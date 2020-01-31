<?php


require_once "clases/sesiones_class.php";
$sesion = new Sesiones();
$sesion->closeSession();

header("Location:index.php");
 ?>
