<?php

class AdminOrdersController extends AdminController {
    public function __construct() {
        parent::__construct();
    }
    public function GetOrder($id){
        $sql = "SELECT * FROM agcms_orders WHERE ID = $id ";
        $rs = $this->db->select($sql, array('single_array' => true));
        if ($rs){
            $rs['DATE_START'] = $this->DateFormat($rs['DATE_START']);
        }

        return $rs;
    }
    public function GetCart(){
        $order = $this->GetOrder($this->get['id']);
        $cart = json_decode($order['CONT']);

        $ids = array();
        $c_list = array();
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
        $sql = "SELECT c.*, co.COUNTRY_NAME, ci.CITY_NAME, i.PHOTO1, i.TITLE AS SH_TITLE FROM agcms_catalog_courses c
        LEFT JOIN agcms_catalog_i i ON i.ID = c.SH_ID
        LEFT JOIN agcms_country co ON co.COUNTRY_ID = i.COUNTRY_ID
        LEFT JOIN agcms_city ci ON ci.CITY_ID = i.CITY_ID
        WHERE c.ID IN (". implode(', ', $c_list) .")";
        $c_list = $this->db->select($sql);

        $sql = "SELECT p.*, co.COUNTRY_NAME, ci.CITY_NAME, i.TITLE AS SH_TITLE FROM agcms_catalog_prozhiv p
        LEFT JOIN agcms_catalog_i i ON i.ID = p.SH_ID
        LEFT JOIN agcms_country co ON co.COUNTRY_ID = i.COUNTRY_ID
        LEFT JOIN agcms_city ci ON ci.CITY_ID = i.CITY_ID
        WHERE p.ID IN (". implode(', ', $p_list) .")";
        $p_list = $this->db->select($sql);
        $cart = array(

            'c_list' => $c_list,
            'p_list' => $p_list,
            'p_list2' => $p_list2,
            'd_list' => $d_list,
            'total' => $total,
            'order' => $order,
        );



        return $cart;
    }

    public function ShowItems(){
        $sql = "SELECT * FROM agcms_orders";
        if ($items = $this->db->select($sql)){
            foreach ($items as &$i){
                $i['DATE'] = $this->DateFormat2($i['DATE_START']);
            }
        }
        $this->assign(array(
            'items' => $items,
        ));
        $this->content = $this->SetTemplate('index.tpl');
    }

    public function ShowItem(){

        $sql = "SELECT * FROM agcms_orders WHERE ID = " . $this->get['id'] ;
        $order = $this->db->select($sql, array('single_array' => true));
        $order['DATE'] = $this->DateFormat2($order['DATE_START']);
        $cart = json_decode($order['CONT']);


        $this->assign(array(
            'order' => $order,
            'cart' => $cart,
        ));

        $this->content = $this->SetTemplate('item.tpl');;
    }

    public function SetStatus(){
        $sql = "UPDATE agcms_orders SET STATUS = " . $this->post['status'] ." WHERE ID = " . $this->get['id'];
        $this->db->query($sql);
        $this->Head('?c=orders&act=item&id=' . $this->get['id']);
    }

    public function DelItem(){
        $sql = "DELETE FROM agcms_orders WHERE ID = " .$this->get['id'];
        $this->db->query($sql);
        $this->Head('?c=orders');
    }

    public function Index(){

        if (isset($this->post['set-status'])){
            $this->SetStatus();
        }
        $this->widget_left_top .=$this->fetch('menu.tpl');
        $this->page_title = 'Вопросы ответы';
        $this->js[]   = HTML_PLUGINS_DIR.'tinymce/tinymce.min.js';

        if (isset($this->get['act']) && $this->get['act'] == 'item'){
            $this->ShowItem();
        }
        elseif (isset($this->get['act']) && $this->get['act'] == 'del'){
            $this->DelItem();
        }
        else {
            $this->ShowItems();
        }
        return $this->content;
    }
}
?>