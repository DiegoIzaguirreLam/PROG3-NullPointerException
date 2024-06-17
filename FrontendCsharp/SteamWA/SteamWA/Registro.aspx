<%@ Page Title="" Language="C#" MasterPageFile="~/Inicio.Master" AutoEventWireup="true" CodeBehind="Registro.aspx.cs" Inherits="SteamWA.Registro" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphScripts" runat="server">
    <script src="Scripts/Steam/Registro.js"></script>
    <script src="Scripts/Steam/Contrasenia.js"></script>
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
                            <asp:TextBox runat="server" ID="txtNombreCuenta" CssClass="form-control" placeholder="Ingrese su nombre de cuenta" Required="true" MaxLength="20"/>
                        </div>

                        <!-- Nombre de perfil -->
                        <div class="mb-3">
                            <label id="lblNombrePerfil" class="form-label" runat="server">Nombre de perfil <span class="text-danger">*</span></label>
                            <asp:TextBox runat="server" ID="txtNombrePerfil" CssClass="form-control" placeholder="Ingrese su nombre de perfil" Required="true" MaxLength="40"/>
                        </div>

                        <!-- Contraseña -->
                        <div class="row">
                            <div class="col-sm mb-3">
                                <label id="lblContrasenia" class="form-label" runat="server">Contraseña <span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <asp:TextBox runat="server" ID="txtContrasenia" TextMode="Password" CssClass="form-control" placeholder="Ingrese su contraseña" Required="true" MaxLength="20"/>
                                    <button type="button" id="togglePassword" class="btn toggle-password-btn" style="border: 1px solid #DEE2E6;">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </div>
                            </div>
                            <div class="col-sm mb-3">
                                <label id="lblConfirmarContrasenia" class="form-label" runat="server">Confirma contraseña <span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <asp:TextBox runat="server" ID="txtConfirmaContrasenia" TextMode="Password" CssClass="form-control" placeholder="Ingrese su contraseña" Required="true" MaxLength="20"/>
                                    <button type="button" id="toggleConfirmPassword" class="btn toggle-password-btn" style="border: 1px solid #DEE2E6;">
                                        <i class="fas fa-eye"></i>
                                    </button>
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
                            <asp:TextBox runat="server" ID="txtCorreo" Type="Email" CssClass="form-control" placeholder="Ingrese su correo electrónico" Required="true" MaxLength="50"/>
                            <asp:RegularExpressionValidator ID="regexCorreo" runat="server" ControlToValidate="txtCorreo"
                                ErrorMessage="Por favor, ingrese un correo electrónico válido."
                                ValidationExpression="^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$" Display="Dynamic" ForeColor="Red" SetFocusOnError="true">
                            </asp:RegularExpressionValidator>
                        </div>

                        <!-- Telefono -->
                        <div class="mb-3">
                            <label id="lblTelefono" class="form-label" runat="server">Teléfono <span class="text-danger">*</span></label>
                            <asp:TextBox runat="server" ID="txtTelefono" Type="Phone" CssClass="form-control" placeholder="Ingrese su número de teléfono" Required="true" MaxLength="15" onkeypress="return soloNumeros(event)"/>
                        </div>

                        <!-- Fecha de nacimiento -->
                        <div class="mb-3">
                            <label id="lblFechaNacimiento" class="form-label" runat="server">Fecha de nacimiento <span class="text-danger">*</span></label>
                            <asp:TextBox runat="server" ID="txtFechaNacimiento" Type="Date" CssClass="form-control" Required="true" ClientIDMode="Static"/>
                            <asp:CustomValidator ID="cvFechaNacimiento" runat="server" ErrorMessage="Debe ser mayor de 13 años para continuar." 
                                ControlToValidate="txtFechaNacimiento" ClientValidationFunction="validarEdad" Display="Dynamic" ForeColor="Red" SetFocusOnError="true"/>
                        </div>

                        <!-- País -->
                        <div class="mb-3">
                            <label id="lblPais" class="form-label" runat="server">País <span class="text-danger">*</span></label>
                            <asp:DropDownList runat="server" ID="ddlPaises" CssClass="form-select">
                                <asp:ListItem Text="Seleccione un país" Value="" />
                                <asp:ListItem Text="Perú" Value="" />
                            </asp:DropDownList>
                        </div>

                        <!-- URL de imagen -->
                        <div class="mb-3">
                            <label id="lblURL" class="form-label" runat="server">URL de imagen de perfil:</label>
                            <asp:TextBox runat="server" ID="txtURL" CssClass="form-control"/>
                            <%--<asp:CustomValidator ID="cvURL" runat="server" ErrorMessage="La URL no apunta a una imagen válida." ControlToValidate="txtURL"
                                ClientValidationFunction="validarImagenURL" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ClientIDMode="Static"/>--%>
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
