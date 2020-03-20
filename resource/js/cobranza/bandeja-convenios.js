$(document).ready(function () {
    $("#txtDesde").val(obtenerFechaActual);
    $("#txtHasta").val(obtenerFechaActual);
    $("#btn_imprimir").click(imprimirConvenio);

  //  buscar();
    $("#btn_buscar").click(buscar);

    $("#sltEstado").change(function () {
        if ($(this).val() == 1) {
            $("#txtDesde").val(obtenerFechaActual);
            $("#txtHasta").val(obtenerFechaActual);
        } else {
            $("#txtDesde").val(obtenerFechaActual);
            $("#txtHasta").val(obtenerFechaActual);
        }
    });

    $(".date-picker").datepicker({
        format: "dd/mm/yyyy",
        firstDay: 1,
        dayNamesMin: ["Do", "Lu", "Ma", "Mi", "Ju", "Vi", "Sa"],
        dayNamesShort: ["Dom", "Lun", "Mar", "Mie", "Jue", "Vie", "Sab"],
        monthNames:
            ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio",
            "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"],
        monthNamesShort:
            ["Ene", "Feb", "Mar", "Abr", "May", "Jun",
            "Jul", "Ago", "Sep", "Oct", "Nov", "Dic"]
    });

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
});

function imprimirConvenio() {
    var url = "../reporte/reporte-convenio.aspx?strCuenta=" + $("#txtCuenta").val() +
        "&strDni=" + $("#txtDNI").val() + "&strNombreCliente=" + $("#txtCliente").val() + "&strFecha=" + $("#sltFecha").val() +
        "&strFechaDesde=" + $("#txtDesde").val().replace("/", "$").replace("/", "$") + "&strFechaHasta=" + $("#txtHasta").val().replace("/", "$").replace("/", "$") +
        "&sltEstado=" + $("#sltEstado").val().replace("/", "$").replace("/", "$");
    window.location = url;
}

