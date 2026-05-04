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
    id_categoria integer NOT NULL,
    nombre character varying(100) NOT NULL
);


ALTER TABLE public.categorias OWNER TO postgres;

--
-- Name: categorias_id_categoria_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categorias_id_categoria_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categorias_id_categoria_seq OWNER TO postgres;

--
-- Name: categorias_id_categoria_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categorias_id_categoria_seq OWNED BY public.categorias.id_categoria;


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
-- Name: detalle_cuentas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.detalle_cuentas (
    id_detalle integer NOT NULL,
    id_cuenta integer NOT NULL,
    id_producto integer NOT NULL,
    cantidad numeric(10,2) NOT NULL,
    precio_unitario numeric(10,2) NOT NULL,
    subtotal numeric(10,2) NOT NULL
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
    id_detalle_venta integer NOT NULL,
    id_venta integer,
    id_producto integer,
    cantidad integer NOT NULL,
    precio_unitario numeric(10,2) NOT NULL
);


ALTER TABLE public.detalle_ventas OWNER TO postgres;

--
-- Name: detalle_ventas_id_detalle_venta_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.detalle_ventas_id_detalle_venta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.detalle_ventas_id_detalle_venta_seq OWNER TO postgres;

--
-- Name: detalle_ventas_id_detalle_venta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.detalle_ventas_id_detalle_venta_seq OWNED BY public.detalle_ventas.id_detalle_venta;


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
    id_movimiento integer NOT NULL,
    id_producto integer NOT NULL,
    fecha timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    cantidad integer NOT NULL,
    precio_unitario numeric(10,2),
    tipo_movimiento character varying(10) NOT NULL,
    motivo text,
    CONSTRAINT movimientos_inventario_tipo_movimiento_check CHECK (((tipo_movimiento)::text = ANY ((ARRAY['entrada'::character varying, 'salida'::character varying])::text[])))
);


ALTER TABLE public.movimientos_inventario OWNER TO postgres;

--
-- Name: movimientos_inventario_id_movimiento_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.movimientos_inventario_id_movimiento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.movimientos_inventario_id_movimiento_seq OWNER TO postgres;

--
-- Name: movimientos_inventario_id_movimiento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.movimientos_inventario_id_movimiento_seq OWNED BY public.movimientos_inventario.id_movimiento;


--
-- Name: productos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.productos (
    id_producto integer NOT NULL,
    nombre character varying(100) NOT NULL,
    descripcion text,
    id_categoria integer,
    id_proveedor integer,
    precio_compra numeric(10,2) NOT NULL,
    precio_venta numeric(10,2) NOT NULL,
    stock integer NOT NULL,
    stock_minimo integer NOT NULL
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
-- Name: productos_id_producto_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.productos_id_producto_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.productos_id_producto_seq OWNER TO postgres;

--
-- Name: productos_id_producto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.productos_id_producto_seq OWNED BY public.productos.id_producto;


--
-- Name: productos_por_gramaje; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.productos_por_gramaje (
    id_producto character varying(10) NOT NULL,
    nombre character varying(255) NOT NULL,
    descripcion text,
    id_categoria integer,
    id_proveedor integer,
    precio_compra numeric(10,2) NOT NULL,
    precio_venta numeric(10,2) NOT NULL,
    stock numeric(10,2) NOT NULL,
    stock_minimo numeric(10,2),
    unidad_medida character varying(50) NOT NULL,
    id_serial integer NOT NULL
);


ALTER TABLE public.productos_por_gramaje OWNER TO postgres;

--
-- Name: productos_por_gramaje_id_producto_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.productos_por_gramaje_id_producto_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.productos_por_gramaje_id_producto_seq OWNER TO postgres;

--
-- Name: productos_por_gramaje_id_producto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.productos_por_gramaje_id_producto_seq OWNED BY public.productos_por_gramaje.id_producto;


--
-- Name: productos_por_gramaje_id_serial_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.productos_por_gramaje_id_serial_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.productos_por_gramaje_id_serial_seq OWNER TO postgres;

--
-- Name: productos_por_gramaje_id_serial_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.productos_por_gramaje_id_serial_seq OWNED BY public.productos_por_gramaje.id_serial;


--
-- Name: productos_respaldo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.productos_respaldo (
    id_producto integer NOT NULL,
    nombre character varying(100) NOT NULL,
    descripcion text,
    id_categoria integer,
    id_proveedor integer,
    precio_compra numeric(10,2) NOT NULL,
    precio_venta numeric(10,2) NOT NULL,
    stock integer NOT NULL,
    stock_minimo integer NOT NULL,
    fecha_respaldo timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.productos_respaldo OWNER TO postgres;

--
-- Name: productos_respaldo_id_producto_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.productos_respaldo_id_producto_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.productos_respaldo_id_producto_seq OWNER TO postgres;

--
-- Name: productos_respaldo_id_producto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.productos_respaldo_id_producto_seq OWNED BY public.productos_respaldo.id_producto;


--
-- Name: proveedores; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.proveedores (
    id_proveedor integer NOT NULL,
    nombre character varying(100) NOT NULL,
    contacto character varying(255)
);


ALTER TABLE public.proveedores OWNER TO postgres;

--
-- Name: proveedores_id_proveedor_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.proveedores_id_proveedor_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.proveedores_id_proveedor_seq OWNER TO postgres;

--
-- Name: proveedores_id_proveedor_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.proveedores_id_proveedor_seq OWNED BY public.proveedores.id_proveedor;


--
-- Name: registro_uso; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.registro_uso (
    id integer NOT NULL,
    fecha_inicio date,
    ultima_fecha_uso date
);


ALTER TABLE public.registro_uso OWNER TO postgres;

--
-- Name: registro_uso_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.registro_uso_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.registro_uso_id_seq OWNER TO postgres;

--
-- Name: registro_uso_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.registro_uso_id_seq OWNED BY public.registro_uso.id;


--
-- Name: usuarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuarios (
    id_usuario integer NOT NULL,
    nombre_usuario character varying(50) NOT NULL,
    contrasena character varying(100) NOT NULL,
    rol character varying(20) NOT NULL
);


ALTER TABLE public.usuarios OWNER TO postgres;

--
-- Name: usuarios_id_usuario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuarios_id_usuario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.usuarios_id_usuario_seq OWNER TO postgres;

--
-- Name: usuarios_id_usuario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuarios_id_usuario_seq OWNED BY public.usuarios.id_usuario;


--
-- Name: ventas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ventas (
    id_venta integer NOT NULL,
    fecha timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    total numeric(10,2) NOT NULL,
    id_usuario integer
);


ALTER TABLE public.ventas OWNER TO postgres;

--
-- Name: ventas_id_venta_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ventas_id_venta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ventas_id_venta_seq OWNER TO postgres;

--
-- Name: ventas_id_venta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ventas_id_venta_seq OWNED BY public.ventas.id_venta;


--
-- Name: categorias id_categoria; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorias ALTER COLUMN id_categoria SET DEFAULT nextval('public.categorias_id_categoria_seq'::regclass);


--
-- Name: categorias_nar id_categoria; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorias_nar ALTER COLUMN id_categoria SET DEFAULT nextval('public.categorias_nar_id_categoria_seq'::regclass);


--
-- Name: cuentas id_cuenta; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuentas ALTER COLUMN id_cuenta SET DEFAULT nextval('public.cuentas_id_cuenta_seq'::regclass);


--
-- Name: detalle_cuentas id_detalle; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_cuentas ALTER COLUMN id_detalle SET DEFAULT nextval('public.detalle_cuentas_id_detalle_seq'::regclass);


--
-- Name: detalle_ventas id_detalle_venta; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_ventas ALTER COLUMN id_detalle_venta SET DEFAULT nextval('public.detalle_ventas_id_detalle_venta_seq'::regclass);


--
-- Name: mesas id_mesa; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mesas ALTER COLUMN id_mesa SET DEFAULT nextval('public.mesas_id_mesa_seq'::regclass);


--
-- Name: movimientos_inventario id_movimiento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movimientos_inventario ALTER COLUMN id_movimiento SET DEFAULT nextval('public.movimientos_inventario_id_movimiento_seq'::regclass);


--
-- Name: productos id_producto; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos ALTER COLUMN id_producto SET DEFAULT nextval('public.productos_id_producto_seq'::regclass);


--
-- Name: productos_bar id_producto; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos_bar ALTER COLUMN id_producto SET DEFAULT nextval('public.productos_bar_id_producto_seq'::regclass);


--
-- Name: productos_por_gramaje id_producto; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos_por_gramaje ALTER COLUMN id_producto SET DEFAULT nextval('public.productos_por_gramaje_id_producto_seq'::regclass);


--
-- Name: productos_por_gramaje id_serial; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos_por_gramaje ALTER COLUMN id_serial SET DEFAULT nextval('public.productos_por_gramaje_id_serial_seq'::regclass);


--
-- Name: productos_respaldo id_producto; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos_respaldo ALTER COLUMN id_producto SET DEFAULT nextval('public.productos_respaldo_id_producto_seq'::regclass);


--
-- Name: proveedores id_proveedor; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proveedores ALTER COLUMN id_proveedor SET DEFAULT nextval('public.proveedores_id_proveedor_seq'::regclass);


--
-- Name: registro_uso id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.registro_uso ALTER COLUMN id SET DEFAULT nextval('public.registro_uso_id_seq'::regclass);


--
-- Name: usuarios id_usuario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios ALTER COLUMN id_usuario SET DEFAULT nextval('public.usuarios_id_usuario_seq'::regclass);


--
-- Name: ventas id_venta; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ventas ALTER COLUMN id_venta SET DEFAULT nextval('public.ventas_id_venta_seq'::regclass);


--
-- Data for Name: categorias; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categorias (id_categoria, nombre) FROM stdin;
1	Aceites y Vinagres
2	Arroz, Pastas y Legumbres
5	Cereales y Barras
6	Conservas y Enlatados
7	Condimentos y Especias
8	Dulces y Chocolates
9	Galletas y Snacks
10	Harinas y Preparados
11	Mermeladas y Miel
12	Pastas y Salsas
13	Sal y Sazonadores
14	Huevos
15	Leche y Derivados
16	Quesos
17	Yogurt y Postres
18	Embutidos y Fiambres
19	Mantequilla y Margarina
20	Frutas Frescas
21	Verduras Frescas
22	Frutas y Verduras Congeladas
23	Carne de Res
24	Carne de Cerdo
25	Carne de Pollo
26	Pescados y Mariscos
27	Pan
28	Pasteles y Tartas
29	Galletas y Pan Dulce
30	Agua
31	Refrescos y Jugos
32	Cervezas
33	Vinos y Licores
34	Detergentes y Lavavajillas
35	Limpiadores y Desinfectantes
38	Cuidado Bucal
39	Cuidado del Cabello
40	Cuidado de la Piel
41	Desodorantes
42	Jabones y Geles
43	Mascotas
3	Azucar, Endulzantes y Harinas
45	Articulos de fiesta
44	Bebes
36	Articulos de papel
4	Cafe, Te y Chocolate
37	Productos para el banio
50	Medicamentos
51	Otros
52	Papeleria
\.


--
-- Data for Name: categorias_nar; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categorias_nar (id_categoria, nombre) FROM stdin;
\.


--
-- Data for Name: cuentas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cuentas (id_cuenta, id_mesa, nombre_cuenta, total, estado, fecha_apertura, fecha_cierre) FROM stdin;
\.


--
-- Data for Name: detalle_cuentas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.detalle_cuentas (id_detalle, id_cuenta, id_producto, cantidad, precio_unitario, subtotal) FROM stdin;
\.


--
-- Data for Name: detalle_ventas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.detalle_ventas (id_detalle_venta, id_venta, id_producto, cantidad, precio_unitario) FROM stdin;
1	1	4	2	15.00
2	1	5	1	23.00
4	2	4	1	15.00
5	2	5	1	23.00
6	3	4	1	15.00
7	3	5	1	23.00
9	4	4	1	15.00
10	4	5	1	23.00
12	5	8	3	45.00
14	6	4	4	15.00
15	8	8	1	45.00
16	8	4	1	15.00
18	9	5	1	23.00
19	9	4	5	15.00
20	10	9	1	12.50
21	10	10	1	100.00
23	10	8	1	45.00
24	11	10	1	100.00
25	11	5	1	23.00
26	12	9	1	12.50
27	13	11	2	16.00
28	13	9	2	12.50
29	13	8	1	45.00
30	14	11	10	16.00
31	15	5	6	23.00
32	16	4	9	15.00
33	17	9	1	12.50
36	19	9	3	12.50
37	20	9	15	12.50
38	21	4	1	15.00
39	22	4	1	15.00
40	22	9	4	12.50
41	23	9	4	12.50
42	24	5	2	23.00
44	25	8	1	45.00
45	25	11	1	16.00
46	26	9	1	12.50
47	26	4	1	15.00
49	27	4	1	15.00
50	27	11	1	16.00
51	27	8	1	45.00
52	28	9	1	12.50
54	29	8	3	45.00
56	30	9	1	12.50
57	31	4	1	15.00
58	31	11	1	16.00
60	31	8	1	45.00
61	32	11	1	16.00
62	32	4	1	15.00
64	33	10	1	100.00
65	33	4	1	15.00
67	34	8	1	45.00
68	34	11	1	16.00
69	35	8	1	45.00
70	35	11	1	16.00
71	35	10	1	100.00
72	35	9	1	12.50
73	36	8	1	45.00
74	36	11	1	16.00
75	36	4	1	15.00
77	37	9	1	12.50
78	37	4	1	15.00
79	37	11	1	16.00
80	38	10	2	100.00
82	38	11	1	16.00
83	39	15	1	25.00
84	40	4	10	15.00
87	40	9	1	12.50
88	40	8	1	45.00
89	40	10	5	100.00
90	41	9	1	12.50
91	41	16	1	18.00
92	41	4	1	15.00
93	41	5	1	23.00
96	43	10	1	100.00
98	45	364	1	32.50
99	46	4	1	15.00
100	46	5	1	23.00
101	46	8	1	45.00
102	46	10	1	100.00
\.


--
-- Data for Name: mesas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mesas (id_mesa, nombre, estado, fecha_registro) FROM stdin;
\.


--
-- Data for Name: movimientos_inventario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.movimientos_inventario (id_movimiento, id_producto, fecha, cantidad, precio_unitario, tipo_movimiento, motivo) FROM stdin;
9	4	2024-07-15 23:09:48.209007	1	15.00	salida	Venta de producto
10	9	2024-07-15 23:09:48.213189	4	12.50	salida	Venta de producto
11	9	2024-07-17 14:58:15.24855	4	12.50	salida	Venta de producto
12	5	2024-07-18 12:41:17.323502	2	23.00	salida	Venta de producto
15	8	2024-07-18 13:44:53.745407	1	45.00	salida	Venta de producto
16	11	2024-07-18 13:44:53.751722	1	16.00	salida	Venta de producto
17	9	2024-07-18 13:45:02.553615	1	12.50	salida	Venta de producto
18	4	2024-07-18 13:45:02.567529	1	15.00	salida	Venta de producto
20	4	2024-07-18 13:45:10.61257	1	15.00	salida	Venta de producto
21	11	2024-07-18 13:45:10.712196	1	16.00	salida	Venta de producto
22	8	2024-07-18 13:45:10.731485	1	45.00	salida	Venta de producto
23	9	2024-07-18 13:45:16.126834	1	12.50	salida	Venta de producto
25	8	2024-07-18 13:45:21.285132	3	45.00	salida	Venta de producto
27	9	2024-07-18 13:45:26.915693	1	12.50	salida	Venta de producto
28	4	2024-07-18 13:45:35.755755	1	15.00	salida	Venta de producto
29	11	2024-07-18 13:45:35.764752	1	16.00	salida	Venta de producto
31	8	2024-07-18 13:45:35.77877	1	45.00	salida	Venta de producto
32	11	2024-07-18 13:45:39.771088	1	16.00	salida	Venta de producto
33	4	2024-07-18 13:45:39.77888	1	15.00	salida	Venta de producto
35	10	2024-07-18 13:45:46.186929	1	100.00	salida	Venta de producto
36	4	2024-07-18 13:45:46.189625	1	15.00	salida	Venta de producto
38	8	2024-07-18 13:45:50.067567	1	45.00	salida	Venta de producto
39	11	2024-07-18 13:45:50.071607	1	16.00	salida	Venta de producto
40	8	2024-07-18 13:45:55.695627	1	45.00	salida	Venta de producto
41	11	2024-07-18 13:45:55.703985	1	16.00	salida	Venta de producto
42	10	2024-07-18 13:45:55.709214	1	100.00	salida	Venta de producto
43	9	2024-07-18 13:45:56.990666	1	12.50	salida	Venta de producto
44	8	2024-07-18 13:46:01.2928	1	45.00	salida	Venta de producto
45	11	2024-07-18 13:46:01.297247	1	16.00	salida	Venta de producto
46	4	2024-07-18 13:46:01.300654	1	15.00	salida	Venta de producto
48	9	2024-07-21 02:09:03.531791	1	12.50	salida	Venta de producto
49	4	2024-07-21 02:09:03.534954	1	15.00	salida	Venta de producto
50	11	2024-07-21 02:09:03.537776	1	16.00	salida	Venta de producto
51	10	2024-07-21 16:43:00.26956	2	100.00	salida	Venta de producto
53	11	2024-07-21 16:43:00.286205	1	16.00	salida	Venta de producto
54	9	2024-07-23 19:50:20.737905	3	12.50	salida	Edicion de producto
55	15	2024-07-31 14:44:02.425533	10	17.00	entrada	Producto agregado
56	15	2024-07-31 22:18:10.700608	1	25.00	salida	Venta de producto
57	4	2024-08-01 11:47:59.326864	10	15.00	salida	Venta de producto
60	9	2024-08-01 11:47:59.392308	1	12.50	salida	Venta de producto
61	8	2024-08-01 11:47:59.442672	1	45.00	salida	Venta de producto
62	10	2024-08-01 11:47:59.44884	5	100.00	salida	Venta de producto
63	16	2024-08-30 15:33:20.901984	5	10.00	entrada	Producto agregado
64	9	2024-08-30 15:34:32.483372	1	12.50	salida	Venta de producto
65	16	2024-08-30 15:34:32.491795	1	18.00	salida	Venta de producto
66	4	2024-08-30 15:34:32.498164	1	15.00	salida	Venta de producto
67	5	2024-08-30 15:34:32.504067	1	23.00	salida	Venta de producto
71	10	2024-12-09 11:10:26.780282	1	100.00	salida	Venta de producto
72	363	2025-04-14 12:30:57.90429	5	3.00	entrada	Producto agregado
74	364	2026-04-09 15:02:00.590632	20	28.00	entrada	Producto agregado
75	364	2026-04-09 15:02:23.290703	1	32.50	salida	Venta de producto
76	4	2026-04-09 15:41:37.029244	1	15.00	salida	Venta de producto
77	5	2026-04-09 15:41:37.033305	1	23.00	salida	Venta de producto
78	8	2026-04-09 15:41:37.376868	1	45.00	salida	Venta de producto
79	10	2026-04-09 15:41:37.421754	1	100.00	salida	Venta de producto
\.


--
-- Data for Name: productos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.productos (id_producto, nombre, descripcion, id_categoria, id_proveedor, precio_compra, precio_venta, stock, stock_minimo) FROM stdin;
400	Coca Cola 2.5L NR	Refresco Coca Cola 2.5 Litros No Retornable	31	16	28.00	35.00	0	5
27	Pepsi 1.5L	Refresco Pepsi 1.5 Litros	31	14	12.00	15.50	100	10
16	Sabritas	Sabritas Flamin Hot	9	3	10.00	18.00	4	1
18	Coca Cola 1L	Refresco Coca Cola 1 Litro	31	16	12.00	15.00	100	10
4	Galletas marias	Las galletas clasicas	9	3	8.90	15.00	18	2
100	Tortillas de maiz 1/2 kg	None	10	58	8.00	10.50	100	10
19	Coca Cola lata 355ml	Refresco Coca Cola 355 ml lata	31	16	8.50	11.00	100	10
8	chimichangas	chimichangas	23	10	30.00	45.00	14	5
9	MaruchanTokyo	maruchan picante	2	11	5.50	12.50	15	10
47	Leche Santa Clara entera 1L	Leche Santa Clara entera 1 Litro	15	4	22.00	28.00	100	10
117	Marias gamesa	None	29	46	8.00	10.50	100	10
44	Leche Lala entera 1L	Leche Lala entera 1 Litro	15	4	19.00	24.00	100	10
46	Leche Lala light 1L	Leche Lala light 1 Litro	15	4	20.00	25.00	100	10
48	Leche Santa Clara deslactosada 1L	Leche Santa Clara deslactosada 1 Litro	15	4	23.00	29.00	100	10
11	Pepsi 600ml	bebida azucarada	31	14	8.00	16.00	77	20
49	Yogurt Lala natural 1L	Yogurt Lala natural 1 Litro	17	4	25.00	30.00	100	10
50	Yogurt Lala de fresa 1L	Yogurt Lala sabor Fresa 1 Litro	17	4	25.00	30.00	100	10
99	Harina de trigo San antonio	None	10	41	8.00	10.50	100	10
43	Del Valle fruit guayaba 600ml	Jugo Del Valle sabor Guayaba 600 ml	31	28	10.50	13.50	100	10
101	Pan bimbo blanco chico	None	27	17	8.00	10.50	100	10
102	Pan bimbo blanco grande	None	27	17	8.00	10.50	100	10
103	Pan bimbo integral chico	None	27	17	8.00	10.50	100	10
104	Pan bimbo integral grande	None	27	17	8.00	10.50	100	10
105	Rebanadas bimbo	None	27	17	8.00	10.50	100	10
106	Chocoroles	None	27	17	8.00	10.50	100	10
107	Nito bimbo	None	27	17	8.00	10.50	100	10
109	Roles de canela con pasas	None	27	17	8.00	10.50	100	10
110	Roles de canela glaseados	None	27	17	8.00	10.50	100	10
111	Conchas bimbo	None	27	17	8.00	10.50	100	10
112	Panque de nuez bimbo	None	27	17	8.00	10.50	100	10
113	Donitas bimbo	None	27	17	8.00	10.50	100	10
114	Donitas espolvoreadas bimbo	None	27	17	8.00	10.50	100	10
115	Tostadas charras	None	5	60	8.00	10.50	100	10
116	Tostadas Sanissimo	None	5	61	8.00	10.50	100	10
10	Roles	Ricos roles de canela caseros	27	13	70.00	100.00	17	10
20	Coca Cola 355ml	Refresco Coca Cola 355 ml	31	16	8.00	10.50	100	10
21	Coca Cola 600ml	Refresco Coca Cola 600 ml	31	16	9.00	12.00	100	10
22	Coca Cola retornable 1 1/4 lt.	Refresco Coca Cola retornable 1 1/4 lt	31	16	12.50	15.50	100	10
23	Coca Cola 2L retornable	Refresco Coca Cola retornable 2 Litros	31	16	19.50	24.00	100	10
24	Coca Cola 3L retornable	Refresco Coca Cola retornable 3 Litros	31	16	24.00	30.00	100	10
25	Coca Cola Light 600ml	Refresco Coca Cola Light 600 ml	31	16	9.50	12.50	100	10
15	Manzanita 2lt.		31	14	17.00	25.00	22	3
32	Manzanita 600ml	Refresco Manzanita Sol 600 ml	31	16	9.00	12.00	100	10
28	Fanta 600ml	Refresco Fanta 600 ml	31	16	9.00	12.00	100	10
29	Fanta 1.5L	Refresco Fanta 1.5 Litros	31	16	12.50	16.00	100	10
30	Sprite 600ml	Refresco Sprite 600 ml	31	16	9.00	12.00	100	10
31	Sprite 1.5L	Refresco Sprite 1.5 Litros	31	16	12.50	16.00	100	10
33	Manzanita 1.5L	Refresco Manzanita Sol 1.5 Litros	31	16	12.50	16.00	100	10
38	Jumex de mango 1L	Jugo Jumex sabor Mango 1 Litro	31	21	16.00	20.00	100	10
34	Fresca 600ml	Refresco Fresca 600 ml	31	16	9.00	12.00	100	10
35	Fresca 3L	Refresco Fresca 3 Litros	31	16	24.00	30.00	100	10
36	Mirinda 600ml	Refresco Mirinda 600 ml	31	16	9.00	12.00	100	10
37	Mirinda 1.5L	Refresco Mirinda 1.5 Litros	31	16	12.50	16.00	100	10
40	Jumex de manzana 600ml	Jugo Jumex sabor Manzana 600 ml	31	21	10.00	13.00	100	10
39	Jumex de durazno 1L	Jugo Jumex sabor Durazno 1 Litro	31	21	16.00	20.00	100	10
118	Emperador chocolate	None	29	46	8.00	10.50	100	10
119	Emperador nuez	None	29	46	8.00	10.50	100	10
42	Del Valle fruit manzana 600ml	Jugo Del Valle sabor Manzana 600 ml	31	28	10.50	13.50	100	10
120	Emperador vainilla	None	29	46	8.00	10.50	100	10
121	Emperador limon	None	29	46	8.00	10.50	100	10
122	Emperador Senso	None	29	46	8.00	10.50	100	10
123	Mamut chico	None	29	46	8.00	10.50	100	10
41	Del Valle fruit naranja 600ml	Jugo Del Valle sabor Naranja 600 ml	31	28	10.50	13.50	100	10
53	Mantequilla Lala 250g	Mantequilla Lala 250 gramos	19	4	30.00	38.00	100	10
108	Mantecadas	None	27	17	8.00	10.50	100	10
124	Mamut grande	None	29	46	8.00	10.50	100	10
125	Chokis	None	29	46	8.00	10.50	100	10
52	Yogurt Yoplait de fresa 1L	Yogurt Yoplait sabor Fresa 1 Litro	17	54	26.00	31.00	100	10
54	Queso panela Lala 200g	Queso panela Lala 200 gramos	16	4	40.00	50.00	100	10
97	Arroz Mexica 1kg	None	2	59	12.00	16.50	100	10
98	Harina de maiz maseca	None	10	59	8.00	10.50	100	10
126	Chokis rellenas	None	29	46	8.00	10.50	100	10
127	Chokis doble chocolate	None	29	46	8.00	10.50	100	10
128	Chokis brownie	None	29	46	8.00	10.50	100	10
401	Coca Cola Sin Azucar 600ml	Refresco Coca Cola Sin Azucar 600ml	31	16	12.00	17.00	0	5
402	Sprite 2L	Refresco sabor Limon 2 Litros	31	16	22.00	28.00	0	5
403	Fanta Naranja 2L	Refresco sabor Naranja 2 Litros	31	16	22.00	28.00	0	5
404	Sidral Mundet 2L	Refresco sabor Manzana 2 Litros	31	16	22.00	28.00	0	5
405	Fresca Toronja 2L	Refresco sabor Toronja 2 Litros	31	16	22.00	28.00	0	5
406	Del Valle Naranja 1L	Jugo Del Valle Naranja 1 Litro	31	28	18.00	23.00	0	5
407	Del Valle Durazno 1L	Jugo Del Valle Durazno 1 Litro	31	28	18.00	23.00	0	5
409	Fuze Tea Limon 600ml	Te helado sabor Limon 600ml	31	16	13.00	18.00	0	5
410	Fuze Tea Negro 600ml	Te helado sabor Negro 600ml	31	16	13.00	18.00	0	5
413	7Up 600ml	Refresco sabor Lima-Limon 600ml	31	14	12.00	16.00	0	5
414	7Up 2L	Refresco sabor Lima-Limon 2 Litros	31	14	20.00	26.00	0	5
415	Mirinda 2L	Refresco sabor Naranja 2 Litros	31	14	20.00	26.00	0	5
417	Agua Epura 5L	Agua Purificada Epura 5 Litros	30	14	24.00	32.00	0	5
418	Agua Epura 10L	Agua Purificada Epura 10 Litros	30	14	35.00	48.00	0	5
419	Agua Ciel 5L	Agua Purificada Ciel 5 Litros	30	16	25.00	33.00	0	5
421	Jumex Lata 335ml Guayaba	Jugo de Guayaba en Lata 335ml	31	21	10.00	14.00	0	5
68	Agua ciel 600ml	None	30	16	8.00	13.00	100	10
69	Agua ciel 1lt	None	30	16	10.00	15.00	100	10
70	Agua ciel 1.5l	None	30	16	12.00	17.00	100	10
71	Agua ciel 2lt	None	30	16	14.00	20.00	100	10
72	Agua E-pura 600ml	None	30	14	8.00	13.00	100	10
73	Agua E-pura 1lt	None	30	14	10.00	15.00	100	10
74	Garrafon E-pura 10lt	None	30	14	18.00	25.00	100	10
75	Crema Lala 200ml	None	15	4	8.00	13.00	100	10
76	Crema Lala 426ml	None	15	4	15.00	30.00	100	10
77	Crema Lala 900ml	None	15	4	35.00	55.00	100	10
55	Queso panela Alpura 200g	Queso panela Alpura 200 gramos	16	18	40.00	50.00	100	10
78	Crema alpura 200ml	None	15	4	8.00	13.00	100	10
79	Crema alpura 426ml	None	15	4	15.00	30.00	100	10
80	Crema alpura 900ml	None	15	4	35.00	55.00	100	10
81	Atun dolores en agua	None	6	51	10.00	15.00	100	10
82	Atun dolores en aceite	None	6	51	12.00	17.00	100	10
83	Sardinas en aceite	None	6	20	10.00	15.00	100	10
84	Frijoles refritos	None	6	50	10.00	15.00	100	10
85	Frijoles bayos	None	6	50	10.00	15.00	100	10
86	Lentejas la moderna	None	2	44	10.00	15.00	100	10
87	Pasta la moderna	None	2	44	10.00	15.00	100	10
56	Queso oaxaca Lala 200g	Queso Oaxaca Lala 200 gramos	16	4	45.00	55.00	100	10
408	Del Valle Mango 1L	Jugo Del Valle Mango 1 Litro	31	28	18.00	23.00	0	5
88	Coditos la moderna	None	2	44	10.00	15.00	100	10
58	Salchichas Fud paquete 500g	Salchichas Fud 500 gramos	18	53	30.00	40.00	100	10
59	Salchichas San Rafael paquete 500g	Salchichas San Rafael 500 gramos	18	52	35.00	45.00	100	10
89	Pasta Barilla espagueti	None	2	56	10.00	15.00	100	10
90	Sopa de letras la moderna	None	2	44	10.00	15.00	100	10
91	Sopa maruchan pollo	None	2	57	10.00	15.00	100	10
92	Sopa maruchan camaron	None	2	57	10.00	15.00	100	10
93	Sopa maruchan res	None	2	57	10.00	15.00	100	10
94	Sopa maruchan habanero	None	2	57	10.00	15.00	100	10
95	Sopa maruchan piquin	None	2	57	10.00	15.00	100	10
96	Sopa maruchan limon	None	2	57	10.00	15.00	100	10
423	Penafiel Mineral 600ml	Agua Mineral Penafiel 600ml	31	58	11.00	15.00	0	5
424	Penafiel Twist Limon 600ml	Agua Mineral con Limon 600ml	31	58	12.00	16.00	0	5
425	Sangria Senorial 355ml	Bebida sabor Sangria 355ml	31	58	10.00	14.00	0	5
426	Sangria Senorial 600ml	Bebida sabor Sangria 600ml	31	58	13.00	18.00	0	5
428	Jarritos Tamarindo 600ml	Refresco sabor Tamarindo 600ml	31	58	10.00	14.00	0	5
429	Jarritos Multisabor 2L	Refresco varios sabores 2 Litros	31	58	18.00	24.00	0	5
60	Jamon de pavo Fud 250g	Jamon de Pavo Fud 250 gramos	18	53	35.00	45.00	100	10
61	Jamon de pavo San Rafael 250g	Jamon de Pavo San Rafael 250 gramos	18	52	40.00	50.00	100	10
62	Sidral mundet 600ml	Refresco de manzana de 600ml	31	16	10.00	16.00	20	5
63	Sidral mundet 3lt	Refresco de manzana de 3lt	31	16	24.00	30.00	20	5
64	Agua bonafont 600ml	None	30	55	8.00	10.50	100	10
65	Agua bonafont 1lt	None	30	55	12.00	15.00	100	10
66	Agua bonafont 2lt.	None	30	55	14.00	18.00	100	10
67	Garrafon bonafont 20lt	None	30	55	19.50	24.00	100	10
431	Leche Lala Entera 1.5L	Leche Entera 1.5 Litros	15	4	30.00	37.00	0	5
432	Leche Lala Semidescremada 1L	Leche Semidescremada 1 Litro	15	4	21.00	26.00	0	5
433	Leche Alpura Entera 1L	Leche Alpura Entera 1 Litro	15	18	20.00	25.00	0	5
434	Leche Alpura Deslactosada 1L	Leche Alpura Deslactosada 1 Litro	15	18	22.00	27.00	0	5
435	Leche Alpura 250ml Fresa	Leche saborizada Fresa 250ml	15	18	8.50	12.00	0	5
411	Pepsi 2.5L NR	Refresco Pepsi 2.5 Litros No Retornable	31	14	25.00	32.00	0	5
412	Pepsi 3L NR	Refresco Pepsi 3 Litros No Retornable	31	14	28.00	36.00	0	5
57	Queso manchego Lala 200g	Queso Manchego Lala 200 gramos	16	4	50.00	60.00	100	10
420	Jumex Lata 335ml Mango	Jugo de Mango en Lata 335ml	31	21	10.00	14.00	0	5
422	Jumex Lata 335ml Manzana	Jugo de Manzana en Lata 335ml	31	21	10.00	14.00	0	5
427	Jarritos Mandarina 600ml	Refresco sabor Mandarina 600ml	31	58	10.00	14.00	0	5
132	Florentinas gamesa	None	29	46	8.00	10.50	100	10
133	Marias doradas	None	29	46	8.00	10.50	100	10
134	Gamesa cajeta	None	29	46	8.00	10.50	100	10
135	Maravillas gamesa	None	29	46	8.00	10.50	100	10
136	Crackets gamesa	None	29	46	8.00	10.50	100	10
137	Surtido rico gamesa	None	29	46	8.00	10.50	100	10
138	Delicias gamesa	None	29	46	8.00	10.50	100	10
139	Oreo	None	9	58	8.00	10.50	100	10
140	Principe chocolate	None	9	22	8.00	10.50	100	10
141	Principe vainilla	None	9	22	8.00	10.50	100	10
142	Principe limon	None	9	22	8.00	10.50	100	10
143	Principe chocolate blanco	None	9	22	8.00	10.50	100	10
144	Lors	None	9	22	8.00	10.50	100	10
145	Plativolos	None	9	22	8.00	10.50	100	10
146	Sponch	None	9	22	8.00	10.50	100	10
147	Triki trakes	None	9	22	8.00	10.50	100	10
148	MaxiTubo Triki trakes	None	9	22	8.00	10.50	100	10
149	Gansito	None	9	22	8.00	10.50	100	10
150	Pinguinos	None	9	22	8.00	10.50	100	10
151	Pasticetas marinela	None	9	22	8.00	10.50	100	10
152	Barritas fresa	None	9	22	8.00	10.50	100	10
153	Barritas pina	None	9	22	8.00	10.50	100	10
154	Barritas moras	None	9	22	8.00	10.50	100	10
156	Maxitubo Barritas pina	None	9	22	8.00	10.50	100	10
157	Canelitas	None	9	22	8.00	10.50	100	10
158	Polvorones	None	9	22	8.00	10.50	100	10
159	Maxitubo Polvorones	None	9	22	8.00	10.50	100	10
160	Ricanelas	None	9	46	8.00	10.50	100	10
161	Ritz bits queso	None	9	58	8.00	10.50	100	10
162	Arcoiris	None	9	46	8.00	10.50	100	10
163	Submarinos fresa	None	9	22	8.00	10.50	100	10
164	Submarinos vainilla	None	9	22	8.00	10.50	100	10
165	Submarinos chocolate	None	9	22	8.00	10.50	100	10
166	Rocko chico	None	9	22	8.00	10.50	100	10
167	Rocko grande	None	9	22	8.00	10.50	100	10
168	Sabritas original	None	9	3	8.00	10.50	100	10
169	Sabritas adobadas	None	9	3	8.00	10.50	100	10
170	Sabritas limon	None	9	3	8.00	10.50	100	10
171	Sabritas flamin hot	None	9	3	8.00	10.50	100	10
172	Sabritas crema y especias	None	9	3	8.00	10.50	100	10
173	Sabritas habanero	None	9	3	8.00	10.50	100	10
174	Sabritas receta crujiente	None	9	3	8.00	10.50	100	10
175	Sabritas receta crujiente jalapeno	None	9	3	8.00	10.50	100	10
176	Crujitos	None	9	3	8.00	10.50	100	10
205	Papatinas	None	9	47	8.00	10.50	100	10
178	Doritos incognita	None	9	3	8.00	10.50	100	10
179	Doritos diablo	None	9	3	8.00	10.50	100	10
180	Doritos flamin hot	None	9	3	8.00	10.50	100	10
181	Doritos dinamita	None	9	3	8.00	10.50	100	10
182	Sabritones	None	9	3	8.00	10.50	100	10
183	Bigmix queso	None	9	47	8.00	10.50	100	10
184	Bigmix fuego	None	9	47	8.00	10.50	100	10
185	Cheetos torciditos	None	9	3	8.00	10.50	100	10
186	Cheetos bolitas	None	9	3	8.00	10.50	100	10
187	Cheetos queso	None	9	3	8.00	10.50	100	10
188	Cheetos flamin hot	None	9	3	8.00	10.50	100	10
189	Ruffles original	None	9	3	8.00	10.50	100	10
190	Ruffles queso	None	9	3	8.00	10.50	100	10
191	Fritos sal y limon	None	9	3	8.00	10.50	100	10
192	Fritos chorizo	None	9	3	8.00	10.50	100	10
193	Bolsaza Sabritas original	None	9	3	8.00	10.50	100	10
194	Bolsaza Doritos nacho	None	9	3	8.00	10.50	100	10
195	Paketaxo	None	9	3	8.00	10.50	100	10
196	Paketaxo queso	None	9	3	8.00	10.50	100	10
197	Paketaxo flamin hot	None	9	3	8.00	10.50	100	10
198	Churrumaiz	None	9	3	8.00	10.50	100	10
199	Churrumaiz flamin hot	None	9	3	8.00	10.50	100	10
200	Rancheritos	None	9	3	8.00	10.50	100	10
201	Sabritas switch doritos nacho	None	9	3	8.00	10.50	100	10
202	Runners	None	9	47	8.00	10.50	100	10
203	Chips jalapeno	None	9	47	8.00	10.50	100	10
204	Chips sal	None	9	47	8.00	10.50	100	10
131	Cremax fresa	None	29	46	8.00	10.50	100	10
206	Chips fuego	None	9	47	8.00	10.50	100	10
207	Palomitas pop	None	9	47	8.00	10.50	100	10
208	Takis original 	None	9	47	8.00	10.50	100	10
209	Takis fuego	None	9	47	8.00	10.50	100	10
210	Takis salsa brava	None	9	47	8.00	10.50	100	10
211	Takis guacamole	None	9	47	8.00	10.50	100	10
212	Chipotles	None	9	47	8.00	10.50	100	10
213	Tostachos	None	9	47	8.00	10.50	100	10
214	Hot nuts	None	9	47	8.00	10.50	100	10
215	Hot nuts fuego	None	9	47	8.00	10.50	100	10
216	Valentones	None	9	47	8.00	10.50	100	10
217	Watz barcel	None	9	47	8.00	10.50	100	10
218	Toreadas	None	9	47	8.00	10.50	100	10
219	Palomitas pop fuego	None	9	47	8.00	10.50	100	10
220	Takis blue heat	None	9	47	8.00	10.50	100	10
221	Doraditas tia rosa	None	29	49	8.00	10.50	100	10
130	Cremax chocolate	None	29	46	8.00	10.50	100	10
177	Doritos nacho	None	9	3	8.00	10.50	100	10
250	Paleta Vero mango	None	8	68	8.00	10.50	100	10
226	Hersheys Cookies n Cream	None	8	45	8.00	10.50	100	10
227	Hersheys almendras	None	8	45	8.00	10.50	100	10
228	Hersheys chocolate amargo	None	8	45	8.00	10.50	100	10
229	Hersheys chocolate blanco	None	8	45	8.00	10.50	100	10
230	Crunch	None	8	19	8.00	10.50	100	10
231	Carlos V	None	8	19	8.00	10.50	100	10
232	Milky way	None	8	19	8.00	10.50	100	10
233	Snickers	None	8	19	8.00	10.50	100	10
234	Kit kat	None	8	19	8.00	10.50	100	10
235	Kinder delice	None	8	40	8.00	10.50	100	10
236	Kinder sorpresa	None	8	40	8.00	10.50	100	10
237	Ferrero rocher 3 piezas	None	8	40	8.00	10.50	100	10
238	Mazapan	None	8	62	8.00	10.50	100	10
239	Pelon pelo rico	None	8	45	8.00	10.50	100	10
240	Pulparindo tamarindo	None	8	62	8.00	10.50	100	10
241	Pulparindo chamoy	None	8	62	8.00	10.50	100	10
242	Tutsi pop	None	8	65	8.00	10.50	100	10
243	Oblea cajeta coronado	None	8	66	8.00	10.50	100	10
244	Paleta payaso	None	8	67	8.00	10.50	100	10
245	Duvalin fresa vainilla	None	8	67	8.00	10.50	100	10
246	Duvalin chocolate vainilla	None	8	67	8.00	10.50	100	10
247	Duvalin vainilla	None	8	67	8.00	10.50	100	10
248	Duvalin trisabor	None	8	67	8.00	10.50	100	10
249	Duvalin choco avellana	None	8	67	8.00	10.50	100	10
271	Palomitas Act II mantequilla	None	9	58	8.00	10.50	100	10
251	Paleta Vero elote	None	8	67	8.00	10.50	100	10
252	Panditas	None	8	67	8.00	10.50	100	10
253	Panditas rellenos	None	8	67	8.00	10.50	100	10
254	Panditas san valentin	None	8	67	8.00	10.50	100	10
255	Bubulubu	None	8	67	8.00	10.50	100	10
256	Rockaleta	None	8	69	8.00	10.50	100	10
257	Tic tac menta	None	8	40	8.00	10.50	100	10
258	Tic tac naranja	None	8	40	8.00	10.50	100	10
259	Halls menta	None	8	58	8.00	10.50	100	10
225	Conchas tia rosa	None	29	49	8.00	10.50	100	10
261	Halls yerba buena	None	8	58	8.00	10.50	100	10
262	Halls miel	None	8	58	8.00	10.50	100	10
263	Halls negras	None	8	58	8.00	10.50	100	10
264	Gomilocas dientes	None	8	67	8.00	10.50	100	10
265	Gomilocas pinguino	None	8	67	8.00	10.50	100	10
266	Chocoretas	None	8	67	8.00	10.50	100	10
267	Kranky	None	8	67	8.00	10.50	100	10
268	Lucas muecas	None	8	58	8.00	10.50	100	10
269	Lucas chamoy	None	8	58	8.00	10.50	100	10
270	Lucas gusanito	None	8	58	8.00	10.50	100	10
301	Vinagre de manzana la coste¤a	None	1	27	8.00	10.50	100	10
272	Palomitas Act II natural	None	9	58	8.00	10.50	100	10
273	Palomitas Act II chile limon	None	9	58	8.00	10.50	100	10
274	Tostitos salsa verde	None	9	3	8.00	10.50	100	10
275	Zucaritas chicas	None	5	26	8.00	10.50	100	10
276	Zucaritas grandes	None	5	26	8.00	10.50	100	10
277	Corn flakes chicas	None	5	26	8.00	10.50	100	10
278	Corn flakes grandes	None	5	26	8.00	10.50	100	10
279	Choco Krispis chicas	None	5	26	8.00	10.50	100	10
280	Choco Krispis grandes	None	5	26	8.00	10.50	100	10
281	Nesquik chico	None	5	26	8.00	10.50	100	10
282	Nesquik grande	None	5	26	8.00	10.50	100	10
283	Froot loops chicas	None	5	26	8.00	10.50	100	10
284	Froot loops grandes	None	5	26	8.00	10.50	100	10
285	Chocomilk sobre	None	4	58	8.00	10.50	100	10
286	Chocomilk bolsa	None	4	58	8.00	10.50	100	10
287	Chocomilk lata	None	4	58	8.00	10.50	100	10
288	Nescafe clasico sobre	None	4	19	8.00	10.50	100	10
289	Nescafe capuccino sobre	None	4	19	8.00	10.50	100	10
290	Nescafe clasico bote chico	None	4	19	8.00	10.50	100	10
291	Nescafe clasico bote grande	None	4	19	8.00	10.50	100	10
292	Azucar Zulka 1kg	None	3	58	8.00	10.50	100	10
293	Azucar refinada 1kg	None	3	58	8.00	10.50	100	10
294	Azucar refinada 500gr	None	3	58	8.00	10.50	100	10
295	Azucar refinada 250gr	None	3	58	8.00	10.50	100	10
296	Aceite nutrioli 1lt	None	1	58	8.00	10.50	100	10
297	Aceite capullo 1lt	None	1	58	8.00	10.50	100	10
298	Aceite 1 2 3 1lt	None	1	58	8.00	10.50	100	10
299	Aceite patrona 1lt	None	1	58	8.00	10.50	100	10
300	Vinagre blanco la coste¤a	None	1	27	8.00	10.50	100	10
302	Catsup la coste¤a	None	1	27	8.00	10.50	100	10
303	Catsup Del monte	None	1	70	8.00	10.50	100	10
304	Catsup heinz	None	1	71	8.00	10.50	100	10
305	Jugo Magui	None	7	19	8.00	10.50	100	10
306	Salsa inglesa	None	7	19	8.00	10.50	100	10
307	Salsa valentina chica	None	7	58	8.00	10.50	100	10
308	Salsa valentina grande	None	7	58	8.00	10.50	100	10
309	Salsa tabasco	None	7	58	8.00	10.50	100	10
310	Salsa buffalo	None	7	58	8.00	10.50	100	10
311	Salsa chipotle la coste¤a	None	7	27	8.00	10.50	100	10
312	Chile chipotle la coste¤a	None	6	27	8.00	10.50	100	10
223	Tortillinas tia rosa	None	10	49	8.00	10.50	100	10
260	Halls limon	None	8	58	8.00	10.50	100	10
320	Mermelada mccormick fresa chica	None	19	72	8.00	10.50	100	10
321	Mermelada mccormick fresa grande	None	19	72	8.00	10.50	100	10
340	Papel higienico Suavel 4 rollos	None	37	58	8.00	10.50	100	10
341	Papel higienico Suavel 6 rollos	None	37	58	8.00	10.50	100	10
342	Toallas sanitarias Always	None	37	58	8.00	10.50	100	10
343	Toallas sanitarias Kotex	None	37	58	8.00	10.50	100	10
359	Licuado lala fresa platano	None	15	4	15.00	30.00	100	10
360	Licuado lala nuez	None	15	4	15.00	30.00	100	10
361	Flan lala	None	15	4	15.00	30.00	100	10
362	Margarina lala 90gr	None	15	4	15.00	30.00	100	10
363	Perejil ramo		21	58	3.00	5.00	5	1
364	Producto nuevo de prueba	Producto para ver funciones	4	4	28.00	32.50	19	5
438	Media Crema Nestle 190g	Media Crema para cocina 190g	15	19	13.00	18.00	0	5
344	Panales Huggies	None	44	58	8.00	10.50	100	10
345	Shampoo Head & Shoulders chico	None	39	58	8.00	10.50	100	10
346	Shampoo Head & Shoulders grande	None	39	58	8.00	10.50	100	10
347	Desodorante Axe	None	41	58	8.00	10.50	100	10
441	Yogurt Lala Fresa Bebible 220g	Yogurt bebible sabor Fresa 220g	17	4	9.00	13.00	0	5
442	Yogurt Lala Durazno Bebible 220g	Yogurt bebible sabor Durazno 220g	17	4	9.00	13.00	0	5
444	Yogurt Danone Fresa Batido 120g	Yogurt batido sabor Fresa 120g	17	58	7.00	10.00	0	5
445	Yogurt Danone Natilla Chocolate	Postre sabor Chocolate Danone	17	58	8.00	11.00	0	5
446	Queso Philadelphia 180g	Queso Crema Philadelphia 180g	16	58	32.00	42.00	0	5
447	Queso Panela La Villita 400g	Queso Panela La Villita 400g	16	58	55.00	72.00	0	5
449	Margarina Primavera 200g	Margarina Primavera 200g	19	58	15.00	21.00	0	5
450	Huevo Blanco 12 pzas	Paquete Huevo Blanco 12 piezas	14	58	30.00	38.00	0	5
451	Huevo Blanco 18 pzas	Paquete Huevo Blanco 18 piezas	14	23	42.00	55.00	0	5
452	Papas Sabritas Sal 42g	Papas fritas con sal 42g	9	3	13.50	18.00	0	5
322	Cloralex 1/2 lt	None	35	58	8.00	10.50	100	10
439	Leche Condensada La Lechera 375g	Leche Condensada Clasica 375g	11	19	22.00	29.00	0	5
51	Yogurt Yoplait natural 1L	Yogurt Yoplait natural 1 Litro	17	54	26.00	31.00	100	10
348	Yomi lala chocolate	None	15	4	15.00	30.00	100	10
129	Cremax vainilla	None	29	46	8.00	10.50	100	10
155	Maxitubo Barritas fresa	None	9	22	8.00	10.50	100	10
222	Bigote tia rosa	None	29	49	8.00	10.50	100	10
224	Magdalenas tia rosa	None	29	49	8.00	10.50	100	10
313	Chiles serranos la coste¤a	None	6	27	8.00	10.50	100	10
314	Chiles en vinagre la coste¤a	None	6	27	8.00	10.50	100	10
315	Chile chipotle la morena	None	6	72	8.00	10.50	100	10
316	Chiles en vinagre la morena	None	6	72	8.00	10.50	100	10
317	Mayonesa mccormick chica	None	7	72	8.00	10.50	100	10
318	Mayonesa mccormick grande	None	7	72	8.00	10.50	100	10
319	Mostaza mccormick	None	7	72	8.00	10.50	100	10
323	Cloralex 1 lt	None	35	58	8.00	10.50	100	10
324	Pinol	None	35	58	8.00	10.50	100	10
325	Fabuloso lavanda 1lt	None	35	58	8.00	10.50	100	10
326	Fabuloso aroma floral 1lt	None	35	58	8.00	10.50	100	10
453	Papas Sabritas Adobadas 42g	Papas fritas adobadas 42g	9	3	13.50	18.00	0	5
454	Papas Sabritas Limon 42g	Papas fritas con limon 42g	9	3	13.50	18.00	0	5
455	Doritos Nacho 61g	Botana de maiz sabor Queso 61g	9	3	13.00	18.00	0	5
456	Doritos Pizzerola 61g	Botana de maiz sabor Pizza 61g	9	3	13.00	18.00	0	5
327	Jabon zote rosa chico	None	42	58	8.00	10.50	100	10
328	Jabon zote rosa grande	None	42	58	8.00	10.50	100	10
329	Jabon zote blanco chico	None	42	58	8.00	10.50	100	10
330	Jabon zote blanco grande	None	42	58	8.00	10.50	100	10
331	Detergente Ariel 1/2 kg	None	34	58	8.00	10.50	100	10
332	Detergente Ariel 1kg	None	34	58	8.00	10.50	100	10
333	Detergente Ace 1/2 kg	None	34	58	8.00	10.50	100	10
334	Detergente Ace 1kg	None	34	58	8.00	10.50	100	10
335	Detergente Foca 1/2 kg	None	34	58	8.00	10.50	100	10
336	Detergente Foca 1kg	None	34	58	8.00	10.50	100	10
337	Suavitel 1l	None	34	58	8.00	10.50	100	10
349	Yomi lala vainilla	None	15	4	15.00	30.00	100	10
350	Yomi lala fresa	None	15	4	15.00	30.00	100	10
351	Yogurt lala fresa	None	15	4	15.00	30.00	100	10
352	Yogurt lala durazno	None	15	4	15.00	30.00	100	10
354	Yogurt bebible lala manzana	None	15	4	15.00	30.00	100	10
443	Yogurt Lala Manzana Bebible 220g	Yogurt bebible sabor Manzana 220g	17	4	9.00	13.00	0	5
355	Yogurt bebible lala durazno	None	15	4	15.00	30.00	100	10
356	Yogurt bebible lala fresa	None	15	4	15.00	30.00	100	10
357	Yogurt bebible lala moras	None	15	4	15.00	30.00	100	10
358	Yogurt bebible lala pina coco	None	15	4	15.00	30.00	100	10
457	Cheetos Torciditos 52g	Botana de maiz sabor Queso y Chile 52g	9	3	10.00	14.00	0	5
338	Papel higienico Petalo 4 rollos	None	37	58	8.00	10.50	100	10
339	Papel higienico Petalo 6 rollos	None	37	58	8.00	10.50	100	10
458	Cheetos Colmillos 27g	Botana de maiz sabor Queso y Chile 27g	9	3	6.00	9.00	0	5
353	Yogurt lala manzana	None	15	4	15.00	30.00	100	10
448	Mantequilla Gloria 90g	Mantequilla Gloria con Sal 90g	19	58	18.00	24.00	0	5
459	Ruffles Queso 50g	Papas onduladas sabor Queso 50g	9	3	13.50	18.00	0	5
460	Tostitos Verdes 65g	Botana de maiz sabor Salsa Verde 65g	9	3	13.00	18.00	0	5
461	Takis Fuego 65g	Botana de maiz sabor Fuego 65g	9	58	12.00	17.00	0	5
462	Chips Sal de Mar 42g	Papas fritas con Sal de Mar 42g	9	58	14.00	19.00	0	5
463	Cacahuates Sabritas Japones 45g	Cacahuates estilo Japones 45g	9	3	9.00	12.00	0	5
464	Cacahuates Sabritas Enchilados 45g	Cacahuates Enchilados 45g	9	3	9.00	12.00	0	5
465	Galletas Emperador Chocolate Tubo	Galletas sandwich sabor Chocolate	9	46	13.00	18.00	0	5
466	Galletas Emperador Vainilla Tubo	Galletas sandwich sabor Vainilla	9	46	13.00	18.00	0	5
467	Galletas Marias Gamesa 144g	Galletas tipo Maria 144g	9	46	11.00	15.00	0	5
468	Galletas Chokis Clasica 63g	Galletas con chispas de chocolate 63g	9	46	12.00	16.00	0	5
469	Galletas Saladitas Gamesa 137g	Galletas saladas 137g	9	46	14.00	19.00	0	5
470	Galletas Ritz Tubo 89g	Galletas saladas Ritz 89g	9	58	11.00	15.00	0	5
471	Galletas Oreo 6 pzas	Galletas sandwich sabor Chocolate 6 pzas	9	58	11.00	15.00	0	5
472	Barritas Marinela Fresa 67g	Galletas rellenas de Fresa 67g	29	22	12.00	16.00	0	5
473	Barritas Marinela Pina 67g	Galletas rellenas de Pina 67g	29	22	12.00	16.00	0	5
474	Canelitas Marinela Tubo	Galletas sabor Canela	29	22	13.00	18.00	0	5
475	Triki-Trakes Marinela Tubo	Galletas con chispas de chocolate	29	22	13.00	18.00	0	5
476	Pinguinos Marinela 2 pzas	Pastelitos sabor Chocolate 2 pzas	29	22	15.00	21.00	0	5
477	Choco Roles Marinela 2 pzas	Pastelitos con chocolate y piña 2 pzas	29	22	15.00	21.00	0	5
478	Gansito Marinela 50g	Pastelito cubierto de chocolate 50g	29	22	12.00	17.00	0	5
480	Panque Bimbo Nuez	Panque con trozos de nuez	29	17	35.00	48.00	0	5
481	Detergente Roma 1kg	Detergente multiusos en polvo 1kg	34	33	28.00	36.00	0	5
482	Detergente Roma 500g	Detergente multiusos en polvo 500g	34	33	15.00	20.00	0	5
483	Detergente Foca 1kg	Detergente biodegradable en polvo 1kg	34	33	30.00	38.00	0	5
484	Detergente Blanca Nieves 1kg	Detergente en polvo para ropa 1kg	34	33	29.00	37.00	0	5
485	Jabon Zote Rosa 400g	Jabon de lavanderia Rosa 400g	33	33	18.00	24.00	0	5
486	Jabon Zote Blanco 400g	Jabon de lavanderia Blanco 400g	33	33	18.00	24.00	0	5
487	Jabon Zote Azul 400g	Jabon de lavanderia Azul 400g	33	33	18.00	24.00	0	5
488	Suavitel Primavera 850ml	Suavizante de telas Primavera 850ml	32	32	20.00	28.00	0	5
489	Fabuloso Lavanda 1L	Limpiador multiusos Lavanda 1L	35	30	22.00	30.00	0	5
490	Pinol Original 1L	Limpiador desinfectante de Pino 1L	35	58	24.00	32.00	0	5
491	Cloralex El Rendidor 950ml	Blanqueador desinfectante 950ml	35	58	14.00	19.00	0	5
492	Axion Liquido Limon 400ml	Lavatrastes liquido Limon 400ml	34	30	18.00	25.00	0	5
493	Jabon Palmolive Neutro 150g	Jabon de tocador Neutro 150g	41	31	12.00	17.00	0	5
494	Jabon Zest Frescura 150g	Jabon de tocador Zest 150g	41	58	12.00	17.00	0	5
495	Pasta Colgate Triple Accion 75ml	Pasta dental Triple Accion 75ml	38	30	14.00	20.00	0	5
496	Pasta Colgate Total 12 100ml	Pasta dental Total 12 100ml	38	30	28.00	38.00	0	5
497	Shampoo Savile Biotina 750ml	Shampoo con Biotina y Sábila 750ml	35	58	32.00	45.00	0	5
498	Shampoo Pantene Restauracion 400ml	Shampoo Restauracion 400ml	35	35	45.00	62.00	0	5
499	Papel Regio Aires Frescura 4 rollos	Papel Higienico Regio 4 rollos	43	29	22.00	30.00	0	5
500	Papel Petalo Rendimax 4 rollos	Papel Higienico Petalo 4 rollos	43	29	20.00	28.00	0	5
501	Aceite Nutrioli 850ml	Aceite puro de Soya 850ml	1	58	32.00	42.00	0	5
502	Aceite 1-2-3 1L	Aceite vegetal 1-2-3 1 Litro	1	58	35.00	45.00	0	5
503	Arroz Verde Valle 900g	Arroz Super Extra Verde Valle 900g	2	58	24.00	32.00	0	5
504	Frijol Negro Verde Valle 900g	Frijol Negro Verde Valle 900g	2	58	38.00	48.00	0	5
505	Spaghetti La Moderna 200g	Pasta tipo Spaghetti 200g	2	44	7.50	11.00	0	5
506	Codo No. 2 La Moderna 200g	Pasta tipo Codo 200g	2	44	7.50	11.00	0	5
507	Fideo No. 0 La Moderna 200g	Pasta tipo Fideo 200g	2	44	7.50	11.00	0	5
508	Atun Herdez en Agua 130g	Atun en hojuelas Agua 130g	6	20	14.00	20.00	0	5
509	Atun Dolores en Aceite 130g	Atun en hojuelas Aceite 130g	6	51	15.00	21.00	0	5
510	Chiles Jalapenos La Costena 220g	Chiles en Vinagre Rajitas 220g	6	27	10.00	14.00	0	5
511	Chiles Chipotles La Costena 105g	Chiles Chipotles en Adobo 105g	6	27	9.00	13.00	0	5
512	Elotes Dorados Herdez 220g	Granos de Elote Dulce 220g	6	20	11.00	16.00	0	5
513	Mayonesa McCormick Limon 190g	Mayonesa con Limon McCormick 190g	12	72	16.00	22.00	0	5
514	Mayonesa McCormick Limon 390g	Mayonesa con Limon McCormick 390g	12	72	35.00	45.00	0	5
515	Salsa Catsup Del Monte 320g	Salsa de Tomate Catsup 320g	12	58	13.00	18.00	0	5
516	Salsa Valentina Amarilla 370ml	Salsa picante Valentina 370ml	12	58	11.00	16.00	0	5
517	Cafe Nescafe Clasico 42g	Cafe Soluble Nescafe Clasico 42g	44	19	28.00	38.00	0	5
518	Cafe Nescafe Clasico 120g	Cafe Soluble Nescafe Clasico 120g	44	19	65.00	85.00	0	5
519	Chocolate Abuelita 90g	Tablilla Chocolate Abuelita 90g	8	19	14.00	20.00	0	5
520	Harina Maseca 1kg	Harina de Maiz Nixtamalizado 1kg	10	59	16.00	22.00	0	5
521	Harina de Trigo San Antonio 1kg	Harina de Trigo para pan 1kg	10	41	15.00	20.00	0	5
522	Azucar Estandar 1kg	Azucar Morena en bolsa 1kg	3	58	22.00	30.00	0	5
523	Sal de Mesa La Fina 1kg	Sal yodada La Fina 1kg	13	58	13.00	18.00	0	5
524	Consome Knorr Suiza 8 cubos	Sazonador de Pollo en Cubos	13	58	12.00	17.00	0	5
525	Pan Blanco Bimbo Gde 680g	Pan de Caja Blanco Grande Bimbo	27	17	35.00	46.00	0	5
526	Pan Integral Bimbo Gde 675g	Pan de Caja Integral Grande Bimbo	27	17	38.00	50.00	0	5
527	Tostadas Charras Amarillas 300g	Tostadas de Maiz Charras 300g	5	60	22.00	30.00	0	5
528	Tostadas Sanissimo Horneadas 20 pzas	Tostadas Horneadas Sanissimo	5	61	25.00	35.00	0	5
529	Corn Flakes Kelloggs 500g	Cereal de Maiz Corn Flakes 500g	5	26	38.00	52.00	0	5
530	Zucaritas Kelloggs 600g	Cereal de Maiz con Azucar 600g	5	26	45.00	60.00	0	5
531	Choco Krispis Kelloggs 600g	Cereal de Arroz con Chocolate 600g	5	26	45.00	60.00	0	5
532	Avena Quaker Instantanea 400g	Avena con Proteina Quaker 400g	25	25	28.00	38.00	0	5
533	Barritas Quaker Fresa 6 pzas	Barras de Avena con Fresa	25	25	22.00	30.00	0	5
534	Trident Menta 12 pzas	Goma de mascar sin azucar Menta	8	58	10.00	15.00	0	5
535	Trident Yerba Buena 12 pzas	Goma de mascar sin azucar Yerba Buena	8	58	10.00	15.00	0	5
536	Chicles Canels 4 pastillas	Goma de mascar Canels caja chica	8	62	1.50	3.00	0	5
537	Bubbaloo Fresa 1 pza	Chicle con relleno liquido Fresa	8	58	1.50	3.00	0	5
538	Bubbaloo Blue 1 pza	Chicle con relleno liquido Mora Azul	8	58	1.50	3.00	0	5
539	Carlos V Stick Chocolate	Barra de chocolate Carlos V chocolate	8	19	5.00	8.00	0	5
540	Crunch Stick Chocolate	Barra de chocolate con arroz inflado	8	19	5.00	8.00	0	5
541	Kinder Delice 39g	Pastelito relleno Kinder Delice	8	40	12.00	17.00	0	5
542	Kinder Sorpresa 20g	Huevo de chocolate con juguete	8	40	18.00	26.00	0	5
543	Ferrero Rocher 3 pzas	Bombones cubiertos de nuez Ferrero	8	40	25.00	35.00	0	5
544	Hersheys Cookies n Cream 40g	Barra chocolate blanco con galleta	8	45	11.00	16.00	0	5
545	Mazapan de la Rosa 28g	Dulce de cacahuate Mazapan	8	62	4.00	7.00	0	5
546	Pulparindo Clasico 14g	Dulce de tamarindo con chile	8	62	3.00	5.00	0	5
547	Pelon Pelo Rico 30g	Dulce de tamarindo suave	8	45	7.00	11.00	0	5
548	Paleta Payaso 45g	Malvavisco con chocolate y gomitas	8	67	12.00	18.00	0	5
549	Duvalin Trisabor 15g	Dulce de avellana, fresa y vainilla	8	67	3.00	5.00	0	5
550	Rockaleta Paleta 24g	Paleta con capas de chile y goma	8	69	4.50	8.00	0	5
551	Halls Mentol 9 pastillas	Pastillas refrescantes Mentol	8	58	8.00	12.00	0	5
552	Skwinkles Rellenos Pina	Dulce de chamoy relleno pina	8	45	9.00	14.00	0	5
553	Lucas Muecas Chamoy	Caramelo con polvo de chamoy	8	45	10.00	15.00	0	5
554	Tutsi Pop 1 pza	Paleta rellena de chicle	8	65	4.50	8.00	0	5
555	Agua Bonafont 600ml	Agua ligera Bonafont 600ml	30	55	8.00	12.00	0	5
556	Agua Bonafont 1.5L	Agua ligera Bonafont 1.5 Litros	30	55	12.00	17.00	0	5
557	Agua Bonafont 2L	Agua ligera Bonafont 2 Litros	30	55	14.00	20.00	0	5
558	Agua Mineral Topo Chico 600ml	Agua mineral de manantial 600ml	31	16	15.00	21.00	0	5
559	Vitamin Water Energy 500ml	Bebida vitaminada sabor Tropical	31	16	22.00	32.00	0	5
560	Monster Energy 473ml	Bebida energetizante original	31	16	30.00	42.00	0	5
561	Red Bull 250ml	Bebida energetizante original	31	58	32.00	45.00	0	5
562	Clight Jamaica 1 pza	Polvo para preparar bebida 7g	31	58	3.50	6.00	0	5
563	Clight Limon 1 pza	Polvo para preparar bebida 7g	31	58	3.50	6.00	0	5
564	Tang Naranja 1 pza	Polvo para preparar bebida 13g	31	58	3.50	6.00	0	5
565	Tang Pina 1 pza	Polvo para preparar bebida 13g	31	58	3.50	6.00	0	5
566	Zuko Horchata 1 pza	Polvo para preparar bebida 15g	31	58	3.50	6.00	0	5
567	Jamon de Pavo Fud 500g	Jamon de Pavo paq. 500g	18	53	65.00	85.00	0	5
568	Salchicha Viena Fud 500g	Salchicha de Pavo Viena 500g	18	53	42.00	58.00	0	5
569	Tocino Fud 250g	Tocino Ahumado de Pavo 250g	18	53	48.00	65.00	0	5
570	Salchicha Asar Chimex 800g	Salchicha roja para asar 800g	18	58	75.00	95.00	0	5
571	Chorizo de Pavo Fud 200g	Chorizo de Pavo paq. 200g	18	53	22.00	32.00	0	5
572	Papas Sabritas Habanero 42g	Papas fritas sabor Habanero 42g	9	3	13.50	18.00	0	5
573	Doritos Dinamita 61g	Botana enrollada sabor Chile y Limon	9	3	13.00	18.00	0	5
574	Ruffles Mezcla Brava 50g	Papas con botanas mixtas 50g	9	3	14.00	19.00	0	5
575	Papas Sabritas Crema y Especias 42g	Papas fritas sabor Crema y Especias	9	3	13.50	18.00	0	5
576	Doritos Flamin Hot 61g	Botana de maiz sabor Picante 61g	9	3	13.00	18.00	0	5
577	Churrumais con Limon 60g	Fritura de maiz sabor Limon 60g	9	3	8.00	11.00	0	5
578	Crujitos Queso y Chile 60g	Botana de maiz en espiral Queso	9	3	11.00	15.00	0	5
579	Rancheritos 60g	Botana de maiz sabor Chile y Especias	9	3	11.00	15.00	0	5
580	Sabritones 160g	Botana de trigo con Chile y Limon	9	3	18.00	25.00	0	5
581	Paketaxo Quexo 215g	Mezcla de botanas sabor Queso	9	3	35.00	48.00	0	5
582	Paketaxo Mezcla 215g	Mezcla de botanas variadas Sabritas	9	3	35.00	48.00	0	5
583	Chips Fuego 42g	Papas fritas sabor Fuego 42g	9	58	14.00	19.00	0	5
584	Takis Blue Heat 65g	Botana de maiz sabor Picante Azul	9	58	12.00	17.00	0	5
585	Tostachos Sal y Limon 65g	Botana de maiz tipo tostada	9	58	11.00	15.00	0	5
586	Palomitas Pop Sal de Mar 65g	Palomitas de maiz listas para comer	9	58	12.00	17.00	0	5
587	Palomitas Pop Acanaladas 65g	Palomitas de maiz sabor Queso	9	58	12.00	17.00	0	5
588	Galletas Oreo Chocolate 10 pzas	Galletas Oreo sabor Chocolate	9	58	14.00	19.00	0	5
589	Galletas Principe Marinela Tubo	Galletas con relleno de chocolate	9	22	13.50	19.00	0	5
590	Galletas Sponch Marinela 4 pzas	Galletas con malvavisco y coco	9	22	12.00	17.00	0	5
591	Galletas Polvorones Marinela Tubo	Galletas sabor Naranja	9	22	13.00	18.00	0	5
592	Galletas Ricanelas Marinela Tubo	Galletas sabor Canela y Azucar	29	22	13.00	18.00	0	5
593	Galletas Florentinas Cajeta Tubo	Galletas rellenas de cajeta	29	46	14.00	19.00	0	5
594	Galletas Florentinas Fresa Tubo	Galletas rellenas de fresa	29	46	14.00	19.00	0	5
595	Cremax de Nieve Chocolate 171g	Galletas wafer sabor Chocolate	29	46	14.00	19.00	0	5
596	Cremax de Nieve Fresa 171g	Galletas wafer sabor Fresa	29	46	14.00	19.00	0	5
597	Galletas Habaneras Integrales 117g	Galletas de harina integral	9	46	11.00	16.00	0	5
598	Galletas Habaneras Clasicas 117g	Galletas saladas crujientes	9	46	11.00	16.00	0	5
599	Galletas Crackets Tubo 95g	Galletas saladas horneadas Crackets	9	46	11.00	16.00	0	5
600	Galletas Mamut 44g	Galleta con malvavisco y chocolate	9	46	10.00	14.00	0	5
601	Galletas Giros Gamesa 100g	Galletas sandwich sabor chocolate	9	46	12.00	17.00	0	5
602	Galletas Senzo Chocolate 60g	Galletas rellenas de chocolate	9	46	11.00	16.00	0	5
603	Galletas Habaneras Integrales Tubo	Galletas saladas integrales tubo	9	46	13.00	18.00	0	5
604	Galletas Marias Doradas Gamesa	Galletas tipo maria doradas tubo	9	46	13.00	18.00	0	5
605	Galletas Piruetas Gamesa Tubo	Galletas sandwich limon tubo	9	46	13.50	19.00	0	5
606	Galletas Emperador Piruetas 6 pzas	Galletas sandwich sabor limon	9	46	11.00	15.00	0	5
607	Galletas Oreo Mini Copa 45g	Galletas mini oreo en vaso	9	58	12.50	17.00	0	5
608	Galletas Ritz Sándwich Queso	Galletas ritz rellenas de queso	9	58	11.00	15.00	0	5
609	Galletas Maravillas Vainilla	Galletas sabor vainilla Gamesa	9	46	11.50	16.00	0	5
610	Barras de Coco Gamesa	Galletas con trozos de coco	9	46	11.50	16.00	0	5
611	Hot Nuts Original 50g	Cacahuates con cobertura picante	9	58	9.50	13.00	0	5
612	Hot Nuts Fuego 50g	Cacahuates con cobertura extra picante	9	58	9.50	13.00	0	5
613	Big Mix Clasico 50g	Mezcla de botanas Barcel	9	58	11.50	16.00	0	5
614	Big Mix Fuego 50g	Mezcla de botanas picantes Barcel	9	58	11.50	16.00	0	5
615	Karameladas de Maiz 60g	Palomitas con caramelo Barcel	9	58	12.00	17.00	0	5
616	Runners 60g	Botana de maiz sabor picante	9	58	11.00	15.00	0	5
617	Takis Original 65g	Botana de maiz enrollada taco	9	58	12.00	17.00	0	5
618	Chips Jalapeno 42g	Papas fritas sabor jalapeno	9	58	14.50	20.00	0	5
619	Chips Chipotle 42g	Papas fritas sabor chipotle	9	58	14.50	20.00	0	5
620	Donitas Totis Sal y Limon 25g	Botana de trigo en aros	9	58	4.00	6.00	0	5
621	Donitas Totis Hot 25g	Botana de trigo picante	9	58	4.00	6.00	0	5
622	Que活os Barcel 60g	Botana de maiz sabor queso	9	58	11.00	15.00	0	5
623	Tostachos Queso 65g	Botana de maiz sabor queso	9	58	11.00	15.00	0	5
624	Cacahuates Mafer Salados 65g	Cacahuates premium con sal	9	3	16.00	22.00	0	5
625	Cacahuates Mafer Japones 65g	Cacahuates premium japones	9	3	16.00	22.00	0	5
626	Bubu Lubu Ricolino 35g	Malvavisco con jalea y chocolate	8	67	9.00	13.00	0	5
627	Kranky Ricolino 40g	Hojuelas de maiz con chocolate	8	67	9.50	14.00	0	5
628	Chocoretas Ricolino 45g	Bolitas de menta con chocolate	8	67	9.50	14.00	0	5
629	Gomitas Panditas Clasicos 45g	Gomitas de ositos frutales	8	67	11.00	15.00	0	5
630	Gomitas Panditas Enchilados 45g	Gomitas de ositos con chile	8	67	11.00	15.00	0	5
631	Dulce Gudupop Azul 1 pza	Paleta de caramelo suave	8	69	3.50	5.00	0	5
632	Gudu Cubos 1 pza	Caramelo suave de sabores	8	69	1.50	3.00	0	5
633	Milky Way Chocolate 48g	Barra de chocolate y caramelo	8	58	14.00	20.00	0	5
634	Snickers Chocolate 48g	Barra de chocolate, nuez y caramelo	8	58	14.00	20.00	0	5
635	M&Ms Chocolate 43g	Botones de chocolate con leche	8	58	14.00	20.00	0	5
636	M&Ms Cacahuate 43g	Botones de chocolate con cacahuate	8	58	14.00	20.00	0	5
637	Conejos Turin 20g	Chocolate con leche figura conejo	8	58	11.00	16.00	0	5
638	Bocadin Chocolate 1 pza	Galleta cubierta de chocolate	8	62	1.50	3.00	0	5
639	Mazapan de la Rosa Gigante 50g	Dulce de cacahuate grande	8	62	7.00	11.00	0	5
640	Pulparindo Extra Picante 14g	Dulce de tamarindo muy picante	8	62	3.50	5.00	0	5
641	Pulparindo Sandia 14g	Dulce de tamarindo sabor sandia	8	62	3.50	5.00	0	5
642	Lucas Gusano Chamoy 36g	Dulce liquido sabor chamoy	8	45	10.00	15.00	0	5
643	Lucas Bomvaso Limon 30g	Caramelo con polvo picante	8	45	10.50	15.00	0	5
644	Pica Fresa Gigante 1 pza	Gomita con chile sabor fresa	8	58	1.50	3.00	0	5
645	Pelon Pelo Rico Gigante 35g	Dulce de tamarindo grande	8	45	10.00	15.00	0	5
646	Skwinkles Clasicos Chamoy 26g	Tiras de dulce con chile	8	45	10.00	15.00	0	5
647	Kinder Chocolate 4 barras	Barritas de chocolate con leche	8	40	18.00	26.00	0	5
648	Halls Yerba Buena 9 pzas	Pastillas refrescantes yerbabuena	8	58	8.50	13.00	0	5
649	Halls Cereza 9 pzas	Pastillas refrescantes sabor cereza	8	58	8.50	13.00	0	5
650	Clorets 2 pastillas	Goma de mascar con clorofila	8	58	1.50	3.00	0	5
651	Shampoo Sedal Ceramidas 620ml	Shampoo para brillo y fuerza	35	34	42.00	58.00	0	5
652	Shampoo Sedal Restauracion 620ml	Shampoo para cabello danado	35	34	42.00	58.00	0	5
653	Shampoo Head & Shoulders Limpieza 375ml	Shampoo anticaspa original	35	58	55.00	75.00	0	5
654	Shampoo Head & Shoulders Mentol 375ml	Shampoo anticaspa mentolado	35	58	55.00	75.00	0	5
655	Shampoo Pantene Control Caida 400ml	Shampoo para evitar la caida	35	35	48.00	65.00	0	5
656	Acondicionador Pantene Restauracion 400ml	Acondicionador para cabello	35	35	48.00	65.00	0	5
657	Shampoo Savile Control Caspa 750ml	Shampoo con sabila y eucalipto	35	58	32.00	45.00	0	5
658	Shampoo Savile Chile 750ml	Shampoo con sabila y chile	35	58	32.00	45.00	0	5
659	Jabon Dove Original 135g	Barra de belleza humectante	41	36	22.00	30.00	0	5
660	Jabon Palmolive Oliva 150g	Jabon de tocador con oliva	41	31	13.00	18.00	0	5
661	Jabon Zest Limon 150g	Jabon de tocador refrescante	41	58	12.50	17.00	0	5
662	Jabon Rosa Venus 100g	Jabon de tocador clasico rosa	41	58	9.00	13.00	0	5
663	Desodorante Rexona Men Aerosol 150ml	Antitranspirante masculino spray	41	58	42.00	58.00	0	5
664	Desodorante Rexona Lady Aerosol 150ml	Antitranspirante femenino spray	41	58	42.00	58.00	0	5
665	Desodorante Axe Black Aerosol 150ml	Body spray para caballero	41	58	45.00	62.00	0	5
666	Desodorante Speed Stick 50g	Desodorante en barra caballero	41	58	30.00	42.00	0	5
667	Desodorante Lady Speed Stick 45g	Desodorante en barra dama	41	58	30.00	42.00	0	5
668	Rastrillo Gillette Prestobarba Azul 1 pza	Rastrillo desechable 2 hojas	41	58	14.00	20.00	0	5
669	Rastrillo Gillette Prestobarba 3 1 pza	Rastrillo desechable 3 hojas	41	58	22.00	30.00	0	5
670	Gel Ego Black 200ml	Gel fijador para caballero	41	58	18.00	25.00	0	5
671	Suavizante Downy Libre Enjuague 800ml	Suavizante de telas concentrado	32	58	25.00	35.00	0	5
672	Suavizante Ensueno Frescura 850ml	Suavizante de telas aroma fresco	32	58	18.00	25.00	0	5
673	Cloro Cloralex El Rendidor 2L	Blanqueador desinfectante 2 litros	35	58	26.00	35.00	0	5
674	Pinol Original 2L	Limpiador de pinol 2 litros	35	58	38.00	52.00	0	5
675	Fabuloso Mar Fresco 1L	Limpiador multiusos azul	35	30	22.00	30.00	0	5
677	Lavatrastes Salvo Limon 750ml	Detergente liquido para platos	34	58	30.00	42.00	0	5
678	Lavatrastes Axion Pasta 400g	Jabon en pasta para platos	34	30	18.00	25.00	0	5
679	Detergente Ariel Liquido 800ml	Detergente liquido para ropa	34	58	35.00	48.00	0	5
680	Detergente Mas Color 830ml	Detergente para ropa de color	34	58	38.00	52.00	0	5
681	Frijoles Isadora Refritos Bayos 430g	Frijoles en bolsa listos para comer	6	58	14.00	20.00	0	5
682	Frijoles Isadora Refritos Negros 430g	Frijoles en bolsa listos para comer	6	58	14.00	20.00	0	5
683	Frijoles La Costena Refritos Bayos 400g	Frijoles refritos en lata	6	27	13.00	18.00	0	5
684	Frijoles La Costena Refritos Negros 400g	Frijoles refritos en lata	6	27	13.00	18.00	0	5
685	Chicharos Herdez 215g	Chicharos verdes en lata	6	20	11.00	15.00	0	5
686	Chicharos con Zanahoria Herdez 215g	Verduras picadas en lata	6	20	11.00	15.00	0	5
687	Ensalada de Verduras Herdez 215g	Verduras mixtas en lata	6	20	12.00	17.00	0	5
688	Champiñones Troceados Herdez 186g	Champinones en conserva	6	20	18.00	25.00	0	5
689	Salsa Herdez Verde 210g	Salsa verde de tomatillo	12	20	13.00	18.00	0	5
690	Salsa Herdez Casera 210g	Salsa roja con trozos	12	20	13.00	18.00	0	5
691	Salsa Valentina Negra 370ml	Salsa muy picante etiqueta negra	12	58	12.00	17.00	0	5
692	Salsa Botanera Clasica 370ml	Salsa picante para botanas	12	58	10.00	14.00	0	5
693	Salsa Maggi Sazonador 100ml	Sazonador para carnes y sopas	13	19	22.00	30.00	0	5
694	Salsa Inglesa Crosse & Blackwell 145ml	Salsa tipo inglesa	13	19	25.00	35.00	0	5
695	Sopa Nissin Cup Noodles Pollo 64g	Sopa instantanea en vaso Pollo	2	11	10.00	15.00	0	5
696	Sopa Nissin Cup Noodles Camaron 64g	Sopa instantanea en vaso Camaron	2	11	10.00	15.00	0	5
697	Sopa Maruchan Vaso Res 64g	Sopa instantanea en vaso Res	2	11	11.00	16.00	0	5
698	Sopa Maruchan Vaso Camaron Limon 64g	Sopa vaso Camaron Chile Limon	2	11	11.00	16.00	0	5
699	Pure de Tomate Del Fuerte 210g	Pure de tomate condimentado	12	58	7.00	10.00	0	5
700	Pure de Tomate La Costena 210g	Pure de tomate condimentado	12	27	7.00	10.00	0	5
701	Sopa Knorr Spaghetti con Queso	Sopa de pasta lista 10 min	2	58	12.00	17.00	0	5
702	Sopa Knorr Coditos con Crema	Sopa de pasta lista 10 min	2	58	12.00	17.00	0	5
703	Knorr Suiza Caldo Pollo 100g	Sazonador en polvo frasco	13	58	18.00	25.00	0	5
704	Knorr Tomate 8 cubos	Sazonador de tomate en cubos	13	58	12.50	18.00	0	5
705	Sal de Uvas Picot 1 sobre	Antiacido efervescente	50	58	4.00	7.00	0	5
706	Alka-Seltzer 2 tabletas	Antiacido y analgesico	50	58	6.00	10.00	0	5
707	Tortillinas Tia Rosa 10 pzas	Tortillas de harina medianas	27	17	18.00	25.00	0	5
708	Tortillinas Tia Rosa 22 pzas	Tortillas de harina paquete familiar	27	17	35.00	48.00	0	5
709	Cuernitos Tia Rosa 2 pzas	Pan de dulce forma cuernito	29	17	16.00	22.00	0	5
710	Banderillas Tia Rosa 4 pzas	Pan dulce tipo hojaldre	29	17	18.00	25.00	0	5
711	Doraditas Tia Rosa 4 pzas	Galletas de hojaldre azucaradas	29	17	18.00	25.00	0	5
712	Pan para Hot Dog Bimbo 8 pzas	Medias noches bimbo 8 pzas	27	17	28.00	38.00	0	5
713	Pan para Hamburguesa Bimbo 8 pzas	Bimbollos con ajonjoli 8 pzas	27	17	32.00	42.00	0	5
714	Tostadas Milpa Real 300g	Tostadas de maiz amarillas	5	17	22.00	30.00	0	5
715	Pan Tostado Bimbo Clasico 210g	Pan de caja tostado crujiente	27	17	25.00	35.00	0	5
716	Pan Tostado Bimbo Doble Fibra	Pan de caja tostado con fibra	27	17	28.00	38.00	0	5
717	Barritas Marinela Zarzamora 67g	Galletas rellenas zarzamora	29	22	12.00	16.00	0	5
718	Napolitano Marinela 70g	Pastelito sabor vainilla y choco	29	22	13.00	18.00	0	5
719	Submarinos Marinela Vainilla 3 pzas	Pastelitos rellenos crema	29	22	13.00	18.00	0	5
720	Submarinos Marinela Fresa 3 pzas	Pastelitos rellenos fresa	29	22	13.00	18.00	0	5
721	Canelitas Marinela 6 pzas	Galletas sabor canela paquete	29	22	11.00	15.00	0	5
722	Polvorones Marinela 6 pzas	Galletas sabor naranja paquete	29	22	11.00	15.00	0	5
723	Yogurt Danup Fresa 220g	Yogurt bebible con fresa	17	58	10.00	15.00	0	5
724	Yogurt Yoplait Fresa Bebible 242g	Yogurt bebible sabor fresa	17	58	10.50	15.00	0	5
725	Yogurt Yoplait Griego Natural 145g	Yogurt estilo griego natural	17	58	14.00	20.00	0	5
726	Yogurt Yoplait Disfruta Fresa 125g	Yogurt con trozos de fruta	17	58	8.50	12.00	0	5
727	Gelatina Dany Fresa 125g	Postre de gelatina sabor fresa	17	58	6.50	9.00	0	5
728	Gelatina Dany Limon 125g	Postre de gelatina sabor limon	17	58	6.50	9.00	0	5
729	Flan Danone vainilla 100g	Postre de flan con caramelo	17	58	9.00	13.00	0	5
730	Yakult 80ml	Producto lacteo fermentado	17	58	7.00	10.00	0	5
731	Jamon Americano de Pavo Kir 250g	Jamon de pavo economico	18	58	25.00	35.00	0	5
732	Jamon de Pavo y Cerdo Fud 290g	Jamon mixto rebanado	18	53	35.00	48.00	0	5
733	Salchicha Hot Dog Fud 500g	Salchicha larga para hot dog	18	53	38.00	52.00	0	5
734	Salchicha de Pavo Kir 500g	Salchicha de pavo economica	18	58	32.00	45.00	0	5
736	Queso Americano Lala 144g	Queso americano rebanado	16	4	25.00	35.00	0	5
737	Chorizo Casero de Cerdo 200g	Chorizo de cerdo en empaque	18	58	18.00	26.00	0	5
738	Tocino Ahumado Kir 200g	Tocino de cerdo ahumado	18	58	35.00	48.00	0	5
739	Pate de Pollo Underwood 100g	Pate de pollo en lata	6	58	18.00	25.00	0	5
740	Alimento Perro Pedigree Adulto Sobre 100g	Comida humeda para perro Res	45	58	11.00	15.00	0	5
741	Alimento Perro Pedigree Cachorro Sobre 100g	Comida humeda para cachorro Pollo	45	58	11.00	15.00	0	5
742	Alimento Gato Whiskas Sobre 85g	Comida humeda para gato Atun	45	58	11.00	15.00	0	5
743	Alimento Gato Whiskas Sobre 85g Res	Comida humeda para gato Res	45	58	11.00	15.00	0	5
744	Ganador Adulto Sobre 100g	Comida humeda para perro Ganador	45	58	10.00	14.00	0	5
745	Dog Chow Adulto Sobre 100g	Comida humeda para perro Dog Chow	45	58	11.00	15.00	0	5
746	Pilas Duracell AA 2 pzas	Pilas alcalinas AA paquete	51	58	38.00	55.00	0	5
747	Pilas Duracell AAA 2 pzas	Pilas alcalinas AAA paquete	51	58	38.00	55.00	0	5
748	Pilas Energizer AA 2 pzas	Pilas alcalinas AA paquete	51	58	35.00	50.00	0	5
749	Pilas Volteck Economicas AA 4 pzas	Pilas de carbon zinc AA	51	58	15.00	25.00	0	5
750	Encendedor Bic Grande 1 pza	Encendedor de gas clasico	51	58	14.00	20.00	0	5
751	Encendedor Bic Mini 1 pza	Encendedor de gas pequeno	51	58	10.00	15.00	0	5
752	Cerillos La Central Clasicos	Caja de cerillos de madera	51	58	1.50	3.00	0	5
753	Cerillos La Central Cocina	Caja de cerillos grande cocina	51	58	8.00	12.00	0	5
754	Veladora Limonera Vaso	Veladora blanca en vaso vidrio	51	58	15.00	22.00	0	5
755	Fibra Scotch-Brite Verde 1 pza	Fibra para lavar platos	34	58	11.00	16.00	0	5
756	Fibra Scotch-Brite Cero Rayas 1 pza	Fibra delicada para teflon	34	58	13.00	18.00	0	5
757	Guantes de Limpieza Medianos	Guantes de latex amarillos	35	58	18.00	28.00	0	5
758	Bolsas para Basura Gde 10 pzas	Bolsas negras resistentes	35	58	22.00	32.00	0	5
759	Servilletas Petalo 100 pzas	Servilletas de papel blancas	43	29	12.00	18.00	0	5
760	Servilletas Regio 100 pzas	Servilletas de papel resistentes	43	29	14.00	20.00	0	5
761	Aluminio Reynolds 7 metros	Papel aluminio para cocina	51	58	18.00	25.00	0	5
762	Plastico Adherente Kleen-Pack 10m	Pelicula plastica para cocina	51	58	15.00	22.00	0	5
763	Vasos Desechables No. 8 20 pzas	Vasos de plastico blancos	51	58	15.00	22.00	0	5
764	Platos Desechables No. 9 20 pzas	Platos de plastico blancos	51	58	18.00	26.00	0	5
765	Tenedores Desechables 25 pzas	Tenedores de plastico blancos	51	58	12.00	18.00	0	5
766	Cafe Legal Soluble 180g	Cafe con azucar soluble	44	58	35.00	48.00	0	5
767	Cafe Oro Soluble 75g	Cafe soluble 100 por ciento puro	44	58	32.00	45.00	0	5
769	Te McCormick Hierbabuena 25 sobres	Te de hierbas natural	44	58	18.00	25.00	0	5
770	Choco Milk Bolsa 160g	Modificador de leche chocolate	44	58	22.00	32.00	0	5
771	Cal-C-Tose Bolsa 160g	Modificador de leche chocolate	44	58	22.00	32.00	0	5
772	Jarabe Hershey Chocolate 589g	Jarabe dulce para postres	11	45	45.00	62.00	0	5
773	Mermelada McCormick Fresa 270g	Mermelada de fruta con trozos	11	58	22.00	30.00	0	5
774	Cajeta Coronado Quemada 370g	Dulce de leche de cabra	11	58	48.00	65.00	0	5
775	Miel Carlota Abeja 250g	Miel de abeja pura	11	19	45.00	60.00	0	5
776	Crema de Cacahuate Aladino 425g	Crema de cacahuate suave	11	58	48.00	65.00	0	5
777	Atun Herdez en Aceite 130g	Atun en hojuelas aceite	6	20	14.50	21.00	0	5
778	Atun Tuny en Agua 140g	Atun en hojuelas agua	6	58	15.00	22.00	0	5
779	Atun Tuny con Verduras 140g	Atun con ensalada de verduras	6	58	13.00	18.00	0	5
780	Sardinas en Tomate Pescador 425g	Sardinas en salsa de tomate	6	58	28.00	38.00	0	5
781	Vinagre Blanco La Costena 520ml	Vinagre de alcohol de cana	1	27	10.00	14.00	0	5
783	Aceite Capullo 840ml	Aceite puro de canola	1	58	42.00	55.00	0	5
784	Aceite Ave 900ml	Aceite vegetal economico	1	58	32.00	42.00	0	5
785	Arroz Verde Valle Precotto 250g	Arroz precocido 5 min	2	58	14.00	20.00	0	5
786	Lentejas Verde Valle 500g	Lentejas secas de primera	2	58	22.00	30.00	0	5
787	Garbanzo Verde Valle 500g	Garbanzo seco de primera	2	58	24.00	32.00	0	5
788	Harina para Hot Cakes Gamesa 850g	Mezcla lista para hot cakes	10	46	32.00	45.00	0	5
789	Jarabe Pronto Maple 250ml	Jarabe sabor maple para hot cakes	11	58	22.00	30.00	0	5
790	Avena Quaker 3 Minutos 400g	Avena en hojuelas instantanea	5	25	24.00	32.00	0	5
791	Gel Ego For Men 500ml	Gel fijador extra firme grande	41	58	32.00	45.00	0	5
792	Toallas Femeninas Saba con Alas 10 pzas	Toallas femeninas flujo regular	41	58	22.00	32.00	0	5
793	Toallas Femeninas Kotex Nocturna 10 pzas	Toallas femeninas flujo abundante	41	58	25.00	35.00	0	5
794	Panales Huggies Etapa 3 10 pzas	Panales desechables medianos	41	58	45.00	65.00	0	5
795	Toallitas Humedas Huggies 80 pzas	Toallitas para bebe	41	58	35.00	50.00	0	5
768	Te McCormick Manzanilla 25 sobres	Te de hierbas natural	44	58	18.00	25.00	0	5
782	Vinagre de Manzana La Costena 520ml	Vinagre de sidra de manzana	1	27	12.00	17.00	0	5
796	Alcohol Etilico Jaloma 445ml	Alcohol para curaciones	50	58	22.00	32.00	0	5
797	Agua Oxigenada Jaloma 225ml	Auxiliar en curaciones	50	58	12.00	18.00	0	5
798	Algodon Jaloma 50g	Algodon plisado puro	50	58	12.00	18.00	0	5
799	Curitas Clasicas 10 pzas	Vendas adhesivas sanitarias	50	58	12.00	18.00	0	5
800	Jugo Boing Guayaba 250ml	Bebida de fruta de carton	31	58	7.50	10.00	0	5
803	Jugo Boing Uva 250ml	Bebida de fruta de carton	31	58	7.50	10.00	0	5
804	Jugo Boing Fresa 250ml	Bebida de fruta de carton	31	58	7.50	10.00	0	5
806	Jugo Boing Guayaba 500ml	Bebida de fruta en vidrio/carton	31	58	12.00	16.00	0	5
808	Jugo Boing Guayaba 1L	Bebida de fruta 1 Litro	31	58	19.00	25.00	0	5
809	Jumex Unico Fresco Naranja 1L	Jugo 100 por ciento sin azucar	31	21	26.00	35.00	0	5
810	Jumex Unico Fresco Verde 1L	Jugo de frutas y verduras	31	21	28.00	38.00	0	5
811	Jumex Fresh Citricos 600ml	Bebida refrescante de limon	31	21	11.00	15.00	0	5
812	Jumex Fresh Congo 600ml	Bebida de frutas tropicales	31	21	11.00	15.00	0	5
813	Pau Pau Fresa 250ml	Bebida infantil con vitaminas	31	21	5.50	8.00	0	5
815	Pau Pau Uva 250ml	Bebida infantil con vitaminas	31	21	5.50	8.00	0	5
816	Arizon Tea Ginseng 680ml	Te helado en lata grande	31	58	18.00	25.00	0	5
817	Arizon Tea Sandia 680ml	Bebida sabor sandia lata	31	58	18.00	25.00	0	5
818	V8 Jugo de Verduras 340ml	Jugo de vegetales en lata	31	58	16.00	22.00	0	5
819	BeLight Jamaica 1.5L	Bebida sin calorias jamaica	31	16	13.00	18.00	0	5
820	BeLight Limon 1.5L	Bebida sin calorias limon	31	16	13.00	18.00	0	5
821	Gatorade Ponche de Frutas 600ml	Bebida para deportistas	31	14	21.00	28.00	0	5
822	Gatorade Lima Limon 600ml	Bebida para deportistas	31	14	21.00	28.00	0	5
823	Gatorade Uva 600ml	Bebida para deportistas	31	14	21.00	28.00	0	5
824	Electrolit Coco 625ml	Suero rehidratante grado medico	31	58	22.00	30.00	0	5
825	Electrolit Fresa 625ml	Suero rehidratante grado medico	31	58	22.00	30.00	0	5
826	Electrolit Uva 625ml	Suero rehidratante grado medico	31	58	22.00	30.00	0	5
827	Choco Milk Lata 400g	Modificador de leche chocolate	44	58	55.00	75.00	0	5
828	Nesquik Fresa Polso 200g	Saborizante para leche fresa	44	19	24.00	32.00	0	5
829	Galletas Arcoiris Gamesa 6 pzas	Galleta con malvavisco y coco	9	46	12.00	17.00	0	5
830	Galletas Mamut Gigante 1 pza	Galleta con malvavisco grande	9	46	8.50	12.00	0	5
831	Galletas Vualá de Chocolate 60g	Pastelito relleno de chocolate	29	58	11.00	15.00	0	5
832	Galletas Vualá de Cajeta 60g	Pastelito relleno de cajeta	29	58	11.00	15.00	0	5
833	Galletas Emperador Combinado Tubo	Galletas chocolate y vainilla	9	46	13.50	19.00	0	5
834	Galletas Choquix Chocolate Tubo	Galletas con chispas Gamesa	9	46	13.50	19.00	0	5
835	Galletas Surtido Rico Gamesa 400g	Caja de galletas variadas	9	46	42.00	58.00	0	5
836	Obleas con Cajeta Las Sevillanas	Dulce de leche con oblea	8	58	12.00	18.00	0	5
837	Glorias de Linares 1 pza	Dulce de leche quemada con nuez	8	58	9.00	13.00	0	5
838	Bombones De La Rosa 100g	Nubes de malvavisco blancas	8	62	13.00	18.00	0	5
839	Gomitas Extreme Sour 50g	Gomitas acidas de colores	8	58	11.00	15.00	0	5
840	Cuaderno Scribe Profesional Raya	Libreta de 100 hojas raya	52	58	22.00	30.00	0	5
841	Cuaderno Scribe Profesional Cuadro	Libreta de 100 hojas cuadro	52	58	22.00	30.00	0	5
842	Lapiz Bic Evolution No. 2	Lapiz de grafito resistente	52	58	4.00	7.00	0	5
843	Pluma Bic Cristal Negra	Boligrafo tinta negra clasico	52	58	5.00	8.00	0	5
844	Pluma Bic Cristal Azul	Boligrafo tinta azul clasico	52	58	5.00	8.00	0	5
845	Pluma Bic Cristal Roja	Boligrafo tinta roja clasico	52	58	5.00	8.00	0	5
846	Goma Pelikan WS30	Goma de borrar migajon	52	58	4.00	7.00	0	5
847	Sacapuntas de Metal	Sacapuntas sencillo metalico	52	58	3.00	6.00	0	5
848	Pegamento Stick Pritt 10g	Pegamento en barra	52	58	15.00	22.00	0	5
849	Cinta Canela 40m	Cinta adhesiva de empaque	52	58	18.00	28.00	0	5
850	Cinta Transparente 40m	Cinta adhesiva transparente	52	58	18.00	28.00	0	5
851	Marcador para Pizarron Negro	Marcador magistral borrable	52	58	18.00	25.00	0	5
853	Corrector Liquido Tipo Pluma	Corrector de precision	52	58	18.00	25.00	0	5
854	Hojas Blancas paq. 50 pzas	Hojas de papel bond tamano carta	52	58	15.00	25.00	0	5
855	Cartulina Blanca 1 pza	Pliego de cartulina estandar	52	58	4.00	7.00	0	5
856	Papel China de Colores 1 pza	Papel seda varios colores	52	58	1.50	3.00	0	5
857	Sobre Amarillo Carta 1 pza	Sobre de papel manila	52	58	2.50	5.00	0	5
859	Foco LED 9W Luz Blanca	Lampara ahorradora base E27	51	58	25.00	40.00	0	5
860	Foco LED 12W Luz Blanca	Lampara ahorradora potente	51	58	32.00	50.00	0	5
861	Extension Electrica 3m	Cable extension uso domestico	51	58	45.00	65.00	0	5
862	Multicontacto 3 entradas	Adaptador triple de corriente	51	58	15.00	25.00	0	5
863	Cinta de Aislar Negra	Cinta para cables electricos	51	58	12.00	20.00	0	5
864	Pila 9V Alcalina 1 pza	Batería cuadrada para equipos	51	58	65.00	85.00	0	5
802	Jugo Boing Manzana 250ml	Bebida de fruta de carton	31	58	7.50	10.00	0	5
805	Jugo Boing Mango 500ml	Bebida de fruta en vidrio/carton	31	58	12.00	16.00	0	5
807	Jugo Boing Mango 1L	Bebida de fruta 1 Litro	31	58	19.00	25.00	0	5
852	Marcador Permanente Sharpie Negro	Marcador de tinta indeleble	52	58	22.00	30.00	0	5
858	Folder Tamano Carta Crema	Folder de cartulina sencillo	52	58	2.50	5.00	0	5
865	Linterna de Mano Basica	Lampara de plastico recargable	51	58	45.00	75.00	0	5
866	Candado de Hierro 30mm	Candado con dos llaves	51	58	35.00	55.00	0	5
867	Pegamento Instantaneo 2g	Pegamento de contacto fuerte	52	58	10.00	18.00	0	5
868	Pegamento Blanco 125g	Resistol escolar blanco	52	58	15.00	22.00	0	5
869	Tafil No. 2 Clavos paq.	Clavos de acero para concreto	51	58	12.00	20.00	0	5
870	Martillo de Una 1 pza	Herramienta basica de carpinteria	51	58	65.00	95.00	0	5
871	Desarmador de Cruz y Plano	Herramienta doble punta	51	58	25.00	45.00	0	5
872	Aspirina 500mg 10 tabletas	Analgesico acido acetilsalicilico	50	58	22.00	35.00	0	5
873	Tabcin Noche 12 capsulas	Auxiliar en sintomas de gripe	50	58	45.00	65.00	0	5
874	Tabcin Dia 12 capsulas	Auxiliar en sintomas de gripe	50	58	45.00	65.00	0	5
875	Tempra Adulto 500mg 10 tabs	Analgesico paracetamol	50	58	25.00	40.00	0	5
876	Tempra Infantil Jarabe 120ml	Paracetamol infantil	50	58	55.00	75.00	0	5
877	Flanax 550mg 12 tabletas	Antiinflamatorio y analgesico	50	58	65.00	95.00	0	5
878	Vick VapoRub 50g	Unguento para congestion nasal	50	58	48.00	68.00	0	5
879	Vick Vaporub 12g	Unguento pequeno presentacion sobre	50	58	12.00	20.00	0	5
882	Tums Surtido de Frutas 12 tabs	Antiacido masticable	50	58	25.00	38.00	0	5
883	XL-3 Gripa 12 tabletas	Auxiliar en resfriado comun	50	58	32.00	48.00	0	5
884	Metamucil Polvo Naranja 10 sobres	Suplemento de fibra natural	50	58	55.00	75.00	0	5
885	Condones Sico Original 3 pzas	Metodo anticonceptivo	50	58	38.00	55.00	0	5
886	Condones Trojan 3 pzas	Metodo anticonceptivo	50	58	42.00	60.00	0	5
887	Prueba de Embarazo Casera	Dispositivo de diagnostico	50	58	45.00	75.00	0	5
888	Gel Antibacterial 250ml	Desinfectante de manos alcohol	50	58	18.00	28.00	0	5
889	Cubrebocas Azul 10 pzas	Mascarilla protectora desechable	50	58	10.00	20.00	0	5
890	Algodon Absorbente 100g	Paquete de algodon de primera	50	58	18.00	28.00	0	5
891	Gasa Esteril 10x10cm	Compresa de gasa individual	50	58	4.00	8.00	0	5
892	Micropore Cinta Medica	Cinta adhesiva para curacion	50	58	15.00	25.00	0	5
893	Pomada de la Campana 35g	Crema protectora para la piel	41	58	22.00	32.00	0	5
894	Vaselina Pura 60g	Unguento humectante de vaselina	41	58	22.00	32.00	0	5
895	Crema Nivea Tarro Azul 60ml	Crema humectante clasica	41	58	28.00	42.00	0	5
896	Crema Lubriderm Tapa Azul 120ml	Crema humectante diaria	41	58	45.00	65.00	0	5
897	Talco para Pies Mexsana 80g	Talco desodorante para pies	41	58	35.00	50.00	0	5
898	Toallitas Desmaquillantes Pond's	Toallitas limpiadoras faciales	41	58	35.00	55.00	0	5
899	Sazonador Pimienta Negra 50g	Pimienta negra molida McCormick	13	72	18.00	25.00	0	5
900	Ajo en Polvo McCormick 50g	Sazonador ajo puro molido	13	72	18.00	25.00	0	5
901	Canela Entera 20g	Rajas de canela natural	13	58	12.00	18.00	0	5
902	Canela Molida 50g	Canela en polvo para postres	13	58	15.00	22.00	0	5
903	Vainilla Molina 250ml	Extracto de vainilla liquido	13	58	18.00	26.00	0	5
904	Polvo para Hornear Royal 100g	Levadura quimica para pan	10	58	18.00	25.00	0	5
905	Grenetina en Polvo 4 sobres	Grenetina natural sin sabor	10	58	15.00	22.00	0	5
906	Colorante Vegetal Rojo	Colorante para alimentos liquido	10	58	10.00	15.00	0	5
907	Chile Guajillo Bolsa 50g	Chile seco seleccionado	13	58	15.00	22.00	0	5
908	Chile Ancho Bolsa 50g	Chile seco seleccionado	13	58	18.00	25.00	0	5
909	Chile de Arbol Bolsa 50g	Chile seco muy picante	13	58	15.00	22.00	0	5
910	Oregano Seco Bolsa 20g	Hierba de olor para cocina	13	58	8.00	12.00	0	5
911	Comino Molido Bolsa 50g	Especias para sazonar	13	58	12.00	18.00	0	5
912	Laurel Hojas Bolsa 20g	Hierba de olor para guisos	13	58	8.00	12.00	0	5
913	Bicarbonato de Sodio 100g	Uso domestico y culinario	13	58	10.00	15.00	0	5
914	Miel de Agave 250ml	Endulzante natural de agave	11	58	45.00	65.00	0	5
915	Splenda 50 sobres	Endulzante sin calorias	3	58	35.00	48.00	0	5
916	Stevia 50 sobres	Endulzante natural sin calorias	3	58	38.00	52.00	0	5
917	Sopa de Letras La Moderna 200g	Pasta de sémola de trigo	2	44	7.50	11.00	0	5
918	Sopa de Estrellas La Moderna 200g	Pasta de sémola de trigo	2	44	7.50	11.00	0	5
919	Sopa de Municion La Moderna 200g	Pasta de sémola de trigo	2	44	7.50	11.00	0	5
920	Macarrones La Moderna 200g	Pasta de sémola de trigo	2	44	7.50	11.00	0	5
921	Aceitunas con Hueso La Costena	Aceitunas verdes en frasco	6	27	18.00	26.00	0	5
922	Aceitunas Rellenas La Costena	Aceitunas con pimiento	6	27	22.00	30.00	0	5
923	Alcaparras en Salmuera 100g	Botella de alcaparras	6	58	25.00	35.00	0	5
924	Pimiento Morron en Lata	Pimiento rojo en tiras	6	58	22.00	30.00	0	5
925	Mole Poblano Doña Maria 235g	Pasta para mole en vaso	12	20	32.00	45.00	0	5
926	Mole Verde Doña Maria 235g	Pasta para mole verde en vaso	12	20	35.00	48.00	0	5
927	Salsa para Pasta Prego Tradicional	Salsa de tomate para spaghetti	12	58	35.00	48.00	0	5
928	Salsa para Pasta Prego Champiñones	Salsa de tomate con hongos	12	58	38.00	52.00	0	5
929	Pechuga de Pavo Zwan 250g	Embutido de pavo premium	18	58	45.00	60.00	0	5
930	Jamon Serrano Paquete 100g	Jamon curado rebanado	18	58	65.00	95.00	0	5
931	Salchicha de Pavo Oscar Mayer	Salchichas de pavo calidad	18	58	38.00	55.00	0	5
932	Chorizo de Bilbao 200g	Chorizo tipo español	18	58	45.00	65.00	0	5
933	Queso Gouda Rebanado Nochebuena	Queso tipo gouda paquete	16	58	48.00	65.00	0	5
935	Queso Oaxaca La Villita 200g	Queso de hebra para fundir	16	58	42.00	58.00	0	5
881	Pepto-Bismol 12 tabletas	Auxiliar en malestar estomacal	50	58	42.00	58.00	0	5
934	Queso Manchego Rebanado Nochebuena	Queso tipo manchego paquete	16	58	48.00	65.00	0	5
936	Queso Cotija en Polvo 100g	Queso seco rallado	16	58	22.00	30.00	0	5
937	Yogurt Vitalímea Fresa 220g	Yogurt bajo en calorias	17	58	12.00	17.00	0	5
938	Yogurt Vitalímea Natural 220g	Yogurt bajo en calorias	17	58	12.00	17.00	0	5
941	Limonada Peñafiel 600ml	Bebida mineral con limon	31	58	13.00	18.00	0	5
942	Naranjada Peñafiel 600ml	Bebida mineral con naranja	31	58	13.00	18.00	0	5
943	Agua Mineral Perrier 330ml	Agua mineral de manantial francesa	31	19	22.00	35.00	0	5
944	Agua Mineral San Pellegrino 330ml	Agua mineral italiana lata	31	19	22.00	35.00	0	5
945	Vino Tinto Las Moras 750ml	Vino de mesa Malbec	33	58	110.00	165.00	0	5
946	Vino Blanco Concha y Toro 750ml	Vino de mesa Sauvignon	33	58	95.00	145.00	0	5
947	Whisky Johnnie Walker Red Label 700ml	Whisky escoces mezclado	33	58	320.00	450.00	0	5
948	Tequila Jose Cuervo Especial 990ml	Tequila joven reposado	33	58	280.00	395.00	0	5
949	Mezcal 400 Conejos 750ml	Mezcal artesanal joven	33	58	420.00	580.00	0	5
950	Cerveza Corona Extra 355ml	Cerveza clara botella	32	58	18.00	24.00	0	5
951	Cerveza Victoria 355ml	Cerveza tipo lager oscura	32	58	18.00	24.00	0	5
952	Cerveza Modelo Especial Lata 355ml	Cerveza clara en lata	32	58	19.00	26.00	0	5
953	Cerveza Michelob Ultra 355ml	Cerveza baja en calorias	32	58	21.00	28.00	0	5
954	Cerveza Heineken 355ml	Cerveza clara premium	32	58	22.00	30.00	0	5
955	Cerveza Dos Equis Lager 355ml	Cerveza clara suave	32	58	19.00	26.00	0	5
956	Clamato Original 473ml	Jugo de tomate con almeja	31	58	22.00	32.00	0	5
957	Hielo en Cubos Bolsa 5kg	Hielo purificado para bebidas	30	58	22.00	35.00	0	5
958	Vasos Rojos Fiesteros 20 pzas	Vasos de plastico grandes rojos	51	58	28.00	42.00	0	5
959	Carbon de Leña Bolsa 3kg	Carbon vegetal para asados	51	58	45.00	65.00	0	5
960	Encendedor de Antorcha Cocina	Encendedor largo para estufa	51	58	28.00	45.00	0	5
961	Pastillas de Encendido 12 pzas	Auxiliar para prender carbon	51	58	15.00	25.00	0	5
962	Insecticida Raid Casa y Jardin	Spray contra insectos voladores	35	58	55.00	78.00	0	5
963	Insecticida Baygon Rastreros	Spray contra cucarachas y hormigas	35	58	55.00	78.00	0	5
964	Laminas Raid Repuesto 12 pzas	Laminas para aparato electrico	35	58	28.00	42.00	0	5
965	Aparato Raid Electrico Liquido	Repelente de mosquitos electrico	35	58	55.00	85.00	0	5
966	Windex Limpiador Vidrios 500ml	Liquido para limpiar cristales	35	58	32.00	45.00	0	5
967	Easy-Off Limpiador de Hornos	Quita grasa para estufas	35	58	55.00	85.00	0	5
968	Harpic Baños Destapa Caños	Liquido para tuberias obstruidas	35	58	45.00	68.00	0	5
969	Pledge Lustrador de Muebles	Spray para madera y superficies	35	58	55.00	78.00	0	5
970	Glade Aerosol Lavanda 400ml	Aromatizante de ambiente	35	58	28.00	42.00	0	5
971	Air Wick Repuesto Electrico	Aromatizante continuo	35	58	55.00	85.00	0	5
972	Veladora de Vaso Imagen	Veladora con imagen religiosa	51	58	18.00	28.00	0	5
973	Incienso de Varilla paq. 10 pzas	Varillas aromaticas surtidas	51	58	12.00	20.00	0	5
974	Comida para Perro Dog Chow 2kg	Croquetas adulto perro mediano	45	58	145.00	195.00	0	5
975	Comida para Gato Whiskas 1.5kg	Croquetas sabor carne y leche	45	58	120.00	175.00	0	5
976	Arena para Gato Scoop Away 3kg	Arena aglutinante para desechos	45	58	85.00	125.00	0	5
977	Hueso de Carnaza para Perro Gde	Juguete masticable para perro	45	58	22.00	35.00	0	5
978	Shampoo para Perros Grisi 400ml	Shampoo antipulgas con avena	45	58	55.00	85.00	0	5
979	Escoba de Mijo Clasica	Escoba de fibras naturales	35	58	45.00	65.00	0	5
980	Trapeador de Algodon Blanco	Mopa de hilos de algodon	35	58	35.00	55.00	0	5
981	Cubeta de Plastico 10L	Cubeta reforzada varios colores	35	58	35.00	55.00	0	5
983	Gancho para Ropa Plastico 6 pzas	Ganchos negros o blancos	51	58	25.00	40.00	0	5
984	Pinzas para Ropa Madera 12 pzas	Tendedero de madera clasico	51	58	15.00	25.00	0	5
985	Bolsas para Basura Chicas 20 pzas	Bolsas para baño cocina	35	58	18.00	28.00	0	5
986	Fibras de Acero Inox 2 pzas	Fibra metalica para ollas	34	58	12.00	20.00	0	5
987	Guantes de Latex Negros Uso Rudo	Guantes de limpieza fuertes	35	58	25.00	42.00	0	5
988	Mascarilla para Cabello Pantene	Tratamiento intensivo capilar	35	35	12.00	20.00	0	5
989	Cepillo Dental Oral-B Indicator	Cepillo dental cerdas medias	38	30	18.00	28.00	0	5
990	Enjuague Bucal Listerine 250ml	Antiseptico bucal original	38	30	38.00	55.00	0	5
991	Hilo Dental Oral-B 25m	Limpieza interdental	38	30	28.00	42.00	0	5
992	Corega Crema Adhesiva 40g	Adhesivo para dentaduras	38	30	85.00	125.00	0	5
993	Pastillas Efervescentes Corega	Limpieza de dentaduras	38	30	45.00	65.00	0	5
994	Desodorante Gillette Gel 82g	Antitranspirante masculino gel	41	58	55.00	78.00	0	5
995	Crema de Afeitar Gillette 200g	Espuma para afeitado suave	41	58	45.00	68.00	0	5
996	Locion After Shave Gillette	Locion para despues de afeitar	41	58	65.00	95.00	0	5
997	Cera para Cabello Axe 50g	Cera moldeadora mate	41	58	55.00	85.00	0	5
998	Esmalte de Uñas Bissú	Barniz de uñas varios colores	41	58	12.00	20.00	0	5
999	Acetona Pura 120ml	Removedor de esmalte de uñas	41	58	18.00	28.00	0	5
1000	Pañales Huggies UltraConfort E4 40pza	Pañales para etapa 4 niño/niña	44	29	210.00	285.00	0	5
1001	Pañales Huggies UltraConfort E5 40pza	Pañales para etapa 5 niño/niña	44	29	225.00	305.00	0	5
1002	Pañales KleenBebé Suavelastic G 38pza	Pañales etapa grande	44	29	185.00	250.00	0	5
1003	Toallitas KleenBebé Absorsec 80pza	Toallitas humedas para bebe	44	29	28.00	42.00	0	5
939	Chambourcy Manzana 100g	Postre de manzana cocida	17	19	9.00	13.00	0	5
1004	Biberón Evenflo 8oz	Biberon de plastico decorado	44	58	35.00	55.00	0	5
1005	Chupón Entrenador Nuk	Chupon de silicona etapa 1	44	58	45.00	70.00	0	5
1006	Aceite para Bebé Mennen 200ml	Aceite humectante suavidad	44	58	42.00	60.00	0	5
1007	Talco para Bebé Mennen 200g	Talco proteccion y frescura	44	58	38.00	55.00	0	5
1008	Jabón Ricitos de Oro 90g	Jabon de tocador manzanilla	44	58	14.00	22.00	0	5
1009	Shampoo Ricitos de Oro 250ml	Shampoo de manzanilla no lagrimas	44	58	45.00	65.00	0	5
1010	Papel Higiénico Regio Luxury 4 rollos	Papel higienico hoja doble	36	29	28.00	42.00	0	5
1011	Papel Higiénico Cottonelle Soft 4 rollos	Papel higienico premium	36	29	32.00	48.00	0	5
1012	Papel Higiénico Pétalo 12 rollos	Paquete economico de papel	36	29	65.00	95.00	0	5
1013	Papel Higiénico Suavel 4 rollos	Papel higienico economico	36	29	18.00	28.00	0	5
1014	Servitoalla Pétalo 1 rollo	Toalla de papel para cocina	36	29	14.00	22.00	0	5
1015	Pañuelos Kleenex Caja 90pza	Pañuelos desechables suaves	36	29	22.00	35.00	0	5
1016	Pañuelos Kleenex Pocket 1pza	Paquete individual de bolsillo	36	29	5.00	8.00	0	5
1017	Velas para Pastel de Colores	Velas de cera para cumpleaños	45	58	8.00	15.00	0	5
1018	Globos del No. 9 20pza	Globos de latex colores surtidos	45	58	22.00	38.00	0	5
1019	Confeti Bolsa 100g	Papel picado de colores	45	58	10.00	18.00	0	5
1020	Gorro de Fiesta 10pza	Gorros de carton para fiesta	45	58	25.00	45.00	0	5
1021	Serpentina Paquete 10pza	Tiras de papel para festejo	45	58	15.00	28.00	0	5
1022	Desechable Charola Térmica No. 66	Charola de unicel para comida	45	58	28.00	45.00	0	5
1023	Desechable Vaso Térmico No. 8 20pza	Vasos de unicel para bebidas calientes	45	58	18.00	32.00	0	5
1024	Piñata de Estrella Mediana	Piñata tradicional de carton	45	58	85.00	135.00	0	5
1025	Palo para Piñata Decorado	Madera forrada de colores	45	58	12.00	25.00	0	5
1026	Cereal Zucaritas Kelloggs 710g	Cereal de maiz escarchado	5	26	65.00	88.00	0	5
1027	Cereal Choco Krispis 620g	Arroz inflado sabor chocolate	5	26	68.00	92.00	0	5
1028	Cereal Froot Loops 410g	Aros de maiz sabor frutas	5	26	55.00	78.00	0	5
1029	Cereal Corn Flakes 500g	Hojuelas de maiz naturales	5	26	48.00	65.00	0	5
1030	Cereal Nesquik 330g	Cereal de trigo sabor chocolate	5	19	45.00	62.00	0	5
1031	Cereal Cheerios Miel 480g	Aros de avena y miel	5	19	58.00	78.00	0	5
1032	Cereal Fitness Original 375g	Hojuelas de trigo integral	5	19	55.00	75.00	0	5
1033	Cereal Special K Original 400g	Cereal de trigo y arroz	5	26	62.00	85.00	0	5
1034	Barra Nature Valley Avena 42g	Barra de granola y miel	5	58	11.00	16.00	0	5
1035	Barra Bran Frut Fresa 48g	Barra de trigo rellena	5	17	10.00	15.00	0	5
1036	Avena Quaker Instantánea 10 sobres	Avena de sabores en sobre	5	25	42.00	58.00	0	5
1037	Canela en Raja 50g	Raja de canela seleccionada	13	58	22.00	35.00	0	5
1038	Clavo de Olor 20g	Especias para cocina	13	58	15.00	25.00	0	5
1039	Pimienta Gorda 50g	Pimienta entera McCormick	13	58	18.00	28.00	0	5
1040	Comino Entero 50g	Semillas de comino natural	13	58	12.00	22.00	0	5
1041	Tomillo Seco 20g	Hierba de olor para guisos	13	58	10.00	18.00	0	5
1042	Mejorana Seca 20g	Hierba de olor para cocina	13	58	10.00	18.00	0	5
1043	Sazonador para Pollo 100g	Mezcla de especias para aves	13	58	18.00	28.00	0	5
1044	Sazonador Ablandador de Carne	Sal con papaína para carnes	13	58	22.00	32.00	0	5
1045	Sal con Ajo McCormick 100g	Sal de mesa condimentada	13	58	18.00	28.00	0	5
1046	Sal con Cebolla McCormick 100g	Sal de mesa condimentada	13	58	18.00	28.00	0	5
1047	Chile Piquín en Polvo 100g	Chile seco molido picante	13	58	15.00	25.00	0	5
1048	Nuez Moscada Molida 20g	Especias para repostería	13	58	18.00	28.00	0	5
1049	Anís Estrella 20g	Para infusiones y repostería	13	58	25.00	40.00	0	5
1050	Mostaza McCormick 210g	Mostaza amarilla clasica	12	20	14.00	21.00	0	5
1051	Mayonesa McCormick con Limón 190g	Mayonesa en frasco vidrio	12	20	22.00	32.00	0	5
1052	Mayonesa McCormick con Limón 390g	Mayonesa en frasco vidrio mediana	12	20	45.00	62.00	0	5
1054	Catsup Del Monte 320g	Salsa de tomate catsup doy pack	12	70	15.00	22.00	0	5
1055	Catsup Heinz 397g	Salsa de tomate catsup botella	12	71	25.00	35.00	0	5
1056	Salsa BBQ Hunts 620g	Salsa para alitas o costillas	12	58	48.00	65.00	0	5
1057	Salsa para Pizza Ragú 400g	Salsa de tomate condimentada	12	58	35.00	48.00	0	5
1058	Salsa Macha con Arándano 200g	Salsa artesanal aceite y chile	12	58	45.00	65.00	0	5
1059	Salsa Casera La Morena 210g	Salsa roja picante	12	72	13.00	18.00	0	5
1060	Pasta para Sopa La Moderna Codo 0	Pasta de trigo pequeña	2	44	7.50	11.00	0	5
1061	Pasta para Sopa La Moderna Fideo 0	Pasta de trigo para sopa	2	44	7.50	11.00	0	5
1062	Pasta Spaghetti La Moderna 200g	Pasta larga de sémola	2	44	8.50	12.00	0	5
1063	Pasta Fetuccini Barilla 500g	Pasta italiana premium	2	56	25.00	35.00	0	5
1064	Pasta Penne Rigate Barilla 500g	Pasta corta tipo pluma	2	56	25.00	35.00	0	5
1065	Lenteja Canada Bolsa 500g	Legumbre seca seleccionada	2	58	22.00	30.00	0	5
1066	Frijol Negro Querétaro 1kg	Frijol seco de primera calidad	2	58	35.00	48.00	0	5
1067	Frijol Flor de Mayo 1kg	Frijol seco suave	2	58	38.00	52.00	0	5
1068	Frijol Bayo 1kg	Frijol seco tradicional	2	58	34.00	45.00	0	5
1069	Haba Entera Pelada 500g	Legumbre seca para sopa	2	58	28.00	42.00	0	5
1070	Garbanzo Extra 500g	Legumbre seca grande	2	58	24.00	35.00	0	5
1071	Maíz Palomero 500g	Maiz para palomitas granel	2	58	15.00	25.00	0	5
1072	Arroz Integral Verde Valle 900g	Arroz con fibra natural	2	58	32.00	45.00	0	5
1073	Aceite de Oliva Extra Virgen 250ml	Aceite de primera prensada	1	58	65.00	95.00	0	5
1074	Aceite en Aerosol PAM 170g	Aceite vegetal para cocinar	1	58	55.00	78.00	0	5
1075	Vinagre Tinto La Costeña 530ml	Vinagre para ensaladas	1	27	14.00	22.00	0	5
1077	Harina de Trigo San Antonio 1kg	Harina de trigo refinada	3	41	18.00	26.00	0	5
1078	Harina de Maíz Maseca 1kg	Harina para tortillas de maiz	3	59	19.00	27.00	0	5
1079	Harina para Hot Cakes Pronto 800g	Mezcla lista para panquecas	10	58	28.00	40.00	0	5
1080	Azúcar Estándar 1kg	Azucar morena de caña	3	58	26.00	35.00	0	5
1081	Azúcar Refinada 1kg	Azucar blanca pura	3	58	32.00	42.00	0	5
1082	Azúcar Glass 500g	Azucar pulverizada para reposteria	3	58	18.00	28.00	0	5
1083	Piloncillo Cono 225g	Dulce de caña natural	3	58	12.00	18.00	0	5
1084	Jarabe de Maíz Karo Bebé 250ml	Miel de maiz natural	11	58	35.00	50.00	0	5
1085	Miel de Maple Aunt Jemima 710ml	Jarabe sabor maple original	11	58	65.00	95.00	0	5
1086	Té Negro Lipton 20 sobres	Te negro clasico	4	58	22.00	32.00	0	5
1087	Té Verde Twinings 20 sobres	Te verde calidad premium	4	58	45.00	65.00	0	5
1088	Té de Limón McCormick 25 sobres	Te de hierbas natural	4	58	18.00	25.00	0	5
1089	Chocolate Abuelita 6 tablillas	Chocolate para mesa tradicional	4	19	68.00	92.00	0	5
1090	Chocolate Ibarra 540g	Chocolate para mesa con canela	4	58	62.00	85.00	0	5
1091	Cocoa Hershey's en Polvo 200g	Cocoa pura sin azucar	4	45	48.00	68.00	0	5
1092	Café Nescafé Clásico 200g	Cafe soluble instantaneo	4	19	85.00	115.00	0	5
1093	Café Nescafé Dolca 170g	Cafe soluble con caramelo	4	19	75.00	105.00	0	5
1094	Café Nescafé Decaf 170g	Cafe soluble descafeinado	4	19	90.00	125.00	0	5
1095	Café Tostado y Molido Legal 400g	Cafe para cafetera mezcla	4	58	65.00	88.00	0	5
1096	Sustituto de Crema Coffee Mate 400g	Crema en polvo para cafe	4	19	52.00	75.00	0	5
1099	Media Crema Nestlé 190g	Crema de leche en cajita	15	19	14.00	20.00	0	5
1106	Bebida de Almendra Silk 946ml	Alimento liquido vegetal	15	58	38.00	55.00	0	5
1107	Bebida de Soya Ades Natural 1L	Alimento liquido de soya	15	58	28.00	42.00	0	5
1110	Huevo Blanco Paquete 12pza	Docena de huevos frescos	14	58	32.00	45.00	0	5
1111	Huevo Rojo Paquete 12pza	Docena de huevos frescos rojos	14	58	35.00	48.00	0	5
1112	Queso Philadelphia Original 190g	Queso crema tradicional	16	58	35.00	48.00	0	5
1113	Queso Panela La Villita 400g	Queso fresco bajo en grasa	16	58	55.00	78.00	0	5
1114	Crema Ácida Alpura 450ml	Crema de leche de vaca	17	18	28.00	40.00	0	5
1115	Yogurt Danone Fresa 900g	Yogurt familiar batido	17	55	32.00	45.00	0	5
1116	Chorizo de Pavo Fud 200g	Chorizo ligero empacado	18	53	22.00	32.00	0	5
1117	Tocino Ahumado Fud 250g	Tocino de cerdo calidad	18	53	45.00	65.00	0	5
1118	Papas Sabritas Original 160g	Papas fritas bolsa familiar	9	3	42.00	58.00	0	5
1119	Doritos Nacho 146g	Botana de maiz sabor queso	9	3	38.00	52.00	0	5
1120	Cheetos Torciditos 145g	Botana de maiz con queso	9	3	32.00	45.00	0	5
1121	Ruffles Original 160g	Papas fritas onduladas	9	3	42.00	58.00	0	5
1122	Tostitos Flamin Hot 200g	Botana picante de maiz	9	3	45.00	62.00	0	5
1123	Cacahuates Japoneses Karate 154g	Cacahuates con cobertura crujiente	9	3	18.00	26.00	0	5
1124	Cacahuates Salados Sabritas 180g	Cacahuates con sal familiar	9	3	35.00	48.00	0	5
1125	Takis Fuego 190g	Botana de maiz enrollada extra picante	9	47	38.00	52.00	0	5
1126	Chips Fuego 170g	Papas fritas picantes Barcel	9	47	45.00	62.00	0	5
1127	Pop Karameladas Barcel 120g	Palomitas con caramelo bolsa	9	47	32.00	45.00	0	5
1129	Pistaches con Sal 100g	Frutos secos calidad bolsa	9	58	45.00	68.00	0	5
1130	Nuez de la India 100g	Frutos secos premium bolsa	9	58	55.00	85.00	0	5
1131	Galletas María Gamesa 3 rollos	Paquete familiar galletas maria	29	46	38.00	52.00	0	5
1132	Galletas Chokis Clasicas 190g	Galletas con chispas chocolate	29	46	22.00	32.00	0	5
1133	Galletas Emperador Chocolate 273g	Galletas sandwich paquete mediano	29	46	28.00	40.00	0	5
1134	Galletas Oreo Clasicas 273g	Galletas sandwich rellenas crema	9	58	32.00	45.00	0	5
1135	Galletas Ritz Original 177g	Galletas saladas crujientes	9	58	18.00	28.00	0	5
1136	Galletas Saladitas Gamesa 186g	Galletas saladas horneadas	9	46	18.00	28.00	0	5
1137	Pan de Caja Bimbo Blanco Grande	Pan de molde clasico 680g	27	17	42.00	55.00	0	5
1138	Pan de Caja Bimbo Integral Gde	Pan de molde con fibra 620g	27	17	48.00	62.00	0	5
1139	Pan de Caja Oroweat Multigrano	Pan de molde premium	27	17	65.00	85.00	0	5
1141	Pan Dulce Nito Bimbo 1pza	Pan relleno de chocolate	29	17	13.00	18.00	0	5
1097	Leche Evaporada Carnation 360g	Leche concentrada en lata	15	19	19.00	26.00	0	5
1098	Leche Condensada La Lechera 100g	Leche dulce en lata	15	19	13.00	16.00	0	5
1100	Leche en Polvo Nido Fortificada 800g	Leche en polvo para niños	15	19	135.00	185.00	0	5
1101	Leche en Polvo Alpura 1kg	Leche entera en polvo bolsa	15	18	145.00	195.00	0	5
1103	Leche Lala Deslactosada 1L	Leche de facil digestion caja	15	4	24.00	31.00	0	5
1104	Leche Alpura Semidescremada 1L	Leche reducida en grasa	15	18	22.00	28.00	0	5
1105	Leche Santa Clara Entera 1L	Leche premium caja	15	16	26.00	35.00	0	5
1076	Manteca de Cerdo 500g	Grasa animal para cocina	1	58	28.00	42.00	0	5
1108	Mantequilla Primavera con Sal 90g	Margarina para untar	19	58	12.00	18.00	0	5
1109	Mantequilla Gloria sin Sal 90g	Mantequilla pura de vaca	19	58	18.00	26.00	0	5
1128	Palomitas ACT II Mantequilla	Bolsa para microondas	9	58	12.00	18.00	0	5
1140	Pan Dulce Mantecadas Bimbo 4pza	Panecitos tipo muffin	29	17	18.00	26.00	0	5
1142	Pan Dulce Donas Bimbo 4pza	Donas azucaradas empaque	29	17	18.00	26.00	0	5
1143	Gansito Marinela 50g	Pastelito relleno mermelada y crema	29	22	13.00	18.00	0	5
1144	Pingüinos Marinela 2pza	Pastelitos de chocolate rellenos	29	22	18.00	25.00	0	5
1145	Chocotorro Marinela 1pza	Pastelito relleno de fresa	29	22	13.00	18.00	0	5
1146	Galletas Triki-Trakes 6pza	Galletas con chispas Marinela	29	22	12.00	17.00	0	5
1147	Galletas Canelitas 120g	Galletas sabor canela paquete mediano	29	22	18.00	28.00	0	5
1148	Donitas Totis Sal y Limón bolsa	Botana de trigo familiar	9	58	18.00	28.00	0	5
1149	Fritos Sal y Limón 170g	Botana de maiz crujiente	9	3	35.00	48.00	0	5
1150	Pasta de Dientes Colgate Total 12	Cuidado bucal proteccion completa	38	30	35.00	52.00	0	5
1151	Pasta de Dientes Colgate Triple Accion	Cuidado bucal economico 100ml	38	30	22.00	32.00	0	5
1152	Pasta de Dientes Crest Blancura	Cuidado bucal blanqueador	38	58	28.00	40.00	0	5
1153	Enjuague Bucal Colgate Plax 250ml	Refrescante bucal sin alcohol	38	30	38.00	55.00	0	5
1154	Shampoo Pantene Brillo 700ml	Cuidado del cabello botella grande	35	35	75.00	105.00	0	5
1155	Acondicionador Sedal Brillo 620ml	Cuidado del cabello desenredante	35	34	42.00	58.00	0	5
1156	Shampoo Caprice Especialidades 750ml	Shampoo economico aromas	35	31	32.00	45.00	0	5
1157	Crema para Peinar Sedal 300ml	Control de frizz para cabello	35	34	32.00	45.00	0	5
1158	Gel Ego Fuerza Extrema 1kg	Gel fijador tarro grande	41	58	55.00	78.00	0	5
1159	Jabón de Tocador Zest Aqua 135g	Jabon de barra refrescante	41	58	12.50	18.00	0	5
1160	Jabón de Tocador Palmolive Neutro	Jabon de barra piel sensible	41	31	14.00	20.00	0	5
1161	Desodorante Speed Stick Spray 150ml	Antitranspirante masculino	41	58	45.00	65.00	0	5
1162	Desodorante Lady Speed Stick Stick	Antitranspirante femenino	41	58	32.00	48.00	0	5
1163	Crema Nivea Corporal 400ml	Crema humectante botella	41	58	65.00	95.00	0	5
1164	Vaselina Labial Proteccion 10g	Protector de labios tarro mini	41	58	15.00	22.00	0	5
1165	Rastrillo Prestobarba 3 4pza	Rastrillos desechables paquete	41	58	75.00	105.00	0	5
1166	Toallas Saba Nocturna 10pza	Higiene femenina flujo pesado	41	58	32.00	45.00	0	5
1167	Protector Diario Saba 20pza	Higiene femenina uso diario	41	58	25.00	38.00	0	5
1168	Detergente Ariel Power 1kg	Detergente en polvo multiusos	34	58	42.00	58.00	0	5
1169	Detergente Roma 1kg	Detergente en polvo biodegradable	34	58	32.00	45.00	0	5
1170	Jabón Zote Blanco 400g	Jabon de lavanderia en barra	34	33	22.00	30.00	0	5
1171	Jabón Zote Rosa 400g	Jabon de lavanderia en barra	34	33	22.00	30.00	0	5
1172	Suavizante Suavitel Fresca Primavera 1L	Suavizante de telas botella	32	32	28.00	38.00	0	5
1173	Cloro Cloralex 950ml	Desinfectante y blanqueador	35	58	16.00	24.00	0	5
1174	Limpiador Fabuloso Lavanda 2L	Limpiador multiusos grande	35	31	42.00	58.00	0	5
1175	Lavatrastes Salvo Limón 900ml	Detergente liquido potente	34	58	38.00	52.00	0	5
1176	Fibra Scotch-Brite Multiusos 2pza	Esponja para lavar platos	34	58	22.00	32.00	0	5
1177	Bolsa para Basura Mediana 15pza	Bolsas negras con jareta	35	58	25.00	38.00	0	5
1178	Guantes de Látex Domésticos G	Guantes para limpieza amarillos	35	58	18.00	28.00	0	5
1179	Insecticida Raid Casa y Jardín 400ml	Spray contra insectos	35	58	58.00	82.00	0	5
1180	Alimento Gato Whiskas Carne 1.5kg	Croquetas para gato adulto	43	58	125.00	175.00	0	5
1181	Alimento Perro Pedigree Res 2kg	Croquetas para perro adulto	43	58	145.00	195.00	0	5
1182	Cerveza Corona Extra 355ml 6-pack	Six pack de cerveza clara	32	58	95.00	135.00	0	5
1183	Cerveza Victoria 355ml 6-pack	Six pack de cerveza oscura	32	58	95.00	135.00	0	5
1184	Refresco Coca-Cola 600ml NR	Bebida de cola botella plastico	31	16	14.50	18.00	0	5
1185	Refresco Coca-Cola 2.5L NR	Bebida de cola botella familiar	31	16	32.00	42.00	0	5
1186	Refresco Sprite 600ml	Bebida de lima limon	31	16	13.00	17.00	0	5
1187	Refresco Sidral Mundet 600ml	Bebida de manzana	31	16	13.00	17.00	0	5
1189	Agua Purificada Ciel 600ml	Agua natural embotellada	30	16	9.00	13.00	0	5
1190	Agua Purificada Bonafont 1.5L	Agua natural botella mediana	30	55	14.00	20.00	0	5
1193	Bebida Energizante Monster 473ml	Bebida con cafeina lata	31	16	35.00	48.00	0	5
1194	Bebida Energizante Red Bull 250ml	Bebida con cafeina lata pequeña	31	58	42.00	58.00	0	5
1195	Sopa Maruchan Instant Lunch Pollo	Vaso de sopa instantanea 64g	12	57	11.00	16.00	0	5
1196	Sopa Maruchan Instant Lunch Camaron	Vaso de sopa instantanea 64g	12	57	11.00	16.00	0	5
1197	Atún Dolores en Aceite 140g	Atun en hojuelas lata	6	51	16.00	23.00	0	5
1198	Atún Dolores en Agua 140g	Atun en hojuelas lata	6	51	16.00	23.00	0	5
1199	Sardina en Tomate Pescador 425g	Sardinas en salsa lata	6	58	28.00	40.00	0	5
1200	Pechuga de Pavo San Rafael Real 250g	Pechuga de pavo premium rebanada	18	52	62.00	88.00	0	5
1201	Jamón Real de Pierna San Rafael 250g	Jamón de pierna de alta calidad	18	52	58.00	82.00	0	5
1202	Salchicha de Pavo San Rafael 500g	Salchichas premium para asar	18	52	48.00	68.00	0	5
1204	Salami Italiano San Rafael 100g	Salami madurado rebanado	18	52	45.00	65.00	0	5
1205	Pastrami de Pavo San Rafael 150g	Corte de pavo sazonado premium	18	52	65.00	92.00	0	5
1206	Lomo Ahumado San Rafael 200g	Lomo de cerdo ahumado natural	18	52	55.00	78.00	0	5
1207	Pechuga de Pavo Balance Fud 250g	Linea saludable reducida en sodio	18	53	48.00	68.00	0	5
1191	Jugo Jumex Mango 1L	Nectar de fruta en carton	31	21	19.00	26.00	0	5
1192	Jugo Jumex Manzana 1L	Nectar de fruta en carton	31	21	19.00	26.00	0	5
1203	Chorizo Salamanca San Rafael 200g	Chorizo tipo español curado	18	52	52.00	75.00	0	5
1208	Jamón de Pierna Fud Selecto 250g	Jamón de pierna calidad extra	18	53	42.00	58.00	0	5
1209	Tocino Premium San Rafael 250g	Tocino corte grueso ahumado	18	52	68.00	95.00	0	5
1210	Chistorra de Res 200g	Embutido para asado premium	18	58	45.00	65.00	0	5
1211	Queso de Puerco Tradicional 250g	Embutido de cerdo especiado	18	58	32.00	48.00	0	5
1212	Paté de Hígado de Cerdo 100g	Crema de higado para untar	18	58	22.00	35.00	0	5
1213	Cerveza Modelo Especial Botella 355ml	Cerveza clara premium	32	58	20.00	28.00	0	5
1214	Cerveza Negra Modelo Botella 355ml	Cerveza oscura tipo Munich	32	58	20.00	28.00	0	5
1215	Cerveza Modelo Ambar 355ml	Cerveza tipo viena botella	32	58	20.00	28.00	0	5
1216	Cerveza Stella Artois 330ml	Cerveza lager importada	32	58	26.00	38.00	0	5
1217	Cerveza Budweiser Lata 355ml	Cerveza lager americana	32	58	18.00	25.00	0	5
1218	Cerveza Michelob Ultra 6-pack Lata	Six pack cerveza light	32	58	110.00	155.00	0	5
1219	Cerveza Corona Extra 12-pack Lata	Paquete familiar 12 piezas	32	58	185.00	245.00	0	5
1220	Cerveza Victoria Mega 1.2L	Cerveza oscura retorno grande	32	58	35.00	48.00	0	5
1221	Cerveza Corona Familiar 940ml	Cerveza clara presentacion grande	32	58	32.00	45.00	0	5
1222	Cerveza Artesanal IPA 355ml	Cerveza con alto contenido de lupulo	32	58	45.00	65.00	0	5
1223	Cerveza Artesanal Porter 355ml	Cerveza oscura artesanal	32	58	45.00	65.00	0	5
1224	Cerveza Heineken 0.0 Sin Alcohol	Cerveza clara sin alcohol	32	58	22.00	32.00	0	5
1225	Cerveza Tecate Original 6-pack Lata	Six pack cerveza clara	32	58	92.00	125.00	0	5
1226	Vino Tinto Casillero del Diablo 750ml	Vino Cabernet Sauvignon	33	58	175.00	245.00	0	5
1228	Vino Rosado L.A. Cetto 750ml	Vino rosado nacional	33	58	145.00	195.00	0	5
1229	Tequila Don Julio 70 700ml	Tequila añejo cristalino	33	58	850.00	1150.00	0	5
1230	Tequila Centenario Plata 700ml	Tequila blanco 100 por ciento agave	33	58	380.00	520.00	0	5
1231	Mezcal Amarás Joven 750ml	Mezcal artesanal de Oaxaca	33	58	550.00	750.00	0	5
1232	Vodka Absolut Azul 750ml	Vodka sueco original	33	58	260.00	365.00	0	5
1233	Ron Bacardi Blanco 980ml	Ron tradicional para cocteleria	33	58	195.00	275.00	0	5
1234	Whisky Buchanan's 12 años 750ml	Whisky escoces de lujo	33	58	720.00	980.00	0	5
1235	Ginebra Tanqueray 750ml	Ginebra premium London Dry	33	58	480.00	650.00	0	5
1236	Brandy Torres 10 700ml	Brandy español reserva	33	58	290.00	395.00	0	5
1238	Bloqueador Solar Nivea FPS 50	Protector solar spray 200ml	40	58	185.00	245.00	0	5
1239	Crema Facial Pond's S 100g	Crema humectante nutritiva	40	58	52.00	75.00	0	5
1240	Serum Loreal Revitalift Hialuronico	Suero facial hidratante 30ml	40	58	245.00	325.00	0	5
1241	Gel Limpiador Facial Neutrogena	Jabón liquido para cara 200ml	40	58	135.00	185.00	0	5
1242	Agua Micelar Garnier 400ml	Limpiador facial todo en uno	40	58	95.00	135.00	0	5
1243	Crema Corporal Lubriderm Piel Seca	Hidratacion profunda 400ml	40	58	85.00	115.00	0	5
1244	Exfoliante Corporal Dove 298g	Exfoliante de granada y manteca	40	36	110.00	155.00	0	5
1245	Mascarilla Facial Garnier Hidra Bomb	Mascara de tela hidratante	40	58	28.00	42.00	0	5
1246	Shampoo Anticaspa Head & Shoulders	Limpieza profunda 700ml	39	58	85.00	115.00	0	5
1247	Shampoo Elvive Reparacion Total	Cuidado capilar 680ml	39	58	75.00	105.00	0	5
1248	Tinte para Cabello Koleston	Coloracion permanente tonos varios	39	58	55.00	85.00	0	5
1249	Crema para Peinar Pantene Rizos	Definicion de rizos 300ml	39	35	42.00	58.00	0	5
1250	Desodorante Axe Black Aero 150ml	Body spray masculino	41	58	48.00	68.00	0	5
1251	Desodorante Rexona Clinical Hombre	Antitranspirante maxima proteccion	41	58	65.00	92.00	0	5
1252	Desodorante Dove Original Barra	Cuidado de axilas femenino	41	36	38.00	55.00	0	5
1253	Jabón Líquido Dial Antibacterial	Jabón corporal de manos 460ml	42	58	42.00	60.00	0	5
1254	Jabón de Barra Dove Blanco 135g	Barra de belleza humectante	42	36	18.00	26.00	0	5
1255	Cera para Depilar Rostro Nair	Bandas de cera fria 20pza	41	58	65.00	95.00	0	5
1256	Enjuague Bucal Colgate Total 12 500ml	Proteccion bucal avanzada	38	30	72.00	98.00	0	5
1257	Hilo Dental Reach Mentolado	Limpieza interdental 50m	38	58	35.00	48.00	0	5
1258	Cepillo Dental Oral-B Pro-Salud	Cepillo de cerdas suaves 2 pack	38	30	45.00	65.00	0	5
1259	Toallas Femeninas Saba V-Natural	Toallas con extractos naturales 10pza	41	58	28.00	40.00	0	5
1260	Pañales Adulto Depend G 10pza	Pañal para incontinencia	44	29	145.00	195.00	0	5
1261	Cuaderno Scribe Doble Raya	Cuaderno profesional 100 hojas	36	58	24.00	35.00	0	5
1262	Sacapuntas con Deposito Maped	Sacapuntas de plastico doble	36	58	12.00	20.00	0	5
1263	Colores Prismacolor 12 pzas	Lapices de colores escolares	36	58	55.00	85.00	0	5
1264	Juego de Geometría Básico	Regla escuadras y transportador	36	58	35.00	55.00	0	5
1265	Marcatextos Sharpie Amarillo	Resaltador de tinta brillante	36	58	14.00	22.00	0	5
1266	Tijeras Escolares punta roma	Tijeras de seguridad para niños	36	58	12.00	20.00	0	5
1267	Diccionario Escolar Básico	Diccionario español para primaria	36	58	45.00	75.00	0	5
1268	Plato Desechable No. 9 20 pzas	Plato de plastico blanco fiesta	45	58	32.00	48.00	0	5
1269	Cuchara Desechable Pastelera 25pza	Cubiertos de plastico chicos	45	58	15.00	25.00	0	5
1271	Limpiador de Vidrios Windex 750ml	Gatillo limpiador cristales	35	58	42.00	62.00	0	5
1272	Desengrasante Mr. Músculo Cocina	Limpiador de superficies grasas	35	58	45.00	68.00	0	5
1273	Pastilla para Tanque Harpic 2pza	Limpiador de inodoro azul	35	58	28.00	42.00	0	5
1227	Vino Blanco Diamante 750ml	Vino blanco semidulce	33	58	165.00	235.00	0	5
1270	Mantel de Plástico para Fiesta	Mantel rectangular de colores	45	58	22.00	38.00	0	5
1274	Aromatizante Glade Toque 3 repuestos	Concentrado de aroma spray	35	58	52.00	78.00	0	5
1275	Escoba de Exterior Uso Rudo	Escoba de cerdas rigidas	35	58	55.00	85.00	0	5
1276	Jalador de Agua de Goma 40cm	Para limpieza de pisos	35	58	42.00	65.00	0	5
1277	Bolsa Basura Jumbo 10pzas	Bolsa negra reforzada	35	58	38.00	55.00	0	5
1278	Alimento Perro Campeon 4kg	Croquetas economicas para perro	43	58	185.00	245.00	0	5
1279	Alimento Gato Minino Plus 1.3kg	Croquetas gourmet para gato	43	58	115.00	165.00	0	5
1280	Arena para Gato con Aroma 5kg	Arena para desechos perfumada	43	58	75.00	105.00	0	5
1281	Café Starbucks Pike Place 340g	Café tostado y molido premium	4	19	145.00	210.00	0	5
1282	Cápsulas Dolce Gusto Cappuccino	Caja con 16 capsulas	4	19	135.00	185.00	0	5
1283	Endulzante Monk Fruit 100g	Sustituto de azucar natural	3	58	85.00	125.00	0	5
1284	Harina de Almendra 500g	Harina para cocina saludable	10	58	95.00	145.00	0	5
1285	Quinoa Real Blanca 500g	Grano saludable de quinoa	2	58	55.00	85.00	0	5
1286	Aceite de Coco Organico 420ml	Aceite para cocina y piel	1	58	85.00	125.00	0	5
1287	Salsa Picante Huichol 190ml	Salsa tradicional picante	12	58	12.00	18.00	0	5
1288	Salsa Maggi Sazonador 100ml	Salsa liquida para carnes	13	19	22.00	32.00	0	5
1289	Salsa Inglesa Crosse & Blackwell	Salsa para marinar 145ml	13	19	24.00	35.00	0	5
1290	Aceitunas Rellenas de Anchoa 200g	Aceitunas gourmet en frasco	6	58	35.00	52.00	0	5
1291	Cereal Cheerios Avena y Granola	Cereal saludable Nestlé	5	19	62.00	88.00	0	5
1292	Barra de Proteina Quest 60g	Barra alta en proteina varios sabores	5	58	45.00	68.00	0	5
1294	Yogurt Griego Oikos Natural 150g	Yogurt cremoso sin azucar	17	55	15.00	22.00	0	5
1295	Helado Holanda Vainilla 1L	Bote de helado cremoso	17	58	55.00	85.00	0	5
1296	Paletas Magnum Clasica 3pza	Caja de helado cubierto chocolate	17	58	85.00	120.00	0	5
1297	Papas Pringles Original 124g	Botana de papa en tubo	9	58	38.00	55.00	0	5
1298	Cacahuates Mafer Salados 180g	Cacahuate premium con sal	9	58	35.00	52.00	0	5
1299	Mezcla de Frutos Secos 200g	Arandanos nueces y almendras	9	58	45.00	68.00	0	5
1300	Palomitas Slim Pop 110g	Palomitas de maiz con aire	9	58	28.00	42.00	0	5
1301	Galletas Stila Avena y Fruta	Galletas nutritivas Bimbo	29	17	12.00	18.00	0	5
1302	Pan Pita Integral Paquete 10pza	Pan plano para sandwiches	27	58	32.00	48.00	0	5
1303	Tortillas de Harina Tía Rosa Gdes	Paquete con 10 piezas grandes	27	49	25.00	35.00	0	5
1304	Tostadas Horneadas Sanissimo	Paquete de 20 piezas	9	61	35.00	48.00	0	5
1305	Refresco Coca-Cola Light 600ml	Refresco sin calorias	31	16	14.50	18.00	0	5
1307	Agua Mineral Topo Chico 600ml	Agua mineral de manantial	30	16	16.00	24.00	0	5
1308	Jugo V8 Splash Berry Blend 1.9L	Bebida de frutas y verduras	31	58	45.00	65.00	0	5
1309	Suero Oral Suerox 630ml	Bebida hidratante sabores varios	31	58	18.00	26.00	0	5
1310	Energizante Bolt Lata 473ml	Bebida con cafeina economica	31	58	15.00	22.00	0	5
1311	Vela de Olor en Vaso de Vidrio	Vela decorativa aromatica	45	58	35.00	55.00	0	5
1312	Tarjetas de Regalo Surtidas	Tarjetas para felicitacion	45	58	15.00	35.00	0	5
1313	Cinta Adhesiva de Color	Cinta decorativa para regalo	45	58	10.00	18.00	0	5
1314	Papel Regalo Pliego	Hojas de papel decorado	45	58	5.00	12.00	0	5
1315	Moño para Regalo Grande	Moño de celofan varios colores	45	58	8.00	15.00	0	5
1316	Pilas Duracell AA 4 piezas	Baterias alcalinas larga duracion	51	38	85.00	125.00	0	5
1317	Pilas Energizer AAA 4 piezas	Baterias alcalinas	51	39	85.00	125.00	0	5
1318	Lampara de Emergencia Recargable	Lampara LED para fallas luz	51	58	145.00	195.00	0	5
1319	Candado de Laton 40mm	Candado reforzado 3 llaves	51	58	65.00	95.00	0	5
1320	Pegamento Epoxico Transparente	Pegamento dos componentes fuerte	51	58	45.00	75.00	0	5
1321	Limpiador de Alfombras en Espuma	Limpieza de textiles y tapiceria	35	58	65.00	95.00	0	5
1322	Detergente Liquido Mas Color 1L	Detergente para ropa oscura	34	58	38.00	55.00	0	5
1324	Suavizante Downy Concentrado 800ml	Aroma intenso para ropa	32	58	42.00	62.00	0	5
1325	Cubeta de Plastico con Exprimidor	Cubeta para trapear reforzada	35	58	85.00	125.00	0	5
1326	Guantes de Nitrilo Caja 50pza	Guantes desechables de examen	35	58	120.00	185.00	0	5
1327	Tapete de Entrada Bienvenida	Tapete de hule para puerta	51	58	65.00	95.00	0	5
1328	Foco LED Vintage Luz Calida	Foco decorativo estilo antiguo	51	58	45.00	75.00	0	5
1329	Cable USB C a USB C 1m	Cable de carga rapida	51	58	35.00	65.00	0	5
1330	Audifonos de Chicharo con Microfono	Manos libres economicos	51	58	45.00	85.00	0	5
1331	Chocolate Ferrero Rocher 16pzas	Caja de bombones de chocolate	8	40	125.00	185.00	0	5
1332	Chocolate Hershey's Almond 40g	Barra de chocolate con almendras	8	45	13.00	18.00	0	5
1334	Dulce Mazapan De La Rosa Gigante	Mazapan de cacahuate 50g	8	62	6.00	10.00	0	5
1335	Gomitas Panditas Ricolino 65g	Gomitas de ositos sabores	8	67	13.00	18.00	0	5
1336	Paleta Tutsi Pop Grande 1pza	Paleta con centro de chicle	8	65	5.00	8.00	0	5
1337	Caramelo Suave Winis 4pza	Tira de caramelos sabores	8	58	5.00	8.00	0	5
1338	Chicles Orbit Menta sin Azucar	Chicles en bote pequeño	8	58	18.00	28.00	0	5
1340	Mermelada McCormick Fresa 270g	Mermelada de fruta con trozos	11	58	28.00	42.00	0	5
1333	Kisses de Chocolate con Leche 75g	Bolsa de chocolates pequeños	8	45	28.00	42.00	0	5
1339	Dulce de Leche Coronado 370g	Cajeta quemada tradicional	11	66	55.00	78.00	0	5
1306	Refresco Sidral Mundet Manzana 2L	Refresco sabor manzana familiar	31	16	26.00	35.00	0	5
1323	Quita Manchas Vanish 450g	Polvo para manchas dificiles	34	58	45.00	68.00	0	5
1341	Arroz Super Extra Verde Valle 900g	Arroz de grano largo seleccionado	2	58	32.00	45.00	0	5
1342	Frijol Negro Isadora Pouch 430g	Frijoles refritos listos	2	58	15.00	22.00	0	5
1343	Atun Herdez en Agua 130g	Atun en trozos lata	6	20	17.00	24.00	0	5
1344	Chiles Jalapeños La Costeña 220g	Chiles en escabeche lata	6	27	12.00	18.00	0	5
1345	Granos de Elote Del Monte 225g	Maiz dulce en lata	6	70	13.00	19.00	0	5
1346	Pure de Tomate Del Fuerte 210g	Tomate molido condimentado	12	43	7.00	11.00	0	5
1347	Sopa Pasta Knorr de Pollo 95g	Sopa instantanea en sobre	12	58	11.00	16.00	0	5
1348	Consome de Pollo Knorr 10 cubos	Sazonador en cubos	13	58	15.00	22.00	0	5
1349	Sal de Mar de Grano 1kg	Sal natural no refinada	13	58	18.00	28.00	0	5
1350	Azucar Stevia en Polvo 100g	Endulzante natural frasco	3	58	65.00	95.00	0	5
1351	Shampoo para Bebe Johnson 400ml	Shampoo no mas lagrimas	44	58	55.00	82.00	0	5
1352	Toallitas Humedas Huggies Cuidado	Paquete de 80 toallitas	44	29	35.00	52.00	0	5
1353	Papilla Gerber Etapa 2 Pollo 113g	Alimento para bebe frasco	44	19	14.00	20.00	0	5
1355	Biberon Avent Natural 9oz	Biberon ergonomico anticólicos	44	58	185.00	265.00	0	5
1357	Crema para Peinar Herbal Essences	Hidratacion y brillo 300ml	39	58	48.00	68.00	0	5
1358	Desodorante Gillette Clear Gel 82g	Antitranspirante transparente	41	58	55.00	78.00	0	5
1359	Toallas Femeninas Kotex Nocturna	Toallas con alas 10pza	41	29	32.00	45.00	0	5
1360	Cepillo de Pelo Redondo	Cepillo para peinar y secar	39	58	45.00	75.00	0	5
1361	Cerveza Indio Mega 1.2L	Cerveza oscura presentacion familiar	32	58	35.00	48.00	0	5
1362	Cerveza Sol Clamato Lata 473ml	Mezcla de cerveza y tomate	32	58	24.00	35.00	0	5
1363	Cerveza Modelo Trigo 355ml	Cerveza de trigo artesanal	32	58	22.00	32.00	0	5
1364	Cerveza XX Ambar 6-pack Botella	Six pack cerveza oscura	32	58	105.00	145.00	0	5
1365	Cerveza Heineken Silver Lata 355ml	Cerveza clara mas ligera	32	58	20.00	28.00	0	5
1366	Vino Tinto Sangre de Toro 750ml	Vino tinto español	33	58	185.00	265.00	0	5
1367	Vodka Smirnoff Tamarindo 750ml	Vodka con sabor picante	33	58	240.00	345.00	0	5
1368	Ginebra Beefeater 750ml	Ginebra clasica London Dry	33	58	450.00	620.00	0	5
1369	Ron Captain Morgan 700ml	Ron especiado dorado	33	58	185.00	265.00	0	5
1370	Licor 43 700ml	Licor español de vainilla	33	58	450.00	620.00	0	5
1371	Salchicha para Hot Dog Fud 500g	Paquete de salchichas familiar	18	53	35.00	48.00	0	5
1372	Tocino Picado para Cocinar 200g	Recortes de tocino ahumado	18	53	28.00	42.00	0	5
1373	Chorizo Argentino para Asar 500g	Embutido premium para parrilla	18	58	75.00	110.00	0	5
1374	Mortadela con Pistache 250g	Embutido fino rebanado	18	58	38.00	55.00	0	5
1375	Jamón de Pavo Virginia Zwan 250g	Jamón de pavo calidad media-alta	18	58	35.00	48.00	0	5
1376	Papas Sabritas Receta Crujiente 170g	Papas fritas con sal de mar	9	3	45.00	65.00	0	5
1377	Doritos Pizzerola 146g	Botana de maiz sabor pizza	9	3	38.00	52.00	0	5
1378	Tostilocos Clasicos Bolsa 200g	Botana de maiz para preparar	9	3	42.00	58.00	0	5
1379	Papas Barcel Chips Jalapeño 170g	Papas fritas crujientes picantes	9	47	45.00	65.00	0	5
1380	Cheetos Colmillo 150g	Botana de maiz forma colmillo	9	3	32.00	45.00	0	5
1381	Galletas Gamesa Habaneras 117g	Galletas integrales saladas	9	46	15.00	22.00	0	5
1382	Galletas Cuetara Surtido 400g	Caja de galletas variadas	9	58	45.00	65.00	0	5
1383	Pan Blanco para Hot Dog Bimbo 8pza	Medias noches clasicas	27	17	32.00	45.00	0	5
1384	Pan para Hamburguesa Bimbo 8pza	Bollos con ajonjoli	27	17	35.00	48.00	0	5
1386	Vasos de Carton Biodegradables 10pza	Vasos para cafe o bebidas	45	58	22.00	35.00	0	5
1387	Globos Metalicos de Numeros	Globos para aniversario o cumple	45	58	25.00	45.00	0	5
1388	Papel Crepé varios colores	Pliego de papel para decoracion	45	58	4.00	10.00	0	5
1389	Adorno de Guirnalda Fiesta 3m	Tira decorativa de colores	45	58	18.00	32.00	0	5
1390	Pegamento Resistol 5000 135ml	Pegamento de contacto amarillo	51	58	45.00	68.00	0	5
1391	Silicon Liquido Frio 100ml	Pegamento para manualidades	51	58	22.00	35.00	0	5
1392	Cinta de Doble Cara 5m	Cinta adhesiva doble contacto	51	58	25.00	42.00	0	5
1394	Notas Adhesivas Post-it 76x76mm	Bloc de notas de colores	36	58	22.00	38.00	0	5
1395	Engrapadora de Oficina con Grapas	Engrapadora pequeña metalica	36	58	65.00	95.00	0	5
1396	Agua de Coco Marva 500ml	Agua de coco natural	31	58	18.00	28.00	0	5
1397	Te Helado Lipton Limon 600ml	Bebida de te negro	31	58	14.00	20.00	0	5
1399	Refresco Mundet Fresa 600ml	Refresco sabor fresa	31	16	13.00	17.00	0	5
5	Leche deslactosada lala 1lt	Presentacion azul	15	4	18.20	23.00	13	2
430	Leche Lala Deslactosada 1.5L	Leche Deslactosada 1.5 Litros	15	4	32.00	39.00	0	5
436	Leche Alpura 250ml Chocolate	Leche saborizada Chocolate 250ml	15	18	8.50	12.00	0	5
437	Leche Alpura 250ml Vainilla	Leche saborizada Vainilla 250ml	15	18	8.50	12.00	0	5
735	Queso Americano Nutrileche 140g	Producto lacteo estilo americano	16	4	16.00	22.00	0	5
940	Arroz con Leche Lala 125g	Postre listo para comer	17	4	10.00	15.00	0	5
1293	Leche de Coco Calahua 1L	Bebida de coco para cocina	15	58	38.00	55.00	0	5
1354	Leche Formula Nan Pro 1 400g	Formula lactea etapa 1	44	19	165.00	225.00	0	5
880	Pepto-Bismol Suspensión 118ml	Auxiliar en malestar estomacal	50	58	55.00	78.00	0	5
1385	Manteles Desechables Decorados 1pza	Mantel de papel para fiesta	45	58	15.00	28.00	0	5
1393	Marcador Permanente Sharpie 2 pack	Marcador negro punta fina	36	58	35.00	55.00	0	5
1398	Refresco Manzana Lift 600ml	Refresco de manzana natural	31	16	13.00	17.00	0	5
1237	Rompepe Santa Clara 1L	Bebida de huevo y vainilla	33	16	145.00	195.00	0	5
479	Mantecadas Bimbo 4 pzas	Pan dulce sabor Vainilla 4 pzas	29	17	19.00	26.00	0	5
676	Fabuloso Fresca Manana 1L	Limpiador multiusos verde	35	30	22.00	30.00	0	5
801	Jugo Boing Mango 250ml	Bebida de fruta de carton	31	58	7.50	10.00	0	5
814	Pau Pau Mango 250ml	Bebida infantil con vitaminas	31	21	5.50	8.00	0	5
982	Recogedor de Plastico con Mango	Recogedor de basura sencillo	35	58	25.00	45.00	0	5
1053	Mayonesa Hellmann's Clasica 390g	Mayonesa suave y cremosa	12	58	42.00	58.00	0	5
1356	Jabón Liquido para Manos Palmolive	Repuesto economico 500ml	42	31	32.00	48.00	0	5
\.


--
-- Data for Name: productos_bar; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.productos_bar (id_producto, nombre, descripcion, id_categoria, precio_venta, stock, stock_minimo) FROM stdin;
\.


--
-- Data for Name: productos_por_gramaje; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.productos_por_gramaje (id_producto, nombre, descripcion, id_categoria, id_proveedor, precio_compra, precio_venta, stock, stock_minimo, unidad_medida, id_serial) FROM stdin;
1	Zanahoria		22	12	14.00	18.00	5.00	1.00	kg	1
\.


--
-- Data for Name: productos_respaldo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.productos_respaldo (id_producto, nombre, descripcion, id_categoria, id_proveedor, precio_compra, precio_venta, stock, stock_minimo, fecha_respaldo) FROM stdin;
8	chimichangas	chimichangas	23	10	30.00	45.00	25	5	2024-07-16 00:00:00
9	Roles	Pan Dulce	27	13	70.00	100.00	35	10	2024-07-16 00:00:00
10	Pepsi	bebida azucarada	31	14	8.00	16.00	86	20	2024-07-16 00:00:00
11	Leche deslactosada lala 1lt	Presentacion azul	15	4	11.75	23.00	2	2	2024-07-16 00:00:00
12	Leche entera lala 1lt	Clasica color roja	15	4	15.24	25.00	2	3	2024-07-16 00:00:00
13	Galletas marias	Las galletas clasicas	9	3	8.90	15.00	23	2	2024-07-16 00:00:00
14	MaruchanTokyo	maruchan picante	2	11	5.50	12.50	14	10	2024-07-16 00:00:00
15	chimichangas	chimichangas	23	10	30.00	45.00	25	5	2024-07-17 00:00:00
16	Roles	Pan Dulce	27	13	70.00	100.00	35	10	2024-07-17 00:00:00
17	Pepsi	bebida azucarada	31	14	8.00	16.00	86	20	2024-07-17 00:00:00
18	Leche deslactosada lala 1lt	Presentacion azul	15	4	11.75	23.00	2	2	2024-07-17 00:00:00
19	Leche entera lala 1lt	Clasica color roja	15	4	15.24	25.00	2	3	2024-07-17 00:00:00
20	Galletas marias	Las galletas clasicas	9	3	8.90	15.00	23	2	2024-07-17 00:00:00
21	MaruchanTokyo	maruchan picante	2	11	5.50	12.50	10	10	2024-07-17 00:00:00
22	Leche deslactosada lala 1lt	Presentacion azul	15	4	11.75	23.00	0	2	2024-07-18 00:00:00
23	Leche entera lala 1lt	Clasica color roja	15	4	15.24	25.00	0	3	2024-07-18 00:00:00
24	Palillos	Palillos de madera	38	15	8.50	13.00	15	4	2024-07-18 00:00:00
25	Roles	Pan Dulce	27	13	70.00	100.00	33	10	2024-07-18 00:00:00
26	MaruchanTokyo	maruchan picante	2	11	5.50	12.50	6	10	2024-07-18 00:00:00
27	chimichangas	chimichangas	23	10	30.00	45.00	16	5	2024-07-18 00:00:00
28	Pepsi	bebida azucarada	31	14	8.00	16.00	79	20	2024-07-18 00:00:00
29	Galletas marias	Las galletas clasicas	9	3	8.90	15.00	17	2	2024-07-18 00:00:00
30	Leche deslactosada lala 1lt	Presentacion azul	15	4	11.75	23.00	0	2	2024-07-19 00:00:00
31	Leche entera lala 1lt	Clasica color roja	15	4	15.24	25.00	0	3	2024-07-19 00:00:00
32	Palillos	Palillos de madera	38	15	8.50	13.00	15	4	2024-07-19 00:00:00
33	Roles	Pan Dulce	27	13	70.00	100.00	33	10	2024-07-19 00:00:00
34	MaruchanTokyo	maruchan picante	2	11	5.50	12.50	6	10	2024-07-19 00:00:00
35	chimichangas	chimichangas	23	10	30.00	45.00	16	5	2024-07-19 00:00:00
36	Pepsi	bebida azucarada	31	14	8.00	16.00	79	20	2024-07-19 00:00:00
37	Galletas marias	Las galletas clasicas	9	3	8.90	15.00	17	2	2024-07-19 00:00:00
38	Leche deslactosada lala 1lt	Presentacion azul	15	4	11.75	23.00	0	2	2024-07-20 00:00:00
39	Leche entera lala 1lt	Clasica color roja	15	4	15.24	25.00	0	3	2024-07-20 00:00:00
40	Palillos	Palillos de madera	38	15	8.50	13.00	15	4	2024-07-20 00:00:00
41	Roles	Pan Dulce	27	13	70.00	100.00	33	10	2024-07-20 00:00:00
42	MaruchanTokyo	maruchan picante	2	11	5.50	12.50	6	10	2024-07-20 00:00:00
43	chimichangas	chimichangas	23	10	30.00	45.00	16	5	2024-07-20 00:00:00
44	Pepsi	bebida azucarada	31	14	8.00	16.00	79	20	2024-07-20 00:00:00
45	Galletas marias	Las galletas clasicas	9	3	8.90	15.00	17	2	2024-07-20 00:00:00
46	Palillos	Palillos de madera	38	15	8.50	13.00	14	4	2024-07-21 00:00:00
47	Galletas marias	Las galletas clasicas	9	3	8.90	15.00	16	2	2024-07-21 00:00:00
48	Leche deslactosada lala 1lt	Presentacion azul	15	4	11.75	23.00	15	2	2024-07-21 00:00:00
49	Roles	Pan Dulce	27	13	70.00	100.00	31	10	2024-07-21 00:00:00
50	Leche entera lala 1lt	Clasica color roja	15	4	15.24	25.00	14	3	2024-07-21 00:00:00
51	Pepsi	bebida azucarada	31	14	8.00	16.00	77	20	2024-07-21 00:00:00
52	MaruchanTokyo	maruchan picante	2	11	5.50	12.50	20	10	2024-07-21 00:00:00
53	chimichangas	chimichangas	23	10	30.00	45.00	16	5	2024-07-21 00:00:00
54	Palillos	Palillos de madera	38	15	8.50	13.00	14	4	2024-07-22 00:00:00
55	Galletas marias	Las galletas clasicas	9	3	8.90	15.00	16	2	2024-07-22 00:00:00
56	Leche deslactosada lala 1lt	Presentacion azul	15	4	11.75	23.00	15	2	2024-07-22 00:00:00
57	Roles	Pan Dulce	27	13	70.00	100.00	31	10	2024-07-22 00:00:00
58	Leche entera lala 1lt	Clasica color roja	15	4	15.24	25.00	14	3	2024-07-22 00:00:00
59	Pepsi	bebida azucarada	31	14	8.00	16.00	77	20	2024-07-22 00:00:00
60	MaruchanTokyo	maruchan picante	2	11	5.50	12.50	20	10	2024-07-22 00:00:00
61	chimichangas	chimichangas	23	10	30.00	45.00	16	5	2024-07-22 00:00:00
62	MaruchanTokyo	maruchan picante	2	11	5.50	12.50	17	10	2024-07-28 00:00:00
63	Galletas marias	Las galletas clasicas	9	3	8.90	15.00	16	2	2024-07-28 00:00:00
64	Leche deslactosada 1lt	Presentacion azul	15	4	11.75	23.00	15	2	2024-07-28 00:00:00
65	Leche entera lala 1lt	Clasica color roja	15	4	15.24	25.00	14	3	2024-07-28 00:00:00
66	chimichangas	chimichangas	23	10	30.00	45.00	16	5	2024-07-28 00:00:00
67	Roles	Ricos roles de canela caseros	27	13	70.00	100.00	31	10	2024-07-28 00:00:00
68	Pepsi	bebida azucarada	31	14	8.00	16.00	77	20	2024-07-28 00:00:00
69	Palillos	Palillos de madera	38	15	8.50	13.00	14	4	2024-07-28 00:00:00
70	MaruchanTokyo	maruchan picante	2	11	5.50	12.50	17	10	2024-07-29 00:00:00
71	Galletas marias	Las galletas clasicas	9	3	8.90	15.00	16	2	2024-07-29 00:00:00
72	Leche deslactosada 1lt	Presentacion azul	15	4	11.75	23.00	15	2	2024-07-29 00:00:00
73	Leche entera lala 1lt	Clasica color roja	15	4	15.24	25.00	14	3	2024-07-29 00:00:00
74	chimichangas	chimichangas	23	10	30.00	45.00	16	5	2024-07-29 00:00:00
75	Roles	Ricos roles de canela caseros	27	13	70.00	100.00	31	10	2024-07-29 00:00:00
76	Pepsi	bebida azucarada	31	14	8.00	16.00	77	20	2024-07-29 00:00:00
77	Palillos	Palillos de madera	38	15	8.50	13.00	14	4	2024-07-29 00:00:00
78	MaruchanTokyo	maruchan picante	2	11	5.50	12.50	17	10	2024-07-30 00:00:00
79	Galletas marias	Las galletas clasicas	9	3	8.90	15.00	16	2	2024-07-30 00:00:00
80	Leche deslactosada 1lt	Presentacion azul	15	4	11.75	23.00	15	2	2024-07-30 00:00:00
81	Leche entera lala 1lt	Clasica color roja	15	4	15.24	25.00	14	3	2024-07-30 00:00:00
82	chimichangas	chimichangas	23	10	30.00	45.00	16	5	2024-07-30 00:00:00
83	Roles	Ricos roles de canela caseros	27	13	70.00	100.00	31	10	2024-07-30 00:00:00
84	Pepsi	bebida azucarada	31	14	8.00	16.00	77	20	2024-07-30 00:00:00
85	Palillos	Palillos de madera	38	15	8.50	13.00	14	4	2024-07-30 00:00:00
86	Manzanita		31	14	17.00	25.00	9	3	2024-07-31 00:00:00
87	MaruchanTokyo	maruchan picante	2	11	5.50	12.50	17	10	2024-07-31 00:00:00
88	Galletas marias	Las galletas clasicas	9	3	8.90	15.00	16	2	2024-07-31 00:00:00
89	Leche deslactosada 1lt	Presentacion azul	15	4	11.75	23.00	15	2	2024-07-31 00:00:00
90	Leche entera lala 1lt	Clasica color roja	15	4	15.24	25.00	14	3	2024-07-31 00:00:00
91	chimichangas	chimichangas	23	10	30.00	45.00	16	5	2024-07-31 00:00:00
92	Roles	Ricos roles de canela caseros	27	13	70.00	100.00	31	10	2024-07-31 00:00:00
93	Pepsi	bebida azucarada	31	14	8.00	16.00	77	20	2024-07-31 00:00:00
94	Palillos	Palillos de madera	38	15	8.50	13.00	14	4	2024-07-31 00:00:00
95	Leche entera lala 1lt	Clasica color roja	15	4	15.24	25.00	12	3	2024-08-02 00:00:00
96	Palillos	Palillos de madera	38	15	8.50	13.00	13	4	2024-08-02 00:00:00
97	MaruchanTokyo	maruchan picante	2	11	5.50	12.50	16	10	2024-08-02 00:00:00
98	chimichangas	chimichangas	23	10	30.00	45.00	15	5	2024-08-02 00:00:00
99	Galletas marias	Las galletas clasicas	9	3	8.90	15.00	20	2	2024-08-02 00:00:00
100	Roles	Ricos roles de canela caseros	27	13	70.00	100.00	19	10	2024-08-02 00:00:00
101	Manzanita		31	14	17.00	25.00	22	3	2024-08-02 00:00:00
102	Leche deslactosada 1lt	Presentacion azul	15	4	11.75	23.00	15	2	2024-08-02 00:00:00
103	Pepsi	bebida azucarada	31	14	8.00	16.00	77	20	2024-08-02 00:00:00
104	Leche entera lala 1lt	Clasica color roja	15	4	15.24	25.00	12	3	2024-08-13 00:00:00
105	Palillos	Palillos de madera	38	15	8.50	13.00	13	4	2024-08-13 00:00:00
106	MaruchanTokyo	maruchan picante	2	11	5.50	12.50	16	10	2024-08-13 00:00:00
107	chimichangas	chimichangas	23	10	30.00	45.00	15	5	2024-08-13 00:00:00
108	Galletas marias	Las galletas clasicas	9	3	8.90	15.00	20	2	2024-08-13 00:00:00
109	Roles	Ricos roles de canela caseros	27	13	70.00	100.00	19	10	2024-08-13 00:00:00
110	Manzanita		31	14	17.00	25.00	22	3	2024-08-13 00:00:00
111	Leche deslactosada 1lt	Presentacion azul	15	4	11.75	23.00	15	2	2024-08-13 00:00:00
112	Pepsi	bebida azucarada	31	14	8.00	16.00	77	20	2024-08-13 00:00:00
113	Leche entera lala 1lt	Clasica color roja	15	4	15.24	25.00	12	3	2024-08-21 00:00:00
114	Palillos	Palillos de madera	38	15	8.50	13.00	13	4	2024-08-21 00:00:00
115	MaruchanTokyo	maruchan picante	2	11	5.50	12.50	16	10	2024-08-21 00:00:00
116	chimichangas	chimichangas	23	10	30.00	45.00	15	5	2024-08-21 00:00:00
117	Galletas marias	Las galletas clasicas	9	3	8.90	15.00	20	2	2024-08-21 00:00:00
118	Roles	Ricos roles de canela caseros	27	13	70.00	100.00	19	10	2024-08-21 00:00:00
119	Manzanita		31	14	17.00	25.00	22	3	2024-08-21 00:00:00
120	Leche deslactosada 1lt	Presentacion azul	15	4	11.75	23.00	15	2	2024-08-21 00:00:00
121	Pepsi	bebida azucarada	31	14	8.00	16.00	77	20	2024-08-21 00:00:00
122	Leche entera lala 1lt	Clasica color roja	15	4	15.24	25.00	12	3	2024-08-25 00:00:00
123	Palillos	Palillos de madera	38	15	8.50	13.00	13	4	2024-08-25 00:00:00
124	MaruchanTokyo	maruchan picante	2	11	5.50	12.50	16	10	2024-08-25 00:00:00
125	chimichangas	chimichangas	23	10	30.00	45.00	15	5	2024-08-25 00:00:00
126	Galletas marias	Las galletas clasicas	9	3	8.90	15.00	20	2	2024-08-25 00:00:00
127	Roles	Ricos roles de canela caseros	27	13	70.00	100.00	19	10	2024-08-25 00:00:00
128	Manzanita		31	14	17.00	25.00	22	3	2024-08-25 00:00:00
129	Leche deslactosada 1lt	Presentacion azul	15	4	11.75	23.00	15	2	2024-08-25 00:00:00
130	Pepsi	bebida azucarada	31	14	8.00	16.00	77	20	2024-08-25 00:00:00
131	Leche entera lala 1lt	Clasica color roja	15	4	15.24	25.00	12	3	2024-08-29 00:00:00
132	Palillos	Palillos de madera	38	15	8.50	13.00	13	4	2024-08-29 00:00:00
133	MaruchanTokyo	maruchan picante	2	11	5.50	12.50	16	10	2024-08-29 00:00:00
134	chimichangas	chimichangas	23	10	30.00	45.00	15	5	2024-08-29 00:00:00
135	Galletas marias	Las galletas clasicas	9	3	8.90	15.00	20	2	2024-08-29 00:00:00
136	Roles	Ricos roles de canela caseros	27	13	70.00	100.00	19	10	2024-08-29 00:00:00
137	Manzanita		31	14	17.00	25.00	22	3	2024-08-29 00:00:00
138	Leche deslactosada 1lt	Presentacion azul	15	4	11.75	23.00	15	2	2024-08-29 00:00:00
139	Pepsi	bebida azucarada	31	14	8.00	16.00	77	20	2024-08-29 00:00:00
140	chimichangas	chimichangas	23	10	30.00	45.00	15	5	2024-09-02 00:00:00
141	Roles	Ricos roles de canela caseros	27	13	70.00	100.00	19	10	2024-09-02 00:00:00
142	Pepsi	bebida azucarada	31	14	8.00	16.00	77	20	2024-09-02 00:00:00
143	Manzanita		31	14	17.00	25.00	22	3	2024-09-02 00:00:00
144	Palillos	Palillos de madera	38	15	8.50	13.00	13	4	2024-09-02 00:00:00
145	MaruchanTokyo	maruchan picante	2	11	5.50	12.50	15	10	2024-09-02 00:00:00
146	Sabritas	Sabritas Flamin Hot	9	3	10.00	18.00	4	1	2024-09-02 00:00:00
147	Galletas marias	Las galletas clasicas	9	3	8.90	15.00	19	2	2024-09-02 00:00:00
148	Leche deslactosada 1lt	Presentacion azul	15	4	11.75	23.00	14	2	2024-09-02 00:00:00
149	Leche entera lala 1lt	Clasica color roja	15	4	15.24	25.00	11	3	2024-09-02 00:00:00
150	chimichangas	chimichangas	23	10	30.00	45.00	15	5	2024-09-11 00:00:00
151	Roles	Ricos roles de canela caseros	27	13	70.00	100.00	19	10	2024-09-11 00:00:00
152	Pepsi	bebida azucarada	31	14	8.00	16.00	77	20	2024-09-11 00:00:00
153	Manzanita		31	14	17.00	25.00	22	3	2024-09-11 00:00:00
154	Palillos	Palillos de madera	38	15	8.50	13.00	13	4	2024-09-11 00:00:00
155	MaruchanTokyo	maruchan picante	2	11	5.50	12.50	15	10	2024-09-11 00:00:00
156	Sabritas	Sabritas Flamin Hot	9	3	10.00	18.00	4	1	2024-09-11 00:00:00
157	Galletas marias	Las galletas clasicas	9	3	8.90	15.00	19	2	2024-09-11 00:00:00
158	Leche deslactosada 1lt	Presentacion azul	15	4	11.75	23.00	14	2	2024-09-11 00:00:00
159	Leche entera lala 1lt	Clasica color roja	15	4	15.24	25.00	11	3	2024-09-11 00:00:00
160	chimichangas	chimichangas	23	10	30.00	45.00	15	5	2024-09-12 00:00:00
161	Roles	Ricos roles de canela caseros	27	13	70.00	100.00	19	10	2024-09-12 00:00:00
162	Pepsi	bebida azucarada	31	14	8.00	16.00	77	20	2024-09-12 00:00:00
163	Manzanita		31	14	17.00	25.00	22	3	2024-09-12 00:00:00
164	Palillos	Palillos de madera	38	15	8.50	13.00	13	4	2024-09-12 00:00:00
165	MaruchanTokyo	maruchan picante	2	11	5.50	12.50	15	10	2024-09-12 00:00:00
166	Sabritas	Sabritas Flamin Hot	9	3	10.00	18.00	4	1	2024-09-12 00:00:00
167	Galletas marias	Las galletas clasicas	9	3	8.90	15.00	19	2	2024-09-12 00:00:00
168	Leche deslactosada 1lt	Presentacion azul	15	4	11.75	23.00	14	2	2024-09-12 00:00:00
169	Leche entera lala 1lt	Clasica color roja	15	4	15.24	25.00	11	3	2024-09-12 00:00:00
170	Arroz Mexica 1kg	\N	2	58	8.00	10.50	100	10	2024-09-30 00:00:00
171	Harina de maiz maseca	\N	10	59	8.00	10.50	100	10	2024-09-30 00:00:00
172	Harina de trigo San antonio	\N	10	41	8.00	10.50	100	10	2024-09-30 00:00:00
173	Tortillas de maiz 1/2 kg	\N	10	58	8.00	10.50	100	10	2024-09-30 00:00:00
174	Pan bimbo blanco chico	\N	27	17	8.00	10.50	100	10	2024-09-30 00:00:00
175	Pan bimbo blanco grande	\N	27	17	8.00	10.50	100	10	2024-09-30 00:00:00
176	Pan bimbo integral chico	\N	27	17	8.00	10.50	100	10	2024-09-30 00:00:00
177	Pan bimbo integral grande	\N	27	17	8.00	10.50	100	10	2024-09-30 00:00:00
178	Rebanadas bimbo	\N	27	17	8.00	10.50	100	10	2024-09-30 00:00:00
179	Chocoroles	\N	27	17	8.00	10.50	100	10	2024-09-30 00:00:00
180	Nito bimbo	\N	27	17	8.00	10.50	100	10	2024-09-30 00:00:00
181	Mantecadas	\N	27	17	8.00	10.50	100	10	2024-09-30 00:00:00
182	Roles de canela con pasas	\N	27	17	8.00	10.50	100	10	2024-09-30 00:00:00
183	Roles de canela glaseados	\N	27	17	8.00	10.50	100	10	2024-09-30 00:00:00
184	Conchas bimbo	\N	27	17	8.00	10.50	100	10	2024-09-30 00:00:00
185	Panque de nuez bimbo	\N	27	17	8.00	10.50	100	10	2024-09-30 00:00:00
186	Donitas bimbo	\N	27	17	8.00	10.50	100	10	2024-09-30 00:00:00
187	Donitas espolvoreadas bimbo	\N	27	17	8.00	10.50	100	10	2024-09-30 00:00:00
188	chimichangas	chimichangas	23	10	30.00	45.00	15	5	2024-09-30 00:00:00
189	Roles	Ricos roles de canela caseros	27	13	70.00	100.00	19	10	2024-09-30 00:00:00
190	Pepsi	bebida azucarada	31	14	8.00	16.00	77	20	2024-09-30 00:00:00
191	Manzanita		31	14	17.00	25.00	22	3	2024-09-30 00:00:00
192	Palillos	Palillos de madera	38	15	8.50	13.00	13	4	2024-09-30 00:00:00
193	MaruchanTokyo	maruchan picante	2	11	5.50	12.50	15	10	2024-09-30 00:00:00
194	Sabritas	Sabritas Flamin Hot	9	3	10.00	18.00	4	1	2024-09-30 00:00:00
195	Galletas marias	Las galletas clasicas	9	3	8.90	15.00	19	2	2024-09-30 00:00:00
196	Leche deslactosada 1lt	Presentacion azul	15	4	11.75	23.00	14	2	2024-09-30 00:00:00
197	Leche entera lala 1lt	Clasica color roja	15	4	15.24	25.00	11	3	2024-09-30 00:00:00
198	Tostadas charras	\N	5	60	8.00	10.50	100	10	2024-09-30 00:00:00
199	Coca Cola 1L	Refresco Coca Cola 1 Litro	31	16	12.00	15.00	100	10	2024-09-30 00:00:00
200	Coca Cola lata 355ml	Refresco Coca Cola 355 ml lata	31	16	8.50	11.00	100	10	2024-09-30 00:00:00
201	Coca Cola 355ml	Refresco Coca Cola 355 ml	31	16	8.00	10.50	100	10	2024-09-30 00:00:00
202	Coca Cola 600ml	Refresco Coca Cola 600 ml	31	16	9.00	12.00	100	10	2024-09-30 00:00:00
203	Coca Cola retornable 1 1/4 lt.	Refresco Coca Cola retornable 1 1/4 lt	31	16	12.50	15.50	100	10	2024-09-30 00:00:00
204	Coca Cola 2L retornable	Refresco Coca Cola retornable 2 Litros	31	16	19.50	24.00	100	10	2024-09-30 00:00:00
205	Coca Cola 3L retornable	Refresco Coca Cola retornable 3 Litros	31	16	24.00	30.00	100	10	2024-09-30 00:00:00
206	Coca Cola Light 600ml	Refresco Coca Cola Light 600 ml	31	16	9.50	12.50	100	10	2024-09-30 00:00:00
207	Pepsi 600ml	Refresco Pepsi 600 ml	31	14	9.00	12.00	100	10	2024-09-30 00:00:00
208	Pepsi 1.5L	Refresco Pepsi 1.5 Litros	31	14	12.00	15.50	100	10	2024-09-30 00:00:00
209	Fanta 600ml	Refresco Fanta 600 ml	31	16	9.00	12.00	100	10	2024-09-30 00:00:00
210	Fanta 1.5L	Refresco Fanta 1.5 Litros	31	16	12.50	16.00	100	10	2024-09-30 00:00:00
211	Sprite 600ml	Refresco Sprite 600 ml	31	16	9.00	12.00	100	10	2024-09-30 00:00:00
212	Sprite 1.5L	Refresco Sprite 1.5 Litros	31	16	12.50	16.00	100	10	2024-09-30 00:00:00
213	Manzanita 600ml	Refresco Manzanita Sol 600 ml	31	16	9.00	12.00	100	10	2024-09-30 00:00:00
214	Manzanita 1.5L	Refresco Manzanita Sol 1.5 Litros	31	16	12.50	16.00	100	10	2024-09-30 00:00:00
215	Fresca 600ml	Refresco Fresca 600 ml	31	16	9.00	12.00	100	10	2024-09-30 00:00:00
216	Fresca 3L	Refresco Fresca 3 Litros	31	16	24.00	30.00	100	10	2024-09-30 00:00:00
217	Mirinda 600ml	Refresco Mirinda 600 ml	31	16	9.00	12.00	100	10	2024-09-30 00:00:00
218	Mirinda 1.5L	Refresco Mirinda 1.5 Litros	31	16	12.50	16.00	100	10	2024-09-30 00:00:00
219	Tostadas Sanissimo	\N	5	61	8.00	10.50	100	10	2024-09-30 00:00:00
220	Marias gamesa	\N	29	46	8.00	10.50	100	10	2024-09-30 00:00:00
221	Jumex de mango 1L	Jugo Jumex sabor Mango 1 Litro	31	21	16.00	20.00	100	10	2024-09-30 00:00:00
222	Emperador chocolate	\N	29	46	8.00	10.50	100	10	2024-09-30 00:00:00
223	Emperador nuez	\N	29	46	8.00	10.50	100	10	2024-09-30 00:00:00
224	Emperador vainilla	\N	29	46	8.00	10.50	100	10	2024-09-30 00:00:00
225	Emperador limon	\N	29	46	8.00	10.50	100	10	2024-09-30 00:00:00
226	Jumex de durazno 1L	Jugo Jumex sabor Durazno 1 Litro	31	21	16.00	20.00	100	10	2024-09-30 00:00:00
227	Jumex de manzana 600ml	Jugo Jumex sabor Manzana 600 ml	31	21	10.00	13.00	100	10	2024-09-30 00:00:00
228	Del Valle fruit naranja 600ml	Jugo Del Valle sabor Naranja 600 ml	31	28	10.50	13.50	100	10	2024-09-30 00:00:00
229	Del Valle fruit manzana 600ml	Jugo Del Valle sabor Manzana 600 ml	31	28	10.50	13.50	100	10	2024-09-30 00:00:00
230	Del Valle fruit guayaba 600ml	Jugo Del Valle sabor Guayaba 600 ml	31	28	10.50	13.50	100	10	2024-09-30 00:00:00
231	Emperador Senso	\N	29	46	8.00	10.50	100	10	2024-09-30 00:00:00
232	Mamut chico	\N	29	46	8.00	10.50	100	10	2024-09-30 00:00:00
233	Leche Lala entera 1L	Leche Lala entera 1 Litro	15	4	19.00	24.00	100	10	2024-09-30 00:00:00
234	Leche Lala deslactosada 1L	Leche Lala deslactosada 1 Litro	15	4	20.00	25.00	100	10	2024-09-30 00:00:00
235	Leche Lala light 1L	Leche Lala light 1 Litro	15	4	20.00	25.00	100	10	2024-09-30 00:00:00
236	Leche Santa Clara entera 1L	Leche Santa Clara entera 1 Litro	15	4	22.00	28.00	100	10	2024-09-30 00:00:00
237	Leche Santa Clara deslactosada 1L	Leche Santa Clara deslactosada 1 Litro	15	4	23.00	29.00	100	10	2024-09-30 00:00:00
238	Yogurt Lala natural 1L	Yogurt Lala natural 1 Litro	17	4	25.00	30.00	100	10	2024-09-30 00:00:00
239	Yogurt Lala de fresa 1L	Yogurt Lala sabor Fresa 1 Litro	17	4	25.00	30.00	100	10	2024-09-30 00:00:00
240	Yogurt Yoplait natural 1L	Yogurt Yoplait natural 1 Litro	17	54	26.00	31.00	100	10	2024-09-30 00:00:00
241	Yogurt Yoplait de fresa 1L	Yogurt Yoplait sabor Fresa 1 Litro	17	54	26.00	31.00	100	10	2024-09-30 00:00:00
242	Mantequilla Lala 250g	Mantequilla Lala 250 gramos	19	4	30.00	38.00	100	10	2024-09-30 00:00:00
243	Queso panela Lala 200g	Queso panela Lala 200 gramos	16	4	40.00	50.00	100	10	2024-09-30 00:00:00
244	Mamut grande	\N	29	46	8.00	10.50	100	10	2024-09-30 00:00:00
245	Chokis	\N	29	46	8.00	10.50	100	10	2024-09-30 00:00:00
246	Chokis rellenas	\N	29	46	8.00	10.50	100	10	2024-09-30 00:00:00
247	Chokis doble chocolate	\N	29	46	8.00	10.50	100	10	2024-09-30 00:00:00
248	Chokis brownie	\N	29	46	8.00	10.50	100	10	2024-09-30 00:00:00
249	Queso panela Alpura 200g	Queso panela Alpura 200 gramos	16	18	40.00	50.00	100	10	2024-09-30 00:00:00
250	Queso oaxaca Lala 200g	Queso Oaxaca Lala 200 gramos	16	4	45.00	55.00	100	10	2024-09-30 00:00:00
251	Queso manchego Lala 200g	Queso Manchego Lala 200 gramos	16	4	50.00	60.00	100	10	2024-09-30 00:00:00
252	Salchichas Fud paquete 500g	Salchichas Fud 500 gramos	18	53	30.00	40.00	100	10	2024-09-30 00:00:00
253	Salchichas San Rafael paquete 500g	Salchichas San Rafael 500 gramos	18	52	35.00	45.00	100	10	2024-09-30 00:00:00
254	Jam¢n de pavo Fud 250g	Jam¢n de Pavo Fud 250 gramos	18	53	35.00	45.00	100	10	2024-09-30 00:00:00
255	Jam¢n de pavo San Rafael 250g	Jam¢n de Pavo San Rafael 250 gramos	18	52	40.00	50.00	100	10	2024-09-30 00:00:00
256	Sidral mundet 600ml	Refresco de manzana de 600ml	31	16	10.00	16.00	20	5	2024-09-30 00:00:00
257	Sidral mundet 3lt	Refresco de manzana de 3lt	31	16	24.00	30.00	20	5	2024-09-30 00:00:00
258	Agua bonafont 600ml	\N	30	55	8.00	10.50	100	10	2024-09-30 00:00:00
259	Agua bonafont 1lt	\N	30	55	12.00	15.00	100	10	2024-09-30 00:00:00
260	Agua bonafont 2lt.	\N	30	55	14.00	18.00	100	10	2024-09-30 00:00:00
261	Garrafon bonafont 20lt	\N	30	55	19.50	24.00	100	10	2024-09-30 00:00:00
262	Agua ciel 600ml	\N	30	16	8.00	13.00	100	10	2024-09-30 00:00:00
263	Agua ciel 1lt	\N	30	16	10.00	15.00	100	10	2024-09-30 00:00:00
264	Agua ciel 1.5l	\N	30	16	12.00	17.00	100	10	2024-09-30 00:00:00
265	Agua ciel 2lt	\N	30	16	14.00	20.00	100	10	2024-09-30 00:00:00
266	Agua E-pura 600ml	\N	30	14	8.00	13.00	100	10	2024-09-30 00:00:00
267	Agua E-pura 1lt	\N	30	14	10.00	15.00	100	10	2024-09-30 00:00:00
268	Garrafon E-pura 10lt	\N	30	14	18.00	25.00	100	10	2024-09-30 00:00:00
269	Crema Lala 200ml	\N	15	4	8.00	13.00	100	10	2024-09-30 00:00:00
270	Crema Lala 426ml	\N	15	4	15.00	30.00	100	10	2024-09-30 00:00:00
271	Crema Lala 900ml	\N	15	4	35.00	55.00	100	10	2024-09-30 00:00:00
272	Crema alpura 200ml	\N	15	4	8.00	13.00	100	10	2024-09-30 00:00:00
273	Crema alpura 426ml	\N	15	4	15.00	30.00	100	10	2024-09-30 00:00:00
274	Crema alpura 900ml	\N	15	4	35.00	55.00	100	10	2024-09-30 00:00:00
275	Atun dolores en agua	\N	6	51	10.00	15.00	100	10	2024-09-30 00:00:00
276	Atun dolores en aceite	\N	6	51	12.00	17.00	100	10	2024-09-30 00:00:00
277	Sardinas en aceite	\N	6	20	10.00	15.00	100	10	2024-09-30 00:00:00
278	Frijoles refritos	\N	6	50	10.00	15.00	100	10	2024-09-30 00:00:00
279	Frijoles bayos	\N	6	50	10.00	15.00	100	10	2024-09-30 00:00:00
280	Lentejas la moderna	\N	2	44	10.00	15.00	100	10	2024-09-30 00:00:00
281	Pasta la moderna	\N	2	44	10.00	15.00	100	10	2024-09-30 00:00:00
282	Coditos la moderna	\N	2	44	10.00	15.00	100	10	2024-09-30 00:00:00
283	Pasta Barilla espagueti	\N	2	56	10.00	15.00	100	10	2024-09-30 00:00:00
284	Sopa de letras la moderna	\N	2	44	10.00	15.00	100	10	2024-09-30 00:00:00
285	Sopa maruchan pollo	\N	2	57	10.00	15.00	100	10	2024-09-30 00:00:00
286	Sopa maruchan camaron	\N	2	57	10.00	15.00	100	10	2024-09-30 00:00:00
287	Sopa maruchan res	\N	2	57	10.00	15.00	100	10	2024-09-30 00:00:00
288	Sopa maruchan habanero	\N	2	57	10.00	15.00	100	10	2024-09-30 00:00:00
289	Sopa maruchan piquin	\N	2	57	10.00	15.00	100	10	2024-09-30 00:00:00
290	Sopa maruchan limon	\N	2	57	10.00	15.00	100	10	2024-09-30 00:00:00
291	Cremax vainilla	\N	29	46	8.00	10.50	100	10	2024-09-30 00:00:00
292	Cremax chocolate	\N	29	46	8.00	10.50	100	10	2024-09-30 00:00:00
293	Cremax fresa	\N	29	46	8.00	10.50	100	10	2024-09-30 00:00:00
294	Florentinas gamesa	\N	29	46	8.00	10.50	100	10	2024-09-30 00:00:00
295	Marias doradas	\N	29	46	8.00	10.50	100	10	2024-09-30 00:00:00
296	Gamesa cajeta	\N	29	46	8.00	10.50	100	10	2024-09-30 00:00:00
297	Maravillas gamesa	\N	29	46	8.00	10.50	100	10	2024-09-30 00:00:00
298	Crackets gamesa	\N	29	46	8.00	10.50	100	10	2024-09-30 00:00:00
299	Surtido rico gamesa	\N	29	46	8.00	10.50	100	10	2024-09-30 00:00:00
300	Delicias gamesa	\N	29	46	8.00	10.50	100	10	2024-09-30 00:00:00
301	Oreo	\N	9	58	8.00	10.50	100	10	2024-09-30 00:00:00
302	Principe chocolate	\N	9	22	8.00	10.50	100	10	2024-09-30 00:00:00
303	Principe vainilla	\N	9	22	8.00	10.50	100	10	2024-09-30 00:00:00
304	Principe limon	\N	9	22	8.00	10.50	100	10	2024-09-30 00:00:00
305	Principe chocolate blanco	\N	9	22	8.00	10.50	100	10	2024-09-30 00:00:00
306	Lors	\N	9	22	8.00	10.50	100	10	2024-09-30 00:00:00
307	Plativolos	\N	9	22	8.00	10.50	100	10	2024-09-30 00:00:00
308	Sponch	\N	9	22	8.00	10.50	100	10	2024-09-30 00:00:00
309	Triki trakes	\N	9	22	8.00	10.50	100	10	2024-09-30 00:00:00
310	MaxiTubo Triki trakes	\N	9	22	8.00	10.50	100	10	2024-09-30 00:00:00
311	Gansito	\N	9	22	8.00	10.50	100	10	2024-09-30 00:00:00
312	Pinguinos	\N	9	22	8.00	10.50	100	10	2024-09-30 00:00:00
313	Pasticetas marinela	\N	9	22	8.00	10.50	100	10	2024-09-30 00:00:00
314	Barritas fresa	\N	9	22	8.00	10.50	100	10	2024-09-30 00:00:00
315	Barritas pina	\N	9	22	8.00	10.50	100	10	2024-09-30 00:00:00
316	Barritas moras	\N	9	22	8.00	10.50	100	10	2024-09-30 00:00:00
317	Maxitubo Barritas fresa	\N	9	22	8.00	10.50	100	10	2024-09-30 00:00:00
318	Maxitubo Barritas pina	\N	9	22	8.00	10.50	100	10	2024-09-30 00:00:00
319	Canelitas	\N	9	22	8.00	10.50	100	10	2024-09-30 00:00:00
320	Polvorones	\N	9	22	8.00	10.50	100	10	2024-09-30 00:00:00
321	Maxitubo Polvorones	\N	9	22	8.00	10.50	100	10	2024-09-30 00:00:00
322	Ricanelas	\N	9	46	8.00	10.50	100	10	2024-09-30 00:00:00
323	Ritz bits queso	\N	9	58	8.00	10.50	100	10	2024-09-30 00:00:00
324	Arcoiris	\N	9	46	8.00	10.50	100	10	2024-09-30 00:00:00
325	Submarinos fresa	\N	9	22	8.00	10.50	100	10	2024-09-30 00:00:00
326	Submarinos vainilla	\N	9	22	8.00	10.50	100	10	2024-09-30 00:00:00
327	Submarinos chocolate	\N	9	22	8.00	10.50	100	10	2024-09-30 00:00:00
328	Rocko chico	\N	9	22	8.00	10.50	100	10	2024-09-30 00:00:00
329	Rocko grande	\N	9	22	8.00	10.50	100	10	2024-09-30 00:00:00
330	Sabritas original	\N	9	3	8.00	10.50	100	10	2024-09-30 00:00:00
331	Sabritas adobadas	\N	9	3	8.00	10.50	100	10	2024-09-30 00:00:00
332	Sabritas limon	\N	9	3	8.00	10.50	100	10	2024-09-30 00:00:00
333	Sabritas flamin hot	\N	9	3	8.00	10.50	100	10	2024-09-30 00:00:00
334	Sabritas crema y especias	\N	9	3	8.00	10.50	100	10	2024-09-30 00:00:00
335	Sabritas habanero	\N	9	3	8.00	10.50	100	10	2024-09-30 00:00:00
336	Sabritas receta crujiente	\N	9	3	8.00	10.50	100	10	2024-09-30 00:00:00
337	Sabritas receta crujiente jalapeno	\N	9	3	8.00	10.50	100	10	2024-09-30 00:00:00
338	Crujitos	\N	9	3	8.00	10.50	100	10	2024-09-30 00:00:00
339	Doritos nacho	\N	9	3	8.00	10.50	100	10	2024-09-30 00:00:00
340	Doritos incognita	\N	9	3	8.00	10.50	100	10	2024-09-30 00:00:00
341	Doritos diablo	\N	9	3	8.00	10.50	100	10	2024-09-30 00:00:00
342	Doritos flamin hot	\N	9	3	8.00	10.50	100	10	2024-09-30 00:00:00
343	Doritos dinamita	\N	9	3	8.00	10.50	100	10	2024-09-30 00:00:00
344	Sabritones	\N	9	3	8.00	10.50	100	10	2024-09-30 00:00:00
345	Bigmix queso	\N	9	47	8.00	10.50	100	10	2024-09-30 00:00:00
346	Bigmix fuego	\N	9	47	8.00	10.50	100	10	2024-09-30 00:00:00
347	Cheetos torciditos	\N	9	3	8.00	10.50	100	10	2024-09-30 00:00:00
348	Cheetos bolitas	\N	9	3	8.00	10.50	100	10	2024-09-30 00:00:00
349	Cheetos queso	\N	9	3	8.00	10.50	100	10	2024-09-30 00:00:00
350	Cheetos flamin hot	\N	9	3	8.00	10.50	100	10	2024-09-30 00:00:00
351	Ruffles original	\N	9	3	8.00	10.50	100	10	2024-09-30 00:00:00
352	Ruffles queso	\N	9	3	8.00	10.50	100	10	2024-09-30 00:00:00
353	Fritos sal y limon	\N	9	3	8.00	10.50	100	10	2024-09-30 00:00:00
354	Fritos chorizo	\N	9	3	8.00	10.50	100	10	2024-09-30 00:00:00
355	Bolsaza Sabritas original	\N	9	3	8.00	10.50	100	10	2024-09-30 00:00:00
356	Bolsaza Doritos nacho	\N	9	3	8.00	10.50	100	10	2024-09-30 00:00:00
357	Paketaxo	\N	9	3	8.00	10.50	100	10	2024-09-30 00:00:00
358	Paketaxo queso	\N	9	3	8.00	10.50	100	10	2024-09-30 00:00:00
359	Paketaxo flamin hot	\N	9	3	8.00	10.50	100	10	2024-09-30 00:00:00
360	Churrumaiz	\N	9	3	8.00	10.50	100	10	2024-09-30 00:00:00
361	Churrumaiz flamin hot	\N	9	3	8.00	10.50	100	10	2024-09-30 00:00:00
362	Rancheritos	\N	9	3	8.00	10.50	100	10	2024-09-30 00:00:00
363	Sabritas switch doritos nacho	\N	9	3	8.00	10.50	100	10	2024-09-30 00:00:00
364	Runners	\N	9	47	8.00	10.50	100	10	2024-09-30 00:00:00
365	Chips jalapeno	\N	9	47	8.00	10.50	100	10	2024-09-30 00:00:00
366	Chips sal	\N	9	47	8.00	10.50	100	10	2024-09-30 00:00:00
367	Papatinas	\N	9	47	8.00	10.50	100	10	2024-09-30 00:00:00
368	Chips fuego	\N	9	47	8.00	10.50	100	10	2024-09-30 00:00:00
369	Palomitas pop	\N	9	47	8.00	10.50	100	10	2024-09-30 00:00:00
370	Takis original 	\N	9	47	8.00	10.50	100	10	2024-09-30 00:00:00
371	Takis fuego	\N	9	47	8.00	10.50	100	10	2024-09-30 00:00:00
372	Takis salsa brava	\N	9	47	8.00	10.50	100	10	2024-09-30 00:00:00
373	Takis guacamole	\N	9	47	8.00	10.50	100	10	2024-09-30 00:00:00
374	Chipotles	\N	9	47	8.00	10.50	100	10	2024-09-30 00:00:00
375	Tostachos	\N	9	47	8.00	10.50	100	10	2024-09-30 00:00:00
376	Hot nuts	\N	9	47	8.00	10.50	100	10	2024-09-30 00:00:00
377	Hot nuts fuego	\N	9	47	8.00	10.50	100	10	2024-09-30 00:00:00
378	Valentones	\N	9	47	8.00	10.50	100	10	2024-09-30 00:00:00
379	Watz barcel	\N	9	47	8.00	10.50	100	10	2024-09-30 00:00:00
380	Toreadas	\N	9	47	8.00	10.50	100	10	2024-09-30 00:00:00
381	Palomitas pop fuego	\N	9	47	8.00	10.50	100	10	2024-09-30 00:00:00
382	Takis blue heat	\N	9	47	8.00	10.50	100	10	2024-09-30 00:00:00
383	Doraditas tia rosa	\N	29	49	8.00	10.50	100	10	2024-09-30 00:00:00
384	Bigote tia rosa	\N	29	49	8.00	10.50	100	10	2024-09-30 00:00:00
385	Tortillinas tia rosa	\N	10	49	8.00	10.50	100	10	2024-09-30 00:00:00
386	Magdalenas tia rosa	\N	29	49	8.00	10.50	100	10	2024-09-30 00:00:00
387	Conchas tia rosa	\N	29	49	8.00	10.50	100	10	2024-09-30 00:00:00
388	Hersheys Cookies n Cream	\N	8	45	8.00	10.50	100	10	2024-09-30 00:00:00
389	Hersheys almendras	\N	8	45	8.00	10.50	100	10	2024-09-30 00:00:00
390	Hersheys chocolate amargo	\N	8	45	8.00	10.50	100	10	2024-09-30 00:00:00
391	Hersheys chocolate blanco	\N	8	45	8.00	10.50	100	10	2024-09-30 00:00:00
392	Crunch	\N	8	19	8.00	10.50	100	10	2024-09-30 00:00:00
393	Carlos V	\N	8	19	8.00	10.50	100	10	2024-09-30 00:00:00
394	Milky way	\N	8	19	8.00	10.50	100	10	2024-09-30 00:00:00
395	Snickers	\N	8	19	8.00	10.50	100	10	2024-09-30 00:00:00
396	Kit kat	\N	8	19	8.00	10.50	100	10	2024-09-30 00:00:00
397	Kinder delice	\N	8	40	8.00	10.50	100	10	2024-09-30 00:00:00
398	Kinder sorpresa	\N	8	40	8.00	10.50	100	10	2024-09-30 00:00:00
399	Ferrero rocher 3 piezas	\N	8	40	8.00	10.50	100	10	2024-09-30 00:00:00
400	Mazapan	\N	8	62	8.00	10.50	100	10	2024-09-30 00:00:00
401	Pelon pelo rico	\N	8	45	8.00	10.50	100	10	2024-09-30 00:00:00
402	Pulparindo tamarindo	\N	8	62	8.00	10.50	100	10	2024-09-30 00:00:00
403	Pulparindo chamoy	\N	8	62	8.00	10.50	100	10	2024-09-30 00:00:00
404	Tutsi pop	\N	8	65	8.00	10.50	100	10	2024-09-30 00:00:00
405	Oblea cajeta coronado	\N	8	66	8.00	10.50	100	10	2024-09-30 00:00:00
406	Paleta payaso	\N	8	67	8.00	10.50	100	10	2024-09-30 00:00:00
407	Duvalin fresa vainilla	\N	8	67	8.00	10.50	100	10	2024-09-30 00:00:00
408	Duvalin chocolate vainilla	\N	8	67	8.00	10.50	100	10	2024-09-30 00:00:00
409	Duvalin vainilla	\N	8	67	8.00	10.50	100	10	2024-09-30 00:00:00
410	Duvalin trisabor	\N	8	67	8.00	10.50	100	10	2024-09-30 00:00:00
411	Duvalin choco avellana	\N	8	67	8.00	10.50	100	10	2024-09-30 00:00:00
412	Paleta Vero mango	\N	8	68	8.00	10.50	100	10	2024-09-30 00:00:00
413	Paleta Vero elote	\N	8	67	8.00	10.50	100	10	2024-09-30 00:00:00
414	Panditas	\N	8	67	8.00	10.50	100	10	2024-09-30 00:00:00
415	Panditas rellenos	\N	8	67	8.00	10.50	100	10	2024-09-30 00:00:00
416	Panditas san valentin	\N	8	67	8.00	10.50	100	10	2024-09-30 00:00:00
417	Bubulubu	\N	8	67	8.00	10.50	100	10	2024-09-30 00:00:00
418	Rockaleta	\N	8	69	8.00	10.50	100	10	2024-09-30 00:00:00
419	Tic tac menta	\N	8	40	8.00	10.50	100	10	2024-09-30 00:00:00
420	Tic tac naranja	\N	8	40	8.00	10.50	100	10	2024-09-30 00:00:00
421	Halls menta	\N	8	58	8.00	10.50	100	10	2024-09-30 00:00:00
422	Halls limon	\N	8	58	8.00	10.50	100	10	2024-09-30 00:00:00
423	Halls yerba buena	\N	8	58	8.00	10.50	100	10	2024-09-30 00:00:00
424	Halls miel	\N	8	58	8.00	10.50	100	10	2024-09-30 00:00:00
425	Halls negras	\N	8	58	8.00	10.50	100	10	2024-09-30 00:00:00
426	Gomilocas dientes	\N	8	67	8.00	10.50	100	10	2024-09-30 00:00:00
427	Gomilocas pinguino	\N	8	67	8.00	10.50	100	10	2024-09-30 00:00:00
428	Chocoretas	\N	8	67	8.00	10.50	100	10	2024-09-30 00:00:00
429	Kranky	\N	8	67	8.00	10.50	100	10	2024-09-30 00:00:00
430	Lucas muecas	\N	8	58	8.00	10.50	100	10	2024-09-30 00:00:00
431	Lucas chamoy	\N	8	58	8.00	10.50	100	10	2024-09-30 00:00:00
432	Lucas gusanito	\N	8	58	8.00	10.50	100	10	2024-09-30 00:00:00
433	Palomitas Act II mantequilla	\N	9	58	8.00	10.50	100	10	2024-09-30 00:00:00
434	Palomitas Act II natural	\N	9	58	8.00	10.50	100	10	2024-09-30 00:00:00
435	Palomitas Act II chile limon	\N	9	58	8.00	10.50	100	10	2024-09-30 00:00:00
436	Tostitos salsa verde	\N	9	3	8.00	10.50	100	10	2024-09-30 00:00:00
437	Zucaritas chicas	\N	5	26	8.00	10.50	100	10	2024-09-30 00:00:00
438	Zucaritas grandes	\N	5	26	8.00	10.50	100	10	2024-09-30 00:00:00
439	Corn flakes chicas	\N	5	26	8.00	10.50	100	10	2024-09-30 00:00:00
440	Corn flakes grandes	\N	5	26	8.00	10.50	100	10	2024-09-30 00:00:00
441	Choco Krispis chicas	\N	5	26	8.00	10.50	100	10	2024-09-30 00:00:00
442	Choco Krispis grandes	\N	5	26	8.00	10.50	100	10	2024-09-30 00:00:00
443	Nesquik chico	\N	5	26	8.00	10.50	100	10	2024-09-30 00:00:00
444	Nesquik grande	\N	5	26	8.00	10.50	100	10	2024-09-30 00:00:00
445	Froot loops chicas	\N	5	26	8.00	10.50	100	10	2024-09-30 00:00:00
446	Froot loops grandes	\N	5	26	8.00	10.50	100	10	2024-09-30 00:00:00
447	Chocomilk sobre	\N	4	58	8.00	10.50	100	10	2024-09-30 00:00:00
448	Chocomilk bolsa	\N	4	58	8.00	10.50	100	10	2024-09-30 00:00:00
449	Chocomilk lata	\N	4	58	8.00	10.50	100	10	2024-09-30 00:00:00
450	Nescafe clasico sobre	\N	4	19	8.00	10.50	100	10	2024-09-30 00:00:00
451	Nescafe capuccino sobre	\N	4	19	8.00	10.50	100	10	2024-09-30 00:00:00
452	Nescafe clasico bote chico	\N	4	19	8.00	10.50	100	10	2024-09-30 00:00:00
453	Nescafe clasico bote grande	\N	4	19	8.00	10.50	100	10	2024-09-30 00:00:00
454	Azucar Zulka 1kg	\N	3	58	8.00	10.50	100	10	2024-09-30 00:00:00
455	Azucar refinada 1kg	\N	3	58	8.00	10.50	100	10	2024-09-30 00:00:00
456	Azucar refinada 500gr	\N	3	58	8.00	10.50	100	10	2024-09-30 00:00:00
457	Azucar refinada 250gr	\N	3	58	8.00	10.50	100	10	2024-09-30 00:00:00
458	Aceite nutrioli 1lt	\N	1	58	8.00	10.50	100	10	2024-09-30 00:00:00
459	Aceite capullo 1lt	\N	1	58	8.00	10.50	100	10	2024-09-30 00:00:00
460	Aceite 1 2 3 1lt	\N	1	58	8.00	10.50	100	10	2024-09-30 00:00:00
461	Aceite patrona 1lt	\N	1	58	8.00	10.50	100	10	2024-09-30 00:00:00
462	Vinagre blanco la coste¤a	\N	1	27	8.00	10.50	100	10	2024-09-30 00:00:00
463	Vinagre de manzana la coste¤a	\N	1	27	8.00	10.50	100	10	2024-09-30 00:00:00
464	Catsup la coste¤a	\N	1	27	8.00	10.50	100	10	2024-09-30 00:00:00
465	Catsup Del monte	\N	1	70	8.00	10.50	100	10	2024-09-30 00:00:00
466	Catsup heinz	\N	1	71	8.00	10.50	100	10	2024-09-30 00:00:00
467	Jugo Magui	\N	7	19	8.00	10.50	100	10	2024-09-30 00:00:00
468	Salsa inglesa	\N	7	19	8.00	10.50	100	10	2024-09-30 00:00:00
469	Salsa valentina chica	\N	7	58	8.00	10.50	100	10	2024-09-30 00:00:00
470	Salsa valentina grande	\N	7	58	8.00	10.50	100	10	2024-09-30 00:00:00
471	Salsa tabasco	\N	7	58	8.00	10.50	100	10	2024-09-30 00:00:00
472	Salsa buffalo	\N	7	58	8.00	10.50	100	10	2024-09-30 00:00:00
473	Salsa chipotle la coste¤a	\N	7	27	8.00	10.50	100	10	2024-09-30 00:00:00
474	Chile chipotle la coste¤a	\N	6	27	8.00	10.50	100	10	2024-09-30 00:00:00
475	Chiles serranos la coste¤a	\N	6	27	8.00	10.50	100	10	2024-09-30 00:00:00
476	Chiles en vinagre la coste¤a	\N	6	27	8.00	10.50	100	10	2024-09-30 00:00:00
477	Chile chipotle la morena	\N	6	72	8.00	10.50	100	10	2024-09-30 00:00:00
478	Chiles en vinagre la morena	\N	6	72	8.00	10.50	100	10	2024-09-30 00:00:00
479	Mayonesa mccormick chica	\N	7	72	8.00	10.50	100	10	2024-09-30 00:00:00
480	Mayonesa mccormick grande	\N	7	72	8.00	10.50	100	10	2024-09-30 00:00:00
481	Mostaza mccormick	\N	7	72	8.00	10.50	100	10	2024-09-30 00:00:00
482	Mermelada mccormick fresa chica	\N	19	72	8.00	10.50	100	10	2024-09-30 00:00:00
483	Mermelada mccormick fresa grande	\N	19	72	8.00	10.50	100	10	2024-09-30 00:00:00
484	Cloralex 1/2 lt	\N	35	58	8.00	10.50	100	10	2024-09-30 00:00:00
485	Cloralex 1 lt	\N	35	58	8.00	10.50	100	10	2024-09-30 00:00:00
486	Pinol	\N	35	58	8.00	10.50	100	10	2024-09-30 00:00:00
487	Fabuloso lavanda 1lt	\N	35	58	8.00	10.50	100	10	2024-09-30 00:00:00
488	Fabuloso aroma floral 1lt	\N	35	58	8.00	10.50	100	10	2024-09-30 00:00:00
489	Jab¢n zote rosa chico	\N	42	58	8.00	10.50	100	10	2024-09-30 00:00:00
490	Jab¢n zote rosa grande	\N	42	58	8.00	10.50	100	10	2024-09-30 00:00:00
491	Jab¢n zote blanco chico	\N	42	58	8.00	10.50	100	10	2024-09-30 00:00:00
492	Jab¢n zote blanco grande	\N	42	58	8.00	10.50	100	10	2024-09-30 00:00:00
493	Detergente Ariel 1/2 kg	\N	34	58	8.00	10.50	100	10	2024-09-30 00:00:00
494	Detergente Ariel 1kg	\N	34	58	8.00	10.50	100	10	2024-09-30 00:00:00
495	Detergente Ace 1/2 kg	\N	34	58	8.00	10.50	100	10	2024-09-30 00:00:00
496	Detergente Ace 1kg	\N	34	58	8.00	10.50	100	10	2024-09-30 00:00:00
497	Detergente Foca 1/2 kg	\N	34	58	8.00	10.50	100	10	2024-09-30 00:00:00
498	Detergente Foca 1kg	\N	34	58	8.00	10.50	100	10	2024-09-30 00:00:00
499	Suavitel 1l	\N	34	58	8.00	10.50	100	10	2024-09-30 00:00:00
500	Papel higienico Petalo 4 rollos	\N	37	58	8.00	10.50	100	10	2024-09-30 00:00:00
501	Papel higienico Petalo 6 rollos	\N	37	58	8.00	10.50	100	10	2024-09-30 00:00:00
502	Papel higienico Suavel 4 rollos	\N	37	58	8.00	10.50	100	10	2024-09-30 00:00:00
503	Papel higienico Suavel 6 rollos	\N	37	58	8.00	10.50	100	10	2024-09-30 00:00:00
504	Toallas sanitarias Always	\N	37	58	8.00	10.50	100	10	2024-09-30 00:00:00
505	Toallas sanitarias Kotex	\N	37	58	8.00	10.50	100	10	2024-09-30 00:00:00
506	Pa¤ales Huggies	\N	44	58	8.00	10.50	100	10	2024-09-30 00:00:00
507	Shampoo Head & Shoulders chico	\N	39	58	8.00	10.50	100	10	2024-09-30 00:00:00
508	Shampoo Head & Shoulders grande	\N	39	58	8.00	10.50	100	10	2024-09-30 00:00:00
509	Desodorante Axe	\N	41	58	8.00	10.50	100	10	2024-09-30 00:00:00
510	Harina de maiz maseca	\N	10	59	8.00	10.50	100	10	2024-10-01 00:00:00
511	Harina de trigo San antonio	\N	10	41	8.00	10.50	100	10	2024-10-01 00:00:00
512	Tortillas de maiz 1/2 kg	\N	10	58	8.00	10.50	100	10	2024-10-01 00:00:00
513	Pan bimbo blanco chico	\N	27	17	8.00	10.50	100	10	2024-10-01 00:00:00
514	Pan bimbo blanco grande	\N	27	17	8.00	10.50	100	10	2024-10-01 00:00:00
515	Pan bimbo integral chico	\N	27	17	8.00	10.50	100	10	2024-10-01 00:00:00
516	Pan bimbo integral grande	\N	27	17	8.00	10.50	100	10	2024-10-01 00:00:00
517	Rebanadas bimbo	\N	27	17	8.00	10.50	100	10	2024-10-01 00:00:00
518	Chocoroles	\N	27	17	8.00	10.50	100	10	2024-10-01 00:00:00
519	Nito bimbo	\N	27	17	8.00	10.50	100	10	2024-10-01 00:00:00
520	Mantecadas	\N	27	17	8.00	10.50	100	10	2024-10-01 00:00:00
521	Roles de canela con pasas	\N	27	17	8.00	10.50	100	10	2024-10-01 00:00:00
522	Roles de canela glaseados	\N	27	17	8.00	10.50	100	10	2024-10-01 00:00:00
523	Conchas bimbo	\N	27	17	8.00	10.50	100	10	2024-10-01 00:00:00
524	Panque de nuez bimbo	\N	27	17	8.00	10.50	100	10	2024-10-01 00:00:00
525	Donitas bimbo	\N	27	17	8.00	10.50	100	10	2024-10-01 00:00:00
526	Donitas espolvoreadas bimbo	\N	27	17	8.00	10.50	100	10	2024-10-01 00:00:00
527	chimichangas	chimichangas	23	10	30.00	45.00	15	5	2024-10-01 00:00:00
528	Roles	Ricos roles de canela caseros	27	13	70.00	100.00	19	10	2024-10-01 00:00:00
529	Pepsi	bebida azucarada	31	14	8.00	16.00	77	20	2024-10-01 00:00:00
530	Manzanita		31	14	17.00	25.00	22	3	2024-10-01 00:00:00
531	Palillos	Palillos de madera	38	15	8.50	13.00	13	4	2024-10-01 00:00:00
532	MaruchanTokyo	maruchan picante	2	11	5.50	12.50	15	10	2024-10-01 00:00:00
533	Sabritas	Sabritas Flamin Hot	9	3	10.00	18.00	4	1	2024-10-01 00:00:00
534	Galletas marias	Las galletas clasicas	9	3	8.90	15.00	19	2	2024-10-01 00:00:00
535	Leche entera lala 1lt	Clasica color roja	15	4	15.24	25.00	11	3	2024-10-01 00:00:00
536	Leche Lala entera 1L	Leche Lala entera 1 Litro	15	4	19.00	24.00	100	10	2024-10-01 00:00:00
537	Tostadas charras	\N	5	60	8.00	10.50	100	10	2024-10-01 00:00:00
538	Coca Cola 1L	Refresco Coca Cola 1 Litro	31	16	12.00	15.00	100	10	2024-10-01 00:00:00
539	Coca Cola lata 355ml	Refresco Coca Cola 355 ml lata	31	16	8.50	11.00	100	10	2024-10-01 00:00:00
540	Coca Cola 355ml	Refresco Coca Cola 355 ml	31	16	8.00	10.50	100	10	2024-10-01 00:00:00
541	Coca Cola 600ml	Refresco Coca Cola 600 ml	31	16	9.00	12.00	100	10	2024-10-01 00:00:00
542	Coca Cola retornable 1 1/4 lt.	Refresco Coca Cola retornable 1 1/4 lt	31	16	12.50	15.50	100	10	2024-10-01 00:00:00
543	Coca Cola 2L retornable	Refresco Coca Cola retornable 2 Litros	31	16	19.50	24.00	100	10	2024-10-01 00:00:00
544	Coca Cola 3L retornable	Refresco Coca Cola retornable 3 Litros	31	16	24.00	30.00	100	10	2024-10-01 00:00:00
545	Coca Cola Light 600ml	Refresco Coca Cola Light 600 ml	31	16	9.50	12.50	100	10	2024-10-01 00:00:00
546	Pepsi 600ml	Refresco Pepsi 600 ml	31	14	9.00	12.00	100	10	2024-10-01 00:00:00
547	Pepsi 1.5L	Refresco Pepsi 1.5 Litros	31	14	12.00	15.50	100	10	2024-10-01 00:00:00
548	Fanta 600ml	Refresco Fanta 600 ml	31	16	9.00	12.00	100	10	2024-10-01 00:00:00
549	Fanta 1.5L	Refresco Fanta 1.5 Litros	31	16	12.50	16.00	100	10	2024-10-01 00:00:00
550	Sprite 600ml	Refresco Sprite 600 ml	31	16	9.00	12.00	100	10	2024-10-01 00:00:00
551	Sprite 1.5L	Refresco Sprite 1.5 Litros	31	16	12.50	16.00	100	10	2024-10-01 00:00:00
552	Manzanita 600ml	Refresco Manzanita Sol 600 ml	31	16	9.00	12.00	100	10	2024-10-01 00:00:00
553	Manzanita 1.5L	Refresco Manzanita Sol 1.5 Litros	31	16	12.50	16.00	100	10	2024-10-01 00:00:00
554	Fresca 600ml	Refresco Fresca 600 ml	31	16	9.00	12.00	100	10	2024-10-01 00:00:00
555	Fresca 3L	Refresco Fresca 3 Litros	31	16	24.00	30.00	100	10	2024-10-01 00:00:00
556	Mirinda 600ml	Refresco Mirinda 600 ml	31	16	9.00	12.00	100	10	2024-10-01 00:00:00
557	Mirinda 1.5L	Refresco Mirinda 1.5 Litros	31	16	12.50	16.00	100	10	2024-10-01 00:00:00
558	Tostadas Sanissimo	\N	5	61	8.00	10.50	100	10	2024-10-01 00:00:00
559	Marias gamesa	\N	29	46	8.00	10.50	100	10	2024-10-01 00:00:00
560	Jumex de mango 1L	Jugo Jumex sabor Mango 1 Litro	31	21	16.00	20.00	100	10	2024-10-01 00:00:00
561	Emperador chocolate	\N	29	46	8.00	10.50	100	10	2024-10-01 00:00:00
562	Emperador nuez	\N	29	46	8.00	10.50	100	10	2024-10-01 00:00:00
563	Emperador vainilla	\N	29	46	8.00	10.50	100	10	2024-10-01 00:00:00
564	Emperador limon	\N	29	46	8.00	10.50	100	10	2024-10-01 00:00:00
565	Jumex de durazno 1L	Jugo Jumex sabor Durazno 1 Litro	31	21	16.00	20.00	100	10	2024-10-01 00:00:00
566	Jumex de manzana 600ml	Jugo Jumex sabor Manzana 600 ml	31	21	10.00	13.00	100	10	2024-10-01 00:00:00
567	Del Valle fruit naranja 600ml	Jugo Del Valle sabor Naranja 600 ml	31	28	10.50	13.50	100	10	2024-10-01 00:00:00
568	Del Valle fruit manzana 600ml	Jugo Del Valle sabor Manzana 600 ml	31	28	10.50	13.50	100	10	2024-10-01 00:00:00
569	Del Valle fruit guayaba 600ml	Jugo Del Valle sabor Guayaba 600 ml	31	28	10.50	13.50	100	10	2024-10-01 00:00:00
570	Emperador Senso	\N	29	46	8.00	10.50	100	10	2024-10-01 00:00:00
571	Mamut chico	\N	29	46	8.00	10.50	100	10	2024-10-01 00:00:00
572	Yogurt Lala natural 1L	Yogurt Lala natural 1 Litro	17	4	25.00	30.00	100	10	2024-10-01 00:00:00
573	Yogurt Lala de fresa 1L	Yogurt Lala sabor Fresa 1 Litro	17	4	25.00	30.00	100	10	2024-10-01 00:00:00
574	Yogurt Yoplait natural 1L	Yogurt Yoplait natural 1 Litro	17	54	26.00	31.00	100	10	2024-10-01 00:00:00
575	Yogurt Yoplait de fresa 1L	Yogurt Yoplait sabor Fresa 1 Litro	17	54	26.00	31.00	100	10	2024-10-01 00:00:00
576	Mantequilla Lala 250g	Mantequilla Lala 250 gramos	19	4	30.00	38.00	100	10	2024-10-01 00:00:00
577	Queso panela Lala 200g	Queso panela Lala 200 gramos	16	4	40.00	50.00	100	10	2024-10-01 00:00:00
578	Mamut grande	\N	29	46	8.00	10.50	100	10	2024-10-01 00:00:00
579	Chokis	\N	29	46	8.00	10.50	100	10	2024-10-01 00:00:00
580	Chokis rellenas	\N	29	46	8.00	10.50	100	10	2024-10-01 00:00:00
581	Chokis doble chocolate	\N	29	46	8.00	10.50	100	10	2024-10-01 00:00:00
582	Chokis brownie	\N	29	46	8.00	10.50	100	10	2024-10-01 00:00:00
583	Leche Lala deslactosada 1L	Leche Lala deslactosada 1 Litro	15	4	20.00	25.00	100	10	2024-10-01 00:00:00
584	Leche Lala light 1L	Leche Lala light 1 Litro	15	4	20.00	25.00	100	10	2024-10-01 00:00:00
585	Leche Santa Clara entera 1L	Leche Santa Clara entera 1 Litro	15	4	22.00	28.00	100	10	2024-10-01 00:00:00
586	Leche Santa Clara deslactosada 1L	Leche Santa Clara deslactosada 1 Litro	15	4	23.00	29.00	100	10	2024-10-01 00:00:00
587	Arroz Mexica 1kg	None	2	59	12.00	16.50	100	10	2024-10-01 00:00:00
588	Queso panela Alpura 200g	Queso panela Alpura 200 gramos	16	18	40.00	50.00	100	10	2024-10-01 00:00:00
589	Queso oaxaca Lala 200g	Queso Oaxaca Lala 200 gramos	16	4	45.00	55.00	100	10	2024-10-01 00:00:00
590	Queso manchego Lala 200g	Queso Manchego Lala 200 gramos	16	4	50.00	60.00	100	10	2024-10-01 00:00:00
591	Salchichas Fud paquete 500g	Salchichas Fud 500 gramos	18	53	30.00	40.00	100	10	2024-10-01 00:00:00
592	Salchichas San Rafael paquete 500g	Salchichas San Rafael 500 gramos	18	52	35.00	45.00	100	10	2024-10-01 00:00:00
593	Jam¢n de pavo Fud 250g	Jam¢n de Pavo Fud 250 gramos	18	53	35.00	45.00	100	10	2024-10-01 00:00:00
594	Jam¢n de pavo San Rafael 250g	Jam¢n de Pavo San Rafael 250 gramos	18	52	40.00	50.00	100	10	2024-10-01 00:00:00
595	Sidral mundet 600ml	Refresco de manzana de 600ml	31	16	10.00	16.00	20	5	2024-10-01 00:00:00
596	Sidral mundet 3lt	Refresco de manzana de 3lt	31	16	24.00	30.00	20	5	2024-10-01 00:00:00
597	Agua bonafont 600ml	\N	30	55	8.00	10.50	100	10	2024-10-01 00:00:00
598	Agua bonafont 1lt	\N	30	55	12.00	15.00	100	10	2024-10-01 00:00:00
599	Agua bonafont 2lt.	\N	30	55	14.00	18.00	100	10	2024-10-01 00:00:00
600	Garrafon bonafont 20lt	\N	30	55	19.50	24.00	100	10	2024-10-01 00:00:00
601	Agua ciel 600ml	\N	30	16	8.00	13.00	100	10	2024-10-01 00:00:00
602	Agua ciel 1lt	\N	30	16	10.00	15.00	100	10	2024-10-01 00:00:00
603	Agua ciel 1.5l	\N	30	16	12.00	17.00	100	10	2024-10-01 00:00:00
604	Agua ciel 2lt	\N	30	16	14.00	20.00	100	10	2024-10-01 00:00:00
605	Agua E-pura 600ml	\N	30	14	8.00	13.00	100	10	2024-10-01 00:00:00
606	Agua E-pura 1lt	\N	30	14	10.00	15.00	100	10	2024-10-01 00:00:00
607	Garrafon E-pura 10lt	\N	30	14	18.00	25.00	100	10	2024-10-01 00:00:00
608	Crema Lala 200ml	\N	15	4	8.00	13.00	100	10	2024-10-01 00:00:00
609	Crema Lala 426ml	\N	15	4	15.00	30.00	100	10	2024-10-01 00:00:00
610	Crema Lala 900ml	\N	15	4	35.00	55.00	100	10	2024-10-01 00:00:00
611	Crema alpura 200ml	\N	15	4	8.00	13.00	100	10	2024-10-01 00:00:00
612	Crema alpura 426ml	\N	15	4	15.00	30.00	100	10	2024-10-01 00:00:00
613	Crema alpura 900ml	\N	15	4	35.00	55.00	100	10	2024-10-01 00:00:00
614	Atun dolores en agua	\N	6	51	10.00	15.00	100	10	2024-10-01 00:00:00
615	Atun dolores en aceite	\N	6	51	12.00	17.00	100	10	2024-10-01 00:00:00
616	Sardinas en aceite	\N	6	20	10.00	15.00	100	10	2024-10-01 00:00:00
617	Frijoles refritos	\N	6	50	10.00	15.00	100	10	2024-10-01 00:00:00
618	Frijoles bayos	\N	6	50	10.00	15.00	100	10	2024-10-01 00:00:00
619	Lentejas la moderna	\N	2	44	10.00	15.00	100	10	2024-10-01 00:00:00
620	Pasta la moderna	\N	2	44	10.00	15.00	100	10	2024-10-01 00:00:00
621	Coditos la moderna	\N	2	44	10.00	15.00	100	10	2024-10-01 00:00:00
622	Pasta Barilla espagueti	\N	2	56	10.00	15.00	100	10	2024-10-01 00:00:00
623	Sopa de letras la moderna	\N	2	44	10.00	15.00	100	10	2024-10-01 00:00:00
624	Sopa maruchan pollo	\N	2	57	10.00	15.00	100	10	2024-10-01 00:00:00
625	Sopa maruchan camaron	\N	2	57	10.00	15.00	100	10	2024-10-01 00:00:00
626	Sopa maruchan res	\N	2	57	10.00	15.00	100	10	2024-10-01 00:00:00
627	Sopa maruchan habanero	\N	2	57	10.00	15.00	100	10	2024-10-01 00:00:00
628	Sopa maruchan piquin	\N	2	57	10.00	15.00	100	10	2024-10-01 00:00:00
629	Sopa maruchan limon	\N	2	57	10.00	15.00	100	10	2024-10-01 00:00:00
630	Cremax vainilla	\N	29	46	8.00	10.50	100	10	2024-10-01 00:00:00
631	Cremax chocolate	\N	29	46	8.00	10.50	100	10	2024-10-01 00:00:00
632	Cremax fresa	\N	29	46	8.00	10.50	100	10	2024-10-01 00:00:00
633	Florentinas gamesa	\N	29	46	8.00	10.50	100	10	2024-10-01 00:00:00
634	Marias doradas	\N	29	46	8.00	10.50	100	10	2024-10-01 00:00:00
635	Gamesa cajeta	\N	29	46	8.00	10.50	100	10	2024-10-01 00:00:00
636	Maravillas gamesa	\N	29	46	8.00	10.50	100	10	2024-10-01 00:00:00
637	Crackets gamesa	\N	29	46	8.00	10.50	100	10	2024-10-01 00:00:00
638	Surtido rico gamesa	\N	29	46	8.00	10.50	100	10	2024-10-01 00:00:00
639	Delicias gamesa	\N	29	46	8.00	10.50	100	10	2024-10-01 00:00:00
640	Oreo	\N	9	58	8.00	10.50	100	10	2024-10-01 00:00:00
641	Principe chocolate	\N	9	22	8.00	10.50	100	10	2024-10-01 00:00:00
642	Principe vainilla	\N	9	22	8.00	10.50	100	10	2024-10-01 00:00:00
643	Principe limon	\N	9	22	8.00	10.50	100	10	2024-10-01 00:00:00
644	Principe chocolate blanco	\N	9	22	8.00	10.50	100	10	2024-10-01 00:00:00
645	Lors	\N	9	22	8.00	10.50	100	10	2024-10-01 00:00:00
646	Plativolos	\N	9	22	8.00	10.50	100	10	2024-10-01 00:00:00
647	Sponch	\N	9	22	8.00	10.50	100	10	2024-10-01 00:00:00
648	Triki trakes	\N	9	22	8.00	10.50	100	10	2024-10-01 00:00:00
649	MaxiTubo Triki trakes	\N	9	22	8.00	10.50	100	10	2024-10-01 00:00:00
650	Gansito	\N	9	22	8.00	10.50	100	10	2024-10-01 00:00:00
651	Pinguinos	\N	9	22	8.00	10.50	100	10	2024-10-01 00:00:00
652	Pasticetas marinela	\N	9	22	8.00	10.50	100	10	2024-10-01 00:00:00
653	Barritas fresa	\N	9	22	8.00	10.50	100	10	2024-10-01 00:00:00
654	Barritas pina	\N	9	22	8.00	10.50	100	10	2024-10-01 00:00:00
655	Barritas moras	\N	9	22	8.00	10.50	100	10	2024-10-01 00:00:00
656	Maxitubo Barritas fresa	\N	9	22	8.00	10.50	100	10	2024-10-01 00:00:00
657	Maxitubo Barritas pina	\N	9	22	8.00	10.50	100	10	2024-10-01 00:00:00
658	Canelitas	\N	9	22	8.00	10.50	100	10	2024-10-01 00:00:00
659	Polvorones	\N	9	22	8.00	10.50	100	10	2024-10-01 00:00:00
660	Maxitubo Polvorones	\N	9	22	8.00	10.50	100	10	2024-10-01 00:00:00
661	Ricanelas	\N	9	46	8.00	10.50	100	10	2024-10-01 00:00:00
662	Ritz bits queso	\N	9	58	8.00	10.50	100	10	2024-10-01 00:00:00
663	Arcoiris	\N	9	46	8.00	10.50	100	10	2024-10-01 00:00:00
664	Submarinos fresa	\N	9	22	8.00	10.50	100	10	2024-10-01 00:00:00
665	Submarinos vainilla	\N	9	22	8.00	10.50	100	10	2024-10-01 00:00:00
666	Submarinos chocolate	\N	9	22	8.00	10.50	100	10	2024-10-01 00:00:00
667	Rocko chico	\N	9	22	8.00	10.50	100	10	2024-10-01 00:00:00
668	Rocko grande	\N	9	22	8.00	10.50	100	10	2024-10-01 00:00:00
669	Sabritas original	\N	9	3	8.00	10.50	100	10	2024-10-01 00:00:00
670	Sabritas adobadas	\N	9	3	8.00	10.50	100	10	2024-10-01 00:00:00
671	Sabritas limon	\N	9	3	8.00	10.50	100	10	2024-10-01 00:00:00
672	Sabritas flamin hot	\N	9	3	8.00	10.50	100	10	2024-10-01 00:00:00
673	Sabritas crema y especias	\N	9	3	8.00	10.50	100	10	2024-10-01 00:00:00
674	Sabritas habanero	\N	9	3	8.00	10.50	100	10	2024-10-01 00:00:00
675	Sabritas receta crujiente	\N	9	3	8.00	10.50	100	10	2024-10-01 00:00:00
676	Sabritas receta crujiente jalapeno	\N	9	3	8.00	10.50	100	10	2024-10-01 00:00:00
677	Crujitos	\N	9	3	8.00	10.50	100	10	2024-10-01 00:00:00
678	Doritos nacho	\N	9	3	8.00	10.50	100	10	2024-10-01 00:00:00
679	Doritos incognita	\N	9	3	8.00	10.50	100	10	2024-10-01 00:00:00
680	Doritos diablo	\N	9	3	8.00	10.50	100	10	2024-10-01 00:00:00
681	Doritos flamin hot	\N	9	3	8.00	10.50	100	10	2024-10-01 00:00:00
682	Doritos dinamita	\N	9	3	8.00	10.50	100	10	2024-10-01 00:00:00
683	Sabritones	\N	9	3	8.00	10.50	100	10	2024-10-01 00:00:00
684	Bigmix queso	\N	9	47	8.00	10.50	100	10	2024-10-01 00:00:00
685	Bigmix fuego	\N	9	47	8.00	10.50	100	10	2024-10-01 00:00:00
686	Cheetos torciditos	\N	9	3	8.00	10.50	100	10	2024-10-01 00:00:00
687	Cheetos bolitas	\N	9	3	8.00	10.50	100	10	2024-10-01 00:00:00
688	Cheetos queso	\N	9	3	8.00	10.50	100	10	2024-10-01 00:00:00
689	Cheetos flamin hot	\N	9	3	8.00	10.50	100	10	2024-10-01 00:00:00
690	Ruffles original	\N	9	3	8.00	10.50	100	10	2024-10-01 00:00:00
691	Ruffles queso	\N	9	3	8.00	10.50	100	10	2024-10-01 00:00:00
692	Fritos sal y limon	\N	9	3	8.00	10.50	100	10	2024-10-01 00:00:00
693	Fritos chorizo	\N	9	3	8.00	10.50	100	10	2024-10-01 00:00:00
694	Bolsaza Sabritas original	\N	9	3	8.00	10.50	100	10	2024-10-01 00:00:00
695	Bolsaza Doritos nacho	\N	9	3	8.00	10.50	100	10	2024-10-01 00:00:00
696	Paketaxo	\N	9	3	8.00	10.50	100	10	2024-10-01 00:00:00
697	Paketaxo queso	\N	9	3	8.00	10.50	100	10	2024-10-01 00:00:00
698	Paketaxo flamin hot	\N	9	3	8.00	10.50	100	10	2024-10-01 00:00:00
699	Churrumaiz	\N	9	3	8.00	10.50	100	10	2024-10-01 00:00:00
700	Churrumaiz flamin hot	\N	9	3	8.00	10.50	100	10	2024-10-01 00:00:00
701	Rancheritos	\N	9	3	8.00	10.50	100	10	2024-10-01 00:00:00
702	Sabritas switch doritos nacho	\N	9	3	8.00	10.50	100	10	2024-10-01 00:00:00
703	Runners	\N	9	47	8.00	10.50	100	10	2024-10-01 00:00:00
704	Chips jalapeno	\N	9	47	8.00	10.50	100	10	2024-10-01 00:00:00
705	Chips sal	\N	9	47	8.00	10.50	100	10	2024-10-01 00:00:00
706	Papatinas	\N	9	47	8.00	10.50	100	10	2024-10-01 00:00:00
707	Chips fuego	\N	9	47	8.00	10.50	100	10	2024-10-01 00:00:00
708	Palomitas pop	\N	9	47	8.00	10.50	100	10	2024-10-01 00:00:00
709	Takis original 	\N	9	47	8.00	10.50	100	10	2024-10-01 00:00:00
710	Takis fuego	\N	9	47	8.00	10.50	100	10	2024-10-01 00:00:00
711	Takis salsa brava	\N	9	47	8.00	10.50	100	10	2024-10-01 00:00:00
712	Takis guacamole	\N	9	47	8.00	10.50	100	10	2024-10-01 00:00:00
713	Chipotles	\N	9	47	8.00	10.50	100	10	2024-10-01 00:00:00
714	Tostachos	\N	9	47	8.00	10.50	100	10	2024-10-01 00:00:00
715	Hot nuts	\N	9	47	8.00	10.50	100	10	2024-10-01 00:00:00
716	Hot nuts fuego	\N	9	47	8.00	10.50	100	10	2024-10-01 00:00:00
717	Valentones	\N	9	47	8.00	10.50	100	10	2024-10-01 00:00:00
718	Watz barcel	\N	9	47	8.00	10.50	100	10	2024-10-01 00:00:00
719	Toreadas	\N	9	47	8.00	10.50	100	10	2024-10-01 00:00:00
720	Palomitas pop fuego	\N	9	47	8.00	10.50	100	10	2024-10-01 00:00:00
721	Takis blue heat	\N	9	47	8.00	10.50	100	10	2024-10-01 00:00:00
722	Doraditas tia rosa	\N	29	49	8.00	10.50	100	10	2024-10-01 00:00:00
723	Bigote tia rosa	\N	29	49	8.00	10.50	100	10	2024-10-01 00:00:00
724	Tortillinas tia rosa	\N	10	49	8.00	10.50	100	10	2024-10-01 00:00:00
725	Magdalenas tia rosa	\N	29	49	8.00	10.50	100	10	2024-10-01 00:00:00
726	Conchas tia rosa	\N	29	49	8.00	10.50	100	10	2024-10-01 00:00:00
727	Hersheys Cookies n Cream	\N	8	45	8.00	10.50	100	10	2024-10-01 00:00:00
728	Hersheys almendras	\N	8	45	8.00	10.50	100	10	2024-10-01 00:00:00
729	Hersheys chocolate amargo	\N	8	45	8.00	10.50	100	10	2024-10-01 00:00:00
730	Hersheys chocolate blanco	\N	8	45	8.00	10.50	100	10	2024-10-01 00:00:00
731	Crunch	\N	8	19	8.00	10.50	100	10	2024-10-01 00:00:00
732	Carlos V	\N	8	19	8.00	10.50	100	10	2024-10-01 00:00:00
733	Milky way	\N	8	19	8.00	10.50	100	10	2024-10-01 00:00:00
734	Snickers	\N	8	19	8.00	10.50	100	10	2024-10-01 00:00:00
735	Kit kat	\N	8	19	8.00	10.50	100	10	2024-10-01 00:00:00
736	Kinder delice	\N	8	40	8.00	10.50	100	10	2024-10-01 00:00:00
737	Kinder sorpresa	\N	8	40	8.00	10.50	100	10	2024-10-01 00:00:00
738	Ferrero rocher 3 piezas	\N	8	40	8.00	10.50	100	10	2024-10-01 00:00:00
739	Mazapan	\N	8	62	8.00	10.50	100	10	2024-10-01 00:00:00
740	Pelon pelo rico	\N	8	45	8.00	10.50	100	10	2024-10-01 00:00:00
741	Pulparindo tamarindo	\N	8	62	8.00	10.50	100	10	2024-10-01 00:00:00
742	Pulparindo chamoy	\N	8	62	8.00	10.50	100	10	2024-10-01 00:00:00
743	Tutsi pop	\N	8	65	8.00	10.50	100	10	2024-10-01 00:00:00
744	Oblea cajeta coronado	\N	8	66	8.00	10.50	100	10	2024-10-01 00:00:00
745	Paleta payaso	\N	8	67	8.00	10.50	100	10	2024-10-01 00:00:00
746	Duvalin fresa vainilla	\N	8	67	8.00	10.50	100	10	2024-10-01 00:00:00
747	Duvalin chocolate vainilla	\N	8	67	8.00	10.50	100	10	2024-10-01 00:00:00
748	Duvalin vainilla	\N	8	67	8.00	10.50	100	10	2024-10-01 00:00:00
749	Duvalin trisabor	\N	8	67	8.00	10.50	100	10	2024-10-01 00:00:00
750	Duvalin choco avellana	\N	8	67	8.00	10.50	100	10	2024-10-01 00:00:00
751	Paleta Vero mango	\N	8	68	8.00	10.50	100	10	2024-10-01 00:00:00
752	Paleta Vero elote	\N	8	67	8.00	10.50	100	10	2024-10-01 00:00:00
753	Panditas	\N	8	67	8.00	10.50	100	10	2024-10-01 00:00:00
754	Panditas rellenos	\N	8	67	8.00	10.50	100	10	2024-10-01 00:00:00
755	Panditas san valentin	\N	8	67	8.00	10.50	100	10	2024-10-01 00:00:00
756	Bubulubu	\N	8	67	8.00	10.50	100	10	2024-10-01 00:00:00
757	Rockaleta	\N	8	69	8.00	10.50	100	10	2024-10-01 00:00:00
758	Tic tac menta	\N	8	40	8.00	10.50	100	10	2024-10-01 00:00:00
759	Tic tac naranja	\N	8	40	8.00	10.50	100	10	2024-10-01 00:00:00
760	Halls menta	\N	8	58	8.00	10.50	100	10	2024-10-01 00:00:00
761	Halls limon	\N	8	58	8.00	10.50	100	10	2024-10-01 00:00:00
762	Halls yerba buena	\N	8	58	8.00	10.50	100	10	2024-10-01 00:00:00
763	Halls miel	\N	8	58	8.00	10.50	100	10	2024-10-01 00:00:00
764	Halls negras	\N	8	58	8.00	10.50	100	10	2024-10-01 00:00:00
765	Gomilocas dientes	\N	8	67	8.00	10.50	100	10	2024-10-01 00:00:00
766	Gomilocas pinguino	\N	8	67	8.00	10.50	100	10	2024-10-01 00:00:00
767	Chocoretas	\N	8	67	8.00	10.50	100	10	2024-10-01 00:00:00
768	Kranky	\N	8	67	8.00	10.50	100	10	2024-10-01 00:00:00
769	Lucas muecas	\N	8	58	8.00	10.50	100	10	2024-10-01 00:00:00
770	Lucas chamoy	\N	8	58	8.00	10.50	100	10	2024-10-01 00:00:00
771	Lucas gusanito	\N	8	58	8.00	10.50	100	10	2024-10-01 00:00:00
772	Palomitas Act II mantequilla	\N	9	58	8.00	10.50	100	10	2024-10-01 00:00:00
773	Palomitas Act II natural	\N	9	58	8.00	10.50	100	10	2024-10-01 00:00:00
774	Palomitas Act II chile limon	\N	9	58	8.00	10.50	100	10	2024-10-01 00:00:00
775	Tostitos salsa verde	\N	9	3	8.00	10.50	100	10	2024-10-01 00:00:00
776	Zucaritas chicas	\N	5	26	8.00	10.50	100	10	2024-10-01 00:00:00
777	Zucaritas grandes	\N	5	26	8.00	10.50	100	10	2024-10-01 00:00:00
778	Corn flakes chicas	\N	5	26	8.00	10.50	100	10	2024-10-01 00:00:00
779	Corn flakes grandes	\N	5	26	8.00	10.50	100	10	2024-10-01 00:00:00
780	Choco Krispis chicas	\N	5	26	8.00	10.50	100	10	2024-10-01 00:00:00
781	Choco Krispis grandes	\N	5	26	8.00	10.50	100	10	2024-10-01 00:00:00
782	Nesquik chico	\N	5	26	8.00	10.50	100	10	2024-10-01 00:00:00
783	Nesquik grande	\N	5	26	8.00	10.50	100	10	2024-10-01 00:00:00
784	Froot loops chicas	\N	5	26	8.00	10.50	100	10	2024-10-01 00:00:00
785	Froot loops grandes	\N	5	26	8.00	10.50	100	10	2024-10-01 00:00:00
786	Chocomilk sobre	\N	4	58	8.00	10.50	100	10	2024-10-01 00:00:00
787	Chocomilk bolsa	\N	4	58	8.00	10.50	100	10	2024-10-01 00:00:00
788	Chocomilk lata	\N	4	58	8.00	10.50	100	10	2024-10-01 00:00:00
789	Nescafe clasico sobre	\N	4	19	8.00	10.50	100	10	2024-10-01 00:00:00
790	Nescafe capuccino sobre	\N	4	19	8.00	10.50	100	10	2024-10-01 00:00:00
791	Nescafe clasico bote chico	\N	4	19	8.00	10.50	100	10	2024-10-01 00:00:00
792	Nescafe clasico bote grande	\N	4	19	8.00	10.50	100	10	2024-10-01 00:00:00
793	Azucar Zulka 1kg	\N	3	58	8.00	10.50	100	10	2024-10-01 00:00:00
794	Azucar refinada 1kg	\N	3	58	8.00	10.50	100	10	2024-10-01 00:00:00
795	Azucar refinada 500gr	\N	3	58	8.00	10.50	100	10	2024-10-01 00:00:00
796	Azucar refinada 250gr	\N	3	58	8.00	10.50	100	10	2024-10-01 00:00:00
797	Aceite nutrioli 1lt	\N	1	58	8.00	10.50	100	10	2024-10-01 00:00:00
798	Aceite capullo 1lt	\N	1	58	8.00	10.50	100	10	2024-10-01 00:00:00
799	Aceite 1 2 3 1lt	\N	1	58	8.00	10.50	100	10	2024-10-01 00:00:00
800	Aceite patrona 1lt	\N	1	58	8.00	10.50	100	10	2024-10-01 00:00:00
801	Vinagre blanco la coste¤a	\N	1	27	8.00	10.50	100	10	2024-10-01 00:00:00
802	Vinagre de manzana la coste¤a	\N	1	27	8.00	10.50	100	10	2024-10-01 00:00:00
803	Catsup la coste¤a	\N	1	27	8.00	10.50	100	10	2024-10-01 00:00:00
804	Catsup Del monte	\N	1	70	8.00	10.50	100	10	2024-10-01 00:00:00
805	Catsup heinz	\N	1	71	8.00	10.50	100	10	2024-10-01 00:00:00
806	Jugo Magui	\N	7	19	8.00	10.50	100	10	2024-10-01 00:00:00
807	Salsa inglesa	\N	7	19	8.00	10.50	100	10	2024-10-01 00:00:00
808	Salsa valentina chica	\N	7	58	8.00	10.50	100	10	2024-10-01 00:00:00
809	Salsa valentina grande	\N	7	58	8.00	10.50	100	10	2024-10-01 00:00:00
810	Salsa tabasco	\N	7	58	8.00	10.50	100	10	2024-10-01 00:00:00
811	Salsa buffalo	\N	7	58	8.00	10.50	100	10	2024-10-01 00:00:00
812	Salsa chipotle la coste¤a	\N	7	27	8.00	10.50	100	10	2024-10-01 00:00:00
813	Chile chipotle la coste¤a	\N	6	27	8.00	10.50	100	10	2024-10-01 00:00:00
814	Chiles serranos la coste¤a	\N	6	27	8.00	10.50	100	10	2024-10-01 00:00:00
815	Chiles en vinagre la coste¤a	\N	6	27	8.00	10.50	100	10	2024-10-01 00:00:00
816	Chile chipotle la morena	\N	6	72	8.00	10.50	100	10	2024-10-01 00:00:00
817	Chiles en vinagre la morena	\N	6	72	8.00	10.50	100	10	2024-10-01 00:00:00
818	Mayonesa mccormick chica	\N	7	72	8.00	10.50	100	10	2024-10-01 00:00:00
819	Mayonesa mccormick grande	\N	7	72	8.00	10.50	100	10	2024-10-01 00:00:00
820	Mostaza mccormick	\N	7	72	8.00	10.50	100	10	2024-10-01 00:00:00
821	Mermelada mccormick fresa chica	\N	19	72	8.00	10.50	100	10	2024-10-01 00:00:00
822	Mermelada mccormick fresa grande	\N	19	72	8.00	10.50	100	10	2024-10-01 00:00:00
823	Cloralex 1/2 lt	\N	35	58	8.00	10.50	100	10	2024-10-01 00:00:00
824	Cloralex 1 lt	\N	35	58	8.00	10.50	100	10	2024-10-01 00:00:00
825	Pinol	\N	35	58	8.00	10.50	100	10	2024-10-01 00:00:00
826	Fabuloso lavanda 1lt	\N	35	58	8.00	10.50	100	10	2024-10-01 00:00:00
827	Fabuloso aroma floral 1lt	\N	35	58	8.00	10.50	100	10	2024-10-01 00:00:00
828	Jab¢n zote rosa chico	\N	42	58	8.00	10.50	100	10	2024-10-01 00:00:00
829	Jab¢n zote rosa grande	\N	42	58	8.00	10.50	100	10	2024-10-01 00:00:00
830	Jab¢n zote blanco chico	\N	42	58	8.00	10.50	100	10	2024-10-01 00:00:00
831	Jab¢n zote blanco grande	\N	42	58	8.00	10.50	100	10	2024-10-01 00:00:00
832	Detergente Ariel 1/2 kg	\N	34	58	8.00	10.50	100	10	2024-10-01 00:00:00
833	Detergente Ariel 1kg	\N	34	58	8.00	10.50	100	10	2024-10-01 00:00:00
834	Detergente Ace 1/2 kg	\N	34	58	8.00	10.50	100	10	2024-10-01 00:00:00
835	Detergente Ace 1kg	\N	34	58	8.00	10.50	100	10	2024-10-01 00:00:00
836	Detergente Foca 1/2 kg	\N	34	58	8.00	10.50	100	10	2024-10-01 00:00:00
837	Detergente Foca 1kg	\N	34	58	8.00	10.50	100	10	2024-10-01 00:00:00
838	Suavitel 1l	\N	34	58	8.00	10.50	100	10	2024-10-01 00:00:00
839	Papel higienico Petalo 4 rollos	\N	37	58	8.00	10.50	100	10	2024-10-01 00:00:00
840	Papel higienico Petalo 6 rollos	\N	37	58	8.00	10.50	100	10	2024-10-01 00:00:00
841	Papel higienico Suavel 4 rollos	\N	37	58	8.00	10.50	100	10	2024-10-01 00:00:00
842	Papel higienico Suavel 6 rollos	\N	37	58	8.00	10.50	100	10	2024-10-01 00:00:00
843	Toallas sanitarias Always	\N	37	58	8.00	10.50	100	10	2024-10-01 00:00:00
844	Toallas sanitarias Kotex	\N	37	58	8.00	10.50	100	10	2024-10-01 00:00:00
845	Pa¤ales Huggies	\N	44	58	8.00	10.50	100	10	2024-10-01 00:00:00
846	Shampoo Head & Shoulders chico	\N	39	58	8.00	10.50	100	10	2024-10-01 00:00:00
847	Shampoo Head & Shoulders grande	\N	39	58	8.00	10.50	100	10	2024-10-01 00:00:00
848	Desodorante Axe	\N	41	58	8.00	10.50	100	10	2024-10-01 00:00:00
849	Leche deslactosada 1lt	Presentacion azul	15	4	18.20	23.00	14	2	2024-10-01 00:00:00
850	Harina de maiz maseca	\N	10	59	8.00	10.50	100	10	2024-10-02 00:00:00
851	Harina de trigo San antonio	\N	10	41	8.00	10.50	100	10	2024-10-02 00:00:00
852	Tortillas de maiz 1/2 kg	\N	10	58	8.00	10.50	100	10	2024-10-02 00:00:00
853	Pan bimbo blanco chico	\N	27	17	8.00	10.50	100	10	2024-10-02 00:00:00
854	Pan bimbo blanco grande	\N	27	17	8.00	10.50	100	10	2024-10-02 00:00:00
855	Pan bimbo integral chico	\N	27	17	8.00	10.50	100	10	2024-10-02 00:00:00
856	Pan bimbo integral grande	\N	27	17	8.00	10.50	100	10	2024-10-02 00:00:00
857	Rebanadas bimbo	\N	27	17	8.00	10.50	100	10	2024-10-02 00:00:00
858	Chocoroles	\N	27	17	8.00	10.50	100	10	2024-10-02 00:00:00
859	Nito bimbo	\N	27	17	8.00	10.50	100	10	2024-10-02 00:00:00
860	Mantecadas	\N	27	17	8.00	10.50	100	10	2024-10-02 00:00:00
861	Roles de canela con pasas	\N	27	17	8.00	10.50	100	10	2024-10-02 00:00:00
862	Roles de canela glaseados	\N	27	17	8.00	10.50	100	10	2024-10-02 00:00:00
863	Conchas bimbo	\N	27	17	8.00	10.50	100	10	2024-10-02 00:00:00
864	Panque de nuez bimbo	\N	27	17	8.00	10.50	100	10	2024-10-02 00:00:00
865	Donitas bimbo	\N	27	17	8.00	10.50	100	10	2024-10-02 00:00:00
866	Donitas espolvoreadas bimbo	\N	27	17	8.00	10.50	100	10	2024-10-02 00:00:00
867	chimichangas	chimichangas	23	10	30.00	45.00	15	5	2024-10-02 00:00:00
868	Roles	Ricos roles de canela caseros	27	13	70.00	100.00	19	10	2024-10-02 00:00:00
869	Pepsi	bebida azucarada	31	14	8.00	16.00	77	20	2024-10-02 00:00:00
870	Manzanita		31	14	17.00	25.00	22	3	2024-10-02 00:00:00
871	MaruchanTokyo	maruchan picante	2	11	5.50	12.50	15	10	2024-10-02 00:00:00
872	Sabritas	Sabritas Flamin Hot	9	3	10.00	18.00	4	1	2024-10-02 00:00:00
873	Galletas marias	Las galletas clasicas	9	3	8.90	15.00	19	2	2024-10-02 00:00:00
874	Leche entera lala 1lt	Clasica color roja	15	4	15.24	25.00	11	3	2024-10-02 00:00:00
875	Leche Lala entera 1L	Leche Lala entera 1 Litro	15	4	19.00	24.00	100	10	2024-10-02 00:00:00
876	Tostadas charras	\N	5	60	8.00	10.50	100	10	2024-10-02 00:00:00
877	Coca Cola 1L	Refresco Coca Cola 1 Litro	31	16	12.00	15.00	100	10	2024-10-02 00:00:00
878	Coca Cola lata 355ml	Refresco Coca Cola 355 ml lata	31	16	8.50	11.00	100	10	2024-10-02 00:00:00
879	Coca Cola 355ml	Refresco Coca Cola 355 ml	31	16	8.00	10.50	100	10	2024-10-02 00:00:00
880	Coca Cola 600ml	Refresco Coca Cola 600 ml	31	16	9.00	12.00	100	10	2024-10-02 00:00:00
881	Coca Cola retornable 1 1/4 lt.	Refresco Coca Cola retornable 1 1/4 lt	31	16	12.50	15.50	100	10	2024-10-02 00:00:00
882	Coca Cola 2L retornable	Refresco Coca Cola retornable 2 Litros	31	16	19.50	24.00	100	10	2024-10-02 00:00:00
883	Coca Cola 3L retornable	Refresco Coca Cola retornable 3 Litros	31	16	24.00	30.00	100	10	2024-10-02 00:00:00
884	Coca Cola Light 600ml	Refresco Coca Cola Light 600 ml	31	16	9.50	12.50	100	10	2024-10-02 00:00:00
885	Pepsi 600ml	Refresco Pepsi 600 ml	31	14	9.00	12.00	100	10	2024-10-02 00:00:00
886	Pepsi 1.5L	Refresco Pepsi 1.5 Litros	31	14	12.00	15.50	100	10	2024-10-02 00:00:00
887	Fanta 600ml	Refresco Fanta 600 ml	31	16	9.00	12.00	100	10	2024-10-02 00:00:00
888	Fanta 1.5L	Refresco Fanta 1.5 Litros	31	16	12.50	16.00	100	10	2024-10-02 00:00:00
889	Sprite 600ml	Refresco Sprite 600 ml	31	16	9.00	12.00	100	10	2024-10-02 00:00:00
890	Sprite 1.5L	Refresco Sprite 1.5 Litros	31	16	12.50	16.00	100	10	2024-10-02 00:00:00
891	Manzanita 600ml	Refresco Manzanita Sol 600 ml	31	16	9.00	12.00	100	10	2024-10-02 00:00:00
892	Manzanita 1.5L	Refresco Manzanita Sol 1.5 Litros	31	16	12.50	16.00	100	10	2024-10-02 00:00:00
893	Fresca 600ml	Refresco Fresca 600 ml	31	16	9.00	12.00	100	10	2024-10-02 00:00:00
894	Fresca 3L	Refresco Fresca 3 Litros	31	16	24.00	30.00	100	10	2024-10-02 00:00:00
895	Mirinda 600ml	Refresco Mirinda 600 ml	31	16	9.00	12.00	100	10	2024-10-02 00:00:00
896	Mirinda 1.5L	Refresco Mirinda 1.5 Litros	31	16	12.50	16.00	100	10	2024-10-02 00:00:00
897	Tostadas Sanissimo	\N	5	61	8.00	10.50	100	10	2024-10-02 00:00:00
898	Marias gamesa	\N	29	46	8.00	10.50	100	10	2024-10-02 00:00:00
899	Jumex de mango 1L	Jugo Jumex sabor Mango 1 Litro	31	21	16.00	20.00	100	10	2024-10-02 00:00:00
900	Emperador chocolate	\N	29	46	8.00	10.50	100	10	2024-10-02 00:00:00
901	Emperador nuez	\N	29	46	8.00	10.50	100	10	2024-10-02 00:00:00
902	Emperador vainilla	\N	29	46	8.00	10.50	100	10	2024-10-02 00:00:00
903	Emperador limon	\N	29	46	8.00	10.50	100	10	2024-10-02 00:00:00
904	Jumex de durazno 1L	Jugo Jumex sabor Durazno 1 Litro	31	21	16.00	20.00	100	10	2024-10-02 00:00:00
905	Jumex de manzana 600ml	Jugo Jumex sabor Manzana 600 ml	31	21	10.00	13.00	100	10	2024-10-02 00:00:00
906	Del Valle fruit naranja 600ml	Jugo Del Valle sabor Naranja 600 ml	31	28	10.50	13.50	100	10	2024-10-02 00:00:00
907	Del Valle fruit manzana 600ml	Jugo Del Valle sabor Manzana 600 ml	31	28	10.50	13.50	100	10	2024-10-02 00:00:00
908	Del Valle fruit guayaba 600ml	Jugo Del Valle sabor Guayaba 600 ml	31	28	10.50	13.50	100	10	2024-10-02 00:00:00
909	Emperador Senso	\N	29	46	8.00	10.50	100	10	2024-10-02 00:00:00
910	Mamut chico	\N	29	46	8.00	10.50	100	10	2024-10-02 00:00:00
911	Yogurt Lala natural 1L	Yogurt Lala natural 1 Litro	17	4	25.00	30.00	100	10	2024-10-02 00:00:00
912	Yogurt Lala de fresa 1L	Yogurt Lala sabor Fresa 1 Litro	17	4	25.00	30.00	100	10	2024-10-02 00:00:00
913	Yogurt Yoplait natural 1L	Yogurt Yoplait natural 1 Litro	17	54	26.00	31.00	100	10	2024-10-02 00:00:00
914	Yogurt Yoplait de fresa 1L	Yogurt Yoplait sabor Fresa 1 Litro	17	54	26.00	31.00	100	10	2024-10-02 00:00:00
915	Mantequilla Lala 250g	Mantequilla Lala 250 gramos	19	4	30.00	38.00	100	10	2024-10-02 00:00:00
916	Queso panela Lala 200g	Queso panela Lala 200 gramos	16	4	40.00	50.00	100	10	2024-10-02 00:00:00
917	Mamut grande	\N	29	46	8.00	10.50	100	10	2024-10-02 00:00:00
918	Chokis	\N	29	46	8.00	10.50	100	10	2024-10-02 00:00:00
919	Chokis rellenas	\N	29	46	8.00	10.50	100	10	2024-10-02 00:00:00
920	Chokis doble chocolate	\N	29	46	8.00	10.50	100	10	2024-10-02 00:00:00
921	Chokis brownie	\N	29	46	8.00	10.50	100	10	2024-10-02 00:00:00
922	Leche Lala deslactosada 1L	Leche Lala deslactosada 1 Litro	15	4	20.00	25.00	100	10	2024-10-02 00:00:00
923	Leche Lala light 1L	Leche Lala light 1 Litro	15	4	20.00	25.00	100	10	2024-10-02 00:00:00
924	Leche Santa Clara entera 1L	Leche Santa Clara entera 1 Litro	15	4	22.00	28.00	100	10	2024-10-02 00:00:00
925	Leche Santa Clara deslactosada 1L	Leche Santa Clara deslactosada 1 Litro	15	4	23.00	29.00	100	10	2024-10-02 00:00:00
926	Arroz Mexica 1kg	None	2	59	12.00	16.50	100	10	2024-10-02 00:00:00
927	Queso panela Alpura 200g	Queso panela Alpura 200 gramos	16	18	40.00	50.00	100	10	2024-10-02 00:00:00
928	Queso oaxaca Lala 200g	Queso Oaxaca Lala 200 gramos	16	4	45.00	55.00	100	10	2024-10-02 00:00:00
929	Queso manchego Lala 200g	Queso Manchego Lala 200 gramos	16	4	50.00	60.00	100	10	2024-10-02 00:00:00
930	Salchichas Fud paquete 500g	Salchichas Fud 500 gramos	18	53	30.00	40.00	100	10	2024-10-02 00:00:00
931	Salchichas San Rafael paquete 500g	Salchichas San Rafael 500 gramos	18	52	35.00	45.00	100	10	2024-10-02 00:00:00
932	Jam¢n de pavo Fud 250g	Jam¢n de Pavo Fud 250 gramos	18	53	35.00	45.00	100	10	2024-10-02 00:00:00
933	Jam¢n de pavo San Rafael 250g	Jam¢n de Pavo San Rafael 250 gramos	18	52	40.00	50.00	100	10	2024-10-02 00:00:00
934	Sidral mundet 600ml	Refresco de manzana de 600ml	31	16	10.00	16.00	20	5	2024-10-02 00:00:00
935	Sidral mundet 3lt	Refresco de manzana de 3lt	31	16	24.00	30.00	20	5	2024-10-02 00:00:00
936	Agua bonafont 600ml	\N	30	55	8.00	10.50	100	10	2024-10-02 00:00:00
937	Agua bonafont 1lt	\N	30	55	12.00	15.00	100	10	2024-10-02 00:00:00
938	Agua bonafont 2lt.	\N	30	55	14.00	18.00	100	10	2024-10-02 00:00:00
939	Garrafon bonafont 20lt	\N	30	55	19.50	24.00	100	10	2024-10-02 00:00:00
940	Agua ciel 600ml	\N	30	16	8.00	13.00	100	10	2024-10-02 00:00:00
941	Agua ciel 1lt	\N	30	16	10.00	15.00	100	10	2024-10-02 00:00:00
942	Agua ciel 1.5l	\N	30	16	12.00	17.00	100	10	2024-10-02 00:00:00
943	Agua ciel 2lt	\N	30	16	14.00	20.00	100	10	2024-10-02 00:00:00
944	Agua E-pura 600ml	\N	30	14	8.00	13.00	100	10	2024-10-02 00:00:00
945	Agua E-pura 1lt	\N	30	14	10.00	15.00	100	10	2024-10-02 00:00:00
946	Garrafon E-pura 10lt	\N	30	14	18.00	25.00	100	10	2024-10-02 00:00:00
947	Crema Lala 200ml	\N	15	4	8.00	13.00	100	10	2024-10-02 00:00:00
948	Crema Lala 426ml	\N	15	4	15.00	30.00	100	10	2024-10-02 00:00:00
949	Crema Lala 900ml	\N	15	4	35.00	55.00	100	10	2024-10-02 00:00:00
950	Crema alpura 200ml	\N	15	4	8.00	13.00	100	10	2024-10-02 00:00:00
951	Crema alpura 426ml	\N	15	4	15.00	30.00	100	10	2024-10-02 00:00:00
952	Crema alpura 900ml	\N	15	4	35.00	55.00	100	10	2024-10-02 00:00:00
953	Atun dolores en agua	\N	6	51	10.00	15.00	100	10	2024-10-02 00:00:00
954	Atun dolores en aceite	\N	6	51	12.00	17.00	100	10	2024-10-02 00:00:00
955	Sardinas en aceite	\N	6	20	10.00	15.00	100	10	2024-10-02 00:00:00
956	Frijoles refritos	\N	6	50	10.00	15.00	100	10	2024-10-02 00:00:00
957	Frijoles bayos	\N	6	50	10.00	15.00	100	10	2024-10-02 00:00:00
958	Lentejas la moderna	\N	2	44	10.00	15.00	100	10	2024-10-02 00:00:00
959	Pasta la moderna	\N	2	44	10.00	15.00	100	10	2024-10-02 00:00:00
960	Coditos la moderna	\N	2	44	10.00	15.00	100	10	2024-10-02 00:00:00
961	Pasta Barilla espagueti	\N	2	56	10.00	15.00	100	10	2024-10-02 00:00:00
962	Sopa de letras la moderna	\N	2	44	10.00	15.00	100	10	2024-10-02 00:00:00
963	Sopa maruchan pollo	\N	2	57	10.00	15.00	100	10	2024-10-02 00:00:00
964	Sopa maruchan camaron	\N	2	57	10.00	15.00	100	10	2024-10-02 00:00:00
965	Sopa maruchan res	\N	2	57	10.00	15.00	100	10	2024-10-02 00:00:00
966	Sopa maruchan habanero	\N	2	57	10.00	15.00	100	10	2024-10-02 00:00:00
967	Sopa maruchan piquin	\N	2	57	10.00	15.00	100	10	2024-10-02 00:00:00
968	Sopa maruchan limon	\N	2	57	10.00	15.00	100	10	2024-10-02 00:00:00
969	Cremax vainilla	\N	29	46	8.00	10.50	100	10	2024-10-02 00:00:00
970	Cremax chocolate	\N	29	46	8.00	10.50	100	10	2024-10-02 00:00:00
971	Cremax fresa	\N	29	46	8.00	10.50	100	10	2024-10-02 00:00:00
972	Florentinas gamesa	\N	29	46	8.00	10.50	100	10	2024-10-02 00:00:00
973	Marias doradas	\N	29	46	8.00	10.50	100	10	2024-10-02 00:00:00
974	Gamesa cajeta	\N	29	46	8.00	10.50	100	10	2024-10-02 00:00:00
975	Maravillas gamesa	\N	29	46	8.00	10.50	100	10	2024-10-02 00:00:00
976	Crackets gamesa	\N	29	46	8.00	10.50	100	10	2024-10-02 00:00:00
977	Surtido rico gamesa	\N	29	46	8.00	10.50	100	10	2024-10-02 00:00:00
978	Delicias gamesa	\N	29	46	8.00	10.50	100	10	2024-10-02 00:00:00
979	Oreo	\N	9	58	8.00	10.50	100	10	2024-10-02 00:00:00
980	Principe chocolate	\N	9	22	8.00	10.50	100	10	2024-10-02 00:00:00
981	Principe vainilla	\N	9	22	8.00	10.50	100	10	2024-10-02 00:00:00
982	Principe limon	\N	9	22	8.00	10.50	100	10	2024-10-02 00:00:00
983	Principe chocolate blanco	\N	9	22	8.00	10.50	100	10	2024-10-02 00:00:00
984	Lors	\N	9	22	8.00	10.50	100	10	2024-10-02 00:00:00
985	Plativolos	\N	9	22	8.00	10.50	100	10	2024-10-02 00:00:00
986	Sponch	\N	9	22	8.00	10.50	100	10	2024-10-02 00:00:00
987	Triki trakes	\N	9	22	8.00	10.50	100	10	2024-10-02 00:00:00
988	MaxiTubo Triki trakes	\N	9	22	8.00	10.50	100	10	2024-10-02 00:00:00
989	Gansito	\N	9	22	8.00	10.50	100	10	2024-10-02 00:00:00
990	Pinguinos	\N	9	22	8.00	10.50	100	10	2024-10-02 00:00:00
991	Pasticetas marinela	\N	9	22	8.00	10.50	100	10	2024-10-02 00:00:00
992	Barritas fresa	\N	9	22	8.00	10.50	100	10	2024-10-02 00:00:00
993	Barritas pina	\N	9	22	8.00	10.50	100	10	2024-10-02 00:00:00
994	Barritas moras	\N	9	22	8.00	10.50	100	10	2024-10-02 00:00:00
995	Maxitubo Barritas fresa	\N	9	22	8.00	10.50	100	10	2024-10-02 00:00:00
996	Maxitubo Barritas pina	\N	9	22	8.00	10.50	100	10	2024-10-02 00:00:00
997	Canelitas	\N	9	22	8.00	10.50	100	10	2024-10-02 00:00:00
998	Polvorones	\N	9	22	8.00	10.50	100	10	2024-10-02 00:00:00
999	Maxitubo Polvorones	\N	9	22	8.00	10.50	100	10	2024-10-02 00:00:00
1000	Ricanelas	\N	9	46	8.00	10.50	100	10	2024-10-02 00:00:00
1001	Ritz bits queso	\N	9	58	8.00	10.50	100	10	2024-10-02 00:00:00
1002	Arcoiris	\N	9	46	8.00	10.50	100	10	2024-10-02 00:00:00
1003	Submarinos fresa	\N	9	22	8.00	10.50	100	10	2024-10-02 00:00:00
1004	Submarinos vainilla	\N	9	22	8.00	10.50	100	10	2024-10-02 00:00:00
1005	Submarinos chocolate	\N	9	22	8.00	10.50	100	10	2024-10-02 00:00:00
1006	Rocko chico	\N	9	22	8.00	10.50	100	10	2024-10-02 00:00:00
1007	Rocko grande	\N	9	22	8.00	10.50	100	10	2024-10-02 00:00:00
1008	Sabritas original	\N	9	3	8.00	10.50	100	10	2024-10-02 00:00:00
1009	Sabritas adobadas	\N	9	3	8.00	10.50	100	10	2024-10-02 00:00:00
1010	Sabritas limon	\N	9	3	8.00	10.50	100	10	2024-10-02 00:00:00
1011	Sabritas flamin hot	\N	9	3	8.00	10.50	100	10	2024-10-02 00:00:00
1012	Sabritas crema y especias	\N	9	3	8.00	10.50	100	10	2024-10-02 00:00:00
1013	Sabritas habanero	\N	9	3	8.00	10.50	100	10	2024-10-02 00:00:00
1014	Sabritas receta crujiente	\N	9	3	8.00	10.50	100	10	2024-10-02 00:00:00
1015	Sabritas receta crujiente jalapeno	\N	9	3	8.00	10.50	100	10	2024-10-02 00:00:00
1016	Crujitos	\N	9	3	8.00	10.50	100	10	2024-10-02 00:00:00
1017	Doritos nacho	\N	9	3	8.00	10.50	100	10	2024-10-02 00:00:00
1018	Doritos incognita	\N	9	3	8.00	10.50	100	10	2024-10-02 00:00:00
1019	Doritos diablo	\N	9	3	8.00	10.50	100	10	2024-10-02 00:00:00
1020	Doritos flamin hot	\N	9	3	8.00	10.50	100	10	2024-10-02 00:00:00
1021	Doritos dinamita	\N	9	3	8.00	10.50	100	10	2024-10-02 00:00:00
1022	Sabritones	\N	9	3	8.00	10.50	100	10	2024-10-02 00:00:00
1023	Bigmix queso	\N	9	47	8.00	10.50	100	10	2024-10-02 00:00:00
1024	Bigmix fuego	\N	9	47	8.00	10.50	100	10	2024-10-02 00:00:00
1025	Cheetos torciditos	\N	9	3	8.00	10.50	100	10	2024-10-02 00:00:00
1026	Cheetos bolitas	\N	9	3	8.00	10.50	100	10	2024-10-02 00:00:00
1027	Cheetos queso	\N	9	3	8.00	10.50	100	10	2024-10-02 00:00:00
1028	Cheetos flamin hot	\N	9	3	8.00	10.50	100	10	2024-10-02 00:00:00
1029	Ruffles original	\N	9	3	8.00	10.50	100	10	2024-10-02 00:00:00
1030	Ruffles queso	\N	9	3	8.00	10.50	100	10	2024-10-02 00:00:00
1031	Fritos sal y limon	\N	9	3	8.00	10.50	100	10	2024-10-02 00:00:00
1032	Fritos chorizo	\N	9	3	8.00	10.50	100	10	2024-10-02 00:00:00
1033	Bolsaza Sabritas original	\N	9	3	8.00	10.50	100	10	2024-10-02 00:00:00
1034	Bolsaza Doritos nacho	\N	9	3	8.00	10.50	100	10	2024-10-02 00:00:00
1035	Paketaxo	\N	9	3	8.00	10.50	100	10	2024-10-02 00:00:00
1036	Paketaxo queso	\N	9	3	8.00	10.50	100	10	2024-10-02 00:00:00
1037	Paketaxo flamin hot	\N	9	3	8.00	10.50	100	10	2024-10-02 00:00:00
1038	Churrumaiz	\N	9	3	8.00	10.50	100	10	2024-10-02 00:00:00
1039	Churrumaiz flamin hot	\N	9	3	8.00	10.50	100	10	2024-10-02 00:00:00
1040	Rancheritos	\N	9	3	8.00	10.50	100	10	2024-10-02 00:00:00
1041	Sabritas switch doritos nacho	\N	9	3	8.00	10.50	100	10	2024-10-02 00:00:00
1042	Runners	\N	9	47	8.00	10.50	100	10	2024-10-02 00:00:00
1043	Chips jalapeno	\N	9	47	8.00	10.50	100	10	2024-10-02 00:00:00
1044	Chips sal	\N	9	47	8.00	10.50	100	10	2024-10-02 00:00:00
1045	Papatinas	\N	9	47	8.00	10.50	100	10	2024-10-02 00:00:00
1046	Chips fuego	\N	9	47	8.00	10.50	100	10	2024-10-02 00:00:00
1047	Palomitas pop	\N	9	47	8.00	10.50	100	10	2024-10-02 00:00:00
1048	Takis original 	\N	9	47	8.00	10.50	100	10	2024-10-02 00:00:00
1049	Takis fuego	\N	9	47	8.00	10.50	100	10	2024-10-02 00:00:00
1050	Takis salsa brava	\N	9	47	8.00	10.50	100	10	2024-10-02 00:00:00
1051	Takis guacamole	\N	9	47	8.00	10.50	100	10	2024-10-02 00:00:00
1052	Chipotles	\N	9	47	8.00	10.50	100	10	2024-10-02 00:00:00
1053	Tostachos	\N	9	47	8.00	10.50	100	10	2024-10-02 00:00:00
1054	Hot nuts	\N	9	47	8.00	10.50	100	10	2024-10-02 00:00:00
1055	Hot nuts fuego	\N	9	47	8.00	10.50	100	10	2024-10-02 00:00:00
1056	Valentones	\N	9	47	8.00	10.50	100	10	2024-10-02 00:00:00
1057	Watz barcel	\N	9	47	8.00	10.50	100	10	2024-10-02 00:00:00
1058	Toreadas	\N	9	47	8.00	10.50	100	10	2024-10-02 00:00:00
1059	Palomitas pop fuego	\N	9	47	8.00	10.50	100	10	2024-10-02 00:00:00
1060	Takis blue heat	\N	9	47	8.00	10.50	100	10	2024-10-02 00:00:00
1061	Doraditas tia rosa	\N	29	49	8.00	10.50	100	10	2024-10-02 00:00:00
1062	Bigote tia rosa	\N	29	49	8.00	10.50	100	10	2024-10-02 00:00:00
1063	Tortillinas tia rosa	\N	10	49	8.00	10.50	100	10	2024-10-02 00:00:00
1064	Magdalenas tia rosa	\N	29	49	8.00	10.50	100	10	2024-10-02 00:00:00
1065	Conchas tia rosa	\N	29	49	8.00	10.50	100	10	2024-10-02 00:00:00
1066	Hersheys Cookies n Cream	\N	8	45	8.00	10.50	100	10	2024-10-02 00:00:00
1067	Hersheys almendras	\N	8	45	8.00	10.50	100	10	2024-10-02 00:00:00
1068	Hersheys chocolate amargo	\N	8	45	8.00	10.50	100	10	2024-10-02 00:00:00
1069	Hersheys chocolate blanco	\N	8	45	8.00	10.50	100	10	2024-10-02 00:00:00
1070	Crunch	\N	8	19	8.00	10.50	100	10	2024-10-02 00:00:00
1071	Carlos V	\N	8	19	8.00	10.50	100	10	2024-10-02 00:00:00
1072	Milky way	\N	8	19	8.00	10.50	100	10	2024-10-02 00:00:00
1073	Snickers	\N	8	19	8.00	10.50	100	10	2024-10-02 00:00:00
1074	Kit kat	\N	8	19	8.00	10.50	100	10	2024-10-02 00:00:00
1075	Kinder delice	\N	8	40	8.00	10.50	100	10	2024-10-02 00:00:00
1076	Kinder sorpresa	\N	8	40	8.00	10.50	100	10	2024-10-02 00:00:00
1077	Ferrero rocher 3 piezas	\N	8	40	8.00	10.50	100	10	2024-10-02 00:00:00
1078	Mazapan	\N	8	62	8.00	10.50	100	10	2024-10-02 00:00:00
1079	Pelon pelo rico	\N	8	45	8.00	10.50	100	10	2024-10-02 00:00:00
1080	Pulparindo tamarindo	\N	8	62	8.00	10.50	100	10	2024-10-02 00:00:00
1081	Pulparindo chamoy	\N	8	62	8.00	10.50	100	10	2024-10-02 00:00:00
1082	Tutsi pop	\N	8	65	8.00	10.50	100	10	2024-10-02 00:00:00
1083	Oblea cajeta coronado	\N	8	66	8.00	10.50	100	10	2024-10-02 00:00:00
1084	Paleta payaso	\N	8	67	8.00	10.50	100	10	2024-10-02 00:00:00
1085	Duvalin fresa vainilla	\N	8	67	8.00	10.50	100	10	2024-10-02 00:00:00
1086	Duvalin chocolate vainilla	\N	8	67	8.00	10.50	100	10	2024-10-02 00:00:00
1087	Duvalin vainilla	\N	8	67	8.00	10.50	100	10	2024-10-02 00:00:00
1088	Duvalin trisabor	\N	8	67	8.00	10.50	100	10	2024-10-02 00:00:00
1089	Duvalin choco avellana	\N	8	67	8.00	10.50	100	10	2024-10-02 00:00:00
1090	Paleta Vero mango	\N	8	68	8.00	10.50	100	10	2024-10-02 00:00:00
1091	Paleta Vero elote	\N	8	67	8.00	10.50	100	10	2024-10-02 00:00:00
1092	Panditas	\N	8	67	8.00	10.50	100	10	2024-10-02 00:00:00
1093	Panditas rellenos	\N	8	67	8.00	10.50	100	10	2024-10-02 00:00:00
1094	Panditas san valentin	\N	8	67	8.00	10.50	100	10	2024-10-02 00:00:00
1095	Bubulubu	\N	8	67	8.00	10.50	100	10	2024-10-02 00:00:00
1096	Rockaleta	\N	8	69	8.00	10.50	100	10	2024-10-02 00:00:00
1097	Tic tac menta	\N	8	40	8.00	10.50	100	10	2024-10-02 00:00:00
1098	Tic tac naranja	\N	8	40	8.00	10.50	100	10	2024-10-02 00:00:00
1099	Halls menta	\N	8	58	8.00	10.50	100	10	2024-10-02 00:00:00
1100	Halls limon	\N	8	58	8.00	10.50	100	10	2024-10-02 00:00:00
1101	Halls yerba buena	\N	8	58	8.00	10.50	100	10	2024-10-02 00:00:00
1102	Halls miel	\N	8	58	8.00	10.50	100	10	2024-10-02 00:00:00
1103	Halls negras	\N	8	58	8.00	10.50	100	10	2024-10-02 00:00:00
1104	Gomilocas dientes	\N	8	67	8.00	10.50	100	10	2024-10-02 00:00:00
1105	Gomilocas pinguino	\N	8	67	8.00	10.50	100	10	2024-10-02 00:00:00
1106	Chocoretas	\N	8	67	8.00	10.50	100	10	2024-10-02 00:00:00
1107	Kranky	\N	8	67	8.00	10.50	100	10	2024-10-02 00:00:00
1108	Lucas muecas	\N	8	58	8.00	10.50	100	10	2024-10-02 00:00:00
1109	Lucas chamoy	\N	8	58	8.00	10.50	100	10	2024-10-02 00:00:00
1110	Lucas gusanito	\N	8	58	8.00	10.50	100	10	2024-10-02 00:00:00
1111	Palomitas Act II mantequilla	\N	9	58	8.00	10.50	100	10	2024-10-02 00:00:00
1112	Palomitas Act II natural	\N	9	58	8.00	10.50	100	10	2024-10-02 00:00:00
1113	Palomitas Act II chile limon	\N	9	58	8.00	10.50	100	10	2024-10-02 00:00:00
1114	Tostitos salsa verde	\N	9	3	8.00	10.50	100	10	2024-10-02 00:00:00
1115	Zucaritas chicas	\N	5	26	8.00	10.50	100	10	2024-10-02 00:00:00
1116	Zucaritas grandes	\N	5	26	8.00	10.50	100	10	2024-10-02 00:00:00
1117	Corn flakes chicas	\N	5	26	8.00	10.50	100	10	2024-10-02 00:00:00
1118	Corn flakes grandes	\N	5	26	8.00	10.50	100	10	2024-10-02 00:00:00
1119	Choco Krispis chicas	\N	5	26	8.00	10.50	100	10	2024-10-02 00:00:00
1120	Choco Krispis grandes	\N	5	26	8.00	10.50	100	10	2024-10-02 00:00:00
1121	Nesquik chico	\N	5	26	8.00	10.50	100	10	2024-10-02 00:00:00
1122	Nesquik grande	\N	5	26	8.00	10.50	100	10	2024-10-02 00:00:00
1123	Froot loops chicas	\N	5	26	8.00	10.50	100	10	2024-10-02 00:00:00
1124	Froot loops grandes	\N	5	26	8.00	10.50	100	10	2024-10-02 00:00:00
1125	Chocomilk sobre	\N	4	58	8.00	10.50	100	10	2024-10-02 00:00:00
1126	Chocomilk bolsa	\N	4	58	8.00	10.50	100	10	2024-10-02 00:00:00
1127	Chocomilk lata	\N	4	58	8.00	10.50	100	10	2024-10-02 00:00:00
1128	Nescafe clasico sobre	\N	4	19	8.00	10.50	100	10	2024-10-02 00:00:00
1129	Nescafe capuccino sobre	\N	4	19	8.00	10.50	100	10	2024-10-02 00:00:00
1130	Nescafe clasico bote chico	\N	4	19	8.00	10.50	100	10	2024-10-02 00:00:00
1131	Nescafe clasico bote grande	\N	4	19	8.00	10.50	100	10	2024-10-02 00:00:00
1132	Azucar Zulka 1kg	\N	3	58	8.00	10.50	100	10	2024-10-02 00:00:00
1133	Azucar refinada 1kg	\N	3	58	8.00	10.50	100	10	2024-10-02 00:00:00
1134	Azucar refinada 500gr	\N	3	58	8.00	10.50	100	10	2024-10-02 00:00:00
1135	Azucar refinada 250gr	\N	3	58	8.00	10.50	100	10	2024-10-02 00:00:00
1136	Aceite nutrioli 1lt	\N	1	58	8.00	10.50	100	10	2024-10-02 00:00:00
1137	Aceite capullo 1lt	\N	1	58	8.00	10.50	100	10	2024-10-02 00:00:00
1138	Aceite 1 2 3 1lt	\N	1	58	8.00	10.50	100	10	2024-10-02 00:00:00
1139	Aceite patrona 1lt	\N	1	58	8.00	10.50	100	10	2024-10-02 00:00:00
1140	Vinagre blanco la coste¤a	\N	1	27	8.00	10.50	100	10	2024-10-02 00:00:00
1141	Vinagre de manzana la coste¤a	\N	1	27	8.00	10.50	100	10	2024-10-02 00:00:00
1142	Catsup la coste¤a	\N	1	27	8.00	10.50	100	10	2024-10-02 00:00:00
1143	Catsup Del monte	\N	1	70	8.00	10.50	100	10	2024-10-02 00:00:00
1144	Catsup heinz	\N	1	71	8.00	10.50	100	10	2024-10-02 00:00:00
1145	Jugo Magui	\N	7	19	8.00	10.50	100	10	2024-10-02 00:00:00
1146	Salsa inglesa	\N	7	19	8.00	10.50	100	10	2024-10-02 00:00:00
1147	Salsa valentina chica	\N	7	58	8.00	10.50	100	10	2024-10-02 00:00:00
1148	Salsa valentina grande	\N	7	58	8.00	10.50	100	10	2024-10-02 00:00:00
1149	Salsa tabasco	\N	7	58	8.00	10.50	100	10	2024-10-02 00:00:00
1150	Salsa buffalo	\N	7	58	8.00	10.50	100	10	2024-10-02 00:00:00
1151	Salsa chipotle la coste¤a	\N	7	27	8.00	10.50	100	10	2024-10-02 00:00:00
1152	Chile chipotle la coste¤a	\N	6	27	8.00	10.50	100	10	2024-10-02 00:00:00
1153	Chiles serranos la coste¤a	\N	6	27	8.00	10.50	100	10	2024-10-02 00:00:00
1154	Chiles en vinagre la coste¤a	\N	6	27	8.00	10.50	100	10	2024-10-02 00:00:00
1155	Chile chipotle la morena	\N	6	72	8.00	10.50	100	10	2024-10-02 00:00:00
1156	Chiles en vinagre la morena	\N	6	72	8.00	10.50	100	10	2024-10-02 00:00:00
1157	Mayonesa mccormick chica	\N	7	72	8.00	10.50	100	10	2024-10-02 00:00:00
1158	Mayonesa mccormick grande	\N	7	72	8.00	10.50	100	10	2024-10-02 00:00:00
1159	Mostaza mccormick	\N	7	72	8.00	10.50	100	10	2024-10-02 00:00:00
1160	Mermelada mccormick fresa chica	\N	19	72	8.00	10.50	100	10	2024-10-02 00:00:00
1161	Mermelada mccormick fresa grande	\N	19	72	8.00	10.50	100	10	2024-10-02 00:00:00
1162	Cloralex 1/2 lt	\N	35	58	8.00	10.50	100	10	2024-10-02 00:00:00
1163	Cloralex 1 lt	\N	35	58	8.00	10.50	100	10	2024-10-02 00:00:00
1164	Pinol	\N	35	58	8.00	10.50	100	10	2024-10-02 00:00:00
1165	Fabuloso lavanda 1lt	\N	35	58	8.00	10.50	100	10	2024-10-02 00:00:00
1166	Fabuloso aroma floral 1lt	\N	35	58	8.00	10.50	100	10	2024-10-02 00:00:00
1167	Jab¢n zote rosa chico	\N	42	58	8.00	10.50	100	10	2024-10-02 00:00:00
1168	Jab¢n zote rosa grande	\N	42	58	8.00	10.50	100	10	2024-10-02 00:00:00
1169	Jab¢n zote blanco chico	\N	42	58	8.00	10.50	100	10	2024-10-02 00:00:00
1170	Jab¢n zote blanco grande	\N	42	58	8.00	10.50	100	10	2024-10-02 00:00:00
1171	Detergente Ariel 1/2 kg	\N	34	58	8.00	10.50	100	10	2024-10-02 00:00:00
1172	Detergente Ariel 1kg	\N	34	58	8.00	10.50	100	10	2024-10-02 00:00:00
1173	Detergente Ace 1/2 kg	\N	34	58	8.00	10.50	100	10	2024-10-02 00:00:00
1174	Detergente Ace 1kg	\N	34	58	8.00	10.50	100	10	2024-10-02 00:00:00
1175	Detergente Foca 1/2 kg	\N	34	58	8.00	10.50	100	10	2024-10-02 00:00:00
1176	Detergente Foca 1kg	\N	34	58	8.00	10.50	100	10	2024-10-02 00:00:00
1177	Suavitel 1l	\N	34	58	8.00	10.50	100	10	2024-10-02 00:00:00
1178	Papel higienico Petalo 4 rollos	\N	37	58	8.00	10.50	100	10	2024-10-02 00:00:00
1179	Papel higienico Petalo 6 rollos	\N	37	58	8.00	10.50	100	10	2024-10-02 00:00:00
1180	Papel higienico Suavel 4 rollos	\N	37	58	8.00	10.50	100	10	2024-10-02 00:00:00
1181	Papel higienico Suavel 6 rollos	\N	37	58	8.00	10.50	100	10	2024-10-02 00:00:00
1182	Toallas sanitarias Always	\N	37	58	8.00	10.50	100	10	2024-10-02 00:00:00
1183	Toallas sanitarias Kotex	\N	37	58	8.00	10.50	100	10	2024-10-02 00:00:00
1184	Pa¤ales Huggies	\N	44	58	8.00	10.50	100	10	2024-10-02 00:00:00
1185	Shampoo Head & Shoulders chico	\N	39	58	8.00	10.50	100	10	2024-10-02 00:00:00
1186	Shampoo Head & Shoulders grande	\N	39	58	8.00	10.50	100	10	2024-10-02 00:00:00
1187	Desodorante Axe	\N	41	58	8.00	10.50	100	10	2024-10-02 00:00:00
1188	Leche deslactosada 1lt	Presentacion azul	15	4	18.20	23.00	14	2	2024-10-02 00:00:00
1189	Harina de maiz maseca	\N	10	59	8.00	10.50	100	10	2024-10-06 00:00:00
1190	Harina de trigo San antonio	\N	10	41	8.00	10.50	100	10	2024-10-06 00:00:00
1191	Tortillas de maiz 1/2 kg	\N	10	58	8.00	10.50	100	10	2024-10-06 00:00:00
1192	Pan bimbo blanco chico	\N	27	17	8.00	10.50	100	10	2024-10-06 00:00:00
1193	Pan bimbo blanco grande	\N	27	17	8.00	10.50	100	10	2024-10-06 00:00:00
1194	Pan bimbo integral chico	\N	27	17	8.00	10.50	100	10	2024-10-06 00:00:00
1195	Pan bimbo integral grande	\N	27	17	8.00	10.50	100	10	2024-10-06 00:00:00
1196	Rebanadas bimbo	\N	27	17	8.00	10.50	100	10	2024-10-06 00:00:00
1197	Chocoroles	\N	27	17	8.00	10.50	100	10	2024-10-06 00:00:00
1198	Nito bimbo	\N	27	17	8.00	10.50	100	10	2024-10-06 00:00:00
1199	Mantecadas	\N	27	17	8.00	10.50	100	10	2024-10-06 00:00:00
1200	Roles de canela con pasas	\N	27	17	8.00	10.50	100	10	2024-10-06 00:00:00
1201	Roles de canela glaseados	\N	27	17	8.00	10.50	100	10	2024-10-06 00:00:00
1202	Conchas bimbo	\N	27	17	8.00	10.50	100	10	2024-10-06 00:00:00
1203	Panque de nuez bimbo	\N	27	17	8.00	10.50	100	10	2024-10-06 00:00:00
1204	Donitas bimbo	\N	27	17	8.00	10.50	100	10	2024-10-06 00:00:00
1205	Donitas espolvoreadas bimbo	\N	27	17	8.00	10.50	100	10	2024-10-06 00:00:00
1206	chimichangas	chimichangas	23	10	30.00	45.00	15	5	2024-10-06 00:00:00
1207	Roles	Ricos roles de canela caseros	27	13	70.00	100.00	19	10	2024-10-06 00:00:00
1208	Pepsi	bebida azucarada	31	14	8.00	16.00	77	20	2024-10-06 00:00:00
1209	Manzanita		31	14	17.00	25.00	22	3	2024-10-06 00:00:00
1210	MaruchanTokyo	maruchan picante	2	11	5.50	12.50	15	10	2024-10-06 00:00:00
1211	Sabritas	Sabritas Flamin Hot	9	3	10.00	18.00	4	1	2024-10-06 00:00:00
1212	Galletas marias	Las galletas clasicas	9	3	8.90	15.00	19	2	2024-10-06 00:00:00
1213	Leche entera lala 1lt	Clasica color roja	15	4	15.24	25.00	11	3	2024-10-06 00:00:00
1214	Leche Lala entera 1L	Leche Lala entera 1 Litro	15	4	19.00	24.00	100	10	2024-10-06 00:00:00
1215	Tostadas charras	\N	5	60	8.00	10.50	100	10	2024-10-06 00:00:00
1216	Coca Cola 1L	Refresco Coca Cola 1 Litro	31	16	12.00	15.00	100	10	2024-10-06 00:00:00
1217	Coca Cola lata 355ml	Refresco Coca Cola 355 ml lata	31	16	8.50	11.00	100	10	2024-10-06 00:00:00
1218	Coca Cola 355ml	Refresco Coca Cola 355 ml	31	16	8.00	10.50	100	10	2024-10-06 00:00:00
1219	Coca Cola 600ml	Refresco Coca Cola 600 ml	31	16	9.00	12.00	100	10	2024-10-06 00:00:00
1220	Coca Cola retornable 1 1/4 lt.	Refresco Coca Cola retornable 1 1/4 lt	31	16	12.50	15.50	100	10	2024-10-06 00:00:00
1221	Coca Cola 2L retornable	Refresco Coca Cola retornable 2 Litros	31	16	19.50	24.00	100	10	2024-10-06 00:00:00
1222	Coca Cola 3L retornable	Refresco Coca Cola retornable 3 Litros	31	16	24.00	30.00	100	10	2024-10-06 00:00:00
1223	Coca Cola Light 600ml	Refresco Coca Cola Light 600 ml	31	16	9.50	12.50	100	10	2024-10-06 00:00:00
1224	Pepsi 600ml	Refresco Pepsi 600 ml	31	14	9.00	12.00	100	10	2024-10-06 00:00:00
1225	Pepsi 1.5L	Refresco Pepsi 1.5 Litros	31	14	12.00	15.50	100	10	2024-10-06 00:00:00
1226	Fanta 600ml	Refresco Fanta 600 ml	31	16	9.00	12.00	100	10	2024-10-06 00:00:00
1227	Fanta 1.5L	Refresco Fanta 1.5 Litros	31	16	12.50	16.00	100	10	2024-10-06 00:00:00
1228	Sprite 600ml	Refresco Sprite 600 ml	31	16	9.00	12.00	100	10	2024-10-06 00:00:00
1229	Sprite 1.5L	Refresco Sprite 1.5 Litros	31	16	12.50	16.00	100	10	2024-10-06 00:00:00
1230	Manzanita 600ml	Refresco Manzanita Sol 600 ml	31	16	9.00	12.00	100	10	2024-10-06 00:00:00
1231	Manzanita 1.5L	Refresco Manzanita Sol 1.5 Litros	31	16	12.50	16.00	100	10	2024-10-06 00:00:00
1232	Fresca 600ml	Refresco Fresca 600 ml	31	16	9.00	12.00	100	10	2024-10-06 00:00:00
1233	Fresca 3L	Refresco Fresca 3 Litros	31	16	24.00	30.00	100	10	2024-10-06 00:00:00
1234	Mirinda 600ml	Refresco Mirinda 600 ml	31	16	9.00	12.00	100	10	2024-10-06 00:00:00
1235	Mirinda 1.5L	Refresco Mirinda 1.5 Litros	31	16	12.50	16.00	100	10	2024-10-06 00:00:00
1236	Tostadas Sanissimo	\N	5	61	8.00	10.50	100	10	2024-10-06 00:00:00
1237	Marias gamesa	\N	29	46	8.00	10.50	100	10	2024-10-06 00:00:00
1238	Jumex de mango 1L	Jugo Jumex sabor Mango 1 Litro	31	21	16.00	20.00	100	10	2024-10-06 00:00:00
1239	Emperador chocolate	\N	29	46	8.00	10.50	100	10	2024-10-06 00:00:00
1240	Emperador nuez	\N	29	46	8.00	10.50	100	10	2024-10-06 00:00:00
1241	Emperador vainilla	\N	29	46	8.00	10.50	100	10	2024-10-06 00:00:00
1242	Emperador limon	\N	29	46	8.00	10.50	100	10	2024-10-06 00:00:00
1243	Jumex de durazno 1L	Jugo Jumex sabor Durazno 1 Litro	31	21	16.00	20.00	100	10	2024-10-06 00:00:00
1244	Jumex de manzana 600ml	Jugo Jumex sabor Manzana 600 ml	31	21	10.00	13.00	100	10	2024-10-06 00:00:00
1245	Del Valle fruit naranja 600ml	Jugo Del Valle sabor Naranja 600 ml	31	28	10.50	13.50	100	10	2024-10-06 00:00:00
1246	Del Valle fruit manzana 600ml	Jugo Del Valle sabor Manzana 600 ml	31	28	10.50	13.50	100	10	2024-10-06 00:00:00
1247	Del Valle fruit guayaba 600ml	Jugo Del Valle sabor Guayaba 600 ml	31	28	10.50	13.50	100	10	2024-10-06 00:00:00
1248	Emperador Senso	\N	29	46	8.00	10.50	100	10	2024-10-06 00:00:00
1249	Mamut chico	\N	29	46	8.00	10.50	100	10	2024-10-06 00:00:00
1250	Yogurt Lala natural 1L	Yogurt Lala natural 1 Litro	17	4	25.00	30.00	100	10	2024-10-06 00:00:00
1251	Yogurt Lala de fresa 1L	Yogurt Lala sabor Fresa 1 Litro	17	4	25.00	30.00	100	10	2024-10-06 00:00:00
1252	Yogurt Yoplait natural 1L	Yogurt Yoplait natural 1 Litro	17	54	26.00	31.00	100	10	2024-10-06 00:00:00
1253	Yogurt Yoplait de fresa 1L	Yogurt Yoplait sabor Fresa 1 Litro	17	54	26.00	31.00	100	10	2024-10-06 00:00:00
1254	Mantequilla Lala 250g	Mantequilla Lala 250 gramos	19	4	30.00	38.00	100	10	2024-10-06 00:00:00
1255	Queso panela Lala 200g	Queso panela Lala 200 gramos	16	4	40.00	50.00	100	10	2024-10-06 00:00:00
1256	Mamut grande	\N	29	46	8.00	10.50	100	10	2024-10-06 00:00:00
1257	Chokis	\N	29	46	8.00	10.50	100	10	2024-10-06 00:00:00
1258	Chokis rellenas	\N	29	46	8.00	10.50	100	10	2024-10-06 00:00:00
1259	Chokis doble chocolate	\N	29	46	8.00	10.50	100	10	2024-10-06 00:00:00
1260	Chokis brownie	\N	29	46	8.00	10.50	100	10	2024-10-06 00:00:00
1261	Leche Lala deslactosada 1L	Leche Lala deslactosada 1 Litro	15	4	20.00	25.00	100	10	2024-10-06 00:00:00
1262	Leche Lala light 1L	Leche Lala light 1 Litro	15	4	20.00	25.00	100	10	2024-10-06 00:00:00
1263	Leche Santa Clara entera 1L	Leche Santa Clara entera 1 Litro	15	4	22.00	28.00	100	10	2024-10-06 00:00:00
1264	Leche Santa Clara deslactosada 1L	Leche Santa Clara deslactosada 1 Litro	15	4	23.00	29.00	100	10	2024-10-06 00:00:00
1265	Arroz Mexica 1kg	None	2	59	12.00	16.50	100	10	2024-10-06 00:00:00
1266	Queso panela Alpura 200g	Queso panela Alpura 200 gramos	16	18	40.00	50.00	100	10	2024-10-06 00:00:00
1267	Queso oaxaca Lala 200g	Queso Oaxaca Lala 200 gramos	16	4	45.00	55.00	100	10	2024-10-06 00:00:00
1268	Queso manchego Lala 200g	Queso Manchego Lala 200 gramos	16	4	50.00	60.00	100	10	2024-10-06 00:00:00
1269	Salchichas Fud paquete 500g	Salchichas Fud 500 gramos	18	53	30.00	40.00	100	10	2024-10-06 00:00:00
1270	Salchichas San Rafael paquete 500g	Salchichas San Rafael 500 gramos	18	52	35.00	45.00	100	10	2024-10-06 00:00:00
1271	Jam¢n de pavo Fud 250g	Jam¢n de Pavo Fud 250 gramos	18	53	35.00	45.00	100	10	2024-10-06 00:00:00
1272	Jam¢n de pavo San Rafael 250g	Jam¢n de Pavo San Rafael 250 gramos	18	52	40.00	50.00	100	10	2024-10-06 00:00:00
1273	Sidral mundet 600ml	Refresco de manzana de 600ml	31	16	10.00	16.00	20	5	2024-10-06 00:00:00
1274	Sidral mundet 3lt	Refresco de manzana de 3lt	31	16	24.00	30.00	20	5	2024-10-06 00:00:00
1275	Agua bonafont 600ml	\N	30	55	8.00	10.50	100	10	2024-10-06 00:00:00
1276	Agua bonafont 1lt	\N	30	55	12.00	15.00	100	10	2024-10-06 00:00:00
1277	Agua bonafont 2lt.	\N	30	55	14.00	18.00	100	10	2024-10-06 00:00:00
1278	Garrafon bonafont 20lt	\N	30	55	19.50	24.00	100	10	2024-10-06 00:00:00
1279	Agua ciel 600ml	\N	30	16	8.00	13.00	100	10	2024-10-06 00:00:00
1280	Agua ciel 1lt	\N	30	16	10.00	15.00	100	10	2024-10-06 00:00:00
1281	Agua ciel 1.5l	\N	30	16	12.00	17.00	100	10	2024-10-06 00:00:00
1282	Agua ciel 2lt	\N	30	16	14.00	20.00	100	10	2024-10-06 00:00:00
1283	Agua E-pura 600ml	\N	30	14	8.00	13.00	100	10	2024-10-06 00:00:00
1284	Agua E-pura 1lt	\N	30	14	10.00	15.00	100	10	2024-10-06 00:00:00
1285	Garrafon E-pura 10lt	\N	30	14	18.00	25.00	100	10	2024-10-06 00:00:00
1286	Crema Lala 200ml	\N	15	4	8.00	13.00	100	10	2024-10-06 00:00:00
1287	Crema Lala 426ml	\N	15	4	15.00	30.00	100	10	2024-10-06 00:00:00
1288	Crema Lala 900ml	\N	15	4	35.00	55.00	100	10	2024-10-06 00:00:00
1289	Crema alpura 200ml	\N	15	4	8.00	13.00	100	10	2024-10-06 00:00:00
1290	Crema alpura 426ml	\N	15	4	15.00	30.00	100	10	2024-10-06 00:00:00
1291	Crema alpura 900ml	\N	15	4	35.00	55.00	100	10	2024-10-06 00:00:00
1292	Atun dolores en agua	\N	6	51	10.00	15.00	100	10	2024-10-06 00:00:00
1293	Atun dolores en aceite	\N	6	51	12.00	17.00	100	10	2024-10-06 00:00:00
1294	Sardinas en aceite	\N	6	20	10.00	15.00	100	10	2024-10-06 00:00:00
1295	Frijoles refritos	\N	6	50	10.00	15.00	100	10	2024-10-06 00:00:00
1296	Frijoles bayos	\N	6	50	10.00	15.00	100	10	2024-10-06 00:00:00
1297	Lentejas la moderna	\N	2	44	10.00	15.00	100	10	2024-10-06 00:00:00
1298	Pasta la moderna	\N	2	44	10.00	15.00	100	10	2024-10-06 00:00:00
1299	Coditos la moderna	\N	2	44	10.00	15.00	100	10	2024-10-06 00:00:00
1300	Pasta Barilla espagueti	\N	2	56	10.00	15.00	100	10	2024-10-06 00:00:00
1301	Sopa de letras la moderna	\N	2	44	10.00	15.00	100	10	2024-10-06 00:00:00
1302	Sopa maruchan pollo	\N	2	57	10.00	15.00	100	10	2024-10-06 00:00:00
1303	Sopa maruchan camaron	\N	2	57	10.00	15.00	100	10	2024-10-06 00:00:00
1304	Sopa maruchan res	\N	2	57	10.00	15.00	100	10	2024-10-06 00:00:00
1305	Sopa maruchan habanero	\N	2	57	10.00	15.00	100	10	2024-10-06 00:00:00
1306	Sopa maruchan piquin	\N	2	57	10.00	15.00	100	10	2024-10-06 00:00:00
1307	Sopa maruchan limon	\N	2	57	10.00	15.00	100	10	2024-10-06 00:00:00
1308	Cremax vainilla	\N	29	46	8.00	10.50	100	10	2024-10-06 00:00:00
1309	Cremax chocolate	\N	29	46	8.00	10.50	100	10	2024-10-06 00:00:00
1310	Cremax fresa	\N	29	46	8.00	10.50	100	10	2024-10-06 00:00:00
1311	Florentinas gamesa	\N	29	46	8.00	10.50	100	10	2024-10-06 00:00:00
1312	Marias doradas	\N	29	46	8.00	10.50	100	10	2024-10-06 00:00:00
1313	Gamesa cajeta	\N	29	46	8.00	10.50	100	10	2024-10-06 00:00:00
1314	Maravillas gamesa	\N	29	46	8.00	10.50	100	10	2024-10-06 00:00:00
1315	Crackets gamesa	\N	29	46	8.00	10.50	100	10	2024-10-06 00:00:00
1316	Surtido rico gamesa	\N	29	46	8.00	10.50	100	10	2024-10-06 00:00:00
1317	Delicias gamesa	\N	29	46	8.00	10.50	100	10	2024-10-06 00:00:00
1318	Oreo	\N	9	58	8.00	10.50	100	10	2024-10-06 00:00:00
1319	Principe chocolate	\N	9	22	8.00	10.50	100	10	2024-10-06 00:00:00
1320	Principe vainilla	\N	9	22	8.00	10.50	100	10	2024-10-06 00:00:00
1321	Principe limon	\N	9	22	8.00	10.50	100	10	2024-10-06 00:00:00
1322	Principe chocolate blanco	\N	9	22	8.00	10.50	100	10	2024-10-06 00:00:00
1323	Lors	\N	9	22	8.00	10.50	100	10	2024-10-06 00:00:00
1324	Plativolos	\N	9	22	8.00	10.50	100	10	2024-10-06 00:00:00
1325	Sponch	\N	9	22	8.00	10.50	100	10	2024-10-06 00:00:00
1326	Triki trakes	\N	9	22	8.00	10.50	100	10	2024-10-06 00:00:00
1327	MaxiTubo Triki trakes	\N	9	22	8.00	10.50	100	10	2024-10-06 00:00:00
1328	Gansito	\N	9	22	8.00	10.50	100	10	2024-10-06 00:00:00
1329	Pinguinos	\N	9	22	8.00	10.50	100	10	2024-10-06 00:00:00
1330	Pasticetas marinela	\N	9	22	8.00	10.50	100	10	2024-10-06 00:00:00
1331	Barritas fresa	\N	9	22	8.00	10.50	100	10	2024-10-06 00:00:00
1332	Barritas pina	\N	9	22	8.00	10.50	100	10	2024-10-06 00:00:00
1333	Barritas moras	\N	9	22	8.00	10.50	100	10	2024-10-06 00:00:00
1334	Maxitubo Barritas fresa	\N	9	22	8.00	10.50	100	10	2024-10-06 00:00:00
1335	Maxitubo Barritas pina	\N	9	22	8.00	10.50	100	10	2024-10-06 00:00:00
1336	Canelitas	\N	9	22	8.00	10.50	100	10	2024-10-06 00:00:00
1337	Polvorones	\N	9	22	8.00	10.50	100	10	2024-10-06 00:00:00
1338	Maxitubo Polvorones	\N	9	22	8.00	10.50	100	10	2024-10-06 00:00:00
1339	Ricanelas	\N	9	46	8.00	10.50	100	10	2024-10-06 00:00:00
1340	Ritz bits queso	\N	9	58	8.00	10.50	100	10	2024-10-06 00:00:00
1341	Arcoiris	\N	9	46	8.00	10.50	100	10	2024-10-06 00:00:00
1342	Submarinos fresa	\N	9	22	8.00	10.50	100	10	2024-10-06 00:00:00
1343	Submarinos vainilla	\N	9	22	8.00	10.50	100	10	2024-10-06 00:00:00
1344	Submarinos chocolate	\N	9	22	8.00	10.50	100	10	2024-10-06 00:00:00
1345	Rocko chico	\N	9	22	8.00	10.50	100	10	2024-10-06 00:00:00
1346	Rocko grande	\N	9	22	8.00	10.50	100	10	2024-10-06 00:00:00
1347	Sabritas original	\N	9	3	8.00	10.50	100	10	2024-10-06 00:00:00
1348	Sabritas adobadas	\N	9	3	8.00	10.50	100	10	2024-10-06 00:00:00
1349	Sabritas limon	\N	9	3	8.00	10.50	100	10	2024-10-06 00:00:00
1350	Sabritas flamin hot	\N	9	3	8.00	10.50	100	10	2024-10-06 00:00:00
1351	Sabritas crema y especias	\N	9	3	8.00	10.50	100	10	2024-10-06 00:00:00
1352	Sabritas habanero	\N	9	3	8.00	10.50	100	10	2024-10-06 00:00:00
1353	Sabritas receta crujiente	\N	9	3	8.00	10.50	100	10	2024-10-06 00:00:00
1354	Sabritas receta crujiente jalapeno	\N	9	3	8.00	10.50	100	10	2024-10-06 00:00:00
1355	Crujitos	\N	9	3	8.00	10.50	100	10	2024-10-06 00:00:00
1356	Doritos nacho	\N	9	3	8.00	10.50	100	10	2024-10-06 00:00:00
1357	Doritos incognita	\N	9	3	8.00	10.50	100	10	2024-10-06 00:00:00
1358	Doritos diablo	\N	9	3	8.00	10.50	100	10	2024-10-06 00:00:00
1359	Doritos flamin hot	\N	9	3	8.00	10.50	100	10	2024-10-06 00:00:00
1360	Doritos dinamita	\N	9	3	8.00	10.50	100	10	2024-10-06 00:00:00
1361	Sabritones	\N	9	3	8.00	10.50	100	10	2024-10-06 00:00:00
1362	Bigmix queso	\N	9	47	8.00	10.50	100	10	2024-10-06 00:00:00
1363	Bigmix fuego	\N	9	47	8.00	10.50	100	10	2024-10-06 00:00:00
1364	Cheetos torciditos	\N	9	3	8.00	10.50	100	10	2024-10-06 00:00:00
1365	Cheetos bolitas	\N	9	3	8.00	10.50	100	10	2024-10-06 00:00:00
1366	Cheetos queso	\N	9	3	8.00	10.50	100	10	2024-10-06 00:00:00
1367	Cheetos flamin hot	\N	9	3	8.00	10.50	100	10	2024-10-06 00:00:00
1368	Ruffles original	\N	9	3	8.00	10.50	100	10	2024-10-06 00:00:00
1369	Ruffles queso	\N	9	3	8.00	10.50	100	10	2024-10-06 00:00:00
1370	Fritos sal y limon	\N	9	3	8.00	10.50	100	10	2024-10-06 00:00:00
1371	Fritos chorizo	\N	9	3	8.00	10.50	100	10	2024-10-06 00:00:00
1372	Bolsaza Sabritas original	\N	9	3	8.00	10.50	100	10	2024-10-06 00:00:00
1373	Bolsaza Doritos nacho	\N	9	3	8.00	10.50	100	10	2024-10-06 00:00:00
1374	Paketaxo	\N	9	3	8.00	10.50	100	10	2024-10-06 00:00:00
1375	Paketaxo queso	\N	9	3	8.00	10.50	100	10	2024-10-06 00:00:00
1376	Paketaxo flamin hot	\N	9	3	8.00	10.50	100	10	2024-10-06 00:00:00
1377	Churrumaiz	\N	9	3	8.00	10.50	100	10	2024-10-06 00:00:00
1378	Churrumaiz flamin hot	\N	9	3	8.00	10.50	100	10	2024-10-06 00:00:00
1379	Rancheritos	\N	9	3	8.00	10.50	100	10	2024-10-06 00:00:00
1380	Sabritas switch doritos nacho	\N	9	3	8.00	10.50	100	10	2024-10-06 00:00:00
1381	Runners	\N	9	47	8.00	10.50	100	10	2024-10-06 00:00:00
1382	Chips jalapeno	\N	9	47	8.00	10.50	100	10	2024-10-06 00:00:00
1383	Chips sal	\N	9	47	8.00	10.50	100	10	2024-10-06 00:00:00
1384	Papatinas	\N	9	47	8.00	10.50	100	10	2024-10-06 00:00:00
1385	Chips fuego	\N	9	47	8.00	10.50	100	10	2024-10-06 00:00:00
1386	Palomitas pop	\N	9	47	8.00	10.50	100	10	2024-10-06 00:00:00
1387	Takis original 	\N	9	47	8.00	10.50	100	10	2024-10-06 00:00:00
1388	Takis fuego	\N	9	47	8.00	10.50	100	10	2024-10-06 00:00:00
1389	Takis salsa brava	\N	9	47	8.00	10.50	100	10	2024-10-06 00:00:00
1390	Takis guacamole	\N	9	47	8.00	10.50	100	10	2024-10-06 00:00:00
1391	Chipotles	\N	9	47	8.00	10.50	100	10	2024-10-06 00:00:00
1392	Tostachos	\N	9	47	8.00	10.50	100	10	2024-10-06 00:00:00
1393	Hot nuts	\N	9	47	8.00	10.50	100	10	2024-10-06 00:00:00
1394	Hot nuts fuego	\N	9	47	8.00	10.50	100	10	2024-10-06 00:00:00
1395	Valentones	\N	9	47	8.00	10.50	100	10	2024-10-06 00:00:00
1396	Watz barcel	\N	9	47	8.00	10.50	100	10	2024-10-06 00:00:00
1397	Toreadas	\N	9	47	8.00	10.50	100	10	2024-10-06 00:00:00
1398	Palomitas pop fuego	\N	9	47	8.00	10.50	100	10	2024-10-06 00:00:00
1399	Takis blue heat	\N	9	47	8.00	10.50	100	10	2024-10-06 00:00:00
1400	Doraditas tia rosa	\N	29	49	8.00	10.50	100	10	2024-10-06 00:00:00
1401	Bigote tia rosa	\N	29	49	8.00	10.50	100	10	2024-10-06 00:00:00
1402	Tortillinas tia rosa	\N	10	49	8.00	10.50	100	10	2024-10-06 00:00:00
1403	Magdalenas tia rosa	\N	29	49	8.00	10.50	100	10	2024-10-06 00:00:00
1404	Conchas tia rosa	\N	29	49	8.00	10.50	100	10	2024-10-06 00:00:00
1405	Hersheys Cookies n Cream	\N	8	45	8.00	10.50	100	10	2024-10-06 00:00:00
1406	Hersheys almendras	\N	8	45	8.00	10.50	100	10	2024-10-06 00:00:00
1407	Hersheys chocolate amargo	\N	8	45	8.00	10.50	100	10	2024-10-06 00:00:00
1408	Hersheys chocolate blanco	\N	8	45	8.00	10.50	100	10	2024-10-06 00:00:00
1409	Crunch	\N	8	19	8.00	10.50	100	10	2024-10-06 00:00:00
1410	Carlos V	\N	8	19	8.00	10.50	100	10	2024-10-06 00:00:00
1411	Milky way	\N	8	19	8.00	10.50	100	10	2024-10-06 00:00:00
1412	Snickers	\N	8	19	8.00	10.50	100	10	2024-10-06 00:00:00
1413	Kit kat	\N	8	19	8.00	10.50	100	10	2024-10-06 00:00:00
1414	Kinder delice	\N	8	40	8.00	10.50	100	10	2024-10-06 00:00:00
1415	Kinder sorpresa	\N	8	40	8.00	10.50	100	10	2024-10-06 00:00:00
1416	Ferrero rocher 3 piezas	\N	8	40	8.00	10.50	100	10	2024-10-06 00:00:00
1417	Mazapan	\N	8	62	8.00	10.50	100	10	2024-10-06 00:00:00
1418	Pelon pelo rico	\N	8	45	8.00	10.50	100	10	2024-10-06 00:00:00
1419	Pulparindo tamarindo	\N	8	62	8.00	10.50	100	10	2024-10-06 00:00:00
1420	Pulparindo chamoy	\N	8	62	8.00	10.50	100	10	2024-10-06 00:00:00
1421	Tutsi pop	\N	8	65	8.00	10.50	100	10	2024-10-06 00:00:00
1422	Oblea cajeta coronado	\N	8	66	8.00	10.50	100	10	2024-10-06 00:00:00
1423	Paleta payaso	\N	8	67	8.00	10.50	100	10	2024-10-06 00:00:00
1424	Duvalin fresa vainilla	\N	8	67	8.00	10.50	100	10	2024-10-06 00:00:00
1425	Duvalin chocolate vainilla	\N	8	67	8.00	10.50	100	10	2024-10-06 00:00:00
1426	Duvalin vainilla	\N	8	67	8.00	10.50	100	10	2024-10-06 00:00:00
1427	Duvalin trisabor	\N	8	67	8.00	10.50	100	10	2024-10-06 00:00:00
1428	Duvalin choco avellana	\N	8	67	8.00	10.50	100	10	2024-10-06 00:00:00
1429	Paleta Vero mango	\N	8	68	8.00	10.50	100	10	2024-10-06 00:00:00
1430	Paleta Vero elote	\N	8	67	8.00	10.50	100	10	2024-10-06 00:00:00
1431	Panditas	\N	8	67	8.00	10.50	100	10	2024-10-06 00:00:00
1432	Panditas rellenos	\N	8	67	8.00	10.50	100	10	2024-10-06 00:00:00
1433	Panditas san valentin	\N	8	67	8.00	10.50	100	10	2024-10-06 00:00:00
1434	Bubulubu	\N	8	67	8.00	10.50	100	10	2024-10-06 00:00:00
1435	Rockaleta	\N	8	69	8.00	10.50	100	10	2024-10-06 00:00:00
1436	Tic tac menta	\N	8	40	8.00	10.50	100	10	2024-10-06 00:00:00
1437	Tic tac naranja	\N	8	40	8.00	10.50	100	10	2024-10-06 00:00:00
1438	Halls menta	\N	8	58	8.00	10.50	100	10	2024-10-06 00:00:00
1439	Halls limon	\N	8	58	8.00	10.50	100	10	2024-10-06 00:00:00
1440	Halls yerba buena	\N	8	58	8.00	10.50	100	10	2024-10-06 00:00:00
1441	Halls miel	\N	8	58	8.00	10.50	100	10	2024-10-06 00:00:00
1442	Halls negras	\N	8	58	8.00	10.50	100	10	2024-10-06 00:00:00
1443	Gomilocas dientes	\N	8	67	8.00	10.50	100	10	2024-10-06 00:00:00
1444	Gomilocas pinguino	\N	8	67	8.00	10.50	100	10	2024-10-06 00:00:00
1445	Chocoretas	\N	8	67	8.00	10.50	100	10	2024-10-06 00:00:00
1446	Kranky	\N	8	67	8.00	10.50	100	10	2024-10-06 00:00:00
1447	Lucas muecas	\N	8	58	8.00	10.50	100	10	2024-10-06 00:00:00
1448	Lucas chamoy	\N	8	58	8.00	10.50	100	10	2024-10-06 00:00:00
1449	Lucas gusanito	\N	8	58	8.00	10.50	100	10	2024-10-06 00:00:00
1450	Palomitas Act II mantequilla	\N	9	58	8.00	10.50	100	10	2024-10-06 00:00:00
1451	Palomitas Act II natural	\N	9	58	8.00	10.50	100	10	2024-10-06 00:00:00
1452	Palomitas Act II chile limon	\N	9	58	8.00	10.50	100	10	2024-10-06 00:00:00
1453	Tostitos salsa verde	\N	9	3	8.00	10.50	100	10	2024-10-06 00:00:00
1454	Zucaritas chicas	\N	5	26	8.00	10.50	100	10	2024-10-06 00:00:00
1455	Zucaritas grandes	\N	5	26	8.00	10.50	100	10	2024-10-06 00:00:00
1456	Corn flakes chicas	\N	5	26	8.00	10.50	100	10	2024-10-06 00:00:00
1457	Corn flakes grandes	\N	5	26	8.00	10.50	100	10	2024-10-06 00:00:00
1458	Choco Krispis chicas	\N	5	26	8.00	10.50	100	10	2024-10-06 00:00:00
1459	Choco Krispis grandes	\N	5	26	8.00	10.50	100	10	2024-10-06 00:00:00
1460	Nesquik chico	\N	5	26	8.00	10.50	100	10	2024-10-06 00:00:00
1461	Nesquik grande	\N	5	26	8.00	10.50	100	10	2024-10-06 00:00:00
1462	Froot loops chicas	\N	5	26	8.00	10.50	100	10	2024-10-06 00:00:00
1463	Froot loops grandes	\N	5	26	8.00	10.50	100	10	2024-10-06 00:00:00
1464	Chocomilk sobre	\N	4	58	8.00	10.50	100	10	2024-10-06 00:00:00
1465	Chocomilk bolsa	\N	4	58	8.00	10.50	100	10	2024-10-06 00:00:00
1466	Chocomilk lata	\N	4	58	8.00	10.50	100	10	2024-10-06 00:00:00
1467	Nescafe clasico sobre	\N	4	19	8.00	10.50	100	10	2024-10-06 00:00:00
1468	Nescafe capuccino sobre	\N	4	19	8.00	10.50	100	10	2024-10-06 00:00:00
1469	Nescafe clasico bote chico	\N	4	19	8.00	10.50	100	10	2024-10-06 00:00:00
1470	Nescafe clasico bote grande	\N	4	19	8.00	10.50	100	10	2024-10-06 00:00:00
1471	Azucar Zulka 1kg	\N	3	58	8.00	10.50	100	10	2024-10-06 00:00:00
1472	Azucar refinada 1kg	\N	3	58	8.00	10.50	100	10	2024-10-06 00:00:00
1473	Azucar refinada 500gr	\N	3	58	8.00	10.50	100	10	2024-10-06 00:00:00
1474	Azucar refinada 250gr	\N	3	58	8.00	10.50	100	10	2024-10-06 00:00:00
1475	Aceite nutrioli 1lt	\N	1	58	8.00	10.50	100	10	2024-10-06 00:00:00
1476	Aceite capullo 1lt	\N	1	58	8.00	10.50	100	10	2024-10-06 00:00:00
1477	Aceite 1 2 3 1lt	\N	1	58	8.00	10.50	100	10	2024-10-06 00:00:00
1478	Aceite patrona 1lt	\N	1	58	8.00	10.50	100	10	2024-10-06 00:00:00
1479	Vinagre blanco la coste¤a	\N	1	27	8.00	10.50	100	10	2024-10-06 00:00:00
1480	Vinagre de manzana la coste¤a	\N	1	27	8.00	10.50	100	10	2024-10-06 00:00:00
1481	Catsup la coste¤a	\N	1	27	8.00	10.50	100	10	2024-10-06 00:00:00
1482	Catsup Del monte	\N	1	70	8.00	10.50	100	10	2024-10-06 00:00:00
1483	Catsup heinz	\N	1	71	8.00	10.50	100	10	2024-10-06 00:00:00
1484	Jugo Magui	\N	7	19	8.00	10.50	100	10	2024-10-06 00:00:00
1485	Salsa inglesa	\N	7	19	8.00	10.50	100	10	2024-10-06 00:00:00
1486	Salsa valentina chica	\N	7	58	8.00	10.50	100	10	2024-10-06 00:00:00
1487	Salsa valentina grande	\N	7	58	8.00	10.50	100	10	2024-10-06 00:00:00
1488	Salsa tabasco	\N	7	58	8.00	10.50	100	10	2024-10-06 00:00:00
1489	Salsa buffalo	\N	7	58	8.00	10.50	100	10	2024-10-06 00:00:00
1490	Salsa chipotle la coste¤a	\N	7	27	8.00	10.50	100	10	2024-10-06 00:00:00
1491	Chile chipotle la coste¤a	\N	6	27	8.00	10.50	100	10	2024-10-06 00:00:00
1492	Chiles serranos la coste¤a	\N	6	27	8.00	10.50	100	10	2024-10-06 00:00:00
1493	Chiles en vinagre la coste¤a	\N	6	27	8.00	10.50	100	10	2024-10-06 00:00:00
1494	Chile chipotle la morena	\N	6	72	8.00	10.50	100	10	2024-10-06 00:00:00
1495	Chiles en vinagre la morena	\N	6	72	8.00	10.50	100	10	2024-10-06 00:00:00
1496	Mayonesa mccormick chica	\N	7	72	8.00	10.50	100	10	2024-10-06 00:00:00
1497	Mayonesa mccormick grande	\N	7	72	8.00	10.50	100	10	2024-10-06 00:00:00
1498	Mostaza mccormick	\N	7	72	8.00	10.50	100	10	2024-10-06 00:00:00
1499	Mermelada mccormick fresa chica	\N	19	72	8.00	10.50	100	10	2024-10-06 00:00:00
1500	Mermelada mccormick fresa grande	\N	19	72	8.00	10.50	100	10	2024-10-06 00:00:00
1501	Cloralex 1/2 lt	\N	35	58	8.00	10.50	100	10	2024-10-06 00:00:00
1502	Cloralex 1 lt	\N	35	58	8.00	10.50	100	10	2024-10-06 00:00:00
1503	Pinol	\N	35	58	8.00	10.50	100	10	2024-10-06 00:00:00
1504	Fabuloso lavanda 1lt	\N	35	58	8.00	10.50	100	10	2024-10-06 00:00:00
1505	Fabuloso aroma floral 1lt	\N	35	58	8.00	10.50	100	10	2024-10-06 00:00:00
1506	Jab¢n zote rosa chico	\N	42	58	8.00	10.50	100	10	2024-10-06 00:00:00
1507	Jab¢n zote rosa grande	\N	42	58	8.00	10.50	100	10	2024-10-06 00:00:00
1508	Jab¢n zote blanco chico	\N	42	58	8.00	10.50	100	10	2024-10-06 00:00:00
1509	Jab¢n zote blanco grande	\N	42	58	8.00	10.50	100	10	2024-10-06 00:00:00
1510	Detergente Ariel 1/2 kg	\N	34	58	8.00	10.50	100	10	2024-10-06 00:00:00
1511	Detergente Ariel 1kg	\N	34	58	8.00	10.50	100	10	2024-10-06 00:00:00
1512	Detergente Ace 1/2 kg	\N	34	58	8.00	10.50	100	10	2024-10-06 00:00:00
1513	Detergente Ace 1kg	\N	34	58	8.00	10.50	100	10	2024-10-06 00:00:00
1514	Detergente Foca 1/2 kg	\N	34	58	8.00	10.50	100	10	2024-10-06 00:00:00
1515	Detergente Foca 1kg	\N	34	58	8.00	10.50	100	10	2024-10-06 00:00:00
1516	Suavitel 1l	\N	34	58	8.00	10.50	100	10	2024-10-06 00:00:00
1517	Papel higienico Petalo 4 rollos	\N	37	58	8.00	10.50	100	10	2024-10-06 00:00:00
1518	Papel higienico Petalo 6 rollos	\N	37	58	8.00	10.50	100	10	2024-10-06 00:00:00
1519	Papel higienico Suavel 4 rollos	\N	37	58	8.00	10.50	100	10	2024-10-06 00:00:00
1520	Papel higienico Suavel 6 rollos	\N	37	58	8.00	10.50	100	10	2024-10-06 00:00:00
1521	Toallas sanitarias Always	\N	37	58	8.00	10.50	100	10	2024-10-06 00:00:00
1522	Toallas sanitarias Kotex	\N	37	58	8.00	10.50	100	10	2024-10-06 00:00:00
1523	Pa¤ales Huggies	\N	44	58	8.00	10.50	100	10	2024-10-06 00:00:00
1524	Shampoo Head & Shoulders chico	\N	39	58	8.00	10.50	100	10	2024-10-06 00:00:00
1525	Shampoo Head & Shoulders grande	\N	39	58	8.00	10.50	100	10	2024-10-06 00:00:00
1526	Desodorante Axe	\N	41	58	8.00	10.50	100	10	2024-10-06 00:00:00
1527	Leche deslactosada 1lt	Presentacion azul	15	4	18.20	23.00	14	2	2024-10-06 00:00:00
1528	Yomi lala chocolate	\N	15	4	15.00	30.00	100	10	2024-10-06 00:00:00
1529	Yomi lala vainilla	\N	15	4	15.00	30.00	100	10	2024-10-06 00:00:00
1530	Yomi lala fresa	\N	15	4	15.00	30.00	100	10	2024-10-06 00:00:00
1531	Yogurt lala fresa	\N	15	4	15.00	30.00	100	10	2024-10-06 00:00:00
1532	Yogurt lala durazno	\N	15	4	15.00	30.00	100	10	2024-10-06 00:00:00
1533	Yogurt lala manzana	\N	15	4	15.00	30.00	100	10	2024-10-06 00:00:00
1534	Yogurt bebible lala manzana	\N	15	4	15.00	30.00	100	10	2024-10-06 00:00:00
1535	Yogurt bebible lala durazno	\N	15	4	15.00	30.00	100	10	2024-10-06 00:00:00
1536	Yogurt bebible lala fresa	\N	15	4	15.00	30.00	100	10	2024-10-06 00:00:00
1537	Yogurt bebible lala moras	\N	15	4	15.00	30.00	100	10	2024-10-06 00:00:00
1538	Yogurt bebible lala pina coco	\N	15	4	15.00	30.00	100	10	2024-10-06 00:00:00
1539	Licuado lala fresa platano	\N	15	4	15.00	30.00	100	10	2024-10-06 00:00:00
1540	Licuado lala nuez	\N	15	4	15.00	30.00	100	10	2024-10-06 00:00:00
1541	Flan lala	\N	15	4	15.00	30.00	100	10	2024-10-06 00:00:00
1542	Margarina lala 90gr	\N	15	4	15.00	30.00	100	10	2024-10-06 00:00:00
1543	Roles	Ricos roles de canela caseros	27	13	70.00	100.00	19	10	2024-11-04 00:00:00
1544	Pepsi	bebida azucarada	31	14	8.00	16.00	77	20	2024-11-04 00:00:00
1545	Manzanita		31	14	17.00	25.00	22	3	2024-11-04 00:00:00
1546	MaruchanTokyo	maruchan picante	2	11	5.50	12.50	15	10	2024-11-04 00:00:00
1547	Harina de maiz maseca	None	10	59	8.00	10.50	100	10	2024-11-04 00:00:00
1548	Sabritas	Sabritas Flamin Hot	9	3	10.00	18.00	4	1	2024-11-04 00:00:00
1549	Galletas marias	Las galletas clasicas	9	3	8.90	15.00	19	2	2024-11-04 00:00:00
1550	Leche entera lala 1lt	Clasica color roja	15	4	15.24	25.00	11	3	2024-11-04 00:00:00
1551	Leche Lala entera 1L	Leche Lala entera 1 Litro	15	4	19.00	24.00	100	10	2024-11-04 00:00:00
1552	Tostadas charras	None	5	60	8.00	10.50	100	10	2024-11-04 00:00:00
1553	Leche Lala light 1L	Leche Lala light 1 Litro	15	4	20.00	25.00	100	10	2024-11-04 00:00:00
1554	Leche Santa Clara entera 1L	Leche Santa Clara entera 1 Litro	15	4	22.00	28.00	100	10	2024-11-04 00:00:00
1555	Leche Santa Clara deslactosada 1L	Leche Santa Clara deslactosada 1 Litro	15	4	23.00	29.00	100	10	2024-11-04 00:00:00
1556	Arroz Mexica 1kg	None	2	59	12.00	16.50	100	10	2024-11-04 00:00:00
1557	Del Valle fruit naranja 600ml	Jugo Del Valle sabor Naranja 600 ml	31	28	10.50	13.50	100	10	2024-11-04 00:00:00
1558	Harina de trigo San antonio	None	10	41	8.00	10.50	100	10	2024-11-04 00:00:00
1559	Tortillas de maiz 1/2 kg	None	10	58	8.00	10.50	100	10	2024-11-04 00:00:00
1560	Pan bimbo blanco chico	None	27	17	8.00	10.50	100	10	2024-11-04 00:00:00
1561	Pan bimbo blanco grande	None	27	17	8.00	10.50	100	10	2024-11-04 00:00:00
1562	Pan bimbo integral chico	None	27	17	8.00	10.50	100	10	2024-11-04 00:00:00
1563	Pan bimbo integral grande	None	27	17	8.00	10.50	100	10	2024-11-04 00:00:00
1564	Rebanadas bimbo	None	27	17	8.00	10.50	100	10	2024-11-04 00:00:00
1565	Chocoroles	None	27	17	8.00	10.50	100	10	2024-11-04 00:00:00
1566	Nito bimbo	None	27	17	8.00	10.50	100	10	2024-11-04 00:00:00
1567	Mantecadas	None	27	17	8.00	10.50	100	10	2024-11-04 00:00:00
1568	Roles de canela con pasas	None	27	17	8.00	10.50	100	10	2024-11-04 00:00:00
1569	Roles de canela glaseados	None	27	17	8.00	10.50	100	10	2024-11-04 00:00:00
1570	Conchas bimbo	None	27	17	8.00	10.50	100	10	2024-11-04 00:00:00
1571	Panque de nuez bimbo	None	27	17	8.00	10.50	100	10	2024-11-04 00:00:00
1572	Donitas bimbo	None	27	17	8.00	10.50	100	10	2024-11-04 00:00:00
1573	Donitas espolvoreadas bimbo	None	27	17	8.00	10.50	100	10	2024-11-04 00:00:00
1574	chimichangas	chimichangas	23	10	30.00	45.00	15	5	2024-11-04 00:00:00
1575	Coca Cola 1L	Refresco Coca Cola 1 Litro	31	16	12.00	15.00	100	10	2024-11-04 00:00:00
1576	Coca Cola lata 355ml	Refresco Coca Cola 355 ml lata	31	16	8.50	11.00	100	10	2024-11-04 00:00:00
1577	Coca Cola 355ml	Refresco Coca Cola 355 ml	31	16	8.00	10.50	100	10	2024-11-04 00:00:00
1578	Coca Cola 600ml	Refresco Coca Cola 600 ml	31	16	9.00	12.00	100	10	2024-11-04 00:00:00
1579	Coca Cola retornable 1 1/4 lt.	Refresco Coca Cola retornable 1 1/4 lt	31	16	12.50	15.50	100	10	2024-11-04 00:00:00
1580	Coca Cola 2L retornable	Refresco Coca Cola retornable 2 Litros	31	16	19.50	24.00	100	10	2024-11-04 00:00:00
1581	Coca Cola 3L retornable	Refresco Coca Cola retornable 3 Litros	31	16	24.00	30.00	100	10	2024-11-04 00:00:00
1582	Coca Cola Light 600ml	Refresco Coca Cola Light 600 ml	31	16	9.50	12.50	100	10	2024-11-04 00:00:00
1583	Pepsi 600ml	Refresco Pepsi 600 ml	31	14	9.00	12.00	100	10	2024-11-04 00:00:00
1584	Pepsi 1.5L	Refresco Pepsi 1.5 Litros	31	14	12.00	15.50	100	10	2024-11-04 00:00:00
1585	Fanta 600ml	Refresco Fanta 600 ml	31	16	9.00	12.00	100	10	2024-11-04 00:00:00
1586	Fanta 1.5L	Refresco Fanta 1.5 Litros	31	16	12.50	16.00	100	10	2024-11-04 00:00:00
1587	Sprite 600ml	Refresco Sprite 600 ml	31	16	9.00	12.00	100	10	2024-11-04 00:00:00
1588	Sprite 1.5L	Refresco Sprite 1.5 Litros	31	16	12.50	16.00	100	10	2024-11-04 00:00:00
1589	Manzanita 600ml	Refresco Manzanita Sol 600 ml	31	16	9.00	12.00	100	10	2024-11-04 00:00:00
1590	Manzanita 1.5L	Refresco Manzanita Sol 1.5 Litros	31	16	12.50	16.00	100	10	2024-11-04 00:00:00
1591	Fresca 600ml	Refresco Fresca 600 ml	31	16	9.00	12.00	100	10	2024-11-04 00:00:00
1592	Fresca 3L	Refresco Fresca 3 Litros	31	16	24.00	30.00	100	10	2024-11-04 00:00:00
1593	Mirinda 600ml	Refresco Mirinda 600 ml	31	16	9.00	12.00	100	10	2024-11-04 00:00:00
1594	Mirinda 1.5L	Refresco Mirinda 1.5 Litros	31	16	12.50	16.00	100	10	2024-11-04 00:00:00
1595	Tostadas Sanissimo	None	5	61	8.00	10.50	100	10	2024-11-04 00:00:00
1596	Marias gamesa	None	29	46	8.00	10.50	100	10	2024-11-04 00:00:00
1597	Jumex de mango 1L	Jugo Jumex sabor Mango 1 Litro	31	21	16.00	20.00	100	10	2024-11-04 00:00:00
1598	Emperador chocolate	None	29	46	8.00	10.50	100	10	2024-11-04 00:00:00
1599	Emperador nuez	None	29	46	8.00	10.50	100	10	2024-11-04 00:00:00
1600	Emperador vainilla	None	29	46	8.00	10.50	100	10	2024-11-04 00:00:00
1601	Emperador limon	None	29	46	8.00	10.50	100	10	2024-11-04 00:00:00
1602	Jumex de durazno 1L	Jugo Jumex sabor Durazno 1 Litro	31	21	16.00	20.00	100	10	2024-11-04 00:00:00
1603	Jumex de manzana 600ml	Jugo Jumex sabor Manzana 600 ml	31	21	10.00	13.00	100	10	2024-11-04 00:00:00
1604	Del Valle fruit manzana 600ml	Jugo Del Valle sabor Manzana 600 ml	31	28	10.50	13.50	100	10	2024-11-04 00:00:00
1605	Del Valle fruit guayaba 600ml	Jugo Del Valle sabor Guayaba 600 ml	31	28	10.50	13.50	100	10	2024-11-04 00:00:00
1606	Emperador Senso	None	29	46	8.00	10.50	100	10	2024-11-04 00:00:00
1607	Mamut chico	None	29	46	8.00	10.50	100	10	2024-11-04 00:00:00
1608	Yogurt Lala natural 1L	Yogurt Lala natural 1 Litro	17	4	25.00	30.00	100	10	2024-11-04 00:00:00
1609	Yogurt Lala de fresa 1L	Yogurt Lala sabor Fresa 1 Litro	17	4	25.00	30.00	100	10	2024-11-04 00:00:00
1610	Yogurt Yoplait de fresa 1L	Yogurt Yoplait sabor Fresa 1 Litro	17	54	26.00	31.00	100	10	2024-11-04 00:00:00
1611	Mantequilla Lala 250g	Mantequilla Lala 250 gramos	19	4	30.00	38.00	100	10	2024-11-04 00:00:00
1612	Queso panela Lala 200g	Queso panela Lala 200 gramos	16	4	40.00	50.00	100	10	2024-11-04 00:00:00
1613	Mamut grande	None	29	46	8.00	10.50	100	10	2024-11-04 00:00:00
1614	Chokis	None	29	46	8.00	10.50	100	10	2024-11-04 00:00:00
1615	Chokis rellenas	None	29	46	8.00	10.50	100	10	2024-11-04 00:00:00
1616	Chokis doble chocolate	None	29	46	8.00	10.50	100	10	2024-11-04 00:00:00
1617	Chokis brownie	None	29	46	8.00	10.50	100	10	2024-11-04 00:00:00
1618	Leche Lala deslactosada 1L	Leche Lala deslactosada 1 Litro	15	4	20.00	25.00	100	10	2024-11-04 00:00:00
1619	Queso panela Alpura 200g	Queso panela Alpura 200 gramos	16	18	40.00	50.00	100	10	2024-11-04 00:00:00
1620	Queso oaxaca Lala 200g	Queso Oaxaca Lala 200 gramos	16	4	45.00	55.00	100	10	2024-11-04 00:00:00
1621	Queso manchego Lala 200g	Queso Manchego Lala 200 gramos	16	4	50.00	60.00	100	10	2024-11-04 00:00:00
1622	Salchichas Fud paquete 500g	Salchichas Fud 500 gramos	18	53	30.00	40.00	100	10	2024-11-04 00:00:00
1623	Salchichas San Rafael paquete 500g	Salchichas San Rafael 500 gramos	18	52	35.00	45.00	100	10	2024-11-04 00:00:00
1624	Sidral mundet 600ml	Refresco de manzana de 600ml	31	16	10.00	16.00	20	5	2024-11-04 00:00:00
1625	Sidral mundet 3lt	Refresco de manzana de 3lt	31	16	24.00	30.00	20	5	2024-11-04 00:00:00
1626	Agua bonafont 600ml	None	30	55	8.00	10.50	100	10	2024-11-04 00:00:00
1627	Agua bonafont 1lt	None	30	55	12.00	15.00	100	10	2024-11-04 00:00:00
1628	Agua bonafont 2lt.	None	30	55	14.00	18.00	100	10	2024-11-04 00:00:00
1629	Garrafon bonafont 20lt	None	30	55	19.50	24.00	100	10	2024-11-04 00:00:00
1630	Agua ciel 600ml	None	30	16	8.00	13.00	100	10	2024-11-04 00:00:00
1631	Agua ciel 1lt	None	30	16	10.00	15.00	100	10	2024-11-04 00:00:00
1632	Agua ciel 1.5l	None	30	16	12.00	17.00	100	10	2024-11-04 00:00:00
1633	Agua ciel 2lt	None	30	16	14.00	20.00	100	10	2024-11-04 00:00:00
1634	Agua E-pura 600ml	None	30	14	8.00	13.00	100	10	2024-11-04 00:00:00
1635	Agua E-pura 1lt	None	30	14	10.00	15.00	100	10	2024-11-04 00:00:00
1636	Garrafon E-pura 10lt	None	30	14	18.00	25.00	100	10	2024-11-04 00:00:00
1637	Crema Lala 200ml	None	15	4	8.00	13.00	100	10	2024-11-04 00:00:00
1638	Crema Lala 426ml	None	15	4	15.00	30.00	100	10	2024-11-04 00:00:00
1639	Crema Lala 900ml	None	15	4	35.00	55.00	100	10	2024-11-04 00:00:00
1640	Crema alpura 200ml	None	15	4	8.00	13.00	100	10	2024-11-04 00:00:00
1641	Crema alpura 426ml	None	15	4	15.00	30.00	100	10	2024-11-04 00:00:00
1642	Crema alpura 900ml	None	15	4	35.00	55.00	100	10	2024-11-04 00:00:00
1643	Atun dolores en agua	None	6	51	10.00	15.00	100	10	2024-11-04 00:00:00
1644	Atun dolores en aceite	None	6	51	12.00	17.00	100	10	2024-11-04 00:00:00
1645	Sardinas en aceite	None	6	20	10.00	15.00	100	10	2024-11-04 00:00:00
1646	Frijoles refritos	None	6	50	10.00	15.00	100	10	2024-11-04 00:00:00
1647	Frijoles bayos	None	6	50	10.00	15.00	100	10	2024-11-04 00:00:00
1648	Pasta la moderna	None	2	44	10.00	15.00	100	10	2024-11-04 00:00:00
1649	Coditos la moderna	None	2	44	10.00	15.00	100	10	2024-11-04 00:00:00
1650	Pasta Barilla espagueti	None	2	56	10.00	15.00	100	10	2024-11-04 00:00:00
1651	Sopa de letras la moderna	None	2	44	10.00	15.00	100	10	2024-11-04 00:00:00
1652	Sopa maruchan pollo	None	2	57	10.00	15.00	100	10	2024-11-04 00:00:00
1653	Sopa maruchan camaron	None	2	57	10.00	15.00	100	10	2024-11-04 00:00:00
1654	Sopa maruchan res	None	2	57	10.00	15.00	100	10	2024-11-04 00:00:00
1655	Sopa maruchan habanero	None	2	57	10.00	15.00	100	10	2024-11-04 00:00:00
1656	Sopa maruchan piquin	None	2	57	10.00	15.00	100	10	2024-11-04 00:00:00
1657	Sopa maruchan limon	None	2	57	10.00	15.00	100	10	2024-11-04 00:00:00
1658	Lentejas la moderna	None	2	44	10.00	15.00	100	10	2024-11-04 00:00:00
1659	Jamon de pavo Fud 250g	Jamon de Pavo Fud 250 gramos	18	53	35.00	45.00	100	10	2024-11-04 00:00:00
1660	Jamon de pavo San Rafael 250g	Jamon de Pavo San Rafael 250 gramos	18	52	40.00	50.00	100	10	2024-11-04 00:00:00
1661	Cremax chocolate	None	29	46	8.00	10.50	100	10	2024-11-04 00:00:00
1662	Cremax fresa	None	29	46	8.00	10.50	100	10	2024-11-04 00:00:00
1663	Florentinas gamesa	None	29	46	8.00	10.50	100	10	2024-11-04 00:00:00
1664	Marias doradas	None	29	46	8.00	10.50	100	10	2024-11-04 00:00:00
1665	Gamesa cajeta	None	29	46	8.00	10.50	100	10	2024-11-04 00:00:00
1666	Maravillas gamesa	None	29	46	8.00	10.50	100	10	2024-11-04 00:00:00
1667	Crackets gamesa	None	29	46	8.00	10.50	100	10	2024-11-04 00:00:00
1668	Surtido rico gamesa	None	29	46	8.00	10.50	100	10	2024-11-04 00:00:00
1669	Delicias gamesa	None	29	46	8.00	10.50	100	10	2024-11-04 00:00:00
1670	Oreo	None	9	58	8.00	10.50	100	10	2024-11-04 00:00:00
1671	Principe chocolate	None	9	22	8.00	10.50	100	10	2024-11-04 00:00:00
1672	Principe vainilla	None	9	22	8.00	10.50	100	10	2024-11-04 00:00:00
1673	Principe limon	None	9	22	8.00	10.50	100	10	2024-11-04 00:00:00
1674	Principe chocolate blanco	None	9	22	8.00	10.50	100	10	2024-11-04 00:00:00
1675	Lors	None	9	22	8.00	10.50	100	10	2024-11-04 00:00:00
1676	Plativolos	None	9	22	8.00	10.50	100	10	2024-11-04 00:00:00
1677	Sponch	None	9	22	8.00	10.50	100	10	2024-11-04 00:00:00
1678	Triki trakes	None	9	22	8.00	10.50	100	10	2024-11-04 00:00:00
1679	MaxiTubo Triki trakes	None	9	22	8.00	10.50	100	10	2024-11-04 00:00:00
1680	Gansito	None	9	22	8.00	10.50	100	10	2024-11-04 00:00:00
1681	Pinguinos	None	9	22	8.00	10.50	100	10	2024-11-04 00:00:00
1682	Pasticetas marinela	None	9	22	8.00	10.50	100	10	2024-11-04 00:00:00
1683	Barritas fresa	None	9	22	8.00	10.50	100	10	2024-11-04 00:00:00
1684	Barritas pina	None	9	22	8.00	10.50	100	10	2024-11-04 00:00:00
1685	Barritas moras	None	9	22	8.00	10.50	100	10	2024-11-04 00:00:00
1686	Maxitubo Barritas pina	None	9	22	8.00	10.50	100	10	2024-11-04 00:00:00
1687	Canelitas	None	9	22	8.00	10.50	100	10	2024-11-04 00:00:00
1688	Polvorones	None	9	22	8.00	10.50	100	10	2024-11-04 00:00:00
1689	Maxitubo Polvorones	None	9	22	8.00	10.50	100	10	2024-11-04 00:00:00
1690	Ricanelas	None	9	46	8.00	10.50	100	10	2024-11-04 00:00:00
1691	Ritz bits queso	None	9	58	8.00	10.50	100	10	2024-11-04 00:00:00
1692	Arcoiris	None	9	46	8.00	10.50	100	10	2024-11-04 00:00:00
1693	Submarinos fresa	None	9	22	8.00	10.50	100	10	2024-11-04 00:00:00
1694	Submarinos vainilla	None	9	22	8.00	10.50	100	10	2024-11-04 00:00:00
1695	Submarinos chocolate	None	9	22	8.00	10.50	100	10	2024-11-04 00:00:00
1696	Rocko chico	None	9	22	8.00	10.50	100	10	2024-11-04 00:00:00
1697	Rocko grande	None	9	22	8.00	10.50	100	10	2024-11-04 00:00:00
1698	Sabritas original	None	9	3	8.00	10.50	100	10	2024-11-04 00:00:00
1699	Sabritas adobadas	None	9	3	8.00	10.50	100	10	2024-11-04 00:00:00
1700	Sabritas limon	None	9	3	8.00	10.50	100	10	2024-11-04 00:00:00
1701	Sabritas flamin hot	None	9	3	8.00	10.50	100	10	2024-11-04 00:00:00
1702	Sabritas crema y especias	None	9	3	8.00	10.50	100	10	2024-11-04 00:00:00
1703	Sabritas habanero	None	9	3	8.00	10.50	100	10	2024-11-04 00:00:00
1704	Sabritas receta crujiente	None	9	3	8.00	10.50	100	10	2024-11-04 00:00:00
1705	Chips jalapeno	None	9	47	8.00	10.50	100	10	2024-11-04 00:00:00
1706	Crujitos	None	9	3	8.00	10.50	100	10	2024-11-04 00:00:00
1707	Doritos nacho	None	9	3	8.00	10.50	100	10	2024-11-04 00:00:00
1708	Doritos incognita	None	9	3	8.00	10.50	100	10	2024-11-04 00:00:00
1709	Doritos diablo	None	9	3	8.00	10.50	100	10	2024-11-04 00:00:00
1710	Doritos flamin hot	None	9	3	8.00	10.50	100	10	2024-11-04 00:00:00
1711	Doritos dinamita	None	9	3	8.00	10.50	100	10	2024-11-04 00:00:00
1712	Sabritones	None	9	3	8.00	10.50	100	10	2024-11-04 00:00:00
1713	Bigmix queso	None	9	47	8.00	10.50	100	10	2024-11-04 00:00:00
1714	Bigmix fuego	None	9	47	8.00	10.50	100	10	2024-11-04 00:00:00
1715	Cheetos torciditos	None	9	3	8.00	10.50	100	10	2024-11-04 00:00:00
1716	Cheetos bolitas	None	9	3	8.00	10.50	100	10	2024-11-04 00:00:00
1717	Cheetos queso	None	9	3	8.00	10.50	100	10	2024-11-04 00:00:00
1718	Cheetos flamin hot	None	9	3	8.00	10.50	100	10	2024-11-04 00:00:00
1719	Ruffles original	None	9	3	8.00	10.50	100	10	2024-11-04 00:00:00
1720	Ruffles queso	None	9	3	8.00	10.50	100	10	2024-11-04 00:00:00
1721	Fritos sal y limon	None	9	3	8.00	10.50	100	10	2024-11-04 00:00:00
1722	Fritos chorizo	None	9	3	8.00	10.50	100	10	2024-11-04 00:00:00
1723	Bolsaza Sabritas original	None	9	3	8.00	10.50	100	10	2024-11-04 00:00:00
1724	Bolsaza Doritos nacho	None	9	3	8.00	10.50	100	10	2024-11-04 00:00:00
1725	Paketaxo	None	9	3	8.00	10.50	100	10	2024-11-04 00:00:00
1726	Paketaxo queso	None	9	3	8.00	10.50	100	10	2024-11-04 00:00:00
1727	Paketaxo flamin hot	None	9	3	8.00	10.50	100	10	2024-11-04 00:00:00
1728	Churrumaiz	None	9	3	8.00	10.50	100	10	2024-11-04 00:00:00
1729	Churrumaiz flamin hot	None	9	3	8.00	10.50	100	10	2024-11-04 00:00:00
1730	Rancheritos	None	9	3	8.00	10.50	100	10	2024-11-04 00:00:00
1731	Sabritas switch doritos nacho	None	9	3	8.00	10.50	100	10	2024-11-04 00:00:00
1732	Runners	None	9	47	8.00	10.50	100	10	2024-11-04 00:00:00
1733	Chips sal	None	9	47	8.00	10.50	100	10	2024-11-04 00:00:00
1734	Papatinas	None	9	47	8.00	10.50	100	10	2024-11-04 00:00:00
1735	Chips fuego	None	9	47	8.00	10.50	100	10	2024-11-04 00:00:00
1736	Palomitas pop	None	9	47	8.00	10.50	100	10	2024-11-04 00:00:00
1737	Takis original 	None	9	47	8.00	10.50	100	10	2024-11-04 00:00:00
1738	Takis fuego	None	9	47	8.00	10.50	100	10	2024-11-04 00:00:00
1739	Takis salsa brava	None	9	47	8.00	10.50	100	10	2024-11-04 00:00:00
1740	Takis guacamole	None	9	47	8.00	10.50	100	10	2024-11-04 00:00:00
1741	Chipotles	None	9	47	8.00	10.50	100	10	2024-11-04 00:00:00
1742	Tostachos	None	9	47	8.00	10.50	100	10	2024-11-04 00:00:00
1743	Hot nuts	None	9	47	8.00	10.50	100	10	2024-11-04 00:00:00
1744	Hot nuts fuego	None	9	47	8.00	10.50	100	10	2024-11-04 00:00:00
1745	Valentones	None	9	47	8.00	10.50	100	10	2024-11-04 00:00:00
1746	Watz barcel	None	9	47	8.00	10.50	100	10	2024-11-04 00:00:00
1747	Toreadas	None	9	47	8.00	10.50	100	10	2024-11-04 00:00:00
1748	Palomitas pop fuego	None	9	47	8.00	10.50	100	10	2024-11-04 00:00:00
1749	Takis blue heat	None	9	47	8.00	10.50	100	10	2024-11-04 00:00:00
1750	Doraditas tia rosa	None	29	49	8.00	10.50	100	10	2024-11-04 00:00:00
1751	Sabritas receta crujiente jalapeno	None	9	3	8.00	10.50	100	10	2024-11-04 00:00:00
1752	Tortillinas tia rosa	None	10	49	8.00	10.50	100	10	2024-11-04 00:00:00
1753	Conchas tia rosa	None	29	49	8.00	10.50	100	10	2024-11-04 00:00:00
1754	Hersheys Cookies n Cream	None	8	45	8.00	10.50	100	10	2024-11-04 00:00:00
1755	Hersheys almendras	None	8	45	8.00	10.50	100	10	2024-11-04 00:00:00
1756	Hersheys chocolate amargo	None	8	45	8.00	10.50	100	10	2024-11-04 00:00:00
1757	Hersheys chocolate blanco	None	8	45	8.00	10.50	100	10	2024-11-04 00:00:00
1758	Crunch	None	8	19	8.00	10.50	100	10	2024-11-04 00:00:00
1759	Carlos V	None	8	19	8.00	10.50	100	10	2024-11-04 00:00:00
1760	Milky way	None	8	19	8.00	10.50	100	10	2024-11-04 00:00:00
1761	Snickers	None	8	19	8.00	10.50	100	10	2024-11-04 00:00:00
1762	Kit kat	None	8	19	8.00	10.50	100	10	2024-11-04 00:00:00
1763	Kinder delice	None	8	40	8.00	10.50	100	10	2024-11-04 00:00:00
1764	Kinder sorpresa	None	8	40	8.00	10.50	100	10	2024-11-04 00:00:00
1765	Ferrero rocher 3 piezas	None	8	40	8.00	10.50	100	10	2024-11-04 00:00:00
1766	Mazapan	None	8	62	8.00	10.50	100	10	2024-11-04 00:00:00
1767	Pelon pelo rico	None	8	45	8.00	10.50	100	10	2024-11-04 00:00:00
1768	Pulparindo tamarindo	None	8	62	8.00	10.50	100	10	2024-11-04 00:00:00
1769	Pulparindo chamoy	None	8	62	8.00	10.50	100	10	2024-11-04 00:00:00
1770	Tutsi pop	None	8	65	8.00	10.50	100	10	2024-11-04 00:00:00
1771	Oblea cajeta coronado	None	8	66	8.00	10.50	100	10	2024-11-04 00:00:00
1772	Paleta payaso	None	8	67	8.00	10.50	100	10	2024-11-04 00:00:00
1773	Duvalin fresa vainilla	None	8	67	8.00	10.50	100	10	2024-11-04 00:00:00
1774	Duvalin chocolate vainilla	None	8	67	8.00	10.50	100	10	2024-11-04 00:00:00
1775	Duvalin vainilla	None	8	67	8.00	10.50	100	10	2024-11-04 00:00:00
1776	Duvalin trisabor	None	8	67	8.00	10.50	100	10	2024-11-04 00:00:00
1777	Duvalin choco avellana	None	8	67	8.00	10.50	100	10	2024-11-04 00:00:00
1778	Paleta Vero mango	None	8	68	8.00	10.50	100	10	2024-11-04 00:00:00
1779	Paleta Vero elote	None	8	67	8.00	10.50	100	10	2024-11-04 00:00:00
1780	Panditas	None	8	67	8.00	10.50	100	10	2024-11-04 00:00:00
1781	Panditas rellenos	None	8	67	8.00	10.50	100	10	2024-11-04 00:00:00
1782	Panditas san valentin	None	8	67	8.00	10.50	100	10	2024-11-04 00:00:00
1783	Bubulubu	None	8	67	8.00	10.50	100	10	2024-11-04 00:00:00
1784	Rockaleta	None	8	69	8.00	10.50	100	10	2024-11-04 00:00:00
1785	Tic tac menta	None	8	40	8.00	10.50	100	10	2024-11-04 00:00:00
1786	Halls menta	None	8	58	8.00	10.50	100	10	2024-11-04 00:00:00
1787	Halls limon	None	8	58	8.00	10.50	100	10	2024-11-04 00:00:00
1788	Halls yerba buena	None	8	58	8.00	10.50	100	10	2024-11-04 00:00:00
1789	Halls miel	None	8	58	8.00	10.50	100	10	2024-11-04 00:00:00
1790	Halls negras	None	8	58	8.00	10.50	100	10	2024-11-04 00:00:00
1791	Gomilocas dientes	None	8	67	8.00	10.50	100	10	2024-11-04 00:00:00
1792	Gomilocas pinguino	None	8	67	8.00	10.50	100	10	2024-11-04 00:00:00
1793	Chocoretas	None	8	67	8.00	10.50	100	10	2024-11-04 00:00:00
1794	Kranky	None	8	67	8.00	10.50	100	10	2024-11-04 00:00:00
1795	Lucas muecas	None	8	58	8.00	10.50	100	10	2024-11-04 00:00:00
1796	Lucas chamoy	None	8	58	8.00	10.50	100	10	2024-11-04 00:00:00
1797	Lucas gusanito	None	8	58	8.00	10.50	100	10	2024-11-04 00:00:00
1798	Palomitas Act II mantequilla	None	9	58	8.00	10.50	100	10	2024-11-04 00:00:00
1799	Palomitas Act II natural	None	9	58	8.00	10.50	100	10	2024-11-04 00:00:00
1800	Palomitas Act II chile limon	None	9	58	8.00	10.50	100	10	2024-11-04 00:00:00
1801	Tostitos salsa verde	None	9	3	8.00	10.50	100	10	2024-11-04 00:00:00
1802	Zucaritas chicas	None	5	26	8.00	10.50	100	10	2024-11-04 00:00:00
1803	Zucaritas grandes	None	5	26	8.00	10.50	100	10	2024-11-04 00:00:00
1804	Corn flakes chicas	None	5	26	8.00	10.50	100	10	2024-11-04 00:00:00
1805	Corn flakes grandes	None	5	26	8.00	10.50	100	10	2024-11-04 00:00:00
1806	Choco Krispis chicas	None	5	26	8.00	10.50	100	10	2024-11-04 00:00:00
1807	Choco Krispis grandes	None	5	26	8.00	10.50	100	10	2024-11-04 00:00:00
1808	Nesquik chico	None	5	26	8.00	10.50	100	10	2024-11-04 00:00:00
1809	Nesquik grande	None	5	26	8.00	10.50	100	10	2024-11-04 00:00:00
1810	Froot loops chicas	None	5	26	8.00	10.50	100	10	2024-11-04 00:00:00
1811	Froot loops grandes	None	5	26	8.00	10.50	100	10	2024-11-04 00:00:00
1812	Chocomilk sobre	None	4	58	8.00	10.50	100	10	2024-11-04 00:00:00
1813	Chocomilk bolsa	None	4	58	8.00	10.50	100	10	2024-11-04 00:00:00
1814	Chocomilk lata	None	4	58	8.00	10.50	100	10	2024-11-04 00:00:00
1815	Nescafe clasico sobre	None	4	19	8.00	10.50	100	10	2024-11-04 00:00:00
1816	Nescafe capuccino sobre	None	4	19	8.00	10.50	100	10	2024-11-04 00:00:00
1817	Nescafe clasico bote chico	None	4	19	8.00	10.50	100	10	2024-11-04 00:00:00
1818	Nescafe clasico bote grande	None	4	19	8.00	10.50	100	10	2024-11-04 00:00:00
1819	Azucar Zulka 1kg	None	3	58	8.00	10.50	100	10	2024-11-04 00:00:00
1820	Azucar refinada 1kg	None	3	58	8.00	10.50	100	10	2024-11-04 00:00:00
1821	Azucar refinada 500gr	None	3	58	8.00	10.50	100	10	2024-11-04 00:00:00
1822	Azucar refinada 250gr	None	3	58	8.00	10.50	100	10	2024-11-04 00:00:00
1823	Aceite nutrioli 1lt	None	1	58	8.00	10.50	100	10	2024-11-04 00:00:00
1824	Aceite capullo 1lt	None	1	58	8.00	10.50	100	10	2024-11-04 00:00:00
1825	Aceite 1 2 3 1lt	None	1	58	8.00	10.50	100	10	2024-11-04 00:00:00
1826	Aceite patrona 1lt	None	1	58	8.00	10.50	100	10	2024-11-04 00:00:00
1827	Vinagre blanco la coste¤a	None	1	27	8.00	10.50	100	10	2024-11-04 00:00:00
1828	Vinagre de manzana la coste¤a	None	1	27	8.00	10.50	100	10	2024-11-04 00:00:00
1829	Catsup la coste¤a	None	1	27	8.00	10.50	100	10	2024-11-04 00:00:00
1830	Catsup Del monte	None	1	70	8.00	10.50	100	10	2024-11-04 00:00:00
1831	Catsup heinz	None	1	71	8.00	10.50	100	10	2024-11-04 00:00:00
1832	Jugo Magui	None	7	19	8.00	10.50	100	10	2024-11-04 00:00:00
1833	Salsa inglesa	None	7	19	8.00	10.50	100	10	2024-11-04 00:00:00
1834	Salsa valentina chica	None	7	58	8.00	10.50	100	10	2024-11-04 00:00:00
1835	Salsa valentina grande	None	7	58	8.00	10.50	100	10	2024-11-04 00:00:00
1836	Salsa tabasco	None	7	58	8.00	10.50	100	10	2024-11-04 00:00:00
1837	Salsa buffalo	None	7	58	8.00	10.50	100	10	2024-11-04 00:00:00
1838	Salsa chipotle la coste¤a	None	7	27	8.00	10.50	100	10	2024-11-04 00:00:00
1839	Chile chipotle la coste¤a	None	6	27	8.00	10.50	100	10	2024-11-04 00:00:00
1840	Tic tac naranja	None	8	40	8.00	10.50	100	10	2024-11-04 00:00:00
1841	Yogurt Yoplait natural 1L	Yogurt Yoplait natural 1 Litro	17	54	26.00	31.00	100	10	2024-11-04 00:00:00
1842	Cremax vainilla	None	29	46	8.00	10.50	100	10	2024-11-04 00:00:00
1843	Maxitubo Barritas fresa	None	9	22	8.00	10.50	100	10	2024-11-04 00:00:00
1844	Bigote tia rosa	None	29	49	8.00	10.50	100	10	2024-11-04 00:00:00
1845	Magdalenas tia rosa	None	29	49	8.00	10.50	100	10	2024-11-04 00:00:00
1846	Chiles serranos la coste¤a	None	6	27	8.00	10.50	100	10	2024-11-04 00:00:00
1847	Chiles en vinagre la coste¤a	None	6	27	8.00	10.50	100	10	2024-11-04 00:00:00
1848	Chile chipotle la morena	None	6	72	8.00	10.50	100	10	2024-11-04 00:00:00
1849	Chiles en vinagre la morena	None	6	72	8.00	10.50	100	10	2024-11-04 00:00:00
1850	Mayonesa mccormick chica	None	7	72	8.00	10.50	100	10	2024-11-04 00:00:00
1851	Mayonesa mccormick grande	None	7	72	8.00	10.50	100	10	2024-11-04 00:00:00
1852	Mostaza mccormick	None	7	72	8.00	10.50	100	10	2024-11-04 00:00:00
1853	Mermelada mccormick fresa chica	None	19	72	8.00	10.50	100	10	2024-11-04 00:00:00
1854	Mermelada mccormick fresa grande	None	19	72	8.00	10.50	100	10	2024-11-04 00:00:00
1855	Cloralex 1/2 lt	None	35	58	8.00	10.50	100	10	2024-11-04 00:00:00
1856	Cloralex 1 lt	None	35	58	8.00	10.50	100	10	2024-11-04 00:00:00
1857	Pinol	None	35	58	8.00	10.50	100	10	2024-11-04 00:00:00
1858	Fabuloso lavanda 1lt	None	35	58	8.00	10.50	100	10	2024-11-04 00:00:00
1859	Fabuloso aroma floral 1lt	None	35	58	8.00	10.50	100	10	2024-11-04 00:00:00
1860	Detergente Ariel 1/2 kg	None	34	58	8.00	10.50	100	10	2024-11-04 00:00:00
1861	Detergente Ariel 1kg	None	34	58	8.00	10.50	100	10	2024-11-04 00:00:00
1862	Detergente Ace 1/2 kg	None	34	58	8.00	10.50	100	10	2024-11-04 00:00:00
1863	Detergente Ace 1kg	None	34	58	8.00	10.50	100	10	2024-11-04 00:00:00
1864	Detergente Foca 1/2 kg	None	34	58	8.00	10.50	100	10	2024-11-04 00:00:00
1865	Detergente Foca 1kg	None	34	58	8.00	10.50	100	10	2024-11-04 00:00:00
1866	Suavitel 1l	None	34	58	8.00	10.50	100	10	2024-11-04 00:00:00
1867	Papel higienico Petalo 4 rollos	None	37	58	8.00	10.50	100	10	2024-11-04 00:00:00
1868	Papel higienico Petalo 6 rollos	None	37	58	8.00	10.50	100	10	2024-11-04 00:00:00
1869	Papel higienico Suavel 4 rollos	None	37	58	8.00	10.50	100	10	2024-11-04 00:00:00
1870	Papel higienico Suavel 6 rollos	None	37	58	8.00	10.50	100	10	2024-11-04 00:00:00
1871	Toallas sanitarias Always	None	37	58	8.00	10.50	100	10	2024-11-04 00:00:00
1872	Toallas sanitarias Kotex	None	37	58	8.00	10.50	100	10	2024-11-04 00:00:00
1873	Panales Huggies	None	44	58	8.00	10.50	100	10	2024-11-04 00:00:00
1874	Shampoo Head & Shoulders chico	None	39	58	8.00	10.50	100	10	2024-11-04 00:00:00
1875	Shampoo Head & Shoulders grande	None	39	58	8.00	10.50	100	10	2024-11-04 00:00:00
1876	Desodorante Axe	None	41	58	8.00	10.50	100	10	2024-11-04 00:00:00
1877	Leche deslactosada 1lt	Presentacion azul	15	4	18.20	23.00	14	2	2024-11-04 00:00:00
1878	Yomi lala chocolate	None	15	4	15.00	30.00	100	10	2024-11-04 00:00:00
1879	Yomi lala vainilla	None	15	4	15.00	30.00	100	10	2024-11-04 00:00:00
1880	Yomi lala fresa	None	15	4	15.00	30.00	100	10	2024-11-04 00:00:00
1881	Yogurt lala fresa	None	15	4	15.00	30.00	100	10	2024-11-04 00:00:00
1882	Yogurt lala durazno	None	15	4	15.00	30.00	100	10	2024-11-04 00:00:00
1883	Yogurt lala manzana	None	15	4	15.00	30.00	100	10	2024-11-04 00:00:00
1884	Yogurt bebible lala manzana	None	15	4	15.00	30.00	100	10	2024-11-04 00:00:00
1885	Yogurt bebible lala durazno	None	15	4	15.00	30.00	100	10	2024-11-04 00:00:00
1886	Yogurt bebible lala fresa	None	15	4	15.00	30.00	100	10	2024-11-04 00:00:00
1887	Yogurt bebible lala moras	None	15	4	15.00	30.00	100	10	2024-11-04 00:00:00
1888	Yogurt bebible lala pina coco	None	15	4	15.00	30.00	100	10	2024-11-04 00:00:00
1889	Licuado lala fresa platano	None	15	4	15.00	30.00	100	10	2024-11-04 00:00:00
1890	Licuado lala nuez	None	15	4	15.00	30.00	100	10	2024-11-04 00:00:00
1891	Flan lala	None	15	4	15.00	30.00	100	10	2024-11-04 00:00:00
1892	Margarina lala 90gr	None	15	4	15.00	30.00	100	10	2024-11-04 00:00:00
1893	Jabon zote rosa chico	None	42	58	8.00	10.50	100	10	2024-11-04 00:00:00
1894	Jabon zote rosa grande	None	42	58	8.00	10.50	100	10	2024-11-04 00:00:00
1895	Jabon zote blanco chico	None	42	58	8.00	10.50	100	10	2024-11-04 00:00:00
1896	Jabon zote blanco grande	None	42	58	8.00	10.50	100	10	2024-11-04 00:00:00
1897	Roles	Ricos roles de canela caseros	27	13	70.00	100.00	19	10	2024-11-05 00:00:00
1898	Pepsi	bebida azucarada	31	14	8.00	16.00	77	20	2024-11-05 00:00:00
1899	Manzanita		31	14	17.00	25.00	22	3	2024-11-05 00:00:00
1900	MaruchanTokyo	maruchan picante	2	11	5.50	12.50	15	10	2024-11-05 00:00:00
1901	Harina de maiz maseca	None	10	59	8.00	10.50	100	10	2024-11-05 00:00:00
1902	Sabritas	Sabritas Flamin Hot	9	3	10.00	18.00	4	1	2024-11-05 00:00:00
1903	Galletas marias	Las galletas clasicas	9	3	8.90	15.00	19	2	2024-11-05 00:00:00
1904	Leche entera lala 1lt	Clasica color roja	15	4	15.24	25.00	11	3	2024-11-05 00:00:00
1905	Leche Lala entera 1L	Leche Lala entera 1 Litro	15	4	19.00	24.00	100	10	2024-11-05 00:00:00
1906	Tostadas charras	None	5	60	8.00	10.50	100	10	2024-11-05 00:00:00
1907	Leche Lala light 1L	Leche Lala light 1 Litro	15	4	20.00	25.00	100	10	2024-11-05 00:00:00
1908	Leche Santa Clara entera 1L	Leche Santa Clara entera 1 Litro	15	4	22.00	28.00	100	10	2024-11-05 00:00:00
1909	Leche Santa Clara deslactosada 1L	Leche Santa Clara deslactosada 1 Litro	15	4	23.00	29.00	100	10	2024-11-05 00:00:00
1910	Arroz Mexica 1kg	None	2	59	12.00	16.50	100	10	2024-11-05 00:00:00
1911	Del Valle fruit naranja 600ml	Jugo Del Valle sabor Naranja 600 ml	31	28	10.50	13.50	100	10	2024-11-05 00:00:00
1912	Harina de trigo San antonio	None	10	41	8.00	10.50	100	10	2024-11-05 00:00:00
1913	Tortillas de maiz 1/2 kg	None	10	58	8.00	10.50	100	10	2024-11-05 00:00:00
1914	Pan bimbo blanco chico	None	27	17	8.00	10.50	100	10	2024-11-05 00:00:00
1915	Pan bimbo blanco grande	None	27	17	8.00	10.50	100	10	2024-11-05 00:00:00
1916	Pan bimbo integral chico	None	27	17	8.00	10.50	100	10	2024-11-05 00:00:00
1917	Pan bimbo integral grande	None	27	17	8.00	10.50	100	10	2024-11-05 00:00:00
1918	Rebanadas bimbo	None	27	17	8.00	10.50	100	10	2024-11-05 00:00:00
1919	Chocoroles	None	27	17	8.00	10.50	100	10	2024-11-05 00:00:00
1920	Nito bimbo	None	27	17	8.00	10.50	100	10	2024-11-05 00:00:00
1921	Mantecadas	None	27	17	8.00	10.50	100	10	2024-11-05 00:00:00
1922	Roles de canela con pasas	None	27	17	8.00	10.50	100	10	2024-11-05 00:00:00
1923	Roles de canela glaseados	None	27	17	8.00	10.50	100	10	2024-11-05 00:00:00
1924	Conchas bimbo	None	27	17	8.00	10.50	100	10	2024-11-05 00:00:00
1925	Panque de nuez bimbo	None	27	17	8.00	10.50	100	10	2024-11-05 00:00:00
1926	Donitas bimbo	None	27	17	8.00	10.50	100	10	2024-11-05 00:00:00
1927	Donitas espolvoreadas bimbo	None	27	17	8.00	10.50	100	10	2024-11-05 00:00:00
1928	chimichangas	chimichangas	23	10	30.00	45.00	15	5	2024-11-05 00:00:00
1929	Coca Cola 1L	Refresco Coca Cola 1 Litro	31	16	12.00	15.00	100	10	2024-11-05 00:00:00
1930	Coca Cola lata 355ml	Refresco Coca Cola 355 ml lata	31	16	8.50	11.00	100	10	2024-11-05 00:00:00
1931	Coca Cola 355ml	Refresco Coca Cola 355 ml	31	16	8.00	10.50	100	10	2024-11-05 00:00:00
1932	Coca Cola 600ml	Refresco Coca Cola 600 ml	31	16	9.00	12.00	100	10	2024-11-05 00:00:00
1933	Coca Cola retornable 1 1/4 lt.	Refresco Coca Cola retornable 1 1/4 lt	31	16	12.50	15.50	100	10	2024-11-05 00:00:00
1934	Coca Cola 2L retornable	Refresco Coca Cola retornable 2 Litros	31	16	19.50	24.00	100	10	2024-11-05 00:00:00
1935	Coca Cola 3L retornable	Refresco Coca Cola retornable 3 Litros	31	16	24.00	30.00	100	10	2024-11-05 00:00:00
1936	Coca Cola Light 600ml	Refresco Coca Cola Light 600 ml	31	16	9.50	12.50	100	10	2024-11-05 00:00:00
1937	Pepsi 600ml	Refresco Pepsi 600 ml	31	14	9.00	12.00	100	10	2024-11-05 00:00:00
1938	Pepsi 1.5L	Refresco Pepsi 1.5 Litros	31	14	12.00	15.50	100	10	2024-11-05 00:00:00
1939	Fanta 600ml	Refresco Fanta 600 ml	31	16	9.00	12.00	100	10	2024-11-05 00:00:00
1940	Fanta 1.5L	Refresco Fanta 1.5 Litros	31	16	12.50	16.00	100	10	2024-11-05 00:00:00
1941	Sprite 600ml	Refresco Sprite 600 ml	31	16	9.00	12.00	100	10	2024-11-05 00:00:00
1942	Sprite 1.5L	Refresco Sprite 1.5 Litros	31	16	12.50	16.00	100	10	2024-11-05 00:00:00
1943	Manzanita 600ml	Refresco Manzanita Sol 600 ml	31	16	9.00	12.00	100	10	2024-11-05 00:00:00
1944	Manzanita 1.5L	Refresco Manzanita Sol 1.5 Litros	31	16	12.50	16.00	100	10	2024-11-05 00:00:00
1945	Fresca 600ml	Refresco Fresca 600 ml	31	16	9.00	12.00	100	10	2024-11-05 00:00:00
1946	Fresca 3L	Refresco Fresca 3 Litros	31	16	24.00	30.00	100	10	2024-11-05 00:00:00
1947	Mirinda 600ml	Refresco Mirinda 600 ml	31	16	9.00	12.00	100	10	2024-11-05 00:00:00
1948	Mirinda 1.5L	Refresco Mirinda 1.5 Litros	31	16	12.50	16.00	100	10	2024-11-05 00:00:00
1949	Tostadas Sanissimo	None	5	61	8.00	10.50	100	10	2024-11-05 00:00:00
1950	Marias gamesa	None	29	46	8.00	10.50	100	10	2024-11-05 00:00:00
1951	Jumex de mango 1L	Jugo Jumex sabor Mango 1 Litro	31	21	16.00	20.00	100	10	2024-11-05 00:00:00
1952	Emperador chocolate	None	29	46	8.00	10.50	100	10	2024-11-05 00:00:00
1953	Emperador nuez	None	29	46	8.00	10.50	100	10	2024-11-05 00:00:00
1954	Emperador vainilla	None	29	46	8.00	10.50	100	10	2024-11-05 00:00:00
1955	Emperador limon	None	29	46	8.00	10.50	100	10	2024-11-05 00:00:00
1956	Jumex de durazno 1L	Jugo Jumex sabor Durazno 1 Litro	31	21	16.00	20.00	100	10	2024-11-05 00:00:00
1957	Jumex de manzana 600ml	Jugo Jumex sabor Manzana 600 ml	31	21	10.00	13.00	100	10	2024-11-05 00:00:00
1958	Del Valle fruit manzana 600ml	Jugo Del Valle sabor Manzana 600 ml	31	28	10.50	13.50	100	10	2024-11-05 00:00:00
1959	Del Valle fruit guayaba 600ml	Jugo Del Valle sabor Guayaba 600 ml	31	28	10.50	13.50	100	10	2024-11-05 00:00:00
1960	Emperador Senso	None	29	46	8.00	10.50	100	10	2024-11-05 00:00:00
1961	Mamut chico	None	29	46	8.00	10.50	100	10	2024-11-05 00:00:00
1962	Yogurt Lala natural 1L	Yogurt Lala natural 1 Litro	17	4	25.00	30.00	100	10	2024-11-05 00:00:00
1963	Yogurt Lala de fresa 1L	Yogurt Lala sabor Fresa 1 Litro	17	4	25.00	30.00	100	10	2024-11-05 00:00:00
1964	Yogurt Yoplait de fresa 1L	Yogurt Yoplait sabor Fresa 1 Litro	17	54	26.00	31.00	100	10	2024-11-05 00:00:00
1965	Mantequilla Lala 250g	Mantequilla Lala 250 gramos	19	4	30.00	38.00	100	10	2024-11-05 00:00:00
1966	Queso panela Lala 200g	Queso panela Lala 200 gramos	16	4	40.00	50.00	100	10	2024-11-05 00:00:00
1967	Mamut grande	None	29	46	8.00	10.50	100	10	2024-11-05 00:00:00
1968	Chokis	None	29	46	8.00	10.50	100	10	2024-11-05 00:00:00
1969	Chokis rellenas	None	29	46	8.00	10.50	100	10	2024-11-05 00:00:00
1970	Chokis doble chocolate	None	29	46	8.00	10.50	100	10	2024-11-05 00:00:00
1971	Chokis brownie	None	29	46	8.00	10.50	100	10	2024-11-05 00:00:00
1972	Leche Lala deslactosada 1L	Leche Lala deslactosada 1 Litro	15	4	20.00	25.00	100	10	2024-11-05 00:00:00
1973	Queso panela Alpura 200g	Queso panela Alpura 200 gramos	16	18	40.00	50.00	100	10	2024-11-05 00:00:00
1974	Queso oaxaca Lala 200g	Queso Oaxaca Lala 200 gramos	16	4	45.00	55.00	100	10	2024-11-05 00:00:00
1975	Queso manchego Lala 200g	Queso Manchego Lala 200 gramos	16	4	50.00	60.00	100	10	2024-11-05 00:00:00
1976	Salchichas Fud paquete 500g	Salchichas Fud 500 gramos	18	53	30.00	40.00	100	10	2024-11-05 00:00:00
1977	Salchichas San Rafael paquete 500g	Salchichas San Rafael 500 gramos	18	52	35.00	45.00	100	10	2024-11-05 00:00:00
1978	Sidral mundet 600ml	Refresco de manzana de 600ml	31	16	10.00	16.00	20	5	2024-11-05 00:00:00
1979	Sidral mundet 3lt	Refresco de manzana de 3lt	31	16	24.00	30.00	20	5	2024-11-05 00:00:00
1980	Agua bonafont 600ml	None	30	55	8.00	10.50	100	10	2024-11-05 00:00:00
1981	Agua bonafont 1lt	None	30	55	12.00	15.00	100	10	2024-11-05 00:00:00
1982	Agua bonafont 2lt.	None	30	55	14.00	18.00	100	10	2024-11-05 00:00:00
1983	Garrafon bonafont 20lt	None	30	55	19.50	24.00	100	10	2024-11-05 00:00:00
1984	Agua ciel 600ml	None	30	16	8.00	13.00	100	10	2024-11-05 00:00:00
1985	Agua ciel 1lt	None	30	16	10.00	15.00	100	10	2024-11-05 00:00:00
1986	Agua ciel 1.5l	None	30	16	12.00	17.00	100	10	2024-11-05 00:00:00
1987	Agua ciel 2lt	None	30	16	14.00	20.00	100	10	2024-11-05 00:00:00
1988	Agua E-pura 600ml	None	30	14	8.00	13.00	100	10	2024-11-05 00:00:00
1989	Agua E-pura 1lt	None	30	14	10.00	15.00	100	10	2024-11-05 00:00:00
1990	Garrafon E-pura 10lt	None	30	14	18.00	25.00	100	10	2024-11-05 00:00:00
1991	Crema Lala 200ml	None	15	4	8.00	13.00	100	10	2024-11-05 00:00:00
1992	Crema Lala 426ml	None	15	4	15.00	30.00	100	10	2024-11-05 00:00:00
1993	Crema Lala 900ml	None	15	4	35.00	55.00	100	10	2024-11-05 00:00:00
1994	Crema alpura 200ml	None	15	4	8.00	13.00	100	10	2024-11-05 00:00:00
1995	Crema alpura 426ml	None	15	4	15.00	30.00	100	10	2024-11-05 00:00:00
1996	Crema alpura 900ml	None	15	4	35.00	55.00	100	10	2024-11-05 00:00:00
1997	Atun dolores en agua	None	6	51	10.00	15.00	100	10	2024-11-05 00:00:00
1998	Atun dolores en aceite	None	6	51	12.00	17.00	100	10	2024-11-05 00:00:00
1999	Sardinas en aceite	None	6	20	10.00	15.00	100	10	2024-11-05 00:00:00
2000	Frijoles refritos	None	6	50	10.00	15.00	100	10	2024-11-05 00:00:00
2001	Frijoles bayos	None	6	50	10.00	15.00	100	10	2024-11-05 00:00:00
2002	Pasta la moderna	None	2	44	10.00	15.00	100	10	2024-11-05 00:00:00
2003	Coditos la moderna	None	2	44	10.00	15.00	100	10	2024-11-05 00:00:00
2004	Pasta Barilla espagueti	None	2	56	10.00	15.00	100	10	2024-11-05 00:00:00
2005	Sopa de letras la moderna	None	2	44	10.00	15.00	100	10	2024-11-05 00:00:00
2006	Sopa maruchan pollo	None	2	57	10.00	15.00	100	10	2024-11-05 00:00:00
2007	Sopa maruchan camaron	None	2	57	10.00	15.00	100	10	2024-11-05 00:00:00
2008	Sopa maruchan res	None	2	57	10.00	15.00	100	10	2024-11-05 00:00:00
2009	Sopa maruchan habanero	None	2	57	10.00	15.00	100	10	2024-11-05 00:00:00
2010	Sopa maruchan piquin	None	2	57	10.00	15.00	100	10	2024-11-05 00:00:00
2011	Sopa maruchan limon	None	2	57	10.00	15.00	100	10	2024-11-05 00:00:00
2012	Lentejas la moderna	None	2	44	10.00	15.00	100	10	2024-11-05 00:00:00
2013	Jamon de pavo Fud 250g	Jamon de Pavo Fud 250 gramos	18	53	35.00	45.00	100	10	2024-11-05 00:00:00
2014	Jamon de pavo San Rafael 250g	Jamon de Pavo San Rafael 250 gramos	18	52	40.00	50.00	100	10	2024-11-05 00:00:00
2015	Cremax chocolate	None	29	46	8.00	10.50	100	10	2024-11-05 00:00:00
2016	Cremax fresa	None	29	46	8.00	10.50	100	10	2024-11-05 00:00:00
2017	Florentinas gamesa	None	29	46	8.00	10.50	100	10	2024-11-05 00:00:00
2018	Marias doradas	None	29	46	8.00	10.50	100	10	2024-11-05 00:00:00
2019	Gamesa cajeta	None	29	46	8.00	10.50	100	10	2024-11-05 00:00:00
2020	Maravillas gamesa	None	29	46	8.00	10.50	100	10	2024-11-05 00:00:00
2021	Crackets gamesa	None	29	46	8.00	10.50	100	10	2024-11-05 00:00:00
2022	Surtido rico gamesa	None	29	46	8.00	10.50	100	10	2024-11-05 00:00:00
2023	Delicias gamesa	None	29	46	8.00	10.50	100	10	2024-11-05 00:00:00
2024	Oreo	None	9	58	8.00	10.50	100	10	2024-11-05 00:00:00
2025	Principe chocolate	None	9	22	8.00	10.50	100	10	2024-11-05 00:00:00
2026	Principe vainilla	None	9	22	8.00	10.50	100	10	2024-11-05 00:00:00
2027	Principe limon	None	9	22	8.00	10.50	100	10	2024-11-05 00:00:00
2028	Principe chocolate blanco	None	9	22	8.00	10.50	100	10	2024-11-05 00:00:00
2029	Lors	None	9	22	8.00	10.50	100	10	2024-11-05 00:00:00
2030	Plativolos	None	9	22	8.00	10.50	100	10	2024-11-05 00:00:00
2031	Sponch	None	9	22	8.00	10.50	100	10	2024-11-05 00:00:00
2032	Triki trakes	None	9	22	8.00	10.50	100	10	2024-11-05 00:00:00
2033	MaxiTubo Triki trakes	None	9	22	8.00	10.50	100	10	2024-11-05 00:00:00
2034	Gansito	None	9	22	8.00	10.50	100	10	2024-11-05 00:00:00
2035	Pinguinos	None	9	22	8.00	10.50	100	10	2024-11-05 00:00:00
2036	Pasticetas marinela	None	9	22	8.00	10.50	100	10	2024-11-05 00:00:00
2037	Barritas fresa	None	9	22	8.00	10.50	100	10	2024-11-05 00:00:00
2038	Barritas pina	None	9	22	8.00	10.50	100	10	2024-11-05 00:00:00
2039	Barritas moras	None	9	22	8.00	10.50	100	10	2024-11-05 00:00:00
2040	Maxitubo Barritas pina	None	9	22	8.00	10.50	100	10	2024-11-05 00:00:00
2041	Canelitas	None	9	22	8.00	10.50	100	10	2024-11-05 00:00:00
2042	Polvorones	None	9	22	8.00	10.50	100	10	2024-11-05 00:00:00
2043	Maxitubo Polvorones	None	9	22	8.00	10.50	100	10	2024-11-05 00:00:00
2044	Ricanelas	None	9	46	8.00	10.50	100	10	2024-11-05 00:00:00
2045	Ritz bits queso	None	9	58	8.00	10.50	100	10	2024-11-05 00:00:00
2046	Arcoiris	None	9	46	8.00	10.50	100	10	2024-11-05 00:00:00
2047	Submarinos fresa	None	9	22	8.00	10.50	100	10	2024-11-05 00:00:00
2048	Submarinos vainilla	None	9	22	8.00	10.50	100	10	2024-11-05 00:00:00
2049	Submarinos chocolate	None	9	22	8.00	10.50	100	10	2024-11-05 00:00:00
2050	Rocko chico	None	9	22	8.00	10.50	100	10	2024-11-05 00:00:00
2051	Rocko grande	None	9	22	8.00	10.50	100	10	2024-11-05 00:00:00
2052	Sabritas original	None	9	3	8.00	10.50	100	10	2024-11-05 00:00:00
2053	Sabritas adobadas	None	9	3	8.00	10.50	100	10	2024-11-05 00:00:00
2054	Sabritas limon	None	9	3	8.00	10.50	100	10	2024-11-05 00:00:00
2055	Sabritas flamin hot	None	9	3	8.00	10.50	100	10	2024-11-05 00:00:00
2056	Sabritas crema y especias	None	9	3	8.00	10.50	100	10	2024-11-05 00:00:00
2057	Sabritas habanero	None	9	3	8.00	10.50	100	10	2024-11-05 00:00:00
2058	Sabritas receta crujiente	None	9	3	8.00	10.50	100	10	2024-11-05 00:00:00
2059	Chips jalapeno	None	9	47	8.00	10.50	100	10	2024-11-05 00:00:00
2060	Crujitos	None	9	3	8.00	10.50	100	10	2024-11-05 00:00:00
2061	Doritos nacho	None	9	3	8.00	10.50	100	10	2024-11-05 00:00:00
2062	Doritos incognita	None	9	3	8.00	10.50	100	10	2024-11-05 00:00:00
2063	Doritos diablo	None	9	3	8.00	10.50	100	10	2024-11-05 00:00:00
2064	Doritos flamin hot	None	9	3	8.00	10.50	100	10	2024-11-05 00:00:00
2065	Doritos dinamita	None	9	3	8.00	10.50	100	10	2024-11-05 00:00:00
2066	Sabritones	None	9	3	8.00	10.50	100	10	2024-11-05 00:00:00
2067	Bigmix queso	None	9	47	8.00	10.50	100	10	2024-11-05 00:00:00
2068	Bigmix fuego	None	9	47	8.00	10.50	100	10	2024-11-05 00:00:00
2069	Cheetos torciditos	None	9	3	8.00	10.50	100	10	2024-11-05 00:00:00
2070	Cheetos bolitas	None	9	3	8.00	10.50	100	10	2024-11-05 00:00:00
2071	Cheetos queso	None	9	3	8.00	10.50	100	10	2024-11-05 00:00:00
2072	Cheetos flamin hot	None	9	3	8.00	10.50	100	10	2024-11-05 00:00:00
2073	Ruffles original	None	9	3	8.00	10.50	100	10	2024-11-05 00:00:00
2074	Ruffles queso	None	9	3	8.00	10.50	100	10	2024-11-05 00:00:00
2075	Fritos sal y limon	None	9	3	8.00	10.50	100	10	2024-11-05 00:00:00
2076	Fritos chorizo	None	9	3	8.00	10.50	100	10	2024-11-05 00:00:00
2077	Bolsaza Sabritas original	None	9	3	8.00	10.50	100	10	2024-11-05 00:00:00
2078	Bolsaza Doritos nacho	None	9	3	8.00	10.50	100	10	2024-11-05 00:00:00
2079	Paketaxo	None	9	3	8.00	10.50	100	10	2024-11-05 00:00:00
2080	Paketaxo queso	None	9	3	8.00	10.50	100	10	2024-11-05 00:00:00
2081	Paketaxo flamin hot	None	9	3	8.00	10.50	100	10	2024-11-05 00:00:00
2082	Churrumaiz	None	9	3	8.00	10.50	100	10	2024-11-05 00:00:00
2083	Churrumaiz flamin hot	None	9	3	8.00	10.50	100	10	2024-11-05 00:00:00
2084	Rancheritos	None	9	3	8.00	10.50	100	10	2024-11-05 00:00:00
2085	Sabritas switch doritos nacho	None	9	3	8.00	10.50	100	10	2024-11-05 00:00:00
2086	Runners	None	9	47	8.00	10.50	100	10	2024-11-05 00:00:00
2087	Chips sal	None	9	47	8.00	10.50	100	10	2024-11-05 00:00:00
2088	Papatinas	None	9	47	8.00	10.50	100	10	2024-11-05 00:00:00
2089	Chips fuego	None	9	47	8.00	10.50	100	10	2024-11-05 00:00:00
2090	Palomitas pop	None	9	47	8.00	10.50	100	10	2024-11-05 00:00:00
2091	Takis original 	None	9	47	8.00	10.50	100	10	2024-11-05 00:00:00
2092	Takis fuego	None	9	47	8.00	10.50	100	10	2024-11-05 00:00:00
2093	Takis salsa brava	None	9	47	8.00	10.50	100	10	2024-11-05 00:00:00
2094	Takis guacamole	None	9	47	8.00	10.50	100	10	2024-11-05 00:00:00
2095	Chipotles	None	9	47	8.00	10.50	100	10	2024-11-05 00:00:00
2096	Tostachos	None	9	47	8.00	10.50	100	10	2024-11-05 00:00:00
2097	Hot nuts	None	9	47	8.00	10.50	100	10	2024-11-05 00:00:00
2098	Hot nuts fuego	None	9	47	8.00	10.50	100	10	2024-11-05 00:00:00
2099	Valentones	None	9	47	8.00	10.50	100	10	2024-11-05 00:00:00
2100	Watz barcel	None	9	47	8.00	10.50	100	10	2024-11-05 00:00:00
2101	Toreadas	None	9	47	8.00	10.50	100	10	2024-11-05 00:00:00
2102	Palomitas pop fuego	None	9	47	8.00	10.50	100	10	2024-11-05 00:00:00
2103	Takis blue heat	None	9	47	8.00	10.50	100	10	2024-11-05 00:00:00
2104	Doraditas tia rosa	None	29	49	8.00	10.50	100	10	2024-11-05 00:00:00
2105	Sabritas receta crujiente jalapeno	None	9	3	8.00	10.50	100	10	2024-11-05 00:00:00
2106	Tortillinas tia rosa	None	10	49	8.00	10.50	100	10	2024-11-05 00:00:00
2107	Conchas tia rosa	None	29	49	8.00	10.50	100	10	2024-11-05 00:00:00
2108	Hersheys Cookies n Cream	None	8	45	8.00	10.50	100	10	2024-11-05 00:00:00
2109	Hersheys almendras	None	8	45	8.00	10.50	100	10	2024-11-05 00:00:00
2110	Hersheys chocolate amargo	None	8	45	8.00	10.50	100	10	2024-11-05 00:00:00
2111	Hersheys chocolate blanco	None	8	45	8.00	10.50	100	10	2024-11-05 00:00:00
2112	Crunch	None	8	19	8.00	10.50	100	10	2024-11-05 00:00:00
2113	Carlos V	None	8	19	8.00	10.50	100	10	2024-11-05 00:00:00
2114	Milky way	None	8	19	8.00	10.50	100	10	2024-11-05 00:00:00
2115	Snickers	None	8	19	8.00	10.50	100	10	2024-11-05 00:00:00
2116	Kit kat	None	8	19	8.00	10.50	100	10	2024-11-05 00:00:00
2117	Kinder delice	None	8	40	8.00	10.50	100	10	2024-11-05 00:00:00
2118	Kinder sorpresa	None	8	40	8.00	10.50	100	10	2024-11-05 00:00:00
2119	Ferrero rocher 3 piezas	None	8	40	8.00	10.50	100	10	2024-11-05 00:00:00
2120	Mazapan	None	8	62	8.00	10.50	100	10	2024-11-05 00:00:00
2121	Pelon pelo rico	None	8	45	8.00	10.50	100	10	2024-11-05 00:00:00
2122	Pulparindo tamarindo	None	8	62	8.00	10.50	100	10	2024-11-05 00:00:00
2123	Pulparindo chamoy	None	8	62	8.00	10.50	100	10	2024-11-05 00:00:00
2124	Tutsi pop	None	8	65	8.00	10.50	100	10	2024-11-05 00:00:00
2125	Oblea cajeta coronado	None	8	66	8.00	10.50	100	10	2024-11-05 00:00:00
2126	Paleta payaso	None	8	67	8.00	10.50	100	10	2024-11-05 00:00:00
2127	Duvalin fresa vainilla	None	8	67	8.00	10.50	100	10	2024-11-05 00:00:00
2128	Duvalin chocolate vainilla	None	8	67	8.00	10.50	100	10	2024-11-05 00:00:00
2129	Duvalin vainilla	None	8	67	8.00	10.50	100	10	2024-11-05 00:00:00
2130	Duvalin trisabor	None	8	67	8.00	10.50	100	10	2024-11-05 00:00:00
2131	Duvalin choco avellana	None	8	67	8.00	10.50	100	10	2024-11-05 00:00:00
2132	Paleta Vero mango	None	8	68	8.00	10.50	100	10	2024-11-05 00:00:00
2133	Paleta Vero elote	None	8	67	8.00	10.50	100	10	2024-11-05 00:00:00
2134	Panditas	None	8	67	8.00	10.50	100	10	2024-11-05 00:00:00
2135	Panditas rellenos	None	8	67	8.00	10.50	100	10	2024-11-05 00:00:00
2136	Panditas san valentin	None	8	67	8.00	10.50	100	10	2024-11-05 00:00:00
2137	Bubulubu	None	8	67	8.00	10.50	100	10	2024-11-05 00:00:00
2138	Rockaleta	None	8	69	8.00	10.50	100	10	2024-11-05 00:00:00
2139	Tic tac menta	None	8	40	8.00	10.50	100	10	2024-11-05 00:00:00
2140	Halls menta	None	8	58	8.00	10.50	100	10	2024-11-05 00:00:00
2141	Halls limon	None	8	58	8.00	10.50	100	10	2024-11-05 00:00:00
2142	Halls yerba buena	None	8	58	8.00	10.50	100	10	2024-11-05 00:00:00
2143	Halls miel	None	8	58	8.00	10.50	100	10	2024-11-05 00:00:00
2144	Halls negras	None	8	58	8.00	10.50	100	10	2024-11-05 00:00:00
2145	Gomilocas dientes	None	8	67	8.00	10.50	100	10	2024-11-05 00:00:00
2146	Gomilocas pinguino	None	8	67	8.00	10.50	100	10	2024-11-05 00:00:00
2147	Chocoretas	None	8	67	8.00	10.50	100	10	2024-11-05 00:00:00
2148	Kranky	None	8	67	8.00	10.50	100	10	2024-11-05 00:00:00
2149	Lucas muecas	None	8	58	8.00	10.50	100	10	2024-11-05 00:00:00
2150	Lucas chamoy	None	8	58	8.00	10.50	100	10	2024-11-05 00:00:00
2151	Lucas gusanito	None	8	58	8.00	10.50	100	10	2024-11-05 00:00:00
2152	Palomitas Act II mantequilla	None	9	58	8.00	10.50	100	10	2024-11-05 00:00:00
2153	Palomitas Act II natural	None	9	58	8.00	10.50	100	10	2024-11-05 00:00:00
2154	Palomitas Act II chile limon	None	9	58	8.00	10.50	100	10	2024-11-05 00:00:00
2155	Tostitos salsa verde	None	9	3	8.00	10.50	100	10	2024-11-05 00:00:00
2156	Zucaritas chicas	None	5	26	8.00	10.50	100	10	2024-11-05 00:00:00
2157	Zucaritas grandes	None	5	26	8.00	10.50	100	10	2024-11-05 00:00:00
2158	Corn flakes chicas	None	5	26	8.00	10.50	100	10	2024-11-05 00:00:00
2159	Corn flakes grandes	None	5	26	8.00	10.50	100	10	2024-11-05 00:00:00
2160	Choco Krispis chicas	None	5	26	8.00	10.50	100	10	2024-11-05 00:00:00
2161	Choco Krispis grandes	None	5	26	8.00	10.50	100	10	2024-11-05 00:00:00
2162	Nesquik chico	None	5	26	8.00	10.50	100	10	2024-11-05 00:00:00
2163	Nesquik grande	None	5	26	8.00	10.50	100	10	2024-11-05 00:00:00
2164	Froot loops chicas	None	5	26	8.00	10.50	100	10	2024-11-05 00:00:00
2165	Froot loops grandes	None	5	26	8.00	10.50	100	10	2024-11-05 00:00:00
2166	Chocomilk sobre	None	4	58	8.00	10.50	100	10	2024-11-05 00:00:00
2167	Chocomilk bolsa	None	4	58	8.00	10.50	100	10	2024-11-05 00:00:00
2168	Chocomilk lata	None	4	58	8.00	10.50	100	10	2024-11-05 00:00:00
2169	Nescafe clasico sobre	None	4	19	8.00	10.50	100	10	2024-11-05 00:00:00
2170	Nescafe capuccino sobre	None	4	19	8.00	10.50	100	10	2024-11-05 00:00:00
2171	Nescafe clasico bote chico	None	4	19	8.00	10.50	100	10	2024-11-05 00:00:00
2172	Nescafe clasico bote grande	None	4	19	8.00	10.50	100	10	2024-11-05 00:00:00
2173	Azucar Zulka 1kg	None	3	58	8.00	10.50	100	10	2024-11-05 00:00:00
2174	Azucar refinada 1kg	None	3	58	8.00	10.50	100	10	2024-11-05 00:00:00
2175	Azucar refinada 500gr	None	3	58	8.00	10.50	100	10	2024-11-05 00:00:00
2176	Azucar refinada 250gr	None	3	58	8.00	10.50	100	10	2024-11-05 00:00:00
2177	Aceite nutrioli 1lt	None	1	58	8.00	10.50	100	10	2024-11-05 00:00:00
2178	Aceite capullo 1lt	None	1	58	8.00	10.50	100	10	2024-11-05 00:00:00
2179	Aceite 1 2 3 1lt	None	1	58	8.00	10.50	100	10	2024-11-05 00:00:00
2180	Aceite patrona 1lt	None	1	58	8.00	10.50	100	10	2024-11-05 00:00:00
2181	Vinagre blanco la coste¤a	None	1	27	8.00	10.50	100	10	2024-11-05 00:00:00
2182	Vinagre de manzana la coste¤a	None	1	27	8.00	10.50	100	10	2024-11-05 00:00:00
2183	Catsup la coste¤a	None	1	27	8.00	10.50	100	10	2024-11-05 00:00:00
2184	Catsup Del monte	None	1	70	8.00	10.50	100	10	2024-11-05 00:00:00
2185	Catsup heinz	None	1	71	8.00	10.50	100	10	2024-11-05 00:00:00
2186	Jugo Magui	None	7	19	8.00	10.50	100	10	2024-11-05 00:00:00
2187	Salsa inglesa	None	7	19	8.00	10.50	100	10	2024-11-05 00:00:00
2188	Salsa valentina chica	None	7	58	8.00	10.50	100	10	2024-11-05 00:00:00
2189	Salsa valentina grande	None	7	58	8.00	10.50	100	10	2024-11-05 00:00:00
2190	Salsa tabasco	None	7	58	8.00	10.50	100	10	2024-11-05 00:00:00
2191	Salsa buffalo	None	7	58	8.00	10.50	100	10	2024-11-05 00:00:00
2192	Salsa chipotle la coste¤a	None	7	27	8.00	10.50	100	10	2024-11-05 00:00:00
2193	Chile chipotle la coste¤a	None	6	27	8.00	10.50	100	10	2024-11-05 00:00:00
2194	Tic tac naranja	None	8	40	8.00	10.50	100	10	2024-11-05 00:00:00
2195	Yogurt Yoplait natural 1L	Yogurt Yoplait natural 1 Litro	17	54	26.00	31.00	100	10	2024-11-05 00:00:00
2196	Cremax vainilla	None	29	46	8.00	10.50	100	10	2024-11-05 00:00:00
2197	Maxitubo Barritas fresa	None	9	22	8.00	10.50	100	10	2024-11-05 00:00:00
2198	Bigote tia rosa	None	29	49	8.00	10.50	100	10	2024-11-05 00:00:00
2199	Magdalenas tia rosa	None	29	49	8.00	10.50	100	10	2024-11-05 00:00:00
2200	Chiles serranos la coste¤a	None	6	27	8.00	10.50	100	10	2024-11-05 00:00:00
2201	Chiles en vinagre la coste¤a	None	6	27	8.00	10.50	100	10	2024-11-05 00:00:00
2202	Chile chipotle la morena	None	6	72	8.00	10.50	100	10	2024-11-05 00:00:00
2203	Chiles en vinagre la morena	None	6	72	8.00	10.50	100	10	2024-11-05 00:00:00
2204	Mayonesa mccormick chica	None	7	72	8.00	10.50	100	10	2024-11-05 00:00:00
2205	Mayonesa mccormick grande	None	7	72	8.00	10.50	100	10	2024-11-05 00:00:00
2206	Mostaza mccormick	None	7	72	8.00	10.50	100	10	2024-11-05 00:00:00
2207	Mermelada mccormick fresa chica	None	19	72	8.00	10.50	100	10	2024-11-05 00:00:00
2208	Mermelada mccormick fresa grande	None	19	72	8.00	10.50	100	10	2024-11-05 00:00:00
2209	Cloralex 1/2 lt	None	35	58	8.00	10.50	100	10	2024-11-05 00:00:00
2210	Cloralex 1 lt	None	35	58	8.00	10.50	100	10	2024-11-05 00:00:00
2211	Pinol	None	35	58	8.00	10.50	100	10	2024-11-05 00:00:00
2212	Fabuloso lavanda 1lt	None	35	58	8.00	10.50	100	10	2024-11-05 00:00:00
2213	Fabuloso aroma floral 1lt	None	35	58	8.00	10.50	100	10	2024-11-05 00:00:00
2214	Detergente Ariel 1/2 kg	None	34	58	8.00	10.50	100	10	2024-11-05 00:00:00
2215	Detergente Ariel 1kg	None	34	58	8.00	10.50	100	10	2024-11-05 00:00:00
2216	Detergente Ace 1/2 kg	None	34	58	8.00	10.50	100	10	2024-11-05 00:00:00
2217	Detergente Ace 1kg	None	34	58	8.00	10.50	100	10	2024-11-05 00:00:00
2218	Detergente Foca 1/2 kg	None	34	58	8.00	10.50	100	10	2024-11-05 00:00:00
2219	Detergente Foca 1kg	None	34	58	8.00	10.50	100	10	2024-11-05 00:00:00
2220	Suavitel 1l	None	34	58	8.00	10.50	100	10	2024-11-05 00:00:00
2221	Papel higienico Petalo 4 rollos	None	37	58	8.00	10.50	100	10	2024-11-05 00:00:00
2222	Papel higienico Petalo 6 rollos	None	37	58	8.00	10.50	100	10	2024-11-05 00:00:00
2223	Papel higienico Suavel 4 rollos	None	37	58	8.00	10.50	100	10	2024-11-05 00:00:00
2224	Papel higienico Suavel 6 rollos	None	37	58	8.00	10.50	100	10	2024-11-05 00:00:00
2225	Toallas sanitarias Always	None	37	58	8.00	10.50	100	10	2024-11-05 00:00:00
2226	Toallas sanitarias Kotex	None	37	58	8.00	10.50	100	10	2024-11-05 00:00:00
2227	Panales Huggies	None	44	58	8.00	10.50	100	10	2024-11-05 00:00:00
2228	Shampoo Head & Shoulders chico	None	39	58	8.00	10.50	100	10	2024-11-05 00:00:00
2229	Shampoo Head & Shoulders grande	None	39	58	8.00	10.50	100	10	2024-11-05 00:00:00
2230	Desodorante Axe	None	41	58	8.00	10.50	100	10	2024-11-05 00:00:00
2231	Leche deslactosada 1lt	Presentacion azul	15	4	18.20	23.00	14	2	2024-11-05 00:00:00
2232	Yomi lala chocolate	None	15	4	15.00	30.00	100	10	2024-11-05 00:00:00
2233	Yomi lala vainilla	None	15	4	15.00	30.00	100	10	2024-11-05 00:00:00
2234	Yomi lala fresa	None	15	4	15.00	30.00	100	10	2024-11-05 00:00:00
2235	Yogurt lala fresa	None	15	4	15.00	30.00	100	10	2024-11-05 00:00:00
2236	Yogurt lala durazno	None	15	4	15.00	30.00	100	10	2024-11-05 00:00:00
2237	Yogurt lala manzana	None	15	4	15.00	30.00	100	10	2024-11-05 00:00:00
2238	Yogurt bebible lala manzana	None	15	4	15.00	30.00	100	10	2024-11-05 00:00:00
2239	Yogurt bebible lala durazno	None	15	4	15.00	30.00	100	10	2024-11-05 00:00:00
2240	Yogurt bebible lala fresa	None	15	4	15.00	30.00	100	10	2024-11-05 00:00:00
2241	Yogurt bebible lala moras	None	15	4	15.00	30.00	100	10	2024-11-05 00:00:00
2242	Yogurt bebible lala pina coco	None	15	4	15.00	30.00	100	10	2024-11-05 00:00:00
2243	Licuado lala fresa platano	None	15	4	15.00	30.00	100	10	2024-11-05 00:00:00
2244	Licuado lala nuez	None	15	4	15.00	30.00	100	10	2024-11-05 00:00:00
2245	Flan lala	None	15	4	15.00	30.00	100	10	2024-11-05 00:00:00
2246	Margarina lala 90gr	None	15	4	15.00	30.00	100	10	2024-11-05 00:00:00
2247	Jabon zote rosa chico	None	42	58	8.00	10.50	100	10	2024-11-05 00:00:00
2248	Jabon zote rosa grande	None	42	58	8.00	10.50	100	10	2024-11-05 00:00:00
2249	Jabon zote blanco chico	None	42	58	8.00	10.50	100	10	2024-11-05 00:00:00
2250	Jabon zote blanco grande	None	42	58	8.00	10.50	100	10	2024-11-05 00:00:00
2251	Roles	Ricos roles de canela caseros	27	13	70.00	100.00	19	10	2024-11-07 00:00:00
2252	Pepsi	bebida azucarada	31	14	8.00	16.00	77	20	2024-11-07 00:00:00
2253	Manzanita		31	14	17.00	25.00	22	3	2024-11-07 00:00:00
2254	MaruchanTokyo	maruchan picante	2	11	5.50	12.50	15	10	2024-11-07 00:00:00
2255	Harina de maiz maseca	None	10	59	8.00	10.50	100	10	2024-11-07 00:00:00
2256	Sabritas	Sabritas Flamin Hot	9	3	10.00	18.00	4	1	2024-11-07 00:00:00
2257	Galletas marias	Las galletas clasicas	9	3	8.90	15.00	19	2	2024-11-07 00:00:00
2258	Leche entera lala 1lt	Clasica color roja	15	4	15.24	25.00	11	3	2024-11-07 00:00:00
2259	Leche Lala entera 1L	Leche Lala entera 1 Litro	15	4	19.00	24.00	100	10	2024-11-07 00:00:00
2260	Tostadas charras	None	5	60	8.00	10.50	100	10	2024-11-07 00:00:00
2261	Leche Lala light 1L	Leche Lala light 1 Litro	15	4	20.00	25.00	100	10	2024-11-07 00:00:00
2262	Leche Santa Clara entera 1L	Leche Santa Clara entera 1 Litro	15	4	22.00	28.00	100	10	2024-11-07 00:00:00
2263	Leche Santa Clara deslactosada 1L	Leche Santa Clara deslactosada 1 Litro	15	4	23.00	29.00	100	10	2024-11-07 00:00:00
2264	Arroz Mexica 1kg	None	2	59	12.00	16.50	100	10	2024-11-07 00:00:00
2265	Del Valle fruit naranja 600ml	Jugo Del Valle sabor Naranja 600 ml	31	28	10.50	13.50	100	10	2024-11-07 00:00:00
2266	Harina de trigo San antonio	None	10	41	8.00	10.50	100	10	2024-11-07 00:00:00
2267	Tortillas de maiz 1/2 kg	None	10	58	8.00	10.50	100	10	2024-11-07 00:00:00
2268	Pan bimbo blanco chico	None	27	17	8.00	10.50	100	10	2024-11-07 00:00:00
2269	Pan bimbo blanco grande	None	27	17	8.00	10.50	100	10	2024-11-07 00:00:00
2270	Pan bimbo integral chico	None	27	17	8.00	10.50	100	10	2024-11-07 00:00:00
2271	Pan bimbo integral grande	None	27	17	8.00	10.50	100	10	2024-11-07 00:00:00
2272	Rebanadas bimbo	None	27	17	8.00	10.50	100	10	2024-11-07 00:00:00
2273	Chocoroles	None	27	17	8.00	10.50	100	10	2024-11-07 00:00:00
2274	Nito bimbo	None	27	17	8.00	10.50	100	10	2024-11-07 00:00:00
2275	Mantecadas	None	27	17	8.00	10.50	100	10	2024-11-07 00:00:00
2276	Roles de canela con pasas	None	27	17	8.00	10.50	100	10	2024-11-07 00:00:00
2277	Roles de canela glaseados	None	27	17	8.00	10.50	100	10	2024-11-07 00:00:00
2278	Conchas bimbo	None	27	17	8.00	10.50	100	10	2024-11-07 00:00:00
2279	Panque de nuez bimbo	None	27	17	8.00	10.50	100	10	2024-11-07 00:00:00
2280	Donitas bimbo	None	27	17	8.00	10.50	100	10	2024-11-07 00:00:00
2281	Donitas espolvoreadas bimbo	None	27	17	8.00	10.50	100	10	2024-11-07 00:00:00
2282	chimichangas	chimichangas	23	10	30.00	45.00	15	5	2024-11-07 00:00:00
2283	Coca Cola 1L	Refresco Coca Cola 1 Litro	31	16	12.00	15.00	100	10	2024-11-07 00:00:00
2284	Coca Cola lata 355ml	Refresco Coca Cola 355 ml lata	31	16	8.50	11.00	100	10	2024-11-07 00:00:00
2285	Coca Cola 355ml	Refresco Coca Cola 355 ml	31	16	8.00	10.50	100	10	2024-11-07 00:00:00
2286	Coca Cola 600ml	Refresco Coca Cola 600 ml	31	16	9.00	12.00	100	10	2024-11-07 00:00:00
2287	Coca Cola retornable 1 1/4 lt.	Refresco Coca Cola retornable 1 1/4 lt	31	16	12.50	15.50	100	10	2024-11-07 00:00:00
2288	Coca Cola 2L retornable	Refresco Coca Cola retornable 2 Litros	31	16	19.50	24.00	100	10	2024-11-07 00:00:00
2289	Coca Cola 3L retornable	Refresco Coca Cola retornable 3 Litros	31	16	24.00	30.00	100	10	2024-11-07 00:00:00
2290	Coca Cola Light 600ml	Refresco Coca Cola Light 600 ml	31	16	9.50	12.50	100	10	2024-11-07 00:00:00
2291	Pepsi 600ml	Refresco Pepsi 600 ml	31	14	9.00	12.00	100	10	2024-11-07 00:00:00
2292	Pepsi 1.5L	Refresco Pepsi 1.5 Litros	31	14	12.00	15.50	100	10	2024-11-07 00:00:00
2293	Fanta 600ml	Refresco Fanta 600 ml	31	16	9.00	12.00	100	10	2024-11-07 00:00:00
2294	Fanta 1.5L	Refresco Fanta 1.5 Litros	31	16	12.50	16.00	100	10	2024-11-07 00:00:00
2295	Sprite 600ml	Refresco Sprite 600 ml	31	16	9.00	12.00	100	10	2024-11-07 00:00:00
2296	Sprite 1.5L	Refresco Sprite 1.5 Litros	31	16	12.50	16.00	100	10	2024-11-07 00:00:00
2297	Manzanita 600ml	Refresco Manzanita Sol 600 ml	31	16	9.00	12.00	100	10	2024-11-07 00:00:00
2298	Manzanita 1.5L	Refresco Manzanita Sol 1.5 Litros	31	16	12.50	16.00	100	10	2024-11-07 00:00:00
2299	Fresca 600ml	Refresco Fresca 600 ml	31	16	9.00	12.00	100	10	2024-11-07 00:00:00
2300	Fresca 3L	Refresco Fresca 3 Litros	31	16	24.00	30.00	100	10	2024-11-07 00:00:00
2301	Mirinda 600ml	Refresco Mirinda 600 ml	31	16	9.00	12.00	100	10	2024-11-07 00:00:00
2302	Mirinda 1.5L	Refresco Mirinda 1.5 Litros	31	16	12.50	16.00	100	10	2024-11-07 00:00:00
2303	Tostadas Sanissimo	None	5	61	8.00	10.50	100	10	2024-11-07 00:00:00
2304	Marias gamesa	None	29	46	8.00	10.50	100	10	2024-11-07 00:00:00
2305	Jumex de mango 1L	Jugo Jumex sabor Mango 1 Litro	31	21	16.00	20.00	100	10	2024-11-07 00:00:00
2306	Emperador chocolate	None	29	46	8.00	10.50	100	10	2024-11-07 00:00:00
2307	Emperador nuez	None	29	46	8.00	10.50	100	10	2024-11-07 00:00:00
2308	Emperador vainilla	None	29	46	8.00	10.50	100	10	2024-11-07 00:00:00
2309	Emperador limon	None	29	46	8.00	10.50	100	10	2024-11-07 00:00:00
2310	Jumex de durazno 1L	Jugo Jumex sabor Durazno 1 Litro	31	21	16.00	20.00	100	10	2024-11-07 00:00:00
2311	Jumex de manzana 600ml	Jugo Jumex sabor Manzana 600 ml	31	21	10.00	13.00	100	10	2024-11-07 00:00:00
2312	Del Valle fruit manzana 600ml	Jugo Del Valle sabor Manzana 600 ml	31	28	10.50	13.50	100	10	2024-11-07 00:00:00
2313	Del Valle fruit guayaba 600ml	Jugo Del Valle sabor Guayaba 600 ml	31	28	10.50	13.50	100	10	2024-11-07 00:00:00
2314	Emperador Senso	None	29	46	8.00	10.50	100	10	2024-11-07 00:00:00
2315	Mamut chico	None	29	46	8.00	10.50	100	10	2024-11-07 00:00:00
2316	Yogurt Lala natural 1L	Yogurt Lala natural 1 Litro	17	4	25.00	30.00	100	10	2024-11-07 00:00:00
2317	Yogurt Lala de fresa 1L	Yogurt Lala sabor Fresa 1 Litro	17	4	25.00	30.00	100	10	2024-11-07 00:00:00
2318	Yogurt Yoplait de fresa 1L	Yogurt Yoplait sabor Fresa 1 Litro	17	54	26.00	31.00	100	10	2024-11-07 00:00:00
2319	Mantequilla Lala 250g	Mantequilla Lala 250 gramos	19	4	30.00	38.00	100	10	2024-11-07 00:00:00
2320	Queso panela Lala 200g	Queso panela Lala 200 gramos	16	4	40.00	50.00	100	10	2024-11-07 00:00:00
2321	Mamut grande	None	29	46	8.00	10.50	100	10	2024-11-07 00:00:00
2322	Chokis	None	29	46	8.00	10.50	100	10	2024-11-07 00:00:00
2323	Chokis rellenas	None	29	46	8.00	10.50	100	10	2024-11-07 00:00:00
2324	Chokis doble chocolate	None	29	46	8.00	10.50	100	10	2024-11-07 00:00:00
2325	Chokis brownie	None	29	46	8.00	10.50	100	10	2024-11-07 00:00:00
2326	Leche Lala deslactosada 1L	Leche Lala deslactosada 1 Litro	15	4	20.00	25.00	100	10	2024-11-07 00:00:00
2327	Queso panela Alpura 200g	Queso panela Alpura 200 gramos	16	18	40.00	50.00	100	10	2024-11-07 00:00:00
2328	Queso oaxaca Lala 200g	Queso Oaxaca Lala 200 gramos	16	4	45.00	55.00	100	10	2024-11-07 00:00:00
2329	Queso manchego Lala 200g	Queso Manchego Lala 200 gramos	16	4	50.00	60.00	100	10	2024-11-07 00:00:00
2330	Salchichas Fud paquete 500g	Salchichas Fud 500 gramos	18	53	30.00	40.00	100	10	2024-11-07 00:00:00
2331	Salchichas San Rafael paquete 500g	Salchichas San Rafael 500 gramos	18	52	35.00	45.00	100	10	2024-11-07 00:00:00
2332	Sidral mundet 600ml	Refresco de manzana de 600ml	31	16	10.00	16.00	20	5	2024-11-07 00:00:00
2333	Sidral mundet 3lt	Refresco de manzana de 3lt	31	16	24.00	30.00	20	5	2024-11-07 00:00:00
2334	Agua bonafont 600ml	None	30	55	8.00	10.50	100	10	2024-11-07 00:00:00
2335	Agua bonafont 1lt	None	30	55	12.00	15.00	100	10	2024-11-07 00:00:00
2336	Agua bonafont 2lt.	None	30	55	14.00	18.00	100	10	2024-11-07 00:00:00
2337	Garrafon bonafont 20lt	None	30	55	19.50	24.00	100	10	2024-11-07 00:00:00
2338	Agua ciel 600ml	None	30	16	8.00	13.00	100	10	2024-11-07 00:00:00
2339	Agua ciel 1lt	None	30	16	10.00	15.00	100	10	2024-11-07 00:00:00
2340	Agua ciel 1.5l	None	30	16	12.00	17.00	100	10	2024-11-07 00:00:00
2341	Agua ciel 2lt	None	30	16	14.00	20.00	100	10	2024-11-07 00:00:00
2342	Agua E-pura 600ml	None	30	14	8.00	13.00	100	10	2024-11-07 00:00:00
2343	Agua E-pura 1lt	None	30	14	10.00	15.00	100	10	2024-11-07 00:00:00
2344	Garrafon E-pura 10lt	None	30	14	18.00	25.00	100	10	2024-11-07 00:00:00
2345	Crema Lala 200ml	None	15	4	8.00	13.00	100	10	2024-11-07 00:00:00
2346	Crema Lala 426ml	None	15	4	15.00	30.00	100	10	2024-11-07 00:00:00
2347	Crema Lala 900ml	None	15	4	35.00	55.00	100	10	2024-11-07 00:00:00
2348	Crema alpura 200ml	None	15	4	8.00	13.00	100	10	2024-11-07 00:00:00
2349	Crema alpura 426ml	None	15	4	15.00	30.00	100	10	2024-11-07 00:00:00
2350	Crema alpura 900ml	None	15	4	35.00	55.00	100	10	2024-11-07 00:00:00
2351	Atun dolores en agua	None	6	51	10.00	15.00	100	10	2024-11-07 00:00:00
2352	Atun dolores en aceite	None	6	51	12.00	17.00	100	10	2024-11-07 00:00:00
2353	Sardinas en aceite	None	6	20	10.00	15.00	100	10	2024-11-07 00:00:00
2354	Frijoles refritos	None	6	50	10.00	15.00	100	10	2024-11-07 00:00:00
2355	Frijoles bayos	None	6	50	10.00	15.00	100	10	2024-11-07 00:00:00
2356	Pasta la moderna	None	2	44	10.00	15.00	100	10	2024-11-07 00:00:00
2357	Coditos la moderna	None	2	44	10.00	15.00	100	10	2024-11-07 00:00:00
2358	Pasta Barilla espagueti	None	2	56	10.00	15.00	100	10	2024-11-07 00:00:00
2359	Sopa de letras la moderna	None	2	44	10.00	15.00	100	10	2024-11-07 00:00:00
2360	Sopa maruchan pollo	None	2	57	10.00	15.00	100	10	2024-11-07 00:00:00
2361	Sopa maruchan camaron	None	2	57	10.00	15.00	100	10	2024-11-07 00:00:00
2362	Sopa maruchan res	None	2	57	10.00	15.00	100	10	2024-11-07 00:00:00
2363	Sopa maruchan habanero	None	2	57	10.00	15.00	100	10	2024-11-07 00:00:00
2364	Sopa maruchan piquin	None	2	57	10.00	15.00	100	10	2024-11-07 00:00:00
2365	Sopa maruchan limon	None	2	57	10.00	15.00	100	10	2024-11-07 00:00:00
2366	Lentejas la moderna	None	2	44	10.00	15.00	100	10	2024-11-07 00:00:00
2367	Jamon de pavo Fud 250g	Jamon de Pavo Fud 250 gramos	18	53	35.00	45.00	100	10	2024-11-07 00:00:00
2368	Jamon de pavo San Rafael 250g	Jamon de Pavo San Rafael 250 gramos	18	52	40.00	50.00	100	10	2024-11-07 00:00:00
2369	Cremax chocolate	None	29	46	8.00	10.50	100	10	2024-11-07 00:00:00
2370	Cremax fresa	None	29	46	8.00	10.50	100	10	2024-11-07 00:00:00
2371	Florentinas gamesa	None	29	46	8.00	10.50	100	10	2024-11-07 00:00:00
2372	Marias doradas	None	29	46	8.00	10.50	100	10	2024-11-07 00:00:00
2373	Gamesa cajeta	None	29	46	8.00	10.50	100	10	2024-11-07 00:00:00
2374	Maravillas gamesa	None	29	46	8.00	10.50	100	10	2024-11-07 00:00:00
2375	Crackets gamesa	None	29	46	8.00	10.50	100	10	2024-11-07 00:00:00
2376	Surtido rico gamesa	None	29	46	8.00	10.50	100	10	2024-11-07 00:00:00
2377	Delicias gamesa	None	29	46	8.00	10.50	100	10	2024-11-07 00:00:00
2378	Oreo	None	9	58	8.00	10.50	100	10	2024-11-07 00:00:00
2379	Principe chocolate	None	9	22	8.00	10.50	100	10	2024-11-07 00:00:00
2380	Principe vainilla	None	9	22	8.00	10.50	100	10	2024-11-07 00:00:00
2381	Principe limon	None	9	22	8.00	10.50	100	10	2024-11-07 00:00:00
2382	Principe chocolate blanco	None	9	22	8.00	10.50	100	10	2024-11-07 00:00:00
2383	Lors	None	9	22	8.00	10.50	100	10	2024-11-07 00:00:00
2384	Plativolos	None	9	22	8.00	10.50	100	10	2024-11-07 00:00:00
2385	Sponch	None	9	22	8.00	10.50	100	10	2024-11-07 00:00:00
2386	Triki trakes	None	9	22	8.00	10.50	100	10	2024-11-07 00:00:00
2387	MaxiTubo Triki trakes	None	9	22	8.00	10.50	100	10	2024-11-07 00:00:00
2388	Gansito	None	9	22	8.00	10.50	100	10	2024-11-07 00:00:00
2389	Pinguinos	None	9	22	8.00	10.50	100	10	2024-11-07 00:00:00
2390	Pasticetas marinela	None	9	22	8.00	10.50	100	10	2024-11-07 00:00:00
2391	Barritas fresa	None	9	22	8.00	10.50	100	10	2024-11-07 00:00:00
2392	Barritas pina	None	9	22	8.00	10.50	100	10	2024-11-07 00:00:00
2393	Barritas moras	None	9	22	8.00	10.50	100	10	2024-11-07 00:00:00
2394	Maxitubo Barritas pina	None	9	22	8.00	10.50	100	10	2024-11-07 00:00:00
2395	Canelitas	None	9	22	8.00	10.50	100	10	2024-11-07 00:00:00
2396	Polvorones	None	9	22	8.00	10.50	100	10	2024-11-07 00:00:00
2397	Maxitubo Polvorones	None	9	22	8.00	10.50	100	10	2024-11-07 00:00:00
2398	Ricanelas	None	9	46	8.00	10.50	100	10	2024-11-07 00:00:00
2399	Ritz bits queso	None	9	58	8.00	10.50	100	10	2024-11-07 00:00:00
2400	Arcoiris	None	9	46	8.00	10.50	100	10	2024-11-07 00:00:00
2401	Submarinos fresa	None	9	22	8.00	10.50	100	10	2024-11-07 00:00:00
2402	Submarinos vainilla	None	9	22	8.00	10.50	100	10	2024-11-07 00:00:00
2403	Submarinos chocolate	None	9	22	8.00	10.50	100	10	2024-11-07 00:00:00
2404	Rocko chico	None	9	22	8.00	10.50	100	10	2024-11-07 00:00:00
2405	Rocko grande	None	9	22	8.00	10.50	100	10	2024-11-07 00:00:00
2406	Sabritas original	None	9	3	8.00	10.50	100	10	2024-11-07 00:00:00
2407	Sabritas adobadas	None	9	3	8.00	10.50	100	10	2024-11-07 00:00:00
2408	Sabritas limon	None	9	3	8.00	10.50	100	10	2024-11-07 00:00:00
2409	Sabritas flamin hot	None	9	3	8.00	10.50	100	10	2024-11-07 00:00:00
2410	Sabritas crema y especias	None	9	3	8.00	10.50	100	10	2024-11-07 00:00:00
2411	Sabritas habanero	None	9	3	8.00	10.50	100	10	2024-11-07 00:00:00
2412	Sabritas receta crujiente	None	9	3	8.00	10.50	100	10	2024-11-07 00:00:00
2413	Chips jalapeno	None	9	47	8.00	10.50	100	10	2024-11-07 00:00:00
2414	Crujitos	None	9	3	8.00	10.50	100	10	2024-11-07 00:00:00
2415	Doritos nacho	None	9	3	8.00	10.50	100	10	2024-11-07 00:00:00
2416	Doritos incognita	None	9	3	8.00	10.50	100	10	2024-11-07 00:00:00
2417	Doritos diablo	None	9	3	8.00	10.50	100	10	2024-11-07 00:00:00
2418	Doritos flamin hot	None	9	3	8.00	10.50	100	10	2024-11-07 00:00:00
2419	Doritos dinamita	None	9	3	8.00	10.50	100	10	2024-11-07 00:00:00
2420	Sabritones	None	9	3	8.00	10.50	100	10	2024-11-07 00:00:00
2421	Bigmix queso	None	9	47	8.00	10.50	100	10	2024-11-07 00:00:00
2422	Bigmix fuego	None	9	47	8.00	10.50	100	10	2024-11-07 00:00:00
2423	Cheetos torciditos	None	9	3	8.00	10.50	100	10	2024-11-07 00:00:00
2424	Cheetos bolitas	None	9	3	8.00	10.50	100	10	2024-11-07 00:00:00
2425	Cheetos queso	None	9	3	8.00	10.50	100	10	2024-11-07 00:00:00
2426	Cheetos flamin hot	None	9	3	8.00	10.50	100	10	2024-11-07 00:00:00
2427	Ruffles original	None	9	3	8.00	10.50	100	10	2024-11-07 00:00:00
2428	Ruffles queso	None	9	3	8.00	10.50	100	10	2024-11-07 00:00:00
2429	Fritos sal y limon	None	9	3	8.00	10.50	100	10	2024-11-07 00:00:00
2430	Fritos chorizo	None	9	3	8.00	10.50	100	10	2024-11-07 00:00:00
2431	Bolsaza Sabritas original	None	9	3	8.00	10.50	100	10	2024-11-07 00:00:00
2432	Bolsaza Doritos nacho	None	9	3	8.00	10.50	100	10	2024-11-07 00:00:00
2433	Paketaxo	None	9	3	8.00	10.50	100	10	2024-11-07 00:00:00
2434	Paketaxo queso	None	9	3	8.00	10.50	100	10	2024-11-07 00:00:00
2435	Paketaxo flamin hot	None	9	3	8.00	10.50	100	10	2024-11-07 00:00:00
2436	Churrumaiz	None	9	3	8.00	10.50	100	10	2024-11-07 00:00:00
2437	Churrumaiz flamin hot	None	9	3	8.00	10.50	100	10	2024-11-07 00:00:00
2438	Rancheritos	None	9	3	8.00	10.50	100	10	2024-11-07 00:00:00
2439	Sabritas switch doritos nacho	None	9	3	8.00	10.50	100	10	2024-11-07 00:00:00
2440	Runners	None	9	47	8.00	10.50	100	10	2024-11-07 00:00:00
2441	Chips sal	None	9	47	8.00	10.50	100	10	2024-11-07 00:00:00
2442	Papatinas	None	9	47	8.00	10.50	100	10	2024-11-07 00:00:00
2443	Chips fuego	None	9	47	8.00	10.50	100	10	2024-11-07 00:00:00
2444	Palomitas pop	None	9	47	8.00	10.50	100	10	2024-11-07 00:00:00
2445	Takis original 	None	9	47	8.00	10.50	100	10	2024-11-07 00:00:00
2446	Takis fuego	None	9	47	8.00	10.50	100	10	2024-11-07 00:00:00
2447	Takis salsa brava	None	9	47	8.00	10.50	100	10	2024-11-07 00:00:00
2448	Takis guacamole	None	9	47	8.00	10.50	100	10	2024-11-07 00:00:00
2449	Chipotles	None	9	47	8.00	10.50	100	10	2024-11-07 00:00:00
2450	Tostachos	None	9	47	8.00	10.50	100	10	2024-11-07 00:00:00
2451	Hot nuts	None	9	47	8.00	10.50	100	10	2024-11-07 00:00:00
2452	Hot nuts fuego	None	9	47	8.00	10.50	100	10	2024-11-07 00:00:00
2453	Valentones	None	9	47	8.00	10.50	100	10	2024-11-07 00:00:00
2454	Watz barcel	None	9	47	8.00	10.50	100	10	2024-11-07 00:00:00
2455	Toreadas	None	9	47	8.00	10.50	100	10	2024-11-07 00:00:00
2456	Palomitas pop fuego	None	9	47	8.00	10.50	100	10	2024-11-07 00:00:00
2457	Takis blue heat	None	9	47	8.00	10.50	100	10	2024-11-07 00:00:00
2458	Doraditas tia rosa	None	29	49	8.00	10.50	100	10	2024-11-07 00:00:00
2459	Sabritas receta crujiente jalapeno	None	9	3	8.00	10.50	100	10	2024-11-07 00:00:00
2460	Tortillinas tia rosa	None	10	49	8.00	10.50	100	10	2024-11-07 00:00:00
2461	Conchas tia rosa	None	29	49	8.00	10.50	100	10	2024-11-07 00:00:00
2462	Hersheys Cookies n Cream	None	8	45	8.00	10.50	100	10	2024-11-07 00:00:00
2463	Hersheys almendras	None	8	45	8.00	10.50	100	10	2024-11-07 00:00:00
2464	Hersheys chocolate amargo	None	8	45	8.00	10.50	100	10	2024-11-07 00:00:00
2465	Hersheys chocolate blanco	None	8	45	8.00	10.50	100	10	2024-11-07 00:00:00
2466	Crunch	None	8	19	8.00	10.50	100	10	2024-11-07 00:00:00
2467	Carlos V	None	8	19	8.00	10.50	100	10	2024-11-07 00:00:00
2468	Milky way	None	8	19	8.00	10.50	100	10	2024-11-07 00:00:00
2469	Snickers	None	8	19	8.00	10.50	100	10	2024-11-07 00:00:00
2470	Kit kat	None	8	19	8.00	10.50	100	10	2024-11-07 00:00:00
2471	Kinder delice	None	8	40	8.00	10.50	100	10	2024-11-07 00:00:00
2472	Kinder sorpresa	None	8	40	8.00	10.50	100	10	2024-11-07 00:00:00
2473	Ferrero rocher 3 piezas	None	8	40	8.00	10.50	100	10	2024-11-07 00:00:00
2474	Mazapan	None	8	62	8.00	10.50	100	10	2024-11-07 00:00:00
2475	Pelon pelo rico	None	8	45	8.00	10.50	100	10	2024-11-07 00:00:00
2476	Pulparindo tamarindo	None	8	62	8.00	10.50	100	10	2024-11-07 00:00:00
2477	Pulparindo chamoy	None	8	62	8.00	10.50	100	10	2024-11-07 00:00:00
2478	Tutsi pop	None	8	65	8.00	10.50	100	10	2024-11-07 00:00:00
2479	Oblea cajeta coronado	None	8	66	8.00	10.50	100	10	2024-11-07 00:00:00
2480	Paleta payaso	None	8	67	8.00	10.50	100	10	2024-11-07 00:00:00
2481	Duvalin fresa vainilla	None	8	67	8.00	10.50	100	10	2024-11-07 00:00:00
2482	Duvalin chocolate vainilla	None	8	67	8.00	10.50	100	10	2024-11-07 00:00:00
2483	Duvalin vainilla	None	8	67	8.00	10.50	100	10	2024-11-07 00:00:00
2484	Duvalin trisabor	None	8	67	8.00	10.50	100	10	2024-11-07 00:00:00
2485	Duvalin choco avellana	None	8	67	8.00	10.50	100	10	2024-11-07 00:00:00
2486	Paleta Vero mango	None	8	68	8.00	10.50	100	10	2024-11-07 00:00:00
2487	Paleta Vero elote	None	8	67	8.00	10.50	100	10	2024-11-07 00:00:00
2488	Panditas	None	8	67	8.00	10.50	100	10	2024-11-07 00:00:00
2489	Panditas rellenos	None	8	67	8.00	10.50	100	10	2024-11-07 00:00:00
2490	Panditas san valentin	None	8	67	8.00	10.50	100	10	2024-11-07 00:00:00
2491	Bubulubu	None	8	67	8.00	10.50	100	10	2024-11-07 00:00:00
2492	Rockaleta	None	8	69	8.00	10.50	100	10	2024-11-07 00:00:00
2493	Tic tac menta	None	8	40	8.00	10.50	100	10	2024-11-07 00:00:00
2494	Halls menta	None	8	58	8.00	10.50	100	10	2024-11-07 00:00:00
2495	Halls limon	None	8	58	8.00	10.50	100	10	2024-11-07 00:00:00
2496	Halls yerba buena	None	8	58	8.00	10.50	100	10	2024-11-07 00:00:00
2497	Halls miel	None	8	58	8.00	10.50	100	10	2024-11-07 00:00:00
2498	Halls negras	None	8	58	8.00	10.50	100	10	2024-11-07 00:00:00
2499	Gomilocas dientes	None	8	67	8.00	10.50	100	10	2024-11-07 00:00:00
2500	Gomilocas pinguino	None	8	67	8.00	10.50	100	10	2024-11-07 00:00:00
2501	Chocoretas	None	8	67	8.00	10.50	100	10	2024-11-07 00:00:00
2502	Kranky	None	8	67	8.00	10.50	100	10	2024-11-07 00:00:00
2503	Lucas muecas	None	8	58	8.00	10.50	100	10	2024-11-07 00:00:00
2504	Lucas chamoy	None	8	58	8.00	10.50	100	10	2024-11-07 00:00:00
2505	Lucas gusanito	None	8	58	8.00	10.50	100	10	2024-11-07 00:00:00
2506	Palomitas Act II mantequilla	None	9	58	8.00	10.50	100	10	2024-11-07 00:00:00
2507	Palomitas Act II natural	None	9	58	8.00	10.50	100	10	2024-11-07 00:00:00
2508	Palomitas Act II chile limon	None	9	58	8.00	10.50	100	10	2024-11-07 00:00:00
2509	Tostitos salsa verde	None	9	3	8.00	10.50	100	10	2024-11-07 00:00:00
2510	Zucaritas chicas	None	5	26	8.00	10.50	100	10	2024-11-07 00:00:00
2511	Zucaritas grandes	None	5	26	8.00	10.50	100	10	2024-11-07 00:00:00
2512	Corn flakes chicas	None	5	26	8.00	10.50	100	10	2024-11-07 00:00:00
2513	Corn flakes grandes	None	5	26	8.00	10.50	100	10	2024-11-07 00:00:00
2514	Choco Krispis chicas	None	5	26	8.00	10.50	100	10	2024-11-07 00:00:00
2515	Choco Krispis grandes	None	5	26	8.00	10.50	100	10	2024-11-07 00:00:00
2516	Nesquik chico	None	5	26	8.00	10.50	100	10	2024-11-07 00:00:00
2517	Nesquik grande	None	5	26	8.00	10.50	100	10	2024-11-07 00:00:00
2518	Froot loops chicas	None	5	26	8.00	10.50	100	10	2024-11-07 00:00:00
2519	Froot loops grandes	None	5	26	8.00	10.50	100	10	2024-11-07 00:00:00
2520	Chocomilk sobre	None	4	58	8.00	10.50	100	10	2024-11-07 00:00:00
2521	Chocomilk bolsa	None	4	58	8.00	10.50	100	10	2024-11-07 00:00:00
2522	Chocomilk lata	None	4	58	8.00	10.50	100	10	2024-11-07 00:00:00
2523	Nescafe clasico sobre	None	4	19	8.00	10.50	100	10	2024-11-07 00:00:00
2524	Nescafe capuccino sobre	None	4	19	8.00	10.50	100	10	2024-11-07 00:00:00
2525	Nescafe clasico bote chico	None	4	19	8.00	10.50	100	10	2024-11-07 00:00:00
2526	Nescafe clasico bote grande	None	4	19	8.00	10.50	100	10	2024-11-07 00:00:00
2527	Azucar Zulka 1kg	None	3	58	8.00	10.50	100	10	2024-11-07 00:00:00
2528	Azucar refinada 1kg	None	3	58	8.00	10.50	100	10	2024-11-07 00:00:00
2529	Azucar refinada 500gr	None	3	58	8.00	10.50	100	10	2024-11-07 00:00:00
2530	Azucar refinada 250gr	None	3	58	8.00	10.50	100	10	2024-11-07 00:00:00
2531	Aceite nutrioli 1lt	None	1	58	8.00	10.50	100	10	2024-11-07 00:00:00
2532	Aceite capullo 1lt	None	1	58	8.00	10.50	100	10	2024-11-07 00:00:00
2533	Aceite 1 2 3 1lt	None	1	58	8.00	10.50	100	10	2024-11-07 00:00:00
2534	Aceite patrona 1lt	None	1	58	8.00	10.50	100	10	2024-11-07 00:00:00
2535	Vinagre blanco la coste¤a	None	1	27	8.00	10.50	100	10	2024-11-07 00:00:00
2536	Vinagre de manzana la coste¤a	None	1	27	8.00	10.50	100	10	2024-11-07 00:00:00
2537	Catsup la coste¤a	None	1	27	8.00	10.50	100	10	2024-11-07 00:00:00
2538	Catsup Del monte	None	1	70	8.00	10.50	100	10	2024-11-07 00:00:00
2539	Catsup heinz	None	1	71	8.00	10.50	100	10	2024-11-07 00:00:00
2540	Jugo Magui	None	7	19	8.00	10.50	100	10	2024-11-07 00:00:00
2541	Salsa inglesa	None	7	19	8.00	10.50	100	10	2024-11-07 00:00:00
2542	Salsa valentina chica	None	7	58	8.00	10.50	100	10	2024-11-07 00:00:00
2543	Salsa valentina grande	None	7	58	8.00	10.50	100	10	2024-11-07 00:00:00
2544	Salsa tabasco	None	7	58	8.00	10.50	100	10	2024-11-07 00:00:00
2545	Salsa buffalo	None	7	58	8.00	10.50	100	10	2024-11-07 00:00:00
2546	Salsa chipotle la coste¤a	None	7	27	8.00	10.50	100	10	2024-11-07 00:00:00
2547	Chile chipotle la coste¤a	None	6	27	8.00	10.50	100	10	2024-11-07 00:00:00
2548	Tic tac naranja	None	8	40	8.00	10.50	100	10	2024-11-07 00:00:00
2549	Yogurt Yoplait natural 1L	Yogurt Yoplait natural 1 Litro	17	54	26.00	31.00	100	10	2024-11-07 00:00:00
2550	Cremax vainilla	None	29	46	8.00	10.50	100	10	2024-11-07 00:00:00
2551	Maxitubo Barritas fresa	None	9	22	8.00	10.50	100	10	2024-11-07 00:00:00
2552	Bigote tia rosa	None	29	49	8.00	10.50	100	10	2024-11-07 00:00:00
2553	Magdalenas tia rosa	None	29	49	8.00	10.50	100	10	2024-11-07 00:00:00
2554	Chiles serranos la coste¤a	None	6	27	8.00	10.50	100	10	2024-11-07 00:00:00
2555	Chiles en vinagre la coste¤a	None	6	27	8.00	10.50	100	10	2024-11-07 00:00:00
2556	Chile chipotle la morena	None	6	72	8.00	10.50	100	10	2024-11-07 00:00:00
2557	Chiles en vinagre la morena	None	6	72	8.00	10.50	100	10	2024-11-07 00:00:00
2558	Mayonesa mccormick chica	None	7	72	8.00	10.50	100	10	2024-11-07 00:00:00
2559	Mayonesa mccormick grande	None	7	72	8.00	10.50	100	10	2024-11-07 00:00:00
2560	Mostaza mccormick	None	7	72	8.00	10.50	100	10	2024-11-07 00:00:00
2561	Mermelada mccormick fresa chica	None	19	72	8.00	10.50	100	10	2024-11-07 00:00:00
2562	Mermelada mccormick fresa grande	None	19	72	8.00	10.50	100	10	2024-11-07 00:00:00
2563	Cloralex 1/2 lt	None	35	58	8.00	10.50	100	10	2024-11-07 00:00:00
2564	Cloralex 1 lt	None	35	58	8.00	10.50	100	10	2024-11-07 00:00:00
2565	Pinol	None	35	58	8.00	10.50	100	10	2024-11-07 00:00:00
2566	Fabuloso lavanda 1lt	None	35	58	8.00	10.50	100	10	2024-11-07 00:00:00
2567	Fabuloso aroma floral 1lt	None	35	58	8.00	10.50	100	10	2024-11-07 00:00:00
2568	Detergente Ariel 1/2 kg	None	34	58	8.00	10.50	100	10	2024-11-07 00:00:00
2569	Detergente Ariel 1kg	None	34	58	8.00	10.50	100	10	2024-11-07 00:00:00
2570	Detergente Ace 1/2 kg	None	34	58	8.00	10.50	100	10	2024-11-07 00:00:00
2571	Detergente Ace 1kg	None	34	58	8.00	10.50	100	10	2024-11-07 00:00:00
2572	Detergente Foca 1/2 kg	None	34	58	8.00	10.50	100	10	2024-11-07 00:00:00
2573	Detergente Foca 1kg	None	34	58	8.00	10.50	100	10	2024-11-07 00:00:00
2574	Suavitel 1l	None	34	58	8.00	10.50	100	10	2024-11-07 00:00:00
2575	Papel higienico Petalo 4 rollos	None	37	58	8.00	10.50	100	10	2024-11-07 00:00:00
2576	Papel higienico Petalo 6 rollos	None	37	58	8.00	10.50	100	10	2024-11-07 00:00:00
2577	Papel higienico Suavel 4 rollos	None	37	58	8.00	10.50	100	10	2024-11-07 00:00:00
2578	Papel higienico Suavel 6 rollos	None	37	58	8.00	10.50	100	10	2024-11-07 00:00:00
2579	Toallas sanitarias Always	None	37	58	8.00	10.50	100	10	2024-11-07 00:00:00
2580	Toallas sanitarias Kotex	None	37	58	8.00	10.50	100	10	2024-11-07 00:00:00
2581	Panales Huggies	None	44	58	8.00	10.50	100	10	2024-11-07 00:00:00
2582	Shampoo Head & Shoulders chico	None	39	58	8.00	10.50	100	10	2024-11-07 00:00:00
2583	Shampoo Head & Shoulders grande	None	39	58	8.00	10.50	100	10	2024-11-07 00:00:00
2584	Desodorante Axe	None	41	58	8.00	10.50	100	10	2024-11-07 00:00:00
2585	Leche deslactosada 1lt	Presentacion azul	15	4	18.20	23.00	14	2	2024-11-07 00:00:00
2586	Yomi lala chocolate	None	15	4	15.00	30.00	100	10	2024-11-07 00:00:00
2587	Yomi lala vainilla	None	15	4	15.00	30.00	100	10	2024-11-07 00:00:00
2588	Yomi lala fresa	None	15	4	15.00	30.00	100	10	2024-11-07 00:00:00
2589	Yogurt lala fresa	None	15	4	15.00	30.00	100	10	2024-11-07 00:00:00
2590	Yogurt lala durazno	None	15	4	15.00	30.00	100	10	2024-11-07 00:00:00
2591	Yogurt lala manzana	None	15	4	15.00	30.00	100	10	2024-11-07 00:00:00
2592	Yogurt bebible lala manzana	None	15	4	15.00	30.00	100	10	2024-11-07 00:00:00
2593	Yogurt bebible lala durazno	None	15	4	15.00	30.00	100	10	2024-11-07 00:00:00
2594	Yogurt bebible lala fresa	None	15	4	15.00	30.00	100	10	2024-11-07 00:00:00
2595	Yogurt bebible lala moras	None	15	4	15.00	30.00	100	10	2024-11-07 00:00:00
2596	Yogurt bebible lala pina coco	None	15	4	15.00	30.00	100	10	2024-11-07 00:00:00
2597	Licuado lala fresa platano	None	15	4	15.00	30.00	100	10	2024-11-07 00:00:00
2598	Licuado lala nuez	None	15	4	15.00	30.00	100	10	2024-11-07 00:00:00
2599	Flan lala	None	15	4	15.00	30.00	100	10	2024-11-07 00:00:00
2600	Margarina lala 90gr	None	15	4	15.00	30.00	100	10	2024-11-07 00:00:00
2601	Jabon zote rosa chico	None	42	58	8.00	10.50	100	10	2024-11-07 00:00:00
2602	Jabon zote rosa grande	None	42	58	8.00	10.50	100	10	2024-11-07 00:00:00
2603	Jabon zote blanco chico	None	42	58	8.00	10.50	100	10	2024-11-07 00:00:00
2604	Jabon zote blanco grande	None	42	58	8.00	10.50	100	10	2024-11-07 00:00:00
2605	Roles	Ricos roles de canela caseros	27	13	70.00	100.00	19	10	2024-12-08 00:00:00
2606	Pepsi	bebida azucarada	31	14	8.00	16.00	77	20	2024-12-08 00:00:00
2607	Manzanita		31	14	17.00	25.00	22	3	2024-12-08 00:00:00
2608	MaruchanTokyo	maruchan picante	2	11	5.50	12.50	15	10	2024-12-08 00:00:00
2609	Harina de maiz maseca	None	10	59	8.00	10.50	100	10	2024-12-08 00:00:00
2610	Sabritas	Sabritas Flamin Hot	9	3	10.00	18.00	4	1	2024-12-08 00:00:00
2611	Galletas marias	Las galletas clasicas	9	3	8.90	15.00	19	2	2024-12-08 00:00:00
2612	Leche entera lala 1lt	Clasica color roja	15	4	15.24	25.00	11	3	2024-12-08 00:00:00
2613	Leche Lala entera 1L	Leche Lala entera 1 Litro	15	4	19.00	24.00	100	10	2024-12-08 00:00:00
2614	Tostadas charras	None	5	60	8.00	10.50	100	10	2024-12-08 00:00:00
2615	Leche Lala light 1L	Leche Lala light 1 Litro	15	4	20.00	25.00	100	10	2024-12-08 00:00:00
2616	Leche Santa Clara entera 1L	Leche Santa Clara entera 1 Litro	15	4	22.00	28.00	100	10	2024-12-08 00:00:00
2617	Leche Santa Clara deslactosada 1L	Leche Santa Clara deslactosada 1 Litro	15	4	23.00	29.00	100	10	2024-12-08 00:00:00
2618	Arroz Mexica 1kg	None	2	59	12.00	16.50	100	10	2024-12-08 00:00:00
2619	Del Valle fruit naranja 600ml	Jugo Del Valle sabor Naranja 600 ml	31	28	10.50	13.50	100	10	2024-12-08 00:00:00
2620	Harina de trigo San antonio	None	10	41	8.00	10.50	100	10	2024-12-08 00:00:00
2621	Tortillas de maiz 1/2 kg	None	10	58	8.00	10.50	100	10	2024-12-08 00:00:00
2622	Pan bimbo blanco chico	None	27	17	8.00	10.50	100	10	2024-12-08 00:00:00
2623	Pan bimbo blanco grande	None	27	17	8.00	10.50	100	10	2024-12-08 00:00:00
2624	Pan bimbo integral chico	None	27	17	8.00	10.50	100	10	2024-12-08 00:00:00
2625	Pan bimbo integral grande	None	27	17	8.00	10.50	100	10	2024-12-08 00:00:00
2626	Rebanadas bimbo	None	27	17	8.00	10.50	100	10	2024-12-08 00:00:00
2627	Chocoroles	None	27	17	8.00	10.50	100	10	2024-12-08 00:00:00
2628	Nito bimbo	None	27	17	8.00	10.50	100	10	2024-12-08 00:00:00
2629	Mantecadas	None	27	17	8.00	10.50	100	10	2024-12-08 00:00:00
2630	Roles de canela con pasas	None	27	17	8.00	10.50	100	10	2024-12-08 00:00:00
2631	Roles de canela glaseados	None	27	17	8.00	10.50	100	10	2024-12-08 00:00:00
2632	Conchas bimbo	None	27	17	8.00	10.50	100	10	2024-12-08 00:00:00
2633	Panque de nuez bimbo	None	27	17	8.00	10.50	100	10	2024-12-08 00:00:00
2634	Donitas bimbo	None	27	17	8.00	10.50	100	10	2024-12-08 00:00:00
2635	Donitas espolvoreadas bimbo	None	27	17	8.00	10.50	100	10	2024-12-08 00:00:00
2636	chimichangas	chimichangas	23	10	30.00	45.00	15	5	2024-12-08 00:00:00
2637	Coca Cola 1L	Refresco Coca Cola 1 Litro	31	16	12.00	15.00	100	10	2024-12-08 00:00:00
2638	Coca Cola lata 355ml	Refresco Coca Cola 355 ml lata	31	16	8.50	11.00	100	10	2024-12-08 00:00:00
2639	Coca Cola 355ml	Refresco Coca Cola 355 ml	31	16	8.00	10.50	100	10	2024-12-08 00:00:00
2640	Coca Cola 600ml	Refresco Coca Cola 600 ml	31	16	9.00	12.00	100	10	2024-12-08 00:00:00
2641	Coca Cola retornable 1 1/4 lt.	Refresco Coca Cola retornable 1 1/4 lt	31	16	12.50	15.50	100	10	2024-12-08 00:00:00
2642	Coca Cola 2L retornable	Refresco Coca Cola retornable 2 Litros	31	16	19.50	24.00	100	10	2024-12-08 00:00:00
2643	Coca Cola 3L retornable	Refresco Coca Cola retornable 3 Litros	31	16	24.00	30.00	100	10	2024-12-08 00:00:00
2644	Coca Cola Light 600ml	Refresco Coca Cola Light 600 ml	31	16	9.50	12.50	100	10	2024-12-08 00:00:00
2645	Pepsi 600ml	Refresco Pepsi 600 ml	31	14	9.00	12.00	100	10	2024-12-08 00:00:00
2646	Pepsi 1.5L	Refresco Pepsi 1.5 Litros	31	14	12.00	15.50	100	10	2024-12-08 00:00:00
2647	Fanta 600ml	Refresco Fanta 600 ml	31	16	9.00	12.00	100	10	2024-12-08 00:00:00
2648	Fanta 1.5L	Refresco Fanta 1.5 Litros	31	16	12.50	16.00	100	10	2024-12-08 00:00:00
2649	Sprite 600ml	Refresco Sprite 600 ml	31	16	9.00	12.00	100	10	2024-12-08 00:00:00
2650	Sprite 1.5L	Refresco Sprite 1.5 Litros	31	16	12.50	16.00	100	10	2024-12-08 00:00:00
2651	Manzanita 600ml	Refresco Manzanita Sol 600 ml	31	16	9.00	12.00	100	10	2024-12-08 00:00:00
2652	Manzanita 1.5L	Refresco Manzanita Sol 1.5 Litros	31	16	12.50	16.00	100	10	2024-12-08 00:00:00
2653	Fresca 600ml	Refresco Fresca 600 ml	31	16	9.00	12.00	100	10	2024-12-08 00:00:00
2654	Fresca 3L	Refresco Fresca 3 Litros	31	16	24.00	30.00	100	10	2024-12-08 00:00:00
2655	Mirinda 600ml	Refresco Mirinda 600 ml	31	16	9.00	12.00	100	10	2024-12-08 00:00:00
2656	Mirinda 1.5L	Refresco Mirinda 1.5 Litros	31	16	12.50	16.00	100	10	2024-12-08 00:00:00
2657	Tostadas Sanissimo	None	5	61	8.00	10.50	100	10	2024-12-08 00:00:00
2658	Marias gamesa	None	29	46	8.00	10.50	100	10	2024-12-08 00:00:00
2659	Jumex de mango 1L	Jugo Jumex sabor Mango 1 Litro	31	21	16.00	20.00	100	10	2024-12-08 00:00:00
2660	Emperador chocolate	None	29	46	8.00	10.50	100	10	2024-12-08 00:00:00
2661	Emperador nuez	None	29	46	8.00	10.50	100	10	2024-12-08 00:00:00
2662	Emperador vainilla	None	29	46	8.00	10.50	100	10	2024-12-08 00:00:00
2663	Emperador limon	None	29	46	8.00	10.50	100	10	2024-12-08 00:00:00
2664	Jumex de durazno 1L	Jugo Jumex sabor Durazno 1 Litro	31	21	16.00	20.00	100	10	2024-12-08 00:00:00
2665	Jumex de manzana 600ml	Jugo Jumex sabor Manzana 600 ml	31	21	10.00	13.00	100	10	2024-12-08 00:00:00
2666	Del Valle fruit manzana 600ml	Jugo Del Valle sabor Manzana 600 ml	31	28	10.50	13.50	100	10	2024-12-08 00:00:00
2667	Del Valle fruit guayaba 600ml	Jugo Del Valle sabor Guayaba 600 ml	31	28	10.50	13.50	100	10	2024-12-08 00:00:00
2668	Emperador Senso	None	29	46	8.00	10.50	100	10	2024-12-08 00:00:00
2669	Mamut chico	None	29	46	8.00	10.50	100	10	2024-12-08 00:00:00
2670	Yogurt Lala natural 1L	Yogurt Lala natural 1 Litro	17	4	25.00	30.00	100	10	2024-12-08 00:00:00
2671	Yogurt Lala de fresa 1L	Yogurt Lala sabor Fresa 1 Litro	17	4	25.00	30.00	100	10	2024-12-08 00:00:00
2672	Yogurt Yoplait de fresa 1L	Yogurt Yoplait sabor Fresa 1 Litro	17	54	26.00	31.00	100	10	2024-12-08 00:00:00
2673	Mantequilla Lala 250g	Mantequilla Lala 250 gramos	19	4	30.00	38.00	100	10	2024-12-08 00:00:00
2674	Queso panela Lala 200g	Queso panela Lala 200 gramos	16	4	40.00	50.00	100	10	2024-12-08 00:00:00
2675	Mamut grande	None	29	46	8.00	10.50	100	10	2024-12-08 00:00:00
2676	Chokis	None	29	46	8.00	10.50	100	10	2024-12-08 00:00:00
2677	Chokis rellenas	None	29	46	8.00	10.50	100	10	2024-12-08 00:00:00
2678	Chokis doble chocolate	None	29	46	8.00	10.50	100	10	2024-12-08 00:00:00
2679	Chokis brownie	None	29	46	8.00	10.50	100	10	2024-12-08 00:00:00
2680	Leche Lala deslactosada 1L	Leche Lala deslactosada 1 Litro	15	4	20.00	25.00	100	10	2024-12-08 00:00:00
2681	Queso panela Alpura 200g	Queso panela Alpura 200 gramos	16	18	40.00	50.00	100	10	2024-12-08 00:00:00
2682	Queso oaxaca Lala 200g	Queso Oaxaca Lala 200 gramos	16	4	45.00	55.00	100	10	2024-12-08 00:00:00
2683	Queso manchego Lala 200g	Queso Manchego Lala 200 gramos	16	4	50.00	60.00	100	10	2024-12-08 00:00:00
2684	Salchichas Fud paquete 500g	Salchichas Fud 500 gramos	18	53	30.00	40.00	100	10	2024-12-08 00:00:00
2685	Salchichas San Rafael paquete 500g	Salchichas San Rafael 500 gramos	18	52	35.00	45.00	100	10	2024-12-08 00:00:00
2686	Sidral mundet 600ml	Refresco de manzana de 600ml	31	16	10.00	16.00	20	5	2024-12-08 00:00:00
2687	Sidral mundet 3lt	Refresco de manzana de 3lt	31	16	24.00	30.00	20	5	2024-12-08 00:00:00
2688	Agua bonafont 600ml	None	30	55	8.00	10.50	100	10	2024-12-08 00:00:00
2689	Agua bonafont 1lt	None	30	55	12.00	15.00	100	10	2024-12-08 00:00:00
2690	Agua bonafont 2lt.	None	30	55	14.00	18.00	100	10	2024-12-08 00:00:00
2691	Garrafon bonafont 20lt	None	30	55	19.50	24.00	100	10	2024-12-08 00:00:00
2692	Agua ciel 600ml	None	30	16	8.00	13.00	100	10	2024-12-08 00:00:00
2693	Agua ciel 1lt	None	30	16	10.00	15.00	100	10	2024-12-08 00:00:00
2694	Agua ciel 1.5l	None	30	16	12.00	17.00	100	10	2024-12-08 00:00:00
2695	Agua ciel 2lt	None	30	16	14.00	20.00	100	10	2024-12-08 00:00:00
2696	Agua E-pura 600ml	None	30	14	8.00	13.00	100	10	2024-12-08 00:00:00
2697	Agua E-pura 1lt	None	30	14	10.00	15.00	100	10	2024-12-08 00:00:00
2698	Garrafon E-pura 10lt	None	30	14	18.00	25.00	100	10	2024-12-08 00:00:00
2699	Crema Lala 200ml	None	15	4	8.00	13.00	100	10	2024-12-08 00:00:00
2700	Crema Lala 426ml	None	15	4	15.00	30.00	100	10	2024-12-08 00:00:00
2701	Crema Lala 900ml	None	15	4	35.00	55.00	100	10	2024-12-08 00:00:00
2702	Crema alpura 200ml	None	15	4	8.00	13.00	100	10	2024-12-08 00:00:00
2703	Crema alpura 426ml	None	15	4	15.00	30.00	100	10	2024-12-08 00:00:00
2704	Crema alpura 900ml	None	15	4	35.00	55.00	100	10	2024-12-08 00:00:00
2705	Atun dolores en agua	None	6	51	10.00	15.00	100	10	2024-12-08 00:00:00
2706	Atun dolores en aceite	None	6	51	12.00	17.00	100	10	2024-12-08 00:00:00
2707	Sardinas en aceite	None	6	20	10.00	15.00	100	10	2024-12-08 00:00:00
2708	Frijoles refritos	None	6	50	10.00	15.00	100	10	2024-12-08 00:00:00
2709	Frijoles bayos	None	6	50	10.00	15.00	100	10	2024-12-08 00:00:00
2710	Pasta la moderna	None	2	44	10.00	15.00	100	10	2024-12-08 00:00:00
2711	Coditos la moderna	None	2	44	10.00	15.00	100	10	2024-12-08 00:00:00
2712	Pasta Barilla espagueti	None	2	56	10.00	15.00	100	10	2024-12-08 00:00:00
2713	Sopa de letras la moderna	None	2	44	10.00	15.00	100	10	2024-12-08 00:00:00
2714	Sopa maruchan pollo	None	2	57	10.00	15.00	100	10	2024-12-08 00:00:00
2715	Sopa maruchan camaron	None	2	57	10.00	15.00	100	10	2024-12-08 00:00:00
2716	Sopa maruchan res	None	2	57	10.00	15.00	100	10	2024-12-08 00:00:00
2717	Sopa maruchan habanero	None	2	57	10.00	15.00	100	10	2024-12-08 00:00:00
2718	Sopa maruchan piquin	None	2	57	10.00	15.00	100	10	2024-12-08 00:00:00
2719	Sopa maruchan limon	None	2	57	10.00	15.00	100	10	2024-12-08 00:00:00
2720	Lentejas la moderna	None	2	44	10.00	15.00	100	10	2024-12-08 00:00:00
2721	Jamon de pavo Fud 250g	Jamon de Pavo Fud 250 gramos	18	53	35.00	45.00	100	10	2024-12-08 00:00:00
2722	Jamon de pavo San Rafael 250g	Jamon de Pavo San Rafael 250 gramos	18	52	40.00	50.00	100	10	2024-12-08 00:00:00
2723	Cremax chocolate	None	29	46	8.00	10.50	100	10	2024-12-08 00:00:00
2724	Cremax fresa	None	29	46	8.00	10.50	100	10	2024-12-08 00:00:00
2725	Florentinas gamesa	None	29	46	8.00	10.50	100	10	2024-12-08 00:00:00
2726	Marias doradas	None	29	46	8.00	10.50	100	10	2024-12-08 00:00:00
2727	Gamesa cajeta	None	29	46	8.00	10.50	100	10	2024-12-08 00:00:00
2728	Maravillas gamesa	None	29	46	8.00	10.50	100	10	2024-12-08 00:00:00
2729	Crackets gamesa	None	29	46	8.00	10.50	100	10	2024-12-08 00:00:00
2730	Surtido rico gamesa	None	29	46	8.00	10.50	100	10	2024-12-08 00:00:00
2731	Delicias gamesa	None	29	46	8.00	10.50	100	10	2024-12-08 00:00:00
2732	Oreo	None	9	58	8.00	10.50	100	10	2024-12-08 00:00:00
2733	Principe chocolate	None	9	22	8.00	10.50	100	10	2024-12-08 00:00:00
2734	Principe vainilla	None	9	22	8.00	10.50	100	10	2024-12-08 00:00:00
2735	Principe limon	None	9	22	8.00	10.50	100	10	2024-12-08 00:00:00
2736	Principe chocolate blanco	None	9	22	8.00	10.50	100	10	2024-12-08 00:00:00
2737	Lors	None	9	22	8.00	10.50	100	10	2024-12-08 00:00:00
2738	Plativolos	None	9	22	8.00	10.50	100	10	2024-12-08 00:00:00
2739	Sponch	None	9	22	8.00	10.50	100	10	2024-12-08 00:00:00
2740	Triki trakes	None	9	22	8.00	10.50	100	10	2024-12-08 00:00:00
2741	MaxiTubo Triki trakes	None	9	22	8.00	10.50	100	10	2024-12-08 00:00:00
2742	Gansito	None	9	22	8.00	10.50	100	10	2024-12-08 00:00:00
2743	Pinguinos	None	9	22	8.00	10.50	100	10	2024-12-08 00:00:00
2744	Pasticetas marinela	None	9	22	8.00	10.50	100	10	2024-12-08 00:00:00
2745	Barritas fresa	None	9	22	8.00	10.50	100	10	2024-12-08 00:00:00
2746	Barritas pina	None	9	22	8.00	10.50	100	10	2024-12-08 00:00:00
2747	Barritas moras	None	9	22	8.00	10.50	100	10	2024-12-08 00:00:00
2748	Maxitubo Barritas pina	None	9	22	8.00	10.50	100	10	2024-12-08 00:00:00
2749	Canelitas	None	9	22	8.00	10.50	100	10	2024-12-08 00:00:00
2750	Polvorones	None	9	22	8.00	10.50	100	10	2024-12-08 00:00:00
2751	Maxitubo Polvorones	None	9	22	8.00	10.50	100	10	2024-12-08 00:00:00
2752	Ricanelas	None	9	46	8.00	10.50	100	10	2024-12-08 00:00:00
2753	Ritz bits queso	None	9	58	8.00	10.50	100	10	2024-12-08 00:00:00
2754	Arcoiris	None	9	46	8.00	10.50	100	10	2024-12-08 00:00:00
2755	Submarinos fresa	None	9	22	8.00	10.50	100	10	2024-12-08 00:00:00
2756	Submarinos vainilla	None	9	22	8.00	10.50	100	10	2024-12-08 00:00:00
2757	Submarinos chocolate	None	9	22	8.00	10.50	100	10	2024-12-08 00:00:00
2758	Rocko chico	None	9	22	8.00	10.50	100	10	2024-12-08 00:00:00
2759	Rocko grande	None	9	22	8.00	10.50	100	10	2024-12-08 00:00:00
2760	Sabritas original	None	9	3	8.00	10.50	100	10	2024-12-08 00:00:00
2761	Sabritas adobadas	None	9	3	8.00	10.50	100	10	2024-12-08 00:00:00
2762	Sabritas limon	None	9	3	8.00	10.50	100	10	2024-12-08 00:00:00
2763	Sabritas flamin hot	None	9	3	8.00	10.50	100	10	2024-12-08 00:00:00
2764	Sabritas crema y especias	None	9	3	8.00	10.50	100	10	2024-12-08 00:00:00
2765	Sabritas habanero	None	9	3	8.00	10.50	100	10	2024-12-08 00:00:00
2766	Sabritas receta crujiente	None	9	3	8.00	10.50	100	10	2024-12-08 00:00:00
2767	Chips jalapeno	None	9	47	8.00	10.50	100	10	2024-12-08 00:00:00
2768	Crujitos	None	9	3	8.00	10.50	100	10	2024-12-08 00:00:00
2769	Doritos nacho	None	9	3	8.00	10.50	100	10	2024-12-08 00:00:00
2770	Doritos incognita	None	9	3	8.00	10.50	100	10	2024-12-08 00:00:00
2771	Doritos diablo	None	9	3	8.00	10.50	100	10	2024-12-08 00:00:00
2772	Doritos flamin hot	None	9	3	8.00	10.50	100	10	2024-12-08 00:00:00
2773	Doritos dinamita	None	9	3	8.00	10.50	100	10	2024-12-08 00:00:00
2774	Sabritones	None	9	3	8.00	10.50	100	10	2024-12-08 00:00:00
2775	Bigmix queso	None	9	47	8.00	10.50	100	10	2024-12-08 00:00:00
2776	Bigmix fuego	None	9	47	8.00	10.50	100	10	2024-12-08 00:00:00
2777	Cheetos torciditos	None	9	3	8.00	10.50	100	10	2024-12-08 00:00:00
2778	Cheetos bolitas	None	9	3	8.00	10.50	100	10	2024-12-08 00:00:00
2779	Cheetos queso	None	9	3	8.00	10.50	100	10	2024-12-08 00:00:00
2780	Cheetos flamin hot	None	9	3	8.00	10.50	100	10	2024-12-08 00:00:00
2781	Ruffles original	None	9	3	8.00	10.50	100	10	2024-12-08 00:00:00
2782	Ruffles queso	None	9	3	8.00	10.50	100	10	2024-12-08 00:00:00
2783	Fritos sal y limon	None	9	3	8.00	10.50	100	10	2024-12-08 00:00:00
2784	Fritos chorizo	None	9	3	8.00	10.50	100	10	2024-12-08 00:00:00
2785	Bolsaza Sabritas original	None	9	3	8.00	10.50	100	10	2024-12-08 00:00:00
2786	Bolsaza Doritos nacho	None	9	3	8.00	10.50	100	10	2024-12-08 00:00:00
2787	Paketaxo	None	9	3	8.00	10.50	100	10	2024-12-08 00:00:00
2788	Paketaxo queso	None	9	3	8.00	10.50	100	10	2024-12-08 00:00:00
2789	Paketaxo flamin hot	None	9	3	8.00	10.50	100	10	2024-12-08 00:00:00
2790	Churrumaiz	None	9	3	8.00	10.50	100	10	2024-12-08 00:00:00
2791	Churrumaiz flamin hot	None	9	3	8.00	10.50	100	10	2024-12-08 00:00:00
2792	Rancheritos	None	9	3	8.00	10.50	100	10	2024-12-08 00:00:00
2793	Sabritas switch doritos nacho	None	9	3	8.00	10.50	100	10	2024-12-08 00:00:00
2794	Runners	None	9	47	8.00	10.50	100	10	2024-12-08 00:00:00
2795	Chips sal	None	9	47	8.00	10.50	100	10	2024-12-08 00:00:00
2796	Papatinas	None	9	47	8.00	10.50	100	10	2024-12-08 00:00:00
2797	Chips fuego	None	9	47	8.00	10.50	100	10	2024-12-08 00:00:00
2798	Palomitas pop	None	9	47	8.00	10.50	100	10	2024-12-08 00:00:00
2799	Takis original 	None	9	47	8.00	10.50	100	10	2024-12-08 00:00:00
2800	Takis fuego	None	9	47	8.00	10.50	100	10	2024-12-08 00:00:00
2801	Takis salsa brava	None	9	47	8.00	10.50	100	10	2024-12-08 00:00:00
2802	Takis guacamole	None	9	47	8.00	10.50	100	10	2024-12-08 00:00:00
2803	Chipotles	None	9	47	8.00	10.50	100	10	2024-12-08 00:00:00
2804	Tostachos	None	9	47	8.00	10.50	100	10	2024-12-08 00:00:00
2805	Hot nuts	None	9	47	8.00	10.50	100	10	2024-12-08 00:00:00
2806	Hot nuts fuego	None	9	47	8.00	10.50	100	10	2024-12-08 00:00:00
2807	Valentones	None	9	47	8.00	10.50	100	10	2024-12-08 00:00:00
2808	Watz barcel	None	9	47	8.00	10.50	100	10	2024-12-08 00:00:00
2809	Toreadas	None	9	47	8.00	10.50	100	10	2024-12-08 00:00:00
2810	Palomitas pop fuego	None	9	47	8.00	10.50	100	10	2024-12-08 00:00:00
2811	Takis blue heat	None	9	47	8.00	10.50	100	10	2024-12-08 00:00:00
2812	Doraditas tia rosa	None	29	49	8.00	10.50	100	10	2024-12-08 00:00:00
2813	Sabritas receta crujiente jalapeno	None	9	3	8.00	10.50	100	10	2024-12-08 00:00:00
2814	Tortillinas tia rosa	None	10	49	8.00	10.50	100	10	2024-12-08 00:00:00
2815	Conchas tia rosa	None	29	49	8.00	10.50	100	10	2024-12-08 00:00:00
2816	Hersheys Cookies n Cream	None	8	45	8.00	10.50	100	10	2024-12-08 00:00:00
2817	Hersheys almendras	None	8	45	8.00	10.50	100	10	2024-12-08 00:00:00
2818	Hersheys chocolate amargo	None	8	45	8.00	10.50	100	10	2024-12-08 00:00:00
2819	Hersheys chocolate blanco	None	8	45	8.00	10.50	100	10	2024-12-08 00:00:00
2820	Crunch	None	8	19	8.00	10.50	100	10	2024-12-08 00:00:00
2821	Carlos V	None	8	19	8.00	10.50	100	10	2024-12-08 00:00:00
2822	Milky way	None	8	19	8.00	10.50	100	10	2024-12-08 00:00:00
2823	Snickers	None	8	19	8.00	10.50	100	10	2024-12-08 00:00:00
2824	Kit kat	None	8	19	8.00	10.50	100	10	2024-12-08 00:00:00
2825	Kinder delice	None	8	40	8.00	10.50	100	10	2024-12-08 00:00:00
2826	Kinder sorpresa	None	8	40	8.00	10.50	100	10	2024-12-08 00:00:00
2827	Ferrero rocher 3 piezas	None	8	40	8.00	10.50	100	10	2024-12-08 00:00:00
2828	Mazapan	None	8	62	8.00	10.50	100	10	2024-12-08 00:00:00
2829	Pelon pelo rico	None	8	45	8.00	10.50	100	10	2024-12-08 00:00:00
2830	Pulparindo tamarindo	None	8	62	8.00	10.50	100	10	2024-12-08 00:00:00
2831	Pulparindo chamoy	None	8	62	8.00	10.50	100	10	2024-12-08 00:00:00
2832	Tutsi pop	None	8	65	8.00	10.50	100	10	2024-12-08 00:00:00
2833	Oblea cajeta coronado	None	8	66	8.00	10.50	100	10	2024-12-08 00:00:00
2834	Paleta payaso	None	8	67	8.00	10.50	100	10	2024-12-08 00:00:00
2835	Duvalin fresa vainilla	None	8	67	8.00	10.50	100	10	2024-12-08 00:00:00
2836	Duvalin chocolate vainilla	None	8	67	8.00	10.50	100	10	2024-12-08 00:00:00
2837	Duvalin vainilla	None	8	67	8.00	10.50	100	10	2024-12-08 00:00:00
2838	Duvalin trisabor	None	8	67	8.00	10.50	100	10	2024-12-08 00:00:00
2839	Duvalin choco avellana	None	8	67	8.00	10.50	100	10	2024-12-08 00:00:00
2840	Paleta Vero mango	None	8	68	8.00	10.50	100	10	2024-12-08 00:00:00
2841	Paleta Vero elote	None	8	67	8.00	10.50	100	10	2024-12-08 00:00:00
2842	Panditas	None	8	67	8.00	10.50	100	10	2024-12-08 00:00:00
2843	Panditas rellenos	None	8	67	8.00	10.50	100	10	2024-12-08 00:00:00
2844	Panditas san valentin	None	8	67	8.00	10.50	100	10	2024-12-08 00:00:00
2845	Bubulubu	None	8	67	8.00	10.50	100	10	2024-12-08 00:00:00
2846	Rockaleta	None	8	69	8.00	10.50	100	10	2024-12-08 00:00:00
2847	Tic tac menta	None	8	40	8.00	10.50	100	10	2024-12-08 00:00:00
2848	Halls menta	None	8	58	8.00	10.50	100	10	2024-12-08 00:00:00
2849	Halls limon	None	8	58	8.00	10.50	100	10	2024-12-08 00:00:00
2850	Halls yerba buena	None	8	58	8.00	10.50	100	10	2024-12-08 00:00:00
2851	Halls miel	None	8	58	8.00	10.50	100	10	2024-12-08 00:00:00
2852	Halls negras	None	8	58	8.00	10.50	100	10	2024-12-08 00:00:00
2853	Gomilocas dientes	None	8	67	8.00	10.50	100	10	2024-12-08 00:00:00
2854	Gomilocas pinguino	None	8	67	8.00	10.50	100	10	2024-12-08 00:00:00
2855	Chocoretas	None	8	67	8.00	10.50	100	10	2024-12-08 00:00:00
2856	Kranky	None	8	67	8.00	10.50	100	10	2024-12-08 00:00:00
2857	Lucas muecas	None	8	58	8.00	10.50	100	10	2024-12-08 00:00:00
2858	Lucas chamoy	None	8	58	8.00	10.50	100	10	2024-12-08 00:00:00
2859	Lucas gusanito	None	8	58	8.00	10.50	100	10	2024-12-08 00:00:00
2860	Palomitas Act II mantequilla	None	9	58	8.00	10.50	100	10	2024-12-08 00:00:00
2861	Palomitas Act II natural	None	9	58	8.00	10.50	100	10	2024-12-08 00:00:00
2862	Palomitas Act II chile limon	None	9	58	8.00	10.50	100	10	2024-12-08 00:00:00
2863	Tostitos salsa verde	None	9	3	8.00	10.50	100	10	2024-12-08 00:00:00
2864	Zucaritas chicas	None	5	26	8.00	10.50	100	10	2024-12-08 00:00:00
2865	Zucaritas grandes	None	5	26	8.00	10.50	100	10	2024-12-08 00:00:00
2866	Corn flakes chicas	None	5	26	8.00	10.50	100	10	2024-12-08 00:00:00
2867	Corn flakes grandes	None	5	26	8.00	10.50	100	10	2024-12-08 00:00:00
2868	Choco Krispis chicas	None	5	26	8.00	10.50	100	10	2024-12-08 00:00:00
2869	Choco Krispis grandes	None	5	26	8.00	10.50	100	10	2024-12-08 00:00:00
2870	Nesquik chico	None	5	26	8.00	10.50	100	10	2024-12-08 00:00:00
2871	Nesquik grande	None	5	26	8.00	10.50	100	10	2024-12-08 00:00:00
2872	Froot loops chicas	None	5	26	8.00	10.50	100	10	2024-12-08 00:00:00
2873	Froot loops grandes	None	5	26	8.00	10.50	100	10	2024-12-08 00:00:00
2874	Chocomilk sobre	None	4	58	8.00	10.50	100	10	2024-12-08 00:00:00
2875	Chocomilk bolsa	None	4	58	8.00	10.50	100	10	2024-12-08 00:00:00
2876	Chocomilk lata	None	4	58	8.00	10.50	100	10	2024-12-08 00:00:00
2877	Nescafe clasico sobre	None	4	19	8.00	10.50	100	10	2024-12-08 00:00:00
2878	Nescafe capuccino sobre	None	4	19	8.00	10.50	100	10	2024-12-08 00:00:00
2879	Nescafe clasico bote chico	None	4	19	8.00	10.50	100	10	2024-12-08 00:00:00
2880	Nescafe clasico bote grande	None	4	19	8.00	10.50	100	10	2024-12-08 00:00:00
2881	Azucar Zulka 1kg	None	3	58	8.00	10.50	100	10	2024-12-08 00:00:00
2882	Azucar refinada 1kg	None	3	58	8.00	10.50	100	10	2024-12-08 00:00:00
2883	Azucar refinada 500gr	None	3	58	8.00	10.50	100	10	2024-12-08 00:00:00
2884	Azucar refinada 250gr	None	3	58	8.00	10.50	100	10	2024-12-08 00:00:00
2885	Aceite nutrioli 1lt	None	1	58	8.00	10.50	100	10	2024-12-08 00:00:00
2886	Aceite capullo 1lt	None	1	58	8.00	10.50	100	10	2024-12-08 00:00:00
2887	Aceite 1 2 3 1lt	None	1	58	8.00	10.50	100	10	2024-12-08 00:00:00
2888	Aceite patrona 1lt	None	1	58	8.00	10.50	100	10	2024-12-08 00:00:00
2889	Vinagre blanco la coste¤a	None	1	27	8.00	10.50	100	10	2024-12-08 00:00:00
2890	Vinagre de manzana la coste¤a	None	1	27	8.00	10.50	100	10	2024-12-08 00:00:00
2891	Catsup la coste¤a	None	1	27	8.00	10.50	100	10	2024-12-08 00:00:00
2892	Catsup Del monte	None	1	70	8.00	10.50	100	10	2024-12-08 00:00:00
2893	Catsup heinz	None	1	71	8.00	10.50	100	10	2024-12-08 00:00:00
2894	Jugo Magui	None	7	19	8.00	10.50	100	10	2024-12-08 00:00:00
2895	Salsa inglesa	None	7	19	8.00	10.50	100	10	2024-12-08 00:00:00
2896	Salsa valentina chica	None	7	58	8.00	10.50	100	10	2024-12-08 00:00:00
2897	Salsa valentina grande	None	7	58	8.00	10.50	100	10	2024-12-08 00:00:00
2898	Salsa tabasco	None	7	58	8.00	10.50	100	10	2024-12-08 00:00:00
2899	Salsa buffalo	None	7	58	8.00	10.50	100	10	2024-12-08 00:00:00
2900	Salsa chipotle la coste¤a	None	7	27	8.00	10.50	100	10	2024-12-08 00:00:00
2901	Chile chipotle la coste¤a	None	6	27	8.00	10.50	100	10	2024-12-08 00:00:00
2902	Tic tac naranja	None	8	40	8.00	10.50	100	10	2024-12-08 00:00:00
2903	Yogurt Yoplait natural 1L	Yogurt Yoplait natural 1 Litro	17	54	26.00	31.00	100	10	2024-12-08 00:00:00
2904	Cremax vainilla	None	29	46	8.00	10.50	100	10	2024-12-08 00:00:00
2905	Maxitubo Barritas fresa	None	9	22	8.00	10.50	100	10	2024-12-08 00:00:00
2906	Bigote tia rosa	None	29	49	8.00	10.50	100	10	2024-12-08 00:00:00
2907	Magdalenas tia rosa	None	29	49	8.00	10.50	100	10	2024-12-08 00:00:00
2908	Chiles serranos la coste¤a	None	6	27	8.00	10.50	100	10	2024-12-08 00:00:00
2909	Chiles en vinagre la coste¤a	None	6	27	8.00	10.50	100	10	2024-12-08 00:00:00
2910	Chile chipotle la morena	None	6	72	8.00	10.50	100	10	2024-12-08 00:00:00
2911	Chiles en vinagre la morena	None	6	72	8.00	10.50	100	10	2024-12-08 00:00:00
2912	Mayonesa mccormick chica	None	7	72	8.00	10.50	100	10	2024-12-08 00:00:00
2913	Mayonesa mccormick grande	None	7	72	8.00	10.50	100	10	2024-12-08 00:00:00
2914	Mostaza mccormick	None	7	72	8.00	10.50	100	10	2024-12-08 00:00:00
2915	Mermelada mccormick fresa chica	None	19	72	8.00	10.50	100	10	2024-12-08 00:00:00
2916	Mermelada mccormick fresa grande	None	19	72	8.00	10.50	100	10	2024-12-08 00:00:00
2917	Cloralex 1/2 lt	None	35	58	8.00	10.50	100	10	2024-12-08 00:00:00
2918	Cloralex 1 lt	None	35	58	8.00	10.50	100	10	2024-12-08 00:00:00
2919	Pinol	None	35	58	8.00	10.50	100	10	2024-12-08 00:00:00
2920	Fabuloso lavanda 1lt	None	35	58	8.00	10.50	100	10	2024-12-08 00:00:00
2921	Fabuloso aroma floral 1lt	None	35	58	8.00	10.50	100	10	2024-12-08 00:00:00
2922	Detergente Ariel 1/2 kg	None	34	58	8.00	10.50	100	10	2024-12-08 00:00:00
2923	Detergente Ariel 1kg	None	34	58	8.00	10.50	100	10	2024-12-08 00:00:00
2924	Detergente Ace 1/2 kg	None	34	58	8.00	10.50	100	10	2024-12-08 00:00:00
2925	Detergente Ace 1kg	None	34	58	8.00	10.50	100	10	2024-12-08 00:00:00
2926	Detergente Foca 1/2 kg	None	34	58	8.00	10.50	100	10	2024-12-08 00:00:00
2927	Detergente Foca 1kg	None	34	58	8.00	10.50	100	10	2024-12-08 00:00:00
2928	Suavitel 1l	None	34	58	8.00	10.50	100	10	2024-12-08 00:00:00
2929	Papel higienico Petalo 4 rollos	None	37	58	8.00	10.50	100	10	2024-12-08 00:00:00
2930	Papel higienico Petalo 6 rollos	None	37	58	8.00	10.50	100	10	2024-12-08 00:00:00
2931	Papel higienico Suavel 4 rollos	None	37	58	8.00	10.50	100	10	2024-12-08 00:00:00
2932	Papel higienico Suavel 6 rollos	None	37	58	8.00	10.50	100	10	2024-12-08 00:00:00
2933	Toallas sanitarias Always	None	37	58	8.00	10.50	100	10	2024-12-08 00:00:00
2934	Toallas sanitarias Kotex	None	37	58	8.00	10.50	100	10	2024-12-08 00:00:00
2935	Panales Huggies	None	44	58	8.00	10.50	100	10	2024-12-08 00:00:00
2936	Shampoo Head & Shoulders chico	None	39	58	8.00	10.50	100	10	2024-12-08 00:00:00
2937	Shampoo Head & Shoulders grande	None	39	58	8.00	10.50	100	10	2024-12-08 00:00:00
2938	Desodorante Axe	None	41	58	8.00	10.50	100	10	2024-12-08 00:00:00
2939	Leche deslactosada 1lt	Presentacion azul	15	4	18.20	23.00	14	2	2024-12-08 00:00:00
2940	Yomi lala chocolate	None	15	4	15.00	30.00	100	10	2024-12-08 00:00:00
2941	Yomi lala vainilla	None	15	4	15.00	30.00	100	10	2024-12-08 00:00:00
2942	Yomi lala fresa	None	15	4	15.00	30.00	100	10	2024-12-08 00:00:00
2943	Yogurt lala fresa	None	15	4	15.00	30.00	100	10	2024-12-08 00:00:00
2944	Yogurt lala durazno	None	15	4	15.00	30.00	100	10	2024-12-08 00:00:00
2945	Yogurt lala manzana	None	15	4	15.00	30.00	100	10	2024-12-08 00:00:00
2946	Yogurt bebible lala manzana	None	15	4	15.00	30.00	100	10	2024-12-08 00:00:00
2947	Yogurt bebible lala durazno	None	15	4	15.00	30.00	100	10	2024-12-08 00:00:00
2948	Yogurt bebible lala fresa	None	15	4	15.00	30.00	100	10	2024-12-08 00:00:00
2949	Yogurt bebible lala moras	None	15	4	15.00	30.00	100	10	2024-12-08 00:00:00
2950	Yogurt bebible lala pina coco	None	15	4	15.00	30.00	100	10	2024-12-08 00:00:00
2951	Licuado lala fresa platano	None	15	4	15.00	30.00	100	10	2024-12-08 00:00:00
2952	Licuado lala nuez	None	15	4	15.00	30.00	100	10	2024-12-08 00:00:00
2953	Flan lala	None	15	4	15.00	30.00	100	10	2024-12-08 00:00:00
2954	Margarina lala 90gr	None	15	4	15.00	30.00	100	10	2024-12-08 00:00:00
2955	Jabon zote rosa chico	None	42	58	8.00	10.50	100	10	2024-12-08 00:00:00
2956	Jabon zote rosa grande	None	42	58	8.00	10.50	100	10	2024-12-08 00:00:00
2957	Jabon zote blanco chico	None	42	58	8.00	10.50	100	10	2024-12-08 00:00:00
2958	Jabon zote blanco grande	None	42	58	8.00	10.50	100	10	2024-12-08 00:00:00
2959	Pepsi	bebida azucarada	31	14	8.00	16.00	77	20	2025-04-06 00:00:00
2960	Manzanita		31	14	17.00	25.00	22	3	2025-04-06 00:00:00
2961	MaruchanTokyo	maruchan picante	2	11	5.50	12.50	15	10	2025-04-06 00:00:00
2962	Harina de maiz maseca	None	10	59	8.00	10.50	100	10	2025-04-06 00:00:00
2963	Sabritas	Sabritas Flamin Hot	9	3	10.00	18.00	4	1	2025-04-06 00:00:00
2964	Galletas marias	Las galletas clasicas	9	3	8.90	15.00	19	2	2025-04-06 00:00:00
2965	Leche entera lala 1lt	Clasica color roja	15	4	15.24	25.00	11	3	2025-04-06 00:00:00
2966	Leche Lala entera 1L	Leche Lala entera 1 Litro	15	4	19.00	24.00	100	10	2025-04-06 00:00:00
2967	Tostadas charras	None	5	60	8.00	10.50	100	10	2025-04-06 00:00:00
2968	Leche Lala light 1L	Leche Lala light 1 Litro	15	4	20.00	25.00	100	10	2025-04-06 00:00:00
2969	Leche Santa Clara entera 1L	Leche Santa Clara entera 1 Litro	15	4	22.00	28.00	100	10	2025-04-06 00:00:00
2970	Leche Santa Clara deslactosada 1L	Leche Santa Clara deslactosada 1 Litro	15	4	23.00	29.00	100	10	2025-04-06 00:00:00
2971	Arroz Mexica 1kg	None	2	59	12.00	16.50	100	10	2025-04-06 00:00:00
2972	Del Valle fruit naranja 600ml	Jugo Del Valle sabor Naranja 600 ml	31	28	10.50	13.50	100	10	2025-04-06 00:00:00
2973	Harina de trigo San antonio	None	10	41	8.00	10.50	100	10	2025-04-06 00:00:00
2974	Tortillas de maiz 1/2 kg	None	10	58	8.00	10.50	100	10	2025-04-06 00:00:00
2975	Pan bimbo blanco chico	None	27	17	8.00	10.50	100	10	2025-04-06 00:00:00
2976	Pan bimbo blanco grande	None	27	17	8.00	10.50	100	10	2025-04-06 00:00:00
2977	Pan bimbo integral chico	None	27	17	8.00	10.50	100	10	2025-04-06 00:00:00
2978	Pan bimbo integral grande	None	27	17	8.00	10.50	100	10	2025-04-06 00:00:00
2979	Rebanadas bimbo	None	27	17	8.00	10.50	100	10	2025-04-06 00:00:00
2980	Chocoroles	None	27	17	8.00	10.50	100	10	2025-04-06 00:00:00
2981	Nito bimbo	None	27	17	8.00	10.50	100	10	2025-04-06 00:00:00
2982	Mantecadas	None	27	17	8.00	10.50	100	10	2025-04-06 00:00:00
2983	Roles de canela con pasas	None	27	17	8.00	10.50	100	10	2025-04-06 00:00:00
2984	Roles de canela glaseados	None	27	17	8.00	10.50	100	10	2025-04-06 00:00:00
2985	Conchas bimbo	None	27	17	8.00	10.50	100	10	2025-04-06 00:00:00
2986	Panque de nuez bimbo	None	27	17	8.00	10.50	100	10	2025-04-06 00:00:00
2987	Donitas bimbo	None	27	17	8.00	10.50	100	10	2025-04-06 00:00:00
2988	Donitas espolvoreadas bimbo	None	27	17	8.00	10.50	100	10	2025-04-06 00:00:00
2989	chimichangas	chimichangas	23	10	30.00	45.00	15	5	2025-04-06 00:00:00
2990	Coca Cola 1L	Refresco Coca Cola 1 Litro	31	16	12.00	15.00	100	10	2025-04-06 00:00:00
2991	Coca Cola lata 355ml	Refresco Coca Cola 355 ml lata	31	16	8.50	11.00	100	10	2025-04-06 00:00:00
2992	Coca Cola 355ml	Refresco Coca Cola 355 ml	31	16	8.00	10.50	100	10	2025-04-06 00:00:00
2993	Coca Cola 600ml	Refresco Coca Cola 600 ml	31	16	9.00	12.00	100	10	2025-04-06 00:00:00
2994	Coca Cola retornable 1 1/4 lt.	Refresco Coca Cola retornable 1 1/4 lt	31	16	12.50	15.50	100	10	2025-04-06 00:00:00
2995	Coca Cola 2L retornable	Refresco Coca Cola retornable 2 Litros	31	16	19.50	24.00	100	10	2025-04-06 00:00:00
2996	Coca Cola 3L retornable	Refresco Coca Cola retornable 3 Litros	31	16	24.00	30.00	100	10	2025-04-06 00:00:00
2997	Coca Cola Light 600ml	Refresco Coca Cola Light 600 ml	31	16	9.50	12.50	100	10	2025-04-06 00:00:00
2998	Pepsi 600ml	Refresco Pepsi 600 ml	31	14	9.00	12.00	100	10	2025-04-06 00:00:00
2999	Pepsi 1.5L	Refresco Pepsi 1.5 Litros	31	14	12.00	15.50	100	10	2025-04-06 00:00:00
3000	Fanta 600ml	Refresco Fanta 600 ml	31	16	9.00	12.00	100	10	2025-04-06 00:00:00
3001	Fanta 1.5L	Refresco Fanta 1.5 Litros	31	16	12.50	16.00	100	10	2025-04-06 00:00:00
3002	Sprite 600ml	Refresco Sprite 600 ml	31	16	9.00	12.00	100	10	2025-04-06 00:00:00
3003	Sprite 1.5L	Refresco Sprite 1.5 Litros	31	16	12.50	16.00	100	10	2025-04-06 00:00:00
3004	Manzanita 600ml	Refresco Manzanita Sol 600 ml	31	16	9.00	12.00	100	10	2025-04-06 00:00:00
3005	Manzanita 1.5L	Refresco Manzanita Sol 1.5 Litros	31	16	12.50	16.00	100	10	2025-04-06 00:00:00
3006	Fresca 600ml	Refresco Fresca 600 ml	31	16	9.00	12.00	100	10	2025-04-06 00:00:00
3007	Fresca 3L	Refresco Fresca 3 Litros	31	16	24.00	30.00	100	10	2025-04-06 00:00:00
3008	Mirinda 600ml	Refresco Mirinda 600 ml	31	16	9.00	12.00	100	10	2025-04-06 00:00:00
3009	Mirinda 1.5L	Refresco Mirinda 1.5 Litros	31	16	12.50	16.00	100	10	2025-04-06 00:00:00
3010	Tostadas Sanissimo	None	5	61	8.00	10.50	100	10	2025-04-06 00:00:00
3011	Marias gamesa	None	29	46	8.00	10.50	100	10	2025-04-06 00:00:00
3012	Jumex de mango 1L	Jugo Jumex sabor Mango 1 Litro	31	21	16.00	20.00	100	10	2025-04-06 00:00:00
3013	Emperador chocolate	None	29	46	8.00	10.50	100	10	2025-04-06 00:00:00
3014	Emperador nuez	None	29	46	8.00	10.50	100	10	2025-04-06 00:00:00
3015	Emperador vainilla	None	29	46	8.00	10.50	100	10	2025-04-06 00:00:00
3016	Emperador limon	None	29	46	8.00	10.50	100	10	2025-04-06 00:00:00
3017	Jumex de durazno 1L	Jugo Jumex sabor Durazno 1 Litro	31	21	16.00	20.00	100	10	2025-04-06 00:00:00
3018	Jumex de manzana 600ml	Jugo Jumex sabor Manzana 600 ml	31	21	10.00	13.00	100	10	2025-04-06 00:00:00
3019	Roles	Ricos roles de canela caseros	27	13	70.00	100.00	18	10	2025-04-06 00:00:00
3020	Del Valle fruit manzana 600ml	Jugo Del Valle sabor Manzana 600 ml	31	28	10.50	13.50	100	10	2025-04-06 00:00:00
3021	Del Valle fruit guayaba 600ml	Jugo Del Valle sabor Guayaba 600 ml	31	28	10.50	13.50	100	10	2025-04-06 00:00:00
3022	Emperador Senso	None	29	46	8.00	10.50	100	10	2025-04-06 00:00:00
3023	Mamut chico	None	29	46	8.00	10.50	100	10	2025-04-06 00:00:00
3024	Yogurt Lala natural 1L	Yogurt Lala natural 1 Litro	17	4	25.00	30.00	100	10	2025-04-06 00:00:00
3025	Yogurt Lala de fresa 1L	Yogurt Lala sabor Fresa 1 Litro	17	4	25.00	30.00	100	10	2025-04-06 00:00:00
3026	Yogurt Yoplait de fresa 1L	Yogurt Yoplait sabor Fresa 1 Litro	17	54	26.00	31.00	100	10	2025-04-06 00:00:00
3027	Mantequilla Lala 250g	Mantequilla Lala 250 gramos	19	4	30.00	38.00	100	10	2025-04-06 00:00:00
3028	Queso panela Lala 200g	Queso panela Lala 200 gramos	16	4	40.00	50.00	100	10	2025-04-06 00:00:00
3029	Mamut grande	None	29	46	8.00	10.50	100	10	2025-04-06 00:00:00
3030	Chokis	None	29	46	8.00	10.50	100	10	2025-04-06 00:00:00
3031	Chokis rellenas	None	29	46	8.00	10.50	100	10	2025-04-06 00:00:00
3032	Chokis doble chocolate	None	29	46	8.00	10.50	100	10	2025-04-06 00:00:00
3033	Chokis brownie	None	29	46	8.00	10.50	100	10	2025-04-06 00:00:00
3034	Leche Lala deslactosada 1L	Leche Lala deslactosada 1 Litro	15	4	20.00	25.00	100	10	2025-04-06 00:00:00
3035	Queso panela Alpura 200g	Queso panela Alpura 200 gramos	16	18	40.00	50.00	100	10	2025-04-06 00:00:00
3036	Queso oaxaca Lala 200g	Queso Oaxaca Lala 200 gramos	16	4	45.00	55.00	100	10	2025-04-06 00:00:00
3037	Queso manchego Lala 200g	Queso Manchego Lala 200 gramos	16	4	50.00	60.00	100	10	2025-04-06 00:00:00
3038	Salchichas Fud paquete 500g	Salchichas Fud 500 gramos	18	53	30.00	40.00	100	10	2025-04-06 00:00:00
3039	Salchichas San Rafael paquete 500g	Salchichas San Rafael 500 gramos	18	52	35.00	45.00	100	10	2025-04-06 00:00:00
3040	Sidral mundet 600ml	Refresco de manzana de 600ml	31	16	10.00	16.00	20	5	2025-04-06 00:00:00
3041	Sidral mundet 3lt	Refresco de manzana de 3lt	31	16	24.00	30.00	20	5	2025-04-06 00:00:00
3042	Agua bonafont 600ml	None	30	55	8.00	10.50	100	10	2025-04-06 00:00:00
3043	Agua bonafont 1lt	None	30	55	12.00	15.00	100	10	2025-04-06 00:00:00
3044	Agua bonafont 2lt.	None	30	55	14.00	18.00	100	10	2025-04-06 00:00:00
3045	Garrafon bonafont 20lt	None	30	55	19.50	24.00	100	10	2025-04-06 00:00:00
3046	Agua ciel 600ml	None	30	16	8.00	13.00	100	10	2025-04-06 00:00:00
3047	Agua ciel 1lt	None	30	16	10.00	15.00	100	10	2025-04-06 00:00:00
3048	Agua ciel 1.5l	None	30	16	12.00	17.00	100	10	2025-04-06 00:00:00
3049	Agua ciel 2lt	None	30	16	14.00	20.00	100	10	2025-04-06 00:00:00
3050	Agua E-pura 600ml	None	30	14	8.00	13.00	100	10	2025-04-06 00:00:00
3051	Agua E-pura 1lt	None	30	14	10.00	15.00	100	10	2025-04-06 00:00:00
3052	Garrafon E-pura 10lt	None	30	14	18.00	25.00	100	10	2025-04-06 00:00:00
3053	Crema Lala 200ml	None	15	4	8.00	13.00	100	10	2025-04-06 00:00:00
3054	Crema Lala 426ml	None	15	4	15.00	30.00	100	10	2025-04-06 00:00:00
3055	Crema Lala 900ml	None	15	4	35.00	55.00	100	10	2025-04-06 00:00:00
3056	Crema alpura 200ml	None	15	4	8.00	13.00	100	10	2025-04-06 00:00:00
3057	Crema alpura 426ml	None	15	4	15.00	30.00	100	10	2025-04-06 00:00:00
3058	Crema alpura 900ml	None	15	4	35.00	55.00	100	10	2025-04-06 00:00:00
3059	Atun dolores en agua	None	6	51	10.00	15.00	100	10	2025-04-06 00:00:00
3060	Atun dolores en aceite	None	6	51	12.00	17.00	100	10	2025-04-06 00:00:00
3061	Sardinas en aceite	None	6	20	10.00	15.00	100	10	2025-04-06 00:00:00
3062	Frijoles refritos	None	6	50	10.00	15.00	100	10	2025-04-06 00:00:00
3063	Frijoles bayos	None	6	50	10.00	15.00	100	10	2025-04-06 00:00:00
3064	Pasta la moderna	None	2	44	10.00	15.00	100	10	2025-04-06 00:00:00
3065	Coditos la moderna	None	2	44	10.00	15.00	100	10	2025-04-06 00:00:00
3066	Pasta Barilla espagueti	None	2	56	10.00	15.00	100	10	2025-04-06 00:00:00
3067	Sopa de letras la moderna	None	2	44	10.00	15.00	100	10	2025-04-06 00:00:00
3068	Sopa maruchan pollo	None	2	57	10.00	15.00	100	10	2025-04-06 00:00:00
3069	Sopa maruchan camaron	None	2	57	10.00	15.00	100	10	2025-04-06 00:00:00
3070	Sopa maruchan res	None	2	57	10.00	15.00	100	10	2025-04-06 00:00:00
3071	Sopa maruchan habanero	None	2	57	10.00	15.00	100	10	2025-04-06 00:00:00
3072	Sopa maruchan piquin	None	2	57	10.00	15.00	100	10	2025-04-06 00:00:00
3073	Sopa maruchan limon	None	2	57	10.00	15.00	100	10	2025-04-06 00:00:00
3074	Lentejas la moderna	None	2	44	10.00	15.00	100	10	2025-04-06 00:00:00
3075	Jamon de pavo Fud 250g	Jamon de Pavo Fud 250 gramos	18	53	35.00	45.00	100	10	2025-04-06 00:00:00
3076	Jamon de pavo San Rafael 250g	Jamon de Pavo San Rafael 250 gramos	18	52	40.00	50.00	100	10	2025-04-06 00:00:00
3077	Cremax chocolate	None	29	46	8.00	10.50	100	10	2025-04-06 00:00:00
3078	Cremax fresa	None	29	46	8.00	10.50	100	10	2025-04-06 00:00:00
3079	Florentinas gamesa	None	29	46	8.00	10.50	100	10	2025-04-06 00:00:00
3080	Marias doradas	None	29	46	8.00	10.50	100	10	2025-04-06 00:00:00
3081	Gamesa cajeta	None	29	46	8.00	10.50	100	10	2025-04-06 00:00:00
3082	Maravillas gamesa	None	29	46	8.00	10.50	100	10	2025-04-06 00:00:00
3083	Crackets gamesa	None	29	46	8.00	10.50	100	10	2025-04-06 00:00:00
3084	Surtido rico gamesa	None	29	46	8.00	10.50	100	10	2025-04-06 00:00:00
3085	Delicias gamesa	None	29	46	8.00	10.50	100	10	2025-04-06 00:00:00
3086	Oreo	None	9	58	8.00	10.50	100	10	2025-04-06 00:00:00
3087	Principe chocolate	None	9	22	8.00	10.50	100	10	2025-04-06 00:00:00
3088	Principe vainilla	None	9	22	8.00	10.50	100	10	2025-04-06 00:00:00
3089	Principe limon	None	9	22	8.00	10.50	100	10	2025-04-06 00:00:00
3090	Principe chocolate blanco	None	9	22	8.00	10.50	100	10	2025-04-06 00:00:00
3091	Lors	None	9	22	8.00	10.50	100	10	2025-04-06 00:00:00
3092	Plativolos	None	9	22	8.00	10.50	100	10	2025-04-06 00:00:00
3093	Sponch	None	9	22	8.00	10.50	100	10	2025-04-06 00:00:00
3094	Triki trakes	None	9	22	8.00	10.50	100	10	2025-04-06 00:00:00
3095	MaxiTubo Triki trakes	None	9	22	8.00	10.50	100	10	2025-04-06 00:00:00
3096	Gansito	None	9	22	8.00	10.50	100	10	2025-04-06 00:00:00
3097	Pinguinos	None	9	22	8.00	10.50	100	10	2025-04-06 00:00:00
3098	Pasticetas marinela	None	9	22	8.00	10.50	100	10	2025-04-06 00:00:00
3099	Barritas fresa	None	9	22	8.00	10.50	100	10	2025-04-06 00:00:00
3100	Barritas pina	None	9	22	8.00	10.50	100	10	2025-04-06 00:00:00
3101	Barritas moras	None	9	22	8.00	10.50	100	10	2025-04-06 00:00:00
3102	Maxitubo Barritas pina	None	9	22	8.00	10.50	100	10	2025-04-06 00:00:00
3103	Canelitas	None	9	22	8.00	10.50	100	10	2025-04-06 00:00:00
3104	Polvorones	None	9	22	8.00	10.50	100	10	2025-04-06 00:00:00
3105	Maxitubo Polvorones	None	9	22	8.00	10.50	100	10	2025-04-06 00:00:00
3106	Ricanelas	None	9	46	8.00	10.50	100	10	2025-04-06 00:00:00
3107	Ritz bits queso	None	9	58	8.00	10.50	100	10	2025-04-06 00:00:00
3108	Arcoiris	None	9	46	8.00	10.50	100	10	2025-04-06 00:00:00
3109	Submarinos fresa	None	9	22	8.00	10.50	100	10	2025-04-06 00:00:00
3110	Submarinos vainilla	None	9	22	8.00	10.50	100	10	2025-04-06 00:00:00
3111	Submarinos chocolate	None	9	22	8.00	10.50	100	10	2025-04-06 00:00:00
3112	Rocko chico	None	9	22	8.00	10.50	100	10	2025-04-06 00:00:00
3113	Rocko grande	None	9	22	8.00	10.50	100	10	2025-04-06 00:00:00
3114	Sabritas original	None	9	3	8.00	10.50	100	10	2025-04-06 00:00:00
3115	Sabritas adobadas	None	9	3	8.00	10.50	100	10	2025-04-06 00:00:00
3116	Sabritas limon	None	9	3	8.00	10.50	100	10	2025-04-06 00:00:00
3117	Sabritas flamin hot	None	9	3	8.00	10.50	100	10	2025-04-06 00:00:00
3118	Sabritas crema y especias	None	9	3	8.00	10.50	100	10	2025-04-06 00:00:00
3119	Sabritas habanero	None	9	3	8.00	10.50	100	10	2025-04-06 00:00:00
3120	Sabritas receta crujiente	None	9	3	8.00	10.50	100	10	2025-04-06 00:00:00
3121	Chips jalapeno	None	9	47	8.00	10.50	100	10	2025-04-06 00:00:00
3122	Crujitos	None	9	3	8.00	10.50	100	10	2025-04-06 00:00:00
3123	Doritos nacho	None	9	3	8.00	10.50	100	10	2025-04-06 00:00:00
3124	Doritos incognita	None	9	3	8.00	10.50	100	10	2025-04-06 00:00:00
3125	Doritos diablo	None	9	3	8.00	10.50	100	10	2025-04-06 00:00:00
3126	Doritos flamin hot	None	9	3	8.00	10.50	100	10	2025-04-06 00:00:00
3127	Doritos dinamita	None	9	3	8.00	10.50	100	10	2025-04-06 00:00:00
3128	Sabritones	None	9	3	8.00	10.50	100	10	2025-04-06 00:00:00
3129	Bigmix queso	None	9	47	8.00	10.50	100	10	2025-04-06 00:00:00
3130	Bigmix fuego	None	9	47	8.00	10.50	100	10	2025-04-06 00:00:00
3131	Cheetos torciditos	None	9	3	8.00	10.50	100	10	2025-04-06 00:00:00
3132	Cheetos bolitas	None	9	3	8.00	10.50	100	10	2025-04-06 00:00:00
3133	Cheetos queso	None	9	3	8.00	10.50	100	10	2025-04-06 00:00:00
3134	Cheetos flamin hot	None	9	3	8.00	10.50	100	10	2025-04-06 00:00:00
3135	Ruffles original	None	9	3	8.00	10.50	100	10	2025-04-06 00:00:00
3136	Ruffles queso	None	9	3	8.00	10.50	100	10	2025-04-06 00:00:00
3137	Fritos sal y limon	None	9	3	8.00	10.50	100	10	2025-04-06 00:00:00
3138	Fritos chorizo	None	9	3	8.00	10.50	100	10	2025-04-06 00:00:00
3139	Bolsaza Sabritas original	None	9	3	8.00	10.50	100	10	2025-04-06 00:00:00
3140	Bolsaza Doritos nacho	None	9	3	8.00	10.50	100	10	2025-04-06 00:00:00
3141	Paketaxo	None	9	3	8.00	10.50	100	10	2025-04-06 00:00:00
3142	Paketaxo queso	None	9	3	8.00	10.50	100	10	2025-04-06 00:00:00
3143	Paketaxo flamin hot	None	9	3	8.00	10.50	100	10	2025-04-06 00:00:00
3144	Churrumaiz	None	9	3	8.00	10.50	100	10	2025-04-06 00:00:00
3145	Churrumaiz flamin hot	None	9	3	8.00	10.50	100	10	2025-04-06 00:00:00
3146	Rancheritos	None	9	3	8.00	10.50	100	10	2025-04-06 00:00:00
3147	Sabritas switch doritos nacho	None	9	3	8.00	10.50	100	10	2025-04-06 00:00:00
3148	Runners	None	9	47	8.00	10.50	100	10	2025-04-06 00:00:00
3149	Chips sal	None	9	47	8.00	10.50	100	10	2025-04-06 00:00:00
3150	Papatinas	None	9	47	8.00	10.50	100	10	2025-04-06 00:00:00
3151	Chips fuego	None	9	47	8.00	10.50	100	10	2025-04-06 00:00:00
3152	Palomitas pop	None	9	47	8.00	10.50	100	10	2025-04-06 00:00:00
3153	Takis original 	None	9	47	8.00	10.50	100	10	2025-04-06 00:00:00
3154	Takis fuego	None	9	47	8.00	10.50	100	10	2025-04-06 00:00:00
3155	Takis salsa brava	None	9	47	8.00	10.50	100	10	2025-04-06 00:00:00
3156	Takis guacamole	None	9	47	8.00	10.50	100	10	2025-04-06 00:00:00
3157	Chipotles	None	9	47	8.00	10.50	100	10	2025-04-06 00:00:00
3158	Tostachos	None	9	47	8.00	10.50	100	10	2025-04-06 00:00:00
3159	Hot nuts	None	9	47	8.00	10.50	100	10	2025-04-06 00:00:00
3160	Hot nuts fuego	None	9	47	8.00	10.50	100	10	2025-04-06 00:00:00
3161	Valentones	None	9	47	8.00	10.50	100	10	2025-04-06 00:00:00
3162	Watz barcel	None	9	47	8.00	10.50	100	10	2025-04-06 00:00:00
3163	Toreadas	None	9	47	8.00	10.50	100	10	2025-04-06 00:00:00
3164	Palomitas pop fuego	None	9	47	8.00	10.50	100	10	2025-04-06 00:00:00
3165	Takis blue heat	None	9	47	8.00	10.50	100	10	2025-04-06 00:00:00
3166	Doraditas tia rosa	None	29	49	8.00	10.50	100	10	2025-04-06 00:00:00
3167	Sabritas receta crujiente jalapeno	None	9	3	8.00	10.50	100	10	2025-04-06 00:00:00
3168	Tortillinas tia rosa	None	10	49	8.00	10.50	100	10	2025-04-06 00:00:00
3169	Conchas tia rosa	None	29	49	8.00	10.50	100	10	2025-04-06 00:00:00
3170	Hersheys Cookies n Cream	None	8	45	8.00	10.50	100	10	2025-04-06 00:00:00
3171	Hersheys almendras	None	8	45	8.00	10.50	100	10	2025-04-06 00:00:00
3172	Hersheys chocolate amargo	None	8	45	8.00	10.50	100	10	2025-04-06 00:00:00
3173	Hersheys chocolate blanco	None	8	45	8.00	10.50	100	10	2025-04-06 00:00:00
3174	Crunch	None	8	19	8.00	10.50	100	10	2025-04-06 00:00:00
3175	Carlos V	None	8	19	8.00	10.50	100	10	2025-04-06 00:00:00
3176	Milky way	None	8	19	8.00	10.50	100	10	2025-04-06 00:00:00
3177	Snickers	None	8	19	8.00	10.50	100	10	2025-04-06 00:00:00
3178	Kit kat	None	8	19	8.00	10.50	100	10	2025-04-06 00:00:00
3179	Kinder delice	None	8	40	8.00	10.50	100	10	2025-04-06 00:00:00
3180	Kinder sorpresa	None	8	40	8.00	10.50	100	10	2025-04-06 00:00:00
3181	Ferrero rocher 3 piezas	None	8	40	8.00	10.50	100	10	2025-04-06 00:00:00
3182	Mazapan	None	8	62	8.00	10.50	100	10	2025-04-06 00:00:00
3183	Pelon pelo rico	None	8	45	8.00	10.50	100	10	2025-04-06 00:00:00
3184	Pulparindo tamarindo	None	8	62	8.00	10.50	100	10	2025-04-06 00:00:00
3185	Pulparindo chamoy	None	8	62	8.00	10.50	100	10	2025-04-06 00:00:00
3186	Tutsi pop	None	8	65	8.00	10.50	100	10	2025-04-06 00:00:00
3187	Oblea cajeta coronado	None	8	66	8.00	10.50	100	10	2025-04-06 00:00:00
3188	Paleta payaso	None	8	67	8.00	10.50	100	10	2025-04-06 00:00:00
3189	Duvalin fresa vainilla	None	8	67	8.00	10.50	100	10	2025-04-06 00:00:00
3190	Duvalin chocolate vainilla	None	8	67	8.00	10.50	100	10	2025-04-06 00:00:00
3191	Duvalin vainilla	None	8	67	8.00	10.50	100	10	2025-04-06 00:00:00
3192	Duvalin trisabor	None	8	67	8.00	10.50	100	10	2025-04-06 00:00:00
3193	Duvalin choco avellana	None	8	67	8.00	10.50	100	10	2025-04-06 00:00:00
3194	Paleta Vero mango	None	8	68	8.00	10.50	100	10	2025-04-06 00:00:00
3195	Paleta Vero elote	None	8	67	8.00	10.50	100	10	2025-04-06 00:00:00
3196	Panditas	None	8	67	8.00	10.50	100	10	2025-04-06 00:00:00
3197	Panditas rellenos	None	8	67	8.00	10.50	100	10	2025-04-06 00:00:00
3198	Panditas san valentin	None	8	67	8.00	10.50	100	10	2025-04-06 00:00:00
3199	Bubulubu	None	8	67	8.00	10.50	100	10	2025-04-06 00:00:00
3200	Rockaleta	None	8	69	8.00	10.50	100	10	2025-04-06 00:00:00
3201	Tic tac menta	None	8	40	8.00	10.50	100	10	2025-04-06 00:00:00
3202	Halls menta	None	8	58	8.00	10.50	100	10	2025-04-06 00:00:00
3203	Halls limon	None	8	58	8.00	10.50	100	10	2025-04-06 00:00:00
3204	Halls yerba buena	None	8	58	8.00	10.50	100	10	2025-04-06 00:00:00
3205	Halls miel	None	8	58	8.00	10.50	100	10	2025-04-06 00:00:00
3206	Halls negras	None	8	58	8.00	10.50	100	10	2025-04-06 00:00:00
3207	Gomilocas dientes	None	8	67	8.00	10.50	100	10	2025-04-06 00:00:00
3208	Gomilocas pinguino	None	8	67	8.00	10.50	100	10	2025-04-06 00:00:00
3209	Chocoretas	None	8	67	8.00	10.50	100	10	2025-04-06 00:00:00
3210	Kranky	None	8	67	8.00	10.50	100	10	2025-04-06 00:00:00
3211	Lucas muecas	None	8	58	8.00	10.50	100	10	2025-04-06 00:00:00
3212	Lucas chamoy	None	8	58	8.00	10.50	100	10	2025-04-06 00:00:00
3213	Lucas gusanito	None	8	58	8.00	10.50	100	10	2025-04-06 00:00:00
3214	Palomitas Act II mantequilla	None	9	58	8.00	10.50	100	10	2025-04-06 00:00:00
3215	Palomitas Act II natural	None	9	58	8.00	10.50	100	10	2025-04-06 00:00:00
3216	Palomitas Act II chile limon	None	9	58	8.00	10.50	100	10	2025-04-06 00:00:00
3217	Tostitos salsa verde	None	9	3	8.00	10.50	100	10	2025-04-06 00:00:00
3218	Zucaritas chicas	None	5	26	8.00	10.50	100	10	2025-04-06 00:00:00
3219	Zucaritas grandes	None	5	26	8.00	10.50	100	10	2025-04-06 00:00:00
3220	Corn flakes chicas	None	5	26	8.00	10.50	100	10	2025-04-06 00:00:00
3221	Corn flakes grandes	None	5	26	8.00	10.50	100	10	2025-04-06 00:00:00
3222	Choco Krispis chicas	None	5	26	8.00	10.50	100	10	2025-04-06 00:00:00
3223	Choco Krispis grandes	None	5	26	8.00	10.50	100	10	2025-04-06 00:00:00
3224	Nesquik chico	None	5	26	8.00	10.50	100	10	2025-04-06 00:00:00
3225	Nesquik grande	None	5	26	8.00	10.50	100	10	2025-04-06 00:00:00
3226	Froot loops chicas	None	5	26	8.00	10.50	100	10	2025-04-06 00:00:00
3227	Froot loops grandes	None	5	26	8.00	10.50	100	10	2025-04-06 00:00:00
3228	Chocomilk sobre	None	4	58	8.00	10.50	100	10	2025-04-06 00:00:00
3229	Chocomilk bolsa	None	4	58	8.00	10.50	100	10	2025-04-06 00:00:00
3230	Chocomilk lata	None	4	58	8.00	10.50	100	10	2025-04-06 00:00:00
3231	Nescafe clasico sobre	None	4	19	8.00	10.50	100	10	2025-04-06 00:00:00
3232	Nescafe capuccino sobre	None	4	19	8.00	10.50	100	10	2025-04-06 00:00:00
3233	Nescafe clasico bote chico	None	4	19	8.00	10.50	100	10	2025-04-06 00:00:00
3234	Nescafe clasico bote grande	None	4	19	8.00	10.50	100	10	2025-04-06 00:00:00
3235	Azucar Zulka 1kg	None	3	58	8.00	10.50	100	10	2025-04-06 00:00:00
3236	Azucar refinada 1kg	None	3	58	8.00	10.50	100	10	2025-04-06 00:00:00
3237	Azucar refinada 500gr	None	3	58	8.00	10.50	100	10	2025-04-06 00:00:00
3238	Azucar refinada 250gr	None	3	58	8.00	10.50	100	10	2025-04-06 00:00:00
3239	Aceite nutrioli 1lt	None	1	58	8.00	10.50	100	10	2025-04-06 00:00:00
3240	Aceite capullo 1lt	None	1	58	8.00	10.50	100	10	2025-04-06 00:00:00
3241	Aceite 1 2 3 1lt	None	1	58	8.00	10.50	100	10	2025-04-06 00:00:00
3242	Aceite patrona 1lt	None	1	58	8.00	10.50	100	10	2025-04-06 00:00:00
3243	Vinagre blanco la coste¤a	None	1	27	8.00	10.50	100	10	2025-04-06 00:00:00
3244	Vinagre de manzana la coste¤a	None	1	27	8.00	10.50	100	10	2025-04-06 00:00:00
3245	Catsup la coste¤a	None	1	27	8.00	10.50	100	10	2025-04-06 00:00:00
3246	Catsup Del monte	None	1	70	8.00	10.50	100	10	2025-04-06 00:00:00
3247	Catsup heinz	None	1	71	8.00	10.50	100	10	2025-04-06 00:00:00
3248	Jugo Magui	None	7	19	8.00	10.50	100	10	2025-04-06 00:00:00
3249	Salsa inglesa	None	7	19	8.00	10.50	100	10	2025-04-06 00:00:00
3250	Salsa valentina chica	None	7	58	8.00	10.50	100	10	2025-04-06 00:00:00
3251	Salsa valentina grande	None	7	58	8.00	10.50	100	10	2025-04-06 00:00:00
3252	Salsa tabasco	None	7	58	8.00	10.50	100	10	2025-04-06 00:00:00
3253	Salsa buffalo	None	7	58	8.00	10.50	100	10	2025-04-06 00:00:00
3254	Salsa chipotle la coste¤a	None	7	27	8.00	10.50	100	10	2025-04-06 00:00:00
3255	Chile chipotle la coste¤a	None	6	27	8.00	10.50	100	10	2025-04-06 00:00:00
3256	Tic tac naranja	None	8	40	8.00	10.50	100	10	2025-04-06 00:00:00
3257	Yogurt Yoplait natural 1L	Yogurt Yoplait natural 1 Litro	17	54	26.00	31.00	100	10	2025-04-06 00:00:00
3258	Cremax vainilla	None	29	46	8.00	10.50	100	10	2025-04-06 00:00:00
3259	Maxitubo Barritas fresa	None	9	22	8.00	10.50	100	10	2025-04-06 00:00:00
3260	Bigote tia rosa	None	29	49	8.00	10.50	100	10	2025-04-06 00:00:00
3261	Magdalenas tia rosa	None	29	49	8.00	10.50	100	10	2025-04-06 00:00:00
3262	Chiles serranos la coste¤a	None	6	27	8.00	10.50	100	10	2025-04-06 00:00:00
3263	Chiles en vinagre la coste¤a	None	6	27	8.00	10.50	100	10	2025-04-06 00:00:00
3264	Chile chipotle la morena	None	6	72	8.00	10.50	100	10	2025-04-06 00:00:00
3265	Chiles en vinagre la morena	None	6	72	8.00	10.50	100	10	2025-04-06 00:00:00
3266	Mayonesa mccormick chica	None	7	72	8.00	10.50	100	10	2025-04-06 00:00:00
3267	Mayonesa mccormick grande	None	7	72	8.00	10.50	100	10	2025-04-06 00:00:00
3268	Mostaza mccormick	None	7	72	8.00	10.50	100	10	2025-04-06 00:00:00
3269	Mermelada mccormick fresa chica	None	19	72	8.00	10.50	100	10	2025-04-06 00:00:00
3270	Mermelada mccormick fresa grande	None	19	72	8.00	10.50	100	10	2025-04-06 00:00:00
3271	Cloralex 1/2 lt	None	35	58	8.00	10.50	100	10	2025-04-06 00:00:00
3272	Cloralex 1 lt	None	35	58	8.00	10.50	100	10	2025-04-06 00:00:00
3273	Pinol	None	35	58	8.00	10.50	100	10	2025-04-06 00:00:00
3274	Fabuloso lavanda 1lt	None	35	58	8.00	10.50	100	10	2025-04-06 00:00:00
3275	Fabuloso aroma floral 1lt	None	35	58	8.00	10.50	100	10	2025-04-06 00:00:00
3276	Detergente Ariel 1/2 kg	None	34	58	8.00	10.50	100	10	2025-04-06 00:00:00
3277	Detergente Ariel 1kg	None	34	58	8.00	10.50	100	10	2025-04-06 00:00:00
3278	Detergente Ace 1/2 kg	None	34	58	8.00	10.50	100	10	2025-04-06 00:00:00
3279	Detergente Ace 1kg	None	34	58	8.00	10.50	100	10	2025-04-06 00:00:00
3280	Detergente Foca 1/2 kg	None	34	58	8.00	10.50	100	10	2025-04-06 00:00:00
3281	Detergente Foca 1kg	None	34	58	8.00	10.50	100	10	2025-04-06 00:00:00
3282	Suavitel 1l	None	34	58	8.00	10.50	100	10	2025-04-06 00:00:00
3283	Papel higienico Petalo 4 rollos	None	37	58	8.00	10.50	100	10	2025-04-06 00:00:00
3284	Papel higienico Petalo 6 rollos	None	37	58	8.00	10.50	100	10	2025-04-06 00:00:00
3285	Papel higienico Suavel 4 rollos	None	37	58	8.00	10.50	100	10	2025-04-06 00:00:00
3286	Papel higienico Suavel 6 rollos	None	37	58	8.00	10.50	100	10	2025-04-06 00:00:00
3287	Toallas sanitarias Always	None	37	58	8.00	10.50	100	10	2025-04-06 00:00:00
3288	Toallas sanitarias Kotex	None	37	58	8.00	10.50	100	10	2025-04-06 00:00:00
3289	Panales Huggies	None	44	58	8.00	10.50	100	10	2025-04-06 00:00:00
3290	Shampoo Head & Shoulders chico	None	39	58	8.00	10.50	100	10	2025-04-06 00:00:00
3291	Shampoo Head & Shoulders grande	None	39	58	8.00	10.50	100	10	2025-04-06 00:00:00
3292	Desodorante Axe	None	41	58	8.00	10.50	100	10	2025-04-06 00:00:00
3293	Leche deslactosada 1lt	Presentacion azul	15	4	18.20	23.00	14	2	2025-04-06 00:00:00
3294	Yomi lala chocolate	None	15	4	15.00	30.00	100	10	2025-04-06 00:00:00
3295	Yomi lala vainilla	None	15	4	15.00	30.00	100	10	2025-04-06 00:00:00
3296	Yomi lala fresa	None	15	4	15.00	30.00	100	10	2025-04-06 00:00:00
3297	Yogurt lala fresa	None	15	4	15.00	30.00	100	10	2025-04-06 00:00:00
3298	Yogurt lala durazno	None	15	4	15.00	30.00	100	10	2025-04-06 00:00:00
3299	Yogurt lala manzana	None	15	4	15.00	30.00	100	10	2025-04-06 00:00:00
3300	Yogurt bebible lala manzana	None	15	4	15.00	30.00	100	10	2025-04-06 00:00:00
3301	Yogurt bebible lala durazno	None	15	4	15.00	30.00	100	10	2025-04-06 00:00:00
3302	Yogurt bebible lala fresa	None	15	4	15.00	30.00	100	10	2025-04-06 00:00:00
3303	Yogurt bebible lala moras	None	15	4	15.00	30.00	100	10	2025-04-06 00:00:00
3304	Yogurt bebible lala pina coco	None	15	4	15.00	30.00	100	10	2025-04-06 00:00:00
3305	Licuado lala fresa platano	None	15	4	15.00	30.00	100	10	2025-04-06 00:00:00
3306	Licuado lala nuez	None	15	4	15.00	30.00	100	10	2025-04-06 00:00:00
3307	Flan lala	None	15	4	15.00	30.00	100	10	2025-04-06 00:00:00
3308	Margarina lala 90gr	None	15	4	15.00	30.00	100	10	2025-04-06 00:00:00
3309	Jabon zote rosa chico	None	42	58	8.00	10.50	100	10	2025-04-06 00:00:00
3310	Jabon zote rosa grande	None	42	58	8.00	10.50	100	10	2025-04-06 00:00:00
3311	Jabon zote blanco chico	None	42	58	8.00	10.50	100	10	2025-04-06 00:00:00
3312	Jabon zote blanco grande	None	42	58	8.00	10.50	100	10	2025-04-06 00:00:00
3313	Pepsi	bebida azucarada	31	14	8.00	16.00	77	20	2025-04-13 00:00:00
3314	Manzanita		31	14	17.00	25.00	22	3	2025-04-13 00:00:00
3315	MaruchanTokyo	maruchan picante	2	11	5.50	12.50	15	10	2025-04-13 00:00:00
3316	Harina de maiz maseca	None	10	59	8.00	10.50	100	10	2025-04-13 00:00:00
3317	Sabritas	Sabritas Flamin Hot	9	3	10.00	18.00	4	1	2025-04-13 00:00:00
3318	Galletas marias	Las galletas clasicas	9	3	8.90	15.00	19	2	2025-04-13 00:00:00
3319	Leche entera lala 1lt	Clasica color roja	15	4	15.24	25.00	11	3	2025-04-13 00:00:00
3320	Leche Lala entera 1L	Leche Lala entera 1 Litro	15	4	19.00	24.00	100	10	2025-04-13 00:00:00
3321	Tostadas charras	None	5	60	8.00	10.50	100	10	2025-04-13 00:00:00
3322	Leche Lala light 1L	Leche Lala light 1 Litro	15	4	20.00	25.00	100	10	2025-04-13 00:00:00
3323	Leche Santa Clara entera 1L	Leche Santa Clara entera 1 Litro	15	4	22.00	28.00	100	10	2025-04-13 00:00:00
3324	Leche Santa Clara deslactosada 1L	Leche Santa Clara deslactosada 1 Litro	15	4	23.00	29.00	100	10	2025-04-13 00:00:00
3325	Arroz Mexica 1kg	None	2	59	12.00	16.50	100	10	2025-04-13 00:00:00
3326	Del Valle fruit naranja 600ml	Jugo Del Valle sabor Naranja 600 ml	31	28	10.50	13.50	100	10	2025-04-13 00:00:00
3327	Harina de trigo San antonio	None	10	41	8.00	10.50	100	10	2025-04-13 00:00:00
3328	Tortillas de maiz 1/2 kg	None	10	58	8.00	10.50	100	10	2025-04-13 00:00:00
3329	Pan bimbo blanco chico	None	27	17	8.00	10.50	100	10	2025-04-13 00:00:00
3330	Pan bimbo blanco grande	None	27	17	8.00	10.50	100	10	2025-04-13 00:00:00
3331	Pan bimbo integral chico	None	27	17	8.00	10.50	100	10	2025-04-13 00:00:00
3332	Pan bimbo integral grande	None	27	17	8.00	10.50	100	10	2025-04-13 00:00:00
3333	Rebanadas bimbo	None	27	17	8.00	10.50	100	10	2025-04-13 00:00:00
3334	Chocoroles	None	27	17	8.00	10.50	100	10	2025-04-13 00:00:00
3335	Nito bimbo	None	27	17	8.00	10.50	100	10	2025-04-13 00:00:00
3336	Mantecadas	None	27	17	8.00	10.50	100	10	2025-04-13 00:00:00
3337	Roles de canela con pasas	None	27	17	8.00	10.50	100	10	2025-04-13 00:00:00
3338	Roles de canela glaseados	None	27	17	8.00	10.50	100	10	2025-04-13 00:00:00
3339	Conchas bimbo	None	27	17	8.00	10.50	100	10	2025-04-13 00:00:00
3340	Panque de nuez bimbo	None	27	17	8.00	10.50	100	10	2025-04-13 00:00:00
3341	Donitas bimbo	None	27	17	8.00	10.50	100	10	2025-04-13 00:00:00
3342	Donitas espolvoreadas bimbo	None	27	17	8.00	10.50	100	10	2025-04-13 00:00:00
3343	chimichangas	chimichangas	23	10	30.00	45.00	15	5	2025-04-13 00:00:00
3344	Coca Cola 1L	Refresco Coca Cola 1 Litro	31	16	12.00	15.00	100	10	2025-04-13 00:00:00
3345	Coca Cola lata 355ml	Refresco Coca Cola 355 ml lata	31	16	8.50	11.00	100	10	2025-04-13 00:00:00
3346	Coca Cola 355ml	Refresco Coca Cola 355 ml	31	16	8.00	10.50	100	10	2025-04-13 00:00:00
3347	Coca Cola 600ml	Refresco Coca Cola 600 ml	31	16	9.00	12.00	100	10	2025-04-13 00:00:00
3348	Coca Cola retornable 1 1/4 lt.	Refresco Coca Cola retornable 1 1/4 lt	31	16	12.50	15.50	100	10	2025-04-13 00:00:00
3349	Coca Cola 2L retornable	Refresco Coca Cola retornable 2 Litros	31	16	19.50	24.00	100	10	2025-04-13 00:00:00
3350	Coca Cola 3L retornable	Refresco Coca Cola retornable 3 Litros	31	16	24.00	30.00	100	10	2025-04-13 00:00:00
3351	Coca Cola Light 600ml	Refresco Coca Cola Light 600 ml	31	16	9.50	12.50	100	10	2025-04-13 00:00:00
3352	Pepsi 600ml	Refresco Pepsi 600 ml	31	14	9.00	12.00	100	10	2025-04-13 00:00:00
3353	Pepsi 1.5L	Refresco Pepsi 1.5 Litros	31	14	12.00	15.50	100	10	2025-04-13 00:00:00
3354	Fanta 600ml	Refresco Fanta 600 ml	31	16	9.00	12.00	100	10	2025-04-13 00:00:00
3355	Fanta 1.5L	Refresco Fanta 1.5 Litros	31	16	12.50	16.00	100	10	2025-04-13 00:00:00
3356	Sprite 600ml	Refresco Sprite 600 ml	31	16	9.00	12.00	100	10	2025-04-13 00:00:00
3357	Sprite 1.5L	Refresco Sprite 1.5 Litros	31	16	12.50	16.00	100	10	2025-04-13 00:00:00
3358	Manzanita 600ml	Refresco Manzanita Sol 600 ml	31	16	9.00	12.00	100	10	2025-04-13 00:00:00
3359	Manzanita 1.5L	Refresco Manzanita Sol 1.5 Litros	31	16	12.50	16.00	100	10	2025-04-13 00:00:00
3360	Fresca 600ml	Refresco Fresca 600 ml	31	16	9.00	12.00	100	10	2025-04-13 00:00:00
3361	Fresca 3L	Refresco Fresca 3 Litros	31	16	24.00	30.00	100	10	2025-04-13 00:00:00
3362	Mirinda 600ml	Refresco Mirinda 600 ml	31	16	9.00	12.00	100	10	2025-04-13 00:00:00
3363	Mirinda 1.5L	Refresco Mirinda 1.5 Litros	31	16	12.50	16.00	100	10	2025-04-13 00:00:00
3364	Tostadas Sanissimo	None	5	61	8.00	10.50	100	10	2025-04-13 00:00:00
3365	Marias gamesa	None	29	46	8.00	10.50	100	10	2025-04-13 00:00:00
3366	Jumex de mango 1L	Jugo Jumex sabor Mango 1 Litro	31	21	16.00	20.00	100	10	2025-04-13 00:00:00
3367	Emperador chocolate	None	29	46	8.00	10.50	100	10	2025-04-13 00:00:00
3368	Emperador nuez	None	29	46	8.00	10.50	100	10	2025-04-13 00:00:00
3369	Emperador vainilla	None	29	46	8.00	10.50	100	10	2025-04-13 00:00:00
3370	Emperador limon	None	29	46	8.00	10.50	100	10	2025-04-13 00:00:00
3371	Jumex de durazno 1L	Jugo Jumex sabor Durazno 1 Litro	31	21	16.00	20.00	100	10	2025-04-13 00:00:00
3372	Jumex de manzana 600ml	Jugo Jumex sabor Manzana 600 ml	31	21	10.00	13.00	100	10	2025-04-13 00:00:00
3373	Roles	Ricos roles de canela caseros	27	13	70.00	100.00	18	10	2025-04-13 00:00:00
3374	Del Valle fruit manzana 600ml	Jugo Del Valle sabor Manzana 600 ml	31	28	10.50	13.50	100	10	2025-04-13 00:00:00
3375	Del Valle fruit guayaba 600ml	Jugo Del Valle sabor Guayaba 600 ml	31	28	10.50	13.50	100	10	2025-04-13 00:00:00
3376	Emperador Senso	None	29	46	8.00	10.50	100	10	2025-04-13 00:00:00
3377	Mamut chico	None	29	46	8.00	10.50	100	10	2025-04-13 00:00:00
3378	Yogurt Lala natural 1L	Yogurt Lala natural 1 Litro	17	4	25.00	30.00	100	10	2025-04-13 00:00:00
3379	Yogurt Lala de fresa 1L	Yogurt Lala sabor Fresa 1 Litro	17	4	25.00	30.00	100	10	2025-04-13 00:00:00
3380	Yogurt Yoplait de fresa 1L	Yogurt Yoplait sabor Fresa 1 Litro	17	54	26.00	31.00	100	10	2025-04-13 00:00:00
3381	Mantequilla Lala 250g	Mantequilla Lala 250 gramos	19	4	30.00	38.00	100	10	2025-04-13 00:00:00
3382	Queso panela Lala 200g	Queso panela Lala 200 gramos	16	4	40.00	50.00	100	10	2025-04-13 00:00:00
3383	Mamut grande	None	29	46	8.00	10.50	100	10	2025-04-13 00:00:00
3384	Chokis	None	29	46	8.00	10.50	100	10	2025-04-13 00:00:00
3385	Chokis rellenas	None	29	46	8.00	10.50	100	10	2025-04-13 00:00:00
3386	Chokis doble chocolate	None	29	46	8.00	10.50	100	10	2025-04-13 00:00:00
3387	Chokis brownie	None	29	46	8.00	10.50	100	10	2025-04-13 00:00:00
3388	Leche Lala deslactosada 1L	Leche Lala deslactosada 1 Litro	15	4	20.00	25.00	100	10	2025-04-13 00:00:00
3389	Queso panela Alpura 200g	Queso panela Alpura 200 gramos	16	18	40.00	50.00	100	10	2025-04-13 00:00:00
3390	Queso oaxaca Lala 200g	Queso Oaxaca Lala 200 gramos	16	4	45.00	55.00	100	10	2025-04-13 00:00:00
3391	Queso manchego Lala 200g	Queso Manchego Lala 200 gramos	16	4	50.00	60.00	100	10	2025-04-13 00:00:00
3392	Salchichas Fud paquete 500g	Salchichas Fud 500 gramos	18	53	30.00	40.00	100	10	2025-04-13 00:00:00
3393	Salchichas San Rafael paquete 500g	Salchichas San Rafael 500 gramos	18	52	35.00	45.00	100	10	2025-04-13 00:00:00
3394	Sidral mundet 600ml	Refresco de manzana de 600ml	31	16	10.00	16.00	20	5	2025-04-13 00:00:00
3395	Sidral mundet 3lt	Refresco de manzana de 3lt	31	16	24.00	30.00	20	5	2025-04-13 00:00:00
3396	Agua bonafont 600ml	None	30	55	8.00	10.50	100	10	2025-04-13 00:00:00
3397	Agua bonafont 1lt	None	30	55	12.00	15.00	100	10	2025-04-13 00:00:00
3398	Agua bonafont 2lt.	None	30	55	14.00	18.00	100	10	2025-04-13 00:00:00
3399	Garrafon bonafont 20lt	None	30	55	19.50	24.00	100	10	2025-04-13 00:00:00
3400	Agua ciel 600ml	None	30	16	8.00	13.00	100	10	2025-04-13 00:00:00
3401	Agua ciel 1lt	None	30	16	10.00	15.00	100	10	2025-04-13 00:00:00
3402	Agua ciel 1.5l	None	30	16	12.00	17.00	100	10	2025-04-13 00:00:00
3403	Agua ciel 2lt	None	30	16	14.00	20.00	100	10	2025-04-13 00:00:00
3404	Agua E-pura 600ml	None	30	14	8.00	13.00	100	10	2025-04-13 00:00:00
3405	Agua E-pura 1lt	None	30	14	10.00	15.00	100	10	2025-04-13 00:00:00
3406	Garrafon E-pura 10lt	None	30	14	18.00	25.00	100	10	2025-04-13 00:00:00
3407	Crema Lala 200ml	None	15	4	8.00	13.00	100	10	2025-04-13 00:00:00
3408	Crema Lala 426ml	None	15	4	15.00	30.00	100	10	2025-04-13 00:00:00
3409	Crema Lala 900ml	None	15	4	35.00	55.00	100	10	2025-04-13 00:00:00
3410	Crema alpura 200ml	None	15	4	8.00	13.00	100	10	2025-04-13 00:00:00
3411	Crema alpura 426ml	None	15	4	15.00	30.00	100	10	2025-04-13 00:00:00
3412	Crema alpura 900ml	None	15	4	35.00	55.00	100	10	2025-04-13 00:00:00
3413	Atun dolores en agua	None	6	51	10.00	15.00	100	10	2025-04-13 00:00:00
3414	Atun dolores en aceite	None	6	51	12.00	17.00	100	10	2025-04-13 00:00:00
3415	Sardinas en aceite	None	6	20	10.00	15.00	100	10	2025-04-13 00:00:00
3416	Frijoles refritos	None	6	50	10.00	15.00	100	10	2025-04-13 00:00:00
3417	Frijoles bayos	None	6	50	10.00	15.00	100	10	2025-04-13 00:00:00
3418	Pasta la moderna	None	2	44	10.00	15.00	100	10	2025-04-13 00:00:00
3419	Coditos la moderna	None	2	44	10.00	15.00	100	10	2025-04-13 00:00:00
3420	Pasta Barilla espagueti	None	2	56	10.00	15.00	100	10	2025-04-13 00:00:00
3421	Sopa de letras la moderna	None	2	44	10.00	15.00	100	10	2025-04-13 00:00:00
3422	Sopa maruchan pollo	None	2	57	10.00	15.00	100	10	2025-04-13 00:00:00
3423	Sopa maruchan camaron	None	2	57	10.00	15.00	100	10	2025-04-13 00:00:00
3424	Sopa maruchan res	None	2	57	10.00	15.00	100	10	2025-04-13 00:00:00
3425	Sopa maruchan habanero	None	2	57	10.00	15.00	100	10	2025-04-13 00:00:00
3426	Sopa maruchan piquin	None	2	57	10.00	15.00	100	10	2025-04-13 00:00:00
3427	Sopa maruchan limon	None	2	57	10.00	15.00	100	10	2025-04-13 00:00:00
3428	Lentejas la moderna	None	2	44	10.00	15.00	100	10	2025-04-13 00:00:00
3429	Jamon de pavo Fud 250g	Jamon de Pavo Fud 250 gramos	18	53	35.00	45.00	100	10	2025-04-13 00:00:00
3430	Jamon de pavo San Rafael 250g	Jamon de Pavo San Rafael 250 gramos	18	52	40.00	50.00	100	10	2025-04-13 00:00:00
3431	Cremax chocolate	None	29	46	8.00	10.50	100	10	2025-04-13 00:00:00
3432	Cremax fresa	None	29	46	8.00	10.50	100	10	2025-04-13 00:00:00
3433	Florentinas gamesa	None	29	46	8.00	10.50	100	10	2025-04-13 00:00:00
3434	Marias doradas	None	29	46	8.00	10.50	100	10	2025-04-13 00:00:00
3435	Gamesa cajeta	None	29	46	8.00	10.50	100	10	2025-04-13 00:00:00
3436	Maravillas gamesa	None	29	46	8.00	10.50	100	10	2025-04-13 00:00:00
3437	Crackets gamesa	None	29	46	8.00	10.50	100	10	2025-04-13 00:00:00
3438	Surtido rico gamesa	None	29	46	8.00	10.50	100	10	2025-04-13 00:00:00
3439	Delicias gamesa	None	29	46	8.00	10.50	100	10	2025-04-13 00:00:00
3440	Oreo	None	9	58	8.00	10.50	100	10	2025-04-13 00:00:00
3441	Principe chocolate	None	9	22	8.00	10.50	100	10	2025-04-13 00:00:00
3442	Principe vainilla	None	9	22	8.00	10.50	100	10	2025-04-13 00:00:00
3443	Principe limon	None	9	22	8.00	10.50	100	10	2025-04-13 00:00:00
3444	Principe chocolate blanco	None	9	22	8.00	10.50	100	10	2025-04-13 00:00:00
3445	Lors	None	9	22	8.00	10.50	100	10	2025-04-13 00:00:00
3446	Plativolos	None	9	22	8.00	10.50	100	10	2025-04-13 00:00:00
3447	Sponch	None	9	22	8.00	10.50	100	10	2025-04-13 00:00:00
3448	Triki trakes	None	9	22	8.00	10.50	100	10	2025-04-13 00:00:00
3449	MaxiTubo Triki trakes	None	9	22	8.00	10.50	100	10	2025-04-13 00:00:00
3450	Gansito	None	9	22	8.00	10.50	100	10	2025-04-13 00:00:00
3451	Pinguinos	None	9	22	8.00	10.50	100	10	2025-04-13 00:00:00
3452	Pasticetas marinela	None	9	22	8.00	10.50	100	10	2025-04-13 00:00:00
3453	Barritas fresa	None	9	22	8.00	10.50	100	10	2025-04-13 00:00:00
3454	Barritas pina	None	9	22	8.00	10.50	100	10	2025-04-13 00:00:00
3455	Barritas moras	None	9	22	8.00	10.50	100	10	2025-04-13 00:00:00
3456	Maxitubo Barritas pina	None	9	22	8.00	10.50	100	10	2025-04-13 00:00:00
3457	Canelitas	None	9	22	8.00	10.50	100	10	2025-04-13 00:00:00
3458	Polvorones	None	9	22	8.00	10.50	100	10	2025-04-13 00:00:00
3459	Maxitubo Polvorones	None	9	22	8.00	10.50	100	10	2025-04-13 00:00:00
3460	Ricanelas	None	9	46	8.00	10.50	100	10	2025-04-13 00:00:00
3461	Ritz bits queso	None	9	58	8.00	10.50	100	10	2025-04-13 00:00:00
3462	Arcoiris	None	9	46	8.00	10.50	100	10	2025-04-13 00:00:00
3463	Submarinos fresa	None	9	22	8.00	10.50	100	10	2025-04-13 00:00:00
3464	Submarinos vainilla	None	9	22	8.00	10.50	100	10	2025-04-13 00:00:00
3465	Submarinos chocolate	None	9	22	8.00	10.50	100	10	2025-04-13 00:00:00
3466	Rocko chico	None	9	22	8.00	10.50	100	10	2025-04-13 00:00:00
3467	Rocko grande	None	9	22	8.00	10.50	100	10	2025-04-13 00:00:00
3468	Sabritas original	None	9	3	8.00	10.50	100	10	2025-04-13 00:00:00
3469	Sabritas adobadas	None	9	3	8.00	10.50	100	10	2025-04-13 00:00:00
3470	Sabritas limon	None	9	3	8.00	10.50	100	10	2025-04-13 00:00:00
3471	Sabritas flamin hot	None	9	3	8.00	10.50	100	10	2025-04-13 00:00:00
3472	Sabritas crema y especias	None	9	3	8.00	10.50	100	10	2025-04-13 00:00:00
3473	Sabritas habanero	None	9	3	8.00	10.50	100	10	2025-04-13 00:00:00
3474	Sabritas receta crujiente	None	9	3	8.00	10.50	100	10	2025-04-13 00:00:00
3475	Chips jalapeno	None	9	47	8.00	10.50	100	10	2025-04-13 00:00:00
3476	Crujitos	None	9	3	8.00	10.50	100	10	2025-04-13 00:00:00
3477	Doritos nacho	None	9	3	8.00	10.50	100	10	2025-04-13 00:00:00
3478	Doritos incognita	None	9	3	8.00	10.50	100	10	2025-04-13 00:00:00
3479	Doritos diablo	None	9	3	8.00	10.50	100	10	2025-04-13 00:00:00
3480	Doritos flamin hot	None	9	3	8.00	10.50	100	10	2025-04-13 00:00:00
3481	Doritos dinamita	None	9	3	8.00	10.50	100	10	2025-04-13 00:00:00
3482	Sabritones	None	9	3	8.00	10.50	100	10	2025-04-13 00:00:00
3483	Bigmix queso	None	9	47	8.00	10.50	100	10	2025-04-13 00:00:00
3484	Bigmix fuego	None	9	47	8.00	10.50	100	10	2025-04-13 00:00:00
3485	Cheetos torciditos	None	9	3	8.00	10.50	100	10	2025-04-13 00:00:00
3486	Cheetos bolitas	None	9	3	8.00	10.50	100	10	2025-04-13 00:00:00
3487	Cheetos queso	None	9	3	8.00	10.50	100	10	2025-04-13 00:00:00
3488	Cheetos flamin hot	None	9	3	8.00	10.50	100	10	2025-04-13 00:00:00
3489	Ruffles original	None	9	3	8.00	10.50	100	10	2025-04-13 00:00:00
3490	Ruffles queso	None	9	3	8.00	10.50	100	10	2025-04-13 00:00:00
3491	Fritos sal y limon	None	9	3	8.00	10.50	100	10	2025-04-13 00:00:00
3492	Fritos chorizo	None	9	3	8.00	10.50	100	10	2025-04-13 00:00:00
3493	Bolsaza Sabritas original	None	9	3	8.00	10.50	100	10	2025-04-13 00:00:00
3494	Bolsaza Doritos nacho	None	9	3	8.00	10.50	100	10	2025-04-13 00:00:00
3495	Paketaxo	None	9	3	8.00	10.50	100	10	2025-04-13 00:00:00
3496	Paketaxo queso	None	9	3	8.00	10.50	100	10	2025-04-13 00:00:00
3497	Paketaxo flamin hot	None	9	3	8.00	10.50	100	10	2025-04-13 00:00:00
3498	Churrumaiz	None	9	3	8.00	10.50	100	10	2025-04-13 00:00:00
3499	Churrumaiz flamin hot	None	9	3	8.00	10.50	100	10	2025-04-13 00:00:00
3500	Rancheritos	None	9	3	8.00	10.50	100	10	2025-04-13 00:00:00
3501	Sabritas switch doritos nacho	None	9	3	8.00	10.50	100	10	2025-04-13 00:00:00
3502	Runners	None	9	47	8.00	10.50	100	10	2025-04-13 00:00:00
3503	Chips sal	None	9	47	8.00	10.50	100	10	2025-04-13 00:00:00
3504	Papatinas	None	9	47	8.00	10.50	100	10	2025-04-13 00:00:00
3505	Chips fuego	None	9	47	8.00	10.50	100	10	2025-04-13 00:00:00
3506	Palomitas pop	None	9	47	8.00	10.50	100	10	2025-04-13 00:00:00
3507	Takis original 	None	9	47	8.00	10.50	100	10	2025-04-13 00:00:00
3508	Takis fuego	None	9	47	8.00	10.50	100	10	2025-04-13 00:00:00
3509	Takis salsa brava	None	9	47	8.00	10.50	100	10	2025-04-13 00:00:00
3510	Takis guacamole	None	9	47	8.00	10.50	100	10	2025-04-13 00:00:00
3511	Chipotles	None	9	47	8.00	10.50	100	10	2025-04-13 00:00:00
3512	Tostachos	None	9	47	8.00	10.50	100	10	2025-04-13 00:00:00
3513	Hot nuts	None	9	47	8.00	10.50	100	10	2025-04-13 00:00:00
3514	Hot nuts fuego	None	9	47	8.00	10.50	100	10	2025-04-13 00:00:00
3515	Valentones	None	9	47	8.00	10.50	100	10	2025-04-13 00:00:00
3516	Watz barcel	None	9	47	8.00	10.50	100	10	2025-04-13 00:00:00
3517	Toreadas	None	9	47	8.00	10.50	100	10	2025-04-13 00:00:00
3518	Palomitas pop fuego	None	9	47	8.00	10.50	100	10	2025-04-13 00:00:00
3519	Takis blue heat	None	9	47	8.00	10.50	100	10	2025-04-13 00:00:00
3520	Doraditas tia rosa	None	29	49	8.00	10.50	100	10	2025-04-13 00:00:00
3521	Sabritas receta crujiente jalapeno	None	9	3	8.00	10.50	100	10	2025-04-13 00:00:00
3522	Tortillinas tia rosa	None	10	49	8.00	10.50	100	10	2025-04-13 00:00:00
3523	Conchas tia rosa	None	29	49	8.00	10.50	100	10	2025-04-13 00:00:00
3524	Hersheys Cookies n Cream	None	8	45	8.00	10.50	100	10	2025-04-13 00:00:00
3525	Hersheys almendras	None	8	45	8.00	10.50	100	10	2025-04-13 00:00:00
3526	Hersheys chocolate amargo	None	8	45	8.00	10.50	100	10	2025-04-13 00:00:00
3527	Hersheys chocolate blanco	None	8	45	8.00	10.50	100	10	2025-04-13 00:00:00
3528	Crunch	None	8	19	8.00	10.50	100	10	2025-04-13 00:00:00
3529	Carlos V	None	8	19	8.00	10.50	100	10	2025-04-13 00:00:00
3530	Milky way	None	8	19	8.00	10.50	100	10	2025-04-13 00:00:00
3531	Snickers	None	8	19	8.00	10.50	100	10	2025-04-13 00:00:00
3532	Kit kat	None	8	19	8.00	10.50	100	10	2025-04-13 00:00:00
3533	Kinder delice	None	8	40	8.00	10.50	100	10	2025-04-13 00:00:00
3534	Kinder sorpresa	None	8	40	8.00	10.50	100	10	2025-04-13 00:00:00
3535	Ferrero rocher 3 piezas	None	8	40	8.00	10.50	100	10	2025-04-13 00:00:00
3536	Mazapan	None	8	62	8.00	10.50	100	10	2025-04-13 00:00:00
3537	Pelon pelo rico	None	8	45	8.00	10.50	100	10	2025-04-13 00:00:00
3538	Pulparindo tamarindo	None	8	62	8.00	10.50	100	10	2025-04-13 00:00:00
3539	Pulparindo chamoy	None	8	62	8.00	10.50	100	10	2025-04-13 00:00:00
3540	Tutsi pop	None	8	65	8.00	10.50	100	10	2025-04-13 00:00:00
3541	Oblea cajeta coronado	None	8	66	8.00	10.50	100	10	2025-04-13 00:00:00
3542	Paleta payaso	None	8	67	8.00	10.50	100	10	2025-04-13 00:00:00
3543	Duvalin fresa vainilla	None	8	67	8.00	10.50	100	10	2025-04-13 00:00:00
3544	Duvalin chocolate vainilla	None	8	67	8.00	10.50	100	10	2025-04-13 00:00:00
3545	Duvalin vainilla	None	8	67	8.00	10.50	100	10	2025-04-13 00:00:00
3546	Duvalin trisabor	None	8	67	8.00	10.50	100	10	2025-04-13 00:00:00
3547	Duvalin choco avellana	None	8	67	8.00	10.50	100	10	2025-04-13 00:00:00
3548	Paleta Vero mango	None	8	68	8.00	10.50	100	10	2025-04-13 00:00:00
3549	Paleta Vero elote	None	8	67	8.00	10.50	100	10	2025-04-13 00:00:00
3550	Panditas	None	8	67	8.00	10.50	100	10	2025-04-13 00:00:00
3551	Panditas rellenos	None	8	67	8.00	10.50	100	10	2025-04-13 00:00:00
3552	Panditas san valentin	None	8	67	8.00	10.50	100	10	2025-04-13 00:00:00
3553	Bubulubu	None	8	67	8.00	10.50	100	10	2025-04-13 00:00:00
3554	Rockaleta	None	8	69	8.00	10.50	100	10	2025-04-13 00:00:00
3555	Tic tac menta	None	8	40	8.00	10.50	100	10	2025-04-13 00:00:00
3556	Halls menta	None	8	58	8.00	10.50	100	10	2025-04-13 00:00:00
3557	Halls limon	None	8	58	8.00	10.50	100	10	2025-04-13 00:00:00
3558	Halls yerba buena	None	8	58	8.00	10.50	100	10	2025-04-13 00:00:00
3559	Halls miel	None	8	58	8.00	10.50	100	10	2025-04-13 00:00:00
3560	Halls negras	None	8	58	8.00	10.50	100	10	2025-04-13 00:00:00
3561	Gomilocas dientes	None	8	67	8.00	10.50	100	10	2025-04-13 00:00:00
3562	Gomilocas pinguino	None	8	67	8.00	10.50	100	10	2025-04-13 00:00:00
3563	Chocoretas	None	8	67	8.00	10.50	100	10	2025-04-13 00:00:00
3564	Kranky	None	8	67	8.00	10.50	100	10	2025-04-13 00:00:00
3565	Lucas muecas	None	8	58	8.00	10.50	100	10	2025-04-13 00:00:00
3566	Lucas chamoy	None	8	58	8.00	10.50	100	10	2025-04-13 00:00:00
3567	Lucas gusanito	None	8	58	8.00	10.50	100	10	2025-04-13 00:00:00
3568	Palomitas Act II mantequilla	None	9	58	8.00	10.50	100	10	2025-04-13 00:00:00
3569	Palomitas Act II natural	None	9	58	8.00	10.50	100	10	2025-04-13 00:00:00
3570	Palomitas Act II chile limon	None	9	58	8.00	10.50	100	10	2025-04-13 00:00:00
3571	Tostitos salsa verde	None	9	3	8.00	10.50	100	10	2025-04-13 00:00:00
3572	Zucaritas chicas	None	5	26	8.00	10.50	100	10	2025-04-13 00:00:00
3573	Zucaritas grandes	None	5	26	8.00	10.50	100	10	2025-04-13 00:00:00
3574	Corn flakes chicas	None	5	26	8.00	10.50	100	10	2025-04-13 00:00:00
3575	Corn flakes grandes	None	5	26	8.00	10.50	100	10	2025-04-13 00:00:00
3576	Choco Krispis chicas	None	5	26	8.00	10.50	100	10	2025-04-13 00:00:00
3577	Choco Krispis grandes	None	5	26	8.00	10.50	100	10	2025-04-13 00:00:00
3578	Nesquik chico	None	5	26	8.00	10.50	100	10	2025-04-13 00:00:00
3579	Nesquik grande	None	5	26	8.00	10.50	100	10	2025-04-13 00:00:00
3580	Froot loops chicas	None	5	26	8.00	10.50	100	10	2025-04-13 00:00:00
3581	Froot loops grandes	None	5	26	8.00	10.50	100	10	2025-04-13 00:00:00
3582	Chocomilk sobre	None	4	58	8.00	10.50	100	10	2025-04-13 00:00:00
3583	Chocomilk bolsa	None	4	58	8.00	10.50	100	10	2025-04-13 00:00:00
3584	Chocomilk lata	None	4	58	8.00	10.50	100	10	2025-04-13 00:00:00
3585	Nescafe clasico sobre	None	4	19	8.00	10.50	100	10	2025-04-13 00:00:00
3586	Nescafe capuccino sobre	None	4	19	8.00	10.50	100	10	2025-04-13 00:00:00
3587	Nescafe clasico bote chico	None	4	19	8.00	10.50	100	10	2025-04-13 00:00:00
3588	Nescafe clasico bote grande	None	4	19	8.00	10.50	100	10	2025-04-13 00:00:00
3589	Azucar Zulka 1kg	None	3	58	8.00	10.50	100	10	2025-04-13 00:00:00
3590	Azucar refinada 1kg	None	3	58	8.00	10.50	100	10	2025-04-13 00:00:00
3591	Azucar refinada 500gr	None	3	58	8.00	10.50	100	10	2025-04-13 00:00:00
3592	Azucar refinada 250gr	None	3	58	8.00	10.50	100	10	2025-04-13 00:00:00
3593	Aceite nutrioli 1lt	None	1	58	8.00	10.50	100	10	2025-04-13 00:00:00
3594	Aceite capullo 1lt	None	1	58	8.00	10.50	100	10	2025-04-13 00:00:00
3595	Aceite 1 2 3 1lt	None	1	58	8.00	10.50	100	10	2025-04-13 00:00:00
3596	Aceite patrona 1lt	None	1	58	8.00	10.50	100	10	2025-04-13 00:00:00
3597	Vinagre blanco la coste¤a	None	1	27	8.00	10.50	100	10	2025-04-13 00:00:00
3598	Vinagre de manzana la coste¤a	None	1	27	8.00	10.50	100	10	2025-04-13 00:00:00
3599	Catsup la coste¤a	None	1	27	8.00	10.50	100	10	2025-04-13 00:00:00
3600	Catsup Del monte	None	1	70	8.00	10.50	100	10	2025-04-13 00:00:00
3601	Catsup heinz	None	1	71	8.00	10.50	100	10	2025-04-13 00:00:00
3602	Jugo Magui	None	7	19	8.00	10.50	100	10	2025-04-13 00:00:00
3603	Salsa inglesa	None	7	19	8.00	10.50	100	10	2025-04-13 00:00:00
3604	Salsa valentina chica	None	7	58	8.00	10.50	100	10	2025-04-13 00:00:00
3605	Salsa valentina grande	None	7	58	8.00	10.50	100	10	2025-04-13 00:00:00
3606	Salsa tabasco	None	7	58	8.00	10.50	100	10	2025-04-13 00:00:00
3607	Salsa buffalo	None	7	58	8.00	10.50	100	10	2025-04-13 00:00:00
3608	Salsa chipotle la coste¤a	None	7	27	8.00	10.50	100	10	2025-04-13 00:00:00
3609	Chile chipotle la coste¤a	None	6	27	8.00	10.50	100	10	2025-04-13 00:00:00
3610	Tic tac naranja	None	8	40	8.00	10.50	100	10	2025-04-13 00:00:00
3611	Yogurt Yoplait natural 1L	Yogurt Yoplait natural 1 Litro	17	54	26.00	31.00	100	10	2025-04-13 00:00:00
3612	Cremax vainilla	None	29	46	8.00	10.50	100	10	2025-04-13 00:00:00
3613	Maxitubo Barritas fresa	None	9	22	8.00	10.50	100	10	2025-04-13 00:00:00
3614	Bigote tia rosa	None	29	49	8.00	10.50	100	10	2025-04-13 00:00:00
3615	Magdalenas tia rosa	None	29	49	8.00	10.50	100	10	2025-04-13 00:00:00
3616	Chiles serranos la coste¤a	None	6	27	8.00	10.50	100	10	2025-04-13 00:00:00
3617	Chiles en vinagre la coste¤a	None	6	27	8.00	10.50	100	10	2025-04-13 00:00:00
3618	Chile chipotle la morena	None	6	72	8.00	10.50	100	10	2025-04-13 00:00:00
3619	Chiles en vinagre la morena	None	6	72	8.00	10.50	100	10	2025-04-13 00:00:00
3620	Mayonesa mccormick chica	None	7	72	8.00	10.50	100	10	2025-04-13 00:00:00
3621	Mayonesa mccormick grande	None	7	72	8.00	10.50	100	10	2025-04-13 00:00:00
3622	Mostaza mccormick	None	7	72	8.00	10.50	100	10	2025-04-13 00:00:00
3623	Mermelada mccormick fresa chica	None	19	72	8.00	10.50	100	10	2025-04-13 00:00:00
3624	Mermelada mccormick fresa grande	None	19	72	8.00	10.50	100	10	2025-04-13 00:00:00
3625	Cloralex 1/2 lt	None	35	58	8.00	10.50	100	10	2025-04-13 00:00:00
3626	Cloralex 1 lt	None	35	58	8.00	10.50	100	10	2025-04-13 00:00:00
3627	Pinol	None	35	58	8.00	10.50	100	10	2025-04-13 00:00:00
3628	Fabuloso lavanda 1lt	None	35	58	8.00	10.50	100	10	2025-04-13 00:00:00
3629	Fabuloso aroma floral 1lt	None	35	58	8.00	10.50	100	10	2025-04-13 00:00:00
3630	Detergente Ariel 1/2 kg	None	34	58	8.00	10.50	100	10	2025-04-13 00:00:00
3631	Detergente Ariel 1kg	None	34	58	8.00	10.50	100	10	2025-04-13 00:00:00
3632	Detergente Ace 1/2 kg	None	34	58	8.00	10.50	100	10	2025-04-13 00:00:00
3633	Detergente Ace 1kg	None	34	58	8.00	10.50	100	10	2025-04-13 00:00:00
3634	Detergente Foca 1/2 kg	None	34	58	8.00	10.50	100	10	2025-04-13 00:00:00
3635	Detergente Foca 1kg	None	34	58	8.00	10.50	100	10	2025-04-13 00:00:00
3636	Suavitel 1l	None	34	58	8.00	10.50	100	10	2025-04-13 00:00:00
3637	Papel higienico Petalo 4 rollos	None	37	58	8.00	10.50	100	10	2025-04-13 00:00:00
3638	Papel higienico Petalo 6 rollos	None	37	58	8.00	10.50	100	10	2025-04-13 00:00:00
3639	Papel higienico Suavel 4 rollos	None	37	58	8.00	10.50	100	10	2025-04-13 00:00:00
3640	Papel higienico Suavel 6 rollos	None	37	58	8.00	10.50	100	10	2025-04-13 00:00:00
3641	Toallas sanitarias Always	None	37	58	8.00	10.50	100	10	2025-04-13 00:00:00
3642	Toallas sanitarias Kotex	None	37	58	8.00	10.50	100	10	2025-04-13 00:00:00
3643	Panales Huggies	None	44	58	8.00	10.50	100	10	2025-04-13 00:00:00
3644	Shampoo Head & Shoulders chico	None	39	58	8.00	10.50	100	10	2025-04-13 00:00:00
3645	Shampoo Head & Shoulders grande	None	39	58	8.00	10.50	100	10	2025-04-13 00:00:00
3646	Desodorante Axe	None	41	58	8.00	10.50	100	10	2025-04-13 00:00:00
3647	Leche deslactosada 1lt	Presentacion azul	15	4	18.20	23.00	14	2	2025-04-13 00:00:00
3648	Yomi lala chocolate	None	15	4	15.00	30.00	100	10	2025-04-13 00:00:00
3649	Yomi lala vainilla	None	15	4	15.00	30.00	100	10	2025-04-13 00:00:00
3650	Yomi lala fresa	None	15	4	15.00	30.00	100	10	2025-04-13 00:00:00
3651	Yogurt lala fresa	None	15	4	15.00	30.00	100	10	2025-04-13 00:00:00
3652	Yogurt lala durazno	None	15	4	15.00	30.00	100	10	2025-04-13 00:00:00
3653	Yogurt lala manzana	None	15	4	15.00	30.00	100	10	2025-04-13 00:00:00
3654	Yogurt bebible lala manzana	None	15	4	15.00	30.00	100	10	2025-04-13 00:00:00
3655	Yogurt bebible lala durazno	None	15	4	15.00	30.00	100	10	2025-04-13 00:00:00
3656	Yogurt bebible lala fresa	None	15	4	15.00	30.00	100	10	2025-04-13 00:00:00
3657	Yogurt bebible lala moras	None	15	4	15.00	30.00	100	10	2025-04-13 00:00:00
3658	Yogurt bebible lala pina coco	None	15	4	15.00	30.00	100	10	2025-04-13 00:00:00
3659	Licuado lala fresa platano	None	15	4	15.00	30.00	100	10	2025-04-13 00:00:00
3660	Licuado lala nuez	None	15	4	15.00	30.00	100	10	2025-04-13 00:00:00
3661	Flan lala	None	15	4	15.00	30.00	100	10	2025-04-13 00:00:00
3662	Margarina lala 90gr	None	15	4	15.00	30.00	100	10	2025-04-13 00:00:00
3663	Jabon zote rosa chico	None	42	58	8.00	10.50	100	10	2025-04-13 00:00:00
3664	Jabon zote rosa grande	None	42	58	8.00	10.50	100	10	2025-04-13 00:00:00
3665	Jabon zote blanco chico	None	42	58	8.00	10.50	100	10	2025-04-13 00:00:00
3666	Jabon zote blanco grande	None	42	58	8.00	10.50	100	10	2025-04-13 00:00:00
3667	Leche entera lala 1lt	Clasica color roja	15	4	15.24	25.00	2	3	2025-04-15 00:00:00
3668	Pepsi	bebida azucarada	31	14	8.00	16.00	77	20	2025-04-15 00:00:00
3669	Manzanita		31	14	17.00	25.00	22	3	2025-04-15 00:00:00
3670	MaruchanTokyo	maruchan picante	2	11	5.50	12.50	15	10	2025-04-15 00:00:00
3671	Harina de maiz maseca	None	10	59	8.00	10.50	100	10	2025-04-15 00:00:00
3672	Sabritas	Sabritas Flamin Hot	9	3	10.00	18.00	4	1	2025-04-15 00:00:00
3673	Galletas marias	Las galletas clasicas	9	3	8.90	15.00	19	2	2025-04-15 00:00:00
3674	Leche Lala entera 1L	Leche Lala entera 1 Litro	15	4	19.00	24.00	100	10	2025-04-15 00:00:00
3675	Tostadas charras	None	5	60	8.00	10.50	100	10	2025-04-15 00:00:00
3676	Leche Lala light 1L	Leche Lala light 1 Litro	15	4	20.00	25.00	100	10	2025-04-15 00:00:00
3677	Leche Santa Clara entera 1L	Leche Santa Clara entera 1 Litro	15	4	22.00	28.00	100	10	2025-04-15 00:00:00
3678	Leche Santa Clara deslactosada 1L	Leche Santa Clara deslactosada 1 Litro	15	4	23.00	29.00	100	10	2025-04-15 00:00:00
3679	Arroz Mexica 1kg	None	2	59	12.00	16.50	100	10	2025-04-15 00:00:00
3680	Del Valle fruit naranja 600ml	Jugo Del Valle sabor Naranja 600 ml	31	28	10.50	13.50	100	10	2025-04-15 00:00:00
3681	Harina de trigo San antonio	None	10	41	8.00	10.50	100	10	2025-04-15 00:00:00
3682	Tortillas de maiz 1/2 kg	None	10	58	8.00	10.50	100	10	2025-04-15 00:00:00
3683	Pan bimbo blanco chico	None	27	17	8.00	10.50	100	10	2025-04-15 00:00:00
3684	Pan bimbo blanco grande	None	27	17	8.00	10.50	100	10	2025-04-15 00:00:00
3685	Pan bimbo integral chico	None	27	17	8.00	10.50	100	10	2025-04-15 00:00:00
3686	Pan bimbo integral grande	None	27	17	8.00	10.50	100	10	2025-04-15 00:00:00
3687	Rebanadas bimbo	None	27	17	8.00	10.50	100	10	2025-04-15 00:00:00
3688	Chocoroles	None	27	17	8.00	10.50	100	10	2025-04-15 00:00:00
3689	Nito bimbo	None	27	17	8.00	10.50	100	10	2025-04-15 00:00:00
3690	Mantecadas	None	27	17	8.00	10.50	100	10	2025-04-15 00:00:00
3691	Roles de canela con pasas	None	27	17	8.00	10.50	100	10	2025-04-15 00:00:00
3692	Roles de canela glaseados	None	27	17	8.00	10.50	100	10	2025-04-15 00:00:00
3693	Conchas bimbo	None	27	17	8.00	10.50	100	10	2025-04-15 00:00:00
3694	Panque de nuez bimbo	None	27	17	8.00	10.50	100	10	2025-04-15 00:00:00
3695	Donitas bimbo	None	27	17	8.00	10.50	100	10	2025-04-15 00:00:00
3696	Donitas espolvoreadas bimbo	None	27	17	8.00	10.50	100	10	2025-04-15 00:00:00
3697	chimichangas	chimichangas	23	10	30.00	45.00	15	5	2025-04-15 00:00:00
3698	Coca Cola 1L	Refresco Coca Cola 1 Litro	31	16	12.00	15.00	100	10	2025-04-15 00:00:00
3699	Coca Cola lata 355ml	Refresco Coca Cola 355 ml lata	31	16	8.50	11.00	100	10	2025-04-15 00:00:00
3700	Coca Cola 355ml	Refresco Coca Cola 355 ml	31	16	8.00	10.50	100	10	2025-04-15 00:00:00
3701	Coca Cola 600ml	Refresco Coca Cola 600 ml	31	16	9.00	12.00	100	10	2025-04-15 00:00:00
3702	Coca Cola retornable 1 1/4 lt.	Refresco Coca Cola retornable 1 1/4 lt	31	16	12.50	15.50	100	10	2025-04-15 00:00:00
3703	Coca Cola 2L retornable	Refresco Coca Cola retornable 2 Litros	31	16	19.50	24.00	100	10	2025-04-15 00:00:00
3704	Coca Cola 3L retornable	Refresco Coca Cola retornable 3 Litros	31	16	24.00	30.00	100	10	2025-04-15 00:00:00
3705	Coca Cola Light 600ml	Refresco Coca Cola Light 600 ml	31	16	9.50	12.50	100	10	2025-04-15 00:00:00
3706	Pepsi 600ml	Refresco Pepsi 600 ml	31	14	9.00	12.00	100	10	2025-04-15 00:00:00
3707	Pepsi 1.5L	Refresco Pepsi 1.5 Litros	31	14	12.00	15.50	100	10	2025-04-15 00:00:00
3708	Fanta 600ml	Refresco Fanta 600 ml	31	16	9.00	12.00	100	10	2025-04-15 00:00:00
3709	Fanta 1.5L	Refresco Fanta 1.5 Litros	31	16	12.50	16.00	100	10	2025-04-15 00:00:00
3710	Sprite 600ml	Refresco Sprite 600 ml	31	16	9.00	12.00	100	10	2025-04-15 00:00:00
3711	Sprite 1.5L	Refresco Sprite 1.5 Litros	31	16	12.50	16.00	100	10	2025-04-15 00:00:00
3712	Manzanita 600ml	Refresco Manzanita Sol 600 ml	31	16	9.00	12.00	100	10	2025-04-15 00:00:00
3713	Manzanita 1.5L	Refresco Manzanita Sol 1.5 Litros	31	16	12.50	16.00	100	10	2025-04-15 00:00:00
3714	Fresca 600ml	Refresco Fresca 600 ml	31	16	9.00	12.00	100	10	2025-04-15 00:00:00
3715	Fresca 3L	Refresco Fresca 3 Litros	31	16	24.00	30.00	100	10	2025-04-15 00:00:00
3716	Mirinda 600ml	Refresco Mirinda 600 ml	31	16	9.00	12.00	100	10	2025-04-15 00:00:00
3717	Mirinda 1.5L	Refresco Mirinda 1.5 Litros	31	16	12.50	16.00	100	10	2025-04-15 00:00:00
3718	Tostadas Sanissimo	None	5	61	8.00	10.50	100	10	2025-04-15 00:00:00
3719	Marias gamesa	None	29	46	8.00	10.50	100	10	2025-04-15 00:00:00
3720	Jumex de mango 1L	Jugo Jumex sabor Mango 1 Litro	31	21	16.00	20.00	100	10	2025-04-15 00:00:00
3721	Emperador chocolate	None	29	46	8.00	10.50	100	10	2025-04-15 00:00:00
3722	Emperador nuez	None	29	46	8.00	10.50	100	10	2025-04-15 00:00:00
3723	Emperador vainilla	None	29	46	8.00	10.50	100	10	2025-04-15 00:00:00
3724	Emperador limon	None	29	46	8.00	10.50	100	10	2025-04-15 00:00:00
3725	Jumex de durazno 1L	Jugo Jumex sabor Durazno 1 Litro	31	21	16.00	20.00	100	10	2025-04-15 00:00:00
3726	Jumex de manzana 600ml	Jugo Jumex sabor Manzana 600 ml	31	21	10.00	13.00	100	10	2025-04-15 00:00:00
3727	Roles	Ricos roles de canela caseros	27	13	70.00	100.00	18	10	2025-04-15 00:00:00
3728	Del Valle fruit manzana 600ml	Jugo Del Valle sabor Manzana 600 ml	31	28	10.50	13.50	100	10	2025-04-15 00:00:00
3729	Del Valle fruit guayaba 600ml	Jugo Del Valle sabor Guayaba 600 ml	31	28	10.50	13.50	100	10	2025-04-15 00:00:00
3730	Emperador Senso	None	29	46	8.00	10.50	100	10	2025-04-15 00:00:00
3731	Mamut chico	None	29	46	8.00	10.50	100	10	2025-04-15 00:00:00
3732	Yogurt Lala natural 1L	Yogurt Lala natural 1 Litro	17	4	25.00	30.00	100	10	2025-04-15 00:00:00
3733	Yogurt Lala de fresa 1L	Yogurt Lala sabor Fresa 1 Litro	17	4	25.00	30.00	100	10	2025-04-15 00:00:00
3734	Yogurt Yoplait de fresa 1L	Yogurt Yoplait sabor Fresa 1 Litro	17	54	26.00	31.00	100	10	2025-04-15 00:00:00
3735	Mantequilla Lala 250g	Mantequilla Lala 250 gramos	19	4	30.00	38.00	100	10	2025-04-15 00:00:00
3736	Queso panela Lala 200g	Queso panela Lala 200 gramos	16	4	40.00	50.00	100	10	2025-04-15 00:00:00
3737	Mamut grande	None	29	46	8.00	10.50	100	10	2025-04-15 00:00:00
3738	Chokis	None	29	46	8.00	10.50	100	10	2025-04-15 00:00:00
3739	Chokis rellenas	None	29	46	8.00	10.50	100	10	2025-04-15 00:00:00
3740	Chokis doble chocolate	None	29	46	8.00	10.50	100	10	2025-04-15 00:00:00
3741	Chokis brownie	None	29	46	8.00	10.50	100	10	2025-04-15 00:00:00
3742	Leche Lala deslactosada 1L	Leche Lala deslactosada 1 Litro	15	4	20.00	25.00	100	10	2025-04-15 00:00:00
3743	Queso panela Alpura 200g	Queso panela Alpura 200 gramos	16	18	40.00	50.00	100	10	2025-04-15 00:00:00
3744	Queso oaxaca Lala 200g	Queso Oaxaca Lala 200 gramos	16	4	45.00	55.00	100	10	2025-04-15 00:00:00
3745	Queso manchego Lala 200g	Queso Manchego Lala 200 gramos	16	4	50.00	60.00	100	10	2025-04-15 00:00:00
3746	Salchichas Fud paquete 500g	Salchichas Fud 500 gramos	18	53	30.00	40.00	100	10	2025-04-15 00:00:00
3747	Salchichas San Rafael paquete 500g	Salchichas San Rafael 500 gramos	18	52	35.00	45.00	100	10	2025-04-15 00:00:00
3748	Sidral mundet 600ml	Refresco de manzana de 600ml	31	16	10.00	16.00	20	5	2025-04-15 00:00:00
3749	Sidral mundet 3lt	Refresco de manzana de 3lt	31	16	24.00	30.00	20	5	2025-04-15 00:00:00
3750	Agua bonafont 600ml	None	30	55	8.00	10.50	100	10	2025-04-15 00:00:00
3751	Agua bonafont 1lt	None	30	55	12.00	15.00	100	10	2025-04-15 00:00:00
3752	Agua bonafont 2lt.	None	30	55	14.00	18.00	100	10	2025-04-15 00:00:00
3753	Garrafon bonafont 20lt	None	30	55	19.50	24.00	100	10	2025-04-15 00:00:00
3754	Agua ciel 600ml	None	30	16	8.00	13.00	100	10	2025-04-15 00:00:00
3755	Agua ciel 1lt	None	30	16	10.00	15.00	100	10	2025-04-15 00:00:00
3756	Agua ciel 1.5l	None	30	16	12.00	17.00	100	10	2025-04-15 00:00:00
3757	Agua ciel 2lt	None	30	16	14.00	20.00	100	10	2025-04-15 00:00:00
3758	Agua E-pura 600ml	None	30	14	8.00	13.00	100	10	2025-04-15 00:00:00
3759	Agua E-pura 1lt	None	30	14	10.00	15.00	100	10	2025-04-15 00:00:00
3760	Garrafon E-pura 10lt	None	30	14	18.00	25.00	100	10	2025-04-15 00:00:00
3761	Crema Lala 200ml	None	15	4	8.00	13.00	100	10	2025-04-15 00:00:00
3762	Crema Lala 426ml	None	15	4	15.00	30.00	100	10	2025-04-15 00:00:00
3763	Crema Lala 900ml	None	15	4	35.00	55.00	100	10	2025-04-15 00:00:00
3764	Crema alpura 200ml	None	15	4	8.00	13.00	100	10	2025-04-15 00:00:00
3765	Crema alpura 426ml	None	15	4	15.00	30.00	100	10	2025-04-15 00:00:00
3766	Crema alpura 900ml	None	15	4	35.00	55.00	100	10	2025-04-15 00:00:00
3767	Atun dolores en agua	None	6	51	10.00	15.00	100	10	2025-04-15 00:00:00
3768	Atun dolores en aceite	None	6	51	12.00	17.00	100	10	2025-04-15 00:00:00
3769	Sardinas en aceite	None	6	20	10.00	15.00	100	10	2025-04-15 00:00:00
3770	Frijoles refritos	None	6	50	10.00	15.00	100	10	2025-04-15 00:00:00
3771	Frijoles bayos	None	6	50	10.00	15.00	100	10	2025-04-15 00:00:00
3772	Pasta la moderna	None	2	44	10.00	15.00	100	10	2025-04-15 00:00:00
3773	Coditos la moderna	None	2	44	10.00	15.00	100	10	2025-04-15 00:00:00
3774	Pasta Barilla espagueti	None	2	56	10.00	15.00	100	10	2025-04-15 00:00:00
3775	Sopa de letras la moderna	None	2	44	10.00	15.00	100	10	2025-04-15 00:00:00
3776	Sopa maruchan pollo	None	2	57	10.00	15.00	100	10	2025-04-15 00:00:00
3777	Sopa maruchan camaron	None	2	57	10.00	15.00	100	10	2025-04-15 00:00:00
3778	Sopa maruchan res	None	2	57	10.00	15.00	100	10	2025-04-15 00:00:00
3779	Sopa maruchan habanero	None	2	57	10.00	15.00	100	10	2025-04-15 00:00:00
3780	Sopa maruchan piquin	None	2	57	10.00	15.00	100	10	2025-04-15 00:00:00
3781	Sopa maruchan limon	None	2	57	10.00	15.00	100	10	2025-04-15 00:00:00
3782	Lentejas la moderna	None	2	44	10.00	15.00	100	10	2025-04-15 00:00:00
3783	Jamon de pavo Fud 250g	Jamon de Pavo Fud 250 gramos	18	53	35.00	45.00	100	10	2025-04-15 00:00:00
3784	Jamon de pavo San Rafael 250g	Jamon de Pavo San Rafael 250 gramos	18	52	40.00	50.00	100	10	2025-04-15 00:00:00
3785	Cremax chocolate	None	29	46	8.00	10.50	100	10	2025-04-15 00:00:00
3786	Cremax fresa	None	29	46	8.00	10.50	100	10	2025-04-15 00:00:00
3787	Florentinas gamesa	None	29	46	8.00	10.50	100	10	2025-04-15 00:00:00
3788	Marias doradas	None	29	46	8.00	10.50	100	10	2025-04-15 00:00:00
3789	Gamesa cajeta	None	29	46	8.00	10.50	100	10	2025-04-15 00:00:00
3790	Maravillas gamesa	None	29	46	8.00	10.50	100	10	2025-04-15 00:00:00
3791	Crackets gamesa	None	29	46	8.00	10.50	100	10	2025-04-15 00:00:00
3792	Surtido rico gamesa	None	29	46	8.00	10.50	100	10	2025-04-15 00:00:00
3793	Delicias gamesa	None	29	46	8.00	10.50	100	10	2025-04-15 00:00:00
3794	Oreo	None	9	58	8.00	10.50	100	10	2025-04-15 00:00:00
3795	Principe chocolate	None	9	22	8.00	10.50	100	10	2025-04-15 00:00:00
3796	Principe vainilla	None	9	22	8.00	10.50	100	10	2025-04-15 00:00:00
3797	Principe limon	None	9	22	8.00	10.50	100	10	2025-04-15 00:00:00
3798	Principe chocolate blanco	None	9	22	8.00	10.50	100	10	2025-04-15 00:00:00
3799	Lors	None	9	22	8.00	10.50	100	10	2025-04-15 00:00:00
3800	Plativolos	None	9	22	8.00	10.50	100	10	2025-04-15 00:00:00
3801	Sponch	None	9	22	8.00	10.50	100	10	2025-04-15 00:00:00
3802	Triki trakes	None	9	22	8.00	10.50	100	10	2025-04-15 00:00:00
3803	MaxiTubo Triki trakes	None	9	22	8.00	10.50	100	10	2025-04-15 00:00:00
3804	Gansito	None	9	22	8.00	10.50	100	10	2025-04-15 00:00:00
3805	Pinguinos	None	9	22	8.00	10.50	100	10	2025-04-15 00:00:00
3806	Pasticetas marinela	None	9	22	8.00	10.50	100	10	2025-04-15 00:00:00
3807	Barritas fresa	None	9	22	8.00	10.50	100	10	2025-04-15 00:00:00
3808	Barritas pina	None	9	22	8.00	10.50	100	10	2025-04-15 00:00:00
3809	Barritas moras	None	9	22	8.00	10.50	100	10	2025-04-15 00:00:00
3810	Maxitubo Barritas pina	None	9	22	8.00	10.50	100	10	2025-04-15 00:00:00
3811	Canelitas	None	9	22	8.00	10.50	100	10	2025-04-15 00:00:00
3812	Polvorones	None	9	22	8.00	10.50	100	10	2025-04-15 00:00:00
3813	Maxitubo Polvorones	None	9	22	8.00	10.50	100	10	2025-04-15 00:00:00
3814	Ricanelas	None	9	46	8.00	10.50	100	10	2025-04-15 00:00:00
3815	Ritz bits queso	None	9	58	8.00	10.50	100	10	2025-04-15 00:00:00
3816	Arcoiris	None	9	46	8.00	10.50	100	10	2025-04-15 00:00:00
3817	Submarinos fresa	None	9	22	8.00	10.50	100	10	2025-04-15 00:00:00
3818	Submarinos vainilla	None	9	22	8.00	10.50	100	10	2025-04-15 00:00:00
3819	Submarinos chocolate	None	9	22	8.00	10.50	100	10	2025-04-15 00:00:00
3820	Rocko chico	None	9	22	8.00	10.50	100	10	2025-04-15 00:00:00
3821	Rocko grande	None	9	22	8.00	10.50	100	10	2025-04-15 00:00:00
3822	Sabritas original	None	9	3	8.00	10.50	100	10	2025-04-15 00:00:00
3823	Sabritas adobadas	None	9	3	8.00	10.50	100	10	2025-04-15 00:00:00
3824	Sabritas limon	None	9	3	8.00	10.50	100	10	2025-04-15 00:00:00
3825	Sabritas flamin hot	None	9	3	8.00	10.50	100	10	2025-04-15 00:00:00
3826	Sabritas crema y especias	None	9	3	8.00	10.50	100	10	2025-04-15 00:00:00
3827	Sabritas habanero	None	9	3	8.00	10.50	100	10	2025-04-15 00:00:00
3828	Sabritas receta crujiente	None	9	3	8.00	10.50	100	10	2025-04-15 00:00:00
3829	Chips jalapeno	None	9	47	8.00	10.50	100	10	2025-04-15 00:00:00
3830	Crujitos	None	9	3	8.00	10.50	100	10	2025-04-15 00:00:00
3831	Doritos nacho	None	9	3	8.00	10.50	100	10	2025-04-15 00:00:00
3832	Doritos incognita	None	9	3	8.00	10.50	100	10	2025-04-15 00:00:00
3833	Doritos diablo	None	9	3	8.00	10.50	100	10	2025-04-15 00:00:00
3834	Doritos flamin hot	None	9	3	8.00	10.50	100	10	2025-04-15 00:00:00
3835	Doritos dinamita	None	9	3	8.00	10.50	100	10	2025-04-15 00:00:00
3836	Sabritones	None	9	3	8.00	10.50	100	10	2025-04-15 00:00:00
3837	Bigmix queso	None	9	47	8.00	10.50	100	10	2025-04-15 00:00:00
3838	Bigmix fuego	None	9	47	8.00	10.50	100	10	2025-04-15 00:00:00
3839	Cheetos torciditos	None	9	3	8.00	10.50	100	10	2025-04-15 00:00:00
3840	Cheetos bolitas	None	9	3	8.00	10.50	100	10	2025-04-15 00:00:00
3841	Cheetos queso	None	9	3	8.00	10.50	100	10	2025-04-15 00:00:00
3842	Cheetos flamin hot	None	9	3	8.00	10.50	100	10	2025-04-15 00:00:00
3843	Ruffles original	None	9	3	8.00	10.50	100	10	2025-04-15 00:00:00
3844	Ruffles queso	None	9	3	8.00	10.50	100	10	2025-04-15 00:00:00
3845	Fritos sal y limon	None	9	3	8.00	10.50	100	10	2025-04-15 00:00:00
3846	Fritos chorizo	None	9	3	8.00	10.50	100	10	2025-04-15 00:00:00
3847	Bolsaza Sabritas original	None	9	3	8.00	10.50	100	10	2025-04-15 00:00:00
3848	Bolsaza Doritos nacho	None	9	3	8.00	10.50	100	10	2025-04-15 00:00:00
3849	Paketaxo	None	9	3	8.00	10.50	100	10	2025-04-15 00:00:00
3850	Paketaxo queso	None	9	3	8.00	10.50	100	10	2025-04-15 00:00:00
3851	Paketaxo flamin hot	None	9	3	8.00	10.50	100	10	2025-04-15 00:00:00
3852	Churrumaiz	None	9	3	8.00	10.50	100	10	2025-04-15 00:00:00
3853	Churrumaiz flamin hot	None	9	3	8.00	10.50	100	10	2025-04-15 00:00:00
3854	Rancheritos	None	9	3	8.00	10.50	100	10	2025-04-15 00:00:00
3855	Sabritas switch doritos nacho	None	9	3	8.00	10.50	100	10	2025-04-15 00:00:00
3856	Runners	None	9	47	8.00	10.50	100	10	2025-04-15 00:00:00
3857	Chips sal	None	9	47	8.00	10.50	100	10	2025-04-15 00:00:00
3858	Papatinas	None	9	47	8.00	10.50	100	10	2025-04-15 00:00:00
3859	Chips fuego	None	9	47	8.00	10.50	100	10	2025-04-15 00:00:00
3860	Palomitas pop	None	9	47	8.00	10.50	100	10	2025-04-15 00:00:00
3861	Takis original 	None	9	47	8.00	10.50	100	10	2025-04-15 00:00:00
3862	Takis fuego	None	9	47	8.00	10.50	100	10	2025-04-15 00:00:00
3863	Takis salsa brava	None	9	47	8.00	10.50	100	10	2025-04-15 00:00:00
3864	Takis guacamole	None	9	47	8.00	10.50	100	10	2025-04-15 00:00:00
3865	Chipotles	None	9	47	8.00	10.50	100	10	2025-04-15 00:00:00
3866	Tostachos	None	9	47	8.00	10.50	100	10	2025-04-15 00:00:00
3867	Hot nuts	None	9	47	8.00	10.50	100	10	2025-04-15 00:00:00
3868	Hot nuts fuego	None	9	47	8.00	10.50	100	10	2025-04-15 00:00:00
3869	Valentones	None	9	47	8.00	10.50	100	10	2025-04-15 00:00:00
3870	Watz barcel	None	9	47	8.00	10.50	100	10	2025-04-15 00:00:00
3871	Toreadas	None	9	47	8.00	10.50	100	10	2025-04-15 00:00:00
3872	Palomitas pop fuego	None	9	47	8.00	10.50	100	10	2025-04-15 00:00:00
3873	Takis blue heat	None	9	47	8.00	10.50	100	10	2025-04-15 00:00:00
3874	Doraditas tia rosa	None	29	49	8.00	10.50	100	10	2025-04-15 00:00:00
3875	Sabritas receta crujiente jalapeno	None	9	3	8.00	10.50	100	10	2025-04-15 00:00:00
3876	Tortillinas tia rosa	None	10	49	8.00	10.50	100	10	2025-04-15 00:00:00
3877	Conchas tia rosa	None	29	49	8.00	10.50	100	10	2025-04-15 00:00:00
3878	Hersheys Cookies n Cream	None	8	45	8.00	10.50	100	10	2025-04-15 00:00:00
3879	Hersheys almendras	None	8	45	8.00	10.50	100	10	2025-04-15 00:00:00
3880	Hersheys chocolate amargo	None	8	45	8.00	10.50	100	10	2025-04-15 00:00:00
3881	Hersheys chocolate blanco	None	8	45	8.00	10.50	100	10	2025-04-15 00:00:00
3882	Crunch	None	8	19	8.00	10.50	100	10	2025-04-15 00:00:00
3883	Carlos V	None	8	19	8.00	10.50	100	10	2025-04-15 00:00:00
3884	Milky way	None	8	19	8.00	10.50	100	10	2025-04-15 00:00:00
3885	Snickers	None	8	19	8.00	10.50	100	10	2025-04-15 00:00:00
3886	Kit kat	None	8	19	8.00	10.50	100	10	2025-04-15 00:00:00
3887	Kinder delice	None	8	40	8.00	10.50	100	10	2025-04-15 00:00:00
3888	Kinder sorpresa	None	8	40	8.00	10.50	100	10	2025-04-15 00:00:00
3889	Ferrero rocher 3 piezas	None	8	40	8.00	10.50	100	10	2025-04-15 00:00:00
3890	Mazapan	None	8	62	8.00	10.50	100	10	2025-04-15 00:00:00
3891	Pelon pelo rico	None	8	45	8.00	10.50	100	10	2025-04-15 00:00:00
3892	Pulparindo tamarindo	None	8	62	8.00	10.50	100	10	2025-04-15 00:00:00
3893	Pulparindo chamoy	None	8	62	8.00	10.50	100	10	2025-04-15 00:00:00
3894	Tutsi pop	None	8	65	8.00	10.50	100	10	2025-04-15 00:00:00
3895	Oblea cajeta coronado	None	8	66	8.00	10.50	100	10	2025-04-15 00:00:00
3896	Paleta payaso	None	8	67	8.00	10.50	100	10	2025-04-15 00:00:00
3897	Duvalin fresa vainilla	None	8	67	8.00	10.50	100	10	2025-04-15 00:00:00
3898	Duvalin chocolate vainilla	None	8	67	8.00	10.50	100	10	2025-04-15 00:00:00
3899	Duvalin vainilla	None	8	67	8.00	10.50	100	10	2025-04-15 00:00:00
3900	Duvalin trisabor	None	8	67	8.00	10.50	100	10	2025-04-15 00:00:00
3901	Duvalin choco avellana	None	8	67	8.00	10.50	100	10	2025-04-15 00:00:00
3902	Paleta Vero mango	None	8	68	8.00	10.50	100	10	2025-04-15 00:00:00
3903	Paleta Vero elote	None	8	67	8.00	10.50	100	10	2025-04-15 00:00:00
3904	Panditas	None	8	67	8.00	10.50	100	10	2025-04-15 00:00:00
3905	Panditas rellenos	None	8	67	8.00	10.50	100	10	2025-04-15 00:00:00
3906	Panditas san valentin	None	8	67	8.00	10.50	100	10	2025-04-15 00:00:00
3907	Bubulubu	None	8	67	8.00	10.50	100	10	2025-04-15 00:00:00
3908	Rockaleta	None	8	69	8.00	10.50	100	10	2025-04-15 00:00:00
3909	Tic tac menta	None	8	40	8.00	10.50	100	10	2025-04-15 00:00:00
3910	Halls menta	None	8	58	8.00	10.50	100	10	2025-04-15 00:00:00
3911	Halls limon	None	8	58	8.00	10.50	100	10	2025-04-15 00:00:00
3912	Halls yerba buena	None	8	58	8.00	10.50	100	10	2025-04-15 00:00:00
3913	Halls miel	None	8	58	8.00	10.50	100	10	2025-04-15 00:00:00
3914	Halls negras	None	8	58	8.00	10.50	100	10	2025-04-15 00:00:00
3915	Gomilocas dientes	None	8	67	8.00	10.50	100	10	2025-04-15 00:00:00
3916	Gomilocas pinguino	None	8	67	8.00	10.50	100	10	2025-04-15 00:00:00
3917	Chocoretas	None	8	67	8.00	10.50	100	10	2025-04-15 00:00:00
3918	Kranky	None	8	67	8.00	10.50	100	10	2025-04-15 00:00:00
3919	Lucas muecas	None	8	58	8.00	10.50	100	10	2025-04-15 00:00:00
3920	Lucas chamoy	None	8	58	8.00	10.50	100	10	2025-04-15 00:00:00
3921	Lucas gusanito	None	8	58	8.00	10.50	100	10	2025-04-15 00:00:00
3922	Palomitas Act II mantequilla	None	9	58	8.00	10.50	100	10	2025-04-15 00:00:00
3923	Palomitas Act II natural	None	9	58	8.00	10.50	100	10	2025-04-15 00:00:00
3924	Palomitas Act II chile limon	None	9	58	8.00	10.50	100	10	2025-04-15 00:00:00
3925	Tostitos salsa verde	None	9	3	8.00	10.50	100	10	2025-04-15 00:00:00
3926	Zucaritas chicas	None	5	26	8.00	10.50	100	10	2025-04-15 00:00:00
3927	Zucaritas grandes	None	5	26	8.00	10.50	100	10	2025-04-15 00:00:00
3928	Corn flakes chicas	None	5	26	8.00	10.50	100	10	2025-04-15 00:00:00
3929	Corn flakes grandes	None	5	26	8.00	10.50	100	10	2025-04-15 00:00:00
3930	Choco Krispis chicas	None	5	26	8.00	10.50	100	10	2025-04-15 00:00:00
3931	Choco Krispis grandes	None	5	26	8.00	10.50	100	10	2025-04-15 00:00:00
3932	Nesquik chico	None	5	26	8.00	10.50	100	10	2025-04-15 00:00:00
3933	Nesquik grande	None	5	26	8.00	10.50	100	10	2025-04-15 00:00:00
3934	Froot loops chicas	None	5	26	8.00	10.50	100	10	2025-04-15 00:00:00
3935	Froot loops grandes	None	5	26	8.00	10.50	100	10	2025-04-15 00:00:00
3936	Chocomilk sobre	None	4	58	8.00	10.50	100	10	2025-04-15 00:00:00
3937	Chocomilk bolsa	None	4	58	8.00	10.50	100	10	2025-04-15 00:00:00
3938	Chocomilk lata	None	4	58	8.00	10.50	100	10	2025-04-15 00:00:00
3939	Nescafe clasico sobre	None	4	19	8.00	10.50	100	10	2025-04-15 00:00:00
3940	Nescafe capuccino sobre	None	4	19	8.00	10.50	100	10	2025-04-15 00:00:00
3941	Nescafe clasico bote chico	None	4	19	8.00	10.50	100	10	2025-04-15 00:00:00
3942	Nescafe clasico bote grande	None	4	19	8.00	10.50	100	10	2025-04-15 00:00:00
3943	Azucar Zulka 1kg	None	3	58	8.00	10.50	100	10	2025-04-15 00:00:00
3944	Azucar refinada 1kg	None	3	58	8.00	10.50	100	10	2025-04-15 00:00:00
3945	Azucar refinada 500gr	None	3	58	8.00	10.50	100	10	2025-04-15 00:00:00
3946	Azucar refinada 250gr	None	3	58	8.00	10.50	100	10	2025-04-15 00:00:00
3947	Aceite nutrioli 1lt	None	1	58	8.00	10.50	100	10	2025-04-15 00:00:00
3948	Aceite capullo 1lt	None	1	58	8.00	10.50	100	10	2025-04-15 00:00:00
3949	Aceite 1 2 3 1lt	None	1	58	8.00	10.50	100	10	2025-04-15 00:00:00
3950	Aceite patrona 1lt	None	1	58	8.00	10.50	100	10	2025-04-15 00:00:00
3951	Vinagre blanco la coste¤a	None	1	27	8.00	10.50	100	10	2025-04-15 00:00:00
3952	Vinagre de manzana la coste¤a	None	1	27	8.00	10.50	100	10	2025-04-15 00:00:00
3953	Catsup la coste¤a	None	1	27	8.00	10.50	100	10	2025-04-15 00:00:00
3954	Catsup Del monte	None	1	70	8.00	10.50	100	10	2025-04-15 00:00:00
3955	Catsup heinz	None	1	71	8.00	10.50	100	10	2025-04-15 00:00:00
3956	Jugo Magui	None	7	19	8.00	10.50	100	10	2025-04-15 00:00:00
3957	Salsa inglesa	None	7	19	8.00	10.50	100	10	2025-04-15 00:00:00
3958	Salsa valentina chica	None	7	58	8.00	10.50	100	10	2025-04-15 00:00:00
3959	Salsa valentina grande	None	7	58	8.00	10.50	100	10	2025-04-15 00:00:00
3960	Salsa tabasco	None	7	58	8.00	10.50	100	10	2025-04-15 00:00:00
3961	Salsa buffalo	None	7	58	8.00	10.50	100	10	2025-04-15 00:00:00
3962	Salsa chipotle la coste¤a	None	7	27	8.00	10.50	100	10	2025-04-15 00:00:00
3963	Chile chipotle la coste¤a	None	6	27	8.00	10.50	100	10	2025-04-15 00:00:00
3964	Tic tac naranja	None	8	40	8.00	10.50	100	10	2025-04-15 00:00:00
3965	Yogurt Yoplait natural 1L	Yogurt Yoplait natural 1 Litro	17	54	26.00	31.00	100	10	2025-04-15 00:00:00
3966	Cremax vainilla	None	29	46	8.00	10.50	100	10	2025-04-15 00:00:00
3967	Maxitubo Barritas fresa	None	9	22	8.00	10.50	100	10	2025-04-15 00:00:00
3968	Bigote tia rosa	None	29	49	8.00	10.50	100	10	2025-04-15 00:00:00
3969	Magdalenas tia rosa	None	29	49	8.00	10.50	100	10	2025-04-15 00:00:00
3970	Chiles serranos la coste¤a	None	6	27	8.00	10.50	100	10	2025-04-15 00:00:00
3971	Chiles en vinagre la coste¤a	None	6	27	8.00	10.50	100	10	2025-04-15 00:00:00
3972	Chile chipotle la morena	None	6	72	8.00	10.50	100	10	2025-04-15 00:00:00
3973	Chiles en vinagre la morena	None	6	72	8.00	10.50	100	10	2025-04-15 00:00:00
3974	Mayonesa mccormick chica	None	7	72	8.00	10.50	100	10	2025-04-15 00:00:00
3975	Mayonesa mccormick grande	None	7	72	8.00	10.50	100	10	2025-04-15 00:00:00
3976	Mostaza mccormick	None	7	72	8.00	10.50	100	10	2025-04-15 00:00:00
3977	Mermelada mccormick fresa chica	None	19	72	8.00	10.50	100	10	2025-04-15 00:00:00
3978	Mermelada mccormick fresa grande	None	19	72	8.00	10.50	100	10	2025-04-15 00:00:00
3979	Cloralex 1/2 lt	None	35	58	8.00	10.50	100	10	2025-04-15 00:00:00
3980	Cloralex 1 lt	None	35	58	8.00	10.50	100	10	2025-04-15 00:00:00
3981	Pinol	None	35	58	8.00	10.50	100	10	2025-04-15 00:00:00
3982	Fabuloso lavanda 1lt	None	35	58	8.00	10.50	100	10	2025-04-15 00:00:00
3983	Fabuloso aroma floral 1lt	None	35	58	8.00	10.50	100	10	2025-04-15 00:00:00
3984	Detergente Ariel 1/2 kg	None	34	58	8.00	10.50	100	10	2025-04-15 00:00:00
3985	Detergente Ariel 1kg	None	34	58	8.00	10.50	100	10	2025-04-15 00:00:00
3986	Detergente Ace 1/2 kg	None	34	58	8.00	10.50	100	10	2025-04-15 00:00:00
3987	Detergente Ace 1kg	None	34	58	8.00	10.50	100	10	2025-04-15 00:00:00
3988	Detergente Foca 1/2 kg	None	34	58	8.00	10.50	100	10	2025-04-15 00:00:00
3989	Detergente Foca 1kg	None	34	58	8.00	10.50	100	10	2025-04-15 00:00:00
3990	Suavitel 1l	None	34	58	8.00	10.50	100	10	2025-04-15 00:00:00
3991	Papel higienico Petalo 4 rollos	None	37	58	8.00	10.50	100	10	2025-04-15 00:00:00
3992	Papel higienico Petalo 6 rollos	None	37	58	8.00	10.50	100	10	2025-04-15 00:00:00
3993	Papel higienico Suavel 4 rollos	None	37	58	8.00	10.50	100	10	2025-04-15 00:00:00
3994	Papel higienico Suavel 6 rollos	None	37	58	8.00	10.50	100	10	2025-04-15 00:00:00
3995	Toallas sanitarias Always	None	37	58	8.00	10.50	100	10	2025-04-15 00:00:00
3996	Toallas sanitarias Kotex	None	37	58	8.00	10.50	100	10	2025-04-15 00:00:00
3997	Panales Huggies	None	44	58	8.00	10.50	100	10	2025-04-15 00:00:00
3998	Shampoo Head & Shoulders chico	None	39	58	8.00	10.50	100	10	2025-04-15 00:00:00
3999	Shampoo Head & Shoulders grande	None	39	58	8.00	10.50	100	10	2025-04-15 00:00:00
4000	Desodorante Axe	None	41	58	8.00	10.50	100	10	2025-04-15 00:00:00
4001	Leche deslactosada 1lt	Presentacion azul	15	4	18.20	23.00	14	2	2025-04-15 00:00:00
4002	Yomi lala chocolate	None	15	4	15.00	30.00	100	10	2025-04-15 00:00:00
4003	Yomi lala vainilla	None	15	4	15.00	30.00	100	10	2025-04-15 00:00:00
4004	Yomi lala fresa	None	15	4	15.00	30.00	100	10	2025-04-15 00:00:00
4005	Yogurt lala fresa	None	15	4	15.00	30.00	100	10	2025-04-15 00:00:00
4006	Yogurt lala durazno	None	15	4	15.00	30.00	100	10	2025-04-15 00:00:00
4007	Yogurt lala manzana	None	15	4	15.00	30.00	100	10	2025-04-15 00:00:00
4008	Yogurt bebible lala manzana	None	15	4	15.00	30.00	100	10	2025-04-15 00:00:00
4009	Yogurt bebible lala durazno	None	15	4	15.00	30.00	100	10	2025-04-15 00:00:00
4010	Yogurt bebible lala fresa	None	15	4	15.00	30.00	100	10	2025-04-15 00:00:00
4011	Yogurt bebible lala moras	None	15	4	15.00	30.00	100	10	2025-04-15 00:00:00
4012	Yogurt bebible lala pina coco	None	15	4	15.00	30.00	100	10	2025-04-15 00:00:00
4013	Licuado lala fresa platano	None	15	4	15.00	30.00	100	10	2025-04-15 00:00:00
4014	Licuado lala nuez	None	15	4	15.00	30.00	100	10	2025-04-15 00:00:00
4015	Flan lala	None	15	4	15.00	30.00	100	10	2025-04-15 00:00:00
4016	Margarina lala 90gr	None	15	4	15.00	30.00	100	10	2025-04-15 00:00:00
4017	Jabon zote rosa chico	None	42	58	8.00	10.50	100	10	2025-04-15 00:00:00
4018	Jabon zote rosa grande	None	42	58	8.00	10.50	100	10	2025-04-15 00:00:00
4019	Jabon zote blanco chico	None	42	58	8.00	10.50	100	10	2025-04-15 00:00:00
4020	Jabon zote blanco grande	None	42	58	8.00	10.50	100	10	2025-04-15 00:00:00
4021	Perejil ramo		21	58	3.00	5.00	5	1	2025-04-15 00:00:00
4022	Leche entera lala 1lt	Clasica color roja	15	4	15.24	25.00	2	3	2026-03-31 00:00:00
4023	Pepsi	bebida azucarada	31	14	8.00	16.00	77	20	2026-03-31 00:00:00
4024	Manzanita		31	14	17.00	25.00	22	3	2026-03-31 00:00:00
4025	MaruchanTokyo	maruchan picante	2	11	5.50	12.50	15	10	2026-03-31 00:00:00
4026	Harina de maiz maseca	None	10	59	8.00	10.50	100	10	2026-03-31 00:00:00
4027	Sabritas	Sabritas Flamin Hot	9	3	10.00	18.00	4	1	2026-03-31 00:00:00
4028	Galletas marias	Las galletas clasicas	9	3	8.90	15.00	19	2	2026-03-31 00:00:00
4029	Leche Lala entera 1L	Leche Lala entera 1 Litro	15	4	19.00	24.00	100	10	2026-03-31 00:00:00
4030	Tostadas charras	None	5	60	8.00	10.50	100	10	2026-03-31 00:00:00
4031	Leche Lala light 1L	Leche Lala light 1 Litro	15	4	20.00	25.00	100	10	2026-03-31 00:00:00
4032	Leche Santa Clara entera 1L	Leche Santa Clara entera 1 Litro	15	4	22.00	28.00	100	10	2026-03-31 00:00:00
4033	Leche Santa Clara deslactosada 1L	Leche Santa Clara deslactosada 1 Litro	15	4	23.00	29.00	100	10	2026-03-31 00:00:00
4034	Arroz Mexica 1kg	None	2	59	12.00	16.50	100	10	2026-03-31 00:00:00
4035	Del Valle fruit naranja 600ml	Jugo Del Valle sabor Naranja 600 ml	31	28	10.50	13.50	100	10	2026-03-31 00:00:00
4036	Harina de trigo San antonio	None	10	41	8.00	10.50	100	10	2026-03-31 00:00:00
4037	Tortillas de maiz 1/2 kg	None	10	58	8.00	10.50	100	10	2026-03-31 00:00:00
4038	Pan bimbo blanco chico	None	27	17	8.00	10.50	100	10	2026-03-31 00:00:00
4039	Pan bimbo blanco grande	None	27	17	8.00	10.50	100	10	2026-03-31 00:00:00
4040	Pan bimbo integral chico	None	27	17	8.00	10.50	100	10	2026-03-31 00:00:00
4041	Pan bimbo integral grande	None	27	17	8.00	10.50	100	10	2026-03-31 00:00:00
4042	Rebanadas bimbo	None	27	17	8.00	10.50	100	10	2026-03-31 00:00:00
4043	Chocoroles	None	27	17	8.00	10.50	100	10	2026-03-31 00:00:00
4044	Nito bimbo	None	27	17	8.00	10.50	100	10	2026-03-31 00:00:00
4045	Mantecadas	None	27	17	8.00	10.50	100	10	2026-03-31 00:00:00
4046	Roles de canela con pasas	None	27	17	8.00	10.50	100	10	2026-03-31 00:00:00
4047	Roles de canela glaseados	None	27	17	8.00	10.50	100	10	2026-03-31 00:00:00
4048	Conchas bimbo	None	27	17	8.00	10.50	100	10	2026-03-31 00:00:00
4049	Panque de nuez bimbo	None	27	17	8.00	10.50	100	10	2026-03-31 00:00:00
4050	Donitas bimbo	None	27	17	8.00	10.50	100	10	2026-03-31 00:00:00
4051	Donitas espolvoreadas bimbo	None	27	17	8.00	10.50	100	10	2026-03-31 00:00:00
4052	chimichangas	chimichangas	23	10	30.00	45.00	15	5	2026-03-31 00:00:00
4053	Coca Cola 1L	Refresco Coca Cola 1 Litro	31	16	12.00	15.00	100	10	2026-03-31 00:00:00
4054	Coca Cola lata 355ml	Refresco Coca Cola 355 ml lata	31	16	8.50	11.00	100	10	2026-03-31 00:00:00
4055	Coca Cola 355ml	Refresco Coca Cola 355 ml	31	16	8.00	10.50	100	10	2026-03-31 00:00:00
4056	Coca Cola 600ml	Refresco Coca Cola 600 ml	31	16	9.00	12.00	100	10	2026-03-31 00:00:00
4057	Coca Cola retornable 1 1/4 lt.	Refresco Coca Cola retornable 1 1/4 lt	31	16	12.50	15.50	100	10	2026-03-31 00:00:00
4058	Coca Cola 2L retornable	Refresco Coca Cola retornable 2 Litros	31	16	19.50	24.00	100	10	2026-03-31 00:00:00
4059	Coca Cola 3L retornable	Refresco Coca Cola retornable 3 Litros	31	16	24.00	30.00	100	10	2026-03-31 00:00:00
4060	Coca Cola Light 600ml	Refresco Coca Cola Light 600 ml	31	16	9.50	12.50	100	10	2026-03-31 00:00:00
4061	Pepsi 600ml	Refresco Pepsi 600 ml	31	14	9.00	12.00	100	10	2026-03-31 00:00:00
4062	Pepsi 1.5L	Refresco Pepsi 1.5 Litros	31	14	12.00	15.50	100	10	2026-03-31 00:00:00
4063	Fanta 600ml	Refresco Fanta 600 ml	31	16	9.00	12.00	100	10	2026-03-31 00:00:00
4064	Fanta 1.5L	Refresco Fanta 1.5 Litros	31	16	12.50	16.00	100	10	2026-03-31 00:00:00
4065	Sprite 600ml	Refresco Sprite 600 ml	31	16	9.00	12.00	100	10	2026-03-31 00:00:00
4066	Sprite 1.5L	Refresco Sprite 1.5 Litros	31	16	12.50	16.00	100	10	2026-03-31 00:00:00
4067	Manzanita 600ml	Refresco Manzanita Sol 600 ml	31	16	9.00	12.00	100	10	2026-03-31 00:00:00
4068	Manzanita 1.5L	Refresco Manzanita Sol 1.5 Litros	31	16	12.50	16.00	100	10	2026-03-31 00:00:00
4069	Fresca 600ml	Refresco Fresca 600 ml	31	16	9.00	12.00	100	10	2026-03-31 00:00:00
4070	Fresca 3L	Refresco Fresca 3 Litros	31	16	24.00	30.00	100	10	2026-03-31 00:00:00
4071	Mirinda 600ml	Refresco Mirinda 600 ml	31	16	9.00	12.00	100	10	2026-03-31 00:00:00
4072	Mirinda 1.5L	Refresco Mirinda 1.5 Litros	31	16	12.50	16.00	100	10	2026-03-31 00:00:00
4073	Tostadas Sanissimo	None	5	61	8.00	10.50	100	10	2026-03-31 00:00:00
4074	Marias gamesa	None	29	46	8.00	10.50	100	10	2026-03-31 00:00:00
4075	Jumex de mango 1L	Jugo Jumex sabor Mango 1 Litro	31	21	16.00	20.00	100	10	2026-03-31 00:00:00
4076	Emperador chocolate	None	29	46	8.00	10.50	100	10	2026-03-31 00:00:00
4077	Emperador nuez	None	29	46	8.00	10.50	100	10	2026-03-31 00:00:00
4078	Emperador vainilla	None	29	46	8.00	10.50	100	10	2026-03-31 00:00:00
4079	Emperador limon	None	29	46	8.00	10.50	100	10	2026-03-31 00:00:00
4080	Jumex de durazno 1L	Jugo Jumex sabor Durazno 1 Litro	31	21	16.00	20.00	100	10	2026-03-31 00:00:00
4081	Jumex de manzana 600ml	Jugo Jumex sabor Manzana 600 ml	31	21	10.00	13.00	100	10	2026-03-31 00:00:00
4082	Roles	Ricos roles de canela caseros	27	13	70.00	100.00	18	10	2026-03-31 00:00:00
4083	Del Valle fruit manzana 600ml	Jugo Del Valle sabor Manzana 600 ml	31	28	10.50	13.50	100	10	2026-03-31 00:00:00
4084	Del Valle fruit guayaba 600ml	Jugo Del Valle sabor Guayaba 600 ml	31	28	10.50	13.50	100	10	2026-03-31 00:00:00
4085	Emperador Senso	None	29	46	8.00	10.50	100	10	2026-03-31 00:00:00
4086	Mamut chico	None	29	46	8.00	10.50	100	10	2026-03-31 00:00:00
4087	Yogurt Lala natural 1L	Yogurt Lala natural 1 Litro	17	4	25.00	30.00	100	10	2026-03-31 00:00:00
4088	Yogurt Lala de fresa 1L	Yogurt Lala sabor Fresa 1 Litro	17	4	25.00	30.00	100	10	2026-03-31 00:00:00
4089	Yogurt Yoplait de fresa 1L	Yogurt Yoplait sabor Fresa 1 Litro	17	54	26.00	31.00	100	10	2026-03-31 00:00:00
4090	Mantequilla Lala 250g	Mantequilla Lala 250 gramos	19	4	30.00	38.00	100	10	2026-03-31 00:00:00
4091	Queso panela Lala 200g	Queso panela Lala 200 gramos	16	4	40.00	50.00	100	10	2026-03-31 00:00:00
4092	Mamut grande	None	29	46	8.00	10.50	100	10	2026-03-31 00:00:00
4093	Chokis	None	29	46	8.00	10.50	100	10	2026-03-31 00:00:00
4094	Chokis rellenas	None	29	46	8.00	10.50	100	10	2026-03-31 00:00:00
4095	Chokis doble chocolate	None	29	46	8.00	10.50	100	10	2026-03-31 00:00:00
4096	Chokis brownie	None	29	46	8.00	10.50	100	10	2026-03-31 00:00:00
4097	Leche Lala deslactosada 1L	Leche Lala deslactosada 1 Litro	15	4	20.00	25.00	100	10	2026-03-31 00:00:00
4098	Queso panela Alpura 200g	Queso panela Alpura 200 gramos	16	18	40.00	50.00	100	10	2026-03-31 00:00:00
4099	Queso oaxaca Lala 200g	Queso Oaxaca Lala 200 gramos	16	4	45.00	55.00	100	10	2026-03-31 00:00:00
4100	Queso manchego Lala 200g	Queso Manchego Lala 200 gramos	16	4	50.00	60.00	100	10	2026-03-31 00:00:00
4101	Salchichas Fud paquete 500g	Salchichas Fud 500 gramos	18	53	30.00	40.00	100	10	2026-03-31 00:00:00
4102	Salchichas San Rafael paquete 500g	Salchichas San Rafael 500 gramos	18	52	35.00	45.00	100	10	2026-03-31 00:00:00
4103	Sidral mundet 600ml	Refresco de manzana de 600ml	31	16	10.00	16.00	20	5	2026-03-31 00:00:00
4104	Sidral mundet 3lt	Refresco de manzana de 3lt	31	16	24.00	30.00	20	5	2026-03-31 00:00:00
4105	Agua bonafont 600ml	None	30	55	8.00	10.50	100	10	2026-03-31 00:00:00
4106	Agua bonafont 1lt	None	30	55	12.00	15.00	100	10	2026-03-31 00:00:00
4107	Agua bonafont 2lt.	None	30	55	14.00	18.00	100	10	2026-03-31 00:00:00
4108	Garrafon bonafont 20lt	None	30	55	19.50	24.00	100	10	2026-03-31 00:00:00
4109	Agua ciel 600ml	None	30	16	8.00	13.00	100	10	2026-03-31 00:00:00
4110	Agua ciel 1lt	None	30	16	10.00	15.00	100	10	2026-03-31 00:00:00
4111	Agua ciel 1.5l	None	30	16	12.00	17.00	100	10	2026-03-31 00:00:00
4112	Agua ciel 2lt	None	30	16	14.00	20.00	100	10	2026-03-31 00:00:00
4113	Agua E-pura 600ml	None	30	14	8.00	13.00	100	10	2026-03-31 00:00:00
4114	Agua E-pura 1lt	None	30	14	10.00	15.00	100	10	2026-03-31 00:00:00
4115	Garrafon E-pura 10lt	None	30	14	18.00	25.00	100	10	2026-03-31 00:00:00
4116	Crema Lala 200ml	None	15	4	8.00	13.00	100	10	2026-03-31 00:00:00
4117	Crema Lala 426ml	None	15	4	15.00	30.00	100	10	2026-03-31 00:00:00
4118	Crema Lala 900ml	None	15	4	35.00	55.00	100	10	2026-03-31 00:00:00
4119	Crema alpura 200ml	None	15	4	8.00	13.00	100	10	2026-03-31 00:00:00
4120	Crema alpura 426ml	None	15	4	15.00	30.00	100	10	2026-03-31 00:00:00
4121	Crema alpura 900ml	None	15	4	35.00	55.00	100	10	2026-03-31 00:00:00
4122	Atun dolores en agua	None	6	51	10.00	15.00	100	10	2026-03-31 00:00:00
4123	Atun dolores en aceite	None	6	51	12.00	17.00	100	10	2026-03-31 00:00:00
4124	Sardinas en aceite	None	6	20	10.00	15.00	100	10	2026-03-31 00:00:00
4125	Frijoles refritos	None	6	50	10.00	15.00	100	10	2026-03-31 00:00:00
4126	Frijoles bayos	None	6	50	10.00	15.00	100	10	2026-03-31 00:00:00
4127	Pasta la moderna	None	2	44	10.00	15.00	100	10	2026-03-31 00:00:00
4128	Coditos la moderna	None	2	44	10.00	15.00	100	10	2026-03-31 00:00:00
4129	Pasta Barilla espagueti	None	2	56	10.00	15.00	100	10	2026-03-31 00:00:00
4130	Sopa de letras la moderna	None	2	44	10.00	15.00	100	10	2026-03-31 00:00:00
4131	Sopa maruchan pollo	None	2	57	10.00	15.00	100	10	2026-03-31 00:00:00
4132	Sopa maruchan camaron	None	2	57	10.00	15.00	100	10	2026-03-31 00:00:00
4133	Sopa maruchan res	None	2	57	10.00	15.00	100	10	2026-03-31 00:00:00
4134	Sopa maruchan habanero	None	2	57	10.00	15.00	100	10	2026-03-31 00:00:00
4135	Sopa maruchan piquin	None	2	57	10.00	15.00	100	10	2026-03-31 00:00:00
4136	Sopa maruchan limon	None	2	57	10.00	15.00	100	10	2026-03-31 00:00:00
4137	Lentejas la moderna	None	2	44	10.00	15.00	100	10	2026-03-31 00:00:00
4138	Jamon de pavo Fud 250g	Jamon de Pavo Fud 250 gramos	18	53	35.00	45.00	100	10	2026-03-31 00:00:00
4139	Jamon de pavo San Rafael 250g	Jamon de Pavo San Rafael 250 gramos	18	52	40.00	50.00	100	10	2026-03-31 00:00:00
4140	Cremax chocolate	None	29	46	8.00	10.50	100	10	2026-03-31 00:00:00
4141	Cremax fresa	None	29	46	8.00	10.50	100	10	2026-03-31 00:00:00
4142	Florentinas gamesa	None	29	46	8.00	10.50	100	10	2026-03-31 00:00:00
4143	Marias doradas	None	29	46	8.00	10.50	100	10	2026-03-31 00:00:00
4144	Gamesa cajeta	None	29	46	8.00	10.50	100	10	2026-03-31 00:00:00
4145	Maravillas gamesa	None	29	46	8.00	10.50	100	10	2026-03-31 00:00:00
4146	Crackets gamesa	None	29	46	8.00	10.50	100	10	2026-03-31 00:00:00
4147	Surtido rico gamesa	None	29	46	8.00	10.50	100	10	2026-03-31 00:00:00
4148	Delicias gamesa	None	29	46	8.00	10.50	100	10	2026-03-31 00:00:00
4149	Oreo	None	9	58	8.00	10.50	100	10	2026-03-31 00:00:00
4150	Principe chocolate	None	9	22	8.00	10.50	100	10	2026-03-31 00:00:00
4151	Principe vainilla	None	9	22	8.00	10.50	100	10	2026-03-31 00:00:00
4152	Principe limon	None	9	22	8.00	10.50	100	10	2026-03-31 00:00:00
4153	Principe chocolate blanco	None	9	22	8.00	10.50	100	10	2026-03-31 00:00:00
4154	Lors	None	9	22	8.00	10.50	100	10	2026-03-31 00:00:00
4155	Plativolos	None	9	22	8.00	10.50	100	10	2026-03-31 00:00:00
4156	Sponch	None	9	22	8.00	10.50	100	10	2026-03-31 00:00:00
4157	Triki trakes	None	9	22	8.00	10.50	100	10	2026-03-31 00:00:00
4158	MaxiTubo Triki trakes	None	9	22	8.00	10.50	100	10	2026-03-31 00:00:00
4159	Gansito	None	9	22	8.00	10.50	100	10	2026-03-31 00:00:00
4160	Pinguinos	None	9	22	8.00	10.50	100	10	2026-03-31 00:00:00
4161	Pasticetas marinela	None	9	22	8.00	10.50	100	10	2026-03-31 00:00:00
4162	Barritas fresa	None	9	22	8.00	10.50	100	10	2026-03-31 00:00:00
4163	Barritas pina	None	9	22	8.00	10.50	100	10	2026-03-31 00:00:00
4164	Barritas moras	None	9	22	8.00	10.50	100	10	2026-03-31 00:00:00
4165	Maxitubo Barritas pina	None	9	22	8.00	10.50	100	10	2026-03-31 00:00:00
4166	Canelitas	None	9	22	8.00	10.50	100	10	2026-03-31 00:00:00
4167	Polvorones	None	9	22	8.00	10.50	100	10	2026-03-31 00:00:00
4168	Maxitubo Polvorones	None	9	22	8.00	10.50	100	10	2026-03-31 00:00:00
4169	Ricanelas	None	9	46	8.00	10.50	100	10	2026-03-31 00:00:00
4170	Ritz bits queso	None	9	58	8.00	10.50	100	10	2026-03-31 00:00:00
4171	Arcoiris	None	9	46	8.00	10.50	100	10	2026-03-31 00:00:00
4172	Submarinos fresa	None	9	22	8.00	10.50	100	10	2026-03-31 00:00:00
4173	Submarinos vainilla	None	9	22	8.00	10.50	100	10	2026-03-31 00:00:00
4174	Submarinos chocolate	None	9	22	8.00	10.50	100	10	2026-03-31 00:00:00
4175	Rocko chico	None	9	22	8.00	10.50	100	10	2026-03-31 00:00:00
4176	Rocko grande	None	9	22	8.00	10.50	100	10	2026-03-31 00:00:00
4177	Sabritas original	None	9	3	8.00	10.50	100	10	2026-03-31 00:00:00
4178	Sabritas adobadas	None	9	3	8.00	10.50	100	10	2026-03-31 00:00:00
4179	Sabritas limon	None	9	3	8.00	10.50	100	10	2026-03-31 00:00:00
4180	Sabritas flamin hot	None	9	3	8.00	10.50	100	10	2026-03-31 00:00:00
4181	Sabritas crema y especias	None	9	3	8.00	10.50	100	10	2026-03-31 00:00:00
4182	Sabritas habanero	None	9	3	8.00	10.50	100	10	2026-03-31 00:00:00
4183	Sabritas receta crujiente	None	9	3	8.00	10.50	100	10	2026-03-31 00:00:00
4184	Chips jalapeno	None	9	47	8.00	10.50	100	10	2026-03-31 00:00:00
4185	Crujitos	None	9	3	8.00	10.50	100	10	2026-03-31 00:00:00
4186	Doritos nacho	None	9	3	8.00	10.50	100	10	2026-03-31 00:00:00
4187	Doritos incognita	None	9	3	8.00	10.50	100	10	2026-03-31 00:00:00
4188	Doritos diablo	None	9	3	8.00	10.50	100	10	2026-03-31 00:00:00
4189	Doritos flamin hot	None	9	3	8.00	10.50	100	10	2026-03-31 00:00:00
4190	Doritos dinamita	None	9	3	8.00	10.50	100	10	2026-03-31 00:00:00
4191	Sabritones	None	9	3	8.00	10.50	100	10	2026-03-31 00:00:00
4192	Bigmix queso	None	9	47	8.00	10.50	100	10	2026-03-31 00:00:00
4193	Bigmix fuego	None	9	47	8.00	10.50	100	10	2026-03-31 00:00:00
4194	Cheetos torciditos	None	9	3	8.00	10.50	100	10	2026-03-31 00:00:00
4195	Cheetos bolitas	None	9	3	8.00	10.50	100	10	2026-03-31 00:00:00
4196	Cheetos queso	None	9	3	8.00	10.50	100	10	2026-03-31 00:00:00
4197	Cheetos flamin hot	None	9	3	8.00	10.50	100	10	2026-03-31 00:00:00
4198	Ruffles original	None	9	3	8.00	10.50	100	10	2026-03-31 00:00:00
4199	Ruffles queso	None	9	3	8.00	10.50	100	10	2026-03-31 00:00:00
4200	Fritos sal y limon	None	9	3	8.00	10.50	100	10	2026-03-31 00:00:00
4201	Fritos chorizo	None	9	3	8.00	10.50	100	10	2026-03-31 00:00:00
4202	Bolsaza Sabritas original	None	9	3	8.00	10.50	100	10	2026-03-31 00:00:00
4203	Bolsaza Doritos nacho	None	9	3	8.00	10.50	100	10	2026-03-31 00:00:00
4204	Paketaxo	None	9	3	8.00	10.50	100	10	2026-03-31 00:00:00
4205	Paketaxo queso	None	9	3	8.00	10.50	100	10	2026-03-31 00:00:00
4206	Paketaxo flamin hot	None	9	3	8.00	10.50	100	10	2026-03-31 00:00:00
4207	Churrumaiz	None	9	3	8.00	10.50	100	10	2026-03-31 00:00:00
4208	Churrumaiz flamin hot	None	9	3	8.00	10.50	100	10	2026-03-31 00:00:00
4209	Rancheritos	None	9	3	8.00	10.50	100	10	2026-03-31 00:00:00
4210	Sabritas switch doritos nacho	None	9	3	8.00	10.50	100	10	2026-03-31 00:00:00
4211	Runners	None	9	47	8.00	10.50	100	10	2026-03-31 00:00:00
4212	Chips sal	None	9	47	8.00	10.50	100	10	2026-03-31 00:00:00
4213	Papatinas	None	9	47	8.00	10.50	100	10	2026-03-31 00:00:00
4214	Chips fuego	None	9	47	8.00	10.50	100	10	2026-03-31 00:00:00
4215	Palomitas pop	None	9	47	8.00	10.50	100	10	2026-03-31 00:00:00
4216	Takis original 	None	9	47	8.00	10.50	100	10	2026-03-31 00:00:00
4217	Takis fuego	None	9	47	8.00	10.50	100	10	2026-03-31 00:00:00
4218	Takis salsa brava	None	9	47	8.00	10.50	100	10	2026-03-31 00:00:00
4219	Takis guacamole	None	9	47	8.00	10.50	100	10	2026-03-31 00:00:00
4220	Chipotles	None	9	47	8.00	10.50	100	10	2026-03-31 00:00:00
4221	Tostachos	None	9	47	8.00	10.50	100	10	2026-03-31 00:00:00
4222	Hot nuts	None	9	47	8.00	10.50	100	10	2026-03-31 00:00:00
4223	Hot nuts fuego	None	9	47	8.00	10.50	100	10	2026-03-31 00:00:00
4224	Valentones	None	9	47	8.00	10.50	100	10	2026-03-31 00:00:00
4225	Watz barcel	None	9	47	8.00	10.50	100	10	2026-03-31 00:00:00
4226	Toreadas	None	9	47	8.00	10.50	100	10	2026-03-31 00:00:00
4227	Palomitas pop fuego	None	9	47	8.00	10.50	100	10	2026-03-31 00:00:00
4228	Takis blue heat	None	9	47	8.00	10.50	100	10	2026-03-31 00:00:00
4229	Doraditas tia rosa	None	29	49	8.00	10.50	100	10	2026-03-31 00:00:00
4230	Sabritas receta crujiente jalapeno	None	9	3	8.00	10.50	100	10	2026-03-31 00:00:00
4231	Tortillinas tia rosa	None	10	49	8.00	10.50	100	10	2026-03-31 00:00:00
4232	Conchas tia rosa	None	29	49	8.00	10.50	100	10	2026-03-31 00:00:00
4233	Hersheys Cookies n Cream	None	8	45	8.00	10.50	100	10	2026-03-31 00:00:00
4234	Hersheys almendras	None	8	45	8.00	10.50	100	10	2026-03-31 00:00:00
4235	Hersheys chocolate amargo	None	8	45	8.00	10.50	100	10	2026-03-31 00:00:00
4236	Hersheys chocolate blanco	None	8	45	8.00	10.50	100	10	2026-03-31 00:00:00
4237	Crunch	None	8	19	8.00	10.50	100	10	2026-03-31 00:00:00
4238	Carlos V	None	8	19	8.00	10.50	100	10	2026-03-31 00:00:00
4239	Milky way	None	8	19	8.00	10.50	100	10	2026-03-31 00:00:00
4240	Snickers	None	8	19	8.00	10.50	100	10	2026-03-31 00:00:00
4241	Kit kat	None	8	19	8.00	10.50	100	10	2026-03-31 00:00:00
4242	Kinder delice	None	8	40	8.00	10.50	100	10	2026-03-31 00:00:00
4243	Kinder sorpresa	None	8	40	8.00	10.50	100	10	2026-03-31 00:00:00
4244	Ferrero rocher 3 piezas	None	8	40	8.00	10.50	100	10	2026-03-31 00:00:00
4245	Mazapan	None	8	62	8.00	10.50	100	10	2026-03-31 00:00:00
4246	Pelon pelo rico	None	8	45	8.00	10.50	100	10	2026-03-31 00:00:00
4247	Pulparindo tamarindo	None	8	62	8.00	10.50	100	10	2026-03-31 00:00:00
4248	Pulparindo chamoy	None	8	62	8.00	10.50	100	10	2026-03-31 00:00:00
4249	Tutsi pop	None	8	65	8.00	10.50	100	10	2026-03-31 00:00:00
4250	Oblea cajeta coronado	None	8	66	8.00	10.50	100	10	2026-03-31 00:00:00
4251	Paleta payaso	None	8	67	8.00	10.50	100	10	2026-03-31 00:00:00
4252	Duvalin fresa vainilla	None	8	67	8.00	10.50	100	10	2026-03-31 00:00:00
4253	Duvalin chocolate vainilla	None	8	67	8.00	10.50	100	10	2026-03-31 00:00:00
4254	Duvalin vainilla	None	8	67	8.00	10.50	100	10	2026-03-31 00:00:00
4255	Duvalin trisabor	None	8	67	8.00	10.50	100	10	2026-03-31 00:00:00
4256	Duvalin choco avellana	None	8	67	8.00	10.50	100	10	2026-03-31 00:00:00
4257	Paleta Vero mango	None	8	68	8.00	10.50	100	10	2026-03-31 00:00:00
4258	Paleta Vero elote	None	8	67	8.00	10.50	100	10	2026-03-31 00:00:00
4259	Panditas	None	8	67	8.00	10.50	100	10	2026-03-31 00:00:00
4260	Panditas rellenos	None	8	67	8.00	10.50	100	10	2026-03-31 00:00:00
4261	Panditas san valentin	None	8	67	8.00	10.50	100	10	2026-03-31 00:00:00
4262	Bubulubu	None	8	67	8.00	10.50	100	10	2026-03-31 00:00:00
4263	Rockaleta	None	8	69	8.00	10.50	100	10	2026-03-31 00:00:00
4264	Tic tac menta	None	8	40	8.00	10.50	100	10	2026-03-31 00:00:00
4265	Halls menta	None	8	58	8.00	10.50	100	10	2026-03-31 00:00:00
4266	Halls limon	None	8	58	8.00	10.50	100	10	2026-03-31 00:00:00
4267	Halls yerba buena	None	8	58	8.00	10.50	100	10	2026-03-31 00:00:00
4268	Halls miel	None	8	58	8.00	10.50	100	10	2026-03-31 00:00:00
4269	Halls negras	None	8	58	8.00	10.50	100	10	2026-03-31 00:00:00
4270	Gomilocas dientes	None	8	67	8.00	10.50	100	10	2026-03-31 00:00:00
4271	Gomilocas pinguino	None	8	67	8.00	10.50	100	10	2026-03-31 00:00:00
4272	Chocoretas	None	8	67	8.00	10.50	100	10	2026-03-31 00:00:00
4273	Kranky	None	8	67	8.00	10.50	100	10	2026-03-31 00:00:00
4274	Lucas muecas	None	8	58	8.00	10.50	100	10	2026-03-31 00:00:00
4275	Lucas chamoy	None	8	58	8.00	10.50	100	10	2026-03-31 00:00:00
4276	Lucas gusanito	None	8	58	8.00	10.50	100	10	2026-03-31 00:00:00
4277	Palomitas Act II mantequilla	None	9	58	8.00	10.50	100	10	2026-03-31 00:00:00
4278	Palomitas Act II natural	None	9	58	8.00	10.50	100	10	2026-03-31 00:00:00
4279	Palomitas Act II chile limon	None	9	58	8.00	10.50	100	10	2026-03-31 00:00:00
4280	Tostitos salsa verde	None	9	3	8.00	10.50	100	10	2026-03-31 00:00:00
4281	Zucaritas chicas	None	5	26	8.00	10.50	100	10	2026-03-31 00:00:00
4282	Zucaritas grandes	None	5	26	8.00	10.50	100	10	2026-03-31 00:00:00
4283	Corn flakes chicas	None	5	26	8.00	10.50	100	10	2026-03-31 00:00:00
4284	Corn flakes grandes	None	5	26	8.00	10.50	100	10	2026-03-31 00:00:00
4285	Choco Krispis chicas	None	5	26	8.00	10.50	100	10	2026-03-31 00:00:00
4286	Choco Krispis grandes	None	5	26	8.00	10.50	100	10	2026-03-31 00:00:00
4287	Nesquik chico	None	5	26	8.00	10.50	100	10	2026-03-31 00:00:00
4288	Nesquik grande	None	5	26	8.00	10.50	100	10	2026-03-31 00:00:00
4289	Froot loops chicas	None	5	26	8.00	10.50	100	10	2026-03-31 00:00:00
4290	Froot loops grandes	None	5	26	8.00	10.50	100	10	2026-03-31 00:00:00
4291	Chocomilk sobre	None	4	58	8.00	10.50	100	10	2026-03-31 00:00:00
4292	Chocomilk bolsa	None	4	58	8.00	10.50	100	10	2026-03-31 00:00:00
4293	Chocomilk lata	None	4	58	8.00	10.50	100	10	2026-03-31 00:00:00
4294	Nescafe clasico sobre	None	4	19	8.00	10.50	100	10	2026-03-31 00:00:00
4295	Nescafe capuccino sobre	None	4	19	8.00	10.50	100	10	2026-03-31 00:00:00
4296	Nescafe clasico bote chico	None	4	19	8.00	10.50	100	10	2026-03-31 00:00:00
4297	Nescafe clasico bote grande	None	4	19	8.00	10.50	100	10	2026-03-31 00:00:00
4298	Azucar Zulka 1kg	None	3	58	8.00	10.50	100	10	2026-03-31 00:00:00
4299	Azucar refinada 1kg	None	3	58	8.00	10.50	100	10	2026-03-31 00:00:00
4300	Azucar refinada 500gr	None	3	58	8.00	10.50	100	10	2026-03-31 00:00:00
4301	Azucar refinada 250gr	None	3	58	8.00	10.50	100	10	2026-03-31 00:00:00
4302	Aceite nutrioli 1lt	None	1	58	8.00	10.50	100	10	2026-03-31 00:00:00
4303	Aceite capullo 1lt	None	1	58	8.00	10.50	100	10	2026-03-31 00:00:00
4304	Aceite 1 2 3 1lt	None	1	58	8.00	10.50	100	10	2026-03-31 00:00:00
4305	Aceite patrona 1lt	None	1	58	8.00	10.50	100	10	2026-03-31 00:00:00
4306	Vinagre blanco la coste¤a	None	1	27	8.00	10.50	100	10	2026-03-31 00:00:00
4307	Vinagre de manzana la coste¤a	None	1	27	8.00	10.50	100	10	2026-03-31 00:00:00
4308	Catsup la coste¤a	None	1	27	8.00	10.50	100	10	2026-03-31 00:00:00
4309	Catsup Del monte	None	1	70	8.00	10.50	100	10	2026-03-31 00:00:00
4310	Catsup heinz	None	1	71	8.00	10.50	100	10	2026-03-31 00:00:00
4311	Jugo Magui	None	7	19	8.00	10.50	100	10	2026-03-31 00:00:00
4312	Salsa inglesa	None	7	19	8.00	10.50	100	10	2026-03-31 00:00:00
4313	Salsa valentina chica	None	7	58	8.00	10.50	100	10	2026-03-31 00:00:00
4314	Salsa valentina grande	None	7	58	8.00	10.50	100	10	2026-03-31 00:00:00
4315	Salsa tabasco	None	7	58	8.00	10.50	100	10	2026-03-31 00:00:00
4316	Salsa buffalo	None	7	58	8.00	10.50	100	10	2026-03-31 00:00:00
4317	Salsa chipotle la coste¤a	None	7	27	8.00	10.50	100	10	2026-03-31 00:00:00
4318	Chile chipotle la coste¤a	None	6	27	8.00	10.50	100	10	2026-03-31 00:00:00
4319	Tic tac naranja	None	8	40	8.00	10.50	100	10	2026-03-31 00:00:00
4320	Yogurt Yoplait natural 1L	Yogurt Yoplait natural 1 Litro	17	54	26.00	31.00	100	10	2026-03-31 00:00:00
4321	Cremax vainilla	None	29	46	8.00	10.50	100	10	2026-03-31 00:00:00
4322	Maxitubo Barritas fresa	None	9	22	8.00	10.50	100	10	2026-03-31 00:00:00
4323	Bigote tia rosa	None	29	49	8.00	10.50	100	10	2026-03-31 00:00:00
4324	Magdalenas tia rosa	None	29	49	8.00	10.50	100	10	2026-03-31 00:00:00
4325	Chiles serranos la coste¤a	None	6	27	8.00	10.50	100	10	2026-03-31 00:00:00
4326	Chiles en vinagre la coste¤a	None	6	27	8.00	10.50	100	10	2026-03-31 00:00:00
4327	Chile chipotle la morena	None	6	72	8.00	10.50	100	10	2026-03-31 00:00:00
4328	Chiles en vinagre la morena	None	6	72	8.00	10.50	100	10	2026-03-31 00:00:00
4329	Mayonesa mccormick chica	None	7	72	8.00	10.50	100	10	2026-03-31 00:00:00
4330	Mayonesa mccormick grande	None	7	72	8.00	10.50	100	10	2026-03-31 00:00:00
4331	Mostaza mccormick	None	7	72	8.00	10.50	100	10	2026-03-31 00:00:00
4332	Mermelada mccormick fresa chica	None	19	72	8.00	10.50	100	10	2026-03-31 00:00:00
4333	Mermelada mccormick fresa grande	None	19	72	8.00	10.50	100	10	2026-03-31 00:00:00
4334	Cloralex 1/2 lt	None	35	58	8.00	10.50	100	10	2026-03-31 00:00:00
4335	Cloralex 1 lt	None	35	58	8.00	10.50	100	10	2026-03-31 00:00:00
4336	Pinol	None	35	58	8.00	10.50	100	10	2026-03-31 00:00:00
4337	Fabuloso lavanda 1lt	None	35	58	8.00	10.50	100	10	2026-03-31 00:00:00
4338	Fabuloso aroma floral 1lt	None	35	58	8.00	10.50	100	10	2026-03-31 00:00:00
4339	Detergente Ariel 1/2 kg	None	34	58	8.00	10.50	100	10	2026-03-31 00:00:00
4340	Detergente Ariel 1kg	None	34	58	8.00	10.50	100	10	2026-03-31 00:00:00
4341	Detergente Ace 1/2 kg	None	34	58	8.00	10.50	100	10	2026-03-31 00:00:00
4342	Detergente Ace 1kg	None	34	58	8.00	10.50	100	10	2026-03-31 00:00:00
4343	Detergente Foca 1/2 kg	None	34	58	8.00	10.50	100	10	2026-03-31 00:00:00
4344	Detergente Foca 1kg	None	34	58	8.00	10.50	100	10	2026-03-31 00:00:00
4345	Suavitel 1l	None	34	58	8.00	10.50	100	10	2026-03-31 00:00:00
4346	Papel higienico Petalo 4 rollos	None	37	58	8.00	10.50	100	10	2026-03-31 00:00:00
4347	Papel higienico Petalo 6 rollos	None	37	58	8.00	10.50	100	10	2026-03-31 00:00:00
4348	Papel higienico Suavel 4 rollos	None	37	58	8.00	10.50	100	10	2026-03-31 00:00:00
4349	Papel higienico Suavel 6 rollos	None	37	58	8.00	10.50	100	10	2026-03-31 00:00:00
4350	Toallas sanitarias Always	None	37	58	8.00	10.50	100	10	2026-03-31 00:00:00
4351	Toallas sanitarias Kotex	None	37	58	8.00	10.50	100	10	2026-03-31 00:00:00
4352	Panales Huggies	None	44	58	8.00	10.50	100	10	2026-03-31 00:00:00
4353	Shampoo Head & Shoulders chico	None	39	58	8.00	10.50	100	10	2026-03-31 00:00:00
4354	Shampoo Head & Shoulders grande	None	39	58	8.00	10.50	100	10	2026-03-31 00:00:00
4355	Desodorante Axe	None	41	58	8.00	10.50	100	10	2026-03-31 00:00:00
4356	Leche deslactosada 1lt	Presentacion azul	15	4	18.20	23.00	14	2	2026-03-31 00:00:00
4357	Yomi lala chocolate	None	15	4	15.00	30.00	100	10	2026-03-31 00:00:00
4358	Yomi lala vainilla	None	15	4	15.00	30.00	100	10	2026-03-31 00:00:00
4359	Yomi lala fresa	None	15	4	15.00	30.00	100	10	2026-03-31 00:00:00
4360	Yogurt lala fresa	None	15	4	15.00	30.00	100	10	2026-03-31 00:00:00
4361	Yogurt lala durazno	None	15	4	15.00	30.00	100	10	2026-03-31 00:00:00
4362	Yogurt lala manzana	None	15	4	15.00	30.00	100	10	2026-03-31 00:00:00
4363	Yogurt bebible lala manzana	None	15	4	15.00	30.00	100	10	2026-03-31 00:00:00
4364	Yogurt bebible lala durazno	None	15	4	15.00	30.00	100	10	2026-03-31 00:00:00
4365	Yogurt bebible lala fresa	None	15	4	15.00	30.00	100	10	2026-03-31 00:00:00
4366	Yogurt bebible lala moras	None	15	4	15.00	30.00	100	10	2026-03-31 00:00:00
4367	Yogurt bebible lala pina coco	None	15	4	15.00	30.00	100	10	2026-03-31 00:00:00
4368	Licuado lala fresa platano	None	15	4	15.00	30.00	100	10	2026-03-31 00:00:00
4369	Licuado lala nuez	None	15	4	15.00	30.00	100	10	2026-03-31 00:00:00
4370	Flan lala	None	15	4	15.00	30.00	100	10	2026-03-31 00:00:00
4371	Margarina lala 90gr	None	15	4	15.00	30.00	100	10	2026-03-31 00:00:00
4372	Jabon zote rosa chico	None	42	58	8.00	10.50	100	10	2026-03-31 00:00:00
4373	Jabon zote rosa grande	None	42	58	8.00	10.50	100	10	2026-03-31 00:00:00
4374	Jabon zote blanco chico	None	42	58	8.00	10.50	100	10	2026-03-31 00:00:00
4375	Jabon zote blanco grande	None	42	58	8.00	10.50	100	10	2026-03-31 00:00:00
4376	Perejil ramo		21	58	3.00	5.00	5	1	2026-03-31 00:00:00
4377	Leche entera lala 1lt	Clasica color roja	15	4	15.24	25.00	2	3	2026-04-01 00:00:00
4378	Pepsi	bebida azucarada	31	14	8.00	16.00	77	20	2026-04-01 00:00:00
4379	Manzanita		31	14	17.00	25.00	22	3	2026-04-01 00:00:00
4380	MaruchanTokyo	maruchan picante	2	11	5.50	12.50	15	10	2026-04-01 00:00:00
4381	Harina de maiz maseca	None	10	59	8.00	10.50	100	10	2026-04-01 00:00:00
4382	Sabritas	Sabritas Flamin Hot	9	3	10.00	18.00	4	1	2026-04-01 00:00:00
4383	Galletas marias	Las galletas clasicas	9	3	8.90	15.00	19	2	2026-04-01 00:00:00
4384	Leche Lala entera 1L	Leche Lala entera 1 Litro	15	4	19.00	24.00	100	10	2026-04-01 00:00:00
4385	Tostadas charras	None	5	60	8.00	10.50	100	10	2026-04-01 00:00:00
4386	Leche Lala light 1L	Leche Lala light 1 Litro	15	4	20.00	25.00	100	10	2026-04-01 00:00:00
4387	Leche Santa Clara entera 1L	Leche Santa Clara entera 1 Litro	15	4	22.00	28.00	100	10	2026-04-01 00:00:00
4388	Leche Santa Clara deslactosada 1L	Leche Santa Clara deslactosada 1 Litro	15	4	23.00	29.00	100	10	2026-04-01 00:00:00
4389	Arroz Mexica 1kg	None	2	59	12.00	16.50	100	10	2026-04-01 00:00:00
4390	Del Valle fruit naranja 600ml	Jugo Del Valle sabor Naranja 600 ml	31	28	10.50	13.50	100	10	2026-04-01 00:00:00
4391	Harina de trigo San antonio	None	10	41	8.00	10.50	100	10	2026-04-01 00:00:00
4392	Tortillas de maiz 1/2 kg	None	10	58	8.00	10.50	100	10	2026-04-01 00:00:00
4393	Pan bimbo blanco chico	None	27	17	8.00	10.50	100	10	2026-04-01 00:00:00
4394	Pan bimbo blanco grande	None	27	17	8.00	10.50	100	10	2026-04-01 00:00:00
4395	Pan bimbo integral chico	None	27	17	8.00	10.50	100	10	2026-04-01 00:00:00
4396	Pan bimbo integral grande	None	27	17	8.00	10.50	100	10	2026-04-01 00:00:00
4397	Rebanadas bimbo	None	27	17	8.00	10.50	100	10	2026-04-01 00:00:00
4398	Chocoroles	None	27	17	8.00	10.50	100	10	2026-04-01 00:00:00
4399	Nito bimbo	None	27	17	8.00	10.50	100	10	2026-04-01 00:00:00
4400	Mantecadas	None	27	17	8.00	10.50	100	10	2026-04-01 00:00:00
4401	Roles de canela con pasas	None	27	17	8.00	10.50	100	10	2026-04-01 00:00:00
4402	Roles de canela glaseados	None	27	17	8.00	10.50	100	10	2026-04-01 00:00:00
4403	Conchas bimbo	None	27	17	8.00	10.50	100	10	2026-04-01 00:00:00
4404	Panque de nuez bimbo	None	27	17	8.00	10.50	100	10	2026-04-01 00:00:00
4405	Donitas bimbo	None	27	17	8.00	10.50	100	10	2026-04-01 00:00:00
4406	Donitas espolvoreadas bimbo	None	27	17	8.00	10.50	100	10	2026-04-01 00:00:00
4407	chimichangas	chimichangas	23	10	30.00	45.00	15	5	2026-04-01 00:00:00
4408	Coca Cola 1L	Refresco Coca Cola 1 Litro	31	16	12.00	15.00	100	10	2026-04-01 00:00:00
4484	Pasta Barilla espagueti	None	2	56	10.00	15.00	100	10	2026-04-01 00:00:00
4409	Coca Cola lata 355ml	Refresco Coca Cola 355 ml lata	31	16	8.50	11.00	100	10	2026-04-01 00:00:00
4410	Coca Cola 355ml	Refresco Coca Cola 355 ml	31	16	8.00	10.50	100	10	2026-04-01 00:00:00
4411	Coca Cola 600ml	Refresco Coca Cola 600 ml	31	16	9.00	12.00	100	10	2026-04-01 00:00:00
4412	Coca Cola retornable 1 1/4 lt.	Refresco Coca Cola retornable 1 1/4 lt	31	16	12.50	15.50	100	10	2026-04-01 00:00:00
4413	Coca Cola 2L retornable	Refresco Coca Cola retornable 2 Litros	31	16	19.50	24.00	100	10	2026-04-01 00:00:00
4414	Coca Cola 3L retornable	Refresco Coca Cola retornable 3 Litros	31	16	24.00	30.00	100	10	2026-04-01 00:00:00
4415	Coca Cola Light 600ml	Refresco Coca Cola Light 600 ml	31	16	9.50	12.50	100	10	2026-04-01 00:00:00
4416	Pepsi 600ml	Refresco Pepsi 600 ml	31	14	9.00	12.00	100	10	2026-04-01 00:00:00
4417	Pepsi 1.5L	Refresco Pepsi 1.5 Litros	31	14	12.00	15.50	100	10	2026-04-01 00:00:00
4418	Fanta 600ml	Refresco Fanta 600 ml	31	16	9.00	12.00	100	10	2026-04-01 00:00:00
4419	Fanta 1.5L	Refresco Fanta 1.5 Litros	31	16	12.50	16.00	100	10	2026-04-01 00:00:00
4420	Sprite 600ml	Refresco Sprite 600 ml	31	16	9.00	12.00	100	10	2026-04-01 00:00:00
4421	Sprite 1.5L	Refresco Sprite 1.5 Litros	31	16	12.50	16.00	100	10	2026-04-01 00:00:00
4422	Manzanita 600ml	Refresco Manzanita Sol 600 ml	31	16	9.00	12.00	100	10	2026-04-01 00:00:00
4423	Manzanita 1.5L	Refresco Manzanita Sol 1.5 Litros	31	16	12.50	16.00	100	10	2026-04-01 00:00:00
4424	Fresca 600ml	Refresco Fresca 600 ml	31	16	9.00	12.00	100	10	2026-04-01 00:00:00
4425	Fresca 3L	Refresco Fresca 3 Litros	31	16	24.00	30.00	100	10	2026-04-01 00:00:00
4426	Mirinda 600ml	Refresco Mirinda 600 ml	31	16	9.00	12.00	100	10	2026-04-01 00:00:00
4427	Mirinda 1.5L	Refresco Mirinda 1.5 Litros	31	16	12.50	16.00	100	10	2026-04-01 00:00:00
4428	Tostadas Sanissimo	None	5	61	8.00	10.50	100	10	2026-04-01 00:00:00
4429	Marias gamesa	None	29	46	8.00	10.50	100	10	2026-04-01 00:00:00
4430	Jumex de mango 1L	Jugo Jumex sabor Mango 1 Litro	31	21	16.00	20.00	100	10	2026-04-01 00:00:00
4431	Emperador chocolate	None	29	46	8.00	10.50	100	10	2026-04-01 00:00:00
4432	Emperador nuez	None	29	46	8.00	10.50	100	10	2026-04-01 00:00:00
4433	Emperador vainilla	None	29	46	8.00	10.50	100	10	2026-04-01 00:00:00
4434	Emperador limon	None	29	46	8.00	10.50	100	10	2026-04-01 00:00:00
4435	Jumex de durazno 1L	Jugo Jumex sabor Durazno 1 Litro	31	21	16.00	20.00	100	10	2026-04-01 00:00:00
4436	Jumex de manzana 600ml	Jugo Jumex sabor Manzana 600 ml	31	21	10.00	13.00	100	10	2026-04-01 00:00:00
4437	Roles	Ricos roles de canela caseros	27	13	70.00	100.00	18	10	2026-04-01 00:00:00
4438	Del Valle fruit manzana 600ml	Jugo Del Valle sabor Manzana 600 ml	31	28	10.50	13.50	100	10	2026-04-01 00:00:00
4439	Del Valle fruit guayaba 600ml	Jugo Del Valle sabor Guayaba 600 ml	31	28	10.50	13.50	100	10	2026-04-01 00:00:00
4440	Emperador Senso	None	29	46	8.00	10.50	100	10	2026-04-01 00:00:00
4441	Mamut chico	None	29	46	8.00	10.50	100	10	2026-04-01 00:00:00
4442	Yogurt Lala natural 1L	Yogurt Lala natural 1 Litro	17	4	25.00	30.00	100	10	2026-04-01 00:00:00
4443	Yogurt Lala de fresa 1L	Yogurt Lala sabor Fresa 1 Litro	17	4	25.00	30.00	100	10	2026-04-01 00:00:00
4444	Yogurt Yoplait de fresa 1L	Yogurt Yoplait sabor Fresa 1 Litro	17	54	26.00	31.00	100	10	2026-04-01 00:00:00
4445	Mantequilla Lala 250g	Mantequilla Lala 250 gramos	19	4	30.00	38.00	100	10	2026-04-01 00:00:00
4446	Queso panela Lala 200g	Queso panela Lala 200 gramos	16	4	40.00	50.00	100	10	2026-04-01 00:00:00
4447	Mamut grande	None	29	46	8.00	10.50	100	10	2026-04-01 00:00:00
4448	Chokis	None	29	46	8.00	10.50	100	10	2026-04-01 00:00:00
4449	Chokis rellenas	None	29	46	8.00	10.50	100	10	2026-04-01 00:00:00
4450	Chokis doble chocolate	None	29	46	8.00	10.50	100	10	2026-04-01 00:00:00
4451	Chokis brownie	None	29	46	8.00	10.50	100	10	2026-04-01 00:00:00
4452	Leche Lala deslactosada 1L	Leche Lala deslactosada 1 Litro	15	4	20.00	25.00	100	10	2026-04-01 00:00:00
4453	Queso panela Alpura 200g	Queso panela Alpura 200 gramos	16	18	40.00	50.00	100	10	2026-04-01 00:00:00
4454	Queso oaxaca Lala 200g	Queso Oaxaca Lala 200 gramos	16	4	45.00	55.00	100	10	2026-04-01 00:00:00
4455	Queso manchego Lala 200g	Queso Manchego Lala 200 gramos	16	4	50.00	60.00	100	10	2026-04-01 00:00:00
4456	Salchichas Fud paquete 500g	Salchichas Fud 500 gramos	18	53	30.00	40.00	100	10	2026-04-01 00:00:00
4457	Salchichas San Rafael paquete 500g	Salchichas San Rafael 500 gramos	18	52	35.00	45.00	100	10	2026-04-01 00:00:00
4458	Sidral mundet 600ml	Refresco de manzana de 600ml	31	16	10.00	16.00	20	5	2026-04-01 00:00:00
4459	Sidral mundet 3lt	Refresco de manzana de 3lt	31	16	24.00	30.00	20	5	2026-04-01 00:00:00
4460	Agua bonafont 600ml	None	30	55	8.00	10.50	100	10	2026-04-01 00:00:00
4461	Agua bonafont 1lt	None	30	55	12.00	15.00	100	10	2026-04-01 00:00:00
4462	Agua bonafont 2lt.	None	30	55	14.00	18.00	100	10	2026-04-01 00:00:00
4463	Garrafon bonafont 20lt	None	30	55	19.50	24.00	100	10	2026-04-01 00:00:00
4464	Agua ciel 600ml	None	30	16	8.00	13.00	100	10	2026-04-01 00:00:00
4465	Agua ciel 1lt	None	30	16	10.00	15.00	100	10	2026-04-01 00:00:00
4466	Agua ciel 1.5l	None	30	16	12.00	17.00	100	10	2026-04-01 00:00:00
4467	Agua ciel 2lt	None	30	16	14.00	20.00	100	10	2026-04-01 00:00:00
4468	Agua E-pura 600ml	None	30	14	8.00	13.00	100	10	2026-04-01 00:00:00
4469	Agua E-pura 1lt	None	30	14	10.00	15.00	100	10	2026-04-01 00:00:00
4470	Garrafon E-pura 10lt	None	30	14	18.00	25.00	100	10	2026-04-01 00:00:00
4471	Crema Lala 200ml	None	15	4	8.00	13.00	100	10	2026-04-01 00:00:00
4472	Crema Lala 426ml	None	15	4	15.00	30.00	100	10	2026-04-01 00:00:00
4473	Crema Lala 900ml	None	15	4	35.00	55.00	100	10	2026-04-01 00:00:00
4474	Crema alpura 200ml	None	15	4	8.00	13.00	100	10	2026-04-01 00:00:00
4475	Crema alpura 426ml	None	15	4	15.00	30.00	100	10	2026-04-01 00:00:00
4476	Crema alpura 900ml	None	15	4	35.00	55.00	100	10	2026-04-01 00:00:00
4477	Atun dolores en agua	None	6	51	10.00	15.00	100	10	2026-04-01 00:00:00
4478	Atun dolores en aceite	None	6	51	12.00	17.00	100	10	2026-04-01 00:00:00
4479	Sardinas en aceite	None	6	20	10.00	15.00	100	10	2026-04-01 00:00:00
4480	Frijoles refritos	None	6	50	10.00	15.00	100	10	2026-04-01 00:00:00
4481	Frijoles bayos	None	6	50	10.00	15.00	100	10	2026-04-01 00:00:00
4482	Pasta la moderna	None	2	44	10.00	15.00	100	10	2026-04-01 00:00:00
4483	Coditos la moderna	None	2	44	10.00	15.00	100	10	2026-04-01 00:00:00
4485	Sopa de letras la moderna	None	2	44	10.00	15.00	100	10	2026-04-01 00:00:00
4486	Sopa maruchan pollo	None	2	57	10.00	15.00	100	10	2026-04-01 00:00:00
4487	Sopa maruchan camaron	None	2	57	10.00	15.00	100	10	2026-04-01 00:00:00
4488	Sopa maruchan res	None	2	57	10.00	15.00	100	10	2026-04-01 00:00:00
4489	Sopa maruchan habanero	None	2	57	10.00	15.00	100	10	2026-04-01 00:00:00
4490	Sopa maruchan piquin	None	2	57	10.00	15.00	100	10	2026-04-01 00:00:00
4491	Sopa maruchan limon	None	2	57	10.00	15.00	100	10	2026-04-01 00:00:00
4492	Lentejas la moderna	None	2	44	10.00	15.00	100	10	2026-04-01 00:00:00
4493	Jamon de pavo Fud 250g	Jamon de Pavo Fud 250 gramos	18	53	35.00	45.00	100	10	2026-04-01 00:00:00
4494	Jamon de pavo San Rafael 250g	Jamon de Pavo San Rafael 250 gramos	18	52	40.00	50.00	100	10	2026-04-01 00:00:00
4495	Cremax chocolate	None	29	46	8.00	10.50	100	10	2026-04-01 00:00:00
4496	Cremax fresa	None	29	46	8.00	10.50	100	10	2026-04-01 00:00:00
4497	Florentinas gamesa	None	29	46	8.00	10.50	100	10	2026-04-01 00:00:00
4498	Marias doradas	None	29	46	8.00	10.50	100	10	2026-04-01 00:00:00
4499	Gamesa cajeta	None	29	46	8.00	10.50	100	10	2026-04-01 00:00:00
4500	Maravillas gamesa	None	29	46	8.00	10.50	100	10	2026-04-01 00:00:00
4501	Crackets gamesa	None	29	46	8.00	10.50	100	10	2026-04-01 00:00:00
4502	Surtido rico gamesa	None	29	46	8.00	10.50	100	10	2026-04-01 00:00:00
4503	Delicias gamesa	None	29	46	8.00	10.50	100	10	2026-04-01 00:00:00
4504	Oreo	None	9	58	8.00	10.50	100	10	2026-04-01 00:00:00
4505	Principe chocolate	None	9	22	8.00	10.50	100	10	2026-04-01 00:00:00
4506	Principe vainilla	None	9	22	8.00	10.50	100	10	2026-04-01 00:00:00
4507	Principe limon	None	9	22	8.00	10.50	100	10	2026-04-01 00:00:00
4508	Principe chocolate blanco	None	9	22	8.00	10.50	100	10	2026-04-01 00:00:00
4509	Lors	None	9	22	8.00	10.50	100	10	2026-04-01 00:00:00
4510	Plativolos	None	9	22	8.00	10.50	100	10	2026-04-01 00:00:00
4511	Sponch	None	9	22	8.00	10.50	100	10	2026-04-01 00:00:00
4512	Triki trakes	None	9	22	8.00	10.50	100	10	2026-04-01 00:00:00
4513	MaxiTubo Triki trakes	None	9	22	8.00	10.50	100	10	2026-04-01 00:00:00
4514	Gansito	None	9	22	8.00	10.50	100	10	2026-04-01 00:00:00
4515	Pinguinos	None	9	22	8.00	10.50	100	10	2026-04-01 00:00:00
4516	Pasticetas marinela	None	9	22	8.00	10.50	100	10	2026-04-01 00:00:00
4517	Barritas fresa	None	9	22	8.00	10.50	100	10	2026-04-01 00:00:00
4518	Barritas pina	None	9	22	8.00	10.50	100	10	2026-04-01 00:00:00
4519	Barritas moras	None	9	22	8.00	10.50	100	10	2026-04-01 00:00:00
4520	Maxitubo Barritas pina	None	9	22	8.00	10.50	100	10	2026-04-01 00:00:00
4521	Canelitas	None	9	22	8.00	10.50	100	10	2026-04-01 00:00:00
4522	Polvorones	None	9	22	8.00	10.50	100	10	2026-04-01 00:00:00
4523	Maxitubo Polvorones	None	9	22	8.00	10.50	100	10	2026-04-01 00:00:00
4524	Ricanelas	None	9	46	8.00	10.50	100	10	2026-04-01 00:00:00
4525	Ritz bits queso	None	9	58	8.00	10.50	100	10	2026-04-01 00:00:00
4526	Arcoiris	None	9	46	8.00	10.50	100	10	2026-04-01 00:00:00
4527	Submarinos fresa	None	9	22	8.00	10.50	100	10	2026-04-01 00:00:00
4528	Submarinos vainilla	None	9	22	8.00	10.50	100	10	2026-04-01 00:00:00
4529	Submarinos chocolate	None	9	22	8.00	10.50	100	10	2026-04-01 00:00:00
4530	Rocko chico	None	9	22	8.00	10.50	100	10	2026-04-01 00:00:00
4531	Rocko grande	None	9	22	8.00	10.50	100	10	2026-04-01 00:00:00
4532	Sabritas original	None	9	3	8.00	10.50	100	10	2026-04-01 00:00:00
4533	Sabritas adobadas	None	9	3	8.00	10.50	100	10	2026-04-01 00:00:00
4534	Sabritas limon	None	9	3	8.00	10.50	100	10	2026-04-01 00:00:00
4535	Sabritas flamin hot	None	9	3	8.00	10.50	100	10	2026-04-01 00:00:00
4536	Sabritas crema y especias	None	9	3	8.00	10.50	100	10	2026-04-01 00:00:00
4537	Sabritas habanero	None	9	3	8.00	10.50	100	10	2026-04-01 00:00:00
4538	Sabritas receta crujiente	None	9	3	8.00	10.50	100	10	2026-04-01 00:00:00
4539	Chips jalapeno	None	9	47	8.00	10.50	100	10	2026-04-01 00:00:00
4540	Crujitos	None	9	3	8.00	10.50	100	10	2026-04-01 00:00:00
4541	Doritos nacho	None	9	3	8.00	10.50	100	10	2026-04-01 00:00:00
4542	Doritos incognita	None	9	3	8.00	10.50	100	10	2026-04-01 00:00:00
4543	Doritos diablo	None	9	3	8.00	10.50	100	10	2026-04-01 00:00:00
4544	Doritos flamin hot	None	9	3	8.00	10.50	100	10	2026-04-01 00:00:00
4545	Doritos dinamita	None	9	3	8.00	10.50	100	10	2026-04-01 00:00:00
4546	Sabritones	None	9	3	8.00	10.50	100	10	2026-04-01 00:00:00
4547	Bigmix queso	None	9	47	8.00	10.50	100	10	2026-04-01 00:00:00
4548	Bigmix fuego	None	9	47	8.00	10.50	100	10	2026-04-01 00:00:00
4549	Cheetos torciditos	None	9	3	8.00	10.50	100	10	2026-04-01 00:00:00
4550	Cheetos bolitas	None	9	3	8.00	10.50	100	10	2026-04-01 00:00:00
4551	Cheetos queso	None	9	3	8.00	10.50	100	10	2026-04-01 00:00:00
4552	Cheetos flamin hot	None	9	3	8.00	10.50	100	10	2026-04-01 00:00:00
4553	Ruffles original	None	9	3	8.00	10.50	100	10	2026-04-01 00:00:00
4554	Ruffles queso	None	9	3	8.00	10.50	100	10	2026-04-01 00:00:00
4555	Fritos sal y limon	None	9	3	8.00	10.50	100	10	2026-04-01 00:00:00
4556	Fritos chorizo	None	9	3	8.00	10.50	100	10	2026-04-01 00:00:00
4557	Bolsaza Sabritas original	None	9	3	8.00	10.50	100	10	2026-04-01 00:00:00
4558	Bolsaza Doritos nacho	None	9	3	8.00	10.50	100	10	2026-04-01 00:00:00
4559	Paketaxo	None	9	3	8.00	10.50	100	10	2026-04-01 00:00:00
4560	Paketaxo queso	None	9	3	8.00	10.50	100	10	2026-04-01 00:00:00
4561	Paketaxo flamin hot	None	9	3	8.00	10.50	100	10	2026-04-01 00:00:00
4562	Churrumaiz	None	9	3	8.00	10.50	100	10	2026-04-01 00:00:00
4563	Churrumaiz flamin hot	None	9	3	8.00	10.50	100	10	2026-04-01 00:00:00
4564	Rancheritos	None	9	3	8.00	10.50	100	10	2026-04-01 00:00:00
4565	Sabritas switch doritos nacho	None	9	3	8.00	10.50	100	10	2026-04-01 00:00:00
4566	Runners	None	9	47	8.00	10.50	100	10	2026-04-01 00:00:00
4567	Chips sal	None	9	47	8.00	10.50	100	10	2026-04-01 00:00:00
4568	Papatinas	None	9	47	8.00	10.50	100	10	2026-04-01 00:00:00
4569	Chips fuego	None	9	47	8.00	10.50	100	10	2026-04-01 00:00:00
4570	Palomitas pop	None	9	47	8.00	10.50	100	10	2026-04-01 00:00:00
4571	Takis original 	None	9	47	8.00	10.50	100	10	2026-04-01 00:00:00
4572	Takis fuego	None	9	47	8.00	10.50	100	10	2026-04-01 00:00:00
4573	Takis salsa brava	None	9	47	8.00	10.50	100	10	2026-04-01 00:00:00
4574	Takis guacamole	None	9	47	8.00	10.50	100	10	2026-04-01 00:00:00
4575	Chipotles	None	9	47	8.00	10.50	100	10	2026-04-01 00:00:00
4576	Tostachos	None	9	47	8.00	10.50	100	10	2026-04-01 00:00:00
4577	Hot nuts	None	9	47	8.00	10.50	100	10	2026-04-01 00:00:00
4578	Hot nuts fuego	None	9	47	8.00	10.50	100	10	2026-04-01 00:00:00
4579	Valentones	None	9	47	8.00	10.50	100	10	2026-04-01 00:00:00
4580	Watz barcel	None	9	47	8.00	10.50	100	10	2026-04-01 00:00:00
4581	Toreadas	None	9	47	8.00	10.50	100	10	2026-04-01 00:00:00
4582	Palomitas pop fuego	None	9	47	8.00	10.50	100	10	2026-04-01 00:00:00
4583	Takis blue heat	None	9	47	8.00	10.50	100	10	2026-04-01 00:00:00
4584	Doraditas tia rosa	None	29	49	8.00	10.50	100	10	2026-04-01 00:00:00
4585	Sabritas receta crujiente jalapeno	None	9	3	8.00	10.50	100	10	2026-04-01 00:00:00
4586	Tortillinas tia rosa	None	10	49	8.00	10.50	100	10	2026-04-01 00:00:00
4587	Conchas tia rosa	None	29	49	8.00	10.50	100	10	2026-04-01 00:00:00
4588	Hersheys Cookies n Cream	None	8	45	8.00	10.50	100	10	2026-04-01 00:00:00
4589	Hersheys almendras	None	8	45	8.00	10.50	100	10	2026-04-01 00:00:00
4590	Hersheys chocolate amargo	None	8	45	8.00	10.50	100	10	2026-04-01 00:00:00
4591	Hersheys chocolate blanco	None	8	45	8.00	10.50	100	10	2026-04-01 00:00:00
4592	Crunch	None	8	19	8.00	10.50	100	10	2026-04-01 00:00:00
4593	Carlos V	None	8	19	8.00	10.50	100	10	2026-04-01 00:00:00
4594	Milky way	None	8	19	8.00	10.50	100	10	2026-04-01 00:00:00
4595	Snickers	None	8	19	8.00	10.50	100	10	2026-04-01 00:00:00
4596	Kit kat	None	8	19	8.00	10.50	100	10	2026-04-01 00:00:00
4597	Kinder delice	None	8	40	8.00	10.50	100	10	2026-04-01 00:00:00
4598	Kinder sorpresa	None	8	40	8.00	10.50	100	10	2026-04-01 00:00:00
4599	Ferrero rocher 3 piezas	None	8	40	8.00	10.50	100	10	2026-04-01 00:00:00
4600	Mazapan	None	8	62	8.00	10.50	100	10	2026-04-01 00:00:00
4601	Pelon pelo rico	None	8	45	8.00	10.50	100	10	2026-04-01 00:00:00
4602	Pulparindo tamarindo	None	8	62	8.00	10.50	100	10	2026-04-01 00:00:00
4603	Pulparindo chamoy	None	8	62	8.00	10.50	100	10	2026-04-01 00:00:00
4604	Tutsi pop	None	8	65	8.00	10.50	100	10	2026-04-01 00:00:00
4605	Oblea cajeta coronado	None	8	66	8.00	10.50	100	10	2026-04-01 00:00:00
4606	Paleta payaso	None	8	67	8.00	10.50	100	10	2026-04-01 00:00:00
4607	Duvalin fresa vainilla	None	8	67	8.00	10.50	100	10	2026-04-01 00:00:00
4608	Duvalin chocolate vainilla	None	8	67	8.00	10.50	100	10	2026-04-01 00:00:00
4609	Duvalin vainilla	None	8	67	8.00	10.50	100	10	2026-04-01 00:00:00
4610	Duvalin trisabor	None	8	67	8.00	10.50	100	10	2026-04-01 00:00:00
4611	Duvalin choco avellana	None	8	67	8.00	10.50	100	10	2026-04-01 00:00:00
4612	Paleta Vero mango	None	8	68	8.00	10.50	100	10	2026-04-01 00:00:00
4613	Paleta Vero elote	None	8	67	8.00	10.50	100	10	2026-04-01 00:00:00
4614	Panditas	None	8	67	8.00	10.50	100	10	2026-04-01 00:00:00
4615	Panditas rellenos	None	8	67	8.00	10.50	100	10	2026-04-01 00:00:00
4616	Panditas san valentin	None	8	67	8.00	10.50	100	10	2026-04-01 00:00:00
4617	Bubulubu	None	8	67	8.00	10.50	100	10	2026-04-01 00:00:00
4618	Rockaleta	None	8	69	8.00	10.50	100	10	2026-04-01 00:00:00
4619	Tic tac menta	None	8	40	8.00	10.50	100	10	2026-04-01 00:00:00
4620	Halls menta	None	8	58	8.00	10.50	100	10	2026-04-01 00:00:00
4621	Halls limon	None	8	58	8.00	10.50	100	10	2026-04-01 00:00:00
4622	Halls yerba buena	None	8	58	8.00	10.50	100	10	2026-04-01 00:00:00
4623	Halls miel	None	8	58	8.00	10.50	100	10	2026-04-01 00:00:00
4624	Halls negras	None	8	58	8.00	10.50	100	10	2026-04-01 00:00:00
4625	Gomilocas dientes	None	8	67	8.00	10.50	100	10	2026-04-01 00:00:00
4626	Gomilocas pinguino	None	8	67	8.00	10.50	100	10	2026-04-01 00:00:00
4627	Chocoretas	None	8	67	8.00	10.50	100	10	2026-04-01 00:00:00
4628	Kranky	None	8	67	8.00	10.50	100	10	2026-04-01 00:00:00
4629	Lucas muecas	None	8	58	8.00	10.50	100	10	2026-04-01 00:00:00
4630	Lucas chamoy	None	8	58	8.00	10.50	100	10	2026-04-01 00:00:00
4631	Lucas gusanito	None	8	58	8.00	10.50	100	10	2026-04-01 00:00:00
4632	Palomitas Act II mantequilla	None	9	58	8.00	10.50	100	10	2026-04-01 00:00:00
4633	Palomitas Act II natural	None	9	58	8.00	10.50	100	10	2026-04-01 00:00:00
4634	Palomitas Act II chile limon	None	9	58	8.00	10.50	100	10	2026-04-01 00:00:00
4635	Tostitos salsa verde	None	9	3	8.00	10.50	100	10	2026-04-01 00:00:00
4636	Zucaritas chicas	None	5	26	8.00	10.50	100	10	2026-04-01 00:00:00
4637	Zucaritas grandes	None	5	26	8.00	10.50	100	10	2026-04-01 00:00:00
4638	Corn flakes chicas	None	5	26	8.00	10.50	100	10	2026-04-01 00:00:00
4639	Corn flakes grandes	None	5	26	8.00	10.50	100	10	2026-04-01 00:00:00
4640	Choco Krispis chicas	None	5	26	8.00	10.50	100	10	2026-04-01 00:00:00
4641	Choco Krispis grandes	None	5	26	8.00	10.50	100	10	2026-04-01 00:00:00
4642	Nesquik chico	None	5	26	8.00	10.50	100	10	2026-04-01 00:00:00
4643	Nesquik grande	None	5	26	8.00	10.50	100	10	2026-04-01 00:00:00
4644	Froot loops chicas	None	5	26	8.00	10.50	100	10	2026-04-01 00:00:00
4645	Froot loops grandes	None	5	26	8.00	10.50	100	10	2026-04-01 00:00:00
4646	Chocomilk sobre	None	4	58	8.00	10.50	100	10	2026-04-01 00:00:00
4647	Chocomilk bolsa	None	4	58	8.00	10.50	100	10	2026-04-01 00:00:00
4648	Chocomilk lata	None	4	58	8.00	10.50	100	10	2026-04-01 00:00:00
4649	Nescafe clasico sobre	None	4	19	8.00	10.50	100	10	2026-04-01 00:00:00
4650	Nescafe capuccino sobre	None	4	19	8.00	10.50	100	10	2026-04-01 00:00:00
4651	Nescafe clasico bote chico	None	4	19	8.00	10.50	100	10	2026-04-01 00:00:00
4652	Nescafe clasico bote grande	None	4	19	8.00	10.50	100	10	2026-04-01 00:00:00
4653	Azucar Zulka 1kg	None	3	58	8.00	10.50	100	10	2026-04-01 00:00:00
4654	Azucar refinada 1kg	None	3	58	8.00	10.50	100	10	2026-04-01 00:00:00
4655	Azucar refinada 500gr	None	3	58	8.00	10.50	100	10	2026-04-01 00:00:00
4656	Azucar refinada 250gr	None	3	58	8.00	10.50	100	10	2026-04-01 00:00:00
4657	Aceite nutrioli 1lt	None	1	58	8.00	10.50	100	10	2026-04-01 00:00:00
4658	Aceite capullo 1lt	None	1	58	8.00	10.50	100	10	2026-04-01 00:00:00
4659	Aceite 1 2 3 1lt	None	1	58	8.00	10.50	100	10	2026-04-01 00:00:00
4660	Aceite patrona 1lt	None	1	58	8.00	10.50	100	10	2026-04-01 00:00:00
4661	Vinagre blanco la coste¤a	None	1	27	8.00	10.50	100	10	2026-04-01 00:00:00
4662	Vinagre de manzana la coste¤a	None	1	27	8.00	10.50	100	10	2026-04-01 00:00:00
4663	Catsup la coste¤a	None	1	27	8.00	10.50	100	10	2026-04-01 00:00:00
4664	Catsup Del monte	None	1	70	8.00	10.50	100	10	2026-04-01 00:00:00
4665	Catsup heinz	None	1	71	8.00	10.50	100	10	2026-04-01 00:00:00
4666	Jugo Magui	None	7	19	8.00	10.50	100	10	2026-04-01 00:00:00
4667	Salsa inglesa	None	7	19	8.00	10.50	100	10	2026-04-01 00:00:00
4668	Salsa valentina chica	None	7	58	8.00	10.50	100	10	2026-04-01 00:00:00
4669	Salsa valentina grande	None	7	58	8.00	10.50	100	10	2026-04-01 00:00:00
4670	Salsa tabasco	None	7	58	8.00	10.50	100	10	2026-04-01 00:00:00
4671	Salsa buffalo	None	7	58	8.00	10.50	100	10	2026-04-01 00:00:00
4672	Salsa chipotle la coste¤a	None	7	27	8.00	10.50	100	10	2026-04-01 00:00:00
4673	Chile chipotle la coste¤a	None	6	27	8.00	10.50	100	10	2026-04-01 00:00:00
4674	Tic tac naranja	None	8	40	8.00	10.50	100	10	2026-04-01 00:00:00
4675	Yogurt Yoplait natural 1L	Yogurt Yoplait natural 1 Litro	17	54	26.00	31.00	100	10	2026-04-01 00:00:00
4676	Cremax vainilla	None	29	46	8.00	10.50	100	10	2026-04-01 00:00:00
4677	Maxitubo Barritas fresa	None	9	22	8.00	10.50	100	10	2026-04-01 00:00:00
4678	Bigote tia rosa	None	29	49	8.00	10.50	100	10	2026-04-01 00:00:00
4679	Magdalenas tia rosa	None	29	49	8.00	10.50	100	10	2026-04-01 00:00:00
4680	Chiles serranos la coste¤a	None	6	27	8.00	10.50	100	10	2026-04-01 00:00:00
4681	Chiles en vinagre la coste¤a	None	6	27	8.00	10.50	100	10	2026-04-01 00:00:00
4682	Chile chipotle la morena	None	6	72	8.00	10.50	100	10	2026-04-01 00:00:00
4683	Chiles en vinagre la morena	None	6	72	8.00	10.50	100	10	2026-04-01 00:00:00
4684	Mayonesa mccormick chica	None	7	72	8.00	10.50	100	10	2026-04-01 00:00:00
4685	Mayonesa mccormick grande	None	7	72	8.00	10.50	100	10	2026-04-01 00:00:00
4686	Mostaza mccormick	None	7	72	8.00	10.50	100	10	2026-04-01 00:00:00
4687	Mermelada mccormick fresa chica	None	19	72	8.00	10.50	100	10	2026-04-01 00:00:00
4688	Mermelada mccormick fresa grande	None	19	72	8.00	10.50	100	10	2026-04-01 00:00:00
4689	Cloralex 1/2 lt	None	35	58	8.00	10.50	100	10	2026-04-01 00:00:00
4690	Cloralex 1 lt	None	35	58	8.00	10.50	100	10	2026-04-01 00:00:00
4691	Pinol	None	35	58	8.00	10.50	100	10	2026-04-01 00:00:00
4692	Fabuloso lavanda 1lt	None	35	58	8.00	10.50	100	10	2026-04-01 00:00:00
4693	Fabuloso aroma floral 1lt	None	35	58	8.00	10.50	100	10	2026-04-01 00:00:00
4694	Detergente Ariel 1/2 kg	None	34	58	8.00	10.50	100	10	2026-04-01 00:00:00
4695	Detergente Ariel 1kg	None	34	58	8.00	10.50	100	10	2026-04-01 00:00:00
4696	Detergente Ace 1/2 kg	None	34	58	8.00	10.50	100	10	2026-04-01 00:00:00
4697	Detergente Ace 1kg	None	34	58	8.00	10.50	100	10	2026-04-01 00:00:00
4698	Detergente Foca 1/2 kg	None	34	58	8.00	10.50	100	10	2026-04-01 00:00:00
4699	Detergente Foca 1kg	None	34	58	8.00	10.50	100	10	2026-04-01 00:00:00
4700	Suavitel 1l	None	34	58	8.00	10.50	100	10	2026-04-01 00:00:00
4701	Papel higienico Petalo 4 rollos	None	37	58	8.00	10.50	100	10	2026-04-01 00:00:00
4702	Papel higienico Petalo 6 rollos	None	37	58	8.00	10.50	100	10	2026-04-01 00:00:00
4703	Papel higienico Suavel 4 rollos	None	37	58	8.00	10.50	100	10	2026-04-01 00:00:00
4704	Papel higienico Suavel 6 rollos	None	37	58	8.00	10.50	100	10	2026-04-01 00:00:00
4705	Toallas sanitarias Always	None	37	58	8.00	10.50	100	10	2026-04-01 00:00:00
4706	Toallas sanitarias Kotex	None	37	58	8.00	10.50	100	10	2026-04-01 00:00:00
4707	Panales Huggies	None	44	58	8.00	10.50	100	10	2026-04-01 00:00:00
4708	Shampoo Head & Shoulders chico	None	39	58	8.00	10.50	100	10	2026-04-01 00:00:00
4709	Shampoo Head & Shoulders grande	None	39	58	8.00	10.50	100	10	2026-04-01 00:00:00
4710	Desodorante Axe	None	41	58	8.00	10.50	100	10	2026-04-01 00:00:00
4711	Leche deslactosada 1lt	Presentacion azul	15	4	18.20	23.00	14	2	2026-04-01 00:00:00
4712	Yomi lala chocolate	None	15	4	15.00	30.00	100	10	2026-04-01 00:00:00
4713	Yomi lala vainilla	None	15	4	15.00	30.00	100	10	2026-04-01 00:00:00
4714	Yomi lala fresa	None	15	4	15.00	30.00	100	10	2026-04-01 00:00:00
4715	Yogurt lala fresa	None	15	4	15.00	30.00	100	10	2026-04-01 00:00:00
4716	Yogurt lala durazno	None	15	4	15.00	30.00	100	10	2026-04-01 00:00:00
4717	Yogurt lala manzana	None	15	4	15.00	30.00	100	10	2026-04-01 00:00:00
4718	Yogurt bebible lala manzana	None	15	4	15.00	30.00	100	10	2026-04-01 00:00:00
4719	Yogurt bebible lala durazno	None	15	4	15.00	30.00	100	10	2026-04-01 00:00:00
4720	Yogurt bebible lala fresa	None	15	4	15.00	30.00	100	10	2026-04-01 00:00:00
4721	Yogurt bebible lala moras	None	15	4	15.00	30.00	100	10	2026-04-01 00:00:00
4722	Yogurt bebible lala pina coco	None	15	4	15.00	30.00	100	10	2026-04-01 00:00:00
4723	Licuado lala fresa platano	None	15	4	15.00	30.00	100	10	2026-04-01 00:00:00
4724	Licuado lala nuez	None	15	4	15.00	30.00	100	10	2026-04-01 00:00:00
4725	Flan lala	None	15	4	15.00	30.00	100	10	2026-04-01 00:00:00
4726	Margarina lala 90gr	None	15	4	15.00	30.00	100	10	2026-04-01 00:00:00
4727	Jabon zote rosa chico	None	42	58	8.00	10.50	100	10	2026-04-01 00:00:00
4728	Jabon zote rosa grande	None	42	58	8.00	10.50	100	10	2026-04-01 00:00:00
4729	Jabon zote blanco chico	None	42	58	8.00	10.50	100	10	2026-04-01 00:00:00
4730	Jabon zote blanco grande	None	42	58	8.00	10.50	100	10	2026-04-01 00:00:00
4731	Perejil ramo		21	58	3.00	5.00	5	1	2026-04-01 00:00:00
4732	chimichangas	chimichangas	23	10	30.00	45.00	15	5	2026-04-08 00:00:00
4733	Manzanita		31	14	17.00	25.00	22	3	2026-04-08 00:00:00
4734	Sabritas	Sabritas Flamin Hot	9	3	10.00	18.00	4	1	2026-04-08 00:00:00
4735	Roles	Ricos roles de canela caseros	27	13	70.00	100.00	18	10	2026-04-08 00:00:00
4736	Harina de trigo San antonio	None	10	41	8.00	10.50	100	10	2026-04-08 00:00:00
4737	Coca Cola 1L	Refresco Coca Cola 1 Litro	31	16	12.00	15.00	100	10	2026-04-08 00:00:00
4738	Leche entera lala 1lt	Clasica color roja	15	4	15.24	25.00	2	3	2026-04-08 00:00:00
4739	Galletas marias	Las galletas clasicas	9	3	8.90	15.00	19	2	2026-04-08 00:00:00
4816	Frijoles refritos	None	6	50	10.00	15.00	100	10	2026-04-08 00:00:00
4740	Leche Lala deslactosada 1L	Leche Lala deslactosada 1 Litro	15	4	20.00	25.00	100	10	2026-04-08 00:00:00
4741	Tostadas Sanissimo	None	5	61	8.00	10.50	100	10	2026-04-08 00:00:00
4742	Leche Santa Clara entera 1L	Leche Santa Clara entera 1 Litro	15	4	22.00	28.00	100	10	2026-04-08 00:00:00
4743	Leche Santa Clara deslactosada 1L	Leche Santa Clara deslactosada 1 Litro	15	4	23.00	29.00	100	10	2026-04-08 00:00:00
4744	Yogurt Lala natural 1L	Yogurt Lala natural 1 Litro	17	4	25.00	30.00	100	10	2026-04-08 00:00:00
4745	Harina de maiz maseca	None	10	59	8.00	10.50	100	10	2026-04-08 00:00:00
4746	Del Valle fruit manzana 600ml	Jugo Del Valle sabor Manzana 600 ml	31	28	10.50	13.50	100	10	2026-04-08 00:00:00
4747	Tortillas de maiz 1/2 kg	None	10	58	8.00	10.50	100	10	2026-04-08 00:00:00
4748	Pan bimbo blanco chico	None	27	17	8.00	10.50	100	10	2026-04-08 00:00:00
4749	Pan bimbo blanco grande	None	27	17	8.00	10.50	100	10	2026-04-08 00:00:00
4750	Pan bimbo integral chico	None	27	17	8.00	10.50	100	10	2026-04-08 00:00:00
4751	Pan bimbo integral grande	None	27	17	8.00	10.50	100	10	2026-04-08 00:00:00
4752	Rebanadas bimbo	None	27	17	8.00	10.50	100	10	2026-04-08 00:00:00
4753	Chocoroles	None	27	17	8.00	10.50	100	10	2026-04-08 00:00:00
4754	Nito bimbo	None	27	17	8.00	10.50	100	10	2026-04-08 00:00:00
4755	Mantecadas	None	27	17	8.00	10.50	100	10	2026-04-08 00:00:00
4756	Roles de canela con pasas	None	27	17	8.00	10.50	100	10	2026-04-08 00:00:00
4757	Roles de canela glaseados	None	27	17	8.00	10.50	100	10	2026-04-08 00:00:00
4758	Conchas bimbo	None	27	17	8.00	10.50	100	10	2026-04-08 00:00:00
4759	Panque de nuez bimbo	None	27	17	8.00	10.50	100	10	2026-04-08 00:00:00
4760	Donitas bimbo	None	27	17	8.00	10.50	100	10	2026-04-08 00:00:00
4761	Donitas espolvoreadas bimbo	None	27	17	8.00	10.50	100	10	2026-04-08 00:00:00
4762	Tostadas charras	None	5	60	8.00	10.50	100	10	2026-04-08 00:00:00
4763	MaruchanTokyo	maruchan picante	2	11	5.50	12.50	15	10	2026-04-08 00:00:00
4764	Coca Cola lata 355ml	Refresco Coca Cola 355 ml lata	31	16	8.50	11.00	100	10	2026-04-08 00:00:00
4765	Coca Cola 355ml	Refresco Coca Cola 355 ml	31	16	8.00	10.50	100	10	2026-04-08 00:00:00
4766	Coca Cola 600ml	Refresco Coca Cola 600 ml	31	16	9.00	12.00	100	10	2026-04-08 00:00:00
4767	Coca Cola retornable 1 1/4 lt.	Refresco Coca Cola retornable 1 1/4 lt	31	16	12.50	15.50	100	10	2026-04-08 00:00:00
4768	Coca Cola 2L retornable	Refresco Coca Cola retornable 2 Litros	31	16	19.50	24.00	100	10	2026-04-08 00:00:00
4769	Coca Cola 3L retornable	Refresco Coca Cola retornable 3 Litros	31	16	24.00	30.00	100	10	2026-04-08 00:00:00
4770	Coca Cola Light 600ml	Refresco Coca Cola Light 600 ml	31	16	9.50	12.50	100	10	2026-04-08 00:00:00
4771	Pepsi 600ml	Refresco Pepsi 600 ml	31	14	9.00	12.00	100	10	2026-04-08 00:00:00
4772	Pepsi 1.5L	Refresco Pepsi 1.5 Litros	31	14	12.00	15.50	100	10	2026-04-08 00:00:00
4773	Fanta 600ml	Refresco Fanta 600 ml	31	16	9.00	12.00	100	10	2026-04-08 00:00:00
4774	Fanta 1.5L	Refresco Fanta 1.5 Litros	31	16	12.50	16.00	100	10	2026-04-08 00:00:00
4775	Sprite 600ml	Refresco Sprite 600 ml	31	16	9.00	12.00	100	10	2026-04-08 00:00:00
4776	Sprite 1.5L	Refresco Sprite 1.5 Litros	31	16	12.50	16.00	100	10	2026-04-08 00:00:00
4777	Manzanita 600ml	Refresco Manzanita Sol 600 ml	31	16	9.00	12.00	100	10	2026-04-08 00:00:00
4778	Manzanita 1.5L	Refresco Manzanita Sol 1.5 Litros	31	16	12.50	16.00	100	10	2026-04-08 00:00:00
4779	Fresca 600ml	Refresco Fresca 600 ml	31	16	9.00	12.00	100	10	2026-04-08 00:00:00
4780	Fresca 3L	Refresco Fresca 3 Litros	31	16	24.00	30.00	100	10	2026-04-08 00:00:00
4781	Mirinda 600ml	Refresco Mirinda 600 ml	31	16	9.00	12.00	100	10	2026-04-08 00:00:00
4782	Mirinda 1.5L	Refresco Mirinda 1.5 Litros	31	16	12.50	16.00	100	10	2026-04-08 00:00:00
4783	Jumex de mango 1L	Jugo Jumex sabor Mango 1 Litro	31	21	16.00	20.00	100	10	2026-04-08 00:00:00
4784	Marias gamesa	None	29	46	8.00	10.50	100	10	2026-04-08 00:00:00
4785	Emperador chocolate	None	29	46	8.00	10.50	100	10	2026-04-08 00:00:00
4786	Jumex de durazno 1L	Jugo Jumex sabor Durazno 1 Litro	31	21	16.00	20.00	100	10	2026-04-08 00:00:00
4787	Emperador nuez	None	29	46	8.00	10.50	100	10	2026-04-08 00:00:00
4788	Emperador vainilla	None	29	46	8.00	10.50	100	10	2026-04-08 00:00:00
4789	Emperador limon	None	29	46	8.00	10.50	100	10	2026-04-08 00:00:00
4790	Emperador Senso	None	29	46	8.00	10.50	100	10	2026-04-08 00:00:00
4791	Jumex de manzana 600ml	Jugo Jumex sabor Manzana 600 ml	31	21	10.00	13.00	100	10	2026-04-08 00:00:00
4792	Del Valle fruit naranja 600ml	Jugo Del Valle sabor Naranja 600 ml	31	28	10.50	13.50	100	10	2026-04-08 00:00:00
4793	Pepsi	bebida azucarada	31	14	8.00	16.00	77	20	2026-04-08 00:00:00
4794	Del Valle fruit guayaba 600ml	Jugo Del Valle sabor Guayaba 600 ml	31	28	10.50	13.50	100	10	2026-04-08 00:00:00
4795	Leche Lala entera 1L	Leche Lala entera 1 Litro	15	4	19.00	24.00	100	10	2026-04-08 00:00:00
4796	Mamut chico	None	29	46	8.00	10.50	100	10	2026-04-08 00:00:00
4797	Mamut grande	None	29	46	8.00	10.50	100	10	2026-04-08 00:00:00
4798	Yogurt Lala de fresa 1L	Yogurt Lala sabor Fresa 1 Litro	17	4	25.00	30.00	100	10	2026-04-08 00:00:00
4799	Yogurt Yoplait de fresa 1L	Yogurt Yoplait sabor Fresa 1 Litro	17	54	26.00	31.00	100	10	2026-04-08 00:00:00
4800	Mantequilla Lala 250g	Mantequilla Lala 250 gramos	19	4	30.00	38.00	100	10	2026-04-08 00:00:00
4801	Queso panela Lala 200g	Queso panela Lala 200 gramos	16	4	40.00	50.00	100	10	2026-04-08 00:00:00
4802	Arroz Mexica 1kg	None	2	59	12.00	16.50	100	10	2026-04-08 00:00:00
4803	Chokis	None	29	46	8.00	10.50	100	10	2026-04-08 00:00:00
4804	Chokis rellenas	None	29	46	8.00	10.50	100	10	2026-04-08 00:00:00
4805	Chokis doble chocolate	None	29	46	8.00	10.50	100	10	2026-04-08 00:00:00
4806	Chokis brownie	None	29	46	8.00	10.50	100	10	2026-04-08 00:00:00
4807	Leche Lala light 1L	Leche Lala light 1 Litro	15	4	20.00	25.00	100	10	2026-04-08 00:00:00
4808	Crema Lala 426ml	None	15	4	15.00	30.00	100	10	2026-04-08 00:00:00
4809	Crema Lala 900ml	None	15	4	35.00	55.00	100	10	2026-04-08 00:00:00
4810	Crema alpura 200ml	None	15	4	8.00	13.00	100	10	2026-04-08 00:00:00
4811	Crema alpura 426ml	None	15	4	15.00	30.00	100	10	2026-04-08 00:00:00
4812	Crema alpura 900ml	None	15	4	35.00	55.00	100	10	2026-04-08 00:00:00
4813	Atun dolores en agua	None	6	51	10.00	15.00	100	10	2026-04-08 00:00:00
4814	Atun dolores en aceite	None	6	51	12.00	17.00	100	10	2026-04-08 00:00:00
4815	Sardinas en aceite	None	6	20	10.00	15.00	100	10	2026-04-08 00:00:00
4817	Frijoles bayos	None	6	50	10.00	15.00	100	10	2026-04-08 00:00:00
4818	Lentejas la moderna	None	2	44	10.00	15.00	100	10	2026-04-08 00:00:00
4819	Pasta la moderna	None	2	44	10.00	15.00	100	10	2026-04-08 00:00:00
4820	Coditos la moderna	None	2	44	10.00	15.00	100	10	2026-04-08 00:00:00
4821	Pasta Barilla espagueti	None	2	56	10.00	15.00	100	10	2026-04-08 00:00:00
4822	Sopa de letras la moderna	None	2	44	10.00	15.00	100	10	2026-04-08 00:00:00
4823	Sopa maruchan pollo	None	2	57	10.00	15.00	100	10	2026-04-08 00:00:00
4824	Sopa maruchan camaron	None	2	57	10.00	15.00	100	10	2026-04-08 00:00:00
4825	Sopa maruchan res	None	2	57	10.00	15.00	100	10	2026-04-08 00:00:00
4826	Sopa maruchan habanero	None	2	57	10.00	15.00	100	10	2026-04-08 00:00:00
4827	Sopa maruchan piquin	None	2	57	10.00	15.00	100	10	2026-04-08 00:00:00
4828	Sopa maruchan limon	None	2	57	10.00	15.00	100	10	2026-04-08 00:00:00
4829	Queso panela Alpura 200g	Queso panela Alpura 200 gramos	16	18	40.00	50.00	100	10	2026-04-08 00:00:00
4830	Queso oaxaca Lala 200g	Queso Oaxaca Lala 200 gramos	16	4	45.00	55.00	100	10	2026-04-08 00:00:00
4831	Queso manchego Lala 200g	Queso Manchego Lala 200 gramos	16	4	50.00	60.00	100	10	2026-04-08 00:00:00
4832	Salchichas Fud paquete 500g	Salchichas Fud 500 gramos	18	53	30.00	40.00	100	10	2026-04-08 00:00:00
4833	Salchichas San Rafael paquete 500g	Salchichas San Rafael 500 gramos	18	52	35.00	45.00	100	10	2026-04-08 00:00:00
4834	Jamon de pavo Fud 250g	Jamon de Pavo Fud 250 gramos	18	53	35.00	45.00	100	10	2026-04-08 00:00:00
4835	Jamon de pavo San Rafael 250g	Jamon de Pavo San Rafael 250 gramos	18	52	40.00	50.00	100	10	2026-04-08 00:00:00
4836	Sidral mundet 600ml	Refresco de manzana de 600ml	31	16	10.00	16.00	20	5	2026-04-08 00:00:00
4837	Sidral mundet 3lt	Refresco de manzana de 3lt	31	16	24.00	30.00	20	5	2026-04-08 00:00:00
4838	Agua bonafont 600ml	None	30	55	8.00	10.50	100	10	2026-04-08 00:00:00
4839	Agua bonafont 1lt	None	30	55	12.00	15.00	100	10	2026-04-08 00:00:00
4840	Agua bonafont 2lt.	None	30	55	14.00	18.00	100	10	2026-04-08 00:00:00
4841	Garrafon bonafont 20lt	None	30	55	19.50	24.00	100	10	2026-04-08 00:00:00
4842	Agua ciel 600ml	None	30	16	8.00	13.00	100	10	2026-04-08 00:00:00
4843	Agua ciel 1lt	None	30	16	10.00	15.00	100	10	2026-04-08 00:00:00
4844	Agua ciel 1.5l	None	30	16	12.00	17.00	100	10	2026-04-08 00:00:00
4845	Agua ciel 2lt	None	30	16	14.00	20.00	100	10	2026-04-08 00:00:00
4846	Agua E-pura 600ml	None	30	14	8.00	13.00	100	10	2026-04-08 00:00:00
4847	Agua E-pura 1lt	None	30	14	10.00	15.00	100	10	2026-04-08 00:00:00
4848	Garrafon E-pura 10lt	None	30	14	18.00	25.00	100	10	2026-04-08 00:00:00
4849	Crema Lala 200ml	None	15	4	8.00	13.00	100	10	2026-04-08 00:00:00
4850	Cremax fresa	None	29	46	8.00	10.50	100	10	2026-04-08 00:00:00
4851	Florentinas gamesa	None	29	46	8.00	10.50	100	10	2026-04-08 00:00:00
4852	Marias doradas	None	29	46	8.00	10.50	100	10	2026-04-08 00:00:00
4853	Gamesa cajeta	None	29	46	8.00	10.50	100	10	2026-04-08 00:00:00
4854	Maravillas gamesa	None	29	46	8.00	10.50	100	10	2026-04-08 00:00:00
4855	Crackets gamesa	None	29	46	8.00	10.50	100	10	2026-04-08 00:00:00
4856	Surtido rico gamesa	None	29	46	8.00	10.50	100	10	2026-04-08 00:00:00
4857	Delicias gamesa	None	29	46	8.00	10.50	100	10	2026-04-08 00:00:00
4858	Oreo	None	9	58	8.00	10.50	100	10	2026-04-08 00:00:00
4859	Principe chocolate	None	9	22	8.00	10.50	100	10	2026-04-08 00:00:00
4860	Principe vainilla	None	9	22	8.00	10.50	100	10	2026-04-08 00:00:00
4861	Principe limon	None	9	22	8.00	10.50	100	10	2026-04-08 00:00:00
4862	Principe chocolate blanco	None	9	22	8.00	10.50	100	10	2026-04-08 00:00:00
4863	Lors	None	9	22	8.00	10.50	100	10	2026-04-08 00:00:00
4864	Plativolos	None	9	22	8.00	10.50	100	10	2026-04-08 00:00:00
4865	Sponch	None	9	22	8.00	10.50	100	10	2026-04-08 00:00:00
4866	Triki trakes	None	9	22	8.00	10.50	100	10	2026-04-08 00:00:00
4867	MaxiTubo Triki trakes	None	9	22	8.00	10.50	100	10	2026-04-08 00:00:00
4868	Gansito	None	9	22	8.00	10.50	100	10	2026-04-08 00:00:00
4869	Pinguinos	None	9	22	8.00	10.50	100	10	2026-04-08 00:00:00
4870	Pasticetas marinela	None	9	22	8.00	10.50	100	10	2026-04-08 00:00:00
4871	Barritas fresa	None	9	22	8.00	10.50	100	10	2026-04-08 00:00:00
4872	Barritas pina	None	9	22	8.00	10.50	100	10	2026-04-08 00:00:00
4873	Barritas moras	None	9	22	8.00	10.50	100	10	2026-04-08 00:00:00
4874	Maxitubo Barritas pina	None	9	22	8.00	10.50	100	10	2026-04-08 00:00:00
4875	Canelitas	None	9	22	8.00	10.50	100	10	2026-04-08 00:00:00
4876	Polvorones	None	9	22	8.00	10.50	100	10	2026-04-08 00:00:00
4877	Maxitubo Polvorones	None	9	22	8.00	10.50	100	10	2026-04-08 00:00:00
4878	Ricanelas	None	9	46	8.00	10.50	100	10	2026-04-08 00:00:00
4879	Ritz bits queso	None	9	58	8.00	10.50	100	10	2026-04-08 00:00:00
4880	Arcoiris	None	9	46	8.00	10.50	100	10	2026-04-08 00:00:00
4881	Submarinos fresa	None	9	22	8.00	10.50	100	10	2026-04-08 00:00:00
4882	Submarinos vainilla	None	9	22	8.00	10.50	100	10	2026-04-08 00:00:00
4883	Submarinos chocolate	None	9	22	8.00	10.50	100	10	2026-04-08 00:00:00
4884	Rocko chico	None	9	22	8.00	10.50	100	10	2026-04-08 00:00:00
4885	Rocko grande	None	9	22	8.00	10.50	100	10	2026-04-08 00:00:00
4886	Sabritas original	None	9	3	8.00	10.50	100	10	2026-04-08 00:00:00
4887	Sabritas adobadas	None	9	3	8.00	10.50	100	10	2026-04-08 00:00:00
4888	Sabritas limon	None	9	3	8.00	10.50	100	10	2026-04-08 00:00:00
4889	Sabritas flamin hot	None	9	3	8.00	10.50	100	10	2026-04-08 00:00:00
4890	Sabritas crema y especias	None	9	3	8.00	10.50	100	10	2026-04-08 00:00:00
4891	Sabritas habanero	None	9	3	8.00	10.50	100	10	2026-04-08 00:00:00
4892	Sabritas receta crujiente	None	9	3	8.00	10.50	100	10	2026-04-08 00:00:00
4893	Sabritas receta crujiente jalapeno	None	9	3	8.00	10.50	100	10	2026-04-08 00:00:00
4894	Chips sal	None	9	47	8.00	10.50	100	10	2026-04-08 00:00:00
4895	Doritos nacho	None	9	3	8.00	10.50	100	10	2026-04-08 00:00:00
4896	Doritos incognita	None	9	3	8.00	10.50	100	10	2026-04-08 00:00:00
4897	Doritos diablo	None	9	3	8.00	10.50	100	10	2026-04-08 00:00:00
4898	Doritos flamin hot	None	9	3	8.00	10.50	100	10	2026-04-08 00:00:00
4899	Doritos dinamita	None	9	3	8.00	10.50	100	10	2026-04-08 00:00:00
4900	Sabritones	None	9	3	8.00	10.50	100	10	2026-04-08 00:00:00
4901	Bigmix queso	None	9	47	8.00	10.50	100	10	2026-04-08 00:00:00
4902	Bigmix fuego	None	9	47	8.00	10.50	100	10	2026-04-08 00:00:00
4903	Cheetos torciditos	None	9	3	8.00	10.50	100	10	2026-04-08 00:00:00
4904	Cheetos bolitas	None	9	3	8.00	10.50	100	10	2026-04-08 00:00:00
4905	Cheetos queso	None	9	3	8.00	10.50	100	10	2026-04-08 00:00:00
4906	Cheetos flamin hot	None	9	3	8.00	10.50	100	10	2026-04-08 00:00:00
4907	Ruffles original	None	9	3	8.00	10.50	100	10	2026-04-08 00:00:00
4908	Ruffles queso	None	9	3	8.00	10.50	100	10	2026-04-08 00:00:00
4909	Fritos sal y limon	None	9	3	8.00	10.50	100	10	2026-04-08 00:00:00
4910	Fritos chorizo	None	9	3	8.00	10.50	100	10	2026-04-08 00:00:00
4911	Bolsaza Sabritas original	None	9	3	8.00	10.50	100	10	2026-04-08 00:00:00
4912	Bolsaza Doritos nacho	None	9	3	8.00	10.50	100	10	2026-04-08 00:00:00
4913	Paketaxo	None	9	3	8.00	10.50	100	10	2026-04-08 00:00:00
4914	Paketaxo queso	None	9	3	8.00	10.50	100	10	2026-04-08 00:00:00
4915	Paketaxo flamin hot	None	9	3	8.00	10.50	100	10	2026-04-08 00:00:00
4916	Churrumaiz	None	9	3	8.00	10.50	100	10	2026-04-08 00:00:00
4917	Churrumaiz flamin hot	None	9	3	8.00	10.50	100	10	2026-04-08 00:00:00
4918	Rancheritos	None	9	3	8.00	10.50	100	10	2026-04-08 00:00:00
4919	Sabritas switch doritos nacho	None	9	3	8.00	10.50	100	10	2026-04-08 00:00:00
4920	Runners	None	9	47	8.00	10.50	100	10	2026-04-08 00:00:00
4921	Chips jalapeno	None	9	47	8.00	10.50	100	10	2026-04-08 00:00:00
4922	Cremax chocolate	None	29	46	8.00	10.50	100	10	2026-04-08 00:00:00
4923	Papatinas	None	9	47	8.00	10.50	100	10	2026-04-08 00:00:00
4924	Chips fuego	None	9	47	8.00	10.50	100	10	2026-04-08 00:00:00
4925	Palomitas pop	None	9	47	8.00	10.50	100	10	2026-04-08 00:00:00
4926	Takis original 	None	9	47	8.00	10.50	100	10	2026-04-08 00:00:00
4927	Takis fuego	None	9	47	8.00	10.50	100	10	2026-04-08 00:00:00
4928	Takis salsa brava	None	9	47	8.00	10.50	100	10	2026-04-08 00:00:00
4929	Takis guacamole	None	9	47	8.00	10.50	100	10	2026-04-08 00:00:00
4930	Chipotles	None	9	47	8.00	10.50	100	10	2026-04-08 00:00:00
4931	Tostachos	None	9	47	8.00	10.50	100	10	2026-04-08 00:00:00
4932	Hot nuts	None	9	47	8.00	10.50	100	10	2026-04-08 00:00:00
4933	Hot nuts fuego	None	9	47	8.00	10.50	100	10	2026-04-08 00:00:00
4934	Valentones	None	9	47	8.00	10.50	100	10	2026-04-08 00:00:00
4935	Watz barcel	None	9	47	8.00	10.50	100	10	2026-04-08 00:00:00
4936	Toreadas	None	9	47	8.00	10.50	100	10	2026-04-08 00:00:00
4937	Palomitas pop fuego	None	9	47	8.00	10.50	100	10	2026-04-08 00:00:00
4938	Takis blue heat	None	9	47	8.00	10.50	100	10	2026-04-08 00:00:00
4939	Doraditas tia rosa	None	29	49	8.00	10.50	100	10	2026-04-08 00:00:00
4940	Crujitos	None	9	3	8.00	10.50	100	10	2026-04-08 00:00:00
4941	Conchas tia rosa	None	29	49	8.00	10.50	100	10	2026-04-08 00:00:00
4942	Hersheys Cookies n Cream	None	8	45	8.00	10.50	100	10	2026-04-08 00:00:00
4943	Hersheys almendras	None	8	45	8.00	10.50	100	10	2026-04-08 00:00:00
4944	Hersheys chocolate amargo	None	8	45	8.00	10.50	100	10	2026-04-08 00:00:00
4945	Hersheys chocolate blanco	None	8	45	8.00	10.50	100	10	2026-04-08 00:00:00
4946	Crunch	None	8	19	8.00	10.50	100	10	2026-04-08 00:00:00
4947	Carlos V	None	8	19	8.00	10.50	100	10	2026-04-08 00:00:00
4948	Milky way	None	8	19	8.00	10.50	100	10	2026-04-08 00:00:00
4949	Snickers	None	8	19	8.00	10.50	100	10	2026-04-08 00:00:00
4950	Kit kat	None	8	19	8.00	10.50	100	10	2026-04-08 00:00:00
4951	Kinder delice	None	8	40	8.00	10.50	100	10	2026-04-08 00:00:00
4952	Kinder sorpresa	None	8	40	8.00	10.50	100	10	2026-04-08 00:00:00
4953	Ferrero rocher 3 piezas	None	8	40	8.00	10.50	100	10	2026-04-08 00:00:00
4954	Mazapan	None	8	62	8.00	10.50	100	10	2026-04-08 00:00:00
4955	Pelon pelo rico	None	8	45	8.00	10.50	100	10	2026-04-08 00:00:00
4956	Pulparindo tamarindo	None	8	62	8.00	10.50	100	10	2026-04-08 00:00:00
4957	Pulparindo chamoy	None	8	62	8.00	10.50	100	10	2026-04-08 00:00:00
4958	Tutsi pop	None	8	65	8.00	10.50	100	10	2026-04-08 00:00:00
4959	Oblea cajeta coronado	None	8	66	8.00	10.50	100	10	2026-04-08 00:00:00
4960	Paleta payaso	None	8	67	8.00	10.50	100	10	2026-04-08 00:00:00
4961	Duvalin fresa vainilla	None	8	67	8.00	10.50	100	10	2026-04-08 00:00:00
4962	Duvalin chocolate vainilla	None	8	67	8.00	10.50	100	10	2026-04-08 00:00:00
4963	Duvalin vainilla	None	8	67	8.00	10.50	100	10	2026-04-08 00:00:00
4964	Duvalin trisabor	None	8	67	8.00	10.50	100	10	2026-04-08 00:00:00
4965	Duvalin choco avellana	None	8	67	8.00	10.50	100	10	2026-04-08 00:00:00
4966	Paleta Vero mango	None	8	68	8.00	10.50	100	10	2026-04-08 00:00:00
4967	Paleta Vero elote	None	8	67	8.00	10.50	100	10	2026-04-08 00:00:00
4968	Panditas	None	8	67	8.00	10.50	100	10	2026-04-08 00:00:00
4969	Panditas rellenos	None	8	67	8.00	10.50	100	10	2026-04-08 00:00:00
4970	Panditas san valentin	None	8	67	8.00	10.50	100	10	2026-04-08 00:00:00
4971	Bubulubu	None	8	67	8.00	10.50	100	10	2026-04-08 00:00:00
4972	Rockaleta	None	8	69	8.00	10.50	100	10	2026-04-08 00:00:00
4973	Tic tac menta	None	8	40	8.00	10.50	100	10	2026-04-08 00:00:00
4974	Tic tac naranja	None	8	40	8.00	10.50	100	10	2026-04-08 00:00:00
4975	Tortillinas tia rosa	None	10	49	8.00	10.50	100	10	2026-04-08 00:00:00
4976	Halls limon	None	8	58	8.00	10.50	100	10	2026-04-08 00:00:00
4977	Halls yerba buena	None	8	58	8.00	10.50	100	10	2026-04-08 00:00:00
4978	Halls miel	None	8	58	8.00	10.50	100	10	2026-04-08 00:00:00
4979	Halls negras	None	8	58	8.00	10.50	100	10	2026-04-08 00:00:00
4980	Gomilocas dientes	None	8	67	8.00	10.50	100	10	2026-04-08 00:00:00
4981	Gomilocas pinguino	None	8	67	8.00	10.50	100	10	2026-04-08 00:00:00
4982	Chocoretas	None	8	67	8.00	10.50	100	10	2026-04-08 00:00:00
4983	Kranky	None	8	67	8.00	10.50	100	10	2026-04-08 00:00:00
4984	Lucas muecas	None	8	58	8.00	10.50	100	10	2026-04-08 00:00:00
4985	Lucas chamoy	None	8	58	8.00	10.50	100	10	2026-04-08 00:00:00
4986	Lucas gusanito	None	8	58	8.00	10.50	100	10	2026-04-08 00:00:00
4987	Palomitas Act II mantequilla	None	9	58	8.00	10.50	100	10	2026-04-08 00:00:00
4988	Palomitas Act II natural	None	9	58	8.00	10.50	100	10	2026-04-08 00:00:00
4989	Palomitas Act II chile limon	None	9	58	8.00	10.50	100	10	2026-04-08 00:00:00
4990	Tostitos salsa verde	None	9	3	8.00	10.50	100	10	2026-04-08 00:00:00
4991	Zucaritas chicas	None	5	26	8.00	10.50	100	10	2026-04-08 00:00:00
4992	Zucaritas grandes	None	5	26	8.00	10.50	100	10	2026-04-08 00:00:00
4993	Corn flakes chicas	None	5	26	8.00	10.50	100	10	2026-04-08 00:00:00
4994	Corn flakes grandes	None	5	26	8.00	10.50	100	10	2026-04-08 00:00:00
4995	Choco Krispis chicas	None	5	26	8.00	10.50	100	10	2026-04-08 00:00:00
4996	Choco Krispis grandes	None	5	26	8.00	10.50	100	10	2026-04-08 00:00:00
4997	Nesquik chico	None	5	26	8.00	10.50	100	10	2026-04-08 00:00:00
4998	Nesquik grande	None	5	26	8.00	10.50	100	10	2026-04-08 00:00:00
4999	Froot loops chicas	None	5	26	8.00	10.50	100	10	2026-04-08 00:00:00
5000	Froot loops grandes	None	5	26	8.00	10.50	100	10	2026-04-08 00:00:00
5001	Chocomilk sobre	None	4	58	8.00	10.50	100	10	2026-04-08 00:00:00
5002	Chocomilk bolsa	None	4	58	8.00	10.50	100	10	2026-04-08 00:00:00
5003	Chocomilk lata	None	4	58	8.00	10.50	100	10	2026-04-08 00:00:00
5004	Nescafe clasico sobre	None	4	19	8.00	10.50	100	10	2026-04-08 00:00:00
5005	Nescafe capuccino sobre	None	4	19	8.00	10.50	100	10	2026-04-08 00:00:00
5006	Nescafe clasico bote chico	None	4	19	8.00	10.50	100	10	2026-04-08 00:00:00
5007	Nescafe clasico bote grande	None	4	19	8.00	10.50	100	10	2026-04-08 00:00:00
5008	Azucar Zulka 1kg	None	3	58	8.00	10.50	100	10	2026-04-08 00:00:00
5009	Azucar refinada 1kg	None	3	58	8.00	10.50	100	10	2026-04-08 00:00:00
5010	Azucar refinada 500gr	None	3	58	8.00	10.50	100	10	2026-04-08 00:00:00
5011	Azucar refinada 250gr	None	3	58	8.00	10.50	100	10	2026-04-08 00:00:00
5012	Aceite nutrioli 1lt	None	1	58	8.00	10.50	100	10	2026-04-08 00:00:00
5013	Aceite capullo 1lt	None	1	58	8.00	10.50	100	10	2026-04-08 00:00:00
5014	Aceite 1 2 3 1lt	None	1	58	8.00	10.50	100	10	2026-04-08 00:00:00
5015	Aceite patrona 1lt	None	1	58	8.00	10.50	100	10	2026-04-08 00:00:00
5016	Vinagre blanco la coste¤a	None	1	27	8.00	10.50	100	10	2026-04-08 00:00:00
5017	Vinagre de manzana la coste¤a	None	1	27	8.00	10.50	100	10	2026-04-08 00:00:00
5018	Catsup la coste¤a	None	1	27	8.00	10.50	100	10	2026-04-08 00:00:00
5019	Catsup Del monte	None	1	70	8.00	10.50	100	10	2026-04-08 00:00:00
5020	Catsup heinz	None	1	71	8.00	10.50	100	10	2026-04-08 00:00:00
5021	Jugo Magui	None	7	19	8.00	10.50	100	10	2026-04-08 00:00:00
5022	Salsa inglesa	None	7	19	8.00	10.50	100	10	2026-04-08 00:00:00
5023	Salsa valentina chica	None	7	58	8.00	10.50	100	10	2026-04-08 00:00:00
5024	Salsa valentina grande	None	7	58	8.00	10.50	100	10	2026-04-08 00:00:00
5025	Salsa tabasco	None	7	58	8.00	10.50	100	10	2026-04-08 00:00:00
5026	Salsa buffalo	None	7	58	8.00	10.50	100	10	2026-04-08 00:00:00
5027	Salsa chipotle la coste¤a	None	7	27	8.00	10.50	100	10	2026-04-08 00:00:00
5028	Chile chipotle la coste¤a	None	6	27	8.00	10.50	100	10	2026-04-08 00:00:00
5029	Halls menta	None	8	58	8.00	10.50	100	10	2026-04-08 00:00:00
5030	Mayonesa mccormick grande	None	7	72	8.00	10.50	100	10	2026-04-08 00:00:00
5031	Mostaza mccormick	None	7	72	8.00	10.50	100	10	2026-04-08 00:00:00
5032	Mermelada mccormick fresa chica	None	19	72	8.00	10.50	100	10	2026-04-08 00:00:00
5033	Mermelada mccormick fresa grande	None	19	72	8.00	10.50	100	10	2026-04-08 00:00:00
5034	Cloralex 1/2 lt	None	35	58	8.00	10.50	100	10	2026-04-08 00:00:00
5035	Papel higienico Petalo 6 rollos	None	37	58	8.00	10.50	100	10	2026-04-08 00:00:00
5036	Papel higienico Suavel 4 rollos	None	37	58	8.00	10.50	100	10	2026-04-08 00:00:00
5037	Papel higienico Suavel 6 rollos	None	37	58	8.00	10.50	100	10	2026-04-08 00:00:00
5038	Toallas sanitarias Always	None	37	58	8.00	10.50	100	10	2026-04-08 00:00:00
5039	Toallas sanitarias Kotex	None	37	58	8.00	10.50	100	10	2026-04-08 00:00:00
5040	Panales Huggies	None	44	58	8.00	10.50	100	10	2026-04-08 00:00:00
5041	Shampoo Head & Shoulders chico	None	39	58	8.00	10.50	100	10	2026-04-08 00:00:00
5042	Shampoo Head & Shoulders grande	None	39	58	8.00	10.50	100	10	2026-04-08 00:00:00
5043	Desodorante Axe	None	41	58	8.00	10.50	100	10	2026-04-08 00:00:00
5044	Cloralex 1 lt	None	35	58	8.00	10.50	100	10	2026-04-08 00:00:00
5045	Pinol	None	35	58	8.00	10.50	100	10	2026-04-08 00:00:00
5046	Fabuloso lavanda 1lt	None	35	58	8.00	10.50	100	10	2026-04-08 00:00:00
5047	Fabuloso aroma floral 1lt	None	35	58	8.00	10.50	100	10	2026-04-08 00:00:00
5048	Yomi lala chocolate	None	15	4	15.00	30.00	100	10	2026-04-08 00:00:00
5049	Yomi lala vainilla	None	15	4	15.00	30.00	100	10	2026-04-08 00:00:00
5050	Yomi lala fresa	None	15	4	15.00	30.00	100	10	2026-04-08 00:00:00
5051	Yogurt lala fresa	None	15	4	15.00	30.00	100	10	2026-04-08 00:00:00
5052	Yogurt lala durazno	None	15	4	15.00	30.00	100	10	2026-04-08 00:00:00
5053	Yogurt lala manzana	None	15	4	15.00	30.00	100	10	2026-04-08 00:00:00
5054	Yogurt bebible lala manzana	None	15	4	15.00	30.00	100	10	2026-04-08 00:00:00
5055	Yogurt bebible lala durazno	None	15	4	15.00	30.00	100	10	2026-04-08 00:00:00
5056	Licuado lala nuez	None	15	4	15.00	30.00	100	10	2026-04-08 00:00:00
5057	Flan lala	None	15	4	15.00	30.00	100	10	2026-04-08 00:00:00
5058	Margarina lala 90gr	None	15	4	15.00	30.00	100	10	2026-04-08 00:00:00
5059	Perejil ramo		21	58	3.00	5.00	5	1	2026-04-08 00:00:00
5060	Jabon zote rosa chico	None	42	58	8.00	10.50	100	10	2026-04-08 00:00:00
5061	Yogurt bebible lala fresa	None	15	4	15.00	30.00	100	10	2026-04-08 00:00:00
5062	Yogurt bebible lala moras	None	15	4	15.00	30.00	100	10	2026-04-08 00:00:00
5063	Yogurt bebible lala pina coco	None	15	4	15.00	30.00	100	10	2026-04-08 00:00:00
5064	Licuado lala fresa platano	None	15	4	15.00	30.00	100	10	2026-04-08 00:00:00
5065	Leche deslactosada 1lt	Presentacion azul	15	4	18.20	23.00	14	2	2026-04-08 00:00:00
5066	Yogurt Yoplait natural 1L	Yogurt Yoplait natural 1 Litro	17	54	26.00	31.00	100	10	2026-04-08 00:00:00
5067	Cremax vainilla	None	29	46	8.00	10.50	100	10	2026-04-08 00:00:00
5068	Maxitubo Barritas fresa	None	9	22	8.00	10.50	100	10	2026-04-08 00:00:00
5069	Bigote tia rosa	None	29	49	8.00	10.50	100	10	2026-04-08 00:00:00
5070	Magdalenas tia rosa	None	29	49	8.00	10.50	100	10	2026-04-08 00:00:00
5071	Chiles serranos la coste¤a	None	6	27	8.00	10.50	100	10	2026-04-08 00:00:00
5072	Chiles en vinagre la coste¤a	None	6	27	8.00	10.50	100	10	2026-04-08 00:00:00
5073	Chile chipotle la morena	None	6	72	8.00	10.50	100	10	2026-04-08 00:00:00
5074	Chiles en vinagre la morena	None	6	72	8.00	10.50	100	10	2026-04-08 00:00:00
5075	Mayonesa mccormick chica	None	7	72	8.00	10.50	100	10	2026-04-08 00:00:00
5076	Jabon zote rosa grande	None	42	58	8.00	10.50	100	10	2026-04-08 00:00:00
5077	Jabon zote blanco chico	None	42	58	8.00	10.50	100	10	2026-04-08 00:00:00
5078	Jabon zote blanco grande	None	42	58	8.00	10.50	100	10	2026-04-08 00:00:00
5079	Detergente Ariel 1/2 kg	None	34	58	8.00	10.50	100	10	2026-04-08 00:00:00
5080	Detergente Ariel 1kg	None	34	58	8.00	10.50	100	10	2026-04-08 00:00:00
5081	Detergente Ace 1/2 kg	None	34	58	8.00	10.50	100	10	2026-04-08 00:00:00
5082	Detergente Ace 1kg	None	34	58	8.00	10.50	100	10	2026-04-08 00:00:00
5083	Detergente Foca 1/2 kg	None	34	58	8.00	10.50	100	10	2026-04-08 00:00:00
5084	Detergente Foca 1kg	None	34	58	8.00	10.50	100	10	2026-04-08 00:00:00
5085	Suavitel 1l	None	34	58	8.00	10.50	100	10	2026-04-08 00:00:00
5086	Papel higienico Petalo 4 rollos	None	37	58	8.00	10.50	100	10	2026-04-08 00:00:00
5087	Coca Cola 2.5L NR	Refresco Coca Cola 2.5 Litros No Retornable	31	16	28.00	35.00	0	5	2026-04-09 00:00:00
5088	Pepsi	bebida azucarada	31	14	8.00	16.00	77	20	2026-04-09 00:00:00
5089	Sabritas	Sabritas Flamin Hot	9	3	10.00	18.00	4	1	2026-04-09 00:00:00
5090	Coca Cola 1L	Refresco Coca Cola 1 Litro	31	16	12.00	15.00	100	10	2026-04-09 00:00:00
5091	Galletas marias	Las galletas clasicas	9	3	8.90	15.00	18	2	2026-04-09 00:00:00
5092	Tortillas de maiz 1/2 kg	None	10	58	8.00	10.50	100	10	2026-04-09 00:00:00
5093	Coca Cola lata 355ml	Refresco Coca Cola 355 ml lata	31	16	8.50	11.00	100	10	2026-04-09 00:00:00
5094	chimichangas	chimichangas	23	10	30.00	45.00	14	5	2026-04-09 00:00:00
5095	MaruchanTokyo	maruchan picante	2	11	5.50	12.50	15	10	2026-04-09 00:00:00
5096	Leche Lala light 1L	Leche Lala light 1 Litro	15	4	20.00	25.00	100	10	2026-04-09 00:00:00
5097	Marias gamesa	None	29	46	8.00	10.50	100	10	2026-04-09 00:00:00
5098	Leche Santa Clara deslactosada 1L	Leche Santa Clara deslactosada 1 Litro	15	4	23.00	29.00	100	10	2026-04-09 00:00:00
5099	Yogurt Lala natural 1L	Yogurt Lala natural 1 Litro	17	4	25.00	30.00	100	10	2026-04-09 00:00:00
5100	Yogurt Lala de fresa 1L	Yogurt Lala sabor Fresa 1 Litro	17	4	25.00	30.00	100	10	2026-04-09 00:00:00
5101	Harina de trigo San antonio	None	10	41	8.00	10.50	100	10	2026-04-09 00:00:00
5102	Del Valle fruit guayaba 600ml	Jugo Del Valle sabor Guayaba 600 ml	31	28	10.50	13.50	100	10	2026-04-09 00:00:00
5103	Pan bimbo blanco chico	None	27	17	8.00	10.50	100	10	2026-04-09 00:00:00
5104	Pan bimbo blanco grande	None	27	17	8.00	10.50	100	10	2026-04-09 00:00:00
5105	Pan bimbo integral chico	None	27	17	8.00	10.50	100	10	2026-04-09 00:00:00
5106	Pan bimbo integral grande	None	27	17	8.00	10.50	100	10	2026-04-09 00:00:00
5107	Rebanadas bimbo	None	27	17	8.00	10.50	100	10	2026-04-09 00:00:00
5108	Chocoroles	None	27	17	8.00	10.50	100	10	2026-04-09 00:00:00
5109	Nito bimbo	None	27	17	8.00	10.50	100	10	2026-04-09 00:00:00
5110	Mantecadas	None	27	17	8.00	10.50	100	10	2026-04-09 00:00:00
5111	Roles de canela con pasas	None	27	17	8.00	10.50	100	10	2026-04-09 00:00:00
5112	Roles de canela glaseados	None	27	17	8.00	10.50	100	10	2026-04-09 00:00:00
5113	Conchas bimbo	None	27	17	8.00	10.50	100	10	2026-04-09 00:00:00
5114	Panque de nuez bimbo	None	27	17	8.00	10.50	100	10	2026-04-09 00:00:00
5115	Donitas bimbo	None	27	17	8.00	10.50	100	10	2026-04-09 00:00:00
5116	Donitas espolvoreadas bimbo	None	27	17	8.00	10.50	100	10	2026-04-09 00:00:00
5117	Tostadas charras	None	5	60	8.00	10.50	100	10	2026-04-09 00:00:00
5118	Tostadas Sanissimo	None	5	61	8.00	10.50	100	10	2026-04-09 00:00:00
5119	Roles	Ricos roles de canela caseros	27	13	70.00	100.00	17	10	2026-04-09 00:00:00
5120	Coca Cola 355ml	Refresco Coca Cola 355 ml	31	16	8.00	10.50	100	10	2026-04-09 00:00:00
5121	Coca Cola 600ml	Refresco Coca Cola 600 ml	31	16	9.00	12.00	100	10	2026-04-09 00:00:00
5122	Coca Cola retornable 1 1/4 lt.	Refresco Coca Cola retornable 1 1/4 lt	31	16	12.50	15.50	100	10	2026-04-09 00:00:00
5123	Coca Cola 2L retornable	Refresco Coca Cola retornable 2 Litros	31	16	19.50	24.00	100	10	2026-04-09 00:00:00
5124	Coca Cola 3L retornable	Refresco Coca Cola retornable 3 Litros	31	16	24.00	30.00	100	10	2026-04-09 00:00:00
5125	Coca Cola Light 600ml	Refresco Coca Cola Light 600 ml	31	16	9.50	12.50	100	10	2026-04-09 00:00:00
5126	Pepsi 600ml	Refresco Pepsi 600 ml	31	14	9.00	12.00	100	10	2026-04-09 00:00:00
5127	Pepsi 1.5L	Refresco Pepsi 1.5 Litros	31	14	12.00	15.50	100	10	2026-04-09 00:00:00
5128	Fanta 600ml	Refresco Fanta 600 ml	31	16	9.00	12.00	100	10	2026-04-09 00:00:00
5129	Fanta 1.5L	Refresco Fanta 1.5 Litros	31	16	12.50	16.00	100	10	2026-04-09 00:00:00
5130	Sprite 600ml	Refresco Sprite 600 ml	31	16	9.00	12.00	100	10	2026-04-09 00:00:00
5131	Sprite 1.5L	Refresco Sprite 1.5 Litros	31	16	12.50	16.00	100	10	2026-04-09 00:00:00
5132	Manzanita 600ml	Refresco Manzanita Sol 600 ml	31	16	9.00	12.00	100	10	2026-04-09 00:00:00
5133	Manzanita 1.5L	Refresco Manzanita Sol 1.5 Litros	31	16	12.50	16.00	100	10	2026-04-09 00:00:00
5134	Fresca 600ml	Refresco Fresca 600 ml	31	16	9.00	12.00	100	10	2026-04-09 00:00:00
5135	Fresca 3L	Refresco Fresca 3 Litros	31	16	24.00	30.00	100	10	2026-04-09 00:00:00
5136	Mirinda 600ml	Refresco Mirinda 600 ml	31	16	9.00	12.00	100	10	2026-04-09 00:00:00
5137	Mirinda 1.5L	Refresco Mirinda 1.5 Litros	31	16	12.50	16.00	100	10	2026-04-09 00:00:00
5138	Jumex de mango 1L	Jugo Jumex sabor Mango 1 Litro	31	21	16.00	20.00	100	10	2026-04-09 00:00:00
5139	Jumex de durazno 1L	Jugo Jumex sabor Durazno 1 Litro	31	21	16.00	20.00	100	10	2026-04-09 00:00:00
5140	Emperador chocolate	None	29	46	8.00	10.50	100	10	2026-04-09 00:00:00
5141	Emperador nuez	None	29	46	8.00	10.50	100	10	2026-04-09 00:00:00
5142	Jumex de manzana 600ml	Jugo Jumex sabor Manzana 600 ml	31	21	10.00	13.00	100	10	2026-04-09 00:00:00
5143	Emperador vainilla	None	29	46	8.00	10.50	100	10	2026-04-09 00:00:00
5144	Emperador limon	None	29	46	8.00	10.50	100	10	2026-04-09 00:00:00
5145	Emperador Senso	None	29	46	8.00	10.50	100	10	2026-04-09 00:00:00
5146	Mamut chico	None	29	46	8.00	10.50	100	10	2026-04-09 00:00:00
5147	Del Valle fruit naranja 600ml	Jugo Del Valle sabor Naranja 600 ml	31	28	10.50	13.50	100	10	2026-04-09 00:00:00
5148	Del Valle fruit manzana 600ml	Jugo Del Valle sabor Manzana 600 ml	31	28	10.50	13.50	100	10	2026-04-09 00:00:00
5149	Manzanita		31	14	17.00	25.00	22	3	2026-04-09 00:00:00
5150	Leche Lala entera 1L	Leche Lala entera 1 Litro	15	4	19.00	24.00	100	10	2026-04-09 00:00:00
5151	Leche Lala deslactosada 1L	Leche Lala deslactosada 1 Litro	15	4	20.00	25.00	100	10	2026-04-09 00:00:00
5152	Mamut grande	None	29	46	8.00	10.50	100	10	2026-04-09 00:00:00
5153	Chokis	None	29	46	8.00	10.50	100	10	2026-04-09 00:00:00
5154	Yogurt Yoplait de fresa 1L	Yogurt Yoplait sabor Fresa 1 Litro	17	54	26.00	31.00	100	10	2026-04-09 00:00:00
5155	Mantequilla Lala 250g	Mantequilla Lala 250 gramos	19	4	30.00	38.00	100	10	2026-04-09 00:00:00
5156	Queso panela Lala 200g	Queso panela Lala 200 gramos	16	4	40.00	50.00	100	10	2026-04-09 00:00:00
5157	Arroz Mexica 1kg	None	2	59	12.00	16.50	100	10	2026-04-09 00:00:00
5158	Harina de maiz maseca	None	10	59	8.00	10.50	100	10	2026-04-09 00:00:00
5159	Chokis rellenas	None	29	46	8.00	10.50	100	10	2026-04-09 00:00:00
5160	Chokis doble chocolate	None	29	46	8.00	10.50	100	10	2026-04-09 00:00:00
5161	Chokis brownie	None	29	46	8.00	10.50	100	10	2026-04-09 00:00:00
5162	Leche entera lala 1lt	Clasica color roja	15	4	15.24	25.00	2	3	2026-04-09 00:00:00
5163	Leche Santa Clara entera 1L	Leche Santa Clara entera 1 Litro	15	4	22.00	28.00	100	10	2026-04-09 00:00:00
5164	Coca Cola Sin Azucar 600ml	Refresco Coca Cola Sin Azucar 600ml	31	16	12.00	17.00	0	5	2026-04-09 00:00:00
5165	Sprite 2L	Refresco sabor Limon 2 Litros	31	16	22.00	28.00	0	5	2026-04-09 00:00:00
5166	Fanta Naranja 2L	Refresco sabor Naranja 2 Litros	31	16	22.00	28.00	0	5	2026-04-09 00:00:00
5167	Sidral Mundet 2L	Refresco sabor Manzana 2 Litros	31	16	22.00	28.00	0	5	2026-04-09 00:00:00
5168	Fresca Toronja 2L	Refresco sabor Toronja 2 Litros	31	16	22.00	28.00	0	5	2026-04-09 00:00:00
5169	Del Valle Naranja 1L	Jugo Del Valle Naranja 1 Litro	31	28	18.00	23.00	0	5	2026-04-09 00:00:00
5170	Del Valle Durazno 1L	Jugo Del Valle Durazno 1 Litro	31	28	18.00	23.00	0	5	2026-04-09 00:00:00
5171	Del Valle Mango 1L	Jugo Del Valle Mango 1 Litro	31	28	18.00	23.00	0	5	2026-04-09 00:00:00
5172	Fuze Tea Limon 600ml	Te helado sabor Limon 600ml	31	16	13.00	18.00	0	5	2026-04-09 00:00:00
5173	Fuze Tea Negro 600ml	Te helado sabor Negro 600ml	31	16	13.00	18.00	0	5	2026-04-09 00:00:00
5174	Pepsi 2.5L NR	Refresco Pepsi 2.5 Litros No Retornable	31	14	25.00	32.00	0	5	2026-04-09 00:00:00
5175	Pepsi 3L NR	Refresco Pepsi 3 Litros No Retornable	31	14	28.00	36.00	0	5	2026-04-09 00:00:00
5176	7Up 600ml	Refresco sabor Lima-Limon 600ml	31	14	12.00	16.00	0	5	2026-04-09 00:00:00
5177	7Up 2L	Refresco sabor Lima-Limon 2 Litros	31	14	20.00	26.00	0	5	2026-04-09 00:00:00
5178	Mirinda 2L	Refresco sabor Naranja 2 Litros	31	14	20.00	26.00	0	5	2026-04-09 00:00:00
5179	Manzanita Sol 2L	Refresco sabor Manzana 2 Litros	31	14	20.00	26.00	0	5	2026-04-09 00:00:00
5180	Agua Epura 5L	Agua Purificada Epura 5 Litros	30	14	24.00	32.00	0	5	2026-04-09 00:00:00
5181	Agua Epura 10L	Agua Purificada Epura 10 Litros	30	14	35.00	48.00	0	5	2026-04-09 00:00:00
5182	Agua Ciel 5L	Agua Purificada Ciel 5 Litros	30	16	25.00	33.00	0	5	2026-04-09 00:00:00
5183	Jumex Lata 335ml Mango	Jugo de Mango en Lata 335ml	31	21	10.00	14.00	0	5	2026-04-09 00:00:00
5184	Jumex Lata 335ml Guayaba	Jugo de Guayaba en Lata 335ml	31	21	10.00	14.00	0	5	2026-04-09 00:00:00
5185	Agua ciel 600ml	None	30	16	8.00	13.00	100	10	2026-04-09 00:00:00
5186	Agua ciel 1lt	None	30	16	10.00	15.00	100	10	2026-04-09 00:00:00
5187	Agua ciel 1.5l	None	30	16	12.00	17.00	100	10	2026-04-09 00:00:00
5188	Agua ciel 2lt	None	30	16	14.00	20.00	100	10	2026-04-09 00:00:00
5189	Agua E-pura 600ml	None	30	14	8.00	13.00	100	10	2026-04-09 00:00:00
5190	Agua E-pura 1lt	None	30	14	10.00	15.00	100	10	2026-04-09 00:00:00
5191	Garrafon E-pura 10lt	None	30	14	18.00	25.00	100	10	2026-04-09 00:00:00
5192	Crema Lala 200ml	None	15	4	8.00	13.00	100	10	2026-04-09 00:00:00
5193	Crema Lala 426ml	None	15	4	15.00	30.00	100	10	2026-04-09 00:00:00
5194	Crema Lala 900ml	None	15	4	35.00	55.00	100	10	2026-04-09 00:00:00
5195	Queso panela Alpura 200g	Queso panela Alpura 200 gramos	16	18	40.00	50.00	100	10	2026-04-09 00:00:00
5196	Crema alpura 200ml	None	15	4	8.00	13.00	100	10	2026-04-09 00:00:00
5197	Crema alpura 426ml	None	15	4	15.00	30.00	100	10	2026-04-09 00:00:00
5198	Crema alpura 900ml	None	15	4	35.00	55.00	100	10	2026-04-09 00:00:00
5199	Atun dolores en agua	None	6	51	10.00	15.00	100	10	2026-04-09 00:00:00
5200	Atun dolores en aceite	None	6	51	12.00	17.00	100	10	2026-04-09 00:00:00
5201	Sardinas en aceite	None	6	20	10.00	15.00	100	10	2026-04-09 00:00:00
5202	Frijoles refritos	None	6	50	10.00	15.00	100	10	2026-04-09 00:00:00
5203	Frijoles bayos	None	6	50	10.00	15.00	100	10	2026-04-09 00:00:00
5204	Lentejas la moderna	None	2	44	10.00	15.00	100	10	2026-04-09 00:00:00
5205	Pasta la moderna	None	2	44	10.00	15.00	100	10	2026-04-09 00:00:00
5206	Queso oaxaca Lala 200g	Queso Oaxaca Lala 200 gramos	16	4	45.00	55.00	100	10	2026-04-09 00:00:00
5207	Queso manchego Lala 200g	Queso Manchego Lala 200 gramos	16	4	50.00	60.00	100	10	2026-04-09 00:00:00
5208	Coditos la moderna	None	2	44	10.00	15.00	100	10	2026-04-09 00:00:00
5209	Salchichas Fud paquete 500g	Salchichas Fud 500 gramos	18	53	30.00	40.00	100	10	2026-04-09 00:00:00
5210	Salchichas San Rafael paquete 500g	Salchichas San Rafael 500 gramos	18	52	35.00	45.00	100	10	2026-04-09 00:00:00
5211	Pasta Barilla espagueti	None	2	56	10.00	15.00	100	10	2026-04-09 00:00:00
5212	Sopa de letras la moderna	None	2	44	10.00	15.00	100	10	2026-04-09 00:00:00
5213	Sopa maruchan pollo	None	2	57	10.00	15.00	100	10	2026-04-09 00:00:00
5214	Sopa maruchan camaron	None	2	57	10.00	15.00	100	10	2026-04-09 00:00:00
5215	Sopa maruchan res	None	2	57	10.00	15.00	100	10	2026-04-09 00:00:00
5216	Sopa maruchan habanero	None	2	57	10.00	15.00	100	10	2026-04-09 00:00:00
5217	Sopa maruchan piquin	None	2	57	10.00	15.00	100	10	2026-04-09 00:00:00
5218	Sopa maruchan limon	None	2	57	10.00	15.00	100	10	2026-04-09 00:00:00
5219	Jumex Lata 335ml Manzana	Jugo de Manzana en Lata 335ml	31	21	10.00	14.00	0	5	2026-04-09 00:00:00
5220	Penafiel Mineral 600ml	Agua Mineral Penafiel 600ml	31	58	11.00	15.00	0	5	2026-04-09 00:00:00
5221	Penafiel Twist Limon 600ml	Agua Mineral con Limon 600ml	31	58	12.00	16.00	0	5	2026-04-09 00:00:00
5304	Paketaxo	None	9	3	8.00	10.50	100	10	2026-04-09 00:00:00
5222	Sangria Senorial 355ml	Bebida sabor Sangria 355ml	31	58	10.00	14.00	0	5	2026-04-09 00:00:00
5223	Sangria Senorial 600ml	Bebida sabor Sangria 600ml	31	58	13.00	18.00	0	5	2026-04-09 00:00:00
5224	Jarritos Mandarina 600ml	Refresco sabor Mandarina 600ml	31	58	10.00	14.00	0	5	2026-04-09 00:00:00
5225	Jarritos Tamarindo 600ml	Refresco sabor Tamarindo 600ml	31	58	10.00	14.00	0	5	2026-04-09 00:00:00
5226	Jarritos Multisabor 2L	Refresco varios sabores 2 Litros	31	58	18.00	24.00	0	5	2026-04-09 00:00:00
5227	Leche Lala Deslactosada 1.5L	Leche Deslactosada 1.5 Litros	15	4	32.00	39.00	0	5	2026-04-09 00:00:00
5228	Leche Lala Entera 1.5L	Leche Entera 1.5 Litros	15	4	30.00	37.00	0	5	2026-04-09 00:00:00
5229	Leche Lala Semidescremada 1L	Leche Semidescremada 1 Litro	15	4	21.00	26.00	0	5	2026-04-09 00:00:00
5230	Leche Alpura Entera 1L	Leche Alpura Entera 1 Litro	15	18	20.00	25.00	0	5	2026-04-09 00:00:00
5231	Leche Alpura Deslactosada 1L	Leche Alpura Deslactosada 1 Litro	15	18	22.00	27.00	0	5	2026-04-09 00:00:00
5232	Jamon de pavo Fud 250g	Jamon de Pavo Fud 250 gramos	18	53	35.00	45.00	100	10	2026-04-09 00:00:00
5233	Jamon de pavo San Rafael 250g	Jamon de Pavo San Rafael 250 gramos	18	52	40.00	50.00	100	10	2026-04-09 00:00:00
5234	Sidral mundet 600ml	Refresco de manzana de 600ml	31	16	10.00	16.00	20	5	2026-04-09 00:00:00
5235	Sidral mundet 3lt	Refresco de manzana de 3lt	31	16	24.00	30.00	20	5	2026-04-09 00:00:00
5236	Agua bonafont 600ml	None	30	55	8.00	10.50	100	10	2026-04-09 00:00:00
5237	Agua bonafont 1lt	None	30	55	12.00	15.00	100	10	2026-04-09 00:00:00
5238	Agua bonafont 2lt.	None	30	55	14.00	18.00	100	10	2026-04-09 00:00:00
5239	Garrafon bonafont 20lt	None	30	55	19.50	24.00	100	10	2026-04-09 00:00:00
5240	Leche Alpura 250ml Fresa	Leche saborizada Fresa 250ml	15	18	8.50	12.00	0	5	2026-04-09 00:00:00
5241	Leche Alpura 250ml Chocolate	Leche saborizada Chocolate 250ml	15	18	8.50	12.00	0	5	2026-04-09 00:00:00
5242	Florentinas gamesa	None	29	46	8.00	10.50	100	10	2026-04-09 00:00:00
5243	Marias doradas	None	29	46	8.00	10.50	100	10	2026-04-09 00:00:00
5244	Gamesa cajeta	None	29	46	8.00	10.50	100	10	2026-04-09 00:00:00
5245	Maravillas gamesa	None	29	46	8.00	10.50	100	10	2026-04-09 00:00:00
5246	Crackets gamesa	None	29	46	8.00	10.50	100	10	2026-04-09 00:00:00
5247	Surtido rico gamesa	None	29	46	8.00	10.50	100	10	2026-04-09 00:00:00
5248	Delicias gamesa	None	29	46	8.00	10.50	100	10	2026-04-09 00:00:00
5249	Oreo	None	9	58	8.00	10.50	100	10	2026-04-09 00:00:00
5250	Principe chocolate	None	9	22	8.00	10.50	100	10	2026-04-09 00:00:00
5251	Principe vainilla	None	9	22	8.00	10.50	100	10	2026-04-09 00:00:00
5252	Principe limon	None	9	22	8.00	10.50	100	10	2026-04-09 00:00:00
5253	Principe chocolate blanco	None	9	22	8.00	10.50	100	10	2026-04-09 00:00:00
5254	Lors	None	9	22	8.00	10.50	100	10	2026-04-09 00:00:00
5255	Plativolos	None	9	22	8.00	10.50	100	10	2026-04-09 00:00:00
5256	Sponch	None	9	22	8.00	10.50	100	10	2026-04-09 00:00:00
5257	Triki trakes	None	9	22	8.00	10.50	100	10	2026-04-09 00:00:00
5258	MaxiTubo Triki trakes	None	9	22	8.00	10.50	100	10	2026-04-09 00:00:00
5259	Gansito	None	9	22	8.00	10.50	100	10	2026-04-09 00:00:00
5260	Pinguinos	None	9	22	8.00	10.50	100	10	2026-04-09 00:00:00
5261	Pasticetas marinela	None	9	22	8.00	10.50	100	10	2026-04-09 00:00:00
5262	Barritas fresa	None	9	22	8.00	10.50	100	10	2026-04-09 00:00:00
5263	Barritas pina	None	9	22	8.00	10.50	100	10	2026-04-09 00:00:00
5264	Barritas moras	None	9	22	8.00	10.50	100	10	2026-04-09 00:00:00
5265	Maxitubo Barritas pina	None	9	22	8.00	10.50	100	10	2026-04-09 00:00:00
5266	Canelitas	None	9	22	8.00	10.50	100	10	2026-04-09 00:00:00
5267	Polvorones	None	9	22	8.00	10.50	100	10	2026-04-09 00:00:00
5268	Maxitubo Polvorones	None	9	22	8.00	10.50	100	10	2026-04-09 00:00:00
5269	Ricanelas	None	9	46	8.00	10.50	100	10	2026-04-09 00:00:00
5270	Ritz bits queso	None	9	58	8.00	10.50	100	10	2026-04-09 00:00:00
5271	Arcoiris	None	9	46	8.00	10.50	100	10	2026-04-09 00:00:00
5272	Submarinos fresa	None	9	22	8.00	10.50	100	10	2026-04-09 00:00:00
5273	Submarinos vainilla	None	9	22	8.00	10.50	100	10	2026-04-09 00:00:00
5274	Submarinos chocolate	None	9	22	8.00	10.50	100	10	2026-04-09 00:00:00
5275	Rocko chico	None	9	22	8.00	10.50	100	10	2026-04-09 00:00:00
5276	Rocko grande	None	9	22	8.00	10.50	100	10	2026-04-09 00:00:00
5277	Sabritas original	None	9	3	8.00	10.50	100	10	2026-04-09 00:00:00
5278	Sabritas adobadas	None	9	3	8.00	10.50	100	10	2026-04-09 00:00:00
5279	Sabritas limon	None	9	3	8.00	10.50	100	10	2026-04-09 00:00:00
5280	Sabritas flamin hot	None	9	3	8.00	10.50	100	10	2026-04-09 00:00:00
5281	Sabritas crema y especias	None	9	3	8.00	10.50	100	10	2026-04-09 00:00:00
5282	Sabritas habanero	None	9	3	8.00	10.50	100	10	2026-04-09 00:00:00
5283	Sabritas receta crujiente	None	9	3	8.00	10.50	100	10	2026-04-09 00:00:00
5284	Sabritas receta crujiente jalapeno	None	9	3	8.00	10.50	100	10	2026-04-09 00:00:00
5285	Crujitos	None	9	3	8.00	10.50	100	10	2026-04-09 00:00:00
5286	Papatinas	None	9	47	8.00	10.50	100	10	2026-04-09 00:00:00
5287	Doritos incognita	None	9	3	8.00	10.50	100	10	2026-04-09 00:00:00
5288	Doritos diablo	None	9	3	8.00	10.50	100	10	2026-04-09 00:00:00
5289	Doritos flamin hot	None	9	3	8.00	10.50	100	10	2026-04-09 00:00:00
5290	Doritos dinamita	None	9	3	8.00	10.50	100	10	2026-04-09 00:00:00
5291	Sabritones	None	9	3	8.00	10.50	100	10	2026-04-09 00:00:00
5292	Bigmix queso	None	9	47	8.00	10.50	100	10	2026-04-09 00:00:00
5293	Bigmix fuego	None	9	47	8.00	10.50	100	10	2026-04-09 00:00:00
5294	Cheetos torciditos	None	9	3	8.00	10.50	100	10	2026-04-09 00:00:00
5295	Cheetos bolitas	None	9	3	8.00	10.50	100	10	2026-04-09 00:00:00
5296	Cheetos queso	None	9	3	8.00	10.50	100	10	2026-04-09 00:00:00
5297	Cheetos flamin hot	None	9	3	8.00	10.50	100	10	2026-04-09 00:00:00
5298	Ruffles original	None	9	3	8.00	10.50	100	10	2026-04-09 00:00:00
5299	Ruffles queso	None	9	3	8.00	10.50	100	10	2026-04-09 00:00:00
5300	Fritos sal y limon	None	9	3	8.00	10.50	100	10	2026-04-09 00:00:00
5301	Fritos chorizo	None	9	3	8.00	10.50	100	10	2026-04-09 00:00:00
5302	Bolsaza Sabritas original	None	9	3	8.00	10.50	100	10	2026-04-09 00:00:00
5303	Bolsaza Doritos nacho	None	9	3	8.00	10.50	100	10	2026-04-09 00:00:00
5305	Paketaxo queso	None	9	3	8.00	10.50	100	10	2026-04-09 00:00:00
5306	Paketaxo flamin hot	None	9	3	8.00	10.50	100	10	2026-04-09 00:00:00
5307	Churrumaiz	None	9	3	8.00	10.50	100	10	2026-04-09 00:00:00
5308	Churrumaiz flamin hot	None	9	3	8.00	10.50	100	10	2026-04-09 00:00:00
5309	Rancheritos	None	9	3	8.00	10.50	100	10	2026-04-09 00:00:00
5310	Sabritas switch doritos nacho	None	9	3	8.00	10.50	100	10	2026-04-09 00:00:00
5311	Runners	None	9	47	8.00	10.50	100	10	2026-04-09 00:00:00
5312	Chips jalapeno	None	9	47	8.00	10.50	100	10	2026-04-09 00:00:00
5313	Chips sal	None	9	47	8.00	10.50	100	10	2026-04-09 00:00:00
5314	Cremax fresa	None	29	46	8.00	10.50	100	10	2026-04-09 00:00:00
5315	Chips fuego	None	9	47	8.00	10.50	100	10	2026-04-09 00:00:00
5316	Palomitas pop	None	9	47	8.00	10.50	100	10	2026-04-09 00:00:00
5317	Takis original 	None	9	47	8.00	10.50	100	10	2026-04-09 00:00:00
5318	Takis fuego	None	9	47	8.00	10.50	100	10	2026-04-09 00:00:00
5319	Takis salsa brava	None	9	47	8.00	10.50	100	10	2026-04-09 00:00:00
5320	Takis guacamole	None	9	47	8.00	10.50	100	10	2026-04-09 00:00:00
5321	Chipotles	None	9	47	8.00	10.50	100	10	2026-04-09 00:00:00
5322	Tostachos	None	9	47	8.00	10.50	100	10	2026-04-09 00:00:00
5323	Hot nuts	None	9	47	8.00	10.50	100	10	2026-04-09 00:00:00
5324	Hot nuts fuego	None	9	47	8.00	10.50	100	10	2026-04-09 00:00:00
5325	Valentones	None	9	47	8.00	10.50	100	10	2026-04-09 00:00:00
5326	Watz barcel	None	9	47	8.00	10.50	100	10	2026-04-09 00:00:00
5327	Toreadas	None	9	47	8.00	10.50	100	10	2026-04-09 00:00:00
5328	Palomitas pop fuego	None	9	47	8.00	10.50	100	10	2026-04-09 00:00:00
5329	Takis blue heat	None	9	47	8.00	10.50	100	10	2026-04-09 00:00:00
5330	Doraditas tia rosa	None	29	49	8.00	10.50	100	10	2026-04-09 00:00:00
5331	Cremax chocolate	None	29	46	8.00	10.50	100	10	2026-04-09 00:00:00
5332	Doritos nacho	None	9	3	8.00	10.50	100	10	2026-04-09 00:00:00
5333	Leche Alpura 250ml Vainilla	Leche saborizada Vainilla 250ml	15	18	8.50	12.00	0	5	2026-04-09 00:00:00
5334	Hersheys Cookies n Cream	None	8	45	8.00	10.50	100	10	2026-04-09 00:00:00
5335	Hersheys almendras	None	8	45	8.00	10.50	100	10	2026-04-09 00:00:00
5336	Hersheys chocolate amargo	None	8	45	8.00	10.50	100	10	2026-04-09 00:00:00
5337	Hersheys chocolate blanco	None	8	45	8.00	10.50	100	10	2026-04-09 00:00:00
5338	Crunch	None	8	19	8.00	10.50	100	10	2026-04-09 00:00:00
5339	Carlos V	None	8	19	8.00	10.50	100	10	2026-04-09 00:00:00
5340	Milky way	None	8	19	8.00	10.50	100	10	2026-04-09 00:00:00
5341	Snickers	None	8	19	8.00	10.50	100	10	2026-04-09 00:00:00
5342	Kit kat	None	8	19	8.00	10.50	100	10	2026-04-09 00:00:00
5343	Kinder delice	None	8	40	8.00	10.50	100	10	2026-04-09 00:00:00
5344	Kinder sorpresa	None	8	40	8.00	10.50	100	10	2026-04-09 00:00:00
5345	Ferrero rocher 3 piezas	None	8	40	8.00	10.50	100	10	2026-04-09 00:00:00
5346	Mazapan	None	8	62	8.00	10.50	100	10	2026-04-09 00:00:00
5347	Pelon pelo rico	None	8	45	8.00	10.50	100	10	2026-04-09 00:00:00
5348	Pulparindo tamarindo	None	8	62	8.00	10.50	100	10	2026-04-09 00:00:00
5349	Pulparindo chamoy	None	8	62	8.00	10.50	100	10	2026-04-09 00:00:00
5350	Tutsi pop	None	8	65	8.00	10.50	100	10	2026-04-09 00:00:00
5351	Oblea cajeta coronado	None	8	66	8.00	10.50	100	10	2026-04-09 00:00:00
5352	Paleta payaso	None	8	67	8.00	10.50	100	10	2026-04-09 00:00:00
5353	Duvalin fresa vainilla	None	8	67	8.00	10.50	100	10	2026-04-09 00:00:00
5354	Duvalin chocolate vainilla	None	8	67	8.00	10.50	100	10	2026-04-09 00:00:00
5355	Duvalin vainilla	None	8	67	8.00	10.50	100	10	2026-04-09 00:00:00
5356	Duvalin trisabor	None	8	67	8.00	10.50	100	10	2026-04-09 00:00:00
5357	Duvalin choco avellana	None	8	67	8.00	10.50	100	10	2026-04-09 00:00:00
5358	Paleta Vero mango	None	8	68	8.00	10.50	100	10	2026-04-09 00:00:00
5359	Paleta Vero elote	None	8	67	8.00	10.50	100	10	2026-04-09 00:00:00
5360	Panditas	None	8	67	8.00	10.50	100	10	2026-04-09 00:00:00
5361	Panditas rellenos	None	8	67	8.00	10.50	100	10	2026-04-09 00:00:00
5362	Panditas san valentin	None	8	67	8.00	10.50	100	10	2026-04-09 00:00:00
5363	Bubulubu	None	8	67	8.00	10.50	100	10	2026-04-09 00:00:00
5364	Rockaleta	None	8	69	8.00	10.50	100	10	2026-04-09 00:00:00
5365	Tic tac menta	None	8	40	8.00	10.50	100	10	2026-04-09 00:00:00
5366	Tic tac naranja	None	8	40	8.00	10.50	100	10	2026-04-09 00:00:00
5367	Halls menta	None	8	58	8.00	10.50	100	10	2026-04-09 00:00:00
5368	Conchas tia rosa	None	29	49	8.00	10.50	100	10	2026-04-09 00:00:00
5369	Halls yerba buena	None	8	58	8.00	10.50	100	10	2026-04-09 00:00:00
5370	Halls miel	None	8	58	8.00	10.50	100	10	2026-04-09 00:00:00
5371	Halls negras	None	8	58	8.00	10.50	100	10	2026-04-09 00:00:00
5372	Gomilocas dientes	None	8	67	8.00	10.50	100	10	2026-04-09 00:00:00
5373	Gomilocas pinguino	None	8	67	8.00	10.50	100	10	2026-04-09 00:00:00
5374	Chocoretas	None	8	67	8.00	10.50	100	10	2026-04-09 00:00:00
5375	Kranky	None	8	67	8.00	10.50	100	10	2026-04-09 00:00:00
5376	Lucas muecas	None	8	58	8.00	10.50	100	10	2026-04-09 00:00:00
5377	Lucas chamoy	None	8	58	8.00	10.50	100	10	2026-04-09 00:00:00
5378	Lucas gusanito	None	8	58	8.00	10.50	100	10	2026-04-09 00:00:00
5379	Palomitas Act II mantequilla	None	9	58	8.00	10.50	100	10	2026-04-09 00:00:00
5380	Palomitas Act II natural	None	9	58	8.00	10.50	100	10	2026-04-09 00:00:00
5381	Palomitas Act II chile limon	None	9	58	8.00	10.50	100	10	2026-04-09 00:00:00
5382	Tostitos salsa verde	None	9	3	8.00	10.50	100	10	2026-04-09 00:00:00
5383	Zucaritas chicas	None	5	26	8.00	10.50	100	10	2026-04-09 00:00:00
5384	Zucaritas grandes	None	5	26	8.00	10.50	100	10	2026-04-09 00:00:00
5385	Corn flakes chicas	None	5	26	8.00	10.50	100	10	2026-04-09 00:00:00
5386	Corn flakes grandes	None	5	26	8.00	10.50	100	10	2026-04-09 00:00:00
5387	Choco Krispis chicas	None	5	26	8.00	10.50	100	10	2026-04-09 00:00:00
5388	Choco Krispis grandes	None	5	26	8.00	10.50	100	10	2026-04-09 00:00:00
5389	Nesquik chico	None	5	26	8.00	10.50	100	10	2026-04-09 00:00:00
5390	Nesquik grande	None	5	26	8.00	10.50	100	10	2026-04-09 00:00:00
5391	Froot loops chicas	None	5	26	8.00	10.50	100	10	2026-04-09 00:00:00
5392	Froot loops grandes	None	5	26	8.00	10.50	100	10	2026-04-09 00:00:00
5393	Chocomilk sobre	None	4	58	8.00	10.50	100	10	2026-04-09 00:00:00
5394	Chocomilk bolsa	None	4	58	8.00	10.50	100	10	2026-04-09 00:00:00
5395	Chocomilk lata	None	4	58	8.00	10.50	100	10	2026-04-09 00:00:00
5396	Nescafe clasico sobre	None	4	19	8.00	10.50	100	10	2026-04-09 00:00:00
5397	Nescafe capuccino sobre	None	4	19	8.00	10.50	100	10	2026-04-09 00:00:00
5398	Nescafe clasico bote chico	None	4	19	8.00	10.50	100	10	2026-04-09 00:00:00
5399	Nescafe clasico bote grande	None	4	19	8.00	10.50	100	10	2026-04-09 00:00:00
5400	Azucar Zulka 1kg	None	3	58	8.00	10.50	100	10	2026-04-09 00:00:00
5401	Azucar refinada 1kg	None	3	58	8.00	10.50	100	10	2026-04-09 00:00:00
5402	Azucar refinada 500gr	None	3	58	8.00	10.50	100	10	2026-04-09 00:00:00
5403	Azucar refinada 250gr	None	3	58	8.00	10.50	100	10	2026-04-09 00:00:00
5404	Aceite nutrioli 1lt	None	1	58	8.00	10.50	100	10	2026-04-09 00:00:00
5405	Aceite capullo 1lt	None	1	58	8.00	10.50	100	10	2026-04-09 00:00:00
5406	Aceite 1 2 3 1lt	None	1	58	8.00	10.50	100	10	2026-04-09 00:00:00
5407	Aceite patrona 1lt	None	1	58	8.00	10.50	100	10	2026-04-09 00:00:00
5408	Vinagre blanco la coste¤a	None	1	27	8.00	10.50	100	10	2026-04-09 00:00:00
5409	Vinagre de manzana la coste¤a	None	1	27	8.00	10.50	100	10	2026-04-09 00:00:00
5410	Catsup la coste¤a	None	1	27	8.00	10.50	100	10	2026-04-09 00:00:00
5411	Catsup Del monte	None	1	70	8.00	10.50	100	10	2026-04-09 00:00:00
5412	Catsup heinz	None	1	71	8.00	10.50	100	10	2026-04-09 00:00:00
5413	Jugo Magui	None	7	19	8.00	10.50	100	10	2026-04-09 00:00:00
5414	Salsa inglesa	None	7	19	8.00	10.50	100	10	2026-04-09 00:00:00
5415	Salsa valentina chica	None	7	58	8.00	10.50	100	10	2026-04-09 00:00:00
5416	Salsa valentina grande	None	7	58	8.00	10.50	100	10	2026-04-09 00:00:00
5417	Salsa tabasco	None	7	58	8.00	10.50	100	10	2026-04-09 00:00:00
5418	Salsa buffalo	None	7	58	8.00	10.50	100	10	2026-04-09 00:00:00
5419	Salsa chipotle la coste¤a	None	7	27	8.00	10.50	100	10	2026-04-09 00:00:00
5420	Chile chipotle la coste¤a	None	6	27	8.00	10.50	100	10	2026-04-09 00:00:00
5421	Tortillinas tia rosa	None	10	49	8.00	10.50	100	10	2026-04-09 00:00:00
5422	Halls limon	None	8	58	8.00	10.50	100	10	2026-04-09 00:00:00
5423	Mermelada mccormick fresa chica	None	19	72	8.00	10.50	100	10	2026-04-09 00:00:00
5424	Mermelada mccormick fresa grande	None	19	72	8.00	10.50	100	10	2026-04-09 00:00:00
5425	Papel higienico Suavel 4 rollos	None	37	58	8.00	10.50	100	10	2026-04-09 00:00:00
5426	Papel higienico Suavel 6 rollos	None	37	58	8.00	10.50	100	10	2026-04-09 00:00:00
5427	Toallas sanitarias Always	None	37	58	8.00	10.50	100	10	2026-04-09 00:00:00
5428	Toallas sanitarias Kotex	None	37	58	8.00	10.50	100	10	2026-04-09 00:00:00
5429	Licuado lala fresa platano	None	15	4	15.00	30.00	100	10	2026-04-09 00:00:00
5430	Licuado lala nuez	None	15	4	15.00	30.00	100	10	2026-04-09 00:00:00
5431	Flan lala	None	15	4	15.00	30.00	100	10	2026-04-09 00:00:00
5432	Margarina lala 90gr	None	15	4	15.00	30.00	100	10	2026-04-09 00:00:00
5433	Perejil ramo		21	58	3.00	5.00	5	1	2026-04-09 00:00:00
5434	Producto nuevo de prueba	Producto para ver funciones	4	4	28.00	32.50	19	5	2026-04-09 00:00:00
5435	Media Crema Nestle 190g	Media Crema para cocina 190g	15	19	13.00	18.00	0	5	2026-04-09 00:00:00
5436	Leche Condensada La Lechera 375g	Leche Condensada Clasica 375g	11	19	22.00	29.00	0	5	2026-04-09 00:00:00
5437	Panales Huggies	None	44	58	8.00	10.50	100	10	2026-04-09 00:00:00
5438	Shampoo Head & Shoulders chico	None	39	58	8.00	10.50	100	10	2026-04-09 00:00:00
5439	Shampoo Head & Shoulders grande	None	39	58	8.00	10.50	100	10	2026-04-09 00:00:00
5440	Desodorante Axe	None	41	58	8.00	10.50	100	10	2026-04-09 00:00:00
5441	Leche Evaporada Carnation 360g	Leche Evaporada Carnation 360g	15	19	16.00	22.00	0	5	2026-04-09 00:00:00
5442	Yogurt Lala Fresa Bebible 220g	Yogurt bebible sabor Fresa 220g	17	4	9.00	13.00	0	5	2026-04-09 00:00:00
5443	Yogurt Lala Durazno Bebible 220g	Yogurt bebible sabor Durazno 220g	17	4	9.00	13.00	0	5	2026-04-09 00:00:00
5444	Yogurt Lala Manzana Bebible 220g	Yogurt bebible sabor Manzana 220g	17	4	9.00	13.00	0	5	2026-04-09 00:00:00
5445	Yogurt Danone Fresa Batido 120g	Yogurt batido sabor Fresa 120g	17	58	7.00	10.00	0	5	2026-04-09 00:00:00
5446	Yogurt Danone Natilla Chocolate	Postre sabor Chocolate Danone	17	58	8.00	11.00	0	5	2026-04-09 00:00:00
5447	Queso Philadelphia 180g	Queso Crema Philadelphia 180g	16	58	32.00	42.00	0	5	2026-04-09 00:00:00
5448	Queso Panela La Villita 400g	Queso Panela La Villita 400g	16	58	55.00	72.00	0	5	2026-04-09 00:00:00
5449	Mantequilla Gloria 90g	Mantequilla Gloria con Sal 90g	19	58	18.00	24.00	0	5	2026-04-09 00:00:00
5450	Margarina Primavera 200g	Margarina Primavera 200g	19	58	15.00	21.00	0	5	2026-04-09 00:00:00
5451	Huevo Blanco 12 pzas	Paquete Huevo Blanco 12 piezas	14	58	30.00	38.00	0	5	2026-04-09 00:00:00
5452	Huevo Blanco 18 pzas	Paquete Huevo Blanco 18 piezas	14	23	42.00	55.00	0	5	2026-04-09 00:00:00
5453	Papas Sabritas Sal 42g	Papas fritas con sal 42g	9	3	13.50	18.00	0	5	2026-04-09 00:00:00
5454	Cloralex 1/2 lt	None	35	58	8.00	10.50	100	10	2026-04-09 00:00:00
5455	Leche deslactosada 1lt	Presentacion azul	15	4	18.20	23.00	13	2	2026-04-09 00:00:00
5456	Yogurt Yoplait natural 1L	Yogurt Yoplait natural 1 Litro	17	54	26.00	31.00	100	10	2026-04-09 00:00:00
5457	Yomi lala chocolate	None	15	4	15.00	30.00	100	10	2026-04-09 00:00:00
5458	Cremax vainilla	None	29	46	8.00	10.50	100	10	2026-04-09 00:00:00
5459	Maxitubo Barritas fresa	None	9	22	8.00	10.50	100	10	2026-04-09 00:00:00
5460	Bigote tia rosa	None	29	49	8.00	10.50	100	10	2026-04-09 00:00:00
5461	Magdalenas tia rosa	None	29	49	8.00	10.50	100	10	2026-04-09 00:00:00
5462	Chiles serranos la coste¤a	None	6	27	8.00	10.50	100	10	2026-04-09 00:00:00
5463	Chiles en vinagre la coste¤a	None	6	27	8.00	10.50	100	10	2026-04-09 00:00:00
5464	Chile chipotle la morena	None	6	72	8.00	10.50	100	10	2026-04-09 00:00:00
5465	Chiles en vinagre la morena	None	6	72	8.00	10.50	100	10	2026-04-09 00:00:00
5466	Mayonesa mccormick chica	None	7	72	8.00	10.50	100	10	2026-04-09 00:00:00
5467	Mayonesa mccormick grande	None	7	72	8.00	10.50	100	10	2026-04-09 00:00:00
5468	Mostaza mccormick	None	7	72	8.00	10.50	100	10	2026-04-09 00:00:00
5469	Cloralex 1 lt	None	35	58	8.00	10.50	100	10	2026-04-09 00:00:00
5470	Pinol	None	35	58	8.00	10.50	100	10	2026-04-09 00:00:00
5471	Fabuloso lavanda 1lt	None	35	58	8.00	10.50	100	10	2026-04-09 00:00:00
5472	Fabuloso aroma floral 1lt	None	35	58	8.00	10.50	100	10	2026-04-09 00:00:00
5473	Papas Sabritas Adobadas 42g	Papas fritas adobadas 42g	9	3	13.50	18.00	0	5	2026-04-09 00:00:00
5474	Papas Sabritas Limon 42g	Papas fritas con limon 42g	9	3	13.50	18.00	0	5	2026-04-09 00:00:00
5475	Doritos Nacho 61g	Botana de maiz sabor Queso 61g	9	3	13.00	18.00	0	5	2026-04-09 00:00:00
5476	Doritos Pizzerola 61g	Botana de maiz sabor Pizza 61g	9	3	13.00	18.00	0	5	2026-04-09 00:00:00
5477	Jabon zote rosa chico	None	42	58	8.00	10.50	100	10	2026-04-09 00:00:00
5478	Jabon zote rosa grande	None	42	58	8.00	10.50	100	10	2026-04-09 00:00:00
5479	Jabon zote blanco chico	None	42	58	8.00	10.50	100	10	2026-04-09 00:00:00
5480	Jabon zote blanco grande	None	42	58	8.00	10.50	100	10	2026-04-09 00:00:00
5481	Detergente Ariel 1/2 kg	None	34	58	8.00	10.50	100	10	2026-04-09 00:00:00
5482	Detergente Ariel 1kg	None	34	58	8.00	10.50	100	10	2026-04-09 00:00:00
5483	Detergente Ace 1/2 kg	None	34	58	8.00	10.50	100	10	2026-04-09 00:00:00
5484	Detergente Ace 1kg	None	34	58	8.00	10.50	100	10	2026-04-09 00:00:00
5485	Detergente Foca 1/2 kg	None	34	58	8.00	10.50	100	10	2026-04-09 00:00:00
5486	Detergente Foca 1kg	None	34	58	8.00	10.50	100	10	2026-04-09 00:00:00
5487	Suavitel 1l	None	34	58	8.00	10.50	100	10	2026-04-09 00:00:00
5488	Yomi lala vainilla	None	15	4	15.00	30.00	100	10	2026-04-09 00:00:00
5489	Yomi lala fresa	None	15	4	15.00	30.00	100	10	2026-04-09 00:00:00
5490	Yogurt lala fresa	None	15	4	15.00	30.00	100	10	2026-04-09 00:00:00
5491	Yogurt lala durazno	None	15	4	15.00	30.00	100	10	2026-04-09 00:00:00
5492	Yogurt lala manzana	None	15	4	15.00	30.00	100	10	2026-04-09 00:00:00
5493	Yogurt bebible lala manzana	None	15	4	15.00	30.00	100	10	2026-04-09 00:00:00
5494	Yogurt bebible lala durazno	None	15	4	15.00	30.00	100	10	2026-04-09 00:00:00
5495	Yogurt bebible lala fresa	None	15	4	15.00	30.00	100	10	2026-04-09 00:00:00
5496	Yogurt bebible lala moras	None	15	4	15.00	30.00	100	10	2026-04-09 00:00:00
5497	Yogurt bebible lala pina coco	None	15	4	15.00	30.00	100	10	2026-04-09 00:00:00
5498	Cheetos Torciditos 52g	Botana de maiz sabor Queso y Chile 52g	9	3	10.00	14.00	0	5	2026-04-09 00:00:00
5499	Papel higienico Petalo 4 rollos	None	37	58	8.00	10.50	100	10	2026-04-09 00:00:00
5500	Papel higienico Petalo 6 rollos	None	37	58	8.00	10.50	100	10	2026-04-09 00:00:00
5501	Cheetos Colmillos 27g	Botana de maiz sabor Queso y Chile 27g	9	3	6.00	9.00	0	5	2026-04-09 00:00:00
5502	Ruffles Queso 50g	Papas onduladas sabor Queso 50g	9	3	13.50	18.00	0	5	2026-04-09 00:00:00
5503	Tostitos Verdes 65g	Botana de maiz sabor Salsa Verde 65g	9	3	13.00	18.00	0	5	2026-04-09 00:00:00
5504	Takis Fuego 65g	Botana de maiz sabor Fuego 65g	9	58	12.00	17.00	0	5	2026-04-09 00:00:00
5505	Chips Sal de Mar 42g	Papas fritas con Sal de Mar 42g	9	58	14.00	19.00	0	5	2026-04-09 00:00:00
5506	Cacahuates Sabritas Japones 45g	Cacahuates estilo Japones 45g	9	3	9.00	12.00	0	5	2026-04-09 00:00:00
5507	Cacahuates Sabritas Enchilados 45g	Cacahuates Enchilados 45g	9	3	9.00	12.00	0	5	2026-04-09 00:00:00
5508	Galletas Emperador Chocolate Tubo	Galletas sandwich sabor Chocolate	9	46	13.00	18.00	0	5	2026-04-09 00:00:00
5509	Galletas Emperador Vainilla Tubo	Galletas sandwich sabor Vainilla	9	46	13.00	18.00	0	5	2026-04-09 00:00:00
5510	Galletas Marias Gamesa 144g	Galletas tipo Maria 144g	9	46	11.00	15.00	0	5	2026-04-09 00:00:00
5511	Galletas Chokis Clasica 63g	Galletas con chispas de chocolate 63g	9	46	12.00	16.00	0	5	2026-04-09 00:00:00
5512	Galletas Saladitas Gamesa 137g	Galletas saladas 137g	9	46	14.00	19.00	0	5	2026-04-09 00:00:00
5513	Galletas Ritz Tubo 89g	Galletas saladas Ritz 89g	9	58	11.00	15.00	0	5	2026-04-09 00:00:00
5514	Galletas Oreo 6 pzas	Galletas sandwich sabor Chocolate 6 pzas	9	58	11.00	15.00	0	5	2026-04-09 00:00:00
5515	Barritas Marinela Fresa 67g	Galletas rellenas de Fresa 67g	29	22	12.00	16.00	0	5	2026-04-09 00:00:00
5516	Barritas Marinela Pina 67g	Galletas rellenas de Pina 67g	29	22	12.00	16.00	0	5	2026-04-09 00:00:00
5517	Canelitas Marinela Tubo	Galletas sabor Canela	29	22	13.00	18.00	0	5	2026-04-09 00:00:00
5518	Triki-Trakes Marinela Tubo	Galletas con chispas de chocolate	29	22	13.00	18.00	0	5	2026-04-09 00:00:00
5519	Pinguinos Marinela 2 pzas	Pastelitos sabor Chocolate 2 pzas	29	22	15.00	21.00	0	5	2026-04-09 00:00:00
5520	Choco Roles Marinela 2 pzas	Pastelitos con chocolate y piña 2 pzas	29	22	15.00	21.00	0	5	2026-04-09 00:00:00
5521	Gansito Marinela 50g	Pastelito cubierto de chocolate 50g	29	22	12.00	17.00	0	5	2026-04-09 00:00:00
5522	Mantecadas Bimbo 4 pzas	Pan dulce sabor Vainilla 4 pzas	29	17	19.00	26.00	0	5	2026-04-09 00:00:00
5523	Panque Bimbo Nuez	Panque con trozos de nuez	29	17	35.00	48.00	0	5	2026-04-09 00:00:00
5524	Detergente Roma 1kg	Detergente multiusos en polvo 1kg	34	33	28.00	36.00	0	5	2026-04-09 00:00:00
5525	Detergente Roma 500g	Detergente multiusos en polvo 500g	34	33	15.00	20.00	0	5	2026-04-09 00:00:00
5526	Detergente Foca 1kg	Detergente biodegradable en polvo 1kg	34	33	30.00	38.00	0	5	2026-04-09 00:00:00
5527	Detergente Blanca Nieves 1kg	Detergente en polvo para ropa 1kg	34	33	29.00	37.00	0	5	2026-04-09 00:00:00
5528	Jabon Zote Rosa 400g	Jabon de lavanderia Rosa 400g	33	33	18.00	24.00	0	5	2026-04-09 00:00:00
5529	Jabon Zote Blanco 400g	Jabon de lavanderia Blanco 400g	33	33	18.00	24.00	0	5	2026-04-09 00:00:00
5530	Jabon Zote Azul 400g	Jabon de lavanderia Azul 400g	33	33	18.00	24.00	0	5	2026-04-09 00:00:00
5531	Suavitel Primavera 850ml	Suavizante de telas Primavera 850ml	32	32	20.00	28.00	0	5	2026-04-09 00:00:00
5532	Fabuloso Lavanda 1L	Limpiador multiusos Lavanda 1L	35	30	22.00	30.00	0	5	2026-04-09 00:00:00
5533	Pinol Original 1L	Limpiador desinfectante de Pino 1L	35	58	24.00	32.00	0	5	2026-04-09 00:00:00
5534	Cloralex El Rendidor 950ml	Blanqueador desinfectante 950ml	35	58	14.00	19.00	0	5	2026-04-09 00:00:00
5535	Axion Liquido Limon 400ml	Lavatrastes liquido Limon 400ml	34	30	18.00	25.00	0	5	2026-04-09 00:00:00
5536	Jabon Palmolive Neutro 150g	Jabon de tocador Neutro 150g	41	31	12.00	17.00	0	5	2026-04-09 00:00:00
5537	Jabon Zest Frescura 150g	Jabon de tocador Zest 150g	41	58	12.00	17.00	0	5	2026-04-09 00:00:00
5538	Pasta Colgate Triple Accion 75ml	Pasta dental Triple Accion 75ml	38	30	14.00	20.00	0	5	2026-04-09 00:00:00
5539	Pasta Colgate Total 12 100ml	Pasta dental Total 12 100ml	38	30	28.00	38.00	0	5	2026-04-09 00:00:00
5540	Shampoo Savile Biotina 750ml	Shampoo con Biotina y Sábila 750ml	35	58	32.00	45.00	0	5	2026-04-09 00:00:00
5541	Shampoo Pantene Restauracion 400ml	Shampoo Restauracion 400ml	35	35	45.00	62.00	0	5	2026-04-09 00:00:00
5542	Papel Regio Aires Frescura 4 rollos	Papel Higienico Regio 4 rollos	43	29	22.00	30.00	0	5	2026-04-09 00:00:00
5543	Papel Petalo Rendimax 4 rollos	Papel Higienico Petalo 4 rollos	43	29	20.00	28.00	0	5	2026-04-09 00:00:00
5544	Aceite Nutrioli 850ml	Aceite puro de Soya 850ml	1	58	32.00	42.00	0	5	2026-04-09 00:00:00
5545	Aceite 1-2-3 1L	Aceite vegetal 1-2-3 1 Litro	1	58	35.00	45.00	0	5	2026-04-09 00:00:00
5546	Arroz Verde Valle 900g	Arroz Super Extra Verde Valle 900g	2	58	24.00	32.00	0	5	2026-04-09 00:00:00
5547	Frijol Negro Verde Valle 900g	Frijol Negro Verde Valle 900g	2	58	38.00	48.00	0	5	2026-04-09 00:00:00
5548	Spaghetti La Moderna 200g	Pasta tipo Spaghetti 200g	2	44	7.50	11.00	0	5	2026-04-09 00:00:00
5549	Codo No. 2 La Moderna 200g	Pasta tipo Codo 200g	2	44	7.50	11.00	0	5	2026-04-09 00:00:00
5550	Fideo No. 0 La Moderna 200g	Pasta tipo Fideo 200g	2	44	7.50	11.00	0	5	2026-04-09 00:00:00
5551	Atun Herdez en Agua 130g	Atun en hojuelas Agua 130g	6	20	14.00	20.00	0	5	2026-04-09 00:00:00
5552	Atun Dolores en Aceite 130g	Atun en hojuelas Aceite 130g	6	51	15.00	21.00	0	5	2026-04-09 00:00:00
5553	Chiles Jalapenos La Costena 220g	Chiles en Vinagre Rajitas 220g	6	27	10.00	14.00	0	5	2026-04-09 00:00:00
5554	Chiles Chipotles La Costena 105g	Chiles Chipotles en Adobo 105g	6	27	9.00	13.00	0	5	2026-04-09 00:00:00
5555	Elotes Dorados Herdez 220g	Granos de Elote Dulce 220g	6	20	11.00	16.00	0	5	2026-04-09 00:00:00
5556	Mayonesa McCormick Limon 190g	Mayonesa con Limon McCormick 190g	12	72	16.00	22.00	0	5	2026-04-09 00:00:00
5557	Mayonesa McCormick Limon 390g	Mayonesa con Limon McCormick 390g	12	72	35.00	45.00	0	5	2026-04-09 00:00:00
5558	Salsa Catsup Del Monte 320g	Salsa de Tomate Catsup 320g	12	58	13.00	18.00	0	5	2026-04-09 00:00:00
5559	Salsa Valentina Amarilla 370ml	Salsa picante Valentina 370ml	12	58	11.00	16.00	0	5	2026-04-09 00:00:00
5560	Cafe Nescafe Clasico 42g	Cafe Soluble Nescafe Clasico 42g	44	19	28.00	38.00	0	5	2026-04-09 00:00:00
5561	Cafe Nescafe Clasico 120g	Cafe Soluble Nescafe Clasico 120g	44	19	65.00	85.00	0	5	2026-04-09 00:00:00
5562	Chocolate Abuelita 90g	Tablilla Chocolate Abuelita 90g	8	19	14.00	20.00	0	5	2026-04-09 00:00:00
5563	Harina Maseca 1kg	Harina de Maiz Nixtamalizado 1kg	10	59	16.00	22.00	0	5	2026-04-09 00:00:00
5564	Harina de Trigo San Antonio 1kg	Harina de Trigo para pan 1kg	10	41	15.00	20.00	0	5	2026-04-09 00:00:00
5565	Azucar Estandar 1kg	Azucar Morena en bolsa 1kg	3	58	22.00	30.00	0	5	2026-04-09 00:00:00
5566	Sal de Mesa La Fina 1kg	Sal yodada La Fina 1kg	13	58	13.00	18.00	0	5	2026-04-09 00:00:00
5567	Consome Knorr Suiza 8 cubos	Sazonador de Pollo en Cubos	13	58	12.00	17.00	0	5	2026-04-09 00:00:00
5568	Pan Blanco Bimbo Gde 680g	Pan de Caja Blanco Grande Bimbo	27	17	35.00	46.00	0	5	2026-04-09 00:00:00
5569	Pan Integral Bimbo Gde 675g	Pan de Caja Integral Grande Bimbo	27	17	38.00	50.00	0	5	2026-04-09 00:00:00
5570	Tostadas Charras Amarillas 300g	Tostadas de Maiz Charras 300g	5	60	22.00	30.00	0	5	2026-04-09 00:00:00
5571	Tostadas Sanissimo Horneadas 20 pzas	Tostadas Horneadas Sanissimo	5	61	25.00	35.00	0	5	2026-04-09 00:00:00
5572	Corn Flakes Kelloggs 500g	Cereal de Maiz Corn Flakes 500g	5	26	38.00	52.00	0	5	2026-04-09 00:00:00
5573	Zucaritas Kelloggs 600g	Cereal de Maiz con Azucar 600g	5	26	45.00	60.00	0	5	2026-04-09 00:00:00
5574	Choco Krispis Kelloggs 600g	Cereal de Arroz con Chocolate 600g	5	26	45.00	60.00	0	5	2026-04-09 00:00:00
5575	Avena Quaker Instantanea 400g	Avena con Proteina Quaker 400g	25	25	28.00	38.00	0	5	2026-04-09 00:00:00
5576	Barritas Quaker Fresa 6 pzas	Barras de Avena con Fresa	25	25	22.00	30.00	0	5	2026-04-09 00:00:00
5577	Trident Menta 12 pzas	Goma de mascar sin azucar Menta	8	58	10.00	15.00	0	5	2026-04-09 00:00:00
5578	Trident Yerba Buena 12 pzas	Goma de mascar sin azucar Yerba Buena	8	58	10.00	15.00	0	5	2026-04-09 00:00:00
5579	Chicles Canels 4 pastillas	Goma de mascar Canels caja chica	8	62	1.50	3.00	0	5	2026-04-09 00:00:00
5580	Bubbaloo Fresa 1 pza	Chicle con relleno liquido Fresa	8	58	1.50	3.00	0	5	2026-04-09 00:00:00
5581	Bubbaloo Blue 1 pza	Chicle con relleno liquido Mora Azul	8	58	1.50	3.00	0	5	2026-04-09 00:00:00
5582	Carlos V Stick Chocolate	Barra de chocolate Carlos V chocolate	8	19	5.00	8.00	0	5	2026-04-09 00:00:00
5583	Crunch Stick Chocolate	Barra de chocolate con arroz inflado	8	19	5.00	8.00	0	5	2026-04-09 00:00:00
5584	Kinder Delice 39g	Pastelito relleno Kinder Delice	8	40	12.00	17.00	0	5	2026-04-09 00:00:00
5585	Kinder Sorpresa 20g	Huevo de chocolate con juguete	8	40	18.00	26.00	0	5	2026-04-09 00:00:00
5586	Ferrero Rocher 3 pzas	Bombones cubiertos de nuez Ferrero	8	40	25.00	35.00	0	5	2026-04-09 00:00:00
5587	Hersheys Cookies n Cream 40g	Barra chocolate blanco con galleta	8	45	11.00	16.00	0	5	2026-04-09 00:00:00
5588	Mazapan de la Rosa 28g	Dulce de cacahuate Mazapan	8	62	4.00	7.00	0	5	2026-04-09 00:00:00
5589	Pulparindo Clasico 14g	Dulce de tamarindo con chile	8	62	3.00	5.00	0	5	2026-04-09 00:00:00
5590	Pelon Pelo Rico 30g	Dulce de tamarindo suave	8	45	7.00	11.00	0	5	2026-04-09 00:00:00
5591	Paleta Payaso 45g	Malvavisco con chocolate y gomitas	8	67	12.00	18.00	0	5	2026-04-09 00:00:00
5592	Duvalin Trisabor 15g	Dulce de avellana, fresa y vainilla	8	67	3.00	5.00	0	5	2026-04-09 00:00:00
5593	Rockaleta Paleta 24g	Paleta con capas de chile y goma	8	69	4.50	8.00	0	5	2026-04-09 00:00:00
5594	Halls Mentol 9 pastillas	Pastillas refrescantes Mentol	8	58	8.00	12.00	0	5	2026-04-09 00:00:00
5595	Skwinkles Rellenos Pina	Dulce de chamoy relleno pina	8	45	9.00	14.00	0	5	2026-04-09 00:00:00
5596	Lucas Muecas Chamoy	Caramelo con polvo de chamoy	8	45	10.00	15.00	0	5	2026-04-09 00:00:00
5597	Tutsi Pop 1 pza	Paleta rellena de chicle	8	65	4.50	8.00	0	5	2026-04-09 00:00:00
5598	Agua Bonafont 600ml	Agua ligera Bonafont 600ml	30	55	8.00	12.00	0	5	2026-04-09 00:00:00
5599	Agua Bonafont 1.5L	Agua ligera Bonafont 1.5 Litros	30	55	12.00	17.00	0	5	2026-04-09 00:00:00
5600	Agua Bonafont 2L	Agua ligera Bonafont 2 Litros	30	55	14.00	20.00	0	5	2026-04-09 00:00:00
5601	Agua Mineral Topo Chico 600ml	Agua mineral de manantial 600ml	31	16	15.00	21.00	0	5	2026-04-09 00:00:00
5602	Vitamin Water Energy 500ml	Bebida vitaminada sabor Tropical	31	16	22.00	32.00	0	5	2026-04-09 00:00:00
5603	Monster Energy 473ml	Bebida energetizante original	31	16	30.00	42.00	0	5	2026-04-09 00:00:00
5604	Red Bull 250ml	Bebida energetizante original	31	58	32.00	45.00	0	5	2026-04-09 00:00:00
5605	Clight Jamaica 1 pza	Polvo para preparar bebida 7g	31	58	3.50	6.00	0	5	2026-04-09 00:00:00
5606	Clight Limon 1 pza	Polvo para preparar bebida 7g	31	58	3.50	6.00	0	5	2026-04-09 00:00:00
5607	Tang Naranja 1 pza	Polvo para preparar bebida 13g	31	58	3.50	6.00	0	5	2026-04-09 00:00:00
5608	Tang Pina 1 pza	Polvo para preparar bebida 13g	31	58	3.50	6.00	0	5	2026-04-09 00:00:00
5609	Zuko Horchata 1 pza	Polvo para preparar bebida 15g	31	58	3.50	6.00	0	5	2026-04-09 00:00:00
5610	Jamon de Pavo Fud 500g	Jamon de Pavo paq. 500g	18	53	65.00	85.00	0	5	2026-04-09 00:00:00
5611	Salchicha Viena Fud 500g	Salchicha de Pavo Viena 500g	18	53	42.00	58.00	0	5	2026-04-09 00:00:00
5612	Tocino Fud 250g	Tocino Ahumado de Pavo 250g	18	53	48.00	65.00	0	5	2026-04-09 00:00:00
5613	Salchicha Asar Chimex 800g	Salchicha roja para asar 800g	18	58	75.00	95.00	0	5	2026-04-09 00:00:00
5614	Chorizo de Pavo Fud 200g	Chorizo de Pavo paq. 200g	18	53	22.00	32.00	0	5	2026-04-09 00:00:00
5615	Papas Sabritas Habanero 42g	Papas fritas sabor Habanero 42g	9	3	13.50	18.00	0	5	2026-04-09 00:00:00
5616	Doritos Dinamita 61g	Botana enrollada sabor Chile y Limon	9	3	13.00	18.00	0	5	2026-04-09 00:00:00
5617	Ruffles Mezcla Brava 50g	Papas con botanas mixtas 50g	9	3	14.00	19.00	0	5	2026-04-09 00:00:00
5618	Papas Sabritas Crema y Especias 42g	Papas fritas sabor Crema y Especias	9	3	13.50	18.00	0	5	2026-04-09 00:00:00
5619	Doritos Flamin Hot 61g	Botana de maiz sabor Picante 61g	9	3	13.00	18.00	0	5	2026-04-09 00:00:00
5620	Churrumais con Limon 60g	Fritura de maiz sabor Limon 60g	9	3	8.00	11.00	0	5	2026-04-09 00:00:00
5621	Crujitos Queso y Chile 60g	Botana de maiz en espiral Queso	9	3	11.00	15.00	0	5	2026-04-09 00:00:00
5622	Rancheritos 60g	Botana de maiz sabor Chile y Especias	9	3	11.00	15.00	0	5	2026-04-09 00:00:00
5623	Sabritones 160g	Botana de trigo con Chile y Limon	9	3	18.00	25.00	0	5	2026-04-09 00:00:00
5624	Paketaxo Quexo 215g	Mezcla de botanas sabor Queso	9	3	35.00	48.00	0	5	2026-04-09 00:00:00
5625	Paketaxo Mezcla 215g	Mezcla de botanas variadas Sabritas	9	3	35.00	48.00	0	5	2026-04-09 00:00:00
5626	Chips Fuego 42g	Papas fritas sabor Fuego 42g	9	58	14.00	19.00	0	5	2026-04-09 00:00:00
5627	Takis Blue Heat 65g	Botana de maiz sabor Picante Azul	9	58	12.00	17.00	0	5	2026-04-09 00:00:00
5628	Tostachos Sal y Limon 65g	Botana de maiz tipo tostada	9	58	11.00	15.00	0	5	2026-04-09 00:00:00
5629	Palomitas Pop Sal de Mar 65g	Palomitas de maiz listas para comer	9	58	12.00	17.00	0	5	2026-04-09 00:00:00
5630	Palomitas Pop Acanaladas 65g	Palomitas de maiz sabor Queso	9	58	12.00	17.00	0	5	2026-04-09 00:00:00
5631	Galletas Oreo Chocolate 10 pzas	Galletas Oreo sabor Chocolate	9	58	14.00	19.00	0	5	2026-04-09 00:00:00
5632	Galletas Principe Marinela Tubo	Galletas con relleno de chocolate	9	22	13.50	19.00	0	5	2026-04-09 00:00:00
5633	Galletas Sponch Marinela 4 pzas	Galletas con malvavisco y coco	9	22	12.00	17.00	0	5	2026-04-09 00:00:00
5634	Galletas Polvorones Marinela Tubo	Galletas sabor Naranja	9	22	13.00	18.00	0	5	2026-04-09 00:00:00
5635	Galletas Ricanelas Marinela Tubo	Galletas sabor Canela y Azucar	29	22	13.00	18.00	0	5	2026-04-09 00:00:00
5636	Galletas Florentinas Cajeta Tubo	Galletas rellenas de cajeta	29	46	14.00	19.00	0	5	2026-04-09 00:00:00
5637	Galletas Florentinas Fresa Tubo	Galletas rellenas de fresa	29	46	14.00	19.00	0	5	2026-04-09 00:00:00
5638	Cremax de Nieve Chocolate 171g	Galletas wafer sabor Chocolate	29	46	14.00	19.00	0	5	2026-04-09 00:00:00
5639	Cremax de Nieve Fresa 171g	Galletas wafer sabor Fresa	29	46	14.00	19.00	0	5	2026-04-09 00:00:00
5640	Galletas Habaneras Integrales 117g	Galletas de harina integral	9	46	11.00	16.00	0	5	2026-04-09 00:00:00
5641	Galletas Habaneras Clasicas 117g	Galletas saladas crujientes	9	46	11.00	16.00	0	5	2026-04-09 00:00:00
5642	Galletas Crackets Tubo 95g	Galletas saladas horneadas Crackets	9	46	11.00	16.00	0	5	2026-04-09 00:00:00
5643	Galletas Mamut 44g	Galleta con malvavisco y chocolate	9	46	10.00	14.00	0	5	2026-04-09 00:00:00
5644	Galletas Giros Gamesa 100g	Galletas sandwich sabor chocolate	9	46	12.00	17.00	0	5	2026-04-09 00:00:00
5645	Galletas Senzo Chocolate 60g	Galletas rellenas de chocolate	9	46	11.00	16.00	0	5	2026-04-09 00:00:00
5646	Galletas Habaneras Integrales Tubo	Galletas saladas integrales tubo	9	46	13.00	18.00	0	5	2026-04-09 00:00:00
5647	Galletas Marias Doradas Gamesa	Galletas tipo maria doradas tubo	9	46	13.00	18.00	0	5	2026-04-09 00:00:00
5648	Galletas Piruetas Gamesa Tubo	Galletas sandwich limon tubo	9	46	13.50	19.00	0	5	2026-04-09 00:00:00
5649	Galletas Emperador Piruetas 6 pzas	Galletas sandwich sabor limon	9	46	11.00	15.00	0	5	2026-04-09 00:00:00
5650	Galletas Oreo Mini Copa 45g	Galletas mini oreo en vaso	9	58	12.50	17.00	0	5	2026-04-09 00:00:00
5651	Galletas Ritz Sándwich Queso	Galletas ritz rellenas de queso	9	58	11.00	15.00	0	5	2026-04-09 00:00:00
5652	Galletas Maravillas Vainilla	Galletas sabor vainilla Gamesa	9	46	11.50	16.00	0	5	2026-04-09 00:00:00
5653	Barras de Coco Gamesa	Galletas con trozos de coco	9	46	11.50	16.00	0	5	2026-04-09 00:00:00
5654	Hot Nuts Original 50g	Cacahuates con cobertura picante	9	58	9.50	13.00	0	5	2026-04-09 00:00:00
5655	Hot Nuts Fuego 50g	Cacahuates con cobertura extra picante	9	58	9.50	13.00	0	5	2026-04-09 00:00:00
5656	Big Mix Clasico 50g	Mezcla de botanas Barcel	9	58	11.50	16.00	0	5	2026-04-09 00:00:00
5657	Big Mix Fuego 50g	Mezcla de botanas picantes Barcel	9	58	11.50	16.00	0	5	2026-04-09 00:00:00
5658	Karameladas de Maiz 60g	Palomitas con caramelo Barcel	9	58	12.00	17.00	0	5	2026-04-09 00:00:00
5659	Runners 60g	Botana de maiz sabor picante	9	58	11.00	15.00	0	5	2026-04-09 00:00:00
5660	Takis Original 65g	Botana de maiz enrollada taco	9	58	12.00	17.00	0	5	2026-04-09 00:00:00
5661	Chips Jalapeno 42g	Papas fritas sabor jalapeno	9	58	14.50	20.00	0	5	2026-04-09 00:00:00
5662	Chips Chipotle 42g	Papas fritas sabor chipotle	9	58	14.50	20.00	0	5	2026-04-09 00:00:00
5663	Donitas Totis Sal y Limon 25g	Botana de trigo en aros	9	58	4.00	6.00	0	5	2026-04-09 00:00:00
5664	Donitas Totis Hot 25g	Botana de trigo picante	9	58	4.00	6.00	0	5	2026-04-09 00:00:00
5665	Que活os Barcel 60g	Botana de maiz sabor queso	9	58	11.00	15.00	0	5	2026-04-09 00:00:00
5666	Tostachos Queso 65g	Botana de maiz sabor queso	9	58	11.00	15.00	0	5	2026-04-09 00:00:00
5667	Cacahuates Mafer Salados 65g	Cacahuates premium con sal	9	3	16.00	22.00	0	5	2026-04-09 00:00:00
5668	Cacahuates Mafer Japones 65g	Cacahuates premium japones	9	3	16.00	22.00	0	5	2026-04-09 00:00:00
5669	Bubu Lubu Ricolino 35g	Malvavisco con jalea y chocolate	8	67	9.00	13.00	0	5	2026-04-09 00:00:00
5670	Kranky Ricolino 40g	Hojuelas de maiz con chocolate	8	67	9.50	14.00	0	5	2026-04-09 00:00:00
5671	Chocoretas Ricolino 45g	Bolitas de menta con chocolate	8	67	9.50	14.00	0	5	2026-04-09 00:00:00
5672	Gomitas Panditas Clasicos 45g	Gomitas de ositos frutales	8	67	11.00	15.00	0	5	2026-04-09 00:00:00
5673	Gomitas Panditas Enchilados 45g	Gomitas de ositos con chile	8	67	11.00	15.00	0	5	2026-04-09 00:00:00
5674	Dulce Gudupop Azul 1 pza	Paleta de caramelo suave	8	69	3.50	5.00	0	5	2026-04-09 00:00:00
5675	Gudu Cubos 1 pza	Caramelo suave de sabores	8	69	1.50	3.00	0	5	2026-04-09 00:00:00
5676	Milky Way Chocolate 48g	Barra de chocolate y caramelo	8	58	14.00	20.00	0	5	2026-04-09 00:00:00
5677	Snickers Chocolate 48g	Barra de chocolate, nuez y caramelo	8	58	14.00	20.00	0	5	2026-04-09 00:00:00
5678	M&Ms Chocolate 43g	Botones de chocolate con leche	8	58	14.00	20.00	0	5	2026-04-09 00:00:00
5679	M&Ms Cacahuate 43g	Botones de chocolate con cacahuate	8	58	14.00	20.00	0	5	2026-04-09 00:00:00
5680	Conejos Turin 20g	Chocolate con leche figura conejo	8	58	11.00	16.00	0	5	2026-04-09 00:00:00
5681	Bocadin Chocolate 1 pza	Galleta cubierta de chocolate	8	62	1.50	3.00	0	5	2026-04-09 00:00:00
5682	Mazapan de la Rosa Gigante 50g	Dulce de cacahuate grande	8	62	7.00	11.00	0	5	2026-04-09 00:00:00
5683	Pulparindo Extra Picante 14g	Dulce de tamarindo muy picante	8	62	3.50	5.00	0	5	2026-04-09 00:00:00
5684	Pulparindo Sandia 14g	Dulce de tamarindo sabor sandia	8	62	3.50	5.00	0	5	2026-04-09 00:00:00
5685	Lucas Gusano Chamoy 36g	Dulce liquido sabor chamoy	8	45	10.00	15.00	0	5	2026-04-09 00:00:00
5686	Lucas Bomvaso Limon 30g	Caramelo con polvo picante	8	45	10.50	15.00	0	5	2026-04-09 00:00:00
5687	Pica Fresa Gigante 1 pza	Gomita con chile sabor fresa	8	58	1.50	3.00	0	5	2026-04-09 00:00:00
5688	Pelon Pelo Rico Gigante 35g	Dulce de tamarindo grande	8	45	10.00	15.00	0	5	2026-04-09 00:00:00
5689	Skwinkles Clasicos Chamoy 26g	Tiras de dulce con chile	8	45	10.00	15.00	0	5	2026-04-09 00:00:00
5690	Kinder Chocolate 4 barras	Barritas de chocolate con leche	8	40	18.00	26.00	0	5	2026-04-09 00:00:00
5691	Halls Yerba Buena 9 pzas	Pastillas refrescantes yerbabuena	8	58	8.50	13.00	0	5	2026-04-09 00:00:00
5692	Halls Cereza 9 pzas	Pastillas refrescantes sabor cereza	8	58	8.50	13.00	0	5	2026-04-09 00:00:00
5693	Clorets 2 pastillas	Goma de mascar con clorofila	8	58	1.50	3.00	0	5	2026-04-09 00:00:00
5694	Shampoo Sedal Ceramidas 620ml	Shampoo para brillo y fuerza	35	34	42.00	58.00	0	5	2026-04-09 00:00:00
5695	Shampoo Sedal Restauracion 620ml	Shampoo para cabello danado	35	34	42.00	58.00	0	5	2026-04-09 00:00:00
5696	Shampoo Head & Shoulders Limpieza 375ml	Shampoo anticaspa original	35	58	55.00	75.00	0	5	2026-04-09 00:00:00
5697	Shampoo Head & Shoulders Mentol 375ml	Shampoo anticaspa mentolado	35	58	55.00	75.00	0	5	2026-04-09 00:00:00
5698	Shampoo Pantene Control Caida 400ml	Shampoo para evitar la caida	35	35	48.00	65.00	0	5	2026-04-09 00:00:00
5699	Acondicionador Pantene Restauracion 400ml	Acondicionador para cabello	35	35	48.00	65.00	0	5	2026-04-09 00:00:00
5700	Shampoo Savile Control Caspa 750ml	Shampoo con sabila y eucalipto	35	58	32.00	45.00	0	5	2026-04-09 00:00:00
5701	Shampoo Savile Chile 750ml	Shampoo con sabila y chile	35	58	32.00	45.00	0	5	2026-04-09 00:00:00
5702	Jabon Dove Original 135g	Barra de belleza humectante	41	36	22.00	30.00	0	5	2026-04-09 00:00:00
5703	Jabon Palmolive Oliva 150g	Jabon de tocador con oliva	41	31	13.00	18.00	0	5	2026-04-09 00:00:00
5704	Jabon Zest Limon 150g	Jabon de tocador refrescante	41	58	12.50	17.00	0	5	2026-04-09 00:00:00
5705	Jabon Rosa Venus 100g	Jabon de tocador clasico rosa	41	58	9.00	13.00	0	5	2026-04-09 00:00:00
5706	Desodorante Rexona Men Aerosol 150ml	Antitranspirante masculino spray	41	58	42.00	58.00	0	5	2026-04-09 00:00:00
5707	Desodorante Rexona Lady Aerosol 150ml	Antitranspirante femenino spray	41	58	42.00	58.00	0	5	2026-04-09 00:00:00
5708	Desodorante Axe Black Aerosol 150ml	Body spray para caballero	41	58	45.00	62.00	0	5	2026-04-09 00:00:00
5709	Desodorante Speed Stick 50g	Desodorante en barra caballero	41	58	30.00	42.00	0	5	2026-04-09 00:00:00
5710	Desodorante Lady Speed Stick 45g	Desodorante en barra dama	41	58	30.00	42.00	0	5	2026-04-09 00:00:00
5711	Rastrillo Gillette Prestobarba Azul 1 pza	Rastrillo desechable 2 hojas	41	58	14.00	20.00	0	5	2026-04-09 00:00:00
5712	Rastrillo Gillette Prestobarba 3 1 pza	Rastrillo desechable 3 hojas	41	58	22.00	30.00	0	5	2026-04-09 00:00:00
5713	Gel Ego Black 200ml	Gel fijador para caballero	41	58	18.00	25.00	0	5	2026-04-09 00:00:00
5714	Suavizante Downy Libre Enjuague 800ml	Suavizante de telas concentrado	32	58	25.00	35.00	0	5	2026-04-09 00:00:00
5715	Suavizante Ensueno Frescura 850ml	Suavizante de telas aroma fresco	32	58	18.00	25.00	0	5	2026-04-09 00:00:00
5716	Cloro Cloralex El Rendidor 2L	Blanqueador desinfectante 2 litros	35	58	26.00	35.00	0	5	2026-04-09 00:00:00
5717	Pinol Original 2L	Limpiador de pinol 2 litros	35	58	38.00	52.00	0	5	2026-04-09 00:00:00
5718	Fabuloso Mar Fresco 1L	Limpiador multiusos azul	35	30	22.00	30.00	0	5	2026-04-09 00:00:00
5719	Fabuloso Fresca Manana 1L	Limpiador multiusos verde	35	30	22.00	30.00	0	5	2026-04-09 00:00:00
5720	Lavatrastes Salvo Limon 750ml	Detergente liquido para platos	34	58	30.00	42.00	0	5	2026-04-09 00:00:00
5721	Lavatrastes Axion Pasta 400g	Jabon en pasta para platos	34	30	18.00	25.00	0	5	2026-04-09 00:00:00
5722	Detergente Ariel Liquido 800ml	Detergente liquido para ropa	34	58	35.00	48.00	0	5	2026-04-09 00:00:00
5723	Detergente Mas Color 830ml	Detergente para ropa de color	34	58	38.00	52.00	0	5	2026-04-09 00:00:00
5724	Frijoles Isadora Refritos Bayos 430g	Frijoles en bolsa listos para comer	6	58	14.00	20.00	0	5	2026-04-09 00:00:00
5725	Frijoles Isadora Refritos Negros 430g	Frijoles en bolsa listos para comer	6	58	14.00	20.00	0	5	2026-04-09 00:00:00
5726	Frijoles La Costena Refritos Bayos 400g	Frijoles refritos en lata	6	27	13.00	18.00	0	5	2026-04-09 00:00:00
5727	Frijoles La Costena Refritos Negros 400g	Frijoles refritos en lata	6	27	13.00	18.00	0	5	2026-04-09 00:00:00
5728	Chicharos Herdez 215g	Chicharos verdes en lata	6	20	11.00	15.00	0	5	2026-04-09 00:00:00
5729	Chicharos con Zanahoria Herdez 215g	Verduras picadas en lata	6	20	11.00	15.00	0	5	2026-04-09 00:00:00
6503	Emperador Senso	None	29	46	8.00	10.50	100	10	2026-04-15 00:00:00
5730	Ensalada de Verduras Herdez 215g	Verduras mixtas en lata	6	20	12.00	17.00	0	5	2026-04-09 00:00:00
5731	Champiñones Troceados Herdez 186g	Champinones en conserva	6	20	18.00	25.00	0	5	2026-04-09 00:00:00
5732	Salsa Herdez Verde 210g	Salsa verde de tomatillo	12	20	13.00	18.00	0	5	2026-04-09 00:00:00
5733	Salsa Herdez Casera 210g	Salsa roja con trozos	12	20	13.00	18.00	0	5	2026-04-09 00:00:00
5734	Salsa Valentina Negra 370ml	Salsa muy picante etiqueta negra	12	58	12.00	17.00	0	5	2026-04-09 00:00:00
5735	Salsa Botanera Clasica 370ml	Salsa picante para botanas	12	58	10.00	14.00	0	5	2026-04-09 00:00:00
5736	Salsa Maggi Sazonador 100ml	Sazonador para carnes y sopas	13	19	22.00	30.00	0	5	2026-04-09 00:00:00
5737	Salsa Inglesa Crosse & Blackwell 145ml	Salsa tipo inglesa	13	19	25.00	35.00	0	5	2026-04-09 00:00:00
5738	Sopa Nissin Cup Noodles Pollo 64g	Sopa instantanea en vaso Pollo	2	11	10.00	15.00	0	5	2026-04-09 00:00:00
5739	Sopa Nissin Cup Noodles Camaron 64g	Sopa instantanea en vaso Camaron	2	11	10.00	15.00	0	5	2026-04-09 00:00:00
5740	Sopa Maruchan Vaso Res 64g	Sopa instantanea en vaso Res	2	11	11.00	16.00	0	5	2026-04-09 00:00:00
5741	Sopa Maruchan Vaso Camaron Limon 64g	Sopa vaso Camaron Chile Limon	2	11	11.00	16.00	0	5	2026-04-09 00:00:00
5742	Pure de Tomate Del Fuerte 210g	Pure de tomate condimentado	12	58	7.00	10.00	0	5	2026-04-09 00:00:00
5743	Pure de Tomate La Costena 210g	Pure de tomate condimentado	12	27	7.00	10.00	0	5	2026-04-09 00:00:00
5744	Sopa Knorr Spaghetti con Queso	Sopa de pasta lista 10 min	2	58	12.00	17.00	0	5	2026-04-09 00:00:00
5745	Sopa Knorr Coditos con Crema	Sopa de pasta lista 10 min	2	58	12.00	17.00	0	5	2026-04-09 00:00:00
5746	Knorr Suiza Caldo Pollo 100g	Sazonador en polvo frasco	13	58	18.00	25.00	0	5	2026-04-09 00:00:00
5747	Knorr Tomate 8 cubos	Sazonador de tomate en cubos	13	58	12.50	18.00	0	5	2026-04-09 00:00:00
5748	Sal de Uvas Picot 1 sobre	Antiacido efervescente	50	58	4.00	7.00	0	5	2026-04-09 00:00:00
5749	Alka-Seltzer 2 tabletas	Antiacido y analgesico	50	58	6.00	10.00	0	5	2026-04-09 00:00:00
5750	Tortillinas Tia Rosa 10 pzas	Tortillas de harina medianas	27	17	18.00	25.00	0	5	2026-04-09 00:00:00
5751	Tortillinas Tia Rosa 22 pzas	Tortillas de harina paquete familiar	27	17	35.00	48.00	0	5	2026-04-09 00:00:00
5752	Cuernitos Tia Rosa 2 pzas	Pan de dulce forma cuernito	29	17	16.00	22.00	0	5	2026-04-09 00:00:00
5753	Banderillas Tia Rosa 4 pzas	Pan dulce tipo hojaldre	29	17	18.00	25.00	0	5	2026-04-09 00:00:00
5754	Doraditas Tia Rosa 4 pzas	Galletas de hojaldre azucaradas	29	17	18.00	25.00	0	5	2026-04-09 00:00:00
5755	Pan para Hot Dog Bimbo 8 pzas	Medias noches bimbo 8 pzas	27	17	28.00	38.00	0	5	2026-04-09 00:00:00
5756	Pan para Hamburguesa Bimbo 8 pzas	Bimbollos con ajonjoli 8 pzas	27	17	32.00	42.00	0	5	2026-04-09 00:00:00
5757	Tostadas Milpa Real 300g	Tostadas de maiz amarillas	5	17	22.00	30.00	0	5	2026-04-09 00:00:00
5758	Pan Tostado Bimbo Clasico 210g	Pan de caja tostado crujiente	27	17	25.00	35.00	0	5	2026-04-09 00:00:00
5759	Pan Tostado Bimbo Doble Fibra	Pan de caja tostado con fibra	27	17	28.00	38.00	0	5	2026-04-09 00:00:00
5760	Barritas Marinela Zarzamora 67g	Galletas rellenas zarzamora	29	22	12.00	16.00	0	5	2026-04-09 00:00:00
5761	Napolitano Marinela 70g	Pastelito sabor vainilla y choco	29	22	13.00	18.00	0	5	2026-04-09 00:00:00
5762	Submarinos Marinela Vainilla 3 pzas	Pastelitos rellenos crema	29	22	13.00	18.00	0	5	2026-04-09 00:00:00
5763	Submarinos Marinela Fresa 3 pzas	Pastelitos rellenos fresa	29	22	13.00	18.00	0	5	2026-04-09 00:00:00
5764	Canelitas Marinela 6 pzas	Galletas sabor canela paquete	29	22	11.00	15.00	0	5	2026-04-09 00:00:00
5765	Polvorones Marinela 6 pzas	Galletas sabor naranja paquete	29	22	11.00	15.00	0	5	2026-04-09 00:00:00
5766	Yogurt Danup Fresa 220g	Yogurt bebible con fresa	17	58	10.00	15.00	0	5	2026-04-09 00:00:00
5767	Yogurt Yoplait Fresa Bebible 242g	Yogurt bebible sabor fresa	17	58	10.50	15.00	0	5	2026-04-09 00:00:00
5768	Yogurt Yoplait Griego Natural 145g	Yogurt estilo griego natural	17	58	14.00	20.00	0	5	2026-04-09 00:00:00
5769	Yogurt Yoplait Disfruta Fresa 125g	Yogurt con trozos de fruta	17	58	8.50	12.00	0	5	2026-04-09 00:00:00
5770	Gelatina Dany Fresa 125g	Postre de gelatina sabor fresa	17	58	6.50	9.00	0	5	2026-04-09 00:00:00
5771	Gelatina Dany Limon 125g	Postre de gelatina sabor limon	17	58	6.50	9.00	0	5	2026-04-09 00:00:00
5772	Flan Danone vainilla 100g	Postre de flan con caramelo	17	58	9.00	13.00	0	5	2026-04-09 00:00:00
5773	Yakult 80ml	Producto lacteo fermentado	17	58	7.00	10.00	0	5	2026-04-09 00:00:00
5774	Jamon Americano de Pavo Kir 250g	Jamon de pavo economico	18	58	25.00	35.00	0	5	2026-04-09 00:00:00
5775	Jamon de Pavo y Cerdo Fud 290g	Jamon mixto rebanado	18	53	35.00	48.00	0	5	2026-04-09 00:00:00
5776	Salchicha Hot Dog Fud 500g	Salchicha larga para hot dog	18	53	38.00	52.00	0	5	2026-04-09 00:00:00
5777	Salchicha de Pavo Kir 500g	Salchicha de pavo economica	18	58	32.00	45.00	0	5	2026-04-09 00:00:00
5778	Queso Americano Nutrileche 140g	Producto lacteo estilo americano	16	4	16.00	22.00	0	5	2026-04-09 00:00:00
5779	Queso Americano Lala 144g	Queso americano rebanado	16	4	25.00	35.00	0	5	2026-04-09 00:00:00
5780	Chorizo Casero de Cerdo 200g	Chorizo de cerdo en empaque	18	58	18.00	26.00	0	5	2026-04-09 00:00:00
5781	Tocino Ahumado Kir 200g	Tocino de cerdo ahumado	18	58	35.00	48.00	0	5	2026-04-09 00:00:00
5782	Pate de Pollo Underwood 100g	Pate de pollo en lata	6	58	18.00	25.00	0	5	2026-04-09 00:00:00
5783	Alimento Perro Pedigree Adulto Sobre 100g	Comida humeda para perro Res	45	58	11.00	15.00	0	5	2026-04-09 00:00:00
5784	Alimento Perro Pedigree Cachorro Sobre 100g	Comida humeda para cachorro Pollo	45	58	11.00	15.00	0	5	2026-04-09 00:00:00
5785	Alimento Gato Whiskas Sobre 85g	Comida humeda para gato Atun	45	58	11.00	15.00	0	5	2026-04-09 00:00:00
5786	Alimento Gato Whiskas Sobre 85g Res	Comida humeda para gato Res	45	58	11.00	15.00	0	5	2026-04-09 00:00:00
5787	Ganador Adulto Sobre 100g	Comida humeda para perro Ganador	45	58	10.00	14.00	0	5	2026-04-09 00:00:00
5788	Dog Chow Adulto Sobre 100g	Comida humeda para perro Dog Chow	45	58	11.00	15.00	0	5	2026-04-09 00:00:00
5789	Pilas Duracell AA 2 pzas	Pilas alcalinas AA paquete	51	58	38.00	55.00	0	5	2026-04-09 00:00:00
5790	Pilas Duracell AAA 2 pzas	Pilas alcalinas AAA paquete	51	58	38.00	55.00	0	5	2026-04-09 00:00:00
5791	Pilas Energizer AA 2 pzas	Pilas alcalinas AA paquete	51	58	35.00	50.00	0	5	2026-04-09 00:00:00
5792	Pilas Volteck Economicas AA 4 pzas	Pilas de carbon zinc AA	51	58	15.00	25.00	0	5	2026-04-09 00:00:00
5793	Encendedor Bic Grande 1 pza	Encendedor de gas clasico	51	58	14.00	20.00	0	5	2026-04-09 00:00:00
5794	Encendedor Bic Mini 1 pza	Encendedor de gas pequeno	51	58	10.00	15.00	0	5	2026-04-09 00:00:00
5795	Cerillos La Central Clasicos	Caja de cerillos de madera	51	58	1.50	3.00	0	5	2026-04-09 00:00:00
5796	Cerillos La Central Cocina	Caja de cerillos grande cocina	51	58	8.00	12.00	0	5	2026-04-09 00:00:00
5797	Veladora Limonera Vaso	Veladora blanca en vaso vidrio	51	58	15.00	22.00	0	5	2026-04-09 00:00:00
5798	Fibra Scotch-Brite Verde 1 pza	Fibra para lavar platos	34	58	11.00	16.00	0	5	2026-04-09 00:00:00
5799	Fibra Scotch-Brite Cero Rayas 1 pza	Fibra delicada para teflon	34	58	13.00	18.00	0	5	2026-04-09 00:00:00
5800	Guantes de Limpieza Medianos	Guantes de latex amarillos	35	58	18.00	28.00	0	5	2026-04-09 00:00:00
5801	Bolsas para Basura Gde 10 pzas	Bolsas negras resistentes	35	58	22.00	32.00	0	5	2026-04-09 00:00:00
5802	Servilletas Petalo 100 pzas	Servilletas de papel blancas	43	29	12.00	18.00	0	5	2026-04-09 00:00:00
5803	Servilletas Regio 100 pzas	Servilletas de papel resistentes	43	29	14.00	20.00	0	5	2026-04-09 00:00:00
5804	Aluminio Reynolds 7 metros	Papel aluminio para cocina	51	58	18.00	25.00	0	5	2026-04-09 00:00:00
5805	Plastico Adherente Kleen-Pack 10m	Pelicula plastica para cocina	51	58	15.00	22.00	0	5	2026-04-09 00:00:00
5806	Vasos Desechables No. 8 20 pzas	Vasos de plastico blancos	51	58	15.00	22.00	0	5	2026-04-09 00:00:00
5807	Platos Desechables No. 9 20 pzas	Platos de plastico blancos	51	58	18.00	26.00	0	5	2026-04-09 00:00:00
5808	Tenedores Desechables 25 pzas	Tenedores de plastico blancos	51	58	12.00	18.00	0	5	2026-04-09 00:00:00
5809	Cafe Legal Soluble 180g	Cafe con azucar soluble	44	58	35.00	48.00	0	5	2026-04-09 00:00:00
5810	Cafe Oro Soluble 75g	Cafe soluble 100 por ciento puro	44	58	32.00	45.00	0	5	2026-04-09 00:00:00
5811	Te McCormick Manzanilla 25 sobres	Te de hierbas natural	44	58	18.00	25.00	0	5	2026-04-09 00:00:00
5812	Te McCormick Hierbabuena 25 sobres	Te de hierbas natural	44	58	18.00	25.00	0	5	2026-04-09 00:00:00
5813	Choco Milk Bolsa 160g	Modificador de leche chocolate	44	58	22.00	32.00	0	5	2026-04-09 00:00:00
5814	Cal-C-Tose Bolsa 160g	Modificador de leche chocolate	44	58	22.00	32.00	0	5	2026-04-09 00:00:00
5815	Jarabe Hershey Chocolate 589g	Jarabe dulce para postres	11	45	45.00	62.00	0	5	2026-04-09 00:00:00
5816	Mermelada McCormick Fresa 270g	Mermelada de fruta con trozos	11	58	22.00	30.00	0	5	2026-04-09 00:00:00
5817	Cajeta Coronado Quemada 370g	Dulce de leche de cabra	11	58	48.00	65.00	0	5	2026-04-09 00:00:00
5818	Miel Carlota Abeja 250g	Miel de abeja pura	11	19	45.00	60.00	0	5	2026-04-09 00:00:00
5819	Crema de Cacahuate Aladino 425g	Crema de cacahuate suave	11	58	48.00	65.00	0	5	2026-04-09 00:00:00
5820	Atun Herdez en Aceite 130g	Atun en hojuelas aceite	6	20	14.50	21.00	0	5	2026-04-09 00:00:00
5821	Atun Tuny en Agua 140g	Atun en hojuelas agua	6	58	15.00	22.00	0	5	2026-04-09 00:00:00
5822	Atun Tuny con Verduras 140g	Atun con ensalada de verduras	6	58	13.00	18.00	0	5	2026-04-09 00:00:00
5823	Sardinas en Tomate Pescador 425g	Sardinas en salsa de tomate	6	58	28.00	38.00	0	5	2026-04-09 00:00:00
5824	Vinagre Blanco La Costena 520ml	Vinagre de alcohol de cana	1	27	10.00	14.00	0	5	2026-04-09 00:00:00
5825	Vinagre de Manzana La Costena 520ml	Vinagre de sidra de manzana	1	27	12.00	17.00	0	5	2026-04-09 00:00:00
5826	Aceite Capullo 840ml	Aceite puro de canola	1	58	42.00	55.00	0	5	2026-04-09 00:00:00
5827	Aceite Ave 900ml	Aceite vegetal economico	1	58	32.00	42.00	0	5	2026-04-09 00:00:00
5828	Arroz Verde Valle Precotto 250g	Arroz precocido 5 min	2	58	14.00	20.00	0	5	2026-04-09 00:00:00
5829	Lentejas Verde Valle 500g	Lentejas secas de primera	2	58	22.00	30.00	0	5	2026-04-09 00:00:00
5830	Garbanzo Verde Valle 500g	Garbanzo seco de primera	2	58	24.00	32.00	0	5	2026-04-09 00:00:00
5831	Harina para Hot Cakes Gamesa 850g	Mezcla lista para hot cakes	10	46	32.00	45.00	0	5	2026-04-09 00:00:00
5832	Jarabe Pronto Maple 250ml	Jarabe sabor maple para hot cakes	11	58	22.00	30.00	0	5	2026-04-09 00:00:00
5833	Avena Quaker 3 Minutos 400g	Avena en hojuelas instantanea	5	25	24.00	32.00	0	5	2026-04-09 00:00:00
5834	Gel Ego For Men 500ml	Gel fijador extra firme grande	41	58	32.00	45.00	0	5	2026-04-09 00:00:00
5835	Toallas Femeninas Saba con Alas 10 pzas	Toallas femeninas flujo regular	41	58	22.00	32.00	0	5	2026-04-09 00:00:00
5836	Toallas Femeninas Kotex Nocturna 10 pzas	Toallas femeninas flujo abundante	41	58	25.00	35.00	0	5	2026-04-09 00:00:00
5837	Panales Huggies Etapa 3 10 pzas	Panales desechables medianos	41	58	45.00	65.00	0	5	2026-04-09 00:00:00
5838	Toallitas Humedas Huggies 80 pzas	Toallitas para bebe	41	58	35.00	50.00	0	5	2026-04-09 00:00:00
5839	Alcohol Etilico Jaloma 445ml	Alcohol para curaciones	50	58	22.00	32.00	0	5	2026-04-09 00:00:00
5840	Agua Oxigenada Jaloma 225ml	Auxiliar en curaciones	50	58	12.00	18.00	0	5	2026-04-09 00:00:00
5841	Algodon Jaloma 50g	Algodon plisado puro	50	58	12.00	18.00	0	5	2026-04-09 00:00:00
5842	Curitas Clasicas 10 pzas	Vendas adhesivas sanitarias	50	58	12.00	18.00	0	5	2026-04-09 00:00:00
5843	Jugo Boing Guayaba 250ml	Bebida de fruta de carton	31	58	7.50	10.00	0	5	2026-04-09 00:00:00
5844	Jugo Boing Mango 250ml	Bebida de fruta de carton	31	58	7.50	10.00	0	5	2026-04-09 00:00:00
5845	Jugo Boing Manzana 250ml	Bebida de fruta de carton	31	58	7.50	10.00	0	5	2026-04-09 00:00:00
5846	Jugo Boing Uva 250ml	Bebida de fruta de carton	31	58	7.50	10.00	0	5	2026-04-09 00:00:00
5847	Jugo Boing Fresa 250ml	Bebida de fruta de carton	31	58	7.50	10.00	0	5	2026-04-09 00:00:00
5848	Jugo Boing Mango 500ml	Bebida de fruta en vidrio/carton	31	58	12.00	16.00	0	5	2026-04-09 00:00:00
5849	Jugo Boing Guayaba 500ml	Bebida de fruta en vidrio/carton	31	58	12.00	16.00	0	5	2026-04-09 00:00:00
5850	Jugo Boing Mango 1L	Bebida de fruta 1 Litro	31	58	19.00	25.00	0	5	2026-04-09 00:00:00
5851	Jugo Boing Guayaba 1L	Bebida de fruta 1 Litro	31	58	19.00	25.00	0	5	2026-04-09 00:00:00
5852	Jumex Unico Fresco Naranja 1L	Jugo 100 por ciento sin azucar	31	21	26.00	35.00	0	5	2026-04-09 00:00:00
5853	Jumex Unico Fresco Verde 1L	Jugo de frutas y verduras	31	21	28.00	38.00	0	5	2026-04-09 00:00:00
5854	Jumex Fresh Citricos 600ml	Bebida refrescante de limon	31	21	11.00	15.00	0	5	2026-04-09 00:00:00
5855	Jumex Fresh Congo 600ml	Bebida de frutas tropicales	31	21	11.00	15.00	0	5	2026-04-09 00:00:00
5856	Pau Pau Fresa 250ml	Bebida infantil con vitaminas	31	21	5.50	8.00	0	5	2026-04-09 00:00:00
5857	Pau Pau Mango 250ml	Bebida infantil con vitaminas	31	21	5.50	8.00	0	5	2026-04-09 00:00:00
5858	Pau Pau Uva 250ml	Bebida infantil con vitaminas	31	21	5.50	8.00	0	5	2026-04-09 00:00:00
5859	Arizon Tea Ginseng 680ml	Te helado en lata grande	31	58	18.00	25.00	0	5	2026-04-09 00:00:00
5860	Arizon Tea Sandia 680ml	Bebida sabor sandia lata	31	58	18.00	25.00	0	5	2026-04-09 00:00:00
5861	V8 Jugo de Verduras 340ml	Jugo de vegetales en lata	31	58	16.00	22.00	0	5	2026-04-09 00:00:00
5862	BeLight Jamaica 1.5L	Bebida sin calorias jamaica	31	16	13.00	18.00	0	5	2026-04-09 00:00:00
5863	BeLight Limon 1.5L	Bebida sin calorias limon	31	16	13.00	18.00	0	5	2026-04-09 00:00:00
5864	Gatorade Ponche de Frutas 600ml	Bebida para deportistas	31	14	21.00	28.00	0	5	2026-04-09 00:00:00
5865	Gatorade Lima Limon 600ml	Bebida para deportistas	31	14	21.00	28.00	0	5	2026-04-09 00:00:00
5866	Gatorade Uva 600ml	Bebida para deportistas	31	14	21.00	28.00	0	5	2026-04-09 00:00:00
5867	Electrolit Coco 625ml	Suero rehidratante grado medico	31	58	22.00	30.00	0	5	2026-04-09 00:00:00
5868	Electrolit Fresa 625ml	Suero rehidratante grado medico	31	58	22.00	30.00	0	5	2026-04-09 00:00:00
5869	Electrolit Uva 625ml	Suero rehidratante grado medico	31	58	22.00	30.00	0	5	2026-04-09 00:00:00
5870	Choco Milk Lata 400g	Modificador de leche chocolate	44	58	55.00	75.00	0	5	2026-04-09 00:00:00
5871	Nesquik Fresa Polso 200g	Saborizante para leche fresa	44	19	24.00	32.00	0	5	2026-04-09 00:00:00
5872	Galletas Arcoiris Gamesa 6 pzas	Galleta con malvavisco y coco	9	46	12.00	17.00	0	5	2026-04-09 00:00:00
5873	Galletas Mamut Gigante 1 pza	Galleta con malvavisco grande	9	46	8.50	12.00	0	5	2026-04-09 00:00:00
5874	Galletas Vualá de Chocolate 60g	Pastelito relleno de chocolate	29	58	11.00	15.00	0	5	2026-04-09 00:00:00
5875	Galletas Vualá de Cajeta 60g	Pastelito relleno de cajeta	29	58	11.00	15.00	0	5	2026-04-09 00:00:00
5876	Galletas Emperador Combinado Tubo	Galletas chocolate y vainilla	9	46	13.50	19.00	0	5	2026-04-09 00:00:00
5877	Galletas Choquix Chocolate Tubo	Galletas con chispas Gamesa	9	46	13.50	19.00	0	5	2026-04-09 00:00:00
5878	Galletas Surtido Rico Gamesa 400g	Caja de galletas variadas	9	46	42.00	58.00	0	5	2026-04-09 00:00:00
5879	Obleas con Cajeta Las Sevillanas	Dulce de leche con oblea	8	58	12.00	18.00	0	5	2026-04-09 00:00:00
5880	Glorias de Linares 1 pza	Dulce de leche quemada con nuez	8	58	9.00	13.00	0	5	2026-04-09 00:00:00
5881	Bombones De La Rosa 100g	Nubes de malvavisco blancas	8	62	13.00	18.00	0	5	2026-04-09 00:00:00
5882	Gomitas Extreme Sour 50g	Gomitas acidas de colores	8	58	11.00	15.00	0	5	2026-04-09 00:00:00
5883	Cuaderno Scribe Profesional Raya	Libreta de 100 hojas raya	52	58	22.00	30.00	0	5	2026-04-09 00:00:00
5884	Cuaderno Scribe Profesional Cuadro	Libreta de 100 hojas cuadro	52	58	22.00	30.00	0	5	2026-04-09 00:00:00
5885	Lapiz Bic Evolution No. 2	Lapiz de grafito resistente	52	58	4.00	7.00	0	5	2026-04-09 00:00:00
5886	Pluma Bic Cristal Negra	Boligrafo tinta negra clasico	52	58	5.00	8.00	0	5	2026-04-09 00:00:00
5887	Pluma Bic Cristal Azul	Boligrafo tinta azul clasico	52	58	5.00	8.00	0	5	2026-04-09 00:00:00
5888	Pluma Bic Cristal Roja	Boligrafo tinta roja clasico	52	58	5.00	8.00	0	5	2026-04-09 00:00:00
5889	Goma Pelikan WS30	Goma de borrar migajon	52	58	4.00	7.00	0	5	2026-04-09 00:00:00
5890	Sacapuntas de Metal	Sacapuntas sencillo metalico	52	58	3.00	6.00	0	5	2026-04-09 00:00:00
5891	Pegamento Stick Pritt 10g	Pegamento en barra	52	58	15.00	22.00	0	5	2026-04-09 00:00:00
5892	Cinta Canela 40m	Cinta adhesiva de empaque	52	58	18.00	28.00	0	5	2026-04-09 00:00:00
5893	Cinta Transparente 40m	Cinta adhesiva transparente	52	58	18.00	28.00	0	5	2026-04-09 00:00:00
5894	Marcador para Pizarron Negro	Marcador magistral borrable	52	58	18.00	25.00	0	5	2026-04-09 00:00:00
5895	Marcador Permanente Sharpie Negro	Marcador de tinta indeleble	52	58	22.00	30.00	0	5	2026-04-09 00:00:00
5896	Corrector Liquido Tipo Pluma	Corrector de precision	52	58	18.00	25.00	0	5	2026-04-09 00:00:00
5897	Hojas Blancas paq. 50 pzas	Hojas de papel bond tamano carta	52	58	15.00	25.00	0	5	2026-04-09 00:00:00
5898	Cartulina Blanca 1 pza	Pliego de cartulina estandar	52	58	4.00	7.00	0	5	2026-04-09 00:00:00
5899	Papel China de Colores 1 pza	Papel seda varios colores	52	58	1.50	3.00	0	5	2026-04-09 00:00:00
5900	Sobre Amarillo Carta 1 pza	Sobre de papel manila	52	58	2.50	5.00	0	5	2026-04-09 00:00:00
5901	Folder Tamano Carta Crema	Folder de cartulina sencillo	52	58	2.50	5.00	0	5	2026-04-09 00:00:00
5902	Foco LED 9W Luz Blanca	Lampara ahorradora base E27	51	58	25.00	40.00	0	5	2026-04-09 00:00:00
5903	Foco LED 12W Luz Blanca	Lampara ahorradora potente	51	58	32.00	50.00	0	5	2026-04-09 00:00:00
5904	Extension Electrica 3m	Cable extension uso domestico	51	58	45.00	65.00	0	5	2026-04-09 00:00:00
5905	Multicontacto 3 entradas	Adaptador triple de corriente	51	58	15.00	25.00	0	5	2026-04-09 00:00:00
5906	Cinta de Aislar Negra	Cinta para cables electricos	51	58	12.00	20.00	0	5	2026-04-09 00:00:00
5907	Pila 9V Alcalina 1 pza	Batería cuadrada para equipos	51	58	65.00	85.00	0	5	2026-04-09 00:00:00
5908	Linterna de Mano Basica	Lampara de plastico recargable	51	58	45.00	75.00	0	5	2026-04-09 00:00:00
5909	Candado de Hierro 30mm	Candado con dos llaves	51	58	35.00	55.00	0	5	2026-04-09 00:00:00
5910	Pegamento Instantaneo 2g	Pegamento de contacto fuerte	52	58	10.00	18.00	0	5	2026-04-09 00:00:00
5911	Pegamento Blanco 125g	Resistol escolar blanco	52	58	15.00	22.00	0	5	2026-04-09 00:00:00
5912	Tafil No. 2 Clavos paq.	Clavos de acero para concreto	51	58	12.00	20.00	0	5	2026-04-09 00:00:00
5913	Martillo de Una 1 pza	Herramienta basica de carpinteria	51	58	65.00	95.00	0	5	2026-04-09 00:00:00
5914	Desarmador de Cruz y Plano	Herramienta doble punta	51	58	25.00	45.00	0	5	2026-04-09 00:00:00
5915	Aspirina 500mg 10 tabletas	Analgesico acido acetilsalicilico	50	58	22.00	35.00	0	5	2026-04-09 00:00:00
5916	Tabcin Noche 12 capsulas	Auxiliar en sintomas de gripe	50	58	45.00	65.00	0	5	2026-04-09 00:00:00
5917	Tabcin Dia 12 capsulas	Auxiliar en sintomas de gripe	50	58	45.00	65.00	0	5	2026-04-09 00:00:00
5918	Tempra Adulto 500mg 10 tabs	Analgesico paracetamol	50	58	25.00	40.00	0	5	2026-04-09 00:00:00
5919	Tempra Infantil Jarabe 120ml	Paracetamol infantil	50	58	55.00	75.00	0	5	2026-04-09 00:00:00
5920	Flanax 550mg 12 tabletas	Antiinflamatorio y analgesico	50	58	65.00	95.00	0	5	2026-04-09 00:00:00
5921	Vick VapoRub 50g	Unguento para congestion nasal	50	58	48.00	68.00	0	5	2026-04-09 00:00:00
5922	Vick Vaporub 12g	Unguento pequeno presentacion sobre	50	58	12.00	20.00	0	5	2026-04-09 00:00:00
5923	Pepto-Bismol Suspensión 118ml	Auxiliar en malestar estomacal	50	58	55.00	78.00	0	5	2026-04-09 00:00:00
5924	Pepto-Bismol 12 tabletas	Auxiliar en malestar estomacal	50	58	42.00	58.00	0	5	2026-04-09 00:00:00
5925	Tums Surtido de Frutas 12 tabs	Antiacido masticable	50	58	25.00	38.00	0	5	2026-04-09 00:00:00
5926	XL-3 Gripa 12 tabletas	Auxiliar en resfriado comun	50	58	32.00	48.00	0	5	2026-04-09 00:00:00
5927	Metamucil Polvo Naranja 10 sobres	Suplemento de fibra natural	50	58	55.00	75.00	0	5	2026-04-09 00:00:00
5928	Condones Sico Original 3 pzas	Metodo anticonceptivo	50	58	38.00	55.00	0	5	2026-04-09 00:00:00
5929	Condones Trojan 3 pzas	Metodo anticonceptivo	50	58	42.00	60.00	0	5	2026-04-09 00:00:00
5930	Prueba de Embarazo Casera	Dispositivo de diagnostico	50	58	45.00	75.00	0	5	2026-04-09 00:00:00
5931	Gel Antibacterial 250ml	Desinfectante de manos alcohol	50	58	18.00	28.00	0	5	2026-04-09 00:00:00
5932	Cubrebocas Azul 10 pzas	Mascarilla protectora desechable	50	58	10.00	20.00	0	5	2026-04-09 00:00:00
5933	Algodon Absorbente 100g	Paquete de algodon de primera	50	58	18.00	28.00	0	5	2026-04-09 00:00:00
5934	Gasa Esteril 10x10cm	Compresa de gasa individual	50	58	4.00	8.00	0	5	2026-04-09 00:00:00
5935	Micropore Cinta Medica	Cinta adhesiva para curacion	50	58	15.00	25.00	0	5	2026-04-09 00:00:00
5936	Pomada de la Campana 35g	Crema protectora para la piel	41	58	22.00	32.00	0	5	2026-04-09 00:00:00
5937	Vaselina Pura 60g	Unguento humectante de vaselina	41	58	22.00	32.00	0	5	2026-04-09 00:00:00
5938	Crema Nivea Tarro Azul 60ml	Crema humectante clasica	41	58	28.00	42.00	0	5	2026-04-09 00:00:00
5939	Crema Lubriderm Tapa Azul 120ml	Crema humectante diaria	41	58	45.00	65.00	0	5	2026-04-09 00:00:00
5940	Talco para Pies Mexsana 80g	Talco desodorante para pies	41	58	35.00	50.00	0	5	2026-04-09 00:00:00
5941	Toallitas Desmaquillantes Pond's	Toallitas limpiadoras faciales	41	58	35.00	55.00	0	5	2026-04-09 00:00:00
5942	Sazonador Pimienta Negra 50g	Pimienta negra molida McCormick	13	72	18.00	25.00	0	5	2026-04-09 00:00:00
5943	Ajo en Polvo McCormick 50g	Sazonador ajo puro molido	13	72	18.00	25.00	0	5	2026-04-09 00:00:00
5944	Canela Entera 20g	Rajas de canela natural	13	58	12.00	18.00	0	5	2026-04-09 00:00:00
5945	Canela Molida 50g	Canela en polvo para postres	13	58	15.00	22.00	0	5	2026-04-09 00:00:00
5946	Vainilla Molina 250ml	Extracto de vainilla liquido	13	58	18.00	26.00	0	5	2026-04-09 00:00:00
5947	Polvo para Hornear Royal 100g	Levadura quimica para pan	10	58	18.00	25.00	0	5	2026-04-09 00:00:00
5948	Grenetina en Polvo 4 sobres	Grenetina natural sin sabor	10	58	15.00	22.00	0	5	2026-04-09 00:00:00
5949	Colorante Vegetal Rojo	Colorante para alimentos liquido	10	58	10.00	15.00	0	5	2026-04-09 00:00:00
5950	Chile Guajillo Bolsa 50g	Chile seco seleccionado	13	58	15.00	22.00	0	5	2026-04-09 00:00:00
5951	Chile Ancho Bolsa 50g	Chile seco seleccionado	13	58	18.00	25.00	0	5	2026-04-09 00:00:00
5952	Chile de Arbol Bolsa 50g	Chile seco muy picante	13	58	15.00	22.00	0	5	2026-04-09 00:00:00
5953	Oregano Seco Bolsa 20g	Hierba de olor para cocina	13	58	8.00	12.00	0	5	2026-04-09 00:00:00
5954	Comino Molido Bolsa 50g	Especias para sazonar	13	58	12.00	18.00	0	5	2026-04-09 00:00:00
5955	Laurel Hojas Bolsa 20g	Hierba de olor para guisos	13	58	8.00	12.00	0	5	2026-04-09 00:00:00
5956	Bicarbonato de Sodio 100g	Uso domestico y culinario	13	58	10.00	15.00	0	5	2026-04-09 00:00:00
5957	Miel de Agave 250ml	Endulzante natural de agave	11	58	45.00	65.00	0	5	2026-04-09 00:00:00
5958	Splenda 50 sobres	Endulzante sin calorias	3	58	35.00	48.00	0	5	2026-04-09 00:00:00
5959	Stevia 50 sobres	Endulzante natural sin calorias	3	58	38.00	52.00	0	5	2026-04-09 00:00:00
5960	Sopa de Letras La Moderna 200g	Pasta de sémola de trigo	2	44	7.50	11.00	0	5	2026-04-09 00:00:00
5961	Sopa de Estrellas La Moderna 200g	Pasta de sémola de trigo	2	44	7.50	11.00	0	5	2026-04-09 00:00:00
5962	Sopa de Municion La Moderna 200g	Pasta de sémola de trigo	2	44	7.50	11.00	0	5	2026-04-09 00:00:00
5963	Macarrones La Moderna 200g	Pasta de sémola de trigo	2	44	7.50	11.00	0	5	2026-04-09 00:00:00
5964	Aceitunas con Hueso La Costena	Aceitunas verdes en frasco	6	27	18.00	26.00	0	5	2026-04-09 00:00:00
5965	Aceitunas Rellenas La Costena	Aceitunas con pimiento	6	27	22.00	30.00	0	5	2026-04-09 00:00:00
5966	Alcaparras en Salmuera 100g	Botella de alcaparras	6	58	25.00	35.00	0	5	2026-04-09 00:00:00
5967	Pimiento Morron en Lata	Pimiento rojo en tiras	6	58	22.00	30.00	0	5	2026-04-09 00:00:00
5968	Mole Poblano Doña Maria 235g	Pasta para mole en vaso	12	20	32.00	45.00	0	5	2026-04-09 00:00:00
5969	Mole Verde Doña Maria 235g	Pasta para mole verde en vaso	12	20	35.00	48.00	0	5	2026-04-09 00:00:00
5970	Salsa para Pasta Prego Tradicional	Salsa de tomate para spaghetti	12	58	35.00	48.00	0	5	2026-04-09 00:00:00
5971	Salsa para Pasta Prego Champiñones	Salsa de tomate con hongos	12	58	38.00	52.00	0	5	2026-04-09 00:00:00
5972	Pechuga de Pavo Zwan 250g	Embutido de pavo premium	18	58	45.00	60.00	0	5	2026-04-09 00:00:00
5973	Jamon Serrano Paquete 100g	Jamon curado rebanado	18	58	65.00	95.00	0	5	2026-04-09 00:00:00
5974	Salchicha de Pavo Oscar Mayer	Salchichas de pavo calidad	18	58	38.00	55.00	0	5	2026-04-09 00:00:00
5975	Chorizo de Bilbao 200g	Chorizo tipo español	18	58	45.00	65.00	0	5	2026-04-09 00:00:00
5976	Queso Gouda Rebanado Nochebuena	Queso tipo gouda paquete	16	58	48.00	65.00	0	5	2026-04-09 00:00:00
5977	Queso Manchego Rebanado Nochebuena	Queso tipo manchego paquete	16	58	48.00	65.00	0	5	2026-04-09 00:00:00
5978	Queso Oaxaca La Villita 200g	Queso de hebra para fundir	16	58	42.00	58.00	0	5	2026-04-09 00:00:00
5979	Queso Cotija en Polvo 100g	Queso seco rallado	16	58	22.00	30.00	0	5	2026-04-09 00:00:00
5980	Yogurt Vitalímea Fresa 220g	Yogurt bajo en calorias	17	58	12.00	17.00	0	5	2026-04-09 00:00:00
5981	Yogurt Vitalímea Natural 220g	Yogurt bajo en calorias	17	58	12.00	17.00	0	5	2026-04-09 00:00:00
5982	Chambourcy Manzana 100g	Postre de manzana cocida	17	19	9.00	13.00	0	5	2026-04-09 00:00:00
5983	Arroz con Leche Lala 125g	Postre listo para comer	17	4	10.00	15.00	0	5	2026-04-09 00:00:00
5984	Limonada Peñafiel 600ml	Bebida mineral con limon	31	58	13.00	18.00	0	5	2026-04-09 00:00:00
5985	Naranjada Peñafiel 600ml	Bebida mineral con naranja	31	58	13.00	18.00	0	5	2026-04-09 00:00:00
5986	Agua Mineral Perrier 330ml	Agua mineral de manantial francesa	31	19	22.00	35.00	0	5	2026-04-09 00:00:00
5987	Agua Mineral San Pellegrino 330ml	Agua mineral italiana lata	31	19	22.00	35.00	0	5	2026-04-09 00:00:00
5988	Vino Tinto Las Moras 750ml	Vino de mesa Malbec	33	58	110.00	165.00	0	5	2026-04-09 00:00:00
5989	Vino Blanco Concha y Toro 750ml	Vino de mesa Sauvignon	33	58	95.00	145.00	0	5	2026-04-09 00:00:00
5990	Whisky Johnnie Walker Red Label 700ml	Whisky escoces mezclado	33	58	320.00	450.00	0	5	2026-04-09 00:00:00
5991	Tequila Jose Cuervo Especial 990ml	Tequila joven reposado	33	58	280.00	395.00	0	5	2026-04-09 00:00:00
5992	Mezcal 400 Conejos 750ml	Mezcal artesanal joven	33	58	420.00	580.00	0	5	2026-04-09 00:00:00
5993	Cerveza Corona Extra 355ml	Cerveza clara botella	32	58	18.00	24.00	0	5	2026-04-09 00:00:00
5994	Cerveza Victoria 355ml	Cerveza tipo lager oscura	32	58	18.00	24.00	0	5	2026-04-09 00:00:00
5995	Cerveza Modelo Especial Lata 355ml	Cerveza clara en lata	32	58	19.00	26.00	0	5	2026-04-09 00:00:00
5996	Cerveza Michelob Ultra 355ml	Cerveza baja en calorias	32	58	21.00	28.00	0	5	2026-04-09 00:00:00
5997	Cerveza Heineken 355ml	Cerveza clara premium	32	58	22.00	30.00	0	5	2026-04-09 00:00:00
5998	Cerveza Dos Equis Lager 355ml	Cerveza clara suave	32	58	19.00	26.00	0	5	2026-04-09 00:00:00
5999	Clamato Original 473ml	Jugo de tomate con almeja	31	58	22.00	32.00	0	5	2026-04-09 00:00:00
6000	Hielo en Cubos Bolsa 5kg	Hielo purificado para bebidas	30	58	22.00	35.00	0	5	2026-04-09 00:00:00
6001	Vasos Rojos Fiesteros 20 pzas	Vasos de plastico grandes rojos	51	58	28.00	42.00	0	5	2026-04-09 00:00:00
6002	Carbon de Leña Bolsa 3kg	Carbon vegetal para asados	51	58	45.00	65.00	0	5	2026-04-09 00:00:00
6003	Encendedor de Antorcha Cocina	Encendedor largo para estufa	51	58	28.00	45.00	0	5	2026-04-09 00:00:00
6004	Pastillas de Encendido 12 pzas	Auxiliar para prender carbon	51	58	15.00	25.00	0	5	2026-04-09 00:00:00
6005	Insecticida Raid Casa y Jardin	Spray contra insectos voladores	35	58	55.00	78.00	0	5	2026-04-09 00:00:00
6006	Insecticida Baygon Rastreros	Spray contra cucarachas y hormigas	35	58	55.00	78.00	0	5	2026-04-09 00:00:00
6007	Laminas Raid Repuesto 12 pzas	Laminas para aparato electrico	35	58	28.00	42.00	0	5	2026-04-09 00:00:00
6008	Aparato Raid Electrico Liquido	Repelente de mosquitos electrico	35	58	55.00	85.00	0	5	2026-04-09 00:00:00
6009	Windex Limpiador Vidrios 500ml	Liquido para limpiar cristales	35	58	32.00	45.00	0	5	2026-04-09 00:00:00
6010	Easy-Off Limpiador de Hornos	Quita grasa para estufas	35	58	55.00	85.00	0	5	2026-04-09 00:00:00
6011	Harpic Baños Destapa Caños	Liquido para tuberias obstruidas	35	58	45.00	68.00	0	5	2026-04-09 00:00:00
6012	Pledge Lustrador de Muebles	Spray para madera y superficies	35	58	55.00	78.00	0	5	2026-04-09 00:00:00
6013	Glade Aerosol Lavanda 400ml	Aromatizante de ambiente	35	58	28.00	42.00	0	5	2026-04-09 00:00:00
6014	Air Wick Repuesto Electrico	Aromatizante continuo	35	58	55.00	85.00	0	5	2026-04-09 00:00:00
6015	Veladora de Vaso Imagen	Veladora con imagen religiosa	51	58	18.00	28.00	0	5	2026-04-09 00:00:00
6016	Incienso de Varilla paq. 10 pzas	Varillas aromaticas surtidas	51	58	12.00	20.00	0	5	2026-04-09 00:00:00
6017	Comida para Perro Dog Chow 2kg	Croquetas adulto perro mediano	45	58	145.00	195.00	0	5	2026-04-09 00:00:00
6018	Comida para Gato Whiskas 1.5kg	Croquetas sabor carne y leche	45	58	120.00	175.00	0	5	2026-04-09 00:00:00
6019	Arena para Gato Scoop Away 3kg	Arena aglutinante para desechos	45	58	85.00	125.00	0	5	2026-04-09 00:00:00
6020	Hueso de Carnaza para Perro Gde	Juguete masticable para perro	45	58	22.00	35.00	0	5	2026-04-09 00:00:00
6021	Shampoo para Perros Grisi 400ml	Shampoo antipulgas con avena	45	58	55.00	85.00	0	5	2026-04-09 00:00:00
6022	Escoba de Mijo Clasica	Escoba de fibras naturales	35	58	45.00	65.00	0	5	2026-04-09 00:00:00
6023	Trapeador de Algodon Blanco	Mopa de hilos de algodon	35	58	35.00	55.00	0	5	2026-04-09 00:00:00
6024	Cubeta de Plastico 10L	Cubeta reforzada varios colores	35	58	35.00	55.00	0	5	2026-04-09 00:00:00
6025	Recogedor de Plastico con Mango	Recogedor de basura sencillo	35	58	25.00	45.00	0	5	2026-04-09 00:00:00
6026	Gancho para Ropa Plastico 6 pzas	Ganchos negros o blancos	51	58	25.00	40.00	0	5	2026-04-09 00:00:00
6027	Pinzas para Ropa Madera 12 pzas	Tendedero de madera clasico	51	58	15.00	25.00	0	5	2026-04-09 00:00:00
6028	Bolsas para Basura Chicas 20 pzas	Bolsas para baño cocina	35	58	18.00	28.00	0	5	2026-04-09 00:00:00
6029	Fibras de Acero Inox 2 pzas	Fibra metalica para ollas	34	58	12.00	20.00	0	5	2026-04-09 00:00:00
6030	Guantes de Latex Negros Uso Rudo	Guantes de limpieza fuertes	35	58	25.00	42.00	0	5	2026-04-09 00:00:00
6031	Mascarilla para Cabello Pantene	Tratamiento intensivo capilar	35	35	12.00	20.00	0	5	2026-04-09 00:00:00
6032	Cepillo Dental Oral-B Indicator	Cepillo dental cerdas medias	38	30	18.00	28.00	0	5	2026-04-09 00:00:00
6033	Enjuague Bucal Listerine 250ml	Antiseptico bucal original	38	30	38.00	55.00	0	5	2026-04-09 00:00:00
6034	Hilo Dental Oral-B 25m	Limpieza interdental	38	30	28.00	42.00	0	5	2026-04-09 00:00:00
6035	Corega Crema Adhesiva 40g	Adhesivo para dentaduras	38	30	85.00	125.00	0	5	2026-04-09 00:00:00
6036	Pastillas Efervescentes Corega	Limpieza de dentaduras	38	30	45.00	65.00	0	5	2026-04-09 00:00:00
6037	Desodorante Gillette Gel 82g	Antitranspirante masculino gel	41	58	55.00	78.00	0	5	2026-04-09 00:00:00
6038	Crema de Afeitar Gillette 200g	Espuma para afeitado suave	41	58	45.00	68.00	0	5	2026-04-09 00:00:00
6039	Locion After Shave Gillette	Locion para despues de afeitar	41	58	65.00	95.00	0	5	2026-04-09 00:00:00
6040	Cera para Cabello Axe 50g	Cera moldeadora mate	41	58	55.00	85.00	0	5	2026-04-09 00:00:00
6041	Esmalte de Uñas Bissú	Barniz de uñas varios colores	41	58	12.00	20.00	0	5	2026-04-09 00:00:00
6042	Acetona Pura 120ml	Removedor de esmalte de uñas	41	58	18.00	28.00	0	5	2026-04-09 00:00:00
6043	Pañales Huggies UltraConfort E4 40pza	Pañales para etapa 4 niño/niña	44	29	210.00	285.00	0	5	2026-04-09 00:00:00
6044	Pañales Huggies UltraConfort E5 40pza	Pañales para etapa 5 niño/niña	44	29	225.00	305.00	0	5	2026-04-09 00:00:00
6045	Pañales KleenBebé Suavelastic G 38pza	Pañales etapa grande	44	29	185.00	250.00	0	5	2026-04-09 00:00:00
6046	Toallitas KleenBebé Absorsec 80pza	Toallitas humedas para bebe	44	29	28.00	42.00	0	5	2026-04-09 00:00:00
6047	Biberón Evenflo 8oz	Biberon de plastico decorado	44	58	35.00	55.00	0	5	2026-04-09 00:00:00
6048	Chupón Entrenador Nuk	Chupon de silicona etapa 1	44	58	45.00	70.00	0	5	2026-04-09 00:00:00
6049	Aceite para Bebé Mennen 200ml	Aceite humectante suavidad	44	58	42.00	60.00	0	5	2026-04-09 00:00:00
6050	Talco para Bebé Mennen 200g	Talco proteccion y frescura	44	58	38.00	55.00	0	5	2026-04-09 00:00:00
6051	Jabón Ricitos de Oro 90g	Jabon de tocador manzanilla	44	58	14.00	22.00	0	5	2026-04-09 00:00:00
6052	Shampoo Ricitos de Oro 250ml	Shampoo de manzanilla no lagrimas	44	58	45.00	65.00	0	5	2026-04-09 00:00:00
6053	Papel Higiénico Regio Luxury 4 rollos	Papel higienico hoja doble	36	29	28.00	42.00	0	5	2026-04-09 00:00:00
6054	Papel Higiénico Cottonelle Soft 4 rollos	Papel higienico premium	36	29	32.00	48.00	0	5	2026-04-09 00:00:00
6055	Papel Higiénico Pétalo 12 rollos	Paquete economico de papel	36	29	65.00	95.00	0	5	2026-04-09 00:00:00
6056	Papel Higiénico Suavel 4 rollos	Papel higienico economico	36	29	18.00	28.00	0	5	2026-04-09 00:00:00
6057	Servitoalla Pétalo 1 rollo	Toalla de papel para cocina	36	29	14.00	22.00	0	5	2026-04-09 00:00:00
6058	Pañuelos Kleenex Caja 90pza	Pañuelos desechables suaves	36	29	22.00	35.00	0	5	2026-04-09 00:00:00
6059	Pañuelos Kleenex Pocket 1pza	Paquete individual de bolsillo	36	29	5.00	8.00	0	5	2026-04-09 00:00:00
6060	Velas para Pastel de Colores	Velas de cera para cumpleaños	45	58	8.00	15.00	0	5	2026-04-09 00:00:00
6061	Globos del No. 9 20pza	Globos de latex colores surtidos	45	58	22.00	38.00	0	5	2026-04-09 00:00:00
6062	Confeti Bolsa 100g	Papel picado de colores	45	58	10.00	18.00	0	5	2026-04-09 00:00:00
6063	Gorro de Fiesta 10pza	Gorros de carton para fiesta	45	58	25.00	45.00	0	5	2026-04-09 00:00:00
6064	Serpentina Paquete 10pza	Tiras de papel para festejo	45	58	15.00	28.00	0	5	2026-04-09 00:00:00
6065	Desechable Charola Térmica No. 66	Charola de unicel para comida	45	58	28.00	45.00	0	5	2026-04-09 00:00:00
6066	Desechable Vaso Térmico No. 8 20pza	Vasos de unicel para bebidas calientes	45	58	18.00	32.00	0	5	2026-04-09 00:00:00
6067	Piñata de Estrella Mediana	Piñata tradicional de carton	45	58	85.00	135.00	0	5	2026-04-09 00:00:00
6068	Palo para Piñata Decorado	Madera forrada de colores	45	58	12.00	25.00	0	5	2026-04-09 00:00:00
6069	Cereal Zucaritas Kelloggs 710g	Cereal de maiz escarchado	5	26	65.00	88.00	0	5	2026-04-09 00:00:00
6070	Cereal Choco Krispis 620g	Arroz inflado sabor chocolate	5	26	68.00	92.00	0	5	2026-04-09 00:00:00
6071	Cereal Froot Loops 410g	Aros de maiz sabor frutas	5	26	55.00	78.00	0	5	2026-04-09 00:00:00
6072	Cereal Corn Flakes 500g	Hojuelas de maiz naturales	5	26	48.00	65.00	0	5	2026-04-09 00:00:00
6073	Cereal Nesquik 330g	Cereal de trigo sabor chocolate	5	19	45.00	62.00	0	5	2026-04-09 00:00:00
6074	Cereal Cheerios Miel 480g	Aros de avena y miel	5	19	58.00	78.00	0	5	2026-04-09 00:00:00
6075	Cereal Fitness Original 375g	Hojuelas de trigo integral	5	19	55.00	75.00	0	5	2026-04-09 00:00:00
6076	Cereal Special K Original 400g	Cereal de trigo y arroz	5	26	62.00	85.00	0	5	2026-04-09 00:00:00
6077	Barra Nature Valley Avena 42g	Barra de granola y miel	5	58	11.00	16.00	0	5	2026-04-09 00:00:00
6078	Barra Bran Frut Fresa 48g	Barra de trigo rellena	5	17	10.00	15.00	0	5	2026-04-09 00:00:00
6079	Avena Quaker Instantánea 10 sobres	Avena de sabores en sobre	5	25	42.00	58.00	0	5	2026-04-09 00:00:00
6080	Canela en Raja 50g	Raja de canela seleccionada	13	58	22.00	35.00	0	5	2026-04-09 00:00:00
6081	Clavo de Olor 20g	Especias para cocina	13	58	15.00	25.00	0	5	2026-04-09 00:00:00
6082	Pimienta Gorda 50g	Pimienta entera McCormick	13	58	18.00	28.00	0	5	2026-04-09 00:00:00
6083	Comino Entero 50g	Semillas de comino natural	13	58	12.00	22.00	0	5	2026-04-09 00:00:00
6084	Tomillo Seco 20g	Hierba de olor para guisos	13	58	10.00	18.00	0	5	2026-04-09 00:00:00
6085	Mejorana Seca 20g	Hierba de olor para cocina	13	58	10.00	18.00	0	5	2026-04-09 00:00:00
6086	Sazonador para Pollo 100g	Mezcla de especias para aves	13	58	18.00	28.00	0	5	2026-04-09 00:00:00
6087	Sazonador Ablandador de Carne	Sal con papaína para carnes	13	58	22.00	32.00	0	5	2026-04-09 00:00:00
6088	Sal con Ajo McCormick 100g	Sal de mesa condimentada	13	58	18.00	28.00	0	5	2026-04-09 00:00:00
6089	Sal con Cebolla McCormick 100g	Sal de mesa condimentada	13	58	18.00	28.00	0	5	2026-04-09 00:00:00
6090	Chile Piquín en Polvo 100g	Chile seco molido picante	13	58	15.00	25.00	0	5	2026-04-09 00:00:00
6091	Nuez Moscada Molida 20g	Especias para repostería	13	58	18.00	28.00	0	5	2026-04-09 00:00:00
6092	Anís Estrella 20g	Para infusiones y repostería	13	58	25.00	40.00	0	5	2026-04-09 00:00:00
6093	Mostaza McCormick 210g	Mostaza amarilla clasica	12	20	14.00	21.00	0	5	2026-04-09 00:00:00
6094	Mayonesa McCormick con Limón 190g	Mayonesa en frasco vidrio	12	20	22.00	32.00	0	5	2026-04-09 00:00:00
6095	Mayonesa McCormick con Limón 390g	Mayonesa en frasco vidrio mediana	12	20	45.00	62.00	0	5	2026-04-09 00:00:00
6096	Mayonesa Hellmann's Clasica 390g	Mayonesa suave y cremosa	12	58	42.00	58.00	0	5	2026-04-09 00:00:00
6097	Catsup Del Monte 320g	Salsa de tomate catsup doy pack	12	70	15.00	22.00	0	5	2026-04-09 00:00:00
6098	Catsup Heinz 397g	Salsa de tomate catsup botella	12	71	25.00	35.00	0	5	2026-04-09 00:00:00
6099	Salsa BBQ Hunts 620g	Salsa para alitas o costillas	12	58	48.00	65.00	0	5	2026-04-09 00:00:00
6100	Salsa para Pizza Ragú 400g	Salsa de tomate condimentada	12	58	35.00	48.00	0	5	2026-04-09 00:00:00
6101	Salsa Macha con Arándano 200g	Salsa artesanal aceite y chile	12	58	45.00	65.00	0	5	2026-04-09 00:00:00
6102	Salsa Casera La Morena 210g	Salsa roja picante	12	72	13.00	18.00	0	5	2026-04-09 00:00:00
6103	Pasta para Sopa La Moderna Codo 0	Pasta de trigo pequeña	2	44	7.50	11.00	0	5	2026-04-09 00:00:00
6104	Pasta para Sopa La Moderna Fideo 0	Pasta de trigo para sopa	2	44	7.50	11.00	0	5	2026-04-09 00:00:00
6105	Pasta Spaghetti La Moderna 200g	Pasta larga de sémola	2	44	8.50	12.00	0	5	2026-04-09 00:00:00
6106	Pasta Fetuccini Barilla 500g	Pasta italiana premium	2	56	25.00	35.00	0	5	2026-04-09 00:00:00
6107	Pasta Penne Rigate Barilla 500g	Pasta corta tipo pluma	2	56	25.00	35.00	0	5	2026-04-09 00:00:00
6108	Lenteja Canada Bolsa 500g	Legumbre seca seleccionada	2	58	22.00	30.00	0	5	2026-04-09 00:00:00
6109	Frijol Negro Querétaro 1kg	Frijol seco de primera calidad	2	58	35.00	48.00	0	5	2026-04-09 00:00:00
6110	Frijol Flor de Mayo 1kg	Frijol seco suave	2	58	38.00	52.00	0	5	2026-04-09 00:00:00
6111	Frijol Bayo 1kg	Frijol seco tradicional	2	58	34.00	45.00	0	5	2026-04-09 00:00:00
6112	Haba Entera Pelada 500g	Legumbre seca para sopa	2	58	28.00	42.00	0	5	2026-04-09 00:00:00
6113	Garbanzo Extra 500g	Legumbre seca grande	2	58	24.00	35.00	0	5	2026-04-09 00:00:00
6114	Maíz Palomero 500g	Maiz para palomitas granel	2	58	15.00	25.00	0	5	2026-04-09 00:00:00
6115	Arroz Integral Verde Valle 900g	Arroz con fibra natural	2	58	32.00	45.00	0	5	2026-04-09 00:00:00
6116	Aceite de Oliva Extra Virgen 250ml	Aceite de primera prensada	1	58	65.00	95.00	0	5	2026-04-09 00:00:00
6117	Aceite en Aerosol PAM 170g	Aceite vegetal para cocinar	1	58	55.00	78.00	0	5	2026-04-09 00:00:00
6118	Vinagre Tinto La Costeña 530ml	Vinagre para ensaladas	1	27	14.00	22.00	0	5	2026-04-09 00:00:00
6119	Manteca de Cerdo 500g	Grasa animal para cocina	1	58	28.00	42.00	0	5	2026-04-09 00:00:00
6120	Harina de Trigo San Antonio 1kg	Harina de trigo refinada	3	41	18.00	26.00	0	5	2026-04-09 00:00:00
6121	Harina de Maíz Maseca 1kg	Harina para tortillas de maiz	3	59	19.00	27.00	0	5	2026-04-09 00:00:00
6122	Harina para Hot Cakes Pronto 800g	Mezcla lista para panquecas	10	58	28.00	40.00	0	5	2026-04-09 00:00:00
6123	Azúcar Estándar 1kg	Azucar morena de caña	3	58	26.00	35.00	0	5	2026-04-09 00:00:00
6124	Azúcar Refinada 1kg	Azucar blanca pura	3	58	32.00	42.00	0	5	2026-04-09 00:00:00
6125	Azúcar Glass 500g	Azucar pulverizada para reposteria	3	58	18.00	28.00	0	5	2026-04-09 00:00:00
6126	Piloncillo Cono 225g	Dulce de caña natural	3	58	12.00	18.00	0	5	2026-04-09 00:00:00
6127	Jarabe de Maíz Karo Bebé 250ml	Miel de maiz natural	11	58	35.00	50.00	0	5	2026-04-09 00:00:00
6128	Miel de Maple Aunt Jemima 710ml	Jarabe sabor maple original	11	58	65.00	95.00	0	5	2026-04-09 00:00:00
6129	Té Negro Lipton 20 sobres	Te negro clasico	4	58	22.00	32.00	0	5	2026-04-09 00:00:00
6130	Té Verde Twinings 20 sobres	Te verde calidad premium	4	58	45.00	65.00	0	5	2026-04-09 00:00:00
6131	Té de Limón McCormick 25 sobres	Te de hierbas natural	4	58	18.00	25.00	0	5	2026-04-09 00:00:00
6132	Chocolate Abuelita 6 tablillas	Chocolate para mesa tradicional	4	19	68.00	92.00	0	5	2026-04-09 00:00:00
6133	Chocolate Ibarra 540g	Chocolate para mesa con canela	4	58	62.00	85.00	0	5	2026-04-09 00:00:00
6134	Cocoa Hershey's en Polvo 200g	Cocoa pura sin azucar	4	45	48.00	68.00	0	5	2026-04-09 00:00:00
6135	Café Nescafé Clásico 200g	Cafe soluble instantaneo	4	19	85.00	115.00	0	5	2026-04-09 00:00:00
6136	Café Nescafé Dolca 170g	Cafe soluble con caramelo	4	19	75.00	105.00	0	5	2026-04-09 00:00:00
6137	Café Nescafé Decaf 170g	Cafe soluble descafeinado	4	19	90.00	125.00	0	5	2026-04-09 00:00:00
6138	Café Tostado y Molido Legal 400g	Cafe para cafetera mezcla	4	58	65.00	88.00	0	5	2026-04-09 00:00:00
6139	Sustituto de Crema Coffee Mate 400g	Crema en polvo para cafe	4	19	52.00	75.00	0	5	2026-04-09 00:00:00
6140	Leche Evaporada Carnation 360g	Leche concentrada en lata	15	19	19.00	26.00	0	5	2026-04-09 00:00:00
6141	Leche Condensada La Lechera 375g	Leche dulce en lata	15	19	24.00	32.00	0	5	2026-04-09 00:00:00
6142	Media Crema Nestlé 190g	Crema de leche en cajita	15	19	14.00	20.00	0	5	2026-04-09 00:00:00
6143	Leche en Polvo Nido Fortificada 800g	Leche en polvo para niños	15	19	135.00	185.00	0	5	2026-04-09 00:00:00
6144	Leche en Polvo Alpura 1kg	Leche entera en polvo bolsa	15	18	145.00	195.00	0	5	2026-04-09 00:00:00
6145	Leche Lala Entera 1L	Leche de vaca clasica caja	15	4	22.00	28.00	0	5	2026-04-09 00:00:00
6146	Leche Lala Deslactosada 1L	Leche de facil digestion caja	15	4	24.00	31.00	0	5	2026-04-09 00:00:00
6147	Leche Alpura Semidescremada 1L	Leche reducida en grasa	15	18	22.00	28.00	0	5	2026-04-09 00:00:00
6148	Leche Santa Clara Entera 1L	Leche premium caja	15	16	26.00	35.00	0	5	2026-04-09 00:00:00
6149	Bebida de Almendra Silk 946ml	Alimento liquido vegetal	15	58	38.00	55.00	0	5	2026-04-09 00:00:00
6150	Bebida de Soya Ades Natural 1L	Alimento liquido de soya	15	58	28.00	42.00	0	5	2026-04-09 00:00:00
6151	Mantequilla Primavera con Sal 90g	Margarina para untar	19	58	12.00	18.00	0	5	2026-04-09 00:00:00
6152	Mantequilla Gloria sin Sal 90g	Mantequilla pura de vaca	19	58	18.00	26.00	0	5	2026-04-09 00:00:00
6153	Huevo Blanco Paquete 12pza	Docena de huevos frescos	14	58	32.00	45.00	0	5	2026-04-09 00:00:00
6154	Huevo Rojo Paquete 12pza	Docena de huevos frescos rojos	14	58	35.00	48.00	0	5	2026-04-09 00:00:00
6155	Queso Philadelphia Original 190g	Queso crema tradicional	16	58	35.00	48.00	0	5	2026-04-09 00:00:00
6156	Queso Panela La Villita 400g	Queso fresco bajo en grasa	16	58	55.00	78.00	0	5	2026-04-09 00:00:00
6157	Crema Ácida Alpura 450ml	Crema de leche de vaca	17	18	28.00	40.00	0	5	2026-04-09 00:00:00
6158	Yogurt Danone Fresa 900g	Yogurt familiar batido	17	55	32.00	45.00	0	5	2026-04-09 00:00:00
6159	Chorizo de Pavo Fud 200g	Chorizo ligero empacado	18	53	22.00	32.00	0	5	2026-04-09 00:00:00
6160	Tocino Ahumado Fud 250g	Tocino de cerdo calidad	18	53	45.00	65.00	0	5	2026-04-09 00:00:00
6161	Papas Sabritas Original 160g	Papas fritas bolsa familiar	9	3	42.00	58.00	0	5	2026-04-09 00:00:00
6162	Doritos Nacho 146g	Botana de maiz sabor queso	9	3	38.00	52.00	0	5	2026-04-09 00:00:00
6163	Cheetos Torciditos 145g	Botana de maiz con queso	9	3	32.00	45.00	0	5	2026-04-09 00:00:00
6164	Ruffles Original 160g	Papas fritas onduladas	9	3	42.00	58.00	0	5	2026-04-09 00:00:00
6165	Tostitos Flamin Hot 200g	Botana picante de maiz	9	3	45.00	62.00	0	5	2026-04-09 00:00:00
6166	Cacahuates Japoneses Karate 154g	Cacahuates con cobertura crujiente	9	3	18.00	26.00	0	5	2026-04-09 00:00:00
6167	Cacahuates Salados Sabritas 180g	Cacahuates con sal familiar	9	3	35.00	48.00	0	5	2026-04-09 00:00:00
6168	Takis Fuego 190g	Botana de maiz enrollada extra picante	9	47	38.00	52.00	0	5	2026-04-09 00:00:00
6169	Chips Fuego 170g	Papas fritas picantes Barcel	9	47	45.00	62.00	0	5	2026-04-09 00:00:00
6170	Pop Karameladas Barcel 120g	Palomitas con caramelo bolsa	9	47	32.00	45.00	0	5	2026-04-09 00:00:00
6171	Palomitas ACT II Mantequilla	Bolsa para microondas	9	58	12.00	18.00	0	5	2026-04-09 00:00:00
6172	Pistaches con Sal 100g	Frutos secos calidad bolsa	9	58	45.00	68.00	0	5	2026-04-09 00:00:00
6173	Nuez de la India 100g	Frutos secos premium bolsa	9	58	55.00	85.00	0	5	2026-04-09 00:00:00
6174	Galletas María Gamesa 3 rollos	Paquete familiar galletas maria	29	46	38.00	52.00	0	5	2026-04-09 00:00:00
6175	Galletas Chokis Clasicas 190g	Galletas con chispas chocolate	29	46	22.00	32.00	0	5	2026-04-09 00:00:00
6176	Galletas Emperador Chocolate 273g	Galletas sandwich paquete mediano	29	46	28.00	40.00	0	5	2026-04-09 00:00:00
6177	Galletas Oreo Clasicas 273g	Galletas sandwich rellenas crema	9	58	32.00	45.00	0	5	2026-04-09 00:00:00
6178	Galletas Ritz Original 177g	Galletas saladas crujientes	9	58	18.00	28.00	0	5	2026-04-09 00:00:00
6179	Galletas Saladitas Gamesa 186g	Galletas saladas horneadas	9	46	18.00	28.00	0	5	2026-04-09 00:00:00
6180	Pan de Caja Bimbo Blanco Grande	Pan de molde clasico 680g	27	17	42.00	55.00	0	5	2026-04-09 00:00:00
6181	Pan de Caja Bimbo Integral Gde	Pan de molde con fibra 620g	27	17	48.00	62.00	0	5	2026-04-09 00:00:00
6182	Pan de Caja Oroweat Multigrano	Pan de molde premium	27	17	65.00	85.00	0	5	2026-04-09 00:00:00
6183	Pan Dulce Mantecadas Bimbo 4pza	Panecitos tipo muffin	29	17	18.00	26.00	0	5	2026-04-09 00:00:00
6184	Pan Dulce Nito Bimbo 1pza	Pan relleno de chocolate	29	17	13.00	18.00	0	5	2026-04-09 00:00:00
6185	Pan Dulce Donas Bimbo 4pza	Donas azucaradas empaque	29	17	18.00	26.00	0	5	2026-04-09 00:00:00
6186	Gansito Marinela 50g	Pastelito relleno mermelada y crema	29	22	13.00	18.00	0	5	2026-04-09 00:00:00
6187	Pingüinos Marinela 2pza	Pastelitos de chocolate rellenos	29	22	18.00	25.00	0	5	2026-04-09 00:00:00
6188	Chocotorro Marinela 1pza	Pastelito relleno de fresa	29	22	13.00	18.00	0	5	2026-04-09 00:00:00
6189	Galletas Triki-Trakes 6pza	Galletas con chispas Marinela	29	22	12.00	17.00	0	5	2026-04-09 00:00:00
6190	Galletas Canelitas 120g	Galletas sabor canela paquete mediano	29	22	18.00	28.00	0	5	2026-04-09 00:00:00
6191	Donitas Totis Sal y Limón bolsa	Botana de trigo familiar	9	58	18.00	28.00	0	5	2026-04-09 00:00:00
6192	Fritos Sal y Limón 170g	Botana de maiz crujiente	9	3	35.00	48.00	0	5	2026-04-09 00:00:00
6193	Pasta de Dientes Colgate Total 12	Cuidado bucal proteccion completa	38	30	35.00	52.00	0	5	2026-04-09 00:00:00
6194	Pasta de Dientes Colgate Triple Accion	Cuidado bucal economico 100ml	38	30	22.00	32.00	0	5	2026-04-09 00:00:00
6195	Pasta de Dientes Crest Blancura	Cuidado bucal blanqueador	38	58	28.00	40.00	0	5	2026-04-09 00:00:00
6196	Enjuague Bucal Colgate Plax 250ml	Refrescante bucal sin alcohol	38	30	38.00	55.00	0	5	2026-04-09 00:00:00
6197	Shampoo Pantene Brillo 700ml	Cuidado del cabello botella grande	35	35	75.00	105.00	0	5	2026-04-09 00:00:00
6198	Acondicionador Sedal Brillo 620ml	Cuidado del cabello desenredante	35	34	42.00	58.00	0	5	2026-04-09 00:00:00
6199	Shampoo Caprice Especialidades 750ml	Shampoo economico aromas	35	31	32.00	45.00	0	5	2026-04-09 00:00:00
6200	Crema para Peinar Sedal 300ml	Control de frizz para cabello	35	34	32.00	45.00	0	5	2026-04-09 00:00:00
6201	Gel Ego Fuerza Extrema 1kg	Gel fijador tarro grande	41	58	55.00	78.00	0	5	2026-04-09 00:00:00
6202	Jabón de Tocador Zest Aqua 135g	Jabon de barra refrescante	41	58	12.50	18.00	0	5	2026-04-09 00:00:00
6203	Jabón de Tocador Palmolive Neutro	Jabon de barra piel sensible	41	31	14.00	20.00	0	5	2026-04-09 00:00:00
6204	Desodorante Speed Stick Spray 150ml	Antitranspirante masculino	41	58	45.00	65.00	0	5	2026-04-09 00:00:00
6205	Desodorante Lady Speed Stick Stick	Antitranspirante femenino	41	58	32.00	48.00	0	5	2026-04-09 00:00:00
6206	Crema Nivea Corporal 400ml	Crema humectante botella	41	58	65.00	95.00	0	5	2026-04-09 00:00:00
6207	Vaselina Labial Proteccion 10g	Protector de labios tarro mini	41	58	15.00	22.00	0	5	2026-04-09 00:00:00
6208	Rastrillo Prestobarba 3 4pza	Rastrillos desechables paquete	41	58	75.00	105.00	0	5	2026-04-09 00:00:00
6209	Toallas Saba Nocturna 10pza	Higiene femenina flujo pesado	41	58	32.00	45.00	0	5	2026-04-09 00:00:00
6210	Protector Diario Saba 20pza	Higiene femenina uso diario	41	58	25.00	38.00	0	5	2026-04-09 00:00:00
6211	Detergente Ariel Power 1kg	Detergente en polvo multiusos	34	58	42.00	58.00	0	5	2026-04-09 00:00:00
6212	Detergente Roma 1kg	Detergente en polvo biodegradable	34	58	32.00	45.00	0	5	2026-04-09 00:00:00
6213	Jabón Zote Blanco 400g	Jabon de lavanderia en barra	34	33	22.00	30.00	0	5	2026-04-09 00:00:00
6214	Jabón Zote Rosa 400g	Jabon de lavanderia en barra	34	33	22.00	30.00	0	5	2026-04-09 00:00:00
6215	Suavizante Suavitel Fresca Primavera 1L	Suavizante de telas botella	32	32	28.00	38.00	0	5	2026-04-09 00:00:00
6216	Cloro Cloralex 950ml	Desinfectante y blanqueador	35	58	16.00	24.00	0	5	2026-04-09 00:00:00
6217	Limpiador Fabuloso Lavanda 2L	Limpiador multiusos grande	35	31	42.00	58.00	0	5	2026-04-09 00:00:00
6218	Lavatrastes Salvo Limón 900ml	Detergente liquido potente	34	58	38.00	52.00	0	5	2026-04-09 00:00:00
6219	Fibra Scotch-Brite Multiusos 2pza	Esponja para lavar platos	34	58	22.00	32.00	0	5	2026-04-09 00:00:00
6220	Bolsa para Basura Mediana 15pza	Bolsas negras con jareta	35	58	25.00	38.00	0	5	2026-04-09 00:00:00
6221	Guantes de Látex Domésticos G	Guantes para limpieza amarillos	35	58	18.00	28.00	0	5	2026-04-09 00:00:00
6222	Insecticida Raid Casa y Jardín 400ml	Spray contra insectos	35	58	58.00	82.00	0	5	2026-04-09 00:00:00
6223	Alimento Gato Whiskas Carne 1.5kg	Croquetas para gato adulto	43	58	125.00	175.00	0	5	2026-04-09 00:00:00
6224	Alimento Perro Pedigree Res 2kg	Croquetas para perro adulto	43	58	145.00	195.00	0	5	2026-04-09 00:00:00
6225	Cerveza Corona Extra 355ml 6-pack	Six pack de cerveza clara	32	58	95.00	135.00	0	5	2026-04-09 00:00:00
6226	Cerveza Victoria 355ml 6-pack	Six pack de cerveza oscura	32	58	95.00	135.00	0	5	2026-04-09 00:00:00
6227	Refresco Coca-Cola 600ml NR	Bebida de cola botella plastico	31	16	14.50	18.00	0	5	2026-04-09 00:00:00
6228	Refresco Coca-Cola 2.5L NR	Bebida de cola botella familiar	31	16	32.00	42.00	0	5	2026-04-09 00:00:00
6229	Refresco Sprite 600ml	Bebida de lima limon	31	16	13.00	17.00	0	5	2026-04-09 00:00:00
6230	Refresco Sidral Mundet 600ml	Bebida de manzana	31	16	13.00	17.00	0	5	2026-04-09 00:00:00
6231	Refresco Pepsi 600ml	Bebida de cola Pepsi	31	14	13.00	17.00	0	5	2026-04-09 00:00:00
6232	Agua Purificada Ciel 600ml	Agua natural embotellada	30	16	9.00	13.00	0	5	2026-04-09 00:00:00
6233	Agua Purificada Bonafont 1.5L	Agua natural botella mediana	30	55	14.00	20.00	0	5	2026-04-09 00:00:00
6234	Jugo Jumex Mango 1L	Nectar de fruta en carton	31	21	19.00	26.00	0	5	2026-04-09 00:00:00
6235	Jugo Jumex Manzana 1L	Nectar de fruta en carton	31	21	19.00	26.00	0	5	2026-04-09 00:00:00
6236	Bebida Energizante Monster 473ml	Bebida con cafeina lata	31	16	35.00	48.00	0	5	2026-04-09 00:00:00
6237	Bebida Energizante Red Bull 250ml	Bebida con cafeina lata pequeña	31	58	42.00	58.00	0	5	2026-04-09 00:00:00
6238	Sopa Maruchan Instant Lunch Pollo	Vaso de sopa instantanea 64g	12	57	11.00	16.00	0	5	2026-04-09 00:00:00
6239	Sopa Maruchan Instant Lunch Camaron	Vaso de sopa instantanea 64g	12	57	11.00	16.00	0	5	2026-04-09 00:00:00
6240	Atún Dolores en Aceite 140g	Atun en hojuelas lata	6	51	16.00	23.00	0	5	2026-04-09 00:00:00
6241	Atún Dolores en Agua 140g	Atun en hojuelas lata	6	51	16.00	23.00	0	5	2026-04-09 00:00:00
6242	Sardina en Tomate Pescador 425g	Sardinas en salsa lata	6	58	28.00	40.00	0	5	2026-04-09 00:00:00
6243	Pechuga de Pavo San Rafael Real 250g	Pechuga de pavo premium rebanada	18	52	62.00	88.00	0	5	2026-04-09 00:00:00
6244	Jamón Real de Pierna San Rafael 250g	Jamón de pierna de alta calidad	18	52	58.00	82.00	0	5	2026-04-09 00:00:00
6245	Salchicha de Pavo San Rafael 500g	Salchichas premium para asar	18	52	48.00	68.00	0	5	2026-04-09 00:00:00
6246	Chorizo Salamanca San Rafael 200g	Chorizo tipo español curado	18	52	52.00	75.00	0	5	2026-04-09 00:00:00
6247	Salami Italiano San Rafael 100g	Salami madurado rebanado	18	52	45.00	65.00	0	5	2026-04-09 00:00:00
6248	Pastrami de Pavo San Rafael 150g	Corte de pavo sazonado premium	18	52	65.00	92.00	0	5	2026-04-09 00:00:00
6249	Lomo Ahumado San Rafael 200g	Lomo de cerdo ahumado natural	18	52	55.00	78.00	0	5	2026-04-09 00:00:00
6250	Pechuga de Pavo Balance Fud 250g	Linea saludable reducida en sodio	18	53	48.00	68.00	0	5	2026-04-09 00:00:00
6251	Jamón de Pierna Fud Selecto 250g	Jamón de pierna calidad extra	18	53	42.00	58.00	0	5	2026-04-09 00:00:00
6252	Tocino Premium San Rafael 250g	Tocino corte grueso ahumado	18	52	68.00	95.00	0	5	2026-04-09 00:00:00
6253	Chistorra de Res 200g	Embutido para asado premium	18	58	45.00	65.00	0	5	2026-04-09 00:00:00
6254	Queso de Puerco Tradicional 250g	Embutido de cerdo especiado	18	58	32.00	48.00	0	5	2026-04-09 00:00:00
6255	Paté de Hígado de Cerdo 100g	Crema de higado para untar	18	58	22.00	35.00	0	5	2026-04-09 00:00:00
6256	Cerveza Modelo Especial Botella 355ml	Cerveza clara premium	32	58	20.00	28.00	0	5	2026-04-09 00:00:00
6257	Cerveza Negra Modelo Botella 355ml	Cerveza oscura tipo Munich	32	58	20.00	28.00	0	5	2026-04-09 00:00:00
6258	Cerveza Modelo Ambar 355ml	Cerveza tipo viena botella	32	58	20.00	28.00	0	5	2026-04-09 00:00:00
6259	Cerveza Stella Artois 330ml	Cerveza lager importada	32	58	26.00	38.00	0	5	2026-04-09 00:00:00
6260	Cerveza Budweiser Lata 355ml	Cerveza lager americana	32	58	18.00	25.00	0	5	2026-04-09 00:00:00
6261	Cerveza Michelob Ultra 6-pack Lata	Six pack cerveza light	32	58	110.00	155.00	0	5	2026-04-09 00:00:00
6262	Cerveza Corona Extra 12-pack Lata	Paquete familiar 12 piezas	32	58	185.00	245.00	0	5	2026-04-09 00:00:00
6263	Cerveza Victoria Mega 1.2L	Cerveza oscura retorno grande	32	58	35.00	48.00	0	5	2026-04-09 00:00:00
6264	Cerveza Corona Familiar 940ml	Cerveza clara presentacion grande	32	58	32.00	45.00	0	5	2026-04-09 00:00:00
6265	Cerveza Artesanal IPA 355ml	Cerveza con alto contenido de lupulo	32	58	45.00	65.00	0	5	2026-04-09 00:00:00
6266	Cerveza Artesanal Porter 355ml	Cerveza oscura artesanal	32	58	45.00	65.00	0	5	2026-04-09 00:00:00
6267	Cerveza Heineken 0.0 Sin Alcohol	Cerveza clara sin alcohol	32	58	22.00	32.00	0	5	2026-04-09 00:00:00
6268	Cerveza Tecate Original 6-pack Lata	Six pack cerveza clara	32	58	92.00	125.00	0	5	2026-04-09 00:00:00
6269	Vino Tinto Casillero del Diablo 750ml	Vino Cabernet Sauvignon	33	58	175.00	245.00	0	5	2026-04-09 00:00:00
6270	Vino Blanco Diamante 750ml	Vino blanco semidulce	33	58	165.00	235.00	0	5	2026-04-09 00:00:00
6271	Vino Rosado L.A. Cetto 750ml	Vino rosado nacional	33	58	145.00	195.00	0	5	2026-04-09 00:00:00
6272	Tequila Don Julio 70 700ml	Tequila añejo cristalino	33	58	850.00	1150.00	0	5	2026-04-09 00:00:00
6273	Tequila Centenario Plata 700ml	Tequila blanco 100 por ciento agave	33	58	380.00	520.00	0	5	2026-04-09 00:00:00
6274	Mezcal Amarás Joven 750ml	Mezcal artesanal de Oaxaca	33	58	550.00	750.00	0	5	2026-04-09 00:00:00
6275	Vodka Absolut Azul 750ml	Vodka sueco original	33	58	260.00	365.00	0	5	2026-04-09 00:00:00
6276	Ron Bacardi Blanco 980ml	Ron tradicional para cocteleria	33	58	195.00	275.00	0	5	2026-04-09 00:00:00
6277	Whisky Buchanan's 12 años 750ml	Whisky escoces de lujo	33	58	720.00	980.00	0	5	2026-04-09 00:00:00
6278	Ginebra Tanqueray 750ml	Ginebra premium London Dry	33	58	480.00	650.00	0	5	2026-04-09 00:00:00
6279	Brandy Torres 10 700ml	Brandy español reserva	33	58	290.00	395.00	0	5	2026-04-09 00:00:00
6280	Rompepe Santa Clara 1L	Bebida de huevo y vainilla	33	16	145.00	195.00	0	5	2026-04-09 00:00:00
6281	Bloqueador Solar Nivea FPS 50	Protector solar spray 200ml	40	58	185.00	245.00	0	5	2026-04-09 00:00:00
6282	Crema Facial Pond's S 100g	Crema humectante nutritiva	40	58	52.00	75.00	0	5	2026-04-09 00:00:00
6283	Serum Loreal Revitalift Hialuronico	Suero facial hidratante 30ml	40	58	245.00	325.00	0	5	2026-04-09 00:00:00
6284	Gel Limpiador Facial Neutrogena	Jabón liquido para cara 200ml	40	58	135.00	185.00	0	5	2026-04-09 00:00:00
6285	Agua Micelar Garnier 400ml	Limpiador facial todo en uno	40	58	95.00	135.00	0	5	2026-04-09 00:00:00
6286	Crema Corporal Lubriderm Piel Seca	Hidratacion profunda 400ml	40	58	85.00	115.00	0	5	2026-04-09 00:00:00
6287	Exfoliante Corporal Dove 298g	Exfoliante de granada y manteca	40	36	110.00	155.00	0	5	2026-04-09 00:00:00
6288	Mascarilla Facial Garnier Hidra Bomb	Mascara de tela hidratante	40	58	28.00	42.00	0	5	2026-04-09 00:00:00
6289	Shampoo Anticaspa Head & Shoulders	Limpieza profunda 700ml	39	58	85.00	115.00	0	5	2026-04-09 00:00:00
6290	Shampoo Elvive Reparacion Total	Cuidado capilar 680ml	39	58	75.00	105.00	0	5	2026-04-09 00:00:00
6291	Tinte para Cabello Koleston	Coloracion permanente tonos varios	39	58	55.00	85.00	0	5	2026-04-09 00:00:00
6292	Crema para Peinar Pantene Rizos	Definicion de rizos 300ml	39	35	42.00	58.00	0	5	2026-04-09 00:00:00
6293	Desodorante Axe Black Aero 150ml	Body spray masculino	41	58	48.00	68.00	0	5	2026-04-09 00:00:00
6294	Desodorante Rexona Clinical Hombre	Antitranspirante maxima proteccion	41	58	65.00	92.00	0	5	2026-04-09 00:00:00
6295	Desodorante Dove Original Barra	Cuidado de axilas femenino	41	36	38.00	55.00	0	5	2026-04-09 00:00:00
6296	Jabón Líquido Dial Antibacterial	Jabón corporal de manos 460ml	42	58	42.00	60.00	0	5	2026-04-09 00:00:00
6297	Jabón de Barra Dove Blanco 135g	Barra de belleza humectante	42	36	18.00	26.00	0	5	2026-04-09 00:00:00
6298	Cera para Depilar Rostro Nair	Bandas de cera fria 20pza	41	58	65.00	95.00	0	5	2026-04-09 00:00:00
6299	Enjuague Bucal Colgate Total 12 500ml	Proteccion bucal avanzada	38	30	72.00	98.00	0	5	2026-04-09 00:00:00
6300	Hilo Dental Reach Mentolado	Limpieza interdental 50m	38	58	35.00	48.00	0	5	2026-04-09 00:00:00
6301	Cepillo Dental Oral-B Pro-Salud	Cepillo de cerdas suaves 2 pack	38	30	45.00	65.00	0	5	2026-04-09 00:00:00
6302	Toallas Femeninas Saba V-Natural	Toallas con extractos naturales 10pza	41	58	28.00	40.00	0	5	2026-04-09 00:00:00
6303	Pañales Adulto Depend G 10pza	Pañal para incontinencia	44	29	145.00	195.00	0	5	2026-04-09 00:00:00
6304	Cuaderno Scribe Doble Raya	Cuaderno profesional 100 hojas	36	58	24.00	35.00	0	5	2026-04-09 00:00:00
6305	Sacapuntas con Deposito Maped	Sacapuntas de plastico doble	36	58	12.00	20.00	0	5	2026-04-09 00:00:00
6306	Colores Prismacolor 12 pzas	Lapices de colores escolares	36	58	55.00	85.00	0	5	2026-04-09 00:00:00
6307	Juego de Geometría Básico	Regla escuadras y transportador	36	58	35.00	55.00	0	5	2026-04-09 00:00:00
6308	Marcatextos Sharpie Amarillo	Resaltador de tinta brillante	36	58	14.00	22.00	0	5	2026-04-09 00:00:00
6309	Tijeras Escolares punta roma	Tijeras de seguridad para niños	36	58	12.00	20.00	0	5	2026-04-09 00:00:00
6310	Diccionario Escolar Básico	Diccionario español para primaria	36	58	45.00	75.00	0	5	2026-04-09 00:00:00
6311	Plato Desechable No. 9 20 pzas	Plato de plastico blanco fiesta	45	58	32.00	48.00	0	5	2026-04-09 00:00:00
6312	Cuchara Desechable Pastelera 25pza	Cubiertos de plastico chicos	45	58	15.00	25.00	0	5	2026-04-09 00:00:00
6313	Mantel de Plástico para Fiesta	Mantel rectangular de colores	45	58	22.00	38.00	0	5	2026-04-09 00:00:00
6314	Limpiador de Vidrios Windex 750ml	Gatillo limpiador cristales	35	58	42.00	62.00	0	5	2026-04-09 00:00:00
6315	Desengrasante Mr. Músculo Cocina	Limpiador de superficies grasas	35	58	45.00	68.00	0	5	2026-04-09 00:00:00
6316	Pastilla para Tanque Harpic 2pza	Limpiador de inodoro azul	35	58	28.00	42.00	0	5	2026-04-09 00:00:00
6317	Aromatizante Glade Toque 3 repuestos	Concentrado de aroma spray	35	58	52.00	78.00	0	5	2026-04-09 00:00:00
6318	Escoba de Exterior Uso Rudo	Escoba de cerdas rigidas	35	58	55.00	85.00	0	5	2026-04-09 00:00:00
6319	Jalador de Agua de Goma 40cm	Para limpieza de pisos	35	58	42.00	65.00	0	5	2026-04-09 00:00:00
6320	Bolsa Basura Jumbo 10pzas	Bolsa negra reforzada	35	58	38.00	55.00	0	5	2026-04-09 00:00:00
6321	Alimento Perro Campeon 4kg	Croquetas economicas para perro	43	58	185.00	245.00	0	5	2026-04-09 00:00:00
6322	Alimento Gato Minino Plus 1.3kg	Croquetas gourmet para gato	43	58	115.00	165.00	0	5	2026-04-09 00:00:00
6323	Arena para Gato con Aroma 5kg	Arena para desechos perfumada	43	58	75.00	105.00	0	5	2026-04-09 00:00:00
6324	Café Starbucks Pike Place 340g	Café tostado y molido premium	4	19	145.00	210.00	0	5	2026-04-09 00:00:00
6325	Cápsulas Dolce Gusto Cappuccino	Caja con 16 capsulas	4	19	135.00	185.00	0	5	2026-04-09 00:00:00
6326	Endulzante Monk Fruit 100g	Sustituto de azucar natural	3	58	85.00	125.00	0	5	2026-04-09 00:00:00
6327	Harina de Almendra 500g	Harina para cocina saludable	10	58	95.00	145.00	0	5	2026-04-09 00:00:00
6328	Quinoa Real Blanca 500g	Grano saludable de quinoa	2	58	55.00	85.00	0	5	2026-04-09 00:00:00
6329	Aceite de Coco Organico 420ml	Aceite para cocina y piel	1	58	85.00	125.00	0	5	2026-04-09 00:00:00
6330	Salsa Picante Huichol 190ml	Salsa tradicional picante	12	58	12.00	18.00	0	5	2026-04-09 00:00:00
6331	Salsa Maggi Sazonador 100ml	Salsa liquida para carnes	13	19	22.00	32.00	0	5	2026-04-09 00:00:00
6332	Salsa Inglesa Crosse & Blackwell	Salsa para marinar 145ml	13	19	24.00	35.00	0	5	2026-04-09 00:00:00
6333	Aceitunas Rellenas de Anchoa 200g	Aceitunas gourmet en frasco	6	58	35.00	52.00	0	5	2026-04-09 00:00:00
6334	Cereal Cheerios Avena y Granola	Cereal saludable Nestlé	5	19	62.00	88.00	0	5	2026-04-09 00:00:00
6335	Barra de Proteina Quest 60g	Barra alta en proteina varios sabores	5	58	45.00	68.00	0	5	2026-04-09 00:00:00
6336	Leche de Coco Calahua 1L	Bebida de coco para cocina	15	58	38.00	55.00	0	5	2026-04-09 00:00:00
6337	Yogurt Griego Oikos Natural 150g	Yogurt cremoso sin azucar	17	55	15.00	22.00	0	5	2026-04-09 00:00:00
6338	Helado Holanda Vainilla 1L	Bote de helado cremoso	17	58	55.00	85.00	0	5	2026-04-09 00:00:00
6339	Paletas Magnum Clasica 3pza	Caja de helado cubierto chocolate	17	58	85.00	120.00	0	5	2026-04-09 00:00:00
6340	Papas Pringles Original 124g	Botana de papa en tubo	9	58	38.00	55.00	0	5	2026-04-09 00:00:00
6341	Cacahuates Mafer Salados 180g	Cacahuate premium con sal	9	58	35.00	52.00	0	5	2026-04-09 00:00:00
6342	Mezcla de Frutos Secos 200g	Arandanos nueces y almendras	9	58	45.00	68.00	0	5	2026-04-09 00:00:00
6343	Palomitas Slim Pop 110g	Palomitas de maiz con aire	9	58	28.00	42.00	0	5	2026-04-09 00:00:00
6344	Galletas Stila Avena y Fruta	Galletas nutritivas Bimbo	29	17	12.00	18.00	0	5	2026-04-09 00:00:00
6345	Pan Pita Integral Paquete 10pza	Pan plano para sandwiches	27	58	32.00	48.00	0	5	2026-04-09 00:00:00
6346	Tortillas de Harina Tía Rosa Gdes	Paquete con 10 piezas grandes	27	49	25.00	35.00	0	5	2026-04-09 00:00:00
6347	Tostadas Horneadas Sanissimo	Paquete de 20 piezas	9	61	35.00	48.00	0	5	2026-04-09 00:00:00
6348	Refresco Coca-Cola Light 600ml	Refresco sin calorias	31	16	14.50	18.00	0	5	2026-04-09 00:00:00
6349	Refresco Sidral Mundet Manzana 2L	Refresco sabor manzana familiar	31	16	26.00	35.00	0	5	2026-04-09 00:00:00
6350	Agua Mineral Topo Chico 600ml	Agua mineral de manantial	30	16	16.00	24.00	0	5	2026-04-09 00:00:00
6351	Jugo V8 Splash Berry Blend 1.9L	Bebida de frutas y verduras	31	58	45.00	65.00	0	5	2026-04-09 00:00:00
6352	Suero Oral Suerox 630ml	Bebida hidratante sabores varios	31	58	18.00	26.00	0	5	2026-04-09 00:00:00
6353	Energizante Bolt Lata 473ml	Bebida con cafeina economica	31	58	15.00	22.00	0	5	2026-04-09 00:00:00
6354	Vela de Olor en Vaso de Vidrio	Vela decorativa aromatica	45	58	35.00	55.00	0	5	2026-04-09 00:00:00
6355	Tarjetas de Regalo Surtidas	Tarjetas para felicitacion	45	58	15.00	35.00	0	5	2026-04-09 00:00:00
6356	Cinta Adhesiva de Color	Cinta decorativa para regalo	45	58	10.00	18.00	0	5	2026-04-09 00:00:00
6357	Papel Regalo Pliego	Hojas de papel decorado	45	58	5.00	12.00	0	5	2026-04-09 00:00:00
6358	Moño para Regalo Grande	Moño de celofan varios colores	45	58	8.00	15.00	0	5	2026-04-09 00:00:00
6359	Pilas Duracell AA 4 piezas	Baterias alcalinas larga duracion	51	38	85.00	125.00	0	5	2026-04-09 00:00:00
6360	Pilas Energizer AAA 4 piezas	Baterias alcalinas	51	39	85.00	125.00	0	5	2026-04-09 00:00:00
6361	Lampara de Emergencia Recargable	Lampara LED para fallas luz	51	58	145.00	195.00	0	5	2026-04-09 00:00:00
6362	Candado de Laton 40mm	Candado reforzado 3 llaves	51	58	65.00	95.00	0	5	2026-04-09 00:00:00
6363	Pegamento Epoxico Transparente	Pegamento dos componentes fuerte	51	58	45.00	75.00	0	5	2026-04-09 00:00:00
6364	Limpiador de Alfombras en Espuma	Limpieza de textiles y tapiceria	35	58	65.00	95.00	0	5	2026-04-09 00:00:00
6365	Detergente Liquido Mas Color 1L	Detergente para ropa oscura	34	58	38.00	55.00	0	5	2026-04-09 00:00:00
6366	Quita Manchas Vanish 450g	Polvo para manchas dificiles	34	58	45.00	68.00	0	5	2026-04-09 00:00:00
6367	Suavizante Downy Concentrado 800ml	Aroma intenso para ropa	32	58	42.00	62.00	0	5	2026-04-09 00:00:00
6368	Cubeta de Plastico con Exprimidor	Cubeta para trapear reforzada	35	58	85.00	125.00	0	5	2026-04-09 00:00:00
6369	Guantes de Nitrilo Caja 50pza	Guantes desechables de examen	35	58	120.00	185.00	0	5	2026-04-09 00:00:00
6370	Tapete de Entrada Bienvenida	Tapete de hule para puerta	51	58	65.00	95.00	0	5	2026-04-09 00:00:00
6371	Foco LED Vintage Luz Calida	Foco decorativo estilo antiguo	51	58	45.00	75.00	0	5	2026-04-09 00:00:00
6372	Cable USB C a USB C 1m	Cable de carga rapida	51	58	35.00	65.00	0	5	2026-04-09 00:00:00
6373	Audifonos de Chicharo con Microfono	Manos libres economicos	51	58	45.00	85.00	0	5	2026-04-09 00:00:00
6374	Chocolate Ferrero Rocher 16pzas	Caja de bombones de chocolate	8	40	125.00	185.00	0	5	2026-04-09 00:00:00
6375	Chocolate Hershey's Almond 40g	Barra de chocolate con almendras	8	45	13.00	18.00	0	5	2026-04-09 00:00:00
6376	Kisses de Chocolate con Leche 75g	Bolsa de chocolates pequeños	8	45	28.00	42.00	0	5	2026-04-09 00:00:00
6377	Dulce Mazapan De La Rosa Gigante	Mazapan de cacahuate 50g	8	62	6.00	10.00	0	5	2026-04-09 00:00:00
6378	Gomitas Panditas Ricolino 65g	Gomitas de ositos sabores	8	67	13.00	18.00	0	5	2026-04-09 00:00:00
6379	Paleta Tutsi Pop Grande 1pza	Paleta con centro de chicle	8	65	5.00	8.00	0	5	2026-04-09 00:00:00
6380	Caramelo Suave Winis 4pza	Tira de caramelos sabores	8	58	5.00	8.00	0	5	2026-04-09 00:00:00
6381	Chicles Orbit Menta sin Azucar	Chicles en bote pequeño	8	58	18.00	28.00	0	5	2026-04-09 00:00:00
6382	Dulce de Leche Coronado 370g	Cajeta quemada tradicional	11	66	55.00	78.00	0	5	2026-04-09 00:00:00
6383	Mermelada McCormick Fresa 270g	Mermelada de fruta con trozos	11	58	28.00	42.00	0	5	2026-04-09 00:00:00
6384	Arroz Super Extra Verde Valle 900g	Arroz de grano largo seleccionado	2	58	32.00	45.00	0	5	2026-04-09 00:00:00
6385	Frijol Negro Isadora Pouch 430g	Frijoles refritos listos	2	58	15.00	22.00	0	5	2026-04-09 00:00:00
6386	Atun Herdez en Agua 130g	Atun en trozos lata	6	20	17.00	24.00	0	5	2026-04-09 00:00:00
6387	Chiles Jalapeños La Costeña 220g	Chiles en escabeche lata	6	27	12.00	18.00	0	5	2026-04-09 00:00:00
6388	Granos de Elote Del Monte 225g	Maiz dulce en lata	6	70	13.00	19.00	0	5	2026-04-09 00:00:00
6389	Pure de Tomate Del Fuerte 210g	Tomate molido condimentado	12	43	7.00	11.00	0	5	2026-04-09 00:00:00
6390	Sopa Pasta Knorr de Pollo 95g	Sopa instantanea en sobre	12	58	11.00	16.00	0	5	2026-04-09 00:00:00
6391	Consome de Pollo Knorr 10 cubos	Sazonador en cubos	13	58	15.00	22.00	0	5	2026-04-09 00:00:00
6392	Sal de Mar de Grano 1kg	Sal natural no refinada	13	58	18.00	28.00	0	5	2026-04-09 00:00:00
6393	Azucar Stevia en Polvo 100g	Endulzante natural frasco	3	58	65.00	95.00	0	5	2026-04-09 00:00:00
6394	Shampoo para Bebe Johnson 400ml	Shampoo no mas lagrimas	44	58	55.00	82.00	0	5	2026-04-09 00:00:00
6395	Toallitas Humedas Huggies Cuidado	Paquete de 80 toallitas	44	29	35.00	52.00	0	5	2026-04-09 00:00:00
6396	Papilla Gerber Etapa 2 Pollo 113g	Alimento para bebe frasco	44	19	14.00	20.00	0	5	2026-04-09 00:00:00
6397	Leche Formula Nan Pro 1 400g	Formula lactea etapa 1	44	19	165.00	225.00	0	5	2026-04-09 00:00:00
6398	Biberon Avent Natural 9oz	Biberon ergonomico anticólicos	44	58	185.00	265.00	0	5	2026-04-09 00:00:00
6399	Jabón Liquido para Manos Palmolive	Repuesto economico 500ml	42	31	32.00	48.00	0	5	2026-04-09 00:00:00
6400	Crema para Peinar Herbal Essences	Hidratacion y brillo 300ml	39	58	48.00	68.00	0	5	2026-04-09 00:00:00
6401	Desodorante Gillette Clear Gel 82g	Antitranspirante transparente	41	58	55.00	78.00	0	5	2026-04-09 00:00:00
6402	Toallas Femeninas Kotex Nocturna	Toallas con alas 10pza	41	29	32.00	45.00	0	5	2026-04-09 00:00:00
6403	Cepillo de Pelo Redondo	Cepillo para peinar y secar	39	58	45.00	75.00	0	5	2026-04-09 00:00:00
6404	Cerveza Indio Mega 1.2L	Cerveza oscura presentacion familiar	32	58	35.00	48.00	0	5	2026-04-09 00:00:00
6405	Cerveza Sol Clamato Lata 473ml	Mezcla de cerveza y tomate	32	58	24.00	35.00	0	5	2026-04-09 00:00:00
6406	Cerveza Modelo Trigo 355ml	Cerveza de trigo artesanal	32	58	22.00	32.00	0	5	2026-04-09 00:00:00
6407	Cerveza XX Ambar 6-pack Botella	Six pack cerveza oscura	32	58	105.00	145.00	0	5	2026-04-09 00:00:00
6408	Cerveza Heineken Silver Lata 355ml	Cerveza clara mas ligera	32	58	20.00	28.00	0	5	2026-04-09 00:00:00
6409	Vino Tinto Sangre de Toro 750ml	Vino tinto español	33	58	185.00	265.00	0	5	2026-04-09 00:00:00
6410	Vodka Smirnoff Tamarindo 750ml	Vodka con sabor picante	33	58	240.00	345.00	0	5	2026-04-09 00:00:00
6411	Ginebra Beefeater 750ml	Ginebra clasica London Dry	33	58	450.00	620.00	0	5	2026-04-09 00:00:00
6412	Ron Captain Morgan 700ml	Ron especiado dorado	33	58	185.00	265.00	0	5	2026-04-09 00:00:00
6413	Licor 43 700ml	Licor español de vainilla	33	58	450.00	620.00	0	5	2026-04-09 00:00:00
6414	Salchicha para Hot Dog Fud 500g	Paquete de salchichas familiar	18	53	35.00	48.00	0	5	2026-04-09 00:00:00
6415	Tocino Picado para Cocinar 200g	Recortes de tocino ahumado	18	53	28.00	42.00	0	5	2026-04-09 00:00:00
6416	Chorizo Argentino para Asar 500g	Embutido premium para parrilla	18	58	75.00	110.00	0	5	2026-04-09 00:00:00
6417	Mortadela con Pistache 250g	Embutido fino rebanado	18	58	38.00	55.00	0	5	2026-04-09 00:00:00
6418	Jamón de Pavo Virginia Zwan 250g	Jamón de pavo calidad media-alta	18	58	35.00	48.00	0	5	2026-04-09 00:00:00
6419	Papas Sabritas Receta Crujiente 170g	Papas fritas con sal de mar	9	3	45.00	65.00	0	5	2026-04-09 00:00:00
6420	Doritos Pizzerola 146g	Botana de maiz sabor pizza	9	3	38.00	52.00	0	5	2026-04-09 00:00:00
6421	Tostilocos Clasicos Bolsa 200g	Botana de maiz para preparar	9	3	42.00	58.00	0	5	2026-04-09 00:00:00
6422	Papas Barcel Chips Jalapeño 170g	Papas fritas crujientes picantes	9	47	45.00	65.00	0	5	2026-04-09 00:00:00
6423	Cheetos Colmillo 150g	Botana de maiz forma colmillo	9	3	32.00	45.00	0	5	2026-04-09 00:00:00
6424	Galletas Gamesa Habaneras 117g	Galletas integrales saladas	9	46	15.00	22.00	0	5	2026-04-09 00:00:00
6425	Galletas Cuetara Surtido 400g	Caja de galletas variadas	9	58	45.00	65.00	0	5	2026-04-09 00:00:00
6426	Pan Blanco para Hot Dog Bimbo 8pza	Medias noches clasicas	27	17	32.00	45.00	0	5	2026-04-09 00:00:00
6427	Pan para Hamburguesa Bimbo 8pza	Bollos con ajonjoli	27	17	35.00	48.00	0	5	2026-04-09 00:00:00
6428	Manteles Desechables Decorados 1pza	Mantel de papel para fiesta	45	58	15.00	28.00	0	5	2026-04-09 00:00:00
6429	Vasos de Carton Biodegradables 10pza	Vasos para cafe o bebidas	45	58	22.00	35.00	0	5	2026-04-09 00:00:00
6430	Globos Metalicos de Numeros	Globos para aniversario o cumple	45	58	25.00	45.00	0	5	2026-04-09 00:00:00
6431	Papel Crepé varios colores	Pliego de papel para decoracion	45	58	4.00	10.00	0	5	2026-04-09 00:00:00
6432	Adorno de Guirnalda Fiesta 3m	Tira decorativa de colores	45	58	18.00	32.00	0	5	2026-04-09 00:00:00
6433	Pegamento Resistol 5000 135ml	Pegamento de contacto amarillo	51	58	45.00	68.00	0	5	2026-04-09 00:00:00
6434	Silicon Liquido Frio 100ml	Pegamento para manualidades	51	58	22.00	35.00	0	5	2026-04-09 00:00:00
6435	Cinta de Doble Cara 5m	Cinta adhesiva doble contacto	51	58	25.00	42.00	0	5	2026-04-09 00:00:00
6436	Marcador Permanente Sharpie 2 pack	Marcador negro punta fina	36	58	35.00	55.00	0	5	2026-04-09 00:00:00
6437	Notas Adhesivas Post-it 76x76mm	Bloc de notas de colores	36	58	22.00	38.00	0	5	2026-04-09 00:00:00
6438	Engrapadora de Oficina con Grapas	Engrapadora pequeña metalica	36	58	65.00	95.00	0	5	2026-04-09 00:00:00
6439	Agua de Coco Marva 500ml	Agua de coco natural	31	58	18.00	28.00	0	5	2026-04-09 00:00:00
6440	Te Helado Lipton Limon 600ml	Bebida de te negro	31	58	14.00	20.00	0	5	2026-04-09 00:00:00
6441	Refresco Manzana Lift 600ml	Refresco de manzana natural	31	16	13.00	17.00	0	5	2026-04-09 00:00:00
6442	Refresco Mundet Fresa 600ml	Refresco sabor fresa	31	16	13.00	17.00	0	5	2026-04-09 00:00:00
6443	Coca Cola 2.5L NR	Refresco Coca Cola 2.5 Litros No Retornable	31	16	28.00	35.00	0	5	2026-04-15 00:00:00
6444	Pepsi 1.5L	Refresco Pepsi 1.5 Litros	31	14	12.00	15.50	100	10	2026-04-15 00:00:00
6445	Sabritas	Sabritas Flamin Hot	9	3	10.00	18.00	4	1	2026-04-15 00:00:00
6446	Coca Cola 1L	Refresco Coca Cola 1 Litro	31	16	12.00	15.00	100	10	2026-04-15 00:00:00
6447	Galletas marias	Las galletas clasicas	9	3	8.90	15.00	18	2	2026-04-15 00:00:00
6448	Tortillas de maiz 1/2 kg	None	10	58	8.00	10.50	100	10	2026-04-15 00:00:00
6449	Coca Cola lata 355ml	Refresco Coca Cola 355 ml lata	31	16	8.50	11.00	100	10	2026-04-15 00:00:00
6450	chimichangas	chimichangas	23	10	30.00	45.00	14	5	2026-04-15 00:00:00
6451	MaruchanTokyo	maruchan picante	2	11	5.50	12.50	15	10	2026-04-15 00:00:00
6452	Leche Santa Clara entera 1L	Leche Santa Clara entera 1 Litro	15	4	22.00	28.00	100	10	2026-04-15 00:00:00
6453	Marias gamesa	None	29	46	8.00	10.50	100	10	2026-04-15 00:00:00
6454	Leche Lala entera 1L	Leche Lala entera 1 Litro	15	4	19.00	24.00	100	10	2026-04-15 00:00:00
6455	Leche Lala light 1L	Leche Lala light 1 Litro	15	4	20.00	25.00	100	10	2026-04-15 00:00:00
6456	Leche Santa Clara deslactosada 1L	Leche Santa Clara deslactosada 1 Litro	15	4	23.00	29.00	100	10	2026-04-15 00:00:00
6457	Pepsi 600ml	bebida azucarada	31	14	8.00	16.00	77	20	2026-04-15 00:00:00
6458	Yogurt Lala natural 1L	Yogurt Lala natural 1 Litro	17	4	25.00	30.00	100	10	2026-04-15 00:00:00
6459	Yogurt Lala de fresa 1L	Yogurt Lala sabor Fresa 1 Litro	17	4	25.00	30.00	100	10	2026-04-15 00:00:00
6460	Harina de trigo San antonio	None	10	41	8.00	10.50	100	10	2026-04-15 00:00:00
6461	Del Valle fruit guayaba 600ml	Jugo Del Valle sabor Guayaba 600 ml	31	28	10.50	13.50	100	10	2026-04-15 00:00:00
6462	Pan bimbo blanco chico	None	27	17	8.00	10.50	100	10	2026-04-15 00:00:00
6463	Pan bimbo blanco grande	None	27	17	8.00	10.50	100	10	2026-04-15 00:00:00
6464	Pan bimbo integral chico	None	27	17	8.00	10.50	100	10	2026-04-15 00:00:00
6465	Pan bimbo integral grande	None	27	17	8.00	10.50	100	10	2026-04-15 00:00:00
6466	Rebanadas bimbo	None	27	17	8.00	10.50	100	10	2026-04-15 00:00:00
6467	Chocoroles	None	27	17	8.00	10.50	100	10	2026-04-15 00:00:00
6468	Nito bimbo	None	27	17	8.00	10.50	100	10	2026-04-15 00:00:00
6469	Roles de canela con pasas	None	27	17	8.00	10.50	100	10	2026-04-15 00:00:00
6470	Roles de canela glaseados	None	27	17	8.00	10.50	100	10	2026-04-15 00:00:00
6471	Conchas bimbo	None	27	17	8.00	10.50	100	10	2026-04-15 00:00:00
6472	Panque de nuez bimbo	None	27	17	8.00	10.50	100	10	2026-04-15 00:00:00
6473	Donitas bimbo	None	27	17	8.00	10.50	100	10	2026-04-15 00:00:00
6474	Donitas espolvoreadas bimbo	None	27	17	8.00	10.50	100	10	2026-04-15 00:00:00
6475	Tostadas charras	None	5	60	8.00	10.50	100	10	2026-04-15 00:00:00
6476	Tostadas Sanissimo	None	5	61	8.00	10.50	100	10	2026-04-15 00:00:00
6477	Roles	Ricos roles de canela caseros	27	13	70.00	100.00	17	10	2026-04-15 00:00:00
6478	Coca Cola 355ml	Refresco Coca Cola 355 ml	31	16	8.00	10.50	100	10	2026-04-15 00:00:00
6479	Coca Cola 600ml	Refresco Coca Cola 600 ml	31	16	9.00	12.00	100	10	2026-04-15 00:00:00
6480	Coca Cola retornable 1 1/4 lt.	Refresco Coca Cola retornable 1 1/4 lt	31	16	12.50	15.50	100	10	2026-04-15 00:00:00
6481	Coca Cola 2L retornable	Refresco Coca Cola retornable 2 Litros	31	16	19.50	24.00	100	10	2026-04-15 00:00:00
6482	Coca Cola 3L retornable	Refresco Coca Cola retornable 3 Litros	31	16	24.00	30.00	100	10	2026-04-15 00:00:00
6483	Coca Cola Light 600ml	Refresco Coca Cola Light 600 ml	31	16	9.50	12.50	100	10	2026-04-15 00:00:00
6484	Manzanita 2lt.		31	14	17.00	25.00	22	3	2026-04-15 00:00:00
6485	Manzanita 600ml	Refresco Manzanita Sol 600 ml	31	16	9.00	12.00	100	10	2026-04-15 00:00:00
6486	Fanta 600ml	Refresco Fanta 600 ml	31	16	9.00	12.00	100	10	2026-04-15 00:00:00
6487	Fanta 1.5L	Refresco Fanta 1.5 Litros	31	16	12.50	16.00	100	10	2026-04-15 00:00:00
6488	Sprite 600ml	Refresco Sprite 600 ml	31	16	9.00	12.00	100	10	2026-04-15 00:00:00
6489	Sprite 1.5L	Refresco Sprite 1.5 Litros	31	16	12.50	16.00	100	10	2026-04-15 00:00:00
6490	Manzanita 1.5L	Refresco Manzanita Sol 1.5 Litros	31	16	12.50	16.00	100	10	2026-04-15 00:00:00
6491	Jumex de mango 1L	Jugo Jumex sabor Mango 1 Litro	31	21	16.00	20.00	100	10	2026-04-15 00:00:00
6492	Fresca 600ml	Refresco Fresca 600 ml	31	16	9.00	12.00	100	10	2026-04-15 00:00:00
6493	Fresca 3L	Refresco Fresca 3 Litros	31	16	24.00	30.00	100	10	2026-04-15 00:00:00
6494	Mirinda 600ml	Refresco Mirinda 600 ml	31	16	9.00	12.00	100	10	2026-04-15 00:00:00
6495	Mirinda 1.5L	Refresco Mirinda 1.5 Litros	31	16	12.50	16.00	100	10	2026-04-15 00:00:00
6496	Jumex de manzana 600ml	Jugo Jumex sabor Manzana 600 ml	31	21	10.00	13.00	100	10	2026-04-15 00:00:00
6497	Jumex de durazno 1L	Jugo Jumex sabor Durazno 1 Litro	31	21	16.00	20.00	100	10	2026-04-15 00:00:00
6498	Emperador chocolate	None	29	46	8.00	10.50	100	10	2026-04-15 00:00:00
6499	Emperador nuez	None	29	46	8.00	10.50	100	10	2026-04-15 00:00:00
6500	Del Valle fruit manzana 600ml	Jugo Del Valle sabor Manzana 600 ml	31	28	10.50	13.50	100	10	2026-04-15 00:00:00
6501	Emperador vainilla	None	29	46	8.00	10.50	100	10	2026-04-15 00:00:00
6502	Emperador limon	None	29	46	8.00	10.50	100	10	2026-04-15 00:00:00
6504	Mamut chico	None	29	46	8.00	10.50	100	10	2026-04-15 00:00:00
6505	Del Valle fruit naranja 600ml	Jugo Del Valle sabor Naranja 600 ml	31	28	10.50	13.50	100	10	2026-04-15 00:00:00
6506	Mantequilla Lala 250g	Mantequilla Lala 250 gramos	19	4	30.00	38.00	100	10	2026-04-15 00:00:00
6507	Mantecadas	None	27	17	8.00	10.50	100	10	2026-04-15 00:00:00
6508	Mamut grande	None	29	46	8.00	10.50	100	10	2026-04-15 00:00:00
6509	Chokis	None	29	46	8.00	10.50	100	10	2026-04-15 00:00:00
6510	Yogurt Yoplait de fresa 1L	Yogurt Yoplait sabor Fresa 1 Litro	17	54	26.00	31.00	100	10	2026-04-15 00:00:00
6511	Queso panela Lala 200g	Queso panela Lala 200 gramos	16	4	40.00	50.00	100	10	2026-04-15 00:00:00
6512	Arroz Mexica 1kg	None	2	59	12.00	16.50	100	10	2026-04-15 00:00:00
6513	Harina de maiz maseca	None	10	59	8.00	10.50	100	10	2026-04-15 00:00:00
6514	Chokis rellenas	None	29	46	8.00	10.50	100	10	2026-04-15 00:00:00
6515	Chokis doble chocolate	None	29	46	8.00	10.50	100	10	2026-04-15 00:00:00
6516	Chokis brownie	None	29	46	8.00	10.50	100	10	2026-04-15 00:00:00
6517	Coca Cola Sin Azucar 600ml	Refresco Coca Cola Sin Azucar 600ml	31	16	12.00	17.00	0	5	2026-04-15 00:00:00
6518	Sprite 2L	Refresco sabor Limon 2 Litros	31	16	22.00	28.00	0	5	2026-04-15 00:00:00
6519	Fanta Naranja 2L	Refresco sabor Naranja 2 Litros	31	16	22.00	28.00	0	5	2026-04-15 00:00:00
6520	Sidral Mundet 2L	Refresco sabor Manzana 2 Litros	31	16	22.00	28.00	0	5	2026-04-15 00:00:00
6521	Fresca Toronja 2L	Refresco sabor Toronja 2 Litros	31	16	22.00	28.00	0	5	2026-04-15 00:00:00
6522	Del Valle Naranja 1L	Jugo Del Valle Naranja 1 Litro	31	28	18.00	23.00	0	5	2026-04-15 00:00:00
6523	Del Valle Durazno 1L	Jugo Del Valle Durazno 1 Litro	31	28	18.00	23.00	0	5	2026-04-15 00:00:00
6524	Fuze Tea Limon 600ml	Te helado sabor Limon 600ml	31	16	13.00	18.00	0	5	2026-04-15 00:00:00
6525	Fuze Tea Negro 600ml	Te helado sabor Negro 600ml	31	16	13.00	18.00	0	5	2026-04-15 00:00:00
6526	7Up 600ml	Refresco sabor Lima-Limon 600ml	31	14	12.00	16.00	0	5	2026-04-15 00:00:00
6527	7Up 2L	Refresco sabor Lima-Limon 2 Litros	31	14	20.00	26.00	0	5	2026-04-15 00:00:00
6528	Mirinda 2L	Refresco sabor Naranja 2 Litros	31	14	20.00	26.00	0	5	2026-04-15 00:00:00
6529	Agua Epura 5L	Agua Purificada Epura 5 Litros	30	14	24.00	32.00	0	5	2026-04-15 00:00:00
6530	Agua Epura 10L	Agua Purificada Epura 10 Litros	30	14	35.00	48.00	0	5	2026-04-15 00:00:00
6531	Agua Ciel 5L	Agua Purificada Ciel 5 Litros	30	16	25.00	33.00	0	5	2026-04-15 00:00:00
6532	Jumex Lata 335ml Guayaba	Jugo de Guayaba en Lata 335ml	31	21	10.00	14.00	0	5	2026-04-15 00:00:00
6533	Agua ciel 600ml	None	30	16	8.00	13.00	100	10	2026-04-15 00:00:00
6534	Agua ciel 1lt	None	30	16	10.00	15.00	100	10	2026-04-15 00:00:00
6535	Agua ciel 1.5l	None	30	16	12.00	17.00	100	10	2026-04-15 00:00:00
6536	Agua ciel 2lt	None	30	16	14.00	20.00	100	10	2026-04-15 00:00:00
6537	Agua E-pura 600ml	None	30	14	8.00	13.00	100	10	2026-04-15 00:00:00
6538	Agua E-pura 1lt	None	30	14	10.00	15.00	100	10	2026-04-15 00:00:00
6539	Garrafon E-pura 10lt	None	30	14	18.00	25.00	100	10	2026-04-15 00:00:00
6540	Crema Lala 200ml	None	15	4	8.00	13.00	100	10	2026-04-15 00:00:00
6541	Crema Lala 426ml	None	15	4	15.00	30.00	100	10	2026-04-15 00:00:00
6542	Crema Lala 900ml	None	15	4	35.00	55.00	100	10	2026-04-15 00:00:00
6543	Queso panela Alpura 200g	Queso panela Alpura 200 gramos	16	18	40.00	50.00	100	10	2026-04-15 00:00:00
6544	Crema alpura 200ml	None	15	4	8.00	13.00	100	10	2026-04-15 00:00:00
6545	Crema alpura 426ml	None	15	4	15.00	30.00	100	10	2026-04-15 00:00:00
6546	Crema alpura 900ml	None	15	4	35.00	55.00	100	10	2026-04-15 00:00:00
6547	Atun dolores en agua	None	6	51	10.00	15.00	100	10	2026-04-15 00:00:00
6548	Atun dolores en aceite	None	6	51	12.00	17.00	100	10	2026-04-15 00:00:00
6549	Sardinas en aceite	None	6	20	10.00	15.00	100	10	2026-04-15 00:00:00
6550	Frijoles refritos	None	6	50	10.00	15.00	100	10	2026-04-15 00:00:00
6551	Frijoles bayos	None	6	50	10.00	15.00	100	10	2026-04-15 00:00:00
6552	Lentejas la moderna	None	2	44	10.00	15.00	100	10	2026-04-15 00:00:00
6553	Pasta la moderna	None	2	44	10.00	15.00	100	10	2026-04-15 00:00:00
6554	Queso oaxaca Lala 200g	Queso Oaxaca Lala 200 gramos	16	4	45.00	55.00	100	10	2026-04-15 00:00:00
6555	Del Valle Mango 1L	Jugo Del Valle Mango 1 Litro	31	28	18.00	23.00	0	5	2026-04-15 00:00:00
6556	Coditos la moderna	None	2	44	10.00	15.00	100	10	2026-04-15 00:00:00
6557	Salchichas Fud paquete 500g	Salchichas Fud 500 gramos	18	53	30.00	40.00	100	10	2026-04-15 00:00:00
6558	Salchichas San Rafael paquete 500g	Salchichas San Rafael 500 gramos	18	52	35.00	45.00	100	10	2026-04-15 00:00:00
6559	Pasta Barilla espagueti	None	2	56	10.00	15.00	100	10	2026-04-15 00:00:00
6560	Sopa de letras la moderna	None	2	44	10.00	15.00	100	10	2026-04-15 00:00:00
6561	Sopa maruchan pollo	None	2	57	10.00	15.00	100	10	2026-04-15 00:00:00
6562	Sopa maruchan camaron	None	2	57	10.00	15.00	100	10	2026-04-15 00:00:00
6563	Sopa maruchan res	None	2	57	10.00	15.00	100	10	2026-04-15 00:00:00
6564	Sopa maruchan habanero	None	2	57	10.00	15.00	100	10	2026-04-15 00:00:00
6565	Sopa maruchan piquin	None	2	57	10.00	15.00	100	10	2026-04-15 00:00:00
6566	Sopa maruchan limon	None	2	57	10.00	15.00	100	10	2026-04-15 00:00:00
6567	Penafiel Mineral 600ml	Agua Mineral Penafiel 600ml	31	58	11.00	15.00	0	5	2026-04-15 00:00:00
6568	Penafiel Twist Limon 600ml	Agua Mineral con Limon 600ml	31	58	12.00	16.00	0	5	2026-04-15 00:00:00
6569	Sangria Senorial 355ml	Bebida sabor Sangria 355ml	31	58	10.00	14.00	0	5	2026-04-15 00:00:00
6570	Sangria Senorial 600ml	Bebida sabor Sangria 600ml	31	58	13.00	18.00	0	5	2026-04-15 00:00:00
6571	Jarritos Tamarindo 600ml	Refresco sabor Tamarindo 600ml	31	58	10.00	14.00	0	5	2026-04-15 00:00:00
6572	Jarritos Multisabor 2L	Refresco varios sabores 2 Litros	31	58	18.00	24.00	0	5	2026-04-15 00:00:00
6573	Jamon de pavo Fud 250g	Jamon de Pavo Fud 250 gramos	18	53	35.00	45.00	100	10	2026-04-15 00:00:00
6574	Jamon de pavo San Rafael 250g	Jamon de Pavo San Rafael 250 gramos	18	52	40.00	50.00	100	10	2026-04-15 00:00:00
6575	Sidral mundet 600ml	Refresco de manzana de 600ml	31	16	10.00	16.00	20	5	2026-04-15 00:00:00
6576	Sidral mundet 3lt	Refresco de manzana de 3lt	31	16	24.00	30.00	20	5	2026-04-15 00:00:00
6577	Agua bonafont 600ml	None	30	55	8.00	10.50	100	10	2026-04-15 00:00:00
6578	Agua bonafont 1lt	None	30	55	12.00	15.00	100	10	2026-04-15 00:00:00
6579	Agua bonafont 2lt.	None	30	55	14.00	18.00	100	10	2026-04-15 00:00:00
6580	Garrafon bonafont 20lt	None	30	55	19.50	24.00	100	10	2026-04-15 00:00:00
6581	Leche Lala Entera 1.5L	Leche Entera 1.5 Litros	15	4	30.00	37.00	0	5	2026-04-15 00:00:00
6582	Leche Lala Semidescremada 1L	Leche Semidescremada 1 Litro	15	4	21.00	26.00	0	5	2026-04-15 00:00:00
6583	Leche Alpura Entera 1L	Leche Alpura Entera 1 Litro	15	18	20.00	25.00	0	5	2026-04-15 00:00:00
6584	Leche Alpura Deslactosada 1L	Leche Alpura Deslactosada 1 Litro	15	18	22.00	27.00	0	5	2026-04-15 00:00:00
6585	Leche Alpura 250ml Fresa	Leche saborizada Fresa 250ml	15	18	8.50	12.00	0	5	2026-04-15 00:00:00
6586	Pepsi 2.5L NR	Refresco Pepsi 2.5 Litros No Retornable	31	14	25.00	32.00	0	5	2026-04-15 00:00:00
6587	Pepsi 3L NR	Refresco Pepsi 3 Litros No Retornable	31	14	28.00	36.00	0	5	2026-04-15 00:00:00
6588	Queso manchego Lala 200g	Queso Manchego Lala 200 gramos	16	4	50.00	60.00	100	10	2026-04-15 00:00:00
6589	Jumex Lata 335ml Mango	Jugo de Mango en Lata 335ml	31	21	10.00	14.00	0	5	2026-04-15 00:00:00
6590	Jumex Lata 335ml Manzana	Jugo de Manzana en Lata 335ml	31	21	10.00	14.00	0	5	2026-04-15 00:00:00
6591	Jarritos Mandarina 600ml	Refresco sabor Mandarina 600ml	31	58	10.00	14.00	0	5	2026-04-15 00:00:00
6592	Florentinas gamesa	None	29	46	8.00	10.50	100	10	2026-04-15 00:00:00
6593	Marias doradas	None	29	46	8.00	10.50	100	10	2026-04-15 00:00:00
6594	Gamesa cajeta	None	29	46	8.00	10.50	100	10	2026-04-15 00:00:00
6595	Maravillas gamesa	None	29	46	8.00	10.50	100	10	2026-04-15 00:00:00
6596	Crackets gamesa	None	29	46	8.00	10.50	100	10	2026-04-15 00:00:00
6597	Surtido rico gamesa	None	29	46	8.00	10.50	100	10	2026-04-15 00:00:00
6598	Delicias gamesa	None	29	46	8.00	10.50	100	10	2026-04-15 00:00:00
6599	Oreo	None	9	58	8.00	10.50	100	10	2026-04-15 00:00:00
6600	Principe chocolate	None	9	22	8.00	10.50	100	10	2026-04-15 00:00:00
6601	Principe vainilla	None	9	22	8.00	10.50	100	10	2026-04-15 00:00:00
6602	Principe limon	None	9	22	8.00	10.50	100	10	2026-04-15 00:00:00
6603	Principe chocolate blanco	None	9	22	8.00	10.50	100	10	2026-04-15 00:00:00
6604	Lors	None	9	22	8.00	10.50	100	10	2026-04-15 00:00:00
6605	Plativolos	None	9	22	8.00	10.50	100	10	2026-04-15 00:00:00
6606	Sponch	None	9	22	8.00	10.50	100	10	2026-04-15 00:00:00
6607	Triki trakes	None	9	22	8.00	10.50	100	10	2026-04-15 00:00:00
6608	MaxiTubo Triki trakes	None	9	22	8.00	10.50	100	10	2026-04-15 00:00:00
6609	Gansito	None	9	22	8.00	10.50	100	10	2026-04-15 00:00:00
6610	Pinguinos	None	9	22	8.00	10.50	100	10	2026-04-15 00:00:00
6611	Pasticetas marinela	None	9	22	8.00	10.50	100	10	2026-04-15 00:00:00
6612	Barritas fresa	None	9	22	8.00	10.50	100	10	2026-04-15 00:00:00
6613	Barritas pina	None	9	22	8.00	10.50	100	10	2026-04-15 00:00:00
6614	Barritas moras	None	9	22	8.00	10.50	100	10	2026-04-15 00:00:00
6615	Maxitubo Barritas pina	None	9	22	8.00	10.50	100	10	2026-04-15 00:00:00
6616	Canelitas	None	9	22	8.00	10.50	100	10	2026-04-15 00:00:00
6617	Polvorones	None	9	22	8.00	10.50	100	10	2026-04-15 00:00:00
6618	Maxitubo Polvorones	None	9	22	8.00	10.50	100	10	2026-04-15 00:00:00
6619	Ricanelas	None	9	46	8.00	10.50	100	10	2026-04-15 00:00:00
6620	Ritz bits queso	None	9	58	8.00	10.50	100	10	2026-04-15 00:00:00
6621	Arcoiris	None	9	46	8.00	10.50	100	10	2026-04-15 00:00:00
6622	Submarinos fresa	None	9	22	8.00	10.50	100	10	2026-04-15 00:00:00
6623	Submarinos vainilla	None	9	22	8.00	10.50	100	10	2026-04-15 00:00:00
6624	Submarinos chocolate	None	9	22	8.00	10.50	100	10	2026-04-15 00:00:00
6625	Rocko chico	None	9	22	8.00	10.50	100	10	2026-04-15 00:00:00
6626	Rocko grande	None	9	22	8.00	10.50	100	10	2026-04-15 00:00:00
6627	Sabritas original	None	9	3	8.00	10.50	100	10	2026-04-15 00:00:00
6628	Sabritas adobadas	None	9	3	8.00	10.50	100	10	2026-04-15 00:00:00
6629	Sabritas limon	None	9	3	8.00	10.50	100	10	2026-04-15 00:00:00
6630	Sabritas flamin hot	None	9	3	8.00	10.50	100	10	2026-04-15 00:00:00
6631	Sabritas crema y especias	None	9	3	8.00	10.50	100	10	2026-04-15 00:00:00
6632	Sabritas habanero	None	9	3	8.00	10.50	100	10	2026-04-15 00:00:00
6633	Sabritas receta crujiente	None	9	3	8.00	10.50	100	10	2026-04-15 00:00:00
6634	Sabritas receta crujiente jalapeno	None	9	3	8.00	10.50	100	10	2026-04-15 00:00:00
6635	Crujitos	None	9	3	8.00	10.50	100	10	2026-04-15 00:00:00
6636	Papatinas	None	9	47	8.00	10.50	100	10	2026-04-15 00:00:00
6637	Doritos incognita	None	9	3	8.00	10.50	100	10	2026-04-15 00:00:00
6638	Doritos diablo	None	9	3	8.00	10.50	100	10	2026-04-15 00:00:00
6639	Doritos flamin hot	None	9	3	8.00	10.50	100	10	2026-04-15 00:00:00
6640	Doritos dinamita	None	9	3	8.00	10.50	100	10	2026-04-15 00:00:00
6641	Sabritones	None	9	3	8.00	10.50	100	10	2026-04-15 00:00:00
6642	Bigmix queso	None	9	47	8.00	10.50	100	10	2026-04-15 00:00:00
6643	Bigmix fuego	None	9	47	8.00	10.50	100	10	2026-04-15 00:00:00
6644	Cheetos torciditos	None	9	3	8.00	10.50	100	10	2026-04-15 00:00:00
6645	Cheetos bolitas	None	9	3	8.00	10.50	100	10	2026-04-15 00:00:00
6646	Cheetos queso	None	9	3	8.00	10.50	100	10	2026-04-15 00:00:00
6647	Cheetos flamin hot	None	9	3	8.00	10.50	100	10	2026-04-15 00:00:00
6648	Ruffles original	None	9	3	8.00	10.50	100	10	2026-04-15 00:00:00
6649	Ruffles queso	None	9	3	8.00	10.50	100	10	2026-04-15 00:00:00
6650	Fritos sal y limon	None	9	3	8.00	10.50	100	10	2026-04-15 00:00:00
6651	Fritos chorizo	None	9	3	8.00	10.50	100	10	2026-04-15 00:00:00
6652	Bolsaza Sabritas original	None	9	3	8.00	10.50	100	10	2026-04-15 00:00:00
6653	Bolsaza Doritos nacho	None	9	3	8.00	10.50	100	10	2026-04-15 00:00:00
6654	Paketaxo	None	9	3	8.00	10.50	100	10	2026-04-15 00:00:00
6655	Paketaxo queso	None	9	3	8.00	10.50	100	10	2026-04-15 00:00:00
6656	Paketaxo flamin hot	None	9	3	8.00	10.50	100	10	2026-04-15 00:00:00
6657	Churrumaiz	None	9	3	8.00	10.50	100	10	2026-04-15 00:00:00
6658	Churrumaiz flamin hot	None	9	3	8.00	10.50	100	10	2026-04-15 00:00:00
6659	Rancheritos	None	9	3	8.00	10.50	100	10	2026-04-15 00:00:00
6660	Sabritas switch doritos nacho	None	9	3	8.00	10.50	100	10	2026-04-15 00:00:00
6661	Runners	None	9	47	8.00	10.50	100	10	2026-04-15 00:00:00
6662	Chips jalapeno	None	9	47	8.00	10.50	100	10	2026-04-15 00:00:00
6663	Chips sal	None	9	47	8.00	10.50	100	10	2026-04-15 00:00:00
6664	Cremax fresa	None	29	46	8.00	10.50	100	10	2026-04-15 00:00:00
6665	Chips fuego	None	9	47	8.00	10.50	100	10	2026-04-15 00:00:00
6666	Palomitas pop	None	9	47	8.00	10.50	100	10	2026-04-15 00:00:00
6667	Takis original 	None	9	47	8.00	10.50	100	10	2026-04-15 00:00:00
6668	Takis fuego	None	9	47	8.00	10.50	100	10	2026-04-15 00:00:00
6669	Takis salsa brava	None	9	47	8.00	10.50	100	10	2026-04-15 00:00:00
6670	Takis guacamole	None	9	47	8.00	10.50	100	10	2026-04-15 00:00:00
6671	Chipotles	None	9	47	8.00	10.50	100	10	2026-04-15 00:00:00
6672	Tostachos	None	9	47	8.00	10.50	100	10	2026-04-15 00:00:00
6673	Hot nuts	None	9	47	8.00	10.50	100	10	2026-04-15 00:00:00
6674	Hot nuts fuego	None	9	47	8.00	10.50	100	10	2026-04-15 00:00:00
6675	Valentones	None	9	47	8.00	10.50	100	10	2026-04-15 00:00:00
6676	Watz barcel	None	9	47	8.00	10.50	100	10	2026-04-15 00:00:00
6677	Toreadas	None	9	47	8.00	10.50	100	10	2026-04-15 00:00:00
6678	Palomitas pop fuego	None	9	47	8.00	10.50	100	10	2026-04-15 00:00:00
6679	Takis blue heat	None	9	47	8.00	10.50	100	10	2026-04-15 00:00:00
6680	Doraditas tia rosa	None	29	49	8.00	10.50	100	10	2026-04-15 00:00:00
6681	Cremax chocolate	None	29	46	8.00	10.50	100	10	2026-04-15 00:00:00
6682	Doritos nacho	None	9	3	8.00	10.50	100	10	2026-04-15 00:00:00
6683	Paleta Vero mango	None	8	68	8.00	10.50	100	10	2026-04-15 00:00:00
6684	Hersheys Cookies n Cream	None	8	45	8.00	10.50	100	10	2026-04-15 00:00:00
6685	Hersheys almendras	None	8	45	8.00	10.50	100	10	2026-04-15 00:00:00
6686	Hersheys chocolate amargo	None	8	45	8.00	10.50	100	10	2026-04-15 00:00:00
6687	Hersheys chocolate blanco	None	8	45	8.00	10.50	100	10	2026-04-15 00:00:00
6688	Crunch	None	8	19	8.00	10.50	100	10	2026-04-15 00:00:00
6689	Carlos V	None	8	19	8.00	10.50	100	10	2026-04-15 00:00:00
6690	Milky way	None	8	19	8.00	10.50	100	10	2026-04-15 00:00:00
6691	Snickers	None	8	19	8.00	10.50	100	10	2026-04-15 00:00:00
6692	Kit kat	None	8	19	8.00	10.50	100	10	2026-04-15 00:00:00
6693	Kinder delice	None	8	40	8.00	10.50	100	10	2026-04-15 00:00:00
6694	Kinder sorpresa	None	8	40	8.00	10.50	100	10	2026-04-15 00:00:00
6695	Ferrero rocher 3 piezas	None	8	40	8.00	10.50	100	10	2026-04-15 00:00:00
6696	Mazapan	None	8	62	8.00	10.50	100	10	2026-04-15 00:00:00
6697	Pelon pelo rico	None	8	45	8.00	10.50	100	10	2026-04-15 00:00:00
6698	Pulparindo tamarindo	None	8	62	8.00	10.50	100	10	2026-04-15 00:00:00
6699	Pulparindo chamoy	None	8	62	8.00	10.50	100	10	2026-04-15 00:00:00
6700	Tutsi pop	None	8	65	8.00	10.50	100	10	2026-04-15 00:00:00
6701	Oblea cajeta coronado	None	8	66	8.00	10.50	100	10	2026-04-15 00:00:00
6702	Paleta payaso	None	8	67	8.00	10.50	100	10	2026-04-15 00:00:00
6703	Duvalin fresa vainilla	None	8	67	8.00	10.50	100	10	2026-04-15 00:00:00
6704	Duvalin chocolate vainilla	None	8	67	8.00	10.50	100	10	2026-04-15 00:00:00
6705	Duvalin vainilla	None	8	67	8.00	10.50	100	10	2026-04-15 00:00:00
6706	Duvalin trisabor	None	8	67	8.00	10.50	100	10	2026-04-15 00:00:00
6707	Duvalin choco avellana	None	8	67	8.00	10.50	100	10	2026-04-15 00:00:00
6708	Palomitas Act II mantequilla	None	9	58	8.00	10.50	100	10	2026-04-15 00:00:00
6709	Paleta Vero elote	None	8	67	8.00	10.50	100	10	2026-04-15 00:00:00
6710	Panditas	None	8	67	8.00	10.50	100	10	2026-04-15 00:00:00
6711	Panditas rellenos	None	8	67	8.00	10.50	100	10	2026-04-15 00:00:00
6712	Panditas san valentin	None	8	67	8.00	10.50	100	10	2026-04-15 00:00:00
6713	Bubulubu	None	8	67	8.00	10.50	100	10	2026-04-15 00:00:00
6714	Rockaleta	None	8	69	8.00	10.50	100	10	2026-04-15 00:00:00
6715	Tic tac menta	None	8	40	8.00	10.50	100	10	2026-04-15 00:00:00
6716	Tic tac naranja	None	8	40	8.00	10.50	100	10	2026-04-15 00:00:00
6717	Halls menta	None	8	58	8.00	10.50	100	10	2026-04-15 00:00:00
6718	Conchas tia rosa	None	29	49	8.00	10.50	100	10	2026-04-15 00:00:00
6719	Halls yerba buena	None	8	58	8.00	10.50	100	10	2026-04-15 00:00:00
6720	Halls miel	None	8	58	8.00	10.50	100	10	2026-04-15 00:00:00
6721	Halls negras	None	8	58	8.00	10.50	100	10	2026-04-15 00:00:00
6722	Gomilocas dientes	None	8	67	8.00	10.50	100	10	2026-04-15 00:00:00
6723	Gomilocas pinguino	None	8	67	8.00	10.50	100	10	2026-04-15 00:00:00
6724	Chocoretas	None	8	67	8.00	10.50	100	10	2026-04-15 00:00:00
6725	Kranky	None	8	67	8.00	10.50	100	10	2026-04-15 00:00:00
6726	Lucas muecas	None	8	58	8.00	10.50	100	10	2026-04-15 00:00:00
6727	Lucas chamoy	None	8	58	8.00	10.50	100	10	2026-04-15 00:00:00
6728	Lucas gusanito	None	8	58	8.00	10.50	100	10	2026-04-15 00:00:00
6729	Vinagre de manzana la coste¤a	None	1	27	8.00	10.50	100	10	2026-04-15 00:00:00
6730	Palomitas Act II natural	None	9	58	8.00	10.50	100	10	2026-04-15 00:00:00
6731	Palomitas Act II chile limon	None	9	58	8.00	10.50	100	10	2026-04-15 00:00:00
6732	Tostitos salsa verde	None	9	3	8.00	10.50	100	10	2026-04-15 00:00:00
6733	Zucaritas chicas	None	5	26	8.00	10.50	100	10	2026-04-15 00:00:00
6734	Zucaritas grandes	None	5	26	8.00	10.50	100	10	2026-04-15 00:00:00
6735	Corn flakes chicas	None	5	26	8.00	10.50	100	10	2026-04-15 00:00:00
6736	Corn flakes grandes	None	5	26	8.00	10.50	100	10	2026-04-15 00:00:00
6737	Choco Krispis chicas	None	5	26	8.00	10.50	100	10	2026-04-15 00:00:00
6738	Choco Krispis grandes	None	5	26	8.00	10.50	100	10	2026-04-15 00:00:00
6739	Nesquik chico	None	5	26	8.00	10.50	100	10	2026-04-15 00:00:00
6740	Nesquik grande	None	5	26	8.00	10.50	100	10	2026-04-15 00:00:00
6741	Froot loops chicas	None	5	26	8.00	10.50	100	10	2026-04-15 00:00:00
6742	Froot loops grandes	None	5	26	8.00	10.50	100	10	2026-04-15 00:00:00
6743	Chocomilk sobre	None	4	58	8.00	10.50	100	10	2026-04-15 00:00:00
6744	Chocomilk bolsa	None	4	58	8.00	10.50	100	10	2026-04-15 00:00:00
6745	Chocomilk lata	None	4	58	8.00	10.50	100	10	2026-04-15 00:00:00
6746	Nescafe clasico sobre	None	4	19	8.00	10.50	100	10	2026-04-15 00:00:00
6747	Nescafe capuccino sobre	None	4	19	8.00	10.50	100	10	2026-04-15 00:00:00
6748	Nescafe clasico bote chico	None	4	19	8.00	10.50	100	10	2026-04-15 00:00:00
6749	Nescafe clasico bote grande	None	4	19	8.00	10.50	100	10	2026-04-15 00:00:00
6750	Azucar Zulka 1kg	None	3	58	8.00	10.50	100	10	2026-04-15 00:00:00
6751	Azucar refinada 1kg	None	3	58	8.00	10.50	100	10	2026-04-15 00:00:00
6752	Azucar refinada 500gr	None	3	58	8.00	10.50	100	10	2026-04-15 00:00:00
6753	Azucar refinada 250gr	None	3	58	8.00	10.50	100	10	2026-04-15 00:00:00
6754	Aceite nutrioli 1lt	None	1	58	8.00	10.50	100	10	2026-04-15 00:00:00
6755	Aceite capullo 1lt	None	1	58	8.00	10.50	100	10	2026-04-15 00:00:00
6756	Aceite 1 2 3 1lt	None	1	58	8.00	10.50	100	10	2026-04-15 00:00:00
6757	Aceite patrona 1lt	None	1	58	8.00	10.50	100	10	2026-04-15 00:00:00
6758	Vinagre blanco la coste¤a	None	1	27	8.00	10.50	100	10	2026-04-15 00:00:00
6759	Catsup la coste¤a	None	1	27	8.00	10.50	100	10	2026-04-15 00:00:00
6760	Catsup Del monte	None	1	70	8.00	10.50	100	10	2026-04-15 00:00:00
6761	Catsup heinz	None	1	71	8.00	10.50	100	10	2026-04-15 00:00:00
6762	Jugo Magui	None	7	19	8.00	10.50	100	10	2026-04-15 00:00:00
6763	Salsa inglesa	None	7	19	8.00	10.50	100	10	2026-04-15 00:00:00
6764	Salsa valentina chica	None	7	58	8.00	10.50	100	10	2026-04-15 00:00:00
6765	Salsa valentina grande	None	7	58	8.00	10.50	100	10	2026-04-15 00:00:00
6766	Salsa tabasco	None	7	58	8.00	10.50	100	10	2026-04-15 00:00:00
6767	Salsa buffalo	None	7	58	8.00	10.50	100	10	2026-04-15 00:00:00
6768	Salsa chipotle la coste¤a	None	7	27	8.00	10.50	100	10	2026-04-15 00:00:00
6769	Chile chipotle la coste¤a	None	6	27	8.00	10.50	100	10	2026-04-15 00:00:00
6770	Tortillinas tia rosa	None	10	49	8.00	10.50	100	10	2026-04-15 00:00:00
6771	Halls limon	None	8	58	8.00	10.50	100	10	2026-04-15 00:00:00
6772	Mermelada mccormick fresa chica	None	19	72	8.00	10.50	100	10	2026-04-15 00:00:00
6773	Mermelada mccormick fresa grande	None	19	72	8.00	10.50	100	10	2026-04-15 00:00:00
6774	Papel higienico Suavel 4 rollos	None	37	58	8.00	10.50	100	10	2026-04-15 00:00:00
6775	Papel higienico Suavel 6 rollos	None	37	58	8.00	10.50	100	10	2026-04-15 00:00:00
6776	Toallas sanitarias Always	None	37	58	8.00	10.50	100	10	2026-04-15 00:00:00
6777	Toallas sanitarias Kotex	None	37	58	8.00	10.50	100	10	2026-04-15 00:00:00
6778	Licuado lala fresa platano	None	15	4	15.00	30.00	100	10	2026-04-15 00:00:00
6779	Licuado lala nuez	None	15	4	15.00	30.00	100	10	2026-04-15 00:00:00
6780	Flan lala	None	15	4	15.00	30.00	100	10	2026-04-15 00:00:00
6781	Margarina lala 90gr	None	15	4	15.00	30.00	100	10	2026-04-15 00:00:00
6782	Perejil ramo		21	58	3.00	5.00	5	1	2026-04-15 00:00:00
6783	Producto nuevo de prueba	Producto para ver funciones	4	4	28.00	32.50	19	5	2026-04-15 00:00:00
6784	Media Crema Nestle 190g	Media Crema para cocina 190g	15	19	13.00	18.00	0	5	2026-04-15 00:00:00
6785	Panales Huggies	None	44	58	8.00	10.50	100	10	2026-04-15 00:00:00
6786	Shampoo Head & Shoulders chico	None	39	58	8.00	10.50	100	10	2026-04-15 00:00:00
6787	Shampoo Head & Shoulders grande	None	39	58	8.00	10.50	100	10	2026-04-15 00:00:00
6788	Desodorante Axe	None	41	58	8.00	10.50	100	10	2026-04-15 00:00:00
6789	Yogurt Lala Fresa Bebible 220g	Yogurt bebible sabor Fresa 220g	17	4	9.00	13.00	0	5	2026-04-15 00:00:00
6790	Yogurt Lala Durazno Bebible 220g	Yogurt bebible sabor Durazno 220g	17	4	9.00	13.00	0	5	2026-04-15 00:00:00
6791	Yogurt Danone Fresa Batido 120g	Yogurt batido sabor Fresa 120g	17	58	7.00	10.00	0	5	2026-04-15 00:00:00
6792	Yogurt Danone Natilla Chocolate	Postre sabor Chocolate Danone	17	58	8.00	11.00	0	5	2026-04-15 00:00:00
6793	Queso Philadelphia 180g	Queso Crema Philadelphia 180g	16	58	32.00	42.00	0	5	2026-04-15 00:00:00
6794	Queso Panela La Villita 400g	Queso Panela La Villita 400g	16	58	55.00	72.00	0	5	2026-04-15 00:00:00
6795	Margarina Primavera 200g	Margarina Primavera 200g	19	58	15.00	21.00	0	5	2026-04-15 00:00:00
6796	Huevo Blanco 12 pzas	Paquete Huevo Blanco 12 piezas	14	58	30.00	38.00	0	5	2026-04-15 00:00:00
6797	Huevo Blanco 18 pzas	Paquete Huevo Blanco 18 piezas	14	23	42.00	55.00	0	5	2026-04-15 00:00:00
6798	Papas Sabritas Sal 42g	Papas fritas con sal 42g	9	3	13.50	18.00	0	5	2026-04-15 00:00:00
6799	Cloralex 1/2 lt	None	35	58	8.00	10.50	100	10	2026-04-15 00:00:00
6800	Leche Condensada La Lechera 375g	Leche Condensada Clasica 375g	11	19	22.00	29.00	0	5	2026-04-15 00:00:00
6801	Yogurt Yoplait natural 1L	Yogurt Yoplait natural 1 Litro	17	54	26.00	31.00	100	10	2026-04-15 00:00:00
6802	Yomi lala chocolate	None	15	4	15.00	30.00	100	10	2026-04-15 00:00:00
6803	Cremax vainilla	None	29	46	8.00	10.50	100	10	2026-04-15 00:00:00
6804	Maxitubo Barritas fresa	None	9	22	8.00	10.50	100	10	2026-04-15 00:00:00
6805	Bigote tia rosa	None	29	49	8.00	10.50	100	10	2026-04-15 00:00:00
6806	Magdalenas tia rosa	None	29	49	8.00	10.50	100	10	2026-04-15 00:00:00
6807	Chiles serranos la coste¤a	None	6	27	8.00	10.50	100	10	2026-04-15 00:00:00
6808	Chiles en vinagre la coste¤a	None	6	27	8.00	10.50	100	10	2026-04-15 00:00:00
6809	Chile chipotle la morena	None	6	72	8.00	10.50	100	10	2026-04-15 00:00:00
6810	Chiles en vinagre la morena	None	6	72	8.00	10.50	100	10	2026-04-15 00:00:00
6811	Mayonesa mccormick chica	None	7	72	8.00	10.50	100	10	2026-04-15 00:00:00
6812	Mayonesa mccormick grande	None	7	72	8.00	10.50	100	10	2026-04-15 00:00:00
6813	Mostaza mccormick	None	7	72	8.00	10.50	100	10	2026-04-15 00:00:00
6814	Cloralex 1 lt	None	35	58	8.00	10.50	100	10	2026-04-15 00:00:00
6815	Pinol	None	35	58	8.00	10.50	100	10	2026-04-15 00:00:00
6816	Fabuloso lavanda 1lt	None	35	58	8.00	10.50	100	10	2026-04-15 00:00:00
6817	Fabuloso aroma floral 1lt	None	35	58	8.00	10.50	100	10	2026-04-15 00:00:00
6818	Papas Sabritas Adobadas 42g	Papas fritas adobadas 42g	9	3	13.50	18.00	0	5	2026-04-15 00:00:00
6819	Papas Sabritas Limon 42g	Papas fritas con limon 42g	9	3	13.50	18.00	0	5	2026-04-15 00:00:00
6820	Doritos Nacho 61g	Botana de maiz sabor Queso 61g	9	3	13.00	18.00	0	5	2026-04-15 00:00:00
6821	Doritos Pizzerola 61g	Botana de maiz sabor Pizza 61g	9	3	13.00	18.00	0	5	2026-04-15 00:00:00
6822	Jabon zote rosa chico	None	42	58	8.00	10.50	100	10	2026-04-15 00:00:00
6823	Jabon zote rosa grande	None	42	58	8.00	10.50	100	10	2026-04-15 00:00:00
6824	Jabon zote blanco chico	None	42	58	8.00	10.50	100	10	2026-04-15 00:00:00
6825	Jabon zote blanco grande	None	42	58	8.00	10.50	100	10	2026-04-15 00:00:00
6826	Detergente Ariel 1/2 kg	None	34	58	8.00	10.50	100	10	2026-04-15 00:00:00
6827	Detergente Ariel 1kg	None	34	58	8.00	10.50	100	10	2026-04-15 00:00:00
6828	Detergente Ace 1/2 kg	None	34	58	8.00	10.50	100	10	2026-04-15 00:00:00
6829	Detergente Ace 1kg	None	34	58	8.00	10.50	100	10	2026-04-15 00:00:00
6830	Detergente Foca 1/2 kg	None	34	58	8.00	10.50	100	10	2026-04-15 00:00:00
6831	Detergente Foca 1kg	None	34	58	8.00	10.50	100	10	2026-04-15 00:00:00
6832	Suavitel 1l	None	34	58	8.00	10.50	100	10	2026-04-15 00:00:00
6833	Yomi lala vainilla	None	15	4	15.00	30.00	100	10	2026-04-15 00:00:00
6834	Yomi lala fresa	None	15	4	15.00	30.00	100	10	2026-04-15 00:00:00
6835	Yogurt lala fresa	None	15	4	15.00	30.00	100	10	2026-04-15 00:00:00
6836	Yogurt lala durazno	None	15	4	15.00	30.00	100	10	2026-04-15 00:00:00
6837	Yogurt bebible lala manzana	None	15	4	15.00	30.00	100	10	2026-04-15 00:00:00
6838	Yogurt Lala Manzana Bebible 220g	Yogurt bebible sabor Manzana 220g	17	4	9.00	13.00	0	5	2026-04-15 00:00:00
6839	Yogurt bebible lala durazno	None	15	4	15.00	30.00	100	10	2026-04-15 00:00:00
6840	Yogurt bebible lala fresa	None	15	4	15.00	30.00	100	10	2026-04-15 00:00:00
6841	Yogurt bebible lala moras	None	15	4	15.00	30.00	100	10	2026-04-15 00:00:00
6842	Yogurt bebible lala pina coco	None	15	4	15.00	30.00	100	10	2026-04-15 00:00:00
6843	Cheetos Torciditos 52g	Botana de maiz sabor Queso y Chile 52g	9	3	10.00	14.00	0	5	2026-04-15 00:00:00
6844	Papel higienico Petalo 4 rollos	None	37	58	8.00	10.50	100	10	2026-04-15 00:00:00
6845	Papel higienico Petalo 6 rollos	None	37	58	8.00	10.50	100	10	2026-04-15 00:00:00
6846	Cheetos Colmillos 27g	Botana de maiz sabor Queso y Chile 27g	9	3	6.00	9.00	0	5	2026-04-15 00:00:00
6847	Yogurt lala manzana	None	15	4	15.00	30.00	100	10	2026-04-15 00:00:00
6848	Mantequilla Gloria 90g	Mantequilla Gloria con Sal 90g	19	58	18.00	24.00	0	5	2026-04-15 00:00:00
6849	Ruffles Queso 50g	Papas onduladas sabor Queso 50g	9	3	13.50	18.00	0	5	2026-04-15 00:00:00
6850	Tostitos Verdes 65g	Botana de maiz sabor Salsa Verde 65g	9	3	13.00	18.00	0	5	2026-04-15 00:00:00
6851	Takis Fuego 65g	Botana de maiz sabor Fuego 65g	9	58	12.00	17.00	0	5	2026-04-15 00:00:00
6852	Chips Sal de Mar 42g	Papas fritas con Sal de Mar 42g	9	58	14.00	19.00	0	5	2026-04-15 00:00:00
6853	Cacahuates Sabritas Japones 45g	Cacahuates estilo Japones 45g	9	3	9.00	12.00	0	5	2026-04-15 00:00:00
6854	Cacahuates Sabritas Enchilados 45g	Cacahuates Enchilados 45g	9	3	9.00	12.00	0	5	2026-04-15 00:00:00
6855	Galletas Emperador Chocolate Tubo	Galletas sandwich sabor Chocolate	9	46	13.00	18.00	0	5	2026-04-15 00:00:00
6856	Galletas Emperador Vainilla Tubo	Galletas sandwich sabor Vainilla	9	46	13.00	18.00	0	5	2026-04-15 00:00:00
6857	Galletas Marias Gamesa 144g	Galletas tipo Maria 144g	9	46	11.00	15.00	0	5	2026-04-15 00:00:00
6858	Galletas Chokis Clasica 63g	Galletas con chispas de chocolate 63g	9	46	12.00	16.00	0	5	2026-04-15 00:00:00
6859	Galletas Saladitas Gamesa 137g	Galletas saladas 137g	9	46	14.00	19.00	0	5	2026-04-15 00:00:00
6860	Galletas Ritz Tubo 89g	Galletas saladas Ritz 89g	9	58	11.00	15.00	0	5	2026-04-15 00:00:00
6861	Galletas Oreo 6 pzas	Galletas sandwich sabor Chocolate 6 pzas	9	58	11.00	15.00	0	5	2026-04-15 00:00:00
6862	Barritas Marinela Fresa 67g	Galletas rellenas de Fresa 67g	29	22	12.00	16.00	0	5	2026-04-15 00:00:00
6863	Barritas Marinela Pina 67g	Galletas rellenas de Pina 67g	29	22	12.00	16.00	0	5	2026-04-15 00:00:00
6864	Canelitas Marinela Tubo	Galletas sabor Canela	29	22	13.00	18.00	0	5	2026-04-15 00:00:00
6865	Triki-Trakes Marinela Tubo	Galletas con chispas de chocolate	29	22	13.00	18.00	0	5	2026-04-15 00:00:00
6866	Pinguinos Marinela 2 pzas	Pastelitos sabor Chocolate 2 pzas	29	22	15.00	21.00	0	5	2026-04-15 00:00:00
6867	Choco Roles Marinela 2 pzas	Pastelitos con chocolate y piña 2 pzas	29	22	15.00	21.00	0	5	2026-04-15 00:00:00
6868	Gansito Marinela 50g	Pastelito cubierto de chocolate 50g	29	22	12.00	17.00	0	5	2026-04-15 00:00:00
6869	Panque Bimbo Nuez	Panque con trozos de nuez	29	17	35.00	48.00	0	5	2026-04-15 00:00:00
6870	Detergente Roma 1kg	Detergente multiusos en polvo 1kg	34	33	28.00	36.00	0	5	2026-04-15 00:00:00
6871	Detergente Roma 500g	Detergente multiusos en polvo 500g	34	33	15.00	20.00	0	5	2026-04-15 00:00:00
6872	Detergente Foca 1kg	Detergente biodegradable en polvo 1kg	34	33	30.00	38.00	0	5	2026-04-15 00:00:00
6873	Detergente Blanca Nieves 1kg	Detergente en polvo para ropa 1kg	34	33	29.00	37.00	0	5	2026-04-15 00:00:00
6874	Jabon Zote Rosa 400g	Jabon de lavanderia Rosa 400g	33	33	18.00	24.00	0	5	2026-04-15 00:00:00
6875	Jabon Zote Blanco 400g	Jabon de lavanderia Blanco 400g	33	33	18.00	24.00	0	5	2026-04-15 00:00:00
6876	Jabon Zote Azul 400g	Jabon de lavanderia Azul 400g	33	33	18.00	24.00	0	5	2026-04-15 00:00:00
6877	Suavitel Primavera 850ml	Suavizante de telas Primavera 850ml	32	32	20.00	28.00	0	5	2026-04-15 00:00:00
6878	Fabuloso Lavanda 1L	Limpiador multiusos Lavanda 1L	35	30	22.00	30.00	0	5	2026-04-15 00:00:00
6879	Pinol Original 1L	Limpiador desinfectante de Pino 1L	35	58	24.00	32.00	0	5	2026-04-15 00:00:00
6880	Cloralex El Rendidor 950ml	Blanqueador desinfectante 950ml	35	58	14.00	19.00	0	5	2026-04-15 00:00:00
6881	Axion Liquido Limon 400ml	Lavatrastes liquido Limon 400ml	34	30	18.00	25.00	0	5	2026-04-15 00:00:00
6882	Jabon Palmolive Neutro 150g	Jabon de tocador Neutro 150g	41	31	12.00	17.00	0	5	2026-04-15 00:00:00
6883	Jabon Zest Frescura 150g	Jabon de tocador Zest 150g	41	58	12.00	17.00	0	5	2026-04-15 00:00:00
6884	Pasta Colgate Triple Accion 75ml	Pasta dental Triple Accion 75ml	38	30	14.00	20.00	0	5	2026-04-15 00:00:00
6885	Pasta Colgate Total 12 100ml	Pasta dental Total 12 100ml	38	30	28.00	38.00	0	5	2026-04-15 00:00:00
6886	Shampoo Savile Biotina 750ml	Shampoo con Biotina y Sábila 750ml	35	58	32.00	45.00	0	5	2026-04-15 00:00:00
6887	Shampoo Pantene Restauracion 400ml	Shampoo Restauracion 400ml	35	35	45.00	62.00	0	5	2026-04-15 00:00:00
6888	Papel Regio Aires Frescura 4 rollos	Papel Higienico Regio 4 rollos	43	29	22.00	30.00	0	5	2026-04-15 00:00:00
6889	Papel Petalo Rendimax 4 rollos	Papel Higienico Petalo 4 rollos	43	29	20.00	28.00	0	5	2026-04-15 00:00:00
6890	Aceite Nutrioli 850ml	Aceite puro de Soya 850ml	1	58	32.00	42.00	0	5	2026-04-15 00:00:00
6891	Aceite 1-2-3 1L	Aceite vegetal 1-2-3 1 Litro	1	58	35.00	45.00	0	5	2026-04-15 00:00:00
6892	Arroz Verde Valle 900g	Arroz Super Extra Verde Valle 900g	2	58	24.00	32.00	0	5	2026-04-15 00:00:00
6893	Frijol Negro Verde Valle 900g	Frijol Negro Verde Valle 900g	2	58	38.00	48.00	0	5	2026-04-15 00:00:00
6894	Spaghetti La Moderna 200g	Pasta tipo Spaghetti 200g	2	44	7.50	11.00	0	5	2026-04-15 00:00:00
6895	Codo No. 2 La Moderna 200g	Pasta tipo Codo 200g	2	44	7.50	11.00	0	5	2026-04-15 00:00:00
6896	Fideo No. 0 La Moderna 200g	Pasta tipo Fideo 200g	2	44	7.50	11.00	0	5	2026-04-15 00:00:00
6897	Atun Herdez en Agua 130g	Atun en hojuelas Agua 130g	6	20	14.00	20.00	0	5	2026-04-15 00:00:00
6898	Atun Dolores en Aceite 130g	Atun en hojuelas Aceite 130g	6	51	15.00	21.00	0	5	2026-04-15 00:00:00
6899	Chiles Jalapenos La Costena 220g	Chiles en Vinagre Rajitas 220g	6	27	10.00	14.00	0	5	2026-04-15 00:00:00
6900	Chiles Chipotles La Costena 105g	Chiles Chipotles en Adobo 105g	6	27	9.00	13.00	0	5	2026-04-15 00:00:00
6901	Elotes Dorados Herdez 220g	Granos de Elote Dulce 220g	6	20	11.00	16.00	0	5	2026-04-15 00:00:00
6902	Mayonesa McCormick Limon 190g	Mayonesa con Limon McCormick 190g	12	72	16.00	22.00	0	5	2026-04-15 00:00:00
6903	Mayonesa McCormick Limon 390g	Mayonesa con Limon McCormick 390g	12	72	35.00	45.00	0	5	2026-04-15 00:00:00
6904	Salsa Catsup Del Monte 320g	Salsa de Tomate Catsup 320g	12	58	13.00	18.00	0	5	2026-04-15 00:00:00
6905	Salsa Valentina Amarilla 370ml	Salsa picante Valentina 370ml	12	58	11.00	16.00	0	5	2026-04-15 00:00:00
6906	Cafe Nescafe Clasico 42g	Cafe Soluble Nescafe Clasico 42g	44	19	28.00	38.00	0	5	2026-04-15 00:00:00
6907	Cafe Nescafe Clasico 120g	Cafe Soluble Nescafe Clasico 120g	44	19	65.00	85.00	0	5	2026-04-15 00:00:00
6908	Chocolate Abuelita 90g	Tablilla Chocolate Abuelita 90g	8	19	14.00	20.00	0	5	2026-04-15 00:00:00
6909	Harina Maseca 1kg	Harina de Maiz Nixtamalizado 1kg	10	59	16.00	22.00	0	5	2026-04-15 00:00:00
6910	Harina de Trigo San Antonio 1kg	Harina de Trigo para pan 1kg	10	41	15.00	20.00	0	5	2026-04-15 00:00:00
6911	Azucar Estandar 1kg	Azucar Morena en bolsa 1kg	3	58	22.00	30.00	0	5	2026-04-15 00:00:00
6912	Sal de Mesa La Fina 1kg	Sal yodada La Fina 1kg	13	58	13.00	18.00	0	5	2026-04-15 00:00:00
6913	Consome Knorr Suiza 8 cubos	Sazonador de Pollo en Cubos	13	58	12.00	17.00	0	5	2026-04-15 00:00:00
6914	Pan Blanco Bimbo Gde 680g	Pan de Caja Blanco Grande Bimbo	27	17	35.00	46.00	0	5	2026-04-15 00:00:00
6915	Pan Integral Bimbo Gde 675g	Pan de Caja Integral Grande Bimbo	27	17	38.00	50.00	0	5	2026-04-15 00:00:00
6916	Tostadas Charras Amarillas 300g	Tostadas de Maiz Charras 300g	5	60	22.00	30.00	0	5	2026-04-15 00:00:00
6917	Tostadas Sanissimo Horneadas 20 pzas	Tostadas Horneadas Sanissimo	5	61	25.00	35.00	0	5	2026-04-15 00:00:00
6918	Corn Flakes Kelloggs 500g	Cereal de Maiz Corn Flakes 500g	5	26	38.00	52.00	0	5	2026-04-15 00:00:00
6919	Zucaritas Kelloggs 600g	Cereal de Maiz con Azucar 600g	5	26	45.00	60.00	0	5	2026-04-15 00:00:00
6920	Choco Krispis Kelloggs 600g	Cereal de Arroz con Chocolate 600g	5	26	45.00	60.00	0	5	2026-04-15 00:00:00
6921	Avena Quaker Instantanea 400g	Avena con Proteina Quaker 400g	25	25	28.00	38.00	0	5	2026-04-15 00:00:00
6922	Barritas Quaker Fresa 6 pzas	Barras de Avena con Fresa	25	25	22.00	30.00	0	5	2026-04-15 00:00:00
6923	Trident Menta 12 pzas	Goma de mascar sin azucar Menta	8	58	10.00	15.00	0	5	2026-04-15 00:00:00
6924	Trident Yerba Buena 12 pzas	Goma de mascar sin azucar Yerba Buena	8	58	10.00	15.00	0	5	2026-04-15 00:00:00
6925	Chicles Canels 4 pastillas	Goma de mascar Canels caja chica	8	62	1.50	3.00	0	5	2026-04-15 00:00:00
6926	Bubbaloo Fresa 1 pza	Chicle con relleno liquido Fresa	8	58	1.50	3.00	0	5	2026-04-15 00:00:00
6927	Bubbaloo Blue 1 pza	Chicle con relleno liquido Mora Azul	8	58	1.50	3.00	0	5	2026-04-15 00:00:00
6928	Carlos V Stick Chocolate	Barra de chocolate Carlos V chocolate	8	19	5.00	8.00	0	5	2026-04-15 00:00:00
6929	Crunch Stick Chocolate	Barra de chocolate con arroz inflado	8	19	5.00	8.00	0	5	2026-04-15 00:00:00
6930	Kinder Delice 39g	Pastelito relleno Kinder Delice	8	40	12.00	17.00	0	5	2026-04-15 00:00:00
6931	Kinder Sorpresa 20g	Huevo de chocolate con juguete	8	40	18.00	26.00	0	5	2026-04-15 00:00:00
6932	Ferrero Rocher 3 pzas	Bombones cubiertos de nuez Ferrero	8	40	25.00	35.00	0	5	2026-04-15 00:00:00
6933	Hersheys Cookies n Cream 40g	Barra chocolate blanco con galleta	8	45	11.00	16.00	0	5	2026-04-15 00:00:00
6934	Mazapan de la Rosa 28g	Dulce de cacahuate Mazapan	8	62	4.00	7.00	0	5	2026-04-15 00:00:00
6935	Pulparindo Clasico 14g	Dulce de tamarindo con chile	8	62	3.00	5.00	0	5	2026-04-15 00:00:00
6936	Pelon Pelo Rico 30g	Dulce de tamarindo suave	8	45	7.00	11.00	0	5	2026-04-15 00:00:00
6937	Paleta Payaso 45g	Malvavisco con chocolate y gomitas	8	67	12.00	18.00	0	5	2026-04-15 00:00:00
6938	Duvalin Trisabor 15g	Dulce de avellana, fresa y vainilla	8	67	3.00	5.00	0	5	2026-04-15 00:00:00
6939	Rockaleta Paleta 24g	Paleta con capas de chile y goma	8	69	4.50	8.00	0	5	2026-04-15 00:00:00
6940	Halls Mentol 9 pastillas	Pastillas refrescantes Mentol	8	58	8.00	12.00	0	5	2026-04-15 00:00:00
6941	Skwinkles Rellenos Pina	Dulce de chamoy relleno pina	8	45	9.00	14.00	0	5	2026-04-15 00:00:00
6942	Lucas Muecas Chamoy	Caramelo con polvo de chamoy	8	45	10.00	15.00	0	5	2026-04-15 00:00:00
6943	Tutsi Pop 1 pza	Paleta rellena de chicle	8	65	4.50	8.00	0	5	2026-04-15 00:00:00
6944	Agua Bonafont 600ml	Agua ligera Bonafont 600ml	30	55	8.00	12.00	0	5	2026-04-15 00:00:00
6945	Agua Bonafont 1.5L	Agua ligera Bonafont 1.5 Litros	30	55	12.00	17.00	0	5	2026-04-15 00:00:00
6946	Agua Bonafont 2L	Agua ligera Bonafont 2 Litros	30	55	14.00	20.00	0	5	2026-04-15 00:00:00
6947	Agua Mineral Topo Chico 600ml	Agua mineral de manantial 600ml	31	16	15.00	21.00	0	5	2026-04-15 00:00:00
6948	Vitamin Water Energy 500ml	Bebida vitaminada sabor Tropical	31	16	22.00	32.00	0	5	2026-04-15 00:00:00
6949	Monster Energy 473ml	Bebida energetizante original	31	16	30.00	42.00	0	5	2026-04-15 00:00:00
6950	Red Bull 250ml	Bebida energetizante original	31	58	32.00	45.00	0	5	2026-04-15 00:00:00
6951	Clight Jamaica 1 pza	Polvo para preparar bebida 7g	31	58	3.50	6.00	0	5	2026-04-15 00:00:00
6952	Clight Limon 1 pza	Polvo para preparar bebida 7g	31	58	3.50	6.00	0	5	2026-04-15 00:00:00
6953	Tang Naranja 1 pza	Polvo para preparar bebida 13g	31	58	3.50	6.00	0	5	2026-04-15 00:00:00
6954	Tang Pina 1 pza	Polvo para preparar bebida 13g	31	58	3.50	6.00	0	5	2026-04-15 00:00:00
6955	Zuko Horchata 1 pza	Polvo para preparar bebida 15g	31	58	3.50	6.00	0	5	2026-04-15 00:00:00
6956	Jamon de Pavo Fud 500g	Jamon de Pavo paq. 500g	18	53	65.00	85.00	0	5	2026-04-15 00:00:00
6957	Salchicha Viena Fud 500g	Salchicha de Pavo Viena 500g	18	53	42.00	58.00	0	5	2026-04-15 00:00:00
6958	Tocino Fud 250g	Tocino Ahumado de Pavo 250g	18	53	48.00	65.00	0	5	2026-04-15 00:00:00
6959	Salchicha Asar Chimex 800g	Salchicha roja para asar 800g	18	58	75.00	95.00	0	5	2026-04-15 00:00:00
6960	Chorizo de Pavo Fud 200g	Chorizo de Pavo paq. 200g	18	53	22.00	32.00	0	5	2026-04-15 00:00:00
6961	Papas Sabritas Habanero 42g	Papas fritas sabor Habanero 42g	9	3	13.50	18.00	0	5	2026-04-15 00:00:00
6962	Doritos Dinamita 61g	Botana enrollada sabor Chile y Limon	9	3	13.00	18.00	0	5	2026-04-15 00:00:00
6963	Ruffles Mezcla Brava 50g	Papas con botanas mixtas 50g	9	3	14.00	19.00	0	5	2026-04-15 00:00:00
6964	Papas Sabritas Crema y Especias 42g	Papas fritas sabor Crema y Especias	9	3	13.50	18.00	0	5	2026-04-15 00:00:00
6965	Doritos Flamin Hot 61g	Botana de maiz sabor Picante 61g	9	3	13.00	18.00	0	5	2026-04-15 00:00:00
6966	Churrumais con Limon 60g	Fritura de maiz sabor Limon 60g	9	3	8.00	11.00	0	5	2026-04-15 00:00:00
6967	Crujitos Queso y Chile 60g	Botana de maiz en espiral Queso	9	3	11.00	15.00	0	5	2026-04-15 00:00:00
6968	Rancheritos 60g	Botana de maiz sabor Chile y Especias	9	3	11.00	15.00	0	5	2026-04-15 00:00:00
6969	Sabritones 160g	Botana de trigo con Chile y Limon	9	3	18.00	25.00	0	5	2026-04-15 00:00:00
6970	Paketaxo Quexo 215g	Mezcla de botanas sabor Queso	9	3	35.00	48.00	0	5	2026-04-15 00:00:00
6971	Paketaxo Mezcla 215g	Mezcla de botanas variadas Sabritas	9	3	35.00	48.00	0	5	2026-04-15 00:00:00
6972	Chips Fuego 42g	Papas fritas sabor Fuego 42g	9	58	14.00	19.00	0	5	2026-04-15 00:00:00
6973	Takis Blue Heat 65g	Botana de maiz sabor Picante Azul	9	58	12.00	17.00	0	5	2026-04-15 00:00:00
6974	Tostachos Sal y Limon 65g	Botana de maiz tipo tostada	9	58	11.00	15.00	0	5	2026-04-15 00:00:00
6975	Palomitas Pop Sal de Mar 65g	Palomitas de maiz listas para comer	9	58	12.00	17.00	0	5	2026-04-15 00:00:00
6976	Palomitas Pop Acanaladas 65g	Palomitas de maiz sabor Queso	9	58	12.00	17.00	0	5	2026-04-15 00:00:00
6977	Galletas Oreo Chocolate 10 pzas	Galletas Oreo sabor Chocolate	9	58	14.00	19.00	0	5	2026-04-15 00:00:00
6978	Galletas Principe Marinela Tubo	Galletas con relleno de chocolate	9	22	13.50	19.00	0	5	2026-04-15 00:00:00
6979	Galletas Sponch Marinela 4 pzas	Galletas con malvavisco y coco	9	22	12.00	17.00	0	5	2026-04-15 00:00:00
6980	Galletas Polvorones Marinela Tubo	Galletas sabor Naranja	9	22	13.00	18.00	0	5	2026-04-15 00:00:00
6981	Galletas Ricanelas Marinela Tubo	Galletas sabor Canela y Azucar	29	22	13.00	18.00	0	5	2026-04-15 00:00:00
6982	Galletas Florentinas Cajeta Tubo	Galletas rellenas de cajeta	29	46	14.00	19.00	0	5	2026-04-15 00:00:00
6983	Galletas Florentinas Fresa Tubo	Galletas rellenas de fresa	29	46	14.00	19.00	0	5	2026-04-15 00:00:00
6984	Cremax de Nieve Chocolate 171g	Galletas wafer sabor Chocolate	29	46	14.00	19.00	0	5	2026-04-15 00:00:00
6985	Cremax de Nieve Fresa 171g	Galletas wafer sabor Fresa	29	46	14.00	19.00	0	5	2026-04-15 00:00:00
6986	Galletas Habaneras Integrales 117g	Galletas de harina integral	9	46	11.00	16.00	0	5	2026-04-15 00:00:00
6987	Galletas Habaneras Clasicas 117g	Galletas saladas crujientes	9	46	11.00	16.00	0	5	2026-04-15 00:00:00
6988	Galletas Crackets Tubo 95g	Galletas saladas horneadas Crackets	9	46	11.00	16.00	0	5	2026-04-15 00:00:00
6989	Galletas Mamut 44g	Galleta con malvavisco y chocolate	9	46	10.00	14.00	0	5	2026-04-15 00:00:00
6990	Galletas Giros Gamesa 100g	Galletas sandwich sabor chocolate	9	46	12.00	17.00	0	5	2026-04-15 00:00:00
6991	Galletas Senzo Chocolate 60g	Galletas rellenas de chocolate	9	46	11.00	16.00	0	5	2026-04-15 00:00:00
6992	Galletas Habaneras Integrales Tubo	Galletas saladas integrales tubo	9	46	13.00	18.00	0	5	2026-04-15 00:00:00
6993	Galletas Marias Doradas Gamesa	Galletas tipo maria doradas tubo	9	46	13.00	18.00	0	5	2026-04-15 00:00:00
6994	Galletas Piruetas Gamesa Tubo	Galletas sandwich limon tubo	9	46	13.50	19.00	0	5	2026-04-15 00:00:00
6995	Galletas Emperador Piruetas 6 pzas	Galletas sandwich sabor limon	9	46	11.00	15.00	0	5	2026-04-15 00:00:00
6996	Galletas Oreo Mini Copa 45g	Galletas mini oreo en vaso	9	58	12.50	17.00	0	5	2026-04-15 00:00:00
6997	Galletas Ritz Sándwich Queso	Galletas ritz rellenas de queso	9	58	11.00	15.00	0	5	2026-04-15 00:00:00
6998	Galletas Maravillas Vainilla	Galletas sabor vainilla Gamesa	9	46	11.50	16.00	0	5	2026-04-15 00:00:00
6999	Barras de Coco Gamesa	Galletas con trozos de coco	9	46	11.50	16.00	0	5	2026-04-15 00:00:00
7000	Hot Nuts Original 50g	Cacahuates con cobertura picante	9	58	9.50	13.00	0	5	2026-04-15 00:00:00
7001	Hot Nuts Fuego 50g	Cacahuates con cobertura extra picante	9	58	9.50	13.00	0	5	2026-04-15 00:00:00
7002	Big Mix Clasico 50g	Mezcla de botanas Barcel	9	58	11.50	16.00	0	5	2026-04-15 00:00:00
7003	Big Mix Fuego 50g	Mezcla de botanas picantes Barcel	9	58	11.50	16.00	0	5	2026-04-15 00:00:00
7004	Karameladas de Maiz 60g	Palomitas con caramelo Barcel	9	58	12.00	17.00	0	5	2026-04-15 00:00:00
7005	Runners 60g	Botana de maiz sabor picante	9	58	11.00	15.00	0	5	2026-04-15 00:00:00
7006	Takis Original 65g	Botana de maiz enrollada taco	9	58	12.00	17.00	0	5	2026-04-15 00:00:00
7007	Chips Jalapeno 42g	Papas fritas sabor jalapeno	9	58	14.50	20.00	0	5	2026-04-15 00:00:00
7008	Chips Chipotle 42g	Papas fritas sabor chipotle	9	58	14.50	20.00	0	5	2026-04-15 00:00:00
7009	Donitas Totis Sal y Limon 25g	Botana de trigo en aros	9	58	4.00	6.00	0	5	2026-04-15 00:00:00
7010	Donitas Totis Hot 25g	Botana de trigo picante	9	58	4.00	6.00	0	5	2026-04-15 00:00:00
7011	Que活os Barcel 60g	Botana de maiz sabor queso	9	58	11.00	15.00	0	5	2026-04-15 00:00:00
7012	Tostachos Queso 65g	Botana de maiz sabor queso	9	58	11.00	15.00	0	5	2026-04-15 00:00:00
7013	Cacahuates Mafer Salados 65g	Cacahuates premium con sal	9	3	16.00	22.00	0	5	2026-04-15 00:00:00
7014	Cacahuates Mafer Japones 65g	Cacahuates premium japones	9	3	16.00	22.00	0	5	2026-04-15 00:00:00
7015	Bubu Lubu Ricolino 35g	Malvavisco con jalea y chocolate	8	67	9.00	13.00	0	5	2026-04-15 00:00:00
7016	Kranky Ricolino 40g	Hojuelas de maiz con chocolate	8	67	9.50	14.00	0	5	2026-04-15 00:00:00
7017	Chocoretas Ricolino 45g	Bolitas de menta con chocolate	8	67	9.50	14.00	0	5	2026-04-15 00:00:00
7018	Gomitas Panditas Clasicos 45g	Gomitas de ositos frutales	8	67	11.00	15.00	0	5	2026-04-15 00:00:00
7019	Gomitas Panditas Enchilados 45g	Gomitas de ositos con chile	8	67	11.00	15.00	0	5	2026-04-15 00:00:00
7020	Dulce Gudupop Azul 1 pza	Paleta de caramelo suave	8	69	3.50	5.00	0	5	2026-04-15 00:00:00
7021	Gudu Cubos 1 pza	Caramelo suave de sabores	8	69	1.50	3.00	0	5	2026-04-15 00:00:00
7022	Milky Way Chocolate 48g	Barra de chocolate y caramelo	8	58	14.00	20.00	0	5	2026-04-15 00:00:00
7023	Snickers Chocolate 48g	Barra de chocolate, nuez y caramelo	8	58	14.00	20.00	0	5	2026-04-15 00:00:00
7024	M&Ms Chocolate 43g	Botones de chocolate con leche	8	58	14.00	20.00	0	5	2026-04-15 00:00:00
7025	M&Ms Cacahuate 43g	Botones de chocolate con cacahuate	8	58	14.00	20.00	0	5	2026-04-15 00:00:00
7026	Conejos Turin 20g	Chocolate con leche figura conejo	8	58	11.00	16.00	0	5	2026-04-15 00:00:00
7027	Bocadin Chocolate 1 pza	Galleta cubierta de chocolate	8	62	1.50	3.00	0	5	2026-04-15 00:00:00
7028	Mazapan de la Rosa Gigante 50g	Dulce de cacahuate grande	8	62	7.00	11.00	0	5	2026-04-15 00:00:00
7029	Pulparindo Extra Picante 14g	Dulce de tamarindo muy picante	8	62	3.50	5.00	0	5	2026-04-15 00:00:00
7030	Pulparindo Sandia 14g	Dulce de tamarindo sabor sandia	8	62	3.50	5.00	0	5	2026-04-15 00:00:00
7031	Lucas Gusano Chamoy 36g	Dulce liquido sabor chamoy	8	45	10.00	15.00	0	5	2026-04-15 00:00:00
7032	Lucas Bomvaso Limon 30g	Caramelo con polvo picante	8	45	10.50	15.00	0	5	2026-04-15 00:00:00
7033	Pica Fresa Gigante 1 pza	Gomita con chile sabor fresa	8	58	1.50	3.00	0	5	2026-04-15 00:00:00
7034	Pelon Pelo Rico Gigante 35g	Dulce de tamarindo grande	8	45	10.00	15.00	0	5	2026-04-15 00:00:00
7035	Skwinkles Clasicos Chamoy 26g	Tiras de dulce con chile	8	45	10.00	15.00	0	5	2026-04-15 00:00:00
7036	Kinder Chocolate 4 barras	Barritas de chocolate con leche	8	40	18.00	26.00	0	5	2026-04-15 00:00:00
7037	Halls Yerba Buena 9 pzas	Pastillas refrescantes yerbabuena	8	58	8.50	13.00	0	5	2026-04-15 00:00:00
7038	Halls Cereza 9 pzas	Pastillas refrescantes sabor cereza	8	58	8.50	13.00	0	5	2026-04-15 00:00:00
7039	Clorets 2 pastillas	Goma de mascar con clorofila	8	58	1.50	3.00	0	5	2026-04-15 00:00:00
7040	Shampoo Sedal Ceramidas 620ml	Shampoo para brillo y fuerza	35	34	42.00	58.00	0	5	2026-04-15 00:00:00
7041	Shampoo Sedal Restauracion 620ml	Shampoo para cabello danado	35	34	42.00	58.00	0	5	2026-04-15 00:00:00
7042	Shampoo Head & Shoulders Limpieza 375ml	Shampoo anticaspa original	35	58	55.00	75.00	0	5	2026-04-15 00:00:00
7043	Shampoo Head & Shoulders Mentol 375ml	Shampoo anticaspa mentolado	35	58	55.00	75.00	0	5	2026-04-15 00:00:00
7044	Shampoo Pantene Control Caida 400ml	Shampoo para evitar la caida	35	35	48.00	65.00	0	5	2026-04-15 00:00:00
7045	Acondicionador Pantene Restauracion 400ml	Acondicionador para cabello	35	35	48.00	65.00	0	5	2026-04-15 00:00:00
7046	Shampoo Savile Control Caspa 750ml	Shampoo con sabila y eucalipto	35	58	32.00	45.00	0	5	2026-04-15 00:00:00
7047	Shampoo Savile Chile 750ml	Shampoo con sabila y chile	35	58	32.00	45.00	0	5	2026-04-15 00:00:00
7048	Jabon Dove Original 135g	Barra de belleza humectante	41	36	22.00	30.00	0	5	2026-04-15 00:00:00
7049	Jabon Palmolive Oliva 150g	Jabon de tocador con oliva	41	31	13.00	18.00	0	5	2026-04-15 00:00:00
7050	Jabon Zest Limon 150g	Jabon de tocador refrescante	41	58	12.50	17.00	0	5	2026-04-15 00:00:00
7051	Jabon Rosa Venus 100g	Jabon de tocador clasico rosa	41	58	9.00	13.00	0	5	2026-04-15 00:00:00
7052	Desodorante Rexona Men Aerosol 150ml	Antitranspirante masculino spray	41	58	42.00	58.00	0	5	2026-04-15 00:00:00
7053	Desodorante Rexona Lady Aerosol 150ml	Antitranspirante femenino spray	41	58	42.00	58.00	0	5	2026-04-15 00:00:00
7054	Desodorante Axe Black Aerosol 150ml	Body spray para caballero	41	58	45.00	62.00	0	5	2026-04-15 00:00:00
7055	Desodorante Speed Stick 50g	Desodorante en barra caballero	41	58	30.00	42.00	0	5	2026-04-15 00:00:00
7056	Desodorante Lady Speed Stick 45g	Desodorante en barra dama	41	58	30.00	42.00	0	5	2026-04-15 00:00:00
7057	Rastrillo Gillette Prestobarba Azul 1 pza	Rastrillo desechable 2 hojas	41	58	14.00	20.00	0	5	2026-04-15 00:00:00
7058	Rastrillo Gillette Prestobarba 3 1 pza	Rastrillo desechable 3 hojas	41	58	22.00	30.00	0	5	2026-04-15 00:00:00
7059	Gel Ego Black 200ml	Gel fijador para caballero	41	58	18.00	25.00	0	5	2026-04-15 00:00:00
7060	Suavizante Downy Libre Enjuague 800ml	Suavizante de telas concentrado	32	58	25.00	35.00	0	5	2026-04-15 00:00:00
7061	Suavizante Ensueno Frescura 850ml	Suavizante de telas aroma fresco	32	58	18.00	25.00	0	5	2026-04-15 00:00:00
7062	Cloro Cloralex El Rendidor 2L	Blanqueador desinfectante 2 litros	35	58	26.00	35.00	0	5	2026-04-15 00:00:00
7063	Pinol Original 2L	Limpiador de pinol 2 litros	35	58	38.00	52.00	0	5	2026-04-15 00:00:00
7064	Fabuloso Mar Fresco 1L	Limpiador multiusos azul	35	30	22.00	30.00	0	5	2026-04-15 00:00:00
7065	Lavatrastes Salvo Limon 750ml	Detergente liquido para platos	34	58	30.00	42.00	0	5	2026-04-15 00:00:00
7066	Lavatrastes Axion Pasta 400g	Jabon en pasta para platos	34	30	18.00	25.00	0	5	2026-04-15 00:00:00
7067	Detergente Ariel Liquido 800ml	Detergente liquido para ropa	34	58	35.00	48.00	0	5	2026-04-15 00:00:00
7068	Detergente Mas Color 830ml	Detergente para ropa de color	34	58	38.00	52.00	0	5	2026-04-15 00:00:00
7069	Frijoles Isadora Refritos Bayos 430g	Frijoles en bolsa listos para comer	6	58	14.00	20.00	0	5	2026-04-15 00:00:00
7070	Frijoles Isadora Refritos Negros 430g	Frijoles en bolsa listos para comer	6	58	14.00	20.00	0	5	2026-04-15 00:00:00
7071	Frijoles La Costena Refritos Bayos 400g	Frijoles refritos en lata	6	27	13.00	18.00	0	5	2026-04-15 00:00:00
7072	Frijoles La Costena Refritos Negros 400g	Frijoles refritos en lata	6	27	13.00	18.00	0	5	2026-04-15 00:00:00
7073	Chicharos Herdez 215g	Chicharos verdes en lata	6	20	11.00	15.00	0	5	2026-04-15 00:00:00
7074	Chicharos con Zanahoria Herdez 215g	Verduras picadas en lata	6	20	11.00	15.00	0	5	2026-04-15 00:00:00
7075	Ensalada de Verduras Herdez 215g	Verduras mixtas en lata	6	20	12.00	17.00	0	5	2026-04-15 00:00:00
7076	Champiñones Troceados Herdez 186g	Champinones en conserva	6	20	18.00	25.00	0	5	2026-04-15 00:00:00
7077	Salsa Herdez Verde 210g	Salsa verde de tomatillo	12	20	13.00	18.00	0	5	2026-04-15 00:00:00
7078	Salsa Herdez Casera 210g	Salsa roja con trozos	12	20	13.00	18.00	0	5	2026-04-15 00:00:00
7079	Salsa Valentina Negra 370ml	Salsa muy picante etiqueta negra	12	58	12.00	17.00	0	5	2026-04-15 00:00:00
7080	Salsa Botanera Clasica 370ml	Salsa picante para botanas	12	58	10.00	14.00	0	5	2026-04-15 00:00:00
7081	Salsa Maggi Sazonador 100ml	Sazonador para carnes y sopas	13	19	22.00	30.00	0	5	2026-04-15 00:00:00
7082	Salsa Inglesa Crosse & Blackwell 145ml	Salsa tipo inglesa	13	19	25.00	35.00	0	5	2026-04-15 00:00:00
7083	Sopa Nissin Cup Noodles Pollo 64g	Sopa instantanea en vaso Pollo	2	11	10.00	15.00	0	5	2026-04-15 00:00:00
7084	Sopa Nissin Cup Noodles Camaron 64g	Sopa instantanea en vaso Camaron	2	11	10.00	15.00	0	5	2026-04-15 00:00:00
7085	Sopa Maruchan Vaso Res 64g	Sopa instantanea en vaso Res	2	11	11.00	16.00	0	5	2026-04-15 00:00:00
7086	Sopa Maruchan Vaso Camaron Limon 64g	Sopa vaso Camaron Chile Limon	2	11	11.00	16.00	0	5	2026-04-15 00:00:00
7087	Pure de Tomate Del Fuerte 210g	Pure de tomate condimentado	12	58	7.00	10.00	0	5	2026-04-15 00:00:00
7088	Pure de Tomate La Costena 210g	Pure de tomate condimentado	12	27	7.00	10.00	0	5	2026-04-15 00:00:00
7089	Sopa Knorr Spaghetti con Queso	Sopa de pasta lista 10 min	2	58	12.00	17.00	0	5	2026-04-15 00:00:00
7090	Sopa Knorr Coditos con Crema	Sopa de pasta lista 10 min	2	58	12.00	17.00	0	5	2026-04-15 00:00:00
7091	Knorr Suiza Caldo Pollo 100g	Sazonador en polvo frasco	13	58	18.00	25.00	0	5	2026-04-15 00:00:00
7092	Knorr Tomate 8 cubos	Sazonador de tomate en cubos	13	58	12.50	18.00	0	5	2026-04-15 00:00:00
7093	Sal de Uvas Picot 1 sobre	Antiacido efervescente	50	58	4.00	7.00	0	5	2026-04-15 00:00:00
7094	Alka-Seltzer 2 tabletas	Antiacido y analgesico	50	58	6.00	10.00	0	5	2026-04-15 00:00:00
7095	Tortillinas Tia Rosa 10 pzas	Tortillas de harina medianas	27	17	18.00	25.00	0	5	2026-04-15 00:00:00
7096	Tortillinas Tia Rosa 22 pzas	Tortillas de harina paquete familiar	27	17	35.00	48.00	0	5	2026-04-15 00:00:00
7097	Cuernitos Tia Rosa 2 pzas	Pan de dulce forma cuernito	29	17	16.00	22.00	0	5	2026-04-15 00:00:00
7098	Banderillas Tia Rosa 4 pzas	Pan dulce tipo hojaldre	29	17	18.00	25.00	0	5	2026-04-15 00:00:00
7099	Doraditas Tia Rosa 4 pzas	Galletas de hojaldre azucaradas	29	17	18.00	25.00	0	5	2026-04-15 00:00:00
7100	Pan para Hot Dog Bimbo 8 pzas	Medias noches bimbo 8 pzas	27	17	28.00	38.00	0	5	2026-04-15 00:00:00
7101	Pan para Hamburguesa Bimbo 8 pzas	Bimbollos con ajonjoli 8 pzas	27	17	32.00	42.00	0	5	2026-04-15 00:00:00
7102	Tostadas Milpa Real 300g	Tostadas de maiz amarillas	5	17	22.00	30.00	0	5	2026-04-15 00:00:00
7103	Pan Tostado Bimbo Clasico 210g	Pan de caja tostado crujiente	27	17	25.00	35.00	0	5	2026-04-15 00:00:00
7104	Pan Tostado Bimbo Doble Fibra	Pan de caja tostado con fibra	27	17	28.00	38.00	0	5	2026-04-15 00:00:00
7105	Barritas Marinela Zarzamora 67g	Galletas rellenas zarzamora	29	22	12.00	16.00	0	5	2026-04-15 00:00:00
7106	Napolitano Marinela 70g	Pastelito sabor vainilla y choco	29	22	13.00	18.00	0	5	2026-04-15 00:00:00
7107	Submarinos Marinela Vainilla 3 pzas	Pastelitos rellenos crema	29	22	13.00	18.00	0	5	2026-04-15 00:00:00
7108	Submarinos Marinela Fresa 3 pzas	Pastelitos rellenos fresa	29	22	13.00	18.00	0	5	2026-04-15 00:00:00
7109	Canelitas Marinela 6 pzas	Galletas sabor canela paquete	29	22	11.00	15.00	0	5	2026-04-15 00:00:00
7110	Polvorones Marinela 6 pzas	Galletas sabor naranja paquete	29	22	11.00	15.00	0	5	2026-04-15 00:00:00
7111	Yogurt Danup Fresa 220g	Yogurt bebible con fresa	17	58	10.00	15.00	0	5	2026-04-15 00:00:00
7112	Yogurt Yoplait Fresa Bebible 242g	Yogurt bebible sabor fresa	17	58	10.50	15.00	0	5	2026-04-15 00:00:00
7113	Yogurt Yoplait Griego Natural 145g	Yogurt estilo griego natural	17	58	14.00	20.00	0	5	2026-04-15 00:00:00
7114	Yogurt Yoplait Disfruta Fresa 125g	Yogurt con trozos de fruta	17	58	8.50	12.00	0	5	2026-04-15 00:00:00
7115	Gelatina Dany Fresa 125g	Postre de gelatina sabor fresa	17	58	6.50	9.00	0	5	2026-04-15 00:00:00
7116	Gelatina Dany Limon 125g	Postre de gelatina sabor limon	17	58	6.50	9.00	0	5	2026-04-15 00:00:00
7117	Flan Danone vainilla 100g	Postre de flan con caramelo	17	58	9.00	13.00	0	5	2026-04-15 00:00:00
7118	Yakult 80ml	Producto lacteo fermentado	17	58	7.00	10.00	0	5	2026-04-15 00:00:00
7119	Jamon Americano de Pavo Kir 250g	Jamon de pavo economico	18	58	25.00	35.00	0	5	2026-04-15 00:00:00
7120	Jamon de Pavo y Cerdo Fud 290g	Jamon mixto rebanado	18	53	35.00	48.00	0	5	2026-04-15 00:00:00
7121	Salchicha Hot Dog Fud 500g	Salchicha larga para hot dog	18	53	38.00	52.00	0	5	2026-04-15 00:00:00
7122	Salchicha de Pavo Kir 500g	Salchicha de pavo economica	18	58	32.00	45.00	0	5	2026-04-15 00:00:00
7123	Queso Americano Lala 144g	Queso americano rebanado	16	4	25.00	35.00	0	5	2026-04-15 00:00:00
7124	Chorizo Casero de Cerdo 200g	Chorizo de cerdo en empaque	18	58	18.00	26.00	0	5	2026-04-15 00:00:00
7125	Tocino Ahumado Kir 200g	Tocino de cerdo ahumado	18	58	35.00	48.00	0	5	2026-04-15 00:00:00
7126	Pate de Pollo Underwood 100g	Pate de pollo en lata	6	58	18.00	25.00	0	5	2026-04-15 00:00:00
7127	Alimento Perro Pedigree Adulto Sobre 100g	Comida humeda para perro Res	45	58	11.00	15.00	0	5	2026-04-15 00:00:00
7128	Alimento Perro Pedigree Cachorro Sobre 100g	Comida humeda para cachorro Pollo	45	58	11.00	15.00	0	5	2026-04-15 00:00:00
7129	Alimento Gato Whiskas Sobre 85g	Comida humeda para gato Atun	45	58	11.00	15.00	0	5	2026-04-15 00:00:00
7130	Alimento Gato Whiskas Sobre 85g Res	Comida humeda para gato Res	45	58	11.00	15.00	0	5	2026-04-15 00:00:00
7131	Ganador Adulto Sobre 100g	Comida humeda para perro Ganador	45	58	10.00	14.00	0	5	2026-04-15 00:00:00
7132	Dog Chow Adulto Sobre 100g	Comida humeda para perro Dog Chow	45	58	11.00	15.00	0	5	2026-04-15 00:00:00
7133	Pilas Duracell AA 2 pzas	Pilas alcalinas AA paquete	51	58	38.00	55.00	0	5	2026-04-15 00:00:00
7134	Pilas Duracell AAA 2 pzas	Pilas alcalinas AAA paquete	51	58	38.00	55.00	0	5	2026-04-15 00:00:00
7135	Pilas Energizer AA 2 pzas	Pilas alcalinas AA paquete	51	58	35.00	50.00	0	5	2026-04-15 00:00:00
7136	Pilas Volteck Economicas AA 4 pzas	Pilas de carbon zinc AA	51	58	15.00	25.00	0	5	2026-04-15 00:00:00
7137	Encendedor Bic Grande 1 pza	Encendedor de gas clasico	51	58	14.00	20.00	0	5	2026-04-15 00:00:00
7138	Encendedor Bic Mini 1 pza	Encendedor de gas pequeno	51	58	10.00	15.00	0	5	2026-04-15 00:00:00
7139	Cerillos La Central Clasicos	Caja de cerillos de madera	51	58	1.50	3.00	0	5	2026-04-15 00:00:00
7140	Cerillos La Central Cocina	Caja de cerillos grande cocina	51	58	8.00	12.00	0	5	2026-04-15 00:00:00
7141	Veladora Limonera Vaso	Veladora blanca en vaso vidrio	51	58	15.00	22.00	0	5	2026-04-15 00:00:00
7142	Fibra Scotch-Brite Verde 1 pza	Fibra para lavar platos	34	58	11.00	16.00	0	5	2026-04-15 00:00:00
7143	Fibra Scotch-Brite Cero Rayas 1 pza	Fibra delicada para teflon	34	58	13.00	18.00	0	5	2026-04-15 00:00:00
7144	Guantes de Limpieza Medianos	Guantes de latex amarillos	35	58	18.00	28.00	0	5	2026-04-15 00:00:00
7145	Bolsas para Basura Gde 10 pzas	Bolsas negras resistentes	35	58	22.00	32.00	0	5	2026-04-15 00:00:00
7146	Servilletas Petalo 100 pzas	Servilletas de papel blancas	43	29	12.00	18.00	0	5	2026-04-15 00:00:00
7147	Servilletas Regio 100 pzas	Servilletas de papel resistentes	43	29	14.00	20.00	0	5	2026-04-15 00:00:00
7148	Aluminio Reynolds 7 metros	Papel aluminio para cocina	51	58	18.00	25.00	0	5	2026-04-15 00:00:00
7149	Plastico Adherente Kleen-Pack 10m	Pelicula plastica para cocina	51	58	15.00	22.00	0	5	2026-04-15 00:00:00
7150	Vasos Desechables No. 8 20 pzas	Vasos de plastico blancos	51	58	15.00	22.00	0	5	2026-04-15 00:00:00
7151	Platos Desechables No. 9 20 pzas	Platos de plastico blancos	51	58	18.00	26.00	0	5	2026-04-15 00:00:00
7152	Tenedores Desechables 25 pzas	Tenedores de plastico blancos	51	58	12.00	18.00	0	5	2026-04-15 00:00:00
7153	Cafe Legal Soluble 180g	Cafe con azucar soluble	44	58	35.00	48.00	0	5	2026-04-15 00:00:00
7154	Cafe Oro Soluble 75g	Cafe soluble 100 por ciento puro	44	58	32.00	45.00	0	5	2026-04-15 00:00:00
7155	Te McCormick Hierbabuena 25 sobres	Te de hierbas natural	44	58	18.00	25.00	0	5	2026-04-15 00:00:00
7156	Choco Milk Bolsa 160g	Modificador de leche chocolate	44	58	22.00	32.00	0	5	2026-04-15 00:00:00
7157	Cal-C-Tose Bolsa 160g	Modificador de leche chocolate	44	58	22.00	32.00	0	5	2026-04-15 00:00:00
7158	Jarabe Hershey Chocolate 589g	Jarabe dulce para postres	11	45	45.00	62.00	0	5	2026-04-15 00:00:00
7159	Mermelada McCormick Fresa 270g	Mermelada de fruta con trozos	11	58	22.00	30.00	0	5	2026-04-15 00:00:00
7160	Cajeta Coronado Quemada 370g	Dulce de leche de cabra	11	58	48.00	65.00	0	5	2026-04-15 00:00:00
7161	Miel Carlota Abeja 250g	Miel de abeja pura	11	19	45.00	60.00	0	5	2026-04-15 00:00:00
7162	Crema de Cacahuate Aladino 425g	Crema de cacahuate suave	11	58	48.00	65.00	0	5	2026-04-15 00:00:00
7163	Atun Herdez en Aceite 130g	Atun en hojuelas aceite	6	20	14.50	21.00	0	5	2026-04-15 00:00:00
7164	Atun Tuny en Agua 140g	Atun en hojuelas agua	6	58	15.00	22.00	0	5	2026-04-15 00:00:00
7165	Atun Tuny con Verduras 140g	Atun con ensalada de verduras	6	58	13.00	18.00	0	5	2026-04-15 00:00:00
7166	Sardinas en Tomate Pescador 425g	Sardinas en salsa de tomate	6	58	28.00	38.00	0	5	2026-04-15 00:00:00
7167	Vinagre Blanco La Costena 520ml	Vinagre de alcohol de cana	1	27	10.00	14.00	0	5	2026-04-15 00:00:00
7168	Aceite Capullo 840ml	Aceite puro de canola	1	58	42.00	55.00	0	5	2026-04-15 00:00:00
7169	Aceite Ave 900ml	Aceite vegetal economico	1	58	32.00	42.00	0	5	2026-04-15 00:00:00
7170	Arroz Verde Valle Precotto 250g	Arroz precocido 5 min	2	58	14.00	20.00	0	5	2026-04-15 00:00:00
7171	Lentejas Verde Valle 500g	Lentejas secas de primera	2	58	22.00	30.00	0	5	2026-04-15 00:00:00
7172	Garbanzo Verde Valle 500g	Garbanzo seco de primera	2	58	24.00	32.00	0	5	2026-04-15 00:00:00
7173	Harina para Hot Cakes Gamesa 850g	Mezcla lista para hot cakes	10	46	32.00	45.00	0	5	2026-04-15 00:00:00
7174	Jarabe Pronto Maple 250ml	Jarabe sabor maple para hot cakes	11	58	22.00	30.00	0	5	2026-04-15 00:00:00
7175	Avena Quaker 3 Minutos 400g	Avena en hojuelas instantanea	5	25	24.00	32.00	0	5	2026-04-15 00:00:00
7176	Gel Ego For Men 500ml	Gel fijador extra firme grande	41	58	32.00	45.00	0	5	2026-04-15 00:00:00
7177	Toallas Femeninas Saba con Alas 10 pzas	Toallas femeninas flujo regular	41	58	22.00	32.00	0	5	2026-04-15 00:00:00
7178	Toallas Femeninas Kotex Nocturna 10 pzas	Toallas femeninas flujo abundante	41	58	25.00	35.00	0	5	2026-04-15 00:00:00
7179	Panales Huggies Etapa 3 10 pzas	Panales desechables medianos	41	58	45.00	65.00	0	5	2026-04-15 00:00:00
7180	Toallitas Humedas Huggies 80 pzas	Toallitas para bebe	41	58	35.00	50.00	0	5	2026-04-15 00:00:00
7181	Te McCormick Manzanilla 25 sobres	Te de hierbas natural	44	58	18.00	25.00	0	5	2026-04-15 00:00:00
7182	Vinagre de Manzana La Costena 520ml	Vinagre de sidra de manzana	1	27	12.00	17.00	0	5	2026-04-15 00:00:00
7183	Alcohol Etilico Jaloma 445ml	Alcohol para curaciones	50	58	22.00	32.00	0	5	2026-04-15 00:00:00
7184	Agua Oxigenada Jaloma 225ml	Auxiliar en curaciones	50	58	12.00	18.00	0	5	2026-04-15 00:00:00
7185	Algodon Jaloma 50g	Algodon plisado puro	50	58	12.00	18.00	0	5	2026-04-15 00:00:00
7186	Curitas Clasicas 10 pzas	Vendas adhesivas sanitarias	50	58	12.00	18.00	0	5	2026-04-15 00:00:00
7187	Jugo Boing Guayaba 250ml	Bebida de fruta de carton	31	58	7.50	10.00	0	5	2026-04-15 00:00:00
7188	Jugo Boing Uva 250ml	Bebida de fruta de carton	31	58	7.50	10.00	0	5	2026-04-15 00:00:00
7189	Jugo Boing Fresa 250ml	Bebida de fruta de carton	31	58	7.50	10.00	0	5	2026-04-15 00:00:00
7190	Jugo Boing Guayaba 500ml	Bebida de fruta en vidrio/carton	31	58	12.00	16.00	0	5	2026-04-15 00:00:00
7191	Jugo Boing Guayaba 1L	Bebida de fruta 1 Litro	31	58	19.00	25.00	0	5	2026-04-15 00:00:00
7192	Jumex Unico Fresco Naranja 1L	Jugo 100 por ciento sin azucar	31	21	26.00	35.00	0	5	2026-04-15 00:00:00
7193	Jumex Unico Fresco Verde 1L	Jugo de frutas y verduras	31	21	28.00	38.00	0	5	2026-04-15 00:00:00
7194	Jumex Fresh Citricos 600ml	Bebida refrescante de limon	31	21	11.00	15.00	0	5	2026-04-15 00:00:00
7195	Jumex Fresh Congo 600ml	Bebida de frutas tropicales	31	21	11.00	15.00	0	5	2026-04-15 00:00:00
7196	Pau Pau Fresa 250ml	Bebida infantil con vitaminas	31	21	5.50	8.00	0	5	2026-04-15 00:00:00
7197	Pau Pau Uva 250ml	Bebida infantil con vitaminas	31	21	5.50	8.00	0	5	2026-04-15 00:00:00
7198	Arizon Tea Ginseng 680ml	Te helado en lata grande	31	58	18.00	25.00	0	5	2026-04-15 00:00:00
7199	Arizon Tea Sandia 680ml	Bebida sabor sandia lata	31	58	18.00	25.00	0	5	2026-04-15 00:00:00
7200	V8 Jugo de Verduras 340ml	Jugo de vegetales en lata	31	58	16.00	22.00	0	5	2026-04-15 00:00:00
7201	BeLight Jamaica 1.5L	Bebida sin calorias jamaica	31	16	13.00	18.00	0	5	2026-04-15 00:00:00
7202	BeLight Limon 1.5L	Bebida sin calorias limon	31	16	13.00	18.00	0	5	2026-04-15 00:00:00
7203	Gatorade Ponche de Frutas 600ml	Bebida para deportistas	31	14	21.00	28.00	0	5	2026-04-15 00:00:00
7204	Gatorade Lima Limon 600ml	Bebida para deportistas	31	14	21.00	28.00	0	5	2026-04-15 00:00:00
7205	Gatorade Uva 600ml	Bebida para deportistas	31	14	21.00	28.00	0	5	2026-04-15 00:00:00
7206	Electrolit Coco 625ml	Suero rehidratante grado medico	31	58	22.00	30.00	0	5	2026-04-15 00:00:00
7207	Electrolit Fresa 625ml	Suero rehidratante grado medico	31	58	22.00	30.00	0	5	2026-04-15 00:00:00
7208	Electrolit Uva 625ml	Suero rehidratante grado medico	31	58	22.00	30.00	0	5	2026-04-15 00:00:00
7209	Choco Milk Lata 400g	Modificador de leche chocolate	44	58	55.00	75.00	0	5	2026-04-15 00:00:00
7210	Nesquik Fresa Polso 200g	Saborizante para leche fresa	44	19	24.00	32.00	0	5	2026-04-15 00:00:00
7211	Galletas Arcoiris Gamesa 6 pzas	Galleta con malvavisco y coco	9	46	12.00	17.00	0	5	2026-04-15 00:00:00
7212	Galletas Mamut Gigante 1 pza	Galleta con malvavisco grande	9	46	8.50	12.00	0	5	2026-04-15 00:00:00
7213	Galletas Vualá de Chocolate 60g	Pastelito relleno de chocolate	29	58	11.00	15.00	0	5	2026-04-15 00:00:00
7214	Galletas Vualá de Cajeta 60g	Pastelito relleno de cajeta	29	58	11.00	15.00	0	5	2026-04-15 00:00:00
7215	Galletas Emperador Combinado Tubo	Galletas chocolate y vainilla	9	46	13.50	19.00	0	5	2026-04-15 00:00:00
7216	Galletas Choquix Chocolate Tubo	Galletas con chispas Gamesa	9	46	13.50	19.00	0	5	2026-04-15 00:00:00
7217	Galletas Surtido Rico Gamesa 400g	Caja de galletas variadas	9	46	42.00	58.00	0	5	2026-04-15 00:00:00
7218	Obleas con Cajeta Las Sevillanas	Dulce de leche con oblea	8	58	12.00	18.00	0	5	2026-04-15 00:00:00
7219	Glorias de Linares 1 pza	Dulce de leche quemada con nuez	8	58	9.00	13.00	0	5	2026-04-15 00:00:00
7220	Bombones De La Rosa 100g	Nubes de malvavisco blancas	8	62	13.00	18.00	0	5	2026-04-15 00:00:00
7221	Gomitas Extreme Sour 50g	Gomitas acidas de colores	8	58	11.00	15.00	0	5	2026-04-15 00:00:00
7222	Cuaderno Scribe Profesional Raya	Libreta de 100 hojas raya	52	58	22.00	30.00	0	5	2026-04-15 00:00:00
7223	Cuaderno Scribe Profesional Cuadro	Libreta de 100 hojas cuadro	52	58	22.00	30.00	0	5	2026-04-15 00:00:00
7224	Lapiz Bic Evolution No. 2	Lapiz de grafito resistente	52	58	4.00	7.00	0	5	2026-04-15 00:00:00
7225	Pluma Bic Cristal Negra	Boligrafo tinta negra clasico	52	58	5.00	8.00	0	5	2026-04-15 00:00:00
7226	Pluma Bic Cristal Azul	Boligrafo tinta azul clasico	52	58	5.00	8.00	0	5	2026-04-15 00:00:00
7227	Pluma Bic Cristal Roja	Boligrafo tinta roja clasico	52	58	5.00	8.00	0	5	2026-04-15 00:00:00
7228	Goma Pelikan WS30	Goma de borrar migajon	52	58	4.00	7.00	0	5	2026-04-15 00:00:00
7229	Sacapuntas de Metal	Sacapuntas sencillo metalico	52	58	3.00	6.00	0	5	2026-04-15 00:00:00
7230	Pegamento Stick Pritt 10g	Pegamento en barra	52	58	15.00	22.00	0	5	2026-04-15 00:00:00
7231	Cinta Canela 40m	Cinta adhesiva de empaque	52	58	18.00	28.00	0	5	2026-04-15 00:00:00
7232	Cinta Transparente 40m	Cinta adhesiva transparente	52	58	18.00	28.00	0	5	2026-04-15 00:00:00
7233	Marcador para Pizarron Negro	Marcador magistral borrable	52	58	18.00	25.00	0	5	2026-04-15 00:00:00
7234	Corrector Liquido Tipo Pluma	Corrector de precision	52	58	18.00	25.00	0	5	2026-04-15 00:00:00
7235	Hojas Blancas paq. 50 pzas	Hojas de papel bond tamano carta	52	58	15.00	25.00	0	5	2026-04-15 00:00:00
7236	Cartulina Blanca 1 pza	Pliego de cartulina estandar	52	58	4.00	7.00	0	5	2026-04-15 00:00:00
7237	Papel China de Colores 1 pza	Papel seda varios colores	52	58	1.50	3.00	0	5	2026-04-15 00:00:00
7238	Sobre Amarillo Carta 1 pza	Sobre de papel manila	52	58	2.50	5.00	0	5	2026-04-15 00:00:00
7239	Foco LED 9W Luz Blanca	Lampara ahorradora base E27	51	58	25.00	40.00	0	5	2026-04-15 00:00:00
7240	Foco LED 12W Luz Blanca	Lampara ahorradora potente	51	58	32.00	50.00	0	5	2026-04-15 00:00:00
7241	Extension Electrica 3m	Cable extension uso domestico	51	58	45.00	65.00	0	5	2026-04-15 00:00:00
7242	Multicontacto 3 entradas	Adaptador triple de corriente	51	58	15.00	25.00	0	5	2026-04-15 00:00:00
7243	Cinta de Aislar Negra	Cinta para cables electricos	51	58	12.00	20.00	0	5	2026-04-15 00:00:00
7244	Pila 9V Alcalina 1 pza	Batería cuadrada para equipos	51	58	65.00	85.00	0	5	2026-04-15 00:00:00
7245	Jugo Boing Manzana 250ml	Bebida de fruta de carton	31	58	7.50	10.00	0	5	2026-04-15 00:00:00
7246	Jugo Boing Mango 500ml	Bebida de fruta en vidrio/carton	31	58	12.00	16.00	0	5	2026-04-15 00:00:00
7247	Jugo Boing Mango 1L	Bebida de fruta 1 Litro	31	58	19.00	25.00	0	5	2026-04-15 00:00:00
7248	Marcador Permanente Sharpie Negro	Marcador de tinta indeleble	52	58	22.00	30.00	0	5	2026-04-15 00:00:00
7249	Folder Tamano Carta Crema	Folder de cartulina sencillo	52	58	2.50	5.00	0	5	2026-04-15 00:00:00
7250	Linterna de Mano Basica	Lampara de plastico recargable	51	58	45.00	75.00	0	5	2026-04-15 00:00:00
7251	Candado de Hierro 30mm	Candado con dos llaves	51	58	35.00	55.00	0	5	2026-04-15 00:00:00
7252	Pegamento Instantaneo 2g	Pegamento de contacto fuerte	52	58	10.00	18.00	0	5	2026-04-15 00:00:00
7253	Pegamento Blanco 125g	Resistol escolar blanco	52	58	15.00	22.00	0	5	2026-04-15 00:00:00
7254	Tafil No. 2 Clavos paq.	Clavos de acero para concreto	51	58	12.00	20.00	0	5	2026-04-15 00:00:00
7255	Martillo de Una 1 pza	Herramienta basica de carpinteria	51	58	65.00	95.00	0	5	2026-04-15 00:00:00
7256	Desarmador de Cruz y Plano	Herramienta doble punta	51	58	25.00	45.00	0	5	2026-04-15 00:00:00
7257	Aspirina 500mg 10 tabletas	Analgesico acido acetilsalicilico	50	58	22.00	35.00	0	5	2026-04-15 00:00:00
7258	Tabcin Noche 12 capsulas	Auxiliar en sintomas de gripe	50	58	45.00	65.00	0	5	2026-04-15 00:00:00
7259	Tabcin Dia 12 capsulas	Auxiliar en sintomas de gripe	50	58	45.00	65.00	0	5	2026-04-15 00:00:00
7260	Tempra Adulto 500mg 10 tabs	Analgesico paracetamol	50	58	25.00	40.00	0	5	2026-04-15 00:00:00
7261	Tempra Infantil Jarabe 120ml	Paracetamol infantil	50	58	55.00	75.00	0	5	2026-04-15 00:00:00
7262	Flanax 550mg 12 tabletas	Antiinflamatorio y analgesico	50	58	65.00	95.00	0	5	2026-04-15 00:00:00
7263	Vick VapoRub 50g	Unguento para congestion nasal	50	58	48.00	68.00	0	5	2026-04-15 00:00:00
7264	Vick Vaporub 12g	Unguento pequeno presentacion sobre	50	58	12.00	20.00	0	5	2026-04-15 00:00:00
7265	Tums Surtido de Frutas 12 tabs	Antiacido masticable	50	58	25.00	38.00	0	5	2026-04-15 00:00:00
7266	XL-3 Gripa 12 tabletas	Auxiliar en resfriado comun	50	58	32.00	48.00	0	5	2026-04-15 00:00:00
7267	Metamucil Polvo Naranja 10 sobres	Suplemento de fibra natural	50	58	55.00	75.00	0	5	2026-04-15 00:00:00
7268	Condones Sico Original 3 pzas	Metodo anticonceptivo	50	58	38.00	55.00	0	5	2026-04-15 00:00:00
7269	Condones Trojan 3 pzas	Metodo anticonceptivo	50	58	42.00	60.00	0	5	2026-04-15 00:00:00
7270	Prueba de Embarazo Casera	Dispositivo de diagnostico	50	58	45.00	75.00	0	5	2026-04-15 00:00:00
7271	Gel Antibacterial 250ml	Desinfectante de manos alcohol	50	58	18.00	28.00	0	5	2026-04-15 00:00:00
7272	Cubrebocas Azul 10 pzas	Mascarilla protectora desechable	50	58	10.00	20.00	0	5	2026-04-15 00:00:00
7273	Algodon Absorbente 100g	Paquete de algodon de primera	50	58	18.00	28.00	0	5	2026-04-15 00:00:00
7274	Gasa Esteril 10x10cm	Compresa de gasa individual	50	58	4.00	8.00	0	5	2026-04-15 00:00:00
7275	Micropore Cinta Medica	Cinta adhesiva para curacion	50	58	15.00	25.00	0	5	2026-04-15 00:00:00
7276	Pomada de la Campana 35g	Crema protectora para la piel	41	58	22.00	32.00	0	5	2026-04-15 00:00:00
7277	Vaselina Pura 60g	Unguento humectante de vaselina	41	58	22.00	32.00	0	5	2026-04-15 00:00:00
7278	Crema Nivea Tarro Azul 60ml	Crema humectante clasica	41	58	28.00	42.00	0	5	2026-04-15 00:00:00
7279	Crema Lubriderm Tapa Azul 120ml	Crema humectante diaria	41	58	45.00	65.00	0	5	2026-04-15 00:00:00
7280	Talco para Pies Mexsana 80g	Talco desodorante para pies	41	58	35.00	50.00	0	5	2026-04-15 00:00:00
7281	Toallitas Desmaquillantes Pond's	Toallitas limpiadoras faciales	41	58	35.00	55.00	0	5	2026-04-15 00:00:00
7282	Sazonador Pimienta Negra 50g	Pimienta negra molida McCormick	13	72	18.00	25.00	0	5	2026-04-15 00:00:00
7283	Ajo en Polvo McCormick 50g	Sazonador ajo puro molido	13	72	18.00	25.00	0	5	2026-04-15 00:00:00
7284	Canela Entera 20g	Rajas de canela natural	13	58	12.00	18.00	0	5	2026-04-15 00:00:00
7285	Canela Molida 50g	Canela en polvo para postres	13	58	15.00	22.00	0	5	2026-04-15 00:00:00
7286	Vainilla Molina 250ml	Extracto de vainilla liquido	13	58	18.00	26.00	0	5	2026-04-15 00:00:00
7287	Polvo para Hornear Royal 100g	Levadura quimica para pan	10	58	18.00	25.00	0	5	2026-04-15 00:00:00
7288	Grenetina en Polvo 4 sobres	Grenetina natural sin sabor	10	58	15.00	22.00	0	5	2026-04-15 00:00:00
7289	Colorante Vegetal Rojo	Colorante para alimentos liquido	10	58	10.00	15.00	0	5	2026-04-15 00:00:00
7290	Chile Guajillo Bolsa 50g	Chile seco seleccionado	13	58	15.00	22.00	0	5	2026-04-15 00:00:00
7291	Chile Ancho Bolsa 50g	Chile seco seleccionado	13	58	18.00	25.00	0	5	2026-04-15 00:00:00
7292	Chile de Arbol Bolsa 50g	Chile seco muy picante	13	58	15.00	22.00	0	5	2026-04-15 00:00:00
7293	Oregano Seco Bolsa 20g	Hierba de olor para cocina	13	58	8.00	12.00	0	5	2026-04-15 00:00:00
7294	Comino Molido Bolsa 50g	Especias para sazonar	13	58	12.00	18.00	0	5	2026-04-15 00:00:00
7295	Laurel Hojas Bolsa 20g	Hierba de olor para guisos	13	58	8.00	12.00	0	5	2026-04-15 00:00:00
7296	Bicarbonato de Sodio 100g	Uso domestico y culinario	13	58	10.00	15.00	0	5	2026-04-15 00:00:00
7297	Miel de Agave 250ml	Endulzante natural de agave	11	58	45.00	65.00	0	5	2026-04-15 00:00:00
7298	Splenda 50 sobres	Endulzante sin calorias	3	58	35.00	48.00	0	5	2026-04-15 00:00:00
7299	Stevia 50 sobres	Endulzante natural sin calorias	3	58	38.00	52.00	0	5	2026-04-15 00:00:00
7300	Sopa de Letras La Moderna 200g	Pasta de sémola de trigo	2	44	7.50	11.00	0	5	2026-04-15 00:00:00
7301	Sopa de Estrellas La Moderna 200g	Pasta de sémola de trigo	2	44	7.50	11.00	0	5	2026-04-15 00:00:00
7302	Sopa de Municion La Moderna 200g	Pasta de sémola de trigo	2	44	7.50	11.00	0	5	2026-04-15 00:00:00
7303	Macarrones La Moderna 200g	Pasta de sémola de trigo	2	44	7.50	11.00	0	5	2026-04-15 00:00:00
7304	Aceitunas con Hueso La Costena	Aceitunas verdes en frasco	6	27	18.00	26.00	0	5	2026-04-15 00:00:00
7305	Aceitunas Rellenas La Costena	Aceitunas con pimiento	6	27	22.00	30.00	0	5	2026-04-15 00:00:00
7306	Alcaparras en Salmuera 100g	Botella de alcaparras	6	58	25.00	35.00	0	5	2026-04-15 00:00:00
7307	Pimiento Morron en Lata	Pimiento rojo en tiras	6	58	22.00	30.00	0	5	2026-04-15 00:00:00
7308	Mole Poblano Doña Maria 235g	Pasta para mole en vaso	12	20	32.00	45.00	0	5	2026-04-15 00:00:00
7309	Mole Verde Doña Maria 235g	Pasta para mole verde en vaso	12	20	35.00	48.00	0	5	2026-04-15 00:00:00
7310	Salsa para Pasta Prego Tradicional	Salsa de tomate para spaghetti	12	58	35.00	48.00	0	5	2026-04-15 00:00:00
7311	Salsa para Pasta Prego Champiñones	Salsa de tomate con hongos	12	58	38.00	52.00	0	5	2026-04-15 00:00:00
7312	Pechuga de Pavo Zwan 250g	Embutido de pavo premium	18	58	45.00	60.00	0	5	2026-04-15 00:00:00
7313	Jamon Serrano Paquete 100g	Jamon curado rebanado	18	58	65.00	95.00	0	5	2026-04-15 00:00:00
7314	Salchicha de Pavo Oscar Mayer	Salchichas de pavo calidad	18	58	38.00	55.00	0	5	2026-04-15 00:00:00
7315	Chorizo de Bilbao 200g	Chorizo tipo español	18	58	45.00	65.00	0	5	2026-04-15 00:00:00
7316	Queso Gouda Rebanado Nochebuena	Queso tipo gouda paquete	16	58	48.00	65.00	0	5	2026-04-15 00:00:00
7317	Queso Oaxaca La Villita 200g	Queso de hebra para fundir	16	58	42.00	58.00	0	5	2026-04-15 00:00:00
7318	Pepto-Bismol 12 tabletas	Auxiliar en malestar estomacal	50	58	42.00	58.00	0	5	2026-04-15 00:00:00
7319	Queso Manchego Rebanado Nochebuena	Queso tipo manchego paquete	16	58	48.00	65.00	0	5	2026-04-15 00:00:00
7320	Queso Cotija en Polvo 100g	Queso seco rallado	16	58	22.00	30.00	0	5	2026-04-15 00:00:00
7321	Yogurt Vitalímea Fresa 220g	Yogurt bajo en calorias	17	58	12.00	17.00	0	5	2026-04-15 00:00:00
7322	Yogurt Vitalímea Natural 220g	Yogurt bajo en calorias	17	58	12.00	17.00	0	5	2026-04-15 00:00:00
7323	Limonada Peñafiel 600ml	Bebida mineral con limon	31	58	13.00	18.00	0	5	2026-04-15 00:00:00
7324	Naranjada Peñafiel 600ml	Bebida mineral con naranja	31	58	13.00	18.00	0	5	2026-04-15 00:00:00
7325	Agua Mineral Perrier 330ml	Agua mineral de manantial francesa	31	19	22.00	35.00	0	5	2026-04-15 00:00:00
7326	Agua Mineral San Pellegrino 330ml	Agua mineral italiana lata	31	19	22.00	35.00	0	5	2026-04-15 00:00:00
7327	Vino Tinto Las Moras 750ml	Vino de mesa Malbec	33	58	110.00	165.00	0	5	2026-04-15 00:00:00
7328	Vino Blanco Concha y Toro 750ml	Vino de mesa Sauvignon	33	58	95.00	145.00	0	5	2026-04-15 00:00:00
7329	Whisky Johnnie Walker Red Label 700ml	Whisky escoces mezclado	33	58	320.00	450.00	0	5	2026-04-15 00:00:00
7330	Tequila Jose Cuervo Especial 990ml	Tequila joven reposado	33	58	280.00	395.00	0	5	2026-04-15 00:00:00
7331	Mezcal 400 Conejos 750ml	Mezcal artesanal joven	33	58	420.00	580.00	0	5	2026-04-15 00:00:00
7332	Cerveza Corona Extra 355ml	Cerveza clara botella	32	58	18.00	24.00	0	5	2026-04-15 00:00:00
7333	Cerveza Victoria 355ml	Cerveza tipo lager oscura	32	58	18.00	24.00	0	5	2026-04-15 00:00:00
7334	Cerveza Modelo Especial Lata 355ml	Cerveza clara en lata	32	58	19.00	26.00	0	5	2026-04-15 00:00:00
7335	Cerveza Michelob Ultra 355ml	Cerveza baja en calorias	32	58	21.00	28.00	0	5	2026-04-15 00:00:00
7336	Cerveza Heineken 355ml	Cerveza clara premium	32	58	22.00	30.00	0	5	2026-04-15 00:00:00
7337	Cerveza Dos Equis Lager 355ml	Cerveza clara suave	32	58	19.00	26.00	0	5	2026-04-15 00:00:00
7338	Clamato Original 473ml	Jugo de tomate con almeja	31	58	22.00	32.00	0	5	2026-04-15 00:00:00
7339	Hielo en Cubos Bolsa 5kg	Hielo purificado para bebidas	30	58	22.00	35.00	0	5	2026-04-15 00:00:00
7340	Vasos Rojos Fiesteros 20 pzas	Vasos de plastico grandes rojos	51	58	28.00	42.00	0	5	2026-04-15 00:00:00
7341	Carbon de Leña Bolsa 3kg	Carbon vegetal para asados	51	58	45.00	65.00	0	5	2026-04-15 00:00:00
7342	Encendedor de Antorcha Cocina	Encendedor largo para estufa	51	58	28.00	45.00	0	5	2026-04-15 00:00:00
7343	Pastillas de Encendido 12 pzas	Auxiliar para prender carbon	51	58	15.00	25.00	0	5	2026-04-15 00:00:00
7344	Insecticida Raid Casa y Jardin	Spray contra insectos voladores	35	58	55.00	78.00	0	5	2026-04-15 00:00:00
7345	Insecticida Baygon Rastreros	Spray contra cucarachas y hormigas	35	58	55.00	78.00	0	5	2026-04-15 00:00:00
7346	Laminas Raid Repuesto 12 pzas	Laminas para aparato electrico	35	58	28.00	42.00	0	5	2026-04-15 00:00:00
7347	Aparato Raid Electrico Liquido	Repelente de mosquitos electrico	35	58	55.00	85.00	0	5	2026-04-15 00:00:00
7348	Windex Limpiador Vidrios 500ml	Liquido para limpiar cristales	35	58	32.00	45.00	0	5	2026-04-15 00:00:00
7349	Easy-Off Limpiador de Hornos	Quita grasa para estufas	35	58	55.00	85.00	0	5	2026-04-15 00:00:00
7350	Harpic Baños Destapa Caños	Liquido para tuberias obstruidas	35	58	45.00	68.00	0	5	2026-04-15 00:00:00
7351	Pledge Lustrador de Muebles	Spray para madera y superficies	35	58	55.00	78.00	0	5	2026-04-15 00:00:00
7352	Glade Aerosol Lavanda 400ml	Aromatizante de ambiente	35	58	28.00	42.00	0	5	2026-04-15 00:00:00
7353	Air Wick Repuesto Electrico	Aromatizante continuo	35	58	55.00	85.00	0	5	2026-04-15 00:00:00
7354	Veladora de Vaso Imagen	Veladora con imagen religiosa	51	58	18.00	28.00	0	5	2026-04-15 00:00:00
7355	Incienso de Varilla paq. 10 pzas	Varillas aromaticas surtidas	51	58	12.00	20.00	0	5	2026-04-15 00:00:00
7356	Comida para Perro Dog Chow 2kg	Croquetas adulto perro mediano	45	58	145.00	195.00	0	5	2026-04-15 00:00:00
7357	Comida para Gato Whiskas 1.5kg	Croquetas sabor carne y leche	45	58	120.00	175.00	0	5	2026-04-15 00:00:00
7358	Arena para Gato Scoop Away 3kg	Arena aglutinante para desechos	45	58	85.00	125.00	0	5	2026-04-15 00:00:00
7359	Hueso de Carnaza para Perro Gde	Juguete masticable para perro	45	58	22.00	35.00	0	5	2026-04-15 00:00:00
7360	Shampoo para Perros Grisi 400ml	Shampoo antipulgas con avena	45	58	55.00	85.00	0	5	2026-04-15 00:00:00
7361	Escoba de Mijo Clasica	Escoba de fibras naturales	35	58	45.00	65.00	0	5	2026-04-15 00:00:00
7362	Trapeador de Algodon Blanco	Mopa de hilos de algodon	35	58	35.00	55.00	0	5	2026-04-15 00:00:00
7363	Cubeta de Plastico 10L	Cubeta reforzada varios colores	35	58	35.00	55.00	0	5	2026-04-15 00:00:00
7364	Gancho para Ropa Plastico 6 pzas	Ganchos negros o blancos	51	58	25.00	40.00	0	5	2026-04-15 00:00:00
7365	Pinzas para Ropa Madera 12 pzas	Tendedero de madera clasico	51	58	15.00	25.00	0	5	2026-04-15 00:00:00
7366	Bolsas para Basura Chicas 20 pzas	Bolsas para baño cocina	35	58	18.00	28.00	0	5	2026-04-15 00:00:00
7367	Fibras de Acero Inox 2 pzas	Fibra metalica para ollas	34	58	12.00	20.00	0	5	2026-04-15 00:00:00
7368	Guantes de Latex Negros Uso Rudo	Guantes de limpieza fuertes	35	58	25.00	42.00	0	5	2026-04-15 00:00:00
7369	Mascarilla para Cabello Pantene	Tratamiento intensivo capilar	35	35	12.00	20.00	0	5	2026-04-15 00:00:00
7370	Cepillo Dental Oral-B Indicator	Cepillo dental cerdas medias	38	30	18.00	28.00	0	5	2026-04-15 00:00:00
7371	Enjuague Bucal Listerine 250ml	Antiseptico bucal original	38	30	38.00	55.00	0	5	2026-04-15 00:00:00
7372	Hilo Dental Oral-B 25m	Limpieza interdental	38	30	28.00	42.00	0	5	2026-04-15 00:00:00
7373	Corega Crema Adhesiva 40g	Adhesivo para dentaduras	38	30	85.00	125.00	0	5	2026-04-15 00:00:00
7374	Pastillas Efervescentes Corega	Limpieza de dentaduras	38	30	45.00	65.00	0	5	2026-04-15 00:00:00
7375	Desodorante Gillette Gel 82g	Antitranspirante masculino gel	41	58	55.00	78.00	0	5	2026-04-15 00:00:00
7376	Crema de Afeitar Gillette 200g	Espuma para afeitado suave	41	58	45.00	68.00	0	5	2026-04-15 00:00:00
7377	Locion After Shave Gillette	Locion para despues de afeitar	41	58	65.00	95.00	0	5	2026-04-15 00:00:00
7378	Cera para Cabello Axe 50g	Cera moldeadora mate	41	58	55.00	85.00	0	5	2026-04-15 00:00:00
7379	Esmalte de Uñas Bissú	Barniz de uñas varios colores	41	58	12.00	20.00	0	5	2026-04-15 00:00:00
7380	Acetona Pura 120ml	Removedor de esmalte de uñas	41	58	18.00	28.00	0	5	2026-04-15 00:00:00
7381	Pañales Huggies UltraConfort E4 40pza	Pañales para etapa 4 niño/niña	44	29	210.00	285.00	0	5	2026-04-15 00:00:00
7382	Pañales Huggies UltraConfort E5 40pza	Pañales para etapa 5 niño/niña	44	29	225.00	305.00	0	5	2026-04-15 00:00:00
7383	Pañales KleenBebé Suavelastic G 38pza	Pañales etapa grande	44	29	185.00	250.00	0	5	2026-04-15 00:00:00
7384	Toallitas KleenBebé Absorsec 80pza	Toallitas humedas para bebe	44	29	28.00	42.00	0	5	2026-04-15 00:00:00
7385	Chambourcy Manzana 100g	Postre de manzana cocida	17	19	9.00	13.00	0	5	2026-04-15 00:00:00
7386	Biberón Evenflo 8oz	Biberon de plastico decorado	44	58	35.00	55.00	0	5	2026-04-15 00:00:00
7387	Chupón Entrenador Nuk	Chupon de silicona etapa 1	44	58	45.00	70.00	0	5	2026-04-15 00:00:00
7388	Aceite para Bebé Mennen 200ml	Aceite humectante suavidad	44	58	42.00	60.00	0	5	2026-04-15 00:00:00
7389	Talco para Bebé Mennen 200g	Talco proteccion y frescura	44	58	38.00	55.00	0	5	2026-04-15 00:00:00
7390	Jabón Ricitos de Oro 90g	Jabon de tocador manzanilla	44	58	14.00	22.00	0	5	2026-04-15 00:00:00
7391	Shampoo Ricitos de Oro 250ml	Shampoo de manzanilla no lagrimas	44	58	45.00	65.00	0	5	2026-04-15 00:00:00
7392	Papel Higiénico Regio Luxury 4 rollos	Papel higienico hoja doble	36	29	28.00	42.00	0	5	2026-04-15 00:00:00
7393	Papel Higiénico Cottonelle Soft 4 rollos	Papel higienico premium	36	29	32.00	48.00	0	5	2026-04-15 00:00:00
7394	Papel Higiénico Pétalo 12 rollos	Paquete economico de papel	36	29	65.00	95.00	0	5	2026-04-15 00:00:00
7395	Papel Higiénico Suavel 4 rollos	Papel higienico economico	36	29	18.00	28.00	0	5	2026-04-15 00:00:00
7396	Servitoalla Pétalo 1 rollo	Toalla de papel para cocina	36	29	14.00	22.00	0	5	2026-04-15 00:00:00
7397	Pañuelos Kleenex Caja 90pza	Pañuelos desechables suaves	36	29	22.00	35.00	0	5	2026-04-15 00:00:00
7398	Pañuelos Kleenex Pocket 1pza	Paquete individual de bolsillo	36	29	5.00	8.00	0	5	2026-04-15 00:00:00
7399	Velas para Pastel de Colores	Velas de cera para cumpleaños	45	58	8.00	15.00	0	5	2026-04-15 00:00:00
7400	Globos del No. 9 20pza	Globos de latex colores surtidos	45	58	22.00	38.00	0	5	2026-04-15 00:00:00
7401	Confeti Bolsa 100g	Papel picado de colores	45	58	10.00	18.00	0	5	2026-04-15 00:00:00
7402	Gorro de Fiesta 10pza	Gorros de carton para fiesta	45	58	25.00	45.00	0	5	2026-04-15 00:00:00
7403	Serpentina Paquete 10pza	Tiras de papel para festejo	45	58	15.00	28.00	0	5	2026-04-15 00:00:00
7404	Desechable Charola Térmica No. 66	Charola de unicel para comida	45	58	28.00	45.00	0	5	2026-04-15 00:00:00
7470	Chocolate Ibarra 540g	Chocolate para mesa con canela	4	58	62.00	85.00	0	5	2026-04-15 00:00:00
7405	Desechable Vaso Térmico No. 8 20pza	Vasos de unicel para bebidas calientes	45	58	18.00	32.00	0	5	2026-04-15 00:00:00
7406	Piñata de Estrella Mediana	Piñata tradicional de carton	45	58	85.00	135.00	0	5	2026-04-15 00:00:00
7407	Palo para Piñata Decorado	Madera forrada de colores	45	58	12.00	25.00	0	5	2026-04-15 00:00:00
7408	Cereal Zucaritas Kelloggs 710g	Cereal de maiz escarchado	5	26	65.00	88.00	0	5	2026-04-15 00:00:00
7409	Cereal Choco Krispis 620g	Arroz inflado sabor chocolate	5	26	68.00	92.00	0	5	2026-04-15 00:00:00
7410	Cereal Froot Loops 410g	Aros de maiz sabor frutas	5	26	55.00	78.00	0	5	2026-04-15 00:00:00
7411	Cereal Corn Flakes 500g	Hojuelas de maiz naturales	5	26	48.00	65.00	0	5	2026-04-15 00:00:00
7412	Cereal Nesquik 330g	Cereal de trigo sabor chocolate	5	19	45.00	62.00	0	5	2026-04-15 00:00:00
7413	Cereal Cheerios Miel 480g	Aros de avena y miel	5	19	58.00	78.00	0	5	2026-04-15 00:00:00
7414	Cereal Fitness Original 375g	Hojuelas de trigo integral	5	19	55.00	75.00	0	5	2026-04-15 00:00:00
7415	Cereal Special K Original 400g	Cereal de trigo y arroz	5	26	62.00	85.00	0	5	2026-04-15 00:00:00
7416	Barra Nature Valley Avena 42g	Barra de granola y miel	5	58	11.00	16.00	0	5	2026-04-15 00:00:00
7417	Barra Bran Frut Fresa 48g	Barra de trigo rellena	5	17	10.00	15.00	0	5	2026-04-15 00:00:00
7418	Avena Quaker Instantánea 10 sobres	Avena de sabores en sobre	5	25	42.00	58.00	0	5	2026-04-15 00:00:00
7419	Canela en Raja 50g	Raja de canela seleccionada	13	58	22.00	35.00	0	5	2026-04-15 00:00:00
7420	Clavo de Olor 20g	Especias para cocina	13	58	15.00	25.00	0	5	2026-04-15 00:00:00
7421	Pimienta Gorda 50g	Pimienta entera McCormick	13	58	18.00	28.00	0	5	2026-04-15 00:00:00
7422	Comino Entero 50g	Semillas de comino natural	13	58	12.00	22.00	0	5	2026-04-15 00:00:00
7423	Tomillo Seco 20g	Hierba de olor para guisos	13	58	10.00	18.00	0	5	2026-04-15 00:00:00
7424	Mejorana Seca 20g	Hierba de olor para cocina	13	58	10.00	18.00	0	5	2026-04-15 00:00:00
7425	Sazonador para Pollo 100g	Mezcla de especias para aves	13	58	18.00	28.00	0	5	2026-04-15 00:00:00
7426	Sazonador Ablandador de Carne	Sal con papaína para carnes	13	58	22.00	32.00	0	5	2026-04-15 00:00:00
7427	Sal con Ajo McCormick 100g	Sal de mesa condimentada	13	58	18.00	28.00	0	5	2026-04-15 00:00:00
7428	Sal con Cebolla McCormick 100g	Sal de mesa condimentada	13	58	18.00	28.00	0	5	2026-04-15 00:00:00
7429	Chile Piquín en Polvo 100g	Chile seco molido picante	13	58	15.00	25.00	0	5	2026-04-15 00:00:00
7430	Nuez Moscada Molida 20g	Especias para repostería	13	58	18.00	28.00	0	5	2026-04-15 00:00:00
7431	Anís Estrella 20g	Para infusiones y repostería	13	58	25.00	40.00	0	5	2026-04-15 00:00:00
7432	Mostaza McCormick 210g	Mostaza amarilla clasica	12	20	14.00	21.00	0	5	2026-04-15 00:00:00
7433	Mayonesa McCormick con Limón 190g	Mayonesa en frasco vidrio	12	20	22.00	32.00	0	5	2026-04-15 00:00:00
7434	Mayonesa McCormick con Limón 390g	Mayonesa en frasco vidrio mediana	12	20	45.00	62.00	0	5	2026-04-15 00:00:00
7435	Catsup Del Monte 320g	Salsa de tomate catsup doy pack	12	70	15.00	22.00	0	5	2026-04-15 00:00:00
7436	Catsup Heinz 397g	Salsa de tomate catsup botella	12	71	25.00	35.00	0	5	2026-04-15 00:00:00
7437	Salsa BBQ Hunts 620g	Salsa para alitas o costillas	12	58	48.00	65.00	0	5	2026-04-15 00:00:00
7438	Salsa para Pizza Ragú 400g	Salsa de tomate condimentada	12	58	35.00	48.00	0	5	2026-04-15 00:00:00
7439	Salsa Macha con Arándano 200g	Salsa artesanal aceite y chile	12	58	45.00	65.00	0	5	2026-04-15 00:00:00
7440	Salsa Casera La Morena 210g	Salsa roja picante	12	72	13.00	18.00	0	5	2026-04-15 00:00:00
7441	Pasta para Sopa La Moderna Codo 0	Pasta de trigo pequeña	2	44	7.50	11.00	0	5	2026-04-15 00:00:00
7442	Pasta para Sopa La Moderna Fideo 0	Pasta de trigo para sopa	2	44	7.50	11.00	0	5	2026-04-15 00:00:00
7443	Pasta Spaghetti La Moderna 200g	Pasta larga de sémola	2	44	8.50	12.00	0	5	2026-04-15 00:00:00
7444	Pasta Fetuccini Barilla 500g	Pasta italiana premium	2	56	25.00	35.00	0	5	2026-04-15 00:00:00
7445	Pasta Penne Rigate Barilla 500g	Pasta corta tipo pluma	2	56	25.00	35.00	0	5	2026-04-15 00:00:00
7446	Lenteja Canada Bolsa 500g	Legumbre seca seleccionada	2	58	22.00	30.00	0	5	2026-04-15 00:00:00
7447	Frijol Negro Querétaro 1kg	Frijol seco de primera calidad	2	58	35.00	48.00	0	5	2026-04-15 00:00:00
7448	Frijol Flor de Mayo 1kg	Frijol seco suave	2	58	38.00	52.00	0	5	2026-04-15 00:00:00
7449	Frijol Bayo 1kg	Frijol seco tradicional	2	58	34.00	45.00	0	5	2026-04-15 00:00:00
7450	Haba Entera Pelada 500g	Legumbre seca para sopa	2	58	28.00	42.00	0	5	2026-04-15 00:00:00
7451	Garbanzo Extra 500g	Legumbre seca grande	2	58	24.00	35.00	0	5	2026-04-15 00:00:00
7452	Maíz Palomero 500g	Maiz para palomitas granel	2	58	15.00	25.00	0	5	2026-04-15 00:00:00
7453	Arroz Integral Verde Valle 900g	Arroz con fibra natural	2	58	32.00	45.00	0	5	2026-04-15 00:00:00
7454	Aceite de Oliva Extra Virgen 250ml	Aceite de primera prensada	1	58	65.00	95.00	0	5	2026-04-15 00:00:00
7455	Aceite en Aerosol PAM 170g	Aceite vegetal para cocinar	1	58	55.00	78.00	0	5	2026-04-15 00:00:00
7456	Vinagre Tinto La Costeña 530ml	Vinagre para ensaladas	1	27	14.00	22.00	0	5	2026-04-15 00:00:00
7457	Harina de Trigo San Antonio 1kg	Harina de trigo refinada	3	41	18.00	26.00	0	5	2026-04-15 00:00:00
7458	Harina de Maíz Maseca 1kg	Harina para tortillas de maiz	3	59	19.00	27.00	0	5	2026-04-15 00:00:00
7459	Harina para Hot Cakes Pronto 800g	Mezcla lista para panquecas	10	58	28.00	40.00	0	5	2026-04-15 00:00:00
7460	Azúcar Estándar 1kg	Azucar morena de caña	3	58	26.00	35.00	0	5	2026-04-15 00:00:00
7461	Azúcar Refinada 1kg	Azucar blanca pura	3	58	32.00	42.00	0	5	2026-04-15 00:00:00
7462	Azúcar Glass 500g	Azucar pulverizada para reposteria	3	58	18.00	28.00	0	5	2026-04-15 00:00:00
7463	Piloncillo Cono 225g	Dulce de caña natural	3	58	12.00	18.00	0	5	2026-04-15 00:00:00
7464	Jarabe de Maíz Karo Bebé 250ml	Miel de maiz natural	11	58	35.00	50.00	0	5	2026-04-15 00:00:00
7465	Miel de Maple Aunt Jemima 710ml	Jarabe sabor maple original	11	58	65.00	95.00	0	5	2026-04-15 00:00:00
7466	Té Negro Lipton 20 sobres	Te negro clasico	4	58	22.00	32.00	0	5	2026-04-15 00:00:00
7467	Té Verde Twinings 20 sobres	Te verde calidad premium	4	58	45.00	65.00	0	5	2026-04-15 00:00:00
7468	Té de Limón McCormick 25 sobres	Te de hierbas natural	4	58	18.00	25.00	0	5	2026-04-15 00:00:00
7469	Chocolate Abuelita 6 tablillas	Chocolate para mesa tradicional	4	19	68.00	92.00	0	5	2026-04-15 00:00:00
7471	Cocoa Hershey's en Polvo 200g	Cocoa pura sin azucar	4	45	48.00	68.00	0	5	2026-04-15 00:00:00
7472	Café Nescafé Clásico 200g	Cafe soluble instantaneo	4	19	85.00	115.00	0	5	2026-04-15 00:00:00
7473	Café Nescafé Dolca 170g	Cafe soluble con caramelo	4	19	75.00	105.00	0	5	2026-04-15 00:00:00
7474	Café Nescafé Decaf 170g	Cafe soluble descafeinado	4	19	90.00	125.00	0	5	2026-04-15 00:00:00
7475	Café Tostado y Molido Legal 400g	Cafe para cafetera mezcla	4	58	65.00	88.00	0	5	2026-04-15 00:00:00
7476	Sustituto de Crema Coffee Mate 400g	Crema en polvo para cafe	4	19	52.00	75.00	0	5	2026-04-15 00:00:00
7477	Media Crema Nestlé 190g	Crema de leche en cajita	15	19	14.00	20.00	0	5	2026-04-15 00:00:00
7478	Bebida de Almendra Silk 946ml	Alimento liquido vegetal	15	58	38.00	55.00	0	5	2026-04-15 00:00:00
7479	Bebida de Soya Ades Natural 1L	Alimento liquido de soya	15	58	28.00	42.00	0	5	2026-04-15 00:00:00
7480	Huevo Blanco Paquete 12pza	Docena de huevos frescos	14	58	32.00	45.00	0	5	2026-04-15 00:00:00
7481	Huevo Rojo Paquete 12pza	Docena de huevos frescos rojos	14	58	35.00	48.00	0	5	2026-04-15 00:00:00
7482	Queso Philadelphia Original 190g	Queso crema tradicional	16	58	35.00	48.00	0	5	2026-04-15 00:00:00
7483	Queso Panela La Villita 400g	Queso fresco bajo en grasa	16	58	55.00	78.00	0	5	2026-04-15 00:00:00
7484	Crema Ácida Alpura 450ml	Crema de leche de vaca	17	18	28.00	40.00	0	5	2026-04-15 00:00:00
7485	Yogurt Danone Fresa 900g	Yogurt familiar batido	17	55	32.00	45.00	0	5	2026-04-15 00:00:00
7486	Chorizo de Pavo Fud 200g	Chorizo ligero empacado	18	53	22.00	32.00	0	5	2026-04-15 00:00:00
7487	Tocino Ahumado Fud 250g	Tocino de cerdo calidad	18	53	45.00	65.00	0	5	2026-04-15 00:00:00
7488	Papas Sabritas Original 160g	Papas fritas bolsa familiar	9	3	42.00	58.00	0	5	2026-04-15 00:00:00
7489	Doritos Nacho 146g	Botana de maiz sabor queso	9	3	38.00	52.00	0	5	2026-04-15 00:00:00
7490	Cheetos Torciditos 145g	Botana de maiz con queso	9	3	32.00	45.00	0	5	2026-04-15 00:00:00
7491	Ruffles Original 160g	Papas fritas onduladas	9	3	42.00	58.00	0	5	2026-04-15 00:00:00
7492	Tostitos Flamin Hot 200g	Botana picante de maiz	9	3	45.00	62.00	0	5	2026-04-15 00:00:00
7493	Cacahuates Japoneses Karate 154g	Cacahuates con cobertura crujiente	9	3	18.00	26.00	0	5	2026-04-15 00:00:00
7494	Cacahuates Salados Sabritas 180g	Cacahuates con sal familiar	9	3	35.00	48.00	0	5	2026-04-15 00:00:00
7495	Takis Fuego 190g	Botana de maiz enrollada extra picante	9	47	38.00	52.00	0	5	2026-04-15 00:00:00
7496	Chips Fuego 170g	Papas fritas picantes Barcel	9	47	45.00	62.00	0	5	2026-04-15 00:00:00
7497	Pop Karameladas Barcel 120g	Palomitas con caramelo bolsa	9	47	32.00	45.00	0	5	2026-04-15 00:00:00
7498	Pistaches con Sal 100g	Frutos secos calidad bolsa	9	58	45.00	68.00	0	5	2026-04-15 00:00:00
7499	Nuez de la India 100g	Frutos secos premium bolsa	9	58	55.00	85.00	0	5	2026-04-15 00:00:00
7500	Galletas María Gamesa 3 rollos	Paquete familiar galletas maria	29	46	38.00	52.00	0	5	2026-04-15 00:00:00
7501	Galletas Chokis Clasicas 190g	Galletas con chispas chocolate	29	46	22.00	32.00	0	5	2026-04-15 00:00:00
7502	Galletas Emperador Chocolate 273g	Galletas sandwich paquete mediano	29	46	28.00	40.00	0	5	2026-04-15 00:00:00
7503	Galletas Oreo Clasicas 273g	Galletas sandwich rellenas crema	9	58	32.00	45.00	0	5	2026-04-15 00:00:00
7504	Galletas Ritz Original 177g	Galletas saladas crujientes	9	58	18.00	28.00	0	5	2026-04-15 00:00:00
7505	Galletas Saladitas Gamesa 186g	Galletas saladas horneadas	9	46	18.00	28.00	0	5	2026-04-15 00:00:00
7506	Pan de Caja Bimbo Blanco Grande	Pan de molde clasico 680g	27	17	42.00	55.00	0	5	2026-04-15 00:00:00
7507	Pan de Caja Bimbo Integral Gde	Pan de molde con fibra 620g	27	17	48.00	62.00	0	5	2026-04-15 00:00:00
7508	Pan de Caja Oroweat Multigrano	Pan de molde premium	27	17	65.00	85.00	0	5	2026-04-15 00:00:00
7509	Pan Dulce Nito Bimbo 1pza	Pan relleno de chocolate	29	17	13.00	18.00	0	5	2026-04-15 00:00:00
7510	Leche Evaporada Carnation 360g	Leche concentrada en lata	15	19	19.00	26.00	0	5	2026-04-15 00:00:00
7511	Leche Condensada La Lechera 100g	Leche dulce en lata	15	19	13.00	16.00	0	5	2026-04-15 00:00:00
7512	Leche en Polvo Nido Fortificada 800g	Leche en polvo para niños	15	19	135.00	185.00	0	5	2026-04-15 00:00:00
7513	Leche en Polvo Alpura 1kg	Leche entera en polvo bolsa	15	18	145.00	195.00	0	5	2026-04-15 00:00:00
7514	Leche Lala Deslactosada 1L	Leche de facil digestion caja	15	4	24.00	31.00	0	5	2026-04-15 00:00:00
7515	Leche Alpura Semidescremada 1L	Leche reducida en grasa	15	18	22.00	28.00	0	5	2026-04-15 00:00:00
7516	Leche Santa Clara Entera 1L	Leche premium caja	15	16	26.00	35.00	0	5	2026-04-15 00:00:00
7517	Manteca de Cerdo 500g	Grasa animal para cocina	1	58	28.00	42.00	0	5	2026-04-15 00:00:00
7518	Mantequilla Primavera con Sal 90g	Margarina para untar	19	58	12.00	18.00	0	5	2026-04-15 00:00:00
7519	Mantequilla Gloria sin Sal 90g	Mantequilla pura de vaca	19	58	18.00	26.00	0	5	2026-04-15 00:00:00
7520	Palomitas ACT II Mantequilla	Bolsa para microondas	9	58	12.00	18.00	0	5	2026-04-15 00:00:00
7521	Pan Dulce Mantecadas Bimbo 4pza	Panecitos tipo muffin	29	17	18.00	26.00	0	5	2026-04-15 00:00:00
7522	Pan Dulce Donas Bimbo 4pza	Donas azucaradas empaque	29	17	18.00	26.00	0	5	2026-04-15 00:00:00
7523	Gansito Marinela 50g	Pastelito relleno mermelada y crema	29	22	13.00	18.00	0	5	2026-04-15 00:00:00
7524	Pingüinos Marinela 2pza	Pastelitos de chocolate rellenos	29	22	18.00	25.00	0	5	2026-04-15 00:00:00
7525	Chocotorro Marinela 1pza	Pastelito relleno de fresa	29	22	13.00	18.00	0	5	2026-04-15 00:00:00
7526	Galletas Triki-Trakes 6pza	Galletas con chispas Marinela	29	22	12.00	17.00	0	5	2026-04-15 00:00:00
7527	Galletas Canelitas 120g	Galletas sabor canela paquete mediano	29	22	18.00	28.00	0	5	2026-04-15 00:00:00
7528	Donitas Totis Sal y Limón bolsa	Botana de trigo familiar	9	58	18.00	28.00	0	5	2026-04-15 00:00:00
7529	Fritos Sal y Limón 170g	Botana de maiz crujiente	9	3	35.00	48.00	0	5	2026-04-15 00:00:00
7530	Pasta de Dientes Colgate Total 12	Cuidado bucal proteccion completa	38	30	35.00	52.00	0	5	2026-04-15 00:00:00
7531	Pasta de Dientes Colgate Triple Accion	Cuidado bucal economico 100ml	38	30	22.00	32.00	0	5	2026-04-15 00:00:00
7532	Pasta de Dientes Crest Blancura	Cuidado bucal blanqueador	38	58	28.00	40.00	0	5	2026-04-15 00:00:00
7533	Enjuague Bucal Colgate Plax 250ml	Refrescante bucal sin alcohol	38	30	38.00	55.00	0	5	2026-04-15 00:00:00
7534	Shampoo Pantene Brillo 700ml	Cuidado del cabello botella grande	35	35	75.00	105.00	0	5	2026-04-15 00:00:00
7535	Acondicionador Sedal Brillo 620ml	Cuidado del cabello desenredante	35	34	42.00	58.00	0	5	2026-04-15 00:00:00
7536	Shampoo Caprice Especialidades 750ml	Shampoo economico aromas	35	31	32.00	45.00	0	5	2026-04-15 00:00:00
7537	Crema para Peinar Sedal 300ml	Control de frizz para cabello	35	34	32.00	45.00	0	5	2026-04-15 00:00:00
7538	Gel Ego Fuerza Extrema 1kg	Gel fijador tarro grande	41	58	55.00	78.00	0	5	2026-04-15 00:00:00
7539	Jabón de Tocador Zest Aqua 135g	Jabon de barra refrescante	41	58	12.50	18.00	0	5	2026-04-15 00:00:00
7540	Jabón de Tocador Palmolive Neutro	Jabon de barra piel sensible	41	31	14.00	20.00	0	5	2026-04-15 00:00:00
7541	Desodorante Speed Stick Spray 150ml	Antitranspirante masculino	41	58	45.00	65.00	0	5	2026-04-15 00:00:00
7542	Desodorante Lady Speed Stick Stick	Antitranspirante femenino	41	58	32.00	48.00	0	5	2026-04-15 00:00:00
7543	Crema Nivea Corporal 400ml	Crema humectante botella	41	58	65.00	95.00	0	5	2026-04-15 00:00:00
7544	Vaselina Labial Proteccion 10g	Protector de labios tarro mini	41	58	15.00	22.00	0	5	2026-04-15 00:00:00
7545	Rastrillo Prestobarba 3 4pza	Rastrillos desechables paquete	41	58	75.00	105.00	0	5	2026-04-15 00:00:00
7546	Toallas Saba Nocturna 10pza	Higiene femenina flujo pesado	41	58	32.00	45.00	0	5	2026-04-15 00:00:00
7547	Protector Diario Saba 20pza	Higiene femenina uso diario	41	58	25.00	38.00	0	5	2026-04-15 00:00:00
7548	Detergente Ariel Power 1kg	Detergente en polvo multiusos	34	58	42.00	58.00	0	5	2026-04-15 00:00:00
7549	Detergente Roma 1kg	Detergente en polvo biodegradable	34	58	32.00	45.00	0	5	2026-04-15 00:00:00
7550	Jabón Zote Blanco 400g	Jabon de lavanderia en barra	34	33	22.00	30.00	0	5	2026-04-15 00:00:00
7551	Jabón Zote Rosa 400g	Jabon de lavanderia en barra	34	33	22.00	30.00	0	5	2026-04-15 00:00:00
7552	Suavizante Suavitel Fresca Primavera 1L	Suavizante de telas botella	32	32	28.00	38.00	0	5	2026-04-15 00:00:00
7553	Cloro Cloralex 950ml	Desinfectante y blanqueador	35	58	16.00	24.00	0	5	2026-04-15 00:00:00
7554	Limpiador Fabuloso Lavanda 2L	Limpiador multiusos grande	35	31	42.00	58.00	0	5	2026-04-15 00:00:00
7555	Lavatrastes Salvo Limón 900ml	Detergente liquido potente	34	58	38.00	52.00	0	5	2026-04-15 00:00:00
7556	Fibra Scotch-Brite Multiusos 2pza	Esponja para lavar platos	34	58	22.00	32.00	0	5	2026-04-15 00:00:00
7557	Bolsa para Basura Mediana 15pza	Bolsas negras con jareta	35	58	25.00	38.00	0	5	2026-04-15 00:00:00
7558	Guantes de Látex Domésticos G	Guantes para limpieza amarillos	35	58	18.00	28.00	0	5	2026-04-15 00:00:00
7559	Insecticida Raid Casa y Jardín 400ml	Spray contra insectos	35	58	58.00	82.00	0	5	2026-04-15 00:00:00
7560	Alimento Gato Whiskas Carne 1.5kg	Croquetas para gato adulto	43	58	125.00	175.00	0	5	2026-04-15 00:00:00
7561	Alimento Perro Pedigree Res 2kg	Croquetas para perro adulto	43	58	145.00	195.00	0	5	2026-04-15 00:00:00
7562	Cerveza Corona Extra 355ml 6-pack	Six pack de cerveza clara	32	58	95.00	135.00	0	5	2026-04-15 00:00:00
7563	Cerveza Victoria 355ml 6-pack	Six pack de cerveza oscura	32	58	95.00	135.00	0	5	2026-04-15 00:00:00
7564	Refresco Coca-Cola 600ml NR	Bebida de cola botella plastico	31	16	14.50	18.00	0	5	2026-04-15 00:00:00
7565	Refresco Coca-Cola 2.5L NR	Bebida de cola botella familiar	31	16	32.00	42.00	0	5	2026-04-15 00:00:00
7566	Refresco Sprite 600ml	Bebida de lima limon	31	16	13.00	17.00	0	5	2026-04-15 00:00:00
7567	Refresco Sidral Mundet 600ml	Bebida de manzana	31	16	13.00	17.00	0	5	2026-04-15 00:00:00
7568	Agua Purificada Ciel 600ml	Agua natural embotellada	30	16	9.00	13.00	0	5	2026-04-15 00:00:00
7569	Agua Purificada Bonafont 1.5L	Agua natural botella mediana	30	55	14.00	20.00	0	5	2026-04-15 00:00:00
7570	Bebida Energizante Monster 473ml	Bebida con cafeina lata	31	16	35.00	48.00	0	5	2026-04-15 00:00:00
7571	Bebida Energizante Red Bull 250ml	Bebida con cafeina lata pequeña	31	58	42.00	58.00	0	5	2026-04-15 00:00:00
7572	Sopa Maruchan Instant Lunch Pollo	Vaso de sopa instantanea 64g	12	57	11.00	16.00	0	5	2026-04-15 00:00:00
7573	Sopa Maruchan Instant Lunch Camaron	Vaso de sopa instantanea 64g	12	57	11.00	16.00	0	5	2026-04-15 00:00:00
7574	Atún Dolores en Aceite 140g	Atun en hojuelas lata	6	51	16.00	23.00	0	5	2026-04-15 00:00:00
7575	Atún Dolores en Agua 140g	Atun en hojuelas lata	6	51	16.00	23.00	0	5	2026-04-15 00:00:00
7576	Sardina en Tomate Pescador 425g	Sardinas en salsa lata	6	58	28.00	40.00	0	5	2026-04-15 00:00:00
7577	Pechuga de Pavo San Rafael Real 250g	Pechuga de pavo premium rebanada	18	52	62.00	88.00	0	5	2026-04-15 00:00:00
7578	Jamón Real de Pierna San Rafael 250g	Jamón de pierna de alta calidad	18	52	58.00	82.00	0	5	2026-04-15 00:00:00
7579	Salchicha de Pavo San Rafael 500g	Salchichas premium para asar	18	52	48.00	68.00	0	5	2026-04-15 00:00:00
7580	Salami Italiano San Rafael 100g	Salami madurado rebanado	18	52	45.00	65.00	0	5	2026-04-15 00:00:00
7581	Pastrami de Pavo San Rafael 150g	Corte de pavo sazonado premium	18	52	65.00	92.00	0	5	2026-04-15 00:00:00
7582	Lomo Ahumado San Rafael 200g	Lomo de cerdo ahumado natural	18	52	55.00	78.00	0	5	2026-04-15 00:00:00
7583	Pechuga de Pavo Balance Fud 250g	Linea saludable reducida en sodio	18	53	48.00	68.00	0	5	2026-04-15 00:00:00
7584	Jugo Jumex Mango 1L	Nectar de fruta en carton	31	21	19.00	26.00	0	5	2026-04-15 00:00:00
7585	Jugo Jumex Manzana 1L	Nectar de fruta en carton	31	21	19.00	26.00	0	5	2026-04-15 00:00:00
7586	Chorizo Salamanca San Rafael 200g	Chorizo tipo español curado	18	52	52.00	75.00	0	5	2026-04-15 00:00:00
7587	Jamón de Pierna Fud Selecto 250g	Jamón de pierna calidad extra	18	53	42.00	58.00	0	5	2026-04-15 00:00:00
7588	Tocino Premium San Rafael 250g	Tocino corte grueso ahumado	18	52	68.00	95.00	0	5	2026-04-15 00:00:00
7589	Chistorra de Res 200g	Embutido para asado premium	18	58	45.00	65.00	0	5	2026-04-15 00:00:00
7590	Queso de Puerco Tradicional 250g	Embutido de cerdo especiado	18	58	32.00	48.00	0	5	2026-04-15 00:00:00
7591	Paté de Hígado de Cerdo 100g	Crema de higado para untar	18	58	22.00	35.00	0	5	2026-04-15 00:00:00
7592	Cerveza Modelo Especial Botella 355ml	Cerveza clara premium	32	58	20.00	28.00	0	5	2026-04-15 00:00:00
7593	Cerveza Negra Modelo Botella 355ml	Cerveza oscura tipo Munich	32	58	20.00	28.00	0	5	2026-04-15 00:00:00
7594	Cerveza Modelo Ambar 355ml	Cerveza tipo viena botella	32	58	20.00	28.00	0	5	2026-04-15 00:00:00
7595	Cerveza Stella Artois 330ml	Cerveza lager importada	32	58	26.00	38.00	0	5	2026-04-15 00:00:00
7596	Cerveza Budweiser Lata 355ml	Cerveza lager americana	32	58	18.00	25.00	0	5	2026-04-15 00:00:00
7597	Cerveza Michelob Ultra 6-pack Lata	Six pack cerveza light	32	58	110.00	155.00	0	5	2026-04-15 00:00:00
7598	Cerveza Corona Extra 12-pack Lata	Paquete familiar 12 piezas	32	58	185.00	245.00	0	5	2026-04-15 00:00:00
7599	Cerveza Victoria Mega 1.2L	Cerveza oscura retorno grande	32	58	35.00	48.00	0	5	2026-04-15 00:00:00
7600	Cerveza Corona Familiar 940ml	Cerveza clara presentacion grande	32	58	32.00	45.00	0	5	2026-04-15 00:00:00
7601	Cerveza Artesanal IPA 355ml	Cerveza con alto contenido de lupulo	32	58	45.00	65.00	0	5	2026-04-15 00:00:00
7602	Cerveza Artesanal Porter 355ml	Cerveza oscura artesanal	32	58	45.00	65.00	0	5	2026-04-15 00:00:00
7603	Cerveza Heineken 0.0 Sin Alcohol	Cerveza clara sin alcohol	32	58	22.00	32.00	0	5	2026-04-15 00:00:00
7604	Cerveza Tecate Original 6-pack Lata	Six pack cerveza clara	32	58	92.00	125.00	0	5	2026-04-15 00:00:00
7605	Vino Tinto Casillero del Diablo 750ml	Vino Cabernet Sauvignon	33	58	175.00	245.00	0	5	2026-04-15 00:00:00
7606	Vino Rosado L.A. Cetto 750ml	Vino rosado nacional	33	58	145.00	195.00	0	5	2026-04-15 00:00:00
7607	Tequila Don Julio 70 700ml	Tequila añejo cristalino	33	58	850.00	1150.00	0	5	2026-04-15 00:00:00
7608	Tequila Centenario Plata 700ml	Tequila blanco 100 por ciento agave	33	58	380.00	520.00	0	5	2026-04-15 00:00:00
7609	Mezcal Amarás Joven 750ml	Mezcal artesanal de Oaxaca	33	58	550.00	750.00	0	5	2026-04-15 00:00:00
7610	Vodka Absolut Azul 750ml	Vodka sueco original	33	58	260.00	365.00	0	5	2026-04-15 00:00:00
7611	Ron Bacardi Blanco 980ml	Ron tradicional para cocteleria	33	58	195.00	275.00	0	5	2026-04-15 00:00:00
7612	Whisky Buchanan's 12 años 750ml	Whisky escoces de lujo	33	58	720.00	980.00	0	5	2026-04-15 00:00:00
7613	Ginebra Tanqueray 750ml	Ginebra premium London Dry	33	58	480.00	650.00	0	5	2026-04-15 00:00:00
7614	Brandy Torres 10 700ml	Brandy español reserva	33	58	290.00	395.00	0	5	2026-04-15 00:00:00
7615	Bloqueador Solar Nivea FPS 50	Protector solar spray 200ml	40	58	185.00	245.00	0	5	2026-04-15 00:00:00
7616	Crema Facial Pond's S 100g	Crema humectante nutritiva	40	58	52.00	75.00	0	5	2026-04-15 00:00:00
7617	Serum Loreal Revitalift Hialuronico	Suero facial hidratante 30ml	40	58	245.00	325.00	0	5	2026-04-15 00:00:00
7618	Gel Limpiador Facial Neutrogena	Jabón liquido para cara 200ml	40	58	135.00	185.00	0	5	2026-04-15 00:00:00
7619	Agua Micelar Garnier 400ml	Limpiador facial todo en uno	40	58	95.00	135.00	0	5	2026-04-15 00:00:00
7620	Crema Corporal Lubriderm Piel Seca	Hidratacion profunda 400ml	40	58	85.00	115.00	0	5	2026-04-15 00:00:00
7621	Exfoliante Corporal Dove 298g	Exfoliante de granada y manteca	40	36	110.00	155.00	0	5	2026-04-15 00:00:00
7622	Mascarilla Facial Garnier Hidra Bomb	Mascara de tela hidratante	40	58	28.00	42.00	0	5	2026-04-15 00:00:00
7623	Shampoo Anticaspa Head & Shoulders	Limpieza profunda 700ml	39	58	85.00	115.00	0	5	2026-04-15 00:00:00
7624	Shampoo Elvive Reparacion Total	Cuidado capilar 680ml	39	58	75.00	105.00	0	5	2026-04-15 00:00:00
7625	Tinte para Cabello Koleston	Coloracion permanente tonos varios	39	58	55.00	85.00	0	5	2026-04-15 00:00:00
7626	Crema para Peinar Pantene Rizos	Definicion de rizos 300ml	39	35	42.00	58.00	0	5	2026-04-15 00:00:00
7627	Desodorante Axe Black Aero 150ml	Body spray masculino	41	58	48.00	68.00	0	5	2026-04-15 00:00:00
7628	Desodorante Rexona Clinical Hombre	Antitranspirante maxima proteccion	41	58	65.00	92.00	0	5	2026-04-15 00:00:00
7629	Desodorante Dove Original Barra	Cuidado de axilas femenino	41	36	38.00	55.00	0	5	2026-04-15 00:00:00
7630	Jabón Líquido Dial Antibacterial	Jabón corporal de manos 460ml	42	58	42.00	60.00	0	5	2026-04-15 00:00:00
7631	Jabón de Barra Dove Blanco 135g	Barra de belleza humectante	42	36	18.00	26.00	0	5	2026-04-15 00:00:00
7632	Cera para Depilar Rostro Nair	Bandas de cera fria 20pza	41	58	65.00	95.00	0	5	2026-04-15 00:00:00
7633	Enjuague Bucal Colgate Total 12 500ml	Proteccion bucal avanzada	38	30	72.00	98.00	0	5	2026-04-15 00:00:00
7634	Hilo Dental Reach Mentolado	Limpieza interdental 50m	38	58	35.00	48.00	0	5	2026-04-15 00:00:00
7635	Cepillo Dental Oral-B Pro-Salud	Cepillo de cerdas suaves 2 pack	38	30	45.00	65.00	0	5	2026-04-15 00:00:00
7636	Toallas Femeninas Saba V-Natural	Toallas con extractos naturales 10pza	41	58	28.00	40.00	0	5	2026-04-15 00:00:00
7637	Pañales Adulto Depend G 10pza	Pañal para incontinencia	44	29	145.00	195.00	0	5	2026-04-15 00:00:00
7638	Cuaderno Scribe Doble Raya	Cuaderno profesional 100 hojas	36	58	24.00	35.00	0	5	2026-04-15 00:00:00
7639	Sacapuntas con Deposito Maped	Sacapuntas de plastico doble	36	58	12.00	20.00	0	5	2026-04-15 00:00:00
7640	Colores Prismacolor 12 pzas	Lapices de colores escolares	36	58	55.00	85.00	0	5	2026-04-15 00:00:00
7641	Juego de Geometría Básico	Regla escuadras y transportador	36	58	35.00	55.00	0	5	2026-04-15 00:00:00
7642	Marcatextos Sharpie Amarillo	Resaltador de tinta brillante	36	58	14.00	22.00	0	5	2026-04-15 00:00:00
7643	Tijeras Escolares punta roma	Tijeras de seguridad para niños	36	58	12.00	20.00	0	5	2026-04-15 00:00:00
7644	Diccionario Escolar Básico	Diccionario español para primaria	36	58	45.00	75.00	0	5	2026-04-15 00:00:00
7645	Plato Desechable No. 9 20 pzas	Plato de plastico blanco fiesta	45	58	32.00	48.00	0	5	2026-04-15 00:00:00
7646	Cuchara Desechable Pastelera 25pza	Cubiertos de plastico chicos	45	58	15.00	25.00	0	5	2026-04-15 00:00:00
7647	Limpiador de Vidrios Windex 750ml	Gatillo limpiador cristales	35	58	42.00	62.00	0	5	2026-04-15 00:00:00
7648	Desengrasante Mr. Músculo Cocina	Limpiador de superficies grasas	35	58	45.00	68.00	0	5	2026-04-15 00:00:00
7649	Pastilla para Tanque Harpic 2pza	Limpiador de inodoro azul	35	58	28.00	42.00	0	5	2026-04-15 00:00:00
7650	Vino Blanco Diamante 750ml	Vino blanco semidulce	33	58	165.00	235.00	0	5	2026-04-15 00:00:00
7651	Mantel de Plástico para Fiesta	Mantel rectangular de colores	45	58	22.00	38.00	0	5	2026-04-15 00:00:00
7652	Aromatizante Glade Toque 3 repuestos	Concentrado de aroma spray	35	58	52.00	78.00	0	5	2026-04-15 00:00:00
7653	Escoba de Exterior Uso Rudo	Escoba de cerdas rigidas	35	58	55.00	85.00	0	5	2026-04-15 00:00:00
7654	Jalador de Agua de Goma 40cm	Para limpieza de pisos	35	58	42.00	65.00	0	5	2026-04-15 00:00:00
7655	Bolsa Basura Jumbo 10pzas	Bolsa negra reforzada	35	58	38.00	55.00	0	5	2026-04-15 00:00:00
7656	Alimento Perro Campeon 4kg	Croquetas economicas para perro	43	58	185.00	245.00	0	5	2026-04-15 00:00:00
7657	Alimento Gato Minino Plus 1.3kg	Croquetas gourmet para gato	43	58	115.00	165.00	0	5	2026-04-15 00:00:00
7658	Arena para Gato con Aroma 5kg	Arena para desechos perfumada	43	58	75.00	105.00	0	5	2026-04-15 00:00:00
7659	Café Starbucks Pike Place 340g	Café tostado y molido premium	4	19	145.00	210.00	0	5	2026-04-15 00:00:00
7660	Cápsulas Dolce Gusto Cappuccino	Caja con 16 capsulas	4	19	135.00	185.00	0	5	2026-04-15 00:00:00
7661	Endulzante Monk Fruit 100g	Sustituto de azucar natural	3	58	85.00	125.00	0	5	2026-04-15 00:00:00
7662	Harina de Almendra 500g	Harina para cocina saludable	10	58	95.00	145.00	0	5	2026-04-15 00:00:00
7663	Quinoa Real Blanca 500g	Grano saludable de quinoa	2	58	55.00	85.00	0	5	2026-04-15 00:00:00
7664	Aceite de Coco Organico 420ml	Aceite para cocina y piel	1	58	85.00	125.00	0	5	2026-04-15 00:00:00
7665	Salsa Picante Huichol 190ml	Salsa tradicional picante	12	58	12.00	18.00	0	5	2026-04-15 00:00:00
7666	Salsa Maggi Sazonador 100ml	Salsa liquida para carnes	13	19	22.00	32.00	0	5	2026-04-15 00:00:00
7667	Salsa Inglesa Crosse & Blackwell	Salsa para marinar 145ml	13	19	24.00	35.00	0	5	2026-04-15 00:00:00
7668	Aceitunas Rellenas de Anchoa 200g	Aceitunas gourmet en frasco	6	58	35.00	52.00	0	5	2026-04-15 00:00:00
7669	Cereal Cheerios Avena y Granola	Cereal saludable Nestlé	5	19	62.00	88.00	0	5	2026-04-15 00:00:00
7670	Barra de Proteina Quest 60g	Barra alta en proteina varios sabores	5	58	45.00	68.00	0	5	2026-04-15 00:00:00
7671	Yogurt Griego Oikos Natural 150g	Yogurt cremoso sin azucar	17	55	15.00	22.00	0	5	2026-04-15 00:00:00
7672	Helado Holanda Vainilla 1L	Bote de helado cremoso	17	58	55.00	85.00	0	5	2026-04-15 00:00:00
7673	Paletas Magnum Clasica 3pza	Caja de helado cubierto chocolate	17	58	85.00	120.00	0	5	2026-04-15 00:00:00
7674	Papas Pringles Original 124g	Botana de papa en tubo	9	58	38.00	55.00	0	5	2026-04-15 00:00:00
7675	Cacahuates Mafer Salados 180g	Cacahuate premium con sal	9	58	35.00	52.00	0	5	2026-04-15 00:00:00
7676	Mezcla de Frutos Secos 200g	Arandanos nueces y almendras	9	58	45.00	68.00	0	5	2026-04-15 00:00:00
7677	Palomitas Slim Pop 110g	Palomitas de maiz con aire	9	58	28.00	42.00	0	5	2026-04-15 00:00:00
7678	Galletas Stila Avena y Fruta	Galletas nutritivas Bimbo	29	17	12.00	18.00	0	5	2026-04-15 00:00:00
7679	Pan Pita Integral Paquete 10pza	Pan plano para sandwiches	27	58	32.00	48.00	0	5	2026-04-15 00:00:00
7680	Tortillas de Harina Tía Rosa Gdes	Paquete con 10 piezas grandes	27	49	25.00	35.00	0	5	2026-04-15 00:00:00
7681	Tostadas Horneadas Sanissimo	Paquete de 20 piezas	9	61	35.00	48.00	0	5	2026-04-15 00:00:00
7682	Refresco Coca-Cola Light 600ml	Refresco sin calorias	31	16	14.50	18.00	0	5	2026-04-15 00:00:00
7683	Agua Mineral Topo Chico 600ml	Agua mineral de manantial	30	16	16.00	24.00	0	5	2026-04-15 00:00:00
7684	Jugo V8 Splash Berry Blend 1.9L	Bebida de frutas y verduras	31	58	45.00	65.00	0	5	2026-04-15 00:00:00
7685	Suero Oral Suerox 630ml	Bebida hidratante sabores varios	31	58	18.00	26.00	0	5	2026-04-15 00:00:00
7686	Energizante Bolt Lata 473ml	Bebida con cafeina economica	31	58	15.00	22.00	0	5	2026-04-15 00:00:00
7687	Vela de Olor en Vaso de Vidrio	Vela decorativa aromatica	45	58	35.00	55.00	0	5	2026-04-15 00:00:00
7688	Tarjetas de Regalo Surtidas	Tarjetas para felicitacion	45	58	15.00	35.00	0	5	2026-04-15 00:00:00
7689	Cinta Adhesiva de Color	Cinta decorativa para regalo	45	58	10.00	18.00	0	5	2026-04-15 00:00:00
7690	Papel Regalo Pliego	Hojas de papel decorado	45	58	5.00	12.00	0	5	2026-04-15 00:00:00
7691	Moño para Regalo Grande	Moño de celofan varios colores	45	58	8.00	15.00	0	5	2026-04-15 00:00:00
7692	Pilas Duracell AA 4 piezas	Baterias alcalinas larga duracion	51	38	85.00	125.00	0	5	2026-04-15 00:00:00
7693	Pilas Energizer AAA 4 piezas	Baterias alcalinas	51	39	85.00	125.00	0	5	2026-04-15 00:00:00
7694	Lampara de Emergencia Recargable	Lampara LED para fallas luz	51	58	145.00	195.00	0	5	2026-04-15 00:00:00
7695	Candado de Laton 40mm	Candado reforzado 3 llaves	51	58	65.00	95.00	0	5	2026-04-15 00:00:00
7696	Pegamento Epoxico Transparente	Pegamento dos componentes fuerte	51	58	45.00	75.00	0	5	2026-04-15 00:00:00
7697	Limpiador de Alfombras en Espuma	Limpieza de textiles y tapiceria	35	58	65.00	95.00	0	5	2026-04-15 00:00:00
7698	Detergente Liquido Mas Color 1L	Detergente para ropa oscura	34	58	38.00	55.00	0	5	2026-04-15 00:00:00
7699	Suavizante Downy Concentrado 800ml	Aroma intenso para ropa	32	58	42.00	62.00	0	5	2026-04-15 00:00:00
7700	Cubeta de Plastico con Exprimidor	Cubeta para trapear reforzada	35	58	85.00	125.00	0	5	2026-04-15 00:00:00
7701	Guantes de Nitrilo Caja 50pza	Guantes desechables de examen	35	58	120.00	185.00	0	5	2026-04-15 00:00:00
7702	Tapete de Entrada Bienvenida	Tapete de hule para puerta	51	58	65.00	95.00	0	5	2026-04-15 00:00:00
7703	Foco LED Vintage Luz Calida	Foco decorativo estilo antiguo	51	58	45.00	75.00	0	5	2026-04-15 00:00:00
7704	Cable USB C a USB C 1m	Cable de carga rapida	51	58	35.00	65.00	0	5	2026-04-15 00:00:00
7705	Audifonos de Chicharo con Microfono	Manos libres economicos	51	58	45.00	85.00	0	5	2026-04-15 00:00:00
7706	Chocolate Ferrero Rocher 16pzas	Caja de bombones de chocolate	8	40	125.00	185.00	0	5	2026-04-15 00:00:00
7707	Chocolate Hershey's Almond 40g	Barra de chocolate con almendras	8	45	13.00	18.00	0	5	2026-04-15 00:00:00
7708	Dulce Mazapan De La Rosa Gigante	Mazapan de cacahuate 50g	8	62	6.00	10.00	0	5	2026-04-15 00:00:00
7709	Gomitas Panditas Ricolino 65g	Gomitas de ositos sabores	8	67	13.00	18.00	0	5	2026-04-15 00:00:00
7710	Paleta Tutsi Pop Grande 1pza	Paleta con centro de chicle	8	65	5.00	8.00	0	5	2026-04-15 00:00:00
7711	Caramelo Suave Winis 4pza	Tira de caramelos sabores	8	58	5.00	8.00	0	5	2026-04-15 00:00:00
7712	Chicles Orbit Menta sin Azucar	Chicles en bote pequeño	8	58	18.00	28.00	0	5	2026-04-15 00:00:00
7713	Mermelada McCormick Fresa 270g	Mermelada de fruta con trozos	11	58	28.00	42.00	0	5	2026-04-15 00:00:00
7714	Kisses de Chocolate con Leche 75g	Bolsa de chocolates pequeños	8	45	28.00	42.00	0	5	2026-04-15 00:00:00
7715	Dulce de Leche Coronado 370g	Cajeta quemada tradicional	11	66	55.00	78.00	0	5	2026-04-15 00:00:00
7716	Refresco Sidral Mundet Manzana 2L	Refresco sabor manzana familiar	31	16	26.00	35.00	0	5	2026-04-15 00:00:00
7717	Quita Manchas Vanish 450g	Polvo para manchas dificiles	34	58	45.00	68.00	0	5	2026-04-15 00:00:00
7718	Arroz Super Extra Verde Valle 900g	Arroz de grano largo seleccionado	2	58	32.00	45.00	0	5	2026-04-15 00:00:00
7719	Frijol Negro Isadora Pouch 430g	Frijoles refritos listos	2	58	15.00	22.00	0	5	2026-04-15 00:00:00
7720	Atun Herdez en Agua 130g	Atun en trozos lata	6	20	17.00	24.00	0	5	2026-04-15 00:00:00
7721	Chiles Jalapeños La Costeña 220g	Chiles en escabeche lata	6	27	12.00	18.00	0	5	2026-04-15 00:00:00
7722	Granos de Elote Del Monte 225g	Maiz dulce en lata	6	70	13.00	19.00	0	5	2026-04-15 00:00:00
7723	Pure de Tomate Del Fuerte 210g	Tomate molido condimentado	12	43	7.00	11.00	0	5	2026-04-15 00:00:00
7724	Sopa Pasta Knorr de Pollo 95g	Sopa instantanea en sobre	12	58	11.00	16.00	0	5	2026-04-15 00:00:00
7725	Consome de Pollo Knorr 10 cubos	Sazonador en cubos	13	58	15.00	22.00	0	5	2026-04-15 00:00:00
7726	Sal de Mar de Grano 1kg	Sal natural no refinada	13	58	18.00	28.00	0	5	2026-04-15 00:00:00
7727	Azucar Stevia en Polvo 100g	Endulzante natural frasco	3	58	65.00	95.00	0	5	2026-04-15 00:00:00
7728	Shampoo para Bebe Johnson 400ml	Shampoo no mas lagrimas	44	58	55.00	82.00	0	5	2026-04-15 00:00:00
7729	Toallitas Humedas Huggies Cuidado	Paquete de 80 toallitas	44	29	35.00	52.00	0	5	2026-04-15 00:00:00
7730	Papilla Gerber Etapa 2 Pollo 113g	Alimento para bebe frasco	44	19	14.00	20.00	0	5	2026-04-15 00:00:00
7731	Biberon Avent Natural 9oz	Biberon ergonomico anticólicos	44	58	185.00	265.00	0	5	2026-04-15 00:00:00
7732	Crema para Peinar Herbal Essences	Hidratacion y brillo 300ml	39	58	48.00	68.00	0	5	2026-04-15 00:00:00
7733	Desodorante Gillette Clear Gel 82g	Antitranspirante transparente	41	58	55.00	78.00	0	5	2026-04-15 00:00:00
7734	Toallas Femeninas Kotex Nocturna	Toallas con alas 10pza	41	29	32.00	45.00	0	5	2026-04-15 00:00:00
7735	Cepillo de Pelo Redondo	Cepillo para peinar y secar	39	58	45.00	75.00	0	5	2026-04-15 00:00:00
7736	Cerveza Indio Mega 1.2L	Cerveza oscura presentacion familiar	32	58	35.00	48.00	0	5	2026-04-15 00:00:00
7737	Cerveza Sol Clamato Lata 473ml	Mezcla de cerveza y tomate	32	58	24.00	35.00	0	5	2026-04-15 00:00:00
7738	Cerveza Modelo Trigo 355ml	Cerveza de trigo artesanal	32	58	22.00	32.00	0	5	2026-04-15 00:00:00
7739	Cerveza XX Ambar 6-pack Botella	Six pack cerveza oscura	32	58	105.00	145.00	0	5	2026-04-15 00:00:00
7740	Cerveza Heineken Silver Lata 355ml	Cerveza clara mas ligera	32	58	20.00	28.00	0	5	2026-04-15 00:00:00
7741	Vino Tinto Sangre de Toro 750ml	Vino tinto español	33	58	185.00	265.00	0	5	2026-04-15 00:00:00
7742	Vodka Smirnoff Tamarindo 750ml	Vodka con sabor picante	33	58	240.00	345.00	0	5	2026-04-15 00:00:00
7743	Ginebra Beefeater 750ml	Ginebra clasica London Dry	33	58	450.00	620.00	0	5	2026-04-15 00:00:00
7744	Ron Captain Morgan 700ml	Ron especiado dorado	33	58	185.00	265.00	0	5	2026-04-15 00:00:00
7745	Licor 43 700ml	Licor español de vainilla	33	58	450.00	620.00	0	5	2026-04-15 00:00:00
7746	Salchicha para Hot Dog Fud 500g	Paquete de salchichas familiar	18	53	35.00	48.00	0	5	2026-04-15 00:00:00
7747	Tocino Picado para Cocinar 200g	Recortes de tocino ahumado	18	53	28.00	42.00	0	5	2026-04-15 00:00:00
7748	Chorizo Argentino para Asar 500g	Embutido premium para parrilla	18	58	75.00	110.00	0	5	2026-04-15 00:00:00
7749	Mortadela con Pistache 250g	Embutido fino rebanado	18	58	38.00	55.00	0	5	2026-04-15 00:00:00
7750	Jamón de Pavo Virginia Zwan 250g	Jamón de pavo calidad media-alta	18	58	35.00	48.00	0	5	2026-04-15 00:00:00
7751	Papas Sabritas Receta Crujiente 170g	Papas fritas con sal de mar	9	3	45.00	65.00	0	5	2026-04-15 00:00:00
7752	Doritos Pizzerola 146g	Botana de maiz sabor pizza	9	3	38.00	52.00	0	5	2026-04-15 00:00:00
7753	Tostilocos Clasicos Bolsa 200g	Botana de maiz para preparar	9	3	42.00	58.00	0	5	2026-04-15 00:00:00
7754	Papas Barcel Chips Jalapeño 170g	Papas fritas crujientes picantes	9	47	45.00	65.00	0	5	2026-04-15 00:00:00
7755	Cheetos Colmillo 150g	Botana de maiz forma colmillo	9	3	32.00	45.00	0	5	2026-04-15 00:00:00
7756	Galletas Gamesa Habaneras 117g	Galletas integrales saladas	9	46	15.00	22.00	0	5	2026-04-15 00:00:00
7757	Galletas Cuetara Surtido 400g	Caja de galletas variadas	9	58	45.00	65.00	0	5	2026-04-15 00:00:00
7758	Pan Blanco para Hot Dog Bimbo 8pza	Medias noches clasicas	27	17	32.00	45.00	0	5	2026-04-15 00:00:00
7759	Pan para Hamburguesa Bimbo 8pza	Bollos con ajonjoli	27	17	35.00	48.00	0	5	2026-04-15 00:00:00
7760	Vasos de Carton Biodegradables 10pza	Vasos para cafe o bebidas	45	58	22.00	35.00	0	5	2026-04-15 00:00:00
7761	Globos Metalicos de Numeros	Globos para aniversario o cumple	45	58	25.00	45.00	0	5	2026-04-15 00:00:00
7762	Papel Crepé varios colores	Pliego de papel para decoracion	45	58	4.00	10.00	0	5	2026-04-15 00:00:00
7763	Adorno de Guirnalda Fiesta 3m	Tira decorativa de colores	45	58	18.00	32.00	0	5	2026-04-15 00:00:00
7764	Pegamento Resistol 5000 135ml	Pegamento de contacto amarillo	51	58	45.00	68.00	0	5	2026-04-15 00:00:00
7765	Silicon Liquido Frio 100ml	Pegamento para manualidades	51	58	22.00	35.00	0	5	2026-04-15 00:00:00
7766	Cinta de Doble Cara 5m	Cinta adhesiva doble contacto	51	58	25.00	42.00	0	5	2026-04-15 00:00:00
7767	Notas Adhesivas Post-it 76x76mm	Bloc de notas de colores	36	58	22.00	38.00	0	5	2026-04-15 00:00:00
7768	Engrapadora de Oficina con Grapas	Engrapadora pequeña metalica	36	58	65.00	95.00	0	5	2026-04-15 00:00:00
7769	Agua de Coco Marva 500ml	Agua de coco natural	31	58	18.00	28.00	0	5	2026-04-15 00:00:00
7770	Te Helado Lipton Limon 600ml	Bebida de te negro	31	58	14.00	20.00	0	5	2026-04-15 00:00:00
7771	Refresco Mundet Fresa 600ml	Refresco sabor fresa	31	16	13.00	17.00	0	5	2026-04-15 00:00:00
7772	Leche deslactosada lala 1lt	Presentacion azul	15	4	18.20	23.00	13	2	2026-04-15 00:00:00
7773	Leche Lala Deslactosada 1.5L	Leche Deslactosada 1.5 Litros	15	4	32.00	39.00	0	5	2026-04-15 00:00:00
7774	Leche Alpura 250ml Chocolate	Leche saborizada Chocolate 250ml	15	18	8.50	12.00	0	5	2026-04-15 00:00:00
7775	Leche Alpura 250ml Vainilla	Leche saborizada Vainilla 250ml	15	18	8.50	12.00	0	5	2026-04-15 00:00:00
7776	Queso Americano Nutrileche 140g	Producto lacteo estilo americano	16	4	16.00	22.00	0	5	2026-04-15 00:00:00
7777	Arroz con Leche Lala 125g	Postre listo para comer	17	4	10.00	15.00	0	5	2026-04-15 00:00:00
7778	Leche de Coco Calahua 1L	Bebida de coco para cocina	15	58	38.00	55.00	0	5	2026-04-15 00:00:00
7779	Leche Formula Nan Pro 1 400g	Formula lactea etapa 1	44	19	165.00	225.00	0	5	2026-04-15 00:00:00
7780	Pepto-Bismol Suspensión 118ml	Auxiliar en malestar estomacal	50	58	55.00	78.00	0	5	2026-04-15 00:00:00
7781	Manteles Desechables Decorados 1pza	Mantel de papel para fiesta	45	58	15.00	28.00	0	5	2026-04-15 00:00:00
7782	Marcador Permanente Sharpie 2 pack	Marcador negro punta fina	36	58	35.00	55.00	0	5	2026-04-15 00:00:00
7783	Refresco Manzana Lift 600ml	Refresco de manzana natural	31	16	13.00	17.00	0	5	2026-04-15 00:00:00
7784	Rompepe Santa Clara 1L	Bebida de huevo y vainilla	33	16	145.00	195.00	0	5	2026-04-15 00:00:00
7785	Mantecadas Bimbo 4 pzas	Pan dulce sabor Vainilla 4 pzas	29	17	19.00	26.00	0	5	2026-04-15 00:00:00
7786	Fabuloso Fresca Manana 1L	Limpiador multiusos verde	35	30	22.00	30.00	0	5	2026-04-15 00:00:00
7787	Jugo Boing Mango 250ml	Bebida de fruta de carton	31	58	7.50	10.00	0	5	2026-04-15 00:00:00
7788	Pau Pau Mango 250ml	Bebida infantil con vitaminas	31	21	5.50	8.00	0	5	2026-04-15 00:00:00
7789	Recogedor de Plastico con Mango	Recogedor de basura sencillo	35	58	25.00	45.00	0	5	2026-04-15 00:00:00
7790	Mayonesa Hellmann's Clasica 390g	Mayonesa suave y cremosa	12	58	42.00	58.00	0	5	2026-04-15 00:00:00
7791	Jabón Liquido para Manos Palmolive	Repuesto economico 500ml	42	31	32.00	48.00	0	5	2026-04-15 00:00:00
\.


--
-- Data for Name: proveedores; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.proveedores (id_proveedor, nombre, contacto) FROM stdin;
3	Sabritas	9515655268
4	Lala	9511694241
10	El de las chimichangas	93332568
11	SEÑOR MARUCHAN	323602564
12	DonChito	4546153264
13	El Victorino	4546159212
14	Pepsi	553167898
15	PaliMex	9515655268
16	Coca-Cola	None
17	Bimbo	None
18	Alpura	None
19	Nestle	None
20	Herdez	None
21	Jumex	None
22	Marinela	None
23	Bachoco	None
24	San Marcos	None
25	Quaker	None
26	Kelloggs	None
27	La costena	None
28	Del Valle	None
29	Kimberly-Clark	None
30	Colgate	None
31	Palmolive	None
32	Suavitel	None
33	Zote	None
34	Sedal	None
35	Pantene	None
36	Dove	None
37	Avon	None
38	Duracell	None
39	Energizer	None
40	Ferrero	None
41	San Antonio	None
42	Tres Estrellas	None
43	Del Fuerte	None
44	La Moderna	None
45	Hersheys	None
46	Gamesa	None
47	Barcel	None
48	Wonder	None
49	Tia rosa	None
50	La Sierra	None
51	Dolores	None
52	San Rafael	9515655268
53	Fud	None
54	Yoplait	None
55	Danone	None
56	Barilla	None
57	Maruchan	None
58	Otro	None
59	Maseca	None
60	Grupo ArcaContinental	None
61	Sanissimo	None
62	De la rosa	None
63	Grupo lorena	None
65	Tutsi pop	None
66	Coronado	None
67	Ricolino	None
68	Vero	None
69	Sonrics	None
70	Del monte	None
71	Heinz	None
72	La morena	None
\.


--
-- Data for Name: registro_uso; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.registro_uso (id, fecha_inicio, ultima_fecha_uso) FROM stdin;
1	2024-07-29	2024-08-01
\.


--
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuarios (id_usuario, nombre_usuario, contrasena, rol) FROM stdin;
1	administrador	hangar81	administrador
\.


--
-- Data for Name: ventas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ventas (id_venta, fecha, total, id_usuario) FROM stdin;
1	2024-06-28 00:47:53.850183	178.00	1
2	2024-06-28 02:52:22.018199	38.00	1
3	2024-06-28 03:06:23.494544	238.00	1
4	2024-06-28 13:57:21.821779	138.00	1
5	2024-06-29 20:44:14.422632	160.00	1
6	2024-06-29 20:45:28.071314	60.00	1
8	2024-06-29 20:45:43.616931	60.00	1
9	2024-06-29 20:45:58.091242	123.00	1
10	2024-06-29 21:01:24.01889	182.50	1
11	2024-06-29 21:01:37.510788	123.00	1
12	2024-06-29 21:01:46.299115	12.50	1
13	2024-06-29 21:05:11.653218	102.00	1
14	2024-06-30 01:46:03.366854	160.00	1
15	2024-06-30 01:46:52.481865	138.00	1
16	2024-06-30 01:50:40.737031	135.00	1
17	2024-07-01 13:27:52.433849	37.50	1
18	2024-07-01 23:24:34.265441	225.00	1
19	2024-07-01 23:24:45.510945	37.50	1
20	2024-07-01 23:24:58.301607	187.50	1
21	2024-07-15 17:03:41.57952	15.00	1
22	2024-07-15 23:09:48.013351	65.00	1
23	2024-07-17 14:58:10.172432	50.00	1
24	2024-07-18 12:41:15.014617	46.00	1
25	2024-07-18 13:44:53.321278	74.00	1
26	2024-07-18 13:45:01.453889	52.50	1
27	2024-07-18 13:45:10.581771	76.00	1
28	2024-07-18 13:45:15.115391	25.50	1
29	2024-07-18 13:45:21.253371	135.00	1
30	2024-07-18 13:45:24.867677	37.50	1
31	2024-07-18 13:45:35.71236	89.00	1
32	2024-07-18 13:45:39.740805	31.00	1
33	2024-07-18 13:45:45.702569	128.00	1
34	2024-07-18 13:45:50.032415	74.00	1
35	2024-07-18 13:45:55.661729	173.50	1
36	2024-07-18 13:46:01.263912	76.00	1
37	2024-07-21 02:08:59.739741	56.50	1
38	2024-07-21 16:43:00.066877	241.00	1
39	2024-07-31 22:18:10.493297	25.00	1
40	2024-08-01 11:47:58.424592	770.50	1
41	2024-08-30 15:34:32.429639	93.50	1
42	2024-09-03 14:34:07.719084	45.00	1
43	2024-12-09 11:10:26.707539	100.00	1
44	2025-04-14 13:20:26.274982	50.00	1
45	2026-04-09 15:02:22.922832	32.50	1
46	2026-04-09 15:41:37.00258	183.00	1
\.


--
-- Name: categorias_id_categoria_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categorias_id_categoria_seq', 45, true);


--
-- Name: categorias_nar_id_categoria_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categorias_nar_id_categoria_seq', 1, false);


--
-- Name: cuentas_id_cuenta_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cuentas_id_cuenta_seq', 1, false);


--
-- Name: detalle_cuentas_id_detalle_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.detalle_cuentas_id_detalle_seq', 1, false);


--
-- Name: detalle_ventas_id_detalle_venta_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.detalle_ventas_id_detalle_venta_seq', 102, true);


--
-- Name: mesas_id_mesa_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mesas_id_mesa_seq', 1, false);


--
-- Name: movimientos_inventario_id_movimiento_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.movimientos_inventario_id_movimiento_seq', 79, true);


--
-- Name: productos_bar_id_producto_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.productos_bar_id_producto_seq', 1, false);


--
-- Name: productos_id_producto_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.productos_id_producto_seq', 364, true);


--
-- Name: productos_por_gramaje_id_producto_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.productos_por_gramaje_id_producto_seq', 1, true);


--
-- Name: productos_por_gramaje_id_serial_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.productos_por_gramaje_id_serial_seq', 1, true);


--
-- Name: productos_respaldo_id_producto_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.productos_respaldo_id_producto_seq', 7791, true);


--
-- Name: proveedores_id_proveedor_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.proveedores_id_proveedor_seq', 72, true);


--
-- Name: registro_uso_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.registro_uso_id_seq', 1, true);


--
-- Name: usuarios_id_usuario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuarios_id_usuario_seq', 1, true);


--
-- Name: ventas_id_venta_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ventas_id_venta_seq', 46, true);


--
-- Name: categorias_nar categorias_nar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorias_nar
    ADD CONSTRAINT categorias_nar_pkey PRIMARY KEY (id_categoria);


--
-- Name: categorias categorias_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorias
    ADD CONSTRAINT categorias_pkey PRIMARY KEY (id_categoria);


--
-- Name: cuentas cuentas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuentas
    ADD CONSTRAINT cuentas_pkey PRIMARY KEY (id_cuenta);


--
-- Name: detalle_cuentas detalle_cuentas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_cuentas
    ADD CONSTRAINT detalle_cuentas_pkey PRIMARY KEY (id_detalle);


--
-- Name: detalle_ventas detalle_ventas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_ventas
    ADD CONSTRAINT detalle_ventas_pkey PRIMARY KEY (id_detalle_venta);


--
-- Name: mesas mesas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mesas
    ADD CONSTRAINT mesas_pkey PRIMARY KEY (id_mesa);


--
-- Name: movimientos_inventario movimientos_inventario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movimientos_inventario
    ADD CONSTRAINT movimientos_inventario_pkey PRIMARY KEY (id_movimiento);


--
-- Name: proveedores nombre_proveedor_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proveedores
    ADD CONSTRAINT nombre_proveedor_unique UNIQUE (nombre);


--
-- Name: productos_bar productos_bar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos_bar
    ADD CONSTRAINT productos_bar_pkey PRIMARY KEY (id_producto);


--
-- Name: productos productos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos
    ADD CONSTRAINT productos_pkey PRIMARY KEY (id_producto);


--
-- Name: productos_por_gramaje productos_por_gramaje_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos_por_gramaje
    ADD CONSTRAINT productos_por_gramaje_pkey PRIMARY KEY (id_producto);


--
-- Name: productos_respaldo productos_respaldo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos_respaldo
    ADD CONSTRAINT productos_respaldo_pkey PRIMARY KEY (id_producto);


--
-- Name: proveedores proveedores_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proveedores
    ADD CONSTRAINT proveedores_pkey PRIMARY KEY (id_proveedor);


--
-- Name: registro_uso registro_uso_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.registro_uso
    ADD CONSTRAINT registro_uso_pkey PRIMARY KEY (id);


--
-- Name: usuarios usuarios_nombre_usuario_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_nombre_usuario_key UNIQUE (nombre_usuario);


--
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id_usuario);


--
-- Name: ventas ventas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ventas
    ADD CONSTRAINT ventas_pkey PRIMARY KEY (id_venta);


--
-- Name: cuentas cuentas_id_mesa_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuentas
    ADD CONSTRAINT cuentas_id_mesa_fkey FOREIGN KEY (id_mesa) REFERENCES public.mesas(id_mesa);


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
    ADD CONSTRAINT detalle_ventas_id_producto_fkey FOREIGN KEY (id_producto) REFERENCES public.productos(id_producto);


--
-- Name: detalle_ventas detalle_ventas_id_venta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_ventas
    ADD CONSTRAINT detalle_ventas_id_venta_fkey FOREIGN KEY (id_venta) REFERENCES public.ventas(id_venta);


--
-- Name: movimientos_inventario movimientos_inventario_id_producto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movimientos_inventario
    ADD CONSTRAINT movimientos_inventario_id_producto_fkey FOREIGN KEY (id_producto) REFERENCES public.productos(id_producto);


--
-- Name: productos_bar productos_bar_id_categoria_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos_bar
    ADD CONSTRAINT productos_bar_id_categoria_fkey FOREIGN KEY (id_categoria) REFERENCES public.categorias_nar(id_categoria);


--
-- Name: productos productos_id_categoria_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos
    ADD CONSTRAINT productos_id_categoria_fkey FOREIGN KEY (id_categoria) REFERENCES public.categorias(id_categoria);


--
-- Name: productos productos_id_proveedor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos
    ADD CONSTRAINT productos_id_proveedor_fkey FOREIGN KEY (id_proveedor) REFERENCES public.proveedores(id_proveedor);


--
-- Name: productos_por_gramaje productos_por_gramaje_id_categoria_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos_por_gramaje
    ADD CONSTRAINT productos_por_gramaje_id_categoria_fkey FOREIGN KEY (id_categoria) REFERENCES public.categorias(id_categoria);


--
-- Name: productos_por_gramaje productos_por_gramaje_id_proveedor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos_por_gramaje
    ADD CONSTRAINT productos_por_gramaje_id_proveedor_fkey FOREIGN KEY (id_proveedor) REFERENCES public.proveedores(id_proveedor);


--
-- Name: productos_respaldo productos_respaldo_id_categoria_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos_respaldo
    ADD CONSTRAINT productos_respaldo_id_categoria_fkey FOREIGN KEY (id_categoria) REFERENCES public.categorias(id_categoria);


--
-- Name: productos_respaldo productos_respaldo_id_proveedor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos_respaldo
    ADD CONSTRAINT productos_respaldo_id_proveedor_fkey FOREIGN KEY (id_proveedor) REFERENCES public.proveedores(id_proveedor);


--
-- Name: ventas ventas_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ventas
    ADD CONSTRAINT ventas_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuarios(id_usuario);


--
-- PostgreSQL database dump complete
--

