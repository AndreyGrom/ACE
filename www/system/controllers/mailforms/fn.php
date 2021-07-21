<?php
/*function mail_form ($params) {
    $form = '';
    if (isset($params['id'])){
        $form_file = TEMPLATES_DIR.Config::getInstance()->Theme.'/tpl/mailforms/form'.$params['id'].'.tpl';
        if (file_exists($form_file)){
            $form = file_get_contents($form_file);
        }
    }
    echo $form ;
    Manager::getInstance()->SetJS(HTML_CONTROLLERS_DIR.'mailforms/action.js');
}
Smart::getInstance()->register_function("mail_form", "mail_form");*/

function mail_form ($id) {
    $form = '';
    if (isset($id)){
        $form_file = TEMPLATES_DIR.Config::getInstance()->Theme.'/tpl/mailforms/form'.$id.'.tpl';
        if (file_exists($form_file)){
            $form = file_get_contents($form_file);
        }
    }
    Manager::getInstance()->SetJS(HTML_CONTROLLERS_DIR.'mailforms/action.js');
    return $form ;
}

?>