CREATE TABLE ESTADO_CIVIL(
	ID_ESTADO_CIVIL NUMBER,
	DESCRIPCION VARCHAR(500),
	CONSTRAINT ESTADO_CIVIL_PK PRIMARY KEY(ID_ESTADO_CIVIL)
);

CREATE TABLE SEXO(
	ID_SEXO NUMBER,
	DESCRIPCION VARCHAR(500),
	CONSTRAINT SEXO_PK PRIMARY KEY(ID_SEXO)
);

CREATE TABLE CREDITOS(
	ID_CREDITOS NUMBER,
	DESCRIPCION VARCHAR(510),
	HORAS_TEORIA NUMBER,
	HORAS_PRACTICA NUMBER,
	HORAS_LABORATORIO NUMBER,
	CONSTRAINT CREDITOS_PK PRIMARY KEY(ID_CREDITOS)
);

CREATE TABLE TIPO_MATERIA(
	ID_TIPO_MATERIA NUMBER,
	DESCRIPCION VARCHAR(510),
	CONSTRAINT TIPO_MAT_PK PRIMARY KEY(ID_TIPO_MATERIA)
);

CREATE TABLE TIPO_DOCENTE(
	ID_TIPO_DOCENTE NUMBER,
	DESCRIPCION VARCHAR(510),
	CONSTRAINT TIPO_DOC_PK PRIMARY KEY(ID_TIPO_DOCENTE)
);

CREATE TABLE SEMESTRE(
	ID_SEMESTRE NUMBER,
	ANIO NUMBER,
	SEMESTRE NUMBER,
	CONSTRAINT SEMESTRE_PK PRIMARY KEY (ID_SEMESTRE)
);

CREATE TABLE SECCION(
	ID_SECCION NUMBER,
	DESCRIPCION_SEC VARCHAR(4),
	CONSTRAINT SECCION_PK PRIMARY KEY (ID_SECCION)
);

CREATE TABLE LICENCIATURA(
	ID_LICENCIATURA NUMBER,
	DESCRIPCION_LIC VARCHAR(510),
	CONSTRAINT LICENCIATURA_PK PRIMARY KEY(ID_LICENCIATURA)
);

CREATE TABLE ESTUDIANTE(
	ID_ESTUDIANTE NUMBER,
	CI NUMBER,
	NOMBRE VARCHAR(500),
	APELLIDO VARCHAR(500),
	CORREO VARCHAR(500),
	DIRECCION VARCHAR(500),
	FECHA_NACIMIENTO DATE,
	FECHA_INGRESO DATE,
	ID_SEXO NUMBER,
	CONSTRAINT ESTUDIANTE_PK PRIMARY KEY(ID_ESTUDIANTE),
	CONSTRAINT SEXO_EST_FK FOREIGN KEY(ID_SEXO) REFERENCES SEXO(ID_SEXO)
);

CREATE TABLE DOCENTE(
	ID_DOCENTE NUMBER,
    CI NUMBER,
	NOMBRE VARCHAR(500),
	APELLIDO VARCHAR(500),
	RIF VARCHAR(500),
	CORREO VARCHAR(500),
	FECHA_NACIMIENTO DATE,
	FECHA_INGRESO DATE,
	DIRECCION VARCHAR(500),
	ID_SEXO NUMBER,
	ID_ESTADO_CIVIL NUMBER,
	ID_TIPO_DOCENTE NUMBER,
	CONSTRAINT DOCENTE_PK PRIMARY KEY(ID_DOCENTE),
	CONSTRAINT EC_PROF_FK FOREIGN KEY(ID_ESTADO_CIVIL) REFERENCES ESTADO_CIVIL(ID_ESTADO_CIVIL),
	CONSTRAINT SEXO_PROF_FK FOREIGN KEY(ID_SEXO) REFERENCES SEXO(ID_SEXO),
	CONSTRAINT TIPO_PROF_FK FOREIGN KEY(ID_TIPO_DOCENTE) REFERENCES TIPO_DOCENTE(ID_TIPO_DOCENTE)
);

CREATE TABLE MATERIA(
	ID_MATERIA NUMBER,
	COD_MATERIA NUMBER,
	NOMBRE VARCHAR(500),
	ID_LICENCIATURA NUMBER,
	ID_TIPO_MATERIA NUMBER,
	ID_CREDITOS NUMBER,
	CONSTRAINT MATERIA_PK PRIMARY KEY(ID_MATERIA),
	CONSTRAINT LIC_FK FOREIGN KEY(ID_LICENCIATURA) REFERENCES LICENCIATURA(ID_LICENCIATURA),
	CONSTRAINT TIPO_FK FOREIGN KEY(ID_TIPO_MATERIA) REFERENCES TIPO_MATERIA(ID_TIPO_MATERIA),
	CONSTRAINT CREDITOS_FK FOREIGN KEY(ID_CREDITOS) REFERENCES CREDITOS(ID_CREDITOS)
);

