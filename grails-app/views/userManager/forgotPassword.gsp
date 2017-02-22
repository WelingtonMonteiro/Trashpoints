<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Login</title>
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
                            <legend><h4 class="header">&nbsp;Recuperar Senha&nbsp;</h4></legend>


                            <g:form name='forgotPassword' useToken="true">

                                <g:if test='${emailSent}'>
                                    <div class="row">
                                        <div class="col s12 m12">
                                            <div class="card-panel grey lighten-5">
                                                <i class="material-icons left orange-text">warning</i>
                                                <span class="black-text">Um link com a recuperação de senha foi enviado para seu email!</span>
                                            </div>
                                        </div>
                                    </div>

                                </g:if>

                                <g:else>
                                    <div class="row">
                                        <div class="input-field col s12">
                                            <i class="material-icons prefix">contact_mail</i>
                                            <input id="email" name="username" type="email" class="validate" required/>
                                            <label for="email">E-mail <span class="red-text">*</span></label>
                                        </div>
                                    </div>


                                    <div class="preloader-wrapper big active">
                                        <div class="spinner-layer spinner-blue-only">
                                            <div class="circle-clipper left">
                                                <div class="circle"></div>
                                            </div>

                                            <div class="gap-patch">
                                                <div class="circle"></div>
                                            </div>

                                            <div class="circle-clipper right">
                                                <div class="circle"></div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="input-field col s12 center">
                                            <button class="btn-large waves-effect waves-light blue darken-3"
                                                    type="submit"
                                                    name="submit">
                                                <i class="material-icons left">mail_outline</i>Enviar
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
        $("#SYNCHRONIZER_TOKEN").val(data.newToken);
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
                title: 'Recuperar Senha',
                message: 'Link de recuperação enviado no email.',
                iconText: "check",
                onClose: function () {
                    window.location.href = "${application.contextPath}/userManager/login";
                }
            });
        }

    }


    function clearErrorMessage() {
        $('#divErrorMessage span#errorMessage').html("")
    }

    function clearInputs() {
        $('#btnClear').click();
        $("#username").val("");
        Materialize.updateTextFields();
    }

    $(".preloader-wrapper").hide();


    $("form").submit(function (e) {
        $(".btn-large").prop("disabled",true);
        $(".btn-large").html($(".preloader-wrapper").show());


        e.preventDefault();

        var urlData = $(this).serialize();
        $.ajax({
            type: "post",
            url: "${application.contextPath}/userManager/forgotPassword/",
            data: urlData,
            success: function (data) {
                $(".preloader-wrapper").hide();
                $(".btn-large").prop("disabled",false);

                showMessage(data)
            }
        });
    });

</script>

</body>
</html>