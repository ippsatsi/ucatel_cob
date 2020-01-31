<%@ Page Title="" Language="C#" MasterPageFile="~/resource/masterPage/Popup.Master" AutoEventWireup="true" CodeBehind="gestionar-nuevo.aspx.cs" Inherits="WEB.cobranza.gestionar_nuevo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="<%=ResolveClientUrl("~/resource/assets/global/plugins/font-awesome/css/font-awesome.min.css")%>" rel="stylesheet" type="text/css" />
    <link href="<%=ResolveClientUrl("~/resource/assets/global/plugins/bootstrap-datepicker/css/bootstrap-datepicker.min.css")%>" rel="stylesheet" />
    <link href="<%=ResolveClientUrl("~/resource/assets/global/plugins/bootstrap-datepicker/css/bootstrap-datepicker.standalone.min.css")%>" rel="stylesheet" />
    <link href="<%=ResolveClientUrl("~/resource/assets/global/plugins/bootstrap-datepicker/css/bootstrap-datepicker3.standalone.min.css")%>" rel="stylesheet" />
    <link href="<%=ResolveClientUrl("~/resource/assets/global/plugins/bootstrap-timepicker/css/bootstrap-timepicker.min.css")%>" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="titulo" runat="server">
    NUEVA GESTIÓN
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contenido" runat="server">
    <input type="hidden" id="txtCodigoCliente" runat="server" value="0"/>
    <input type="hidden" id="txtCodigoCuenta" runat="server" value="0"/>
    <input type="hidden" id="txtCodigoRol" runat="server" value="0"/>
    <input type="hidden" id="txtCodigoCartera" runat="server" value="0"/>
    <input type="hidden" id="txtCodigoSubCartera" runat="server" value="0"/>
    <input type="hidden" id="txtDni" runat="server" value="0"/>
    <input type="hidden" id="txtCodigoTelefono" runat="server" value="0"/>
    <input type="hidden" id="txtCodigoDireccion" runat="server" value="0"/>
    <div class="container" style="height:400px; overflow-y:auto;">
        <div class="content">
            <div class="row">
                <div class="col-sm-6">
                    <label for="sltTipoGestion">TIPO DE GESTIÓN:</label>
                    <select id="sltTipoGestion" class="form-control">
                        <option value="00">-SELECCIONE-</option>
                    </select>
                </div>
                <div class="col-sm-6" id="divTelefono" style="display:none;">
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
                    <label for="txtNroCuotas">N° DE CUOTAS ADICIONALES:</label>
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
        
        <div class="content" id="divBusquedaEspecializada">
            <div class="col-sm-12">
                <div class="checkbox">
                    <label for="chkBusquedaEspecializada"><input type="checkbox" id="chkBusquedaEspecializada"/> BUSQUEDA ESPECIALIZADA</label>
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
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footer" runat="server">
    <button type="button" class="btn btn-primary" id="btnRegistrarGestion">ACEPTAR</button>
    <button type="button" class="btn btn-danger" onclick="parent.$.fancybox.close();">CANCELAR</button>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="script" runat="server">
    <script type="text/javascript" src='<%=ResolveClientUrl("~/resource/assets/global/plugins/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js")%>'></script>
    <script type="text/javascript" src='<%=ResolveClientUrl("~/resource/assets/global/plugins/bootstrap-datepicker/js/bootstrap-datepicker.min.js")%>'></script>
    <script type="text/javascript" src="<%=ResolveClientUrl("~/resource/assets/global/plugins/bootstrap-timepicker/js/bootstrap-timepicker.min.js")%>"></script>
    <script type="text/javascript" src='<%=ResolveClientUrl("~/resource/js/cobranza/gestionar-nuevo.js")%>'></script>
    <%--<script type="text/javascript" src='<%=ResolveClientUrl("~/resource/datetimepicker/moment-with-locales.js")%>'></script>
    <script type="text/javascript" src='<%=ResolveClientUrl("~/resource/datepicker/js/bootstrap-datepicker.js")%>'></script>
    <script type="text/javascript" src='<%=ResolveClientUrl("~/resource/datetimepicker/bootstrap-datetimepicker.js")%>'></script>
    --%>    
</asp:Content>
