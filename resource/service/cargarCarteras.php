<?php

$data = json_decode(file_get_contents('php://input'), true);

if ( is_array($data) ) :
    require_once "../../clases/bandejas_class.php";
    $proveedor = $data['PRV_CODIGO'];
    $bandeja = new Bandejas();
    $carteras = $bandeja->getCarteras($proveedor);
    //var_dump($carteras);
    header('Content-Type: application/json; charset=UTF-8');

    echo json_encode($carteras);
endif;

exit;

 ?>
