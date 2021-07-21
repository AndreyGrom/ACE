<?php

class Analysis {
    public $url;
    private  $is_ssl;
    private  $proto = '';
    private  $domain;
    private  $html_encoding;
    private  $success_count = 0;
    private  $error_count = 0;
    private  $headers;
    private  $robots;
    public function __construct() {
        $this->old_tags = array(
            'applet' => 'Добавляет Java-апплет в документ. Вместо него следует использовать &lt;embed&gt; или &lt;object&gt;',
            'acronym' => 'Этот тег вызывал постоянные вопросы, что такое акроним и чем он отличается от  аббревиатуры. Для упрощения остался единственный тег &lt;abbr&gt;',
            'bgsound' => 'Определяет музыкальный файл, который будет проигрываться на веб-странице при  её открытии. Для воспроизведения музыки используйте новый элемент &lt;audio&gt;',
            'dir' => 'Создает список, содержащий названия директорий, вместо него используйте &lt;ul&gt;',
            'frame' => 'Фреймы более не  поддерживаются. Если они вам требуются, используйте другую версию HTML или &lt;iframe&gt; совместно со стилями',
            'frameset' => 'Фреймы более не  поддерживаются. Если они вам требуются, используйте другую версию HTML или &lt;iframe&gt; совместно со стилями',
            'noframe' => 'Фреймы более не  поддерживаются. Если они вам требуются, используйте другую версию HTML или &lt;iframe&gt; совместно со стилями',
            'isindex' => 'Предназначен для поискового индекса в текущем документе. Комбинация  &lt;form&gt; и &lt;input&gt; лучше справляется с этой задачей',
            'listing' => 'Для вывода листинга программы  предназначены &lt;pre&gt; и &lt;code&gt;',
            'xmp' => 'Для вывода листинга программы  предназначены &lt;pre&gt; и &lt;code&gt;',
            'nextid' => 'Этот тег не предназначен для людей и указывает  идентификатор следующего документа для автоматических редакторов HTML. Полностью исключён',
            'noembed' => 'Предназначен для отображения информации на  веб-странице, если браузер не поддерживает работу с плагинами. В качестве  альтернативы используйте &lt;object&gt;',
            'plaintext' => 'Отображает  содержимое контейнера «как есть», любые теги выводятся как текст. Вместо тега  используйте MIME-тип text/plain',
            'rb' => 'Определяет базовый текст внутри &lt;ruby&gt;. Этот тег полностью исключён',
            'strike' => 'Для зачёркнутого текста применяется &lt;s&gt;, а для указания редакторской  правки &lt;del&gt;',
            'basefont' => 'Вместо этого тега применяются стили',
            'big' => 'Вместо этого тега применяются стили',
            'blink' => 'Вместо этого тега применяются стили',
            'center' => 'Вместо этого тега применяются стили',
            'font' => 'Вместо этого тега применяются стили',
            'marquee' => 'Вместо этого тега применяются стили',
            'multicol' => 'Вместо этого тега применяются стили',
            'nobr' => 'Вместо этого тега применяются стили',
            'spacer' => 'Вместо этого тега применяются стили',
            'tt' => 'Вместо этого тега применяются стили',
            'u' => 'Вместо этого тега применяются стили',
        );
    }

    function GetOldTags(){
        $result = array();
        foreach ($this->old_tags as $k => $t){
            $result[] = $k;
        }
        return $result;
    }

