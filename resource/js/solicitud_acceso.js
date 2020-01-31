$(document).ready(function () {
    $("#btn_buscar").click(fncBuscar);

    function fncBuscar() {
        var recapcha = new Object();
        recapcha.dni = $("#txt_dni").val();
        recapcha.reCapcha = $(".g-recaptcha-response").val();
        $.ajax({
            url: $("#rutaWeb").val()+"resource/service/recapcha.asmx/validar_dni",
            data: '{"recapcha":' + JSON.stringify(recapcha) + '}',
            dataType: 'JSON',
            type: 'POST',
            contentType: "application/json; charset=utf-8",
            success: function (jsondata) {
                console.log(jsondata.d);
                if (jsondata.d.Valido) {
                    window.location = "solicitud_ciudadano.aspx?p=" + jsondata.d.ParametroAcceso;
                } else {
                    bootbox.alert(jsondata.d.Mensaje);
                }
            }
        });
    }
});