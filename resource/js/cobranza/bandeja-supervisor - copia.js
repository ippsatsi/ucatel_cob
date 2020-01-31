$(document).ready(function () {
    iniciarDatos();
   // buscar();

    $("#chk_semanal").click(function () {
        $(".gestiones_diarias").hide();
        $(".gestiones_mes").fadeIn('slow');
    });

    $("#sltProveedor").change(cargarCarteras);
    $("#sltCartera").change(cargarSubCarteras);

    $("#btn_buscar").click(function () {
        buscar();
    });

    $("#btn_limpiar").click(function () {
        $("#sltProveedor").val("0");
        $("#sltCartera").val("0");
        $("#sltSubCartera").val("0");
        $("#txtUbigeo").val(""); 
        $("#sltUsuario").val("0");
        $("#txtNroCuenta").val("");
        $("#txtDni").val("");
        $("#txtCliente").val("");
        $("#txtDesde").val("");
        $("#txtHasta").val("");
        $("#sltFiltro").val("P");
        $(".btn-default").removeAttr("active");
        buscar();
    });

    $("#btn_buscar_telefono").click(function () {
        $.fancybox({
            type: "iframe",
            width: 600,
            height: 450,
            scrolling: 'no',
            modal: false,
            href: "buscar-telefono.aspx"
        });
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
        format: "dd/mm/yyyy"//,
        //firstDay: 1,
        //dayNamesMin: ["Do", "Lu", "Ma", "Mi", "Ju", "Vi", "Sa"],
        //dayNamesShort: ["Dom", "Lun", "Mar", "Mie", "Jue", "Vie", "Sab"],
        //monthNames:
        //    ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio",
        //    "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"],
        //monthNamesShort:
        //    ["Ene", "Feb", "Mar", "Abr", "May", "Jun",
        //    "Jul", "Ago", "Sep", "Oct", "Nov", "Dic"]
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
            case 'T': $("#txtDesde").val(""); $("#txtHasta").val(""); break; //$("#txtDesde").val(obtenerFechaActual); $("#txtHasta").val(obtenerFechaActual); break;
            case 'R': $("#txtDesde").val(obtenerFechaActual); $("#txtHasta").val(obtenerFechaActual); break;
        }
    }
});

function buscar() {
    abrir_preload('div_contenido');
    if (typeof table != 'undefined') {
        table.destroy();
    }

    table = $('.tblLista').DataTable({
        "filter": false,
        "language": {
            "sProcessing": "Procesando...",
            "sLengthMenu": "Mostrar _MENU_ cuentas",
            "sZeroRecords": "No se encontraron resultados",
            "sEmptyTable": "Ningún dato disponible en esta tabla",
            //"sInfo": "Mostrando cuentas del _START_ al _END_ de un total de _TOTAL_ cuentas",
            "sInfo": "Total: _TOTAL_ cuentas",
            "sInfoEmpty": "Mostrando cuentas del 0 al 0 de un total de 0 cuentas",
            "sInfoFiltered": "(filtrado de un total de _MAX_ cuentas)",
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
            }, "oAria": {
                "sSortAscending": ": Activar para ordenar la columna de manera ascendente",
                "sSortDescending": ": Activar para ordenar la columna de manera descendente"
            },
        },
        "bLengthChange": false,
        "responsive": true,
        "order": [[0, "asc"]],
        "info": true,
        "scrollCollapse": false,
        "pageLength": 10,
        "bProcessing": true,
        "bServerSide": true,
        "columnDefs": [{ orderable: false }], //, targets: [1,2] }],
        "sAjaxSource": strServicio + "cartera.asmx/cargarBandejaSupervisor",
        "fnServerData": function (sSource, aoData, fnCallback) {
            aoData.push({ "name": "NRO_CUENTA", "value": $("#txtNroCuenta").val() });
            aoData.push({ "name": "PERIODO", "value": $("#sltPeriodo").val() });
            aoData.push({ "name": "DNI", "value": $("#txtDni").val() });
            aoData.push({ "name": "CLIENTE", "value": $("#txtCliente").val() });
            aoData.push({ "name": "PROVEEDOR", "value": $("#sltProveedor").val() });
            aoData.push({ "name": "CARTERA", "value": $("#sltCartera").val() });
            aoData.push({ "name": "SUBCARTERA", "value": $("#sltSubCartera").val() });
            aoData.push({ "name": "UBIGEO", "value": $("#txtUbigeo").val() });
            aoData.push({ "name": "USUARIO", "value": $("#sltUsuario").val() });
            aoData.push({ "name": "FILTRO", "value": $("#sltFiltro").val() });
            aoData.push({ "name": "FEC_DESDE", "value": $("#txtDesde").val() });
            aoData.push({ "name": "FEC_HASTA", "value": $("#txtHasta").val() });
            aoData.push({ "name": "FL_CD", "value": $("#chkConDir").is(":checked") ? "1" : "0" });
            aoData.push({ "name": "FL_CI", "value": $("#chkConInd").is(":checked") ? "1" : "0" });
            aoData.push({ "name": "FL_NC", "value": $("#chkNoCont").is(":checked") ? "1" : "0" });
            aoData.push({ "name": "FL_SG", "value": $("#chkNoGest").is(":checked") ? "1" : "0" });
            $.ajax({
                "dataType": 'json',
                "contentType": "application/json; charset=utf-8",
                "type": "GET",
                "url": sSource,
                "data": aoData,
                "success": function (json) {
                    cerrar_preload('div_contenido');
                    console.log(json.d);
                    fnCallback(json.d);
                }
            });
        }
    });
}

