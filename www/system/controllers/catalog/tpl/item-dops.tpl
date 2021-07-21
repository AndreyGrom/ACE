<div class="form-horizontal" role="form">


    <div class="form-group">
        <label class="col-sm-2 control-label">Обязательные</label>
        <div class="col-sm-10">
            {section name=i loop=$dops}
                {if $dops[i].TYPE == 0}
                    <div class="row">
                        <div class="col-sm-1">
                            <input
                                    {section name=j loop=$item.DOPS}
                                        {if $item.DOPS[j][0] == $dops[i].ID}checked{/if}
                                    {/section}
                                    type="checkbox" value="{$dops[i].ID}" name="dop_id[]"/>
                        </div>
                        <div class="col-sm-1">Цена</div>
                        <div class="col-sm-2">
                            <input
                                    {section name=j loop=$item.DOPS}
                                        {if $item.DOPS[j][0] == $dops[i].ID}value="{$item.DOPS[j][1]}" {/if}
                                    {/section}
                                    type="number" name="dop_price_{$dops[i].ID}" class="form-control" />
                        </div>
                        <div class="col-sm-8">{$dops[i].TITLE}</div>
                    </div>
                {/if}
            {/section}
        </div>
    </div>
    <hr/>
    <div class="form-group">
        <label class="col-sm-2 control-label">На выбор</label>
        <div class="col-sm-10">
            {section name=i loop=$dops}
                {if $dops[i].TYPE == 1}
                    <div class="row">
                        <div class="col-sm-1">
                            <input
                                    {section name=j loop=$item.DOPS}
                                        {if $item.DOPS[j][0] == $dops[i].ID}checked{/if}
                                    {/section}
                                    type="checkbox" value="{$dops[i].ID}" name="dop_id[]"/>
                        </div>
                        <div class="col-sm-1">Цена</div>
                        <div class="col-sm-2">
                            <input
                                    {section name=j loop=$item.DOPS}
                                        {if $item.DOPS[j][0] == $dops[i].ID}value="{$item.DOPS[j][1]}" {/if}
                                    {/section}
                                    type="number" name="dop_price_{$dops[i].ID}" class="form-control" />
                        </div>
                        <div class="col-sm-8">{$dops[i].TITLE}</div>
                    </div>
                {/if}
            {/section}
        </div>
    </div>
    <hr/>
    <div class="form-group">
        <label class="col-sm-2 control-label">Не включенные</label>
        <div class="col-sm-10">
            {section name=i loop=$dops}
                {if $dops[i].TYPE == 2}
                    <div class="row">
                        <div class="col-sm-1">
                            <input
                                    {section name=j loop=$item.DOPS}
                                        {if $item.DOPS[j][0] == $dops[i].ID}checked{/if}
                                    {/section}
                                    type="checkbox" value="{$dops[i].ID}" name="dop_id[]"/>
                        </div>

                        <div class="col-sm-11">{$dops[i].TITLE}</div>
                    </div>
                {/if}
            {/section}
        </div>
    </div>