<?php

if ( !isset($_GET['cuenta']) ) :
    echo "<h1>No indico el numero de cuenta o contrato</h1>";
endif;

$cuenta = $_GET['cuenta'];
require_once "url_relativa.php";
require_once $url_relativa."valida_sesion.php";
require_once $url_relativa."clases/usuario_class.php";
require_once $url_relativa."clases/cliente_class.php";

$user = new Usuario();
$user->setUserInfo();
$user->setUrlMaster($ruta_web);
//mostramos todas la cuentas que tiene el cliente
$cliente = new Cliente();
$cuentas_adicionales = $cliente->getCuentasCliente($cuenta);
$cuenta_html = '';
if ( count($cuentas_adicionales['d']) > 0 ) :
    $array = $cuentas_adicionales['d'];
    foreach ($array as $fila) :
        $cuenta_html .= "<tr>";
        $cuenta_html .= '    <td>'.($fila['ES_CUENTA']==1 ? '<i class="fa fa-credit-card">' : '').'</i></td>';
        $cuenta_html .= '    <td><a href="gestionar-cuenta.php?cuenta='.$fila['CUE_NROCUENTA'].'">'.$fila['CUE_NROCUENTA'].'</a></td>';
        $cuenta_html .= '    <td>'.$fila['CUE_PRODUCTO'].'</td>';
        $cuenta_html .= '    <td>'.$fila['CUE_PRODUCTO_DESC'].'</td>';
        $cuenta_html .= '    <td>'.$fila['BAD_DEUDA_SALDO'].'</td>';
        $cuenta_html .= '    <td>'.$fila['BAD_DEUDA_MONTO_CAPITAL'].'</td>';
        $cuenta_html .= "</tr>";
    endforeach;

    $tabla_cuentas = <<<Final
    <table id="tblCuentas" class="table table-bordered">
        <thead>
            <tr>
                <th></th>
                <th>NRO. CUENTA</th>
                <th>PRODUCTO</th>
                <th>DESCRIPCIÓN</th>
                <th>DEUDA</th>
                <th>CAPITAL</th>
            </tr>
        </thead>
        <tbody>
            $cuenta_html
        </tbody>
    </table>

Final;
endif;

//Extraemos los datos de los cuadros informativos para mostrarlos

$datos_cuadros = $cliente->getCuadrosCliente($cuenta);

$head =<<<Final
<link href="${url_relativa}resource/datatables/css/jquery.dataTables.css" rel="stylesheet" />
Final;
$titulo = "";//"BANDEJA DE GESTIONES";
$sub_titulo = "";//"Página de inicio";
$sub_titulo = "";
$pageBar = "";/*<<<Final
<div class="page-toolbar">
    <div class="clearfix">
        <div class="btn-group" data-toggle="buttons">
            <label class="btn blue-chambray active" id="chk_diario"><input type="radio" class="toggle"/> Gestiones de día </label>
            <label class="btn blue-chambray" id="chk_semanal"><input type="radio" class="toggle"/> Gestiones del mes </label>
        </div>
    </div>
</div>

Final;
*/

