<h3>Способы доставки
    <div class="pull-right"><a class="btn btn-primary btn-xs" href="?c=shop&act=delivery&act2=add"><span class="glyphicon glyphicon-plus"></span></a></div>

</h3>
<hr/>
<table class="table table-hover">
    <tr>
        <th>Способ доставки</th>
        <th>Стоимость</th>
        <th>Действие</th>
    </tr>
    {section name=i loop=$deliverys}
        <tr>
            <td>{$deliverys[i].DELIVERY_NAME}</td>
            <td>{$deliverys[i].DELIVERY_PRICE}</td>
            <td>
                <a href="?c=shop&act=delivery&id={$deliverys[i].DELIVERY_ID}" class="btn btn-primary btn-xs"><span class="glyphicon glyphicon-pencil"></span></a>
                <a href="?c=shop&act=delivery&act2=del&id={$deliverys[i].DELIVERY_ID}" class="btn btn-danger btn-xs confirm"><span class="glyphicon glyphicon-remove"></span></a>

            </td>
        </tr>

    {/section}
</table>
<script>
    $(".confirm").click(function(e){
        if (!confirm('Вы действительно хотите удалить способ доставки?')){
            e.preventDefault();
        }
    });
</script>