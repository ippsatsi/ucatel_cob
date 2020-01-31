<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="direccion_busqueda_copy.aspx.cs" Inherits="WEB.cobranza.direccion_busqueda" %>

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
        <h2>GESTIONAR DIRECCIÓN</h2>
        <div>
            <div class="cell tb_datos_sol_01">
                <span>TIPO DIRECCIÓN (*)</span>
            </div>
            <div class="cell">
                <span>:</span>
            </div>
            <div class="cell tb_datos_sol_02">
                <select id="sltTipoDireccion" style="width:255px;">
                    <option value="0">-SELECCIONE-</option>
                </select>
            </div>
        </div>
        <div>
            <div class="cell tb_datos_sol_01">
                <span>DIRECCIÓN (*)</span>
            </div>
            <div class="cell">
                <span>:</span>
            </div>
            <div class="cell tb_datos_sol_02">
                <textarea id="txtDirección" rows="3" cols="20" style="height: 60px;width: 255px;"></textarea>
            </div>
        </div>
        <div>
            <div class="cell tb_datos_sol_01">
                <span>DEPARTAMENTO (*)</span>
            </div>
            <div class="cell">
                <span>:</span>
            </div>
            <div class="cell tb_datos_sol_02">
                <select id="sltDepartamento" style="width:255px;">
                    <option value="0">-SELECCIONE-</option>
                </select>
            </div>
        </div>
        <div>
            <div class="cell tb_datos_sol_01">
                <span>PROVINCIA (*)</span>
            </div>
            <div class="cell">
                <span>:</span>
            </div>
            <div class="cell tb_datos_sol_02">
                <select id="sltProvincia" style="width:255px;">
                    <option value="0">-SELECCIONE-</option>
                </select>
            </div>
        </div>
        <div>
            <div class="cell tb_datos_sol_01">
                <span>DISTRITO (*)</span>
            </div>
            <div class="cell">
                <span>:</span>
            </div>
            <div class="cell tb_datos_sol_02">
                <select id="sltDistrito" style="width:255px;">
                    <option value="0">-SELECCIONE-</option>
                </select>
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
                <%--<input type="text" id="txtValido" style="width:255px;"/>--%>
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
            <br />
            <div><a class="btns_popup btn_aceptar" onclick="parent.$.fancybox.close();">CANCELAR</a></div>
            <div><a class="btns_popup btn_aceptar" onclick="guardar_direccion();">ACEPTAR</a></div>
            <%--<br />
            <input type="button" class="btns_popup btn_aceptar" onclick="$.fancybox.close();" value="CANCELAR"/>
            <input type="button" class="btns_popup btn_aceptar" value="ACEPTAR"/>--%>
        </div>
    </div>
    </form>
    <script type="text/javascript">
        $(document).ready(function () {
            listarDepartamento();
            listaTipoDireccion();
            cargarTipoOrigen();
            cargarDireccionStatus();

            function cargarDireccionStatus() {
                $.ajax({
                    url: strServicio+"general.asmx/obtenerDireccionStatus",
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
        });

        function guardar_direccion() {
            if ($("#sltTipoDireccion").val() == "0") {
                bootbox.alert("Seleccione el tipo de dirección");
                return false;
            }
            if ($("#txtDirección").val().length < 1) {
                bootbox.alert("Ingrese la dirección");
                return false;
            }
            if ($("#sltDepartamento").val() == "0") {
                bootbox.alert("Seleccione departamento");
                return false;
            }
            if ($("#sltProvincia").val() == "0") {
                bootbox.alert("Seleccione provincia");
                return false;
            }
            if ($("#sltDistrito").val() == "0") {
                bootbox.alert("Seleccione distrito");
                return false;
            }
            if ($("#txtValido").val().length < 1) {
                bootbox.alert("Ingrese la validación");
                return false;
            }
            if ($("#sltOrigen").val() == "0") {
                bootbox.alert("Seleccione el origen");
                return false;
            }
            objDireccion = new Object();
            objDireccion.DIR_CODIGO = $("#txtCodigo").val();
            objDireccion.COD_BUSQUEDA = $("#txtCodigoBusqueda").val();
            objDireccion.DIR_DIRECCION = $("#txtDirección").val();
            objDireccion.DIR_ESTADO_VALIDEZ = $("#txtValido").val();
            objDireccion.ObjTipoOrigen = new Object();
            objDireccion.ObjTipoOrigen.TOR_CODIGO = $("#sltOrigen").val();
            objDireccion.UBI_DISTRITO = $("#sltDistrito").val();
            objDireccion.ObjTipoDireccion = new Object();
            objDireccion.ObjTipoDireccion.TDI_CODIGO = $("#sltTipoDireccion").val();
            $.ajax({
                url: strServicio+"direccion.asmx/registrar_busqueda",
                data: '{"objDireccion":' + JSON.stringify(objDireccion) + '}',
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

        function listaTipoDireccion() {
            $.ajax({
                url: strServicio+"general.asmx/listaTipoDireccion",
                dataType: 'JSON',
                type: 'POST',
                async: false,
                contentType: "application/json; charset=utf-8",
                success: function (jsondata) {
                    //console.table(jsondata.d);
                    //$("#sltDepartamento").empty();
                    $.each(jsondata.d, function (i, obj) {
                        $("#sltTipoDireccion").append("<option value='" + obj.value + "'>" + obj.key + "</option>");
                    });
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
                    console.table(jsondata.d);
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
    </script>
</body>
</html>
