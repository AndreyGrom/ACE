<?php
if ($this->config->siteedit_enabled ) {

    $search = '/\[\$EDIT_BOX_([^>]*)\]/siu';
    $_SERVER['vars_array'] = array();
    $m = array();
    preg_match_all($search, $result, $m);

    if (count($m[0]) > 0) {
        for ($i=0;$i<count($m[0]);$i++){
            $_SERVER['vars_array'][] = $m[1][$i];
        }
    }

    if (count($_SERVER['vars_array']) > 0){
        $vars_array_str = implode(',',$_SERVER['vars_array']);

        $_SERVER['vars_array'] = array();
        $sql = "SELECT * FROM `".db_pref."siteedit_vars` WHERE ID IN ($vars_array_str)";
        $query = $this->db->query($sql);
        if ($this->db->num_rows($query) > 0){
            $_SERVER['vars_array'] = $this->db->fetch_all($query);
        }
    }

    if (isset($_SESSION['admin'])){
        if (count($_SERVER['vars_array']) > 0){
            $result = preg_replace_callback($search, 'GetVarsCallback2', $result);
            $client = @file_get_contents(CONTROLLERS_DIR.'siteedit/client/footer.tpl');
            $result = str_replace('</body>', $client."\r\n</body>",$result);
            $css = '<link href="'.HTML_CONTROLLERS_DIR.'siteedit/client/style.css" rel="stylesheet">';
            $result = str_replace('</head>', $css."\r\n</head>",$result);
        }
    } else {
        if (count($_SERVER['vars_array']) > 0){
              $result = preg_replace_callback($search, 'GetVarsCallback', $result);
        }
    }
}

function GetVarsCallback($data) {
    $res = '';
    foreach ($_SERVER['vars_array'] as $var){
        if ($var['ID'] == $data[1]){
            $res = $var['HTML'];
            break;
        }
    }
    return $res;
}

function GetVarsCallback2($data) {
    $res = '';
    foreach ($_SERVER['vars_array'] as $var){
        if ($var['ID'] == $data[1]){
            $res = $var['HTML'];
            if ($var['TAG'] == 'img'){
                $res .= '?id='.$var['ID'].'&tag='.$var['TAG'];
            } else {
                $res = '<i class="siteedit-info" style="display:none;" data-id="'.$var['ID'].'" data-tag="'.$var['TAG'].'"></i>'.$res;

            }

            break;

        }
    }
    return $res;
}
?>