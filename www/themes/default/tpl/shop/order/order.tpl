{include file="../../common/header.tpl"}
<section>
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <ol class="breadcrumb">
                    <li>Вы находитесь:</li>
                    <li><a href="/">Главная</a></li>
                    <li class="active">Оформление заказа</li>
                </ol>
            </div>
        </div>
    </div>
    <form class="form-horizontal" method="post">
        <div class="container" id="cart-container">
            <div class="row" id="step1">
                <div class="row">
                    <div class="col-sm-12">
                        <div class="ota2">
                            <div class="page-header">
                                <h3>
                                    Введите адрес доставки
                                </h3>
                                <p>Сегодня ни одна женщина не может обойтись в своем гардеробе без различных видов нижнего белья. Бюстгальтеры, трусики, чулки, колготки, боди – базовые элементы, которые обеспечивают комфорт и уверенность в себе. Более того, правильно подобранное нижнее белье способно скорректировать линии фигуры и преподнести Ваш наряд в более выгодном свете.</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="ota">
                        <h3>Адрес доставки товара</h3>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">Регион:</label>
                            <div class="col-sm-9">
                                <select class="form-control" id="OrderRegionID" name="OrderRegionID">
                                    {section name=i loop=$regions}
                                        <option data-name="{$regions[i].REGION_NAME}" value="{$regions[i].REGION_ID}">{$regions[i].REGION_NAME}</option>
                                    {/section}
                                </select>
                                <input type="hidden" name="OrderRegion" id="OrderRegion" value=""/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">Город:</label>
                            <div class="col-sm-9">
                                <select class="form-control" id="OrderCityID" name="OrderCityID">
                                    {section name=i loop=$city}
                                        <option data-name="{$city[i].CITY_NAME}" {if $city[i].CITY_ID==$config->SiteCityID}selected {/if} value="{$city[i].CITY_NAME}">{$city[i].CITY_NAME}</option>
                                    {/section}
                                </select>
                                <input type="hidden" name="OrderCity" id="OrderCity" value="{$config->SiteCity}"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">Улица:</label>
                            <div class="col-sm-9">
                                <input type="text" name="OrderStreet" id="OrderStreet" value="" class="form-control"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-3">
                                <div class="form-group">
                                    <label class="col-sm-12 control-label">Дом:</label>
                                    <div class="col-sm-12">
                                        <input type="text" name="OrderStreet" id="OrderStreet" value="" class="form-control"/>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-3">
                                <div class="form-group">
                                    <label class="col-sm-12 control-label">Строение:</label>
                                    <div class="col-sm-12">
                                        <input type="text" name="OrderStreet" id="OrderStreet" value="" class="form-control"/>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-3">
                                <div class="form-group">
                                    <label class="col-sm-12 control-label">Корпус:</label>
                                    <div class="col-sm-12">
                                        <input type="text" name="OrderStreet" id="OrderStreet" value="" class="form-control"/>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-3">
                                <div class="form-group">
                                    <label class="col-sm-12 control-label">Квартира:</label>
                                    <div class="col-sm-12">
                                        <input type="text" name="OrderStreet" id="OrderStreet" value="" class="form-control"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-sm-6">
                    <div class="ota">
                        <h3>Получатель товара</h3>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">Фамилия:</label>
                            <div class="col-sm-9">
                                <input required value="{$user.LAST_NAME}" name="last_name" type="text" class="form-control">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">Имя:</label>
                            <div class="col-sm-9">
                                <input required value="{$user.FIRST_NAME}" name="first_name" type="text" class="form-control">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">Отчество:</label>
                            <div class="col-sm-9">
                                <input required value="{$user.FATHER_NAME}" name="father_name" type="text" class="form-control">
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-12 control-label">Email:</label>
                                    <div class="col-sm-12">
                                        <input required value="{$user.EMAIL}" name="email" type="email" class="form-control">
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-sm-12 control-label">Телефон:</label>
                                    <div class="col-sm-12">
                                        <input required value="{$user.PHONE}" name="phone" type="tel" class="form-control">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="clearfix"></div>
                <br/>
                <button type="button" class="btn btn-primary center-block" id="close-step1">Продолжить</button>
            </div>

            <div class="row" id="step2" style="display: none">
                <div class="row">
                    <div class="col-sm-12">
                        <div class="ota2">
                            <div class="page-header">
                                <h3>
                                    Выберите способ доставки и метод оплаты
                                </h3>
                                <p>Сегодня ни одна женщина не может обойтись в своем гардеробе без различных видов нижнего белья. Бюстгальтеры, трусики, чулки, колготки, боди – базовые элементы, которые обеспечивают комфорт и уверенность в себе. Более того, правильно подобранное нижнее белье способно скорректировать линии фигуры и преподнести Ваш наряд в более выгодном свете.</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="ota">
                        <h3>Способ доставки товара</h3>
                        {section name=i loop=$delivery}
                        <div class="radio">
                            <label>
                                <input name="delivery" type="radio" value=""> {$delivery[i].DELIVERY_NAME} (+{$delivery[i].DELIVERY_PRICE} руб.)
                            </label>
                        </div>
                        {/section}
                        <br/>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="ota">
                        <h3>Способ оплаты</h3>
                        <div class="radio">
                            <label>
                                <input name="delivery" type="radio" value=""> Оплата картой (Скидка 10%)
                            </label>
                        </div>
                        <div class="radio">
                            <label>
                                <input name="delivery" type="radio" value=""> Яндек.Деньги (Скидка 5%)
                            </label>
                        </div>
                        <div class="radio">
                            <label>
                                <input name="delivery" type="radio" value=""> WebMoney (Скидка 5%)
                            </label>
                        </div>
                        <div class="radio">
                            <label>
                                <input name="delivery" type="radio" value=""> Альфа-клик (Скидка 10%)
                            </label>
                        </div>
                        <div class="radio">
                            <label>
                                <input name="delivery" type="radio" value=""> Оплата при получении
                            </label>
                        </div>
                        <br/>
                    </div>
                </div>
                <div class="clearfix"></div>
                <br/>
                <div class="col-sm-6">
                    <button type="button" class="btn btn-primary" id="back-step1">Назад</button>
                </div>
            </div>


        </div>
    </form>
