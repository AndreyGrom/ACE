<?php

class AdminRegisterController extends AdminController {
    public function __construct() {
        parent::__construct();
        $this->id            = $this->get['id'];
        $this->act           = $this->get['act'];
        $this->act2          = $this->get['act2'];
    }
    public function GetUsers(){
        $sql = "SELECT * FROM `agcms_users`";
        $query = $this->db->query($sql);
        for ($i=0; $i < $this->db->num_rows($query); $i++) {
            $row = $this->db->fetch_array($query);
            $row["DATE_CREATE"] = $this->DateFormat($row["DATE_CREATE"]);
            $row["DATE_ACTIVE"] = $this->DateFormat($row["DATE_ACTIVE"]);
            $users[] = $row;
        }
        return $users;
    }
    public function GetUser($id){
        $sql = "SELECT * FROM `agcms_users` WHERE `ID`=$id LIMIT 1";
        $query = $this->db->query($sql);
        if ($this->db->num_rows($query) > 0) {
            $row = $this->db->fetch_array($query);
            $row["DATE_CREATE"] = $this->DateFormat($row["DATE_CREATE"]);
            $row["DATE_ACTIVE"] = $this->DateFormat($row["DATE_ACTIVE"]);
            $user = $row;
        }
        return $user;
    }
    public function ShowUsers(){
        $sql = "SELECT * FROM `agcms_users`";
        $params = array(
            'sql' => $sql,
            'per_page' => 20,
            'current_page' => $this->get['page'],
            'link' => '?c=register',
            'get_name' => 'page',
        );
        $result = $this->getPagination($params);
        $query = $result['query'];
        $num_pages = $result['num_pages'];
        $pagination = $result['pagination'];
        $total = $result['total'];
        $start = $result['start'];
        for ($i=0; $i < $this->db->num_rows($query); $i++) {
            $row = $this->db->fetch_array($query);
            $row["DATE_CREATE"] = $this->DateFormat($row["DATE_CREATE"]);
            $row["DATE_ACTIVE"] = $this->DateFormat($row["DATE_ACTIVE"]);
            $users[] = $row;
        }

        $this->assign(array(
            'users'           => $users,
            'num_pages'       => $num_pages,
            'items_count'     => count($users),
            'total'           => $total,
            'start'           => $start,
            'pagination'      => $pagination,
        ));
        $this->content = $this->SetTemplate('users.tpl');
    }
    public function ShowUser(){
        $groups = $this->GetGroups();
        $this->assign(array(
            'groups'           => $groups,
        ));
        $user = $this->GetUser($this->id);
        $this->assign(array(
            'user'           => $user,
        ));
        $this->content = $this->SetTemplate('user.tpl');
    }
    public function SaveUser(){
        $id = $this->id;
        $group_id = $this->post['group_id'];
        $first_name = isset($this->post['first_name']) ? $this->db->input($_POST['first_name']) : '';
        $last_name = isset($this->post['last_name']) ? $this->db->input($_POST['last_name']) : '';
        $father_name = isset($this->post['father_name']) ? $this->db->input($_POST['father_name']) : '';
        $nick = isset($this->post['nick']) ? $this->db->input($_POST['nick']) : '';
        $email = isset($this->post['email']) ? $this->db->input($_POST['email']) : '';
        $password = isset($this->post['password']) ? $this->db->input($_POST['password']) : '';
        $phone = isset($this->post['phone']) ? $this->db->input($_POST['phone']) : '';
        $skype = isset($_POST['skype']) ? $this->db->input($_POST['skype']) : '';
        $icq = isset($_POST['icq']) ? $this->db->input($_POST['icq']) : '';
        $site = isset($_POST['site']) ? $this->db->input($_POST['site']) : '';
        $birthday = isset($_POST['birthday']) ? $this->db->input($_POST['birthday']) : '';
        $country = isset($_POST['country']) ? $this->db->input($_POST['country']) : '';
        $region = isset($_POST['region']) ? $this->db->input($_POST['region']) : '';
        $city = isset($_POST['city']) ? $this->db->input($_POST['city']) : '';
        $wmr = isset($_POST['wmr']) ? $this->db->input($_POST['wmr']) : '';
        $wmz = isset($_POST['wmz']) ? $this->db->input($_POST['wmz']) : '';
        $yamoney = isset($_POST['yamoney']) ? $this->db->input($_POST['yamoney']) : '';
        $qiwi = isset($_POST['qiwi']) ? $this->db->input($_POST['qiwi']) : '';
        $card = isset($_POST['card']) ? $this->db->input($_POST['card']) : '';
        $signature = isset($_POST['signature']) ? $this->db->input($_POST['signature']) : '';

        $sql = "UPDATE `agcms_users` SET
        `GROUP_ID`='$group_id',
        `FIRST_NAME`='$first_name',
        `LAST_NAME`='$last_name',
        `FATHER_NAME`='$father_name',
        `NICK`='$nick',
        `EMAIL`='$email',
        `PASSWORD`='$password',
        `PHONE`='$phone',
        `SKYPE`='$skype',
        `ICQ`='$icq',
        `SITE`='$site',
        `BIRTHDAY`='$birthday',
        `COUNTRY`='$country',
        `REGION`='$region',
        `CITY`='$city',
        `WMR`='$wmr',
        `WMZ`='$wmz',
        `YAMONEY`='$yamoney',
        `QIWI`='$qiwi',
        `CARD`='$card',
        `SIGNATURE`='$signature'
         WHERE `ID`=$id";
        $query = $this->db->query($sql);
        $this->Head("?c=register");
    }
    public function DeleteUser(){
        $id = $this->id;
        $sql = "DELETE FROM `agcms_users` WHERE `ID`=$id";
        $query = $this->db->query($sql);
        $this->Head("?c=register");
    }
    public function ShowSettings(){
        $this->content = $this->SetTemplate('settings.tpl');
    }
    public function SaveSettings(){
        foreach ($this->post as $k=>$p){
            if ($k == 'save-settings') continue;
            $this->config->set($k,$p);
        }
        $this->Head("?c=register&act=settings");
    }
    public function GetGroups(){
        $result = false;
        $sql = "SELECT *,@id:=GROUP_ID, (SELECT COUNT(*) FROM `agcms_users` WHERE GROUP_ID=@id) AS CNT FROM `agcms_users_group`";
        $query = $this->db->query($sql);
        if ($query){
            $result = $this->db->fetch_all($query);
        }
        return $result;
    }
    public function GetGroup($id){
        $result = false;
        $sql = "SELECT * FROM `agcms_users_group` WHERE GROUP_ID = $id LIMIT 1";
        $query = $this->db->query($sql);
        if ($query){
            $result = $this->db->fetch_array($query);
        }
        return $result;
    }
    public function ShowGroups(){
        $groups = $this->GetGroups();
        $this->assign(array(
            'groups'           => $groups,
        ));
        $this->content = $this->SetTemplate('groups.tpl');
    }
    public function ShowGroup(){
        $link = HTML_CONTROLLERS_DIR.'register/res/img/';
        $list = scandir($link);
        $icons = array();
        if (isset($this->id)){
            $group = $this->GetGroup($this->id);
        }
        foreach ($list as $v){
            if ($v == '.' || $v == '..') continue;
            $icons[] = '/'.$link.$v;
        }
        $this->assign(array(
            'icons'           => $icons,
            'group'           => $group,
        ));
        $this->content = $this->SetTemplate('group.tpl');
    }
    public function SaveGroup(){
        $name = $this->post['GROUP_NAME'];
        $icon = $this->post['GROUP_ICON'];
        if ($this->id == 0){
            $sql = "INSERT INTO `agcms_users_group`
            (GROUP_NAME,GROUP_ICON) VALUES
            ('$name','$icon')";
        } else {
            $sql = "UPDATE `agcms_users_group` SET
            GROUP_NAME = '$name',
            GROUP_ICON = '$icon'
            WHERE GROUP_ID = $this->id";
        }
        $this->db->query($sql);
        $this->Head("?c=register&act=groups");
    }
    public function Index(){
        $this->page_title = 'Пользователи';
        $this->widget_left_top .=$this->fetch('menu.tpl');
        if (isset($this->post['first_name'])){
            $this->SaveUser();
        }
        if (isset($this->post['GROUP_NAME'])){
            $this->SaveGroup();
        }
        if (isset($this->post['save-settings'])){
            $this->SaveSettings();
        }
        if ($this->act == 'settings'){
            $this->ShowSettings();
        }
        elseif ($this->act == 'groups'){
            if ($this->act2 == 'add'){
                $this->ShowGroup();
            }
            elseif (isset($this->id)){
                $this->ShowGroup();
            } else {
                $this->ShowGroups();
            }
        }
        elseif ($this->act == 'del'){
            $this->DeleteUser();
        }
        elseif (isset($this->id)){
            $this->ShowUser();
        } else {
            $this->ShowUsers();
        }
        return $this->content;
    }
}