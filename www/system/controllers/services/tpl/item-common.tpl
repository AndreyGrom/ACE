<div class="form-horizontal" role="form">
    <div class="form-group">
        <label for="title" class="col-sm-3 control-label">Название:</label>
        <div class="col-sm-9">
            <input required value="{$item.TITLE}" name="title" id="title" type="text" class="form-control" placeholder="Введите название материала">
        </div>
    </div>
    <div class="form-group">
        <label for="title" class="col-sm-3 control-label">Склонение:</label>
        <div class="col-sm-9">
            <input value="{$item.TITLE2}" name="title2" id="title2" type="text" class="form-control" placeholder="Введите название материала">
        </div>
    </div>
    <div class="form-group">
        <label for="alias" class="col-sm-3 control-label">Алиас:</label>
        <div class="col-sm-9">
            <input value="{$item.ALIAS}" name="alias" id="alias" type="text" class="form-control" placeholder="Только символы a-z, A-Z, 0-9, -_ " />
            <p class="help-block">Только символы a-z, A-Z, 0-9, -_ <br/>
                Можно оставить пустым. Заполнится автоматически</p>
        </div>
    </div>
    <div class="form-group">
        <label for="parent" class="col-sm-3 control-label">Категории:</label>
        <div class="col-sm-9">
            <div style="height: 100px;overflow:auto;border:1px solid #ccc;padding: 3px;">
                {include file="menu_.tpl"}
            </div>
        </div>
    </div>
</div>