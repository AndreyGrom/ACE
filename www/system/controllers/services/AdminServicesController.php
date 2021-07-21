<?php

class AdminServicesController extends AdminController {
    public function __construct() {
        parent::__construct();
        $this->categories    = array();
        $this->structure     = array();
        $this->id            = $this->get['id'];
        $this->cid           = $this->get['cid'];
        $this->act           = $this->get['act'];
        $this->per_page      = 20;
        $this->start         = 0;
        $this->num_pages     = 1;
    }

    public function SetPlugins(){
/*        $this->js[]   = HTML_PLUGINS_DIR.'cleeditor/jquery.cleditor.min.js';
        $this->js[]   = HTML_PLUGINS_DIR.'cleeditor/jquery.cleditor.rfm.js';
        $this->css[]  = HTML_PLUGINS_DIR.'cleeditor/jquery.cleditor.css';*/
        $this->js[]   = HTML_PLUGINS_DIR.'tinymce/tinymce.min.js';
        $this->js[]   = HTML_PLUGINS_DIR.'fancybox/jquery.fancybox.js';
        $this->js[]   = HTML_PLUGINS_DIR.'fancybox/jquery.fancybox.pack.js';

        $this->js[]   = HTML_PLUGINS_DIR.'ajaxupload.3.5.js';
        $this->css[]  = HTML_PLUGINS_DIR.'fancybox/jquery.fancybox.css';
    }


    public function SaveSettings(){
        foreach ($this->post as $k=>$p){
            if ($k == 'save-settings') continue;
            $this->config->set($k,$p);
        }
        $this->Head("?c=services&act=settings");
    }
    public function SaveCategory(){
        $title            = $this->db->input($this->post['c_title']);
        $desc             = $this->db->input($this->post['c_desc']);
        $desc2            = $this->db->input($this->post['c_desc2']);
        $parent           = $this->db->input($this->post['parent']);
        $alias            = ($this->post['alias']!=='')?$this->post['alias']:$this->func->TranslitURL($title);
        $template         = $this->db->input($this->post['template']);
        $publ             = $this->post['publ'];
        $meta_desc        = $this->db->input($this->post['meta_description']);
        $meta_keywords    = $this->db->input($this->post['meta_keywords']);
        $delete_image     = $this->post['delete_image'];
        $old_image        = $this->post['old_image'];

        $sql = "SELECT * FROM `".db_pref."services_c` WHERE `ALIAS`='$alias'";
        if ($this->act!=='new_c'){
            $sql .= " AND ID <> $this->cid";
        }
        $query = $this->db->query($sql);
        if ($this->db->num_rows($query) == 0){
            $upload_path = UPLOAD_IMAGES_DIR.'services/';
            $image = Func::getInstance()->UploadFile($_FILES["image"]['name'],$_FILES["image"]['tmp_name'], $upload_path);

            $params = array(
                'PARENT'   => 0,
                'TITLE'   => $title,
                'ALIAS'   => $alias,
                'META_DESC'   => $meta_desc,
                'META_KEYWORDS'   => $meta_keywords,

            );

            if ($this->act == 'new_c'){
                $this->db->insert('agcms_services_c', $params);

                $this->cid = $this->db->last_id();
            }else{
                if ($image!=='') {
                    $params['IMAGE'] = $image;

                    if (!is_dir($old_image) && file_exists($old_image)){  // если есть новое изображение, то удаляем прежнее
                        unlink($old_image);
                    }
                }
                if ($delete_image) {
                    $params['IMAGE'] = '';
                    if (file_exists($old_image) && file_exists($old_image)){
                        unlink($old_image);
                    }
                }
                $this->db->update('agcms_services_c', $params, "ID = " . $this->cid);

            }
            $this->Head("?c=services&cid=$this->cid");
        } else {
            $this->session['alert'] = 'Такой алиас уже существует';
        }
    }

