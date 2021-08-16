<?php

class PagesController extends Controller {
    public function __construct($query, $controller) {
        parent::__construct($query, $controller);
        $this->table_name = 'agcms_pages';
        $this->module_alias = 'pages';
    }
    public function Index(){
        $this->LoadModel('pages');
        if ($this->query){
            $row = $this->ModelPages->GetPageClient(end($this->query));
        } else {
            $row = $this->ModelPages->GetPage(1);
        }

        if ($row){
            $row['DATE_PUBL'] = $this->DateFormat($row["DATE_PUBL"]);
            $row['DATE_EDIT'] = $this->DateFormat($row["DATE_EDIT"]);
            $this->page_title = $row['TITLE'];
            $this->meta_title = $row['META_TITLE'];
            $this->meta_description = $row['META_DESC'];
            $this->meta_keywords = $row['META_KEYWORDS'];
            $this->page_title = $row['TITLE'];
            if ($this->meta_title == ''){
                $this->meta_title = $this->page_title.' - '. $this->config->SiteTitle;
            }
            if ($this->meta_description == ''){
                $this->meta_description = mb_substr(strip_tags($row['CONTENT']), 0, 200, 'UTF-8');;
            }
            if ($row['ID']>1){
                $this->breadcrumbs = array(
                    array('text' => 'Главная', 'href' => '/'),
                    array('text' => $row['TITLE'], 'href' => ''),
                );
            }

            $sql = "SELECT * FROM `agcms_catalog_predmets`";
            $predmets =  $this->db->select($sql);
            $sql = "SELECT * FROM `agcms_country` ORDER BY `COUNTRY_NAME`";
            $countries = $this->db->select($sql);

            $this->SetPath($this->module_alias.'/');
            $this->assign(array(
                'predmets'       => $predmets,
                'countries'       => $countries,
                'page_title'       => $row['TITLE'],
                'page_content'     => $row['CONTENT'],
            ));

            $cart = $this->GetCartDB();


            $this->assign(array(
                'cart' => $cart,
                'total' => $cart['total'],
            ));

            if ($row['ID'] == 1){
                $this->assign(array(
                    'spec'  => $this->GetSpec(),
                    'rews'  => $this->GetRews(),
                    'popular'  => $this->GetPopular(),
                ));
            }



            $this->content =$this->SetTemplate($row['TEMPLATE'] . '.tpl');
        } else {

        }
        return $this->content;
    }

    public function GetSpec(){
        $sql = "SELECT s.*, i.TITLE, co.COUNTRY_NAME, city.CITY_NAME, co.C_CURRENCY, i.PHOTO1, i.ALIAS,
            (SELECT MIN(course.PRICE) FROM agcms_catalog_courses course WHERE (i.ID = course.SH_ID) AND course.PRICE > 0) as MIN_PRICE
            FROM agcms_spec s
            LEFT JOIN agcms_catalog_i i ON s.SCH_ID = i.ID
            LEFT JOIN agcms_country co ON co.COUNTRY_ID = i.COUNTRY_ID
            LEFT JOIN agcms_city city ON city.CITY_ID = i.CITY_ID";
        return $this->db->select($sql);
    }

    public function GetPopular(){
        $sql = "SELECT popular.POPULAR_ID, country.COUNTRY_NAME, city.CITY_NAME, course.TITLE, i.PHOTO1,
                country.C_CURRENCY, i.ALIAS,
                   (SELECT MIN(cour.PRICE) FROM agcms_catalog_courses cour WHERE cour.ID = popular.POPULAR_ID AND cour.PRICE > 0) as MIN_PRICE
        FROM agcms_popular popular
        LEFT JOIN agcms_catalog_courses course ON course.ID = popular.POPULAR_ID
        LEFT JOIN agcms_catalog_i i ON i.ID = course.SH_ID
        LEFT JOIN agcms_country country ON country.COUNTRY_ID = i.COUNTRY_ID
        LEFT JOIN agcms_city city ON city.CITY_ID = i.CITY_ID";
        $item = $this->db->select($sql);
        return $item;
    }

    public function GetRews(){
        $sql = "SELECT * FROM agcms_services_rews WHERE SERVICE_ID = 0";

        return $this->db->select($sql);
    }



    public function getSiteMap(){
        $sql = "SELECT ALIAS FROM `agcms_pages`  WHERE `PUBLIC`=1 ORDER BY `DATE_PUBL` DESC";
        $result = $this->db->query($sql);
        $return = array();
        if ($this->db->num_rows($result)){
            for ($i = 0; $i < $this->db->num_rows($result); $i++){
                $row = $this->db->fetch_array($result);
                $return[]  = array(
                    'loc'           => $this->site_url . $row['ALIAS'] .'/',
                    'changefreq'    => 'weekly',
                    'priority'      => '1',
                );
            }
        }
        return $return;
    }

    public function GetCartDB(){
        $sql = "SELECT * FROM agcms_cart WHERE HASH = '" . $_COOKIE['hash'] . "'";
        $cart = $this->db->select($sql, array('single_array' => true));
        $cart = json_decode($cart['ORDER']);
        return $cart;
    }
}