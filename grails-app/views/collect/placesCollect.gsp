<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Locais para coletar</title>
    <style>
    .picker__holder {
        overflow: hidden !important;
    }
    </style>
    <link href="/Trashpoints/css/materialize.clockpicker.css" rel="stylesheet">
</head>

<body>

<main>
    <g:form name="formPlacesCollect" useToken="true"></g:form>
    <div class="section">
        <div class="container-fluid">

            <div class="row">
                <div id="containerMap" class="col s12" style="height: 500px; position: relative;">
                    <h5 class="header">Locais para coletar</h5>

                    <div id="map"></div>
                    <button id="btnCreateRoute"
                            class="btn waves-effect waves-light blue darken-3 btn-google-map disabled"
                            title="Criar rota entre a sua posição e o ponto selecionado" style="top: 60px;">
                        <i class="material-icons left">directions</i>Rota
                    </button>
                    <button id="btnCollectRecycling"
                            class="btn waves-effect waves-light blue darken-3 btn-google-map disabled"
                            title="Marcar que quero coletar essa reciclagem" style="top: 110px;">
                        <i class="material-icons left">local_shipping</i>Coletar
                    </button>
                    <button id="btnCleanRoute"
                            class="btn waves-effect waves-light blue darken-3 btn-google-map"
                            title="Limpar rotas criadas" style="top: 160px;">
                        <i class="material-icons left">clear</i>Limpar
                    </button>
                </div>

                <div class="col s12" style="max-height: 145px; margin-top: 50px">
                    <div id="panelMap"><h6 id="infoRoute" class="center-align bold hidden">Informações sobre a rota</h6>
                    </div>
                </div>
            </div>

            <div class="row">
                <div id="infoCollect" class="col s12">
                    <ul class="collection with-header hidden">
                        <li class="collection-header"><h5>Informações da Coleta</h5></li>
                        <li class="collection-item">
                            <div>
                                <i class="material-icons left">directions</i>
                                <label class="my-label">Distância total das rotas:</label>
                                <span id="totalRouteDistance">sem rota para calcular</span>
                            </div>
                        </li>
                        <li class="collection-item">
                            <div>
                                <i class="fa fa-arrows-h left" aria-hidden="true" style="font-size: 24px;"></i>
                                <label class="my-label">Distância entre a origem e o ponto selecionado:</label> ≅
                                <span id="distanceBetweenPoints">0 km</span>
                            </div>
                        </li>
                        <li class="collection-item">
                            <div>
                                <i class="material-icons left">person</i>
                                <label class="my-label">Colaborador:</label> <span id="nameColaborator"></span>
                            </div>
                        </li>
                        <li class="collection-item">
                            <div>
                                <i class="material-icons left">location_on</i>
                                <label class="my-label">Endereço:</label> <span id="address"></span>
                            </div>
                        </li>
                        <li class="collection-item">
                            <div>
                                <i class="material-icons left">today</i>
                                <label class="my-label">Data Pedido:</label> <span id="orderDate"></span>
                            </div>
                        </li>
                        <li class="collection-item">
                            <div>
                                <i class="fa fa-recycle left" aria-hidden="true" style="font-size: 24px;"></i>
                                <label class="my-label">Tipo(s) de Coleta:</label> <span id="typeOfCollect"></span>
                            </div>
                        </li>

                        <li class="collection-item">
                            <div>
                                <i class="fa fa-file-image-o left" aria-hidden="true" style="font-size: 24px;"></i>
                                <label class="my-label">Imagem Coleta:</label><br/>

                                <div id="divCollectImage" class="center"></div>
                            </div>
                        </li>

                    </ul>
                </div>
            </div>

            <div class="row">
                <div class="col s12 offset-m2 m8">
                    <div class="card-panel grey lighten-5">
                        <i class="material-icons left blue-text">info</i>
                        <span class="black-text">
                            Para criar uma rota, basta somente clicar em algum ponto e depois clicar no botão
                            <button class="btn waves-effect waves-light blue darken-3 btn-disabled">
                                <i class="material-icons left">directions</i>Rota
                            </button>
                        </span>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col s12 offset-m2 m8">
                    <div class="card-panel grey lighten-5">
                        <i class="material-icons left blue-text">info</i>
                        <span class="black-text">
                            Para marcar que você vai coletar em um local, basta somente clicar em algum ponto e depois clicar no botão
                            <button class="btn waves-effect waves-light blue darken-3 btn-disabled">
                                <i class="material-icons left">local_shipping</i>Coletar
                            </button>
                        </span>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col s12 offset-m2 m8">
                    <div class="card-panel grey lighten-5">
                        <i class="material-icons left blue-text">info</i> <strong>Legenda</strong><br/>

                        <div class="row">
                            <div class="col s12 offset-m2 m8">
                                <img src="/Trashpoints/images/icon_my_location_38.png">
                                <span style="vertical-align: super;">- Representa sua localização</span><br/>

                                <img src="/Trashpoints/images/map_marker.png">
                                <span style="vertical-align: super;">- Representa um ponto de coleta</span><br/>

                                <img src="/Trashpoints/images/map_marker_selected.png">
                                <span style="vertical-align: super;">- Representa um ponto selecionado</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</main>

<!-- Modal para selecao de data e hora -->
<div id="dateTimeToCollectModal" class="modal">
    <div class="modal-content">

        <h5 class="header">Seleção de data</h5>

        <p>Selecione a data da coleta:</p>

        <div class="row">
            <div class="input-field col s12">
                <i class="material-icons prefix">today</i>
                <input type="date" class="datepicker" id="txb-collect-date">
                <label for="txb-collect-date" class="active">Data:<span class="red-text">*</span></label>
            </div>
        </div>

        %{--<div class="row">
            <div class="input-field col s12">
                <i class="material-icons prefix">schedule</i>
                <input id="txb-collect-time" class="timepicker" type="time" data-default="00:00:00">
                <input type="hidden" id="fld-collect-id"/>
                <label for="txb-collect-time" class="active">Hora:<span class="red-text">*</span></label>
            </div>
        </div>--}%

    </div>

    <div class="modal-footer">
        <a id="btn-schedule-collect" href="#!" class="waves-effect waves-light btn-flat">Marcar coleta</a>
        <a id="btn-cancel-datetime-collect" href="#!" class="waves-effect waves-light btn-flat">Cancelar</a>
    </div>
</div>

<script src="/Trashpoints/js/map.js" type="text/javascript"></script>
<script src="/Trashpoints/js/markerclusterer.min.js" type="text/javascript"></script>
<script src="/Trashpoints/js/materialize.clockpicker.min.js" type="text/javascript"></script>
<script src="/Trashpoints/js/moment.min.js" type="text/javascript"></script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyA6W1hTA1qEYPC1qi4V3dvDkIcg75yUc68"></script>

</body>
</html>
