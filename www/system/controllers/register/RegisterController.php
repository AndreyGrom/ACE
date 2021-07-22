<?php

class RegisterController extends Controller {
    public function __construct($query, $controller) {
        parent::__construct($query, $controller);
        $this->error = '';
        $this->tags = "<a><b><p><img><br>";
    }

    public function SaveUser(){

/*        $id = $this->user['ID'];
        $sql = "SELECT FROM `agcms_users` WHERE ID=$id LIMIT 1";
        $query = $this->db->query($sql);
        $user = $this->db->fetch_array($query);*/
        $password = ($this->post['password'] !== '') ? md5($this->db->input($_POST['password'])) : $this->user['PASSWORD'];


        $id = $this->user['ID'];
        $first_name = isset($this->post['first_name']) ? strip_tags($this->db->input($_POST['first_name'])) : $this->user['FIRST_NAME'];
        $last_name = isset($this->post['last_name']) ? strip_tags($this->db->input($_POST['last_name'])) : $this->user['LAST_NAME'];
        $father_name = isset($this->post['father_name']) ? strip_tags($this->db->input($_POST['father_name'])) : $this->user['FATHER_NAME'];
        /*$nick = isset($this->post['nick']) ? strip_tags($this->db->input($_POST['nick'])) : $this->user['NICK'];*/
        $email = isset($this->post['email']) ? strip_tags($this->db->input($_POST['email'])) : $this->user['EMAIL'];

        $phone = isset($this->post['phone']) ? strip_tags($this->db->input($_POST['phone'])) : $this->user['PHONE'];
        $icq = isset($_POST['icq']) ? strip_tags($this->db->input($_POST['icq'])) : $this->user['ICQ'];
        $site = isset($_POST['site']) ? strip_tags($this->db->input($_POST['site'])) : $this->user['SITE'];
        $birthday = isset($_POST['birthday']) ? strip_tags($this->db->input($_POST['birthday'])) : $this->user['BIRTHDAY'];
        $country = isset($_POST['country']) ? strip_tags($this->db->input($_POST['country'])) : $this->user['COUNTRY'];
        $region = isset($_POST['region']) ? strip_tags($this->db->input($_POST['region'])) : $this->user['REGION'];
        $city = isset($_POST['city']) ? strip_tags($this->db->input($_POST['city'])) : $this->user['CITY'];
        $wmr = isset($_POST['wmr']) ? strip_tags($this->db->input($_POST['wmr'])) : $this->user['WMR'];
        $wmz = isset($_POST['wmz']) ? strip_tags($this->db->input($_POST['wmz'])) : $this->user['WMZ'];
        $yamoney = isset($_POST['yamoney']) ? strip_tags($this->db->input($_POST['yamoney'])) : $this->user['YAMONEY'];
        $qiwi = isset($_POST['qiwi']) ? strip_tags($this->db->input($_POST['qiwi'])) : $this->user['QIWI'];
        $card = isset($_POST['card']) ? strip_tags($this->db->input($_POST['card'])) : $this->user['CARD'];
        $signature = isset($_POST['signature']) ? strip_tags($this->db->input($_POST['signature']),$this->tags) : $this->user['SIGNATURE'];

        $sql = "UPDATE `agcms_users` SET
        `FIRST_NAME`='$first_name',
        `LAST_NAME`='$last_name',
        `FATHER_NAME`='$father_name',
        `EMAIL`='$email',
        `PASSWORD`='$password',
        `PHONE`='$phone',
        `COUNTRY`='$country',
        `REGION`='$region',
        `CITY`='$city'
         WHERE `ID`=$id";
        $query = $this->db->query($sql);
        //var_dump($this->db->error());
        $this->Head("/register/profile");
    }

