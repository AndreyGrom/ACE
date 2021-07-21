<form id="page-form" action="" method="post">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title text-uppercase">
                <span class="glyphicon glyphicon-envelope"></span>
                {if $new}Создание новой формы{else}Редактирование формы "{$form_name}"{/if}
                {if !$new}
                    <span class="pull-right text-lowercase">
                            <a href="?c=mailforms&act=new" class="btn btn-info btn-xs" data-toggle="tooltip" title="" data-original-title="Создать новую форму"><span class="glyphicon glyphicon-copy"></span></a>
                        {if $page_id!=1}
                            <a href="?c=mailforms&act=del-form&fid={$form_id}" class="btn btn-danger btn-xs confirm" data-toggle="tooltip" title="" data-original-title="Удалить форму"><span class="glyphicon glyphicon-remove"></span></a>
                        {/if}
                    </span>
                {/if}
            </h3>
        </div>
        <div class="panel-body">
            {if !$new}
                <a class="btn btn-info btn-xs" href="?c=mailforms&fid={$form_id}&act=fields">Поля формы</a>
                <a class="btn btn-info btn-xs" href="?c=mailforms&fid={$form_id}&act=template">Шаблон формы</a>
                <hr/>
                <div class="alert alert-info">
                    <p>Код вызова формы: <input onclick="this.select()" class="form-control" style="display:inline-block;width: 270px" type="text" readonly value='[widjet name="mail_form" params="{$form_id}"]'/></p>
                </div>
            {/if}
            <div class="form-horizontal">
                <div class="form-group">
                    <label for="form_name" class="col-sm-3 control-label">Название:</label>
                    <div class="col-sm-9">
                        <input required value="{$form_name}" name="form_name" id="form_name" type="text" class="form-control" placeholder="Введите название формы">
                    </div>
                </div>
                <div class="form-group">
                    <label for="email_1" class="col-sm-3 control-label">Email 1:</label>
                    <div class="col-sm-9">
                        <input required value="{$form_email_1}" name="email_1" id="email_1" type="email" class="form-control" />
                    </div>
                </div>
                <div class="form-group">
                    <label for="email_2" class="col-sm-3 control-label">Email 2:</label>
                    <div class="col-sm-9">
                        <input value="{$form_email_2}" name="email_2" id="email_2" type="email" class="form-control" />
                    </div>
                </div>
                <div class="form-group text-left">
                    <label for="captcha" class="col-sm-3 control-label">Капча:</label>
                    <div class="col-sm-9">
                        <input {if $form_captcha == 1}checked="checked" {/if} style="margin-top: 10px;" name="captcha" id="captcha" type="checkbox" class=""/>
                    </div>
                </div>
            </div>

            <div class="form-horizontal">
                <div class="form-group">
                    <label for="form_success_message" class="col-sm-12">Сообщение после успешной отправки:</label>
                    <div class="col-sm-12">

                        <textarea name="form_success_message" id="form_success_message" style="width:100%;height:100px;">{$form_success_message}</textarea>

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
    $('.confirm').click(function(e){
        if (!confirm('Вы уверены, что хотите выполнить данное действие?')){
            e.preventDefault();
        }
    });

</script>