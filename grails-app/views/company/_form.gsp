<g:form name="formCompany" useToken="true">

    <fieldset>
        <legend><h5 class="header">&nbsp;Dados da Empresa&nbsp;</h5></legend>

        <div class="row">
            <div class="input-field col s12 m12">
                <i class="fa fa-building-o prefix" aria-hidden="true"></i>
                <input id="companyName" name="companyName" type="text" required minlength="2" class="validate"
                       autofocus="autofocus"/>
                <label for="companyName">Razão social<span class="red-text">*</span></label>
            </div>
        </div>

        <div class="row">
            <div class="input-field col s12 m12">
                <i class="fa fa-building-o prefix" aria-hidden="true"></i>
                <input id="tradingName" name="tradingName" type="text" required class="validate">
                <label for="tradingName">Nome fantasia <span class="red-text">*</span></label>
            </div>
        </div>

        <div class="row">
            <div class="input-field col s12 m12">
                <i class="fa fa-id-card prefix"></i>
                <input id="identificationNumber" name="identificationNumber" type="text" class="validate" required
                       maxlength="18" minlength="18">
                <label for="identificationNumber">CNPJ <span class="red-text">*</span></label>
            </div>
        </div>

        <div class="row">
            <div class="input-field col s12 m12">
                <br/>

                <p>
                    <input class="with-gap validate" name="typeOfCompany" type="radio" id="recyclingCompany"
                           value="coleta" required/>
                    <label for="recyclingCompany">Empresa de coleta</label>
                </p>

                <p>
                    <input class="with-gap validate" name="typeOfCompany" type="radio" id="partnerCompany"
                           value="parceira" required/>
                    <label for="partnerCompany">Empresa parceira</label>
                </p>
                <label>Tipo da Empresa <span class="red-text">*</span></label>
            </div>
        </div>

        <div class="row">
            <div class="input-field col s12 m4">
                <i class="material-icons prefix">contact_phone</i>
                <input id="phone" name="phone" type="tel" class="validate" required>
                <label for="phone">Telefone <span class="red-text">*</span></label>
            </div>

            <div class="input-field col s12 m8">
                <i class="material-icons prefix">http</i>
                <input id="site" name="site" type="url" class="validate">
                <label for="site">Site</label>
            </div>
        </div>
    </fieldset>

    <br/>
    <fieldset>
        <legend><h5 class="header">&nbsp;Dados do Login&nbsp;</h5></legend>

        <div id="formUser">
            <g:render template="../userManager/authLogin"></g:render>
        </div>

    </fieldset>

    <br/>
    <fieldset>
        <legend><h5 class="header">&nbsp;Endereço &nbsp;</h5></legend>

        <div id="formAddress">
            <g:render template="../layouts/address"></g:render>
        </div>

    </fieldset>

    <div class="row">
        <div class="input-field col s12">
            <button type="submit" class="btn-large waves-effect waves-light blue darken-3" >
                <i class="material-icons left">check</i>Cadastrar
            </button>

            <button type="reset" id="btnClear" class="btn-large waves-effect waves-light grey right">
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

<script src="${application.contextPath}/js/Company/create.js" type="text/javascript"></script>