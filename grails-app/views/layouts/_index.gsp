<header>
    <nav id="top-menu" class="indigo accent-2">
        <a  href="${application.contextPath}/" class="brand-logo left margin-left-3rem">
            <img src="${resource(dir: 'images', file: 'trashPoints_logo_miniatura_alpha.png')}" class="img-responsive" />
        </a>
        <ul class="right">
            <li>
                <a href="${application.contextPath}/userManager/login" class="hide-on-small-only waves-effect waves-light">
                    <i class="fa fa-2x fa-sign-in" style="margin-right: 15px;"></i>Logar
                </a>
            </li>
            <!-- Dropdown Structure -->
            <ul id="dropdown-creates" class="dropdown-content hide-on-small-only">
                <li>
                    <a href="${application.contextPath}/Collaborator/Create" class="hide-on-small-only waves-effect waves-light">
                        <i class="material-icons left">person_add</i>Colaborador
                    </a>
                </li>
                <li>
                    <g:link controller="company" action="create" class="hide-on-small-only waves-effect waves-light">
                        <i class="material-icons left">business</i>Empresa
                    </g:link>
                </li>
            </ul>
            <li>
                <a class="dropdown-button waves-effect waves-light hide-on-small-only" href="#!" data-beloworigin="true" data-activates="dropdown-creates">
                    &nbsp;&nbsp;&nbsp;&nbsp;Cadastrar&nbsp;&nbsp;&nbsp;<i class="material-icons right">arrow_drop_down</i>
                </a>
            </li>
        </ul>

        <a href="#" data-activates="side-menu" class="button-collapse hide-on-large-only"><i class="material-icons">menu</i></a>
    </nav>

    <ul id="side-menu" class="side-nav">
        <li id="home"><a class="waves-effect" href="${application.contextPath}/">Home<i class="material-icons">home</i></a></li>
        <li id="login"><a class="waves-effect hide-on-large-only" href="${application.contextPath}/userManager/login"><i class="fa fa-2x fa-sign-in"></i>Logar</a></li>

        <li class="no-padding">
            <ul class="collapsible collapsible-accordion">
                <li>
                    <a class="collapsible-header waves-effect">Cadastrar<i class="material-icons">arrow_drop_down</i></a>
                    <div class="collapsible-body">
                        <ul>
                            <li id="createCollaborator">
                                <a class="waves-effect hide-on-large-only" href="${application.contextPath}/Collaborator/Create"><i class="material-icons left">person_add</i>Cadastrar Cidadão
                                </a>
                            </li>
                            <li id="createCompany">
                                <g:link controller="company" action="create" class="waves-effect hide-on-large-only">
                                    <i class="material-icons left">business</i>Cadastrar Empresa
                                </g:link>
                            </li>
                        </ul>
                    </div>
                </li>
            </ul>
        </li>


    </ul>
</header>

<style>
    header, main, footer {
        padding-left: 0px;
    }
</style>



