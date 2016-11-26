<g:formRemote name="formClient" url="[controller: 'collaborator', action: 'save']" onSuccess="showMessage(data)"
              class="col s12">
    <fieldset>
        <legend><h5 class="header">&nbsp;Dados do Colaborador&nbsp;</h5></legend>

        <div class="row">
            <div class="input-field col s12 m12">
                <i class="material-icons prefix" aria-hidden="true">account_circle</i>
                <input id="name" name="name" type="text" required minlength="2" class="validate" autofocus="autofocus"/>
                <label for="name">Nome<span class="red-text">*</span></label>
            </div>
        </div>

        <div class="row">
            <div class="input-field col s12 m6">
                <i class="material-icons prefix">today</i>
                <input id="date" name="dateOfBirth" type="date" placeholder="aa/aa/aaaa" class="validate datepicker"/>
                <label for="date" class="active">Data Nascimento<span class="red-text">*</span></label>
            </div>
        </div>

        <div class="row">
            <div class="input-field col s12 m4">
                <i class="material-icons prefix">contact_phone</i>
                <input id="phone" name="phone" type="tel" class="validate" required>
                <label for="phone">Telefone <span class="red-text">*</span></label>
            </div>
        </div>

    </fieldset>
    %{--<br/>--}%
    %{--<fieldset>--}%
        %{--<legend><h5 class="header">&nbsp;Dados do Login&nbsp;</h5></legend>--}%

        %{--<div id="formUser">--}%
            %{--<g:render template="../layouts/userLogin"></g:render>--}%
        %{--</div>--}%

    %{--</fieldset>--}%

    <br/>
    <fieldset>
        <legend><h5 class="header">&nbsp;Endereço de coleta&nbsp;</h5></legend>

        <div id="formAddress">
            <g:render template="../layouts/address"></g:render>
        </div>

    </fieldset>
    <br>
    <fieldset>
        <legend><h5 class="header">&nbsp;Endereço Residencial&nbsp;</h5></legend>

        <div class="row">
            <div class="input-field col s12 m12">
                <p>
                    <input type="checkbox" id="_isAddressEqual" name="isAddressEqual" checked/>
                    <label for="_isAddressEqual">Endereço residencial é o mesmo da coleta?</label>
                </p>
            </div>
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
            <button class="btn-large waves-effect waves-light blue darken-3" type="submit" name="submit">
                <i class="material-icons left">check</i>Cadastrar
            </button>

            <button class="btn-large waves-effect waves-light grey right" type="reset" id="btnClear">
                <i class="material-icons left">delete_sweep</i>Limpar
            </button>

        </div>
    </div>
</g:formRemote>

<br/>

<div class="row">
    <div class="col s12 m6">
        <div class="card-panel grey lighten-5">
            <i class="material-icons left orange-text">warning</i>
            <span class="black-text">Campos marcados com <span class="red-text">*</span> são obrigatórios</span>
        </div>
    </div>
</div>

<script type="text/javascript">

    //var year = new Date().getFullYear().toString().substr(2,2);

    $('.datepicker').pickadate({
        selectMonths: true, // Creates a dropdown to control month
        selectYears:  100,// Creates a dropdown of 15 years to control year
        format: 'dd/mm/yyyy',
//        min: 30, //get last 30 day range
//        max: true,
        closeOnSelect: true,
        closeOnClear: true,

    });

    jQuery(function ($) {
        $("#phone").mask("(99) 9999-9999");
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
        setTimeout(function(){
            $('#divSuccessMessage span#successMessage').html("")
        }, 3000);

    }

    function clearInputs() {
        $('#btnClear').click()
        Materialize.updateTextFields();
    }

</script>
