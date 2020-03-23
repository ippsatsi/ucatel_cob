<?php

require_once "url_relativa.php";
require_once $url_relativa."valida_sesion.php";
require_once $url_relativa."clases/usuario_class.php";
require_once $url_relativa."clases/bandejas_class.php";

$user = new Usuario();
$user->setUserInfo();
$user->setUrlMaster($ruta_web);

if ( isset($_GET['CONSULTA_AJAX']) ) :
    if (  $_GET['CONSULTA_AJAX'] == 'BANDEJA_SUPERVISOR') :
        //:rol, :usuario, :cuenta, :periodo, :dni, :nombres, :prv,:car,:sca,:ubi_codigo,:agente,:filtro,:desde,:hasta,:fcd,:fci,:fnc,:fsg";
//         "NRO_CUENTA":"",
// "PERIODO":"1",
// "DNI":"",
// "CLIENTE":"",
// "PROVEEDOR":"2",
// "CARTERA":"2",
// "SUBCARTERA":"4",
// "UBIGEO":"",
// "USUARIO":"0",
// "FILTRO":"T",
// "FEC_DESDE":"",
// "FEC_HASTA":"",
// "FL_CD":"1",
// "FL_CI":"1",
// "FL_NC":"1",
// "FL_SG":"0"}}
        $parametros = array(
            ":rol" =>  $user->getUserRol(),
            ":usuario" =>  $user->getUserId(),
            ":cuenta" =>  $_GET['NRO_CUENTA'],
            ":periodo" =>  $_GET['PERIODO'],
            ":dni" =>  $_GET['DNI'],
            ":nombres" =>  $_GET['CLIENTE'],
            ":prv" =>  $_GET['PROVEEDOR'],
            ":car" =>  $_GET['CARTERA'],
            ":sca" =>  $_GET['SUBCARTERA'],
            ":ubi_codigo" =>  $_GET['UBIGEO'],
            ":agente" =>  $_GET['USUARIO'],
            ":filtro" =>  $_GET['FILTRO'],
            ":desde" =>  $_GET['FEC_DESDE'],
            ":hasta" =>  $_GET['FEC_HASTA'],
            ":fcd" =>  $_GET['FL_CD'],
            ":fci" =>  $_GET['FL_CI'],
            ":fnc" =>  $_GET['FL_NC'],
            ":fsg" =>  $_GET['FL_SG']
        );
        $bandeja = new Bandejas();
        $start = $_GET['iDisplayStart'];
        $pag_size = $_GET['iDisplayLength'];
        $resultado = $bandeja->getBandejaSupervisor($parametros, $start, $pag_size);
        //"iTotalDisplayRecords\":148,\"iTotalRecords\":148,\"recordsFiltered\":148,\"recordsTotal\":148,\"sEcho\":1}
        $resultado['d']['sEcho'] = $_GET['sEcho'];
        //si hay registros (clientes/cuentas) extraemos el total del primer registro
        if ( $totales = count($resultado['d']['aaData']) ) :
            $totales = $resultado['d']['aaData'][0][16];
        else:
            $totales = 0;
        endif;
        $resultado['d']['iTotalDisplayRecords'] = $totales;
        $resultado['d']['iTotalRecords'] = $totales;
        $resultado['d']['recordsFiltered'] = $totales;
        $resultado['d']['recordsTotal'] = $totales; //[["a", "b"],["c", "d"]];
        //var_dump($resultado);
        header('Content-Type: application/json; charset=UTF-8');
        //var_dump($resultado);
        //print_r($resultado);
        echo json_encode($resultado);
    endif;

    //BANDEJA_PRINCIPAL
    if (  $_GET['CONSULTA_AJAX'] == 'BANDEJA_PRINCIPAL') :
        //:rol, :usuario, :cuenta, :dni, :nombres, :filtro,:desde,:hasta,:fcd,:fci,:fnc,:fsg";
//         "NRO_CUENTA":"",

// "DNI":"",
// "CLIENTE":"",

