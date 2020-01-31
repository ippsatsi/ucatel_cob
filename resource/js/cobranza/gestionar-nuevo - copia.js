$(document).ready(function () {
    listarTipoGestion();
    listarTelefonos();
    listarDirecciones();

    $("#sltTipoGestion").change(function () {
        comboPorTipoGestion($(this).val());
    });

    $("#sltRespuesta").change(function () {
        //alert($(this).val().split("-")[0]);
        comboPorTipoRespuesta($(this).val().split("-")[0]);
        activarCampos($(this).val());
        $("#txtObservacion").val($("#sltRespuesta option:selected").text());
    });

    $('.datehourpicker').timepicker({
        autoclose: true,
        showSeconds: true,
        minuteStep: 1
    });

    $("#txtFechaRecordatorio").val(obtenerFechaActual);

    function obtenerFechaActual() {
        var today = new Date();
        var dd = today.getDate();
        var mm = today.getMonth() + 1; //January is 0!

        var yyyy = today.getFullYear();
        if (dd < 10) {
            dd = '0' + dd
        }
        if (mm < 10) {
            mm = '0' + mm
        }
        var today = dd + '/' + mm + '/' + yyyy;
        return today;
    }

    $('.datetimepicker').datepicker({
        format: 'dd/mm/yyyy'
    });

    //$('.datehourpicker').datepicker({
    //    format: 'LT'
    //});

    $('.datehourpicker').timepicker({
        autoclose: true,
        showSeconds: true,
        minuteStep: 1
    });
    
    $("#btnRegistrarGestion").click(registrarGestion);

    $("#chkRecordatorio").change(habilitarRecordatorio);

    cargarDatosIniciales();

    $("#chkBusquedaEspecializada").change(function () {
        if ($("#chkBusquedaEspecializada").is(":checked")) {
            bootbox.confirm("¿Esta seguro de enviar a este cliente a una busqueda especializada?", function (r) {
                if (r) {
                        var objBusqueda = new Object();
                        objBusqueda.CLI_CODIGO = $("#contenido_txtCodigoCliente").val();
                        objBusqueda.SCA_CODIGO = $("#contenido_txtCodigoSubCartera").val();
                        objBusqueda.CUE_CODIGO = $("#contenido_txtCodigoCuenta").val();
                        $.ajax({
                            url: strServicio + "gestion.asmx/registrarBusqueda",
                            data: '{"objBusqueda": ' + JSON.stringify(objBusqueda) + '}',
                            dataType: 'JSON',
                            type: 'POST',
                            contentType: "application/json; charset=utf-8",
                            async: false,
                            success: function (jsondata) {
                                if (jsondata.d == "CORRECTO") {
                                    bootbox.alert("Busqueda registrada correctamente");
                                }
                            }
                        });
                        $("#divBusquedaEspecializada").html("INFORME: BUSQUEDA ESPECIALIZADA REGISTRADA");
                } else {
                    $("#chkBusquedaEspecializada").removeAttr("checked");
                }
            });
        }
    });
});

function cargarDatosIniciales() {
    if ($("#contenido_txtCodigoTelefono").val() != "0") {
        $("#sltTipoGestion").val("5");
        $("#sltTipoGestion").change();
        $("#divTelefono").show();
        $("#divDireccion").hide();
        $("#sltTelefono").val($("#contenido_txtCodigoTelefono").val());
    }
    if ($("#contenido_txtCodigoDireccion").val() != "0") {
        $("#sltTipoGestion").val("7");
        $("#sltTipoGestion").change();
        $("#divTelefono").hide();
        $("#divDireccion").show();
        $("#sltDireccion").val($("#contenido_txtCodigoDireccion").val());
    }
}

function habilitarRecordatorio() {
    if ($(this).is(":checked")) {
        $("#divRecordatorio").show();
    } else {
        $("#divRecordatorio").hide();
    }
}

