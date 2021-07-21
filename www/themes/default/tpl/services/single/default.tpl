{include file="../../common/header.tpl"}
{*<input type="hidden" id="sh_id" value="{$item.ID}" />
<input type="hidden" id="sh_name" value="{$item.TITLE}" />
<input type="hidden" id="c_currency" value="{$item.C_ZN}" />
<input type="hidden" id="c_photo" value="{$item.PHOTO2}" />
<input type="hidden" id="c_alias" value="{$item.ALIAS}" />*}

<main>
    <div class="container">
        {if $item.PHOTO2}
        <!-- BANNER -->
        <div class="banner" style="background-image: url(/upload/images/services/{$item.PHOTO2});">
            <div class="h1-hldr">
                {* <h1>{$item.TITLE}</h1>
                <p class="overview-location"><i class="fas fa-globe-americas" aria-hidden="true"></i> {$item.CITY_NAME},
                    {$item.COUNTRY_NAME}</p>*}
            </div>
        </div> <!-- .banner -->
        {/if}

        <div class="row">
            <div class="col-sm-12 col-lg-12 col-primary">
                <br />

                {* <h1>{if $item.TITLE !== 'Опекунство' && $category.TITLE !== 'Другие услуги'}{$category.TITLE}
                    {$item.TITLE2}{else}{$item.TITLE}{/if}</h1>*}
                <h1>{if $item.TITLE2}{$category.TITLE} {$item.TITLE2}{else}{$item.TITLE}{/if}</h1>


                <!-- SECTION. OVERVIEW -->
                <div class="section section-overview">
                    <div class="row">
                        <div class="col-md-6"> {$item.LEFT_CONTENT}</div>
                        <div class="col-md-6"> {$item.RIGHT_CONTENT}</div>
                    </div>


                </div>
                <!-- .section-overview -->


                <!-- SECTION. COURSES -->
                <div class="section section-courses" id="section-courses">
                    {* <h2>Наши услуги</h2>*}

                    <div id="courseList2">
                        {section name=i loop=$list}
                        <!-- CARD -->
                        {if $list[i].CAPT1}
                        <h2>{$list[i].CAPT1}</h2>
                        {/if}
                        <div class="card card-services">
                            {if $list[i].TYPE != 3 && $list[i].TYPE != 4}
                            <div class="card-header" id="heading-{$smarty.section.i.index}">
                                <h3>
                                    <div class="row align-items-center">
                                        <div class="col-md-7 col-lg-8 text-title">
                                            {*<i class="fa fa-angle-double-right" aria-hidden="true"></i>*}
                                            {if $list[i].TYPE == 1 || $list[i].TYPE == 2}
                                            {$list[i].TITLE}
                                            {elseif $list[i].TYPE == 3}


                                            {elseif $list[i].TYPE == 4}

                                            {else}
                                            {$list[i].TITLE}
                                            {/if}
                                            {if $list[i].TYPE != 4 && $list[i].TYPE != 3}
                                            &nbsp;
                                            <a href="#" data-toggle="collapse"
                                                data-target="#collapse-{$smarty.section.i.index}"
                                                aria-expanded="{if $smarty.section.i.index == 0}false{else}false{/if}"
                                                aria-controls="collapse-{$smarty.section.i.index}">
                                                подробнее
                                            </a>
                                            {/if}
                                        </div>
                                        <div class="col-md-2 col-sm-6 text-price">
                                            {if $list[i].TYPE == 1}

                                            {if $list[i