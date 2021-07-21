{include file="../../common/header.tpl"}


<main class="page-profile">
    <div class="container">
        <div class="row">
            <div class="col">
                <h1>Мои заказы</h1>

                <div class="row">
                    <div class="col-lg-9">
                        <div class="profile-main">
                            {if $orders}
                            <table class="table">
                                <tr>
                                    <td>№ заказа</td>
                                    <td>Дата</td>
                                    <td>Статус</td>
                                    <td></td>
                                </tr>
                                {section name=i loop=$orders}
                                <tr>
                                    <td>
                                        <a
                                            href="/register/order={$orders[i].ID}">{$config->OrderPref}{$orders[i].ID}</a>

                                    </td>
                                    <td>{$orders[i].DATE_START}</td>
                                    <td>
                                        {if $orders[i].STATUS == 0}
                                        Не оплачен
                                        {elseif $orders[i].STATUS == 1}
                                        Оплачен
                                        {/if}
                                    </td>
                                    <td>
                                        {if $orders[i].STATUS == 0}
                                        <a class="btn btn-xs btn--mini" href="/catalog/pay={$orders[i].ID}">Оплатить</a>
                                        <a class="btn btn-xs btn--mini confirm"
                                            href="/register/delete-order={$orders[i].ID}">Удалить</a>

                                        {/if}

                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4">
                                        <hr />
                                    </td>
                                </tr>
                                {/section}
                            </table>
                            {else}
                            <p>У вас еще нет заказов</p>
                            {/if}
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