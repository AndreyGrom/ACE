<?php

class AdminShopController extends AdminController {
    public function __construct() {
        parent::__construct();
        $this->categories    = array();
        $this->structure     = array();
        $this->id            = $this->get['id'];
        $this->cid           = $this->get['cid'];
        $this->act           = $this->get['act'];
        $this->act2          = $this->get['act2'];
    }

    public function SetPlugins(){
/*        $this->js[]   = HTML_PLUGINS_DIR.'cleeditor/jquery.cleditor.min.js';
        $this->js[]   = HTML_PLUGINS_DIR.'cleeditor/jquery.cleditor.rfm.js';
        $this->css[]  = HTML_PLUGINS_DIR.'cleeditor/jquery.cleditor.css';*/
        $this->js[]   = HTML_PLUGINS_DIR.'tinymce/tinymce.min.js';
        $this->js[]   = HTML_PLUGINS_DIR.'fancybox/jquery.fancybox.js';
        $this->js[]   = HTML_PLUGINS_DIR.'fancybox/jquery.fancybox.pack.js';
        $this->js[]   = HTML_CONTROLLERS_DIR.'shop/action.js';
        $this->js[]   = HTML_PLUGINS_DIR.'ajaxupload.3.5.js';
        $this->js[]   = HTML_PLUGINS_DIR.'jquery-ui-1.11.4.custom/jquery-ui.min.js';
        $this->css[]  = HTML_PLUGINS_DIR.'fancybox/jquery.fancybox.css';
        $this->css[]  = HTML_PLUGINS_DIR.'jquery-ui-1.11.4.custom/jquery-ui.min.css';
    }

