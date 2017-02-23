<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Minhas coletas</title>
    <style>
    .picker__holder {
        overflow: hidden !important;
    }
    </style>
    %{--<link href="${application.contextPath}/css/materialize.clockpicker.css" rel="stylesheet">--}%
</head>

<body>

<main>
    <div class="section">
        <div class="container">
            <div class="row">
                <div class="col s12">
                    <h5 class="header">Minhas coletas recolhidas</h5>
                </div>
            </div>

            <div class="row">
                <div id="listCollections" class="col s12">
                    <g:render template="listCollectionsCollected" model="[companyCollections: companyCollections]"></g:render>
                </div>
            </div>
        </div>
    </div>
</main>

</body>
</html>
