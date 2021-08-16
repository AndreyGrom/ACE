
<h1>Популярные курсы</h1>
<hr/>
<a class="btn btn-primary" href="?c=home&act=popular&id=0">Добавить курс</a>
<hr/>
{if $items}

    <table class="table table-striped">
        <tr>
            <th>ID</th>
            <th>Курс</th>
            <th style="width: 144px;">Действия</th>
        </tr>
        {section name=i loop=$items}
            <tr>
                <td>{$items[i].ID}</td>
                <td>
                    <a href="?c=home&act=popular&id={$items[i].ID}">{$items[i].TITLE}</a>
                    <br>
                    <div class="help-block">Школа: {$items[i].SH_TITLE}</div>
                </td>
                <td>
                    <a class="btn btn-success btn-mini" data-original-title="Редактировать материал" title="" data-toggle="tooltip" href="?c=home&act=popular&id={$items[i].ID}">
                        <span class="glyphicon glyphicon-pencil"></span>
                    </a>
                    <a class="btn btn-danger btn-mini confirm" data-original-title="Материал будет полностью удален" title="" data-toggle="tooltip" href="?c=home&act=del-popular&id={$items[i].ID}">
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