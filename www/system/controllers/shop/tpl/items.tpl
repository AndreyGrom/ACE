<div class="col-sm-3">
    <select class="form-control" name="" id="q_filter">
        <option value="">-- Наличие</option>
        {section name=i loop=$q_filter}
            <option {if isset($smarty.get.q) && $smarty.get.q==$smarty.section.i.index} selected="selected" {/if} value="{$smarty.section.i.index}">{$q_filter[i]}</option>
        {/section}
    </select>
</div>
<div class="col-sm-3">
    <select class="form-control" name="" id="a_filter">
        <option value="">-- Цена</option>
        {section name=i loop=$a_filter}
            <option {if isset($smarty.get.a) && $smarty.get.a==$smarty.section.i.index} selected="selected" {/if} value="{$smarty.section.i.index}">{$a_filter[i]}</option>
        {/section}
    </select>
</div>
<div class="col-sm-2">
    <input type="text" id="n_filter" value="{$smarty.get.n}" class="form-control" placeholder="Номер"/>
</div>
<div class="col-sm-3">
    <input type="text" id="art_filter" value="{$smarty.get.art}" class="form-control" placeholder="Артикул"/>
</div>
<div class="col-sm-1">
    <button type="button" class="btn btn-primary" id="apply_filter">ОК</button>
</div>
<div class="clearfix"></div>
<hr/>

{if $items}
    <div class="col-sm-6">
        {$pagination}
    </div>
    <div class="{if $pagination}col-sm-6{else}col-sm-12{/if} text-right">
        <p style="margin-top: 10px;">Показано товаров: {$start}-{$items_count+$start-1} из {$total}</p>
    </div>

    <table class="table table-striped">
        <tr>
            <th>ID</th>
            <th>Название</th>
            <th>Цена</th>
            <th>Наличие</th>
            <th>Статус</th>
            <th>Действия</th>
        </tr>
    {section name=i loop=$items}
        <tr>
            <td>{$items[i].ID}</td>
            <td><a href="?c=shop&id={$items[i].ID}">{$items[i].TITLE}</a></td>
            <td>{$items[i].PRICE}{if $items[i].PRICE_NEW}({$items[i].PRICE_NEW}){/if}</td>
            <td>{$items[i].QUANTITY}</td>
            <td>
                {if $items[i].PUBLIC==1}
                    <span class="glyphicon glyphicon-ok text-success"></span>
                {else}
                    <span class="glyphicon glyphicon-minus text-danger">Не опубликовано</span>
                {/if}
            </td>
            <td>
                <a target="_blank" class="btn btn-primary btn-xs" data-original-title="Перейти к материалу" title="" data-toggle="tooltip" href="/shop/{$items[i].ALIAS}">
                    <span class="glyphicon glyphicon-share-alt"></span>
                </a>
                <a class="btn btn-success btn-xs" data-original-title="Редактировать материал" title="" data-toggle="tooltip" href="?c=shop&id={$items[i].ID}">
                    <span class="glyphicon glyphicon-pencil"></span>
                </a>
                <a class="btn btn-danger btn-xs del-item" data-original-title="Материал будет полностью удален" title="" data-toggle="tooltip" href="?c=shop&act=del-item&id={$items[i].ID}&cid={$category_id}">
                    <span class="glyphicon glyphicon-remove"></span>
                </a>
            </td>
        </tr>
    {/section}
    </table>
    <div class="col-sm-6">
        {$pagination}
    </div>
    <div class="{if $pagination}col-sm-6{else}col-sm-12{/if} text-right">
        <p style="margin-top: 10px;">Показано товаров: {$start}-{$items_count+$start-1} из {$total}</p>
    </div>
{else}
    Материалов в данной категории нет
{/if}
<script>
    $(".del-item").click(function(e){
        if (!confirm("Вы уверенны что хотите удалить товар?")){
            e.preventDefault();
        }
    });

    $("#apply_filter").click(function(){
        var q_filter = $("#q_filter").val();
        var a_filter = $("#a_filter").val();
        var n_filter = $("#n_filter").val();
        var art_filter = $("#art_filter").val();
        var url = '?c=shop';
        if (q_filter !==''){
            url = url + '&q='+q_filter;
        }
        if (a_filter !==''){
            url = url + '&a='+a_filter;
        }
        if (n_filter !==''){
            url = url + '&n='+n_filter;
        }
        if (art_filter !==''){
            url = url + '&art='+art_filter;
        }
        document.location.href = url;
    });
</script>