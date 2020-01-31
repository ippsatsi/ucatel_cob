<%@ Page Title="" Language="C#" MasterPageFile="~/resource/masterPage/Template.Master" AutoEventWireup="true" CodeBehind="home.aspx.cs" Inherits="WEB.home" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contenido" runat="server">
    <div style="width:100%; height:550px; padding:20px 50px;">
        <h1 id="txtBienvenido" style="font-size:26px; font-weight:bold;"></h1>
        <h4 id="txtRolDescripcion" style="font-size:18px; font-weight:bold;"></h4>
        <div class="clearfix" style="width:100%;">
            <asp:HiddenField ID="json_indicador_semanal" runat="server"/>
            <asp:HiddenField ID="json_indicador_semanal_porc" runat="server"/>
            <asp:HiddenField ID="json_categorias" runat="server"/>
            <asp:HiddenField ID="json_series" runat="server"/>
            <div style="width:100%; padding:10px; float:left;" id="div_usuarios"></div>
            <div style="width:60%; padding:10px;float:left;" id="div_estadistica"></div>
            <div style="width:39%; padding:10px;float:right;" id="div_pie"></div>
            <div class="clearfix"></div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="server">
    <script src="https://code.highcharts.com/highcharts.js"></script>
    <script src="https://code.highcharts.com/modules/exporting.js"></script>
    <script type="text/javascript">
        $.ajax({
            url: strServicio + "GestionarUsuarios.asmx/ObtenerDatosSession",
            dataType: "json",
            type: "POST",
            contentType: "application/json; charset=utf-8",
            success: function (jsondata) {
                $("#txtBienvenido").text("BIENVENIDO AL SISTEMA: " + jsondata.d.USU_NOMBRES + " " + jsondata.d.USU_APELLIDO_PATERNO + " " + jsondata.d.USU_APELLIDO_MATERNO);
                $("#txtRolDescripcion").text("ROL: " + jsondata.d.ROL_DESCRIPCION);
            }
        });

        Highcharts.createElement('link', {
            href: 'https://fonts.googleapis.com/css?family=Signika:400,700',
            rel: 'stylesheet',
            type: 'text/css'
        }, null, document.getElementsByTagName('head')[0]);

        // Add the background image to the container
        Highcharts.wrap(Highcharts.Chart.prototype, 'getContainer', function (proceed) {
            proceed.call(this);
            this.container.style.background = 'url(http://www.highcharts.com/samples/graphics/sand.png)';
        });


        Highcharts.theme = {
            colors: ["#88f45b", "#8085e9", "#f45b5b", "#f4d35b", "#aaeeee", "#ff0066", "#eeaaee",
               "#55BF3B", "#DF5353", "#7798BF", "#aaeeee"],
            chart: {
                backgroundColor: null,
                style: {
                    fontFamily: "Signika, serif"
                }
            },
            title: {
                style: {
                    color: 'black',
                    fontSize: '16px',
                    fontWeight: 'bold'
                }
            },
            subtitle: {
                style: {
                    color: 'black'
                }
            },
            tooltip: {
                borderWidth: 0
            },
            legend: {
                itemStyle: {
                    fontWeight: 'bold',
                    fontSize: '13px'
                }
            },
            xAxis: {
                labels: {
                    style: {
                        color: '#6e6e70'
                    }
                }
            },
            yAxis: {
                labels: {
                    style: {
                        color: '#6e6e70'
                    }
                }
            },
            plotOptions: {
                series: {
                    shadow: true
                },
                candlestick: {
                    lineColor: '#404048'
                },
                map: {
                    shadow: false
                }
            },

            // Highstock specific
            navigator: {
                xAxis: {
                    gridLineColor: '#D0D0D8'
                }
            },
            rangeSelector: {
                buttonTheme: {
                    fill: 'white',
                    stroke: '#C0C0C8',
                    'stroke-width': 1,
                    states: {
                        select: {
                            fill: '#D0D0D8'
                        }
                    }
                }
            },
            scrollbar: {
                trackBorderColor: '#C0C0C8'
            },

            // General
            background2: '#E0E0E8'

        };

        // Apply the theme
        Highcharts.setOptions(Highcharts.theme);

        $(function () {
            var json_data = JSON.parse($("#contenido_json_indicador_semanal").val());
            var json_data_porc = JSON.parse($("#contenido_json_indicador_semanal_porc").val());
            var json_categorias_usua = JSON.parse($("#contenido_json_categorias").val());
            var json_series_usua = JSON.parse($("#contenido_json_series").val());
            $('#div_estadistica').highcharts({
                title: {
                    text: 'Cantidad de Gestiones Diarias',
                    x: -20 //center
                },
                subtitle: {
                    text: 'Reporte Semanal',
                    x: -20
                },
                xAxis: {
                    categories: ['Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes', 'Sabado','Domingo']
                },
                yAxis: {
                    title: {
                        text: 'Cantidad de Gestiones'
                    },
                    plotLines: [{
                        value: 0,
                        width: 1,
                        color: '#808080'
                    }]
                },
                tooltip: {
                    valueSuffix: 'Gestiones'
                },
                legend: {
                    layout: 'vertical',
                    align: 'left',
                    verticalAlign: 'middle',
                    borderWidth: 0
                },
                series: json_data
            });

            $('#div_pie').highcharts({
                chart: {
                    plotBackgroundColor: null,
                    plotBorderWidth: null,
                    plotShadow: false,
                    type: 'pie'
                },
                title: {
                    text: 'Porcentaje de Gestiones Semanales'
                },
                tooltip: {
                    pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
                },
                plotOptions: {
                    pie: {
                        allowPointSelect: true,
                        cursor: 'pointer',
                        dataLabels: {
                            enabled: false
                        },
                        showInLegend: true
                    }
                },
                series: [{
                    name: 'Brands',
                    colorByPoint: true,
                    data: json_data_porc
                }]
            });

            $('#div_usuarios').highcharts({
                chart: {
                    type: 'column'
                },
                title: {
                    text: 'Cantidad de Gestiones Diarias'
                },
                xAxis: json_categorias_usua,
                yAxis: {
                    min: 0,
                    title: {
                        text: 'Gestiones diarias'
                    },
                    stackLabels: {
                        enabled: true,
                        style: {
                            fontWeight: 'bold',
                            color: (Highcharts.theme && Highcharts.theme.textColor) || 'gray'
                        }
                    }
                },
                legend: {
                    align: 'right',
                    x: -30,
                    verticalAlign: 'top',
                    y: 25,
                    floating: true,
                    backgroundColor: (Highcharts.theme && Highcharts.theme.background2) || 'white',
                    borderColor: '#CCC',
                    borderWidth: 1,
                    shadow: false
                },
                tooltip: {
                    headerFormat: '<b>{point.x}</b><br/>',
                    pointFormat: '{series.name}: {point.y}<br/>Total: {point.stackTotal}'
                },
                plotOptions: {
                    column: {
                        stacking: 'normal',
                        dataLabels: {
                            enabled: true,
                            color: (Highcharts.theme && Highcharts.theme.dataLabelsColor) || 'white',
                            style: {
                                textShadow: '0 0 3px black'
                            }
                        }
                    }
                },
                series: json_series_usua
            });
        });

    </script>
</asp:Content>
