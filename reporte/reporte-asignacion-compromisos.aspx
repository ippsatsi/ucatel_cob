<%@ Page Title="" Language="C#" MasterPageFile="~/resource/masterPage/Template.Master" AutoEventWireup="true" CodeBehind="reporte-asignacion-compromisos.aspx.cs" Inherits="WEB.reporte.reporte_asignacion_compromisos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contenido" runat="server">
    <div class="row" id="div_contenido">
        <div class="col-md-12">

            <div class="portlet box blue">
                <div class="portlet-title">
                    <div class="caption">
                        <i class="fa fa-globe"></i> Reporte de Compromisos</div>
                    <div class="tools"> </div>
                </div>
                <div class="portlet-body">

                    <div class="row">
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 margin-bottom-20">
                            <div class="col-md-4">
                                <label>PROVEEDOR</label>
                                <select id="sltProveedor" class="form-control" runat="server">
                                    <option value="0">-SELECCIONA-</option>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <label>CARTERA</label>
                                <select id="sltCartera" class="form-control" runat="server">
                                    <option value="0">-SELECCIONA-</option>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <label>SUB CARTERA</label>
                                <select id="sltSubCartera" class="form-control" runat="server">
                                    <option value="0">-SELECCIONA-</option>
                                </select>
                            </div>
                        </div>

                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 margin-bottom-20">
                            <div class="col-md-3">
                                <label>FECHA DESDE</label>
                                <input type="text" id="txtDesde" runat="server" class="form-control date-picker">
                            </div>
                            <div class="col-md-3">
                                <label>FECHA HASTA</label>
                                <input type="text" id="txtHasta" runat="server" class="form-control date-picker">
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                                <label>&nbsp;</label>
                                <div>
                                    <a class="btn btn blue" id="btn_buscar">BUSCAR</a>
                                    <a class="btn blue" id="btn_imprimir_excel" runat="server" onclick="clk_imprimir_excel"><i class="fa fa-file-excel-o"></i> IMPORTAR EXCEL</a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <table id="tblLista" class="tblLista_grid table table-striped table-bordered table-hover dt-responsive" cellspacing="0" width="100%">
                        <thead>
                            <tr>
                                <th>N°</th>
                                <th>N° DOCUMENTO</th>
                                <th>N° CUENTA</th>
                                <th>TELEFONO</th>
                                <th>FECHA COMPROMISO</th>
                                <th>MONTO COMPROMISO</th>
                                <th>TIPO RESULTADO</th>
                                <th>SUB CARTERA</th>
                                <th>GESTION</th>
                                <th>ULTIMA GESTION</th>
                                <th>USUARIO</th>
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
            cargarProveedor();
            $("#btn_buscar").click(fnc_buscar);
            $("#contenido_sltProveedor").change(cargarCarteras);
            $("#contenido_sltCartera").change(cargarSubCarteras);

            $("#contenido_btn_imprimir_excel").click(function () {
                //bootbox.alert(1);
                var url = "imprimir.aspx?tipo=rep_asig_comp&prv_codigo=" + $("#contenido_sltProveedor").val() +
                    "&car_codigo=" + $("#contenido_sltCartera").val() +
                    "&sca_codigo=" + $("#contenido_sltSubCartera").val() +
                    "&fec_desde=" + $("#contenido_txtDesde").val().replace("/","$") +
                    "&fec_hasta=" + $("#contenido_txtHasta").val().replace("/", "$");
                window.open(url);
            });

            $(".date-picker").datepicker({
                format: "dd/mm/yyyy",
                //dateFormat: "dd/mm/yy",
                //firstDay: 1,
                //dayNamesMin: ["Do", "Lu", "Ma", "Mi", "Ju", "Vi", "Sa"],
                //dayNamesShort: ["Dom", "Lun", "Mar", "Mie", "Jue", "Vie", "Sab"],
                //monthNames:
                //    ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio",
                //    "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"],
                //monthNamesShort:
                //    ["Ene", "Feb", "Mar", "Abr", "May", "Jun",
                //    "Jul", "Ago", "Sep", "Oct", "Nov", "Dic"]
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
                abrir_preload('div_contenido');
                $.ajax({
                    url: strServicio+"reporte.asmx/reporteAsignacionCompromisos",
                    data: '{"prv_codigo":' + $("#contenido_sltProveedor").val() + ',"car_codigo":' + $("#contenido_sltCartera").val() + ',"sca_codigo":' + $("#contenido_sltSubCartera").val() + ',"fecha_desde":"' + $("#contenido_txtDesde").val() + '","fecha_hasta":"' + $("#contenido_txtHasta").val() + '"}',
                    dataType: 'JSON',
                    type: 'POST',
                    contentType: "application/json; charset=utf-8",
                    success: function (jsondata) {
                        cerrar_preload('div_contenido');
                        $("#tblLista tbody").empty();
                        var htmlText = "";
                        $.each(jsondata.d, function (i, obj) {
                            htmlText = "<tr>" +
                                    "<td>" + (i+1) + "</td>" +
                                    "<td>" + obj.CLI_DOCUMENTO_IDENTIDAD + "</td>" +
                                    "<td>" + obj.CUE_NROCUENTA + "</td>" +
                                    "<td>" + obj.TEL_NUMERO + "</td>" +
                                    "<td>" + obj.FECHA_COMPROMISO + "</td>" +
                                    "<td>" + obj.GES_IMPORTE_INICIAL + "</td>" +
                                    "<td>" + obj.TIR_DESCRIPCION + "</td>" +
                                    "<td>" + obj.SCA_DESCRIPCION + "</td>" +
                                    "<td>" + obj.GESTION + "</td>" +
                                    "<td>" + obj.ULTIMA_GESTION + "</td>" +
                                    "<td>" + obj.USU_LOGIN + "</td>" +
                                "</tr>";
                            $("#tblLista tbody").append(htmlText);
                        });
                    }
                });
            }
function borrarRetirados(select_box,obj) {
    if ( obj.key.endsWith("XX") ) {
       console.log(obj.key) }
    else {
       $(select_box).append("<option value='" + obj.value + "'>" + obj.key + "</option>");
    }
}

function cargarProveedor() {
    $.ajax({
        url: strServicio + "general.asmx/cargarProveedor",
        dataType: 'JSON',
        type: 'POST',
        contentType: "application/json; charset=utf-8",
        success: function (jsondata) {
            //$("#contenido_sltProveedor").empty();
            $.each(jsondata.d, function (i, obj) {
              //  $("#contenido_sltProveedor").append("<option value='" + obj.value + "'>" + obj.key + "</option>");
              borrarRetirados("#contenido_sltProveedor",obj);
            });
            //console.log(jsondata.d);
        }
    });
}

function cargarCarteras() {
    $.ajax({
        url: strServicio + "general.asmx/cargarCarteras",
        data: '{"PRV_CODIGO":"' + $("#contenido_sltProveedor").val() + '"}',
        dataType: 'JSON',
        type: 'POST',
        contentType: "application/json; charset=utf-8",
        success: function (jsondata) {
            $("#contenido_sltCartera").empty();
            $("#contenido_sltCartera").append("<option value='0'>-SELECCIONA-</option>");
            $.each(jsondata.d, function (i, obj) {
              //  $("#contenido_sltCartera").append("<option value='" + obj.value + "'>" + obj.key + "</option>");
              borrarRetirados("#contenido_sltCartera",obj);
            });
            //console.log(jsondata.d);
        }
    });
}

function cargarSubCarteras() {
    $.ajax({
        url: strServicio + "general.asmx/cargarSubCarteras",
        data: '{"CAR_CODIGO":"' + $("#contenido_sltCartera").val() + '"}',
        dataType: 'JSON',
        type: 'POST',
        contentType: "application/json; charset=utf-8",
        success: function (jsondata) {
            $("#contenido_sltSubCartera").empty();
            $("#contenido_sltSubCartera").append("<option value='0'>-SELECCIONA-</option>");
            $.each(jsondata.d, function (i, obj) {
              //  $("#contenido_sltSubCartera").append("<option value='" + obj.value + "'>" + obj.key + "</option>");
               borrarRetirados("#contenido_sltSubCartera",obj);
            });
            //console.log(jsondata.d);
        }
    });
} 
        });
    </script>
</asp:Content>
