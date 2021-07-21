<form id="cat-form" action="" method="post" enctype="multipart/form-data">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title text-uppercase">
                <span class="glyphicon glyphicon-duplicate"></span>
                {if $new}Создание новой категории{else}Редактирование категории{/if}
                {if !$new}
                    <span class="pull-right text-lowercase">
                        <a href="?c=shop&act=new_c" class="btn btn-info btn-xs" data-toggle="tooltip" title="" data-original-title="Создать новую категорию"><span class="glyphicon glyphicon-copy"></span></a>
                        <a href="?c=shop&act=del&cid={$category_id}" class="btn btn-danger btn-xs confirm" data-toggle="tooltip" title="" data-original-title="Удалить категорию"><span class="glyphicon glyphicon-remove"></span></a>
                    </span>
                {/if}
            </h3>
        </div>
        <div class="panel-body">

            <!-- Форма для редактора -->
            <div class="form-horizontal" role="form">
                <div class="form-group">
                    <label for="c_title" class="col-sm-3 control-label">Название:</label>
                    <div class="col-sm-9">
                        <input required value="{$category_title}" name="c_title" id="c_title" type="text" class="form-control" placeholder="Введите название категории">
                    </div>
                </div>
                <div class="form-group">
                    <label for="c_desc" class="col-sm-3 control-label">Описание верхнее:</label>
                    <div class="col-sm-9">
                        <textarea name="c_desc" id="c_desc" cols="30" rows="5" class="form-control textarea-edit">{$category_desc}</textarea>
                    </div>
                </div>
                <div class="form-group">
                    <label for="c_desc" class="col-sm-3 control-label">Описание нижнее:</label>
                    <div class="col-sm-9">
                        <textarea name="c_desc2" id="c_desc2" cols="30" rows="5" class="form-control textarea-edit">{$category_desc2}</textarea>
                    </div>
                </div>
                <div class="form-group">
                    <label for="alias" class="col-sm-3 control-label">Алиас:</label>
                    <div class="col-sm-9">
                        <input value="{$category_alias}" name="alias" id="alias" type="text" class="form-control" placeholder="Только символы a-z, A-Z, 0-9, -_ " />
                        <p class="help-block">Только символы a-z, A-Z, 0-9, -_ <br/>
                            Можно оставить пустым. Заполнится автоматически</p>
                    </div>
                </div>
                <div class="form-group">
                    <label for="parent" class="col-sm-3 control-label">Уровень:</label>
                    <div class="col-sm-9">
                        <select name="parent" id="parent" class="form-control">
                            <option value="0">Верхний уровень</option>
                            {section name=i loop=$categories}
                                {if $categories[i].ID !== $category_id}
                                    <option {if $categories[i].ID==$category_parent}selected="selected"{/if} value="{$categories[i].ID}">{$categories[i].TITLE}</option>
                                {/if}
                            {/section}
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label for="template" class="col-sm-3 control-label">Изображение:</label>
                    <div class="col-sm-4">
                        <input name="image" id="image" type="file" class="" />
                        <input type="hidden" name="old_image" value="{$category_image}"/>
                        <p class="help-block">.jpg, .jpeg, .png, .gif</p>
                    </div>
                    <div class="col-sm-3">
                        {if $category_new_image}
                            <a class="fancybox" href="{$category_image}">
                                <img src="{$category_new_image}" alt=""/>
                            </a>
                            <br/>
                            <label><input name="delete_image" type="checkbox"/> Удалить</label>
                        {/if}
                    </div>
                </div>
                <div class="form-group">
                    <label for="template" class="col-sm-3 control-label">Шаблон:</label>
                    <div class="col-sm-9">
                        <select name="template" id="template" class="form-control">
                            {section name=i loop=$templates}
                                <option {if $templates[i]==$category_template}selected="selected" {/if} value="{$templates[i]}">{$templates[i]}</option>
                            {/section}
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label for="publ" class="col-sm-3 control-label">Публикация:{$category_publ}</label>
                    <div class="col-sm-9">
                        <label><input type="radio" name="publ" id="publ" value="1" {if $category_publ==1 || $new}checked="checked"{/if} /> Сразу</label>
                        <label><input {if !$new && $category_publ==0}checked="checked"{/if} type="radio" name="publ" value="0" /> Позже</label>
                    </div>
                </div>
            </div>

            <div class="form-horizontal" role="form">
                <div class="form-group">
                    <label for="" class="col-sm-3 control-label">Meta-description:</label>
                    <div class="col-sm-9">
                        <input value="{$category_meta_desc}" name="meta_description" type="text" class="form-control" />
                    </div>
                </div>
                <div class="form-group">
                    <label for="" class="col-sm-3 control-label">Meta-keywords:</label>
                    <div class="col-sm-9">
                        <input value="{$category_meta_keywords}" name="meta_keywords" type="text" class="form-control" />
                    </div>
                </div>
            </div>

            <div class="text-right">
                <button type="submit" class="btn btn-success btn-large"><span class="glyphicon glyphicon-floppy-disk"></span> Сохранить</button>
            </div>

        </div>
    </div>
</form>
<script type="text/javascript" src="{$html_plugins_dir}init_mce.js"></script>
<script>
/*    {literal}
    $(document).ready(function(){
        $.cleditor.set_rfm('/filemanager');
        var  controls=
                "bold italic underline strikethrough subscript superscript | font size " +
                        "style | color highlight removeformat | bullets numbering | outdent " +
                        "indent | alignleft center alignright justify | " +
                        "rule image link unlink | source";
        $("#c_desc").cleditor({'controls':controls});
        $("#c_desc2").cleditor({'controls':controls});
    });
    {/literal}*/

    var alias_page_new = false;
    if ($("#alias").val()==''){
        alias_page_new = true;
    }
    $("#c_title").change(function(){
        if (alias_page_new){
            var str = $(this).val();
            var str2 = SetTranslitRuToLat(str);
            $("#alias").val(str2);
        }
    });
    $("#cat-form").submit(function(){
        var alias_page = $(this).find("input[name='alias']").val();
        var pattern = /^[a-z0-9_-]+$/i;
        if (alias_page !='' && !pattern.test(alias_page)){
            alert('Алиас содержит недопустимые символы');
            return false;
        }
    });
    $(".confirm").click(function(e){
        if (!confirm("Вы уверенны что хотите это сделать??")){
            e.preventDefault();
        }
    });
</script>