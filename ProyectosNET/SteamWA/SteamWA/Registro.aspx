<%@ Page Title="" Language="C#" MasterPageFile="~/Inicio.Master" AutoEventWireup="true" CodeBehind="Registro.aspx.cs" Inherits="SteamWA.Registro" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphScripts" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphContenido" runat="server">
    <div class="container">
        <div class="row justify-content-md-center">
            <div class="col-12 col-md-11 col-lg-8 col-xl-7 col-xxl-6">
                <asp:Label ID="lblMensajeError" runat="server" CssClass="alert alert-danger mt-4" Visible="false" Width="100% "></asp:Label>
                <div class="bg-white p-4 p-md-5 rounded shadow-sm mb-4 mt-4">
                    <h2 class="text-center mb-4"><strong>REGISTRO</strong></h2>
                    <div>
                        <h5 class="mt-4"><strong>Información de cuenta</strong></h5>
                        <!-- Nombre de cuenta -->
                        <div class="form-group mb-3">
                            <label id="lblNombreCuenta" class="form-label" runat="server">Nombre de cuenta <span class="text-danger">*</span></label>
                            <asp:TextBox runat="server" ID="txtNombreCuenta" CssClass="form-control" placeholder="Ingrese su nombre de cuenta" Required="true" />
                        </div>

                        <!-- Nombre de perfil -->
                        <div class="mb-3">
                            <label id="lblNombrePerfil" class="form-label" runat="server">Nombre de perfil <span class="text-danger">*</span></label>
                            <asp:TextBox runat="server" ID="txtNombrePerfil" CssClass="form-control" placeholder="Ingrese su nombre de perfil" Required="true" />
                        </div>

                        <!-- Contraseña -->
                        <div class="row">
                            <div class="col-sm mb-3">
                                <label id="lblContrasenia" class="form-label" runat="server">Contraseña <span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <asp:TextBox runat="server" ID="txtContrasenia" TextMode="Password" CssClass="form-control" placeholder="Ingrese su contraseña" />
                                    <%--<asp:LinkButton ID="lbVisualizarContrasenia" runat="server" CssClass="btn btn-light" Text="<i class='fas fa-eye'></i>"/>--%>
                                </div>
                            </div>
                            <div class="col-sm mb-3">
                                <label id="lblConfirmarContrasenia" class="form-label" runat="server">Confirma contraseña <span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <asp:TextBox runat="server" ID="txtConfirmaContrasenia" TextMode="Password" CssClass="form-control" placeholder="Ingrese su contraseña" />
                                    <%--<asp:LinkButton ID="lbVisualizarConfirmaContrasenia" runat="server" CssClass="btn btn-light" Text="<i class='fas fa-eye'></i>"/>--%>
                                </div>
                            </div>
                            <asp:CompareValidator ID="cmpValContrasenia" runat="server" ErrorMessage="Contraseña y Confirma contraseña deben ser iguales."
                                ControlToCompare="txtContrasenia" ControlToValidate="txtConfirmaContrasenia" ForeColor="Red" Display="Dynamic" SetFocusOnError="true"></asp:CompareValidator>
                        </div>
                    </div>
                    <div>
                        <h5 class="mt-4"><strong>Información adicional</strong></h5>
                        <!-- Correo electronico -->
                        <div class="mb-3">
                            <label id="lblCorreo" class="form-label" runat="server">Correo electrónico <span class="text-danger">*</span></label>
                            <asp:TextBox runat="server" ID="txtCorreo" Type="Email" CssClass="form-control" placeholder="Ingrese su correo electrónico" Required="true" />
                        </div>

                        <!-- Telefono -->
                        <div class="mb-3">
                            <label id="lblTelefono" class="form-label" runat="server">Teléfono <span class="text-danger">*</span></label>
                            <asp:TextBox runat="server" ID="txtTelefono" Type="Phone" CssClass="form-control" placeholder="Ingrese su número de teléfono" Required="true" />
                        </div>

                        <!-- Fecha de nacimiento -->
                        <div class="mb-3">
                            <label id="lblFechaNacimiento" class="form-label" runat="server">Fecha de nacimiento <span class="text-danger">*</span></label>
                            <asp:TextBox runat="server" ID="txtFechaNacimiento" Type="Date" CssClass="form-control" Required="true" />
                        </div>

                        <!-- Edad -->
                        <div class="mb-3">
                            <label id="lblEdad" class="form-label" runat="server">Edad <span class="text-danger">*</span></label>
                            <asp:TextBox runat="server" ID="txtEdad" Type="Number" CssClass="form-control" Min="18" Required="true" />
                        </div>

                        <!-- País -->
                        <div class="mb-3">
                            <label id="lblPais" class="form-label" runat="server">País <span class="text-danger">*</span></label>
                            <asp:DropDownList runat="server" ID="ddlPaises" CssClass="form-select">
                                <asp:ListItem Text="Seleccione un país" Value="" />
                                <asp:ListItem Text="Perú" Value="" />
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="mt-4 d-grid">
                        <asp:Button ID="btnRegistro" runat="server" CssClass="btn btn-success" Text="Registrarse" OnClick="lbRegistrar_Click" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
