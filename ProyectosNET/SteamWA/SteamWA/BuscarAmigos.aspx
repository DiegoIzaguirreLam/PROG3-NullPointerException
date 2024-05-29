<%@ Page Title="" Language="C#" MasterPageFile="~/Steam.Master" AutoEventWireup="true" CodeBehind="BuscarAmigos.aspx.cs" Inherits="SteamWA.BuscarAmigos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphScripts" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphContenido" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-md-12 col-sm-12">
                <h1 class="mt-4">Buscar amigos</h1>
            </div>
        </div>
        <hr />
        <div class="row">
            <!-- Primera tarjeta para buscar por ID -->
            <div class="col-md-6 col-sm-12">
                <div class="card bg-dark text-gray">
                    <div class="card-body">
                        <h5 class="card-title">Buscar por ID</h5>
                        <div class="form-group mb-4">
                            <span class="input-group">
                                <input type="text" class="form-control" placeholder="Ingrese el UID">
                                <asp:LinkButton ID="lbBuscarPorID" runat="server" class="btn bg-navy btn-outline-light" Text="<i class='fas fa-search'></i>" />
                            </span>
                        </div>
                        <ul class="list-group list-group-flush">
                            <li class="list-group-item text-gray bg-navy" id="amigo">
                                <div class="d-flex justify-content-between align-items-center">
                                    <span>Amigo 1</span>
                                    <div>
                                        <button class="btn btn-primary">
                                            <i class="fas fa-user-plus"></i>
                                        </button>
                                        <button class="btn btn-danger">
                                            <i class="fas fa-ban"></i>
                                        </button>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>

            <!-- Segunda tarjeta para buscar por nombre de usuario -->
            <div class="col-md-6 col-sm-12">
                <div class="card bg-dark text-gray">
                    <div class="card-body">
                        <h5 class="card-title">Por nombre de usuario</h5>
                        <div class="form-group">
                            <span class="input-group">
                                <input type="text" class="form-control" placeholder="Ingrese el nombre de usuario">
                                <asp:LinkButton ID="lbBuscarPorNombre" runat="server" class="btn bg-navy btn-outline-light" Text="<i class='fas fa-search'></i>"/>
                            </span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>