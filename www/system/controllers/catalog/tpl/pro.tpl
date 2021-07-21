<form id="item-form" action="" method="post" enctype="multipart/form-data">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title text-uppercase">
                <span class="glyphicon glyphicon-duplicate"></span>
                Создание/Редактирование проживания
            </h3>
        </div>
        <div class="panel-body">
            <div class="form-horizontal" role="form">

            <h4>Привязка к школам</h4>
            <div>Вы можете выбрать сеть школ или отдельную школу</div>
            <div>Нужно выбрать что-то одно. Если вы выберите и сеть и школу, то проживание будет привязано ко всей сети школ</div>
            <br/>

            <div class="form-group">
                <label class="col-sm-3 control-label">Выберите сеть школ:</label>
                <div class="col-sm-9">
                    <select class="form-control" name="net_id">
                        <option value="0">Не выбрано</option>
                        {section name=i loop=$nets}
                            <option {if $nets[i].ID==$item.NET_ID}selected {/if} value="{$nets[i].ID}">{$nets[i].TITLE}</option>
                        {/section}
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">Выберите школу:</label>
                <div class="col-sm-9">
                    <select class="form-control" name="sh_id">
                        <option value="0">Не выбрано</option>
                        {section name=i loop=$schools}
                            <option {if $schools[i].ID==$item.SH_ID}selected {/if} value="{$schools[i].ID}">{$schools[i].TITLE}</option>
                        {/section}
                    </select>
                </div>
            </div>

            <hr/>

                <div class="form-group">
                    <label for="title" class="col-sm-3 control-label">Вид:</label>
                    <div class="col-sm-9">
                        <input required value="{$item.VID}" name="vid" type="text" class="form-control" placeholder="">
                        <div class="help-block">

                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label for="title" class="col-sm-3 control-label">Дата:</label>
                    <div class="col-sm-9">
                        <input required value="{$item.DATE1}" name="date1" type="text" id="date1" class="form-control" placeholder="">
                        <div class="help-block">

                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label for="title" class="col-sm-3 control-label">Возраст:</label>
                    <div class="col-sm-9">
                        <input required value="{$item.VOZRAST}" name="vozrast" type="number" class="form-control" placeholder="">
                        <div class="help-block">

                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label for="title" class="col-sm-3 control-label">Заезд</label>
                    <div class="col-sm-9">
                        <input required value="{$item.GEO1}" name="geo1" type="text" class="form-control" placeholder="">
                        <div class="help-block">

                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label for="title" class="col-sm-3 control-label">Выезд</label>
                    <div class="col-sm-9">
                        <input required value="{$item.GEO2}" name="geo2" type="text" class="form-control" placeholder="">
                        <div class="help-block">

                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label for="title" class="col-sm-3 control-label">Расположение</label>
                    <div class="col-sm-9">
                        <input required value="{$item.GEO}" name="geo" type="text" class="form-control" placeholder="">
                        <div class="help-block">

                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label for="title" class="col-sm-3 control-label">Фото №1</label>
                    <div class="col-sm-4">
                        <input name="photo1" type="file" class="form-control" placeholder="">
                    </div>
                    <div class="col-sm-5">
                        {if $item.PHOTO1}
                        <img class="img-responsive" src="/upload/images/catalog/{$item.PHOTO1}" alt=""/>
                        {/if}
                    </div>
                </div>

                <div class="form-group">
                    <label for="title" class="col-sm-3 control-label">Фото №2</label>
                    <div class="col-sm-4">
                        <input name="photo2" type="file" class="form-control" placeholder="">
                    </div>
                    <div class="col-sm-5">
                        {if $item.PHOTO2}
                        <img class="img-responsive" src="/upload/images/catalog/{$item.PHOTO2}" alt=""/>
                        {/if}
                    </div>
                </div>

                <div class="form-group">
                    <label for="content" class="col-sm-12">Описание</label>
                    <div class="col-sm-12">
                        <textarea name="desc" class="textarea-edit" style="height:100px;">{$item.DESC}</textarea>
                    </div>
                </div>
                <div class="form-group">
                    <label for="content" class="col-sm-12">Что включено</label>
                    <div class="col-sm-12">
                        <textarea name="inc" class="textarea-edit" style="height:100px;">{$item.INC}</textarea>
                    </div>
                </div>

                <hr/>
                <h2>Пакеты <span class="pull-right"><button type="button" class="btn btn-primary add-pack">Еще один</button></span></h2>
                <hr/>
                <div class="packs">
                    {if $item.PACKS}
                        {section name=i loop=$item.PACKS}
                            <div class="pack-item">
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">Описание</label>
                                    <div class="col-sm-5">
                                        <input value="{$item.PACKS[i][0]}"  name="pack_text[]" type="text" class="form-control" placeholder="">
                                    </div>
                                    <label class="col-sm-2 control-label">Стоимость</label>
                                    <div class="col-sm-2">
                                        <input value="{$item.PACKS[i][1]}" name="pack_price[]" type="number" class="form-control" placeholder="">
                                    </div>
                                    <div class="col-sm-1"><button type="button" class="btn btn-danger r-pack">-</button></div>
                                </div>
                                <hr/>
                            </div>
                        {/section}
                    {else}
                        <div class="pack-item">
                            <div class="form-group">
                                <label class="col-sm-2 control-label">Описание</label>
                                <div class="col-sm-5">
                                    <input value="{$item.PACKS[i][0]}"  name="pack_text[]" type="text" class="form-control" placeholder="">
                                </div>
                                <label class="col-sm-2 control-label">Стоимость</label>
                                <div class="col-sm-2">
                                    <input value="{$item.PACKS[i][1]}" name="pack_price[]" type="number" class="form-control" placeholder="">
                                </div>
                                <div class="col-sm-1"><button type="button" class="btn btn-danger r-pack">-</button></div>
                            </div>
                            <hr/>
                        </div>
                    {/if}
                </div>

                <script>
                    $('body').on('click', '.add-pack', function(){
                        $(".packs .pack-item").last().clone().appendTo(".packs");
                        $(".packs .pack-item").last().find("input").val("");
                    });
                    $('body').on('click', '.r-pack', function(){
                        if ($(".packs .pack-item").length > 1){
                            $(this).parent().parent().parent().remove();
                        } else{
                            $(".packs .pack-item").last().find("input").val("");
                        }

                    });
                </script>
            <div class="form-group">
                <label for="title" class="col-sm-3 control-label">Что вклюено</label>
                <div class="col-sm-9">
                    {section name=i loop=$incs}
                        <div class="row">
                            <div class="col-sm-1">
                                <input
                                        {section name=j loop=$item.INCS}
                                            {if $item.INCS[j] == $incs[i].ID}checked{/if}
                                        {/section}
                                        name="incs[]" type="checkbox" value="{$incs[i].ID}"/>
                            </div>
                            <div class="col-sm-1">{$incs[i].ICON}</div>
                            <div class="col-sm-10">{$incs[i].TITLE}</div>
                        </div>

                    {/section}
                </div>
            </div>

               {* <div class="form-group">
                    <label for="title" class="col-sm-3 control-label">Расходы</label>
                    <div class="col-sm-9">
                        <input value="{$item.RASHOD}" name="rashod" type="text" class="form-control" placeholder="">
                        <div class="help-block">

                        </div>
                    </div>
                </div>*}
                <div class="pull-right">
                    <button type="submit" name="save-pro" class="btn btn-success"><span class="glyphicon glyphicon-floppy-disk"></span> Сохранить</button>
                </div>
            </div>

        </div>
    </div>

</form>
<script type="text/javascript" src="{$html_plugins_dir}init_mce.js"></script>
<script>
    $(".confirm").click(function(e){
        if (!confirm("Вы уверенны что хотите это сделать?")){
            e.preventDefault();
        }
    });

</script>
