<?php
$sql = "CREATE TABLE IF NOT EXISTS ".$db_prefix."config
        (
        ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
        PARAM text,
        VALUE text
        ) ENGINE=InnoDB DEFAULT CHARACTER SET=utf8";
$db->query($sql);
$array_config = array(
    "AdminLogin" => "$admin_login",
    "AdminPassword" => "$admin_password",
    "SiteTitle" => "AG CMS - самый быстрый универсальный движок для Вашего сайта!",
    "Theme" => "default",
    "SiteEnabled" => "1",
    "ModuleDefault" => "pages",
);
foreach ($array_config as $k=>$v){
    $sql = "INSERT INTO `".$db_prefix."config` (`PARAM`,`VALUE`) VALUES('".$k."','".$v."') ";
    $db->query($sql);
}
?>