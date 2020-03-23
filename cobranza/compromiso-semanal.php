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


//personalizacion del contenido de la pagina

$head =<<<Final

Final;
$titulo = $carpeta_secundaria;//"BANDEJA DE GESTIONES";
$sub_titulo = "";//"Página de inicio";
$sub_titulo = "";
$pageBar = "";

$contenido =<<<Final
<div class="row" id="div_contenido">
<div class="col-md-12">
    <div class="portlet box blue">
        <div class="portlet-title">
            <div class="caption">
                <i class="fa fa-globe"></i> COMPROMISOS POR FECHAS</div>
            <div class="tools"> </div>
        </div>
        <div class="portlet-body">
            <div class="row">
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 margin-bottom-20">
                    <div class="col-md-4">
                        <label>DOCUMENTO</label>
                        <input type="text" id="txt_dni" class="form-control"/>
                    </div>
                    <div class="col-md-4">
                        <label>DESDE</label>
                        <input type="text" id="txt_desde" class="form-control date-picker"/>
                    </div>
                    <div class="col-md-4">
                        <label>HASTA</label>
                        <input type="text" id="txt_hasta" class="form-control date-picker"/>
                    </div>
                </div>
                <div  class="col-lg-6 col-md-6 col-sm-6 col-xs-12 margin-bottom-20">
                    <div class="col-md-8">
                        <label>TIPO DE RESULTADO</label>
                        <select id="slt_tipo" class="form-control">
                            <option value="0">TODOS</option>
                            <option value="1">COMPROMISO TIPO A</option>
                            <option value="2">COMPROMISO TIPO B</option>
                            <option value="3">PAGO A CUENTA</option>
                            <option value="4">OPORTUNIDAD DE PAGO</option> 
                            <option value="5">REPROGRAMACIÓN</option>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <div><label>&nbsp;</label></div>
                        <a class="btn blue" id="btn_buscar">BUSCAR</a>
                    </div>
                </div>
            </div>
            <table id="tblLista" class="tblLista_grid table table-striped table-bordered table-hover dt-responsive" cellspacing="0" width="100%">
                <thead>
                    <tr>
                        <th></th>
                        <th>N° CUENTA</th>
                        <th>CLIENTE</th>
                        <th>DNI</th>
                        <th>TIPO RESULTADO</th>
                        <th>MONTO COMPROMISO</th>
                        <th>FECHA COMPROMISO</th>
                        <th>PAGO MONTO</th>
                        <th>FECHA PAGO</th>
                        <th></th>
                        <th>VALIDO</th>
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
Final;

$script =<<<Final
<script type="text/javascript">
$(document).ready(function () {

    $("#btn_buscar").click(function () {
        cargarCompromiso();
    });

    $("#txt_desde").val(obtenerFechaActual);
    $("#txt_hasta").val(obtenerFechaActual);

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

    var cargarCompromiso = function () {
        abrir_preload('div_contenido');
        $.ajax({
            url: strServicio + "cartera.php?CONSULTA_AJAX=obtenerCompromisoSemanal",
            data: '{"dni":"' + $("#txt_dni").val() + '","fecha_desde":"' + $("#txt_desde").val() + '","fecha_hasta":"' + $("#txt_hasta").val() + '","tipo":"' + $("#slt_tipo").val() + '"}',
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
                    "<td><a href='gestionar-cuenta.php?cuenta=" + obj.NRO_CUENTA + "'>" + obj.NRO_CUENTA + "</a></td>" +
                    "<td><span>" + obj.NOMBRE_COMPLETO + "</span></td>" +
                    "<td><span>" + obj.NRO_DOCUMENTO + "</span></td>" +
                    "<td><span>" + obj.TIPO_RESULTADO + "</span></td>" +
                    "<td><span>" + obj.MONTO_COMPROMISO + "</span></td>" +
                    "<td><span>" + obj.FECHA_COMPROMISO + "</span></td>" +
                    "<td><span>" + (obj.PAG_MONTO == null ? "" : obj.PAG_MONTO)  + "</span></td>" +
                    "<td><span>" + (obj.FECHA_PAGO == null ? "" : obj.FECHA_PAGO) + "</span></td>" +
                    "<td>" + (obj.VALIDO == "VALIDO" ? "<img src='resource/img/semaforo/verde.png'>" :
                        obj.VALIDO == "CAIDOS" ? "<img src='resource/img/semaforo/rojo.png'>" :
                        obj.VALIDO == "CAIDOS" ? "<img src='resource/img/semaforo/rojo.png'>" :
                        obj.VALIDO == "INVALIDO" ? "<img src='resource/img/semaforo/amarillo.png'>" :
                        obj.VALIDO == "VACIO" ? "" :
                            "<img src='resource/img/semaforo/rojo.png'>") +
                        "</td>" +
                    "<td><span>" + (obj.VALIDO=="VACIO"?"":obj.VALIDO) + "</span></td>" +
                    "<td>" +
                        "<div class='dv_icon_edit'><a class='icon_edit' href='gestionar-cuenta.php?cuenta=" + obj.NRO_CUENTA + "'></a></div>" +
                    "</td>" +
                    "</tr>";
                    $("#tblLista tbody").append(htmlText);
                });
            }
        });
        //setTimeout(cargarRecordatorio, 20000);
    }
    cargarCompromiso();
});
</script>
Final;

//llamamao a la plantilla principal
require_once $url_relativa.'resource/masterPage/master.php';

 ?>
