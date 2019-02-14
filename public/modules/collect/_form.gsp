<div class="row no-margin">
    <div class="input-field col s12 m6">
        <i class="material-icons prefix grey-text text-darken-2">today</i>
        <input id="orderDate" name="orderDate" type="text" disabled class="grey-text text-darken-2"
               value="<g:formatDate date="${new java.util.Date()}" format="dd/MM/yyyy"></g:formatDate>"
        >
        <label for="orderDate" class="active grey-text text-darken-2">Data da Coleta <span class="red-text">*</span></label>
    </div>
</div>

<g:form name="formCollect" useToken="true">
    <div class="row">
        <div class="input-field col s12 m12">
            <h5>Selecione um ou mais tipos da coleta: <span class="red-text">*</span></h5>
            <span id="errorRequired" class="red-text"></span>

            <g:each in="${materialTypes}" var="materialType">
                <p>
                    <input type="checkbox" value="${materialType.id}" name="materialTypes" id="${materialType.name}"/>
                    %{--<label for="${materialType.url}">${materialType?.url}</label>--}%
                    <label for="${materialType.name}">${materialType.name}</label>
                </p>
            </g:each>
        </div>
    </div>

   <div class="row">
        <div class="input-field col s12 m9">
            <div class="file-field input-field">
                <div class="btn blue darken-3">
                    <i class="material-icons left">add_a_photo</i>Imagem
                    <input type="file" id="imageUpload" name="imageUpload" accept="image/gif, image/jpeg, image/png">
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
                <i class="material-icons left">check</i>Cadastrar
            </button>

            <button class="btn-large waves-effect waves-light grey right" type="reset" id="btnClear">
                <i class="material-icons left">delete_sweep</i>Limpar
            </button>
        </div>
    </div>
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
    $('form[name=formCollect]').submit(function(e){
        e.preventDefault();
        if(hasLeastOneMaterialTypeChecked() == true) {
            var oData = new FormData(document.forms.namedItem("formCollect"));
            var url = "${createLink(controller: 'collect', action: 'save')} ";
            $.ajax({
                url: url,
                type: 'POST',
                data: oData,
                processData: false,  // tell jQuery not to process the data
                contentType: false,
                success: function (data) {
                    showMessage(data)
                }
            });
        }
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
        $('#btnClear').click();
        Materialize.updateTextFields();
    }

    function hasLeastOneMaterialTypeChecked() {
        var isChecked = false;
        var elementErrorRequired = document.getElementById("errorRequired");
        var elementsCheckboxes = document.getElementsByName("materialTypes")

        for (var i = 0; i < elementsCheckboxes.length; i++) {
            if( elementsCheckboxes[i].checked == true ) {
                isChecked = true;
                break;
            }
        }

        if(isChecked)
            //elementErrorRequired.setCustomValidity("");
            elementErrorRequired.innerHTML = "";
        else
            elementErrorRequired.innerHTML = "Selecione pelo menos uma opção";
        //elementErrorRequired.setCustomValidity("Selecione pelo menos uma opção");*/

        return isChecked;
    }

</script>