<form method="post" enctype="multipart/form-data">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title text-uppercase">
                <span class="glyphicon glyphicon-duplicate"></span>
                Обновление цен и количества товаров
            </h3>
        </div>
        <div class="panel-body">
            <div class="form-horizontal" role="form">
                <div class="form-group">
                    <label class="col-sm-3 control-label">Файл №1 (.csv)</label>
                    <div class="col-sm-9">
                        <input required  name="file1" type="file" class="form-control2">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">Файл №2 (.csv)</label>
                    <div class="col-sm-9">
                        <input  name="file2" type="file" class="form-control2">
                    </div>
                </div>
            </div>
            <div class="text-right">
                <button type="submit" name="import" class="btn btn-success btn-large"><span class="glyphicon glyphicon-upload"></span> Загрузить</button>
            </div>
        </div>
    </div>
</form>