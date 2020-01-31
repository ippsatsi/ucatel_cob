/// <reference path="jquery-1.8.3.js" />
/*INICIALIZAR LA VARIABLE objPerfilUsuarioBE*/
var objPerfilUsuarioBE = new Object();
objPerfilUsuarioBE.objUsuarioBE = new Object();
objPerfilUsuarioBE.objUsuarioBE.strCodigoUsuario = "";
objPerfilUsuarioBE.objUsuarioBE.intEstado = 0;
objPerfilUsuarioBE.objPerfilBE = new Object();

/*INICIALIZAR LA VARIABLE objPerfilUsuarioBESES - SESSION DEL USUARIO QUE SE LOGUEO*/
var objPerfilUsuarioBESES = new Object();
objPerfilUsuarioBESES.objUsuarioBE = new Object();
objPerfilUsuarioBESES.objUsuarioBE.objUNegocio = new Object();
objPerfilUsuarioBESES.objUsuarioBE.objProcesoElectoral = new Object();
objPerfilUsuarioBESES.objUNegocioAplicativo = new Object();
objPerfilUsuarioBESES.objUNegocioAplicativo.objAplicativoBE = new Object();
objPerfilUsuarioBESES.objPerfilBE = new Object();

var strServicio = 'resource/service/';
$(document).ready(function () {

    $('#codigo').realperson({ regenerate: 'Intentar con otro' });
    $('input, textarea').placeholder();
    $('#user').focus();

    //$('#codigo').key

    $('#user,#password,#codigo').keypress(function (e) {
        if (e.which == 13) {
            $("#btnAceptar").trigger('click');
        }
    });

    $("#btnAceptar").click(ValidarLogin);
    EliminarSesiones('0');
    $('.preload').hide();//AFAC
    //MostrarPopUp();
    function ValidarLogin() {

        $('.preload').show();

        objPerfilUsuarioBE.objUsuarioBE.strCodigoUsuario = $("#user").val();
        objPerfilUsuarioBE.objUsuarioBE.strClaveUsuario = $("#password").val();
        objPerfilUsuarioBE.objUsuarioBE.intEstado = 1;


        if ($("#user").val() == '') {
            bootbox.alert("Por favor, ingresar el nombre de usuario.", function (e) {
                $('.preload').hide();
                $('.btnLogin').button("enable");
                $("#user").focus();
            }); return;
        }
        if ($("#password").val() == '') {
            bootbox.alert("Por favor, ingrese su contraseña.", function (e) {
                $('.preload').hide();
                $('.btnLogin').button("enable");
                $("#password").focus();
            }); return;
        }
        if ($("#codigo").val() == '') {
            bootbox.alert("Por favor, ingresar el c&oacute;digo de seguridad.", function (e) {
                $('.preload').hide();
                $('.btnLogin').button("enable");
                $("#codigo").focus();
            }); return;
        }

        $.post("resource/utils/captcha/comparar.aspx", { 'codigo': $('#codigo').val(), 'captcha': $('.realperson-hash').val() }, function (data) {
            if (data == 1) {
                $.ajax({
                    url: strServicio + "GestionarUsuarios.asmx/ValidarUsuarioContrasena",
                    data: '{"objPerfilUsuarioBE":' + JSON.stringify(objPerfilUsuarioBE) + ', "intInsertaLog": "1"}',
                    dataType: "json",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    success: function (jsondata) {
                        var str = '';
                        console.log(jsondata.d);
                        if (jsondata.d) {
                            if (jsondata.d.objUsuarioBE.intIdUsuario === undefined || jsondata.d.objUsuarioBE.intIdUsuario == 0) {
                                bootbox.alert("Error: La información ingresada es incorrecta.", "Error en el ingreso de información", function (e) {
                                    $('.preload').hide();
                                    $('.btnLogin').button("enable");
                                });
                                return false;
                            }
                            if (jsondata.d.objUsuarioBE.intEstado != objPerfilUsuarioBE.objUsuarioBE.intEstado) {
                                bootbox.alert(jsondata.d.objUsuarioBE.strMensajeValidacion, "Información de usuario", function (e) {
                                    $('.preload').hide();
                                    $('.btnLogin').button("enable");
                                });
                                return false;
                            }
                            objPerfilUsuarioBE.objPerfilBE.intIdPerfil = jsondata.d.objPerfilBE.intIdPerfil;
                            objPerfilUsuarioBE.objUsuarioBE.strClaveUsuario = ""; //AFAC
                            AsignarDatosSesion();
                            return false;
                        }
                        else {
                            bootbox.alert('Codigo de Usuario Incorrecto.', function (e) {
                                $('.preload').hide();
                                $('.btnLogin').button("enable");
                            });
                            return;
                        }
                    },
                    error: function (xhr, status, error) {
                        MostrarPopUp('img/PaginaMantenimiento.png');
                        //                        $("#divAlert").dialog('open');
                        //                        $("#spnAlert").empty().html(xhr.responseText);
                    }
                });AsignarSessionInformacionUsuario
            } else {
                bootbox.alert("El c&oacute;digo de seguridad es incorrecto.", function (e) {
                    $('.preload').hide();
                    $('.btnLogin').button("enable");
                    $("#codigo").focus();
                }); return;
            }
        });

    }
});

