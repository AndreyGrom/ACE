<form method="post">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title text-uppercase">
                <span class="glyphicon glyphicon-duplicate"></span>
                Названия дополнительных полей
            </h3>
        </div>
        <div class="panel-body">
            <div class="form-horizontal" role="form">
                <div class="form-group">
                    <label class="col-sm-3 control-label">Поле №1:</label>
                    <div class="col-sm-9">
                        <input required value="{$config->CatalogField1Name}" name="CatalogField1Name" type="text" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">Поле №2:</label>
                    <div class="col-sm-9">
                        <input required value="{$config->CatalogField2Name}" name="CatalogField2Name" type="text" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">Поле №3:</label>
                    <div class="col-sm-9">
                        <input required value="{$config->CatalogField3Name}" name="CatalogField3Name" type="text" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">Поле №4:</label>
                    <div class="col-sm-9">
                        <input required value="{$config->CatalogField4Name}" name="CatalogField4Name" type="text" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">Поле №5:</label>
                    <div class="col-sm-9">
                        <input required value="{$config->CatalogField5Name}" name="CatalogField5Name" type="text" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">Поле №6:</label>
                    <div class="col-sm-9">
                        <input required value="{$config->CatalogField6Name}" name="CatalogField6Name" type="text" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">Поле №7:</label>
                    <div class="col-sm-9">
                        <input required value="{$config->CatalogField7Name}" name="CatalogField7Name" type="text" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">Поле №8:</label>
                    <div class="col-sm-9">
                        <input required value="{$config->CatalogField8Name}" name="CatalogField8Name" type="text" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">Поле №9:</label>
                    <div class="col-sm-9">
                        <input required value="{$config->CatalogField9Name}" name="CatalogField9Name" type="text" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">Поле №10:</label>
                    <div class="col-sm-9">
                        <input required value="{$config->CatalogField10Name}" name="CatalogField10Name" type="text" class="form-control">
                    </div>
                </div>
            </div>
            <div class="text-right">
                <button type="submit" name="save-fields" class="btn btn-success btn-large"><span class="glyphicon glyphicon-floppy-disk"></span> Сохранить</button>
            </div>
        </div>
    </div>
</form>