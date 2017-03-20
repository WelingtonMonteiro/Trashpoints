<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Cadastrar Usuário</title>
</head>

<body>
<main>
    <div class="section">
        <div class="container">
            <div class="row center-align">
                <h4 class="header bold">Cadastrar Usuário</h4><hr /><br />

                <div class="col s12 m6 l4 ">
                    <div class="card medium hoverable">
                        <div class="card-image">
                            <i class="material-icons" style="font-size: 11rem; color: #5f5f5f;">business</i>
                        </div>

                        <div class="card-content">
                            <p class="title-type-users">Empresa de coleta</p>
                            <p class="light center">Cadastre sua empresa de coleta seletiva.</p>
                        </div>

                        <div class="card-action">

                            <g:link controller="company" action="create" class="waves-effect waves-light">
                                <i class="material-icons left">person_add</i>Cadastrar-se</g:link>
                        </div>
                    </div>
                </div>

                <div class="col s12 m6 l4 ">
                    <div class="card medium hoverable">
                        <div class="card-image">
                            <i class="material-icons" style="font-size: 11rem; color: #5f5f5f;">person</i>
                        </div>

                        <div class="card-content">
                            <p class="title-type-users">Colaborador</p>
                            <p class="light center">Cadastre-se como um colaborador para notificar as empresas e coletores que você possui coletas para ser recolhidas.</p>
                        </div>

                        <div class="card-action">
                            <g:link controller="collaborator" action="create" class="waves-effect waves-light">
                                <i class="material-icons left">person_add</i>Cadastrar-se</g:link>
                        </div>
                    </div>
                </div>

                <div class="col s12 m6 l4 ">
                    <div class="card medium hoverable">
                        <div class="card-image">
                            <img class="img-responsive" style="margin-left: auto;margin-right: auto;" src="${resource(dir: 'images', file: 'garbage_collector.svg')}">
                            <br/>
                        </div>

                        <div class="card-content">
                            <p class="title-type-users">Coletor de reciclagem</p>
                            <p class="light center">Cadastre-se como coletor de reciclagem.</p>
                        </div>

                        <div class="card-action">
                            <g:link controller="collaborator" action="create" class="waves-effect waves-light btn-disabled">
                                <i class="material-icons left">person_add</i>Cadastrar-se</g:link>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</main>
<script type="text/javascript">
    function setActiveItemMenu() {
        $('li#createUser').addClass('active');
    }

    $(document).ready(function () {
        setActiveItemMenu();
    });
</script>

</body>
</html>