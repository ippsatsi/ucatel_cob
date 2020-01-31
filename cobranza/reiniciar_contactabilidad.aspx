<%@ Page Title="" Language="C#" MasterPageFile="~/resource/masterPage/Template.Master" AutoEventWireup="true" CodeBehind="reiniciar_contactabilidad.aspx.cs" Inherits="WEB.cobranza.reiniciar_contactabilidad" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="titulo" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="pageBar" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="antesTitulo" runat="server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="contenido" runat="server">
    <div class="col-md-12">
            <div class="portlet box blue">
                <div class="portlet-title">
                    <div class="caption">
                        <i class="fa fa-globe"></i> Lista de Periodos Faltantes</div>
                    <div class="tools"> </div>
                </div>
                <div class="portlet-body">
                    <div class="row">
                        <table id="tblListaPeriodosFaltantes" class="tblLista_grid table table-striped table-bordered table-hover dt-responsive" cellspacing="0" width="100%">
                            <thead>
                                <tr>
                                    <th class="all">N°</th>
                                    <th class="min-cartera">Proveedor</th>
                                    <th class="min-usuario">Cartera</th>
                                    <th class="min-cuenta">Sub Cartera</th>
                                    <th class="min-cliente">Periodo</th>
                                    <th class="min-dni">Reiniciar</th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
    </div>

    <div class="col-md-12">
            <div class="portlet box blue">
                <div class="portlet-title">
                    <div class="caption">
                        <i class="fa fa-globe"></i> Lista de Periodos Activos</div>
                    <div class="tools"> </div>
                </div>
                <div class="portlet-body">
                    <div class="row">
                        <table id="tblListaPeriodosActivos" class="tblLista_grid table table-striped table-bordered table-hover dt-responsive" cellspacing="0" width="100%">
                            <thead>
                                <tr>
                                    <th class="all">N°</th>
                                    <th class="min-cartera">Proveedor</th>
                                    <th class="min-usuario">Cartera</th>
                                    <th class="min-cuenta">Sub Cartera</th>
                                    <th class="min-cliente">Periodo</th>
                                    <th class="min-dni">Fecha Activación</th>
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
    <script type="text/javascript">
        $(document).ready(function () {
            listarPeriodosFaltantes();
            listarPeriodosActuales();
        });

        function activarPeriodo(codigo) {
            $.ajax({
                url: strServicio + "periodo.asmx/registrarPeriodo",
                data: "{'codigo':" + codigo + "}",
                dataType: 'JSON',
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                success: function (jsondata) {
                    if (jsondata.d == "CORRECTO") {
                        listarPeriodosActuales();
                        listarPeriodosFaltantes();
                        bootbox.alert("Periodo actualizado correctamente");
                    } else {
                        bootbox.alert("Se ha detectado un error. Inténtalo nuevamente.");
                    }
                }
            });
        }

        function reiniciarPeriodo(codigo) {
            $.ajax({
                url: strServicio + "periodo.asmx/reiniciarPeriodo",
                data: "{'codigo':" + codigo + "}",
                dataType: 'JSON',
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                success: function (jsondata) {
                    if (jsondata.d == "CORRECTO") {
                        listarPeriodosActuales();
                        listarPeriodosFaltantes();
                        bootbox.alert("Periodo reseteado correctamente");
                    } else {
                        bootbox.alert("Se ha detectado un error. Inténtalo nuevamente.");
                    }
                }
            });
        }
        
        function listarPeriodosFaltantes() {
            $.ajax({
                url: strServicio + "periodo.asmx/listarPeriodosFaltantes",
                dataType: 'JSON',
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                success: function (jsondata) {
                    var htmlText = "";
                    $("#tblListaPeriodosFaltantes tbody").empty();
                    $.each(jsondata.d, function (i, obj) {
                        htmlText = "<tr>" +
                                "<td>" + (i + 1) + "</td>" +
                                "<td>" + obj.PRV_NOMBRES + "</td>" +
                                "<td>" + obj.CAR_DESCRIPCION + "</td>" +
                                "<td>" + obj.SCA_DESCRIPCION + "</td>" +
                                "<td>" + (obj.PER_ACTIVO ? "<a class='form-control btn blue' onclick='activarPeriodo(" + obj.SCA_CODIGO + ");'>" + obj.PERIODO_ACTUAL + "</a>" : "") + "</td>" +
                                "<td><a class='form-control btn blue' onclick='reiniciarPeriodo(" + obj.SCA_CODIGO + ");'>REINICIAR</a></td>" +
                            "</tr>";

                        $("#tblListaPeriodosFaltantes tbody").append(htmlText);
                    });
                }
            });
        }

        function listarPeriodosActuales() {
            $.ajax({
                url: strServicio + "periodo.asmx/listarPeriodosActivos",
                dataType: 'JSON',
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                success: function (jsondata) {
                    var htmlText = "";
                    $("#tblListaPeriodosActivos tbody").empty();
                    $.each(jsondata.d, function (i, obj) {
                        htmlText = "<tr>" +
                                "<td>" + (i + 1) + "</td>" +
                                "<td>" + obj.PRV_NOMBRES + "</td>" +
                                "<td>" + obj.CAR_DESCRIPCION + "</td>" +
                                "<td>" + obj.SCA_DESCRIPCION + "</td>" +
                                "<td>" + obj.PER_CODIGO + "</td>" +
                                "<td>" + obj.PER_FECHA_REGISTRO + "</td>" +
                            "</tr>";

                        $("#tblListaPeriodosActivos tbody").append(htmlText);
                    });
                }
            });
        }
    </script>
</asp:Content>
