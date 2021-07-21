<?php
require_once($_SERVER['DOCUMENT_ROOT'].'/system/classes/DB.class.php');
$db = Database::getInstance();
$rs = array();
if (isset($_POST['cid'])){
    $sql = "SELECT v.*, c.C_ZN, c.C_CURRENCY FROM agcms_service_visa v
    LEFT JOIN agcms_country c ON c.COUNTRY_ID = v.COUNTRY_ID

    WHERE v.COUNTRY_ID = " . $_POST['cid'];
    $rs = $db->select($sql);
}


echo json_encode($rs);
?>