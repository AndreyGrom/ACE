<?php

class Controller {
    public function __construct($query, $controller) {
        $this->script_start_time = Manager::getInstance()->script_start_time;
        $this->login = false;
        $this->user = array();
        $this->post = $_POST;
        if (isset($_SESSION['user'])){
            $this->login = true;
            $this->user = $_SESSION['user'];
            if ($this->user['AVATAR']){
                $upload_dir    = UPLOAD_IMAGES_DIR.'users/avatars/'.$this->user['ID'].'/';
                $this->user['AVATAR_SRC'] = Func::getInstance()->GetImage($upload_dir.$this->user['AVATAR'],110,110,'w','users/avatars');
            }
            unset($_SESSION['user']);
        }

        $this->get = array();
        $this->query = $query;
        $this->redirect = '';
        $this->redir = '';
        $this->ParseQuery();
        $this->controller = $controller;
        $this->db = Database::getInstance();
        $this->config = Config::getInstance();
        $this->theme = $this->config->Theme;
        $this->theme_dir = TEMPLATES_DIR . $this->config->Theme .'/';
        $this->templates_dir = TEMPLATES_DIR . $this->config->Theme . '/tpl/';
        $this->smarty = Smart::getInstance();
        $this->meta_title = '';
        $this->meta_description = '';
        $this->meta_keywords = '';
        $this->meta_image = '';
        $this->content = '';
        $this->js = array();
        $this->css = array();
        //if (filesize(dirname(__FILE__).'/M'.'an'.'ag'.'e'.'r'.'.c'.'l'.'a' . 's'.'s.ph'.'p')>7000) exit;
        $this->page_title = '';
        $this->breadcrumbs = array();

    }

    function ParseQuery(){
        $arr = array();
        $s = array();
        if (count($this->query) > 0){
            foreach($this->query as $q){
                $s = explode('=',$q);
                if (count($s) > 1){
                    $arr[$s[0]] = $s[1];
                } else {
                    $arr[$s[0]] = '';
                }
            }
        }
        $this->get = $arr;
        if (isset($this->get['redirect'])){
            $this->redir = $this->get['redirect'];
            $this->redirect = str_replace('-','/',$this->get['redirect']);
        }
    }
    public function GetAliasFromQuery(){
        $result = '';
        if (count($this->query) > 0){
            foreach($this->query as $q){
                if (strpos($q,'=')===false){
                    $result = $q;
                    break;
                }
            }
        }
        return $result;
    }
    public function assign($arr){
        $this->smarty->assign($arr);
    }

    public function display($temp=''){
        $this->smarty->display($temp);
    }

    public function fetch($temp=''){
        return $this->smarty->fetch($temp);
    }

    public function SetPath($path){
        $this->smarty->template_dir = $this->templates_dir . $path;
    }
    public function getCats($parent = false){
        $sql = "SELECT * FROM `".db_pref."catalog_c` ORDER BY `ID`";
        $categories = $this->db->select($sql, false);
        return $categories;
    }
    public function AssingCommonVars(){
        if ($this->meta_title == ''){
            $this->meta_title = $this->config->SiteTitle;
        }

        if ($this->meta_description==''){
            $this->meta_description = $this->config->DefaultMetaDesc;
        }
        if ($this->meta_keywords==''){
            $this->meta_keywords = $this->config->DefaultMetaKeywords;
        }
        $this->smarty->assign(array(
            'meta_title'                 => $this->meta_title,
            'meta_description'           => $this->meta_description,
            'meta_keywords'              => $this->meta_keywords,
            'meta_image'                 => $this->meta_image,
            'site_name'                  => $this->config->SiteTitle,
            'site_description'           => $this->config->SiteDescription,
            'site_director'              => $this->config->SiteDirector,
            'site_theme'                 => $this->config->Theme,
            'module_default'             => $this->config->ModuleDefault,
            'site_country'               => $this->config->SiteCountry,
            'site_country_id'            => $this->config->SiteCountryID,
            'site_address'               => $this->config->SiteAddress,
            'site_geocode'               => $this->config->SiteGeocode,
            'site_email'                 => $this->config->SiteEmail,
            'site_phone'                 => $this->config->SitePhone,
            'site_skype'                 => $this->config->SiteSkype,
            'site_icq'                   => $this->config->SiteIcq,
            'module_name'                => $this->controller,
            'site_url'                   => 'http://'.$_SERVER['SERVER_NAME'].'/',
            'self_url'                   => 'http://'.$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'],
            'template_dir'               => '/'.$this->templates_dir,
            'theme_dir'                  => HTML_THEMES_DIR . $this->config->Theme.'/',
            'config'                     => $this->config,
            'js'                         => $this->getJs(),
            'css'                        => $this->getCss(),
            'login'                      => $this->login,
            'user'                       => $this->user,
            'redirect'                   => $this->redirect,
            'redir'                      => $this->redir,
            'breadcrumbs'                => count($this->breadcrumbs) > 0 ? $this->breadcrumbs : false,
            'qurey_count'                => $this->db->query_count,
            'script_time'                => sprintf("%.4F сек.", microtime(true) - $this->script_start_time),
            'upload_images_dir'          => '/'.UPLOAD_IMAGES_DIR,
            'cache_images'               => '/'.CACHE_IMAGES,
            'html_upload_images_dir'     => HTML_UPLOAD_IMAGES_DIR,
            'html_cache_images'          => HTML_CACHE_IMAGES,
            'html_plugins_dir'           => HTML_PLUGINS_DIR,
            'html_controllers_dir'       => HTML_CONTROLLERS_DIR,
            'html_classes_dir'           => HTML_CLASSES_DIR,


        ));
    }
    public function SetTemplate($tpl){
        if ($this->config->SiteEnabled == 0 && !isset($_SESSION['admin'])){
            $result = $this->SetSystemPage('Сайт временно отключен', $this->config->SiteDisabledMessage);
        } else{
            $this->AssingCommonVars();

            $result = $this->smarty->fetch($tpl);

            $result = str_replace('</head>', $this->getCss()."\r\n</head>",$result);
            $result = str_replace('</body>', $this->getJs()."\r\n</body>",$result);
        }

        if (is_dir(CONTROLLERS_DIR)){
            $list = scandir(CONTROLLERS_DIR);
            foreach ($list as $l){
                $file_func = CONTROLLERS_DIR.$l.'/after_fn.php';
                if (file_exists($file_func)){
                    include_once($file_func);
                }
            }
        }

        return $result;
    }
    public function SetSystemPage($title, $message){
        $this->assign(array(
            'title'       => $title,
            'message'       => $message,
        ));
        $this->smarty->template_dir = CONTROLLERS_DIR;
        return $result = $this->smarty->fetch('system.tpl');
    }
    public function SetTitle($title){
        $this->assign(array(
            'site_title'       => $title.' - '. $this->config->SiteTitle,
        ));
    }
    public function SetDescription($description){
        $this->smarty->assign(array(
            'meta_description'           => $description,
        ));
    }

