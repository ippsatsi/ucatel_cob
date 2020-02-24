<?php

require_once "url_relativa.php";
require_once $url_relativa."valida_sesion.php";
require_once $url_relativa."clases/usuario_class.php";

$user = new Usuario();
$user->setUserInfo();
$user->setUrlMaster($ruta_web);

if ( ! ( isset($_GET['codigoCliente']) && isset($_GET['codigoProveedor']) ) ) :
    exit;
endif;
$tel_codigo = 0;

if ( isset($_GET['codigo']) ) :
    $tel_codigo = $_GET['codigo'];
endif;

$cli_codigo = $_GET['codigoCliente'];
$prv_codigo = $_GET['codigoProveedor'];

//$rol_codigo = $_GET['codigoRol'];
$head = "";
$titulo = "GESTIONAR TELEFONO";
$sub_titulo = "Página de inicio";
$sub_titulo = "";
$pageBar =<<<Final
Final;


$contenido =<<<Final
<div class="content">
        <input type="hidden" name="txtCodigo" id="txtCodigo" value="${tel_codigo}" />
        <input type="hidden" name="txtCodigoCliente" id="txtCodigoCliente" value="${cli_codigo}" />
        <input type="hidden" name="txtCodigoProveedor" id="txtCodigoProveedor" value="${prv_codigo}" />
    <div class="form-group row">
      <label for="txtTelefono" class="col-xs-4 col-form-label">TELEFONO</label>
      <div class="col-xs-8">
        <input class="form-control" type="text" placeholder="FIJO Lima:7 digitos, PROV,MOVIL: 9 digitos" id="txtTelefono"/>
      </div>
    </div>
    <div class="form-group row">
      <label for="txtAnexo" class="col-xs-4 col-form-label">ANEXO</label>
      <div class="col-xs-8">
        <input class="form-control" type="text" id="txtAnexo"/>
      </div>
    </div>
    <div class="form-group row">
      <label for="txtValido" class="col-xs-4 col-form-label">VALIDO</label>
      <div class="col-xs-8">
        <select id="txtValido" class="form-control">
            <option value="0">-SELECCIONE-</option>
        </select>
      </div>
    </div>
    <div class="form-group row">
      <label for="sltEstado" class="col-xs-4 col-form-label">ESTADO</label>
      <div class="col-xs-8">
        <select id="sltEstado" class="form-control">
            <option value="0">-SELECCIONE-</option>
            <option value="N">NUEVO</option>
            <option value="G">GESTIONADO</option>
        </select>
      </div>
    </div>
    <div class="form-group row">
      <label for="sltOrigen" class="col-xs-4 col-form-label">ORIGEN</label>
      <div class="col-xs-8">
        <select id="sltOrigen" class="form-control">
            <option value="0">-SELECCIONE-</option>
        </select>
      </div>
    </div>
    <div class="form-group row">
      <label for="txtObservacion" class="col-xs-4 col-form-label">OBSERVACIÓN</label>
      <div class="col-xs-8">
        <textarea id="txtObservacion" class="form-control"></textarea>
      </div>
    </div>
</div>

Final;

$footer =<<<Final
    <button type="button" class="btn btn-primary" onclick="guardar_telefono();">ACEPTAR</button>
    <button type="button" class="btn btn-danger" onclick="parent.$.fancybox.close();">CANCELAR</button>
Final;

