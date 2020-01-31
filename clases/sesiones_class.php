<?php

/**
 *
 */
class Sesiones
{

    public function __construct()
    {
        session_start();
    }

    public function setUsuarioActual($user)
    {
        $_SESSION['usuario'] = $user;
    }

    public function getUsuarioActual()
    {
        return $_SESSION['usuario'];
    }

    public function closeSession()
    {
        session_unset();
        session_destroy();
    }

    public function setDatosUsuario($datos_usuario)
    {
        $_SESSION['ROL_CODIGO'] = $datos_usuario['d']['ROL_CODIGO'];
        $_SESSION['USU_CODIGO'] = $datos_usuario['d']['USU_CODIGO'];
        $_SESSION['USU_NOMBRES'] = $datos_usuario['d']['USU_NOMBRES'];
        $_SESSION['USU_APELLIDO_PATERNO'] = $datos_usuario['d']['USU_APELLIDO_PATERNO'];
        $_SESSION['USU_APELLIDO_MATERNO'] = $datos_usuario['d']['USU_APELLIDO_MATERNO'];
        $_SESSION['AST_ANEXO'] = $datos_usuario['d']['AST_ANEXO'];
        $_SESSION['ROL_DESCRIPCION'] = $datos_usuario['d']['ROL_DESCRIPCION'];
        $_SESSION['AST_TRONCAL_SIP'] = $datos_usuario['d']['AST_TRONCAL_SIP'];
        $_SESSION['AST_CONTEXTO'] = $datos_usuario['d']['AST_CONTEXTO'];
        $_SESSION['nombre_completo'] = $datos_usuario['d']['USU_NOMBRES'].' '.$datos_usuario['d']['USU_APELLIDO_PATERNO'].' '.$datos_usuario['d']['USU_APELLIDO_MATERNO'];
        //$_SESSION[''] = $datos_usuario['d'][''];

    }
}

 ?>
