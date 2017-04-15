<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Trashpoints</title>
</head>

<body>

<main>

    <div id="banner-index" class="blue-gradient full-height itens-center">
        <div id="banner-image">
            <img src="${resource(dir: 'images', file: 'trashPoints_logo_index_alpha.png')}" style="width: 100%;">
        </div>
        <div id="banner-text">
            <h5 class="white-text center-align">Sistema voltado para gestão de coleta de lixo reciclável.</h5>
        </div>
    </div>

    <div class="section">
        <div class="container">

            <div class="row">
                <div class="col s12 m12 l12">
                    <div class="card-panel white hoverable">
                        <h5 class="bold indigo-text text-accent-1 uppercase">O que é o sistema Trashpoints?</h5>
                        <hr style="border-color: rgba(140, 158, 255, 0.57) !important;" />
                        <p style="text-align: justify; text-indent: 4ch; font-size: 1.03rem;">
                            Um dos principais problemas hoje em dia é o lixo urbano. Contudo, a reciclagem é uma das soluções para esse problema.
                            Mas muitas pessoas não sabem onde entregar e nem quando alguém vai poder retirar esse lixo de sua casa,
                            causando falta de interesse na separação do lixo e consequentemente na degradação do meio ambiente.
                        </p>
                        <p style="text-align: justify; text-indent: 4ch; font-size: 1.03rem;">
                            Pensando nisso, foi criado o sistema Trashpoints, onde os moradores podem avisar as empresas de coletas para que possam buscar suas coletas e
                            as empresas coletoras visualizariam as coletas e poderiam definir a melhor rota, coletando mais em menos tempo.
                        </p>
                    </div>
                </div>
            </div>
            <div class="row">
                <!-- Vidros -->
                <div class="col s12 m6">
                    <h5 class="header">Tipos de vidros recicláveis</h5>

                    <div class="card horizontal">
                        <div class="card-image">
                            <img src="${resource(dir: 'images', file: 'glasses.png')}">
                        </div>

                        <div class="card-stacked">
                            <div class="card-content">
                                <p>Tampas, potes, frascos, garrafas de bebidas, copos, embalagens.</p>
                            </div>

                            <div class="card-action">
                                <a href="#">Ver mais</a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Papéis -->
                <div class="col s12 m6">
                    <h5 class="header">Tipos de papéis recicláveis</h5>

                    <div class="card horizontal">
                        <div class="card-image">
                            <img src="${resource(dir: 'images', file: 'papers.png')}">
                        </div>

                        <div class="card-stacked">
                            <div class="card-content">
                                <p>Aparas de papel, jornais, revistas, caixas, papelão, papel de fax, formulários de computador, folhas de caderno, cartolinas, cartões, rascunhos escritos, envelopes, fotocópias, folhetos, impressos em geral.</p>
                            </div>

                            <div class="card-action">
                                <a href="#">Ver mais</a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Pláticos -->
                <div class="col s12 m6">
                    <h5 class="header">Tipos de plásticos recicláveis</h5>

                    <div class="card horizontal">
                        <div class="card-image">
                            <img src="${resource(dir: 'images', file: 'plastics.png')}">
                        </div>

                        <div class="card-stacked">
                            <div class="card-content">
                                <p>Tampas, potes de alimentos (margarina), frascos, utilidades domésticas, embalagens de refrigerante, garrafas de água mineral, recipientes para produtos de higiene e limpeza, PVC, tubos e conexões, sacos plásticos em geral, peças de brinquedos, engradados de bebidas, baldes.</p>
                            </div>

                            <div class="card-action">
                                <a href="#">Ver mais</a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Metais -->
                <div class="col s12 m6">
                    <h5 class="header">Tipos de metais recicláveis</h5>

                    <div class="card horizontal">
                        <div class="card-image">
                            <img src="${resource(dir: 'images', file: 'metals.png')}">
                        </div>

                        <div class="card-stacked">
                            <div class="card-content">
                                <p>Latas de alumínio (ex: latas de bebidas), latas de aço (ex: latas de óleo, sardinha, molho de tomate), tampas, ferragens, canos, esquadrias e molduras de quadros.</p>
                            </div>

                            <div class="card-action">
                                <a href="#">Ver mais</a>
                            </div>
                        </div>
                    </div>
                </div>

                <div style="clear:both"></div>

                <!-- Orgânicos -->
                <div class="col s12 m6">
                    <h5 class="header">Tipos de orgânicos</h5>

                    <div class="card horizontal">
                        <div class="card-image">
                            <img src="${resource(dir: 'images', file: 'organics.png')}">
                        </div>

                        <div class="card-stacked">
                            <div class="card-content">
                                <p>Restos de comida em geral, cascas de frutas, casca de ovo, sacos de chá e café, folhas, caules, flores, aparas de madeira, cinzas.</p>
                            </div>

                            <div class="card-action">
                                <a href="#">Ver mais</a>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</main>

</body>
<script type="text/javascript">    window.domain = "${application.contextPath}" </script>
<script>
    (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
            (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
        m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
    })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

    ga('create', 'UA-93957312-1', 'auto');
    ga('send', 'pageview');

</script>
</html>
