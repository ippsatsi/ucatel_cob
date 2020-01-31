<%@ Page Title="" Language="C#" MasterPageFile="~/resource/masterPage/Popup.Master" AutoEventWireup="true" CodeBehind="direccion_busqueda.aspx.cs" Inherits="WEB.cobranza.direccion_busqueda" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="titulo" runat="server">
    NUEVA DIRECCIÓN
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contenido" runat="server">
    <div class="content">
        <asp:HiddenField runat="server" ID="txtCodigo" Value="0" />
        <asp:HiddenField runat="server" ID="txtCodigoBusqueda" Value="0" />
        <div class="form-group row">
          <label for="sltTipoDireccion" class="col-xs-4 col-form-label">TIPO DIRECCIÓN</label>
          <div class="col-xs-8">
            <select id="sltTipoDireccion" class="form-control">
                <option value="0">-SELECCIONE-</option>
            </select>
          </div>
        </div>
        <div class="form-group row">
          <label for="txtDirección" class="col-xs-4 col-form-label">DIRECCIÓN</label>
          <div class="col-xs-8">
            <textarea id="txtDirección" class="form-control"></textarea>
          </div>
        </div>
        <div class="form-group row">
          <label for="sltDepartamento" class="col-xs-4 col-form-label">DEPARTAMENTO</label>
          <div class="col-xs-8">
            <select id="sltDepartamento" class="form-control">
                <option value="0">-SELECCIONE-</option>
            </select>
          </div>
        </div>
        <div class="form-group row">
          <label for="sltProvincia" class="col-xs-4 col-form-label">PROVINCIA</label>
          <div class="col-xs-8">
            <select id="sltProvincia" class="form-control">
                <option value="0">-SELECCIONE-</option>
            </select>
          </div>
        </div>
        <div class="form-group row">
          <label for="sltDistrito" class="col-xs-4 col-form-label">DISTRITO</label>
          <div class="col-xs-8">
            <select id="sltDistrito" class="form-control">
                <option value="0">-SELECCIONE-</option>
            </select>
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
          <label for="sltOrigen" class="col-xs-4 col-form-label">ORIGEN</label>
          <div class="col-xs-8">
            <select id="sltOrigen" class="form-control">
                <option value="0">-SELECCIONE-</option>
            </select>
          </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footer" runat="server">
    <button type="button" class="btn btn-primary" onclick="guardar_direccion();">ACEPTAR</button>
    <button type="button" class="btn btn-danger" onclick="parent.$.fancybox.close();">CANCELAR</button>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="script" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            listarDepartamento();
            listaTipoDireccion();
            cargarTipoOrigen();
            cargarDireccionStatus();
        });


        function cargarDireccionStatus() {
            $.ajax({
                url: "../resource/service/general.asmx/obtenerDireccionStatus",
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
            objDireccion.COD_BUSQUEDA = $("#contenido_txtCodigoBusqueda").val();
            objDireccion.DIR_DIRECCION = $("#txtDirección").val();
            objDireccion.DIR_ESTADO_VALIDEZ = $("#txtValido").val();
            objDireccion.ObjTipoOrigen = new Object();
            objDireccion.ObjTipoOrigen.TOR_CODIGO = $("#sltOrigen").val();
            objDireccion.UBI_DISTRITO = $("#sltDistrito").val();
            objDireccion.ObjTipoDireccion = new Object();
            objDireccion.ObjTipoDireccion.TDI_CODIGO = $("#sltTipoDireccion").val();
            $.ajax({
                url: "../resource/service/direccion.asmx/registrar_busqueda",
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

        function listaTipoDireccion() {
            $.ajax({
                url: "../resource/service/general.asmx/listaTipoDireccion",
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
                url: "../resource/service/general.asmx/listarDepartamento",
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
                url: "../resource/service/general.asmx/listarProvincia",
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
                url: "../resource/service/general.asmx/listarDistrito",
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
</asp:Content>
