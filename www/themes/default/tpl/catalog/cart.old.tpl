{include file="../common/header.tpl" home = 0}

<main>
<section class="container basket">
<h1>Корзина заказов</h1>

{if $c_list}
<div class="basket__list">
    {section name=i loop=$c_list}
    <div class="basket__group">

        <h2 class="basket__group-name">Курс</h2>

        <div class="basket__item">
            <img class="basket__item-image" src="/upload/images/catalog/{$c_list[i].PHOTO1}" alt="" width="159" height="118">

            <div class="basket__desc">
                <h3>
                    {$c_list[i].TITLE}
                </h3>

                <p>
                    {$c_list[i].SH_TITLE}
                </p>

                <p>
                    {$c_list[i].CITY_NAME}, {$c_list[i].COUNTRY_NAME}
                </p>
            </div>

            <div class="basket__controls">


                <div class="basket__item-price">
                     {*{if $c_list[i].PRICE_NEW}
                         £{$c_list[i].PRICE_NEW}
                      {else}
                         £{$c_list[i].PRICE}
                      {/if}*}
                    {$c_list[i].C_ZN}{$c_list[i].price}<br/>

                </div>

                <button data-id="{$c_list[i].SH_ID}" class="basket__item-delete" type="button" aria-label="Удалить товар"></button>