function listarTipoGestion() {
    $.ajax({
        url: strServicio+"general.asmx/listaTipoGestion",
        data: '{"codigo":"' + $("#contenido_txtCodigoRol").val() + '"}',
        dataType: 'JSON',
        type: 'POST',
        contentType: "application/json; charset=utf-8",
        async: false,
        success: function (jsondata) {
            console.log(jsondata.d);
            $.each(jsondata.d, function (i, obj) {
                $("#sltTipoGestion").append("<option value='" + obj.value + "'>" + obj.key + "</option>");
            });
        }
    });
}

function comboPorTipoGestion(tipoGestion) {
    var rol = $("#contenido_txtCodigoRol").val();
    if (tipoGestion == 5 || tipoGestion == 6) {
        $("#divTelefono").show();
        $("#divDireccion").hide();
    } else if (tipoGestion == 7 || tipoGestion == 8) {
        $("#divTelefono").hide();
        $("#divDireccion").show();
    } else {
        $("#divTelefono").hide();
        $("#divDireccion").hide();
    }

    $("#sltRespuesta").empty();
    $.ajax({
        url: strServicio+"general.asmx/listarRespuestaPorTipoGestion",
        data: "{'sca_codigo':'" + $("#contenido_txtCodigoSubCartera").val() + "','codigo':'" + tipoGestion + "'}",
        dataType: 'JSON',
        type: 'POST',
        contentType: "application/json; charset=utf-8",
        async: true,
        success: function (jsondata) {
            console.log(jsondata.d);
            $("#sltRespuesta").append("<option value=''>-SELECCIONE-</option>");
            $.each(jsondata.d, function (i, obj) {
                //$("#sltRespuesta").append("<option value='" + obj.value + "'>" + obj.key + "</option>");
                if (obj.value.split("-")[0] == 160) {
                    if (rol == 1 || rol == 2 || rol == 3) {
                        $("#sltRespuesta").append("<option value='" + obj.value + "'>" + obj.key + "</option>");
                    }
                } else {
                    $("#sltRespuesta").append("<option value='" + obj.value + "'>" + obj.key + "</option>");
                }
            });
        }
    });
}

function comboPorTipoRespuesta(tipoRespuesta) {
    $("#sltSolucion").empty();
    $.ajax({
        url: strServicio+"general.asmx/listarSolucionPorTipoRespuesta",
        data: "{'codigo':'" + tipoRespuesta + "'}",
        dataType: 'JSON',
        type: 'POST',
        contentType: "application/json; charset=utf-8",
        async: true,
        success: function (jsondata) {
            //alert(jsondata.d.length);
            if (jsondata.d.length > 0) {
                $("#divSolucion").show();
                $("#sltSolucion").append("<option value=''>-SELECCIONE-</option>");
                $.each(jsondata.d, function (i, obj) {
                    $("#sltSolucion").append("<option value='" + obj.value + "'>" + obj.key + "</option>");
                });
            } else {
                $("#divSolucion").hide();
            }
        }
    });
}

$("#sltSolucion").change(function () {
    activarCampos($(this).val());
    $("#txtObservacion").val($("#sltRespuesta option:selected").text() + " / " + $("#sltSolucion option:selected").text());
});

function activarCampos(campo) {
    var datos = campo.split('-');
    var importe_negociado = datos[1];
    var fecha = datos[2];
    var monto = datos[3];
    var reprogramacion = datos[4];
    var recibo = datos[5];
    var cuotas = datos[6];
    var inicial = datos[7];
    var saldo = datos[8];
    var rango_cuotas = datos[9];

    if (importe_negociado == 1) {
        $("#divMontoNegociado").show();
    } else {
        $("#divMontoNegociado").hide();
    }
    if (fecha == 1) {
        $("#divFecha").show();
    } else {
        $("#divFecha").hide();
    }
    if (monto == 1) {
        $("#divMonto").show();
    } else {
        $("#divMonto").hide();
    }
    if (reprogramacion == 1) {
        $("#divRegistrarTarea").show();
    } else {
        $("#divRegistrarTarea").hide();
    }
    if (recibo == 1) {
        $(".divRecibo").show();
    } else {
        $(".divRecibo").hide();
    }
    if (cuotas == 1) {
        $(".divRespuestaCuotas").show();
    } else {
        $(".divRespuestaCuotas").hide();
    }
    if (saldo == 1) {
        $("#divSaldo").show();
    } else {
        $("#divSaldo").hide();
    }
    $("#txtMontoNegociacion").val('');
    $("#txtSaldoNegociacion").val('');
    $("#txtReciboMonto").val('');
    $("#txtReciboFecha").val('');
    $("#txtReciboNumero").val('');
    $("#txtReciboAgencia").val('');
    $("#txtMontoInicial").val('');
    $("#txtFechaInicial").val('');
    $("#txtNroCuotas").val('');
    $("#txtValorCuota").val('');
    $("#tblCuotas tbody").empty();
}


