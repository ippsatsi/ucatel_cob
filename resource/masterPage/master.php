<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Sistema de Cobranza | GCC</title>
    <!-- <asp:ContentPlaceHolder ID="head" runat="server"></asp:ContentPlaceHolder> -->
<?php echo $head; ?>
<!--    <link href="http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700&subset=all" rel="stylesheet" type="text/css" />-->
    <link href="resource/css/google_fonts.css" rel="stylesheet" type="text/css" />
    <link href="resource/assets/global/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <link href="resource/assets/global/plugins/simple-line-icons/simple-line-icons.min.css" rel="stylesheet" type="text/css" />
    <link href="resource/assets/global/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="resource/assets/global/plugins/bootstrap-switch/css/bootstrap-switch.min.css" rel="stylesheet" type="text/css" />
    <link href="resource/assets/global/css/components.min.css" rel="stylesheet" id="style_components" type="text/css" />
    <link href="resource/assets/global/css/plugins.min.css" rel="stylesheet" type="text/css" />
    <link href="resource/assets/global/plugins/bootstrap-datepicker/css/bootstrap-datepicker.min.css" rel="stylesheet" type="text/css" />
    <link href="resource/assets/layouts/layout/css/layout.min.css" rel="stylesheet" type="text/css" />
    <link href="resource/assets/layouts/layout/css/themes/blue.min.css" rel="stylesheet" type="text/css" id="style_color" />
    <link id="Link4" rel="stylesheet" type="text/css" href="resource/css/jne/jquery-ui-1.9.2.custom.css" />
    <link href="resource/js/vendor/fancybox/jquery.fancybox-1.3.4.css" rel="stylesheet" type="text/css" />
    <link rel="shortcut icon" href="resource/masterPage/favicon.ico" />
