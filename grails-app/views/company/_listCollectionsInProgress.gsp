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
            <th data-field="scheduleDateCollect">Data Agendada</th>
            <th data-field="isCollected">Foi Coletada?</th>
            <th data-field="detailsCompany">Colaborador</th>
            <!-- <th>Ações</th> -->
        </tr>
        </thead>

        <tbody>
        <g:each in="${companyCollections}" var="collect">
            <tr>
                <td>
                    <!-- Modal Trigger -->
                    <a class="waves-effect waves-light" onclick="openModalViewCollectImage(${collect.id})"
                       title="Ver Imagem da coleta">
                        <i class="fa fa-file-image-o fa-2x left"></i>
                    </a>
                </td>
                <td>
                    <g:join in="${collect.materialTypes.name}" delimiter=", " />
                </td>
                <td>${collect?.orderDate?.format("dd/MM/yyyy")}</td>
                <td>
                    <g:if test="${collect?.scheduleDateCollect}">
                        ${collect?.scheduleDateCollect?.format("dd/MM/yyyy")}</g:if>
                    <g:else>_</g:else>
                </td>
                <td>
                    <!-- Modal Trigger -->
                    <a class="waves-effect waves-light"
                       onclick="openModalCollaboratorDetails(${collect?.collaborator?.id})"
                       title="Detalhes do colaborador">
                        <i class="material-icons fa-2x">list</i>
                    </a>
                </td>
                <td>
                    <p title="Foi coletada?">
                        <input type="checkbox" id="isCollected${collect.id}"
                               onchange="openModalConfirmation(${collect.id})"/>
                        <label for="isCollected${collect.id}"></label>
                    </p>
                </td>
                %{--<td>
                    <a class="waves-effect waves-light"
                       onclick="openModalUpdateScheduleDate('${collect?.scheduleDateCollect}', ${collect?.id})"
                       title="Alterar data de coleta agendada">
                        <i class="material-icons fa-2x">query_builder</i>
                    </a>
                </td>--}%
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
                <g:link action="myCollectionsInProgress" controller="company"
                        params="[pageIndex: pageIndex - 1]">
                    <i class="material-icons">chevron_left</i>
                </g:link>
            </li>
        </g:else>

        <g:each in="${(1..numberOfPages)}" var="number">
            <g:if test="${number == pageIndex}">
                <li class="active btn-disabled">
                    <g:link action="myCollectionsInProgress" controller="company" params="[pageIndex: number]">
                        ${number}
                    </g:link>
                </li>
            </g:if>
            <g:else>
                <li class="waves-effect">
                    <g:link action="myCollectionsInProgress" controller="company" params="[pageIndex: number]">
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
                <g:link action="myCollectionsInProgress" controller="company"
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
                <label class="my-label">&nbsp; Número: </label><span id="number"></span>
            </p>

            <p><label class="my-label">Bairro: </label><span id="neighborhood"></span></p>
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

<!-- Modal para selecao de data e hora -->
%{--<div id="dateTimeToCollectModal" class="modal">
    <div class="modal-content">
        <h4>Seleção de data e hora</h4>
        <p>Selecione a data da coleta:</p>

        <div class="row">
            <div class="input-field col s12">
                <i class="material-icons prefix">today</i>
                <input type="date" class="datepicker" id="txb-collect-date">
                <label for="txb-collect-date" class="active">Data:<span class="red-text">*</span></label>
            </div>
        </div>

        <div class="row">
            <div class="input-field col s12">
                <i class="material-icons prefix">schedule</i>
                <input id="txb-collect-time" class="timepicker" type="time" data-default="00:00:00">
                <input type="hidden" id="fld-collect-id"/>
                <label for="txb-collect-time" class="active">Hora:<span class="red-text">*</span></label>
            </div>
        </div>
    </div>

    <div class="modal-footer">
        <a id="btn-schedule-collect" href="#!" class="waves-effect waves-light btn-flat">Remarcar coleta</a>
        <a id="btn-cancel-datetime-collect" href="#!" class="waves-effect waves-light btn-flat">Cancelar</a>
    </div>
</div>--}%

%{-- <script src="${application.contextPath}/js/materialize.clockpicker.min.js" type="text/javascript"></script>
<script src="${application.contextPath}/js/moment.min.js" type="text/javascript"></script> --}%
<script src="${application.contextPath}/js/Company/myCollections.js" type="text/javascript"></script>
<script type="text/javascript">
    function setActiveItemMenu() {
        $('li#home').removeClass('active');
        $('li#myCollectionsInProgress').addClass('active');
    }
</script>
