<div class="form-group">
    <label class="col-sm-3 control-label">Статус:</label>
    <div class="col-sm-9">
        <select name="SiteEnabled" id="SiteEnabled" class="form-control">
            <option {if $config->SiteEnabled == '1'}selected{/if} value="1">Сайт включен</option>
            <option {if $config->SiteEnabled == '0'}selected{/if} value="0">Сайт отключен</option>
        </select>
    </div>
</div>
<div class="form-group disabled-message" {if $config->SiteEnabled == '1'}style="display:none;"{/if}>
    <label for="SiteDisabledMessage" class="col-sm-3 control-label">Сообщение при отключенном сайте:</label>
    <div class="col-sm-9">
        <textarea name="SiteDisabledMessage" id="SiteDisabledMessage" class="form-control">{$config->SiteDisabledMessage}</textarea>
    </div>
</div>
<div class="form-group">
    <label for="title" class="col-sm-3 control-label">Название сайта:</label>
    <div class="col-sm-9">
        <input value="{$config->SiteTitle}" name="SiteTitle" id="SiteTitle" type="text" class="form-control" placeholder="">
    </div>
</div>
<div class="form-group">
    <label for="title" class="col-sm-3 control-label">Описание сайта:</label>
    <div class="col-sm-9">
        <textarea name="SiteDescription" id="SiteDescription" cols="30" rows="5" class="form-control">{$config->SiteDescription}</textarea>
    </div>
</div>
<div class="form-group">
    <label for="title" class="col-sm-3 control-label">Владелец:</label>
    <div class="col-sm-9">
        <input value="{$config->SiteDirector}" name="SiteDirector" id="SiteDirector" type="text" class="form-control" placeholder="">
    </div>
</div>
<div class="form-group">
    <label for="template" class="col-sm-3 control-label">Тема оформления:</label>
    <div class="col-sm-9">
        <select name="Theme" id="Theme" class="form-control">
            {section name=i loop=$themes}
                <option {if $themes[i]==$page_template}selected="selected" {/if} value="{$themes[i]}">{$themes[i]}</option>
            {/section}
        </select>
    </div>
</div>
<div class="form-group">
    <label class="col-sm-3 control-label">Модуль на главной:</label>
    <div class="col-sm-9">
        <select name="ModuleDefault" id="ModuleDefault" class="form-control">
            {section name=i loop=$modules}
                {if $modules[i].type !==0}
                    <option {if $modules[i].alias==$config->ModuleDefault}selected="selected"{/if} value="{$modules[i].alias}">{$modules[i].name}</option>
                {/if}
            {/section}
        </select>
    </div>
</div>

<div class="form-group">
    <label class="col-sm-3 control-label">Мета-описание по-умолчанию:</label>
    <div class="col-sm-9">
        <input value="{$config->DefaultMetaDesc}" name="DefaultMetaDesc" type="text" class="form-control" />
    </div>
</div>

<div class="form-group">
    <label for="" class="col-sm-3 control-label">Ключевые слова по-умолчанию:</label>
    <div class="col-sm-9">
        <input value="{$config->DefaultMetaKeywords}" name="DefaultMetaKeywords" type="text" class="form-control" />
    </div>
</div>

<div class="form-group">
    <label for="title" class="col-sm-3 control-label">Преффикс для заказов:</label>
    <div class="col-sm-9">
        <input value="{$config->OrderPref}" name="OrderPref" id="OrderPref" type="text" class="form-control" placeholder="">
    </div>
</div>

<hr/>
<div class="form-group">
    <label class="col-sm-3 control-label">Консоль отладки:</label>
    <div class="col-sm-9">
        <select name="ShowDebugConsole" id="ShowDebugConsole" class="form-control">
            <option {if $config->ShowDebugConsole == '1'}selected{/if} value="1">Показывать</option>
            <option {if $config->ShowDebugConsole == '0'}selected{/if} value="0">Не показывать</option>
        </select>
    </div>
</div>
<script>
    $("#SiteEnabled").change(function(){
        if ($(this).val() == 0){
            $(".disabled-message").show();
        } else {
            $(".disabled-message").hide();
        }
    });
</script>