    public function SetKeyWords($keywords){
        $this->smarty->assign(array(
            'meta_keywords'           => $keywords,
        ));
    }

    public function getJs(){
        $r = '';
        if (count($this->js) > 0){
            foreach ($this->js as $val){
                if (trim($val)!==''){
                    $r .= '<script type="text/javascript" src="'.$val.'"></script>'."\r\n";
                }
            }
        }
        return $r;
    }
    public function SetJS($js){
        $b = true;
        if (count($this->js) > 0){
            foreach ($this->js as  $j){
                if (trim($js) == $j)  {
                    $b = false;
                    break;
                }
            }
        }
        if ($b){
            $this->js[] = $js;
            $this->assign(array(
                'js'  => $this->js,
            ));
        }
    }
    public function getCss(){
        $r = '';
        if (count($this->css) > 0){
            foreach ($this->css as $val){
                if (trim($val)!==''){
                    $r .= ' <link rel="stylesheet" href="'.$val.'">'."\r\n";
                }
            }
        }
        return $r;
    }

    public function DateFormat($date){
        return date("d.m.Y G:i:s", $date);
    }
    public function DateFormatForum($date){
        return date("d.m.Y, в G:i:s", $date);
    }
    public function Head($url, $anch=''){
        if ($anch!==''){
            $url.='#'.$anch;
        }
        header("Location: ".$url);
        exit;
    }

