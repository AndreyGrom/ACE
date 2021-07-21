
<h1>Страны</h1>
<a class="btn btn-primary" href="?c=geo&act=country">Добавить страну</a>
<hr/>

<table class="table table-striped">
    <tr>
        <th>ID</th>
        <th>Страна</th>
        <th>Валюта</th>
        <th style="width: 144px;">Действия</th>
    </tr>
    {section name=i loop=$items}
        <tr>
            <td>{$items[i].COUNTRY_ID}</td>
            <td><a href="?c=geo&country-id={$items[i].COUNTRY_ID}">{$items[i].COUNTRY_NAME}</a></td>
            <td>{if $items[i].C_CURRENCY} {$items[i].C_ZN} ({$items[i].C_CURRENCY_N}){/if}</td>
            <td>
                <a class="btn btn-success btn-mini" data-original-title="" title="Редактировать страну" data-toggle="tooltip" href="?c=geo&act=country&id={$items[i].COUNTRY_ID}">
                    <span class="glyphicon glyphicon-pencil"></span>
                </a>
                <a class="btn btn-danger btn-mini confirm" data-original-title="" title="Удалить страну" data-toggle="tooltip" href="?c=geo&act=del-country&id={$items[i].COUNTRY_ID}">
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