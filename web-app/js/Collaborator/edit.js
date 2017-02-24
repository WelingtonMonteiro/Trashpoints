$('.datepicker').pickadate({
    selectMonths: true, // Creates a dropdown to control month
    selectYears: 100,// Creates a dropdown of 15 years to control year
    format: 'dd/mm/yyyy',
    max: new Date(),
    closeOnSelect: true,
    closeOnClear: true
});

jQuery(function ($) {
    $("#phone").mask("(99) 9999-9999");
    setActiveItemMenu();
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
    $('#divErrorMessage span#errorMessage').html("")
}

function clearInputs() {
    $('#btnClear').click()
    $("#password").val("");
    $("#username").val("");
    Materialize.updateTextFields();
}

$("form").submit(function (e) {
    e.preventDefault();

    if ($('#latitude').val() && $('#longitude').val()) {
        var urlData = $(this).serialize();
        $.ajax({
            type: "post",
            url: window.domain + "/Collaborator/saveEditCollaborator/",
            data: urlData,
            success: function (data) {
                showMessage(data)
            }
        });
    }else
        showNotifyError("Precisamos ter sua localização para poder cadastrar");
});

function setActiveItemMenu() {
    $('li#home').removeClass('active');
    $('#editProfile').addClass('active');
}