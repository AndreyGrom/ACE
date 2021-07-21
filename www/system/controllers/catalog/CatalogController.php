<?php

class CatalogController extends Controller {
    public function __construct($query, $controller) {
        parent::__construct($query, $controller);
        $this->row = array();
        $this->cid = 0;
        $this->categories = array();
        $this->template = '';
        $this->alias = '';
        $this->desc = '';
        $this->desc2 = '';
    }

    public function GetCategory($alias){
        $result = false;
        $sql = "SELECT * FROM `".db_pref."catalog_c` WHERE `ALIAS` = '$alias' AND `PUBLIC`=1 LIMIT 1";
        $query = $this->db->query($sql);
        if ($this->db->num_rows($query) > 0){
            $result = $this->db->fetch_array($query);
        }

        return $result;
    }

    public function GetCart($pay = 0){
        if ($pay == 0){
            $cart = json_decode($_COOKIE['cart']);

        } else {
            $order = $this->GetOrder($this->get['pay']);
            $cart = json_decode($order['CONT']);
        }

        $cart2 = $cart;
        $ids = array();
        $c_list = array();
        $c_list2 = array();
        $p_list = array();
        $p_list2 = array();
        $d_list = array();
        $total = 0;
        if (count($cart->list) > 0){
            foreach ($cart->list as $sh){
                $ids[] = $sh->id;
                if (count($sh->c_list) > 0){
                    foreach ($sh->c_list as $c){
                        $c_list[] = $c->id;
                        $c_list2[] = array($c->id, $c->price);
                    }
                }
                if (count($sh->p_list) > 0){
                    foreach ($sh->p_list as $p){
                        $p_list[] = $p->id;
                        $p_list2[] = $p;
                    }
                }
                if (count($sh->d_list) > 0){
                    foreach ($sh->d_list as $d){
                        $d_list[] = $d;
                    }
                }
                $total += $sh->total;
            }
        }
        $sql = "SELECT c.*, co.COUNTRY_NAME, co.C_CURRENCY, co.C_ZN, ci.CITY_NAME, i.PHOTO1, i.TITLE AS SH_TITLE FROM agcms_catalog_courses c
        LEFT JOIN agcms_catalog_i i ON i.ID = c.SH_ID
        LEFT JOIN agcms_country co ON co.COUNTRY_ID = i.COUNTRY_ID
        LEFT JOIN agcms_city ci ON ci.CITY_ID = i.CITY_ID
        WHERE c.ID IN (". implode(', ', $c_list) .")";
        $c_list = $this->db->select($sql);

        $sql = "SELECT p.*, co.COUNTRY_NAME, co.C_CURRENCY, co.C_ZN, ci.CITY_NAME, i.TITLE AS SH_TITLE FROM agcms_catalog_prozhiv p
        LEFT JOIN agcms_catalog_i i ON i.ID = p.SH_ID
        LEFT JOIN agcms_country co ON co.COUNTRY_ID = i.COUNTRY_ID
        LEFT JOIN agcms_city ci ON ci.CITY_ID = i.CITY_ID
        WHERE p.ID IN (". implode(', ', $p_list) .")";
        $p_list = $this->db->select($sql);

        foreach ($c_list as &$c){
            foreach ($c_list2 as $c2){
                if ($c2[0] == $c['ID']){
                    $c['price'] = $c2[1];
                }
            }

        }

        $cart = array(

            'c_list' => $c_list,
            'p_list' => $p_list,
            'p_list2' => $p_list2,
            'd_list' => $d_list,
            'total' => $total,
        );
        if ($pay > 0){
            $cart['order'] = $order;
        }

        return $cart;
    }

