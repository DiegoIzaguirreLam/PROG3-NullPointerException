<%@ Page Title="" Language="C#" MasterPageFile="~/Steam.Master" AutoEventWireup="true" CodeBehind="Tienda.aspx.cs" Inherits="SteamWA.Tienda" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphScripts" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphContenido" runat="server">
    <script>
        document.body.style.backgroundColor = '#24282f';
        function desplegarFiltros() {
      
            
            new bootstrap.Collapse(document.getElementById('myCollapsible'), { toggle: true });
            
           
        }
    </script>
    <div class="container">
        <h1 class="mt-4">Catálogo de Productos</h1>
        <!-- Barra de búsqueda -->
        <div class="search-bar d-flex">


            <input type="search" class="rounded-0 rounded-start-2 form-control" placeholder="Buscar programas...">

            <button type="submit" class="rounded-0 rounded-end-2 btn btn-outline-light  ">
                <i class="fas fa-search"></i>
            </button>

            <div class="dropdown ps-3">
                <button class="btn btn-outline-light dropdown-toggle" type="button" id="dropdownOrdenar" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Ordenar
                </button>
                <ul class="dropdown-menu" aria-labelledby="dropdownOrdenar">
                    <li><a class="dropdown-item" href="#">Por relevancia</a></li>
                    <li><a class="dropdown-item" href="#">Por nombre</a></li>
                    <li><a class="dropdown-item" href="#">Por precio</a></li>
                </ul>
            </div>

        </div>

      <div class="d-flex flex-row mt-2">
            <p class="border-0 text-light mb-0" cursor="pointer" onclick="desplegarFiltros()" id="desplegable">
                    
                 <i class="fas fa-bars pr-1"></i>
                Filtrar 
            </p>
         </div>
            <div class="collapse" id="myCollapsible">
                    <div class="w-25">
                    <label for="barRangoPrecio" class="form-label">Filtrar por precio</label>
                    <input type="range" class="form-range" min="0" max="5" id="barRangoPrecio">
                    </div>
            </div>
     
        <hr />
        <div class="w-75 d-flex ms-auto me-auto">
        <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-indicators">
                <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
                <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
            </div>
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img src="Images/portada_juego2.jpg" class="d-block w-75 ms-auto me-auto" alt="...">
                </div>
                <div class="carousel-item">
                    <img src="Images/portada_juego2.jpg" class="d-block w-75 ms-auto me-auto" alt="...">
                </div>
                <div class="carousel-item">
                    <img src="Images/portada_juego2.jpg" class="d-block w-75 ms-auto me-auto" alt="...">
                </div>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
        </div>
            </div>
        <div class="row mt-4">
            <!-- tarjeta 1 -->
            <div class="col-md-4">
                <div class="card bg-dark-subtle">
                    <img src="Images/portada_juego1.jpg" height="200" class="card-img-top" alt="Juego 1">
                    <div class="card-body">
                        <h5 class="card-title">Nombre del Programa 1</h5>
                        <p class="card-text">Descripción breve del Programa 1.</p>
                        <p class="card-text">Precio: $10.99</p>
                        <a href="#" class="btn btn-primary">Añadir al Carrito</a>
                    </div>
                </div>
            </div>
            <!-- tarjeta 2-->
            <div class="col-md-4">
                <div class="card bg-dark-subtle">
                    <img src="Images/portada_juego2.jpg" height="200" class="card-img-top" alt="Juego 2">
                    <div class="card-body">
                        <h5 class="card-title">Nombre del Programa 2</h5>
                        <p class="card-text">Descripción breve del Programa 2.</p>
                        <p class="card-text">Precio: $5.99</p>
                        <a href="#" class="btn btn-primary">Añadir al Carrito</a>
                    </div>
                </div>
            </div>
            <!-- tarjeta 3-->
            <div class="col-md-4">
                <div class="card bg-dark-subtle">
                    <img src="Images/portada_juego3.jpg" height="200" class="card-img-top" alt="Juego 3">
                    <div class="card-body">
                        <h5 class="card-title">Nombre del Programa 3</h5>
                        <p class="card-text">Descripción breve del Programa 3.</p>
                        <p class="card-text">Precio: $17.99</p>
                        <a href="#" class="btn btn-primary">Añadir al Carrito</a>
                    </div>
                </div>
            </div>
            <!-- mas tarjetas -->
        </div>
    </div>
</asp:Content>
