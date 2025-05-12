-- Crear la base de datos ESCOLAR si no existe
CREATE DATABASE IF NOT EXISTS ESCOLAR;

-- Usar la base de datos ESCOLAR
USE ESCOLAR;

-- Tabla de Usuarios
CREATE TABLE usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    dni VARCHAR(15) UNIQUE,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    correo VARCHAR(100) UNIQUE,
    telefono VARCHAR(20),
    clave VARCHAR(255) NOT NULL,
    estado BOOLEAN DEFAULT TRUE,
    fec_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    foto_perfil VARCHAR(255)
);

-- Tabla de Roles
CREATE TABLE rol (
    id_rol INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE,
    desc_rol TEXT
);

-- Tabla de Permisos
CREATE TABLE permiso (
    id_permiso INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    desc_permiso TEXT
);

-- Tabla de Unión Usuario-Rol
CREATE TABLE usuario_rol (
    id_usuario INT NOT NULL,
    id_rol INT NOT NULL,
    PRIMARY KEY (id_usuario, id_rol),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_rol) REFERENCES rol(id_rol)
);

-- Tabla de Unión Rol-Permiso
CREATE TABLE rol_permiso (
    id_rol INT NOT NULL,
    id_permiso INT NOT NULL,
    PRIMARY KEY (id_rol, id_permiso),
    FOREIGN KEY (id_rol) REFERENCES rol(id_rol),
    FOREIGN KEY (id_permiso) REFERENCES permiso(id_permiso)
);

-- Tabla de Niveles Educativos
CREATE TABLE nivel (
    id_nivel INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE,
    desc_nivel TEXT
);

-- Tabla de Grados
CREATE TABLE grado (
    id_grado INT AUTO_INCREMENT PRIMARY KEY,
    id_nivel INT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_nivel) REFERENCES nivel(id_nivel)
);

-- Tabla de Secciones
CREATE TABLE seccion (
    id_seccion INT AUTO_INCREMENT PRIMARY KEY,
    id_grado INT NOT NULL,
    nombre VARCHAR(10) NOT NULL,
    FOREIGN KEY (id_grado) REFERENCES grado(id_grado)
);

-- Tabla de Cursos
CREATE TABLE curso (
    id_curso INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE
);

-- Tabla de Unión Docente-Curso-Sección
CREATE TABLE docente_curso (
    id_usuario INT NOT NULL,
    id_curso INT NOT NULL,
    id_seccion INT NOT NULL,
    PRIMARY KEY (id_usuario, id_curso, id_seccion),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_curso) REFERENCES curso(id_curso),
    FOREIGN KEY (id_seccion) REFERENCES seccion(id_seccion)
);

-- Tabla de Unión Estudiante-Curso-Sección
CREATE TABLE estudiante_curso (
    id_usuario INT NOT NULL,
    id_curso INT NOT NULL,
    id_seccion INT NOT NULL,
    PRIMARY KEY (id_usuario, id_curso, id_seccion),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_curso) REFERENCES curso(id_curso),
    FOREIGN KEY (id_seccion) REFERENCES seccion(id_seccion)
);

-- Tabla de Periodos Lectivos
CREATE TABLE periodo_lectivo (
    id_periodo_lectivo INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL UNIQUE,
    fec_inicio DATE NOT NULL,
    fec_fin DATE NOT NULL,
    estado BOOLEAN DEFAULT TRUE
);

-- Tabla de Bimestres
CREATE TABLE bimestre (
    id_bimestre INT AUTO_INCREMENT PRIMARY KEY,
    id_periodo_lectivo INT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_periodo_lectivo) REFERENCES periodo_lectivo(id_periodo_lectivo)
);

-- Tabla de Criterios de Evaluación
CREATE TABLE criterio (
    id_criterio INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    tipo ENUM('Conceptual', 'Procedimental', 'Actitudinal') NOT NULL,
    escala TEXT
);

