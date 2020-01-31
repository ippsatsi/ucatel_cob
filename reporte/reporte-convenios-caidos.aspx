<%@ Page Title="" Language="C#" MasterPageFile="~/resource/masterPage/Template.Master" AutoEventWireup="true" CodeBehind="reporte-convenios-caidos.aspx.cs" Inherits="WEB.reporte.reporte_convenios_caidos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href='<%=ResolveClientUrl("~/resource/assets/global/plugins/datatables/datatables.min.css") %>' rel="stylesheet" type="text/css" />
    <link href='<%=ResolveClientUrl("~/resource/assets/global/plugins/datatables/plugins/bootstrap/datatables.bootstrap.css") %>' rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="titulo" runat="server">
    REPORTE CONVENIOS CAIDOS
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="pageBar" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="antesTitulo" runat="server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="contenido" runat="server">
    <div class="row" id="div_contenido">
        <div class="col-md-12">
            <input type="hidden" id="txt_rol_codigo" runat="server" />
            <input type="hidden" id="txt_usu_codigo" runat="server" />
            <div class="portlet box blue">
                <div class="portlet-title">
                    <div class="caption">
                        <i class="fa fa-globe"></i> Reporte de convenios caidos </div>
                    <div class="tools"> </div>
                </div>
                <div class="portlet-body">
                    <div class="row">
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 margin-bottom-20">
                            <div class="col-md-4">
                                <label>Nº CUENTA</label>
                                <input type="text" id="txtCuenta" class="form-control"/>
                            </div>
                            <div class="col-md-4">
                                <label>DNI</label>
                                <input type="text" id="txtDNI" class="form-control"/>
                            </div>
                            <div class="col-md-4">
                                <label>CLIENTE</label>
                                <input type="text" id="txtCliente" class="form-control"/>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 margin-bottom-20"> 
                            <div class="col-md-4">
                                <label>AÑO</label>
                                <select class="form-control" id="sltAno">
                                    <option value="2017">2017</option>
                                    <option value="2016">2016</option>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <label>MES</label>
                                <select class="form-control" id="sltMes">
                                    <option value="1">ENERO</option>
                                    <option value="2">FEBRERO</option>
                                    <option value="3">MARZO</option>
                                    <option value="4">ABRIL</option>
                                    <option value="5">MAYO</option>
                                    <option value="6">JUNIO</option>
                                    <option value="7">JULIO</option>
                                    <option value="8">AGOSTO</option>
                                    <option value="9">SEPTIEMBRE</option>
                                    <option value="10">OCTUBRE</option>
                                    <option value="11">NOVIEMBRE</option>
                                    <option value="12">DICIEMBRE</option>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <label>&nbsp;&nbsp;</label>
                                <input type="button" class="form-control btn blue btn_buscar" id="btn_buscar" value="BUSCAR"/>
                            </div>
                        </div>
                    </div>

                    <table id="tblLista" class="tblLista table table-striped table-bordered table-hover dt-responsive" cellspacing="0" width="100%">
                    <thead>
                        <tr>
                            <th class="all">Item</th>
                            <th class="all">Nº Cuenta</th>
                            <th class="min-proovedor">Proveedor</th>
                            <th class="min-cartera">Cartera</th>
                            <th class="min-subcartera">Sub Cartera</th>
                            <th class="min-dni">DNI</th>
                            <th class="min-cliente">Cliente</th>
                            <th class="min-cliente">Dirección</th>
                            <th class="min-cliente">Departamento</th>
                            <th class="min-cliente">Provincia</th>
                            <th class="min-cliente">Distrito</th>
                            <th class="none">Cuotas</th>
                            <th class="none">Cuotas Pagadas</th>
                            <th class="min-fechavenc">Fecha Venc.</th>
                            <th class="min-numcuota">Nº Cuota</th>
                            <th class="min-montocuota">Monto Cuota</th>
                            <th class="min-montopago">Monto Pago</th>
                            <th class="min-fecha">Fecha</th>
                            <th class="min-anular">Tipo</th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="script" runat="server">
    <script src='<%=ResolveClientUrl("~/resource/assets/global/scripts/datatable.js")%>' type="text/javascript"></script>
    <script src='<%=ResolveClientUrl("~/resource/assets/global/plugins/datatables/datatables.min.js")%>' type="text/javascript"></script>
    <script src='<%=ResolveClientUrl("~/resource/assets/global/plugins/datatables/plugins/bootstrap/datatables.bootstrap.js")%>' type="text/javascript"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            $("#btn_buscar").click(fnc_buscar);

            function fnc_buscar() {

                $.ajax({
                    url: strServicio + "reporte.asmx/reporteConvenioCaido",
                    data: '{"nro_cuenta":"' + $("#txtCuenta").val() + '","nro_documento":"' + $("#txtDNI").val() + '","str_nombre":"' + $("#txtCliente").val() + '","nro_ano":' + $("#sltAno").val() + ',"nro_mes":' + $("#sltMes").val() + '}',
                    dataType: 'JSON',
                    type: 'POST',
                    contentType: "application/json; charset=utf-8",
                    success: function (jsondata) {
                        $("#tblLista tbody").empty();
                        var htmlText = "";
                        $.each(jsondata.d, function (i, obj) {
                            htmlText = "<tr>" +
                                    "<td>" + (i + 1) + "</td>" +
                                    "<td>" + obj.CUE_NROCUENTA + "</td>" +
                                    "<td>" + obj.PRV_NOMBRES + "</td>" +
                                    "<td>" + obj.CAR_DESCRIPCION + "</td>" +
                                    "<td>" + obj.SCA_DESCRIPCION + "</td>" +
                                    "<td>" + obj.CLI_DOCUMENTO_IDENTIDAD + "</td>" +
                                    "<td>" + obj.CLI_NOMBRE_COMPLETO + "</td>" +
                                    "<td>" + obj.CLI_DIRECCION_PARTICULAR + "</td>" +
                                    "<td>" + obj.UBI_DEPARTAMENTO + "</td>" +
                                    "<td>" + obj.UBI_PROVINCIA + "</td>" +
                                    "<td>" + obj.UBI_DISTRITO + "</td>" +
                                    "<td>" + obj.CUE_CONVENIO_CUOTAS + "</td>" +
                                    "<td>" + obj.CUE_CUOTAS_PAGADAS + "</td>" +
                                    "<td>" + obj.FEC_VENCIMIENTO + "</td>" +
                                    "<td>" + obj.NRO_CUOTA + "</td>" +
                                    "<td>" + obj.IMP_CUOTA + "</td>" +
                                    "<td>" + obj.PAG_MONTO + "</td>" +
                                    "<td>" + obj.PAG_FECHA + "</td>" +
                                    "<td>" + obj.TIPO + "</td>" +
                                "</tr>";
                            $("#tblLista tbody").append(htmlText);
                        });
                    }
                });
            }
        });
    </script>
</asp:Content>
