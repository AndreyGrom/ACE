<div class="form-horizontal" role="form">
    <h4>Опции</h4>
    <div id="options">
        <div class="panel-group" id="">
        {section name=i loop=$options}
        <div class="panel panel-default">
            <div class="panel-heading">
                <h4 class="panel-title">
                    <a data-toggle="collapse" data-parent="#accordion" href="#collapse{$smarty.section.i.index}">{$options[i].option.OPTION_NAME}</a>
                </h4>
            </div>
            <div id="collapse{$smarty.section.i.index}" class="panel-collapse collapse">
                <div class="panel-body">
                    {section name=j loop=$options[i].params}
                        {assign var="checked" value=""}
                        {assign var="method" value="+"}
                        {assign var="price" value="0"}
                        {assign var="article" value=''}
                        {section name=k loop=$item_options}
                            {if $item_options[k].PARAMETER_ID==$options[i].params[j].ID}
                                {assign var="checked" value="checked"}
                                {assign var="method" value=$item_options[k].PARAMETER_METHOD}
                                {assign var="price" value=$item_options[k].PARAMETER_PRICE}
                                {assign var="article" value=$item_options[k].PARAMETER_ARTICLE}
                            {/if}
                        {/section}
                            <div class="col-sm-5">
                                <label>
                                    <input {$checked} data-option="{$options[i].option.OPTION_ID}" class="option-item" value="{$options[i].params[j].ID}" type="checkbox"/> {$options[i].params[j].PARAMETER}
                                </label>
                            </div>
                            <div class="col-sm-2">
                                <select class="form-control" name="" id="param_method_{$options[i].params[j].ID}">
                                    <option value="+">+</option>
                                    <option {if $method=='-'}selected {/if} value="-">-</option>
                                </select>
                            </div>
                            <div class="col-sm-2">
                                <input value="{$price}" id="param_price_{$options[i].params[j].ID}" class="form-control" type="number"/>
                            </div>
                            <div class="col-sm-1">руб.</div>
                            <div class="col-sm-2">
                                <input value="{$article}" placeholder="артикул" id="param_article_{$options[i].params[j].ID}" class="form-control" type="text"/>
                            </div>
                            <div class="clearfix"></div>
                    {/section}
                </div>
            </div>
        </div>
        {/section}
        </div>
        <textarea id="options_json" name="options_json" style="display: none"></textarea>
    </div>
</div>