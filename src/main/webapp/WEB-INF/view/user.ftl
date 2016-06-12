<#include "/view/head.ftl"/>
<script type="text/javascript" src="${ctx}/js/user.js"></script>
</head>
<body>
<div class="form-container">
    <form id="searchForm" method="post" class="form-inline">
    <@p.input name="name" label="姓名" />
    <@p.datepicker name="birth" label="出生日期" clear=false/>
    <@p.select id="gender" name="gender" placeholder="请填写"  key="gender" label="性别"/>
    <@p.buttonWrap align="right">
        <@button id="searchBtn" url="urlurl" class="btn-primary" name="查询" icon="glyphicon-search"/>
        <@button id="exportBtn" url="urlurl" class="btn-warning" name="导出" icon="glyphicon-export"/>
    </@p.buttonWrap>
        <div id="errorWap"></div>
    </form>
</div>
<div id="toolbar">
<@button id="addBtn" url="urlurl" class="btn-success" name="添加" icon="glyphicon-plus"/>
    <@button id="editBtn" url="urlurl" class="btn-info" name="修改" icon="glyphicon-pencil"/>
    <@button id="delBtn" url="urlurl" class="btn-danger" name="删除" icon="glyphicon-trash"/>
    <@button id="importtn" url="urlurl" class="btn-warning" name="导入" icon="glyphicon-import"/>
</div>
<div id="maingrid"></div>
</body>
</html>