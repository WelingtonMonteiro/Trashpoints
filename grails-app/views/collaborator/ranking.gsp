<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Ranking</title>
</head>

<body>
<main>
    <div class="section">
        <div class="container">
            <div class="row">
                <div class="col s12">
                    <h5 class="header">Ranking</h5>

                    <table class="striped centered responsive-table">
                        <thead>
                        <tr>
                            <th data-field="position">Posição</th>
                            <th data-field="name">Nome</th>
                            <th data-field="score">Trashpoints</th>
                        </tr>
                        </thead>

                        <tbody>
                        <g:each in="${rankingTop10}" var="scorer">
                            <tr>
                                <td>
                                    <span class="bold">${scorer.position}º</span>
                                </td>
                                <td>
                                    <span>${scorer.name}</span>
                                </td>
                                <td>
                                    <span>${scorer.score}</span>
                                </td>
                            </tr>

                        </g:each>
                        </tbody>
                    </table>

                </div>
            </div>
        </div>
    </div>
</main>

<script type="text/javascript">
    function setActiveItemMenu() {
        $('li#home').removeClass('active');
        $('li#ranking').addClass('active');
    }

    $(document).ready(function () {
        setActiveItemMenu();
    })

</script>

</body>
</html>
