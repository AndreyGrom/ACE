<div class="form-group">
    <label class="col-sm-3 control-label">Статус:</label>
    <div class="col-sm-9">
        <select name="ShopEnabled" id="ShopEnabled" class="form-control">
            <option {if $config->ShopEnabled == '1'}selected{/if} value="1">Модуль включен</option>
            <option {if $config->ShopEnabled == '0'}selected{/if} value="0">Модуль отключен</option>
        </select>
    </div>
</div>
<div class="form-group">
    <label class="col-sm-3 control-label">Meta-title модуля:</label>
    <div class="col-sm-9">
        <input required value="{$config->ShopModuleTitle}" name="ShopModuleTitle" type="text" class="form-control">
    </div>
</div>
<div class="form-group">
    <label class="col-sm-3 control-label">Meta-description модуля:</label>
    <div class="col-sm-9">
        <textarea name="ShopModuleDescription" id="" cols="2" rows="3" class="form-control">{$config->ShopModuleDescription}</textarea>
    </div>
</div>
<div class="form-group">
    <label class="col-sm-3 control-label">Кол-во категорий на страницу:</label>
    <div class="col-sm-9">
        <input required value="{$config->ShopCategoryListPerPage}" name="ShopCategoryListPerPage" type="text" class="form-control">
    </div>
</div>
<div class="form-group">
    <label class="col-sm-3 control-label">Кол-во материалов на страницу:</label>
    <div class="col-sm-9">
        <input required value="{$config->ShopItemListPerPage}" name="ShopItemListPerPage" type="text" class="form-control">
    </div>
</div>
<div class="form-group">
    <label class="col-sm-3 control-label">Выводить последние материалы:</label>
    <div class="col-sm-9">
        <select name="ShopItemListSort" id="" class="form-control">
            <option {if $config->ShopItemListSort == 'DESC'}selected{/if} value="DESC">Вначале</option>
            <option {if $config->ShopItemListSort == 'ASC'}selected{/if} value="ASC">В конце</option>
        </select>
    </div>
</div>
<div class="form-group">
    <label class="col-sm-3 control-label">Комментарии:</label>
    <div class="col-sm-9">
        <select name="ShopCommentsEnabled" id="ShopCommentsEnabled" class="form-control">
            <option {if $config->ShopCommentsEnabled == '1'}selected{/if} value="1">Включены</option>
            <option {if $config->ShopCommentsEnabled == '0'}selected{/if} value="0">Отключены</option>
        </select>
    </div>
</div>
<div class="form-group">
    <label for="ShopCommentsTemplateView" class="col-sm-3 control-label">Шаблон комментариев:</label>
    <div class="col-sm-9">
        <select name="ShopCommentsTemplateView" id="ShopCommentsTemplateView" class="form-control">
            {section name=i loop=$templates_comment_view}
                <option {if $templates_comment_view[i]==$config->ShopCommentsTemplateView}selected="selected" {/if} value="{$templates_comment_view[i]}">{$templates_comment_view[i]}</option>
            {/section}
        </select>
    </div>
</div>
<div class="form-group">
    <label for="ShopCommentsTemplateForm" class="col-sm-3 control-label">Шаблон формы комментариев:</label>
    <div class="col-sm-9">
        <select name="ShopCommentsTemplateForm" id="ShopCommentsTemplateForm" class="form-control">
            {section name=i loop=$templates_comment_form}
                <option {if $templates_comment_form[i]==$config->ShopCommentsTemplateForm}selected="selected" {/if} value="{$templates_comment_form[i]}">{$templates_comment_form[i]}</option>
            {/section}
        </select>
    </div>
</div>