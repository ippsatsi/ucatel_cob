<?php

require_once "db.php";

class Indicadores extends DB
{

public function indicadorSemanal($user)
{
  $query = "EXEC COBRANZA.SP_INDICADOR_SEMANAL ?";
  $array_user = array($user);
  $indSemanal = $this->connect()->prepare($query ,array(PDO::ATTR_CURSOR => PDO::CURSOR_SCROLL));
  $indSemanal->execute($array_user);

  if ( $indSemanal->rowCount() > 0 ) :
      while ( $fila = $indSemanal->fetch(PDO::FETCH_NUM) ) :
          //acortamos el array extrayendo la primera columna
          $tipo_contacto = array_shift($fila);
          //acortamos el array extrayendo la ultima columna
          $total = array_pop($fila);
          $datasets[] = array("name" => $tipo_contacto, "data" => $fila);
      endwhile;
      return json_encode($datasets);
  endif;

}
}

 ?>