function listarTelefonos() {
    var rol = $("#contenido_txtCodigoRol").val();
    $.ajax({
        url: strServicio+"general.asmx/listarTelefonos",
  //      data: '{"dni":"' + $("#contenido_txtDni").val() + '"}',
        data: '{"dni":"' + '|' + $("#contenido_txtCodigoCuenta").val() + '"}',//se usa nrode cuenta en vez de dni
        dataType: 'JSON',
        type: 'POST',
        contentType: "application/json; charset=utf-8",
        async: false,
        success: function (jsondata) {
            $("#sltTelefono").html("<option value='0'>-SIN ESPECIFICAR-</option>");
            $.each(jsondata.d, function (i, obj) {
                $("#sltTelefono").append("<option value='" + obj.TEL_CODIGO + "'>" + obj.TEL_NUMERO + " (" + obj.TEL_ORIGEN + ")" + "</option>");
            });
        }
    });
}



function listarDirecciones() {
    var rol = $("#contenido_txtCodigoRol").val();
    $.ajax({
        url: strServicio+"general.asmx/listarDirecciones",
 //       data: '{"dni":"' + $("#contenido_txtDni").val() + '"}',
        data: '{"dni":"' + '|' + $("#contenido_txtCodigoCuenta").val() + '"}',//se usa CUE_CODIGO (NO HAY NRO DE CUENTA) en vez de dni
        dataType: 'JSON',
        type: 'POST',
        contentType: "application/json; charset=utf-8",
        async: false,
        success: function (jsondata) {
            $("#sltDireccion").html("<option value='00'>-SELECCIONE-</option>");
            $.each(jsondata.d, function (i, obj) {
                $("#sltDireccion").append("<option value='" + obj.DIR_CODIGO + "'>" + obj.DIR_DIRECCION + " - " + obj.UBI_DISTRITO + " (" + obj.TDI_DESCRIPCION + ")" + "</option>");
            });
        }
    });
}

$(".calcularCuotaMonto").keyup(function () {
    calcularMonto();
});

$("#txtFechaInicial").change(function () {
    calcularMonto();
});

