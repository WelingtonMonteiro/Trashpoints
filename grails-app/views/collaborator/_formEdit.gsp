<g:form name="formCollaborator" useToken="true">
    <input type="hidden" value="${currentCollaborator?.id}" name="id" id="id">
    <fieldset>
        <legend><h5 class="header">&nbsp;Dados do Colaborador&nbsp;</h5></legend>

        <div class="row">
            <div class="input-field col s12 m12">
                <i class="material-icons prefix" aria-hidden="true">account_circle</i>
                <input id="name" name="name" type="text" required minlength="2" class="validate" autofocus
                       value="${currentCollaborator?.name}"/>
                <label for="name">Nome<span class="red-text">*</span></label>
            </div>
        </div>

        <div class="row">
            <div class="input-field col s12 m6">
                <i class="material-icons prefix">today</i>
                <input id="dateOfBirth" name="dateOfBirth" type="text" placeholder="dd/mm/aaaa"
                       class="valid datepicker" value="<g:formatDate date="${currentCollaborator?.dateOfBirth}"
                                                                     format="dd/MM/yyyy"></g:formatDate>"/>
                <label for="dateOfBirth" class="active">Data Nascimento<span class="red-text">*</span></label>
            </div>
        </div>

        <div class="row">
            <div class="input-field col s12 m6 l6">
                <i class="material-icons prefix">contact_phone</i>
                <input id="phone" name="phone" type="tel" class="validate" required
                       value="${currentCollaborator?.phone}">
                <label for="phone">Telefone <span class="red-text">*</span></label>
            </div>
        </div>

    </fieldset>
    <br/>
    <fieldset>
        <legend><h5 class="header">&nbsp;Endereço de coleta&nbsp;</h5></legend>

        <g:set var="currentAddress" value="${currentCollaborator?.address}"/>

        <div id="formAddress">
            <g:if test="${currentCollaborator?.address}">
                <g:render template="../layouts/address" model="['currentAddress': currentAddress]"/>
            </g:if>
            <g:else>
                <g:render template="../layouts/address"/>
            </g:else>

            <div class="row">
                <div class="col s12">
                    <div id="panel-warning-location" class="card-panel grey lighten-5 center hidden">
                        <i class="material-icons left orange-text">warning</i>
                        <span class="black-text justify-align bolder">
                            Não foi possível encontrar sua localização pelo endereço!<br/>
                            Clique no botão abaixo para permitir que possamos pegar sua localização.
                            <br/>
                        </span>
                        <br/>
                        <button id="btn-enable-location" type="button"
                                class="btn btn-large waves-effect waves-light blue darken-3">
                            <i class="material-icons left">my_location</i>Minha Localização
                        </button>
                    </div>
                </div>
            </div>

            <div class="row">
                <div id="col-map" class="col s12 hidden" style="height: 500px; margin-bottom: 50px;">

                    <h5>
                        <i class="material-icons left">my_location</i>Minha localização
                    </h5>
                    <h6 class="bolder blue-text">Você pode arrastar o marcador da sua localização para ajustá-lo.</h6>

                    <div id="map"></div>

                </div>
            </div>

        </div>
    </fieldset>
    <br>
    <fieldset>
        <legend><h5 class="header">&nbsp;Endereço Residencial&nbsp;</h5></legend>

        <div class="row">
            <div class="input-field col s12 m12">
                <p>
                    <input type="checkbox" id="isAddressEqual" name="isAddressEqual"/>
                    <label for="isAddressEqual">Endereço residencial é o mesmo da coleta?</label>
                </p>
            </div>
        </div>
    </fieldset>

    <div class="row">
        <div class="input-field col s12">

            <button type="submit" class="btn-large waves-effect waves-light blue darken-3">
                <i class="material-icons left">check</i>Salvar
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
        max: new Date(),
        closeOnSelect: true,
        closeOnClear: true
    });

    jQuery(function ($) {
        $("#phone").mask("(99) 9999-9999");
        var isAddressEqual = ${currentCollaborator?.isAddressEqual};
        var checkedState = isAddressEqual ? 'checked' : '';
        $('#isAddressEqual').prop('checked', checkedState);
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
            iziToast.success({
                title: 'OK',
                message: 'Sucesso ao salvar!',
                iconText: "check"
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
                url: "/Trashpoints/Collaborator/saveEditCollaborator/",
                data: urlData,
                success: function (data) {
                    showMessage(data)
                }
            });
        }else
            showNotifyError("Precisamos ter sua localização para poder cadastrar");
    });

</script>
