<div class="row">
    <div class="input-field col s12 m6">
        <i class="material-icons prefix">today</i>
        <input id="orderDate" name="orderDate" type="date" class="validate datepicker" disabled>
        <label for="orderDate" class="active">Data <span class="red-text">*</span></label>
    </div>
</div>
<form name="formCollect" action="save" onSuccess="showMessage(data)" enctype="multipart/form-data" method="POST">
    <div class="row">
        <div class="input-field col s12 m6">
            <h5>Selecione um ou mais tipos da coleta:</h5>
            <g:each in="${materialTypes}" var="materialType">
                <p>
                    <input type="checkbox" value="${materialType.id}" name="materialTypes" id="${materialType.name}" required/>
                    <label for="${materialType.name}">${materialType.name}</label>
                </p>
            </g:each>
        </div>
    </div>
    <div class="row">
        <div class="input-field col s12 m9">
            <br/>
            <p>
            <div class="file-field input-field">
                <div class="btn blue darken-3">
                    <i class="material-icons left">add_a_photo</i>Imagem
                    <input type="file" id="imageUpload" name="imageUpload">
                </div>
                <div class="file-path-wrapper">
                    <input class="file-path validate" type="text" placeholder="Envie uma imagen da sua coleta">
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
</form>
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
        $('#orderDate').val(year + '-' + month + '-' + day).css({'color': 'black'});
        $('[for="orderDate"]').css({'color': 'black'});
    });

</script>



