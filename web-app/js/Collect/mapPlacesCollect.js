var map;
var markersClusters = [];
var directionsDisplay;
var latLngBounds;
var myLatLng;
var selectedMarker;
var allSelectedMarkers = [];
var selectedCollectIds = [];
var isActiveToggle = false;
var line;
var waypoints = [];
var responseDirectionsService;
var currentInfoWindowOpen;
//const MAX_POINTS_SELECTED;

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
    //getMyLocationByGeolocation();

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
        url: window.domain + "/Collect/listPlacesCollect/",
        method: "post",
        success: function (data) {
            locations = data;
        },
        complete: function () {
            createMarkersOfCollections(locations)
        }
    });
}

function checkMarkersForDuplicatePosition(latLng) {
    //Check Markers array for duplicate position and offset a little
    if (markersClusters.length != 0) {
        for (var i = 0; i < markersClusters.length; i++) {
            var existingMarker = markersClusters[i];
            var position = existingMarker.getPosition();
            if (latLng.equals(position)) {
                var a = 360.0 / markersClusters.length;
                var newLat = position.lat() + -.00004 * Math.cos((+a * i) / 180 * Math.PI);  //x
                var newLng = position.lng() + -.00004 * Math.sin((+a * i) / 180 * Math.PI);  //Y
                latLng = new google.maps.LatLng(newLat, newLng);
            }
        }
    }
    return latLng;
}

function createMarkersOfCollections(locations) {
    if(locations) {
        $.each(locations, function (index, location) {
            var latLng = new google.maps.LatLng(location.lat, location.lng);
            latLng = checkMarkersForDuplicatePosition(latLng);

            var marker = new google.maps.Marker({
                position: latLng
            });

            latLngBounds.extend(marker.position); //Adjust bounds of map
            markersClusters.push(marker);
            createListenerClickMarker(location.collectId, marker);
        });

        var markerCluster = new MarkerClusterer(map, markersClusters, {maxZoom: 17, zoomOnClick: true, imagePath: window.domain + '/images/m'});

        ajustZoomMap();
    }
}

function createListenerClickMarker(collectId, marker){
    //Listener to marker one point of collect
    marker.addListener('click', function () {
        getInfoCollect(collectId, this);
    });
}

function getInfoCollect(collectId, marker) {
    $.ajax({
        url: window.domain + "/Collect/listInfoCollect/",
        data: {
            id: collectId
        },
        method: "post",
        success: function (data) {

            if (!collectHasCompanyToCollect(data)) {
                changeMarkerIcon(marker, collectId, data);

                if(hasSelectedMarker())
                    enableButtonsMap();
            }else {
                showInfoWindowCollect(data, marker);
                hideInfoCollect();
                eraseLine();
            }

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
    }else{
        contentString =
            '<p><strong>Endereço: </strong>' + address + '</p>' +
            '<p><strong>Data Pedido: </strong>' + data.infoCollect.orderDate + '</p>' +
            '<p><strong>Tipo da Coleta: </strong>' + materialTypes +'</p>';
    }

    var infoWindow = new google.maps.InfoWindow({
        content: contentString
    });

    infoWindow.open(map, marker);
    if(currentInfoWindowOpen) currentInfoWindowOpen.close();
    currentInfoWindowOpen = infoWindow;
    setTimeout(function () { infoWindow.close(); }, 9000);
}

function showInfoCollect(data) {
    var address = data.infoCollect.street + ", " + data.infoCollect.number + " - " + data.infoCollect.neighborhood + ", " + data.infoCollect.city + "-" + data.infoCollect.state;
    var materialTypes = data.materialTypes.join(", ");

    if (data.infoCollect.imageCollect){
        var UPLOAD_FOLDER_PATH = window.domain + "/images/uploads/";
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
    }else
        $('.collection').show("slow");
}

function computeDistanceInKmBetweenPoints(myPosition, targetPosition) {
    if(myLatLng != undefined && selectedMarker) {
        var distanceBetweenPoints = (google.maps.geometry.spherical.computeDistanceBetween(myPosition, targetPosition) / 1000).toFixed(2);
        document.getElementById('distanceBetweenPoints').innerHTML = distanceBetweenPoints.toString().replace('.',',') + ' km';
        drawLine();
    }
}

function computeTotalDistance(directions) {
    var totalRouteDistance = 0;
    var myRoute = directions.routes[0];
    for (var i = 0; i < myRoute.legs.length; i++) {
        totalRouteDistance += myRoute.legs[i].distance.value;
    }
    totalRouteDistance = (totalRouteDistance / 1000).toString().replace('.',',');
    document.getElementById('totalRouteDistance').innerHTML = '≅' + totalRouteDistance + ' km';
}

function drawLine() {
    var path = [myLatLng, selectedMarker.getPosition()];
    line.setPath(path);
    line.setMap(map);
}

function eraseLine() {
    line.setMap(null);
}

function createRoute(){
    var request = {
        origin: myLatLng,
        destination: myLatLng,
        waypoints: waypoints,
        optimizeWaypoints: true,
        travelMode: 'DRIVING'
    };

    var directionsService = new google.maps.DirectionsService();
    directionsService.route(request, function(response, status) {
        if (status == 'OK') {
            eraseLine();
            $("h6#infoRoute").show();
            responseDirectionsService = response;
            directionsDisplay.setMap(map);
            numberMarkers();
            directionsDisplay.setDirections(response);
            computeTotalDistance(directionsDisplay.getDirections());
        }
    });
}

function numberMarkers() {
    var number = 1;
    for (var i = 0; i < allSelectedMarkers.length; i++) {
        var labelMarker = {
            color: 'white',
            fontSize: '15px',
            fontWeight: 'bold',
            text: number.toString()
        };
        allSelectedMarkers[i].setLabel(labelMarker);

        number++;
    }
}

function removeMarkerNumber(clickedMarker) {
    clickedMarker.setLabel(null);
}

function removeMarkersNumber() {
    for (var i = 0; i < allSelectedMarkers.length; i++) {
        allSelectedMarkers[i].setLabel(null);
    }
}

function getMyLocationByGeolocation(){
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(setPositionByGeolocation, errorGeolocation);
    } else {
        iziToast.error({
            title: 'Erro',
            message: 'Geolocalização não é suportada para este navegador.',
            iconText: "block"
        });
    }
}

function getMyLocation(){
    $.post( window.domain + "/Company/getMyLocation/", setPosition);
}

function setPositionByGeolocation(position) {
    myLatLng = new google.maps.LatLng(position.coords.latitude, position.coords.longitude)
    createMarkerMyLocation();
}

function setPosition(position) {
    myLatLng = new google.maps.LatLng(position.latitude, position.longitude)
    createMarkerMyLocation();
}

function createMarkerMyLocation() {
    var markerMyPosition = new google.maps.Marker({
        map: map,
        position: myLatLng,
        icon: window.domain + '/images/icon_my_location.png',
        title: 'Minha localização'
    });
    latLngBounds.extend(myLatLng); //Adjust bounds of map
    ajustZoomMap();

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
            errorDescription += 'erro desconhecido!';
            break;
    }

    iziToast.error({
        title: 'Erro',
        message: errorDescription,
        iconText: "block"
    });
}