    public function SaveItem(){
        $parents = $this->post['parents'];
        if (count($parents)==1){
            $parent = ','.$parents[0].',';
        } else {
            foreach ($parents as $k=>$p){
                if ($k==0) $parent = ',';
                $parent .= $p.',';
            }
        }
        $tags_str = '';
        $tag = trim($this->post['tags']);
        if ($tag!==''){
            $temp = explode(",",$tag);
            foreach ($temp as $t){
                if (trim($t)!==''){
                    $tags[]=trim($t);
                }
            }
            foreach ($tags as $k=>$t){
                if ($k==0)  $tags_str = ',';
                $tags_str .=$t.",";
            }
        }
        $date = time();



        $params = array(
            'TITLE'   => $this->post['title'],
            'TITLE2'   => $this->post['title2'],
            'LEFT_CONTENT'   => $this->post['left_content'],
            'RIGHT_CONTENT'   => $this->post['right_content'],
            'ALIAS'   => ($this->post['alias']!=='')?$this->post['alias']:Func::getInstance()->TranslitURL($title),
            'META_TITLE'   => $this->post['meta_title'],
            'META_DESC'   => $this->post['meta_description'],
            'META_KEYWORDS'   => $this->post['meta_keywords'],
            'TAGS'   => $tags_str,
            'PARENT'   => $parent,
        );


        $upload_path = UPLOAD_IMAGES_DIR.'services/';
        $photo1 = Func::getInstance()->UploadFile($_FILES["photo1"]['name'],$_FILES["photo1"]['tmp_name'], $upload_path);
        if ($photo1 !== false){
            $params['PHOTO1'] = $photo1;
        }
        $photo2 = Func::getInstance()->UploadFile($_FILES["photo2"]['name'],$_FILES["photo2"]['tmp_name'], $upload_path);
        if ($photo2 !== false){
            $params['PHOTO2'] = $photo2;
        }


        if (isset($this->id) && $this->id > 0){
            $this->db->update('agcms_services_i', $params, "ID = " . $this->id);
        } else{
            $this->db->insert('agcms_services_i', $params);
            $this->id = $this->db->last_id();
        }
        $this->Head("?c=services&id=$this->id");

    }

    public function getCategories($parent = false){
        $categories = array();
        $sql = "SELECT * FROM `".db_pref."services_c` ORDER BY `ID`";
        $query = $this->db->query($sql);
        for ($i=0; $i < $this->db->num_rows($query); $i++) {
            $row = $this->db->fetch_array($query);
            $categories[] = $row;
        }
        return $categories;
    }

    public function getPagination2($parent = false){
        $where = '';
        if ($parent){
            $where = "WHERE `PARENT` LIKE '%,$parent,%'";
        }
        $sql = "SELECT * FROM `".db_pref."services_i` $where";
        $query = $this->db->query($sql);
        $total = $this->db->num_rows($query);
        $this->num_pages = ceil($total / $this->per_page);
        $this->total = $total;
        $cur_page = 1;
        if (isset($_GET['p']) && $_GET['p'] > 0) {
            $cur_page = $_GET['p'];
        }
        $this->start = ($cur_page - 1) * $this->per_page;
    }

    public function getItems($parent = false, $start, $count){
        $items = array();
        $where = '';
        if ($count > 0){
            $limit = "LIMIT $start, $count";
        }
        if ($parent){
            $where = "WHERE `PARENT` LIKE '%,$parent,%'";
        }

        $sql = "SELECT * FROM `".db_pref."services_i` $where ORDER BY `ID` DESC $limit";
        $query = $this->db->query($sql);
        for ($i=0; $i < $this->db->num_rows($query); $i++) {
            $row = $this->db->fetch_array($query);
            $row["DATE_PUBL"] = $this->DateFormat($row["DATE_PUBL"]);
            $row["DATE_EDIT"] = $this->DateFormat($row["DATE_EDIT"]);
            $items[] = $row;
        }
        return $items;
    }
    public function getCategory($cid){
        $row = array();
        $sql = "SELECT * FROM `".db_pref."services_c` WHERE `ID`=$cid LIMIT 1";
        $query = $this->db->query($sql);
        if ($this->db->num_rows($query)>0){
            $row = $this->db->fetch_array($query);
            $row['DATE_PUBL'] = $this->DateFormat($row["DATE_PUBL"]);
            $row['DATE_EDIT'] = $this->DateFormat($row["DATE_EDIT"]);
            if ($row['IMAGE']!==''){
                $row['NEW_IMAGE'] = Func::getInstance()->GetImage(UPLOAD_IMAGES_DIR.'services/'.$row['IMAGE'], 50,50,'','services');
            }
        }
        return $row;
    }
    public function getItem($id){
        $sql = "SELECT i.*, c.ID AS CID, c.TITLE AS CAT_NAME, c.ALIAS AS CAT_ALIAS
        FROM `".db_pref."services_i` i
        LEFT JOIN `".db_pref."services_c` c ON i.PARENT=c.ID
        WHERE i.`ID`=$id  LIMIT 1";
        $query = $this->db->query($sql);
        $row = $this->db->fetch_array($query);



        $row['PARENTS'] = explode(",", $row['PARENT']);
        $row['PARENTS'] = array_filter($row['PARENTS']);
        sort($row['PARENTS']);
        $tags = $row['TAGS'];
        if ($tags!==''){
            if (mb_substr($tags, 0, 1)==','){
                $tags = mb_substr($tags,1);
            }
            if (mb_substr($tags,-1)==','){
                $tags = substr($tags,0,-1);
            }
        }
        $row['TAGS'] = $tags;
        $images = array();
        $new_images = array();
        if ($row['IMAGES']!==''){
            $images = explode(",", $row['IMAGES']);
            foreach ($images as $img){
                $new_images[] = $this->func->GetImage(UPLOAD_IMAGES_DIR.'services/'.$img, 100,100,'','services');
            }
        }

        $row['IMAGES'] = $images;
        $row['NEW_IMAGES'] = $new_images;
        $files = array();
        if ($row['FILES']!==''){
            $files = unserialize($row['FILES']);
        }
        $row['FILES'] = $files;

        return $row;
    }
    public function ShowMenu(){
        $this->assign(array(
            'categories' => $this->structure,
        ));
        $menu = $this->fetch('menu2.tpl');
        $this->assign(array(
            'menu' => $menu,
        ));
        $this->widget_left_top .=$this->fetch('menu.tpl');
    }

