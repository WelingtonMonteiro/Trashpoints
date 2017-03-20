<header>
    <nav id="top-menu" class="indigo accent-2">
        <a  href="${application.contextPath}/" class="brand-logo left margin-left-3rem">
            <img src="${resource(dir: 'images', file: 'trashPoints_logo_miniatura_alpha.png')}" class="img-responsive" />
        </a>
        <ul class="right">
            <li>
                <g:link controller="userManager" action="login" class="hide-on-small-only waves-effect waves-light">
                    <i class="fa fa-2x fa-sign-in" style="margin-right: 15px; margin-bottom: -7px;"></i>Logar
                </g:link>
            </li>
            <li>
                <g:link controller="userManager" action="createUser" class="hide-on-small-only waves-effect waves-light">
                    <i class="material-icons left">person_add</i>Cadastrar-se
                </g:link>
            </li>
        </ul>

        <a href="#" data-activates="side-menu" class="button-collapse hide-on-large-only"><i class="material-icons">menu</i></a>
    </nav>

    <ul id="side-menu" class="side-nav">
        <li id="home"><a class="waves-effect" href="${application.contextPath}/">Home<i class="material-icons">home</i></a></li>
        <li id="login">
            <g:link controller="userManager" action="login" class="waves-effect hide-on-large-only">
                <i class="fa fa-2x fa-sign-in"></i>Logar
            </g:link>
        </li>

        <li id="createUser">
            <g:link controller="userManager" action="createUser" class="waves-effect hide-on-large-only">
                <i class="material-icons left">person_add</i>Cadastrar-se
            </g:link>
        </li>


    </ul>
</header>

<style>
    header, main, footer {
        padding-left: 0px;
    }
</style>



