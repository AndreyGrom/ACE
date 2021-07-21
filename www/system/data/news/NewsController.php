<?php

class NewsController extends Controller {
    public function __construct($query, $controller) {
        parent::__construct($query, $controller);
        $this->row = array();
        $this->cid = 0;
        $this->c_name = '';
        $this->template = '';
        $this->alias = '';
    }
    public function Index(){
        if (!$this->config->NewsEnabled){
            $message = 'Модуль не активирован!<br/><a href="/">На главную</a>';
            $title = 'Модуль не активирован!';
            return $this->SetSystemPage($title, $message);
        }
        elseif (count($this->query) == 2 && $this->query[1]=='tag'){
            $this->ShowItems();
        }
        elseif (count($this->query)==1 && is_numeric($this->query[0])){
            $this->ShowItem($id = $this->query[0]);
        }
        elseif ($this->query){ // если есть алиас
            $this->alias = end($this->query);
            $this->ShowItem();
        } else {
            $this->ShowItems();
        }
        return $this->content;
    }



    public function ShowItems(){
        $sort = $this->config->NewsItemListSort;
        if (count($this->query) == 2 && $this->query[1]=='tag'){
            $tag = urldecode($this->query[0]);
            $this->c_name = $tag;

            $sql = "SELECT *, @id:=ID, (SELECT COUNT(*) FROM `".db_pref."comments` WHERE `CONTROLLER` = 'news' AND `MATERIAL_ID` = @id) AS COMMENTS_COUNT FROM `".db_pref."news_i`  WHERE `TAGS` LIKE '%,$tag,%' AND `PUBLIC`=1 ORDER BY `DATE_PUBL` $sort";
        } else {
            $sql = "SELECT *, @id:=ID, (SELECT COUNT(*) FROM `".db_pref."comments` WHERE `CONTROLLER` = 'news' AND `MATERIAL_ID` = @id) AS COMMENTS_COUNT FROM `".db_pref."news_i`  WHERE `PUBLIC`=1 ORDER BY `DATE_PUBL` $sort";
        }
        $query = $this->db->query($sql);
        if ($this->db->num_rows($query) > 0){
            for ($i=0; $i < $this->db->num_rows($query); $i++) {
                $row = $this->db->fetch_array($query);
                $row["DATE_PUBL"] = $this->DateFormat($row["DATE_PUBL"]);
                $row["DATE_EDIT"] = $this->DateFormat($row["DATE_EDIT"]);
                if ($row['SKIN']!==''){
                    $row['SKIN_NEW'] = Func::getInstance()->GetImage(UPLOAD_IMAGES_DIR.'news/'.$row['SKIN'], $this->config->NewsImageWidthItemList,$this->config->NewsImageHeightItemList);
                }
                $items[] = $row;
            }

            $this->page_title = $this->c_name;
            $this->assign(array(
                'site_title'       => $this->c_name.' - '. $this->config->SiteTitle,
                'page_title'       => $this->c_name,
                'items'            => $items,
                'c_name'           => $this->c_name,
                'cid'              => $this->cid,
                'desc'             => $this->desc,
                'desc2'            => $this->desc2,
            ));
            $this->SetPath('news/categories/');
            if ($this->template == ''){
                $this->template = 'default_cat_list';
            }
            $this->content = $this->SetTemplate($this->template.'.tpl');
        }
    }

    public function ShowItem($id=0){;
        if ($id > 0){
            $sql = "SELECT * FROM `".db_pref."news_i`  WHERE `ID` = '$id' AND `PUBLIC`=1 LIMIT 1";
        } else {
            $sql = "SELECT * FROM `".db_pref."news_i`  WHERE `ALIAS` = '$this->alias' AND `PUBLIC`=1 LIMIT 1";
        }

        $query = $this->db->query($sql);
        if ($this->db->num_rows($query) > 0){
            $row = $this->db->fetch_array($query);
            $row["DATE_PUBL"] = $this->DateFormat($row["DATE_PUBL"]);
            $row["DATE_EDIT"] = $this->DateFormat($row["DATE_EDIT"]);
            $item = $row;

            $item['CONTENT'] = Func::getInstance()->syntax_filter( $item['CONTENT']);

            $str = $row['TAGS'];
            $tags = explode(",",$str);
            $tags = array_filter($tags);
            sort($tags);

            $files = array();
            $str = $row["FILES"];
            if ($str!==''){
                $files = unserialize($str);
            }


            /*Выбираем похожие материалы*/
            if (count($tags) > 0){
                $sql = "";
                foreach ($tags as $k=>$t){
                    if ($k>0){
                        $sql.= " OR `TAGS` LIKE '%$t%'";
                    } else {
                        $sql.= "`TAGS` LIKE '%$t%'";
                    }
                }
                $sql = "SELECT * FROM `".db_pref."news_i` WHERE `ID` <> ".$item["ID"]." AND ( ".$sql." ) ORDER BY `DATE_EDIT` DESC LIMIT 10";
                $query = $this->db->query($sql);
                for ($i=0; $i < $this->db->num_rows($query); $i++) {
                    $row = $this->db->fetch_array($query);
                    $other_items[] = $row;
                }
            }

            /*///////////////////*/

            if ($this->config->NewsCommentsEnabled && $item['COMMENTS']){
                include_once(dirname(__FILE__).'../../comments/CommentsController.php');
                $comments = new CommentsController($this->query, $this->controller);
                $comments->material_id = $item["ID"];
                $comments->controller = $this->controller;
                $comments->tpl_view = $this->config->NewsCommentsTemplateView.'.tpl';
                $comments->tpl_form = $this->config->NewsCommentsTemplateForm.'.tpl';

                $comments ->Index();
                $this->smarty->assign(array(
                    'comments_form'                 => $comments->comments_form,
                    'comments'                      => $comments->comments,
                ));
                if (count($comments->js) > 0){
                    foreach ($comments->js as $j){
                        $this->js[]=$j;
                    }
                }
                if (count($comments->css) > 0){
                    foreach ($comments->css as $j){
                        $this->css[]=$j;
                    }
                }
            }

            $this->meta_description = $item['META_DESC'];
            $this->meta_keywords = $item['META_KEYWORDS'];
            $this->page_title = $item["TITLE"];
            $this->assign(array(
                'item'             => $item,
                'other_items'      => $other_items,
                'files'            => $files,
                'tags'             => $tags,
                'image'            => $item['SKIN'],
                'image_new'        => Func::getInstance()->GetImage(UPLOAD_IMAGES_DIR.'news/'.$item['SKIN'], 200,120),
            ));

            $this->SetPath('news/items/');
            $this->content = $this->SetTemplate($item['TEMPLATE'].'.tpl');
        }
    }
}
?>