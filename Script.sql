--Creación del schema
create schema if not exists videoclub;

set schema 'videoclub';

--Creación de las tablas
CREATE TABLE IF NOT EXISTS genero(
	id bigserial primary key,
	nombre varchar(50) not null
);

CREATE TABLE IF NOT EXISTS director(
	id bigserial primary key,
	nombre varchar(50) not null,
	apellidos varchar(50) not null
);

CREATE TABLE IF NOT EXISTS pelicula(
	id bigserial primary key,
	titulo varchar(100) not null,
	anio_publicacion int not null,
	sinopsis varchar(500) not null,
	genero_id integer not null,
	director_id integer not null,
	constraint fk_genero_pelicula 
	foreign key (genero_id)
	references genero(id),
	constraint fk_director_pelicula
	foreign key (director_id)
	references director(id)
);

CREATE TABLE IF NOT EXISTS copia(
	id bigserial PRIMARY KEY,
	pelicula_id integer NOT NULL,
	CONSTRAINT fk_pelicula_copia 
	FOREIGN KEY (pelicula_id) 
	REFERENCES pelicula(id)
);

CREATE TABLE IF NOT EXISTS socio(
	id bigserial primary key,
	nombre varchar(50) not null,
	apellidos varchar(50) not null,
	fecha_nacimiento date not null,
	telefono varchar(20) not null,
	dni varchar(9) not null
);

CREATE TABLE IF NOT EXISTS direccion(
	id bigserial primary key,
	codigo_postal integer not null,
	calle varchar(50) not null,
	numero integer not null,
	piso integer not null,
	socio_id integer not null,
	constraint fk_socio_direccion
	foreign key (socio_id)
	references socio(id)
);

CREATE TABLE IF NOT EXISTS prestamo(
	id bigserial primary key,
	socio_id integer not null,
	copia_id integer not null,
	fecha_prestamo date not null,
	fecha_devolucion date,
	constraint fk_socio_prestamo
	foreign key (socio_id)
	references socio(id),
	constraint fk_copia_prestamo
	foreign key (copia_id)
	references copia(id)
);

--Chequeo para evitar datos incorrectos o duplicados
ALTER TABLE genero ADD CONSTRAINT unique_nombre UNIQUE (nombre);
ALTER TABLE socio ADD CONSTRAINT unique_dni UNIQUE (dni);
ALTER TABLE prestamo ADD CONSTRAINT check_dates CHECK (fecha_devolucion > fecha_prestamo);
ALTER TABLE pelicula ADD CONSTRAINT unique_pelicula_genero_director UNIQUE (titulo, director_id, genero_id);

--Inserción de datos
insert into genero (nombre) values('drama');
insert into genero (nombre) values('fantasía');
insert into genero (nombre) values('comedia');
insert into genero (nombre) values('acción');
insert into genero (nombre) values('documental');

insert into director (nombre, apellidos) values('John', 'Lee Hancock');
insert into director (nombre, apellidos) values('Maite', 'Alberdi');
insert into director (nombre, apellidos) values('Glen', 'Ficarra');
insert into director (nombre, apellidos) values('Peter', 'Jackson');
insert into director (nombre, apellidos) values('Antoine', 'Fuqua');