    public function ShowCart(){
        if (isset($this->get['clear'])){
            setcookie('cart','',time()+3600*24*30*6,'/');
            $this->Head('/catalog/cart');
        }

        //$cart = $this->GetCart();
        if ($cart =$this->GetCartDB()){

            if (isset($this->get['act']) && $this->get['act'] =='delete-cart' && isset($this->get['act2'])){
                foreach ($cart as $kk => &$car){
                    if ($this->get['act2'] == 'c'){
                        $a = array();
                        foreach ($car->c_list as $k => $c){
                            if ($c->id !== $this->get['id']){
                                $a[] = $c;
                            }

                        }


                        $car->c_list = $a;
                        if (count( $car->c_list) == 0){
                            unset($cart[$kk]);
                            sort($cart);
                        }
                    }
                    if ($this->get['act2'] == 'p'){
                        $a = array();
                        foreach ($car->p_list as $k => $c){
                            if ($c->id !== $this->get['id']){
                                $a[] = $c;
                            }

                        }
                        $car->p_list = $a;
                    }
                    if ($this->get['act2'] == 'd'){
                        $a = array();
                        foreach ($car->d_list as $k => $c){
                            if ($c->id !== (int)$this->get['id']){
                                $a[] = $c;
                            }

                        }
                        $car->d_list = $a;
                    }
                }

                $this->UpdateCartDB($cart, $_COOKIE['hash_cart'] );
                $this->Head('/catalog/cart');
            }
        }




        if ($cart){
            foreach ($cart as &$car){
                $p = 0;
                foreach ($car->c_list as $c){
                    $p = $p + $c->price;
                    if (is_numeric($c->count)) {
                        $c->count_numeric = true;
                    } else{
                        $c->count_numeric = false;
                    }
                }
                foreach ($car->p_list as $c){
                    $p = $p + $c->price*$c->count;
                }
                foreach ($car->d_list as $c){
                    $p = $p + $c->price;
                }
                $car->total = $p;
            }
        }

        $cart2 = $this->GetCartDB2();

        if (isset($this->get['act']) && $this->get['act'] =='delete-cart2'){

                $a = array();
                foreach ($cart2 as $k => $c2){
                    if ($c2->id !== $this->get['id']){
                        $a[] = $c2;
                    }

                }
            $cart2 = $a;
            $this->UpdateCartDB2($cart2, $_COOKIE['hash_cart'] );
            $this->Head('/catalog/cart');
        }

        $this->assign(array(
            'cart' => $cart,
            'cart2' => $cart2,
        ));



        $this->SetPath('catalog/');
        $this->content = $this->SetTemplate('cart.tpl');

    }

/*    public function RemoveCart($act){
        $cart = $this->GetCart();
        $id = $this->get['id'];
        $cart2 = array();
        if ($act == 'sch'){

            if (count($cart['c_list']) > 0){
                foreach ($cart['c_list'] as &$sh){

                    if ($sh['SH_ID'] !==  $id){
                        $cart2 = $sh;

                    }
                }
                $cart['c_list'] = $cart2;
                $cart = json_encode($cart);
                setcookie('cart',$cart,time()+3600*24*30*6,'/');
            }
        }
    }*/


    public function ShowMainPage(){
        $this->page_title = $this->config->CatalogModuleTitle;
        $this->meta_title = $this->config->CatalogModuleTitle.' - '. $this->config->SiteTitle;
        $this->meta_description = $this->config->CatalogModuleDescription;
        $this->meta_keywords = $this->config->CatalogModuleKeywords;
        $this->template = 'default';
        $this->ShowItems();
        //$this->ShowCategories();
    }

    public function ShowCategories(){
        $sql = "SELECT * FROM `".db_pref."catalog_c` WHERE `PARENT` = '$this->cid' AND `PUBLIC`=1"; // получаем потомков
        $query = $this->db->query($sql);
        if ($this->db->num_rows($query) > 0){ // Если в категории есть подкатегории, то выводим их
            for ($i=0; $i < $this->db->num_rows($query); $i++) {
                $row = $this->db->fetch_array($query);
                if ($row['IMAGE']!==''){
                    $row['IMAGE_NEW'] = Func::getInstance()->GetImage(UPLOAD_IMAGES_DIR.'catalog/'.$row['IMAGE'], $this->config->CatalogImageWidthCategoryList,$this->config->CatalogImageHeightCategoryList,'','catalog');
                }

                $this->categories[] = $row;
            }
            $this->assign(array(
                'page_title'       => $this->page_title,
                'categories'       => $this->categories,
                'cid'              => $this->cid,
            ));
            $this->SetPath('catalog/list/');
            $this->content = $this->SetTemplate($this->template.'.tpl');
            return true;
        }
    }

