<?php

$data = json_decode(file_get_contents('php://input'), true);

if ( is_array($data) ) :
    require_once "../../clases/bandejas_class.php";
    $cartera = $data['CAR_CODIGO'];
    $bandeja = new Bandejas();
    $subcarteras = $bandeja->getSubCarteras($cartera);
    //var_dump($carteras);
    header('Content-Type: application/json; charset=UTF-8');

    echo json_encode($subcarteras);
endif;

exit;

 ?>
