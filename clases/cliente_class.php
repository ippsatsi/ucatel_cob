<?php

require_once "db.php";

class Cliente extends DB
{

  public function getDatosCuenta($cuenta)
  {
      $query = "EXEC COBRANZA.SP_INFORMACION_CUENTA :cuenta";
      $parametros = array("cuenta" => $cuenta);
      $datos_cuenta = $this->run_query_wParam($query, $parametros);
      $result = array("d"=>[]);
      $array_result = array();
      while ( $fila = $datos_cuenta->fetch(PDO::FETCH_ASSOC) ) :
          array_push($array_result, $fila);
      endwhile;
      $result['d'] = $array_result;
      return $result;
  }
}

 ?>
