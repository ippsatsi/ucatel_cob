<?php

require "datos_conexion_local.php";
/**
 *
 */
class DB
{
    private $server;
    private $database;
    private $user;
    private $password;
    private $array_parameter_select_count;
//PDO::SQLSRV_CURSOR_DYNAMIC
    public function __construct()
    {
        GLOBAL $ip_server_local;
        GLOBAL $sql_user_local;
        GLOBAL $sql_pass_local;
        
        $this->server = $ip_server_local;
        $this->database = "ucatel_db_gcc";
        $this->user = $sql_user_local;
        $this->password = $sql_pass_local;
        $this->array_parameter_select_count = array(
              PDO::ATTR_CURSOR                      => PDO::CURSOR_SCROLL,
              PDO::SQLSRV_ATTR_CURSOR_SCROLL_TYPE   => PDO::SQLSRV_CURSOR_BUFFERED);
        $this->array_parameter_select_big_count = array(
              PDO::ATTR_CURSOR                      => PDO::CURSOR_SCROLL,
              PDO::SQLSRV_ATTR_CURSOR_SCROLL_TYPE   => PDO::SQLSRV_CURSOR_DYNAMIC);
        //este parametro me cuenta el resultado del update, en los select me da -1
        $this->array_parameter_update_count = array(
              PDO::ATTR_CURSOR                      => PDO::CURSOR_FWDONLY);
    }

    public function connect() {
        try {

            $conn = new PDO( "sqlsrv:server=$this->server ; Database=$this->database", $this->user, $this->password);
            $conn->setAttribute( PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION );
            return $conn;
        } catch (PDOException $e) {
            die( print_r( $e->getMessage() ) );
        }

    }

    public function run_query_wParam($query, $parameters)
    {
        $run_query = $this->connect()->prepare($query, $this->array_parameter_select_count);
        $run_query->execute($parameters);

        return $run_query;
    }

    public function run_big_query_wParam($query, $parameters)
    {
        //aumentamos el buffer de php para cursores client-side
        $new_size = 61440;
        ini_set('pdo_sqlsrv.client_buffer_max_kb_size', $new_size);
        $this->connect()->setAttribute( PDO::SQLSRV_ATTR_CLIENT_BUFFER_MAX_KB_SIZE, $new_size );
        $run_query = $this->connect()->prepare($query, $this->array_parameter_select_count);
        $run_query->execute($parameters);

        return $run_query;
    }
    public function run_query_update_wParam($query, $parameters)
    {
        $run_query = $this->connect()->prepare($query, $this->array_parameter_update_count);
        $run_query->execute($parameters);
        return $run_query;
    }

    public function run_query($query)
    {
        $run_query = $this->connect()->query($query);
        return $run_query;
    }

    public function getListaOrigenDB()
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

    public function getListaTipoGestionDB()
    {
        $query = "
            SELECT
                TPG.TIG_DESCRIPCION AS 'key'
                , TPG.TIG_CODIGO AS 'value'
                FROM
                COBRANZA.GCC_TIPO_GESTION TPG
                WHERE
                TPG.TIG_ESTADO_REGISTRO='A'";

        $resultado = $this->run_query($query);
        $result = array("d" => 0);
        $array_filas = array();
        $result['d'] = $resultado->fetchall(PDO::FETCH_ASSOC);

        return $result;
    }//endfunction

}


 ?>
