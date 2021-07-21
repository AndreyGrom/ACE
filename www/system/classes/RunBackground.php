<?php
class RunBackground {
    public function __construct() {
        $this->ParamName = 'params_run_background';
        $this->UserAgent = 'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; (R1 1.5))';
        $this->ContentType = 'application/x-www-form-urlencoded';
        $this->AcceptLanguage = 'ru';
        $this->Accept = 'image/gif, image/x-xbitmap, image/jpeg, image/pjpeg, application/x-shockwave-flash, application/vnd.ms-excel, application/msword, */*';
        $this->Host = $_SERVER['HTTP_HOST'];
        $this->Data = array();
        $this->URL = '';
        $this->Params = new stdClass();
        if (isset($_GET[$this->ParamName])){
            $params = json_decode($_GET[$this->ParamName]);
            if (count($params) > 0) {
                foreach ($params as $p){
                   $arr = explode('=',$p);
                   $this->Params[$arr[0]] = $arr[1];
                }
            }
        }
        if (isset($_POST[$this->ParamName])){
            $str = $_POST[$this->ParamName];
            if ( get_magic_quotes_gpc() ) {
                $str = stripslashes( $str );
            }
            //$params = json_decode(iconv('windows-1251','utf-8',$str));
            $this->Params = json_decode($str);

        }
    }

    public function Get(){
        $url = $this->URL;
        if (count($this->Data) > 0){
            $url = $this->URL."?".$this->ParamName."=".json_encode($this->Data, JSON_UNESCAPED_UNICODE);
        }

        $header= "GET ".$url." HTTP/1.0\r\n";
        $header.= "Accept: ".$this->Accept."\r\n";
        $header.= "Accept-Language: ".$this->AcceptLanguage."\r\n";
        $header.= "Content-Type: ".$this->ContentType."\r\n";
        $header.= "User-Agent: ".$this->UserAgent."\r\n";
        $header.= "Host: ".$this->Host."\r\n\r\n";
        $http = fsockopen($this->Host,80, $errno, $errstr, 30);
        fputs($http,$header);
        fclose($http);
    }

    public function Post(){
        $data = '';
        if (count($this->Data) > 0){
            $data = $this->ParamName."=".json_encode($this->Data);
        }
        $header= "POST ".$this->URL." HTTP/1.0\r\n";
        $header.= "Accept: ".$this->Accept."\r\n";
        $header.= "Accept-Language: ".$this->AcceptLanguage."\r\n";
        $header.= "Content-Type: ".$this->ContentType."\r\n";
        $header.= "User-Agent: ".$this->UserAgent."\r\n";
        $header .= "Content-Length: ".strlen($data)."\r\n";
        $header.= "Host: ".$this->Host."\r\n\r\n";

        $http = fsockopen($this->Host,80, $errno, $errstr, 30);
        fwrite($http, $header.$data);

        fputs($http,$header);
        fclose($http);
    }
}
?>