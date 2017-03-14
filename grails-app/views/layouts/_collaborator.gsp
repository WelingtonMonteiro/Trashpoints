<style>
#notification-list sub {
    color: black !important;
}
</style>

<!-- Notifications -->
<ul id="notification-list" class="dropdown-content">
    <li class="divider"></li>
</ul>

<header>
    <nav id="top-menu" class="indigo accent-2">
        <a href="${application.contextPath}" class="brand-logo left margin-left-3rem ">
            <img src="${resource(dir: 'images', file: 'trashPoints_logo_miniatura_alpha.png')}" class="img-responsive"/>
        </a>
        <ul class="right">
            <li>
                <a class="dropdown-button hide-on-small-only" href="#!" data-activates="notification-list" id="btn-show-notification">
                    Notificações <span class="new badge red" id="bdg-qtde-notifications" data-badge-caption="novas">0</span>
                </a>
            </li>
            <li>
                <a class="hide-on-small-only"><sec:loggedInUserInfo field="username"/></a>
            </li>
        </ul>
        <a href="#" data-activates="side-menu" class="button-collapse hide-on-large-only"><i
                class="material-icons">menu</i></a>
    </nav>

    <ul id="side-menu" class="side-nav fixed">
        <li><a class="waves-effect hide-on-large-only"><sec:loggedInUserInfo field="username"/><i
                class="material-icons">account_circle</i></a></li>
        <li id="home" class="active"><a class="waves-effect" href="${application.contextPath}">Home<i class="material-icons">home</i></a></li>
        <li>
            <a class="waves-effect" href="${application.contextPath}/Collaborator/myCollectedCollections" title="Meus TrashCoins">
                <i class="material-icons">monetization_on</i>
                <span id="quantityOfCoins" class="new badge my-badge bold" data-badge-caption="" ></span>
            </a>
        </li>
        <li><div class="divider"></div></li>
        <li><a class="subheader">Editar meus dados</a></li>
        <li class="no-padding">
            <ul class="collapsible collapsible-accordion">
                <li>
                    <a class="collapsible-header waves-effect">Meus dados<i class="material-icons">arrow_drop_down</i></a>

                    <div class="collapsible-body">
                        <ul>
                            <li id="editProfile">
                                <a class="waves-effect" href="${application.contextPath}/collaborator/editCollaborator">
                                    Editar Perfil<i class="material-icons">account_circle</i>
                                </a>
                            </li>
                            <!-- <li><a class="waves-effect" href="#">Editar Endereço<i class="material-icons">edit_location</i></a></li> -->
                        </ul>
                    </div>
                </li>
            </ul>
        </li>

        <li><div class="divider"></div></li>
        <li><a class="subheader">Minhas Coletas</a></li>
        <li class="no-padding">
            <ul class="collapsible collapsible-accordion">
                <li>
                    <a class="collapsible-header waves-effect">
                        Minhas Coletas<i class="material-icons fa-2x">arrow_drop_down</i>
                    </a>

                    <div class="collapsible-body">
                        <ul>
                            <li id="myCollectedCollections"><a class="waves-effect" href="${application.contextPath}/Collaborator/myCollectedCollections">Coletadas<i class="fa fa-recycle fa-2x" aria-hidden="true"></i></a></li>
                            <li id="myCollectionsInProgress"><a class="waves-effect" href="${application.contextPath}/Collaborator/myCollectionsInProgress">A Recolher<i class="material-icons fa-2x">event_note</i></a></li>
                        </ul>
                    </div>
                </li>
            </ul>
        </li>

        <li id="createCollect">
            <a class="waves-effect" href="${application.contextPath}/Collect/Create">
                Tenho uma Coleta<i class="fa fa-bullhorn fa-2x" aria-hidden="true"></i>
            </a>
        </li>
        <li id="ranking"><a class="waves-effect" href="${application.contextPath}/Collaborator/ranking">Ranking Top 10<i class="material-icons">equalizer</i></a></li>
        <li><a class="waves-effect" href="#">Notificações<i class="material-icons">notifications</i></a></li>
        <li><a class="waves-effect" href="${application.contextPath}/ContactUs/index">Fale conosco<i class="material-icons">hearing</i></a></li>
        <li><a class="waves-effect" href="${application.contextPath}/j_spring_security_logout">Sair<i class="fa fa-2x fa-sign-out"
                                                                                        aria-hidden="true"></i></a></li>
    </ul>
</header>

<script type="text/javascript">

    var notificationsAlreadyAccessed = false;

    $(document).ready(function () {
        // Loading notifications
        $('#bdg-qtde-notifications').removeClass('red').text('??');
        //$('#notification-list').find('li:lt(3)').remove();
        $.ajax({
            type: 'get',
            url: "${application.contextPath}/Notification/getNotifications",
            success: function (data) {
                if (data.length > 0) {
                    var newNotifications = 0;
                    $.each(data, function (idx, obj) {
                        if (obj.wasRead == 0) {
                            newNotifications++;
                        }
                        if (obj.wasRead == 0) {
                            $('#notification-list').find('li.divider')
                                    .before('<li style="background-color: #ddd;">' +
                                            '   <a href="#!"> ' +
                                            '       <sub>' + obj.header + '</sub><br> ' +
                                            obj.body +
                                            '   </a> ' +
                                            '</li>');
                        } else {
                            $('#notification-list').find('li.divider')
                                    .before('<li>' +
                                            '   <a href="#!"> ' +
                                            '       <sub>' + obj.header + '</sub><br> ' +
                                            obj.body +
                                            '   </a> ' +
                                            '</li>');
                        }
                    });
                    if (newNotifications > 0) {
                        $('#bdg-qtde-notifications').addClass('red').text(newNotifications.toString());
                    } else {
                        $('#bdg-qtde-notifications').removeClass('red').text(newNotifications.toString());
                    }
                } else {
                    $('#bdg-qtde-notifications').removeClass('red').text('0');
                    $('#notification-list').find('li.divider')
                            .before('<li><a href="#">' +
                                    ' Não existem novas notificações.' +
                                    '</a></li>');
                }
            },
            error: function () {
                $('#notification-list').find('li.divider')
                        .before('<li><a href="#">' +
                                ' <i>Houve um erro ao tentar recuperar as notificações</i>' +
                                '</a></li>');
            }
        });

        $.ajax({
            type: "post",
            url: "${application.contextPath}/Collaborator/sumQuantityOfCoins/",
            success: function (data) {
                if(!data) return  $("#quantityOfCoins").text(0);
                $("#quantityOfCoins").text(data.quantityOfCoins);
            }
        });

        $('#btn-show-notification').on('click', function () {
            if (notificationsAlreadyAccessed) {
                $('#notification-list > li').css({'background-color': 'white'});
            }
            while (!$('#notification-list').is(':visible')) {
            }
            $('#notification-list').css({'top': '52px'});
            $('#notification-list').css({'width': '350px'});
            if ($('#bdg-qtde-notifications').text() != '0') {
                $.post("${application.contextPath}/Notification/setLastNotificationsAsRead/");
            }
            $('#bdg-qtde-notifications').removeClass('red').text('0');
            if (!notificationsAlreadyAccessed) {
                notificationsAlreadyAccessed = true;
            }
        });
    });
</script>