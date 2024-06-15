<%@ Page Title="" Language="C#" MasterPageFile="~/Inicio.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="SteamWA.Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphScripts" runat="server">
    <script src="Scripts/Steam/Contrasenia.js"></script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphContenido" runat="server">
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="mb-4">
                    <asp:Label ID="lblMensajeExito" runat="server" CssClass="alert alert-success" Visible="false" Width="100%" ></asp:Label>
                    <asp:Label ID="lblMensajeError" runat="server" CssClass="alert alert-danger" Visible="false" Width="100% "></asp:Label>
                </div>
                <div class="card p-4">
                    <div class="card-body">
                        <div class="text-center">
                            <h3><strong>INICIO DE SESIÓN</strong></h3>
                        </div>
                        <div class="row gy-3 gy-md-4 overflow-hidden">
                            <!-- Nombre de cuenta -->
                            <div class="form-group col-12">
                                <label id="lblNombreCuenta" class="form-label">Nombre de cuenta <span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <div class="input-group-text">
                                        <i class="fas fa-user"></i>
                                    </div>
                                    <asp:TextBox ID="txtNombreCuenta" runat="server" CssClass="form-control btn-outline-dark" Required="true" MaxLength="20"></asp:TextBox>
                                </div>
                            </div>
                            <!-- Contraseña -->
                            <div class="form-group col-12">
                                <label id="lblPassword" class="form-label">Contraseña <span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <div class="input-group-text">
                                        <i class="fas fa-key"></i>
                                    </div>
                                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control btn-outline-dark" TextMode="Password" Required="true" MaxLength="20"></asp:TextBox>
                                    <button type="button" id="toggleConfirmPassword" class="btn toggle-password-btn" style="border: 1px solid #DEE2E6;">
                                        <i class="fas fa-eye"></i>
                                    </button>
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
