<%@ Page Title="" Language="C#" MasterPageFile="~/Steam.Master" AutoEventWireup="true" CodeBehind="Configuracion.aspx.cs" Inherits="SteamWA.Configuracion" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphScripts" runat="server">
    <script src="Scripts/Steam/mostrarModal.js"></script>
    <script type="text/javascript">
        function validarEdad(source, args) {
            var fechaNacimiento = new Date(document.getElementById('<%= txtFechaNacimiento.ClientID %>').value);
            var hoy = new Date();
            var edad = hoy.getFullYear() - fechaNacimiento.getFullYear();
            var mes = hoy.getMonth() - fechaNacimiento.getMonth();
            if (mes < 0 || (mes === 0 && hoy.getDate() < fechaNacimiento.getDate())) {
                edad--;
            }
            args.IsValid = edad >= 13;
        }
    </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphContenido" runat="server">
    <div class="container">
        <asp:Label ID="lblMensajeError" runat="server" CssClass="alert alert-danger mt-4" Visible="false" Width="100% "></asp:Label>
        <div class="card w-auto border-0 ms-5 me-5">
            <!-- Header -->
            <div class="card-header bg-navy">
                <h1 class="mt-4 text-white">Configuración de Usuario</h1>
            </div>
            <!-- Body -->
            <div class="card-body bg-navy">
                <!-- UID -->
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
                            <asp:TextBox ID="txtNombreCuenta" runat="server" CssClass="form-control" PlaceHolder="NombreUsuario" Enabled="false" Required="true"/>
                            <%--<asp:LinkButton ID="lbEditarNombreCuenta" runat="server" Text="<i class='fa-solid fa-pen-to-square'></i>" CssClass="btn btn-outline-secondary" Onclick="lbEditarNombreCuenta_Click"/>--%>
                        </div>
                    </div>
                </div>


                <!-- nombre del perfil -->
                <div class="mb-4 row">
                    <label id="lblNombrePerfil" class="col-sm-3 col-form-label text-white" runat="server">Nombre de perfil <span class="text-danger">*</span></label>
                    <div class="col-sm-9">
                        <div class="input-group">
                            <asp:TextBox ID="txtNombrePerfil" runat="server" CssClass="form-control" PlaceHolder="NombrePerfil" Enabled="false" Required="true"/>
                            <%--<asp:LinkButton ID="lbEditarNombrePerfil" runat="server" Text="<i class='fa-solid fa-pen-to-square'></i>" CssClass="btn btn-outline-secondary" Onclick="lbEditarNombrePerfil_Click"/>--%>
                        </div>
                    </div>
                </div>

                <!-- correo -->
                <div class="mb-4 row ">
                    <label id="lblCorreo" class="col-sm-3 col-form-label text-white" runat="server">Correo electrónico <span class="text-danger">*</span></label>
                    <div class="col-sm-9">
                        <div class="input-group">
                            <asp:TextBox ID="txtCorreo" runat="server" CssClass="form-control" PlaceHolder="usuario@gmail.com" Enabled="false" Required="true"/>
                            <%--<asp:LinkButton ID="lbEditarCorreo" runat="server" Text="<i class='fa-solid fa-pen-to-square'></i>" CssClass="btn btn-outline-secondary" Onclick="lbEditarCorreo_Click"/>--%>
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
                            <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control" PlaceHolder="#########" Enabled="false" Required="true"/>
                            <%--<asp:LinkButton ID="lbEditarTelefono" runat="server" Text="<i class='fa-solid fa-pen-to-square'></i>" CssClass="btn btn-outline-secondary" Onclick="lbEditarTelefono_Click"/>--%>
                        </div>
                        <asp:RegularExpressionValidator ID="regexTelefono" runat="server" ControlToValidate="txtTelefono"
                            ErrorMessage="Por favor, ingrese un número de teléfono válido." ValidationExpression="^\d+$" Display="Dynamic" ForeColor="White" SetFocusOnError="true">
                        </asp:RegularExpressionValidator>
                    </div>
                </div>

                <!-- fecha de nacimiento -->
                <div class="mb-4 row">
                    <label id="lblFechaNacimiento" class="col-sm-3 col-form-label text-white" runat="server">Fecha de nacimiento <span class="text-danger">*</span></label>
                    <div class="col-sm-9">
                        <div class="input-group">
                            <asp:TextBox runat="server" ID="txtFechaNacimiento" Type="Date" CssClass="form-control" Enabled="false" Required="true"/>
                            <%--<asp:LinkButton ID="lbEditarFechaNacimiento" runat="server" Text="<i class='fa-solid fa-pen-to-square'></i>" CssClass="btn btn-outline-secondary" Onclick="lbEditarFechaNacimiento_Click"/>--%>
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
                            <asp:DropDownList CssClass="form-control" runat="server" ID="ddlPaises" data-style="btn-primary" Enabled="false" Placeholder="Seleccionar país..." Required="true">
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
                        <asp:Button ID="btnGuardarModal" runat="server" CssClass="btn btn-primary" Text="Guardar" OnClick="btnGuardarModal_Click"/>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
