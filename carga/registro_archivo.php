<?php
//inicializacion
require_once "url_relativa.php";
require_once $url_relativa."valida_sesion.php";
require_once $url_relativa."clases/usuario_class.php";
require_once $url_relativa."clases/cliente_class.php";

$user = new Usuario();
$user->setUserInfo();
$user->setUrlMaster($ruta_web);
//mostramos todas la cuentas que tiene el cliente
$cliente = new Cliente();


//Extraemos los datos de los cuadros informativos para mostrarlos

//personalizacion del contenido de la pagina

$head =<<<Final
Final;
$titulo = "";//"BANDEJA DE GESTIONES";
$sub_titulo = "";//"Página de inicio";
$sub_titulo = "";
$pageBar = "";

$contenido =<<<Final
<div class="row" id="div_contenido">
<div class="col-md-12">
    <div class="portlet box blue">
        <div class="portlet-title">
            <div class="caption">
                <i class="fa fa-globe"></i> Registro de Archivo </div>
            <div class="tools"> </div>
        </div>

        <div class="portlet-body">
            <div class="row">
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 margin-bottom-20">
                    <div class="col-md-4">
                        <label>PROVEEDOR</label>
                        <select id="sltProveedor" class="form-control">
                            <option value="0">-SELECCIONA-</option>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label>CARTERA</label>
                        <select id="sltCartera" class="form-control">
                            <option value="0">-SELECCIONA-</option>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label>SUB CARTERA</label>
                        <select id="sltSubCartera" class="form-control">
                            <option value="0">-SELECCIONA-</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 margin-bottom-20">
                    <div class="col-md-2">
                        <label>MONEDA</label>
                        <select id="sltMoneda" class="form-control">
                            <option value="0">-SELECCIONA-</option>
                            <option value="0">AUTOMATICO</option>
                            <option value="1">SOLES</option>
                            <option value="2">DOLARES</option>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <label>SEPARADOR</label>
                        <select id="sltSeparador" class="form-control">
                            <option value="0">-SELECCIONA-</option>
                            <option value="C">COMA ','</option>
                            <option value="P">PUNTO Y COMA ';'</option>
                            <option value="S">SEPARADOR '|'</option>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label>ARCHIVO</label>
                        <input type="file" id="fl_archivo" class="form-control"/>
                        <span id="txtProgreso"></span>
                    </div>
                    <div class="col-md-2">
                        <label>&nbsp;&nbsp;</label>
                        <input type="button" id="btn_registrar" value="REGISTRAR" class="form-control btn blue btn_buscar" />
                    </div>
                    <div class="col-md-2">
                        <label>&nbsp;&nbsp;</label>
                        <a class="btn blue form-control" onclick="generarModelo();"><i class="fa fa-file-excel-o"></i> DESCARGAR MODELO</a>
                    </div>
                </div>
            </div>            
            <div id="div_mensaje">
            </div>
            <table class="tblLista table table-striped table-bordered table-hover dt-responsive" cellspacing="0" width="100%" id="tbl_respuesta">
                <thead>
                    <tr>
                        <th class="min-cliente">REGISTRADOS</th>
                        <th class="min-cliente">RETIRADOS</th>
                        <th class="min-cliente">ACTUALIZADOS</th>
                        <th class="min-cliente">MIGRACIONES</th>
                        <th class="all">TOTAL</th>
                    </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>
    </div>
</div>

<div class="col-sm-12 sidenav">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title"><i class="fa fa-user" aria-hidden="true"></i> RESUMEN CUENTAS ACTIVAS</h3>
        </div>
        <div class="panel-body">
            <table class="table table-striped table-bordered table-hover" id="tblResumenCuentas">
                <thead>
                    <tr style="background-color: black; color: white;">
                        <th>N°</th>
                        <th>PROVEEDOR</th>
                        <th>CARTERA</th>
                        <th>SUB CARTERA</th>
                        <th>CANT. CUENTAS</th>
                        <th>CANT. CLIENTES</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>0</td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td>0</td>
                        <td>0</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

</div>


Final;

$script =<<<Final
<script type="text/javascript">
$(document).ready(function () {
    cargarProveedor();
    //cargarTipoMoneda();
    listarResumenCuentas();

    $("#sltProveedor").change(cargarCarteras);
    $("#sltCartera").change(cargarSubCarteras);
    $("#btn_registrar").click(registrar);

    $("#fl_archivo").change(function (e) {
        abrir_preload('div_contenido');
        var fileName = e.target.files[0];

        if (fileName.name.split('.').pop().toLowerCase() != "txt" &&
            fileName.name.split('.').pop().toLowerCase() != "csv") {
            bootbox.alert("USTED NO SELECCIONO EL FORMATO INDICADO");
            $(this).val("");
            return false;
        }

        var formData = new FormData();
        var files = $("#fl_archivo").get(0).files;
        formData.append("proveedor", $("#sltProveedor").val());
        formData.append("cartera", $("#sltCartera").val());
        formData.append("sub_cartera", $("#sltSubCartera").val());
        formData.append("separador", $("#sltSeparador").val());
        formData.append("UploadFile", files[0]);

        $.ajax({
            url: "../resource/carga/carga_registro.ashx",
            type: 'POST',
            beforeSend: function () {
                $("#div_mensaje").html("CARGANDO..");
            },
            uploadProgress: function (event, position, total, percentComplete) {
                $("#div_mensaje").html(percentComplete + '%');
            },
            success: function () {
                $("#div_mensaje").html('100%');
            },
            complete: function (response) {
                cerrar_preload('div_contenido');
                console.log(response.responseText);
                if (response.responseText.split("|-|")[0] == "ERROR") {
                    var datosError = response.responseText.split("|-|")[1].split("-");
                    $("#div_mensaje").html("Carga realizada incorrectamente : " + datosError[0] + "<br/>");
                    var html_texto = "<ul>";
                    for (var i = 1; i < datosError.length ; i++) {
                        html_texto += "<li>&nbsp;" + datosError[i] + "</li>";
                    }
                    html_texto += "</ul>";
                    $("#div_mensaje").append(html_texto);
                } else {
                    $("#div_mensaje").html("Carga realizada correctamente");
                    $("#tbl_respuesta tbody").html(response.responseText);

                }
            },
            error: function () {
                $("#div_mensaje").html("Ocurrio un error, por favor vuelva a intentar cargar el documento.", "MENSAJE DE CARGA DE DOCUMENTOS");
            },
            data: formData,
            cache: false,
            contentType: false,
            processData: false
        });
    });

});

