<?php

require_once "../../clases/bandejas_class.php";

$bandeja = new Bandejas();
$proveedores = $bandeja->getUsuariosCall();
header('Content-Type: application/json; charset=UTF-8');

echo json_encode($proveedores);
exit;

?>
