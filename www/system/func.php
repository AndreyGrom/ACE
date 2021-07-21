<?php
function generatePassword($length = 8){
    $chars = 'abdefhiknrstyzABDEFGHKNQRSTYZ23456789';
    $numChars = strlen($chars);
    $string = '';
    for ($i = 0; $i < $length; $i++) {
        $string .= substr($chars, rand(1, $numChars) - 1, 1);
    }
    return $string;
}

function mail_sender_plain($to, $subject, $content, $attach=false)
{
    require_once(dirname(__FILE__).'/classes/Config.class.php');
    require_once(dirname(__FILE__).'/classes/DB.class.php');
    require_once(dirname(__FILE__).'/plugins/phpmailer/class.phpmailer.php');
    $mail = new PHPMailer(true);
    $config = Config::getInstance();

    if ($config->MailSMTPEnabled){
        //$mail->IsSMTP();
    }

    try {
        $mail->Host       = $config->MailSMTPHost;
        $mail->SMTPDebug  = 0;
        $mail->SMTPAuth   = true;
        $mail->Port       = $config->MailSMTPPort;
        $mail->Username   = $config->MailSMTPUserName;
        $mail->Password   = $config->MailSMTPUserPassword;
        $mail->CharSet    = 'UTF-8';
        $mail->AddReplyTo($mail->Username, $mail->Username);
        $mail->AddAddress($to);
        $mail->SetFrom($mail->Username, $config->MailSMTPFromName);
        $mail->AddReplyTo($mail->Username, $mail->Username);
        $mail->Subject = htmlspecialchars($subject);
        $mail->isHTML(true);
        $mail->Body = $content;
        if($attach)  $mail->AddAttachment($attach);
        $mail->Send();
        return true;
    } catch (phpmailerException $e) {
        return false;
    } catch (Exception $e) {
        return false;
    }
}

?>