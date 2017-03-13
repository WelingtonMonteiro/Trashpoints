/*function formData(){
    return new FormData($("#imageUpload").val())
}*/


//enviando arquivo via form/data
$('form[name=formCollect]').submit(function(e){

    e.preventDefault();
    var file = e.target.imageUpload.files[0];


    uploadImage(file, function(err, imageName){
        if(err) {
            iziToast.error({
                title: 'Erro Upload',
                message: err,
                iconText: "check"
            })
            return;
        }

        if(hasLeastOneMaterialTypeChecked() == true) {
            var oData = new FormData(document.forms.namedItem("formCollect"));
            var url = window.domain + "/Collect/save/";
            $.ajax({
                url: url,
                type: 'POST',
                data: oData,
                processData: false,  // tell jQuery not to process the data
                contentType: false,
                success: function (data) {
                    showMessage(data)
                }
            });
        }
    })

});

function showMessage(data) {
    clearErrorMessage()

    if (data.error) {
        $('#divErrorMessage').removeClass("hide")
        var errors = data.error
        $.each(errors, function (key, value) {
            var errorMessage = value

            var p = '<p>' + errorMessage + '</p>'
            $('#divErrorMessage span#errorMessage').append(p)
        });
        setFocusSummaryErrorMessage()
    }
    if (data.success) {
        clearInputs();
        iziToast.success({
            title: 'OK',
            message: 'Sucesso ao salvar!',
            iconText: "check"
        });
    }

    $("#SYNCHRONIZER_TOKEN").val(data.newToken);
}

function setFocusSummaryErrorMessage() {
    $(window).scrollTop($('#divErrorMessage').offset().top);
}

function clearErrorMessage() {
    $('#divMessageError span#messageError').html("");
}

function clearInputs() {
    $('#btnClear').click();
    Materialize.updateTextFields();
}

function hasLeastOneMaterialTypeChecked() {
    var isChecked = false;
    var elementErrorRequired = document.getElementById("errorRequired");
    var elementsCheckboxes = document.getElementsByName("materialTypes")

    for (var i = 0; i < elementsCheckboxes.length; i++) {
        if( elementsCheckboxes[i].checked == true ) {
            isChecked = true;
            break;
        }
    }

    if(isChecked)
    //elementErrorRequired.setCustomValidity("");
        elementErrorRequired.innerHTML = "";
    else
        elementErrorRequired.innerHTML = "Selecione pelo menos uma opção";
    //elementErrorRequired.setCustomValidity("Selecione pelo menos uma opção");*/

    return isChecked;
}

function setActiveItemMenu() {
    $('li#home').removeClass('active');
    $('li#createCollect').addClass('active');
}

$(document).ready(function () {
    setActiveItemMenu();
});

