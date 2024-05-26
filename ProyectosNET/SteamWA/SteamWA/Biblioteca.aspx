<%@ Page Title="" Language="C#" MasterPageFile="~/Steam.Master" AutoEventWireup="true" CodeBehind="Biblioteca.aspx.cs" Inherits="SteamWA.Biblioteca" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Content/stylesBiblioteca.css" rel="stylesheet" />
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
                <ul id="ulProgramas" runat="server" class="list-group list-group-flush">
                    <li class="list-group-item text-gray bg-transparent" id="liPrograma1">
                        <img src="Images/logo_juego1.jpg" height="30" />
                        <asp:LinkButton ID="lbPrograma1" runat="server" Text="Programa 1" CssClass="text-decoration-none text-white" OnClick="lbPrograma_Click" CommandArgument='1' />
                    </li>
                    <li class="list-group-item text-gray bg-transparent" id="liPrograma2">
                        <img src="Images/logo_juego2.jpg" height="30" />
                        <asp:LinkButton ID="lbPrograma2" runat="server" Text="Programa 2" CssClass="text-decoration-none text-white" OnClick="lbPrograma_Click" CommandArgument='2' />
                    </li>
                    <li class="list-group-item text-gray bg-transparent" id="liPrograma3">
                        <img src="Images/logo_juego3.jpg" height="30" />
                        <asp:LinkButton ID="lbPrograma3" runat="server" Text="Programa 3" CssClass="text-decoration-none text-white" OnClick="lbPrograma_Click" CommandArgument='3' />
                    </li>
                </ul>
            </div>
            <!-- línea divisoria vertical -->
            <div class="border-end p-2"></div>
            <!-- parte derecha: información del programa seleccionado -->
            <div class="col-md-8 p-4">
                <div id="infoPrograma" runat="server" style="display: none;">
                    <!-- Imagen del juego -->
                    <img id="imgPrograma" src="" width="600" alt="Portada del juego">
                    <!-- Información del juego -->
                    <div class="program-info">
                        <h3 id="tituloPrograma" runat="server">Titulo del Juego</h3>
                        <p runat="server"><span id="descripcionPrograma">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla quam velit, vulputate eu pharetra nec, mattis ac neque.</span></p>
                        <p runat="server"><strong>Última ejecución:</strong> <span id="fechaEjecucionPrograma">10 de mayo de 2024</span></p>
                        <p runat="server"><strong>Tiempo de uso:</strong> <span id="tiempoUsoPrograma">10 horas</span></p>
                        <p runat="server"><strong>Actualizado:</strong> <span id="actualizadoPrograma">Sí</span></p>
                        <!-- Contenedor de logros y botón para jugar -->
                        <div class="d-flex flex-column">
                            <!-- Contenedor de logros -->
                            <div id="logrosPrograma" style="margin-bottom: 20px;">
                                <h3>Logros</h3>
                                <ul id="ulLogros">
                                    <!-- logros -->
                                    <li>Logro 1</li>
                                    <li>Logro 2</li>
                                    <li>Logro 3</li>
                                </ul>
                            </div>
                            <!-- Botón para eliminar -->
                            <div class="d-flex justify-content-between">
                                <asp:LinkButton ID="lbLogros" runat="server" CssClass="btn btn-info" Text="<i class='fa-solid fa-magnifying-glass pe-2'></i> Logros" OnClick="lbLogros_Click" />
                                <asp:LinkButton ID="lbJugar" runat="server" CssClass="btn btn-primary btn-success" Text="Jugar" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="modal" id="form-modal-logros">
        <div class="modal-dialog modal-xl">
            <div class="modal-content bg-dark">
                <div class="modal-header">
                    <h5 class="modal-title">Logros de juegos</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p>Logros modal</p>
                    <ul id="ulLogrosModal">
                        <!-- logros -->
                        <li>Logro 1</li>
                        <li>Logro 2</li>
                        <li>Logro 3</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
