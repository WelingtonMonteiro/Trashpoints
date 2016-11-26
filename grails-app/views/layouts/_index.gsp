<header>
    <nav id="top-menu" class="indigo accent-2">
        <a href="/Trashpoints" class="page-title">TrashPoints</a>
        <ul class="right">
            <li>
                <a href="/Trashpoints/userManager/login" class="hide-on-small-only waves-effect waves-light">
                    <i class="fa fa-2x fa-sign-in" style="margin-right: 15px;"></i>Logar
                </a>
            </li>
            <!-- Dropdown Structure -->
            <ul id="dropdown-creates" class="dropdown-content hide-on-small-only">
                <li>
                    <a href="/Trashpoints/Collaborator/Create" class="hide-on-small-only waves-effect waves-light">
                        <i class="material-icons left">person_add</i>Colaborador
                    </a>
                </li>
                <li>
                    <a href="/Trashpoints/Company/Create" class="hide-on-small-only waves-effect waves-light">
                        <i class="material-icons left">business</i>Empresa
                    </a>
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
        <li class="active"><a class="waves-effect active" href="/Trashpoints">Home<i class="material-icons">home</i></a></li>
        <li><a class="waves-effect hide-on-large-only" href="/Trashpoints/userManager/login"><i class="fa fa-2x fa-sign-in"></i>Logar</a></li>

        <li class="no-padding">
            <ul class="collapsible collapsible-accordion">
                <li>
                    <a class="collapsible-header waves-effect">Cadastrar<i class="material-icons">arrow_drop_down</i></a>
                    <div class="collapsible-body">
                        <ul>
                            <li>
                                <a class="waves-effect hide-on-large-only" href="/Trashpoints/Collaborator/Create"><i class="material-icons left">person_add</i>Cadastrar Cidadão
                                </a>
                            </li>
                            <li>
                                <a class="waves-effect hide-on-large-only" href="/Trashpoints/Company/Create"><i class="material-icons left">business</i>Cadastrar Empresa
                                </a>
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

