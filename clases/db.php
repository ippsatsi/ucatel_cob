<?php

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

    public function __construct()
    {
        $this->server = "192.168.1.248";
        $this->database = "ucatel_db_gcc";
        $this->user = "sa";
        $this->password = "Tg3st10n";
        $this->array_parameter_select_count = array(
              PDO::ATTR_CURSOR                      => PDO::CURSOR_SCROLL,
              PDO::SQLSRV_ATTR_CURSOR_SCROLL_TYPE   => PDO::SQLSRV_CURSOR_BUFFERED);
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
}


 ?>
