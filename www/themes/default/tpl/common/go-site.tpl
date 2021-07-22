<div class="modal fade" id="go-site-modal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h3 class="modal-title"><i class="fa fa-ban"></i> Переход на внешний сайт</h3>
            </div>
            <div class="modal-body clearfix">
                <h4>Вы действительно хотите перейти на сайт <span class="go-site-url"></span>?</h4>
                <p style="font-weight: bold">Мы не ручаемся за их допропорядочность!</p>
                <div class="alert alert-info">
                    <p><span style="font-weight: bold">На нашем сайте самые лучшие цены и грамотные специалисты.</span>
                        Не тратьте время на поиск исполнителей. <span style="font-weight: bold"><a
                                    href="/contacts">Закажите сайт у нас!</a></span></p>
                    <p>Мы подойдем к вашему заказу индивидуально. У многих фирм по разработке сайтов общение с клиентами поставлено на поток. Они общаются, основываясь на специальных шаблонах.</p>
                    <p style="font-weight: bold">Мы же подходим к клиенту сугубо индивидуально и искренне заинтересованы в том, чтобы ваш сайт приносил вам хороший доход!</p>
                    <p><a target="_blank" class="go-site-url-p" href="#">Да, я хочу перейти на сайт <span class="go-site-url"></span></a> &nbsp;&nbsp;&nbsp;<button type="button" class="btn btn-success" data-dismiss="modal">Нет, закрыть окно</button></p>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $(".go-site").click(function(e){
        e.preventDefault();
        var url = $(this).data('url');
        var url_p = '/go.php?url=http://' + url;
        $(".go-site-url").text(url);
        $(".go-site-url-p").attr('href', url_p);
        $("#go-site-modal").modal('show');
    });
</script>