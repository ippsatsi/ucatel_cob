<?php

$data = json_decode(file_get_contents("php://input"),true);

if ( is_array($data) ) :


    require_once "url_relativa.php";
    require_once $url_relativa."valida_sesion.php";
    require_once $url_relativa."clases/usuario_class.php";
    require_once $url_relativa."clases/telefono_class.php";

    $user = new Usuario();
    $user->setUserInfo();
    $user->setUrlMaster($ruta_web);
    $telefono = new Telefono();

    if ( isset($data['CONSULTA_AJAX']) && $data['CONSULTA_AJAX'] == 'eliminarTelefonoId' ) :
        $tel_codigo = $data['codigo'];
        $resultado = $telefono->eliminaTelefono($tel_codigo, $user->getUserId());
        header("Content-Type: application/json; charset=UTF-8");
        echo json_encode($resultado);
        return;
    endif;

    if ( isset($data['CONSULTA_AJAX']) && $data['CONSULTA_AJAX'] == 'obtenerPorId' ) :
        $tel_codigo = $data['codigo'];
        $resultado = $telefono->getDatosTelfById($tel_codigo);
        header("Content-Type: application/json; charset=UTF-8");
        echo json_encode($resultado);
        return;
    endif;

    if ( isset($data['CONSULTA_AJAX']) && $data['CONSULTA_AJAX'] == 'registrar' ) :
        $obj_parametros = $data['objTelefono'];
        $obj_parametros['USU_CODIGO'] = $user->getUserId();
        // @TEL_CODIGO INT OUTPUT,
// @TEL_NUMERO VARCHAR(15),
// --@TIT_CODIGO INT,
// --@TIO_CODIGO INT,
// @TEL_ESTADO_VALIDEZ CHAR(2),
// @TEL_USUARIO_REGISTRO INT,
// @CLI_CODIGO INT,
// @TOR_CODIGO INT,
// --@TEL_TIPO_EQUIPO CHAR(1),
// @TEL_ESTADO_TELEFONO CHAR(1),
// @TEL_ANEXO VARCHAR(10),
// @PRV_CODIGO INT,
// @TEL_OBSERVACIONES VARCHAR(300)
        $resultado = $telefono->registraTelefono($obj_parametros);
        header("Content-Type: application/json; charset=UTF-8");
        echo json_encode($resultado);
        return;
    endif;

    if ( isset($_GET['obtenerTelefonoStatus']) ) :

        $resultado = $telefono->getStatusTelefono();
        header("Content-Type: application/json; charset=UTF-8");
        echo json_encode($resultado);
        return;
    endif;

    if ( isset($_GET['listarTipoOrigen']) ) :
        $resultado = $telefono->getListaOrigenDB();
        header("Content-Type: application/json; charset=UTF-8");
        echo json_encode($resultado);
        return;
    endif;

    if ( isset($data['CONSULTA_AJAX']) && $data['CONSULTA_AJAX'] == 'buscar_telefono' ) :

        $resultado = $telefono->getResultadosBusqueda($data);
        header("Content-Type: application/json; charset=UTF-8");
        echo json_encode($resultado);
        return;
    endif;
endif;
 ?>
