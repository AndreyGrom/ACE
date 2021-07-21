<form id="page-form" action="" method="post">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title text-uppercase">
                <span class="glyphicon glyphicon-cog"></span> Главная страница. Видео
                <div class="pull-right">
                    <button name="save-vid" type="submit" class="btn btn-success btn-xs"><span class="glyphicon glyphicon-floppy-disk"></span> Сохранить</button>
                </div>
            </h3>
        </div>
        <div class="panel-body">

            <div class="form-horizontal" role="form">


                <div class="form-group disabled-message">
                    <label class="col-sm-3 control-label">Код для вставки:</label>
                    <div class="col-sm-9">
                        <textarea style="height: 200px;" name="vid" id="vid" class="form-control">{$config->vid}</textarea>
                    </div>
                </div>

                {if $config->vid}
                    {$config->vid}
                {/if}
            </div>
        </div>






    </div>




</form>
