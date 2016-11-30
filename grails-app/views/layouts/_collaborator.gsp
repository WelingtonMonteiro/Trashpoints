<header>
	<nav id="top-menu" class="indigo accent-2">
		<a class="page-title" href="/Trashpoints">TrashPoints</a>
		<ul class="right">
			<li>
				<a class="hide-on-small-only"><sec:loggedInUserInfo field="username"/></a>
			</li>
		</ul>
		<a href="#" data-activates="side-menu" class="button-collapse hide-on-large-only"><i class="material-icons">menu</i></a>
	</nav>

	<ul id="side-menu" class="side-nav fixed">
		<li><a class="waves-effect hide-on-large-only"><sec:loggedInUserInfo field="username"/><i class="material-icons">account_circle</i></a></li>
		<li class="active"><a class="waves-effect active" href="/Trashpoints">Home<i class="material-icons">home</i></a></li>
		<li><a class="waves-effect" href="#">Meus TrashPoints<i class="material-icons">monetization_on</i></a></li>
		<li><div class="divider"></div></li>
		<li><a class="subheader">Editar meus dados</a></li>
		<li class="no-padding">
			<ul class="collapsible collapsible-accordion">
				<li>
					<a class="collapsible-header waves-effect">Meus dados<i class="material-icons">arrow_drop_down</i></a>
					<div class="collapsible-body">
						<ul>
							<li><a class="waves-effect" href="/Trashpoints/collaborator/editCollaborator">Editar Perfil<i class="material-icons">account_circle</i></a></li>
							<!-- <li><a class="waves-effect" href="#">Editar Endereço<i class="material-icons">edit_location</i></a></li> -->
						</ul>
					</div>
				</li>
			</ul>
		</li>
		<li><div class="divider"></div></li>
		<li><a class="waves-effect" href="/Trashpoints/Collaborator/MyCollections">Minhas Coletas<i class="fa fa-recycle fa-2x" aria-hidden="true"></i></a></li>
		<li><a class="waves-effect" href="/Trashpoints/Collect/Create">Tenho uma Coleta<i class="fa fa-bullhorn fa-2x" aria-hidden="true"></i></a></li>
		<li><a class="waves-effect" href="#">Notificações<i class="material-icons">notifications</i></a></li>
		<li><a class="waves-effect" href="/Trashpoints/j_spring_security_logout">Sair<i class="fa fa-2x fa-sign-out" aria-hidden="true"></i></a></li>
	</ul>
</header>