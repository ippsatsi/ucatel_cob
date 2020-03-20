<?php
session_start();
$error_message = "";
if (!isset($_SESSION['usuario']))
{
  header("Location:".$ruta_web."index.php");
  exit;
}

 ?>
