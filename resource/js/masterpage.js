///*INICIALIZAR LA VARIABLE objPerfilUsuarioBESES - SESSION DEL USUARIO QUE SE LOGUEO*/
//var objPerfilUsuarioBESES = new Object();
//objPerfilUsuarioBESES.objUsuarioBE = new Object();
//objPerfilUsuarioBESES.objUsuarioBE.objUNegocio = new Object();
//objPerfilUsuarioBESES.objUsuarioBE.objOpInscritas = new Object();
//objPerfilUsuarioBESES.objUsuarioBE.objProcesoElectoral = new Object();
//objPerfilUsuarioBESES.objUNegocioAplicativo = new Object();
//objPerfilUsuarioBESES.objUNegocioAplicativo.objAplicativoBE = new Object();
//objPerfilUsuarioBESES.objPerfilBE = new Object();

///*INICIALIZAR LA VARIABLE objPerfilUsuarioBESES - SESSION DEL USUARIO QUE SE LOGUEO*/
//var objUsuarioBE = new Object();

//var objMenuBE = new Object();
//objMenuBE.objAplicativoBE = new Object();

var strServicio = $("#rutaWeb").val() + 'resource/service/';
var strPath = $("#rutaWeb").val();
$(document).ready(function () {

    $('.btnCerrarSesion').click(function (e) {
        EliminarSesiones(1);
        e.preventDefault();
    });

    function ObtenerDatosSesion() {
        $.ajax({
            url: strServicio + "GestionarUsuarios.asmx/ObtenerDatosSession",
            data: '',
            dataType: "json",
            type: "POST",
            //async: false,
            contentType: "application/json; charset=utf-8",
            success: function (jsondata) {
                //console.log(jsondata.d);
                var str = '';
                if (jsondata.d) {
                    if (jsondata.d.USU_CODIGO === undefined || jsondata.d.USU_CODIGO == "" || jsondata.d.USU_CODIGO == "0") {
                        bootbox.alert("Información: Su sesión ha caducado, por favor ingrese nuevamente.");
                        location.href = strPath + 'index.aspx';
                        return;
                    }
                    ValidarAccesoPagina();
                }
                else {
                    bootbox.alert("Información: Su sesión ha caducado, por favor ingrese nuevamente.", function (answer) {
                        location.href = strPath + 'index.aspx';
                        //if (!answer) return;
                        //else {
                        //    location.href = strPath + 'index.aspx';
                        //}
                    });
                }
            },
            error: function (xhr, status, error) {
                $("#divAlert").dialog('open');
                $("#spnAlert").empty().html(xhr.responseText);
            }
        });
    }
    //ObtenerDatosSesion();

    /*VALIDAR SI EL USUARIO TIENE PERMISOS PARA LA PAGINA QUE INGRESA.*/
    function ValidarAccesoPagina() {

        $.ajax({
            url: strServicio + "menu.asmx/ObtenerMenuAplicativoPerfilSesion",
            data: '',
            dataType: "json",
            type: "POST",
            contentType: "application/json; charset=utf-8",
            success: function (jsondata) {
                //console.log(jsondata.d);
                //var strPermiso = '0';
                //var strMenuActual = ObtenerPaginaUrl(location.href);
                if (jsondata.d) {
                    if (jsondata.d.length < 1) {
                        location.href = strPath + "index.aspx";
                    }
                } else {
                    location.href = strPath + "index.aspx";
                }
                //if (jsondata.d) {
                //    $.each(jsondata.d, function (i, item) {
                //        var strMenuOpcion = ObtenerPaginaUrl(item.strUrlMenu);
                //        //console.log(strMenuOpcion + " ==> " + strMenuActual);
                //        if ($.trim(strMenuActual.toUpperCase()).indexOf($.trim(strMenuOpcion.toUpperCase()))>-1) { strPermiso = '1'; }
                //        if ($.trim(strMenuActual.toUpperCase()) == $.trim(strMenuOpcion.toUpperCase().replace("PAGES\\", ""))) { strPermiso = '1'; }
                //    });

                //    if (strPermiso == '0') {
                //        bootbox.alertError("Validación: Usted no tiene permisos para acceder a esta pagina.", "Estudio Galicia S.A.C.", function (answer) {
                //            if (!answer) return;
                //            else {
                //                location.href = strPath + "index.aspx";
                //            }
                //        });
                //        EliminarSesiones('0');
                //        return;
                //    }
                //}
                //else {
                //    bootbox.alert("Información: Su sesión ha caducado, por favor ingrese nuevamente.", "Sesión Caducada", function (answer) {
                //        if (!answer) return;
                //        else {
                //            location.href = strPath + 'index.aspx';
                //        }
                //    });
                //}
            },
            error: function (xhr, status, error) {
                $("#divAlert").dialog('open');
                $("#spnAlert").empty().html(xhr.responseText);
            }
        });

    }

    //no cargar los datos del notificador cuando es gestion predictiva/progresiva
    if (!document.getElementById('progresivo_flag')) {
        obtenerNotificacion();
    }
});               /*************************************** FIN: DOCUMENT.READY ***************************************/

