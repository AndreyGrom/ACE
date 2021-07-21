<div class="panel-group {*hidden-sm hidden-xs*}" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="collapseListGroupHeading1">
            <h4 class="panel-title">
                <span class="glyphicon glyphicon-shopping-cart"></span>
                <a class="" data-toggle="collapse" href="#collapseListGroup1" aria-expanded="true"
                   aria-controls="collapseListGroup1">Категории магазина</a>
                <span class="caret"></span>

            </h4>
            <br/>
            <a class="btn btn-info btn-xs" data-target="" data-toggle="tooltip" href="?c=shop&act=new_c">
                <span class="glyphicon glyphicon-plus"></span>
                Создать категорию
            </a>
            <a class="btn btn-info btn-xs" data-target="" data-toggle="tooltip" href="?c=shop&act=new">
                <span class="glyphicon glyphicon-plus"></span>
                Добавить материал
            </a>
            <a class="btn btn-info btn-xs" href="?c=shop&act=settings"><span class="glyphicon glyphicon-cog"></span></a>
        </div>
        <div id="collapseListGroup1" class="panel-collapse collapse in" role="tabpanel"
             aria-labelledby="collapseListGroupHeading1" aria-expanded="true">
            {if ($menu)}
                {$menu}
            {/if}
        </div>
        <div class="panel-footer">
            <ul class="list-inline">
                <li><a href="?c=shop&act=manufacturer">Производители</a></li>
                <li><a href="?c=shop&act=options">Опции</a><li>
                <li><a href="?c=shop&act=delivery">Доставка</a><li>
                <li><a href="?c=shop&act=import">Импорт</a><li>
                <li><a href="?c=shop&act=pays">Способы оплаты</a><li>
            </ul>
        </div>
    </div>
</div>