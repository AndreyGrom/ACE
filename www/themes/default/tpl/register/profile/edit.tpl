{include file="../../common/header.tpl"}

<main class="page-profile">
    <div class="container">
        <div class="row">
            <div class="col">
                <h1>Профиль</h1>

                {if $error}
                <div class="alert alert-danger">
                    <p>{$error}</p>
                </div>
                {/if}

                <div class="row">
                    <div class="col-lg-9">
                        <div class="profile-main">
                            <div class="row">
                                <div class="col-lg-3">
                                    <div id="img-pr">
                                        {if $user.AVATAR}
                                        <img class="img-photo"
                                            src="/upload/images/users/avatars/{$user.ID}/{$user.AVATAR}" alt="" />
                                        {/if}
                                    </div>
                                    <div data-id="{$user.ID}" id="upload" class="btn btn--mini btn--blue btn-upload-img"><span
                                            style="cursor: pointer">Выбрать фoто<span></div>
                                    <span id="status"></span>
                                    
                                </div>
                                <div class="col-lg-6 offset-lg-1">
                                    <form class="form-horizontal" method="post" enctype="multipart/form-data">
                                        <p>
                                            <label>Имя:</label>
                                            <input value="{$user.FIRST_NAME}" name="last_name" type="text"
                                                class="input__control">
                                        </p>
                                        <p>
                                            <label>Телефон:</label>
                                            <input value="{$user.PHONE}" name="phone" type="tel" class="input__control">
                                        </p>
                                        <p>
                                            <label>Email:</label>
                                            <input required value="{$user.EMAIL}" name="email" type="email"
                                                class="input__control">
                                        </p>
                                        <p>
                                            <label>Новый пароль:</label>
                                            <input value="" name="password" type="text" class="input__control">
                                        </p>
                                        <p>
                                            <button type="submit" name="save-user"
                                                class="btn btn--middle btn--blue">Сохранить</button>
                                        </p>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3">
                        {include file="../../common/sidebar2.tpl"}
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

{include file="../../common/footer.tpl"}