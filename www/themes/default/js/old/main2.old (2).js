var course = {};
var cart = {};

cart.list = [];
course.id = $("#sh_id").val();
course.c_list = [];
course.p_list = [];
course.d_list = [];
var inner = $("#inner");

function Curr(){
    var rss;
    rss = $("#curr").text() + ' ';
    return rss;
}


$( document ).ready(function() {
    $(".price_n").change(function(){
        var p = $(this).parent().find(".price_s").val() * $(this).val();
        var p_n = $(this).parent().find(".price_s_n").val() * $(this).val();
        var btn = $(this).parent().parent().find('button');

        if (p_n > 0){
            $(this).parent().parent().find(".course-price s").html(" &nbsp;" + Curr() + p);
            $(this).parent().parent().find(".course-price ss").html(Curr() + p_n);
        } else{
            $(this).parent().parent().find(".course-price ss").html(Curr() + p);
        }

        btn.attr('data-p', p);
        btn.attr('data-p_n', p_n);
        btn.attr('data-count-n', $(this).val());
    });

    $('.select-price').change(function(){
        var str = $(this).parent().find('.j_price').text();
        var str2 = '';
        var arr = JSON.parse(str);
        var cl = $(this).val();
        var i, j, price, ot2, ddo2;
        var ot = [];
        var ddo = [];
        for (i = 0; i < arr.length; ++i) {
            if (arr[i][0] == cl){
                for (j = 0; j < arr[i][1].length; ++j){
                    str += '<tr><td>' + arr[i][1][j][0] +'</td><td>' + arr[i][1][j][1] +'</td><td>' + Curr() + arr[i][1][j][2] +'</td></tr>';
                    ot.push(arr[i][1][j][0]);
                    ddo.push(arr[i][1][j][1]);
                }
            }
        }
        $(this).parent().parent().find(".sel-table tbody").html(str);
        str = '<option value="0">Выбрать</option>';
        for (i = Math.min.apply(null, ot); i < Math.max.apply(null, ddo) + 1; ++i) {
            str += '<option value="' + i + '">' + i + '</option>';
        }
        $(this).parent().parent().find(".select-price-2").html(str);
    });

    $('.select-price-2').change(function(){
        var th2 = $(this).val();
        if (th2 == 0) {return false}
        var str = $(this).parent().parent().find('.j_price').text();
        var th = $(this).parent().parent().find('.select-price').val();

        var arr = JSON.parse(str);
        var i;
        var btn = $(this).parent().parent().find('button');

        for (i = 0; i < arr.length; ++i) {

            if (arr[i][0] == th){
              // console.log(arr[i][1]);
                for (j = 0; j < arr[i][1].length; ++j){
                    //console.log(arr[i][1][j][0]);
                    //console.log(arr[i][1][j][1]);
                    //console.log(th2);
                    //if (th2 >= arr[i][1][j][0] && th2 <=  arr[i][1][j][1]){
                    //alert(arr[i][1][j][0] + ' | ' + arr[i][1][j][1] + ' | ' + th2);
                    if (Number(arr[i][1][j][0]) <= Number(th2) && Number(arr[i][1][j][1]) >= Number(th2)){

                        btn.attr('data-p', arr[i][1][j][2] * th2);
                        btn.attr('data-count-n', th2);

                        $(this).parent().parent().find(".curr-price").text(Curr() + arr[i][1][j][2] * th2);
                        //alert(arr[i][1][j][2] * th2);
                    }
                }
            }
        }
    });

    $(".btn-select-course").click(function(){
        if ($(this).attr('data-p') == '') return false;
        var n = -1;
        var id = $(this).attr('data-course-id');
        if (course.c_list.length > 0){
            for (i = 0; i < course.c_list.length; i++){
                if (course.c_list[i].id == id){
                    n = i;
                }
            }
        }

        if (n > -1){
           // alert(n);
            course.c_list.splice(n);
        }
        //if (n == false){
            var list = {};
            list.id = $(this).attr('data-course-id');
            list.name = $(this).attr('data-course-name');
            list.price = $(this).attr('data-p');
            list.price_new = $(this).attr('data-p_n');

            list.count_n = $(this).attr('data-count-n');
            course.c_list.push(list);
        console.log(course.c_list);
        //}

        Write_box();
    });

    $(".dop_price input").click(function(){
        Write_box();
    });

    $(".select-pro").change(function(){
        var btn = $(this).parent().parent().parent().find('button');
        btn.attr('data-name', $(this).find('option:selected').attr('data-name'));
        btn.attr('data-price', $(this).find('option:selected').attr('data-price'));
    });

    $(".btn-select-pro").click(function(){
        var n = -1;
        var id = $(this).attr('data-id');
        if (course.p_list.length > 0){
            for (i = 0; i < course.p_list.length; i++){
                if (course.p_list[i].id == id){
                    n = i
                }
            }
        }
        if (n > -1){
            // alert(n);
            course.p_list.splice(n);
        }
        //if (n == false){
            var list = {};
            list.id = $(this).attr('data-id');
            list.name = $(this).attr('data-name');
            list.price = $(this).attr('data-price');
            course.p_list.push(list);
        //}

        Write_box();
    });

    function Write_box(){
        course.total = 0;
        var tr = '';
        var table = $(".table-costs");
        table.find("tr").remove();
        table.show();
        if (course.c_list.length > 0){
            for (i = 0; i < course.c_list.length; i++){
                var n = 0;
                if (course.c_list[i].price_new > 0){
                    n = course.c_list[i].price_new;
                    course.total += Number(course.c_list[i].price_new);
                } else {
                    n = course.c_list[i].price;
                    course.total += Number(course.c_list[i].price);
                }
                if (course.c_list[i].price_new == 0){
                    course.c_list[i].price_new = course.c_list[i].price;
                }
                tr += '<tr><th colspan="2">' + course.c_list[i].name +':</th></tr>';
                tr += '<tr><td>' + String(course.c_list[i].count_n) + ' ' + declOfNum(course.c_list[i].count_n, ['неделя', ' недели', 'недель']) +'</td><td>' + Curr() + n +'</td> </tr>';
                //tr += '<tr class="costs-discount"><td>Скидка</td><td>' + Curr() + (course.c_list[i].price - course.c_list[i].price_new) +'</td> </tr>';
            }

            if (course.p_list.length > 0){
                tr += '<tr><th colspan="2">Проживание:</th></tr>';
                for (i = 0; i < course.p_list.length; i++){
                    tr += '<tr><td>' + course.p_list[i].name +'</td><td>' + Curr() + course.p_list[i].price +'</td> </tr>';
                    course.total += Number(course.p_list[i].price);
                }

            }
            course.d_list = [];
            if ($(".dop_price input:checkbox:checked")){
                tr += '<tr><th colspan="2">Дополнительно:</th></tr>';

                $('.dop_price').each(function (index, element) {
                    if ($(element).find('input').prop('checked')){
                        var d_list = {};
                        tr +=  '<tr><td>' + $(element).find('.dop-title').text() + '</td><td>' + Curr() + $(element).data('price') + '</td></tr>';
                        course.total += Number($(element).data('price'));
                        d_list.id = $(element).data('id');
                        d_list.name = $(element).data('name');
                        d_list.price = $(element).data('price');
                        course.d_list.push(d_list);
                    }
                });
            }
            tr += '<tr class="total"><td>Всего:</td><td>' + Curr() + course.total + '</td></tr>';

        }
        table.append(tr);
    }

    $('.add-to-cart').click(function(){
        if (course.c_list.length == 0){
            alert('Ничего не выбрано');
            return false;
        }
        var n = false;
        if (($.cookie('cart'))){
            cart = $.parseJSON($.cookie('cart'));
        }
        if (cart.list.length > 0){
            for (i = 0; i < cart.list.length; i++){
                if (cart.list[i].id == course.id){
                    cart.list[i] = course;
                    n = true;
                }
            }
        }
        if (n ==  false){
            cart.list.push(course);
            //alert('Добавлено в корзину');
        } else{
            //alert('Корзина обновлена');
        }

        //$("#Modal1").modal('show');

        $.cookie('cart', JSON.stringify(cart), { path: '/', expires: 180});

        /*cart = JSON.parse($.cookie('cart'));
        console.log(cart);*/
        document.location.href = '/catalog/cart/';
    });


    $('.basket__item-delete').click(function(){
        if (!confirm('Вы уверены?')){
            return false;
        }
        var id = $(this).data('id');

        var n = false;
        if ($.cookie('cart')){
            cart = $.parseJSON($.cookie('cart'));
            if (cart.list.length > 0){
                var list = [];
                for (var i = 0; i < cart.list.length; i++){
                    if (cart.list[i].id != id){
                        list.push(course) ;
                    }
                }
                cart.list = list;
            }
            $.cookie('cart', JSON.stringify(cart), { path: '/', expires: 180});
            document.location.href = '/catalog/cart/';
        }

    });



    function declOfNum(number, titles) {
        cases = [2, 0, 1, 1, 1, 2];
        return titles[ (number%100>4 && number%100<20)? 2 : cases[(number%10<5)?number%10:5] ];
    }

	$('#accomodationList').collapse({
	  toggle: false
	});

	$(function () {
	  $('[data-toggle="tooltip"]').tooltip()
	});



    $(".mr-auto a").click(function () {
        var elementClick = $(this).attr("href");
        var destination = $(elementClick).offset().top;
        $('html, body').animate({ scrollTop: destination }, 600);
        return false;
    });

});


    var a = document.querySelector('#inner'), b = null;
    window.addEventListener('scroll', Ascroll, false);
    document.body.addEventListener('scroll', Ascroll, false);
    function Ascroll() {
        if (b == null) {
            var Sa = getComputedStyle(a, ''), s = '';
            for (var i = 0; i < Sa.length; i++) {
                if (Sa[i].indexOf('overflow') == 0 || Sa[i].indexOf('padding') == 0 || Sa[i].indexOf('border') == 0 || Sa[i].indexOf('outline') == 0 || Sa[i].indexOf('box-shadow') == 0 || Sa[i].indexOf('background') == 0) {
                    s += Sa[i] + ': ' +Sa.getPropertyValue(Sa[i]) + '; '
                }
            }
            b = document.createElement('div');
            b.style.cssText = s + ' box-sizing: border-box; width: ' + a.offsetWidth + 'px;';
            a.insertBefore(b, a.firstChild);
            var l = a.childNodes.length;
            for (var i = 1; i < l; i++) {
                b.appendChild(a.childNodes[1]);
            }
            a.style.height = b.getBoundingClientRect().height + 'px';
            a.style.padding = '0';
            a.style.border = '0';
        }
        if (a.getBoundingClientRect().top <= 0) {
            b.className = 'sticky';
        } else {
            b.className = '';
        }
        window.addEventListener('resize', function() {
            a.children[0].style.width = getComputedStyle(a, '').width
        }, false);
    }
