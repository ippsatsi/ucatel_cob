<?php


require_once "db.php";

class Usuario extends DB
{
    private $user_rol;
    private $user_id;
    private $user_login;
    private $user_nombre_completo;
    private $user_anexo;
    private $user_descripcion;
    private $user_troncal;
    private $user_contexto;
    private $url_master;

    public function user_info($user, $password) {
        $query = "EXEC COBRANZA.SP_LOGIN ?, ?";
        $array_user = array($user, $password);
        $validar_usuario = $this->connect()->prepare($query ,array(PDO::ATTR_CURSOR => PDO::CURSOR_SCROLL));
        $validar_usuario->execute($array_user);


        $result = array("d"=>[]);
        if ( $validar_usuario->rowCount() ) :
            while ( $usuario = $validar_usuario->fetch( PDO::FETCH_ASSOC ) ):
                $result['d'] = $usuario;
                $user_rol = $usuario['ROL_CODIGO'];
                $user_id = $usuario['USU_CODIGO'];
                $user_login = $user;
                $username = $usuario['USU_NOMBRES'];
                $user_paterno = $usuario['USU_APELLIDO_PATERNO'];
                $user_materno = $usuario['USU_APELLIDO_MATERNO'];
                $user_anexo = $usuario['AST_ANEXO'];
                $user_descripcion = $usuario['ROL_DESCRIPCION'];
                $user_troncal = $usuario['AST_TRONCAL_SIP'];
                $user_contexto = $usuario['AST_CONTEXTO'];
            endwhile;
            return $result;
        else:
            return false;
        endif;

    }//enfunction

    public function setUserInfo()
    {
      $this->user_rol = $_SESSION['ROL_CODIGO'];
      $this->user_id = $_SESSION['USU_CODIGO'];
    //  $_SESSION['USU_NOMBRES'] = $datos_usuario['d']['USU_NOMBRES'];
    //  $_SESSION['USU_APELLIDO_PATERNO'] = $datos_usuario['d']['USU_APELLIDO_PATERNO'];
    //  $_SESSION['USU_APELLIDO_PATERNO'] = $datos_usuario['d']['USU_APELLIDO_PATERNO'];
      $this->user_anexo = $_SESSION['AST_ANEXO'];
      $this->user_descripcion = $_SESSION['ROL_DESCRIPCION'];
      $this->user_troncal = $_SESSION['AST_TRONCAL_SIP'];
      $this->user_contexto = $_SESSION['AST_CONTEXTO'];
      $this->user_nombre_completo = $_SESSION['nombre_completo'];
    }//endfunction

    public function getNombreCompleto()
    {
        return $this->user_nombre_completo;
    }

    public function getUserId()
    {
        return $this->user_id;
    }

    public function getUserRol()
    {
        return $this->user_rol;
    }

    public function getUserAnexo()
    {
        return $this->user_anexo;
    }

    public function getUserTroncalCh()
    {
        return $this->user_troncal;
    }

    public function getUserContextSip()
    {
        return $this->user_contexto;
    }

    public function setUrlMaster($url)
    {
        $this->url_master = $url;
    }
    public function getUrlMaster()
    {
        return $this->url_master;
    }

    public function getMenuByRol()
    {
        $query = "EXEC COBRANZA.SP_MENU_POR_ROL ?";
        $array_rol = array($this->user_rol);
        $obtener_menu = $this->connect()->prepare($query ,
            array(PDO::ATTR_CURSOR                      => PDO::CURSOR_SCROLL,
                  PDO::SQLSRV_ATTR_CURSOR_SCROLL_TYPE   => PDO::SQLSRV_CURSOR_BUFFERED));
        $obtener_menu->execute($array_rol);
        //echo $obtener_menu->rowCount();
        $html = "  <ul class='page-sidebar-menu  page-header-fixed page-sidebar-menu-light ' data-keep-expanded='false' data-auto-scroll='true' data-slide-speed='200'>";
        $html_final = '';
        $primer_padre = true;
        $url_base = $this->url_master;
        if ( $obtener_menu->rowCount() > 0 ) :
             while ( $menu = $obtener_menu->fetch( PDO::FETCH_ASSOC ) ) {
                if ( $menu["PAG_ES_PADRE"] == 1 ) :
                    // $html .= $primer_padre?" ":"    </li>\n";
                    $html .= "    <li class='heading'>\n";
                    $html .= "      <h3 class='uppercase'>${menu["PAG_TITLE"]}</h3>\n";
                    //$html .= "    </li>";
                else:
                    $url = str_replace(".aspx", ".php", $menu['PAG_URL']);
                    $html .= "      <li  class='nav-item'>\n";
                    $html .= "        <a href='${url_base}${url}' data-master='${url_base}' data-url='${url}' class='nav-link nav-toggle'>\n";
                    $html .= "          <i class='${menu["PAG_ICON"]}'></i>\n";
                    $html .= "          <span class='title'>${menu["PAG_TITLE"]}</span>\n";
                    $html .= "        </a>\n";
                    $html .= "      </li><!-- li -->\n";
                    $primer_padre = false;
                endif;/*
                echo "<pre>";
                var_dump($_SERVER);
                echo "</pre>";*/
             }
        endif;
        $html .= "    </li>\n";
        $html .= "    <li class='heading'>\n";
        $html .= "      <h3 class='btnCerrarSesion uppercase'>\n";
        $html .= "        <i class='ico-menu'></i>SALIR</h3>\n";
        $html .= "    </li>\n";
        $html .= "  </ul>\n";
        echo $html;

    }
}//endclass


 ?>
