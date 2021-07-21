<form id="cat-form" action="" method="post" enctype="multipart/form-data">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title text-uppercase">
                <span class="glyphicon glyphicon-duplicate"></span>
                Редактирование отзыва
            </h3>
        </div>
        <div class="panel-body">


            <div class="form-horizontal" role="form">

                <div class="form-group">
                    <label for="c_title" class="col-sm-3 control-label">Имя:</label>
                    <div class="col-sm-9">
                        <input value="{$item.TITLE}" name="title" type="text" class="form-control" placeholder="">
                    </div>
                </div>
                <div class="form-group type1 type2">
                    <label for="desc" class="col-sm-3 control-label">Отзыв:</label>
                    <div class="col-sm-9">
                        <textarea name="rew" cols="30" rows="5" class="form-control">{$item.REW}</textarea>
                    </div>
                </div>
                <div class="form-group type1 type2 type3 type4">
                    <label for="c_title" class="col-sm-3 control-label">Откуда:</label>
                    <div class="col-sm-9">
                        <input value="{$item.RFROM}" name="rfrom" type="text" class="form-control" placeholder="">
                    </div>
                </div>
                <div class="form-group type2">
                    <label for="title" class="col-sm-3 control-label">Фото</label>
                    <div class="col-sm-4">
                        <input name="photo" type="file" class="form-control" placeholder="">
                        <p class="help-block">Изображение должно быть квадратным</p>
                    </div>
                    <div class="col-sm-5">
                        {if $item.PHOTO}
                            <img class="img-responsive" src="/upload/images/services/{$item.PHOTO}" alt=""/>
                        {/if}
                    </div>
                </div>

            </div>



            <div class="text-right">
                <button name="save-rew" type="submit" class="btn btn-success btn-large"><span class="glyphicon glyphicon-floppy-disk"></span> Сохранить</button>
            </div>

        </div>
    </div>
</form>


