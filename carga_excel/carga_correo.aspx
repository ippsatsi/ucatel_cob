<%@ Page Title="" Language="C#" MasterPageFile="~/resource/masterPage/Template.Master" AutoEventWireup="true" CodeBehind="carga_correo.aspx.cs" Inherits="WEB.carga_excel.carga_correo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contenido" runat="server">

    <div class="row">
        <div class="col-md-12">

            <div class="portlet box blue">
                <div class="portlet-title">
                    <div class="caption">
                        <i class="fa fa-globe"></i> CARGA DE CORREOS</div>
                    <div class="tools"> </div>
                </div>
                <div class="portlet-body">

                    <div class="row">
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 margin-bottom-20">
                            <div class="col-md-6">
                                <label>CARGAR ARCHIVO (.XLS)</label>
                                <input type="file" id="file_upload" class="form-control"/>
                                <span id="txtProgreso"></span>
                            </div>
                            <div class="col-md-3">
                                <label>ORIGEN DEL TELEFONO</label>
                                <a class="btn_buscar btn btn blue form-control" id="btn_cargar">CARGAR</a>
                            </div>
                            <div class="col-md-3">
                                <label>&nbsp;</label>
                                <a class="btn blue form-control" href="../resource/carga/excel/FORMATO_CORREO.xlsx"><i class="fa fa-file-excel-o"></i> DESCARGAR MODELO</a>
                            </div>
                        </div>
                    </div>

                    <table id="tbl_respuesta" class="table table-striped table-bordered table-hover dt-responsive" cellspacing="0" width="100%">
                        <thead>
                            <tr>
                                <th>NO REGISTRADOS</th>
                                <th>REGISTRADOS</th>
                                <th>TOTAL</th>
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
    <script type="text/javascript">
        $(document).on("click", "#btn_cargar", function (event) {
            var formData = new FormData();
            var files = $("#file_upload").get(0).files;
            if (files[0].type != "application/vnd.ms-excel" &&
                files[0].type != "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet") {
                bootbox.alert("Solo se aceptan formatos EXCEL");
                return false;
            }
            formData.append("Tipo", "correo");
            formData.append("UploadFile", files[0]);
            $.ajax({
                url: "../resource/carga/carga_excel.ashx",
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
                    parent.bootbox.alert(response.responseText);
                    if (response.responseText.split("|")[0] == "ERROR") {
                        parent.bootbox.alert("Ocurrio un error, por favor vuelva a intentar cargar el documento.", "MENSAJE DE CARGA DE DOCUMENTOS");
                    } else if (response.responseText.split("|")[0] == "CORRECTO") {
                        parent.bootbox.alert("Carga realizada correctamente");
                        $("#tbl_respuesta tbody").html(response.responseText.split("|")[1]);
                    }
                },
                error: function () {
                    parent.bootbox.alert("Ocurrio un error, por favor vuelva a intentar cargar el documento.", "MENSAJE DE CARGA DE DOCUMENTOS");
                },
                data: formData,
                cache: false,
                contentType: false,
                processData: false
            });
        });
    </script>
</asp:Content>
