function buscarForo_js() {
    var texto = document.getElementById('cphContenido_txtBusquedaForo').blur();
    
}

function buscarSubforo_js() {
    var texto = document.getElementById('cphContenido_txtBusquedaSubforo').blur();

}

function evitarEnter_js(event, buscador) {
    if (event.keyCode === 13) {
        return false; //Para que no funcione el enter
    }
    return document.getElementById(buscador).value;
}