    public function ShowItems($cid = null){
        $this->getPagination2($cid,$this->start,$this->per_page);
        $items =  $this->getItems($cid,$this->start,$this->per_page);
        $this->assign(array(
            'items'           => $items,

            'category_id'     => $this->cid,
            'num_pages'       => $this->num_pages,
            'items_count'     => count($items),
            'total'           => $this->total,
            'start'           => $this->start+1,
        ));
        $this->content = $this->SetTemplate('items.tpl');
    }


    public function DeleteCategory($id){
        $sql = "SELECT * FROM `".db_pref."services_i` WHERE `PARENT` LIKE '%,$id,%'";
        $query = $this->db->query($sql);
        if ($this->db->num_rows($query) == 0){
            $sql = "DELETE FROM `".db_pref."services_c` WHERE `ID`=$id";
            $query = $this->db->query($sql);
            $this->Head('?c=services');
        } else {
            $_SESSION['alert'] = 'Сначала удалите материалы из этой категории!';
            $this->Head("?c=services&cid=$id");
        }
    }
    public function DeleteItem($id){
        $sql = "SELECT * FROM `".db_pref."services_i` WHERE `ID`=$id LIMIT 1";
        $query = $this->db->query($sql);
        $row = $this->db->fetch_array($query);
        if ($row['IMAGES']!==''){
            $images = explode(",", $row['IMAGES']);
            foreach ($images as $img){
                if (file_exists(UPLOAD_IMAGES_DIR.'services/'.$img)){
                    unlink(UPLOAD_IMAGES_DIR.'services/'.$img);
                }
            }
        }
        $sql = "DELETE FROM `".db_pref."services_i` WHERE `ID`=$id";
        $query = $this->db->query($sql);
    }
    public function ShowCategory($row){
        $this->assign(array(
            'category_id'              => $this->cid,
            'category_title'           => isset($title)    ?   $title    :    $row['TITLE'],
            'category_desc'            => isset($desc)     ?   $desc     :    $row['DESC'],
            'category_desc2'            => isset($desc2)     ?   $desc2     :    $row['DESC2'],
            'category_alias'           => isset($alias)    ?   $alias    :    $row['ALIAS'],
            'category_template'        => isset($template) ?   $template :    $row['TEMPLATE'],
            'category_parent'          => isset($parent)   ?   $parent   :    $row['PARENT'],
            'category_publ'            => isset($publ)     ?   $publ     :    $row['PUBLIC'],
            'category_meta_desc'       => isset($meta_desc)     ?   $meta_desc     :    $row['META_DESC'],
            'category_meta_keywords'   => isset($meta_keywords)     ?   $meta_keywords     :    $row['META_KEYWORDS'],
            'category_new_image'       => $row['NEW_IMAGE'],
            'category_image'           => UPLOAD_IMAGES_DIR.'services/'.$row['IMAGE'],
            'category'                 => $row,
            'categories'               => $this->categories,
            'templates'                => Func::getInstance()->getTemplates($this->templates_dir.'services/list/'),
        ));
        $this->content = $this->SetTemplate('cat.tpl');
    }
    public function ShowItem($row){

        $this->assign(array(
            'item'                     => $row,
        ));
        $this->content = $this->SetTemplate('item.tpl');
    }