function abrir_gestion_cuenta(cuenta,pago,compromiso,estado) {
    //target='_blank' href='gestionar-cuenta.aspx?cuenta=" + row["CUE_NROCUENTA"] + "'
    var url = "gestionar-cuenta.aspx?cuenta=" + cuenta;

    if (estado == "C") {
        //bootbox.alert("PAGO CANCELACION/AJUSTE");
        //window.open(url, "GESTIONAR CUENTA");
        //return false;
        bootbox.confirm("Esta cuenta ya tiene un pago de Cancelacion Total ¿Esta seguro que desea gestionarla?", function (r) {
            if (r) {
                window.open(url, "GESTIONAR CUENTA");
            }
        });
        return false;
    }
    if (pago > 0) {
        bootbox.confirm("Esta cuenta ya tiene un pago ¿Esta seguro que desea gestionarla?", function (r) {
            if (r) {
                window.open(url, "GESTIONAR CUENTA");
            }
        });
    } else if (compromiso > 0) {
        bootbox.confirm("Esta cuenta ya tiene un compromiso ¿Esta seguro que desea gestionarla?", function (r) {
            if (r) {
                window.open(url, "GESTIONAR CUENTA");
            }
        });
    } else {
        window.open(url, "GESTIONAR CUENTA");
    }
    
}

function historial(cuenta) {
    var url = "historial.aspx?cuenta="+cuenta;
    $.fancybox({
        type: "iframe",
        width: 550,
        height: 600,
        scrolling: 'yes',
        modal: false,
        href: url
    });
}

function iniciarDatos() {
    cargarProveedor();
    //listarDepartamento();
    cargarUsuarios();

    var rol = $("#contenido_txt_rol_codigo").val();
    var html_text = "<option value='P'>ASIGNADOS</option>" +
                "<option value='G'>GESTIONADOS</option>" +
                "<option value='N' "+ (rol == "4" || rol == "5" ? "selected":"")+">NO GESTIONADOS</option>" +
                (rol != "4" && rol != "5" ? "<option value='T'>TODOS</option>" : "") +
                "<option value='R'>RETIRADOS</option>";
    $("#sltFiltro").append(html_text);
}

function cargarUsuarios() {
    $.ajax({
        url: strServicio + "general.asmx/listarUsuariosAsigCall",
        dataType: 'JSON',
        type: 'POST',
        contentType: "application/json; charset=utf-8",
        success: function (jsondata) {
            //$("#sltProveedor").empty();
            $.each(jsondata.d, function (i, obj) {
                $("#sltUsuario").append("<option value='" + obj.value + "'>" + obj.key + "</option>");
            });
            //console.log(jsondata.d);
        }
    });
}

function cargarProveedor() {
    $.ajax({
        url: strServicio + "general.asmx/cargarProveedor",
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
        url: strServicio + "general.asmx/cargarCarteras",
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
        url: strServicio + "general.asmx/cargarSubCarteras",
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