<%@ Page Title="" Language="C#" MasterPageFile="~/resource/masterPage/Template.Master" AutoEventWireup="true" CodeBehind="reporte-diario.aspx.cs" Inherits="WEB.cobranza.reporte_diario" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contenido" runat="server">
    <div class="row" id="div_contenido">
        <div class="col-md-12">
            <div class="portlet box blue">
                <div class="portlet-title">
                    <div class="caption">
                        <i class="fa fa-globe"></i> Reporte Diario</div>
                    <div class="tools"> </div>
                </div>
                <div class="portlet-body">
                    <table id="tblLista" class="tblLista_grid table table-striped table-bordered table-hover dt-responsive" cellspacing="0" width="100%">
                        <thead>
                            <tr>
                                <th></th>
                                <th>FECHA REGISTRO</th>
                                <th>HORA</th>
                                <th>USUARIO</th>
                                <th>N° CUENTA</th>
                                <th>SUB CARTERA</th>
                                <th>DNI</th>
                                <th>NOMBRE COMPLETO</th>
                                <th>FECHA INICIAL</th>
                                <th>IMPORTE INICIAL</th>
                                <th>TIPO RESPUESTA</th>
                                <th>SOLUCIÓN</th>
                                <th>OBSERVACIONES</th>
                            </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            var cargarReporteDiario = function () {
                abrir_preload('div_contenido');
                $.ajax({
                    url: strServicio+"gestion.asmx/obtenerReporteDiarioUsuario",
                    dataType: 'JSON',
                    type: 'POST',
                    contentType: "application/json; charset=utf-8",
                    success: function (jsondata) {
                        cerrar_preload('div_contenido');
                         var htmlText = "";
                        $("#tblLista tbody").empty();
                        $.each(jsondata.d, function (i, obj) {
                            htmlText = "<tr " + (i % 2 == 0 ? "class='row_listabandejavirtual'" : "") + ">" +
                            "<td><span>" + (i + 1) + "</span></td>" +
                            "<td><span>" + obj.GES_FECHA_REGISTRO + "</span></td>" +
                            "<td><span>" + obj.GES_HORA + "</span></td>" +
                            "<td><span>" + obj.GES_USU_LOGIN + "</span></td>" +
                            "<td><span>" + obj.CUE_NROCUENTA + "</span></td>" +
                            "<td><span>" + obj.SCA_DESCRIPCION + "</span></td>" +
                            "<td><span>" + obj.CLI_DOCUMENTO_IDENTIDAD + "</span></td>" +
                            "<td><span>" + obj.CLI_NOMBRE_COMPLETO + "</span></td>" +
                            "<td><span>" + obj.GES_FECHA_INICIAL + "</span></td>" +
                            "<td><span>" + obj.GES_IMPORTE_INICIAL + "</span></td>" +
                            "<td><span>" + obj.TIR_DESCRIPCION + "</span></td>" +
                            "<td><span>" + obj.SOL_DESCRIPCION + "</span></td>" +
                            "<td><span>" + obj.GES_OBSERVACIONES + "</span></td>" +
                            "</tr>";
                            $("#tblLista tbody").append(htmlText);
                        });
                    }
                });
            }

            cargarReporteDiario();
        });
    </script>
</asp:Content>
