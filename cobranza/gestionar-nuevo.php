<?php

require_once "url_relativa.php";
require_once $url_relativa."valida_sesion.php";
require_once $url_relativa."clases/usuario_class.php";

$user = new Usuario();
$user->setUserInfo();
$user->setUrlMaster($ruta_web);

if ( ! ( isset($_GET['codigoCliente']) && isset($_GET['codigoCuenta']) ) ) :
    exit;
endif;
$dir_codigo = "";

if ( isset($_GET['codigo']) ) :
    $dir_codigo = $_GET['codigo'];
endif;

$cli_codigo = $_GET['codigoCliente'];
$cue_codigo = $_GET['codigoCuenta'];

//$rol_codigo = $_GET['codigoRol'];
$head = <<<Final
<link href="${url_relativa}resource/assets/global/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
<link href="${url_relativa}resource/assets/global/plugins/bootstrap-datepicker/css/bootstrap-datepicker.min.css" rel="stylesheet" />
<link href="${url_relativa}resource/assets/global/plugins/bootstrap-datepicker/css/bootstrap-datepicker.standalone.min.css" rel="stylesheet" />
<link href="${url_relativa}resource/assets/global/plugins/bootstrap-datepicker/css/bootstrap-datepicker3.standalone.min.css" rel="stylesheet" />
<link href="${url_relativa}resource/assets/global/plugins/bootstrap-timepicker/css/bootstrap-timepicker.min.css" rel="stylesheet" type="text/css" />

Final;
$titulo = "NUEVA GESTIÓN";
$sub_titulo = "";
$sub_titulo = "";
$pageBar =<<<Final
Final;

$contenido =<<<Final
<input type="hidden" id="txtCodigoCliente" value="{$_GET['codigoCliente']}"/>
<input type="hidden" id="txtCodigoCuenta" value="{$_GET['codigoCuenta']}"/>
<input type="hidden" id="txtCodigoRol" value="{$_GET['codigoRol']}"/>
<input type="hidden" id="txtCodigoCartera" value="{$_GET['codigoCartera']}"/>
<input type="hidden" id="txtCodigoSubCartera" value="{$_GET['codigoSubcartera']}"/>
<input type="hidden" id="txtDni" value="{$_GET['txtDniCliente']}"/>
<input type="hidden" id="txtCodigoTelefono" value="{$_GET['txtCodigoTelefono']}"/>
<input type="hidden" id="txtCodigoDireccion" value="{$_GET['txtCodigoDireccion']}"/>