    public function GetCountries(){
        $sql = "SELECT * FROM `".db_pref."country` ORDER BY `COUNTRY_NAME`";
        return $this->db->select($sql);
    }

    public function GetRegions($id){
        $sql = "SELECT * FROM `".db_pref."regions` WHERE COUNTRY_ID = $id ORDER BY `REGION_NAME`";
        return $this->db->select($sql);
    }

    public function GetCities($id){
        $sql = "SELECT * FROM `".db_pref."city` WHERE COUNTRY_ID = $id ORDER BY `CITY_NAME`";
        return $this->db->select($sql);
    }

    public function GetDate1(){
        $sql = "SELECT DISTINCT DATE1 FROM agcms_catalog_i";
        return $this->db->select($sql);
    }

    public function ShowItems(){
        $sort = '';
        $url = '/catalog/';
        $where = array();
        $have = array();
        /*$sort = $this->config->CatalogItemListSort;*/
        $pr = '';
        if (isset($this->get['find'])){
            $this->page_title = 'Результаты поиска';

            $url .= 'find/';
            $this->assign(array(
                'get' => $this->get,
            ));
            if (isset($this->get['country']) && $this->get['country'] > 0){
                $url .= 'country=' . $this->get['country'] . '/';
                $where[] = 'country.COUNTRY_ID = ' . $this->get['country'];
                $this->assign(array(
                    'cities' => $this->GetCities($this->get['country'])
                ));
            }
            if (isset($this->get['city']) && $this->get['city'] > 0){
                $url .= 'city=' . $this->get['city'] . '/';
                $where[] = 'city.CITY_ID = ' . $this->get['city'];
            }
            if (isset($this->get['duration']) && $this->get['duration'] > 0){
                $url .= 'duration=' . $this->get['duration'] . '/';
                $have[] = 'COUNT_OT <= ' . $this->get['duration'];
                $have[] = 'COUNT_DO >= ' . $this->get['duration'];

            }
            if (isset($this->get['age']) && $this->get['age'] > 0){
                $url .= 'duration=' . $this->get['duration'] . '/';
                $where[] = 'i.VOZ <= ' . $this->get['age'];
            }
            if (isset($this->get['25'])){
                $url .= '25=true/';
                $where[] = 'i.P_25 =1';
                $this->assign(array(
                    'P_25' => true
                ));
            }
            if (isset($this->get['pm'])){
                $url .= 'pm=true/';
                $where[] = 'i.P_M =1';
                $this->assign(array(
                    'P_M' => true
                ));
            }
            if (isset($this->get['top'])){
                $url .= 'top=true/';
                $where[] = 'i.P_TOP =1';
                $this->assign(array(
                    'P_TOP' => true
                ));
            }
            if (isset($this->get['predmet'])){
                $url .= 'predmet=' . $this->get['predmet'] . '/';
                $have[] = 'COUNT_PREDMET > 0 ';
                $pr = "(SELECT COUNT(*) FROM agcms_catalog_courses course WHERE course.PREDMET = " . $this->get['predmet'] ." AND course.SH_ID = i.ID) as COUNT_PREDMET,";
                $this->assign(array(
                    'PREDMET' => $this->get['predmet']
                ));
            }
            if (isset($this->get['address'])){
                $this->get['address'] = urldecode($this->get['address']);
                $where[] = "MATCH (address) AGAINST ('" . $this->get['address'] ."')";
                $this->assign(array(
                    'ADDRESS' => $this->get['address']
                ));
            }
        }

        if (isset($this->get['sort'])){
            $url .= 'sort=' . $this->get['sort'] . '/';
            if ($this->get['sort'] == 'rating'){
                $sort = 'ORDER BY i.RATING DESC';
            }
            if ($this->get['sort'] == 'price-asc'){
                $sort = 'ORDER BY MIN_PRICE ASC';
            }
            if ($this->get['sort'] == 'price-desc'){
                $sort = 'ORDER BY MIN_PRICE DESC';
            }
            $this->assign(array(
                'sort' => $this->get['sort']
            ));
        } else {
            //$sort = 'ORDER BY i.DATE_PUBL DESC';
        }


/*
        (SELECT MIN(COUNT_OT) FROM agcms_catalog_courses) as COUNT_OT_MIN,
        (SELECT MIN(COUNT_DO) FROM agcms_catalog_courses) as COUNT_DO_MIN
*/

        $sql = "SELECT i.*,  country.COUNTRY_NAME, country.C_CURRENCY, country.C_ZN,country.C_CURRENCY_N , city.CITY_NAME, regions.REGION_NAME, @id:=i.ID,
        (SELECT MIN(COUNT_OT) FROM agcms_catalog_courses course WHERE i.ID = course.SH_ID) as COUNT_OT,
        (SELECT MAX(COUNT_DO) FROM agcms_catalog_courses course WHERE i.ID = course.SH_ID) as COUNT_DO,
        $pr
        (SELECT MIN(course.PRICE) FROM agcms_catalog_courses course WHERE (i.ID = course.SH_ID) AND course.PRICE > 0) as MIN_PRICE
        FROM  agcms_catalog_i i
        LEFT JOIN agcms_country country ON country.COUNTRY_ID = i.COUNTRY_ID
        LEFT JOIN agcms_regions regions ON regions.REGION_ID = i.REGION_ID
        LEFT JOIN agcms_city city ON city.CITY_ID = i.CITY_ID

        ";

        if (count($where) > 0){
            $sql .= ' WHERE ' . implode(' AND ', $where);
        }
        if (count($have) > 0){
            $sql .= ' HAVING ' . implode(' AND ', $have);

        }

        /*$sql .= " ORDER BY `DATE_PUBL` $sort";*/
  /*      $sql .= " GROUP BY i.ID ";*/
        $sql .= $sort;

/*var_dump($sql);*/
/*exit;*/
        $params = array(
            'sql' => $sql,
            'per_page' => $this->config->CatalogItemListPerPage,
            'current_page' => isset($this->get['page'])?$this->get['page']:0,
            'link' => $url,
            'get_name' => 'page',
        );
        $result = $this->getPagination($params);
/*var_dump($this->db->error());*/
        $query = $result['query'];
        $num_pages = $result['num_pages'];
        $pagination = $result['pagination'];
        $items = array();
        //var_dump($this->db->error());
        //exit;
//var_dump($query['items']);
        if (count($query['items']) > 0){
            foreach ($query['items'] as $row){
                //$row["DATE1"] = $this->DateFormat2($row["DATE1"]);
                //$row["DATE2"] = $this->DateFormat2($row["DATE2"]);
                if ($row['SKIN']!==''){
                    $row['SKIN_NEW'] = Func::getInstance()->GetImage(UPLOAD_IMAGES_DIR.'catalog/'.$row['SKIN'], $this->config->CatalogImageWidthItemList,$this->config->CatalogImageHeightItemList,'','catalog');
                }
                $items[] = $row;

            }

        //var_dump($items);

        }
        if ($this->meta_title == ''){
            $this->meta_title = $this->page_title.' - '. $this->config->SiteTitle;
        }
        $sql = "SELECT * FROM `agcms_catalog_predmets`";
        $predmets =  $this->db->select($sql);
        $this->assign(array(
            'cart' => $this->GetCartDB(),
            'predmets'         => $predmets,
            'countries'        => $this->GetCountries(),
            'date1'            => $this->GetDate1(),
            'page_title'       => $this->page_title,
            'items'            => $items,
            'cid'              => $this->cid,
            'desc'             => $this->desc,
            'desc2'            => $this->desc2,
            'pagination'       => $pagination,
            'num_pages'        => $num_pages,
        ));

        $this->SetPath('catalog/list/');
        if ($this->template == ''){
            $this->template = 'default';
        }
        $this->content = $this->SetTemplate($this->template.'.tpl');
    }

