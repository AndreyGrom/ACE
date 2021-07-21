<h3>Опции
    <div class="pull-right"><a class="btn btn-primary btn-xs" href="?c=shop&act=options&act2=add"><span class="glyphicon glyphicon-plus"></span></a></div>
</h3>
<hr/>
<table class="table table-hover" id="table-options">
    <tr>
        <th>ID</th>
        <th>Опция</th>
        <th colspan="2" class="text-center"><span class="glyphicon glyphicon-sort"></span></th>
        <th>Действие</th>
    </tr>
    {section name=i loop=$options}
        <tr id="{$options[i].OPTION_ID}">
            <td>{$options[i].OPTION_ID}</td>
            <td>{$options[i].OPTION_NAME}</td>
            <td style="width: 30px">
                {if $smarty.section.i.index > 0}
                <a href="#" class="upper"><span title="Переместить наверх" class="glyphicon glyphicon-arrow-up" style="cursor: pointer"></span></a>
                {/if}
            </td>
            <td style="width: 30px">
                {if $smarty.section.i.index < $smarty.section.i.total-1}
                    <a href="#" class="downer"><span title="Переместить вниз" class="glyphicon glyphicon-arrow-down" style="cursor: pointer"></span></a>
                {/if}
            </td>
            <td>
                <a href="?c=shop&act=options&id={$options[i].OPTION_ID}" class="btn btn-primary btn-xs"><span class="glyphicon glyphicon-pencil"></span></a>
                <a href="?c=shop&act=options&act2=del&id={$options[i].OPTION_ID}" class="btn btn-danger btn-xs confirm"><span class="glyphicon glyphicon-remove"></span></a>

            </td>
        </tr>

    {/section}
</table>
<form method="post" id="form-sort" style="display: none;">
    <input type="hidden" name="blocks_sort" id="blocks_sort"/>
</form>
<script>
    $(".confirm").click(function(e){
        if (!confirm('Вы действительно хотите удалить опцию?')){
            e.preventDefault();
        }
    });

    $(function(){
        $('.upper').click(move_up);
        $('.downer').click(move_down);
        function move_up(eventObject){
            var curr_li = $(this).parent().parent();
            var prev_li = $(curr_li).prev();
            prev_li.insertAfter(curr_li);
            getTbl();
        }

        function move_down(eventObject){
            var curr_li = $(this).parent().parent();
            var next_li = $(curr_li).next();
            next_li.insertBefore(curr_li);
            getTbl();
        }

        function getTbl(){
            var table = document.getElementById("table-options");
            var rows = table.tBodies[0].rows;
            var debugStr = "";
            for (var i=0; i<rows.length; i++) {
                debugStr += rows[i].id+";";
            }
            $("#blocks_sort").val(debugStr);
            $("#form-sort").submit();
        }
    });
</script>