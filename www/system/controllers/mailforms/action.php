<?php
session_start();
error_reporting(-1);
ini_set("display_errors", 0);
if (!isset($_POST['form_id'])) exit;
$id = $_POST['form_id'];

/*if (!isset($_COOKIE['mail_form_cid_'.$id])) exit;
if ($_COOKIE['mail_form_cid_'.$id] !== $_SESSION['mail_form_cid_'.$id]){
    echo '<div class="alert alert-info">Включите cookie</div>';
    exit;
};*/
include_once(dirname(__FILE__).'../../../func.php');
include_once(dirname(__FILE__).'/func.php');

$file = dirname(__FILE__).'/forms.xml';
if (!file_exists($file)) exit;
$form = GetForm($file,$id);
$form_name = $form['name'];
$success_message = $form['successMessage'];
$email1 = $form['email1'];
$email2 = $form['email2'];
$fields = GetFields($file,$id);
$message = '';
foreach ($fields as $f){
    $message .= $f['name'].': '.$_POST['f'.$f['id']]."<br/>\r\n";
}
mail_sender_plain($email1,$form_name, $message);

echo '<div class="alert alert-info">'.$success_message.'</div>';
?>