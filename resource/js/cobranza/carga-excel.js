$(document).ready(function () {
    iniciarDatos();
    $("#btn_registrar").click(registrarCartera);
    $("#sltProveedor").change(cargarCarteras);
    $("#sltCartera").change(cargarSubCarteras);
    $("#btn_asignar").click(asignarCarteras);
    $("#sltSubCartera").change(function () {
        //bootbox.alert($("#sltSubCartera").find("option:selected").text());
        buscarCarga();
    });

    $("#txtValor1").keyup(function (e) {
        if (e.keyCode == 13) {
            buscarCarga();
        }
    });

    $("#txtValor2").keyup(function (e) {
        if (e.keyCode == 13) {
            buscarCarga();
        }
    });
});

function iniciarDatos() {
    cargarProveedor();
    cargarTipoMoneda();
    cargarResponsable();
    cargarCall();
    cargarCampo();
}


function registrarCartera() {
    if ($("#sltProveedor").val() == "0") {
        bootbox.alert("Seleccione Proveedor");
        $(this).val("");
        return false;
    }
    if ($("#sltCartera").val() == "0") {
        bootbox.alert("Seleccione Cartera");
        $(this).val("");
        return false;
    }
    if ($("#sltSubCartera").val() == "0") {
        bootbox.alert("Seleccione Sub Cartera");
        $(this).val("");
        return false;
    }
    if ($("#sltMoneda").val() == "0") {
        bootbox.alert("Seleccione Moneda");
        $(this).val("");
        return false;
    }

    //fancyPreload();
    $.ajax({
        url: strServicio+"cartera.asmx/registrarCartera",
        data: '{"prvCodigo":' + $("#sltProveedor").val() + ',"carCodigo":' + $("#sltCartera").val() + ',"scaCodigo":' + $("#sltSubCartera").val() +
            ',"monCodigo":' + $("#sltMoneda").val() + '}',
        dataType: 'JSON',
        type: 'POST',
        contentType: "application/json; charset=utf-8",
        success: function (jsondata) {
            //fancyPreloadClose();
            if (jsondata.d == "SUCCESS") {
                bootbox.alert("CUENTAS REGISTRADAS CORRECTAMENTE");
            } else {
                bootbox.alert(jsondata.d.split('|').pop());
            }
            //console.log(jsondata.d);
        }
    });
}

