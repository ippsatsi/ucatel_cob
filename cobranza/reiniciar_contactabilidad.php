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
Final;
$titulo = "";//"BANDEJA DE GESTIONES";
$sub_titulo = "";//"Página de inicio";
$sub_titulo = "";
$pageBar = "";

$contenido =<<<Final
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
Final;

$script =<<<Final
<script type="text/javascript">
$(document).ready(function () {
    listarPeriodosFaltantes();
    listarPeriodosActuales();
});

function activarPeriodo(codigo) {
    $.ajax({
        url: strServicio + "cartera.php?CONSULTA_AJAX=registrarPeriodo",
        data: '{"codigo":' + codigo + '}',
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
        url: strServicio + "cartera.php?CONSULTA_AJAX=reiniciarPeriodo",
        data: '{"codigo":' + codigo + '}',
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
        url: strServicio + "cartera.php?CONSULTA_AJAX=listarPeriodosFaltantes",
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
        url: strServicio + "cartera.php?CONSULTA_AJAX=listarPeriodosActivos",
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
Final;

//llamamao a la plantilla principal
require_once $url_relativa.'resource/masterPage/master.php';

 ?>
