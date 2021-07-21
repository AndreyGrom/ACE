
<form id="page-form" action="" method="post">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title text-uppercase">
                <span class="glyphicon glyphicon-cog"></span> Добавление новой группы пользователей
                <div class="pull-right">
                    <a class="btn btn-primary btn-xs" href="?c=register&act=groups"><span class="glyphicon glyphicon-arrow-left"></span></a>
                    <button type="submit" class="btn btn-success btn-xs"><span class="glyphicon glyphicon-floppy-disk"></span> Сохранить</button>
                </div>
            </h3>
        </div>
        <div class="panel-body">
            <div class="form-horizontal">
                <div class="form-group">
                    <label class="col-sm-3 control-label">Название:</label>
                    <div class="col-sm-9">
                        <input required value="{$group.GROUP_NAME}" name="GROUP_NAME" type="text" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">Иконка:</label>
                    <div class="col-sm-8">
                        <input value="{$group.GROUP_ICON}" name="GROUP_ICON" id="GROUP_ICON" type="text" class="form-control">
                        <div class="help-block">Нужно указать ссылку на иконку или выбрать из списка ниже</div>
                    </div>
                    <div class="col-sm-1"><img src="" id="GROUP_ICON_VIEW" alt=""/></div>
                </div>
                <div class="form-group">
                    <div class="col-sm-3"></div>
                    <div class="col-sm-9">
                        <ul class="list-inline" id="icon-list">
                            <li><img src="{$html_controllers_dir}register/res/img/admin.gif" alt=""/></li>
                            <li><img src="{$html_controllers_dir}register/res/img/banned.png" alt=""/></li>
                            <li><img src="{$html_controllers_dir}register/res/img/moder.gif" alt=""/></li>
                            {section name=i loop=$icons}
                            <li><img src="{$icons[i]}" alt=""/></li>
                            {/section}
                        </ul>
                    </div>
                    <script>
                        $("#GROUP_ICON").change(function(){
                            var url = $(this).val();
                            $("#GROUP_ICON_VIEW").attr("src",url);
                            console.log(url);
                        });
                        $("#icon-list li img").click(function(){
                            var url = $(this).attr("src");
                            $("#GROUP_ICON").val(url);
                            $("#GROUP_ICON").change();
                        });
                    </script>
                </div>
            </div>
        </div>
    </div>
</form>