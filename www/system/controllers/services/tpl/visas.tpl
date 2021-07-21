
<h1>Страны виз</h1>
<hr/>

    <table class="table table-striped">
        <tr>
            <th>ID</th>
            <th>Название</th>

        </tr>
    {section name=i loop=$items}
        <tr>
            <td>{$items[i].COUNTRY_ID}</td>
            <td><a href="?c=services&act=visa&cid={$items[i].COUNTRY_ID}">{$items[i].COUNTRY_NAME}</a></td>


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