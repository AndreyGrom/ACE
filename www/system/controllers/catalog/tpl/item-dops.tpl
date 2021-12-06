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
                        {if $dops[i].ID != 5 && $dops[i].ID != 6}
                        <div class="col-sm-1">Цена</div>
                        <div class="col-sm-2">
                            <input
                                    {section name=j loop=$item.DOPS}
                                        {if $item.DOPS[j][0] == $dops[i].ID}value="{$item.DOPS[j][1]}" {/if}
                                    {/section}
                                    type="number" name="dop_price_{$dops[i].ID}" class="form-control" />
                        </div>
                            {/if}
                        <div class="col-sm-8">{$dops[i].TITLE}</div>
                    </div>
                    {if $dops[i].ID == 5 || $dops[i].ID == 6}
                        <br>
                        {section name=k loop=$aeros}
                        <div class="row">
                            <div class="col-sm-1"></div>
                            <div class="col-sm-1">
                                <input type="checkbox" value="{$aeros[k].ID}"
                                        {if $dops[i].ID == 5}
                                           {section name=l loop=$from_aero}
                                               {if $from_aero[l].id == $aeros[k].ID}checked{/if}
                                           {/section}
                                        {/if}
                                        {if $dops[i].ID == 6}
                                            {section name=l loop=$to_aero}
                                                {if $to_aero[l].id == $aeros[k].ID}checked{/if}
                                            {/section}
                                        {/if}
                                       name="{if $dops[i].ID == 5}from-aeros[]{else}to-aeros[]{/if}
                                 ">

                            </div>
                            <div class="col-sm-4">{$aeros[k].TITLE}</div>
                            <div class="col-sm-1">Цена</div>
                            <div class="col-sm-2">
                                <input type="number"
                                        {if $dops[i].ID == 5}
                                            {section name=l loop=$from_aero}
                                                {if $from_aero[l].id == $aeros[k].ID}value="{$from_aero[l].price}"{/if}
                                            {/section}
                                        {/if}
                                        {if $dops[i].ID == 6}
                                            {section name=l loop=$to_aero}
                                                {if $to_aero[l].id == $aeros[k].ID}value="{$to_aero[l].price}"{/if}
                                            {/section}
                                        {/if}
                                       name="{if $dops[i].ID == 5}from-aeros{else}to-aeros{/if}_{$aeros[k].ID}">
                            </div>
                        </div>
                        {/section}
                        <br>

                    {/if}
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