    public function ShowNewCat(){
        $this->assign(array(
            'templates'      => $this->func->getTemplates($this->templates_dir.'service/list/'),
            'categories'     => $this->categories,
            'new'            => true,
        ));
        $this->content = $this->SetTemplate('cat.tpl');
    }

    public function ShowList(){
        $sql = 'SELECT * FROM agcms_services_list WHERE SERVICE_ID = ' . $this->id . " ORDER BY SORT ASC";
        $items = $this->db->select($sql);
        $this->assign(array(
            'items'                     => $items,
        ));
        $this->content = $this->SetTemplate('list.tpl');
    }

    public function ShowAddList(){
        $sql = "SELECT * FROM `".db_pref."service_levels_g` ORDER BY `TITLE`";
        $gid = $this->db->select($sql);
        $this->assign(array(
            'countrys'      => $this->GetCountries(),
            'gid'      => $gid,
            'categories'     => $this->categories,
            'new'            => true,
            'visa'           => $this->GetVisas(),
        ));
        if (isset($this->get['aid']) && $this->get['aid'] > 0){
            $sql = "SELECT * FROM `".db_pref."services_list` WHERE ID = " . $this->get['aid'];
            $item = $this->db->select($sql, array('single_array' => true));
            $this->assign(array(
                'item'      => $item,
            ));
        }
        $this->content = $this->SetTemplate('add_list.tpl');
    }

    public function SaveList(){
        $params = array(
            'SERVICE_ID' => $this->id,
            'TYPE' => $this->post['type'],
            'TITLE' => $this->post['title'],
            'DESC' => $this->post['desc'],
            'PRICE' => $this->post['price'],
            'PRICE_NEW' => $this->post['price_new'],
            'COUNTRY_CUR' => $this->post['cur'],
            'NAME' => $this->post['name'],
            'BULLET1' => $this->post['bullet1'],
            'BULLET2' => $this->post['bullet2'],
            'BULLET3' => $this->post['bullet3'],
            'LEVEL_ID' => $this->post['level'],
            'CAPT1' => $this->post['capt1'],
            'CAPT2' => $this->post['capt2'],
            'SORT' => ($this->post['sort'] !=='')?$this->post['sort']:9999,
            'GID' => $this->post['gid'],
        );

        $upload_path = UPLOAD_IMAGES_DIR.'services/';
        $photo1 = Func::getInstance()->UploadFile($_FILES["photo"]['name'],$_FILES["photo"]['tmp_name'], $upload_path);
        if ($photo1 !== false){
            $params['PHOTO'] = $photo1;
        }

        if (isset($this->get['aid']) && $this->get['aid'] > 0){
            $this->db->update('agcms_services_list', $params, "ID = " . $this->get['aid']);
        } else {
            $this->db->insert('agcms_services_list', $params);
        }
        $this->Head('?c=services&act=list&id=' . $this->id);
    }
    public function DelList(){
        $sql = "DELETE FROM agcms_services_list WHERE ID = " . $this->get['aid'];
        $this->db->query($sql);
        $this->Head('?c=services&act=list&id=' . $this->id);
    }


    public function GetLevelsG(){
        $sql = "SELECT * FROM `agcms_service_levels_g`";
        return $this->db->select($sql);
    }
    public function ShowLevelsG(){
        $this->assign(array(
            'items'           => $this->GetLevelsG(),
        ));
        $this->content = $this->SetTemplate('levels-g.tpl');
    }
    public function ShowLevelG(){
        if (isset($this->id)){
            $sql = "SELECT * FROM agcms_service_levels_g WHERE ID = " . $this->id;
            $item = $this->db->select($sql, array('single_array' => true));
            $this->assign(array(
                'item' => $item
            ));
        }
        $this->content = $this->SetTemplate('level-g.tpl');
    }
    public function SaveLevelG(){
        $params = array(
            'TITLE' => $this->post['title'],
        );
        if (isset($this->id)){
            $this->db->update('agcms_service_levels_g', $params, 'ID = ' . $this->id);
        } else{
            $this->db->insert('agcms_service_levels_g', $params);
        }

        $this->Head('?c=services&act=levels-g');
    }
    public function DelLevelG(){
        $this->db->query('DELETE FROM agcms_service_levels_g WHERE ID = ' . $this->id);
        $this->Head('?c=services&act=levels-g');
    }
    public function GetLevels($gid){
        $sql = "SELECT * FROM `agcms_service_levels` WHERE GID = $gid";
        return $this->db->select($sql);
    }
    public function ShowLevels(){
        $this->assign(array(
            'items'           => $this->GetLevels($this->get['gid']),
        ));
        $this->content = $this->SetTemplate('levels.tpl');
    }

