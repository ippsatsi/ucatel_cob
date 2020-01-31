<%@ Page Title="" Language="C#" MasterPageFile="~/resource/masterPage/Template.Master" AutoEventWireup="true" CodeBehind="convenio-nuevo.aspx.cs" Inherits="WEB.convenio.convenio_nuevo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%--<link href="http://netdna.bootstrapcdn.com/twitter-bootstrap/2.3.1/css/bootstrap-combined.no-icons.min.css" rel="stylesheet">--%>
    <link href="http://netdna.bootstrapcdn.com/twitter-bootstrap/2.3.1/css/bootstrap-responsive.min.css" rel="stylesheet">
	<link href="http://netdna.bootstrapcdn.com/font-awesome/3.0.2/css/font-awesome.css" rel="stylesheet">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contenido" runat="server">
    <div class="container-fluid">
        <%--<asp:HiddenField runat="server" ID="txtCuenta" />
        <input type="hidden" id="txtCodigoCliente" value="0"/>
        <input type="hidden" id="txtCodigoProveedor" value="0"/>
        <input type="hidden" id="txtCodigoCuenta" value="0"/>
        <input type="hidden" id="txtCodigoCartera" value="0"/>
        <input type="hidden" id="txtCodigoSubCartera" value="0"/>
        <input type="hidden" id="txtCodigoGestion" value="0"/>
        <input type="hidden" id="txtCodigoRol" runat="server" value="0"/>--%>
        <div class="row content">
            <div class="col-sm-3 sidenav">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                      <h3 class="panel-title"><i class="fa fa-user" aria-hidden="true"></i> DATOS DEL CLIENTE</h3>
                    </div>
                    <div class="panel-body">
                        <div class="form-group">
                            <img src="resource/img/sin-imagen.png" class="img-thumbnail" alt="Cinque Terre" width="304" height="236"/>
                        </div>
                        <div class="form-group">
                            <label for="txtDni">DNI:</label><br />
                            <span id="txtDni"></span>
                        </div>
                        <div class="form-group">
                            <label for="txtNombres">NOMBRES Y APELLIDOS:</label><br />
                            <span id="txtNombres"></span>
                        </div>
                        <div class="form-group">
                            <label for="txtDireccion">DIRECCIÓN:</label><br />
                            <span id="txtDireccion"></span><br />
                            <span id="txtUbigeo"></span>
                        </div>
                        <div class="form-group">
                            <label for="txtNombres">CORREO:</label><br />
                            <span id="txtCorreo"></span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-sm-9">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                      <h3 class="panel-title"><i class="fa fa-credit-card-alt" aria-hidden="true"></i> DATOS DEL CONVENIO</h3>
                    </div>
                    <div class="panel-body">
                        <div class="panel-group">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="panel-title">
                                    <a data-toggle="collapse" href="#collapse1">BUSQUEDA DEL CLIENTE</a>
                                    </h4>
                                </div>
                                <div id="collapse1" class="panel-collapse collapse in">
                                    <div class="panel-body">
                                        <div class="content">
                                            <div class="form-group row">
                                              <div class="col-xs-3">
                                                  <select class="form-control" id="">
                                                      <option>DNI</option>
                                                      <option>N° CUENTA</option>
                                                  </select>
                                              </div>
                                              <div class="col-xs-3">
                                                <input class="form-control" type="text" id="txtTexto"/>
                                              </div>
                                              <div class="col-xs-2">
                                                <input class="form-control" type="button" value="BUSCAR"/>
                                              </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="panel-footer">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="panel-group">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="panel-title">
                                    <a data-toggle="collapse" href="#collapse2">DATOS DE LA CUENTA</a>
                                    </h4>
                                </div>
                                <div id="collapse2" class="panel-collapse collapse in"><br />
                                    <div class="content">
                                        <div class="form-group row">
                                            <div class="col-xs-6">
                                                <label for="txtProveedor" class="col-xs-4 col-form-label">PROVEEDOR</label>
                                                <div class="col-xs-8">
                                                    <input class="form-control" type="text" id="txtProveedor" readonly="true" value="BANCO FALABELLA"/>
                                                </div>
                                            </div>
                                            <div class="col-xs-6">
                                                <label for="txtProveedor" class="col-xs-4 col-form-label">N° CUENTA</label>
                                                <div class="col-xs-8">
                                                    <input class="form-control" type="text" id="Text1" readonly="true" value="7547252911"/>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <div class="col-xs-6">
                                                <label for="txtProveedor" class="col-xs-4 col-form-label">MONEDA</label>
                                                <div class="col-xs-8">
                                                    <input class="form-control" type="text" id="Text2" readonly="true" value="SOLES"/>
                                                </div>
                                            </div>
                                            <div class="col-xs-6">
                                                <label for="txtProveedor" class="col-xs-4 col-form-label">MONTO CAPITAL</label>
                                                <div class="col-xs-8">
                                                    <input class="form-control" type="text" id="Text3" readonly="true" value="35,600"/>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <div class="col-xs-6">
                                            </div>
                                            <div class="col-xs-6">
                                                <label for="txtProveedor" class="col-xs-4 col-form-label">DEUDA TOTAL</label>
                                                <div class="col-xs-8">
                                                    <input class="form-control" type="text" id="Text5" readonly="true" value="37,600"/>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="panel-footer">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="panel-group">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="panel-title">
                                    <a data-toggle="collapse" href="#collapse3">DATOS DEL ESTUDIO</a>
                                    </h4>
                                </div>
                                <div id="collapse3" class="panel-collapse collapse in">
                                    <br />
                                    <div class="content">
                                        <div class="form-group row">
                                            <div class="col-xs-6">
                                                <label for="txtProveedor" class="col-xs-4 col-form-label">ESTUDIO</label>
                                                <div class="col-xs-8">
                                                    <input class="form-control" type="text" id="Text4" readonly="true" value="ESTUDIO GALICIA S.A.C."/>
                                                </div>
                                            </div>
                                            <div class="col-xs-6">
                                                <label for="txtProveedor" class="col-xs-4 col-form-label">PARTIDA</label>
                                                <div class="col-xs-8">
                                                    <input class="form-control" type="text" id="Text10" readonly="true" value="11973574"/>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <div class="col-xs-6">
                                                <label for="txtProveedor" class="col-xs-4 col-form-label">REPRESENTANTE</label>
                                                <div class="col-xs-8">
                                                    <input class="form-control" type="text" id="Text6" readonly="true" value="Dr. Victor Raúl Galicia Cruzatte"/>
                                                </div>
                                            </div>
                                            <div class="col-xs-6">
                                                <label for="txtProveedor" class="col-xs-4 col-form-label">DNI</label>
                                                <div class="col-xs-8">
                                                    <input class="form-control" type="text" id="Text8" readonly="true" value="09312345"/>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <div class="col-xs-12">
                                                <label for="txtProveedor" class="col-xs-2 col-form-label">DOMICILIO</label>
                                                <div class="col-xs-10">
                                                    <input class="form-control" type="text" id="Text7" readonly="true" value="Calle 28 Pasaje 22 N° 121 Urb. Córpac, Distrito de San Isidro"/>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="panel-footer">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="panel-group">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="panel-title">
                                    <a data-toggle="collapse" href="#collapse4">ESTUDIO CONVENIO ANTERIOR</a>
                                    </h4>
                                </div>
                                <div id="collapse4" class="panel-collapse collapse">
                                    <br />
                                    <div class="content">
                                        <div class="form-group row">
                                            <div class="col-xs-12">
                                                <label for="txtProveedor" class="col-xs-2 col-form-label">ESTUDIO</label>
                                                <div class="col-xs-10">
                                                    <input class="form-control" type="text" id="Text9" value="SERVICIOS EXTERNOS S.A.C. / SERVEX"/>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <div class="col-xs-12">
                                                <label for="txtMencion" class="col-xs-2 col-form-label">MENCIÓN</label>
                                                <div class="col-xs-10">
                                                    <textarea id="txtMencion" class="form-control"></textarea>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="panel-footer">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="panel-group">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="panel-title">
                                    <a data-toggle="collapse" href="#collapse5">ACUERDO DE PAGO</a>
                                    </h4>
                                </div>
                                <div id="collapse5" class="panel-collapse collapse in">
                                    <br />
                                    <div class="content">
                                        <div class="form-group row">
                                            <div class="col-xs-6">
                                                <label for="txtProveedor" class="col-xs-4 col-form-label">MONTO NEGOCIADO</label>
                                                <div class="col-xs-8">
                                                    <input class="form-control" type="text" id="Text11" value="37,600"/>
                                                </div>
                                            </div>
                                            <div class="col-xs-6">
                                                <label for="txtProveedor" class="col-xs-4 col-form-label">FECHA PAGO</label>
                                                <div class="col-xs-8">
                                                    <input class="form-control" type="text" id="Text12" value="12/02/2016"/>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <div class="col-xs-6">
                                                <label for="txtProveedor" class="col-xs-4 col-form-label">CUOTA INICIAL</label>
                                                <div class="col-xs-8">
                                                    <input class="form-control" type="text" id="Text13" value="3,760"/>
                                                </div>
                                            </div>
                                            <div class="col-xs-6">
                                                <label for="txtProveedor" class="col-xs-4 col-form-label">N° CUOTAS</label>
                                                <div class="col-xs-8">
                                                    <input class="form-control" type="text" id="Text14" value="11"/>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <%--<div class="panel-body table-responsive" style="overflow:auto; height:400px;">--%>
                                    <div class="panel-body table-responsive">
                                        <h4>CRONOGRAMA</h4>
                                        <table id="tblMultas" class="table table-bordered">
                                            <thead>
                                                <tr>
                                                    <th class="col-lg-4">CUOTA</th>
                                                    <th class="col-lg-4">FECHA</th>
                                                    <th class="col-lg-4">MONTO</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td>1°</td>
                                                    <td>12/02/2016</td>
                                                    <td><input class="form-control" type="text" value="966.90"/></td>
                                                </tr>
                                                <tr>
                                                    <td>2°</td>
                                                    <td>12/03/2016</td>
                                                    <td><input class="form-control" type="text" value="966.90"/></td>
                                                </tr>
                                                <tr>
                                                    <td>3°</td>
                                                    <td>12/04/2016</td>
                                                    <td><input class="form-control" type="text" value="966.90"/></td>
                                                </tr>
                                                <tr>
                                                    <td>4°</td>
                                                    <td>12/05/2016</td>
                                                    <td><input class="form-control" type="text" value="3600.90"/></td>
                                                </tr>
                                                <tr>
                                                    <td>5°</td>
                                                    <td>12/06/2016</td>
                                                    <td><input class="form-control" type="text" value="966.90"/></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="panel-footer">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="panel-group">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="panel-title">
                                    <a data-toggle="collapse" href="#collapse6">FORMATO DE CONVENIO DE PAGO</a>
                                    </h4>
                                </div>
                                <div id="collapse6" class="panel-collapse collapse in">
                                    <div class="content">
                                        <div class="btn-toolbar" data-role="editor-toolbar" data-target="#editor">
                                            <div class="btn-group">
                                            <a class="btn dropdown-toggle" data-toggle="dropdown" title="Font"><i class="icon-font"></i><b class="caret"></b></a>
                                                <ul class="dropdown-menu">
                                                </ul>
                                            </div>
                                            <div class="btn-group">
                                            <a class="btn dropdown-toggle" data-toggle="dropdown" title="Font Size"><i class="icon-text-height"></i>&nbsp;<b class="caret"></b></a>
                                                <ul class="dropdown-menu">
                                                <li><a data-edit="fontSize 5"><font size="5">Huge</font></a></li>
                                                <li><a data-edit="fontSize 3"><font size="3">Normal</font></a></li>
                                                <li><a data-edit="fontSize 1"><font size="1">Small</font></a></li>
                                                </ul>
                                            </div>
                                            <div class="btn-group">
                                            <a class="btn" data-edit="bold" title="Bold (Ctrl/Cmd+B)"><i class="icon-bold"></i></a>
                                            <a class="btn" data-edit="italic" title="Italic (Ctrl/Cmd+I)"><i class="icon-italic"></i></a>
                                            <a class="btn" data-edit="strikethrough" title="Strikethrough"><i class="icon-strikethrough"></i></a>
                                            <a class="btn" data-edit="underline" title="Underline (Ctrl/Cmd+U)"><i class="icon-underline"></i></a>
                                            </div>
                                            <div class="btn-group">
                                            <a class="btn" data-edit="insertunorderedlist" title="Bullet list"><i class="icon-list-ul"></i></a>
                                            <a class="btn" data-edit="insertorderedlist" title="Number list"><i class="icon-list-ol"></i></a>
                                            <a class="btn" data-edit="outdent" title="Reduce indent (Shift+Tab)"><i class="icon-indent-left"></i></a>
                                            <a class="btn" data-edit="indent" title="Indent (Tab)"><i class="icon-indent-right"></i></a>
                                            </div>
                                            <div class="btn-group">
                                            <a class="btn" data-edit="justifyleft" title="Align Left (Ctrl/Cmd+L)"><i class="icon-align-left"></i></a>
                                            <a class="btn" data-edit="justifycenter" title="Center (Ctrl/Cmd+E)"><i class="icon-align-center"></i></a>
                                            <a class="btn" data-edit="justifyright" title="Align Right (Ctrl/Cmd+R)"><i class="icon-align-right"></i></a>
                                            <a class="btn" data-edit="justifyfull" title="Justify (Ctrl/Cmd+J)"><i class="icon-align-justify"></i></a>
                                            </div>
                                            <div class="btn-group">
		                                        <a class="btn dropdown-toggle" data-toggle="dropdown" title="Hyperlink"><i class="icon-link"></i></a>
		                                        <div class="dropdown-menu input-append">
			                                        <input class="span2" placeholder="URL" type="text" data-edit="createLink"/>
			                                        <button class="btn" type="button">Add</button>
                                            </div>
                                            <a class="btn" data-edit="unlink" title="Remove Hyperlink"><i class="icon-cut"></i></a>

                                            </div>
      
                                            <div class="btn-group">
                                            <a class="btn" title="Insert picture (or just drag & drop)" id="pictureBtn"><i class="icon-picture"></i></a>
                                            <input type="file" data-role="magic-overlay" data-target="#pictureBtn" data-edit="insertImage" />
                                            </div>
                                            <div class="btn-group">
                                            <a class="btn" data-edit="undo" title="Undo (Ctrl/Cmd+Z)"><i class="icon-undo"></i></a>
                                            <a class="btn" data-edit="redo" title="Redo (Ctrl/Cmd+Y)"><i class="icon-repeat"></i></a>
                                            </div>
                                            <input type="text" data-edit="inserttext" id="voiceBtn" x-webkit-speech="">
                                        </div>

                                        <div id="editor">
                                            
                                            <p class=3DMsoNormal style=3D'text-align:justify'><span style=3D'font-size:=
                                            11.0pt;
                                            font-family:"Bookman Old Style",serif;mso-bidi-font-family:Arial'>El pago de
                                            toda suma de dinero aquí acordada deberá ser efectuado en cualquier caja de=
                                            l <b
                                            style=3D'mso-bidi-font-weight:normal'>BANCO FALABELLA PERÚ S.A</b>, debiend=
                                            o <b
                                            style=3D'mso-bidi-font-weight:normal'>EL CLIENTE</b>, necesariamente entreg=
                                            ar una
                                            copia simple del comprobante de pago a EL ESTUDIO, en forma personal o vía
                                            email a los correos </span><a href=3D"mailto:palburqueque@estudiogalicia.co=
                                            m"><span
                                            style=3D'font-size:11.0pt;font-family:"Bookman Old Style",serif;mso-bidi-fo=
                                            nt-family:
                                            Arial;color:windowtext;text-decoration:none;text-underline:none'>palburqueq=
                                            ue@estudiogalicia.com</span></a><span
                                            style=3D'font-size:11.0pt;font-family:"Bookman Old Style",serif;mso-bidi-fo=
                                            nt-family:
                                            Arial'>. y/o </span>arivasplata@estudiogalicia.com<span style=3D'font-size:=
                                            11.0pt;
                                            font-family:"Bookman Old Style",serif;mso-bidi-font-family:Arial'><o:p></o:=
                                            p></span></p>

                                            <p class=3DMsoNormal style=3D'text-align:justify'><span style=3D'font-size:=
                                            11.0pt;
                                            font-family:"Bookman Old Style",serif;mso-bidi-font-family:Arial'><o:p>&nbs=
                                            p;</o:p></span></p>

                                            <p class=3DMsoNormal style=3D'text-align:justify'><span style=3D'font-size:=
                                            11.0pt;
                                            font-family:"Bookman Old Style",serif;mso-bidi-font-family:Arial'>Asimismo,=
                                             una
                                            vez cancelado la totalidad de las cuotas estipuladas en el presente conveni=
                                            o, <b
                                            style=3D'mso-bidi-font-weight:normal'>EL ESTUDIO</b> informará a <b
                                            style=3D'mso-bidi-font-weight:normal'>EL BANCO</b> para el ajuste respectiv=
                                            o de
                                            la deuda y así <b style=3D'mso-bidi-font-weight:normal'>EL CLIENTE</b> obte=
                                            nga su
                                            carta de no adeudo a un plazo máximo de 15 días hábiles; para ello, <b
                                            style=3D'mso-bidi-font-weight:normal'>EL CLIENTE</b> tiene como responsabil=
                                            idad
                                            acercarse a la entidad financiera a solicitarla.<o:p></o:p></span></p>

                                            <p class=3DMsoNormal style=3D'text-align:justify'><span style=3D'font-size:=
                                            11.0pt;
                                            font-family:"Bookman Old Style",serif;mso-bidi-font-family:Arial'><o:p>&nbs=
                                            p;</o:p></span></p>

                                            <p class=3DMsoNormal style=3D'text-align:justify'><b style=3D'mso-bidi-font=
                                            -weight:
                                            normal'><span style=3D'font-size:11.0pt;font-family:"Bookman Old Style",ser=
                                            if;
                                            mso-bidi-font-family:Arial'>CUARTO.- EL ESTUDIO</span></b><span
                                            style=3D'font-size:11.0pt;font-family:"Bookman Old Style",serif;mso-bidi-fo=
                                            nt-family:
                                            Arial'>, asume el compromiso de no iniciar o en su defecto de no continuar =
                                            el proceso
                                            de cobranza por la vía judicial, mientras EL CLIENTE cumpla con el pago
                                            completo y oportuno de todas y cada una de las cuotas establecidas en el
                                            presente convenio. No obstante ello, <b style=3D'mso-bidi-font-weight:norma=
                                            l'>BANCO
                                            FALABELLA PERÚ S.A y/o EL ESTUDIO</b> podrán continuar realizando gestiones=
                                             de
                                            cobranza extrajudiciales, que impliquen comunicaciones escritas u orales a =
                                            <b
                                            style=3D'mso-bidi-font-weight:normal'>EL CLIENTE</b>.<o:p></o:p></span></p>

                                            <p class=3DMsoNormal style=3D'text-align:justify'><span style=3D'font-size:=
                                            11.0pt;
                                            font-family:"Bookman Old Style",serif;mso-bidi-font-family:Arial'><o:p>&nbs=
                                            p;</o:p></span></p>

                                            <p class=3DMsoNormal style=3D'text-align:justify'><b style=3D'mso-bidi-font=
                                            -weight:
                                            normal'><span style=3D'font-size:11.0pt;font-family:"Bookman Old Style",ser=
                                            if;
                                            mso-bidi-font-family:Arial'>QUINTO</span></b><span style=3D'font-size:11.0p=
                                            t;
                                            font-family:"Bookman Old Style",serif;mso-bidi-font-family:Arial'>.- En cas=
                                            o de
                                            incumplimiento de pago de cualquiera de las cuotas antes señaladas, las par=
                                            tes
                                            acuerdan que <b style=3D'mso-bidi-font-weight:normal'>EL ESTUDIO</b> podrá =
                                            optar
                                            por cualquiera de las alternativas siguientes:<o:p></o:p></span></p>

                                            <p class=3DMsoNormal style=3D'text-align:justify'><span style=3D'font-size:=
                                            11.0pt;
                                            font-family:"Bookman Old Style",serif;mso-bidi-font-family:Arial'><o:p>&nbs=
                                            p;</o:p></span></p>

                                            <p class=3DMsoNormal style=3D'margin-left:53.25pt;text-align:justify'><b
                                            style=3D'mso-bidi-font-weight:normal'><span style=3D'font-size:11.0pt;font-=
                                            family:
                                            "Bookman Old Style",serif;mso-bidi-font-family:Arial'>5.1. EL ESTUDIO</span=
                                            ></b><span
                                            style=3D'font-size:11.0pt;font-family:"Bookman Old Style",serif;mso-bidi-fo=
                                            nt-family:
                                            Arial'> sin necesidad de comunicación previa podrá iniciar o en su defecto
                                            continuar las acciones legales correspondientes a la recuperación en vía
                                            judicial del real saldo pendiente de pago según la liquidación practicada p=
                                            or
                                            el <b style=3D'mso-bidi-font-weight:normal'>BANCO FALABELLA PERU S.A</b>., =
                                            con
                                            los intereses devengados correspondientes a la fecha de pago efectivo, de
                                            acuerdo a lo establecido en el tarifario vigente, más costas y costos <span
                                            style=3D'mso-spacerun:yes'> </span>procesales; interponiendo las medidas
                                            cautelares que sean necesarias con la finalidad de conseguir la cobranza del
                                            integro de la deuda.<o:p></o:p></span></p>

                                            <p class=3DMsoNormal style=3D'margin-left:53.25pt;text-align:justify'><v:sh=
                                            ape
                                             id=3D"_x0000_s1051" type=3D"#_x0000_t136" style=3D'position:absolute;left:=
                                            0;
                                             text-align:left;margin-left:-53.6pt;margin-top:-7.35pt;width:120.2pt;heigh=
                                            t:30.55pt;
                                             rotation:270;z-index:-251652096;mso-position-horizontal-relative:text;
                                             mso-position-vertical-relative:text' fillcolor=3D"black">
                                             <v:stroke src=3D"CONVENIOCMR-MERINOARAOZweb_archivos/image001.jpg" o:title=
                                            =3D""/>
                                             <v:shadow color=3D"#868686"/>
                                             <v:textpath style=3D'font-family:"Arial Unicode MS";font-size:8pt;v-text-k=
                                            ern:t'
                                              trim=3D"t" fitpath=3D"t" string=3D"......................................=
                                            ..................&#13;&#10; VICTOR R. GALICIA CRUZATTE&#13;&#10;     ABOGA=
                                            DO - APODERADO&#13;&#10;  Reg. C.A.L N° 41264"/>
                                            </v:shape><span style=3D'font-size:11.0pt;font-family:"Bookman Old Style",s=
                                            erif;
                                            mso-bidi-font-family:Arial'><o:p></o:p></span></p>

                                            <p class=3DMsoNormal style=3D'margin-left:53.25pt;text-align:justify'><span
                                            style=3D'font-size:11.0pt;font-family:"Bookman Old Style",serif;mso-bidi-fo=
                                            nt-family:
                                            Arial'>5.2. Mantener vigente el presente convenio de pagos, para lo cual <b
                                            style=3D'mso-bidi-font-weight:normal'>EL CLIENTE</b> deberá CANCELAR el ínt=
                                            egro
                                            de las cuotas que pudiera estar <o:p></o:p></span></p>

                                            <p class=3DMsoNormal style=3D'margin-left:53.25pt;text-align:justify'><span
                                            style=3D'font-size:11.0pt;font-family:"Bookman Old Style",serif;mso-bidi-fo=
                                            nt-family:
                                            Arial'>Adeudando, al solo requerimiento del <b style=3D'mso-bidi-font-weigh=
                                            t:
                                            normal'>EL ESTUDIO.<o:p></o:p></b></span></p>

                                            <p class=3DMsoNormal style=3D'text-align:justify'><b style=3D'mso-bidi-font=
                                            -weight:
                                            normal'><span style=3D'font-size:11.0pt;font-family:"Bookman Old Style",ser=
                                            if;
                                            mso-bidi-font-family:Arial'><o:p>&nbsp;</o:p></span></b></p>

                                            <p class=3DMsoNormal style=3D'margin-left:53.25pt;text-align:justify'><b
                                            style=3D'mso-bidi-font-weight:normal'><span style=3D'font-size:11.0pt;font-=
                                            family:
                                            "Bookman Old Style",serif;mso-bidi-font-family:Arial'><o:p>&nbsp;</o:p></sp=
                                            an></b></p>

                                            <p class=3DMsoNormal style=3D'text-align:justify'><span style=3D'font-size:=
                                            11.0pt;
                                            font-family:"Bookman Old Style",serif;mso-bidi-font-family:Arial'><o:p>&nbs=
                                            p;</o:p></span></p>

                                            <p class=3DMsoNormal style=3D'text-align:justify'><b style=3D'mso-bidi-font=
                                            -weight:
                                            normal'><span style=3D'font-size:11.0pt;font-family:"Bookman Old Style",ser=
                                            if;
                                            mso-bidi-font-family:Arial'>SEXTO</span></b><span style=3D'font-size:11.0pt;
                                            font-family:"Bookman Old Style",serif;mso-bidi-font-family:Arial'>.- Las pa=
                                            rtes
                                            acuerdan que lo indicado en el presente documento constituye una facilidad =
                                            de
                                            pago que <b style=3D'mso-bidi-font-weight:normal'>BANCO FALABELLA PERU S.A<=
                                            /b>.
                                            otorga a <b style=3D'mso-bidi-font-weight:normal'>EL CLIENTE</b>, sin embar=
                                            go, lo
                                            pactado no debe entenderse como un nuevo cronograma, modificación de plazos,
                                            refinanciación, extinción ni novación de la deuda que <b style=3D'mso-bidi-=
                                            font-weight:
                                            normal'>EL CLIENTE</b> mantiene pendiente de pago con <b style=3D'mso-bidi-=
                                            font-weight:
                                            normal'>BANCO FALABELLA PERÚ S.A</b>., ya que la deuda mencionada continúa =
                                            siendo
                                            exigible en su totalidad <b style=3D'mso-bidi-font-weight:normal'>por BANCO
                                            FALABELLA PERÚ S.A. a EL CLIENTE.<o:p></o:p></b></span></p>

                                            <p class=3DMsoNormal style=3D'text-align:justify'><span style=3D'font-size:=
                                            11.0pt;
                                            font-family:"Bookman Old Style",serif;mso-bidi-font-family:Arial'><o:p>&nbs=
                                            p;</o:p></span></p>

                                            <p class=3DMsoNormal style=3D'text-align:justify'><span style=3D'font-size:=
                                            11.0pt;
                                            font-family:"Bookman Old Style",serif;mso-bidi-font-family:Arial'><o:p>&nbs=
                                            p;</o:p></span></p>

                                            <p class=3DMsoNormal style=3D'text-align:justify'><span style=3D'font-size:=
                                            11.0pt;
                                            font-family:"Bookman Old Style",serif;mso-bidi-font-family:Arial'>En caso <b
                                            style=3D'mso-bidi-font-weight:normal'>EL CLIENTE</b> incumpla con el pago d=
                                            e las
                                            cuotas antes mencionadas, este acuerdo quedará automáticamente sin efecto y=
                                             <b
                                            style=3D'mso-bidi-font-weight:normal'>BANCO FALABELLA PERÚ S.A. </b>y/o<b
                                            style=3D'mso-bidi-font-weight:normal'> EL ESTUDIO</b> quedarán facultados p=
                                            ara
                                            realizar la cobranza del monto total adeudado a la fecha más los intereses<=
                                            span
                                            style=3D'mso-spacerun:yes'>  </span>que se generen hasta la fecha de pago
                                            efectivo, de acuerdo a lo establecido en el tarifario vigente.<o:p></o:p></=
                                            span></p>

                                            <p class=3DMsoNormal style=3D'text-align:justify'><span style=3D'font-size:=
                                            11.0pt;
                                            font-family:"Bookman Old Style",serif;mso-bidi-font-family:Arial'><span
                                            style=3D'mso-spacerun:yes'> </span><o:p></o:p></span></p>

                                            <p class=3DMsoNormal style=3D'text-align:justify'><span style=3D'font-size:=
                                            11.0pt;
                                            font-family:"Bookman Old Style",serif;mso-bidi-font-family:Arial'><o:p>&nbs=
                                            p;</o:p></span></p>

                                            <p class=3DMsoNormal style=3D'text-align:justify'><span style=3D'font-size:=
                                            11.0pt;
                                            font-family:"Bookman Old Style",serif;mso-bidi-font-family:Arial'>Asimismo,=
                                             las
                                            partes declaran que el presente convenio de pagos no constituye una transac=
                                            ción
                                            extrajudicial, por lo que no podrá ser opuesta como tal ante ninguna autori=
                                            dad
                                            administrativa, judicial ni de cualquier otra índole.<o:p></o:p></span></p>

                                            <p class=3DMsoNormal style=3D'text-align:justify'><span style=3D'font-size:=
                                            11.0pt;
                                            font-family:"Bookman Old Style",serif;mso-bidi-font-family:Arial'><o:p>&nbs=
                                            p;</o:p></span></p>

                                            <p class=3DMsoNormal style=3D'text-align:justify'><span style=3D'font-size:=
                                            11.0pt;
                                            font-family:"Bookman Old Style",serif;mso-bidi-font-family:Arial'><o:p>&nbs=
                                            p;</o:p></span></p>

                                            <p class=3DMsoNormal style=3D'text-align:justify'><b style=3D'mso-bidi-font=
                                            -weight:
                                            normal'><span style=3D'font-size:11.0pt;font-family:"Bookman Old Style",ser=
                                            if;
                                            mso-bidi-font-family:Arial'>SEPTIMO</span></b><span style=3D'font-size:11.0=
                                            pt;
                                            font-family:"Bookman Old Style",serif;mso-bidi-font-family:Arial'>.- Tenien=
                                            do
                                            en cuenta que ya no recibe estados de cuenta mensuales en su domicilio, por=
                                             el
                                            presente documento <b style=3D'mso-bidi-font-weight:normal'>EL CLIENTE</b>
                                            declara su aceptación expresa e irrevocable para que personal de <b
                                            style=3D'mso-bidi-font-weight:normal'>EL ESTUDIO</b> pueda realizarle llama=
                                            das
                                            recordatorias para el pago de sus cuotas, de lunes a sábado entre las 07:00=
                                             am
                                            y 21:00 pm horas, así como enviarle mensajes de textos a su celular o a su
                                            dirección electrónica que para estos efectos señala en el presente document=
                                            o;
                                            y/o realizar cualquier otra acción para efectos del pago de su deuda.<o:p><=
                                            /o:p></span></p>

                                            <p class=3DMsoNormal style=3D'text-align:justify'><span style=3D'font-size:=
                                            11.0pt;
                                            font-family:"Bookman Old Style",serif;mso-bidi-font-family:Arial'><o:p>&nbs=
                                            p;</o:p></span></p>

                                            <p class=3DMsoNormal style=3D'text-align:justify'><span style=3D'font-size:=
                                            11.0pt;
                                            font-family:"Bookman Old Style",serif;mso-bidi-font-family:Arial'><o:p>&nbs=
                                            p;</o:p></span></p>

                                            <p class=3DMsoNormal style=3D'text-align:justify'><b style=3D'mso-bidi-font=
                                            -weight:
                                            normal'><span style=3D'font-size:11.0pt;font-family:"Bookman Old Style",ser=
                                            if;
                                            mso-bidi-font-family:Arial'>OCTAVO.- EL CLIENTE</span></b><span
                                            style=3D'font-size:11.0pt;font-family:"Bookman Old Style",serif;mso-bidi-fo=
                                            nt-family:
                                            Arial'> señala como su domicilio el indicado en la introducción del presente
                                            instrumento, al cual se le enviarán las comunicaciones y notificaciones que=
                                             se
                                            deriven del presente acuerdo.<o:p></o:p></span></p>

                                            <p class=3DMsoNormal style=3D'text-align:justify'><span style=3D'font-size:=
                                            11.0pt;
                                            font-family:"Bookman Old Style",serif;mso-bidi-font-family:Arial'><o:p>&nbs=
                                            p;</o:p></span></p>

                                            <p class=3DMsoNormal style=3D'text-align:justify'><span style=3D'font-size:=
                                            11.0pt;
                                            font-family:"Bookman Old Style",serif;mso-bidi-font-family:Arial'><o:p>&nbs=
                                            p;</o:p></span></p>

                                            <p class=3DMsoNormal style=3D'text-align:justify'><span style=3D'font-size:=
                                            11.0pt;
                                            font-family:"Bookman Old Style",serif;mso-bidi-font-family:Arial'>De acuerd=
                                            o a
                                            lo establecido en el artículo 66.1 de la Ley N° 27287, Ley de Títulos Valor=
                                            es,
                                            los cambios de domicilio que <b style=3D'mso-bidi-font-weight:normal'>EL CL=
                                            IENTE</b>
                                            comunique a <b style=3D'mso-bidi-font-weight:normal'>EL BANCO</b> no surtir=
                                            án
                                            efectos frente a éste. <o:p></o:p></span></p>

                                            <p class=3DMsoNormal style=3D'text-align:justify'><span style=3D'font-size:=
                                            11.0pt;
                                            font-family:"Bookman Old Style",serif;mso-bidi-font-family:Arial'><o:p>&nbs=
                                            p;</o:p></span></p>

                                            <p class=3DMsoNormal style=3D'text-align:justify'><span lang=3DES-PE
                                            style=3D'font-size:11.0pt;font-family:"Bookman Old Style",serif;mso-bidi-fo=
                                            nt-family:
                                            Arial;mso-ansi-language:ES-PE'><o:p>&nbsp;</o:p></span></p>

                                            <p class=3DMsoNormal style=3D'text-align:justify'><b style=3D'mso-bidi-font=
                                            -weight:
                                            normal'><span style=3D'font-size:11.0pt;font-family:"Bookman Old Style",ser=
                                            if;
                                            mso-bidi-font-family:Arial'>NOVENO</span></b><span style=3D'font-size:11.0p=
                                            t;
                                            font-family:"Bookman Old Style",serif;mso-bidi-font-family:Arial'>.- Las pa=
                                            rtes
                                            se someten<span style=3D'mso-spacerun:yes'>  </span>a la jurisdicción de los
                                            jueces y tribunales de la ciudad donde se suscribe el presente acuerdo o de
                                            cualquiera de las ciudades en las que el Banco tenga oficinas instaladas,
                                            renunciando expresamente <b style=3D'mso-bidi-font-weight:normal'>EL CLIENT=
                                            E</b>
                                            al fuero de su domicilio<o:p></o:p></span></p>

                                            <p class=3DMsoNormal style=3D'text-align:justify'><span style=3D'font-size:=
                                            11.0pt;
                                            font-family:"Bookman Old Style",serif;mso-bidi-font-family:Arial'><o:p>&nbs=
                                            p;</o:p></span></p>

                                            <p class=3DMsoNormal style=3D'text-align:justify'><b style=3D'mso-bidi-font=
                                            -weight:
                                            normal'><span style=3D'font-size:11.0pt;font-family:"Bookman Old Style",ser=
                                            if;
                                            mso-bidi-font-family:Arial'>DECIMO</span></b><span style=3D'font-size:11.0p=
                                            t;
                                            font-family:"Bookman Old Style",serif;mso-bidi-font-family:Arial'>.- Las pa=
                                            rtes
                                            declaran su conformidad con todo lo estipulado en el presente documento, no
                                            teniendo nada más que reclamar en el futuro.<o:p></o:p></span></p>

                                            <p class=3DMsoNormal style=3D'text-align:justify'><span style=3D'font-size:=
                                            11.0pt;
                                            font-family:"Bookman Old Style",serif;mso-bidi-font-family:Arial'><o:p>&nbs=
                                            p;</o:p></span></p>

                                            <p class=3DMsoNormal style=3D'text-align:justify'><span style=3D'font-size:=
                                            11.0pt;
                                            font-family:"Bookman Old Style",serif;mso-bidi-font-family:Arial'><o:p>&nbs=
                                            p;</o:p></span></p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <br />
                            <div class="form-group row">
                                <div class="col-xs-6">
                                    <input type="button" value="REGISTRAR" class="form-control btn-danger"/>
                                </div>
                                <div class="col-xs-6">
                                    <input type="button" value="CANCELAR" class="form-control btn-primary"/>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>                
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="script" runat="server">
    <script src="../../resource/js/wysiwyg/external/jquery.hotkeys.js"></script>
    <script src="../../resource/js/wysiwyg/bootstrap-wysiwyg.js"></script>
    <link href="../../resource/js/wysiwyg/index.css" rel="stylesheet" />
    <script>
        $(function () {
            function initToolbarBootstrapBindings() {
                var fonts = ['Serif', 'Sans', 'Arial', 'Arial Black', 'Courier',
                        'Courier New', 'Comic Sans MS', 'Helvetica', 'Impact', 'Lucida Grande', 'Lucida Sans', 'Tahoma', 'Times',
                        'Times New Roman', 'Verdana'],
                        fontTarget = $('[title=Font]').siblings('.dropdown-menu');
                $.each(fonts, function (idx, fontName) {
                    fontTarget.append($('<li><a data-edit="fontName ' + fontName + '" style="font-family:\'' + fontName + '\'">' + fontName + '</a></li>'));
                });
                $('a[title]').tooltip({ container: 'body' });
                $('.dropdown-menu input').click(function () { return false; })
                    .change(function () { $(this).parent('.dropdown-menu').siblings('.dropdown-toggle').dropdown('toggle'); })
                .keydown('esc', function () { this.value = ''; $(this).change(); });

                $('[data-role=magic-overlay]').each(function () {
                    var overlay = $(this), target = $(overlay.data('target'));
                    overlay.css('opacity', 0).css('position', 'absolute').offset(target.offset()).width(target.outerWidth()).height(target.outerHeight());
                });
                if ("onwebkitspeechchange" in document.createElement("input")) {
                    var editorOffset = $('#editor').offset();
                    $('#voiceBtn').css('position', 'absolute').offset({ top: editorOffset.top, left: editorOffset.left + $('#editor').innerWidth() - 35 });
                } else {
                    $('#voiceBtn').hide();
                }
            };
            function showErrorbootbox.alert(reason, detail) {
                var msg = '';
                if (reason === 'unsupported-file-type') { msg = "Unsupported format " + detail; }
                else {
                }
                $('<div class="alert"> <button type="button" class="close" data-dismiss="alert">&times;</button>' +
                    '<strong>File upload error</strong> ' + msg + ' </div>').prependTo('#alerts');
            };
            initToolbarBootstrapBindings();
            $('#editor').wysiwyg({ fileUploadError: showErrorAlert });
            window.prettyPrint && prettyPrint();
        });
</script>
</asp:Content>