    public function GetIncs(){
        $sql = "SELECT * FROM `agcms_catalog_inc`";
        return $this->db->select($sql);
    }

    public function ShowItem($id=0){;
        if ($id > 0){
            $sql = "SELECT * FROM `".db_pref."catalog_i`  WHERE `ID` = '$id' AND `PUBLIC`=1 LIMIT 1";
        } else {
            $sql = "SELECT i.*, country.*, region.*, city.*,
            (SELECT MIN(c.PRODOL_COUNT) FROM agcms_catalog_courses c WHERE c.NET_ID = i.NET_ID OR c.SH_ID =i.ID) AS MIN_COUNT
            FROM `".db_pref."catalog_i` i
                    LEFT JOIN agcms_country country ON country.COUNTRY_ID = i.COUNTRY_ID
                    LEFT JOIN agcms_regions region ON region.REGION_ID = i.REGION_ID
                    LEFT JOIN agcms_city city ON city.CITY_ID = i.CITY_ID
            WHERE i.ALIAS = '$this->alias' AND i.PUBLIC = 1 LIMIT 1";
        }
        $categories = array();
        $query = $this->db->query($sql);

        if ($this->db->num_rows($query) > 0){
            $row = $this->db->fetch_array($query);
            $row["DATE_START"] = $this->DateFormat($row["DATE_START"]);
            $row["DATE_END"] = $this->DateFormat($row["DATE_END"]);
            //$row["DATE1"] = $this->DateFormat2($row["DATE1"]);
            //$row["DATE2"] = $this->DateFormat2($row["DATE2"]);
            $item = $row;
            //$item['CONTENT'] = Func::getInstance()->syntax_filter( $item['CONTENT']);

       /*     $str = $row['TAGS'];
            $tags = explode(",",$str);
            $tags = array_filter($tags);
            sort($tags);*/

    /*        $files = array();
            $str = $row["FILES"];
            if ($str!==''){
                $files = unserialize($str);
            }*/

            $this->meta_title = $row['META_TITLE'];
            $this->meta_description = $row['META_DESC'];
            if (trim($this->meta_description == '')){
                $this->meta_description = mb_substr(trim(strip_tags($item['SHORT_CONTENT'])),0,200);
            }
            if (trim($this->meta_description == '')){
                $this->meta_description = mb_substr(trim(strip_tags($item['CONTENT'])),0,200);
            }
            $this->meta_keywords = $row['META_KEYWORDS'];
            $this->page_title = $row['TITLE'];
            if ($this->meta_title == ''){
                $this->meta_title = $this->page_title.' - '. $this->config->SiteTitle;
            }
            $this->page_title = $row["TITLE"];


            /*Получаем список категорий, к которым принадлежит материал*/
/*            $str = $row['PARENT'];
            $parents = explode(",",$str);
            $parents = array_filter($parents);
            sort($parents);
            $str = implode(",",$parents);
            $sql = "SELECT * FROM `".db_pref."catalog_c`  WHERE `ID` IN ($str) AND `PUBLIC`=1";
            $query = $this->db->query($sql);
            for ($i=0; $i < $this->db->num_rows($query); $i++) {
                $row = $this->db->fetch_array($query);
                $categories[] = $row;
            }*/
            /*///////////////////*/

            /*Выбираем похожие материалы*/
            /*$other_items = array();
            if (count($tags) > 0){
                $sql = "";
                foreach ($tags as $k=>$t){
                    if ($k>0){
                        $sql.= " OR `TAGS` LIKE '%$t%'";
                    } else {
                        $sql.= "`TAGS` LIKE '%$t%'";
                    }
                }
                $sql = "SELECT * FROM `".db_pref."catalog_i` WHERE `ID` <> ".$item["ID"]." AND ( ".$sql." ) ORDER BY `DATE_EDIT` DESC LIMIT 10";
                $query = $this->db->query($sql);
                for ($i=0; $i < $this->db->num_rows($query); $i++) {
                    $row = $this->db->fetch_array($query);
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
                $sql = "SELECT * FROM `".db_pref."catalog_i` WHERE `ID` <> ".$item["ID"]." AND ( ".$sql." ) ORDER BY `DATE_EDIT` DESC LIMIT 10";
                $query = $this->db->query($sql);
                for ($i=0; $i < $this->db->num_rows($query); $i++) {
                    $row = $this->db->fetch_array($query);
                    $other_items[] = $row;
                }
            }*/
            /*///////////////////*/

            /*if ($this->config->CatalogCommentsEnabled && $item['COMMENTS']){
                include_once(dirname(__FILE__).'../../comments/CommentsController.php');
                $comments = new CommentsController($this->query, $this->controller);
                $comments->material_id = $item["ID"];
                $comments->controller = $this->controller;
                $comments->premoderation = $this->config->CatalogCommentsModerationEnabled;
                $comments->captcha = $this->config->CatalogCommentsCaptchaEnabled;
                $comments->tpl_view = $this->config->CatalogCommentsTemplateView.'.tpl';
                $comments->tpl_form = $this->config->CatalogCommentsTemplateForm.'.tpl';


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
            }*/


/*            $this->breadcrumbs = array(
                array('text' => 'Главная', 'href' => '/'),
                array('text' => $categories[0]['TITLE'], 'href' => '/catalog/'.$categories[0]['ALIAS']),
                array('text' => $item['TITLE'], 'href' => ''),
            );*/
            $this->breadcrumbs[] = array('text' => 'Главная', 'href' => '/');
            $this->breadcrumbs[] = array('text' => 'Каталог', 'href' => '/catalog/');
            foreach ($categories as $c){
                $this->breadcrumbs[] = array('text' => $c['TITLE'], 'href' => '/catalog/'.$c['ALIAS']);
            }
            $this->breadcrumbs[] = array('text' => $item['TITLE'], 'href' => '');

            $sql = "SELECT * FROM agcms_catalog_courses WHERE NET_ID > 0 AND NET_ID = " . $item['NET_ID'];
            $courses = $this->db->select($sql);
            $sql = "SELECT * FROM agcms_catalog_courses WHERE SH_ID > 0 AND SH_ID = " . $item['ID'];
            $courses2 = $this->db->select($sql);
            foreach ($courses2 as $c){
                $courses[] = $c;
            }
            $sql = "SELECT * FROM agcms_catalog_prozhiv WHERE NET_ID > 0 AND NET_ID = " . $item['NET_ID'];
            $pros = $this->db->select($sql);

            $sql = "SELECT * FROM agcms_catalog_prozhiv WHERE SH_ID > 0 AND SH_ID = " . $item['ID'];
            $pros2 = $this->db->select($sql);

            foreach ($pros2 as $c2){
                $pros[] = $c2;
            }

            foreach ($pros as &$c){
                $c['PACKS'] = unserialize($c['PACKS']);
                $c['INCS'] = unserialize($c['INCS']);
;
            }

            foreach($courses as &$c){
                $c['PACKS2'] = json_decode($c['PACKS']);
            }

            $item['TOP_N'] = unserialize($item['TOP_N']);

            $item['DOPS'] = unserialize($item['DOPS']);


            if ($cart2 = $this->GetCartDB()){

                foreach($cart2 as $c2){
                    if ($c2->id == $item['ID']){
                        $this->assign(array(
                            'cart_c'  => $c2
                        ));
                        //var_dump($c2);
                    }
                }
            }


            $this->assign(array(
                'item'             => $item,
                'courses'             => $courses,
                'pros'             => $pros,
                'dops'             => $this->GetDops(),
                'incs'             => $this->GetIncs(),
                //'other_items'      => $other_items,
                'parents'          => $categories,
                'files'            => $files,
                //'tags'             => $tags,
                'image'            => $item['SKIN'],
                'page_title'       => $this->page_title ,
                'image_new'        => Func::getInstance()->GetImage(UPLOAD_IMAGES_DIR.'catalog/'.$item['SKIN'], $this->config->CatalogImageWidthItem,$this->config->CatalogImageHeightItem,'','catalog'),
                'images'           => explode(",",$item['IMAGES']),
            ));

            $this->SetPath('catalog/single/');
            $this->content = $this->SetTemplate($item['TEMPLATE'].'.tpl');
        }
    }

