<header>
	<nav id="top-menu" class="indigo accent-2">
		<a  href="${application.contextPath}/" class="brand-logo left margin-left-3rem">
			<img src="${resource(dir: 'images', file: 'trashPoints_logo_miniatura_alpha.png')}" class="img-responsive" />
		</a>
		<ul class="right">
			<li>
				<a class="hide-on-small-only"><sec:loggedInUserInfo field="username"/></a>
			</li>
		</ul>
		<a href="#" data-activates="side-menu" class="button-collapse hide-on-large-only"><i class="material-icons">menu</i></a>
	</nav>

	<ul id="side-menu" class="side-nav fixed">
		<li><a class="waves-effect hide-on-large-only"><sec:loggedInUserInfo field="username"/><i class="material-icons fa-2x">account_circle</i></a></li>
		<li id="home"><a class="waves-effect" href="${application.contextPath}/">Home<i class="material-icons fa-2x">home</i></a></li>
		<li>
			<g:link controller="report" action="companyCollections" class="waves-effect">
				Relatórios<i class="fa fa-line-chart fa-2x" aria-hidden="true"></i>
			</g:link>
		</li>
		<li><div class="divider"></div></li>
		<li><a class="subheader">Editar meus dados</a></li>
		<li class="no-padding">
			<ul class="collapsible collapsible-accordion">
				<li>
					<a class="collapsible-header waves-effect">Meus dados<i class="material-icons fa-2x">arrow_drop_down</i></a>
					<div class="collapsible-body">
						<ul>
							<li id="editProfile">
								<g:link controller="company" action="editCompany" class="waves-effect">
									Editar Perfil<i class="material-icons fa-2x">account_circle</i>
								</g:link>
							</li>
							%{--<li><a class="waves-effect" href="#">Editar Endereço<i class="material-icons fa-2x">edit_location</i></a></li>--}%
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
					<a class="collapsible-header waves-effect">Minhas Coletas<i class="material-icons fa-2x">arrow_drop_down</i></a>
					<div class="collapsible-body">
						<ul>
							<li id="myCollectedCollections">
                                <g:link controller="company" action="myCollectedCollections" class="waves-effect">
                                    Coletadas<i class="fa fa-recycle fa-2x" aria-hidden="true"></i>
                                </g:link>
                            </li>
							<li id="myCollectionsInProgress">
                                <g:link controller="company" action="myCollectionsInProgress" class="waves-effect">
                                    A Recolher<i class="material-icons fa-2x">event_note</i>
                                </g:link>
                            </li>
						</ul>
					</div>
				</li>
			</ul>
		</li>

		<li id="placesCollect">
            <g:link controller="collect" action="placesCollect" class="waves-effect">
                Locais para coletar<i class="material-icons fa-2x">local_shipping</i>
            </g:link>
        </li>

		<li>
            <a class="waves-effect" href="#">Notificações<i class="material-icons fa-2x">notifications</i></a>
        </li>
		<li>
            <g:link controller="contactUs" action="index" class="waves-effect">
                Fale conosco<i class="material-icons">hearing</i>
            </g:link>
        </li>
		<li>
            <a class="waves-effect" href="${application.contextPath}/j_spring_security_logout">Sair<i class="fa fa-sign-out fa-2x" aria-hidden="true"></i></a>
        </li>
	</ul>
</header>

<script>
    (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
            (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
        m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
    })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

    ga('create', 'UA-93957312-1', 'auto');
    ga('send', 'pageview');

</script>

