<?php
session_start();
ini_set("display_errors", 0);
if (!isset($_SESSION['admin'])) exit;

date_default_timezone_set( 'Europe/Moscow' );
require_once($_SERVER['DOCUMENT_ROOT'].'/system/config/config.php');
require_once($_SERVER['DOCUMENT_ROOT'].'/system/smarty/SmartyBC.class.php');
require_once($_SERVER['DOCUMENT_ROOT'].'/system/classes/Smart.class.php');
require_once($_SERVER['DOCUMENT_ROOT'].'/system/classes/DB.class.php');
require_once($_SERVER['DOCUMENT_ROOT'].'/system/classes/Config.class.php');
require_once($_SERVER['DOCUMENT_ROOT'].'/system/classes/Image.class.php');
require_once($_SERVER['DOCUMENT_ROOT'].'/system/classes/Func.class.php');

$db = new Database();
function GetImage2($old_image, $width, $height){
    $new_image = '';
    $path_info = pathinfo($old_image);
    $ext = $path_info['extension'];
    if (file_exists($old_image)){
        $new_image = CACHE_IMAGES.basename($old_image,'.'.$ext).'_'.$width.'x'.$height.'.'.$ext;
        if (!file_exists($_SERVER['DOCUMENT_ROOT'].'/'.$new_image)){
            $image = new Image($old_image);
            $image->resize($width, $height);
            $image->save($_SERVER['DOCUMENT_ROOT'].'/'.$new_image);
        }
    }
    return $new_image;
}


if (isset($_FILES)){
    $smarty = Smart::getInstance();
    $smarty->template_dir = dirname( __FILE__  ).'/tpl/';

    if (isset($_FILES["image"])){
        $id = $_GET['id'];
        $images = array();
        $upload = UPLOAD_IMAGES_DIR.'catalog/';

        $cache_img = CACHE_IMAGES;
        $sql = "SELECT * FROM `".db_pref."catalog_i` WHERE ID=$id";
        $query = $db->query($sql);
        $row = $db->fetch_array($query);
        $str = $row["IMAGES"];
        if ($str!==''){
            $images = explode(",", $str);
        }
        if (is_uploaded_file($_FILES["image"]["tmp_name"])) {
            if (!is_dir($upload)) Func::getInstance()->CreatePath($upload);
            if (!is_dir($cache_img)) Func::getInstance()->CreatePath($cache_img);
            $image = Func::getInstance()->generateName() . '.' . Func::getInstance()->getExt($_FILES["image"]["name"]);
            move_uploaded_file($_FILES["image"]["tmp_name"], $upload . $image);
            $images[] = $image;
            if (count($images)==1){
                $skin = ", SKIN='".$images[0]."'";
            }
            $str = implode(",", $images);
            $sql = "UPDATE `".db_pref."catalog_i` SET `IMAGES`='$str' $skin WHERE ID=$id";

            $query = $db->query($sql);
        }

        $smarty->assign(array(
            'image' => $image,
            'new_image' =>  GetImage2($upload.$image, 100,100),
            'upload_images_dir'        => UPLOAD_IMAGES_DIR,
            'cache_images'             => CACHE_IMAGES,
        ));
        echo $smarty->fetch('image.tpl');
    }

    if (isset($_FILES["file"])){
        $id = $_GET['id'];
        $files = array();
        $upload = UPLOAD_FILES_DIR.'catalog/';
        $sql = "SELECT * FROM `".db_pref."catalog_i` WHERE ID=$id";
        $query = $db->query($sql);
        $row = $db->fetch_array($query);
        $str = $row["FILES"];
        if ($str!==''){
            $files = unserialize($str);
        }
        if (is_uploaded_file($_FILES["file"]["tmp_name"])) {
            if (!is_dir($upload)) Func::getInstance()->CreatePath($upload);
            $original_name = $_FILES["file"]["name"];
            $file = Func::getInstance()->generateName() . '.' . Func::getInstance()->getExt($original_name);
            move_uploaded_file($_FILES["file"]["tmp_name"], $upload . $file);

            $file_info = array(
                'original_name' => $original_name,
                'display_name' => $_POST['DisplayName'],
                'name' => $file,
                'ext' => Func::getInstance()->getExt($original_name),
                'size' => filesize($upload . $file),
            );
            $files[] = $file_info;
            $str = serialize($files);
            $sql = "UPDATE `".db_pref."catalog_i` SET `FILES`='$str' WHERE ID=$id";
            $query = $db->query($sql);

        }
        $smarty->assign(array(
            'file_item' => $file_info,
            'upload_files_dir'        => UPLOAD_FILES_DIR,
        ));
        echo $smarty->fetch('file.tpl');
    }
}
if (isset($_POST['skin'])){
    $id = $_POST['id'];
    $skin = $_POST['skin'];
    $sql = "UPDATE `".db_pref."catalog_i` SET `SKIN`='$skin' WHERE ID=$id";
    $db->query($sql);
}
if (isset($_POST['image'])){
    $id = $_POST['id'];
    $image= $_POST['image'];
    $sql = "SELECT * FROM `".db_pref."catalog_i` WHERE ID=$id";
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
        $sql = "UPDATE `".db_pref."catalog_i` SET `IMAGES`='$str' WHERE ID=$id";
        $db->query($sql);

        $file = $_SERVER['DOCUMENT_ROOT'].'/'.UPLOAD_IMAGES_DIR.'catalog/'.$image;
        if (file_exists($file)){
            unlink($file);
        }
    }
}
if (isset($_POST['file'])){
    $id = $_POST['id'];
    $file= $_POST['file'];
    $sql = "SELECT * FROM `".db_pref."catalog_i` WHERE ID=$id";
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
        $sql = "UPDATE `".db_pref."catalog_i` SET `FILES`='$str' WHERE ID=$id";
        $db->query($sql);

        $file = $_SERVER['DOCUMENT_ROOT'].'/'.UPLOAD_FILES_DIR.'catalog/'.$file;
        if (file_exists($file)){
            unlink($file);
        }
    }
}
?>