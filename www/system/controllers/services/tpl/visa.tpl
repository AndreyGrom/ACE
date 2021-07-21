<form id="cat-form" action="" method="post" enctype="multipart/form-data">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title text-uppercase">
                <span class="glyphicon glyphicon-duplicate"></span>
                Добавление/изменение типа визы для страны {$country.COUNTRY_NAME}
            </h3>
        </div>
        <div class="panel-body">


            <div class="form-horizontal" role="form">
                <div class="form-group">
                    <label for="c_title" class="col-sm-3 control-label">Тип визы:</label>
                    <div class="col-sm-9">
                        <input required value="{$item.TYPE}" name="type" type="text" class="form-control" placeholder="">
                    </div>
                </div>
            </div>

            <div class="form-horizontal" role="form">
                <div class="form-group">
                    <label for="c_title" class="col-sm-3 control-label">Цена:</label>
                    <div class="col-sm-9">
                        <input required value="{$item.PRICE}" name="price" type="text" class="form-control" placeholder="">
                    </div>
                </div>
            </div>

            <div class="form-horizontal" role="form">
                <div class="form-group">
                    <label for="c_title" class="col-sm-3 control-label">Цена со скидкой:</label>
                    <div class="col-sm-9">
                        <input required value="{$item.PRICE_NEW}" name="price_new" type="text" class="form-control" placeholder="">
                    </div>
                </div>
            </div>

            <div class="text-right">
                <button type="submit" name="save-visa" class="btn btn-success btn-large"><span class="glyphicon glyphicon-floppy-disk"></span> Сохранить</button>
            </div>

        </div>
    </div>
</form>
