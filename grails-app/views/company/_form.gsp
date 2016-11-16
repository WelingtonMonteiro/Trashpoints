<g:formRemote name="formCompany" url="[controller:'company', action:'save']" onSuccess="showMessage(data)" class="col s12">
	<div class="row">
		<div class="input-field col s12 m6">
			<i class="fa fa-building-o prefix" aria-hidden="true"></i>
			<input id="name" name="name" type="text" required minlength="2" class="validate" autofocus="autofocus" />
			<label for="name">Razão social<span class="red-text">*</span></label>
		</div>
	</div>

	<div class="row">
		<div class="input-field col s12 m6">
			<i class="fa fa-building-o prefix" aria-hidden="true"></i>
			<input id="tradingName" name="tradingName" type="text" required class="validate">
			<label for="tradingName">Nome fantasia <span class="red-text">*</span></label>
		</div>
	</div>

	<div class="row">
		<div class="input-field col s12 m6">
			<i class="fa fa-id-card prefix"></i>
			<input id="identificationNumber" name="identificationNumber" type="text" class="validate" required maxlength="18" minlength="18" >
			<label for="identificationNumber">CNPJ <span class="red-text">*</span></label>
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
				<input class="with-gap validate" name="typeOfCompany" type="radio" id="recyclingCompany" value="coleta" required />
				<label for="recyclingCompany">Empresa de coleta</label>
			</p>
			<p>
				<input class="with-gap validate" name="typeOfCompany" type="radio" id="partnerCompany" value="parceira" required />
				<label for="partnerCompany">Empresa parceira</label>
			</p>
			<label>Tipo da Empresa <span class="red-text">*</span></label>
		</div>
	</div>

	<div class="row">
		<div class="input-field col s12 m6">
			<i class="material-icons prefix">contact_mail</i>
			<input id="email" name="email" type="email" class="validate" required />
			<label for="email">E-mail <span class="red-text">*</span></label>
		</div>
	</div>

	<div class="row">
		<div class="input-field col s12 m6">
            <a id="btnShowPassword" class="waves-effect waves-indigo accent-2 btn-flat grey lighten-4 black-text button-show-password"
               onmousedown="showPassword()" onmouseup="hidePassword()">
                <i class="fa fa-eye"></i>
            </a>
			<i class="material-icons prefix">lock</i>
			<input id="password" name="password" type="password" class="validate"
				   required minlength="6">
			<label for="password">Senha <span class="red-text">*</span></label>
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
				<span id="zipCodeErrorMessage" class="red-text"></span>

			</div>
			<div class="input-field col s12 m2">
				<select id="states" disabled required class="validate browser-default">
					<option value="" disabled selected>Selecione</option>
					<option value="AC">AC</option>
					<option value="AL">AL</option>
					<option value="AP">AP</option>
					<option value="AM">AM</option>
					<option value="BA">BA</option>
					<option value="CE">CE</option>
					<option value="DF">DF</option>
					<option value="ES">EF</option>
					<option value="GO">GO</option>
					<option value="MA">MA</option>
					<option value="MT">MT</option>
					<option value="MS">MS</option>
					<option value="MG">MG</option>
					<option value="PA">PA</option>
					<option value="PB">PB</option>
					<option value="PR">PR</option>
					<option value="PE">PE</option>
					<option value="PI">PI</option>
					<option value="RJ">RJ</option>
					<option value="RN">RN</option>
					<option value="RS">RS</option>
					<option value="RO">RO</option>
					<option value="RR">RR</option>
					<option value="SC">SC</option>
					<option value="SP">SP</option>
					<option value="SE">SE</option>
					<option value="TO">TO</option>
				</select>
				<label for="states" class="active">Estado <span class="red-text">*</span></label>
			</div>

			<div class="col s12 m4">
				<div class="preloader-wrapper big active">
					<div class="spinner-layer spinner-blue-only">
						<div class="circle-clipper left">
							<div class="circle"></div>
						</div>
						<div class="gap-patch">
							<div class="circle"></div>
						</div>
						<div class="circle-clipper right">
							<div class="circle"></div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="row">
			<div class="input-field col s12 m8">
				<input id="street" name="street" type="text" class="validate" required disabled>
				<label for="street">Rua <span class="red-text">*</span></label>
			</div>
			<div class="input-field col s12 m4">
				<input id="number" name="number" type="text" class="validate" required>
				<label for="number">Número <span class="red-text">*</span></label>
			</div>
		</div>

		<div class="row">
			<div class="input-field col s12 m7">
				<input id="neighborhood" name="neighborhood" type="text" class="validate" required disabled>
				<label for="neighborhood">Bairro <span class="red-text">*</span></label>
			</div>
			<div class="input-field col s12 m5">
				<input id="city" name="city" type="text" class="validate" required disabled>
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

