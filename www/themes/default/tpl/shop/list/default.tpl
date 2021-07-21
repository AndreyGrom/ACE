{include file="../../common/header.tpl"}
<section>
<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <ol class="breadcrumb">
                <li>Вы находитесь:</li>
                <li><a href="/">Главная</a></li>
                <li><a href="/shop/">Каталог</a></li>
                <li class="active">{$page_title}</li>
            </ol>
        </div>
    </div>
</div>
<div class="container">
<div class="row">
{include file="../../common/sidebar.tpl"}

<div class="col-xs-12 col-sm-12 col-md-8 col-lg-9">
<div class="page-header">
    <h3>
        Презентаионный каталог <small>заголовок презентации</small>
    </h3>
    <p>Сегодня ни одна женщина не может обойтись в своем гардеробе без различных видов нижнего белья. Бюстгальтеры, трусики, чулки, колготки, боди – базовые элементы, которые обеспечивают комфорт и уверенность в себе. Более того, правильно подобранное нижнее белье способно скорректировать линии фигуры и преподнести Ваш наряд в более выгодном свете.</p>
</div>



<div class="input-group poisk-po-kat">
    <div class="input-group-btn search-panel">
        <button type="button" class="btn btn-ser dropdown-toggle" data-toggle="dropdown">
            <span id="search_concept">Все категории</span> <span class="caret"></span>
        </button>
        <ul class="dropdown-menu ul-ser">
            {shop_categories source="shop_categories"}
            {section name=i loop=$shop_categories}
                <li><a href="#rol">{$shop_categories[i].TITLE}</a></li>
            {/section}
            <li class="divider"></li>
            <li><a href="#all">Все категории</a></li>
        </ul>
    </div>
    <input type="hidden" name="search_param" value="all" id="search_param">
    <input type="text" class="form-control poisk-kn" name="x" placeholder="Ключевое слово, напр., трусики белые xxl">
                <span class="input-group-btn">
                    <button class="btn btn-ser" type="button"><span class="glyphicon glyphicon-search"></span> Поиск</button>
                </span>
</div>




<div class="row">
{if $items}
    {section name=i loop=$items}
    <div class="col-xs-12 col-sm-6 col-md-3 col-lg-3">
        <div class="panel panel-default">
            <div class="show show-third">
                {*<img class="img-responsive" src="/upload/images/shop/{$items[i].SKIN}" alt="" />*}
                <img class="img-responsive" src="/{$items[i].SKIN_NEW}" alt="" />
                {if $items[i].PRICE_NEW}
                    <img class="img-responsive sale" src="{$theme_dir}img/actia.png" alt="" />
                {/if}
                <div class="mask">
                    <h4>{if $items[i].QUANTITY > 0}В наличии{else}Доступен под заказ{/if}</h4>
                    <p>ПОДАРОК ПРИ ПОКУПКЕ</p>
                    <!--КНОПКИ ХОВЕРА ДЛЯ КАТАЛОГА-->
                    <p>
                        <a href="/shop/{$items[i].ALIAS}" class="more-blue" data-toggle="tooltip" data-placement="bottom" title="Смотреть"><span class="glyphicon glyphicon-link"></span></a>
                        <a href="#" class="more-green" data-toggle="modal" data-target=".bs-example-modal-sm" data-placement="bottom" title="Быстрый заказ"><span class="glyphicon glyphicon-phone-alt"></span></a>
                        <a href="#" class="more-red" data-toggle="tooltip" data-placement="bottom" title="В корзину"><span class="glyphicon glyphicon-shopping-cart"></span></a>
                    </p>
                </div>
            </div>

            <div class="panel-body text-center"> 
                <h4 class="zag4"><a href="/shop/{$items[i].ALIAS}">{$items[i].TITLE}</a></h4>
                {if $items[i].PRICE_NEW}
                    <p class="text-danger gold"><span>{$items[i].PRICE|number_format} руб.</span> {$items[i].PRICE_NEW|number_format} руб.</p>
                {else}
                    <p class="text-danger">{$items[i].PRICE|number_format} руб.</p>
                {/if}
                <p>
                    <a href="/shop/{$items[i].ALIAS}" class="more-red" {if $items[i].OPTIONS == ''}onclick="AddCart({$items[i].ID},1,''); return false"{/if} title="В корзину"><span class="glyphicon glyphicon-shopping-cart"></span> В корзину</a>
                </p>
            </div>
        </div>
    </div>
    {/section}
{/if}

</div>
<hr>
<div class="row">
    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        {$pagination}
    </div>
</div>
</div>
</div>
</div>
</section>
{include file="../../common/footer.tpl"}