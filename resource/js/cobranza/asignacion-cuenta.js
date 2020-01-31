$(document).ready(function () {
    iniciarDatos();
    $("#sltProveedor").change(cargarCarteras);
    $("#sltCartera").change(cargarSubCarteras);
    $("#sltSubCartera").change(obtenerDatosCantidades);
    $("#sltResponsable").change(obtenerDatosCantidades);
    $("#sltTipoRespuesta").change(obtenerDatosCantidades);
    $("#sltTelefono").change(obtenerCatidadCall);
    $("#sltDistrito").change(obtenerCatidadCampo);
    $("#btnAceptar").click(fnc_Aceptar);

    $("#sltResponsableCall").change(validarCambioResponsable);
    $("#sltTelefono").change(validarCambioTelefono);
    $("#sltDistrito").change(validarCambioDistrito);
});
function iniciarDatos() {
    cargarUsuariosCall();
    cargarUsuariosCampo();
    cargarProveedor();
    cargarResponsable();
    cargarTipoRespuesta();
}

function validarCambioResponsable() {
    if ($("#sltProveedor").val() == "0") {
        bootbox.alert("Usted no selecciono Proveedor");
        $(this).val("0");
        return false;
    }
    if ($("#sltCartera").val() == "0") {
        bootbox.alert("Usted no selecciono Cartera");
        $(this).val("0");
        return false;
    }
    if ($("#sltSubCartera").val() == "0") {
        bootbox.alert("Usted no selecciono Sub Cartera");
        $(this).val("0");
        return false;
    }
    if ($("#txtCantCuentas").text() == "0") {
        bootbox.alert("La cartera seleccionada no tiene cuentas asignadas, o no se cargo el archivo");
        $(this).val("0");
        return false;
    }
}

function validarCambioTelefono() {
    if ($("#sltResponsableCall").val() == "0") {
        bootbox.alert("Usted no selecciono Responsable");
        $(this).val("0");
        return false;
    }
}

function validarCambioDistrito() {
    if ($("#sltResponsableCall").val() == "0") {
        bootbox.alert("Usted no selecciono Responsable");
        $(this).val("0");
        return false;
    }
} 

function fnc_Aceptar() {
    var lstTempUsuario = new Array();
    var objTempUsuario = null;
    $(".chkCall").each(function () {
        if ($(this).is(":checked")) {
            var codigo = $(this).attr("id").replace("chk_", "");
            objTempUsuario = new Object();
            objTempUsuario.TIPO = "C";
            objTempUsuario.USU_CODIGO = codigo;
            objTempUsuario.CANTIDAD = $("#txt_" + codigo).val();
            lstTempUsuario.push(objTempUsuario);
        }
    });
    $(".chkCampo").each(function () {
        if ($(this).is(":checked")) {
            var codigo = $(this).attr("id").replace("chkc_", "");
            objTempUsuario = new Object();
            objTempUsuario.TIPO = "P";
            objTempUsuario.USU_CODIGO = codigo;
            objTempUsuario.CANTIDAD = $("#txtc_" + codigo).val();
            lstTempUsuario.push(objTempUsuario);
        }
    });
    console.log(lstTempUsuario);
    $.ajax({
        url: strServicio+"cartera.asmx/asignar_cuentas",
        data: '{"prvCodigo":' + $("#sltProveedor").val() + ',"carCodigo":' + $("#sltCartera").val() +
            ',"scaCodigo":' + $("#sltSubCartera").val() + ',"resCodigo":' + $("#sltResponsable").val() +
            ',"treCodigo":' + $("#sltTipoRespuesta").val().split(';')[0] +
            ',"resposableCall":"' + $("#sltResponsableCall").val() + '","call":"' + $("#sltTelefono").val() + '","campo":"' + $("#sltDistrito").val() +
            '","lstTempUsuario":' + JSON.stringify(lstTempUsuario) + '}',
        dataType: 'JSON',
        type: 'POST',
        contentType: "application/json; charset=utf-8",
        success: function (jsondata) {
            console.log(jsondata.d);
            if (jsondata.d == 'SUCCESS') {
                bootbox.alert("ASIGNACIÓN REALIZADA CORRECTAMENTE");
                window.location = 'bandeja-principal.aspx';
            }
        }
    });
}

