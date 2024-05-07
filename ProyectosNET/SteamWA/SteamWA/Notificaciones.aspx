<%@ Page Title="" Language="C#" MasterPageFile="~/Steam.Master" AutoEventWireup="true" CodeBehind="Notificaciones.aspx.cs" Inherits="SteamWA.Notificaciones" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphScripts" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphContenido" runat="server">
    <div class="container">
        <h1 class="mt-4">Notificaciones</h1>
        <div class="container-fluid">
            <div class="col d-flex justify-content-end align-items-center">
                <h5>Filtrar por:</h5>

                <div class="dropdown ps-3">
                    <button class="btn btn-primary dropdown-toggle bg-navy text-gray" type="button" id="ddMostrar"
                        data-bs-toggle="dropdown" aria-expanded="false">
                        Opciones
                    </button>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="ddMostrar" style="max-width: 400px;">
                        <li>
                            <asp:LinkButton ID="lbAmigos" runat="server" CssClass="dropdown-item" Text="Amigos" />
                        </li>
                        <li>
                            <asp:LinkButton ID="lbJuegos" runat="server" CssClass="dropdown-item" Text="Juegos" />
                        </li>
                        <li>
                            <asp:LinkButton ID="lbBiblioteca" runat="server" CssClass="dropdown-item" Text="Biblioteca" />
                        </li>
                        <li>
                            <asp:LinkButton ID="lbForos" runat="server" CssClass="dropdown-item" Text="Foros" />
                        </li>
                        <li>
                            <asp:LinkButton ID="lbTodos" runat="server" CssClass="dropdown-item" Text="Todos" />
                        </li>
                    </ul>
                </div>
            </div>
        </div>

        <hr />
        <div class="container-fluid d-flex row">
            <asp:ListView ID="lvNotificaciones" runat="server" ItemPlaceholderID="itemPlaceholder">
                <ItemTemplate>
                    <div class="col-12 mb-3">
                        <div class="card bg-<%# (bool)Eval("Revisada") ? "dark" : "navy-50" %> text-light full-width">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-9">
                                        <h5 class="card-title"><%# Eval("TipoNotificacion") %></h5>
                                        <p class="card-text"><%# Eval("Mensaje") %></p>
                                    </div>
                                    <div class="col-md-3 d-flex justify-content-end">
                                        <asp:LinkButton runat="server" CssClass="text-light" Text="<i class='fa-solid fa-up-right-and-down-left-from-center'></i>" OnClick="ExpandirNotificacion_Click" CommandArgument='<%# Eval("IdNotificacion") %>'/>
                                    </div>
                                </div>
                                
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:ListView>
        </div>
    </div>
    <div class="modal border-white" id="form-modal-notificacion">
        <div class="modal-dialog">
            <div class="modal-content bg-navy">
                <div class="modal-header bg-dark">
                    <h5 class="modal-title border-white">Notificación</h5>
                    <button type="button" class="btn-close bg-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div>
                        <h5>Tipo de notificación:</h5>
                        <p id="tipoNotificacion"></p>
                    </div>
                    <div>
                        <h5>Mensaje:</h5>
                        <p id="mensaje"></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
