<?php

require_once "db.php";

class Telefono extends DB
{

  public function eliminaTelefono($tel_codigo, $usu_codigo)
  {
      $query = "EXEC COBRANZA.SP_TELEFONO_ELIMINA :tel_codigo , :usu_codigo";
      $parametros = array("tel_codigo" => $tel_codigo, "usu_codigo" => $usu_codigo);
      $telef_desactivado = $this->run_query_wParam($query, $parametros);
      $resultado = $telef_desactivado->rowCount();
      $result = array("d" => 0);
      if ( $resultado > 0 ) :
          $result = array('d' => $resultado);
      endif;
      return $result;
  }//endfunction

  public function getDatosTelfById($tel_codigo)
  {
      $query = "EXEC COBRANZA.SP_OBTENER_TELEFONO_ID :tel_codigo";
      $datos_telefono = $this->run_query_wParam($query, array("tel_codigo" => $tel_codigo));
      $result = array('d' => 0);
      $result['d'] = $datos_telefono->fetch(PDO::FETCH_ASSOC);
      return $result;
  }//endfunction

  public function registraTelefono($obj_parametros)
  {
      $query = "EXEC COBRANZA.SP_REGISTRAR_TELEFONO
                  :TEL_CODIGO,
                  :TEL_NUMERO,
                  :TEL_ESTADO_VALIDEZ,
                  :USU_CODIGO,
                  :CLI_CODIGO,
                  :TOR_CODIGO,
                  :TEL_ESTADO_TELEFONO,
                  :TEL_ANEXO,
                  :PRV_CODIGO,
                  :TEL_OBSERVACIONES";

      $upd_telefono = $this->run_query_update_wParam($query, $obj_parametros);
      $result = array("d" => 0);
      //$result['d'] = $upd_telefono->fetch(PDO::FETCH_NUM);
      $result['d'] = $upd_telefono->rowCount();
      // $result['otro'] = $resultado;
      // if ( $resultado > 0 ) :
      //     $result['upd'] = $resultado;
      // endif;
      return $result;
      // @TEL_CODIGO INT OUTPUT,
// @TEL_NUMERO VARCHAR(15),
// @TEL_ESTADO_VALIDEZ CHAR(2),
// @TEL_USUARIO_REGISTRO INT,
// @CLI_CODIGO INT,
// @TOR_CODIGO INT,
// @TEL_ESTADO_TELEFONO CHAR(1),
// @TEL_ANEXO VARCHAR(10),
// @PRV_CODIGO INT,
// @TEL_OBSERVACIONES VARCHAR(300)

      // objTelefono.TEL_CODIGO = $("#txtCodigo").val();
      // objTelefono.TEL_NUMERO = $("#txtTelefono").val();
      // objTelefono.TEL_ESTADO_VALIDEZ = $("#txtValido").val();
      // objTelefono.CLI_CODIGO = $("#txtCodigoCliente").val();
      // objTelefono.TOR_CODIGO = $("#sltOrigen").val();
      // objTelefono.TEL_ESTADO_TELEFONO = $("#sltEstado").val();
      // objTelefono.TEL_ANEXO = $("#txtAnexo").val();
      // objTelefono.TEL_OBSERVACIONES = $("#txtObservacion").val();
      // objTelefono.PRV_CODIGO = $("#txtCodigoProveedor").val();
  }//endfunction

  public function getStatusTelefono()
  {
      $query = "
      SELECT
          TST.TES_DESCRIPCION AS 'key'
          , TST.TES_ABREVIATURA as 'value'
          FROM
          COBRANZA.GCC_TELEFONO_STATUS TST
          WHERE
          TST.TES_ESTADO='A'";

      $resultado = $this->run_query($query);
      $result = array("d" => 0);
      $array_filas = array();
      $result['d'] = $resultado->fetchall(PDO::FETCH_ASSOC);

      return $result;
  }//endfunction

  public function getListaOrigen()
  {
      $query = "
      SELECT
          TOR.TOR_DESCRIPCION AS 'key'
          , TOR.TOR_CODIGO as 'value'
          FROM
          COBRANZA.GCC_TIPO_ORIGEN TOR
          WHERE
          TOR.TOR_ESTADO_REGISTRO='A'";

      $resultado = $this->run_query($query);
      $result = array("d" => 0);
      $array_filas = array();
      $result['d'] = $resultado->fetchall(PDO::FETCH_ASSOC);

      return $result;
  }//endfunction

  public function getResultadosBusqueda($array_parametros)
  {
      $query = "EXEC COBRANZA.SP_BUSCAR_POR_TELEFONO :tipo, :numero";
      //eliminamos el ultimo paramentro que es CONSULTA_AJAX
      array_pop($array_parametros);
      $datos_telefono = $this->run_query_wParam($query, $array_parametros);
      $result = array("d" => 0);
      while ( $fila = $datos_telefono->fetch(PDO::FETCH_ASSOC) ) :
          $array_result[] = $fila;
      endwhile;
      $result['d'] = $array_result;
      return $result;
  }//endfunction

}


 ?>
