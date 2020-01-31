<%@ Page Title="" Language="C#" MasterPageFile="~/resource/masterPage/Template.Master" AutoEventWireup="true" CodeBehind="reporte-asignacion-gestiones.aspx.cs" Inherits="WEB.reporte.reporte_asignacion_gestiones" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href='<%=ResolveClientUrl("~/resource/assets/global/plugins/datatables/datatables.min.css") %>' rel="stylesheet" type="text/css" />
    <link href='<%=ResolveClientUrl("~/resource/assets/global/plugins/datatables/plugins/bootstrap/datatables.bootstrap.css") %>' rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contenido" runat="server">

    <div class="row" id="div_contenido">
        <div class="col-md-12">

            <div class="portlet box blue">
                <div class="portlet-title">
                    <div class="caption">
                        <i class="fa fa-globe"></i> Lista de Gestiones </div>
                    <div class="tools"> </div>
                </div>
                <div class="portlet-body">

                    <div class="row">
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 margin-bottom-20">
                            <div class="col-md-4">
                                <label>PROOVEDOR</label>
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
                            <div class="col-md-4">
                                <div><label></label></div>
                                <a class="btn_buscar form-control btn blue" id="btn_buscar">BUSCAR</a>
                            </div>
                            <div class="col-md-8">
                                <div><label></label></div>
                                <a id="btn_imprimir_excel" class="form-control btn blue" runat="server"> <i class="fa fa-file-excel-o"></i> DESCARGAR EXCEL</a>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 margin-bottom-20">
                            <div class="col-md-4">
                                <label>FECHA DESDE</label>
                                <input type="text" id="txtDesde" runat="server" class="form-control date-picker"/>
                            </div>
                            
                            <div class="col-md-4">
                                <label>FECHA HASTA</label>
                                <input type="text" id="txtHasta" runat="server" class="form-control date-picker"/>
                            </div>

                            <div class="col-md-4">
                                <label>TIPO DE GESTIÓN</label>
                                <select id="sltTipoGestion" class="form-control" runat="server">
                                    <option value="0">-TODOS-</option>
                                    <option value="1">CALL</option>
                                    <option value="2">CAMPO</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 margin-bottom-20">
                            <div class="col-md-6">
                                <label>INCLUIR GESTIÓN PROGRESIVO</label>
                                <select id="sltProgresivo" class="form-control" runat="server">
                                    <option value="0">-TODOS-</option>
                                    <option value="1">GESTIONES</option>
                                    <option value="3">PROGRESIVO</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label>ESTADO</label>
                                <select id="sltEstado" class="form-control" runat="server">
                                    <option value="A">ACTIVO</option>
                                    <option value="I">INACTIVO</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="table-scrollable">
                        <table id="tblLista" class="tblLista_grid table table-striped table-bordered table-hover dt-responsive" cellspacing="0" width="100%">
                            <thead>
                                <tr>
                                    <th class="all">N°</th>
                                    <th class="min-tipogestion">Gestión</th>
                                    <th class="min-tipogestion">Tipo de gestión</th>
                                    <th class="min-documento">N° de documento</th>
                                    <th class="min-cuenta">N° de cuenta</th>
                                    <th class="min-telefono">Teléfono</th>
                                    <th class="min-direccion">Dirección</th>
                                    <th class="min-fecha">Fecha compromiso</th>
                                    <th class="min-monto">Monto compromiso</th>
                                    <th class="min-subcartera">Sub cartera</th>
                                    <th class="min-resultado">Tipo resultado</th>
                                    <th class="min-fechagestion">Fecha gestión</th>
                                    <th class="min-horagestion">Hora gestión</th>
                                    <th class="min-montopago">Monto pago</th>
                                    <th class="min-fechpago">Fecha pago</th>
                                    <th class="min-tipopago">Tipo pago</th>
                                    <th class="min-valido">Válido</th>
                                    <th class="min-gestion">Gestión</th>
                                    <th class="min-ultgestion">Última gestión</th>
                                    <th class="min-usuario">Usuario</th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="server">
    <script src='<%=ResolveClientUrl("~/resource/assets/global/scripts/datatable.js")%>' type="text/javascript"></script>
    <script src='<%=ResolveClientUrl("~/resource/assets/global/plugins/datatables/datatables.min.js")%>' type="text/javascript"></script>
    <script src='<%=ResolveClientUrl("~/resource/assets/global/plugins/datatables/plugins/bootstrap/datatables.bootstrap.js")%>' type="text/javascript"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            cargarProveedor();
            $("#btn_buscar").click(fnc_buscar);
            $("#contenido_sltProveedor").change(cargarCarteras);
            $("#contenido_sltCartera").change(cargarSubCarteras);

            $("#contenido_btn_imprimir_excel").click(function () {
                //bootbox.alert(1);
                var url = "imprimir.aspx?tipo=rep_asig_gest&prv_codigo=" + $("#contenido_sltProveedor").val() +
                    "&car_codigo=" + $("#contenido_sltCartera").val() +
                    "&sca_codigo=" + $("#contenido_sltSubCartera").val() +
                    "&fec_desde=" + $("#contenido_txtDesde").val().replace("/","$") +
                    "&fec_hasta=" + $("#contenido_txtHasta").val().replace("/", "$") +
                    "&tipo_gestion=" + $("#contenido_sltTipoGestion").val().replace("/", "$") +
                    "&progresivo=" + $("#contenido_sltProgresivo").val().replace("/", "$") +
                    "&estado=" + $("#contenido_sltEstado").val();
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
                
                $.ajax({
                    url: strServicio+"reporte.asmx/reporteAsignacionGestiones",
                    data: '{"prv_codigo":' + $("#contenido_sltProveedor").val() + ',"car_codigo":' + $("#contenido_sltCartera").val() + ',"sca_codigo":' + $("#contenido_sltSubCartera").val() + ',"fecha_desde":"' + $("#contenido_txtDesde").val() + '","fecha_hasta":"' + $("#contenido_txtHasta").val() + '","tipo":"' + $("#contenido_sltTipoGestion").val() + '","progresivo":"' + $("#contenido_sltProgresivo").val() + '","estado":"' + $("#contenido_sltEstado").val() + '"}',
                    dataType: 'JSON',
                    type: 'POST',
                    contentType: "application/json; charset=utf-8",
                    success: function (jsondata) {
                        $("#tblLista tbody").empty();
                        var htmlText = "";
                        $.each(jsondata.d, function (i, obj) {
                            htmlText = "<tr>" +
                                    "<td>" + (i + 1) + "</td>" +
                                    "<td>" + obj.GES_TIPO_GESTION + "</td>" +
                                    "<td>" + obj.TIG_DESCRIPCION + "</td>" +
                                    "<td>" + obj.CLI_DOCUMENTO_IDENTIDAD + "</td>" +
                                    "<td>" + obj.CUE_NROCUENTA + "</td>" +
                                    "<td>" + obj.TEL_NUMERO + "</td>" +
                                    "<td>" + obj.DIR_DIRECCION + "</td>" +
                                    "<td>" + obj.FECHA_COMPROMISO + "</td>" +
                                    "<td>" + obj.GES_IMPORTE_INICIAL + "</td>" +
                                    "<td>" + obj.SCA_DESCRIPCION + "</td>" +
                                    "<td>" + obj.TIR_DESCRIPCION + "</td>" +
                                    "<td>" + obj.FECHA_GESTION + "</td>" +
                                    "<td>" + obj.HORA_GESTION + "</td>" +
                                    "<td>" + obj.PAG_MONTO + "</td>" +
                                    "<td>" + obj.FECHA_PAGO + "</td>" +
                                    "<td>" + obj.TPA_TIPO_PAGO + "</td>" +
                                    "<td>" + obj.VALIDO + "</td>" +
                                    "<td>" + obj.GESTION + "</td>" +
                                    "<td>" + obj.ULTIMA_GESTION + "</td>" +
                                    "<td>" + obj.USU_LOGIN + "</td>" +
                                "</tr>";
                            $("#tblLista tbody").append(htmlText);
                        });
                    }
                });
            }
// Añadida fucion para que no aparezcan carteras, proveedores o subcarteras retiradas (las cuales sus nobres deben finalizar con XX para que
// la funcion las detecte) 21.06.19
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
              //  $("#contenido_sltProveedor").append("<option value='" + obj.value + "'>" + obj.key + "</option>"); // 21.06.19
              borrarRetirados("#contenido_sltProveedor",obj); // 21.06.19
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
              //  $("#contenido_sltCartera").append("<option value='" + obj.value + "'>" + obj.key + "</option>"); // 21.06.19
              borrarRetirados("#contenido_sltCartera",obj); // 21.06.19
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
              //  $("#contenido_sltSubCartera").append("<option value='" + obj.value + "'>" + obj.key + "</option>"); // 21.06.19
               borrarRetirados("#contenido_sltSubCartera",obj); // 21.06.19
            });
            //console.log(jsondata.d);
        }
    });
} 
        });
    </script>
</asp:Content>