function calcularMonto() {
    try {
        var rol = $("#contenido_txtCodigoRol").val();
        var montoNegociado = parseFloat($("#txtMontoNegociacion").val());
        var numeroCuotas = parseFloat($("#txtNroCuotas").val());
        var montoRecibo;

        if ($("#txtReciboMonto").is(":visible")) {
            montoRecibo = parseFloat($("#txtReciboMonto").val());
        } else if ($("#txtMontoInicial").is(":visible")) {
            montoRecibo = parseFloat($("#txtMontoInicial").val());
        } else {
            montoRecibo = 0.0;
        }

        var montoInicial;

        if ($("#txtReciboMonto").is(":visible")) {
            montoInicial = parseFloat($("#txtReciboMonto").val());
        } else if ($("#txtMontoInicial").is(":visible")) {
            montoInicial = parseFloat($("#txtMontoInicial").val());
        }

        var valorCuota = (montoNegociado - montoInicial) / numeroCuotas;
        $("#txtValorCuota").val(valorCuota.toFixed(2));

        var saldoNegociacion = montoNegociado - montoRecibo;
        $("#txtSaldoNegociacion").val(saldoNegociacion.toFixed(2));

        var fechaInicial;

        if ($("#txtReciboFecha").is(":visible")) {
            fechaInicial = $("#txtReciboFecha").val().split("/");
        } else if ($("#txtFechaInicial").is(":visible")) {
            fechaInicial = $("#txtFechaInicial").val().split("/");
        }

        var fecha = new Date(fechaInicial[2], fechaInicial[1] - 1, fechaInicial[0]);

        $("#tblCuotas tbody").empty();
        for (var x = 0; x < numeroCuotas; x++) {
            fecha.setMonth(fecha.getMonth() + 1);

            $("#tblCuotas tbody").append("<tr><td>" + (x + 1) + "</td><td><input type='text' id='cuota_" + (x + 1) + "' class='form-control' onChange='modificarFechas(" + (x + 1) + "," + numeroCuotas + ");' value='" + formattedDate(fecha) + "' style='text-align:right;' /></td><td><input type='text' id='cuota_valor_" + (x + 1) + "' class='form-control' value='" + valorCuota.toFixed(2) + "' style='text-align:right;' onChange='calcularConvenio(" + (x + 1) + "," + numeroCuotas + ");' /></td></tr>");
            //$("#tblCuotas tbody").append("<tr><td>" + (x + 1) + "</td><td><input type='text' id='cuota_" + (x + 1) + "' class='form-control' onChange='modificarFechas(" + (x + 1) + "," + numeroCuotas + ");' value='" + formattedDate(fecha) + "' style='text-align:right;' " + (rol == 4 || rol == 5 ? "readonly='true'" : "") + "/></td><td><input type='text' id='cuota_valor_" + (x + 1) + "' class='form-control' value='" + valorCuota.toFixed(2) + "' style='text-align:right;' onChange='calcularConvenio(" + (x + 1) + "," + numeroCuotas + ");' " + (rol == 4 || rol == 5 ? "readonly='true'" : "") + "/></td></tr>");

            $("#cuota_" + (x + 1)).datepicker({
                format: 'dd/mm/yyyy'
            });
            /*if (rol != 4 && rol != 5) {
                $("#cuota_" + (x + 1)).datepicker({
                    format: 'dd/mm/yyyy'
                });
            }*/
        }
        $("#tblCuotas tfoot").html("<tr><td></td><td style='text-align:right;'>TOTAL</td><td style='text-align:right;' id='txtConvenioTotal'>" + saldoNegociacion.toFixed(2) + "</td></tr>");
    } catch (Err) { }
}

