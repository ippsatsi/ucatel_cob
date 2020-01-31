<%@ Page Title="" Language="C#" MasterPageFile="~/resource/masterPage/Template.Master" AutoEventWireup="true" CodeBehind="registro_cabecera.aspx.cs" Inherits="WEB.carga.registro_cabecera" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contenido" runat="server">
    <div class="row">
        <div class="col-md-12">
            <div class="portlet box blue">
                <div class="portlet-title">
                    <div class="caption">
                        <i class="fa fa-globe"></i> Registro de Cabecera </div>
                    <div class="tools"> </div>
                </div>
            </div>
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
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 margin-bottom-20">
                    <div class="col-md-6">
                        <label>ARCHIVO</label>
                        <input type="file" id="fl_archivo" class="form-control"/>
                    </div>
                    <div class="col-md-6">
                        <label>&nbsp;&nbsp;&nbsp;</label>
                        <input type="button" id="btn_registrar" value="REGISTRAR"  class="form-control btn blue btn_buscar"/>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 margin-bottom-20">
                    <span id="txtProgreso"></span>
                </div>
            </div>
        </div>
    </div>
    <div id="div_contenido" class="clearfix">
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="server">
    <script type="text/javascript">
        var html_columnas = "";

        $(document).ready(function () {
            cargarProveedor();
            cargarColumnas();
            $("#sltProveedor").change(cargarCarteras);
            $("#sltCartera").change(cargarSubCarteras);
            $("#btn_registrar").click(registrar);
        });

        function registrar() {
            var sca_codigo = $("#sltSubCartera").val();

            var lista = new Array();
            var obj = null;
            $(".cabeceras").each(function () {
                var codigo = $(this).attr('id').replace('txt_', '');
                //if ($.trim($(this).val()).length > 0) {
                obj = new Object();
                obj.MEM_CODIGO = 0;
                obj.SCA_CODIGO = sca_codigo;
                obj.CAMPO = codigo;
                obj.NOMBRE_HTML = $(this).val();
                obj.INDICE = ($("#slt_" + codigo).val() == "0" ? "0" : $("#slt_" + codigo).val().split("|").pop());
                obj.ELIMINAR = ($("#chk_eli_" + codigo).is(":checked")?true:false);
                obj.DESCRIPCION = "";
                lista.push(obj);
                //}
            });
            $.ajax({
                url: strServicio+"memoria.asmx/registrar",
                data: '{"lista":' + JSON.stringify(lista) + '}',
                dataType: 'JSON',
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                success: function (jsondata) {
                    if (jsondata.d == 'CORRECTO') {
                        bootbox.alert("ASIGNACIÓN REALIZADA CORRECTAMENTE");

                    } else {
                        bootbox.alert("ERROR DE ASIGNACION");
                    }
                }
            });
        }

        $("#fl_archivo").change(function (e) {
            var fileName = e.target.files[0];

            if (fileName.name.split('.').pop().toLowerCase() != "txt" &&
                fileName.name.split('.').pop().toLowerCase() != "csv") {
                bootbox.alert("USTED NO SELECCIONO EL FORMATO INDICADO");
                $(this).val("");
                return false;
            }

            var formData = new FormData();
            var files = $("#fl_archivo").get(0).files;
            //formData.append("Proveedor", $("#sltProveedor").val());
            //formData.append("Cartera", $("#sltCartera").val());
            formData.append("UploadFile", files[0]);

            $.ajax({
                url: "../resource/carga/carga_verificacion.ashx",
                type: 'POST',
                beforeSend: function () {
                    $("#txtProgreso").html("CARGANDO..");
                },
                uploadProgress: function (event, position, total, percentComplete) {
                    $("#txtProgreso").html(percentComplete + '%');
                },
                success: function () {
                    $("#txtProgreso").html('100%');
                },
                complete: function (response) {
                    $("#div_contenido").empty();

                    if (response.responseText.split("|")[0] == "ERROR") {
                        bootbox.alert("Carga realizada incorrectamente");
                    } else {
                        var datos_array = response.responseText.split("-*-");
                        var cabecera = datos_array[0];
                        //var contador = 0;

                        var cabecera_length = cabecera.split(";").length;
                        var filas = cabecera.split(";");
                        var columnas = datos_array.length;
                        for (var x = 0; x < cabecera_length ; x++) {
                            var nombre_col = $.trim(filas[x]);

                            var html_opc = "";
                            for (var y = 1; y < columnas; y++) {
                                html_opc += "<tr><td>" + datos_array[y].split(";")[x].substring(0, 20); + "</td></tr>";
                            }

                            var html_div = "<div style='border:1px solid white; padding:20px; width:280px; height: 450px; float:left;background-color: #3598dc;'>" +
                                "<b style='color:white;'>" + nombre_col + "</b><br /><span style='color:white;'>DESCRIPCIÓN COLUMNA</span><br />" +
                                "<input type='text' class='cabeceras form-control' id='txt_" + nombre_col.replace(' ', '_').replace(' ', '_').replace(' ', '_').replace('.', '').replace('.', '').replace('#', '').replace('#', '') + "' style='width:180px;'/><br />" +
                                "<b style='color:white;'>COLUMNA DEL SISTEMA</b>" +
                                "<select class='form-control' id='slt_" + nombre_col.replace(' ', '_').replace(' ', '_').replace(' ', '_').replace('.', '').replace('.', '').replace('#', '').replace('#', '') + "'>" +
                                    "<option value='0'>-Seleccione-</option>" +
                                    html_columnas +
                                "</select><br />" +
                                "<table class='table table-striped table-bordered table-hover' id='tbl_" + nombre_col.replace(' ', '_').replace(' ', '_').replace(' ', '_').replace('.', '').replace('.', '').replace('#', '').replace('#', '') + "' style='width: 100%;font-size: 13px;background-color: #f5f5f5;'>" +
                                    "<tr><th>DATOS</th></tr>" +
                                    html_opc +
                                "</table>" +
                                "<input type='checkbox' id='chk_eli_" + nombre_col.replace(' ', '_').replace(' ', '_').replace(' ', '_').replace('.', '').replace('.', '').replace('#', '').replace('#', '') + "'/><b style='color:white;'> ELIMINAR<b/>" +
                            "</div>";

                            $("#div_contenido").append(html_div);
                        }

                        bootbox.alert("Carga realizada correctamente");
                    }
                },
                error: function () {
                    bootbox.alert("Ocurrio un error, por favor vuelva a intentar cargar el documento.", "MENSAJE DE CARGA DE DOCUMENTOS");
                },
                data: formData,
                cache: false,
                contentType: false,
                processData: false
            });
        });

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
                url: strServicio+"general.asmx/cargarProveedor",
                dataType: 'JSON',
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                success: function (jsondata) {
                    //$("#sltProveedor").empty();
                    $.each(jsondata.d, function (i, obj) {
                       // $("#sltProveedor").append("<option value='" + obj.value + "'>" + obj.key + "</option>"); //11.09.19
                       borrarRetirados("#sltProveedor",obj); // 11.09.19
                    });
                }
            });
        }



        function cargarCarteras() {
            $.ajax({
                url: strServicio+"general.asmx/cargarCarteras",
                data: '{"PRV_CODIGO":"' + $("#sltProveedor").val() + '"}',
                dataType: 'JSON',
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                success: function (jsondata) {
                    $("#sltCartera").empty();
                    $("#sltCartera").append("<option value='0'>-SELECCIONA-</option>");
                    $.each(jsondata.d, function (i, obj) {
                        // $("#sltCartera").append("<option value='" + obj.value + "'>" + obj.key + "</option>"); //11.09.19
                        borrarRetirados("#sltCartera",obj); // 11.09.19
                    });
                }
            });
        }

        function cargarSubCarteras() {
            $.ajax({
                url: strServicio+"general.asmx/cargarSubCarteras",
                data: '{"CAR_CODIGO":"' + $("#sltCartera").val() + '"}',
                dataType: 'JSON',
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                success: function (jsondata) {
                    $("#sltSubCartera").empty();
                    $("#sltSubCartera").append("<option value='0'>-SELECCIONA-</option>");
                    $.each(jsondata.d, function (i, obj) {
                        // $("#sltSubCartera").append("<option value='" + obj.value + "'>" + obj.key + "</option>"); //11.09.19
                        borrarRetirados("#sltSubCartera",obj); // 11.09.19
                    });
                    //buscarCarga();
                }
            });
        }

        function cargarColumnas() {
            $.ajax({
                url: strServicio+"general.asmx/cargarMemoriaCol",
                dataType: 'JSON',
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                success: function (jsondata) {
                    $.each(jsondata.d, function (i, obj) {
                        html_columnas += "<option value='" + obj.value + "'>" + obj.key + "</option>";
                    });
                }
            });
        }
    </script>
</asp:Content>
