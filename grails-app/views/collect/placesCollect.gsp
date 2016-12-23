<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Locais para coletar</title>
    <style type="text/css">
    #map {
        height: 100%;
        width: 100%;
    }

    #panelMap {
        height: 100%;
        width: 100%;
        overflow: auto;
    }
    </style>
</head>

<body>

<main>
    <div class="section">
        <div class="container">

            <div class="row">
                <div class="col s12" style="height: 500px; position: relative;">
                    <h5 class="header">Locais para coletar</h5>
                    <div id="map"></div>
                    <button id="createRoute" class="btn waves-effect waves-light blue darken-3"
                            style="position: absolute; top: 60px; right: 30px; opacity: 0.79;">
                        <i class="material-icons left">directions</i>Criar rota
                    </button>
                </div>

                <div class="col s12" style="height: 145px; margin-top: 50px">
                    <div id="panelMap"><h6 class="center-align bold">Informações sobre a rota</h6></div>
                </div>
            </div>

            <div class="row">
                <div id="infoMap" class="col s12">
                    <label class="my-label">
                        <i class="fa fa-arrows-h" aria-hidden="true"></i> Distância entre a origem e o destino:
                    </label>
                    <span id="distanceBetweenPoints">0 km</span>
                </div>
            </div>

            <div class="row">
                <div id="infoCollect" class="col s12">
                    <ul class="collection with-header hidden">
                        <li class="collection-header"><h5>Informações da Coleta</h5></li>
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
                                <label class="my-label"> Imagem Coleta: </label><br/>
                                <div id="divCollectImage" class="center">
                                </div>
                            </div>
                        </li>

                    </ul>
                </div>
            </div>

        </div>
    </div>
</main>

<script src="/Trashpoints/js/map.js" type="text/javascript"></script>
<script src="/Trashpoints/js/markerclusterer.js" type="text/javascript"></script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyA6W1hTA1qEYPC1qi4V3dvDkIcg75yUc68"></script>


</body>
</html>
