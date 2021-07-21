<h3>Пользователи сайта</h3>
{if $users}
    <div class="col-sm-6">
        {$pagination}
    </div>
    <div class="{if $pagination}col-sm-6{else}col-sm-12{/if} text-right">
        <p style="margin-top: 10px;">Показано пользователей: {$start}-{$items_count+$start-1} из {$total}</p>
    </div>

    <table class="table table-striped">
        <tr>
            <th>ID</th>
            <th>E-mail</th>
            <th>Регистрация</th>
            <th>Активность</th>
            <th>Действия</th>
        </tr>
        {section name=i loop=$users}
            <tr>
                <td>{$users[i].ID}</td>
                <td><a href="?c=register&id={$users[i].ID}">{$users[i].EMAIL}</a></td>
                <td>{$users[i].DATE_CREATE}</td>
                <td>{$users[i].DATE_ACTIVE}</td>
                <td>
                    <a class="btn btn-success btn-xs" data-original-title="Редактировать данные пользователя" title="" data-toggle="tooltip" href="?c=register&id={$users[i].ID}">
                        <span class="glyphicon glyphicon-pencil"></span>
                    </a>
                    <a class="btn btn-danger btn-xs del-user" data-original-title="Удалить пользователя" title="" data-toggle="tooltip" href="?c=register&act=del&id={$users[i].ID}">
                        <span class="glyphicon glyphicon-remove"></span>
                    </a>
                </td>
            </tr>
        {/section}
    </table>
    <div class="col-sm-6">
        {$pagination}
    </div>
    <div class="{if $pagination}col-sm-6{else}col-sm-12{/if} text-right">
        <p style="margin-top: 10px;">Показано пользователей: {$start}-{$items_count+$start-1} из {$total}</p>
    </div>
    <script>
        $(".del-user").click(function(e){
            if (!confirm("Вы действительно хотите удалить пользователя?")){
                e.preventDefault();
            }
        });
    </script>
{else}
    Пользователей нет
{/if}
