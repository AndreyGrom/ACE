<form id="page-form" action="" method="post">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title text-uppercase">
                <span class="glyphicon glyphicon-cog"></span> Изменение данных пользователя
                <div class="pull-right">
                    <a class="btn btn-primary btn-xs" href="?c=register"><span class="glyphicon glyphicon-arrow-left"></span></a>
                    <button type="submit" class="btn btn-success btn-xs"><span class="glyphicon glyphicon-floppy-disk"></span> Сохранить</button>
                </div>
            </h3>
        </div>
        <div class="panel-body">
            <div class="form-horizontal">
                <div class="form-group">
                    <label class="col-sm-3 control-label">Группа:</label>
                    <div class="col-sm-9">
                        <select name="group_id" id="" class="form-control">
                            {section name=i loop=$groups}
                                <option {if $groups[i].GROUP_ID == $user.GROUP_ID} selected="selected" {/if}value="{$groups[i].GROUP_ID}">{$groups[i].GROUP_NAME}</option>
                            {/section}
                        </select>
                    </div>
                </div>
                <hr/>

                <div class="form-group">
                    <label class="col-sm-3 control-label">Email:</label>
                    <div class="col-sm-9">
                        <input required value="{$user.EMAIL}" name="email" type="email" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">Пароль:</label>
                    <div class="col-sm-9">
                        <input required value="{$user.PASSWORD}" name="password" type="text" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">Телефон:</label>
                    <div class="col-sm-9">
                        <input required value="{$user.PHONE}" name="phone" type="tel" class="form-control">
                    </div>
                </div>



            </div>
        </div>
    </div>
</form>