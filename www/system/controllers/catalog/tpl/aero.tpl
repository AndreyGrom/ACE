<form id="item-form" action="" method="post" enctype="multipart/form-data">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title text-uppercase">
                <span class="glyphicon glyphicon-duplicate"></span>
                Создание/Редактирование аэропорта
            </h3>
        </div>
        <div class="panel-body">
            <div class="form-horizontal" role="form">

                <div class="form-group">
                    <label for="title" class="col-sm-3 control-label">Заголовок:</label>
                    <div class="col-sm-9">
                        <input required value="{$item.TITLE}" name="title" type="text" class="form-control" placeholder="">
                        <div class="help-block">

                        </div>
                    </div>
                </div>

                <div class="pull-right">
                    <button type="submit" name="save-aero" class="btn btn-success"><span class="glyphicon glyphicon-floppy-disk"></span> Сохранить</button>
                </div>
            </div>

        </div>
    </div>

</form>

