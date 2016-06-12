/**
 * Created by joe on 2016/6/10.
 */
$(function(){
    $.fn.select2.defaults.set("minimumResultsForSearch", 6);

    $('.date').datetimepicker(
        {
            format: 'yyyy-mm-dd',
            pickerPosition: 'bottom-left',
            minView:2,
            autoclose: true,
            language:'zh-CN'
        }
    );
});
