<?php
function print_latest_news ($params, &$smarty) {
    $items = array();
    if (isset($params['count'])){
        $db = Database::getInstance();
        $count = $params['count'];
        $sql = "SELECT * FROM `".db_pref."news_i` WHERE `PUBLIC`=1 ORDER BY ID DESC LIMIT $count";
        $query = $db->query($sql);
        if ($db->num_rows($query) > 0){
            for ($i=0; $i < $db->num_rows($query); $i++) {
                $row = $db->fetch_array($query);

                $items[] = $row;
            }
        }
    }

    $smarty->assign('latest_news_items',$items);
}
Smart::getInstance()->register_function("latest_news", "print_latest_news");


?>