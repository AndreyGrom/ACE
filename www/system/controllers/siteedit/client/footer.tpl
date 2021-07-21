<link rel="stylesheet" href="/system/plugins/bootstrap/bootstrap.min.css">
<div id="siteedit-text-box-modal" class="modal fade">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">Редактирование текстового блока</h4>
            </div>
            <span style="display: none;" id="siteedit-var-id"></span>
            <span style="display: none;" id="siteedit-var-tag"></span>
            <div class="modal-body">
                <textarea class="form-control" id="siteedit-text-box" style="height: 300px;"></textarea>
            </div>
            <div class="modal-footer">
                <span id="siteedit-status-save" style="display: none;">Сохранение....</span>
                <button type="button" class="btn btn-primary" id="siteedit-var-save">Сохранить изменения</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">Закрыть</button>
            </div>
        </div>
    </div>
</div>

<input type="hidden" id="rfm_input"/>
<a style="display: none" id="rfm_open" href="/filemanager/dialog.php?type=1&field_id=rfm_input"></a>

<script type="text/javascript" src="/system/plugins/tinymce/tinymce.min.js"></script>
<script src="/system/plugins/bootstrap/bootstrap.min.js"></script>
<script type="text/javascript" src="/system/plugins/fancybox/jquery.fancybox.js"></script>
<script type="text/javascript" src="/system/plugins/fancybox/jquery.fancybox.pack.js"></script>
<link rel="stylesheet" href="/system/plugins/fancybox/jquery.fancybox.css">
<script>
    $(document).ready(function(){
        tinymce.init({
            selector:'#siteedit-text-box',
            force_p_newlines : false,
            forced_root_block : false,
            verify_html : false,
            schema: 'html5',
            language : 'ru',
            cleanup: false,
            preformatted : false,
            plugins: [
                "advlist autolink link image lists charmap print preview hr anchor pagebreak spellchecker",
                "searchreplace wordcount visualblocks visualchars code fullscreen insertdatetime media nonbreaking",
                "table contextmenu directionality emoticons template textcolor paste textcolor colorpicker textpattern responsivefilemanager"
            ],
            extended_valid_elements : 'embed[param|src|type|width|height|flashvars|wmode|allowscriptaccess|allowfullscreen],iframe[src|style|width|height|scrolling|marginwidth|marginheight|frameborder],div[*],p[*],span[*],i[*],a[*],object[width|height|classid|codebase|embed|param],param[name|value]',
            media_strict: false,
            menubar : false,
            global_xss_filtering:true,
            relative_urls : false,
            document_base_url : "/",
            /*fontsize_formats: "8pt 9pt 10pt 11pt 12pt 26pt 36pt",*/
            toolbar1: "bold italic underline strikethrough | alignleft aligncenter alignright alignjustify | formatselect fontselect fontsizeselect |  forecolor backcolor | bullist numlist | outdent indent blockquote | link unlink anchor image media code | preview ",
            image_advtab: true ,

            external_filemanager_path:"/filemanager/",
            filemanager_title:"Responsive Filemanager" ,
            external_plugins: { "filemanager" : "/filemanager/plugin.min.js"}
        });
    });

    var active_edit_box;
    $(".edit-box-site").click(function(){
        active_edit_box = $(this);
        if ($(this).get(0).tagName == 'IMG'){
            $("#rfm_open").click();
        } else {
            var elem_info = $(this).find("i").first();
            var id = elem_info.data('id');
            var tag = elem_info.data('tag');
            var html = $(this).html();
            html = html.slice(html.indexOf("</i>")+4);
            $("#siteedit-var-id").text(id);
            $("#siteedit-var-tag").text(tag);
            tinyMCE.activeEditor.setContent(html);
            if (id){
                $("#siteedit-text-box-modal").modal('show');
            }
        }
    });
    $("#siteedit-var-save").click(function(){
        var id = $("#siteedit-var-id").text();
        var tag = $("#siteedit-var-tag").text();
        var html = tinyMCE.activeEditor.getContent();
        $("#siteedit-status-save").show();
        $("#siteedit-status-save").text("Сохранение...");
        $.ajax({
            type: 'POST',
            url: '/system/controllers/siteedit/ajax.php',
            data: 'id='+id+'&html='+encodeURIComponent(html),
            success: function(result){
                if (result == 1){
                    active_edit_box.html('<i class="siteedit-info" style="display:none;" data-id="'+id+'" data-tag="'+tag+'"></i>'+html);
                    $("#siteedit-status-save").text("Сохранено").delay(5000).fadeOut();
                } else {
                    $("#siteedit-status-save").text("Ошибка сохранения");
                }
            }
        });
    });
    $('.edit-box-site').hover(
            function(){
                var e = $(this).find("i.siteedit-info");
                if (e.data('id')){
                    $(this).addClass('edit-box-site-hover');
                }
            },
            function(){ $(this).removeClass('edit-box-site-hover') }
    );

    $('#rfm_open').fancybox({
        'width'		: 900,
        'height'	: 600,
        'type'		: 'iframe',
        'autoScale'    	: false
    });

    function parseGetParams(url) {
        var $_GET = {};
        url = url.split("?")[1];
        var __GET = url.split("&");
        for(var i=0; i<__GET.length; i++) {
            var getVar = __GET[i].split("=");
            $_GET[getVar[0]] = typeof(getVar[1])=="undefined" ? "" : getVar[1];
        }
        return $_GET;
    }

    function responsive_filemanager_callback(field_id){
        var url=jQuery('#'+field_id).val();
        var url_old = active_edit_box.attr("src");
        var params = parseGetParams(url_old);
        var id = params.id;
        var tag = params.tag;

        $.ajax({
            type: 'POST',
            url: '/system/controllers/siteedit/ajax.php',
            data: 'id='+id+'&html='+encodeURI(url),
            success: function(result){
                active_edit_box.attr("src",url+"?id="+id+"&tag="+tag);
            }
        });
    }


</script>