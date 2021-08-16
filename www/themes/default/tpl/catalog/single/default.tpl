{include file="../../common/header.tpl"}
<input type="hidden" id="sh_id" value="{$item.ID}"/>
<input type="hidden" id="sh_name" value="{$item.TITLE}"/>
<input type="hidden" id="c_currency" value="{$item.C_ZN}"/>
<input type="hidden" id="c_photo" value="{$item.PHOTO2}"/>
<input type="hidden" id="c_alias" value="{$item.ALIAS}"/>

<main class="body-school">
    <div class="container">

<!-- BANNER -->
<div class="banner" style="background-image: url(/upload/images/catalog/{$item.PHOTO2});">
    <div class="h1-hldr">
    {*    <h1>{$item.TITLE}</h1>
        <p class="overview-location"><i class="fas fa-globe-americas" aria-hidden="true"></i> {$item.CITY_NAME}, {$item.COUNTRY_NAME}</p>*}
    </div>
</div> <!-- .banner -->

<!-- SECONDARY NAVBAR -->
<nav class="navbar navbar-secondary navbar-expand-md">
    <ul class="navbar-nav mr-auto">
        <li class="nav-item active">
            <a class="nav-link" href="#">O школе <span class="sr-only">(current)</span></a>
        </li>
        <li class="nav-item active">
            <a class="nav-link" href="#section-courses">Курсы ({count($courses)})</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#section-pros">Проживание ({count($pros)})</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#section-dops">Дополнительные расходы</a>
        </li>
    </ul>
</nav>

<div class="row">
<div class="col-sm-12 col-lg-8 col-primary">
<br/>
<h1>{$item.TITLE}</h1>

<p class="overview-location"><i class="fas fa-globe-americas" aria-hidden="true"></i> {$item.CITY_NAME}, {$item.COUNTRY_NAME}</p>

{if $cart_c}
    <div class="alert alert-info">
        <h2>Из этой школы у вас в корзине:</h2>
        <table class="table">
            {if $cart_c->c_list}
                {section name=j loop=$cart_c->c_list}
                    <tr><th colspan="2">{$cart_c->c_list[j]->name}</th></tr>
                    <tr><td>Кол-во недель: {$cart_c->c_list[j]->count_n}</td><td>{$cart_c->c_currency} {$cart_c->c_list[j]->price}</td></tr>
                {/section}
            {/if}
            {if $cart_c->p_list}
                <tr><th colspan="2">Проживание</th></tr>
                {section name=j loop=$cart_c->p_list}
                    <tr><td>{$cart_c->p_list[j]->name}</td><td>{$cart_c->c_currency} {$cart_c->p_list[j]->price}</td></tr>
                {/section}
            {/if}
            {if $cart_c->d_list}
                <tr><th colspan="2">Дополнительные расходы</th></tr>
                {section name=j loop=$cart_c->d_list}
                    <tr><td>{$cart_c->d_list[j]->name}</td><td>{$cart_c->c_currency} {$cart_c->d_list[j]->price}</td></tr>
                {/section}
            {/if}
        </table>
        <p style="text-align: right"><a href="/catalog/cart">Перейти в корзину</a></p>
    </div>
{/if}
<!-- SECTION. OVERVIEW -->
<div class="section section-overview">

    <dl class="row dl-overview">
        <dt class="col-md-4"><i class="fa fa-calendar-check-o" aria-hidden="true"></i> Даты:</dt>
        <dd class="col-md-8">{$item.DATE1}</dd>

        <dt class="col-md-4"><i class="fas fa-graduation-cap" aria-hidden="true"></i> Продолжительность:</dt>
        <dd class="col-md-8">от {$item.MIN_COUNT} недель</dd>

        <dt class="col-md-4"><i class="fa fa-map-marker" aria-hidden="true"></i> Расположение:</dt>
        <dd class="col-md-8">{$item.ADDRESS}, {$item.CITY_NAME}, {$item.COUNTRY_NAME}</dd>

        <dt class="col-md-4"><i class="fa fa-id-card-o" aria-hidden="true"></i> Возраст студентов:</dt>
        <dd class="col-md-8">от {$item.VOZ} (средний - {$item.S_VOZ})</dd>

        <dt class="col-md-4"><i class="fa fa-users" aria-hidden="true"></i> Человек в группе:</dt>
        <dd class="col-md-8">максимум {$item.COUNT_G} (в среднем {$item.S_COUNT_G})</dd>
    </dl>

    {if $item.PDF}<a target="_blank" href="/upload/files/catalog/{$item.PDF}" class="lnk-doc btn btn-secondary" style="float:right; margin-top: -5px; text-decoration: none;"><i class="fa fa-download" aria-hidden="true"></i> Памятка студенту <span>(PDF)</span></a>{/if}
    <p class="content-rAAAAAAAA" style="margin-bottom: 25px;"><a href="#" class="lnk-top-nations" data-toggle="tooltip" data-placement="bottom" data-html="true" title="
                    {section name=i loop=$item.TOP_N}
                    <em>{$item.TOP_N[i][0]} <b>{$item.TOP_N[i][1]}%</b></em>
                    {/section}
                    "><i class="fa fa-star" aria-hidden="true"></i>  Топ национальностей</a></p>
    <div class="top-nationals">

    </div>


    {$item.SHORT_CONTENT}

  {*  <div class="collapse" id="collapseMoreInfo">


    </div>

    <p class="p-show-more"><a class="" data-toggle="collapse" href="#collapseMoreInfo" role="button" aria-expanded="false" aria-controls="collapseMoreInfo" id="readMoreBtn1">
            Read <span>more</span> <i aria-hidden="true">/</i> <span aria-hidden="true">less</span>
        </a>
    </p>*}

