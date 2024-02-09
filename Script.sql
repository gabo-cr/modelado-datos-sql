create schema if not exists videoclub;

set schema 'videoclub';

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
	cantidad integer not null,
	genero_id integer not null,
	director_id integer not null,
	constraint fk_genero_pelicula 
	foreign key (genero_id)
	references genero(id),
	constraint fk_director_pelicula
	foreign key (director_id)
	references director(id)
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
	pelicula_id integer not null,
	fecha_prestamo date not null,
	fecha_devolucion date,
	constraint fk_socio_prestamo
	foreign key (socio_id)
	references socio(id),
	constraint fk_pelicula_prestamo
	foreign key (pelicula_id)
	references pelicula(id)
);

ALTER TABLE genero ADD CONSTRAINT unique_nombre UNIQUE (nombre);
ALTER TABLE socio ADD CONSTRAINT unique_dni UNIQUE (dni);

