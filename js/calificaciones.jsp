<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro de Calificaciones - Colegio Peruano Chino Diez de Octubre</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="assets/css/dashboard.css">
    <style>
        .nota-input {
            width: 60px;
            text-align: center;
            font-weight: bold;
        }
        .nota-input:focus {
            border-color: #0A0A3D;
            box-shadow: 0 0 0 0.2rem rgba(10, 10, 61, 0.25);
        }
        .nota-aprobado {
            background-color: #d4edda;
            color: #155724;
        }
        .nota-regular {
            background-color: #fff3cd;
            color: #856404;
        }
        .nota-desaprobado {
            background-color: #f8d7da;
            color: #721c24;
        }
        .filter-section {
            background-color: #f8f9fa;
            border-radius: 0.5rem;
            padding: 1rem;
            margin-bottom: 1.5rem;
        }
        .alumno-row:hover {
            background-color: rgba(10, 10, 61, 0.05);
        }
        .tipo-evaluacion {
            font-weight: bold;
            color: #0A0A3D;
        }
        .observacion-input {
            font-size: 0.9rem;
        }
        .btn-save-all {
            position: fixed;
            bottom: 20px;
            right: 20px;
            z-index: 1000;
        }
        .promedio-cell {
            font-weight: bold;
            background-color: #f8f9fa;
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
                    <h1 class="h2">Registro de Calificaciones</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <div class="btn-group me-2">
                            <button type="button" class="btn btn-sm btn-outline-secondary" id="btnImportar">
                                <i class="bi bi-file-earmark-excel"></i> Importar
                            </button>
                            <button type="button" class="btn btn-sm btn-outline-secondary" id="btnExportar">
                                <i class="bi bi-download"></i> Exportar
                            </button>
                        </div>
                    </div>
                </div>
                
                <!-- Filtros de calificaciones -->
                <div class="filter-section">
                    <form id="filtroForm" class="row g-3">
                        <div class="col-md-3">
                            <label for="filtroCurso" class="form-label">Curso</label>
                            <select class="form-select" id="filtroCurso" name="idCurso" required>
                                <option value="">Seleccione un curso</option>
                                <option value="1">Matemáticas - 3° Secundaria</option>
                                <option value="2">Comunicación - 3° Secundaria</option>
                                <option value="3">Ciencias - 3° Secundaria</option>
                                <option value="4">Historia - 3° Secundaria</option>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <label for="filtroPeriodo" class="form-label">Periodo</label>
                            <select class="form-select" id="filtroPeriodo" name="idPeriodo" required>
                                <option value="">Seleccione un periodo</option>
                                <option value="1">Primer Bimestre</option>
                                <option value="2">Segundo Bimestre</option>
                                <option value="3">Tercer Bimestre</option>
                                <option value="4">Cuarto Bimestre</option>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <label for="filtroEvaluacion" class="form-label">Tipo de Evaluación</label>
                            <select class="form-select" id="filtroEvaluacion" name="tipoEvaluacion">
                                <option value="">Todas las evaluaciones</option>
                                <option value="Examen Parcial">Examen Parcial</option>
                                <option value="Examen Final">Examen Final</option>
                                <option value="Trabajo Práctico">Trabajo Práctico</option>
                                <option value="Participación">Participación</option>
                            </select>
                        </div>
                        <div class="col-md-3 d-flex align-items-end">
                            <button type="submit" class="btn btn-primary w-100">
                                <i class="bi bi-search"></i> Buscar
                            </button>
                        </div>
                    </form>
                </div>
                
                <!-- Tabla de calificaciones -->
                <div class="card border-0 shadow-sm mb-4">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h5 class="mb-0">Matemáticas - 3° Secundaria - Primer Bimestre</h5>
                        <button type="button" class="btn btn-sm btn-outline-primary" id="btnNuevaEvaluacion">
                            <i class="bi bi-plus-circle"></i> Nueva Evaluación
                        </button>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <form id="formCalificaciones">
                                <table class="table table-bordered">
                                    <thead>
                                        <tr>
                                            <th rowspan="2" style="vertical-align: middle;">N°</th>
                                            <th rowspan="2" style="vertical-align: middle;">Alumno</th>
                                            <th colspan="4" class="text-center">Examen Parcial (30%)</th>
                                            <th colspan="4" class="text-center">Trabajo Práctico (30%)</th>
                                            <th colspan="2" class="text-center">Participación (20%)</th>
                                            <th colspan="2" class="text-center">Examen Final (20%)</th>
                                            <th rowspan="2" style="vertical-align: middle;">Promedio</th>
                                        </tr>
                                        <tr>
                                            <th>EP1</th>
                                            <th>EP2</th>
                                            <th>EP3</th>
                                            <th>Prom</th>
                                            <th>TP1</th>
                                            <th>TP2</th>
                                            <th>TP3</th>
                                            <th>Prom</th>
                                            <th>P1</th>
                                            <th>Prom</th>
                                            <th>EF</th>
                                            <th>Prom</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <!-- Alumnos -->
                                        <tr class="alumno-row">
                                            <td>1</td>
                                            <td>Alarcón Mendoza, Carlos</td>
                                            <td><input type="number" min="0" max="20" step="0.1" class="form-control nota-input nota-aprobado" name="nota_1_EP1" value="16"></td>
                                            <td><input type="number" min="0" max="20" step="0.1" class="form-control nota-input nota-aprobado" name="nota_1_EP2" value="15"></td>
                                            <td><input type="number" min="0" max="20" step="0.1" class="form-control nota-input nota-aprobado" name="nota_1_EP3" value="17"></td>
                                            <td class="promedio-cell">16.0</td>
                                            <td><input type="number" min="0" max="20" step="0.1" class="form-control nota-input nota-aprobado" name="nota_1_TP1" value="18"></td>
                                            <td><input type="number" min="0" max="20" step="0.1" class="form-control nota-input nota-aprobado" name="nota_1_TP2" value="16"></td>
                                            <td><input type="number" min="0" max="20" step="0.1" class="form-control nota-input nota-aprobado" name="nota_1_TP3" value="17"></td>
                                            <td class="promedio-cell">17.0</td>
                                            <td><input type="number" min="0" max="20" step="0.1" class="form-control nota-input nota-aprobado" name="nota_1_P1" value="15"></td>
                                            <td class="promedio-cell">15.0</td>
                                            <td><input type="number" min="0" max="20" step="0.1" class="form-control nota-input nota-aprobado" name="nota_1_EF" value="16"></td>
                                            <td class="promedio-cell">16.0</td>
                                            <td class="promedio-cell nota-aprobado">16.2</td>
                                        </tr>
                                        <tr class="alumno-row">
                                            <td>2</td>
                                            <td>Benites Rojas, Ana María</td>
                                            <td><input type="number" min="0" max="20" step="0.1" class="form-control nota-input nota-regular" name="nota_2_EP1" value="13"></td>
                                            <td><input type="number" min="0" max="20" step="0.1" class="form-control nota-input nota-regular" name="nota_2_EP2" value="12"></td>
                                            <td><input type="number" min="0" max="20" step="0.1" class="form-control nota-input nota-regular" name="nota_2_EP3" value="11"></td>
                                            <td class="promedio-cell">12.0</td>
                                            <td><input type="number" min="0" max="20" step="0.1" class="form-control nota-input nota-aprobado" name="nota_2_TP1" value="14"></td>
                                            <td><input type="number" min="0" max="20" step="0.1" class="form-control nota-input nota-aprobado" name="nota_2_TP2" value="15"></td>
                                            <td><input type="number" min="0" max="20" step="0.1" class="form-control nota-input nota-regular" name="nota_2_TP3" value="13"></td>
                                            <td class="promedio-cell">14.0</td>
                                            <td><input type="number" min="0" max="20" step="0.1" class="form-control nota-input nota-regular" name="nota_2_P1" value="12"></td>
                                            <td class="promedio-cell">12.0</td>
                                            <td><input type="number" min="0" max="20" step="0.1" class="form-control nota-input nota-regular" name="nota_2_EF" value="13"></td>
                                            <td class="promedio-cell">13.0</td>
                                            <td class="promedio-cell nota-regular">12.8</td>
                                        </tr>
                                        <tr class="alumno-row">
                                            <td>3</td>
                                            <td>Chávez Díaz, Luis Alberto</td>
                                            <td><input type="number" min="0" max="20" step="0.1" class="form-control nota-input nota-desaprobado" name="nota_3_EP1" value="9"></td>
                                            <td><input type="number" min="0" max="20" step="0.1" class="form-control nota-input nota-desaprobado" name="nota_3_EP2" value="10"></td>
                                            <td><input type="number" min="0" max="20" step="0.1" class="form-control nota-input nota-regular" name="nota_3_EP3" value="11"></td>
                                            <td class="promedio-cell">10.0</td>
                                            <td><input type="number" min="0" max="20" step="0.1" class="form-control nota-input nota-regular" name="nota_3_TP1" value="12"></td>
                                            <td><input type="number" min="0" max="20" step="0.1" class="form-control nota-input nota-regular" name="nota_3_TP2" value="11"></td>
                                            <td><input type="number" min="0" max="20" step="0.1" class="form-control nota-input nota-regular" name="nota_3_TP3" value="12"></td>
                                            <td class="promedio-cell">11.7</td>
                                            <td><input type="number" min="0" max="20" step="0.1" class="form-control nota-input nota-regular" name="nota_3_P1" value="11"></td>
                                            <td class="promedio-cell">11.0</td>
                                            <td><input type="number" min="0" max="20" step="0.1" class="form-control nota-input nota-regular" name="nota_3_EF" value="12"></td>
                                            <td class="promedio-cell">12.0</td>
                                            <td class="promedio-cell nota-regular">11.1</td>
                                        </tr>
                                        <tr class="alumno-row">
                                            <td>4</td>
                                            <td>Delgado Flores, María José</td>
                                            <td><input type="number" min="0" max="20" step="0.1" class="form-control nota-input nota-aprobado" name="nota_4_EP1" value="18"></td>
                                            <td><input type="number" min="0" max="20" step="0.1" class="form-control nota-input nota-aprobado" name="nota_4_EP2" value="19"></td>
                                            <td><input type="number" min="0" max="20" step="0.1" class="form-control nota-input nota-aprobado" name="nota_4_EP3" value="20"></td>
                                            <td class="promedio-cell">19.0</td>
                                            <td><input type="number" min="0" max="20" step="0.1" class="form-control nota-input nota-aprobado" name="nota_4_TP1" value="19"></td>
                                            <td><input type="number" min="0" max="20" step="0.1" class="form-control nota-input nota-aprobado" name="nota_4_TP2" value="18"></td>
                                            <td><input type="number" min="0" max="20" step="0.1" class="form-control nota-input nota-aprobado" name="nota_4_TP3" value="20"></td>
                                            <td class="promedio-cell">19.0</td>
                                            <td><input type="number" min="0" max="20" step="0.1" class="form-control nota-input nota-aprobado" name="nota_4_P1" value="18"></td>
                                            <td class="promedio-cell">18.0</td>
                                            <td><input type="number" min="0" max="20" step="0.1" class="form-control nota-input nota-aprobado" name="nota_4_EF" value="19"></td>
                                            <td class="promedio-cell">19.0</td>
                                            <td class="promedio-cell nota-aprobado">18.8</td>
                                        </tr>
                                        <tr class="alumno-row">
                                            <td>5</td>
                                            <td>Espinoza García, Juan Carlos</td>
                                            <td><input type="number" min="0" max="20" step="0.1" class="form-control nota-input nota-aprobado" name="nota_5_EP1" value="14"></td>
                                            <td><input type="number" min="0" max="20" step="0.1" class="form-control nota-input nota-aprobado" name="nota_5_EP2" value="15"></td>
                                            <td><input type="number" min="0" max="20" step="0.1" class="form-control nota-input nota-aprobado" name="nota_5_EP3" value="16"></td>
                                            <td class="promedio-cell">15.0</td>
                                            <td><input type="number" min="0" max="20" step="0.1" class="form-control nota-input nota-aprobado" name="nota_5_TP1" value="16"></td>
                                            <td><input type="number" min="0" max="20" step="0.1" class="form-control nota-input nota-aprobado" name="nota_5_TP2" value="15"></td>
                                            <td><input type="number" min="0" max="20" step="0.1" class="form-control nota-input nota-aprobado" name="nota_5_TP3" value="14"></td>
                                            <td class="promedio-cell">15.0</td>
                                            <td><input type="number" min="0" max="20" step="0.1" class="form-control nota-input nota-aprobado" name="nota_5_P1" value="16"></td>
                                            <td class="promedio-cell">16.0</td>
                                            <td><input type="number" min="0" max="20" step="0.1" class="form-control nota-input nota-aprobado" name="nota_5_EF" value="15"></td>
                                            <td class="promedio-cell">15.0</td>
                                            <td class="promedio-cell nota-aprobado">15.2</td>
                                        </tr>
                                    </tbody>
                                </table>
                                
                                <!-- Botón flotante para guardar -->
                                <button type="submit" class="btn btn-primary btn-lg rounded-circle btn-save-all">
                                    <i class="bi bi-save"></i>
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
                
                <!-- Observaciones -->
                <div class="card border-0 shadow-sm mb-4">
                    <div class="card-header">
                        <h5 class="mb-0">Observaciones</h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th width="20%">Alumno</th>
                                        <th width="15%">Evaluación</th>
                                        <th width="10%">Nota</th>
                                        <th width="40%">Observación</th>
                                        <th width="15%">Acciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>Alarcón Mendoza, Carlos</td>
                                        <td>Examen Parcial 1</td>
                                        <td class="text-center nota-aprobado">16</td>
                                        <td>
                                            <input type="text" class="form-control observacion-input" value="Buen desempeño en problemas de álgebra">
                                        </td>
                                        <td>
                                            <button type="button" class="btn btn-sm btn-outline-primary">
                                                <i class="bi bi-save"></i> Guardar
                                            </button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Chávez Díaz, Luis Alberto</td>
                                        <td>Examen Parcial 1</td>
                                        <td class="text-center nota-desaprobado">9</td>
                                        <td>
                                            <input type="text" class="form-control observacion-input" value="Dificultades con ecuaciones. Necesita reforzamiento">
                                        </td>
                                        <td>
                                            <button type="button" class="btn btn-sm btn-outline-primary">
                                                <i class="bi bi-save"></i> Guardar
                                            </button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Delgado Flores, María José</td>
                                        <td>Trabajo Práctico 3</td>
                                        <td class="text-center nota-aprobado">20</td>
                                        <td>
                                            <input type="text" class="form-control observacion-input" value="Excelente trabajo de investigación. Muy completo">
                                        </td>
                                        <td>
                                            <button type="button" class="btn btn-sm btn-outline-primary">
                                                <i class="bi bi-save"></i> Guardar
                                            </button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4">
                                            <div class="input-group">
                                                <select class="form-select" id="alumnoObservacion">
                                                    <option value="">Seleccione un alumno</option>
                                                    <option>Alarcón Mendoza, Carlos</option>
                                                    <option>Benites Rojas, Ana María</option>
                                                    <option>Chávez Díaz, Luis Alberto</option>
                                                    <option>Delgado Flores, María José</option>
                                                    <option>Espinoza García, Juan Carlos</option>
                                                </select>
                                                <select class="form-select" id="evaluacionObservacion">
                                                    <option value="">Seleccione una evaluación</option>
                                                    <option>Examen Parcial 1</option>
                                                    <option>Examen Parcial 2</option>
                                                    <option>Examen Parcial 3</option>
                                                    <option>Trabajo Práctico 1</option>
                                                    <option>Trabajo Práctico 2</option>
                                                    <option>Trabajo Práctico 3</option>
                                                    <option>Participación</option>
                                                    <option>Examen Final</option>
                                                </select>
                                                <input type="text" class="form-control" placeholder="Nueva observación...">
                                                <button class="btn btn-outline-primary" type="button">Agregar</button>
                                            </div>
                                        </td>
                                        <td></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>
    
    <!-- Modal para Nueva Evaluación -->
    <div class="modal fade" id="nuevaEvaluacionModal" tabindex="-1" aria-labelledby="nuevaEvaluacionModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="nuevaEvaluacionModalLabel">Nueva Evaluación</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="formNuevaEvaluacion">
                        <div class="mb-3">
                            <label for="tipoEvaluacion" class="form-label">Tipo de Evaluación</label>
                            <select class="form-select" id="tipoEvaluacion" required>
                                <option value="">Seleccione un tipo</option>
                                <option value="Examen Parcial">Examen Parcial</option>
                                <option value="Trabajo Práctico">Trabajo Práctico</option>
                                <option value="Participación">Participación</option>
                                <option value="Examen Final">Examen Final</option>
                                <option value="Otro">Otro</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="nombreEvaluacion" class="form-label">Nombre de la Evaluación</label>
                            <input type="text" class="form-control" id="nombreEvaluacion" placeholder="Ej: Examen Parcial 4" required>
                        </div>
                        <div class="mb-3">
                            <label for="fechaEvaluacion" class="form-label">Fecha de la Evaluación</label>
                            <input type="date" class="form-control" id="fechaEvaluacion" required>
                        </div>
                        <div class="mb-3">
                            <label for="pesoEvaluacion" class="form-label">Peso en el Promedio (%)</label>
                            <input type="number" class="form-control" id="pesoEvaluacion" min="1" max="100" value="10" required>
                        </div>
                        <div class="mb-3">
                            <label for="descripcionEvaluacion" class="form-label">Descripción</label>
                            <textarea class="form-control" id="descripcionEvaluacion" rows="3"></textarea>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="button" class="btn btn-primary" id="btnGuardarEvaluacion">Guardar</button>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Modal para Importar Notas -->
    <div class="modal fade" id="importarModal" tabindex="-1" aria-labelledby="importarModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="importarModalLabel">Importar Notas</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="formImportar">
                        <div class="mb-3">
                            <label for="archivoExcel" class="form-label">Archivo Excel</label>
                            <input class="form-control" type="file" id="archivoExcel" accept=".xlsx, .xls" required>
                            <div class="form-text">El archivo debe seguir la plantilla establecida.</div>
                        </div>
                        <div class="mb-3">
                            <label for="tipoImportacion" class="form-label">Tipo de Importación</label>
                            <select class="form-select" id="tipoImportacion" required>
                                <option value="reemplazar">Reemplazar notas existentes</option>
                                <option value="agregar">Agregar solo notas nuevas</option>
                            </select>
                        </div>
                    </form>
                    <div class="alert alert-info">
                        <i class="bi bi-info-circle"></i> Puede descargar la plantilla de importación <a href="#" class="alert-link">aquí</a>.
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="button" class="btn btn-primary" id="btnConfirmarImportar">Importar</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Inicializar modales
        document.addEventListener('DOMContentLoaded', function() {
            // Modal de Nueva Evaluación
            const btnNuevaEvaluacion = document.getElementById('btnNuevaEvaluacion');
            const nuevaEvaluacionModal = new bootstrap.Modal(document.getElementById('nuevaEvaluacionModal'));
            
            btnNuevaEvaluacion.addEventListener('click', function() {
                nuevaEvaluacionModal.show();
            });
            
            // Modal de Importar
            const btnImportar = document.getElementById('btnImportar');
            const importarModal = new bootstrap.Modal(document.getElementById('importarModal'));
            
            btnImportar.addEventListener('click', function() {
                importarModal.show();
            });
            
            // Formulario de calificaciones
            const formCalificaciones = document.getElementById('formCalificaciones');
            
            formCalificaciones.addEventListener('submit', function(e) {
                e.preventDefault();
                
                // Simulación de guardado
                alert('Calificaciones guardadas correctamente');
            });
            
            // Cambio de color en inputs de notas
            const notaInputs = document.querySelectorAll('.nota-input');
            
            notaInputs.forEach(input => {
                input.addEventListener('input', function() {
                    const valor = parseFloat(this.value);
                    
                    // Limpiar clases
                    this.classList.remove('nota-aprobado', 'nota-regular', 'nota-desaprobado');
                    
                    // Asignar clase según valor
                    if (valor >= 14) {
                        this.classList.add('nota-aprobado');
                    } else if (valor >= 11) {
                        this.classList.add('nota-regular');
                    } else {
                        this.classList.add('nota-desaprobado');
                    }
                    
                    // Recalcular promedios
                    recalcularPromedios();
                });
            });
            
            // Función para recalcular promedios
            function recalcularPromedios() {
                // Esta función simularía el cálculo de promedios
                console.log('Recalculando promedios...');
            }
            
            // Guardar nueva evaluación
            const btnGuardarEvaluacion = document.getElementById('btnGuardarEvaluacion');
            
            btnGuardarEvaluacion.addEventListener('click', function() {
                const tipoEvaluacion = document.getElementById('tipoEvaluacion').value;
                const nombreEvaluacion = document.getElementById('nombreEvaluacion').value;
                
                if (!tipoEvaluacion || !nombreEvaluacion) {
                    alert('Por favor complete los campos requeridos');
                    return;
                }
                
                // Simulación de guardado
                alert(`Nueva evaluación "${nombreEvaluacion}" creada correctamente`);
                nuevaEvaluacionModal.hide();
            });
            
            // Importar notas
            const btnConfirmarImportar = document.getElementById('btnConfirmarImportar');
            
            btnConfirmarImportar.addEventListener('click', function() {
                const archivoExcel = document.getElementById('archivoExcel').value;
                
                if (!archivoExcel) {
                    alert('Por favor seleccione un archivo');
                    return;
                }
                
                // Simulación de importación
                alert('Notas importadas correctamente');
                importarModal.hide();
            });
        });
    </script>
</body>
</html>

