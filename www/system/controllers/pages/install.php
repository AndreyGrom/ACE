<?php
$table_name = '';
$module_alias = '';
require_once(dirname(__FILE__).'/module_config.php');
$sql = "CREATE TABLE IF NOT EXISTS $table_name
        (
        ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
        PARENT INT NOT NULL,
        TITLE varchar(255),
        ALIAS varchar(255),
        CONTENT text,
        META_DESC varchar(255),
        META_KEYWORDS varchar(255),
        COMMENTS INT(1) NOT NULL,
        PUBLIC INT(1) NOT NULL,
        TEMPLATE varchar(255),
        DATE_PUBL INT NOT NULL,
        DATE_EDIT INT NOT NULL,
        POSITION INT NOT NULL
        ) ENGINE=InnoDB DEFAULT CHARACTER SET=utf8";
$db->query($sql);
$date = time();
$sql = "INSERT INTO $table_name (`PARENT`,`TITLE`,`ALIAS`,`CONTENT`,`COMMENTS`,`PUBLIC`,`TEMPLATE`,`DATE_PUBL`,`DATE_EDIT`,`POSITION`)
 VALUES
 ('0','Главная страница','main','<p>Это текст главной страницы</p>','1','1','main','$date','$date','0')";
$db->query($sql);
?>