    public function DateFormat2($date){
        return date("d.m.Y", $date);
    }

    public function GetDops(){
        $sql = "SELECT * FROM `agcms_catalog_dop`";
        return $this->db->select($sql);
    }

    public function Order_1(){
        if (!$this->login){
            $this->Head('/login/u');
        } else{
            $this->Head('/catalog/pay');
        }
    }

    public function GetOrder($id){
        $sql = "SELECT * FROM agcms_orders WHERE ID = $id AND USER_ID = " .$this->user['ID'] . ' AND STATUS = 0';
        $rs = $this->db->select($sql, array('single_array' => true));
        if ($rs){
            $rs['DATE_START'] = $this->DateFormat($rs['DATE_START']);
        }

        return $rs;
    }

    public function ShowPay(){


        if (isset($_COOKIE['hash_cart']) && $this->login){
            $sql = "SELECT * FROM agcms_cart WHERE HASH = '" . $_COOKIE['hash_cart'] . "'";
            $cart = $this->db->select($sql, array('single_array' => true));
            $params = array(
                'USER_ID' => $this->user['ID'],
                'DATE_START' => time(),
                'CONT' => $cart['ORDER'],
                'CONT2' => $cart['ORDER2'],
            );
            $this->db->insert('agcms_orders', $params);
            setcookie('hash_cart','',time()+3600*24*30*6,'/');
            $this->Head('/catalog/pay=' . $this->db->last_id());
        }

        $sql = "SELECT * FROM agcms_orders WHERE ID = " . $this->get['pay'] ;
        $query = $this->db->select($sql, array('single_array' => true));

        $cart = json_decode($query['CONT']);
        $cart2 = json_decode($query['CONT2']);

        $total = $this->GetTotal($cart, $cart2);


        $sql = "SELECT * FROM agcms_faq_i";
        $faq = $this->db->select($sql);

        $this->assign(array(
            'faq' => $faq,
            'cart' => $cart,
            'cart2' => $cart2,
            'total' => $total,
        ));

        $this->SetPath('catalog/');
        $this->content = $this->SetTemplate('pay.tpl');

    }

