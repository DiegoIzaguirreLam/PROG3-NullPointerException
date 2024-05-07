<%@ Page Title="" Language="C#" MasterPageFile="~/Inicio.Master" AutoEventWireup="true" CodeBehind="Registro.aspx.cs" Inherits="SteamWA.Registro" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphScripts" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphContenido" runat="server">
    <div class="container mt-5 ms-auto me-auto">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <h2 class="text-center mb-4"><strong>REGISTRO</strong></h2>
                <div>
                    <h5 class="mt-4"><strong>Información de cuenta</strong></h5>
                    <!-- Nombre de cuenta -->
                    <div class="form-group mb-3">
                        <asp:Label ID="lblNombreCuenta" runat="server" CssClass="form-label" Text="Nombre de cuenta:" />
                        <asp:TextBox runat="server" ID="txtNombreCuenta" CssClass="form-control" placeholder="Ingrese su nombre de cuenta" Required="true" />
                    </div>

                    <!-- Nombre de perfil -->
                    <div class="mb-3">
                        <asp:Label ID="lblNombrePerfil" runat="server" CssClass="form-label" Text="Nombre de perfil:" />
                        <asp:TextBox runat="server" ID="txtNombrePerfil" CssClass="form-control" placeholder="Ingrese su nombre de perfil" Required="true" />
                    </div>

                    <!-- Contraseña -->
                    <div class="row">
                        <div class="col-sm mb-3">
                            <asp:Label ID="lblContrasenia" runat="server" CssClass="form-label" Text="Contraseña" />
                            <div class="input-group">
                                <asp:TextBox runat="server" ID="txtContrasenia" TextMode="Password" CssClass="form-control" placeholder="Ingrese su contraseña" Required="true" />
                            </div>
                        </div>
                        <div class="col-sm mb-3">
                            <asp:Label ID="lblConfirmarContrasenia" runat="server" CssClass="form-label" Text="Confirma contraseña" />
                            <div class="input-group">
                                <asp:TextBox runat="server" ID="txtConfirmaContrasenia" TextMode="Password" CssClass="form-control" placeholder="Ingrese su contraseña" Required="true" />
                            </div>
                        </div>
                    </div>
                </div>
                <div>
                    <h5 class="mt-4"><strong>Información adicional</strong></h5>
                    <!-- Correo electronico -->
                    <div class="mb-3">
                        <asp:Label ID="lblCorreo" runat="server" CssClass="form-label" Text="Correo electrónico:" />
                        <asp:TextBox runat="server" ID="txtCorreo" Type="Email" CssClass="form-control" placeholder="Ingrese su correo electrónico" Required="true" />
                    </div>

                    <!-- Telefono -->
                    <div class="mb-3">
                        <asp:Label ID="lblTelefono" runat="server" CssClass="form-label" Text="Teléfono" />
                        <asp:TextBox runat="server" ID="txtTelefono" Type="Phone" CssClass="form-control" placeholder="Ingrese su número de teléfono" Required="true" />
                    </div>

                    <!-- Fecha de nacimiento -->
                    <div class="mb-3">
                        <asp:Label ID="lblFechaNacimiento" runat="server" CssClass="form-label" Text="Fecha Nacimiento:" />
                        <asp:TextBox runat="server" ID="dtpFechaNacimiento" Type="Date" CssClass="form-control" Required="true" />
                    </div>

                    <!-- Edad -->
                    <div class="mb-3">
                        <asp:Label ID="lblEdad" runat="server" CssClass="form-label" Text="Edad:" />
                        <asp:TextBox runat="server" ID="txtEdad" Type="Number" CssClass="form-control" Min="18" Required="true" />
                    </div>

                    <!-- País -->
                    <div class="mb-3">
                        <asp:Label ID="lblPais" runat="server" CssClass="form-label" Text="País:" />
                        <asp:DropDownList runat="server" ID="ddlPaises" CssClass="form-select">
                            <asp:ListItem Text="Seleccione un país" Value="" />
                            <asp:ListItem Text="Perú" Value="" />
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="mt-4 mb-2 text-end">
                    <asp:Button ID="btnRegistro" runat="server" CssClass="btn btn-success" Text="Registrarse" OnClick="lbRegistrar_Click" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
