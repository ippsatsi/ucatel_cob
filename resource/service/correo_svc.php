<?php

$data = json_decode(file_get_contents("php://input"),true);

if ( is_array($data) ) :

      require_once "url_relativa.php";
      require_once $url_relativa."valida_sesion.php";
      require_once $url_relativa."clases/usuario_class.php";
      require_once $url_relativa."clases/correo_class.php";

      $user = new Usuario();
      $user->setUserInfo();
      $user->setUrlMaster($ruta_web);
      $correo = new Correo();

      if ( isset($data['CONSULTA_AJAX']) && $data['CONSULTA_AJAX'] == 'eliminarCorreoId' ) :
          $cor_codigo = $data['codigo'];
          $resultado = $correo->eliminarCorreo($cor_codigo, $user->getUserId());
          header("Content-Type: application/json; charset=UTF-8");
          echo json_encode($resultado);
          return;
      endif;

      if ( isset($data['CONSULTA_AJAX']) && $data['CONSULTA_AJAX'] == 'registrar' ) :
          $array_param = $data['objCorreo'];
          $array_param['USU_CODIGO'] = $user->getUserId();
          $resultado = $correo->registraCorreo($array_param);
          header("Content-Type: application/json; charset=UTF-8");
          echo json_encode($resultado);
          return;
      endif;
endif;

 ?>