function generarModelo() {
    var url = "generar.aspx?sca_codigo=" + $("#sltSubCartera").val() +
            "&sca_nombre=" + $("#sltSubCartera option:selected").text();
    window.open(url);
}

function registrar() {
    abrir_preload('div_contenido');
    $.ajax({
        url: strServicio+"memoria.asmx/registrar_datos_memoria",
        data: '{"prv_codigo":"' + $("#sltProveedor").val() + '","car_codigo":"' + $("#sltCartera").val() + '","sca_codigo":"' + $("#sltSubCartera").val() + '","mon_codigo":"' + $("#sltMoneda").val() + '"}',
        dataType: 'JSON',
        type: 'POST',
        contentType: "application/json; charset=utf-8",
        success: function (jsondata) {
            cerrar_preload('div_contenido');
            if(jsondata.d=="CORRECTO"){
                bootbox.alert("Carga realizada correctamente");
            }
        }
    });
}

function cargarTipoMoneda() {
    $.ajax({
        url: strServicio+"general.asmx/listarTipoMoneda",
        dataType: 'JSON',
        type: 'POST',
        contentType: "application/json; charset=utf-8",
        success: function (jsondata) {
            //$("#sltProveedor").empty();
            $.each(jsondata.d, function (i, obj) {
                $("#sltMoneda").append("<option value='" + obj.value + "'>" + obj.key + "</option>");
            });
        }
    });
}

// Añadida fucion para que no aparezcan carteras, proveedores o subcarteras retiradas (las cuales sus nobres deben finalizar con XX para que
// la funcion las detecte) 21.06.19
function borrarRetirados(select_box,obj) {
if ( obj.key.endsWith("XX") ) {
console.log(obj.key) }
else {
$(select_box).append("<option value='" + obj.value + "'>" + obj.key + "</option>");
}
}

function cargarProveedor() {
$.ajax({
url: strServicio + "cargarProveedor.php",
dataType: 'JSON',
type: 'POST',
contentType: "application/json; charset=utf-8",
success: function (jsondata) {
    //$("#sltProveedor").empty();
    $.each(jsondata.d, function (i, obj) {
      //  $("#sltProveedor").append("<option value='" + obj.value + "'>" + obj.key + "</option>"); // 21.06.19
      borrarRetirados("#sltProveedor",obj); // 21.06.19
    });
    //console.log(jsondata.d);
}
});
}

function cargarCarteras() {
$.ajax({
url: strServicio + "cargarCarteras.php",
data: '{"PRV_CODIGO":"' + $("#sltProveedor").val() + '"}',
dataType: 'JSON',
type: 'POST',
contentType: "application/json; charset=utf-8",
success: function (jsondata) {
    $("#sltCartera").empty();
    $("#sltCartera").append("<option value='0'>-SELECCIONA-</option>");
    $.each(jsondata.d, function (i, obj) {
      //  $("#sltCartera").append("<option value='" + obj.value + "'>" + obj.key + "</option>"); // 21.06.19
      borrarRetirados("#sltCartera",obj); // 21.06.19
    });
    //console.log(jsondata.d);
}
});
}

function cargarSubCarteras() {
$.ajax({
url: strServicio + "cargarSubCarteras.php",
data: '{"CAR_CODIGO":"' + $("#sltCartera").val() + '"}',
dataType: 'JSON',
type: 'POST',
contentType: "application/json; charset=utf-8",
success: function (jsondata) {
    $("#sltSubCartera").empty();
    $("#sltSubCartera").append("<option value='0'>-SELECCIONA-</option>");
    $.each(jsondata.d, function (i, obj) {
      //  $("#sltSubCartera").append("<option value='" + obj.value + "'>" + obj.key + "</option>"); // 21.06.19
       borrarRetirados("#sltSubCartera",obj); // 21.06.19
    });
    //console.log(jsondata.d);
}
});
} 
function listarResumenCuentas() {
    $.ajax({
        url: strServicio + "cartera.php?CONSULTA_AJAX=listarResumenCuentas",
        dataType: 'JSON',
        type: 'POST',
        contentType: "application/json; charset=utf-8",
        success: function (jsondata) {
            $("#tblResumenCuentas tbody").empty();
            $.each(jsondata.d, function (i, obj) {
                var htmlText = "<tr>" +
                        "<td>" + (i + 1) + "</td>" +
                        "<td>" + obj.PRV_NOMBRES + "</td>" +
                        "<td>" + obj.CAR_DESCRIPCION + "</td>" +
                        "<td>" + obj.SCA_DESCRIPCION + "</td>" +
                        "<td>" + obj.CANT_CUENTAS + "</td>" +
                        "<td>" + obj.CANT_CLIENTES + "</td>" +
                    "</tr>";
                $("#tblResumenCuentas tbody").append(htmlText);
            });
        }
    });
}
</script>
Final;

//llamamao a la plantilla principal
require_once $url_relativa.'resource/masterPage/master.php';

 ?>
