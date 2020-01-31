<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="tarea.aspx.cs" Inherits="WEB.cobranza.tarea" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link href="../resource/css/jne/jquery-ui-1.9.2.custom.min.css" rel="stylesheet" />
    <link href="../resource/css/main_sol.css" rel="stylesheet" />
    <script src="../resource/js/jquery-1.8.3.js"></script>
    <script src="../resource/js/vendor/ui/jquery-ui-1.9.2.custom.js"></script>
    <script src="../resource/js/vendor/ui/jquery.timepicker.js"></script>
    <link href="../resource/css/jquery.timepicker.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
    <asp:HiddenField runat="server" ID="txtCodigo" Value="0" />
    <div class="table table_bandeja_segmento_d" id="tb_datos_solicitante">
        <h2>GESTIONAR TAREAS</h2>
        <div>
            <div class="cell tb_datos_sol_01">
                <span>FECHA (*)</span>
            </div>
            <div class="cell">
                <span>:</span>
            </div>
            <div class="cell tb_datos_sol_02">
                <input type="text" id="txtFecha" style="width:255px;"/>
            </div>
        </div>
        <div>
            <div class="cell tb_datos_sol_01">
                <span>HORA (*)</span>
            </div>
            <div class="cell">
                <span>:</span>
            </div>
            <div class="cell tb_datos_sol_02">
                <input type="text" id="txtHora" style="width:255px;"/>
            </div>
        </div>
        <div>
            <div class="cell tb_datos_sol_01">
                <span>OBSERVACIONES</span>
            </div>
            <div class="cell">
                <span>:</span>
            </div>
            <div class="cell tb_datos_sol_02">
                <textarea id="txtObservacion" rows="3" cols="20" style="height: 60px;width: 255px;"></textarea>
            </div>
        </div>
        <div>
            <br />
            <div><a class="btns_popup btn_aceptar" onclick="cancelar_tarea();">CANCELAR</a></div>
            <div><a class="btns_popup btn_aceptar" onclick="guardar_tarea();">ACEPTAR</a></div>
        </div>
    </div>
    </form>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#txtFecha").datepicker({ dateFormat: 'dd/mm/yy' });

            //$("#txtHora").timepicker({ 'timeFormat': 'h:i A' });

            $("#txtHora").timepicker({
                'minTime': '8:00am',
                'maxTime': '7:30pm',
                'showDuration': true
            });
        });

        function guardar_tarea() {
            parent.obtenerDatosTarea($("#txtFecha").val(), $("#txtHora").val(), $("#txtObservacion").val());
            parent.$.fancybox.close();
        }

        function cancelar_tarea() {
            parent.obtenerDatosTarea("", "", "");
            parent.$.fancybox.close();
        }
    </script>
</body>
</html>
