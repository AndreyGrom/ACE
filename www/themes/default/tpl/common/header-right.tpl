<div class="header__right">

    <div class="header__cabinet">
        <a href="/register/profile">
            <svg role="img" width="20" height="20">
                <use xlink:href="#ico-user"></use>
            </svg> <span>Кабинет</span></a>

        </div>

    <div class="header__basket">
        <a href="/catalog/cart">
            <svg role="img" width="16" height="20">
                <use xlink:href="#ico-basket"></use>
            </svg> <span>Корзина</span>
       </a>



        <div class="basket-mini">
            <p class="basket-mini__heading">Корзина</p>

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

                <p class="basket-mini__footer">
                    <a class="link" href="/catalog/cart">просмотреть</a>
                    <a class="btn btn--mini" href="/catalog/pay">оплатить</a>
                </p>
            {else}
                Корзина пуста!
            {/if}
        </div>
    </div>
</div>