/*************************************** INICIO: ObtenerDatosSesion***************************************/
function AsignarDatosSesion() {
    objPerfilUsuarioBE.objUsuarioBE.intEstado = 1;
    $.ajax({
        url: strServicio + "GestionarUsuarios.asmx/AsignarSessionInformacionUsuario",
        data: '{"objPerfilUsuarioBE":' + JSON.stringify(objPerfilUsuarioBE) + '}',
        dataType: "json",
        type: "POST",
        contentType: "application/json; charset=utf-8",
        success: function (jsondata) {
            var str = '';
            if (jsondata.d) {
                if (jsondata.d.objUsuarioBE.intIdUsuario === undefined || jsondata.d.objUsuarioBE.intIdUsuario == 0) {
                    bootbox.alert("Información: Su sesión ha caducado, por favor ingrese nuevamente.");
                    location.href = '../index.aspx';
                    return;
                }
                objPerfilUsuarioBESES = jsondata.d;
                AsignarDatosMenuSesion();
            }
            else {

            }
        },
        error: function (xhr, status, error) {
            $("#divAlert").dialog('open');
            $("#spnAlert").empty().html(xhr.responseText);
        }
    });
} /*************************************** FIN: ObtenerDatosSesion***************************************/

/*************************************** INICIO: AsignarDatosMenuSesion***************************************/
function AsignarDatosMenuSesion() {
    $.ajax({
        url: strServicio + "GestionarUsuarios.asmx/ObtenerMenuAplicativoPerfil",
        data: '{"objPerfilUsuarioBE":' + JSON.stringify(objPerfilUsuarioBESES) + '}',
        dataType: "json",
        type: "POST",
        contentType: "application/json; charset=utf-8",
        success: function (jsondata) {
            var str = '';
            if (jsondata.d) {
                if (objPerfilUsuarioBESES.objUsuarioBE.intFlagCambioContrasena == 1) {
                    $("#lnkOlvideContrasena").click();
                } else {
                    location.href = 'home.aspx';
                }
            }
        },
        error: function (xhr, status, error) {
        }
    });
} /*************************************** FIN: AsignarDatosMenuSesion***************************************/
function EliminarSesiones(strRedireccionar) {
    console.log(strRedireccionar);
    if (strRedireccionar == '1') {
        jConfirm("¿Esta seguro que desea salir del sistema?", "Estudio Galicia S. A. C.", function (answer) {
            if (!answer) return;
            else {
                $.ajax({
                    url: strServicio + "menu.asmx/EliminarSesiones",
                    data: '',
                    dataType: "json",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    success: function (jsondata) {
                        console.log(jsondata.d);
                        if (jsondata.d) {
                            if (strRedireccionar == '0') { return false; }
                            location.href = '/index.aspx';
                            return false;
                        }
                    },
                    error: function (xhr, status, error) {
                        $("#divAlert").dialog('open');
                        $("#spnAlert").empty().html(xhr.responseText);
                    }
                });
            }
        });
        return false;
    }
    $.ajax({
        url: strServicio + "menu.asmx/EliminarSesiones",
        //data: '',
        dataType: "json",
        type: "POST",
        contentType: "application/json; charset=utf-8",
        success: function (jsondata) {
            console.log(jsondata.d);
            if (jsondata.d) {
                if (strRedireccionar == '0') { return false; }
                location.href = '/index.aspx';
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

function MostrarPopUp(strHref) {
    $.fancybox({
        'type': 'iframe',
        'href': strHref,
        'width': 720,
        'height': 400,
        'padding': 0,
        'margin': 0
    });
}