    public function GetTotal($cart, $cart2){
        $total = array();
        foreach ($cart as $c){
            if (isset($c->c_list)){
                foreach ($c->c_list as $c_l){
                    if (!isset($total[$c->c_currency]['total'])){
                        $total[$c->c_currency]['total'] = 0;
                    }
                    $total[$c->c_currency]['cur'] =  $c->c_currency;
                    $total[$c->c_currency]['total'] = $total[$c->c_currency]['total'] + $c_l->price;
                }
            }
            if (isset($c->p_list)){
                foreach ($c->p_list as $c_l){
                    if (!isset($total[$c->c_currency]['total'])){
                        $total[$c->c_currency]['total'] = 0;
                    }
                    $total[$c->c_currency]['cur'] =  $c->c_currency;
                    $total[$c->c_currency]['total'] = $total[$c->c_currency]['total'] + $c_l->price;
                }
            }
            if (isset($c->d_list)){
                foreach ($c->d_list as $c_l){
                    if (!isset($total[$c->c_currency]['total'])){
                        $total[$c->c_currency]['total'] = 0;
                    }
                    $total[$c->c_currency]['cur'] =  $c->c_currency;
                    $total[$c->c_currency]['total'] = $total[$c->c_currency]['total'] + $c_l->price;
                }
            }
        }
        foreach ($cart2 as $c){
            if (!isset($total[$c->cur]['total'])){
                $total[$c->cur]['total'] = 0;
            }
            $total[$c->cur]['cur'] = $c->cur;
            if ($c->price_new){
                $total[$c->cur]['total'] = $total[$c->cur]['total'] + $c->price_new;
            } else{
                $total[$c->cur]['total'] = $total[$c->cur]['total'] + $c->price;
            }

        }
        return $total;
    }

