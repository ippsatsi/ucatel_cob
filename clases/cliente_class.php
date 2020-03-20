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

  public function getListaRespuestaTipoGestion($array_param)
  {
      $query = "
          SELECT
              TRES.TIR_DESCRIPCION
              , TRES.TIR_CODIGO
              , ISNULL(TAB.IMP_NEGOCIADO,0)
              , ISNULL(TAB.FECHA,0)
              , ISNULL(TAB.MONTO,0)
              , ISNULL(TAB.REPROGRAMACION,0)
              , ISNULL(TAB.RECIBO,0)
              , ISNULL(TAB.CUOTAS,0)
              , ISNULL(TAB.INICIAL,0)
              , ISNULL(TAB.SALDO,0)
              , ISNULL(TAB.RANGO_CUOTAS,0)
              FROM
              COBRANZA.GCC_TGEST_TRESU TRE
              INNER JOIN COBRANZA.GCC_TIPO_RESULTADO TRES ON TRE.TIR_CODIGO=TRES.TIR_CODIGO
              LEFT JOIN COBRANZA.GCC_TIPO_RESULTADO_TAB TAB ON TAB.TAB_CODIGO=TRES.TIR_CODIGO
              WHERE
              TRE.SCA_CODIGO = :sca_codigo
              AND TRE.TIG_CODIGO = :codigo
              AND TRE.TGR_ESTADO_REGISTRO='A'";

      $resultado = $this->run_query_wParam($query, $array_param);
      $tipo_resultado = array();
      while ( $fila = $resultado->fetch(PDO::FETCH_NUM) ) :
          //generamos este tipo de array
          //{"d":[{"key":"FRACCIONADO O ARMADAS","value":"163-0-0-0-0-0-0-0-0-0"},
          $key = array_shift($fila);
          $tipo_resultado[] = ["key" => $key , "value" => implode('-', $fila)];
      endwhile;

      $result = array("d" => $tipo_resultado);
      return $result;
  }//endfunction

  public function getlistarSolucionPorTipoRespuesta($array_param)
  {
      $query = "
          SELECT
          TRES.TIR_DESCRIPCION
          , TRES.TIR_CODIGO
          , ISNULL(TAB.IMP_NEGOCIADO,0)
          , ISNULL(TAB.FECHA,0)
          , ISNULL(TAB.MONTO,0)
          , ISNULL(TAB.REPROGRAMACION,0)
          , ISNULL(TAB.RECIBO,0)
          , ISNULL(TAB.CUOTAS,0)
          , ISNULL(TAB.INICIAL,0)
          , ISNULL(TAB.SALDO,0)
          , ISNULL(TAB.RANGO_CUOTAS,0)
          FROM COBRANZA.GCC_TIPO_RESULTADO TRES
          LEFT JOIN COBRANZA.GCC_TIPO_RESULTADO_TAB TAB ON TAB.TAB_CODIGO=TRES.TIR_CODIGO
          WHERE
          TRES.TIR_PADRE = :codigo
          AND TRES.TIR_ESTADO_REGISTRO='A'";

      $resultado = $this->run_query_wParam($query, $array_param);
      $tipo_resultado = array();
      while ( $fila = $resultado->fetch(PDO::FETCH_NUM) ) :
          //generamos este tipo de array
          //{"d":[{"key":"FRACCIONADO O ARMADAS","value":"163-0-0-0-0-0-0-0-0-0"},
          $key = array_shift($fila);
          $tipo_resultado[] = ["key" => $key , "value" => implode('-', $fila)];
      endwhile;

      $result = array("d" => $tipo_resultado);
      return $result;
  }//endfunction
  //SP_TIENE_CONVENIO
  public function getTieneConvenio($array_param)
  {
      $query = "EXEC COBRANZA.SP_TIENE_CONVENIO :CUE_CODIGO";
      $datos_cronograma = $this->run_query_wParam($query, $array_param);
      $num_filas = $datos_cronograma->rowCount();
      $result['d'] = $datos_cronograma->fetch(PDO::FETCH_ASSOC);
      return $result;
  }//endfunction

  public function setRegistrarGestion($array_param)
  {
      $query = "EXEC COBRANZA.SP_REGISTRAR_GESTION
                  :TIR_CODIGO,
                  :SOL_CODIGO,
                  0,
                  :TEL_CODIGO,
                  :GES_OBSERVACIONES,
                  :CUE_CODIGO,
                  :CAR_CODIGO,
                  :SCA_CODIGO,
                  :DIR_CODIGO,
                  0,
                  :USU_CODIGO,
                  :TIG_CODIGO,
                  :GES_FECHA_INICIAL,
                  :GES_IMPORTE_INICIAL,
                  0,
                  :GES_NRO_CUOTAS,
                  :GES_IMPORTE_NEGOCIACION,
                  :GES_SALDO_NEGOCIACION,
                  :GES_VALOR_CUOTA,
                  :REC_NUMERO,
                  :REC_AGENCIA,
                  :REC_MONTO,
                  :REC_FECHA";
      $datos_reg_gestion = $this->run_query_wParam($query, $array_param);
      //iteramos sobre todos los resultados del procedimiento hasta llegar al
      //ultimo, no sabemos eq que rowset estara el resultado, porque el numero de
      //rowset varia segun los parametros del procedimiento
      while ( $datos_reg_gestion->nextRowset() ) :
          try {
              $cod_gestion = $datos_reg_gestion->fetch(PDO::FETCH_NUM);
              $result['msg'][] = $cod_gestion;
          } catch (\Exception $e) {
              $result['msg'][] = "sin resultados";
          }
      endwhile;
      $result['d'] = $cod_gestion[0];
      return $result;
//       @TIPORESPUESTA INT,
// @SOL_CODIGO INT,
// @TDE_CODIGO INT,
// @CODIGOTELEFONO INT,
// @OBSERVACIONES varchar(500),
// @CUENTACLI int,
// @CARCODIGO int,
// @SCACODIGO int,
// @CODDIREC int,
// @TIPOLLAMADA int,
// @GES_USUARIO_REGISTRO int,--afac
// @TIG_CODIGO int,
// @GES_FECHA_INICIAL varchar(10),
// @GES_IMPORTE_INICIAL decimal(10,2),
// @TPA_CODIGO int,
// @GES_NRO_CUOTAS int,
// @GES_IMPORTE_NEGOCIACION decimal(10,2),
// @GES_SALDO_NEGOCIACION decimal(10,2),
// @GES_VALOR_CUOTA decimal(10,2),
// @REC_NUMERO VARCHAR(15),
// @REC_AGENCIA VARCHAR(10),
// @REC_MONTO DECIMAL(10,2),
// @REC_FECHA VARCHAR(10)
// {"objGestion":
//     {"FLG_ELIMINAR_CRONOGRAMA":false,
//     "ObjCuenta":
//         {"CUE_CODIGO":"2070"},
//     "ObjTipoResultado":
//         {"TIR_CODIGO":"408",
//         "SOL_CODIGO":"412"},
//      "ObjTelefono":
//         {"TEL_CODIGO":"52003"},
//      "GES_OBSERVACIONES":"TITULAR / VOLVER A LLAMAR",
//      "ObjCartera":
//         {"CAR_CODIGO":"2"},
//      "ObjSubCartera":
//         {"SCA_CODIGO":"4"},
//      "ObjDireccion":
//         {"DIR_CODIGO":"00"},
//       "ObjTipoGestion":
//         {"TIG_CODIGO":"5"},
//       "GES_FECHA_INICIAL":"",
//       "GES_IMPORTE_INICIAL":"0",
//       "ObjTipoPago":  {},
//     "GES_NRO_CUOTAS":"0",
//     "GES_IMPORTE_NEGOCIACION":"0",
//     "GES_SALDO_NEGOCIACION":"0",
//     "GES_VALOR_CUOTA":"0",
//     "REC_NUMERO":"",
//     "REC_AGENCIA":"",
//     "REC_MONTO":"0",
//     "REC_FECHA":""},
//     "CONSULTA_AJAX":"registrarGestion"}
  }//endfunction

  public function setRegistrarTareaRecordatorio($array_param)
  {
      $query = "EXEC COBRANZA.SP_REGISTRAR_RECORDATORIO
                      :GES_CODIGO,
                      :REC_FECHA,
                      :REC_HORA,
                      :REC_OBSERVACIONES,
                      :TIR_CODIGO,
                      :CLI_CODIGO,
                      :REC_USUARIO";

      $tarea = $this->run_query_wParam($query, $array_param);
      $tarea->nextRowset();
    //  $tarea->nextRowset();
       $cod_tarea = $tarea->fetch(PDO::FETCH_NUM);
       $result['d'] = $cod_tarea[0];
      return $result;
      // @GES_CODIGO INT,
      // @REC_FECHA VARCHAR(10),
      // @REC_HORA CHAR(12),
      // @REC_OBSERVACIONES VARCHAR(300),
      // @TIR_CODIGO INT,
      // @CLI_CODIGO INT,
      // @REC_USUARIO INT
  }//endfunction

  public function setRegistraCronograma($array_param)
  {
      $query = "EXEC COBRANZA.SP_REGISTRAR_CRONOGRAMA
                    :CUE_CODIGO,
                    :GES_CODIGO,
                    :NRO_CUOTA,
                    :FEC_VENCIMIENTO,
                    :IMP_CUOTA,
                    :USU_CODIGO";

      $insert_cronograma = $this->run_query_wParam($query, $array_param);
      //para valorar las inserciones usamos rowCount
      $result['d'] = $insert_cronograma->rowCount();
  /*    while ( $insert_cronograma->nextRowset() ) :
          try {
              $cod_gestion = $insert_cronograma->fetch(PDO::FETCH_NUM);
              $result['msg'][] = $cod_gestion;
          } catch (\Exception $e) {
              $result['msg'][] = "sin resultados_cro";
          }
      endwhile;
      $result['d'] = $cod_gestion;*/
      return $result;
      // @CUE_CODIGO bigint
      // ,@GES_CODIGO bigint
      // ,@NRO_CUOTA smallint
      // ,@FEC_VENCIMIENTO varchar(10)
      // ,@IMP_CUOTA decimal(12,2)
      // ,@CRO_USUARIO_REGISTRO int
  }//endfunction

  public function setCuentaTieneConvenio($array_param)
  {
      $query = "EXEC COBRANZA.SP_CUENTA_TIENE_CONVENIO
                      :CUE_CODIGO,
                      :CUE_CONVENIO_CUOTAS,
                      :GES_IMPORTE_INICIAL,
                      :GES_FECHA_INICIAL";
      $tiene_convenio = $this->run_query_update_wParam($query, $array_param);
      $result['d'] = $tiene_convenio->rowCount();
      return $result;
    // CREATE PROCEDURE [COBRANZA].[SP_CUENTA_TIENE_CONVENIO]
    // @CUE_CODIGO INT,
    // @CUE_CONVENIO_CUOTAS INT,
    // @GES_IMPORTE_INICIAL DECIMAL(10,2),
    // @GES_FECHA_INICIAL VARCHAR(10)
  }//endfunction

  public function setEliminarCronograma($array_param)
  {//usado para eliminar cronogramas cuando otro cronograma lo reemplazara
      $query = "EXEC COBRANZA.SP_ELIMINAR_CRONOGRAMA
                      :CUE_CODIGO,
                      :CRO_USUARIO_MODIFICA,
                      :TXT_MOTIVO_CONVENIO";
      $elimina_cronograma = $this->run_query_update_wParam($query, $array_param);
      $result['d'] = $elimina_cronograma->rowCount();
      return $result;
  }//endfunction

  public function setDesactivarCronograma($array_param)
  {//usado en la bandeja de convenios
      $query = "EXEC COBRANZA.SP_INACTIVAR_CONVENIO
                      :id_cuenta,
                      :txt_motivo,
                      :USU_CODIGO";
      $desactiva_cronograma = $this->run_query_update_wParam($query, $array_param);
      $result['d'] = $desactiva_cronograma->rowCount();
      return $result;
  }//endfunction
}

 ?>
