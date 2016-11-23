<g:if test="${companyCollections.size() > 0}">
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
        <div id="collaboratorDetails" class="left-align">
            <p><label>Nome: </label><span id="name"></span></p>
            <p><label>Telefone: </label><span id="phone"></span></p>
            <p><label>CEP: </label><span id="zipCode"></span></p>
            <p><label>Rua: </label><span id="street"></span> <label> &nbsp; Número: </label><span id="number"></span></p>
            <p><label>Bairro: </label><span id="neighborhood"></span></p>
            <span><label>Cidade: </label><span id="city"></span> <label> &nbsp; Estado: </label><span id="state"></span></span>
        </div>
    </div>
    <div class="modal-footer">
        <a class=" modal-action modal-close waves-effect light btn-flat">Fechar</a>
    </div>
</div>

<!-- Modal Collect Confirmation -->
<div id="confirmationCollect" class="modal">
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
<div id="viewCollectImage" class="modal">
    <a class="modal-action modal-close waves-effect waves-light btn-flat right">
        <i class="material-icons">close</i>
    </a>
    <div class="modal-content">
        <h5>Foto da coleta</h5>
        <div id="collectImage" class="center-align">
        </div>
    </div>
    <div class="modal-footer">
        <a class=" modal-action modal-close waves-effect light btn-flat">Fechar</a>
    </div>
</div>


<script type="text/javascript">
    var global_collect_id;

    function openModalViewCollectImage(collectId) {
        $("#viewCollectImage").modal('open');
        loadCollectImage(collectId)
    }

    function openModalCollaboratorDetails(collaboratorId) {
        $("#modalCollaboratorDetails").modal('open');
        loadCollaboratorDetails(collaboratorId)
    }

    function loadCollectImage(collectId) {
        $.ajax({
            url: "/Trashpoints/Collaborator/loadCollectImage/",
            data: {
                id: collectId
            },
            method: "post",
            success: function (data) {
                $("#collectImage").html("")

                if (data.imagePath) {
                    var imagePath = "<img src='" + data.imagePath +"' style='max-height: 168px;'>"
                    $("#collectImage").append(imagePath)
                }else{
                    var imagePath = "<i class='fa fa-file-image-o fa-5x center-align'></i>"
                    $("#collectImage").append(imagePath)
                }
            }
        });
    }

    function openModalConfirmation(collectId) {
        global_collect_id = collectId
        $("#confirmationCollect").modal({
            dismissible: false
        })
        $("#confirmationCollect").modal('open');
    }

    function markWasCollected() {
        var collectId = global_collect_id
        $.ajax({
            url: "/Trashpoints/Company/markWasCollected/",
            data: {
                id: collectId
            },
            method: "post",
            success: function (data) {
                if (data.success) {
                    Materialize.toast("Coleta marcada", 3000);
                    disabledCheckBoxClicked(collectId)
                    $("#collectedDate" + collectId).text(data.collectedDate)
                }
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

    function loadCollaboratorDetails(collaboratorId) {
        $.ajax({
            url: "/Trashpoints/Company/loadCollaboratorDetails/",
            data: {
                id: collaboratorId
            },
            method: "post",
            success: function (data) {
                var collaborator = data.collaborator
                var address = data.address

                if (data.collaborator) {
                    $("#collaboratorDetails span#name").text(collaborator.name)
                    $("#collaboratorDetails span#phone").text(collaborator.phone)

                    $("#collaboratorDetails span#zipCode").text(address.zipCode)
                    $("#collaboratorDetails span#street").text(address.street)
                    $("#collaboratorDetails span#number").text(address.number)
                    $("#collaboratorDetails span#neighborhood").text(address.neighborhood)
                    $("#collaboratorDetails span#city").text(address.city)
                    $("#collaboratorDetails span#state").text(address.state)
                }
            }
        });
    }

</script>

