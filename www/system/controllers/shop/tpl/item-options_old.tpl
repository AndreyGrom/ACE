<div class="form-horizontal" role="form">
    <h4>Опции</h4>
    <div id="options">
        {section name=i loop=$option_list}
            <h5>
                <label>
                    <input data-option="" class="option-item"
                            {section name=j loop=$item_options}
                                {if $item_options[j]->id==$option_list[i].OPTION_ID}
                                    checked
                                {/if}
                            {/section}
                           value="{$option_list[i].OPTION_ID}" type="checkbox"/>  {$option_list[i].OPTION_NAME}
                </label>
            </h5>
            {section name=j loop=$option_param_list}
                {assign var="params" value=""}
                {if $option_list[i].OPTION_ID==$option_param_list[j].OPTION_ID}
                    {section name=k loop=$item_options}
                        {if $item_options[k]->id==$option_list[i].OPTION_ID}
                            {assign var="params" value=$item_options[k]->params}
                        {/if}
                    {/section}
                    <div class="col-sm-7">
                        <label>
                            <input class="param{$option_list[i].OPTION_ID}"
                                    {if $params}
                                        {section name=k loop=$params}
                                            {if $params[k]->id == $option_param_list[j].ID}checked{/if}
                                        {/section}
                                    {/if}
                                   value="{$option_param_list[j].ID}" type="checkbox"/> {$option_param_list[j].PARAMETER}
                        </label>
                    </div>
                    <div class="col-sm-2">
                        <select class="form-control" name="" id="param_method_{$option_param_list[j].ID}">
                            <option value="+">+</option>
                            <option
                                    {if $params}
                                        {section name=k loop=$params}
                                            {if $params[k]->id == $option_param_list[j].ID && $params[k]->method=='-'}selected="selected" {/if}
                                        {/section}
                                    {/if}
                                    value="-">-</option>
                        </select>
                    </div>
                    <div class="col-sm-2">
                        <input
                                {if $params}
                                    {section name=k loop=$params}
                                        {if $params[k]->id == $option_param_list[j].ID}value="{$params[k]->price}" {/if}
                                    {/section}
                                {/if}
                                id="param_price_{$option_param_list[j].ID}" class="form-control" type="number"/>
                    </div>
                    <div class="col-sm-1">руб.</div>
                    <div class="clearfix"></div>
                {/if}
            {/section}
        {/section}
        <textarea id="options_json" name="options_json" style="display: none"></textarea>
    </div>
</div>