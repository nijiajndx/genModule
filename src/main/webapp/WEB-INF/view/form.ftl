<#include "/view/head.ftl"/>
</head>
<body>
<div class="form-container">

    <form class="form-horizontal" id="addForm">
    <@p.input name="name" label="姓名"/>
    <@p.datepicker name="birth" label="年龄"/>
    <@p.select id="id" name="gender" placeholder="请填写"  key="name" label="性别"></@p.select>
    <@p.textarea name="descript" default="hello"/>
    <@p.input name="name" label="password" type="password"/>
    <@p.checkbox name="aaa" key="name" data=[{"id":"1","text":"zs"},{"id":"2","text":"ls"},{"id":"3","text":"ww"},{"id":"4","text":"zl"}] default=["2","3"]/>
    <@p.radio name="bbb" key="name" data=[{"id":"1","text":"zs"},{"id":"2","text":"ls"},{"id":"3","text":"ww"},{"id":"4","text":"zl"}] default="2"/>
    <@p.buttonWrap>
        <@button id="saveBtn" url="urlurl" class="btn-primary" name="保存" icon="glyphicon-floppy-disk"/>
        <@button id="cancelBtn" url="urlurl" class="btn-danger" name="取消" icon="glyphicon-floppy-remove"/>
    </@p.buttonWrap>
    </form>
    <form class="form-inline">
        <div class="form-group">
            <label for="exampleInputName2">Name</label>
            <input type="text" class="form-control" id="exampleInputName2" name="name" placeholder="Jane Doe">
        </div>
        <div class="form-group">
            <label for="exampleInputEmail2">12312312312</label>
            <input type="email" class="form-control" id="exampleInputEmail2" name="gender"
                   placeholder="jane.doe@example.com">
        </div>
        <div class="form-group">
            <label for="exampleInputName2">Name</label>
            <input type="text" class="form-control" id="exampleInputName2" name="birth" placeholder="Jane Doe">
        </div>
        <div class="form-group">
            <label for="exampleInputEmail2">Email</label>
            <input type="email" class="form-control" id="exampleInputEmail2" name="descpt"
                   placeholder="jane.doe@example.com">
        </div>
        <div class="form-group">
            <label for="exampleInputName2">Nam1e</label>
            <input type="text" class="form-control" id="exampleInputName2" placeholder="Jane Doe">
        </div>
        <div class="form-group">
            <label for="exampleInputEmail2">Em32132ail</label>
            <input type="email" class="form-control" id="exampleInputEmail2" placeholder="jane.doe@example.com">
        </div>
        <button type="submit" class="btn btn-default">Send invitation</button>
    </form>
</div>
<div id="maingrid"></div>
</body>
<style type="text/css">
    .form-container {
        width: 800px;
        margin: 0 auto;
    }
</style>

<script type="text/javascript">
    $(".date").datetimepicker(
            {
                format: 'yyyy-mm-dd hh:ii',
                pickerPosition: 'bottom-left',
                autoclose: true
            }
    );

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

        $('#saveBtn').on('click',function(){
            validator.form();
        });

        $('#cancelBtn').on('click',function(){
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
                }
            }
        });
    });
</script>
</html>


