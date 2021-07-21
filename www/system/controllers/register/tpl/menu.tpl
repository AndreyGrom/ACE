<div class="panel-group {*hidden-sm hidden-xs*}" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="module_{$module_name}_heading">
            <h4 class="panel-title">
                <span class="glyphicon glyphicon-user"></span>
                <a class="" data-toggle="collapse" href="#collapseListGroup1" aria-expanded="true"
                   aria-controls="collapseListGroup1">Пользователи сайта</a>
                <span class="caret"></span>

            </h4>

        </div>
        <div id="collapseListGroup1" class="panel-collapse collapse in" role="tabpanel"
             aria-labelledby="module_{$module_name}_heading" aria-expanded="true">
            <div class="row" style="padding-left: 16px; padding-top: 9px;">
                <div class="col-sm-12">
                    <a class="btn btn-info btn-xs" href="?c=register"><span class="glyphicon glyphicon-user"></span> Список пользователей</a>
                    <a class="btn btn-info btn-xs" href="?c=register&act=settings"><span class="glyphicon glyphicon-cog"></span> Настройки модуля</a>
                </div>
            </div>
            <div class="row" style="padding-left: 16px; padding-top: 9px;">
                <div class="col-sm-12">
                    <a class="btn btn-info btn-xs" href="?c=register&act=groups"><span class="glyphicon glyphicon-cog"></span> Группы пользователей</a>
                </div>
            </div>
            <br/>
        </div>
    </div>
</div>