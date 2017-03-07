<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Relatórios/Gráficos</title>

    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script src="${application.contextPath}/js/Report/chartCollect.js" type="text/javascript"></script>
</head>

<body>
<main>
    <div class="section">
        <div class="container">
            <h5 class="header">Relatórios e Gráficos</h5>

            <div class="row">
                <div class="col s12">
                    <ul class="tabs">
                        <li class="tab col s3"><a class="active" href="#charts">Gráficos</a></li>
                        <li class="tab col s3"><a href="#reports">Relatórios</a></li>
                    </ul>
                </div>

                <div id="charts" class="col s12">
                    <div class="section padding-sides">
                        <label class="my-label uppercase">Total de pedidos de coletas:</label> <span id="totalOrdersCollections"></span><br/>
                        <label class="my-label uppercase">Total coletado:</label> <span id="totalCollected"></span><br/>
                    </div>

                    <div id="column_chart_div" class="chart">
                        <div id="preloader_column_chart" class="preloader-wrapper big active" style="margin-left: auto !important; margin-right: auto !important; display: block;">
                            <div class="spinner-layer spinner-blue-only">
                                <div class="circle-clipper left">
                                    <div class="circle"></div>
                                </div>

                                <div class="gap-patch">
                                    <div class="circle"></div>
                                </div>

                                <div class="circle-clipper right">
                                    <div class="circle"></div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div id="pie_chart_div" class="chart">
                        <div id="preloader_pie_chart" class="preloader-wrapper big active" style="margin-left: auto !important; margin-right: auto !important; display: block;">
                            <div class="spinner-layer spinner-blue-only">
                                <div class="circle-clipper left">
                                    <div class="circle"></div>
                                </div>

                                <div class="gap-patch">
                                    <div class="circle"></div>
                                </div>

                                <div class="circle-clipper right">
                                    <div class="circle"></div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>

                <div id="reports" class="col s12">
                    <div class="section padding-sides">
                        Relatórios
                    </div>
                </div>

            </div>

        </div>
    </div>
</main>

</body>
</html>
