--Docente
INSERT INTO docente (ci, nombre, apellido, rif, correo, fecha_nacimiento, fecha_ingreso, direccion, estado_civil, tipo_docente, sexo)
select do.ci, do.nombre, do.apellido, do.rif, do.correo, do.fecha_nacimiento, do.fecha_ingreso, do.direccion, ec.descripcion, td.descripcion, sd.descripcion
from TRANS.docente do, trans.estado_civil ec, trans.tipo_docente td, trans.sexo sd
where do.id_sexo = sd.id_sexo and do.id_estado_civil = ec.id_estado_civil and do.id_tipo_docente = td.id_tipo_docente;

--Estudiante
INSERT INTO ESTUDIANTE
(ci, nombre, apellido, correo, direccion, fecha_nacimiento, fecha_ingreso, sexo)
SELECT e.ci, e.nombre, e.apellido, e.correo, e.direccion, e.fecha_nacimiento, e.fecha_ingreso, s.descripcion
FROM trans.estudiante e, trans.sexo s
WHERE e.id_sexo = s.id_sexo;

--Licenciatura
INSERT INTO licenciatura
(id_licenciatura, descripcion)
SELECT l.id_licenciatura, l.descripcion_lic
FROM trans.licenciatura l;

--Seccion
INSERT INTO seccion
(id_seccion, descripcion)
select s.id_seccion, s.descripcion_sec
from trans.seccion s;

--Semestre
INSERT into semestre
(id_semestre, anio, semestre)
select s.id_semestre, s.anio, s.semestre
from trans.semestre s;

--Materia
INSERT INTO materia
(cod_materia, nombre, id_licenciatura, tipo_materia, creditos)
select ma.cod_materia, ma.nombre, ma.id_licenciatura, tm.descripcion, ma.id_creditos
from trans.materia ma, trans.tipo_materia tm
where ma.id_tipo_materia = tm.id_tipo_materia;

--Inscribe
insert into inscribe
(ci_docente, id_seccion, id_semestre, cod_materia, ci_estudiante)
select doc.ci, ms.id_seccion, sm.id_semestre, mat.cod_materia, est.ci 
from trans.inscribe ins, trans.materia_seccion ms, trans.semestre_materia sm, trans.materia mat, trans.docente doc, trans.estudiante est 
where
ins.id_materia_seccion = ms.id_materia_seccion and
ins.id_semestre_materia = sm.id_semestre_materia and
ins.id_estudiante = est.id_estudiante and
ms.id_docente = doc.id_docente and
ms.id_semestre_materia = sm.id_semestre_materia and
sm.id_materia = mat.id_materia;

--Cursa
insert into cursa
(ci_estudiante, id_licenciatura, fecha_ingreso)
select distinct est.ci, cur.id_licenciatura, cur.fecha_ingreso
from trans.cursa cur, trans.estudiante est
where cur.id_estudiante = est.id_estudiante;

--Semestre-materia
insert into semestre_materia
(id_semestre, cod_materia)
select distinct sm.id_semestre, mat.cod_materia
from trans.semestre_materia sm, trans.materia mat
where sm.id_materia = mat.id_materia;

--Programa materia
insert into programa_materia
(id_programa_item, id_semestre, cod_materia, fecha, semana, clase, tema, descripcion)
select pm.id_programa_item, sm.id_semestre, mat.cod_materia, pm.fecha, pm.semana, pm.clase, pm.tema, pm.descripcion
from trans.programa_materia pm, trans.semestre_materia sm, trans.materia mat
where pm.id_semestre_materia = sm.id_semestre_materia and
sm.id_materia = mat.id_materia;

--Asistencia
insert into asistencia
(id_asistencia, id_programa_item, ci_docente, id_seccion, id_semestre, cod_materia, ci_estudiante, asistio)
select
asi.id_asistencia, asi.id_programa_item, doc.ci, ms.id_seccion, sm.id_semestre, mat.cod_materia, est.ci, asi.asistio
from trans.asistencia asi, trans.docente doc, trans.materia_seccion ms, trans.semestre_materia sm, trans.materia mat, trans.estudiante est, trans.inscribe ins
where
asi.id_inscribe = ins.id_inscribe and
ins.id_semestre_materia = sm.id_semestre_materia and
ins.id_materia_seccion = ms.id_materia_seccion and
ins.id_estudiante = est.id_estudiante and
ms.id_docente = doc.id_docente and
ms.id_semestre_materia  = sm.id_semestre_materia and
sm.id_materia = mat.id_materia;