    function getPagination($params){
        function str_replace_once($search, $replace, $text)
        {
            $pos = strpos($text, $search);
            return $pos!==false ? substr_replace($text, $replace, $pos, strlen($search)) : $text;
        }
        $pagin = '';
        $per_page = isset($params['per_page'])?$params['per_page']:10;
        $link_count = isset($params['link_count'])?$params['link_count']:3;
        $sql = $params['sql'];
        $current_page = $params['current_page'];
        $link = $params['link'];
        $get_name = isset($params['get_name'])?$params['get_name']:'page';

        $cur_page = 1;
        if (isset($current_page) && $current_page > 0) {
            $cur_page = $current_page;
        }
        $start = ($cur_page - 1) * $per_page;
        $sql = $sql." LIMIT $start,$per_page";
        $sql = str_replace_once('SELECT','SELECT SQL_CALC_FOUND_ROWS ', $sql);
        $table = isset($params['table']) ? $params['table'] : 'paginations';
        $query = $this->db->select($sql, array('total_rows' => true, 'table' => $table));
        $total_rows = $query['total_rows'];

        $num_pages = ceil($total_rows / $per_page);
        if ($num_pages > 1) {
            $pagin = '<ul class="pagination">';
            if ($num_pages > $link_count ){
                if ($cur_page == 1){
                    $pagin .= '<li class="disabled"><a href="#">«</a></li>';
                } else {
                    $pagin .= '<li><a href="'.$link.$get_name.'=1">«</a></li>';
                }
            }
            if ($num_pages < $link_count*2){
                for($i=1;$i<=$num_pages; $i++) {
                    if ($i == $cur_page) {
                        $pagin .= '<li class="active"><a href="'.$link.$get_name.'=' . $i . '">' . $i . "</a></li>";
                    } else {
                        $pagin .= '<li><a href="'.$link.$get_name.'=' . $i . '">' . $i . "</a></li>";
                    }
                }
            }
            elseif($cur_page > $link_count && $cur_page < ($num_pages-$link_count)){
                for($i=$cur_page-$link_count; $i<=$cur_page+$link_count; $i++) {
                    if ($i == $cur_page) {
                        $pagin .= '<li class="active"><a href="'.$link.$get_name.'=' . $i . '">' . $i . "</a></li>";
                    } else {
                        $pagin .= '<li><a href="'.$link.$get_name.'=' . $i . '">' . $i . "</a></li>";
                    }
                }
            }
            elseif($cur_page<=$link_count){
                $iSlice = 1+$link_count-$cur_page;
                for($i=1; $i<=$cur_page+($link_count+$iSlice); $i++){
                    if ($i == $cur_page) {
                        $pagin .= '<li class="active"><a href="'.$link.$get_name.'=' . $i . '">' . $i . "</a></li>";
                    } else {
                        $pagin .= '<li><a href="'.$link.$get_name.'=' . $i . '">' . $i . "</a></li>";
                    }
                }
            }
            else{
                $iSlice = $link_count-($num_pages - $cur_page);
                for($i=$cur_page-($link_count+$iSlice); $i<=$num_pages; $i++){
                    if ($i == $cur_page) {
                        $pagin .= '<li class="active"><a href="'.$link.$get_name.'=' . $i . '">' . $i . "</a></li>";
                    } else {
                        $pagin .= '<li><a href="'.$link.$get_name.'=' . $i . '">' . $i . "</a></li>";
                    }
                }
            }
            if ($cur_page == $num_pages){
                $pagin .= '<li class="disabled"><a href="#">»</a></li>';
            } else {
                $pagin .= '<li><a href="'.$link.$get_name.'='.$num_pages.'">»</a></li>';
            }
            $pagin .= '</ul>';
        }

        $result = array(
            'query' => $query,
            'num_pages' => $num_pages,
            'items' => $query['items'],
            'pagination' => $pagin,
        );
        return $result;
    }
    function generateName($length = 20){
        $chars = 'abdefhiknrstyzABDEFGHKNQRSTYZ23456789';
        $numChars = strlen($chars);
        $string = '';
        for ($i = 0; $i < $length; $i++) {
            $string .= substr($chars, rand(1, $numChars) - 1, 1);
        }
        return $string;
    }
    function mail_sender_plain($to, $subject, $content, $attach=false)
    {
        $__smtp = array(
            "smtp" => false,
/*            "host" => "ssl://smtp.yandex.ru",
            "auth" => true,
            "port" => 465,
            "username" => "",
            "fromname" => "",
            "password" => "",*/
        );
        require_once(CLASSES_DIR.'phpmailer/class.phpmailer.php');
        $mail = new PHPMailer(true);

        if ($__smtp['smtp']){
            $mail->IsSMTP();
        }

        try {
            /*          $mail->Host       = $__smtp['host'];
                        $mail->SMTPDebug  = 0;
                        $mail->SMTPAuth   = $__smtp['auth'];
                        $mail->Port       = $__smtp['port'];
                        $mail->Username   = $__smtp['username'];
                        $mail->Password   = $__smtp['password'];*/
            $mail->CharSet    = 'UTF-8';
            /*$mail->AddReplyTo($mail->Username, $mail->Username);*/
            $mail->AddAddress($to);
            /*$mail->SetFrom($mail->Username, $__smtp['fromname']);*/
            /* $mail->AddReplyTo($mail->Username, $mail->Username);*/
            $mail->Subject = htmlspecialchars($subject);
            $mail->isHTML(true);
            $mail->Body = $content;
            if($attach)  $mail->AddAttachment($attach);
            $mail->Send();
            return true;
        } catch (phpmailerException $e) {
            return false;
        } catch (Exception $e) {
            return false;
        }
    }
    function SetMail($params){
        $this->SetPath('mail/');
        $tpl = $params['tpl'];
        $email = $params['email'];
        $subject = $params['subject'];
        $this->assign($params);
        $body = $this->fetch($tpl);
        $this->mail_sender_plain($email,$subject,$body,false);
        return true;

    }

    public function LoadModel ($model){
        $file = MODELS_DIR . $model .'.php';
        $model = mb_convert_case($model, MB_CASE_TITLE, "UTF-8");
        if (file_exists($file) && !is_dir($file)){
            include_once ($file);
            $class_name = 'Model'. $model;
            $method_name = 'Model' . $model;
            $this->$method_name = new $class_name();
        }
    }

}