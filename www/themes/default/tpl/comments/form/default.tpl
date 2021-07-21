<form method="post" class="form-horizontal" id="comments-form">
    <input type="hidden" name="username"/>
    <input type="text" name="useremail" style="width: 1px;height: 1px;padding:0;borde:none;"/>
    <input type="hidden" name="comment-parent" value="0"/>
    <div id="reply-panel" class="alert alert-info" style="display: none">
        <p>
            Вы отвечаете пользователю <span id="reply-user-comment">Андрей Гром</span>
            <a id="no-reply" href="#">Отменить</a>
        </p>
    </div>
    {if $error_comment}
        <div class="alert alert-error">
            {$error_comment}
        </div>
    {/if}
    {if $comments_system_message}
        <div class="alert alert-warning">
            {$comments_system_message}
        </div>
    {/if}
    <div class="col-md-8">
        <div class="form-group">
            <label class="control-label" for="comment"><i class="fa fa-comment"></i> Комментарий:</label>
            <div class="">
                <textarea required class="form-control" name="comment" id="comment">{if isset($smarty.post.comment)}{$smarty.post.comment}{/if}</textarea>
            </div>
        </div>
    </div>
    <div class="col-md-3 col-md-offset-1">
        <div class="form-group">
            <label class="control-label" for="name"><i class="fa fa-user"></i> Имя:</label>
            <div class="">
                <input required type="text" value="{if isset($smarty.post.name)}{$smarty.post.name}{/if}" class="form-control" name="name" id="name" placeholder="Введите имя">
            </div>
        </div>
        <div class="form-group">
            <label class="control-label" for="email"><i class="fa fa-envelope"></i> Email:</label>
            <div class="">
                <input type="email" value="{if isset($smarty.post.email)}{$smarty.post.email}{/if}" class="form-control" name="email" id="email" placeholder="Email">
            </div>
        </div>
        {if $captcha}
        <div class="form-group">
            <div class="row">
                <label class="col-sm-12 control-label">Код с картинки:</label>
                <div class="col-sm-5">
                    <input required value="" name="captcha" type="tel" class="form-control">
                </div>
                <div class="col-sm-7"><img style="cursor: pointer" class="img-responsive" id="captcha" src="{$html_plugins_dir}captcha/index.php?hash={$rand}&sn=comment" alt=""/></div>
            </div>
        </div>
        {/if}
        <div class="form-group">
            <button type="submit" class="btn btn-primary" style="width:100%;display:block"><i class="fa fa-comment"></i> Добавить комментарий</button>

        </div>
    </div>
</form>
<script>
    $(document).ready(function(){
        {literal}
        $(document).ready(function(){
            $.cleditor.set_rfm('/filemanager');
            var  controls=
                    "bold italic underline strikethrough subscript superscript | font size " +
                            "style | color highlight removeformat | bullets numbering | outdent " +
                            "indent | alignleft center alignright justify | " +
                            "link unlink";
            $("#comment").cleditor({'controls':controls,'height':220});
        });
        {/literal}
    });

    $(".comment-reply").click(function(e){
        e.preventDefault();
        var user_name = $(this).parent(".comment-meta").find(".comment-user").text();
        var area = $("#comment");
        var reply_panel = $("#reply-panel");
        var reply_user_comment = $("#reply-user-comment");
        reply_user_comment.text(user_name);
        reply_panel.show();
        area.val('<p><strong>'+user_name+',</strong>&nbsp;</p');
        var user_parent = $(this).attr("href");
        $("#comments-form").find("input[name='comment-parent']").val(user_parent);
        document.location.href='#comments-form';
    });
    $("#no-reply").click(function(e){
        e.preventDefault();
        $("#comments-form").find("input[name='comment-parent']").val('0');
        $("#reply-panel").hide();
    });
    $("#comments-form").submit(function(e){

    });

    $("#captcha").click(function(){
        $(this).attr('src','{$html_plugins_dir}captcha/index.php?hash='+new Date().getTime()+'&sn=comment');
    });

    var error = '{$error_comment}';
    if (error){
        document.location.href = '#comments-form';
    }

</script>