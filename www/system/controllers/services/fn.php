<?php
/*function print_other_items_category ($params, &$smarty) {
    $items = array();
    if (isset($params['cid'])){
        $db = Database::getInstance();
        $cid = $params['cid'];
        $sort = isset($params['sort'])?$params['sort']:'DATE_PUBL ASC';
        $sort = "ORDER BY $sort";

        $sql = "SELECT * FROM `agcms_catalog_i` WHERE `PARENT` LIKE '%,$cid,%' AND `PUBLIC`=1 $sort";
        $query = $db->query($sql);
        if ($db->num_rows($query) > 0){
            for ($i=0; $i < $db->num_rows($query); $i++) {
                $row = $db->fetch_array($query);
                $items[] = $row;
            }
        }
    }
    $smarty->assign('items_category',$items);
}
*/
function ServicesGetCategories($params, &$smarty){
    $db = Database::getInstance();
    $source = $params['source'];
    $sql = "SELECT * FROM `agcms_services_i`";
    if (isset($params['id'])){
        $sql .= " WHERE PARENT LIKE '%," . $params['id'] . ",%'";
    }

    $query = $db->query($sql);

    for ($i=0; $i < $db->num_rows($query); $i++) {
        $row = $db->fetch_array($query);
        $categories[] = $row;
    }

    $categories =  Func::getInstance()->getStructure($categories);
    $smarty->assign($source,$categories);
}

/*Smart::getInstance()->register_function("other_items_category", "print_other_items_category");*/
Smart::getInstance()->register_function("services_categories", "ServicesGetCategories");

?>