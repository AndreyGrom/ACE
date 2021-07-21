<form id="item-form" action="" method="post" enctype="multipart/form-data">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title text-uppercase">
                <span class="glyphicon glyphicon-duplicate"></span>
                Создание/Редактирование страны
            </h3>
        </div>
        <div class="panel-body">
            <div class="form-horizontal" role="form">

                <div class="form-group">
                    <label for="title" class="col-sm-3 control-label">Название:</label>
                    <div class="col-sm-9">
                        <input required value="{$item.COUNTRY_NAME}" name="name" type="text" class="form-control" placeholder="">
                        <div class="help-block">

                        </div>
                    </div>
                </div>


                {*<div class="form-group">
                    <label for="title" class="col-sm-3 control-label">Склонение:</label>
                    <div class="col-sm-9">
                        <input required value="{$item.S_NAME}" name="s_name" type="text" class="form-control" placeholder="">
                        <div class="help-block">

                        </div>
                    </div>
                </div>*}


                <div class="form-group">
                    <label for="title" class="col-sm-3 control-label">Валюта:</label>
                    <div class="col-sm-9">
                        <input required value="{$item.C_CURRENCY}" name="currency" type="text" class="form-control" placeholder="">
                        <div class="help-block">

                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label for="title" class="col-sm-3 control-label">Навание валюты:</label>
                    <div class="col-sm-9">
                        <input required value="{$item.C_CURRENCY_N}" name="currency_n" type="text" class="form-control" placeholder="">
                        <div class="help-block">

                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label for="title" class="col-sm-3 control-label">HTML код значка (<a target="_blank" href="https://www.rabotayvinter.net/html/simvoly_html/1_znaki_valjut.php">Смотреть</a>):</label>
                    <div class="col-sm-9">
                        <input required value="{$item.C_ZN}" name="zn" type="text" class="form-control" placeholder="">
                        <div class="help-block">

                        </div>
                    </div>
                </div>


                <div class="pull-right">
                    <button type="submit" name="save-country" class="btn btn-success"><span class="glyphicon glyphicon-floppy-disk"></span> Сохранить</button>
                </div>
            </div>

        </div>
    </div>

</form>

