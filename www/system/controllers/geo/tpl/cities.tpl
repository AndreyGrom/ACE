
<h1>Города региона {$items[0].REGION_NAME} страны {$items[0].COUNTRY_NAME} <a class="btn btn-primary pull-right" href="?c=geo&country-id={$items[0].COUNTRY_ID}">Назад</a></h1>
<hr/>
<a class="btn btn-primary" href="?c=geo&act=city&a-country-id={$country_id}&a-region-id={$region_id}">Добавить город</a>
<table class="table table-striped">
    <tr>
        <th>ID</th>
        <th>Город</th>
        <th style="width: 144px;">Действия</th>
    </tr>
    {section name=i loop=$items}
        <tr>
            <td>{$items[i].CITY_ID}</td>
            <td><a href="?c=geo&act=city&id={$items[i].CITY_ID}&a-region-id={$items[i].REGION_ID}&a-country-id={$items[i].COUNTRY_ID}">{$items[i].CITY_NAME}</a></td>
            <td>
                <a class="btn btn-danger btn-mini confirm" data-original-title="" title="Удалить город" data-toggle="tooltip" href="?c=geo&act=del-city&id={$items[i].CITY_ID}">
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