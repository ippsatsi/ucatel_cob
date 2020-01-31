<%@ Page Title="" Language="C#" MasterPageFile="~/resource/masterPage/Template.Master" AutoEventWireup="true" CodeBehind="bandeja-busqueda-especializada.aspx.cs" Inherits="WEB.cobranza.bandeja_busqueda_especializada" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../resource/css/jne/jquery-ui-1.9.2.custom.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contenido" runat="server">

    <div class="row">
        <div class="col-md-12">

            <div class="portlet box blue">
                <div class="portlet-title">
                    <div class="caption">
                        <i class="fa fa-globe"></i> Búsqueda especializada</div>
                    <div class="tools"> </div>
                </div>
                <div class="portlet-body">

                    <div class="row">
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 margin-bottom-20">
                            <div class="col-md-4">
                                <label>N° CUENTA</label>
                                <input type="text" id="txtNroCuenta" class="form-control">
                            </div>
                            <div class="col-md-4">
                                <label>DNI</label>
                                <input type="text" id="txtDni" class="form-control">
                            </div>
                            <div class="col-md-4">
                                <label>CLIENTE</label>
                                <input type="text" id="txtCliente" class="form-control">
                            </div>
                        </div>

                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 margin-bottom-20">
                            <div class="col-md-4">
                                <label>TELEFONO</label>
                                <input type="text" id="txtTelefono" class="form-control">
                            </div>
                            <div class="col-md-4">
                                <label>ESTADO</label>
                                <select id="sltEstado" class="form-control">
                                    <option value="-1">TODOS</option>
                                    <option value="0">NUEVOS</option>
                                    <option value="1">ENCONTRADOS</option>
                                </select>
                            </div>
                            
                            <div class="col-md-4">
                                <div><label>&nbsp;</label></div>
                                <a class="btn blue btn_buscar" id="btn_buscar">BUSCAR</a>
                            </div>
                            <%--<div class="col-md-4">
                                <label>OBSERVACIÓN</label>
                                <input type="hidden" id="Hidden1" value="0" />
                                <textarea id="Textarea1" rows="3" cols="20" class="form-control"></textarea>
                            </div>--%>
                        </div>
                    </div>

                    <table id="tblLista" class="tblLista_grid table table-striped table-bordered table-hover dt-responsive" cellspacing="0" width="100%">
                        <thead>
                            <tr>
                                <th></th>
                                <th>N° CUENTA</th>
                                <th>DNI</th>
                                <th>CLIENTE</th>
                                <th>CANT. TELEFONOS</th>
                                <th>CANT. DIRECCIONES</th>
                                <th>FECHA INGRESO</th>
                                <th>USUARIO</th>
                                <th>ESTADO</th>
                                <th>OBSERVACION</th>
                                <th></th>
                                <th></th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <div id="div_eliminar" style="display:none;">
        <div>
            <div class="cell">
                <div class="cell_contenido">
                    <span>OBSERVACIÓN</span>
                </div>
                <div>
                    <input type="hidden" id="txt_codigo" value="0" />
                    <textarea id="txt_observacion" rows="3" cols="20" style="height: 60px;width: 255px;"></textarea>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="server">
    <script src="../resource/js/vendor/ui/jquery-ui-1.9.2.custom.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            buscar();

            $("#btn_buscar").click(buscar);
        });

        function buscar() {
            var objBusqueda = new Object();
            objBusqueda.CUE_NROCUENTA = $("#txtNroCuenta").val();
            objBusqueda.CLI_NRODOCUMENTO = $("#txtDni").val();
            objBusqueda.CLI_NOMBRES = $("#txtCliente").val();
            objBusqueda.TEL_NUMERO = $("#txtTelefono").val();
            objBusqueda.ESTADO_BUSQUEDA = $("#sltEstado").val();
            $.ajax({
                url: strServicio+"busqueda.asmx/obtenerBandejaBusqueda",
                data: '{"objBusqueda": ' + JSON.stringify(objBusqueda) + '}',
                dataType: 'JSON',
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                async: false,
                success: function (jsondata) {
                    var html_text = "";
                    $("#tblLista tbody").empty();
                    $.each(jsondata.d, function (i, obj) {
                        html_text = "<tr>" +
                                "<td>" + (i + 1) + "</td>" +
                                "<td>" + obj.CUE_NROCUENTA + "</td>" +
                                "<td>" + obj.CLI_NRODOCUMENTO + "</td>" +
                                "<td>" + obj.CLI_NOMBRES + "</td>" +
                                "<td>" + obj.CANT_TELEFONO + "</td>" +
                                "<td>" + obj.CANT_DIRECCION + "</td>" +
                                "<td>" + obj.BUS_FECHA + "</td>" +
                                "<td>" + obj.USU_REGISTRA_VC + "</td>" +
                                "<td>" + obj.ESTADO_BUSQUEDA + "</td>" +
                                "<td>" + obj.BUS_OBSERVACION + "</td>" +
                                "<td><a onclick='nuevo_telefono(" + obj.BUS_CODIGO + ");'><i class='fa fa-phone' aria-hidden='true'></i> Nuevo teléfono</a></td>" +
                                "<td><a onclick='nuevo_direccion(" + obj.BUS_CODIGO + ");'><i class='fa fa-home' aria-hidden='true'></i> Nueva dirección</a></td>" +
                                "<td><a onclick='eliminar_busqueda(" + obj.BUS_CODIGO + ");'><i class='fa fa-trash-o' aria-hidden='true'></i> Eliminar busqueda</a></td>" +
                            "</tr>";
                        $("#tblLista tbody").append(html_text);
                    });
                }
            });
        }

        function nuevo_telefono(codigo) {
            var url = "telefono_busqueda.aspx?codigo=" + codigo;
            $.fancybox({
                type: "iframe",
                width: 500,
                height: 450,
                scrolling: 'no',
                modal: true,
                href: url
            });
        }

        function nuevo_direccion(codigo) {
            var url = "direccion_busqueda.aspx?codigo=" + codigo;
            $.fancybox({
                type: "iframe",
                width: 500,
                height: 500,
                scrolling: 'no',
                modal: true,
                href: url
            });
        }

        function eliminar_busqueda(codigo) {
            bootbox.prompt("¿Esta seguro que desea eliminar la busqueda especialziada?",
                function (result)
                {
                    //console.log(result);
                    var objBusqueda = new Object();
                    objBusqueda.BUS_CODIGO = codigo;
                    objBusqueda.BUS_OBSERVACION = result;
                    $.ajax({
                        url: strServicio + "busqueda.asmx/eliminar",
                        data: '{"objBusqueda": ' + JSON.stringify(objBusqueda) + '}',
                        dataType: 'JSON',
                        type: 'POST',
                        contentType: "application/json; charset=utf-8",
                        async: false,
                        success: function (jsondata) {
                            if (jsondata.d == "CORRECTO") {
                                buscar();
                                bootbox.alert("Eliminado correctamente");
                            }
                        }
                    });
                });

            //$("#txt_codigo").val(codigo);
            //$("#div_eliminar").dialog({
            //    title:"ELIMINAR",
            //    height: 200,
            //    width: 300,
            //    modal: true,
            //    buttons: {
            //        "ELIMINAR": eliminar,
            //        "CANCELAR": function () {
            //            $("#div_eliminar").dialog("close");
            //        }
            //    }
            //});
        }

        function eliminar(codigo) {
            var objBusqueda = new Object();
            objBusqueda.BUS_CODIGO = $("#txt_codigo").val();
            objBusqueda.BUS_OBSERVACION = $("#txt_observacion").val();
            $.ajax({
                url: strServicio+"busqueda.asmx/eliminar",
                data: '{"objBusqueda": ' + JSON.stringify(objBusqueda) + '}',
                dataType: 'JSON',
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                async: false,
                success: function (jsondata) {
                    if (jsondata.d == "CORRECTO") {
                        buscar();
                        $("#div_eliminar").dialog("close");
                    }
                }
            });
        }
    </script>
</asp:Content>
