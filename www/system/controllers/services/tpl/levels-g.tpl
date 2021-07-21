
<h1>Группы уровней репетиторов</h1>
<hr/>
{if $items}

    <table class="table table-striped">
        <tr>
            <th>ID</th>
            <th>Группа</th>
            <th>Уровни</th>
            <th style="width: 144px;">Действия</th>
        </tr>
    {section name=i loop=$items}
        <tr>
            <td>{$items[i].ID}</td>
            <td><a href="?c=services&act=level-g&id={$items[i].ID}">{$items[i].TITLE}</a></td>
            <td>
                <a href="?c=services&act=levels&gid={$items[i].ID}">
                    <span class="glyphicon glyphicon-pencil"></span>
                </a>
            </td>
            <td>

                <a class="btn btn-success btn-mini" data-original-title="Редактировать материал" title="" data-toggle="tooltip" href="?c=services&act=level-g&id={$items[i].ID}">
                    <span class="glyphicon glyphicon-pencil"></span>
                </a>
                <a class="btn btn-danger btn-mini confirm" data-original-title="Материал будет полностью удален" title="" data-toggle="tooltip" href="?c=services&act=del-level-g&id={$items[i].ID}">
                    <span class="glyphicon glyphicon-remove"></span>
                </a>
            </td>
        </tr>
    {/section}
    </table>

{else}
    Материалов в данной категории нет
{/if}
<a class="btn btn-primary" href="?c=services&act=level-g">Добавить группу уровней</a>
<script>
    $(".confirm").click(function(e){
        if (!confirm("Вы уверенны что хотите это сделать??")){
            e.preventDefault();
        }
    });
</script>