$("#flArchivo").change(function (e) {
    if ($("#sltProveedor").val() == "0") {
        bootbox.alert("Seleccione Proveedor");
        $(this).val("");
        return false;
    }
    if ($("#sltCartera").val() == "0") {
        bootbox.alert("Seleccione Cartera");
        $(this).val("");
        return false;
    }

    var fileName = e.target.files[0];
    //console.log(fileName.size);
    //console.log(fileName.name);
    //console.log(fileName.name.split('.').pop());
    //console.log(fileName.type);
    if (fileName.name.split('.').pop().toLowerCase() != "txt" &&
        fileName.name.split('.').pop().toLowerCase() != "csv") {
        bootbox.alert("USTED NO SELECCIONO EL FORMATO INDICADO");
        $(this).val("");
        return false;
    }

    //fancyPreload();
    var formData = new FormData();
    var files = $("#flArchivo").get(0).files;
    formData.append("Proveedor", $("#sltProveedor").val());
    formData.append("Cartera", $("#sltCartera").val());
    formData.append("UploadFile", files[0]);
    $.ajax({
        url: "../resource/carga/carga_texto.ashx",
        type: 'POST',
        beforeSend: function () {
            $("#txtProgreso").html("CARGANDO..");
        },
        uploadProgress: function (event, position, total, percentComplete) {
            $("#txtProgreso").html(percentComplete + '%');
        },
        success: function () {
            $("#txtProgreso").html('100%');
        },
        complete: function (response) {
            //fancyPreloadClose();
            console.log(response.responseText);
            if (response.responseText.split("|")[0] == "ERROR") {
                $("#divTblLista").hide();
                bootbox.alert("Ocurrio un error, por favor vuelva a intentar cargar el documento.", "MENSAJE DE CARGA DE DOCUMENTOS");
                var listaError = response.responseText.split(",");
                var htmlText = "";
                $("#lstError tbody").empty();
                $.each(listaError, function (i, obj) {
                    console.log(obj);
                    htmlText = "<tr>" +
                        "<td>" + (i + 1) + "</td>" +
                        "<td>" + (obj) + "</td>" +
                        "</tr>";
                    $("#lstError tbody").append(htmlText);
                });
                $("#divError").show();
            } else if (response.responseText == "CORRECTO") {
                $("#divTblLista").show();
                $("#divError").hide();
                buscarCarga();
                buscarReporte();
                bootbox.alert("Carga realizada correctamente");
            }
        },
        error: function () {
            console.log("<font color='red'> ERROR: unable to upload files</font>");
            bootbox.alert("Ocurrio un error, por favor vuelva a intentar cargar el documento.", "MENSAJE DE CARGA DE DOCUMENTOS");
        },
        data: formData,
        cache: false,
        contentType: false,
        processData: false
    });
    //$.ajax({
    //    url: "../../resource/service/cartera.asmx/subirArchivo",  //Server script to process data
    //    type: 'POST',
    //    dataType: 'XML',
    //    contentType: "application/json; charset=utf-8",
    ////    xhr: function () {  // Custom XMLHttpRequest
    ////        //var myXhr = $.ajaxSettings.xhr();
    ////        //if (myXhr.upload) { // Check if upload property exists
    ////        //    myXhr.upload.addEventListener('progress', progressHandlingFunction, false); // For handling the progress of the upload
    ////        //}
    ////        //return myXhr;
    ////    },
    //    //Ajax events
    //    beforeSend: function () {
    //        console.log("ENVIANDO ARCHIVO");
    //    },
    //    success: function (xmldata) {
    //        var xml = $(xmldata);
    //        var datos = xml.find("string").text();
    //        console.log(datos);
    //        if (datos == "SUCCESS") {
    //            buscarCarga();
    //            $("#txtMensaje").html("MENSAJE: CARGA REALIZADA CORRECTAMENTE");
    //        } else {
    //            $("#txtMensaje").html(datos.split("|").pop());
    //        }
    //        //fancyPreloadClose();
    //    },
    //    //error: errorHandler,
    //    data: formData,
    //    cache: false,
    //    contentType: false,
    //    processData: false
    //});
});

function asignarCarteras() {
    //bootbox.alert('{"prvCodigo":' + $("#sltProveedor").val() + ',"carCodigo":' + $("#sltCartera").val() + ',"scaCodigo":' + $("#sltSubCartera").val() +
    //        ',"subCartera":"' + $("#sltSubCartera").find("option:selected").text() + '","criterio":' + $("#sltCriterio").val() + ',"filtro":' + $("#sltFiltro").val() +
    //        ',"valor1":"' + ($("#txtValor1").val() == "" ? "0" : $("#txtValor1").val()) + '","valor2":"' + ($("#txtValor2").val() == "" ? "0" : $("#txtValor2").val()) +
    //        '","responsable":' + $("#sltResponsable").val() + ',"call":' + $("#sltCall").val() + ',"campo":' + $("#sltCampo").val() + '}');
    $.ajax({
        url: strServicio+"cartera.asmx/asignarCarteras",
        data: '{"prvCodigo":' + $("#sltProveedor").val() + ',"carCodigo":' + $("#sltCartera").val() + ',"scaCodigo":' + $("#sltSubCartera").val() +
            ',"subCartera":"' + $("#sltSubCartera").find("option:selected").text() + '","criterio":' + $("#sltCriterio").val() + ',"filtro":' + $("#sltFiltro").val() +
            ',"valor1":"' + ($("#txtValor1").val() == "" ? "0" : $("#txtValor1").val()) + '","valor2":"' + ($("#txtValor2").val() == "" ? "0" : $("#txtValor2").val()) +
            '","responsable":' + $("#sltResponsable").val() + ',"call":' + $("#sltCall").val() + ',"campo":' + $("#sltCampo").val() + '}',
        dataType: 'JSON',
        type: 'POST',
        contentType: "application/json; charset=utf-8",
        success: function (jsondata) {
            console.log(jsondata.d);
            if (jsondata.d == "SUCCESS") {
                buscarCarga();
            }
        }
    });
}

