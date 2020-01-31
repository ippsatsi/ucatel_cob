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

    public function __construct()
    {
        $this->server = "192.168.1.248";
        $this->database = "ucatel_db_gcc";
        $this->user = "sa";
        $this->password = "Tg3st10n";
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
}


 ?>
