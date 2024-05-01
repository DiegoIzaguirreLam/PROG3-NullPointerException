<%@ Page Title="" Language="C#" MasterPageFile="~/Steam.Master" AutoEventWireup="true" CodeBehind="Configuracion.aspx.cs" Inherits="SteamWA.Configuracion" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphScripts" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphContenido" runat="server">
    <div class="container">
        <h1 class="mt-4">Configuración de Usuario</h1>
        <!-- nombre de cuenta -->
        <div class="form-group">
            <label for="nombreCuenta">Nombre de Cuenta</label>
            <div class="input-group">
                <input type="text" class="form-control" id="nombreCuenta" placeholder="Usuario" disabled>
                <button class="btn btn-outline-secondary" type="button" id="editarNombreCuenta"><i class="fa-solid fa-pen-to-square"></i></button>
            </div>
        </div>

        <!-- nombre del perfil -->
        <div class="form-group">
            <label for="nombrePerfil">Nombre de Perfil</label>
            <div class="input-group">
                <input type="text" class="form-control" id="nombrePerfil" placeholder="NombrePerfil" disabled>
                <button class="btn btn-outline-secondary" type="button" id="editarNombrePerfil"><i class="fa-solid fa-pen-to-square"></i></button>
            </div>
        </div>

        <!-- correo -->
        <div class="form-group">
            <label for="correo">Correo Electrónico</label>
            <div class="input-group">
                <input type="email" class="form-control" id="correo" placeholder="usuario@gmail.com" disabled>
                <button class="btn btn-outline-secondary" type="button" id="editarCorreo"><i class="fa-solid fa-pen-to-square"></i></button>
            </div>
        </div>

        <!-- telefono -->
        <div class="form-group">
            <label for="telefono">Teléfono</label>
            <div class="input-group">
                <input type="tel" class="form-control" id="telefono" placeholder="984895374" disabled>
                <button class="btn btn-outline-secondary" type="button" id="editarTelefono"><i class="fa-solid fa-pen-to-square"></i></button>
            </div>
        </div>

        <!-- fecha de nacimiento -->
        <div class="form-group">
            <label for="fechaNacimiento">Fecha de Nacimiento</label>
            <div class="input-group">
                <input type="date" class="form-control" id="fechaNacimiento" disabled>
                <button class="btn btn-outline-secondary" type="button" id="editarFechaNacimiento"><i class="fa-solid fa-pen-to-square"></i></button>
            </div>
        </div>

        <!-- botones de confirmar y cancelar -->
        <div class="row mt-5">
            <div class="col-md-6 text-start">
                <button type="button" class="btn btn-secondary bg-danger btn-outline-light">Cancelar</button>
            </div>
            <div class="col-md-6 text-end">
                <button type="submit" class="btn btn-primary bg-success btn-outline-light">Guardar Cambios</button>
            </div>
        </div>
    </div>
</asp:Content>
