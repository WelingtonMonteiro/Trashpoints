<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Edição de colaborador</title>
</head>
<body>
<main>
    <div class="section">
        <div class="container">
            <div class="row">
                <div class="col s12 offset-m1 m10 offset-l2 l8">
                    <div id="divErrorMessage" class="row red-text hide">
                        <div class="col s12">
                            <div class="card-panel grey lighten-5">
                                <span id="errorMessage"></span>
                            </div>
                        </div>
                    </div>

                    <div id="divCollaborator">
                        <g:render template="formEdit"></g:render>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>
</body>
</html>
