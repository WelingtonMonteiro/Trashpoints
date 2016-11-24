<!DOCTYPE html>
<html lang="pt-br">
<!--[if lt IE 7 ]> <html lang="pt-BR" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="pt-BR" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="pt-BR" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="pt-BR" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="pt-BR" class="no-js"><!--<![endif]-->
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title><g:layoutTitle default="TrashPoints Login"/></title>
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
                    <li><a class="grey-text text-lighten-3" href="#!">Traspoints</a></li>
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

%{--<div id="spinner" class="spinner" style="display:none;"><g:message code="spinner.alt" default="Loading&hellip;"/></div>--}%
<r:layoutResources />
<script type="text/javascript">
    $(document).ready(function () {
        $(".button-collapse").sideNav();
        $('.modal').modal();
    });
</script>
</body>
</html>
