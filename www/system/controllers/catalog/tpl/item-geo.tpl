<div class="form-horizontal" role="form">

    <div class="form-group">
        <label class="col-sm-3 control-label">Страна:</label>
        <div class="col-sm-9">
            <select class="form-control" id="SiteCountryID" name="country_id">
                {section name=i loop=$countrys}
                    <option data-name="{$countrys[i].COUNTRY_NAME}" {if $countrys[i].COUNTRY_ID==$item.COUNTRY_ID}selected {/if} value="{$countrys[i].COUNTRY_ID}">{$countrys[i].COUNTRY_NAME}</option>
                {/section}
            </select>
            <input type="hidden" name="SiteCountry" id="SiteCountry" value="{$config->SiteCountry}"/>
        </div>
    </div>

   {* <div class="form-group">
        <label class="col-sm-3 control-label">Регион:</label>
        <div class="col-sm-9">
            <select class="form-control" id="SiteRegionID" name="region_id">
                {section name=i loop=$regions}
                    <option data-name="{$regions[i].REGION_NAME}" {if $regions[i].REGION_ID==$item.REGION_ID}selected {/if} value="{$regions[i].REGION_ID}">{$regions[i].REGION_NAME}</option>
                {/section}
            </select>
            <input type="hidden" name="SiteRegion" id="SiteRegion" value="{$config->SiteRegion}"/>
        </div>
    </div>*}

    <div class="form-group">
        <label class="col-sm-3 control-label">Город:</label>
        <div class="col-sm-9">
            <select class="form-control" id="SiteCityID" name="city_id">
                {section name=i loop=$city}
                    <option data-name="{$city[i].CITY_NAME}" {if $city[i].CITY_ID==$item.CITY_ID}selected {/if} value="{$city[i].CITY_ID}">{$city[i].CITY_NAME}</option>
                {/section}
            </select>
            <input type="hidden" name="SiteCity" id="SiteCity" value="{$config->SiteCity}"/>
        </div>
    </div>
    <div class="form-group">
        <label for="title" class="col-sm-3 control-label">Адрес:</label>
        <div class="col-sm-9">
            <textarea name="address" id="SiteAddress" cols="30" rows="5" class="form-control">{$item.ADDRESS}</textarea>
        </div>
    </div>
</div>


<script>
    function getData(sel){
        var r_id = sel.val();
        var Name;
        sel.find('option').each(function(i){
            var option = $(this);
            if (option.val() == r_id){
                Name = option.attr("data-name");
                return false;
            }
        });
        return Name;
    }
    var SiteCountryID = $("#SiteCountryID");
    var SiteCountry = $("#SiteCountry");
    var SiteRegionID = $("#SiteRegionID");
    var SiteRegion = $("#SiteRegion");
    var SiteCityID = $("#SiteCityID");
    var SiteCity = $("#SiteCity");
    SiteCountryID.change(function(){
        SiteCountry.val(getData($(this)));
        SiteCityID.html('<option>Загрузка</option>');
        $.ajax({
            type: 'POST',
            url: '{$html_controllers_dir}settings/ajax.php',
            data: 'get_city='+$(this).val(),
            success: function(result){
                SiteCityID.html(result);
                SiteCityID.change()
            }
        });
    });
    SiteRegionID.change(function(){
        SiteRegion.val(getData($(this)));
        SiteCityID.html('<option>Загрузка</option>');
        $.ajax({
            type: 'POST',
            url: '{$html_controllers_dir}settings/ajax.php',
            data: 'get_city='+$(this).val(),
            success: function(result){
                SiteCityID.html(result);
                SiteCityID.change();
            }
        });
    });
    SiteCityID.change(function(){
        SiteCity.val(getData($(this)));
    });
</script>