<%@ Page Title="" Language="C#" MasterPageFile="~/resource/masterPage/Template.Master" AutoEventWireup="true" CodeBehind="reporte-compromiso.aspx.cs" Inherits="WEB.reporte.reporte_compromiso" %>
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
                                <select id="sltProveedor" class="form-control">
                                    <option value="0">-SELECT-</option>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <label>CARTERAS</label>
                                <select id="sltCartera" class="form-control">
                                    <option value="0">-SELECT-</option>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <label>SUB CARTERAS</label>
                                <select id="sltSubCartera" class="form-control">
                                    <option value="0">-SELECT-</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 margin-bottom-20">
                            <div class="col-md-4">
                                <label>USUARIO</label>
                                <select id="sltUsuario" class="form-control">
                                    <option value="0">-TODOS-</option>
                                </select>
                            </div>
                            
                            <div class="col-md-4">
                                <label>DNI</label>
                                <input type="text" id="txt_dni" class="form-control">
                            </div>

                        </div>
                    </div>
                    
                    <div class="row">

                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 margin-bottom-20">
                            <div class="col-md-4">
                                <label>TIPO</label>
                                <select id="slt_tipo" class="form-control">
                                    <option value="1">FECHA REGISTRO</option>
                                    <option value="2">FECHA COMPROMISO</option>
                                </select>
                            </div>
                            
                            <div class="col-md-4">
                                <label>FECHA DESDE</label>
                                <input type="text" id="txtDesde" class="form-control date-picker">
                            </div>

                            <div class="col-md-4">
                                <label>FECHA HASTA</label>
                                <input type="text" id="txtHasta" class="form-control date-picker">
                            </div>
                            

                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 margin-bottom-20">
                        
                            <div class="col-md-4">
                                <label>&nbsp;</label>
                                <a class="btn_buscar form-control btn blue" id="btn_buscar">BUSCAR</a>
                            </div>
                        </div>
                    </div>

                    <table id="tblLista" class="tblLista_grid table table-striped table-bordered table-hover dt-responsive" cellspacing="0" width="100%">
                        <thead>
                            <tr>
                                <th class="all">N°</th>
                                <th class="min-cartera">Cartera</th>
                                <th class="min-usuario">Usuario</th>
                                <th class="min-cuenta">N° cuenta</th>
                                <th class="min-cliente">Cliente</th>
                                <th class="min-dni">DNI</th>
                                <th class="min-resultado">Tipo de resultado</th>
                                <th class="min-fechareg">Fecha de registro</th>
                                <th class="min-montocomp">Monto compromiso</th>
                                <th class="min-fechcomp">Fecha compromiso</th>
                                <th class="min-pagomont">Pago monto</th>
                                <th class="min-fechpago">Fecha pago</th>
                                <th class="min-valido">Válido</th>
                                <th class="min-proceso"></th>
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
            cargarProveedor();
            obtener_usuarios();

            $("#txtDesde").val(obtenerFechaActual);
            $("#txtHasta").val(obtenerFechaActual);            

            cargarCompromiso();
            $("#sltProveedor").change(cargarCarteras);
            $("#sltCartera").change(cargarSubCarteras);

            $("#btn_buscar").click(function () {
                cargarCompromiso();
            });

            $(".date-picker").datepicker({
                format: "dd/mm/yyyy"//,
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

            function cargarCompromiso() {
                abrir_preload('div_contenido');
                $.ajax({
                    url: strServicio+"reporte.asmx/reporteCompromiso",
                    data: '{"prv_codigo":' + $("#sltProveedor").val() + ',"car_codigo":' + $("#sltCartera").val() + ',"sca_codigo":' + $("#sltSubCartera").val() + ',"usu_codigo":' + $("#sltUsuario").val() + ',"nro_documento":"' + $("#txt_dni").val() + '","fec_inicio":"' + $("#txtDesde").val() + '","fec_fin":"' + $("#txtHasta").val() + '","slt_tipo":' + $("#slt_tipo").val() + '}',
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
                            "<td><span>" + obj.CAR_DESCRIPCION + "</span></td>" +
                            //"<td><span>" + obj.SCA_DESCRIPCION + "</span></td>" +
                            "<td><span>" + obj.USU_LOGIN + "</span></td>" +
                            "<td><a href='../cobranza/gestionar-cuenta.aspx?cuenta=" + obj.NRO_CUENTA + "'>" + obj.NRO_CUENTA + "</a></td>" +
                            "<td><span>" + obj.NOMBRE_COMPLETO + "</span></td>" +
                            "<td><span>" + obj.NRO_DOCUMENTO + "</span></td>" +
                            "<td><span>" + obj.TIPO_RESULTADO + "</span></td>" +
                            "<td><span>" + obj.FECHA_REGISTRO + "</span></td>" +
                            "<td><span>" + obj.MONTO_COMPROMISO + "</span></td>" +
                            "<td><span>" + obj.FECHA_COMPROMISO + "</span></td>" +
                            "<td><span>" + obj.PAG_MONTO + "</span></td>" +
                            "<td><span>" + obj.FECHA_PAGO + "</span></td>" +
                            "<td><span>" + obj.VALIDO + "</span></td>" +
                            "<td>" +
                                "<div class='dv_icon_edit'><a class='icon_edit' href='gestionar-cuenta.aspx?cuenta=" + obj.NRO_CUENTA + "'></a></div>" +
                            "</td>" +
                            "</tr>";
                            $("#tblLista tbody").append(htmlText);
                        });
                    }
                });
                //setTimeout(cargarRecordatorio, 20000);
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
                    }
                });
            }

            function obtener_usuarios(){
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

        });
    </script>
</asp:Content>
