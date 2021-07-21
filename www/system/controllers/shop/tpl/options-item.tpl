<form method="post">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title">
                {if $smarty.get.id}
                    <span class="glyphicon glyphicon-pencil"></span> Редактирование опции
                {else}
                    <span class="glyphicon glyphicon-plus"></span> Добавление опции
                {/if}
                <div class="pull-right"><a class="btn btn-primary btn-xs" href="?c=shop&act=options"><span class="glyphicon glyphicon-arrow-left"></span></a></div>
                <div class="clearfix"></div>
            </h3>
        </div>
        <div class="panel-body">
            <div class="form-horizontal" role="form">
                <div class="form-group">
                    <label class="col-sm-3 control-label"><span class="text-danger">*</span> Название:</label>
                    <div class="col-sm-9">
                        <input required value="{$option.OPTION_NAME}" name="OPTION_NAME" type="text" class="form-control">
                    </div>
                </div>
                {if $smarty.get.id}
                    <hr/>
                    <h5>Добавить параметр</h5>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">Параметр</label>
                        <div class="col-sm-9">
                            <input value="{$option.OPTION_PARAMETER}" name="OPTION_PARAMETER" type="text" class="form-control">
                        </div>
                    </div>

                    <br/>
                    {if params}
                        <table class="table table-hover">
                            <tr>

                                <th>Параметр</th>
                                <th>Действие</th>
                            </tr>
                            {section name=i loop=$params}
                                <tr>
                                    <td class="param-name">{$params[i].PARAMETER}</td>
                                    <td>
                                        <a href="{$params[i].ID}" class="btn btn-primary btn-xs edit"><span class="glyphicon glyphicon-pencil"></span></a>
                                        <a href="?c=shop&act=options&act2=del-param&id={$option.OPTION_ID}&param_id={$params[i].ID}" class="btn btn-danger btn-xs confirm"><span class="glyphicon glyphicon-remove"></span></a>
                                    </td>
                                </tr>
                            {/section}
                        </table>
                    {/if}
                {/if}
                <div class="text-right">
                    <button type="submit" class="btn btn-success btn-large"><span class="glyphicon glyphicon-floppy-disk"></span> Сохранить</button>
                </div>
            </div>

        </div>
    </div>
</form>
<form id="param-edit" method="post" style="display: none">
    <input type="text" name="PARAM_NAME"/>
    <input type="text" name="PARAM_ID"/>
</form>
<script>
    $(".edit").click(function(e){
        e.preventDefault();
        var id = $(this).attr('href');
        var s = prompt('Введите новое название параметра');
        if (s == null || s == '') return false;
        $(this).parent().parent().find(".param-name").text(s);
        var form = $("#param-edit");
        form.find('input[name="PARAM_NAME"]').val(s);
        form.find('input[name="PARAM_ID"]').val(id);
        form.submit();
    });
    $(".confirm").click(function(e){
        if (!confirm('Вы действительно хотите удалить параметр?')){
            e.preventDefault();
        }
    });
</script>