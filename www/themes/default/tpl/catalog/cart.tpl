{include file="../common/header.tpl" home = 0}

<main>
<section class="container basket">
<h1>Корзина заказов</h1>

{if $cart || $cart2}
   {* {$cart|debug_print_var}*}
<div class="basket__list">

    {section name=i loop=$cart}
    <div class="basket__group">
        <h2 class="school-name">Школа: <a target="_blank" href="/catalog/{$cart[i]->c_alias}">{$cart[i]->c_name}</a></h2>
        <h2 class="basket__group-name">Курсы</h2>
        {section name=j loop=$cart[i]->c_list}


            <div class="basket__item big-item">
                <img class="basket__item-image" src="/upload/images/catalog/{$cart[i]->c_photo}" alt="" width="159" height="118">
                <div class="basket__desc">
                    <h3>
                        {$cart[i]->c_list[j]->name}
                    </h3>
                    <p>
                        {$cart[i]->c_name}
                    </p>
                    <p>
                        <h3>Категория/Часы: {$cart[i]->c_list[j]->count} </h3>
                        {*<h3>{if $cart[i]->c_list[j]->count_numeric}Часы{else}Категория{/if}: {$cart[i]->c_list[j]->count} </h3>*}
                    </p>

                </div>

                <div class="basket__controls">
                    <div class="basket__select">

                        <form method="post">
                            <input type="hidden" class="cart_course_id" name="cart_course_id" value="{$cart[i]->c_list[j]->id}"/>
                            <input type="hidden" class="price_one" name="price_one" value="{$cart[i]->c_list[j]->price_one}"/>
                            <input type="hidden" class="cart_sh_id" value="{$cart[i]->id}"/>
                            <select name="cart_course" class="select js-select week-sel">
                                {section name=k loop=$cart[i]->c_list[j]->do+1 start=$cart[i]->c_list[j]->ot}
                                    <option data-price-one="{$cart[i]->c_list[j]->price_one}" value="{$smarty.section.k.iteration}" {if $cart[i]->c_list[j]->count_n == $smarty.section.k.iteration}selected {/if}>Недель: {$smarty.section.k.iteration}</option>
                                {/section}
                            </select>
                        </form>

                    </div>
                    <div class="basket__item-price">
                       {$cart[i]->c_currency}  <span>{$cart[i]->c_list[j]->price}<br/></span>
                    </div>
                    <a href="/catalog/cart/act=delete-cart/act2=c/id={$cart[i]->c_list[j]->id}" class="basket__item-delete"></a>
                </div>
            </div>
        {/section}

        <div>
            {if $cart[i]->p_list}
                <h2 class="basket__group-name">Проживание</h2>
            {section name=j loop=$cart[i]->p_list}

                <div class="basket__item big-item">
                    <img class="basket__item-image" src="/upload/images/catalog/{$cart[i]->p_list[j]->photo}" alt="" width="159" height="118">
                    <div class="basket__desc">
                        <h3>
                            {$cart[i]->p_list[j]->vid}
                        </h3>
                        <p>
                            {$cart[i]->p_list[j]->name}
                        </p>
                        <p>


                    </div>
                    <div class="basket__controls">
                        <div class="basket__select">

                            <form method="post">
                                <input type="hidden" class="cart_pro_id" name="cart_pro_id" value="{$cart[i]->p_list[j]->id}"/>
                                <input type="hidden" class="cart_sh_id" value="{$cart[i]->id}""/>
                                <select name="cart_pro" class="select js-select cnt-sel">
                                    {section name=k loop=30}
                                        <option value="{$smarty.section.k.iteration}" {if $cart[i]->p_list[j]->count == $smarty.section.k.iteration}selected {/if}>Недель: {$smarty.section.k.iteration}</option>
                                    {/section}
                                </select>
                            </form>

                        </div>

                        <div class="basket__item-price">
                            {$cart[i]->c_currency} <span>{$cart[i]->p_list[j]->price * $cart[i]->p_list[j]->count}</span>
                        </div>
                        <a href="/catalog/cart/act=delete-cart/act2=p/id={$cart[i]->p_list[j]->id}" class="basket__item-delete"></a>
                    </div>
                </div>
            {/section}
            {/if}
            {if $cart[i]->d_list}
            <h2 class="basket__group-name">Дополнительные расходы</h2>
            {section name=j loop=$cart[i]->d_list}
                <div class="basket__item">
                    <p>{$cart[i]->d_list[j]->name}</p>

                    <div class="basket__controls">
                        <div class="basket__item-price">
                            {$cart[i]->c_currency} {$cart[i]->d_list[j]->price}
                        </div>

                        <a href="/catalog/cart/act=delete-cart/act2=d/id={$cart[i]->d_list[j]->id}" class="basket__item-delete"></a>
                    </div>
                </div>
            {/section}

            {/if}
        </div>
        <div class="basket__group-result">
            <div class="basket__result">
                <p><b>Всего:</b><span><b>{$cart[i]->c_currency}</b> <strong>{$cart[i]->total}</strong></span></p>
                <!--<p>Депозит к оплате*: <span>£200</span></p>-->
            </div>
        </div>
    </div>


    {/section}
</div>


    {if $cart2}

        <div class="basket__list">
            <div class="basket__group">
                <h2 class="basket__group-name">Дополнительные услуги</h2>
                {section name=i loop=$cart2}
                    <div class="basket__item">
                        <div class="basket__desc">
                            <h3>
                                {$cart2[i]->name}
                            </h3>
                            <p>{$cart2[i]->desc}</p>
                        </div>

                        <div class="basket__controls">
                            <div class="basket__item-price">
                                {$cart2[i]->c_zn} {$cart2[i]->price_new}<br/>
                            </div>
                            <a href="/catalog/cart/act=delete-cart2/id={$cart2[i]->id}" class="basket__item-delete"></a>
                        </div>
                    </div>
                {/section}


        </div>
    {/if}

    <div class="basket__form">
        {if !$login}
    <form action="/register" class="cart-form" method="post">
     {*   <p class="d-flex justify-content-end d1">
            <a href="/catalog/cart/clear" class="btn btn--blue" type="submit">Отменить покупки</a>
        </p>*}
        <div class="row">
            <div class="col-md-12">
                <p class="basket__form_text">Заполните краткие сведения о себе, чтобы школа могла зарезервировать для вас место.</p>
                <p class="basket__form_text">На e-mail будут высланы документы, подтверждающие ваше бронирование.</p>
                <p>&nbsp;</p>
            </div>
        </div>
        <div class="row no-gutters">
            <div class="col-md-4 g-5">
                <input name="first_name" required type="text" class="input__control" placeholder="Имя">
            </div>
            <div class="col-md-4 g-5">
                <input name="phone" required type="tel" class="input__control" placeholder="Телефон">
            </div>
            <div class="col-md-4">
                <input name="email" required type="email" class="input__control" placeholder="Email">
            </div>

        </div>
        <div class="row">
            <div class="col-md-8"></div>
            <div class="col-md-4">
                <button name="register2" class="btn btn--middle" type="submit">Перейти к оплате</button>
                <div style="clear: both"></div>


            </div>
        </div>
 
     </form>
        {else}
        <form class="cart-form" method="post">
        <p class="d-flex justify-content-end d2">
            <button name="cart-form" class="btn btn--middle" type="submit">Перейти к оплате</button>
        </p>
        </form>
        {/if}
</div>
    {else}
        <h2 class="h-empty-basket">Корзина пуста</h2>
    {/if}



</section>
</main>
{include file="../common/footer.tpl"}
