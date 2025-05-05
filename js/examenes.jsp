<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Exámenes - Colegio Peruano Chino Diez de Octubre</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="assets/css/dashboard.css">
    <style>
        .custom-header {
            background-color: #0A0A3D;
            color: white;
        }
        .examen-card {
            transition: transform 0.3s;
            border-left: 4px solid #0A0A3D;
        }
        .examen-card:hover {
            transform: translateY(-5px);
        }
        .examen-fecha {
            background-color: #0A0A3D;
            color: white;
            border-radius: 4px;
            padding: 8px;
            text-align: center;
        }
        .examen-dia {
            font-size: 1.5rem;
            font-weight: bold;
        }
        .examen-mes {
            font-size: 0.9rem;
            text-transform: uppercase;
        }
        .examen-titulo {
            color: #0A0A3D;
            font-weight: bold;
        }
        .examen-curso {
            color: #6c757d;
        }
        .examen-profesor {
            font-size: 0.85rem;
        }
        .examen-hora {
            font-size: 0.9rem;
            color: #495057;
        }
        .examen-aula {
            font-size: 0.9rem;
            color: #495057;
        }
        .sin-examenes {
            padding: 40px;
            text-align: center;
            color: #6c757d;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar (mismo que en dashboard.jsp) -->
            <nav id="sidebar" class="col-md-3 col-lg-2 d-md-block bg-dark sidebar collapse">
                <!-- Contenido del sidebar -->
                <jsp:include page="sidebar.jsp" />
            </nav>
            
            <!-- Main content -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">Exámenes Programados</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <div class="btn-group me-2">
                            <button type="button" class="btn btn-sm btn-outline-secondary" onclick="window.print()">
                                <i class="bi bi-printer"></i> Imprimir
                            </button>
                        </div>
                    </div>
                </div>
                
                <!-- Contenido de exámenes -->
                <div class="row">
                    <c:choose>
                        <c:when test="${empty examenes}">
                            <div class="col-12">
                                <div class="card border-0 shadow-sm mb-4">
                                    <div class="card-body sin-examenes">
                                        <i class="bi bi-calendar-x" style="font-size: 3rem;"></i>
                                        <h4 class="mt-3">No hay exámenes programados</h4>
                                        <p>Actualmente no hay exámenes programados para mostrar.</p>
                                    </div>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="examen" items="${examenes}">
                                <div class="col-md-6 mb-4">
                                    <div class="card border-0 shadow-sm examen-card">
                                        <div class="card-body p-0">
                                            <div class="row g-0">
                                                <div class="col-3">
                                                    <div class="examen-fecha h-100 d-flex flex-column justify-content-center">
                                                        <fmt:formatDate value="${examen.fecha}" pattern="dd" var="dia" />
                                                        <fmt:formatDate value="${examen.fecha}" pattern="MMM" var="mes" />
                                                        <div class="examen-dia">${dia}</div>
                                                        <div class="examen-mes">${mes}</div>
                                                    </div>
                                                </div>
                                                <div class="col-9 p-3">
                                                    <h5 class="examen-titulo">${examen.titulo}</h5>
                                                    <p class="examen-curso mb-1">${examen.nombreCurso} - ${examen.nombreGrado}</p>
                                                    <p class="examen-profesor mb-1">Prof. ${examen.nombreProfesor}</p>
                                                    <div class="d-flex justify-content-between mt-2">
                                                        <span class="examen-hora">
                                                            <i class="bi bi-clock"></i> ${examen.horaInicio} (${examen.duracion} min)
                                                        </span>
                                                        <span class="examen-aula">
                                                            <i class="bi bi-geo-alt"></i> Aula ${examen.aula}
                                                        </span>
                                                    </div>
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
