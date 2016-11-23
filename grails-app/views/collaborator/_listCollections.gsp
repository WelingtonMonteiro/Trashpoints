<g:if test="${collaboratorCollections.size() > 0}">
    <table class="striped centered responsive-table">
        <thead>
        <tr>
            <th data-field="photo">Foto Coleta</th>
            <th data-field="types">Tipo(s)</th>
            <th data-field="orderDate">Data Pedido</th>
            <th data-field="collectedDate">Data Coletada</th>
            <th data-field="isCollected">Foi Coletada?</th>
            <th data-field="CompanyDetails">Empresa</th>
        </tr>
        </thead>

        <tbody>
        <g:each in="${collaboratorCollections}" var="collect">
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
                    </g:if>
                    <g:else>
                        <p id="collectedDate${collect.id}"> _ </p>
                    </g:else>
                </td>
                <td>
                    <g:if test="${collect?.isCollected}">
                        <input type="checkbox" class="disabled" checked="checked" disabled="disabled" />
                        <label></label>
                    </g:if>
                    <g:else>
                        <input type="checkbox" class="disabled" disabled="disabled" />
                        <label></label>
                    </g:else>
                </td>
                <td>
                    <g:if test="${collect?.isCollected}">
                        <!-- Modal Trigger -->
                        <a class="waves-effect waves-light" onclick="openModalCompanyDetails(${collect?.company?.id})"
                           title="Detalhes da empresa">
                            <i class="material-icons fa-2x">list</i>
                        </a>
                    </g:if>
                    <g:else>
                        <a class="disabled grey-text">
                            <i class="material-icons fa-2x">list</i>
                        </a>
                    </g:else>
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

<!-- Modal Company details-->
<div id="modalCompanyDetails" class="modal">
    <a class="modal-action modal-close waves-effect waves-light btn-flat right">
        <i class="material-icons">close</i>
    </a>
    <div class="modal-content">
        <h5>Detalhes da Empresa</h5>
        <div id="companyDetails" class="left-align">
            <p><label>Razão Social: </label><span id="companyName"></span></p>
            <p><label>Nome Fantasia: </label><span id="tradingName"></span></p>
            <p><label>Telefone: </label><span id="phone"></span></p>
            <p><label>Site: </label><span id="site"></span></p>
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

<!-- Modal View Image of Collect -->
<div id="viewCollectImage" class="modal">
    <a class="modal-action modal-close waves-effect waves-light btn-flat right">
        <i class="material-icons">close</i>
    </a>
    <div class="modal-content">
        <h4>Foto da coleta</h4>
        <div id="collectImage" class="center-align">
        </div>
    </div>
    <div class="modal-footer">
        <a class=" modal-action modal-close waves-effect light btn-flat">Fechar</a>
    </div>
</div>


<script type="text/javascript">

    function openModalViewCollectImage(collectId) {
        $("#viewCollectImage").modal('open');
        loadCollectImage(collectId)
    }

    function openModalCompanyDetails(companyId) {
        $("#modalCompanyDetails").modal('open');
        loadCompanyDetails(companyId)
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

    function loadCompanyDetails(companyId) {
        $.ajax({
            url: "/Trashpoints/Collaborator/loadCompanyDetails/",
            data: {
                id: companyId
            },
            method: "post",
            success: function (data) {
                var company = data.company
                var address = data.address

                if (data.company) {
                    $("#companyDetails span#companyName").text(company.companyName)
                    $("#companyDetails span#tradingName").text(company.tradingName)
                    $("#companyDetails span#phone").text(company.phone)
                    $("#companyDetails span#site").text(company.site)

                    $("#companyDetails span#zipCode").text(address.zipCode)
                    $("#companyDetails span#street").text(address.street)
                    $("#companyDetails span#number").text(address.number)
                    $("#companyDetails span#neighborhood").text(address.neighborhood)
                    $("#companyDetails span#city").text(address.city)
                    $("#companyDetails span#state").text(address.state)
                }
            }
        });
    }
</script>

