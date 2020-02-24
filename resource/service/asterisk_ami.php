<?php

$data = json_decode(file_get_contents("php://input"),true);

if ( is_array($data) ) :

    require_once "url_relativa.php";
    require_once $url_relativa."clases/db.php";
    require_once $url_relativa."clases/asterisk_call_class.php";

    if ( isset($data['objTelefono']) ) :
        $array_llamada = $data['objTelefono'];
        //($troncal, $contexto, $numero_a_marcar, $anexo_llamante)
        // objTelefono.TEL_NUMERO = telefono;
        // objTelefono.TRONCAL = $("#txtTroncal").val();
        // objTelefono.CONTEXTO = $("#txtContextoSip").val();
        // objTelefono.CALLERID = '00000' + $("#txtAnexo").val();

        $db_sever = new DB();
        $query = "
            SELECT
                ARC.AMI_HOSTNAME
                , ARC.AMI_USERNAME
                , ARC.AMI_PASSWORD
                , ARC.AMI_PORT
                , ARC.TRO_PREFIJO
                FROM
                ASTERISK.CONEXION ARC
                WHERE
                ARC.FG_ESTADO = 1";

        $datos_consulta = $db_sever->run_query($query);

        $datos_ami_server = $datos_consulta->fetch(PDO::FETCH_ASSOC);

        //colocamos el prefijo de movil a los numeros q emiezan con 9 tienen 9 digitos
        $prefijo_moviles = $datos_ami_server['TRO_PREFIJO'];
        if ( substr($array_llamada['TEL_NUMERO'],1,1) == '9' && strlen($array_llamada['TEL_NUMERO']) == 9  ) :
            $numero_a_marcar = $prefijo_moviles.$array_llamada['TEL_NUMERO'];
        else:
            $numero_a_marcar = $array_llamada['TEL_NUMERO'];
        endif;

        $llamada = new AMI( $datos_ami_server['AMI_HOSTNAME'],
                            $datos_ami_server['AMI_USERNAME'],
                            $datos_ami_server['AMI_PASSWORD'],
                            $datos_ami_server['AMI_PORT']);

        $result = $llamada->OriginarLlamada($array_llamada['TRONCAL'],
                                            $array_llamada['CONTEXTO'],
                                            $numero_a_marcar,
                                            $array_llamada['CALLERID']);

        header("Content-Type: application/json; charset=UTF-8");
        echo json_encode($result);
        return;
      //  var_dump($data['objTelefono']);
    endif;
endif;

 ?>
