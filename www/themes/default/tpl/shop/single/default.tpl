{include file="../../common/header.tpl"}
<section>
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <ol class="breadcrumb">
                    <li>Вы находитесь:</li>
                    <li><a href="/">Главная</a></li>
                    <li><a href="/shop/">Каталог</a></li>
                    <li><a href="/shop/{$parents[0].ALIAS}">{$parents[0].TITLE}</a></li>
                    <li class="active">{$page_title}</li>
                </ol>
            </div>
        </div>
    </div>

    <div class="container">
        <div class="row">
            <div class="col-lg-1 col-xs-1 col-sm-1 col-md-1 produkt-tab">
                <ul>
                    {section name=i loop=$images}
                        <li {if $smarty.section.i.index==0}class="active"{/if}>
                            <a data-toggle="tab" href="#img{$smarty.section.i.index}" aria-expanded="false">
                                <img class="img-responsive" src="/upload/images/shop/{$images[i]}" alt="">
                            </a>
                        </li>
                    {/section}
                </ul>
            </div>
            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-11 kartina">
                <div class="tab-content">
                    {section name=i loop=$images}
                    <div id="img{$smarty.section.i.index}" class="tab-pane fade {if $smarty.section.i.index==0}active{/if} in">
                        <div class='zoom'>
                            <div class="product-wrapper">
                                <img class="img-responsive" src="/upload/images/shop/{$images[i]}" alt="">
                            </div>
                        </div>
                    </div>
                    {/section}
                </div>
            </div>
            <script src="{$theme_dir}js/jquery.zoom.min.js"></script>

            <div class="col-lg-7 col-md-7 col-sm-7">
                <div class="product-information">
                    <h2>{$page_title}</h2>
                    <div class="product-heading">
                        <div class="row">
                            <div class="col-md-7 col-sm-7">
                                <ul>
                                    <li><span>Наличие:</span> <a style="text-decoration: none;" href="#" data-toggle="tooltip" data-placement="right" title="{if $item.QUANTITY>0}Товар в наличии на складе. Вы можете оставить заявку и мы доставим товар в течении 14 дней.{/if}">{if $item.QUANTITY>0}В наличии{else}Нет в наличии{/if}</a></li>
                                    <li><span>Номер товара:</span> <a style="text-decoration: none;" href="#" data-toggle="tooltip" data-placement="right" title="Запомните номер товара. При быстром заказе просто назовите номер товара и согласуйте доставку.">{$item.NUMBER}</a></li>
                                    <li><span>Производитель:</span> <a href="/shop/manufacturer/{$item.MANUFACTURER_ID}" data-toggle="tooltip" data-placement="right" title="Кликните чтобы применить фильтр и отобразить все товары этого поизводителя">{$item.MANUFACTURER_NAME}</a></li>
                                    <li><span>Отзывов {$item.COMMENTS_COUNT}.</span> <a href="#">Оставьте отзыв</a></li>
                                </ul>
                            </div>

                            <div class="col-md-5 col-sm-5">
                                <div class="product-price">
                                    <h4>{if $item.PRICE_NEW}<span>{$item.PRICE|number_format}</span> {$item.PRICE_NEW|number_format}{else}{$item.PRICE|number_format}{/if} руб.</h4>
                                    <p><a href="#" onclick="supportAPI.openSupport(); return false;">Онлайн чат с продавцом</a> <span class="glyphicon glyphicon-comment"></span></p>
                                    {if $item.PRICE_NEW}<p class="price-vigod">Ваша выгода - {$item.PRICE-$item.PRICE_NEW} руб.</p>{/if}
                                    <p class="price-ost">Остаток на складе: {$item.QUANTITY}</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="product-feature">
                        <h3>Краткое описание:</h3>
                        {$item.SHORT_CONTENT}

                        <div class="row text-center">
                            <div class="col-sm-4"><span class="glyphicon glyphicon-transfer"></span> <a href="#" data-toggle="tooltip" data-placement="top" title="Узнайте о новых поступлениях этого и других товаров в наш магазин. Кликните чтобы подписаться.">Узнать о наличии</a></div>
                            <div class="col-sm-4"><span class="glyphicon glyphicon-ruble"></span> <a href="#" data-toggle="tooltip" data-placement="top" title="Вы можете узнать о снижении цены на этот и другие товары. Жмите чтобы узнать о скидках.">Сообщить о скидке</a></div>
                            <div class="col-sm-4"><span class="glyphicon glyphicon-gift"></span> <a href="#" data-toggle="modal" data-target=".bs-example-modal-lg" data-placement="top" title="При покупке любого товара вы получаете подарок. Кликните, чтобы узнать.">При покупке подарок</a></div>
                        </div>
                    </div>

                    <h3>
                        <span class="typed hidden-xs"></span>

                        <span class="hidden-sm hidden-lg hidden-md">Доставка почтой по всей России |</span>
                    </h3>
                    <!-- Форма чтобы положить в корзину-->
                    <div class="row">
                        <form action="" method="post">

                            {section name=i loop=$options}
                            <div class="col-md-4 col-sm-4 col-xs-12" id="options">
                                <h6>{$options[i].name}</h6>
                                <select data-option="{$options[i].id}" class="form-control">
                                    {section name=j loop=$options[i].params}
                                        <option value="{$options[i].params[j].ID}">{$options[i].params[j].PARAMETER}</option>
                                    {/section}
                                </select>
                            </div>
                            {/section}


