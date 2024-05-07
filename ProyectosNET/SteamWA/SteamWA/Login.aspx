<%@ Page Title="" Language="C#" MasterPageFile="~/Inicio.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="SteamWA.Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphScripts" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphContenido" runat="server">
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="mb-4">
                    <asp:Label ID="lblMensajeExito" runat="server" CssClass="alert alert-success" Visible="false"></asp:Label>
                </div>
                <div class="card">
                    <div class="card-header">
                        <strong>Iniciar Sesión</strong>
                    </div>
                    <div class="card-body">
                        <div class="form-group">
                            <asp:Label ID="lblNombreCuenta" runat="server" Text="Nombre de cuenta:"></asp:Label>
                            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control btn-outline-dark" Required="true"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="lblContrasenia" runat="server" Text="Contraseña:"></asp:Label>
                            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control btn-outline-dark" TextMode="Password" Required="true"></asp:TextBox>
                        </div>
                        <div class="mt-3">
                            <asp:Button ID="btnLogin" runat="server" Text="Iniciar Sesión" CssClass="btn btn-dark btn-block" OnClick="btnLogin_Click" />
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
