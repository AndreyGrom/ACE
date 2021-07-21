<?php

class error404Controller extends Controller {
    public function __construct($query, $controller) {
        parent::__construct($query, $controller);
    }
    public function Index(){
        $this->SetPath('error404/');
        $this->assign(array(
            'site_title'       => 'Ошибка 404. Страницы не существует - '. $this->config->SiteTitle,
        ));
        $this->content =$this->SetTemplate('error404.tpl');
        header('HTTP/1.1 404 Not Found');
        header('Status: 404 Not Found');
        return $this->content;
    }
}