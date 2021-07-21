<form id="page-form" action="" method="post">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title text-uppercase">
                <span class="glyphicon glyphicon-cog"></span> Предложение

            </h3>
        </div>
        <div class="panel-body">

            <div class="form-horizontal" role="form">


                <div class="form-group">
                    <label class="col-sm-3 control-label">Школа:</label>
                    <div class="col-sm-9">
                        <input value="{$item.TITLE}" name="school" id="school" class="form-control">
                        <input value="{$item.SCH_ID}" name="school_id" id="school_id" type="hidden" class="form-control">
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-sm-3 control-label">Надпись:</label>
                    <div class="col-sm-9">
                        <input value="{$item.TEXT}" name="text" id="text" class="form-control">
                    </div>
                </div>


                <div class="text-right">
                    <button name="save-spec-item" type="submit" class="btn btn-success btn-xs"><span class="glyphicon glyphicon-floppy-disk"></span> Сохранить</button>
                </div>




            </div>
        </div>

    </div>




</form>
<script>
    $('#school').autocomplete({
        source: '/system/controllers/home/ajax.php',
        //minLength: 2,
        delay: 1000,
        select:  function( event, ui ) {
            $("#school_id").val(ui.item.value);
            $("#school").val(ui.item.label);
            return false;
        }


    })
</script>