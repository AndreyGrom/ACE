<form method="post">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title text-uppercase">
                <span class="glyphicon glyphicon-duplicate"></span>
                Настройки модуля "{$config->RegisterModuleTitle}"
            </h3>
        </div>
        <div class="panel-body">
            <div class="form-horizontal" role="form">
                <div class="form-group">
                    <label class="col-sm-3 control-label">Статус:</label>
                    <div class="col-sm-9">
                        <select name="RegisterEnabled" id="RegisterEnabled" class="form-control">
                            <option {if $config->RegisterEnabled == '1'}selected{/if} value="1">Модуль включен</option>
                            <option {if $config->RegisterEnabled == '0'}selected{/if} value="0">Модуль отключен</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">Название модуля:</label>
                    <div class="col-sm-9">
                        <input required value="{$config->RegisterModuleTitle}" name="RegisterModuleTitle" type="text" class="form-control">
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-10 col-sm-offset-1 col-md-offset-1 col-lg-offset-1">
                        <h4>Форма регистрации</h4>
                        <div style="height: 300px;overflow: auto">
                            <table class="table">
                                <tr>
                                    <th>Поле</th>
                                    <th>Показывать</th>
                                    <th>Обязательное</th>
                                </tr>
                                <tr>
                                    <td>Email</td>
                                    <td><input type="checkbox" checked disabled/></td>
                                    <td><input type="checkbox" checked disabled/></td>
                                </tr>
                                <tr>
                                    <td>Пароль</td>
                                    <td><input type="checkbox" checked disabled/></td>
                                    <td><input type="checkbox" checked disabled/></td>
                                </tr>
                                <tr>
                                    <td>Аватар</td>
                                    <td><input {if $config->RegisterFieldAvatarShow}checked{/if} name="RegisterFieldAvatarShow" type="checkbox"/></td>
                                    <td><input {if $config->RegisterFieldAvatarRequired}checked{/if} name="RegisterFieldAvatarRequired" type="checkbox"/></td>
                                </tr>
                                <tr>
                                    <td>Ник</td>
                                    <td><input {if $config->RegisterFieldNickShow}checked{/if} name="RegisterFieldNickShow" type="checkbox"/></td>
                                    <td><input {if $config->RegisterFieldNickRequired}checked{/if} name="RegisterFieldNickRequired" type="checkbox"/></td>
                                </tr>
                                <tr>
                                    <td>Телефон</td>
                                    <td><input {if $config->RegisterFieldPhoneShow}checked{/if} name="RegisterFieldPhoneShow" type="checkbox"/></td>
                                    <td><input {if $config->RegisterFieldPhoneRequired}checked{/if} name="RegisterFieldPhoneRequired" type="checkbox"/></td>
                                </tr>
                                <tr>
                                    <td>Skype</td>
                                    <td><input {if $config->RegisterFieldSkypeShow}checked{/if} name="RegisterFieldSkypeShow" type="checkbox"/></td>
                                    <td><input {if $config->RegisterFieldSkypeRequired}checked{/if} name="RegisterFieldSkypeRequired" type="checkbox"/></td>
                                </tr>
                                <tr>
                                    <td>ICQ</td>
                                    <td><input {if $config->RegisterFieldICQShow}checked{/if} name="RegisterFieldICQShow" type="checkbox"/></td>
                                    <td><input {if $config->RegisterFieldICQRequired}checked{/if} name="RegisterFieldICQRequired" type="checkbox"/></td>
                                </tr>
                                <tr>
                                    <td>Сайт</td>
                                    <td><input {if $config->RegisterFieldSiteShow}checked{/if} name="RegisterFieldSiteShow" type="checkbox"/></td>
                                    <td><input {if $config->RegisterFieldSiteRequired}checked{/if} name="RegisterFieldSiteRequired" type="checkbox"/></td>
                                </tr>
                                <tr>
                                    <td>Фамилия</td>
                                    <td><input {if $config->RegisterFieldFirstNameShow}checked{/if} name="RegisterFieldFirstNameShow" type="checkbox"/></td>
                                    <td><input {if $config->RegisterFieldFirstNameRequired}checked{/if} name="RegisterFieldFirstNameRequired" type="checkbox"/></td>
                                </tr>
                                <tr>
                                    <td>Имя</td>
                                    <td><input {if $config->RegisterFieldNameShow}checked{/if} name="RegisterFieldNameShow" type="checkbox"/></td>
                                    <td><input {if $config->RegisterFieldNameRequired}checked{/if} name="RegisterFieldNameRequired" type="checkbox"/></td>
                                </tr>
                                <tr>
                                    <td>Отчество</td>
                                    <td><input {if $config->RegisterFieldFatherNameShow}checked{/if} name="RegisterFieldFatherNameShow" type="checkbox"/></td>
                                    <td><input {if $config->RegisterFieldFatherNameRequired}checked{/if} name="RegisterFieldFatherNameRequired" type="checkbox"/></td>
                                </tr>
                                <tr>
                                    <td>Дата рождения</td>
                                    <td><input {if $config->RegisterFieldBirthdayShow}checked{/if} name="RegisterFieldBirthdayShow" type="checkbox"/></td>
                                    <td><input {if $config->RegisterFieldBirthdayRequired}checked{/if} name="RegisterFieldBirthdayRequired" type="checkbox"/></td>
                                </tr>
                                <tr>
                                    <td>Страна</td>
                                    <td><input {if $config->RegisterFieldCountryShow}checked{/if} name="RegisterFieldCountryShow" type="checkbox"/></td>
                                    <td><input {if $config->RegisterFieldCountryRequired}checked{/if} name="RegisterFieldCountryRequired" type="checkbox"/></td>
                                </tr>
                                <tr>
                                    <td>Регион</td>
                                    <td><input {if $config->RegisterFieldRegionShow}checked{/if} name="RegisterFieldRegionShow" type="checkbox"/></td>
                                    <td><input {if $config->RegisterFieldRegionRequired}checked{/if} name="RegisterFieldRegionRequired" type="checkbox"/></td>
                                </tr>
                                <tr>
                                    <td>Город</td>
                                    <td><input {if $config->RegisterFieldCityShow}checked{/if} name="RegisterFieldCityShow" type="checkbox"/></td>
                                    <td><input {if $config->RegisterFieldCityRequired}checked{/if} name="RegisterFieldCityRequired" type="checkbox"/></td>
                                </tr>
                                <tr>
                                    <td>WMR-кошелек</td>
                                    <td><input {if $config->RegisterFieldWMRShow}checked{/if} name="RegisterFieldWMRShow" type="checkbox"/></td>
                                    <td><input {if $config->RegisterFieldWMRRequired}checked{/if} name="RegisterFieldWMRRequired" type="checkbox"/></td>
                                </tr>
                                <tr>
                                    <td>WMZ-кошелек</td>
                                    <td><input {if $config->RegisterFieldWMZShow}checked{/if} name="RegisterFieldWMZShow" type="checkbox"/></td>
                                    <td><input {if $config->RegisterFieldWMZRequired}checked{/if} name="RegisterFieldWMZRequired" type="checkbox"/></td>
                                </tr>
                                <tr>
                                    <td>Яндекс кошелек</td>
                                    <td><input {if $config->RegisterFieldYaMoneyShow}checked{/if} name="RegisterFieldYaMoneyShow" type="checkbox"/></td>
                                    <td><input {if $config->RegisterFieldYaMoneyRequired}checked{/if} name="RegisterFieldYaMoneyRequired" type="checkbox"/></td>
                                </tr>
                                <tr>
                                    <td>Qiwi кошелек</td>
                                    <td><input {if $config->RegisterFieldQiwiShow}checked{/if} name="RegisterFieldQiwiShow" type="checkbox"/></td>
                                    <td><input {if $config->RegisterFieldQiwiRequired}checked{/if} name="RegisterFieldQiwiRequired" type="checkbox"/></td>
                                </tr>
                                <tr>
                                    <td>Банковская карта</td>
                                    <td><input {if $config->RegisterFieldCardShow}checked{/if} name="RegisterFieldCardShow" type="checkbox"/></td>
                                    <td><input {if $config->RegisterFieldCardRequired}checked{/if} name="RegisterFieldCardRequired" type="checkbox"/></td>
                                </tr>
                                <tr>
                                    <td>Подпись</td>
                                    <td><input {if $config->RegisterFieldSignatureShow}checked{/if} name="RegisterFieldSignatureShow" type="checkbox"/></td>
                                    <td><input {if $config->RegisterFieldSignatureRequired}checked{/if} name="RegisterFieldSignatureRequired" type="checkbox"/></td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
                <br/>
                <div class="row">
                    <div class="col-sm-10 col-sm-offset-1 col-md-offset-1 col-lg-offset-1">
                        <h4>Профиль пользователя</h4>
                        <div style="height: 300px;overflow: auto">
                            <table class="table">
                                <tr>
                                    <th>Поле</th>
                                    <th>Показывать</th>
                                </tr>
                                <tr>
                                    <td>Аватар</td>
                                    <td><input {if $config->ProfileFieldAvatarShow}checked{/if} name="ProfileFieldAvatarShow" type="checkbox"/></td>
                                </tr>
                                <tr>
                                    <td>Email</td>
                                    <td><input type="checkbox" checked disabled/></td>
                                </tr>
                                <tr>
                                    <td>Пароль</td>
                                    <td><input type="checkbox" checked disabled/></td>
                                </tr>
                                <tr>
                                    <td>Ник</td>
                                    <td><input {if $config->ProfileFieldNickShow}checked{/if} name="ProfileFieldNickShow" type="checkbox"/></td>
                                </tr>
                                <tr>
                                    <td>Телефон</td>
                                    <td><input {if $config->ProfileFieldPhoneShow}checked{/if} name="ProfileFieldPhoneShow" type="checkbox"/></td>
                                </tr>
                                <tr>
                                    <td>Skype</td>
                                    <td><input {if $config->ProfileFieldSkypeShow}checked{/if} name="ProfileFieldSkypeShow" type="checkbox"/></td>
                                </tr>
                                <tr>
                                    <td>ICQ</td>
                                    <td><input {if $config->ProfileFieldICQShow}checked{/if} name="ProfileFieldICQShow" type="checkbox"/></td>
                                </tr>
                                <tr>
                                    <td>Сайт</td>
                                    <td><input {if $config->ProfileFieldSiteShow}checked{/if} name="ProfileFieldSiteShow" type="checkbox"/></td>
                                </tr>
                                <tr>
                                    <td>Фамилия</td>
                                    <td><input {if $config->ProfileFieldFirstNameShow}checked{/if} name="ProfileFieldFirstNameShow" type="checkbox"/></td>
                                </tr>
                                <tr>
                                    <td>Имя</td>
                                    <td><input {if $config->ProfileFieldNameShow}checked{/if} name="ProfileFieldNameShow" type="checkbox"/></td>
                                 </tr>
                                <tr>
                                    <td>Отчество</td>
                                    <td><input {if $config->ProfileFieldFatherNameShow}checked{/if} name="ProfileFieldFatherNameShow" type="checkbox"/></td>
                                </tr>
                                <tr>
                                    <td>Дата рождения</td>
                                    <td><input {if $config->ProfileFieldBirthdayShow}checked{/if} name="ProfileFieldBirthdayShow" type="checkbox"/></td>
                                </tr>
                                <tr>
                                    <td>Страна</td>
                                    <td><input {if $config->ProfileFieldCountryShow}checked{/if} name="ProfileFieldCountryShow" type="checkbox"/></td>
                                </tr>
                                <tr>
                                    <td>Регион</td>
                                    <td><input {if $config->ProfileFieldRegionShow}checked{/if} name="ProfileFieldRegionShow" type="checkbox"/></td>
                                </tr>
                                <tr>
                                    <td>Город</td>
                                    <td><input {if $config->ProfileFieldCityShow}checked{/if} name="ProfileFieldCityShow" type="checkbox"/></td>
                                </tr>
                                <tr>
                                    <td>WMR-кошелек</td>
                                    <td><input {if $config->ProfileFieldWMRShow}checked{/if} name="ProfileFieldWMRShow" type="checkbox"/></td>
                                </tr>
                                <tr>
                                    <td>WMZ-кошелек</td>
                                    <td><input {if $config->ProfileFieldWMZShow}checked{/if} name="ProfileFieldWMZShow" type="checkbox"/></td>
                                </tr>
                                <tr>
                                    <td>Яндекс кошелек</td>
                                    <td><input {if $config->ProfileFieldYaMoneyShow}checked{/if} name="ProfileFieldYaMoneyShow" type="checkbox"/></td>
                                </tr>
                                <tr>
                                    <td>Qiwi кошелек</td>
                                    <td><input {if $config->ProfileFieldQiwiShow}checked{/if} name="ProfileFieldQiwiShow" type="checkbox"/></td>
                                </tr>
                                <tr>
                                    <td>Банковская карта</td>
                                    <td><input {if $config->ProfileFieldCardShow}checked{/if} name="ProfileFieldCardShow" type="checkbox"/></td>
                                </tr>
                                <tr>
                                    <td>Подпись</td>
                                    <td><input {if $config->ProfileFieldSignatureShow}checked{/if} name="ProfileFieldSignatureShow" type="checkbox"/></td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="text-right">
                <button type="submit" name="save-settings" class="btn btn-success btn-large"><span class="glyphicon glyphicon-floppy-disk"></span> Сохранить</button>
            </div>
        </div>
    </div>
</form>