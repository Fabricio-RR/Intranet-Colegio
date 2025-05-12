<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Colegio Peruano Chino Diez de Octubre</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="assets/css/dashboard.css">
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            
            
            <!-- Main content -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">Dashboard</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        
                    </div>
                </div>
                
                <!-- Widgets de resumen -->
                <div class="row mb-4">
                    <div class="col-md-3 mb-4">
                        <div class="dashboard-widget">
                            <div class="dashboard-widget-icon">
                                <i class="bi bi-calendar-check"></i>
                            </div>
                            <div class="dashboard-widget-title">Asistencia</div>
                            <div class="dashboard-widget-value">95%</div>
                            <div class="dashboard-widget-footer">
                                <span class="text-success"><i class="bi bi-arrow-up"></i> 2%</span> desde el mes pasado
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 mb-4">
                        <div class="dashboard-widget">
                            <div class="dashboard-widget-icon">
                                <i class="bi bi-journal-check"></i>
                            </div>
                            <div class="dashboard-widget-title">Promedio de Notas</div>
                            <div class="dashboard-widget-value">14.5</div>
                            <div class="dashboard-widget-footer">
                                <span class="text-success"><i class="bi bi-arrow-up"></i> 0.5</span> desde el último periodo
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-3 mb-4">
                        <div class="dashboard-widget">
                            <div class="dashboard-widget-icon">
                                <i class="bi bi-bell"></i>
                            </div>
                            <div class="dashboard-widget-title">Comunicados</div>
                            <div class="dashboard-widget-value">5</div>
                            <div class="dashboard-widget-footer">
                                <span class="text-success"><i class="bi bi-arrow-up"></i> 2</span> nuevos esta semana
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Calendario y Eventos 
                <div class="row mb-4">
                    <div class="col-md-8">
                        <div class="card border-0 shadow-sm">
                            <div class="card-header">
                                <h5 class="mb-0">Calendario Académico</h5>
                            </div>
                            <div class="card-body">
                                <div id="calendar" style="height: 400px;"></div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card border-0 shadow-sm">
                            <div class="card-header">
                                <h5 class="mb-0">Próximos Eventos</h5>
                            </div>
                            <div class="card-body">
                                <div class="timeline">
                                    <div class="timeline-item">
                                        <div class="timeline-date">15 de Mayo, 2023</div>
                                        <div class="timeline-title">Examen de Matemáticas</div>
                                        <div class="timeline-content">Evaluación del segundo bimestre sobre álgebra y geometría.</div>
                                    </div>
                                    <div class="timeline-item">
                                        <div class="timeline-date">18 de Mayo, 2023</div>
                                        <div class="timeline-title">Día del Logro</div>
                                        <div class="timeline-content">Presentación de proyectos y trabajos realizados durante el bimestre.</div>
                                    </div>
                                    <div class="timeline-item">
                                        <div class="timeline-date">22 de Mayo, 2023</div>
                                        <div class="timeline-title">Reunión de Padres</div>
                                        <div class="timeline-content">Entrega de libretas y reunión con tutores.</div>
                                    </div>
                                    <div class="timeline-item">
                                        <div class="timeline-date">30 de Mayo, 2023</div>
                                        <div class="timeline-title">Feriado - Día de la Educación</div>
                                        <div class="timeline-content">No habrá clases.</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>-->
                
                <!-- Comunicados Recientes -->
                <div class="row mb-4">
                    <div class="col-12">
                        <div class="card border-0 shadow-sm">
                            <div class="card-header">
                                <h5 class="mb-0">Comunicados Recientes</h5>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-hover">
                                        <thead>
                                            <tr>
                                                <th>Fecha</th>
                                                <th>Título</th>
                                                <th>Emisor</th>
                                                <th>Alcance</th>
                                                <th>Acciones</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>10/05/2023</td>
                                                <td>Cronograma de Exámenes del Segundo Bimestre</td>
                                                <td>Dirección Académica</td>
                                                <td><span class="badge bg-primary">General</span></td>
                                                <td>
                                                    <button class="btn btn-sm btn-outline-primary">
                                                        <i class="bi bi-eye"></i> Ver
                                                    </button>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>08/05/2023</td>
                                                <td>Taller de Reforzamiento de Matemáticas</td>
                                                <td>Prof. Juan Pérez</td>
                                                <td><span class="badge bg-info">Secundaria</span></td>
                                                <td>
                                                    <button class="btn btn-sm btn-outline-primary">
                                                        <i class="bi bi-eye"></i> Ver
                                                    </button>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>05/05/2023</td>
                                                <td>Campaña de Vacunación Escolar</td>
                                                <td>Departamento de Salud</td>
                                                <td><span class="badge bg-primary">General</span></td>
                                                <td>
                                                    <button class="btn btn-sm btn-outline-primary">
                                                        <i class="bi bi-eye"></i> Ver
                                                    </button>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>03/05/2023</td>
                                                <td>Actividades por el Día de la Madre</td>
                                                <td>Coordinación de Actividades</td>
                                                <td><span class="badge bg-primary">General</span></td>
                                                <td>
                                                    <button class="btn btn-sm btn-outline-primary">
                                                        <i class="bi bi-eye"></i> Ver
                                                    </button>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>01/05/2023</td>
                                                <td>Suspensión de Clases - Día del Trabajo</td>
                                                <td>Dirección</td>
                                                <td><span class="badge bg-primary">General</span></td>
                                                <td>
                                                    <button class="btn btn-sm btn-outline-primary">
                                                        <i class="bi bi-eye"></i> Ver
                                                    </button>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <div class="card-footer text-end">
                                <a href="#" class="btn btn-sm btn-primary">Ver todos los comunicados</a>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Estadísticas y Gráficos -->
                <div class="row mb-4">
                    <div class="col-md-6">
                        <div class="card border-0 shadow-sm">
                            <div class="card-header">
                                <h5 class="mb-0">Rendimiento Académico</h5>
                            </div>
                            <div class="card-body">
                                <canvas id="rendimientoChart" height="250"></canvas>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="card border-0 shadow-sm">
                            <div class="card-header">
                                <h5 class="mb-0">Asistencia Mensual</h5>
                            </div>
                            <div class="card-body">
                                <canvas id="asistenciaChart" height="250"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js"></script>
    
    <script>
        // Inicializar FullCalendar
        document.addEventListener('DOMContentLoaded', function() {
            var calendarEl = document.getElementById('calendar');
            var calendar = new FullCalendar.Calendar(calendarEl, {
                initialView: 'dayGridMonth',
                headerToolbar: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'dayGridMonth,timeGridWeek,listWeek'
                },
                locale: 'es',
                events: [
                    {
                        title: 'Examen de Matemáticas',
                        start: '2023-05-15',
                        color: '#dc3545'
                    },
                    {
                        title: 'Día del Logro',
                        start: '2023-05-18',
                        color: '#0A0A3D'
                    },
                    {
                        title: 'Reunión de Padres',
                        start: '2023-05-22',
                        color: '#28a745'
                    },
                    {
                        title: 'Feriado - Día de la Educación',
                        start: '2023-05-30',
                        color: '#ffc107'
                    }
                ]
            });
            calendar.render();
        });
        
        // Gráfico de Rendimiento Académico
        var ctxRendimiento = document.getElementById('rendimientoChart').getContext('2d');
        var rendimientoChart = new Chart(ctxRendimiento, {
            type: 'bar',
            data: {
                labels: ['Matemáticas', 'Comunicación', 'Ciencias', 'Historia', 'Inglés', 'Arte'],
                datasets: [{
                    label: 'Primer Bimestre',
                    data: [14, 16, 13, 15, 17, 18],
                    backgroundColor: 'rgba(10, 10, 61, 0.7)',
                    borderColor: 'rgba(10, 10, 61, 1)',
                    borderWidth: 1
                }, {
                    label: 'Segundo Bimestre',
                    data: [15, 15, 14, 16, 18, 17],
                    backgroundColor: 'rgba(220, 53, 69, 0.7)',
                    borderColor: 'rgba(220, 53, 69, 1)',
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true,
                        max: 20
                    }
                },
                plugins: {
                    legend: {
                        position: 'top',
                    },
                    title: {
                        display: true,
                        text: 'Comparativa de Notas por Curso'
                    }
                }
            }
        });
        
        // Gráfico de Asistencia Mensual
        var ctxAsistencia = document.getElementById('asistenciaChart').getContext('2d');
        var asistenciaChart = new Chart(ctxAsistencia, {
            type: 'line',
            data: {
                labels: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo'],
                datasets: [{
                    label: 'Porcentaje de Asistencia',
                    data: [92, 94, 91, 93, 95],
                    backgroundColor: 'rgba(10, 10, 61, 0.1)',
                    borderColor: 'rgba(10, 10, 61, 1)',
                    borderWidth: 2,
                    fill: true,
                    tension: 0.3
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: false,
                        min: 80,
                        max: 100
                    }
                },
                plugins: {
                    legend: {
                        position: 'top',
                    },
                    title: {
                        display: true,
                        text: 'Porcentaje de Asistencia Mensual'
                    }
                }
            }
        });
    </script>
</body>
</html>
