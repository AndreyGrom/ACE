<?php

class AdminSettingsController extends AdminController {
    public function __construct() {
        parent::__construct();
    }



    public function Index(){
        $this->widget_left_top .=$this->fetch('menu.tpl');
        $this->page_title = 'Настройки сайта';

        if (count($this->post)>0){
            foreach ($this->post as $k=>$p){
                Config::getInstance()->set($k,$p);
            }
            $this->Head("?c=settings");
        }

        $sql = "SELECT * FROM `agcms_country` ORDER BY `COUNTRY_NAME`";
        $query = $this->db->query($sql);
        for ($i=0; $i < $this->db->num_rows($query); $i++) {
            $row = $this->db->fetch_array($query);
            $row["DATE_PUBL"] = $this->DateFormat($row["DATE_PUBL"]);
            $row["DATE_EDIT"] = $this->DateFormat($row["DATE_EDIT"]);
            $countrys[] = $row;
        }

        if ($this->config->SiteCountryID){
            $country_id = $this->config->SiteCountryID;
            $sql = "SELECT * FROM `agcms_regions` WHERE `COUNTRY_ID`= $country_id  ORDER BY `REGION_NAME`";
            $query = $this->db->query($sql);
            for ($i=0; $i < $this->db->num_rows($query); $i++) {
                $row = $this->db->fetch_array($query);
                $row["DATE_PUBL"] = $this->DateFormat($row["DATE_PUBL"]);
                $row["DATE_EDIT"] = $this->DateFormat($row["DATE_EDIT"]);
                $regions[] = $row;
            }
        }
        if ($this->config->SiteRegionID){
            $region_id = $this->config->SiteRegionID;
            $sql = "SELECT * FROM `agcms_city` WHERE `REGION_ID`= $region_id  ORDER BY `CITY_NAME`";
            $query = $this->db->query($sql);
            for ($i=0; $i < $this->db->num_rows($query); $i++) {
                $row = $this->db->fetch_array($query);
                $row["DATE_PUBL"] = $this->DateFormat($row["DATE_PUBL"]);
                $row["DATE_EDIT"] = $this->DateFormat($row["DATE_EDIT"]);
                $city[] = $row;
            }
        }
        $this->assign(array(
            'countrys' => $countrys,
            'regions' => $regions,
            'city' => $city,
        ));
        $this->content = $this->SetTemplate('settings.tpl');
        return $this->content;
    }
}
?>