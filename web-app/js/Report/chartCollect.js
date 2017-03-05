var dataReport;

google.charts.load("current", {'packages':['bar'], 'language': 'pt'});

$(document).ready(function () {
    $.post(window.domain + "/Report/reportByCurrentYear/", setInfoReport);
});

function setInfoReport(data) {

    //$('#totalCollections').text(data.quantityOfCollectByMonth);
    //$('#totalCollected').text(data.quantityOfCollectByMonth);
    dataReport = data
    google.charts.setOnLoadCallback(drawChart);

}

function drawChart() {

    var data = new google.visualization.DataTable();
    data.addColumn("string", "Mês");
    data.addColumn("number", "Quantidade");

    $.each(dataReport.quantityOfCollectByMonths, function (i, obj) {
        data.addRow([obj.monthCollect, obj.quantityByMonth]);
    });

    var options = {
        chart: {
            title: 'Quantidade de coletas por mês do ano atual',
            subtitle: new Date(),
        },
        series: {
            0: { axis: 'Quantity' }, // Bind series 0 to an axis named 'distance'.
        },
        axes: {
            y: {
                Quantity: {label: 'Quantidade'}, // Left y-axis.
            }
        }
    };

    /*var options = {
        title: "Quantidade de coletas por mês do ano atual",
        width: 600,
        height: 400,
        //bar: {groupWidth: "95%"},
        legend: { position: "none" },
        vAxis: {title: "Quantidade"},
        hAxis: {title: "Mês"}
    };
*/
    var chart = new google.charts.Bar(document.getElementById("column_chart_div"));
    chart.draw(data, options);
}