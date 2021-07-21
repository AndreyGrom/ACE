
<h1>Что включено</h1>
<hr/>
{if $items}

    <table class="table table-striped">
        <tr>
            <th>ID</th>
            <th>Заголовок</th>
            <th>Иконка</th>
            <th style="width: 144px;">Действия</th>
        </tr>
        {section name=i loop=$items}
            <tr>
                <td>{$items[i].ID}</td>
                <td><a href="?c=catalog&act=inc&id={$items[i].ID}">{$items[i].TITLE}</a></td>
                <td>
                    {$items[i].ICON}
                </td>
                <td>


                    <a class="btn btn-danger btn-mini del-item" data-original-title="Материал будет полностью удален" title="" data-toggle="tooltip" href="?c=catalog&act=del-inc&id={$items[i].ID}">
                        <span class="glyphicon glyphicon-remove"></span>
                    </a>
                </td>
            </tr>
        {/section}
    </table>

{else}
    Материалов в данной категории нет
{/if}
<a class="btn btn-primary" href="?c=catalog&act=inc">Добавить</a>
<script>
    $(".confirm").click(function(e){
        if (!confirm("Вы уверенны что хотите это сделать??")){
            e.preventDefault();
        }
    });
</script>