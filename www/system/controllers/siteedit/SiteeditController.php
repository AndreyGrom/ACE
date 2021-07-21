<?php

class PagesController extends Controller {
    public function __construct($query, $controller) {
        parent::__construct($query, $controller);
        $table_name = '';
        $module_alias = '';
        require_once(dirname(__FILE__).'/module_config.php');
        $this->table_name = $table_name;
        $this->module_alias = $module_alias;
    }
    public function Index(){
        $row = 0;
        $alias='';
        $id = 1;
        $page = array();
        if ($this->query){
            $alias = end($this->query);
            $sql = "SELECT * FROM $this->table_name WHERE `ALIAS` = '$alias' AND `PUBLIC`=1 LIMIT 1";
            $query = $this->db->query($sql);
            if ($this->db->num_rows($query) > 0){
                $row = $this->db->fetch_array($query);
            }
        } else {
            $sql = "SELECT * FROM $this->table_name WHERE `ID` = '$id' AND `PUBLIC`=1 LIMIT 1";
            $query = $this->db->query($sql);
            if ($this->db->num_rows($query) > 0){
                $row = $this->db->fetch_array($query);
            }
        }
        if ($row){
            $row['DATE_PUBL'] = $this->DateFormat($row["DATE_PUBL"]);
            $row['DATE_EDIT'] = $this->DateFormat($row["DATE_EDIT"]);
            $page = $row;
            $this->page_title = $page['TITLE'];
            $this->meta_title = $page['META_TITLE'];
            $this->meta_description = $page['META_DESC'];
            $this->meta_keywords = $page['META_KEYWORDS'];
            $this->page_title = $page['TITLE'];
            if ($this->meta_title == ''){
                $this->meta_title = $this->page_title.' - '. $this->config->SiteTitle;
            }

            if ($page['ID']>1){
                $this->breadcrumbs = array(
                    array('text' => 'Главная', 'href' => '/'),
                    array('text' => $page['TITLE'], 'href' => ''),
                );
            }


            $this->SetPath($this->module_alias.'/');
            $this->assign(array(
                'page_title'       => $page['TITLE'],
                'page_content'     => $page['CONTENT'],
            ));
            $this->content =$this->SetTemplate($page['TEMPLATE'] . '.tpl');
        } else {
            //$this->Head("/catalog/$alias"); редирект для махача
        }
        return $this->content;
    }
}