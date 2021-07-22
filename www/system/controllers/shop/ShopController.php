<?php

class ShopController extends Controller {
    public function __construct($query, $controller) {
        parent::__construct($query, $controller);
        $this->row = array();
        $this->cid = 0;
        $this->c_name = '';
        $this->categories = array();
        $this->template = '';
        $this->alias = '';
        $this->desc = '';
        $this->desc2 = '';
    }
    public function Index(){
        if (!$this->config->ShopEnabled){
            $message = 'Модуль не активирован!<br/><a href="/">На главную</a>';
            $title = 'Модуль не активирован!';
            return $this->SetSystemPage($title, $message);
        }
        elseif (isset($this->get['tag']) || isset($this->get['manufacturer'])){
            $this->ShowItems();
        }
        elseif (isset($this->get['cart'])){
            $this->ShowCart();
        }
        elseif (isset($this->get['order'])){
            $this->ShowOrder();
        }
        elseif (count($this->query)==1 && is_numeric($this->query[0])){

            $this->ShowItem($id = $this->query[0]);
        }
        elseif ($this->query && !isset($this->get['page'])){ // если есть алиас
            $this->alias = end($this->query);
            $sql = "SELECT * FROM `agcms_shop_c` WHERE `ALIAS` = '$this->alias' AND `PUBLIC`=1 LIMIT 1";
            $query = $this->db->query($sql);
            if ($this->db->num_rows($query) > 0){ // Если алиас принадлежит категории
                $row = $this->db->fetch_array($query);
                $this->cid = $row['ID']; // получаем id категории для вывода всех материалов подкатегорий
                $this->template = $row['TEMPLATE'];
                $this->c_name = $row['TITLE'];
                $this->desc = $row['DESC'];
                $this->desc2 = $row['DESC2'];

                if (!$this->ShowCategories()){ // если нет подкатегорий


                    $this->ShowItems();       // то выводим материалы
                }
            } else { // Если алиас принадлежит материалу, то выводим его
                $this->ShowItem();
            }
        } else { // если нет алиаса, то выводим корневые категории

            $this->c_name = $this->config->ShopModuleTitle;
            $this->template = 'default';
            $this->ShowItems();
            //$this->ShowCategories();
        }
        return $this->content;
    }

    public function ShowCategories(){
        $sql = "SELECT * FROM `agcms_shop_c` WHERE `PARENT` = '$this->cid' AND `PUBLIC`=1"; // получаем потомков
        $query = $this->db->query($sql);
        if ($this->db->num_rows($query) > 0){ // Если в категории есть подкатегории, то выводим их
            for ($i=0; $i < $this->db->num_rows($query); $i++) {
                $row = $this->db->fetch_array($query);
                if ($row['IMAGE']!==''){
                    $row['IMAGE_NEW'] = Func::getInstance()->GetImage(UPLOAD_IMAGES_DIR.'shop/'.$row['IMAGE'], $this->config->ShopImageWidthCategoryList,$this->config->ShopImageHeightCategoryList,'','shop');
                }

                $this->categories[] = $row;
            }
            $this->assign(array(
                'site_title'       => $this->c_name.' - '. $this->config->SiteTitle,
                'page_title'       => $this->c_name,
                'categories'       => $this->categories,
                'c_name'           => $this->c_name,
                'cid'              => $this->cid,
            ));
            $this->SetPath('shop/list/');
            $this->content = $this->SetTemplate($this->template.'.tpl');
            return true;
        }
    }

