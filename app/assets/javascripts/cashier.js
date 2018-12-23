// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
function CheckOut() {
    var table = $('#itemList').DataTable();
    var data = table.rows().data();
    var items = [];
    for (var i = 0; i < data.length; i++) {
        var obj = { 
            id: data[i][0],
            qty: data[i][3],
            price: data[i][4],
            disc: data[i][5],
            total: data[i][6]
        };
        items.push(obj);
    }

    var nominal = $('#label-total').html();
    var payment = $("#payment-method-select").val();
    var change = "0";
    var bank = 0;
    var edc = "";

    if (payment==1){
        nominal= $('#nominal').val();
        change = $('#change-h5').html();
    }else{
        bank = $("#bank-select").val();
        edc = $("#edc-number").val();
    }

    //var jsonObjects = [{item: items}, {member: "member", payment_method: payment, grand_total: $('#label-total').html(), nominal: nominal, change: change, bank: bank, edc: edc}];

    jQuery.ajax({
              url: "/cashier/transaction",
              type: "POST",
              data: items,
              dataType: "json",
              beforeSend: function(x) {
                if (x && x.overrideMimeType) {
                  x.overrideMimeType("application/j-son;charset=UTF-8");
                  alert(JSON.stringify(data))
                }
              },
              success: function(result) {
             //Write your code here
              }
    });
}

function setPrinter(printer) {
    var cf = getUpdatedConfig();
    cf.setPrinter(printer);

    if (typeof printer === 'object' && printer.name == undefined) {
        var shown;
        if (printer.file != undefined) {
            shown = "<em>FILE:</em> " + printer.file;
        }
        if (printer.host != undefined) {
            shown = "<em>HOST:</em> " + printer.host + ":" + printer.port;
        }

        $("#configPrinter").html(shown);
    } else {
        if (printer.name != undefined) {
            printer = printer.name;
        }

        if (printer == undefined) {
            printer = 'NONE';
        }
        $("#configPrinter").html(printer);
    }
}

function getUpdatedConfig() {
    if (cfg == null) {
        cfg = qz.configs.create(null);
    }

    updateConfig();
    return cfg
}

function updateConfig() {
    var pxlSize = null;
    if ($("#pxlSizeActive").prop('checked')) {
        pxlSize = {
            width: $("#pxlSizeWidth").val(),
            height: $("#pxlSizeHeight").val()
        };
    }

    var pxlMargins = $("#pxlMargins").val();
    if ($("#pxlMarginsActive").prop('checked')) {
        pxlMargins = {
            top: $("#pxlMarginsTop").val(),
            right: $("#pxlMarginsRight").val(),
            bottom: $("#pxlMarginsBottom").val(),
            left: $("#pxlMarginsLeft").val()
        };
    }

    var copies = 1;
    var jobName = null;
    if ($("#rawTab").hasClass("active")) {
        copies = $("#rawCopies").val();
        jobName = $("#rawJobName").val();
    } else {
        copies = $("#pxlCopies").val();
        jobName = $("#pxlJobName").val();
    }

    cfg.reconfigure({
        altPrinting: $("#rawAltPrinting").prop('checked'),
        encoding: $("#rawEncoding").val(),
        endOfDoc: $("#rawEndOfDoc").val(),
        perSpool: $("#rawPerSpool").val(),

        colorType: $("#pxlColorType").val(),
        copies: copies,
        density: $("#pxlDensity").val(),
        duplex: $("#pxlDuplex").prop('checked'),
        interpolation: $("#pxlInterpolation").val(),
        jobName: jobName,
        legacy: $("#pxlLegacy").prop('checked'),
        margins: pxlMargins,
        orientation: $("#pxlOrientation").val(),
        paperThickness: $("#pxlPaperThickness").val(),
        printerTray: $("#pxlPrinterTray").val(),
        rasterize: $("#pxlRasterize").prop('checked'),
        rotation: $("#pxlRotation").val(),
        scaleContent: $("#pxlScale").prop('checked'),
        size: pxlSize,
        units: $("input[name='pxlUnits']:checked").val()
    });
}