INSERT INTO pelicula (titulo, anio_publicacion, sinopsis, genero_id, director_id) VALUES('Blind Side', 2009, 'La historia de Michael Oher, un chico sin hogar traumatizado que se convertiría en un campeón del fútbol americano con la ayuda de una cariñosa mujer y su familia.', 1, 1);
INSERT INTO pelicula (titulo, anio_publicacion, sinopsis, genero_id, director_id) VALUES('The Mole Agent', 2020, 'Un investigador privado en Chile contrata a alguien para que trabaje como topo en una residencia de ancianos en la que un cliente suyo sospecha que los cuidadores están abusando de los ancianos.', 5, 2);
INSERT INTO pelicula (titulo, anio_publicacion, sinopsis, genero_id, director_id) VALUES('The Founder', 2016, 'La historia de Ray Kroc, un vendedor que convirtió el restaurante de comida rápida de los hermanos McDonalds, en el negocio de restaurantes más grande del mundo, con una combinación de ambición, persistencia y crueldad.', 1, 1);
INSERT INTO pelicula (titulo, anio_publicacion, sinopsis, genero_id, director_id) VALUES('Crazy, Stupid, Love', 2011, 'La vida de un hombre casado cambia dramáticamente cuando su esposa le pide el divorcio. Mientras esto ocurre, busca redescubrir su virilidad con la ayuda de un nuevo amigo Jacob.', 3, 3);
INSERT INTO pelicula (titulo, anio_publicacion, sinopsis, genero_id, director_id) VALUES('Lord of the Rings: The Fellowship of the Ring', 2001, 'Un Hobbit y ocho compañeros emprendieron un viaje para destruir el poderoso Anillo Único y salvar a la Tierra del Señor Oscuro Sauron.', 2, 4);
INSERT INTO pelicula (titulo, anio_publicacion, sinopsis, genero_id, director_id) VALUES('Lord of the Rings: The Two Towers', 2002, 'Mientras Frodo y Sam se acercan más a Mordor con la ayuda del cambiante Gollum, la comunidad dividida se opone al nuevo aliado de Sauron, Saruman, y sus hordas de Isengard.', 2, 4);
INSERT INTO pelicula (titulo, anio_publicacion, sinopsis, genero_id, director_id) VALUES('Lord of the Rings: The Return of the King', 2003, 'Gandalf y Aragorn lideran el Mundo de los hombres, e intentarán atraer la atención de Sauron para darle a Frodo la última oportunidad de completar su misión y así tratar de evitar sucumbir a las continuas tentaciones del Anillo.', 2, 4);
INSERT INTO pelicula (titulo, anio_publicacion, sinopsis, genero_id, director_id) VALUES('The Equalizer', 2014, 'Un hombre cree que ha dejado su misterioso pasado atrás y que puede llevar una nueva vida en paz. Pero cuando conoce a una joven bajo el control de gánsteres rusos ultra-violentos, no puede quedarse de brazos cruzados.', 4, 5);
INSERT INTO pelicula (titulo, anio_publicacion, sinopsis, genero_id, director_id) VALUES('The Guilty', 2021, 'Un oficial de policía degradado y asignado a un despacho de llamadas, entra en conflicto cuando recibe una llamada telefónica de emergencia de una mujer secuestrada.', 1, 5);
INSERT INTO pelicula (titulo, anio_publicacion, sinopsis, genero_id, director_id) VALUES('Olympus Has Fallen', 2013, 'El desacreditado agente del Servicio Secreto Mike Banning se encuentra atrapado en la Casa Blanca después de un ataque terrorista; usando sus conocimientos, trabaja con la seguridad nacional para rescatar al Presidente de sus secuestradores.', 4, 5);

INSERT INTO copia (pelicula_id) VALUES (1);
INSERT INTO copia (pelicula_id) VALUES (1);
INSERT INTO copia (pelicula_id) VALUES (1);
INSERT INTO copia (pelicula_id) VALUES (1);
INSERT INTO copia (pelicula_id) VALUES (1);
INSERT INTO copia (pelicula_id) VALUES (1);
INSERT INTO copia (pelicula_id) VALUES (2);
INSERT INTO copia (pelicula_id) VALUES (2);
INSERT INTO copia (pelicula_id) VALUES (3);
INSERT INTO copia (pelicula_id) VALUES (3);
INSERT INTO copia (pelicula_id) VALUES (3);
INSERT INTO copia (pelicula_id) VALUES (4);
INSERT INTO copia (pelicula_id) VALUES (4);
INSERT INTO copia (pelicula_id) VALUES (4);
INSERT INTO copia (pelicula_id) VALUES (4);
INSERT INTO copia (pelicula_id) VALUES (4);
INSERT INTO copia (pelicula_id) VALUES (4);
INSERT INTO copia (pelicula_id) VALUES (4);
INSERT INTO copia (pelicula_id) VALUES (4);
INSERT INTO copia (pelicula_id) VALUES (5);
INSERT INTO copia (pelicula_id) VALUES (5);
INSERT INTO copia (pelicula_id) VALUES (5);
INSERT INTO copia (pelicula_id) VALUES (5);
INSERT INTO copia (pelicula_id) VALUES (5);
INSERT INTO copia (pelicula_id) VALUES (5);
INSERT INTO copia (pelicula_id) VALUES (5);
INSERT INTO copia (pelicula_id) VALUES (6);
INSERT INTO copia (pelicula_id) VALUES (6);
INSERT INTO copia (pelicula_id) VALUES (6);
INSERT INTO copia (pelicula_id) VALUES (6);
INSERT INTO copia (pelicula_id) VALUES (6);
INSERT INTO copia (pelicula_id) VALUES (6);
INSERT INTO copia (pelicula_id) VALUES (6);
INSERT INTO copia (pelicula_id) VALUES (7);
INSERT INTO copia (pelicula_id) VALUES (7);
INSERT INTO copia (pelicula_id) VALUES (7);
INSERT INTO copia (pelicula_id) VALUES (7);
INSERT INTO copia (pelicula_id) VALUES (7);
INSERT INTO copia (pelicula_id) VALUES (7);
INSERT INTO copia (pelicula_id) VALUES (7);
INSERT INTO copia (pelicula_id) VALUES (7);
INSERT INTO copia (pelicula_id) VALUES (7);
INSERT INTO copia (pelicula_id) VALUES (7);
INSERT INTO copia (pelicula_id) VALUES (7);
INSERT INTO copia (pelicula_id) VALUES (8);
INSERT INTO copia (pelicula_id) VALUES (8);
INSERT INTO copia (pelicula_id) VALUES (8);
INSERT INTO copia (pelicula_id) VALUES (8);
INSERT INTO copia (pelicula_id) VALUES (8);
INSERT INTO copia (pelicula_id) VALUES (9);
INSERT INTO copia (pelicula_id) VALUES (9);
INSERT INTO copia (pelicula_id) VALUES (10);
INSERT INTO copia (pelicula_id) VALUES (10);
INSERT INTO copia (pelicula_id) VALUES (10);
INSERT INTO copia (pelicula_id) VALUES (10);
INSERT INTO copia (pelicula_id) VALUES (10);
INSERT INTO copia (pelicula_id) VALUES (10);
INSERT INTO copia (pelicula_id) VALUES (10);
INSERT INTO copia (pelicula_id) VALUES (10);
INSERT INTO copia (pelicula_id) VALUES (10);
INSERT INTO copia (pelicula_id) VALUES (10);

