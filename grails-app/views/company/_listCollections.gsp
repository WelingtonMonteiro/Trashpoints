<g:if test="${companyCollections.size() > 0}">
    <g:form name="formCollections" controller="company" action="markWasCollected" useToken="true">
        <g:hiddenField name="collectId"></g:hiddenField>
    </g:form>

    <table class="striped centered responsive-table">
        <thead>
        <tr>
            <th data-field="photo">Foto Coleta</th>
            <th data-field="types">Tipo(s)</th>
            <th data-field="orderDate">Data Pedido</th>
            <th data-field="collectedDate">Data Coletada</th>
            <th data-field="isCollected">Foi Coletada?</th>
            <th data-field="detailsCompany">Colaborador</th>
        </tr>
        </thead>

        <tbody>
        <g:each in="${companyCollections}" var="collect">
            <tr>
                <td>
                    <!-- Modal Trigger -->
                    <a class="waves-effect waves-light" onclick="openModalViewCollectImage(${collect.id})" title="Ver Imagem da coleta">
                        <i class="fa fa-file-image-o fa-2x"></i>
                    </a>
                </td>
                <td>
                    <g:each in="${collect.materialTypes}" var="materialType">
                        <span>${materialType.name}</span><br/>
                    </g:each>
                </td>
                <td>${collect?.orderDate?.format("dd/MM/yyyy")}</td>
            <td>
                <g:if test="${collect?.isCollected}">
                    ${collect?.collectedDate?.format("dd/MM/yyyy")}
                    </td>
                </g:if>
                <g:else>
                    <p id="collectedDate${collect.id}">-</p>
                </g:else>
                <td>
                    <g:if test="${collect?.isCollected}">
                        <p title="Foi coletada?">
                            <input type="checkbox" checked="checked" disabled="disabled" />
                            <label></label>
                        </p>
                    </g:if>
                    <g:else>
                        <p title="Foi coletada?">
                            <input type="checkbox" id="isCollected${collect.id}" onchange="openModalConfirmation(${collect.id})" />
                            <label for="isCollected${collect.id}"></label>
                        </p>
                    </g:else>
                </td>
                <td>
                    <!-- Modal Trigger -->
                    <a class="waves-effect waves-light" onclick="openModalCollaboratorDetails(${collect?.collaborator?.id})"
                       title="Detalhes do colaborador">
                        <i class="material-icons fa-2x">list</i>
                    </a>
                </td>
            </tr>

        </g:each>
        </tbody>
    </table>
</g:if>
<g:else>
    <div id="infoMessage" class="row">
        <div class="col s12 m6">
            <div class="card-panel grey lighten-5">
                <i class="material-icons left blue-text lighten-1">info</i>
                <span class="black-text">Você ainda não possui coletas</span>
            </div>
        </div>
    </div>
</g:else>

<!-- Modal Collaborator details-->
<div id="modalCollaboratorDetails" class="modal">
    <a class="modal-action modal-close waves-effect waves-light btn-flat right">
        <i class="material-icons">close</i>
    </a>
    <div class="modal-content">
        <h5>Detalhes do Colaborador</h5>
        <div class="center-align">
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
        <div id="collaboratorDetails" class="center-align">
            <p><label class="my-label">Nome: </label><span id="name"></span></p>
            <p><label class="my-label">Telefone: </label><span id="phone"></span></p>
            <p><label class="my-label">CEP: </label><span id="zipCode"></span></p>
            <p>
                <label class="my-label">Rua: </label><span id="street"></span>
                <label class="my-label"> &nbsp; Número: </label><span id="number"></span>
            </p>
            <p><label class="my-label">Bairro: </label><span id="neighborhood"></span></p>
            <span>
                <label class="my-label">Cidade: </label><span id="city"></span>
                <label class="my-label"> &nbsp; Estado: </label><span id="state"></span>
            </span>
        </div>
    </div>
    <div class="modal-footer">
        <a class=" modal-action modal-close waves-effect light btn-flat">Fechar</a>
    </div>
</div>

<!-- Modal Collect Confirmation -->
<div id="modalConfirmationCollect" class="modal">
    <div class="modal-content">
        <h5>Confirmação da ação</h5>
        <p>Deseja realmente marcar que a coleta foi recolhida?</p>
    </div>
    <div class="modal-footer">
        <a class="modal-action modal-close waves-effect waves-light btn-flat" onclick="wasNotCollected()">Não</a>
        <a class="modal-action modal-close waves-effect waves-light btn-flat" onclick="markWasCollected()">Sim</a>
    </div>
