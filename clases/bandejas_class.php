<?php

require_once "db.php";

class Bandejas extends DB
{

    public function getProveedores()
    {
        $query = "EXEC COBRANZA.SP_CARGAR_PROVEEDORES";
        $proveedores = $this->connect()->query($query);

        $result = array("d"=>[]);
        $array_result = array();
        while ( $fila = $proveedores->fetch() ) :
            array_push($array_result, array("key"=>$fila[1],"value"=>$fila[0]));
        endwhile;
        $result['d'] = $array_result;
        return $result;
    }

    public function getCarteras($proveedor)
    {
      $query = "EXEC COBRANZA.SP_CARGAR_CARTERAS ?";
      $prv_codigo = array($proveedor);/*
      $carteras = $this->connect()->prepare($query,
      array(PDO::ATTR_CURSOR                      => PDO::CURSOR_SCROLL,
            PDO::SQLSRV_ATTR_CURSOR_SCROLL_TYPE   => PDO::SQLSRV_CURSOR_BUFFERED));
      $carteras->execute($prv_codigo);
*/
      $carteras = $this->run_query_wParam($query, $prv_codigo);
      $result = array("d"=>[]);
      $carteras_result = array();
      if ( $carteras->rowCount() > 0 ) :
          while ( $fila = $carteras->fetch() ) :
              array_push($carteras_result, array("key"=>$fila[1],"value"=>$fila[0]));
          endwhile;
      endif;
      $result['d'] = $carteras_result;
      return $result;
    }

    public function getSubCarteras($cartera)
    {
      $query = "EXEC COBRANZA.SP_CARGAR_SUBCARTERAS ?";
      $car_codigo = array($cartera);

      $subcarteras = $this->run_query_wParam($query, $car_codigo);
      $result = array("d"=>[]);
      $subcarteras_result = array();
      if ( $subcarteras->rowCount() > 0 ) :
          while ( $fila = $subcarteras->fetch() ) :
              array_push($subcarteras_result, array("key"=>$fila[1],"value"=>$fila[0]));
          endwhile;
      endif;
      $result['d'] = $subcarteras_result;
      return $result;
    }

    public function getUsuariosCall()
    {
        $query = "EXEC COBRANZA.SP_LISTAR_USUARIOS_CALL";
        $proveedores = $this->connect()->query($query);

        $result = array("d"=>[]);
        $array_result = array();
        while ( $fila = $proveedores->fetch() ) :
            array_push($array_result, array("key"=>$fila[1],"value"=>$fila[0]));
        endwhile;
        $result['d'] = $array_result;
        return $result;
    }

