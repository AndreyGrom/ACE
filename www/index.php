<?php

session_start();
error_reporting(-1);
ini_set("display_errors", 0);
/*ini_set('log_errors', 'On'); */
/*ini_set('error_log', 'system/logs/errors.log');*/
$script_start = microtime(true);
require_once('system/config/config.php');
require_once('system/plugins/geshi/geshi.php');
require_once('system/smarty/SmartyBC.class.php');
require_once('system/classes/Controller.php');
require_once('system/classes/Config.class.php');
require_once('system/classes/DB.class.php');
require_once('system/classes/Func.class.php');
require_once('system/classes/Image.class.php');
include_once("system/classes/Smart.class.php");
include_once("system/classes/Manager.class.php");
include_once("system/classes/Model.class.php");
include_once("system/func.php");

if (is_dir(CONTROLLERS_DIR)){
    $list = scandir(CONTROLLERS_DIR);
    foreach ($list as $l){
        $file_func = CONTROLLERS_DIR.$l.'/fn.php';
        if (file_exists($file_func)){
            include_once($file_func);
        }
    }
}
$mng = Manager::getInstance();
$mng->script_start_time = $script_start;
$mng->getContent();
?>