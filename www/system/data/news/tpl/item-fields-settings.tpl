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
                        <input required value="{$config->NewsField1Name}" name="NewsField1Name" type="text" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">Поле №2:</label>
                    <div class="col-sm-9">
                        <input required value="{$config->NewsField2Name}" name="NewsField2Name" type="text" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">Поле №3:</label>
                    <div class="col-sm-9">
                        <input required value="{$config->NewsField3Name}" name="NewsField3Name" type="text" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">Поле №4:</label>
                    <div class="col-sm-9">
                        <input required value="{$config->NewsField4Name}" name="NewsField4Name" type="text" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">Поле №5:</label>
                    <div class="col-sm-9">
                        <input required value="{$config->NewsField5Name}" name="NewsField5Name" type="text" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">Поле №6:</label>
                    <div class="col-sm-9">
                        <input required value="{$config->NewsField6Name}" name="NewsField6Name" type="text" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">Поле №7:</label>
                    <div class="col-sm-9">
                        <input required value="{$config->NewsField7Name}" name="NewsField7Name" type="text" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">Поле №8:</label>
                    <div class="col-sm-9">
                        <input required value="{$config->NewsField8Name}" name="NewsField8Name" type="text" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">Поле №9:</label>
                    <div class="col-sm-9">
                        <input required value="{$config->NewsField9Name}" name="NewsField9Name" type="text" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">Поле №10:</label>
                    <div class="col-sm-9">
                        <input required value="{$config->NewsField10Name}" name="NewsField10Name" type="text" class="form-control">
                    </div>
                </div>
            </div>
            <div class="text-right">
                <button type="submit" name="save-fields" class="btn btn-success btn-large"><span class="glyphicon glyphicon-floppy-disk"></span> Сохранить</button>
            </div>
        </div>
    </div>
</form>