    public function SaveFields(){
        foreach ($this->post as $k=>$p){
            if ($k == 'save-fields') continue;
            $this->config->set($k,$p);
        }
        $this->Head("?c=shop&act=fields");
    }
    public function SaveSettings(){
        foreach ($this->post as $k=>$p){
            if ($k == 'save-settings') continue;
            $this->config->set($k,$p);
        }
        $this->Head("?c=shop&act=settings");
    }
    public function SaveCategory(){
        $title            = $this->post['c_title'];
        $desc             = $this->db->input($this->post['c_desc']);
        $desc2             = $this->db->input($this->post['c_desc2']);
        $parent           = $this->post['parent'];
        $alias            = ($this->post['alias']!=='')?$this->post['alias']:$this->func->TranslitURL($title);
        $template         = $this->post['template'];
        $publ             = $this->post['publ'];
        $meta_desc        = $this->post['meta_description'];
        $meta_keywords    = $this->post['meta_keywords'];
        $delete_image     = $this->post['delete_image'];
        $old_image        = $this->post['old_image'];
        $sql = "SELECT * FROM `agcms_shop_c` WHERE `ALIAS`='$alias'";
        if ($this->act!=='new_c'){
            $sql .= " AND ID <> $this->cid";
        }
        $query = $this->db->query($sql);
        if ($this->db->num_rows($query) == 0){
            $upload_path = UPLOAD_IMAGES_DIR.'shop/';
            $image = Func::getInstance()->UploadFile($_FILES["image"]['name'],$_FILES["image"]['tmp_name'], $upload_path);
            if ($this->act == 'new_c'){
                $sql = "
            INSERT INTO `agcms_shop_c` (
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
                $sql = "UPDATE `agcms_shop_c` SET
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
            $this->Head("?c=shop&cid=$this->cid");
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

        $title = $this->post['title'];
        $alias = ($this->post['alias']!=='')?$this->post['alias']:Func::getInstance()->TranslitURL($title);
        $short_content = $this->db->input($this->post['short_content']);
        $content = $this->db->input($this->post['content']);
        $template = $this->post['template'];
        $comments = $this->post['comments'];
        $publ = $this->post['publ'];
        $meta_title = $this->post['meta_title'];
        $meta_desc = $this->post['meta_description'];
        $meta_keywords = $this->post['meta_keywords'];
        $article = $this->post['article'];
        $price = $this->post['price'];
        $price_opt = $this->post['price_opt'];
        $price_new = $this->post['price_new'];
        $quantity = $this->post['quantity'];
        $other1 = $this->db->input($this->post['other1']);
        $other2 = $this->db->input($this->post['other2']);
        $other3 = $this->db->input($this->post['other3']);
        $other4 = $this->db->input($this->post['other4']);
        $other5 = $this->db->input($this->post['other5']);
        $other6 = $this->db->input($this->post['other6']);
        $other7 = $this->db->input($this->post['other7']);
        $other8 = $this->db->input($this->post['other8']);
        $other9 = $this->db->input($this->post['other9']);
        $other10 = $this->db->input($this->post['other10']);
        $file1 = $this->db->input($this->post['file1']);
        $file2 = $this->db->input($this->post['file2']);
        $file3 = $this->db->input($this->post['file3']);
        $file1_name = $this->db->input($this->post['file1_name']);
        $file2_name = $this->db->input($this->post['file2_name']);
        $file3_name = $this->db->input($this->post['file3_name']);
        $manufacturer = $this->db->input($this->post['manufacturer']);
        $model = $this->db->input($this->post['model']);
        $country = $this->db->input($this->post['country']);

        $tag = trim($this->post['tags']);
        $links = trim($this->post['links']);
        $video = trim($this->post['video']);
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
        $sql = "SELECT * FROM `agcms_shop_i` WHERE `ALIAS`='$alias'";
        if (isset($this->id)){
            $sql .= " AND ID <> $this->id";
        }
        $query = $this->db->query($sql);
        if ($this->db->num_rows($query) == 0){ // если такого алиаса нет
            if ($this->act == 'new'){
                $sql = "
            INSERT INTO `agcms_shop_i` (
            `PARENT`,`TITLE`, `ALIAS`,`SHORT_CONTENT`, `CONTENT`,`META_TITLE`,`META_DESC`,`META_KEYWORDS`,`COMMENTS`,`PUBLIC`,`TEMPLATE`,`DATE_PUBL`,`DATE_EDIT`,`TAGS`,`ARTICLE`,`PRICE_OPT`,`PRICE`,`PRICE_NEW`,`QUANTITY`,
            `OTHER1`,`OTHER2`,`OTHER3`,`OTHER4`,`OTHER5`,`OTHER6`,`OTHER7`,`OTHER8`,`OTHER9`,`OTHER10`,`FILE1`,`FILE2`,`FILE3`,`FILE1_NAME`,`FILE2_NAME`,`FILE3_NAME`,`MANUFACTURER_ID`,`MODEL`,`COUNTRY`,`LINKS`,`VIDEO`)
            VALUES
            ('$parent','$title','$alias','$short_content','$content','$meta_title','$meta_desc','$meta_keywords','$comments','$publ','$template','$date','$date','$tags_str','$article','$price_opt','$price','$price_new','$quantity',
            '$other1','$other2','$other3','$other4','$other5','$other6','$other7','$other8','$other9','$other10','$file1','$file2','$file3','$file1_name','$file2_name','$file3_name','$manufacturer','$model','$country','$links','$video')";
                $query = $this->db->query($sql);
                $this->id = $this->db->last_id();

            }else{
                $date_edit = $this->post['DATE_EDIT'];
                $sql = "UPDATE `agcms_shop_i` SET
        `PARENT` = '$parent',
        `TITLE` = '$title',
        `ALIAS` = '$alias',
        `SHORT_CONTENT` = '$short_content',
        `CONTENT` = '$content',
        `META_TITLE` = '$meta_title',
        `META_DESC` = '$meta_desc',
        `META_KEYWORDS` = '$meta_keywords',
        `COMMENTS` = '$comments',
        `PUBLIC` = '$publ',
        `TEMPLATE` = '$template',
        `DATE_EDIT` = '$date',
        `TAGS` = '$tags_str',
        `ARTICLE` = '$article',
        `PRICE_OPT` = '$price_opt',
        `PRICE` = '$price',
        `PRICE_NEW` = '$price_new',
        `QUANTITY` = '$quantity',
        `OTHER1` = '$other1',
        `OTHER2` = '$other2',
        `OTHER3` = '$other3',
        `OTHER4` = '$other4',
        `OTHER5` = '$other5',
        `OTHER6` = '$other6',
        `OTHER7` = '$other7',
        `OTHER8` = '$other8',
        `OTHER9` = '$other9',
        `OTHER10` = '$other10',
        `FILE1` = '$file1',
        `FILE2` = '$file2',
        `FILE3` = '$file3',
        `FILE1_NAME` = '$file1_name',
        `FILE2_NAME` = '$file2_name',
        `FILE3_NAME` = '$file3_name',
        `MANUFACTURER_ID` = '$manufacturer',
        `MODEL` = '$model',
        `COUNTRY` = '$country',
        `LINKS` = '$links',
        `VIDEO` = '$video'
         WHERE `ID` = $this->id";
                $query = $this->db->query($sql);
            }


            $product_id = $this->id;
            $sql = "DELETE FROM `agcms_shop_i_options` WHERE `PRODUCT_ID`=$product_id";
            $query = $this->db->query($sql);
            $options = $this->post['options_json'];
            $options = json_decode($options);
            if (count($options) > 0){
                $sql_arr = array();
                $sql = "INSERT INTO `agcms_shop_i_options` (`PRODUCT_ID`, `OPTION_ID`, `PARAMETER_ID`, `PARAMETER_METHOD`, `PARAMETER_PRICE`, `PARAMETER_ARTICLE`) VALUES ";
                foreach($options as $o){
                    $option_id = $o->option_id;
                    $parameter_id = $o->id;
                    $parameter_method = $o->method;
                    $parameter_price = $o->price;
                    $parameter_article = $o->article;
                    $sql_arr[] = "('$product_id', '$option_id', '$parameter_id', '$parameter_method', '$parameter_price', '$parameter_article')";
                }
                $sql .= implode(",",$sql_arr);
                $sql .=';';
                $query = $this->db->query($sql);
            }

            $this->Head("?c=shop&cid=".$parents[0]."&id=$this->id");
        } else {
            $this->session['alert'] = 'Такой алиас уже существует';
        }
    }

    public function getCategories($parent = false){
        $sql = "SELECT * FROM `agcms_shop_c` ORDER BY `ID`";
        $query = $this->db->query($sql);
        $categories = $this->db->fetch_all($query);
        return $categories;
    }

    public function getItems($parent = false, $start, $count, $sort='`ID` DESC'){
        $items = array();
        $where = '';
        if ($count > 0){
            $limit = "LIMIT $start, $count";
        }
        if ($parent){
            $where = "WHERE `PARENT` LIKE '%,$parent,%'";
        }

        $sql = "SELECT * FROM `agcms_shop_i` $where ORDER BY $sort $limit";
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
        $sql = "SELECT * FROM `agcms_shop_c` WHERE `ID`=$cid LIMIT 1";
        $query = $this->db->query($sql);
        if ($this->db->num_rows($query)>0){
            $row = $this->db->fetch_array($query);
            $row['DATE_PUBL'] = $this->DateFormat($row["DATE_PUBL"]);
            $row['DATE_EDIT'] = $this->DateFormat($row["DATE_EDIT"]);
            if ($row['IMAGE']!==''){
                $row['NEW_IMAGE'] = Func::getInstance()->GetImage(UPLOAD_IMAGES_DIR.'shop/'.$row['IMAGE'], 50,50,'','shop');
            }
        }
        return $row;
    }
    public function getItem($id){
        $sql = "SELECT i.*, c.ID AS CID, c.TITLE AS CAT_NAME, c.ALIAS AS CAT_ALIAS FROM `agcms_shop_i` i LEFT JOIN `agcms_shop_c` c ON i.PARENT=c.ID WHERE i.`ID`=$id LIMIT 1";
        $query = $this->db->query($sql);
        $row = $this->db->fetch_array($query);
        $row["DATE_PUBL"] = $this->DateFormat($row["DATE_PUBL"]);
        $row["DATE_EDIT"] = $this->DateFormat($row["DATE_EDIT"]);
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
                $new_images[] = $this->func->GetImage(UPLOAD_IMAGES_DIR.'shop/'.$img, 100,100,'','shop');
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

    public function ShowItems($cid = false){
        $url = '';
        if ($cid){
            $where = "WHERE `PARENT` LIKE '%,$cid,%'";
            $url .= '&cid='.$cid;
        }
        if (isset($this->get['q'])){
            if ($this->get['q']==0){
                $where_arr[] = "QUANTITY > 0";
            } else {
                $where_arr[] = "QUANTITY = 0";
            }
            $url = $url.'&q='.$this->get['q'];
        }
        if (isset($this->get['a'])){
            if ($this->get['a']==0){
                $where_arr[] = "PRICE_NEW = 0";
            } else {
                $where_arr[] = "PRICE_NEW > 0";
            }
            $url = $url.'&a='.$this->get['a'];
        }
        if (isset($this->get['n'])){
            $where_arr[] = "ID='".$this->get['n']."'";
            $url = $url.'&n='.$this->get['n'];
        }
        if (isset($this->get['art'])){
            $where_arr[] = "ARTICLE='".$this->get['art']."'";
            $url = $url.'&art='.$this->get['art'];
        }
        if (isset($where_arr)){
            $where = implode(' AND ',$where_arr);
            $where = 'WHERE '.$where;
        }
        $sql = "SELECT * FROM `agcms_shop_i` $where";
        $params = array(
            'sql' => $sql,
            'per_page' => 20,
            'current_page' => $this->get['page'],
            'link' => '?c=shop'.$url,
            'get_name' => 'page',
        );
        $result = $this->getPagination($params);
        $query = $result['query'];
        for ($i=0; $i < $this->db->num_rows($query); $i++) {
            $row = $this->db->fetch_array($query);
            $row["DATE_PUBL"] = $this->DateFormat($row["DATE_PUBL"]);
            $row["DATE_EDIT"] = $this->DateFormat($row["DATE_EDIT"]);
            $items[] = $row;
        }
        $num_pages = $result['num_pages'];
        $pagination = $result['pagination'];
        $total = $result['total'];
        $start = $result['start'];
        $this->assign(array(
            'items'           => $items,
            'category_id'     => $this->cid,
            'items_count'     => count($items),
            'total'           => $total,
            'start'           => $start,
            'pagination'      => $pagination,
            'q_filter'        => array('В наличии','Нет в наличии'),
            'a_filter'        => array('Без скидки','Со скидкой'),
        ));
        $this->content = $this->SetTemplate('items.tpl');
    }

    public function ShowNewCat(){
        $this->assign(array(
            'templates'      => $this->func->getTemplates($this->templates_dir.'shop/list/'),
            'categories'     => $this->categories,
            'new'            => true,
        ));
        $this->content = $this->SetTemplate('cat.tpl');
    }
    public function ShowNewItem(){
        $this->assign(array(
            'templates'     => $this->func->getTemplates($this->templates_dir.'shop/single/'),
            'categories'    => $this->structure,
            'new'           => true,
            'products'      => $this->getItems(false,0,0),
            'options'      => $this->GetOptionsArray(),
        ));
        $this->content = $this->SetTemplate('item.tpl');
    }
    public function DeleteCategory($id){
        $sql = "SELECT * FROM `agcms_shop_i` WHERE `PARENT` LIKE '%,$id,%'";
        $query = $this->db->query($sql);
        if ($this->db->num_rows($query) == 0){
            $sql = "DELETE FROM `agcms_shop_c` WHERE `ID`=$id";
            $query = $this->db->query($sql);
            $this->Head('?c=shop');
        } else {
            $_SESSION['alert'] = 'Сначала удалите материалы из этой категории!';
            $this->Head("?c=shop&cid=$id");
        }
    }
    public function DeleteItem($id){
        $sql = "SELECT * FROM `agcms_shop_i` WHERE `ID`=$id LIMIT 1";
        $query = $this->db->query($sql);
        $row = $this->db->fetch_array($query);
        if ($row['IMAGES']!==''){
            $images = explode(",", $row['IMAGES']);
            foreach ($images as $img){
                if (file_exists(UPLOAD_IMAGES_DIR.'shop/'.$img)){
                    unlink(UPLOAD_IMAGES_DIR.'shop/'.$img);
                }
            }
        }
        $sql = "DELETE FROM `agcms_shop_i` WHERE `ID`=$id";
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
            'category_image'           => UPLOAD_IMAGES_DIR.'shop/'.$row['IMAGE'],
            'category'                 => $row,
            'categories'               => $this->categories,
            'templates'                => Func::getInstance()->getTemplates($this->templates_dir.'shop/list/'),
        ));
        $this->content = $this->SetTemplate('cat.tpl');
    }
    public function GetOptionsArray(){
        $option_list = $this->GetOptions();
        $options = array();
        foreach ($option_list as $v){
            $temp = $this->GetOptionParams($v['OPTION_ID']);
            $option_param_list = array();
            foreach ($temp as $t){
                $option_param_list[] = $t;
            }
            $options[] = array('option'=>$v, 'params'=>$option_param_list);
        }
        return $options;
    }
    public function GetProductOptions($id){
        $result = array();
        $sql = "SELECT * FROM `agcms_shop_i_options` WHERE `PRODUCT_ID`=$id";
        $query = $this->db->query($sql);
        $result = $this->db->fetch_all($query);
/*        if ($this->db->num_rows($query)>0){
            for ($i=0; $i < $this->db->num_rows($query); $i++) {
                $result[] = $this->db->fetch_array($query);
            }
        }*/
        return $result;
    }
    public function ShowItem(){
        $row = $this->getItem($this->id);
        $options = $this->GetOptionsArray();
        $this->assign(array(
            'item'                     => $row,
            'item_id'                  => $row['ID'],
            'categories'               => $this->structure,
            'templates'                => Func::getInstance()->getTemplates($this->templates_dir.'shop/single/'),
            'cid'                      => $row['CID'],
            'c_name'                   => $row['CAT_NAME'],
            'c_alias'                  => $row['CAT_ALIAS'],
            'item_title'               => $row['TITLE'],
            'item_alias'               => $row['ALIAS'],
            'item_parents'             => $row['PARENTS'],
            'item_template'            => $row['TEMPLATE'],
            'short_item_content'       => $row['SHORT_CONTENT'],
            'item_content'             => htmlspecialchars($row['CONTENT']),
            'item_publ'                => $row['PUBLIC'],
            'item_comments'            => $row['COMMENTS'],
            'item_meta_title'          => $row['META_TITLE'],
            'item_meta_desc'           => $row['META_DESC'],
            'item_meta_keywords'       => $row['META_KEYWORDS'],
            'item_tags'                => $row['TAGS'],
            'item_article'             => $row['ARTICLE'],
            'item_price_opt'           => $row['PRICE_OPT'],
            'item_price'               => $row['PRICE'],
            'item_price_new'           => $row['PRICE_NEW'],
            'item_quantity'            => $row['QUANTITY'],
            'new_images'               => $row['NEW_IMAGES'],
            'images'                   => $row['IMAGES'],
            'files'                    => $row['FILES'],
            'skin'                     => $row['SKIN'],
            'item_other1'              => $row['OTHER1'],
            'item_other2'              => $row['OTHER2'],
            'item_other3'              => $row['OTHER3'],
            'item_other4'              => $row['OTHER4'],
            'item_other5'              => $row['OTHER5'],
            'item_other6'              => $row['OTHER6'],
            'item_other7'              => $row['OTHER7'],
            'item_other8'              => $row['OTHER8'],
            'item_other9'              => $row['OTHER9'],
            'item_other10'             => $row['OTHER10'],
            'item_file1'               => $row['FILE1'],
            'item_file2'               => $row['FILE2'],
            'item_file3'               => $row['FILE3'],
            'item_file1_name'          => $row['FILE1_NAME'],
            'item_file2_name'          => $row['FILE2_NAME'],
            'item_file3_name'          => $row['FILE3_NAME'],
            'item_manufacturer'        => $row['MANUFACTURER_ID'],
            'manufacturers'            => $this->GetManufacturers(),
            'options'                  => $options,
            'item_options'             => $this->GetProductOptions($this->id),
            'item_model'               => $row['MODEL'],
            'item_country'             => $row['COUNTRY'],
            'products'                 => $this->getItems(false,0,0),
            'item_links'               => explode(',',$row['LINKS']),
            'item_video'               => $row['VIDEO'],
        ));
        $this->content = $this->SetTemplate('item.tpl');
    }

    public function SaveManufacturer(){
        $MANUFACTURER_NAME = $this->post['MANUFACTURER_NAME'];
        $MANUFACTURER_DESC = $this->post['MANUFACTURER_DESC'];
        $MANUFACTURER_META_TITLE = $this->post['MANUFACTURER_META_TITLE'];
        $MANUFACTURER_META_DESC = $this->post['MANUFACTURER_META_DESC'];
        $MANUFACTURER_META_KEYWORDS = $this->post['MANUFACTURER_META_KEYWORDS'];
        if (isset($this->id)){
            $sql = "UPDATE `agcms_manufacturer` SET
                `MANUFACTURER_NAME` = '$MANUFACTURER_NAME',
                `MANUFACTURER_DESC` = '$MANUFACTURER_DESC',
                `MANUFACTURER_META_TITLE` = '$MANUFACTURER_META_TITLE',
                `MANUFACTURER_META_DESC` = '$MANUFACTURER_META_DESC',
                `MANUFACTURER_META_KEYWORDS` = '$MANUFACTURER_META_KEYWORDS'
                 WHERE `MANUFACTURER_ID` = $this->id";
            $query = $this->db->query($sql);

        } else{
            $sql = "INSERT INTO `agcms_manufacturer` (
            `MANUFACTURER_NAME`,`MANUFACTURER_DESC`, `MANUFACTURER_META_TITLE`, `MANUFACTURER_META_DESC`, `MANUFACTURER_META_KEYWORDS`)
            VALUES
            ('$MANUFACTURER_NAME','$MANUFACTURER_DESC','$MANUFACTURER_META_TITLE','$MANUFACTURER_META_DESC', '$MANUFACTURER_META_KEYWORDS')";
                $query = $this->db->query($sql);
            $this->id = $this->db->last_id();
        }
        //$this->Head("?c=shop&act=manufacturer&id=".$this->id);
        $this->Head("?c=shop&act=manufacturer");
    }

    function GetManufacturer(){
        $id = $this->id;
        $sql = "SELECT * FROM `agcms_manufacturer` WHERE MANUFACTURER_ID = $id LIMIT 1";
        $query = $this->db->query($sql);
        $manufacturer = $this->db->fetch_array($query);
        return $manufacturer;
    }

    function GetManufacturers(){
        $id = $this->id;
        $sql = "SELECT * FROM `agcms_manufacturer`";
        $query = $this->db->query($sql);
        $manufacturers = $this->db->fetch_all($query);
/*        for ($i=0; $i < $this->db->num_rows($query); $i++) {
            $row = $this->db->fetch_array($query);
            $manufacturers[] = $row;
        }*/
        return $manufacturers;
    }

    public function ShowManufacturers(){
        $this->assign(array(
            'manufacturers' => $this->GetManufacturers()
        ));
        $this->content = $this->SetTemplate('manufacturer.tpl');
    }
    public function ShowManufacturer(){
        $this->assign(array(
            'manufacturer' => $this->GetManufacturer()
        ));
        $this->content = $this->SetTemplate('manufacturer-item.tpl');
    }
    public function DeleteManufacturer(){
        $id = $this->id;
        $sql = "DELETE FROM `agcms_manufacturer` WHERE MANUFACTURER_ID=$id";
        $query = $this->db->query($sql);
        $this->Head("?c=shop&act=manufacturer");
    }
    public function SaveOption(){
        $OPTION_NAME = $this->post['OPTION_NAME'];
        if (isset($this->id)){
            $sql = "UPDATE `agcms_options` SET
                `OPTION_NAME` = '$OPTION_NAME'
                 WHERE `OPTION_ID` = $this->id";
            $query = $this->db->query($sql);

        } else{
            $sql = "INSERT INTO `agcms_options` (
            `OPTION_NAME`)
            VALUES
            ('$OPTION_NAME')";
            $query = $this->db->query($sql);
            $this->id = $this->db->last_id();
        }
        if (isset($this->post["OPTION_PARAMETER"]) && $this->post["OPTION_PARAMETER"]!==''){
            $p = $this->post["OPTION_PARAMETER"];
            $id = $this->id;
            $sql = "INSERT INTO `agcms_options_parameter` (
            `PARAMETER`, `OPTION_ID`)
            VALUES
            ('$p','$id')";
            $query = $this->db->query($sql);
        }
        $this->Head("?c=shop&act=options&id=".$this->id);
    }
    function GetOptions(){
        $id = $this->id;
        $sql = "SELECT * FROM `agcms_options` ORDER BY `POSITION`,`OPTION_ID`";
        $query = $this->db->query($sql);
        $options = $this->db->fetch_all($query);
/*        for ($i=0; $i < $this->db->num_rows($query); $i++) {
            $row = $this->db->fetch_array($query);
            $options[] = $row;
        }*/
        return $options;
    }
    public function ShowOptions(){
        $this->assign(array(
            'options' => $this->GetOptions()
        ));
        $this->content = $this->SetTemplate('options.tpl');
    }
    function GetOption(){
        $id = $this->id;
        $sql = "SELECT * FROM `agcms_options` WHERE OPTION_ID = $id LIMIT 1";
        $query = $this->db->query($sql);
        $option = $this->db->fetch_array($query);
        return $option;
    }
    function GetOptionParams($id){
        $sql = "SELECT * FROM `agcms_options_parameter` WHERE OPTION_ID = $id";
        $query = $this->db->query($sql);
        $params = $this->db->fetch_all($query);
/*        for ($i=0; $i < $this->db->num_rows($query); $i++) {
            $row = $this->db->fetch_array($query);
            $params[] = $row;
        }*/
        return $params;
    }
    public function ShowOption(){
        $option = $this->GetOption();
        $params = $this->GetOptionParams($option['OPTION_ID']);
        $this->assign(array(
            'option' =>$option,
            'params' =>$params,
        ));
        $this->content = $this->SetTemplate('options-item.tpl');
    }
    public function DeleteOption(){
        $id = $this->id;
        $sql = "DELETE FROM `agcms_options` WHERE OPTION_ID=$id";
        $query = $this->db->query($sql);
        $sql = "DELETE FROM `agcms_options_parameter` WHERE OPTION_ID=$id";
        $query = $this->db->query($sql);
        $this->Head("?c=shop&act=options");
    }
    public function SaveOptionParam(){
        $name = $this->post['PARAM_NAME'];
        $id = $this->post['PARAM_ID'];
        $option_id = $this->get['id'];
        $sql = "UPDATE `agcms_options_parameter` SET `PARAMETER`='$name' WHERE ID = $id";
        $query = $this->db->query($sql);
        $this->Head("?c=shop&act=options&id=$option_id");
    }
    function DeleteOptionParam(){
        $param_id = $this->get['param_id'];
        $id = $this->get['id'];
        $sql = "DELETE FROM `agcms_options_parameter` WHERE ID=$param_id";
        $query = $this->db->query($sql);

    }
    public function SaveOptionsSort(){
        if ($this->post["blocks_sort"]!==''){
            $list = explode(';', $this->post["blocks_sort"]);
            foreach ($list as $k=>$v){
                if ($v=='') continue;
                $sql = "UPDATE `agcms_options` SET `POSITION`=$k WHERE `OPTION_ID` = $v";
                $query = $this->db->query($sql);
            }
        }
        $this->Head("?c=shop&act=options");
    }
    public function ShowImport(){
        $this->content = $this->SetTemplate('import.tpl');
    }
    public function GetProductFromArray($products,$article){
        $result = array();
        foreach ($products as $p){
            if ($p['ARTICLE']==$article){
                $result = $p;
                break;
            }
        }
        return $result;
    }
    public function ImportUpdate(){
        if (isset($_FILES)){
            $products = $this->getItems(false,0,0);
            $sql = "UPDATE `agcms_shop_i` SET `QUANTITY`='0'";
            $this->db->query($sql);
            $i = 0;
            foreach($_FILES as $f){
                if (is_uploaded_file($f["tmp_name"])) {
                    $file = file($f["tmp_name"]);
                    foreach ($file as $str){
                        $arr = explode(';',$str);
                        $article = preg_replace('/(^"|"$)/ ', '', $arr[1]);
                        $price1 = preg_replace('/(^"|"$)/ ', '', $arr[3]);
                        $price2 = preg_replace('/(^"|"$)/ ', '', $arr[9]);
                        $quantity = preg_replace('/(^"|"$)/ ', '', $arr[13]);

                        $product = $this->GetProductFromArray($products,$article);
                        if (count($product)>0){
                            /*if ($product['PRICE_OPT']!==$price1 || $product['PRICE']!==$price2 || $product['QUANTITY']!==$quantity){*/
                                $id = $product['ID'];
                                $sql = "UPDATE `agcms_shop_i` SET `PRICE_OPT` = '$price1',`PRICE` = '$price2',`QUANTITY`='$quantity' WHERE `ID`=$id";
                                $this->db->query($sql);
                                $i++;
                        /*}*/
                        }
                    }
                }
            }
        }
        $_SESSION['alert'] = "Обновлено позиций: $i";
        $this->Head("?c=shop");
    }
    public function SaveDelivery(){
        $DELIVERY_NAME = $this->db->input($this->post['DELIVERY_NAME']);
        $DELIVERY_DESC = $this->db->input($this->post['DELIVERY_DESC']);
        $DELIVERY_PRICE = $this->db->input($this->post['DELIVERY_PRICE']);
        if (isset($this->id)){
            $sql = "UPDATE `agcms_delivery` SET
                `DELIVERY_NAME` = '$DELIVERY_NAME',
                `DELIVERY_DESC` = '$DELIVERY_DESC',
                `DELIVERY_PRICE` = '$DELIVERY_PRICE'
                 WHERE `DELIVERY_ID` = $this->id";
            $query = $this->db->query($sql);

        } else{
            $sql = "INSERT INTO `agcms_delivery` (
            `DELIVERY_NAME`,`DELIVERY_DESC`, `DELIVERY_PRICE`)
            VALUES
            ('$DELIVERY_NAME','$DELIVERY_DESC','$DELIVERY_PRICE')";
            $query = $this->db->query($sql);
            $this->id = $this->db->last_id();
        }
        $this->Head("?c=shop&act=delivery");
    }

    function GetDelivery(){
        $id = $this->id;
        $sql = "SELECT * FROM `agcms_delivery` WHERE `DELIVERY_ID` = $id LIMIT 1";
        $query = $this->db->query($sql);
        $result = $this->db->fetch_array($query);
        return $result;
    }

    function GetDeliverys(){
        $result = array();
        $sql = "SELECT * FROM `agcms_delivery`";
        $query = $this->db->query($sql);
        $result = $this->db->fetch_all($query);
/*        for ($i=0; $i < $this->db->num_rows($query); $i++) {
            $row = $this->db->fetch_array($query);
            $result[] = $row;
        }*/
        return $result;
    }
    public function ShowDeliverys(){
        $this->assign(array(
            'deliverys' => $this->GetDeliverys()
        ));
        $this->content = $this->SetTemplate('delivery-list.tpl');
    }
    public function ShowDelivery(){
        $this->assign(array(
            'delivery' => $this->GetDelivery()
        ));
        $this->content = $this->SetTemplate('delivery-item.tpl');
    }
    function GetPays(){
        $result = array();
        $sql = "SELECT * FROM `agcms_shop_pay_systems`";
        $query = $this->db->query($sql);
        for ($i=0; $i < $this->db->num_rows($query); $i++) {
            $row = $this->db->fetch_array($query);
            $system = array(
                'id' => $row['ID'],
                'name' => $row['NAME'],
                'desc' => $row['DESC'],
                'status' => $row['STATUS'],
            );
            $id = $row['ID'];
            $sql = "SELECT * FROM `agcms_shop_pay_methods` WHERE `SYSTEM_ID`='$id' ORDER BY `POSITION`";
            $query2 = $this->db->query($sql);
            $system['pays'] = $this->db->fetch_all($query2);
/*            for ($j=0; $j < $this->db->num_rows($query2); $j++) {
                $row2 = $this->db->fetch_array($query2);
                $system['pays'][] = $row2;
            }*/
            $result[] = $system;

        }
        return $result;
    }
    public function ShowPays(){
        $this->assign(array(
            'pays' => $this->GetPays()
        ));
        $this->content = $this->SetTemplate('pays.tpl');
    }
    public function SavePays(){
        $system = $this->post['ShopPaySystem'];
        $this->config->set('ShopPaySystem',$system);
        $sql = "UPDATE `agcms_shop_pay_methods` SET `STATUS`=0";
        $query = $this->db->query($sql);

        $methods = json_decode($this->post['pays_json']);
        foreach ($methods as $v){
            $method_id = $v->id;
            $price_method = $v->price_method;
            $price_sum = $v->price_sum;
            $price_ed = $v->price_ed;
            $position = $v->position;
            $sql = "UPDATE `agcms_shop_pay_methods` SET `STATUS`=1, `PRICE_METHOD`='$price_method',`PRICE_SUM`='$price_sum', `PRICE_ED`='$price_ed',`POSITION`=$position WHERE `METHOD_ID` = '$method_id' AND `SYSTEM_ID`='$system'";
            $query = $this->db->query($sql);
        }
        $this->Head('?c=shop&act=pays');
    }
    public function Index(){
        $this->SetPlugins();
        $this->page_title = 'Каталог';
        if (isset($this->post['c_title']) && trim($this->post['c_title'])!==''){
            $this->SaveCategory();
        }
        /*добавление/редактирование материала*/
        if (isset($this->post['title']) && trim($this->post['title'])!==''){
            $this->SaveItem();
        }
        if (isset($this->post['save-fields'])){
            $this->SaveFields();
        }
        if (isset($this->post['save-settings'])){
            $this->SaveSettings();
        }
        if (isset($this->post['MANUFACTURER_NAME'])){
            $this->SaveManufacturer();
        }
        if (isset($this->post['DELIVERY_NAME'])){
            $this->SaveDelivery();
        }
        if (isset($this->post['OPTION_NAME'])){
            $this->SaveOption();
        }
        if (isset($this->post['PARAM_NAME'])){
            $this->SaveOptionParam();
        }
        if (isset($this->post["blocks_sort"])){
            $this->SaveOptionsSort();
        }
        if (isset($this->post["ShopPaySystem"])){
            $this->SavePays();
        }
        if (isset($this->post['import'])){
            $this->ImportUpdate();
        }
        $this->categories = $this->getCategories();
        if(count($this->categories) == 0 && !isset($this->act)){
            $this->head('?c=shop&act=new_c');
        }
        $this->structure = Func::getInstance()->getStructure($this->categories);
        $this->ShowMenu();


        if ($this->act == 'fields'){
            $this->content = $this->SetTemplate('item-fields-settings.tpl');
        }
        elseif ($this->act == 'manufacturer'){
            if (isset($this->act2) && $this->act2 == 'add'){
                $this->content = $this->SetTemplate('manufacturer-item.tpl');
            }
            elseif (isset($this->act2) && $this->act2 == 'del'){
                $this->DeleteManufacturer();
            }
            elseif(isset($this->id)){
                $this->ShowManufacturer();
            }
            else{
                $this->ShowManufacturers();
            }
        }
        elseif ($this->act == 'delivery'){
            if (isset($this->act2) && $this->act2 == 'add'){
                $this->content = $this->SetTemplate('delivery-item.tpl');
            }
            elseif (isset($this->act2) && $this->act2 == 'del'){
                $this->DeleteDelivery();
            }
            elseif(isset($this->id)){
                $this->ShowDelivery();
            }
            else{
                $this->ShowDeliverys();
            }
        }
        elseif ($this->act == 'pays'){
            if (isset($this->act2) && $this->act2 == 'add'){
                $this->content = $this->SetTemplate('delivery-item.tpl');
            }
            elseif (isset($this->act2) && $this->act2 == 'del'){
                $this->DeleteDelivery();
            }
            elseif(isset($this->id)){
                $this->ShowDelivery();
            }
            else{
                $this->ShowPays();
            }
        }
        elseif ($this->act == 'import'){
            $this->ShowImport();
        }
        elseif ($this->act == 'options'){
            if (isset($this->act2) && $this->act2 == 'add'){
                $this->content = $this->SetTemplate('options-item.tpl');
            }
            elseif (isset($this->act2) && $this->act2 == 'del'){
                $this->DeleteOption();
            }
            elseif (isset($this->act2) && $this->act2 == 'del-param'){
                $this->DeleteOptionParam();
            }
            elseif(isset($this->id)){
                $this->ShowOption();
            }
            else{
                $this->ShowOptions();
            }

        }
        elseif ($this->act == 'settings'){
            $this->assign(array(
                'templates_comment_form'      => $this->func->getTemplates($this->templates_dir.'comments/form/'),
                'templates_comment_view'      => $this->func->getTemplates($this->templates_dir.'comments/view/'),
                'pays'                        => $this->pay_system,
            ));
            $this->content = $this->SetTemplate('settings.tpl');
        }
        elseif ($this->act == 'new_c'){
            $this->ShowNewCat();
        }
        elseif ($this->act == 'new'){
            $this->ShowNewItem();
        }
        elseif ($this->act == 'del'){
            $this->DeleteCategory($this->cid);

        }
        elseif ($this->act == 'del-item'){
            $this->DeleteItem($this->id);
            $this->Head("?c=shop&cid=$this->cid");
        }
        elseif (!isset($this->act) && isset($this->cid) && !isset($this->id)){
            $this->ShowItems($this->cid);
        }
        elseif ($this->act == 'edit' && isset($this->cid) && $this->cid!==''){
            $row = $this->getCategory($this->cid);
            $this->ShowCategory($row);
        }
        elseif (isset($this->id)){

            $this->ShowItem();
        }
        else {
            $this->ShowItems();
        }
        return $this->content;
    }




}
?>