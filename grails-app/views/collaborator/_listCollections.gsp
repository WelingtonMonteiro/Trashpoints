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
            <th data-field="quantityOfCoins">Trashpoints</th>
        </tr>
        </thead>

        <tbody>
        <g:each in="${collaboratorCollections}" var="collect">
            <tr>
                <td>
                    <!-- Modal Trigger -->
                    <a class="waves-effect waves-light" onclick="openModalViewCollectImage(${collect.id})"
                       title="Ver Imagem da coleta">
                        <i class="fa fa-file-image-o fa-2x"></i>
                    </a>
                </td>
                <td>
                    <g:each in="${collect.materialTypes}" var="materialType">
                        <span>${materialType.name}</span><br/>
                    </g:each>
                </td>
                <td>${collect?.orderDate.format("dd/MM/yyyy")}</td>

                <g:if test="${collect?.isCollected}">
                    <td>
                        ${collect?.collectedDate?.format("dd/MM/yyyy")}
                    </td>
                    <td>
                        <input type="checkbox" class="disabled" checked="checked" disabled="disabled"/>
                        <label></label>
                    </td>
                    <td>
                        <!-- Modal Trigger -->
                        <a class="waves-effect waves-light" onclick="openModalCompanyDetails(${collect?.company?.id})"
                           title="Detalhes da empresa">
                            <i class="material-icons fa-2x">list</i>
                        </a>
                    </td>
                    <td>
                        <p style="text-align: left; margin-left: 2rem;" id="quantityOfCoins${collect.id}">
                            <i class="material-icons left" style="margin-right: 2px">monetization_on</i> ${collect.quantityOfCoins}
                        </p>
                    </td>
                </g:if>
                <g:else>
                    <td><p id="collectedDate${collect.id}">_</p></td>
                    <td><p>Não foi coletado ainda</p></td>
                    <td><a class="disabled grey-text"><i class="material-icons fa-2x">list</i></a></td>
                    <td><p id="quantityOfCoins${collect.id}">_</p></td>
                </g:else>

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

        <div id="companyDetails" class="center-align">
            <p>
                <label class="my-label">Razão Social:</label>
                <span id="companyName"></span>
            </p>

            <p>
                <label class="my-label">Nome Fantasia:</label>
                <span id="tradingName"></span>
            </p>

            <p>
                <label class="my-label">Telefone:</label>
                <span id="phone"></span>
            </p>

            <p><label class="my-label">Site:</label>
                <span id="site"></span>
            </p>

            <p>
                <label class="my-label">CEP:</label>
                <span id="zipCode"></span>
            </p>

            <p>
                <label class="my-label">Rua:</label><span id="street"></span>
                <label class="my-label">&nbsp; Número:</label><span id="number"></span>
            </p>

            <p>
                <label class="my-label">Bairro:</label><span id="neighborhood"></span>
            </p>
            <span>
                <label class="my-label">Cidade:</label><span id="city"></span>
                <label class="my-label">&nbsp; Estado:</label><span id="state"></span>
            </span>
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

    function openModalViewCollectImage(collectId) {
        $("#viewCollectImage").modal('open');
        loadCollectImage(collectId)
    }

    function openModalCompanyDetails(companyId) {
        $("#modalCompanyDetails").modal('open');
        loadCompanyDetails(companyId)
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

                    var imageUpload = "<img src='" + UPLOAD_FOLDER_PATH + "' style='max-height: 284px;'>"
                    $("#collectImage").append(imageUpload)
                } else {
                    var imageUpload = "<i class='fa fa-file-image-o fa-5x center-align'></i>"
                    $("#collectImage").append(imageUpload)
                }
            },
            complete: function () {
                $(".preloader-wrapper").hide();
            }
        });
    }

    function loadCompanyDetails(companyId) {
        $(".preloader-wrapper").show();

        $.ajax({
            url: "/Trashpoints/Collaborator/loadCompanyDetails/",
            data: {
                id: companyId
            },
            method: "post",
            success: function (data) {
                var company = data.company
                var address = data.address

                if (company) {
                    $("#companyDetails #companyName").text(company.companyName)
                    $("#companyDetails #tradingName").text(company.tradingName)
                    $("#companyDetails #phone").text(company.phone)
                    $("#companyDetails #site").text(company.site)
                }
                if (address) {
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
</script>