-- Tabla de Calificaciones
CREATE TABLE calificacion (
    id_calificacion INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_curso INT NOT NULL,
    id_bimestre INT NOT NULL,
    id_criterio INT NOT NULL,
    id_periodo_lectivo INT NOT NULL,
    nota VARCHAR(10) NOT NULL,
    tipo_nota ENUM('Literal', 'Numérica') NOT NULL,
    fec_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion DATETIME ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_curso) REFERENCES curso(id_curso),
    FOREIGN KEY (id_bimestre) REFERENCES bimestre(id_bimestre),
    FOREIGN KEY (id_criterio) REFERENCES criterio(id_criterio),
    FOREIGN KEY (id_periodo_lectivo) REFERENCES periodo_lectivo(id_periodo_lectivo)
);

-- Tabla de Historial de Notas
CREATE TABLE historial_nota (
    id_historial INT AUTO_INCREMENT PRIMARY KEY,
    id_calificacion INT NOT NULL,
    id_usuario_modifico INT NOT NULL,
    fecha_modificacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    nota_anterior VARCHAR(10) NOT NULL,
    nota_nueva VARCHAR(10) NOT NULL,
    FOREIGN KEY (id_calificacion) REFERENCES calificacion(id_calificacion),
    FOREIGN KEY (id_usuario_modifico) REFERENCES usuario(id_usuario)
);

-- Tabla de Asistencia
CREATE TABLE asistencia (
    id_asistencia INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_seccion INT NOT NULL,
    id_periodo_lectivo INT NOT NULL,
    fec_asistencia DATE NOT NULL,
    estado_asistencia ENUM('Presente', 'Ausente', 'Tardanza', 'Justificado') NOT NULL,
    justificada BOOLEAN DEFAULT FALSE,
    motivo_tardanza TEXT,
    observaciones TEXT,
    fec_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_seccion) REFERENCES seccion(id_seccion),
    FOREIGN KEY (id_periodo_lectivo) REFERENCES periodo_lectivo(id_periodo_lectivo)
);

-- Tabla de Tipos de Incidencia
CREATE TABLE tipo_incidencia (
    id_tipo_incidencia INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL UNIQUE,
    descripcion TEXT,
    puntos_demerito INT DEFAULT 0,
    fec_registro DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de Conducta
CREATE TABLE conducta (
    id_conducta INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_periodo_lectivo INT NOT NULL,
    fec_conducta DATE NOT NULL,
    desc_conducta TEXT,
    tipo ENUM('Merito', 'Demerito') NOT NULL,
    puntos_merito INT DEFAULT 0,
    puntos_demerito INT DEFAULT 0,
    fec_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    id_usuario_registro INT NOT NULL,
    id_incidencia INT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_periodo_lectivo) REFERENCES periodo_lectivo(id_periodo_lectivo),
    FOREIGN KEY (id_usuario_registro) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_incidencia) REFERENCES incidencia(id_incidencia)
);

-- Tabla de Incidencias
CREATE TABLE incidencia (
    id_incidencia INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_periodo_lectivo INT NOT NULL,
    fec_incidencia DATE NOT NULL,
    nivel_gravedad ENUM('Leve', 'Moderada', 'Grave') NOT NULL,
    fec_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    id_usuario_reporta INT NOT NULL,
    id_tipo_incidencia INT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_periodo_lectivo) REFERENCES periodo_lectivo(id_periodo_lectivo),
    FOREIGN KEY (id_usuario_reporta) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_tipo_incidencia) REFERENCES tipo_incidencia(id_tipo_incidencia)
);

-- Tabla de Atención en Tópico (o similar)
CREATE TABLE atencion_topico (
    id_atencion INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario_estudiante INT NOT NULL,
    fecha_hora DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    motivo TEXT NOT NULL,
    desc_atencion TEXT,
    usuario_atendio INT NOT NULL,
    observaciones TEXT,
    FOREIGN KEY (id_usuario_estudiante) REFERENCES usuario(id_usuario),
    FOREIGN KEY (usuario_atendio) REFERENCES usuario(id_usuario)
);

-- Tabla de Comunicados
CREATE TABLE comunicado (
    id_comunicado INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario_autor INT NOT NULL,
    id_seccion INT,
    titulo VARCHAR(255) NOT NULL,
    contenido TEXT NOT NULL,
    fec_publicacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    dirigido_a ENUM('Todos', 'Docentes', 'Estudiantes', 'Padres', 'Seccion'),
    FOREIGN KEY (id_usuario_autor) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_seccion) REFERENCES seccion(id_seccion)
);

