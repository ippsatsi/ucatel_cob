$(document).ready(function () {
    iniciarDatos();
    listarTelefonos();
    listarDirecciones();
    listarCorreos();
    cargarGestiones();

   $("#btnCancelarCronograma").click(cancelarCronograma);
   $("#btnRegistrarCronograma").click(registrarCronograma);
   obtenerCronograma();
    //$("#chkBusquedaEspecializada").change(function () {
    //    if ($("#chkBusquedaEspecializada").is(":checked")) {

    //        jConfirm("¿Esta seguro de enviar a este cliente a una busqueda especializada?", "BUSQUEDA ESPECIALIZADA", function (r) {
    //            if (r) {
    //                var objBusqueda = new Object();
    //                objBusqueda.CLI_CODIGO = $("#txtCodigoCliente").val();
    //                objBusqueda.SCA_CODIGO = $("#txtCodigoSubCartera").val();
    //                objBusqueda.CUE_CODIGO = $("#txtCodigoCuenta").val();
    //                $.ajax({
    //                    url: "../resource/service/gestion.asmx/registrarBusqueda",
    //                    data: '{"objBusqueda": ' + JSON.stringify(objBusqueda) + '}',
    //                    dataType: 'JSON',
    //                    type: 'POST',
    //                    contentType: "application/json; charset=utf-8",
    //                    async: false,
    //                    success: function (jsondata) {
    //                        if (jsondata.d == "CORRECTO") {
    //                            bootbox.alert("Busqueda registrada correctamente");
    //                        }
    //                    }
    //                });
    //            }
    //        });
    //    }
    //});

    $("#txtReciboFecha").datepicker();
    $("#txtFechaInicial").datepicker();
    $('#tblMultas').dataTable({
      "iDisplayLength": 25,
     "aLengthMenu": [[25, 50, 100, -1], [25, 50, 100, "Todos"]],
     "bLengthChange": true,
     "bPaginate": true,
     //"sScrollX": "50%",
     //"bScrollCollapse": true,
     //"sScrollXInner": "110%",
     //"sScrollY": "200px",
        "oLanguage": {
            "sProcessing": "Procesando...",
            "sLengthMenu": "Mostrar _MENU_ registros",
            "sZeroRecords": "No se encontraron resultados",
            "sEmptyTable": "Ningún dato disponible en esta tabla",
            "sInfo": "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
            "sInfoEmpty": "Mostrando registros del 0 al 0 de un total de 0 registros",
            "sInfoFiltered": "(filtrado de un total de _MAX_ registros)",
            "sInfoPostFix": "",
            "sSearch": "Buscar:",
            "sUrl": "",
            "sInfoThousands": ",",
            "sLoadingRecords": "Cargando...",
            "oPaginate": {
                "sFirst": "Primero",
                "sLast": "Último",
                "sNext": "Siguiente",
                "sPrevious": "Anterior"
            },
            "oAria": {
                "sSortAscending": ": Activar para ordenar la columna de manera ascendente",
                "sSortDescending": ": Activar para ordenar la columna de manera descendente"
            }

        }
    });
});

function cargarGestiones() {
    objCuenta = new Object();
    objCuenta.CUE_CODIGO = $("#txtCodigoCuenta").val();
    //console.log("GESTIONES: " + objCuenta);
    $.ajax({
        url: strServicio +  "gestion.php?cargarGestiones=1",
        data: '{"objCuenta": ' + JSON.stringify(objCuenta) + ', "CONSULTA_AJAX":"cargarGestiones"}',
        dataType: 'JSON',
        type: 'POST',
        contentType: "application/json; charset=utf-8",
        async: false,
        success: function (jsondata) {
            //console.table(jsondata.d);
            $("#tblMultas tbody").empty();
            var htmlText = "";
            $.each(jsondata.d, function (i, obj) {
                //htmlText = "<tr" + (i % 2 == 0 ? " class='row_listabandejavirtual'" : "") + ">" +
                htmlText = "<tr>" +
                    "<td>" + (i + 1) + "</td>" +
                    "<td>" + obj.GES_FECHA_REGISTRO + "</td>" +
                    "<td>" + obj.USU_LOGIN + "</td>" +
                    "<td>" + obj.TIR_DESCRIPCION + "</td>" +
                    "<td>" + (obj.SOL_DESCRIPCION ?? '') + "</td>" +
                    "<td>" + obj.TIG_DESCRIPCION + "</td>" +
                    "<td>" + obj.MONEDA + "</td>" +
                    "<td>" + Number(obj.GES_IMPORTE_NEGOCIACION) + "</td>" +
                    "<td>" + Number(obj.GES_SALDO_NEGOCIACION) + "</td>" +
                    "<td>" + (obj.GES_FECHA_INICIAL ?? '') + "</td>" +
                    "<td>" + Number(obj.GES_IMPORTE_INICIAL) + "</td>" +
                    "<td>" + obj.GES_NRO_CUOTAS + "</td>" +
                    "<td>" + Number(obj.GES_VALOR_CUOTA) + "</td>" +
                    "<td>" + (obj.TELEFONO ?? '') + "</td>" +
                    "<td>" + (obj.DIRECCION ?? '') + "</td>" +
                    "<td>" + obj.OBSERVACIONES + "</td>" +
                "</tr>";
                $("#tblMultas tbody").append(htmlText);
            });
        }
    });
}

