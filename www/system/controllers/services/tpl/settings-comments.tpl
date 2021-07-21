<div class="form-group">
    <label class="col-sm-3 control-label">Статус:</label>
    <div class="col-sm-9">
        <select name="CatalogCommentsEnabled" id="CatalogCommentsEnabled" class="form-control">
            <option {if $config->CatalogCommentsEnabled == '1'}selected{/if} value="1">Включены</option>
            <option {if $config->CatalogCommentsEnabled == '0'}selected{/if} value="0">Отключены</option>
        </select>
    </div>
</div>
<div class="form-group">
    <label class="col-sm-3 control-label">Премодерация комментариев:</label>
    <div class="col-sm-9">
        <select name="CatalogCommentsModerationEnabled" id="CatalogCommentsModerationEnabled" class="form-control">
            <option {if $config->CatalogCommentsModerationEnabled == '1'}selected{/if} value="1">Включена</option>
            <option {if $config->CatalogCommentsModerationEnabled == '0'}selected{/if} value="0">Выключена</option>
        </select>
    </div>
</div>
<div class="form-group">
    <label class="col-sm-3 control-label">Капча в комментариях:</label>
    <div class="col-sm-9">
        <select name="CatalogCommentsCaptchaEnabled" id="CatalogCommentsCaptchaEnabled" class="form-control">
            <option {if $config->CatalogCommentsCaptchaEnabled == '1'}selected{/if} value="1">Включена</option>
            <option {if $config->CatalogCommentsCaptchaEnabled == '0'}selected{/if} value="0">Выключена</option>
        </select>
    </div>
</div>
<div class="form-group">
    <label for="CatalogCommentsTemplateView" class="col-sm-3 control-label">Шаблон комментариев:</label>
    <div class="col-sm-9">
        <select name="CatalogCommentsTemplateView" id="CatalogCommentsTemplateView" class="form-control">
            {section name=i loop=$templates_comment_view}
                <option {if $templates_comment_view[i]==$config->CatalogCommentsTemplateView}selected="selected" {/if} value="{$templates_comment_view[i]}">{$templates_comment_view[i]}</option>
            {/section}
        </select>
    </div>
</div>
<div class="form-group">
    <label for="CatalogCommentsTemplateForm" class="col-sm-3 control-label">Шаблон формы комментариев:</label>
    <div class="col-sm-9">
        <select name="CatalogCommentsTemplateForm" id="CatalogCommentsTemplateForm" class="form-control">
            {section name=i loop=$templates_comment_form}
                <option {if $templates_comment_form[i]==$config->CatalogCommentsTemplateForm}selected="selected" {/if} value="{$templates_comment_form[i]}">{$templates_comment_form[i]}</option>
            {/section}
        </select>
    </div>
</div>