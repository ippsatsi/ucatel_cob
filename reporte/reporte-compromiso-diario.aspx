<%@ Page Title="" Language="C#" MasterPageFile="~/resource/masterPage/Template.Master" AutoEventWireup="true" CodeBehind="reporte-compromiso-diario.aspx.cs" Inherits="WEB.reporte.reporte_compromiso_diario" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contenido" runat="server">
    <div class="bandeja-contenido" style="height: 145px !important;">
        <div class="bandeja_buscar_contenido">
            <%--<div class="bandeja_buscar_header">
                <span>Buscar Dispensa ingresada:</span>
            </div>--%>
            <h1>REPORTE COMPROMISO DIARIO</h1>
            <asp:HiddenField runat="server" ID="txtIdUsuario"/>
            <asp:HiddenField runat="server" ID="txtRol"/>
            <div class="table_bandeja_buscar">
                <div>
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
                            <span>AÑO</span>
                        </div>
                        <div>
                            <select id="sltAno">
                                <option value="2016">2016</option>
                                <option value="2017">2017</option>
                            </select>
                        </div>
                    </div>
                    <div class="cell">
                        <div class="cell_contenido">
                            <span>MES</span>
                        </div>
                        <div>
                            <select id="sltMes">
                                <option value="0">-SELECCIONE-</option>
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
        <table id="tblLista" class="tblLista_grid">
            <thead>
                <tr>
                    <th>SEDE</th>
                    <th>CALL/GESTOR</th>
                    <%--<th>CTAS. ASIG.</th>--%>
                    <th>1</th>
                    <th>2</th>
                    <th>3</th>
                    <th>4</th>
                    <th>5</th>
                    <th>6</th>
                    <th>7</th>
                    <th>8</th>
                    <th>9</th>
                    <th>10</th>
                    <th>11</th>
                    <th>12</th>
                    <th>13</th>
                    <th>14</th>
                    <th>15</th>
                    <th>16</th>
                    <th>17</th>
                    <th>18</th>
                    <th>19</th>
                    <th>20</th>
                    <th>21</th>
                    <th>22</th>
                    <th>23</th>
                    <th>24</th>
                    <th>25</th>
                    <th>26</th>
                    <th>27</th>
                    <th>28</th>
                    <th>29</th>
                    <th>30</th>
                    <th>31</th>
                    <th>TOTAL</th>
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
            fnc_buscar();

            $("#btn_buscar").click(fnc_buscar);
        });

        function fnc_buscar() {
            var codigo_encargado = 0;
            if ($("#contenido_txtRol").val() == "2") {
                codigo_encargado = $("#contenido_txtIdUsuario").val();
            }

            $.ajax({
                url: strServicio+"reporte.asmx/reporteCompromisoDiario",
                data: '{"enc_sede":' + codigo_encargado + ',"usuario":' + $("#sltUsuario").val() + ',"ano":' + $("#sltAno").val() + ',"mes":' + $("#sltMes").val() + '}',
                dataType: 'JSON',
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                success: function (jsondata) {
                    $("#tblLista tbody").empty();
                    var TOTDIA1 = 0,
                        TOTDIA2 = 0,
                        TOTDIA3 = 0,
                        TOTDIA4 = 0,
                        TOTDIA5 = 0,
                        TOTDIA6 = 0,
                        TOTDIA7 = 0,
                        TOTDIA8 = 0,
                        TOTDIA9 = 0,
                        TOTDIA10 = 0,
                        TOTDIA11 = 0,
                        TOTDIA12 = 0,
                        TOTDIA13 = 0,
                        TOTDIA14 = 0,
                        TOTDIA15 = 0,
                        TOTDIA16 = 0,
                        TOTDIA17 = 0,
                        TOTDIA18 = 0,
                        TOTDIA19 = 0,
                        TOTDIA20 = 0,
                        TOTDIA21 = 0,
                        TOTDIA22 = 0,
                        TOTDIA23 = 0,
                        TOTDIA24 = 0,
                        TOTDIA25 = 0,
                        TOTDIA26 = 0,
                        TOTDIA27 = 0,
                        TOTDIA28 = 0,
                        TOTDIA29 = 0,
                        TOTDIA30 = 0,
                        TOTDIA31 = 0,
                        TOTAL = 0;
                    $.each(jsondata.d, function (i, obj) {
                        var htmlText = "<tr" + (i % 2 == 0 ? " class='row_listabandejavirtual'" : "") + ">" +
                            "<td>" + obj.SEDE + "</td>" +
                            "<td>" + obj.GESTOR + "</td>" +
                            //"<td style='background-color: #131313;color: white;font-size: 17px;'>" + obj.CTA_ASIG + "</td>" +
                            "<td>" + obj.DIA1 + (obj.DIA1_PAG == "0" ? "" : " <span style='color:red'>" + obj.DIA1_PAG + "</span>") + "</td>" +
                            "<td>" + obj.DIA2 + (obj.DIA2_PAG == "0" ? "" : " <span style='color:red'>" + obj.DIA2_PAG + "</span>") + "</td>" +
                            "<td>" + obj.DIA3 + (obj.DIA3_PAG == "0" ? "" : " <span style='color:red'>" + obj.DIA3_PAG + "</span>") + "</td>" +
                            "<td>" + obj.DIA4 + (obj.DIA4_PAG == "0" ? "" : " <span style='color:red'>" + obj.DIA4_PAG + "</span>") + "</td>" +
                            "<td>" + obj.DIA5 + (obj.DIA5_PAG == "0" ? "" : " <span style='color:red'>" + obj.DIA5_PAG + "</span>") + "</td>" +
                            "<td>" + obj.DIA6 + (obj.DIA6_PAG == "0" ? "" : " <span style='color:red'>" + obj.DIA6_PAG + "</span>") + "</td>" +
                            "<td>" + obj.DIA7 + (obj.DIA7_PAG == "0" ? "" : " <span style='color:red'>" + obj.DIA7_PAG + "</span>") + "</td>" +
                            "<td>" + obj.DIA8 + (obj.DIA8_PAG == "0" ? "" : " <span style='color:red'>" + obj.DIA8_PAG + "</span>") + "</td>" +
                            "<td>" + obj.DIA9 + (obj.DIA9_PAG == "0" ? "" : " <span style='color:red'>" + obj.DIA9_PAG + "</span>") + "</td>" +
                            "<td>" + obj.DIA10 + (obj.DIA10_PAG == "0" ? "" : " <span style='color:red'>" + obj.DIA10_PAG + "</span>") + "</td>" +
                            "<td>" + obj.DIA11 + (obj.DIA11_PAG == "0" ? "" : " <span style='color:red'>" + obj.DIA11_PAG + "</span>") + "</td>" +
                            "<td>" + obj.DIA12 + (obj.DIA12_PAG == "0" ? "" : " <span style='color:red'>" + obj.DIA12_PAG + "</span>") + "</td>" +
                            "<td>" + obj.DIA13 + (obj.DIA13_PAG == "0" ? "" : " <span style='color:red'>" + obj.DIA13_PAG + "</span>") + "</td>" +
                            "<td>" + obj.DIA14 + (obj.DIA14_PAG == "0" ? "" : " <span style='color:red'>" + obj.DIA14_PAG + "</span>") + "</td>" +
                            "<td>" + obj.DIA15 + (obj.DIA15_PAG == "0" ? "" : " <span style='color:red'>" + obj.DIA15_PAG + "</span>") + "</td>" +
                            "<td>" + obj.DIA16 + (obj.DIA16_PAG == "0" ? "" : " <span style='color:red'>" + obj.DIA16_PAG + "</span>") + "</td>" +
                            "<td>" + obj.DIA17 + (obj.DIA17_PAG == "0" ? "" : " <span style='color:red'>" + obj.DIA17_PAG + "</span>") + "</td>" +
                            "<td>" + obj.DIA18 + (obj.DIA18_PAG == "0" ? "" : " <span style='color:red'>" + obj.DIA18_PAG + "</span>") + "</td>" +
                            "<td>" + obj.DIA19 + (obj.DIA19_PAG == "0" ? "" : " <span style='color:red'>" + obj.DIA19_PAG + "</span>") + "</td>" +
                            "<td>" + obj.DIA20 + (obj.DIA20_PAG == "0" ? "" : " <span style='color:red'>" + obj.DIA20_PAG + "</span>") + "</td>" +
                            "<td>" + obj.DIA21 + (obj.DIA21_PAG == "0" ? "" : " <span style='color:red'>" + obj.DIA21_PAG + "</span>") + "</td>" +
                            "<td>" + obj.DIA22 + (obj.DIA22_PAG == "0" ? "" : " <span style='color:red'>" + obj.DIA22_PAG + "</span>") + "</td>" +
                            "<td>" + obj.DIA23 + (obj.DIA23_PAG == "0" ? "" : " <span style='color:red'>" + obj.DIA23_PAG + "</span>") + "</td>" +
                            "<td>" + obj.DIA24 + (obj.DIA24_PAG == "0" ? "" : " <span style='color:red'>" + obj.DIA24_PAG + "</span>") + "</td>" +
                            "<td>" + obj.DIA25 + (obj.DIA25_PAG == "0" ? "" : " <span style='color:red'>" + obj.DIA25_PAG + "</span>") + "</td>" +
                            "<td>" + obj.DIA26 + (obj.DIA26_PAG == "0" ? "" : " <span style='color:red'>" + obj.DIA26_PAG + "</span>") + "</td>" +
                            "<td>" + obj.DIA27 + (obj.DIA27_PAG == "0" ? "" : " <span style='color:red'>" + obj.DIA27_PAG + "</span>") + "</td>" +
                            "<td>" + obj.DIA28 + (obj.DIA28_PAG == "0" ? "" : " <span style='color:red'>" + obj.DIA28_PAG + "</span>") + "</td>" +
                            "<td>" + obj.DIA29 + (obj.DIA29_PAG == "0" ? "" : " <span style='color:red'>" + obj.DIA29_PAG + "</span>") + "</td>" +
                            "<td>" + obj.DIA30 + (obj.DIA30_PAG == "0" ? "" : " <span style='color:red'>" + obj.DIA30_PAG + "</span>") + "</td>" +
                            "<td>" + obj.DIA31 + (obj.DIA31_PAG == "0" ? "" : " <span style='color:red'>" + obj.DIA31_PAG + "</span>") + "</td>" +
                            "<td style='background-color: #131313;color: white;font-size: 17px;'>" + obj.TOTAL + "</td>" +
                        "</tr>";
                        $("#tblLista tbody").append(htmlText);
                        TOTDIA1 += parseInt(obj.DIA1);
                        TOTDIA2 += parseInt(obj.DIA2);
                        TOTDIA3 += parseInt(obj.DIA3);
                        TOTDIA4 += parseInt(obj.DIA4);
                        TOTDIA5 += parseInt(obj.DIA5);
                        TOTDIA6 += parseInt(obj.DIA6);
                        TOTDIA7 += parseInt(obj.DIA7);
                        TOTDIA8 += parseInt(obj.DIA8);
                        TOTDIA9 += parseInt(obj.DIA9);
                        TOTDIA10 += parseInt(obj.DIA10);
                        TOTDIA11 += parseInt(obj.DIA11);
                        TOTDIA12 += parseInt(obj.DIA12);
                        TOTDIA13 += parseInt(obj.DIA13);
                        TOTDIA14 += parseInt(obj.DIA14);
                        TOTDIA15 += parseInt(obj.DIA15);
                        TOTDIA16 += parseInt(obj.DIA16);
                        TOTDIA17 += parseInt(obj.DIA17);
                        TOTDIA18 += parseInt(obj.DIA18);
                        TOTDIA19 += parseInt(obj.DIA19);
                        TOTDIA20 += parseInt(obj.DIA20);
                        TOTDIA21 += parseInt(obj.DIA21);
                        TOTDIA22 += parseInt(obj.DIA22);
                        TOTDIA23 += parseInt(obj.DIA23);
                        TOTDIA24 += parseInt(obj.DIA24);
                        TOTDIA25 += parseInt(obj.DIA25);
                        TOTDIA26 += parseInt(obj.DIA26);
                        TOTDIA27 += parseInt(obj.DIA27);
                        TOTDIA28 += parseInt(obj.DIA28);
                        TOTDIA29 += parseInt(obj.DIA29);
                        TOTDIA30 += parseInt(obj.DIA30);
                        TOTDIA31 += parseInt(obj.DIA31);
                        TOTAL += parseInt(obj.TOTAL);
                    });

                    var htmlText = "<tr>" +
                            "<th></th>" +
                            //"<th></th>" +
                            "<th></th>" +
                            "<th>" + TOTDIA1 + "</th>" +
                            "<th>" + TOTDIA2 + "</th>" +
                            "<th>" + TOTDIA3 + "</th>" +
                            "<th>" + TOTDIA4 + "</th>" +
                            "<th>" + TOTDIA5 + "</th>" +
                            "<th>" + TOTDIA6 + "</th>" +
                            "<th>" + TOTDIA7 + "</th>" +
                            "<th>" + TOTDIA8 + "</th>" +
                            "<th>" + TOTDIA9 + "</th>" +
                            "<th>" + TOTDIA10 + "</th>" +
                            "<th>" + TOTDIA11 + "</th>" +
                            "<th>" + TOTDIA12 + "</th>" +
                            "<th>" + TOTDIA13 + "</th>" +
                            "<th>" + TOTDIA14 + "</th>" +
                            "<th>" + TOTDIA15 + "</th>" +
                            "<th>" + TOTDIA16 + "</th>" +
                            "<th>" + TOTDIA17 + "</th>" +
                            "<th>" + TOTDIA18 + "</th>" +
                            "<th>" + TOTDIA19 + "</th>" +
                            "<th>" + TOTDIA20 + "</th>" +
                            "<th>" + TOTDIA21 + "</th>" +
                            "<th>" + TOTDIA22 + "</th>" +
                            "<th>" + TOTDIA23 + "</th>" +
                            "<th>" + TOTDIA24 + "</th>" +
                            "<th>" + TOTDIA25 + "</th>" +
                            "<th>" + TOTDIA26 + "</th>" +
                            "<th>" + TOTDIA27 + "</th>" +
                            "<th>" + TOTDIA28 + "</th>" +
                            "<th>" + TOTDIA29 + "</th>" +
                            "<th>" + TOTDIA30 + "</th>" +
                            "<th>" + TOTDIA31 + "</th>" +
                            "<th>" + TOTAL + "</th>" +
                        "</tr>";
                    $("#tblLista tfoot").empty();
                    $("#tblLista tfoot").append(htmlText);
                }
            });
        }

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
    </script>
</asp:Content>
