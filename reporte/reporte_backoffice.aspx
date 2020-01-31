<%@ Page Title="" Language="C#" MasterPageFile="~/resource/masterPage/Template.Master" AutoEventWireup="true" CodeBehind="reporte_backoffice.aspx.cs" Inherits="WEB.reporte.reporte_backoffice" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contenido" runat="server">
      <div class="row">
        <div class="col-md-12">
            <div class="portlet box blue">
                <div class="portlet-title">
                    <div class="caption">
                        <i class="fa fa-globe"></i> Reporte de back Office</div>
                    <div class="tools"> </div>
                </div>
                <div class="portlet-body">
                    <div class="row">
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 margin-bottom-20">
                            <div class="col-md-4">
                                <label>PROVEEDOR</label>
                                <select id="sltProveedor" class="form-control" >
                                    <option value="0">-SELECCIONA-</option>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <label>CARTERA</label>
                                <select id="sltCartera" class="form-control" >
                                    <option value="0">-SELECCIONA-</option>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <label>SUB CARTERA</label>
                                <select id="sltSubCartera" class="form-control">
                                    <option value="0">-SELECCIONA-</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 margin-bottom-20">
                            <div class="col-md-3">
                                <label>FECHA DESDE</label>
                                <input type="text" id="txtDesde" class="form-control date-picker" />
                            </div>
                            <div class="col-md-3">
                                <label>FECHA HASTA</label>
                                <input type="text" id="txtHasta" class="form-control date-picker" />
                            </div>
                            <div class="col-md-3">
                                <label>SEPARADOR</label>
                                <select class="form-control" id="sltSeparador">
                                    <option value="S">SIN</option>
                                    <option value="|">|</option>
                                    <option value=";">;</option>
                                    <option value=",">,</option>
                                    <option value="-">-</option>
                                    <option value="_">_</option>
                                </select>
                            </div>
                            <div class="col-md-3">
                                 <label>&nbsp;</label>
                                <div class="btn-group">
                                  <button type="button" class="btn blue dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    Exportar
                                  </button>
                                  <div class="dropdown-menu">
                                    <a class="dropdown-item" id="btn_imprimir_excel"  onclick="clk_imprimir_excel"><i class="fa fa-file-excel-o"></i>EXCEL</a>
                                    <div class="dropdown-divider"></div>

                                     <a class="dropdown-item" id="btn_imprimir_txt"><i class="fa fa-file-code-o" aria-hidden="true"></i> TXT</a>
                                  </div>
                                </div>
                            </div>
                                                       
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="server">
      <script type="text/javascript">
        var html_columnas = "";
        $(document).ready(function () {           
            cargarProveedor();            
            $("#sltProveedor").change(cargarCarteras);
            $("#sltCartera").change(cargarSubCarteras);
            $("#txtDesde").val(obtenerFechaActual);
            $("#txtHasta").val(obtenerFechaActual);

            $(".date-picker").datepicker({
                format: "dd/mm/yyyy"
                //,
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

            /*Exportar a Excel*/
            $("#btn_imprimir_excel").click(function () {
                
                if ($("#sltProveedor").val() == '0') {
                    bootbox.alert("Seleccionar el proveedor");
                    return false;
                }
                if ($("#sltCartera").val() == '0') {
                    bootbox.alert("Seleccionar la cartera");
                    return false;
                }
                if ($("#sltSubCartera").val() == '0') {
                    bootbox.alert("Seleccionar la sub cartera");
                    return false;
                }

                var url = "imprimir_backoffice.aspx?tipo=1&prv_codigo=" + $("#sltProveedor").val() +
                    "&car_codigo=" + $("#sltCartera").val() +
                    "&sca_codigo=" + $("#sltSubCartera").val() +
                    "&fec_desde=" + $("#txtDesde").val().replace("/", "$") +
                    "&fec_hasta=" + $("#txtHasta").val().replace("/", "$") +
                    "&separador=" + $("#sltSeparador").val();
                
                window.open(url);
            });

            /*exportar a TXT*/
            $("#btn_imprimir_txt").click(function () {
                //alert(1);
                if ($("#sltProveedor").val() == '0') {
                    bootbox.alert("Seleccionar el proveedor");
                    return false;
                }
                if ($("#sltCartera").val() == '0') {
                    bootbox.alert("Seleccionar la cartera");
                    return false;
                }
                if ($("#sltSubCartera").val() == '0') {
                    bootbox.alert("Seleccionar la sub cartera");
                    return false;
                }

                var url = "imprimir_backoffice.aspx?tipo=2&prv_codigo=" + $("#sltProveedor").val() +
                    "&car_codigo=" + $("#sltCartera").val() +
                    "&sca_codigo=" + $("#sltSubCartera").val() +
                    "&fec_desde=" + $("#txtDesde").val().replace("/", "$") +
                    "&fec_hasta=" + $("#txtHasta").val().replace("/", "$")+
                    "&separador=" + $("#sltSeparador").val();
                window.open(url);
            });

            
        });       

        function cargarProveedor() {
            $.ajax({
                url: strServicio+"general.asmx/cargarProveedor",
                dataType: 'JSON',
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                success: function (jsondata) {                    
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
                }
            });
        }

       

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

        
          </script>
</asp:Content>