$contenido =<<<Final
<div class="container-fluid">
    <input type="hidden" name="ctl00\$contenido\$txtCuenta" id="contenido_txtCuenta" value="$cuenta" />
    <input type="hidden" id="txtCodigoCliente" value="0"/>
    <input type="hidden" id="txtCodigoProveedor" value="0"/>
    <input type="hidden" id="txtCodigoCuenta" value="0"/>
    <input type="hidden" id="txtCodigoCartera" value="0"/>
    <input type="hidden" id="txtCodigoSubCartera" value="0"/>
    <input type="hidden" id="txtCodigoGestion" value="0"/>
    <input type="hidden" id="txtCodigoRol" value="{$user->getUserRol()}"/>
    <input type="hidden" id="txtAnexo" value="{$user->getUserAnexo()}"/>
    <input type="hidden" id="txtTroncal" value="{$user->getUserTroncalCh()}"/>
    <input type="hidden" id="txtContextoSip" value="{$user->getUserContextSip()}"/>
    <div class="row content">
        <div class="col-sm-3 sidenav">
            <div class="panel panel-primary">
                <div class="panel-heading">
                  <h3 class="panel-title"><i class="fa fa-user" aria-hidden="true"></i> DATOS DEL CLIENTE</h3>
                </div>
                <div class="panel-body">
                    <div class="form-group">
                        <img src="../resource/img/sin-imagen.png" class="img-thumbnail" alt="Cinque Terre" width="304" height="236"/>
                    </div>
                    <div class="form-group">
                        <label for="txtDni"><b>DNI:</b></label><br />
                        <span id="txtDni"></span>
                    </div>
                    <div class="form-group">
                        <label for="txtNombres"><b>NOMBRES Y APELLIDOS:</b></label><br />
                        <span id="txtNombres"></span>
                    </div>
                    <div class="form-group">
                        <label for="txtDireccion"><b>DIRECCIÓN:</b></label><br />
                        <span id="txtDireccion"></span><br />
                        <span id="txtUbigeo"></span>
                    </div>
                    <div class="form-group">
                        <label for="txtNombres"><b>CORREO:</b></label><br />
                        <span id="txtCorreo"></span>
                    </div>
                    <div class="form-group">
                        <label for="txtNombres"><b>USUARIO CALL:</b></label><br />
                        <span id="txtUsuarioCall"></span>
                    </div>
                    <div class="form-group">
                        <label for="txtNombres"><b>USUARIO CAMPO:</b></label><br />
                        <span id="txtUsuarioCampo"></span>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-sm-9">
            <div class="panel panel-primary">
                <div class="panel-heading">
                  <h3 class="panel-title"><i class="fa fa-credit-card-alt" aria-hidden="true"></i> DATOS DE LA CUENTA</h3>
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-sm-2" id="divDiasMora" style="display:none;">
                            <div class="panel panel-danger">
                            <div class="panel-heading">
                                <h3 class="panel-title">DIAS DE MORA</h3>
                            </div>
                            <div class="panel-body">
                                <span id="txtDiasMora">0</span>
                            </div>
                            </div>
                        </div>
                        <div class="col-sm-2">
                            <div class="panel panel-primary">
                            <div class="panel-heading">
                                <h3 class="panel-title">DIAS SIN GESTIÓN</h3>
                            </div>
                            <div class="panel-body">
                                <span id="txtDias">0</span>
                            </div>
                            </div>
                        </div>
                        <div class="col-sm-2" id="divCampanaMinimo" style="display:none;">
                            <div class="panel panel-danger">
                            <div class="panel-heading">
                                <h3 class="panel-title">CAMPAÑA MINIMO</h3>
                            </div>
                            <div class="panel-body">
                                <span id="txtCampanaMinimo">0</span>
                            </div>
                            </div>
                        </div>
                        <div class="col-sm-2" id="divCampanaMaximo" style="display:none;">
                            <div class="panel panel-primary">
                            <div class="panel-heading">
                                <h3 class="panel-title">CAMPAÑA MAXIMO</h3>
                            </div>
                            <div class="panel-body">
                                <span id="txtCampanaMaximo">0</span>
                            </div>
                            </div>
                        </div>
                        <div class="col-sm-2" id="divCampanaCancelacion" style="display:none;">
                            <div class="panel panel-danger">
                            <div class="panel-heading">
                                <h3 class="panel-title">CAMPAÑA CANCELACIÓN</h3>
                            </div>
                            <div class="panel-body">
                                <span id="txtCampanaCancelacion">0</span>
                            </div>
                            </div>
                        </div>
                        <div class="col-sm-2" id="divCampanaArmada" style="display:none;">
                            <div class="panel panel-primary">
                            <div class="panel-heading">
                                <h3 class="panel-title">CAMPAÑA ARMADA</h3>
                            </div>
                            <div class="panel-body">
                                <span id="txtCampanaArmada">0</span>
                            </div>
                            </div>
                        </div>
                    </div>
                    <div class="row" id="divDatosCuenta">
                    $datos_cuadros
                    </div>
                    <div class="panel-group">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h4 class="panel-title">
                                <a data-toggle="collapse" href="#collapse4">CUENTAS DEL CLIENTE</a>
                                </h4>
                            </div>
                            <div id="collapse4" class="panel-collapse collapse in">
                                <div id="div_cuentas_adicionales" class="panel-body table-responsive">
                                    $tabla_cuentas
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="panel-group" id="divConvenio" style="display:none;">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h4 class="panel-title">
                                <a data-toggle="collapse" href="#collapse7">CONVENIO</a>
                                </h4>
                            </div>
                            <div id="collapse7" class="panel-collapse collapse in">
                                <div class="panel-body table-responsive">
                                    <table id="tblCronograma" class="table table-striped table-bordered table-hover">
                                        <thead>
                                            <tr>
                                                <th>CUOTA</th>
                                                <th>FECHA VENCIMIENTO</th>
                                                <th>IMPORTE</th>
                                                <th>ESTADO PAGO</th>
                                                <th>IMPORTE PAGO</th>
                                                <th>FECHA PAGO</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="panel-footer">
                                    <button type="button" class="btn btn-primary" id="btnRegistrarCronograma">ACEPTAR</button>
                                    <button type="button" class="btn btn-danger"  id="btnCancelarCronograma">CANCELAR</button>
                                    <!--<button type="button" class="btn btn-primary" onclick="registrarTelefono(0);"><i class="fa fa-phone" aria-hidden="true"></i> NUEVO TELÉFONO</button>-->
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="panel-group" id="div_gestion_datos">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h4 class="panel-title">
                                <a data-toggle="collapse" href="#collapse5">GESTION DE TELEFONOS, DIRECCIONES Y CORREOS</a>
                                </h4>
                            </div>
                            <div id="collapse5" class="panel-collapse collapse in">

                                <ul class="nav nav-pills">
                      <li class="active"><a data-toggle="tab" href="#home">TELÉFONOS</a></li>
                      <li><a data-toggle="tab" href="#menu1">DIRECCIONES</a></li>
                      <li><a data-toggle="tab" href="#menu2">CORREOS</a></li>
                    </ul>

                    <div class="tab-content">
                      <div id="home" class="tab-pane fade in active">
                        <div class="panel panel-default">
                            <div id="collapse1" class="panel-collapse collapse in">
                                <div class="panel-body table-responsive">
                                    <table id="tblTelefonos" class="table table-bordered">
                                        <thead>
                                            <tr>
                                                <th>N°</th>
                                                <th>TELEFONO</th>
                                                <th>ANEXO</th>
                                                <th>HIS</th>
                                                <th>PER</th>
                                                <th>ESTADO</th>
                                                <th>ORIGEN</th>
                                                <th>OBSERVACIÓN</th>
                                                <th></th>
                                                <th></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="panel-footer">
                                    <button type="button" class="btn btn-primary" onclick="registrarTelefono(0);"><i class="fa fa-phone" aria-hidden="true"></i> NUEVO TELÉFONO</button>
                                </div>
                            </div>
                        </div>
                      </div>
                      <div id="menu1" class="tab-pane fade">
                        <div class="panel panel-default">
                            <div id="collapse2" class="panel-collapse collapse in">
                                <div class="panel-body table-responsive">
                                    <table id="tblDirecciones" class="table table-bordered">
                                        <thead>
                                            <tr>
                                                <th>N°</th>
                                                <th>DIRECCIÓN</th>
                                                <th>DISTRITO</th>
                                                <th>VALIDO</th>
                                                <th>TIPO DIRECCIÓN</th>
                                                <th>ORIGEN</th>
                                                <th></th>
                                                <th></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="panel-footer">
                                    <button type="button" class="btn btn-primary" onclick="registrarDireccion(0);"><i class="fa fa-home" aria-hidden="true"></i> NUEVO DIRECCIÓN</button>
                                </div>
                            </div>
                        </div>
                      </div>
                      <div id="menu2" class="tab-pane fade">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h4 class="panel-title">
                                <a data-toggle="collapse" href="#collapse5">GESTIÓN DE CORREOS</a>
                                </h4>
                            </div>
                            <div id="Div1" class="panel-collapse collapse in">
                                <div class="panel-body table-responsive">
                                    <table id="tblCorreos" class="table table-bordered">
                                        <thead>
                                            <tr>
                                                <th>N°</th>
                                                <th>CORREO</th>
                                                <th></th>
                                                <th></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="panel-footer">
                                    <button type="button" class="btn btn-primary" onclick="registrarCorreo(0);"><i class="fa fa-home" aria-hidden="true"></i> NUEVO CORREO</button>
                                </div>
                            </div>
                        </div>
                      </div>
                    </div>

                            </div>
                        </div>
                    </div>
