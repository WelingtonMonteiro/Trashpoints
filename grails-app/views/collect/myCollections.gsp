<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="_client"/>
    <title>Minhas coletas</title>
</head>
<body>

<main>
    <div class="section">
        <div class="container">
            <div class="row">
                <div class="col s12">
                    <h4 class="header">Minhas coletas</h4>
                </div>
            </div>
            <div class="row">
                <div class="col s12">
                    <g:render template="listColletions" model="[clientCollections:clientCollections]"></g:render>
                </div>
            </div>
        </div>
    </div>
</main>

</body>
</html>