    public function getBandejaSupervisor($array_params, $start, $pag_size)
    {
        $query = "EXEC COBRANZA.SP_CARGAR_BANDEJA_SUPERVISOR :rol, :usuario, :cuenta, :periodo, :dni, :nombres, :prv,:car,:sca,:ubi_codigo,:agente,:filtro,:desde,:hasta,:fcd,:fci,:fnc,:fsg";
        //"EXEC COBRANZA.SP_CARGAR_BANDEJA_SUPERVISOR 3, 3052, '', 9, '', '', 2,2,4,'',0,'T','','',0,0,0,0
        $bandeja_super = $this->run_big_query_wParam($query, $array_params);
        $result = array("d"=>[]);
        $aaData = array();
        $count_filas = $start;
        $end = $start + $pag_size;//50
        $fetch_cursor_orientation = PDO::FETCH_ORI_ABS;
            while ( ($fila = $bandeja_super->fetch( PDO::FETCH_ASSOC,$fetch_cursor_orientation, $count_filas)) && ($count_filas < $end)  ) :
                $fetch_cursor_orientation = PDO::FETCH_ORI_NEXT;
                $nombre_cliente = str_replace(" ","&nbsp;", $fila['CLIENTE'] );
                $array_fila = array(
                  "<span class='color_verde'></span>  <a onclick='abrir_gestion_cuenta(\"${fila['CUE_NROCUENTA']}\",${fila['FL_PAGO']},${fila['FL_COMPROMISO']},\"${fila['BAD_ESTADO_CUENTA']}\");'>${fila['CUE_NROCUENTA']}</a>"
                  , (string)$fila['PERIODO']
                  , $fila['PROVEEDOR']
                  , $fila['CAR_DESCRIPCION']
                  , $fila['SCA_DESCRIPCION']
                  , $fila['CLI_DOCUMENTO_IDENTIDAD']
                  , "<a onclick='historial(\"${fila['CUE_NROCUENTA']}\");'>$nombre_cliente</a>"
                  , $fila['CUE_ULTIMO_CONT']
                  , $fila['FEC_MEJOR_CONT']
                  , $fila['CLI_DISTRITO']
                  , $fila['TIPO_MONEDA']
                  , (float)$fila['CAPITAL']
                  , (float)$fila['SALDO']
                  , $fila['ULTIMA_GESTION']
                  , $fila['BAD_DIAS_MORA']
                  , (int)$fila['DIAS']
                  , (int)$fila['CANT_TOTAL']
                  , $fila['SEM_COLOR']
                  , $fila['BAD_ESTADO_CUENTA']
                );
                array_push($aaData, $array_fila);
                $count_filas++;
            endwhile;
        //cabeceras de la query
        // CLI_DOCUMENTO_IDENTIDAD
        // CLIENTE
        // PROVEEDOR
        // CLI_DISTRITO
        // CAR_DESCRIPCION
        // SCA_DESCRIPCION
        // CUE_NROCUENTA
        // ULTIMA_GESTION
        // DIAS
        // CANT_TOTAL
        // TIPO_MONEDA
        // CAPITAL
        // SALDO
        // SEM_COLOR
        // SEM_ORDEN
        // CUE_ULTIMO_CONT
        // FEC_MEJOR_CONT
        // BAD_DIAS_MORA
        // FG_NUEVO_TELEFONO
        // FL_PAGO
        // FL_COMPROMISO
        // BAD_ESTADO_CUENTA
        // PERIODO
        unset($bandeja_super);
        $result['d']['aaData'] = $aaData;
        return $result;
    }//endfunction

