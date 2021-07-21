<section class="container">
    <form id="filter-form" method="get">
        <div class="filter">
            <div class="filter__left">
                <div class="row">
                    <div class="col-md-4 col-sm-12">
                        <select id="predmet" class="select">
                            <option value="0">Предмет</option>
                            {section name=i loop=$predmets}
                                <option {if $get.predmet == $predmets[i].ID}selected {/if} value="{$predmets[i].ID}">{$predmets[i].TITLE}</option>
                            {/section}
                        </select>
                    </div>
                    <div class="col-md-4 col-sm-12">
                        <input value="{$get.age}" class="input__control" type="number" id="age" placeholder="Возраст">
                    </div>
                    <div class="col-md-4 col-sm-12">
                        <select class="select" id="duration">
                            <option value="0">Длительность</option>
                            {section name=i loop=52}
                                <option {if $smarty.section.i.iteration  == $get.duration}selected{/if} value="{$smarty.section.i.index+1}">{$smarty.section.i.index+1}</option>
                            {/section}

                        </select>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-4 col-sm-12">
                        <select class="select" id="SiteCountryID" name="country_id">
                            <option value="0">Страна</option>
                            {section name=i loop=$countries}
                                <option {if $get.country == $countries[i].COUNTRY_ID}selected {/if} value="{$countries[i].COUNTRY_ID}">{$countries[i].COUNTRY_NAME}</option>
                            {/section}

                        </select>
                        <input type="hidden" name="SiteCountry" id="SiteCountry" value=""/>
                    </div>
                    <div class="col-md-4 col-sm-12">

                        <select class="select" id="SiteRegionID" name="region_id">>
                            <option selected value="0">Регион</option>
                            {if $get.country}
                                {section name=i loop=$regions}
                                    <option value="{$regions[i].REGION_ID}" {if $regions[i].REGION_ID == $get.region}selected {/if} data-name="{$regions[i].REGION_NAME}">{$regions[i].REGION_NAME}</option>
                                {/section}
                            {else}

                            {/if}
                        </select>

                        <input type="hidden" name="SiteRegion" id="SiteRegion" value="{$config->SiteRegion}"/>
                    </div>
                    <div class="col-md-4 col-sm-12">
                        <select class="select" id="SiteCityID" name="city_id">>
                            <option value="">Город</option>
                            {if $get.region}
                                {section name=i loop=$cities}
                                    <option {if $cities[i].CITY_ID == $get.city}selected {/if} data-name="{$cities[i].CITY_NAME}" value="{$cities[i].CITY_ID}">{$cities[i].CITY_NAME}</option>
                                {/section}
                            {else}
                                <option selected value="{$get.city}">Город</option>
                            {/if}
                        </select>

                        <input type="hidden" name="SiteCity" id="SiteCity" value="{$config->SiteCity}"/>
                    </div>


                </div>


                <div style="text-align: right" class="btn-sm-hide">
                    <a class="btn btn--blue" href="/catalog">Сбросить</a>
                    <button class="btn btn--blue" type="submit">Искать</button>
                </div>
            </div>

            <div class="filter__right">
                <p>Подходит для:</p>

                <ul class="filter__tags">
                    <li>
                        <input {if $P_25}checked{/if} id="25" type="checkbox">
                        <label for="25">25+</label>
                    </li>
                    <li>
                        <input {if $P_M}checked{/if} id="pm" type="checkbox">
                        <label for="youth">молодежи</label>
                    </li>
                    <li>
                        <input {if $P_TOP}checked{/if} id="p_top" type="checkbox">
                        <label for="managers">топ менеджеров</label>
                    </li>
                </ul>
            </div>
            <div style="" class="btn-sm-show">
                <button class="btn btn--blue" type="submit">Искать</button>
                <a class="btn btn--blue" href="/catalog">Сбросить</a>

            </div>
        </div>
    </form>
</section>