</div> <!-- .section-overview -->



<!-- SECTION. COURSES -->
<div class="section section-courses" id="section-courses">
    <h2>Курсы</h2>

    <p class="note"><i class="fas fa-percentage" aria-hidden="true"></i>Бронируя курсы через нашу компанию, вы получаете возможность <b>скидки 10%</b> от стоимости школы, делая это напрямую.</p>

    <div id="courseList">
        {section name=i loop=$courses}
        <!-- CARD -->
        <div class="card">
            <div class="card-header" id="heading-{$courses[i].ID}">
                <h3 class="mb-0" data-toggle="collapse" data-target="#collapse-{$courses[i].ID}" aria-expanded="{if $smarty.section.i.index == 0}true{else}false{/if}" aria-controls="collapse-{$courses[i].ID}">
                    <i class="fa fa-angle-double-right" aria-hidden="true"></i> {$courses[i].TITLE}
                </h3>
            </div>

            <div id="collapse-{$courses[i].ID}" class="collapse {if $smarty.section.i.index == 0}show{/if}" aria-labelledby="heading-{$courses[i].ID}" data-parent="#courseList">
                <div class="card-body">

                    <div class="row">
                        <div class="col-md-12">
                            <p class="facts"><span><i class="fa fa-list-alt" aria-hidden="true"></i> {round($courses[i].COUNT_UR)} часов</span> <span><i class="fa fa-clock-o" aria-hidden="true"></i> Урок: {$courses[i].PRODOL_UR} мин</span> <span><i class="fa fa-graduation-cap" aria-hidden="true"></i> Минимальный уровень: {$courses[i].MIN_LEVEL}</span></p>

                            <table>
                                <tr>
                                    <td><b>Даты:</b></td><td>{$courses[i].DATE_START}</td>
                                </tr>
                                <tr>
                                    <td>
                                        <b>Продолжительность:</b>
                                    </td>
                                    <td>
                                        {if $courses[i].COUNT_OT == $courses[i].COUNT_DO}
                                            {$courses[i].COUNT_DO} недели
                                         {else}
                                            {$courses[i].COUNT_OT}{if $courses[i].COUNT_DO} - {$courses[i].COUNT_DO}{/if} недели
                                        {/if}
                                    </td>
                                </tr>
                            </table>

                            {$courses[i].DESC}

                            <p><b>Время занятий</b></p>
                            {$courses[i].TIME_DESC}
                        </div>
                    </div>

                    <div class="row row-select-btn align-items-end">


                        {*<div class="col-md-4">
                            <input type="hidden" class="price_s" value="{$courses[i].PRICE}"/>
                            <input type="hidden" class="price_s_n" value="{$courses[i].PRICE_NEW}"/>
                            <select class="custom-select price_n">
                                {section name=j loop=$courses[i].COUNT_DO+1 start=$courses[i].COUNT_OT}
                                    <option value="{$smarty.section.j.index}">{$smarty.section.j.index}{decliner qty=$smarty.section.j.index word=' неделя, недели, недель'}</option>
                                {/section}

                            </select>
                        </div>*}

                        <div class="col-md-4 course-price">
                            <span class="label">Часы: </span>
                            <span style="display: none;" class="j_price">{$courses[i].PACKS}</span>
                            <span style="display: none;" class="j_price_n"></span>
                            <select class="custom-select select-price select js-select form-control">
                                <option value="0">Выбрать</option>
                                {section name=j loop=$courses[i].PACKS2}
                                    <option value="{$courses[i].PACKS2[j][0]}">{$courses[i].PACKS2[j][0]}</option>
                                {/section}
                            </select>

                        </div>
                        <div class="col-md-2">
                            <div style="display: none;">
                                <span class="label">Недели: </span>
                                <select class="custom-select select-price-2 select js-select form-control">

                                </select>
                            </div>

                        </div>
                        <div class="col-sm-3 curr-price">
                            <span></span>
                        </div>
                        <div class="col-md-3">

                            <button style="display: none"
                                    data-course-id="{$courses[i].ID}"
                                    data-p="{$price}"
                                    data-p_n="{$price_new}"
                                    data-course-name="{$courses[i].TITLE}"
                                    data-count-n="{$courses[i].COUNT_OT}"
                                    type="button" class="btn btn-secondary btn-select-course">
                                Выбрать
                            </button>
                        </div>

                    </div>
                   <div class="sel-table" style="display: none;">
                       <p class="title">Система скидок:</p>
                       <table class="table sel-table">
                           <thead>

                           <tr>
                               <th>Недели от</th>
                               <th>Недели до</th>
                               <th>Стоимость недели</th>
                           </tr>
                           </thead>
                           <tbody>

                           </tbody>
                       </table>
                   </div>
                </div>
            </div>
        </div>
        {/section}


    </div>

