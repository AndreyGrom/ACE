
<h1>Заказы</h1>
<hr/>
{if $items}

    <table class="table table-striped">
        <tr>
            <th>ID</th>
            <th>№</th>
            <th>Дата</th>
            <th>Статус</th>
            <th style="width: 144px;">Действия</th>
        </tr>
    {section name=i loop=$items}
        <tr>
            <td>{$items[i].ID}</td>
            <td><a href="?c=orders&act=item&id={$items[i].ID}">{$config->OrderPref}{$items[i].ID}</a></td>
            <td>{$items[i].DATE}</td>
            <td>
                {if $items[i].STATUS == 0}
                    Не оплачен
                {elseif $items[i].STATUS == 1}
                    Оплачен
                {/if}
            </td>
            <td>
                <a class="btn btn-primary btn-mini" data-original-title="Редактировать" title="Редактировать" data-toggle="tooltip" href="?c=orders&act=item&id={$items[i].ID}">
                    <span class="glyphicon glyphicon-pencil"></span>
                </a>

                <a class="btn btn-danger btn-mini confirm" data-original-title="" title="Удалить вопрос" data-toggle="tooltip" href="?c=orders&act=del&id={$items[i].ID}">
                    <span class="glyphicon glyphicon-remove"></span>
                </a>
            </td>
        </tr>
    {/section}
    </table>

{else}
    Материалов в данной категории нет
{/if}

<script>
    $(".confirm").click(function(e){
        if (!confirm("Вы уверенны что хотите это сделать??")){
            e.preventDefault();
        }
    });
</script>