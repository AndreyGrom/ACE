{if $categories}
<aside class="list-group ag-list-group edit-box-site">
    {if categories}
    {section name=i loop=$categories}
        <a href="/catalog/{$categories[i].ALIAS}">
            {$categories[i].TITLE}
        </a>
    {/section}
    {/if}
</aside>
{/if}

<aside class="list-group ag-list-group edit-box-site sidebar-menu">
    <a href="/register/profile"> Мой профиль</a>
    <a href="/register/orders">Мои заказы</a>
    <a href="#">Мои курсы</a>
    <a href="#">Скидки</a>
    <a href="#">Служба поддержки</a>
    <a href="/login/out">Выход</a>

</aside>
