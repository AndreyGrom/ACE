{include file="../common/header.tpl" home = 0}

<main>
<section class="container payment">

    {if $cart}
<h1>Oплата заказа №{$config->OrderPref}{$order['ID']}</h1>

<div class="row">
    <div class="col-md-8">
        <div class="payment__heading">
            Сумма к оплате:
            {foreach item=i from=$total}
                <br/>
                {$i.cur}   {$i.total}
            {/foreach}
        </div>

        <p>
            Предоплата — часть общей стоимости поездки, которую нужно оплатить, чтобы завершить бронироvние.
            После получения депозита школа фиксирует за вами место на курсе. <br>
            При отказе в визе студенту возвращаются все деньги.
        </p>
    </div>
</div>

<div class="row payment-form">
    <div class="col-md-8">
        <form class="payment-form__form">
            <p class="payment-form__row payment-form__row--border input-border-row">
                            <span class="input">
                                <input class="input__control" type="text" placeholder="Имя">
                            </span>

                            <span class="input">
                                <input class="input__control" type="text" placeholder="Фамилия">
                            </span>
            </p>

            <p class="payment-form__row payment-form__row--border input-border-row">
                            <span class="input">
                                <input class="input__control" type="text" placeholder="Номер карты">
                            </span>

                            <span class="input input--expiry-date">
                                <input class="input__control" type="text" placeholder="Срок действия">
                            </span>

                            <span class="input input--cvv">
                                <input class="input__control" type="text" placeholder="CVV">
                            </span>
            </p>

            <p class="payment-form__row input-border-row">
                            <span class="input">
                                <input class="input__control" type="text" placeholder="Адрес 1">
                            </span>

                            <span class="input">
                                <input class="input__control" type="text" placeholder="Адрес 2">
                            </span>
            </p>

            <p class="payment-form__row input-border-row">
                            <span class="input">
                                <input class="input__control" type="text" placeholder="Город">
                            </span>

                            <span class="input">
                                <input class="input__control" type="text" placeholder="Страна">
                            </span>
            </p>

            <p class="payment-form__footer">
                            <span>
                                Нажимая на эту кнопку, вы соглашаетесь <br>
                                с <a href="" class="link">условиями пользования сайтом</a>
                            </span>

                <button class="btn btn--middle" type="submit">Оплатить</button>
            </p>
        </form>
    </div>

    <div class="col-md-4">
        <div class="basket-mini basket-mini--content">
            {if $cart || $cart2}
                <div class="basket-mini__products" style="max-height: 400px;overflow: auto">
                    {section name=i loop=$cart}
                        <h2 style="font-weight: bold; margin-bottom: 10px;">Школа: <a target="_blank" href="/catalog/{$cart[i]->c_alias}">{$cart[i]->c_name}</a></h2>
                        <h2 class="basket__group-name">Курсы</h2>
                        {section name=j loop=$cart[i]->c_list}
                            <div class="basket-mini__row2">
                                <div class="row">
                                    <div class="col-sm-8">{$cart[i]->c_list[j]->name}</div>
                                    <div class="col-sm-4">{$cart[i]->c_currency} {$cart[i]->c_list[j]->price}</div>
                                </div>
                            </div>
                        {/section}
                        {if $cart[i]->p_list}
                            <br/>
                            <h2 class="basket__group-name">Проживание</h2>
                            {section name=j loop=$cart[i]->p_list}
                                <div class="basket-mini__row2">
                                    <div class="row">
                                        <div class="col-sm-8">{$cart[i]->p_list[j]->name}</div>
                                        <div class="col-sm-4">{$cart[i]->c_currency} {$cart[i]->p_list[j]->price}</div>
                                    </div>
                                </div>
                            {/section}
                        {/if}
                        {if $cart[i]->d_list}
                            <br/>
                            <h2 class="basket__group-name">Дополнительные расходы</h2>
                            {section name=j loop=$cart[i]->d_list}
                                <div class="basket-mini__row2">
                                    <div class="row">
                                        <div class="col-sm-8">{$cart[i]->d_list[j]->name}</div>
                                        <div class="col-sm-4">{$cart[i]->c_currency} {$cart[i]->d_list[j]->price}</div>
                                    </div>
                                </div>
                            {/section}
                        {/if}
                        <br/>
                        <p style="text-align: right"><b>Всего:</b><span>{$cart[i]->c_currency} {$cart[i]->total}</span></p>
                        <hr/>
                    {/section}

                    {if $cart2}
                        <h2 class="basket__group-name">Дополнительные услуги</h2>
                        {section name=j loop=$cart2}
                            <div class="basket-mini__row2">
                                <div class="row">
                                    <div class="col-sm-8">
                                        {$cart2[j]->name}
                                        <p style="color: #808080">{$cart2[j]->desc}</p>
                                    </div>
                                    <div class="col-sm-4">{$cart2[j]->c_zn}
                                        {if $cart2[j]->price_new}
                                            {$cart2[j]->price_new}
                                        {else}
                                            {$cart2[j]->price}
                                        {/if}
                                    </div>
                                </div>
                            </div>
                        {/section}
                    {/if}
                </div>

            {else}
                Корзина пуста!
            {/if}

        </div>
    </div>
</div>

<div class="payment__heading">Вопросы и ответы</div>

<div class="row">
    <div class="col-md-12">
        <div class="accordion js-accordion">
            {section name=i loop=$faq}
            <div class="accordion__item js-accordion-item">

                <button class="accordion__button js-accordion-btn" type="button">{$faq[i].TITLE}</button>
                <div class="accordion__content js-accordion-content">
                    {$faq[i].OTV}
                </div>
            </div>
            {/section}

        </div>
    </div>


</div>
    {else}
        <h1>Такого заказа не существует</h1>
    {/if}
</section>
</main>
{include file="../common/footer.tpl"}
