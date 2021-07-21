<?php
session_start();
date_default_timezone_set( 'Europe/Moscow' );
require_once(SYSTEM_DIR.'config/config.php');
require_once(SYSTEM_DIR.'smarty/SmartyBC.class.php');
require_once(CLASSES_DIR.'Config.class.php');
require_once(CLASSES_DIR.'Smart.class.php');
require_once(CLASSES_DIR.'DB.class.php');

require_once(dirname(__FILE__).'/func.php');

function GetCart2($list){
    $smarty = Smart::getInstance();
    return GetCart($smarty,$list);
}

if ($_POST['act']=='add'){
    $list_arr = array();
    $id = $_POST['id'];
    $count = $_POST['count'];
    $param = $_POST['param'];
    $list = $_COOKIE['cart'];
    if (isset($list)){
        $list_arr = unserialize($list);
    }
    $exists = false;
    if (count($list_arr) > 0){
        foreach ($list_arr as &$v){
            if ($v['id'] == $id && $v['param']==$param){
                $v['count'] =  $v['count']+$count;
                $exists = true;
            }
        }
    }
    if (!$exists){
        $list_arr[] = array('id' => $id, 'count' => $count,'param'=>$param);
    }
    $list = serialize($list_arr);
    setcookie('cart',$list,time()+3600*24*7,'/');
    echo GetCart2($list);
}

if ($_POST['act']=='del'){
    $list_arr = array();
    $list_arr2 = array();
    $id = $_POST['id'];
    $pid = (int)$_POST['pid'];
    $list = $_COOKIE['cart'];
    if (isset($list)){
        $list_arr = unserialize($list);
    }
    if (count($list_arr) > 0){
        foreach ($list_arr as $k=>$v){
            /*if ($v['id'] !== $id){*/
            if ($k !== $pid){
                $list_arr2[] = $v;
            }
        }
    }
    $list = serialize($list_arr2);
    setcookie('cart',$list,time()+3600*24*7,'/');
    echo GetCart2($list);
}
if ($_POST['act']=='quantity'){
    $list_arr = array();
    $list_arr2 = array();
    $quantity = $_POST['quantity'];
    $pid = (int)$_POST['pid'];
    $list = $_COOKIE['cart'];
    if (isset($list)){
        $list_arr = unserialize($list);
    }
    if (count($list_arr) > 0){
        foreach ($list_arr as $k=>$v){
            if ($k == $pid){
                $v['count'] = $quantity;
            }
            $list_arr2[] = $v;
        }
    }
    $list = serialize($list_arr2);
    setcookie('cart',$list,time()+3600*24*7,'/');
}
?>