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
        if ( $data['CONSULTA_AJAX'] == 'obtenerDatosCuenta' ) :
            $cuenta = $data['cuenta'];
            $cliente = new Cliente();
            $resultado = $cliente->getDatosCuenta($cuenta);
            $resultado['d'][0]['CAPITAL_VC'] = $resultado['d'][0]['BAD_DEUDA_MONTO_CAPITAL'];
            $resultado['d'][0]['PROTESTO_VC'] = $resultado['d'][0]['BAD_DEUDA_MONTO_PROTESTO'];
            $resultado['d'][0]['SALDO_VC'] = $resultado['d'][0]['BAD_DEUDA_SALDO'];
            header('Content-Type: application/json; charset=UTF-8');

            echo json_encode($resultado);
        endif;

        if ( $data['CONSULTA_AJAX'] == 'obtenerPagos' ) :
            $cue_codigo = $data['codigo'];
            $cliente = new Cliente();
            $resultado = $cliente->getPagosCliente($cue_codigo);
            header('Content-Type: application/json; charset=UTF-8');

            echo json_encode($resultado);
        endif;

        if ( $data['CONSULTA_AJAX'] == 'listarTelefonos' ) :
            $cue_codigo = $data['dni'];
            $cliente = new Cliente();
            $resultado = $cliente->getTlfsCliente($cue_codigo);
            header('Content-Type: application/json; charset=UTF-8');

            echo json_encode($resultado);
        endif;

        if ( $data['CONSULTA_AJAX'] == 'listarDirecciones' ) :
            $cue_codigo = $data['dni'];
            $cliente = new Cliente();
            $resultado = $cliente->getDirsCliente($cue_codigo);
            header('Content-Type: application/json; charset=UTF-8');

            echo json_encode($resultado);
        endif;

        if ( $data['CONSULTA_AJAX'] == 'listarCorreos' ) :
            $dni = $data['dni'];
            $cliente = new Cliente();
            $resultado = $cliente->getCorreosCliente($dni);
            header('Content-Type: application/json; charset=UTF-8');

            echo json_encode($resultado);
        endif;

        if ( $data['CONSULTA_AJAX'] == 'cargarGestiones' ) :
            $cue_codigo = $data['objCuenta']['CUE_CODIGO'];
            $cliente = new Cliente();
            $resultado = $cliente->getGestionesCliente($cue_codigo);
            header('Content-Type: application/json; charset=UTF-8');

            echo json_encode($resultado);
        endif;

        if ( $data['CONSULTA_AJAX'] == 'obtenerCronograma' ) :
            $cue_codigo = $data['CUE_CODIGO'];
            $cliente = new Cliente();

            $resultado = $cliente->getCronogramaCliente($cue_codigo);

            header('Content-Type: application/json; charset=UTF-8');
            echo json_encode($resultado);
        endif;
        //
        if ( $data['CONSULTA_AJAX'] == 'actualizarCronograma' ) :
          //lstCronograma
            $cronograma = $data['lstCronograma'][0];
            $cro_codigo = $cronograma['CRO_CODIGO'];
            $pag_monto = $cronograma['PAG_MONTO'];
            $pag_fecha = $cronograma['PAG_FECHA'];
            $cliente = new Cliente();

            $resultado = $cliente->UpdateCronogramaCliente($cro_codigo, $pag_monto, $pag_fecha);

            header('Content-Type: application/json; charset=UTF-8');
            echo json_encode($resultado);
        endif;
endif;


 ?>
