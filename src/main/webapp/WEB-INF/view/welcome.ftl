<#include "/view/head.ftl"/>
</head>
<body>
<div class="form-container">
    <form class="form-inline">
    <@p.input name="name" label="姓名" />
    <@p.datepicker name="birth" label="年龄" clear=false/>
    <@p.datepicker name="birth" label="年龄" clear=false />
    <@p.input name="name" label="姓名" />
    <@p.input name="name" label="姓名" />
    <@p.datepicker name="birth" label="年龄" clear=false/>
    <@p.select id="gender" name="gender" placeholder="请填写"  key="name" label="性别"/>
    <@p.buttonWrap align="right">
        <@button id="saveBtn" url="urlurl" class="btn-primary" name="查询" icon="glyphicon-search"/>
        <@button id="cancelBtn" url="urlurl" class="btn-warning" name="导出" icon="glyphicon-export"/>
    <#--<@button id="saveBtn" url="urlurl" class="btn-primary" name="保存" icon="glyphicon-floppy-disk"/>-->
    </@p.buttonWrap>
    </form>
</div>
<div id="toolbar">
<@button id="saveBtn" url="urlurl" class="btn-primary" name="添加" icon="glyphicon-plus"/>
    <@button id="saveBtn" url="urlurl" class="btn-info" name="修改" icon="glyphicon-pencil"/>
    <@button id="saveBtn" url="urlurl" class="btn-danger" name="删除" icon="glyphicon-trash"/>
    <@button id="saveBtn" url="urlurl" class="btn-warning" name="导入" icon="glyphicon-import"/>
</div>
<div id="maingrid"></div>
</body>
<script type="text/javascript">
    $(".date").datetimepicker(
            {
                format: 'yyyy-mm-dd',
                pickerPosition: 'bottom-left',
                minView:3,
                autoclose: true
            }
    );

    $("#maingrid").ligerGrid({
        columns: [
            {display: '顾客', name: 'CustomerID', align: 'left', width: 100, minWidth: 60},
            {display: '公司名', name: 'CompanyName', minWidth: 120},
            {display: '联系名', name: 'ContactName', minWidth: 140},
            {display: '城市', name: 'City'}
        ], data: CustomersData,  pageSize: 300, rownumbers: true
    });

    $(function () {
        $("select").select2({
            placeholder: '请选择......',
            allowClear: true
        });

        $('#saveBtn').on('click', function () {
            validator.form();
        });

        $('#cancelBtn').on('click', function () {
            validator.resetForm();
        });

        var validator = $('#addForm').validate({
            rules: {
                name: {
                    required: true,
                    email: true
                },
                birth: {
                    required: true
                },
                gender: {
                    required: true
                },
                descript: {
                    required: true,
                    minlength: 10
                },
                aaa: {
                    required: true
                },
                bbb: {
                    required: true
                }
            },
            messages: {
                name: {
                    required: '必填',
                    email: '邮箱地址不在不确'
                },
                birth: {
                    required: '必填'
                },
                gender: {
                    required: '必填'
                },
                descript: {
                    required: '必填',
                    minlength: '最小长度为10'
                },
                aaa: {
                    required: '必填'
                },
                bbb: {
                    required: '必填'
                }
            }
        });
    });
</script>
</html>


