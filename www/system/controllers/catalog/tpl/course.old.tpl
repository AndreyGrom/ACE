<form id="item-form" action="" method="post" enctype="multipart/form-data">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title text-uppercase">
                <span class="glyphicon glyphicon-duplicate"></span>
                Создание/Редактирование курса
            </h3>
        </div>
        <div class="panel-body">
            <div class="form-horizontal" role="form">
                <h4>Привязка к школам</h4>
                <div>Вы можете выбрать сеть школ или отдельную школу</div>
                <div>Нужно выбрать что-то одно. Если вы выберите и сеть и школу, то курс будет привязан ко всей сети школ</div>
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
                    <label for="title" class="col-sm-3 control-label">Название:</label>
                    <div class="col-sm-9">
                        <input required value="{$item.TITLE}" name="title" type="text" class="form-control" placeholder="">
                        <div class="help-block">
                            Отображается только на странице школы в блоке курсов, не влияет на поиск
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label for="title" class="col-sm-3 control-label">Предмет/Дисциплина:</label>
                    <div class="col-sm-9">
                        <select name="predmet" class="form-control">
                            <option value="0">Предмет</option>
                            {section name=i loop=$predmets}
                                <option {if $item.PREDMET ==  $predmets[i].ID}selected {/if} value="{$predmets[i].ID}">{$predmets[i].TITLE}</option>
                            {/section}
                        </select>

                        <div class="help-block">Показывается только в списке ‘чему хочу научиться/предмет’ в строках поиска</div>
                    </div>
                </div>
                <div class="form-group">
                    <label for="title" class="col-sm-3 control-label">Кол-во недель:</label>
                    <div class="col-sm-9">
                        <div class="row">
                            <label for="title" class="col-sm-1 control-label">от</label>
                            <div class="col-sm-3">
                                <input required value="{$item.COUNT_OT}" name="count_ot" type="number" class="form-control">
                            </div>
                            <label for="title" class="col-sm-1 control-label">до</label>
                            <div class="col-sm-3">
                                <input required value="{$item.COUNT_DO}" name="count_do" type="number" class="form-control">
                            </div>
                        </div>
                        <div class="help-block">
                            Отображается в каталоге и на странице школы в блоке курса. Данная информация относится к поиску ‘продолжительность’
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label for="title" class="col-sm-3 control-label">Кол-во уроков:</label>
                    <div class="col-sm-9">
                        <input required value="{$item.COUNT_UR}" name="count_ur" type="number" class="form-control" placeholder="">
                        <div class="help-block">
                            Отображается только на странице школы в блоке курсов, не влияет на поиск
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label for="title" class="col-sm-3 control-label">Продолжительность урока</label>
                    <div class="col-sm-9">
                        <input required value="{$item.PRODOL_UR}" name="prodol_ur" type="number" class="form-control" placeholder="">
                        <div class="help-block">
                            В минутах. Отображается только на странице школы в блоке курсов, не влияет на поиск
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label for="title" class="col-sm-3 control-label">Минимальный уровень</label>
                    <div class="col-sm-9">
                        <input required value="{$item.MIN_LEVEL}" name="min_level" type="text" class="form-control" placeholder="">
                        <div class="help-block">
                            Минимальный уровень, необходимый для поступления на курс. Отображается только на странице школы в блоке курсов, не влияет на поиск
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label for="title" class="col-sm-3 control-label">Даты:</label>
                    <div class="col-sm-9">
                        <input required value="{$item.DATE_START}" name="date_start" type="text" class="form-control" placeholder="">

                        <div class="help-block">

                        </div>
                    </div>
                </div>
              {*  <script>
                    $(".date-input").datepicker();
                    $(".date-input").datepicker("option", "dateFormat", "dd-mm-yy");
                    $("#date_start").datepicker('setDate', '{$item.DATE_START}');
                    $("#date_end").datepicker('setDate', '{$item.DATE_END}');
                </script>*}
                <div class="form-group">
                    <label for="title" class="col-sm-3 control-label">Продолжительность курса</label>
                    <div class="col-sm-9">
                        <div class="row">
                            <div class="col-sm-3">
                                <input required value="{$item.PRODOL_COUNT}" name="prodol_count" type="number" class="form-control" placeholder="">
                            </div>
                            <div class="col-sm-3">
                                <select name="prodol_type" class="form-control">
                                    <option value="0">Недель</option>
                                    <option {if $item.PRODOL_TYPE==1}selected {/if} value="1">Дней</option>
                                </select>
                            </div>
                        </div>
                        <div class="help-block">

                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label for="content" class="col-sm-12">Описание</label>
                    <div class="col-sm-12">
                        <textarea name="desc" class="textarea-edit" style="height:100px;">{$item.DESC}</textarea>
                    </div>
                </div>
                <div class="form-group">
                    <label for="content" class="col-sm-12">Время занятий</label>
                    <div class="col-sm-12">
                        <textarea name="time_desc" class="textarea-edit" style="height:100px;">{$item.TIME_DESC}</textarea>
                    </div>
                </div>

                <div class="form-group">
                    <label for="title" class="col-sm-3 control-label">Цена</label>
                    <div class="col-sm-9">
                        <input required value="{$item.PRICE}" name="price" type="text" class="form-control" placeholder="">
                        <div class="help-block">
                            Цифра/Неделю, отображается в поиске
                        </div>
                    </div>
                </div>
                {*<div class="form-group">
                    <label for="title" class="col-sm-3 control-label">Цена со скидкой</label>
                    <div class="col-sm-9">
                        <input value="{$item.PRICE_NEW}" name="price_new" type="text" class="form-control" placeholder="">
                        <div class="help-block">
                            Стоимость со скидкой (если есть): фиксированная цифра.
                        </div>
                    </div>
                </div>*}

                <h2>Система скидок <span class="pull-right"><button type="button" class="btn btn-primary add-pack">Еще один</button></span></h2>
                <hr/>
                <div class="packs">
                    {if $item.PACKS}
                        {section name=i loop=$item.PACKS}
                            <div class="pack-item">
                                <h2></h2>
                                <div class="form-group">
                                    <label class="col-sm-1 control-label"></label>
                                    <div class="col-sm-1">
                                        <input value="{$item.PACKS[i][0]}"  name="pack_ot[]" type="text" class="form-control" placeholder="">
                                    </div>
                                    <label class="col-sm-1 control-label">От</label>
                                    <div class="col-sm-1">
                                        <input value="{$item.PACKS[i][0]}"  name="pack_ot[]" type="text" class="form-control" placeholder="">
                                    </div>
                                    <label class="col-sm-1 control-label">До</label>
                                    <div class="col-sm-1">
                                        <input value="{$item.PACKS[i][1]}"  name="pack_do[]" type="text" class="form-control" placeholder="">
                                    </div>
                                    <label class="col-sm-1 control-label">Цена</label>
                                    <div class="col-sm-1">
                                        <input value="{$item.PACKS[i][2]}" name="pack_price[]" type="number" class="form-control" placeholder="">
                                    </div>
                                    <div class="col-sm-1"><button type="button" class="btn btn-danger r-pack">-</button></div>
                                </div>
                                <hr/>
                            </div>
                        {/section}
                    {else}
                        <div class="pack-item">
                            <h4>Часы</h4>
                            <div class="form-group">
                                <label class="col-sm-1 control-label">Часы</label>
                                <div class="col-sm-1">
                                    <input value=""  name="pack_ot[]" type="text" class="form-control" placeholder="">
                                </div>
                                <label class="col-sm-1 control-label">От</label>
                                <div class="col-sm-1">
                                    <input value=""  name="pack_ot[]" type="text" class="form-control" placeholder="">
                                </div>
                                <label class="col-sm-1 control-label">До</label>
                                <div class="col-sm-1">
                                    <input value=""  name="pack_do[]" type="text" class="form-control" placeholder="">
                                </div>
                                <label class="col-sm-2 control-label">Цена</label>
                                <div class="col-sm-1">
                                    <input value="" name="pack_price[]" type="number" class="form-control" placeholder="">
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

                <div class="pull-right">
                    <button type="submit" name="save-course" class="btn btn-success"><span class="glyphicon glyphicon-floppy-disk"></span> Сохранить</button>
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
