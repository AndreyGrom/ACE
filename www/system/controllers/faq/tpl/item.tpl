<form id="page-form" action="" method="post">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title text-uppercase">
                <span class="glyphicon glyphicon-duplicate"></span>
                Создание/Редактирование вопроса-ответа
            </h3>
        </div>
        <div class="panel-body">
            <div class="form-horizontal" role="form">

                <div class="form-group">
                    <label for="title" class="col-sm-3 control-label">Вопрос:</label>
                    <div class="col-sm-9">
                        <input required value="{$item.TITLE}" name="title" id="title" type="text" class="form-control" placeholder="Введите название страницы">
                    </div>
                </div>


            <div class="form-horizontal" role="form">
                <div class="form-group">
                    <label for="content" class="col-sm-12">Ответ:</label>
                    <div class="col-sm-12">

                        <textarea class="textarea-edit" name="otv" id="otv" style="width:100%;height:400px;">{$item.OTV}</textarea>

                    </div>
                </div>

            </div>

            <div class="text-right">
                <button name="save-faq" type="submit" class="btn btn-success btn-large"><span class="glyphicon glyphicon-floppy-disk"></span> Сохранить</button>
            </div>

        </div>
    </div>
</form>
<script type="text/javascript" src="{$html_plugins_dir}init_mce.js"></script>
