jQuery(function ($) {
    $("#phone").mask("(99) 9999-9999");
    $("#identificationNumber").mask("99.999.999/9999-99");
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
        //clearInputs();
        //var successMessage = data.success;
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

$("form").submit(function(e) {
    e.preventDefault();
    var urlData = $(this).serialize();
    $.ajax({
        type: "post",
        url: window.domain = "/Company/saveEditCompany/",
        data: urlData,
        success: function(data)
        {
            showMessage(data)
        }
    });
});

function setActiveItemMenu() {
    $('#editProfile').addClass('active');
}