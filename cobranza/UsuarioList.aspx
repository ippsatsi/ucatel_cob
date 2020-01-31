<%@ Page Title="" Language="C#" MasterPageFile="~/resource/masterPage/Template.Master" AutoEventWireup="true" CodeBehind="UsuarioForm.aspx.cs" Inherits="WEB.maestros.UsuarioForm" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href='<%=ResolveClientUrl("~/resource/assets/global/plugins/datatables/datatables.min.css") %>' rel="stylesheet" type="text/css" />
    <link href='<%=ResolveClientUrl("~/resource/assets/global/plugins/datatables/plugins/bootstrap/datatables.bootstrap.css") %>' rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contenido" runat="server">



    <div class="row">
        <div class="col-md-12">

            <div class="portlet box blue">
                <div class="portlet-title">
                    <div class="caption">
                        <i class="fa fa-globe"></i> Lista de usuarios </div>
                    <div class="tools"> </div>
                </div>
                <div class="portlet-body">


                    <table id="tblLista" class="tblLista_grid tblLista_grid table table-striped table-bordered table-hover dt-responsive" cellspacing="0" width="100%">
                        <thead>
                            <tr>
                                <th class="all">Código</th>
                                <th class="min-rol">Rol</th>
                                <th class="min-dni">DNI</th>
                                <th class="min-nombre">Nombres</th>
                                <th class="min-nacimiento">Alta</th> <!-- listado anexos - 19072019 -->
                            <!--    <th class="min-direccion">Baja</th> --> <!-- listado anexos - 19072019 -->
                                <th class="min-correo">Anexo</th>  <!-- listado anexos - 19072019 -->
                                <th class="min-usuario">Usuario</th>
                                <th class="min-estado">Estado</th>
                        <!--        <th class="min-editar">Editar</th> -->
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


                buscar();

        });

        function buscar() {
            abrir_preload('div_contenido');
            $.ajax({
                url: strServicio+"GestionarUsuarios.asmx/listarUsuariosCriterio",
                data: '{"criterio":"7","texto":""}',
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
                              //  "<td>" + obj.USU_DIRECCION_DOMICILIO + "</td>" +
                                "<td>" + obj.USU_CORREO_ELECTRONICO + "</td>" +
                                "<td>" + obj.USU_LOGIN + "</td>" +
                                "<td>" + obj.USU_ESTADO_REGISTRO + "</td>" +
                              //  "<td><a href='#' onclick='editar(" + obj.USU_CODIGO + ")'>Editar</a></td>" +
                            "</tr>";
                        $("#tblLista tbody").append(htmlText);
                    });
                }
            });
        }
    </script>
</asp:Content>
