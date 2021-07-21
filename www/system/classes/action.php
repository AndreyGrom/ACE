<?php
if (isset($_POST['add-content-block'])){
        $id = $_POST['add-id-content'];
        $lst =  $this->getContentsListFromPage($this->page);
        $lst[]=$id;
        $lst = array_filter($lst);
        $this->ini->write('pages_contents',$this->page, implode(',',$lst));
        $this->ini->updateFile();
        $_SESSION['alert'] = 'Блок добавлен';
        //Header("Location: ".$_SERVER['HTTP_REFERER']);
        $this->Head('?c=content&id='.$id);
        exit;
}

if (isset($_POST['add-design-block'])){
    $id = $_POST['add-id-content'];
    $lst =  $this->getBlockListFromPage($this->page);

    $lst[]=$id;
    $lst = array_filter($lst);
    $this->ini->write('pages_blocks',$this->page, implode(',',$lst));
    $this->ini->updateFile();
    $_SESSION['alert'] = 'Блок добавлен';
    //Header("Location: ".$_SERVER['HTTP_REFERER']);
    $this->Head('?c=blocks&p='.$id);
    exit;
}
?>