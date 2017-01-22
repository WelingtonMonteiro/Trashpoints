var map;
var markersClusters = [];
var directionsDisplay;
var latLngBounds;
var myLatLng;
var selectedMarker;
var collectIdSelected;
var isActiveToggle = false;
var line;

function initMap() {
    var latLng = new google.maps.LatLng(-22.19496980839918, -47.32420171249998);

    //Setup Map
    map = new google.maps.Map(document.getElementById('map'), {
        center: latLng,
        zoom: 6,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    });
    latLngBounds = new google.maps.LatLngBounds();

    getLocationsOfCollections();
    getMyLocation();

    //Setup Directions Renderer(Used in routes)
    directionsDisplay = new google.maps.DirectionsRenderer({
        map: map,
        panel: document.getElementById('panelMap'),
        draggable: false,
        suppressMarkers: true
    });
    //Listener to recalculate total distance between two points
    directionsDisplay.addListener('directions_changed', function() {
        computeTotalDistance(directionsDisplay.getDirections());
    });

    line = new google.maps.Polyline({
        map: map,
        strokeColor: "#FF3333",
        strokeOpacity: 0.7,
        strokeWeight: 7
    });
}

function getLocationsOfCollections(){
    var locations;
    $.ajax({
        url: "/Trashpoints/Collect/listPlacesCollect/",
        method: "post",
        success: function (data) {
            locations = data;
        },
        complete: function () {
            createMarkersOfCollections(locations)
        }
    });
}

function createMarkersOfCollections(locations) {
    if(locations) {
        $.each(locations, function (index, location) {
            var marker = new google.maps.Marker({
                position: new google.maps.LatLng(location.lat, location.lng)
            });

            latLngBounds.extend(marker.position); //Adjust bounds of map
            markersClusters.push(marker);
            createListenerClickMarker(location.collectId, marker)
        });
        var markerCluster = new MarkerClusterer(map, markersClusters, {imagePath: '/Trashpoints/images/m'});
    }
}

function createListenerClickMarker(collectId, marker){
    //Listener to marker one point of collect
    marker.addListener('click', function () {
        getInfoCollect(collectId, marker);
        if (selectedMarker)
            selectedMarker.setIcon(); //set Default icon
        selectedMarker = this;
        selectedMarker.setIcon('/Trashpoints/images/map_marker_selected.png');
        collectIdSelected = collectId
    });
}

function getInfoCollect(collectId, marker) {
    $.ajax({
        url: "/Trashpoints/Collect/listInfoCollect/",
        data: {
            id: collectId
        },
        method: "post",
        success: function (data) {
            showInfoCollect(data, marker);
            showInfoWindowCollect(data, marker);
        }
    });
}

function showInfoWindowCollect(data, marker) {
    var contentString = "";

    var address = data.infoCollect.street + ", " + data.infoCollect.number + " - <br/>" + data.infoCollect.neighborhood + ", " + data.infoCollect.city + "-" + data.infoCollect.state;
    var materialTypes = data.materialTypes.join(", ");

    if (data.infoCollect.companyName){
        var companyName = data.infoCollect.companyName;
        contentString =
            '<p><strong>Empresa: ' + companyName + ', já selecionou que vai recolher essa coleta </strong> </p>'+
            '<p><strong>Data Pedido: </strong>' + data.infoCollect.orderDate + '</p>' +
            '<p><strong>Tipo da Coleta: </strong>' + materialTypes +'</p>';

        selectedMarker.setIcon('/Trashpoints/images/map_marker_selected.png');
        disableButtonsMap();
    }else{
        contentString =
            '<p><strong>Endereço: </strong>' + address + '</p>' +
            '<p><strong>Data Pedido: </strong>' + data.infoCollect.orderDate + '</p>' +
            '<p><strong>Tipo da Coleta: </strong>' + materialTypes +'</p>';
        enableButtonsMap();
    }

    var infoWindow = new google.maps.InfoWindow({
        content: contentString
    });

    infoWindow.open(map, marker);
    setTimeout(function () { infoWindow.close(); }, 10000);
}

function showInfoCollect(data, marker) {
    var address = data.infoCollect.street + ", " + data.infoCollect.number + " - " + data.infoCollect.neighborhood + ", " + data.infoCollect.city + "-" + data.infoCollect.state;
    var materialTypes = data.materialTypes.join(", ");

    if (data.infoCollect.imageCollect){
        var UPLOAD_FOLDER_PATH = "/Trashpoints/images/uploads/";
        $("#infoCollect #divCollectImage").html("<img src='" + UPLOAD_FOLDER_PATH + data.infoCollect.imageCollect +"' class='responsive-img' style='max-height: 284px;'>");
    }else{
        $("#infoCollect #divCollectImage").html("<i class='fa fa-file-image-o fa-5x center-align'></i>");
    }
    $("#infoCollect span#nameColaborator").text(data.infoCollect.nameColaborator);
    $("#infoCollect span#address").html(address);
    $("#infoCollect span#orderDate").text(data.infoCollect.orderDate);
    $("#infoCollect span#typeOfCollect").text(materialTypes);

    if(!isActiveToggle) {
        $('.collection').toggle("slow");
        isActiveToggle = true;
    }

    computeDistanceInKmBetweenPoints(myLatLng, marker.getPosition());
}