function calcularCall() {
    //bootbox.alert($("#sltTelefono").val());
    if ($("#sltTelefono").val() == "00") {
        bootbox.alert("Usted no selecciono Telefono");
        return false;
    }
    if ($("#txtCantCall").text() == "" || $("#txtCantCall").text() == "0") {
        bootbox.alert("No cuenta con cuentas para asignar");
        return false;
    }

    var cantCuentas = parseInt($("#txtCantCall").html());
    var contador = 0;
    $(".chkCall").each(function () {
        var codigo = $(this).attr("id").replace("chk_", "");
        $("#txt_" + codigo).val("0");
    });
    //console.log(cantCuentas);
    if (cantCuentas > 0) {
        while (contador < cantCuentas) {
            //console.log(contador);
            $(".chkCall").each(function () {
                if (contador == cantCuentas) return false;
                //console.log(contador + " >> " + cantCuentas);
                if ($(this).is(":checked")) {
                    var codigo = $(this).attr("id").replace("chk_", "");
                    $("#txt_" + codigo).val(parseInt($("#txt_" + codigo).val()) + 1);
                    contador++;

                }
                //console.log($(this).is(":checked"));
            });
        }
    }
}

function calcularCampo() {

    if ($("#sltDistrito").val() == "00") {
        bootbox.alert("Usted no selecciono Distrito");
        return false;
    }
    if ($("#txtCantCampo").text() == "" || $("#txtCantCampo").text() == "0") {
        bootbox.alert("No cuenta con cuentas para asignar");
        return false;
    }

    var cantCuentas = parseInt($("#txtCantCampo").html());
    var contador = 0;
    $(".chkCampo").each(function () {
        var codigo = $(this).attr("id").replace("chkc_", "");
        $("#txtc_" + codigo).val("0");
    });
    //console.log(cantCuentas);
    if (cantCuentas > 0) {
        while (contador < cantCuentas) {
            //console.log(contador);
            $(".chkCampo").each(function () {
                if (contador == cantCuentas) return false;
                //console.log(contador + " >> " + cantCuentas);
                if ($(this).is(":checked")) {
                    var codigo = $(this).attr("id").replace("chkc_", "");
                    $("#txtc_" + codigo).val(parseInt($("#txtc_" + codigo).val()) + 1);
                    contador++;
                }
                //console.log($(this).is(":checked"));
            });
        }
    }
}

function obtenerCatidadCall() {
    $.ajax({
        url: strServicio+"cartera.asmx/obtenerCantidadAsignacionCall",
        data: '{"prvCodigo":' + $("#sltProveedor").val() + ',"carCodigo":' + $("#sltCartera").val() + ',"scaCodigo":' + $("#sltSubCartera").val() + ',"resCodigo":' + $("#sltResponsable").val() + ',"treCodigo":' + $("#sltTipoRespuesta").val().split(';')[0] + ',"call":"' + $("#sltTelefono").val() + '"}',
        dataType: 'JSON',
        type: 'POST',
        contentType: "application/json; charset=utf-8",
        success: function (jsondata) {
            console.log(jsondata.d);
            $("#txtCantCall").text(jsondata.d);
        }
    });
}

function obtenerCatidadCampo() {
    $.ajax({
        url: strServicio+"cartera.asmx/obtenerCantidadAsignacionCampo",
        data: '{"prvCodigo":' + $("#sltProveedor").val() + ',"carCodigo":' + $("#sltCartera").val() + ',"scaCodigo":' + $("#sltSubCartera").val() + ',"resCodigo":' + $("#sltResponsable").val() + ',"treCodigo":' + $("#sltTipoRespuesta").val().split(';')[0] + ',"campo":"' + $("#sltDistrito").val() + '"}',
        dataType: 'JSON',
        type: 'POST',
        contentType: "application/json; charset=utf-8",
        success: function (jsondata) {
            console.log(jsondata.d);
            $("#txtCantCampo").text(jsondata.d);
        }
    });
}

function obtenerDatosCantidades() {
    $.ajax({
        url: strServicio+"cartera.asmx/obtenerCantidadAsignacion",
        data: '{"prvCodigo":' + $("#sltProveedor").val() + ',"carCodigo":' + $("#sltCartera").val() + ',"scaCodigo":' + $("#sltSubCartera").val() + ',"resCodigo":' + $("#sltResponsable").val() + ',"treCodigo":' + $("#sltTipoRespuesta").val().split(';')[0] + '}',
        dataType: 'JSON',
        type: 'POST',
        contentType: "application/json; charset=utf-8",
        success: function (jsondata) {
            console.log(jsondata.d);
            $("#txtCantCuentas").html(jsondata.d.CANT_CUENTAS);
            $("#txtCapitalTotal").html(jsondata.d.CAPITAL);
            $("#txtProtestoTotal").html(jsondata.d.PROTESTO);
            $("#txtSaldoTotal").html(jsondata.d.SALDO);
            $("#sltTelefono").val("00");
            $("#txtCantCall").text("0");
            $("#sltDistrito").val("00");
            $("#txtCantCampo").text("0");
        }
    });
}

