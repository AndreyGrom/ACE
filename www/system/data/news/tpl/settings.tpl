<form method="post">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title text-uppercase">
                <span class="glyphicon glyphicon-duplicate"></span>
                Настройки модуля "{$config->NewsModuleTitle}"
            </h3>
        </div>
        <div class="panel-body">
            <div class="form-horizontal" role="form">
                <div class="form-group">
                    <label class="col-sm-3 control-label">Статус:</label>
                    <div class="col-sm-9">
                        <select name="NewsEnabled" id="NewsEnabled" class="form-control">
                            <option {if $config->NewsEnabled == '1'}selected{/if} value="1">Модуль включен</option>
                            <option {if $config->NewsEnabled == '0'}selected{/if} value="0">Модуль отключен</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">Название модуля:</label>
                    <div class="col-sm-9">
                        <input required value="{$config->NewsModuleTitle}" name="NewsModuleTitle" type="text" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">Размер изображения новостей:</label>
                    <div class="col-sm-2">
                        <input required value="{$config->NewsImageWidthItemList}" name="NewsImageWidthItemList" type="text" class="form-control">
                    </div>
                    <div class="col-sm-1"><p class="form-control">X</p></div>
                    <div class="col-sm-2">
                        <input required value="{$config->NewsImageHeightItemList}" name="NewsImageHeightItemList" type="text" class="form-control">
                    </div>
                    <div class="col-sm-1"><p class="form-control">px</p></div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">Кол-во материалов на страницу:</label>
                    <div class="col-sm-9">
                        <input required value="{$config->NewsItemListPerPage}" name="NewsItemListPerPage" type="text" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">Выводить последние новости:</label>
                    <div class="col-sm-9">
                        <select name="NewsItemListSort" id="" class="form-control">
                            <option {if $config->NewsItemListSort == 'DESC'}selected{/if} value="DESC">Вначале</option>
                            <option {if $config->NewsItemListSort == 'ASC'}selected{/if} value="ASC">В конце</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">Комментарии:</label>
                    <div class="col-sm-9">
                        <select name="NewsCommentsEnabled" id="NewsCommentsEnabled" class="form-control">
                            <option {if $config->NewsCommentsEnabled == '1'}selected{/if} value="1">Включены</option>
                            <option {if $config->NewsCommentsEnabled == '0'}selected{/if} value="0">Отключены</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label for="NewsCommentsTemplateView" class="col-sm-3 control-label">Шаблон комментариев:</label>
                    <div class="col-sm-9">
                        <select name="NewsCommentsTemplateView" id="NewsCommentsTemplateView" class="form-control">
                            {section name=i loop=$templates_comment_view}
                                <option {if $templates_comment_view[i]==$config->NewsCommentsTemplateView}selected="selected" {/if} value="{$templates_comment_view[i]}">{$templates_comment_view[i]}</option>
                            {/section}
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label for="NewsCommentsTemplateForm" class="col-sm-3 control-label">Шаблон формы комментариев:</label>
                    <div class="col-sm-9">
                        <select name="NewsCommentsTemplateForm" id="NewsCommentsTemplateForm" class="form-control">
                            {section name=i loop=$templates_comment_form}
                                <option {if $templates_comment_form[i]==$config->NewsCommentsTemplateForm}selected="selected" {/if} value="{$templates_comment_form[i]}">{$templates_comment_form[i]}</option>
                            {/section}
                        </select>
                    </div>
                </div>
            </div>
            <div class="text-right">
                <button type="submit" name="save-settings" class="btn btn-success btn-large"><span class="glyphicon glyphicon-floppy-disk"></span> Сохранить</button>
            </div>
        </div>
    </div>
</form>