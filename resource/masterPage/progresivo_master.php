<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Sistema de Cobranza | GCC</title>
    <?php echo $head; ?>

   <!-- <link href="http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700&subset=all" rel="stylesheet" type="text/css" />-->
    <link href="<?php echo $url_relativa; ?>resource/css/google_fonts.css" rel="stylesheet" type="text/css" />
    <link href="<?php echo $url_relativa; ?>resource/assets/global/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <link href="<?php echo $url_relativa; ?>resource/assets/global/plugins/simple-line-icons/simple-line-icons.min.css" rel="stylesheet" type="text/css" />
    <link href="<?php echo $url_relativa; ?>resource/assets/global/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="<?php echo $url_relativa; ?>resource/assets/global/plugins/bootstrap-switch/css/bootstrap-switch.min.css" rel="stylesheet" type="text/css" />
    <link href="<?php echo $url_relativa; ?>resource/assets/global/css/components.min.css" rel="stylesheet" id="style_components" type="text/css" />
    <link href="<?php echo $url_relativa; ?>resource/assets/global/css/plugins.min.css" rel="stylesheet" type="text/css" />
    <link href="<?php echo $url_relativa; ?>resource/assets/global/plugins/bootstrap-datepicker/css/bootstrap-datepicker.min.css" rel="stylesheet" type="text/css" />
    <link href="<?php echo $url_relativa; ?>resource/assets/layouts/layout/css/layout.min.css" rel="stylesheet" type="text/css" />
    <link href="<?php echo $url_relativa; ?>resource/assets/layouts/layout/css/themes/blue.min.css" rel="stylesheet" type="text/css" id="style_color" />
    <link id="Link4" rel="stylesheet" type="text/css" href="<?php echo $url_relativa; ?>resource/css/jne/jquery-ui-1.9.2.custom.css" />
    <link href="<?php echo $url_relativa; ?>resource/js/vendor/fancybox/jquery.fancybox-1.3.4.css" rel="stylesheet" type="text/css" />
    <link rel="shortcut icon" href="favicon.ico" /> </head>
</head>
<body class="page-container-bg-solid page-content-white">
    <form id="form1" runat="server">

        <input type="hidden" value='<?php echo $ruta_web; ?>' id="rutaWeb" />
        <input type="hidden" value='<?php echo $MapPath; ?>' id="MapPath" />

        <div class="page-container">
            <div class="page-content">
          
                <?php echo $antesTitulo; ?>
                
                <?php echo $contenido; ?>
            </div>
        </div>
        <!--[if lt IE 9]>
            <script src="assets/global/plugins/respond.min.js"></script>
            <script src="assets/global/plugins/excanvas.min.js"></script>
        <![endif]-->
        <script type="text/javascript" src='<?php echo $url_relativa; ?>resource/assets/global/plugins/jquery.min.js'></script>
        
	<script type="text/javascript" src='<?php echo $url_relativa; ?>resource/assets/global/plugins/jquery-migrate-1.2.1.js'></script>
        <script type="text/javascript" src='<?php echo $url_relativa; ?>resource/assets/global/plugins/bootstrap/js/bootstrap.min.js'></script>
        <script type="text/javascript" src='<?php echo $url_relativa; ?>resource/assets/global/plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js'></script>
        <script type="text/javascript" src='<?php echo $url_relativa; ?>resource/assets/global/scripts/app.min.js'></script>
        <script type="text/javascript" src='<?php echo $url_relativa; ?>resource/assets/layouts/layout/scripts/layout.min.js'></script>
        <script type="text/javascript" src='<?php echo $url_relativa; ?>resource/assets/layouts/global/scripts/quick-sidebar.min.js'></script>    
        <script type="text/javascript" src='<?php echo $url_relativa; ?>resource/assets/global/plugins/bootstrap-datepicker/js/bootstrap-datepicker.js'></script>  
        <script type="text/javascript" src='<?php echo $url_relativa; ?>resource/assets/global/plugins/bootbox/bootbox.min.js'></script>
        <script type="text/javascript" src='<?php echo $url_relativa; ?>resource/assets/global/plugins/jquery.blockui.min.js' ></script>
        <script type="text/javascript" src='<?php echo $url_relativa; ?>resource/js/masterpage.js'></script> 
        <script type="text/javascript" src='<?php echo $url_relativa; ?>resource/js/vendor/fancybox/jquery.fancybox-1.3.4.js'></script>
        <script type="text/javascript" src='<?php echo $url_relativa; ?>resource/js/vendor/fancybox/jquery.fancybox-1.3.4.pack.js'></script>
        <?php echo $script; ?>
    </form>
</body>
</html>