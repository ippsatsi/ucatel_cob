<?php

require_once "url_relativa.php";
require_once $url_relativa."valida_sesion.php";
require_once $url_relativa."clases/usuario_class.php";

$user = new Usuario();
$user->setUserInfo();
$user->setUrlMaster($ruta_web);

if ( ! ( isset($_GET['codigoCliente']) && isset($_GET['codigoProveedor'])  ) ) :
    exit;
endif;
$cor_codigo = "";

if ( isset($_GET['codigo']) ) :
    $cor_codigo = $_GET['codigo'];
endif;

$correo = "";
if ( isset($_GET['correo']) ) :
    $correo = $_GET['correo'];
endif;

$cli_codigo = $_GET['codigoCliente'];
$prv_codigo = $_GET['codigoProveedor'];

//$rol_codigo = $_GET['codigoRol'];
$head = "";
$titulo = "GESTIONAR CORREO";
$sub_titulo = "";
$sub_titulo = "";
$pageBar =<<<Final
Final;


$contenido =<<<Final
<div class="content">
<input type="hidden" name="txtCodigo" id="txtCodigo" value="${cor_codigo}" />
<input type="hidden" name="txtCodigoCliente" id="txtCodigoCliente" value="${cli_codigo}" />
<input type="hidden" name="txtCodigoProveedor" id="txtCodigoProveedor" value="${prv_codigo}" />
    <div class="form-group row">
      <label for="txtCorreo" class="col-xs-4 col-form-label">CORREO</label>
      <div class="col-xs-8">
        <input class="form-control" type="text" id="txtCorreo" value="${correo}"/>
      </div>
    </div>
</div>
Final;

$footer =<<<Final
<button type="button" class="btn btn-primary" onclick="guardar_correo();">ACEPTAR</button>
<button type="button" class="btn btn-danger" onclick="parent.$.fancybox.close();">CANCELAR</button>
Final;

$script =<<<Final
<script type="text/javascript">
    function guardar_correo() {
        if ($.trim($("#txtCorreo").val()).length < 1) {
            bootbox.alert("Ingrese correo electrónico");
            return false;
        }
        var re = /^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/;
        if (!re.test($("#txtCorreo").val())) {
            bootbox.alert("Ingrese formato valido de correo (sin Ñ ó ESPACIOS)");
            return false;
        }
        //CREAR OBJETO
        objCorreo = new Object();
        objCorreo.COR_CODIGO = $("#txtCodigo").val();
        objCorreo.CLI_CODIGO = $("#txtCodigoCliente").val();
        objCorreo.COR_CORREO_ELECTRONICO = $("#txtCorreo").val();
        //return;
        $.ajax({
            url: strServicio + "correo_svc.php?registrar=1",
            data: '{"objCorreo":' + JSON.stringify(objCorreo) + ',"CONSULTA_AJAX":"registrar"}',
            dataType: 'JSON',
            type: 'POST',
            contentType: "application/json; charset=utf-8",
            async: false,
            success: function (jsondata) {
                if (jsondata.d > 0) {
                    parent.listarCorreos();
                    parent.$.fancybox.close();
                  }
              }
          });
      }
  </script>
Final;

require_once $url_relativa.'resource/masterPage/Popup.php';

 ?>