function listarTipoRespuesta() {
    $.ajax({
        url: "../resource/service/general.asmx/listaTipoRespuesta",
        dataType: 'JSON',
        type: 'POST',
        contentType: "application/json; charset=utf-8",
        async: false,
        success: function (jsondata) {
            $.each(jsondata.d, function (i, obj) {
                $("#sltRespuestaCopy").append("<option id='rec_" + i + "' value='" + obj.value + "'>" + obj.key + "</option>");
            });
        }
    });
}

function iniciarDatos() {
    var rol = $("#txtCodigoRol").val();

    // $("label[for=ac-1]").click();
    // //AFAC 11/05/2016
    // if (rol=="4") {
    //     $("label[for=ac-2]").click();
    // } else if (rol == "5") {
    //     $("label[for=ac-5]").click();
    // } else {
    //     $("label[for=ac-2]").click();
    //     $("label[for=ac-5]").click();
    // }
    $.ajax({
        url: strServicio +  "gestion.php?obtenerDatosCuenta=1",
        data: '{"cuenta":"' + $("#contenido_txtCuenta").val() + '", "CONSULTA_AJAX":"obtenerDatosCuenta"}',
        dataType: 'JSON',
        type: 'POST',
        contentType: "application/json; charset=utf-8",
        async: false,
        success: function (jsondata) {
            $("#txtCodigoCliente").val(jsondata.d[0].CLI_CODIGO);
            $("#txtCodigoProveedor").val(jsondata.d[0].PRV_CODIGO);
            $("#txtCodigoCuenta").val(jsondata.d[0].CUE_CODIGO);
            $("#txtCodigoCartera").val(jsondata.d[0].CAR_CODIGO);
            $("#txtCodigoSubCartera").val(jsondata.d[0].SCA_CODIGO);
            $("#txtDni").html(jsondata.d[0].CLI_DOCUMENTO_IDENTIDAD);
            $("#txtNombres").html(jsondata.d[0].CLI_NOMBRE_COMPLETO);
            $("#txtDireccion").html(jsondata.d[0].CLI_DIRECCION_PARTICULAR);
            $("#txtUbigeo").html(jsondata.d[0].UBIGEO);
            $("#txtCorreo").html(jsondata.d[0].CLI_CORR_PARTICULAR);
            $("#txtCelular").html(jsondata.d[0].CLI_CELULAR);
            $("#txtDias").html(jsondata.d[0].DIAS);
            if (jsondata.d[0].BAD_DIAS_MORA > 0) {
                $("#divDiasMora").show();
                $("#txtDiasMora").html(jsondata.d[0].BAD_DIAS_MORA);
            }
            console.log(jsondata.d);
            if (jsondata.d[0].MONTO_CAMPANA_MINIMO.length > 0) {
                $("#divCampanaMinimo").show();
                $("#txtCampanaMinimo").html(jsondata.d[0].MONTO_CAMPANA_MINIMO);
            }
            if (jsondata.d[0].MONTO_CAMPANA_MAXIMO.length > 0) {
                $("#divCampanaMaximo").show();
                $("#txtCampanaMaximo").html(jsondata.d[0].MONTO_CAMPANA_MAXIMO);
            }
            if (jsondata.d[0].MONTO_CAMPANA_CANCELACION.length > 0) {
                $("#divCampanaCancelacion").show();
                $("#txtCampanaCancelacion").html(jsondata.d[0].MONTO_CAMPANA_CANCELACION);
            }
            if (jsondata.d[0].MONTO_CAMPANA_ARMADA.length > 0) {
                $("#divCampanaArmada").show();
                $("#txtCampanaArmada").html(jsondata.d[0].MONTO_CAMPANA_ARMADA);
            }

            $("#txtUsuarioCall").html(jsondata.d[0].USUARIO_CALL);
            $("#txtUsuarioCampo").html(jsondata.d[0].USUARIO_CAMPO);
            //bootbox.alert($("#txtCodigoCartera").val());
            if ($("#txtCodigoCartera").val() == "1" ||
                $("#txtCodigoCartera").val() == "3") {// SAGA CASTIGO
                $("#lblCampo1").html("FECHA CASTIGO");
                $("#lblCampo2").html("FECHA ASIGNACIÓN");
                $("#lblCampo3").html("FECHA PROTESTO");
                $("#lblCampo4").html("MORA ACTUALIZADO");
                $("#lblCampo5").html("CAPITAL");
                $("#lblCampo6").html("MONTO PROTESTO");
                $("#lblCampo7").html("SALDO DEUDA");

                $("#txtCampo1").html(jsondata.d[0].BAD_FECHA_CASTIGO);
                $("#txtCampo2").html(jsondata.d[0].BAD_FECHA_ASIGNACION);
                $("#txtCampo3").html(jsondata.d[0].BAD_FECHA_PROTESTO);
                $("#txtCampo4").html(jsondata.d[0].BAD_DIAS_MORA);
                $("#txtCampo5").html(jsondata.d[0].CAPITAL);
                $("#txtCampo6").html(jsondata.d[0].PROTESTO);
                $("#txtCampo7").html(jsondata.d[0].SALDO);
            } else if ($("#txtCodigoCartera").val() == "4") {// SAGA JUDICIAL
                $("#lblCampana").text("EXPEDIENTE");
                $("#txtCampana").html(jsondata.d[0].BAD_NRO_EXP + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;JUZGADO: " + jsondata.d[0].BAD_JUZGADO);

                $("#lblCampo1").html("FECHA DEMANDA");
                $("#lblCampo2").html("ETAPA JUICIO");
                $("#lblCampo3").html("FECHA PROTESTO");
                $("#lblCampo4").html("MORA ACTUALIZADO");
                $("#lblCampo5").html("CAPITAL");
                $("#lblCampo6").html("MONTO PROTESTO");
                $("#lblCampo7").html("SALDO DEUDA");

                $("#txtCampo1").text(jsondata.d[0].BAD_FECHA_DEMANDA);
                $("#txtCampo2").text(jsondata.d[0].BAD_ETAPA_JUICIO + " - " + jsondata.d[0].BAD_FECHA_ETAPA);
                $("#txtCampo3").html(jsondata.d[0].BAD_FECHA_PROTESTO);
                $("#txtCampo4").html(jsondata.d[0].BAD_DIAS_MORA);
                $("#txtCampo5").html(jsondata.d[0].CAPITAL);
                $("#txtCampo6").html(jsondata.d[0].PROTESTO);
                $("#txtCampo7").html(jsondata.d[0].SALDO);
            } else if ($("#txtCodigoCartera").val() == "X") { //DUPRE
                $("#lblCampo1").html("PERIODO CAMPAÑA");
                $("#lblCampo2").html("FECHA ASIGNACIÓN");
                $("#lblCampo3").html("FECHA VENCIMIENTO");
                $("#lblCampo4").html("DIAS MORA");
                $("#lblCampo5").html("");
                $("#lblCampo6").html("SALDO DEUDA");
                $("#lblCampo7").html("");
                var datos_json = JSON.parse(jsondata.d[0].DATOS);
                console.log("DUPRE JSON");
                console.log(datos_json);
                $("#txtCampo1").html(datos_json.CAMPANA);
                $("#txtCampo2").html(jsondata.d[0].BAD_FECHA_ASIGNACION);
                $("#txtCampo3").html(jsondata.d[0].BAD_FECHA_VENCIMIENTO1);
                $("#txtCampo4").html(jsondata.d[0].BAD_DIAS_MORA);
                $("#txtCampo5").html("");
                $("#txtCampo6").html(jsondata.d[0].SALDO);
                $("#txtCampo7").html("");
            }
            //$.each(jsondata.d, function (i, obj) {
            //});
        }
    });
}

function listarTelefonos() {
    var rol = $("#txtCodigoRol").val();
    $.ajax({
        url: strServicio + "gestion.php?telefonos=1",
     //   data: '{"dni":"' + $("#txtDni").html() + '"}',
        data: '{"dni":"' + $("#contenido_txtCuenta").val() + '", "CONSULTA_AJAX":"listarTelefonos"}',//se usa nrode cuenta en vez de dni
        dataType: 'JSON',
        type: 'POST',
        contentType: "application/json; charset=utf-8",
        async: true,
        success: function (jsondata) {
            var htmlText = "";
            var contador = 0;
            $("#tblTelefonos tbody").empty();
            //$("#sltTelefono").html("<option value='0'>-SELECCIONE-</option>");
            //$("#sltTelefono").html("<option value='0'>-SIN ESPECIFICAR-</option>");
            $.each(jsondata.d, function (i, obj) {
                contador++;
                //console.log(obj);
                htmlText = " <tr>" +
                    "<td><span>" + (i + 1) + "</span></td>" +
                    //"<td><span>" + obj.TOR_DESCRIPCION + "</span></td>" +
                    "<td><a onclick='gestionarTelefono("+obj.TEL_CODIGO + ");'>" + obj.TEL_NUMERO +
                    (obj.FG_NUEVO_TELEFONO == 'T' ? " <span class='fa-stack fa-lg' aria-hidden='true'><i class='fa fa-exclamation-triangle fa-pulse fa-1x fa-fw margin-bottom text-warning'></i></span>" : "") + "</a></td>" +
                    "<td><span>" + obj.TEL_ANEXO + "</span></td>" +
                    "<td " + (obj.TES_COLOR !== null ? "style='background-color:" + obj.TES_COLOR + " !important;'" : "") + "><span>" + obj.TEL_ESTADO_VALIDEZ + "</span></td>" +
                    "<td " + (obj.TES_COLOR_MENSUAL !== null ? "style='background-color:" + obj.TES_COLOR_MENSUAL + " !important;'" : "") + "><span>" + (obj.TES_ABREVIATURA_MENSUAL==null ? '' : obj.TES_ABREVIATURA_MENSUAL)  + "</span></td>" +
                    //"<td><span>" + obj.TEL_TIPO_EQUIPO + "</span></td>" +
                    "<td><span>" + obj.ESTADO_TELEFONO + "</span></td>" +
                    "<td><span>" + obj.TOR_DESCRIPCION + "</span></td>" +
                    "<td><span>" + obj.TEL_OBSERVACIONES + "</span></td>" +
                    "<td><a onclick=\"llamar_telefono('" + obj.TEL_NUMERO + "', '" + contador + "')\"><i class='glyphicon glyphicon-earphone btn bg-green-jungle' style='color:#FFFFFF;' id='phone_num_" + contador + "' aria-hidden='true'></i></a></td>" +
                    "<td><a onclick='registrarTelefono(" + obj.TEL_CODIGO + ");'><i class='fa fa-pencil' aria-hidden='true'></i></a></td>" +
                    "<td>" + (rol == 1 ||rol == 2 ||rol == 3? "<a onclick='eliminarTelefonoSession(" + obj.TEL_CODIGO + ");'><i class='fa fa-trash-o' aria-hidden='true'></i></a>" : "") + "</td>" +
                "</tr>";
                $("#tblTelefonos tbody").append(htmlText);

                //$("#sltTelefono").append("<option value='" + obj.TEL_CODIGO + "'>" + obj.TEL_NUMERO + " (" + obj.TOR_DESCRIPCION + ")" + "</option>");
            });
        }
    });
}

function gestionarTelefono(codigo) {
    if($("#txtCodigoRol").val()!=5){
        var url = "gestionar-nuevo.php?codigoCuenta=" + $("#txtCodigoCuenta").val() +
            "&codigoCliente=" + $("#txtCodigoCliente").val() +
            "&codigoRol=" + $("#txtCodigoRol").val() +
            "&codigoCartera=" + $("#txtCodigoCartera").val() +
            "&codigoSubcartera=" + $("#txtCodigoSubCartera").val() +
            "&txtDniCliente=" + $("#txtDni").html() +
            "&txtCodigoTelefono=" + codigo + "&txtCodigoDireccion=0";
        console.log(url);

        $.fancybox({
            type: "iframe",
            width: 800,
            height: 570,
            scrolling: 'no',
            modal: false, //modal: true,
            href: url
        });
    }
}

function listarCorreos() {
    var rol = $("#txtCodigoRol").val();
    $.ajax({
        url: strServicio + "gestion.php?listarCorreos=1",
        data: '{"dni":"' + $("#txtDni").html() + '", "CONSULTA_AJAX":"listarCorreos"}',
        dataType: 'JSON',
        type: 'POST',
        contentType: "application/json; charset=utf-8",
        async: true,
        success: function (jsondata) {
            var htmlText = "";
            $("#tblCorreos tbody").empty();
            $.each(jsondata.d, function (i, obj) {
                htmlText = "<tr>" +
                    "<td><span>" + (i + 1) + "</span></td>" +
                    "<td><span id='txt_correo_" + obj.COR_CODIGO + "'>" + obj.COR_CORREO_ELECTRONICO + "</span></td>" +
                    "<td><a onclick='registrarCorreo(" + obj.COR_CODIGO + ");'><i class='fa fa-pencil' aria-hidden='true'></i></a></td>" +
                    "<td>" + (rol == 1 || rol == 2 || rol == 3 ? "<a onclick='eliminarCorreo(" + obj.COR_CODIGO + ");'><i class='fa fa-trash-o' aria-hidden='true'></i></a>" : "") + "</td>" +
                "</tr>";
                $("#tblCorreos tbody").append(htmlText);
            });
        }
    });
}

function registrarCorreo(codigo) {
    var url = "";
    if (parseInt(codigo) > 0) {
        url = "correo.php?codigo=" + codigo + "&correo=" + $("#txt_correo_"+codigo).text() + "&codigoCliente=" + $("#txtCodigoCliente").val() + "&codigoProveedor=" + $("#txtCodigoProveedor").val();
    } else {
        url = "correo.php?codigoCliente=" + $("#txtCodigoCliente").val() + "&codigoProveedor=" + $("#txtCodigoProveedor").val();
    }
    //console.log(url);
    $.fancybox({
        type: "iframe",
        width: 500,
        height: 180,
        scrolling: 'no',
        modal: false, //modal: true,
        href: url
    });
}

function eliminarCorreo(codigo) {
    bootbox.confirm("¿Esta seguro de eliminar esta correo?", function (res) {
        if (res) {
            $.ajax({
                url: strServicio + "correo_svc.php?eliminarCorreoId=1",
                data: '{"codigo":' + codigo + ',"CONSULTA_AJAX":"eliminarCorreoId"}',
                dataType: 'JSON',
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                async: false,
                success: function (jsondata) {
                    if (jsondata.d) {
                        listarCorreos();
                    }
                }
            });
        }
    });
}

function listarDirecciones() {
    var rol = $("#txtCodigoRol").val();
    $.ajax({
        url: strServicio + "gestion.php?listarDirecciones=1",
    //    data: '{"dni":"' + $("#txtDni").html() + '"}',
        data: '{"dni":"' + $("#contenido_txtCuenta").val() + '", "CONSULTA_AJAX":"listarDirecciones"}',//se usa nrode cuenta en vez de dni
        dataType: 'JSON',
        type: 'POST',
        contentType: "application/json; charset=utf-8",
        async: true,
        success: function (jsondata) {
            var htmlText = "";
            $("#tblDirecciones tbody").empty();
            $.each(jsondata.d, function (i, obj) {
                htmlText = "<tr>" +
                    "<td><span>" + (i + 1) + "</span></td>" +
                    "<td><a onclick='gestionarDireccion(" + obj.DIR_CODIGO + ");'>" + obj.DIR_DIRECCION + "</span></td>" +
                    "<td><span>" + obj.UBI_DISTRITO + "</span></td>" +
                    "<td " + (obj.DIR_COLOR !== null ? "style='background-color:" + obj.DIR_COLOR + " !important;'" : "") + "><span>" + obj.DIR_ESTADO_VALIDEZ + "</span></td>" +
                    "<td><span>" + obj.TDI_DESCRIPCION + "</span></td>" +
                    "<td><span>" + obj.TOR_DESCRIPCION + "</span></td>" +
 //                    "<td><a onclick='registrarDireccionSession(" + obj.DIR_CODIGO + ");'><i class='fa fa-pencil' aria-hidden='true'></i></a></td>" +  //laguilar:24.05.19 se quita para restringir edicion en teleoperadores
                    "<td>" + (rol == 1 || rol == 2 || rol == 3 || rol == 5 ? "<a onclick='registrarDireccion(" + obj.DIR_CODIGO + ");'><i class='fa fa-pencil' aria-hidden='true'></i></a>" : "") + "</td>" + //restringe edicion solo a supervisores y campo
                    "<td>" + (rol == 1 || rol == 2 || rol == 3 ? "<a onclick='eliminarDireccionSession(" + obj.DIR_CODIGO + ");'><i class='fa fa-trash-o' aria-hidden='true'></i></a>" : "") + "</td>" +
                "</tr>";
                $("#tblDirecciones tbody").append(htmlText);
            });
        }
    });
}

function gestionarDireccion(codigo) {
    if ($("#txtCodigoRol").val() != 4) {

        var url = "gestionar-nuevo.php?codigoCuenta=" + $("#txtCodigoCuenta").val() +
            "&codigoCliente=" + $("#txtCodigoCliente").val() +
            "&codigoRol=" + $("#txtCodigoRol").val() +
            "&codigoCartera=" + $("#txtCodigoCartera").val() +
            "&codigoSubcartera=" + $("#txtCodigoSubCartera").val() +
            "&txtDniCliente=" + $("#txtDni").html() +
            "&txtCodigoTelefono=0&txtCodigoDireccion=" + codigo;

        $.fancybox({
            type: "iframe",
            width: 800,
            height: 570,
            scrolling: 'no',
            modal: false, //modal: true,
            href: url
        });
    }
}

function registrarTelefono(codigo) {
    var url = "";
    if (parseInt(codigo) > 0) {
          url = "telefono.php?codigo=" + codigo + "&codigoCliente=" + $("#txtCodigoCliente").val() + "&codigoProveedor=" + $("#txtCodigoProveedor").val()
                + "&codigoRol=" + $("#txtCodigoRol").val();
     //   url = "telefono.aspx?codigo=" + codigo + "&codigoCliente=" + $("#txtCodigoCliente").val() + "&codigoProveedor=" + $("#txtCodigoProveedor").val(); //cambio en permisos de edicion telefonos 04.04.2019
    } else {
        url = "telefono.php?codigoCliente=" + $("#txtCodigoCliente").val() + "&codigoProveedor=" + $("#txtCodigoProveedor").val();
    }
    //console.log(url);
    $.fancybox({
        type: "iframe",
        width: 500,
        height: 450,
        scrolling: 'no',
        modal: false, //modal: true,
        href: url
    });
}

function registrarTarea() {
    $.fancybox({
        type: "iframe",
        width: 500,
        height: 320,
        scrolling: 'no',
        modal: false, //modal: true,
        href: "tarea.aspx?codigo=" + $("#txtCodigoGestion").val()
    });
}

function obtenerDatosTarea(txtFecha,txtHora,txtObservacion) {
    if (txtObservacion.length > 0) {
        tarea.REC_FECHA = txtFecha;
        tarea.REC_HORA = txtHora;
        tarea.REC_OBSERVACIONES = txtObservacion;
        $("#Checkbox100").attr("checked", "checked");
    } else {
        $("#Checkbox100").removeAttr("checked");
    }
}

function registrarDireccionSession(codigo) {
    $.ajax({
        url: "../resource/service/GestionarUsuarios.asmx/ObtenerDatosSession",
        dataType: 'JSON',
        type: 'POST',
        contentType: "application/json; charset=utf-8",
        async: false,
        success: function (jsondata) {
            ////console.log(jsondata);
            if (jsondata.d == null) {
                $.fancybox({
                    type: "iframe",
                    width: 500,
                    height: 420,
                    scrolling: 'no',
                    modal: false, //modal: true,
                    href: "login.php"
                });
            } else {
                registrarDireccion(codigo);
            }
        }
    });
}

function eliminarDireccionSession(codigo) {
    bootbox.confirm("¿Esta seguro de eliminar esta dirección?", function (res) {
        if (res) {
            $.ajax({
                url: strServicio + "direccion_svc.php?eliminarDireccionId=1",
                data: '{"codigo":' + codigo + ',"CONSULTA_AJAX":"eliminarDireccionId"}',
                dataType: 'JSON',
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                async: false,
                success: function (jsondata) {
                    if (jsondata.d) {
                        listarDirecciones();
                    }
                }
            });
        }
    });
}

function eliminarTelefonoSession(codigo) {
    bootbox.confirm("¿Esta seguro de eliminar esta teléfono?", function (res) {
        if (res) {
            $.ajax({
                url:  strServicio + "telefono_svc.php?eliminarTelefonoId=1",
                data: '{"codigo":' + codigo + ', "CONSULTA_AJAX":"eliminarTelefonoId"}',
                dataType: 'JSON',
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                async: false,
                success: function (jsondata) {
                    if (jsondata.d) {
                        listarTelefonos();
                    }
                }
            });
        }
    });
}

function registrarDireccion(codigo) {
    var url = "";
    //console.log("CODIGO: " + codigo);
    if (parseInt(codigo) > 0) {
        url = "direccion.php?codigo=" + codigo + "&codigoCliente=" + $("#txtCodigoCliente").val() + "&codigoProveedor=" + $("#txtCodigoProveedor").val();
    } else {
        url = "direccion.php?codigoCliente=" + $("#txtCodigoCliente").val() + "&codigoProveedor=" + $("#txtCodigoProveedor").val();
    }
    //console.log(url);
    $.fancybox({
        type: "iframe",
        width: 500,
        height: 530,
        scrolling: 'no',
        modal: false, //modal: true,
        href: url
    });
}

function nuevaGestion() {
    var url = "gestionar-nuevo.php?codigoCuenta=" + $("#txtCodigoCuenta").val() +
        "&codigoCliente=" + $("#txtCodigoCliente").val() +
        "&codigoRol=" + $("#txtCodigoRol").val() +
        "&codigoCartera=" + $("#txtCodigoCartera").val() +
        "&codigoSubcartera=" + $("#txtCodigoSubCartera").val() +
        "&txtDniCliente=" + $("#txtDni").html() +
        "&txtCodigoTelefono=0&txtCodigoDireccion=0";

    $.fancybox({
        type: "iframe",
        width: 800,
        height: 570,
        scrolling: 'no',
        modal: false, //modal: true,
        href: url
    });
}

function llamar_telefono(telefono, elemento) {
    var strServicio = '../resource/service/';
    var objTelefono = new Object();
    objTelefono.TEL_NUMERO = telefono;
    objTelefono.TRONCAL = $("#txtTroncal").val();
    objTelefono.CONTEXTO = $("#txtContextoSip").val();
    objTelefono.CALLERID = telefono + '*' + $("#txtAnexo").val();

    $.ajax({
        url: strServicio + "asterisk_ami.php?llamar_asterisk=1",
        data: '{"objTelefono":' + JSON.stringify(objTelefono) + '}',
        dataType: "json",
        type: "POST",
        contentType: "application/json; charset=utf-8",
        success: function (jsondata) {
            console.log(jsondata);

            if ( jsondata.d ) {
                console.log(jsondata.msg);
                $("#phone_num_" + elemento).removeClass("bg-green-jungle").addClass("red");
                setTimeout(function () {
                    $("#phone_num_" + elemento).removeClass("red").addClass("bg-green-jungle");
                }, 5000);
            }else {
                bootbox.alert(jsondata.msg);
            }
            // var respuesta = "";
            //
            // if(jsondata.d == null || jsondata.d == undefined){
            //     respuesta = "Se ha detectado un error. Inténtalo nuevamente. Si el error persiste, comunicarlo a su área de sistemas.";
            // }else{
            //     switch(jsondata.d){
            //         case "ERROR_CODIGO":
            //             respuesta = "Se ha detectado un error. Inténtalo nuevamente. Si el error persiste, comunicarlo a su área de sistemas.";
            //             break;
            //         case "ERROR_NOSESION":
            //             respuesta = "Se ha perdido la sesión de usuario. Inténte accediendo nuevamente al sistema.";
            //             break;
            //         case "ERROR_CONF_ASTERISK":
            //             respuesta = "No hay datos de conectividad con el servidor Asterisk. Comunique el error a su área de sistemas.";
            //             break;
            //         case "ERROR_AUTENTICATE_ASTERISK":
            //             respuesta = "No hay conectividad con el servidor Asterisk. Comunique el error a su área de sistemas.";
            //             break;
            //         case "ERROR_TIMEOUT_ASTERISK":
            //             respuesta = "Tiempo de espera al servidor asterisk acabado, inténtelo nuevamente. Si el error persiste, comunicarlo a su área de sistemas.";
            //             break;
            //         case "ERROR_MANAGER_ASTERISK":
            //             respuesta = "Se ha detectado un error con el aplicativo Manager del Asterisk. Inténtelo nuevamente. Si el error persiste, comunicarlo a su área de sistemas.";
            //             break;
            //         case "ERROR_VALIDA_ANEXO":
            //             respuesta = "Se ha detectado un error. Inténtalo nuevamente. Si el error persiste, comunicarlo a su área de sistemas.";
            //             break;
            //         case "RES_EXTENSION_RESPUESTA_NOCONOCIDA":
            //             respuesta = "Se ha detectado un error en el servidor Asterisk. Inténtalo nuevamente. Si el error persiste, comunicarlo a su área de sistemas.";
            //             break;
            //         case "RES_EXTENSION_EN_ESPERA":
            //             respuesta = "El anexo se encuentra en espera. No se pudo realizar la llamada.";
            //             break;
            //         case "RES_EXTENSION_TIMBRANDO":
            //             respuesta = "El anexo se encuentra timbrando. No se pudo realizar la llamada.";
            //             break;
            //         case "RES_EXTENSION_INDISPONIBLE":
            //             respuesta = "El anexo no se encuentra disponible. Verifique que el anexo se encuentre encendido y registrado.";
            //             break;
            //         case "RES_EXTENSION_OCUPADO":
            //             respuesta = "El anexo se encuentra ocupado.";
            //             break;
            //         case "RES_EXTENSION_LLAMANDO":
            //             respuesta = "El anexo se encuentra con una llamada activa.";
            //             break;
            //         case "RES_EXTENSION_NO_FUNCIONA":
            //             respuesta = "Se detectó un error con el anexo. Inténtelo nuevamente.";
            //             break;
            //         case "RES_EXTENSION_ELIMINADO":
            //             respuesta = "Se ha eliminado el amexo. Comunicarse con su área de sistemas.";
            //             break;
            //         case "LLAMADA_EN_PROCESO":
            //             $("#phone_num_" + elemento).removeClass("bg-green-jungle").addClass("red");
            //             setTimeout(function () {
            //                 $("#phone_num_" + elemento).removeClass("red").addClass("bg-green-jungle");
            //             }, 7000);
            //             break;
            //         default:
            //             respuesta = "Se ha detectado un error. Inténtalo nuevamente. Si el error persiste, comunicarlo a su área de sistemas.";
            //             break;
            //     }
            //
            //     bootbox.alert(respuesta);
            // }
        },
        error: function (xhr, status, error) {
            console.log(xhr, status, error);
        }
    });
}

function obtenerCronograma() {
    var rol = $("#txtCodigoRol").val();
    var object = new Object();
    object.CUE_CODIGO = $("#txtCodigoCuenta").val();
    $.ajax({
        url: strServicio + "gestion.php?obtenerCronograma=1",
        data: '{"CUE_CODIGO":"' + object.CUE_CODIGO + '", "CONSULTA_AJAX":"obtenerCronograma"}',
            //'{"dni":"' + $("#contenido_txtCuenta").val() + '"}',
        //'{"dni":"' + $("#contenido_txtCuenta").val() + '", "CONSULTA_AJAX":"listarDirecciones"}',
        //'{"objCuentaBE":"' +'hh'  + '"}',//,'CONSULTA_AJAX':'obtenerCronograma'//JSON.stringify(object)
        dataType: 'JSON',
        type: 'POST',
        contentType: "application/json; charset=utf-8",
        async: true,
        success: function (jsondata) {
            if (jsondata.d.length > 0) {
                $("#divConvenio").show();
                if (rol == 1 || rol == 2 || rol == 3) $("#divBotonesCronograma").show();
                var htmlText = "";
                $("#tblCronograma tbody").empty();
                $.each(jsondata.d, function (i, obj) {
                    htmlText = "<tr>"
                            + "<td>" + obj.NRO_CUOTA + "</td>"
                            + "<td>" + obj.FEC_VENCIMIENTO + "</td>"
                            + "<td>" + obj.DIC_SIMBOLO + " " + obj.IMP_CUOTA + "</td>"
                            + "<td>" + ((rol != 1 && rol != 2 && rol != 3) || Number(obj.FLG_PAGO) ? obj.FLG_ESTADO_PAGO : "<input type='checkbox' class='form-cronograma' id='rdCompromiso_" + obj.CRO_CODIGO + "' onclick='habilitarDatosPago(" + obj.CRO_CODIGO + ");'/>" +
                                " <span id='lblComprEstado_" + obj.CRO_CODIGO + "'>PENDIENTE</span>") + "</td>"
                            + "<td>" + ((rol != 1 && rol != 2 && rol != 3) || Number(obj.FLG_PAGO) ? (obj.PAG_MONTO == '.00' ? '' : obj.PAG_MONTO) : "<input type='text' id='txtComprMonto_" + obj.CRO_CODIGO + "' class='form-control' disabled='true'/>") + "</td>"
                            + "<td>" + ((rol != 1 && rol != 2 && rol != 3) || Number(obj.FLG_PAGO) ? (obj.PAG_FECHA == null ? '' : obj.PAG_FECHA) : "<input type='text' id='txtComprFecha_" + obj.CRO_CODIGO + "' class='form-control' disabled='true'/>") + "</td>"
                        + "</tr>";
                    $("#tblCronograma tbody").append(htmlText);
                    $("#txtComprFecha_" + obj.CRO_CODIGO).datepicker({
                        format: 'dd/mm/yyyy'
                    });
                });
            } else {
                $("#divConvenio").hide();
                $("#divBotonesCronograma").hide();
            }
        }
    });
}

function registrarCronograma() {
    var lstCronograma = new Array();
    $(".form-cronograma").each(function (i, obj) {
        if ($(obj).is(":checked")) {
            var codigo = $(obj).attr("id").replace('rdCompromiso_', '');
            var cronograma = new Object();
            cronograma.CRO_CODIGO = codigo;
            cronograma.PAG_MONTO = $("#txtComprMonto_" + codigo).val();
            cronograma.PAG_FECHA = $("#txtComprFecha_" + codigo).val();
            lstCronograma.push(cronograma);
        }
    });
    if (lstCronograma.length > 0) {
        $.ajax({
            url: strServicio + "gestion.php?actualizarCronograma=1",
            data: '{"CONSULTA_AJAX":"actualizarCronograma","lstCronograma":' + JSON.stringify(lstCronograma) + '}', //"{'lstCronograma':" + JSON.stringify(lstCronograma) + "}",//+ '", "CONSULTA_AJAX":"actualizarCronograma"}',
            dataType: 'JSON',
            type: 'POST',
            contentType: "application/json",//; charset=utf-8",
            async: true,
            success: function (jsondata) {
                if (jsondata.d == "CORRECTO") {
                    bootbox.alert("Cronograma registrado correctamente");
                    obtenerCronograma();
                } else {
                    bootbox.alert("Ocurrio un error, por favor vuelva a intentar registrar");
                }
            }
        });
    }
}

function cancelarCronograma() {
    $(".form-cronograma").each(function (i, obj) {
        var codigo = $(obj).attr("id").replace('rdCompromiso_', '');
        $(obj).removeAttr("checked");
        $("#lblComprEstado_" + codigo).text("PENDIENTE");
        $("#txtComprMonto_" + codigo).val("").attr("disabled", "disabled");
        $("#txtComprFecha_" + codigo).val("").attr("disabled", "disabled");
    });
}

function habilitarDatosPago(codigo) {
    var check = $("#rdCompromiso_" + codigo).is(":checked");
    if (check) {
        $("#lblComprEstado_" + codigo).text("REALIZO PAGO");
        $("#txtComprMonto_" + codigo).removeAttr("disabled");
        $("#txtComprFecha_" + codigo).removeAttr("disabled");
    } else {
        $("#lblComprEstado_" + codigo).text("PENDIENTE");
        $("#txtComprMonto_" + codigo).val("").attr("disabled", "disabled");
        $("#txtComprFecha_" + codigo).val("").attr("disabled", "disabled");
    }
}
