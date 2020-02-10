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


        if ( $data['CONSULTA_AJAX'] == 'obtenerDatosCuenta' ) :
            $cuenta = $data['cuenta'];
            $cliente = new Cliente();
            $resultado = $cliente->getDatosCuenta($cuenta);
            header('Content-Type: application/json; charset=UTF-8');

            echo json_encode($resultado);
        endif;

endif;


 ?>
