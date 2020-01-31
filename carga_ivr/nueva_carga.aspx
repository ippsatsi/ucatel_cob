<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="nueva_carga.aspx.cs" Inherits="WEB.carga_ivr.nueva_carga" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link href="../resource/css/main_sol.css" rel="stylesheet" />
    <script src="../resource/js/jquery-1.8.3.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="table table_bandeja_segmento_d" id="tb_datos_solicitante">
            <h2>CARGA DE IVR</h2>
            <div>
                <div class="cell tb_datos_sol_01">
                    <span>ADJUNTAR ARCHIVO</span>
                </div>
                <div class="cell">
                    <span>:</span>
                </div>
                <div class="cell tb_datos_sol_02">
                    <input type="file" id="file_upload" class="grande08" style="border: none; width: 300px;"/>
                </div>
                <div class="cell tb_datos_sol_02">
                    <input type="button" class="btn_buscar" id="btn_cargar" value="CARGAR" />
                </div>
            </div>
            <div id="txtProgreso"></div>
        </div>
    </form>
    <script type="text/javascript">
        $(document).on("click", "#btn_cargar", function (event) {
            var formData = new FormData();
            var files = $("#file_upload").get(0).files;
            if (files[0].type != "application/vnd.ms-excel" &&
                files[0].type != "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet") {
                bootbox.alert("Solo se aceptan formatos EXCEL");
                return false;
            }
            formData.append("Tipo", "correo");
            formData.append("UploadFile", files[0]);
            $.ajax({
                url: "../resource/carga/carga_ivr.ashx",
                type: 'POST',
                beforeSend: function () {
                    $("#txtProgreso").html("CARGANDO..");
                },
                uploadProgress: function (event, position, total, percentComplete) {
                    $("#txtProgreso").html(percentComplete + '%');
                },
                success: function () {
                    $("#txtProgreso").html('100%');
                },
                complete: function (response) {
                    bootbox.alert(response.responseText);
                    parent.listarBandeja();
                    parent.$.fancybox.close();
                },
                error: function () {
                    bootbox.alert("Ocurrio un error, por favor vuelva a intentar cargar el documento.");
                },
                data: formData,
                cache: false,
                contentType: false,
                processData: false
            });
        });
    </script>
</body>
</html>
