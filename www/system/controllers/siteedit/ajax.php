<?php
session_start();

if (!isset($_SESSION['admin'])) exit;
$_SESSION['admin'] = $_SESSION['admin'];
if (isset($_POST['id'])){
    include_once($_SERVER['DOCUMENT_ROOT'].'/system/classes/DB.class.php');
    include_once($_SERVER['DOCUMENT_ROOT'].'/system/config/db.php');

    $db = Database::getInstance();
    $id = $_POST['id'];
    $html = $db->input($_POST['html']);;
    $sql = "UPDATE `".db_pref."siteedit_vars` SET `HTML`='$html' WHERE `ID`=$id";
    $db->query($sql);
    echo 1;
}

?>