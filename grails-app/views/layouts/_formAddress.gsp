
    <div class="row">
        <div class="input-field col s12 m4">
            <input id="zipCode" name="zipCode" type="text" maxlength="9" class="validate" required>
            <label for="zipCode">CEP <span class="red-text">*</span></label>
            <span id="zipCodeErrorMessage" class="red-text"></span>

        </div>

        <div class="input-field col s12 m2">
            <select id="states" disabled required class="validate browser-default">
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
            <input id="street" name="street" type="text" class="validate" required disabled>
            <label for="street">Rua <span class="red-text">*</span></label>
        </div>

        <div class="input-field col s12 m4">
            <input id="number" name="number" type="text" class="validate" required>
            <label for="number">Número <span class="red-text">*</span></label>
        </div>
    </div>

    <div class="row">
        <div class="input-field col s12 m7">
            <input id="neighborhood" name="neighborhood" type="text" class="validate" required disabled>
            <label for="neighborhood">Bairro <span class="red-text">*</span></label>
        </div>

        <div class="input-field col s12 m5">
            <input id="city" name="city" type="text" class="validate" required disabled>
            <label for="city">Cidade <span class="red-text">*</span></label>
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



    var elementZipCode = document.getElementById("zipCode");

    $(document).ready(function () {
        $(".preloader-wrapper").hide();

        $("#zipCode").blur(function fillAddress() {
            $(".preloader-wrapper").show();

            //var zipcode only with digits.
            var zipCode = $(this).val().replace(/\D/g, '');

            if (zipCode != "") {

                var validatorZipCode = /^[0-9]{8}$/;

                if (validatorZipCode.test(zipCode)) {

                    $("#street").val("...");
                    $("#neighborhood").val("...");
                    $("#city").val("...");
                    Materialize.updateTextFields();

//                    if(!isOnLine()) {
//                        clearAddressInputs();
//                        enableAddressInputs();
//                        $("#zipCodeErrorMessage").text("Sem conexao com a internet.");
//                        $(".preloader-wrapper").hide();
//                    }

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

                        }
                        else {
                            clearAddressInputs();
                            enableAddressInputs();
                            $("#zipCodeErrorMessage").text("CEP não encontrado.");
                            $(".preloader-wrapper").hide();
                        }
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

    });

    function enableAddressInputs() {
        $("#states").removeAttr("disabled");
        $("#street").removeAttr("disabled");
        $("#neighborhood").removeAttr("disabled");
        $("#city").removeAttr("disabled");
    }

</script>