</div>

<!-- Modal View Collect Image -->
<div id="modalViewCollectImage" class="modal">
    <a class="modal-action modal-close waves-effect waves-light btn-flat right">
        <i class="material-icons">close</i>
    </a>
    <div class="modal-content">
        <h5>Foto da coleta</h5>
        <div id="collectImage" class="center-align"></div>
        <div class="center-align">
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
    <div class="modal-footer">
        <a class=" modal-action modal-close waves-effect light btn-flat">Fechar</a>
    </div>
</div>


<script type="text/javascript">
    var global_collect_id;

    function openModalViewCollectImage(collectId) {
        $("#modalViewCollectImage").modal({
            dismissible: false
        })
        $("#modalViewCollectImage").modal('open');
        loadCollectImage(collectId)
    }

    function loadCollectImage(collectId) {
        $(".preloader-wrapper").show();

        $.ajax({
            url: "/Trashpoints/Collect/loadCollectImage/",
            data: {
                id: collectId
            },
            method: "post",
            success: function (data) {
                $("#collectImage").html("")

                if (data.imagePath) {
                    var UPLOAD_FOLDER_PATH = "/Trashpoints/images/uploads/" + data.imagePath;
                    var imageUpload = "<img src='" + UPLOAD_FOLDER_PATH +"' style='max-height: 284px;'>";
                    $("#collectImage").append(imageUpload)
                }else{
                    var imageUpload = "<i class='fa fa-file-image-o fa-5x center-align'></i>"
                    $("#collectImage").append(imageUpload)
                }
            },
            complete: function () {
                $(".preloader-wrapper").hide();
            }
        });
    }

    function openModalCollaboratorDetails(collaboratorId) {
        $("#modalCollaboratorDetails").modal({
            dismissible: false
        })
        $("#modalCollaboratorDetails").modal('open');
        loadCollaboratorDetails(collaboratorId)
    }

    function loadCollaboratorDetails(collaboratorId) {
        $(".preloader-wrapper").show();

        $.ajax({
            url: "/Trashpoints/Company/loadCollaboratorDetails/",
            data: {
                id: collaboratorId
            },
            method: "post",
            success: function (data) {
                var collaborator = data.collaborator
                var address = data.address

                if (collaborator) {
                    $("#collaboratorDetails span#name").text(collaborator.name)
                    $("#collaboratorDetails span#phone").text(collaborator.phone)
                }
                if (address){
                    $("#collaboratorDetails span#zipCode").text(address.zipCode)
                    $("#collaboratorDetails span#street").text(address.street)
                    $("#collaboratorDetails span#number").text(address.number)
                    $("#collaboratorDetails span#neighborhood").text(address.neighborhood)
                    $("#collaboratorDetails span#city").text(address.city)
                    $("#collaboratorDetails span#state").text(address.state)
                }
            },
            complete: function () {
                $(".preloader-wrapper").hide();
            }

        });
    }

    function openModalConfirmation(collectId) {
        global_collect_id = collectId
        $("input[type=hidden]#collectId").val(collectId)
        $("#modalConfirmationCollect").modal({
            dismissible: false
        })
        $("#modalConfirmationCollect").modal('open');
    }

    function markWasCollected() {
        var collectId = global_collect_id
        var formData = jQuery("form[name=formCollections]").serializeArray();

        $.ajax({
            url: "/Trashpoints/Company/markWasCollected/",
            data: formData,
            method: "post",
            success: function (data) {
                if (data.success) {
                    Materialize.toast("Salvo com sucesso", 3000);
                    disabledCheckBoxClicked(collectId)
                    $("#collectedDate" + collectId).text(data.collectedDate)
                }
                $("#SYNCHRONIZER_TOKEN").val(data.newToken);
            }
        });
    }

    function wasNotCollected() {
        var collectId = global_collect_id
        $("input[type=checkbox]#isCollected" + collectId).prop("checked", false)
    }

    function disabledCheckBoxClicked(collectId) {
        $("input[type=checkbox]#isCollected" + collectId).prop("disabled", true).removeAttr("onchange")
    }


</script>

