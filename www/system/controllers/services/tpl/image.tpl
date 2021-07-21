<li>

    <a class="fancybox" href="/upload/images/catalog/{$image}"><img src="{$new_image}" alt=""/></a>
    <p><a class="del-image" href="{$image}">Удалить</a></p>
    <a class="skin" {if $item.SKIN == $image}style="display: none" {/if} href="{$image}">Главная</a>
</li>