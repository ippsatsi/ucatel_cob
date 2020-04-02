<?php

$data = json_decode(file_get_contents('php://input'), true);


if ( is_array($data) ) :
    require_once "url_relativa.php";
    require_once $url_relativa."valida_sesion.php";
    require_once $url_relativa."clases/usuario_class.php";
    
    $user = new Usuario();
    $user->setUserInfo();
    $user->setUrlMaster($ruta_web);

    switch ($data['CONSULTA_AJAX']) :
        case 'liberarUsuario':
            //eliminamos CONSULTA_AJAX
            array_pop($data);
            $resultado = $user->liberar_usuario($data);
            break;
        
        default:
            $resultado = ["error" => "consulta no encontrada"];
            break;
    endswitch;

    header('Content-Type: application/json; charset=UTF-8');
    echo json_encode($resultado);

endif;

?>