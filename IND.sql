/* - preguntar acerca de dominios: create type, enum o domain
- hay problema con cambiar mr un poco, ej regioones de varchar a un dominio
- una correcion era sobre entidades en plural en mer, es necesario que entidades sean en singular en tablas
- sobre el usuario al que le pertenece las tablas, hay un problema si se deja public en vez de crearlo con un usuario dueño
el pgadmin lo hace siempre con el usuario default

- preguntar acerca de necesidad de xamp(no me aparece postgresql en la lista) y como se compila php/ como funciona para mostrarse con html???
php.ini
descomentar pgsql 
*/
-- Dominios

	-- Sector protectosdeportivos: Privado, Publico
	    CREATE DOMAIN Sector as varchar(15)
       	    check(value in('Privado','Publico'));
	-- Categoria proyectos deportivos: Deporte de Competición, Formacion para el deporte, Deporte Recreativo, Ciencias del deporte
	    CREATE DOMAIN Categoria as text
	    check(VALUE in
	    ( 'Deporte de Competicion', 'Formacion para el deporte', 'Deporte Recreativo', 'Ciencias del deporte'));
	-- estado_actual recinto deportivo:{Arrendada, Propia, En comodato, otra situacion}

	    CREATE DOMAIN estado_actual as text
	    check(VALUE in(
		'Arrendada', 'Propia', 'En comodato', 'otra situacion'
	    ));
	-- tipo_recinti Recinto deportivo {Cancha futbol de tierra, Cancha futbol de pasto, multicancha cubierta, multicancha techada, gimnasio municipal, otros}
	CREATE DOMAIN tipo_recinto as text
	check(VALUE in(
	'Cancha futbol de tierra', 'Cancha futbol de pasto', 'multicancha cubierta', 'multicancha techada', 'gimnasio municipal', 'otros'
	));
	-- tipo_de_organizacion Organizacion deportiva superior: {Asociación, Liga, Federación, Federación Nacional }
	CREATE DOMAIN tipo_de_organizacion as text
	check(VALUE in(
	'Asociación', 'Liga', 'Federación', 'Federación Nacional '
	));
	--cargo Directorio: {Presidente, Vicepresidente, Secretario, Tesorero, Director}
	CREATE DOMAIN cargo as text
	check(VALUE in(
	'Presidente', 'Vicepresidente', 'Secretario', 'Tesorero', 'Director'
	));

