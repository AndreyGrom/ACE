<li>
    <a class="fancybox" href="{$upload_images_dir}shop/{$image}"><img src="{$new_image_upload}" alt=""/></a>
    <p><a class="del-image" href="{$image}">Удалить</a></p>
    <a class="skin" {if $skin == $image}style="display: none" {/if} href="{$image}">Главная</a>
</li>