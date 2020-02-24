<?php

class AMI
{
    private $socket;
    private $error_socket;
    private $asterisk_server;
    private $port;
    private $user;
    private $pass;
    private $msg;


  function __construct($ami_server, $user, $pass, $port='5038')
  {
      $this->asterisk_server = $ami_server;
      $this->user = $user;
      $this->pass = $pass;
      $this->port = $port;
      $this->socket = false;
      $this->msg = "Inicializando..";
  }

  public function OriginarLlamada($troncal, $contexto, $numero_a_marcar, $caller_id)
  {
      $result['d'] = false;
      $socket = stream_socket_client("tcp://$this->asterisk_server:$this->port");
      if ( $socket ) :
          $this->msg = "Conectado al Servidor, iniciando login";

          $ami_request  = "Action: Login\r\n";
          $ami_request .= "Username: $this->user\r\n";
          $ami_request .= "Secret: $this->pass\r\n";
          $ami_request .= "Events: off\r\n\r\n";

          // Enviando solicitud de logeo
          $autenticacion = stream_socket_sendto($socket, $ami_request);
          if ( $autenticacion > 0 ) :
              //esperamos
              usleep(200000);
              //Leemos respuesta
              $respuesta_login = fread($socket, 4096);
              //verificamos si el logeo fue aceptado
              if ( strpos($respuesta_login, 'Success') !== false ) :
                  $this->msg = "Logueado en AMI, iniciando llamada";

                  $llamada_request = "Action: Originate\r\n";
                  $llamada_request .= "Channel: $troncal\r\n";
                  $llamada_request .= "Callerid: $caller_id\r\n";
                  $llamada_request .= "Exten: $numero_a_marcar\r\n";
                  $llamada_request .= "Context: $contexto\r\n";
                  $llamada_request .= "Priority: 1\r\n";
                  $llamada_request .= "Async: yes\r\n\r\n";
                  $llamada_request .= "Action: Logoff\r\n\r\n";
                  // fecha	    hora	    ori	         t	dst	      anexo	proveedor	time	tipo	 variable Callerid
                  // 2020-02-24	09:49:27	4001	       M	997016720	4001	fravatel	12	  exten	 $anexo
                  // 2020-02-24	09:43:52	38997016720	 M	997016720	4001	fravatel	33	 target	 $numero_a_marcar
                  // 2020-02-24	09:38:59	919359912	   M	997016720	4001	fravatel	52	 texto	 "Click2Call"

                  //enviando soliciutd de llamada
                  $llamando = stream_socket_sendto($socket, $llamada_request);

                  if ( $llamando > 0 ) :
                      //esperamos respuesta del servidor
                      usleep(200000);
                      $llamand_Respuesta = fread($socket, 4096);
                      if ( strpos($llamand_Respuesta, "Success") !== False ) :
                          $result['d'] = true;
                          $this->msg = "Iniciando Llamada...";
                      else:
                          $this->msg = "Conexion al servidor correcto, pero no se pudo iniciar la llamada";
                      endif;
                  else:
                      $this->msg = "Error en la conexion al servidor en el envio de datos para hacer la llamada";
                  endif;
              else:
                  //Nos acepto el paquete, pero el logueo fue rechazado
                  $this->msg = "El servidor no valido los datos de autenticacion";
              endif;
          else:
              //No nos pudimo autenticar por un problema de conexion al socket
              $this->msg = "Error en la conexion al servidor durante la autenticacion";
          endif;
      else:
          //Nos nos pudimos conectar al servidor
          $this->msg = "Error en la conexion al servidor";
      endif;

      $result['msg'] = $this->msg;
      return $result;
  }//endfunction
}


 ?>
