<div class="container">
    <div class="search-sidebar">
        <h2>Найти отличную школу за рубежом</h2>

        <p class="search-sidebar__desc">Забронируйте курс дешевле, чем напрямую в школе</p>

        <form class="search-sidebar__form">
            <p>
                <div class="input">
                         <select id="predmet" class="select">
                             <option value="0">Чему хотите научиться</option>
                             {section name=i loop=$predmets}
                                 <option value="{$predmets[i].ID}">{$predmets[i].TITLE}</option>
                             {/section}
                         </select>
                </div>
            </p>
            <p>
            <div class="">
                <div class="row">
                    <div class="col-md-6">
                        <select class="select" id="SiteCountryID" name="country_id">
                            <option value="0">Страна</option>
                            {section name=i loop=$countries}
                                <option value="{$countries[i].COUNTRY_ID}">{$countries[i].COUNTRY_NAME}</option>
                            {/section}

                        </select>
                    </div>
                    <div class="col-md-6" style="padding-left: 0px;">
                        <input name="address" id="address" class="input__control" type="text" placeholder="Адрес (необязательно)"/>
                    </div>
                </div>


            </div>
            </p>
            <button class="btn" type="submit">Искать</button>
        </form>
    </div>
</div>
<script>
    $('#address').autocomplete({
        source: '/system/controllers/catalog/autocomplete.php',
        //minLength: 2,
        delay: 1000,
        //appendTo: '#term'
    })
</script>