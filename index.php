<!DOCTYPE html>
<html class="no-js" lang="">
<head id="Head1" runat="server">
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Sistema de Cobranza GCC</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
    <meta content="Sistema gestión de cobranza" name="description" />
    <meta content="GCC Consultores" name="author" />
    <!--<link href="http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700&subset=all" rel="stylesheet" type="text/css" />-->
    <link href="resource/css/google_fonts.css" rel="stylesheet" type="text/css" />
    <link href="resource/assets/global/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <link href="resource/assets/global/plugins/simple-line-icons/simple-line-icons.min.css" rel="stylesheet" type="text/css" />
    <link href="resource/assets/global/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="resource/assets/global/plugins/bootstrap-switch/css/bootstrap-switch.min.css" rel="stylesheet" type="text/css" />
    <link href="resource/assets/global/plugins/select2/css/select2.min.css" rel="stylesheet" type="text/css" />
    <link href="resource/assets/global/plugins/select2/css/select2-bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="resource/assets/global/css/components.min.css" rel="stylesheet" id="style_components" type="text/css" />
    <link href="resource/assets/global/css/plugins.min.css" rel="stylesheet" type="text/css" />
    <link href="resource/assets/pages/css/login-2.min.css" rel="stylesheet" type="text/css" />
    <link rel="shortcut icon" href="resource/masterPage/favicon.ico" type="image/x-icon">
    <link rel="icon" href="resource/masterPage/favicon.ico" type="image/x-icon">
</head>
<body class=" login">

  <!--  <div class="compatible"><img src='resource/assets/layouts/layout/img/compatible.png' alt="" /></div> -->

    <div class="logo">
        <a href="index.html"><img src='resource/assets/layouts/layout/img/logo-big.png' alt="" /></a>
    </div>


    <div class="content">
        <form class="login-form" id="form_inicio" action="inicio.php" method="post">
            <div class="form-title">
                <span class="form-title">Acceso al sistema</span>
            </div>
            <div class="alert alert-danger display-hide">
                <button class="close" data-close="alert"></button>
                <span> Ingrese algun nombre de usuario y clave. </span>
            </div>
            <div class="form-group">
                <label class="control-label visible-ie8 visible-ie9">Usuario</label>
                <input class="form-control form-control-solid placeholder-no-fix" type="text" id="user" autocomplete="off" placeholder="Usuario" name="usuario" /> </div>
            <div class="form-group">
                <label class="control-label visible-ie8 visible-ie9">Clave</label>
                <input class="form-control form-control-solid placeholder-no-fix" type="password" id="password" autocomplete="off" placeholder="Clave" name="clave" /> </div>
            <div class="form-actions">
                <button type="button" class="btn red btn-block uppercase btn_buscar" id="btnAceptar">Ingresar al sistema</button>
            </div>
        </form>
    </div>
    <?php
        require_once "clases/db.php";


     ?>
    <div class="copyright"> 2016 © GCC Consultores. Sistema de Gestión de cobranzas. </div>

    <script type="text/javascript" src='resource/assets/global/plugins/jquery.min.js'></script>
    <script type="text/javascript" src='resource/assets/global/plugins/bootstrap/js/bootstrap.min.js'></script>
    <script type="text/javascript" src='resource/assets/global/plugins/js.cookie.min.js'></script>
    <script type="text/javascript" src='resource/assets/global/plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js'></script>
    <script type="text/javascript" src='resource/assets/global/plugins/jquery-slimscroll/jquery.slimscroll.min.js'></script>
    <script type="text/javascript" src='resource/assets/global/plugins/jquery.blockui.min.js'></script>
    <script type="text/javascript" src='resource/assets/global/plugins/bootstrap-switch/js/bootstrap-switch.min.js'></script>
    <script type="text/javascript" src='resource/assets/global/plugins/jquery-validation/js/jquery.validate.min.js'></script>
    <script type="text/javascript" src='resource/assets/global/plugins/jquery-validation/js/additional-methods.min.js'></script>
    <script type="text/javascript" src='resource/assets/global/plugins/select2/js/select2.full.min.js'></script>
  <!--  <script type="text/javascript" src='resource/assets/global/plugins/backstretch/jquery.backstretch.min.js'></script> -->
    <script type="text/javascript" src='resource/assets/global/scripts/app.min.js'></script>
    <script type="text/javascript" src='resource/js/vendor/placeholder/jquery.placeholder.js'></script>
    <script type="text/javascript" src='resource/assets/global/plugins/bootbox/bootbox.min.js'></script>
    <script type="text/javascript" src='resource/js/index.js'></script>


</body>
</html>
