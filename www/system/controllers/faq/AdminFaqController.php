<?php

class AdminFaqController extends AdminController {
    public function __construct() {
        parent::__construct();
    }


    public function SaveItem(){
        $params = array(
            'TITLE' => $this->post['title'],
            'OTV' => $this->post['otv'],
        );
        if (isset($this->get['id'])){
            $this->db->update('agcms_faq_i', $params, "ID = " .  $this->get['id']);
        } else {
            $this->db->insert('agcms_faq_i', $params);
        }
        $this->Head('?c=faq');
    }

    public function DelItem(){
        $sql = "DELETE FROM agcms_faq_i WHERE ID = " . $this->get['id'];
        $this->db->query($sql);
        $this->Head("?c=faq");
    }

    public function Index(){

        if (isset($this->post['save-faq'])){
            $this->SaveItem();
        }

        $this->widget_left_top .=$this->fetch('menu.tpl');
        $this->page_title = 'Вопросы ответы';
        $this->js[]   = HTML_PLUGINS_DIR.'tinymce/tinymce.min.js';
        if (isset($this->get['act']) && $this->get['act'] == 'del'){
            $this->DelItem();
        }
        elseif (isset($this->get['act']) && $this->get['act'] == 'item'){
            if (isset($this->get['id'])){
                $sql = "SELECT * FROM agcms_faq_i WHERE ID = " .$this->get['id'];
                $this->assign(array(
                    'item' => $this->db->select($sql, array('single_array' => true)),
                ));

            }
            $this->content = $this->SetTemplate('item.tpl');
        }
        else {
            $sql = "SELECT * FROM agcms_faq_i";
            $this->assign(array(
                'items' => $this->db->select($sql),
            ));
            $this->content = $this->SetTemplate('index.tpl');
        }
        return $this->content;
    }
}
?>