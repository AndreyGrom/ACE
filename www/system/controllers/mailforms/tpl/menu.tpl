<div class="panel-group hidden-sm hidden-xs" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="collapseListGroupHeading1">
            <h4 class="panel-title">
                <span class="glyphicon glyphicon-envelope"></span>
                <a class="" data-toggle="collapse" href="#collapseListGroup1" aria-expanded="true"
                   aria-controls="collapseListGroup1">Почтовые формы</a>
                <span class="caret"></span>
                <a class="btn btn-info btn-xs" data-target="" data-toggle="tooltip" href="?c=mailforms&act=new">
                    <span class="glyphicon glyphicon-plus"></span>
                    Создать форму
                </a>

            </h4>
        </div>
        <div id="collapseListGroup1" class="panel-collapse collapse in" role="tabpanel"
             aria-labelledby="collapseListGroupHeading1" aria-expanded="true">
            {if ($forms)}
                <ul class="nav">
                    {section name=i loop=$forms}
                        <li>
                            <a href="?c=mailforms&fid={$forms[i].id}" data-toggle="tooltip"><span class="glyphicon glyphicon-text-size btn-xs"></span> {$forms[i].name}</a>
                        </li>
                    {/section}
                </ul>
            {else}
                <br/>
                <ul>Нет созданных форм</ul>
                <br/>
            {/if}
        </div>
    </div>
</div>