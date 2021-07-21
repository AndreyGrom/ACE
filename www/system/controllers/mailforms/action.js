$(document).ready(function(){
    $('.ag-mail-form').submit(function(e){
        e.preventDefault();
        var m_data=$(this).serialize();
        var form = $(this);
        $.ajax({
            type: 'POST',
            url: '/system/controllers/mailforms/action.php',
            data: m_data,
            success: function(result){
                form.html(result);
                var offset = form.offset();
                var totalScroll = offset.top-60;
                $('body,html').animate({
                    scrollTop: totalScroll
                }, 500);
            }
        });
    });
});