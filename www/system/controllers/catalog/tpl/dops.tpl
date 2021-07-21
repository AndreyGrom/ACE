
<h1>Дополнительные расходы</h1>
<hr/>
{if $items}

    <table class="table table-striped">
        <tr>
            <th>ID</th>
            <th>Название</th>
            <th>Тип</th>
            <th style="width: 144px;">Действия</th>
        </tr>
        {section name=i loop=$items}
            <tr>
                <td>{$items[i].ID}</td>
                <td><a href="?c=catalog&act=dop&id={$items[i].ID}">{$items[i].TITLE}</a></td>
                <td>
                    {if $items[i].TYPE == 0}
                       Обязательный
                    {elseif $items[i].TYPE == 1}
                        На выбор
                    {elseif $items[i].TYPE == 2}
                        Не включенный
                    {/if}
                </td>
                <td>
                    {* <a target="_blank" class="btn btn-primary btn-mini" data-original-title="Перейти к материалу" title="" data-toggle="tooltip" href="/catalog/{$items[i].ALIAS}">
                         <span class="glyphicon glyphicon-share-alt"></span>
                     </a>*}

                    <a class="btn btn-danger btn-mini del-item" data-original-title="Материал будет полностью удален" title="" data-toggle="tooltip" href="?c=catalog&act=del-dop&id={$items[i].ID}">
                        <span class="glyphicon glyphicon-remove"></span>
                    </a>
                </td>
            </tr>
        {/section}
    </table>

{else}
    Материалов в данной категории нет
{/if}
<a class="btn btn-primary" href="?c=catalog&act=dop">Добавить расход</a>
<script>
    $(".confirm").click(function(e){
        if (!confirm("Вы уверенны что хотите это сделать??")){
            e.preventDefault();
        }
    });
</script>