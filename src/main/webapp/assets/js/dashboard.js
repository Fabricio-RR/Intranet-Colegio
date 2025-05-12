/**
 * dashboard.js - Funcionalidades principales del dashboard con soporte responsivo
 */
document.addEventListener('DOMContentLoaded', function() {
    // Referencias a elementos DOM
    const sidebar = document.querySelector('.sidebar');
    const mainContent = document.querySelector('.main-content');
    const toggleSidebarBtn = document.querySelector('.toggle-sidebar');
    const allNavLinks = document.querySelectorAll('.sidebar .nav-link');
    const dropdownToggles = document.querySelectorAll('.dropdown-toggle');
    const notificationBtns = document.querySelectorAll('[data-toggle="notifications"]');
    const darkModeToggle = document.getElementById('darkModeToggle');
    const printButtons = document.querySelectorAll('.btn-print');
    const exportButtons = document.querySelectorAll('.btn-export');
    const searchForms = document.querySelectorAll('.search-form');
    const dataTableContainers = document.querySelectorAll('.datatable-container');
    const chartContainers = document.querySelectorAll('.chart-container');
    const notaInputs = document.querySelectorAll('.nota-input');
    const formSubmitButtons = document.querySelectorAll('form button[type="submit"]');
    
    // Estado de la aplicación
    const appState = {
        sidebarCollapsed: window.innerWidth < 768,
        darkMode: localStorage.getItem('darkMode') === 'true',
        isMobile: window.innerWidth < 768,
        isTablet: window.innerWidth >= 768 && window.innerWidth < 992,
        isDesktop: window.innerWidth >= 992,
        charts: [],
        dataTables: []
    };
    
    // Inicialización
    function init() {
        setupSidebar();
        setupResponsiveness();
        setupDarkMode();
        setupNotifications();
        setupDropdowns();
        setupPrintExport();
        setupForms();
        setupDataTables();
        setupCharts();
        setupNotaInputs();
        setupAccessibility();
        
        // Inicializar tooltips y popovers de Bootstrap si están disponibles
        if (typeof bootstrap !== 'undefined') {
            const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
            tooltipTriggerList.map(function (tooltipTriggerEl) {
                return new bootstrap.Tooltip(tooltipTriggerEl);
            });
            
            const popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'));
            popoverTriggerList.map(function (popoverTriggerEl) {
                return new bootstrap.Popover(popoverTriggerEl);
            });
        }
    }
    
    // Configuración del sidebar
    function setupSidebar() {
        if (appState.sidebarCollapsed) {
            sidebar.classList.add('sidebar-collapsed');
            mainContent.classList.add('main-content-expanded');
        }
        
        toggleSidebarBtn.addEventListener('click', function() {
            sidebar.classList.toggle('sidebar-collapsed');
            mainContent.classList.toggle('main-content-expanded');
            
            // En móvil, mostrar/ocultar completamente
            if (appState.isMobile) {
                sidebar.classList.toggle('show');
            }
            
            appState.sidebarCollapsed = sidebar.classList.contains('sidebar-collapsed');
            localStorage.setItem('sidebarCollapsed', appState.sidebarCollapsed);
        });
        
        // Cerrar sidebar al hacer clic en un enlace en móvil
        if (appState.isMobile) {
            allNavLinks.forEach(link => {
                link.addEventListener('click', function() {
                    sidebar.classList.remove('show');
                });
            });
            
            // Cerrar sidebar al hacer clic fuera de él
            document.addEventListener('click', function(event) {
                if (sidebar.classList.contains('show') && 
                    !sidebar.contains(event.target) && 
                    !toggleSidebarBtn.contains(event.target)) {
                    sidebar.classList.remove('show');
                }
            });
        }
    }
    
    // Configuración de responsividad
    function setupResponsiveness() {
        // Manejar cambios de tamaño de ventana
        window.addEventListener('resize', debounce(function() {
            const wasDesktop = appState.isDesktop;
            const wasTablet = appState.isTablet;
            const wasMobile = appState.isMobile;
            
            appState.isMobile = window.innerWidth < 768;
            appState.isTablet = window.innerWidth >= 768 && window.innerWidth < 992;
            appState.isDesktop = window.innerWidth >= 992;
            
            // Si cambia entre móvil y no móvil
            if (wasMobile !== appState.isMobile) {
                if (appState.isMobile) {
                    sidebar.classList.remove('sidebar-collapsed');
                    sidebar.classList.remove('show');
                    mainContent.classList.remove('main-content-expanded');
                } else {
                    sidebar.classList.remove('show');
                    if (appState.sidebarCollapsed) {
                        sidebar.classList.add('sidebar-collapsed');
                        mainContent.classList.add('main-content-expanded');
                    }
                }
            }
            
            // Actualizar gráficos si existen
            if (appState.charts.length > 0) {
                appState.charts.forEach(chart => {
                    if (chart && typeof chart.resize === 'function') {
                        chart.resize();
                    }
                });
            }
            
            // Actualizar tablas de datos si existen
            if (appState.dataTables.length > 0) {
                appState.dataTables.forEach(table => {
                    if (table && typeof table.columns.adjust === 'function') {
                        table.columns.adjust();
                    }
                });
            }
        }, 250));
        
        // Orientación en dispositivos móviles
        window.addEventListener('orientationchange', function() {
            setTimeout(function() {
                // Actualizar gráficos
                if (appState.charts.length > 0) {
                    appState.charts.forEach(chart => {
                        if (chart && typeof chart.resize === 'function') {
                            chart.resize();
                        }
                    });
                }
                
                // Actualizar tablas
                if (appState.dataTables.length > 0) {
                    appState.dataTables.forEach(table => {
                        if (table && typeof table.columns.adjust === 'function') {
                            table.columns.adjust();
                        }
                    });
                }
            }, 300);
        });
    }
    
    // Configuración de modo oscuro
    function setupDarkMode() {
        if (darkModeToggle) {
            // Aplicar modo oscuro si está guardado
            if (appState.darkMode) {
                document.body.classList.add('dark-mode');
                darkModeToggle.checked = true;
            }
            
            darkModeToggle.addEventListener('change', function() {
                document.body.classList.toggle('dark-mode');
                appState.darkMode = document.body.classList.contains('dark-mode');
                localStorage.setItem('darkMode', appState.darkMode);
                
                // Actualizar gráficos para modo oscuro si existen
                if (appState.charts.length > 0) {
                    appState.charts.forEach(chart => {
                        if (chart && typeof chart.setOption === 'function') {
                            const theme = appState.darkMode ? 'dark' : '';
                            chart.setOption({
                                backgroundColor: 'transparent',
                                textStyle: {
                                    color: appState.darkMode ? '#e9ecef' : '#212529'
                                }
                            });
                        }
                    });
                }
            });
        }
        
        // Detectar preferencia del sistema
        const prefersDarkMode = window.matchMedia('(prefers-color-scheme: dark)');
        prefersDarkMode.addEventListener('change', function(e) {
            if (localStorage.getItem('darkMode') === null) {
                if (e.matches) {
                    document.body.classList.add('dark-mode');
                    if (darkModeToggle) darkModeToggle.checked = true;
                } else {
                    document.body.classList.remove('dark-mode');
                    if (darkModeToggle) darkModeToggle.checked = false;
                }
                appState.darkMode = document.body.classList.contains('dark-mode');
            }
        });
    }
    
    // Configuración de notificaciones
    function setupNotifications() {
        notificationBtns.forEach(btn => {
            btn.addEventListener('click', function(e) {
                e.preventDefault();
                
                // Simulación de carga de notificaciones
                const notificationContainer = document.querySelector(this.getAttribute('data-target'));
                if (notificationContainer) {
                    if (!notificationContainer.classList.contains('loaded')) {
                        notificationContainer.innerHTML = '<div class="loader"></div>';
                        
                        // Simular carga
                        setTimeout(() => {
                            fetchNotifications()
                                .then(notifications => {
                                    renderNotifications(notificationContainer, notifications);
                                    notificationContainer.classList.add('loaded');
                                })
                                .catch(error => {
                                    notificationContainer.innerHTML = `<div class="alert alert-danger">Error al cargar notificaciones: ${error.message}</div>`;
                                });
                        }, 500);
                    }
                }
            });
        });
    }
    
    // Simulación de obtención de notificaciones
    async function fetchNotifications() {
        // Simulación de API
        return new Promise((resolve) => {
            setTimeout(() => {
                resolve([
                    { id: 1, title: 'Nueva tarea asignada', message: 'Se ha asignado una nueva tarea para el curso de Matemáticas', time: '10 min', unread: true },
                    { id: 2, title: 'Recordatorio de examen', message: 'Examen de Comunicación mañana a las 9:00 AM', time: '1 hora', unread: true },
                    { id: 3, title: 'Calificación publicada', message: 'Se ha publicado la calificación del examen de Ciencias', time: '3 horas', unread: false },
                    { id: 4, title: 'Comunicado importante', message: 'Reunión de padres este viernes a las 6:00 PM', time: '1 día', unread: false }
                ]);
            }, 300);
        });
    }
    
    // Renderizar notificaciones
    function renderNotifications(container, notifications) {
        if (notifications.length === 0) {
            container.innerHTML = '<div class="p-3 text-center text-muted">No hay notificaciones</div>';
            return;
        }
        
        let html = '<div class="notification-list">';
        notifications.forEach(notification => {
            html += `
                <div class="notification-item ${notification.unread ? 'unread' : ''}">
                    <div class="notification-title">${notification.title}</div>
                    <div class="notification-message">${notification.message}</div>
                    <div class="notification-time"><small><i class="bi bi-clock"></i> ${notification.time}</small></div>
                </div>
            `;
        });
        html += '</div>';
        html += '<div class="text-center p-2"><a href="notificaciones.jsp" class="btn btn-sm btn-outline-primary">Ver todas</a></div>';
        
        container.innerHTML = html;
    }
    
    // Configuración de dropdowns
    function setupDropdowns() {
        dropdownToggles.forEach(toggle => {
            toggle.addEventListener('click', function(e) {
                e.preventDefault();
                const dropdownMenu = this.nextElementSibling;
                
                // Cerrar otros dropdowns
                document.querySelectorAll('.dropdown-menu.show').forEach(menu => {
                    if (menu !== dropdownMenu) {
                        menu.classList.remove('show');
                    }
                });
                
                dropdownMenu.classList.toggle('show');
            });
        });
        
        // Cerrar dropdowns al hacer clic fuera
        document.addEventListener('click', function(e) {
            if (!e.target.matches('.dropdown-toggle') && !e.target.closest('.dropdown-menu')) {
                document.querySelectorAll('.dropdown-menu.show').forEach(menu => {
                    menu.classList.remove('show');
                });
            }
        });
    }
    
    // Configuración de impresión y exportación
    function setupPrintExport() {
        // Botones de impresión
        printButtons.forEach(btn => {
            btn.addEventListener('click', function(e) {
                e.preventDefault();
                
                const printArea = document.querySelector(this.getAttribute('data-print-target')) || document.querySelector('main');
                
                if (printArea) {
                    const originalContents = document.body.innerHTML;
                    const printContents = printArea.innerHTML;
                    
                    document.body.innerHTML = `
                        <div class="print-header">
                            <img src="${this.getAttribute('data-logo') || 'assets/img/EscudoCDO.png'}" alt="Logo" style="height: 60px;">
                            <h2>${this.getAttribute('data-title') || 'Colegio Peruano Chino Diez de Octubre'}</h2>
                        </div>
                        <div class="print-content">${printContents}</div>
                        <div class="print-footer">
                            <p>Fecha de impresión: ${new Date().toLocaleString()}</p>
                        </div>
                    `;
                    
                    window.print();
                    document.body.innerHTML = originalContents;
                    init(); // Reinicializar eventos después de restaurar
                }
            });
        });
        
        // Botones de exportación
        exportButtons.forEach(btn => {
            btn.addEventListener('click', function(e) {
                e.preventDefault();
                
                const format = this.getAttribute('data-format') || 'excel';
                const tableId = this.getAttribute('data-table');
                
                if (tableId) {
                    const table = document.getElementById(tableId);
                    if (table) {
                        exportTable(table, format, this.getAttribute('data-filename') || 'exportacion');
                    }
                }
            });
        });
    }
    
    // Exportar tabla a diferentes formatos
    function exportTable(table, format, filename) {
        if (format === 'excel') {
            exportToExcel(table, filename);
        } else if (format === 'pdf') {
            exportToPDF(table, filename);
        } else if (format === 'csv') {
            exportToCSV(table, filename);
        }
    }
    
    // Exportar a Excel (simulado)
    function exportToExcel(table, filename) {
        alert('Exportando a Excel: ' + filename + '.xlsx');
        // Aquí iría la implementación real
    }
    
    // Exportar a PDF (simulado)
    function exportToPDF(table, filename) {
        alert('Exportando a PDF: ' + filename + '.pdf');
        // Aquí iría la implementación real
    }
    
    // Exportar a CSV
    function exportToCSV(table, filename) {
        let csv = [];
        const rows = table.querySelectorAll('tr');
        
        for (let i = 0; i < rows.length; i++) {
            const row = [], cols = rows[i].querySelectorAll('td, th');
            
            for (let j = 0; j < cols.length; j++) {
                // Escapar comillas y añadir comillas alrededor del texto
                let text = cols[j].innerText;
                text = text.replace(/"/g, '""');
                row.push('"' + text + '"');
            }
            
            csv.push(row.join(','));
        }
        
        // Descargar CSV
        const csvString = csv.join('\n');
        const blob = new Blob([csvString], { type: 'text/csv;charset=utf-8;' });
        const link = document.createElement('a');
        const url = URL.createObjectURL(blob);
        
        link.setAttribute('href', url);
        link.setAttribute('download', filename + '.csv');
        link.style.visibility = 'hidden';
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
    }
    
    // Configuración de formularios
    function setupForms() {
        searchForms.forEach(form => {
            form.addEventListener('submit', function(e) {
                const searchInput = this.querySelector('input[type="search"]');
                if (searchInput && searchInput.value.trim() === '') {
                    e.preventDefault();
                    searchInput.focus();
                }
            });
        });
        
        // Prevenir envío múltiple de formularios
        formSubmitButtons.forEach(button => {
            button.addEventListener('click', function() {
                const form = this.closest('form');
                if (form && form.checkValidity()) {
                    this.disabled = true;
                    this.innerHTML = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Procesando...';
                    
                    // Restaurar después de un tiempo (para demo)
                    setTimeout(() => {
                        this.disabled = false;
                        this.innerHTML = this.getAttribute('data-original-text') || 'Guardar';
                    }, 2000);
                }
            });
            
            // Guardar texto original
            button.setAttribute('data-original-text', button.innerHTML);
        });
    }
    
    // Configuración de DataTables
    function setupDataTables() {
        if (dataTableContainers.length > 0 && typeof $.fn.DataTable !== 'undefined') {
            dataTableContainers.forEach(container => {
                const table = container.querySelector('table');
                if (table) {
                    const dataTable = $(table).DataTable({
                        responsive: true,
                        language: {
                            url: '//cdn.datatables.net/plug-ins/1.10.25/i18n/Spanish.json'
                        },
                        dom: 'Bfrtip',
                        buttons: [
                            'copy', 'excel', 'pdf', 'print'
                        ]
                    });
                    
                    appState.dataTables.push(dataTable);
                }
            });
        }
    }
    
    // Configuración de gráficos
    function setupCharts() {
        if (chartContainers.length > 0 && typeof Chart !== 'undefined') {
            chartContainers.forEach(container => {
                const canvas = container.querySelector('canvas');
                if (canvas) {
                    const ctx = canvas.getContext('2d');
                    const chartType = container.getAttribute('data-chart-type') || 'bar';
                    const chartData = JSON.parse(container.getAttribute('data-chart-data') || '{}');
                    
                    const chart = new Chart(ctx, {
                        type: chartType,
                        data: chartData,
                        options: {
                            responsive: true,
                            maintainAspectRatio: false,
                            plugins: {
                                legend: {
                                    position: 'top',
                                },
                                title: {
                                    display: true,
                                    text: container.getAttribute('data-chart-title') || ''
                                }
                            }
                        }
                    });
                    
                    appState.charts.push(chart);
                }
            });
        }
    }
    
    // Configuración de inputs de notas
    function setupNotaInputs() {
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
                
                // Recalcular promedios si hay función disponible
                if (typeof recalcularPromedios === 'function') {
                    recalcularPromedios();
                }
            });
        });
    }
    
    // Configuración de accesibilidad
    function setupAccessibility() {
        // Añadir atributos ARIA donde sea necesario
        document.querySelectorAll('button:not([aria-label])').forEach(button => {
            if (!button.textContent.trim()) {
                const icon = button.querySelector('i, .bi');
                if (icon) {
                    const iconClass = icon.className;
                    let label = 'Botón';
                    
                    if (iconClass.includes('print')) label = 'Imprimir';
                    else if (iconClass.includes('download')) label = 'Descargar';
                    else if (iconClass.includes('search')) label = 'Buscar';
                    else if (iconClass.includes('eye')) label = 'Ver';
                    else if (iconClass.includes('pencil')) label = 'Editar';
                    else if (iconClass.includes('trash')) label = 'Eliminar';
                    
                    button.setAttribute('aria-label', label);
                }
            }
        });
        
        // Mejorar navegación por teclado
        document.querySelectorAll('a, button, input, select, textarea, [tabindex]').forEach(el => {
            el.addEventListener('focus', function() {
                this.classList.add('focus-visible');
            });
            
            el.addEventListener('blur', function() {
                this.classList.remove('focus-visible');
            });
        });
    }
    
    // Utilidad: Debounce para eventos de resize
    function debounce(func, wait) {
        let timeout;
        return function() {
            const context = this;
            const args = arguments;
            clearTimeout(timeout);
            timeout = setTimeout(() => func.apply(context, args), wait);
        };
    }
    
    // Iniciar la aplicación
    init();
});