<br />
<div class="row">
	<div class="col s12 m6">
		<div class="card-panel grey lighten-5">
			<i class="material-icons left orange-text">warning</i>
			<span class="black-text">Campos marcados com <span class="red-text">*</span> são obrigatórios</span>
		</div>
	</div>
</div>

<script type="text/javascript">

	jQuery(function($){
		$("#phone").mask("(99) 9999-9999");
		$("#zipCode").mask("99999-999");
		$("#identificationNumber").mask("99.999.999/9999-99");
	});

	function showMessage(data) {
		clearErrorMessage()

		if(data.error){
			$('#divErrorMessage').removeClass("hide")
			var errors = data.error
			$.each(errors, function (key, value) {
				var errorMessage = value

				var p = '<p>' + errorMessage + '</p>'
				$('#divErrorMessage span#errorMessage').append(p)
			});
			setFocusSummaryErrorMessage()
		}
	}

	function setFocusSummaryErrorMessage() {
		$(window).scrollTop($('#divErrorMessage').offset().top);
	}

	function clearErrorMessage() {
		$('#divErrorMessage span#errorMessage').html("")
	}

	function clearInputs() {
		$('#btnClear').click()
		Materialize.updateTextFields();
	}

	function clearAddressInputs() {
		$("#street").val("");
		$("#neighborhood").val("");
		$("#city").val("");
		$("#states").val("");
	}

    function showPassword()
    {
        $("#password").attr("type", "text");
    }

    function hidePassword()
    {
        $("#password").attr("type", "password");
    }

    var elementZipCode = document.getElementById("zipCode");

	$(document).ready(function () {
		$(".preloader-wrapper").hide();

		$("#zipCode").blur(function fillAddress() {
			$(".preloader-wrapper").show();

			//var zipcode only with digits.
			var zipCode = $(this).val().replace(/\D/g, '');

			if (zipCode != "") {

				var validatorZipCode = /^[0-9]{8}$/;

				if (validatorZipCode.test(zipCode)) {

					$("#street").val("...");
					$("#neighborhood").val("...");
					$("#city").val("...");
					Materialize.updateTextFields();

					$.getJSON("https://viacep.com.br/ws/" + zipCode + "/json/?callback=?", function (data) {

						if (!("erro" in data)) {
							$("#zipCodeErrorMessage").text("");
							enableAddressInputs();

							$("#zipCode").val(data.cep);
							$("#states").val(data.uf)
							$("#street").val(data.logradouro);
							$("#neighborhood").val(data.bairro);
							$("#city").val(data.localidade);
							Materialize.updateTextFields();
							$("#number").focus();
							$(".preloader-wrapper").hide();

						}
						else {
							clearAddressInputs();
							enableAddressInputs();
							$("#zipCodeErrorMessage").text("CEP não encontrado.");
							$(".preloader-wrapper").hide();
						}
					});
				}
				else {
					clearAddressInputs();
					$("#zipCodeErrorMessage").text("Formato de CEP inválido.");
					$(".preloader-wrapper").hide();
				}
			}
			else {
				//cep sem valor
				clearAddressInputs();
				$(".preloader-wrapper").hide();
			}

		});

	});

	function enableAddressInputs() {
		$("#states").removeAttr("disabled");
		$("#street").removeAttr("disabled");
		$("#neighborhood").removeAttr("disabled");
		$("#city").removeAttr("disabled");
	}

	/*function encryptPassword() {
	  	var encryptedPassword = btoa($("#password").val());
	  	$("#password").val(encryptedPassword)
	}*/

</script>
