<%@ Page Title="" Language="C#" MasterPageFile="~/resource/masterPage/Template.Master" AutoEventWireup="true" CodeBehind="registro_backoffice.aspx.cs" Inherits="WEB.maestros.registro_backoffice" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contenido" runat="server">
    <div class="row">
       <div class="col-md-12">
            <div class="portlet box blue">
                <div class="portlet-title">
                    <div class="caption">
                        <i class="fa fa-database"></i> Registro de Configuración de Back Office </div>
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
                    <div class="col-md-12">
                        <label>COLUMNA</label>
                        <select id="sltTableName" class="form-control">
                            <option value="0">-SELECCIONA-</option>
                        </select>
                        </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 margin-bottom-20">
                    <div class="col-md-3">
                        <label>NOMBRE CABECERA</label>
                        <input type="text" id="txtNombreColumna" class="form-control" maxlength="150"/>
                    </div>

                    <div class="col-md-2">
                        <label>FORMATO</label>
                       <!-- <input type="text" id="txtFormato" class="form-control" maxlength="10" />-->
                        <select id="sltFormato" class="form-control">
                            <option value="0">Seleccionar</option>
                            <option value="103">dd/mm/aaaa</option>
                            <option value="112">aaaammdd</option>
                            <option value="101">mm/dd/aaaa</option>
                            <option value="102">dd.mm.aa</option>
                            <option value="110">mm-dd-aa</option>
                        </select>
                    </div>
                     
                    <div class="col-md-2">
                        <label>LONGITUD</label>
                        <input type="text" id="txtLongitud" class="form-control solo-numero" maxlength="5"/>
                    </div>
                    <div class="col-md-1">
                        <label>CARAC.</label>
                        <input type="text" id="txtCompletaCaracter" class="form-control" maxlength="2" />
                    </div>
                    <div class="col-md-2">
                        <label>UBICACION</label>
                        <select id="sltUbicacion" class="form-control"><option value="0">--</option><option value="1">Derecha</option><option value="2">Izquierda</option>
                        </select>
                    </div>
                    
                    <div class="col-md-2">
                        <label></label>
                        <input type="button" id="btnAgregar" value="Añadir" class="form-control btn btn-info" />
                        <input type="hidden" id="txtCodigo" value="0" />
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
   

    <div class="row">
        <div class="col-md-12">

            <div class="portlet box blue">
                <div class="portlet-title">
                    <div class="caption">
                        <i class="fa fa-database"></i> Listado de Configuración Back Office</div>
                    <div class="tools"> </div>
                </div>
                <div class="portlet-body">
                   <table id="tblLista" class="tblLista_grid table table-striped table-bordered table-hover dt-responsive" cellspacing="0" width="100%">
                    <thead>
                        <tr>
                            <th>N°</th>
                            <th>NOMBRE TABLE</th>
                            <th>NOMBRE COLUMNA </th>
                            <th>NOMBRE</th>
                            <th>FORMATO</th>
                            <th>LONGITUD</th>
                            <th>CARACTER</th>                    
                            <th>ESTADO</th>
                            <th>EDITAR</th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
                </div>
            </div>
        </div>
    </div>
 


