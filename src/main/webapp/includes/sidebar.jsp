<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<nav id="sidebar" class="col-md-3 col-lg-2 d-md-block bg-dark sidebar collapse">
    <div class="position-sticky pt-3">
        <!-- Logo y nombre del colegio -->
        <div class="sidebar-logo">
            <img src="../assets/img/EscudoCDO.png" alt="Escudo CDO">
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
                <a class="nav-link ${pageContext.request.servletPath == '/dashboard.jsp' ? 'active' : ''}" href="dashboard">
                    <i class="bi bi-house-door"></i> Dashboard
                </a>
            </li>
            
            <!-- Menú para APODERADO -->
            <c:if test="${sessionScope.usuario.tieneRol('APODERADO')}">
                <li class="nav-item">
                    <a class="nav-link ${pageContext.request.servletPath == '/mis-hijos.jsp' ? 'active' : ''}" href="mis-hijos">
                        <i class="bi bi-people"></i> Mis Hijos
                    </a>
                </li>
            </c:if>
            
            <!-- Menú para ALUMNO -->
            <c:if test="${sessionScope.usuario.tieneRol('ALUMNO')}">
                <li class="nav-item">
                    <a class="nav-link ${pageContext.request.servletPath == '/notas.jsp' ? 'active' : ''}" href="notas">
                        <i class="bi bi-journal-check"></i> Mis Notas
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${pageContext.request.servletPath == '/horario.jsp' ? 'active' : ''}" href="horario">
                        <i class="bi bi-calendar3"></i> Horario
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${pageContext.request.servletPath == '/examenes.jsp' ? 'active' : ''}" href="examenes">
                        <i class="bi bi-file-earmark-text"></i> Exámenes
                    </a>
                </li>
            </c:if>
            
            <!-- Menú para PROFESOR -->
            <c:if test="${sessionScope.usuario.tieneRol('PROFESOR')}">
                <li class="nav-item">
                    <a class="nav-link ${pageContext.request.servletPath == '/mis-cursos.jsp' ? 'active' : ''}" href="mis-cursos">
                        <i class="bi bi-book"></i> Mis Cursos
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${pageContext.request.servletPath == '/asistencia.jsp' ? 'active' : ''}" href="asistencia">
                        <i class="bi bi-calendar-check"></i> Asistencia
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${pageContext.request.servletPath == '/calificaciones.jsp' ? 'active' : ''}" href="calificaciones">
                        <i class="bi bi-pencil-square"></i> Calificaciones
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${pageContext.request.servletPath == '/comunicados-profesor.jsp' ? 'active' : ''}" href="comunicados-profesor">
                        <i class="bi bi-megaphone"></i> Comunicados
                    </a>
                </li>
            </c:if>
            
            <!-- Menú para ADMINISTRADOR -->
            <c:if test="${sessionScope.usuario.tieneRol('ADMINISTRADOR')}">
                <li class="nav-item">
                    <a class="nav-link ${pageContext.request.servletPath == '/usuarios.jsp' ? 'active' : ''}" href="usuarios">
                        <i class="bi bi-person-gear"></i> Usuarios
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${pageContext.request.servletPath == '/cursos-admin.jsp' ? 'active' : ''}" href="cursos-admin">
                        <i class="bi bi-book"></i> Cursos
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${pageContext.request.servletPath == '/grados.jsp' ? 'active' : ''}" href="grados">
                        <i class="bi bi-mortarboard"></i> Grados
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${pageContext.request.servletPath == '/comunicados-admin.jsp' ? 'active' : ''}" href="comunicados-admin">
                        <i class="bi bi-megaphone"></i> Comunicados
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${pageContext.request.servletPath == '/configuracion.jsp' ? 'active' : ''}" href="configuracion">
                        <i class="bi bi-gear"></i> Configuración
                    </a>
                </li>
            </c:if>
            
            <!-- Menú común para todos los usuarios -->
            <li class="nav-item">
                <a class="nav-link" href="comunicados">
                    <i class="bi bi-bell"></i> Comunicados
                    <span class="badge bg-danger rounded-pill">5</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="perfil">
                    <i class="bi bi-person-circle"></i> Mi Perfil
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="logout">
                    <i class="bi bi-box-arrow-right"></i> Cerrar Sesión
                </a>
            </li>
        </ul>
        
        <!-- Separador -->
        <h6 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1 text-muted">
            <span>Enlaces Rápidos</span>
        </h6>
    </div>
</nav>
