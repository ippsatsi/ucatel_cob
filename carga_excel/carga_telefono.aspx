<%@ Page Title="" Language="C#" MasterPageFile="~/resource/masterPage/Template.Master" AutoEventWireup="true" CodeBehind="carga_telefono.aspx.cs" Inherits="WEB.carga_excel.carga_telefono" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contenido" runat="server">

    <div class="row">
        <div class="col-md-12">

            <div class="portlet box blue">
                <div class="portlet-title">
                    <div class="caption">
                        <i class="fa fa-globe"></i> CARGA DE TELEFONOS</div>
                    <div class="tools"> </div>
                </div>
                <div class="portlet-body">

                    <div class="row">
                        <div class="col-lg-7 col-md-7 col-sm-7 col-xs-12 margin-bottom-20">
                            <div class="col-md-6">
                                <label>CARGAR ARCHIVO (.XLS)</label>
                                <input type="file" id="file_upload" class="form-control"/>
                                <span id="txtProgreso"></span>
                            </div>
                            <div class="col-md-6">
                                <label>ORIGEN DEL TELEFONO</label>
                                <select id="sltOrigen" class="form-control">
                                    <option value="0">-SELECCIONE-</option>
                                </select>
                            </div>
                        </div>

                        <div class="col-lg-5 col-md-5 col-sm-5 col-xs-12 margin-bottom-20">
                            <div class="col-md-5">
                                <label>&nbsp;</label> 
                                <a class="btn_buscar btn btn blue form-control" id="btn_cargar">CARGAR</a>
                            </div>
                            <div class="col-md-7">
                                <label>&nbsp;&nbsp;&nbsp;</label>
                                 <a class="btn blue form-control" href="../resource/carga/excel/FORMATO_TELEFONO.xlsx"><i class="fa fa-file-excel-o"></i> DESCARGAR MODELO</a>
                            </div>
                        </div>
                    </div>

                    <table id="tbl_respuesta" class="tblLista_grid table table-striped table-bordered table-hover dt-responsive" cellspacing="0" width="100%">
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
        $(document).ready(function () {
            cargarTipoOrigen();
        });

        function cargarTipoOrigen() {
            $.ajax({
                url: strServicio+"general.asmx/listarTipoOrigen",
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

        $(document).on("click", "#btn_cargar", function (event) {
            if ($("#sltOrigen").val() == "0") {
                bootbox.alert("Usted no selecciono el Origen.");
                return false;
            }

            var formData = new FormData();
            var files = $("#file_upload").get(0).files;
            if (files[0].type != "application/vnd.ms-excel" &&
                files[0].type != "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet") {
                bootbox.alert("Solo se aceptan formatos EXCEL");
                return false;
            }
            formData.append("Tipo", "telefono");
            formData.append("Origen", $("#sltOrigen").val());
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
                    bootbox.alert(response.responseText);
                    if (response.responseText.split("|")[0] == "ERROR") {
                        parent.bootbox.alert("Ocurrio un error, por favor vuelva a intentar cargar el documento.", "MENSAJE DE CARGA DE DOCUMENTOS");
                    } else if (response.responseText.split("|")[0] == "CORRECTO") {
                        bootbox.alert("Carga realizada correctamente");
                        $("#tbl_respuesta tbody").html(response.responseText.split("|")[1]);
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
