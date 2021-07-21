<ul{if !$sub} class="list-unstyled"{else} style="list-style: none;padding-left:10px;"{/if}>
    {section name=i loop=$categories}
        <li>
            <label>
                <input type="checkbox" name="parents[]"
                       {section name=j loop=$item_parents}
                        {if $item_parents[j]==$categories[i].ID} checked="checked" {/if}
                       {/section}
                       value="{$categories[i].ID}"/> {$categories[i].TITLE}
            </label>
            {if $categories[i].SUB}
                {include file="menu_.tpl" categories=$categories[i].SUB sub=true}
            {/if}
        </li>
    {/section}
</ul>