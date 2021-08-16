<form id="page-form" action="" method="post">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title text-uppercase">
                <span class="glyphicon glyphicon-cog"></span> Курс

            </h3>
        </div>
        <div class="panel-body">

            <div class="form-horizontal" role="form">


                <div class="form-group">
                    <label class="col-sm-3 control-label">Курс:</label>
                    <div class="col-sm-9">
                        <input value="{$item.TITLE}" name="popular" id="popular" class="form-control">
                        <input value="{$item.POPULAR_ID}" name="popular_id" id="popular_id" type="hidden" class="form-control">
                    </div>
                </div>




                <div class="text-right">
                    <button name="save-popular-item" type="submit" class="btn btn-success btn-xs"><span class="glyphicon glyphicon-floppy-disk"></span> Сохранить</button>
                </div>




            </div>
        </div>

    </div>




</form>
<script>
    $('#popular').autocomplete({
        source: '/system/controllers/home/popular.php',
        //minLength: 2,
        delay: 1000,
        select:  function( event, ui ) {
            $("#popular_id").val(ui.item.value);
            $("#popular").val(ui.item.label);
            return false;
        }


    })
</script>