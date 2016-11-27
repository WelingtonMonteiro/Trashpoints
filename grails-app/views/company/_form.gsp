<g:form name="formCompany" controller="company" action="save" useToken="true">

    <fieldset>
        <legend><h5 class="header">&nbsp;Dados da Empresa&nbsp;</h5></legend>

        <div class="row">
            <div class="input-field col s12 m12">
                <i class="fa fa-building-o prefix" aria-hidden="true"></i>
                <input id="companyName" name="companyName" type="text" required minlength="2" class="validate"
                       autofocus="autofocus"/>
                <label for="companyName">Razão social<span class="red-text">*</span></label>
            </div>
        </div>

        <div class="row">
            <div class="input-field col s12 m12">
                <i class="fa fa-building-o prefix" aria-hidden="true"></i>
                <input id="tradingName" name="tradingName" type="text" required class="validate">
                <label for="tradingName">Nome fantasia <span class="red-text">*</span></label>
            </div>
        </div>

        <div class="row">
            <div class="input-field col s12 m12">
                <i class="fa fa-id-card prefix"></i>
                <input id="identificationNumber" name="identificationNumber" type="text" class="validate" required
                       maxlength="18" minlength="18">
                <label for="identificationNumber">CNPJ <span class="red-text">*</span></label>
            </div>
        </div>

        <div class="row">
            <div class="input-field col s12 m12">
                <i class="material-icons prefix">business</i>
                <input id="segment" name="segment" type="text" class="validate" required>
                <label for="segment">Segmento <span class="red-text">*</span></label>
            </div>
        </div>

        <div class="row">
            <div class="input-field col s12 m12">
                <br/>

                <p>
                    <input class="with-gap validate" name="typeOfCompany" type="radio" id="recyclingCompany"
                           value="coleta" required/>
                    <label for="recyclingCompany">Empresa de coleta</label>
                </p>

                <p>
                    <input class="with-gap validate" name="typeOfCompany" type="radio" id="partnerCompany"
                           value="parceira" required/>
                    <label for="partnerCompany">Empresa parceira</label>
                </p>
                <label>Tipo da Empresa <span class="red-text">*</span></label>
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
    </fieldset>

    <br/>
    <fieldset>
        <legend><h5 class="header">&nbsp;Dados do Login&nbsp;</h5></legend>

        <div id="formUser">
            <g:render template="../userManager/authLogin"></g:render>
        </div>

    </fieldset>

    <br/>
    <fieldset>
        <legend><h5 class="header">&nbsp;Endereço &nbsp;</h5></legend>

        <div id="formAddress">
            <g:render template="../layouts/address"></g:render>
        </div>

    </fieldset>

    <div id="divSuccessMessage" class="row green-text hide">
        <div class="col s12">
            <div class="card-panel grey lighten-5">
                <span id="successMessage"></span>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="input-field col s12">
            <g:submitToRemote url="[controller: 'company', action: 'save']"
                              class="btn-large waves-effect waves-light blue darken-3" onSuccess="showMessage(data)"
                              value="Cadastrar">
                <i class="material-icons left"></i>
            </g:submitToRemote>

            <button class="btn-large waves-effect waves-light grey right" type="reset" id="btnClear">
                <i class="material-icons left">delete_sweep</i>Limpar
            </button>
        </div>
    </div>
</g:form>

<br/>

<div class="row">
    <div class="col s12 m8">
        <div class="card-panel grey lighten-5">
            <i class="material-icons left orange-text">warning</i>
            <span class="black-text">Campos marcados com <span class="red-text">*</span> são obrigatórios</span>
        </div>
    </div>
</div>

<script type="text/javascript">


    jQuery(function ($) {
        $("#phone").mask("(99) 9999-9999");
        $("#identificationNumber").mask("99.999.999/9999-99");
    });

    function showMessage(data) {
        clearErrorMessage()

        if (data.error) {
            $('#divErrorMessage').removeClass("hide")
            var errors = data.error
            $.each(errors, function (key, value) {
                var errorMessage = value

                var p = '<p>' + errorMessage + '</p>'
                $('#divErrorMessage span#errorMessage').append(p)
            });
            setFocusSummaryErrorMessage()
        }
        if (data.success) {
            clearInputs();
            $('#divSuccessMessage').removeClass("hide");

            var successMessage = data.success;

            var p = '<p>' + successMessage + '</p>';
            $('#divSuccessMessage span#successMessage').append(p);

            clearSuccessMessage();
        }
    }

    function setFocusSummaryErrorMessage() {
        $(window).scrollTop($('#divErrorMessage').offset().top);
    }

    function clearErrorMessage() {
        $('#divErrorMessage span#errorMessage').html("")
    }

    function clearSuccessMessage() {
        setTimeout(function () {
            $('#divSuccessMessage').html("")
        }, 3000);

    }

    function clearInputs() {
        $('#btnClear').click()
        $("#password").val("");
        $("#username").val("");
        Materialize.updateTextFields();
    }

</script>
