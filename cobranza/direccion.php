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
$dir_codigo = "";

if ( isset($_GET['codigo']) ) :
    $dir_codigo = $_GET['codigo'];
endif;

$cli_codigo = $_GET['codigoCliente'];
$prv_codigo = $_GET['codigoProveedor'];

//$rol_codigo = $_GET['codigoRol'];
$head = "";
$titulo = "GESTIONAR DIRECCIÓN";
$sub_titulo = "";
$sub_titulo = "";
$pageBar =<<<Final
Final;


$contenido =<<<Final
<div class="content">
<input type="hidden" name="txtCodigo" id="txtCodigo" value="${dir_codigo}" />
<input type="hidden" name="txtCodigoCliente" id="txtCodigoCliente" value="${cli_codigo}" />
<input type="hidden" name="txtCodigoProveedor" id="txtCodigoProveedor" value="${prv_codigo}" />
    <div class="form-group row">
      <label for="sltTipoDireccion" class="col-xs-4 col-form-label">TIPO DIRECCIÓN</label>
      <div class="col-xs-8">
        <select id="sltTipoDireccion" class="form-control">
            <option value="0">-SELECCIONE-</option>
        </select>
      </div>
    </div>
    <div class="form-group row">
      <label for="txtDirección" class="col-xs-4 col-form-label">DIRECCIÓN</label>
      <div class="col-xs-8">
        <textarea id="txtDirección" class="form-control"></textarea>
      </div>
    </div>
    <div class="form-group row">
      <label for="sltDepartamento" class="col-xs-4 col-form-label">DEPARTAMENTO</label>
      <div class="col-xs-8">
        <select id="sltDepartamento" class="form-control">
            <option value="0">-SELECCIONE-</option>
        </select>
      </div>
    </div>
    <div class="form-group row">
      <label for="sltProvincia" class="col-xs-4 col-form-label">PROVINCIA</label>
      <div class="col-xs-8">
        <select id="sltProvincia" class="form-control">
            <option value="0">-SELECCIONE-</option>
        </select>
      </div>
    </div>
    <div class="form-group row">
      <label for="sltDistrito" class="col-xs-4 col-form-label">DISTRITO</label>
      <div class="col-xs-8">
        <select id="sltDistrito" class="form-control">
            <option value="0">-SELECCIONE-</option>
        </select>
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
      <label for="sltOrigen" class="col-xs-4 col-form-label">ORIGEN</label>
      <div class="col-xs-8">
        <select id="sltOrigen" class="form-control">
            <option value="0">-SELECCIONE-</option>
        </select>
      </div>
    </div>
</div>

Final;

$footer =<<<Final
<button type="button" class="btn btn-primary" onclick="guardar_direccion();">ACEPTAR</button>
<button type="button" class="btn btn-danger" onclick="parent.$.fancybox.close();">CANCELAR</button>

Final;

