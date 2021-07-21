<?php
if(!isset($_SESSION)){ session_start();}
date_default_timezone_set( 'Europe/Moscow' );
require_once(SYSTEM_DIR.'config/config.php');
require_once(SYSTEM_DIR.'smarty/SmartyBC.class.php');
require_once(CLASSES_DIR.'Config.class.php');
require_once(CLASSES_DIR.'Smart.class.php');
require_once(CLASSES_DIR.'DB.class.php');

function GetProductFromQuery($array, $id){
    $result = '';
    foreach ($array as $v){
        if ($v['ID']==$id){
            $result = $v;
            break;
        }
    }
    return $result;
}
function GetOptions(){
    $db = Database::getInstance();
    $options_temp = array();
    $params_temp = array();
    $sql = "SELECT * FROM `".db_pref."options`";
    $query = $db->query($sql);
    for ($i=0; $i < $db->num_rows($query); $i++) {
        $row = $db->fetch_array($query);
        $options_temp[] = $row;
    }
    $sql = "SELECT * FROM `".db_pref."options_parameter`";
    $query = $db->query($sql);
    for ($i=0; $i < $db->num_rows($query); $i++) {
        $row = $db->fetch_array($query);
        $params_temp[] = $row;
    }
    return array('options'=>$options_temp,'params'=>$params_temp);
}
function GetOptionName($options, $id){
    $result= '';
    foreach ($options as $v){
        if ($v['OPTION_ID'] == $id){
            $result = $v['OPTION_NAME'];
            break;
        }
    }
    return $result;
}
function GetParamName($params,$id){
    $result= '';
    foreach ($params as $v){
        if ($v['ID'] == $id){
            $result = $v['PARAMETER'];
            break;
        }
    }
    return $result;
}
function GetParamPrice($json,$id){
    $result = '';
    $op = json_decode($json);
    foreach ($op as $o){
        foreach ($o->params as $o2){
            if ($o2->id==$id){
                $result = $o2->price;
            }
        }
    }
    if ($result == '') $result = 0;
    return $result;
}
function GetParamMethod($json,$id){
    $result = '';
    $op = json_decode($json);
    foreach ($op as $o){
        foreach ($o->params as $o2){
            if ($o2->id==$id){
                $result = $o2->method;
            }
        }
    }
    return $result;
}
function GetProductsCart($list=false){
    $products_cart = array();
    if (isset($_COOKIE['cart'])){
        if (!$list) $list = $_COOKIE['cart'];
        $list_arr = array();
        if (isset($list)){
            $list_arr = unserialize($list);
        }
        $s = '';
        foreach ($list_arr as $v){
            if ($s!=='') $s .=',';
            $s .= "'".$v['id']."'";
        }
        if ($s !== ''){
            $db = Database::getInstance();
            $sql = "SELECT * FROM `".db_pref."shop_i` WHERE `PUBLIC`=1 AND `ID` IN ($s)";
            $query = $db->query($sql);
            for ($i=0; $i < $db->num_rows($query); $i++) {
                $row = $db->fetch_array($query);
                $products_cart[] = $row;
            }
        }
    }
    return $products_cart;
}

function GetCart($smarty, $list=false){
    $products = array();
    $total_price_all = 0;
    $total_count = 0;
    $current_product = array();
    if (!$list && isset($_COOKIE['cart'])) $list = $_COOKIE['cart'];
    $list_arr = array();
    if (isset($list)){
        $list_arr = unserialize($list);
    }
    if (is_array($list_arr) && count($list_arr) > 0){
        $products_cart = GetProductsCart($list);
        foreach ($list_arr as $v){
            $id = $v{'id'};
            $row = GetProductFromQuery($products_cart,$id);
            if ($row['ID'] == $id){
                $current_product = $row;
            }

            if ($row['PRICE_NEW'] > 0){
                $price = $row['PRICE_NEW'];

            } else {
                $price = $row['PRICE'];
            }

            $options_all = GetOptions();
            $options_cart = json_decode($v['param']);
            if (is_array($options_cart) && count($options_cart) > 0){
                foreach ($options_cart as $o){
                    $o->name = GetOptionName($options_all['options'],$o->id);
                    $o->param_name = GetParamName($options_all['params'],$o->param);
                    $o->param_price = GetParamPrice($row['OPTIONS'],$o->param);
                    if ($o->param_price > 0){
                        $o->param_method = GetParamMethod($row['OPTIONS'],$o->param);
                        if ($o->param_method == '+'){
                            $price = $price+$o->param_price;
                        }
                        if ($o->param_method == '-'){
                            $price = $price-$o->param_price;
                        }
                    }
                }
            }

            $count = $v{'count'};
            $total_count = $total_count + $count;
            $total_price = $price*$count;
            $total_price_all = $total_price_all+$total_price;

            $products[] = array('product' => $row, 'price' => $price, 'count' => $count, 'total_price' => $total_price,'options'=>$options_cart);
        }
    }

    $smarty->assign(array(
        'products' => $products,
        'total_count' => $total_count,
        'total_price_all' => $total_price_all,
        'current_product' => $current_product,
    ));
    $cart = $smarty->fetch($_SERVER['DOCUMENT_ROOT'].'/'.TEMPLATES_DIR.Config::getInstance()->Theme.'/tpl/common/cart.tpl');
    return $cart;
}
?>