    public function getBandejaPrincipal($array_params, $start, $pag_size)
    {
        $query = "EXEC COBRANZA.SP_CARGAR_GRIV_CLIENTES :rol, :usuario, :cuenta, :dni, :nombres, :filtro,:desde,:hasta,:fcd,:fci,:fnc,:fsg";
//         @rolCodigo INT,
// @idUsuario INT,
// @CUE_NROCUENTA VARCHAR(30),
// @CLI_DOCUMENTO_IDENTIDAD VARCHAR(12),
// @CLIENTE VARCHAR(30),
// @TODOS CHAR(1),
// @DESDE VARCHAR(10),
// @HASTA VARCHAR(10),
// @FIL_CD BIT,
// @FIL_CI BIT,
// @FIL_NC BIT,
// @FIL_SG BIT
        $bandeja_super = $this->run_big_query_wParam($query, $array_params);
        $result = array("d"=>[]);
        $aaData = array();
        $count_filas = (int) $start;
        $end = $start + $pag_size;//50
        $fetch_cursor_orientation = PDO::FETCH_ORI_ABS;
            while ( ($fila = $bandeja_super->fetch( PDO::FETCH_ASSOC,$fetch_cursor_orientation, $count_filas)) && ($count_filas < $end)  ) :
                $fetch_cursor_orientation = PDO::FETCH_ORI_NEXT;
                $nombre_cliente = str_replace(" ","&nbsp;", $fila['CLIENTE'] );
                $array_fila = array(
                  "<span class='color_verde'></span>  <a onclick='abrir_gestion_cuenta(\"${fila['CUE_NROCUENTA']}\",${fila['FL_PAGO']},${fila['FL_COMPROMISO']},\"${fila['BAD_ESTADO_CUENTA']}\");'>${fila['CUE_NROCUENTA']}</a>"
                  , (string)$fila['PERIODO']
                  , $fila['PROVEEDOR']
                  , $fila['CAR_DESCRIPCION']
                  , $fila['SCA_DESCRIPCION']
                  , $fila['CLI_DOCUMENTO_IDENTIDAD']
                  , "<a onclick='historial(\"${fila['CUE_NROCUENTA']}\");'>$nombre_cliente</a>"
                  , $fila['CUE_ULTIMO_CONT']
                  , $fila['FEC_MEJOR_CONT']
                  , $fila['CLI_DISTRITO']
                  , $fila['TIPO_MONEDA']
                  , (float)$fila['CAPITAL']
                  , (float)$fila['SALDO']
                  , $fila['ULTIMA_GESTION']
                  , $fila['BAD_DIAS_MORA']
                  , (int)$fila['DIAS']
                  , (int)$fila['CANT_TOTAL']
                  , $fila['SEM_COLOR']
                  , $fila['BAD_ESTADO_CUENTA']
                );
                array_push($aaData, $array_fila);
                $count_filas++;
            endwhile;
        //cabeceras de la query
        // CLI_DOCUMENTO_IDENTIDAD
        // CLIENTE
        // PROVEEDOR
        // CLI_DISTRITO
        // CAR_DESCRIPCION
        // SCA_DESCRIPCION
        // CUE_NROCUENTA
        // ULTIMA_GESTION
        // DIAS
        // CANT_TOTAL
        // TIPO_MONEDA
        // CAPITAL
        // SALDO
        // SEM_COLOR
        // SEM_ORDEN
        // CUE_ULTIMO_CONT
        // FEC_MEJOR_CONT
        // BAD_DIAS_MORA
        // FG_NUEVO_TELEFONO
        // FL_PAGO
        // FL_COMPROMISO
        // BAD_ESTADO_CUENTA
        // PERIODO
        unset($bandeja_super);
        $result['d']['aaData'] = $aaData;
        return $result;
    }//endfunction

    public function getBandejaConvenios($parametros)
    {
        $query = "EXEC COBRANZA.SP_BANDEJA_CONVENIOS :cuenta, :dni, :nombre, :tipo_fecha, :desde, :hasta, :estado";//"'', '', '', 0, '14/02/2020', '14/02/2020', 1";

        $bandeja_convenios = $this->run_query_wParam($query, $parametros);
        $result = array("d"=>[]);
        $array_result = array();
        while ( $fila = $bandeja_convenios->fetch(PDO::FETCH_ASSOC) ) :
            array_push($array_result, $fila);
        endwhile;

        $result['d'] = $array_result;
        return $result;
    }//endfunction

    public function getBandejaCompromisoSemanal($parametros)
    {
        $query = "EXEC COBRANZA.SP_COMPROMISO_SEMANAL :usu_codigo, :dni, :desde, :hasta, :tipo";//"'', '', '', 0, '14/02/2020', '14/02/2020', 1";

        $bandeja_convenios = $this->run_query_wParam($query, $parametros);
        $result = array("d"=>[]);
        $array_result = array();
        while ( $fila = $bandeja_convenios->fetch(PDO::FETCH_ASSOC) ) :
            array_push($array_result, $fila);
        endwhile;

        $result['d'] = $array_result;
        return $result;
    }//endfunction

    public function getBandejaRecordatorios($parametros)
    {
        $query = "EXEC COBRANZA.SP_OBTENER_RECORDATORIO :usu_codigo";//"'', '', '', 0, '14/02/2020', '14/02/2020', 1";

        $bandeja_recordatorios = $this->run_query_wParam($query, $parametros);
        $result = array("d"=>[]);
        $array_result = array();
        while ( $fila = $bandeja_recordatorios->fetch(PDO::FETCH_ASSOC) ) :
            array_push($array_result, $fila);
        endwhile;

        $result['d'] = $array_result;
        return $result;
    }//endfunction
    
