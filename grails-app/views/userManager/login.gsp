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
                            <legend><h4 class="header">&nbsp;Login&nbsp;</h4></legend>
                            <form action='${request.contextPath}/j_spring_security_check' method='POST' class="section">

                                <g:render template="authLogin"></g:render>

                                <div class="row right-align ">
                                    <g:link controller="userManager" action="forgotPasswordView"><strong>Esqueceu a senha?</strong></g:link>
                                </div>

                                <g:if test="${error == "1"}">
                                    <div id="divErrorMessage" class="row red-text center-align">
                                        <span id="errorMessage">Usuário ou senha incorretos</span>
                                    </div>
                                </g:if>

                                <div class="row">
                                    <div class="input-field col s12 center">
                                        <button class="btn-large waves-effect waves-light blue darken-3" type="submit"
                                                name="submit">
                                            <i class="fa fa-sign-in left"></i>Entrar
                                        </button>
                                    </div>
                                </div>

                                <div class="row center-align ">
                                    <strong>Ainda não está cadastrado?
                                    <g:link controller="userManager" action="createUser">Cadastre-se</g:link>
                                    </strong>
                                </div>

                            </form>

                        </fieldset>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<script>
    function setActiveItemMenu() {
        $('li#login').addClass('active');
    }

    $(document).ready(function () {
        setActiveItemMenu();
    });
</script>

</body>
</html>