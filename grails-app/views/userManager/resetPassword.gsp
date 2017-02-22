<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Resetar Senha</title>
</head>

<body>
<main>
    <div class="section">
        <div class="container">
            <div class="row">
                <div class="col s12 offset-m2 m8 offset-l3 l6">
                    <br/>

                    <div id="formAuth">
                        <fieldset>
                            <legend><h4 class="header">&nbsp;Resetar Senha&nbsp;</h4></legend>


                            <g:form name='resetPassword' useToken="true">

                                <g:if test='${emailSent}'>
                                    <div class="row">
                                        <div class="col s12 m12">
                                            <div class="card-panel grey lighten-5">
                                                <i class="material-icons left orange-text">warning</i>
                                                <span class="black-text">Senha foi alterado com sucesso!</span>
                                            </div>
                                        </div>
                                    </div>

                                </g:if>

                                <g:else>

                                    <span class="black-text">Digite a nova senha</span>

                                    <g:hiddenField name='token' value='${token}'/>

                                    <div class="row">
                                        <div class="input-field col s12">
                                            <a id="btnShowPassword"
                                               class="waves-effect waves-indigo accent-2 btn-flat grey lighten-4 black-text button-show-password"
                                               onmousedown="showPassword()" onmouseup="hidePassword()">
                                                <i class="fa fa-eye"></i>
                                            </a>

                                            <i class="material-icons prefix">lock</i>
                                            <input id="password" name="j_password" type="password" class="validate"
                                                   required minlength="6">
                                            <label for="password">Nova senha <span class="red-text">*</span></label>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="input-field col s12 center">
                                            <button name="submit" type="submit" class="btn-large waves-effect waves-light blue darken-3">
                                                <i class="left material-icons">autorenew</i> Resetar
                                            </button>
                                        </div>
                                    </div>

                                </g:else>
                            </g:form>

                        </fieldset>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>
<script type="text/javascript">


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

        }
        if (data.success) {
            clearInputs();
            iziToast.success({
                title: 'Resetar Senha',
                message: 'Senha alterada com sucesso',
                iconText: "check",
                onClose: function () { window.location.href = "${application.contextPath}/userManager/login" ; }
            });
        }
        $("#SYNCHRONIZER_TOKEN").val(data.newToken);
    }


    function clearErrorMessage() {
        $('#divErrorMessage span#errorMessage').html("")
    }

    function clearInputs() {
        $('#btnClear').click();
        $("#username").val("");
        Materialize.updateTextFields();
    }

    $("form").submit(function (e) {
        e.preventDefault();
        var urlData = $(this).serialize();
        $.ajax({
            type: "post",
            url: "${application.contextPath}/userManager/resetPassword/",
            data: urlData,
            success: function (data) {
                showMessage(data)
            }
        });
    });


    function showPassword() {
        $("#password").attr("type", "text");
    }

    function hidePassword() {
        $("#password").attr("type", "password");
    }


</script>

</body>
</html>