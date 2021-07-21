<h3>Способы оплаты</h3>
<hr/>
<form method="post" id="pays_form">
    <div class="form-group">
        <label class="col-sm-3 control-label">Платежная система:</label>
        <div class="col-sm-9">
            <select name="ShopPaySystem" id="ShopPaySystem" class="form-control">
                {section name=i loop=$pays}
                    <option {if $config->ShopPaySystem == $pays[i].id}selected{/if} value="{$pays[i].id}">{$pays[i].name}</option>
                {/section}
            </select>
        </div>
    </div>

    {section name=i loop=$pays}
        <div class="form-group pay-methods" id="{$pays[i].id}" {if $pays[i].status == 0}style="display: none;" {/if}>
            <label class="col-sm-12 control-label">Методы оплаты:</label>
            <div class="col-sm-12">
                <table class="table">
                    <tr>
                        <th>Метод</th>
                        <th colspan="3">Влияние на цену</th>
                        <th>Порядок</th>
                    </tr>
                {section name=j loop=$pays[i].pays}
                    <tr>
                        <td>
                            <label>
                                <input type="checkbox" {if $pays[i].pays[j].STATUS>0}checked {/if} value="{$pays[i].pays[j].METHOD_ID}"> {$pays[i].pays[j].NAME}
                            </label>
                        </td>
                        <td>
                            <select class="form-control" name="" id="price_method_{$pays[i].pays[j].METHOD_ID}_{$pays[i].id}">
                                <option value="+">+</option>
                                <option {if $pays[i].pays[j].PAY_METHOD=='-'}selected {/if} value="-">-</option>
                            </select>
                        </td>
                        <td>
                            <input value="{$pays[i].pays[j].PRICE_SUM}" id="price_sum_{$pays[i].pays[j].METHOD_ID}_{$pays[i].id}" class="form-control" type="number"/>
                        </td>
                        <td>
                            <select class="form-control" name="" id="price_ed_{$pays[i].pays[j].METHOD_ID}_{$pays[i].id}">
                                <option value="%">%</option>
                                <option {if $pays[i].pays[j].PRICE_ED=='р'}selected {/if} value="р">р</option>
                            </select>
                        </td>
                        <td>
                            <input value="{$pays[i].pays[j].POSITION}" id="sort_{$pays[i].pays[j].METHOD_ID}_{$pays[i].id}" class="form-control" type="number" placeholder="Порядок"/>
                        </td>
                    </tr>
                {/section}
                </table>
            </div>
        </div>
        <div class="clearfix"></div>
    {/section}
    <input type="hidden" name="pays_json" id="pays_json"/>
    <div class="col-sm-12">
        <button type="submit" class="btn btn-primary pull-right">Сохранить</button>
    </div>
    <hr/>
    <div class="form-group">
        <label class="col-sm-3 control-label">Включить "Оплата при получении":</label>
        <div class="col-sm-9">

        </div>
    </div>
</form>
<script>
    var ShopPaySystem = $("#ShopPaySystem");
    ShopPaySystem.change(function(){
        var id = $(this).val();
        $(".pay-methods").hide();
        $("#"+id).show();
    });
    ShopPaySystem.change();
    $("#pays_form").submit(function(){
        var pays =[];
        var system = ShopPaySystem.val();
        $("#"+ShopPaySystem.val()+" input:checked").each(function(i,e){
            var parameter = new Object();
            parameter.id = $(e).val();
            parameter.price_method = $("#price_method_"+parameter.id+'_'+system).val();
            parameter.price_sum = $("#price_sum_"+parameter.id+'_'+system).val();
            parameter.price_ed = $("#price_ed_"+parameter.id+'_'+system).val();
            parameter.position = $("#sort_"+parameter.id+'_'+system).val();
            pays.push(parameter);
        });
        $("#pays_json").val(JSON.stringify(pays));
    });

</script>