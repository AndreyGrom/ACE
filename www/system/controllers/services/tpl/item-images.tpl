<div class="form-horizontal" role="form">
    <div class="form-group">
        <label for="title" class="col-sm-3 control-label">Фото (список)</label>
        <div class="col-sm-4">
            <input name="photo1" type="file" class="form-control" placeholder="">
        </div>
        <div class="col-sm-5">
            {if $item.PHOTO1}
                <img class="img-responsive" src="/upload/images/services/{$item.PHOTO1}" alt=""/>
            {/if}
        </div>
    </div>

    <div class="form-group">
        <label for="title" class="col-sm-3 control-label">Фото (страница)</label>
        <div class="col-sm-4">
            <input name="photo2" type="file" class="form-control" placeholder="">
        </div>
        <div class="col-sm-5">

            {if $item.PHOTO2}
                <img class="img-responsive" src="/upload/images/services/{$item.PHOTO2}" alt=""/>
            {/if}
        </div>
    </div>
</div>
