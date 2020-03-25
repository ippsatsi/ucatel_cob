<?php

require_once "db.php";

class Indicadores extends DB
{

public function indicadorSemanal($user)
{
  $query = "EXEC COBRANZA.SP_INDICADOR_SEMANAL ?";
  $array_user = array($user);
  $indSemanal = $this->run_query_wParam($query, $array_user);

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

}//endfunction

public function indicadorSemanalPorcentaje($user)
{
  $query = "EXEC COBRANZA.SP_INDICADOR_SEMANAL_PORCENTAJE ?";
  $array_user = array($user);
  $indSemanal = $this->run_query_wParam($query, $array_user);

  if ( $indSemanal->rowCount() > 0 ) :
      while ( $fila = $indSemanal->fetch(PDO::FETCH_NUM) ) :
          $datasets[] = array("name" => $fila[1], "y" => (float) $fila[4]);
      endwhile;
      return json_encode($datasets);
  endif;

}//endfunction

public function indicadorUsuarioDiario()
{
  $query = "EXEC COBRANZA.SP_INDICADOR_USUARIO_DIARIO";
 // $array_user = array($user);
 $query2 = "
 SELECT TAB.USU_LOGIN,
 SUM(CASE WHEN TAB.GSTION=1 THEN 1 ELSE 0 END) AS CONT_DIRECTO,
 SUM(CASE WHEN TAB.GSTION=2 THEN 1 ELSE 0 END) AS CONT_INDIRECTO,
--	SUM(CASE WHEN TAB.GSTION=3 THEN 1 ELSE 0 END) AS NO_CONTACTO,
 SUM(CASE WHEN TAB.GSTION>2 THEN 1 ELSE 0 END) AS NO_CONTACTO, ----inubicado 13.02.2018
 SUM(TAB.COMPROMISO) AS COMPROMISO
FROM (
 SELECT ROL.ROL_DESCRIPCION+': '+USU.USU_LOGIN AS USU_LOGIN
 ,CLI.CLI_DOCUMENTO_IDENTIDAD
,	MIN(RES.TIR_TIPO_CONTAC) AS GSTION
,	SUM(CASE WHEN RES.FLG_COMPROMISO=1 THEN 1 ELSE 0 END) AS COMPROMISO
 FROM COBRANZA.GCC_GESTIONES GES
 LEFT JOIN COBRANZA.GCC_TIPO_RESULTADO RES ON GES.SOL_CODIGO=RES.TIR_CODIGO OR (GES.SOL_CODIGO=0 AND GES.TIR_CODIGO=RES.TIR_CODIGO)
 INNER JOIN COBRANZA.GCC_USUARIO USU ON USU.USU_CODIGO=GES.GES_USUARIO_REGISTRO
 INNER JOIN COBRANZA.GCC_USUARIO_ROL URO ON URO.USU_CODIGO=USU.USU_CODIGO
 INNER JOIN COBRANZA.GCC_ROL ROL ON ROL.ROL_CODIGO=URO.ROL_CODIGO
 INNER JOIN COBRANZA.GCC_CUENTAS CUE ON CUE.CUE_CODIGO=GES.CUE_CODIGO
 INNER JOIN COBRANZA.GCC_CLIENTE CLI ON CLI.CLI_CODIGO=CUE.CLI_CODIGO
 WHERE CONVERT(VARCHAR,GES.GES_FECHA_REGISTRO,103) = CONVERT(VARCHAR,GETDATE(),103)
 AND URO.ROL_CODIGO IN (4,5)
 AND GES.GES_ESTADO_REGISTRO='A'
 GROUP BY ROL.ROL_DESCRIPCION+': '+USU.USU_LOGIN, CLI.CLI_DOCUMENTO_IDENTIDAD
 ) TAB
 GROUP BY TAB.USU_LOGIN";
  $ind_usu_diario = $this->run_query($query);

 // if ( $ind_usu_diario->rowCount() > 0 ) :
    /*
      while ( $fila = $ind_usu_diario->fetch(PDO::FETCH_NUM) ) :
          $agentes[] = $fila[0];
          $cont_directo[] = $fila[1];
          $datasets[] = array("name" => $fila[1], "y" => (float) $fila[4]);
      endwhile;*/
     // $ind_usu_diario->nextRowset();
 //     $ind_usu_diario->nextRowset();
      $data = $ind_usu_diario->fetchall(PDO::FETCH_ASSOC);
      $categorias = array_column($data, "USU_LOGIN");
      $contacto_directo = array_column($data, "CONT_DIRECTO");
      $contacto_indirecto = array_column($data, "CONT_INDIRECTO");
      $no_contacto = array_column($data, "NO_CONTACTO");
      $datasets = array(
                      array("name" => "CONTACTO_DIRECTO", "data" => $contacto_directo),
                      array("name" => "CONTACTO_INDIRECTO", "data" => $contacto_indirecto),
                      array("name" => "NO_CONTACTO", "data" => $no_contacto));
      $resultado = array("datasets" => $datasets, "categorias" => $categorias );
      return $resultado;
//  endif;

}//endfunction
}

 ?>
