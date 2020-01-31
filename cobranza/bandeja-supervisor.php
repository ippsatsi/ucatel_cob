<?php

require_once "valida_sesion.php";
require_once "clases/usuario_class.php";
$user = new Usuario();
$user->setUserInfo();

require_once 'resource/masterPage/master.php';
 ?>
