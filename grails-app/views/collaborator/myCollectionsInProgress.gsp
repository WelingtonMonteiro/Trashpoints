<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Minhas coletas</title>
</head>
<body>

<main>
    <div class="section">
        <div class="container">
            <div class="row">
                <div class="col s12">
                    <h5 class="header">Minhas coletas em andamento</h5>
                </div>
            </div>
            <div class="row">
                <div id="listCollections" class="col s12">
                    <g:render template="listCollectionsInProgress" model="[collaboratorCollections:collaboratorCollections]"></g:render>
                </div>
            </div>
        </div>
    </div>
</main>

</body>
</html>
