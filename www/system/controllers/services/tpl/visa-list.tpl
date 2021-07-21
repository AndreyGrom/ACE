
<h3>Типы виз для страны {$country.COUNTRY_NAME}</h3>
<hr/>


    <table class="table table-striped">
        <tr>
            <th>ID</th>
            <th>Тип</th>
            <th>Действия</th>

        </tr>
    {section name=i loop=$items}
        <tr>
            <td>{$items[i].ID}</td>
            <td><a href="?c=services&act=visa-add&cid={$country.COUNTRY_ID}&vid={$items[i].ID}">{$items[i].TYPE}</a></td>

            <td>

                <a class="btn btn-success btn-mini" data-original-title="Редактировать материал" title="" data-toggle="tooltip" href="?c=services&act=visa-add&cid={$country.COUNTRY_ID}&vid={$items[i].ID}">
                    <span class="glyphicon glyphicon-pencil"></span>
                </a>
                <a class="btn btn-danger btn-mini confirm" data-original-title="Материал будет полностью удален" title="" data-toggle="tooltip" href="?c=services&act=visa-del&cid={$country.COUNTRY_ID}&vid={$items[i].ID}">
                    <span class="glyphicon glyphicon-remove"></span>
                </a>
            </td>
        </tr>
    {/section}
    </table>


<a class="btn btn-primary" href="?c=services&act=visa-add&cid={$country.COUNTRY_ID}">Добавить тип визы</a>
<script>
    $(".confirm").click(function(e){
        if (!confirm("Вы уверенны что хотите это сделать??")){
            e.preventDefault();
        }
    });
</script>