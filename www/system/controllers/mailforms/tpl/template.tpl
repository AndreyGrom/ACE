<form id="page-form" action="" method="post">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title text-uppercase">
                <span class="glyphicon glyphicon-duplicate"></span>
                Дизайн формы "{$form['name']}"
                <div class="pull-right"><a class="bnt btn-xs btn-primary" href="?c=mailforms&fid={$form['id']}&act=fields"><span class="glyphicon glyphicon-arrow-left"></span> Назад к списку полей</a></div>
            </h3>
        </div>
        <div class="panel-body">
            <div class="alert alert-info">
                <p><a href="?c=mailforms&fid={$form['id']}&act=template&restruct"><span class="glyphicon glyphicon-picture"></span> Перестроить шаблон формы</a></p>
            </div>
            <div class="form-horizontal">
                <div class="form-group">
                    <div class="col-sm-12">
                        <textarea class="form-control" name="template" id="template" rows="15">{$template}</textarea>
                    </div>
                    </div>
                </div>
            </div>

            <div class="text-right">
                <button type="submit" class="btn btn-success btn-large"><span class="glyphicon glyphicon-floppy-disk"></span> Сохранить</button>
            </div>

        </div>
    </div>
</form>
<script>
    $(document).ready(function(){
        editAreaLoader.init({
            id: "template"
            ,start_highlight: true
            ,allow_resize: "both"
            ,allow_toggle: true
            ,word_wrap: true
            ,language: "ru"
            ,syntax: "html"
            ,min_width: "50"
            ,width: "150"
            ,min_height: "400"
            // ,display: "later"
        });
    });
</script>