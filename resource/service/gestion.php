<?php

$data = json_decode(file_get_contents('php://input'), true);

if (  is_array($data) ) :
    require_once "url_relativa.php";
    require_once $url_relativa."valida_sesion.php";
    require_once $url_relativa."clases/usuario_class.php";
    require_once $url_relativa."clases/cliente_class.php";

    $user = new Usuario();
    $user->setUserInfo();
    $user->setUrlMaster($ruta_web);

    //var_dump($data);
    switch ( $data['CONSULTA_AJAX'] ) :
        case 'obtenerDatosCuenta' :
            $cuenta = $data['cuenta'];
            $cliente = new Cliente();
            $resultado = $cliente->getDatosCuenta($cuenta);
            $resultado['d'][0]['CAPITAL_VC'] = $resultado['d'][0]['BAD_DEUDA_MONTO_CAPITAL'];
            $resultado['d'][0]['PROTESTO_VC'] = $resultado['d'][0]['BAD_DEUDA_MONTO_PROTESTO'];
            $resultado['d'][0]['SALDO_VC'] = $resultado['d'][0]['BAD_DEUDA_SALDO'];
            break;
        case 'obtenerPagos' :
            $cue_codigo = $data['codigo'];
            $cliente = new Cliente();
            $resultado = $cliente->getPagosCliente($cue_codigo);
            break;
        case 'cargarGestiones' :
            $cue_codigo = $data['objCuenta']['CUE_CODIGO'];
            $cliente = new Cliente();
            $resultado = $cliente->getGestionesCliente($cue_codigo);
            break;
        case 'obtenerCronograma'  :
            $cue_codigo = $data['CUE_CODIGO'];
            $cliente = new Cliente();
            $resultado = $cliente->getCronogramaCliente($cue_codigo);
            break;
        case 'actualizarCronograma' :
            $cronograma = $data['lstCronograma'][0];
            $cro_codigo = $cronograma['CRO_CODIGO'];
            $pag_monto = $cronograma['PAG_MONTO'];
            $pag_fecha = $cronograma['PAG_FECHA'];
            $cliente = new Cliente();
            $resultado = $cliente->UpdateCronogramaCliente($cro_codigo, $pag_monto, $pag_fecha);
            break;
        case 'listaTipoGestion' :
            $cliente = new Cliente();
            $resultado = $cliente->getListaTipoGestionDB();
            break;
        case 'listarTelefonos':
            $cue_codigo = $data['dni'];
            $cliente = new Cliente();
            $resultado = $cliente->getTlfsCliente($cue_codigo);
            break;
        case 'listarDirecciones':
            $cue_codigo = $data['dni'];
            $cliente = new Cliente();
            $resultado = $cliente->getDirsCliente($cue_codigo);
            break;
        case 'listarCorreos' :
            $dni = $data['dni'];
            $cliente = new Cliente();
            $resultado = $cliente->getCorreosCliente($dni);
            break;
        case 'listarRespuestaPorTipoGestion' :
            $cliente = new Cliente();
            //eliminamos CONSULTA_AJAX
            $array_param = $data;
            array_pop($array_param);
            $resultado = $cliente->getListaRespuestaTipoGestion($array_param);
            break;
        case 'listarSolucionPorTipoRespuesta':
            $cliente = new Cliente();
            //eliminamos CONSULTA_AJAX
            array_pop($data);
            $resultado = $cliente->getlistarSolucionPorTipoRespuesta($data);
            break;
        case 'tieneConvenio':
            $cliente = new Cliente();
            $array_param = $data['objCuentaBE'];
            $resultado = $cliente->getTieneConvenio($array_param);
          break;
        case 'registrarGestion':
            $cliente = new Cliente();
            $array_obj = $data['objGestion'];
            $array_param['CUE_CODIGO'] = $array_obj['ObjCuenta']['CUE_CODIGO'];
            $array_param['TIR_CODIGO'] = $array_obj['ObjTipoResultado']['TIR_CODIGO'];
            $array_param['SOL_CODIGO'] = isset($array_obj['ObjTipoResultado']['SOL_CODIGO']) ? $array_obj['ObjTipoResultado']['SOL_CODIGO'] : 0 ;
            $array_param['TEL_CODIGO'] = $array_obj['ObjTelefono']['TEL_CODIGO'];
            $array_param['GES_OBSERVACIONES'] = $array_obj['GES_OBSERVACIONES'];
            $array_param['CAR_CODIGO'] = $array_obj['ObjCartera']['CAR_CODIGO'];
            $array_param['SCA_CODIGO'] = $array_obj['ObjSubCartera']['SCA_CODIGO'];
            $array_param['DIR_CODIGO'] = $array_obj['ObjDireccion']['DIR_CODIGO'];
            $array_param['USU_CODIGO'] = $user->getUserId();
            $array_param['TIG_CODIGO'] = $array_obj['ObjTipoGestion']['TIG_CODIGO'];
            $array_param['GES_FECHA_INICIAL'] = $array_obj['GES_FECHA_INICIAL'];
            $array_param['GES_IMPORTE_INICIAL'] = $array_obj['GES_IMPORTE_INICIAL'];
            $array_param['GES_NRO_CUOTAS'] = $array_obj['GES_NRO_CUOTAS'];
            $array_param['GES_IMPORTE_NEGOCIACION'] = $array_obj['GES_IMPORTE_NEGOCIACION'];
            $array_param['GES_SALDO_NEGOCIACION'] = $array_obj['GES_SALDO_NEGOCIACION'];
            $array_param['GES_VALOR_CUOTA'] = $array_obj['GES_VALOR_CUOTA'];
            $array_param['REC_NUMERO'] = $array_obj['REC_NUMERO'];
            $array_param['REC_AGENCIA'] = $array_obj['REC_AGENCIA'];
            $array_param['REC_MONTO'] = $array_obj['REC_MONTO'];
            $array_param['REC_FECHA'] = $array_obj['REC_FECHA'];
            // :TIR_CODIGO,
            // :SOL_CODIGO,
            // 0,
            // :TEL_CODIGO,
            // :GES_OBSERVACIONES,
            // :CUE_CODIGO,
            // :CAR_CODIGO,
            // :SCA_CODIGO,
            // :DIR_CODIGO,
            // 0,
            // :USU_CODIGO,
            // :TIG_CODIGO,
            // :GES_FECHA_INICIAL,
            // :GES_IMPORTE_INICIAL,
            // 0,
            // :GES_NRO_CUOTAS,
            // :GES_IMPORTE_NEGOCIACION,
            // :GES_SALDO_NEGOCIACION,
            // :GES_VALOR_CUOTA,
            // :REC_NUMERO,
            // :REC_AGENCIA,
            // :REC_MONTO,
            // :REC_FECHA";
            $resultado = $cliente->setRegistrarGestion($array_param);
            $ges_codigo = $resultado['d'];
            //vemos si es un convenio la gestion a registrar
            if ( $ges_codigo > 0 && isset($data['objGestion']['lstCronogramaBE']) ) :
                //consultamos si ya tiene cronograma
                if ( $data['objGestion']['FLG_ELIMINAR_CRONOGRAMA']  ) :
                    //eliminamos si tiene un cronograma anteriior
                    $del_cronograma['CUE_CODIGO'] = $array_param['CUE_CODIGO'];
                    $del_cronograma['CRO_USUARIO_MODIFICA'] = $array_param['USU_CODIGO'];
                    $del_cronograma['TXT_MOTIVO_CONVENIO'] = $array_obj['ObjCuenta']['TXT_MOTIVO_CONVENIO'];
                    $result = $cliente->setEliminarCronograma($del_cronograma);
                    $resultado['elimina_cronograma'] = $result;
                endif;
                //agregamos la cuota 0 al array de cuotas
                $array_cuota_cero = [ "NRO_CUOTA" => 0,
                                      "FEC_VENCIMIENTO" => $array_param['GES_FECHA_INICIAL'],
                                      "IMP_CUOTA" => $array_param['GES_IMPORTE_INICIAL'] ];
                $array_cronograma = $data['objGestion']['lstCronogramaBE'];
                array_unshift($array_cronograma, $array_cuota_cero);
                //insertamos cuota por cuota en la tabla de CRONOGRAMA
                foreach ($array_cronograma as $cuota) :
                    $cuota['CUE_CODIGO'] = $array_param['CUE_CODIGO'];
                    $cuota['GES_CODIGO'] = $ges_codigo;
                    $cuota['USU_CODIGO'] = $array_param['USU_CODIGO'];
                    $result = $cliente->setRegistraCronograma($cuota);
                    $resultado['cronograma'][] = $result;
                endforeach;
                //seteamos que tiene convenio en la tabla GCC_CUENTAS
                $array_param = array();
                $array_param['GES_FECHA_INICIAL'] = $array_obj['GES_FECHA_INICIAL'];
                $array_param['GES_IMPORTE_INICIAL'] = $array_obj['GES_IMPORTE_INICIAL'];
                $array_param['CUE_CONVENIO_CUOTAS'] = $array_obj['GES_NRO_CUOTAS'];
                $array_param['CUE_CODIGO'] = $array_obj['ObjCuenta']['CUE_CODIGO'];
                $result = $cliente->setCuentaTieneConvenio($array_param);
                $resultado['CUENTA_TIENE_CONVENIO'] = $result;
            endif;
            break;
        case 'inactivarConvenio':
            $cliente = new Cliente();
            //eliminamos CONSULTA_AJAX
            array_pop($data);
            $data['USU_CODIGO'] = $user->getUserId();
            $resultado = $cliente->setDesactivarCronograma($data);
            break;
        case 'registrarTarea':
            $cliente = new Cliente();
            $array_param = $data['tarea'];
            $array_param['REC_USUARIO'] = $user->getUserId();
            // @GES_CODIGO INT,
            // @REC_FECHA VARCHAR(10),
            // @REC_HORA CHAR(12),
            // @REC_OBSERVACIONES VARCHAR(300),
            // @TIR_CODIGO INT,
            // @CLI_CODIGO INT,
            // @REC_USUARIO INT
            $resultado = $cliente->setRegistrarTareaRecordatorio($array_param);
            break;
        case 'registrarGestionProgresivo':
            $cliente = new Cliente();
            $array_obj = $data['objGestion'];
            $array_param['CUE_CODIGO'] = $array_obj['ObjCuenta']['CUE_CODIGO'];
            $array_param['TIR_CODIGO'] = $array_obj['ObjTipoResultado']['TIR_CODIGO'];
            $array_param['SOL_CODIGO'] = isset($array_obj['ObjTipoResultado']['SOL_CODIGO']) ? $array_obj['ObjTipoResultado']['SOL_CODIGO'] : 0 ;
            $array_param['TEL_CODIGO'] = $array_obj['ObjTelefono']['TEL_CODIGO'];
            $array_param['GES_OBSERVACIONES'] = $array_obj['GES_OBSERVACIONES'];
            $array_param['CAR_CODIGO'] = $array_obj['ObjCartera']['CAR_CODIGO'];
            $array_param['SCA_CODIGO'] = $array_obj['ObjSubCartera']['SCA_CODIGO'];
            $array_param['DIR_CODIGO'] = $array_obj['ObjDireccion']['DIR_CODIGO'];
            $array_param['USU_CODIGO'] = $user->getUserId();
            $array_param['TIG_CODIGO'] = $array_obj['ObjTipoGestion']['TIG_CODIGO'];
            $array_param['GES_FECHA_INICIAL'] = $array_obj['GES_FECHA_INICIAL'];
            $array_param['GES_IMPORTE_INICIAL'] = $array_obj['GES_IMPORTE_INICIAL'];
            $array_param['GES_NRO_CUOTAS'] = $array_obj['GES_NRO_CUOTAS'];
            $array_param['GES_IMPORTE_NEGOCIACION'] = $array_obj['GES_IMPORTE_NEGOCIACION'];
            $array_param['GES_SALDO_NEGOCIACION'] = $array_obj['GES_SALDO_NEGOCIACION'];
            $array_param['GES_VALOR_CUOTA'] = $array_obj['GES_VALOR_CUOTA'];
            $array_param['REC_NUMERO'] = $array_obj['REC_NUMERO'];
            $array_param['REC_AGENCIA'] = $array_obj['REC_AGENCIA'];
            $array_param['REC_MONTO'] = $array_obj['REC_MONTO'];
            $array_param['REC_FECHA'] = $array_obj['REC_FECHA'];
            // :TIR_CODIGO,
            // :SOL_CODIGO,
            // 0,
            // :TEL_CODIGO,
            // :GES_OBSERVACIONES,
            // :CUE_CODIGO,
            // :CAR_CODIGO,
            // :SCA_CODIGO,
            // :DIR_CODIGO,
            // 0,
            // :USU_CODIGO,
            // :TIG_CODIGO,
            // :GES_FECHA_INICIAL,
            // :GES_IMPORTE_INICIAL,
            // 0,
            // :GES_NRO_CUOTAS,
            // :GES_IMPORTE_NEGOCIACION,
            // :GES_SALDO_NEGOCIACION,
            // :GES_VALOR_CUOTA,
            // :REC_NUMERO,
            // :REC_AGENCIA,
            // :REC_MONTO,
            // :REC_FECHA";
            $resultado = $cliente->setRegistrarGestionProgresivo($array_param);
            $ges_codigo = $resultado['d'];
            //vemos si es un convenio la gestion a registrar
            if ( $ges_codigo > 0 && isset($data['objGestion']['lstCronogramaBE']) ) :
                //consultamos si ya tiene cronograma
                if ( $data['objGestion']['FLG_ELIMINAR_CRONOGRAMA']  ) :
                    //eliminamos si tiene un cronograma anteriior
                    $del_cronograma['CUE_CODIGO'] = $array_param['CUE_CODIGO'];
                    $del_cronograma['CRO_USUARIO_MODIFICA'] = $array_param['USU_CODIGO'];
                    $del_cronograma['TXT_MOTIVO_CONVENIO'] = $array_obj['ObjCuenta']['TXT_MOTIVO_CONVENIO'];
                    $result = $cliente->setEliminarCronograma($del_cronograma);
                    $resultado['elimina_cronograma'] = $result;
                endif;
                //agregamos la cuota 0 al array de cuotas
                $array_cuota_cero = [ "NRO_CUOTA" => 0,
                                      "FEC_VENCIMIENTO" => $array_param['GES_FECHA_INICIAL'],
                                      "IMP_CUOTA" => $array_param['GES_IMPORTE_INICIAL'] ];
                $array_cronograma = $data['objGestion']['lstCronogramaBE'];
                array_unshift($array_cronograma, $array_cuota_cero);
                //insertamos cuota por cuota en la tabla de CRONOGRAMA
                foreach ($array_cronograma as $cuota) :
                    $cuota['CUE_CODIGO'] = $array_param['CUE_CODIGO'];
                    $cuota['GES_CODIGO'] = $ges_codigo;
                    $cuota['USU_CODIGO'] = $array_param['USU_CODIGO'];
                    $result = $cliente->setRegistraCronograma($cuota);
                    $resultado['cronograma'][] = $result;
                endforeach;
                //seteamos que tiene convenio en la tabla GCC_CUENTAS
                $array_param = array();
                $array_param['GES_FECHA_INICIAL'] = $array_obj['GES_FECHA_INICIAL'];
                $array_param['GES_IMPORTE_INICIAL'] = $array_obj['GES_IMPORTE_INICIAL'];
                $array_param['CUE_CONVENIO_CUOTAS'] = $array_obj['GES_NRO_CUOTAS'];
                $array_param['CUE_CODIGO'] = $array_obj['ObjCuenta']['CUE_CODIGO'];
                $result = $cliente->setCuentaTieneConvenio($array_param);
                $resultado['CUENTA_TIENE_CONVENIO'] = $result;
            endif;
        break;

        default:
            $resultado = ["error" => "consulta no encontrada"];
        break;
    endswitch;

    header('Content-Type: application/json; charset=UTF-8');
    echo json_encode($resultado);

endif;

?>
