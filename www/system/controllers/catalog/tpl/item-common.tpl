<div class="form-horizontal" role="form">
    <div class="form-group">
        <label for="template" class="col-sm-3 control-label">Принадлежит:</label>
        <div class="col-sm-9">
            <select name="net_id" id="net_id" class="form-control">
                <option value="0">Без сети</option>
                {section name=i loop=$nets}
                    <option {if $nets[i].ID==$item.NET_ID}selected="selected" {/if} value="{$nets[i].ID}">{$nets[i].TITLE}</option>
                {/section}
            </select>
        </div>
    </div>
    <div class="form-group">
        <label for="title" class="col-sm-3 control-label">Название:</label>
        <div class="col-sm-9">
            <input required value="{$item.TITLE}" name="title" id="title" type="text" class="form-control" placeholder="Введите название материала">
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
    <div class="form-group">
        <label for="template" class="col-sm-3 control-label">Шаблон:</label>
        <div class="col-sm-9">
            <select name="template" id="template" class="form-control">
                {section name=i loop=$templates}
                    <option {if $templates[i]==$item.TEMPLATE}selected="selected" {/if} value="{$templates[i]}">{$templates[i]}</option>
                {/section}
            </select>
        </div>
    </div>
    <div class="form-group">
        <label for="content" class="col-sm-12">Краткое описание:</label>
        <div class="col-sm-12">
            <textarea name="short_content" class="textarea-edit" id="short_content" style="width:750px;height:100px;">{$item.SHORT_CONTENT}</textarea>
        </div>
    </div>
</div>