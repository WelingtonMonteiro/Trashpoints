var global_collect_id;

function openModalViewCollectImage(collectId) {
    $("#modalViewCollectImage").modal({
        dismissible: false
    })
    $("#modalViewCollectImage").modal('open');
    loadCollectImage(collectId)
}

function loadCollectImage(collectId) {
    $(".preloader-wrapper").show();

    $.ajax({
        url: domain + "/Collect/loadCollectImage/",
        data: {
            id: collectId
        },
        method: "post",
        success: function (data) {
            $("#collectImage").html("")
            var imageUpload = "<i class='fa fa-file-image-o fa-5x center-align'></i>"

            if (data.imagePath) {
                var UPLOAD_FOLDER_PATH = domain + "/images/uploads/" + data.imagePath;
                imageUpload = "<img src='" + UPLOAD_FOLDER_PATH + "' style='max-height: 284px;'>";
            }

            $("#collectImage").append(imageUpload)

        },
        complete: function () {
            $(".preloader-wrapper").hide();
        }
    });
}

function openModalCollaboratorDetails(collaboratorId) {
    $("#modalCollaboratorDetails").modal({
        dismissible: false
    })
    $("#modalCollaboratorDetails").modal('open');
    loadCollaboratorDetails(collaboratorId)
}

function loadCollaboratorDetails(collaboratorId) {
    $(".preloader-wrapper").show();

    $.ajax({
        url: domain + "/Company/loadCollaboratorDetails/",
        data: {
            id: collaboratorId
        },
        method: "post",
        success: function (data) {
            var collaborator = data.collaborator
            var address = data.address

            if (collaborator) {
                $("#collaboratorDetails span#name").text(collaborator.name)
                $("#collaboratorDetails span#phone").text(collaborator.phone)
            }
            if (address) {
                $("#collaboratorDetails span#zipCode").text(address.zipCode)
                $("#collaboratorDetails span#street").text(address.street)
                $("#collaboratorDetails span#number").text(address.number)
                $("#collaboratorDetails span#neighborhood").text(address.neighborhood)
                $("#collaboratorDetails span#city").text(address.city)
                $("#collaboratorDetails span#state").text(address.state)
            }
        },
        complete: function () {
            $(".preloader-wrapper").hide();
        }

    });
}

function openModalConfirmation(collectId) {
    global_collect_id = collectId
    $("input[type=hidden]#collectId").val(collectId)
    $("#modalConfirmationCollect").modal({
        dismissible: false
    })
    $("#modalConfirmationCollect").modal('open');
}

function markWasCollected() {
    var collectId = global_collect_id
    var formData = jQuery("form[name=formCollections]").serializeArray();

    $.ajax({
        url: domain + "/Company/markWasCollected/",
        data: formData,
        method: "post",
        success: function (data) {
            if (data.success) {
                iziToast.success({
                    title: 'OK',
                    message: 'Sucesso ao salvar!',
                    iconText: "check"
                });
                disableCheckBoxClicked(collectId);
                $("#collectedDate" + collectId).text(data.collectedDate);
                //window.localStorage.removeItem("")
            }
            $("#SYNCHRONIZER_TOKEN").val(data.newToken);
        }
    });
}

function wasNotCollected() {
    var collectId = global_collect_id
    $("input[type=checkbox]#isCollected" + collectId).prop("checked", false)
}

function disableCheckBoxClicked(collectId) {
    $("input[type=checkbox]#isCollected" + collectId).prop("disabled", true).removeAttr("onchange")
}

/*function openModalUpdateScheduleDate(dateTimeCollect, collectId) {
 $('#txb-collect-date').val(moment(dateTimeCollect).format('DD/MM/YYYY'));
 $('#txb-collect-time').val(moment(dateTimeCollect).format('HH:mm'));
 $('#fld-collect-id').val(collectId);
 $('#dateTimeToCollectModal').modal({
 dismissible: false, // Modal can be dismissed by clicking outside of the modal
 startingTop: '2%', // Starting top style attribute
 endingTop: '2%'
 });
 $('#dateTimeToCollectModal').modal('open');
 Materialize.updateTextFields();
 }
 */

/*function updateScheduleDateCollect() {
 var dateTime = $('#txb-collect-date').val() + " " + $('#txb-collect-time').val();
 $("#scheduleDateCollect" + $('#fld-collect-id').val()).text(dateTime);
 }*/

/*$(document).ready(function () {
 var MAX_DATE = moment().add(3, 'day').toDate();

 $('.datepicker').pickadate({
 selectMonths: false,
 selectYears: 3,
 min: new Date(),
 max: MAX_DATE
 });

 $('.timepicker').pickatime({
 autoclose: false,
 twelvehour: false,
 default: '00:00:00',
 donetext: 'OK'
 });

 $('#txb-collect-date').on('focus', function () {
 $('.picker').appendTo('body');
 });
 $('#txb-collect-time').on('focus', function () {
 $('.picker').appendTo('body');
 });

 // ** Configuracao dos eventos de clique dos botoes no modal de data e hora
 $('#btn-cancel-datetime-collect').on('click', function () {
 $('#dateTimeToCollectModal').modal('close');
 });

 $('#btn-schedule-collect').on('click', function () {
 if ($('#txb-collect-date').val() == '') {
 iziToast.error({
 title: 'Erro',
 message: 'Por favor, selecione a data planejada para coleta.',
 iconText: "block"
 });
 return false;
 }
 if ($('#txb-collect-time').val() == '') {
 iziToast.error({
 title: 'Erro',
 message: 'Por favor, selecione a hora planejada para coleta.',
 iconText: "block"
 });
 return false;
 }
 var selectedDate = moment($('#txb-collect-date').val(), 'DD/MM/YYYY').toDate();
 if (moment(new Date()).isAfter(selectedDate, 'day')) {
 iziToast.error({
 title: 'Erro',
 message: 'A data de coleta planejada deve ser maior ou igual que a data de hoje',
 iconText: "block"
 });
 return false;
 }
 var formData = [];
 var id = {
 name: "id",
 value: $('#fld-collect-id').val()
 };
 formData.push(id);
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
 url: domain + "/Collect/updateDateTimeCollect/",
 data: formData,
 method: "post",
 success: function (data) {
 if (data.success) {
 iziToast.success({
 title: 'OK',
 message: 'Sucesso ao salvar!',
 iconText: "check"
 });
 updateScheduleDateCollect();
 } else if (data.error) {
 iziToast.error({
 title: 'Erro',
 message: 'Operação ilegal!',
 iconText: "block"
 });
 }
 $("#SYNCHRONIZER_TOKEN").val(data.newToken);
 }
 });

 $('#dateTimeToCollectModal').modal('close');
 });
 });*/