function ajustZoomMap() {
    map.fitBounds(latLngBounds);
}

function collectRecycling(collectIds) {
    var formData = $("form[name=formPlacesCollect]").serializeArray();
    var ids = {
        name: "id",
        value: collectIds
    };
    formData.push(ids);

    var date = {
        name: 'scheduleDate',
        value: $('#txb-collect-date').val()
    };
    formData.push(date);
    var hour = {
        name: 'scheduleHour',
        value: $('#txb-collect-time').val()
    };
    formData.push(hour);

    $.ajax({
        url: window.domain + "/Collect/collectRecycling/",
        data: formData,
        method: "post",
        success: function (data) {
            if (data.success) {
                removeAllCollectIdsSelected();
                window.localStorage.setItem('waypoints', JSON.stringify(responseDirectionsService));

                iziToast.success({
                    title: 'OK',
                    message: 'Sucesso ao salvar!',
                    iconText: "check"
                });
            }else if(data.error) {
                iziToast.error({
                    title: 'Erro',
                    message: 'Operação ilegal!',
                    iconText: "block"
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

function enableButtonCollectRecycling() {
    $('#btnCollectRecycling').removeClass("disabled");
}

function disableButtonCollectRecycling() {
    $('#btnCollectRecycling').addClass("disabled");
}

function disableButtonsMap() {
    $('#btnCreateRoute').addClass("disabled");
    $('#btnCollectRecycling').addClass("disabled");
}

function getRoutesByLocalStorageAndDisplay() {
    var wayPoints = window.localStorage.getItem('waypoints');
    if (wayPoints != undefined && wayPoints != "undefined") {
        wayPoints = JSON.parse(wayPoints);
        directionsDisplay.setDirections(wayPoints);
    }
}

function cleanRoutes() {
    window.localStorage.clear();
    directionsDisplay.setMap(null);
    eraseLine();
    deselectAllMarkers();
    disableButtonsMap();
    hideInfoCollect();
    $('#totalRouteDistance').text("sem rota para calcular");
}

function changeMarkerIcon(clickedMarker, collectId, dataCollect) {
    if(isSelectedMarker(clickedMarker)){
        deselectMarker(clickedMarker, collectId);
        return;
    }

    selectedMarker = clickedMarker;
    selectedMarker.setIcon(window.domain + "/images/map_marker_selected.png");

    addCollectIdIfNotExist(collectId);
    showInfoWindowCollect(dataCollect, clickedMarker);
    showInfoCollect(dataCollect);
    computeDistanceInKmBetweenPoints(myLatLng, clickedMarker.getPosition());
}

function deselectMarker(clickedMarker, collectId) {
    clickedMarker.setIcon(); //set Default icon
    removeMarkerNumber(clickedMarker);
    removeCollectId(collectId);
    removeWayPointRoute(clickedMarker);
    hideInfoCollect();
    eraseLine();

    if(hasSelectedMarker() == false)
        disableButtonsMap();
}

function deselectAllMarkers() {
    for(var i = 0; i < allSelectedMarkers.length; i++){
        allSelectedMarkers[i].setIcon(); //set Default icon
    }

    removeMarkersNumber();
    removeAllCollectIdsSelected();
    removeAllWayPointRoute();
}

function addCollectIdIfNotExist(collectId) {
    if (selectedCollectIds.indexOf(collectId) === -1) {
        selectedCollectIds.push(collectId);
        waypoints.push({ location: selectedMarker.position });
        allSelectedMarkers.push(selectedMarker);
    }
}

function removeCollectId(collectId) {
    var index = selectedCollectIds.indexOf(collectId);
    if (index != -1)
        selectedCollectIds.splice(index, 1);
}

function removeWayPointRoute(clickedMarker) {
    var index = -1;
    for(var i = 0, len = waypoints.length; i < len; i++) {
        if (waypoints[i].location === clickedMarker.position) {
            index = i;
            break;
        }
    }
    if(index != -1)
        waypoints.splice(index, 1);

    index = allSelectedMarkers.indexOf(clickedMarker);
    if(index != -1)
        allSelectedMarkers.splice(index, 1);

    selectedMarker = null;
}

function removeAllWayPointRoute() {
    waypoints = [];
    allSelectedMarkers = [];
}

function removeAllCollectIdsSelected() {
    selectedCollectIds = [];
    selectedMarker = null;
    disableButtonCollectRecycling();
}

function hasSelectedMarker() {
    return allSelectedMarkers.length > 0;
}

function isSelectedMarker(clickedMarker) {
    // Check if the current marker is selected(blue marker)
    if (allSelectedMarkers.indexOf(clickedMarker) != -1)
        return true;
    else
        return false;
}

function hideInfoCollect() {
    $('.collection').hide("slow");
}

function collectHasCompanyToCollect(data) {
    return data.infoCollect.companyName;
}

function setFocusMap() {
    $("html, body").animate({
        scrollTop: $("#containerMap").offset().top
    }, 350);
}

function setActiveItemMenu() {
    $('li#home').removeClass('active');
    $('li#placesCollect').addClass('active');
}

$(document).ready(function () {
    var MAX_DATE = moment().add(3, 'day').toDate();

    initMap();

    $('#btnCreateRoute').click(function(){
        if(hasSelectedMarker() && myLatLng != undefined) {
            createRoute();
        }
    });

    $('#btnCollectRecycling').click(function(){
        if(hasSelectedMarker() && myLatLng != undefined) {
			// Exibe modal de data e hora
			$('#txb-collect-date').val('');
			$('#dateTimeToCollectModal').modal({
				dismissible: false, // Modal can be dismissed by clicking outside of the modal
				startingTop: '2%', // Starting top style attribute
				endingTop: '2%'
			});
			$('#dateTimeToCollectModal').modal('open');
		}
    });

    // ** Configuracao dos eventos de clique dos botoes no modal de data e hora
    $('#btn-cancel-datetime-collect').on('click', function(){
        setFocusMap();
        $('#dateTimeToCollectModal').modal('close');
    });

    $('#btn-schedule-collect').on('click', function(){
        if ($('#txb-collect-date').val() == ''){
            iziToast.error({
                title: 'Erro',
                message: 'Por favor, selecione a data planejada para coleta.',
                iconText: "block"
            });
            return false;
        }
        /*if ($('#txb-collect-time').val() == ''){
            iziToast.error({
                title: 'Erro',
                message: 'Por favor, selecione a hora planejada para coleta.',
                iconText: "block"
            });
            return false;
        }*/

        var selectedDate = moment($('#txb-collect-date').val(), 'DD/MM/YYYY').toDate();

        if (moment(new Date()).isAfter(selectedDate, 'day')){
            iziToast.error({
                title: 'Erro',
                message: 'A data de coleta planejada deve ser maior ou igual a data de hoje',
                iconText: "block"
            });
            return false;
        }
        if(hasSelectedMarker()) {
            collectRecycling(selectedCollectIds);
            setFocusMap();
            $('#dateTimeToCollectModal').modal('close');
        }
    });

    $('.datepicker').pickadate({
        selectMonths: false,
        selectYears: 3,
        min: new Date(),
        max: MAX_DATE
    });
    /*$('.timepicker').pickatime({
        autoclose: false,
        twelvehour: false,
        default: '00:00:00',
        donetext: 'OK'
    });*/
    $('#txb-collect-date').on('focus', function(){
        $('.picker').appendTo('body');
    });
    /*$('#txb-collect-time').on('focus', function(){
        $('.picker').appendTo('body');
    });*/

    getRoutesByLocalStorageAndDisplay();
    $("#btnCleanRoute").click(cleanRoutes);
    setActiveItemMenu();
});
