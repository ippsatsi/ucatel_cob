<%@ Page Title="" Language="C#" MasterPageFile="~/resource/masterPage/Template.Master" AutoEventWireup="true" CodeBehind="gestion_ivr.aspx.cs" Inherits="WEB.carga_ivr.carga_ivr" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contenido" runat="server">

    <div class="row">
        <div class="col-md-12">

            <div class="portlet box blue">
                <div class="portlet-title">
                    <div class="caption">
                        <i class="fa fa-globe"></i> Gestión IVR</div>
                    <div class="tools"> </div>
                </div>
                <div class="portlet-body">

                    <div class="row">
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 margin-bottom-20">
                            <div class="col-md-4">
                                <label>Nº CUENTA</label>
                                <input type="text" id="txtNroCuenta" class="form-control">
                            </div>
                            <div class="col-md-4">
                                <label>DNI</label>
                                <input type="text" id="txtDni" class="form-control">
                            </div>
                            <div class="col-md-4">
                                <label>FECHA CARGA</label>
                                <input type="text" id="txtFechaCarga" class="form-control date-picker">
                            </div>
                        </div>

                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 margin-bottom-20">
                            <div class="col-md-3">
                                <label>&nbsp;&nbsp;&nbsp;</label>
                                <a class="btn btn blue btn_buscar form-control" id="btn_buscar">BUSCAR</a>
                            </div>
                            <div class="col-md-3">
                                <label>&nbsp;&nbsp;&nbsp;</label>
                                <a class="btn btn blue btn_nuevo form-control" id="btn_nuevo">NUEVO</a>
                            </div>
                            <div class="col-md-6">
                                <label>&nbsp;&nbsp;&nbsp;</label>
                                <a class="btn blue form-control" href="../resource/carga/excel/FORMATO_IVR.xlsx"><i class="fa fa-file-excel-o"></i> DESCARGAR MODELO</a>
                            </div>
                        </div>
                    </div>

                    <table id="tblLista" class="tblLista_grid table table-striped table-bordered table-hover dt-responsive" cellspacing="0" width="100%">
                        <thead>
                            <tr>
                                <th>ITEM</th>
                                <th>TIPO_GESTION</th>
                                <th>NRO_DOCUMENTO</th>
                                <th>TELEFONO</th>
                                <th>SUB_CARTERA</th>
                                <th>TIPO_RESULTADO</th>
                                <th>FECHA_GESTION</th>
                                <th>HORA_GESTION</th>
                                <th>OBSERVACION</th>
                                <th>FLG_ASOCIADO</th>
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
            $("#btn_buscar").click(listarBandeja);

            $("#btn_nuevo").click(function () {
                $.fancybox({
                    type: "iframe",
                    width: 650,
                    height: 150,
                    scrolling: 'no',
                    href: "nueva_carga.aspx"
                });
            });

            $("#txtFechaCarga").val(obtenerFechaActual);

            function obtenerFechaActual() {
                var today = new Date();
                var dd = today.getDate();
                var mm = today.getMonth() + 1; //January is 0!

                var yyyy = today.getFullYear();
                if (dd < 10) {
                    dd = '0' + dd
                }
                if (mm < 10) {
                    mm = '0' + mm
                }
                var today = dd + '/' + mm + '/' + yyyy;
                return today;
            }

            $(".date-picker").datepicker({
                dateFormat: "dd/mm/yy",
                firstDay: 1,
                dayNamesMin: ["Do", "Lu", "Ma", "Mi", "Ju", "Vi", "Sa"],
                dayNamesShort: ["Dom", "Lun", "Mar", "Mie", "Jue", "Vie", "Sab"],
                monthNames:
                    ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio",
                    "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"],
                monthNamesShort:
                    ["Ene", "Feb", "Mar", "Abr", "May", "Jun",
                    "Jul", "Ago", "Sep", "Oct", "Nov", "Dic"]
            });

            listarBandeja();
        });


        function listarBandeja() {
            $.ajax({
                url: strServicio+"carga_ivr.asmx/listarIvrPorCriterio",
                data: "{'nroCuenta':'" + $("#txtNroCuenta").val() + "','nroDni':'" + $("#txtDni").val() + "','fechaCarga':'" + $("#txtFechaCarga").val() + "'}",
                dataType: 'JSON',
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    $("#tblLista tbody").empty();
                    var html_text = "";
                    $.each(data.d, function (i, obj) {
                        html_text = "<tr>"
                            + "<td>" + obj.IVR_ITEM + "</td>"
                            + "<td>" + obj.IVR_TIPO_GESTION + "</td>"
                            + "<td>" + obj.IVR_NRO_DOCUMENTO + "</td>"
                            + "<td>" + obj.IVR_TELEFONO + "</td>"
                            + "<td>" + obj.IVR_SUB_CARTERA + "</td>"
                            + "<td>" + obj.IVR_TIPO_RESULTADO + "</td>"
                            + "<td>" + obj.IVR_FECHA_GESTION + "</td>"
                            + "<td>" + obj.IVR_HORA_GESTION + "</td>"
                            + "<td>" + obj.IVR_OBSERVACION + "</td>"
                            + "<td>" + obj.FLG_ASOCIADO + "</td>"
                            + "</tr>";
                        $("#tblLista tbody").append(html_text);
                    });
                }
            });
        }
    </script>
</asp:Content>
