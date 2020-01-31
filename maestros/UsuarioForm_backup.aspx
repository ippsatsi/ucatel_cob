<%@ Page Title="" Language="C#" MasterPageFile="~/resource/masterPage/Template.Master" AutoEventWireup="true" CodeBehind="UsuarioForm.aspx.cs" Inherits="WEB.maestros.UsuarioForm" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href='<%=ResolveClientUrl("~/resource/assets/global/plugins/datatables/datatables.min.css") %>' rel="stylesheet" type="text/css" />
    <link href='<%=ResolveClientUrl("~/resource/assets/global/plugins/datatables/plugins/bootstrap/datatables.bootstrap.css") %>' rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contenido" runat="server">
    <div class="form-horizontal" role="form" id="div_contenido">
        
        <input type="hidden" id="txtCodigo" class="form-control" readonly="true" value="0"/>
        <div class="form-group">
            <label for="txtDni" class="col-md-2 control-label">DNI</label>
            <div class="col-md-4">
                <input type="text" id="txtDni" class="form-control"/>
            </div>
        </div>
        <div class="form-group">
            <label for="txtNombres" class="col-md-2 control-label">NOMBRE</label>
            <div class="col-md-4">
                <input type="text" id="txtNombres" class="form-control"/>
            </div>
        </div>
        <div class="form-group">
            <label for="txtPaterno" class="col-md-2 control-label">APELLIDO PATERNO</label>
            <div class="col-md-4">
                <input type="text" id="txtPaterno" class="form-control"/>
            </div>
        </div>
        <div class="form-group">
            <label for="txtMaterno" class="col-md-2 control-label">APELLIDO MATERNO</label>
            <div class="col-md-4">
                <input type="text" id="txtMaterno" class="form-control"/>
            </div>
        </div>
        <div class="form-group">
            <label for="txtNacimiento" class="col-md-2 control-label">F. NACIMIENTO</label>
            <div class="col-md-4">
                <input type="text" id="txtNacimiento" class="form-control date-picker"/>
            </div>
        </div>
        <div class="form-group">
            <label for="txtDireccion" class="col-md-2 control-label">DIRECCIÓN</label>
            <div class="col-md-4">
                <input type="text" id="txtDireccion" class="form-control"/>
            </div>
        </div>
        <div class="form-group">
            <label for="sltDepartamento" class="col-md-2 control-label">DEPARTAMENTO</label>
            <div class="col-md-4">
                <select id="sltDepartamento" class="form-control">
                    <option value="0">-SELECT-</option>
                </select>
            </div>
        </div>

        <div class="form-group">
            <label for="sltProvincia" class="col-md-2 control-label">PROVINCIA</label>
            <div class="col-md-4">
                <select id="sltProvincia" class="form-control">
                    <option value="0">-SELECT-</option>
                </select>
            </div>
        </div>
        <div class="form-group">
            <label for="sltDistrito" class="col-md-2 control-label">DISTRITO</label>
            <div class="col-md-4">
                <select id="sltDistrito" class="form-control">
                    <option value="0">-SELECT-</option>
                </select>
            </div>
        </div>
        <div class="form-group">
            <label for="txtCorreo" class="col-md-2 control-label">CORREO</label>
            <div class="col-md-4">
                <input type="text" id="txtCorreo" class="form-control"/>
            </div>
        </div>
        <div class="form-group">
            <label for="txtUsuario" class="col-md-2 control-label">USUARIO</label>
            <div class="col-md-4">
                <input type="text" id="txtUsuario" class="form-control"/>
            </div>
        </div>
        <div class="form-group">
            <label for="txtClave" class="col-md-2 control-label">CLAVE</label>
            <div class="col-md-4">
                <input type="password" id="txtClave" class="form-control"/>
            </div>
        </div>
        <div class="form-group">
            <label for="sltRol" class="col-md-2 control-label">ROL</label>
            <div class="col-md-4">
                <select id="sltRol" class="form-control"></select>
            </div>
        </div>

        <div class="form-group">
            <label for="sltRol" class="col-md-2 control-label">ESTADO</label>
            <div class="col-md-4">
                <select id="sltEstado" class="form-control">
                    <option value="A">ACTIVO</option>
                    <option value="I">INACTIVO</option>
                </select>
            </div>
        </div>

        <div class="form-group">
            <div class="col-md-offset-2 col-md-10">
                <button type="button" id="btnGuardar" class="btn blue">GUARDAR</button>
                <button type="button" id="btnNuevo" class="btn blue">NUEVO</button>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">

            <div class="portlet box blue">
                <div class="portlet-title">
                    <div class="caption">
                        <i class="fa fa-globe"></i> Lista de usuarios </div>
                    <div class="tools"> </div>
                </div>
                <div class="portlet-body">

                    <div class="row">
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 margin-bottom-20">
                            <div class="col-md-3">
                                <label>CRITERIO</label>
                                <select id="sltCriterio" class="form-control">
                                    <option value="0">-SELECT-</option>
                                    <option value="1">DNI</option>
                                    <option value="2">USUARIO</option>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <label>BÚSQUEDA</label>
                                <input type="text" id="txtTexto" class="form-control"/>
                            </div>

                            <div class="col-md-3">
                                <label>&nbsp;</label>
                                <a id="btn_buscar" class="btn_buscar form-control btn blue">BUSCAR</a>
                            </div>
                        </div>
                    </div>

                    <table id="tblLista" class="tblLista_grid tblLista_grid table table-striped table-bordered table-hover dt-responsive" cellspacing="0" width="100%">
                        <thead>
                            <tr>
                                <th class="all">Código</th>
                                <th class="min-rol">Rol</th>
                                <th class="min-dni">DNI</th>
                                <th class="min-nombre">Nombres</th>
                                <th class="min-nacimiento">F. de nacimiento</th>
                                <th class="min-direccion">Dirección</th>
                                <th class="min-correo">Correo</th>
                                <th class="min-usuario">Usuario</th>
                                <th class="min-estado">Estado</th>
                                <th class="min-editar">Editar</th>
                            </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
 
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="server">
    
    <script src='<%=ResolveClientUrl("~/resource/assets/global/scripts/datatable.js")%>' type="text/javascript"></script>
    <script src='<%=ResolveClientUrl("~/resource/assets/global/plugins/datatables/datatables.min.js")%>' type="text/javascript"></script>
    <script src='<%=ResolveClientUrl("~/resource/assets/global/plugins/datatables/plugins/bootstrap/datatables.bootstrap.js")%>' type="text/javascript"></script>

    <script>
        $(document).ready(function () {

            listarDepartamento();
            listarRol();

            $(".date-picker").datepicker({
                format: "dd/mm/yyyy"
            });

            $("#btnNuevo").click(function () {
                $("#txtCodigo").val("0");
                $("#txtDni").val("");
                $("#txtNombres").val("");
                $("#txtPaterno").val("");
                $("#txtMaterno").val("");
                $("#txtNacimiento").val("");
                $("#txtDireccion").val("");
                $("#sltDepartamento").val("0");
                $("#sltProvincia").val("0");
                $("#sltDistrito").val("0");
                $("#txtCorreo").val("");
                $("#txtUsuario").val("");
                $("#txtClave").val("");
                $("#sltEstado").val("A");
                $("#sltRol").val("0");
            });

            $("#btnGuardar").click(function () {
                if ($.trim($("#txtDni").val()).length != 8) {
                    bootbox.alert("Ingrese el DNI de 8 digitos.");
                    $("#txtDni").focus();
                    return;
                }
                if ($.trim($("#txtNombres").val()).length == 0) {
                    bootbox.alert("Ingrese el Nombre");
                    $("#txtNombres").focus();
                    return;
                }
                if ($.trim($("#txtPaterno").val()).length == 0) {
                    bootbox.alert("Ingrese el Apellido Paterno");
                    $("#txtPaterno").focus();
                    return;
                }
                if ($.trim($("#txtMaterno").val()).length == 0) {
                    bootbox.alert("Ingrese el Apellido Materno");
                    $("#txtMaterno").focus();
                    return;
                }
                if ($.trim($("#txtNacimiento").val()).length == 0) {
                    bootbox.alert("Ingrese la Fecha de Nacimiento");
                    $("#txtNacimiento").focus();
                    return;
                }
                if ($.trim($("#txtDireccion").val()).length == 0) {
                    bootbox.alert("Ingrese la Dirección");
                    $("#txtDireccion").focus();
                    return;
                }
                if ($("#sltDepartamento").val() == "0") {
                    bootbox.alert("Ingrese el Departamento");
                    $("#sltDepartamento").focus();
                    return;
                }
                if ($("#sltProvincia").val() == "0") {
                    bootbox.alert("Ingrese la Provincia");
                    $("#sltProvincia").focus();
                    return;
                }
                if ($("#sltDistrito").val() == "0") {
                    bootbox.alert("Ingrese la Provincia");
                    $("#sltDistrito").focus();
                    return;
                }
                if ($.trim($("#txtCorreo").val()).length == 0) {
                    bootbox.alert("Ingrese el Correo");
                    $("#txtCorreo").focus();
                    return;
                }
                if ($.trim($("#txtUsuario").val()).length == 0) {
                    bootbox.alert("Ingrese el Usuario");
                    $("#txtUsuario").focus();
                    return;
                }
                if ($.trim($("#txtClave").val()).length == 0) {
                    bootbox.alert("Ingrese la Clave");
                    $("#txtClave").focus();
                    return;
                }
                if ($("#sltRol").val() == "0") {
                    bootbox.alert("Ingrese el Rol");
                    $("#sltRol").focus();
                    return;
                }
                if ($("#sltEstado").val() == "0") {
                    bootbox.alert("Ingrese el Estado");
                    $("#sltEstado").focus();
                    return;
                }
                abrir_preload('div_contenido');
                var usuario = new Object();
                usuario.USU_CODIGO = $("#txtCodigo").val();
                usuario.USU_DOCUMENTO_IDENTIDAD = $("#txtDni").val();
                usuario.USU_NOMBRES = $("#txtNombres").val();
                usuario.USU_APELLIDO_PATERNO = $("#txtPaterno").val();
                usuario.USU_APELLIDO_MATERNO = $("#txtMaterno").val();
                usuario.USU_FECHA_NACIMIENTO = $("#txtNacimiento").val();
                usuario.USU_DIRECCION_DOMICILIO = $("#txtDireccion").val();
                usuario.UBI_CODIGO = $("#sltDistrito").val();
                usuario.USU_CORREO_ELECTRONICO = $("#txtCorreo").val();
                usuario.USU_LOGIN = $("#txtUsuario").val();
                usuario.USU_CLAVE = $("#txtClave").val();
                usuario.USU_ESTADO_REGISTRO = $("#sltEstado").val();
                usuario.USU_ROL = $("#sltRol").val();
                $.ajax({
                    url: strServicio+"GestionarUsuarios.asmx/registrar",
                    data: '{"usuario":' + JSON.stringify(usuario) + '}',
                    dataType: 'JSON',
                    type: 'POST',
                    contentType: "application/json; charset=utf-8",
                    success: function (jsondata) {
                        cerrar_preload('div_contenido');
                        if (jsondata.d == "CORRECTO") {
                            bootbox.alert("Registrado correctamente.");
                            buscar();
                        } else {
                            bootbox.alert("Ocurrio un error, por favor vuelva a intentar registrar.");
                        }
                    }
                });
            });

            $("#btn_buscar").click(function () {
                buscar();
            });
        });

        function buscar() {
            abrir_preload('div_contenido');
            $.ajax({
                url: strServicio+"GestionarUsuarios.asmx/listarUsuariosCriterio",
                data: '{"criterio":"' + $("#sltCriterio").val() + '","texto":"' + $("#txtTexto").val() + '"}',
                dataType: 'JSON',
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                success: function (jsondata) {
                    cerrar_preload('div_contenido');
                    $("#tblLista tbody").empty();
                    var htmlText = "";
                    $.each(jsondata.d, function (i, obj) {
                        htmlText = "<tr>" +
                                "<td>" + obj.USU_CODIGO + "</td>" +
                                "<td>" + obj.USU_ROL + "</td>" +
                                "<td>" + obj.USU_CLAVE + "</td>" +
                                "<td>" + obj.USU_NOMBRES + "</td>" +
                                "<td>" + obj.USU_FECHA_NACIMIENTO + "</td>" +
                                "<td>" + obj.USU_DIRECCION_DOMICILIO + "</td>" +
                                "<td>" + obj.USU_CORREO_ELECTRONICO + "</td>" +
                                "<td>" + obj.USU_LOGIN + "</td>" +
                                "<td>" + obj.USU_ESTADO_REGISTRO + "</td>" +
                                "<td><a href='#' onclick='editar(" + obj.USU_CODIGO + ")'>Editar</a></td>" +
                            "</tr>";
                        $("#tblLista tbody").append(htmlText);
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
                url: strServicio+"general.asmx/listarDepartamento",
                dataType: 'JSON',
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
                url: strServicio+"general.asmx/listarProvincia",
                data: '{"objUbigeo":' + JSON.stringify(objUbigeo) + '}',
                dataType: 'JSON',
                type: 'POST',
                async: false,
                contentType: "application/json; charset=utf-8",
                success: function (jsondata) {
                    //console.table(jsondata.d);
                    $("#sltProvincia").empty();
                    $("#sltProvincia").html("<option value='0'>-SELECT-</option>");
                    $.each(jsondata.d, function (i, obj) {
                        $("#sltProvincia").append("<option value='" + obj.value + "'>" + obj.key + "</option>");
                    });
                }
            });
        }

        function editar(codigo) {
            abrir_preload('div_contenido');
            $.ajax({
                url: strServicio+"GestionarUsuarios.asmx/obtenerUsuarioId",
                data: "{'codigo':'"+codigo+"'}",
                dataType: 'JSON',
                type: 'POST',
                async: false,
                contentType: "application/json; charset=utf-8",
                success: function (jsondata) {
                    cerrar_preload('div_contenido');
                    console.table(jsondata.d);
                    $("#txtCodigo").val(jsondata.d.USU_CODIGO);
                    $("#txtDni").val(jsondata.d.USU_DOCUMENTO_IDENTIDAD);
                    $("#txtNombres").val(jsondata.d.USU_NOMBRES);
                    $("#txtPaterno").val(jsondata.d.USU_APELLIDO_PATERNO);
                    $("#txtMaterno").val(jsondata.d.USU_APELLIDO_MATERNO);
                    $("#txtNacimiento").val(jsondata.d.USU_FECHA_NACIMIENTO);
                    $("#txtDireccion").val(jsondata.d.USU_DIRECCION_DOMICILIO);
                    //bootbox.alert(jsondata.d.UBI_CODIGO);
                    //bootbox.alert(jsondata.d.UBI_CODIGO.substring(0, 2));
                    //bootbox.alert(jsondata.d.UBI_CODIGO.substring(0, 4));
                    $("#sltDepartamento").val(jsondata.d.UBI_CODIGO.substring(0, 2));
                    $("#sltDepartamento").change();
                    $("#sltProvincia").val(jsondata.d.UBI_CODIGO.substring(2, 4));
                    $("#sltProvincia").change();
                    $("#sltDistrito").val(jsondata.d.UBI_CODIGO);  
                    //$("#sltProvincia").val(jsondata.d.UBI_CODIGO);
                    $("#txtCorreo").val(jsondata.d.USU_CORREO_ELECTRONICO);
                    $("#txtUsuario").val(jsondata.d.USU_LOGIN);
                    $("#txtClave").val(jsondata.d.USU_CLAVE);
                    $("#sltEstado").val(jsondata.d.USU_ESTADO_REGISTRO);
                    $("#sltRol").val(jsondata.d.USU_ROL);
                }
            });
        }

        function listarDistrito(idDepartamento, idProvincia) {
            var objUbigeo = new Object();
            objUbigeo.UBI_CODIGO_DEPARTAMENTO = idDepartamento;
            objUbigeo.UBI_CODIGO_PROVINCIA = idProvincia;
            $.ajax({
                url: strServicio+"general.asmx/listarDistrito",
                data: '{"objUbigeo":' + JSON.stringify(objUbigeo) + '}',
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


        function listarRol() {
            $.ajax({
                url: strServicio+"general.asmx/listarRol",
                dataType: 'JSON',
                type: 'POST',
                async: false,
                contentType: "application/json; charset=utf-8",
                success: function (jsondata) {
                    //console.table(jsondata.d);
                    //$("#sltDepartamento").empty();
                    $.each(jsondata.d, function (i, obj) {
                        $("#sltRol").append("<option value='" + obj.value + "'>" + obj.key + "</option>");
                    });
                }
            });
        }
    </script>
</asp:Content>
