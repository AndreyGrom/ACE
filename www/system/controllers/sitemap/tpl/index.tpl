<h2>Генератор карты сайта</h2>

<a class="btn btn-primary" href="?c=sitemap&act=generate-site-map">Сгенерировать сейчас</a>

{if $xml_exists}
    <hr/>
    <h3>Текущая версия карты сайты</h3>
    <p>Последняя модификация: {$lastmod}</p>
    <p>Количество ссылок: {$link_count}</p>
    <p><a target="_blank" href="{$site_url}sitemap.xml">Посмотреть версию .xml</a></p>
    {if $txt_exists}<p><a target="_blank" href="{$site_url}sitemap.txt">Посмотреть версию .txt</a></p>{/if}
    {if $robots_exists}<p><a target="_blank" href="{$site_url}robots.txt">Посмотреть robots.txt</a></p>{/if}
{/if}