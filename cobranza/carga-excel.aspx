<%@ Page Title="" Language="C#" MasterPageFile="~/resource/masterPage/Template.Master" AutoEventWireup="true" CodeBehind="carga-excel.aspx.cs" Inherits="WEB.cobranza.carga_excel" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contenido" runat="server">

    <div class="row">
        <div class="col-md-12">

            <div class="portlet box blue">
                <div class="portlet-title">
                    <div class="caption">
                        <i class="fa fa-globe"></i> CARGA DE ARCHIVOS</div>
                    <div class="tools"> </div>
                </div>
                <div class="portlet-body">

                    <div class="row">
                        <div class="col-lg-8 col-md-8 col-sm-8 col-xs-12 margin-bottom-20">
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

                        <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 margin-bottom-20">

                            <div class="col-md-4">
                                <label>CARGAR ARCHIVO (.TXT, .CSV)</label>
                                <input type="file" id="flArchivo" class="form-control">
                                <span id="txtMensaje"></span>
                            </div>
                            <div class="col-md-4">
                                <label>MONEDA</label>
                                <select id="sltMoneda" class="form-control">
                                    <option value="0">-SELECCIONA-</option>
                                </select>
                            </div>

                            <div class="col-md-4">
                                <label>&nbsp;</label> 
                                <a class="btn_buscar btn btn blue form-control" id="btn_registrar">REGISTRAR</a>
                            </div>
                        </div>
                    </div>

                    <table id="tblReporte" class="tblLista_grid table table-striped table-bordered table-hover dt-responsive" cellspacing="0" width="100%">
                        <thead>
                            <tr>
                                <th>NUEVOS</th>
                                <th>ACTUALIZACIONES</th>
                                <th>RETIROS</th>
                                <th>TOTAL</th>
                            </tr>
                        </thead>
                        <tbody></tbody>
                    </table>

                    <div class="bandeja-grid" id="divTblLista">
                        <table id="tblLista" class="tblLista_grid table table-striped table-bordered table-hover dt-responsive" cellspacing="0" width="100%">
                            <thead>
                                <tr>
                                    <th></th>
                                    <%--<th>GESTOR</th>
                                    <th>CALL</th>
                                    <th>CAMPO</th>--%>
                                    <th>SUB CARTERA</th>
                                    <th>N° CUENTA</th>
                                    <th>N° TARJETA</th>
                                    <th>DNI</th>
                                    <th>CLIENTE</th>
                                    <th>CAPITAL</th>
                                    <th>SALDO DEUDA</th>
                                    <th>DIAS</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody></tbody>
                        </table>
                    </div>
                        
                    <div id="divError" style="display:none;">
                        <table id="lstError" class="tblLista_grid table table-striped table-bordered table-hover dt-responsive" cellspacing="0" width="100%">
                            <thead>
                                <tr>
                                    <th>N°</th>
                                    <th>ERROR</th>
                                </tr>
                            </thead>
                            <tbody></tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="server">
    <script src="../resource/js/cobranza/carga-excel.js"></script>
</asp:Content>
