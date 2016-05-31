package com.fmy.core.mybatis;

import com.fmy.core.mybatis.dialect.DBMS;
import com.fmy.core.mybatis.dialect.Dialect;
import com.fmy.core.mybatis.dialect.DialectClient;
import com.fmy.core.mybatis.dto.PageDto;
import com.fmy.core.mybatis.dto.Paginationable;
import com.fmy.core.mybatis.helpers.CountHelper;
import com.fmy.core.mybatis.helpers.StringHelper;
import com.google.common.base.Preconditions;
import org.apache.ibatis.executor.Executor;
import org.apache.ibatis.logging.Log;
import org.apache.ibatis.logging.LogFactory;
import org.apache.ibatis.mapping.BoundSql;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.mapping.ParameterMapping;
import org.apache.ibatis.mapping.SqlSource;
import org.apache.ibatis.plugin.*;
import org.apache.ibatis.session.ResultHandler;
import org.apache.ibatis.session.RowBounds;
import org.springframework.dao.InvalidDataAccessResourceUsageException;
import org.springframework.util.ReflectionUtils;

import java.io.Serializable;
import java.lang.reflect.InvocationTargetException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Properties;


@Intercepts({@Signature(
        type = Executor.class,
        method = "query",
        args = {MappedStatement.class, Object.class, RowBounds.class, ResultHandler.class})})
public class PaginationInterceptor implements Interceptor, Serializable {
    /**
     * serial Version
     */
    private static final long serialVersionUID = -6075937069117597841L;
    private static final ThreadLocal<Integer> PAGINATION_TOTAL = new ThreadLocal<Integer>();
    private static final ThreadLocal<Boolean> NEEDPAGE = new ThreadLocal<Boolean>();
    private static final ThreadLocal<PageDto> PAGE_REQUEST = new ThreadLocal<PageDto>();
    /**
     * logging
     */
    private static final Log log = LogFactory.getLog(PaginationInterceptor.class);
    /**
     * mapped statement parameter index.
     */
    private static final int MAPPED_STATEMENT_INDEX = 0;
    /**
     * sql id , in the mapper xml file.
     */
    private static String _sql_regex = "[*]";
    /**
     * DataBase dialect.
     */
    protected Dialect _dialect;

    /**
     * Gets pagination total.
     *
     * @return the pagination total
     */
    public static int getPaginationTotal() {
        if (PAGINATION_TOTAL.get() == null) {
            return 0;
        }
        return PAGINATION_TOTAL.get();
    }

    public static boolean isPage() {
        if (NEEDPAGE.get() == null || NEEDPAGE.get()) {
            return true;
        }
        return NEEDPAGE.get();
    }

    /**
     * Gets page request.
     *
     * @return the page request
     */
    public static PageDto getPageRequest() {
        return PAGE_REQUEST.get();
    }

    /**
     * clear total context.
     */
    public static void clean() {
        PAGE_REQUEST.remove();
        PAGINATION_TOTAL.remove();
        NEEDPAGE.remove();
    }

    /**
     * Set the paging information,to RowBuounds.
     *
     * @param rowBounds rowBounds.
     * @return rowBounds.
     */
    private static RowBounds offset_paging(RowBounds rowBounds, PageDto pageRequest) {
        // rowBuounds has offset.
        if (rowBounds.getOffset() == RowBounds.NO_ROW_OFFSET) {
            if (pageRequest != null) {
                return new RowBounds((pageRequest.getPageNo() - 1) * pageRequest.getPageSize(), pageRequest.getPageNo() * pageRequest.getPageSize());
            }
        }
        return rowBounds;
    }


    /**
     * Copy from bound sql.
     *
     * @param ms       the ms
     * @param boundSql the bound sql
     * @param sql      the sql
     * @return the bound sql
     */
    public static BoundSql copyFromBoundSql(MappedStatement ms, BoundSql boundSql,
                                            String sql) {
        BoundSql newBoundSql = new BoundSql(ms.getConfiguration(), sql, boundSql.getParameterMappings(), boundSql.getParameterObject());
        for (ParameterMapping mapping : boundSql.getParameterMappings()) {
            String prop = mapping.getProperty();
            if (boundSql.hasAdditionalParameter(prop)) {
                newBoundSql.setAdditionalParameter(prop, boundSql.getAdditionalParameter(prop));
            }
        }
        return newBoundSql;
    }

    //see: MapperBuilderAssistant
    private static MappedStatement copyFromMappedStatement(MappedStatement ms, SqlSource newSqlSource) {
        MappedStatement.Builder builder = new MappedStatement.Builder(ms.getConfiguration(), ms.getId(), newSqlSource, ms.getSqlCommandType());

        builder.resource(ms.getResource());
        builder.fetchSize(ms.getFetchSize());
        builder.statementType(ms.getStatementType());
        builder.keyGenerator(ms.getKeyGenerator());
        String[] keyProperties = ms.getKeyProperties();
        builder.keyProperty(keyProperties == null ? null : keyProperties[0]);

        //setStatementTimeout()
        builder.timeout(ms.getTimeout());

        //setStatementResultMap()
        builder.parameterMap(ms.getParameterMap());

        //setStatementResultMap()
        builder.resultMaps(ms.getResultMaps());
        builder.resultSetType(ms.getResultSetType());

        //setStatementCache()
        builder.cache(ms.getCache());
        builder.flushCacheRequired(ms.isFlushCacheRequired());
        builder.useCache(ms.isUseCache());

        return builder.build();
    }

