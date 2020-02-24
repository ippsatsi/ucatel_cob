<?php

require_once "url_relativa.php";
require_once $url_relativa."valida_sesion.php";
require_once $url_relativa."clases/usuario_class.php";

$user = new Usuario();
$user->setUserInfo();
$user->setUrlMaster($ruta_web);


$head = "";
$titulo = "BUSCAR CLIENTE";
$sub_titulo = "";
$sub_titulo = "";
$pageBar =<<<Final
Final;


$contenido =<<<Final
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

Final;

$footer =<<<Final

Final;

$script =<<<Final
<script type="text/javascript">
    $(document).ready(function () {
        $("#btn_buscar").click(function () {
            $.ajax({
                url: strServicio + "telefono_svc.php?buscar_telefono=1",
                data: '{"tipo": ' + $("#slt_tipo").val() + ',"numero":"' + $("#txt_numero").val().trim() + '", "CONSULTA_AJAX":"buscar_telefono"}',
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
                                "<td>" + obj.CLI_NOMBRE_COMPLETO + "<br/><span style='text-decoration: none;font-size: 17px;color: #c0392b;'>" + obj.CUE_NROCUENTA + "</span></td>" +
                                "<td><a target='_blank' href='gestionar-cuenta.php?cuenta=" + obj.CUE_NROCUENTA + "' class='btn btn-default'>GESTIONAR</a></td>" +
                            "</tr>";
                        $("#tblLista tbody").append(htmlText);
                    });
                }
            });
        });
    });
</script>

Final;

require_once $url_relativa.'resource/masterPage/Popup.php';


 ?>
