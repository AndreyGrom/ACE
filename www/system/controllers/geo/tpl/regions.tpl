
<h1>Регионы страны {$country['COUNTRY_NAME']} <a class="btn btn-primary pull-right" href="?c=geo">Назад</a></h1>
<hr/>
<a class="btn btn-primary" href="?c=geo&act=region&a-country-id={$country['COUNTRY_ID']}">Добавить регион</a>
<table class="table table-striped">
    <tr>
        <th>ID</th>
        <th>Регион</th>
        <th style="width: 144px;">Действия</th>
    </tr>
    {section name=i loop=$items}
        <tr>
            <td>{$items[i].REGION_ID}</td>
            <td><a href="?c=geo&region-id={$items[i].REGION_ID}&a-country-id={$items[i].COUNTRY_ID}&a-region-id={$items[i].REGION_ID}">{$items[i].REGION_NAME}</a></td>
            <td>
                <a class="btn btn-success btn-mini" data-original-title="" title="Редактировать регион" data-toggle="tooltip" href="?c=geo&act=region&id={$items[i].REGION_ID}&a-country-id={$items[i].COUNTRY_ID}">
                    <span class="glyphicon glyphicon-pencil"></span>
                </a>
                <a class="btn btn-danger btn-mini confirm" data-original-title="" title="Удалить регион" data-toggle="tooltip" href="?c=geo&act=del-region&id={$items[i].REGION_ID}&a-country-id={$items[i].COUNTRY_ID}">
                    <span class="glyphicon glyphicon-remove"></span>
                </a>
            </td>
        </tr>
    {/section}
</table>
<script>
    $(".confirm").click(function(e){
        if (!confirm("Вы уверенны что хотите это сделать??")){
            e.preventDefault();
        }
    });
</script>