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
                    <h5 class="header">Minhas coletas em andamento</h5>
                </div>
            </div>

            <div class="row">
                <div id="listCollections" class="col s12">
                    <g:render template="listCollections" model="[companyCollections: companyCollections]"></g:render>
                </div>
            </div>
        </div>
    </div>
</main>

<!-- Modal Collect Confirmation -->
<div id="modalConfirmationCollect" class="modal">
    <div class="modal-content">
        <h5>Confirmação da ação</h5>

        <p>Deseja realmente marcar que a coleta foi recolhida?</p>
    </div>

    <div class="modal-footer">
        <a class="modal-action modal-close waves-effect waves-light btn-flat" onclick="wasNotCollected()">Não</a>
        <a class="modal-action modal-close waves-effect waves-light btn-flat" onclick="markWasCollected()">Sim</a>
    </div>
</div>

</body>
</html>
