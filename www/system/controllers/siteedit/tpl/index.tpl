<h2>Визуальный редактор сайта</h2>
<hr/>
<a class="btn btn-primary" href="?c=siteedit&act=scan-templates">Скомпановать шаблоны</a>
<a class="btn btn-primary" href="?c=siteedit&act=recovery-templates">Восстановить шаблоны</a>

{if $vars}
    <table class="table table-hover">
        <tr>
            <th>Метка</th>
            <th>Тег</th>
            <th>Текст</th>
            <th>Путь</th>
        </tr>
        {section name=i loop=$vars}
        <tr>
            <td>[$EDIT_BOX_{$vars[i].ID}]</td>
            <td>{$vars[i].TAG}</td>
            <td>{$vars[i].HTML}</td>
            <td>{$vars[i].PATH}</td>
        </tr>
        {/section}
    </table>
{/if}