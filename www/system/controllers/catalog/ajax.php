<?php
require_once($_SERVER['DOCUMENT_ROOT'].'/system/classes/DB.class.php');
$db = Database::getInstance();
$sql = "SELECT * FROM agcms_cart WHERE HASH = '" . $_COOKIE['hash_cart'] . "'";
$cart = $db->select($sql, array('single_array' => true));
$cart = json_decode($cart['ORDER']);
$id = $_POST['id'];
$sh = $_POST['sh'];
if (isset($_POST['pro'])){
    $w = $_POST['c'];
    $rs = 0;
    $total = 0;
    foreach ($cart as &$c){
        foreach($c->p_list as &$cc){
            if ($cc->id == $id){
                $cc->count = $w;
                $rs = $w * $cc->price;
            }
        }
    }

    $params = array(
        'ORDER' => json_encode($cart,  JSON_UNESCAPED_UNICODE),
    );
    $db->update('agcms_cart', $params, "HASH = '" . $_COOKIE['hash_cart'] . "'");

/*    foreach ($cart as &$c){
        if ($c->id == $sh){
            foreach ($c->c_list as $c2){
                $total = $total + $c2->price;
            }
            foreach ($c->p_list as $c2){
                $total = $total + $c2->price*$c2->count;
            }
            foreach ($c->d_list as $c2){
                $total = $total + $c2->price;
            }
        }
    }

    $rs = array(
        'total' => $total,
        'week'  => $rs,
    );*/
}

if (isset($_POST['week'])){
    $w = $_POST['c'];
    $rs = 0;
    $total = 0;
    foreach ($cart as &$c){
        foreach($c->c_list as &$cc){
            if ($cc->id == $id){
                $cc->count_n = $w;

                $cc->price = $cc->price_one * $w;
                $rs = $w * $cc->price_one;
            }
        }
    }

    $params = array(
        'ORDER' => json_encode($cart,  JSON_UNESCAPED_UNICODE),
    );
    $db->update('agcms_cart', $params, "HASH = '" . $_COOKIE['hash_cart'] . "'");


}

foreach ($cart as &$c){
    if ($c->id == $sh){
        foreach ($c->c_list as $c2){
            $total = $total + $c2->price;
        }
        foreach ($c->p_list as $c2){
            $total = $total + $c2->price*$c2->count;
        }
        foreach ($c->d_list as $c2){
            $total = $total + $c2->price;
        }
    }
}

$rs = array(
    'total' => $total,
    'week'  => $rs,
);

echo json_encode($rs);
?>