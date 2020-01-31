$(document).ready(function () {
    iniciarDatos();
    buscarSession('');
    $("#sltProveedor").change(cargarCarteras);

    $("#btn_buscar").click(function () {
        buscarSession('');
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

    $(".date-picker").datepicker({
        dateFormat: "dd/mm/yy",
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

    $("#txtNroCuenta,#txtDni,#txtCliente").keyup(function () {
        if ($("#txtNroCuenta").val() != "" || $("#txtDni").val() != "" || $("#txtCliente").val() != "") {
            $("#txtDesde").val(""); $("#txtHasta").val("");
        } else {
            cambiarPorFiltro($("#sltFiltro").val());
        }
    });

    $("#sltFiltro").change(function () {
        cambiarPorFiltro($(this).val());
    });

    function cambiarPorFiltro(valor){
        switch (valor) {
            case 'P': $("#txtDesde").val(""); $("#txtHasta").val(""); break;
            case 'N': $("#txtDesde").val(""); $("#txtHasta").val(""); break;
            case 'G': $("#txtDesde").val(obtenerFechaActual); $("#txtHasta").val(obtenerFechaActual); break;
            case 'T': $("#txtDesde").val(""); $("#txtHasta").val(""); break;
            case 'R': $("#txtDesde").val(obtenerFechaActual); $("#txtHasta").val(obtenerFechaActual); break;
        }
    }

    var recordatorio = function () {
        $.ajax({
            url: strServicio+"general.asmx/cantidadRecordatorio",
            dataType: 'JSON',
            type: 'POST',
            contentType: "application/json; charset=utf-8",
            success: function (jsondata) {
                if (jsondata.d.value > 0) {
                    $.message.Recordatorio("TAREAS", "Existen " + jsondata.d.value + " recordatorios por realizar", "/cobranza/recordatorio.aspx");
                }
            }
        });
        setTimeout(recordatorio, 120000);
    }

    recordatorio();
});

function buscarSession(orden) {
    $.ajax({
        url: strServicio+"GestionarUsuarios.asmx/ObtenerDatosSession",
        dataType: 'JSON',
        type: 'POST',
        contentType: "application/json; charset=utf-8",
        async: false,
        success: function (jsondata) {
            //console.log(jsondata);
            if (jsondata.d == null) {
                $.fancybox({
                    type: "iframe",
                    width: 500,
                    height: 420,
                    scrolling: 'no',
                    modal: true,
                    href: "login.aspx"
                });
            } else {
                buscar(orden);
            }
        }
    });
}

function buscar(orden) {
    //bootbox.alert(orden);
    //fancyPreload();
    var criterio = new Object();
    criterio.NroCuenta = $("#txtNroCuenta").val();
    criterio.Dni = $("#txtDni").val();
    criterio.Cliente = $("#txtCliente").val();
    criterio.IdProveedor = $("#sltProveedor").val();
    criterio.IdCartera = $("#sltCartera").val();
    if ($("#sltDistrito").val() != "0") {
        criterio.IdUbigeo = $("#sltDistrito").val();
    } else if ($("#sltProvincia").val() != "0") {
        criterio.IdUbigeo = $("#sltDepartamento").val()+$("#sltProvincia").val();
    } else if ($("#sltDepartamento").val() != "0") {
        criterio.IdUbigeo = $("#sltDepartamento").val();
    } else {
        criterio.IdUbigeo = "0";
    }
    criterio.orden = orden;
    criterio.Todos = $("#sltFiltro").val();//($("#Checkbox1:checked").val()=="G"?"":"T");
    criterio.desde = $("#txtDesde").val();
    criterio.hasta = $("#txtHasta").val();
    $.ajax({
        url: strServicio+"cartera.asmx/cargarGridClientes",
        data: '{"criterio":' + JSON.stringify(criterio) + '}',
        dataType: 'JSON',
        type: 'POST',
        contentType: "application/json; charset=utf-8",
        success: function (jsondata) {
            //fancyPreloadClose();
            console.log(jsondata.d);
            $("#tblLista tbody").empty();
            if (jsondata.d.length > 0) {
                var htmlText = "";
                $("#txtCantRegistros").html(jsondata.d[0].CANT_TOTAL + " REGISTROS SELECCIONADOS");
                $.each(jsondata.d, function (i, obj) {
                    htmlText = "<tr" + (i % 2 == 0 ? " class='row_listabandejavirtual'" : "") +
                        (obj.FL_PAGO == "1" ? " style='background-color:rgba(96, 232, 51, 0.49);'" : (obj.FL_COMPROMISO == "1" ? " style='background-color:rgba(242, 245, 66, 0.77);'" : "")) + ">" +
                        "<td>" + (obj.SEM_COLOR != "" ? "<img src='resource/img/semaforo/" + obj.SEM_COLOR + ".png'/>" : "") + "</td>" +
                        "<td><a href='gestionar-cuenta.aspx?cuenta=" + obj.CUE_NROCUENTA + "'>" + obj.CUE_NROCUENTA + "</a></td>" +
                        "<td><span>" + obj.PRV_NOMBRES + "</span></td>" +
                        "<td><span>" + obj.CAR_DESCRIPCION + "</span></td>" +
                        "<td><span>" + obj.SCA_DESCRIPCION + "</span></td>" +
                        "<td><span>" + obj.CLI_DOCUMENTO_IDENTIDAD + "</span></td>" +
                        "<td><a onclick='historial(\"" + obj.CUE_NROCUENTA + "\");'>" + obj.CLI_NOMBRE_COMPLETO + "</a>" +
                            (obj.FG_NUEVO_TELEFONO == 'T' ? "<img src='resource/img/icons/alerta_telefono.gif' title='Tiene nuevo telefono'/>" : "") +
                        "</td>" +
                        "<td><span>" + obj.CUE_ULTIMA_COND + "</span></td>" +
                        "<td><span>" + obj.CUE_FECHA_COND + "</span></td>" +
                        "<td><span>" + obj.UBI_DISTRITO + "</span></td>" +
                        "<td><span>" + obj.CAPITAL + "</span></td>" +
                        "<td><span>" + obj.SALDO + "</span></td>" +
                        "<td><span>" + obj.CUE_ULTIMA_GESTION + "</span></td>" +
                        "<td><span>" + obj.BAD_DIAS_MORA + "</span></td>" +
                        "<td><span class='" + obj.SEM_COLOR + "' style='font-size: 18px;font-weight: bold;'>" + obj.DIAS + "</span></td>" +
                    "</tr>";
                    $("#tblLista tbody").append(htmlText);
                });
            } else {
                $("#txtCantRegistros").html("");
            }
        }
    });
}

function historial(cuenta) {
    var url = "historial.aspx?cuenta="+cuenta;
    $.fancybox({
        type: "iframe",
        width: 550,
        height: 600,
        scrolling: 'no',
        modal: true,
        href: url
    });
}

function iniciarDatos() {
    cargarProveedor();
    //cargarCarteras();
    listarDepartamento();
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
    //$.ajax({
    //    url: strServicio+"general.asmx/cargarCarteras",
    //    dataType: 'JSON',
    //    type: 'POST',
    //    contentType: "application/json; charset=utf-8",
    //    success: function (jsondata) {
    //        //$("#sltProveedor").empty();
    //        $.each(jsondata.d, function (i, obj) {
    //            $("#sltCartera").append("<option value='" + obj.value + "'>" + obj.key + "</option>");
    //        });
    //        //console.log(jsondata.d);
    //    }
    //});
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

$("#sltDepartamento").change(function () {
    listarProvincia($(this).val());
    $("#sltDistrito").html("<option value='0'>-SELECT-</option>");
});

$("#sltProvincia").change(function () { listarDistrito($("#sltDepartamento").val(), $(this).val()); });

function listarDepartamento() {
    $.ajax({
        url: strServicio+"general.asmx/listarDepartamento",
        dataType: 'JSON',
        type: 'POST',
        async: false,
        contentType: "application/json; charset=utf-8",
        success: function (jsondata) {
            //console.table(jsondata.d);
            //$("#sltDepartamento").empty();
            $.each(jsondata.d, function (i, obj) {
                $("#sltDepartamento").append("<option value='" + obj.value + "'>" + obj.key + "</option>");
            });
        }
    });
}

function listarProvincia(idDepartamento) {
    var objUbigeo = new Object();
    objUbigeo.UBI_CODIGO_DEPARTAMENTO = idDepartamento;
    $.ajax({
        url: strServicio+"general.asmx/listarProvincia",
        data: '{"objUbigeo":' + JSON.stringify(objUbigeo) + '}',
        dataType: 'JSON',
        type: 'POST',
        async: false,
        contentType: "application/json; charset=utf-8",
        success: function (jsondata) {
            //console.table(jsondata.d);
            $("#sltProvincia").empty();
            $("#sltProvincia").html("<option value='0'>-SELECT-</option>");
            $.each(jsondata.d, function (i, obj) {
                $("#sltProvincia").append("<option value='" + obj.value + "'>" + obj.key + "</option>");
            });
        }
    });
}

function listarDistrito(idDepartamento, idProvincia) {
    var objUbigeo = new Object();
    objUbigeo.UBI_CODIGO_DEPARTAMENTO = idDepartamento;
    objUbigeo.UBI_CODIGO_PROVINCIA = idProvincia;
    $.ajax({
        url: strServicio+"general.asmx/listarDistrito",
        data: '{"objUbigeo":' + JSON.stringify(objUbigeo) + '}',
        dataType: 'JSON',
        type: 'POST',
        async: false,
        contentType: "application/json; charset=utf-8",
        success: function (jsondata) {
            console.table(jsondata.d);
            $("#sltDistrito").empty();
            $("#sltDistrito").html("<option value='0'>-SELECT-</option>");
            $.each(jsondata.d, function (i, obj) {
                $("#sltDistrito").append("<option value='" + obj.value + "'>" + obj.key + "</option>");
            });
        }
    });
}