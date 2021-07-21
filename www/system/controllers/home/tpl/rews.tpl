
<h1>Что о нас говорят</h1>
<hr/>
<div class="pull-right">
    <a class="btn btn-primary" href="?c=home&act=rews&id={if $smarty.get.id}{$smarty.get.id}{else}0{/if}">Добавить отзыв</a>
</div>
<div class="clearfix"></div>
<hr/>
{if $items}


    <table class="table table-striped">
        <tr>
            <th>ID</th>
            <th>Имя</th>
            <th style="width: 144px;">Действия</th>
        </tr>
        {section name=i loop=$items}
            <tr>
                <td>{$items[i].ID}</td>
                <td>
                    <a href="?c=home&act=rews&id={$smarty.get.id}&id={$items[i].ID}">
                        {$items[i].TITLE}
                    </a>
                </td>
                <td>
                    <a class="btn btn-success btn-mini" data-original-title="Редактировать материал" title="" data-toggle="tooltip" href="?c=home&act=rews&id={$smarty.get.id}&id={$items[i].ID}">
                        <span class="glyphicon glyphicon-pencil"></span>
                    </a>
                    <a class="btn btn-danger btn-mini confirm" data-original-title="Материал будет полностью удален" title="" data-toggle="tooltip" href="?c=home&act=del-rews&id={$smarty.get.id}&aid={$items[i].ID}">
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