{*                            <div class="col-md-4 col-sm-4 col-xs-12">
                                <h6>Кол-во</h6>
                                <select id="product-count" class="form-control">
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                    <option value="5">5</option>
                                    <option value="6">6</option>
                                    <option value="7">7</option>
                                    <option value="8">8</option>
                                    <option value="9">9</option>
                                    <option value="10">10</option>
                                </select>
                            </div>*}
                    </div>
                    <div class="row produkt-subm">
                        <div class="col-md-4 col-sm-4 col-xs-12">
                            <p class="text-center">
                                <a class="sub-t" href="#" data-toggle="modal" data-target=".bs-example-modal-lg2">
                                    <span class="glyphicon hidden-sm glyphicon-th-list"></span>
                                    Таблица размеров
                                </a></p>
                            <p class="text-center vopros hidden-xs"><span data-toggle="tooltip" data-placement="bottom" title="У каждого производителя своя таблица размеров. Кликните по кнопке чтобы открыть таблицу размеров.">Как выбрать размер <span class="glyphicon glyphicon-question-sign"></span></span></p>

                        </div>
                        <div class="col-md-4 col-sm-4 col-xs-12">
                            <p class="text-center">
                                <a class="sub-b order-click" href="#" data-toggle="modal" data-target=".bs-example-modal-sm">
                                    <span class="hidden-sm glyphicon glyphicon-phone-alt"></span>
                                    Купить в 1 клик
                                </a> </p>
                            <p class="text-center vopros hidden-xs"><span data-toggle="tooltip" data-placement="bottom" title="Быстрый заказ без оформления товара, просто сообщите менеджеру номер товара и согласуйте доставку или самовывоз. Кликните по кнопке, чтобы сделать быстрый заказ.">Быстрый заказ <span class="glyphicon glyphicon-question-sign"></span></span></p>

                        </div>
                        <div class="col-md-4 col-sm-4 col-xs-12">
                            <p class="text-center">
                                <a class="sub-o" href="#" id="add-cart-button">
                                    <span class="hidden-sm glyphicon glyphicon-shopping-cart"></span>
                                    В корзину
                                </a>
                            </p>
                            <p class="text-center vopros hidden-xs">
                                <span data-toggle="tooltip" data-placement="bottom" title="Положите товар в корзину для оформления заказа через сайт, далее перейдите в корзину. Жмите кнопку чтобы положить товар в корзину.">Заказ с оформлением  <span class="glyphicon glyphicon-question-sign"></span></span>
                            </p>

                        </div>
                        </form>
                    </div>
                    {if $tags}
                    <div class="product-brand">
                        <div class="tags">
                            <span class="glyphicon glyphicon-tags"></span> <span>Метки товара:</span>
                            {section name=i loop=$tags}
                                <a href="/shop/tag/{$tags[i]}">{$tags[i]}</a>{if !$smarty.section.i.last}, {/if}
                            {/section}
                        </div>
                    </div>
                    {/if}
                </div>
            </div>

        </div>
    </div>

</section>