function computeDistanceInKmBetweenPoints(myPosition, targetPosition) {
    var distanceBetweenPoints = (google.maps.geometry.spherical.computeDistanceBetween(myPosition, targetPosition) / 1000).toFixed(2);
    document.getElementById('distanceBetweenPoints').innerHTML = distanceBetweenPoints.toString().replace('.',',') + ' km';
    drawLine();
}

function drawLine() {
    var path = [myLatLng, selectedMarker.getPosition()];
    line.setPath(path);
    line.setMap(map);
}

function eraseLine() {
    line.setMap(null);
}

function createRoute(markerPosition){
    var destinationLatLng = markerPosition

    var request = {
        origin: myLatLng,
        destination: destinationLatLng,
        travelMode: 'DRIVING'
    };

    var directionsService = new google.maps.DirectionsService();
    directionsService.route(request, function(response, status) {
        if (status == 'OK') {
            eraseLine();
            $("h6#infoRoute").show();
            directionsDisplay.setDirections(response);
        }
    });
}

function computeTotalDistance(directions) {
    var distanceBetweenPoints = 0;
    var myRoute = directions.routes[0];
    for (var i = 0; i < myRoute.legs.length; i++) {
        distanceBetweenPoints += myRoute.legs[i].distance.value;
    }
    distanceBetweenPoints = (distanceBetweenPoints / 1000).toString().replace('.',',');
    document.getElementById('distanceBetweenPoints').innerHTML = distanceBetweenPoints + ' km';
}

function getMyLocation(){
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(setPosition, errorGeolocation);
    } else {
        alert("Geolocalização não é suportado para este navegador.");
    }
}

function setPosition(position) {
    myLatLng = new google.maps.LatLng(position.coords.latitude, position.coords.longitude)
    createMarkerMyLocation();
}

function createMarkerMyLocation() {
    var markerMyPosition = new google.maps.Marker({
        map: map,
        position: myLatLng,
        icon: '/Trashpoints/images/icon_my_location.png',
        title: 'Minha localização'
    });
    latLngBounds.extend(myLatLng); //Adjust bounds of map
    //map.fitBounds(latLngBounds);

    //Listener for set zoom when click in my marker position
    markerMyPosition.addListener('click', function() {
        map.setZoom(map.getZoom() + 2);
        map.setCenter(markerMyPosition.getPosition());
    });
}

function errorGeolocation(error){
    var errorDescription = 'Ops, ';
    switch(error.code) {
        case error.PERMISSION_DENIED:
            errorDescription += 'usuário não autorizou a Geolocalização.';
            break;
        case error.POSITION_UNAVAILABLE:
            errorDescription += 'localização indisponível.';
            break;
        case error.TIMEOUT:
            errorDescription += 'tempo expirado.';
            break;
        case error.UNKNOWN_ERROR:
            errorDescription += 'não sei o que foi, mas deu erro!';
            break;
    }
    alert(errorDescription)
};

function ajustMapZoom() {
    map.fitBounds(latLngBounds);
}

function collectRecycling(collectIdSelected) {
    var formData = $("form[name=formPlacesCollect]").serializeArray();
    var id = {
        name: "id",
        value: collectIdSelected
    }
    formData.push(id);

    $.ajax({
        url: "/Trashpoints/Collect/collectRecycling/",
        data: formData,
        method: "post",
        success: function (data) {
            if (data.success) {
                iziToast.success({
                    title: 'OK',
                    message: 'Sucesso ao salvar!',
                    iconText: "check"
                });
            }else if(data.error) {
                iziToast.error({
                    title: 'Erro',
                    message: 'Operação ilegal!',
                });
            }
            $("#SYNCHRONIZER_TOKEN").val(data.newToken);
        }
    });
}

function enableButtonsMap() {
    $('#btnCreateRoute').removeClass("disabled");
    $('#btnCollectRecycling').removeClass("disabled");
}

function disableButtonsMap() {
    $('#btnCreateRoute').addClass("disabled");
    $('#btnCollectRecycling').addClass("disabled");
}

$(document).ready(function () {
    initMap();
    $('#btnCreateRoute').click(function(){
        if(selectedMarker) {
            createRoute(selectedMarker.position);
        }
    });
    $('#btnCollectRecycling').click(function(){
        if(selectedMarker) {
            collectRecycling(collectIdSelected);
        }
    });
    ajustMapZoom();
});


