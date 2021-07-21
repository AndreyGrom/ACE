<?php
$sql = "CREATE TABLE IF NOT EXISTS ".$db_prefix."comments
        (
        ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
        CONTROLLER varchar(255),
        MATERIAL_ID INT(11) NOT NULL,
        DATE_PUBL INT NOT NULL,
        USER_NAME varchar(255),
        USER_EMAIL varchar(255),
        USER_COMMENT text,
        PARENT INT NOT NULL,
        IP varchar(15),
        STATUS INT(1) NOT NULL
        ) ENGINE=InnoDB DEFAULT CHARACTER SET=utf8";
$db->query($sql);
$array_config = array(
    "CommentsPubl" => "1",
);
foreach ($array_config as $k=>$v){
    $sql = "INSERT INTO `".$db_prefix."config` (`PARAM`,`VALUE`) VALUES('".$k."','".$v."') ";
    $db->query($sql);
}
?>