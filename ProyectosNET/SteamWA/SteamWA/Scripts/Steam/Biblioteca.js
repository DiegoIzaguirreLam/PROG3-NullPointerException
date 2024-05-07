function mostrarInfoPrograma(nombrePrograma) {
    var programa = {
        titulo: nombrePrograma,
        fechaPublicacion: "01 de enero de 2024",
        descripcion: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla quam velit, vulputate eu pharetra nec, mattis ac neque.",
        fechaAdquisicion: "05 de mayo de 2024",
        fechaEjecucion: "10 de mayo de 2024",
        actualizado: "Sí",
        imagen: "Images/portada_juego1.jpg"
    };

    // cargar la informacion del programa
    document.getElementById("gameImage").src = programa.imagen;
    document.getElementById("gameTitle").innerText = programa.titulo;
    document.getElementById("gameReleaseDate").innerText = programa.fechaPublicacion;
    document.getElementById("gameDescription").innerText = programa.descripcion;
    document.getElementById("gameAcquisitionDate").innerText = programa.fechaAdquisicion;
    document.getElementById("gameExecutionDate").innerText = programa.fechaEjecucion;
    document.getElementById("gameUpdated").innerText = programa.actualizado;

    // Mostrar el contenedor de la información del programa
    document.getElementById("infoPrograma").style.display = "block";
}