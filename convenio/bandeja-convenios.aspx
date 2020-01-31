<%@ Page Title="" Language="C#" MasterPageFile="~/resource/masterPage/Template.Master" AutoEventWireup="true" CodeBehind="bandeja-convenios.aspx.cs" Inherits="WEB.convenio.bandeja_convenios" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../../resource/datatables/css/jquery.dataTables.css"/>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contenido" runat="server">
    <div class="content">
        <div class="col-sm-12">
            <h3>BANDEJA DE CONVENIOS</h3>
            <div class="row">
                <div class="col-lg-2">
                    <label for="sltProveedor">PROVEEDOR:</label>
                    <select id="sltProveedor" class="form-control">
                        <option value="0">-SELECT-</option>
                    </select>
                </div>
                <div class="col-lg-2">
                    <label for="sltCartera">CARTERA:</label>
                    <select id="sltCartera" class="form-control">
                        <option value="0">-SELECT-</option>
                    </select>
                </div>
                <div class="col-lg-2">
                    <label for="txtNroCuenta">CUENTA:</label>
                    <input type="email" class="form-control" id="txtNroCuenta"/>
                </div>
                <div class="col-lg-2">
                    <label for="txtDni">DNI:</label>
                    <input type="email" class="form-control" id="txtDni"/>
                </div>
                <div class="col-lg-2">
                    <label for="txtCliente">CLIENTE:</label>
                    <input type="email" class="form-control" id="txtCliente"/>
                </div>
                <div class="col-lg-2">
                </div>
            </div>
            <div class="row">
                <div class="col-lg-2">
                    <label for="sltFiltro">FILTROS:</label><br />
                    <select id="sltFiltro" class="form-control">
                        <option value="">NUEVOS</option>
                        <option value="">PREVENTIVOS</option>
                        <option value="">A LA FECHA</option>
                        <option value="">VENCIDOS</option>
                    </select>
                </div>
                <div class="col-lg-2">
                    <label for="txtDesde">DESDE:</label>
                    <input type="email" class="form-control" id="txtDesde"/>
                </div>
                <div class="col-lg-2">
                    <label for="txtHasta">HASTA:</label>
                    <input type="email" class="form-control" id="txtHasta"/>
                </div>
                
                <div class="col-lg-2">
                    <label for="btn_buscar">&nbsp;</label><br />
                    <button type="button" class="btn btn-primary" id="btn_buscar">BUSCAR</button>
                </div>

                <div class="col-lg-2">
                    <label for="btn_buscar">&nbsp;</label><br />
                    <button type="button" class="btn btn-danger" onclick="javascript:location.href='convenio-nuevo.aspx'">NUEVO CONVENIO</button>
                </div>
                
                <div class="col-lg-2">
                </div>
            </div>
        </div>
    </div>
    <br />&nbsp;
    <br />
    <div class="content">
        <div class="col-sm-12">
            <div style="overflow-x:auto;">
                <table id="tblLista" class="table table-bordered tblLista_grid">
                    <thead>
                        <tr>
                            <th></th>
                            <th>N° CUENTA</th>
                            <%--<th>PROVEEDOR</th>
                            <th>CARTERA</th>--%>
                            <th>SUB CARTERA</th>
                            <th>DNI</th>
                            <th>CLIENTE</th>
                            <th>MONTO NEGOCIADO</th>
                            <th>CUOTAS</th>
                            <th>N° CUOTA</th>
                            <th>FECHA ULT. PAGO</th>
                            <th>FECHA PROX. PAGO</th>
                            <th>SALDO</th>
                            <th>DÍAS FALT.</th>
                            <th>DÍAS</th>
                            <th>CONVENIO</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>1</td>
                            <td>74215615656</td>
                            <%--<th>PROVEEDOR</th>
                            <th>CARTERA</th>--%>
                            <td>GALIPUCA</td>
                            <td>45612378</td>
                            <td>JUAN PEREZ SOLORZANO</td>
                            <td>37,600</td>
                            <td>5</td>
                            <td>3</td>
                            <td>08/09/2016</td>
                            <td>09/09/2016</td>
                            <td>26,600</td>
                            <td>21</td>
                            <td>200</td>
                            <td><a onclick="imprimir_pdf()"><i class="fa fa-file-pdf-o" aria-hidden="true"></i></a></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="script" runat="server">
    <script type="text/javascript" src='<%=ResolveClientUrl("~/resource/js/verificar_session.js")%>'></script>
    <script type="text/javascript" src='<%=ResolveClientUrl("~/resource/js/vita/vita.message.js")%>'></script>
    <script type="text/javascript" src='<%=ResolveClientUrl("~/resource/datatables/jquery.dataTables.js")%>'></script>
    <script type="text/javascript" src='<%=ResolveClientUrl("~/resource/datatables/jquery.dataTables.min.js")%>'></script>
    <script type="text/javascript" src='<%=ResolveClientUrl("~/resource/datatables/jquery.dataTables.sorting.js")%>'></script>
    <script type="text/javascript">
        function imprimir_pdf() {
            $.fancybox({
                type: "iframe",
                width: 600,
                height: 420,
                scrolling: 'no',
                href: "modelo/convenio.pdf"
            });
        }
    </script>
</asp:Content>
