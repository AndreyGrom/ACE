<div class="panel-group {*hidden-sm hidden-xs*}" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="collapseListGroupHeading1">
            <h4 class="panel-title">
                <span class="glyphicon glyphicon-th-list"></span>
                <a class="" data-toggle="collapse" href="#collapseListGroup1" aria-expanded="true"
                   aria-controls="collapseListGroup1">Дополнительные услуги</a>
                <span class="caret"></span>

            </h4>
            <br/>
            <a class="btn btn-info btn-xs" data-target="" data-toggle="tooltip" href="?c=services&act=new_c">
                <span class="glyphicon glyphicon-plus"></span>
                Создать категорию
            </a>
            <a class="btn btn-info btn-xs" data-target="" data-toggle="tooltip" href="?c=services&id=0">
                <span class="glyphicon glyphicon-plus"></span>
                Добавить страницу
            </a>
            <a class="btn btn-info btn-xs" href="?c=services&act=settings"><span class="glyphicon glyphicon-cog"></span></a>
        </div>
        <div id="collapseListGroup1" class="panel-collapse collapse in" role="tabpanel"
             aria-labelledby="collapseListGroupHeading1" aria-expanded="true">
            {if ($menu)}
                {$menu}
            {/if}
        </div>
        <div class="panel-footer">
            <ul class="list-inline">
                <li> <a href="?c=services&act=visas">Визы</a></li>
                <li> <a href="?c=services&act=levels-g">Репетиторство</a></li>

            </ul>
        </div>
    </div>

</div>