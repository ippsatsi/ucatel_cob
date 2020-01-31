function verificarSession() {
    $.ajax({
        url: strServicio+"GestionarUsuarios.asmx/ObtenerDatosSession",
        dataType: 'JSON',
        type: 'POST',
        contentType: "application/json; charset=utf-8",
        async:false,
        success: function (jsondata) {
            //console.log(jsondata);
            if (jsondata.d == null) {
                $.fancybox({
                    type: "iframe",
                    width: 500,
                    height: 420,
                    scrolling: 'no',
                    modal: true,
                    href: "login.aspx"
                });
                return true;
            } else {
                return false;
            }
        }
    });
}