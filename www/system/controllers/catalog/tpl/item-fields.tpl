<div class="form-horizontal" role="form">
    <div class="form-group">
        <label class="col-sm-3 control-label">Даты:</label>
        <div class="col-sm-9">
            <input value="{$item.DATE1}" name="date1" type="text" class="form-control">
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-3 control-label">Рейтинг:</label>
        <div class="col-sm-9">
            <input value="{$item.RATING}" name="rating" type="number" class="form-control">
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-3 control-label">Возраст:</label>
        <div class="col-sm-3">
            <input value="{$item.VOZ}" name="voz" type="text" class="form-control">
        </div>
        <label class="col-sm-3 control-label">Средний:</label>
        <div class="col-sm-3">
            <input value="{$item.S_VOZ}" name="s_voz" type="text" class="form-control">
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-3 control-label">Человек в группе (максимум):</label>
        <div class="col-sm-3">
            <input value="{$item.COUNT_G}" name="count_g" type="text" class="form-control">
        </div>
        <label class="col-sm-3 control-label">Среднее:</label>
        <div class="col-sm-3">
            <input value="{$item.S_COUNT_G}" name="s_count_g" type="text" class="form-control">
        </div>
    </div>

    <div class="form-group">
        <label class="col-sm-3 control-label">25+:</label>
        <div class="col-sm-9">
            <select class="form-control" name="p_25">
                <option value="0">Нет</option>
                <option {if $item.P_25}selected="selected" {/if} value="1">Да</option>
            </select>
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-3 control-label">Для молодежи:</label>
        <div class="col-sm-9">
            <select class="form-control" name="p_m">
                <option value="0">Нет</option>
                <option {if $item.P_M}selected="selected" {/if} value="1">Да</option>
            </select>
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-3 control-label">Для топ-менеджеров:</label>
        <div class="col-sm-9">
            <select class="form-control"  name="p_top">
                <option value="0">Нет</option>
                <option {if $item.P_TOP}selected="selected" {/if}value="1">Да</option>
            </select>
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-3 control-label">Топ национальностей:</label>
        <div class="col-sm-7 top-r">
            {section name=i loop=$item.TOP_N}
            <div class="row">
                <div class="col-sm-5">
                    <input value="{$item.TOP_N[i][0]}" name="top_n_t[]" type="text" class="form-control">
                </div>
                <div class="col-sm-2">
                    <input value="{$item.TOP_N[i][1]}" type="text" name="top_n_p[]" class="form-control" />
                </div>
                <div class="col-sm-1">%</div>
                <div class="col-sm-1"><button type="button" class="btn btn-danger rem-t">-</button></div>
            </div>
            {/section}
        </div>
        <div class="col-sm-1">
            <div class="col-sm-1"><button type="button" class="btn btn-primary add-t">+</button></div>
        </div>
    </div>
</div>
<script>
    $('body').on('click', '.add-t', function(){
        $(".top-r .row").last().clone().appendTo(".top-r");
        $(".top-r .row").last().find("input").val("");
    });
    $('body').on('click', '.rem-t', function(){
        if ($(".top-r .row").length > 1){
            $(this).parent().parent().remove();
        } else{
            $(".top-r .row").last().find("input").val("");
        }

    });
</script>