Ejercicio 2. CREACIÓN DE BASE DE DATOS. 

-- Creación de la tabla Alumno 

CREATE TABLE Alumno ( 

    ID_Alumno SERIAL PRIMARY KEY, 

    Nombre VARCHAR(255) NOT NULL, 

    Apellido VARCHAR(255) NOT NULL, 

    Email VARCHAR(255) UNIQUE NOT NULL, 

    Fecha_Inscripcion DATE NOT NULL 

); 

  

-- Creación de la tabla Bootcamp 

CREATE TABLE Bootcamp ( 

    ID_Bootcamp SERIAL PRIMARY KEY, 

    Nombre VARCHAR(255) NOT NULL, 

    Descripcion TEXT, 

    Duracion INT 

); 

  

-- Creación de la tabla Módulo 

CREATE TABLE Modulo ( 

    ID_Modulo SERIAL PRIMARY KEY, 

    Nombre VARCHAR(255) NOT NULL, 

    Descripcion TEXT, 

    ID_Bootcamp INT NOT NULL, 

    FOREIGN KEY (ID_Bootcamp) REFERENCES Bootcamp (ID_Bootcamp) 

); 

  

-- Creación de la tabla Profesor 

CREATE TABLE Profesor ( 

    ID_Profesor SERIAL PRIMARY KEY, 

    Nombre VARCHAR(255) NOT NULL, 

    Apellido VARCHAR(255) NOT NULL, 

    Especialidad VARCHAR(255) 

); 

  

-- Creación de la tabla Inscripción 

CREATE TABLE Inscripcion ( 

    ID_Inscripcion SERIAL PRIMARY KEY, 

    ID_Alumno INT NOT NULL, 

    ID_Bootcamp INT NOT NULL, 

    Fecha_Inicio DATE NOT NULL, 

    Fecha_Fin DATE, 

    FOREIGN KEY (ID_Alumno) REFERENCES Alumno (ID_Alumno), 

    FOREIGN KEY (ID_Bootcamp) REFERENCES Bootcamp (ID_Bootcamp) 

); 

  

-- Creación de la tabla Asignación de Módulo 

CREATE TABLE Asignacion_Modulo ( 

    ID_Asignacion SERIAL PRIMARY KEY, 

    ID_Profesor INT NOT NULL, 

    ID_Modulo INT UNIQUE NOT NULL, 

    FOREIGN KEY (ID_Profesor) REFERENCES Profesor (ID_Profesor), 

    FOREIGN KEY (ID_Modulo) REFERENCES Modulo (ID_Modulo) 

); 