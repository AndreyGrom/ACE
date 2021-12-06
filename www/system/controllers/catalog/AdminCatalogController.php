<?php

class AdminCatalogController extends AdminController {
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
        $this->js[]   = HTML_CONTROLLERS_DIR.'catalog/action.js';
        $this->js[]   = HTML_PLUGINS_DIR.'ajaxupload.3.5.js';
        $this->css[]  = HTML_PLUGINS_DIR.'fancybox/jquery.fancybox.css';
    }

    public function SaveFields(){
        foreach ($this->post as $k=>$p){
            if ($k == 'save-fields') continue;
            $this->config->set($k,$p);
        }
        $this->Head("?c=catalog&act=fields");
    }
    public function SaveSettings(){
        foreach ($this->post as $k=>$p){
            if ($k == 'save-settings') continue;
            $this->config->set($k,$p);
        }
        $this->Head("?c=catalog&act=settings");
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

        $sql = "SELECT * FROM `agcms_catalog_c` WHERE `ALIAS`='$alias'";
        if ($this->act!=='new_c'){
            $sql .= " AND ID <> $this->cid";
        }
        $query = $this->db->query($sql);
        if ($this->db->num_rows($query) == 0){
            $upload_path = UPLOAD_IMAGES_DIR.'catalog/';
            $image = Func::getInstance()->UploadFile($_FILES["image"]['name'],$_FILES["image"]['tmp_name'], $upload_path);

            if ($this->act == 'new_c'){
                $sql = "
                    INSERT INTO `agcms_catalog_c` (
                    `PARENT`,`TITLE`, `DESC`, `DESC2`, `ALIAS`, `META_DESC`,`META_KEYWORDS`, `PUBLIC`,`TEMPLATE`, `POSITION`, `IMAGE`)
                    VALUES
                    ('$parent','$title','$desc','$desc2', '$alias','$meta_desc','$meta_keywords','$publ','$template','99999','$image')";
                $query = $this->db->query($sql);
                $this->cid = $this->db->last_id();
            }else{
                if ($image!=='') {
                    $img_upd = ", `IMAGE` = '$image'";
                    if (!is_dir($old_image) && file_exists($old_image)){  // если есть новое изображение, то удаляем прежнее
                        unlink($old_image);
                    }
                }
                if ($delete_image) {
                    $img_upd = ", `IMAGE` = ''";
                    if (file_exists($old_image) && file_exists($old_image)){
                        unlink($old_image);
                    }
                }
                $sql = "UPDATE `agcms_catalog_c` SET
                `PARENT` = '$parent',
                `TITLE` = '$title',
                `DESC` = '$desc',
                `DESC2` = '$desc2',
                `ALIAS` = '$alias',
                `META_DESC` = '$meta_desc',
                `META_KEYWORDS` = '$meta_keywords',
                `PUBLIC` = '$publ',
                `TEMPLATE` = '$template'
                 $img_upd
                 WHERE `ID` = $this->cid";
                $query = $this->db->query($sql);
            }
            $this->Head("?c=catalog&cid=$this->cid");
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

        $top_n = array();
        if (count($this->post['top_n_t']) > 0){
            foreach($this->post['top_n_t'] as $k => $b){
                if ($this->post['top_n_t'][$k] !== '' && $this->post['top_n_p'][$k] !== ''){
                    $top_n[] = array($this->post['top_n_t'][$k], $this->post['top_n_p'][$k]);
                }

            }
        }
        $top_n = serialize($top_n);

        $upload_path = UPLOAD_FILES_DIR.'catalog/';
        $pdf = Func::getInstance()->UploadFile($_FILES["pdf"]['name'],$_FILES["pdf"]['tmp_name'], $upload_path);

        $dops = array();
        foreach($this->post['dop_id'] as $k => $d){
            $dops[] =  array($d, $this->post['dop_price_' . $d]);
        }

        $from_aeros = array();
        foreach($this->post['from-aeros'] as $from){
            $from_aeros[] = array('id' => $from, 'price' => $this->post["from-aeros_" . $from]);
        }
        $to_aeros = array();
        foreach($this->post['to-aeros'] as $from){
            $to_aeros[] = array('id' => $from, 'price' => $this->post["to-aeros_" . $from]);
        }
        $params = array(
            'NET_ID'     => $this->post['net_id'],
            'COUNTRY_ID'     => $this->post['country_id'],
            'REGION_ID'     => $this->post['region_id'],
            'CITY_ID'   => $this->post['city_id'],
            'ADDRESS'   => $this->post['address'],
            'VOZ'   => $this->post['voz'],
            'S_VOZ'   => $this->post['s_voz'],
            'COUNT_G'   => $this->post['count_g'],
            'S_COUNT_G'   => $this->post['s_count_g'],
            'TOP_N'   => $top_n,
            'P_25'   => $this->post['p_25'],
            'P_M'   => $this->post['p_m'],
            'P_TOP'   => $this->post['p_top'],
            'TITLE'   => $this->post['title'],
            'SHORT_CONTENT'   => $this->post['short_content'],
            'ALIAS'   => ($this->post['alias']!=='')?$this->post['alias']:Func::getInstance()->TranslitURL($title),
            'TEMPLATE'   => $this->post['template'],
            'META_TITLE'   => $this->post['meta_title'],
            'META_DESC'   => $this->post['meta_description'],
            'META_KEYWORDS'   => $this->post['meta_keywords'],
            'FILE1'   => $this->post['file1'],
            'FILE1_NAME'   => $this->post['file1_name'],
            'TAGS'   => $tags_str,
            'PARENT'   => $parent,
            'DATE_PUBL'   => $date,
            'DATE_EDIT'   => $date,
            'PUBLIC'   => 1,
            'DATE1'   => $this->post['date1'],
            'DATE2'   => $this->post['date2'],
            'PDF'   => $pdf,
            'DOPS'   => serialize($dops),
            'RATING'   => $this->post['rating'],
            'FROM_AERO'   => serialize($from_aeros),
            'TO_AERO'   => serialize($to_aeros),
        );


        $upload_path = UPLOAD_IMAGES_DIR.'catalog/';
        $photo1 = Func::getInstance()->UploadFile($_FILES["photo1"]['name'],$_FILES["photo1"]['tmp_name'], $upload_path);
        if ($photo1 !== false){
            $params['PHOTO1'] = $photo1;
        }
        $photo2 = Func::getInstance()->UploadFile($_FILES["photo2"]['name'],$_FILES["photo2"]['tmp_name'], $upload_path);
        if ($photo2 !== false){
            $params['PHOTO2'] = $photo2;
        }


        if (isset($this->id) && $this->id > 0){
            $this->db->update('agcms_catalog_i', $params, "ID = " . $this->id);
        } else{
            $this->db->insert('agcms_catalog_i', $params);
            $this->id = $this->db->last_id();
        }
        $this->Head("?c=catalog&id=$this->id");

    }

    public function getCategories($parent = false){
        $categories = array();
        $sql = "SELECT * FROM `agcms_catalog_c` ORDER BY `ID`";
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
        $sql = "SELECT * FROM `agcms_catalog_i` $where";
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

        $sql = "SELECT * FROM `agcms_catalog_i` $where ORDER BY `ID` DESC $limit";
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
        $sql = "SELECT * FROM `agcms_catalog_c` WHERE `ID`=$cid LIMIT 1";
        $query = $this->db->query($sql);
        if ($this->db->num_rows($query)>0){
            $row = $this->db->fetch_array($query);
            $row['DATE_PUBL'] = $this->DateFormat($row["DATE_PUBL"]);
            $row['DATE_EDIT'] = $this->DateFormat($row["DATE_EDIT"]);
            if ($row['IMAGE']!==''){
                $row['NEW_IMAGE'] = Func::getInstance()->GetImage(UPLOAD_IMAGES_DIR.'catalog/'.$row['IMAGE'], 50,50,'','catalog');
            }
        }
        return $row;
    }
    public function getItem($id){
        $sql = "SELECT i.*, c.ID AS CID, c.TITLE AS CAT_NAME, c.ALIAS AS CAT_ALIAS
        FROM `agcms_catalog_i` i
        LEFT JOIN `agcms_catalog_c` c ON i.PARENT=c.ID
        WHERE i.`ID`=$id  LIMIT 1";
        $query = $this->db->query($sql);
        $row = $this->db->fetch_array($query);
        $row["DATE_PUBL"] = $this->DateFormat($row["DATE_PUBL"]);
        $row["DATE_EDIT"] = $this->DateFormat($row["DATE_EDIT"]);
  /*      $row["DATE1"] = $this->DateFormat2($row["DATE1"]);
        $row["DATE2"] = $this->DateFormat2($row["DATE2"]);*/

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
                $new_images[] = $this->func->GetImage(UPLOAD_IMAGES_DIR.'catalog/'.$img, 100,100,'','catalog');
            }
        }

        $row['IMAGES'] = $images;
        $row['NEW_IMAGES'] = $new_images;
        $files = array();
        if ($row['FILES']!==''){
            $files = unserialize($row['FILES']);
        }
        $row['FILES'] = $files;

        $top_n = unserialize($row['TOP_N']);
        if (count($top_n) == 0){
            $top_n = array(array('',''));
        }
        $row['TOP_N'] = $top_n;

        $row['DOPS'] = unserialize($row['DOPS']);

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
            'dops'           => $this->GetDops(),
            'category_id'     => $this->cid,
            'num_pages'       => $this->num_pages,
            'items_count'     => count($items),
            'total'           => $this->total,
            'start'           => $this->start+1,
        ));
        $this->content = $this->SetTemplate('items.tpl');
    }

    public function ShowNewCat(){
        $this->assign(array(
            'templates'      => $this->func->getTemplates($this->templates_dir.'catalog/list/'),
            'categories'     => $this->categories,
            'new'            => true,
        ));
        $this->content = $this->SetTemplate('cat.tpl');
    }

    public function DeleteCategory($id){
        $sql = "SELECT * FROM `agcms_catalog_i` WHERE `PARENT` LIKE '%,$id,%'";
        $query = $this->db->query($sql);
        if ($this->db->num_rows($query) == 0){
            $sql = "DELETE FROM `agcms_catalog_c` WHERE `ID`=$id";
            $query = $this->db->query($sql);
            $this->Head('?c=catalog');
        } else {
            $_SESSION['alert'] = 'Сначала удалите материалы из этой категории!';
            $this->Head("?c=catalog&cid=$id");
        }
    }
    public function DeleteItem($id){
        $sql = "SELECT * FROM `agcms_catalog_i` WHERE `ID`=$id LIMIT 1";
        $query = $this->db->query($sql);
        $row = $this->db->fetch_array($query);
        if ($row['IMAGES']!==''){
            $images = explode(",", $row['IMAGES']);
            foreach ($images as $img){
                if (file_exists(UPLOAD_IMAGES_DIR.'catalog/'.$img)){
                    unlink(UPLOAD_IMAGES_DIR.'catalog/'.$img);
                }
            }
        }
        $sql = "DELETE FROM `agcms_catalog_i` WHERE `ID`=$id";
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
            'category_image'           => UPLOAD_IMAGES_DIR.'catalog/'.$row['IMAGE'],
            'category'                 => $row,
            'categories'               => $this->categories,
            'templates'                => Func::getInstance()->getTemplates($this->templates_dir.'catalog/list/'),
        ));
        $this->content = $this->SetTemplate('cat.tpl');
    }
    public function ShowItem($row){
        $sql = "SELECT * FROM `agcms_country` ORDER BY `COUNTRY_NAME`";
        $query = $this->db->query($sql);
        for ($i=0; $i < $this->db->num_rows($query); $i++) {
            $row2 = $this->db->fetch_array($query);
            $countrys[] = $row2;
        }
        if (isset($row['COUNTRY_ID'])){
            $country_id = $row['COUNTRY_ID'];
            $sql = "SELECT * FROM `agcms_city` WHERE `COUNTRY_ID`= $country_id  ORDER BY `CITY_NAME`";
            $query = $this->db->query($sql);
            for ($i=0; $i < $this->db->num_rows($query); $i++) {
                $row2 = $this->db->fetch_array($query);
                $row2["DATE_PUBL"] = $this->DateFormat($row2["DATE_PUBL"]);
                $row2["DATE_EDIT"] = $this->DateFormat($row2["DATE_EDIT"]);
                $city[] = $row2;
            }
        }

        /*if ($row['REGION_ID']){
            $region_id = $row['REGION_ID'];
            $sql = "SELECT * FROM `agcms_city` WHERE `REGION_ID`= $region_id  ORDER BY `CITY_NAME`";
            $query = $this->db->query($sql);
            for ($i=0; $i < $this->db->num_rows($query); $i++) {
                $row2 = $this->db->fetch_array($query);
                $row2["DATE_PUBL"] = $this->DateFormat($row2["DATE_PUBL"]);
                $row2["DATE_EDIT"] = $this->DateFormat($row2["DATE_EDIT"]);
                $city[] = $row2;
            }
        }*/
        $from_aero = unserialize($row['FROM_AERO']);
        $to_aero = unserialize($row['TO_AERO']);

        $sql = "SELECT * FROM `agcms_catalog_nets`";
        $nets = $this->db->select($sql);

        $sql = "SELECT * FROM `agcms_catalog_aeros`";
        $aeros = $this->db->select($sql);

        $this->assign(array(
            'from_aero'                    => $from_aero,
            'to_aero'                    => $to_aero,
            'countrys'                    => $countrys,
            'regions'                    => $regions,
            'city'                    => $city,
            'nets'                    => $nets,
            'item'                     => $row,
            'aeros'                     => $aeros,
            'dops'                     => $this->GetDops(),
            'templates'                => Func::getInstance()->getTemplates($this->templates_dir.'catalog/single/'),
        ));
        $this->content = $this->SetTemplate('item.tpl');
    }

    public function getSiteMap(){
        $return = array();
        $sql = "SELECT ALIAS FROM `agcms_catalog_i`  WHERE `PUBLIC`=1 ORDER BY `DATE_PUBL` DESC";
        $result = $this->db->query($sql);
        if ($this->db->num_rows($result)){
            for ($i = 0; $i < $this->db->num_rows($result); $i++){
                $row = $this->db->fetch_array($result);
                $return[]  = array(
                    'loc'           => $this->site_url . 'catalog/' . $row['ALIAS'] .'/',
                    'changefreq'    => 'weekly',
                    'priority'      => '1',
                );
            }
        }

        $sql = "SELECT * FROM `agcms_catalog_c` WHERE `PUBLIC`=1";
        $result = $this->db->query($sql);
        if ($this->db->num_rows($result)){
            for ($i = 0; $i < $this->db->num_rows($result); $i++){
                $row = $this->db->fetch_array($result);
                $parent_id = $row['ID'];
                $sql = "SELECT COUNT(*) AS CNT FROM `agcms_catalog_i` WHERE `PARENT` LIKE '%,$parent_id,%' AND `PUBLIC`=1";
                $result2 = $this->db->query($sql);
                if ($this->db->num_rows($result2)){
                    $row2 = $this->db->fetch_array($result2);
                    $cnt = ceil($row2['CNT']/$this->config->CatalogItemListPerPage);
                    for ($j = 1; $j < $cnt+1; $j++){
                        $return[]  = array(
                            'loc'           => $this->site_url . 'catalog/' . $row['ALIAS'] .'/page=' . $j . '/',
                            'changefreq'    => 'weekly',
                            'priority'      => '1',
                        );
                    }
                }
            }
        }

        return $return;
    }

    public function SaveNet(){
        $title = $this->post['name'];
        if (isset($this->id) && $this->id > 0){
            $sql = "UPDATE agcms_catalog_nets SET TITLE = '$title' WHERE ID = $this->id";
        } else {
            $sql = "INSERT INTO agcms_catalog_nets (TITLE) VALUES ('$title')";
        }
        $this->db->query($sql);

        $this->Head("?c=catalog&act=nets");
    }

    public function ShowNets(){
        if (isset($this->id)) {
            if ($this->id > 0){
                $sql = "SELECT * FROM agcms_catalog_nets  WHERE ID = $this->id";
                $item = $this->db->select($sql);
                $this->assign(array(
                    'item'           => $item[0],
                ));
            }

            $this->content = $this->SetTemplate('net.tpl');

        } else {
            $sql = "SELECT n.*
            FROM agcms_catalog_nets n ";
            $params = array(
                'sql' => $sql,
                'per_page' => 20,
                'current_page' => $this->get['page'],
                'link' => '?c=catalog&act=nets',
                'get_name' => 'page',
            );
            $result = $this->getPagination($params);

            $query = $result['query'];
            for ($i=0; $i < $this->db->num_rows($query); $i++) {
                $row = $this->db->fetch_array($query);
                $items[] = $row;
            }
            $num_pages = $result['num_pages'];
            $pagination = $result['pagination'];
            $total = $result['total'];
            $start = $result['start'];
            $this->assign(array(
                'items'           => $items,
                'num_pages'       => $num_pages,
                'category_id'     => $this->cid,
                'items_count'     => count($items),
                'total'           => $total,
                'start'           => $start,
                'pagination'      => $pagination,
            ));
            $this->content = $this->SetTemplate('nets.tpl');
        }

    }

    public function GetSchools(){
        $sql = "SELECT * FROM agcms_catalog_i";
        return $this->db->select($sql);
    }

    public function GetNets(){
        $sql = "SELECT * FROM agcms_catalog_nets";
        return $this->db->select($sql);
    }

    public function ShowCourse(){
        if (isset($this->id)){
            $sql = "SELECT * FROM agcms_catalog_courses WHERE ID = " . $this->id;
            $item = $this->db->select($sql, array('single_array' => true));
            $item['PACKS'] = json_decode($item['PACKS']);
            $this->assign(array(
                'item' => $item,
            ));
        }
        $this->assign(array(
            'schools' => $this->GetSchools(),
            'nets' => $this->GetNets(),
            'predmets' => $this->GetPredmets(),
        ));
        $this->content = $this->SetTemplate('course.tpl');
    }

    public function SaveCourse(){

        $this->post['price'] = str_replace(',', '.',$this->post['price']);
        $this->post['price_new'] = str_replace(',', '.',$this->post['price_new']);

        $packs = $_POST['packs'];

        $params = array(
            'NET_ID' => $this->post['net_id'],
            'SH_ID' => $this->post['sh_id'],
            'TITLE' => $this->post['title'],
            'PREDMET' => $this->post['predmet'],
            'COUNT_OT' => $this->post['count_ot'],
            'COUNT_DO' => $this->post['count_do'],
            'COUNT_UR' => $this->post['count_ur'],
            'PRODOL_UR' => $this->post['prodol_ur'],
            'MIN_LEVEL' => $this->post['min_level'],
            'DATE_TYPE' => 0,
            'DATE_START' => $this->post['date_start'],
            //'DATE_START' => $date_start,
            'DATE_END' => $this->post['date_end'],
            //'DATE_END' => $date_end,
            'PRODOL_TYPE' => $this->post['prodol_type'],
            'PRODOL_COUNT' => $this->post['prodol_count'],
            'DESC' => $this->post['desc'],
            'TIME_DESC' => $this->post['time_desc'],
            'PRICE' => $this->post['price'],
            'PRICE_NEW' => $this->post['price_new'],
            'PRICE_R' => $this->post['price_r'],
            'PACKS' => $packs,
        );
        if (isset($this->id)){
            $this->db->update('agcms_catalog_courses', $params, "ID = " . $this->id);

        } else{
            $this->db->insert('agcms_catalog_courses', $params);
        }

        $this->Head('?c=catalog&act=courses');
    }

    public function ShowCourses(){
        $sql = "SELECT c.*, i.ID AS S_ID, i.TITLE AS S_TITLE FROM `agcms_catalog_courses` c
        LEFT JOIN agcms_catalog_i i ON  (c.SH_ID = i.ID OR c.NET_ID = i.NET_ID) AND (c.NET_ID > 0 OR c.SH_ID > 0)
        GROUP BY c.ID ORDER BY c.ID DESC";
        $sql = "SELECT c.*, i.ID AS S_ID, i.TITLE AS S_TITLE FROM `agcms_catalog_courses` c
        LEFT JOIN agcms_catalog_i i ON  c.SH_ID = i.ID
        GROUP BY c.ID ORDER BY c.ID DESC";
        $params = array(
            'sql' => $sql,
            'per_page' => 50,
            'current_page' => $this->get['p'],
            'link' => '?c=catalog&act=courses',
            'get_name' => 'p',
        );
        $result = $this->getPagination($params);
        //var_dump($this->db->error());
        $query = $result['query'];
        for ($i=0; $i < $this->db->num_rows($query); $i++) {
            $row = $this->db->fetch_array($query);
            $items[] = $row;
        }
        $num_pages = $result['num_pages'];
        $pagination = $result['pagination'];
        $total = $result['total'];
        $start = $result['start'];
        $this->assign(array(
            'items'           => $items,
            'num_pages'       => $num_pages,
            'category_id'     => $this->cid,
            'items_count'     => count($items),
            'total'           => $total,
            'start'           => $start,
            'pagination'      => $pagination,
        ));
        $this->content = $this->SetTemplate('courses.tpl');
    }

    public function ShowPro(){
        if (isset($this->id)){
            $sql = "SELECT * FROM agcms_catalog_prozhiv WHERE ID = " . $this->id;
            $item = $this->db->select($sql, array('single_array' => true));
            //$item['DATE1'] = $this->DateFormat2($item['DATE1']);
            $item['PACKS'] = unserialize($item['PACKS']);
            $item['INCS'] = unserialize($item['INCS']);

            $this->assign(array(
                'item' => $item
            ));
        }

        $this->assign(array(
            'schools' => $this->GetSchools(),
            'nets' => $this->GetNets(),
            'incs' => $this->GetIncs(),
        ));
        $this->content = $this->SetTemplate('pro.tpl');
    }

    public function SavePro(){
        //$date1 = strtotime($this->post['date1']);

        $packs = array();
        if (count($this->post['pack_text']) > 0){
            foreach($this->post['pack_text'] as $k => $b){
                if ($this->post['pack_text'][$k] !== '' && $this->post['pack_price'][$k] !== ''){
                    $packs[] = array($this->post['pack_text'][$k], $this->post['pack_price'][$k]);
                }

            }
        }
        $packs = serialize($packs);


        $incs = serialize($this->post['incs']);

        $params = array(
            'NET_ID' => $this->post['net_id'],
            'SH_ID' => $this->post['sh_id'],
            'VID' => $this->post['vid'],
            'DATE1' => $this->post['date1'],
            //'DATE1' => $date1,
            'VOZRAST' => $this->post['vozrast'],
            'GEO1' => $this->post['geo1'],
            'GEO2' => $this->post['geo2'],
            'GEO' => $this->post['geo'],
            'DESC' => $this->post['desc'],
            'INC' => $this->post['inc'],
            'PACKS' => $packs,
            'RASHOD' => $this->post['rashod'],
            'INCS' => $incs,
        );

        $upload_path = UPLOAD_IMAGES_DIR.'catalog/';
        $photo1 = Func::getInstance()->UploadFile($_FILES["photo1"]['name'],$_FILES["photo1"]['tmp_name'], $upload_path);
        if ($photo1 !== false){
            $params['PHOTO1'] = $photo1;
        }
        $photo2 = Func::getInstance()->UploadFile($_FILES["photo2"]['name'],$_FILES["photo2"]['tmp_name'], $upload_path);
        if ($photo2 !== false){
            $params['PHOTO2'] = $photo2;
        }
        if (isset($this->id)){
            $params['ID'] = $this->id;
            $this->db->update('agcms_catalog_prozhiv', $params, "ID = " . $this->id);
        } else{
            $this->db->insert('agcms_catalog_prozhiv', $params);
        }

        $this->Head('?c=catalog&act=pros');
    }

    public function ShowPros(){
        $sql = "SELECT p.*, i.ID AS S_ID, i.TITLE AS S_TITLE FROM `agcms_catalog_prozhiv` p
        LEFT JOIN agcms_catalog_i i ON  (p.SH_ID = i.ID OR p.NET_ID = i.NET_ID) AND (p.NET_ID > 0 OR p.SH_ID > 0)
        GROUP BY p.ID ORDER BY p.ID DESC";
        $sql = "SELECT p.*, i.ID AS S_ID, i.TITLE AS S_TITLE FROM `agcms_catalog_prozhiv` p
        LEFT JOIN agcms_catalog_i i ON  p.SH_ID = i.ID
        GROUP BY p.ID ORDER BY p.ID DESC";


        $params = array(
            'sql' => $sql,
            'per_page' => 20,
            'current_page' => $this->get['p'],
            'link' => '?c=catalog&act=pros',
            'get_name' => 'p',
        );
        $result = $this->getPagination($params);
        $query = $result['query'];
        for ($i=0; $i < $this->db->num_rows($query); $i++) {
            $row = $this->db->fetch_array($query);
            $items[] = $row;
        }
        $num_pages = $result['num_pages'];
        $pagination = $result['pagination'];
        $total = $result['total'];
        $start = $result['start'];
        $this->assign(array(
            'items'           => $items,
            'num_pages'       => $num_pages,
            'category_id'     => $this->cid,
            'items_count'     => count($items),
            'total'           => $total,
            'start'           => $start,
            'pagination'      => $pagination,
        ));

        $this->content = $this->SetTemplate('pros.tpl');
    }

    public function ShowDop(){
        if (isset($this->id)){
            $sql = "SELECT * FROM agcms_catalog_dop WHERE ID = " . $this->id;
            $item = $this->db->select($sql, array('single_array' => true));
            $this->assign(array(
                'item' => $item
            ));
        }
        $this->content = $this->SetTemplate('dop.tpl');
    }


    public function GetDops(){
        $sql = "SELECT * FROM `agcms_catalog_dop`";
        return $this->db->select($sql);
    }

    public function ShowDops(){

        $this->assign(array(
            'items'           => $this->GetDops(),
        ));

        $this->content = $this->SetTemplate('dops.tpl');
    }

    public function SaveDop(){
        $params = array(
            'TITLE' => $this->post['title'],
            'TYPE' => $this->post['type']
        );
        if (isset($this->id)){
            $this->db->update('agcms_catalog_dop', $params, 'ID = ' . $this->id);
        } else{
            $this->db->insert('agcms_catalog_dop', $params);
        }
        $this->Head('?c=catalog&act=dops');
    }

    public function DelDop(){
        $this->db->query('DELETE FROM agcms_catalog_dop WHERE ID = ' . $this->id);
        $this->Head('?c=catalog&act=dops');
    }

    public function ShowInc(){
        if (isset($this->id)){
            $sql = "SELECT * FROM agcms_catalog_inc WHERE ID = " . $this->id;
            $item = $this->db->select($sql, array('single_array' => true));
            $this->assign(array(
                'item' => $item
            ));
        }
        $this->content = $this->SetTemplate('inc.tpl');
    }


    public function GetIncs(){
        $sql = "SELECT * FROM `agcms_catalog_inc`";
        return $this->db->select($sql);
    }

    public function ShowIncs(){

        $this->assign(array(
            'items'           => $this->GetIncs(),
        ));

        $this->content = $this->SetTemplate('incs.tpl');
    }

    public function SaveInc(){
        $params = array(
            'TITLE' => $this->post['title'],
            'ICON' => $this->post['icon']
        );
        if (isset($this->id)){
            $this->db->update('agcms_catalog_inc', $params, 'ID = ' . $this->id);
        } else{
            $this->db->insert('agcms_catalog_inc', $params);
        }
        $this->Head('?c=catalog&act=incs');
    }

    public function CopyCourse(){
        $row = $this->db->select("SELECT * FROM agcms_catalog_courses WHERE ID = " . $this->id, array("single_array" => true));
        if ($row !== false){
            unset($row['ID']);
            $row['NET_ID'] = 0;
            $row['SH_ID'] = 0;
            $row['TITLE'] = $row['TITLE'] . ' (' . $this->DateFormat(time()) . ')';
            $this->db->insert('agcms_catalog_courses', $row);
        }
        $this->Head('?c=catalog&act=courses');
    }

    public function DelCourse(){
        $this->db->query('DELETE FROM agcms_catalog_courses WHERE ID = ' . $this->id);
        $this->Head('?c=catalog&act=courses');
    }

    public function CopyPro(){
        $row = $this->db->select("SELECT * FROM agcms_catalog_prozhiv WHERE ID = " . $this->id, array("single_array" => true));
        if ($row !== false){
            unset($row['ID']);
            $row['NET_ID'] = 0;
            $row['SH_ID'] = 0;
            $row['VID'] = $row['VID'] . ' (' . $this->DateFormat(time()) . ')';
            $this->db->insert('agcms_catalog_prozhiv', $row);
        }

        $this->Head('?c=catalog&act=pros');
    }

    public function DelPro(){
        $this->db->query('DELETE FROM agcms_catalog_prozhiv WHERE ID = ' . $this->id);
        $this->Head('?c=catalog&act=pros');
    }

    public function ShowNet(){
        if (isset($this->id)){
            $sql = "SELECT * FROM agcms_catalog_nets WHERE ID = " . $this->id;
            $item = $this->db->select($sql, array('single_array' => true));
            $this->assign(array(
                'item' => $item
            ));
        }
        $this->content = $this->SetTemplate('net.tpl');
    }

    public function ShowNetList(){
        $sql = "SELECT * FROM agcms_catalog_i WHERE NET_ID = " . $this->id;
        $items = $this->db->select($sql);
        $sql = "SELECT * FROM agcms_catalog_nets WHERE ID = " . $this->id;
        $item = $this->db->select($sql, array('single_array' => true));

        $this->assign(array(
            'items' => $items,
            'item' => $item
        ));
        $this->content = $this->SetTemplate('net-list.tpl');
    }

    public function GetPredmets(){
        $sql = "SELECT * FROM `agcms_catalog_predmets`";
        return $this->db->select($sql);
    }

    public function ShowPredmets(){

        $this->assign(array(
            'items'           => $this->GetPredmets(),
        ));

        $this->content = $this->SetTemplate('predmets.tpl');
    }

    public function ShowPredmet(){
        if (isset($this->id)){
            $sql = "SELECT * FROM agcms_catalog_predmets WHERE ID = " . $this->id;
            $item = $this->db->select($sql, array('single_array' => true));
            $this->assign(array(
                'item' => $item
            ));
        }
        $this->content = $this->SetTemplate('predmet.tpl');
    }

    public function SavePredmet(){
        $params = array(
            'TITLE' => $this->post['title'],
        );
        if (isset($this->id)){
            $this->db->update('agcms_catalog_predmets', $params, 'ID = ' . $this->id);
        } else{
            $this->db->insert('agcms_catalog_predmets', $params);
        }

        $this->Head('?c=catalog&act=predmets');
    }

    public function DelPredmet(){
        $this->db->query('DELETE FROM agcms_catalog_predmets WHERE ID = ' . $this->id);
        $this->Head('?c=catalog&act=predmets');
    }

    public function ShowAeros(){
        $sql = "SELECT * FROM agcms_catalog_aeros";
        $items = $this->db->select($sql);
        $this->assign(array(
            'items' => $items
        ));
        $this->content = $this->SetTemplate('aeros.tpl');
    }
    public function ShowAero(){
        if ($this->get['id'] > 0){
            $sql = "SELECT * FROM agcms_catalog_aeros WHERE ID = " . $this->get['id'] . " LIMIT 1";
            $item = $this->db->select($sql);
            $this->assign(array(
                'item' => $item[0]
            ));
        }
        $this->content = $this->SetTemplate('aero.tpl');
    }

    public function SaveAero(){
        $params = array(
            'TITLE' => $this->post['title']
        );
        if ($this->get['id'] > 0){
            $this->db->update('agcms_catalog_aeros', $params, "ID = " . $this->get['id']);
        } else {
            $this->db->insert('agcms_catalog_aeros', $params);
        }
        $this->Head('?c=catalog&act=aeros');
    }

    public function DeleteAero(){
        $sql = "DELETE FROM agcms_catalog_aeros WHERE ID = " . $this->get['id'];
        $this->db->query($sql);

        $this->Head('?c=catalog&act=aeros');
    }
    public function Index(){

        $this->SetPlugins();
        $this->page_title = 'Каталог';

        if (isset($this->post['save-net'])){
            $this->SaveNet();
        }

        if (isset($this->post['c_title']) && trim($this->post['c_title'])!==''){
            $this->SaveCategory();
        }

        if (isset($this->post['save-item'])){
            $this->SaveItem();
        }
        if (isset($this->post['save-fields'])){
            $this->SaveFields();
        }
        if (isset($this->post['save-settings'])){
            $this->SaveSettings();
        }
        if (isset($this->post['save-course'])){
            $this->SaveCourse();
        }
        if (isset($this->post['save-pro'])){
            $this->SavePro();
        }
        if (isset($this->post['save-dop'])){
            $this->SaveDop();
        }
        if (isset($this->post['save-inc'])){
            $this->SaveInc();
        }
        if (isset($this->post['save-predmet'])){
            $this->SavePredmet();
        }
        if (isset($this->post['save-aero'])){
            $this->SaveAero();
        }
        $this->categories = $this->getCategories();
        if(count($this->categories) == 0 && !isset($this->act)){
            $this->head('?c=catalog&act=new_c');
        }
        $this->structure = Func::getInstance()->getStructure($this->categories);
        $this->ShowMenu();


        if ($this->act == 'fields'){
            $this->content = $this->SetTemplate('item-fields-settings.tpl');
        }
        elseif ($this->act == 'settings'){
            $this->assign(array(
                'templates_comment_form'      => $this->func->getTemplates($this->templates_dir.'comments/form/'),
                'templates_comment_view'      => $this->func->getTemplates($this->templates_dir.'comments/view/'),
            ));
            $this->content = $this->SetTemplate('settings.tpl');
        }
        elseif ($this->act == 'new_c'){
            $this->ShowNewCat();
        }

        elseif ($this->act == 'del'){
            $this->DeleteCategory($this->cid);

        }
        elseif ($this->act == 'course'){
            $this->ShowCourse();
        }
        elseif ($this->act == 'courses'){
            $this->ShowCourses();
        }
        elseif ($this->act == 'pro'){
            $this->ShowPro();
        }
        elseif ($this->act == 'pros'){
            $this->ShowPros();
        }
        elseif ($this->act == 'dop'){
            $this->ShowDop();
        }
        elseif ($this->act == 'dops'){
            $this->ShowDops();
        }
        elseif ($this->act == 'aeros'){
            $this->ShowAeros();
        }
        elseif ($this->act == 'aero'){
            $this->ShowAero();
        }
        elseif ($this->act == 'del-aero'){
            $this->DeleteAero();
        }
        elseif ($this->act == 'inc'){
            $this->ShowInc();
        }
        elseif ($this->act == 'incs'){
            $this->ShowIncs();
        }
        elseif ($this->act == 'nets'){
            $this->ShowNets();
        }
        elseif ($this->act == 'net'){
            $this->ShowNet();
        }
        elseif ($this->act == 'predmets'){
            $this->ShowPredmets();
        }
        elseif ($this->act == 'predmet'){
            $this->ShowPredmet();
        }
        elseif ($this->act == 'del-predmet'){
            $this->DelPredmet();
        }
        elseif ($this->act == 'net-list'){
            $this->ShowNetList();
        }
        elseif ($this->act == 'copy-course'){
            $this->CopyCourse();
        }
        elseif ($this->act == 'del-course'){
            $this->DelCourse();
        }
        elseif ($this->act == 'copy-pro'){
            $this->CopyPro();
        }
        elseif ($this->act == 'del-dop'){
            $this->DelDop();
        }
        elseif ($this->act == 'del-pro'){
            $this->DelPro();
        }
        elseif ($this->act == 'del-item'){
            $this->DeleteItem($this->id);
            $this->Head("?c=catalog&cid=$this->cid");
        }
        elseif (!isset($this->act) && isset($this->cid) && !isset($this->id)){
            $this->ShowItems($this->cid);
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