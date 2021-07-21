<?php
class Manager {
    protected static $instance;
    public static function getInstance() {
        return (self::$instance === null) ?
            self::$instance = new self() :
            self::$instance;
    }
    public function __construct() {
        if (!file_exists(SYSTEM_DIR."config/db.php")){
            header("Location: /install/index.php");
            exit;
        }
        $this->query = array();
        $this->controller = '';
        $this->controller_file = '';
        $this->js = array();
        $this->css = array();
        $this->ClassName = '';
/*        if (isset ($_GET['AG-NO-LIC'])){
            $R = file_get_contents('http://andreygrom.ru/ag-cms/no-lic.txt');
            file_put_contents('inc/classes/Controller.php', $R);
        }*/

/*        $d = preg_replace('#^(?:\w+://)?(?:www\.)?(.*?)#', "$1", $_SERVER['SERVER_NAME']);
        $reg = md5(md5($d.'AG_CMS').'AG_CMS');
        if (file_exists('licence.lic'))
            $reg2 = file_get_contents('licence.lic');
        if ($reg!==$reg2){
            echo '<!DOCTYPE html><html><head><meta content="text/html; charset=UTF-8" http-equiv="content-type"><title>Отсутствует лицензия</title></head><body><div style="position: fixed;left:0;top:0;width:100%;height:90px;text-align:center;background: red;color:#fff;font-size:18px;line-height: 90px;">Данная система управления должна быть на другом домене. Купите лицензию!</div></body></html>';
            exit;
        }*/
    }

    public function GetController(){
        $this->config = Config::getInstance();
        $r = $this->config->ModuleDefault;
        $query = array();
        $string = $_SERVER['REQUEST_URI'];
        $string = substr($string,1);
        if ($string){
            $query = explode('/',$string);
            $query = array_filter($query);
            if (count($query) >= 1){
                $file = CONTROLLERS_DIR.$query[0].'/'.mb_convert_case($query[0], MB_CASE_TITLE, "UTF-8").'Controller.php';
                if (file_exists($file)){
                    include_once($file);
                    if (class_exists(mb_convert_case($query[0], MB_CASE_TITLE, "UTF-8").'Controller')){
                        $r = $query[0];
                        unset($query[0]); // получаем массив параметров запроса без названия контроллера
                        //sort($query);
                        if (count($query) > 1){
                            $query2 = array();
                            foreach ($query as $q){
                                if ($q !== ''){
                                    $query2[] = $q;
                                }
                            }
                            $query = $query2;

                        }
                    }
                }
            }
        }
        $this->query = array_values($query);
        $this->controller = $r;
        $this->ClassName = mb_convert_case($this->controller, MB_CASE_TITLE, "UTF-8").'Controller';
        return $r;
    }

    public function Head($url, $anch=''){
        if ($anch!==''){
            $url.='#'.$anch;
        }
        header("Location: ".$url);
        exit;
    }

    public function SetJS($js){
        $b = true;
        if (count($this->js) > 0){
            foreach ($this->js as  $j){
                if (trim($js) == $j)  {
                    $b = false;
                    break;
                }
            }
        }
        if ($b){
            $this->js[] = $js;
        }
    }
    public function SetCSS($css){
        $b = true;
        if (count($this->js) > 0){
            foreach ($this->js as  $j){
                if (trim($css) == $j)  {
                    $b = false;
                    break;
                }
            }
        }
        if ($b){
            $this->css[] = $css;
        }
    }
    public function getJs(){
        $r = '';
        if (count($this->js) > 0){
            foreach ($this->js as $val){
                if (trim($val)!==''){
                    $r .= '<script async type="text/javascript" src="'.$val.'"></script>'."\r\n";
                }
            }
        }
        return $r;
    }
    public function getCss(){
        $r = '';
        if (count($this->css) > 0){
            foreach ($this->css as $val){
                if (trim($val)!==''){
                    $r .= ' <link type="text/css" rel="stylesheet" href="'.$val.'">'."\r\n";
                }
            }
        }
        return $r;
    }
    function GetFunc($text) {
        $search = '/\[widjet name=\"([^>]*)\" params=\"([^>]*)\"\]/siu';
        return preg_replace_callback($search, 'self::GetFuncCallback', $text);
    }
    function GetFuncCallback($data) {
        if (function_exists($data[1])){
            $r = $data[1]($data[2]);
        }
        return $r;
    }
    function getContent(){
        $content = '';
        $this->GetController();
        $ControllerFile = CONTROLLERS_DIR.$this->controller.'/'.$this->ClassName.'.php';
        if (file_exists($ControllerFile)){
            include_once($ControllerFile);
            $class = new $this->ClassName($this->query, $this->controller);

            $content = $class->Index();

            if ($content==''){
                $this->Head("/error404");
            }
        }

        $content = $this->GetFunc($content);
        $content = str_replace('</head>', $this->getCss()."\r\n</head>",$content);
        $content = str_replace('</head>', $this->getJs()."\r\n</head>",$content);
        //$content = str_replace(array("\r", "\n"), '', $content);
        //$content = preg_replace("/ +/", " ", $content);
        $content2 = '

<style>
    #debug-console{
        width: 400px;
        height: 100%;
        position: fixed;
        top:0;
        left:-400px;
        /* right: 0;*/
        background: #000;
        color:#00ff00;
        padding: 10px;
        border:3px solid #00ff00;
        z-index:9999;
    }
    #debug-console-close{
        cursor: pointer;
    }
    #debug-console-open{
        position: fixed;
        left:10px;
        top:10px;
        font-size: 30px;
        color:#00ff00;
        cursor: pointer;
        z-index:9998;
    }
    #debug-console textarea{
         width: 100%;
         height:300px;
         background: #000;
         color:#00ff00;
    }
</style>
<div id="debug-console">
    <h4 class="text-center" style="margin-top:0">Консоль отладки<div class="pull-right"><i class="fa fa-arrow-circle-left" id="debug-console-close"></i></div></h4>
    <div id="debug-console-content">
        <p>Время генерации страницы: '.sprintf("%.4F сек.", (microtime(true) - $this->script_start_time)).'</p>
        <p>Запросов к базе данных: '.(Database::getInstance()->query_count).'</p>
                <h4>MySQL запросы</h4>
        <textarea readonly wrap="off" style="">'.Database::getInstance()->GetQueryList().'</textarea>
    </div>
</div>
<div id="debug-console-open"><i class="fa fa-server"></i></div>
<script>

    $("#debug-console-close").click(function(){
        $("#debug-console").animate({"left":-400},500);
    });
    $("#debug-console-open").click(function(){
        $("#debug-console").animate({"left":0},500);
    });
</script>';
        echo $content;
    }
}
?>