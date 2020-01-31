<%@ Page Title="" Language="C#" MasterPageFile="~/resource/masterPage/Template.Master" AutoEventWireup="true" CodeBehind="pago-excel.aspx.cs" Inherits="WEB.cobranza.pago_excel" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contenido" runat="server">
    <div class="row" id="div_contenido">
        <div class="col-md-12">

            <div class="portlet box blue">
                <div class="portlet-title">
                    <div class="caption">
                        <i class="fa fa-globe"></i> CARGA DE PAGOS</div>
                    <div class="tools"> </div>
                </div>
                <div class="portlet-body">

                    <div class="row">
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 margin-bottom-20">
                            <div class="col-md-6">
                                <label>CARGAR ARCHIVO (.XLS)</label>
                                <input type="file" id="file_upload" class="form-control">
                                <span id="txtProgreso"></span>
                            </div>
  
                            <div class="col-md-3">
                                <label>&nbsp;</label> 
                                <a class="btn_buscar btn btn blue form-control" id="btn_cargar">CARGAR</a>
                            </div>
                            <div class="col-md-3">
                                <label>&nbsp;&nbsp;&nbsp;</label>
                                 <a class="btn blue form-control" href="../resource/carga/excel/FORMATO_PAGO.xlsx"><i class="fa fa-file-excel-o"></i> DESCARGAR MODELO</a>
                            </div>
                        </div>

                    </div>


                </div>
            </div>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="server">
    <script type="text/javascript">
        $(document).on("click", "#btn_cargar", function (event) {
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
                url: "../resource/carga/carga_pagos_excel.ashx",
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
                    bootbox.alert(response.responseText);
                    if (response.responseText == "ERROR") {
                        bootbox.alert("Ocurrio un error, por favor vuelva a intentar cargar el documento.", "MENSAJE DE CARGA DE DOCUMENTOS");
                    } else if (response.responseText == "CORRECTO") {
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
    </script>
</asp:Content>
