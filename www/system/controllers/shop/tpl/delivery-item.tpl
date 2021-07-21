<form method="post">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title">
                {if $smarty.get.id}
                    <span class="glyphicon glyphicon-pencil"></span> Редактирование способа доставки
                {else}
                    <span class="glyphicon glyphicon-plus"></span> Добавление способа доставки
                {/if}
                <div class="pull-right"><a class="btn btn-primary btn-xs" href="?c=shop&act=delivery"><span class="glyphicon glyphicon-arrow-left"></span></a></div>
                <div class="clearfix"></div>
            </h3>
        </div>
        <div class="panel-body">
            <div class="form-horizontal" role="form">
                <div class="form-group">
                    <label class="col-sm-3 control-label"><span class="text-danger">*</span> Название:</label>
                    <div class="col-sm-9">
                        <input required value="{$delivery.DELIVERY_NAME}" name="DELIVERY_NAME" type="text" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">Описание:</label>
                    <div class="col-sm-9">
                        <textarea name="DELIVERY_DESC" id="" cols="30" rows="10" class="form-control">{$delivery.DELIVERY_DESC}</textarea>
                    </div>
                </div>
                <div class="form-group">
                    <label for="" class="col-sm-3 control-label">Стоимость:</label>
                    <div class="col-sm-9">
                        <input value="{$delivery.DELIVERY_PRICE}" name="DELIVERY_PRICE" type="number" class="form-control" />
                    </div>
                </div>
            </div>
            <div class="text-right">
                <button type="submit" class="btn btn-success btn-large"><span class="glyphicon glyphicon-floppy-disk"></span> Сохранить</button>
            </div>
        </div>
    </div>
</form>