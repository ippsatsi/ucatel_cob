<%@ Page Title="" Language="C#" MasterPageFile="~/resource/masterPage/Popup.Master" AutoEventWireup="true" CodeBehind="buscar-telefono.aspx.cs" Inherits="WEB.cobranza.buscar_telefono" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="titulo" runat="server">
    BUSCAR CLIENTE
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contenido" runat="server">
    <div class="container" style="height: 370px; overflow-y:auto;">
        <div class="form-group row">
          <div class="col-xs-4">
              <select id="slt_tipo" class="form-control">
                  <option value="1">TELEFONO</option>
                  <option value="2">DOCUMENTO</option>
                  <option value="3">CORREO</option>
              </select>
          </div>
          <div class="col-xs-4">
              <input class="form-control" type="text" id="txt_numero"/>
          </div>
          <div class="col-xs-4">
              <input class="form-control" type="button" id="btn_buscar" value="BUSCAR"/>
          </div>
        </div>

        <table id="tblLista" class="table table-bordered">
            <thead>
                <tr>
                    <th></th>
                    <th>TELEFONO</th>
                    <th>CLIENTE</th>
                    <th>GESTIONAR</th>
                </tr>
            </thead>
            <tbody></tbody>
        </table>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footer" runat="server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="script" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $("#btn_buscar").click(function () {
                $.ajax({
                    url: strServicio + "telefono.asmx/buscar_telefono",
                    data: '{"tipo": ' + $("#slt_tipo").val() + ',"numero":"' + $("#txt_numero").val().trim() + '"}',
                    dataType: 'JSON',
                    type: 'POST',
                    contentType: "application/json; charset=utf-8",
                    async: false,
                    success: function (jsondata) {
                        var htmlText = "";
                        $("#tblLista tbody").empty();
                        $.each(jsondata.d, function (i, obj) {
                            htmlText = "<tr>" +
                                    "<td>" + (i + 1) + "</td>" +
                                    "<td style='font-size: 18px;color: #6f89b5;'>" + obj.TEL_NUMERO + "</td>" +
                                    "<td>" + obj.TEL_USUARIO_REGISTRO + "<br/><span style='text-decoration: none;font-size: 17px;color: #c0392b;'>" + obj.TEL_ORIGEN + "</span></td>" +
                                    "<td><a target='_blank' href='gestionar-cuenta.aspx?cuenta=" + obj.TEL_ORIGEN + "' class='btn btn-default'>GESTIONAR</a></td>" +
                                "</tr>";
                            $("#tblLista tbody").append(htmlText);
                        });
                    }
                });
            });
        });
    </script>
</asp:Content>