</div> <!-- .section-courses -->

{if $pros}
<div class="section section-accomodation" id="section-pros">
    <h2>Проживание</h2>
    <div class="custom-control custom-checkbox checkbox-required">
        <input type="checkbox" class="custom-control-input" id="customCheck1" checked="" data-toggle="collapse" data-target="#accomodationList" aria-expanded="true" aria-controls="accomodationList">
        <label class="custom-control-label" for="customCheck1">Необходимо</label>
    </div>

    <div id="accomodationList" class="collapse show">
        {section name=i loop=$pros}
        <!-- CARD -->
        <div class="card">
            <div class="card-header" id="heading-2{$smarty.section.i.index}">
                <h3 class="mb-0" data-toggle="collapse" data-target="#collapse-2{$smarty.section.i.index}" aria-expanded="{if $smarty.section.i.index == 0}true{else}false{/if}" aria-controls="collapse-2{$smarty.section.i.index}">
                    {$pros[i].VID}
                </h3>
            </div>

            <div id="collapse-2{$smarty.section.i.index}" class="collapse {if $smarty.section.i.index == 0}show{/if}" aria-labelledby="heading-2{$smarty.section.i.index}" data-parent="#accomodationList">
                <div class="card-body">

                    <div class="row">
                        <div class="col-md-12">
                            <!--                               <h4>Проживание в семье</h4>
                             -->
                            <dl class="row dl-accom-overview">
                                <dt class="col-md-4"><i class="fa fa-calendar-check-o"></i> Даты:</dt>
                                <dd class="col-md-8">{$pros[i].DATE1}</dd>
                                <dt class="col-md-4"><i class="fa fa-birthday-cake" aria-hidden="true"></i> Возраст:</dt>
                                <dd class="col-md-8">{$pros[i].VOZRAST}</dd>
                                <dt class="col-md-4"><i class="fa fa-suitcase" aria-hidden="true"></i> Заезд:</dt>
                                <dd class="col-md-8">{$pros[i].GEO1}</dd>
                                <dt class="col-md-4"><i class="fa fa-suitcase" aria-hidden="true"></i> Выселение:</dt>
                                <dd class="col-md-8">{$pros[i].GEO2}</dd>
                                <dt class="col-md-4"><i class="fa fa-map-marker" aria-hidden="true"></i> Расположение:</dt>
                                <dd class="col-md-8">{$pros[i].GEO}</dd>
                            </dl>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">

                            {$pros[i].DESC}
                        </div>
                    </div>

                    <div class="row">
                        {if $pros[i].PHOTO1}
                        <div class="col-md-6">
                            <img src="/upload/images/catalog/{$pros[i].PHOTO1}" class="img-fluid">
                        </div>
                        {/if}
                        {if $pros[i].PHOTO2}
                        <div class="col-md-6">
                            <img src="/upload/images/catalog/{$pros[i].PHOTO2}" class="img-fluid">
                        </div>
                        {/if}
                    </div>

                    <div class="row accom-facilities">
                        {section name=j loop=$pros[i].INCS}
                            {section name=k loop=$incs}
                                {if $incs[k].ID == $pros[i].INCS[j]}
                                <div class="cols col-sm-12 col-md-6">
                                    {$incs[k].ICON} {$incs[k].TITLE}
                                </div>
                                {/if}
                            {/section}
                        {/section}

                    </div>

                    <div class="row">
                        <div class="col-md-12">


                        </div>
                    </div>
                    
                    <div class="row row-select-btn">
                        <div class="col-md-9">
                            <select class="custom-select select-pro select js-select form-control">
                                {section name=j loop=$pros[i].PACKS}
                                    <option data-name="{$pros[i].PACKS[j][0]}" data-price="{$pros[i].PACKS[j][1]}">{$pros[i].PACKS[j][0]} по цене  {$item.C_ZN}{$pros[i].PACKS[j][1]}</option>
                                {/section}
                            </select>
                        </div>

                        <div class="col-md-3">
                            <button data-photo="{$pros[i].PHOTO1}" data-vid="{$pros[i].VID}" data-id="{$pros[i].ID}" data-name="{$pros[i].PACKS[0][0]}" data-price="{$pros[i].PACKS[0][1]}" type="button" class="btn btn-secondary btn-select-pro">Выбрать</button>
                        </div>
                    </div>

                </div>
            </div>
        </div> <!-- .card -->
        {/section}

    </div>

