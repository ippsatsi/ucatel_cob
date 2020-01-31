<%@ Page Title="" Language="C#" MasterPageFile="~/resource/masterPage/Template.Master" AutoEventWireup="true" CodeBehind="carga_ivr.aspx.cs" Inherits="WEB.carga_ivr.carga_ivr" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="titulo" runat="server">
    CARGA IVR
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="pageBar" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="antesTitulo" runat="server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="contenido" runat="server">
    <div class="container-fluid" id="div_contenido">
        <div class="row content">
            <div class="col-sm-12 sidenav">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                      <h3 class="panel-title"><i class="fa fa-user" aria-hidden="true"></i> DESCARGA DE TELEFONOS ACTIVOS</h3>
                    </div>
                    <div class="panel-body">
                        <div class="content">
                            <div class="form-group row">
                                <div class="col-xs-3">
                                    <a class="btn btn-danger form-control" href="descarga.aspx"><i class="fa fa-file-excel-o"></i> DESCARGAR TELEFONOS</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-sm-12 sidenav">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                      <h3 class="panel-title"><i class="fa fa-user" aria-hidden="true"></i> CARGA IVR</h3>
                    </div>
                    <div class="panel-body">
                        <div class="content">
                            <div class="form-group row">
                                <div class="col-xs-6">
                                    <label for="file_upload">Adjuntar Archivo (xls. xlsx.)</label>
                                    <input type="file" id="file_upload" class="form-control" />
                                    <span id="txtProgreso"></span>
                                </div>
                                <div class="col-xs-3">
                                    <label for="btn_cargar">&nbsp;</label>
                                    <input type="button" class="btn-default form-control" id="btn_cargar" value="CARGAR IVR" />
                                </div>
                                <div class="col-xs-3">
                                    <label for="btn_cargar">&nbsp;</label>
                                    <a class="btn btn-danger form-control" href="../resource/carga/excel/FORMATO_ACT_IVR.xlsx"><i class="fa fa-file-excel-o"></i> DESCARGAR MODELO</a>
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="col-xs-4">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                          <h3 class="panel-title"><i class="fa fa-user" aria-hidden="true"></i> ACTUALIZADOS</h3>
                                        </div>
                                        <div class="panel-body">
                                            <div class="content">
                                                <span id="txt_actualizados">0</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xs-4">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                          <h3 class="panel-title"><i class="fa fa-user" aria-hidden="true"></i> ELIMINADOS</h3>
                                        </div>
                                        <div class="panel-body">
                                            <div class="content">
                                                <span id="txt_eliminados">0</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xs-4">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                          <h3 class="panel-title"><i class="fa fa-user" aria-hidden="true"></i> TOTAL</h3>
                                        </div>
                                        <div class="panel-body">
                                            <div class="content">
                                                <span id="txt_total">0</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="script" runat="server">
    <script type="text/javascript">
        $(document).on("click", "#btn_cargar", function (event) {
            var formData = new FormData();
            var files = $("#file_upload").get(0).files;
            console.log(files[0].type);
            if (files[0].type != "application/vnd.ms-excel" &&
                files[0].type != "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet") {
                bootbox.alert("Solo se aceptan formatos EXCEL");
                return false;
            }
            abrir_preload('div_contenido');
            formData.append("Tipo", "correo");
            formData.append("UploadFile", files[0]);
            $.ajax({
                url: "../resource/carga/carga_telefonos_ivr.ashx",
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
                    console.log(response.responseText);
                    if (response.responseText.split("|")[0] == "ERROR") {
                        bootbox.alert("Ocurrio un error, por favor vuelva a intentar cargar el documento.");
                    } else if (response.responseText.split("|")[0] == "CORRECTO") {
                        bootbox.alert("Carga realizada correctamente");
                        var datos = JSON.parse(response.responseText.split("|")[1]);
                        $("#txt_actualizados").html(datos.ACTUALIZADOS);
                        $("#txt_eliminados").html(datos.ELIMINADOS);
                        $("#txt_total").html(datos.TOTAL);
                        //$("#tbl_respuesta tbody").html(response.responseText.split("|")[1]);
                    }
                },
                error: function () {
                    console.log("<font color='red'> ERROR: unable to upload files</font>");
                    bootbox.alert("Ocurrio un error, por favor vuelva a intentar cargar el documento.");
                },
                data: formData,
                cache: false,
                contentType: false,
                processData: false
            });
        });
    </script>
</asp:Content>
