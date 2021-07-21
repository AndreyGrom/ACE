<h2>Форма "{$form['name']}"</h2>

<a class="btn btn-info btn-xs" href="?c=mailforms&fid={$form['id']}&act=field-add"><span class="glyphicon glyphicon-plus"></span> Добавить поле</a>
<a class="btn btn-info btn-xs" href="?c=mailforms&fid={$form['id']}&act=template"><span class="glyphicon glyphicon-picture"></span> Дизайн формы</a>
<br/><br/>
{if $fields}
    <div class="alert alert-info">
        <p>При изменении/добавлении полей, не забудьте перестроить шаблон формы на странице <a href="?c=mailforms&fid={$form['id']}&act=template"><span class="glyphicon glyphicon-picture"></span> Дизайн формы</a></p>
    </div>
    <table class="table table-striped table-hover">
        <tr>
            <th>Имя</th>
            <th>Тип</th>
            <th>Подсказка</th>
            <th>Обязательное</th>
            <th></th>
        </tr>
        {section name=i loop=$fields}
        <tr>
            <td>{$fields[i].name}</td>
            <td>{$fields[i].type}</td>
            <td>{$fields[i].placeholder}</td>
            <td>{if $fields[i].required == 1}Да{else}Нет{/if}</td>
            <td>
                <a href="?c=mailforms&fid={$form['id']}&id={$fields[i].id}" class="btn btn-primary btn-xs"><span class="glyphicon glyphicon-pencil"></span></a>
                <a href="?c=mailforms&fid={$form['id']}&id={$fields[i].id}&act=del-field" class="btn btn-danger btn-xs confirm"><span class="glyphicon glyphicon-remove"></span></a>
            </td>
        </tr>
        {/section}
    </table>
    <script>
        $('.confirm').click(function(e){
            if (!confirm('Вы уверены, что хотите выполнить данное действие?')){
                e.preventDefault();
            }
        });

    </script>
{/if}