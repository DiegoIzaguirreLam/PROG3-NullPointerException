<%@ Page Title="" Language="C#" MasterPageFile="~/Steam.Master" AutoEventWireup="true" CodeBehind="Biblioteca.aspx.cs" Inherits="SteamWA.Biblioteca" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* Estilos para la lista de juegos */
        .list-group-item {
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

            .list-group-item:hover {
                background-color: #4a4a4a;
            }

        /* Estilos para el contenedor principal */
        .container {
            background: linear-gradient(to right, #141e30, #243b55);
            border-radius: 10px;
            padding: 20px;
        }

        /* Estilos para la información del programa */
        #infoPrograma {
            /* Eliminar fondo */
            background: none;
            /* Estilos de texto */
            color: #fff; /* Color de texto blanco para contrastar con el gradiente */
            padding: 20px;
            box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.3);
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphScripts" runat="server">
    <script src="Scripts/Steam/Biblioteca.js"></script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphContenido" runat="server">
    <div class="container">
        <h1 class="mt-4 d-inline-block">Biblioteca de Programas</h1>
        <!-- dropdown checkbox con colecciones -->
        <div class="text-end">
            <div class="dropdown d-inline-block">
                <button class="btn btn-primary dropdown-toggle bg-navy text-gray" type="button" id="dropdownColecciones"
                    data-bs-toggle="dropdown" aria-expanded="false" style="float: right;">
                    Colecciones
                </button>
                <ul class="dropdown-menu" aria-labelledby="dropdownColecciones">
                    <li>
                        <a class="dropdown-item" href="#">
                            <div class="form-check d-flex align-items-center">
                                <input class="form-check-input" type="checkbox" value="" id="chkColeccion1" />
                                <label class="form-check-label" for="chkColeccion1">Colección 1</label>
                                <a href="GestionarColeccion.aspx" class="ms-auto">
                                    <i class="fa-solid fa-pen-to-square"></i>
                                </a>
                            </div>
                        </a>
                    </li>
                    <li>
                        <a class="dropdown-item" href="#">
                            <div class="form-check d-flex align-items-center">
                                <input class="form-check-input" type="checkbox" value="" id="chkColeccion2" />
                                <label class="form-check-label" for="chkColeccion2">Colección 2</label>
                                <a href="GestionarColeccion.aspx" class="ms-auto">
                                    <i class="fa-solid fa-pen-to-square"></i>
                                </a>
                            </div>
                        </a>
                    </li>
                    <li>
                        <a class="dropdown-item" href="GestionarColeccion.aspx">
                            <i class="fa-solid fa-plus me-2"></i>Nueva Colección
                        </a>
                    </li>
                </ul>
            </div>
            <!-- dropdown de ordenar -->
            <div class="dropdown d-inline-block">
                <button class="btn btn-primary dropdown-toggle bg-navy text-gray" type="button" id="dropdownOrdenar"
                    data-bs-toggle="dropdown" aria-expanded="false" style="float: left;">
                    Ordenar
                </button>
                <ul class="dropdown-menu" aria-labelledby="dropdownOrdenar">
                    <li>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="ordenarOption" id="radioTiempo" value="tiempo" checked>
                            <label class="form-check-label" for="radioTiempo">Por Tiempo de Juego</label>
                        </div>
                    </li>
                    <li>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="ordenarOption" id="radioTamaño" value="tamaño" checked>
                            <label class="form-check-label" for="radioTamaño">Por Tamaño</label>
                        </div>
                    </li>
                    <li>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="ordenarOption" id="radioPrecio" value="precio" checked>
                            <label class="form-check-label" for="radioPrecio">Por Precio</label>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
        <hr />
        <div class="container d-flex">
            <!-- parte izquierda: lista de programas -->
            <div class="col-md-4 me-4">
                <!-- <h2>Listado de Programas</h2> -->
                <ul class="list-group list-group-flush">
                    <li class="list-group-item text-gray bg-navy" onclick="mostrarInfoPrograma('Programa 1')">Programa 1</li>
                    <li class="list-group-item text-gray bg-navy" onclick="mostrarInfoPrograma('Programa 2')">Programa 2</li>
                    <li class="list-group-item text-gray bg-navy" onclick="mostrarInfoPrograma('Programa 3')">Programa 3</li>
                </ul>
            </div>
            <!-- línea divisoria vertical -->
            <div class="border-end p-2"></div>
            <!-- parte derecha: información del programa seleccionado -->
            <div class="col-md-8 p-4">
                <div id="infoPrograma" style="display: none;">
                    <!-- Imagen del juego -->
                    <img id="gameImage" src="" width="600" alt="Portada del juego">
                    <!-- Información del juego -->
                    <div class="program-info">
                        <h3 id="gameTitle">Titulo del Juego</h3>
                        <p><strong>Fecha de Publicación:</strong> <span id="gameReleaseDate">01 de enero de 2024</span></p>
                        <p><strong>Descripción:</strong> <span id="gameDescription">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla quam velit, vulputate eu pharetra nec, mattis ac neque.</span></p>
                        <p><strong>Fecha de Adquisición:</strong> <span id="gameAcquisitionDate">05 de mayo de 2024</span></p>
                        <p><strong>Fecha Ejecutado:</strong> <span id="gameExecutionDate">10 de mayo de 2024</span></p>
                        <p><strong>Actualizado:</strong> <span id="gameUpdated">Sí</span></p>
                        <button id="playButton" class="btn btn-primary">Jugar</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