    public function GetCartDB(){
        $sql = "SELECT * FROM agcms_cart WHERE HASH = '" . $_COOKIE['hash_cart'] . "'";
        $cart = $this->db->select($sql, array('single_array' => true));
        $cart = json_decode($cart['ORDER']);
        return $cart;
    }

    public function GetCartDB2(){
        $sql = "SELECT * FROM agcms_cart WHERE HASH = '" . $_COOKIE['hash_cart'] . "'";
        $cart = $this->db->select($sql, array('single_array' => true));
        $cart = json_decode($cart['ORDER2']);
        return $cart;
    }

    public function UpdateCartDB($cart, $hash){
        $params = array(
            'ORDER' => json_encode($cart,  JSON_UNESCAPED_UNICODE),
        );
        $this->db->update('agcms_cart', $params, "HASH = '" . $hash . "'");

    }

    public function UpdateCartDB2($cart, $hash){
        $params = array(
            'ORDER2' => json_encode($cart,  JSON_UNESCAPED_UNICODE),
        );
        $this->db->update('agcms_cart', $params, "HASH = '" . $hash . "'");

    }

    public function AddCartDB($cart, $hash){
        $params = array(
            'ORDER' => json_encode($cart,  JSON_UNESCAPED_UNICODE),
            'HASH' => $hash,
        );
        $this->db->insert('agcms_cart', $params);

    }

