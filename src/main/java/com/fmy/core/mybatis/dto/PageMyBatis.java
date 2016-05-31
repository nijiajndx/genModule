package com.fmy.core.mybatis.dto;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import com.google.common.base.MoreObjects;
import com.google.common.collect.Lists;

/**
 * <p>
 * PageMyBatis.
 * </p>
 *
 * @author mumu @yfyang
 * @version 1.0 2013-08-03 9:31 PM
 * @since JDK 1.5
 */
public class PageMyBatis<E> extends ArrayList<E> {
    private static final long serialVersionUID = -3472924628671922516L;
    /**
     * data connection.
     */
    private final List<E> content = Lists.newArrayList();
    /**
     * pagination information
     */
    private final PageDto pageable;


    /**
     * Instantiates a new Page my batis.
     *
     * @param content  the content
     * @param pageable the pageable
     */
    public PageMyBatis(Collection<? extends E> content, PageDto pageable) {
        super(content);

        this.content.addAll(content);
        this.pageable = pageable;
    }

    /**
     * Instantiates a new Page my batis.
     *
     * @param content the content
     */
    public PageMyBatis(List<E> content) {
        // fixed total is 0 throw NullPointException
        this(content, new PageDto());
    }

    @Override
    public String toString() {
        return MoreObjects.toStringHelper(this)
                .add("content", content)
                .add("pageable", pageable)
                .toString();
    }

	public List<E> getContent() {
		return content;
	}

	public PageDto getPageable() {
		return pageable;
	}
	
	private  PageInfo<E> pageInfo;
	
	public PageInfo<E> getPageInfo(){
		if(pageInfo == null){
			pageInfo = new PageInfo<E>();
			pageInfo.setRows(getContent());
			pageInfo.setPageable(getPageable());
            pageInfo.setTotal(getPageable().getCount());
		}
		return pageInfo;
	}
	
}