</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="server">
     <script type="text/javascript">
        var html_columnas = "";

        $(document).ready(function () {
            $('.solo-numero').keyup(function () {
                this.value = (this.value + '').replace(/[^0-9]/g, '');
            });
            cargarProveedor();            
            $("#sltProveedor").change(cargarCarteras);
            $("#sltCartera").change(cargarSubCarteras);
            $("#sltSubCartera").change(listarbackOfficeMaestro);            
        });       

        function cargarProveedor() {
            $.ajax({
                url: strServicio+"general.asmx/cargarProveedor",
                dataType: 'JSON',
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                success: function (jsondata) {                    
                    $.each(jsondata.d, function (i, obj) {
                        $("#sltProveedor").append("<option value='" + obj.value + "'>" + obj.key + "</option>");
                    });                    
                }
            });
            cargarListaTableName();
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
                        $("#sltCartera").append("<option value='" + obj.value + "'>" + obj.key + "</option>");
                    });
                }
            });
            $("#tblLista tbody").empty();
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
                        $("#sltSubCartera").append("<option value='" + obj.value + "'>" + obj.key + "</option>");
                    });                    
                }
            });
            $("#tblLista tbody").empty();
        }
        
        function cargarListaTableName() {
            $.ajax({
                url: strServicio + "backoffice.asmx/cargarListaTableName",
                dataType: 'JSON',
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                success: function (jsondata) {
                    $("#sltTableName").empty();
                    $("#sltTableName").append("<option value='0'>-SELECCIONA-</option>");
                    $.each(jsondata.d, function (i, obj) {
                        $("#sltTableName").append("<option value='" + obj.value + "'>" + obj.key + "</option>");
                    });
                    //console.log(jsondata.d);
                }
            });
        }

        function listarbackOfficeMaestro() {
            
            if (parseInt($("#sltSubCartera").val()) > 0) {
                $.ajax({
                    url: strServicio + "backoffice.asmx/ObtenerReporteBackoffice",
                    data: '{"prv_codigo":' + $("#sltProveedor").val() + ',"car_codigo":' + $("#sltCartera").val() + ',"sca_codigo":' + $("#sltSubCartera").val() + '}',
                    dataType: 'JSON',
                    type: 'POST',
                    contentType: "application/json; charset=utf-8",
                    success: function (jsondata) {
                       
                        $("#tblLista tbody").empty();
                        var htmlText = "";
                        var styleclass = "";
                        $.each(jsondata.d, function (i, obj) {
                            styleclass = (obj.CON_ESTADO == 1 ? '' : 'class="alert alert-danger fade in"')
                            htmlText = "<tr " + styleclass + ">" +
                                    "<td>" + (i + 1) + "</td>" +
                                    "<td>" + obj.NombreTable + "</td>" +
                                    "<td>" + obj.NombreColumna + "</td>" +
                                    "<td>" + obj.CON_NOMBRECAB + "</td>" +
                                    "<td>" + obj.CON_FORMAT + "</td>" +
                                    "<td>" + obj.CON_LONGITUD + "</td>" +
                                    "<td>" + obj.CON_CARACTERCOMPLETAR + "</td>" +
                                    "<td>" + (obj.CON_ESTADO==1?'Activo':'Inactivo' )+ "</td>" +
                                    "<td style='text-align: center;'><a href='#'  onclick=EditarBackOffice('" + obj.CON_CODIGO + "')><span class='fa fa-edit'></span></a> | <a href='#'  onclick=eliminarBackOffice('" + obj.CON_CODIGO + "')><i class='fa fa-trash-o' aria-hidden='true'></i></a></td>" +
                                "</tr>";
                            $("#tblLista tbody").append(htmlText);
                        });
                    }
                });

            } else {
                $("#tblLista tbody").empty();
            }

        }

        function EditarBackOffice(codigo) {
            $.ajax({
                url: strServicio + "backoffice.asmx/BuscarConfiguracion",
                data: '{"con_codigo":"' + codigo + '"}',
                dataType: 'JSON',
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                success: function (jsondata) {
                    if (jsondata.d) {

                        console.log(jsondata.d);
                        $("#txtCodigo").val(jsondata.d.CON_CODIGO);
                        $("#sltTableName").val(jsondata.d.OBJECT_ID + '-' + jsondata.d.COLUMN_ID)                        
                        //$("#sltProveedor").val(jsondata.d.PRV_CODIGO);
                        //$("#sltCartera").val(jsondata.d.CAR_CODIGO);
                        //$("#sltSubCartera").val(jsondata.d.SCA_CODIGO);
                        $("#sltUbicacion").val(jsondata.d.CON_UBICACION);
                        $("#sltFormato").val(jsondata.d.CON_FORMAT);
                        $("#txtLongitud").val(jsondata.d.CON_LONGITUD);
                        $("#txtCompletaCaracter").val(jsondata.d.CON_CARACTERCOMPLETAR);
                        $("#txtNombreColumna").val(jsondata.d.CON_NOMBRECAB);                        
                    }
                }
            });
        };

        $("#btnAgregar").click(function () {
            
            if ($("#sltProveedor").val()=='0') {
                bootbox.alert("Seleccionar el proveedor");
                return false;
            }
            if ($("#sltCartera").val()=='0') {
                bootbox.alert("Seleccionar la cartera");
                return false;
            }
            if ($("#sltSubCartera").val()=='0') {
                bootbox.alert("Seleccionar la sub cartera");
                return false;
            }
            if ($("#sltTableName").val() == '0') {
                bootbox.alert("Seleccionar el campo de datos");
                return false;
            }
            if ($("#txtNombreColumna").val().length < 1) {
                bootbox.alert("Ingrese nombre que aparecerá en la cabecera del reporte");
                return false;
            }
        
            var objBE = new Object();
            objBE.CON_CODIGO = $("#txtCodigo").val();
            objBE.OBJECT_ID = $("#sltTableName").val().split("-")[0];
            objBE.COLUMN_ID = $("#sltTableName").val().split("-")[1];
            objBE.PRV_CODIGO = $("#sltProveedor").val();
            objBE.CAR_CODIGO = $("#sltCartera").val();
            objBE.SCA_CODIGO = $("#sltSubCartera").val();
            objBE.CON_UBICACION = $("#sltUbicacion").val();
            objBE.CON_FORMAT = $("#sltFormato").val();
            objBE.CON_LONGITUD = $("#txtLongitud").val();
            objBE.CON_CARACTERCOMPLETAR = $("#txtCompletaCaracter").val();
            objBE.CON_NOMBRECAB = $("#txtNombreColumna").val();

            
            $.ajax({
                url: strServicio + "backoffice.asmx/registrarBackofficemaestro",                             
                data: '{"objBE":' + JSON.stringify(objBE) + '}',                
                dataType: 'json',                
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                beforeSend: function () {
                    $("#txtProgreso").html("CARGANDO..");
                },               
                success: function (jsondata) {
                    
                    if (jsondata.d >= 0) {
                        listarbackOfficeMaestro();
                        $("#txtCodigo").val(0);
                        $("#sltTableName").val('0');
                        $("#sltProveedor").val();
                        $("#sltCartera").val();
                        $("#sltSubCartera").val();
                        $("#sltUbicacion").val();
                        $("#sltFormato").val('0');
                        $("#txtLongitud").val('');
                        $("#txtCompletaCaracter").val('');
                        $("#txtNombreColumna").val('');
                        $("#txtProgreso").html("");
                        $("#sltUbicacion").val('0')
                    }

                },
                error: function (xhr, ajaxOptions, thrownError) {
                    
                    alert(thrownError);
                    alert("Ocurrio un error, por favor vuelva a intentar cargar el documento.", "MENSAJE DE CARGA DE DOCUMENTOS");
                }                
            });
        });

        function eliminarBackOffice(cod) {
           /* ;*/
            bootbox.confirm("¿Deseas Eliminar el registro?", function (answer) {
                if (!answer) return;
                else {
                    $.ajax({
                        url: strServicio + "backoffice.asmx/eliminarConfiguracion",
                        data: '{"con_codigo":"' + cod + '"}',
                        dataType: 'JSON',
                        type: 'POST',
                        contentType: "application/json; charset=utf-8",
                        success: function (jsondata) {
                            if (parseInt(jsondata.d) > 0) {
                                listarbackOfficeMaestro();
                            }
                        }
                    })
                }
            });
        }


        



    </script>
</asp:Content>
