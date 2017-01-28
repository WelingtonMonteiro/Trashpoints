<g:form name="formClient" useToken="true">

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
                <input id="date" name="dateOfBirth" type="text" placeholder="dd/mm/aaaa" class="datepicker"/>
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
    <br/>
    <fieldset>
        <legend><h5 class="header">&nbsp;Dados do Login&nbsp;</h5></legend>

        <div id="formUser">
            <g:render template="../userManager/authLogin"></g:render>
        </div>

    </fieldset>

    <br/>
    <fieldset>
        <legend><h5 class="header">&nbsp;Endereço de coleta&nbsp;</h5></legend>

        <div id="formAddress">
            <g:render template="../layouts/address"></g:render>

            <div class="row">
                <div class="col s12">
                    <div id="card-panel-location" class="card-panel grey lighten-5 center">
                        <i class="material-icons left orange-text">warning</i>
                        <span class="black-text justify-align bolder">
                            É muito importante que você habilite a sua localização para que as empresas possam saber onde recolher as coletas!<br/>
                        </span>
                        <br/>
                        <button id="btn-enable-location" type="button"
                                class="btn btn-large waves-effect waves-light blue darken-3">
                            <i class="material-icons left">my_location</i>Habilitar
                        </button>
                    </div>
                </div>
            </div>

            <div class="row">
                <div id="col-map" class="col s12 hidden" style="height: 500px; margin-bottom: 50px;">

                    <h5>
                        <i class="material-icons left">my_location</i>Minha localização
                    </h5>
                    <h6 class="bolder red-text">Você pode arrastar o marcador da sua localização para ajustá-lo.</h6>

                    <div id="map"></div>

                </div>
            </div>
        </div>

    </fieldset>

    <br />
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

    <div class="row">
        <div class="input-field col s12">
            <button type="submit" class="btn-large waves-effect waves-light blue darken-3">
                <i class="material-icons left">check</i>Cadastrar
            </button>

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

    $('.datepicker').pickadate({
        selectMonths: true, // Creates a dropdown to control month
        selectYears: 100,// Creates a dropdown of 15 years to control year
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
            iziToast.success({
                title: 'OK',
                message: 'Sucesso ao salvar!',
                iconText: "check",
                onClose: function () {
                    window.location.href = "/Trashpoints/userManager/login";
                }
            });
        }
        $("#SYNCHRONIZER_TOKEN").val(data.newToken);
    }

    function setFocusSummaryErrorMessage() {
        $(window).scrollTop($('#divErrorMessage').offset().top);
    }

    function clearErrorMessage() {
        $('#divErrorMessage span#errorMessage').html("")
    }

    function clearInputs() {
        $('#btnClear').click()
        $("#password").val("");
        $("#username").val("");
        Materialize.updateTextFields();
    }

    $("form").submit(function (e) {
        e.preventDefault();

        if ($('#latitude').val() && $('#longitude').val()) {
            var urlData = $(this).serialize();
            $.ajax({
                type: "post",
                url: "/Trashpoints/Collaborator/save/",
                data: urlData,
                success: function (data) {
                    showMessage(data)
                }
            });
        }
    });

</script>
