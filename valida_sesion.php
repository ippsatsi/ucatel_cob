<?php
session_start();
$error_message = "";
if (!isset($_SESSION['usuario']))
{
  header("Location:index.php");
  exit;
}

 ?>
