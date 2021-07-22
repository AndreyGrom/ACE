<?php
$act = $this->get['act'];
$this->smarty->template_dir = dirname( __FILE__  ).'/';
$tpl = $this->get['c'].'.tpl';
$id = $this->get['id'];
$cid = $this->get['cid'];
$this->page_title = 'Настройки сайта';

    if (count($this->post)>0){
        foreach ($this->post as $k=>$p){
            Config::getInstance()->set($k,$p);
        }
        $this->Head("?c=settings");
    }

    $this->content = $this->fetch('settings.tpl');


$this->assign(array(
    'menu' => $menu,
));

$this->widget_left_top .=$this->fetch('menu.tpl');

?>