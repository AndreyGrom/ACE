<?php
if (isset($_GET['term'])){
    require_once($_SERVER['DOCUMENT_ROOT'].'/system/classes/DB.class.php');
    $db = Database::getInstance();;
    $find = $_GET['term'];
    $sql = "SELECT * FROM `agcms_catalog_courses` WHERE TITLE LIKE '%$find%' LIMIT 20";
    $items =$db->select($sql);
    $rs = array();
    if ($items){
    foreach ($items as $i){
        $rs[] = $result[] = '{"label":"'.$i['TITLE'].'", "value":"'.$i['ID'].'"}';
        //$rs[] = $result[] = '{"id":"' . $i['TITLE'] . '", "label":"'.$i['TITLE'].'", "value":"'.$i['ID'].'"}';
    }
    //echo json_encode($rs);

    }
/*    header('Expires: Mon, 26 Jul 1997 05:00:00 GMT' );
    header('Last-Modified: ' . gmdate('D, d M Y H:i:s') . 'GMT');
    header('Cache-Control: no-cache, must-revalidate');
    header('Pragma: no-cache');
    header('Content-Type: text/json; charset=utf-8;');*/
    echo '['.implode(',',$rs).']';
}
?>