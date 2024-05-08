// hardcoding de programas
var programas = {
    "Programa 1": {
        titulo: "Programa 1",
        descripcion: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla quam velit, vulputate eu pharetra nec, mattis ac neque.",
        tiempoUso: "20.4 horas",
        fechaEjecucion: "10 de mayo de 2024",
        actualizado: "Sí",
        imagen: "Images/portada_juego1.jpg",
        logros: ["Logro 1 Programa 1", "Logro 2 Programa 1", "Logro 3 Programa 1"]
    },
    "Programa 2": {
        titulo: "Programa 2",
        descripcion: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla quam velit, vulputate eu pharetra nec, mattis ac neque.",
        tiempoUso: "12.5 horas",
        fechaEjecucion: "10 de mayo de 2024",
        actualizado: "Sí",
        imagen: "Images/portada_juego2.jpg",
        logros: ["Logro 1 Programa 2", "Logro 2 Programa 2", "Logro 3 Programa 2"]
    },
    "Programa 3": {
        titulo: "Programa 3",
        descripcion: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla quam velit, vulputate eu pharetra nec, mattis ac neque.",
        tiempoUso: "0.2 horas",
        fechaEjecucion: "10 de mayo de 2024",
        actualizado: "Sí",
        imagen: "Images/portada_juego3.jpg",
        logros: ["Logro 1 Programa 3", "Logro 2 Programa 3", "Logro 3 Programa 3"]
    }
}

function mostrarInfoPrograma(nombrePrograma) {
    var programa = programas[nombrePrograma];

    // cargar la informacion del programa (hardcoding)
    document.getElementById("imgPrograma").src = programa.imagen;
    document.getElementById("tituloPrograma").innerText = programa.titulo;
    document.getElementById("descripcionPrograma").innerText = programa.descripcion;
    document.getElementById("tiempoUsoPrograma").innerText = programa.tiempoUso;
    document.getElementById("fechaEjecucionPrograma").innerText = programa.fechaEjecucion;
    document.getElementById("actualizadoPrograma").innerText = programa.actualizado;

    // actualizas la lista de logros
    var logrosHTML = "";
    for (var i = 0; i < programa.logros.length; i++) {
        logrosHTML += "<li>" + programa.logros[i] + "</li>";
    }
    document.getElementById("ulLogros").innerHTML = logrosHTML;

    document.getElementById("infoPrograma").style.display = "block";
}
function showModalForm(modal) {
    var modalForm = new bootstrap.Modal(document.getElementById(modal));
    modalForm.toggle();
}