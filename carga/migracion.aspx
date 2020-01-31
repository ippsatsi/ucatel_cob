<%@ Page Title="" Language="C#" MasterPageFile="~/resource/masterPage/Template.Master" AutoEventWireup="true" CodeBehind="migracion.aspx.cs" Inherits="WEB.carga.migracion" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="titulo" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="pageBar" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="antesTitulo" runat="server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="contenido" runat="server">
    <div class="row" id="div_contenido">
        <div class="col-md-12">
            <div class="portlet box blue">
                <div class="portlet-title">
                    <div class="caption">
                        <i class="fa fa-globe"></i> Historico de Migración de Cuentas</div>
                    <div class="tools"> </div>
                </div>

                <div class="portlet-body">
                    <div class="row">
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 margin-bottom-20">
                            <div class="col-md-2">
                                <label>N° CUENTA</label>
                                <input type="text" id="txtNroCuenta" class="form-control">
                            </div>
                            <div class="col-md-2">
                                <label>DNI</label>
                                <input type="text" id="txtDni" class="form-control">
                            </div>
                            <div class="col-md-2">
                                <label>CLIENTE</label>
                                <input type="text" id="txtCliente" class="form-control">
                            </div>
                            <div class="col-md-2">
                                <label>FECHA</label>
                                <input type="text" id="txtFecha" class="form-control date-picker"/>
                            </div>
                            <div class="col-md-2">
                                <label>&nbsp;&nbsp;</label>
                                <input type="button" class="form-control btn blue btn_buscar" id="btn_buscar" value="BUSCAR"/>
                                <%--<img src="../resource/img/icons/phone-icon.png" id="btn_buscar_telefono" />--%>
                            </div>
                            <div class="col-md-2">
                                <label>&nbsp;&nbsp;</label>
                                <input type="button" class="form-control btn blue btn_buscar" id="btn_limpiar" value="LIMPIAR"/>
                                <%--<img src="../resource/img/icons/phone-icon.png" id="btn_buscar_telefono" />--%>
                            </div>
                        </div>
                    </div>            
                    <div id="div_mensaje">
                    </div>
                    <table class="tblLista table table-striped table-bordered table-hover dt-responsive" cellspacing="0" width="100%" id="tblLista">
                        <thead>
                            <tr>
                                <th class="min-cliente">N°</th>
                                <th class="min-cliente">FECHA MIGRACIÓN</th>
                                <th class="min-cliente">N° DOCUMENTO</th>
                                <th class="min-cliente">NOMBRE COMPLETO</th>
                                <th class="min-cliente">PROVEEDOR MIGRACION</th>
                                <th class="min-cliente">CUENTA</th>
                                <th class="min-cliente">PRODUCTO</th>
                                <th class="min-cliente">DESCRIPCIÓN</th>
                                <th class="all">MONTO CAPITAL</th>
                                <th class="all">DEUDA TOTAL</th>
                                <th class="all">PROVEEDOR ACTUAL</th>
                            </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="script" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $(".date-picker").datepicker({
                format: "dd/mm/yyyy"
            });

            $("#txtFecha").val(obtenerFechaActual);

            function obtenerFechaActual() {
                var today = new Date();
                var dd = today.getDate();
                var mm = today.getMonth() + 1; //January is 0!

                var yyyy = today.getFullYear();
                if (dd < 10) {
                    dd = '0' + dd
                }
                if (mm < 10) {
                    mm = '0' + mm
                }
                var today = dd + '/' + mm + '/' + yyyy;
                return today;
            }

            buscar();
            $("#btn_buscar").click(buscar);

            $("#btn_limpiar").click(function () {
                $("#txtNroCuenta").val("");
                $("#txtDni").val("");
                $("#txtCliente").val("");
                $("#txtFecha").val("");

                $("#tblLista tbody").empty();
            });
        });

        function buscar() {
            if ($.trim($("#txtNroCuenta").val()).length < 1 &&
                $.trim($("#txtDni").val()).length < 1 &&
                $.trim($("#txtCliente").val()).length < 1 &&
                $.trim($("#txtFecha").val()).length < 1) {
                bootbox.alert("Usted no ingreso ningun filtro.");
                return false;
            }

            abrir_preload('div_contenido');
            objFiltro=new Object();
            objFiltro.nro_cuenta = $("#txtNroCuenta").val();
            objFiltro.nro_documento = $("#txtDni").val();
            objFiltro.nombre_completo = $("#txtCliente").val();
            objFiltro.fec_desde = $("#txtFecha").val();
            $.ajax({
                url: strServicio + "cartera.asmx/listarMigraciones",
                data: "{'objFiltro':" + JSON.stringify(objFiltro) + "}",
                dataType: 'JSON',
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    cerrar_preload('div_contenido');
                    var htmlText = "";
                    $("#tblLista tbody").empty();
                    $.each(data.d, function (i, obj) {
                        htmlText = "<tr>" +
                            "<td>" + (i + 1) + "</td>" +
                            "<td>" + obj.BAD_FECHA_MIGRACION + "</td>" +
                            "<td>" + obj.CLI_DOCUMENTO_IDENTIDAD + "</td>" +
                            "<td>" + obj.CLI_NOMBRE_COMPLETO + "</td>" +
                            "<td>" + obj.PRV_MIGRACION + "</td>" +
                            "<td>" + obj.CUE_NROCUENTA + "</td>" +
                            "<td>" + obj.CUE_PRODUCTO + "</td>" +
                            "<td>" + obj.CUE_PRODUCTO_DESC + "</td>" +
                            "<td>" + obj.BAD_DEUDA_MONTO_CAPITAL + "</td>" +
                            "<td>" + obj.BAD_DEUDA_SALDO + "</td>" +
                            "<td>" + obj.PRV_ACTUAL + "</td>" +
                            "<tr>";
                        $("#tblLista tbody").append(htmlText);
                    });
                }
            });
        }
    </script>
</asp:Content>
