$(document).ready(function () {
    var estado = false;
    $('.card-info').click(function () {
        var idNotificacion = $(this).data('id-notificacion');
        var revisada = $(this).data('revisada');
        var card = $(this);

        // Se asigna el valor
        estado = revisada === 'True';

        // Si es que ya estaba revisada no es necesario marcarla como leída
        if (estado) {
            mostrarModalNotificacion(card);
            return;
        }

        $.ajax({
            type: "POST",
            url: "Notificaciones.aspx/MarcarComoRevisada",
            data: JSON.stringify({ idNotificacion: idNotificacion }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                mostrarModalNotificacion(card);
            },
            failure: function (response) {
                alert("Error al marcar la notificación como revisada.");
            }
        });
    });

    function mostrarModalNotificacion(card) {
        var tipo = card.find('.card-title').text().trim();
        var mensaje = card.data('mensaje-completo');
        var fecha = card.data('fecha');
        // Textos del modal
        $('#tipoNotificacion').text(tipo);
        $('#mensajeNotificacion').text(mensaje);
        $('#fechaNotificacion').text(fecha);
        // Mostrar el modal
        $('#form-modal-notificacion').modal('show');
    }

    // Cuando se cierre el modal
    $('#form-modal-notificacion').on('hidden.bs.modal', function () {
        // Solo se va a actualizar si es que la notificación no estaba revisada
        if (!estado) {
            location.reload();
        }
    });
});