<div class="container">
    <div class="row product-op">
        <div class="col-md-6">
            <!-- Nav tabs -->
            <div class="card">
                <ul class="nav nav-tabs">
                    <li class="active"><a href="#h" data-toggle="tab" aria-expanded="true"><span class="glyphicon glyphicon-th-list"></span> Описание товара</a></li>
                    <li><a href="#p" data-toggle="tab" aria-expanded="false"><span class="glyphicon glyphicon-flag"></span> Доставка</a></li>
                    <li><a href="#o" data-toggle="tab" aria-expanded="false"><span class="glyphicon glyphicon-credit-card"></span> Оплата</a></li>
                </ul>


                <div class="tab-content">
                    <div class="tab-pane active" id="h">
                        <!-- Основной контент -->
                        {$item.CONTENT}
                        <hr>
                        <!-- При заказе у нас -->
                        <h4>Почему стоит купить у нас?</h4>
                        <div class="row prizyv-kd-trigger">
                            <div class="col-md-6">
                                <ul>
                                    <li><span class="glyphicon glyphicon-piggy-bank"></span> <span class="kd-trigger-span" data-toggle="tooltip" data-placement="top" title="Без риска, оплата при получении товара">Без предоплаты</span></li>
                                    <li><span class="glyphicon glyphicon-gift"></span> <span class="kd-trigger-span" data-toggle="tooltip" data-placement="top" title="Каждая покупка сопровождается уникальным подарком">Подарки при покупке</span></li>
                                    <li><span class="glyphicon glyphicon-saved"></span> <span class="kd-trigger-span" data-toggle="tooltip" data-placement="top" title="Около 3.000 товаров на любой вкус">Всегда в наличии</span></li>
                                </ul>
                            </div>
                            <div class="col-md-6">
                                <ul>
                                    <li><span class="glyphicon glyphicon-transfer"></span> <span class="kd-trigger-span" data-toggle="tooltip" data-placement="top" title="В течении 60 дней со дня покупки">Обмен товара</span></li>
                                    <li><span class="glyphicon glyphicon-sunglasses"></span> <span class="kd-trigger-span" data-toggle="tooltip" data-placement="top" title="Мы гарантируем анонимность покупки">Анонимность покупки</span></li>
                                    <li><span class="glyphicon glyphicon-compressed"></span> <span class="kd-trigger-span" data-toggle="tooltip" data-placement="top" title="При заказе от 3500 руб., в любую точку России">Бесплатная доставка</span></li>
                                </ul>
                            </div>
                        </div>
                        <div class="row prizyv-kd-trigger">
                            <div class="col-md-12">
                                <p class="text-center">
                                    Заказать по телефону 8 903 555 77 11<br><a href="#" data-toggle="tooltip" data-placement="bottom" title="Быстрый заказ без оформления товара, просто сообщите менеджеру номер товара и согласуйте доставку">Позвоните мне! Клик!</a>
                                </p>
                            </div>
                        </div>
                    </div>

                    <div class="tab-pane" id="p">
                        <h3>Доставка товара по России</h3>
                        <p>Классические плавки-стринг средне-низкой посадки с узким бочком, обработаны эластичным зигзагом. Классические плавки-стринг средне-низкой посадки с узким бочком, обработаны эластичным зигзагом.</p>
                        <h3>Доставка товара в Нижнем Новгороде</h3>
                        <p>Классические плавки-стринг средне-низкой посадки с узким бочком, обработаны эластичным зигзагом. Классические плавки-стринг средне-низкой посадки с узким бочком, обработаны эластичным зигзагом.</p>
                    </div>
                    <div class="tab-pane" id="o">
                        <h3>Оплата товара</h3>
                        <p>Классические плавки-стринг средне-низкой посадки с узким бочком, обработаны эластичным зигзагом. Классические плавки-стринг средне-низкой посадки с узким бочком, обработаны эластичным зигзагом.</p>
                        <p>Классические плавки-стринг средне-низкой посадки с узким бочком, обработаны эластичным зигзагом. Классические плавки-стринг средне-низкой посадки с узким бочком, обработаны эластичным зигзагом.</p>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <!-- Nav tabs -->
            <div class="card">
                <ul class="nav nav-tabs">
                    <li class="active"><a href="#s" data-toggle="tab" aria-expanded="false"><span class="glyphicon glyphicon-check"></span> Гарантии</a></li>
                    {if $item.VIDEO}
                    <li><a href="#v" data-toggle="tab" aria-expanded="false"><span class="glyphicon glyphicon-facetime-video"></span> Видео товара</a></li>
                    {/if}
                    <li><a href="#m" data-toggle="tab" aria-expanded="true"><span class="glyphicon glyphicon-user"></span> Отзывы покупателей</a></li>
                </ul>

                <!-- Tab panes -->
                <div class="tab-content">
                    <div class="tab-pane product-scrol" id="m">
                        <h3>Анонимные отзывы <div class="pull-right">[<a class="small" href="#" data-target=".comments-form-modal" data-toggle="modal">Добавить отзыв</a>]</div></h3>
                        {if $comments}{$comments}{else}<p>Отзывов нет</p>{/if}
                    </div>
                    <div class="tab-pane active" id="s">
                        <h4>1. Гарантии и покупка без риска</h4>
                        <p>Отправляем заказы по России без предоплаты. Товар не подошел – меняем без проблем.</p>

                        <h4>2. Товар без подделок</h4>
                        <p>Работаем только с годами проверенными брендами и поставщиками и никогда не пойдем на	компромисс с совестью.</p>

                        <h4>3. Обоснованная цена</h4>
                        <p>Мы не стремимся сделать самую низкую в России цену. Наша задача предложить товар высокого качества по минимально возможной и согласованной с производителем цене.</p>

                        <h4>4. Акции и распродажи</h4>
                        <p>Иногда мы освобождаем свои полки и делаем распродажи до 50%. Ловите момент и вы также сможете неприлично выгодно купить красивые вещи известных брендов. </p>

                        <h4>5. Дарим подарки и гарантируем удовольствие от покупок</h4>
                        <p>Каждый клиент к заказу получает подарок. И если вдруг наше обслуживание или товар Вас разочаруют – звоните прямо директору: +7 (905) 444-33-22, Татьяна</p>
                    </div>
                    {if $item.VIDEO}
                    <div class="tab-pane" id="v">
                        <h3>Заголовок видео</h3>
                        <div class="embed-responsive embed-responsive-16by9">
                            <iframe width="640" height="360" src="https://www.youtube.com/embed/PbcAA-6U7b8" frameborder="0" allowfullscreen></iframe>
                        </div>
                    </div>
                    {/if}
                </div>
            </div>
        </div>
    </div>
