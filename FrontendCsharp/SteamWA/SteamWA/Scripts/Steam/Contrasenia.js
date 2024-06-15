document.addEventListener('DOMContentLoaded', function () {
    var togglePasswordButtons = document.querySelectorAll('.toggle-password-btn');

    togglePasswordButtons.forEach(function (button) {
        button.addEventListener('click', function () {
            var passwordInput = this.previousElementSibling;
            var toggleIcon = this.querySelector('i');

            // Alternar el tipo de campo
            var tipo = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
            passwordInput.setAttribute('type', tipo);

            // Alternar el ícono
            if (tipo === 'text') {
                toggleIcon.classList.remove('fa-eye');
                toggleIcon.classList.add('fa-eye-slash');
            } else {
                toggleIcon.classList.remove('fa-eye-slash');
                toggleIcon.classList.add('fa-eye');
            }
        });
    });
});