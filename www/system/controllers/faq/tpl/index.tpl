
<h1>Вопросы и ответы</h1>
<hr/>
{if $items}

    <table class="table table-striped">
        <tr>
            <th>ID</th>
            <th>Вопрос</th>
            <th style="width: 144px;">Действия</th>
        </tr>
    {section name=i loop=$items}
        <tr>
            <td>{$items[i].ID}</td>
            <td><a href="?c=faq&act=item&id={$items[i].ID}">{$items[i].TITLE}</a></td>
            <td>
                <a class="btn btn-primary btn-mini" data-original-title="Редактировать" title="Редактировать" data-toggle="tooltip" href="?c=faq&id={$items[i].ID}">
                    <span class="glyphicon glyphicon-copy"></span>
                </a>

                <a class="btn btn-danger btn-mini confirm" data-original-title="" title="Удалить вопрос" data-toggle="tooltip" href="?c=faq&act=del&id={$items[i].ID}">
                    <span class="glyphicon glyphicon-remove"></span>
                </a>
            </td>
        </tr>
    {/section}
    </table>

{else}
    Материалов в данной категории нет
{/if}
<a class="btn btn-primary" href="?c=faq&act=item">Добавить вопрос</a>
<script>
    $(".confirm").click(function(e){
        if (!confirm("Вы уверенны что хотите это сделать??")){
            e.preventDefault();
        }
    });
</script>