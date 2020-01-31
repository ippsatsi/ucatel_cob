<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="telefono_busqueda_copy.aspx.cs" Inherits="WEB.cobranza.telefono_busqueda" %>

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
    <asp:HiddenField runat="server" ID="txtCodigo" Value="0" />
    <asp:HiddenField runat="server" ID="txtCodigoBusqueda" Value="0" />
    <div class="table table_bandeja_segmento_d" id="tb_datos_solicitante">
        <h2>GESTIONAR TELEFONO</h2>
        <div>
            <div class="cell tb_datos_sol_01">
                <span>TELEFONO (*)</span>
            </div>
            <div class="cell">
                <span>:</span>
            </div>
            <div class="cell tb_datos_sol_02">
                <input type="text" id="txtTelefono" style="width:255px;"/>
            </div>
        </div>
        <div>
            <div class="cell tb_datos_sol_01">
                <span>ANEXO</span>
            </div>
            <div class="cell">
                <span>:</span>
            </div>
            <div class="cell tb_datos_sol_02">
                <input type="text" id="txtAnexo" style="width:255px;"/>
            </div>
        </div>
        <div>
            <div class="cell tb_datos_sol_01">
                <span>VALIDO (*)</span>
            </div>
            <div class="cell">
                <span>:</span>
            </div>
            <div class="cell tb_datos_sol_02">
                <select id="txtValido" style="width:255px;">
                    <option value="0">-SELECCIONE-</option>
                </select>
            </div>
        </div>
        <div>
            <div class="cell tb_datos_sol_01">
                <span>ESTADO (*)</span>
            </div>
            <div class="cell">
                <span>:</span>
            </div>
            <div class="cell tb_datos_sol_02">
                <select id="sltEstado" style="width:255px;">
                    <option value="0">-SELECCIONE-</option>
                    <option value="N">NUEVO</option>
                    <option value="G">GESTIONADO</option>
                </select>
            </div>
        </div>
        <div>
            <div class="cell tb_datos_sol_01">
                <span>ORIGEN (*)</span>
            </div>
            <div class="cell">
                <span>:</span>
            </div>
            <div class="cell tb_datos_sol_02">
                <select id="sltOrigen" style="width:255px;">
                    <option value="0">-SELECCIONE-</option>
                </select>
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
            <div><a class="btns_popup btn_aceptar" onclick="parent.$.fancybox.close();">CANCELAR</a></div>
            <div><a class="btns_popup btn_aceptar" onclick="guardar_telefono();">ACEPTAR</a></div>
        </div>
    </div>
    </form>
    <script type="text/javascript">
        $(document).ready(function () {
            cargarTipoOrigen();
            cargarTelefonoStatus();

            function cargarTelefonoStatus() {
                $.ajax({
                    url: strServicio+"general.asmx/obtenerTelefonoStatus",
                    dataType: 'JSON',
                    type: 'POST',
                    contentType: "application/json; charset=utf-8",
                    async: false,
                    success: function (jsondata) {
                        $.each(jsondata.d, function (i, obj) {
                            $("#txtValido").append("<option value='" + obj.value + "'>" + obj.key + "</option>");
                        });
                    }
                });
            }

            function cargarTipoOrigen() {
                $.ajax({
                    url: strServicio+"general.asmx/listarTipoOrigen",
                    dataType: 'JSON',
                    type: 'POST',
                    contentType: "application/json; charset=utf-8",
                    async: false,
                    success: function (jsondata) {
                        $.each(jsondata.d, function (i, obj) {
                            $("#sltOrigen").append("<option value='" + obj.value + "'>" + obj.key + "</option>");
                        });
                    }
                });
            }
        });

        function guardar_telefono() {
            if ($("#txtTelefono").val().length < 1) {
                bootbox.alert("Ingrese número de telefono");
                return false;
            }
            if ($("#txtValido").val().length < 1) {
                bootbox.alert("Ingrese valido");
                return false;
            }
            if ($("#sltEstado").val() == "0") {
                bootbox.alert("Seleccione el estado");
                return false;
            }
            if ($("#sltOrigen").val() == "0") {
                bootbox.alert("Seleccione el origen");
                return false;
            }
            //CREAR OBJETO
            objTelefono = new Object();
            objTelefono.TEL_CODIGO = $("#txtCodigo").val();
            objTelefono.TEL_NUMERO = $("#txtTelefono").val();
            objTelefono.TEL_ESTADO_VALIDEZ = $("#txtValido").val();
            objTelefono.ObjTipoOrigen = new Object();
            objTelefono.ObjTipoOrigen.TOR_CODIGO = $("#sltOrigen").val();
            objTelefono.TEL_ESTADO_TELEFONO = $("#sltEstado").val();
            objTelefono.TEL_ANEXO = $("#txtAnexo").val();
            objTelefono.TEL_OBSERVACIONES = $("#txtObservacion").val();
            objTelefono.COD_BUSQUEDA = $("#txtCodigoBusqueda").val();
            //return;
            $.ajax({
                url: strServicio+"telefono.asmx/registrar_busqueda",
                data: '{"objTelefono":' + JSON.stringify(objTelefono) + '}',
                dataType: 'JSON',
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                async: false,
                success: function (jsondata) {
                    if (jsondata.d > 0) {
                        parent.buscar();
                        parent.$.fancybox.close();
                    }
                }
            });
        }
    </script>
</body>
</html>
