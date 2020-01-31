<?php

$data = json_decode(file_get_contents('php://input'), true);

//If json_decode failed, the JSON is invalid.
if(is_array($data)):
    $user = $data['usuario']['USU_LOGIN'];
    $password = $data['usuario']['USU_CLAVE'];


    require_once "../../clases/usuario_class.php";


        $usuario = new Usuario();
        $result = $usuario->user_info($user, $password);

        header('Content-Type: application/json; charset=UTF-8');

        echo json_encode($result);


        exit;


else:
  exit;
endif;

 ?>
