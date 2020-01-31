<?php

require_once "db.php";

class Menu extends DB
{

  public function getMenuByRol($rol)
  {
      $query = "EXEC COBRANZA.SP_MENU_POR_ROL ?";
      $array_rol = array($rol);
      $obtener_menu = $this->connect()->prepare($query ,array(PDO::ATTR_CURSOR => PDO::CURSOR_SCROLL));
      $obtener_menu->execute($array_rol);

      if ( $obtener_menu->rowCount() > 0 ) :
          while ( $menu = $obtener_menu->fetch( PDO::FETCH_ASSOC ) ) {
              echo "<pre>";
              var_dump($menu);
              echo "</pre>";
          }
      endif;
  }
}

 ?>
