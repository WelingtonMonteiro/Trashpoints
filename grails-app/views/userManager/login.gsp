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
                    <div id="divErrorMessage" class="row red-text hide">
                        <div class="col s12">
                            <div class="card-panel grey lighten-5">
                                <span id="errorMessage"></span>
                            </div>
                        </div>
                    </div>
                    <br/>

                    <div id="formAuth">
                        <fieldset>
                            <legend><h4 class="header">&nbsp;Login&nbsp;</h4></legend>

                            <form action='${request.contextPath}/j_spring_security_check' method='POST' class="section">
                                <g:render template="authLogin"></g:render>

                                <div class="row">
                                    <div class="input-field col s12 center">
                                        <button class="btn-large waves-effect waves-light blue darken-3" type="submit"
                                                name="submit">
                                            <i class="fa fa-sign-in left"></i>Entrar
                                        </button>
                                    </div>
                                </div>

                            </form>
                        </fieldset>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

</body>
</html>