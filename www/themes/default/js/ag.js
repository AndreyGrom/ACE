$(".cnt-sel").change(function(){
    var id = $(this).parent().find(".cart_pro_id").val();
    var c = $(this).val();
    var sh_id = $(this).parent().find(".cart_sh_id").val();
    var d = "id=" + id + "&c=" + c + "&sh=" + sh_id + "&pro=1";
    var price_box = $(this).closest(".basket__item").find(".basket__item-price span");
    var price_total = $(this).closest(".basket__group").find(".basket__result strong");
    $.ajax({
        type: "POST",
        url: "/system/controllers/catalog/ajax.php",
        data: d,
        success: function(msg){
            var res = jQuery.parseJSON(msg);
            price_box.text(res.week);
            price_total.text(res.total);

        }
    });
});
$(".week-sel").change(function(){
    var id = $(this).parent().find(".cart_course_id").val();
    var c = $(this).val();
    var sh_id = $(this).parent().find(".cart_sh_id").val();
    var price_one = $(this).parent().find(".price_one").val();
    var d = "id=" + id + "&price_one=" + price_one + "&c=" + c + "&sh=" + sh_id + "&week=1";
    var price_box = $(this).closest(".basket__item").find(".basket__item-price span");
    var price_total = $(this).closest(".basket__group").find(".basket__result strong");
    $.ajax({
        type: "POST",
        url: "/system/controllers/catalog/ajax.php",
        data: d,
        success: function(msg){
            var res = jQuery.parseJSON(msg);
            price_box.text(res.week);
            price_total.text(res.total);

        }
    });
});

$(document).ready(function(){
    var hash = window.location.hash.substr(1);
    if (hash){
        $('#collapse-' + hash).addClass('show');
        $('#heading-' + hash + " h3").attr("aria-expanded", true);
        $('html, body').animate({
            scrollTop: $('#heading-' + hash).offset().top
        }, {
            duration: 100,
            easing: "linear"
        });
    }
});
