
<h1>Курсы</h1>
<hr/>
{if $items}
    {if $num_pages > 1}
        <div class="col-sm-6">
            <ul class="pagination" style="margin: 0">
                {section name=i loop = $num_pages}
                    <li><a href="?c=catalog&act=courses&p={$smarty.section.i.index+1}">{$smarty.section.i.index+1}</a></li>
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
            <th>Сеть/Школа</th>
            <th style="width: 144px;">Действия</th>
        </tr>
    {section name=i loop=$items}
        <tr>
            <td>{$items[i].ID}</td>
            <td><a href="?c=catalog&act=course&id={$items[i].ID}">{$items[i].TITLE}</a></td>
            <td><a href="?c=catalog&id={$items[i].S_ID}">{$items[i].S_TITLE}</a></td>
            <td>
                <a class="btn btn-primary btn-mini" data-original-title="Копировать" title="Копировать" data-toggle="tooltip" href="?c=catalog&act=copy-course&id={$items[i].ID}">
                    <span class="glyphicon glyphicon-copy"></span>
                </a>

                <a class="btn btn-danger btn-mini confirm" data-original-title="" title="Удалить курс" data-toggle="tooltip" href="?c=catalog&act=del-course&id={$items[i].ID}">
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
                    <li><a href="?c=catalog&act=courses&p={$smarty.section.i.index+1}">{$smarty.section.i.index+1}</a></li>
                {/section}
            </ul>
        </div>
    {/if}
    <div class="{if $num_pages > 1}col-sm-6{else}col-sm-12{/if} text-right">
        <p style="margin-top: 10px;">Показано материалов: {$start}-{$items_count+$start-1} из {$total}</p>
    </div>
{else}
    Материалов в данной категории нет
{/if}
<a class="btn btn-primary" href="?c=catalog&act=course">Добавить курс</a>
<script>
    $(".confirm").click(function(e){
        if (!confirm("Вы уверенны что хотите это сделать??")){
            e.preventDefault();
        }
    });
</script>