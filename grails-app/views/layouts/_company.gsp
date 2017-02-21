<header>
	<nav id="top-menu" class="indigo accent-2">
		<a  href="/Trashpoints" class="brand-logo left margin-left-3rem">
			<img src="/Trashpoints/images/trashPoints_logo_miniatura_alpha.png" class="img-responsive" />
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
		<li class="active"><a class="waves-effect active" href="/Trashpoints">Home<i class="material-icons fa-2x">home</i></a></li>
		<li><a class="waves-effect" href="#">Relatórios<i class="fa fa-line-chart fa-2x" aria-hidden="true"></i></a></li>
		<li><div class="divider"></div></li>
		<li><a class="subheader">Editar meus dados</a></li>
		<li class="no-padding">
			<ul class="collapsible collapsible-accordion">
				<li>
					<a class="collapsible-header waves-effect">Meus dados<i class="material-icons fa-2x">arrow_drop_down</i></a>
					<div class="collapsible-body">
						<ul>
							<li><a class="waves-effect" href="/Trashpoints/Company/editCompany">Editar Perfil<i class="material-icons fa-2x">account_circle</i></a></li>
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
							<li><a class="waves-effect" href="/Trashpoints/Company/myCollectedCollections">Coletadas<i class="fa fa-recycle fa-2x" aria-hidden="true"></i></a></li>
							<li><a class="waves-effect" href="/Trashpoints/Company/myCollectionsInProgress">A Recolher<i class="material-icons fa-2x">event_note</i></a></li>
						</ul>
					</div>
				</li>
			</ul>
		</li>

		<li><a class="waves-effect" href="/Trashpoints/Collect/placesCollect">Locais para coletar<i class="material-icons fa-2x">local_shipping</i></a></li>


		<li><a class="waves-effect" href="#">Notificações<i class="material-icons fa-2x">notifications</i></a></li>
		<li><a class="waves-effect" href="/Trashpoints/j_spring_security_logout">Sair<i class="fa fa-sign-out fa-2x" aria-hidden="true"></i></a></li>
	</ul>
</header>

