<%@ Page Title="" Language="C#" MasterPageFile="~/resource/masterPage/Template.Master" AutoEventWireup="true" CodeBehind="reporte-excel-compromisos.aspx.cs" Inherits="WEB.reporte.reporte_excel_compromisos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contenido" runat="server">
    <div class="bandeja-contenido" style="height: 145px !important;">
        <div class="bandeja_buscar_contenido">
            <div class="table_bandeja_buscar">
                <div>
                    <div class="cell">
                        <div class="cell_contenido">
                            <span>PROVEEDOR</span>
                        </div>
                        <div>
                            <select id="sltProveedor" runat="server">
                                <option value="0">-SELECCIONA-</option>
                            </select>
                        </div>
                    </div>
                    <div class="cell">
                        <div class="cell_contenido">
                            <span>CARTERA</span>
                        </div>
                        <div>
                            <select id="sltCartera" runat="server">
                                <option value="0">-SELECCIONA-</option>
                            </select>
                        </div>
                    </div>
                    <div class="cell">
                        <div class="cell_contenido">
                            <span>SUB CARTERA</span>
                        </div>
                        <div>
                            <select id="sltSubCartera" runat="server">
                                <option value="0">-SELECCIONA-</option>
                            </select>
                        </div>
                    </div>
                    <div class="cell">
                        <div class="cell_contenido">
                            <span>FECHA DESDE</span>
                        </div>
                        <div>
                            <input type="text" id="txtDesde" runat="server" class="grande08 date-picker" style="width:150px">
                        </div>
                    </div>
                    <div class="cell">
                        <div class="cell_contenido">
                            <span>FECHA HASTA</span>
                        </div>
                        <div>
                            <input type="text" id="txtHasta" runat="server" class="grande08 date-picker" style="width:150px">
                        </div>
                    </div>
                    <div class="cell">
                        <div class="cell_contenido">
                            <a class="btn_buscar" id="btn_buscar">BUSCAR</a>
                        </div>
                    </div>
                </div>
                <div>
                    <div class="cell">
                        <div class="cell_contenido">
                            <%--<asp:Button runat="server" OnClick="btn_imprimir_excel_Click" Text="IMPRIMIR EXCEL"/>--%>
                            <a id="btn_imprimir_excel" runat="server" onclick="clk_imprimir_excel">IMPORTAR EXCEL <img src="resource/img/icons/print-excel.png" /></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="bandeja-grid">
        <table id="tblLista" class="tblLista_grid" style="font-size:12px;">
            <thead>
                <tr>
                    <th>N°</th>
                    <th>N° CUENTA</th>
                    <th>NOMBRE COMPLETO</th>
                    <th>MONTO COMPROMISO</th>
                    <th>FECHA PAGO</th>
                    <th>GESTOR</th>
                    <th>OBSERVACIONES</th>
                </tr>
            </thead>
            <tbody></tbody>
        </table>
    </div>  
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            cargarProveedor();
            $("#btn_buscar").click(fnc_buscar);
            $("#contenido_sltProveedor").change(cargarCarteras);
            $("#contenido_sltCartera").change(cargarSubCarteras);

            $("#contenido_btn_imprimir_excel").click(function () {
                //bootbox.alert(1);
                var url = "imprimir.aspx?tipo=rep_com&prv_codigo=" + $("#contenido_sltProveedor").val() +
                    "&car_codigo=" + $("#contenido_sltCartera").val() +
                    "&sca_codigo=" + $("#contenido_sltSubCartera").val() +
                    "&fec_desde=" + $("#contenido_txtDesde").val().replace("/","$") +
                    "&fec_hasta=" + $("#contenido_txtHasta").val().replace("/", "$");
                window.open(url);
            });

            $(".date-picker").datepicker({
                dateFormat: "dd/mm/yy",
                firstDay: 1,
                dayNamesMin: ["Do", "Lu", "Ma", "Mi", "Ju", "Vi", "Sa"],
                dayNamesShort: ["Dom", "Lun", "Mar", "Mie", "Jue", "Vie", "Sab"],
                monthNames:
                    ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio",
                    "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"],
                monthNamesShort:
                    ["Ene", "Feb", "Mar", "Abr", "May", "Jun",
                    "Jul", "Ago", "Sep", "Oct", "Nov", "Dic"]
            });

            $("#contenido_txtDesde").val(obtenerFechaActual);
            $("#contenido_txtHasta").val(obtenerFechaActual);

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

            function fnc_buscar() {
                $.ajax({
                    url: strServicio+"reporte.asmx/reporteExcelCompromiso",
                    data: '{"prv_codigo":' + $("#contenido_sltProveedor").val() + ',"car_codigo":' + $("#contenido_sltCartera").val() + ',"sca_codigo":' + $("#contenido_sltSubCartera").val() + ',"fecha_desde":"' + $("#contenido_txtDesde").val() + '","fecha_hasta":"' + $("#contenido_txtHasta").val() + '"}',
                    dataType: 'JSON',
                    type: 'POST',
                    contentType: "application/json; charset=utf-8",
                    success: function (jsondata) {
                        $("#tblLista tbody").empty();
                        var htmlText = "";
                        $.each(jsondata.d, function (i, obj) {
                            htmlText = "<tr>" +
                                    "<td>" + (i+1) + "</td>" +
                                    "<td>" + obj.CUE_NROCUENTA + "</td>" +
                                    "<td>" + obj.CLI_NOMBRE_COMPLETO + "</td>" +
                                    "<td>" + obj.GES_IMPORTE_INICIAL + "</td>" +
                                    "<td>" + obj.GES_FECHA_INICIAL + "</td>" +
                                    "<td>" + obj.USU_LOGIN + "</td>" +
                                    "<td>" + obj.GES_OBSERVACIONES + "</td>" +
                                "</tr>";
                            $("#tblLista tbody").append(htmlText);
                        });
                    }
                });
            }

            function cargarProveedor() {
                $.ajax({
                    url: strServicio+"general.asmx/cargarProveedor",
                    dataType: 'JSON',
                    type: 'POST',
                    contentType: "application/json; charset=utf-8",
                    success: function (jsondata) {
                        //$("#sltProveedor").empty();
                        $.each(jsondata.d, function (i, obj) {
                            $("#contenido_sltProveedor").append("<option value='" + obj.value + "'>" + obj.key + "</option>");
                        });
                    }
                });
            }

            function cargarCarteras() {
                $.ajax({
                    url: strServicio+"general.asmx/cargarCarteras",
                    data: '{"PRV_CODIGO":"' + $("#contenido_sltProveedor").val() + '"}',
                    dataType: 'JSON',
                    type: 'POST',
                    contentType: "application/json; charset=utf-8",
                    success: function (jsondata) {
                        $("#contenido_sltCartera").empty();
                        $("#contenido_sltCartera").append("<option value='0'>-SELECCIONA-</option>");
                        $.each(jsondata.d, function (i, obj) {
                            $("#contenido_sltCartera").append("<option value='" + obj.value + "'>" + obj.key + "</option>");
                        });
                    }
                });
            }

            function cargarSubCarteras() {
                $.ajax({
                    url: strServicio+"general.asmx/cargarSubCarteras",
                    data: '{"CAR_CODIGO":"' + $("#contenido_sltCartera").val() + '"}',
                    dataType: 'JSON',
                    type: 'POST',
                    contentType: "application/json; charset=utf-8",
                    success: function (jsondata) {
                        $("#contenido_sltSubCartera").empty();
                        $("#contenido_sltSubCartera").append("<option value='0'>-SELECCIONA-</option>");
                        $.each(jsondata.d, function (i, obj) {
                            $("#contenido_sltSubCartera").append("<option value='" + obj.value + "'>" + obj.key + "</option>");
                        });
                    }
                });
            }
        });
    </script>
</asp:Content>
