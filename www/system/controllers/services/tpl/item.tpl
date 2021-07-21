<form id="item-form" action="" method="post" enctype="multipart/form-data">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title text-uppercase">
                <span class="glyphicon glyphicon-duplicate"></span>
                Создание/Редактирование материала
            </h3>
        </div>
        <div class="panel-body">

            <div class="tabs">
                <ul class="nav nav-tabs">
                    <li class="active"><a href="#tab-common" data-toggle="tab">Общие</a></li>
                    <li><a href="#tab-content" data-toggle="tab">Контент</a></li>
                    <li><a href="#tab-images" data-toggle="tab">Изображения</a></li>
                    <li><a href="#tab-seo" data-toggle="tab">СЕО</a></li>

                </ul>
                <div class="tab-content">
                    <div id="tab-common" class="tab-pane fade in active">
                        <h3>Общие данные</h3>
                        <p>{include file="item-common.tpl"}</p>
                    </div>
                    <div id="tab-content" class="tab-pane fade">
                        <h3></h3>
                        <p>{include file="item-content.tpl"}</p>
                    </div>
                    <div id="tab-images" class="tab-pane fade">
                        <h3></h3>
                        <p>{include file="item-images.tpl"}</p>
                    </div>

                    <div id="tab-seo" class="tab-pane fade">
                        <h3></h3>
                        <p>{include file="item-seo.tpl"}</p>
                    </div>

                </div>
            </div>

            <div class="pull-right">
                <button type="submit" name="save-item" class="btn btn-success"><span class="glyphicon glyphicon-floppy-disk"></span> Сохранить</button>

            </div>

        </div>
    </div>

</form>
<script type="text/javascript" src="{$html_plugins_dir}init_mce.js"></script>
<script>
    var alias_page_new = false;
    if ($("#alias").val()==''){
        alias_page_new = true;
    }
    $("#title").change(function(){
        if (alias_page_new){
            var str = $(this).val();
            var str2 = SetTranslitRuToLat(str);
            $("#alias").val(str2);
        }
    });
    $("#item-form").submit(function(){
        var alias_page = $(this).find("input[name='alias']").val();
        if (alias_page != ''){
            var pattern = /^[a-z0-9_-]+$/i;
            if (!pattern.test(alias_page)){
                alert('Алиас содержит недопустимые символы');
                return false;
            }
        }


   /*     var chs = $(this).find("input[name='parents[]']:checked");
        if (chs.length==0){
            alert("Необходимо выбрать хотя бы одну категорию");
            return false;
        }*/
    });
    $(".confirm").click(function(e){
        if (!confirm("Вы уверенны что хотите это сделать?")){
            e.preventDefault();
        }
    });
</script>
