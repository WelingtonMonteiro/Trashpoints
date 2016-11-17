<g:formRemote name="formClient" url="[controller: 'client', action: 'save']" onSuccess="showMessage(data)"
              class="col s12">
    <div class="row">
        <div class="input-field col s12 m6">
            <i class="fa fa-building-o prefix" aria-hidden="true"></i>
            <input id="name" name="name" type="text" required minlength="2" class="validate" autofocus="autofocus"/>
            <label for="name">Nome<span class="red-text">*</span></label>
        </div>
    </div>

    <div class="row">
        <div class="input-field col s12 m4">
            <i class="material-icons prefix">contact_phone</i>
            <input id="phone" name="phone" type="tel" class="validate" required>
            <label for="phone">Telefone <span class="red-text">*</span></label>
        </div>
    </div>

    <h4 class="header">Dados para login</h4>

    <div id="formUser">
        <g:render template="../layouts/formUser"></g:render>
    </div>


    <br>

    <h4 class="header">Endereço de Coleta</h4>

    <div id="formAddress">
        <g:render template="../layouts/formAddress"></g:render>
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

</script>