insert into socio (nombre, apellidos, fecha_nacimiento, telefono, dni) values('Gabriel', 'Chávez', '1990-05-15', '+50401020304', '01234567A');
insert into socio (nombre, apellidos, fecha_nacimiento, telefono, dni) values('Claudia', 'Pérez', '1994-08-25', '+50401020304', '01234567B');
insert into socio (nombre, apellidos, fecha_nacimiento, telefono, dni) values('Antonia', 'García', '1986-12-05', '+50401020304', '01234567C');

insert into prestamo (socio_id, copia_id, fecha_prestamo, fecha_devolucion) values(1, 52, '2024-01-10', '2024-01-15');
insert into prestamo (socio_id, copia_id, fecha_prestamo, fecha_devolucion) values(1, 20, '2024-01-11', '2024-01-15');
insert into prestamo (socio_id, copia_id, fecha_prestamo, fecha_devolucion) values(1, 1, '2024-01-12', '2024-01-15');
insert into prestamo (socio_id, copia_id, fecha_prestamo, fecha_devolucion) values(1, 7, '2024-02-01', '2024-02-08');
insert into prestamo (socio_id, copia_id, fecha_prestamo, fecha_devolucion) values(1, 50, '2024-02-02', null);
insert into prestamo (socio_id, copia_id, fecha_prestamo, fecha_devolucion) values(2, 9, '2024-01-22', '2024-01-24');
insert into prestamo (socio_id, copia_id, fecha_prestamo, fecha_devolucion) values(2, 12, '2024-01-23', '2024-01-24');
insert into prestamo (socio_id, copia_id, fecha_prestamo, fecha_devolucion) values(2, 1, '2024-01-23', '2024-01-24');
insert into prestamo (socio_id, copia_id, fecha_prestamo, fecha_devolucion) values(2, 51, '2024-02-02', null);
insert into prestamo (socio_id, copia_id, fecha_prestamo, fecha_devolucion) values(3, 20, '2024-01-24', '2024-01-28');
insert into prestamo (socio_id, copia_id, fecha_prestamo, fecha_devolucion) values(3, 27, '2024-01-24', '2024-01-28');
insert into prestamo (socio_id, copia_id, fecha_prestamo, fecha_devolucion) values(3, 34, '2024-01-24', '2024-01-28');
insert into prestamo (socio_id, copia_id, fecha_prestamo, fecha_devolucion) values(3, 45, '2024-02-05', null);


/*
 * Query 1
 * Películas disponibles para alquilar en este momento (no están prestadas).
 * Muestra el título de la película y el número de copias disponibles.
 * */
select pe.titulo, count(c.id) copias_disponibles from pelicula pe
inner join copia c on pe.id = c.pelicula_id 
left join prestamo pr on c.id = pr.copia_id and pr.fecha_prestamo is not null and pr.fecha_devolucion is null
where pr.id is null
group by pe.titulo;

/*
 * Query 2
 * Cuál es el género favorito de cada uno de mis socios.
 * Muestra el número y el nombre del socio, y el género favorito.
 * */
-- Opción 1: muestra todos los géneros vistos por cada socio, junto con la cantidad de visualizaciones de ese género.
select s.id as numero_socio, s.nombre, s.apellidos, g.nombre as genero, count(g.*) as genero_vistas
from socio s
inner join prestamo pr on pr.socio_id = s.id
inner join copia co on pr.copia_id = co.id
inner join pelicula pe on pe.id = co.pelicula_id
inner join genero g on g.id = pe.genero_id
group by s.id, s.nombre, g.nombre
order by s.id, count(g.*) desc;

--Opción 2: muestra únicamente el género más visto por cada socio.
with ranking as (
	select s.id as numero_socio, s.nombre, s.apellidos, g.nombre as genero_favorito, 
		count(g.*) as genero_vistas, 
		row_number() over (partition by s.id order by count(pr.copia_id) desc) as genero_ranking
	from socio s
	inner join prestamo pr on pr.socio_id = s.id
	inner join copia co on co.id = pr.copia_id
	inner join pelicula pe on pe.id = co.pelicula_id
	inner join genero g on g.id = pe.genero_id
	group by s.id, s.nombre, g.nombre
)
select numero_socio, nombre, apellidos, genero_favorito
from ranking
where genero_ranking = 1;