$script =<<<Final
<script type="text/javascript">
    $(document).ready(function () {
        listarDepartamento();
        listaTipoDireccion();
        cargarTipoOrigen();
        cargarDireccionStatus();

        if ($("#txtCodigo").val().length > 0) {
            cargarDatos($("#txtCodigo").val());
        }



        function cargarDireccionStatus() {
            $.ajax({
                url: strServicio + "direccion_svc.php?obtenerDireccionStatus=1",
                dataType: 'JSON',
                data: '{"consulta":"ajax"}',
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

        function cargarDatos(codigo) {
            $.ajax({
                url: strServicio + "direccion_svc.php?obtenerPorId=1",
                data: '{"codigo":' + codigo + ', "CONSULTA_AJAX":"obtenerPorId"}',
                dataType: 'JSON',
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                async: false,
                success: function (jsondata) {
                    $("#sltTipoDireccion").val(jsondata.d.TDI_CODIGO);
                    $("#txtDirección").val(jsondata.d.DIR_DIRECCION);
                    $("#sltDepartamento").val(jsondata.d.UBI_CODIGO.substring(0, 2));
                    $("#sltDepartamento").change();
                    $("#sltProvincia").val(jsondata.d.UBI_CODIGO.substring(2, 4));
                    $("#sltProvincia").change();
                    $("#sltDistrito").val(jsondata.d.UBI_CODIGO.substring(0, 6));
                    $("#txtValido").val(jsondata.d.DIR_ESTADO_VALIDEZ);
                    $("#sltOrigen").val(jsondata.d.TOR_CODIGO);
                }
            });
        }
    });

    function guardar_direccion() {
        if ($("#sltTipoDireccion").val() == "0") {
            bootbox.alert("Seleccione el tipo de dirección");
            return false;
        }
        if ($("#txtDirección").val().length < 1) {
            bootbox.alert("Ingrese la dirección");
            return false;
        }
        if ($("#sltDepartamento").val() == "0") {
            bootbox.alert("Seleccione departamento");
            return false;
        }
        if ($("#sltProvincia").val() == "0") {
            bootbox.alert("Seleccione provincia");
            return false;
        }
        if ($("#sltDistrito").val() == "0") {
            bootbox.alert("Seleccione distrito");
            return false;
        }
        if ($("#txtValido").val().length < 1) {
            bootbox.alert("Ingrese la validación");
            return false;
        }
        if ($("#sltOrigen").val() == "0") {
            bootbox.alert("Seleccione el origen");
            return false;
        }
        objDireccion = new Object();
        objDireccion.DIR_CODIGO = $("#txtCodigo").val();
        objDireccion.DIR_DIRECCION = $("#txtDirección").val();
        objDireccion.DIR_ESTADO_VALIDEZ = $("#txtValido").val();
        objDireccion.PRV_CODIGO = $("#txtCodigoProveedor").val();
        objDireccion.CLI_CODIGO = $("#txtCodigoCliente").val();
      //  objDireccion.ObjTipoOrigen = new Object();
        objDireccion.TOR_CODIGO = $("#sltOrigen").val();
        objDireccion.UBI_DISTRITO = $("#sltDistrito").val();
      //  objDireccion.ObjTipoDireccion = new Object();
        objDireccion.TDI_CODIGO = $("#sltTipoDireccion").val();
        $.ajax({
            url: strServicio + "direccion_svc.php?registrar=1",
            data: '{"objDireccion":' + JSON.stringify(objDireccion) + ', "CONSULTA_AJAX":"registrar"}',
            dataType: 'JSON',
            type: 'POST',
            contentType: "application/json; charset=utf-8",
            async: false,
            success: function (jsondata) {
                if (jsondata.d > 0) {
                    parent.listarDirecciones();
                    parent.$.fancybox.close();
                    } else if (jsondata.d == -1) {  // RESTRICCIONES 24072019 // RESTRICCIONES 24072019 UCATEL
                        console.log("valor_registro_dir menor a 1:"+jsondata.d); // RESTRICCIONES 24072019 UCATEL
                        bootbox.alert("NO TIENE LOS PERMISOS NECESARIOS PARA REALIZAR ESTA GESTION"); // RESTRICCIONES 24072019 UCATEL
                }
            }
        });
    }

    function cargarTipoOrigen() {
        $.ajax({
            url: strServicio + "direccion_svc.php?listarTipoOrigen=1",
            dataType: 'JSON',
            data: '{"consulta":"ajax"}',
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

    function listaTipoDireccion() {
        $.ajax({
            url: strServicio + "direccion_svc.php?listaTipoDireccion=1",
            dataType: 'JSON',
            data: '{"consulta":"ajax"}',
            type: 'POST',
            async: false,
            contentType: "application/json; charset=utf-8",
            success: function (jsondata) {
                //console.table(jsondata.d);
                //$("#sltDepartamento").empty();
                $.each(jsondata.d, function (i, obj) {
                    $("#sltTipoDireccion").append("<option value='" + obj.value + "'>" + obj.key + "</option>");
                });
            }
        });
    }

    $("#sltDepartamento").change(function () {
        listarProvincia($(this).val());
        $("#sltDistrito").html("<option value='0'>-SELECT-</option>");
    });

    $("#sltProvincia").change(function () { listarDistrito($("#sltDepartamento").val(), $(this).val()); });

    function listarDepartamento() {
        $.ajax({
            url: strServicio + "direccion_svc.php?listarDepartamento=1",
            dataType: 'JSON',
            data: '{"consulta":"ajax"}',
            type: 'POST',
            async: false,
            contentType: "application/json; charset=utf-8",
            success: function (jsondata) {
                //console.table(jsondata.d);
                //$("#sltDepartamento").empty();
                $.each(jsondata.d, function (i, obj) {
                    $("#sltDepartamento").append("<option value='" + obj.value + "'>" + obj.key + "</option>");
                });
            }
        });
    }

    function listarProvincia(idDepartamento) {
        var objUbigeo = new Object();
        objUbigeo.UBI_CODIGO_DEPARTAMENTO = idDepartamento;
        $.ajax({
            url: strServicio + "direccion_svc.php?listarProvincia=1",
            data: '{"objUbigeo":' + JSON.stringify(objUbigeo) + ', "CONSULTA_AJAX":"listarProvincia"}',
            dataType: 'JSON',
            type: 'POST',
            async: false,
            contentType: "application/json; charset=utf-8",
            success: function (jsondata) {
                console.table(jsondata.d);
                $("#sltProvincia").empty();
                $("#sltProvincia").html("<option value='0'>-SELECT-</option>");
                $.each(jsondata.d, function (i, obj) {
                    $("#sltProvincia").append("<option value='" + obj.value + "'>" + obj.key + "</option>");
                });
            }
        });
    }

    function listarDistrito(idDepartamento, idProvincia) {
        var objUbigeo = new Object();
        objUbigeo.UBI_CODIGO_DEPARTAMENTO = idDepartamento;
        objUbigeo.UBI_CODIGO_PROVINCIA = idProvincia;
        $.ajax({
            url: strServicio + "direccion_svc.php?listarDistrito=1",
            data: '{"objUbigeo":' + JSON.stringify(objUbigeo) + ', "CONSULTA_AJAX":"listarDistrito"}',
            dataType: 'JSON',
            type: 'POST',
            async: false,
            contentType: "application/json; charset=utf-8",
            success: function (jsondata) {
                console.table(jsondata.d);
                $("#sltDistrito").empty();
                $("#sltDistrito").html("<option value='0'>-SELECT-</option>");
                $.each(jsondata.d, function (i, obj) {
                    $("#sltDistrito").append("<option value='" + obj.value + "'>" + obj.key + "</option>");
                });
            }
        });
    }
</script>

Final;

require_once $url_relativa.'resource/masterPage/Popup.php';

 ?>
