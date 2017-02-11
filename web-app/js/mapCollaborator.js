var map;
var myLatLng;

function initMap() {
    var latLng = new google.maps.LatLng(-22.19496980839918, -47.32420171249998);

    //Setup Map
    map = new google.maps.Map(document.getElementById('map'), {
        center: latLng,
        zoom: 5,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    });
}

function getMyLocation(){
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(setPosition, errorGeolocation);
    } else {
        showNotifyError('Geolocalização não é suportada para este navegador.');
        getMyLocationByZipCode();
    }
}

function setPosition(position) {
    initMap();

    myLatLng = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
    $('#latitude').val(position.coords.latitude);
    $('#longitude').val(position.coords.longitude);

    Materialize.updateTextFields();

    createMarkerMyLocation(myLatLng);
    showNotifySucess('Sucesso ao encontrar sua localização!');
    showMap();
    hidePanelWarningLocation();
}

function setPositionByGeoCoder(latitude, longitude) {
    initMap();

    $('#latitude').val(latitude);
    $('#longitude').val(longitude);

    Materialize.updateTextFields();

    myLatLng = new google.maps.LatLng(latitude, longitude);
    createMarkerMyLocation(myLatLng);
    showNotifySucess('Sucesso ao encontrar sua localização pelo endereço!');
    showMap();
}

function createMarkerMyLocation(myLatLng) {
    var markerMyPosition = new google.maps.Marker({
        map: map,
        draggable: true,
        title: 'Minha localização'
    });

    markerMyPosition.setPosition(myLatLng);
    map.setCenter(myLatLng);
    map.setZoom(18);

    markerMyPosition.addListener('click', function() {
        map.setZoom(map.getZoom() + 2);
        map.setCenter(markerMyPosition.getPosition());
    });

    var geocoder = new google.maps.Geocoder();
    google.maps.event.addListener(markerMyPosition, 'drag', function () {
        geocoder.geocode({ 'latLng': markerMyPosition.getPosition() }, function (results, status) {
            if (status == google.maps.GeocoderStatus.OK) {
                if (results[0]) {
                    $('#latitude').val(markerMyPosition.getPosition().lat());
                    $('#longitude').val(markerMyPosition.getPosition().lng());
                }
            }
        });
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

    showNotifyError(errorDescription);
    getMyLocationByZipCode();
};

function getFullAddress() {
    var street = $('#street').val();
    var number = $('#number').val();
    var neighborhood = $('#neighborhood').val();
    var city = $('#city').val();
    var state = $('#states').val();
    var zipCode = $('#zipCode').val();

    if(street && number && neighborhood && city && state && zipCode){
        var formatted_address = street + ", " + number +" - " + neighborhood + ", " + city + " - " + state + ", Brasil";
        return formatted_address;
    }
    return String.empty;
}

function getStreetZipCodeAndNumber() {
    var street = $('#street').val();
    var number = $('#number').val();
    var zipCode = $('#zipCode').val();

    if(street && number && zipCode){
        var formatted_address = street + ", " + number +", " + zipCode + ", Brasil";
        return formatted_address;
    }
    return String.empty;
}

function getMyLocationByAddress() {
    var address = getStreetZipCodeAndNumber();
    if(address) {
        var geocoder = new google.maps.Geocoder();

        geocoder.geocode({address: address, 'region': 'BR'}, function(results, status) {
            if (status == google.maps.GeocoderStatus.OK) {
                if (results[0]) {
                    var latitude = results[0].geometry.location.lat();
                    var longitude = results[0].geometry.location.lng();

                    setPositionByGeoCoder(latitude, longitude);
                }
            }else
                showPanelWarningLocation();
        });

    }
}

function getMyLocationByZipCode() {
    var zipCode = $("#zipCode").val();
    if(zipCode) {
        var geocoder = new google.maps.Geocoder();

        geocoder.geocode({address: zipCode, 'region': 'BR'}, function(results, status) {
            if (status == google.maps.GeocoderStatus.OK) {
                if (results[0]) {
                    var latitude = results[0].geometry.location.lat();
                    var longitude = results[0].geometry.location.lng();

                    setPositionByGeoCoder(latitude, longitude);
                }
            }
        });

    }
}

function showPanelWarningLocation(){
    //showNotifyError("Não foi possível encontrar sua localização pelo endereço!");
    $("#panel-warning-location").show();
    $("html, body").animate({
        scrollTop: $("#latitude").offset().top
    }, 550);
}

function hidePanelWarningLocation(){
    $("#panel-warning-location").hide();
}

function showMap(){
    $("#col-map").show();
    setFocusMap();
}

function setFocusMap() {
    $("html, body").animate({
        scrollTop: $("#col-map").offset().top
    }, 550);
}

function showNotifySucess(message) {
    iziToast.success({
        title: 'OK',
        message: message,
        iconText: "check"
    });
}

function showNotifyError(message) {
    iziToast.error({
        title: 'Erro',
        message: message,
        iconText: "block"
    });
}

$(document).ready(function () {

    $("#btn-enable-location").click(function () {
        getMyLocation();
    });
});