function buscar() {
    abrir_preload('div_contenido');

    $('#tblLista').dataTable().fnClearTable();
    $('#tblLista').dataTable().fnDraw();
    $('#tblLista').dataTable().fnDestroy();

    var criterio = new Object();
    criterio.NroCuenta = $("#txtCuenta").val();
    criterio.Dni = $("#txtDNI").val();
    criterio.Cliente = $("#txtCliente").val();
    criterio.Todos = $("#sltFecha").val();
    criterio.desde = $("#txtDesde").val();
    criterio.hasta = $("#txtHasta").val();
    criterio.Estado = $("#sltEstado").val();
    $.ajax({
        url: strServicio + "cartera.php?CONSULTA_AJAX=bandejaConvenios",  //strServicio + "cartera.asmx/bandejaConvenios",
        data: '{"criterio":' + JSON.stringify(criterio) + '}',
        dataType: 'JSON',
        type: 'POST',
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            //console.log(JSON.parse(data.d));
            //console.log(data.d.length);
            cerrar_preload('div_contenido');
            //if (data.d.length == 0) {
            //    $("#txtCantRegistros").html("0 REGISTROS ENCONTRADOS");
            //} else {
            //    $("#txtCantRegistros").html(data.d[0].CANT_TOTAL + " REGISTROS ENCONTRADOS");
            //}
            $('#tblLista').dataTable({
                "aaData": data.d,//JSON.parse(data.d),
                "sPaginationType": "full_numbers",
                //"aaSorting": [[1, 'desc']],
                "bLengthChange": false,
                "bFilter": false,
                "bInfo": false,
                "oLanguage": {
                    "sEmptyTable": "No hay registros encontrados."
                },
                "fnDrawCallback": function (oSettings, json) {
                    var tamanoVentana = $(window).height();
                    var cantidadFilas = 0;
                    if (tamanoVentana < 680) { cantidadFilas = 3; }
                    else if (tamanoVentana > 680 && tamanoVentana < 860) { cantidadFilas = 6; }

                    if ($('#tblLista').dataTable().fnGetData().length >= cantidadFilas) {
                        $('#id_footer').css("bottom", "inherit");
                        $('#id_footer').css("margin-top", "80px");
                    }
                    else {
                        $('#id_footer').css("bottom", "0");
                        $('#id_footer').css("margin-top", "0px");
                    }

                },
                "aoColumns": [
                    {
                        mData: "CUE_NROCUENTA", "bSortable": true, mRender: function (data, type, row) {
                            //var htmlText = "<a target='_blank' href='gestionar-cuenta.aspx?cuenta=" + row["CUE_NROCUENTA"] + "'>" + row["CUE_NROCUENTA"] + "</a>";row["FLG_TIENE_CONVENIO"]
                            var htmlText = "<a onclick='abrir_gestion_cuenta(\"" + row["CUE_NROCUENTA"] + "\"," + row["FLG_PAGO"] + ");'>" + row["CUE_NROCUENTA"] + "</a>";
                            return htmlText;
                        }
                    },
                    { mData: "PRV_NOMBRES", "bSortable": true },
                    { mData: "CAR_DESCRIPCION", "bSortable": true },
                    { mData: "SCA_DESCRIPCION", "bSortable": true },
                    { mData: "CLI_DOCUMENTO_IDENTIDAD", "bSortable": true },
                    {
                        mData: "CLI_NOMBRE_COMPLETO", "bSortable": true, mRender: function (data, type, row) {
                            var htmlText = "";
                            if (row["FLG_PAGO"] == true) { htmlText += "<img src='../resource/img/icons/img_pago.png'/><span class='span-pago'> PAGO</span><br/>" };
                            return "<a>" + row["CLI_NOMBRE_COMPLETO"] + "</a><br/>" + htmlText;
                        }
                    },
                    //{ mData: "CLI_DIRECCION_PARTICULAR", "bSortable": true },
                    //{ mData: "UBI_DEPARTAMENTO", "bSortable": true },
                    //{ mData: "UBI_DISTRITO", "bSortable": true },
                    //{ mData: "UBI_PROVINCIA", "bSortable": true },
                    //{ mData: "FLG_TIENE_CONVENIO", "bSortable": true },
                    { mData: "DIC_SIMBOLO", "bSortable": true },
                    //{ mData: "GES_IMPORTE_NEGOCIACION", "bSortable": true },
                    {
                        mData: "GES_IMPORTE_NEGOCIACION", "bSortable": true, mRender: function (data, type, row) {
                          return Number(row['GES_IMPORTE_NEGOCIACION']);
                        }
                    },
                    { mData: "CUE_CONVENIO_FECHA_INI", "bSortable": true },
                    //{ mData: "CUE_CONVENIO_CUOTA_INI", "bSortable": true },
                    {
                        mData: "CUE_CONVENIO_CUOTA_INI", "bSortable": true, mRender: function (data, type, row) {
                          return Number(row['CUE_CONVENIO_CUOTA_INI']);
                        }
                    },
                    { mData: "CUE_CONVENIO_CUOTAS", "bSortable": true },
                    { mData: "CUE_CUOTAS_PAGADAS", "bSortable": true },
                    { mData: "FEC_VENCIMIENTO", "bSortable": true },
                    { mData: "NRO_CUOTA", "bSortable": true },
                  //  { mData: "IMP_CUOTA", "bSortable": true },
                    {
                        mData: "IMP_CUOTA", "bSortable": true, mRender: function (data, type, row) {
                          return Number(row['IMP_CUOTA']);
                        }
                    },
                    {
                        mData: "FLG_PAGO", "bSortable": true, mRender: function (data, type, row) {
                            var htmlText = "PENDIENTE DE PAGO";
                            if (row["FLG_PAGO"] == true) {
                                htmlText ="PAGO REALIZADO"
                            }
                            return htmlText;
                        }
                    },
                    //{ mData: "PAG_MONTO", "bSortable": true },
                    {
                        mData: "PAG_MONTO", "bSortable": true, mRender: function (data, type, row) {
                          return Number(row['PAG_MONTO']);
                        }
                    },
                    { mData: "PAG_FECHA", "bSortable": true },
                    { mData: "USU_LOGIN", "bSortable": true },
                    { mData: "TXT_MOTIVO_CONVENIO", "bSortable": true },
                    {
                        mData: "CUE_CODIGO", "bSortable": true, mRender: function (data, type, row) {
                            //var htmlText = "<a target='_blank' href='gestionar-cuenta.aspx?cuenta=" + row["CUE_NROCUENTA"] + "'>" + row["CUE_NROCUENTA"] + "</a>";row["FLG_TIENE_CONVENIO"]
                            var htmlText = "";
                            if (row["FLG_ESTADO"] == true) {
                                htmlText = "<input type='button' class='form-control btn blue' value='ANULAR CONVENIO' onclick='anular_convenio(\"" + row["CUE_CODIGO"] + "\");'>";
                            }
                            return htmlText;
                        }
                    }
                ]
            });
        }
    });
}

function abrir_gestion_cuenta(cuenta, pago) {
    //target='_blank' href='gestionar-cuenta.aspx?cuenta=" + row["CUE_NROCUENTA"] + "'
    var url = "gestionar-cuenta.php?cuenta=" + cuenta;

    if (pago > 0) {
        bootbox.confirm("Esta cuenta ya tiene un PAGO ¿Esta seguro que desea gestionarla?", function (r) {
            if (r) {
                window.open(url, "GESTIONAR CUENTA");
            }
        });
    } else {
        window.open(url, "GESTIONAR CUENTA");
    }

}

function anular_convenio(codigo) {
//    bootbox.prompt('¿Desea dejar el Convenio sin efecto?:', function (r) {
    bootbox.prompt({
         size:"large",
         placeholder:"maximo 50 caracteres",
         maxlength:50,
         title:'¿Desea dejar el Convenio sin efecto?:', callback:function (r) {
/// agregar limite de 50 caracteres 29.01.18
        if (r) {
            $.ajax({
                url: strServicio + "gestion.php?inactivarConvenio=1",
                data: '{"id_cuenta":"' + codigo + '","txt_motivo":"' + r + '", "CONSULTA_AJAX":"inactivarConvenio"}',
                dataType: 'JSON',
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    if (data.d  >  0) {
                        buscar();
                        bootbox.alert("Inactivación de cuenta realizado correctamente.");
                    } else {
                        bootbox.alert("Ocurrio un error por favor vuelva a intentar.");
                    }
                }
            });
        };
    }});
}
