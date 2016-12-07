<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Informar coleta</title>
</head>

<body>
<main>
    <div class="section">
        <div class="container">
            <br/>
            <fieldset>
                <legend><h5 class="header">&nbsp;Informar coleta&nbsp;</h5></legend>

                <div id="divErrorMessage" class="row red-text hide">
                    <div class="col s12">
                        <div class="card-panel grey lighten-5">
                            <span id="errorMessage"></span>
                        </div>
                    </div>
                </div>

                <div>
                    <g:render template="form"></g:render>
                </div>

            </fieldset>

        </div>
    </div>
</main>
</body>
</html>
