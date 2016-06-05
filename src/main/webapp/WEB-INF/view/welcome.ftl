<#include "head.ftl"/>
</head>
<body style="padding:0px;background:#EAEEF5;">
<div>
<@button id="a" url="urlurl" name="首选项" class="btn-default"/>
<@button id="b" url="urlurl" class="btn-primary" name="首选项" />
<@button url="urlurl" class="btn-warning" name="首选项" />
<@button url="auth" name="首选项" />

    <input size="16" type="text" value="2012-06-15 14:45" readonly class="form_datetime">
<@p.select id="id" name="name" class="hi" placeholder="请填写"  default="2"key="name"></@p.select>
    <select data-placeholder="Select an option" data-allow-clear="true">
        <option value="1">a</option>
        <option value="2">b</option>
        <option value="3">c</option>
    </select>
    <div id="maingrid"></div>
</div>
</body>
<script type="text/javascript">
    $(".form_datetime").datetimepicker({format: 'yyyy-mm-dd hh:ii'});

    $("#maingrid").ligerGrid({
        columns: [
            {display: '顾客', name: 'CustomerID', align: 'left', width: 100, minWidth: 60},
            {display: '公司名', name: 'CompanyName', minWidth: 120},
            {display: '联系名', name: 'ContactName', minWidth: 140},
            {display: '城市', name: 'City'}
        ], data: CustomersData, height: 300, pageSize: 300, rownumbers: true
    });

    $(function () {
        $("select").select2({
            placeholder: '请选择......',
            allowClear: true
        });
    });
</script>
</html>