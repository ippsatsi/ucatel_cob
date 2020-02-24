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
  }//endfunction

  public function getPagosCliente($cue_codigo)
  {
      $query = "EXEC COBRANZA.SP_OBTENER_PAGOS :cue_codigo";
      $parametros = array("cue_codigo" => $cue_codigo);
      $datos_pagos = $this->run_query_wParam($query, $parametros);
      $result = array("d"=>[]);
      $array_result = array();
      while ( $fila = $datos_pagos->fetch(PDO::FETCH_ASSOC) ) :
          array_push($array_result, $fila);
      endwhile;
      $result['d'] = $array_result;
      return $result;
  }//endfunction

  public function getTlfsCliente($cuenta)
  {
      $query = "EXEC COBRANZA.SP_LISTAR_TELEFONOS_CLIENTE :cuenta";
      $parametros = array("cuenta" => $cuenta);
      $datos_tlfs = $this->run_query_wParam($query, $parametros);
      $result = array("d"=>[]);
      $array_result = array();
      while ( $fila = $datos_tlfs->fetch(PDO::FETCH_ASSOC) ) :
          array_push($array_result, $fila);
      endwhile;
      $result['d'] = $array_result;
      return $result;
  }//endfunction

  public function getDirsCliente($cuenta)
  {
      $query = "EXEC COBRANZA.SP_LISTAR_DIRECCION_CLIENTE :cuenta";
      $parametros = array("cuenta" => $cuenta);
      $datos_tlfs = $this->run_query_wParam($query, $parametros);
      $result = array("d"=>[]);
      $array_result = array();
      while ( $fila = $datos_tlfs->fetch(PDO::FETCH_ASSOC) ) :
          array_push($array_result, $fila);
      endwhile;
      $result['d'] = $array_result;
      return $result;
  }//endfunction

  public function getCorreosCliente($dni)
  {
      $query = "EXEC COBRANZA.SP_LISTAR_CORREO_CLIENTE :dni";
      $parametros = array("dni" => $dni);
      $datos_correos = $this->run_query_wParam($query, $parametros);
      $result = array("d"=>[]);
      $array_result = array();
      while ( $fila = $datos_correos->fetch(PDO::FETCH_ASSOC) ) :
          array_push($array_result, $fila);
      endwhile;
      $result['d'] = $array_result;
      return $result;
  }//endfunction

  public function getCuentasCliente($cuenta)
  {
      $query = "EXEC COBRANZA.SP_OBTENER_CUENTAS :cuenta";
      $parametros = array("cuenta" => $cuenta);
      $datos_cuentas = $this->run_query_wParam($query, $parametros);
      $result = array("d"=>[]);
      $array_result = array();
      while ( $fila = $datos_cuentas->fetch(PDO::FETCH_ASSOC) ) :
          array_push($array_result, $fila);
      endwhile;
      $result['d'] = $array_result;
      return $result;
  }//endfunction

  public function getGestionesCliente($cue_codigo)
  {
      $query = "EXEC COBRANZA.SP_CARGAR_GRID_GESTIONES :cue_codigo";
      $parametros = array("cue_codigo" => $cue_codigo);
      $datos_gestiones = $this->run_query_wParam($query, $parametros);
      $result = array("d"=>[]);
      $array_result = array();
      while ( $fila = $datos_gestiones->fetch(PDO::FETCH_ASSOC) ) :
          array_push($array_result, $fila);
      endwhile;
      $result['d'] = $array_result;
      return $result;
  }//endfunction

  //funciones para obtener cuadros
  private function generarCuadroHtml($cabecera, $dato)
  {
      $cuadro_html  = "<div class='col-sm-2'>";
      $cuadro_html .= "   <div class='panel panel-default'>";
      $cuadro_html .= "       <div class='panel-heading'>";
      $cuadro_html .= "           <h3 class='panel-title'>$cabecera</h3>";
      $cuadro_html .= "       </div>";
      $cuadro_html .= "       <div class='panel-body'>";
      $cuadro_html .= "           <span>$dato</span>";
      $cuadro_html .= "       </div>";
      $cuadro_html .= "   </div>";
      $cuadro_html .= "</div>";

      return $cuadro_html;
  }

  public function getCuadrosCliente($cuenta)
  {
      //extraemos la info de BASEDET con los datos de los campos BAD_
      $query = "EXEC COBRANZA.SP_OBTENER_DATOS_CUENTA :cuenta";
      $parametros = array("cuenta" => $cuenta);
      $datos_BAD = $this->run_query_wParam($query, $parametros);
      $cue_datos = "";
      $array_campos_bad = array();
      $array_campos_bad = $datos_BAD->fetch(PDO::FETCH_ASSOC);
      if ( count($array_campos_bad) > 0 ) :
          //nos quedamos con las que empiecen con BAD
          unset($array_campos_bad['DIAS']);
          //extraemos los datos json de cue_datos, antes de borrarlos
          // y los convertimos a array
          $cue_datos = json_decode($array_campos_bad['DATOS'], true);
          unset($array_campos_bad['DATOS']);
      endif;

      //extraemos los cuadros activos de esa cuenta con sus nombres reales y a visualizar
      $query = "EXEC COBRANZA.SP_CUENTA_ORDEN :cuenta";
      $parametros = array("cuenta" => $cuenta);
      $datos_cuenta_orden = $this->run_query_wParam($query, $parametros);

      $cuadros_html = "";
      while ( $fila = $datos_cuenta_orden->fetch(PDO::FETCH_ASSOC) ) :
        //Evaluamos cada cuadro si es BAD y si esta activo
          if ( substr($fila['DESC_CAM_VC'], 0, 3) == 'BAD' ) :
              if ( $fila['TIPO_SI'] == 1 ) :

                  //HACEMOS EL CUADRO
                  //usamos DESC_CAM_VC como clave para extraer el dato del
                  //array_campos
                  $dato_cuadro = $array_campos_bad[$fila['DESC_CAM_VC']];
                  //extraemos la cabecera a visualizar
                  $cabecera_cuadro = $fila['COL_CAM_VC'];
                  $cuadros_html .= $this->generarCuadroHtml($cabecera_cuadro, $dato_cuadro);
              endif;
          else:
              if ( $fila['TIPO_SI'] == 2 ) :
                  //hacemos el cuadro
                  //usamos DESC_CAM_VC como clave para extraer el dato del
                  //CUE_DATOS,
                  $dato_cuadro = $cue_datos[$fila['DESC_CAM_VC']];
                  //extraemos la cabecera a visualizar
                  $cabecera_cuadro = $fila['COL_CAM_VC'];
                  $cuadros_html .= $this->generarCuadroHtml($cabecera_cuadro, $dato_cuadro);
              endif;
          endif;
      endwhile;
      return $cuadros_html;
  }//endfunction

  //funcion para obtener cronograma
  public function getCronogramaCliente($cue_codigo)
  {
      $query = "EXEC COBRANZA.SP_OBTENER_CRONOGRAMA :cue_codigo";
      $parametros = array("cue_codigo" => $cue_codigo);
      $datos_cronograma = $this->run_query_wParam($query, $parametros);
      $result = array("d"=>[]);
      $array_result = array();
      while ( $fila = $datos_cronograma->fetch(PDO::FETCH_ASSOC) ) :
          array_push($array_result, $fila);
      endwhile;
      $result['d'] = $array_result;
      return $result;
  }//endfunction
  //UpdateCronogramaCliente
  //funcion para obtener cronograma
  public function UpdateCronogramaCliente($cro_codigo, $pag_monto, $pag_fecha)
  {
      $query = "EXEC COBRANZA.SP_ACTUALIZAR_CRONOGRAMA :cro_codigo , :pag_monto , :pag_fecha";
      $parametros = array("cro_codigo" => $cro_codigo, "pag_monto" => $pag_monto, "pag_fecha" => $pag_fecha );
      $datos_cronograma = $this->run_query_wParam($query, $parametros);
      $num_filas = $datos_cronograma->rowCount();
      $result['d'] = array();
      if ( $num_filas > 0 ) :
          $result['d'] = "CORRECTO";
          return $result;
      endif;
      return $result;
  }//endfunction
}

 ?>
