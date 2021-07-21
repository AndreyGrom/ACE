<?php
$sql = "CREATE TABLE IF NOT EXISTS ".$db_prefix."news_c
        (
        ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
        PARENT INT NOT NULL,
        TITLE varchar(255),
        ALIAS varchar(255),
        POSITION INT NOT NULL,
        PUBLIC INT(1) NOT NULL,
        TEMPLATE varchar(255),
        META_DESC varchar(255),
        META_KEYWORDS varchar(255),
        IMAGE varchar(255),
        `DESC` text,
        `DESC2` text
        ) ENGINE=InnoDB DEFAULT CHARACTER SET=utf8";
$db->query($sql);
$sql = "CREATE TABLE IF NOT EXISTS ".$db_prefix."news_i
        (
        ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
        TITLE varchar(255),
        ALIAS varchar(255),
        PARENT INT NOT NULL,
        TEMPLATE varchar(255),
        PUBLIC INT(1) NOT NULL,
        COMMENTS INT(1) NOT NULL,
        IMAGES text,
        FILES text,
        DATE_PUBL INT(1) NOT NULL,
        DATE_EDIT INT(1) NOT NULL,
        POSITION INT NOT NULL,
        SHORT_CONTENT text,
        CONTENT text,
        META_DESC varchar(255),
        META_KEYWORDS varchar(255),
        TAGS text,
        SKIN varchar(255),
        PRICE decimal(10,0),
        PRICE_NEW decimal(10,0),
        OTHER1 text,
        OTHER2 text,
        OTHER3 text,
        OTHER4 text,
        OTHER5 text,
        OTHER6 text,
        OTHER7 text,
        OTHER8 text,
        OTHER9 text,
        OTHER10 text,
        FILE1 varchar(255),
        FILE2 varchar(255),
        FILE3 varchar(255),
        FILE1_NAME varchar(255),
        FILE2_NAME varchar(255),
        FILE3_NAME varchar(255)
        ) ENGINE=InnoDB DEFAULT CHARACTER SET=utf8";
$db->query($sql);
$date = time();
$sql = "INSERT INTO `".$db_prefix."news_c` (`PARENT`,`TITLE`,`ALIAS`,`POSITION`,`PUBLIC`,`TEMPLATE`,`DESC`,`DESC2`)
 VALUES
 ('0','Первая категория новостей','category1','99999','1','default_cat_list','Описание категории №1','Описание категории №2')";
$db->query($sql);
$sql = "INSERT INTO `".$db_prefix."news_i` (`TITLE`,`ALIAS`,`PARENT`,`TEMPLATE`,`PUBLIC`,`COMMENTS`,`DATE_PUBL`,`DATE_EDIT`,`SHORT_CONTENT`,`CONTENT`)
 VALUES
 ('Моя первая новость','new1',',1,','default','1','1','$date','$date','<p>Анонс новости</p>','<p>Полная новость</p>')";
$db->query($sql);
$array_config = array(
    "NewsSubCategories" => "0",
    "NewsModuleTitle" => "Галерея проектов",
    "NewsField1Name" => "Поле 1",
    "NewsField2Name" => "Поле 2",
    "NewsField3Name" => "Поле 3",
    "NewsField4Name" => "Поле 4",
    "NewsField5Name" => "Поле 5",
    "NewsField6Name" => "Поле 6",
    "NewsField7Name" => "Поле 7",
    "NewsField8Name" => "Поле 8",
    "NewsField9Name" => "Поле 9",
    "NewsField10Name" => "Поле 10",
    "NewsImageWidthCategoryList" => "200",
    "NewsImageHeightCategoryList" => "200",
    "NewsImageWidthItemList" => "200",
    "NewsImageHeightItemList" => "200",
    "NewsCategoryListPerPage" => "10",
    "NewsItemListSort" => "ASC",
    "NewsEnabled" => "1",
    "NewsCommentsEnabled" => "1",
    "NewsCommentsTemplateView" => "default",
    "NewsCommentsTemplateForm" => "default",
);
foreach ($array_config as $k=>$v){
    $sql = "INSERT INTO `".$db_prefix."config` (`PARAM`,`VALUE`) VALUES('".$k."','".$v."') ";
    $db->query($sql);
}
?>