function buscarReporte() {
    $.ajax({
        url: strServicio+"cartera.asmx/obtenerDetalleCarga",
        //data: '{"prvCodigo":' + $("#sltProveedor").val() + ',"carCodigo":' + $("#sltCartera").val() + ',"scaCodigo":' + $("#sltSubCartera").val() +
        //    ',"subCartera":"' + $("#sltSubCartera").find("option:selected").text() + '"}',
        data: '{"prvCodigo":' + $("#sltProveedor").val() + ',"carCodigo":' + $("#sltCartera").val() + ',"scaCodigo":' + $("#sltSubCartera").val() +'}',
        dataType: 'JSON',
        type: 'POST',
        contentType: "application/json; charset=utf-8",
        success: function (jsondata) {
            console.log(jsondata.d);
            $("#tblReporte tbody").empty();
            var htmlText = "<tr>"
            //+ "<td></td>"
            + "<td>" + jsondata.d.NUEVOS + "</td>"
            + "<td>" + jsondata.d.ACTUALIZADOS + "</td>"
            + "<td>" + jsondata.d.RETIRADOS + "</td>"
            + "<td>" + (jsondata.d.NUEVOS + jsondata.d.ACTUALIZADOS + jsondata.d.RETIRADOS) + "</td>"
            //+ "<td></td>"
            + "</tr>";
            $("#tblReporte tbody").append(htmlText);
        }
    });
}

function buscarCarga() {
    $.ajax({
        url: strServicio+"cartera.asmx/listarCartera",
        data: '{"prvCodigo":' + $("#sltProveedor").val() + ',"carCodigo":' + $("#sltCartera").val() + ',"scaCodigo":' + $("#sltSubCartera").val() +
            ',"subCartera":"' + $("#sltSubCartera").find("option:selected").text() + '"}',
        dataType: 'JSON',
        type: 'POST',
        contentType: "application/json; charset=utf-8",
        success: function (jsondata) {
            console.log(jsondata.d);
            $("#tblLista tbody").empty();
            var htmlText = "";
            $.each(jsondata.d, function (i, obj) {
                htmlText = "<tr"+(i%2==0?" class='row_listabandejavirtual'":"")+">"+
                    "<td></td>" +
                    //"<td><span>" + obj.GESTOR + "</span></td>" +
                    //"<td><span>" + obj.CALL + "</span></td>" +
                    //"<td><span>" + obj.CAMPO + "</span></td>" +
                    "<td><span>" + obj.SCA_DESCRIPCION + "</span></td>" +
                    "<td><span>" + obj.CUE_NROCUENTA + "</span></td>" +
                    "<td><span>" + obj.CUE_NROTARJETA + "</span></td>" +
                    "<td><span>" + obj.CLI_DOCUMENTO_IDENTIDAD + "</span></td>" +
                    "<td><span>" + obj.CLI_NOMBRE_COMPLETO + "</span></td>" +
                    "<td><span>" + obj.CAPITAL + "</span></td>" +
                    "<td><span>" + obj.SALDO + "</span></td>" +
                    "<td><span>" + obj.CAMPANA + "</span></td>" +
                    "<td></td>"+
                "</tr>";
                $("#tblLista tbody").append(htmlText);
            });
        }
    });
}

