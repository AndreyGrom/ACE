
<h1>Школы сети "{$item.TITLE}"</h1>
<hr/>
{if $items}


    <table class="table table-striped">
        <tr>
            <th>ID</th>

            <th>Школа</th>

        </tr>
    {section name=i loop=$items}
        <tr>
            <td>{$items[i].ID}</td>
            <td><a href="?c=catalog&id={$items[i].ID}">{$items[i].TITLE}</a></td>

        </tr>
    {/section}
    </table>

{else}
    Материалов в данной категории нет
{/if}