--tablas
    CREATE TABLE IF NOT EXISTS public.patrimonio(
        codigo int2 NOT NULL,
        inversion float8 NOT NULL,
        direccion varchar(100) NOT NULL,
        terreno_construido float8 NOT NULL,
        administrador varchar(40),
	direccion_regional smallint NOT NULL,
        capacidad_maxima integer,
        contacto integer,
        CONSTRAINT patrimonio_pk PRIMARY KEY(codigo));
    CREATE TABLE IF NOT EXISTS public.direccion_regional(
	id smallint NOT NULL,
        region smallint NOT NULL,
        direccion varchar(100) NOT NULL,
        telefono integer NOT NULL,
        --PK
        CONSTRAINT direccion_regional_pk PRIMARY KEY (id));

    CREATE TABLE IF NOT EXISTS public.region(
	id smallint NOT NULL, -- 1-15
	nombre text NOT NULL, --('Arica y Parinacota', 'Tarapacá', 'Antofagasta', 'Atacama', 'Coquimbo', 'Valparaíso', 'Metropolitana', 'Libertador General Bernardo O’Higgins', 'Maule', 'Ñuble', 'Biobío', 'La Araucanía', 'Los Ríos', 'Los Lagos', 'Aysén', 'Magallanes y de la Antártica Chilena')
	--pk
        CONSTRAINT region_pk PRIMARY KEY (id));
    CREATE TABLE IF NOT EXISTS public.noticia(
        id integer NOT NULL,
        titulo varchar(50) NOT NULL,
        cuerpo text NOT NULL,
        fecha date NOT NULL,
        autor varchar(40),
	direccion_regional smallint NOT NULL,
        --pk
        CONSTRAINT noticia_pk  PRIMARY KEY(id));
    CREATE TABLE IF NOT EXISTS public.empleado(
        rut integer NOT NULL,
	nombre text NOT NULL,
        telefono integer NOT NULL,
        correo varchar(320) NOT NULL,
        id_area integer NOT NULL,
	direccion_regional smallint NOT NULL,
        --pk
        CONSTRAINT empleado_pk PRIMARY KEY(rut));
    CREATE TABLE IF NOT EXISTS public.area(
        id integer NOT NULL,
        nombre varchar(40) NOT NULL,
        --pk
        CONSTRAINT area_pk PRIMARY KEY(id));
    CREATE TABLE IF NOT EXISTS public.supervisa(
        rut_empleado integer NOT NULL,
        id_programas_deporte integer NOT NULL,
        --pk
        CONSTRAINT supervisa_pk1 PRIMARY KEY(rut_empleado));
    CREATE TABLE IF NOT EXISTS public.programa_deporte(
        id integer NOT NULL,
        nombre varchar(40) NOT NULL,
        descripcion text NOT NULL,
        --pk
        CONSTRAINT pdeporte_pk  PRIMARY KEY(id));
    CREATE TABLE IF NOT EXISTS public.beneficia(
        id_programas_deporte integer NOT NULL,
        rut_deportista integer NOT NULL,
        --pk
        CONSTRAINT beneficia_pk1 PRIMARY KEY(id_programas_deporte));
    CREATE TABLE IF NOT EXISTS public.deportista(
        rut integer NOT NULL,
        nombre varchar(20) NOT NULL,
        paterno varchar(20) NOT NULL,
        materno varchar(20) NOT NULL,
        region smallint NOT NULL,
    
        CONSTRAINT deportista_pk  PRIMARY KEY(rut));
    CREATE TABLE IF NOT EXISTS public.realiza(
        rut_deportista integer NOT NULL,
        id_deporte integer NOT NULL,
        --pk
        CONSTRAINT reliza_pk1  PRIMARY KEY(rut_deportista));
    CREATE TABLE IF NOT EXISTS public.deporte(
        id integer NOT NULL,
        nombre varchar(40) NOT NULL,
    
        CONSTRAINT deporte_pk PRIMARY KEY(id));
    CREATE TABLE IF NOT EXISTS public.inscribir(
        rut_deportista integer NOT NULL,
        rut_organizacion integer NOT NULL,
        --pk
        CONSTRAINT ins_pk1  PRIMARY KEY(rut_deportista));
    CREATE TABLE IF NOT EXISTS public.organizacion(
        rut integer NOT NULL,
        nombre varchar(40) NOT NULL,
        direccion varchar(100) NOT NULL,
        --pk
        CONSTRAINT org_pk PRIMARY KEY(rut));
    CREATE TABLE IF NOT EXISTS public.asociacion_externa(
        rut_organizacion integer NOT NULL,
        --pk
        CONSTRAINT ext_pk PRIMARY KEY(rut_organizacion));
    CREATE TABLE IF NOT EXISTS public.concedido(
        rut_organizacion integer NOT NULL,
        codigo_proyecto_deportivo integer NOT NULL,
        --pk
        CONSTRAINT concedido_pk1 PRIMARY KEY(rut_organizacion));
    CREATE TABLE IF NOT EXISTS public.proyecto_deportivo(
        codigo integer NOT NULL,
        sector Sector NOT NULL, --dominio
	categoria Categoria NOT NULL, --dominio
        nombre varchar(40) NOT NULL,
        fecha_postulacion date NOT NULL,
        hora_postulacion varchar(40) NOT NULL,
        aporte_ind float8 NOT NULL,
        aporte_propio float8 NOT NULL,
        puntaje integer NOT NULL,
        --pk
        CONSTRAINT pdep_pk PRIMARY KEY(codigo));
    CREATE TABLE IF NOT EXISTS public.donacion(
        codigo integer NOT NULL,
        region_postulacion smallint NOT NULL,
        organizacion_dona integer NOT NULL,
        monto float8 NOT NULL,
        codigo_proyecto_deportivo integer NOT NULL,
        --pk
        CONSTRAINT donacion_pk PRIMARY KEY(codigo));
    CREATE TABLE IF NOT EXISTS public.organizacion_deportiva(
        rut_organizacion integer NOT NULL,
        es_profesional boolean NOT NULL,
        email varchar(320) NOT NULL,
        region smallint NOT NULL, 
        comuna varchar(20) NOT NULL,
        fono integer NOT NULL,
        id_recinto_deportivo integer NOT NULL,
        --pk
        CONSTRAINT org_dep_pk PRIMARY KEY(rut_organizacion));
    CREATE TABLE IF NOT EXISTS public.practica(
        rut_organizacion integer NOT NULL,
        id_deporte integer NOT NULL,
        --pk
        CONSTRAINT practica_pk1 PRIMARY KEY(rut_organizacion));
    CREATE TABLE IF NOT EXISTS public.recinto_deportivo(
        id integer NOT NULL,
        estado estado_actual NOT NULL, --dominio
        otro_estado varchar(20) NOT NULL,
        recinto tipo_recinto NOT NULL, --dominio tiporecinto
        otro_tipo_recinto varchar(20) NOT NULL,
        --pk
        CONSTRAINT recinto_pk PRIMARY KEY(id));
    CREATE TABLE IF NOT EXISTS public.miembro(
        rut integer NOT NULL,
        rut_organizacion integer NOT NULL,
        nombre varchar(40) NOT NULL,
        direccion varchar(100) NOT NULL,
        comuna varchar(20) NOT NULL,
        region smallint NOT NULL, 
        numero_contacto integer NOT NULL,
        email varchar(320) NOT NULL,
        --pk
        CONSTRAINT miembro_pk PRIMARY KEY(rut));
    CREATE TABLE IF NOT EXISTS public.club(
        rut_organizacion integer NOT NULL,
        --pk
        CONSTRAINT club_pk PRIMARY KEY(rut_organizacion));
    CREATE TABLE IF NOT EXISTS public.compone(
        rut_club integer NOT NULL,
        rut_organizacion_superior integer NOT NULL,
        --pk
        CONSTRAINT compone_pk1 PRIMARY KEY(rut_club));
    CREATE TABLE IF NOT EXISTS public.organizacion_deportiva_superior(
        rut_organizacion integer NOT NULL,
        tipo_de_organizacion tipo_de_organizacion NOT NULL, --dominio
        --pk
        CONSTRAINT org_dep_sup_pk PRIMARY KEY(rut_organizacion));
    CREATE TABLE IF NOT EXISTS public.directorio(
        rut_miembro integer NOT NULL,
        cargo Cargo NOT NULL, --dominio
        anio_ingreso int2 NOT NULL,
        escolaridad varchar(40) NOT NULL,
        --pk
        CONSTRAINT directorio_pk PRIMARY KEY(rut_miembro));
    CREATE TABLE IF NOT EXISTS public.representante_legal(
        rut_miembro integer NOT NULL,
        fecha_de_nombramiento date NOT NULL,
        documento_de_nombramiento text NOT NULL,
        cargo varchar(30) NOT NULL,
        --pk
        CONSTRAINT rlegal_pk PRIMARY KEY(rut_miembro));

