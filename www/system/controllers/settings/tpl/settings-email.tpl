<div class="form-group">
    <label class="col-sm-3 control-label">Почтовый сервер:</label>
    <div class="col-sm-9">
        <select name="MailSMTPEnabled" id="MailSMTPEnabled" class="form-control">
            <option {if $config->MailSMTPEnabled == '0'}selected{/if} value="0">Функция Mail</option>
            <option {if $config->MailSMTPEnabled == '1'}selected{/if} value="1">Внешний SMTP</option>
        </select>
    </div>
</div>
<div class="smtp-settings" {if $config->MailSMTPEnabled == '0'}style="display: none" {/if}>
    <div class="form-group">
        <label for="MailSMTPHost" class="col-sm-3 control-label">SMTP Host:</label>
        <div class="col-sm-9">
            <input value="{$config->MailSMTPHost}" name="MailSMTPHost" id="MailSMTPHost" type="text" class="form-control" placeholder="">
        </div>
    </div>
    <div class="form-group">
        <label for="MailSMTPPort" class="col-sm-3 control-label">SMTP Port:</label>
        <div class="col-sm-9">
            <input value="{$config->MailSMTPPort}" name="MailSMTPPort" id="MailSMTPPort" type="text" class="form-control" placeholder="">
        </div>
    </div>
    <div class="form-group">
        <label for="MailSMTPUserName" class="col-sm-3 control-label">SMTP User Name:</label>
        <div class="col-sm-9">
            <input value="{$config->MailSMTPUserName}" name="MailSMTPUserName" id="MailSMTPUserName" type="text" class="form-control" placeholder="">
        </div>
    </div>
    <div class="form-group">
        <label for="MailSMTPUserPassword" class="col-sm-3 control-label">SMTP User Password:</label>
        <div class="col-sm-9">
            <input value="{$config->MailSMTPUserPassword}" name="MailSMTPUserPassword" id="MailSMTPUserPassword" type="text" class="form-control" placeholder="">
        </div>
    </div>

    <div class="form-group">
        <label for="MailSMTPFromName" class="col-sm-3 control-label">SMTP From Name</label>
        <div class="col-sm-9">
            <input value="{$config->MailSMTPFromName}" name="MailSMTPFromName" id="MailSMTPFromName" type="text" class="form-control" placeholder="">
        </div>
    </div>
</div>
<script>
    $("#MailSMTPEnabled").change(function(){
        if ($(this).val() == 1){
            $(".smtp-settings").show();
        } else {
            $(".smtp-settings").hide();
        }
    });
</script>