    public function RegisterUser(){
        if (isset($_POST['register'])){
            if($_SESSION['register'] !== $_POST['captcha']){
                $this->error = 'Неверно введен код с картинки!';
            }
            unset($_SESSION['register']);

            if ($this->error == ''){
                $first_name = isset($_POST['first_name']) ? $this->db->input($_POST['first_name']) : '';
                $email = isset($_POST['email']) ? $this->db->input($_POST['email']) : '';
                $password = isset($_POST['password']) ? md5($_POST['password']) : '';
                $ip = $_SERVER['REMOTE_ADDR'];
                $hash = $this->generateName(30);
                $date = time();
                $sql = "SELECT * FROM `agcms_users` WHERE `EMAIL`='$email' AND STATUS = 1";
                $query = $this->db->query($sql);
                if ($this->db->num_rows($query) > 0){
                    $this->error = 'Email "<b>'.$email.'</b>" уже зарегистрирован в системе!';
                }

                if ($this->error == ''){
                    $params = array(
                        'EMAIL'   => $email,
                        'PASSWORD'   => $password,
                        'HASH'   => $hash,
                        'DATE_CREATE'   => $date,
                        'REG_IP'   => $ip,
                     );
                    $this->db->insert('agcms_users', $params);
                    $valid_url = "http://крейф.рф/register/validate/hash=" . $hash;

                    $params = array(
                        "email" => $email,
                        "subject" => 'Подтверждение регистрации на сайте '.$this->config->SiteTitle,
                        "tpl" => 'registration_validate.tpl',
                        "valid_url" => $valid_url,
                        "site_name" => $this->config->SiteTitle,
                        "site_email" => $this->config->SiteEmail,
                        "site_phone" => $this->config->SitePhone,
                        "site_url" => 'http://'.$_SERVER['SERVER_NAME'].'/',
                        "user_name" => $first_name,
                        "user_email" => $email,
                        "user_password" => $password,
                    );
                    $this->SetMail($params);

                    /*$query = $this->db->query($sql);
                    $id = $this->db->last_id();
                    setcookie('hash',$hash,time()+3600*24*30*6,'/');
                    setcookie('user_id',$id,time()+3600*24*30*6,'/');
                    $params = array(
                        "email" => $email,
                        "subject" => 'Регистрация на сайте '.$this->config->SiteTitle,
                        "tpl" => 'registration.tpl',
                        "site_name" => $this->config->SiteTitle,
                        "site_email" => $this->config->SiteEmail,
                        "site_phone" => $this->config->SitePhone,
                        "site_url" => 'http://'.$_SERVER['SERVER_NAME'].'/',
                        "user_name" => $first_name,
                        "user_email" => $email,
                        "user_password" => $password,
                    );
                    $this->SetMail($params);*/

                    if ($this->redirect!==''){
                        $this->Head('/'.$this->redirect);
                    } else {

                        $this->Head('/register/success2');
                    }
                }
            }
        }
    }

    public function RegisterUser2(){
        if (isset($_POST['register2'])){


                $first_name = isset($_POST['first_name']) ? $this->db->input($_POST['first_name']) : '';
                $email = isset($_POST['email']) ? $this->db->input($_POST['email']) : '';
                $phone = isset($_POST['phone']) ? $this->db->input($_POST['phone']) : '';
                $password = $this->generateName(6);
                $ip = $_SERVER['REMOTE_ADDR'];
                $hash = $this->generateName(30);
                $date = time();
                $sql = "SELECT * FROM `agcms_users` WHERE `EMAIL`='$email' AND STATUS = 1";
                $query = $this->db->query($sql);
                if ($this->db->num_rows($query) > 0){
                    $this->error = 'Email "<b>'.$email.'</b>" уже зарегистрирован в системе!';
                }

                if ($this->error == ''){

                    $params = array(
                        'FIRST_NAME'   => $first_name,
                        'PHONE'   => $phone,
                        'EMAIL'   => $email,
                        'PASSWORD'   => md5($password),
                        'HASH'   => $hash,
                        'DATE_CREATE'   => $date,
                        'REG_IP'   => $ip,
                    );
                    $this->db->insert('agcms_users', $params);
                    $valid_url = "http://крейф.рф/register/validate/hash=" . $hash;

                    $params = array(
                        "email" => $email,
                        "subject" => 'Подтверждение регистрации на сайте '.$this->config->SiteTitle,
                        "tpl" => 'registration_validate.tpl',
                        "valid_url" => $valid_url,
                        "site_name" => $this->config->SiteTitle,
                        "site_email" => $this->config->SiteEmail,
                        "site_phone" => $this->config->SitePhone,
                        "site_url" => 'http://'.$_SERVER['SERVER_NAME'].'/',
                        "user_name" => $first_name,
                        "user_email" => $email,
                        "user_password" => $password,
                    );
                    $this->SetMail($params);

                    if ($this->redirect!==''){
                        $this->Head('/'.$this->redirect);
                    } else {

                        $this->Head('/register/success2');
                    }
                } else {
                    $this->Head('/login');
                }
            }
        }



    public function ShowFormRegistry(){
        if ($this->login){
            $this->Head('/');
        }
        $this->page_title = 'Регистрация аккаунта';
        $this->meta_title = $this->page_title .' -'. $this->config->SiteTitle;

        $this->breadcrumbs = array(
            array('text' => 'Главная', 'href' => '/'),
            array('text' => 'Регистрация аккаунта', 'href' => ''),
        );
        $this->assign(array(
            'rand' => rand(1111111,9999999),
            'error' => $this->error,
            'page_title' => $this->page_title,
        ));
        $this->SetPath('register/register');
        $this->content =$this->SetTemplate('default.tpl');
    }

