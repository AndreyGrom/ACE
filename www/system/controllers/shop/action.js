
function AddCart(id,count,param){
    $.ajax({
        type: 'POST',
        url: '/system/controllers/shop/cart.php',
        data: 'act=add&id='+id+'&count='+count+'&param='+param,
        success: function(result){
            $("#cart-box").html(result);
            $(".cart-product-modal").modal({'show':true});
        }
    });
}
function DelCart(id,pid){
    $.ajax({
        type: 'POST',
        url: '/system/controllers/shop/cart.php',
        data: 'act=del&id='+id+'&pid='+pid,
        success: function(result){
            $("#cart-box").html(result);
        }
    });
}
function DelCart2(id,pid){
    $.ajax({
        type: 'POST',
        url: '/system/controllers/shop/cart.php',
        data: 'act=del&id='+id+'&pid='+pid,
        success: function(result){
            document.location.href='/shop/cart';
        }
    });
}
function SetQuantityCart(pid,quantity){
    $.ajax({
        type: 'POST',
        url: '/system/controllers/shop/cart.php',
        data: 'act=quantity&quantity='+quantity+'&pid='+pid,
        success: function(result){
            document.location.href='/shop/cart';
        }
    });
}