<?php

class AdminMailformsController extends AdminController {
    public function __construct() {
        parent::__construct();
        $this->categories    = array();
        $this->structure     = array();
        $this->id            = $this->get['id'];
        $this->fid           = $this->get['fid'];
        $this->act           = $this->get['act'];
        $this->act2          = $this->get['act2'];
        $this->form          = '';
        $this->forms         = array();
        $this->fields        = array();
        include_once(dirname( __FILE__  ).'/func.php');
        $this->xml = dirname( __FILE__  ).'/forms.xml';
        $this->types[] = array( 'name' => 'Текстовое',     'type' =>'text');
        $this->types[] = array( 'name' => 'Email',         'type' =>'email');
        $this->types[] = array( 'name' => 'Телефон',       'type' =>'tel');
        $this->types[] = array( 'name' => 'Пароль',        'type' =>'password');
        $this->types[] = array( 'name' => 'Флажок',        'type' =>'checkbox');
        $this->types[] = array( 'name' => 'Опция',         'type' =>'radio');
        $this->types[] = array( 'name' => 'Многострочное', 'type' =>'textarea');
        $this->types[] = array( 'name' => 'Список выбора', 'type' =>'select');
    }

    public function ShowMenu(){
        $this->assign(array(
            'forms'              => $this->forms,
        ));
        $this->widget_left_top .=$this->fetch('menu.tpl');
    }
    public function SaveForm(){
        $name = $_POST['form_name'];
        $email1 = $_POST['email_1'];
        $email2 = $_POST['email_2'];
        $captcha = isset($_POST['captcha']) ? 1 : 0;
        $success_message = $_POST['form_success_message'];
        if (!file_exists($this->xml)){
            MailFormCreateXML($this->xml);
        }
        if ($this->act == 'new'){
            $this->fid = AddForm($this->xml,$name,$email1,$email2,$captcha,$success_message);
        } else {
            UpdateForm($this->xml,$this->fid,$name,$email1,$email2,$captcha,$success_message);
        }
        $this->Head("?c=mailforms&fid=$this->fid");
    }
    public function SaveField(){
        $options = array();
        $name = $this->post['field_name'];
        $type = $this->post['field_type'];
        $placeholder = $this->post['field_placeholder'];
        $required = isset($this->post['field_required']) ? 1 : 0;
        $str = trim($this->post['field_options']);
        if ($str !=='') {
            $options = explode("\r\n",$str);
        }
        if ($this->act == 'field-add'){
            AddField($this->xml,$this->fid,$name,$type,$placeholder,$required,$options);
        } else {
            UpdateField($this->xml,$this->fid,$this->id,$name,$type,$placeholder,$required,$options);
        }
        $this->Head("?c=mailforms&fid=$this->fid&act=fields");
    }

    public function Index(){
        $this->page_title = 'Управление Почтовыми формами';
        $this->forms = GetForms($this->xml);
        $this->ShowMenu();
        if (isset($_POST['form_name'])){
            $this->SaveForm();
        }
        if (isset($this->post['field_name'])){
            $this->SaveField();
        }
        if ($this->act == 'del-form'){
            RemoveForm($this->xml,$this->fid);
            $this->Head("?c=mailforms");
        }
        if ($this->act == 'del-field'){
            RemoveField($this->xml,$this->fid, $this->id);
            $this->Head("?c=mailforms&fid=$this->fid&act=fields");
        }
        if ($this->act == 'new'){
            $this->assign(array(
                'new' => true,
            ));
            $this->content = $this->SetTemplate('new.tpl');
        }

        if (isset($this->fid)){
            $this->form = GetForm($this->xml, $this->fid);
            if ($this->act == 'fields'){
                $this->fields = GetFields($this->xml, $this->fid);
                $this->assign(array(
                    'form'     => $this->form,
                    'fields'   => $this->fields,
                ));
                $this->content = $this->SetTemplate('fields.tpl');
            }
            elseif ($this->act == 'field-add'){
                $this->assign(array(
                    'types'    => $this->types,
                    'form'     => $this->form,
                    'new'      => true,
                ));
                $this->content = $this->SetTemplate('field.tpl');
            }
            elseif ($this->act == 'template'){
                $temp_name = $this->templates_dir . 'mailforms/form'.$this->form['id'].'.tpl';
                if (isset($this->post['template'])){
                    file_put_contents($temp_name,$this->post['template']);
                    $this->Head("?c=mailforms&fid=$this->fid&act=template");
                }
                if (isset($this->get['restruct'])){
                    $this->assign(array(
                        'form_id'      => $this->form['id'],
                        'form'         => $this->form,
                        'form_fields'  => GetFields($this->xml, $this->fid),
                    ));
                    $temp = $this->fetch('temp.tpl');

                    if (!is_dir($this->templates_dir . 'mailforms/')){
                        mkdir($this->templates_dir . 'mailforms/');
                    }
                    file_put_contents($temp_name, $temp);
                    $this->Head("?c=mailforms&fid=$this->fid&act=template");
                }
                $this->js[] = HTML_PLUGINS_DIR.'edit_area/edit_area_full.js';
                $template = htmlspecialchars(@file_get_contents($temp_name));

                $this->assign(array(
                    'form'         => $this->form,
                    'template'     => $template,
                ));
                $this->content = $this->SetTemplate('template.tpl');
            }
            elseif (isset($this->id)){
                $field = GetField($this->xml, $this->fid, $this->id);
                $this->assign(array(
                    'types'        => $this->types,
                    'form'         => $this->form,
                    'field'        => $field,
                    'temp'         => @file_get_contents($this->templates_dir.'/forms/form'.$this->fid.'.tpl'),
                ));
                $this->content = $this->SetTemplate('field.tpl');
            }
            else{
                if (!$this->form){
                    $this->Head("?c=mailforms");
                }
                $this->assign(array(
                    'form_id'              => $this->form['id'],
                    'form_name'            => $this->form['name'],
                    'form_email_1'         => $this->form['email1'],
                    'form_email_2'         => $this->form['email2'],
                    'form_captcha'         => $this->form['captcha'],
                    'form_success_message' => $this->form['successMessage'],
                ));
                $this->content = $this->SetTemplate('new.tpl');
            }
        }

        if ($this->content == ''){
            if (count($this->forms) > 0){
                $this->Head("?c=mailforms&fid=".$this->forms[0]["id"]);
            } else{
                $this->Head("?c=mailforms&act=new");
            }
        }

        return $this->content;
    }
}
?>