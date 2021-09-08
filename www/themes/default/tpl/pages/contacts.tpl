{include file="../common/header.tpl" home = 0}

<main>
    <div class="page-image" style="background-image: url('/themes/default/img/page-image.jpg');"></div>

    <section class="contacts container">
        <h1>Контакты</h1>

        <div class="contacts__text">
            Чем раньше студент задумается о поступлении в медицинский университет – тем большую поддержку мы можем ему оказать.
        </div>

        <div class="row justify-content-between">
            <div class="col-md-6">
                <form class="contacts__form ag-mail-form" method="post" >
                    <input type="hidden" name="form_id" value="1"/>
                    <h2 class="contacts__form-title">пишите нам:</h2>

                    <p class="contacts__subtitle">Отправьте нам заявку для дополнительной информации.</p>

                    <p>
                            <span class="input">
                                <input name="f1" required class="input__control" type="text" placeholder="Имя">
                            </span>
                    </p>

                    <p>
                            <span class="input">
                                {literal}
                                <input name="f2" id="f2" required class="input__control" type="email" placeholder="Email">
                                {/literal}
                            </span>
                    </p>

                    <p>
                            <span class="input">
                                 {literal}
                                <input name="f3" id="f3" required class="input__control" type="number" placeholder="Телефон">
                                 {/literal}
                            </span>
                    </p>

                    <p>
                            <span class="input">
                                <textarea  name="f4" required class="input__control"></textarea>
                            </span>
                    </p>

                    <button class="btn btn--blue btn--middle" type="submit">Отправить</button>
                </form>


            </div>

            <div class="col-md-5">
                <div class="contacts__group">
                    <h2 class="contacts__group-title">Alpha Capital Education <span>(Рег.номер: 123456789)</span></h2>
                    <a class="link" href="/sertifikaty-reprezentacij-shkol">Посмотреть сертификаты репрезентаций школ</a>
                </div>

                <div class="contacts__group">
                    <p class="contacts__wrap-link contacts__wrap-link--email">
                        <a class="link link--bold" href="mailto:+info@alphacapitaleducation.com">info@alphacapitaleducation.com</a>
                    </p>
                    <p class="contacts__wrap-link contacts__wrap-link--phone">
                        <a class="link-tel" href="tel:+447481515012">+447481515012</a>
                    </p>
                </div>

                <div class="contacts__group">
                    <h2 class="contacts__group-title">Мы в социальных сетях:</h2>
                    <p class="contacts__wrap-link contacts__wrap-link--insta">
                        <a class="link link--bold" href="">@alphacapitaleducation</a>
                    </p>
                    <p class="contacts__wrap-link contacts__wrap-link--fb">
                        <a class="link link--bold" href="">alphacapitaleducation</a>
                    </p>
                </div>
            </div>
        </div>
    </section>
</main>
{include file="../common/footer.tpl"}
