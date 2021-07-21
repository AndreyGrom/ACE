<div class="form-horizontal" role="form">
    <div class="form-group">
        <label for="content" class="col-sm-12">Краткое описание:</label>
        <div class="col-sm-12">

            <textarea name="short_content" class="textarea-edit" id="short_content" style="width:750px;height:400px;">{$short_item_content}</textarea>

        </div>
    </div>

    <div class="form-group">
        <label for="content" class="col-sm-12">Полное описание:</label>
        <div class="col-sm-12">

            <textarea class="form-control textarea-edit" name="content" id="content" style="width:750px;height:400px;">{$item_content}</textarea>

        </div>
    </div>

    <div class="form-group">
        <label for="" class="col-sm-3 control-label">Meta-description:</label>
        <div class="col-sm-9">
            <input value="{$item_meta_desc}" name="meta_description" type="text" class="form-control" />
        </div>
    </div>
    <div class="form-group">
        <label for="" class="col-sm-3 control-label">Meta-keywords:</label>
        <div class="col-sm-9">
            <input value="{$item_meta_keywords}" name="meta_keywords" type="text" class="form-control" />
        </div>
    </div>
    <div class="form-group">
        <label for="" class="col-sm-3 control-label">Теги:</label>
        <div class="col-sm-9">
            <input value="{$item_tags}" name="tags" type="text" class="form-control" />
            <p class="help-block">Через запятую</p>
        </div>
    </div>
</div>