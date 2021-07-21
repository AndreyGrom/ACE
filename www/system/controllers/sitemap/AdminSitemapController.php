<?php

class AdminSitemapController extends AdminController {
    public function __construct() {
        parent::__construct();
        $this->act = $this->get['act'];
    }

    public function SaveSettings(){
        foreach ($this->post as $k=>$p){
            if ($k == 'save-settings') continue;
            $this->config->set($k,$p);
        }
        $this->Head("?c=catalog&act=settings");
    }

    public function ShowMenu(){
        $menu = $this->fetch('menu.tpl');
        $this->widget_left_top .=$this->fetch('menu.tpl');
    }

    public function GenerateSiteMap(){
        $list = array();
        foreach ($this->modules as $m){
            if (file_exists(CONTROLLERS_DIR.$m['alias'].'/'.$m['admin_class_name'].'.php')){
                include_once(CONTROLLERS_DIR.$m['alias'].'/'.$m['admin_class_name'].'.php');
                if (class_exists($m['admin_class_name'])){
                    $class = new $m['admin_class_name']();
                    if (method_exists($class, 'getSiteMap')){
                        $list = array_merge($list ,$class->getSiteMap());

                    }
                }
            }
        }
        $sitemapXML='<?xml version="1.0" encoding="UTF-8"?>
            <urlset xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd" xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">'."\r\n";
        $sitemapTXT = null;

        foreach($list as $l){
            $loc = trim($l['loc']);
            $changefreq = trim($l['changefreq']);
            $lastmod = trim($l['lastmod']);
            $priority = trim($l['priority']);
            $sitemapXML .= "<url>\r\n<loc>".$loc."</loc>\r\n";
            if (isset($changefreq)){
                $sitemapXML .= "<changefreq>".$changefreq."</changefreq>\r\n";
            }
            if (isset($priority)){
                $sitemapXML .= "<priority>".$priority."</priority>\r\n";
            }
            $sitemapXML .= "</url>";
            $sitemapTXT.="$loc\r\n";
        }
        $sitemapXML.="\r\n</urlset>";


        //Некоторые символы, а также кириллица - должны быть в правильной кодировке/виде (по спецификации)
        $sitemapXML=trim(strtr($sitemapXML,array('%2F'=>'/','%3A'=>':','%3F'=>'?','%3D'=>'=','%26'=>'&','%27'=>"'",'%22'=>'"','%3E'=>'>','%3C'=>'<','%23'=>'#','&'=>'&')));
        $sitemapTXT=trim(strtr($sitemapTXT,array('%2F'=>'/','%3A'=>':','%3F'=>'?','%3D'=>'=','%26'=>'&','%27'=>"'",'%22'=>'"','%3E'=>'>','%3C'=>'<','%23'=>'#','&'=>'&')));


        file_put_contents('sitemap.xml', $sitemapXML);
        file_put_contents('sitemap.txt', $sitemapTXT);
        $file2 = array();
        if (file_exists('robots.txt')){
            $file = file('robots.txt');
            foreach ($file as &$f){
                if (strpos(trim($f), 'Sitemap') === false){
                    $file2[] = trim($f) . "\r\n";
                }
            }
        }
        $file2[] = 'Sitemap: ' . $this->site_url . 'sitemap.xml';
        file_put_contents('robots.txt', $file2);

        $this->Head('?c=sitemap');
    }

    public function Index(){
        $this->page_title = 'Карта сайта';

        if (isset($this->post['save-settings'])){
            $this->SaveSettings();
        }

        $this->ShowMenu();

        if ($this->act == 'generate-site-map'){
            $this->GenerateSiteMap();
        } else {
            if (file_exists('sitemap.xml')){
                $time = date ("F d Y H:i:s.", filemtime('sitemap.xml'));
                $xml = new SimpleXMLElement('sitemap.xml', null, true);
                $link_count = $xml->url->count();
                $this->assign(array(
                    'lastmod' => $time,
                    'link_count' => $link_count,
                    'xml_exists' => file_exists('sitemap.xml'),
                    'txt_exists' => file_exists('sitemap.txt'),
                    'robots_exists' => file_exists('robots.txt'),
                ));
            }
            $this->content = $this->SetTemplate('index.tpl');
        }



        return $this->content;
    }

}
?>