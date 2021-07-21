<form method="post">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title text-uppercase">
                <span class="glyphicon glyphicon-duplicate"></span>
                Настройки модуля "{$config->CatalogModuleTitle}"
                <div class="pull-right">
                    <a class="btn btn-primary btn-xs" href="?c=catalog"><span class="glyphicon glyphicon-arrow-left"></span></a>
                    <button type="submit" class="btn btn-primary btn-xs"><span class="glyphicon glyphicon-floppy-disk"></span> Сохранить</button>
                </div>
            </h3>
        </div>
        <div class="panel-body">
            <div class="form-horizontal" role="form">
                <div class="tabs">
                    <ul class="nav nav-tabs">
                        <li class="active"><a href="#tab-common" data-toggle="tab">Общее</a></li>
                        <li><a href="#tab-image" data-toggle="tab">Изображения</a></li>
                        <li><a href="#tab-comments" data-toggle="tab">Комментарии</a></li>
                        <li><a href="#tab-seo" data-toggle="tab">SEO</a></li>
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
                        <div id="tab-seo" class="tab-pane fade">
                            <h3></h3>
                            <p>{include file="settings-seo.tpl"}</p>
                        </div>
                        <div id="tab-comments" class="tab-pane fade">
                            <h3></h3>
                            <p>{include file="settings-comments.tpl"}</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="text-right">
                <button type="submit" name="save-settings" class="btn btn-success btn-large"><span class="glyphicon glyphicon-floppy-disk"></span> Сохранить</button>
            </div>
        </div>
    </div>
</form>