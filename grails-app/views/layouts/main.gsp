<!DOCTYPE html>
<html lang="pt-br">
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title><g:layoutTitle default="TrashPoints"/></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'materialize.css')}" type="text/css" media="screen,projection">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" />
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'font-awesome.min.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'style.css')}" type="text/css">
    %{--<script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.8/js/materialize.min.js"></script>--}%
    <script src="/Trashpoints/js/jquery-2.1.1.min.js" type="text/javascript"></script>
    <script src="/Trashpoints/js/materialize.min.js" type="text/javascript"></script>
    <script src="/Trashpoints/js/jquery.maskedinput.min.js" type="text/javascript"></script>
    <g:layoutHead/>
    <g:javascript library="application"/>
    <r:layoutResources />
</head>
<body>
%{--<div id="grailsLogo" role="banner"><a href="http://grails.org"><img src="${resource(dir: 'images', file: 'grails_logo.png')}" alt="Grails"/></a></div>--}%
<header>
    <nav id="top-menu" class="indigo accent-2">
        <a href="/Trashpoints" class="page-title">TrashPoints</a>
        <ul class="right">
            <li>
                <a href="#" class="hide-on-small-only waves-effect waves-light">
                    <i class="fa fa-2x fa-sign-in" style="margin-right: 15px;"></i>Logar
                </a>
            </li>
            <!-- Dropdown Structure -->
            <ul id="dropdown-creates" class="dropdown-content hide-on-small-only">
                <li>
                    <a href="/Trashpoints/Client/Create" class="hide-on-small-only waves-effect waves-light">
                        <i class="material-icons left">person_add</i>Cidadão
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
                    &nbsp;Cadastrar&nbsp;<i class="material-icons right">arrow_drop_down</i>
                </a>
            </li>
        </ul>

        <a href="#" data-activates="side-menu" class="button-collapse hide-on-large-only"><i class="material-icons">menu</i></a>
    </nav>

    <ul id="side-menu" class="side-nav">
        <li class="active"><a class="waves-effect active" href="/Trashpoints">Home<i class="material-icons">home</i></a></li>
        <li><a class="waves-effect hide-on-large-only" href="#"><i class="fa fa-2x fa-sign-in"></i>Logar</a></li>

        <li class="no-padding">
            <ul class="collapsible collapsible-accordion">
                <li>
                    <a class="collapsible-header waves-effect">Cadastrar<i class="material-icons">arrow_drop_down</i></a>
                    <div class="collapsible-body">
                        <ul>
                            <li>
                                <a class="waves-effect hide-on-large-only" href="/Trashpoints/Company/Create"><i class="material-icons left">person_add</i>Cadastrar Cidadão
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

<g:layoutBody/>

<footer class="page-footer indigo accent-2" role="contentinfo">
    <div class="container">
        <div class="row">
            <div class="col l6 s12">
                <h5 class="white-text">Footer Content</h5>
                <p class="grey-text text-lighten-4">You can use rows and columns here to organize your footer content.</p>
            </div>
            <div class="col l4 offset-l2 s12">
                <h5 class="white-text">Links</h5>
                <ul>
                    <li><a class="grey-text text-lighten-3" href="#!">Link 1</a></li>
                    <li><a class="grey-text text-lighten-3" href="#!">Link 2</a></li>
                    <li><a class="grey-text text-lighten-3" href="#!">Link 3</a></li>
                    <li><a class="grey-text text-lighten-3" href="#!">Link 4</a></li>
                </ul>
            </div>
        </div>
    </div>
    <div class="footer-copyright">
        <div class="container">
        &copy; 2016 Copyright
            <a class="grey-text text-lighten-4 right" href="#">More Links</a>
        </div>
    </div>
</footer>

<r:layoutResources />

<style>
header, main, footer {
    padding-left: 0px;
}
</style>

<script type="text/javascript">
    $(document).ready(function () {
        $(".button-collapse").sideNav();
    });
</script>
</body>
</html>
