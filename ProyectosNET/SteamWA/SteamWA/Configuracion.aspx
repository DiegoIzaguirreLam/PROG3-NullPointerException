<%@ Page Title="" Language="C#" MasterPageFile="~/Steam.Master" AutoEventWireup="true" CodeBehind="Configuracion.aspx.cs" Inherits="SteamWA.Configuracion" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphScripts" runat="server">
    <script src="Scripts/Steam/mostrarModal.js"></script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphContenido" runat="server">
    <div class="container">
        <div class="card w-auto border-0 ms-5 me-5">
            <!-- Header -->
            <div class="card-header bg-navy">
                <h1 class="mt-4 text-white">Configuración de Usuario</h1>
            </div>
            <!-- Body -->
            <div class="card-body bg-navy">
                <!-- UID -->
                <div class="mb-4 row">
                    <asp:Label ID="Label1" runat="server" Text="UID:" CssClass="col-sm-3 col-form-label text-white" />
                    <div class="col-sm-4">
                        <div class="input-group">
                            <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control" PlaceHolder="Id del usuario" Enabled="false" />
                        </div>
                    </div>
                </div>

                <!-- nombre de cuenta -->
                <div class="mb-4 row">
                    <asp:Label ID="lblNombreCuenta" runat="server" Text="Nombre de cuenta:" CssClass="col-sm-3 col-form-label text-white" />
                    <div class="col-sm-9">
                        <div class="input-group">
                            <asp:TextBox ID="txtNombreCuenta" runat="server" CssClass="form-control" PlaceHolder="NombreUsuario" Enabled="false" />
                            <%--<asp:LinkButton ID="lbEditarNombreCuenta" runat="server" Text="<i class='fa-solid fa-pen-to-square'></i>" CssClass="btn btn-outline-secondary" Onclick="lbEditarNombreCuenta_Click"/>--%>
                        </div>
                    </div>
                </div>


                <!-- nombre del perfil -->
                <div class="mb-4 row">
                    <asp:Label ID="lblNombrePerfil" runat="server" Text="Nombre de perfil:" CssClass="col-sm-3 col-form-label text-white" />
                    <div class="col-sm-9">
                        <div class="input-group">
                            <asp:TextBox ID="txtNombrePerfil" runat="server" CssClass="form-control" PlaceHolder="NombrePerfil" Enabled="false" />
                            <%--<asp:LinkButton ID="lbEditarNombrePerfil" runat="server" Text="<i class='fa-solid fa-pen-to-square'></i>" CssClass="btn btn-outline-secondary" Onclick="lbEditarNombrePerfil_Click"/>--%>
                        </div>
                    </div>
                </div>

                <!-- correo -->
                <div class="mb-4 row ">
                    <asp:Label ID="lblCorreo" runat="server" Text="Correo Electrónico:" CssClass="col-sm-3 col-form-label text-white" />
                    <div class="col-sm-9">
                        <div class="input-group">
                            <asp:TextBox ID="txtCorreo" runat="server" CssClass="form-control" PlaceHolder="usuario@gmail.com" Enabled="false" />
                            <%--<asp:LinkButton ID="lbEditarCorreo" runat="server" Text="<i class='fa-solid fa-pen-to-square'></i>" CssClass="btn btn-outline-secondary" Onclick="lbEditarCorreo_Click"/>--%>
                        </div>
                    </div>
                </div>

                <!-- telefono -->
                <div class="mb-4 row">
                    <asp:Label ID="lblTelefono" runat="server" Text="Teléfono:" CssClass="col-sm-3 col-form-label text-white" />
                    <div class="col-sm-9">
                        <div class="input-group">
                            <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control" PlaceHolder="#########" Enabled="false" />
                            <%--<asp:LinkButton ID="lbEditarTelefono" runat="server" Text="<i class='fa-solid fa-pen-to-square'></i>" CssClass="btn btn-outline-secondary" Onclick="lbEditarTelefono_Click"/>--%>
                        </div>
                    </div>
                </div>

                <!-- fecha de nacimiento -->
                <div class="mb-4 row">
                    <asp:Label ID="lblFechaNacimiento" runat="server" Text="Fecha de Nacimiento:" CssClass="col-sm-3 col-form-label text-white" />
                    <div class="col-sm-9">
                        <div class="input-group">
                            <input class="form-control" type="date" id="dtpFechaNacimiento" runat="server" disabled />
                            <%--<asp:LinkButton ID="lbEditarFechaNacimiento" runat="server" Text="<i class='fa-solid fa-pen-to-square'></i>" CssClass="btn btn-outline-secondary" Onclick="lbEditarFechaNacimiento_Click"/>--%>
                        </div>
                    </div>
                </div>

                <!-- país -->
                <div class="mb-4 row align-items-center">
                    <asp:Label ID="lblPais" runat="server" Text="País:" CssClass="col-sm-3 col-form-label text-white" />
                    <div class="col-sm-9">
                        <div class="input-group">
                            <asp:DropDownList CssClass="form-control" runat="server" ID="ddlPaises" data-style="btn-primary" Enabled="false" Placeholder="Seleccionar país...">
                            </asp:DropDownList>
                            <%--<asp:LinkButton ID="lbEditarPais" runat="server" Text="<i class='fa-solid fa-pen-to-square'></i>" CssClass="btn btn-outline-secondary" Onclick="lbEditarPais_Click"/>--%>
                        </div>
                    </div>
                </div>

            </div>
            <!-- Footer -->
            <div class="card-footer clearfix bg-navy ">
                <asp:Button ID="btnCancelar" runat="server" Text="Cancelar"
                    CssClass="float-start btn btn-danger" OnClick="btnCancelar_Click" />
                <div>
                    <asp:Button ID="btnGuardar" runat="server" Text="Guardar cambios"
                        CssClass="float-end btn btn-success" OnClick="btnGuardar_Click" />
                    <asp:Button ID="btnEditar" runat="server" Text="Editar"
                        CssClass="float-end me-2 btn btn-outline-light" OnClick="btnEditar_Click" />
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
                        <h5 class="modal-title" id="lblEliminarAmigo">Guardar cambios</h5>
                    </div>
                    <div class="modal-body">
                        <p>¿Está seguro que desea los cambios realizados en su cuenta?</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <button type="button" class="btn btn-primary">Guardar</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