function obtenerNotificacion() {
    $.ajax({
        url: strServicio + "general.asmx/obtenerNotificador",
        dataType: "json",
        type: "POST",
        contentType: "application/json; charset=utf-8",
        success: function (jsondata) {
            console.log(jsondata.d);
            $.each(jsondata.d, function (i, obj) {
                if (obj.TIPO == 1) {
                    $("#txt_cant_recordatorio").text(obj.CANTIDAD);
                    $("#txt_cant_recordatorios").text(obj.CANTIDAD + " recordatorios");
                    var html_text = "<li><a href='gestionar-cuenta.aspx?cuenta=" + obj.NRO_CUENTA + "'>" +
                            "<span class='time'>" + obj.FECHA + "<br/>" + obj.HORA + "</span>" +
                            "<span class='details'>" +
                                "<span class='label label-sm label-icon label-success'>" +
                                    "<i class='fa fa-clock-o'></i>" +
                                "</span>" + obj.NRO_CUENTA + "<br/>" + obj.NOMBRES + "</span>" +
                        "</a></li>";
                    $("#lst_recordatorio").append(html_text);
                } else if (obj.TIPO == 2) {
                    $("#txt_cant_compromiso").text(obj.CANTIDAD);
                    $("#txt_cant_compromisos").text(obj.CANTIDAD + " compromisos");
                    var html_text = "<li>" +
                            "<a href='gestionar-cuenta.aspx?cuenta=" + obj.NRO_CUENTA + "'>" +
                                "<span class='task'>" +
                                    "<span class='desc'>" + obj.NRO_CUENTA + "</span>" +
                                    "<span class='percent'>" + obj.FECHA + "</span>" +
                                "</span>" +
                                "<span class='details'>" +
                                "<span class='label label-sm label-icon label-success'>" +
                                    "<i class='fa fa-money'></i>" +
                                "</span>" + obj.NOMBRES + "</span>" +
                            "</a>" +
                        "</li>";
                    $("#lst_compromiso").append(html_text);
                }else if (obj.TIPO == 3) {
                    $("#txt_cant_convenio").text(obj.CANTIDAD);
                    $("#txt_cant_convenios").text(obj.CANTIDAD + " convenio");
                    var html_text="<li>" +
                            "<a href='gestionar-cuenta.aspx?cuenta=" + obj.NRO_CUENTA + "'>" +
                                "<span class='task'>" +
                                    "<span class='desc'>" + obj.NRO_CUENTA + "</span>" +
                                    "<span class='percent'>" + obj.FECHA + "</span>" +
                                "</span>" +
                                "<span class='details'>" +
                                "<span class='label label-sm label-icon label-success'>" +
                                    "<i class='fa fa-money'></i>" +
                                "</span>" + obj.NOMBRES + "</span>" +
                            "</a>" +
                        "</li>";
                    $("#lst_convenio").append(html_text);
                }
            });
        },
        error: function (xhr, status, error) {
        }
    });
}

function EliminarSesiones(strRedireccionar) {
    if (strRedireccionar == '1') {
        bootbox.confirm("¿Esta seguro que desea salir del sistema?", function (answer) {
            if (!answer) return;
            else {
              location.href = 'logout.php';
                // $.ajax({
                //     url: strServicio + "menu.asmx/EliminarSesiones",
                //     data: '',
                //     dataType: "json",
                //     type: "POST",
                //     contentType: "application/json; charset=utf-8",
                //     success: function (jsondata) {
                //         if (jsondata.d) {
                //             if (strRedireccionar == '0') { return false; }
                //             location.href = strPath + 'index.aspx';
                //             return false;
                //         }
                //     },
                //     error: function (xhr, status, error) {
                //         $("#divAlert").dialog('open');
                //         $("#spnAlert").empty().html(xhr.responseText);
                //     }
                // });
            }
        });
        return false;
    }
    $.ajax({
        url: strServicio + "menu.asmx/EliminarSesiones",
        data: '',
        dataType: "json",
        type: "POST",
        contentType: "application/json; charset=utf-8",
        success: function (jsondata) {
            if (jsondata.d) {
                if (strRedireccionar == '0') { return false; }
                location.href = strPath + 'index.aspx';
                return false;
            }
        },
        error: function (xhr, status, error) {
            $("#divAlert").dialog('open');
            $("#spnAlert").empty().html(xhr.responseText);
        }
    });
    return false;
}

function ObtenerPaginaUrl(strMenuParametro) {
    var url = strMenuParametro;
    var strContextoUrl = url.split("?")[0].split('/');
    return strContextoUrl[strContextoUrl.length - 1];
}

function ValidarEstadoUsuario() {

    $.ajax({
        url: strServicio + "GestionarUsuarios.asmx/ValidarEstadoUsuario",
        data: '{"objUsuarioBE":' + JSON.stringify(objUsuarioBE) + '}',
        dataType: "json",
        type: "POST",
        contentType: "application/json; charset=utf-8",
        success: function (jsondata) {
            var str = '';
            if (jsondata.d) {
                if ($.trim(jsondata.d.strMensajeValidacion.length) > 0 ) {
                    bootbox.alert(jsondata.d.strMensajeValidacion, function (answer) {
                        if (!answer) return;
                        else {
                            location.href = strPath + 'index.aspx';
                        }
                    });
                    return;
                }
            }
            else {
                bootbox.alert("Información: Su sesión ha caducado, por favor ingrese nuevamente.", function (answer) {
                    if (!answer) return;
                    else {
                        location.href = strPath + 'index.aspx';
                    }
                });
            }
        },
        error: function (xhr, status, error) {
            $("#divAlert").dialog('open');
            $("#spnAlert").empty().html(xhr.responseText);
        }
    });
}

function AbrirManual() {
    window.open($("#rutaWeb").val() + '04DOCUMENTOS/Manual.pdf', 'mywindow', 'toolbar=yes, location=yes,directories=yes,status=yes,menubar=yes,scrollbars=yes,copyhistory=yes, resizable=yes');
    return false;
}