    public function ShowEditProfile(){
        if ($this->login){
            $this->page_title = 'Мой профиль';
            $this->assign(array(
                'user' => $this->user,
            ));
            $this->SetPath('register/profile');
            $this->content =$this->SetTemplate('edit.tpl');
        } else {
            $this->Head('/login');
        }
    }

    public function validate(){
        $hash = $this->get['hash'];
        $sql = "SELECT * FROM agcms_users WHERE HASH = '$hash' AND STATUS = 0 LIMIT 1";
        $query = $this->db->select($sql);

        if (count($query) > 0){
            $sql = "UPDATE agcms_users SET STATUS = 1";
            $this->db->query($sql);
            setcookie('hash',$hash,time()+3600*24*30*6,'/');
            setcookie('user_id',$query[0]['ID'],time()+3600*24*30*6,'/');
            $params = array(
                "email" => $query[0]['EMAIL'],
                "subject" => 'Регистрация на сайте '.$this->config->SiteTitle,
                "tpl" => 'registration.tpl',
                "site_name" => $this->config->SiteTitle,
                "site_email" => $this->config->SiteEmail,
                "site_phone" => $this->config->SitePhone,
                "site_url" => 'http://'.$_SERVER['SERVER_NAME'].'/',
                "user_email" => $query[0]['EMAIL'],
                "user_password" => $query[0]['PASSWORD'],
            );
            $this->SetMail($params);

            $params = array(
                "email" => $this->config->SiteEmail,
                "subject" => 'Новый пользователь на сайте '.$this->config->SiteTitle,
                "tpl" => 'registration_new.tpl',
                "id"  =>$query[0]['ID'],
                "site_name" => $this->config->SiteTitle,
                "site_email" => $this->config->SiteEmail,
                "site_phone" => $this->config->SitePhone,
                "site_url" => 'http://'.$_SERVER['SERVER_NAME'].'/',
                "user_email" => $query[0]['EMAIL'],
                "user_password" => $query[0]['PASSWORD'],
            );
            $this->SetMail($params);
            $this->Head('/register/profile');
        } else{
            $this->assign(array(
                'message' => 'Неверная или устаревшая ссылка'
            ));
            $this->SetPath('register/register');
            $this->content =$this->SetTemplate('success.tpl');
        }
    }



    public function ShowProfile(){
        if ($this->login){
            $this->page_title = 'Мой профиль';
            $this->assign(array(
                'user' => $this->user,
            ));
            $this->SetPath('register/profile');
            $this->content =$this->SetTemplate('default.tpl');
        } else {
            $this->Head('/login');
        }
    }

    public function ShowOrders(){
        if ($this->login){
            $this->page_title = 'Мои заказы';
            $sql = "SELECT * FROM agcms_orders WHERE USER_ID = " .$this->user['ID'];
            if ($orders = $this->db->select($sql));
            foreach ($orders as &$o){
                $o['DATE_START'] = $this->DateFormat($o['DATE_START']);
                $o['CONT'] = json_decode($o['CONT']);
            }
            $this->assign(array(
                'orders' => $orders,
            ));

            $this->SetPath('register/profile');
            $this->content = $this->SetTemplate('orders.tpl');

        } else {
            $this->Head( $this->content);
        }
    }
    public function GetOrder($id){
        $sql = "SELECT * FROM agcms_orders WHERE ID = $id ";
        $rs = $this->db->select($sql, array('single_array' => true));
        if ($rs){
            $rs['DATE_START'] = $this->DateFormat($rs['DATE_START']);
        }

        return $rs;
    }
    public function GetCart(){
        $order = $this->GetOrder($this->get['order']);
        $cart = json_decode($order['CONT']);

        $ids = array();
        $c_list = array();
        $p_list = array();
        $p_list2 = array();
        $d_list = array();
        $total = 0;
        if (count($cart->list) > 0){
            foreach ($cart->list as $sh){
                $ids[] = $sh->id;
                if (count($sh->c_list) > 0){
                    foreach ($sh->c_list as $c){
                        $c_list[] = $c->id;
                    }
                }
                if (count($sh->p_list) > 0){
                    foreach ($sh->p_list as $p){
                        $p_list[] = $p->id;
                        $p_list2[] = $p;
                    }
                }
                if (count($sh->d_list) > 0){
                    foreach ($sh->d_list as $d){
                        $d_list[] = $d;
                    }
                }
                $total += $sh->total;
            }
        }
        $sql = "SELECT c.*, co.COUNTRY_NAME, ci.CITY_NAME, i.PHOTO1, i.TITLE AS SH_TITLE FROM agcms_catalog_courses c
        LEFT JOIN agcms_catalog_i i ON i.ID = c.SH_ID
        LEFT JOIN agcms_country co ON co.COUNTRY_ID = i.COUNTRY_ID
        LEFT JOIN agcms_city ci ON ci.CITY_ID = i.CITY_ID
        WHERE c.ID IN (". implode(', ', $c_list) .")";
        $c_list = $this->db->select($sql);

        $sql = "SELECT p.*, co.COUNTRY_NAME, ci.CITY_NAME, i.TITLE AS SH_TITLE FROM agcms_catalog_prozhiv p
        LEFT JOIN agcms_catalog_i i ON i.ID = p.SH_ID
        LEFT JOIN agcms_country co ON co.COUNTRY_ID = i.COUNTRY_ID
        LEFT JOIN agcms_city ci ON ci.CITY_ID = i.CITY_ID
        WHERE p.ID IN (". implode(', ', $p_list) .")";
        $p_list = $this->db->select($sql);
        $cart = array(

            'c_list' => $c_list,
            'p_list' => $p_list,
            'p_list2' => $p_list2,
            'd_list' => $d_list,
            'total' => $total,
            'order' => $order,
        );



        return $cart;
    }
    public function ShowOrder(){
        $cart = $this->GetCart();
        $this->assign(array(
            'order' => $cart['order'],
            'c_list' => $cart['c_list'],
            'p_list' => $cart['p_list'],
            'p_list2' => $cart['p_list2'],
            'd_list' => $cart['d_list'],
            'total' => $cart['total'],
        ));
        $this->SetPath('register/profile');
        $this->content = $this->SetTemplate('order.tpl');;
    }

