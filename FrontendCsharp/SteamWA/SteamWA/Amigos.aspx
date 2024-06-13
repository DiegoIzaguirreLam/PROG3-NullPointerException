<%@ Page Title="" Language="C#" MasterPageFile="~/Steam.Master"
    AutoEventWireup="true" CodeBehind="Amigos.aspx.cs"
    Inherits="SteamWA.Amigos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Content/stylesBiblioteca.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cphScripts" runat="server">
    <script src="Scripts/Steam/mostrarModal.js"></script>
    <script src="Scripts/Steam/Amigos.js"></script>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="cphContenido" runat="server">
    <!-- Contenido Principal -->
    <div class="container rounded-3 border-Gradient">
        <div class="row">
            <div class="col-md col-sm">
                <h1 class="mt-4">Amigos</h1>
                <!-- Barra de profundidad -->
                <div class="col-md-7 row align-items-center">
                    <div class="col-md-auto align-items-lg-start">
                        <asp:Label runat="server" CssClass="h5 bg-transparent border-0" Text="Amigos" />
                        <i class="fa-solid fa-caret-right fa-1x" style="color: #ffffff;"></i>
                    </div>
                </div>
            </div>
            <div class="col-md-auto col-sm-auto d-flex align-items-center justify-content-md-start">
                <asp:LinkButton runat="server" ID="btnAgregarAmigo" CssClass="btn btn-dark btn-outline-light mt-3" Text="Añadir amigo <i class='fa-solid fa-user-plus ms-2'></i>" OnClick="btnAgregarAmigo_Click" />
            </div>
        </div>

        <!-- Barra de búsqueda -->
        <hr />
        <div class="search-bar">
            <input type="text" class="form-control" placeholder="Buscar amigos por nombre de perfil..." id="buscarAmigosInput" onkeyup="filtrarAmigos()">
        </div>
        <hr />

        <!-- Tarjetas de Amigos -->
        <div class="rounded-3">
            <div class="px-3">
                <div class="row mt-3 pb-4">
                    <asp:ListView ID="lvAmigos" runat="server" ItemPlaceholderID="itemPlaceholder">
                        <ItemTemplate>
                            <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3 mb-4">
                                <div class="card bg-dark text-light amigo-card position-relative">
                                    <div class="card-body d-flex flex-column">
                                        <div class="d-flex flex-wrap justify-content-between align-items-center">
                                            <div class="d-flex align-items-center my-2">
                                                <img src="Images/foto_perfil.png" alt="Imagen de amigo" class="me-3 mb-3 mb-sm-0" style="max-width: 70px;" />
                                                <div>
                                                    <h5 class="card-title mb-0 text-truncate" style="max-width: 140px;"><%# Eval("NombrePerfil") %></h5>
                                                    <p class="card-text">ID: <%# Eval("UID") %></p>
                                                </div>
                                            </div>
                                            <div class="dropdown position-absolute top-0 end-0 m-2">
                                                <button class="btn btn-link text-light p-0" type="button" id="dropdownMenuButton<%# Eval("UID") %>" data-bs-toggle="dropdown" aria-expanded="false">
                                                    <i class="fa-solid fa-ellipsis-vertical"></i>
                                                </button>
                                                <div class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdownMenuButton<%# Eval("UID") %>">
                                                    <asp:LinkButton runat="server" CssClass="dropdown-item" Text="Eliminar" CommandArgument='<%# Eval("UID") + "," + Eval("NombrePerfil") %>' OnClick="btnEliminarAmigo_Click" />
                                                    <asp:LinkButton runat="server" CssClass="dropdown-item" Text="Bloquear" CommandArgument='<%# Eval("UID") + "," + Eval("NombrePerfil") %>' OnClick="btnBloquearAmigo_Click" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                        <EmptyDataTemplate>
                            <div class="d-flex justify-content-center align-items-center mt-3">
                                <asp:Label runat="server" Text="Aún no tienes ningún amigo." CssClass="display-7 text-center" />
                            </div>
                        </EmptyDataTemplate>
                    </asp:ListView>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal para Eliminar -->
    <div class="modal fade" id="form-modal-EliminarAmigo" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="container bg-dark">
                    <div class="modal-header">
                        <h5 class="modal-title" id="lblEliminarAmigo">Eliminar Amigo</h5>
                    </div>
                    <div class="modal-body">
                        <p id="txtConfirmacionEliminar" runat="server" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <asp:LinkButton runat="server" ID="btnEliminarAmigoModal" type="button" CssClass="btn btn-primary btn-danger" OnClick="btnEliminarAmigoModal_Click">Eliminar</asp:LinkButton>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal para Bloquear -->
    <div class="modal fade" id="form-modal-BloquearUsuario" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="container bg-dark">
                    <div class="modal-header">
                        <h5 class="modal-title" id="lblBloquearUsuario">Bloquear Usuario</h5>
                    </div>
                    <div class="modal-body">
                        <p id="txtConfirmacionBloquear" runat="server" />
                        <p runat="server" class="text-danger m-0">¡Recuerda que el bloqueo es permanente!</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <asp:LinkButton runat="server" ID="btnBloquarAmigoModal" type="button" CssClass="btn btn-primary btn-danger" OnClick="btnBloquearAmigoModal_Click">Bloquear</asp:LinkButton>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
