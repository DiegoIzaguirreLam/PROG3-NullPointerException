<%@ Page Title="" Language="C#" MasterPageFile="~/Steam.Master" AutoEventWireup="true" CodeBehind="Biblioteca.aspx.cs" Inherits="SteamWA.Biblioteca" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Content/stylesBiblioteca.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphScripts" runat="server">
    <script src="Scripts/Steam/Biblioteca.js"></script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphContenido" runat="server">
    <div class="container">
        <h1 class="mt-4 d-inline-block">Biblioteca de Productos</h1>
        <!-- dropdown checkbox con colecciones -->
        <div class="text-end">
            <div class="dropdown d-inline-block">
                <button class="btn bg-navy btn-outline-light dropdown-toggle" type="button" id="dropdownColecciones"
                    data-bs-toggle="dropdown" aria-expanded="false" style="float: left;">
                    Colecciones
                </button> 
                <ul id="ddlColecciones" runat="server" class="dropdown-menu text-" aria-labelledby="dropdownColecciones">
                    
                </ul>
            </div>
            <!-- dropdown de ordenar -->
            <div class="dropdown d-inline-block">
                <button class="btn bg-navy btn-outline-light dropdown-toggle" type="button" id="dropdownOrdenar"
                    data-bs-toggle="dropdown" aria-expanded="false" style="float: left;">
                    Ordenar
                </button>
                <ul class="dropdown-menu" aria-labelledby="dropdownOrdenar">
                    <li>
                        <asp:RadioButton ID="rbNombre" runat="server" GroupName="orderCriteria" Text="Por Nombre" AutoPostBack="True" OnCheckedChanged="RadioButton_CheckedChanged" />
                    </li>
                    <li>
                        <asp:RadioButton ID="rbTiempo" runat="server" GroupName="orderCriteria" Text="Por Uso" AutoPostBack="True" OnCheckedChanged="RadioButton_CheckedChanged" />
                    </li>
                    <li>
                        <asp:RadioButton ID="rbTam" runat="server" GroupName="orderCriteria" Text="Por Tamaño" AutoPostBack="True" OnCheckedChanged="RadioButton_CheckedChanged" />
                    </li>
                    <li>
                        <asp:RadioButton ID="rbFechaPub" runat="server" GroupName="orderCriteria" Text="Por Recientes" AutoPostBack="True" OnCheckedChanged="RadioButton_CheckedChanged" />
                    </li>
                    <li>
                        <asp:RadioButton ID="rbPrecio" runat="server" GroupName="orderCriteria" Text="Por Precio" AutoPostBack="True" OnCheckedChanged="RadioButton_CheckedChanged" />
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
                </ul>
            </div>
            <!-- línea divisoria vertical -->
            <div class="border-end p-2"></div>
            <!-- parte derecha: información del programa seleccionado -->
            <div class="col-md-8 p-4">
                <div id="infoPrograma" runat="server" style="display: none;">
                    <!-- Imagen del juego -->
                    <div class="justify-content-center">
                        <img id="imgPrograma" runat="server" width="650" alt="Portada del juego">
                    </div>
                    <!-- Información del juego -->
                    <div class="program-info">
                        <h3 id="txtTituloPrograma" runat="server">Titulo del Juego</h3>
                        <p id="txtDescripcionPrograma" runat="server">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla quam velit, vulputate eu pharetra nec, mattis ac neque.</p>
                        <p id="txtFechaEjecucionPrograma" runat="server"></p>
                        <p id="txtTiempoUsoPrograma" runat="server"></p>
                        <p id="txtActualizadoPrograma" runat="server"></p>
                        <!-- Contenedor de logros y botón para jugar -->
                        <div class="d-flex flex-column">
                            <!-- Botón para eliminar -->
                            <div id="divBotonesPrograma" runat="server">
                                <asp:LinkButton ID="lbLogros" runat="server" CssClass="btn btn-primary btn-dark" Text="<i class='fa-solid fa-gamepad'></i> Logros" OnClick="lbLogros_Click" />
                                <asp:LinkButton ID="lbJugar" runat="server" CssClass="btn btn-primary btn-success" Text="Jugar" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