</div>
{shop_links source="links" links=$item.LINKS image_width="194" image_height="290"}
{if $links}
    <div class="container sl-produkt">
        <div class="row">
            <div class="col-md-12">
                <div class="row">
                    <div class="col-md-6"><h3>Сопутствующие товары</h3></div>
                    <div class="col-md-6">
                        <div class="customNavigation">
                            <a class="btn prev">Предыдущий</a>
                            <a class="btn next">Следующий</a>
                        </div>
                    </div>
                </div>
                <div id="owl-produkt" class="owl-carousel">
                    {section name=i loop=$links}
                        <div class="item">
                            <div class="panel panel-default lazyOwl" data-src="your img path">
                                <div class="show show-third">
                                    <img class="img-responsive product-img" src="/{$links[i].SKIN_NEW}" alt="" />
                                    {if $links[i].PRICE_NEW}
                                        <img class="img-responsive sale" src="{$theme_dir}img/actia.png" alt="" />
                                    {/if}
                                    <div class="mask">
                                        <h4 class="zag4">{if $links[i].QUANTITY > 0}В наличии{else}Нет в наличии{/if}</h4>
                                        <p>Подарок при покупке</p>
                                        <!--КНОПКИ ХОВЕРА ДЛЯ КАТАЛОГА-->
                                        <p>
                                            <a href="/shop/{$links[i].ALIAS}" class="more-blue" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Смотреть"><span class="glyphicon glyphicon-link"></span></a>
                                            <a href="#" class="more-green" data-toggle="modal" data-target=".bs-example-modal-sm" data-placement="bottom" title="" data-original-title="Быстрый заказ"><span class="glyphicon glyphicon-phone-alt"></span></a>
                                            <a href="#" class="more-red" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="В корзину"><span class="glyphicon glyphicon-shopping-cart"></span></a>
                                        </p>
                                    </div>
                                </div>
                                <div class="panel-body text-center">
                                    <h4 class="zag4"><a href="/shop/{$links[i].ALIAS}">{$links[i].TITLE}</a></h4>
                                    {if $links[i].PRICE_NEW}
                                        <p class="text-danger gold"><span>{$links[i].PRICE|number_format} руб.</span> {$links[i].PRICE_NEW|number_format} руб.</p>
                                    {else}
                                        <p class="text-danger">{$links[i].PRICE|number_format} руб.</p>
                                    {/if}
                                    <p><a href="#" class="more-red" onclick="AddCart({$links[i].ID},1,''); return false" title="В корзину"><span class="glyphicon glyphicon-shopping-cart"></span> В корзину</a></p>
                                </div>
                            </div>
                        </div>
                    {/section}
                </div>
            </div>
        </div>
    </div>
{/if}
{if $other_items}
<div class="container sl-produkt">
    <div class="row">
        <div class="col-md-12">
            <div class="row">
                <div class="col-md-6"><h3>Еще товары в этой категории</h3></div>
                <div class="col-md-6">
                    <div class="customNavigation">
                        <a class="btn prev">Предыдущий</a>
                        <a class="btn next">Следующий</a>
                    </div>
                </div>
            </div>
            <div id="owl-produkt" class="owl-carousel">
                {section name=i loop=$other_items}
                <div class="item">
                    <div class="panel panel-default lazyOwl" data-src="your img path">
                        <div class="show show-third">
                            <img class="img-responsive product-img" src="/{$other_items[i].SKIN_NEW}" alt="" />
                            {if $other_items[i].PRICE_NEW}
                                <img class="img-responsive sale" src="{$theme_dir}img/actia.png" alt="" />
                            {/if}
                            <div class="mask">
                                <h4 class="zag4">{if $other_items[i].QUANTITY > 0}В наличии{else}Нет в наличии{/if}</h4>
                                <p>Подарок при покупке</p>
                                <!--КНОПКИ ХОВЕРА ДЛЯ КАТАЛОГА-->
                                <p>
                                    <a href="/shop/{$other_items[i].ALIAS}" class="more-blue" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Смотреть"><span class="glyphicon glyphicon-link"></span></a>
                                    <a href="#" class="more-green" data-toggle="modal" data-target=".bs-example-modal-sm" data-placement="bottom" title="" data-original-title="Быстрый заказ"><span class="glyphicon glyphicon-phone-alt"></span></a>
                                    <a href="#" class="more-red" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="В корзину"><span class="glyphicon glyphicon-shopping-cart"></span></a>
                                </p>
                            </div>
                        </div>
                        <div class="panel-body text-center">
                            <h4 class="zag4"><a href="/shop/{$other_items[i].ALIAS}">{$other_items[i].TITLE}</a></h4>
                            {if $other_items[i].PRICE_NEW}
                                <p class="text-danger gold"><span>{$other_items[i].PRICE|number_format} руб.</span> {$other_items[i].PRICE_NEW|number_format} руб.</p>
                            {else}
                                <p class="text-danger">{$other_items[i].PRICE|number_format} руб.</p>
                            {/if}
                            <p><a href="#" class="more-red" onclick="AddCart({$other_items[i].ID},1,''); return false" title="В корзину"><span class="glyphicon glyphicon-shopping-cart"></span> В корзину</a></p>
                        </div>
                    </div>
                </div>
                {/section}
            </div>
        </div>
    </div>
