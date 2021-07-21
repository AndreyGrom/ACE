<div class="form-horizontal" role="form">
    <div class="form-group">

        <div class="form-group">
            <label for="template" class="col-sm-3 control-label">Файл .pdf:</label>
            <div class="col-sm-4">
                <input name="pdf"  type="file" class="" />
            </div>
            <div class="col-sm-5">
                {if $item.PDF}
                    <a target="_blank" href="/upload/files/catalog/{$item.PDF}">Посмотреть</a>
                {/if}
            </div>

        </div>

    </div>
</div>