function registrarGestion() {
    if ($("#sltTipoGestion").is(":visible") && $("#sltTipoGestion").val() == "00") {
        bootbox.alert("Usted no selecciono el TIPO DE GESTIÓN");
        $("#sltTipoGestion").focus();
        return false;
    }
    if ($("#sltRespuesta").val() == "") {
        bootbox.alert("Usted no selecciono la RESPUESTA");
        $("#sltRespuesta").focus();
        return false;
    }
    if ($("#sltSolucion").is(":visible") && $("#sltSolucion").val() == "") {
        bootbox.alert("Usted no selecciono la SOLUCION");
        $("#sltSolucion").focus();
        return false;
    }
    if ($("#sltTelefono").is(":visible") && $("#sltTelefono").val() == "0" && $("#sltTipoGestion").val() != "6") {
        bootbox.alert("Usted no selecciono el TELÉFONO GESTIONADO");
        $("#sltTelefono").focus();
        return false;
    }
    if ($("#sltTipoLlamada").is(":visible") && $("#sltTipoLlamada").val() == "00") {
        bootbox.alert("Usted no selecciono el TIPO DE LLAMADA");
        $("#sltTipoLlamada").focus();
        return false;
    }
    if ($("#sltDireccion").is(":visible") && $("#sltDireccion").val() == "00") {
        bootbox.alert("Usted no selecciono la DIRECCIÓN");
        $("#sltDireccion").focus();
        return false;
    }
    if ($("#sltTipoPago").is(":visible") && $("#sltTipoPago").val() == "00") {
        bootbox.alert("Usted no selecciono el TIPO DE PAGO");
        $("#sltTipoPago").focus();
        return false;
    }
    if ($("#txtMontoNegociacion").is(":visible") && ($("#txtMontoNegociacion").val().length < 1 || !$.isNumeric($("#txtMontoNegociacion").val()))) {
        bootbox.alert("Usted no ingreso el MONTO DE NEGOCIACIÓN o no es formato NUMÉRICO");
        $("#txtMontoNegociacion").focus();
        return false;
    }
    if ($("#txtSaldoNegociacion").is(":visible") && ($("#txtSaldoNegociacion").val().length < 1 || !$.isNumeric($("#txtSaldoNegociacion").val()))) {
        bootbox.alert("Usted no ingreso el SALDO DE NEGOCIACIÓN o no es formato NUMÉRICO");
        $("#txtSaldoNegociacion").focus();
        return false;
    }
    if ($("#txtMontoInicial").is(":visible") && ($("#txtMontoInicial").val().length < 1 || !$.isNumeric($("#txtMontoInicial").val()))) {
        bootbox.alert("Usted no selecciono el MONTO INICIAL o no es formato NUMÉRICO");
        $("#txtMontoInicial").focus();
        return false;
    }
    if ($("#txtFechaInicial").is(":visible") && ($("#txtFechaInicial").val().length < 1 || !isValidDate($("#txtFechaInicial").val()))) {
        bootbox.alert("Usted ingreso la FECHA INICIAL o no es el formato CORRECTO");
        $("#txtFechaInicial").focus();
        return false;
    }
    if ($("#txtNroCuotas").is(":visible") && ($("#txtNroCuotas").val().length < 1 || !$.isNumeric($("#txtNroCuotas").val()))) {
        bootbox.alert("Usted no Ingreso el NÚMERO DE CUOTAS");
        $("#txtNroCuotas").focus();
        return false;
    }
    if ($("#txtNroCuotas").is(":visible") && ($("#txtNroCuotas").val().length > 0 && $.isNumeric($("#txtNroCuotas").val()))) {
        var cant_cuotas = ($("#sltSolucion").is(":visible") ? $("#sltSolucion").val().split('-').pop() :
                ($("#sltRespuesta").is(":visible") ? $("#sltRespuesta").val().split('-').pop() : '0'));
        console.log(cant_cuotas);
        if (cant_cuotas != "0") {
            var rango = cant_cuotas.split(';');
            console.log($("#txtNroCuotas").val() + "<" + rango[0]);
            console.log($("#txtNroCuotas").val() + ">" + rango[1]);
            if ((parseInt($("#txtNroCuotas").val()) < parseInt(rango[0])) ||
                (parseInt($("#txtNroCuotas").val()) > parseInt(rango[1]))) {
                var texto = "Usted no esta en el rango valido de [" + rango[0] + " - " + rango[1] + " cuotas]";
                bootbox.alert(texto);
                return false;
            }
        }
    }
    if ($("#txtObservacionRecordatorio").is(":visible") && $("#txtObservacionRecordatorio").val().length < 1) {
        bootbox.alert("Usted no Ingreso la observación del RECORDATORIO");
        $("#txtObservacionRecordatorio").focus();
        return false;
    }
    //if ($("#sltApoyoCall").is(":visible") && $("#sltApoyoCall").val() == "00") {
    //    bootbox.alert("Usted no selecciono la ASIGNACION DE GESTOR CALL");
    //    $("#sltApoyoCall").focus();
    //    return false;
    //}
    //if ($("#sltApoyoCampo").is(":visible") && $("#sltApoyoCampo").val() == "00") {
    //    bootbox.alert("Usted no selecciono la ASIGNACION DE GESTOR CAMPO");
    //    $("#sltApoyoCampo").focus();
    //    return false;
    //}
    if ($("#txtReciboMonto").is(":visible") && ($("#txtReciboMonto").val().length < 1 || !$.isNumeric($("#txtReciboMonto").val()))) {
        bootbox.alert("Usted no ingreso el MONTO DE RECIBO");
        $("#txtReciboMonto").focus();
        return false;
    }
    if ($("#txtReciboFecha").is(":visible") && $("#txtReciboFecha").val().length < 1) {
        bootbox.alert("Usted no ingreso el FECHA DE RECIBO");
        $("#txtReciboFecha").focus();
        return false;
    }
    if ($("#txtReciboNumero").is(":visible") && $("#txtReciboNumero").val().length < 1) {
        bootbox.alert("Usted no ingreso el NÜMERO DE RECIBO");
        $("#txtReciboNumero").focus();
        return false;
    }
    if ($("#txtReciboAgencia").is(":visible") && $("#txtReciboAgencia").val().length < 1) {
        bootbox.alert("Usted no ingreso el NÚMERO DE LA AGENCIA");
        $("#txtReciboAgencia").focus();
        return false;
    }

    var objGestion = new Object();
    objGestion.FLG_ELIMINAR_CRONOGRAMA = false;
    objGestion.ObjCuenta = new Object();

    if ($("#tblCuotas").is(":visible")) {
        var objCuentaBE = new Object();
        objCuentaBE.CUE_CODIGO = $("#contenido_txtCodigoCuenta").val();
        $.ajax({
            url: strServicio + "gestion.asmx/tieneConvenio",
            data: '{"objCuentaBE": ' + JSON.stringify(objCuentaBE) + '}',
            dataType: 'JSON',
            type: 'POST',
            contentType: "application/json; charset=utf-8",
            async: false,
            success: function (jsondata) {
                if (jsondata.d != null) {
                    if (jsondata.d.NRO_CUO_FAL > 0) {
                        /*todo no funciona*/
                        bootbox.prompt({
                            size:"large",
                            placeholder:"maximo 50 caracteres",
                            maxlength:50,
                            title:"ESTA CUENTA YA TIENE UN CONVENIO VIGENTE. SI DESEA DARLO DE BAJA, INGRESE EL MOTIVO DE MODIFICACIÓN:", 
                            callback:function (r) {
                            if (r != null && $.trim(r).length > 0 ) {
                                objGestion.FLG_ELIMINAR_CRONOGRAMA = true;
                                objGestion.ObjCuenta.TXT_MOTIVO_CONVENIO = r;
                                iniciarRegistroGestion(objGestion, true);
                            } else {
                                bootbox.alert("Usted no ingreso el MOTIVO DE MODIFICACIÓN, vuelva a intentar registrar.");
                            }
                        }});
                    } else {
                        iniciarRegistroGestion(objGestion, true);
                    }
                } else {
                    iniciarRegistroGestion(objGestion,true);
                }
            }
        });
    } else {
        iniciarRegistroGestion(objGestion, false);
    }
}

