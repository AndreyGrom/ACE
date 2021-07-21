

<div class="clearfix">
    <a class="btn btn-primary" href="?c=news&act=new"><span class="glyphicon glyphicon-plus"></span> Добавить новость</a>
</div>
<hr/>

{if $items}
    {if $num_pages > 1}
        <div class="col-sm-6">
            <ul class="pagination" style="margin: 0">
                {section name=i loop = $num_pages}
                    <li><a href="?c=news&p={$smarty.section.i.index+1}">{$smarty.section.i.index+1}</a></li>
                {/section}
            </ul>
        </div>
    {/if}
    <div class="{if $num_pages > 1}col-sm-6{else}col-sm-12{/if} text-right">
        <p style="margin-top: 10px;">Показано материалов: {$start}-{$items_count+$start-1} из {$total}</p>
    </div>

    <table class="table table-striped">
        <tr>
            <th>ID</th>
            <th>Название</th>
            <th>Краткое описание</th>
            <th>Статус</th>
            <th>Действия</th>
        </tr>
    {section name=i loop=$items}
        <tr>
            <td>{$items[i].ID}</td>
            <td><a href="?c=news&id={$items[i].ID}">{$items[i].TITLE}</a></td>
            <td>{$items[i].SHORT_CONTENT}</td>
            <td>
                {if $items[i].PUBLIC==1}
                    <span class="glyphicon glyphicon-ok text-success"></span>
                {else}
                    <span class="glyphicon glyphicon-minus text-danger">Не опубликовано</span>
                {/if}
            </td>
            <td>
                <a target="_blank" class="btn btn-primary btn-mini" data-original-title="Перейти к материалу" title="" data-toggle="tooltip" href="/news/{$items[i].ALIAS}">
                    <span class="glyphicon glyphicon-share-alt"></span>
                </a>
                <a class="btn btn-success btn-mini" data-original-title="Редактировать материал" title="" data-toggle="tooltip" href="?c=news&id={$items[i].ID}">
                    <span class="glyphicon glyphicon-pencil"></span>
                </a>
                <a class="btn btn-danger btn-mini del-item" data-original-title="Материал будет полностью удален" title="" data-toggle="tooltip" href="?c=news&act=del-item&id={$items[i].ID}">
                    <span class="glyphicon glyphicon-remove"></span>
                </a>
            </td>
        </tr>
    {/section}
    </table>
    {if $num_pages > 1}
        <div class="col-sm-6">
            <ul class="pagination" style="margin: 0">
                {section name=i loop = $num_pages}
                    <li><a href="?c=news&p={$smarty.section.i.index+1}">{$smarty.section.i.index+1}</a></li>
                {/section}
            </ul>
        </div>
    {/if}
    <div class="{if $num_pages > 1}col-sm-6{else}col-sm-12{/if} text-right">
        <p style="margin-top: 10px;">Показано материалов: {$start}-{$items_count+$start-1} из {$total}</p>
    </div>
{else}
    Новостей нет
{/if}
<script>
    $(".confirm").click(function(e){
        if (!confirm("Вы уверенны что хотите это сделать??")){
            e.preventDefault();
        }
    });
</script>