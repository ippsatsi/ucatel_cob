<%@ Page Title="" Language="C#" MasterPageFile="~/resource/masterPage/Template.Master" AutoEventWireup="true" CodeBehind="bandeja-principal.aspx.cs" Inherits="WEB.cobranza.bandeja_principal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <link href='<%=ResolveClientUrl("~/resource/assets/global/plugins/datatables/datatables.min.css") %>' rel="stylesheet" type="text/css" />
        <link href='<%=ResolveClientUrl("~/resource/assets/global/plugins/datatables/plugins/bootstrap/datatables.bootstrap.css") %>' rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content6" ContentPlaceHolderID="titulo" runat="server">
    BANDEJA DE GESTIONES
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="pageBar" runat="server">
    <div class="page-toolbar">
        <div class="clearfix">
            <div class="btn-group" data-toggle="buttons">
                <label class="btn blue-chambray active" id="chk_diario"><input type="radio" class="toggle"/> Gestiones de día </label>
                <label class="btn blue-chambray" id="chk_semanal"><input type="radio" class="toggle"/> Gestiones del mes </label>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="antesTitulo" runat="server">
    
    <h3 class="page-title"></h3>

    <div class="gestiones_diarias" style="display:none;">
        <div class="row">
            <div class="col-lg-6 col-md-6">
                <div class="row">
                    <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 margin-bottom-5">
                        <div class="dashboard-stat blue">
                            <div class="visual">
                                <i class="fa fa-list-alt fa-icon-medium"></i>
                            </div>
                            <div class="details">
                                <div class="number" id="txt_cant_gest_dia"></div>
                                <div class="desc"> Cantidad de Gestiones </div>
                            </div>
                            <div class="more">&nbsp;</div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 margin-bottom-5">
                        <div id="txt_cd_color_dia" class="dashboard-stat green">
                            <div class="visual">
                                <i class="fa fa-user"></i>
                            </div>
                            <div class="details">
                                <div class="number" id="txt_cant_cd_dia"></div>
                                <div class="desc"> Contacto Directo </div>
                            </div>
                            <div class="more" id="txt_cant_cd_porc_dia">&nbsp;</div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 margin-bottom-5">
                        <div id="txt_ci_color_dia" class="dashboard-stat green">
                            <div class="visual">
                                <i class="fa fa-group fa-icon-medium"></i>
                            </div>
                            <div class="details">
                                <div class="number" id="txt_cant_ci_dia"></div>
                                <div class="desc"> Contacto Indirecto </div>
                            </div>
                            <div class="more" id="txt_cant_ci_porc_dia">&nbsp;</div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-6 col-md-6">
                <div class="row">
                    <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 margin-bottom-5">
                        <div id="txt_nc_color_dia" class="dashboard-stat green">
                            <div class="visual">
                                <i class="fa fa-user-times fa-icon-medium"></i>
                            </div>
                            <div class="details">
                                <div class="number" id="txt_cant_nc_dia"></div>
                                <div class="desc"> No Contacto </div>
                            </div>
                            <div class="more" id="txt_cant_nc_porc_dia">&nbsp;</div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 margin-bottom-5">
                        <div class="dashboard-stat green">
                            <div class="visual">
                                <i class="fa fa-check"></i>
                            </div>
                            <div class="details">
                                <div class="number" id="txt_cant_cp_dia"></div>
                                <div class="desc"> Cantidad de compromisos </div>
                            </div>
                            <div class="more" id="txt_cant_cp_porc_dia">&nbsp;</div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 margin-bottom-5">
                        <div class="dashboard-stat blue-soft">
                            <div class="visual">
                                <i class="fa fa-money fa-icon-medium"></i>
                            </div>
                            <div class="details">
                                <div class="number" id="txt_monto_cp_dia"></div>
                                <div class="desc"> Monto de compromisos </div>
                            </div>
                            <div class="more">&nbsp;</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="gestiones_mes" style="display:none;">
        <div class="row">
            <div class="col-lg-6 col-md-6">
                <div class="row">
                    <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 margin-bottom-5">
                        <div class="dashboard-stat blue">
                            <div class="visual">
                                <i class="fa fa-list-alt fa-icon-medium"></i>
                            </div>
                            <div class="details">
                                <div class="number" id="txt_cant_gest_sem"></div>
                                <div class="desc"> Cantidad de Gestiones </div>
                            </div>
                            <div class="more" id="txtCantRegistros">&nbsp;</div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 margin-bottom-5">
                        <div id="txt_cd_color_sem" class="dashboard-stat green">
                            <div class="visual">
                                <i class="fa fa-user"></i>
                            </div>
                            <div class="details">
                                <div class="number" id="txt_cant_cd_sem"></div>
                                <div class="desc"> Contacto Directo </div>
                            </div>
                            <div class="more" id="txt_cant_cd_porc_sem">&nbsp;</div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 margin-bottom-5">
                        <div id="txt_ci_color_sem" class="dashboard-stat green">
                            <div class="visual">
                                <i class="fa fa-group fa-icon-medium"></i>
                            </div>
                            <div class="details">
                                <div class="number" id="txt_cant_ci_sem"></div>
                                <div class="desc"> Contacto Indirecto </div>
                            </div>
                            <div class="more" id="txt_cant_ci_porc_sem">&nbsp;</div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-6 col-md-6">
                <div class="row">
                    <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 margin-bottom-5">
                        <div id="txt_nc_color_sem" class="dashboard-stat green">
                            <div class="visual">
                                <i class="fa fa-user-times fa-icon-medium"></i>
                            </div>
                            <div class="details">
                                <div class="number" id="txt_cant_nc_sem"></div>
                                <div class="desc"> No Contacto </div>
                            </div>
                            <div class="more" id="txt_cant_nc_porc_sem">&nbsp;</div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 margin-bottom-5">
                        <div class="dashboard-stat green">
                            <div class="visual">
                                <i class="fa fa-check"></i>
                            </div>
                            <div class="details">
                                <div class="number" id="txt_cant_cp_sem"></div>
                                <div class="desc"> Cantidad de compromisos </div>
                            </div>
                            <div class="more" id="txt_cant_cp_porc_sem">&nbsp;</div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 margin-bottom-5">
                        <div class="dashboard-stat blue-soft">
                            <div class="visual">
                                <i class="fa fa-money fa-icon-medium"></i>
                            </div>
                            <div class="details">
                                <div class="number" id="txt_monto_cp_sem"></div>
                                <div class="desc"> Monto recaudado </div>
                            </div>
                            <div class="more">&nbsp;</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="contenido" runat="server">
    <div class="row" id="div_contenido">
        <div class="col-md-12">
            <input type="hidden" id="txt_rol_codigo" runat="server" />
            <input type="hidden" id="txt_usu_codigo" runat="server" />
            <div class="portlet box blue">
                <div class="portlet-title">
                    <div class="caption">
                        <i class="fa fa-globe"></i> Lista de Gestiones </div>
                    <div class="tools"> </div>
                </div>
                <div class="portlet-body">
                    <%--<div class="row">
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 margin-bottom-20">
                            <div class="col-md-4">
                                <label>PROVEEDOR</label>
                                <select class="form-control" id="sltProveedor">
                                    <option value="0">-SELECCIONE-</option>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <label>CARTERA</label>
                                <select class="form-control" id="sltCartera">
                                    <option value="0">-SELECCIONE-</option>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <label>SUB-CARTERA</label>
                                <select class="form-control" id="sltSubCartera">
                                    <option value="0">-SELECCIONE-</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 margin-bottom-20">    
                            <div class="col-md-6">
                                <label>RESULTADO</label>
                                <select class="form-control" id="sltResultado">
                                    <option value="0">-SELECCIONE-</option>
                                </select>
                            </div>
                            <div class="col-md-6" id="div_solucion" style="display:none;">
                                <label>SOLUCIÓN</label>
                                <select class="form-control" id="sltSolucion">
                                    <option value="0">-SELECCIONE-</option>
                                </select>
                            </div>
                        </div>
                        
                    </div>--%>

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
                            <div class="col-md-10">
                                <label>Seleccióna Tipo de contacto: </label>
                                <div class="clearfix">
                                    <div class="btn-group" data-toggle="buttons">
                                        <label class="btn btn-default input_check"><i class="fa fa-check valida_check"></i> <input type="checkbox" class="toggle" id="chkConDir">Cont. Directo</label>
                                        <label class="btn btn-default input_check"><i class="fa fa-check valida_check"></i> <input type="checkbox" class="toggle" id="chkConInd">Cont. Indirecto</label>
                                        <label class="btn btn-default input_check"><i class="fa fa-check valida_check"></i> <input type="checkbox" class="toggle" id="chkNoCont">No Contacto</label>
                                        <label class="btn btn-default input_check"><i class="fa fa-check valida_check"></i> <input type="checkbox" class="toggle" id="chkNoGest">No Gestionado</label>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <label>PP </label>
                                <select id="sltPeriodo" class="form-control">
                                    <option value="9">--</option>
                                    <option value="1">P1</option>
                                    <option value="2">P2</option>
                                    <option value="3">P3</option>
                                    <option value="4">P4</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="row">

                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 margin-bottom-20">
                            
                            <div class="col-md-4">
                                <label>FECHA DESDE</label>
                                <input type="text" id="txtDesde" class="form-control date-picker"/>
                            </div>
                            
                            <div class="col-md-4">
                                <label>FECHA HASTA</label>
                                <input type="text" id="txtHasta" class="form-control date-picker"/>
                            </div>

                            <div class="col-md-4">
                                <label>FILTROS</label>
                                <select id="sltFiltro" class="form-control">
                                </select>
                            </div>
                        </div>

                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 margin-bottom-20">
                            <div class="col-md-4">
                                <label>&nbsp;&nbsp;</label>
                                <input type="button" class="form-control btn blue btn_buscar" id="btn_buscar" value="BUSCAR"/>
                                <%--<img src="../resource/img/icons/phone-icon.png" id="btn_buscar_telefono" />--%>
                            </div>
                            <div class="col-md-4">
                                <label>&nbsp;&nbsp;</label>
                                <input type="button" class="form-control btn blue btn_buscar" id="btn_limpiar" value="LIMPIAR"/>
                                <%--<img src="../resource/img/icons/phone-icon.png" id="btn_buscar_telefono" />--%>
                            </div>
                            <div class="col-md-4">
                                <div><label>&nbsp;&nbsp;</label></div>
                                <a id="btn_buscar_telefono" class="btn btn-danger btn-circle"><i class="fa fa-phone"></i> LLAMADA</a>
                            </div>
                        </div>
                    </div>

                    <table id="tblLista" class="tblLista table table-striped table-bordered table-hover dt-responsive" cellspacing="0" width="100%">
                    <thead>
                        <tr>
                            <th class="all">Nº Cuenta</th>
                            <th class="min-saldo">PP</th>
                            <th class="min-proovedor">Proveedor</th>
                            <th class="min-cartera">Cartera</th>
                            <th class="min-subcartera">Sub Cartera</th>
                            <th class="min-dni">DNI</th>
                            <th class="min-cliente">Cliente</th>
                            <th class="none">Tipo Contacto</th>
                            <th class="none">Fecha contacto</th>
                            <th class="min-distrito">Distrito</th>
                            <th class="min-moneda">Moneda</th>
                            <th class="min-capital">Capital</th>
                            <th class="min-saldo">Saldo</th>
                            <th class="min-ultgestion">Última Gestión</th>
                            <th class="min-dias">Días mora</th>
                            <th class="min-dias">Días</th>
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
    <script type="text/javascript" src='<%=ResolveClientUrl("~/resource/js/cobranza/bandeja-principal.js")%>'></script>
    <script type="text/javascript" src='<%=ResolveClientUrl("~/resource/js/verificar_session.js")%>'></script>
    <script src="../resource/js/vita/vita.message.js"></script>
    <%--<script type="text/javascript" src='<%=ResolveClientUrl("~/resource/datatable/Scripts/DataTables-1.10.4/jquery.dataTables.js")%>'></script>--%>

    <script src='<%=ResolveClientUrl("~/resource/assets/global/scripts/datatable.js")%>' type="text/javascript"></script>
    <script src='<%=ResolveClientUrl("~/resource/assets/global/plugins/datatables/datatables.min.js")%>' type="text/javascript"></script>
    <script src='<%=ResolveClientUrl("~/resource/assets/global/plugins/datatables/plugins/bootstrap/datatables.bootstrap.js")%>' type="text/javascript"></script>

</asp:Content>