<?php
require_once(dirname(__FILE__).'/func.php');

function print_latest_shop ($params, &$smarty) {
    $items = array();
    if (isset($params['count'])){
        $db = Database::getInstance();
        $count = $params['count'];
        $source = $params['source'];
        $show_parent_category = $params['parent'];
        $image_width = $params['image_width'];
        $image_height = $params['image_height'];
        $sql = "SELECT * FROM `".db_pref."shop_i` WHERE `PUBLIC`=1 ORDER BY ID DESC LIMIT $count";
        $query = $db->query($sql);
        if ($db->num_rows($query) > 0){
            for ($i=0; $i < $db->num_rows($query); $i++) {
                $row = $db->fetch_array($query);
                if (isset($image_width) && isset($image_height)){
                    $row['SKIN_NEW'] = Func::getInstance()->GetImage(UPLOAD_IMAGES_DIR.'shop/'.$row['SKIN'], $image_width,$image_height,'','shop');
                }

                if (isset($show_parent_category) && $show_parent_category){
                    /*Получаем список категорий, к которым принадлежит материал*/
                    $str = $row['PARENT'];
                    $parents = explode(",",$str);
                    $parents = array_filter($parents);
                    sort($parents);
                    $str = implode(",",$parents);
                    if (count($parents)>0) {
                        $sql2 = "SELECT * FROM `".db_pref."shop_c`  WHERE `ID` IN ($str) AND `PUBLIC`=1";
                        $query2 = $db->query($sql2);
                        for ($i2=0; $i2 < $db->num_rows($query2); $i2++) {
                            $row2 = $db->fetch_array($query2);
                            $categories[] = $row2;
                        }
                        $row['PARENTS'] = $categories;
                    }
                }
                $items[] = $row;
            }
        }
    }

    $smarty->assign($source,$items);
}

function ShopGetDiscount ($params, &$smarty) {
    $items = array();
    if (isset($params['count'])){
        $db = Database::getInstance();
        $count = $params['count'];
        $source = $params['source'];
        $image_width = $params['image_width'];
        $image_height = $params['image_height'];
        $show_parent_category = $params['parent'];
        $sql = "SELECT * FROM `".db_pref."shop_i` WHERE `PUBLIC`=1 AND `PRICE_NEW` > 0 ORDER BY ID DESC LIMIT $count";
        $query = $db->query($sql);
        if ($db->num_rows($query) > 0){
            for ($i=0; $i < $db->num_rows($query); $i++) {
                $row = $db->fetch_array($query);
                if (isset($image_width) && isset($image_height)){
                    $row['SKIN_NEW'] = Func::getInstance()->GetImage(UPLOAD_IMAGES_DIR.'shop/'.$row['SKIN'], $image_width,$image_height,'','shop');
                }
                if (isset($show_parent_category) && $show_parent_category){
                    /*Получаем список категорий, к которым принадлежит материал*/
                    $str = $row['PARENT'];
                    $parents = explode(",",$str);
                    $parents = array_filter($parents);
                    sort($parents);
                    $str = implode(",",$parents);
                    if (count($parents)>0) {
                        $sql2 = "SELECT * FROM `".db_pref."shop_c`  WHERE `ID` IN ($str) AND `PUBLIC`=1";
                        $query2 = $db->query($sql2);
                        for ($i2=0; $i2 < $db->num_rows($query2); $i2++) {
                            $row2 = $db->fetch_array($query2);
                            $categories[] = $row2;
                        }
                        $row['PARENTS'] = $categories;
                    }
                }
                $items[] = $row;
            }
        }
    }

    $smarty->assign($source,$items);
}

function ShopGetTags($params, &$smarty){
    $db = Database::getInstance();
    $sql = "SELECT * FROM `".db_pref."shop_i` WHERE `TAGS` <> ''";
    $query = $db->query($sql);
    $tags = array();
    for ($i=0; $i < $db->num_rows($query); $i++) {
        $row = $db->fetch_array($query);
        $temp_arr = explode(',',$row['TAGS']);
        foreach ($temp_arr as $v){
            $v = trim($v);
            if ($v == '') continue;
            $tags[] = $v;
        }
    }
    $tags = array_unique($tags);
    $smarty->assign('shop_tags',$tags);
}
function ShopGetCategories($params, &$smarty){
    $db = Database::getInstance();
    $source = $params['source'];
    $sql = "SELECT * FROM `".db_pref."shop_c` WHERE `PUBLIC` = '1'";
    $query = $db->query($sql);
    for ($i=0; $i < $db->num_rows($query); $i++) {
        $categories[] = $db->fetch_array($query);
    }
    $categories =  Func::getInstance()->getStructure($categories);
    $smarty->assign($source,$categories);
}
function ShopGetLinks($params, &$smarty){
    /*Выбираем сопутствующие товары*/
    $db = Database::getInstance();
    $links = array();
    $links_str = $params['links'];
    $source = $params['source'];
    $image_width = $params['image_width'];
    $image_height = $params['image_height'];
    $links_str = explode(",",$links_str);
    $links_str = array_filter($links_str);
    sort($links_str);
    $links_str = implode(",",$links_str);
    $sql = "SELECT * FROM `".db_pref."shop_i`  WHERE `ID` IN ($links_str) AND `PUBLIC`=1";
    $query = $db->query($sql);
    if ($db->num_rows($query) > 0){
        $links = $db->fetch_all($query);
        foreach ($links as &$v){
            if (isset($image_width) && isset($image_height)){
                $v['SKIN_NEW'] = Func::getInstance()->GetImage(UPLOAD_IMAGES_DIR.'shop/'.$v['SKIN'], $image_width,$image_height,'','shop');
            }
        }
    }
    $smarty->assign($source,$links);
    /*/////////////////////////////*/

}


function ShopCartShow($params, &$smarty){
    Manager::getInstance()->SetJS(HTML_CONTROLLERS_DIR.'shop/action.js');
   echo '<div id="cart-box">'.GetCart($smarty).'</div>';
}

Smart::getInstance()->register_function("get_shop_discount", "ShopGetDiscount");
Smart::getInstance()->register_function("latest_shop", "print_latest_shop");
Smart::getInstance()->register_function("get_shop_tags", "ShopGetTags");
Smart::getInstance()->register_function("shop_cart", "ShopCartShow");
Smart::getInstance()->register_function("shop_categories", "ShopGetCategories");
Smart::getInstance()->register_function("shop_links", "ShopGetLinks");



?>