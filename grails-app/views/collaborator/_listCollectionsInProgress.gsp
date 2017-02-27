<g:if test="${collaboratorCollections.size() > 0}">
    <table class="striped centered responsive-table">
        <thead>
        <tr>
            <th data-field="photo">Foto Coleta</th>
            <th data-field="types">Tipo(s)</th>
            <th data-field="orderDate">Data Pedido</th>
            <th data-field="scheduleDateCollect">Data Agendada</th>
            <th data-field="CompanyDetails">Empresa</th>
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
                    <g:join in="${collect.materialTypes.name}" delimiter=", " />
                </td>
                <td>${collect?.orderDate.format("dd/MM/yyyy")}</td>
                <td>
                    <g:if test="${collect?.scheduleDateCollect}">
                        ${collect?.scheduleDateCollect?.format("dd/MM/yyyy")}
                    </g:if>
                    <g:else>_</g:else>
                </td>
                <td><a class="disabled grey-text"><i class="material-icons fa-2x">list</i></a></td>
            </tr>

        </g:each>
        </tbody>
    </table>

    <br/>
    <ul class="pagination center">
        <%
            Integer pageIndex = params.pageIndex ? params.pageIndex.toInteger() : 1
            pageIndex = pageIndex <= 0 ? 1 : pageIndex
        %>

        <g:if test="${pageIndex <= 1}">
            <li class="disabled btn-disabled">
                <g:link>
                    <i class="material-icons">chevron_left</i>
                </g:link>
            </li>
        </g:if>
        <g:else>
            <li class="waves-effect">
                <g:link action="myCollectionsInProgress" controller="collaborator"
                        params="[pageIndex: pageIndex - 1]">
                    <i class="material-icons">chevron_left</i>
                </g:link>
            </li>
        </g:else>

        <g:each in="${(1..numberOfPages)}" var="number">
            <g:if test="${number == pageIndex}">
                <li class="active btn-disabled">
                    <g:link action="myCollectionsInProgress" controller="collaborator" params="[pageIndex: number]">
                        ${number}
                    </g:link>
                </li>
            </g:if>
            <g:else>
                <li class="waves-effect">
                    <g:link action="myCollectionsInProgress" controller="collaborator" params="[pageIndex: number]">
                        ${number}
                    </g:link>
                </li>
            </g:else>
        </g:each>

        <g:if test="${pageIndex >= numberOfPages}">
            <li class="disabled btn-disabled">
                <g:link>
                    <i class="material-icons">chevron_right</i>
                </g:link>
            </li>
        </g:if>
        <g:else>
            <li class="waves-effect">
                <g:link action="myCollectionsInProgress" controller="collaborator"
                        params="[pageIndex: pageIndex + 1]">
                    <i class="material-icons">chevron_right</i>
                </g:link>
            </li>
        </g:else>

    </ul>

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
                <label class="my-label">Razão Social: </label>
                <span id="companyName"></span>
            </p>

            <p>
                <label class="my-label">Nome Fantasia: </label>
                <span id="tradingName"></span>
            </p>

            <p>
                <label class="my-label">Telefone: </label>
                <span id="phone"></span>
            </p>

            <p><label class="my-label">Site: </label>
                <span id="site"></span>
            </p>

            <p>
                <label class="my-label">CEP: </label>
                <span id="zipCode"></span>
            </p>

            <p>
                <label class="my-label">Rua: </label><span id="street"></span>
                <label class="my-label">&nbsp; Número: </label><span id="number"></span>
            </p>

            <p>
                <label class="my-label">Bairro: </label><span id="neighborhood"></span>
            </p>
            <span>
                <label class="my-label">Cidade: </label><span id="city"></span>
                <label class="my-label">&nbsp; Estado: </label><span id="state"></span>
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

<script src="${resource(dir: 'js/Collaborator', file: 'myCollections.js')}" type="text/javascript"></script>
<script type="text/javascript">
    function setActiveItemMenu() {
        $('li#home').removeClass('active');
        $('li#myCollectionsInProgress').addClass('active');
    }
</script>