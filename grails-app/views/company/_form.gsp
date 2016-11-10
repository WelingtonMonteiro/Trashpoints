<g:formRemote name="formCompany" url="[controller:'company', action:'save']" onSuccess="showMessage(data)" class="col s12">
	<div class="row">
		<div class="input-field col s12 m6">
			<i class="fa fa-building-o prefix" aria-hidden="true"></i>
			<input id="name" name="name" type="text" required class="validate">
			<label for="name">Nome da empresa <span class="red-text">*</span></label>
		</div>
	</div>

	<div class="row">
		<div class="input-field col s12 m6">
			<i class="material-icons prefix">business</i>
			<input id="segment" name="segment" type="text" class="validate" required>
			<label for="segment">Segmento <span class="red-text">*</span></label>
		</div>
	</div>

	<div class="row">
		<div class="input-field col s12 m3">
			<br />
			<p>
				<input class="with-gap" name="typeOfCompany" type="radio" id="recyclingCompany" value="Empresa de coleta" />
				<label for="recyclingCompany">Empresa de coleta</label>
			</p>
			<p>
				<input class="with-gap" name="typeOfCompany" type="radio" id="partnerCompany" value="Empresa parceira" />
				<label for="partnerCompany">Empresa parceira</label>
			</p>
			<label>Tipo da Empresa <span class="red-text">*</span></label>
		</div>
	</div>

	<div class="row">
		<div class="input-field col s12 m6">
			<i class="material-icons prefix">email</i>
			<input id="email" name="email" type="email" class="validate" required>
			<label for="email">E-mail <span class="red-text">*</span></label>
		</div>
	</div>

	<div class="row">
		<div class="input-field col s12 m6">
			<i class="material-icons prefix">lock</i>
			<input id="password" name="password" type="password" class="validate" required>
			<label for="password">Senha <span class="red-text">*</span></label>
		</div>
	</div>

	<div class="row">
		<div class="input-field col s12 m6">
			<i class="material-icons prefix">lock</i>
			<input id="passwordConfirmation" name="passwordConfirmation" type="password" class="validate" required>
			<label for="passwordConfirmation">Confirme sua senha <span class="red-text">*</span></label>
		</div>
	</div>

	<div class="row">
		<div class="input-field col s12 m4">
			<i class="material-icons prefix">contact_phone</i>
			<input id="phone" name="phone" type="tel" class="validate" required>
			<label for="phone">Telefone <span class="red-text">*</span></label>
		</div>

		<div class="input-field col s12 m8">
			<i class="material-icons prefix">http</i>
			<input id="site" name="site" type="url" class="validate">
			<label for="site">Site</label>
		</div>
	</div>

	<h4 class="header">Endereço</h4>

	<div class="row">
		<div class="input-field col s12 m4">
			<input id="zipCode" name="zipCode" type="text" maxlength="9" class="validate" required>
			<label for="zipCode">CEP <span class="red-text">*</span></label>
		</div>
		<div class="input-field col s12 m2">
			<input id="state" name="state" type="text" class="validate" required>
			<label for="state">Estado <span class="red-text">*</span></label>
		</div>
	</div>

	<div class="row">
		<div class="input-field col s12 m8">
			<input id="street" name="street" type="text" class="validate" required>
			<label for="street">Rua <span class="red-text">*</span></label>
		</div>
		<div class="input-field col s12 m4">
			<input id="number" name="number" type="text" class="validate" required>
			<label for="number">Número <span class="red-text">*</span></label>
		</div>
	</div>

	<div class="row">
		<div class="input-field col s12 m7">
			<input id="neighborhood" name="neighborhood" type="text" class="validate" required>
			<label for="neighborhood">Bairro <span class="red-text">*</span></label>
		</div>
		<div class="input-field col s12 m5">
			<input id="city" name="city" type="text" class="validate" required>
			<label for="city">Cidade <span class="red-text">*</span></label>
		</div>
	</div>

	<div class="row">
		<div class="input-field col s12">
			<button class="btn-large waves-effect waves-light blue darken-3" type="submit" name="submit">
				<i class="material-icons left">check</i>Cadastrar
			</button>

			<button class="btn-large waves-effect waves-light grey right" type="reset" id="btnClear">
				<i class="material-icons left">delete_sweep</i>Limpar
			</button>
		</div>
	</div>
</g:formRemote>

<div class="row">
	<div class="col s12 m6">
		<div class="card-panel grey lighten-5">
			<i class="material-icons left orange-text">warning</i>
			<span class="black-text">Campos marcados com <span class="red-text">*</span> são obrigatórios</span>
		</div>
	</div>
</div>

<script type="text/javascript">

	function showMessage(data) {
		clearMessage()

		if(data.error){
			$('#divMessageError').show()
			$.each(data.error, function (key, value) {
				var errorMessage = value.defaultMessage.toString().replace("{0}", value.field)
				errorMessage = errorMessage.replace("{1}", value.objectName)

				var p = '<p>' + errorMessage + '</p>'
				$('#divMessageError span#messageError').append(p)
			});
		}
		console.log(data)
	}

	function clearMessage() {
		$('#divMessageError span#messageError').html("")
	}

	function clearInputs() {
		$('#btnClear').click()
		Materialize.updateTextFields();
	}

	function clearAddressInputs() {
		$("#street").val("");
		$("#neighborhood").val("");
		$("#city").val("");
		$("#state").val("");
	}

	$(document).ready(function () {
		$(".button-collapse").sideNav();

		$("#zipCode").blur(function fillAddress() {

			//var zipcode only with digits.
			var zipCode = $(this).val().replace(/\D/g, '');

			if (zipCode != "") {

				var validatorCep = /^[0-9]{8}$/;

				if (validatorCep.test(zipCode)) {

					$("#street").val("...");
					$("#neighborhood").val("...");
					$("#city").val("...");
					$("#state").val("...");
					Materialize.updateTextFields();

					$.getJSON("https://viacep.com.br/ws/" + zipCode + "/json/?callback=?", function (data) {

						if (!("erro" in data)) {
							$("#state").val(data.uf);
							$("#street").val(data.logradouro);
							$("#neighborhood").val(data.bairro);
							$("#city").val(data.localidade);
							Materialize.updateTextFields();
							$("#number").focus();
						}
						else {
							//CEP pesquisado não foi encontrado.
							clearAddressInputs();
							alert("CEP não encontrado.");
						}
					});
				}
				else {
					//cep é inválido.
					clearAddressInputs();
					alert("Formato de CEP inválido.");
				}
			}
			else {
				//cep sem valor, limpa formulário.
				clearAddressInputs();
			}
		});

		//var password = $("#senha").val();
		//var encrypted = btoa(password);
	});
</script>
