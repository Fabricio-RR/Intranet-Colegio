<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="Sistema de Intranet Escolar - Colegio Peruano Chino Diez de Octubre">
    <meta name="theme-color" content="#0a0a3d">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
    
    <title>${param.pageTitle} - Colegio Peruano Chino Diez de Octubre</title>
    
    <!-- Favicon -->
    <link rel="icon" href="${pageContext.request.contextPath}/assets/img/favicon.ico" type="image/x-icon">
    <link rel="apple-touch-icon" href="${pageContext.request.contextPath}/assets/img/apple-touch-icon.png">
    
    <!-- Manifest para PWA -->
    <link rel="manifest" href="${pageContext.request.contextPath}/manifest.json">
    
    <!-- CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/dashboard.css">
    
    <!-- CSS específico de la página si existe -->
    <c:if test="${not empty param.pageCss}">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/${param.pageCss}.css">
    </c:if>
    
    <!-- Precargar fuentes críticas -->
    <link rel="preload" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/fonts/bootstrap-icons.woff2" as="font" type="font/woff2" crossorigin>
</head>
<body class="dark-mode-support">
    <div class="app-container">
        <!-- Sidebar -->
        <aside class="sidebar">
            <div class="sidebar-sticky">
                <!-- Logo -->
                <div class="sidebar-logo">
                    <img src="${pageContext.request.contextPath}/assets/img/EscudoCDO.png" alt="Escudo CDO">
                    <h5>Colegio Peruano Chino<br>Diez de Octubre</h5>
                </div>
                
                <!-- Perfil del usuario -->
                <div class="user-profile">
                    <div class="user-avatar">
                        ${sessionScope.usuario.nombres.charAt(0)}${sessionScope.usuario.apellidos.charAt(0)}
                    </div>
                    <div class="user-info">
                        <div class="user-name">${sessionScope.usuario.nombreCompleto()}</div>
                        <div class="user-role">
                            <c:forEach var="rol" items="${sessionScope.usuario.roles}" varStatus="status">
                                ${rol.nombre}${!status.last ? ', ' : ''}
                            </c:forEach>
                        </div>
                    </div>
                </div>
                
                <!-- Menú principal -->
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a class="nav-link ${pageContext.request.servletPath == '/dashboard.jsp' ? 'active' : ''}" href="${pageContext.request.contextPath}/dashboard">
                            <i class="bi bi-house-door"></i> <span>Dashboard</span>
                        </a>
                    </li>
                    
                    <!-- Menú para APODERADO -->
                    <c:if test="${sessionScope.usuario.tieneRol('APODERADO')}">
                        <li class="nav-item">
                            <a class="nav-link ${pageContext.request.servletPath == '/mis-hijos.jsp' ? 'active' : ''}" href="${pageContext.request.contextPath}/mis-hijos">
                                <i class="bi bi-people"></i> <span>Mis Hijos</span>
                            </a>
                        </li>
                    </c:if>
                    
                    <!-- Menú para ALUMNO -->
                    <c:if test="${sessionScope.usuario.tieneRol('ALUMNO')}">
                        <li class="nav-item">
                            <a class="nav-link ${pageContext.request.servletPath == '/notas.jsp' ? 'active' : ''}" href="${pageContext.request.contextPath}/notas">
                                <i class="bi bi-journal-check"></i> <span>Mis Notas</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link ${pageContext.request.servletPath == '/horario.jsp' ? 'active' : ''}" href="${pageContext.request.contextPath}/horario">
                                <i class="bi bi-calendar3"></i> <span>Horario</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link ${pageContext.request.servletPath == '/examenes.jsp' ? 'active' : ''}" href="${pageContext.request.contextPath}/examenes">
                                <i class="bi bi-file-earmark-text"></i> <span>Exámenes</span>
                            </a>
                        </li>
                    </c:if>
                    
                    <!-- Menú para PROFESOR -->
                    <c:if test="${sessionScope.usuario.tieneRol('PROFESOR')}">
                        <li class="nav-item">
                            <a class="nav-link ${pageContext.request.servletPath == '/calificaciones.jsp' ? 'active' : ''}" href="${pageContext.request.contextPath}/calificaciones">
                                <i class="bi bi-pencil-square"></i> <span>Calificaciones</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link ${pageContext.request.servletPath == '/comunicados-profesor.jsp' ? 'active' : ''}" href="${pageContext.request.contextPath}/comunicados-profesor">
                                <i class="bi bi-megaphone"></i> <span>Comunicados</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link ${pageContext.request.servletPath == '/reportes.jsp' ? 'active' : ''}" href="${pageContext.request.contextPath}/reportes">
                                <i class="bi bi-file-earmark-bar-graph"></i> <span>Reportes</span>
                            </a>
                        </li>
                    </c:if>
                    
                    <!-- Menú para ADMINISTRADOR -->
                    <c:if test="${sessionScope.usuario.tieneRol('ADMINISTRADOR')}">
                        <li class="nav-item">
                            <a class="nav-link ${pageContext.request.servletPath == '/comunicados-admin.jsp' ? 'active' : ''}" href="${pageContext.request.contextPath}/comunicados-admin">
                                <i class="bi bi-megaphone"></i> <span>Comunicados</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link ${pageContext.request.servletPath == '/reportes.jsp' ? 'active' : ''}" href="${pageContext.request.contextPath}/reportes">
                                <i class="bi bi-file-earmark-bar-graph"></i> <span>Reportes</span>
                            </a>
                        </li>
                    </c:if>
                    
                    <!-- Menú común para todos los usuarios -->
                    <li class="nav-item">
                        <a class="nav-link ${pageContext.request.servletPath == '/comunicados.jsp' ? 'active' : ''}" href="${pageContext.request.contextPath}/comunicados">
                            <i class="bi bi-bell"></i> <span>Comunicados</span>
                            <c:if test="${comunicadosNoLeidos > 0}">
                                <span class="badge bg-danger rounded-pill">${comunicadosNoLeidos}</span>
                            </c:if>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link ${pageContext.request.servletPath == '/perfil.jsp' ? 'active' : ''}" href="${pageContext.request.contextPath}/perfil">
                            <i class="bi bi-person-circle"></i> <span>Mi Perfil</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/logout">
                            <i class="bi bi-box-arrow-right"></i> <span>Cerrar Sesión</span>
                        </a>
                    </li>
                </ul>
                
                <!-- Separador -->
                <h6 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1 text-muted">
                    <span>Enlaces Rápidos</span>
                </h6>
                
                <!-- Enlaces rápidos -->
                <ul class="nav flex-column mb-2">
                    <li class="nav-item">
                        <a class="nav-link" href="https://www.minedu.gob.pe/" target="_blank" rel="noopener noreferrer">
                            <i class="bi bi-link-45deg"></i> <span>MINEDU</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/ayuda">
                            <i class="bi bi-question-circle"></i> <span>Ayuda</span>
                        </a>
                    </li>
                </ul>
            </div>
        </aside>
        
        <!-- Contenido principal -->
        <div class="main-content">
            <!-- Header -->
            <header class="main-header">
                <div class="d-flex align-items-center">
                    <button type="button" class="toggle-sidebar me-3" aria-label="Alternar menú">
                        <i class="bi bi-list"></i>
                    </button>
                    <h1 class="header-title">${param.pageTitle}</h1>
                </div>
                
                <div class="header-actions">
                    <!-- Notificaciones -->
                    <div class="dropdown">
                        <button class="btn btn-link position-relative" type="button" data-toggle="notifications" data-target="#notificationsDropdown" aria-label="Notificaciones">
                            <i class="bi bi-bell"></i>
                            <c:if test="${notificacionesNoLeidas > 0}">
                                <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                                    ${notificacionesNoLeidas}
                                    <span class="visually-hidden">notificaciones no leídas</span>
                                </span>
                            </c:if>
                        </button>
                        <div class="dropdown-menu dropdown-menu-end" id="notificationsDropdown">
                            <!-- Contenido cargado dinámicamente -->
                        </div>
                    </div>
                    
                    <!-- Modo oscuro -->
                    <div class="form-check form-switch ms-3 d-flex align-items-center">
                        <input class="form-check-input" type="checkbox" id="darkModeToggle" aria-label="Cambiar a modo oscuro">
                        <label class="form-check-label ms-2 d-none d-md-block" for="darkModeToggle">
                            <i class="bi bi-moon"></i>
                        </label>
                    </div>
                </div>
            </header>
            
            <!-- Contenido de la página -->
            <div class="page-content">
                <jsp:doBody/>
            </div>
            
            <!-- Footer -->
            <footer class="main-footer mt-auto py-3 text-center text-muted">
                <div class="container">
                    <p class="mb-0">&copy; ${java.time.Year.now().getValue()} Colegio Peruano Chino Diez de Octubre. Todos los derechos reservados.</p>
                </div>
            </footer>
        </div>
    </div>
    
    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/dashboard.js"></script>
    
    <!-- Script específico de la página si existe -->
    <c:if test="${not empty param.pageJs}">
        <script src="${pageContext.request.contextPath}/assets/js/${param.pageJs}.js"></script>
    </c:if>
    
    <!-- Service Worker para PWA -->
    <script>
        if ('serviceWorker' in navigator) {
            window.addEventListener('load', () => {
                navigator.serviceWorker.register('${pageContext.request.contextPath}/service-worker.js')
                    .then(registration => {
                        console.log('Service Worker registrado con éxito:', registration);
                    })
                    .catch(error => {
                        console.log('Error al registrar el Service Worker:', error);
                    });
            });
        }
    </script>
</body>
</html>