</head>
<body class="page-header-fixed page-sidebar-closed-hide-logo page-container-bg-solid page-content-white">
    <form id="form1">

        <!-- <input type="hidden" value='<%=Request.Url.GetLeftPart(UriPartial.Authority) + VirtualPathUtility.ToAbsolute("") %>' id="rutaWeb" /> -->
        <!-- <input type="hidden" value='<%=VirtualPathUtility.ToAbsolute("") %>' id="MapPath" /> -->
        <input type="hidden" value='<?php echo $_SERVER['URI'] ?>' id="rutaWeb" />
        <input type="hidden" value='/siscob/' id="MapPath" />
        <!-- BEGIN HEADER -->
        <div class="page-header navbar navbar-fixed-top">
            <!-- BEGIN HEADER INNER -->
            <div class="page-header-inner ">
                <!-- BEGIN LOGO -->
                <div class="page-logo">
                    <a href="inicio.aspx">
                        <img src='resource/assets/layouts/layout/img/logo.png' alt="logo" class="logo-default" /> </a>
                    <div class="menu-toggler sidebar-toggler">
                        <span></span>
                    </div>
                </div>
                <!-- END LOGO -->
                <!-- BEGIN RESPONSIVE MENU TOGGLER -->
                <a href="javascript:;" class="menu-toggler responsive-toggler" data-toggle="collapse" data-target=".navbar-collapse">
                    <span></span>
                </a>
                <!-- END RESPONSIVE MENU TOGGLER -->
                <!-- BEGIN TOP NAVIGATION MENU -->
                <div class="top-menu">
                    <ul class="nav navbar-nav pull-right">
                        <!-- BEGIN NOTIFICATION DROPDOWN -->
                        <li class="dropdown dropdown-extended dropdown-notification" id="header_notification_bar">
                            <a href="javascript:'';" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
                                <i class="icon-bell"></i>
                                <span class="badge badge-default"  id="txt_cant_recordatorio">0</span>
                            </a>
                            <ul class="dropdown-menu">
                                <li class="external">
                                    <h3>
                                        <span class="bold" id="txt_cant_recordatorios">0 recordatorios</span></h3>
                                    <a href="cobranza/recordatorio.aspx">Ver todo</a>
                                </li>
                                <li>
                                    <ul id="lst_recordatorio" class="dropdown-menu-list scroller" style="height: 250px;" data-handle-color="#637283">
                                    </ul>
                                </li>
                            </ul>
                        </li>
                        <!-- END NOTIFICATION DROPDOWN -->
                        <!-- BEGIN TODO DROPDOWN -->
                        <li class="dropdown dropdown-extended dropdown-tasks" id="header_task_bar">
                            <a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
                                <i class="icon-calendar"></i>
                                <span class="badge badge-default" id="txt_cant_compromiso">0</span>
                            </a>
                            <ul class="dropdown-menu extended tasks">
                                <li class="external">
                                    <h3>Tu tienes
                                        <span class="bold" id="txt_cant_compromisos">0 compromisos</span></h3>
                                    <a href="cobranza/compromiso-semanal.aspx">Ver todo</a>
                                </li>
                                <li>
                                    <ul id="lst_compromiso" class="dropdown-menu-list scroller" style="height: 275px;" data-handle-color="#637283">
                                    </ul>
                                </li>
                            </ul>
                        </li>
                        <!-- END TODO DROPDOWN -->
                        <!-- BEGIN TODO DROPDOWN -->
                        <li class="dropdown dropdown-extended dropdown-tasks" id="Li1">
                            <a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
                                <i class="icon-clock"></i>
                                <span class="badge badge-default" id="txt_cant_convenio">0</span>
                            </a>
                            <ul class="dropdown-menu extended tasks">
                                <li class="external">
                                    <h3>Tu tienes
                                        <span class="bold" id="txt_cant_convenios">0 convenios</span></h3>
                                    <a href="cobranza/bandeja-convenios.aspx">Ver todo</a>
                                </li>
                                <li>
                                    <ul id="lst_convenio" class="dropdown-menu-list scroller" style="height: 275px;" data-handle-color="#637283">
                                    </ul>
                                </li>
                            </ul>
                        </li>
                        <!-- END TODO DROPDOWN -->
                        <!-- BEGIN USER LOGIN DROPDOWN -->
                        <li class="dropdown dropdown-user">
                            <a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
                               <!-- <img alt="" class="img-circle" src="assets/layouts/layout/img/avatar3_small.jpg" /> -->
                               <i class="fa fa-user" aria-hidden="true"></i>
                                <!-- <span class="username username-hide-on-mobile" id="txt_usuario_nombres" runat="server"></span> -->
                                <span id="txt_usuario_nombres" class="username username-hide-on-mobile"><?php echo $user->getNombreCompleto(); ?></span>
                                <i class="fa fa-angle-down"></i>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-default">
                                <li>
                                    <a href="#"><i class="icon-user"></i> Mi información </a>
                                </li>
                                <li>
                                    <a href="#"><i class="icon-calendar"></i> Mis actividades </a>
                                </li>
                                <li>
                                    <a href="#"><i class="icon-rocket"></i> Mis Tareas <span class="badge badge-success"> 7 </span></a>
                                </li>
                                <li class="divider"> </li>
                                <li>
                                    <a href='logout.php'><i class="icon-key"></i> Salir del sistema </a>
                                </li>
                            </ul>
                        </li>
                        <!-- END USER LOGIN DROPDOWN -->
                    </ul>
                </div>
                <!-- END TOP NAVIGATION MENU -->
            </div>
            <!-- END HEADER INNER -->
        </div>
        <!-- END HEADER -->
        <!-- BEGIN HEADER & CONTENT DIVIDER -->
        <div class="clearfix"> </div>
        <!-- END HEADER & CONTENT DIVIDER -->
        <!-- BEGIN CONTAINER -->
        <div class="page-container">
            <!-- BEGIN SIDEBAR -->
            <div class="page-sidebar-wrapper">
                <!-- BEGIN SIDEBAR -->
                <div class="page-sidebar navbar-collapse collapse"  id="navigation">
                    <!-- BEGIN SIDEBAR MENU -->
                    <?php
                    //require_once "clases/menu_class.php";
                    //$menu = new Menu();
                    echo $user->getMenuByRol();
                     ?>
                    <!-- <ul class="page-sidebar-menu  page-header-fixed page-sidebar-menu-light " data-keep-expanded="false" data-auto-scroll="true" data-slide-speed="200"> -->
                      <!-- MENU LATERAL -->

                      <!-- <li class="heading">
                          <h3 class="uppercase">PAGINA DE INICIO</h3>
                      </li>
                      <li class="nav-item  active">
                          <a href="javascript:;" class="nav-link nav-toggle">
                                <i class="icon-home"></i>
                              <span class="title">Inicio</span>
                          </a>
                      </li>
                        <li class="heading">
                            <h3 class="uppercase">Gestiones</h3>
                        </li>
                        <li class="nav-item ">
                            <a href="javascript:;" class="nav-link nav-toggle">
                                  <i class="icon-home"></i>
                                <span class="title">Bandeja Principal</span>
                            </a>
                        </li>
                        <li class="nav-item  ">
                            <a href="javascript:;" class="nav-link nav-toggle">
                                <i class="fa fa-tasks"></i>
                                <span class="title">Recordatorio</span>
                            </a>
                        </li>

                        <li class="heading">
                            <h3 class="uppercase">Reportes</h3>
                        </li>
                        <li class="nav-item  ">
                            <a href="javascript:;" class="nav-link nav-toggle">
                                <i class="fa fa-table"></i>
                                <span class="title">Reportes Diario</span>
                            </a>
                        </li>
                    </ul>> -->
                    <!-- END SIDEBAR MENU -->
                </div>
                <!-- END SIDEBAR -->
            </div>
            <!-- END SIDEBAR -->

            <!-- BEGIN CONTENT -->
            <div class="page-content-wrapper">
                <!-- BEGIN CONTENT BODY -->
                <div class="page-content">
                    <!-- BEGIN PAGE HEADER-->
                    <!-- BEGIN PAGE BAR -->
                    <div class="page-bar">
                        <ul class="page-breadcrumb">
                            <li>
                                <a><small>SECCIÓN : <?php echo $titulo; ?></small></a>
                            </li>
                        </ul>

                        <!-- <asp:ContentPlaceHolder ID="pageBar" runat="server"></asp:ContentPlaceHolder> -->
                    </div>

                    <!-- <asp:ContentPlaceHolder ID="antesTitulo" runat="server"></asp:ContentPlaceHolder> -->
                    <!-- END PAGE BAR -->
                    <!-- BEGIN PAGE TITLE-->
                    <!-- <h3 class="page-title">Sección:
                        <small><asp:ContentPlaceHolder ID="sub_titulo" runat="server"></asp:ContentPlaceHolder></small>
                    </h3> -->
                    <?php echo $sub_titulo; ?>
                    <!-- END PAGE TITLE-->
                    <!-- END PAGE HEADER-->
                    <!-- CONTENIDO PHP -->

                    <?php echo $contenido; ?>
                    <!-- <asp:ContentPlaceHolder ID="contenido" runat="server"></asp:ContentPlaceHolder> -->
                    <!-- FIN CONTENIDO PHP -->
                </div>
                <!-- END CONTENT BODY -->
            </div>
            <!-- END CONTENT -->

        </div>
        <!-- END CONTAINER -->
        <!-- BEGIN FOOTER -->
        <div class="page-footer">
            <div class="page-footer-inner"> 2016 &copy; Sistema de Cobranza GCC Consultores.</div>
            <div class="scroll-to-top">
                <i class="icon-arrow-up"></i>
            </div>
        </div>
        <!-- END FOOTER -->
        <!--[if lt IE 9]>
            <script src="assets/global/plugins/respond.min.js"></script>
            <script src="assets/global/plugins/excanvas.min.js"></script>
        <![endif]-->
        <script type="text/javascript" src='resource/assets/global/plugins/jquery.min.js'></script>
	<script type="text/javascript" src='resource/assets/global/plugins/jquery-migrate-1.2.1.js'></script>
        <!--<script src="http://code.jquery.com/jquery-migrate-1.2.1.js"></script>-->
        <script type="text/javascript" src='resource/assets/global/plugins/bootstrap/js/bootstrap.min.js'></script>
        <script type="text/javascript" src='resource/assets/global/plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js'></script>
        <script type="text/javascript" src='resource/assets/global/scripts/app.min.js'></script>
        <script type="text/javascript" src='resource/assets/layouts/layout/scripts/layout.min.js'></script>
        <script type="text/javascript" src='resource/assets/layouts/global/scripts/quick-sidebar.min.js'></script>
        <script type="text/javascript" src='resource/assets/global/plugins/bootstrap-datepicker/js/bootstrap-datepicker.js'></script>
        <script type="text/javascript" src='resource/assets/global/plugins/bootbox/bootbox.min.js'></script>
        <script type="text/javascript" src='resource/assets/global/plugins/jquery.blockui.min.js' ></script>
        <script type="text/javascript" src='resource/js/masterpage.js'></script>
        <script type="text/javascript" src='resource/js/vendor/fancybox/jquery.fancybox-1.3.4.js'></script>
        <script type="text/javascript" src='resource/js/vendor/fancybox/jquery.fancybox-1.3.4.pack.js'></script>
        <!-- <asp:ContentPlaceHolder ID="script" runat="server"></asp:ContentPlaceHolder> -->
        <!-- CONTENIDO SCRIPT PHP -->
        <script>

            function abrir_preload(bloque_id) {
                App.blockUI({
                    message: '<img src="resource/assets/global/img/loading-spinner-default.gif" />  Procesando...',
                    target: '#' + bloque_id,
                    boxed: true
                });
            }

            function cerrar_preload(bloque_id) {
                App.unblockUI('#' + bloque_id);
            }
        </script>

    </form>
</body>
</html>
