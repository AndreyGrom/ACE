var player,file,el;
var hl= getTop("#player");
var pl_b = jQuery("#player");
var h2=pl_b.height();
if(!!document.createElement('audio').canPlayType){
    player = new Uppod({
        m:"audio",
        uid:"player"
    });
} else {
    jQuery("#player").html('<div class="error_pl">Ваш браузер не поддерживает HTML5! Воспроизведение невозможно!</div>')
}
function pl(f,c){
    jQuery(".play-list li").removeClass("stop");
    if (file!=f){
        file=f;
        player.Play("http://andreygrom.ru/upload/music/"+f+".mp3");
        player.Alert(c);
        el.addClass("stop");
    } else{
        player.Pause();
        file='';
    }
}
function getTop(el){
    var of=jQuery(el).offset();
    return of.top;
}
jQuery(".play-list li").click(function(e){
    e.preventDefault();
    el=jQuery(this);
    pl(el.find("a").attr("rel"),el.find("a").text());
});
jQuery(window).scroll(function(){
    var scroll = jQuery(window).scrollTop();

    if (scroll>=hl){
        pl_b.css({"position":"fixed","width":"940px","top":0});
    } else {
        pl_b.css({"position":"static"});
    }
});