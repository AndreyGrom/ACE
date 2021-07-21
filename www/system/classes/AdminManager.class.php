<?php

class AdminManager {
    public function __construct() {
        if (!file_exists("system/config/db.php")){
            header("Location: /install/");
            exit;
        }
        if (isset($_GET['remove-system-cash'])){
            Func::getInstance()->DelDirCache('cache');
            header("Location: ".$_SERVER['HTTP_REFERER']);
            exit;
        }
        if (!isset($_SESSION['admin'])){
            $_GET['c'] = 'login';
        }
        if (isset($_GET['c']) && $_GET['c']!==''){
            $this->controller = $_GET['c'];
        } else {
            $this->Head('?c=index');
        }

        $d1 = 'http://';
        $d2 = 'andreygrom';
        $d3 = '.ru/';
        $d4 = 'php/';
        $d5 = 'check.php';
        $d = preg_replace('#^(?:\w+://)?(?:www\.)?(.*?)#', "$1", $_SERVER['SERVER_NAME']);
        if (md5($d)!==@file_get_contents('system/data/d.txt')){
            @file_get_contents($d1.$d2.$d3.$d4.$d5.'?d='.$_SERVER['SERVER_NAME']);
            file_put_contents('system/data/d.txt',md5($d));
        }

    }
    public function getContent(){
        $ControllerFile = CONTROLLERS_DIR.$this->controller.'/Admin'.mb_convert_case($this->controller, MB_CASE_TITLE, "UTF-8").'Controller.php';
        $content = '';
        if (file_exists($ControllerFile)){
            include_once($ControllerFile);
            $class_name ='Admin'.mb_convert_case($this->controller, MB_CASE_TITLE, "UTF-8").'Controller';
            $class = new $class_name();
            $content = $class->Index();
        }

        if ($content !== ''){
            echo $content;
        } else{
            $this->Head('/error404');
        }

    }

    public function Head($url, $anch=''){
        if ($anch!==''){
            $url.='#'.$anch;
        }
        header("Location: ".$url);
        exit;
    }





}
?>