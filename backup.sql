--
-- PostgreSQL database dump
--

-- Dumped from database version 16.8
-- Dumped by pg_dump version 16.8

-- Started on 2025-08-07 03:43:18

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 251 (class 1255 OID 19834)
-- Name: borrarcodigo(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.borrarcodigo(character varying) RETURNS void
    LANGUAGE sql
    AS $_$
	delete from mesas where codigo = $1;
$_$;


ALTER FUNCTION public.borrarcodigo(character varying) OWNER TO laravel;

--
-- TOC entry 252 (class 1255 OID 19835)
-- Name: borrarcodigo1(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.borrarcodigo1(character varying) RETURNS void
    LANGUAGE sql
    AS $_$
	delete from mesas where codigo = $1;
$_$;


ALTER FUNCTION public.borrarcodigo1(character varying) OWNER TO laravel;

--
-- TOC entry 253 (class 1255 OID 19836)
-- Name: insertarmenu(character varying, integer, boolean); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.insertarmenu(character varying, integer, boolean) RETURNS void
    LANGUAGE sql
    AS $_$
insert into mesas (codigo,capacidad,disponible) values ($1,$2,$3);
$_$;


ALTER FUNCTION public.insertarmenu(character varying, integer, boolean) OWNER TO laravel;

--
-- TOC entry 254 (class 1255 OID 19837)
-- Name: insertarmesas(character varying, integer, boolean); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.insertarmesas(codigo character varying, capacidad integer, disponible boolean) RETURNS void
    LANGUAGE sql
    AS $_$
    insert into mesas (codigo, capacidad, disponible) values ($1, $2, $3);
$_$;


ALTER FUNCTION public.insertarmesas(codigo character varying, capacidad integer, disponible boolean) OWNER TO laravel;

--
-- TOC entry 255 (class 1255 OID 19838)
-- Name: insertarpedidos(character varying, integer, boolean); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.insertarpedidos(character varying, integer, boolean) RETURNS void
    LANGUAGE sql
    AS $_$
insert into mesas (codigo,capacidad,disponible) values ($1,$2,$3);
$_$;


ALTER FUNCTION public.insertarpedidos(character varying, integer, boolean) OWNER TO laravel;

--
-- TOC entry 256 (class 1255 OID 19839)
-- Name: promediomesas(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.promediomesas() RETURNS numeric
    LANGUAGE sql
    AS $$
    select avg(capacidad) from mesas;
$$;


ALTER FUNCTION public.promediomesas() OWNER TO laravel;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 215 (class 1259 OID 19840)
-- Name: cache; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cache (
    key character varying(255) NOT NULL,
    value text NOT NULL,
    expiration integer NOT NULL
);


ALTER TABLE public.cache OWNER TO laravel;

--
-- TOC entry 216 (class 1259 OID 19845)
-- Name: cache_locks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cache_locks (
    key character varying(255) NOT NULL,
    owner character varying(255) NOT NULL,
    expiration integer NOT NULL
);


ALTER TABLE public.cache_locks OWNER TO laravel;

--
-- TOC entry 217 (class 1259 OID 19850)
-- Name: clientes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clientes (
    id bigint NOT NULL,
    nombre character varying(255) NOT NULL,
    cedula character varying(255) NOT NULL,
    telefono character varying(255),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.clientes OWNER TO laravel;

--
-- TOC entry 218 (class 1259 OID 19855)
-- Name: clientes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.clientes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.clientes_id_seq OWNER TO laravel;

--
-- TOC entry 5003 (class 0 OID 0)
-- Dependencies: 218
-- Name: clientes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.clientes_id_seq OWNED BY public.clientes.id;


--
-- TOC entry 219 (class 1259 OID 19856)
-- Name: cocineros; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cocineros (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    especialidad character varying(255),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.cocineros OWNER TO laravel;

--
-- TOC entry 220 (class 1259 OID 19859)
-- Name: cocineros_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cocineros_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cocineros_id_seq OWNER TO laravel;

--
-- TOC entry 5004 (class 0 OID 0)
-- Dependencies: 220
-- Name: cocineros_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cocineros_id_seq OWNED BY public.cocineros.id;


--
-- TOC entry 221 (class 1259 OID 19860)
-- Name: detalle_pedidos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.detalle_pedidos (
    id bigint NOT NULL,
    pedido_id bigint NOT NULL,
    producto_id bigint NOT NULL,
    cantidad integer NOT NULL,
    subtotal numeric(8,2),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.detalle_pedidos OWNER TO laravel;

--
-- TOC entry 222 (class 1259 OID 19863)
-- Name: detalle_pedidos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.detalle_pedidos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.detalle_pedidos_id_seq OWNER TO laravel;

--
-- TOC entry 5005 (class 0 OID 0)
-- Dependencies: 222
-- Name: detalle_pedidos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.detalle_pedidos_id_seq OWNED BY public.detalle_pedidos.id;


--
-- TOC entry 223 (class 1259 OID 19864)
-- Name: failed_jobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.failed_jobs (
    id bigint NOT NULL,
    uuid character varying(255) NOT NULL,
    connection text NOT NULL,
    queue text NOT NULL,
    payload text NOT NULL,
    exception text NOT NULL,
    failed_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.failed_jobs OWNER TO laravel;

--
-- TOC entry 224 (class 1259 OID 19870)
-- Name: failed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.failed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.failed_jobs_id_seq OWNER TO laravel;

--
-- TOC entry 5006 (class 0 OID 0)
-- Dependencies: 224
-- Name: failed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.failed_jobs_id_seq OWNED BY public.failed_jobs.id;


--
-- TOC entry 225 (class 1259 OID 19871)
-- Name: job_batches; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.job_batches (
    id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    total_jobs integer NOT NULL,
    pending_jobs integer NOT NULL,
    failed_jobs integer NOT NULL,
    failed_job_ids text NOT NULL,
    options text,
    cancelled_at integer,
    created_at integer NOT NULL,
    finished_at integer
);


ALTER TABLE public.job_batches OWNER TO laravel;

--
-- TOC entry 226 (class 1259 OID 19876)
-- Name: jobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jobs (
    id bigint NOT NULL,
    queue character varying(255) NOT NULL,
    payload text NOT NULL,
    attempts smallint NOT NULL,
    reserved_at integer,
    available_at integer NOT NULL,
    created_at integer NOT NULL
);


ALTER TABLE public.jobs OWNER TO laravel;

--
-- TOC entry 227 (class 1259 OID 19881)
-- Name: jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.jobs_id_seq OWNER TO laravel;

--
-- TOC entry 5007 (class 0 OID 0)
-- Dependencies: 227
-- Name: jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.jobs_id_seq OWNED BY public.jobs.id;


--
-- TOC entry 228 (class 1259 OID 19882)
-- Name: mesas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mesas (
    id bigint NOT NULL,
    codigo character varying(255) NOT NULL,
    capacidad integer NOT NULL,
    disponible boolean DEFAULT true NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.mesas OWNER TO laravel;

--
-- TOC entry 229 (class 1259 OID 19886)
-- Name: mesas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.mesas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.mesas_id_seq OWNER TO laravel;

--
-- TOC entry 5008 (class 0 OID 0)
-- Dependencies: 229
-- Name: mesas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mesas_id_seq OWNED BY public.mesas.id;


--
-- TOC entry 230 (class 1259 OID 19887)
-- Name: meseros; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.meseros (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    turno character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.meseros OWNER TO laravel;

--
-- TOC entry 231 (class 1259 OID 19890)
-- Name: meseros_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.meseros_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.meseros_id_seq OWNER TO laravel;

--
-- TOC entry 5009 (class 0 OID 0)
-- Dependencies: 231
-- Name: meseros_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.meseros_id_seq OWNED BY public.meseros.id;


--
-- TOC entry 232 (class 1259 OID 19891)
-- Name: migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);


ALTER TABLE public.migrations OWNER TO laravel;

--
-- TOC entry 233 (class 1259 OID 19894)
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.migrations_id_seq OWNER TO laravel;

--
-- TOC entry 5010 (class 0 OID 0)
-- Dependencies: 233
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- TOC entry 234 (class 1259 OID 19895)
-- Name: pagos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pagos (
    id bigint NOT NULL,
    pedido_id bigint NOT NULL,
    monto numeric(8,2) NOT NULL,
    metodo character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT pagos_metodo_check CHECK (((metodo)::text = ANY (ARRAY[('efectivo'::character varying)::text, ('tarjeta'::character varying)::text])))
);


ALTER TABLE public.pagos OWNER TO laravel;

--
-- TOC entry 235 (class 1259 OID 19899)
-- Name: pagos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pagos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pagos_id_seq OWNER TO laravel;

--
-- TOC entry 5011 (class 0 OID 0)
-- Dependencies: 235
-- Name: pagos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pagos_id_seq OWNED BY public.pagos.id;


--
-- TOC entry 236 (class 1259 OID 19900)
-- Name: pedidos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pedidos (
    id bigint NOT NULL,
    cliente_id bigint NOT NULL,
    mesa_id bigint NOT NULL,
    mesero_id bigint NOT NULL,
    estado character varying(255) DEFAULT 'pendiente'::character varying NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT pedidos_estado_check CHECK (((estado)::text = ANY (ARRAY[('pendiente'::character varying)::text, ('en preparación'::character varying)::text, ('servido'::character varying)::text, ('pagado'::character varying)::text])))
);


ALTER TABLE public.pedidos OWNER TO laravel;

--
-- TOC entry 237 (class 1259 OID 19905)
-- Name: pedidos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pedidos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pedidos_id_seq OWNER TO laravel;

--
-- TOC entry 5012 (class 0 OID 0)
-- Dependencies: 237
-- Name: pedidos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pedidos_id_seq OWNED BY public.pedidos.id;


--
-- TOC entry 238 (class 1259 OID 19906)
-- Name: personal_access_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.personal_access_tokens (
    id bigint NOT NULL,
    tokenable_type character varying(255) NOT NULL,
    tokenable_id bigint NOT NULL,
    name text NOT NULL,
    token character varying(64) NOT NULL,
    abilities text,
    last_used_at timestamp(0) without time zone,
    expires_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.personal_access_tokens OWNER TO laravel;

--
-- TOC entry 239 (class 1259 OID 19911)
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.personal_access_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.personal_access_tokens_id_seq OWNER TO laravel;

--
-- TOC entry 5013 (class 0 OID 0)
-- Dependencies: 239
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.personal_access_tokens_id_seq OWNED BY public.personal_access_tokens.id;


--
-- TOC entry 240 (class 1259 OID 19912)
-- Name: productos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.productos (
    id bigint NOT NULL,
    nombre character varying(255) NOT NULL,
    precio numeric(8,2) NOT NULL,
    descripcion text,
    requiere_preparacion boolean DEFAULT true NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    disponible boolean DEFAULT true NOT NULL
);


ALTER TABLE public.productos OWNER TO laravel;

--
-- TOC entry 241 (class 1259 OID 19919)
-- Name: productos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.productos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.productos_id_seq OWNER TO laravel;

--
-- TOC entry 5014 (class 0 OID 0)
-- Dependencies: 241
-- Name: productos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.productos_id_seq OWNED BY public.productos.id;


--
-- TOC entry 242 (class 1259 OID 19920)
-- Name: sessions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sessions (
    id character varying(255) NOT NULL,
    user_id bigint,
    ip_address character varying(45),
    user_agent text,
    payload text NOT NULL,
    last_activity integer NOT NULL
);


ALTER TABLE public.sessions OWNER TO laravel;

--
-- TOC entry 243 (class 1259 OID 19925)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    rol character varying(255) DEFAULT 'mesero'::character varying NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT users_rol_check CHECK (((rol)::text = ANY (ARRAY[('admin'::character varying)::text, ('mesero'::character varying)::text, ('cocinero'::character varying)::text, ('cliente'::character varying)::text])))
);


ALTER TABLE public.users OWNER TO laravel;

--
-- TOC entry 244 (class 1259 OID 19932)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO laravel;

--
-- TOC entry 5015 (class 0 OID 0)
-- Dependencies: 244
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 245 (class 1259 OID 19933)
-- Name: vista_control_mesas; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vista_control_mesas AS
 SELECT id,
    codigo,
    capacidad,
    disponible
   FROM public.mesas;


ALTER VIEW public.vista_control_mesas OWNER TO laravel;

--
-- TOC entry 246 (class 1259 OID 19937)
-- Name: vista_pedidos_con_cliente; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vista_pedidos_con_cliente AS
 SELECT p.id AS pedido_id,
    c.nombre AS cliente,
    u.name AS mesero,
    p.estado
   FROM (((public.pedidos p
     JOIN public.clientes c ON ((p.cliente_id = c.id)))
     JOIN public.meseros m ON ((p.mesero_id = m.id)))
     JOIN public.users u ON ((m.user_id = u.id)));


ALTER VIEW public.vista_pedidos_con_cliente OWNER TO laravel;

--
-- TOC entry 247 (class 1259 OID 19942)
-- Name: vista_pedidos_detallados_mat; Type: MATERIALIZED VIEW; Schema: public; Owner: postgres
--

CREATE MATERIALIZED VIEW public.vista_pedidos_detallados_mat AS
 SELECT p.id AS pedido_id,
    c.nombre AS cliente,
    m.codigo AS mesa,
    u.name AS mesero,
    p.estado,
    p.created_at AS fecha_pedido
   FROM ((((public.pedidos p
     JOIN public.clientes c ON ((p.cliente_id = c.id)))
     JOIN public.mesas m ON ((p.mesa_id = m.id)))
     JOIN public.meseros me ON ((p.mesero_id = me.id)))
     JOIN public.users u ON ((me.user_id = u.id)))
  WITH NO DATA;


ALTER MATERIALIZED VIEW public.vista_pedidos_detallados_mat OWNER TO laravel;

--
-- TOC entry 248 (class 1259 OID 19949)
-- Name: vista_productos_disponibles; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vista_productos_disponibles AS
 SELECT id,
    nombre,
    precio
   FROM public.productos
  WHERE (disponible = true);


ALTER VIEW public.vista_productos_disponibles OWNER TO laravel;

--
-- TOC entry 249 (class 1259 OID 19953)
-- Name: vista_productos_preparacion; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vista_productos_preparacion AS
 SELECT id,
    nombre,
    precio,
    descripcion,
    requiere_preparacion,
    created_at,
    updated_at,
    disponible
   FROM public.productos
  WHERE (requiere_preparacion = true);


ALTER VIEW public.vista_productos_preparacion OWNER TO laravel;

--
-- TOC entry 250 (class 1259 OID 19957)
-- Name: vista_productos_preparacion_disponibles; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vista_productos_preparacion_disponibles AS
 SELECT id,
    nombre,
    precio
   FROM public.vista_productos_preparacion
  WHERE (disponible = true);


ALTER VIEW public.vista_productos_preparacion_disponibles OWNER TO laravel;

--
-- TOC entry 4740 (class 2604 OID 19961)
-- Name: clientes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clientes ALTER COLUMN id SET DEFAULT nextval('public.clientes_id_seq'::regclass);


--
-- TOC entry 4741 (class 2604 OID 19962)
-- Name: cocineros id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cocineros ALTER COLUMN id SET DEFAULT nextval('public.cocineros_id_seq'::regclass);


--
-- TOC entry 4742 (class 2604 OID 19963)
-- Name: detalle_pedidos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_pedidos ALTER COLUMN id SET DEFAULT nextval('public.detalle_pedidos_id_seq'::regclass);


--
-- TOC entry 4743 (class 2604 OID 19964)
-- Name: failed_jobs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs ALTER COLUMN id SET DEFAULT nextval('public.failed_jobs_id_seq'::regclass);


--
-- TOC entry 4745 (class 2604 OID 19965)
-- Name: jobs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobs ALTER COLUMN id SET DEFAULT nextval('public.jobs_id_seq'::regclass);


--
-- TOC entry 4746 (class 2604 OID 19966)
-- Name: mesas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mesas ALTER COLUMN id SET DEFAULT nextval('public.mesas_id_seq'::regclass);


--
-- TOC entry 4748 (class 2604 OID 19967)
-- Name: meseros id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meseros ALTER COLUMN id SET DEFAULT nextval('public.meseros_id_seq'::regclass);


--
-- TOC entry 4749 (class 2604 OID 19968)
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- TOC entry 4750 (class 2604 OID 19969)
-- Name: pagos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagos ALTER COLUMN id SET DEFAULT nextval('public.pagos_id_seq'::regclass);


--
-- TOC entry 4751 (class 2604 OID 19970)
-- Name: pedidos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedidos ALTER COLUMN id SET DEFAULT nextval('public.pedidos_id_seq'::regclass);


--
-- TOC entry 4753 (class 2604 OID 19971)
-- Name: personal_access_tokens id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal_access_tokens ALTER COLUMN id SET DEFAULT nextval('public.personal_access_tokens_id_seq'::regclass);


--
-- TOC entry 4754 (class 2604 OID 19972)
-- Name: productos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos ALTER COLUMN id SET DEFAULT nextval('public.productos_id_seq'::regclass);


--
-- TOC entry 4757 (class 2604 OID 19973)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 4967 (class 0 OID 19840)
-- Dependencies: 215
-- Data for Name: cache; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cache (key, value, expiration) FROM stdin;
\.


--
-- TOC entry 4968 (class 0 OID 19845)
-- Dependencies: 216
-- Data for Name: cache_locks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cache_locks (key, owner, expiration) FROM stdin;
\.


--
-- TOC entry 4969 (class 0 OID 19850)
-- Dependencies: 217
-- Data for Name: clientes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.clientes (id, nombre, cedula, telefono, created_at, updated_at) FROM stdin;
1	Carlos Andrade	1305678910	0991234567	2025-07-25 16:07:06	2025-07-25 16:07:06
15	Angel	1300545926	0969735759	2025-08-07 05:06:23	2025-08-07 05:06:23
17	Angel	1300545925	0969735759	2025-08-07 05:06:35	2025-08-07 05:06:35
18	Pedro	1203879240	0969735759	2025-08-07 05:09:25	2025-08-07 05:09:25
19	Pedro Picapiedra	1203889560	0978870349	2025-08-07 05:36:19	2025-08-07 05:36:19
20	Pepe	1234567890	1234567890	2025-08-07 05:40:43	2025-08-07 05:40:43
21	Pablo Gallardo	1235647890	1235647890	2025-08-07 05:50:13	2025-08-07 05:50:13
24	Luis	1203779240	0969735750	2025-08-07 05:52:32	2025-08-07 05:52:32
25	Pablo	1203452895	0984627852	2025-08-07 07:03:11	2025-08-07 07:03:11
\.


--
-- TOC entry 4971 (class 0 OID 19856)
-- Dependencies: 219
-- Data for Name: cocineros; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cocineros (id, user_id, especialidad, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4973 (class 0 OID 19860)
-- Dependencies: 221
-- Data for Name: detalle_pedidos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.detalle_pedidos (id, pedido_id, producto_id, cantidad, subtotal, created_at, updated_at) FROM stdin;
2	3	4	1	\N	2025-08-07 05:09:26	2025-08-07 05:09:26
3	4	5	2	\N	2025-08-07 05:36:20	2025-08-07 05:36:20
4	4	8	1	\N	2025-08-07 05:36:20	2025-08-07 05:36:20
5	5	7	1	\N	2025-08-07 05:40:44	2025-08-07 05:40:44
6	5	6	1	\N	2025-08-07 05:40:44	2025-08-07 05:40:44
7	5	11	1	\N	2025-08-07 05:40:45	2025-08-07 05:40:45
8	6	10	1	\N	2025-08-07 05:50:14	2025-08-07 05:50:14
9	7	3	2	\N	2025-08-07 05:52:33	2025-08-07 05:52:33
10	7	5	1	\N	2025-08-07 05:52:33	2025-08-07 05:52:33
11	8	13	1	\N	2025-08-07 07:03:12	2025-08-07 07:03:12
12	8	11	1	\N	2025-08-07 07:03:12	2025-08-07 07:03:12
\.


--
-- TOC entry 4975 (class 0 OID 19864)
-- Dependencies: 223
-- Data for Name: failed_jobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.failed_jobs (id, uuid, connection, queue, payload, exception, failed_at) FROM stdin;
\.


--
-- TOC entry 4977 (class 0 OID 19871)
-- Dependencies: 225
-- Data for Name: job_batches; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.job_batches (id, name, total_jobs, pending_jobs, failed_jobs, failed_job_ids, options, cancelled_at, created_at, finished_at) FROM stdin;
\.


--
-- TOC entry 4978 (class 0 OID 19876)
-- Dependencies: 226
-- Data for Name: jobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.jobs (id, queue, payload, attempts, reserved_at, available_at, created_at) FROM stdin;
\.


--
-- TOC entry 4980 (class 0 OID 19882)
-- Dependencies: 228
-- Data for Name: mesas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mesas (id, codigo, capacidad, disponible, created_at, updated_at) FROM stdin;
13	codigo 2	4	t	\N	\N
17	codigo 3	2	t	2025-08-07 03:41:53	2025-08-07 05:53:24
14	codigo 1	4	f	\N	2025-08-07 07:03:12
\.


--
-- TOC entry 4982 (class 0 OID 19887)
-- Dependencies: 230
-- Data for Name: meseros; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.meseros (id, user_id, turno, created_at, updated_at) FROM stdin;
1	5	mañana	2025-07-25 16:10:48	2025-07-25 16:10:48
\.


--
-- TOC entry 4984 (class 0 OID 19891)
-- Dependencies: 232
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.migrations (id, migration, batch) FROM stdin;
1	0001_01_01_000001_create_cache_table	1
2	0001_01_01_000002_create_jobs_table	1
3	2025_06_13_040353_create_clientes_table	1
4	2025_06_13_040414_create_mesas_table	1
5	2025_06_13_040420_create_users_table	1
6	2025_06_13_040423_create_meseros_table	1
7	2025_06_13_040427_create_cocineros_table	1
8	2025_06_13_040433_create_productos_table	1
9	2025_06_13_040435_create_pedidos_table	1
10	2025_06_13_040439_create_detalle_pedidos_table	1
11	2025_06_13_040442_create_pagos_table	1
12	2025_07_15_145331_create_sessions_table	1
13	2025_07_15_150143_add_disponible_to_productos_table	1
14	2025_07_15_183004_create_personal_access_tokens_table	1
\.


--
-- TOC entry 4986 (class 0 OID 19895)
-- Dependencies: 234
-- Data for Name: pagos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pagos (id, pedido_id, monto, metodo, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4988 (class 0 OID 19900)
-- Dependencies: 236
-- Data for Name: pedidos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pedidos (id, cliente_id, mesa_id, mesero_id, estado, created_at, updated_at) FROM stdin;
1	1	13	1	servido	2025-07-25 16:11:18	2025-08-07 04:53:36
2	17	14	1	servido	2025-08-07 05:06:35	2025-08-07 05:33:29
3	18	17	1	servido	2025-08-07 05:09:26	2025-08-07 05:33:31
4	19	14	1	servido	2025-08-07 05:36:19	2025-08-07 05:41:57
5	20	14	1	servido	2025-08-07 05:40:44	2025-08-07 05:41:59
6	21	14	1	servido	2025-08-07 05:50:14	2025-08-07 05:50:37
7	24	17	1	servido	2025-08-07 05:52:32	2025-08-07 05:53:23
8	25	14	1	en preparación	2025-08-07 07:03:11	2025-08-07 07:05:20
\.


--
-- TOC entry 4990 (class 0 OID 19906)
-- Dependencies: 238
-- Data for Name: personal_access_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.personal_access_tokens (id, tokenable_type, tokenable_id, name, token, abilities, last_used_at, expires_at, created_at, updated_at) FROM stdin;
1	App\\Models\\User	2	auth_token	f644ee841ffa3358076b0c00a46c16c39e9687c5004cdeab4bfe66e91ec4df6a	["*"]	2025-07-17 02:21:31	\N	2025-07-17 02:21:04	2025-07-17 02:21:31
3	App\\Models\\User	2	auth_token	ff68a54102c923f6591a533294484d8afadc5d4a5c1ffb1271933f9807fd3809	["*"]	2025-07-17 02:45:28	\N	2025-07-17 02:43:26	2025-07-17 02:45:28
2	App\\Models\\User	2	auth_token	cc87c806c169d48d2d940ce865ae62c371275b1ec226fe5f28d912fd64d4c7f6	["*"]	2025-07-17 02:47:13	\N	2025-07-17 02:26:28	2025-07-17 02:47:13
4	App\\Models\\User	2	auth_token	d8cc6f8e565374e85843a684736e3b5faa5a6e84116a167fc54ba98676cd8cb2	["*"]	2025-07-17 02:47:26	\N	2025-07-17 02:45:44	2025-07-17 02:47:26
5	App\\Models\\User	2	auth_token	f0301324f98a1114105dc9aee44ef5e78c219b31f98664b05114c490e6cdb02d	["*"]	2025-07-17 02:49:20	\N	2025-07-17 02:49:20	2025-07-17 02:49:20
9	App\\Models\\User	6	auth_token	854f59bbe50dc957f4865005461e5e35b26f64e19f6dcf3815436856a90c8bfe	["*"]	\N	\N	2025-08-07 04:14:34	2025-08-07 04:14:34
10	App\\Models\\User	6	auth_token	5bb3ae1a76ace19779cc2573eb88261232ef4a95d81f20b0546dbc9327818a1f	["*"]	\N	\N	2025-08-07 04:16:44	2025-08-07 04:16:44
11	App\\Models\\User	6	auth_token	eeeef09cec427e8e86c1ada129eece99fb36436e8d3b0f33a1503ffde32ddd7a	["*"]	\N	\N	2025-08-07 04:16:55	2025-08-07 04:16:55
12	App\\Models\\User	6	auth_token	28f2eb1a3f98c860902444d539fdea3f97b4bf9729436caa9d73bf2482c38aff	["*"]	\N	\N	2025-08-07 04:30:53	2025-08-07 04:30:53
13	App\\Models\\User	6	auth_token	c5fb11d4fdb887731797429702d8eae09be92036b1047b84f9b1b8038bec1c78	["*"]	\N	\N	2025-08-07 04:30:59	2025-08-07 04:30:59
14	App\\Models\\User	6	auth_token	d9f3824bdbe3ace645cf55a0fb3545fd9ab57c4e0e12f84ad7b7f57a16d86532	["*"]	\N	\N	2025-08-07 04:34:08	2025-08-07 04:34:08
15	App\\Models\\User	2	auth_token	525544c8b066634e9ec70610873b4dde90fe28a4191708714eef94a9003539b3	["*"]	\N	\N	2025-08-07 04:34:26	2025-08-07 04:34:26
16	App\\Models\\User	6	auth_token	68dacca8d63692978ae99baa5a542c22e7278144148a8b9b618a51f7cff40fa0	["*"]	\N	\N	2025-08-07 04:36:57	2025-08-07 04:36:57
17	App\\Models\\User	2	auth_token	b3db9cf55676e883b95f0085b8c66e506e1ca2b57e5906605ef7b80ffc99474a	["*"]	\N	\N	2025-08-07 04:41:27	2025-08-07 04:41:27
18	App\\Models\\User	3	auth_token	9e10667ebda6dc2edac9a6f5de6b63662351f646f0119843ad1140621593911d	["*"]	\N	\N	2025-08-07 04:45:24	2025-08-07 04:45:24
19	App\\Models\\User	3	auth_token	6225668382881281a15e903caaad074979be5fa32da1c0c56d19a0df55bced31	["*"]	\N	\N	2025-08-07 04:48:03	2025-08-07 04:48:03
20	App\\Models\\User	2	auth_token	e1fd0709a61f021588c8bee18a6765143bcee753a818236f13afb5c4aed37315	["*"]	\N	\N	2025-08-07 04:48:25	2025-08-07 04:48:25
21	App\\Models\\User	3	auth_token	5180f41937faecb5a30e15f2a9015a4f4ae56b6eef0a00432ab87f311f19a5aa	["*"]	\N	\N	2025-08-07 04:48:39	2025-08-07 04:48:39
22	App\\Models\\User	2	auth_token	49cca80fbaef1e8d6168ec03aadfaad40b92834a5e561afd00771e355462e416	["*"]	\N	\N	2025-08-07 04:50:51	2025-08-07 04:50:51
23	App\\Models\\User	3	auth_token	d45ef50f5892982a49fd5ce7c09ef2f87041e2fcb8b0d1cdd375ba9889d905b4	["*"]	\N	\N	2025-08-07 04:55:29	2025-08-07 04:55:29
24	App\\Models\\User	3	auth_token	81c3778c67cb9b9cefd8337024f21d32b2195e42c18a28c83e9a974e66bf8d9d	["*"]	\N	\N	2025-08-07 04:57:47	2025-08-07 04:57:47
25	App\\Models\\User	3	auth_token	faf861447c4807203a1288895ac321fc9fa60b7b92baf877622d2fb2f9e2907e	["*"]	\N	\N	2025-08-07 05:08:11	2025-08-07 05:08:11
26	App\\Models\\User	3	auth_token	b3181cc91cded7bf48f3ff307178f004df689e15837d9582c19c7be22311cec1	["*"]	\N	\N	2025-08-07 05:09:34	2025-08-07 05:09:34
27	App\\Models\\User	2	auth_token	e0ecf8d1221e4182f27561633d7483e1cda624fc94d25643dfea0f97879aef0d	["*"]	\N	\N	2025-08-07 05:33:23	2025-08-07 05:33:23
28	App\\Models\\User	2	auth_token	937b9e1cef2950ca5be57d99c26694c45026680f16a4360565fe9d1299d0a0d3	["*"]	\N	\N	2025-08-07 05:40:00	2025-08-07 05:40:00
29	App\\Models\\User	3	auth_token	44d8c8b1ae77275ce975a467e10358748fc901da7ef9ccbe80885ad8f9d72834	["*"]	\N	\N	2025-08-07 05:40:07	2025-08-07 05:40:07
30	App\\Models\\User	6	auth_token	e92b1c53ff874ec6505d8dcf2e2496e44bddeb4cce631d3673d4bedf386a897c	["*"]	\N	\N	2025-08-07 05:41:04	2025-08-07 05:41:04
31	App\\Models\\User	3	auth_token	e7804624b102876989c7d35dec3e159f4458ae0692a82c26001488eb58556641	["*"]	\N	\N	2025-08-07 05:41:45	2025-08-07 05:41:45
32	App\\Models\\User	2	auth_token	d0a6e64c2b4554fe15f5dea7b90bc0be3b039334eda8957405095cbda4ba5c62	["*"]	\N	\N	2025-08-07 05:41:55	2025-08-07 05:41:55
33	App\\Models\\User	3	auth_token	dd302aeefdf511bd2ac0b59cc3926b6c4ffff234b30f324ba2dcaf06385d4df5	["*"]	\N	\N	2025-08-07 05:50:22	2025-08-07 05:50:22
34	App\\Models\\User	2	auth_token	a0bb1f81d50253640e00318f8e841e131a5b94bdf42b92c4698783b3849486f0	["*"]	\N	\N	2025-08-07 05:50:34	2025-08-07 05:50:34
35	App\\Models\\User	3	auth_token	1fd21f0e06d2558e73f22367acb31bc65321e9ceba5b63ba23df3d2e8a23f30e	["*"]	\N	\N	2025-08-07 05:53:00	2025-08-07 05:53:00
36	App\\Models\\User	2	auth_token	b72088511d3903674450378a260bf4906f73cb1fcc89913ae7406900f94d478c	["*"]	\N	\N	2025-08-07 05:53:18	2025-08-07 05:53:18
37	App\\Models\\User	6	auth_token	9cb7f3be76324952a5e78fd74c2045186b334927f6ff5da22a44ff587faa4816	["*"]	\N	\N	2025-08-07 06:23:13	2025-08-07 06:23:13
38	App\\Models\\User	6	auth_token	73858de4b9d9820864a1829ae8b3810d8355ab669a9e45ea412576397eb0124e	["*"]	\N	\N	2025-08-07 06:24:35	2025-08-07 06:24:35
39	App\\Models\\User	2	auth_token	224ff8491c944cbae219c1979f8dd98607ef35a41830af2ae8ba6adbc77d275f	["*"]	\N	\N	2025-08-07 06:24:39	2025-08-07 06:24:39
40	App\\Models\\User	2	auth_token	eb7bcafccbaac3f4940adc5ec6b36bbb0836b5170a56f539ee44417fffbaac5d	["*"]	\N	\N	2025-08-07 06:25:25	2025-08-07 06:25:25
41	App\\Models\\User	3	auth_token	a3616bcd91c10d4ba772fa77507596ea8438da08e6594aede659a2d7d0b4fec9	["*"]	\N	\N	2025-08-07 06:25:35	2025-08-07 06:25:35
42	App\\Models\\User	6	auth_token	bab75bfd340fa35c71bef507d5a34b96dedaf13ce78eb7fd979328d3593f9a6d	["*"]	\N	\N	2025-08-07 06:25:39	2025-08-07 06:25:39
43	App\\Models\\User	3	auth_token	d7cd12c320d8331e14ca3681a4615f81d88c318edec12a23a994797766497703	["*"]	\N	\N	2025-08-07 06:26:06	2025-08-07 06:26:06
44	App\\Models\\User	3	auth_token	81db8c9e2d2e481311dbae67b222b983e4134060831e70abaf5a6d1be44cc34b	["*"]	\N	\N	2025-08-07 06:26:39	2025-08-07 06:26:39
45	App\\Models\\User	6	auth_token	af45ebd2de0676839cf5f0354c3c31c2dce9e404fc5c0315b6ffd7ee01b1081a	["*"]	\N	\N	2025-08-07 06:36:08	2025-08-07 06:36:08
46	App\\Models\\User	2	auth_token	1e43ce9eb194c66b9c8b600c288cff233658e6463aeaa41d540685f28ddee625	["*"]	\N	\N	2025-08-07 06:36:18	2025-08-07 06:36:18
47	App\\Models\\User	3	auth_token	5bbab00445a253a194b8555b331f9b848d629a2d222ec0276e498fab2f7d0fd2	["*"]	\N	\N	2025-08-07 07:05:16	2025-08-07 07:05:16
48	App\\Models\\User	2	auth_token	bba6c38f9c1970437a55cd090486ab291f13c06a2fc6e3e8c985f122a0a3898f	["*"]	\N	\N	2025-08-07 07:05:26	2025-08-07 07:05:26
49	App\\Models\\User	6	auth_token	abc9e38fa3b2f69cb7c4704c210bbdafa426b0486f4c9cdbe24c123454ca680c	["*"]	\N	\N	2025-08-07 07:39:50	2025-08-07 07:39:50
50	App\\Models\\User	2	auth_token	8fb4c891900ae8dbdba6cd4055fe2e1bb597f72e5afa4ec18cab7585195bdec8	["*"]	\N	\N	2025-08-07 07:53:10	2025-08-07 07:53:10
51	App\\Models\\User	3	auth_token	dfb3bc5abd8b12b3f8bee0de8760e9fd984db03c582d81e1b5cd95c10dcb4b0c	["*"]	\N	\N	2025-08-07 07:57:44	2025-08-07 07:57:44
52	App\\Models\\User	6	auth_token	caef38ae95f5bdbc09fd4765813bd75bc23dd89cb81d7a94fb2c159d9ff8fa02	["*"]	\N	\N	2025-08-07 07:59:03	2025-08-07 07:59:03
53	App\\Models\\User	6	auth_token	6ba472fafc5723fb829fb27a67f4c1a1ac642097122ab8f748de0f8548b134ef	["*"]	\N	\N	2025-08-07 08:00:54	2025-08-07 08:00:54
54	App\\Models\\User	3	auth_token	9d1c2c6eeee8575896cdc380dee4107c838dd9bb4041bb578c840ac4f07f9331	["*"]	\N	\N	2025-08-07 08:01:21	2025-08-07 08:01:21
55	App\\Models\\User	2	auth_token	946919bf2bdab27c16638837388448effd37543b4d27474343ef24991f7696de	["*"]	\N	\N	2025-08-07 08:01:35	2025-08-07 08:01:35
56	App\\Models\\User	6	auth_token	08d2b721d319054060ce3c1f3f3c2992ae91c1915471c35a9d598b40f8196018	["*"]	\N	\N	2025-08-07 08:01:54	2025-08-07 08:01:54
57	App\\Models\\User	2	auth_token	baa2bb20e4168df135da8b98afde05ffc5ba7204a09c81bcdd36a0a730a31046	["*"]	\N	\N	2025-08-07 08:05:00	2025-08-07 08:05:00
58	App\\Models\\User	3	auth_token	df04bc58ef3e95f7ae6a0d2c034979245353b4780a52e117e937e8673e5f14e7	["*"]	\N	\N	2025-08-07 08:05:06	2025-08-07 08:05:06
59	App\\Models\\User	2	auth_token	d97feb46ec30696e4b130738d22d770997a78a68fc3c693dfe325d8cefeb3ec4	["*"]	\N	\N	2025-08-07 08:05:12	2025-08-07 08:05:12
\.


--
-- TOC entry 4992 (class 0 OID 19912)
-- Dependencies: 240
-- Data for Name: productos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.productos (id, nombre, precio, descripcion, requiere_preparacion, created_at, updated_at, disponible) FROM stdin;
3	Arroz con camarón especial	12.50	Plato típico con mariscos y vegetales	t	\N	\N	t
4	Pizza hawaiana grande	10.00	Con piña, jamón y queso	t	\N	\N	t
5	Ceviche mixto	8.00	Camarones, pescado y jugo de limón	t	\N	\N	t
6	Ensalada César	6.50	Con pollo, lechuga y aderezo	t	\N	\N	t
7	Lomo saltado	11.25	Carne salteada con papas y arroz	t	\N	\N	t
8	Cola 500ml	2.00	Bebida gaseosa fría	f	\N	\N	t
9	Cerveza artesanal	3.50	Bebida alcohólica bien fría	f	\N	\N	t
10	Agua mineral	1.50	Botella sin gas	f	\N	\N	t
11	Torta de chocolate	4.00	Rebanada lista para servir	f	\N	\N	t
12	Helado de vainilla	3.00	Copa individual lista	f	\N	\N	t
2	Jugo de Naranja	21.00	Bebida de Naranja bien helada	f	2025-07-17 02:45:54	2025-07-17 02:45:54	t
13	Cafe	1.50	Cafe bien caliente	t	2025-08-07 03:41:13	2025-08-07 03:41:29	t
14	Pollo Frito	3.50	Pollo frito bien frito	t	2025-08-07 07:51:51	2025-08-07 07:51:51	t
\.


--
-- TOC entry 4994 (class 0 OID 19920)
-- Dependencies: 242
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) FROM stdin;
\.


--
-- TOC entry 4995 (class 0 OID 19925)
-- Dependencies: 243
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, email, password, rol, created_at, updated_at) FROM stdin;
4	Prueba2	Prueba2@gmail.com	$2y$12$tnETW9hi.x9m0fg/.4P2v.4thrjrOItqlZwjmpEgul6JhrLiWPJYW	mesero	2025-07-22 19:32:11	2025-07-22 19:32:11
5	Pedro Jiménez	pedro@example.com	123456	mesero	2025-07-25 16:08:01	2025-07-25 16:08:01
6	Paul	paul@gmail.com	$2y$12$LuU4ZwcrLLY7seM6Xe9iV.vSJGl4PhEN21vndVvssRMdswIO2Uiai	admin	2025-08-07 03:37:22	2025-08-07 03:37:22
9	Larry	larry@gmail.com	$2y$12$/6CKDL.2iJPIS9i9jjtUmORYl2dloxF1UU1ym2SWNAojTY.v0tzri	cliente	2025-08-07 03:54:07	2025-08-07 03:54:07
1	Juan	juan@example.com	$2y$12$95v9HpX2TVmKcV9MX29N1uEfGUfmMHcPaPJP2TfV9E3begdP8Ukv6	cliente	2025-07-17 02:08:20	2025-08-07 04:00:45
2	Luis	a@gmail.com	$2y$12$mJjSXTrzrWu5Vdf.RjOnaetNvM20YhwgRr0RJgLYvomIq/9M1Y07m	mesero	2025-07-17 02:20:56	2025-08-07 04:34:21
3	Prueba	Prueba@gmail.com	$2y$12$/3hDhS.YCiWxvvLPQqBoj.f.oQCftozu6dPhGEhRmS5vd7.npQk2C	cocinero	2025-07-22 19:31:49	2025-08-07 04:37:19
\.


--
-- TOC entry 5016 (class 0 OID 0)
-- Dependencies: 218
-- Name: clientes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.clientes_id_seq', 25, true);


--
-- TOC entry 5017 (class 0 OID 0)
-- Dependencies: 220
-- Name: cocineros_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cocineros_id_seq', 1, false);


--
-- TOC entry 5018 (class 0 OID 0)
-- Dependencies: 222
-- Name: detalle_pedidos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.detalle_pedidos_id_seq', 12, true);


--
-- TOC entry 5019 (class 0 OID 0)
-- Dependencies: 224
-- Name: failed_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.failed_jobs_id_seq', 1, false);


--
-- TOC entry 5020 (class 0 OID 0)
-- Dependencies: 227
-- Name: jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.jobs_id_seq', 1, false);


--
-- TOC entry 5021 (class 0 OID 0)
-- Dependencies: 229
-- Name: mesas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mesas_id_seq', 17, true);


--
-- TOC entry 5022 (class 0 OID 0)
-- Dependencies: 231
-- Name: meseros_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.meseros_id_seq', 1, true);


--
-- TOC entry 5023 (class 0 OID 0)
-- Dependencies: 233
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.migrations_id_seq', 14, true);


--
-- TOC entry 5024 (class 0 OID 0)
-- Dependencies: 235
-- Name: pagos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pagos_id_seq', 1, false);


--
-- TOC entry 5025 (class 0 OID 0)
-- Dependencies: 237
-- Name: pedidos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pedidos_id_seq', 8, true);


--
-- TOC entry 5026 (class 0 OID 0)
-- Dependencies: 239
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.personal_access_tokens_id_seq', 59, true);


--
-- TOC entry 5027 (class 0 OID 0)
-- Dependencies: 241
-- Name: productos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.productos_id_seq', 14, true);


--
-- TOC entry 5028 (class 0 OID 0)
-- Dependencies: 244
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 9, true);


--
-- TOC entry 4765 (class 2606 OID 19975)
-- Name: cache_locks cache_locks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cache_locks
    ADD CONSTRAINT cache_locks_pkey PRIMARY KEY (key);


--
-- TOC entry 4763 (class 2606 OID 19977)
-- Name: cache cache_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cache
    ADD CONSTRAINT cache_pkey PRIMARY KEY (key);


--
-- TOC entry 4767 (class 2606 OID 19979)
-- Name: clientes clientes_cedula_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT clientes_cedula_unique UNIQUE (cedula);


--
-- TOC entry 4769 (class 2606 OID 19981)
-- Name: clientes clientes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT clientes_pkey PRIMARY KEY (id);


--
-- TOC entry 4771 (class 2606 OID 19983)
-- Name: cocineros cocineros_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cocineros
    ADD CONSTRAINT cocineros_pkey PRIMARY KEY (id);


--
-- TOC entry 4773 (class 2606 OID 19985)
-- Name: detalle_pedidos detalle_pedidos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_pedidos
    ADD CONSTRAINT detalle_pedidos_pkey PRIMARY KEY (id);


--
-- TOC entry 4775 (class 2606 OID 19987)
-- Name: failed_jobs failed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_pkey PRIMARY KEY (id);


--
-- TOC entry 4777 (class 2606 OID 19989)
-- Name: failed_jobs failed_jobs_uuid_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_uuid_unique UNIQUE (uuid);


--
-- TOC entry 4779 (class 2606 OID 19991)
-- Name: job_batches job_batches_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_batches
    ADD CONSTRAINT job_batches_pkey PRIMARY KEY (id);


--
-- TOC entry 4781 (class 2606 OID 19993)
-- Name: jobs jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);


--
-- TOC entry 4784 (class 2606 OID 19995)
-- Name: mesas mesas_codigo_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mesas
    ADD CONSTRAINT mesas_codigo_unique UNIQUE (codigo);


--
-- TOC entry 4786 (class 2606 OID 19997)
-- Name: mesas mesas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mesas
    ADD CONSTRAINT mesas_pkey PRIMARY KEY (id);


--
-- TOC entry 4788 (class 2606 OID 19999)
-- Name: meseros meseros_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meseros
    ADD CONSTRAINT meseros_pkey PRIMARY KEY (id);


--
-- TOC entry 4790 (class 2606 OID 20001)
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 4792 (class 2606 OID 20003)
-- Name: pagos pagos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagos
    ADD CONSTRAINT pagos_pkey PRIMARY KEY (id);


--
-- TOC entry 4794 (class 2606 OID 20005)
-- Name: pedidos pedidos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedidos
    ADD CONSTRAINT pedidos_pkey PRIMARY KEY (id);


--
-- TOC entry 4796 (class 2606 OID 20007)
-- Name: personal_access_tokens personal_access_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_pkey PRIMARY KEY (id);


--
-- TOC entry 4798 (class 2606 OID 20009)
-- Name: personal_access_tokens personal_access_tokens_token_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_token_unique UNIQUE (token);


--
-- TOC entry 4801 (class 2606 OID 20011)
-- Name: productos productos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos
    ADD CONSTRAINT productos_pkey PRIMARY KEY (id);


--
-- TOC entry 4804 (class 2606 OID 20013)
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- TOC entry 4807 (class 2606 OID 20015)
-- Name: users users_email_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_unique UNIQUE (email);


--
-- TOC entry 4809 (class 2606 OID 20017)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 4782 (class 1259 OID 20018)
-- Name: jobs_queue_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX jobs_queue_index ON public.jobs USING btree (queue);


--
-- TOC entry 4799 (class 1259 OID 20019)
-- Name: personal_access_tokens_tokenable_type_tokenable_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX personal_access_tokens_tokenable_type_tokenable_id_index ON public.personal_access_tokens USING btree (tokenable_type, tokenable_id);


--
-- TOC entry 4802 (class 1259 OID 20020)
-- Name: sessions_last_activity_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sessions_last_activity_index ON public.sessions USING btree (last_activity);


--
-- TOC entry 4805 (class 1259 OID 20021)
-- Name: sessions_user_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sessions_user_id_index ON public.sessions USING btree (user_id);


--
-- TOC entry 4810 (class 2606 OID 20022)
-- Name: cocineros cocineros_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cocineros
    ADD CONSTRAINT cocineros_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 4811 (class 2606 OID 20027)
-- Name: detalle_pedidos detalle_pedidos_pedido_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_pedidos
    ADD CONSTRAINT detalle_pedidos_pedido_id_foreign FOREIGN KEY (pedido_id) REFERENCES public.pedidos(id) ON DELETE CASCADE;


--
-- TOC entry 4812 (class 2606 OID 20032)
-- Name: detalle_pedidos detalle_pedidos_producto_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_pedidos
    ADD CONSTRAINT detalle_pedidos_producto_id_foreign FOREIGN KEY (producto_id) REFERENCES public.productos(id) ON DELETE CASCADE;


--
-- TOC entry 4813 (class 2606 OID 20037)
-- Name: meseros meseros_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meseros
    ADD CONSTRAINT meseros_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 4814 (class 2606 OID 20042)
-- Name: pagos pagos_pedido_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagos
    ADD CONSTRAINT pagos_pedido_id_foreign FOREIGN KEY (pedido_id) REFERENCES public.pedidos(id) ON DELETE CASCADE;


--
-- TOC entry 4815 (class 2606 OID 20047)
-- Name: pedidos pedidos_cliente_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedidos
    ADD CONSTRAINT pedidos_cliente_id_foreign FOREIGN KEY (cliente_id) REFERENCES public.clientes(id) ON DELETE CASCADE;


--
-- TOC entry 4816 (class 2606 OID 20052)
-- Name: pedidos pedidos_mesa_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedidos
    ADD CONSTRAINT pedidos_mesa_id_foreign FOREIGN KEY (mesa_id) REFERENCES public.mesas(id) ON DELETE CASCADE;


--
-- TOC entry 4817 (class 2606 OID 20057)
-- Name: pedidos pedidos_mesero_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedidos
    ADD CONSTRAINT pedidos_mesero_id_foreign FOREIGN KEY (mesero_id) REFERENCES public.meseros(id) ON DELETE CASCADE;


--
-- TOC entry 4997 (class 0 OID 19942)
-- Dependencies: 247 4999
-- Name: vista_pedidos_detallados_mat; Type: MATERIALIZED VIEW DATA; Schema: public; Owner: postgres
--

REFRESH MATERIALIZED VIEW public.vista_pedidos_detallados_mat;


-- Completed on 2025-08-07 03:43:18

--
-- PostgreSQL database dump complete
--

