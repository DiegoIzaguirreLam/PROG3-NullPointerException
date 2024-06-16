document.addEventListener("DOMContentLoaded", function () {
    // Obtener los elementos del aspx
    var inputId = document.getElementById(txtUIDClientId);
    var botonId = document.getElementById(lbBuscarPorIDClientId);
    var inputNombre = document.getElementById(txtNombreClientId);
    var botonNombre = document.getElementById(lbBuscarPorNombreClientId);

    // Habilitar o inhabilitar inicialmente el botón de ID si ya existe un ID introducido
    if (inputId.value.trim() !== "") {
        botonId.classList.remove('disabled');
        botonId.classList.remove('aspNetDisabled');
    } else {
        botonId.classList.add('disabled');
        botonId.classList.add('aspNetDisabled');
    }

    // Habilitar o inhabilitar inicialmente el botón de nombre si ya existe un nombre introducido
    if (inputNombre.value.trim() !== "") {
        botonNombre.classList.remove('disabled');
        botonNombre.classList.remove('aspNetDisabled');
    } else {
        botonNombre.classList.add('disabled');
        botonNombre.classList.add('aspNetDisabled');
    }

    // Agregar un Listener para (des)habilitar el botón del ID dependiendo del textbox
    inputId.addEventListener('keyup', function () {
        if (inputId.value.trim() !== "") {
            botonId.classList.remove('disabled');
            botonId.classList.remove('aspNetDisabled');
        } else {
            botonId.classList.add('disabled');
            botonId.classList.add('aspNetDisabled');
        }
    });

    // Agregar un Listener para (des)habilitar el botón del nombre dependiendo del textbox
    inputNombre.addEventListener('keyup', function () {
        if (inputNombre.value.trim() !== "") {
            botonNombre.classList.remove('disabled');
            botonNombre.classList.remove('aspNetDisabled');
        } else {
            botonNombre.classList.add('disabled');
            botonNombre.classList.add('aspNetDisabled');
        }
    });

});