    public function AddOrder(){
        $cart = array();
        $order = json_decode($this->post['order-j']);

        foreach ($order->p_list as &$o){
            if ($o->count == NULL){
                $o->count  = 1;
            }
        }


        $a = true;
        if (isset($_COOKIE['hash_cart'])){
            if ($cart = $this->GetCartDB()){
                foreach ($cart as &$c){
                    if ($c->id == $order->id){
                        $c = $order;
                        $a = false;
                    }
                }
                if ($a){
                    $cart[] = $order;
                }
            } else {
                $cart[] = $order;


            }

            $this->UpdateCartDB($cart, $_COOKIE['hash_cart'] );

        } else {
            $cart[] = $order;
            $hash = $this->generateName();
            setcookie('hash_cart', $hash,time()+3600*24*30*6,'/');
            $this->AddCartDB($cart, $hash);
        }
        $this->Head('/catalog/cart');
    }

    public function CartPro(){
        $id = $this->post['cart_pro_id'];
        $cart = $this->GetCartDB();
        foreach ($cart as &$c){
            foreach($c->p_list as &$cc){
                if ($cc->id == $id){
                    $cc->count = $this->post['cart_pro'];
                }
            }
        }
        $this->UpdateCartDB($cart, $_COOKIE['hash_cart'] );

    }

    public function Index(){
        if (isset($this->post['order-form'])){
            $this->AddOrder();

        }

        if (isset($this->post['cart_pro_btn'])){
            $this->CartPro();
        }

        if (isset($this->post['cart-form'])){
            $this->Order_1();
        }

        if (isset($this->get['tag'])){
            $this->ShowItems();
        }
        elseif (isset($this->get['sort'])){
            $this->ShowItems();
        }
        elseif (isset($this->get['cart'])){
            $this->ShowCart();
        }
        elseif (isset($this->get['pay'])){
            $this->ShowPay();
        }
        elseif (count($this->query)==1 && is_numeric($this->query[0])){
            $this->ShowItem($this->query[0]);
        }
        elseif ($this->query){ // если есть алиас

            $this->alias = reset($this->query);
            if (reset($this->query) == 'find'){
                $this->ShowItems();
            }
            elseif (strpos($this->alias, 'page') === false) {

                $row = $this->GetCategory($this->alias);
                if ($row){ // Если алиас принадлежит категории
                    $this->cid = $row['ID']; // получаем id категории для вывода всех материалов подкатегорий
                    $this->alias = $row['ALIAS'];
                    $this->template = $row['TEMPLATE'];
                    $this->page_title = $row['TITLE'];
                    $this->desc = $row['DESC'];
                    $this->desc2 = $row['DESC2'];
                    $this->meta_title = $row['META_TITLE'];
                    $this->meta_description = $row['META_DESC'];
                    $this->meta_keywords = $row['META_KEYWORDS'];

                    if (!$this->ShowCategories()){ // если нет подкатегорий
                        $this->ShowItems();       // то выводим материалы
                    }
                } else { // Если алиас принадлежит материалу, то выводим его
                    $this->ShowItem();
                }
            } else { // если нет алиаса, то выводим корневые категории
                $this->ShowMainPage();
            }
        } else {
            $this->ShowMainPage();
        }

        return $this->content;
    }
}
?>