function iniciarRegistroGestion(objGestion, flgConvenio) {
    if (flgConvenio) {
        var lstCronograma = new Array();
        $("#tblCuotas tbody tr").each(function (i) {
            var cronograma = new Object();
            var codigo = (i + 1);
            cronograma.NRO_CUOTA = codigo;
            cronograma.FEC_VENCIMIENTO = $("#cuota_" + codigo).val();
            cronograma.IMP_CUOTA = $("#cuota_valor_" + codigo).val();
            lstCronograma.push(cronograma);
        });
        objGestion.lstCronogramaBE = lstCronograma;
    }
    
    objGestion.ObjTipoResultado = new Object();
    objGestion.ObjTipoResultado.TIR_CODIGO = $("#sltRespuesta").val().split('-')[0];
    if ($("#sltSolucion").is(":visible")) { objGestion.ObjTipoResultado.SOL_CODIGO = $("#sltSolucion").val().split('-')[0]; }
    objGestion.ObjTelefono = new Object();
    objGestion.ObjTelefono.TEL_CODIGO = $("#sltTelefono").val();
    objGestion.GES_OBSERVACIONES = $("#txtObservacion").val();
    objGestion.ObjCuenta.CUE_CODIGO = $("#contenido_txtCodigoCuenta").val();
    objGestion.ObjCartera = new Object();
    objGestion.ObjCartera.CAR_CODIGO = $("#contenido_txtCodigoCartera").val();
    objGestion.ObjSubCartera = new Object();
    objGestion.ObjSubCartera.SCA_CODIGO = $("#contenido_txtCodigoSubCartera").val();
    //objGestion.GES_HORA = $("#horaGestion").text();
    objGestion.ObjDireccion = new Object();
    objGestion.ObjDireccion.DIR_CODIGO = $("#sltDireccion").val();
    objGestion.ObjTipoGestion = new Object();
    objGestion.ObjTipoGestion.TIG_CODIGO = $("#sltTipoGestion").val();
    objGestion.GES_FECHA_INICIAL = $("#txtFechaInicial").val();
    objGestion.GES_IMPORTE_INICIAL = ($("#txtMontoInicial").val() == "" ? "0" : $("#txtMontoInicial").val());
    objGestion.ObjTipoPago = new Object();
    objGestion.ObjTipoPago.TPA_CODIGO = $("#sltTipoPago").val();
    objGestion.GES_NRO_CUOTAS = ($("#txtNroCuotas").val() == "" ? "0" : $("#txtNroCuotas").val());
    objGestion.GES_IMPORTE_NEGOCIACION = (isNaN($("#txtMontoNegociacion").val()) || $("#txtMontoNegociacion").val() == "" ? "0" : $("#txtMontoNegociacion").val());
    objGestion.GES_SALDO_NEGOCIACION = (isNaN($("#txtSaldoNegociacion").val()) || $("#txtSaldoNegociacion").val() == "" ? "0" : $("#txtSaldoNegociacion").val());
    objGestion.GES_VALOR_CUOTA = (isNaN($("#txtValorCuota").val()) || $("#txtValorCuota").val() == "" ? "0" : $("#txtValorCuota").val());
    //objGestion.ASI_GES_CALL = $("#sltApoyoCall").val();
    //objGestion.ASI_GES_CAMPO = $("#sltApoyoCampo").val();
    objGestion.REC_NUMERO = $("#txtReciboNumero").val();
    objGestion.REC_AGENCIA = $("#txtReciboAgencia").val();
    objGestion.REC_MONTO = ($("#txtReciboMonto").val() == "" ? "0" : $("#txtReciboMonto").val());
    objGestion.REC_FECHA = $("#txtReciboFecha").val();
    console.log(objGestion);

    var rol = $("#contenido_txtCodigoRol").val();

    /*if ($("#tblCuotas").is(":visible") && (rol != 4 && rol != 5)) {
        var lstCronograma = new Array();
        $("#tblCuotas tbody tr").each(function (i) {
            var cronograma = new Object();
            var codigo = (i + 1);
            cronograma.NRO_CUOTA = codigo;
            cronograma.FEC_VENCIMIENTO = $("#cuota_" + codigo).val();
            cronograma.IMP_CUOTA = $("#cuota_valor_" + codigo).val();
            lstCronograma.push(cronograma);
        });
        objGestion.lstCronogramaBE = lstCronograma;
    }*/

    $.ajax({
        url: strServicio + "gestion.asmx/registrarGestion",
        data: '{"objGestion": ' + JSON.stringify(objGestion) + '}',
        dataType: 'JSON',
        type: 'POST',
        contentType: "application/json; charset=utf-8",
        async: false,
        success: function (jsondata) {
            console.log(jsondata.d);
            if (jsondata != null) {
                if (jsondata.d > 0) {
                    //tarea.GES_CODIGO = jsondata.d;
                    //$("#txtCodigoGestion").val(jsondata.d);
                    guardarTarea(jsondata.d);
                    parent.cargarGestiones();
                    bootbox.alert("REGISTRO DE GESTIÓN REALIZADO CORRECTAMENTE");
                    parent.$.fancybox.close();
                }
            } else {
                bootbox.alert("EL REGISTRO DE GESTIÓN NO SE REALIZO, POR FAVOR VUELVA A INTENTAR");
            }
        }
    });
}

