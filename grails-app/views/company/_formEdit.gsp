<g:form name="formCompany" useToken="true">
    <input type="hidden" id="id" name="id" value="${currentCompany?.id}" >
    <fieldset>
        <legend><h5 class="header">&nbsp;Dados da Empresa&nbsp;</h5></legend>
        <div class="row">
            <div class="input-field col s12 m12">
                <i class="fa fa-building-o prefix" aria-hidden="true"></i>
                <input id="companyName" name="companyName" type="text" required minlength="2" class="validate"
                       autofocus="autofocus" value="${currentCompany?.companyName}"/>
                <label for="companyName">Razão social<span class="red-text">*</span></label>
            </div>
        </div>

        <div class="row">
            <div class="input-field col s12 m12">
                <i class="fa fa-building-o prefix" aria-hidden="true"></i>
                <input id="tradingName" name="tradingName" type="text" required class="validate" value="${currentCompany?.tradingName}">
                <label for="tradingName">Nome fantasia <span class="red-text">*</span></label>
            </div>
        </div>

        <div class="row">
            <div class="input-field col s12 m12">
                <i class="fa fa-id-card prefix"></i>
                <input id="identificationNumber" name="identificationNumber" type="text" class="validate" required
                       maxlength="18" minlength="18" value="${currentCompany?.identificationNumber}">
                <label for="identificationNumber">CNPJ <span class="red-text">*</span></label>
            </div>
        </div>

        %{--<div class="row">--}%
            %{--<div class="input-field col s12 m12">--}%
                %{--<i class="material-icons prefix">business</i>--}%
                %{--<input id="segment" name="segment" type="text" class="validate" required value="${currentCompany?.segment}">--}%
                %{--<label for="segment">Segmento <span class="red-text">*</span></label>--}%
            %{--</div>--}%
        %{--</div>--}%

        <div class="row">
            <div class="input-field col s12 m12">
                <br/>
                <!-- TODO: verificar se por JavaScript fica melhor -->
                <g:if test="${currentCompany?.typeOfCompany == 'coleta'}">
                    <input class="with-gap disabled" name="typeOfCompany" type="radio" id="recyclingCompany"
                        value="coleta" checked="checked" disabled="disabled"/>
                </g:if>
                <g:else>
                    <input class="with-gap validate" name="typeOfCompany" type="radio" id="recyclingCompany"
                        value="coleta" required />
                </g:else>
                <label for="recyclingCompany">Empresa de coleta</label>
                </p>
                <p>
                    <g:if test="${currentCompany?.typeOfCompany == 'parceira'}">
                        <input class="with-gap disabled" name="typeOfCompany" type="radio" id="partnerCompany"
                               value="parceira" checked="checked" disabled="disabled"/>
                    </g:if>
                    <g:else>
                        <input class="disabled" name="typeOfCompany" type="radio" id="partnerCompany"
                               value="parceira"  disabled="disabled"/>
                    </g:else>
                    <label for="partnerCompany">Empresa parceira</label>
                </p>
                <label>Tipo da Empresa <span class="red-text">*</span></label>
            </div>
        </div>

        <div class="row">
            <div class="input-field col s12 m4">
                <i class="material-icons prefix">contact_phone</i>
                <input id="phone" name="phone" type="tel" class="validate" required value="${currentCompany?.phone}">
                <label for="phone">Telefone <span class="red-text">*</span></label>
            </div>

            <div class="input-field col s12 m8">
                <i class="material-icons prefix">http</i>
                <input id="site" name="site" type="url" class="validate" value="${currentCompany?.site}">
                <label for="site">Site</label>
            </div>
        </div>
    </fieldset>
    <br/>
    <fieldset>
        <legend><h5 class="header">&nbsp;Endereço &nbsp;</h5></legend>
        <g:set var="currentAddress" value="${currentCompany?.address}"/>
        <div id="formAddress">
        <g:if test="${currentCompany?.address}">
            <g:render template="../layouts/address" model="['currentAddress': currentAddress]"/>
        </g:if>
        <g:else>
            <g:render template="../layouts/address"/>
        </g:else>
        </div>
    </fieldset>

    <div class="row">
        <div class="input-field col s12">
            <button type="submit" class="btn-large waves-effect waves-light blue darken-3" >
                <i class="material-icons left">check</i>Salvar
            </button>

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

<script src="${application.contextPath}/js/Company/edit.js" type="text/javascript"></script>
