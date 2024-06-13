<%@ Page Title="" Language="C#" MasterPageFile="~/Steam.Master"
    AutoEventWireup="true" CodeBehind="BuscarAmigos.aspx.cs"
    Inherits="SteamWA.BuscarAmigos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Content/stylesBiblioteca.css" rel="stylesheet" />
    <style>
        .pagination a, .pagination span {
            margin: 0 3px;
            padding: 4px 8px;
            text-decoration: none;
            color: #007bff;
        }

            .pagination a:hover {
                background-color: #f8f9fa;
                border-color: #dee2e6;
            }

        .pagination span {
            background-color: #007bff;
            color: #fff;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cphScripts" runat="server">
    <!-- Archivo Javascript para (des)habilitar el botón de búsqueda -->
    <script src="Scripts/Steam/BuscarAmigos.js"></script>

    <!-- Se registran los ID de los elementos que se llevan a JavaScript -->
    <script>
        var txtUIDClientId = '<%= txtUID.ClientID %>';
        var lbBuscarPorIDClientId = '<%= lbBuscarPorID.ClientID %>';
        console.log(lbBuscarPorIDClientId);

        var txtNombreClientId = '<%= txtNombre.ClientID %>';
        var lbBuscarPorNombreClientId = '<%= lbBuscarPorNombre.ClientID %>';
        console.log(lbBuscarPorNombreClientId);
    </script>


</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="cphContenido" runat="server">
    <div class="container rounded-3 border-Gradient">
        <!-- Título -->
        <div class="row">
            <div class="col-md-12 col-sm-12">
                <h1 class="mt-4">Buscar un usuario para agregar</h1>
            </div>
            <!-- Barra de profundidad -->
            <div class="col-md-7 row align-items-center">
                <div class="col-md-auto align-items-lg-start">
                    <asp:Button runat="server" CssClass="h5 bg-transparent border-0" Text="Amigos" OnClick="volverPaginaAmigos_Click" />
                    <i class="fa-solid fa-caret-right fa-1x" style="color: #ffffff;"></i>
                </div>
                <div class="col-md-auto align-items-lg-start">
                    <asp:Button runat="server" CssClass="h5 bg-transparent border-0" Text="Agregar un Amigo" Enabled="false"/>
                </div>
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
                                <input id="txtUID" runat="server" type="number" class="form-control" placeholder="ID del Usuario">
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
                                <input id="txtNombre" runat="server" type="text" class="form-control" placeholder="Nombre de Cuenta">
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
                OnRowDataBound="gvUsuarios_RowDataBound"
                AutoGenerateColumns="false"
                CssClass="table table-hover table-responsive table-striped table-dark mt-4"
                PagerStyle-CssClass="pagination"
                PagerStyle-Width="0">
                <Columns>
                    <asp:BoundField HeaderText="UID" DataField="UID" HeaderStyle-Width="200" ItemStyle-Width="200" />
                    <asp:BoundField HeaderText="Nombre de Perfil" DataField="nombrePerfil" HeaderStyle-Width="300" ItemStyle-Width="300" />
                    <asp:BoundField HeaderText="Nombre de Cuenta" DataField="nombreCuenta" HeaderStyle-Width="300" ItemStyle-Width="300" />
                    <asp:TemplateField HeaderStyle-Width="350" ItemStyle-Width="350" ItemStyle-HorizontalAlign="Right" >
                        <ItemTemplate>
                            <asp:LinkButton ID="lbAgregarAmigo" runat="server"
                                Text="<i class='fa-solid fa-plus ps-2'></i>"
                                CommandArgument='<%# Eval("UID") %>'
                                OnClick="lbAgregarAmigo_Click" />
                            <asp:Label ID="lblYaEsAmigo" Text="¡Ya son amigos!" runat="server" CssClass="text-success" Visible="false"></asp:Label>
                            <asp:Label ID="lblEstaBloqueado" Text="Este usuario ha sido bloqueado." runat="server" CssClass="text-danger" Visible="false"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>
