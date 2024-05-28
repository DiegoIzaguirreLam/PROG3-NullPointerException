<%@ Page Title="" Language="C#" MasterPageFile="~/Steam.Master" AutoEventWireup="true" CodeBehind="Tienda.aspx.cs" Inherits="SteamWA.Tienda" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphScripts" runat="server">
     <script src="Scripts/Steam/Tienda.js"></script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphContenido" runat="server">
    <style>
        .divisionTienda{

            background-image: linear-gradient(#364458, #24282f);
        }
        #desplegableFiltro{
            background-image:linear-gradient(90deg, #24282f 0%, #262c35 15%, #262c35 85%, #24282f 100%);
            border-image-source: linear-gradient(90deg, rgb(36, 40, 47) 0%, rgb(122, 78, 78) 10%, rgb(90, 93, 122) 90%, rgb(36, 40, 47) 100%);

        }
        .contenidoTiendo{

            padding: 0 10px;
        }
        .carouselDestacados{
            background-image: linear-gradient(90deg, #24282f 0%, #2e3b4e 45%, #2e3b4e 55%, #24282f 100%)

        }
        .border-Gradient{

 
    border: 1px solid;
    border-image-slice: 1;
    border-width: 1px;
    border-image-source: linear-gradient(90deg, #24282f 0%, #ffffff 45%, #ffffff 55%, #24282f 100%);
        }
        .border-Gradient-Gray{

 
    border: 1px solid;
    border-image-slice: 1;
    border-width: 1px;
    border-image-source: linear-gradient(90deg, #24282f 0%, #afafaf 45%, #afafaf 55%, #24282f 100%);
        }
        .border-shadow{
            box-shadow: 0 0 5px #0d0523;
        }
        .separador{
            padding-bottom: 3rem;
        }
        .dropdown-item{
            cursor: pointer;
        }
        #suggestions{

            background-color: #392e47;
        }
        .desplegableBusqueda{
            color: white;
        }
    </style>
    
    <div class="container">
        <h1 class="mt-4">Catálogo de Productos</h1>
        <!-- Barra de búsqueda -->
        <div class="search-bar d-flex">
            <asp:TextBox ID="search_autocomplete" type="search" data-bs-toggle="dropdown" autocomplete="off" list="suggestions" CssClass="rounded-0 rounded-start-2 form-control" placeholder="Buscar programas..." runat="server"></asp:TextBox>

            <asp:LinkButton ID="btnBuscar" type="submit" class="rounded-0 rounded-end-2 btn btn-outline-light" runat="server" OnClick="search_Click">
                <i class="fas fa-search"></i>
            </asp:LinkButton>



            <ul class="dropdown-menu" aria-labelledby="search-autocomplete" id="suggestions">
            </ul>
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

        <div class="d-flex flex-row mt-2 px-1">
            <p class="border-0 text-light mb-0" role="button" onclick="desplegarFiltros()" id="desplegable">
                <i class="fas fa-bars pr-1"></i>
                Filtrar 
            </p>
        </div>
        <!--Desplegable de filtros-->
        <div class="collapse px-2 py-2 border-Gradient carouselDestacados" id="desplegableFiltro">
            <div class="w-25">
                <label for="barRangoPrecio" class="form-label">Filtrar por precio</label>
                <input class="form-range" type="range" min="0" max="5" id="barRangoPrecio">
            </div>
        </div>
        <div class="carouselDestacados">
            <hr class="border-Gradient" />
            <div class="px-3 separador">
                <h5 class="mt-2 mb-3">Destacados y recomendados</h5>
                <!--Carrusel de imagenes-->
                <div class="w-75 d-flex ms-auto me-auto ">
                    <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
                        <div class="carousel-indicators">
                            <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                            <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
                            <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
                        </div>
                        <div class="carousel-inner">
                            <div class="carousel-item active">
                                <img src="Images/portada_juego2.jpg" class="d-block w-75 ms-auto me-auto border-shadow rounded-3" alt="...">
                            </div>
                            <div class="carousel-item">
                                <img src="Images/portada_juego4.jpg" class="d-block w-75 ms-auto me-auto border-shadow rounded-3" alt="...">
                            </div>
                            <div class="carousel-item">
                                <img src="Images/portada_juego5.jpg" class="d-block w-75 ms-auto me-auto border-shadow rounded-3" alt="...">
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
            </div>
        </div>
        <div class="divisionTienda  rounded-3">
            <hr class="border-Gradient mt-0" />
            <div class="px-3">
                <h5 class="mt-1">Todos los productos</h5>
                <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <asp:PlaceHolder ID="placeholderProductos" runat="server">
                              
                        </asp:PlaceHolder>
                      
                    </ContentTemplate>

                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnBuscar" EventName="Click" />
                    </Triggers>
                </asp:UpdatePanel>
                <script type="text/javascript">
                    // Restaura la posición de desplazamiento después de que se complete la actualización parcial
                    Sys.WebForms.PageRequestManager.getInstance().add_endRequest(restaurarPosicionDesplazamiento);
                </script>
            </div>
        </div>
    </div>
   
    <!-- Modal -->

<div class="modal fade " id="form-modal-añadido-carrito" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog ">
    <div class="modal-content carouselDestacados border-Gradient-Gray" style="border-radius:0">
      <div class="modal-header border-Gradient-Gray" style="border:none">
        <h5 class="modal-title" id="exampleModalLabel" >¡Añadido a tu carro!</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body mx-3" style="background-color:#181721">
           <div class="card-body">
          <h5 class="card-title pb-2">Nombre del Programa 1</h5>
         <img src="Images/portada_juego1.jpg" height="200" class="card-img-top" style="border-radius:0.4rem"" alt="Juego 1">
        </div>
      </div>
      <div class="modal-footer"  style="border-style:none">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal"">Seguir comprando</button>
            <asp:LinkButton ID="btnCarro" CssClass="btn btn-primary" 
                            runat="server" OnClick="btnCarro_Click">Ver mi carro</asp:LinkButton> 

       
      </div>
    </div>
  </div>
</div>
          
</asp:Content>