    public function getBandejaReporteDiarioUsuario($parametros)
    {
        $query = "EXEC COBRANZA.SP_REPORTE_DIARIO_USUARIO :usu_codigo";//"'', '', '', 0, '14/02/2020', '14/02/2020', 1";

        $bandeja_reporteDiarioUsuario = $this->run_query_wParam($query, $parametros);
        $result = array("d"=>[]);
        $array_result = array();
        while ( $fila = $bandeja_reporteDiarioUsuario->fetch(PDO::FETCH_ASSOC) ) :
            array_push($array_result, $fila);
        endwhile;

        $result['d'] = $array_result;
        return $result;
    }//endfunction

    public function getNotificador($parametros)
    {
        $query = "EXEC COBRANZA.SP_OBTENER_NOTIFICADOR :usu_codigo";//"'', '', '', 0, '14/02/2020', '14/02/2020', 1";

        $notificador = $this->run_query_wParam($query, $parametros);
        $result = array("d"=>[]);
        $array_result = array();
        while ( $fila = $notificador->fetch(PDO::FETCH_ASSOC) ) :
            array_push($array_result, $fila);
        endwhile;

        $result['d'] = $array_result;
        return $result;
    }//endfunction

    public function getResumenCarteras()
    {
        $query = "EXEC COBRANZA.SP_RESUMEN_CUENTAS_ACTIVAS";
        $resumenCarteras = $this->run_query($query);
        $result = array("d"=>[]);
        $array_result = array();
        while ( $fila = $resumenCarteras->fetch(PDO::FETCH_ASSOC) ) :
            array_push($array_result, $fila);
        endwhile;

        $result['d'] = $array_result;
        return $result;
    }//endfunction
    //reiniciar contactabilidad
    public function getPeriodosActivos()
    {
        $query = "EXEC COBRANZA.SP_LISTAR_PERIODOS_ACTIVOS";

        $periodosActivos = $this->run_query($query);
        $result = array("d"=>[]);
        $array_result = array();
        while ( $fila = $periodosActivos->fetch(PDO::FETCH_ASSOC) ) :
            array_push($array_result, $fila);
        endwhile;

        $result['d'] = $array_result;
        return $result;
    }//endfunction
    //reiniciar contactabilidad
    public function getPeriodosActuales()
    {
        $query = "EXEC COBRANZA.SP_LISTAR_PERIODOS_ACTUALES";
        $periodosActuales = $this->run_query($query);
        $result = array("d"=>[]);
        $array_result = array();
        while ( $fila = $periodosActuales->fetch(PDO::FETCH_ASSOC) ) :
            array_push($array_result, $fila);
        endwhile;

        $result['d'] = $array_result;
        return $result;
    }//endfunction
        //reiniciar contactabilidad
        public function setPeriodo($parametros)
        {
            $query = "EXEC COBRANZA.SP_REGISTRAR_PERIODO_SUBCARTERA :sca_codigo";
            $registrarPeriodo = $this->run_query_wParam($query, $parametros);

            $num_filas = $registrarPeriodo->rowCount();
            $result['d'] = array();
            if ( $num_filas > 0 ) :
                $result['d'] = "CORRECTO";
                return $result;
            endif;
            return $result;
        }//endfunction
            //reiniciar contactabilidad
    public function resetPeriodo($parametros)
    {
        $query = "EXEC COBRANZA.SP_RESETEAR_CUENTA_STATUS_MENSUAL :sca_codigo";
        $resetPeriodo = $this->run_query_wParam($query, $parametros);
        $num_filas = $resetPeriodo->rowCount();
        $result['d'] = array();
        if ( $num_filas > 0 ) :
            $result['d'] = "CORRECTO";
            return $result;
        endif;
        return $result;
    }//endfunction
    //Asignacion - Listar cuentas por Rol
    public function ListarAsignacionPorRol($parametros)
    {
        $query = "EXEC COBRANZA.SP_LISTAR_CUENTAS_ROL :rol_codigo";
        $resetPeriodo = $this->run_query_wParam($query, $parametros);
        $result = array("d"=>[]);
        $array_result = array();
        while ( $fila = $resetPeriodo->fetch(PDO::FETCH_ASSOC) ) :
            array_push($array_result, $fila);
        endwhile;

        $result['d'] = $array_result;
        return $result;
    }//endfunction
    //Bandeja Compromisos - Listar usuarios activos
    public function ListarUsuariosActivos()
    {
        $query = "EXEC COBRANZA.SP_LISTAR_USUARIOS_ACTIVOS";
        $usuariosActivos = $this->run_query($query);
        $result = array("d"=>[]);
        $array_result = array();
        while ( $fila = $usuariosActivos->fetch(PDO::FETCH_ASSOC) ) :
            array_push($array_result, $fila);
        endwhile;

        $result['d'] = $array_result;
        return $result;
    }//endfunction
    //Usuarios - Listar usuarios activos
    public function ListarUsuariosCriterio($parametros)
    {
        $query = "EXEC COBRANZA.SP_LISTAR_USUARIOS_CRITERIO :criterio, :texto";
        $listaUsuariosCriterio = $this->run_query_wParam($query, $parametros);
        $result = array("d"=>[]);
        $array_result = array();
        while ( $fila = $listaUsuariosCriterio->fetch(PDO::FETCH_ASSOC) ) :
            array_push($array_result, $fila);
        endwhile;

        $result['d'] = $array_result;
        return $result;
    }//endfunction
    //bandeja_compromisos
    public function getBandejaCompromisos($parametros)
    {
        $query = "EXEC COBRANZA.SP_REPORTE_COMPROMISOS 
                    :prv_codigo, 
                    :car_codigo, 
                    :sca_codigo, 
                    :usu_codigo, 
                    :nro_documento,
                    :fec_inicio,
                    :fec_fin,
                    :slt_tipo";

        $bandeja_compromisos = $this->run_query_wParam($query, $parametros);
        $result = array("d"=>[]);
        $array_result = array();
        while ( $fila = $bandeja_compromisos->fetch(PDO::FETCH_ASSOC) ) :
            array_push($array_result, $fila);
        endwhile;

        $result['d'] = $array_result;
        return $result;
    }//endfunction

