{include file="../../common/header.tpl"}

<main class="page-profile">
    <div class="container">
        <div class="row">
            <div class="col">
                <h1>Профиль</h1>

                <div class="row">
                    <div class="col-lg-9">
                        <div class="profile-main">
                            <div class="row">
                                <div class="col-lg-3">
                                    <img class="img-photo" src="/upload/images/users/avatars/{$user.ID}/{$user.AVATAR}"
                                        alt="" />
                                </div>
                                <div class="col-lg-9">
                                    <table class="table table-main">
                                        <tr>
                                            <td>Имя:</td>
                                            <td>{$user.FIRST_NAME}</td>
                                        </tr>
                                        <tr>
                                            <td>Телефон:</td>
                                            <td>{$user.PHONE}</td>
                                        </tr>
                                        <tr>
                                            <td>Email:</td>
                                            <td>{$user.EMAIL}</td>
                                        </tr>
    
                                    </table>
                                    <a class="btn btn--middle btn--blue" href="/register/edit">Редактировать</a>
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