function validarEdad(source, args) {
    var fechaNacimientoInput = document.getElementById('txtFechaNacimiento').value;
    if (fechaNacimientoInput) {
        var fechaNacimiento = new Date(fechaNacimientoInput + "T00:00:00");
        var hoy = new Date();
        var edad = hoy.getFullYear() - fechaNacimiento.getFullYear();
        var mes = hoy.getMonth() - fechaNacimiento.getMonth();
        if (mes < 0 || (mes === 0 && hoy.getDate() < fechaNacimiento.getDate())) {
            edad--;
        }
        args.IsValid = edad >= 13;
    } else {
        args.IsValid = false;
    }
}

function soloNumeros(evt) {
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (charCode < 48 || charCode > 57) {
        return false;
    }
    return true;
}