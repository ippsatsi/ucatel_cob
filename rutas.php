<?php

$campos_url = explode("/",$_SERVER['REQUEST_URI']);
//var_dump($_SERVER);
$ruta_web = $_SERVER['REQUEST_SCHEME']."://".$_SERVER['SERVER_NAME']."/".$campos_url['1']."/";
$MapPath = "/$campos_url[1]/";

 ?>