</div>
{/if}
{if $comments_form}
<div class="modal fade comments-form-modal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span class="glyphicon glyphicon-remove-circle"></span></button>
                <h4 class="modal-title" id="myModalLabel">Добавление отзыва о товаре</h4>
            </div>

            <div class="modal-body">
                {$comments_form}
                <div class="clearfix"></div>
            </div>
            <div class="modal-footer">

            </div>

        </div>
    </div>
</div>
{/if}
<!-- размеры -->
<div class="modal fade bs-example-modal-lg2" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header razmer-f">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span class="glyphicon glyphicon-remove-circle"></span></button>
                <h4 class="modal-title text-center" id="myModalLabel">Заголовок таблицы с размерами</h4>
            </div>
            <div class="modal-body razmer-b">
                <h4>Заголовок таблицы с размерами (другой ниже таблица)</h4>
                <!-- таблица -->
                {$item.MANUFACTURER_DESC}
            </div>
            <div class="modal-footer razmer-f">
                <p class="text-center">Заказать по телефону - {$site_phone}</p>
            </div>
        </div>
    </div>
</div>
<script>
    $(document).ready(function(){
        $('.zoom').zoom();
    });

    $("#add-cart-button").click(function(e){
        e.preventDefault();
        var id = {$item.ID};
        var count = $("#product-count").val();

        var options =[];
        $("#options select").each(function(i,e){
            var option = new Object();
            option.id = $(e).attr("data-option");
            option.param = $(e).val();
            options.push(option);
        });
        AddCart(id,1,JSON.stringify(options));
    });
    $(".order-click").click(function(e){
        e.preventDefault();
        var name = '{$item.TITLE}';
        var price = '{if $item.PRICE_NEW}{$item.PRICE_NEW|number_format}{else}{$item.PRICE|number_format}{/if}';
        var number = '{$item.NUMBER}';
        $(".priziv").html('Вы заказываете "'+name+'" на сумму '+price+' руб с учетом скидки');
    });
</script>
{include file="../../common/footer.tpl"}