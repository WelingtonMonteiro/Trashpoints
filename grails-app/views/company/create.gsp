<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="main"/>
	<title>Cadastrar empresa</title>
</head>
<body>
	<main>
		<div class="section">
			<div class="container">
				<h4 class="header">Cadastro da empresa</h4>

				<div id="divMessageError" class="row red-text hiddendiv">
					<div class="col s12 m6">
						<div class="card-panel grey lighten-5">
							<i class="material-icons left">error</i>
							<span id="messageError"></span>
						</div>
					</div>
				</div>

				<div id="formCompany">
					<g:render template="form"></g:render>
				</div>

			</div>
		</div>
	</main>


</body>
</html>
