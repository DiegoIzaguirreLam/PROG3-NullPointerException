
function validarValor(input) {
    // Obtener el valor actual del TextBox
    var valor = input.value;

    if (isNaN(valor)) {
        input.value = "";
        return;
    }
    // Convertir el valor a un número entero
    var numero = parseFloat(valor);

    // Verificar si el número es negativo
    if (numero < 0) {
        // Si es negativo, establecer el valor del TextBox en cero
        input.value = 0;
        return;
    }

    if (numero == 0) {
        input.value = 0;
        return;
    }

    if (valor.charAt(0) == "0") {
        input.value = input.value.substring(1);
    }

    if (numero > 999999) {
        // Si excede, truncar el valor a 6 dígitos
        input.value = valor.slice(0, 6);
    }

    var partes = valor.split('.');
    if (partes.length > 1 && partes[1].length > 2) {
        // Si hay más de dos dígitos decimales, truncar la entrada
        input.value = partes[0] + '.' + partes[1].slice(0, 2);
    }
}