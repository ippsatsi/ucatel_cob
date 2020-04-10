<?php
//inicializacion
require_once "url_relativa.php";
require_once $url_relativa."valida_sesion.php";
require_once $url_relativa."clases/usuario_class.php";
require_once $url_relativa."clases/cliente_class.php";

$user = new Usuario();
$user->setUserInfo();
$user->setUrlMaster($ruta_web);
//mostramos todas la cuentas que tiene el cliente
$cliente = new Cliente();


//Extraemos los datos de los cuadros informativos para mostrarlos

//personalizacion del contenido de la pagina

$head =<<<Final
<link href='../resource/assets/global/plugins/datatables/datatables.min.css' rel="stylesheet" type="text/css" />
<link href='../resource/assets/global/plugins/datatables/plugins/bootstrap/datatables.bootstrap.css' rel="stylesheet" type="text/css" />

Final;
$titulo = "";//"BANDEJA DE GESTIONES";
$sub_titulo = "";//"Página de inicio";
$sub_titulo = "";
$pageBar = "";

$contenido =<<<Final

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
                        <a id="btn_imprimir_excel" class="form-control btn blue"> <i class="fa fa-file-excel-o"></i> DESCARGAR EXCEL</a>
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

Final;

$script =<<<Final
<script src='../resource/assets/global/scripts/datatable.js' type="text/javascript"></script>
<script src='../resource/assets/global/plugins/datatables/datatables.min.js' type="text/javascript"></script>
<script src='../resource/assets/global/plugins/datatables/plugins/bootstrap/datatables.bootstrap.js' type="text/javascript"></script>

<script type="text/javascript">
    $(document).ready(function () {
        cargarProveedor();
        $("#btn_buscar").click(fnc_buscar);
        $("#sltProveedor").change(cargarCarteras);
        $("#sltCartera").change(cargarSubCarteras);

        $("#btn_imprimir_excel").click(function () {
            //bootbox.alert(1);
            var url = "imprimir.aspx?tipo=rep_asig_gest&prv_codigo=" + $("#sltProveedor").val() +
                "&car_codigo=" + $("#sltCartera").val() +
                "&sca_codigo=" + $("#sltSubCartera").val() +
                "&fec_desde=" + $("#txtDesde").val().replace("/","$") +
                "&fec_hasta=" + $("#txtHasta").val().replace("/", "$") +
                "&tipo_gestion=" + $("#sltTipoGestion").val().replace("/", "$") +
                "&progresivo=" + $("#sltProgresivo").val().replace("/", "$") +
                "&estado=" + $("#sltEstado").val();
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

        $("#txtDesde").val(obtenerFechaActual);
        $("#txtHasta").val(obtenerFechaActual);

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
                url: strServicio+"cartera.php?CONSULTA_AJAX=reporteAsignacionGestiones",
                data: '{"prv_codigo":' + $("#sltProveedor").val() + ',"car_codigo":' + $("#sltCartera").val() + ',"sca_codigo":' + $("#sltSubCartera").val() + ',"fecha_desde":"' + $("#txtDesde").val() + '","fecha_hasta":"' + $("#txtHasta").val() + '","tipo":"' + $("#sltTipoGestion").val() + '","progresivo":"' + $("#sltProgresivo").val() + '","estado":"' + $("#sltEstado").val() + '"}',
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


function cargarProveedor() {
$.ajax({
    url: strServicio + "cargarProveedor.php",
    dataType: 'JSON',
    type: 'POST',
    contentType: "application/json; charset=utf-8",
    success: function (jsondata) {
        //$("#sltProveedor").empty();
        $.each(jsondata.d, function (i, obj) {
            $("#sltProveedor").append("<option value='" + obj.value + "'>" + obj.key + "</option>"); // 21.06.19
       
        });
        //console.log(jsondata.d);
    }
});
}

function cargarCarteras() {
$.ajax({
    url: strServicio + "cargarCarteras.php",
    data: '{"PRV_CODIGO":"' + $("#sltProveedor").val() + '"}',
    dataType: 'JSON',
    type: 'POST',
    contentType: "application/json; charset=utf-8",
    success: function (jsondata) {
        $("#sltCartera").empty();
        $("#sltCartera").append("<option value='0'>-SELECCIONA-</option>");
        $.each(jsondata.d, function (i, obj) {
            $("#sltCartera").append("<option value='" + obj.value + "'>" + obj.key + "</option>"); // 21.06.19
       
        });
        //console.log(jsondata.d);
    }
});
}

function cargarSubCarteras() {
$.ajax({
    url: strServicio + "cargarSubCarteras.php",
    data: '{"CAR_CODIGO":"' + $("#sltCartera").val() + '"}',
    dataType: 'JSON',
    type: 'POST',
    contentType: "application/json; charset=utf-8",
    success: function (jsondata) {
        $("#sltSubCartera").empty();
        $("#sltSubCartera").append("<option value='0'>-SELECCIONA-</option>");
        $.each(jsondata.d, function (i, obj) {
            $("#sltSubCartera").append("<option value='" + obj.value + "'>" + obj.key + "</option>"); // 21.06.19
     
        });
        //console.log(jsondata.d);
    }
});
} 
    });
</script>
Final;

//llamamao a la plantilla principal
require_once $url_relativa.'resource/masterPage/master.php';

 ?>
