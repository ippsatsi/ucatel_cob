<%@ Page Title="" Language="C#" MasterPageFile="~/resource/masterPage/progresivo.Master" AutoEventWireup="true" CodeBehind="asterisk_progresivo.aspx.cs" Inherits="WEB.progresivo.asterisk_progresivo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="<%=ResolveClientUrl("~/resource/assets/global/plugins/font-awesome/css/font-awesome.min.css")%>" rel="stylesheet" type="text/css" />
    <link href="<%=ResolveClientUrl("~/resource/assets/global/plugins/bootstrap-datepicker/css/bootstrap-datepicker.min.css")%>" rel="stylesheet" />
    <link href="<%=ResolveClientUrl("~/resource/assets/global/plugins/bootstrap-datepicker/css/bootstrap-datepicker.standalone.min.css")%>" rel="stylesheet" />
    <link href="<%=ResolveClientUrl("~/resource/assets/global/plugins/bootstrap-datepicker/css/bootstrap-datepicker3.standalone.min.css")%>" rel="stylesheet" />
    <link href="<%=ResolveClientUrl("~/resource/assets/global/plugins/bootstrap-timepicker/css/bootstrap-timepicker.min.css")%>" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="antesTitulo" runat="server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="contenido" runat="server">
    <div class="container-fluid" id="div_contenido" runat="server">
        <asp:HiddenField runat="server" ID="txtCuenta" />
        <input type="hidden" id="txtCodigoCliente" value="0"/>
        <input type="hidden" id="txtCodigoProveedor" value="0"/>
        <input type="hidden" id="txtCodigoCuenta" value="0"/>
        <input type="hidden" id="txtCodigoCartera" value="0"/>
        <input type="hidden" id="txtCodigoSubCartera" value="0"/>
        <input type="hidden" id="txtCodigoGestion" value="0"/>
        <input type="hidden" id="txtCodigoRol" runat="server" value="0"/>
        <input type="hidden" id="txtCodigoTelefono" runat="server" value="0"/>
        <input type="hidden" id="txtCodigoDireccion" runat="server" value="0"/>
        <input type="hidden" id="txtTelefonoGestionado" runat="server" value="0"/>
        <div class="row content">
            <div class="col-sm-3 sidenav">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                      <h3 class="panel-title"><i class="fa fa-user" aria-hidden="true"></i> DATOS DEL CLIENTE</h3>
                    </div>
                    <div class="panel-body">
                        <div class="form-group">
                            <img src="../resource/img/sin-imagen.png" class="img-thumbnail" alt="Cinque Terre" width="304" height="236"/>
                        </div>
                        <div class="form-group">
                            <label for="txtDni"><b>DNI:</b></label><br />
                            <span id="txtDni"></span>
                        </div>
                        <div class="form-group">
                            <label for="txtNombres"><b>NOMBRES Y APELLIDOS:</b></label><br />
                            <span id="txtNombres"></span>
                        </div>
                        <div class="form-group">
                            <label for="txtDireccion"><b>DIRECCIÓN:</b></label><br />
                            <span id="txtDireccion"></span><br />
                            <span id="txtUbigeo"></span>
                        </div>
                        <div class="form-group">
                            <label for="txtNombres"><b>CORREO:</b></label><br />
                            <span id="txtCorreo"></span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-sm-9">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                      <h3 class="panel-title"><i class="fa fa-credit-card-alt" aria-hidden="true"></i> DATOS DE LA CUENTA</h3>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-sm-3" id="divDiasMora" style="display:none;">
                                <div class="panel panel-danger">
                                <div class="panel-heading">
                                    <h3 class="panel-title">DIAS DE MORA</h3>
                                </div>
                                <div class="panel-body">
                                    <span id="txtDiasMora">0</span>
                                </div>
                                </div>
                            </div>
                            <div class="col-sm-3">
                                <div class="panel panel-primary">
                                <div class="panel-heading">
                                    <h3 class="panel-title">DIAS SIN GESTIÓN</h3>
                                </div>
                                <div class="panel-body">
                                    <span id="txtDias">0</span>
                                </div>
                                </div>
                            </div>
                        </div>
                        <div class="row" id="divDatosCuenta" runat="server">
                        </div>
                        <div class="panel-group">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="panel-title">
                                    <a data-toggle="collapse" href="#collapse4">CUENTAS DEL CLIENTE</a>
                                    </h4>
                                </div>
                                <div id="collapse4" class="panel-collapse collapse in">
                                    <div id="div_cuentas_adicionales" runat="server" class="panel-body table-responsive">
                                        
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-sm-12">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                      <h3 class="panel-title"><i class="fa fa-credit-card-alt" aria-hidden="true"></i> NUEVA GESTIÓN</h3>
                    </div>
                    <div class="panel-body">
                        <div class="content">
                            <div class="row">
                                <div class="col-sm-6">
                                    <label for="sltTipoGestion">TIPO DE GESTIÓN:</label>
                                    <select id="sltTipoGestion" class="form-control">
                                        <option value="5">LLAMADA SALIENTE</option>
                                    </select>
                                </div>
                                <div class="col-sm-6" id="divTelefono">
                                    <label for="sltTelefono">TELÉFONO GESTIONADO:</label>
                                    <select id="sltTelefono" class="form-control">
                                        <option value="00">-SELECCIONE-</option>
                                    </select>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-6">
                                    <label for="sltRespuesta">RESPUESTA:</label>
                                    <select id="sltRespuesta" class="form-control">
                                        <option value="00">-SELECCIONE-</option>
                                    </select>
                                </div>
                                <div class="col-sm-6" id="divSolucion" style="display:none;">
                                    <label for="sltSolucion">SOLUCIÓN:</label>
                                    <select id="sltSolucion" class="form-control">
                                        <option value="00">-SELECCIONE-</option>
                                    </select>
                                </div>
                            </div>
                            <div class="row" id="divDireccion" style="display:none;">
                                <div class="col-sm-12">
                                    <label for="sltDireccion">DIRECCIÓN:</label>
                                    <select id="sltDireccion" class="form-control">
                                        <option value="00">-SELECCIONE-</option>
                                    </select>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-12">
                                    <label for="txtObservacion">OBSERVACIÓN:</label>
                                    <textarea id="txtObservacion" class="form-control"></textarea>
                                </div>
                            </div>
                        </div>

                        <div class="content divRespuestaPago">
                            <div class="row divRecibo" style="display:none;">
                                <div class="col-sm-6">
                                <label for="txtReciboMonto">MONTO RECIBO:</label>
                                <input type="text" class="form-control calcularCuotaMonto" id="txtReciboMonto"/>
                                </div>
                                <div class="col-sm-6">
                                    <label for="txtReciboFecha">FECHA RECIBO: DD/MM/YYYY:</label>
                                    <div class='input-group date datetimepicker'>
                                        <input type='text' class="form-control" id="txtReciboFecha"/>
                                        <span class="input-group-addon">
                                            <span class="glyphicon glyphicon-calendar"></span>
                                        </span>
                                    </div>
                                    <%--<input type="text" class="form-control calcularCuotaMonto datepicker" id="txtReciboFecha"/>--%>
                                </div>
                            </div>
                            <div class="row divRecibo" style="display:none;">
                                <div class="col-sm-6">
                                    <label for="txtReciboNumero">N° VOUCHER:</label>
                                    <input type="text" class="form-control calcularCuotaMonto" id="txtReciboNumero"/>
                                </div>
                                <div class="col-sm-6">
                                    <label for="txtReciboAgencia">AGENCIA:</label>
                                    <input type="text" class="form-control calcularCuotaMonto" id="txtReciboAgencia"/>
                                </div>
                            </div>
                            <div class="row" id="divMontoNegociado" style="display:none;">
                                <div class="col-sm-6">
                                    <label for="txtMontoInicial">MONTO DE NEGOCIACIÓN:</label>
                                    <input type="text" class="form-control calcularCuotaMonto" id="txtMontoNegociacion"/>
                                </div>
                                <div class="col-sm-6" id="divSaldo" style="display:none;">
                                    <label for="txtFechaInicial">SALDO DE NEGOCIACIÓN:</label>
                                    <input type="text" class="form-control calcularCuotaMonto" id="txtSaldoNegociacion" readonly="true"/>
                                </div>
                            </div>
                            <div class="row" id="divMonto" style="display:none;">
                                <div class="col-sm-6">
                                    <label for="txtMontoInicial">MONTO:</label>
                                    <input type="text" class="form-control calcularCuotaMonto" id="txtMontoInicial"/>
                                </div>
                                <div class="col-sm-6" id="divFecha" style="display:none;">
                                    <label for="txtFechaInicial">FECHA: DD/MM/YYYY:</label>
                                    <div class='input-group date datetimepicker'>
                                        <input type='text' class="form-control" id="txtFechaInicial"/>
                                        <span class="input-group-addon">
                                            <span class="glyphicon glyphicon-calendar"></span>
                                        </span>
                                    </div>
                                    <%--<input type="text" class="form-control calcularCuotaMonto datepicker" id="txtFechaInicial"/>--%>
                                </div>
                            </div>
                            <div class="row divRespuestaCuotas" style="display:none;">
                                <div class="col-sm-6">
                                    <label for="txtNroCuotas">N° DE CUOTAS:</label>
                                    <input type="text" class="form-control calcularCuotaMonto" id="txtNroCuotas"/>
                                </div>
                                <div class="col-sm-6">
                                    <label for="txtValorCuota">VALOR DE LA CUOTA:</label>
                                    <input type="text" class="form-control calcularCuotaMonto" id="txtValorCuota" readonly="true"/>
                                </div>
                            </div>
                            <div class="row divRespuestaCuotas" style="display:none;">
                                <div class="col-sm-12">
                                    <br />
                                    <table id="tblCuotas" class="table table-bordered">
                                        <thead>
                                            <tr>
                                                <th>N° CUOTA</th>
                                                <th>FECHA</th>
                                                <th>MONTO</th>
                                            </tr>
                                        </thead>
                                        <tbody></tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
        
                        <div class="content">
                            <div class="col-sm-12">
                                <div class="checkbox">
                                    <label for="chkRecordatorio"><input type="checkbox" id="chkRecordatorio"/> NUEVO RECORDATORIO</label>
                                </div>
                            </div>
                        </div>

                        <div class="content clearfix" id="divRecordatorio" style="display:none;">
                            <div class="col-sm-12">
                                <div class="panel panel-primary">
                                    <div class="panel-heading">
                                        <h3 class="panel-title"><i class="fa fa-calendar" aria-hidden="true"></i> REGISTRAR NUEVO RECORDATORIO</h3>
                                    </div>
                                    <div class="panel-body">
                                        <div class="col-sm-6">
                                            <label for="txtNroCuotas">FECHA:</label>
                                            <div class='input-group date datetimepicker'>
                                                <input type='text' class="form-control" id="txtFechaRecordatorio"/>
                                                <span class="input-group-addon">
                                                    <span class="glyphicon glyphicon-calendar"></span>
                                                </span>
                                            </div>
                                        </div>
                                        <div class="col-sm-6">
                                            <label for="txtValorCuota">HORA:</label>
                                            <div class='input-group date'>
                                                <input type='text' class="form-control datehourpicker" id="txtHoraRecordatorio"/>
                                                <span class="input-group-addon">
                                                    <span class="glyphicon glyphicon-time"></span>
                                                </span>
                                            </div>
                                            <%--<input type="text" class="form-control datetimepicker" id="txtHoraRecordatorio"/>--%>
                                        </div>
                                        <div class="col-sm-12">
                                            <label for="txtObservacionRecordatorio">RECORDATORIO:</label>
                                            <textarea id="txtObservacionRecordatorio" class="form-control"></textarea>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        
                        <div class="content" style="text-align:right">
                            <button type="button" class="btn btn-danger" id="btnRegistrarGestion">REGISTRAR GESTIÓN</button>
                        </div>

                    </div>
                </div>
            </div>

            <div class="col-sm-12">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                      <h3 class="panel-title"><i class="fa fa-credit-card-alt" aria-hidden="true"></i><a data-toggle="collapse" href="#collapse10"> GESTION DE TELEFONOS, DIRECCIONES Y CORREOS</a></h3>
                    </div>
                    <div id="collapse10" class="panel-collapse collapse">
                        <ul class="nav nav-pills">
                          <li class="active"><a data-toggle="tab" href="#home">TELÉFONOS</a></li>
                          <li><a data-toggle="tab" href="#menu1">DIRECCIONES</a></li>
                          <li><a data-toggle="tab" href="#menu2">CORREOS</a></li>
                        </ul>

                        <div class="tab-content">
                          <div id="home" class="tab-pane fade in active">                      
                            <div class="panel panel-default">
                                <div id="collapse1" class="panel-collapse collapse in">
                                    <div class="panel-body table-responsive">
                                        <table id="tblTelefonos" class="table table-bordered">
                                            <thead>
                                                <tr>
                                                    <th>N°</th>
                                                    <th>TELEFONO</th>
                                                    <th>ANEXO</th>
                                                    <th>HIS</th>
                                                    <th>PER</th>
                                                    <th>ESTADO</th>
                                                    <th>ORIGEN</th>
                                                    <th>OBSERVACIÓN</th>
                                                    <th></th>
                                                    <th></th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="panel-footer">
                                        <button type="button" class="btn btn-primary" onclick="registrarTelefono(0);"><i class="fa fa-phone" aria-hidden="true"></i> NUEVO TELÉFONO</button>
                                    </div>
                                </div>
                            </div>
                          </div>
                          <div id="menu1" class="tab-pane fade">
                            <div class="panel panel-default">
                                <div id="collapse2" class="panel-collapse collapse in">
                                    <div class="panel-body table-responsive">
                                        <table id="tblDirecciones" class="table table-bordered">
                                            <thead>
                                                <tr>
                                                    <th>N°</th>
                                                    <th>DIRECCIÓN</th>
                                                    <th>DISTRITO</th>
                                                    <th>VALIDO</th>
                                                    <th>TIPO DIRECCIÓN</th>
                                                    <th>ORIGEN</th>
                                                    <th></th>
                                                    <th></th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="panel-footer">
                                        <button type="button" class="btn btn-primary" onclick="registrarDireccion(0);"><i class="fa fa-home" aria-hidden="true"></i> NUEVO DIRECCIÓN</button>
                                    </div>
                                </div>
                            </div>
                          </div>
                          <div id="menu2" class="tab-pane fade">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="panel-title">
                                    <a data-toggle="collapse" href="#collapse5">GESTIÓN DE CORREOS</a>
                                    </h4>
                                </div>
                                <div id="collapse5" class="panel-collapse collapse in">
                                    <div class="panel-body table-responsive">
                                        <table id="tblCorreos" class="table table-bordered">
                                            <thead>
                                                <tr>
                                                    <th>N°</th>
                                                    <th>CORREO</th>
                                                    <th></th>
                                                    <th></th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="panel-footer">
                                        <button type="button" class="btn btn-primary" onclick="registrarCorreo(0);"><i class="fa fa-home" aria-hidden="true"></i> NUEVO CORREO</button>
                                    </div>
                                </div>
                            </div>
                          </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-sm-12">
                <div class="panel-group">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                            <a data-toggle="collapse" href="#collapse3">HISTORIAL DE GESTIONES</a>
                            </h4>
                        </div>
                        <div id="collapse3" class="panel-collapse collapse in">
                            <div class="panel-body table-responsive" style="overflow:auto; max-height:400px;">
                                <table id="tblMultas" class="table table-bordered">
                                    <thead>
                                        <tr>
                                            <th>FECHA</th>
                                            <th>USUARIO</th>
                                            <th>RESPUESTA</th>
                                            <th>SOLUCIÓN</th>
                                            <th>TIPO</th>
                                            <th>MONEDA</th>
                                            <th>IMPORTE NEGOCIACIÓN</th>
                                            <th>SALDO NEGOCIACIÓN</th>
                                            <th>FECHA</th>
                                            <th>IMPORTE</th>
                                            <th>N° CUOTAS</th>
                                            <th>VALOR CUOTA</th>
                                            <th>TELEFONO</th>
                                            <th>DIRECCIÓN</th>
                                            <th>OBSERVACIONES</th>
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
    </div>
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="script" runat="server">
    <script type="text/javascript" src='<%=ResolveClientUrl("~/resource/assets/global/plugins/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js")%>'></script>
    <script type="text/javascript" src='<%=ResolveClientUrl("~/resource/assets/global/plugins/bootstrap-datepicker/js/bootstrap-datepicker.min.js")%>'></script>
    <script type="text/javascript" src="<%=ResolveClientUrl("~/resource/assets/global/plugins/bootstrap-timepicker/js/bootstrap-timepicker.min.js")%>"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            iniciarDatos();
            listarTelefonos();
            listarDirecciones();
            listarCorreos();
            cargarGestiones();

            comboPorTipoGestion($("#sltTipoGestion").val());
            
            $("#sltRespuesta").change(function () {
                //alert($(this).val().split("-")[0]);
                comboPorTipoRespuesta($(this).val().split("-")[0]);
                activarCampos($(this).val());
                $("#txtObservacion").val($("#sltRespuesta option:selected").text());
            });

            $("#sltSolucion").change(function () {
                activarCampos($(this).val());
                $("#txtObservacion").val($("#sltRespuesta option:selected").text() + " / " + $("#sltSolucion option:selected").text());
            });

            $("#btnRegistrarGestion").click(registrarGestion);

            $("#txtFechaRecordatorio").val(obtenerFechaActual);
            $("#chkRecordatorio").change(habilitarRecordatorio);


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

            $('.datetimepicker').datepicker({
                format: 'dd/mm/yyyy'
            });

            $('.datehourpicker').timepicker({
                autoclose: true,
                showSeconds: true,
                minuteStep: 1
            });
        });

        function iniciarDatos() {
            var rol = $("#contenido_txtCodigoRol").val();

            $("label[for=ac-1]").click();
            //AFAC 11/05/2016
            if (rol == "4") {
                $("label[for=ac-2]").click();
            } else if (rol == "5") {
                $("label[for=ac-5]").click();
            } else {
                $("label[for=ac-2]").click();
                $("label[for=ac-5]").click();
            }
            $.ajax({
                url: "../resource/service/gestion.asmx/obtenerDatosCuenta",
                data: '{"cuenta":"' + $("#contenido_txtCuenta").val() + '"}',
                dataType: 'JSON',
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                async: false,
                success: function (jsondata) {
                    $("#txtCodigoCliente").val(jsondata.d[0].CLI_CODIGO);
                    $("#txtCodigoProveedor").val(jsondata.d[0].PRV_CODIGO);
                    $("#txtCodigoCuenta").val(jsondata.d[0].CUE_CODIGO);
                    $("#txtCodigoCartera").val(jsondata.d[0].CAR_CODIGO);
                    $("#txtCodigoSubCartera").val(jsondata.d[0].SCA_CODIGO);
                    $("#txtDni").html(jsondata.d[0].CLI_DOCUMENTO_IDENTIDAD);
                    $("#txtNombres").html(jsondata.d[0].CLI_NOMBRE_COMPLETO);
                    $("#txtDireccion").html(jsondata.d[0].CLI_DIRECCION_PARTICULAR);
                    $("#txtUbigeo").html(jsondata.d[0].UBIGEO);
                    $("#txtCorreo").html(jsondata.d[0].CLI_CORR_PARTICULAR);
                    $("#txtCelular").html(jsondata.d[0].CLI_CELULAR);
                    $("#txtDias").html(jsondata.d[0].DIAS);
                    if (jsondata.d[0].BAD_DIAS_MORA > 0) {
                        $("#divDiasMora").show();
                        $("#txtDiasMora").html(jsondata.d[0].BAD_DIAS_MORA);
                    }
                    console.log(jsondata.d);
                    if (jsondata.d[0].MONTO_CAMPANA_MINIMO.length > 0) {
                        $("#divCampanaMinimo").show();
                        $("#txtCampanaMinimo").html(jsondata.d[0].MONTO_CAMPANA_MINIMO);
                    }
                    if (jsondata.d[0].MONTO_CAMPANA_MAXIMO.length > 0) {
                        $("#divCampanaMaximo").show();
                        $("#txtCampanaMaximo").html(jsondata.d[0].MONTO_CAMPANA_MAXIMO);
                    }
                    if (jsondata.d[0].MONTO_CAMPANA_CANCELACION.length > 0) {
                        $("#divCampanaCancelacion").show();
                        $("#txtCampanaCancelacion").html(jsondata.d[0].MONTO_CAMPANA_CANCELACION);
                    }
                    if (jsondata.d[0].MONTO_CAMPANA_ARMADA.length > 0) {
                        $("#divCampanaArmada").show();
                        $("#txtCampanaArmada").html(jsondata.d[0].MONTO_CAMPANA_ARMADA);
                    }

                    $("#txtUsuarioCall").html(jsondata.d[0].USU_CALL);
                    $("#txtUsuarioCampo").html(jsondata.d[0].USU_CAMPO);
                    //bootbox.alert($("#txtCodigoCartera").val());
                    if ($("#txtCodigoCartera").val() == "1" ||
                        $("#txtCodigoCartera").val() == "3") {// SAGA CASTIGO
                        $("#lblCampo1").html("FECHA CASTIGO");
                        $("#lblCampo2").html("FECHA ASIGNACIÓN");
                        $("#lblCampo3").html("FECHA PROTESTO");
                        $("#lblCampo4").html("MORA ACTUALIZADO");
                        $("#lblCampo5").html("CAPITAL");
                        $("#lblCampo6").html("MONTO PROTESTO");
                        $("#lblCampo7").html("SALDO DEUDA");

                        $("#txtCampo1").html(jsondata.d[0].BAD_FECHA_CASTIGO);
                        $("#txtCampo2").html(jsondata.d[0].BAD_FECHA_ASIGNACION);
                        $("#txtCampo3").html(jsondata.d[0].BAD_FECHA_PROTESTO);
                        $("#txtCampo4").html(jsondata.d[0].BAD_DIAS_MORA);
                        $("#txtCampo5").html(jsondata.d[0].CAPITAL);
                        $("#txtCampo6").html(jsondata.d[0].PROTESTO);
                        $("#txtCampo7").html(jsondata.d[0].SALDO);
                    } else if ($("#txtCodigoCartera").val() == "4") {// SAGA JUDICIAL
                        $("#lblCampana").text("EXPEDIENTE");
                        $("#txtCampana").html(jsondata.d[0].BAD_NRO_EXP + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;JUZGADO: " + jsondata.d[0].BAD_JUZGADO);

                        $("#lblCampo1").html("FECHA DEMANDA");
                        $("#lblCampo2").html("ETAPA JUICIO");
                        $("#lblCampo3").html("FECHA PROTESTO");
                        $("#lblCampo4").html("MORA ACTUALIZADO");
                        $("#lblCampo5").html("CAPITAL");
                        $("#lblCampo6").html("MONTO PROTESTO");
                        $("#lblCampo7").html("SALDO DEUDA");

                        $("#txtCampo1").text(jsondata.d[0].BAD_FECHA_DEMANDA);
                        $("#txtCampo2").text(jsondata.d[0].BAD_ETAPA_JUICIO + " - " + jsondata.d[0].BAD_FECHA_ETAPA);
                        $("#txtCampo3").html(jsondata.d[0].BAD_FECHA_PROTESTO);
                        $("#txtCampo4").html(jsondata.d[0].BAD_DIAS_MORA);
                        $("#txtCampo5").html(jsondata.d[0].CAPITAL);
                        $("#txtCampo6").html(jsondata.d[0].PROTESTO);
                        $("#txtCampo7").html(jsondata.d[0].SALDO);
                    } else if ($("#txtCodigoCartera").val() == "8") { //DUPRE
                        $("#lblCampo1").html("PERIODO CAMPAÑA");
                        $("#lblCampo2").html("FECHA ASIGNACIÓN");
                        $("#lblCampo3").html("FECHA VENCIMIENTO");
                        $("#lblCampo4").html("DIAS MORA");
                        $("#lblCampo5").html("");
                        $("#lblCampo6").html("SALDO DEUDA");
                        $("#lblCampo7").html("");
                        var datos_json = JSON.parse(jsondata.d[0].DATOS);
                        console.log("DUPRE JSON");
                        console.log(datos_json);
                        $("#txtCampo1").html(datos_json.CAMPANA);
                        $("#txtCampo2").html(jsondata.d[0].BAD_FECHA_ASIGNACION);
                        $("#txtCampo3").html(jsondata.d[0].BAD_FECHA_VENCIMIENTO1);
                        $("#txtCampo4").html(jsondata.d[0].BAD_DIAS_MORA);
                        $("#txtCampo5").html("");
                        $("#txtCampo6").html(jsondata.d[0].SALDO);
                        $("#txtCampo7").html("");
                    }
                }
            });
        }

        function listarTelefonos() {
            var rol = $("#contenido_txtCodigoRol").val();
            $.ajax({
                url: "../resource/service/general.asmx/listarTelefonos",
          //      data: '{"dni":"' + $("#txtDni").html() + '"}',
        data: '{"dni":"' + $("#contenido_txtCuenta").val() + '"}',//se usa nrode cuenta en vez de dni
                dataType: 'JSON',
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                async: true,
                success: function (jsondata) {
                    var htmlText = "";
                    var contador = 0;
                    $("#tblTelefonos tbody").empty();
                    //$("#sltTelefono").html("<option value='0'>-SELECCIONE-</option>");
                    //$("#sltTelefono").html("<option value='0'>-SIN ESPECIFICAR-</option>");
                    $.each(jsondata.d, function (i, obj) {
                        contador++;
                        htmlText = " <tr>" +
                            "<td><span>" + (i + 1) + "</span></td>" +
                            //"<td><span>" + obj.TOR_DESCRIPCION + "</span></td>" +
                            "<td><span>" + obj.TEL_NUMERO + "</span></td>" +
                            "<td><span>" + obj.TEL_ANEXO + "</span></td>" +
                            "<td " + (obj.TES_COLOR.length > 0 ? "style='background-color:" + obj.TES_COLOR + " !important;'" : "") + "><span>" + obj.TEL_ESTADO_VALIDEZ + "</span></td>" +
                            "<td " + (obj.TES_COLOR_MENSUAL.length > 0 ? "style='background-color:" + obj.TES_COLOR_MENSUAL + " !important;'" : "") + "><span>" + obj.TES_ABREVIATURA_MENSUAL + "</span></td>" +
                            //"<td><span>" + obj.TEL_TIPO_EQUIPO + "</span></td>" +
                            "<td><span>" + obj.TEL_ESTADO_TELEFONO + "</span></td>" +
                            "<td><span>" + obj.TEL_ORIGEN + "</span></td>" +
                            "<td><span>" + obj.TEL_OBSERVACIONES + "</span></td>" +
                            "<td><a onclick='registrarTelefono(" + obj.TEL_CODIGO + ");'><i class='fa fa-pencil' aria-hidden='true'></i></a></td>" +
                            "<td>" + (rol == 1 || rol == 2 || rol == 3 ? "<a onclick='eliminarTelefonoSession(" + obj.TEL_CODIGO + ");'><i class='fa fa-trash-o' aria-hidden='true'></i></a>" : "") + "</td>" +
                        "</tr>";
                        $("#tblTelefonos tbody").append(htmlText);

                        if ($.trim($("#contenido_txtTelefonoGestionado").val()) == $.trim(obj.TEL_NUMERO)) {
                            $("#sltTelefono").html("<option value='" + obj.TEL_CODIGO + "'>" + obj.TEL_NUMERO + "</option>");
                        }
                    });
                }
            });
        }

        function listarDirecciones() {
            var rol = $("#contenido_txtCodigoRol").val();
            $.ajax({
                url: "../resource/service/general.asmx/listarDirecciones",
                data: '{"dni":"' + $("#txtDni").html() + '"}',
                dataType: 'JSON',
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                async: true,
                success: function (jsondata) {
                    var htmlText = "";
                    $("#tblDirecciones tbody").empty();
                    $.each(jsondata.d, function (i, obj) {
                        htmlText = "<tr>" +
                            "<td><span>" + (i + 1) + "</span></td>" +
                            "<td><span>" + obj.DIR_DIRECCION + "</span></td>" +
                            "<td><span>" + obj.UBI_DISTRITO + "</span></td>" +
                            "<td " + (obj.DIR_COLOR.length > 0 ? "style='background-color:" + obj.DIR_COLOR + " !important;'" : "") + "><span>" + obj.DIR_ESTADO_VALIDEZ + "</span></td>" +
                            "<td><span>" + obj.TDI_DESCRIPCION + "</span></td>" +
                            "<td><span>" + obj.TOR_DESCRIPCION + "</span></td>" +
                            "<td><a onclick='registrarDireccion(" + obj.DIR_CODIGO + ");'><i class='fa fa-pencil' aria-hidden='true'></i></a></td>" +
                            "<td>" + (rol == 1 || rol == 2 || rol == 3 ? "<a onclick='eliminarDireccionSession(" + obj.DIR_CODIGO + ");'><i class='fa fa-trash-o' aria-hidden='true'></i></a>" : "") + "</td>" +
                        "</tr>";
                        $("#tblDirecciones tbody").append(htmlText);
                    });
                }
            });
        }

        function listarCorreos() {
            var rol = $("#contenido_txtCodigoRol").val();
            $.ajax({
                url: "../resource/service/general.asmx/listarCorreos",
                data: '{"dni":"' + $("#txtDni").html() + '"}',
                dataType: 'JSON',
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                async: true,
                success: function (jsondata) {
                    var htmlText = "";
                    $("#tblCorreos tbody").empty();
                    $.each(jsondata.d, function (i, obj) {
                        htmlText = "<tr>" +
                            "<td><span>" + (i + 1) + "</span></td>" +
                            "<td><span id='txt_correo_" + obj.COR_CODIGO + "'>" + obj.COR_CORREO_ELECTRONICO + "</span></td>" +
                            "<td><a onclick='registrarCorreo(" + obj.COR_CODIGO + ");'><i class='fa fa-pencil' aria-hidden='true'></i></a></td>" +
                            "<td>" + (rol == 1 || rol == 2 || rol == 3 ? "<a onclick='eliminarCorreo(" + obj.COR_CODIGO + ");'><i class='fa fa-trash-o' aria-hidden='true'></i></a>" : "") + "</td>" +
                        "</tr>";
                        $("#tblCorreos tbody").append(htmlText);
                    });
                }
            });
        }

        function registrarTelefono(codigo) {
            var url = "";
            if (parseInt(codigo) > 0) {
                url = "../cobranza/telefono.aspx?codigo=" + codigo + "&codigoCliente=" + $("#txtCodigoCliente").val() + "&codigoProveedor=" + $("#txtCodigoProveedor").val();
            } else {
                url = "../cobranza/telefono.aspx?codigoCliente=" + $("#txtCodigoCliente").val() + "&codigoProveedor=" + $("#txtCodigoProveedor").val();
            }
            //console.log(url);
            $.fancybox({
                type: "iframe",
                width: 500,
                height: 450,
                scrolling: 'no',
                modal: false, //modal: true,
                href: url
            });
        }

        function registrarDireccion(codigo) {
            var url = "";
            //console.log("CODIGO: " + codigo);
            if (parseInt(codigo) > 0) {
                url = "../cobranza/direccion.aspx?codigo=" + codigo + "&codigoCliente=" + $("#txtCodigoCliente").val() + "&codigoProveedor=" + $("#txtCodigoProveedor").val();
            } else {
                url = "../cobranza/direccion.aspx?codigoCliente=" + $("#txtCodigoCliente").val() + "&codigoProveedor=" + $("#txtCodigoProveedor").val();
            }
            //console.log(url);
            $.fancybox({
                type: "iframe",
                width: 500,
                height: 530,
                scrolling: 'no',
                modal: false, //modal: true,
                href: url
            });
        }

        function registrarCorreo(codigo) {
            var url = "";
            if (parseInt(codigo) > 0) {
                url = "../cobranza/correo.aspx?codigo=" + codigo + "&correo=" + $("#txt_correo_" + codigo).text() + "&codigoCliente=" + $("#txtCodigoCliente").val() + "&codigoProveedor=" + $("#txtCodigoProveedor").val();
            } else {
                url = "../cobranza/correo.aspx?codigoCliente=" + $("#txtCodigoCliente").val() + "&codigoProveedor=" + $("#txtCodigoProveedor").val();
            }
            //console.log(url);
            $.fancybox({
                type: "iframe",
                width: 500,
                height: 180,
                scrolling: 'no',
                modal: false, //modal: true,
                href: url
            });
        }

        function eliminarTelefonoSession(codigo) {
            bootbox.confirm("¿Esta seguro de eliminar esta teléfono?", function (res) {
                if (res) {
                    $.ajax({
                        url: "../resource/service/telefono.asmx/eliminarTelefonoId",
                        data: '{"codigo":' + codigo + '}',
                        dataType: 'JSON',
                        type: 'POST',
                        contentType: "application/json; charset=utf-8",
                        async: false,
                        success: function (jsondata) {
                            if (jsondata.d) {
                                listarTelefonos();
                            }
                        }
                    });
                }
            });
        }

        function eliminarCorreo(codigo) {
            bootbox.confirm("¿Esta seguro de eliminar esta correo?", function (res) {
                if (res) {
                    $.ajax({
                        url: "../resource/service/correo.asmx/eliminarCorreoId",
                        data: '{"codigo":' + codigo + '}',
                        dataType: 'JSON',
                        type: 'POST',
                        contentType: "application/json; charset=utf-8",
                        async: false,
                        success: function (jsondata) {
                            if (jsondata.d) {
                                listarCorreos();
                            }
                        }
                    });
                }
            });
        }

        function eliminarDireccionSession(codigo) {
            bootbox.confirm("¿Esta seguro de eliminar esta dirección?", function (res) {
                if (res) {
                    $.ajax({
                        url: "../resource/service/direccion.asmx/eliminarDireccionId",
                        data: '{"codigo":' + codigo + '}',
                        dataType: 'JSON',
                        type: 'POST',
                        contentType: "application/json; charset=utf-8",
                        async: false,
                        success: function (jsondata) {
                            if (jsondata.d) {
                                listarDirecciones();
                            }
                        }
                    });
                }
            });
        }

        function obtenerDatosTarea(txtFecha, txtHora, txtObservacion) {
            if (txtObservacion.length > 0) {
                tarea.REC_FECHA = txtFecha;
                tarea.REC_HORA = txtHora;
                tarea.REC_OBSERVACIONES = txtObservacion;
                $("#Checkbox100").attr("checked", "checked");
            } else {
                $("#Checkbox100").removeAttr("checked");
            }
        }

        function registrarTarea() {
            $.fancybox({
                type: "iframe",
                width: 500,
                height: 320,
                scrolling: 'no',
                modal: false, //modal: true,
                href: "tarea.aspx?codigo=" + $("#txtCodigoGestion").val()
            });
        }

        function comboPorTipoGestion(tipoGestion) {
            var rol = $("#contenido_txtCodigoRol").val();

            $("#sltRespuesta").empty();
            $.ajax({
                url: strServicio + "general.asmx/listarRespuestaPorTipoGestion",
                data: "{'sca_codigo':'" + $("#txtCodigoSubCartera").val() + "','codigo':'" + tipoGestion + "'}",
                dataType: 'JSON',
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                async: true,
                success: function (jsondata) {
                    console.log(jsondata.d);
                    $("#sltRespuesta").append("<option value=''>-SELECCIONE-</option>");
                    $.each(jsondata.d, function (i, obj) {
                        //$("#sltRespuesta").append("<option value='" + obj.value + "'>" + obj.key + "</option>");
                        if (obj.value.split("-")[0] == 160) {
                            if (rol == 1 || rol == 2 || rol == 3) {
                                $("#sltRespuesta").append("<option value='" + obj.value + "'>" + obj.key + "</option>");
                            }
                        } else {
                            $("#sltRespuesta").append("<option value='" + obj.value + "'>" + obj.key + "</option>");
                        }
                    });
                }
            });
        }

        function comboPorTipoRespuesta(tipoRespuesta) {
            $("#sltSolucion").empty();
            $.ajax({
                url: strServicio + "general.asmx/listarSolucionPorTipoRespuesta",
                data: "{'codigo':'" + tipoRespuesta + "'}",
                dataType: 'JSON',
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                async: true,
                success: function (jsondata) {
                    //alert(jsondata.d.length);
                    if (jsondata.d.length > 0) {
                        $("#divSolucion").show();
                        $("#sltSolucion").append("<option value=''>-SELECCIONE-</option>");
                        $.each(jsondata.d, function (i, obj) {
                            $("#sltSolucion").append("<option value='" + obj.value + "'>" + obj.key + "</option>");
                        });
                    } else {
                        $("#divSolucion").hide();
                    }
                }
            });
        }

        function habilitarRecordatorio() {
            if ($(this).is(":checked")) {
                $("#divRecordatorio").show();
            } else {
                $("#divRecordatorio").hide();
            }
        }

        function activarCampos(campo) {
            var datos = campo.split('-');
            var importe_negociado = datos[1];
            var fecha = datos[2];
            var monto = datos[3];
            var reprogramacion = datos[4];
            var recibo = datos[5];
            var cuotas = datos[6];
            var inicial = datos[7];
            var saldo = datos[8];
            var rango_cuotas = datos[9];

            if (importe_negociado == 1) {
                $("#divMontoNegociado").show();
            } else {
                $("#divMontoNegociado").hide();
            }
            if (fecha == 1) {
                $("#divFecha").show();
            } else {
                $("#divFecha").hide();
            }
            if (monto == 1) {
                $("#divMonto").show();
            } else {
                $("#divMonto").hide();
            }
            if (reprogramacion == 1) {
                $("#divRegistrarTarea").show();
            } else {
                $("#divRegistrarTarea").hide();
            }
            if (recibo == 1) {
                $(".divRecibo").show();
            } else {
                $(".divRecibo").hide();
            }
            if (cuotas == 1) {
                $(".divRespuestaCuotas").show();
            } else {
                $(".divRespuestaCuotas").hide();
            }
            if (saldo == 1) {
                $("#divSaldo").show();
            } else {
                $("#divSaldo").hide();
            }
            $("#txtMontoNegociacion").val('');
            $("#txtSaldoNegociacion").val('');
            $("#txtReciboMonto").val('');
            $("#txtReciboFecha").val('');
            $("#txtReciboNumero").val('');
            $("#txtReciboAgencia").val('');
            $("#txtMontoInicial").val('');
            $("#txtFechaInicial").val('');
            $("#txtNroCuotas").val('');
            $("#txtValorCuota").val('');
            $("#tblCuotas tbody").empty();
        }

        function registrarGestion() {
            //console.log($("#sltTipoGestion").is(":visible") + " - " + $("#sltTipoGestion").val());
            if ($("#sltTipoGestion").is(":visible") && $("#sltTipoGestion").val() == "00") {
                bootbox.alert("Usted no selecciono el TIPO DE GESTIÓN");
                $("#sltTipoGestion").focus();
                return false;
            }
            if ($("#sltRespuesta").val() == "") {
                bootbox.alert("Usted no selecciono la RESPUESTA");
                $("#sltRespuesta").focus();
                return false;
            }
            if ($("#sltSolucion").is(":visible") && $("#sltSolucion").val() == "") {
                bootbox.alert("Usted no selecciono la SOLUCION");
                $("#sltSolucion").focus();
                return false;
            }
            if ($("#sltTelefono").is(":visible") && $("#sltTelefono").val() == "00" && $("#sltTipoGestion").val() != "6") {
                bootbox.alert("Usted no selecciono el TELÉFONO GESTIONADO");
                $("#sltTelefono").focus();
                return false;
            }
            if ($("#sltTipoLlamada").is(":visible") && $("#sltTipoLlamada").val() == "00") {
                bootbox.alert("Usted no selecciono el TIPO DE LLAMADA");
                $("#sltTipoLlamada").focus();
                return false;
            }
            if ($("#sltDireccion").is(":visible") && $("#sltDireccion").val() == "00") {
                bootbox.alert("Usted no selecciono la DIRECCIÓN");
                $("#sltDireccion").focus();
                return false;
            }
            if ($("#sltTipoPago").is(":visible") && $("#sltTipoPago").val() == "00") {
                bootbox.alert("Usted no selecciono el TIPO DE PAGO");
                $("#sltTipoPago").focus();
                return false;
            }
            if ($("#txtMontoNegociacion").is(":visible") && ($("#txtMontoNegociacion").val().length < 1 || !$.isNumeric($("#txtMontoNegociacion").val()))) {
                bootbox.alert("Usted no ingreso el MONTO DE NEGOCIACIÓN o no es formato NUMÉRICO");
                $("#txtMontoNegociacion").focus();
                return false;
            }
            if ($("#txtSaldoNegociacion").is(":visible") && ($("#txtSaldoNegociacion").val().length < 1 || !$.isNumeric($("#txtSaldoNegociacion").val()))) {
                bootbox.alert("Usted no ingreso el SALDO DE NEGOCIACIÓN o no es formato NUMÉRICO");
                $("#txtSaldoNegociacion").focus();
                return false;
            }
            if ($("#txtMontoInicial").is(":visible") && ($("#txtMontoInicial").val().length < 1 || !$.isNumeric($("#txtMontoInicial").val()))) {
                bootbox.alert("Usted no selecciono el MONTO INICIAL o no es formato NUMÉRICO");
                $("#txtMontoInicial").focus();
                return false;
            }
            if ($("#txtFechaInicial").is(":visible") && ($("#txtFechaInicial").val().length < 1 || !isValidDate($("#txtFechaInicial").val()))) {
                bootbox.alert("Usted ingreso la FECHA INICIAL o no es el formato CORRECTO");
                $("#txtFechaInicial").focus();
                return false;
            }
            if ($("#txtNroCuotas").is(":visible") && ($("#txtNroCuotas").val().length < 1 || !$.isNumeric($("#txtNroCuotas").val()))) {
                bootbox.alert("Usted no Ingreso el NÚMERO DE CUOTAS");
                $("#txtNroCuotas").focus();
                return false;
            }
            if ($("#txtNroCuotas").is(":visible") && ($("#txtNroCuotas").val().length > 0 && $.isNumeric($("#txtNroCuotas").val()))) {
                var cant_cuotas = ($("#sltSolucion").is(":visible") ? $("#sltSolucion").val().split('-').pop() :
                        ($("#sltRespuesta").is(":visible") ? $("#sltRespuesta").val().split('-').pop() : '0'));
                console.log(cant_cuotas);
                if (cant_cuotas != "0") {
                    var rango = cant_cuotas.split(';');
                    console.log($("#txtNroCuotas").val() + "<" + rango[0]);
                    console.log($("#txtNroCuotas").val() + ">" + rango[1]);
                    if ((parseInt($("#txtNroCuotas").val()) < parseInt(rango[0])) ||
                        (parseInt($("#txtNroCuotas").val()) > parseInt(rango[1]))) {
                        var texto = "Usted no esta en el rango valido de [" + rango[0] + " - " + rango[1] + " cuotas]";
                        bootbox.alert(texto);
                        return false;
                    }
                }
            }
            if ($("#txtObservacionRecordatorio").is(":visible") && $("#txtObservacionRecordatorio").val().length < 1) {
                bootbox.alert("Usted no Ingreso la observación del RECORDATORIO");
                $("#txtObservacionRecordatorio").focus();
                return false;
            }
            //if ($("#sltApoyoCall").is(":visible") && $("#sltApoyoCall").val() == "00") {
            //    bootbox.alert("Usted no selecciono la ASIGNACION DE GESTOR CALL");
            //    $("#sltApoyoCall").focus();
            //    return false;
            //}
            //if ($("#sltApoyoCampo").is(":visible") && $("#sltApoyoCampo").val() == "00") {
            //    bootbox.alert("Usted no selecciono la ASIGNACION DE GESTOR CAMPO");
            //    $("#sltApoyoCampo").focus();
            //    return false;
            //}
            if ($("#txtReciboMonto").is(":visible") && ($("#txtReciboMonto").val().length < 1 || !$.isNumeric($("#txtReciboMonto").val()))) {
                bootbox.alert("Usted no ingreso el MONTO DE RECIBO");
                $("#txtReciboMonto").focus();
                return false;
            }
            if ($("#txtReciboFecha").is(":visible") && $("#txtReciboFecha").val().length < 1) {
                bootbox.alert("Usted no ingreso el FECHA DE RECIBO");
                $("#txtReciboFecha").focus();
                return false;
            }
            if ($("#txtReciboNumero").is(":visible") && $("#txtReciboNumero").val().length < 1) {
                bootbox.alert("Usted no ingreso el NÜMERO DE RECIBO");
                $("#txtReciboNumero").focus();
                return false;
            }
            if ($("#txtReciboAgencia").is(":visible") && $("#txtReciboAgencia").val().length < 1) {
                bootbox.alert("Usted no ingreso el NÚMERO DE LA AGENCIA");
                $("#txtReciboAgencia").focus();
                return false;
            }

            var objGestion = new Object();
            objGestion.FLG_ELIMINAR_CRONOGRAMA = false;
            objGestion.ObjCuenta = new Object();

            if ($("#tblCuotas").is(":visible")) {
                var objCuentaBE = new Object();
                objCuentaBE.CUE_CODIGO = $("#txtCodigoCuenta").val();
                $.ajax({
                    url: strServicio + "gestion.asmx/tieneConvenio",
                    data: '{"objCuentaBE": ' + JSON.stringify(objCuentaBE) + '}',
                    dataType: 'JSON',
                    type: 'POST',
                    contentType: "application/json; charset=utf-8",
                    async: false,
                    success: function (jsondata) {
                        if (jsondata.d != null) {
                            if (jsondata.d.NRO_CUO_FAL > 0) {
                                bootbox.prompt({
                                    size:"large",
                                    placeholder:"maximo 50 caracteres",
                                    maxlength:50,
                                    title:"ESTA CUENTA YA TIENE UN CONVENIO VIGENTE. SI DESEA DARLO DE BAJA, INGRESE EL MOTIVO DE MODIFICACIÓN:", 
                                    callback:function (r) {
                                    if (r != null && $.trim(r).length > 0) {
                                        objGestion.FLG_ELIMINAR_CRONOGRAMA = true;
                                        objGestion.ObjCuenta.TXT_MOTIVO_CONVENIO = r;
                                        iniciarRegistroGestion(objGestion, true);
                                    } else {
                                        bootbox.alert("Usted no ingreso el MOTIVO DE MODIFICACIÓN, vuelva a intentar registrar.");
                                    }
                                }});
                            } else {
                                iniciarRegistroGestion(objGestion, true);
                            }
                        } else {
                            iniciarRegistroGestion(objGestion, true);
                        }
                    }
                });
            } else {
                iniciarRegistroGestion(objGestion, false);
            }
        }



        function iniciarRegistroGestion(objGestion, flgConvenio) {
            if (flgConvenio) {
                var lstCronograma = new Array();
                $("#tblCuotas tbody tr").each(function (i) {
                    var cronograma = new Object();
                    var codigo = (i + 1);
                    cronograma.NRO_CUOTA = codigo;
                    cronograma.FEC_VENCIMIENTO = $("#cuota_" + codigo).val();
                    cronograma.IMP_CUOTA = $("#cuota_valor_" + codigo).val();
                    lstCronograma.push(cronograma);
                });
                objGestion.lstCronogramaBE = lstCronograma;
            }

            objGestion.ObjTipoResultado = new Object();
            objGestion.ObjTipoResultado.TIR_CODIGO = $("#sltRespuesta").val().split('-')[0];
            if ($("#sltSolucion").is(":visible")) { objGestion.ObjTipoResultado.SOL_CODIGO = $("#sltSolucion").val().split('-')[0]; }
            objGestion.ObjTelefono = new Object();
            objGestion.ObjTelefono.TEL_CODIGO = $("#sltTelefono").val();
            objGestion.GES_OBSERVACIONES = $("#txtObservacion").val();
            objGestion.ObjCuenta.CUE_CODIGO = $("#txtCodigoCuenta").val();
            objGestion.ObjCartera = new Object();
            objGestion.ObjCartera.CAR_CODIGO = $("#txtCodigoCartera").val();
            objGestion.ObjSubCartera = new Object();
            objGestion.ObjSubCartera.SCA_CODIGO = $("#txtCodigoSubCartera").val();
            //objGestion.GES_HORA = $("#horaGestion").text();
            objGestion.ObjDireccion = new Object();
            objGestion.ObjDireccion.DIR_CODIGO = $("#sltDireccion").val();
            objGestion.ObjTipoGestion = new Object();
            objGestion.ObjTipoGestion.TIG_CODIGO = $("#sltTipoGestion").val();
            objGestion.GES_FECHA_INICIAL = $("#txtFechaInicial").val();
            objGestion.GES_IMPORTE_INICIAL = ($("#txtMontoInicial").val() == "" ? "0" : $("#txtMontoInicial").val());
            objGestion.ObjTipoPago = new Object();
            objGestion.ObjTipoPago.TPA_CODIGO = $("#sltTipoPago").val();
            objGestion.GES_NRO_CUOTAS = ($("#txtNroCuotas").val() == "" ? "0" : $("#txtNroCuotas").val());
            objGestion.GES_IMPORTE_NEGOCIACION = (isNaN($("#txtMontoNegociacion").val()) || $("#txtMontoNegociacion").val() == "" ? "0" : $("#txtMontoNegociacion").val());
            objGestion.GES_SALDO_NEGOCIACION = (isNaN($("#txtSaldoNegociacion").val()) || $("#txtSaldoNegociacion").val() == "" ? "0" : $("#txtSaldoNegociacion").val());
            objGestion.GES_VALOR_CUOTA = (isNaN($("#txtValorCuota").val()) || $("#txtValorCuota").val() == "" ? "0" : $("#txtValorCuota").val());
            //objGestion.ASI_GES_CALL = $("#sltApoyoCall").val();
            //objGestion.ASI_GES_CAMPO = $("#sltApoyoCampo").val();
            objGestion.REC_NUMERO = $("#txtReciboNumero").val();
            objGestion.REC_AGENCIA = $("#txtReciboAgencia").val();
            objGestion.REC_MONTO = ($("#txtReciboMonto").val() == "" ? "0" : $("#txtReciboMonto").val());
            objGestion.REC_FECHA = $("#txtReciboFecha").val();
            console.log(objGestion);

            var rol = $("#contenido_txtCodigoRol").val();

            /*if ($("#tblCuotas").is(":visible") && (rol != 4 && rol != 5)) {
                var lstCronograma = new Array();
                $("#tblCuotas tbody tr").each(function (i) {
                    var cronograma = new Object();
                    var codigo = (i + 1);
                    cronograma.NRO_CUOTA = codigo;
                    cronograma.FEC_VENCIMIENTO = $("#cuota_" + codigo).val();
                    cronograma.IMP_CUOTA = $("#cuota_valor_" + codigo).val();
                    lstCronograma.push(cronograma);
                });
                objGestion.lstCronogramaBE = lstCronograma;
            }*/

            $.ajax({
                url: strServicio + "gestion.asmx/registrarGestionProgresivo",
                data: '{"objGestion": ' + JSON.stringify(objGestion) + '}',
                dataType: 'JSON',
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                async: false,
                success: function (jsondata) {
                    console.log(jsondata.d);
                    if (jsondata != null) {
                        if (jsondata.d > 0) {
                            guardarTarea(jsondata.d);
                            bootbox.alert("REGISTRO DE GESTIÓN REALIZADO CORRECTAMENTE");
                        }
                    } else {
                        bootbox.alert("EL REGISTRO DE GESTIÓN NO SE REALIZO, POR FAVOR VUELVA A INTENTAR");
                        //$("#txtMensaje").html("EL REGISTRO DE GESTIÓN NO SE REALIZO, POR FAVOR VUELVA A INTENTAR");
                    }
                }
            });
        }


        function guardarTarea(gestion_codigo) {
            var tarea = new Object();
            tarea.GES_CODIGO = gestion_codigo;
            tarea.REC_FECHA = $("#txtFechaRecordatorio").val();
            tarea.REC_HORA = $("#txtHoraRecordatorio").val();
            tarea.REC_OBSERVACIONES = $("#txtObservacionRecordatorio").val();
            tarea.TIR_CODIGO = $("#sltRespuesta").val().split("-")[0];
            tarea.CLI_CODIGO = $("#txtCodigoCliente").val();
            //console.log(tarea);
            if (tarea.GES_CODIGO != "0" && tarea.REC_OBSERVACIONES != null && tarea.REC_OBSERVACIONES.length > 0) {
                $.ajax({
                    url: strServicio + "gestion.asmx/registrarTarea",
                    data: '{"tarea":' + JSON.stringify(tarea) + '}',
                    dataType: 'JSON',
                    type: 'POST',
                    contentType: "application/json; charset=utf-8",
                    async: true,
                    success: function (jsondata) {
                        //console.log(jsondata.d);
                    }
                });
            }
        }

        function isValidDate(s) {
            var bits = s.split('/');
            var d = new Date(bits[2] + '/' + bits[1] + '/' + bits[0]);
            return !!(d && (d.getMonth() + 1) == bits[1] && d.getDate() == Number(bits[0]));
        }

        function cargarGestiones() {
            objCuenta = new Object();
            objCuenta.CUE_CODIGO = $("#txtCodigoCuenta").val();
            //console.log("GESTIONES: " + objCuenta);
            $.ajax({
                url: "../resource/service/gestion.asmx/cargarGestiones",
                data: '{"objCuenta": ' + JSON.stringify(objCuenta) + '}',
                dataType: 'JSON',
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                async: false,
                success: function (jsondata) {
                    //console.table(jsondata.d);
                    $("#tblMultas tbody").empty();
                    var htmlText = "";
                    $.each(jsondata.d, function (i, obj) {
                        htmlText = "<tr" + (i % 2 == 0 ? " class='row_listabandejavirtual'" : "") + ">" +
                            "<td>" + obj.GES_FECHA_REGISTRO + "</td>" +
                            "<td>" + obj.GES_USU_LOGIN + "</td>" +
                            "<td>" + obj.TIR_DESCRIPCION + "</td>" +
                            "<td>" + obj.SOL_DESCRIPCION + "</td>" +
                            "<td>" + obj.TIG_DESCRIPCION + "</td>" +
                            "<td>" + obj.GES_MONEDA + "</td>" +
                            "<td>" + obj.GES_IMPORTE_NEGOCIACION + "</td>" +
                            "<td>" + obj.GES_SALDO_NEGOCIACION + "</td>" +
                            "<td>" + obj.GES_FECHA_INICIAL + "</td>" +
                            "<td>" + obj.GES_IMPORTE_INICIAL + "</td>" +
                            "<td>" + obj.GES_NRO_CUOTAS + "</td>" +
                            "<td>" + obj.GES_VALOR_CUOTA + "</td>" +
                            "<td>" + obj.TEL_NUMERO + "</td>" +
                            "<td>" + obj.DIR_DIRECCION + "</td>" +
                            "<td>" + obj.GES_OBSERVACIONES + "</td>" +
                        "</tr>";
                        $("#tblMultas tbody").append(htmlText);
                    });
                }
            });
        }

        $(".calcularCuotaMonto").keyup(function () {
            calcularMonto();
        });
        $("#txtFechaInicial").change(function () {
            calcularMonto();
        });

        function calcularMonto() {
            try {
                var rol = $("#contenido_txtCodigoRol").val();
                var montoNegociado = parseFloat($("#txtMontoNegociacion").val());
                var numeroCuotas = parseFloat($("#txtNroCuotas").val());
                var montoRecibo;

                if ($("#txtReciboMonto").is(":visible")) {
                    montoRecibo = parseFloat($("#txtReciboMonto").val());
                } else if ($("#txtMontoInicial").is(":visible")) {
                    montoRecibo = parseFloat($("#txtMontoInicial").val());
                } else {
                    montoRecibo = 0.0;
                }

                var montoInicial;

                if ($("#txtReciboMonto").is(":visible")) {
                    montoInicial = parseFloat($("#txtReciboMonto").val());
                } else if ($("#txtMontoInicial").is(":visible")) {
                    montoInicial = parseFloat($("#txtMontoInicial").val());
                }

                var valorCuota = (montoNegociado - montoInicial) / numeroCuotas;
                $("#txtValorCuota").val(valorCuota.toFixed(2));

                var saldoNegociacion = montoNegociado - montoRecibo;
                $("#txtSaldoNegociacion").val(saldoNegociacion.toFixed(2));

                var fechaInicial;

                if ($("#txtReciboFecha").is(":visible")) {
                    fechaInicial = $("#txtReciboFecha").val().split("/");
                } else if ($("#txtFechaInicial").is(":visible")) {
                    fechaInicial = $("#txtFechaInicial").val().split("/");
                }

                var fecha = new Date(fechaInicial[2], fechaInicial[1] - 1, fechaInicial[0]);

                $("#tblCuotas tbody").empty();
                for (var x = 0; x < numeroCuotas; x++) {
                    fecha.setMonth(fecha.getMonth() + 1);

                    $("#tblCuotas tbody").append("<tr><td>" + (x + 1) + "</td><td><input type='text' id='cuota_" + (x + 1) + "' class='form-control' onChange='modificarFechas(" + (x + 1) + "," + numeroCuotas + ");' value='" + formattedDate(fecha) + "' style='text-align:right;' /></td><td><input type='text' id='cuota_valor_" + (x + 1) + "' class='form-control' value='" + valorCuota.toFixed(2) + "' style='text-align:right;' onChange='calcularConvenio(" + (x + 1) + "," + numeroCuotas + ");' /></td></tr>");
                    //$("#tblCuotas tbody").append("<tr><td>" + (x + 1) + "</td><td><input type='text' id='cuota_" + (x + 1) + "' class='form-control' onChange='modificarFechas(" + (x + 1) + "," + numeroCuotas + ");' value='" + formattedDate(fecha) + "' style='text-align:right;' " + (rol == 4 || rol == 5 ? "readonly='true'" : "") + "/></td><td><input type='text' id='cuota_valor_" + (x + 1) + "' class='form-control' value='" + valorCuota.toFixed(2) + "' style='text-align:right;' onChange='calcularConvenio(" + (x + 1) + "," + numeroCuotas + ");' " + (rol == 4 || rol == 5 ? "readonly='true'" : "") + "/></td></tr>");

                    $("#cuota_" + (x + 1)).datepicker({
                        format: 'dd/mm/yyyy'
                    });
                    /*if (rol != 4 && rol != 5) {
                        $("#cuota_" + (x + 1)).datepicker({
                            format: 'dd/mm/yyyy'
                        });
                    }*/
                }
                $("#tblCuotas tfoot").html("<tr><td></td><td style='text-align:right;'>TOTAL</td><td style='text-align:right;' id='txtConvenioTotal'>" + saldoNegociacion.toFixed(2) + "</td></tr>");
            } catch (Err) {
            }
        }

        function modificarFechas(indice, nro_cuotas) {
            console.log($("#cuota_" + indice).val());
            var mi_fecha = $("#cuota_" + indice).val().split("/");
            console.log(mi_fecha);
            var fecha_nuevo = new Date(mi_fecha[2], mi_fecha[1] - 1, mi_fecha[0]);
            console.log(fecha_nuevo);
            for (var x = indice + 1; x <= nro_cuotas; x++) {
                fecha_nuevo.setMonth(fecha_nuevo.getMonth() + 1);
                $("#cuota_" + x).val(formattedDate(fecha_nuevo));
            }
        }

        function formattedDate(date) {
            var d = new Date(date || Date.now()),
                month = '' + (d.getMonth() + 1),
                day = '' + d.getDate(),
                year = d.getFullYear();

            if (month.length < 2) month = '0' + month;
            if (day.length < 2) day = '0' + day;

            return [day, month, year].join('/');
        }
        /*function calcularMonto() {
            try {
                var montoNegociado = parseFloat($("#txtMontoNegociacion").val());
                var numeroCuotas = parseFloat($("#txtNroCuotas").val());
                var montoRecibo;

                if ($("#txtReciboMonto").is(":visible")) {
                    montoRecibo = parseFloat($("#txtReciboMonto").val());
                } else if ($("#txtMontoInicial").is(":visible")) {
                    montoRecibo = parseFloat($("#txtMontoInicial").val());
                } else {
                    montoRecibo = 0.0;
                }

                var montoInicial;

                if ($("#txtReciboMonto").is(":visible")) {
                    montoInicial = parseFloat($("#txtReciboMonto").val());
                } else if ($("#txtMontoInicial").is(":visible")) {
                    montoInicial = parseFloat($("#txtMontoInicial").val());
                }

                var valorCuota = (montoNegociado - montoInicial) / numeroCuotas;
                $("#txtValorCuota").val(valorCuota.toFixed(2));

                var saldoNegociacion = montoNegociado - montoRecibo;
                $("#txtSaldoNegociacion").val(saldoNegociacion.toFixed(2));

                var fechaInicial;

                if ($("#txtReciboFecha").is(":visible")) {
                    fechaInicial = $("#txtReciboFecha").val().split("/");
                } else if ($("#txtFechaInicial").is(":visible")) {
                    fechaInicial = $("#txtFechaInicial").val().split("/");
                }

                var fecha = new Date(fechaInicial[2], fechaInicial[1] - 1, fechaInicial[0]);

                $("#tblCuotas tbody").empty();
                for (var x = 0; x < numeroCuotas; x++) {
                    fecha.setMonth(fecha.getMonth() + 1);

                    $("#tblCuotas tbody").append("<tr><td>" + (x + 1) + "</td><td>" + (fecha.getDate() + '/' + (fecha.getMonth() + 1) + '/' + fecha.getFullYear()) + "</td><td>" + valorCuota.toFixed(2) + "</td></tr>");
                }
            } catch (Err) { }
        }*/
    </script>
</asp:Content>
