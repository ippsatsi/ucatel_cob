<?php

require_once "db.php";

/**
 *
 */
class Correo extends DB
{

  public function eliminarCorreo($cor_codigo, $usu_codigo)
  {
      $query = "EXEC COBRANZA.SP_CORREO_ELIMINA :codigo, :USU_CODIGO";
      $parametros = array("codigo" => $cor_codigo, "USU_CODIGO" => $usu_codigo );
      $elimina_correo = $this->run_query_update_wParam($query, $parametros);
      $result['d'] = $elimina_correo->rowCount();
      return $result;
  }//endfunction

  public function registraCorreo($array_param)
  {
      $query = "EXEC COBRANZA.SP_REGISTRAR_CORREO :COR_CODIGO, :CLI_CODIGO, :COR_CORREO_ELECTRONICO, :USU_CODIGO";
      // @COR_CODIGO INT OUTPUT,
      // @CLI_CODIGO INT,
      // @COR_CORREO_ELECTRONICO VARCHAR(120),
      // @COR_USUARIO_REGISTRO INT

      $registra_correo = $this->run_query_update_wParam($query, $array_param);
      $result['d'] = $registra_correo->rowCount();
      return $result;
  }//endfunction
}


 ?>
