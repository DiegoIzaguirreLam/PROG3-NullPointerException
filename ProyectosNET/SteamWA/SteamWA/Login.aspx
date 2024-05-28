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
                    <asp:Label ID="lblMensajeExito" runat="server" CssClass="alert alert-success" Visible="false" Width="100%" ></asp:Label>
                    <asp:Label ID="lblMensajeError" runat="server" CssClass="alert alert-danger" Visible="false" Width="100% "></asp:Label>
                </div>
                <div class="card">
                    <div class="card-header">
                        <strong>Iniciar sesión</strong>
                    </div>
                    <div class="card-body p-4">
                        <div class="row gy-3 gy-md-4 overflow-hidden">
                            <div class="form-group col-12">
                                <label id="lblNombreCuenta" class="form-label">Nombre de cuenta <span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <div class="input-group-text">
                                        <i class="fas fa-user"></i>
                                    </div>
                                    <asp:TextBox ID="txtNombreCuenta" runat="server" CssClass="form-control btn-outline-dark" Required="true"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group col-12">
                                <label id="lblPassword" class="form-label">Contraseña <span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <div class="input-group-text">
                                        <i class="fas fa-key"></i>
                                    </div>
                                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control btn-outline-dark" TextMode="Password" Required="true"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="d-grid">
                                    <asp:Button ID="btnLogin" runat="server" Text="Log In" CssClass="btn btn-dark btn-block" OnClick="btnLogin_Click" type="submit"/>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
