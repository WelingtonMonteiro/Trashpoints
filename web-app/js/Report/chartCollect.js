var dataReport;
var dataPieChart;
var months = ["Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"];
google.charts.load("current", {'packages':['corechart'], 'language': 'pt'});

$(document).ready(function () {
    $.post(window.domain + "/Report/reportByCurrentYear/", setInfoChart);
    $.post(window.domain + "/Report/quantityOfMaterialTypesCollectedByYear/", setInfoPieChart);
    $.post(window.domain + "/Report/reportTotalCollectedByCurrentYear/", setInfoReport);
});

function setInfoReport(data) {
    $('#totalOrdersCollections').text(data.ordersCollectionsByYear[0].totalOrdersCollections);
    $('#totalCollected').text(data.totalCollectionsCollectedByYear[0].totalCollectedByYear);
}

function setInfoChart(data) {
    dataReport = data;

    for(var indexMonth = 0; indexMonth < dataReport.biggerMonth; indexMonth++) {
        if(isMonthWithoutCollect(indexMonth, dataReport.biggerMonth)) {
            //Quando o mês não tem coleta, adiciona-se o mês e atribui o valor 0 para a quantidade coletada por mês
            dataReport.quantityOfCollectByMonths.splice(indexMonth, 0, {collectedDate: "", monthCollect: getNameOfMonth(indexMonth), quantityByMonth: 0});
        }
    }
    google.charts.setOnLoadCallback(drawColumnChart);
}

function setInfoPieChart(data) {
    dataPieChart = data;

    google.charts.setOnLoadCallback(drawPieChart);
}

function isMonthWithoutCollect(currentIndex, biggerMonth) {
    for(var i = 0; i < biggerMonth; i++){
        if(months[currentIndex] === dataReport.quantityOfCollectByMonths[i].monthCollect)
            return false;
    }

    return true;
}

function drawColumnChart() {
    $("#preloader_column_chart").hide();

    var data = new google.visualization.DataTable();
    data.addColumn("string", "Mês");
    data.addColumn("number", "Quantidade");

    $.each(dataReport.quantityOfCollectByMonths, function (i, obj) {
        data.addRow([obj.monthCollect, obj.quantityByMonth]);
    });

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

function drawPieChart() {
    $('#preloader_pie_chart').hide();

    var data = new google.visualization.DataTable();
    data.addColumn("string", "Tipo reciclável");
    data.addColumn("number", "Quantidade");

    $.each(dataPieChart.quantityOfMaterialTypesCollectedByYear, function (i, obj) {
        data.addRow([obj.materialTypeName, obj.quantityCollected]);
    });

    var options = {
        title: 'Quantidade de tipos de recicláveis coletados por ano',
        is3D: true,
        colors:['#fec909', '#0998d0', '#ee1c25', '#079968']
    };

    var chart = new google.visualization.PieChart(document.getElementById('pie_chart_div'));
    chart.draw(data, options);
}

function getNameOfMonth(monthIndex) {
    return months[monthIndex];
}

$(window).resize(function resizeChart(){
    drawColumnChart();
    drawPieChart();
});