-- Tabla de Notificaciones
CREATE TABLE notificacion (
    id_notificacion INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    titulo VARCHAR(255) NOT NULL,
    desc_notificacion TEXT,
    tipo ENUM('General', 'Académica', 'Conductual', 'Administrativa') NOT NULL,
    fec_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    leido BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

-- Tabla de Horario de Clases
CREATE TABLE horario_clase (
    id_horario INT AUTO_INCREMENT PRIMARY KEY,
    id_periodo_lectivo INT NOT NULL,
    id_seccion INT NOT NULL,
    id_curso INT NOT NULL,
    id_usuario_docente INT NOT NULL,
    dia_semana ENUM('Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo') NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL,
    FOREIGN KEY (id_periodo_lectivo) REFERENCES periodo_lectivo(id_periodo_lectivo),
    FOREIGN KEY (id_seccion) REFERENCES seccion(id_seccion),
    FOREIGN KEY (id_curso) REFERENCES curso(id_curso),
    FOREIGN KEY (id_usuario_docente) REFERENCES usuario(id_usuario)
);

-- Tabla de Horario de Exámenes
CREATE TABLE horario_examen (
    id_horario_examen INT AUTO_INCREMENT PRIMARY KEY,
    id_periodo_lectivo INT NOT NULL,
    id_curso INT NOT NULL,
    id_seccion INT NOT NULL,
    nombre_examen VARCHAR(100) NOT NULL,
    fec_examen DATE NOT NULL,
    hora_examen TIME NOT NULL,
    lugar VARCHAR(100),
    FOREIGN KEY (id_periodo_lectivo) REFERENCES periodo_lectivo(id_periodo_lectivo),
    FOREIGN KEY (id_curso) REFERENCES curso(id_curso),
    FOREIGN KEY (id_seccion) REFERENCES seccion(id_seccion)
);

-- Tabla de Eventos
CREATE TABLE evento (
    id_evento INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario_autor INT NOT NULL,
    id_seccion INT,
    id_periodo_lectivo INT NOT NULL,
    titulo VARCHAR(255) NOT NULL,
    desc_evento TEXT,
    fec_inicio DATE NOT NULL,
    fec_fin DATE NOT NULL,
    hora_inicio TIME,
    hora_fin TIME,
    lugar VARCHAR(255),
    tipo_evento ENUM('Académico', 'Cultural', 'Deportivo', 'Social') NOT NULL,
    dirigido_a ENUM('Todos', 'Docentes', 'Estudiantes', 'Padres', 'Seccion'),
    fec_publicacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario_autor) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_seccion) REFERENCES seccion(id_seccion),
    FOREIGN KEY (id_periodo_lectivo) REFERENCES periodo_lectivo(id_periodo_lectivo)
);

-- Tabla de Noticias
CREATE TABLE noticia (
    id_noticia INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario_autor INT NOT NULL,
    titulo VARCHAR(255) NOT NULL,
    contenido TEXT NOT NULL,
    fec_publicacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    dirigido_a ENUM('Todos', 'Docentes', 'Estudiantes', 'Padres', 'Seccion'),
    FOREIGN KEY (id_usuario_autor) REFERENCES usuario(id_usuario)
);

-- Tabla de Estudiantes por Periodo Lectivo (Historial de Inscripciones)
CREATE TABLE estudiante_periodo_lectivo (
    id_estudiante_periodo INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_periodo_lectivo INT NOT NULL,
    fec_inscripcion DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    estado_en_periodo ENUM('Activo', 'Inactivo', 'Trasladado', 'Graduado') DEFAULT 'Activo',
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_periodo_lectivo) REFERENCES periodo_lectivo(id_periodo_lectivo)
);

-- Tabla de Apoderados por Estudiante
CREATE TABLE apoderado_estudiante (
    id_apoderado_estudiante INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario_estudiante INT NOT NULL,
    id_usuario_apoderado INT NOT NULL,
    parentesco ENUM('Padre', 'Madre', 'Tutor', 'Otro') NOT NULL,
    FOREIGN KEY (id_usuario_estudiante) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_usuario_apoderado) REFERENCES usuario(id_usuario),
    UNIQUE KEY `unique_apoderado_estudiante` (`id_usuario_estudiante`,`id_usuario_apoderado`)
);