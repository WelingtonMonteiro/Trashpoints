<g:form name="formCollaborator" useToken="true">
    <input type="hidden" value="${currentCollaborator?.id}" name="id" id="id">
    <fieldset>
        <legend><h5 class="header">&nbsp;Dados do Colaborador&nbsp;</h5></legend>

        <div class="row">
            <div class="input-field col s12 m12">
                <i class="material-icons prefix" aria-hidden="true">account_circle</i>
                <input id="name" name="name" type="text" required minlength="2" class="validate" autofocus
                       value="${currentCollaborator?.name}"/>
                <label for="name">Nome<span class="red-text">*</span></label>
            </div>
        </div>

        <div class="row">
            <div class="input-field col s12 m6">
                <i class="material-icons prefix">today</i>
                <input id="dateOfBirth" name="dateOfBirth" type="text" placeholder="dd/mm/aaaa"
                       class="valid datepicker" value="<g:formatDate date="${currentCollaborator?.dateOfBirth}"
                                                                     format="dd/MM/yyyy"></g:formatDate>"/>
                <label for="dateOfBirth" class="active">Data Nascimento<span class="red-text">*</span></label>
            </div>
        </div>

        <div class="row">
            <div class="input-field col s12 m6 l6">
                <i class="material-icons prefix">contact_phone</i>
                <input id="phone" name="phone" type="tel" class="validate" required
                       value="${currentCollaborator?.phone}">
                <label for="phone">Telefone <span class="red-text">*</span></label>
            </div>
        </div>

    </fieldset>
    <br/>
    <fieldset>
        <legend><h5 class="header">&nbsp;Endereço de coleta&nbsp;</h5></legend>

        <g:set var="currentAddress" value="${currentCollaborator?.address}"/>

        <div id="formAddress">
            <g:if test="${currentCollaborator?.address}">
                <g:render template="../layouts/address" model="['currentAddress': currentAddress]"/>
            </g:if>
            <g:else>
                <g:render template="../layouts/address"/>
            </g:else>
        </div>
    </fieldset>
    <br>
    <fieldset>
        <legend><h5 class="header">&nbsp;Endereço Residencial&nbsp;</h5></legend>

        <div class="row">
            <div class="input-field col s12 m12">
                <p>
                    <input type="checkbox" id="isAddressEqual" name="isAddressEqual" checked="${currentCollaborator?.isAddressEqual}" />
                    <label for="isAddressEqual">Endereço residencial é o mesmo da coleta?</label>
                </p>
            </div>
        </div>
    </fieldset>

    <div class="row">
        <div class="input-field col s12">

            <button type="submit" class="btn-large waves-effect waves-light blue darken-3">
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

<script src="${application.contextPath}/js/Collaborator/edit.js" type="text/javascript"></script>