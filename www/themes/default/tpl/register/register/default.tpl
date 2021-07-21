{include file="../../common/header.tpl"}

<main>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">

                <div class="register-page">
                    <div class="row justify-content-center">
                        <div class="col-lg-10">
                            <h2>Регистрация</h2>
                            {if $error}
                            <p class="alert alert-danger">{$error}</p>
                            {/if}
        
                            <form class="form-horizontal" method="post" id="register-form">
        
                                <p>
                                    <input required value="{$smarty.post.email}" name="email" id="email"
                                        type="email" class="input__control" placeholder="Email">
                                    <div class="help-block" id="system_message_email"></div>
                                </p>
        
                                <p>
                                    <input required value="{$smarty.post.password}" name="password"
                                        id="password" type="text" class="input__control"
                                        placeholder="Пароль (от 4 до 20 символов)">
                                    <div class="help-block" id="system_message_password"></div>
                                </p>
        
                                {*<p>
                                    <button id="gen-p" class="btn btn--blue" type="button">Сгенерировать</button>
                                </p>*}
        
                                <p>
                                    <input required value="" name="captcha" id="captcha" type="tel" class="input__control"
                                        placeholder="Код с картинки">
                                    <div class="help-block" id="system_message_captcha"></div>
                                </p>
        
                                <img class="img-responsive" id="captcha"
                                    src="{$html_plugins_dir}captcha/index.php?hash={$rand}&sn=register" alt="" />
        
                                <p>
                                    <button type="submit" name="register"
                                        class="btn btn--blue btn--middle">Зарегистрироваться</button>
                                </p>
        
                                <p class="links"> <a href="/login">Уже зарегистрированы?</a></p>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</main>

<script>
    $("#captcha").click(function () {
        $(this).attr('src', '{$html_plugins_dir}captcha/index.php?hash=' + new Date().getTime() +
            '&sn=register');
    }); {
        literal
    }
    var CheckParam = false;

    function CheckP(elm, ParamName) {
        if (elm.val() == false) {
            CheckParam = true;
            return false;
        }
        time = (new Date()).getTime();
        delay = 500;
        elm.attr({
            'keyup': time
        });
        elm.off('keydown');
        elm.off('keypress');
        elm.on('keydown', function (e) {
            $(this).attr({
                'keyup': time
            });
        });
        elm.on('keypress', function (e) {
            $(this).attr({
                'keyup': time
            });
        });
        var system_message = $("#system_message_" + ParamName);
        setTimeout(function () {
            oldtime = parseFloat(elm.attr('keyup'));
            if (oldtime <= (new Date()).getTime() - delay & oldtime > 0 & elm.attr('keyup') != '' & typeof elm
                .attr('keyup') !== 'undefined') {
                /*Ваша функция после окончания печати*/
                var param = elm.val();
                system_message.text('Проверка...');
                system_message.css("color", "green");
                elm.css("border", "green solid 1px");
                $.ajax({
                    type: 'POST',
                    url: '/system/controllers/register/ajax.php',
                    data: ParamName + '=' + param,
                    success: function (result) {
                        if (result != 0) {
                            system_message.text(result);
                            system_message.css("color", "red");
                            elm.css("border", "red solid 1px");
                            CheckParam = false;
                        } else {
                            system_message.text('Все верно');
                            system_message.css("color", "green");
                            elm.css("border", "green solid 1px");
                            CheckParam = true;
                        }
                    }
                });
                elm.removeAttr('keyup');
            }
        }, delay);
    } {
        /literal}



        $('#email').keyup(function (e) {
            CheckP($(this), 'email');
        });
        $('#email').change(function (e) {
            CheckP($(this), 'email');
        });
        CheckP($('#email'), 'email');

        $('#password').keyup(function (e) {
            CheckP($(this), 'password');
        });
        $('#password').change(function (e) {
            CheckP($(this), 'password');
        });
        CheckP($('#password'), 'password');

        $('#captcha').keyup(function (e) {
            CheckP($(this), 'captcha');
        });
        $('#password').change(function (e) {
            CheckP($(this), 'captcha');
        });
        CheckP($('#captcha'), 'captcha');

        $("#register-form").submit(function () {
            if (!CheckParam) {
                alert('Пожалуста, правильно заполните форму');
                return false;
            }
        });

        function gen_password(len) {
            var password = "";
            var symbols = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!№;%:?*()_+=";
            for (var i = 0; i < len; i++) {
                password += symbols.charAt(Math.floor(Math.random() * symbols.length));
            }
            return password;
        }

        $("#gen-p").click(function () {
            $("#password").val(gen_password(6));
        });
</script>
{include file="../../common/footer.tpl"}