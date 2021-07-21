<form class="ag-mail-form" method="post">
    <input type="hidden" name="form_id" value="{$form_id}"/>
    <div class="form-horizontal">
        {section name=i loop=$form_fields}
        <div class="form-group">
            <div class="col-sm-12">
                {if $form_fields[i].type=='text' || $form_fields[i].type=='email' || $form_fields[i].type=='tel' || $form_fields[i].type=='password'}
                    <label class="col-sm-12">{$form_fields[i].name}:</label>
                    <input {if $form_fields[i].required}required{/if} name="f{$form_fields[i].id}" type="{$form_fields[i].type}" class="form-control" placeholder="{$form_fields[i].placeholder}" />
                {elseif $form_fields[i].type=='checkbox'}
                    <label class="col-sm-12"><input type="checkbox" name="f{$form_fields[i].id}" /> {$form_fields[i].name}</label>

                {elseif $form_fields[i].type=='radio'}
                    <label class="col-sm-12">{$form_fields[i].name}:</label>
                    <ul>
                    {section name=j loop=$form_fields[i].options}
                        <li><input type="radio" name="f{$form_fields[i].id}" value="{$form_fields[i].options[j]}"/></li>
                    {/section}
                    </ul>
                {elseif $form_fields[i].type=='select'}
                    <label class="col-sm-12">{$form_fields[i].name}:</label>
                    <select name="f{$form_fields[i].id}" class="form-control">
                        {section name=j loop=$form_fields[i].options}
                            <option value="{$form_fields[i].options[j]}">{$form_fields[i].options[j]}</option>
                        {/section}
                    </select>
                {elseif $form_fields[i].type=='textarea'}
                    <label class="col-sm-12">{$form_fields[i].name}:</label>
                    <textarea name="f{$form_fields[i].id}"  cols="30" rows="5" class="form-control"></textarea>
                {/if}
            </div>
        </div>
        {/section}
    </div>
    <div class="text-right">
        <button type="submit" class="btn btn-success btn-large"><i class="fa fa-envelope"></i> Отправить</button>
    </div>
</form>