    public function DeleteOrder(){
        $sql = "DELETE FROM agcms_orders WHERE STATUS = 0 AND ID = " . $this->get['delete-order'] . " AND USER_ID = " . $this->user['ID'];
        $this->db->query($sql);
        $this->Head("/register/orders");
    }

    public function ShowRestore(){
        $this->SetPath('register');
        if (isset($this->get['success'])){
            $this->content =$this->SetTemplate('restore3.tpl');
        }
        else if(isset($this->get['ver'])){
            $this->content =$this->SetTemplate('restore1.tpl');
        }
        else if(isset($this->get['hash'])){
            $this->content =$this->SetTemplate('restore2.tpl');
        }
        else{
            $this->content =$this->SetTemplate('restore.tpl');
        }
    }

    public function Restore1(){
        $sql = "SELECT * FROM agcms_users WHERE EMAIL = '" . $this->post['email'] . "'";
        if ($user = $this->db->select($sql, array('single_array'=> true))){
            $url = 'http://'.$_SERVER['SERVER_NAME'].'/register/restore/hash=' . $user['HASH'];
            $params = array(
                "email" => $this->post['email'],
                "subject" => 'Востановление пароля на сайте '.$this->config->SiteTitle,
                "tpl" => 'restore.tpl',
                "url" => $url,
                "site_name" => $this->config->SiteTitle,
                "site_email" => $this->config->SiteEmail,
                "site_phone" => $this->config->SitePhone,
                "site_url" => 'http://'.$_SERVER['SERVER_NAME'].'/',
            );
            $this->SetMail($params);
            //$this->SetPath('register');
            $this->Head("/register/restore/ver");

        } else{
            $this->assign(array(
                'error' => true,
            ));
        }
    }
    public function Restore2(){
        $pas = md5($this->post['pass']);
        $sql = "UPDATE agcms_users SET PASSWORD = '$pas' WHERE HASH = '" . $this->get['hash'] . "'";
        $this->db->query($sql);

        $this->SetPath('register');
        $this->Head("/register/restore/success");
    }

    public function SwowSuccess(){
        $this->assign(array(
            'message' => 'На ваш e-mail отправлено письмо с подтверждением',
        ));
        $this->SetPath('/register/register');
        $this->content =$this->SetTemplate('success.tpl');
    }

    public function Index(){
        if (isset($this->post['save-user'])){
            $this->SaveUser();
        }
        if (isset($_POST['register'])){
            $this->RegisterUser();
        }
        if (isset($_POST['register2'])){
            $this->RegisterUser2();
        }
        if (isset($_POST['restore'])){
            $this->Restore1();
        }
        if (isset($_POST['save_password'])){
            $this->Restore2();
        }

        if (isset($this->get['edit'])){
            $this->ShowEditProfile();
        }
        elseif (isset($this->get['orders'])){
            $this->ShowOrders();
        }
        elseif (isset($this->get['order'])){
            $this->ShowOrder();
        }
        elseif (isset($this->get['delete-order'])){
            $this->DeleteOrder();
        }
        elseif (isset($this->get['profile'])){
            $this->ShowProfile();
        }
        elseif (isset($this->get['success2'])){
            $this->SwowSuccess();
        }
        elseif (isset($this->get['restore'])){
            $this->ShowRestore();
        }
        elseif(isset($this->get['validate'])){
            $this->validate();
        }

        else {
            $this->ShowFormRegistry();
        }

        return $this->content;
    }
}