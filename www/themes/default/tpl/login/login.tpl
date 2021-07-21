{include file="../common/header.tpl"}
<main>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">
                <div class="register-page">

                    <div class="row justify-content-center">
                        <div class="col-lg-10">
                            <h2>Вход в личный кабинет</h2>
                            <form class="form-horizontal" method="post">
                                {if $error}
                                <p class="alert alert-danger">{$error}</p>
                                {/if}
                                <p>
                                    <input required value="" name="email" type="email" class="input__control"
                                        placeholder="Email">
                                </p>
                                <p>
                                    <input required value="" name="password" type="password" class="input__control"
                                        placeholder="Пароль">
                                </p>
                                <p>
                                    <button type="submit" name="register"
                                        class="btn btn--blue btn--middle">Войти</button>
                                </p>
                                <p class="links">
                                    <a href="/register/restore">Забыли пароль?</a>
                                    <br><a href="/register">Зарегистрироваться</a>
                                </p>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>
{include file="../common/footer.tpl"}