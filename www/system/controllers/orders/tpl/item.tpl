<div method="post">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title text-uppercase">
                <span class="glyphicon glyphicon-duplicate"></span>
                Детали заказа
            </h3>
        </div>
        <div class="panel-body">
            <div class="form-horizontal" role="form">
                <p>Дата: {$order.DATE}</p>
                <form method="post">
                    <div class="row">

                        <div class="col-sm-3">Статус</div>
                        <div class="col-sm-6">
                            <select name="status" class="form-control">
                                <option value="0">Не оплачен</option>
                                <option {if $order.STATUS == 1} selected {/if} value="1">Оплачен</option>
                            </select>
                        </div>
                        <div class="col-sm-3"><button name="set-status" type="submit" class="btn btn-success btn-large"><span class="glyphicon glyphicon-floppy-disk"></span> Изменить статус</button></div>
                    </div>
                </form>

            </div>


            {section name=i loop=$cart}
            <div class="basket__group">
                <h3 style="font-weight: bold; margin-bottom: 40px;">Школа: <a target="_blank" href="/catalog/{$cart[i]->c_alias}">{$cart[i]->c_name}</a></h3>
                <h3 class="basket__group-name">Курсы</h3>
                <table class="table table-hover">
                    {section name=j loop=$cart[i]->c_list}
                        <tr>
                            <td>{$cart[i]->c_list[j]->name}</td>
                            <td>{$cart[i]->c_name}</td>
                            <td>Кол-во недель: {$cart[i]->c_list[j]->count_n}</td>
                            <td>{$cart[i]->c_currency} {$cart[i]->c_list[j]->price}</td>
                        </tr>
                    {/section}
                </table>

                <h3 class="basket__group-name">Проживание</h3>
                <table class="table table-hover">
                    {section name=j loop=$cart[i]->p_list}
                        <tr>
                            <td>{$cart[i]->p_list[j]->vid}</td>
                            <td>{$cart[i]->p_list[j]->name}</td>
                            <td>Кол-во недель: {$cart[i]->p_list[j]->count}</td>
                            <td>{$cart[i]->c_currency} {$cart[i]->p_list[j]->price * $cart[i]->p_list[j]->count}</td>
                        </tr>
                    {/section}
                </table>

                <h3 class="basket__group-name">Дополнительные расходы</h3>
                <table class="table table-hover">
                    {section name=j loop=$cart[i]->d_list}
                        <tr>
                            <td>{$cart[i]->d_list[j]->name}</td>
                            <td>{$cart[i]->c_currency} {$cart[i]->d_list[j]->price}</td>

                        </tr>
                    {/section}
                </table>
                <hr/>
            {/section}
        </div>
    </div>
</div>

