<g:formRemote name="formCollect" url="[controller: 'collect', action: 'save']" onSuccess="showMessage(data)"
              class="col s12">
    <div class="row">
        <div class="input-field col s12 m6">
            <i class="material-icons prefix">today</i>
            <input id="date" name="date" type="date" class="validate datepicker" disabled>
            <label for="date" class="active">Data <span class="red-text">*</span></label>
        </div>
    </div>

    <div class="row">
        <div class="input-field col s12 m6">

            <h5>Selecione o tipo da coleta:</h5>

            <p>
                <input type="checkbox" id="_paper"/>
                <label for="_paper">Papel</label>
            </p>

            <p>
                <input type="checkbox" id="_plastic"/>
                <label for="_plastic">Plástico</label>
            </p>

            <p>
                <input type="checkbox" id="_metal"/>
                <label for="_metal">Metal</label>
            </p>

            <p>
                <input type="checkbox" id="_glass"/>
                <label for="_glass">Vidro</label>
            </p>

            <p>
                <input type="checkbox" id="_organic"/>
                <label for="_organic">Orgânico</label>
            </p>
        </div>
    </div>

    <div class="row">
        <div class="input-field col s12 m9">
            <br/>
            <p>
            <div class="file-field input-field">
                <div class="btn">
                    <span>Imagem</span>
                    <input type="file" id="image_upload" name="image_upload">
                </div>

                <div class="file-path-wrapper">
                    <input class="file-path validate" type="text" placeholder="Envie imagens de sua coleta">
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col s12">
            <button class="btn-large waves-effect waves-light blue darken-3" type="submit" name="submit">
                <i class="material-icons left">check</i>Enviar
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
        clearErrorMessage();

        if (data.error) {
            $('#divMessageError').removeClass("hide");
            $.each(data.error, function (key, value) {
                var errorMessage = value.defaultMessage.toString().replace("{0}", value.field);
                errorMessage = errorMessage.replace("{1}", value.objectName);

                var p = '<p>' + errorMessage + '</p>';
                $('#divMessageError span#messageError').append(p);
            });
            setFocusSummaryErrorMessage()
        }
    }

    function setFocusSummaryErrorMessage() {
        $(window).scrollTop($('#divMessageError').offset().top);
    }

    function clearErrorMessage() {
        $('#divMessageError span#messageError').html("");
    }

    function clearInputs() {
        $('#btnClear').click();
        Materialize.updateTextFields();
    }

    $(document).ready(function () {
        var actualDate = new Date();
        var day = actualDate.getDate();
        var month = actualDate.getMonth() + 1;
        var year = actualDate.getFullYear();
        $('#date').val(year + '-' + month + '-' + day).css({'color': 'black'});
        $('[for="date"]').css({'color': 'black'});
    });

</script>



