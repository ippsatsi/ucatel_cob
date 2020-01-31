<%@ Page Title="" Language="C#" MasterPageFile="~/resource/masterPage/Popup.Master" AutoEventWireup="true" CodeBehind="correo.aspx.cs" Inherits="WEB.cobranza.correo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="titulo" runat="server">
    GESTIONAR CORREO
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contenido" runat="server">
    <div class="content">
        <asp:HiddenField runat="server" ID="txtCodigo" Value="0" />
        <asp:HiddenField runat="server" ID="txtCodigoCliente" Value="0" />
        <asp:HiddenField runat="server" ID="txtCodigoProveedor" Value="0" />
        <div class="form-group row">
          <label for="txtCorreo" class="col-xs-4 col-form-label">CORREO</label>
          <div class="col-xs-8">
            <input class="form-control" type="text" id="txtCorreo" runat="server"/>
          </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footer" runat="server">
    <button type="button" class="btn btn-primary" onclick="guardar_correo();">ACEPTAR</button>
    <button type="button" class="btn btn-danger" onclick="parent.$.fancybox.close();">CANCELAR</button>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="script" runat="server">
    <script type="text/javascript">
        function guardar_correo() {
            if ($.trim($("#contenido_txtCorreo").val()).length < 1) {
                bootbox.alert("Ingrese correo electrónico");
                return false;
            }
            var re = /^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/;
            if (!re.test($("#contenido_txtCorreo").val())) {
                bootbox.alert("Ingrese formato valido de correo (sin Ñ ó ESPACIOS)");
                return false;
            }
            //CREAR OBJETO
            objCorreo = new Object();
            objCorreo.COR_CODIGO = $("#contenido_txtCodigo").val();
            objCorreo.CLI_CODIGO = $("#contenido_txtCodigoCliente").val();
            objCorreo.COR_CORREO_ELECTRONICO = $("#contenido_txtCorreo").val();
            //return;
            $.ajax({
                url: "../resource/service/correo.asmx/registrar",
                data: '{"objCorreo":' + JSON.stringify(objCorreo) + '}',
                dataType: 'JSON',
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                async: false,
                success: function (jsondata) {
                    if (jsondata.d > 0) {
                        parent.listarCorreos();
                        parent.$.fancybox.close();
                    }
                }
            });
        }
    </script>
</asp:Content>