    public function ShowLevel(){
        if (isset($this->id)){
            $sql = "SELECT * FROM agcms_service_levels WHERE ID = " . $this->id;
            $item = $this->db->select($sql, array('single_array' => true));
            $this->assign(array(
                'item' => $item
            ));
        }
        $this->content = $this->SetTemplate('level.tpl');
    }

    public function SaveLevel(){
        $params = array(
            'TITLE' => $this->post['title'],
            'PRICE' => $this->post['price'],
            'PRICE_NEW' => $this->post['price_new'],
            'GID' => $this->get['gid'],
        );
        if (isset($this->id)){
            $this->db->update('agcms_service_levels', $params, 'ID = ' . $this->id);
        } else{
            $this->db->insert('agcms_service_levels', $params);
        }

        $this->Head('?c=services&act=levels&gid=' . $this->get['gid']);
    }

    public function DelLevel(){
        $this->db->query('DELETE FROM agcms_service_levels WHERE ID = ' . $this->id);
        $this->Head('?c=services&act=levels');
    }

    public function GetVisas(){
        $sql = "SELECT * FROM `agcms_service_visa`";
        return $this->db->select($sql);
    }



    public function ShowVisas(){
        $this->assign(array(
            'items'           => $this->GetCountries(),
        ));
        $this->content = $this->SetTemplate('visas.tpl');
    }

    public function ShowVisa(){
        $sql = "SELECT * FROM agcms_service_visa WHERE COUNTRY_ID = " . $this->get['cid'];
        $this->assign(array(
            'country'         => $this->GetCountry($this->get['cid']),
            'items'           => $this->db->select($sql),
        ));
        $this->content = $this->SetTemplate('visa-list.tpl');
    }

    public function ShowVisaAdd(){
        if (isset($this->get['vid'])){
            $sql = "SELECT * FROM agcms_service_visa WHERE ID = " . $this->get['vid'];
            $this->assign(array(
                'item'         => $this->db->select($sql, array('single_array' => true)),
            ));
        }
        $this->assign(array(
            'country'         => $this->GetCountry($this->get['cid']),
        ));
        $this->content = $this->SetTemplate('visa.tpl');
    }

    public function SaveVisa(){
        $params = array(
            'TYPE' => $this->post['type'],
            'PRICE' => $this->post['price'],
            'PRICE_NEW' => $this->post['price_new'],
            'COUNTRY_ID' => $this->get['cid'],
        );
        if (isset($this->get['vid'])){
            $this->db->update('agcms_service_visa', $params, 'ID = ' . $this->get['vid']);
        } else{
            $this->db->insert('agcms_service_visa', $params);
        }

        $this->Head('?c=services&act=visa&cid=' . $this->get['cid']);
    }

    public function DelVisa(){
        $this->db->query('DELETE FROM agcms_service_visa WHERE ID = ' . $this->get['vid']);
        $this->Head('?c=services&act=visa&cid=' . $this->get['cid']);
    }

    public function GetCountries(){
        $sql = "SELECT * FROM `".db_pref."country` ORDER BY `COUNTRY_NAME`";
        return $this->db->select($sql);
    }
    public function GetCountry($id){
        $sql = "SELECT * FROM `".db_pref."country` WHERE COUNTRY_ID = $id LIMIT 1";
        return $this->db->select($sql, array('single_array' => true));
    }

