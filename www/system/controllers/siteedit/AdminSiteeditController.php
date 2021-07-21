<?php

class AdminSiteeditController extends AdminController {
    public function __construct() {
        parent::__construct();
        $this->categories    = array();
        $this->structure     = array();
        $this->act           = $this->get['act'];
        $this->list = array();
    }

    public function SetPlugins(){
        $this->js[]   = HTML_PLUGINS_DIR.'tinymce/tinymce.min.js';
    }

    public function ShowMenu(){
        $this->widget_left_top .=$this->fetch('menu.tpl');
    }

    function GetTemplates($d) {
        if ($os = glob($d."*")) {
            foreach($os as $o) {
                is_dir($o) ? $this->GetTemplates($o.'/') : $this->list[] = $o;
            }
        }
        return $this->list;
    }

    function ScanTemplates(){
        $this->GetTemplates($this->templates_dir);
        include_once(dirname(__FILE__)."/simple_html_dom.php");
        $s = '';
        $b = 0;

        foreach ($this->list as $t){
            $path = str_replace($this->templates_dir,'',$t);
            $bb = 0;
            $html = file_get_html($t,$use_include_path = false, $context=null, $offset = -1, $maxLen=-1, $lowercase = true, $forceTagsClosed=true, $target_charset = DEFAULT_TARGET_CHARSET, $stripRN=false, $defaultBRText=DEFAULT_BR_TEXT);
            if (!$html) continue;
            $elems = $html->find('.edit-box-site');
            if (count($elems) > 0){
                foreach($elems as &$e){
                    if( strpos($e->innertext,'[$EDIT_BOX_') === false){
                        $b = 1;
                        $bb = 1;
                        $tag = $e->tag;
                        if ($tag == 'img'){
                            $s = $e->src;
                        } else {
                            $s = $this->db->input($e->innertext);
                        }
                        $sql = "INSERT INTO `".db_pref."siteedit_vars`(`HTML`,`TAG`,`PATH`) VALUES ('$s','$tag','$path')";
                        $this->db->query($sql);
                        $id = $this->db->last_id();
                        if ($tag == 'img'){
                            $e->src = '[$EDIT_BOX_'.$id.']';
                        } else {
                            $e->innertext = '[$EDIT_BOX_'.$id.']';
                        }
                    }
                }
                if ($bb){
                    file_put_contents($t,$html->save());
                }
            }
            $html->clear();
            unset($html);
        }
        if ($b){
            $this->config->set('siteedit_enabled',1);
        }
    }

    function SetVarsCallback($data) {
        $res = '';
        foreach ($_SERVER['vars_array'] as $var){
            if ($var['ID'] == $data[1]){
                $res = $var['HTML'];
                break;
            }
        }
        return $res;
    }

    function RecoveryTemplates(){
        $this->GetTemplates($this->templates_dir);
        $_SERVER['vars_array'] = array();
        $_SERVER['vars_array'] = $this->getVars();
        $search = '/\[\$EDIT_BOX_([^>]*)\]/siu';
        foreach ($this->list as $t){
            $file = file_get_contents($t);
            $file = preg_replace_callback($search, 'self::SetVarsCallback', $file);
            file_put_contents($t,$file);
        }
        $this->ClearVars();
    }

    function getVars(){
        $list = array();
        $sql = "SELECT * FROM `".db_pref."siteedit_vars`";
        $query = $this->db->query($sql);
        for ($i=0; $i < $this->db->num_rows($query); $i++) {
            $list[] = $this->db->fetch_array($query);
        }
        return $list;
    }

    function ClearVars(){
        $sql = "TRUNCATE TABLE `".db_pref."siteedit_vars`";
        $this->db->query($sql);
    }

    public function Index(){
        $this->SetPlugins();
        $this->page_title = 'Визуальный редактор сайта';
        $this->ShowMenu();

        if ($this->act == 'scan-templates'){
            $this->ScanTemplates();
            $_SESSION['alert'] = 'Сканирование закончено!';
            $this->Head('?c=siteedit');
        }
        if ($this->act == 'recovery-templates'){
            $this->RecoveryTemplates();
            $_SESSION['alert'] = 'Восстановление закончено!';
            $this->Head('?c=siteedit');
        }
        $this->assign(array(
            'vars' =>    $this->getVars(),
        ));
        $this->content = $this->SetTemplate('index.tpl');


        return $this->content;
    }
}
?>