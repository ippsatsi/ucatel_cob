<?php

require_once "db.php";


class Direccion extends DB
{

    public function eliminarDireccion($codigo, $usu_codigo)
    {
        $query = "EXEC COBRANZA.SP_DIRECCION_ELIMINA :codigo, :usu_codigo";
        $array_param = array("codigo" => $codigo, "usu_codigo" => $usu_codigo);
        $elimina_direccion = $this->run_query_update_wParam($query, $array_param);
        $result = array('d' => 0);
        $result['d'] = $elimina_direccion->rowCount();

        return $result;
    }//endfunction

    public function listarDistrito($array_param)
    {
      $query = "
          SELECT
          UBI.UBI_DISTRITO AS 'key'
          , UBI.UBI_CODIGO AS 'value'
          FROM
          COBRANZA.GCC_UBIGEO UBI
          WHERE
          UBI.UBI_CODIGO_DEPARTAMENTO= :UBI_CODIGO_DEPARTAMENTO
          AND UBI.UBI_CODIGO_PROVINCIA = :UBI_CODIGO_PROVINCIA
          AND UBI.UBI_DISTRITO <> '-'";

      $list_distrito = $this->run_query_wParam($query, $array_param);
      $result['d'] = $list_distrito->fetchall(PDO::FETCH_ASSOC);
      return $result;
    }//endfunction

    public function listarProvincia($array_param)
    {
      $query = "
          SELECT
          UBI.UBI_PROVINCIA AS 'key'
          , UBI.UBI_CODIGO_PROVINCIA AS 'value'
          FROM
          COBRANZA.GCC_UBIGEO UBI
          WHERE
          UBI.UBI_DISTRITO='-' AND
          UBI.UBI_CODIGO_DEPARTAMENTO= :UBI_CODIGO_DEPARTAMENTO
          AND UBI.UBI_PROVINCIA <> '-'";

      $list_prov = $this->run_query_wParam($query, $array_param);
      $result['d'] = $list_prov->fetchall(PDO::FETCH_ASSOC);
      return $result;
    }//endfunction

    public function listarDepartamento()
    {
        $query = "
            SELECT
            UBI.UBI_DEPARTAMENTO AS 'key'
            , UBI.UBI_CODIGO_DEPARTAMENTO AS 'value'
            FROM
            COBRANZA.GCC_UBIGEO UBI
            WHERE
            UBI.UBI_PROVINCIA='-' AND UBI.UBI_DISTRITO='-'";

        $list_dpto = $this->run_query($query);
        $result['d'] = $list_dpto->fetchall(PDO::FETCH_ASSOC);
        return $result;
    }//endfunction

    public function listaTipoDireccion()
    {
        $query = "
        SELECT
            TDI.TDI_DESCRIPCION AS'key'
            , TDI.TDI_CODIGO AS 'value'
            FROM
            COBRANZA.GCC_TIPO_DIRECCION TDI
            WHERE
            TDI.TDI_ESTADO_REGISTRO='A'";

        $tipo_dir = $this->run_query($query);
        $result['d'] = $tipo_dir->fetchall(PDO::FETCH_ASSOC);
        return $result;
    }//endfunction

    public function listarDireccionStatus()
    {
        $query = "
          SELECT
              DST.DIS_DESCRIPCION AS 'key'
              , DST.DIS_ABREVIATURA AS 'value'
              FROM
              COBRANZA.GCC_DIRECCION_STATUS DST
              WHERE
              DST.DIS_ESTADO='A'";

        $dir_status = $this->run_query($query);
        $result['d'] = $dir_status->fetchall(PDO::FETCH_ASSOC);
        return $result;
    }//endfunction

    public function registraDireccion($array_param)
    {
        $query = "EXEC COBRANZA.SP_REGISTRAR_DIRECCION
                      :DIR_CODIGO,
                      :DIR_DIRECCION,
                      :DIR_ESTADO_VALIDEZ,
                      :USU_CODIGO,
                      :PRV_CODIGO,
                      :CLI_CODIGO,
                      :TOR_CODIGO,
                      :UBI_DISTRITO,
                      :TDI_CODIGO ";
          // @DIR_DIRECCION VARCHAR(120),
          // @DIR_ESTADO_VALIDEZ CHAR(2),
          // @DIR_USUARIO_REGISTRO INT,
          // @PRV_CODIGO INT,
          // @CLI_CODIGO INT,
          // @TOR_CODIGO INT,
          // @UBI_CODIGO CHAR(6),
          // @TDI_CODIGO INT
        $registro_direccion = $this->run_query_update_wParam($query, $array_param);

        $result['d'] = $registro_direccion->rowCount();
        return $result;

    }//endfunction

    public function obtenerPorId($array_param)
    {
        $query = "EXEC COBRANZA.SP_OBTENER_DIRECCION_ID :codigo";

        $datos_direccion = $this->run_query_wParam($query, $array_param);
        $result['d'] = $datos_direccion->fetch(PDO::FETCH_ASSOC);
        return $result;
    }//endfunction
}

 ?>