    function GetPage($url) {
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL,$url);
        curl_setopt($ch, CURLOPT_USERAGENT, 'Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.130 Safari/537.36');
        curl_setopt($ch, CURLOPT_RETURNTRANSFER,1);
        //curl_setopt ($ch, CURLOPT_FOLLOWLOCATION, 1);
        $result=curl_exec ($ch);
        curl_close ($ch);
        return $result;
    }

    function GetHeaders($url){
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_HEADER, true);
        curl_setopt($ch, CURLOPT_NOBODY, true);
        curl_setopt($ch, CURLOPT_ENCODING, 'gzip');
        curl_setopt($ch, CURLOPT_URL,$url);
        curl_setopt($ch, CURLOPT_USERAGENT, 'Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.130 Safari/537.36');
        curl_setopt($ch, CURLOPT_RETURNTRANSFER,1);
        curl_setopt ($ch, CURLOPT_FOLLOWLOCATION, 1);
        $result=curl_exec ($ch);
        curl_close ($ch);
        return $result;
    }

    function str_replace_once($search, $replace, $text)
    {
        $pos = strpos($text, $search);
        return $pos!==false ? substr_replace($text, $replace, $pos, strlen($search)) : $text;
    }

    public function Run(){
        $result = array();
        include_once('simple_html_dom.php');
        $url =  parse_url($this->url);
        //$this->domain = $this->str_replace_once('www.', '', $url['path']);
        $this->domain = $url['path'];
        if (strpos($this->url, 'https://') !== false){
            $this->is_ssl = 1;
            $this->proto = 'https://';
        } else {
            $this->proto = 'http://';
        }
        //$this->url = $this->str_replace_once('https://', '', $this->url);
        //$this->url = $this->str_replace_once('http://', '', $this->url);
        //$this->current_url .= $this->url;
        $result['proto'] = $this->proto;
        if ($data = $this->GetPage($this->url)){
            $html = str_get_html($data);
            $this->html_encoding = mb_detect_encoding($data);

            // соотношение Текст/HTML
            $data = str_replace(array("\r", "\n"), '', $data);
            $data = preg_replace("/ +/", " ", $data);
            $result['html_info']['length'] = mb_strlen($data, $this->html_encoding);
            $result['html_info']['length_plain'] = mb_strlen(strip_tags($data), $this->html_encoding);
            $result['html_info']['ratio']['ratio'] = round(($result['html_info']['length_plain']/$result['html_info']['length'])*100);
            if ($result['html_info']['ratio']['ratio'] > 15){
                $result['html_info']['ratio']['success'][] = 'Соотношение текста в коде HTML между 15 и 70 процентов';
            } else {
                $result['html_info']['ratio']['errors'][] = 'Соотношение текста в коде HTML меньше 15 процентов';
            }

            unset($data);


            if ($h = $html->find('html')){
                $result['html_info']['count'] = count($h);
                if (count($h) > 1){ // Больше одного html
                    $result['html_info']['errors'][] = 'Больше одного тега html';
                    $this->error_count ++;
                } else {
                    $this->success_count ++;
                }
                if (isset($h[0]->lang)){ // задан язык страницы
                    $result['html_info']['lang'] = $h[0]->lang;
                    $this->success_count ++;
                    $result['html_info']['success'][] = 'Задан язык страницы (' . $result['html_info']['lang'] . ')';
                } else { // не задан язык страницы
                    $this->error_count ++;
                    $result['html_info']['errors'][] = 'Не задан язык страницы';
                }

            } else {
                $result['html_info']['errors'][] = 'Не найден корень документа';
                $this->error_count ++;
            }
            unset($h);

            $h = $html->find('title');
            if (count($h) > 0 && $h[0]->innertext !== ''){
                $result['title_info']['count'] = count($h);
                if (count($h) > 1){
                    $result['title_info']['errors'][] = 'Найдено больше одного title';
                }
                $result['title_info']['length'] = mb_strlen($h[0]->innertext, $this->html_encoding);
                if ($result['title_info']['length'] < 10 || $result['title_info']['length'] > 70){
                    $result['title_info']['warnings'][] = 'Длина заголовка ' . $result['title_info']['length'] . ' символов';
                } else {
                    $result['title_info']['success'][] = 'Длина заголовка от 10 до 70' . ' символов';
                }
                $result['title_info']['content'] = $h[0]->innertext;
            } else {
                $result['title_info']['errors'][] = 'Не найден заголовок страницы';
            }
            unset($h);

            $h = $html->find('meta[name=description]');
            if (count($h) > 0 && $h[0]->content !== ''){
                $result['description_info']['length'] = mb_strlen($h[0]->content, $this->html_encoding);
                if ($result['description_info']['length'] < 70 || $result['description_info']['length'] > 160){
                    $result['description_info']['warnings'][] = 'Длина описания ' . $result['description_info']['length'] . ' символов';
                } else {
                    $result['description_info']['success'][] = 'Длина описания от 70 до 160' . ' символов';
                }
                $result['description_info']['content'] = $h[0]->content;
            } else {
                $result['description_info']['errors'][] = 'Не найдено описание страницы';
            }
            unset($h);

            $h = $html->find('meta[name=keywords]');
            if (count($h) > 0 && $h[0]->content !== ''){
                $result['keywords_info']['length'] = mb_strlen($h[0]->content, $this->html_encoding);
                if ($result['keywords_info']['length'] > 250){
                    $result['keywords_info']['warnings'][] = 'Общая длина ключевых слов ' . $result['keywords_info']['length'] . ' символов';
                } else {
                    $result['keywords_info']['success'][] = 'Общая длина ключевых слов меньше 250 символов';
                }
                $result['keywords_info']['content'] = $h[0]->content;
            } else {
                $result['keywords_info']['errors'][] = 'Не найдены ключевые слова';
            }
            unset($h);

            $h = $html->find('meta[property]');
            if (count($h) > 0){
                foreach ($h as $i){
                    if (strpos($i->property,'og:') !== false){
                        $result['og_info']['list'][] = array(
                            'property' => $i->property,
                            'content' =>  $i->content,
                        );
                    }
                }
                if (is_array($result['og_info']['list']) && count($result['og_info']['list']) > 0){
                    $result['og_info']['success'][] = 'На странице используются преимущества Open Graph';
                }
            } else {
                $result['og_info']['errors'][] = 'На странице не используется Open Graph';
            }
            unset($h);

            $tags = array();
            $tags_null = array();
            $h = $html->find('h1, h2, h3, h4, h5, h6');
            if (count($h) > 0){
                foreach ($h as $i){
                    if (trim($i->innertext) !== ''){
                        $tags[$i->tag][] = $i->innertext;
                    } else {
                        $tags_null[$i->tag] = '';
                    }

                }
                $result['h_info']['tags'] = $tags;
                $result['h_info']['tags_null'] = $tags_null;
                if (isset($result['h_info']['tags']['h1'])){
                    if (count($result['h_info']['tags']['h1']) > 1){
                        $result['h_info']['errors'][] = 'На странице обнаружено несколько заголовков H1';
                    } elseif (isset($result['h_info']['tags_null']['h1'])){
                        $result['h_info']['errors'][] = 'На странице присутствует заголовок H1, но в нем нет текста';
                    } else {
                        $result['h_info']['success'][] = 'На странице присутствует заголовок H1';
                    }
                } else {
                    $result['h_info']['errors'][] = 'На странице отсутствует заголовок H1';
                }
            }
            unset($h);


            $h = $html->find('img');
            if (count($h) > 0){
                $result['img_info']['count'] = count($h);
                $result['img_info']['alt'] = 0;
                $result['img_info']['alt_no'] = 0;
                foreach ($h as $i){
                    if (isset($i->alt) && $i->alt !== ''){
                        $result['img_info']['alt'] ++;
                    } else {
                        $result['img_info']['alt_no'] ++;
                    }
                }
                if ($result['img_info']['alt_no'] > 0){
                    $result['img_info']['warnings'][] = 'Найдено ' . $result['img_info']['alt_no'] . ' изображений без атрибута alt';
                } else {
                    $result['img_info']['success'][] = 'Все изображения имеют атрибут alt';
                }
            } else {
                $result['img_info']['success'][] = 'На странице нет изображений';
            }
            unset($h);


            $h = $html->find('object, embed');
            if (count($h) > 0){
                $result['flash_info']['warnings'][] = 'На странице присутствует Flash-контент';
            } else {
                $result['flash_info']['success'][] = 'На странице отсутствует Flash-контент';
            }
            unset($h);

            $h = $html->find('iframe');
            if (count($h) > 0){
                $result['iframe_info']['warnings'][] = 'На странице присутствует ифреймы';
            } else {
                $result['iframe_info']['success'][] = 'На странице отсутствует ифреймы';
            }
            unset($h);

            $h = $html->find('a');
            if (count($h) > 0){
                $link_array = array();
                $link_in = array();
                $link_out = array();
                $link_out_nofollow = array();

                foreach ($h as $i){
                    if (isset($i->href) && $i->href !== ''){
                        $link = parse_url($i->href);
                        if (isset($link['path'])){
                            if (!in_array($i->href,$link_array)){
                                $link_array[] = $i->href;
                                if (isset($link['host']) && $link['host'] !== $this->domain){
                                    $nofollow = false;
                                    if (isset($i->rel) && $i->rel == 'nofollow'){
                                        $link_out_nofollow[] = array(
                                            'text' => $i->innertext,
                                            'href' => $i->href,
                                        );
                                    } else {
                                        $link_out[] = array(
                                            'text' => $i->innertext,
                                            'href' => $i->href,
                                        );
                                    }

                                } else {
                                    $link_in[] = array(
                                        'text' => $i->innertext,
                                        'href' => $i->href,
                                    );
                                };
                            }

                        }

                    }
                }
                $result['links_info']['links'] = $link_array;
                $result['links_info']['links_in'] = $link_in;
                $result['links_info']['links_out'] = $link_out;
                $result['links_info']['links_out_nofollow'] = $link_out_nofollow;
                $result['links_info']['links_ratio_in'] = round((count($link_in)/count($link_array))*100);
                $result['links_info']['links_ratio_out'] = round((count($link_out)/count($link_array))*100);
                $result['links_info']['links_ratio_out_nofollow'] = round((count($link_out_nofollow)/count($link_array))*100);
            } else {
                $result['links_info']['warnings'][] = 'На странице не обнаружено ни одной ссылки';
            }
            unset($h);

            $h = $html->find('link[rel="shortcut icon"]');
            if (count($h) > 0){
                $result['favicon_info']['success'][] = 'На вашем сайте есть favicon';
            } else {
                $result['favicon_info']['warnings'][] = 'На вашем сайте отсутствует favicon';
            }
            unset($h);

            $h = $html->find('meta[charset]');
            if (count($h) > 0){
                $result['charset'] = strtolower($h[0]->charset);
                if ($result['charset'] == 'utf-8'){
                    $result['encoding_info']['success'][] = 'Кодировка сайта UTF-8';
                } else {
                    $result['favicon_info']['warnings'][] = 'Кодировка сайта '. strtoupper($result['encoding_info']);
                }
            } else {
                $result['encoding_info']['errors'][] = 'На странице не задана кодировка';
            }
            unset($h);

            $h = $html->find(implode(',', $this->GetOldTags()));
            if (count($h) > 0){
                foreach ($h as $i){
                    $result['old_tags_info']['tags'][] = array(
                        'tag' =>  $i->tag,
                        'info' =>  $this->old_tags[$i->tag],
                    );
                }
                $result['old_tags_info']['errors'][] = 'Обнаружены устаревшие теги';
            } else {
                $result['old_tags_info']['success'][] = 'Устаревших тегов не обнаружено';
            }
            unset($h);

            $this->headers = $this->GetHeaders($this->url);
            if (strpos($this->headers, 'gzip') === false){
                $result['gzip_info']['warnings'][] = 'Gzip сжатие не используется';
            } else {
                $result['gzip_info']['success'][] = 'На сайте используется gzip сжатие';
            }
            $this->robots = $this->GetPage($this->proto . $this->domain . '/robots.txt');
            //var_dump($this->robots);

        } else {
            $result['errors'][] = 'Не получилось загрузить страницу';
        }
        $result['url'] = $this->url;
        $result['domain'] = $this->domain;

        return $result;
    }

}
?>