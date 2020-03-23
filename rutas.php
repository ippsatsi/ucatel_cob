<?php

$campos_url = explode("/",$_SERVER['REQUEST_URI']);
//eliminamos la parte ultima que se refiere al archivo
array_pop($campos_url);
//lo volvemos a unir en una sola cadena
$url_data = implode('/',$campos_url);
// var_dump($_SERVER);
$port = $_SERVER['SERVER_PORT'] == '80' ? '' : ':'.$_SERVER['SERVER_PORT'];
// $ruta_web = $_SERVER['REQUEST_SCHEME']."://".$_SERVER['SERVER_NAME']."/".$campos_url['1']."/";
// $ruta_web = $_SERVER['REQUEST_SCHEME']."://".$_SERVER['SERVER_NAME']."/".$campos_url."/";
//eliminamos las carpetas secundarias como cobranza, reportes, cargas
$url_data = $carpeta_secundaria == "" ? $url_data : str_replace($carpeta_secundaria, "", $url_data);
$ruta_web = $_SERVER['REQUEST_SCHEME']."://".$_SERVER['SERVER_NAME'].$port.$url_data."/";

$MapPath = "/$campos_url[1]/";

 ?>
