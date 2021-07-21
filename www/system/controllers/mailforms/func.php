<?php

function MailFormCreateXML($FileName){
    $dom = new DomDocument('1.0');
    $root = $dom->appendChild($dom->createElement('Forms'));
    $root->appendChild($dom->createElement('Index','0'));
    $dom->formatOutput = true;
    $dom->save($FileName);
}

function AddForm($FileName, $Name, $Email1,$Email2, $Captcha, $SuccessMessage){
    $xml = new SimpleXMLElement($FileName, null, true);
    $index = (int)$xml->Index + 1;
    $xml->Index = $index;
    $form = $xml->addChild('Form');
    $form->addChild('ID', $index);
    $form->addChild('Name', $Name);
    $form->addChild('Email1', $Email1);
    $form->addChild('Email2', $Email2);
    $form->addChild('Captcha', $Captcha);
    $form->addChild('SuccessMessage', $SuccessMessage);
    $fields = $form->addChild('Fields', '');
    $fields->addChild('Index', 0);
    $xml->saveXML($FileName);
    return $index;
}


function UpdateForm($FileName, $ID,$Name, $Email1, $Email2, $Captcha, $SuccessMessage){
    $xml = new SimpleXMLElement($FileName, null, true);
    foreach ($xml->Form as $form) {
        if ((int)$form->ID==(int)$ID){
            $form->Name = $Name;
            $form->Email1 = $Email1;
            $form->Email2 = $Email2;
            $form->Captcha = $Captcha;
            $form->SuccessMessage = $SuccessMessage;
            break;
        }
    }
    $xml->saveXML($FileName);
}

function RemoveForm($FileName, $ID){
    $dom_xml= new DomDocument();
    $dom_xml->loadXML(file_get_contents($FileName));
    $root = $dom_xml->documentElement;
    $mod=$root->getElementsByTagName("Form");
    Foreach ($mod as $k=>$element){
        if ($element->getElementsByTagName("ID")->item(0)->nodeValue == $ID){
            $root->removeChild($element);
            break;
        }
    }
    $dom_xml->save($FileName);
}

function GetForms($FileName){
    if (!file_exists($FileName)){
        MailFormCreateXML($FileName);
    }
    $r = array();
    $xml = new SimpleXMLElement($FileName, null, true);
    foreach ($xml->Form as $form){
        $r[] = array(
            'id'             => (int)$form->ID,
            'name'           => (string)$form->Name,
            'email1'         => (string)$form->Email1,
            'email2'         => (string)$form->Email2,
            'captcha'        => (int)$form->Captcha,
            'successMessage' => (string)$form->SuccessMessage,
        );
    }
    return $r;
}
function GetForm($FileName, $id){
    $r = array();
    $xml = new SimpleXMLElement($FileName, null, true);
    foreach ($xml->Form as $form){
        if ((int)$id == (int)$form->ID){
            $r = array(
                'id'             => (int)$form->ID,
                'name'           => (string)$form->Name,
                'email1'         => (string)$form->Email1,
                'email2'         => (string)$form->Email2,
                'captcha'        => (int)$form->Captcha,
                'successMessage' => (string)$form->SuccessMessage,
            );
            break;
        };
    }
    return $r;
}
function AddField($FileName, $ID, $Name, $Type, $Placeholder, $Required, $Options){
    $xml = new SimpleXMLElement($FileName, null, true);
    foreach ($xml->Form as $form) {
        if ((int)$form->ID==(int)$ID){
            $index = (int)$form->Fields->Index + 1;
            $form->Fields->Index = $index;
            $field = $form->Fields->addChild('Field');
            $field->ID = $index;
            $field->Name = $Name;
            $field->Type = $Type;
            $field->Placeholder = $Placeholder;
            $field->Required = $Required;
            $list = $field->addChild("Options");
            if ($Options){
                foreach ($Options as $o){
                    $list->addChild('Option',$o);
                }
            }
            break;
        }
    }
    $xml->saveXML($FileName);
}

function UpdateField($FileName, $FID, $ID, $Name, $Type, $Placeholder, $Required, $Options){
    $xml = new SimpleXMLElement($FileName, null, true);
    foreach ($xml->Form as $form) {
        if ((int)$form->ID==(int)$FID){
            foreach ($form->Fields->Field as $field){
                if ((int)$field->ID == $ID){
                    $field->Name = $Name;
                    $field->Type = $Type;
                    $field->Placeholder = $Placeholder;
                    $field->Required = $Required;
                    $field->Options = NUll;
                    if ($Options){
                        foreach ($Options as $o){
                            $field->Options->addChild('Option',$o);
                        }
                    }
                    break;
                }
            }
        }
    }
    $xml->saveXML($FileName);
}

function GetFields($FileName, $id){
    $r = array();
    $xml = new SimpleXMLElement($FileName, null, true);
    foreach ($xml->Form as $form){
        if ((int)$id == (int)$form->ID){
            foreach ($form->Fields->Field as $field){
                $options = array();
                $options_ = $field->Options->Option;
                if ($options_){
                    foreach ($options_ as $o){
                        $options[] = (string)$o;
                    }
                }
                $r[] = array(
                    'id'               => (int)$field->ID,
                    'name'             => (string)$field->Name,
                    'type'             => (string)$field->Type,
                    'placeholder'      => (string)$field->Placeholder,
                    'required'         => (string)$field->Required,
                    'options'          => $options,
                );
            }
            break;
        };
    }
    return $r;
}

function GetField($FileName, $fid, $id){
    $r = array();
    $xml = new SimpleXMLElement($FileName, null, true);
    foreach ($xml->Form as $form){
        $options = array();
        if ((int)$fid == (int)$form->ID){
            foreach ($form->Fields->Field as $field){
                if ((int)$field->ID == $id){
                    $options_ = $field->Options->Option;
                    if ($options_){
                        foreach ($options_ as $o){
                            $options[] = (string)$o;
                        }
                    }
                    $r = array(
                        'id'               => (int)$field->ID,
                        'name'             => (string)$field->Name,
                        'type'             => (string)$field->Type,
                        'placeholder'      => (string)$field->Placeholder,
                        'required'         => (string)$field->Required,
                        'options'          => $options,
                    );
                }

            }
            break;
        };
    }
    return $r;
}

function RemoveField($FileName, $FID, $ID){
    $dom_xml= new DomDocument();
    $dom_xml->loadXML(file_get_contents($FileName));
    $root = $dom_xml->documentElement;
    $mod=$root->getElementsByTagName("Form");

    Foreach ($mod as $element){
        if ($element->getElementsByTagName("ID")->item(0)->nodeValue == $FID){
            $mod_t = $element->getElementsByTagName("Fields");
            $mod2 = $mod_t->item(0)->getElementsByTagName("Field");
            Foreach ($mod2 as $element2){
                if ($element2->getElementsByTagName("ID")->item(0)->nodeValue == $ID){
                    $el = $element->getElementsByTagName("Fields")->item(0);
                    $el->removeChild($element2);
                }
            }
            break;
        }
    }
    $dom_xml->save($FileName);
}

?>