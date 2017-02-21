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
        <a href="/Trashpoints" class="brand-logo left margin-left-3rem ">
            <img src="${resource(dir: 'images', file: 'trashPoints_logo_miniatura_alpha.png')}" class="img-responsive"/>
        </a>
        <ul class="right">
            <li>
                <a class="dropdown-button hide-on-small-only" href="#!" data-activates="notification-list" id="btn-show-notification">
                    Notificações <span class="new badge red" id="bdg-qtde-notifications" data-badge-caption="novas">4</span>
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
        <li class="active"><a class="waves-effect active" href="/Trashpoints">Home<i class="material-icons">home</i></a>
        </li>
        <li>
            <a class="waves-effect" href="/Trashpoints/Collaborator/MyCollections" title="Meus TrashCoins">
                <i class="material-icons">monetization_on</i> <span class="new badge my-badge bold"
                                                                    data-badge-caption="" id="quantityOfCoins"></span>
            </a>
        </li>
        <li><div class="divider"></div></li>
        <li><a class="subheader">Editar meus dados</a></li>
        <li class="no-padding">
            <ul class="collapsible collapsible-accordion">
                <li>
                    <a class="collapsible-header waves-effect">Meus dados<i class="material-icons">arrow_drop_down</i>
                    </a>

                    <div class="collapsible-body">
                        <ul>
                            <li><a class="waves-effect"
                                   href="/Trashpoints/collaborator/editCollaborator">Editar Perfil<i
                                        class="material-icons">account_circle</i></a></li>
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
                            <li>
                                <a class="waves-effect" href="/Trashpoints/Collaborator/MyCollectedCollections">Coletadas
                                    <i class="fa fa-recycle fa-2x" aria-hidden="true"></i>
                                </a>
                            </li>
                            <li>
                                <a class="waves-effect" href="/Trashpoints/Collaborator/MyCollectionsInProgress">A Recolher
                                    <i class="material-icons fa-2x">event_note</i>
                                </a>
                            </li>
                        </ul>
                    </div>
                </li>
            </ul>
        </li>

        <li><a class="waves-effect" href="/Trashpoints/Collect/Create">Tenho uma Coleta<i class="fa fa-bullhorn fa-2x"
                                                                                          aria-hidden="true"></i></a>
        </li>
        <li><a class="waves-effect" href="#">Notificações<i class="material-icons">notifications</i></a></li>
        <li><a class="waves-effect" href="/Trashpoints/j_spring_security_logout">Sair<i class="fa fa-2x fa-sign-out"
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
            url: "/Trashpoints/Notification/getNotifications",
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
            url: "/Trashpoints/Collaborator/sumQuantityOfCoins/",
            success: function (data) {
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
                $.post("/Trashpoints/Notification/setLastNotificationsAsRead/");
            }
            $('#bdg-qtde-notifications').removeClass('red').text('0');
            if (!notificationsAlreadyAccessed) {
                notificationsAlreadyAccessed = true;
            }
        });
    });
</script>