    public function ShowRews(){
        $sql = 'SELECT * FROM agcms_services_rews WHERE SERVICE_ID = ' . $this->id;
        $items = $this->db->select($sql);
        $this->assign(array(
            'items'                     => $items,
        ));
        $this->content = $this->SetTemplate('rews.tpl');
    }
    public function DelRews(){
        $sql = "DELETE FROM agcms_services_rews WHERE ID = " . $this->get['aid'];
        $this->db->query($sql);
        $this->Head('?c=services&act=rews&id=' . $this->id);
    }
    public function ShowAddRew(){
        $this->assign(array(
            'new'            => true,
        ));
        if (isset($this->get['aid']) && $this->get['aid'] > 0){
            $sql = "SELECT * FROM `".db_pref."services_rews` WHERE ID = " . $this->get['aid'];
            $item = $this->db->select($sql, array('single_array' => true));
            $this->assign(array(
                'item'      => $item,
            ));
        }
        $this->content = $this->SetTemplate('add_rew.tpl');
    }
    public function SaveRew(){
        $params = array(
            'SERVICE_ID' => $this->id,
            'TITLE' => $this->post['title'],
            'REW' => $this->post['rew'],
            'RFROM' => $this->post['rfrom'],

        );

        $upload_path = UPLOAD_IMAGES_DIR.'services/';
        $photo1 = Func::getInstance()->UploadFile($_FILES["photo"]['name'],$_FILES["photo"]['tmp_name'], $upload_path);
        if ($photo1 !== false){
            $params['PHOTO'] = $photo1;
        }

        if (isset($this->get['aid']) && $this->get['aid'] > 0){
            $this->db->update('agcms_services_rews', $params, "ID = " . $this->get['aid']);
        } else {
            $this->db->insert('agcms_services_rews', $params);
        }
        $this->Head('?c=services&act=rews&id=' . $this->id);
    }

    public function Index(){

        $this->SetPlugins();
        $this->page_title = 'Каталог';

        if (isset($this->post['c_title']) && trim($this->post['c_title'])!==''){
            $this->SaveCategory();
        }

        if (isset($this->post['save-item'])){
            $this->SaveItem();
        }

        if (isset($this->post['save-settings'])){
            $this->SaveSettings();
        }
        if (isset($this->post['save-level-g'])){
            $this->SaveLevelG();
        }
        if (isset($this->post['save-level'])){
            $this->SaveLevel();
        }
        if (isset($this->post['save-visa'])){
            $this->SaveVisa();
        }
        if (isset($this->post['save-list'])){
            $this->SaveList();
        }
        if (isset($this->post['save-rew'])){
            $this->SaveRew();
        }

        $this->categories = $this->getCategories();
        if(count($this->categories) == 0 && !isset($this->act)){
            $this->head('?c=services&act=new_c');
        }
        $this->structure = Func::getInstance()->getStructure($this->categories);
        $this->ShowMenu();


        if (!isset($this->act) && isset($this->cid) && !isset($this->id)){
            $this->ShowItems($this->cid);
        }
        elseif ($this->act == 'new_c'){
            $this->ShowNewCat();
        }
        elseif ($this->act == 'list'){
            $this->ShowList();
        }
        elseif ($this->act == 'del-list'){
            $this->DelList();
        }
        elseif ($this->act == 'add'){
            $this->ShowAddList();
        }
        elseif ($this->act == 'levels-g'){
            $this->ShowLevelsG();
        }
        elseif ($this->act == 'level-g'){
            $this->ShowLevelG();
        }
        elseif ($this->act == 'del-level-g'){
            $this->DelLevelG();
        }
        elseif ($this->act == 'levels'){
            $this->ShowLevels();
        }
        elseif ($this->act == 'level'){
            $this->ShowLevel();
        }
        elseif ($this->act == 'del-level'){
            $this->DelLevel();
        }
        elseif ($this->act == 'visas'){
            $this->ShowVisas();
        }
        elseif ($this->act == 'visa'){
            $this->ShowVisa();
        }
        elseif ($this->act == 'visa-add'){
            $this->ShowVisaAdd();
        }
        elseif ($this->act == 'visa-del'){
            $this->DelVisa();
        }
        elseif ($this->act == 'rews'){
            $this->ShowRews();
        }
        elseif ($this->act == 'del-rews'){
            $this->DelRews();
        }
        elseif ($this->act == 'rew'){
            $this->ShowAddRew();
        }
        elseif ($this->act == 'edit' && isset($this->cid) && $this->cid!==''){
            $row = $this->getCategory($this->cid);
            $this->ShowCategory($row);
        }
        elseif (isset($this->id)){
            $row = $this->getItem($this->id);
            $this->ShowItem($row);
        }
        else {
            $this->ShowItems();
        }
        return $this->content;
    }




}
?>