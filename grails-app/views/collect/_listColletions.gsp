<g:if test="${clientCollections.size() > 0}">
    <table class="striped responsive-table centered">
        <thead>
        <tr>
            <th data-field="photo">Foto</th>
            <th data-field="types">Tipo(s)</th>
            <th data-field="orderDate">Data Pedido</th>
            <th data-field="collectedDate">Data Coletada</th>
            <th data-field="isCollected">Foi Coletada?</th>
            <th data-field="detailsCompany">Empresa</th>
        </tr>
        </thead>

        <tbody>
        <g:each in="${clientCollections}" var="collect">
            <tr>
                <td><img height="168" src="${collect.image_upload}"></td>
                <td><label>${collect.type}</label></td>
                <td><label>${collect.date}</label></td>
                <td>${collect.date}</td>
                <td>
                    <g:if test="${collect.isCollected}">
                        <p title="Foi coletada?">
                            <input type="checkbox" checked="checked" disabled="disabled" />
                            <label for="isCollected${collect.id}"></label>
                        </p>
                    </g:if>
                    <g:else>
                        <p title="Foi coletada?">
                            <input type="checkbox" onclick="markWasCollected(${collect.id})" />
                            <label for="isCollected${collect.id}"></label>
                        </p>
                    </g:else>
                </td>
                <td>
                    <!-- Modal Trigger -->
                    <a class="waves-effect waves-light" href="#detailsCompany" id="${collect.company.id}" title="Detalhes da empresa">
                        <i class="material-icons fa-3x">list</i>
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
        <p>A bunch of text</p>
    </div>
    <div class="modal-footer">
        <a href="#!" class=" modal-action modal-close waves-effect light btn-flat">Fechar</a>
    </div>
</div>

<script type="text/javascript">

    function markWasCollected(collectId) {
        if(confirm("Deseja realmente marcar que foi recolhido?")) {
            $.ajax({
                url: "/Trashpoints/Collect/markWasCollected/",
                data: {
                    id: collectId
                },
                method: "post",
                success: function (data) {
                    if (data.success) {
                        var $toastContent = $("<span class='indigo accent-2 white-text'>Sucesso ao marcar</span>");
                        Materialize.toast($toastContent, 3000);
                        updateListCollections()
                    }
                }
            });
        }
    }

    function updateListCollections() {
        <g:remoteFunction controller="collect" action="listCollect" update="listCollections" />
    }

    $(document).ready(function () {

    });

</script>

