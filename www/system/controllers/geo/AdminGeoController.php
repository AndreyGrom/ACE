<?php

class AdminGeoController extends AdminController {
    public function __construct() {
        parent::__construct();
        $this->id = $this->get['id'];
    }

    public function GetCountries(){
        return $this->db->select("SELECT * FROM agcms_country");
    }

    public function GetRegions($country_id){
        return $this->db->select("SELECT * FROM agcms_regions WHERE COUNTRY_ID = $country_id");
    }
    public function ShowCountries(){
        $this->assign(array(
            'items' => $this->GetCountries()
        ));
        $this->content = $this->SetTemplate('countries.tpl');
    }

    public function ShowRegions(){
        $country =  $this->db->select("SELECT * FROM agcms_country WHERE COUNTRY_ID = " . $this->get['country-id'], array('single_array' => true));
        $this->assign(array(
            'country' => $country,
            'items' => $this->GetRegions($this->get['country-id'])
        ));
        $this->content = $this->SetTemplate('regions.tpl');

    }

    public function ShowCities(){
        $items =  $this->db->select(
            "SELECT ci.*, r.REGION_NAME, c.COUNTRY_NAME FROM agcms_city ci
            LEFT JOIN agcms_regions r ON r.REGION_ID = ci.REGION_ID
            LEFT JOIN agcms_country c ON c.COUNTRY_ID = ci.COUNTRY_ID
            WHERE ci.REGION_ID = " . $this->get['region-id'] . ' GROUP BY ci.CITY_ID',
            array('single_array' => true));
        $this->assign(array(
            'items' => $items
        ));
        $this->assign(array(
            'country_id' => $this->get['a-country-id'],
            'region_id' => $this->get['a-region-id']
        ));
        $this->content = $this->SetTemplate('cities.tpl');
    }

    public function SaveCountry(){
        $params = array(
            'COUNTRY_NAME' => $this->post['name'],
            'S_NAME' => $this->post['s_name'],
            'C_CURRENCY' => $this->post['currency'],
            'C_CURRENCY_N' => $this->post['currency_n'],
            'C_ZN' => $this->post['zn']
        );
        if (isset($this->id)){
            $this->db->update('agcms_country', $params, 'COUNTRY_ID = ' . $this->id);
        } else {
            $params['COUNTRY_ID'] = $this->generateID();

            $this->db->insert('agcms_country', $params);
        }
        $this->Head('?c=geo');
    }

    public function DelCountry(){
        $sql = "DELETE FROM agcms_country WHERE COUNTRY_ID = " . $this->id;
        $this->db->query($sql);
        $sql = "DELETE FROM agcms_regions WHERE COUNTRY_ID = " . $this->id;
        $this->db->query($sql);
        $sql = "DELETE FROM agcms_city WHERE COUNTRY_ID = " . $this->id;
        $this->db->query($sql);
        $this->Head('?c=geo');
    }

    public function ShowCountry(){
        if (isset($this->id)){
            $sql = "SELECT * FROM agcms_country WHERE COUNTRY_ID = " . $this->id;
            $this->assign(array(
                'item' => $this->db->select($sql, array('single_array' => true))
            ));
        }
        $this->content = $this->SetTemplate('country.tpl');
    }

    public function ShowRegion(){
        if (isset($this->id)){
            $sql = "SELECT * FROM agcms_regions WHERE REGION_ID = " . $this->id;
            $this->assign(array(
                'item' => $this->db->select($sql, array('single_array' => true))
            ));
        }
        $this->assign(array(
            'country_id' => $this->get['a-country-id'],
            'region_id' => $this->get['a-region-id']
        ));
        $this->content = $this->SetTemplate('region.tpl');
    }

    public function SaveRegion(){
        $params = array(
            'REGION_NAME' => $this->post['name']
        );
        if (isset($this->id)){
            $this->db->update('agcms_regions', $params, 'REGION_ID = ' . $this->id);
        } else {
            $params['COUNTRY_ID'] = $this->post['country_id'];
            $params['REGION_ID'] = $this->generateID(9);

            $this->db->insert('agcms_regions', $params);
        }
        $this->Head('?c=geo&country-id=' . $this->post['country_id']);
    }


    public function DelRegion(){
        $sql = "DELETE FROM agcms_regions WHERE REGION_ID = " . $this->id;
        $this->db->query($sql);
        $sql = "DELETE FROM agcms_city WHERE REGION_ID = " . $this->id;
        $this->db->query($sql);
        $this->Head('?c=geo&country-id=' . $this->get['a-country-id']);
    }

    public function ShowCity(){
        if (isset($this->id)){
            $sql = "SELECT * FROM agcms_city WHERE CITY_ID = " . $this->id;
            $this->assign(array(
                'item' => $this->db->select($sql, array('single_array' => true))
            ));
        }

        $this->assign(array(
            'country_id' => $this->get['a-country-id'],
            'region_id' => $this->get['a-region-id']
        ));

        $this->content = $this->SetTemplate('city.tpl');
    }

    public function DelCity(){;
        $sql = "DELETE FROM agcms_city WHERE CITY_ID = " . $this->id;
        $this->db->query($sql);
        $this->Head('?c=geo&region-id=' . $this->get['a-region-id'] . '&a-region-id = ' .  $this->get['a-region-id'] . '&a-country-id=' . $this->get['a-country-id']);
    }

    public function SaveCity(){
        $params = array(
            'CITY_NAME' => $this->post['name']
        );
        if (isset($this->id)){
            $this->db->update('agcms_regions', $params, 'CITY_ID = ' . $this->id);
        } else {
            $params['COUNTRY_ID'] = $this->post['country_id'];
            $params['REGION_ID'] = $this->post['region_id'];
            $params['CITY_ID'] = $this->generateID(9);

            $this->db->insert('agcms_city', $params);
        }

        //var_dump($this->get);

        $this->Head('?c=geo&region-id=' . $this->get['a-region-id'] . '&a-country-id=' . $this->get['a-country-id'] . '&a-region-id=' . $this->get['a-region-id']);
    }


    function generateID($length = 7){
        $chars = '123456789987654321121345891648';
        $numChars = strlen($chars);
        $string = '';
        for ($i = 0; $i < $length; $i++) {
            $string .= substr($chars, rand(1, $numChars) - 1, 1);
        }
        return $string;
    }

    public function Index(){
        $this->widget_left_top .=$this->fetch('menu.tpl');

        $this->page_title = 'Города и страны';

        if (isset($this->post['save-country'])){
            $this->SaveCountry();
        }
        if (isset($this->post['save-region'])){
            $this->SaveRegion();
        }
        if (isset($this->post['save-city'])){
            $this->SaveCity();
        }

        if (isset($this->get['country-id'])){
            $this->ShowRegions();
        }
        elseif (isset($this->get['region-id'])){
            $this->ShowCities();
        }
        elseif (isset($this->get['act']) && $this->get['act'] == 'country'){
            $this->ShowCountry();
        }
        elseif (isset($this->get['act']) && $this->get['act'] == 'del-country'){
            $this->DelCountry();
        }
        elseif (isset($this->get['act']) && $this->get['act'] == 'region'){
            $this->ShowRegion();
        }
        elseif (isset($this->get['act']) && $this->get['act'] == 'del-region'){
            $this->DelRegion();
        }
        elseif (isset($this->get['act']) && $this->get['act'] == 'city'){
            $this->ShowCity();
        }
        elseif (isset($this->get['act']) && $this->get['act'] == 'del-city'){
            $this->DelCity();
        }
        else {
            $this->ShowCountries();
        }
        return $this->content;
    }


}
?>