</section>

<script>
    var OrderRegionID = $("#OrderRegionID");
    var OrderRegion = $("#OrderRegion");
    var OrderCityID = $("#OrderCityID");
    var OrderCity = $("#OrderCity");

    function getData(sel){
        var r_id = sel.val();
        var Name;
        sel.find('option').each(function(i){
            var option = $(this);
            if (option.val() == r_id){
                Name = option.attr("data-name");
                return false;
            }
        });
        return Name;
    }

    OrderRegionID.change(function(){
        OrderRegion.val(getData($(this)));
        OrderCityID.html('<option>Загрузка</option>');
        $.ajax({
            type: 'POST',
            url: '{$html_controllers_dir}shop/ajax.php',
            data: 'get_city='+$(this).val(),
            success: function(result){
                OrderCityID.html(result);
                OrderCityID.change();
            }
        });
    });
    OrderCityID.change(function(){
        OrderCity.val(getData($(this)));
    });
    {literal}
    $("#close-step1").click(function(){
/*        $("#step1").animate({display:'none'}, 500, "linear", function(){
            $("#step2").animate({ opacity:1}, 1000, "linear", function(){
            });
            var offset = $("#step2").offset();
            var totalScroll = offset.top-60;
            $('body,html').animate({
                scrollTop: totalScroll
            }, 500);
        });*/
        $("#step1").fadeOut(700, function () {
            $("#step2").fadeIn(700, function () {

            });
            var offset = $("#step2").offset();
            var totalScroll = offset.top-60;
            $('body,html').animate({
                scrollTop: totalScroll
            }, 500);
        });
    });
    $("#back-step1").click(function(){
        $("#step2").fadeOut(700, function () {
            $("#step1").fadeIn(700, function () {

            });
            var offset = $("#step1").offset();
            var totalScroll = offset.top-60;
            $('body,html').animate({
                scrollTop: totalScroll
            }, 500);
        });
    });
    {/literal}
</script>


{include file="../../common/footer.tpl"}