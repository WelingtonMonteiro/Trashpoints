var geocoder;
var map;
var markersClusters = [];
var directionsDisplay;
var latLngBounds;
var myLatLng;
var selectedMarker;
var isActiveToggle = false;

function initMap() {
    //Setup Map
    map = new google.maps.Map(document.getElementById('map'), {
        center: {lat: -22.81603082953687, lng: -45.19272714106444},
        zoom: 10,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    });
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

    latLngBounds = new google.maps.LatLngBounds();

    getLocationsOfCollections();
    getMyLocation();
    map.fitBounds(latLngBounds);
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
    //Listener to marker one point
    marker.addListener('click', function () {
        setInfoCollect(collectId, marker);
        if (selectedMarker)
            selectedMarker.setIcon(); //set Default icon
        selectedMarker = this;
        selectedMarker.setIcon('/Trashpoints/images/Map-Marker.png');
    });
}

function setInfoCollect(collectId, marker) {
    var contentString = "";

    $.ajax({
        url: "/Trashpoints/Collect/listInfoCollect/",
        data: {
            id: collectId
        },
        method: "post",
        success: function (data) {
            var address = data.infoCollect.street + ", " + data.infoCollect.number + " - " +
                data.infoCollect.neighborhood + ", " + data.infoCollect.city + "-" + data.infoCollect.state;
            $("#infoCollect #divCollectImage").html("");
            if (data.infoCollect.imageCollect){
                var UPLOAD_FOLDER_PATH = "/Trashpoints/images/uploads/";
                $("#infoCollect #divCollectImage").html("<img src='" + UPLOAD_FOLDER_PATH + data.infoCollect.imageCollect +"' class='responsive-img' style='max-height: 284px;'>")
            }else{
                $("#infoCollect #divCollectImage").html("<i class='fa fa-file-image-o fa-5x center-align'></i>")
            }
            $("#infoCollect span#nameColaborator").text(data.infoCollect.nameColaborator)
            $("#infoCollect span#address").text(address)
            $("#infoCollect span#orderDate").text(data.infoCollect.orderDate)

            var materialTypes = data.materialTypes.join(", ");

            $("#infoCollect span#typeOfCollect").text(materialTypes)

            if(!isActiveToggle) {
                $('.collection').toggle("slow");
                isActiveToggle = true;
            }

            contentString =
                '<p>Colaborador: ' + data.infoCollect.nameColaborator + '</p>' +
                '<p>Endereço: ' + address + '</p>' +
                '<p>Data Pedido: ' + data.infoCollect.orderDate + '</p>' +
                '<p>Tipo da Coleta: ' + materialTypes +'</p>';

            var infoWindow = new google.maps.InfoWindow({
                content: contentString
            });

            infoWindow.open(map, marker);
            setTimeout(function () { infoWindow.close(); }, 10000);
        }
    });
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
    latLngBounds.extend(markerMyPosition.position); //Adjust bounds of map

    //Listener for set zoom when click in my position's marker
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

$(document).ready(function () {
    initMap();

    $('#createRoute').click(function(){
        if(selectedMarker) {
            createRoute(selectedMarker.position);
        }
    });

});