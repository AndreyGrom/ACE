<?php
session_start();
ini_set("display_errors", 0);
date_default_timezone_set( 'Europe/Moscow' );
require_once($_SERVER['DOCUMENT_ROOT'].'/system/config/config.php');
require_once($_SERVER['DOCUMENT_ROOT'].'/system/classes/DB.class.php');
require_once($_SERVER['DOCUMENT_ROOT'].'/system/classes/Config.class.php');
require_once($_SERVER['DOCUMENT_ROOT'].'/system/classes/Image.class.php');
require_once($_SERVER['DOCUMENT_ROOT'].'/system/classes/Func.class.php');

$db = new Database();

if (isset($_FILES)){
    if (isset($_FILES["image"])){
        $id = $_GET['id'];
        $upload = UPLOAD_IMAGES_DIR.'users/avatars/' .$id . '/';
        if (is_uploaded_file($_FILES["image"]["tmp_name"])) {
            $image = Func::getInstance()->generateName() . '.' . Func::getInstance()->getExt($_FILES["image"]["name"]);
           Func::getInstance()->CreatePath($upload);
            move_uploaded_file($_FILES["image"]["tmp_name"], $upload . $image);
            $sql = "UPDATE `".db_pref."users` SET `AVATAR`='$image' WHERE ID=$id";

            $query = $db->query($sql);

        }


        echo '<img src="/upload/images/users/avatars/' . $id . '/' . $image . '" />';

    }
}

?>