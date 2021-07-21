<form method="post">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title">
                {if $smarty.get.id}
                    <span class="glyphicon glyphicon-pencil"></span> Редактирование производителя
                {else}
                    <span class="glyphicon glyphicon-plus"></span> Добавление производителя
                {/if}
                <div class="pull-right"><a class="btn btn-primary btn-xs" href="?c=shop&act=manufacturer"><span class="glyphicon glyphicon-arrow-left"></span></a></div>
                <div class="clearfix"></div>
            </h3>
        </div>
        <div class="panel-body">
            <div class="form-horizontal" role="form">
                <div class="form-group">
                    <label class="col-sm-3 control-label"><span class="text-danger">*</span> Название:</label>
                    <div class="col-sm-9">
                        <input required value="{$manufacturer.MANUFACTURER_NAME}" name="MANUFACTURER_NAME" type="text" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">Описание:</label>
                    <div class="col-sm-9">
                        <textarea name="MANUFACTURER_DESC" id="" cols="30" rows="10" class="form-control">{$manufacturer.MANUFACTURER_DESC}</textarea>
                    </div>
                </div>
                <div class="form-group">
                    <label for="" class="col-sm-3 control-label">Meta-title:</label>
                    <div class="col-sm-9">
                        <input value="{$manufacturer.MANUFACTURER_META_TITLE}" name="MANUFACTURER_META_TITLE" type="text" class="form-control" />
                    </div>
                </div>
                <div class="form-group">
                    <label for="" class="col-sm-3 control-label">Meta-description:</label>
                    <div class="col-sm-9">
                        <input value="{$manufacturer.MANUFACTURER_META_DESC}" name="MANUFACTURER_META_DESC" type="text" class="form-control" />
                    </div>
                </div>
                <div class="form-group">
                    <label for="" class="col-sm-3 control-label">Meta-keywords:</label>
                    <div class="col-sm-9">
                        <input value="{$manufacturer.MANUFACTURER_META_KEYWORDS}" name="MANUFACTURER_META_KEYWORDS" type="text" class="form-control" />
                    </div>
                </div>
            </div>
            <div class="text-right">
                <button type="submit" class="btn btn-success btn-large"><span class="glyphicon glyphicon-floppy-disk"></span> Сохранить</button>
            </div>
        </div>
    </div>
</form>