function guardarTarea(gestion_codigo) {
    var tarea = new Object();
    tarea.GES_CODIGO = gestion_codigo;
    tarea.REC_FECHA = $("#txtFechaRecordatorio").val();
    tarea.REC_HORA = $("#txtHoraRecordatorio").val();
    tarea.REC_OBSERVACIONES = $("#txtObservacionRecordatorio").val();
    tarea.TIR_CODIGO = $("#sltRespuesta").val().split("-")[0];
    tarea.CLI_CODIGO = $("#contenido_txtCodigoCliente").val();
    //console.log(tarea);
    if (tarea.GES_CODIGO != "0" && tarea.REC_OBSERVACIONES != null && tarea.REC_OBSERVACIONES.length > 0) {
        $.ajax({
            url: strServicio+"gestion.asmx/registrarTarea",
            data: '{"tarea":' + JSON.stringify(tarea) + '}',
            dataType: 'JSON',
            type: 'POST',
            contentType: "application/json; charset=utf-8",
            async: true,
            success: function (jsondata) {
                //console.log(jsondata.d);
            }
        });
    }
}

function isValidDate(s) {
    var bits = s.split('/');
    var d = new Date(bits[2] + '/' + bits[1] + '/' + bits[0]);
    return !!(d && (d.getMonth() + 1) == bits[1] && d.getDate() == Number(bits[0]));
}


