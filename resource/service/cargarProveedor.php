<?php

require_once "../../clases/bandejas_class.php";

$bandeja = new Bandejas();
$proveedores = $bandeja->getProveedores();
echo "<pre>";
var_dump($proveedores);
echo "</pre>";
//If json_decode failed, the JSON is invalid.
    //
    // $user = $data['usuario']['USU_LOGIN'];
    // $password = $data['usuario']['USU_CLAVE'];
    //
    //
    // require_once "../../clases/usuario_class.php";
    //
    //
    //     $usuario = new Usuario();
    //     $result = $usuario->user_info($user, $password);
    //
    //     header('Content-Type: application/json; charset=UTF-8');
    //
    //     echo json_encode($result);
    //
    //
    //     exit;





?>
