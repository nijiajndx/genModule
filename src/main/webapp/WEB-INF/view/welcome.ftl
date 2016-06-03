<#import "/WEB-INF/tpl/select.ftl" as select />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN""http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>genModule</title>
    <link type="text/css" rel="stylesheet" href="${ctx}/thirdParty/ligerUI/skins/Aqua/css/ligerui-all.css"/>
    <link type="text/css" rel="stylesheet" href="${ctx}/thirdParty/ligerUI/skins/Gray/css/all.css"/>
    <link type="text/css" rel="stylesheet" href="${ctx}/thirdParty/bootstrap/css/bootstrap.css"/>
    <link type="text/css" rel="stylesheet" href="${ctx}/thirdParty/bootstrap-datetimepicker/css/bootstrap-datetimepicker.css"/>
    <link type="text/css" rel="stylesheet" href="${ctx}/thirdParty/select2/dist/css/select2.css"/>
    <link type="text/css" rel="stylesheet" href="${ctx}/css/common.css"/>

    <script type="text/javascript" src="${cxt}/thirdParty/jquery/jquery-1.11.3.js"></script>
    <script type="text/javascript" src="${cxt}/thirdParty/ligerUI/js/ligerui.all.js"></script>
    <script type="text/javascript" src="${cxt}/thirdParty/jquery/jquery.cookie.js"></script>
    <script type="text/javascript" src="${cxt}/thirdParty/bootstrap/js/bootstrap.js"></script>
    <script type="text/javascript" src="${cxt}/thirdParty/bootstrap-datetimepicker/js/bootstrap-datetimepicker.js"></script>
    <script type="text/javascript" src="${cxt}/thirdParty/select2/dist/js/select2.full.js"></script>
    <script type="text/javascript" src="${cxt}/js/indexdata.js"></script>
    <script type="text/javascript" src="${cxt}/js/customData.js"></script>
    <script type="text/javascript" src="${cxt}/js/fmy.js"></script>
</head>
<body style="padding:0px;background:#EAEEF5;">
    <#--<button type="button" class="btn">（首选项）Primary</button>
    <@button id="a" url="urlurl" name="首选项" />
    <@button id="b" url="urlurl" class="btn-primary" name="首选项" />
    <@button url="urlurl" class="btn-warning" name="首选项" />
    <@button url="auth" name="首选项" />

    <input size="16" type="text" value="2012-06-15 14:45" readonly class="form_datetime">-->
    <@select></@select>
  <#--  <select data-placeholder="Select an option" data-allow-clear="true">
        <option value="1">a</option>
        <option value="2">b</option>
        <option value="3">c</option>
    </select>
    <div id="maingrid"></div>-->
</body>
<script type="text/javascript">
    $(".form_datetime").datetimepicker({format: 'yyyy-mm-dd hh:ii'});

    $("#maingrid").ligerGrid({
        columns: [
            { display: '顾客', name: 'CustomerID', align: 'left', width: 100, minWidth: 60 },
            { display: '公司名', name: 'CompanyName', minWidth: 120 },
            { display: '联系名', name: 'ContactName', minWidth: 140 },
            { display: '城市', name: 'City' }
        ], data:CustomersData,  height:300,pageSize:300 ,rownumbers:true
    });

    $(function(){
        $("select").select2({
            placeholder: "Select an option",
            allowClear: true
        });
    });
</script>
</html>