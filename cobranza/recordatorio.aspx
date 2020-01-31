<%@ Page Title="" Language="C#" MasterPageFile="~/resource/masterPage/Template.Master" AutoEventWireup="true" CodeBehind="recordatorio.aspx.cs" Inherits="WEB.cobranza.recordatorio" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contenido" runat="server">
    <div class="row"  id="div_contenido">
        <div class="col-md-12">
            <div class="portlet box blue">
                <div class="portlet-title">
                    <div class="caption">
                        <i class="fa fa-globe"></i> RECORDATORIO DE LLAMADAS</div>
                    <div class="tools"> </div>
                </div>
                <div class="portlet-body">
                    <table id="tblLista" class="tblLista_grid table table-striped table-bordered table-hover dt-responsive" cellspacing="0" width="100%">
                        <thead>
                            <tr>
                                <th></th>
                                <th>N° CUENTA</th>
                                <th>CLIENTE</th>
                                <th>DNI</th>
                                <th>FECHA</th>
                                <th>HORA</th>
                                <th>OBSERVACIONES</th>
                                <th></th>
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
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            var cargarRecordatorio = function () {
                abrir_preload('div_contenido');
                $.ajax({
                    url: strServicio+"gestion.asmx/obtenerRecordatorios",
                    dataType: 'JSON',
                    type: 'POST',
                    contentType: "application/json; charset=utf-8",
                    success: function (jsondata) {
                        cerrar_preload('div_contenido');
                        var htmlText = "";
                        $("#tblLista tbody").empty();
                        $.each(jsondata.d,function (i, obj) {
                            htmlText = "<tr " + (i % 2 == 0 ? "class='row_listabandejavirtual'" : "") + ">" +
                            "<td><span>" + (i + 1) + "</span></td>" +
                            "<td><a href='gestionar-cuenta.aspx?cuenta=" + obj.CUE_NROCUENTA + "'>" + obj.CUE_NROCUENTA + "</a></td>" +
                            "<td><span>" + obj.CLI_NOMBRE_COMPLETO + "</span></td>" +
                            "<td><span>" + obj.CLI_DOCUMENTO_IDENTIDAD + "</span></td>" +
                            "<td><span>" + obj.REC_FECHA + "</span></td>" +
                            "<td><span>" + obj.REC_HORA + "</span></td>" +
                            "<td><span>" + obj.REC_OBSERVACIONES + "</span></td>" +
                            "<td>" +
                                "<div class='dv_icon_edit'><a class='icon_edit' href='gestionar-cuenta.aspx?cuenta=" + obj.CUE_NROCUENTA + "'></a></div>" +
                            "</td>" +
                            "</tr>";
                            $("#tblLista tbody").append(htmlText);
                        });
                    }
                });
                //setTimeout(cargarRecordatorio, 20000);
            }

            cargarRecordatorio();
        });
    </script>
</asp:Content>
