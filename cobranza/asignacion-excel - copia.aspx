<%@ Page Title="" Language="C#" MasterPageFile="~/resource/masterPage/Template.Master" AutoEventWireup="true" CodeBehind="asignacion-excel.aspx.cs" Inherits="WEB.cobranza.asignacion_excel" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contenido" runat="server">
    <div class="row" id="div_contenido">
        <div class="col-md-12">
            <div class="portlet box blue">
                <div class="portlet-title">
                    <div class="caption">
                        <i class="fa fa-globe"></i> ASIGNACION DE CUENTAS</div>
                    <div class="tools"> </div>
                </div>
                <div class="portlet-body">
                    <div class="row">
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 margin-bottom-20">
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
                            <div class="col-md-5">
                                <label>CARGAR ARCHIVO (.TXT, .CSV)</label>
                                <input type="file" id="file_upload" class="form-control"/>
                                <span id="txtProgreso"></span>
                            </div>
                            
                            <div class="col-md-3">
                                <div><label>&nbsp;</label></div>
                                <a class="btn_buscar btn btn blue form-control" id="btn_cargar">CARGAR</a>
                            </div>
                            <div class="col-md-4">
                                <label>&nbsp;</label>
                                <a class="btn blue form-control" href="../resource/carga/excel/CARGA_USUARIOS.xlsx"><i class="fa fa-file-excel-o"></i> DESCARGAR ASIGNACIÓN</a>
                            </div>
                        </div>
                    </div>

                    <div class="row" id="divErrores" style="display:none;">
                        <h3>Errores de Asignación</h3>
                        <table id="tblErrores" class="tblLista table table-striped table-bordered table-hover dt-responsive" cellspacing="0">
                            <thead>
                                <tr>
                                    <th>ITEM</th>
                                    <th>CUENTA</th>
                                    <th>RESPONSABLE</th>
                                    <th>CALL</th>
                                    <th>CAMPO</th>
                                    <th>ERROR</th>
                                    <%--<th></th>--%>
                                </tr>
                            </thead>
                            <tbody></tbody>
                        </table>
                    </div>

                    <div class="row" id="divAsignacion">
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 margin-bottom-20">
                        <h4>ASIGNACIONES CALL</h4>
                        <table id="tblListaCall" class="tblLista table table-striped table-bordered table-hover dt-responsive" cellspacing="0" width="100%">
                            <thead>
                                <tr>
                                    <th>PERFIL</th>
                                    <th>USUARIO</th>
                                    <th>CUENTAS</th>
                                    <th>LIBERAR</th>
                                </tr>
                            </thead>
                            <tbody></tbody>
                        </table>
                        <br />
                        <h4>ASIGNACIONES CAMPO</h4>
                        <table id="tblListaCampo" class="tblLista table table-striped table-bordered table-hover dt-responsive" cellspacing="0" width="100%">
                            <thead>
                                <tr>
                                    <th>PERFIL</th>
                                    <th>USUARIO</th>
                                    <th>CUENTAS</th>
                                    <th>LIBERAR</th>
                                </tr>
                            </thead>
                            <tbody></tbody>
                        </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            cargarUsuariosCall();
            cargarUsuariosCampo();
            cargarProveedor();

            $("#sltProveedor").change(cargarCarteras);
            $("#sltCartera").change(cargarSubCarteras);
        });

        $(document).on("click", "#btn_cargar", function (event) {
            if ($("#sltProveedor").val() == "0") {
                bootbox.alert("Usted no selecciono el proveedor");
                return false;
            }
            if ($("#sltCartera").val() == "0") {
                bootbox.alert("Usted no selecciono la cartera");
                return false;
            }
            if ($("#sltSubCartera").val() == "0") {
                bootbox.alert("Usted no selecciono la sub cartera");
                return false;
            }

            abrir_preload('div_contenido');
            var formData = new FormData();
            var files = $("#file_upload").get(0).files;
            if (files[0].type != "application/vnd.ms-excel" &&
                files[0].type != "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet") {
                bootbox.alert("Solo se aceptan formatos EXCEL");
                return false;
            }
            formData.append("UploadFile", files[0]);

            $.ajax({
                url: "../resource/carga/carga_archivo.ashx",
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
                    cerrar_preload('div_contenido');
                    if (response.responseText == "ERROR") {
                        bootbox.alert("Ocurrio un error, por favor vuelva a intentar cargar el documento.", "MENSAJE DE CARGA DE DOCUMENTOS");
                    } else if (response.responseText == "CORRECTO") {
                        $("#txtProgreso").html('100%');
                        obtenerTablaErrores();
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

        function obtenerTablaErrores() {
            abrir_preload('div_contenido');
            $.ajax({
                url: strServicio + "cartera.asmx/obtenerTablaErrores",
                data: "{'id_sub_cartera':"+$("#sltSubCartera").val()+"}",
                dataType: 'JSON',
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                async: false,
                success: function (jsondata) {
                    cerrar_preload('div_contenido');
                    var htmlText = "";
                    $("#tblErrores tbody").empty();
                    if (jsondata.d.length > 0) {
                        $("#divErrores").show();
                        //$("#divAsignacion").hide();
                        cargarUsuariosCall();
                        cargarUsuariosCampo();
                        $.each(jsondata.d, function (i, obj) {
                            htmlText = "<tr>" +
                            "<td>" + (i + 1) + "</td>" +
                            "<td>" + obj.NROCUENTA + "</td>" +
                            "<td>" + obj.RESPONSABLE + "</td>" +
                            "<td>" + obj.CALL + "</td>" +
                            "<td>" + obj.CAMPO + "</td>" +
                            "<td>" + obj.ERROR + "</td>" +
                            //"<td><input type='button' id='btn_lib_indi_" + i + "' onclick='fncLiberarIndividual(" + i + "," + obj.ID_CUENTA + "," + obj.ID_USU_ASIGNADO + ")' value='Liberar'/></td>" +
                                "</tr>";
                            $("#tblErrores tbody").append(htmlText);
                        });
                        bootbox.alert("Se encontro errores en la carga.");
                    } else {
                        //iniciarDatos(); 
                        cargarUsuariosCall();
                        cargarUsuariosCampo();
                        $("#divAsignacion").show();
                        $("#divErrores").hide();
                        bootbox.alert("Registro realizado correctamente");
                    }
                }
            });
        }

        function fncLiberarIndividual(cod, cod_cuenta, usu_asignado) {
            $.ajax({
                url: strServicio+"cartera.asmx/liberarUsuarioIndividual",
                data: '{"cod_cuenta":"' + cod_cuenta + '","usu_asignado":' + usu_asignado + '}',
                dataType: 'JSON',
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                success: function (jsondata) {
                    if (jsondata.d == "SUCCESS") {
                        bootbox.alert("Cuenta liberada correctamente");
                        $("#btn_lib_indi_" + cod).hide();
                    }
                }
            });
        }

        function cargarUsuariosCall() {
            $.ajax({
                url: strServicio+"cartera.asmx/listarCuentasCall",
                dataType: 'JSON',
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                success: function (jsondata) {
                    var htmlText = "";
                    $("#tblListaCall tbody").empty();
                    $.each(jsondata.d, function (i, obj) {
                        htmlText = "<tr>" +
                            "<td>" + obj.USU_ROL + "</td>" +
                            "<td>" + obj.USU_LOGIN + "</td>" +
                            "<td>" + obj.CANT_CUENTAS + "</td>" +
                            "<td>" + (obj.CANT_CUENTAS > 0 ? "<input type='button' onclick='fncLiberar(\"C\"," + obj.USU_CODIGO + ")' value='Liberar'/>" : "") + "</td>" +
                            "</tr>";
                        $("#tblListaCall tbody").append(htmlText);
                    });
                }
            });
        }

        function cargarUsuariosCampo() {
            $.ajax({
                url: strServicio+"cartera.asmx/listarCuentasCampo",
                dataType: 'JSON',
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                success: function (jsondata) {
                    var htmlText = "";
                    $("#tblListaCampo tbody").empty();
                    $.each(jsondata.d, function (i, obj) {
                        htmlText = "<tr>" +
                            "<td>" + obj.USU_ROL + "</td>" +
                            "<td>" + obj.USU_LOGIN + "</td>" +
                            "<td>" + obj.CANT_CUENTAS + "</td>" +
                            "<td>" + (obj.CANT_CUENTAS > 0 ? "<input type='button' onclick='fncLiberar(\"P\"," + obj.USU_CODIGO + ")' value='Liberar'/>" : "") + "</td>" +
                            "</tr>";
                        $("#tblListaCampo tbody").append(htmlText);
                    });
                }
            });
        }

        function fncLiberar(tipo, codigo) {
            $.ajax({
                url: strServicio+"cartera.asmx/liberarUsuario",
                data: '{"tipo":"' + tipo + '","codigo":' + codigo + '}',
                dataType: 'JSON',
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                success: function (jsondata) {
                    if (jsondata.d == "SUCCESS") {
                        if (tipo = "C") {
                            cargarUsuariosCall();
                        } else if (tipo = "P") {
                            cargarUsuariosCampo();
                        }
                    }
                }
            });
            //bootbox.alert(codigo);
        }

        function cargarProveedor() {
            $.ajax({
                url: strServicio + "general.asmx/cargarProveedor",
                dataType: 'JSON',
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                success: function (jsondata) {
                    //$("#sltProveedor").empty();
                    $.each(jsondata.d, function (i, obj) {
                        $("#sltProveedor").append("<option value='" + obj.value + "'>" + obj.key + "</option>");
                    });
                }
            });
        }

        function cargarCarteras() {
            $.ajax({
                url: strServicio + "general.asmx/cargarCarteras",
                data: '{"PRV_CODIGO":"' + $("#sltProveedor").val() + '"}',
                dataType: 'JSON',
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                success: function (jsondata) {
                    $("#sltCartera").empty();
                    $("#sltCartera").append("<option value='0'>-SELECCIONA-</option>");
                    $.each(jsondata.d, function (i, obj) {
                        $("#sltCartera").append("<option value='" + obj.value + "'>" + obj.key + "</option>");
                    });
                }
            });
        }

        function cargarSubCarteras() {
            $.ajax({
                url: strServicio + "general.asmx/cargarSubCarteras",
                data: '{"CAR_CODIGO":"' + $("#sltCartera").val() + '"}',
                dataType: 'JSON',
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                success: function (jsondata) {
                    $("#sltSubCartera").empty();
                    $("#sltSubCartera").append("<option value='0'>-SELECCIONA-</option>");
                    $.each(jsondata.d, function (i, obj) {
                        $("#sltSubCartera").append("<option value='" + obj.value + "'>" + obj.key + "</option>");
                    });
                    //buscarCarga();
                }
            });
        }
    </script>
</asp:Content>
