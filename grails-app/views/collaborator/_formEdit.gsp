<g:form name="formCollaborator" controller="collaborator" action="saveEditCollaborator" onSuccess="showMessage(data)"
        useToken="true">
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
                <input id="dateOfBirth" name="dateOfBirth" type="date" placeholder="dd/mm/aaaa"
                       class="validate datepicker" value="${currentCollaborator?.dateOfBirth}"/>
                <label for="dateOfBirth" class="active">Data Nascimento<span class="red-text">*</span></label>
            </div>
        </div>

        <div class="row">
            <div class="input-field col s12 m4">
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

            <i class="btn-large waves-effect waves-light blue darken-3 waves-input-wrapper">
                <g:submitToRemote id="btnSubmit" url="[controller: 'collaborator', action: 'saveEditCollaborator']"
                                  onSuccess="showMessage(data)" value="Cadastrar">
                </g:submitToRemote>
                <i class="material-icons left">check</i>
            </i>

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

        var isAddressEqual = ${currentCollaborator?.isAddressEqual};
        var checkedState = isAddressEqual ? 'checked' : '';
        $('#isAddressEqual').prop('checked', checkedState);
    });

    function showMessage(data) {
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

</script>