//PARA CONVENIOS
function modificarFechas(indice, nro_cuotas) {
    console.log($("#cuota_" + indice).val());
    var mi_fecha = $("#cuota_" + indice).val().split("/");
    console.log(mi_fecha);
    var fecha_nuevo = new Date(mi_fecha[2], mi_fecha[1] - 1, mi_fecha[0]);
    console.log(fecha_nuevo);
    for (var x = indice + 1; x <= nro_cuotas; x++) {
        fecha_nuevo.setMonth(fecha_nuevo.getMonth() + 1);
        $("#cuota_" + x).val(formattedDate(fecha_nuevo));
    }
}

function formattedDate(date) {
    var d = new Date(date || Date.now()),
        month = '' + (d.getMonth() + 1),
        day = '' + d.getDate(),
        year = d.getFullYear();

    if (month.length < 2) month = '0' + month;
    if (day.length < 2) day = '0' + day;

    return [day, month, year].join('/');
}

function calcularConvenio(indice, nro_cuotas) {
    //alert(indice + " - " + nro_cuotas);
    var saldo_negociacion = parseFloat($("#txtSaldoNegociacion").val());
    var monto_actual = parseFloat($("#cuota_valor_" + indice).val());
    var monto_anterior = parseFloat(0.0);
    var total = parseFloat(0.0);
    for (var x = 1; x < indice; x++) {
        monto_anterior += parseFloat($("#cuota_valor_" + x).val());
    }
    var saldo_calculo = ((parseFloat(saldo_negociacion) - parseFloat(monto_anterior) - monto_actual)
        / parseFloat(nro_cuotas - indice));

    for (var x = indice + 1; x <= nro_cuotas; x++) {
        $("#cuota_valor_" + x).val(saldo_calculo.toFixed(2));
    }

    if (saldo_calculo < 0) {
        console.log(indice);
        jAlert("El cronograma del convenio no tiene los montos correctos por favor modificarlos.");
        if (indice == 1) calcularMonto();
        if (indice > 1) calcularConvenio(indice - 1, nro_cuotas);
        $("#cuota_valor_" + indice).focus();
    }

    for (var x = 1; x <= nro_cuotas; x++) {
        total += parseFloat($("#cuota_valor_" + x).val());
    }
    $("#txtConvenioTotal").text(total.toFixed(2));
};
//FIN CONVENIOS