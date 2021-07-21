<?php
require_once($_SERVER['DOCUMENT_ROOT'].'/system/classes/DB.class.php');

if (isset($_GET['term'])){
    $s = $_GET['term'];
    $rs = array();
    $db = Database::getInstance();
    $sql = "SELECT * FROM agcms_catalog_i WHERE ADDRESS LIKE '%" . $s . "%' LIMIT 20";
    $items =  $db->select($sql);
    /*var_dump($sql);*/
    if ($items){
        foreach ($items as $i){
            $rs[] = $i['ADDRESS'];
        }
        echo json_encode($rs);

    }

}


?>