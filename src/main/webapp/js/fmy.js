/**
 * Created by njoe on 2016/6/1.
 */
(function ($) {
    $fmy = function () {
    };
    $.extend($fmy,
        {
            'alert': function (opts) {
                var title_part =(opts.title==undefined||opts.title=='')?'':'<p><strong>'+opts.title+'</strong></p>',
                    id_part = (opts.id==undefined || opts.id=='')?'':'id="'+opts.id+'"';

                var html = '<div ' + id_part + ' class="alert alert-' + opts.type + ' alert-dismissable"' +
                    ' style="position: fixed;right:20px;top:20px;z-index:891020">' +
                    '    <button type="button" class="close" data-dismiss="alert"' +
                    'aria-hidden="true">' +
                    '    &times;</button>' +
                    title_part+
                    opts.content +
                    '</div>';
                $(html).appendTo('body').alert();
            },
            'closeAlert': function (id) {
                $('#' + id).alert('close');
            }
        }
    );
})(jQuery);