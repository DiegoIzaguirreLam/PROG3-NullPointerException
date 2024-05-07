function mostrarNotificacion(tipoNotificacion, mensaje) {
    document.getElementById("tipoNotificacion").innerText = tipoNotificacion;
    document.getElementById("mensaje").innerText = mensaje;

    var modalForm = new bootstrap.Modal(document.getElementById('form-modal-notificacion'));
    modalForm.toggle();
}