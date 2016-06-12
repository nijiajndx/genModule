$(function(){
    /*初始化组件*/
    $('#gender').select2({
        placeholder:'请输入',
        allowClear: true
    });

    grid = $('#maingrid').ligerGrid({
        title:'用户列表',
        url:'/user/find',
        checkbox:true,
        columns:[
            {display: '姓名', name: 'name', minWidth: 120},
            {display: '出生日期', name: 'birth', minWidth: 120},
            {display: '性别', name: 'gender', minWidth: 120},
            {display: '学历', name: 'qualification', minWidth: 120},
            {display: '兴趣爱好', name: 'interest', minWidth: 120},
            {display: '简介', name: 'introduction',width:500}
        ],
        parms:function(e){
            return false;
        },
        pageSize: 10
    });

    /*绑定按钮事件*/
    $('#searchBtn').on('click',function(){

    });

    $('#exportBtn').on('click',function(){

    });

    $('#addBtn').on('click',function(){

    });

    $('#editBtn').on('click',function(){

    });

    $('#delBtn').on('click',function(){

    });

    $('#importBtn').on('click',function(){

    });
});