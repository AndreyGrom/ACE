<form id="cat-form" action="" method="post" enctype="multipart/form-data">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title text-uppercase">
                <span class="glyphicon glyphicon-duplicate"></span>
                Добавление/изменение предмета
            </h3>
        </div>
        <div class="panel-body">

            <!-- Форма для редактора -->
            <div class="form-horizontal" role="form">
                <div class="form-group">
                    <label for="c_title" class="col-sm-3 control-label">Название предмета:</label>
                    <div class="col-sm-9">
                        <input required value="{$item['TITLE']}" name="title" type="text" class="form-control" placeholder="Введите название">
                    </div>
                </div>
            </div>



            <div class="text-right">
                <button type="submit" name="save-predmet" class="btn btn-success btn-large"><span class="glyphicon glyphicon-floppy-disk"></span> Сохранить</button>
            </div>

        </div>
    </div>
</form>