<div class="container" style="height:400px; overflow-y:auto;">
    <div class="content">
        <div class="row">
            <div class="col-sm-6">
                <label for="sltTipoGestion">TIPO DE GESTIÓN:</label>
                <select id="sltTipoGestion" class="form-control">
                    <option value="00">-SELECCIONE-</option>
                </select>
            </div>
            <div class="col-sm-6" id="divTelefono" style="display:none;">
                <label for="sltTelefono">TELÉFONO GESTIONADO:</label>
                <select id="sltTelefono" class="form-control">
                    <option value="00">-SELECCIONE-</option>
                </select>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-6">
                <label for="sltRespuesta">RESPUESTA:</label>
                <select id="sltRespuesta" class="form-control">
                    <option value="00">-SELECCIONE-</option>
                </select>
            </div>
            <div class="col-sm-6" id="divSolucion" style="display:none;">
                <label for="sltSolucion">SOLUCIÓN:</label>
                <select id="sltSolucion" class="form-control">
                    <option value="00">-SELECCIONE-</option>
                </select>
            </div>
        </div>
        <div class="row" id="divDireccion" style="display:none;">
            <div class="col-sm-12">
                <label for="sltDireccion">DIRECCIÓN:</label>
                <select id="sltDireccion" class="form-control">
                    <option value="00">-SELECCIONE-</option>
                </select>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-12">
                <label for="txtObservacion">OBSERVACIÓN:</label>
                <textarea id="txtObservacion" class="form-control"></textarea>
            </div>
        </div>
    </div>

    <div class="content divRespuestaPago">
        <div class="row divRecibo" style="display:none;">
            <div class="col-sm-6">
            <label for="txtReciboMonto">MONTO RECIBO:</label>
            <input type="text" class="form-control calcularCuotaMonto" id="txtReciboMonto"/>
            </div>
            <div class="col-sm-6">
                <label for="txtReciboFecha">FECHA RECIBO: DD/MM/YYYY:</label>
                <div class='input-group date datetimepicker'>
                    <input type='text' class="form-control" id="txtReciboFecha"/>
                    <span class="input-group-addon">
                        <span class="glyphicon glyphicon-calendar"></span>
                    </span>
                </div>

            </div>
        </div>
        <div class="row divRecibo" style="display:none;">
            <div class="col-sm-6">
                <label for="txtReciboNumero">N° VOUCHER:</label>
                <input type="text" class="form-control calcularCuotaMonto" id="txtReciboNumero"/>
            </div>
            <div class="col-sm-6">
                <label for="txtReciboAgencia">AGENCIA:</label>
                <input type="text" class="form-control calcularCuotaMonto" id="txtReciboAgencia"/>
            </div>
        </div>
        <div class="row" id="divMontoNegociado" style="display:none;">
            <div class="col-sm-6">
                <label for="txtMontoInicial">MONTO DE NEGOCIACIÓN:</label>
                <input type="text" class="form-control calcularCuotaMonto" id="txtMontoNegociacion"/>
            </div>
            <div class="col-sm-6" id="divSaldo" style="display:none;">
                <label for="txtFechaInicial">SALDO DE NEGOCIACIÓN:</label>
                <input type="text" class="form-control calcularCuotaMonto" id="txtSaldoNegociacion" readonly="true"/>
            </div>
        </div>
        <div class="row" id="divMonto" style="display:none;">
            <div class="col-sm-6">
                <label for="txtMontoInicial">MONTO:</label>
                <input type="text" class="form-control calcularCuotaMonto" id="txtMontoInicial"/>
            </div>
            <div class="col-sm-6" id="divFecha" style="display:none;">
                <label for="txtFechaInicial">FECHA: DD/MM/YYYY:</label>
                <div class='input-group date datetimepicker'>
                    <input type='text' class="form-control" id="txtFechaInicial"/>
                    <span class="input-group-addon">
                        <span class="glyphicon glyphicon-calendar"></span>
                    </span>
                </div>

            </div>
        </div>
        <div class="row divRespuestaCuotas" style="display:none;">
            <div class="col-sm-6">
                <label for="txtNroCuotas">N° DE CUOTAS ADICIONALES:</label>
                <input type="text" class="form-control calcularCuotaMonto" id="txtNroCuotas"/>
            </div>
            <div class="col-sm-6">
                <label for="txtValorCuota">VALOR DE LA CUOTA:</label>
                <input type="text" class="form-control calcularCuotaMonto" id="txtValorCuota" readonly="true"/>
            </div>
        </div>
        <div class="row divRespuestaCuotas" style="display:none;">
            <div class="col-sm-12">
                <br />
                <table id="tblCuotas" class="table table-bordered">
                    <thead>
                        <tr>
                            <th>N° CUOTA</th>
                            <th>FECHA</th>
                            <th>MONTO</th>
                        </tr>
                    </thead>
                    <tbody></tbody>
                </table>
            </div>
        </div>
    </div>

    <div class="content" id="divBusquedaEspecializada">
        <div class="col-sm-12">
            <div class="checkbox">
                <label for="chkBusquedaEspecializada"><input type="checkbox" id="chkBusquedaEspecializada"/> BUSQUEDA ESPECIALIZADA</label>
            </div>
        </div>
    </div>

    <div class="content">
        <div class="col-sm-12">
            <div class="checkbox">
                <label for="chkRecordatorio"><input type="checkbox" id="chkRecordatorio"/> NUEVO RECORDATORIO</label>
            </div>
        </div>
    </div>

    <div class="content clearfix" id="divRecordatorio" style="display:none;">
        <div class="col-sm-12">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title"><i class="fa fa-calendar" aria-hidden="true"></i> REGISTRAR NUEVO RECORDATORIO</h3>
                </div>
                <div class="panel-body">
                    <div class="col-sm-6">
                        <label for="txtNroCuotas">FECHA:</label>
                        <div class='input-group date datetimepicker'>
                            <input type='text' class="form-control" id="txtFechaRecordatorio"/>
                            <span class="input-group-addon">
                                <span class="glyphicon glyphicon-calendar"></span>
                            </span>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <label for="txtValorCuota">HORA:</label>
                        <div class='input-group date'>
                            <input type='text' class="form-control datehourpicker" id="txtHoraRecordatorio"/>
                            <span class="input-group-addon">
                                <span class="glyphicon glyphicon-time"></span>
                            </span>
                        </div>
                      
                    </div>
                    <div class="col-sm-12">
                        <label for="txtObservacionRecordatorio">RECORDATORIO:</label>
                        <textarea id="txtObservacionRecordatorio" class="form-control"></textarea>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

Final;

$footer =<<<Final
<button type="button" class="btn btn-primary" id="btnRegistrarGestion">ACEPTAR</button>
<button type="button" class="btn btn-danger" onclick="parent.$.fancybox.close();">CANCELAR</button>
Final;

$script =<<<Final
<script type="text/javascript" src='${url_relativa}resource/assets/global/plugins/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js'></script>
<script type="text/javascript" src='${url_relativa}resource/assets/global/plugins/bootstrap-datepicker/js/bootstrap-datepicker.min.js'></script>
<script type="text/javascript" src="${url_relativa}resource/assets/global/plugins/bootstrap-timepicker/js/bootstrap-timepicker.min.js"></script>
<script type="text/javascript" src='${url_relativa}resource/js/cobranza/gestionar-nuevo.js'></script>
Final;

require_once $url_relativa.'resource/masterPage/Popup.php';


 ?>