    //carga carteras//migracion de cuentas
    public function getBandejaMigracionCuentas($parametros)
    {
        $query = "EXEC COBRANZA.SP_LISTAR_MIGRACIONES 
                    :nro_cuenta, 
                    :nro_documento,
                    :nombre_completo,
                    :fec_desde";

        $bandeja_migracion_cuentas = $this->run_query_wParam($query, $parametros);
        $result = array("d"=>[]);
        $array_result = array();
        while ( $fila = $bandeja_migracion_cuentas->fetch(PDO::FETCH_ASSOC) ) :
            array_push($array_result, $fila);
        endwhile;

        $result['d'] = $array_result;
        return $result;
    }//endfunction

    public function getBandejaGestiones($parametros)
    {
        $query = "EXEC COBRANZA.SP_REPORTE_ASIGNACION_GESTIONES 
                    :prv_codigo,
                    :car_codigo,
                    :sca_codigo,
                    :fecha_desde,
                    :fecha_hasta,
                    :tipo,
                    :progresivo,
                    :estado";

        $band_reporte_gestiones = $this->run_too_big_query_wParam($query, $parametros);
        $result = array("d"=>[]);
        $array_result = array();
        while ( $fila = $band_reporte_gestiones->fetch(PDO::FETCH_ASSOC) ) :
            array_push($array_result, $fila);
        endwhile;

        $result['d'] = $array_result;
        return $result;
    }//endfunction
}//endclass


 ?>
