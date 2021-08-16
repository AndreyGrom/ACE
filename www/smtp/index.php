<?php

/*
    Михаил
    Инструкция по настройке ящика
    тут надо выполнить пункты №1 и №2
    https://yandex.ru/support/mail/mail-clients/mozilla-thunderbird.html
*/


// Тут вносим свои настройки от ящика
$Host = "smtp.yandex.ru"; // Не изменяем
$Port = 465; // Не изменяем
$Username = "infogrom1983@yandex.ru"; // Почтовый ящик
$Password = "";  // Пароль, созданный в раздели Пароли для приложений, из инструкции
$FromName = "Андрей Гром"; // От кого. Любое имя
$FromEmail = ""; // От кого. Только свой почтовый ящик, от которого пароль
$To = "grominfo@gmail.com";  // Кому письмо

/*=======================================================================================*/
// Далее ничего не меняем !!!

require 'PHPMailer/PHPMailer.php';
require 'PHPMailer/SMTP.php';
require 'PHPMailer/Exception.php';

$title = "Заголовок письма";
$body = "<h2>Новое письмо</h2>";


$mail = new PHPMailer\PHPMailer\PHPMailer();
try {
    $mail->isSMTP();
    $mail->CharSet = "UTF-8";
    $mail->SMTPAuth = true;
    $mail->SMTPDebug = 2;
    $mail->Debugoutput = function($str, $level) {$GLOBALS['status'][] = $str;};
    $mail->Host = $Host;
    $mail->Username = $Username;
    $mail->Password = $Password;
    $mail->SMTPSecure = 'ssl';
    $mail->Port = $Port;
    $mail->setFrom($FromEmail, $FromName);
    $mail->addAddress($To);
    $mail->isHTML(true);
    $mail->Subject = $title;
    $mail->Body = $body;
    if ($mail->send()) {
        $result = "success";
    }
    else {
        $result = "error";
    }
} catch (Exception $e) {
    $result = "error";
    $status = "Сообщение не было отправлено. Причина ошибки: {$mail->ErrorInfo}";
}
?>