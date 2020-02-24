<?php

$data = json_decode(file_get_contents("php://input"),true);

if ( is_array($data) ) :

    require_once "url_relativa.php";
    require_once $url_relativa."valida_sesion.php";
    require_once $url_relativa."clases/usuario_class.php";
    require_once $url_relativa."clases/direccion_class.php";

    $user = new Usuario();
    $user->setUserInfo();
    $user->setUrlMaster($ruta_web);
    $direccion = new Direccion();

    if ( isset($data['CONSULTA_AJAX']) && $data['CONSULTA_AJAX'] == 'eliminarDireccionId' ) :
        $dir_codigo = $data['codigo'];
        $resultado = $direccion->eliminarDireccion($dir_codigo, $user->getUserId());
        header("Content-Type: application/json; charset=UTF-8");
        echo json_encode($resultado);
        return;
    endif;

    if ( isset($data['CONSULTA_AJAX']) && $data['CONSULTA_AJAX'] == 'listarDistrito' ) :
        $array_param = $data['objUbigeo'];
        $resultado = $direccion->listarDistrito($array_param);
        header("Content-Type: application/json; charset=UTF-8");
        echo json_encode($resultado);
        return;
    endif;

    if ( isset($data['CONSULTA_AJAX']) && $data['CONSULTA_AJAX'] == 'listarProvincia' ) :
        $array_param = $data['objUbigeo'];
        $resultado = $direccion->listarProvincia($array_param);
        header("Content-Type: application/json; charset=UTF-8");
        echo json_encode($resultado);
        return;
    endif;

    if ( isset($_GET['listarDepartamento']) ) :

        $resultado = $direccion->listarDepartamento();
        header("Content-Type: application/json; charset=UTF-8");
        echo json_encode($resultado);
        return;
    endif;

    if ( isset($_GET['listaTipoDireccion']) ) :

        $resultado = $direccion->listaTipoDireccion();
        header("Content-Type: application/json; charset=UTF-8");
        echo json_encode($resultado);
        return;
    endif;

    if ( isset($_GET['listarTipoOrigen']) ) :

        $resultado = $direccion->getListaOrigenDB();
        header("Content-Type: application/json; charset=UTF-8");
        echo json_encode($resultado);
        return;
    endif;

    if ( isset($data['CONSULTA_AJAX']) && $data['CONSULTA_AJAX'] == 'registrar' ) :
        $array_param = $data['objDireccion'];
        $array_param['USU_CODIGO'] = $user->getUserId();
        $resultado = $direccion->registraDireccion($array_param);
        header("Content-Type: application/json; charset=UTF-8");
        echo json_encode($resultado);
        return;
    endif;

    if ( isset($data['CONSULTA_AJAX']) && $data['CONSULTA_AJAX'] == 'obtenerPorId' ) :
        array_pop($data);
        $resultado = $direccion->obtenerPorId($data);
        header("Content-Type: application/json; charset=UTF-8");
        echo json_encode($resultado);
        return;
    endif;

    if ( isset($_GET['obtenerDireccionStatus']) ) :

        $resultado = $direccion->listarDireccionStatus();
        header("Content-Type: application/json; charset=UTF-8");
        echo json_encode($resultado);
        return;
    endif;
endif;

 ?>