// "FILTRO":"T",
// "FEC_DESDE":"",
// "FEC_HASTA":"",
// "FL_CD":"1",
// "FL_CI":"1",
// "FL_NC":"1",
// "FL_SG":"0"}}
        $parametros = array(
            ":rol" =>  $user->getUserRol(),
            ":usuario" =>  $user->getUserId(),
            ":cuenta" =>  $_GET['NRO_CUENTA'],
            ":dni" =>  $_GET['DNI'],
            ":nombres" =>  $_GET['CLIENTE'],
            ":filtro" =>  $_GET['FILTRO'],
            ":desde" =>  $_GET['FEC_DESDE'],
            ":hasta" =>  $_GET['FEC_HASTA'],
            ":fcd" =>  $_GET['FL_CD'],
            ":fci" =>  $_GET['FL_CI'],
            ":fnc" =>  $_GET['FL_NC'],
            ":fsg" =>  $_GET['FL_SG']
        );
        $bandeja = new Bandejas();
        $start = $_GET['iDisplayStart'];
        $pag_size = $_GET['iDisplayLength'];
        $resultado = $bandeja->getBandejaPrincipal($parametros, $start, $pag_size);
        //"iTotalDisplayRecords\":148,\"iTotalRecords\":148,\"recordsFiltered\":148,\"recordsTotal\":148,\"sEcho\":1}
        $resultado['d']['sEcho'] = $_GET['sEcho'];
        //si hay registros (clientes/cuentas) extraemos el total del primer registro
        if ( $totales = count($resultado['d']['aaData']) ) :
            $totales = $resultado['d']['aaData'][0][16];
        else:
            $totales = 0;
        endif;
        $resultado['d']['iTotalDisplayRecords'] = $totales;
        $resultado['d']['iTotalRecords'] = $totales;
        $resultado['d']['recordsFiltered'] = $totales;
        $resultado['d']['recordsTotal'] = $totales; //[["a", "b"],["c", "d"]];
        //var_dump($resultado);
        header('Content-Type: application/json; charset=UTF-8');
        //var_dump($resultado);
        //print_r($resultado);
        echo json_encode($resultado);
    endif;

    //BANDEJA CONVENIOS
    if ( $_GET['CONSULTA_AJAX'] == 'bandejaConvenios') :
        $data = json_decode(file_get_contents('php://input'), true);

        if (  is_array($data)) :
            $band_convenios = new Bandejas();
            $parametros_criterio = $data['criterio'];
            $parametros = array(
                ":cuenta" => $parametros_criterio['NroCuenta'],
                ":dni" => $parametros_criterio['Dni'],
                ":nombre" => $parametros_criterio['Cliente'],
                ":tipo_fecha" => $parametros_criterio['Todos'],
                ":desde" => $parametros_criterio['desde'],
                ":hasta" => $parametros_criterio['hasta'],
                ":estado" => $parametros_criterio['Estado']
            );
            //{"criterio":{"NroCuenta":"","Dni":"","Cliente":"","Todos":"0","desde":"14/02/2020","hasta":"14/02/2020","Estado":"1"}
            $resultado = $band_convenios->getBandejaConvenios($parametros);
            header('Content-Type: application/json; charset=UTF-8');
            //var_dump($resultado);
            //print_r($resultado);
            echo json_encode($resultado);
        endif;
    endif;

        //BANDEJA CONVENIOS
        if ( $_GET['CONSULTA_AJAX'] == 'obtenerCompromisoSemanal') :
            $data = json_decode(file_get_contents('php://input'), true);
    
            if (  is_array($data)) :
                $band_compromiso_semanal = new Bandejas();
                $parametros = array(
                    ":dni" => $data['dni'],
                    ":desde" => $data['fecha_desde'],
                    ":hasta" => $data['fecha_hasta'],
                    "usu_codigo" => $user->getUserId(),
                    "tipo" => $data['tipo']
                );
                
                $resultado = $band_compromiso_semanal->getBandejaCompromisoSemanal($parametros);
                header('Content-Type: application/json; charset=UTF-8');
                //var_dump($resultado);
                //print_r($resultado);
                echo json_encode($resultado);
            endif;
        endif;

endif;

exit;

 ?>
