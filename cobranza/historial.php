<?php

require_once "url_relativa.php";
require_once $url_relativa."valida_sesion.php";
require_once $url_relativa."clases/usuario_class.php";

$user = new Usuario();
$user->setUserInfo();
$user->setUrlMaster($ruta_web);
// echo "<pre>";
// var_dump($_SERVER);
// echo "</pre>";
// echo dirname(dirname(__FILE__));
// echo "</br>";
// echo dirname(__FILE__);
// exit;
if ( !isset($_GET['cuenta']) ) {
    exit;
}
$cuenta = $_GET['cuenta'];
$head = "";

$titulo = "HISTORIAL";
$sub_titulo = "Página de inicio";
$sub_titulo = "";
$pageBar =<<<Final
<div class="page-toolbar">
    <div class="clearfix">
        <div class="btn-group" data-toggle="buttons">
            <label class="btn blue-chambray active" id="chk_diario"><input type="radio" class="toggle"/> Gestiones de día </label>
            <label class="btn blue-chambray" id="chk_semanal"><input type="radio" class="toggle"/> Gestiones del mes </label>
        </div>
    </div>
</div>

Final;


$contenido =<<<Final
<div class="container">
    <div class="row">
        <div style="width:45%; float:left;">
          <div class="panel panel-default">
            <div class="panel-heading">
              <h3 class="panel-title">DIAS MORA</h3>
            </div>
            <div class="panel-body">
              <span id="txtDiasMora"></span>
            </div>
          </div>
        </div>
        <div style="width:45%; float:right;">
          <div class="panel panel-primary">
            <div class="panel-heading">
              <h3 class="panel-title">DIAS S/G</h3>
            </div>
            <div class="panel-body">
              <span id="txtDias"></span>
            </div>
          </div>
        </div>
    </div>
    <input type="hidden" name="ctl00\$contenido\$txtCuenta" id="contenido_txtCuenta" value="$cuenta" />
    <input type="hidden" id="txtCodigoCliente" value="0"/>
    <input type="hidden" id="txtCodigoProveedor" value="0"/>
    <input type="hidden" id="txtCodigoCuenta" value="0"/>
    <input type="hidden" id="txtCodigoCartera" value="0"/>
    <input type="hidden" id="txtCodigoSubCartera" value="0"/>
    <input type="hidden" id="txtCodigoGestion" value="0"/>
    <input type="hidden" id="txtCodigoRol" runat="server" value="0"/>
    <div class="row">
        <div>
          <div class="panel panel-default">
            <div class="panel-heading">
              <h4 class="panel-title">DATOS DEL SOLICITANTE</h4>
            </div>
            <div class="panel-body">
                <table border="0">
                    <tr>
                        <td>DNI</td>
                        <td>&nbsp;:&nbsp;</td>
                        <td><span id="txtDni"></span></td>
                    </tr>
                    <tr>
                        <td>NOMBRES Y APELLIDOS</td>
                        <td>&nbsp;:&nbsp;</td>
                        <td><span id="txtNombres"></span></td>
                    </tr>
                    <tr>
                        <td>DIRECCIÓN</td>
                        <td>&nbsp;:&nbsp;</td>
                        <td><span id="txtDireccion"></span></td>
                    </tr>
                    <tr>
                        <td>CORREO</td>
                        <td>&nbsp;:&nbsp;</td>
                        <td><span id="txtCorreo"></span></td>
                    </tr>
                    <tr>
                        <td>CELULAR</td>
                        <td>&nbsp;:&nbsp;</td>
                        <td><span id="txtCelular"></span></td>
                    </tr>
                </table>
            </div>
          </div>
        </div>
    </div>
    <div class="row">
        <div>
          <div class="panel panel-default">
            <div class="panel-heading">
              <h3 class="panel-title">MONTOS</h3>
            </div>
            <div class="panel-body">
              <table class="table table-bordered">
                <thead>
                    <tr>
                        <th style="width:33%;">CAPITAL</th>
                        <th style="width:33%;">MONTO PROTESTO</th>
                        <th style="width:33%;">SALDO DEUDA</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><span id="txtCapital"></span></td>
                        <td><span id="txtMontoProtesto"></span></td>
                        <td><span id="txtSaldoDeuda"></span></td>
                    </tr>
                </tbody>
            </table>
            </div>
          </div>
        </div>
    </div>
    <div class="row">
        <div>
          <div class="panel panel-default">
            <div class="panel-heading">
              <h3 class="panel-title">PAGOS</h3>
            </div>
            <div class="panel-body">
              <table id="tblPago" class="table table-bordered">
                <thead>
                    <tr>
                        <th style="width: 33%;">FECHA PAGO</th>
                        <th style="width: 33%;">MONTO PAGO</th>
                        <th style="width: 33%;">TIPO PAGO</th>
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

