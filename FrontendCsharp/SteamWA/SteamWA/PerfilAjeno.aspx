<%@ Page Title="" Language="C#" MasterPageFile="~/Steam.Master" AutoEventWireup="true" CodeBehind="PerfilAjeno.aspx.cs" Inherits="SteamWA.PerfilAjeno" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Content/bootstrap.css" rel="stylesheet" />
    <style>
        .container-gradient {
            border-top: 1px solid;
            border-image-slice: 1;
            border-width: 1px;
            border-image-source: linear-gradient(90deg, #24282f 0%, #ffffff 45%, #ffffff 55%, #24282f 100%);
            background-image: linear-gradient(#364458, #24282f);
        }

        .nav-tabs .nav-item .nav-link.active {
            background-color: rgb(67, 70, 73);
        }

        .card-img-height {
            height: 220px;
        }

        .column-space {
            padding-right: 50px;
        }

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
    <script src="Scripts/Steam/mostrarModal.js"></script>
</asp:Content>


<asp:Content ID="Content3" ContentPlaceHolderID="cphContenido" runat="server">
    <div class="container">
        <div class="row mb-3">
            <!-- Barra de profundidad -->
            <div class="col-md-7 row align-items-center">
                <div class="col-md-auto align-items-lg-start">
                    <asp:Button runat="server" CssClass="h5 bg-transparent border-0" Text="Amigos" OnClick="volverPaginaAmigos_Click" />
                    <i class="fa-solid fa-caret-right fa-1x" style="color: #ffffff;"></i>
                </div>
                <div class="col-md-auto align-items-lg-start">
                    <asp:Button runat="server" CssClass="h5 bg-transparent border-0" ID="btnPerfilAmigo" Enabled="false" />
                </div>
            </div>
        </div>
        <div class="row">
            <!-- Información General del Usuario -->
            <div class="col-md-4">
                <div class="card mb-3 bg-info-subtle">
                    <div class="d-flex justify-content-center align-items-center" style="height: 100%; padding: 1rem;">
                        <asp:Image ID="imgPerfil" AlternateText="Avatar del Usuario" CssClass="card-img-top"
                            style="border-radius:0.4rem; max-width:250px; max-height:250px; box-shadow: 0 4px 16px rgba(0, 0, 0, 0.5);" runat="server" />
                    </div>
                    <div class="card-body">
                        <h5 class="card-title" id="lblNombreCuenta" runat="server">UserName</h5>
                        <p class="card-text text-muted">
                            <i class="fa-solid fa-certificate" id="iconVerificado" runat="server" style="color: green;"></i>
                            <span id="lblVerificado" runat="server" style="color: green;">Verificado por Steam</span>
                        </p>
                        <div id="onlineIndicator" class="online-indicator bg-success" runat="server"></div>
                        <ul>
                            <li>UID:
                    <asp:Label ID="lblUID" runat="server">UserUID</asp:Label></li>
                            <li>Correo:
                    <asp:Label ID="lblCorreo" runat="server">UserMail</asp:Label></li>
                            <li>Teléfono:
                    <asp:Label ID="lblTelefono" runat="server">UserPhone</asp:Label></li>
                            <li>Fecha Nacimiento:
                    <asp:Label ID="lblFechaNacimiento" runat="server">UserBirth</asp:Label></li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="col-md-8 container-gradient rounded-4">

                <!-- Barra de Navegación -->
                <ul class="nav nav-tabs m-3" role="tablist">
                    <li class="nav-item">
                        <asp:LinkButton ID="lbLogros" CssClass="nav-link bg-navy text-light bg-gradient" runat="server" OnClick="lbLogros_Click">Logros Obtenidos</asp:LinkButton>
                    </li>
                </ul>

                <div class="m-3">
                    <!-- Contenido de cada Pestaña -->
                    <asp:MultiView ID="MultiView1" runat="server">
                        <!-- Vista para Logros Obtenidos -->
                        <asp:View ID="ViewLogrosObtenidos" runat="server">
                            <!-- GridView para listar los logros del usuario -->
                            <asp:GridView ID="gvLogros" runat="server" AutoGenerateColumns="False"
                                AllowPaging="True" PageSize="5"
                                CssClass="table table-responsive table-striped table-dark"
                                OnPageIndexChanging="gvLogros_PageIndexChanging"
                                OnRowDataBound="gvLogros_RowDataBound">
                                <Columns>
                                    <asp:TemplateField HeaderText="Logo">
                                        <ItemTemplate>
                                            <img src="Images/logo_juego4.jpg" style="height: 50px; width: 50px;" />
                                        </ItemTemplate>
                                        <ItemStyle CssClass="column-space" />
                                    </asp:TemplateField>
                                    <asp:BoundField HeaderText="Título">
                                        <ItemStyle CssClass="column-space" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="Logro">
                                        <ItemStyle CssClass="column-space" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="Descripción">
                                        <ItemStyle CssClass="column-space" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="Fecha" DataFormatString="{0:dd-MM-yyyy}">
                                        <ItemStyle CssClass="column-space" />
                                    </asp:BoundField>
                                </Columns>
                                <EmptyDataTemplate>
                                    <div class="d-flex justify-content-center align-items-center mt-3">
                                        <asp:Label runat="server" Text="Este usuario aún no ha conseguido ningún logro..." CssClass="display-7 text-center" />
                                    </div>
                                </EmptyDataTemplate>
                            </asp:GridView>
                        </asp:View>
                    </asp:MultiView>
                </div>
            </div>
        </div>
    </div>
</asp:Content>