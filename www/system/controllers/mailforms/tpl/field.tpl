<form id="page-form" action="" method="post">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title text-uppercase">
                <span class="glyphicon glyphicon-duplicate"></span>
                {if $new}Создание поля формы "{$form['name']}"{else}Редактирование поля формы "{$form['name']}"{/if}
                <div class="pull-right"><a class="bnt btn-xs btn-primary" href="?c=mailforms&fid={$form['id']}&act=fields"><span class="glyphicon glyphicon-arrow-left"></span> Назад к списку полей</a></div>
            </h3>
        </div>
        <div class="panel-body">
            <div class="form-horizontal">
                <div class="form-group">
                    <label for="field_name" class="col-sm-3 control-label">Название:</label>
                    <div class="col-sm-9">
                        <input required value="{$field['name']}" name="field_name" id="field_name" type="text" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label for="field_type" class="col-sm-3 control-label">Тип:</label>
                    <div class="col-sm-9">
                        <select class="form-control" name="field_type" id="field_type">
                            {section name=i loop=$types}
                                <option {if $types[i].type == $field['type']}selected="selected" {/if} value="{$types[i].type}">{$types[i].name}</option>
                            {/section}
                        </select>
                        <div {if $field['type']!=='radio' && $field['type'] !== 'textarea' && $field['type'] !== 'select'} style="display: none"{/if} class="field-options">
                            <p class="help-block">Введите значения. Каждое значение с новой строки</p>
<textarea class="form-control" name="field_options" id="options"" rows="5">
{section name=i loop=$field['options']}
{$field['options'][i]}
{/section}</textarea>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label for="field_placeholder" class="col-sm-3 control-label">Подсказка:</label>
                    <div class="col-sm-9">
                        <input value="{$field['placeholder']}" name="field_placeholder" id="field_placeholder" type="text" class="form-control" />
                    </div>
                </div>
                <div class="form-group text-left">
                    <label for="field_required" class="col-sm-3 control-label">Обязательное:</label>
                    <div class="col-sm-9">
                        <input {if $field['required']== 1}checked="checked" {/if} style="margin-top: 10px;" name="field_required" id="field_required" type="checkbox" class=""/>
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
 $("#field_type").change(function(){
     var type = $(this).val();
     if (type == 'select' || type == 'radio'){
         $(".field-options").show();
     } else {
         $(".field-options").hide();
         $("#options").val("");
     }
 });
</script>