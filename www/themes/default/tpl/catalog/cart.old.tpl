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
            </div>
        </div>
    </div>
    {/section}
    {section name=i loop=$p_list}
    <div class="basket__group">
        <h2 class="basket__group-name">Проживание</h2>

        <div class="basket__item">
            <img class="basket__item-image" src="/upload/images/catalog/{$p_list[i].PHOTO1}" alt="" width="159" height="118">

            <div class="basket__desc">
                <h3>
                    {$p_list[i].VID}
                </h3>

                <p>

                </p>
            </div>

            <div class="basket__controls">


                <div class="basket__item-price">
                    £{$p_list2[i]->price}
                </div>

                <a href="/catalog/cart/act=" class="basket__item-delete" type="button" aria-label="Удалить товар"></a>
            </div>
        </div>
    </div>
    {/section}

    <div class="basket__group">

        <h2 class="basket__group-name">Дополнительные расходы</h2>
        {section name=i loop=$d_list}
        <div class="basket__item">
            <p>{$d_list[i]->name}</p>

            <div class="basket__controls">
                <div class="basket__item-price">
                    £{$d_list[i]->price}
                </div>

                <button class="basket__item-delete" type="button" aria-label="Удалить товар"></button>
            </div>
        </div>
        {/section}


    </div>



    <!--<div class="basket__group">
        <div class="basket__item">
            <p>Туристическая виза (Великобритания)</p>

            <div class="basket__controls">
                <div class="basket__item-price">
                    £100
                </div>

                <button class="basket__item-delete" type="button" aria-label="Удалить товар"></button>
            </div>
        </div>
    </div>-->

    <div class="basket__group-result">
        <!--<div class="basket__result-desc">
            Phasellus ac nulla vel neque varius porttitor ac et dui. Etiam ultrices cursus suscipit.
            Quisque et pretium ante. Quisque laoreet ultrices felis, sed vulputate nibh ultricies.
            Donec quis felis a urna feugiat dignissim vel nec justo.
        </div>-->

        <div class="basket__result">
            <p><b>Всего:</b><span>£{$total}</span></p>
            <!--<p>Депозит к оплате*: <span>£200</span></p>-->
        </div>
    </div>
</div>

<div class="basket__form">

    <form class="cart-form" method="post">
     {*   <p class="d-flex justify-content-end d1">
            <a href="/catalog/cart/clear" class="btn btn--blue" type="submit">Отменить покупки</a>
        </p>*}


        <p class="d-flex justify-content-end d2">
            <button name="cart-form" class="btn btn--middle" type="submit">Перейти к оплате</button>
        </p>
        <div style="clear: both"></div>
</div>
    {else}
        <h2>Корзина пуста</h2>
    {/if}
</section>
</main>
<script>
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
</script>
{include file="../common/footer.tpl"}
