<div class="row">
    <div class="input-field col s12 m6">
        <i class="material-icons prefix">today</i>
        <input id="orderDate" name="orderDate" type="date" class="validate datepicker" disabled>
        <label for="orderDate" class="active">Data da Coleta <span class="red-text">*</span></label>
    </div>
</div>
%{--<form name="formCollect" action="save" onSuccess="showMessage(data)" enctype="multipart/form-data" method="POST" useToken="true">--}%
<g:form   name="formCollect" controller="collect"  action="save"  useToken="true" enctype="multipart/form-data">
    <div class="row">
        <div class="input-field col s12 m12">
            <h5>Selecione um ou mais tipos da coleta:</h5>
            <g:each in="${materialTypes}" var="materialType">
                <p>
                    <input type="checkbox" value="${materialType.id}" name="materialTypes" id="${materialType.name}"/>
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

    <div id="divSuccessMessage" class="row green-text hide">
        <div class="col s12">
            <div class="card-panel grey lighten-5">
                <span id="successMessage"></span>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col s12">
            <button class="btn-large waves-effect waves-light blue darken-3" type="submit" name="submit">
                <i class="material-icons left">check</i>Cadastrar
            </button>
            %{--<g:submitToRemote url="[controller: 'collect', action: 'save', format:'multipartForm']"--}%
                              %{--class="btn-large waves-effect waves-light blue darken-3" onSuccess="showMessage(data)"--}%
                              %{--value="Cadastrar">--}%
                %{--<i class="material-icons left"></i>--}%
            %{--</g:submitToRemote>--}%
            <button class="btn-large waves-effect waves-light grey right" type="reset" id="btnClear">
                <i class="material-icons left">delete_sweep</i>Limpar
            </button>
        </div>
    </div>
%{--</form>--}%
</g:form >
<div class="row">
    <div class="col s12 m8">
        <div class="card-panel grey lighten-5">
            <i class="material-icons left orange-text">warning</i>
            <span class="black-text">Campos marcados com <span class="red-text">*</span> são obrigatórios</span>
        </div>
    </div>
</div>

<script type="text/javascript">

    function formData(){
        return new FormData($("#imageUpload").val())
    }
    //enviando arquivo via form/data
    $('#submit').click(function(){
        var oData = new FormData(document.forms.namedItem("formCollect"));
        var url="${createLink(controller: 'collect', action: 'save')} ";
        $.ajax({
            url:url,
            type:'POST',
            data:oData,
            processData: false,  // tell jQuery not to process the data
            contentType: false ,
            success:function (data) {
                showMessage(data)
            }
        });
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

        $("#SYNCHRONIZER_TOKEN").val(data.newToken);
    }

    function setFocusSummaryErrorMessage() {
        $(window).scrollTop($('#divMessageError').offset().top);
    }

    function clearErrorMessage() {
        $('#divMessageError span#messageError').html("");
    }

    function clearSuccessMessage() {
        setTimeout(function () {
            $('#divSuccessMessage').html("")
        }, 3000);

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