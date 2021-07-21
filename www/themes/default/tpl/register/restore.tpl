{include file="../common/header.tpl"}
<main>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">
                <div class="register-page">

                    <h2>Восстановление пароля</h2>

                    <div class="row justify-content-center">
                        <div class="col-lg-10">
                            <form class="form-horizontal" method="post">
                                {if $error}
                                <p class="alert alert-danger">Такой Email не зарегистрирован в системе</p>
                                {/if}
                                <p>
                                    <input required value="" name="email" type="email" class="input__control"
                                        placeholder="Email">
                                </p>

                                <p>
                                    <button type="submit" name="restore"
                                        class="btn btn--blue btn--middle">Восстановить</button>
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