<!--gestiones telefonos direccion-->
                </div>
            </div>
        </div>
    </div>

    <div class="row content">
        <div class="panel-group">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h4 class="panel-title">
                    <a data-toggle="collapse" href="#collapse3">HISTORIAL DE GESTIONES</a>
                    </h4>
                </div>
                <div id="collapse3" class="panel-collapse collapse in">
                    <div class="panel-body table-responsive">
                        <table id="tblMultas" class="table table-striped table-bordered">
                            <thead>
                                <tr>
                                    <th>N°</th>
                                    <th>FECHA</th>
                                    <th>USUARIO</th>
                                    <th>RESPUESTA</th>
                                    <th>SOLUCIÓN</th>
                                    <th>TIPO</th>
                                    <th>MONEDA</th>
                                    <th>IMPORTE NEGOCIACIÓN</th>
                                    <th>SALDO NEGOCIACIÓN</th>
                                    <th>FECHA</th>
                                    <th>IMPORTE</th>
                                    <th>N° CUOTAS</th>
                                    <th>VALOR CUOTA</th>
                                    <th>TELEFONO</th>
                                    <th>DIRECCIÓN</th>
                                    <th>OBSERVACIONES</th>
                                </tr>
                            </thead>
                            <tbody></tbody>
                        </table>
                    </div>
                    <div class="panel-footer">
                        <button type="button" class="btn btn-danger" onclick="nuevaGestion();"><i class="fa fa-plus" aria-hidden="true"></i> NUEVA GESTIÓN</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
Final;

$script =<<<Final
<script src="${url_relativa}resource/datatables/jquery.dataTables.js"></script>
<script src="${url_relativa}resource/js/cobranza/gestionar-cuenta.js" type="text/javascript"></script>

Final;

require_once $url_relativa.'resource/masterPage/master.php';

 ?>