function cargarTipoRespuesta() {
    $.ajax({
        url: strServicio+"general.asmx/listaTipoRespuesta",
        dataType: 'JSON',
        type: 'POST',
        contentType: "application/json; charset=utf-8",
        success: function (jsondata) {
            //$("#sltProveedor").empty();
            $.each(jsondata.d, function (i, obj) {
                $("#sltTipoRespuesta").append("<option value='" + obj.value + "'>" + obj.key + "</option>");
            });
            //console.log(jsondata.d);
        }
    });
}

function cargarTipoRespuesta() {
    $.ajax({
        url: strServicio+"general.asmx/listaAsignacionDistrito",
        dataType: 'JSON',
        type: 'POST',
        contentType: "application/json; charset=utf-8",
        success: function (jsondata) {
            //$("#sltProveedor").empty();
            $.each(jsondata.d, function (i, obj) {
                $("#sltDistrito").append("<option value='" + obj.value + "'>" + obj.key + "</option>");
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
                $("#sltResponsableCall").append("<option value='" + obj.value + "'>" + obj.key + "</option>");
                //$("#sltResponsableCampo").append("<option value='" + obj.value + "'>" + obj.key + "</option>");
            });
            //console.log(jsondata.d);
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
            //buscarCarga();
        }
    });
}

function cargarUsuariosCall() {
    $.ajax({
        url: strServicio+"cartera.asmx/listarCuentasCall",
        dataType: 'JSON',
        type: 'POST',
        contentType: "application/json; charset=utf-8",
        success: function (jsondata) {
            console.log(jsondata.d);
            var htmlText = "";
            $("#tblListaCall tbody").empty();
            $.each(jsondata.d, function (i,obj) {
                htmlText = "<tr>" +
                    "<td>" + obj.USU_ROL + "</td>" +
                    "<td>" + obj.USU_LOGIN + "</td>" +
                    "<td>" + obj.CANT_CUENTAS + "</td>" +
                    "<td>" + (obj.CANT_CUENTAS > 0 ? "<input type='button' onclick='fncLiberar(\"C\"," + obj.USU_CODIGO + ")' value='Liberar'/>" : "") + "</td>" +
                    "<td><input type='text' id='txt_" + obj.USU_CODIGO + "' value='0' style='width: 70px;'/>" + "</td>" +
                    "<td><input type='checkbox' class='chkCall' id='chk_" + obj.USU_CODIGO + "' onchange='calcularCall()' style='opacity: 100;' " + (obj.CANT_CUENTAS > 0 ? "disabled='disabled'" : "") + "/> " + "</td>" +
                    "</tr>";
                $("#tblListaCall tbody").append(htmlText);
            });
        }
    });
}

function cargarUsuariosCampo() {
    $.ajax({
        url: strServicio+"cartera.asmx/listarCuentasCampo",
        dataType: 'JSON',
        type: 'POST',
        contentType: "application/json; charset=utf-8",
        success: function (jsondata) {
            console.log(jsondata.d);
            var htmlText = "";
            $("#tblListaCampo tbody").empty();
            $.each(jsondata.d, function (i, obj) {
                htmlText = "<tr>" +
                    "<td>" + obj.USU_ROL + "</td>" +
                    "<td>" + obj.USU_LOGIN + "</td>" +
                    "<td>" + obj.CANT_CUENTAS + "</td>" +
                    "<td>" + (obj.CANT_CUENTAS > 0 ? "<input type='button' onclick='fncLiberar(\"P\"," + obj.USU_CODIGO + ")' value='Liberar'/>" : "") + "</td>" +
                    "<td><input type='text' id='txtc_" + obj.USU_CODIGO + "' value='0' style='width: 70px;'/>" + "</td>" +
                    "<td><input type='checkbox' class='chkCampo' id='chkc_" + obj.USU_CODIGO + "' onchange='calcularCampo()' style='opacity: 100;' " + (obj.CANT_CUENTAS > 0 ? "disabled='disabled'" : "") + "/>" + "</td>" +
                    "</tr>";
                $("#tblListaCampo tbody").append(htmlText);
            });
        }
    });
}

function fncLiberar(tipo,codigo) {
    $.ajax({
        url: strServicio+"cartera.asmx/liberarUsuario",
        data: '{"tipo":"' + tipo + '","codigo":' + codigo + '}',
        dataType: 'JSON',
        type: 'POST',
        contentType: "application/json; charset=utf-8",
        success: function (jsondata) {
            console.log(jsondata);
            if (jsondata.d == "SUCCESS") {
                if (tipo = "C") {
                    console.log("CARGAR CALL");
                    cargarUsuariosCall();
                } else {
                    console.log("CARGAR CAMPO");
                    cargarUsuariosCampo();
                }
            }
        }
    });
    //bootbox.alert(codigo);
}