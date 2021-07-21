<div class="form-horizontal" role="form">
    <div class="col-sm-12">
    <h4>Сопутствующие товары</h4>
    </div>
    <div class="col-sm-12">
        <input id="link-products" type="text" class="form-control"/>
    </div>
    <div class="clearfix"></div>
    <div class="col-sm-12">
        <ul id="links" class="list-group">
            {section name=i loop=$products}
                {section name=j loop=$item_links}
                    {if $item_links[j] == $products[i].ID}
                        <li class="list-group-item" data-id="{$products[i].ID}"><a target="_blank" href="/shop/{$products[i].ID}">{$products[i].TITLE}</a><span class="pull-right text-danger remove" style="cursor: pointer"><span class="glyphicon glyphicon-remove-sign text-dange"></span></span></li>
                    {/if}
                {/section}
            {/section}
        </ul>
    </div>
    <input type="hidden" name="links" id="input-links"/>
</div>

<script>
    $(document).ready(function() {
        var products = [
           {section name=i loop=$products}
            {literal}{label:"{/literal}{$products[i].TITLE}", value:"{$products[i].ID}{literal}"},{/literal}
           {/section}
        ];
        {literal}
        var link_products = $("#link-products");
        var links = $("#links");
        function addLink(item){
            var b = true;
            var id;
            links.find('li').each(function(i,el){
                id = $(this).attr("data-id");
                if (id == item.value){
                    b = false;
                    return false;
                }
            });
            if (b){
                links.append('<li class="list-group-item" data-id="'+item.value+'"><a target="_blank" href="/shop/'+item.value+'">'+item.label+'</a><span class="pull-right text-danger remove" style="cursor: pointer"><span class="glyphicon glyphicon-remove-sign text-dange"></span></span></li>');
            }
        }

        $("#links").on("click", ".remove", function(e){
            var li = $(this).parent();
            li.remove();
        });
        link_products.autocomplete({
            source: products,
            select: function(event, ui) {
                link_products.val('');
                addLink(ui.item);
                return false;
            }
        });
    });



    {/literal}
</script>