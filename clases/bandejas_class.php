<?php

require_once "db.php";

class Bandejas extends DB
{

    public function getProveedores()
    {
        $query = "EXEC COBRANZA.SP_CARGAR_PROVEEDORES";
        $proveedores = $this->connect()->query($query);

        $result = array("d"=>[]);
        while ( $fila = $proveedores->fetch() ) :
            array_push($result['d'], array("key"=>$fila[0],"value"=>$fila[1]));
        endwhile;
        return $result;
    }

}


 ?>
