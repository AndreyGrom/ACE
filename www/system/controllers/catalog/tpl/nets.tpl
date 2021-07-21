
<h1>Сети школ</h1>
<hr/>
{if $items}
    {if $num_pages > 1}
        <div class="col-sm-6">
            <ul class="pagination" style="margin: 0">
                {section name=i loop = $num_pages}
                    <li><a href="?c=catalog&act=nets&p={$smarty.section.i.index+1}">{$smarty.section.i.index+1}</a></li>
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
            <th style="width: 144px;">Действия</th>
        </tr>
    {section name=i loop=$items}
        <tr>
            <td>{$items[i].ID}</td>
            <td><a href="?c=catalog&act=net-list&id={$items[i].ID}">{$items[i].TITLE}</a></td>

            <td>
               {* <a target="_blank" class="btn btn-primary btn-mini" data-original-title="Перейти к материалу" title="" data-toggle="tooltip" href="/catalog/{$items[i].ALIAS}">
                    <span class="glyphicon glyphicon-share-alt"></span>
                </a>*}
                <a class="btn btn-success btn-mini" data-original-title="Редактировать материал" title="" data-toggle="tooltip" href="?c=catalog&act=net&id={$items[i].ID}">
                    <span class="glyphicon glyphicon-pencil"></span>
                </a>
                <a class="btn btn-danger btn-mini del-item" data-original-title="Материал будет полностью удален" title="" data-toggle="tooltip" href="?c=catalog&act=nets&act2=del-net&id={$items[i].ID}">
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
                    <li><a href="?c=catalog&act=nets&p={$smarty.section.i.index+1}">{$smarty.section.i.index+1}</a></li>
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
<a class="btn btn-primary" href="?c=catalog&act=nets&id=0">Добавить сеть</a>
<script>
    $(".confirm").click(function(e){
        if (!confirm("Вы уверенны что хотите это сделать??")){
            e.preventDefault();
        }
    });
</script>