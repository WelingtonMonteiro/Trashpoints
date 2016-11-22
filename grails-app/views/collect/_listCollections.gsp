<g:if test="${collaboratorCollections.size() > 0}">
    <table class="striped centered responsive-table">
        <thead>
        <tr>
            <th data-field="photo">Foto Coleta</th>
            <th data-field="types">Tipo(s)</th>
            <th data-field="orderDate">Data Pedido</th>
            <th data-field="collectedDate">Data Coletada</th>
            <th data-field="isCollected">Foi Coletada?</th>
            <th data-field="detailsCompany">Empresa</th>
        </tr>
        </thead>

        <tbody>
        <g:each in="${collaboratorCollections}" var="collect">
            <tr>
                %{--<td><img src="${collect?.imageUpload}" style="max-height: 168px;"></td>--}%
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
                    <a class="waves-effect waves-light" href="#detailsCompany" id="${collect?.company?.id}" title="Detalhes da empresa">
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

<!-- Modal details Company -->
<div id="detailsCompany" class="modal">
    <a href="#!" class="modal-action modal-close waves-effect waves-light btn-flat right">
        <i class="material-icons">close</i>
    </a>
    <div class="modal-content">
        <h4>Detalhes da Empresa</h4>
        <p></p>
    </div>
    <div class="modal-footer">
        <a href="#!" class=" modal-action modal-close waves-effect light btn-flat">Fechar</a>
    </div>
</div>

<!-- Modal Confirmation of Collect -->
<div id="confirmationCollect" class="modal">
    <div class="modal-content">
        <h4>Confirmação de que foi recolhida</h4>
        <p>Deseja realmente marcar que a coleta foi recolhida?</p>
    </div>
    <div class="modal-footer">
        <a class="modal-action modal-close waves-effect waves-light btn-flat" onclick="wasNotCollected()">Não</a>
        <a class="modal-action modal-close waves-effect waves-light btn-flat" onclick="markWasCollected()">Sim</a>
    </div>
</div>

<!-- Modal View Image of Collect -->
<div id="viewCollectImage" class="modal">
    <a href="#!" class="modal-action modal-close waves-effect waves-light btn-flat right">
        <i class="material-icons">close</i>
    </a>
    <div class="modal-content">
        <h4>Foto da coleta</h4>
        <div id="collectImage" class="center-align">
        </div>
    </div>
    <div class="modal-footer">
        <a href="#!" class=" modal-action modal-close waves-effect light btn-flat">Fechar</a>
    </div>
</div>


<script type="text/javascript">
    var global_collect_id;

    function openModalViewCollectImage(collectId) {
        $("#viewCollectImage").modal('open');
        loadCollectImage(collectId)
    }
    
    function loadCollectImage(collectId) {
        $.ajax({
            url: "/Trashpoints/Collect/loadCollectImage/",
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
            url: "/Trashpoints/Collect/markWasCollected/",
            data: {
                id: global_collect_id
            },
            method: "post",
            success: function (data) {
                if (data.success) {
                    Materialize.toast("Sucesso ao marcar", 3000);
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

    $(document).ready(function () {

    });

</script>

