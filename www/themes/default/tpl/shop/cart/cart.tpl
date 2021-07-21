{include file="../../common/header.tpl"}
<section>
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <ol class="breadcrumb">
                    <li>Вы находитесь:</li>
                    <li><a href="/">Главная</a></li>
                    <li class="active">{$page_title}</li>
                </ol>
            </div>
        </div>
    </div>

    <div class="container" id="cart-container">
        <div class="row">
		<div class="ota2">
		<div class="page-header">
			<h3>
				{$page_title} <small>оформите заказ</small>
			</h3>
			<p>Сегодня ни одна женщина не может обойтись в своем гардеробе без различных видов нижнего белья. Бюстгальтеры, трусики, чулки, колготки, боди – базовые элементы, которые обеспечивают комфорт и уверенность в себе. Более того, правильно подобранное нижнее белье способно скорректировать линии фигуры и преподнести Ваш наряд в более выгодном свете.</p>
		</div>
		</div>
		</div>
		<div class="row">
            <div class="col-sm-12">
			<div class="ota">
                {if $products}
                   <div class="col-sm-12">
                       <h3 class="">Оформите заказ или продолжите покупки
                           <a class="more-podp pull-right" href="/">Продолжить покупки</a>
                       </h3>
                   </div>

                    <table class="table">
                        <tr>
                            <th style="width: 10%;">Изображение</th>
                            <th>Название товара</th>
                            <th style="width: 185px;">Количество</th>
                            <th>Цена</th>
                            <th>Итого</th>
                        </tr>
                        {section name=i loop=$products}
                            <tr>
                                <td><a href="/shop/{$products[i].product.ALIAS}"><img class="img-responsive" src="/upload/images/shop/{$products[i].product.SKIN}" alt=""/></a></td>
                                <td><p><a href="/shop/{$products[i].product.ALIAS}" class="otr3">{$products[i].product.TITLE}</a><br>
								{section name=j loop=$products[i].options}
                                        {$products[i].options[j]->name}: {$products[i].options[j]->param_name}
                                        <br/>
                                    {/section}</p>
								</td>

                                <td>
                                    <div class="input-group">

                                        {if $products[i].count > 1}
                                            <a class="input-group-addon" href="#" onclick="SetQuantityCart({$smarty.section.i.index},{$products[i].count - 1});return false;"><i class="fa fa-minus"></i></a>
                                        {else}
                                        <span class="input-group-addon"><i class="fa fa-minus minus-fa"></i></span>
                                        {/if}

                                        <input readonly value="{$products[i].count}" type="text" class="form-control text-center">

                                        <a class="input-group-addon" href="#" onclick="SetQuantityCart({$smarty.section.i.index},{$products[i].count + 1});return false;"><i class="fa fa-plus"></i></a>


                                        <a class="text-danger input-group-addon btn-danger" href="#" onclick="DelCart2({$products[i].product.ID},{$smarty.section.i.index});return false;"><i class="fa fa-remove"></i></a>

                                    </div>
                                </td>
                                <td>{$products[i].price|number_format} руб.</td>
                                <td>{$products[i].total_price|number_format} руб.</td>
                            </tr>
                        {/section}
                    </table>
				 
					<div class="row">
                    <div class="col-sm-12 otr4">
                        <a class="more-podp pull-left" href="/">Продолжить покупки</a>
                        <a class="more-gold pull-right" href="/shop/order">Оформить заказ</a>
                        <h3 style="margin: 15px 34px 0 0;" class="pull-right">Итого: {$total_price_all|number_format} руб.</h3>
                        <div class="clearfix"></div>
                        <br/>
                    </div>
                {else}
                    <h3>Ваша корзина пуста!</h3>
                    <a class="more-podp" href="/">Продолжить покупки</a>
                {/if}
            </div>
		   </div>
        </div>
    </div>
 </div>
</section>




{include file="../../common/footer.tpl"}