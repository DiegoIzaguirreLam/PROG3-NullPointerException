﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Steam.Master" AutoEventWireup="true" CodeBehind="Configuracion.aspx.cs" Inherits="SteamWA.Configuracion" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphScripts" runat="server">
    <script src="Scripts/Steam/mostrarModal.js"></script>
    <script src="Scripts/Steam/Registro.js"></script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphContenido" runat="server">
    <div class="container">
        <h1 class="mt-4 text-white">Configuración de Usuario</h1>
        <hr />
        <div class="row justify-content-center">
            <div class="col-md-10">
                <asp:Label ID="lblMensajeError" runat="server" CssClass="alert alert-danger mt-4 mb-3" Visible="false" Width="100% "></asp:Label>
                <div class="mt-3">
                    <div class="mb-4 row">
                        <asp:Label ID="lblUID" runat="server" Text="UID:" CssClass="col-sm-3 col-form-label text-white" />
                        <div class="col-sm-4">
                            <div class="input-group">
                                <asp:TextBox ID="txtUID" runat="server" CssClass="form-control" PlaceHolder="Id del usuario" Enabled="false" />
                            </div>
                        </div>
                    </div>

                    <!-- Nombre de cuenta -->
                    <div class="mb-4 row">
                        <label id="lblNombreCuenta" class="col-sm-3 col-form-label text-white">Nombre de cuenta <span class="text-danger">*</span></label>
                        <div class="col-sm-9">
                            <div class="input-group">
                                <asp:TextBox runat="server" ID="txtNombreCuenta" CssClass="form-control" Enabled="false" MaxLength="20" />
                            </div>
                        </div>
                    </div>


                    <!-- nombre del perfil -->
                    <div class="mb-4 row">
                        <label id="lblNombrePerfil" class="col-sm-3 col-form-label text-white" runat="server">Nombre de perfil <span class="text-danger">*</span></label>
                        <div class="col-sm-9">
                            <div class="input-group">
                                <asp:TextBox ID="txtNombrePerfil" runat="server" CssClass="form-control" Enabled="false" MaxLength="40" />
                            </div>
                        </div>
                    </div>

                    <!-- correo -->
                    <div class="mb-4 row ">
                        <label id="lblCorreo" class="col-sm-3 col-form-label text-white" runat="server">Correo electrónico <span class="text-danger">*</span></label>
                        <div class="col-sm-9">
                            <div class="input-group">
                                <asp:TextBox ID="txtCorreo" runat="server" CssClass="form-control" Enabled="false" MaxLength="50" />
                            </div>
                            <asp:RegularExpressionValidator ID="regexCorreo" runat="server" ControlToValidate="txtCorreo"
                                ErrorMessage="Por favor, ingrese un correo electrónico válido."
                                ValidationExpression="^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$" Display="Dynamic" ForeColor="White" SetFocusOnError="true">
                            </asp:RegularExpressionValidator>
                        </div>
                    </div>

                    <!-- telefono -->
                    <div class="mb-4 row">
                        <label id="lblTelefono" class="col-sm-3 col-form-label text-white" runat="server">Telefono <span class="text-danger">*</span></label>
                        <div class="col-sm-9">
                            <div class="input-group">
                                <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control" Enabled="false" MaxLength="15" onkeypress="return soloNumeros(event)" />
                            </div>
                        </div>
                    </div>

                    <!-- fecha de nacimiento -->
                    <div class="mb-4 row">
                        <label id="lblFechaNacimiento" class="col-sm-3 col-form-label text-white" runat="server">Fecha de nacimiento <span class="text-danger">*</span></label>
                        <div class="col-sm-9">
                            <div class="input-group">
                                <asp:TextBox runat="server" ID="txtFechaNacimiento" Type="Date" CssClass="form-control" Enabled="false" ClientIDMode="Static" />
                            </div>
                            <asp:CustomValidator ID="cvFechaNacimiento" runat="server" ErrorMessage="Debe ser mayor de 13 años para continuar."
                                ControlToValidate="txtFechaNacimiento" ClientValidationFunction="validarEdad" Display="Dynamic" ForeColor="White" SetFocusOnError="true" />
                        </div>
                    </div>

                    <!-- país -->
                    <div class="mb-4 row align-items-center">
                        <label id="lblPais" class="col-sm-3 col-form-label text-white" runat="server">Pais <span class="text-danger">*</span></label>
                        <div class="col-sm-9">
                            <div class="input-group">
                                <asp:DropDownList CssClass="form-control" runat="server" ID="ddlPaises" data-style="btn-primary" Enabled="false" Placeholder="Seleccionar país...">
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>

                    <!-- Imagen de perfil -->
                    <asp:Panel ID="PanelImagen" runat="server" Visible="false">
                        <div class="mb-4 row">
                            <div class="col-md-3">
                                <label id="lblURL" class="form-label" runat="server">Foto de perfil:</label>
                            </div>
                            <div class="col-md-9">
                                <asp:FileUpload ID="fileUpdloadFotoPerfil" runat="server"
                                    CssClass="form-control mb-2" />
                            </div>
                        </div>
                    </asp:Panel>

                </div>
                <div id="divBotonesConfiguracion" runat="server" class="d-flex justify-content-between mb-4">
                    <asp:Button ID="btnCancelar" CssClass="btn btn-secondary" runat="server" Text="Cancelar" OnClick="btnCancelar_Click"  UseSubmitBehavior="false"/>
                    <div id="divEliminarGuardar" runat="server">
                        <asp:Button ID="btnEditar" CssClass="btn btn-outline-light" runat="server" Text="Editar" OnClick="btnEditar_Click" />
                        <asp:Button ID="btnGuardar" CssClass="btn btn-success" runat="server" Text="Guardar" OnClick="btnGuardar_Click" Visible="false"/>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- modal para editar foto de perfil-->
    <div class="modal fade" id="form-modal-Editar" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="container bg-dark">
                    <div class="modal-header">
                        <h5 class="modal-title" id="lblEditarCampos">Editar datos de usuario</h5>
                        <button type="button" class="btn-close bg-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <p>¿Desea editar su imagen de perfil?</p>
                    </div>
                    <div class="modal-footer">
                        <asp:Button ID="btnNo" runat="server" CssClass="btn btn-danger" Text="No" OnClick="btnNo_Click" />
                        <asp:Button ID="btnSi" runat="server" CssClass="btn btn-success" Text="Sí" OnClick="btnSi_Click" />
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- modal para guardar cambios-->
    <div class="modal fade" id="form-modal-GuardarCambios" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="container bg-dark">
                    <div class="modal-header">
                        <h5 class="modal-title" id="lblGuardarCambios">Guardar cambios</h5>
                        <button type="button" class="btn-close bg-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <p>¿Está seguro que desea los cambios realizados en su cuenta?</p>
                    </div>
                    <div class="modal-footer">
                        <asp:Button ID="btnCancelarModal" runat="server" CssClass="btn btn-secondary" Text="Cancelar" OnClick="btnCancelarModal_Click"/>
                        <asp:Button ID="btnGuardarModal" runat="server" CssClass="btn btn-success" Text="Guardar" OnClick="btnGuardarModal_Click"/>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
