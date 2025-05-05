<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mis Hijos - Colegio Peruano Chino Diez de Octubre</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="assets/css/dashboard.css">
    <style>
        .custom-header {
            background-color: #0A0A3D;
            color: white;
        }
        .hijo-card {
            transition: transform 0.3s;
            border-left: 4px solid #0A0A3D;
        }
        .hijo-card:hover {
            transform: translateY(-5px);
        }
        .hijo-avatar {
            width: 80px;
            height: 80px;
            background-color: #0A0A3D;
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            font-weight: bold;
        }
        .hijo-nombre {
            color: #0A0A3D;
            font-weight: bold;
        }
        .hijo-grado {
            color: #6c757d;
        }
        .comunicado-card {
            border-left: 4px solid #0A0A3D;
        }
        .comunicado-fecha {
            font-size: 0.85rem;
            color: #6c757d;
        }
        .comunicado-titulo {
            color: #0A0A3D;
            font-weight: bold;
        }
        .comunicado-emisor {
            font-size: 0.85rem;
            color: #495057;
        }
        .comunicado-alcance {
            font-size: 0.8rem;
            background-color: #e9ecef;
            padding: 2px 8px;
            border-radius: 10px;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <jsp:include page="sidebar.jsp" />
            
            <!-- Main content -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">Mis Hijos</h1>
                </div>
                
                <!-- Tarjetas de hijos -->
                <div class="row mb-4">
                    <c:forEach var="hijo" items="${hijos}">
                        <div class="col-md-6 col-lg-4 mb-4">
                            <div class="card border-0 shadow-sm hijo-card">
                                <div class="card-body">
                                    <div class="d-flex align-items-center mb-3">
                                        <div class="hijo-avatar me-3">
                                            ${hijo.nombres.charAt(0)}${hijo.apellidos.charAt(0)}
                                        </div>
                                        <div>
                                            <h5 class="hijo-nombre mb-1">${hijo.nombres} ${hijo.apellidos}</h5>
                                            <p class="hijo-grado mb-0">${hijo.grado} - ${hijo.curso}</p>
                                        </div>
                                    </div>
                                    <div class="d-flex justify-content-between">
                                        <a href="notas?idAlumno=${hijo.idUsuario}" class="btn btn-sm btn-outline-primary">
                                            <i class="bi bi-journal-check"></i> Notas
                                        </a>
                                        <a href="horario?idAlumno=${hijo.idUsuario}" class="btn btn-sm btn-outline-secondary">
                                            <i class="bi bi-calendar3"></i> Horario
                                        </a>
                                        <a href="examenes?idAlumno=${hijo.idUsuario}" class="btn btn-sm btn-outline-danger">
                                            <i class="bi bi-file-earmark-text"></i> Exámenes
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                
                <!-- Comunicados recientes -->
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h2 class="h4">Comunicados Recientes</h2>
                </div>
                
                <div class="row">
                    <c:choose>
                        <c:when test="${empty comunicados}">
                            <div class="col-12">
                                <div class="alert alert-info" role="alert">
                                    No hay comunicados recientes para mostrar.
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="comunicado" items="${comunicados}">
                                <div class="col-md-6 mb-4">
                                    <div class="card border-0 shadow-sm comunicado-card">
                                        <div class="card-body">
                                            <div class="d-flex justify-content-between align-items-center mb-2">
                                                <span class="comunicado-fecha">
                                                    <i class="bi bi-calendar3"></i> 
                                                    <fmt:formatDate value="${comunicado.fechaEmision}" pattern="dd/MM/yyyy HH:mm" />
                                                </span>
                                                <span class="comunicado-alcance">
                                                    ${comunicado.alcance}
                                                </span>
                                            </div>
                                            <h5 class="comunicado-titulo">${comunicado.titulo}</h5>
                                            <p class="card-text">
                                                ${comunicado.contenido.length() > 150 ? comunicado.contenido.substring(0, 150).concat('...') : comunicado.contenido}
                                            </p>
                                            <div class="d-flex justify-content-between align-items-center">
                                                <span class="comunicado-emisor">
                                                    <i class="bi bi-person"></i> ${comunicado.nombreEmisor}
                                                </span>
                                                <a href="#" class="btn btn-sm btn-link" data-bs-toggle="modal" data-bs-target="#comunicadoModal${comunicado.idComunicado}">
                                                    Leer más
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- Modal para ver comunicado completo -->
                                    <div class="modal fade" id="comunicadoModal${comunicado.idComunicado}" tabindex="-1" aria-labelledby="comunicadoModalLabel${comunicado.idComunicado}" aria-hidden="true">
                                        <div class="modal-dialog modal-lg">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="comunicadoModalLabel${comunicado.idComunicado}">${comunicado.titulo}</h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                                        <span class="comunicado-fecha">
                                                            <i class="bi bi-calendar3"></i> 
                                                            <fmt:formatDate value="${comunicado.fechaEmision}" pattern="dd/MM/yyyy HH:mm" />
                                                        </span>
                                                        <span class="comunicado-alcance">
                                                            ${comunicado.alcance}
                                                        </span>
                                                    </div>
                                                    <p>${comunicado.contenido}</p>
                                                    <hr>
                                                    <p class="comunicado-emisor mb-0">
                                                        <i class="bi bi-person"></i> ${comunicado.nombreEmisor}
                                                    </p>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
            </main>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
