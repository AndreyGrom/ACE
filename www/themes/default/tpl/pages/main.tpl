{include file="../common/header.tpl" home = 1}





<main>
    <section class="advantages container">
        <h2 class="visually-hidden">Преимущества</h2>

        <div class="row">
            <div class="advantages__item col-md-3 col-6">
                <img src="/themes/default/img/svg/advantages-1.svg" alt="">
                <p>Проверенные программы</p>
            </div>

            <div class="advantages__item col-md-3 col-6">
                <img src="/themes/default/img/svg/advantages-2.svg" alt="">
                <p>Цены дешевле, <br> чем напрямую у&nbsp;школы</p>
            </div>

            <div class="advantages__item col-md-3 col-6">
                <img src="/themes/default/img/svg/advantages-3.svg" alt="">
                <p>24/7 поддержка</p>
            </div>

            <div class="advantages__item col-md-3 col-6">
                <img src="/themes/default/img/svg/advantages-4.svg" alt="">
                <p>Офис в&nbsp;Лондоне - студенты со&nbsp;всего мира</p>
            </div>
        </div>
    </section>

    <section class="how-to-use container">
        <div class="row justify-content-between">
            <div class="col-md-5">
                <h2>Как пользоваться платформой</h2>

                <p>
                    Идейные соображения высшего порядка, а также начало повседневной работы по формированию позиции
                    обеспечивает широкому кругу (специалистов) участие в формировании модели развития.
                </p>

                <p>
                    Равным образом постоянное информационно пропагандистское обеспечение нашей деятельности позволяет
                    оценить значение систем массового участия. Таким образом консультация с широким активом позволяет
                    оценить значение систем массового участия.
                </p>
            </div>

            <div class="col-md-6 video-hldr">
                <div>
                    {$config->vid}
                </div>
            </div>
        </div>
    </section>

    <section class="special-offers">
        <div class="container">
            <h2>Специальные предложения</h2>
            <p class="special-offers__subtitle">С другой стороны дальнейшее развитие различных форм.</p>

            <div class="row slider slick">
                {section name=i loop=$spec}
                <div class="col-md-6">
                    <div class="special-offers__item">
                        <a href="/catalog/{$spec[i].ALIAS}"><img src="/upload/images/catalog/{$spec[i].PHOTO1}" alt="">

                            <p class="special-offers__label">{$spec[i].TEXT}</p>

                            <div class="special-offers__desc">
                                <div class="special-offers__rating">
                                    <ul class="rating">
                                        {section name=j loop=5 start = 0}
                                        {*{$smarty.section.j.iteration}*}
                                        <li
                                            class="{if $items[i].RATING >= $smarty.section.j.iteration}isset{else}empty{/if}">
                                        </li>
                                        {/section}

                                    </ul>
                                </div>

                                <p class="special-offers__address">{$spec[i].CITY_NAME}, {$spec[i].COUNTRY_NAME}</p>

                                <div class="special-offers__footer">
                                    <p class="special-offers__name">{$spec[i].TITLE}</p>
                                    <p class="special-offers__price">от
                                        <span>{$spec[i].C_CURRENCY}{$spec[i].MIN_PRICE}</span> в неделю</p>
                                </div>
                            </div>
                        </a>
                    </div>
                </div>
                {/section}
            </div>
            <script>
                $('.slick').slick({
                    slidesToShow: 2,
                    slidesToScroll: 1,
                    autoplay: true,
                    autoplaySpeed: 4000,
                    arrows: true,
                    responsive: [

                        {
                            breakpoint: 767,
                            settings: {
                                slidesToShow: 1,
                                slidesToScroll: 1,
                                arrows: false
                            }
                        }
                    ]
                });
            </script>


        </div>
    </section>

    <section class="popular-courses container">
        <h2>Популярные курсы</h2>

        <p class="popular-courses__subtitle">С другой стороны дальнейшее развитие различных форм.</p>

        <div class="row slider slick3">
            {section name=i loop=$popular}
                <div class="col-md-4">
                    <div class="popular-courses__item">
                        <a href="/catalog/{$popular[i].ALIAS}/#{$popular[i].POPULAR_ID}"><img src="/upload/images/catalog/{$popular[i].PHOTO1}" alt="">
                            <div class="popular-courses__desc">
                                <p class="popular-courses__address">{$popular[i].CITY_NAME}, {$popular[i].COUNTRY_NAME}</p>
                                <p class="popular-courses__name">{$popular[i].TITLE}</p>
                                <p class="popular-courses__price">от <span>{$popular[i].C_CURRENCY}{$popular[i].MIN_PRICE}</span> в неделю</p>
                            </div>
                        </a>
                    </div>
                </div>
            {/section}
        </div>
        <script>
            $('.slick3').slick({
                slidesToShow: {if count($popular) == 1}1{elseif count($popular) == 2}2{else}3{/if},
                slidesToScroll: 1,
                autoplay: false,
                autoplaySpeed: 4000,
                arrows: true,
                responsive: [

                    {
                        breakpoint: 767,
                        settings: {
                            slidesToShow: 1,
                            slidesToScroll: 1,
                            arrows: false
                        }
                    }
                ]
            });
        </script>
    </section>

    {if $rews}
    <section class="reviews container">
        <h2>Что он нас говорят</h2>

        <div class="reviews__slider slider slick2">
            {section name=i loop=$rews}
            <div class="reviews__slide">
                <div class="img" style="background-image: url('/upload/images/services/{$rews[i].PHOTO}')"></div>

                <div class="reviews__slide-desc">
                    <h3>{$rews[i].TITLE}</h3>

                    <div class="reviews__slide-subtitle">{$rews[i].RFROM}</div>

                    <p class="">
                        {$rews[i].REW}
                    </p>
                </div>
            </div>
            {/section}
        </div>
    </section>

    {/if}


    <script>
        $('.slick2').slick({
            slidesToShow: 1,
            slidesToScroll: 1,
            dots: true,
            arrows: true,
            adaptiveHeight: true,
            responsive: [{
                breakpoint: 767,
                settings: {
                    arrows: false,
                }
            }]
        });
    </script>


</main>

{include file="../common/footer.tpl"}