<%@ Page Title="" Language="C#" MasterPageFile="~/resource/masterPage/Popup.Master" AutoEventWireup="true" CodeBehind="telefono_busqueda.aspx.cs" Inherits="WEB.cobranza.telefono_busqueda1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="titulo" runat="server">
    NUEVO TELEFONO
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contenido" runat="server">
    <div class="content">
        <asp:HiddenField runat="server" ID="txtCodigo" Value="0" />
        <asp:HiddenField runat="server" ID="txtCodigoBusqueda" Value="0" />
        <div class="form-group row">
          <label for="txtTelefono" class="col-xs-4 col-form-label">TELEFONO</label>
          <div class="col-xs-8">
            <input class="form-control" type="text" id="txtTelefono"/>
          </div>
        </div>
        <div class="form-group row">
          <label for="txtAnexo" class="col-xs-4 col-form-label">ANEXO</label>
          <div class="col-xs-8">
            <input class="form-control" type="text" id="txtAnexo"/>
          </div>
        </div>
        <div class="form-group row">
          <label for="txtValido" class="col-xs-4 col-form-label">VALIDO</label>
          <div class="col-xs-8">
            <select id="txtValido" class="form-control">
                <option value="0">-SELECCIONE-</option>
            </select>
          </div>
        </div>
        <div class="form-group row">
          <label for="sltEstado" class="col-xs-4 col-form-label">ESTADO</label>
          <div class="col-xs-8">
            <select id="sltEstado" class="form-control">
                <option value="N">NUEVO</option>
            </select>
          </div>
        </div>
        <div class="form-group row">
          <label for="sltOrigen" class="col-xs-4 col-form-label">ORIGEN</label>
          <div class="col-xs-8">
            <select id="sltOrigen" class="form-control">
                <option value="0">-SELECCIONE-</option>
            </select>
          </div>
        </div>
        <div class="form-group row">
          <label for="txtObservacion" class="col-xs-4 col-form-label">OBSERVACIÓN</label>
          <div class="col-xs-8">
            <textarea id="txtObservacion" class="form-control"></textarea>
          </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footer" runat="server">
    <button type="button" class="btn btn-primary" onclick="guardar_telefono();">ACEPTAR</button>
    <button type="button" class="btn btn-danger" onclick="parent.$.fancybox.close();">CANCELAR</button>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="script" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            cargarTipoOrigen();
            cargarTelefonoStatus();
            
            function cargarTelefonoStatus() {
                $.ajax({
                    url: "../resource/service/general.asmx/obtenerTelefonoStatus",
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
                    url: "../resource/service/general.asmx/listarTipoOrigen",
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
            //VALIDAR
            //if ($("#sltOperador").val() == "0") {
            //    bootbox.alert("Seleccione el operador");
            //    return false;
            //}
            if ($("#txtTelefono").val().length < 1) {
                bootbox.alert("Ingrese número de telefono");
                return false;
            }
            if ($("#txtValido").val().length < 1) {
                bootbox.alert("Ingrese valido");
                return false;
            }
            //if ($("#sltTipoEquipo").val() == "0") {
            //    bootbox.alert("Seleccione el tipo de equipo");
            //    return false;
            //}
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
            objTelefono.TEL_CODIGO = $("#contenido_txtCodigo").val();
            objTelefono.TEL_NUMERO = $("#txtTelefono").val();
            objTelefono.TEL_ESTADO_VALIDEZ = $("#txtValido").val();
            objTelefono.ObjTipoOrigen = new Object();
            objTelefono.ObjTipoOrigen.TOR_CODIGO = $("#sltOrigen").val();
            objTelefono.TEL_ESTADO_TELEFONO = $("#sltEstado").val();
            objTelefono.TEL_ANEXO = $("#txtAnexo").val();
            objTelefono.TEL_OBSERVACIONES = $("#txtObservacion").val();
            objTelefono.COD_BUSQUEDA = $("#contenido_txtCodigoBusqueda").val();
            //return;
            $.ajax({
                url: "../resource/service/telefono.asmx/registrar_busqueda",
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
</asp:Content>
