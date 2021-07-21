<form id="item-form" action="" method="post" enctype="multipart/form-data">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title text-uppercase">
                <span class="glyphicon glyphicon-duplicate"></span>
                Создание/Редактирование включенной услуги
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
                <div class="form-group">
                    <label for="title" class="col-sm-3 control-label">Иконка:</label>
                    <div class="col-sm-9">
                        <input value="{htmlspecialchars($item.ICON)}" class="form-control" type="text" name="icon"/>
                        <div class="help-block">
                            <a target="_blank" href="https://fontawesome.ru/all-icons/">Посмотреть иконки</a>
                        </div>
                    </div>
                </div>

                <div class="pull-right">
                    <button type="submit" name="save-inc" class="btn btn-success"><span class="glyphicon glyphicon-floppy-disk"></span> Сохранить</button>
                </div>
            </div>

        </div>
    </div>

</form>
<script type="text/javascript" src="{$html_plugins_dir}init_mce.js"></script>
<script>
    $(".confirm").click(function(e){
        if (!confirm("Вы уверенны что хотите это сделать?")){
            e.preventDefault();
        }
    });

</script>
