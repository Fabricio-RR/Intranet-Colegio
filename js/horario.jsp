<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Horario de Clases - Colegio Peruano Chino Diez de Octubre</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="assets/css/dashboard.css">
    <style>
        .custom-header {
            background-color: #0A0A3D;
            color: white;
        }
        .horario-table th {
            background-color: #0A0A3D;
            color: white;
            text-align: center;
            vertical-align: middle;
        }
        .horario-table td {
            height: 80px;
            vertical-align: middle;
        }
        .horario-cell {
            background-color: #f8f9fa;
            border-radius: 5px;
            padding: 8px;
            height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        .horario-curso {
            font-weight: bold;
            color: #0A0A3D;
        }
        .horario-profesor {
            font-size: 0.85em;
            color: #6c757d;
        }
        .horario-aula {
            font-size: 0.8em;
            color: #495057;
        }
        @media (max-width: 768px) {
            .horario-table {
                font-size: 0.8rem;
            }
            .horario-cell {
                padding: 4px;
            }
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
                    <h1 class="h2">Horario de Clases</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <div class="btn-group me-2">
                            <button type="button" class="btn btn-sm btn-outline-secondary" onclick="window.print()">
                                <i class="bi bi-printer"></i> Imprimir
                            </button>
                            <button type="button" class="btn btn-sm btn-outline-secondary" id="btnExportar">
                                <i class="bi bi-download"></i> Exportar
                            </button>
                        </div>
                        <form class="d-inline-flex" action="horario" method="get">
                            <c:if test="${param.idAlumno != null}">
                                <input type="hidden" name="idAlumno" value="${param.idAlumno}">
                            </c:if>
                            <c:if test="${param.idGrado != null}">
                                <input type="hidden" name="idGrado" value="${param.idGrado}">
                            </c:if>
                            <select class="form-select form-select-sm" name="anioEscolar" onchange="this.form.submit()">
                                <c:forEach var="anio" begin="${anioEscolar - 2}" end="${anioEscolar + 1}">
                                    <option value="${anio}" ${anio == anioEscolar ? 'selected' : ''}>${anio}</option>
                                </c:forEach>
                            </select>
                        </form>
                    </div>
                </div>
                
                <!-- Contenido del horario -->
                <div class="card border-0 shadow-sm mb-4">
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-bordered horario-table">
                                <thead>
                                    <tr>
                                        <th width="10%">Hora</th>
                                        <th width="18%">Lunes</th>
                                        <th width="18%">Martes</th>
                                        <th width="18%">Miércoles</th>
                                        <th width="18%">Jueves</th>
                                        <th width="18%">Viernes</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <!-- Horarios de 7:30 a 15:30 -->
                                    <c:forEach var="hora" begin="7" end="15">
                                        <c:forEach var="minuto" begin="0" end="30" step="30">
                                            <c:set var="horaFormateada" value="${hora < 10 ? '0' : ''}${hora}:${minuto == 0 ? '00' : '30'}" />
                                            <tr>
                                                <td class="text-center">${horaFormateada}</td>
                                                <c:forEach var="dia" begin="1" end="5">
                                                    <td>
                                                        <c:set var="horarioEncontrado" value="false" />
                                                        <c:forEach var="horario" items="${horarios}">
                                                            <c:if test="${horario.diaSemana.value == dia && horario.horaInicio.toString() == horaFormateada}">
                                                                <c:set var="horarioEncontrado" value="true" />
                                                                <div class="horario-cell">
                                                                    <div class="horario-curso">${horario.nombreCurso}</div>
                                                                    <div class="horario-profesor">${horario.nombreProfesor}</div>
                                                                    <div class="horario-aula">Aula: ${horario.aula}</div>
                                                                </div>
                                                            </c:if>
                                                        </c:forEach>
                                                        <c:if test="${!horarioEncontrado}">
                                                            <!-- Celda vacía -->
                                                        </c:if>
                                                    </td>
                                                </c:forEach>
                                            </tr>
                                        </c:forEach>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Función para exportar el horario a CSV
        document.getElementById('btnExportar').addEventListener('click', function() {
            let csv = 'Hora,Lunes,Martes,Miércoles,Jueves,Viernes\n';
            
            const tabla = document.querySelector('.horario-table');
            const filas = tabla.querySelectorAll('tbody tr');
            
            filas.forEach(fila => {
                const celdas = fila.querySelectorAll('td');
                let linea = '';
                
                celdas.forEach((celda, index) => {
                    let texto = '';
                    if (index === 0) {
                        texto = celda.textContent.trim();
                    } else {
                        const curso = celda.querySelector('.horario-curso');
                        const profesor = celda.querySelector('.horario-profesor');
                        const aula = celda.querySelector('.horario-aula');
                        
                        if (curso && profesor && aula) {
                            texto = `${curso.textContent.trim()} - ${profesor.textContent.trim()} - ${aula.textContent.trim()}`;
                        }
                    }
                    
                    // Escapar comillas y añadir comillas alrededor del texto
                    texto = '"' + texto.replace(/"/g, '""') + '"';
                    linea += texto + ',';
                });
                
                csv += linea.slice(0, -1) + '\n';
            });
            
            // Crear un enlace para descargar el archivo CSV
            const blob = new Blob([csv], { type: 'text/csv;charset=utf-8;' });
            const url = URL.createObjectURL(blob);
            const link = document.createElement('a');
            link.setAttribute('href', url);
            link.setAttribute('download', 'horario_clases.csv');
            link.style.visibility = 'hidden';
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
        });
    </script>
</body>
</html>
