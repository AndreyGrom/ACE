{include file="../../common/header.tpl"}

<main>
	<section class="container">
    
        <div class="catalog-heading">
            <h1>Школы и курсы</h1>

        </div>

        {include file="../../common/filter.tpl"}

        <div class="row">
            <div class="catalog__header col">{$page_title} <span></span></div>

            <div class="catalog__heading col align-self-end">
                    <div class="catalog__sort">
                        <span class="catalog__sort-name"></span>

                        <div class="catalog__sort-select">
                            <select class="select select--border js-select" name="" id="sort-select">
                                <option value="">Сортировать</option>
                                <option {if $sort=='rating'}selected{/if} value="rating">по рейтингу</option>
                                <option {if $sort=='price-desc'}selected{/if} value="price-desc">по убыванию цены</option>
                                <option {if $sort=='price-asc'}selected{/if} value="price-asc">по возрастанию цены</option>
                            </select>
                        </div>
                    </div>
                </div>
        </div>


        {if $items}
            <div class="catalog__list">
                {section name=i loop=$items}
                    <a href="/catalog/{$items[i].ALIAS}" class="catalog__item product">
                        <img class="product__img" catalog__item="" src="/upload/images/catalog/{$items[i].PHOTO1}"
                             alt="" width="260" height="187">

                        <div class="product__desc">
                            <div class="product__heading">
                                <div class="product__name">
                                    <span>{$items[i].TITLE}</span>
                                    <ul class="rating">
                                        {section name=j loop=5 start = 0}
                                            {*{$smarty.section.j.iteration}*}
                                            <li class="{if $items[i].RATING >= $smarty.section.j.iteration}isset{else}empty{/if}"></li>
                                        {/section}
    
                                    </ul>
                                </div>
                                
                            </div>

                            <p class="product__city">{$items[i].CITY_NAME}, {$items[i].REGION_NAME}
                                , {$items[i].COUNTRY_NAME}</p>

                            <table class="product__params">
                                <tr>
                                    <td>Возраст:</td>
                                    <td>от {$items[i].VOZ}</td>
                                </tr>
                                <tr>
                                    <td>Даты:</td>
                                    <td>{$items[i].DATE1}</td>
                                </tr>
                                <tr>
                                    <td>Продолжительность:</td>
                                    <td>{$items[i].COUNT_OT}-{$items[i].COUNT_DO} недель</td>
                                </tr>
                            </table>

                            <p class="product__tags">
                                {if $items[i].P_25}<span class="tag tag--red">25+</span>{/if}
                                {if $items[i].P_M}<span class="tag tag--blue">для молодежи</span>{/if}
                                {if $items[i].P_TOP}<span class="tag tag--green">для топ менеджеров</span>{/if}
                            </p>
                        </div>
                        <div class="product__price"> от {$items[i].MIN_PRICE} {$items[i].C_ZN} <span>в неделю</span></div>
                    </a>
                {/section}
            </div>
            {$pagination}
        {else}
            По данному запросу ничего не найдено :(
        {/if}

	</section>
</main>



{include file="../../common/footer.tpl"}

