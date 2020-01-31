var strServicio = 'resource/service/';
$(document).ready(function () {
    $('input, textarea').placeholder();
    $('#user').focus();

    $('#user, #password').keypress(function (e) {
        if (e.which == 13) {
            $("#btnAceptar").trigger("click");
        }
    });

    $("#btnAceptar").click(function () {
        $('.preload').show();
        usuario = new Object();
        usuario.USU_LOGIN = $("#user").val();
        usuario.USU_CLAVE = $("#password").val();

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

        $.ajax({
            url: "resource/service/user_exist.php",
            data: '{"usuario":' + JSON.stringify(usuario) + ', "intInsertaLog": "1"}',
            dataType: "json",
            type: "POST",
            contentType: "application/json; charset=utf-8",
            success: function (jsondata) {
                var str = '';
                 if (jsondata.d) {
                    if (jsondata.d.USU_CODIGO === undefined || jsondata.d.USU_CODIGO == null || jsondata.d.USU_CODIGO == "0") {
                        bootbox.alert("Error: La información ingresada es incorrecta.", function (e) {
                            $('.preload').hide();
                            $('.btnLogin').button("enable");
                        });
                        return false;
                    }else if (jsondata.d.USU_ROL != undefined || jsondata.d.USU_ROL != null || jsondata.d.USU_ROL != "") {
                      //console.log("logueado");
                        document.getElementById("form_inicio").submit();
                        //window.location = "inicio.php";
                    } else {
                        bootbox.alert(jsondata.d.MENSAJE);
                    }
                    return false;
                } else {
                    bootbox.alert('Codigo de Usuario Incorrecto.', function (e) {
                        $('.preload').hide();
                        $('.btnLogin').button("enable");
                    });
                    return;
                }
            },
            error: function (xhr, status, error) {
                MostrarPopUp('img/PaginaMantenimiento.png');
            }
        });
    });
});
