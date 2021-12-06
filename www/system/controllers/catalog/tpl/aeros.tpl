
<h1>Аэропорты</h1>
<hr/>
{if $items}
    <table class="table table-striped">
        <tr>
            <th>ID</th>
            <th>Название</th>
            <th style="width: 144px;">Действия</th>
        </tr>
    {section name=i loop=$items}
        <tr>
            <td>{$items[i].ID}</td>
            <td><a href="?c=catalog&act=aero&id={$items[i].ID}">{$items[i].TITLE}</a></td>
            <td>
                <a class="btn btn-danger btn-mini confirm" data-original-title="" title="Удалить аэропорт" data-toggle="tooltip" href="?c=catalog&act=del-aero&id={$items[i].ID}">
                    <span class="glyphicon glyphicon-remove"></span>
                </a>
            </td>
        </tr>
    {/section}
    </table>
{else}
    Материалов в данной категории нет
{/if}
<a class="btn btn-primary" href="?c=catalog&act=aero&id=0">Добавить аэропорт</a>
<script>
    $(".confirm").click(function(e){
        if (!confirm("Вы уверенны что хотите это сделать??")){
            e.preventDefault();
        }
    });
</script>