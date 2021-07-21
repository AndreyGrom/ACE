<!DOCTYPE html>
<html lang="ru" class="{if $home == 1}home{/if}">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="format-detection" content="telephone=no">
    <title>{$meta_title}</title>
    {section name=i loop=$js}
        <script  type="text/javascript" src="{$js[i]}"></script>
    {/section}
    {section name=i loop=$css}
        <link type="text/css" rel="stylesheet" href="{$css[i]}">
    {/section}
    <meta name="description" content="{$meta_description}">
    <meta name="keywords" content="{$meta_keywords}">

    <!-- <link href="https://fonts.googleapis.com/css?family=M+PLUS+Rounded+1c:300,400,500,700|Roboto:400,500,700&display=swap" rel="stylesheet"> -->
    <!--
            <link href="https://fonts.googleapis.com/css?family=M+PLUS+Rounded+1c:300,400,500,700|Noto+Sans:400,700|Roboto:400,500,700&display=swap" rel="stylesheet"> -->

    <link href="https://fonts.googleapis.com/css?family=Roboto:400,500,700|Source+Sans+Pro:300,400,600&display=swap&subset=cyrillic-ext" rel="stylesheet">

    <!--  <script src="https://use.fontawesome.com/ad73625e41.js"></script> -->
    <script src="https://kit.fontawesome.com/804b240201.js"></script>
 {*   <link rel="stylesheet" href="/themes/default/css/bootstrap.min.css">*}
    <link rel="stylesheet" href="/themes/default/css/styles.css">
    <link href="https://fonts.googleapis.com/css?family=PT+Sans+Narrow:400,700|PT+Sans:400,400i,700,700i&display=swap&subset=cyrillic" rel="stylesheet">
    <link rel="stylesheet" href="/themes/default/css/ag-styles.css">
    <script  type="text/javascript" src="/themes/default/js/html5shiv.min.js"></script>
