function showModalForm(modal) {
    var modalForm = new bootstrap.Modal(document.getElementById(modal));
    modalForm.toggle();
}


function validarValor(input, maximo) {
    // Obtener el valor actual del TextBox
    var valor = input.value;

    // Convertir el valor a un número entero
    var numero = parseInt(valor);

    // Verificar si el número es mayor que el máximo permitido
    if (numero > maximo) {
        // Si es mayor, establecer el valor del TextBox en el máximo permitido
        input.value = maximo;
    }

    // Verificar si el número es negativo
    if (numero < 0) {
        // Si es negativo, establecer el valor del TextBox en cero
        input.value = 0;
    }
}

