<%@ Page Title="" Language="C#" MasterPageFile="~/Steam.Master" AutoEventWireup="true" CodeBehind="Biblioteca.aspx.cs" Inherits="SteamWA.Biblioteca" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphScripts" runat="server">
    <script>
        function mostrarInfoPrograma(Programa) {
            // Obtener el contenedor de la información del programa
            var infoProgramaContainer = document.getElementById("infoPrograma");
            //esto se implementara despues en un script propiamente para mostrar la informacion del Programa
            infoProgramaContainer.innerHTML = "<h4>Información de " + Programa + "</h4>";
        }
    </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphContenido" runat="server">
    <div class="container">
        <h1 class="mt-4 d-inline-block">Biblioteca de Programas</h1>
        <!-- dropdown checkbox con colecciones -->
        <div class="text-end">
            <div class="dropdown d-inline-block">
                <button class="btn btn-primary dropdown-toggle bg-navy text-gray" type="button" id="dropdownMenuButton"
                    data-bs-toggle="dropdown" aria-expanded="false">
                    Colecciones
                </button>
                <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                    <li>
                        <a class="dropdown-item" href="#">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" value="" id="chkColeccion1" />
                                <label class="form-check-label" for="chkColeccion1">Colección 1</label>
                            </div>
                        </a>
                    </li>
                    <li>
                        <a class="dropdown-item" href="#">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" value="" id="chkColeccion2" />
                                <label class="form-check-label" for="chkColeccion2">Colección 2</label>
                            </div>
                        </a>
                    </li>
                </ul>
            </div>
            <hr />
        </div>
        <div class="row mt-4">
            <!-- lista de programas -->
            <div class="col-md-4">
                <h2>Listado de Programas</h2>
                <ul class="list-group">
                    <li class="list-group-item text-gray bg-navy" onclick="mostrarInfoPrograma('Programa 1')">Programa 1</li>
                    <li class="list-group-item text-gray bg-navy" onclick="mostrarInfoPrograma('Programa 2')">Programa 2</li>
                    <li class="list-group-item text-gray bg-navy" onclick="mostrarInfoPrograma('Programa 3')">Programa 3</li>
                </ul>
            </div>
            <div class="col-md-8">
                <div id="infoPrograma">
                    <!-- aqui se muestra la información del programa seleccionado -->
                </div>
            </div>
        </div>
    </div>
</asp:Content>
