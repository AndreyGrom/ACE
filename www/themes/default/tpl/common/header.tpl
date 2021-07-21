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
    {*<link rel="stylesheet" href="/themes/default/css/main.css">*}
    <link href="https://fonts.googleapis.com/css?family=PT+Sans+Narrow:400,700|PT+Sans:400,400i,700,700i&display=swap&subset=cyrillic" rel="stylesheet">
{*    <link rel="apple-touch-icon" sizes="180x180" href="/themes/default/img/apple-touch-icon.png">
    <link rel="icon" type="image/png" sizes="32x32" href="/themes/default/img//favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="/themes/default/img/favicon-16x16.png">
    <link rel="shortcut icon" type="image/png" href=/themes/default/img/favicon-16x16.png">
    <link rel="mask-icon" href="/themes/default/img/safari-pinned-tab.svg" color="#9e38ff">
    <link rel="manifest" href="assets/site.webmanifest">*}
    <meta name="msapplication-TileColor" content="#603cba">
    <meta name="theme-color" content="#ffffff">
    <meta name="msapplication-config" content="assets/browserconfig.xml">
    <script  type="text/javascript" src="/themes/default/js/html5shiv.min.js"></script>
    <script src="/themes/default/js/jquery.min.js"></script>
    <script src="https://code.jquery.com/jquery-migrate-3.0.0.min.js"></script>

    <script src="/themes/default/js/jquery.cookie.js"></script>
    <script src="/system/plugins/jquery-ui-1.11.4.custom/jquery-ui.min.js"></script>
    <link rel="stylesheet" href="/system/plugins/jquery-ui-1.11.4.custom/jquery-ui.min.css">

    <link rel="stylesheet" type="text/css" href="/system/plugins/slick/slick.css"/>
    <link rel="stylesheet" type="text/css" href="/system/plugins/slick/slick-theme.css"/>
    <script type="text/javascript" src="/system/plugins/slick/slick.min.js"></script>

    <script src="https://kit.fontawesome.com/804b240201.js"></script>

    <link rel="stylesheet" href="/themes/default/css/style.css">
    <link rel="stylesheet" href="/themes/default/css/ag-styles.css">

    <script async type="text/javascript" src="/system/controllers/mailforms/action.js"></script>
</head>

<body {if $module_name == 'catalog' || $module_name == 'services'}class="body-school"{/if}>
    <header class="{if $home == 1}home-{/if}header">
        <div class="container"> 

        <div class="header__top">
            {include file = './header-left.tpl'}
            {include file = './header-right.tpl'}

        </div>

        <div class="header__logo">
            <a href="/">
                <svg role="img" aria-label="Alpha Capital Education" width="309" height="50">
                    <use xlink:href="#logo-current-color"></use>
                </svg>
            </a>
        </div>
        {services_categories source="m_school_1" id='1'}
        {services_categories source="m_school_2" id='2'}
      {*  {services_categories source="m_school_3" id='3'}*}
        {services_categories source="m_school_4" id='4'}
        {include file = './header-menu.tpl'}
        {include file = './header-mobile-menu.tpl'}


    </div>
    {if $home == 1}
    {include file = './header-form.tpl'}
    {/if}
</header>
