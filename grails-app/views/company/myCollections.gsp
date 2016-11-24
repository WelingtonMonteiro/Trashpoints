<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="_company"/>
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
                <div id="listCollections" class="col s12">
                    <g:render template="listCollections" model="[companyCollections:companyCollections]"></g:render>
                </div>
            </div>
        </div>
    </div>
</main>

</body>
</html>
