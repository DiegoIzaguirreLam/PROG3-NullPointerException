document.addEventListener("DOMContentLoaded", function () {
    
    var inputId = document.getElementById(txtUIDClientId);
    var botonId = document.getElementById(lbBuscarPorIDClientId);
    var inputNombre = document.getElementById(txtNombreClientId);
    var botonNombre = document.getElementById(lbBuscarPorNombreClientId);

    botonId.style.display = 'none';
    botonNombre.style.display = 'none';
    
    inputId.addEventListener('keyup', function () {
        botonId.style.display = inputId.value.trim() !== "" ? 'block' : 'none';
    });
    inputNombre.addEventListener('keyup', function () {
        botonNombre.style.display = inputNombre.value.trim() !== "" ? 'block' : 'none';
    });

});