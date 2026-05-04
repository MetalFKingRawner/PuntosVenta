--
-- PostgreSQL database dump
--

-- Dumped from database version 12.18
-- Dumped by pg_dump version 12.18

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: categorias; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categorias (
    id integer NOT NULL,
    nombre character varying(255) NOT NULL
);


ALTER TABLE public.categorias OWNER TO postgres;

--
-- Name: categorias_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categorias_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categorias_id_seq OWNER TO postgres;

--
-- Name: categorias_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categorias_id_seq OWNED BY public.categorias.id;


--
-- Name: categorias_nar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categorias_nar (
    id_categoria integer NOT NULL,
    nombre character varying(50) NOT NULL
);


ALTER TABLE public.categorias_nar OWNER TO postgres;

--
-- Name: categorias_nar_id_categoria_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categorias_nar_id_categoria_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categorias_nar_id_categoria_seq OWNER TO postgres;

--
-- Name: categorias_nar_id_categoria_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categorias_nar_id_categoria_seq OWNED BY public.categorias_nar.id_categoria;


--
-- Name: cuentas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cuentas (
    id_cuenta integer NOT NULL,
    id_mesa integer NOT NULL,
    nombre_cuenta character varying(50) NOT NULL,
    total numeric(10,2) DEFAULT 0,
    estado character varying(20) DEFAULT 'abierta'::character varying,
    fecha_apertura timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    fecha_cierre timestamp without time zone
);


ALTER TABLE public.cuentas OWNER TO postgres;

--
-- Name: cuentas_id_cuenta_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cuentas_id_cuenta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cuentas_id_cuenta_seq OWNER TO postgres;

--
-- Name: cuentas_id_cuenta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cuentas_id_cuenta_seq OWNED BY public.cuentas.id_cuenta;


--
-- Name: descuentos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.descuentos (
    id_descuento integer NOT NULL,
    id_cuenta integer,
    id_detalle integer,
    tipo_descuento character varying(10),
    valor_descuento numeric(10,2),
    motivo character varying(100),
    fecha_aplicacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    activo boolean DEFAULT true,
    CONSTRAINT descuentos_tipo_descuento_check CHECK (((tipo_descuento)::text = ANY ((ARRAY['porcentaje'::character varying, 'fijo'::character varying])::text[])))
);


ALTER TABLE public.descuentos OWNER TO postgres;

--
-- Name: descuentos_id_descuento_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.descuentos_id_descuento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.descuentos_id_descuento_seq OWNER TO postgres;

--
-- Name: descuentos_id_descuento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.descuentos_id_descuento_seq OWNED BY public.descuentos.id_descuento;


