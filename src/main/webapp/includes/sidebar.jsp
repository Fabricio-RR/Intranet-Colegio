<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
                <a class="nav-link" href="${pageContext.request.contextPath}/ayuda">
                    <i class="bi bi-question-circle"></i> <span>Ayuda</span>
                </a>
            </li>
        </ul>
    </div>
</aside>