    public function ShowItems(){
        $sort = $this->config->ShopItemListSort;
        if (isset($this->get['tag'])){
            $tag = urldecode($this->query[0]);
            $this->c_name = $tag;
            $sql = "SELECT *, @id:=ID, (SELECT COUNT(*) FROM `agcms_comments` WHERE `CONTROLLER` = 'shop' AND `MATERIAL_ID` = @id) AS COMMENTS_COUNT FROM `agcms_shop_i`  WHERE `TAGS` LIKE '%,$tag,%' AND `PUBLIC`=1 ORDER BY `DATE_PUBL` $sort";
        }elseif (isset($this->get['manufacturer'])){
            $manufacturer =$this->query[0];
            $sql = "SELECT * FROM `agcms_manufacturer` WHERE MANUFACTURER_ID=$manufacturer LIMIT 1";
            $query = $this->db->query($sql);
            $row = $this->db->fetch_array($query);
            $this->c_name = $row['MANUFACTURER_NAME'];;
            $sql = "SELECT *, @id:=ID, (SELECT COUNT(*) FROM `agcms_comments` WHERE `CONTROLLER` = 'shop' AND `MATERIAL_ID` = @id) AS COMMENTS_COUNT FROM `agcms_shop_i`  WHERE `MANUFACTURER_ID` = '$manufacturer' AND `PUBLIC`=1 ORDER BY `DATE_PUBL` $sort";
        }
        elseif($this->cid==0){
            $sql = "SELECT *, @id:=ID, (SELECT COUNT(*) FROM `agcms_comments` WHERE `CONTROLLER` = 'shop' AND `MATERIAL_ID` = @id) AS COMMENTS_COUNT FROM `agcms_shop_i`  WHERE `PUBLIC`=1 ORDER BY `DATE_PUBL` $sort";
        } else {
            $sql = "SELECT *, @id:=ID, (SELECT COUNT(*) FROM `agcms_comments` WHERE `CONTROLLER` = 'shop' AND `MATERIAL_ID` = @id) AS COMMENTS_COUNT FROM `agcms_shop_i`  WHERE `PARENT` LIKE '%,$this->cid,%' AND `PUBLIC`=1 ORDER BY `DATE_PUBL` $sort";
        }

        $params = array(
            'sql' => $sql,
            'per_page' => $this->config->ShopItemListPerPage,
            'current_page' => isset($this->get['page'])?$this->get['page']:0,
            'link' => '/shop/',
            'get_name' => 'page',
        );
        $result = $this->getPagination($params);
        $query = $result['query'];
        $num_pages = $result['num_pages'];
        $pagination = $result['pagination'];
        $items = array();
        if ($this->db->num_rows($query) > 0){
            for ($i=0; $i < $this->db->num_rows($query); $i++) {
                $row = $this->db->fetch_array($query);
                $row["DATE_PUBL"] = $this->DateFormat($row["DATE_PUBL"]);
                $row["DATE_EDIT"] = $this->DateFormat($row["DATE_EDIT"]);
                if ($row['SKIN']!==''){
                    $row['SKIN_NEW'] = Func::getInstance()->GetImage(UPLOAD_IMAGES_DIR.'shop/'.$row['SKIN'], $this->config->ShopImageWidthItemList,$this->config->ShopImageHeightItemList,'','shop');
                }
                $items[] = $row;
            }
            $this->page_title = $this->c_name;
            $this->assign(array(
                'site_title'       => $this->c_name.' - '. $this->config->SiteTitle,
                'page_title'       => $this->c_name,
                'items'            => $items,
                'c_name'           => $this->c_name,
                'cid'              => $this->cid,
                'desc'             => $this->desc,
                'desc2'            => $this->desc2,
                'pagination'       => $pagination,
            ));
            $this->SetPath('shop/list/');
            if ($this->template == ''){
                $this->template = 'default';
            }
            $this->content = $this->SetTemplate($this->template.'.tpl');
        }
    }
    function GetOptionName($options,$id){
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
    function GetOptionsList(){
        $sql = "SELECT * FROM `agcms_options` ORDER BY `POSITION`,`OPTION_ID`";
        $query = $this->db->query($sql);
        for ($i=0; $i < $this->db->num_rows($query); $i++) {
            $row = $this->db->fetch_array($query);
            $options[] = $row;
        }
        return $options;
    }
    function GetOptionParams($id){
        $sql = "SELECT * FROM `agcms_options_parameter` WHERE OPTION_ID = $id";
        $query = $this->db->query($sql);
        for ($i=0; $i < $this->db->num_rows($query); $i++) {
            $row = $this->db->fetch_array($query);
            $params[] = $row;
        }
        return $params;
    }
    public function GetOptionsArray(){
        $option_list = $this->GetOptionsList();
        $options = array();
        foreach ($option_list as $v){
            $temp = $this->GetOptionParams($v['OPTION_ID']);
            $option_param_list = array();
            foreach ($temp as $t){
                $option_param_list[] = $t;
            }
            $options[] = array('option'=>$v, 'params'=>$option_param_list);
        }
        return $options;
    }
    public function GetProductOptions($id){
        $result = array();
        $sql = "SELECT * FROM `agcms_shop_i_options` WHERE `PRODUCT_ID`=$id";
        $query = $this->db->query($sql);
        if ($this->db->num_rows($query)>0){
            for ($i=0; $i < $this->db->num_rows($query); $i++) {
                $result[] = $this->db->fetch_array($query);
            }
        }
        return $result;
    }
    function OptionExists($product_options, $id){
        $result = false;
        foreach ($product_options as $o){
            if ($o['OPTION_ID'] == $id){
                $result = true;
                break;
            }
        }
        return $result;
    }
    function ParamExists($product_options, $id){
        $result = false;
        foreach ($product_options as $o){
            if ($o['PARAMETER_ID'] == $id){
                $result = true;
                break;
            }
        }
        return $result;
    }
    function GetOptions($id){
        $op = array();
        $op_temp = array();
        $options = $this->GetOptionsArray();
        //var_dump($options);
        $product_options = $this->GetProductOptions($id);
        foreach ($options as $o){
            if ($this->OptionExists($product_options,$o['option']['OPTION_ID'])){
                $op_temp['name']=$o['option']['OPTION_NAME'];
                $op_temp['id'] = $o['option']['OPTION_ID'];
                $op_temp['params'] = array();
                foreach ($o['params'] as $o_param){
                    if ($this->ParamExists($product_options,$o_param['ID'])){
                        $op_temp['params'][] = $o_param;
                    }
                }
                $op[] = $op_temp;
            }
        }
        return $op;
    }

    public function GetProductsLinks($links){
        if ($links!==''){
            $sql = "SELECT *, @id:=ID, (SELECT COUNT(*) FROM `agcms_comments` WHERE `CONTROLLER` = 'shop' AND `MATERIAL_ID` = @id) AS COMMENTS_COUNT FROM `agcms_shop_i`  WHERE `PUBLIC`=1 AND `ID` IN ($links) ORDER BY `DATE_PUBL`";
        }

    }

    public function ShowItem($id=0){
        $other_items = array();
        if ($id > 0){
            $sql = "SELECT *, @id:=ID, (SELECT COUNT(*) FROM `agcms_comments` WHERE `CONTROLLER` = 'shop' AND `MATERIAL_ID` = @id) AS COMMENTS_COUNT FROM `agcms_shop_i` i LEFT JOIN `agcms_manufacturer` m ON m.MANUFACTURER_ID=i.MANUFACTURER_ID WHERE i.ID = '$id' AND i.PUBLIC=1 LIMIT 1";
        } else {
            $sql = "SELECT *, @id:=ID, (SELECT COUNT(*) FROM `agcms_comments` WHERE `CONTROLLER` = 'shop' AND `MATERIAL_ID` = @id) AS COMMENTS_COUNT FROM `agcms_shop_i` i LEFT JOIN `agcms_manufacturer` m ON m.MANUFACTURER_ID=i.MANUFACTURER_ID WHERE i.ALIAS = '$this->alias' AND i.PUBLIC=1 LIMIT 1";
        }

        $query = $this->db->query($sql);
        if ($this->db->num_rows($query) > 0){
            $row = $this->db->fetch_array($query);
            $row["DATE_PUBL"] = $this->DateFormat($row["DATE_PUBL"]);
            $row["DATE_EDIT"] = $this->DateFormat($row["DATE_EDIT"]);
            $item = $row;

            $item['CONTENT'] = Func::getInstance()->syntax_filter( $item['CONTENT']);
            $item['NUMBER'] = sprintf("%05d", $item['ID']);

            $str = $row['TAGS'];
            $tags = explode(",",$str);
            $tags = array_filter($tags);
            sort($tags);

            $files = array();
            $str = $row["FILES"];
            if ($str!==''){
                $files = unserialize($str);
            }

            $options = $this->GetOptions($row["ID"]);

            /*Получаем список категорий, к которым принадлежит материал*/
            $str = $row['PARENT'];
            $parents = explode(",",$str);
            $parents = array_filter($parents);
            sort($parents);
            $str = implode(",",$parents);
            $sql = "SELECT * FROM `agcms_shop_c`  WHERE `ID` IN ($str) AND `PUBLIC`=1";
            $query = $this->db->query($sql);
            $categories = $this->db->fetch_all($query);
            /*///////////////////*/

            /*Выбираем сопутствующие товары*/
/*            $str = $row['LINKS'];
            $str = explode(",",$str);
            $str = array_filter($str);
            sort($str);
            $str = implode(",",$str);
            $sql = "SELECT * FROM `agcms_shop_i`  WHERE `ID` IN ($str) AND `PUBLIC`=1";
            $query = $this->db->query($sql);
            $links = $this->db->fetch_all($query);*/
            /*/////////////////////////////*/


            /*Выбираем похожие материалы*/
            if (count($tags) > 0){
                $sql = "";
                foreach ($tags as $k=>$t){
                    if ($k>0){
                        $sql.= " OR `TAGS` LIKE '%$t%'";
                    } else {
                        $sql.= "`TAGS` LIKE '%$t%'";
                    }
                }
                $sql = "SELECT * FROM `agcms_shop_i` WHERE `ID` <> ".$item["ID"]." AND ( ".$sql." ) ORDER BY `DATE_EDIT` DESC LIMIT 10";
                $query = $this->db->query($sql);
                for ($i=0; $i < $this->db->num_rows($query); $i++) {
                    $row = $this->db->fetch_array($query);
                    $row['SKIN_NEW'] = Func::getInstance()->GetImage(UPLOAD_IMAGES_DIR.'shop/'.$row['SKIN'], $this->config->ShopImageWidthItemList,$this->config->ShopImageHeightItemList,'','shop');
                    $other_items[] = $row;
                }
            }
            if (count($other_items) == 0){
                $sql = "";
                foreach ($parents as $k=>$t){
                    if ($k>0){
                        $sql.= " OR `PARENT` LIKE '%$t%'";
                    } else {
                        $sql.= "`PARENT` LIKE '%$t%'";
                    }
                }
                $sql = "SELECT * FROM `agcms_shop_i` WHERE `ID` <> ".$item["ID"]." AND ( ".$sql." ) ORDER BY `DATE_EDIT` DESC LIMIT 10";
                $query = $this->db->query($sql);
                for ($i=0; $i < $this->db->num_rows($query); $i++) {
                    $row = $this->db->fetch_array($query);
                    $row['SKIN_NEW'] = Func::getInstance()->GetImage(UPLOAD_IMAGES_DIR.'shop/'.$row['SKIN'], $this->config->ShopImageWidthItemList,$this->config->ShopImageHeightItemList,'','shop');
                    $other_items[] = $row;
                }
            }
            /*///////////////////*/

            if ($this->config->ShopCommentsEnabled && $item['COMMENTS']){
                include_once(dirname(__FILE__).'../../comments/CommentsController.php');
                $comments = new CommentsController($this->query, $this->controller);
                $comments->material_id = $item["ID"];
                $comments->controller = $this->controller;
                $comments->tpl_view = $this->config->ShopCommentsTemplateView.'.tpl';
                $comments->tpl_form = $this->config->ShopCommentsTemplateForm.'.tpl';

                $comments ->Index();
                $this->smarty->assign(array(
                    'comments_form'                 => $comments->comments_form,
                    'comments'                      => $comments->comments,
                ));
                if (count($comments->js) > 0){
                    foreach ($comments->js as $j){
                        $this->js[]=$j;
                    }
                }
                if (count($comments->css) > 0){
                    foreach ($comments->css as $j){
                        $this->css[]=$j;
                    }
                }
            }

            $this->meta_description = $item['META_DESC'];
            $this->meta_keywords = $item['META_KEYWORDS'];
            $this->page_title = $item["TITLE"];
            $images = explode(",",$item['IMAGES']);
/*            foreach ($images as $img){
                $images_new[] = Func::getInstance()->GetImage(UPLOAD_IMAGES_DIR.'shop/'.$img, $this->config->GalleryImageWidthItemList,$this->config->GalleryImageHeightItemList,'','shop');
            }*/
            $this->assign(array(
                'item'             => $item,
                'other_items'      => $other_items,
                'parents'          => $categories,
                'files'            => $files,
                'tags'             => $tags,
                'image'            => $item['SKIN'],
                'image_new'        => Func::getInstance()->GetImage(UPLOAD_IMAGES_DIR.'shop/'.$item['SKIN'], $this->config->ShopImageWidthItem,$this->config->ShopImageHeightItem,'','shop'),
                'images'           => $images,
                'options'           => $options,
            ));

            $this->SetPath('shop/single/');
            $this->content = $this->SetTemplate($item['TEMPLATE'].'.tpl');
        }
    }
    public function ShowCart(){
        require_once(dirname(__FILE__).'/func.php');
        $this->page_title = 'Корзина покупок';
        $products = array();
        $total_price_all = 0;
        $total_count = 0;
        if (isset($_COOKIE['cart'])){
            $list = $_COOKIE['cart'];
            $list_arr = array();
            if (isset($list)){
                $list_arr = unserialize($list);
            }
            $products_cart = GetProductsCart($list);
            foreach ($list_arr as $v){
                $id = $v{'id'};
                $row = GetProductFromQuery($products_cart,$id);
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

        $this->SetPath('shop/cart/');
        $this->smarty->assign(array(
            'products' => $products,
            'total_count' => $total_count,
            'total_price_all' => $total_price_all,
        ));
        $this->content = $this->SetTemplate('cart.tpl');
    }
    function GetDeliverys(){
        $result = array();
        $sql = "SELECT * FROM `agcms_delivery`";
        $query = $this->db->query($sql);
        for ($i=0; $i < $this->db->num_rows($query); $i++) {
            $row = $this->db->fetch_array($query);
            $result[] = $row;
        }
        return $result;
    }
    function GetDelivery($id){
        $sql = "SELECT * FROM `agcms_delivery` WHERE `DELIVERY_ID` = $id LIMIT 1";
        $query = $this->db->query($sql);
        $result = $this->db->fetch_array($query);
        return $result;
    }
    public function ShowOrder(){
        $regions = array();
        if (!$this->login){
            $this->head('/register/redirect=shop-order');
        }
        $sql = "SELECT * FROM `agcms_regions` WHERE `COUNTRY_ID`=3159 ORDER BY `REGION_NAME`";
        $query = $this->db->query($sql);
        if ($this->db->num_rows($query) > 0){
            for ($i=0; $i < $this->db->num_rows($query); $i++) {
                $regions[] = $this->db->fetch_array($query);
            }
        }


        $this->assign(array(
            'regions'    => $regions,
            'delivery'    => $this->GetDeliverys(),
        ));
        $this->SetPath('shop/order/');
        $this->content = $this->SetTemplate('order.tpl');
    }
}
?>