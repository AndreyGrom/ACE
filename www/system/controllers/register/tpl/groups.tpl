<h3>Группы пользователей
<div class="pull-right">
    <a class="btn btn-primary btn-xs" href="?c=register&act=groups&act2=add"><span class="glyphicon glyphicon-plus"></span></a>
</div>
</h3>

<table class="table table-striped">
    <tr>
        <th>ID</th>
        <th>Группа</th>
        <th>Иконка</th>
        <th>Пользователей</th>
        <th>Действия</th>
    </tr>
    {section name=i loop=$groups}
        <tr>
            <td>{$groups[i].GROUP_ID}</td>
            <td>{$groups[i].GROUP_NAME}</td>
            <td>
                {if $groups[i].GROUP_ICON}
                    <img class="img-responsive" src="{$groups[i].GROUP_ICON}" alt=""/>
                {/if}
            </td>
            <td>{$groups[i].CNT}</td>
            <td>
                {if $groups[i].GROUP_ID > 5}
                <a class="btn btn-success btn-xs" data-original-title="Редактировать группу" title="" data-toggle="tooltip" href="?c=register&act=groups&id={$groups[i].GROUP_ID}">
                    <span class="glyphicon glyphicon-pencil"></span>
                </a>
                <a class="btn btn-danger btn-xs del-user" data-original-title="Удалить группу" title="" data-toggle="tooltip" href="?c=register&act=groups&act2=del&id={$groups[i].GROUP_ID}">
                    <span class="glyphicon glyphicon-remove"></span>
                </a>
                {/if}
            </td>
        </tr>
    {/section}
</table>
<script>
    $(".del-user").click(function(e){
        if (!confirm("Вы действительно хотите удалить группу?")){
            e.preventDefault();
        }
    });
</script>