<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>Inicio de Sesión</title>
    <link rel="icon" href=".../assets/img/EscudoCDO.png" type="image/png">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet"/>
    <style>
        .custom-header {
            background-color: #0A0A3D;
        }
        .custom-text {
            color: #0A0A3D;
        }
        .error-message {
            color: red;
            font-size: 0.9em;
            display: none;
        }
        .input-error {
            border-color: #ff0000;
        }
        .input-group-append i {
            color: #ff0000;
        }
        .hidden {
            display: none;
        }
        @media (max-width: 576px) {
            .custom-header h1 {
                font-size: 1.2rem;
            }
            .custom-header img {
                width: 60px;
                height: 70px;
            }
        }
    </style>
</head>
<body class="bg-white d-flex flex-column align-items-center justify-content-center min-vh-100">
    <header class="w-100 py-4 custom-header text-white text-center d-flex justify-content-center align-items-center">
        <h1 class="mb-0">COLEGIO PERUANO CHINO DIEZ DE OCTUBRE</h1>
        <img src="..\webapp/assets/img/EscudoCDO.png" alt="Escudo CDO" class="ml-3" style="width: 80px; height: 90px; object-fit: contain;">
    </header>
    <div class="container-fluid d-flex justify-content-center align-items-center flex-grow-1 px-3">
        <div class="bg-white shadow-lg rounded-lg p-4 w-100" style="max-width: 400px;">
            <h2 class="text-center text-muted mb-2">Ingresa tus datos para</h2>
            <h2 class="text-center custom-text font-weight-bold mb-4">iniciar sesión.</h2>

            <form action="login" method="post">
                <div class="form-group">
                    <label for="dni" class="custom-text">DNI</label>
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text custom-input-group-text"><i class="fas fa-user"></i></span>
                        </div>
                        <input type="text" class="form-control" id="dni" name="dni" placeholder="Ingrese su DNI" required aria-label="DNI de usuario">
                        <div class="input-group-append">
                            <span class="input-group-text <%= (request.getAttribute("error") != null) ? "" : "hidden" %>" id="dni-error-icon"><i class="fas fa-times-circle"></i></span>
                        </div>
                    </div>
                    <small id="dni-error" class="error-message <%= (request.getAttribute("error") != null) ? "" : "hidden" %>"><%= (request.getAttribute("error") != null) ? request.getAttribute("error") : "El DNI ingresado no es válido." %></small>
                </div>

                <div class="form-group">
                    <label for="password" class="custom-text">Contraseña</label>
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text custom-input-group-text"><i class="fas fa-lock"></i></span>
                        </div>
                        <input type="password" class="form-control" id="password" name="password" placeholder="Ingrese su contraseña" required aria-label="Contraseña">
                        <div class="input-group-append">
                            <button class="btn btn-outline-secondary" type="button" id="togglePassword" aria-label="Mostrar/Ocultar contraseña">
                                <i class="fas fa-eye"></i>
                            </button>
                            <span class="input-group-text <%= (request.getAttribute("error") != null) ? "" : "hidden" %>" id="password-error-icon"><i class="fas fa-times-circle"></i></span>
                        </div>
                    </div>
                    <small id="password-error" class="error-message <%= (request.getAttribute("error") != null) ? "" : "hidden" %>"><%= (request.getAttribute("error") != null) ? request.getAttribute("error") : "La contraseña es incorrecta." %></small>
                </div>

                <div class="mb-3 form-check">
                    <input type="checkbox" class="form-check-input" id="rememberMe" name="rememberMe">
                    <label class="form-check-label custom-text" for="rememberMe">Recordar sesión</label>
                </div>

                <div class="d-grid gap-2">
                        <button type="submit" class="btn btn-danger w-100 mt-3">Iniciar sesión</button>
                </div>
            </form>

            <div class="text-center mt-3">
                <a href="#" data-bs-toggle="modal" data-bs-target="#forgotPasswordModal" class="small text-decoration-none custom-text">¿Olvidaste tu contraseña?</a>
            </div>
        </div>
    </div>

    <div class="modal fade" id="forgotPasswordModal" tabindex="-1" aria-labelledby="forgotPasswordModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header custom-header text-white">
                    <h5 class="modal-title" id="forgotPasswordModalLabel">Recuperar Contraseña</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p class="custom-text">Ingrese su DNI y correo electrónico registrado para recibir instrucciones de recuperación de contraseña.</p>
                    <form id="forgotPasswordForm">
                        <div class="mb-3">
                            <label for="recoveryDni" class="form-label custom-text">DNI</label>
                            <input type="text" class="form-control" id="recoveryDni" required>
                        </div>
                        <div class="mb-3">
                            <label for="recoveryEmail" class="form-label custom-text">Correo Electrónico</label>
                            <input type="email" class="form-control" id="recoveryEmail" required>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="button" class="btn btn-primary" id="sendRecoveryBtn">Enviar</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Mostrar/ocultar contraseña
        document.getElementById('togglePassword').addEventListener('click', function() {
            const passwordInput = document.getElementById('password');
            const icon = this.querySelector('i');

            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                icon.classList.remove('fa-eye');
                icon.classList.add('fa-eye-slash');
            } else {
                passwordInput.type = 'password';
                icon.classList.remove('fa-eye-slash');
                icon.classList.add('fa-eye');
            }
        });

        // Ocultar los mensajes de error cuando el usuario empieza a escribir nuevamente
        const dniInput = document.getElementById('dni');
        const passwordInput = document.getElementById('password');
        const errorMessage = document.getElementById('error-message');
        const dniErrorIcon = document.getElementById('dni-error-icon');
        const passwordErrorIcon = document.getElementById('password-error-icon');
        const dniErrorSmall = document.getElementById('dni-error');
        const passwordErrorSmall = document.getElementById('password-error');

        dniInput.addEventListener('input', function() {
            dniInput.classList.remove('input-error');
            dniErrorIcon.classList.add('hidden');
            dniErrorSmall.classList.add('hidden');
            errorMessage.classList.add('hidden');
        });

        passwordInput.addEventListener('input', function() {
            passwordInput.classList.remove('input-error');
            passwordErrorIcon.classList.add('hidden');
            passwordErrorSmall.classList.add('hidden');
            errorMessage.classList.add('hidden');
        });

        // Mostrar error si el atributo "error" existe en la petición
        window.onload = function() {
            if ("<%= request.getAttribute("error") %>" !== "null") {
                document.getElementById('dni').classList.add('input-error');
                document.getElementById('password').classList.add('input-error');
                document.getElementById('dni-error-icon').classList.remove('hidden');
                document.getElementById('password-error-icon').classList.remove('hidden');
                document.getElementById('dni-error').classList.remove('hidden');
                document.getElementById('password-error').classList.remove('hidden');
                document.getElementById('error-message').classList.remove('hidden');
            }
        };

        // Enviar solicitud de recuperación de contraseña (simulación)
        document.getElementById('sendRecoveryBtn').addEventListener('click', function() {
            const form = document.getElementById('forgotPasswordForm');

            if (form.checkValidity()) {
                alert('Se ha enviado un correo con instrucciones para recuperar su contraseña.');

                // Cerrar modal
                const modal = bootstrap.Modal.getInstance(document.getElementById('forgotPasswordModal'));
                modal.hide();
            } else {
                form.reportValidity();
            }
        });
    </script>
</body>
</html>