$script =<<<Final
<script type="text/javascript">
    $(document).ready(function () {
        //cargarTipoOperador();
        //cargarTipoEquipo();
        cargarTipoOrigen();
        cargarTelefonoStatus();
        console.log('txtlen: ' + $("#txtCodigo").val().length);
        console.log('prueba');
        if ($("#txtCodigo").val() > 0) {
            cargarDatos($("#txtCodigo").val());
            //buscamos los paramentros en el URL
            const params = new URLSearchParams(location.search);
            var rol = params.get('codigoRol');
            if (rol > 3) {
                 $("#txtTelefono").attr('disabled','disabled');
            }
        }

        function cargarDatos(codigo) {
            $.ajax({
                url: strServicio + "telefono_svc.php?obtenerPorId=1",
                data: '{"codigo":' + codigo + ',"CONSULTA_AJAX":"obtenerPorId"}',
                dataType: 'JSON',
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                async: false,
                success: function (jsondata) {
                    console.log('ajax');
                    //$("#sltOperador").val(jsondata.d.ObjTipoOperador.TIO_CODIGO);
                    $("#txtTelefono").val(jsondata.d.TEL_NUMERO);
                    $("#txtAnexo").val(jsondata.d.TEL_ANEXO);
                    $("#txtValido").val(jsondata.d.TEL_ESTADO_VALIDEZ);
                    //$("#sltTipoEquipo").val(jsondata.d.ObjTipoTelefono.TIT_CODIGO);
                    $("#sltEstado").val(jsondata.d.TEL_ESTADO_TELEFONO);
                    $("#sltOrigen").val(jsondata.d.TOR_CODIGO);
                    $("#txtObservacion").val(jsondata.d.TEL_OBSERVACIONES);
                }
            });
        }

        function cargarTelefonoStatus() {
            $.ajax({
                url: strServicio + "telefono_svc.php?obtenerTelefonoStatus=1",
                data: '{"consulta":"ajax"}',
                dataType: 'JSON',
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                async: false,
                success: function (jsondata) {
                    $.each(jsondata.d, function (i, obj) {
                        $("#txtValido").append("<option value='" + obj.value + "'>" + obj.key + "</option>");
                    });
                }
            });
        }

        function cargarTipoOrigen() {
            $.ajax({
                url: strServicio +  "telefono_svc.php?listarTipoOrigen=1",
                data: '{"consulta":"ajax"}',
                dataType: 'JSON',
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                async: false,
                success: function (jsondata) {
                    $.each(jsondata.d, function (i, obj) {
                        $("#sltOrigen").append("<option value='" + obj.value + "'>" + obj.key + "</option>");
                    });
                }
            });
        }
    });

    function guardar_telefono() {
        //VALIDAR
        //if ($("#sltOperador").val() == "0") {
        //    bootbox.alert("Seleccione el operador");
        //    return false;
        //}
        var re = /^([09][0-9]{8})$|^([2-7][0-9]{6})$/;
        if (!re.test($("#txtTelefono").val())) {
            bootbox.alert("Ingrese formato valido de telefono de 7 o 9 digitos, SIN ESPACIOS NI GUIONES");
            return false;
        }
        if ($("#txtTelefono").val().length < 1) {
            bootbox.alert("Ingrese número de telefono");
            return false;
        }
        if ($("#txtValido").val().length < 1) {
            bootbox.alert("Ingrese valido");
            return false;
        }
        //if ($("#sltTipoEquipo").val() == "0") {
        //    bootbox.alert("Seleccione el tipo de equipo");
        //    return false;
        //}
        if ($("#sltEstado").val() == "0") {
            bootbox.alert("Seleccione el estado");
            return false;
        }
        if ($("#sltOrigen").val() == "0") {
            bootbox.alert("Seleccione el origen");
            return false;
        }
        //CREAR OBJETO
        objTelefono = new Object();
        objTelefono.TEL_CODIGO = $("#txtCodigo").val();
        objTelefono.TEL_NUMERO = $("#txtTelefono").val();
        objTelefono.TEL_ESTADO_VALIDEZ = $("#txtValido").val();
        objTelefono.CLI_CODIGO = $("#txtCodigoCliente").val();
        //objTelefono.ObjTipoOrigen = new Object();
        //objTelefono.ObjTipoOrigen.TOR_CODIGO = $("#sltOrigen").val();
        objTelefono.TOR_CODIGO = $("#sltOrigen").val();
        objTelefono.TEL_ESTADO_TELEFONO = $("#sltEstado").val();
        objTelefono.TEL_ANEXO = $("#txtAnexo").val();
        objTelefono.TEL_OBSERVACIONES = $("#txtObservacion").val();
        objTelefono.PRV_CODIGO = $("#txtCodigoProveedor").val();
        //return;
        $.ajax({
            url: strServicio +  "telefono_svc.php?registrar=1",
            data: '{"objTelefono":' + JSON.stringify(objTelefono) + ', "CONSULTA_AJAX":"registrar"}',
            dataType: 'JSON',
            type: 'POST',
            contentType: "application/json; charset=utf-8",
            async: false,
            success: function (jsondata) {
                if (jsondata.d > 0) {
                    parent.listarTelefonos();
                    parent.$.fancybox.close();
                    console.log("valor_registro_tel mayor a cero:"+jsondata.d); <!-- RESTRICCIONES 24072019 -->
                    } else if (jsondata.d == -1) {                              <!-- RESTRICCIONES 24072019 -->
                        console.log("valor_registro_tel menor a 1:"+jsondata.d); <!-- RESTRICCIONES 24072019 -->
                        bootbox.alert("NO TIENE LOS PERMISOS NECESARIOS PARA REALIZAR ESTA GESTION"); <!-- RESTRICCIONES 24072019 -->
                }
            }
        });
    }
</script>


Final;

require_once $url_relativa.'resource/masterPage/Popup.php';

 ?>
