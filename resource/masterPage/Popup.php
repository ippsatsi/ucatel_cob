<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link href="<?php echo $url_relativa; ?>resource/assets/global/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <title></title>
    <!-- <asp:ContentPlaceHolder ID="head" runat="server">
    </asp:ContentPlaceHolder> -->
    <?php echo $head; ?>
</head>
<body>
    <form id="form1">
    <input type="hidden" value='<?php echo $ruta_web; ?>' id="rutaWeb" />
    <input type="hidden" value='<?php echo $MapPath; ?>' id="MapPath" />
    <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Popup</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#">
            <!-- <asp:ContentPlaceHolder ID="titulo" runat="server">
            </asp:ContentPlaceHolder> -->
            <?php echo $titulo; ?>
          </a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
        </div>
        <!-- <asp:ContentPlaceHolder ID="contenido" runat="server">
        </asp:ContentPlaceHolder> -->
        <?php echo $contenido; ?>
    </div>
    <footer class="footer">
      <div class="container text-right">
        <br />
        <!-- <asp:ContentPlaceHolder ID="footer" runat="server">
        </asp:ContentPlaceHolder> -->
        <?php echo $footer; ?>
      </div>
    </footer>
    <script type="text/javascript" src='<?php echo $url_relativa; ?>resource/assets/global/plugins/jquery.min.js'></script>
  <!--  <script src="http://code.jquery.com/jquery-migrate-1.2.1.js"></script>    -->
    <script type="text/javascript" src='<?php echo $url_relativa; ?>resource/assets/global/plugins/jquery-migrate-1.2.1.js'></script>
    <script type="text/javascript" src='<?php echo $url_relativa; ?>resource/assets/global/plugins/bootstrap/js/bootstrap.min.js'></script>
    <script type="text/javascript" src='<?php echo $url_relativa; ?>resource/assets/global/plugins/bootbox/bootbox.min.js'></script>
    <script type="text/javascript">
        var strServicio = $("#rutaWeb").val() + 'resource/service/';
        var strPath = $("#rutaWeb").val();
    </script>
    <!-- <asp:ContentPlaceHolder ID="script" runat="server">
    </asp:ContentPlaceHolder> -->
    <?php echo $script; ?>
    </form>
</body>
</html>
