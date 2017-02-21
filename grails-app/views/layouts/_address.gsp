<div class="row">
    <div class="input-field col s12 m4">
        <input id="zipCode" name="zipCode" type="text" value="${currentAddress?.zipCode}" maxlength="9" class="validate"
               required>
        <label for="zipCode">CEP <span class="red-text">*</span></label>
        <span id="zipCodeErrorMessage" class="red-text"></span>
    </div>

    <div class="input-field col s12 m4">
        <select id="states" disabled required class="validate browser-default" name="states" style="margin-top: 5px">
            <option value="" disabled selected>Selecione</option>
            <option value="AC">AC</option>
            <option value="AL">AL</option>
            <option value="AP">AP</option>
            <option value="AM">AM</option>
            <option value="BA">BA</option>
            <option value="CE">CE</option>
            <option value="DF">DF</option>
            <option value="ES">EF</option>
            <option value="GO">GO</option>
            <option value="MA">MA</option>
            <option value="MT">MT</option>
            <option value="MS">MS</option>
            <option value="MG">MG</option>
            <option value="PA">PA</option>
            <option value="PB">PB</option>
            <option value="PR">PR</option>
            <option value="PE">PE</option>
            <option value="PI">PI</option>
            <option value="RJ">RJ</option>
            <option value="RN">RN</option>
            <option value="RS">RS</option>
            <option value="RO">RO</option>
            <option value="RR">RR</option>
            <option value="SC">SC</option>
            <option value="SP">SP</option>
            <option value="SE">SE</option>
            <option value="TO">TO</option>
        </select>
        <label for="states" class="active">Estado <span class="red-text">*</span></label>
    </div>

    <div class="col s12 m4">
        <div class="preloader-wrapper big active">
            <div class="spinner-layer spinner-blue-only">
                <div class="circle-clipper left">
                    <div class="circle"></div>
                </div>

                <div class="gap-patch">
                    <div class="circle"></div>
                </div>

                <div class="circle-clipper right">
                    <div class="circle"></div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="input-field col s12 m8">
        <input id="street" name="street" type="text" value="${currentAddress?.street}" class="validate" required
               disabled>
        <label for="street">Rua <span class="red-text">*</span></label>
    </div>

    <div class="input-field col s12 m4">
        <input id="number" name="number" type="text" value="${currentAddress?.number}" class="validate" required>
        <label for="number">Número <span class="red-text">*</span></label>
    </div>
</div>

<div class="row">
    <div class="input-field col s12 m7">
        <input id="neighborhood" name="neighborhood" type="text" value="${currentAddress?.neighborhood}"
               class="validate" required disabled>
        <label for="neighborhood">Bairro <span class="red-text">*</span></label>
    </div>

    <div class="input-field col s12 m5">
        <input id="city" name="city" type="text" value="${currentAddress?.city}" class="validate" required disabled>
        <label for="city">Cidade <span class="red-text">*</span></label>
    </div>
</div>

<div class="row">
    <div class="input-field col s6 m6">
        <i class="material-icons prefix grey-text">my_location</i>
        <input id="latitude" name="latitude" type="text" value="${currentAddress?.latitude}" class="validate" required
               readonly="readonly">
        <label for="latitude">Latitude <span class="red-text">*</span></label>
    </div>

    <div class="input-field col s6 m6">
        <i class="material-icons prefix grey-text">my_location</i>
        <input id="longitude" name="longitude" type="text" value="${currentAddress?.longitude}" class="validate"
               required readonly="readonly">
        <label for="longitude">Longitude <span class="red-text">*</span></label>
    </div>
</div>

<script type="text/javascript">

    jQuery(function ($) {
        $("#zipCode").mask("99999-999");
    });

    function clearAddressInputs() {
        $("#street").val("");
        $("#neighborhood").val("");
        $("#city").val("");
        $("#states").val("");
    }

    $(document).ready(function () {
        $(".preloader-wrapper").hide();

        $("#zipCode").blur(function fillAddress() {
            $(".preloader-wrapper").show();

            var zipCode = $(this).val().replace(/\D/g, '');

            if (zipCode != "") {

                var validatorZipCode = /^[0-9]{8}$/;

                if (validatorZipCode.test(zipCode)) {

                    $("#street").val("...");
                    $("#neighborhood").val("...");
                    $("#city").val("...");
                    Materialize.updateTextFields();

                    $.getJSON("https://viacep.com.br/ws/" + zipCode + "/json/?callback=?", function (data) {

                        if (!("erro" in data)) {
                            $("#zipCodeErrorMessage").text("");
                            enableAddressInputs();

                            $("#zipCode").val(data.cep);
                            $("#states").val(data.uf)
                            $("#street").val(data.logradouro);
                            $("#neighborhood").val(data.bairro);
                            $("#city").val(data.localidade);
                            Materialize.updateTextFields();
                            $("#number").focus();
                            $(".preloader-wrapper").hide();

                            getMyLocationByAddress();
                        }
                        else {
                            clearAddressInputs();
                            enableAddressInputs();
                            $("#zipCodeErrorMessage").text("CEP não encontrado.");
                            $(".preloader-wrapper").hide();
                        }
                        <sec:ifLoggedIn>
                        $('#companyName').focus();
                        </sec:ifLoggedIn>
                    });
                }
                else {
                    clearAddressInputs();
                    $("#zipCodeErrorMessage").text("Formato de CEP inválido.");
                    $(".preloader-wrapper").hide();
                }
            }
            else {
                //cep sem valor
                clearAddressInputs();
                $(".preloader-wrapper").hide();
            }

        });

        <sec:ifLoggedIn >
        enableAddressInputs();
        </sec:ifLoggedIn>

        $("#states").val('${currentAddress?.state}');
    });

    function enableAddressInputs() {
        $("#states").removeAttr("disabled");
        $("#street").removeAttr("disabled");
        $("#neighborhood").removeAttr("disabled");
        $("#city").removeAttr("disabled");
    }

    $("#number").change(function () {
        getMyLocationByAddress();
    });

    $("#street").change(function () {
        getMyLocationByAddress();
    });

</script>

<script src="${resource(dir: 'js', file: 'mapCollaborator.js')}" type="text/javascript"></script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyA6W1hTA1qEYPC1qi4V3dvDkIcg75yUc68"></script>
