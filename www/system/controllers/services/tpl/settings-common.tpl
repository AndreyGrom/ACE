<div class="form-group">
    <label class="col-sm-3 control-label">Статус:</label>
    <div class="col-sm-9">
        <select name="CatalogEnabled" id="CatalogEnabled" class="form-control">
            <option {if $config->CatalogEnabled == '1'}selected{/if} value="1">Модуль включен</option>
            <option {if $config->CatalogEnabled == '0'}selected{/if} value="0">Модуль отключен</option>
        </select>
    </div>
</div>

<div class="form-group">
    <label class="col-sm-3 control-label">Кол-во категорий на страницу:</label>
    <div class="col-sm-9">
        <input required value="{$config->CatalogCategoryListPerPage}" name="CatalogCategoryListPerPage" type="text" class="form-control">
    </div>
</div>
<div class="form-group">
    <label class="col-sm-3 control-label">Кол-во материалов на страницу:</label>
    <div class="col-sm-9">
        <input required value="{$config->CatalogItemListPerPage}" name="CatalogItemListPerPage" type="text" class="form-control">
    </div>
</div>
<div class="form-group">
    <label class="col-sm-3 control-label">Выводить последние материалы:</label>
    <div class="col-sm-9">
        <select name="CatalogItemListSort" id="" class="form-control">
            <option {if $config->CatalogItemListSort == 'DESC'}selected{/if} value="DESC">Вначале</option>
            <option {if $config->CatalogItemListSort == 'ASC'}selected{/if} value="ASC">В конце</option>
        </select>
    </div>
</div>
