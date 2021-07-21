<nav class="header__menu">
    <ul class="header__menu-list">
        <li><a href="/catalog">Kурсы</a></li>
        <li class="header__menu-dropdown">
            Школы

            <ul class="dropdown-menu">

                {section name=i loop=$m_school_1}
                    <li><a href="/services/{$m_school_1[i].ALIAS}">{$m_school_1[i].TITLE}</a></li>
                {/section}
                {*<li><a href="/catalog/find/country=5681/">США</a></li>
                <li><a href="/catalog/find/country=616/">Англия</a></li>
                <li><a href="/catalog/find/country=2172/">Канада</a></li>
                <li><a href="/catalog/find/country=10904/">Швейцария</a></li>*}
            </ul>
        </li>
        <li class="header__menu-dropdown">
            Университеты

            <ul class="dropdown-menu">

                {section name=i loop=$m_school_2}
                    <li><a href="/services/{$m_school_2[i].ALIAS}">{$m_school_2[i].TITLE}</a></li>
                {/section}
{*                <li><a href="">США</a></li>
                <li><a href="">Англия</a></li>
                <li><a href="">Канада</a></li>
                <li><a href="">Швейцария</a></li>
                <li><a href="">Творческие специальности</a></li>
                <li><a href="">Медицинские ВУЗы</a></li>
                <li><a href="">Оксбридж</a></li>*}
            </ul>
        </li>
        <li><a href="/services/opekunstvo-p">Опекунство</a></li>
        <li class="header__menu-dropdown">
            Другие услуги

            <ul class="dropdown-menu">

                {section name=i loop=$m_school_4}
                    <li><a href="/services/{$m_school_4[i].ALIAS}">{$m_school_4[i].TITLE}</a></li>
                {/section}
{*                <li><a href="">Планирование и развитие карьеры</a></li>
                <li><a href="">Детские сады в Лондоне</a></li>
                <li><a href="">Подбор репетиторов и факультативных занятий в Англии </a></li>
                <li><a href="">Визовая поддержка иммиграционных адвокатов для всех типов виз </a></li>
                <li><a href="">Оформление виз </a></li>*}
            </ul>
        </li>
    </ul>
</nav>