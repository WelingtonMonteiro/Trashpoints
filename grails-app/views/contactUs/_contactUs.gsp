<g:form name="contactUs" useToken="true">
    <div class="row">
        <h6>Selecione o tipo de contato: <span class="red-text">*</span></h6>
        <span id="errorRequired" class="red-text"></span>
        <!-- Dropdown Structure -->
        <div class="col s12 m6">
            <select name="contactType" id="slt-contact-type">
                <option value="-1" selected>Selecione</option>
                <option value="1">Informações</option>
                <option value="2">Sugestões</option>
                <option value="3">Reclamações</option>
                <option value="4">Elogios</option>
                <option value="5">Serviços / Solicitações</option>
                <option value="6">Outros</option>
            </select>
        </div>
    </div>

    <div class="row">
        <h6>Digite uma mensagem: <span class="red-text">*</span></h6>

        <div class="input-field col s12 m6">
            <i class="material-icons prefix">mode_edit</i>
            <textarea class="materialize-textarea" name="contactText" id="txb-contact-text" required></textarea>
            <label for="txb-contact-text">Mensagem</label>
        </div>
    </div>

    <div class="row">
        <div class="col s12">
            <button class="btn-large waves-effect waves-light blue darken-3" type="submit" name="submit">
                <i class="material-icons left">check</i>Enviar
            </button>

        </div>
    </div>
</g:form>

<div class="row">
    <div class="col s12 m8">
        <div class="card-panel grey lighten-5">
            <i class="material-icons left orange-text">warning</i>
            <span class="black-text">Campos marcados com <span class="red-text">*</span> são obrigatórios</span>
        </div>
    </div>
</div>

<script type="text/javascript">

    function clearErrorMessage() {
        $('#divMessageError span#messageError').html("");
    }

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
                message: 'Contato enviado com sucesso!',
                iconText: "check"
            });
        }
        $("#SYNCHRONIZER_TOKEN").val(data.newToken);
    }

    function setFocusSummaryErrorMessage() {
        $(window).scrollTop($('#divErrorMessage').offset().top);
    }

    function clearErrorMessage() {
        $('#divMessageError span#messageError').html("");
    }

    function clearInputs() {
        $("#slt-contact-type").val($("#slt-contact-type option:first").val());
        $("#slt-contact-type").material_select('destroy');
        $("#slt-contact-type").material_select();
        $('#txb-contact-text').val('');
        Materialize.updateTextFields();
    }

    $(document).ready(function () {
        $('select').material_select();

        $("form").submit(function (e) {
            e.preventDefault();
            $('#divErrorMessage').addClass("hide")
            $('#divErrorMessage span#errorMessage > p').remove();

            var urlData = $(this).serialize();
            $.ajax({
                type: "post",
                url: "${application.contextPath}/contactUs/save/",
                data: urlData,
                success: function (data) {
                    showMessage(data)
                }
            });
        });
    });
</script>