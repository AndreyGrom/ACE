$(document).ready(function(){
    $('.ag-mail-form').submit(function(e){
        var email = $(this).find("#f2").val();
        var pattern = /^([a-z0-9_\.-])+@[a-z0-9-]+\.([a-z]{2,4}\.)?[a-z]{2,4}$/i;
        if(pattern.test(email)) {

        } else {
            alert("Некорректный email");
            return false;
        }
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
 /*   $("#f3").mask("+9 (999) 99-99-999");*/
});


