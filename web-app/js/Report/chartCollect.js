var dataReport;
var months = ["Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"];
google.charts.load("current", {'packages':['corechart'], 'language': 'pt'});

$(document).ready(function () {
    $.post(window.domain + "/Report/reportByCurrentYear/", setInfoChart);
    $.post(window.domain + "/Report/reportTotalCollectedByCurrentYear/", setInfoReport);
});

function setInfoReport(data) {
    //$('#totalCollections').text(data.quantityOfCollectByMonths.length);
    $('#totalCollected').text(data.listInfoCollectedByYear[0].totalCollectedByYear);
}

function setInfoChart(data) {
    dataReport = data;

    for(var i = 0; i < dataReport.biggerMonth; i++) {
        if(isMonthWithoutCollect(i, dataReport.biggerMonth)) {
            dataReport.quantityOfCollectByMonths.splice(i, 0, {collectedDate: "", monthCollect: getNameOfMonth(i), quantityByMonth: 0});
        }
    }
    google.charts.setOnLoadCallback(drawChart);
}

function drawChart() {
    $(".preloader-wrapper").hide();

    var data = new google.visualization.DataTable();
    data.addColumn("string", "Mês");
    data.addColumn("number", "Quantidade");

    $.each(dataReport.quantityOfCollectByMonths, function (i, obj) {
        data.addRow([obj.monthCollect, obj.quantityByMonth]);
    });

    /*var options = {
        chart: {
            title: 'Quantidade de coletas por mês do ano atual',
            subtitle: new Date().toLocaleTimeString("pt-BR", { day: '2-digit', month: 'long', year: 'numeric' })
        },
        series: {
            0: { axis: 'Quantity' }, // Bind series 0 to an axis named 'Quantity'.
        },
        axes: {
            y: {
                Quantity: {label: 'Quantidade'}, // Left y-axis.
            }
        }
    };*/

    var options = {
        title: "Quantidade de coletas por mês do ano atual",
        width: '100%',
        height: '100%',
        //bar: {groupWidth: "95%"},
        legend: { position: "none" },
        hAxis: {
            title: 'Mês',
        },
        vAxis: {
            title: 'Quantidade'
        }
    };

    var chart = new google.visualization.ColumnChart(document.getElementById("column_chart_div"));
    chart.draw(data, options);
}

function isMonthWithoutCollect(currentIndex, biggerMonth) {
    for(var j = 0; j < biggerMonth; j++){
        if(months[currentIndex] === dataReport.quantityOfCollectByMonths[j].monthCollect)
            return false;
    }

    return true;
}

function getNameOfMonth(monthIndex) {
    return months[monthIndex];
}

$(window).resize(function(){
  drawChart();
});