</div> <!-- .section-accomodation -->
{/if}

{if $item.DOPS}
<div class="section section-extras" id="section-dops">
    <h2>Дополнительные расходы</h2>

    <table class="table">
        <tbody>
        {section name=i loop=$item.DOPS}
            {section name=j loop=$dops}
                {if $dops[j].TYPE == 0 && $item.DOPS[i][0] == $dops[j].ID}
                    {assign var=a value=true}
                {/if}
                {if $dops[j].TYPE == 1 && $item.DOPS[i][0] == $dops[j].ID}
                    {assign var=b value=true}
                {/if}
                {if $dops[j].TYPE == 2 && $item.DOPS[i][0] == $dops[j].ID}
                    {assign var=c value=true}
                {/if}
            {/section}
        {/section}

        {if $a}
        <tr><th colspan="3">Обязательные расходы</th></tr>
        {section name=i loop=$item.DOPS}
            {section name=j loop=$dops}
                {if $dops[j].TYPE == 0 && $item.DOPS[i][0] == $dops[j].ID}
                    <tr class="dop_price" data-name="{$dops[j].TITLE}" data-id="{$dops[j].ID}" data-price="{$item.DOPS[i][1]}">
                        <td><input class="form-check-input" type="checkbox" value="" checked disabled></td>
                        <td class="dop-title">{$dops[j].TITLE}</td>
                        <td>{$item.C_ZN}{$item.DOPS[i][1]}</td>
                    </tr>
                {/if}
            {/section}
        {/section}
        {/if}

        {if $b}
        <tr><th colspan="3">На выбор</th></tr>
         {*   {$item.DOPS|debug_print_var}*}
        {section name=i loop=$item.DOPS}
            {section name=j loop=$dops}
                {if $dops[j].TYPE == 1 && $item.DOPS[i][0] == $dops[j].ID}
                    <tr class="dop_price" data-name="{$dops[j].TITLE}" data-id="{$dops[j].ID}" data-price="{$item.DOPS[i][1]}">
                        <td><input class="form-check-input" type="checkbox" value="" id=""></td>
                        <td class="dop-title">{$dops[j].TITLE}</td>
                        <td>{$item.C_ZN}{$item.DOPS[i][1]}</td>
                    </tr>
                {/if}
            {/section}
        {/section}
        {/if}

        {if $c}
        <tr><th colspan="3">Не включенные расходы:</th></tr>
        {section name=i loop=$item.DOPS}
            {section name=j loop=$dops}
                {if $dops[j].TYPE == 2 && $item.DOPS[i][0] == $dops[j].ID}
                    <tr>
                        <td class="bulleted"></td>
                        <td colspan="3">{$dops[j].TITLE}</td>
                        <td></td>
                    </tr>
                {/if}
            {/section}
        {/section}
        {/if}
        </tbody>
    </table>

    <p class="asterisk"><sup>*</sup> В Великобритании для прохождения курсов медицинское страхование не является обязательным требованием, но может быть приобретена самостоятельно по желанию студента.  Авиабилеты так же оплачиваются студентом самостоятельно.</p>

