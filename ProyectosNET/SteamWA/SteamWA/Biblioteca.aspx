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
        <h1 class="mt-4">Biblioteca de Programas</h1>
        <div class="dropdown mt-3">
            <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownColecciones" data-bs-toggle="dropdown" aria-expanded="false">
                Seleccionar Colección
            </button>
            <ul class="dropdown-menu dropdown-menu-dark" aria-labelledby="dropdownColecciones">
                <li><a class="dropdown-item" href="#">Colección 1</a></li>
                <li><a class="dropdown-item" href="#">Colección 2</a></li>
                <li><a class="dropdown-item" href="#">Colección 3</a></li>
            </ul>
        </div>
        <hr />
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
