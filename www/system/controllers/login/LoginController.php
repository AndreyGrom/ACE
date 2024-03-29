<?php

class LoginController extends Controller {
    public function __construct($query, $controller) {
        parent::__construct($query, $controller);
        $this->error = '';
    }
    public function Index(){
        if (count($this->query) > 0 && $this->query[0] == 'out'){
            setcookie('hash','',time()+3600*24*30*6,'/');
            setcookie('user_id','',time()+3600*24*30*6,'/');
            unset($_SESSION['user']);
            $this->Head('/login/');
        }
        if (isset($this->get['redirect'])){
            $this->redirect = str_replace('-','/',$this->get['redirect']);
        }

        if ($this->login){
            if ($this->redirect!==''){
                $this->Head('/'.$this->redirect);
            } else {
                if (isset($this->get['u'])){
                    $this->Head('/catalog/pay');
                } else{
                    $this->Head('/register/profile');
                }
            }
        }
        if (isset($_POST['email'])){
            $email = $_POST['email'];
            $password = md5($_POST['password']);
            $sql = "SELECT * FROM `agcms_users` WHERE `EMAIL`='$email' AND `PASSWORD`='$password' AND STATUS > 0 LIMIT 1";
            $query = $this->db->query($sql);

            if ($this->db->num_rows($query) > 0){
                $row = $this->db->fetch_array($query);
                setcookie('hash',$row['HASH'],time()+3600*24*30*6,'/');
                setcookie('user_id',$row['ID'],time()+3600*24*30*6,'/');

                if ($this->redirect!==''){
                    $this->Head('/'.$this->redirect);
                } else {
                    if (isset($this->get['u'])){
                        $this->Head('/catalog/pay');
                    } else{
                        $this->Head('/register/profile');
                    }
                }
            } else{
                $this->error = 'Неправильная пара "Логин-пароль"!';
            }
        }
        $this->page_title = 'Вход в аккаунт';
        $this->assign(array(
            'error' => $this->error,
            'redirect' => $this->redir,
        ));
        $this->SetPath('login/');
        $this->content =$this->SetTemplate('login.tpl');
        return $this->content;
    }
}
?>