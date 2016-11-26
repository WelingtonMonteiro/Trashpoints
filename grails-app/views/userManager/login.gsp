<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="mainOld"/>
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

                    <div id="formAuth">
                        <g:render template="authLogin"></g:render>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>


</body>
</html>


%{--
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Área restrita - Restaurante Tô com fome</title>
</head>
<body>
<form action='${request.contextPath}/j_spring_security_check' method='POST' id='frmLogar' name='frmLogar'>
    <p>
        Email
        <input type='text' name='j_username' id='username' />
    </p>
    <p>
        Senha
        <input type='password' name='j_password' id='password' />
    </p>
    <input type="submit" value="Entrar" />
</form>
</body>
--}%
</html>