    /**
     * perform paging intercetion.
     *
     * @param queryArgs Executor.query params.
     * @throws IllegalAccessException
     * @throws IllegalArgumentException
     * @throws InvocationTargetException
     */
    private void processIntercept(final Object[] queryArgs) throws IllegalArgumentException, IllegalAccessException, InvocationTargetException {
        final MappedStatement ms = (MappedStatement) queryArgs[MAPPED_STATEMENT_INDEX];
        final Object parameter = queryArgs[1];

        //the need for paging intercept.
        boolean interceptor = ms.getId().matches(_sql_regex);
        if (!interceptor) {
            NEEDPAGE.set(false);
            return;
        }
        ;
        //obtain paging information.

        PageDto pageRequest = getPageDtoFromParam(parameter);
        if (pageRequest == null) throw new IllegalAccessException(" page dto is null ");
        PAGE_REQUEST.set(pageRequest);

        final RowBounds oldRow = (RowBounds) queryArgs[2];
        final RowBounds rowBounds = offset_paging(oldRow, pageRequest);
        int offset = rowBounds.getOffset();
        int limit = rowBounds.getLimit();

        if (_dialect.supportsLimit() && (offset != RowBounds.NO_ROW_OFFSET || limit != RowBounds.NO_ROW_LIMIT)) {
            final BoundSql boundSql = ms.getBoundSql(parameter);
            String sql = boundSql.getSql().trim();

            Connection connection = null;
            try {
                //get connection
                connection = ms.getConfiguration().getEnvironment().getDataSource().getConnection();
                int count = CountHelper.getCount(sql, connection, ms, parameter, boundSql, _dialect);
                pageRequest.setCount(count);
                PAGINATION_TOTAL.set(count);
            } catch (SQLException e) {
                log.error("The total number of access to the database failure.", e);
                throw new InvalidDataAccessResourceUsageException(" The total number of access to the database failure. ");
            } finally {
                try {
                    connection.close();
                } catch (SQLException e) {
                    log.error("close connection fails");
                    e.printStackTrace();
                }
            }
            String new_sql = sql;
            if (_dialect.supportsLimit()) {
                new_sql = _dialect.getLimitString(new_sql, offset, limit);
                offset = RowBounds.NO_ROW_OFFSET;
            } else {
                new_sql = _dialect.getLimitString(new_sql, 0, limit);
            }
            if (log.isDebugEnabled()) {
                log.debug("pagination sql is :[" + new_sql + "]");
            }
            limit = RowBounds.NO_ROW_LIMIT;

            queryArgs[2] = new RowBounds(offset, limit);

            BoundSql newBoundSql = copyFromBoundSql(ms, boundSql, new_sql);

            MappedStatement newMs = copyFromMappedStatement(ms, new BoundSqlSqlSource(newBoundSql));
            queryArgs[MAPPED_STATEMENT_INDEX] = newMs;
        }
    }

    private PageDto getPageDtoFromParam(final Object parameter)
            throws IllegalAccessException, InvocationTargetException {
        PageDto pageRequest = null;
        if (parameter instanceof Paginationable) {
            pageRequest = (PageDto) ReflectionUtils.findMethod(parameter.getClass(), "getPageDto").invoke(parameter, new Object[]{});
        } else {
            pageRequest = PagingParametersFinder.instance.findCriteria(parameter);
        }
        return pageRequest;

    }

    public Object intercept(Invocation invocation) throws Throwable {
        processIntercept(invocation.getArgs());
        return invocation.proceed();
    }

    public Object plugin(Object o) {

        if (Executor.class.isAssignableFrom(o.getClass())) {
            return Plugin.wrap(new PaginationExecutor((Executor) o), this);
        }
        return Plugin.wrap(o, this);

    }

    /**
     * 设置属性，支持自定义方言类和制定数据库的方式
     * <p>
     * <p/>
     * <ode>dbms</ode> 数据库类型，插件支持的数据库
     * <code>sqlRegex</code> 需要拦截的SQL ID
     * </p>
     *
     * @param p 属性
     */
    public void setProperties(Properties p) {
        DBMS dbms;
        String dialect = p.getProperty("dbms");
        Preconditions.checkArgument(!StringHelper.isEmpty(dialect), "dialect property is not found!");
        dbms = DBMS.valueOf(dialect.toUpperCase());
        _dialect = DialectClient.getDbmsDialect(dbms);
        String sql_regex = p.getProperty("sqlRegex");
        if (!StringHelper.isEmpty(sql_regex)) {
            _sql_regex = sql_regex;
        }
        clean();
    }

    public static class BoundSqlSqlSource implements SqlSource {
        BoundSql boundSql;

        public BoundSqlSqlSource(BoundSql boundSql) {
            this.boundSql = boundSql;
        }

        public BoundSql getBoundSql(Object parameterObject) {
            return boundSql;
        }
    }
}
