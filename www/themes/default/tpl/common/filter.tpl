<section class="">
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

                    <div class="col-md-5 col-sm-12">
                        <select class="select" id="SiteCountryID" name="country_id">
                            <option value="0">Страна</option>
                            {section name=i loop=$countries}
                                <option {if $get.country == $countries[i].COUNTRY_ID}selected {/if} value="{$countries[i].COUNTRY_ID}">{$countries[i].COUNTRY_NAME}</option>
                            {/section}

                        </select>
                        <input type="hidden" name="SiteCountry" id="SiteCountry" value=""/>
                    </div>

                    <div class="col-md-3 col-sm-12">
                        <select class="select" id="date" name="date">
                            <option value="0">Даты</option>
                            {section name=i loop=$date1}
                                <option {if $get.date1 == $date1[i].DATE1 &&  $date1[i].DATE1 !== ''}selected {/if} value="{$date1[i].DATE1}">{$date1[i].DATE1}</option>
                            {/section}

                        </select>
                    </div>

                </div>

                <div class="row">

                    <div class="col-md-4 col-sm-12">
                        <select class="select" id="SiteCityID" name="city_id" style="width: 220px;">
                            <option value="">Город</option>
                            {if $get.country}
                                {section name=i loop=$cities}
                                    <option {if $cities[i].CITY_ID == $get.city}selected {/if} data-name="{$cities[i].CITY_NAME}" value="{$cities[i].CITY_ID}">{$cities[i].CITY_NAME}</option>
                                {/section}
                            {else}
                                <option selected value="{$get.city}">Город</option>
                            {/if}
                        </select> <span style="font-size: 16px;font-style: italic">&nbsp;&nbsp;&nbsp;или</span>
                        <input type="hidden" name="SiteCity" id="SiteCity" value="{$config->SiteCity}"/>
                    </div>

                    <div class="col-md-5 col-sm-12">
                        <input value="{$ADDRESS}" class="input__control" type="text" id="address" name="address" placeholder="Адрес (точный, на английском языке)">
                    </div>

                    <div class="col-md-3 col-sm-12">
                        <select class="select" id="duration">
                            <option value="0">Длительность</option>
                            {section name=i loop=52}
                                <option {if $smarty.section.i.iteration  == $get.duration}selected{/if} value="{$smarty.section.i.index+1}">{$smarty.section.i.index+1}</option>
                            {/section}

                        </select>
                    </div>
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
                <div style="" class="btn-sm-show">
                    {*<a class="btn btn--blue btn--submit-filter" href="/catalog">Сбросить</a>*}
                    <button class="btn btn--blue btn--submit-filter" type="submit">Искать</button>

                </div>
                <div style="text-align: right" class="btn-sm-hide">
                    {*<a class="btn btn--blue" href="/catalog">Сбросить</a>*}
                    <button class="btn btn--blue btn--submit-filter" type="submit">Искать</button>
                </div>
            </div>

        </div>
    </form>
</section>
<script>
    $('#address').autocomplete({
        source: '/system/controllers/catalog/autocomplete.php',
        //minLength: 2,
        delay: 1000,
        //appendTo: '#term'
    })
</script>