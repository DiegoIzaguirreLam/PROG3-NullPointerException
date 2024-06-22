<%@ Page Title="" Language="C#" MasterPageFile="~/Steam.Master" AutoEventWireup="true" CodeBehind="Tienda.aspx.cs" Inherits="SteamWA.Tienda" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphScripts" runat="server">
     <script src="Scripts/Steam/Tienda.js"></script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphContenido" runat="server">
    <style>
        .divisionTienda {
            background-image: linear-gradient(#364458, #24282f);
        }

        #desplegableFiltro {
            background-image: linear-gradient(90deg, #24282f 0%, #262c35 15%, #262c35 85%, #24282f 100%);
            border-image-source: linear-gradient(90deg, rgb(36, 40, 47) 0%, rgb(122, 78, 78) 10%, rgb(90, 93, 122) 90%, rgb(36, 40, 47) 100%);
        }

        .contenidoTiendo {
            padding: 0 10px;
        }

        .carouselDestacados {
            background-image: linear-gradient(90deg, #24282f 0%, #2e3b4e 45%, #2e3b4e 55%, #24282f 100%)
        }

        .border-Gradient {
            border: 1px solid;
            border-image-slice: 1;
            border-width: 1px;
            border-image-source: linear-gradient(90deg, #24282f 0%, #ffffff 45%, #ffffff 55%, #24282f 100%);
        }

        .border-Gradient-Gray {
            border: 1px solid;
            border-image-slice: 1;
            border-width: 1px;
            border-image-source: linear-gradient(90deg, #24282f 0%, #afafaf 45%, #afafaf 55%, #24282f 100%);
        }

        .border-shadow {
            box-shadow: 0 0 5px #0d0523;
        }

        .separador {
            padding-bottom: 3rem;
        }

        .dropdown-item {
            cursor: pointer;
        }

        #suggestions {
            background-color: #392e47;
        }

        .bgDesplegables {
            background-color: #392e47;
        }

        .desplegableBusqueda {
            color: white;
        }

        .carousel-img-game{
            width:1280px;
            max-width: 75%;
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
                <button class="btn btn-outline-light dropdown-toggle " type="button" id="dropdownOrdenar" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Ordenar
                </button>
                <ul class="dropdown-menu bgDesplegables" aria-labelledby="dropdownOrdenar">
                    

                    <li class="d-flex ps-2">
                     <asp:RadioButton ID="rdbNombre" runat="server" GroupName="listaOrdenar" AutoPostBack="true" OnCheckedChanged="rdbNombre_CheckedChanged" />
                    <p class="ps-2 m-0 text-light"> Por nombre </>
                    </li>

                    <li class="d-flex ps-2">
                     <asp:RadioButton ID="rdbPrecio" runat="server" GroupName="listaOrdenar" OnCheckedChanged="rdbPrecio_CheckedChanged" AutoPostBack="true" />
                    <p class="ps-2 m-0 text-light"> Por precio </>
                    </li>
                     
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
        <div class="collapse row mt-3 px-2 py-2 border-Gradient carouselDestacados" id="desplegableFiltro">
            <div class="col-md-3">
                <label for="barRangoPrecio" class="form-label">Filtrar por precio:</label>
                
                <label id="labelito"  style="color:lightgreen" runat="server"></label>
                <input class="form-range" type="range" min="0" max="5" id="barRangoPrecio" runat="server"  onserverchange="rangeInput_ServerChange">
                <asp:HiddenField ID="monedaSimboloTipoCambio" runat="server" />
            </div>
            <div class="col-md-3 ">
                <label for="barRangoPrecio" class="form-label">Filtrar por etiqueta</label>

                 <div class="dropdown">
                <button class="btn btn-primary btn-dark dropdown-toggle" style="--bs-btn-bg: #323842" type="button" id="dropdownColecciones"
                    data-bs-toggle="dropdown" aria-expanded="false">
                    Etiquetas
                </button> 
                <ul id="ddlEtiquetas" runat="server" class="dropdown-menu bgDesplegables text-" aria-labelledby="dropdownColecciones">
                    
                </ul>
            </div>
            </div>
            <div class="col-md-3">
                <label for="barRangoPrecio" class="form-label">Filtrar por tipo</label>
                <div class="dropdown">
                <button class="btn btn-primary btn-dark dropdown-toggle" style="--bs-btn-bg: #323842" type="button" id="dropdownTipos"
                    data-bs-toggle="dropdown" aria-expanded="false" >
                    Tipo de Producto
                </button> 
                <ul id="ddlTipos" runat="server" class="dropdown-menu bgDesplegables text-"  aria-labelledby="dropdownTipos">
                    
                </ul>
                </div>
             
            </div>
            <div class="col-md-3">
                                <label for="barRangoPrecio" class="form-label">Limpiar Filtros</label>
                <div class="dropdown">
                <asp:LinkButton ID="btnLimpFiltro" cssClass="btn btn-primary btn-dark" style="--bs-btn-bg: #323842" runat="server" OnClick="btnLimpFiltro_Click">🗑 Limpiar</asp:LinkButton>
                    </div>
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
                               <asp:Image ID="imgDest1" CssClass="d-block ms-auto me-auto border-shadow rounded-3 carousel-img-game" runat="server" />

                            </div>
                            <div class="carousel-item">
                                <asp:Image ID="imgDest2" CssClass="d-block ms-auto me-auto border-shadow rounded-3 carousel-img-game" runat="server" />
                            </div>
                            <div class="carousel-item">
                                <asp:Image ID="imgDest3" CssClass="d-block ms-auto me-auto border-shadow rounded-3 carousel-img-game" runat="server" />
            
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
              
                        <asp:PlaceHolder ID="placeholderProductos" runat="server">
                              
                        </asp:PlaceHolder>
                 
            </div>
        </div>
    </div>
   
    <!-- Modal -->

<div class="modal fade " id="form-modal-añadido-carrito" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog ">
    <div class="modal-content carouselDestacados border-Gradient-Gray" style="border-radius:0">
      <div class="modal-header border-Gradient-Gray" style="border:none">
        <h5 class="modal-title" id="exampleModalLabel" >¡Añadido a tu carro!</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body mx-3" style="background-color:#181721">
           <div class="card-body">
          <h5 id="labelModal" runat="server" class="card-title pb-2"></h5>
              
               <asp:Image ID="modalImagen"  height="200" CssClass="card-img-top" style="border-radius:0.4rem" runat="server" />
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