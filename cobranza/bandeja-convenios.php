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
<link href='${url_relativa}resource/assets/global/plugins/datatables/datatables.min.css' rel="stylesheet" type="text/css" />
<link href='${url_relativa}resource/assets/global/plugins/datatables/plugins/bootstrap/datatables.bootstrap.css' rel="stylesheet" type="text/css" />

Final;
$titulo = "    BANDEJA DE CONVENIOS";//"BANDEJA DE GESTIONES";
$sub_titulo = "";//"Página de inicio";
$sub_titulo = "";
$pageBar = "";

$contenido =<<<Final
<div class="row" id="div_contenido">
    <div class="col-md-12">
        <input type="hidden" id="txt_rol_codigo" value="{$user->getUserRol()}"/>
        <input type="hidden" id="txt_usu_codigo" value="{$user->getUserId()}" />
        <div class="portlet box blue">
            <div class="portlet-title">
                <div class="caption">
                    <i class="fa fa-globe"></i> Lista de convenios </div>
                <div class="tools"> </div>
            </div>
            <div class="portlet-body">
                <div class="row">
                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 margin-bottom-20">
                        <div class="col-md-4">
                            <label>Nº CUENTA</label>
                            <input type="text" id="txtCuenta" class="form-control"/>
                        </div>
                        <div class="col-md-4">
                            <label>DNI</label>
                            <input type="text" id="txtDNI" class="form-control"/>
                        </div>
                        <div class="col-md-4">
                            <label>CLIENTE</label>
                            <input type="text" id="txtCliente" class="form-control"/>
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 margin-bottom-20">
                        <div class="col-md-4">
                            <label>&nbsp;&nbsp;</label>
                            <input type="button" class="form-control btn blue btn_buscar" id="btn_buscar" value="BUSCAR"/>
                        </div>
                        <div class="col-md-4">
                            <label>&nbsp;&nbsp;</label>
                            <input type="button" class="form-control btn blue btn_buscar" id="btn_imprimir" value="DESCARGAR"/>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 margin-bottom-20">
                        <div class="col-md-4">
                            <label>&nbsp;&nbsp;</label>
                            <select id="sltFecha" class="form-control">
                                <option value="0">FECHA PAGO</option>
                                <option value="1">FECHA REGISTRO/ANULACIÓN</option>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label>FECHA DESDE</label>
                            <input type="text" id="txtDesde" class="form-control date-picker"/>
                        </div>
                        <div class="col-md-4">
                            <label>FECHA HASTA</label>
                            <input type="text" id="txtHasta" class="form-control date-picker"/>
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 margin-bottom-20">
                        <div class="col-md-4">
                            <label>&nbsp;&nbsp;</label>
                            <select id="sltEstado" class="form-control">
                                <option value="1">ACTIVOS</option>
                                <option value="0">ANULADOS</option>
                            </select>
                        </div>
                    </div>
                </div>

                <table id="tblLista" class="tblLista table table-striped table-bordered table-hover dt-responsive" cellspacing="0" width="100%">
                <thead>
                    <tr>
                        <th class="all">Nº Cuenta</th>
                        <th class="min-proovedor">Proveedor</th>
                        <th class="min-cartera">Cartera</th>
                        <th class="min-subcartera">Sub Cartera</th>
                        <th class="min-dni">DNI</th>
                        <th class="min-cliente">Cliente</th>
                        <th class="min-montocuota">Moneda</th>
                        <th class="none">Monto Negociado</th>
                        <th class="none">Fecha Inicial</th>
                        <th class="none">Cuota Inicial</th>
                        <th class="none">Cuotas</th>
                        <th class="none">Cuotas Pagadas</th>
                        <th class="min-fechavenc">Fecha Venc.</th>
                        <th class="min-numcuota">Nº Cuota</th>
                        <th class="min-montocuota">Monto Cuota</th>
                        <th class="min-pago">Pago</th>
                        <th class="min-montopago">Monto Pago</th>
                        <th class="min-fecha">Fecha</th>
                        <th class="min-cliente">Usuario Registro/Anulación</th>
                        <th class="min-fecha">Motivo/Anulación</th>
                        <th class="min-anular"></th>
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
<script src='${url_relativa}resource/js/cobranza/bandeja-convenios.js' type="text/javascript"></script>
<script src='${url_relativa}resource/assets/global/scripts/datatable.js' type="text/javascript"></script>
<script src='${url_relativa}resource/assets/global/plugins/datatables/datatables.min.js' type="text/javascript"></script>
<script src='${url_relativa}resource/assets/global/plugins/datatables/plugins/bootstrap/datatables.bootstrap.js' type="text/javascript"></script>

Final;

//llamamao a la plantilla principal
require_once $url_relativa.'resource/masterPage/master.php';

 ?>
