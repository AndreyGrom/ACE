<?php

class CommentsController extends Controller {
    public function __construct($query, $controller) {
        parent::__construct($query, $controller);
        $this->tpl_view = 'default.tpl';
        $this->tpl_form = 'default.tpl';
        $this->material_id = 0;
        $this->premoderation = true;
        $this->captcha = true;
        $this->error = '';
    }
    public function Index(){
        if (isset($_POST['comment'])){
            if($this->captcha && $_SESSION['comment'] !== $_POST['captcha']){
                $this->error = 'Неверно введен код с картинки!';
            }
            if ($_POST["username"] !== '' || $_POST["useremail"] !== ''){
                $this->error = 'Ваши действия похожи на робота. Комментарий не добавлен';
            }
            unset($_SESSION['register']);
            if ($this->error == ''){
                $strip_tags = '<a><b><i><u><p><h1><h2><h3><h4><h5><h6><ul><li><div>';
                $date_publ = time();
                $user_name = $this->db->input(strip_tags($_POST["name"]));
                $user_email = $this->db->input(strip_tags($_POST["email"]));
                $user_comment = $this->db->input(strip_tags($_POST["comment"],$strip_tags));
                $parent = $_POST["comment-parent"];
                $ip = $_SERVER["REMOTE_ADDR"];
                $status = !$this->premoderation;
                $sql = "INSERT INTO `".db_pref."comments` (`CONTROLLER`,`MATERIAL_ID`,`DATE_PUBL`,`USER_NAME`,`USER_EMAIL`,`USER_COMMENT`,`PARENT`,`IP`,`STATUS`)
                VALUES ('$this->controller','$this->material_id','$date_publ','$user_name','$user_email','$user_comment','$parent','$ip','$status')";
                $query = $this->db->query($sql);
                $id = $this->db->last_id();

                if ($this->premoderation){
                    $_SESSION['comments_message'] = 'Ваш комментарий отправлен на проверку';
                }
                if ($this->premoderation){
                    $this->Head( $_SERVER['HTTP_REFERER']."#comments-form");
                } else {
                    $this->Head( $_SERVER['HTTP_REFERER']."#comment-$id");
                }

            } else {
                /*$this->Head($_SERVER['HTTP_REFERER']."#comments-form");*/
            }
        }
        $comments = array();
        if ($this->material_id > 0){
            $sql = "SELECT * FROM `".db_pref."comments` WHERE `CONTROLLER` = '$this->controller' AND `MATERIAL_ID` = '$this->material_id' AND `STATUS` = '1' ORDER BY `DATE_PUBL` DESC";
            $query = $this->db->query($sql);
            if ($this->db->num_rows($query) > 0){
                for ($i=0; $i < $this->db->num_rows($query); $i++) {
                    $row = $this->db->fetch_array($query);
                    $row["DATE_PUBL"] = $this->DateFormat($row["DATE_PUBL"]);
                    $comments[] = $row;
                }
            }
        }

        $this->js[]   = HTML_PLUGINS_DIR.'cleeditor/jquery.cleditor.min.js';
        $this->js[]   = HTML_PLUGINS_DIR.'cleeditor/jquery.cleditor.rfm.js';
        $this->css[]  = HTML_PLUGINS_DIR.'cleeditor/jquery.cleditor.css';
        $this->SetPath('comments/');
        $this->AssingCommonVars();
        $this->SetPath('comments/form/');
        $comments_system_message = '';
        if (isset($_SESSION['comments_message'])){
            $comments_system_message = $_SESSION['comments_message'];
            unset($_SESSION['comments_message']);
        }
        $this->smarty->assign(array(
            'error_comment' =>  $this->error,
            'captcha' =>  $this->captcha,
            'comments_system_message' =>  $comments_system_message
        ));
        $comments_form = $this->fetch($this->tpl_form);

        $structure = Func::getInstance()->getStructure($comments);

        $this->smarty->assign(array(
            'comments'  => $structure,
            'tpl_name'  => $this->tpl_view,
        ));
        $this->SetPath('comments/view/');
        $comments = $this->fetch($this->tpl_view);

        $this->comments_form = $comments_form;
        $this->comments = $comments;
    }
}