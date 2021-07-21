<form method="post">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title text-uppercase">
                <span class="glyphicon glyphicon-duplicate"></span>
                Настройки модуля "{$config->ShopModuleTitle}"
            </h3>
        </div>
        <div class="panel-body">
            <div class="form-horizontal" role="form">

                <div class="tabs">
                    <ul class="nav nav-tabs">
                        <li class="active"><a href="#tab-common" data-toggle="tab">Общее</a></li>
                        <li><a href="#tab-image" data-toggle="tab">Изображения</a></li>
                        <li><a href="#tab-pays" data-toggle="tab">Способы оплаты</a></li>
                    </ul>
                    <div class="tab-content">
                        <div id="tab-common" class="tab-pane fade in active">
                            <h3></h3>
                            <p>{include file="settings-common.tpl"}</p>
                        </div>
                        <div id="tab-image" class="tab-pane fade">
                            <h3></h3>
                            <p>{include file="settings-image.tpl"}</p>
                        </div>
                        <div id="tab-pays" class="tab-pane fade">
                            <h3></h3>
                            <p>{include file="settings-pays.tpl"}</p>
                        </div
                    </div>
                </div>

            </div>
            <div class="text-right">
                <button type="submit" name="save-settings" class="btn btn-success btn-large"><span class="glyphicon glyphicon-floppy-disk"></span> Сохранить</button>
            </div>
        </div>
    </div>
</form>