{include file="../../common/header.tpl"}


<main class="page-profile">
    <div class="container payment">
        <div class="row">
            <div class="col">
                <h1>Заказ №{$config->OrderPref}{$order['ID']}</h1>
                {if $order.STATUS == 0}

                <a class="btn btn--mini" href="/catalog/pay={$order.ID}">оплатить</a>
                {elseif $order.STATUS == 1}

                {/if}

                <div class="row">
                    <div class="col-lg-9">
                        <div class="profile-main">
                            <table class="table table-hover">
                                <tr>
                                    <th colspan="2" style="font-size: 20px;font-weight: bold;">
                                        <h2>Курсы</h2>
                                    </th>
                                </tr>
                                <tr style="font-weight: bold;">
                                    <th>Название</th>
                                    <th>Цена</th>
                                </tr>

                                {section name=i loop=$c_list}
                                <tr>
                                    <td>{$c_list[i].TITLE}</td>
                                    <td>
                                        {if $c_list[i].PRICE_NEW}£{$c_list[i].PRICE_NEW}{else}£{$c_list[i].PRICE}{/if}
                                    </td>
                                </tr>
                                {/section}
                                <tr>
                                    <th colspan="2">
                                        <hr />
                                    </th>
                                </tr>
                                <tr>
                                    <th colspan="2" style="font-size: 20px;font-weight: bold;">
                                        <h2>Проживание</h2>
                                    </th>
                                </tr>
                                <tr style="font-weight: bold;">
                                    <th>Вид</th>
                                    <th>Цена</th>
                                </tr>

                                {section name=i loop=$p_list2}
                                <tr>
                                    <td>{$p_list2[i]->name}</td>
                                    <td>£{$p_list2[i]->price}</td>
                                </tr>
                                {/section}
                                <tr>
                                    <th colspan="2">
                                        <hr />
                                    </th>
                                </tr>
                                <tr>
                                    <th colspan="2" style="font-size: 20px;font-weight: bold;">
                                        <h2>Дополнительные расходы</h2>
                                    </th>
                                </tr>
                                <tr style="font-weight: bold;">
                                    <th>Вид</th>
                                    <th>Цена</th>
                                </tr>

                                {section name=i loop=$d_list}
                                <tr>
                                    <td>{$d_list[i]->name}</td>
                                    <td>£{$d_list[i]->price}</td>
                                </tr>
                                {/section}
                            </table>
                            <p>Итого: £{$total}</p>
                        </div>
                    </div>
                    <div class="col-lg-3">
                        {include file="../../common/sidebar2.tpl"}
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

{include file="../../common/footer.tpl"}