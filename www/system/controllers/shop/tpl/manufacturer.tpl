<h3>Производители
    <div class="pull-right"><a class="btn btn-primary btn-xs" href="?c=shop&act=manufacturer&act2=add"><span class="glyphicon glyphicon-plus"></span></a></div>

</h3>
<hr/>
<table class="table table-hover">
    <tr>
        <th>Производитель</th>
        <th>Действие</th>
    </tr>
    {section name=i loop=$manufacturers}
    <tr>
        <td>{$manufacturers[i].MANUFACTURER_NAME}</td>
        <td>
            <a href="?c=shop&act=manufacturer&id={$manufacturers[i].MANUFACTURER_ID}" class="btn btn-primary btn-xs"><span class="glyphicon glyphicon-pencil"></span></a>
            <a href="?c=shop&act=manufacturer&act2=del&id={$manufacturers[i].MANUFACTURER_ID}" class="btn btn-danger btn-xs confirm"><span class="glyphicon glyphicon-remove"></span></a>

        </td>
    </tr>

    {/section}
</table>
<script>
    $(".confirm").click(function(e){
        if (!confirm('Вы действительно хотите удалить производителя?')){
            e.preventDefault();
        }
    });
</script>