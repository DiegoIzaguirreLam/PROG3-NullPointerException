<%@ Page Title="" Language="C#" MasterPageFile="~/Steam.Master"
    AutoEventWireup="true" CodeBehind="BuscarAmigos.aspx.cs"
    Inherits="SteamWA.BuscarAmigos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cphScripts" runat="server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="cphContenido" runat="server">
    <div class="container">
        <!-- Título -->
        <div class="row">
            <div class="col-md-12 col-sm-12">
                <h1 class="mt-4">Buscar amigos</h1>
            </div>
        </div>
        <hr />

        <!-- Contenido Principal -->
        <div class="row">
            <!-- Primera tarjeta para buscar por ID -->
            <div class="col-md-6 col-sm-12">
                <div class="card bg-dark text-gray">
                    <div class="card-body">
                        <h5 class="card-title">Buscar por ID</h5>
                        <div class="form-group mb-4">
                            <span class="input-group">
                                <asp:TextBox ID="txtUID" runat="server" class="form-control"></asp:TextBox>
                                <asp:LinkButton ID="lbBuscarPorID" runat="server" class="btn bg-navy btn-outline-light" Text="<i class='fas fa-search'></i>" OnClick="lbBuscarPorID_Click" />
                            </span>
                        </div>
                        <asp:Label ID="lblMensajeID" runat="server" CssClass="text-danger" Visible="false"></asp:Label>
                    </div>
                </div>
            </div>

            <!-- Segunda tarjeta para buscar por nombre de usuario -->
            <div class="col-md-6 col-sm-12">
                <div class="card bg-dark text-gray">
                    <div class="card-body">
                        <h5 class="card-title">Buscar por Nombre de Usuario</h5>
                        <div class="form-group mb-4">
                            <span class="input-group">
                                <asp:TextBox ID="txtNombre" runat="server" class="form-control"></asp:TextBox>
                                <asp:LinkButton ID="lbBuscarPorNombre" runat="server" class="btn bg-navy btn-outline-light" Text="<i class='fas fa-search'></i>" OnClick="lbBuscarPorNombre_Click" />
                            </span>
                        </div>
                        <asp:Label ID="lblMensajeNombre" runat="server" CssClass="text-danger" Visible="false"></asp:Label>
                    </div>
                </div>
            </div>

            <!-- GridView de resultados de las búsquedas -->
            <asp:GridView ID="gvUsuarios" runat="server"
                AllowPaging="true" PageSize="5"
                OnPageIndexChanging="gvUsuarios_PageIndexChanging"
                AutoGenerateColumns="false"
                CssClass="table table-hover table-responsive table-striped">
                <Columns>
                    <asp:BoundField HeaderText="UID" DataField="uid" />
                    <asp:BoundField HeaderText="Nombre del Perfil" DataField="nombrePerfil" />
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:LinkButton runat="server"
                                Text="<i class='fa-solid fa-plus ps-2'></i>"
                                CommandArgument='<%# Eval("UID") %>'
                                OnClick="lbAgregarAmigo_Click" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

        </div>
    </div>
</asp:Content>