$footer = '  <button type="button" class="btn btn-danger" onclick="parent.$.fancybox.close();">ACEPTAR</button>';

$script =<<<Final
<script type="text/javascript">
    $(document).ready(function () {
        iniciarDatos();
    });


    function iniciarDatos() {
        $.ajax({
            url: strServicio +  "gestion.php",
            data: '{"cuenta":"' + $("#contenido_txtCuenta").val() + '", "CONSULTA_AJAX":"obtenerDatosCuenta"}',
            dataType: 'JSON',
            type: 'POST',
            contentType: "application/json; charset=utf-8",
            async: false,
            success: function (jsondata) {
                $("#txtCodigoCliente").val(jsondata.d[0].CLI_CODIGO);
                $("#txtCodigoProveedor").val(jsondata.d[0].PRV_CODIGO);
                $("#txtCodigoCuenta").val(jsondata.d[0].CUE_CODIGO);
                $("#txtCodigoCartera").val(jsondata.d[0].CAR_CODIGO);
                $("#txtCodigoSubCartera").val(jsondata.d[0].SCA_CODIGO);
                $("#txtDni").html(jsondata.d[0].CLI_DOCUMENTO_IDENTIDAD);
                $("#txtNombres").html(jsondata.d[0].CLI_NOMBRE_COMPLETO);
                $("#txtDireccion").html(jsondata.d[0].CLI_DIRECCION_PARTICULAR);
                $("#txtUbigeo").html(jsondata.d[0].UBIGEO);
                $("#txtCorreo").html(jsondata.d[0].CLI_CORR_PARTICULAR);
                $("#txtCelular").html(jsondata.d[0].CLI_CELULAR);
                $("#txtDias").html(jsondata.d[0].DIAS);

                $("#txtCampana").html(jsondata.d[0].CAMPANA);
                $("#txtFechaCastigo").html(jsondata.d[0].BAD_FECHA_CASTIGO);
                $("#txtFechaAsignacion").html(jsondata.d[0].BAD_FECHA_ASIGNACION);
                $("#txtFechaProtesto").html(jsondata.d[0].BAD_FECHA_PROTESTO);
                $("#txtMoraActualizado").html(jsondata.d[0].BAD_DIAS_MORA);
                $("#txtDiasMora").html(jsondata.d[0].BAD_DIAS_MORA);
                $("#txtCapital").html(jsondata.d[0].CAPITAL_VC);
                $("#txtMontoProtesto").html(jsondata.d[0].PROTESTO_VC);
                $("#txtSaldoDeuda").html(jsondata.d[0].SALDO_VC);

                cargarPagos(jsondata.d[0].CUE_CODIGO);
            }
        });
    }

    function cargarPagos(codigo) {
        $.ajax({
            url: "../resource/service/pago.asmx/obtenerPagos",
            data: '{"codigo":' + codigo + '}',
            dataType: 'JSON',
            type: 'POST',
            contentType: "application/json; charset=utf-8",
            async: false,
            success: function (jsondata) {
                $("#tblPago tbody").empty();
                var htmlText = "";

                $.each(jsondata.d, function (i, obj) {
                    htmlText = "<tr>" +
                        "<td style='text-align:right; height: 35px;'>" + obj.FECHAPAGO + "</td>" +
                        "<td style='text-align:right;height: 35px;'>" + obj.MONTOPAGO + "</td>" +
                        "<td style='text-align:right;height: 35px;'>" + obj.TPA_DESCRIPCION + "</td>" +
                    "</tr>";
                    $("#tblPago tbody").append(htmlText);
                });
            }
        });
    }
</script>


Final;

require_once $url_relativa.'resource/masterPage/Popup.php';
 ?>
