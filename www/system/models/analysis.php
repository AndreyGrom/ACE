<?php

class ModelAnalysis extends Model {
    public function __construct() {
        parent::__construct();
        $this->table_name = db_pref.'pages';
        $this->table_name_content = 'pages_content';

    }

    function str_replace_once($search, $replace, $text)
    {
        $pos = strpos($text, $search);
        return $pos!==false ? substr_replace($text, $replace, $pos, strlen($search)) : $text;
    }

    public function FormatUrl($url){
        $url = $this->str_replace_once('https://', '', $url);
        $url = $this->str_replace_once('http://', '', $url);
        return $url;
    }

    public function GetSiteInfo($url){
        include_once(CLASSES_DIR . "analysis.class.php");
        $analiz = new Analysis();
        $analiz->url = $url;
        return $analiz->Run();
    }

}
?>