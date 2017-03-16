<div class="row no-margin">
    <div class="input-field col s12 m6">
        <i class="material-icons prefix grey-text text-darken-2">today</i>
        <input id="orderDate" name="orderDate" type="text" disabled class="grey-text text-darken-2"
               value="<g:formatDate date="${new java.util.Date()}" format="dd/MM/yyyy"></g:formatDate>">
        <label for="orderDate" class="active grey-text text-darken-2">Data da Coleta <span class="red-text">*</span>
        </label>
    </div>
</div>

<g:form name="formCollect" useToken="true">
    <div class="row">
        <div class="input-field col s12 m12">
            <h6 class="header bold">Selecione um ou mais tipos da coleta: <span class="red-text">*</span></h6>
            <span id="errorRequired" class="red-text"></span>

            <g:each in="${materialTypes}" var="materialType">
                <p class="margin-bottom">
                    <input type="checkbox" value="${materialType.id}" name="materialTypes" id="${materialType.name}"/>
                    <label for="${materialType.name}">
                        <img src="${application.contextPath}/${materialType.url}" />
                    </label>

                </p>
            </g:each>
        </div>
    </div>
    <g:hiddenField name='imageUploadUrl'/>

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
        <div class="input-field col s12">
            <button class="btn-large waves-effect waves-light blue darken-3" type="submit" name="submit">
                <i class="material-icons left">check</i>Cadastrar
                <span id="preloader-container" style="margin-left: 0.4rem;"></span>
            </button>

            <button class="btn-large waves-effect waves-light grey right" type="reset" id="btnClear">
                <i class="material-icons left">delete_sweep</i>Limpar
            </button>

            <div class="preloader-wrapper small right active hidden" style="margin-top: 0.5rem !important;">
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
</g:form>

<div class="row">
    <div class="col s12 m8">
        <div class="card-panel grey lighten-5">
            <i class="material-icons left orange-text">warning</i>
            <span class="black-text">Campos marcados com <span class="red-text">*</span> são obrigatórios</span>
        </div>
    </div>
</div>

<script src="${application.contextPath}/js/firebase.js" type="text/javascript"></script>
<script src="${application.contextPath}/js/Collect/create.js" type="text/javascript"></script>
<script src="${application.contextPath}/js/Collect/storageFile.js" type="text/javascript"></script>