CREATE TABLE PRELACION(
	ID_MATERIA NUMBER,
	ID_MATERIA2 NUMBER,
	CONSTRAINT M1_FK FOREIGN KEY(ID_MATERIA) REFERENCES MATERIA(ID_MATERIA),
	CONSTRAINT M2_FK FOREIGN KEY(ID_MATERIA2) REFERENCES MATERIA(ID_MATERIA)
);

CREATE TABLE CURSA(
	ID_ESTUDIANTE NUMBER,
	ID_LICENCIATURA NUMBER,
	FECHA_INGRESO DATE,
	CONSTRAINT ESTUD_FK FOREIGN KEY(ID_ESTUDIANTE) REFERENCES ESTUDIANTE(ID_ESTUDIANTE),
	CONSTRAINT LICEN_FK FOREIGN KEY(ID_LICENCIATURA) REFERENCES LICENCIATURA(ID_LICENCIATURA)
);

CREATE TABLE SEMESTRE_MATERIA(
	ID_SEMESTRE_MATERIA NUMBER,
	ID_SEMESTRE NUMBER,
	ID_MATERIA NUMBER,
	CONSTRAINT SEMESTRE_ID_FK FOREIGN KEY(ID_SEMESTRE) REFERENCES SEMESTRE(ID_SEMESTRE),
	CONSTRAINT MATERIA_ID_FK FOREIGN KEY(ID_MATERIA) REFERENCES MATERIA(ID_MATERIA),
	CONSTRAINT SEMESTRE_MATERIA_ID_PK PRIMARY KEY(ID_SEMESTRE_MATERIA)
);

CREATE TABLE PROGRAMA_MATERIA(
	ID_PROGRAMA_ITEM NUMBER,
	ID_SEMESTRE_MATERIA NUMBER,
	FECHA DATE,
	SEMANA NUMBER,
	CLASE NUMBER,
	TEMA VARCHAR(500),
	DESCRIPCION VARCHAR (500),
	CONSTRAINT SEMESTRE_MATERIA_ID2_FK FOREIGN KEY(ID_SEMESTRE_MATERIA) REFERENCES SEMESTRE_MATERIA(ID_SEMESTRE_MATERIA),
	CONSTRAINT PROGRAMA_ITEM_ID_PK PRIMARY KEY(ID_PROGRAMA_ITEM)
);

CREATE TABLE MATERIA_SECCION(
	ID_MATERIA_SECCION NUMBER,
	ID_DOCENTE NUMBER,
	ID_SECCION NUMBER,
	ID_SEMESTRE_MATERIA NUMBER,
	CONSTRAINT MATERIA_SECCION_ID_PK PRIMARY KEY(ID_MATERIA_SECCION),
	CONSTRAINT DOCENTE_ID_FK FOREIGN KEY(ID_DOCENTE) REFERENCES DOCENTE(ID_DOCENTE),
	CONSTRAINT SECCION_ID_FK FOREIGN KEY(ID_SECCION) REFERENCES SECCION(ID_SECCION),
	CONSTRAINT SEMESTRE_MATERIA_ID_FK FOREIGN KEY(ID_SEMESTRE_MATERIA) REFERENCES SEMESTRE_MATERIA(ID_SEMESTRE_MATERIA)
);

CREATE TABLE INSCRIBE(
	ID_INSCRIBE NUMBER,
	ID_SEMESTRE_MATERIA NUMBER,
	ID_MATERIA_SECCION NUMBER,
	ID_ESTUDIANTE NUMBER,
	CONSTRAINT SEMESTRE_MAT_ID_FK FOREIGN KEY(ID_SEMESTRE_MATERIA) REFERENCES SEMESTRE_MATERIA(ID_SEMESTRE_MATERIA),
	CONSTRAINT MATERIA_SECN_ID_FK FOREIGN KEY(ID_MATERIA_SECCION) REFERENCES MATERIA_SECCION(ID_MATERIA_SECCION),
	CONSTRAINT ESTUD_ID_FK FOREIGN KEY(ID_ESTUDIANTE) REFERENCES ESTUDIANTE(ID_ESTUDIANTE),
	CONSTRAINT INSCRIBE_ID_PK PRIMARY KEY(ID_INSCRIBE)
);

CREATE TABLE ASISTENCIA(
	ID_ASISTENCIA NUMBER,
	ID_PROGRAMA_ITEM NUMBER,
	ID_INSCRIBE NUMBER,
	ID_ESTUDIANTE NUMBER,
	ASISTIO NUMBER,
	CONSTRAINT ASISTENCIA_PK PRIMARY KEY(ID_ASISTENCIA),
	CONSTRAINT PROGRAMA_ITEM_ID_FK FOREIGN KEY(ID_PROGRAMA_ITEM) REFERENCES PROGRAMA_MATERIA(ID_PROGRAMA_ITEM),
	CONSTRAINT INSCRIBE_FK FOREIGN KEY (ID_INSCRIBE) REFERENCES INSCRIBE(ID_INSCRIBE),
	CONSTRAINT ESTD_ID4_FK FOREIGN KEY(ID_ESTUDIANTE) REFERENCES ESTUDIANTE(ID_ESTUDIANTE)
);
