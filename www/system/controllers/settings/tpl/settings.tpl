<form id="page-form" action="" method="post">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title text-uppercase">
                <span class="glyphicon glyphicon-cog"></span> Настройки сайта
                <div class="pull-right">
                    <button type="submit" class="btn btn-success btn-xs"><span class="glyphicon glyphicon-floppy-disk"></span> Сохранить</button>
                </div>
            </h3>
        </div>
        <div class="panel-body">
            <div class="form-horizontal" role="form">

                <div class="tabs">
                    <ul class="nav nav-tabs">
                        <li class="active"><a href="#tab-common" data-toggle="tab">Общие</a></li>
                        <li><a href="#tab-geo" data-toggle="tab">Расположение и контакты</a></li>
                        <li><a href="#tab-profile" data-toggle="tab">Админ-профиль</a></li>
                        <li><a href="#tab-email" data-toggle="tab">Почта</a></li>
                    </ul>
                    <div class="tab-content">
                        <div id="tab-common" class="tab-pane fade in active">
                            <h3>Общие данные</h3>
                            <p>{include file="settings-common.tpl"}</p>
                        </div>
                        <div id="tab-geo" class="tab-pane fade">
                            <h3></h3>
                            <p>{include file="settings-geo.tpl"}</p>
                        </div>
                        <div id="tab-profile" class="tab-pane fade">
                            <h3></h3>
                            <p>{include file="settings-profile.tpl"}</p>
                        </div>
                        <div id="tab-email" class="tab-pane fade">
                            <h3></h3>
                            <p>{include file="settings-email.tpl"}</p>
                        </div>
                    </div>
                </div>
            </div>



        </div>
    </div>
</form>
