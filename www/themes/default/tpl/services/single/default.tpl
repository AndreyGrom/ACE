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
                            {if $list[i].CAPT3}
                                <h4 class="sub-caption">{$list[i].CAPT3}</h4>
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

                                            {if $list[i].PRICE_NEW}
                                            {*<span
                                                style="text-decoration: line-through;font-size: 16px;">{$list[i].C_ZN}{$list[i].PRICE}</span>*}
                                            {$list[i].C_ZN}{$list[i].PRICE_NEW}
                                            {else}
                                            {$list[i].C_ZN}{$list[i].PRICE}
                                            {/if}
                                            {/if}
                                        </div>
                                        <div class="col-md-3 col-lg-2 col-sm-6 btn-box">
                                            <div class="pull-right">
                                                {if $list[i].TYPE == 1}
                                                <form method="post">
                                                    <input type="hidden" name="id" value="{$list[i].SID}" />
                                                    <input type="hidden" name="name" value="{$list[i].TITLE}" />
                                                    <input type="hidden" name="desc"
                                                        value="{$category.TITLE} - {$item.TITLE}" />
                                                    <input type="hidden" name="type" value="{$list[i].TYPE}" />
                                                    <input type="hidden" name="c_zn" value="{$list[i].C_ZN}" />
                                                    <input type="hidden" name="cur" value="{$list[i].C_CURRENCY}" />
                                                    <input type="hidden" name="price" value="{$list[i].PRICE}" />
                                                    <input type="hidden" name="price_new"
                                                        value="{$list[i].PRICE_NEW}" />
                                                    <button type="submit" name="add-order" class="btn btn-secondary">
                                                        Заказать
                                                    </button>
                                                </form>
                                                {/if}
                                            </div>
                                        </div>


                                </h3>

                            </div>
                            {/if}
                            <div id="collapse-{$smarty.section.i.index}"
                                class="collapse {if $list[i].TYPE == 3 || $list[i].TYPE == 4 || $list[i].TYPE == 2}show{/if}"
                                aria-labelledby="heading-{$smarty.section.i.index}">
                                <div class="card-body">

                                    <div class="row">
                                        <div class="col-md-12">

                                            {if $list[i].TYPE == 2}
                                            <div class="row consultant-details">
                                                <div class="col-md-8">
                                                    <img class="rounded-circle"
                                                        src="/upload/images/services/{$list[i].PHOTO}" alt="" />
                                                    <div class="copy">
                                                        <h3>{$list[i].NAME}</h3>

                                                        <div class="bullets">
                                                            <p>- {$list[i].BULLET1}</p>
                                                            <p>- {$list[i].BULLET2}</p>
                                                            <p>- {$list[i].BULLET3}</p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-7 col-lg-8">
                                                    {* $list[i].DESC *}
                                                </div>
                                                <div class="col-md-2 col-sm-6 text-price">
                                                    {if $list[i].PRICE_NEW}
                                                    {*<span
                                                        style="text-decoration: line-through;font-size: 16px;">{$list[i].C_ZN}{$list[i].PRICE}</span>*}
                                                    {$list[i].C_ZN}{$list[i].PRICE_NEW}
                                                    {else}
                                                    {$list[i].C_ZN}{$list[i].PRICE}
                                                    {/if}
                                                </div>
                                                <div class="col-md-3 col-lg-2 col-sm-6 btn-box">

                                                    <form method="post">
                                                        <input type="hidden" name="id" value="{$list[i].SID}" />
                                                        <input type="hidden" name="name" value="{$list[i].TITLE}" />
                                                        <input type="hidden" name="desc"
                                                            value="{$category.TITLE} - {$item.TITLE}" />
                                                        <input type="hidden" name="type" value="{$list[i].TYPE}" />
                                                        <input type="hidden" name="c_zn" value="{$list[i].C_ZN}" />
                                                        <input type="hidden" name="cur" value="{$list[i].C_CURRENCY}" />
                                                        <input type="hidden" name="price" value="{$list[i].PRICE}" />
                                                        <input type="hidden" name="price_new"
                                                            value="{$list[i].PRICE_NEW}" />
                                                        <button type="submit" name="add-order"
                                                            class="btn btn-secondary">
                                                            Заказатьs
                                                        </button>
                                                    </form>
                                                </div>
                                            </div>
                                            {/if}

                                            {if $list[i].TYPE == 1}
                                            {$list[i].DESC}
                                            {/if}

                                            {if $list[i].TYPE == 3}
                                            <div class="row align-items-center">
                                                <div class="col-md-4 col-lg-5">
                                                    <p class="rep-capt">{$list[i].TITLE}</p>
                                                </div>
                                                <div class="col-md-3 col-lg-2">
                                                    <select id="" class="select js-select form-control select-level">
                                                        <option value="0">Уровень</option>
                                                        {section name=j loop=$levels}
                                                        {if $list[i].GID == $levels[j].GID}
                                                        <option data-cur="{$list[i].C_CURRENCY}"
                                                            data-c_zn="{$list[i].C_ZN}" data-price="{$levels[j].PRICE}"
                                                            data-price_new="{$levels[j].PRICE_NEW}"
                                                            value="{$levels[j].ID}">{$levels[j].TITLE}</option>
                                                        {/if}
                                                        {/section}
                                                    </select>
                                                </div>
                                                <div class="col-md-2 col-lg-3 col-sm-6 text-price">
                                                    {*<span style="text-decoration:line-through;font-size:16px;"
                                                        class="price-level"></span>*}
                                                    {* <span class="price-level_new  text-price"></span>*}
                                                </div>
                                                <div class="col-md-3 col-sm-6 col-lg-2 btn-box">
                                                    <form method="post">
                                                        <input type="hidden" name="id" value="{$list[i].SID}" />
                                                        <input type="hidden" name="name" value="" />
                                                        <input type="hidden" name="desc"
                                                            value="{$category.TITLE} - {$item.TITLE}" />
                                                        <input type="hidden" name="type" value="{$list[i].TYPE}" />
                                                        <input type="hidden" name="c_zn" value="{$list[i].C_ZN}" />
                                                        <input type="hidden" name="cur" value="{$list[i].C_CURRENCY}" />
                                                        <input type="hidden" name="price" value="{$list[i].PRICE}" />
                                                        <input type="hidden" name="price_new"
                                                            value="{$list[i].PRICE_NEW}" />
                                                        <button name="add-order" style="display: none" type="submit"
                                                            class="btn btn-secondary btn-select-level">Заказать
                                                        </button>
                                                    </form>
                                                </div>
                                            </div>
                                            {/if}


                                            {if $list[i].TYPE == 4}
                                            <div class="row align-items-center">
                                                <div class="col-md-3">
                                                    <select id="select-country" class="select js-select form-control">
                                                        <option value="0">Страна</option>
                                                        <option value="5681">США</option>
                                                        <option value="616">Англия</option>
                                                        <option value="2172">Канада</option>
                                                        <option value="10904">Швейцария</option>
                                                    </select>
                                                </div>
                                                <div class="col-md-3 col-lg-4">
                                                    <select style="display: none" id="select-visa"
                                                        class="select js-select form-control">

                                                    </select>
                                                </div>
                                                <div class="col-md-3 col-sm-6 text-price">
                                                    {*<span style="text-decoration:line-through;font-size:16px;"
                                                        class="price"></span>*}
                                                    <span class="price_new visa-price"></span>
                                                </div>
                                                <div class="col-md-3 col-sm-6 col-lg-2 btn-box">
                                                    <form method="post">
                                                        <input type="hidden" name="id" value="{$list[i].SID}" />
                                                        <input type="hidden" name="name" value="" />
                                                        <input type="hidden" name="desc"
                                                            value="{$category.TITLE} - {$item.TITLE}" />
                                                        <input type="hidden" name="type" value="{$list[i].TYPE}" />
                                                        <input type="hidden" name="c_zn" value="" />
                                                        <input type="hidden" name="cur" value="" />
                                                        <input type="hidden" name="price" value="" />
                                                        <input type="hidden" name="price_new" value="" />
                                                        <button name="add-order" style="display: none" type="submit"
                                                            class="btn btn-secondary btn-select-visa">Заказать
                                                        </button>
                                                    </form>
                                                </div>
                                            </div>
                                            {/if}
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        {if $list[i].CAPT2}
                        <h2>{$list[i].CAPT2}</h2>
                        {/if}
                            {if $list[i].CAPT4}
                                <h4 class="sub-caption">{$list[i].CAPT4}</h4>
                            {/if}
                        {/section}

                    </div>
                </div>

                <p>&nbsp;</p>

                <p>&nbsp;</p>

                {if $rews}
                <div class="section section-overview rews container">
                    <p class="rew-capt">Клиенты о нас</p>
                    <div class="row">
                        {section name=i loop=$rews}
                        <div class="col-lg-6 rews-item">
                            <div class="row">
                                <div class="col-3">
                                    <img class="rounded-circle" src="/upload/images/services/{$rews[i].PHOTO}" alt="" />
                                </div>
                                <div class="col-9">
                                    <div class="rew">
                                        {$rews[i].REW}
                                    </div>
                                    <p class="name"><strong>{$rews[i].TITLE},</strong> {$rews[i].RFROM}</p>
                                </div>
                            </div>
                        </div>
                        {if $smarty.section.i.index_next is div by 2}
                        <div class="clearfix"></div>
                        {/if}
                        {/section}
                    </div>
                </div>
                {/if}
                <!-- .section-courses -->
                <p>&nbsp;</p>

                <p>&nbsp;</p>

            </div>
            <!-- .col-primary -->


        </div>


    </div>

    </div>
</main><!-- .container -->
{include file="../../common/footer.tpl"}