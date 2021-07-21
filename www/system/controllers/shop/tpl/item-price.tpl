<div class="form-horizontal" role="form">
    <div class="form-group">
        <label class="col-sm-3 control-label">Артикул:</label>
        <div class="col-sm-9">
            <input value="{$item_article}" name="article" type="text" class="form-control">
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-3 control-label">Модель:</label>
        <div class="col-sm-9">
            <input value="{$item_model}" name="model" type="text" class="form-control">
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-3 control-label">Производитель:</label>
        <div class="col-sm-9">
            <select name="manufacturer" class="form-control">
                <option value="0">--</option>
                {section name=i loop=$manufacturers}
                    <option {if $item_manufacturer == $manufacturers[i].MANUFACTURER_ID} selected="selected" {/if} value="{$manufacturers[i].MANUFACTURER_ID}">{$manufacturers[i].MANUFACTURER_NAME}</option>
                {/section}
            </select>
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-3 control-label">Страна:</label>
        <div class="col-sm-9">
            <input value="{$item_country}" name="country" type="text" class="form-control">
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-3 control-label">Оптовая цена:</label>
        <div class="col-sm-9">
            <input value="{$item_price_opt}" name="price_opt" type="text" class="form-control">
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-3 control-label">Розничная цена:</label>
        <div class="col-sm-9">
            <input value="{$item_price}" name="price" type="text" class="form-control">
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-3 control-label">Новая цена:</label>
        <div class="col-sm-9">
            <input value="{$item_price_new}" name="price_new" type="text" class="form-control">
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-3 control-label">Количество:</label>
        <div class="col-sm-9">
            <input value="{$item_quantity}" name="quantity" type="text" class="form-control">
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-12 control-label" style="text-align: left">Видео товара:</label>
        <div class="col-sm-12">
            <textarea name="video" id="" cols="30" rows="10" class="form-control">{$item_video}</textarea>
        </div>
    </div>
</div>