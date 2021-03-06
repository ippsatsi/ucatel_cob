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
$head =<<<Final
<link href='../resource/assets/global/plugins/datatables/datatables.min.css' rel="stylesheet" type="text/css" />
<link href='../resource/assets/global/plugins/datatables/plugins/bootstrap/datatables.bootstrap.css' rel="stylesheet" type="text/css" />

Final;
$titulo = "BANDEJA DE GESTIONES";
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
<div class="row" id="div_contenido">
    <div class="col-md-12">
        <input type="hidden" id="txt_rol_codigo" value="{$user->getUserRol()}" />
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
                            <label>PROVEEDOR</label>
                            <select class="form-control" id="sltProveedor">
                                <option value="0">-SELECCIONE-</option>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label>CARTERA</label>
                            <select class="form-control" id="sltCartera">
                                <option value="0">-SELECCIONE-</option>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label>SUB-CARTERA</label>
                            <select class="form-control" id="sltSubCartera">
                                <option value="0">-SELECCIONE-</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 margin-bottom-20">
                        <div class="col-md-6">
                            <label>DEPARTAMENTO</label>
                            <input type="text" id="txtUbigeo" class="form-control"/>
                        </div>
                        <div class="col-md-6">
                            <label>USUARIO</label>
                            <select class="form-control" id="sltUsuario">
                                <option value="0">-SELECCIONE-</option>
                            </select>
                        </div>

                    </div>

                </div>
                <div class="row">
                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 margin-bottom-20">
                        <div class="col-md-4">
                            <label>N° CUENTA</label>
                            <input type="text" id="txtNroCuenta" class="form-control"/>
                        </div>
                        <div class="col-md-4">
                            <label>DNI</label>
                            <input type="text" id="txtDni" class="form-control"/>
                        </div>
                        <div class="col-md-4">
                            <label>CLIENTE</label>
                            <input type="text" id="txtCliente" class="form-control"/>
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 margin-bottom-20">
                        <div class="col-md-10">
                            <label>TIPO DE CONTACTO </label>
                            <div class="clearfix">
                                <div class="btn-group" data-toggle="buttons">
                                    <label class="btn btn-default input_check"><i class="fa fa-check valida_check"></i> <input type="checkbox" class="toggle" id="chkConDir">Cont. Directo</label>
                                    <label class="btn btn-default input_check"><i class="fa fa-check valida_check"></i> <input type="checkbox" class="toggle" id="chkConInd">Cont. Indirecto</label>
                                    <label class="btn btn-default input_check"><i class="fa fa-check valida_check"></i> <input type="checkbox" class="toggle" id="chkNoCont">No Contacto</label>
                                    <label class="btn btn-default input_check"><i class="fa fa-check valida_check"></i> <input type="checkbox" class="toggle" id="chkNoGest">No Gestionado</label>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <label>PP </label>
                            <select id="sltPeriodo" class="form-control">
                                <option value="9">--</option>
                                <option value="1">P1</option>
                                <option value="2">P2</option>
                                <option value="3">P3</option>
                                <option value="4">P4</option>
                            </select>
                        </div>
                    </div>
                </div>

                <div class="row">

                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 margin-bottom-20">

                        <div class="col-md-4">
                            <label>FECHA DESDE</label>
                            <input type="text" id="txtDesde" class="form-control date-picker"/>
                        </div>

                        <div class="col-md-4">
                            <label>FECHA HASTA</label>
                            <input type="text" id="txtHasta" class="form-control date-picker"/>
                        </div>

                        <div class="col-md-4">
                            <label>FILTROS</label>
                            <select id="sltFiltro" class="form-control">
                            </select>
                        </div>
                    </div>

                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 margin-bottom-20">
                        <div class="col-md-4">
                            <label>&nbsp;&nbsp;</label>
                            <input type="button" class="form-control btn blue btn_buscar" id="btn_buscar" value="BUSCAR"/>

                        </div>
                        <div class="col-md-4">
                            <label>&nbsp;&nbsp;</label>
                            <input type="button" class="form-control btn blue btn_buscar" id="btn_limpiar" value="LIMPIAR"/>

                        </div>
                        <div class="col-md-4">
                            <div><label>&nbsp;&nbsp;</label></div>
                            <a id="btn_buscar_telefono" class="btn btn-danger btn-circle"><i class="fa fa-phone"></i> LLAMADA</a>
                        </div>
                    </div>
                </div>

                <table id="tblLista" class="tblLista table table-striped table-bordered table-hover dt-responsive" cellspacing="0" width="100%">
                <thead>
                    <tr>
                        <th class="all">Nº Cuenta</th>
                        <th class="min-saldo">PP</th>
                        <th class="min-proovedor">Proveedor</th>
                        <th class="min-cartera">Cartera</th>
                        <th class="min-subcartera">Sub Cartera</th>
                        <th class="min-dni">DNI</th>
                        <th class="min-cliente">Cliente</th>
                        <th class="none">Tipo Contacto</th>
                        <th class="none">Fecha contacto</th>
                        <th class="min-distrito">Distrito</th>
                        <th class="min-moneda">Moneda</th>
                        <th class="min-capital">Capital</th>
                        <th class="min-saldo">Saldo</th>
                        <th class="min-ultgestion">Última Gestión</th>
                        <th class="min-dias">Días mora</th>
                        <th class="min-dias">Días</th>
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
<script type="text/javascript" src='../resource/js/cobranza/bandeja-supervisor.js'></script>
<script type="text/javascript" src='../resource/js/verificar_session.js'></script>
<script src="../resource/js/vita/vita.message.js"></script>


<script src='../resource/assets/global/scripts/datatable.js' type="text/javascript"></script>
<script src='../resource/assets/global/plugins/datatables/datatables.min.js' type="text/javascript"></script>
<script src='../resource/assets/global/plugins/datatables/plugins/bootstrap/datatables.bootstrap.js' type="text/javascript"></script>

Final;

require_once $url_relativa.'resource/masterPage/master.php';
 ?>
