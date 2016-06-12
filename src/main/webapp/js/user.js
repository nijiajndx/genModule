$(function () {
    /*初始化组件*/
    $('#gender').select2({
        placeholder: '请输入',
        allowClear: true
    });

    var grid = $('#maingrid').ligerGrid({
        title: '用户列表',
        url: '/user/find',
        checkbox: true,
        errorLabelContainer: $('#searchForm #errorWap'),
        columns: [
            {display: '姓名', name: 'name', minWidth: 120},
            {display: '出生日期', name: 'birth', minWidth: 120},
            {display: '性别', name: 'gender', minWidth: 120},
            {display: '学历', name: 'qualification', minWidth: 120},
            {display: '兴趣爱好', name: 'interest', minWidth: 120},
            {display: '简介', name: 'introduction', width: 500}
        ],
        parms: function (e) {
            //先判断查询条件是否满足条件
            if(searchFormValidator && !searchFormValidator.form()){
                return false;
            }
            return $fmy.serializeObject('#searchForm');
        },
        pageSize: 10
    });

    /*绑定按钮事件*/
    $('#searchBtn').on('click', function () {
        grid.load();
    });

    $('#exportBtn').on('click', function () {

    });

    $('#addBtn').on('click', function () {

    });

    $('#editBtn').on('click', function () {

    });

    $('#delBtn').on('click', function () {

    });

    $('#importBtn').on('click', function () {

    });

    //定义表单校验
    var searchFormValidator = $('#searchForm').validate({
        rules: {
            name: {required: true},
            birth: {required: true,date:'YYYY-MM-DD'}
        },
        messages: {
            name: {
                required: '姓名不可为空'
            },
            birth: {
                required: '出生日期不可为空',
                date:'日期格式不正确'
            }
        }
    });
});