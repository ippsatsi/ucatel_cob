$(document).ready(function () {
    $("#btnBuscar").click(fncBuscar);

    function fncBuscar() {
        var recapcha = new Object();
        recapcha.dni = $("#txtDni").val();
        recapcha.reCapcha = $(".g-recaptcha-response").val();
        $.ajax({
            url: $("#rutaWeb).val()+"resource/service/recapcha.asmx/validar",
            data: '{"recapcha":' + JSON.stringify(recapcha) + '}',
            dataType: 'JSON',
            type: 'POST',
            contentType: "application/json; charset=utf-8",
            success: function (jsondata) {
                console.log(jsondata.d);
                if (jsondata.d == true) {
                    $("#lblReCaptcha").hide();
                    $("#txtReCaptcha").hide();
                    $("#txtDniDatos").val($("#txtDni").val());
                    $("#btnBuscarDatos").click();
                    $("#divBuscarDni").hide("blind", {}, 1000, callback);
                }

            }
        });
    }

    listarDepartamento();

    //$("#sltDepartamento").change(function () {
    //    listarProvincia($(this).val());
    //    $("#sltDistrito").html("<option value='00'>< Seleccione ></option>");
    //});
    //$("#sltProvincia").change(function () { listarDistrito($("#sltDepartamento").val(),$(this).val()); });

    function listarDepartamento() {
        $.ajax({
            url: $("#rutaWeb).val()+"resource/service/general.asmx/listarDepartamento",
            dataType: 'JSON',
            type: 'POST',
            async: false,
            contentType: "application/json; charset=utf-8",
            success: function (jsondata) {
                console.table(jsondata.d);
                $("#sltDepartamento").empty();
                $.each(jsondata.d, function (i, obj) {
                    $("#sltDepartamento").append("<option value='"+obj.UbiRegion+"'>"+obj.Region+"</option>");
                });
            }
        });
    }

    function listarProvincia(idDepartamento) {
        var objUbigeo = new Object();
        objUbigeo.ubiRegion = idDepartamento;
        $.ajax({
            url: $("#rutaWeb).val()+"resource/service/general.asmx/listarProvincia",
            data: '{"objUbigeo":' + JSON.stringify(objUbigeo) + '}',
            dataType: 'JSON',
            type: 'POST',
            async: false,
            contentType: "application/json; charset=utf-8",
            success: function (jsondata) {
                console.table(jsondata.d);
                $("#sltProvincia").empty();
                $.each(jsondata.d, function (i, obj) {
                    $("#sltProvincia").append("<option value='" + obj.UbiProvincia + "'>" + obj.Provincia + "</option>");
                });
            }
        });
    }

    function listarDistrito(idDepartamento,idProvincia) {
        var objUbigeo = new Object();
        objUbigeo.UbiRegion = idDepartamento;
        objUbigeo.ubiProvincia = idProvincia;
        $.ajax({
            url: $("#rutaWeb).val()+"resource/service/general.asmx/listarDistrito",
            data: '{"objUbigeo":' + JSON.stringify(objUbigeo) + '}',
            dataType: 'JSON',
            type: 'POST',
            async: false,
            contentType: "application/json; charset=utf-8",
            success: function (jsondata) {
                console.table(jsondata.d);
                $("#sltDistrito").empty();
                $.each(jsondata.d, function (i, obj) {
                    $("#sltDistrito").append("<option value='" + obj.UbiDistrito + "'>" + obj.Distrito + "</option>");
                });
            }
        });
    }

});