--llaves foraneas
    --fk patrimonio
    ALTER TABLE patrimonio ADD CONSTRAINT direccion_regional_patrimonio_fk FOREIGN KEY (direccion_regional) REFERENCES public.direccion_regional(id);    --patrimonio - direccion_regional
    --FK direccion regional
    ALTER TABLE direccion_regional ADD CONSTRAINT direccion_regional_region_fk FOREIGN KEY (region) REFERENCES public.region(id);--direccion regional - region
    --fk noticia
    ALTER TABLE noticia ADD CONSTRAINT direccion_regional_noticia_fk FOREIGN KEY (direccion_regional) REFERENCES public.direccion_regional(id);--Noticia - direccion regional
    --fk empleado
    ALTER TABLE empleado ADD CONSTRAINT empleado_area_fk FOREIGN KEY (id_area) REFERENCES public.area(id);--Empleado - Area
    ALTER TABLE empleado ADD CONSTRAINT direccion_regional_empleado_fk FOREIGN KEY (direccion_regional) REFERENCES public.direccion_regional(id);--Empleado - direccion regional
    --fk supervisa
    ALTER TABLE supervisa ADD CONSTRAINT supervisa_empleado_fk FOREIGN KEY (rut_empleado) REFERENCES public.empleado(rut) ON DELETE CASCADE;--Empleado - supervisa
    ALTER TABLE supervisa ADD CONSTRAINT supervisa_programadeporte_fk  FOREIGN KEY (id_programas_deporte) REFERENCES public.programa_deporte(id);-- Progrma deporte - supervisa
    --fk beneficia
    ALTER TABLE beneficia ADD CONSTRAINT beneficia_fk1 FOREIGN KEY (id_programas_deporte) REFERENCES public.programa_deporte(id);-- Programa deporte - beneficia
    ALTER TABLE beneficia ADD CONSTRAINT beneficia_fk2 FOREIGN KEY (rut_deportista) REFERENCES public.deportista(rut);-- Beneficia - deportista
    --fk realiza
    ALTER TABLE realiza ADD CONSTRAINT realiza_fk1  FOREIGN KEY (rut_deportista) REFERENCES public.deportista(rut);-- Realiza - deportista
    ALTER TABLE realiza ADD CONSTRAINT realiza_fk2  FOREIGN KEY (id_deporte) REFERENCES public.deporte(id);-- realiza - deporte
    --fk donacion
    ALTER TABLE donacion ADD CONSTRAINT donacion_fk1 FOREIGN KEY (organizacion_dona) REFERENCES public.organizacion(rut);--organizacion - donacion
    ALTER TABLE donacion ADD CONSTRAINT donacion_fk2 FOREIGN KEY (codigo_proyecto_deportivo) REFERENCES public.proyecto_deportivo(codigo);-- donacion -- proyecto deportivo
    ALTER TABLE donacion ADD CONSTRAINT donacion_fk3 FOREIGN KEY (region_postulacion) REFERENCES public.region(id);-- Donacion -- region
    --fk organizacion_deportiva
    ALTER TABLE organizacion_deportiva ADD CONSTRAINT org_dep_fk1  FOREIGN KEY (rut_organizacion) REFERENCES public.organizacion(rut);-- organizacion - org deportiva
    ALTER TABLE organizacion_deportiva ADD CONSTRAINT org_dep_fk2  FOREIGN KEY (id_recinto_deportivo) REFERENCES public.recinto_deportivo(id);-- org deportiva - recinto dep
    ALTER TABLE organizacion_deportiva ADD CONSTRAINT org_dep_fk3 FOREIGN KEY (region) REFERENCES public.region(id);-- org deportiva - region
    --fk inscribir
    ALTER TABLE inscribir ADD CONSTRAINT ins_dep_fk  FOREIGN KEY (rut_deportista) REFERENCES public.deportista(rut);-- Inscribir - Deportista
    ALTER TABLE inscribir ADD CONSTRAINT ins_org_fk  FOREIGN KEY (rut_organizacion) REFERENCES public.organizacion_deportiva(rut_organizacion);-- Inscribir - org deportiva
    --fk asociacion_externa
    ALTER TABLE asociacion_externa ADD CONSTRAINT ext_fk FOREIGN KEY (rut_organizacion) REFERENCES public.organizacion(rut);-- organizacion - asociacion externa
    --fk concedido
    ALTER TABLE concedido ADD CONSTRAINT concedido_fk1 FOREIGN KEY (rut_organizacion) REFERENCES public.organizacion(rut);-- Concedido - Organizacion
    ALTER TABLE concedido ADD CONSTRAINT concedido_fk2 FOREIGN KEY (codigo_proyecto_deportivo) REFERENCES public.proyecto_deportivo(codigo);-- Concedido - proyecto deportivo
    --fk compone
    ALTER TABLE compone ADD CONSTRAINT compone_fk1 FOREIGN KEY (rut_club) REFERENCES public.club(rut_organizacion);-- compone - club
    ALTER TABLE compone ADD CONSTRAINT compone_fk2 FOREIGN KEY (rut_organizacion_superior) REFERENCES public.organizacion_deportiva_superior(rut_organizacion);-- compone - org dep superior
    --fk practica
    ALTER TABLE practica ADD CONSTRAINT practica_fk1 FOREIGN KEY (rut_organizacion) REFERENCES public.organizacion_deportiva(rut_organizacion);-- practica - orga deportiva
    ALTER TABLE practica ADD CONSTRAINT practica_fk2 FOREIGN KEY (id_deporte) REFERENCES public.deporte(id);-- practica - deporte
    --fk miembro
    ALTER TABLE miembro ADD CONSTRAINT miembro_fk1 FOREIGN KEY (rut_organizacion) REFERENCES public.organizacion_deportiva(rut_organizacion); -- org deportiva - miembro
    ALTER TABLE miembro ADD CONSTRAINT miembro_fk2 FOREIGN KEY (region) REFERENCES public.region(id);-- miembro - region
    --fk org dep sup
    ALTER TABLE organizacion_deportiva_superior ADD CONSTRAINT org_dep_sup_fk FOREIGN KEY (rut_organizacion) REFERENCES public.organizacion_deportiva(rut_organizacion);-- org deportiva - org dep superior
    --fk directorio
    ALTER TABLE directorio ADD CONSTRAINT dir_fk FOREIGN KEY (rut_miembro) REFERENCES public.miembro(rut);-- miembro - directorio
    --fk re legal
    ALTER TABLE representante_legal ADD CONSTRAINT rep_fk FOREIGN KEY (rut_miembro) REFERENCES public.miembro(rut);-- miembro - rep legal
    --fk club
    ALTER TABLE club ADD CONSTRAINT club_fk FOREIGN KEY (rut_organizacion) REFERENCES public.organizacion_deportiva(rut_organizacion);-- org deportiva - club
    --fk deportista
    ALTER TABLE deportista ADD CONSTRAINT deportista_fk FOREIGN KEY (region) REFERENCES public.region(id);-- Deportista - Region
    --relaciones region
