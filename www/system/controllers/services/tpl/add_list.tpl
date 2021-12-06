<form id="cat-form" action="" method="post" enctype="multipart/form-data">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title text-uppercase">
                <span class="glyphicon glyphicon-duplicate"></span>
                Редактирование услуги
            </h3>
        </div>
        <div class="panel-body">


            <div class="form-horizontal" role="form">

                <div class="form-group">
                    <label for="parent" class="col-sm-3 control-label">Тип услуги:</label>
                    <div class="col-sm-9">
                        <select id="select-type" name="type" class="form-control">
                            <option  value="0">Выберите</option>
                            <option {if $item.TYPE == 1}selected{/if} value="1">Тип 1</option>
                            <option {if $item.TYPE == 2}selected{/if} value="2">Тип 2</option>
                            <option {if $item.TYPE == 3}selected{/if} value="3">Тип 3</option>
                            <option {if $item.TYPE == 4}selected{/if} value="4">Тип 4</option>
                        </select>
                    </div>
                </div>
                <div class="form-group type1 type2 type3 type4">
                    <label for="c_title" class="col-sm-3 control-label">Порядок сортировки:</label>
                    <div class="col-sm-9">
                        <input value="{$item.SORT}" name="sort" type="number" class="form-control" placeholder="">
                    </div>
                </div>
                <div class="form-group type1 type2 type3 type4">
                    <label for="c_title" class="col-sm-3 control-label">Заголовок верхний:</label>
                    <div class="col-sm-9">
                        <input value="{$item.CAPT1}" name="capt1" type="text" class="form-control" placeholder="">
                    </div>
                </div>
                <div class="form-group type1 type2 type3 type4">
                    <label for="c_title" class="col-sm-3 control-label">Подзаголовок верхний:</label>
                    <div class="col-sm-9">
                        <input value="{$item.CAPT3}" name="capt3" type="text" class="form-control" placeholder="">
                    </div>
                </div>
                <div class="form-group type1 type2 type3 type4">
                    <label for="c_title" class="col-sm-3 control-label">Заголовок нижний:</label>
                    <div class="col-sm-9">
                        <input value="{$item.CAPT2}" name="capt2" type="text" class="form-control" placeholder="">
                    </div>
                </div>
                <div class="form-group type1 type2 type3 type4">
                    <label for="c_title" class="col-sm-3 control-label">Подзаголовок нижний:</label>
                    <div class="col-sm-9">
                        <input value="{$item.CAPT4}" name="capt4" type="text" class="form-control" placeholder="">
                    </div>
                </div>
                <div class="form-group type1 type2 type3">
                    <label for="c_title" class="col-sm-3 control-label">Название:</label>
                    <div class="col-sm-9">
                        <input value="{$item.TITLE}" name="title" type="text" class="form-control" placeholder="">
                    </div>
                </div>
                <div class="form-group type3"">
                <label for="parent" class="col-sm-3 control-label">Группа уровней:</label>
                <div class="col-sm-9">
                    <select name="gid" class="form-control">
                        {section name=i loop=$gid}
                            <option {if $gid[i].ID == $item.GID}selected{/if} value="{$gid[i].ID}">{$gid[i].TITLE}</option>
                        {/section}
                    </select>
                </div>
            </div>
                <div class="form-group type1 type2">
                    <label for="desc" class="col-sm-3 control-label">Описание:</label>
                    <div class="col-sm-9">
                        <textarea name="desc" cols="30" rows="5" class="form-control">{$item.DESC}</textarea>
                    </div>
                </div>
                <div class="form-group type1 type2">
                    <label for="c_title" class="col-sm-3 control-label">Стоимость:</label>
                    <div class="col-sm-9">
                        <input value="{$item.PRICE}" name="price" type="text" class="form-control" placeholder="">
                    </div>
                </div>

                <div class="form-group type1 type2">
                    <label for="c_title" class="col-sm-3 control-label">Скидочная стоимость:</label>
                    <div class="col-sm-9">
                        <input value="{$item.PRICE_NEW}" name="price_new" type="text" class="form-control" placeholder="">
                    </div>
                </div>

                <div class="form-group type1 type2 type3"">
                    <label for="parent" class="col-sm-3 control-label">Валюта:</label>
                    <div class="col-sm-9">
                        <select name="cur" class="form-control">
                            {section name=i loop=$countrys}
                                <option {if $countrys[i].COUNTRY_ID == $item.COUNTRY_CUR}selected{/if} value="{$countrys[i].COUNTRY_ID}">{$countrys[i].COUNTRY_NAME}</option>
                            {/section}
                        </select>
                    </div>
                </div>

                <div class="form-group type2">
                    <label for="desc" class="col-sm-3 control-label">Буллет 1:</label>
                    <div class="col-sm-9">
                        <textarea name="bullet1" cols="30" rows="5" class="form-control">{$item.BULLET1}</textarea>
                    </div>
                </div>
                <div class="form-group type2">
                    <label for="desc" class="col-sm-3 control-label">Буллет 2:</label>
                    <div class="col-sm-9">
                        <textarea name="bullet2" cols="30" rows="5" class="form-control">{$item.BULLET2}</textarea>
                    </div>
                </div>
                <div class="form-group type2">
                    <label for="desc" class="col-sm-3 control-label">Буллет 3:</label>
                    <div class="col-sm-9">
                        <textarea name="bullet3" cols="30" rows="5" class="form-control">{$item.BULLET3}</textarea>
                    </div>
                </div>
                <div class="form-group type2">
                    <label for="title" class="col-sm-3 control-label">Фото</label>
                    <div class="col-sm-4">
                        <input name="photo" type="file" class="form-control" placeholder="">
                    </div>
                    <div class="col-sm-5">
                        {if $item.PHOTO}
                            <img class="img-responsive" src="/upload/images/services/{$item.PHOTO}" alt=""/>
                        {/if}
                    </div>
                </div>

                <div class="form-group type2">
                    <label for="c_title" class="col-sm-3 control-label">Имя:</label>
                    <div class="col-sm-9">
                        <input value="{$item.NAME}" name="name" type="text" class="form-control" placeholder="">
                    </div>
                </div>



            </div>



            <div class="text-right">
                <button name="save-list" type="submit" class="btn btn-success btn-large"><span class="glyphicon glyphicon-floppy-disk"></span> Сохранить</button>
            </div>

        </div>
    </div>
</form>

<hr/>
<p>Подсказка по типам услуг</p>

<br/>Платная консультация общая (1)
<br/>Платная консультация с профильным специалистом (2)
<br/>Полное сопровождение (1)
<br/>Помощь с мотивационным письмом (1)
<br/>Помощь с рекомендациями (1)
<br/>Помощь с рекомендациями для Master’s/PHD (1)
<br/>Помощь с proposal для PHD (1)
<br/>Написание personalstatement (1)
<br/>Подготовка к интервью (1)
<br/>Подбор ВУЗов (1)
<br/>Подбор репетитора (3)
<br/>Оформление визы (4)


<script type="text/javascript" src="{$html_plugins_dir}init_mce.js"></script>
<script>
 $(document).ready(function(){
     function InitF(){
         $(".type1,.type2, .type3, .type4").hide();
         $(".type" + $("#select-type").val()).show();

     }

     InitF();
     $("#select-type").change(function(){
         InitF();
     });
 });
</script>

