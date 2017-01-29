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
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'materialize.min.css')}" type="text/css" media="screen,projection">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" />
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'font-awesome.min.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'style.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'iziToast.min.css')}" type="text/css">
    <script src="/Trashpoints/js/iziToast.min.js" type="text/javascript"></script>
    <script src="/Trashpoints/js/jquery-2.1.1.min.js" type="text/javascript"></script>
    <script src="/Trashpoints/js/materialize.min.js" type="text/javascript"></script>
    <script src="/Trashpoints/js/jquery.maskedinput.min.js" type="text/javascript"></script>
    <g:layoutHead/>
    <g:javascript library="application"/>
    <r:layoutResources />
</head>
<body>
%{--<div id="grailsLogo" role="banner"><a href="http://grails.org"><img src="${resource(dir: 'images', file: 'grails_logo.png')}" alt="Grails"/></a></div>--}%

<sec:ifNotLoggedIn>
    <g:render template="/layouts/index"></g:render>
</sec:ifNotLoggedIn>

<sec:ifAnyGranted roles="ROLE_COLLABORATOR">
    <g:render template="/layouts/collaborator"></g:render>
</sec:ifAnyGranted>

<sec:ifAnyGranted roles="ROLE_COMPANY_COLLECT">
    <g:render template="/layouts/company"></g:render>
</sec:ifAnyGranted>

<g:layoutBody/>

<g:render template="/layouts/footer"></g:render>

<r:layoutResources />

<script type="text/javascript">
    $(document).ready(function () {
        $(".button-collapse").sideNav();
        $('.modal').modal();
        iziToast.settings({
            timeout: 3500,
            resetOnHover: false,
            position: 'topRight',
            balloon: true,
            icon: "material-icons",
            layout: 2
        });
    });
</script>
</body>
</html>
