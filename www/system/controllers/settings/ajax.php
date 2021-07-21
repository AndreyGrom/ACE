<?php
require_once('../../classes/DB.class.php');
if (isset($_POST['get_city'])){
    $id = $_POST['get_city'];
    $db = Database::getInstance();
    $sql = "SELECT * FROM `".db_pref."city` WHERE `COUNTRY_ID`=$id ORDER BY `CITY_NAME`";
    $result = '<option value="">Город</option>';
    $query = $db->query($sql);
    if ($db->num_rows($query) > 0){
        for ($i=0; $i < $db->num_rows($query); $i++) {
            $row = $db->fetch_array($query);
            $result .= '<option data-name="'.$row['CITY_NAME'].'" value="'.$row['CITY_ID'].'">'.$row['CITY_NAME'].'</option>';
        }
    }
    echo $result;
}
if (isset($_POST['get_region'])){
    $id = $_POST['get_region'];
    $db = Database::getInstance();
    $sql = "SELECT * FROM `".db_pref."regions` WHERE `COUNTRY_ID`=$id ORDER BY `REGION_NAME`";
    $result = '';
    $query = $db->query($sql);
    if ($db->num_rows($query) > 0){
        for ($i=0; $i < $db->num_rows($query); $i++) {
            $row = $db->fetch_array($query);
            $result .= '<option data-name="'.$row['REGION_NAME'].'" value="'.$row['REGION_ID'].'">'.$row['REGION_NAME'].'</option>';
        }
    }
    echo $result;
}
?>