function cargarProveedor() {
    $.ajax({
        url: strServicio+"general.asmx/cargarProveedor",
        dataType: 'JSON',
        type: 'POST',
        contentType: "application/json; charset=utf-8",
        success: function (jsondata) {
            //$("#sltProveedor").empty();
            $.each(jsondata.d, function (i, obj) {
                $("#sltProveedor").append("<option value='" + obj.value + "'>" + obj.key + "</option>");
            });
            //console.log(jsondata.d);
        }
    });
}

function cargarTipoMoneda() {
    $.ajax({
        url: strServicio+"general.asmx/cargarTipoMoneda",
        dataType: 'JSON',
        type: 'POST',
        contentType: "application/json; charset=utf-8",
        success: function (jsondata) {
            //$("#sltProveedor").empty();
            $.each(jsondata.d, function (i, obj) {
                $("#sltMoneda").append("<option value='" + obj.value + "'>" + obj.key + "</option>");
            });
            //console.log(jsondata.d);
        }
    });
}

function cargarResponsable() {
    $.ajax({
        url: strServicio+"general.asmx/cargarGestor",
        dataType: 'JSON',
        type: 'POST',
        contentType: "application/json; charset=utf-8",
        success: function (jsondata) {
            //$("#sltProveedor").empty();
            $.each(jsondata.d, function (i, obj) {
                $("#sltResponsable").append("<option value='" + obj.value + "'>" + obj.key + "</option>");
            });
            //console.log(jsondata.d);
        }
    });
}

function cargarCall() {
    $.ajax({
        url: strServicio+"general.asmx/cargarCall",
        dataType: 'JSON',
        type: 'POST',
        contentType: "application/json; charset=utf-8",
        success: function (jsondata) {
            //$("#sltProveedor").empty();
            $.each(jsondata.d, function (i, obj) {
                $("#sltCall").append("<option value='" + obj.value + "'>" + obj.key + "</option>");
            });
            //console.log(jsondata.d);
        }
    });
}

function cargarCampo() {
    $.ajax({
        url: strServicio+"general.asmx/cargarCampo",
        dataType: 'JSON',
        type: 'POST',
        contentType: "application/json; charset=utf-8",
        success: function (jsondata) {
            //$("#sltProveedor").empty();
            $.each(jsondata.d, function (i, obj) {
                $("#sltCampo").append("<option value='" + obj.value + "'>" + obj.key + "</option>");
            });
            //console.log(jsondata.d);
        }
    });
}

function cargarCarteras() {
    $.ajax({
        url: strServicio+"general.asmx/cargarCarteras",
        data: '{"PRV_CODIGO":"' + $("#sltProveedor").val() + '"}',
        dataType: 'JSON',
        type: 'POST',
        contentType: "application/json; charset=utf-8",
        success: function (jsondata) {
            $("#sltCartera").empty();
            $("#sltCartera").append("<option value='0'>-SELECCIONA-</option>");
            $.each(jsondata.d, function (i, obj) {
                $("#sltCartera").append("<option value='" + obj.value + "'>" + obj.key + "</option>");
            });
            //console.log(jsondata.d);
        }
    });
}

function cargarSubCarteras() {
    $.ajax({
        url: strServicio+"general.asmx/cargarSubCarteras",
        data: '{"CAR_CODIGO":"' + $("#sltCartera").val() + '"}',
        dataType: 'JSON',
        type: 'POST',
        contentType: "application/json; charset=utf-8",
        success: function (jsondata) {
            $("#sltSubCartera").empty();
            $("#sltSubCartera").append("<option value='0'>-SELECCIONA-</option>");
            $.each(jsondata.d, function (i, obj) {
                $("#sltSubCartera").append("<option value='" + obj.value + "'>" + obj.key + "</option>");
            });
            //console.log(jsondata.d);
            buscarCarga();
            if ($("#sltProveedor").val() == "14" && $("#sltCartera").val() == "8") {
                buscarReporte();
            }
        }
    });
}