</div> <!-- .section-extras -->
{/if}
</div><!-- .col-primary -->

    <div class="col-sm-12 col-lg-4 col-secondary">
        <form id="add-order-form" method="post">
            <textarea id="order-j" name="order-j" style="display: none;"></textarea>
            <div class="inner" id="inner">
                <div class="scroll">
                    <table class="table-costs">
                        <tbody>
                       {* {if $cart_c}
                            {if $cart_c->c_list}
                                {section name=j loop=$cart_c->c_list}
                                    <tr><th colspan="2" class="name"><span>{$cart_c->c_list[j]->name}</span></th></tr>
                                    <tr><td>Кол-во недель: {$cart_c->c_list[j]->count_n}</td><td>{$cart_c->c_currency} {$cart_c->c_list[j]->price}</td></tr>
                                {/section}
                            {/if}
                            {if $cart_c->p_list}
                                <tr><th colspan="2">Проживание</th></tr>
                                {section name=j loop=$cart_c->p_list}
                                    <tr><td>{$cart_c->p_list[j]->name}</td><td>{$cart_c->c_currency} {$cart_c->p_list[j]->price}</td></tr>
                                {/section}
                            {/if}
                            {if $cart_c->d_list}
                                <tr><th colspan="2">Дополнительные расходы</th></tr>
                                {section name=j loop=$cart_c->d_list}
                                    <tr><td>{$cart_c->d_list[j]->name}</td><td>{$cart_c->c_currency} {$cart_c->d_list[j]->price}</td></tr>
                                {/section}
                            {/if}
                        {else}*}
                            <tr><td colspan="2"><span class="no-selection">Ничего не выбрано</span></td></tr>
                        {*{/if}*}
                        </tbody>
                    </table>
                </div>
                <button name="order-form" type="submit" class="btn btn-primary add-to-cart">Зарезервировать</button>
            </div>
        </form>
    </div>
</div>
<div class="modal fade" id="Modal1" role="dialog">
    <div class="modal-dialog">

        <div class="modal-content">
            <div class="modal-header" style="padding:35px 50px;">

            </div>
            <div class="modal-body" style="padding:40px 50px;">
                <h3>Корзина обновлена!</h3>
            </div>
            <div class="modal-footer">
                <p><a class="btn btn--blue" href="/catalog/cart">Перейти в корзину</a></p>
                <button type="submit" class="btn btn-danger btn-default pull-left" data-dismiss="modal"><span class="glyphicon glyphicon-remove"></span> Закрыть</button>
            </div>
        </div>

    </div>
</div>



</div> <!-- .container -->
</main>

{include file="../../common/footer.tpl"}