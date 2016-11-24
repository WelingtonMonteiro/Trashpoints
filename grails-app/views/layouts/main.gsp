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
        <a class="page-title" href="/Trashpoints">TrashPoints</a>
        <ul class="right">
            <li><a href="#" class="hide-on-small-only">Nome usuário logada</a></li>
        </ul>
        <a href="#" data-activates="side-menu" class="button-collapse hide-on-large-only"><i class="material-icons">menu</i></a>
    </nav>

    <ul id="side-menu" class="side-nav fixed">
        <li><a class="waves-effect hide-on-large-only" href="#">Nome usuário logada<i class="material-icons">account_circle</i></a></li>
        <li class="active"><a class="waves-effect active" href="/Trashpoints">Home<i class="material-icons">home</i></a></li>
        <li><a class="waves-effect" href="#">Meus TrashPoints<i class="material-icons">monetization_on</i></a></li>
        <li><div class="divider"></div></li>
        <li><a class="subheader">Editar meus dados</a></li>
        <li class="no-padding">
            <ul class="collapsible collapsible-accordion">
                <li>
                    <a class="collapsible-header waves-effect">Dados do Colaborador<i class="material-icons">arrow_drop_down</i></a>
                    <div class="collapsible-body">
                        <ul>
                            <li><a class="waves-effect" href="/Trashpoints/Collaborator/Create">Cadastrar Perfil Colaborador<i class="material-icons">account_circle</i></a></li>
                            <li><a class="waves-effect" href="#">Editar Perfil Colaborador<i class="material-icons">edit_location</i></a></li>
                        </ul>
                    </div>
                </li>
                <li>
                    <a class="collapsible-header waves-effect">Dados da Empresa<i class="material-icons">arrow_drop_down</i></a>
                    <div class="collapsible-body">
                        <ul>
                            <li><a class="waves-effect" href="/Trashpoints/Company/Create">Cadastrar Perfil Empresa<i class="material-icons">account_circle</i></a></li>
                            <li><a class="waves-effect" href="#">Editar Perfil Empresa<i class="material-icons">edit_location</i></a></li>
                        </ul>
                    </div>
                </li>
            </ul>
        </li>
        <li><div class="divider"></div></li>
        <li><a class="waves-effect" href="/Trashpoints/Collect/MyCollections">Minhas Coletas<i class="fa fa-recycle fa-2x" aria-hidden="true"></i></a></li>
        <li><a class="waves-effect" href="/Trashpoints/Collect/Create">Tenho uma Coleta<i class="fa fa-bullhorn fa-2x" aria-hidden="true"></i></a></li>
        <li><a class="waves-effect" href="#">Notificações<i class="material-icons">notifications</i></a></li>
        <li><a class="waves-effect" href="#">Sair<i class="fa fa-2x fa-sign-out" aria-hidden="true"></i></a></li>
    </ul>
</header>

<g:layoutBody/>

<g:render template="/layouts/footer"></g:render>

<r:layoutResources />

<script type="text/javascript">
    $(document).ready(function () {
        $(".button-collapse").sideNav();
        $('.modal').modal();
    });
</script>
</body>
</html>
