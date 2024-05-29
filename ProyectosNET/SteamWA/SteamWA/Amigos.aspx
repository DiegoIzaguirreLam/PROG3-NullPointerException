<%@ Page Title="" Language="C#"
    MasterPageFile="~/Steam.Master" AutoEventWireup="true"
    CodeBehind="Amigos.aspx.cs" Inherits="SteamWA.Amigos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cphScripts" runat="server">
    <script src="Scripts/Steam/mostrarModal.js"></script>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="cphContenido" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-md col-sm">
                <h1 class="mt-4">Amigos</h1>
            </div>
            <div class="col-md-auto col-sm-auto d-flex align-items-center justify-content-md-start">
                <asp:LinkButton runat="server" ID="btnAgregarAmigo" CssClass="btn btn-dark btn-outline-light" Text="Añadir amigo <i class='fa-solid fa-user-plus ms-2'></i>" OnClick="btnAgregarAmigo_Click"/>
            </div>
        </div>

        <!-- Barra de búsqueda -->
        <div class="search-bar">
            <input type="text" class="form-control" placeholder="Buscar amigos...">
        </div>
        <hr />
        <div class="rounded-3">
            <div class="px-3">
                <div class="row mt-3 pb-4">
                    <asp:ListView ID="lvAmigos" runat="server" ItemPlaceholderID="itemPlaceholder">
                        <ItemTemplate>
                            <div class="ccol-xs-12 col-sm-6 col-md-4 col-lg-3 mb-4">
                                <div class="card bg-dark text-light">
                                    <div class="card-body d-flex flex-column">
                                        <div class="d-flex flex-wrap justify-content-center align-items-center">
                                            <img src="Images/foto_perfil.png" alt="Imagen de amigo" class="me-3 mb-3 mb-sm-0" style="max-width: 100px;" />
                                            <div>
                                                <h5 class="card-title mb-0"><%# Eval("NombrePerfil") %></h5>
                                                <p class="card-text">ID: <%# Eval("UID") %></p>
                                                <asp:LinkButton runat="server" CssClass="btn btn-light" Text="<i class='fa-solid fa-x'></i>" OnClick="btnEliminarAmigo_Click" />
                                                <asp:LinkButton runat="server" CssClass="btn btn-danger ms-2" Text="<i class='fa-solid fa-ban'></i>" OnClick="btnBloquearAmigo_Click" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                        <EmptyDataTemplate>
                            <div class="d-flex justify-content-center align-items-center mt-3">
                                <asp:Label runat="server" Text="No hay amigos" CssClass="display-7 text-center" />
                            </div>
                        </EmptyDataTemplate>
                    </asp:ListView>
                </div>
            </div>
        </div>
        <div class="container-fluid d-flex row">
            <asp:ListView ID="a" runat="server" ItemPlaceholderID="itemPlaceholder">
                <LayoutTemplate>
                    <div class="container d-flex flex-wrap justify-content-start">
                        <asp:PlaceHolder ID="itemPlaceholder" runat="server">No hay amigos</asp:PlaceHolder>
                    </div>
                </LayoutTemplate>
                <ItemTemplate>
                    <div class="ccol-xs-12 col-sm-6 col-md-4 col-lg-3 mb-3 me-3">
                        <div class="card bg-dark text-light">
                            <div class="card-body d-flex flex-column">
                                <div class="d-flex flex-wrap justify-content-between align-items-center">
                                    <img src="Images/foto_perfil.png" alt="Imagen de amigo" class="me-3" style="max-width: 100px;" />
                                    <div>
                                        <h5 class="card-title mb-0"><%# Eval("NombrePerfil") %></h5>
                                        <p class="card-text">ID: <%# Eval("UID") %></p>
                                        <asp:LinkButton runat="server" CssClass="btn btn-light" Text="<i class='fa-solid fa-x'></i>" OnClick="btnEliminarAmigo_Click" />
                                        <asp:LinkButton runat="server" CssClass="btn btn-danger ms-2" Text="<i class='fa-solid fa-ban'></i>" OnClick="btnBloquearAmigo_Click" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:ListView>
        </div>
    </div>
    <!-- modal para eliminar-->
    <div class="modal fade" id="form-modal-EliminarAmigo" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="container bg-dark">
                    <div class="modal-header">
                        <h5 class="modal-title" id="lblEliminarAmigo">Eliminar Amigo</h5>
                    </div>
                    <div class="modal-body">
                        <p>¿Está seguro que desea eliminar este amigo?</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <button type="button" class="btn btn-primary btn-danger">Eliminar</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- modal para bloquear-->
    <div class="modal fade" id="form-modal-BloquearUsuario" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="container bg-dark">
                    <div class="modal-header">
                        <h5 class="modal-title" id="lblBloquearUsuario">Bloquear Usuario</h5>
                    </div>
                    <div class="modal-body">
                        <p>¿Está seguro que desea bloquear este usuario?</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <button type="button" class="btn btn-primary btn-danger">Bloquear</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>