--
-- Name: detalle_cuentas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.detalle_cuentas (
    id_detalle integer NOT NULL,
    id_cuenta integer NOT NULL,
    id_producto integer NOT NULL,
    cantidad numeric(10,2) NOT NULL,
    precio_unitario numeric(10,2) NOT NULL,
    subtotal numeric(10,2) NOT NULL,
    fecha timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.detalle_cuentas OWNER TO postgres;

--
-- Name: detalle_cuentas_id_detalle_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.detalle_cuentas_id_detalle_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.detalle_cuentas_id_detalle_seq OWNER TO postgres;

--
-- Name: detalle_cuentas_id_detalle_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.detalle_cuentas_id_detalle_seq OWNED BY public.detalle_cuentas.id_detalle;


--
-- Name: detalle_ventas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.detalle_ventas (
    id integer NOT NULL,
    id_venta integer NOT NULL,
    id_producto integer NOT NULL,
    cantidad integer NOT NULL,
    subtotal numeric(10,2) NOT NULL
);


ALTER TABLE public.detalle_ventas OWNER TO postgres;

--
-- Name: detalle_ventas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.detalle_ventas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.detalle_ventas_id_seq OWNER TO postgres;

--
-- Name: detalle_ventas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.detalle_ventas_id_seq OWNED BY public.detalle_ventas.id;


--
-- Name: mesas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mesas (
    id_mesa integer NOT NULL,
    nombre character varying(50) NOT NULL,
    estado character varying(20) NOT NULL,
    fecha_registro timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT mesas_estado_check CHECK (((estado)::text = ANY ((ARRAY['disponible'::character varying, 'ocupada'::character varying, 'reservada'::character varying, 'impresa'::character varying])::text[])))
);


ALTER TABLE public.mesas OWNER TO postgres;

--
-- Name: mesas_id_mesa_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.mesas_id_mesa_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.mesas_id_mesa_seq OWNER TO postgres;

--
-- Name: mesas_id_mesa_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mesas_id_mesa_seq OWNED BY public.mesas.id_mesa;


--
-- Name: movimientos_inventario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.movimientos_inventario (
    id integer NOT NULL,
    id_producto integer NOT NULL,
    cantidad integer NOT NULL,
    precio_unitario numeric(10,2) NOT NULL,
    tipo_movimiento character varying(50) NOT NULL,
    motivo text NOT NULL,
    fecha timestamp without time zone DEFAULT now()
);


ALTER TABLE public.movimientos_inventario OWNER TO postgres;

--
-- Name: movimientos_inventario_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.movimientos_inventario_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.movimientos_inventario_id_seq OWNER TO postgres;

--
-- Name: movimientos_inventario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.movimientos_inventario_id_seq OWNED BY public.movimientos_inventario.id;


--
-- Name: productos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.productos (
    id integer NOT NULL,
    nombre character varying(255) NOT NULL,
    id_categoria integer NOT NULL,
    precio numeric(10,2) NOT NULL,
    stock integer DEFAULT 0 NOT NULL,
    codigo character varying(50) NOT NULL
);


ALTER TABLE public.productos OWNER TO postgres;

--
-- Name: productos_bar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.productos_bar (
    id_producto integer NOT NULL,
    nombre character varying(255) NOT NULL,
    descripcion text,
    id_categoria integer,
    precio_venta numeric(10,2) NOT NULL,
    stock numeric(10,2) DEFAULT 0,
    stock_minimo numeric(10,2) DEFAULT 0
);


ALTER TABLE public.productos_bar OWNER TO postgres;

--
-- Name: productos_bar_id_producto_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.productos_bar_id_producto_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.productos_bar_id_producto_seq OWNER TO postgres;

--
-- Name: productos_bar_id_producto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.productos_bar_id_producto_seq OWNED BY public.productos_bar.id_producto;


--
-- Name: productos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.productos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.productos_id_seq OWNER TO postgres;

--
-- Name: productos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.productos_id_seq OWNED BY public.productos.id;


--
-- Name: productos_respaldo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.productos_respaldo (
    id integer NOT NULL,
    nombre character varying(255) NOT NULL,
    id_categoria integer NOT NULL,
    precio numeric(10,2) NOT NULL,
    stock integer NOT NULL,
    fecha_respaldo date,
    codigo character(10)
);


ALTER TABLE public.productos_respaldo OWNER TO postgres;

--
-- Name: productos_respaldo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.productos_respaldo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.productos_respaldo_id_seq OWNER TO postgres;

--
-- Name: productos_respaldo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.productos_respaldo_id_seq OWNED BY public.productos_respaldo.id;


--
-- Name: turnos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.turnos (
    id integer NOT NULL,
    fecha_apertura timestamp without time zone NOT NULL,
    fecha_cierre timestamp without time zone,
    total_inicio numeric(10,2) NOT NULL,
    total_cierre numeric(10,2),
    estado boolean DEFAULT true
);


ALTER TABLE public.turnos OWNER TO postgres;

--
-- Name: turnos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.turnos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.turnos_id_seq OWNER TO postgres;

--
-- Name: turnos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.turnos_id_seq OWNED BY public.turnos.id;


--
-- Name: ventas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ventas (
    id integer NOT NULL,
    fecha timestamp without time zone DEFAULT now() NOT NULL,
    total numeric(10,2) NOT NULL
);


ALTER TABLE public.ventas OWNER TO postgres;

--
-- Name: ventas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ventas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ventas_id_seq OWNER TO postgres;

--
-- Name: ventas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ventas_id_seq OWNED BY public.ventas.id;


--
-- Name: categorias id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorias ALTER COLUMN id SET DEFAULT nextval('public.categorias_id_seq'::regclass);


--
-- Name: categorias_nar id_categoria; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorias_nar ALTER COLUMN id_categoria SET DEFAULT nextval('public.categorias_nar_id_categoria_seq'::regclass);


--
-- Name: cuentas id_cuenta; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuentas ALTER COLUMN id_cuenta SET DEFAULT nextval('public.cuentas_id_cuenta_seq'::regclass);


--
-- Name: descuentos id_descuento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.descuentos ALTER COLUMN id_descuento SET DEFAULT nextval('public.descuentos_id_descuento_seq'::regclass);


--
-- Name: detalle_cuentas id_detalle; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_cuentas ALTER COLUMN id_detalle SET DEFAULT nextval('public.detalle_cuentas_id_detalle_seq'::regclass);


--
-- Name: detalle_ventas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_ventas ALTER COLUMN id SET DEFAULT nextval('public.detalle_ventas_id_seq'::regclass);


--
-- Name: mesas id_mesa; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mesas ALTER COLUMN id_mesa SET DEFAULT nextval('public.mesas_id_mesa_seq'::regclass);


--
-- Name: movimientos_inventario id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movimientos_inventario ALTER COLUMN id SET DEFAULT nextval('public.movimientos_inventario_id_seq'::regclass);


--
-- Name: productos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos ALTER COLUMN id SET DEFAULT nextval('public.productos_id_seq'::regclass);


--
-- Name: productos_bar id_producto; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos_bar ALTER COLUMN id_producto SET DEFAULT nextval('public.productos_bar_id_producto_seq'::regclass);


--
-- Name: productos_respaldo id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos_respaldo ALTER COLUMN id SET DEFAULT nextval('public.productos_respaldo_id_seq'::regclass);


--
-- Name: turnos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.turnos ALTER COLUMN id SET DEFAULT nextval('public.turnos_id_seq'::regclass);


--
-- Name: ventas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ventas ALTER COLUMN id SET DEFAULT nextval('public.ventas_id_seq'::regclass);


--
-- Data for Name: categorias; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categorias (id, nombre) FROM stdin;
1	Paletas de fruta
2	Paletas de crema
3	Paletas cubiertas de chocolate
4	Helado
5	Extras
\.


--
-- Data for Name: categorias_nar; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categorias_nar (id_categoria, nombre) FROM stdin;
1	Cocteler¡a
2	Cerveza
3	Botellas
4	Botellas premium
5	Bebidas sin alcohol
6	Cigarros
7	Jugos
8	Snacks
9	Alitas
\.


--
-- Data for Name: cuentas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cuentas (id_cuenta, id_mesa, nombre_cuenta, total, estado, fecha_apertura, fecha_cierre) FROM stdin;
3	1	Marianito	0.00	abierta	2025-04-04 01:03:30.824592	\N
13	1	Pepin	0.00	abierta	2025-04-05 02:50:35.661809	\N
14	1	Morgan	0.00	abierta	2025-04-05 02:53:13.962128	\N
15	1	Marianito (1)	0.00	abierta	2025-04-05 02:54:11.853562	\N
18	1	Porfirio	0.00	abierta	2025-05-06 18:58:30.309113	\N
21	1	Profundo	0.00	abierta	2025-05-06 19:05:27.711676	\N
\.


--
-- Data for Name: descuentos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.descuentos (id_descuento, id_cuenta, id_detalle, tipo_descuento, valor_descuento, motivo, fecha_aplicacion, activo) FROM stdin;
8	13	44	porcentaje	25.00	Promo miercoles	2025-04-09 12:37:33.15935	t
9	13	42	porcentaje	50.00	Promo jueves	2025-04-09 14:05:03.018681	t
10	18	53	porcentaje	50.00	Descuento por tardío	2025-05-06 19:01:19.821372	t
11	18	65	porcentaje	50.00	martes 50% descuento	2025-05-06 19:07:02.347444	t
\.


--
-- Data for Name: detalle_cuentas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.detalle_cuentas (id_detalle, id_cuenta, id_producto, cantidad, precio_unitario, subtotal, fecha) FROM stdin;
45	18	115	1.00	70.00	70.00	2025-05-06 18:59:11.151057
50	18	123	2.00	40.00	80.00	2025-05-06 18:59:11.151057
49	18	140	2.00	100.00	200.00	2025-05-06 18:59:11.151057
53	18	143	1.00	180.00	180.00	2025-05-06 19:00:28.186443
51	18	123	2.00	40.00	80.00	2025-05-06 18:59:49.744974
52	18	115	1.00	70.00	70.00	2025-05-06 18:59:49.744974
61	21	36	1.00	80.00	80.00	2025-05-06 19:05:28.108217
34	14	138	1.00	80.00	80.00	2025-04-05 21:47:53.569314
55	21	45	2.00	50.00	100.00	2025-05-06 19:04:34.227013
56	21	106	1.00	30.00	30.00	2025-05-06 19:04:34.227013
58	21	133	1.00	50.00	50.00	2025-05-06 19:04:34.227013
57	21	135	1.00	50.00	50.00	2025-05-06 19:04:34.227013
41	13	1	1.00	50.00	50.00	2025-04-06 02:34:50.371469
22	15	20	1.00	80.00	80.00	2025-04-05 02:54:11.857947
32	15	136	1.00	50.00	50.00	2025-04-05 21:31:44.61911
21	15	138	1.00	80.00	80.00	2025-04-05 02:54:11.857947
42	13	8	1.00	50.00	50.00	2025-04-06 02:35:22.902472
23	3	1	1.00	50.00	50.00	2025-04-05 03:09:11.136366
10	3	1	3.00	50.00	150.00	2025-04-04 21:48:58.660817
11	3	5	1.00	50.00	50.00	2025-04-04 21:48:58.660817
16	3	8	1.00	50.00	50.00	2025-04-05 00:58:40.499951
13	3	20	1.00	80.00	80.00	2025-04-04 21:52:29.267777
60	21	143	1.00	180.00	180.00	2025-05-06 19:04:34.227013
26	3	27	1.00	80.00	80.00	2025-04-05 19:50:15.101796
64	18	36	1.00	80.00	80.00	2025-05-06 19:06:30.691833
27	3	112	1.00	40.00	40.00	2025-04-05 19:50:15.101796
28	3	115	1.00	70.00	70.00	2025-04-05 19:50:15.101796
30	3	135	1.00	50.00	50.00	2025-04-05 19:50:15.101796
24	3	136	1.00	50.00	50.00	2025-04-05 03:09:11.136366
15	3	136	1.00	50.00	50.00	2025-04-04 21:52:29.267777
65	18	106	1.00	30.00	30.00	2025-05-06 19:06:30.691833
29	3	137	1.00	80.00	80.00	2025-04-05 19:50:15.101796
43	13	138	4.00	80.00	320.00	2025-04-06 19:11:25.503198
44	13	123	1.00	40.00	40.00	2025-04-09 11:37:41.968294
46	18	135	2.00	50.00	100.00	2025-05-06 18:59:11.151057
\.


--
-- Data for Name: detalle_ventas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.detalle_ventas (id, id_venta, id_producto, cantidad, subtotal) FROM stdin;
1	1	1	1	15.00
2	2	2	1	15.00
3	2	6	1	15.00
4	2	9	1	15.00
5	2	1	2	15.00
6	3	3	2	15.00
7	3	10	2	15.00
8	3	39	1	55.00
9	3	38	1	50.00
10	3	40	2	50.00
11	4	12	2	15.00
12	5	13	4	15.00
13	6	16	1	15.00
14	6	22	1	20.00
15	6	14	2	15.00
16	7	4	1	15.00
17	7	11	1	15.00
18	7	33	1	60.00
19	7	25	2	20.00
20	8	26	4	20.00
21	8	13	2	15.00
22	8	11	5	15.00
23	9	11	1	15.00
24	9	23	1	20.00
25	9	7	1	15.00
26	10	7	1	15.00
27	10	5	1	15.00
28	10	28	1	20.00
29	10	24	1	20.00
30	11	20	2	20.00
31	11	21	2	20.00
32	11	5	1	15.00
33	11	29	1	20.00
34	11	32	2	30.00
35	11	35	1	120.00
36	11	31	1	30.00
37	12	7	1	15.00
38	12	5	1	15.00
39	12	8	2	15.00
40	12	28	1	20.00
41	12	30	1	30.00
42	13	11	2	15.00
43	13	23	2	20.00
44	13	21	1	20.00
45	13	31	1	30.00
46	13	28	3	20.00
47	13	7	1	15.00
48	13	30	2	30.00
49	14	3	1	15.00
50	14	18	2	20.00
51	14	9	1	15.00
52	14	42	1	45.00
53	14	15	1	15.00
54	14	1	1	15.00
55	14	4	2	15.00
56	15	5	1	15.00
57	15	7	1	15.00
58	16	1	1	15.00
59	16	10	1	15.00
60	16	15	1	15.00
61	16	18	2	20.00
62	17	1	3	15.00
63	17	36	1	35.00
64	18	2	1	15.00
65	19	4	2	15.00
97	51	1	1	15.00
\.


--
-- Data for Name: mesas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mesas (id_mesa, nombre, estado, fecha_registro) FROM stdin;
3	Mesa 3	disponible	2025-04-03 13:21:53.047945
5	Mesa 5	disponible	2025-04-03 13:21:53.187253
6	Mesa 6	disponible	2025-04-03 13:21:53.187816
7	Terraza	disponible	2025-04-03 13:33:55.931741
10	jardin	disponible	2025-04-03 22:07:59.639096
1	Mesa 1	ocupada	2025-04-03 13:21:53.002455
4	Mesa 4	reservada	2025-04-03 13:21:53.186581
11	Jardin 2	disponible	2025-04-03 22:13:48.629003
12	Terraza 2	disponible	2025-04-05 19:53:26.957302
2	Mesa 2	disponible	2025-04-03 13:21:53.047314
\.


--
-- Data for Name: movimientos_inventario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.movimientos_inventario (id, id_producto, cantidad, precio_unitario, tipo_movimiento, motivo, fecha) FROM stdin;
1	45	10	15.00	entrada	Producto agregado	2024-11-19 12:09:33.42302
2	1	1	15.00	salida	Venta de producto	2024-11-19 23:05:28.149646
3	2	1	15.00	salida	Venta de producto	2024-11-19 23:09:48.501353
4	6	1	15.00	salida	Venta de producto	2024-11-19 23:09:48.509491
5	9	1	15.00	salida	Venta de producto	2024-11-19 23:09:48.514358
6	1	2	15.00	salida	Venta de producto	2024-11-19 23:09:48.519483
7	3	2	15.00	salida	Venta de producto	2024-11-19 23:12:22.921275
8	10	2	15.00	salida	Venta de producto	2024-11-19 23:12:22.925363
9	39	1	55.00	salida	Venta de producto	2024-11-19 23:12:22.928735
10	38	1	50.00	salida	Venta de producto	2024-11-19 23:12:23.03228
11	40	2	50.00	salida	Venta de producto	2024-11-19 23:12:23.039368
12	12	2	15.00	salida	Venta de producto	2024-11-20 00:31:52.735006
13	13	4	15.00	salida	Venta de producto	2024-11-21 00:20:29.999352
14	16	1	15.00	salida	Venta de producto	2024-11-21 12:19:05.470342
15	22	1	20.00	salida	Venta de producto	2024-11-21 12:19:05.497603
16	14	2	15.00	salida	Venta de producto	2024-11-21 12:19:05.507742
17	4	1	15.00	salida	Venta de producto	2024-11-21 22:01:01.110016
18	11	1	15.00	salida	Venta de producto	2024-11-21 22:01:01.121567
19	33	1	60.00	salida	Venta de producto	2024-11-21 22:01:01.13621
20	25	2	20.00	salida	Venta de producto	2024-11-21 22:01:01.161454
21	26	4	20.00	salida	Venta de producto	2024-11-21 22:02:56.340233
22	13	2	15.00	salida	Venta de producto	2024-11-21 22:02:56.365422
23	11	5	15.00	salida	Venta de producto	2024-11-21 22:02:56.383439
33	11	1	15.00	salida	Venta de producto	2024-11-22 23:01:28.211968
34	23	1	20.00	salida	Venta de producto	2024-11-22 23:01:28.369099
35	7	1	15.00	salida	Venta de producto	2024-11-22 23:01:28.37633
36	7	1	15.00	salida	Venta de producto	2024-11-22 23:01:46.050997
37	5	1	15.00	salida	Venta de producto	2024-11-22 23:01:46.054504
38	28	1	20.00	salida	Venta de producto	2024-11-22 23:01:46.160729
39	24	1	20.00	salida	Venta de producto	2024-11-22 23:01:46.207746
40	20	2	20.00	salida	Venta de producto	2024-11-22 23:51:42.016683
41	21	2	20.00	salida	Venta de producto	2024-11-22 23:51:42.02549
42	5	1	15.00	salida	Venta de producto	2024-11-22 23:51:42.030677
43	29	1	20.00	salida	Venta de producto	2024-11-22 23:51:42.036909
44	32	2	30.00	salida	Venta de producto	2024-11-22 23:51:42.043938
45	35	1	120.00	salida	Venta de producto	2024-11-22 23:51:42.04975
46	31	1	30.00	salida	Venta de producto	2024-11-22 23:51:42.054928
47	7	1	15.00	salida	Venta de producto	2024-11-23 00:30:27.079285
48	5	1	15.00	salida	Venta de producto	2024-11-23 00:30:27.087977
49	8	2	15.00	salida	Venta de producto	2024-11-23 00:30:27.093984
50	28	1	20.00	salida	Venta de producto	2024-11-23 00:30:27.100083
51	30	1	30.00	salida	Venta de producto	2024-11-23 00:30:27.106382
52	11	2	15.00	salida	Venta de producto	2024-11-23 01:05:34.899538
53	23	2	20.00	salida	Venta de producto	2024-11-23 01:05:34.905047
54	21	1	20.00	salida	Venta de producto	2024-11-23 01:05:34.908268
55	31	1	30.00	salida	Venta de producto	2024-11-23 01:05:35.244116
56	28	3	20.00	salida	Venta de producto	2024-11-23 01:05:35.251269
57	7	1	15.00	salida	Venta de producto	2024-11-23 01:05:35.258687
58	30	2	30.00	salida	Venta de producto	2024-11-23 01:05:35.265038
59	57	4	15.00	entrada	Producto agregado	2024-11-23 21:57:09.914186
60	3	1	15.00	salida	Venta de producto	2024-11-23 21:59:41.421158
61	18	2	20.00	salida	Venta de producto	2024-11-23 21:59:41.427556
62	9	1	15.00	salida	Venta de producto	2024-11-23 21:59:41.431424
63	42	1	45.00	salida	Venta de producto	2024-11-23 21:59:41.449454
64	15	1	15.00	salida	Venta de producto	2024-11-23 21:59:41.45333
65	1	1	15.00	salida	Venta de producto	2024-11-23 21:59:41.456309
66	4	2	15.00	salida	Venta de producto	2024-11-23 21:59:41.459075
67	5	1	15.00	salida	Venta de producto	2024-11-24 01:48:20.427935
68	7	1	15.00	salida	Venta de producto	2024-11-24 01:48:20.530873
69	1	1	15.00	salida	Venta de producto	2024-11-24 03:01:55.191455
70	10	1	15.00	salida	Venta de producto	2024-11-24 03:01:55.240807
71	15	1	15.00	salida	Venta de producto	2024-11-24 03:01:55.244242
72	18	2	20.00	salida	Venta de producto	2024-11-24 03:01:55.247335
73	1	3	15.00	salida	Venta de producto	2024-11-24 03:05:46.869758
74	36	1	35.00	salida	Venta de producto	2024-11-24 03:05:46.872717
75	2	1	15.00	salida	Venta de producto	2024-11-25 14:57:11.099135
76	4	2	15.00	salida	Venta de producto	2024-11-25 14:57:40.003324
108	1	1	15.00	salida	Venta de producto	2025-10-17 21:41:27.465749
\.


--
-- Data for Name: productos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.productos (id, nombre, id_categoria, precio, stock, codigo) FROM stdin;
9	Paleta grosella agua	1	15.00	98	PF009
11	Chamoy Tamarindo	1	15.00	91	PF011
12	Chamoy Mango	1	15.00	98	PF012
13	Chamoy Limon	1	15.00	94	PF013
14	Limon Pepino	1	15.00	98	PF014
16	Paleta fresa agua	1	15.00	99	PF016
17	Chocogalleta	2	20.00	5	PC001
19	Nuez	2	20.00	0	PC003
20	Capuchino	2	20.00	98	PC004
21	Cajeta	2	20.00	97	PC005
22	Paleta nanche leche	2	20.00	99	PC006
23	Paleta coco leche	2	20.00	97	PC007
24	Pistache	2	20.00	99	PC008
25	Melon con crema	2	20.00	98	PC009
26	Fresa con yogurt	2	20.00	96	PC010
27	Chabacano	2	20.00	100	PC011
28	Arroz con leche	2	20.00	95	PC012
29	Naranja con crema	2	20.00	99	PC013
30	Paleta cubierta chocolate	3	30.00	47	PCC001
31	Cono	4	30.00	98	H001
3	Paleta guayaba agua	1	15.00	97	PF003
6	Paleta limon agua	1	15.00	99	PF006
32	Vaso chico	4	30.00	98	H002
33	Vaso grande	4	60.00	49	H003
34	Canasta	4	35.00	100	H004
35	Litro	4	120.00	19	H005
37	Mangonadas	5	55.00	50	E002
38	Tostilocos	5	50.00	49	E003
39	Tostinachos	5	55.00	49	E004
8	Paleta manzanita agua	1	15.00	98	PF008
40	Dorilocos	5	50.00	48	E005
41	Dorinachos	5	40.00	50	E006
42	Paleta loca	5	45.00	49	E007
43	Vaso agua	5	25.00	100	E008
44	Litro agua	5	50.00	50	E009
45	Sandia	2	15.00	10	178526
57	Editado	2	15.00	4	OekKH
5	Paleta uva agua	1	15.00	96	PF005
7	Paleta melon agua	1	15.00	95	PF007
10	Chamoy Pina	1	15.00	97	PF010
15	Paleta nanche agua	1	15.00	48	PF015
18	Oreo	2	20.00	0	PC002
36	Palomitas	5	35.00	49	E001
2	Paleta coco agua	1	15.00	98	PF002
4	Paleta sandia agua	1	15.00	95	PF004
1	Paleta pina agua	1	15.00	95	PF001
\.


--
-- Data for Name: productos_bar; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.productos_bar (id_producto, nombre, descripcion, id_categoria, precio_venta, stock, stock_minimo) FROM stdin;
1	Pecocita	\N	1	50.00	0.00	0.00
2	Moradito	\N	1	50.00	0.00	0.00
3	Azulito	\N	1	50.00	0.00	0.00
4	Beso de angel	\N	1	50.00	0.00	0.00
5	Charro negro	\N	1	50.00	0.00	0.00
6	Desarmador	\N	1	50.00	0.00	0.00
7	Tequila sunrise	\N	1	50.00	0.00	0.00
8	Gavil n	\N	1	50.00	0.00	0.00
9	Mojito cl sico	\N	1	50.00	0.00	0.00
10	Margarita	\N	1	50.00	0.00	0.00
11	Charro blanco	\N	1	50.00	0.00	0.00
12	Paloma	\N	1	50.00	0.00	0.00
13	Cantarito cl sico	\N	1	50.00	0.00	0.00
14	Sex on the beach	\N	1	50.00	0.00	0.00
15	Cantarito gran malo	\N	1	80.00	0.00	0.00
16	Cantarito barullo	\N	1	80.00	0.00	0.00
17	Mojito maracuy 	\N	1	80.00	0.00	0.00
18	Mojito mango	\N	1	80.00	0.00	0.00
19	Mojito frutos rojos	\N	1	80.00	0.00	0.00
20	Mojito tamarindo	\N	1	80.00	0.00	0.00
21	Mojito supremo	\N	1	100.00	0.00	0.00
22	Vampiro	\N	1	80.00	0.00	0.00
23	Sub-marino	\N	1	80.00	0.00	0.00
24	Gin tonic bombay	\N	1	80.00	0.00	0.00
25	Vodka tonic	\N	1	80.00	0.00	0.00
26	Mezcal tonic	\N	1	80.00	0.00	0.00
27	Clericot	\N	1	80.00	0.00	0.00
28	Perla negra	\N	1	80.00	0.00	0.00
29	Pi¤a colada	\N	1	80.00	0.00	0.00
30	Media de seda	\N	1	80.00	0.00	0.00
31	Negroni	\N	1	80.00	0.00	0.00
32	Flotante	\N	1	80.00	0.00	0.00
33	Aperol spritz	\N	1	80.00	0.00	0.00
34	Tinto de primavera	\N	1	80.00	0.00	0.00
35	Carajillo	\N	1	80.00	0.00	0.00
36	Martini	\N	1	80.00	0.00	0.00
37	Bombon	\N	1	80.00	0.00	0.00
38	Orgasmo	\N	1	80.00	0.00	0.00
39	Corona 1/2	\N	2	30.00	0.00	0.00
40	Victoria 1/2	\N	2	30.00	0.00	0.00
41	Corona cero 1/2	\N	2	30.00	0.00	0.00
42	Michelob ultra	\N	2	40.00	0.00	0.00
43	Negra modelo	\N	2	80.00	0.00	0.00
44	Pacifico	\N	2	40.00	0.00	0.00
45	Chelada	\N	2	50.00	0.00	0.00
46	Michelada cl sica	\N	2	80.00	0.00	0.00
47	Michelada de sabor	\N	2	100.00	0.00	0.00
48	Cart¢n victoria	\N	2	700.00	0.00	0.00
49	Cart¢n corona	\N	2	700.00	0.00	0.00
50	Yardas 3Lt	\N	2	250.00	0.00	0.00
51	Mezcal caballito	\N	2	50.00	0.00	0.00
52	Espadin caballito	\N	2	50.00	0.00	0.00
53	Tobal  caballito	\N	2	50.00	0.00	0.00
54	Tequila	\N	2	50.00	0.00	0.00
55	Etiqueta roja - Copa	\N	3	50.00	0.00	0.00
56	Etiqueta roja - Botella	\N	3	700.00	0.00	0.00
57	Torres 10 - Copa	\N	3	50.00	0.00	0.00
58	Torres 10 - Botella	\N	3	700.00	0.00	0.00
59	Torres 5 - Copa	\N	3	50.00	0.00	0.00
60	Torres 5 - Botella	\N	3	700.00	0.00	0.00
61	Absolut azul - Copa	\N	3	50.00	0.00	0.00
62	Absolut azul - Botella	\N	3	700.00	0.00	0.00
63	Absolut raspberri - Copa	\N	3	50.00	0.00	0.00
64	Absolut raspberri - Botella	\N	3	700.00	0.00	0.00
65	Bacardi blanco - Copa	\N	3	50.00	0.00	0.00
66	Bacardi blanco - Botella	\N	3	700.00	0.00	0.00
67	Bacardi raspberri - Copa	\N	3	50.00	0.00	0.00
68	Bacardi raspberri - Botella	\N	3	700.00	0.00	0.00
69	Capitan morgan - Copa	\N	3	50.00	0.00	0.00
70	Capitan morgan - Botella	\N	3	700.00	0.00	0.00
71	Smirnoff - Copa	\N	3	50.00	0.00	0.00
72	Smirnoff - Botella	\N	3	700.00	0.00	0.00
73	Smirnoff tamarindo - Copa	\N	3	50.00	0.00	0.00
74	Smirnoff tamarindo - Botella	\N	3	700.00	0.00	0.00
75	Black and white - Copa	\N	3	50.00	0.00	0.00
76	Black and white - Botella	\N	3	700.00	0.00	0.00
77	Tequila hornitos - Copa	\N	3	50.00	0.00	0.00
78	Tequila hornitos - Botella	\N	3	700.00	0.00	0.00
79	Tequila jimador - Copa	\N	3	50.00	0.00	0.00
80	Tequila jimador - Botella	\N	3	700.00	0.00	0.00
81	Tequila gran malo - Copa	\N	3	50.00	0.00	0.00
82	Tequila gran malo - Botella	\N	3	700.00	0.00	0.00
83	Jack daniels - Copa	\N	4	100.00	0.00	0.00
84	Jack daniels - Botella	\N	4	1500.00	0.00	0.00
85	Jack daniels honey - Copa	\N	4	100.00	0.00	0.00
86	Jack daniels honey - Botella	\N	4	1500.00	0.00	0.00
87	Jack daniels apple - Copa	\N	4	100.00	0.00	0.00
88	Jack daniels apple - Botella	\N	4	1500.00	0.00	0.00
89	Buchanas 12 - Copa	\N	4	100.00	0.00	0.00
90	Buchanas 12 - Botella	\N	4	1500.00	0.00	0.00
91	Jagermeister - Copa	\N	4	100.00	0.00	0.00
92	Jagermeister - Botella	\N	4	1500.00	0.00	0.00
93	Tequila maestro dobel diamante - Copa	\N	4	100.00	0.00	0.00
94	Tequila maestro dobel diamante - Botella	\N	4	1500.00	0.00	0.00
95	Etiqueta negra - Copa	\N	4	120.00	0.00	0.00
96	Etiqueta negra - Botella	\N	4	1700.00	0.00	0.00
97	Hipnotiq - Copa	\N	4	120.00	0.00	0.00
98	Hipnotiq - Botella	\N	4	1700.00	0.00	0.00
99	Don julio 70 - Copa	\N	4	150.00	0.00	0.00
100	Don julio 70 - Botella	\N	4	2000.00	0.00	0.00
101	Champagne moet - Botella	\N	4	2500.00	0.00	0.00
102	Tequila barullo - Copa	\N	4	150.00	0.00	0.00
103	Tequila barullo - Botella	\N	4	900.00	0.00	0.00
104	Coca cola	\N	5	30.00	0.00	0.00
105	Manzanita	\N	5	30.00	0.00	0.00
106	Squirt	\N	5	30.00	0.00	0.00
107	7 up	\N	5	30.00	0.00	0.00
108	Agua mineral	\N	5	30.00	0.00	0.00
109	Agua natural	\N	5	30.00	0.00	0.00
110	Limonada	\N	5	40.00	0.00	0.00
111	Naranjada	\N	5	40.00	0.00	0.00
112	Suero agua mineral	\N	5	40.00	0.00	0.00
113	Boost	\N	5	50.00	0.00	0.00
114	Frappe cl sico	\N	5	60.00	0.00	0.00
115	Frappe oreo	\N	5	70.00	0.00	0.00
116	Frappe magnum	\N	5	80.00	0.00	0.00
117	Malboro rojo - Cajetilla	\N	6	150.00	0.00	0.00
118	Malboro rojo - Suelto	\N	6	10.00	0.00	0.00
119	Malboro mentolado - Cajetilla	\N	6	150.00	0.00	0.00
120	Malboro mentolado - Suelto	\N	6	10.00	0.00	0.00
121	Malboro clavo - Cajetilla	\N	6	150.00	0.00	0.00
122	Malboro clavo - Suelto	\N	6	10.00	0.00	0.00
123	Uva - Vaso	\N	7	40.00	0.00	0.00
124	Uva - Jarra	\N	7	70.00	0.00	0.00
125	Pi¤a - Vaso	\N	7	40.00	0.00	0.00
126	Pi¤a - Jarra	\N	7	70.00	0.00	0.00
127	Ar ndano - Vaso	\N	7	40.00	0.00	0.00
128	Ar ndano - Jarra	\N	7	80.00	0.00	0.00
129	Maruchan	\N	8	35.00	0.00	0.00
130	Torta jam¢n	\N	8	40.00	0.00	0.00
131	Torta quesillo	\N	8	40.00	0.00	0.00
132	Torta salchicha ejuteca	\N	8	50.00	0.00	0.00
133	Club sandwich	\N	8	50.00	0.00	0.00
134	Sincronizada	\N	8	45.00	0.00	0.00
135	Nachos	\N	8	50.00	0.00	0.00
136	Papas a la francesa	\N	8	50.00	0.00	0.00
137	Hamburguesa cl sica	\N	8	80.00	0.00	0.00
138	Nuggets	\N	8	80.00	0.00	0.00
139	Alitas Bbq	\N	9	100.00	0.00	0.00
140	Alitas Habanero	\N	9	100.00	0.00	0.00
141	Alitas Mango habanero	\N	9	100.00	0.00	0.00
142	Alitas Buffalo	\N	9	100.00	0.00	0.00
143	Promo 2 ord	\N	9	180.00	0.00	0.00
\.


--
-- Data for Name: productos_respaldo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.productos_respaldo (id, nombre, id_categoria, precio, stock, fecha_respaldo, codigo) FROM stdin;
1	Chamoy Tamarindo	1	15.00	94	2024-11-21	PF011     
2	Capuchino	2	20.00	100	2024-11-21	PC004     
3	Cajeta	2	20.00	100	2024-11-21	PC005     
4	Paleta coco leche	2	20.00	100	2024-11-21	PC007     
5	Pistache	2	20.00	100	2024-11-21	PC008     
6	Paleta uva agua	1	15.00	100	2024-11-21	PF005     
7	Paleta melon agua	1	15.00	100	2024-11-21	PF007     
8	Paleta manzanita agua	1	15.00	100	2024-11-21	PF008     
9	Chabacano	2	20.00	100	2024-11-21	PC011     
10	Arroz con leche	2	20.00	100	2024-11-21	PC012     
11	Naranja con crema	2	20.00	100	2024-11-21	PC013     
12	Paleta cubierta chocolate	3	30.00	50	2024-11-21	PCC001    
13	Cono	4	30.00	100	2024-11-21	H001      
14	Vaso chico	4	30.00	100	2024-11-21	H002      
15	Canasta	4	35.00	100	2024-11-21	H004      
16	Litro	4	120.00	20	2024-11-21	H005      
17	Palomitas	5	35.00	50	2024-11-21	E001      
18	Mangonadas	5	55.00	50	2024-11-21	E002      
19	Dorinachos	5	40.00	50	2024-11-21	E006      
20	Paleta loca	5	45.00	50	2024-11-21	E007      
21	Vaso agua	5	25.00	100	2024-11-21	E008      
22	Litro agua	5	50.00	50	2024-11-21	E009      
23	Sandia	2	15.00	10	2024-11-21	178526    
24	Paleta coco agua	1	15.00	99	2024-11-21	PF002     
25	Paleta limon agua	1	15.00	99	2024-11-21	PF006     
26	Paleta grosella agua	1	15.00	99	2024-11-21	PF009     
27	Paleta pina agua	1	15.00	97	2024-11-21	PF001     
28	Paleta guayaba agua	1	15.00	98	2024-11-21	PF003     
29	Chamoy Pina	1	15.00	98	2024-11-21	PF010     
30	Tostinachos	5	55.00	49	2024-11-21	E004      
31	Tostilocos	5	50.00	49	2024-11-21	E003      
32	Dorilocos	5	50.00	48	2024-11-21	E005      
33	Chamoy Mango	1	15.00	98	2024-11-21	PF012     
34	Paleta fresa agua	1	15.00	99	2024-11-21	PF016     
35	Paleta nanche leche	2	20.00	99	2024-11-21	PC006     
36	Limon Pepino	1	15.00	98	2024-11-21	PF014     
37	Paleta nanche agua	1	15.00	50	2024-11-21	PF015     
38	Chocogalleta	2	20.00	5	2024-11-21	PC001     
39	Oreo	2	20.00	4	2024-11-21	PC002     
40	Nuez	2	20.00	0	2024-11-21	PC003     
41	Paleta sandia agua	1	15.00	99	2024-11-21	PF004     
42	Vaso grande	4	60.00	49	2024-11-21	H003      
43	Melon con crema	2	20.00	98	2024-11-21	PC009     
44	Fresa con yogurt	2	20.00	96	2024-11-21	PC010     
45	Chamoy Limon	1	15.00	94	2024-11-21	PF013     
46	Chamoy Tamarindo	1	15.00	93	2024-11-22	PF011     
47	Paleta coco leche	2	20.00	99	2024-11-22	PC007     
48	Paleta melon agua	1	15.00	98	2024-11-22	PF007     
49	Arroz con leche	2	20.00	99	2024-11-22	PC012     
50	Pistache	2	20.00	99	2024-11-22	PC008     
51	Capuchino	2	20.00	98	2024-11-22	PC004     
52	Cajeta	2	20.00	98	2024-11-22	PC005     
53	Paleta uva agua	1	15.00	98	2024-11-22	PF005     
54	Naranja con crema	2	20.00	99	2024-11-22	PC013     
55	Vaso chico	4	30.00	98	2024-11-22	H002      
56	Litro	4	120.00	19	2024-11-22	H005      
57	Cono	4	30.00	99	2024-11-22	H001      
58	Paleta manzanita agua	1	15.00	100	2024-11-22	PF008     
59	Chabacano	2	20.00	100	2024-11-22	PC011     
60	Paleta cubierta chocolate	3	30.00	50	2024-11-22	PCC001    
61	Canasta	4	35.00	100	2024-11-22	H004      
62	Palomitas	5	35.00	50	2024-11-22	E001      
63	Mangonadas	5	55.00	50	2024-11-22	E002      
64	Dorinachos	5	40.00	50	2024-11-22	E006      
65	Paleta loca	5	45.00	50	2024-11-22	E007      
66	Vaso agua	5	25.00	100	2024-11-22	E008      
67	Litro agua	5	50.00	50	2024-11-22	E009      
68	Sandia	2	15.00	10	2024-11-22	178526    
69	Paleta coco agua	1	15.00	99	2024-11-22	PF002     
70	Paleta limon agua	1	15.00	99	2024-11-22	PF006     
71	Paleta grosella agua	1	15.00	99	2024-11-22	PF009     
72	Paleta pina agua	1	15.00	97	2024-11-22	PF001     
73	Paleta guayaba agua	1	15.00	98	2024-11-22	PF003     
74	Chamoy Pina	1	15.00	98	2024-11-22	PF010     
75	Tostinachos	5	55.00	49	2024-11-22	E004      
76	Tostilocos	5	50.00	49	2024-11-22	E003      
77	Dorilocos	5	50.00	48	2024-11-22	E005      
78	Chamoy Mango	1	15.00	98	2024-11-22	PF012     
79	Paleta fresa agua	1	15.00	99	2024-11-22	PF016     
80	Paleta nanche leche	2	20.00	99	2024-11-22	PC006     
81	Limon Pepino	1	15.00	98	2024-11-22	PF014     
82	Paleta nanche agua	1	15.00	50	2024-11-22	PF015     
83	Chocogalleta	2	20.00	5	2024-11-22	PC001     
84	Oreo	2	20.00	4	2024-11-22	PC002     
85	Nuez	2	20.00	0	2024-11-22	PC003     
86	Paleta sandia agua	1	15.00	99	2024-11-22	PF004     
87	Vaso grande	4	60.00	49	2024-11-22	H003      
88	Melon con crema	2	20.00	98	2024-11-22	PC009     
89	Fresa con yogurt	2	20.00	96	2024-11-22	PC010     
90	Chamoy Limon	1	15.00	94	2024-11-22	PF013     
91	Pistache	2	20.00	99	2024-11-23	PC008     
92	Capuchino	2	20.00	98	2024-11-23	PC004     
93	Naranja con crema	2	20.00	99	2024-11-23	PC013     
94	Vaso chico	4	30.00	98	2024-11-23	H002      
95	Litro	4	120.00	19	2024-11-23	H005      
96	Paleta uva agua	1	15.00	97	2024-11-23	PF005     
97	Paleta manzanita agua	1	15.00	98	2024-11-23	PF008     
98	Chamoy Tamarindo	1	15.00	91	2024-11-23	PF011     
99	Paleta coco leche	2	20.00	97	2024-11-23	PC007     
100	Cajeta	2	20.00	97	2024-11-23	PC005     
101	Cono	4	30.00	98	2024-11-23	H001      
102	Arroz con leche	2	20.00	95	2024-11-23	PC012     
103	Paleta melon agua	1	15.00	96	2024-11-23	PF007     
104	Paleta cubierta chocolate	3	30.00	47	2024-11-23	PCC001    
105	df	2	15.00	4	2024-11-23	OekKH     
106	Paleta guayaba agua	1	15.00	97	2024-11-23	PF003     
107	Oreo	2	20.00	2	2024-11-23	PC002     
108	Paleta grosella agua	1	15.00	98	2024-11-23	PF009     
109	Paleta loca	5	45.00	49	2024-11-23	E007      
110	Paleta nanche agua	1	15.00	49	2024-11-23	PF015     
111	Paleta pina agua	1	15.00	96	2024-11-23	PF001     
112	Paleta sandia agua	1	15.00	97	2024-11-23	PF004     
113	Chabacano	2	20.00	100	2024-11-23	PC011     
114	Canasta	4	35.00	100	2024-11-23	H004      
115	Palomitas	5	35.00	50	2024-11-23	E001      
116	Mangonadas	5	55.00	50	2024-11-23	E002      
117	Dorinachos	5	40.00	50	2024-11-23	E006      
118	Vaso agua	5	25.00	100	2024-11-23	E008      
119	Litro agua	5	50.00	50	2024-11-23	E009      
120	Sandia	2	15.00	10	2024-11-23	178526    
121	Paleta coco agua	1	15.00	99	2024-11-23	PF002     
122	Paleta limon agua	1	15.00	99	2024-11-23	PF006     
123	Chamoy Pina	1	15.00	98	2024-11-23	PF010     
124	Tostinachos	5	55.00	49	2024-11-23	E004      
125	Tostilocos	5	50.00	49	2024-11-23	E003      
126	Dorilocos	5	50.00	48	2024-11-23	E005      
127	Chamoy Mango	1	15.00	98	2024-11-23	PF012     
128	Paleta fresa agua	1	15.00	99	2024-11-23	PF016     
129	Paleta nanche leche	2	20.00	99	2024-11-23	PC006     
130	Limon Pepino	1	15.00	98	2024-11-23	PF014     
131	Chocogalleta	2	20.00	5	2024-11-23	PC001     
132	Nuez	2	20.00	0	2024-11-23	PC003     
133	Vaso grande	4	60.00	49	2024-11-23	H003      
134	Melon con crema	2	20.00	98	2024-11-23	PC009     
135	Fresa con yogurt	2	20.00	96	2024-11-23	PC010     
136	Chamoy Limon	1	15.00	94	2024-11-23	PF013     
137	Paleta grosella agua	1	15.00	98	2024-11-24	PF009     
138	Chamoy Tamarindo	1	15.00	91	2024-11-24	PF011     
139	Chamoy Mango	1	15.00	98	2024-11-24	PF012     
140	Chamoy Limon	1	15.00	94	2024-11-24	PF013     
141	Limon Pepino	1	15.00	98	2024-11-24	PF014     
142	Paleta fresa agua	1	15.00	99	2024-11-24	PF016     
143	Chocogalleta	2	20.00	5	2024-11-24	PC001     
144	Nuez	2	20.00	0	2024-11-24	PC003     
145	Capuchino	2	20.00	98	2024-11-24	PC004     
146	Cajeta	2	20.00	97	2024-11-24	PC005     
147	Paleta nanche leche	2	20.00	99	2024-11-24	PC006     
148	Paleta coco leche	2	20.00	97	2024-11-24	PC007     
149	Pistache	2	20.00	99	2024-11-24	PC008     
150	Melon con crema	2	20.00	98	2024-11-24	PC009     
151	Fresa con yogurt	2	20.00	96	2024-11-24	PC010     
152	Chabacano	2	20.00	100	2024-11-24	PC011     
153	Arroz con leche	2	20.00	95	2024-11-24	PC012     
154	Naranja con crema	2	20.00	99	2024-11-24	PC013     
155	Paleta cubierta chocolate	3	30.00	47	2024-11-24	PCC001    
156	Cono	4	30.00	98	2024-11-24	H001      
157	Paleta coco agua	1	15.00	99	2024-11-24	PF002     
158	Paleta guayaba agua	1	15.00	97	2024-11-24	PF003     
159	Paleta sandia agua	1	15.00	97	2024-11-24	PF004     
160	Paleta limon agua	1	15.00	99	2024-11-24	PF006     
161	Vaso chico	4	30.00	98	2024-11-24	H002      
162	Vaso grande	4	60.00	49	2024-11-24	H003      
163	Canasta	4	35.00	100	2024-11-24	H004      
164	Litro	4	120.00	19	2024-11-24	H005      
165	Mangonadas	5	55.00	50	2024-11-24	E002      
166	Tostilocos	5	50.00	49	2024-11-24	E003      
167	Tostinachos	5	55.00	49	2024-11-24	E004      
168	Paleta manzanita agua	1	15.00	98	2024-11-24	PF008     
169	Dorilocos	5	50.00	48	2024-11-24	E005      
170	Dorinachos	5	40.00	50	2024-11-24	E006      
171	Paleta loca	5	45.00	49	2024-11-24	E007      
172	Vaso agua	5	25.00	100	2024-11-24	E008      
173	Litro agua	5	50.00	50	2024-11-24	E009      
174	Sandia	2	15.00	10	2024-11-24	178526    
175	Editado	2	15.00	4	2024-11-24	OekKH     
176	Paleta uva agua	1	15.00	96	2024-11-24	PF005     
177	Paleta melon agua	1	15.00	95	2024-11-24	PF007     
178	Chamoy Pina	1	15.00	97	2024-11-24	PF010     
179	Paleta nanche agua	1	15.00	48	2024-11-24	PF015     
180	Oreo	2	20.00	0	2024-11-24	PC002     
181	Paleta pina agua	1	15.00	96	2024-11-24	PF001     
182	Palomitas	5	35.00	49	2024-11-24	E001      
203	Paleta grosella agua	1	15.00	98	2025-03-28	PF009     
204	Chamoy Tamarindo	1	15.00	91	2025-03-28	PF011     
205	Chamoy Mango	1	15.00	98	2025-03-28	PF012     
206	Chamoy Limon	1	15.00	94	2025-03-28	PF013     
207	Limon Pepino	1	15.00	98	2025-03-28	PF014     
208	Paleta fresa agua	1	15.00	99	2025-03-28	PF016     
209	Chocogalleta	2	20.00	5	2025-03-28	PC001     
210	Nuez	2	20.00	0	2025-03-28	PC003     
211	Capuchino	2	20.00	98	2025-03-28	PC004     
212	Cajeta	2	20.00	97	2025-03-28	PC005     
213	Paleta nanche leche	2	20.00	99	2025-03-28	PC006     
214	Paleta coco leche	2	20.00	97	2025-03-28	PC007     
215	Pistache	2	20.00	99	2025-03-28	PC008     
216	Melon con crema	2	20.00	98	2025-03-28	PC009     
217	Fresa con yogurt	2	20.00	96	2025-03-28	PC010     
218	Chabacano	2	20.00	100	2025-03-28	PC011     
219	Arroz con leche	2	20.00	95	2025-03-28	PC012     
220	Naranja con crema	2	20.00	99	2025-03-28	PC013     
221	Paleta cubierta chocolate	3	30.00	47	2025-03-28	PCC001    
222	Cono	4	30.00	98	2025-03-28	H001      
223	Paleta guayaba agua	1	15.00	97	2025-03-28	PF003     
224	Paleta limon agua	1	15.00	99	2025-03-28	PF006     
225	Vaso chico	4	30.00	98	2025-03-28	H002      
226	Vaso grande	4	60.00	49	2025-03-28	H003      
227	Canasta	4	35.00	100	2025-03-28	H004      
228	Litro	4	120.00	19	2025-03-28	H005      
229	Mangonadas	5	55.00	50	2025-03-28	E002      
230	Tostilocos	5	50.00	49	2025-03-28	E003      
231	Tostinachos	5	55.00	49	2025-03-28	E004      
232	Paleta manzanita agua	1	15.00	98	2025-03-28	PF008     
233	Dorilocos	5	50.00	48	2025-03-28	E005      
234	Dorinachos	5	40.00	50	2025-03-28	E006      
235	Paleta loca	5	45.00	49	2025-03-28	E007      
236	Vaso agua	5	25.00	100	2025-03-28	E008      
237	Litro agua	5	50.00	50	2025-03-28	E009      
238	Sandia	2	15.00	10	2025-03-28	178526    
239	Editado	2	15.00	4	2025-03-28	OekKH     
240	Paleta uva agua	1	15.00	96	2025-03-28	PF005     
241	Paleta melon agua	1	15.00	95	2025-03-28	PF007     
242	Chamoy Pina	1	15.00	97	2025-03-28	PF010     
243	Paleta nanche agua	1	15.00	48	2025-03-28	PF015     
244	Oreo	2	20.00	0	2025-03-28	PC002     
245	Paleta pina agua	1	15.00	96	2025-03-28	PF001     
246	Palomitas	5	35.00	49	2025-03-28	E001      
247	Paleta coco agua	1	15.00	98	2025-03-28	PF002     
248	Paleta sandia agua	1	15.00	95	2025-03-28	PF004     
249	Paleta grosella agua	1	15.00	98	2025-04-02	PF009     
250	Chamoy Tamarindo	1	15.00	91	2025-04-02	PF011     
251	Chamoy Mango	1	15.00	98	2025-04-02	PF012     
252	Chamoy Limon	1	15.00	94	2025-04-02	PF013     
253	Limon Pepino	1	15.00	98	2025-04-02	PF014     
254	Paleta fresa agua	1	15.00	99	2025-04-02	PF016     
255	Chocogalleta	2	20.00	5	2025-04-02	PC001     
256	Nuez	2	20.00	0	2025-04-02	PC003     
257	Capuchino	2	20.00	98	2025-04-02	PC004     
258	Cajeta	2	20.00	97	2025-04-02	PC005     
259	Paleta nanche leche	2	20.00	99	2025-04-02	PC006     
260	Paleta coco leche	2	20.00	97	2025-04-02	PC007     
261	Pistache	2	20.00	99	2025-04-02	PC008     
262	Melon con crema	2	20.00	98	2025-04-02	PC009     
263	Fresa con yogurt	2	20.00	96	2025-04-02	PC010     
264	Chabacano	2	20.00	100	2025-04-02	PC011     
265	Arroz con leche	2	20.00	95	2025-04-02	PC012     
266	Naranja con crema	2	20.00	99	2025-04-02	PC013     
267	Paleta cubierta chocolate	3	30.00	47	2025-04-02	PCC001    
268	Cono	4	30.00	98	2025-04-02	H001      
269	Paleta guayaba agua	1	15.00	97	2025-04-02	PF003     
270	Paleta limon agua	1	15.00	99	2025-04-02	PF006     
271	Vaso chico	4	30.00	98	2025-04-02	H002      
272	Vaso grande	4	60.00	49	2025-04-02	H003      
273	Canasta	4	35.00	100	2025-04-02	H004      
274	Litro	4	120.00	19	2025-04-02	H005      
275	Mangonadas	5	55.00	50	2025-04-02	E002      
276	Tostilocos	5	50.00	49	2025-04-02	E003      
277	Tostinachos	5	55.00	49	2025-04-02	E004      
278	Paleta manzanita agua	1	15.00	98	2025-04-02	PF008     
279	Dorilocos	5	50.00	48	2025-04-02	E005      
280	Dorinachos	5	40.00	50	2025-04-02	E006      
281	Paleta loca	5	45.00	49	2025-04-02	E007      
282	Vaso agua	5	25.00	100	2025-04-02	E008      
283	Litro agua	5	50.00	50	2025-04-02	E009      
284	Sandia	2	15.00	10	2025-04-02	178526    
285	Editado	2	15.00	4	2025-04-02	OekKH     
286	Paleta uva agua	1	15.00	96	2025-04-02	PF005     
287	Paleta melon agua	1	15.00	95	2025-04-02	PF007     
288	Chamoy Pina	1	15.00	97	2025-04-02	PF010     
289	Paleta nanche agua	1	15.00	48	2025-04-02	PF015     
290	Oreo	2	20.00	0	2025-04-02	PC002     
291	Paleta pina agua	1	15.00	96	2025-04-02	PF001     
292	Palomitas	5	35.00	49	2025-04-02	E001      
293	Paleta coco agua	1	15.00	98	2025-04-02	PF002     
294	Paleta sandia agua	1	15.00	95	2025-04-02	PF004     
295	Paleta grosella agua	1	15.00	98	2025-04-03	PF009     
296	Chamoy Tamarindo	1	15.00	91	2025-04-03	PF011     
297	Chamoy Mango	1	15.00	98	2025-04-03	PF012     
298	Chamoy Limon	1	15.00	94	2025-04-03	PF013     
299	Limon Pepino	1	15.00	98	2025-04-03	PF014     
300	Paleta fresa agua	1	15.00	99	2025-04-03	PF016     
301	Chocogalleta	2	20.00	5	2025-04-03	PC001     
302	Nuez	2	20.00	0	2025-04-03	PC003     
303	Capuchino	2	20.00	98	2025-04-03	PC004     
304	Cajeta	2	20.00	97	2025-04-03	PC005     
305	Paleta nanche leche	2	20.00	99	2025-04-03	PC006     
306	Paleta coco leche	2	20.00	97	2025-04-03	PC007     
307	Pistache	2	20.00	99	2025-04-03	PC008     
308	Melon con crema	2	20.00	98	2025-04-03	PC009     
309	Fresa con yogurt	2	20.00	96	2025-04-03	PC010     
310	Chabacano	2	20.00	100	2025-04-03	PC011     
311	Arroz con leche	2	20.00	95	2025-04-03	PC012     
312	Naranja con crema	2	20.00	99	2025-04-03	PC013     
313	Paleta cubierta chocolate	3	30.00	47	2025-04-03	PCC001    
314	Cono	4	30.00	98	2025-04-03	H001      
315	Paleta guayaba agua	1	15.00	97	2025-04-03	PF003     
316	Paleta limon agua	1	15.00	99	2025-04-03	PF006     
317	Vaso chico	4	30.00	98	2025-04-03	H002      
318	Vaso grande	4	60.00	49	2025-04-03	H003      
319	Canasta	4	35.00	100	2025-04-03	H004      
320	Litro	4	120.00	19	2025-04-03	H005      
321	Mangonadas	5	55.00	50	2025-04-03	E002      
322	Tostilocos	5	50.00	49	2025-04-03	E003      
323	Tostinachos	5	55.00	49	2025-04-03	E004      
324	Paleta manzanita agua	1	15.00	98	2025-04-03	PF008     
325	Dorilocos	5	50.00	48	2025-04-03	E005      
326	Dorinachos	5	40.00	50	2025-04-03	E006      
327	Paleta loca	5	45.00	49	2025-04-03	E007      
328	Vaso agua	5	25.00	100	2025-04-03	E008      
329	Litro agua	5	50.00	50	2025-04-03	E009      
330	Sandia	2	15.00	10	2025-04-03	178526    
331	Editado	2	15.00	4	2025-04-03	OekKH     
332	Paleta uva agua	1	15.00	96	2025-04-03	PF005     
333	Paleta melon agua	1	15.00	95	2025-04-03	PF007     
334	Chamoy Pina	1	15.00	97	2025-04-03	PF010     
335	Paleta nanche agua	1	15.00	48	2025-04-03	PF015     
336	Oreo	2	20.00	0	2025-04-03	PC002     
337	Paleta pina agua	1	15.00	96	2025-04-03	PF001     
338	Palomitas	5	35.00	49	2025-04-03	E001      
339	Paleta coco agua	1	15.00	98	2025-04-03	PF002     
340	Paleta sandia agua	1	15.00	95	2025-04-03	PF004     
341	Paleta grosella agua	1	15.00	98	2025-04-04	PF009     
342	Chamoy Tamarindo	1	15.00	91	2025-04-04	PF011     
343	Chamoy Mango	1	15.00	98	2025-04-04	PF012     
344	Chamoy Limon	1	15.00	94	2025-04-04	PF013     
345	Limon Pepino	1	15.00	98	2025-04-04	PF014     
346	Paleta fresa agua	1	15.00	99	2025-04-04	PF016     
347	Chocogalleta	2	20.00	5	2025-04-04	PC001     
348	Nuez	2	20.00	0	2025-04-04	PC003     
349	Capuchino	2	20.00	98	2025-04-04	PC004     
350	Cajeta	2	20.00	97	2025-04-04	PC005     
351	Paleta nanche leche	2	20.00	99	2025-04-04	PC006     
352	Paleta coco leche	2	20.00	97	2025-04-04	PC007     
353	Pistache	2	20.00	99	2025-04-04	PC008     
354	Melon con crema	2	20.00	98	2025-04-04	PC009     
355	Fresa con yogurt	2	20.00	96	2025-04-04	PC010     
356	Chabacano	2	20.00	100	2025-04-04	PC011     
357	Arroz con leche	2	20.00	95	2025-04-04	PC012     
358	Naranja con crema	2	20.00	99	2025-04-04	PC013     
359	Paleta cubierta chocolate	3	30.00	47	2025-04-04	PCC001    
360	Cono	4	30.00	98	2025-04-04	H001      
361	Paleta guayaba agua	1	15.00	97	2025-04-04	PF003     
362	Paleta limon agua	1	15.00	99	2025-04-04	PF006     
363	Vaso chico	4	30.00	98	2025-04-04	H002      
364	Vaso grande	4	60.00	49	2025-04-04	H003      
365	Canasta	4	35.00	100	2025-04-04	H004      
366	Litro	4	120.00	19	2025-04-04	H005      
367	Mangonadas	5	55.00	50	2025-04-04	E002      
368	Tostilocos	5	50.00	49	2025-04-04	E003      
369	Tostinachos	5	55.00	49	2025-04-04	E004      
370	Paleta manzanita agua	1	15.00	98	2025-04-04	PF008     
371	Dorilocos	5	50.00	48	2025-04-04	E005      
372	Dorinachos	5	40.00	50	2025-04-04	E006      
373	Paleta loca	5	45.00	49	2025-04-04	E007      
374	Vaso agua	5	25.00	100	2025-04-04	E008      
375	Litro agua	5	50.00	50	2025-04-04	E009      
376	Sandia	2	15.00	10	2025-04-04	178526    
377	Editado	2	15.00	4	2025-04-04	OekKH     
378	Paleta uva agua	1	15.00	96	2025-04-04	PF005     
379	Paleta melon agua	1	15.00	95	2025-04-04	PF007     
380	Chamoy Pina	1	15.00	97	2025-04-04	PF010     
381	Paleta nanche agua	1	15.00	48	2025-04-04	PF015     
382	Oreo	2	20.00	0	2025-04-04	PC002     
383	Paleta pina agua	1	15.00	96	2025-04-04	PF001     
384	Palomitas	5	35.00	49	2025-04-04	E001      
385	Paleta coco agua	1	15.00	98	2025-04-04	PF002     
386	Paleta sandia agua	1	15.00	95	2025-04-04	PF004     
387	Paleta grosella agua	1	15.00	98	2025-04-05	PF009     
388	Chamoy Tamarindo	1	15.00	91	2025-04-05	PF011     
389	Chamoy Mango	1	15.00	98	2025-04-05	PF012     
390	Chamoy Limon	1	15.00	94	2025-04-05	PF013     
391	Limon Pepino	1	15.00	98	2025-04-05	PF014     
392	Paleta fresa agua	1	15.00	99	2025-04-05	PF016     
393	Chocogalleta	2	20.00	5	2025-04-05	PC001     
394	Nuez	2	20.00	0	2025-04-05	PC003     
395	Capuchino	2	20.00	98	2025-04-05	PC004     
396	Cajeta	2	20.00	97	2025-04-05	PC005     
397	Paleta nanche leche	2	20.00	99	2025-04-05	PC006     
398	Paleta coco leche	2	20.00	97	2025-04-05	PC007     
399	Pistache	2	20.00	99	2025-04-05	PC008     
400	Melon con crema	2	20.00	98	2025-04-05	PC009     
401	Fresa con yogurt	2	20.00	96	2025-04-05	PC010     
402	Chabacano	2	20.00	100	2025-04-05	PC011     
403	Arroz con leche	2	20.00	95	2025-04-05	PC012     
404	Naranja con crema	2	20.00	99	2025-04-05	PC013     
405	Paleta cubierta chocolate	3	30.00	47	2025-04-05	PCC001    
406	Cono	4	30.00	98	2025-04-05	H001      
407	Paleta guayaba agua	1	15.00	97	2025-04-05	PF003     
408	Paleta limon agua	1	15.00	99	2025-04-05	PF006     
409	Vaso chico	4	30.00	98	2025-04-05	H002      
410	Vaso grande	4	60.00	49	2025-04-05	H003      
411	Canasta	4	35.00	100	2025-04-05	H004      
412	Litro	4	120.00	19	2025-04-05	H005      
413	Mangonadas	5	55.00	50	2025-04-05	E002      
414	Tostilocos	5	50.00	49	2025-04-05	E003      
415	Tostinachos	5	55.00	49	2025-04-05	E004      
416	Paleta manzanita agua	1	15.00	98	2025-04-05	PF008     
417	Dorilocos	5	50.00	48	2025-04-05	E005      
418	Dorinachos	5	40.00	50	2025-04-05	E006      
419	Paleta loca	5	45.00	49	2025-04-05	E007      
420	Vaso agua	5	25.00	100	2025-04-05	E008      
421	Litro agua	5	50.00	50	2025-04-05	E009      
422	Sandia	2	15.00	10	2025-04-05	178526    
423	Editado	2	15.00	4	2025-04-05	OekKH     
424	Paleta uva agua	1	15.00	96	2025-04-05	PF005     
425	Paleta melon agua	1	15.00	95	2025-04-05	PF007     
426	Chamoy Pina	1	15.00	97	2025-04-05	PF010     
427	Paleta nanche agua	1	15.00	48	2025-04-05	PF015     
428	Oreo	2	20.00	0	2025-04-05	PC002     
429	Paleta pina agua	1	15.00	96	2025-04-05	PF001     
430	Palomitas	5	35.00	49	2025-04-05	E001      
431	Paleta coco agua	1	15.00	98	2025-04-05	PF002     
432	Paleta sandia agua	1	15.00	95	2025-04-05	PF004     
433	Paleta grosella agua	1	15.00	98	2025-04-06	PF009     
434	Chamoy Tamarindo	1	15.00	91	2025-04-06	PF011     
435	Chamoy Mango	1	15.00	98	2025-04-06	PF012     
436	Chamoy Limon	1	15.00	94	2025-04-06	PF013     
437	Limon Pepino	1	15.00	98	2025-04-06	PF014     
438	Paleta fresa agua	1	15.00	99	2025-04-06	PF016     
439	Chocogalleta	2	20.00	5	2025-04-06	PC001     
440	Nuez	2	20.00	0	2025-04-06	PC003     
441	Capuchino	2	20.00	98	2025-04-06	PC004     
442	Cajeta	2	20.00	97	2025-04-06	PC005     
443	Paleta nanche leche	2	20.00	99	2025-04-06	PC006     
444	Paleta coco leche	2	20.00	97	2025-04-06	PC007     
445	Pistache	2	20.00	99	2025-04-06	PC008     
446	Melon con crema	2	20.00	98	2025-04-06	PC009     
447	Fresa con yogurt	2	20.00	96	2025-04-06	PC010     
448	Chabacano	2	20.00	100	2025-04-06	PC011     
449	Arroz con leche	2	20.00	95	2025-04-06	PC012     
450	Naranja con crema	2	20.00	99	2025-04-06	PC013     
451	Paleta cubierta chocolate	3	30.00	47	2025-04-06	PCC001    
452	Cono	4	30.00	98	2025-04-06	H001      
453	Paleta guayaba agua	1	15.00	97	2025-04-06	PF003     
454	Paleta limon agua	1	15.00	99	2025-04-06	PF006     
455	Vaso chico	4	30.00	98	2025-04-06	H002      
456	Vaso grande	4	60.00	49	2025-04-06	H003      
457	Canasta	4	35.00	100	2025-04-06	H004      
458	Litro	4	120.00	19	2025-04-06	H005      
459	Mangonadas	5	55.00	50	2025-04-06	E002      
460	Tostilocos	5	50.00	49	2025-04-06	E003      
461	Tostinachos	5	55.00	49	2025-04-06	E004      
462	Paleta manzanita agua	1	15.00	98	2025-04-06	PF008     
463	Dorilocos	5	50.00	48	2025-04-06	E005      
464	Dorinachos	5	40.00	50	2025-04-06	E006      
465	Paleta loca	5	45.00	49	2025-04-06	E007      
466	Vaso agua	5	25.00	100	2025-04-06	E008      
467	Litro agua	5	50.00	50	2025-04-06	E009      
468	Sandia	2	15.00	10	2025-04-06	178526    
469	Editado	2	15.00	4	2025-04-06	OekKH     
470	Paleta uva agua	1	15.00	96	2025-04-06	PF005     
471	Paleta melon agua	1	15.00	95	2025-04-06	PF007     
472	Chamoy Pina	1	15.00	97	2025-04-06	PF010     
473	Paleta nanche agua	1	15.00	48	2025-04-06	PF015     
474	Oreo	2	20.00	0	2025-04-06	PC002     
475	Paleta pina agua	1	15.00	96	2025-04-06	PF001     
476	Palomitas	5	35.00	49	2025-04-06	E001      
477	Paleta coco agua	1	15.00	98	2025-04-06	PF002     
478	Paleta sandia agua	1	15.00	95	2025-04-06	PF004     
479	Paleta grosella agua	1	15.00	98	2025-04-07	PF009     
480	Chamoy Tamarindo	1	15.00	91	2025-04-07	PF011     
481	Chamoy Mango	1	15.00	98	2025-04-07	PF012     
482	Chamoy Limon	1	15.00	94	2025-04-07	PF013     
483	Limon Pepino	1	15.00	98	2025-04-07	PF014     
484	Paleta fresa agua	1	15.00	99	2025-04-07	PF016     
485	Chocogalleta	2	20.00	5	2025-04-07	PC001     
486	Nuez	2	20.00	0	2025-04-07	PC003     
487	Capuchino	2	20.00	98	2025-04-07	PC004     
488	Cajeta	2	20.00	97	2025-04-07	PC005     
489	Paleta nanche leche	2	20.00	99	2025-04-07	PC006     
490	Paleta coco leche	2	20.00	97	2025-04-07	PC007     
491	Pistache	2	20.00	99	2025-04-07	PC008     
492	Melon con crema	2	20.00	98	2025-04-07	PC009     
493	Fresa con yogurt	2	20.00	96	2025-04-07	PC010     
494	Chabacano	2	20.00	100	2025-04-07	PC011     
495	Arroz con leche	2	20.00	95	2025-04-07	PC012     
496	Naranja con crema	2	20.00	99	2025-04-07	PC013     
497	Paleta cubierta chocolate	3	30.00	47	2025-04-07	PCC001    
498	Cono	4	30.00	98	2025-04-07	H001      
499	Paleta guayaba agua	1	15.00	97	2025-04-07	PF003     
500	Paleta limon agua	1	15.00	99	2025-04-07	PF006     
501	Vaso chico	4	30.00	98	2025-04-07	H002      
502	Vaso grande	4	60.00	49	2025-04-07	H003      
503	Canasta	4	35.00	100	2025-04-07	H004      
504	Litro	4	120.00	19	2025-04-07	H005      
505	Mangonadas	5	55.00	50	2025-04-07	E002      
506	Tostilocos	5	50.00	49	2025-04-07	E003      
507	Tostinachos	5	55.00	49	2025-04-07	E004      
508	Paleta manzanita agua	1	15.00	98	2025-04-07	PF008     
509	Dorilocos	5	50.00	48	2025-04-07	E005      
510	Dorinachos	5	40.00	50	2025-04-07	E006      
511	Paleta loca	5	45.00	49	2025-04-07	E007      
512	Vaso agua	5	25.00	100	2025-04-07	E008      
513	Litro agua	5	50.00	50	2025-04-07	E009      
514	Sandia	2	15.00	10	2025-04-07	178526    
515	Editado	2	15.00	4	2025-04-07	OekKH     
516	Paleta uva agua	1	15.00	96	2025-04-07	PF005     
517	Paleta melon agua	1	15.00	95	2025-04-07	PF007     
518	Chamoy Pina	1	15.00	97	2025-04-07	PF010     
519	Paleta nanche agua	1	15.00	48	2025-04-07	PF015     
520	Oreo	2	20.00	0	2025-04-07	PC002     
521	Paleta pina agua	1	15.00	96	2025-04-07	PF001     
522	Palomitas	5	35.00	49	2025-04-07	E001      
523	Paleta coco agua	1	15.00	98	2025-04-07	PF002     
524	Paleta sandia agua	1	15.00	95	2025-04-07	PF004     
525	Paleta grosella agua	1	15.00	98	2025-04-08	PF009     
526	Chamoy Tamarindo	1	15.00	91	2025-04-08	PF011     
527	Chamoy Mango	1	15.00	98	2025-04-08	PF012     
528	Chamoy Limon	1	15.00	94	2025-04-08	PF013     
529	Limon Pepino	1	15.00	98	2025-04-08	PF014     
530	Paleta fresa agua	1	15.00	99	2025-04-08	PF016     
531	Chocogalleta	2	20.00	5	2025-04-08	PC001     
532	Nuez	2	20.00	0	2025-04-08	PC003     
533	Capuchino	2	20.00	98	2025-04-08	PC004     
534	Cajeta	2	20.00	97	2025-04-08	PC005     
535	Paleta nanche leche	2	20.00	99	2025-04-08	PC006     
536	Paleta coco leche	2	20.00	97	2025-04-08	PC007     
537	Pistache	2	20.00	99	2025-04-08	PC008     
538	Melon con crema	2	20.00	98	2025-04-08	PC009     
539	Fresa con yogurt	2	20.00	96	2025-04-08	PC010     
540	Chabacano	2	20.00	100	2025-04-08	PC011     
541	Arroz con leche	2	20.00	95	2025-04-08	PC012     
542	Naranja con crema	2	20.00	99	2025-04-08	PC013     
543	Paleta cubierta chocolate	3	30.00	47	2025-04-08	PCC001    
544	Cono	4	30.00	98	2025-04-08	H001      
545	Paleta guayaba agua	1	15.00	97	2025-04-08	PF003     
546	Paleta limon agua	1	15.00	99	2025-04-08	PF006     
547	Vaso chico	4	30.00	98	2025-04-08	H002      
548	Vaso grande	4	60.00	49	2025-04-08	H003      
549	Canasta	4	35.00	100	2025-04-08	H004      
550	Litro	4	120.00	19	2025-04-08	H005      
551	Mangonadas	5	55.00	50	2025-04-08	E002      
552	Tostilocos	5	50.00	49	2025-04-08	E003      
553	Tostinachos	5	55.00	49	2025-04-08	E004      
554	Paleta manzanita agua	1	15.00	98	2025-04-08	PF008     
555	Dorilocos	5	50.00	48	2025-04-08	E005      
556	Dorinachos	5	40.00	50	2025-04-08	E006      
557	Paleta loca	5	45.00	49	2025-04-08	E007      
558	Vaso agua	5	25.00	100	2025-04-08	E008      
559	Litro agua	5	50.00	50	2025-04-08	E009      
560	Sandia	2	15.00	10	2025-04-08	178526    
561	Editado	2	15.00	4	2025-04-08	OekKH     
562	Paleta uva agua	1	15.00	96	2025-04-08	PF005     
563	Paleta melon agua	1	15.00	95	2025-04-08	PF007     
564	Chamoy Pina	1	15.00	97	2025-04-08	PF010     
565	Paleta nanche agua	1	15.00	48	2025-04-08	PF015     
566	Oreo	2	20.00	0	2025-04-08	PC002     
567	Paleta pina agua	1	15.00	96	2025-04-08	PF001     
568	Palomitas	5	35.00	49	2025-04-08	E001      
569	Paleta coco agua	1	15.00	98	2025-04-08	PF002     
570	Paleta sandia agua	1	15.00	95	2025-04-08	PF004     
571	Paleta grosella agua	1	15.00	98	2025-04-09	PF009     
572	Chamoy Tamarindo	1	15.00	91	2025-04-09	PF011     
573	Chamoy Mango	1	15.00	98	2025-04-09	PF012     
574	Chamoy Limon	1	15.00	94	2025-04-09	PF013     
575	Limon Pepino	1	15.00	98	2025-04-09	PF014     
576	Paleta fresa agua	1	15.00	99	2025-04-09	PF016     
577	Chocogalleta	2	20.00	5	2025-04-09	PC001     
578	Nuez	2	20.00	0	2025-04-09	PC003     
579	Capuchino	2	20.00	98	2025-04-09	PC004     
580	Cajeta	2	20.00	97	2025-04-09	PC005     
581	Paleta nanche leche	2	20.00	99	2025-04-09	PC006     
582	Paleta coco leche	2	20.00	97	2025-04-09	PC007     
583	Pistache	2	20.00	99	2025-04-09	PC008     
584	Melon con crema	2	20.00	98	2025-04-09	PC009     
585	Fresa con yogurt	2	20.00	96	2025-04-09	PC010     
586	Chabacano	2	20.00	100	2025-04-09	PC011     
587	Arroz con leche	2	20.00	95	2025-04-09	PC012     
588	Naranja con crema	2	20.00	99	2025-04-09	PC013     
589	Paleta cubierta chocolate	3	30.00	47	2025-04-09	PCC001    
590	Cono	4	30.00	98	2025-04-09	H001      
591	Paleta guayaba agua	1	15.00	97	2025-04-09	PF003     
592	Paleta limon agua	1	15.00	99	2025-04-09	PF006     
593	Vaso chico	4	30.00	98	2025-04-09	H002      
594	Vaso grande	4	60.00	49	2025-04-09	H003      
595	Canasta	4	35.00	100	2025-04-09	H004      
596	Litro	4	120.00	19	2025-04-09	H005      
597	Mangonadas	5	55.00	50	2025-04-09	E002      
598	Tostilocos	5	50.00	49	2025-04-09	E003      
599	Tostinachos	5	55.00	49	2025-04-09	E004      
600	Paleta manzanita agua	1	15.00	98	2025-04-09	PF008     
601	Dorilocos	5	50.00	48	2025-04-09	E005      
602	Dorinachos	5	40.00	50	2025-04-09	E006      
603	Paleta loca	5	45.00	49	2025-04-09	E007      
604	Vaso agua	5	25.00	100	2025-04-09	E008      
605	Litro agua	5	50.00	50	2025-04-09	E009      
606	Sandia	2	15.00	10	2025-04-09	178526    
607	Editado	2	15.00	4	2025-04-09	OekKH     
608	Paleta uva agua	1	15.00	96	2025-04-09	PF005     
609	Paleta melon agua	1	15.00	95	2025-04-09	PF007     
610	Chamoy Pina	1	15.00	97	2025-04-09	PF010     
611	Paleta nanche agua	1	15.00	48	2025-04-09	PF015     
612	Oreo	2	20.00	0	2025-04-09	PC002     
613	Paleta pina agua	1	15.00	96	2025-04-09	PF001     
614	Palomitas	5	35.00	49	2025-04-09	E001      
615	Paleta coco agua	1	15.00	98	2025-04-09	PF002     
616	Paleta sandia agua	1	15.00	95	2025-04-09	PF004     
617	Paleta grosella agua	1	15.00	98	2025-04-13	PF009     
618	Chamoy Tamarindo	1	15.00	91	2025-04-13	PF011     
619	Chamoy Mango	1	15.00	98	2025-04-13	PF012     
620	Chamoy Limon	1	15.00	94	2025-04-13	PF013     
621	Limon Pepino	1	15.00	98	2025-04-13	PF014     
622	Paleta fresa agua	1	15.00	99	2025-04-13	PF016     
623	Chocogalleta	2	20.00	5	2025-04-13	PC001     
624	Nuez	2	20.00	0	2025-04-13	PC003     
625	Capuchino	2	20.00	98	2025-04-13	PC004     
626	Cajeta	2	20.00	97	2025-04-13	PC005     
627	Paleta nanche leche	2	20.00	99	2025-04-13	PC006     
628	Paleta coco leche	2	20.00	97	2025-04-13	PC007     
629	Pistache	2	20.00	99	2025-04-13	PC008     
630	Melon con crema	2	20.00	98	2025-04-13	PC009     
631	Fresa con yogurt	2	20.00	96	2025-04-13	PC010     
632	Chabacano	2	20.00	100	2025-04-13	PC011     
633	Arroz con leche	2	20.00	95	2025-04-13	PC012     
634	Naranja con crema	2	20.00	99	2025-04-13	PC013     
635	Paleta cubierta chocolate	3	30.00	47	2025-04-13	PCC001    
636	Cono	4	30.00	98	2025-04-13	H001      
637	Paleta guayaba agua	1	15.00	97	2025-04-13	PF003     
638	Paleta limon agua	1	15.00	99	2025-04-13	PF006     
639	Vaso chico	4	30.00	98	2025-04-13	H002      
640	Vaso grande	4	60.00	49	2025-04-13	H003      
641	Canasta	4	35.00	100	2025-04-13	H004      
642	Litro	4	120.00	19	2025-04-13	H005      
643	Mangonadas	5	55.00	50	2025-04-13	E002      
644	Tostilocos	5	50.00	49	2025-04-13	E003      
645	Tostinachos	5	55.00	49	2025-04-13	E004      
646	Paleta manzanita agua	1	15.00	98	2025-04-13	PF008     
647	Dorilocos	5	50.00	48	2025-04-13	E005      
648	Dorinachos	5	40.00	50	2025-04-13	E006      
649	Paleta loca	5	45.00	49	2025-04-13	E007      
650	Vaso agua	5	25.00	100	2025-04-13	E008      
651	Litro agua	5	50.00	50	2025-04-13	E009      
652	Sandia	2	15.00	10	2025-04-13	178526    
653	Editado	2	15.00	4	2025-04-13	OekKH     
654	Paleta uva agua	1	15.00	96	2025-04-13	PF005     
655	Paleta melon agua	1	15.00	95	2025-04-13	PF007     
656	Chamoy Pina	1	15.00	97	2025-04-13	PF010     
657	Paleta nanche agua	1	15.00	48	2025-04-13	PF015     
658	Oreo	2	20.00	0	2025-04-13	PC002     
659	Paleta pina agua	1	15.00	96	2025-04-13	PF001     
660	Palomitas	5	35.00	49	2025-04-13	E001      
661	Paleta coco agua	1	15.00	98	2025-04-13	PF002     
662	Paleta sandia agua	1	15.00	95	2025-04-13	PF004     
663	Paleta grosella agua	1	15.00	98	2025-04-23	PF009     
664	Chamoy Tamarindo	1	15.00	91	2025-04-23	PF011     
665	Chamoy Mango	1	15.00	98	2025-04-23	PF012     
666	Chamoy Limon	1	15.00	94	2025-04-23	PF013     
667	Limon Pepino	1	15.00	98	2025-04-23	PF014     
668	Paleta fresa agua	1	15.00	99	2025-04-23	PF016     
669	Chocogalleta	2	20.00	5	2025-04-23	PC001     
670	Nuez	2	20.00	0	2025-04-23	PC003     
671	Capuchino	2	20.00	98	2025-04-23	PC004     
672	Cajeta	2	20.00	97	2025-04-23	PC005     
673	Paleta nanche leche	2	20.00	99	2025-04-23	PC006     
674	Paleta coco leche	2	20.00	97	2025-04-23	PC007     
675	Pistache	2	20.00	99	2025-04-23	PC008     
676	Melon con crema	2	20.00	98	2025-04-23	PC009     
677	Fresa con yogurt	2	20.00	96	2025-04-23	PC010     
678	Chabacano	2	20.00	100	2025-04-23	PC011     
679	Arroz con leche	2	20.00	95	2025-04-23	PC012     
680	Naranja con crema	2	20.00	99	2025-04-23	PC013     
681	Paleta cubierta chocolate	3	30.00	47	2025-04-23	PCC001    
682	Cono	4	30.00	98	2025-04-23	H001      
683	Paleta guayaba agua	1	15.00	97	2025-04-23	PF003     
684	Paleta limon agua	1	15.00	99	2025-04-23	PF006     
685	Vaso chico	4	30.00	98	2025-04-23	H002      
686	Vaso grande	4	60.00	49	2025-04-23	H003      
687	Canasta	4	35.00	100	2025-04-23	H004      
688	Litro	4	120.00	19	2025-04-23	H005      
689	Mangonadas	5	55.00	50	2025-04-23	E002      
690	Tostilocos	5	50.00	49	2025-04-23	E003      
691	Tostinachos	5	55.00	49	2025-04-23	E004      
692	Paleta manzanita agua	1	15.00	98	2025-04-23	PF008     
693	Dorilocos	5	50.00	48	2025-04-23	E005      
694	Dorinachos	5	40.00	50	2025-04-23	E006      
695	Paleta loca	5	45.00	49	2025-04-23	E007      
696	Vaso agua	5	25.00	100	2025-04-23	E008      
697	Litro agua	5	50.00	50	2025-04-23	E009      
698	Sandia	2	15.00	10	2025-04-23	178526    
699	Editado	2	15.00	4	2025-04-23	OekKH     
700	Paleta uva agua	1	15.00	96	2025-04-23	PF005     
701	Paleta melon agua	1	15.00	95	2025-04-23	PF007     
702	Chamoy Pina	1	15.00	97	2025-04-23	PF010     
703	Paleta nanche agua	1	15.00	48	2025-04-23	PF015     
704	Oreo	2	20.00	0	2025-04-23	PC002     
705	Paleta pina agua	1	15.00	96	2025-04-23	PF001     
706	Palomitas	5	35.00	49	2025-04-23	E001      
707	Paleta coco agua	1	15.00	98	2025-04-23	PF002     
708	Paleta sandia agua	1	15.00	95	2025-04-23	PF004     
709	Paleta grosella agua	1	15.00	98	2025-05-05	PF009     
710	Chamoy Tamarindo	1	15.00	91	2025-05-05	PF011     
711	Chamoy Mango	1	15.00	98	2025-05-05	PF012     
712	Chamoy Limon	1	15.00	94	2025-05-05	PF013     
713	Limon Pepino	1	15.00	98	2025-05-05	PF014     
714	Paleta fresa agua	1	15.00	99	2025-05-05	PF016     
715	Chocogalleta	2	20.00	5	2025-05-05	PC001     
716	Nuez	2	20.00	0	2025-05-05	PC003     
717	Capuchino	2	20.00	98	2025-05-05	PC004     
718	Cajeta	2	20.00	97	2025-05-05	PC005     
719	Paleta nanche leche	2	20.00	99	2025-05-05	PC006     
720	Paleta coco leche	2	20.00	97	2025-05-05	PC007     
721	Pistache	2	20.00	99	2025-05-05	PC008     
722	Melon con crema	2	20.00	98	2025-05-05	PC009     
723	Fresa con yogurt	2	20.00	96	2025-05-05	PC010     
724	Chabacano	2	20.00	100	2025-05-05	PC011     
725	Arroz con leche	2	20.00	95	2025-05-05	PC012     
726	Naranja con crema	2	20.00	99	2025-05-05	PC013     
727	Paleta cubierta chocolate	3	30.00	47	2025-05-05	PCC001    
728	Cono	4	30.00	98	2025-05-05	H001      
729	Paleta guayaba agua	1	15.00	97	2025-05-05	PF003     
730	Paleta limon agua	1	15.00	99	2025-05-05	PF006     
731	Vaso chico	4	30.00	98	2025-05-05	H002      
732	Vaso grande	4	60.00	49	2025-05-05	H003      
733	Canasta	4	35.00	100	2025-05-05	H004      
734	Litro	4	120.00	19	2025-05-05	H005      
735	Mangonadas	5	55.00	50	2025-05-05	E002      
736	Tostilocos	5	50.00	49	2025-05-05	E003      
737	Tostinachos	5	55.00	49	2025-05-05	E004      
738	Paleta manzanita agua	1	15.00	98	2025-05-05	PF008     
739	Dorilocos	5	50.00	48	2025-05-05	E005      
740	Dorinachos	5	40.00	50	2025-05-05	E006      
741	Paleta loca	5	45.00	49	2025-05-05	E007      
742	Vaso agua	5	25.00	100	2025-05-05	E008      
743	Litro agua	5	50.00	50	2025-05-05	E009      
744	Sandia	2	15.00	10	2025-05-05	178526    
745	Editado	2	15.00	4	2025-05-05	OekKH     
746	Paleta uva agua	1	15.00	96	2025-05-05	PF005     
747	Paleta melon agua	1	15.00	95	2025-05-05	PF007     
748	Chamoy Pina	1	15.00	97	2025-05-05	PF010     
749	Paleta nanche agua	1	15.00	48	2025-05-05	PF015     
750	Oreo	2	20.00	0	2025-05-05	PC002     
751	Paleta pina agua	1	15.00	96	2025-05-05	PF001     
752	Palomitas	5	35.00	49	2025-05-05	E001      
753	Paleta coco agua	1	15.00	98	2025-05-05	PF002     
754	Paleta sandia agua	1	15.00	95	2025-05-05	PF004     
755	Paleta grosella agua	1	15.00	98	2025-10-12	PF009     
756	Chamoy Tamarindo	1	15.00	91	2025-10-12	PF011     
757	Chamoy Mango	1	15.00	98	2025-10-12	PF012     
758	Chamoy Limon	1	15.00	94	2025-10-12	PF013     
759	Limon Pepino	1	15.00	98	2025-10-12	PF014     
760	Paleta fresa agua	1	15.00	99	2025-10-12	PF016     
761	Chocogalleta	2	20.00	5	2025-10-12	PC001     
762	Nuez	2	20.00	0	2025-10-12	PC003     
763	Capuchino	2	20.00	98	2025-10-12	PC004     
764	Cajeta	2	20.00	97	2025-10-12	PC005     
765	Paleta nanche leche	2	20.00	99	2025-10-12	PC006     
766	Paleta coco leche	2	20.00	97	2025-10-12	PC007     
767	Pistache	2	20.00	99	2025-10-12	PC008     
768	Melon con crema	2	20.00	98	2025-10-12	PC009     
769	Fresa con yogurt	2	20.00	96	2025-10-12	PC010     
770	Chabacano	2	20.00	100	2025-10-12	PC011     
771	Arroz con leche	2	20.00	95	2025-10-12	PC012     
772	Naranja con crema	2	20.00	99	2025-10-12	PC013     
773	Paleta cubierta chocolate	3	30.00	47	2025-10-12	PCC001    
774	Cono	4	30.00	98	2025-10-12	H001      
775	Paleta guayaba agua	1	15.00	97	2025-10-12	PF003     
776	Paleta limon agua	1	15.00	99	2025-10-12	PF006     
777	Vaso chico	4	30.00	98	2025-10-12	H002      
778	Vaso grande	4	60.00	49	2025-10-12	H003      
779	Canasta	4	35.00	100	2025-10-12	H004      
780	Litro	4	120.00	19	2025-10-12	H005      
781	Mangonadas	5	55.00	50	2025-10-12	E002      
782	Tostilocos	5	50.00	49	2025-10-12	E003      
783	Tostinachos	5	55.00	49	2025-10-12	E004      
784	Paleta manzanita agua	1	15.00	98	2025-10-12	PF008     
785	Dorilocos	5	50.00	48	2025-10-12	E005      
786	Dorinachos	5	40.00	50	2025-10-12	E006      
787	Paleta loca	5	45.00	49	2025-10-12	E007      
788	Vaso agua	5	25.00	100	2025-10-12	E008      
789	Litro agua	5	50.00	50	2025-10-12	E009      
790	Sandia	2	15.00	10	2025-10-12	178526    
791	Editado	2	15.00	4	2025-10-12	OekKH     
792	Paleta uva agua	1	15.00	96	2025-10-12	PF005     
793	Paleta melon agua	1	15.00	95	2025-10-12	PF007     
794	Chamoy Pina	1	15.00	97	2025-10-12	PF010     
795	Paleta nanche agua	1	15.00	48	2025-10-12	PF015     
796	Oreo	2	20.00	0	2025-10-12	PC002     
797	Paleta pina agua	1	15.00	96	2025-10-12	PF001     
798	Palomitas	5	35.00	49	2025-10-12	E001      
799	Paleta coco agua	1	15.00	98	2025-10-12	PF002     
800	Paleta sandia agua	1	15.00	95	2025-10-12	PF004     
801	Paleta grosella agua	1	15.00	98	2025-10-15	PF009     
802	Chamoy Tamarindo	1	15.00	91	2025-10-15	PF011     
803	Chamoy Mango	1	15.00	98	2025-10-15	PF012     
804	Chamoy Limon	1	15.00	94	2025-10-15	PF013     
805	Limon Pepino	1	15.00	98	2025-10-15	PF014     
806	Paleta fresa agua	1	15.00	99	2025-10-15	PF016     
807	Chocogalleta	2	20.00	5	2025-10-15	PC001     
808	Nuez	2	20.00	0	2025-10-15	PC003     
809	Capuchino	2	20.00	98	2025-10-15	PC004     
810	Cajeta	2	20.00	97	2025-10-15	PC005     
811	Paleta nanche leche	2	20.00	99	2025-10-15	PC006     
812	Paleta coco leche	2	20.00	97	2025-10-15	PC007     
813	Pistache	2	20.00	99	2025-10-15	PC008     
814	Melon con crema	2	20.00	98	2025-10-15	PC009     
815	Fresa con yogurt	2	20.00	96	2025-10-15	PC010     
816	Chabacano	2	20.00	100	2025-10-15	PC011     
817	Arroz con leche	2	20.00	95	2025-10-15	PC012     
818	Naranja con crema	2	20.00	99	2025-10-15	PC013     
819	Paleta cubierta chocolate	3	30.00	47	2025-10-15	PCC001    
820	Cono	4	30.00	98	2025-10-15	H001      
821	Paleta guayaba agua	1	15.00	97	2025-10-15	PF003     
822	Paleta limon agua	1	15.00	99	2025-10-15	PF006     
823	Vaso chico	4	30.00	98	2025-10-15	H002      
824	Vaso grande	4	60.00	49	2025-10-15	H003      
825	Canasta	4	35.00	100	2025-10-15	H004      
826	Litro	4	120.00	19	2025-10-15	H005      
827	Mangonadas	5	55.00	50	2025-10-15	E002      
828	Tostilocos	5	50.00	49	2025-10-15	E003      
829	Tostinachos	5	55.00	49	2025-10-15	E004      
830	Paleta manzanita agua	1	15.00	98	2025-10-15	PF008     
831	Dorilocos	5	50.00	48	2025-10-15	E005      
832	Dorinachos	5	40.00	50	2025-10-15	E006      
833	Paleta loca	5	45.00	49	2025-10-15	E007      
834	Vaso agua	5	25.00	100	2025-10-15	E008      
835	Litro agua	5	50.00	50	2025-10-15	E009      
836	Sandia	2	15.00	10	2025-10-15	178526    
837	Editado	2	15.00	4	2025-10-15	OekKH     
838	Paleta uva agua	1	15.00	96	2025-10-15	PF005     
839	Paleta melon agua	1	15.00	95	2025-10-15	PF007     
840	Chamoy Pina	1	15.00	97	2025-10-15	PF010     
841	Paleta nanche agua	1	15.00	48	2025-10-15	PF015     
842	Oreo	2	20.00	0	2025-10-15	PC002     
843	Paleta pina agua	1	15.00	96	2025-10-15	PF001     
844	Palomitas	5	35.00	49	2025-10-15	E001      
845	Paleta coco agua	1	15.00	98	2025-10-15	PF002     
846	Paleta sandia agua	1	15.00	95	2025-10-15	PF004     
847	Paleta grosella agua	1	15.00	98	2025-10-16	PF009     
848	Chamoy Tamarindo	1	15.00	91	2025-10-16	PF011     
849	Chamoy Mango	1	15.00	98	2025-10-16	PF012     
850	Chamoy Limon	1	15.00	94	2025-10-16	PF013     
851	Limon Pepino	1	15.00	98	2025-10-16	PF014     
852	Paleta fresa agua	1	15.00	99	2025-10-16	PF016     
853	Chocogalleta	2	20.00	5	2025-10-16	PC001     
854	Nuez	2	20.00	0	2025-10-16	PC003     
855	Capuchino	2	20.00	98	2025-10-16	PC004     
856	Cajeta	2	20.00	97	2025-10-16	PC005     
857	Paleta nanche leche	2	20.00	99	2025-10-16	PC006     
858	Paleta coco leche	2	20.00	97	2025-10-16	PC007     
859	Pistache	2	20.00	99	2025-10-16	PC008     
860	Melon con crema	2	20.00	98	2025-10-16	PC009     
861	Fresa con yogurt	2	20.00	96	2025-10-16	PC010     
862	Chabacano	2	20.00	100	2025-10-16	PC011     
863	Arroz con leche	2	20.00	95	2025-10-16	PC012     
864	Naranja con crema	2	20.00	99	2025-10-16	PC013     
865	Paleta cubierta chocolate	3	30.00	47	2025-10-16	PCC001    
866	Cono	4	30.00	98	2025-10-16	H001      
867	Paleta guayaba agua	1	15.00	97	2025-10-16	PF003     
868	Paleta limon agua	1	15.00	99	2025-10-16	PF006     
869	Vaso chico	4	30.00	98	2025-10-16	H002      
870	Vaso grande	4	60.00	49	2025-10-16	H003      
871	Canasta	4	35.00	100	2025-10-16	H004      
872	Litro	4	120.00	19	2025-10-16	H005      
873	Mangonadas	5	55.00	50	2025-10-16	E002      
874	Tostilocos	5	50.00	49	2025-10-16	E003      
875	Tostinachos	5	55.00	49	2025-10-16	E004      
876	Paleta manzanita agua	1	15.00	98	2025-10-16	PF008     
877	Dorilocos	5	50.00	48	2025-10-16	E005      
878	Dorinachos	5	40.00	50	2025-10-16	E006      
879	Paleta loca	5	45.00	49	2025-10-16	E007      
880	Vaso agua	5	25.00	100	2025-10-16	E008      
881	Litro agua	5	50.00	50	2025-10-16	E009      
882	Sandia	2	15.00	10	2025-10-16	178526    
883	Editado	2	15.00	4	2025-10-16	OekKH     
884	Paleta uva agua	1	15.00	96	2025-10-16	PF005     
885	Paleta melon agua	1	15.00	95	2025-10-16	PF007     
886	Chamoy Pina	1	15.00	97	2025-10-16	PF010     
887	Paleta nanche agua	1	15.00	48	2025-10-16	PF015     
888	Oreo	2	20.00	0	2025-10-16	PC002     
889	Paleta pina agua	1	15.00	96	2025-10-16	PF001     
890	Palomitas	5	35.00	49	2025-10-16	E001      
891	Paleta coco agua	1	15.00	98	2025-10-16	PF002     
892	Paleta sandia agua	1	15.00	95	2025-10-16	PF004     
893	Paleta grosella agua	1	15.00	98	2025-11-13	PF009     
894	Chamoy Tamarindo	1	15.00	91	2025-11-13	PF011     
895	Chamoy Mango	1	15.00	98	2025-11-13	PF012     
896	Chamoy Limon	1	15.00	94	2025-11-13	PF013     
897	Limon Pepino	1	15.00	98	2025-11-13	PF014     
898	Paleta fresa agua	1	15.00	99	2025-11-13	PF016     
899	Chocogalleta	2	20.00	5	2025-11-13	PC001     
900	Nuez	2	20.00	0	2025-11-13	PC003     
901	Capuchino	2	20.00	98	2025-11-13	PC004     
902	Cajeta	2	20.00	97	2025-11-13	PC005     
903	Paleta nanche leche	2	20.00	99	2025-11-13	PC006     
904	Paleta coco leche	2	20.00	97	2025-11-13	PC007     
905	Pistache	2	20.00	99	2025-11-13	PC008     
906	Melon con crema	2	20.00	98	2025-11-13	PC009     
907	Fresa con yogurt	2	20.00	96	2025-11-13	PC010     
908	Chabacano	2	20.00	100	2025-11-13	PC011     
909	Arroz con leche	2	20.00	95	2025-11-13	PC012     
910	Naranja con crema	2	20.00	99	2025-11-13	PC013     
911	Paleta cubierta chocolate	3	30.00	47	2025-11-13	PCC001    
912	Cono	4	30.00	98	2025-11-13	H001      
913	Paleta guayaba agua	1	15.00	97	2025-11-13	PF003     
914	Paleta limon agua	1	15.00	99	2025-11-13	PF006     
915	Vaso chico	4	30.00	98	2025-11-13	H002      
916	Vaso grande	4	60.00	49	2025-11-13	H003      
917	Canasta	4	35.00	100	2025-11-13	H004      
918	Litro	4	120.00	19	2025-11-13	H005      
919	Mangonadas	5	55.00	50	2025-11-13	E002      
920	Tostilocos	5	50.00	49	2025-11-13	E003      
921	Tostinachos	5	55.00	49	2025-11-13	E004      
922	Paleta manzanita agua	1	15.00	98	2025-11-13	PF008     
923	Dorilocos	5	50.00	48	2025-11-13	E005      
924	Dorinachos	5	40.00	50	2025-11-13	E006      
925	Paleta loca	5	45.00	49	2025-11-13	E007      
926	Vaso agua	5	25.00	100	2025-11-13	E008      
927	Litro agua	5	50.00	50	2025-11-13	E009      
928	Sandia	2	15.00	10	2025-11-13	178526    
929	Editado	2	15.00	4	2025-11-13	OekKH     
930	Paleta uva agua	1	15.00	96	2025-11-13	PF005     
931	Paleta melon agua	1	15.00	95	2025-11-13	PF007     
932	Chamoy Pina	1	15.00	97	2025-11-13	PF010     
933	Paleta nanche agua	1	15.00	48	2025-11-13	PF015     
934	Oreo	2	20.00	0	2025-11-13	PC002     
935	Palomitas	5	35.00	49	2025-11-13	E001      
936	Paleta coco agua	1	15.00	98	2025-11-13	PF002     
937	Paleta sandia agua	1	15.00	95	2025-11-13	PF004     
938	Paleta pina agua	1	15.00	95	2025-11-13	PF001     
939	Paleta grosella agua	1	15.00	98	2026-04-08	PF009     
940	Chamoy Tamarindo	1	15.00	91	2026-04-08	PF011     
941	Chamoy Mango	1	15.00	98	2026-04-08	PF012     
942	Chamoy Limon	1	15.00	94	2026-04-08	PF013     
943	Limon Pepino	1	15.00	98	2026-04-08	PF014     
944	Paleta fresa agua	1	15.00	99	2026-04-08	PF016     
945	Chocogalleta	2	20.00	5	2026-04-08	PC001     
946	Nuez	2	20.00	0	2026-04-08	PC003     
947	Capuchino	2	20.00	98	2026-04-08	PC004     
948	Cajeta	2	20.00	97	2026-04-08	PC005     
949	Paleta nanche leche	2	20.00	99	2026-04-08	PC006     
950	Paleta coco leche	2	20.00	97	2026-04-08	PC007     
951	Pistache	2	20.00	99	2026-04-08	PC008     
952	Melon con crema	2	20.00	98	2026-04-08	PC009     
953	Fresa con yogurt	2	20.00	96	2026-04-08	PC010     
954	Chabacano	2	20.00	100	2026-04-08	PC011     
955	Arroz con leche	2	20.00	95	2026-04-08	PC012     
956	Naranja con crema	2	20.00	99	2026-04-08	PC013     
957	Paleta cubierta chocolate	3	30.00	47	2026-04-08	PCC001    
958	Cono	4	30.00	98	2026-04-08	H001      
959	Paleta guayaba agua	1	15.00	97	2026-04-08	PF003     
960	Paleta limon agua	1	15.00	99	2026-04-08	PF006     
961	Vaso chico	4	30.00	98	2026-04-08	H002      
962	Vaso grande	4	60.00	49	2026-04-08	H003      
963	Canasta	4	35.00	100	2026-04-08	H004      
964	Litro	4	120.00	19	2026-04-08	H005      
965	Mangonadas	5	55.00	50	2026-04-08	E002      
966	Tostilocos	5	50.00	49	2026-04-08	E003      
967	Tostinachos	5	55.00	49	2026-04-08	E004      
968	Paleta manzanita agua	1	15.00	98	2026-04-08	PF008     
969	Dorilocos	5	50.00	48	2026-04-08	E005      
970	Dorinachos	5	40.00	50	2026-04-08	E006      
971	Paleta loca	5	45.00	49	2026-04-08	E007      
972	Vaso agua	5	25.00	100	2026-04-08	E008      
973	Litro agua	5	50.00	50	2026-04-08	E009      
974	Sandia	2	15.00	10	2026-04-08	178526    
975	Editado	2	15.00	4	2026-04-08	OekKH     
976	Paleta uva agua	1	15.00	96	2026-04-08	PF005     
977	Paleta melon agua	1	15.00	95	2026-04-08	PF007     
978	Chamoy Pina	1	15.00	97	2026-04-08	PF010     
979	Paleta nanche agua	1	15.00	48	2026-04-08	PF015     
980	Oreo	2	20.00	0	2026-04-08	PC002     
981	Palomitas	5	35.00	49	2026-04-08	E001      
982	Paleta coco agua	1	15.00	98	2026-04-08	PF002     
983	Paleta sandia agua	1	15.00	95	2026-04-08	PF004     
984	Paleta pina agua	1	15.00	95	2026-04-08	PF001     
\.


--
-- Data for Name: turnos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.turnos (id, fecha_apertura, fecha_cierre, total_inicio, total_cierre, estado) FROM stdin;
1	2024-11-22 22:46:12.260329	2024-11-22 22:59:00.059158	0.00	0.00	f
2	2024-11-22 22:59:44.237854	2024-11-22 22:59:47.198418	0.00	0.00	f
3	2024-11-22 23:01:06.610158	2024-11-22 23:01:09.512101	0.00	0.00	f
4	2024-11-22 23:01:33.380328	2024-11-22 23:01:37.497715	0.00	0.00	f
5	2024-11-22 23:01:41.194028	2024-11-22 23:01:50.611737	0.00	70.00	f
6	2024-11-22 23:04:56.466592	2024-11-22 23:05:09.142047	0.00	0.00	f
7	2024-11-22 23:51:22.092361	2024-11-22 23:52:00.583947	0.00	325.00	f
8	2024-11-23 00:29:57.835825	2024-11-23 00:55:33.270566	500.00	110.00	f
9	2024-11-23 01:04:48.478981	2024-11-23 01:06:45.684021	200.00	255.00	f
10	2024-11-23 21:57:57.712624	2024-11-23 22:02:04.448594	50.00	175.00	f
11	2024-11-24 03:02:22.529846	2024-11-24 03:06:06.629609	100.00	80.00	f
12	2024-11-25 14:56:29.1552	2024-11-25 14:57:20.763606	0.00	15.00	f
13	2024-11-25 14:57:35.277685	2024-11-25 14:57:47.062333	0.00	30.00	f
45	2025-10-17 21:41:12.56315	2025-10-17 21:41:48.310747	500.00	15.00	f
\.


--
-- Data for Name: ventas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ventas (id, fecha, total) FROM stdin;
1	2024-11-19 23:05:27.89401	15.00
2	2024-11-19 23:09:48.469218	75.00
3	2024-11-19 23:12:22.892991	265.00
4	2024-11-20 00:31:52.374896	30.00
5	2024-11-21 00:20:29.686069	60.00
6	2024-11-21 12:19:05.021953	65.00
7	2024-11-21 22:01:00.915751	130.00
8	2024-11-21 22:02:56.218919	185.00
9	2024-11-22 23:01:28.015844	50.00
10	2024-11-22 23:01:46.025546	70.00
11	2024-11-22 23:51:41.883036	325.00
12	2024-11-23 00:30:26.939133	110.00
13	2024-11-23 01:05:34.868172	255.00
14	2024-11-23 21:59:41.29996	175.00
15	2024-11-24 01:48:20.103163	30.00
16	2024-11-24 03:01:54.732162	85.00
17	2024-11-24 03:05:46.861888	80.00
18	2024-11-25 14:57:11.059221	15.00
19	2024-11-25 14:57:39.967878	30.00
51	2025-10-17 21:41:27.286761	15.00
\.


--
-- Name: categorias_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categorias_id_seq', 5, true);


--
-- Name: categorias_nar_id_categoria_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categorias_nar_id_categoria_seq', 9, true);


--
-- Name: cuentas_id_cuenta_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cuentas_id_cuenta_seq', 21, true);


--
-- Name: descuentos_id_descuento_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.descuentos_id_descuento_seq', 11, true);


--
-- Name: detalle_cuentas_id_detalle_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.detalle_cuentas_id_detalle_seq', 65, true);


--
-- Name: detalle_ventas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.detalle_ventas_id_seq', 97, true);


--
-- Name: mesas_id_mesa_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mesas_id_mesa_seq', 12, true);


--
-- Name: movimientos_inventario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.movimientos_inventario_id_seq', 108, true);


--
-- Name: productos_bar_id_producto_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.productos_bar_id_producto_seq', 143, true);


--
-- Name: productos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.productos_id_seq', 57, true);


--
-- Name: productos_respaldo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.productos_respaldo_id_seq', 984, true);


--
-- Name: turnos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.turnos_id_seq', 45, true);


--
-- Name: ventas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ventas_id_seq', 51, true);


--
-- Name: categorias_nar categorias_nar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorias_nar
    ADD CONSTRAINT categorias_nar_pkey PRIMARY KEY (id_categoria);


--
-- Name: categorias categorias_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorias
    ADD CONSTRAINT categorias_pkey PRIMARY KEY (id);


--
-- Name: cuentas cuentas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuentas
    ADD CONSTRAINT cuentas_pkey PRIMARY KEY (id_cuenta);


--
-- Name: descuentos descuentos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.descuentos
    ADD CONSTRAINT descuentos_pkey PRIMARY KEY (id_descuento);


--
-- Name: detalle_cuentas detalle_cuentas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_cuentas
    ADD CONSTRAINT detalle_cuentas_pkey PRIMARY KEY (id_detalle);


--
-- Name: detalle_ventas detalle_ventas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_ventas
    ADD CONSTRAINT detalle_ventas_pkey PRIMARY KEY (id);


--
-- Name: mesas mesas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mesas
    ADD CONSTRAINT mesas_pkey PRIMARY KEY (id_mesa);


--
-- Name: movimientos_inventario movimientos_inventario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movimientos_inventario
    ADD CONSTRAINT movimientos_inventario_pkey PRIMARY KEY (id);


--
-- Name: productos_bar productos_bar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos_bar
    ADD CONSTRAINT productos_bar_pkey PRIMARY KEY (id_producto);


--
-- Name: productos productos_codigo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos
    ADD CONSTRAINT productos_codigo_key UNIQUE (codigo);


--
-- Name: productos productos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos
    ADD CONSTRAINT productos_pkey PRIMARY KEY (id);


--
-- Name: productos_respaldo productos_respaldo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos_respaldo
    ADD CONSTRAINT productos_respaldo_pkey PRIMARY KEY (id);


--
-- Name: turnos turnos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.turnos
    ADD CONSTRAINT turnos_pkey PRIMARY KEY (id);


--
-- Name: ventas ventas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ventas
    ADD CONSTRAINT ventas_pkey PRIMARY KEY (id);


--
-- Name: cuentas cuentas_id_mesa_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuentas
    ADD CONSTRAINT cuentas_id_mesa_fkey FOREIGN KEY (id_mesa) REFERENCES public.mesas(id_mesa);


--
-- Name: descuentos descuentos_id_cuenta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.descuentos
    ADD CONSTRAINT descuentos_id_cuenta_fkey FOREIGN KEY (id_cuenta) REFERENCES public.cuentas(id_cuenta);


--
-- Name: descuentos descuentos_id_producto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.descuentos
    ADD CONSTRAINT descuentos_id_producto_fkey FOREIGN KEY (id_detalle) REFERENCES public.productos_bar(id_producto);


--
-- Name: detalle_cuentas detalle_cuentas_id_cuenta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_cuentas
    ADD CONSTRAINT detalle_cuentas_id_cuenta_fkey FOREIGN KEY (id_cuenta) REFERENCES public.cuentas(id_cuenta);


--
-- Name: detalle_cuentas detalle_cuentas_id_producto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_cuentas
    ADD CONSTRAINT detalle_cuentas_id_producto_fkey FOREIGN KEY (id_producto) REFERENCES public.productos_bar(id_producto);


--
-- Name: detalle_ventas detalle_ventas_id_producto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_ventas
    ADD CONSTRAINT detalle_ventas_id_producto_fkey FOREIGN KEY (id_producto) REFERENCES public.productos(id) ON DELETE CASCADE;


--
-- Name: detalle_ventas detalle_ventas_id_venta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_ventas
    ADD CONSTRAINT detalle_ventas_id_venta_fkey FOREIGN KEY (id_venta) REFERENCES public.ventas(id) ON DELETE CASCADE;


--
-- Name: movimientos_inventario movimientos_inventario_id_producto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movimientos_inventario
    ADD CONSTRAINT movimientos_inventario_id_producto_fkey FOREIGN KEY (id_producto) REFERENCES public.productos(id) ON DELETE CASCADE;


--
-- Name: productos_bar productos_bar_id_categoria_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos_bar
    ADD CONSTRAINT productos_bar_id_categoria_fkey FOREIGN KEY (id_categoria) REFERENCES public.categorias_nar(id_categoria);


--
-- Name: productos productos_id_categoria_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos
    ADD CONSTRAINT productos_id_categoria_fkey FOREIGN KEY (id_categoria) REFERENCES public.categorias(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

