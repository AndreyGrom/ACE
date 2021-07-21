<div class="alert alert-info">
    <h5><i class="fa fa-money"></i> Стоимость: {$price} <i class="fa fa-rub"></i></h5>
    <form class="form-inline" target="_blank" action="https://money.yandex.ru/quickpay/confirm.xml">
        <input type="hidden" name="need-email" value="true"/>
        <input type="hidden" name="receiver" value="410011333889756"/>
        <input type="hidden" name="formcomment" value="Андрей Гром. Сайт разработчика"/>
        <input type="hidden" name="short-dest" value="{$page_title}"/>
        <input type="hidden" name="targets" value="Покупка {$page_title}"/>
        <input type="hidden" name="sum" value="{$price}"/>
        <input type="hidden" name="quickpay-form" value="shop"/>
        <div class="form-group">
            <label class="" for="paymentType">Способ оплаты</label>
            <select id="paymentType" class="form-control" name="paymentType">
                <option value="AC">Банковская карта</option>
                <option value="PC">Яндекс.Деньги</option>
            </select>
        </div>
        <button name="submit-button" type="submit" class="btn btn-success btn-large"><i class="fa fa-shopping-cart"></i> Купить</button>
    </form>
    <p></p>
    <p>После нажатия на кнопку <strong>Купить</strong> Вы будете переведены на страницу платежной системы, где Вам, помимо платежных данных, нужно будет ввести свой e-mail. После успешной оплаты и проверки платежа на этот адрес будет выслана Ваша покупка.</p>
    <ul class="list-inline">
        <li><i class="fa fa-certificate"></i> <a href="">Гарантии</a></li>
        <li><i class="fa fa-info-circle"></i> <a href="">Условия предоставления услуг</a><li>
    </ul>
</div>