/**
 * Created by njoe on 2016/6/3.
 */
(function( $ ){

    var methods = {
        init : function( options ) {
            // 这
        },
        show : function( ) {
            // 很
        },
        hide : function( ) {
            // 好
        },
        update : function( content ) {
            // !!!
        }
    };

    $.fn.fselect = function( method ) {

        // Method calling logic
        if ( methods[method] ) {
            return methods[ method ].apply( this, Array.prototype.slice.call( arguments, 1 ));
        } else if ( typeof method === 'object' || ! method ) {
            return methods.init.apply( this, arguments );
        } else {
            $.error( 'Method ' +  method + ' does not exist on jQuery.tooltip' );
        }

    };

})( jQuery );