</head>
<body class="body-school">
{services_categories source="m_school_1" id='1'}
{services_categories source="m_school_2" id='2'}
{*  {services_categories source="m_school_3" id='3'}*}
{services_categories source="m_school_4" id='4'}
<div class="container">
    <nav class="navbar navbar-expand-md navbar-light bg-light justify-content-between">

        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <a href="/" class=" d-block d-md-none">
            <svg role="img" aria-label="Alpha Capital Education" width="182" height="26">
                <use xlink:href="#logo-current-color"></use>
            </svg>
        </a>
        <div class="form-inline">
            <a class=" d-block d-md-none" href="/register/profile">
                <svg role="img" width="20" height="20">
                    <use xlink:href="#ico-user"></use>
                </svg>
            </a>
            &nbsp;&nbsp;&nbsp;
            <a class=" d-block d-md-none" href="/catalog/cart">
                <svg role="img" width="16" height="20">
                    <use xlink:href="#ico-basket"></use>
                </svg>
            </a>
        </div>

        <div class="collapse navbar-collapse" id="navbarNavDropdown">

            <ul class="navbar-nav">
                <li class="nav-item d-md-none">
                    <a class="nav-link" href="/catalog">Курсы</a>
                </li>
                <li class="nav-item dropdown d-md-none">
                    <a class="nav-link dropdown-toggle" href="#" id="sh1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        Школы
                    </a>
                    <div class="dropdown-menu" aria-labelledby="sh1">
                        {section name=i loop=$m_school_1}
                            <a class="dropdown-item" href="/services/{$m_school_1[i].ALIAS}">{$m_school_1[i].TITLE}</a>
                        {/section}
                    </div>
                </li>
                <li class="nav-item dropdown d-md-none">
                    <a class="nav-link dropdown-toggle" href="#" id="sh2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        Университеты
                    </a>
                    <div class="dropdown-menu" aria-labelledby="sh2">
                        {section name=i loop=$m_school_2}
                            <a class="dropdown-item" href="/services/{$m_school_2[i].ALIAS}">{$m_school_2[i].TITLE}</a>
                        {/section}
                    </div>
                </li>
                <li class="nav-item d-md-none">
                    <a class="nav-link" href="/services/opekunstvo-p">Опекунство</a>
                </li>
                <li class="nav-item dropdown d-md-none">
                    <a class="nav-link dropdown-toggle" href="#" id="sh4" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        Другие услуги
                    </a>
                    <div class="dropdown-menu" aria-labelledby="sh4">
                        {section name=i loop=$m_school_4}
                            <a class="dropdown-item" href="/services/{$m_school_4[i].ALIAS}">{$m_school_4[i].TITLE}</a>
                        {/section}
                    </div>
                </li>


                <li class="nav-item d-none d-md-block">
                    <a class="nav-link" href="/about-as">О компании</a>
                </li>
                <li class="nav-item d-none d-md-block">
                    <a class="nav-link" href="" title="Alpha Capital Education Instagram" aria-label="Alpha Capital Education Instagram">
                        <svg xmlns="http://www.w3.org/2000/svg" viewbox="0 0 511 511.9" width="18" height="18">
                            <path d="M510.95 150.5c-1.2-27.2-5.598-45.898-11.9-62.102-6.5-17.199-16.5-32.597-29.6-45.398-12.802-13-28.302-23.102-45.302-29.5-16.296-6.3-34.898-10.7-62.097-11.898C334.648.3 325.949 0 256.449 0s-78.199.3-105.5 1.5c-27.199 1.2-45.898 5.602-62.097 11.898-17.204 6.5-32.602 16.5-45.403 29.602-13 12.8-23.097 28.3-29.5 45.3-6.3 16.302-10.699 34.9-11.898 62.098C.75 177.801.449 186.5.449 256s.301 78.2 1.5 105.5c1.2 27.2 5.602 45.898 11.903 62.102 6.5 17.199 16.597 32.597 29.597 45.398 12.801 13 28.301 23.102 45.301 29.5 16.3 6.3 34.898 10.7 62.102 11.898 27.296 1.204 36 1.5 105.5 1.5s78.199-.296 105.5-1.5c27.199-1.199 45.898-5.597 62.097-11.898a130.934 130.934 0 0074.903-74.898c6.296-16.301 10.699-34.903 11.898-62.102 1.2-27.3 1.5-36 1.5-105.5s-.102-78.2-1.3-105.5zm-46.098 209c-1.102 25-5.301 38.5-8.801 47.5-8.602 22.3-26.301 40-48.602 48.602-9 3.5-22.597 7.699-47.5 8.796-27 1.204-35.097 1.5-103.398 1.5s-76.5-.296-103.403-1.5c-25-1.097-38.5-5.296-47.5-8.796C94.551 451.5 84.45 445 76.25 436.5c-8.5-8.3-15-18.3-19.102-29.398-3.5-9-7.699-22.602-8.796-47.5-1.204-27-1.5-35.102-1.5-103.403s.296-76.5 1.5-103.398c1.097-25 5.296-38.5 8.796-47.5C61.25 94.199 67.75 84.1 76.352 75.898c8.296-8.5 18.296-15 29.398-19.097 9-3.5 22.602-7.7 47.5-8.801 27-1.2 35.102-1.5 103.398-1.5 68.403 0 76.5.3 103.403 1.5 25 1.102 38.5 5.3 47.5 8.8 11.097 4.098 21.199 10.598 29.398 19.098 8.5 8.301 15 18.301 19.102 29.403 3.5 9 7.699 22.597 8.8 47.5 1.2 27 1.5 35.097 1.5 103.398s-.3 76.301-1.5 103.301zm0 0"></path>
                            <path d="M256.45 124.5c-72.598 0-131.5 58.898-131.5 131.5s58.902 131.5 131.5 131.5c72.6 0 131.5-58.898 131.5-131.5s-58.9-131.5-131.5-131.5zm0 216.8c-47.098 0-85.302-38.198-85.302-85.3s38.204-85.3 85.301-85.3c47.102 0 85.301 38.198 85.301 85.3s-38.2 85.3-85.3 85.3zm0 0M423.852 119.3c0 16.954-13.747 30.7-30.704 30.7-16.953 0-30.699-13.746-30.699-30.7 0-16.956 13.746-30.698 30.7-30.698 16.956 0 30.703 13.742 30.703 30.699zm0 0"></path>
                        </svg>
                    </a>
                </li>
                <li class="nav-item d-none d-md-block">
                    <a class="nav-link" href="" title="Alpha Capital Education Facebook" aria-label="Alpha Capital Education Facebook">
                        <svg xmlns="http://www.w3.org/2000/svg" viewbox="0 0 24 24" width="18" height="18">
                            <path d="M12,0C5.373,0,0,5.373,0,12c0,6.016,4.432,10.984,10.206,11.852V15.18H7.237v-3.154h2.969V9.927c0-3.475,1.693-5,4.581-5 c1.383,0,2.115,0.103,2.461,0.149v2.753h-1.97c-1.226,0-1.654,1.163-1.654,2.473v1.724h3.593L16.73,15.18h-3.106v8.697 C19.481,23.083,24,18.075,24,12C24,5.373,18.627,0,12,0z"></path>
                        </svg>
                    </a>
                </li>
                <li class="nav-item d-none d-md-block">
                    <a class="nav-link" href="tel:+447481515012" title="Alpha Capital Education Phone" aria-label="Alpha Capital Education Phone">

                        <svg xmlns="http://www.w3.org/2000/svg" viewbox="0 0 18 18" width="18" height="18">
                            <path d="M9.032 0C4.085 0 .065 3.998.065 8.917c0 1.779.576 3.408 1.476 4.801L0 18l4.796-1.345c1.272.691 2.684 1.179 4.236 1.179 4.948 0 8.968-3.998 8.968-8.917C18 3.997 13.98 0 9.032 0zm0 1.372c4.198 0 7.588 3.37 7.588 7.545 0 4.174-3.39 7.545-7.588 7.545a7.584 7.584 0 01-3.923-1.093l-.253-.155-2.657.739.862-2.38-.21-.289a7.48 7.48 0 01-1.407-4.367c0-4.175 3.39-7.545 7.588-7.545zM5.67 4.116c-.156 0-.415.064-.635.321-.216.252-.83.868-.83 2.122 0 1.249.851 2.46.97 2.631.118.172 1.676 2.739 4.058 3.843.566.262 1.008.417 1.352.535.572.193 1.09.166 1.499.102.458-.075 1.406-.616 1.606-1.21.194-.596.199-1.105.134-1.212-.053-.107-.215-.171-.452-.295-.238-.128-1.407-.745-1.623-.825-.215-.091-.377-.129-.538.123-.157.258-.61.83-.75.997-.14.171-.274.193-.512.064-.242-.128-1.007-.396-1.913-1.264-.706-.676-1.185-1.506-1.32-1.763-.14-.258-.016-.392.102-.515.108-.118.237-.3.356-.45.119-.145.156-.257.237-.423a.49.49 0 00-.016-.445c-.065-.129-.539-1.383-.733-1.892-.194-.493-.393-.428-.539-.434-.135-.01-.296-.01-.453-.01z"></path>
                        </svg>
                        +447481515012
                    </a>
                </li>
            </ul>

            <ul class="navbar-nav ml-auto">
                <li class="nav-item d-none d-md-block">
                    <a class="nav-link" href="/register/profile">
                        <svg role="img" width="20" height="20">
                            <use xlink:href="#ico-user"></use>
                        </svg>
                        Кабинет
                    </a>

                </li>
                <li class="nav-item d-none d-md-block">
                    <a class="nav-link" href="/catalog/cart">
                        <svg role="img" width="16" height="20">
                            <use xlink:href="#ico-basket"></use>
                        </svg> Корзина
                    </a>

                </li>
            </ul>
        </div>
    </nav>

    <div class="d-none d-md-block d-xl-block text-center">
        <a href="/">
           {* <img style="width: 309px; height: 50px;" src="/themes/default/img/logo.png" alt=""/>*}
            <svg role="img" aria-label="Alpha Capital Education" width="309" height="50">
                <use xlink:href="#logo-current-color"></use>
            </svg>
        </a>
    </div>
<div class="h-menu">
    {include file = './header-menu.tpl'}
</div>