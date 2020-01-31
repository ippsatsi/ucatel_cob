<%@ Page Title="" Language="C#" MasterPageFile="~/resource/masterPage/Template.Master" AutoEventWireup="true" CodeBehind="reporte-indicadores-gestion.aspx.cs" Inherits="WEB.reporte.reporte_indicadores_gestion" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contenido" runat="server">
    <div class="bandeja-contenido" style="height: 145px !important;">
        <div class="bandeja_buscar_contenido">
            <%--<div class="bandeja_buscar_header">
                <span>Buscar Dispensa ingresada:</span>
            </div>--%>
            <asp:HiddenField runat="server" ID="txtIdUsuario"/>
            <asp:HiddenField runat="server" ID="txtRol"/>
            <div class="table_bandeja_buscar">
                <h1>REPORTE INDICADORES DE GESTION</h1>
                <div>
                    <div class="cell">
                        <div class="cell_contenido">
                            <span>PROVEEDOR</span>
                        </div>
                        <div>
                            <select id="sltProveedor">
                                <option value="0">-SELECCIONA-</option>
                            </select>
                        </div>
                    </div>
                    <div class="cell">
                        <div class="cell_contenido">
                            <span>CARTERA</span>
                        </div>
                        <div>
                            <select id="sltCartera">
                                <option value="0">-SELECCIONA-</option>
                            </select>
                        </div>
                    </div>
                    <div class="cell">
                        <div class="cell_contenido">
                            <span>SUB CARTERA</span>
                        </div>
                        <div>
                            <select id="sltSubCartera">
                                <option value="0">-SELECCIONA-</option>
                            </select>
                        </div>
                    </div>
                    <div class="cell">
                        <div class="cell_contenido">
                            <span>USUARIO</span>
                        </div>
                        <div>
                            <select id="sltUsuario">
                                <option value="0">-TODOS-</option>
                            </select>
                        </div>
                    </div>
                    <div class="cell">
                        <div class="cell_contenido">
                            <span>FECHA DESDE</span>
                        </div>
                        <div>
                            <input type="text" id="txtDesde" class="grande08 date-picker">
                        </div>
                    </div>
                    <div class="cell">
                        <div class="cell_contenido">
                            <span>FECHA HASTA</span>
                        </div>
                        <div>
                            <input type="text" id="txtHasta" class="grande08 date-picker">
                        </div>
                    </div>
                    <div class="cell">
                        <div class="cell_contenido">
                            <a class="btn_buscar" id="btn_buscar">BUSCAR</a>
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
                    <th rowspan="2" style="padding-left: 15px;">N°</th>
                    <%--<th rowspan="2" style="padding-left: 15px;">ACTIVO</th>--%>
                    <th rowspan="2" style="padding-left: 15px;">USUARIO</th>
                    <th colspan="6" style="padding-left: 15px;">RECORRIDO</th>
                    <th colspan="2" style="padding-left: 15px;">C. DIRECTO</th>
                    <th colspan="2" style="padding-left: 15px;">C. INDIRECTO</th>
                    <th colspan="2" style="padding-left: 15px;">NO CONTACTO</th>
                    <th colspan="3" style="padding-left: 15px;">CIERRE GESTIÓN</th>
                    <th colspan="3" style="padding-left: 15px;">EFECTIVIDAD</th>
                </tr>
                <tr>
                    <th style="padding-left: 15px;">CAPITAL</th>
                    <th style="padding-left: 15px;">CLIENTES</th>
                    <th style="padding-left: 15px;">AVANCE</th>
                    <th style="padding-left: 15px;">% CUMPL</th>
                    <th style="padding-left: 15px;">GESTIONES</th>
                    <th style="padding-left: 15px;">INTENSIDAD</th>
                    <th style="padding-left: 15px;">CLIENTES</th>
                    <th style="padding-left: 15px;">% CD</th>
                    <th style="padding-left: 15px;">CLIENTES</th>
                    <th style="padding-left: 15px;">% CI</th>
                    <th style="padding-left: 15px;">CLIENTES</th>
                    <th style="padding-left: 15px;">% NC</th>
                    <th style="padding-left: 15px;">COMPROM</th>
                    <th style="padding-left: 15px;">IMP. ACUM.</th>
                    <th style="padding-left: 15px;">% COMPR</th>
                    <th style="padding-left: 15px;">PAGOS</th>
                    <th style="padding-left: 15px;">IMP. ACUM.</th>
                    <th style="padding-left: 15px;">% PAGOS</th>
                </tr>
            </thead>
            <tbody>
            </tbody>
            <tfoot>
            </tfoot>
        </table>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            cargarProveedor();
            cargarUsuario();
            $("#sltProveedor").change(cargarCarteras);
            $("#sltCartera").change(cargarSubCarteras);

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

            fnc_buscar();

            $("#btn_buscar").click(fnc_buscar);
        });

        function fnc_buscar() {
            $.ajax({
                url: strServicio+"reporte.asmx/reporteIndicadorGestion",
                data: '{"prv_codigo":"' + $("#sltProveedor").val() + '","car_codigo":"' + $("#sltCartera").val() + '","sca_codigo":"' + $("#sltSubCartera").val() + '","usu_codigo":"' + $("#sltUsuario").val() + '","fecha_desde":"' + $("#txtDesde").val() + '","fecha_hasta":"' + $("#txtHasta").val() + '"}',
                dataType: 'JSON',
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                success: function (jsondata) {
                    var htmlText = "";
                    $("#tblLista tbody").empty();
                    $.each(jsondata.d, function (i, obj) {
                        //if (obj.AVANCE != "") {
                            htmlText = "<tr>" +
                                    "<td>" + (i + 1) + "</td>" +
                                    //"<td>" + obj.USU_ESTADO_REGISTRO + "</td>" +
                                    "<td>" + obj.USU_LOGIN + "</td>" +
                                    "<td class='alignRight'>" + obj.CAPITAL + "</td>" +
                                    "<td class='alignRight'>" + (obj.CAPITAL == "" ? "0" : obj.CLIENTES) + "</td>" +
                                    "<td class='alignRight'>" + obj.AVANCE + "</td>" +
                                    "<td class='alignRight'>" + obj.PORC_CUMPL + (obj.REC_COLOR != "" ? "&nbsp;<img src='resource/img/semaforo/" + obj.REC_COLOR + ".png'/>" : "") + "</td>" +
                                    "<td class='alignRight'>" + obj.GESTIONES + "</td>" +
                                    "<td class='alignRight'>" + obj.INTENSIDAD + "</td>" +
                                    "<td class='alignRight'>" + obj.CD_CLIENTE + "</td>" +
                                    "<td class='alignRight'>" + obj.CD_CLIENTE_PORC + (obj.CDI_COLOR != "" ? "&nbsp;<img src='resource/img/semaforo/" + obj.CDI_COLOR + ".png'/>" : "") + "</td>" +
                                    "<td class='alignRight'>" + obj.CI_CLIENTE + "</td>" +
                                    "<td class='alignRight'>" + obj.CI_CLIENTE_PORC + (obj.CIN_COLOR != "" ? "&nbsp;<img src='resource/img/semaforo/" + obj.CIN_COLOR + ".png'/>" : "") + "</td>" +
                                    "<td class='alignRight'>" + obj.NC_CLIENTE + "</td>" +
                                    "<td class='alignRight'>" + obj.NC_CLIENTE_PORC + (obj.NCO_COLOR != "" ? "&nbsp;<img src='resource/img/semaforo/" + obj.NCO_COLOR + ".png'/>" : "") + "</td>" +
                                    "<td class='alignRight'>" + obj.CANT_COMPR + "</td>" +
                                    "<td class='alignRight'>" + obj.MONT_COMPR + "</td>" +
                                    "<td class='alignRight'>" + obj.CANT_COMPR_PORC + (obj.CGE_COLOR != "" ? "&nbsp;<img src='resource/img/semaforo/" + obj.CGE_COLOR + ".png'/>" : "") + "</td>" +
                                    "<td class='alignRight'>" + obj.CANT_PAGOS + "</td>" +
                                    "<td class='alignRight'>" + obj.MONT_PAGO + "</td>" +
                                    "<td class='alignRight'>" + obj.CANT_PAGO_PORC + (obj.EFE_COLOR != "" ? "&nbsp;<img src='resource/img/semaforo/" + obj.EFE_COLOR + ".png'/>" : "") + "</td>" +
                                "</tr>";
                            $("#tblLista tbody").append(htmlText);
                        //}
                    });
                }
            });
        }

        function cargarUsuario() {
            $.ajax({
                url: strServicio+"general.asmx/listarUsuariosGestion",
                dataType: 'JSON',
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                success: function (jsondata) {
                    //$("#sltProveedor").empty();
                    $.each(jsondata.d, function (i, obj) {
                        $("#sltUsuario").append("<option value='" + obj.value + "'>" + obj.key + "</option>");
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
                        $("#sltProveedor").append("<option value='" + obj.value + "'>" + obj.key + "</option>");
                    });
                }
            });
        }
        
        function cargarCarteras() {
            $.ajax({
                url: strServicio+"general.asmx/cargarCarteras",
                data: '{"PRV_CODIGO":"' + $("#sltProveedor").val() + '"}',
                dataType: 'JSON',
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                success: function (jsondata) {
                    $("#sltCartera").empty();
                    $("#sltCartera").append("<option value='0'>-SELECCIONA-</option>");
                    $.each(jsondata.d, function (i, obj) {
                        $("#sltCartera").append("<option value='" + obj.value + "'>" + obj.key + "</option>");
                    });
                }
            });
        }

        function cargarSubCarteras() {
            $.ajax({
                url: strServicio+"general.asmx/cargarSubCarteras",
                data: '{"CAR_CODIGO":"' + $("#sltCartera").val() + '"}',
                dataType: 'JSON',
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                success: function (jsondata) {
                    $("#sltSubCartera").empty();
                    $("#sltSubCartera").append("<option value='0'>-SELECCIONA-</option>");
                    $.each(jsondata.d, function (i, obj) {
                        $("#sltSubCartera").append("<option value='" + obj.value + "'>" + obj.key + "</option>");
                    });
                    buscarCarga();
                }
            });
        }
    </script>
</asp:Content>
