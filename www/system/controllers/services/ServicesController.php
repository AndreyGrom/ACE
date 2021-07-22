<?php

class ServicesController extends Controller {
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
        $sql = "SELECT * FROM `agcms_services_c` WHERE `ALIAS` = '$alias' LIMIT 1";
        $query = $this->db->query($sql);
        if ($this->db->num_rows($query) > 0){
            $result = $this->db->fetch_array($query);
        }

        return $result;
    }





    public function ShowItems(){
        $url = '/catalog/';
        $where = array();
        $have = array();
        $sort = $this->config->CatalogItemListSort;
        $pr = '';



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

        $sql .= " ORDER BY `DATE_PUBL` $sort";
//var_dump($sql);

        $params = array(
            'sql' => $sql,
            'per_page' => $this->config->CatalogItemListPerPage,
            'current_page' => isset($this->get['page'])?$this->get['page']:0,
            'link' => $url,
            'get_name' => 'page',
        );
        $result = $this->getPagination($params);
//var_dump($this->db->error());
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
            'predmets'       => $predmets,
            'countries'       => $this->GetCountries(),
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



    public function ShowItem($id=0){;

        //$this->js[] = '/system/controllers/services/action.js';

        $sql = "SELECT * FROM agcms_services_i WHERE ALIAS = '" . $this->alias ."'";

        $categories = array();
        $query = $this->db->query($sql);

        if ($this->db->num_rows($query) > 0){
            $row = $this->db->fetch_array($query);
            $item = $row;
            $parent = str_replace(',', '' , $item['PARENT']);
            $sql = "SELECT * FROM agcms_services_c WHERE ID = $parent";
            $category = $this->db->select($sql, array('single_array' => true));
            $this->meta_title = $row['META_TITLE'];
            $this->meta_description = $row['META_DESC'];
            if (trim($this->meta_description == '')){
                $this->meta_description = mb_substr(trim(strip_tags($item['LEFT_CONTENT'])),0,200);
            }
            $this->meta_keywords = $row['META_KEYWORDS'];
            $this->page_title = $row['TITLE'];
            if ($this->meta_title == ''){
                $this->meta_title = $this->page_title.' - '. $this->config->SiteTitle;
            }
            $this->page_title = $row["TITLE"];


            $this->breadcrumbs[] = array('text' => 'Главная', 'href' => '/');
            $this->breadcrumbs[] = array('text' => 'Каталог', 'href' => '/services/');
            foreach ($categories as $c){
                $this->breadcrumbs[] = array('text' => $c['TITLE'], 'href' => '/services/'.$c['ALIAS']);
            }
            $this->breadcrumbs[] = array('text' => $item['TITLE'], 'href' => '');

/*            $sql = "SELECT sl.*, sl.ID AS SID, l.TITLE AS LEVEL, c.C_CURRENCY, c.C_CURRENCY_N, c.C_ZN
            FROM agcms_services_list sl
            LEFT JOIN agcms_service_levels l ON l.ID = sl.LEVEL_ID
            LEFT JOIN agcms_country c ON c.COUNTRY_ID = sl.COUNTRY_CUR
            WHERE sl.SERVICE_ID = " . $item['ID'];*/

            $sql = "SELECT sl.*, sl.ID AS SID, c.C_CURRENCY, c.C_CURRENCY_N, c.C_ZN
            FROM agcms_services_list sl
            LEFT JOIN agcms_country c ON c.COUNTRY_ID = sl.COUNTRY_CUR
            WHERE sl.SERVICE_ID = " . $item['ID'] . " ORDER BY SORT ASC";

            $list = $this->db->select($sql);

            $sql = "SELECT * FROM agcms_service_levels";
            $levels = $this->db->select($sql);


            $sql = "SELECT * FROM agcms_services_rews WHERE SERVICE_ID = " . $item['ID'];
            $rews = $this->db->select($sql);
          /*  foreach ($rews as &$r){
                $r['REW'] = iconv_substr ($r['REW'], 0 , 350 , "UTF-8" );;
            }*/

            $this->assign(array(
                'item'             => $item,
                'category'             => $category,
                'levels'             => $levels,
                'list'             => $list,
                'rews'             => $rews,
                'parents'          => $categories,
                'page_title'       => $this->page_title ,
            ));

            $this->SetPath('services/single/');
            $this->content = $this->SetTemplate('default.tpl');
        }
    }

    public function DateFormat2($date){
        return date("d.m.Y", $date);
    }


    public function GetCartDB(){
        $sql = "SELECT * FROM agcms_cart WHERE HASH = '" . $_COOKIE['hash_cart'] . "'";
        $cart = $this->db->select($sql, array('single_array' => true));
        $cart = json_decode($cart['ORDER2']);
        return $cart;
    }

    public function UpdateCartDB($cart, $hash){
        $params = array(
            'ORDER2' => json_encode($cart,  JSON_UNESCAPED_UNICODE),
        );
        $this->db->update('agcms_cart', $params, "HASH = '" . $hash . "'");

    }

    public function AddCartDB($cart, $hash){
        $params = array(
            'ORDER2' => json_encode($cart,  JSON_UNESCAPED_UNICODE),
            'HASH' => $hash,
        );
        $this->db->insert('agcms_cart', $params);
    }

    public function AddOrder(){
        $cart = array();
        $order = array(
            'id' => $this->post['id'],
            'type' => $this->post['type'],
            'name' => $this->post['name'],
            'desc' => $this->post['desc'],
            'c_zn' => $this->post['c_zn'],
            'cur' => $this->post['cur'],
            'price' => $this->post['price'],
            'price_new' => $this->post['price_new'],
        );



        $a = true;
        if (isset($_COOKIE['hash_cart'])){
            if ($cart = $this->GetCartDB()){
                foreach ($cart as &$c){
                    if ($c->id == $order['id']){
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


    public function Index(){
        if (isset($this->post['add-order'])){
            $this->AddOrder();
        }


        if (isset($this->get['tag'])){
            $this->ShowItems();
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
                //$this->ShowMainPage();
            }
        } else {
            //$this->ShowMainPage();
        }

        return $this->content;
    }
}
?>