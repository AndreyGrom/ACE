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
    <div class="form-group pay-methods" id="{$pays[i].id}">
        <label class="col-sm-3 control-label">Методы оплаты:</label>
        <div class="col-sm-9">
            {section name=j loop=$pays[j].pays}
                <div class="checkbox">
                    <label>
                        {assign  var="m" value="ShopPay_`$pays[j].pays[j].id`_`$p[i].id`"}
                        <input {if $config->$m == $p[i].id}checked {/if} name="ShopPay0_{$pays0[i].id}" type="checkbox" value="{$pays0[i].id}"> {$pays0[i].name}
                    </label>
                </div>
                <option  value=""></option>
            {/section}
        </div>
    </div>
{/section}
{*<div class="form-group pay-methods" id="ya_d">
    <label class="col-sm-3 control-label">Методы оплаты:</label>
    <div class="col-sm-9">
            {section name=i loop=$pays0}
                <div class="checkbox">
                    <label>
                        {assign  var="m" value="ShopPay0_`$pays0[i].id`"}
                        <input {if $config->$m == $pays0[i].id}checked {/if} name="ShopPay0_{$pays0[i].id}" type="checkbox" value="{$pays0[i].id}"> {$pays0[i].name}
                    </label>
                </div>
                <option  value=""></option>
            {/section}
    </div>
</div>
<div class="form-group pay-methods" id="ya_k" style="display: none;">
    <label class="col-sm-3 control-label">Методы оплаты:</label>
    <div class="col-sm-9">
        {section name=i loop=$pays1}
            <div class="checkbox">
                <label>
                    {assign  var="m" value="ShopPay1_`$pays1[i].id`"}
                    <input {if $config->$m == $pays1[i].id}checked{/if} name="ShopPay1_{$pays1[i].id}" type="checkbox" value="{$pays1[i].id}"> {$pays1[i].name}
                </label>
            </div>
            <option  value=""></option>
        {/section}
    </div>
</div>*}
