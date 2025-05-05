<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Intranet Escolar - Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="assets/css/dashboard.css">
</head>
<body>
    <header class="navbar navbar-dark sticky-top bg-dark flex-md-nowrap p-0 shadow">
        <a class="navbar-brand col-md-3 col-lg-2 me-0 px-3" href="#">Intranet Escolar</a>
        <button class="navbar-toggler position-absolute d-md-none collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#sidebarMenu" aria-controls="sidebarMenu" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <input class="form-control form-control-dark w-100" type="text" placeholder="Buscar" aria-label="Buscar">
        <div class="navbar-nav">
            <div class="nav-item text-nowrap">
                <a class="nav-link px-3" href="logout">Cerrar Sesión</a>
            </div>
        </div>
    </header>
    
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <nav id="sidebarMenu" class="col-md-3 col-lg-2 d-md-block bg-dark sidebar collapse">
                <div class="position-sticky pt-3">
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link active" href="dashboard">
                                <i class="bi bi-house-door me-2"></i>
                                Dashboard
                            </a>
                        </li>
                        
                        <c:if test="${tieneRolDocente}">
                            <li class="nav-item">
                                <a class="nav-link" href="mis-cursos">
                                    <i class="bi bi-book me-2"></i>
                                    Mis Cursos
                                </a>
                            </li>
                        </c:if>
                        
                        <c:if test="${tieneRolEstudiante}">
                            <li class="nav-item">
                                <a class="nav-link" href="mis-cursos">
                                    <i class="bi bi-book me-2"></i>
                                    Mis Cursos
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="tareas">
                                    <i class="bi bi-clipboard-check me-2"></i>
                                    Tareas
                                </a>
                            </li>
                        </c:if>
                        
                        <c:if test="${tieneRolApoderado}">
                            <li class="nav-item">
                                <a class="nav-link" href="mis-hijos">
                                    <i class="bi bi-people me-2"></i>
                                    Mis Hijos
                                </a>
                            </li>
                        </c:if>
                        
                        <li class="nav-item">
                            <a class="nav-link" href="comunicados">
                                <i class="bi bi-megaphone me-2"></i>
                                Comunicados
                            </a>
                        </li>
                        
                        <c:if test="${tieneRolAdministrativo}">
                            <li class="nav-item">
                                <a class="nav-link" href="usuarios">
                                    <i class="bi bi-person-badge me-2"></i>
                                    Usuarios
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="reportes">
                                    <i class="bi bi-file-earmark-bar-graph me-2"></i>
                                    Reportes
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="configuracion">
                                    <i class="bi bi-gear me-2"></i>
                                    Configuración
                                </a>
                            </li>
                        </c:if>
                    </ul>
                    
                    <h6 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1 text-muted">
                        <span>Accesos Rápidos</span>
                    </h6>
                    <ul class="nav flex-column mb-2">
                        <li class="nav-item">
                            <a class="nav-link" href="horarios">
                                <i class="bi bi-calendar3 me-2"></i>
                                Horarios
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="perfil">
                                <i class="bi bi-person-circle me-2"></i>
                                Mi Perfil
                            </a>
                        </li>
                    </ul>
                </div>
            </nav>
            
            <!-- Main content -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">Dashboard</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <div class="btn-group me-2">
                            <button type="button" class="btn btn-sm btn-outline-secondary">Compartir</button>
                            <button type="button" class="btn btn-sm btn-outline-secondary">Exportar</button>
                        </div>
                        <button type="button" class="btn btn-sm btn-outline-secondary dropdown-toggle">
                            <i class="bi bi-calendar3"></i>
                            Esta semana
                        </button>
                    </div>
                </div>
                
                <!-- Bienvenida -->
                <div class="alert alert-info" role="alert">
                    <h4 class="alert-heading">¡Bienvenido, ${usuario.nombreCompleto}!</h4>
                    <p>Estás accediendo como: 
                        <c:forEach items="${usuario.roles}" var="rol" varStatus="status">
                            <span class="badge bg-primary">${rol.nombre}</span>
                            <c:if test="${!status.last}">, </c:if>
                        </c:forEach>
                    </p>
                    <hr>
                    <p class="mb-0">Última conexión: ${ultimaConexion}</p>
                </div>
                
                <!-- Tarjetas de resumen -->
                <div class="row row-cols-1 row-cols-md-3 g-4 mb-4">
                    <c:if test="${tieneRolDocente || tieneRolEstudiante}">
                        <div class="col">
                            <div class="card h-100">
                                <div class="card-body">
                                    <h5 class="card-title"><i class="bi bi-book text-primary me-2"></i>Cursos</h5>
                                    <p class="card-text display-4">${totalCursos}</p>
                                </div>
                                <div class="card-footer">
                                    <a href="mis-cursos" class="btn btn-sm btn-outline-primary">Ver cursos</a>
                                </div>
                            </div>
                        </div>
                    </c:if>
                    
                    <c:if test="${tieneRolEstudiante}">
                        <div class="col">
                            <div class="card h-100">
                                <div class="card-body">
                                    <h5 class="card-title"><i class="bi bi-clipboard-check text-warning me-2"></i>Tareas Pendientes</h5>
                                    <p class="card-text display-4">${tareasPendientes}</p>
                                </div>
                                <div class="card-footer">
                                    <a href="tareas" class="btn btn-sm btn-outline-warning">Ver tareas</a>
                                </div>
                            </div>
                        </div>
                    </c:if>
                    
                    <c:if test="${tieneRolDocente}">
                        <div class="col">
                            <div class="card h-100">
                                <div class="card-body">
                                    <h5 class="card-title"><i class="bi bi-clipboard-check text-warning me-2"></i>Tareas por Calificar</h5>
                                    <p class="card-text display-4">${tareasPorCalificar}</p>
                                </div>
                                <div class="card-footer">
                                    <a href="tareas-por-calificar" class="btn btn-sm btn-outline-warning">Ver tareas</a>
                                </div>
                            </div>
                        </div>
                    </c:if>
                    
                    <c:if test="${tieneRolApoderado}">
                        <div class="col">
                            <div class="card h-100">
                                <div class="card-body">
                                    <h5 class="card-title"><i class="bi bi-people text-success me-2"></i>Mis Hijos</h5>
                                    <p class="card-text display-4">${totalHijos}</p>
                                </div>
                                <div class="card-footer">
                                    <a href="mis-hijos" class="btn btn-sm btn-outline-success">Ver hijos</a>
                                </div>
                            </div>
                        </div>
                    </c:if>
                    
                    <div class="col">
                        <div class="card h-100">
                            <div class="card-body">
                                <h5 class="card-title"><i class="bi bi-megaphone text-danger me-2"></i>Comunicados</h5>
                                <p class="card-text display-4">${totalComunicados}</p>
                            </div>
                            <div class="card-footer">
                                <a href="comunicados" class="btn btn-sm btn-outline-danger">Ver comunicados</a>
                            </div>
                        </div>
                    </div>
                    
                    <c:if test="${tieneRolAdministrativo}">
                        <div class="col">
                            <div class="card h-100">
                                <div class="card-body">
                                    <h5 class="card-title"><i class="bi bi-person-badge text-info me-2"></i>Usuarios</h5>
                                    <p class="card-text display-4">${totalUsuarios}</p>
                                </div>
                                <div class="card-footer">
                                    <a href="usuarios" class="btn btn-sm btn-outline-info">Gestionar usuarios</a>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </div>
                
                <!-- Comunicados recientes -->
                <div class="card mb-4">
                    <div class="card-header">
                        <h5 class="mb-0"><i class="bi bi-megaphone me-2"></i>Comunicados Recientes</h5>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${not empty comunicados}">
                                <div class="list-group">
                                    <c:forEach items="${comunicados}" var="comunicado">
                                        <a href="comunicado?id=${comunicado.idComunicado}" class="list-group-item list-group-item-action">
                                            <div class="d-flex w-100 justify-content-between">
                                                <h5 class="mb-1">${comunicado.titulo}</h5>
                                                <small>${comunicado.fechaPublicacion}</small>
                                            </div>
                                            <p class="mb-1">${comunicado.contenido}</p>
                                            <small>Publicado por: ${comunicado.emisor}</small>
                                        </a>
                                    </c:forEach>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <p class="text-muted">No hay comunicados recientes.</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="card-footer text-end">
                        <a href="comunicados" class="btn btn-sm btn-outline-primary">Ver todos los comunicados</a>
                    </div>
                </div>
                
                <!-- Horario del día -->
                <div class="card mb-4">
                    <div class="card-header">
                        <h5 class="mb-0"><i class="bi bi-calendar3 me-2"></i>Horario de Hoy</h5>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${not empty horarioHoy}">
                                <div class="table-responsive">
                                    <table class="table table-hover">
                                        <thead>
                                            <tr>
                                                <th>Hora</th>
                                                <th>Curso</th>
                                                <th>Aula</th>
                                                <c:if test="${tieneRolDocente}">
                                                    <th>Sección</th>
                                                </c:if>
                                                <c:if test="${tieneRolEstudiante}">
                                                    <th>Docente</th>
                                                </c:if>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${horarioHoy}" var="horario">
                                                <tr>
                                                    <td>${horario.horaInicio} - ${horario.horaFin}</td>
                                                    <td>${horario.curso}</td>
                                                    <td>${horario.aula}</td>
                                                    <c:if test="${tieneRolDocente}">
                                                        <td>${horario.seccion}</td>
                                                    </c:if>
                                                    <c:if test="${tieneRolEstudiante}">
                                                        <td>${horario.docente}</td>
                                                    </c:if>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <p class="text-muted">No hay clases programadas para hoy.</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="card-footer text-end">
                        <a href="horarios" class="btn btn-sm btn-outline-primary">Ver horario completo</a>
                    </div>
                </div>
            </main>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</body>
</html>