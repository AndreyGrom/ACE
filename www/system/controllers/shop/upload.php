<?php
session_start();

if (!isset($_SESSION['admin'])) exit;

date_default_timezone_set( 'Europe/Moscow' );
require_once(SYSTEM_DIR.'config/config.php');
require_once(SYSTEM_DIR.'smarty/SmartyBC.class.php');
require_once(CLASSES_DIR.'Smart.class.php');
require_once(CLASSES_DIR.'DB.class.php');
require_once(CLASSES_DIR.'Config.class.php');
require_once(CLASSES_DIR.'Image.class.php');
require_once(CLASSES_DIR.'Func.class.php');

$db = new Database();

if (isset($_FILES)){
    $smarty = Smart::getInstance();
    $smarty->template_dir = dirname( __FILE__  ).'/tpl/';

    if (isset($_FILES["upload_image"])){
        $id = $_GET['id'];
        $images = array();
        $upload_path = $_SERVER['DOCUMENT_ROOT'].'/'.UPLOAD_IMAGES_DIR.'shop/';
        $sql = "SELECT * FROM `".db_pref."shop_i` WHERE ID=$id";
        $query = $db->query($sql);
        $row = $db->fetch_array($query);
        $str = $row["IMAGES"];
        $image_count = count($_FILES["upload_image"]);
        if ($str!==''){
            $images = explode(",", $str);
        }
        $list = $_FILES["upload_image"];
        for ($i=0; $i < $image_count; $i++) {
            $image = Func::getInstance()->UploadFile($list['name'][$i],$list['tmp_name'][$i], $upload_path);
            if ($image){
                $images[] = $image;
                if (count($images)==1){
                    $skin = ", SKIN='".$images[0]."'";
                }
                $str = implode(",", $images);
                $sql = "UPDATE `".db_pref."shop_i` SET `IMAGES`='$str' $skin WHERE ID=$id";
                $query = $db->query($sql);
                $smarty->assign(array(
                    'image' => $image,
                    'new_image_upload' =>  Func::getInstance()->GetImage($upload_path.$image, 100,100,'','shop'),
                    'upload_images_dir'        => UPLOAD_IMAGES_DIR,
                ));
                echo $smarty->fetch('image.tpl');
            }
        }
    }

    if (isset($_FILES["file"])){
        $id = $_GET['id'];
        $files = array();
        $upload_path = $_SERVER['DOCUMENT_ROOT'].'/'.UPLOAD_FILES_DIR.'shop/';
        $upload_file = Func::getInstance()->UploadFile($_FILES["file"]['name'],$_FILES["file"]['tmp_name'], $upload_path);
        if ($upload_file) {
            $original_name = $_FILES["file"]["name"];
            $sql = "SELECT * FROM `".db_pref."shop_i` WHERE ID=$id";
            $query = $db->query($sql);
            $row = $db->fetch_array($query);
            $str = $row["FILES"];
            if ($str!==''){
                $files = unserialize($str);
            }
            $file_info = array(
                'original_name' => $original_name,
                'display_name' => $_POST['DisplayName'],
                'name' => $upload_file,
                'ext' => Func::getInstance()->getExt($original_name),
                'size' => filesize($upload . $file),
            );
            $files[] = $file_info;
            $str = serialize($files);
            $sql = "UPDATE `".db_pref."shop_i` SET `FILES`='$str' WHERE ID=$id";
            $query = $db->query($sql);
        }
        $smarty->assign(array(
            'file_item'               => $file_info,
            'upload_files_dir'        => $upload_path,
        ));
        echo $smarty->fetch('file.tpl');
    }
}
if (isset($_POST['skin'])){
    $id = $_POST['id'];
    $skin = $_POST['skin'];
    $sql = "UPDATE `".db_pref."shop_i` SET `SKIN`='$skin' WHERE ID=$id";
    $db->query($sql);
}
if (isset($_POST['image'])){
    /*Удаление изображения*/
    $id = $_POST['id'];
    $image= $_POST['image'];
    $sql = "SELECT * FROM `".db_pref."shop_i` WHERE ID=$id";
    $query = $db->query($sql);
    $row = $db->fetch_array($query);
    $str = $row["IMAGES"];
    if ($str!==''){
        $images = explode(",", $str);
        foreach ($images as $img){
            if ($img !== $image){
                $images_[] =  $img;
            }
        }
        $str = implode(',',$images_);
        $sql = "UPDATE `".db_pref."shop_i` SET `IMAGES`='$str' WHERE ID=$id";
        $db->query($sql);

        $file = $_SERVER['DOCUMENT_ROOT'].'/'.UPLOAD_IMAGES_DIR.'shop/'.$image;
        if (file_exists($file)){
            unlink($file);
        }
    }
}
if (isset($_POST['file'])){
    /*Удаление файла*/
    $id = $_POST['id'];
    $file= $_POST['file'];
    $sql = "SELECT * FROM `".db_pref."shop_i` WHERE ID=$id";
    $query = $db->query($sql);
    $row = $db->fetch_array($query);
    $str = $row["FILES"];
    if ($str!==''){
        $files = unserialize($str);
        foreach ($files as $f){
            if ($f['name'] !== $file){
                $files_[] =  $f;
            }
        }
        $str = serialize($files_);
        $sql = "UPDATE `".db_pref."shop_i` SET `FILES`='$str' WHERE ID=$id";
        $db->query($sql);

        $file = $_SERVER['DOCUMENT_ROOT'].'/'.UPLOAD_FILES_DIR.'shop/'.$file;
        if (file_exists($file)){
            unlink($file);
        }
    }
}
?>