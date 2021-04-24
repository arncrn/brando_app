--
-- PostgreSQL database dump
--

-- Dumped from database version 12.6 (Ubuntu 12.6-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.6 (Ubuntu 12.6-0ubuntu0.20.04.1)

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
-- Name: clothing; Type: TABLE; Schema: public; Owner: arn
--

CREATE TABLE public.clothing (
    id integer NOT NULL,
    size text NOT NULL,
    brand text NOT NULL,
    type text NOT NULL,
    colors text NOT NULL,
    receipt_id integer,
    tag_number text,
    purchase_price numeric(5,2) NOT NULL,
    sold_price numeric(5,2),
    package_id integer,
    order_id integer,
    extra_info text,
    seen boolean,
    gender text,
    picture text,
    style text,
    material text,
    location text,
    date_created timestamp without time zone DEFAULT now(),
    date_sold date,
    shipping_cost numeric(5,2)
);


ALTER TABLE public.clothing OWNER TO arn;

--
-- Name: clothing_id_seq; Type: SEQUENCE; Schema: public; Owner: arn
--

CREATE SEQUENCE public.clothing_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.clothing_id_seq OWNER TO arn;

--
-- Name: clothing_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arn
--

ALTER SEQUENCE public.clothing_id_seq OWNED BY public.clothing.id;


--
-- Name: customers; Type: TABLE; Schema: public; Owner: arn
--

CREATE TABLE public.customers (
    id integer NOT NULL,
    name text NOT NULL,
    email text,
    phone text,
    address text,
    extra_info text,
    date_created timestamp without time zone DEFAULT now()
);


ALTER TABLE public.customers OWNER TO arn;

--
-- Name: customers_id_seq; Type: SEQUENCE; Schema: public; Owner: arn
--

CREATE SEQUENCE public.customers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.customers_id_seq OWNER TO arn;

--
-- Name: customers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arn
--

ALTER SEQUENCE public.customers_id_seq OWNED BY public.customers.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: arn
--

CREATE TABLE public.orders (
    id integer NOT NULL,
    date_sent date DEFAULT CURRENT_DATE,
    customer_id integer,
    status text DEFAULT 'active'::text,
    date_created timestamp without time zone DEFAULT now()
);


ALTER TABLE public.orders OWNER TO arn;

--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: arn
--

CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orders_id_seq OWNER TO arn;

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arn
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- Name: packages; Type: TABLE; Schema: public; Owner: arn
--

CREATE TABLE public.packages (
    id integer NOT NULL,
    package_name text,
    price numeric(5,2),
    date_sent date DEFAULT CURRENT_DATE,
    date_arrived date,
    date_created timestamp without time zone DEFAULT now(),
    tracking_number text
);


ALTER TABLE public.packages OWNER TO arn;

--
-- Name: packages_id_seq; Type: SEQUENCE; Schema: public; Owner: arn
--

CREATE SEQUENCE public.packages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.packages_id_seq OWNER TO arn;

--
-- Name: packages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arn
--

ALTER SEQUENCE public.packages_id_seq OWNED BY public.packages.id;


--
-- Name: receipts; Type: TABLE; Schema: public; Owner: arn
--

CREATE TABLE public.receipts (
    id integer NOT NULL,
    store text,
    tax numeric(3,2),
    purchase_date date DEFAULT CURRENT_DATE,
    date_created timestamp without time zone DEFAULT now()
);


ALTER TABLE public.receipts OWNER TO arn;

--
-- Name: receipts_id_seq; Type: SEQUENCE; Schema: public; Owner: arn
--

CREATE SEQUENCE public.receipts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.receipts_id_seq OWNER TO arn;

--
-- Name: receipts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arn
--

ALTER SEQUENCE public.receipts_id_seq OWNED BY public.receipts.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: arn
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username text NOT NULL,
    password text NOT NULL
);


ALTER TABLE public.users OWNER TO arn;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: arn
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO arn;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arn
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: clothing id; Type: DEFAULT; Schema: public; Owner: arn
--

ALTER TABLE ONLY public.clothing ALTER COLUMN id SET DEFAULT nextval('public.clothing_id_seq'::regclass);


--
-- Name: customers id; Type: DEFAULT; Schema: public; Owner: arn
--

ALTER TABLE ONLY public.customers ALTER COLUMN id SET DEFAULT nextval('public.customers_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: arn
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: packages id; Type: DEFAULT; Schema: public; Owner: arn
--

ALTER TABLE ONLY public.packages ALTER COLUMN id SET DEFAULT nextval('public.packages_id_seq'::regclass);


--
-- Name: receipts id; Type: DEFAULT; Schema: public; Owner: arn
--

ALTER TABLE ONLY public.receipts ALTER COLUMN id SET DEFAULT nextval('public.receipts_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: arn
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: clothing; Type: TABLE DATA; Schema: public; Owner: arn
--

INSERT INTO public.clothing VALUES (2509, 'S', 'Levis', 'Puffy Jacket', 'Orange', 203, '660661', 41.99, 83.93, 81, 22, 'chest: 57
length: 56
arm: 56/70', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-12 01:35:06.111203', NULL, 0.00);
INSERT INTO public.clothing VALUES (3221, 'M', 'Michael Kors', 'Dress', 'Navy', 272, '459829', 29.99, NULL, 109, NULL, 'oversized
with hood
large MK on chest
', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-21 00:31:39.12532', NULL, NULL);
INSERT INTO public.clothing VALUES (3030, 'S', 'Tommy Hilfiger', 'Dress', 'White', 233, '830536', 12.00, NULL, 111, NULL, 'with flag

chest: 51
length: 86
', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-10 00:32:36.423322', NULL, 0.00);
INSERT INTO public.clothing VALUES (2524, 'XS', 'DKNY', 'Puffy Jacket', 'Grey', NULL, '391268', 25.00, 101.79, 84, 22, 'from costco

chest: 50
length: 84
arm: 63
shoulders: 41', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-13 02:17:34.753047', NULL, 0.00);
INSERT INTO public.clothing VALUES (3532, '8', 'Armani Exchange', 'Blazer', 'Black', 287, '4365353', 39.99, NULL, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-02 23:51:15.135559', NULL, NULL);
INSERT INTO public.clothing VALUES (3688, 'XS', 'Levis', 'Sweater', 'Black', 299, '353397', 14.99, NULL, 127, NULL, 'с красн знаком на гр не утеплён 
ПОГ 51
дл 57
рук 70 от горловины', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-08 17:48:28.180453', NULL, NULL);
INSERT INTO public.clothing VALUES (45, 'N/A', 'Guess', 'Wallet', 'Black', 6, '280066', 12.99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:54.021813', NULL, NULL);
INSERT INTO public.clothing VALUES (2563, 'S', 'Calvin Klein', 'Panties', 'Purple', 208, '453155', 3.00, 0.00, 92, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-15 04:40:21.901037', NULL, 0.00);
INSERT INTO public.clothing VALUES (2431, 'M', 'Calvin Klein', 'Panties', 'White, Black', 197, '485309', 2.96, 0.00, 92, 9, 'letters all around', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-07 23:29:19.190961', NULL, 0.00);
INSERT INTO public.clothing VALUES (342, 'XS', 'Calvin Klein', 'Dress Shirt', 'White', 29, '494675', 11.22, 0.00, 92, 9, 'Female
Split back

Chest: 47
Waist: 47
Length: 73
Arm: 61', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.65769', NULL, 0.00);
INSERT INTO public.clothing VALUES (2203, 'S', 'DKNY', 'Dress Shirt', 'White', 173, '641862', 14.99, 0.00, 79, 9, 'chest: 52
length: 66
arm: 60', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-21 17:35:11.029441', NULL, 0.00);
INSERT INTO public.clothing VALUES (2365, 'L', 'Karl Lagerfeld', 'Hoodie', 'Black', 189, 'Lorh7081', 24.99, 0.00, 79, 9, 'pictures on front', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-31 15:29:33.713489', NULL, 0.00);
INSERT INTO public.clothing VALUES (2229, 'S', 'Calvin Klein', 'Tank Top', 'Grey', NULL, '123260', 10.00, 0.00, 79, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-21 18:00:11.543588', NULL, 0.00);
INSERT INTO public.clothing VALUES (333, 'XS', 'Calvin Klein', 'Hoodie', 'Blue, Grey', 28, '250868', 9.24, 0.00, 80, 9, 'zipped
blue sleeve

chest: 52
length: 54
arm: 48-68', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.580784', NULL, 0.00);
INSERT INTO public.clothing VALUES (1984, 'M', 'Tommy Hilfiger', 'Blazer', 'Black', 153, '466405', 20.00, 0.00, 80, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 11:35:21.424129', NULL, 0.00);
INSERT INTO public.clothing VALUES (2026, 'XS', 'Calvin Klein', 'Sweat Shirt', 'Black', NULL, '796472', 15.99, 0.00, 80, 9, 'stripe + "calvin" on shoulder

chest: 53
length: 58-67
arm: 43-66', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 12:25:30.416915', NULL, 0.00);
INSERT INTO public.clothing VALUES (2244, 'L', 'Tommy Hilfiger', 'Sweater', 'Navy', 177, '407347', 16.00, 0.00, 68, 9, 'deep V
', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-22 10:26:38.285919', NULL, 0.00);
INSERT INTO public.clothing VALUES (2060, '34', 'Michael Kors', 'Belt', 'Black', 157, '445996', 12.00, 0.00, 68, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-13 11:15:34.213595', NULL, 0.00);
INSERT INTO public.clothing VALUES (2230, 'XL', 'Tommy Hilfiger', 'Tank Top', 'Navy', NULL, '036607', 8.00, 0.00, 68, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-21 18:00:35.475236', NULL, 0.00);
INSERT INTO public.clothing VALUES (1972, 'S', 'Tommy Hilfiger', 'Puffy Jacket', 'Navy', NULL, '954683', 40.01, 0.00, 68, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 10:47:26.014236', NULL, 0.00);
INSERT INTO public.clothing VALUES (2202, 'XL', 'DKNY', 'Coat', 'Grey', 172, '264371', 44.99, 0.00, 68, 9, NULL, NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-01-21 17:32:29.947219', NULL, 0.00);
INSERT INTO public.clothing VALUES (2200, 'M', 'DKNY', 'Coat', 'Grey', 172, '264395', 44.99, 0.00, 68, 9, 'chest: 58
length: 92
arm: 66
shoulders: 50', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-01-21 17:31:51.061224', NULL, 0.00);
INSERT INTO public.clothing VALUES (2058, '38', 'Calvin Klein', 'Belt', 'Black', 157, '619816', 10.00, 0.00, 68, 9, 'reversible', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-13 11:13:31.755277', NULL, 0.00);
INSERT INTO public.clothing VALUES (2250, 'M', 'DKNY', 'Puffy Jacket', 'Grey', NULL, '391244', 49.99, 0.00, 67, 9, 'from costco

chest: 56
length: 88
arm: 66
shoulders: 43', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-22 10:29:28.287091', NULL, 0.00);
INSERT INTO public.clothing VALUES (2263, 'XXL', 'Tommy Hilfiger', 'Sweater', 'Navy', 179, '394840', 15.99, 0.00, 67, 9, NULL, NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-01-23 19:28:15.051665', NULL, 0.00);
INSERT INTO public.clothing VALUES (2194, 'M', 'Armani Exchange', 'Polo Shirt', 'White', 171, '421370', 19.99, 0.00, 67, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-21 17:24:54.11351', NULL, 0.00);
INSERT INTO public.clothing VALUES (2196, 'L', 'Armani Exchange', 'Polo Shirt', 'Navy', 171, '424548', 19.99, 0.00, 67, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-21 17:25:48.11451', NULL, 0.00);
INSERT INTO public.clothing VALUES (2195, 'XXL', 'Armani Exchange', 'Polo Shirt', 'White', 171, '425378', 19.99, 0.00, 67, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-21 17:25:15.544862', NULL, 0.00);
INSERT INTO public.clothing VALUES (2161, 'L', 'DKNY', 'Windbreaker', 'Purple', NULL, '525226', 34.99, 0.00, 67, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-18 16:07:38.565915', NULL, 0.00);
INSERT INTO public.clothing VALUES (2162, 'XS', 'DKNY', 'Windbreaker', 'Purple', NULL, '525646', 34.99, 0.00, 67, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-18 16:08:16.135473', NULL, 0.00);
INSERT INTO public.clothing VALUES (2164, 'M', 'DKNY', 'Windbreaker', 'Pink', NULL, '526384', 34.99, 0.00, 67, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-18 16:09:37.547241', NULL, 0.00);
INSERT INTO public.clothing VALUES (2267, 'XL', 'Tommy Hilfiger', 'Sweater', 'White', 179, '622028', 10.39, 0.00, 67, 9, 'with zipper', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-01-23 19:31:00.638282', NULL, 0.00);
INSERT INTO public.clothing VALUES (2228, 'L', 'Michael Kors', 'Hoodie', 'Salmon', NULL, '857874', 20.00, 0.00, 67, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-21 17:59:42.766363', NULL, 0.00);
INSERT INTO public.clothing VALUES (2265, 'XS', 'Tommy Hilfiger', 'Hoodie', 'Blue, White, Navy', 179, '453165', 11.99, 0.00, 67, 9, NULL, NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-01-23 19:29:48.136977', NULL, 0.00);
INSERT INTO public.clothing VALUES (2266, 'XS', 'Tommy Hilfiger', 'Sweater', 'White', 179, '622004', 10.39, 0.00, 67, 9, 'with zipper', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-01-23 19:30:37.565554', NULL, 0.00);
INSERT INTO public.clothing VALUES (1982, 'XL', 'Tommy Hilfiger', 'Sweater', 'Blue', 153, '711553', 10.00, 0.00, 67, 9, 'v-neck
chest: 61
length: 73
arm: 70', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 11:33:11.636942', NULL, 0.00);
INSERT INTO public.clothing VALUES (3222, 'L', 'Tommy Hilfiger', 'Dress', 'Black', 272, '738092', 19.99, NULL, 109, NULL, 'tommy jeans on chest
chest: 51
hips: 53
length: 86', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-21 00:33:09.389419', NULL, NULL);
INSERT INTO public.clothing VALUES (3453, 'N/A', 'Tommy Hilfiger', 'Hat', 'Navy', NULL, '521548', 9.54, 33.93, NULL, 22, 'baseball cap', NULL, 'women', NULL, NULL, NULL, NULL, '2021-03-31 17:30:36.434428', NULL, NULL);
INSERT INTO public.clothing VALUES (3616, '2', 'Armani Exchange', 'Blazer', 'Pink', 294, '4365407', 39.99, NULL, 124, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-06 20:16:31.820198', NULL, NULL);
INSERT INTO public.clothing VALUES (3689, 'M', 'Calvin Klein', 'T-Shirt', 'Black', 299, '039746', 7.49, NULL, 127, NULL, 'майка с мал бел знаком внизу
ПОГ 51
дл 50', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-08 17:50:14.397852', NULL, NULL);
INSERT INTO public.clothing VALUES (3533, '8', 'Levis', 'Shorts', 'Navy', 288, '815724', 19.99, NULL, 127, NULL, '39
49
25
46', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-03 02:21:58.397033', NULL, 0.00);
INSERT INTO public.clothing VALUES (3223, 'L', 'Tommy Hilfiger', 'Dress', 'Black', 272, '738092', 19.99, NULL, 116, NULL, 'tommy jeans on chest
chest: 51
hips: 53
length: 86', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-21 00:33:13.276594', NULL, NULL);
INSERT INTO public.clothing VALUES (2822, 'M', 'Calvin Klein', 'T-Shirt', 'White', NULL, '455638', 7.99, 25.00, 104, 22, 'укороченная, буквы в столб маломерит
ПОТ 43
длина 55
', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-04 02:01:08.013657', NULL, 0.00);
INSERT INTO public.clothing VALUES (3290, 'N/A', 'Tommy Hilfiger', 'Hat', 'White', NULL, '521524', 9.54, NULL, 122, NULL, 'baseball cap', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-23 21:14:02.345914', NULL, 0.00);
INSERT INTO public.clothing VALUES (3617, '8', 'Armani Exchange', 'Blazer', 'Pink', 294, '4365438', 39.99, NULL, 124, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-06 20:19:54.762264', NULL, 0.00);
INSERT INTO public.clothing VALUES (2174, 'XS', 'Calvin Klein', 'T-Shirt', 'Black', 168, '855780', 12.74, 17.22, 67, 9, 'gold stones

chest: 42
length: 61', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-21 16:57:35.532505', NULL, 0.00);
INSERT INTO public.clothing VALUES (3690, '30', 'Karl Lagerfeld', 'Jeans', 'Navy', 299, '510870001499', 14.99, NULL, NULL, NULL, 'stripe on the side', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-08 17:51:33.611532', NULL, NULL);
INSERT INTO public.clothing VALUES (3374, '26', 'Armani Exchange', 'Jeans', 'Grey', 283, '0458099', 29.99, 75.00, 117, NULL, 'с полоской с боку
ПОТ 32-35
ПОБ  39-44
пос 21
дл 95

', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-27 05:30:12.405315', NULL, 0.00);
INSERT INTO public.clothing VALUES (3028, 'M', 'Calvin Klein', 'Dress', 'Black', 233, '398072', 19.99, 50.00, 111, 23, 'с полоской с боку
ПОГ49
ПОБ 52
длина 90', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-10 00:31:20.776586', NULL, 0.00);
INSERT INTO public.clothing VALUES (3373, '30', 'Armani Exchange', 'Jeans', 'Grey', 283, '0458136', 29.99, 75.00, 117, 23, 'с полоской с боку
ПОТ 39-41
ПОБ  44-50
пос 24
дл 99

', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-27 05:28:10.857805', NULL, NULL);
INSERT INTO public.clothing VALUES (3534, '2', 'Levis', 'Shorts', 'Navy', 288, '815755', 19.99, NULL, 127, NULL, 'джинсовые 
36
43
23
44', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-03 02:23:12.178821', NULL, NULL);
INSERT INTO public.clothing VALUES (443, 'M', 'Calvin Klein', 'Sweat Pants', 'Black', NULL, '956951', 19.99, 26.99, 12, 9, 'silver letters', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.54653', NULL, NULL);
INSERT INTO public.clothing VALUES (444, 'XL', 'Calvin Klein', 'Gloves', 'Black', 36, '543091', 8.92, 12.06, 12, 9, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.554617', NULL, NULL);
INSERT INTO public.clothing VALUES (3291, 'N/A', 'Karl Lagerfeld', 'Purse', 'Black', NULL, '172417', 29.99, NULL, 112, NULL, 'Cat eye', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-23 22:21:15.49984', NULL, NULL);
INSERT INTO public.clothing VALUES (2158, 'L', 'DKNY', 'Puffy Jacket', 'Grey', NULL, '391237', 49.99, 101.79, 69, 21, 'from costco

chest: 59
length: 89
arm: 65
shoulders: 46', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-18 15:41:34.83188', NULL, 0.00);
INSERT INTO public.clothing VALUES (3618, '6', 'Armani Exchange', 'Blazer', 'Pink', 294, '4365421', 39.99, NULL, 124, NULL, 'ПОГ 51
дл 77
рук 61
плечи 42', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-06 20:21:13.74181', NULL, 0.00);
INSERT INTO public.clothing VALUES (3535, 'M', 'DKNY', 'Jean Jacket', 'Navy', 288, 'EOKDP667', 24.99, NULL, 125, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-03 02:24:23.87157', NULL, NULL);
INSERT INTO public.clothing VALUES (3224, 'S', 'Tommy Hilfiger', 'Dress', 'Black', 272, '868898', 19.99, NULL, 127, NULL, 'white line across chest
chest: 49
hips: 50
length: 87', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-21 00:34:26.32612', NULL, NULL);
INSERT INTO public.clothing VALUES (276, '1SZ', 'Calvin Klein', 'Scarf', 'Black', 24, '562757', 8.15, NULL, NULL, NULL, 'Mat-black-leather  square at end', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:56.066214', NULL, NULL);
INSERT INTO public.clothing VALUES (277, '1SZ', 'Calvin Klein', 'Scarf', 'Black', 24, '562757', 8.15, 11.01, NULL, 1, 'Mat-black-leather  square at end', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:56.075895', NULL, NULL);
INSERT INTO public.clothing VALUES (3115, 'M', 'Calvin Klein', 'Hoodie', 'Pink', NULL, '432097', 21.99, NULL, 107, NULL, 'white + silver letters
burlington

Chest: 56
Length: 62
Arm: 55/73

', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-13 05:02:21.429771', NULL, NULL);
INSERT INTO public.clothing VALUES (3292, 'S', 'Tommy Hilfiger', 'Windbreaker', 'Red', NULL, '866566', 29.99, NULL, 112, NULL, 'from costco', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-23 22:22:04.3773', NULL, NULL);
INSERT INTO public.clothing VALUES (3225, 'M', 'Calvin Klein', 'Windbreaker', 'Black', 273, '133627', 39.99, NULL, 115, NULL, 'Chest: 60
Waist: 56
Length: 70
Arm: 68', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-21 00:47:13.129392', NULL, 0.00);
INSERT INTO public.clothing VALUES (3377, 'S', 'Armani Exchange', 'Hoodie', 'Blue', 283, '4147508', 39.99, NULL, NULL, NULL, 'на замке в комплекте с штанами
ПОГ 51
дл 66
рук 66

', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-27 05:35:22.74924', NULL, NULL);
INSERT INTO public.clothing VALUES (3454, '0', 'Tommy Hilfiger', 'Blazer', 'Red', NULL, '??????', 50.00, 69.75, NULL, 21, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-31 21:34:57.210218', NULL, 5.00);
INSERT INTO public.clothing VALUES (3536, 'L', 'Michael Kors', 'T-Shirt', 'Black', 288, '452325', 19.99, NULL, 125, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-03 02:26:05.561948', NULL, NULL);
INSERT INTO public.clothing VALUES (3619, 'XL', 'Armani Exchange', 'Sweat Shirt', 'Black', 294, '2433127', 19.99, NULL, 118, NULL, 'неопреновый
ПОГ 59
дл 74
рук 67
плечи 56', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-04-06 20:33:30.623119', NULL, NULL);
INSERT INTO public.clothing VALUES (3692, 'M', 'Armani Exchange', 'Sweat Pants', 'Blue', 300, '7968690', 29.99, NULL, NULL, NULL, 'waist: 42
hips: 54
pasadka: 30
length: 105', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-08 23:24:20.845005', NULL, 0.00);
INSERT INTO public.clothing VALUES (493, 'XS', 'Calvin Klein', 'Jean Jacket', 'Blue', 34, '105815', 13.10, NULL, 127, NULL, 'Buttons

Chest: 53
Waist: 52
Length: 65
Arm: 57', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:57.96679', NULL, NULL);
INSERT INTO public.clothing VALUES (3293, 'S', 'Tommy Hilfiger', 'Windbreaker', 'Navy, White', NULL, '866610', 29.99, NULL, 112, NULL, 'from costco', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-23 22:22:30.016853', NULL, NULL);
INSERT INTO public.clothing VALUES (3378, 'S', 'Armani Exchange', 'Sweat Pants', 'Blue', 283, '7064552', 29.99, NULL, NULL, NULL, ' в комплекте с худи
ПОТ 40
ПОБ 50
пос 30
дл 101

', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-27 05:37:12.810264', NULL, NULL);
INSERT INTO public.clothing VALUES (3455, 'XXS', 'Karl Lagerfeld', 'Sweat Shirt', 'Black', NULL, '??????', 36.00, 60.71, NULL, 21, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-31 22:01:12.876211', NULL, 4.00);
INSERT INTO public.clothing VALUES (3226, 'M', 'Michael Kors', 'Windbreaker', 'Black', 273, '273363', 49.99, NULL, 119, NULL, 'chest: 53
length: 78
hips: 53', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-21 00:50:01.475817', NULL, NULL);
INSERT INTO public.clothing VALUES (3620, 'XL', 'Armani Exchange', 'Sweat Shirt', 'Black', 294, '2433127', 19.99, NULL, NULL, NULL, 'неопреновый
ПОГ 59
дл 74
рук 67
плечи 56', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-04-06 20:33:38.187261', NULL, NULL);
INSERT INTO public.clothing VALUES (3537, '4', 'DKNY', 'Jeans', 'Navy', 288, 'EORKP600', 21.99, NULL, 125, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-03 02:27:04.915631', NULL, NULL);
INSERT INTO public.clothing VALUES (3693, 'M', 'Armani Exchange', 'Sweat Pants', 'Blue', 300, '7968690', 29.99, NULL, NULL, NULL, 'waist: 42
hips: 54
pasadka: 30
length: 105', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-08 23:25:25.548429', NULL, 0.00);
INSERT INTO public.clothing VALUES (3145, 'S', 'Calvin Klein', 'Jean Jacket', 'White', NULL, '??????', 9.99, NULL, 107, NULL, 'chest: 47
length: 47
arm: 59
shoulders: 40', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-18 23:09:38.780963', NULL, 0.00);
INSERT INTO public.clothing VALUES (3294, 'L', 'Calvin Klein', 'Jean Jacket', 'White', NULL, '??????', 20.00, NULL, 114, NULL, 'ripped bottom
chest: 51
length: 49
arm: 59
shoulders: 42', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-23 23:27:49.485187', NULL, NULL);
INSERT INTO public.clothing VALUES (3227, 'L', 'Calvin Klein', 'Sweat Shirt', 'Black', 273, '593075', 24.99, NULL, 115, NULL, 'grey/white letters
chest: 59
length: 73
arm: 69', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-21 00:51:39.540553', NULL, NULL);
INSERT INTO public.clothing VALUES (3379, 'XL', 'Armani Exchange', 'Vest Jacket', 'Salmon', 283, '4114837', 59.99, NULL, NULL, NULL, 'персиковая 
ПОГ 52
дл 66


', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-27 05:39:16.572541', NULL, NULL);
INSERT INTO public.clothing VALUES (3456, 'XXS', 'Karl Lagerfeld', 'Sweat Shirt', 'Black', NULL, '??????', 36.00, NULL, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, NULL, '2021-03-31 22:01:18.642134', NULL, NULL);
INSERT INTO public.clothing VALUES (3621, 'XS', 'Armani Exchange', 'Sweat Shirt', 'Black', 294, '2433134', 19.99, NULL, NULL, NULL, 'неопреновый
ПОГ 48
дл 66
рук 63
плечи 53', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-04-06 20:36:19.337143', NULL, NULL);
INSERT INTO public.clothing VALUES (652, 'L', 'Tommy Hilfiger', 'Coat', 'Plaid', 41, '916780', 50.39, 68.11, 31, 9, 'missing button', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.355729', NULL, NULL);
INSERT INTO public.clothing VALUES (657, 'L', 'Tommy Hilfiger', 'Sweater', 'White', 42, '653794', 17.49, 23.89, 31, 9, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.401629', NULL, NULL);
INSERT INTO public.clothing VALUES (3228, 'L', 'Calvin Klein', 'Sweat Shirt', 'Black', 273, '593075', 24.99, NULL, NULL, NULL, 'grey/white letters
chest: 59
length: 73
arm: 69', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-21 00:51:43.281787', NULL, NULL);
INSERT INTO public.clothing VALUES (3295, '25', 'Calvin Klein', 'Jeans', 'White', NULL, '501663', 19.93, NULL, 114, NULL, 'waist: 36
hips: 46
pasadka: 23
length: 94', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-23 23:29:06.502456', NULL, NULL);
INSERT INTO public.clothing VALUES (3380, 'One Size', 'Armani Exchange', 'Purse', 'Blue', 283, '4454735', 49.99, NULL, NULL, NULL, 'лакированная


', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-27 05:41:16.597877', NULL, NULL);
INSERT INTO public.clothing VALUES (3457, 'N/A', 'Armani Exchange', 'Bag', 'White', NULL, '786539', 39.99, 82.14, NULL, 21, 'length: 42
width: 15
height: 24', NULL, 'women', NULL, NULL, NULL, NULL, '2021-03-31 22:07:54.169382', NULL, NULL);
INSERT INTO public.clothing VALUES (3622, 'L', 'Armani Exchange', 'Dress Shirt', 'White', 294, '4138995', 19.99, NULL, NULL, NULL, 'на планочке
ПОГ 54
дл 78
рук 66
плечи 49', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-04-06 20:40:03.806344', NULL, NULL);
INSERT INTO public.clothing VALUES (3695, 'XL', 'Armani Exchange', 'Hoodie', 'Blue', 300, '4147515', 39.99, NULL, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-08 23:27:34.751096', NULL, 0.00);
INSERT INTO public.clothing VALUES (3539, 'S', 'Karl Lagerfeld', 'Dress', 'Black', 288, 'LD1R9552', 19.99, NULL, 127, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-03 02:29:41.1475', NULL, NULL);
INSERT INTO public.clothing VALUES (1193, '???', 'Calvin Klein', 'unknown', 'Unknown', 105, '662946', 24.00, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.597423', NULL, NULL);
INSERT INTO public.clothing VALUES (1194, '???', 'Calvin Klein', 'unknown', 'Unknown', 105, '662595', 24.00, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.606674', NULL, NULL);
INSERT INTO public.clothing VALUES (3229, '8', 'DKNY', 'Dress', 'Blue', 274, '615302', 29.99, NULL, NULL, NULL, 'Chest: 47/55
length: 93', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-21 00:53:49.050143', NULL, NULL);
INSERT INTO public.clothing VALUES (3296, 'S', 'Tommy Hilfiger', 'Polo Shirt', 'Blue', 137, '716939', 7.19, NULL, 114, NULL, 'V-Neck
chest: 44
length: 64', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-23 23:31:18.825234', NULL, 0.00);
INSERT INTO public.clothing VALUES (3301, 'Onesize', 'DKNY', 'Purse', 'Black', NULL, '594187', 39.99, NULL, 115, NULL, '25/16/9', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-24 23:47:24.128562', NULL, NULL);
INSERT INTO public.clothing VALUES (2647, 'XL', 'Armani Exchange', 'Sweater', 'Black', 217, '336640', 30.00, 64.29, 105, 22, 'red sign A|X
chest: 59
length: 71
arm: 68', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-02-23 20:47:34.591707', NULL, 0.00);
INSERT INTO public.clothing VALUES (3458, 'XS', 'Karl Lagerfeld', 'Sweat Shirt', 'White', NULL, '??????', 37.00, 60.71, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-31 22:12:09.8455', NULL, 4.00);
INSERT INTO public.clothing VALUES (3146, '2', 'Calvin Klein', 'Dress Pants', 'Peach', NULL, '299676', 15.00, 46.43, 107, 23, 'Waist: 36
Hips: 47
Pasadka: 21
Length: 86', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-18 23:18:13.488685', NULL, 0.00);
INSERT INTO public.clothing VALUES (3694, 'XL', 'Armani Exchange', 'Hoodie', 'Blue', 300, '4147515', 39.99, 60.71, NULL, 23, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-08 23:27:10.684805', NULL, NULL);
INSERT INTO public.clothing VALUES (3691, 'XL', 'Armani Exchange', 'Sweat Pants', 'Blue', 300, '7064569', 29.99, 60.71, NULL, 23, NULL, NULL, 'men', NULL, NULL, NULL, 'usa', '2021-04-08 23:22:20.553682', NULL, 0.00);
INSERT INTO public.clothing VALUES (3376, '27', 'Armani Exchange', 'Jeans', 'Grey', 283, '0458105', 29.99, 75.00, 117, 23, 'с полоской с боку
ПОТ 33-36
ПОБ  40-45
пос 22
дл 96

', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-27 05:32:59.591921', NULL, NULL);
INSERT INTO public.clothing VALUES (3623, 'XL', 'Armani Exchange', 'Dress Shirt', 'White', 294, '4139022', 19.99, NULL, NULL, NULL, 'на планочке
ПОГ 56
дл 81
рук 70
плечи 50', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-04-06 20:42:28.278002', NULL, NULL);
INSERT INTO public.clothing VALUES (3540, 'M', 'Calvin Klein', 'T-Shirt', 'Pink', 288, '526512', 12.99, NULL, 121, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-03 02:31:16.1169', NULL, 0.00);
INSERT INTO public.clothing VALUES (3696, 'L', 'Armani Exchange', 'Hoodie', 'Blue', 300, '4147485', 39.99, NULL, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-08 23:28:23.588475', NULL, NULL);
INSERT INTO public.clothing VALUES (1165, 'L', 'Calvin Klein', 'Windbreaker', 'Black, Red', 100, '719464', 22.31, NULL, NULL, NULL, 'Chest: 59
Waist: 59
Length: 69
Arm: 67
', NULL, 'women', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:11.334911', NULL, 0.00);
INSERT INTO public.clothing VALUES (1103, '???', 'Calvin Klein', 'unknown', 'Unknown', 88, '427826', 25.36, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.750992', NULL, NULL);
INSERT INTO public.clothing VALUES (2007, 'S', 'Calvin Klein', 'Sweat Shirt', 'Black', 154, '796465', 14.05, NULL, 108, NULL, '"calvin" on shoulder
chest: 58
length: 60/70
arm: 43/66', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 12:04:39.743902', NULL, 5.67);
INSERT INTO public.clothing VALUES (3297, 'L', 'Calvin Klein', 'T-Shirt', 'Black', NULL, '779134', 12.99, NULL, 114, NULL, 'grey ck, white letters
chest: 58
length: 73
', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-23 23:36:24.19562', NULL, NULL);
INSERT INTO public.clothing VALUES (3381, 'M', 'Calvin Klein', 'Hoodie', 'Black', NULL, '??????', 29.99, 57.14, NULL, 22, 'с полоской по плечу', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-29 02:01:47.391186', NULL, 4.00);
INSERT INTO public.clothing VALUES (1655, 'M', 'Tommy Hilfiger', 'Long Sleeved Shirt', 'White', 56, '833544', 15.00, 35.00, 44, 21, 'Men''s dress shirt

Chest: 53
Waist: 51
Length:71
Arm: 63', true, 'men', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:15.886604', NULL, 3.00);
INSERT INTO public.clothing VALUES (3541, 'S', 'Calvin Klein', 'T-Shirt', 'Pink', 288, '525188', 12.99, NULL, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-03 02:31:50.975657', NULL, NULL);
INSERT INTO public.clothing VALUES (3230, '8', 'DKNY', 'Dress', 'Blue', 274, '615302', 29.99, NULL, 121, NULL, 'Chest: 47/55
length: 93', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-21 00:53:51.810447', NULL, NULL);
INSERT INTO public.clothing VALUES (3624, 'XXL', 'Armani Exchange', 'Polo Shirt', 'White', 294, '7281036', 19.99, NULL, 122, NULL, 'с орлом
ПОГ 63
дл 76
плечи 54', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-04-06 20:44:12.507093', NULL, NULL);
INSERT INTO public.clothing VALUES (3697, 'L', 'Armani Exchange', 'Hoodie', 'Blue', 300, '4147485', 39.99, NULL, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-08 23:28:43.27122', NULL, NULL);
INSERT INTO public.clothing VALUES (1169, '???', 'Calvin Klein', 'unknown', 'Unknown', 100, '421736', 11.89, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.371414', NULL, NULL);
INSERT INTO public.clothing VALUES (154, 'L', 'Levis', 'Puffy Jacket', 'Black', NULL, '052771', 59.99, 103.57, 9, 22, 'Men
Jean Puffy Jacket

Chest: 64
Waist: 63
Length: 73
Arm: 70
Shoulders: 49', true, 'men', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:55.032451', NULL, 7.85);
INSERT INTO public.clothing VALUES (3231, 'S', 'Calvin Klein', 'Dress', 'Blue', 274, '411146', 19.99, NULL, 109, NULL, '3d calvin on chest', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-21 00:54:40.556793', NULL, NULL);
INSERT INTO public.clothing VALUES (3298, 'M', 'Guess', 'Windbreaker', 'Black', NULL, '458404', 34.99, NULL, 114, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-23 23:46:22.142754', NULL, NULL);
INSERT INTO public.clothing VALUES (3382, '7.5', 'Michael Kors', 'Shoes', 'White', NULL, '??????', 58.00, 103.57, NULL, 22, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-29 02:15:55.379482', NULL, 4.00);
INSERT INTO public.clothing VALUES (3459, 'S', 'Tommy Hilfiger', 'Sweater', 'Navy', NULL, '394802', 14.44, NULL, NULL, NULL, 'chest: 52
length: 67
arm: 68', NULL, 'women', NULL, NULL, NULL, NULL, '2021-03-31 22:29:03.796292', NULL, NULL);
INSERT INTO public.clothing VALUES (3625, 'XS', 'Armani Exchange', 'T-Shirt', 'Navy', 294, '0283905', 19.99, NULL, NULL, NULL, 'с полоской по рукаву укороченная
ПОГ 53
дл 48
', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-06 20:44:45.734608', NULL, 0.00);
INSERT INTO public.clothing VALUES (3542, 'S', 'Calvin Klein', 'T-Shirt', 'Pink', 288, '411887', 12.99, NULL, 120, NULL, 'светло розовая', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-03 02:32:19.224381', NULL, NULL);
INSERT INTO public.clothing VALUES (3698, 'XL', 'Armani Exchange', 'Hoodie', 'Blue', 300, '4147515', 39.99, NULL, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-08 23:29:11.448451', NULL, 0.00);
INSERT INTO public.clothing VALUES (1230, 'XS', 'Levis', 'Trucker Jacket', 'Unknown', 108, '0120XS', 44.52, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.932907', NULL, NULL);
INSERT INTO public.clothing VALUES (1231, 'S', 'Levis', 'Trucker Jacket', 'Unknown', 108, '00150S', 20.64, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.942209', NULL, NULL);
INSERT INTO public.clothing VALUES (902, 'L', 'Tommy Hilfiger', 'Windbreaker', 'Blue', 62, '9332', 29.24, NULL, 108, NULL, 'M

Chest: 59
Waist: 52
Length:  63
Arm: 69', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:08.854782', NULL, 5.00);
INSERT INTO public.clothing VALUES (3232, 'S', 'Tommy Hilfiger', 'Blazer', 'White', 274, '235865', 24.99, NULL, 112, NULL, 'buttons along', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-21 00:55:15.109313', NULL, NULL);
INSERT INTO public.clothing VALUES (3026, '14/16', 'Calvin Klein', 'T-Shirt', 'Black', 232, '688520', 7.99, NULL, 114, NULL, 'kid clothes
blue calvin
yellow klein
white jeans
chest: 46
length: 62
', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-10 00:29:11.553123', NULL, 0.00);
INSERT INTO public.clothing VALUES (3383, 'XS', 'Karl Lagerfeld', 'Sweat Shirt', 'Black', NULL, '??????', 39.99, 53.57, NULL, 22, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-29 02:23:32.663834', NULL, 4.00);
INSERT INTO public.clothing VALUES (3460, '8', 'Calvin Klein', 'Shorts', 'Black', NULL, '928509', 10.00, NULL, 119, NULL, 'sewn-in belt', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-01 00:00:38.376386', NULL, 0.00);
INSERT INTO public.clothing VALUES (3543, 'XS', 'Calvin Klein', 'T-Shirt', 'Pink', 288, '411894', 12.99, NULL, NULL, NULL, 'светло розовая', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-03 02:32:34.988162', NULL, NULL);
INSERT INTO public.clothing VALUES (3626, 'XS', 'Armani Exchange', 'T-Shirt', 'Navy', 294, '0283905', 19.99, NULL, NULL, NULL, 'с полоской по рукаву укороченная
ПОГ 53
дл 48
', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-06 20:44:46.992122', NULL, 0.00);
INSERT INTO public.clothing VALUES (3699, 'L', 'Armani Exchange', 'Hoodie', 'Blue', 300, '4147485', 39.99, NULL, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-08 23:29:44.123135', NULL, NULL);
INSERT INTO public.clothing VALUES (1195, 'XS', 'Calvin Klein', 'T-Shirt', 'Pink', 105, '860548', 6.33, NULL, NULL, NULL, 'Black CK, silver letters on front', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.615287', NULL, NULL);
INSERT INTO public.clothing VALUES (388, 'M', 'Tommy Hilfiger', 'Sweat Shirt', 'Blue', 31, '439077', 29.99, NULL, 108, NULL, 'Men

chest: 58
length: 70
arm: 59/77', true, 'men', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.061468', NULL, 5.38);
INSERT INTO public.clothing VALUES (3233, '27', 'Levis', 'Shorts', 'Navy', 274, '647518', 12.99, NULL, 109, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-21 00:57:03.213041', NULL, NULL);
INSERT INTO public.clothing VALUES (3384, 'XXXL', 'Tommy Hilfiger', 'T-Shirt', 'White', NULL, '079211', 7.58, 25.00, NULL, 22, NULL, NULL, 'women', NULL, NULL, NULL, NULL, '2021-03-29 02:28:07.615958', NULL, NULL);
INSERT INTO public.clothing VALUES (3461, 'S', 'Tommy Hilfiger', 'T-Shirt', 'White', NULL, '747919', 14.00, NULL, 119, NULL, 'picture of blue squares', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-04-01 00:10:08.079899', NULL, 0.00);
INSERT INTO public.clothing VALUES (3299, 'L', 'Armani Exchange', 'Jean Jacket', 'Black', NULL, '2548609', 39.00, NULL, 121, NULL, NULL, NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-24 23:40:51.163968', NULL, NULL);
INSERT INTO public.clothing VALUES (3544, 'L', 'Michael Kors', 'T-Shirt', 'White', 288, '452776', 19.99, NULL, NULL, NULL, 'с замком на груди
ПОГ 50
дл 63
', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-03 02:33:51.533139', NULL, NULL);
INSERT INTO public.clothing VALUES (3700, '4T', 'Calvin Klein', 'Vest', 'Black', NULL, '400153', 12.97, NULL, 126, NULL, 'kid clothes', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-09 02:23:51.789278', NULL, NULL);
INSERT INTO public.clothing VALUES (1205, 'XS', 'Calvin Klein', 'T-Shirt', 'Black', 105, '858088', 12.59, NULL, NULL, NULL, 'Gold CK, white letters on front', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.706895', NULL, NULL);
INSERT INTO public.clothing VALUES (2507, 'L', 'Levis', 'Sherpa', 'White, Blue', 203, '944704', 29.99, 67.86, 81, 22, 'fluffy white on arms/body
jean chest/neck

chest: 56
length: 61
arm: 58', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-11 23:38:55.035006', NULL, 0.00);
INSERT INTO public.clothing VALUES (3234, '28', 'Levis', 'Shorts', 'Navy', 274, '987469', 12.99, NULL, 109, NULL, '987469
', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-21 00:57:13.886678', NULL, NULL);
INSERT INTO public.clothing VALUES (3300, 'L', 'Calvin Klein', 'Polo Shirt', 'Black', NULL, '294521', 19.99, NULL, 116, NULL, 'ПОГ 56
длина 71', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-24 23:44:56.620864', NULL, 0.00);
INSERT INTO public.clothing VALUES (3385, 'XXXL', 'Tommy Hilfiger', 'T-Shirt', 'White', NULL, '079211', 7.58, 25.00, NULL, 22, NULL, NULL, 'women', NULL, NULL, NULL, NULL, '2021-03-29 02:28:14.332833', NULL, NULL);
INSERT INTO public.clothing VALUES (3462, 'L', 'Tommy Hilfiger', 'Polo Shirt', 'White', NULL, '874547', 14.00, NULL, 119, NULL, 'red collar', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-04-01 00:11:09.800808', NULL, NULL);
INSERT INTO public.clothing VALUES (3545, 'S', 'Calvin Klein', 'T-Shirt', 'Pink', 288, '117987', 12.99, NULL, NULL, NULL, 'белые буквы calvin jn chest
ПОГ 44
дл  59
', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-03 02:35:25.401579', NULL, NULL);
INSERT INTO public.clothing VALUES (3701, '6T', 'Calvin Klein', 'Vest', 'Black', NULL, '400177', 12.97, NULL, 126, NULL, 'kid clothes', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-09 02:27:41.472418', NULL, NULL);
INSERT INTO public.clothing VALUES (1240, 'L', 'Levis', 'T-Shirt', 'Unknown', 108, '00420L', 8.00, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:12.024479', NULL, NULL);
INSERT INTO public.clothing VALUES (1241, 'S', 'Levis', 'T-Shirt', 'Unknown', 108, '04560S', 8.00, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:12.039015', NULL, NULL);
INSERT INTO public.clothing VALUES (1242, 'S', 'Levis', 'T-Shirt', 'Unknown', 108, '04570S', 7.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:12.052504', NULL, NULL);
INSERT INTO public.clothing VALUES (2151, 'S', 'DKNY', 'Puffy Jacket', 'Black', NULL, '391329', 49.99, 101.79, 63, 22, 'from costco

chest: 53
length: 87
arm: 63
shoulders: 42', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-18 15:39:10.392997', NULL, 0.00);
INSERT INTO public.clothing VALUES (3235, 'S', 'Levis', 'Hoodie', 'Black', 275, '310325', 23.99, NULL, NULL, NULL, 'fleece
levis sign on chest
chest: 52
length: 66', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-21 01:02:28.578445', NULL, NULL);
INSERT INTO public.clothing VALUES (3463, 'M', 'Tommy Hilfiger', 'T-Shirt', 'Black', NULL, '926024', 14.00, NULL, 119, NULL, 'picture of blue sqyares', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-04-01 00:12:12.130808', NULL, NULL);
INSERT INTO public.clothing VALUES (3386, 'XS', 'Calvin Klein', 'Hoodie', 'Grey', NULL, '524945', 29.99, NULL, 121, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-29 03:15:18.589428', NULL, NULL);
INSERT INTO public.clothing VALUES (1227, 'XS', 'Levis', 'Hoodie', 'Unknown', 107, '0160XS', 19.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.906609', NULL, NULL);
INSERT INTO public.clothing VALUES (3546, 'S', 'Calvin Klein', 'Pants', 'Tan', 288, '436588002299', 22.99, NULL, 122, NULL, 'Cropped', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-03 02:36:02.200657', NULL, 0.00);
INSERT INTO public.clothing VALUES (3702, '6T', 'Calvin Klein', 'Vest', 'Black', NULL, '400573', 12.97, NULL, 126, NULL, 'kid clothes', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-04-09 02:28:13.949927', NULL, NULL);
INSERT INTO public.clothing VALUES (1168, 'M', 'Calvin Klein', 'T-Shirt', 'Black', 100, '711315', 11.89, NULL, NULL, NULL, 'White CK, grey letters on front', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.361569', NULL, NULL);
INSERT INTO public.clothing VALUES (1114, 'XS', 'Calvin Klein', 'T-Shirt', 'Black', 88, '858088', 12.75, NULL, NULL, NULL, 'Gold CK, white letters on front', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.860698', NULL, NULL);
INSERT INTO public.clothing VALUES (2127, 'S', 'Tommy Hilfiger', 'Windbreaker', 'Blue', 164, '686331', 31.99, 66.43, 81, 22, 'chest: 50
length: 66
arm: 61/63
shoulders: 40', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-16 18:51:25.9155', NULL, 4.44);
INSERT INTO public.clothing VALUES (3236, '25X32', 'Levis', 'Jeans', 'Navy', 275, '487481', 23.99, NULL, NULL, NULL, 'women
ribcage straight

waist: 33
hips: 44
length: 109
pasadka: 28', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-21 01:02:40.254449', NULL, 0.00);
INSERT INTO public.clothing VALUES (665, 'N/A', 'Armani Exchange', 'Purse', 'Black', 32, '767493', 39.99, 54.61, 31, 9, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.472301', NULL, NULL);
INSERT INTO public.clothing VALUES (58, 'S', 'Calvin Klein', 'Hoodie', 'Mint', 7, '827619', 29.75, 57.14, NULL, 22, 'Black "Calvin" across chest
Belly Pocket

Chest: 55
Waist: 53
Length: 52
Arm: 70', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.148026', NULL, NULL);
INSERT INTO public.clothing VALUES (3302, '4', 'Calvin Klein', 'Dress', 'Pink', NULL, '998128', 19.99, NULL, 115, NULL, 'Светло розовое с воротником воланом
ПОГ 44
ПОТ 36
ПОБ 45
дл 98', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-24 23:51:26.24094', NULL, NULL);
INSERT INTO public.clothing VALUES (3464, 'M', 'Tommy Hilfiger', 'T-Shirt', 'White', NULL, '747926', 14.00, NULL, 119, NULL, 'picture of blue sqyares', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-04-01 00:12:32.382528', NULL, NULL);
INSERT INTO public.clothing VALUES (3387, 'XS', 'Calvin Klein', 'Sweat Pants', 'Grey', NULL, '474509', 19.99, NULL, 121, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-29 03:19:03.622445', NULL, NULL);
INSERT INTO public.clothing VALUES (3547, 'S', 'Calvin Klein', 'Hoodie', 'Tan', 288, '436502002299', 22.99, NULL, 122, NULL, 'sleeveless', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-03 02:36:34.653619', NULL, 0.00);
INSERT INTO public.clothing VALUES (3703, '5T', 'Calvin Klein', 'Vest', 'Black', NULL, '400566', 12.97, NULL, 126, NULL, 'kid clothes', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-04-09 02:28:34.169953', NULL, NULL);
INSERT INTO public.clothing VALUES (2564, 'M', 'Calvin Klein', 'Sweat Shirt', 'Black', 208, '782155', 37.62, 57.14, 84, 22, 'zipped
striped calvin klein on sleeve

chest: 52
length: 68
arm: 65', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-02-15 04:40:41.964555', NULL, 0.00);
INSERT INTO public.clothing VALUES (746, 'XS', 'Tommy Hilfiger', 'Hoodie', 'Navy', 49, '430739', 27.99, 0.00, 34, 22, 'zipper
gold cursive "hilfiger" on chest

Chest: 48
length: 60
arm: 57', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.17928', NULL, 0.00);
INSERT INTO public.clothing VALUES (3388, 'S', 'Calvin Klein', 'Sweat Pants', 'Pink', NULL, '549504', 29.99, NULL, 117, NULL, 'светло розовые со швом наружу на поясе', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-29 03:23:01.336834', NULL, NULL);
INSERT INTO public.clothing VALUES (3465, 'M', 'Tommy Hilfiger', 'Polo Shirt', 'Green', NULL, '694916', 14.00, NULL, 119, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-01 00:13:05.642903', NULL, 0.00);
INSERT INTO public.clothing VALUES (3548, '6.5', 'Michael Kors', 'Shoes', 'Tan', 288, '861647004999', 49.99, NULL, NULL, NULL, 'heels', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-03 02:40:03.412524', NULL, NULL);
INSERT INTO public.clothing VALUES (3631, '4', 'Armani Exchange', 'Blazer', 'Black', 294, '4365735', 39.99, NULL, 124, NULL, 'с полоской с боку
ПОГ 49
дл 72
плечи 40
рукав 62', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-06 20:58:49.738081', NULL, 0.00);
INSERT INTO public.clothing VALUES (3704, '3T', 'Calvin Klein', 'Vest', 'Black', NULL, '400542', 12.97, NULL, 126, NULL, 'kid clothes', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-04-09 02:28:50.721947', NULL, 0.00);
INSERT INTO public.clothing VALUES (1464, 'XS', 'Tommy Hilfiger', 'Shorts', 'Navy', 135, '787137', 15.99, NULL, 127, NULL, 'waist: 36
hips: 49
length: 30
pasadka: 25', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:14.120208', NULL, NULL);
INSERT INTO public.clothing VALUES (3058, '9', 'Calvin Klein', 'Flip Flops', 'Brown', 234, '949084', 14.99, 20.28, 91, 9, 'коричневый лого верх', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-11 22:38:03.795946', NULL, 0.00);
INSERT INTO public.clothing VALUES (479, 'S', 'Calvin Klein', 'Vest Jacket', 'Black, Grey', 37, '067670', 10.49, 64.29, 78, 22, 'women vest
grey hood

chest: 48
length: 67/73', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.849777', NULL, 0.00);
INSERT INTO public.clothing VALUES (3237, 'S', 'Calvin Klein', 'Sweat Pants', 'Tan', NULL, '??????', 19.99, 46.43, NULL, 22, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-21 01:38:02.526372', NULL, NULL);
INSERT INTO public.clothing VALUES (3304, '9', 'Calvin Klein', 'Flip Flops', 'Black', NULL, '733782', 26.29, NULL, 115, NULL, 'шлёпки с лентами
размер 9 стелька 27 см', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-25 00:04:16.817407', NULL, NULL);
INSERT INTO public.clothing VALUES (3389, 'M', 'Calvin Klein', 'T-Shirt', 'White', NULL, '455638', 7.99, NULL, 117, NULL, 'укороченная, буквы в столб маломерит
ПОТ 43
длина 55
', NULL, 'women', NULL, NULL, NULL, NULL, '2021-03-29 03:26:53.999047', NULL, NULL);
INSERT INTO public.clothing VALUES (3466, 'M', 'DKNY', 'Dress Shirt', 'Black', NULL, '607181', 19.98, NULL, 120, NULL, 'short sleeves', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-04-01 00:26:50.659997', NULL, NULL);
INSERT INTO public.clothing VALUES (3549, '8', 'Calvin Klein', 'Shoes', 'Tan', 288, '518572002499', 24.99, NULL, NULL, NULL, 'gold', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-03 02:40:46.437453', NULL, NULL);
INSERT INTO public.clothing VALUES (3632, '4', 'Armani Exchange', 'Blazer', 'Black', 294, '4365735', 39.99, NULL, 124, NULL, 'с полоской с боку
ПОГ 49
дл 72
плечи 40
рукав 62', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-06 20:59:23.844072', NULL, 0.00);
INSERT INTO public.clothing VALUES (3705, '5T', 'Calvin Klein', 'Vest', 'Pink', NULL, '400511', 12.97, NULL, 126, NULL, 'kid clothes', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-09 02:29:21.869913', NULL, NULL);
INSERT INTO public.clothing VALUES (1506, 'N/A', 'Tommy Hilfiger', 'Unknown', 'Unknown', 138, '948033', 7.49, NULL, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:14.504761', NULL, 0.00);
INSERT INTO public.clothing VALUES (849, 'S', 'Calvin Klein', 'Sweat Shirt', 'White', NULL, '623277', 29.99, NULL, NULL, NULL, 'stripe on sleeve "calvin"', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:01.046642', NULL, NULL);
INSERT INTO public.clothing VALUES (1643, 'S', 'Calvin Klein', 'Sweater', 'Purple', 56, '958542', 0.00, 50.00, 43, 22, 'High neck

Chest: 61
Waist: 53
Length: 57
Arm: 42', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:15.774018', NULL, NULL);
INSERT INTO public.clothing VALUES (3238, 'M', 'Calvin Klein', 'T-Shirt', 'Black', NULL, '??????', 12.99, 25.00, NULL, NULL, NULL, NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-03-21 01:50:12.437379', NULL, 0.00);
INSERT INTO public.clothing VALUES (3390, 'S', 'Calvin Klein', 'Sweat Shirt', 'White', NULL, '457212', 19.99, NULL, 117, NULL, 'белый свитшот с черн знаком СК не утеплён', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-29 03:29:19.785666', NULL, NULL);
INSERT INTO public.clothing VALUES (3467, 'M', 'Calvin Klein', 'Leggings', 'Black', NULL, '429929', 19.99, NULL, 121, NULL, 'calvin klein jeans on back of waist and down side', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-01 00:31:13.42856', NULL, NULL);
INSERT INTO public.clothing VALUES (3550, 'XL', 'Calvin Klein', 'Hoodie', 'Black', 289, '872122', 29.99, NULL, NULL, NULL, 'Zipped small sign CK on chest
chest 62
L 73
SL 67', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-04-03 02:49:58.342967', NULL, NULL);
INSERT INTO public.clothing VALUES (3392, '7', 'Calvin Klein', 'Shoes', 'Black', 284, '164632', 34.99, NULL, 127, NULL, 'кроссовки неопрен надпись на резинке
размер 7 стелька 24 см', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-29 04:02:45.518957', NULL, NULL);
INSERT INTO public.clothing VALUES (336, 'M', 'Michael Kors', 'Sweater', 'White', 30, '066509', 20.00, 27.00, NULL, 8, 'black stripes

chest: 50
length: 63
arm: 65', NULL, 'women', NULL, NULL, NULL, 'usa', '2020-12-21 01:07:56.606135', NULL, 0.00);
INSERT INTO public.clothing VALUES (339, 'S', 'Tommy Hilfiger', 'Sweater', 'Navy', 30, '130474', 13.00, 17.55, NULL, 8, 'golfik
ribbed lines on chest

chest: 45
length: 61
arm: 59', NULL, 'women', NULL, NULL, NULL, 'usa', '2020-12-21 01:07:56.631264', NULL, 0.00);
INSERT INTO public.clothing VALUES (283, 'S', 'Michael Kors', 'Puffy Jacket', 'Red', NULL, '336273', 99.00, 140.00, 5, NULL, 'Original price 140
sold for 180', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.12888', NULL, NULL);
INSERT INTO public.clothing VALUES (3406, 'S', 'Adidas', 'Skirt', 'Pink', 284, '728101', 19.99, NULL, 127, NULL, 'плесированная

ПОТ 31-41
дл 80', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-29 04:24:39.823469', NULL, NULL);
INSERT INTO public.clothing VALUES (455, 'XS', 'Calvin Klein', 'Sweat Shirt', 'Black', 37, '962518', 8.78, NULL, NULL, NULL, 'Big silver payetki letters

chest: 51
length: 52
arm: 58/70', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.648483', NULL, NULL);
INSERT INTO public.clothing VALUES (1164, '???', 'Calvin Klein', 'unknown', 'Unknown', 100, '528137', 9.40, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.325408', NULL, NULL);
INSERT INTO public.clothing VALUES (523, '1SZ', 'Calvin Klein', 'Hat', 'Black', 38, '555766', 10.49, NULL, NULL, NULL, 'beanie cap
white sign', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:58.236737', NULL, NULL);
INSERT INTO public.clothing VALUES (524, '1SZ', 'Calvin Klein', 'Hat', 'Black', 38, '555766', 10.49, NULL, NULL, NULL, 'beanie cap
white sign', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:58.245576', NULL, NULL);
INSERT INTO public.clothing VALUES (536, '36', 'Levis', 'Belt', 'Brown', 39, '294735', 10.39, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:58.352123', NULL, NULL);
INSERT INTO public.clothing VALUES (537, '38', 'Levis', 'Belt', 'Black', 39, '758684', 10.39, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:58.35999', NULL, NULL);
INSERT INTO public.clothing VALUES (539, '38', 'Levis', 'Belt', 'Black', 39, '758684', 10.39, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:58.376789', NULL, NULL);
INSERT INTO public.clothing VALUES (3305, 'M', 'Calvin Klein', 'Dress', 'Black', NULL, '402601', 19.99, 50.00, 115, 23, 'с полоской по плечу 
ПОГ 50
дл 94', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-25 01:33:00.646458', NULL, NULL);
INSERT INTO public.clothing VALUES (3630, '10', 'Armani Exchange', 'Blazer', 'Black', 294, '4365698', 39.99, 100.00, NULL, 23, 'Stripe on side
chest: 54
length: 78
shoulders: 43
arm: 62', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-06 20:56:28.295683', NULL, 0.00);
INSERT INTO public.clothing VALUES (540, '31', 'Levis', 'Jeans', 'Unknown', 39, '203132', 27.80, 40.00, NULL, NULL, '514 straight burch', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:58.385067', NULL, NULL);
INSERT INTO public.clothing VALUES (1104, 'XS', 'Calvin Klein', 'T-Shirt', 'Black', 88, '711292', 12.75, NULL, NULL, NULL, 'white CK, grey letters on front', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.76559', NULL, NULL);
INSERT INTO public.clothing VALUES (571, 'N/A', 'Tommy Hilfiger', 'Purse', 'Black', NULL, '647456', 18.99, NULL, NULL, NULL, 'shiny', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:58.655299', NULL, NULL);
INSERT INTO public.clothing VALUES (572, 'N/A', 'Calvin Klein', 'Airpod Case', 'Black', 36, '564427', 8.92, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:58.663496', NULL, NULL);
INSERT INTO public.clothing VALUES (1930, 'N/A', 'Karl Lagerfeld', 'Credit Card Holder', 'Black', NULL, '893483', 0.00, NULL, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'Ukraine', '2021-01-03 04:11:25.727998', NULL, 0.00);
INSERT INTO public.clothing VALUES (574, '1SZ', 'Calvin Klein', 'Scarf', 'Black', 36, '562818', 11.89, NULL, NULL, NULL, 'Scarf + hat', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:58.680545', NULL, NULL);
INSERT INTO public.clothing VALUES (577, 'S', 'Calvin Klein', 'Hoodie', 'Pink', 36, '784660', 14.88, NULL, NULL, NULL, 'vertical and horizontal white words all over front

Chest: 51
length: 52
arm: 50/66', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:58.707374', NULL, NULL);
INSERT INTO public.clothing VALUES (2204, 'XS', 'DKNY', 'Dress Shirt', 'White', 173, '641879', 14.99, NULL, 103, 9, 'chest: 50
length: 63/74
arm: 59', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-01-21 17:36:26.659859', NULL, 0.00);
INSERT INTO public.clothing VALUES (583, '1SZ', 'Calvin Klein', 'Scarf', 'Olive', 36, '562764', 8.92, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:58.757849', NULL, NULL);
INSERT INTO public.clothing VALUES (865, 'S', 'Calvin Klein', 'Dress', 'Black', 58, '899353', 8.16, 33.93, 43, 22, 'Stripe on side

Chest: 47
Waist: 47
Length: 82
Arm: 58
', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:08.491282', NULL, NULL);
INSERT INTO public.clothing VALUES (2135, 'M', 'Calvin Klein', 'Hoodie', 'Salmon', 166, '432141', 21.99, 50.00, 81, 22, 'chest: 56
length: 61
arm: 55/74', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-16 19:01:42.89705', NULL, 0.00);
INSERT INTO public.clothing VALUES (3391, 'XL', 'Armani Exchange', 'Windbreaker', 'Black', NULL, '3933639', 29.99, NULL, 117, NULL, 'замок на половину
ПОГ 66
ДЛ 83
рук 67
плечи 54', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-29 03:34:25.436876', NULL, 0.00);
INSERT INTO public.clothing VALUES (452, 'XS', 'Calvin Klein', 'Satin Pants', 'Black', 34, '549462', 10.57, 42.86, NULL, 22, 'waist: 36
hips: 50
Length: 96', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.623214', NULL, NULL);
INSERT INTO public.clothing VALUES (3220, 'S', 'Michael Kors', 'Dress', 'Navy', 272, '459812', 29.99, NULL, 120, NULL, 'oversized
with hood
large MK on chest
chest: 54
length: 87
arm: 52/69', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-21 00:31:17.402877', NULL, NULL);
INSERT INTO public.clothing VALUES (522, '1SZ', 'Calvin Klein', 'Hat', 'Black', 38, '555766', 10.49, 32.14, NULL, 22, 'beanie cap
white sign', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:58.228759', NULL, NULL);
INSERT INTO public.clothing VALUES (584, '1SZ', 'Calvin Klein', 'Hat', 'Olive', 36, '562795', 8.92, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:58.766491', NULL, NULL);
INSERT INTO public.clothing VALUES (585, '1SZ', 'Calvin Klein', 'Hat', 'Olive', 36, '562795', 8.92, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:58.774447', NULL, NULL);
INSERT INTO public.clothing VALUES (586, '1SZ', 'Calvin Klein', 'Hat', 'Black', 36, '562788', 8.92, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:58.783099', NULL, NULL);
INSERT INTO public.clothing VALUES (3306, 'One Size', 'DKNY', 'Purse', 'Black', 279, '857332', 39.99, NULL, 120, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-25 02:55:48.075968', NULL, NULL);
INSERT INTO public.clothing VALUES (440, 'M', 'Tommy Hilfiger', 'Hoodie', 'Black', NULL, '238032', 22.99, 31.04, 12, 9, 'Fluffy
zipper
red boob
white boob', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.511123', NULL, NULL);
INSERT INTO public.clothing VALUES (431, 'N/A', 'Calvin Klein', 'Bag', 'White', 34, '269438', 17.02, 22.93, 13, 9, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.432732', NULL, NULL);
INSERT INTO public.clothing VALUES (432, 'N/A', 'Calvin Klein', 'Bag', 'Black', 34, '269452', 17.02, 22.93, 13, 9, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.441448', NULL, NULL);
INSERT INTO public.clothing VALUES (3551, 'XL', 'Calvin Klein', 'Hoodie', 'Black', 289, '872122', 29.99, NULL, NULL, NULL, 'Zipped small sign CK on chest
chest 62
L 73
SL 67', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-04-03 02:50:31.332741', NULL, NULL);
INSERT INTO public.clothing VALUES (433, 'L', 'Calvin Klein', 'Long sleeved shirt', 'Black', 34, '579440', 9.24, 12.45, 13, 9, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.449796', NULL, NULL);
INSERT INTO public.clothing VALUES (434, 'L', 'Calvin Klein', 'Satin Pants', 'Black', 34, '549493', 10.57, 14.24, 13, 9, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.458811', NULL, NULL);
INSERT INTO public.clothing VALUES (435, 'XL', 'Calvin Klein', 'Vest Jacket', 'Black, Grey', 34, '067649', 19.85, 26.74, 13, 9, 'Grey hood', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.467235', NULL, NULL);
INSERT INTO public.clothing VALUES (1131, 'S', 'Calvin Klein', 'T-Shirt', 'White', 92, '893226', 10.00, NULL, NULL, NULL, 'golden sign on chest', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.012999', NULL, NULL);
INSERT INTO public.clothing VALUES (621, 'M', 'Calvin Klein', 'Sweater', 'Red', 34, '784905', 16.62, NULL, NULL, NULL, 'pkg 19
Long neck
Black patch on shoulder

Chest: 64
Waist: 58
Length: 64
Arm: 67', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:59.079548', NULL, NULL);
INSERT INTO public.clothing VALUES (626, 'M', 'Calvin Klein', 'Sweat Pants', 'Black', NULL, '??????', 24.33, 54.19, NULL, 3, 'sold with 2108 
grey logo sign', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:59.132975', NULL, NULL);
INSERT INTO public.clothing VALUES (627, 'XS', 'Tommy Hilfiger', 'Hoodie', 'Navy', 8, '792819', 19.99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:59.140623', NULL, NULL);
INSERT INTO public.clothing VALUES (629, 'N/A', 'Michael Kors', 'Purse', 'Black', NULL, '??????', 29.99, 59.44, NULL, 4, 'sold for 1700', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:59.157148', NULL, NULL);
INSERT INTO public.clothing VALUES (1931, 'M', 'Levis', 'Puffy Jacket', 'Blue, White, Black', NULL, '030267', 59.99, NULL, NULL, NULL, 'Men
Black hood
White chest
Blue bottom

Chest: 59
Length:  69
Arm: 70
Shoulders: 49', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-01-03 04:12:09.147115', NULL, 0.00);
INSERT INTO public.clothing VALUES (676, 'S', 'Tommy Hilfiger', 'Puffy Jacket', 'Navy', 44, '912515', 34.99, NULL, NULL, NULL, 'Shiny
with hood
reversible to fluffy and white

Chest: 55
Length: 62
Arm: 58', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:59.57098', NULL, NULL);
INSERT INTO public.clothing VALUES (436, 'L', 'Calvin Klein', 'Puffy Jacket', 'Pink', 34, '093242', 33.24, 44.78, 13, 9, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.476356', NULL, NULL);
INSERT INTO public.clothing VALUES (1128, 'S', 'Calvin Klein', 'T-Shirt', 'White', 92, '893226', 10.00, NULL, NULL, NULL, 'golden sign on chest', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.985831', NULL, NULL);
INSERT INTO public.clothing VALUES (437, 'M', 'Calvin Klein', 'Puffy Jacket', 'Pearl', 34, '093259', 33.24, 44.78, 13, 9, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.484527', NULL, NULL);
INSERT INTO public.clothing VALUES (1156, 'M', 'Calvin Klein', 'T-Shirt', 'White', 99, '599318', 6.71, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.253707', NULL, NULL);
INSERT INTO public.clothing VALUES (694, '1SZ', 'Tommy Hilfiger', 'Hat', 'White', 46, '561914', 13.99, NULL, NULL, NULL, 'HILFIGER sign on forehead

beanie cap', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:59.739844', NULL, NULL);
INSERT INTO public.clothing VALUES (695, '1SZ', 'Tommy Hilfiger', 'Hat', 'White', 45, '561914', 13.99, NULL, NULL, NULL, 'HILFIGER sign on forehead

beanie cap', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:59.748656', NULL, NULL);
INSERT INTO public.clothing VALUES (696, '1SZ', 'Tommy Hilfiger', 'Bag', 'Navy', 46, '812020', 11.19, NULL, NULL, NULL, 'computer bag', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:59.756496', NULL, NULL);
INSERT INTO public.clothing VALUES (698, '1SZ', 'Tommy Hilfiger', 'Hat', 'Navy', 48, '512548', 12.98, NULL, NULL, NULL, 'baseball cap', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:59.774744', NULL, NULL);
INSERT INTO public.clothing VALUES (699, '1SZ', 'Tommy Hilfiger', 'Hat', 'White', 48, '512524', 12.98, NULL, NULL, NULL, 'baseball cap', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:59.783691', NULL, NULL);
INSERT INTO public.clothing VALUES (697, '1SZ', 'Tommy Hilfiger', 'Bag', 'Navy', 46, '812020', 11.19, NULL, NULL, NULL, 'computer bag', NULL, 'women', NULL, NULL, NULL, 'Ukraine', '2020-12-21 01:07:59.766718', NULL, 0.00);
INSERT INTO public.clothing VALUES (705, 'M', 'Tommy Hilfiger', 'Puffy Jacket', 'Navy', 47, '912508', 34.99, NULL, NULL, NULL, 'Shiny
with hood
reversible to fluffy and white

Chest: 57
Length: 62
Arm: 58', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:59.835157', NULL, NULL);
INSERT INTO public.clothing VALUES (706, 'M', 'Tommy Hilfiger', 'Puffy Jacket', 'Black', NULL, '098934', 59.00, NULL, NULL, NULL, 'long
maroon inside

Chest: 50
Waist: 46
length: 87
Arm: 65', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:59.842829', NULL, NULL);
INSERT INTO public.clothing VALUES (707, 'M', 'Tommy Hilfiger', 'Puffy Jacket', 'White, Navy, Red', NULL, '994115', 59.99, NULL, NULL, NULL, 'hooded
Navy top
white center
red bottom

Chest: 51
length: 56
arm: 67', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:59.851069', NULL, NULL);
INSERT INTO public.clothing VALUES (708, '7/8S', 'DKNY', 'Puffy Jacket', 'Pink', NULL, '447806', 34.99, NULL, NULL, NULL, 'kid clothes
age 7/8

Chest: 43
length: 52
arm: 50', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:59.857833', NULL, NULL);
INSERT INTO public.clothing VALUES (505, 'XS', 'Calvin Klein', 'Sweat Pants', 'Black', 15, '082933', 30.35, 50.00, NULL, 19, 'White outlined black stripe with "cavin klein ck" down leg

Waist: 36
Hips: 47
Length: 90
Pasadka: 23', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.081432', NULL, 0.00);
INSERT INTO public.clothing VALUES (590, '1SZ', 'Calvin Klein', 'Hat', 'Green', NULL, '555780', 10.49, 26.79, NULL, 19, NULL, true, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.815883', NULL, 0.00);
INSERT INTO public.clothing VALUES (1142, 'L', 'Calvin Klein', 'T-Shirt', 'Navy', 96, '892206', 5.01, NULL, NULL, NULL, 'white big letters on chest', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.12179', NULL, NULL);
INSERT INTO public.clothing VALUES (582, 'S', 'Calvin Klein', 'Puffy Jacket', 'Pearl', 36, '093266', 29.74, NULL, 20, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.749741', NULL, NULL);
INSERT INTO public.clothing VALUES (1151, 'S', 'Calvin Klein', 'Hoodie', 'Black', 98, '599608', 33.12, NULL, NULL, NULL, 'big yellow sign', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:11.20784', NULL, NULL);
INSERT INTO public.clothing VALUES (438, 'L', 'Levis', 'Puffy Jacket', 'Black', 35, '640305', 32.49, 43.91, 13, 9, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.493918', NULL, NULL);
INSERT INTO public.clothing VALUES (447, '1SZ', 'Levis', 'Scarf', 'Black', NULL, '195899', 12.99, 17.54, 13, 9, 'Hat + scarf', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.581486', NULL, NULL);
INSERT INTO public.clothing VALUES (448, 'S', 'Calvin Klein', 'Blouse', 'Black', 34, '579464', 9.24, 12.45, 13, 9, 'chest: 49
length: 65/72
arm: 64', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.589353', NULL, NULL);
INSERT INTO public.clothing VALUES (1228, '24', 'Levis', 'Jeans', 'Unknown', 107, '602243', 34.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.915036', NULL, NULL);
INSERT INTO public.clothing VALUES (1127, 'S', 'Calvin Klein', 'T-Shirt', 'White', 92, '893226', 10.00, 30.36, NULL, 23, 'golden sign on chest', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.976505', NULL, NULL);
INSERT INTO public.clothing VALUES (451, 'S', 'Calvin Klein', 'Satin Pants', 'Black', 34, '549479', 10.57, 14.24, 13, 9, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.614714', NULL, NULL);
INSERT INTO public.clothing VALUES (541, 'L', 'DKNY', 'Puffy Jacket', 'Black', NULL, '244714', 59.99, 80.99, 13, 9, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.393115', NULL, NULL);
INSERT INTO public.clothing VALUES (542, 'N/A', 'Tommy Hilfiger', 'Bag', 'Navy', NULL, '812013', 22.49, 30.36, 13, 9, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.401837', NULL, NULL);
INSERT INTO public.clothing VALUES (714, 'XS', 'Tommy Hilfiger', 'Sweater', 'Deep Seawave', 46, '654043', 17.49, NULL, NULL, NULL, 'knitted
V-neck

Chest: 43
length: 59
arm: 62', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:59.906023', NULL, NULL);
INSERT INTO public.clothing VALUES (717, '14/16L', 'DKNY', 'Puffy Jacket', 'Pink', NULL, '447820', 34.99, NULL, NULL, NULL, '14-16 years

chest: 49
length: 62
arm: 59', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:59.931093', NULL, NULL);
INSERT INTO public.clothing VALUES (721, 'S', 'Calvin Klein', 'Sweater', 'White', NULL, '873012', 34.99, NULL, NULL, NULL, 'long neck
black line down arms

chest: 53
length: 55
arm: 49/65', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:59.963737', NULL, NULL);
INSERT INTO public.clothing VALUES (2001, 'XS', 'Calvin Klein', 'Hoodie', 'Black', 154, '657834', 14.05, NULL, NULL, NULL, 'pocket on belly
calvin on sleeve

chest: 52
length: 59
arm: 56/76', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-01-08 11:54:04.688515', NULL, 0.00);
INSERT INTO public.clothing VALUES (1129, 'S', 'Calvin Klein', 'T-Shirt', 'White', 92, '866343', 6.32, NULL, NULL, NULL, 'blue city picture on chest', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:10.994965', NULL, NULL);
INSERT INTO public.clothing VALUES (543, 'XS', 'Tommy Hilfiger', 'Puffy Jacket', 'White', NULL, '484862', 37.51, 50.64, 13, 9, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.409838', NULL, NULL);
INSERT INTO public.clothing VALUES (63, 'M', 'Calvin Klein', 'Sweater', 'Yellow', 3, '063733', 34.99, 57.14, 2, 22, 'Knitted
Stripe on arms

Chest: 58
Length: 61
Arm: 68', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.191253', NULL, NULL);
INSERT INTO public.clothing VALUES (3148, 'S', 'Ralph Lauren', 'Polo Shirt', 'Navy', 269, '349449', 14.99, NULL, 109, NULL, 'wish mishka teddy bear', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-20 23:16:01.560077', NULL, NULL);
INSERT INTO public.clothing VALUES (1633, '33', 'Calvin Klein', 'Shorts', 'Blue', 125, '995860', 8.49, NULL, 114, NULL, 'blue-ish
waist: 43
hips: 52
pasadka: 29
length: 47', NULL, 'men', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:15.685706', NULL, 0.00);
INSERT INTO public.clothing VALUES (644, 'M', 'Tommy Hilfiger', 'Puffy Jacket', 'Navy', 40, '912508', 34.99, 47.29, 31, 9, 'shiny
reversible to white', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.284582', NULL, NULL);
INSERT INTO public.clothing VALUES (645, 'M', 'Tommy Hilfiger', 'Puffy Jacket', 'Navy', 40, '912508', 34.99, 47.29, 31, 9, 'shiny
reversible to white', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.293288', NULL, NULL);
INSERT INTO public.clothing VALUES (646, 'S', 'Tommy Hilfiger', 'Puffy Jacket', 'Navy', 40, '912515', 34.99, 47.29, 31, 9, 'shiny
reversible to white', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.302572', NULL, NULL);
INSERT INTO public.clothing VALUES (729, '2', 'Tommy Hilfiger', 'Jeans', 'Blue', NULL, '440561', 0.00, NULL, NULL, NULL, 'TJ flex stretch skinny
Tommy jeans on back pocket', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:08:00.026934', NULL, NULL);
INSERT INTO public.clothing VALUES (732, 'XS', 'Tommy Hilfiger', 'Sweat Shirt', 'White', 47, '430319', 17.49, NULL, NULL, NULL, 'circled logo
on the video on the double sided puffy jacket', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:08:00.060215', NULL, NULL);
INSERT INTO public.clothing VALUES (744, 'M', 'Tommy Hilfiger', 'Puffy Jacket', 'Black', 50, '598316', 55.99, NULL, NULL, NULL, 'Matt black fabric
Misha''s jacket

Chest: 60
length: 73
arm: 68
shoulders: 45', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:08:00.162101', NULL, NULL);
INSERT INTO public.clothing VALUES (750, 'L', 'Tommy Hilfiger', 'Sweater', 'Navy', 50, '395458', 20.99, NULL, NULL, NULL, 'Chest: 55
length: 68
arm: 67', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:08:00.212874', NULL, NULL);
INSERT INTO public.clothing VALUES (752, 'M', 'Tommy Hilfiger', 'Golfik', 'White', 50, '395304', 20.99, NULL, NULL, NULL, 'Chest: 52
length: 70
arm: 78', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:08:00.229305', NULL, NULL);
INSERT INTO public.clothing VALUES (754, 'XS', 'Tommy Hilfiger', 'Coat', 'Plaid', 50, '916810', 56.03, NULL, NULL, NULL, 'Chest: 45
length: 96
arm: 63', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:08:00.246041', NULL, NULL);
INSERT INTO public.clothing VALUES (1932, 'XS', 'Wilsons Leather', 'Leather Jacket', 'Purple', NULL, '950555', 59.99, NULL, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'Ukraine', '2021-01-03 04:15:57.07087', NULL, 0.00);
INSERT INTO public.clothing VALUES (758, '1SZ', 'Tommy Hilfiger', 'Scarf', 'Plaid', 50, '561730', 15.74, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:08:00.280103', NULL, NULL);
INSERT INTO public.clothing VALUES (759, '1SZ', 'Tommy Hilfiger', 'Scarf', 'Plaid', 50, '561730', 15.74, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:08:00.288778', NULL, NULL);
INSERT INTO public.clothing VALUES (760, '1SZ', 'Calvin Klein', 'Scarf', 'Olive', 51, '562764', 2.32, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:08:00.296832', NULL, NULL);
INSERT INTO public.clothing VALUES (761, '1SZ', 'Calvin Klein', 'Scarf', 'Black', 51, '562757', 2.32, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:08:00.305768', NULL, NULL);
INSERT INTO public.clothing VALUES (762, '1SZ', 'Calvin Klein', 'Scarf', 'Black', 51, '562757', 2.32, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:08:00.313812', NULL, NULL);
INSERT INTO public.clothing VALUES (764, '1SZ', 'Calvin Klein', 'Hat', 'Black', 51, '562788', 2.32, NULL, NULL, NULL, 'beanie cap', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:08:00.330971', NULL, NULL);
INSERT INTO public.clothing VALUES (765, '1SZ', 'Calvin Klein', 'Hat', 'Black', 51, '555766', 2.32, NULL, NULL, NULL, 'beanie cap
large white logo on forehead', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:08:00.339732', NULL, NULL);
INSERT INTO public.clothing VALUES (766, '1SZ', 'Calvin Klein', 'Hat', 'Olive', 51, '562795', 2.32, NULL, NULL, NULL, 'beanie cap', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:08:00.348054', NULL, NULL);
INSERT INTO public.clothing VALUES (769, 'M', 'Calvin Klein', 'Puffy Jacket', 'Black', 51, '934645', 7.70, NULL, NULL, NULL, 'chest: 58
length: 70
arm: 66', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:08:00.37322', NULL, NULL);
INSERT INTO public.clothing VALUES (1170, '???', 'Calvin Klein', 'unknown', 'Unknown', 100, '599608', 28.38, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.380141', NULL, NULL);
INSERT INTO public.clothing VALUES (771, '7/8S', 'Calvin Klein', 'Hoodie', 'Pink', NULL, '488601', 13.00, NULL, NULL, NULL, 'kids clothes
7-8 years
costco
super furry/fluffy

chest: 36
length: 46
arm: 55', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:08:00.389308', NULL, NULL);
INSERT INTO public.clothing VALUES (772, '10/12M', 'Calvin Klein', 'Hoodie', 'Black', NULL, '488519', 13.00, NULL, NULL, NULL, 'kids clothes
10-12 years
costco
super furry/fluffy

chest: 40
length: 49
arm: 58', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:08:00.396812', NULL, NULL);
INSERT INTO public.clothing VALUES (773, '5/6XS', 'Calvin Klein', 'Hoodie', 'Black', NULL, '488533', 13.00, NULL, NULL, NULL, 'kids clothes
5-6 years
costco
super furry/fluffy

chest: 34
length: 44
arm: 52', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:08:00.404878', NULL, NULL);
INSERT INTO public.clothing VALUES (780, 'L', 'Calvin Klein', 'Sweat Pants', 'Black', 53, '785391', 13.13, NULL, NULL, NULL, 'tape on calf
"calvin" on the tape

Waist: 47
Hips: 52
Length: 94
Pasadka: 27', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:08:00.475443', NULL, NULL);
INSERT INTO public.clothing VALUES (3706, 'N/A', 'DKNY', 'Backpack', 'Tan', NULL, '850121', 49.99, NULL, 127, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-09 03:13:00.18661', NULL, NULL);
INSERT INTO public.clothing VALUES (3307, 'One Size', 'DKNY', 'Purse', 'Black', 279, '857325', 29.99, NULL, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-25 02:57:03.364707', NULL, 0.00);
INSERT INTO public.clothing VALUES (3468, 'XS', 'Tommy Hilfiger', 'Blazer', 'Navy', NULL, '756629', 20.00, NULL, 121, NULL, 'Linen', NULL, 'women', NULL, NULL, 'Linen', 'usa', '2021-04-01 02:31:48.749074', NULL, 0.00);
INSERT INTO public.clothing VALUES (1991, 'M', 'Tommy Hilfiger', 'Sweater', 'Navy', 153, '101863', 12.00, 16.31, 56, 9, 'with diamonds', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 11:45:48.894824', NULL, 0.00);
INSERT INTO public.clothing VALUES (2746, 'XS', 'Tommy Hilfiger', 'Sweat Pants', 'Grey', 225, '006608', 28.79, 0.00, 92, 9, 'waist: 36
hips: 50
pasadka: 24
length: 96', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-01 01:20:14.751322', NULL, 0.00);
INSERT INTO public.clothing VALUES (2274, 'XL', 'DKNY', 'Puffy Jacket', 'Green', 180, '223047', 69.99, 0.00, 68, 9, NULL, NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-01-23 20:50:05.85172', NULL, 0.00);
INSERT INTO public.clothing VALUES (781, 'S', 'Calvin Klein', 'Satin Pants', 'Black', 53, '785391', 10.45, NULL, NULL, NULL, 'waist: 38
hips: 52
Length: 97', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:08:00.48382', NULL, NULL);
INSERT INTO public.clothing VALUES (647, 'L', 'Tommy Hilfiger', 'Puffy Jacket', 'White, Red, Navy', 40, '621716', 34.99, 47.29, 31, 9, 'navy top
white center
red bottom', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.311238', NULL, NULL);
INSERT INTO public.clothing VALUES (755, 'S', 'Tommy Hilfiger', 'Coat', 'Plaid', 50, '916803', 55.99, NULL, NULL, NULL, 'chest: 48
Waist: 45
length: 96
arm: 65', false, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:08:00.25468', NULL, NULL);
INSERT INTO public.clothing VALUES (1173, '???', 'Calvin Klein', 'unknown', 'Unknown', 101, '860531', 5.44, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.418153', NULL, NULL);
INSERT INTO public.clothing VALUES (648, 'M', 'Tommy Hilfiger', 'Puffy Jacket', 'Gold', 40, '899908', 55.99, 75.67, 31, 9, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.320185', NULL, NULL);
INSERT INTO public.clothing VALUES (768, 'M', 'Calvin Klein', 'Puffy Jacket', 'Black', 52, '934478', 27.99, NULL, NULL, NULL, 'matte black

chest: 58
length: 90
arm: 68', NULL, 'men', NULL, NULL, NULL, 'usa', '2020-12-21 01:08:00.364471', NULL, 0.00);
INSERT INTO public.clothing VALUES (783, 'S', 'Calvin Klein', 'Sweater', 'Pink', 53, '954414', 8.76, NULL, NULL, NULL, 'With hood

Chest: 51
Waist: 48
Length: 51
Arm: 51', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.501885', NULL, NULL);
INSERT INTO public.clothing VALUES (786, 'XS', 'Calvin Klein', 'Sweater', 'Red', 53, '986248', 8.76, NULL, NULL, NULL, 'White line + black "calvin kelin jeans" down arms

Chest: 40
Waist: 39
Length: 52
Arm: 72', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.526766', NULL, NULL);
INSERT INTO public.clothing VALUES (774, 'N/A', 'Michael Kors', 'Bag', 'Red', NULL, '074299', 199.00, NULL, NULL, NULL, '3 items', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:08:00.41176', NULL, NULL);
INSERT INTO public.clothing VALUES (1175, '???', 'Calvin Klein', 'unknown', 'Unknown', 101, '860531', 5.43, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.436', NULL, NULL);
INSERT INTO public.clothing VALUES (789, 'M', 'Calvin Klein', 'Hoodie', 'White', 53, '013395', 24.22, NULL, NULL, NULL, 'very fluffy
black tape on wrists
white "calvin" on tape', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:08:00.55235', NULL, NULL);
INSERT INTO public.clothing VALUES (792, 'M', 'Calvin Klein', 'Sweat Pants', 'Black', 54, '263169', 19.99, NULL, NULL, NULL, 'men
grey logo sign

Waist: 41
hips: 53
length: 106
pasadka: 30', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:08:00.587385', NULL, NULL);
INSERT INTO public.clothing VALUES (797, 'S', 'Calvin Klein', 'Jacket', 'Black', 54, '015306', 17.61, NULL, NULL, NULL, 'double sided
(black on other side)', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:08:00.629718', NULL, NULL);
INSERT INTO public.clothing VALUES (802, 'L', 'Tommy Hilfiger', 'Sweater', 'Navy', 55, '395458', 17.49, NULL, NULL, NULL, 'Chest: 55
length: 68
arm: 67', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:08:00.671496', NULL, NULL);
INSERT INTO public.clothing VALUES (803, 'XS', 'Tommy Hilfiger', 'Windbreaker', 'White', 55, '912171', 42.00, NULL, NULL, NULL, '2 jackets in 1.
hooded

chest: 50
Waist: 44
length: 73
arm: 73', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:08:00.679135', NULL, NULL);
INSERT INTO public.clothing VALUES (2361, 'S', 'Calvin Klein', 'Yoga Pants', 'Black', NULL, '444151', 19.99, 39.29, 83, 22, 'white calvin performance everywhere

waist: 32
hips: 39
pasadka: 25
length: 84', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-31 15:23:03.826964', NULL, 0.00);
INSERT INTO public.clothing VALUES (3149, 'XS', 'Ralph Lauren', 'Polo Shirt', 'Navy', 269, '349463', 14.99, NULL, 109, NULL, 'wish mishka teddy bear', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-20 23:16:16.7945', NULL, NULL);
INSERT INTO public.clothing VALUES (3393, '9', 'Calvin Klein', 'Shoes', 'Black', 284, '164670', 34.99, NULL, NULL, NULL, 'кроссовки неопрен надпись на резинке
размер 9 стелька 25.5  см', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-29 04:04:02.044989', NULL, NULL);
INSERT INTO public.clothing VALUES (3469, 'M', 'Calvin Klein', 'Sweat Shirt', 'Black', NULL, '237296', 24.99, NULL, 121, NULL, 'no fleece
white stacked CK

chest: 54
length: 61
arm: 54/72', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-01 02:35:23.407255', NULL, 0.00);
INSERT INTO public.clothing VALUES (85, 'S', 'Calvin Klein', 'Sweater', 'Red', 9, '986231', 19.66, 48.95, NULL, 14, 'in package 1.2
sold for 1400
stripe down arm', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.378821', NULL, NULL);
INSERT INTO public.clothing VALUES (3552, 'L', 'Calvin Klein', 'Hoodie', 'Black', 289, '872115', 29.99, NULL, NULL, NULL, 'Zipped small sign CK on chest
chest 57
L 67
SL 66', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-04-03 02:51:49.505141', NULL, NULL);
INSERT INTO public.clothing VALUES (3308, 'M', 'Calvin Klein', 'Windbreaker', 'Silver', 279, '899401', 12.00, NULL, 122, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-25 02:59:39.208242', NULL, NULL);
INSERT INTO public.clothing VALUES (3707, '2', 'Armani Exchange', 'Blazer', 'Pink', NULL, '4365407', 39.99, NULL, 127, NULL, NULL, NULL, 'women', NULL, NULL, NULL, NULL, '2021-04-09 03:14:55.828158', NULL, NULL);
INSERT INTO public.clothing VALUES (659, 'M', 'Armani Exchange', 'T-Shirt', 'White', 43, '001818', 9.99, 13.64, 31, 9, 'Black letters', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.419522', NULL, NULL);
INSERT INTO public.clothing VALUES (49, 'S', 'Calvin Klein', 'Sweat Pants', 'Mint', 7, '827336', 29.75, 53.57, 1, 22, 'Black "Calvin" on calf
Has pockets

Waist: 40
Hips: 47
Length: 93
Pasadka: 25', true, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.06295', NULL, 0.00);
INSERT INTO public.clothing VALUES (3394, '7.5', 'Calvin Klein', 'Shoes', 'Black', 284, '164649', 34.99, NULL, NULL, NULL, 'кроссовки неопрен надпись на резинке
размер 7.5 стелька 24.5  см', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-29 04:05:31.682799', NULL, NULL);
INSERT INTO public.clothing VALUES (1572, 'XS', 'Calvin Klein', 'Shorts', 'Pink', 142, '350216', 9.69, NULL, 121, NULL, 'waist: 36
hips: 49
length: 48
pasadka: 24', NULL, 'women', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:15.118041', NULL, 0.00);
INSERT INTO public.clothing VALUES (3553, 'M', 'Calvin Klein', 'Hoodie', 'Black', 289, '872108', 29.99, NULL, NULL, NULL, 'Zipped small sign CK on chest
chest 53
L 66
SL 66', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-04-03 02:52:52.442804', NULL, NULL);
INSERT INTO public.clothing VALUES (3309, 'M', 'Calvin Klein', 'Rain Coat', 'Pearl', 279, '360895', 32.00, NULL, 122, NULL, 'ПОГ 54
длина 77
Рукав 72', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-25 03:00:12.43786', NULL, 0.00);
INSERT INTO public.clothing VALUES (3708, 'XS', 'Tommy Hilfiger', 'Shorts', 'Navy', NULL, '503598', 5.00, NULL, 127, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-09 03:46:00.109187', NULL, NULL);
INSERT INTO public.clothing VALUES (807, 'XS', 'Calvin Klein', 'Hoodie', 'Mint', NULL, '827626', 29.99, NULL, NULL, NULL, 'Black "Calvin" across chest
Belly pocket

Chest: 53
Waist: 51
Length: 51
Arm: 67', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:08:00.711966', NULL, NULL);
INSERT INTO public.clothing VALUES (1179, '???', 'Calvin Klein', 'unknown', 'Unknown', 101, '662847', 7.83, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.471972', NULL, NULL);
INSERT INTO public.clothing VALUES (1180, 'XS', 'Calvin Klein', 'Puffy Jacket', 'Purple', 102, '873142', 28.72, 0.00, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.480418', NULL, NULL);
INSERT INTO public.clothing VALUES (3151, 'S', 'Calvin Klein', 'Dress', 'White', 269, '314850', 24.99, NULL, NULL, NULL, 'tunika
chest: 51
length: 91', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-20 23:17:36.901432', NULL, NULL);
INSERT INTO public.clothing VALUES (3239, '8', 'Converce', 'Shoes', 'White', NULL, '??????', 14.00, 33.93, NULL, 22, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-21 02:41:00.071186', NULL, NULL);
INSERT INTO public.clothing VALUES (3395, '8.5', 'Calvin Klein', 'Shoes', 'Black', 284, '164663', 34.99, NULL, NULL, NULL, 'кроссовки неопрен надпись на резинке
размер 8 стелька 25  см', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-29 04:06:37.200181', NULL, NULL);
INSERT INTO public.clothing VALUES (461, 'XS', 'Calvin Klein', 'T-Shirt', 'White', 37, '974139', 2.77, NULL, 121, NULL, 'black logo letter with city inside

chest: 43
length: 62', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:57.699537', NULL, NULL);
INSERT INTO public.clothing VALUES (3310, 'M', 'Calvin Klein', 'Sweat Shirt', 'Navy', 279, '384321', 15.00, NULL, 119, NULL, NULL, NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-25 03:01:08.233384', NULL, NULL);
INSERT INTO public.clothing VALUES (3554, 'S', 'Calvin Klein', 'Hoodie', 'Black', 289, '254839', 29.99, NULL, NULL, NULL, 'grey  sign CK on chest
chest 53
L 69
SL 66', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-04-03 02:54:06.485614', NULL, NULL);
INSERT INTO public.clothing VALUES (1504, 'XXS', 'Tommy Hilfiger', 'T-Shirt', 'Black', 138, '947869', 7.49, NULL, 127, NULL, 'knitted/yarn', NULL, 'women', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:14.486826', NULL, 0.00);
INSERT INTO public.clothing VALUES (649, 'M', 'Tommy Hilfiger', 'Puffy Jacket', 'Gold', 40, '899908', 55.99, 75.67, 31, 9, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.328795', NULL, NULL);
INSERT INTO public.clothing VALUES (1181, '???', 'Calvin Klein', 'Puffy Jacket', 'Purple', 102, '873128', 28.72, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.48968', NULL, NULL);
INSERT INTO public.clothing VALUES (1182, '???', 'Calvin Klein', 'Puffy Jacket', 'Purple', 102, '873135', 28.72, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.498081', NULL, NULL);
INSERT INTO public.clothing VALUES (650, 'XL', 'Tommy Hilfiger', 'Coat', 'Grey', 41, '641494', 56.00, 75.68, 31, 9, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.33804', NULL, NULL);
INSERT INTO public.clothing VALUES (3152, '2', 'Calvin Klein', 'Jumpsuit', 'Blue', 269, '991631', 24.99, NULL, NULL, NULL, 'chest: 39
waist: 33
length: 150', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-20 23:18:55.368989', NULL, NULL);
INSERT INTO public.clothing VALUES (545, 'N/A', 'Armani Exchange', 'Purse', 'Black', NULL, '767493', 29.99, 75.00, 19, 22, NULL, true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.426262', NULL, NULL);
INSERT INTO public.clothing VALUES (3311, 'M', 'Michael Kors', 'Polo Shirt', 'Blue', 279, '411948', 19.99, NULL, 120, NULL, 'голубая с бел полоск по плечу', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-25 03:02:35.439121', NULL, NULL);
INSERT INTO public.clothing VALUES (3470, '7.5', 'Michael Kors', 'Shoes', 'Tan', NULL, '429929', 49.99, NULL, 121, NULL, 'high heels', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-01 02:58:39.856998', NULL, NULL);
INSERT INTO public.clothing VALUES (3555, 'L', 'Michael Kors', 'Hoodie', 'Navy', 289, '453504', 29.99, NULL, NULL, NULL, 'grey  stripes on chest
chest 56
L 68
SL 69', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-04-03 02:55:38.749022', NULL, NULL);
INSERT INTO public.clothing VALUES (3638, 'M', 'Armani Exchange', 'Leather Jacket', 'Black', 294, '4136380', 39.99, NULL, NULL, NULL, 'ПОГ 47
дл 52
рук 51', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-06 21:08:15.775486', NULL, 0.00);
INSERT INTO public.clothing VALUES (3396, '8', 'Calvin Klein', 'Flip Flops', 'Black', 284, '670755901499', 14.99, NULL, NULL, NULL, 'шлёпки пена полоски накрест размер 8 стелька 24.5 cm', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-29 04:08:54.408512', NULL, 0.00);
INSERT INTO public.clothing VALUES (3709, '2', 'Tommy Hilfiger', 'Shorts', 'Blue', NULL, '694190', 15.00, NULL, 127, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-09 03:47:20.974637', NULL, NULL);
INSERT INTO public.clothing VALUES (701, 'S', 'Tommy Hilfiger', 'Sweater', 'White', 46, '653770', 17.49, 44.64, NULL, 19, 'knitted
V-neck

Chest: 43
length: 59
arm: 61', true, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.800888', NULL, 0.00);
INSERT INTO public.clothing VALUES (793, 'XS', 'Calvin Klein', 'Jacket', 'Black', 54, '068998', 17.61, 66.07, NULL, 19, 'double sided', NULL, 'women', NULL, NULL, NULL, 'usa', '2020-12-21 01:08:00.595315', NULL, 5.00);
INSERT INTO public.clothing VALUES (679, 'L', 'Tommy Hilfiger', 'Puffy Jacket', 'Navy', 44, '912492', 34.99, NULL, 33, NULL, 'Shiny
with hood
reversible to fluffy and white

Chest: 57
Length: 62
Arm: 55', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.597185', NULL, NULL);
INSERT INTO public.clothing VALUES (3240, '7.5', 'Guess', 'Shoes', 'Red', NULL, '??????', 29.99, 50.00, NULL, 22, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-21 03:01:51.893118', NULL, NULL);
INSERT INTO public.clothing VALUES (3153, 'M', 'Tommy Hilfiger', 'Hoodie', 'Navy, White', 269, '836149', 24.99, NULL, 115, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-20 23:19:08.769089', NULL, 0.00);
INSERT INTO public.clothing VALUES (3312, 'L', 'Michael Kors', 'Polo Shirt', 'Blue', 279, '784606', 19.99, NULL, 120, NULL, 'светло голубая с бел полоск по плечу', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-25 03:03:28.316355', NULL, NULL);
INSERT INTO public.clothing VALUES (1576, 'M', 'Calvin Klein', 'Hoodie', 'Pink', 142, '351466', 9.69, NULL, 121, NULL, 'sleeveless
chest: 58
length: 52', NULL, 'women', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:15.153555', NULL, 0.00);
INSERT INTO public.clothing VALUES (3556, 'L', 'Michael Kors', 'Polo Shirt', 'Blue', 289, '784606', 19.99, NULL, NULL, NULL, 'stripe on shoulder
chest 55
L 68
', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-04-03 02:56:59.56714', NULL, NULL);
INSERT INTO public.clothing VALUES (3397, '7', 'Calvin Klein', 'Flip Flops', 'Black', 284, '670755901499', 14.99, NULL, 125, NULL, 'шлёпки пена полоски накрест размер 7 стелька 24 cm', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-29 04:09:48.630578', NULL, NULL);
INSERT INTO public.clothing VALUES (3710, 'S', 'Tommy Hilfiger', 'T-Shirt', 'White', NULL, '694190', 10.00, NULL, 127, NULL, 'cursive silver sign', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-09 03:47:53.499517', NULL, NULL);
INSERT INTO public.clothing VALUES (651, 'M', 'Tommy Hilfiger', 'Coat', 'Brown', 41, '639507', 55.99, 75.67, 31, 9, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.346963', NULL, NULL);
INSERT INTO public.clothing VALUES (964, 'M', 'Tommy Hilfiger', 'Windbreaker', 'White', 61, '684276', 20.99, 66.43, NULL, 22, 'Blue/red stripes on chest

chest: 53
length: 67
arm: 63', NULL, 'women', NULL, NULL, NULL, 'Ukraine', '2020-12-21 01:19:09.445226', NULL, 0.00);
INSERT INTO public.clothing VALUES (1933, 'M', 'Karl Lagerfeld', 'Sport Jacket', 'Red', NULL, '343794', 59.99, NULL, 128, NULL, 'red stripe on sleeve', NULL, 'women', NULL, NULL, NULL, 'Ukraine', '2021-01-03 04:17:28.175227', NULL, 0.00);
INSERT INTO public.clothing VALUES (3635, 'S', 'Armani Exchange', 'Leather Jacket', 'Black', NULL, '4136397', 39.99, 53.99, 125, 9, 'ПОГ 44
по низу 41
длина 49
рук 50
плечи 39', NULL, 'women', NULL, NULL, NULL, NULL, '2021-04-06 21:05:08.017611', NULL, NULL);
INSERT INTO public.clothing VALUES (3636, 'S', 'Armani Exchange', 'Leather Jacket', 'Black', 294, '4136397', 39.99, 82.14, NULL, 23, 'ПОГ 44
по низу 41
длина 49
рук 50
плечи 39', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-06 21:05:09.029149', NULL, 0.00);
INSERT INTO public.clothing VALUES (3398, '8', 'Michael Kors', 'Flip Flops', 'White', 284, '871822', 24.99, NULL, 117, NULL, 'шлёпки пена метал знак размер 8 стелька 24.5 cm', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-29 04:11:21.800713', NULL, NULL);
INSERT INTO public.clothing VALUES (3313, 'XL', 'Michael Kors', 'Polo Shirt', 'Blue', 279, '784613', 19.99, NULL, 120, NULL, 'светло голубая с бел полоск по плечу', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-25 03:03:59.317417', NULL, NULL);
INSERT INTO public.clothing VALUES (1573, 'M', 'Calvin Klein', 'Shorts', 'Pink', 142, '350193', 9.69, NULL, 121, NULL, 'waist: 40
hips: 52
pasadka: 28
length: 51', NULL, 'women', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:15.12659', NULL, 0.00);
INSERT INTO public.clothing VALUES (3557, 'M', 'Calvin Klein', 'Sweat Shirt', 'Pink', 289, '133536', 19.99, NULL, NULL, NULL, 'с карманами и мал знаком белым возле кармана
ПОТ 41
ПОБ 52
дл 93
пос 28', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-03 02:59:05.046375', NULL, NULL);
INSERT INTO public.clothing VALUES (3154, 'M', 'Karl Lagerfeld', 'Sweat Pants', 'Black', 269, 'Lorf6246', 22.99, NULL, 122, NULL, 'white stripe on side', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-20 23:20:06.75173', NULL, 0.00);
INSERT INTO public.clothing VALUES (1388, '0', 'Calvin Klein', 'Shorts', 'Yellow', 125, '928547', 12.74, NULL, 127, NULL, 'Built in belt

Waist: 33
Hips: 47
Length: 40
Pasadka: 26', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:13.405792', NULL, NULL);
INSERT INTO public.clothing VALUES (655, 'M', 'Tommy Hilfiger', 'Sweat Shirt', 'Grey', 42, '269254', 13.99, 19.10, 31, 9, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.383555', NULL, NULL);
INSERT INTO public.clothing VALUES (656, 'M', 'Tommy Hilfiger', 'Sweater', 'Deep Seawave', 42, '654067', 17.49, 23.89, 31, 9, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.391798', NULL, NULL);
INSERT INTO public.clothing VALUES (658, 'S', 'Armani Exchange', 'Hoodie', 'White', 43, '001375', 9.99, 13.64, 31, 9, 'with zipper', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.409974', NULL, NULL);
INSERT INTO public.clothing VALUES (660, 'S', 'Armani Exchange', 'T-Shirt', 'White', 43, '839221', 9.99, 13.64, 31, 9, 'Red letters', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.428102', NULL, NULL);
INSERT INTO public.clothing VALUES (3241, 'S', 'Calvin Klein', 'Sweat Shirt', 'Pink', NULL, '??????', 29.99, 48.21, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-21 03:12:20.535683', NULL, 0.00);
INSERT INTO public.clothing VALUES (3155, '4', 'Tommy Hilfiger', 'Shorts', 'Navy', 269, '815748', 19.99, NULL, 114, NULL, 'Jean Shorts
waist: 36
hips: 47
pasadka: 24
length: 45', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-20 23:20:58.145556', NULL, NULL);
INSERT INTO public.clothing VALUES (3314, 'S', 'Tommy Hilfiger', 'Sweat Shirt', 'White', 279, '742426', 19.99, NULL, 121, NULL, 'трёх нить с флагом на гр 
ПОГ 50
дл 60
рук 59', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-25 03:06:14.091463', NULL, NULL);
INSERT INTO public.clothing VALUES (1412, '4', 'Calvin Klein', 'Shorts', 'Black', 128, '927847', 8.83, NULL, 121, NULL, 'waist: 39
hips: 49
pasadka: 22
length: 31', NULL, 'women', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:13.657141', NULL, 0.00);
INSERT INTO public.clothing VALUES (3558, 'S', 'Calvin Klein', 'Sweat Shirt', 'Pink', 289, '133543', 19.99, NULL, NULL, NULL, 'с карманами и мал знаком белым возле кармана
ПОТ 37
ПОБ 49
дл 93
пос 25', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-03 03:00:12.274492', NULL, NULL);
INSERT INTO public.clothing VALUES (1238, 'S', 'Levis', 'T-Shirt', 'Unknown', 108, '05550S', 8.00, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:12.00652', NULL, NULL);
INSERT INTO public.clothing VALUES (3242, 'S', 'Calvin Klein', 'Sweat Pants', 'Pink', NULL, '??????', 29.99, 46.43, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-21 03:13:15.778119', NULL, 4.00);
INSERT INTO public.clothing VALUES (3315, 'S', 'Tommy Hilfiger', 'Dress', 'Red', 279, '741559', 29.99, NULL, NULL, NULL, 'tommy hilfiger on chest', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-25 03:13:17.632847', NULL, NULL);
INSERT INTO public.clothing VALUES (3471, 'M', 'Calvin Klein', 'T-Shirt', 'White', NULL, '196227', 12.99, NULL, 121, NULL, 'circled logo
short', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-01 03:09:49.003136', NULL, 0.00);
INSERT INTO public.clothing VALUES (3559, '8.5', 'Calvin Klein', 'Shoes', 'Black', 289, '839665', 29.99, NULL, 122, NULL, 'heels', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-03 03:02:19.893941', NULL, NULL);
INSERT INTO public.clothing VALUES (3400, 'L', 'Calvin Klein', 'Windbreaker', 'Black', 284, '389995', 49.99, NULL, 125, NULL, 'надпись calvin на спине
ПОГ 63
дл 75
рук 67
плечи 52', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-29 04:14:41.737761', NULL, 0.00);
INSERT INTO public.clothing VALUES (3156, '2', 'Tommy Hilfiger', 'Shorts', 'Navy', 269, '815755', 19.99, NULL, NULL, NULL, 'Jean Shorts
waist: 35
hips: 45
pasadka: 23
length: 45', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-20 23:21:50.466548', NULL, 0.00);
INSERT INTO public.clothing VALUES (1003, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 77, '683118', 52.01, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:09.82605', NULL, NULL);
INSERT INTO public.clothing VALUES (1005, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 77, '577349', 33.59, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:09.843763', NULL, NULL);
INSERT INTO public.clothing VALUES (1717, 'S', 'Calvin Klein', 'Sweat Shirt', 'Pink', 56, '000000', 19.99, 50.00, 50, 22, 'Long neck, belly pouch, "performance" tag

Chest: 50
Waist: 48
Length: 63
Arm: 61', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:16.462917', NULL, 0.00);
INSERT INTO public.clothing VALUES (3157, 'S', 'Calvin Klein', 'T-Shirt', 'White', 269, '903703', 12.99, NULL, 114, NULL, 'Black on black calvin square
chest: 51
length: 69', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-20 23:22:35.941648', NULL, NULL);
INSERT INTO public.clothing VALUES (3401, 'M', 'Calvin Klein', 'Windbreaker', 'Black', 284, '390007', 49.99, NULL, 117, NULL, 'надпись calvin на спине
ПОГ 58
дл 74
рук 66
плечи 51', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-29 04:15:52.649715', NULL, 0.00);
INSERT INTO public.clothing VALUES (3316, 'L', 'Tommy Hilfiger', 'Sweater', 'Navy', 279, '714394', 15.00, NULL, 121, NULL, NULL, NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-25 03:14:33.945652', NULL, 0.00);
INSERT INTO public.clothing VALUES (3472, '10-12M', 'Levis', 'T-Shirt', 'Black', 286, '900359', 4.99, NULL, 119, NULL, 'kid clothes
san francisco
chest: 42
length: 59', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-01 03:18:39.784869', NULL, 0.00);
INSERT INTO public.clothing VALUES (3560, '9', 'Calvin Klein', 'Shoes', 'Black', 289, '839672', 29.99, NULL, NULL, NULL, 'heels', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-03 03:02:34.121096', NULL, NULL);
INSERT INTO public.clothing VALUES (3643, 'M', 'Armani Exchange', 'Dress', 'Pink', 294, '7212627', 28.00, NULL, NULL, NULL, 'ПОГ 55
ПОБ 52
дл 95
', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-06 21:15:08.690599', NULL, 0.00);
INSERT INTO public.clothing VALUES (3317, 'L', 'Tommy Hilfiger', 'Dress', 'Black', 279, '779879201999', 19.99, NULL, 120, NULL, 'с золотой надписью CAlvin klein', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-25 03:16:46.102899', NULL, 0.00);
INSERT INTO public.clothing VALUES (3402, 'M', 'Calvin Klein', 'Windbreaker', 'Black', 284, '133627', 39.99, NULL, 121, NULL, 'надпись calvin внутри вдоль молнии
ПОГ 58
дл 67
рук 66
плечи 51', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-29 04:18:28.234382', NULL, 0.00);
INSERT INTO public.clothing VALUES (2555, 'M', 'Calvin Klein', 'Leggings', 'Black', 207, '036905', 19.99, NULL, 121, 22, 'white words everywhere
vertical rubber-band on calf
waist: 35
hips: 42
pasadka: 23
length: 80', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-15 04:34:14.314931', NULL, 0.00);
INSERT INTO public.clothing VALUES (3473, 'L', 'Levis', 'T-Shirt', 'Black', 286, '905392', 19.99, NULL, 119, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-01 03:21:34.835962', NULL, NULL);
INSERT INTO public.clothing VALUES (3561, '7.5', 'Calvin Klein', 'Shoes', 'Black', 289, '839641', 29.99, NULL, 122, NULL, 'heels', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-03 03:02:48.128571', NULL, NULL);
INSERT INTO public.clothing VALUES (3158, 'M', 'Michael Kors', 'Long Sleeved Shirt', 'Navy', 269, '056583', 19.99, NULL, 127, NULL, 'chest: 55
length: 76
arm: 66
shoulders: 48', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-20 23:23:44.294449', NULL, NULL);
INSERT INTO public.clothing VALUES (933, 'S', 'Tommy Hilfiger', 'Sweat Shirt', 'White', 65, '418295', 33.60, NULL, 39, NULL, 'Chest: 49
waist: 47
length: 61
arm: 60
', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:09.160344', NULL, NULL);
INSERT INTO public.clothing VALUES (962, '8', 'Tommy Hilfiger', 'Sweat Shirt', 'Unknown', 61, '686898', 7.49, NULL, 36, NULL, '', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:09.426677', NULL, NULL);
INSERT INTO public.clothing VALUES (1719, 'M', 'Calvin Klein', 'Sweat Shirt', 'White', 56, '792320', 24.99, 48.21, 50, 22, 'Long neck, "performance" tag
large black "Calvin" on chest

Chest: 64
Waist: 54
Length: 61
Arm: 43', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:16.480836', NULL, NULL);
INSERT INTO public.clothing VALUES (3159, 'L', 'Calvin Klein', 'T-Shirt', 'White', 269, '779257', 12.99, NULL, 114, NULL, 'grey + black letters
monogram logo
chest: 57
length: 72', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-20 23:24:41.097438', NULL, 0.00);
INSERT INTO public.clothing VALUES (3403, 'M', 'Calvin Klein', 'Windbreaker', 'Black', 284, '133634', 39.99, NULL, 121, NULL, 'надпись calvin внутри вдоль молнии
ПОГ 56
дл 67
рук 66
плечи 49', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-29 04:19:45.198687', NULL, 0.00);
INSERT INTO public.clothing VALUES (3562, '8', 'Michael Kors', 'Shoes', 'Black', 289, '713591', 49.99, NULL, NULL, NULL, 'heels', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-03 03:03:17.79845', NULL, 0.00);
INSERT INTO public.clothing VALUES (3474, 'XS', 'Levis', 'Jean Jacket', 'Navy', 286, '509690', 19.99, NULL, 127, NULL, 'chest: 49
length: 53
arm: 55/72
shoulders: 48', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-01 03:24:49.111466', NULL, 0.00);
INSERT INTO public.clothing VALUES (2056, '8', 'Michael Kors', 'Jeans', 'Navy', 157, '834825', 20.00, 27.06, 64, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-13 11:10:49.646384', NULL, 0.00);
INSERT INTO public.clothing VALUES (1649, 'M', 'Calvin Klein', 'Windbreaker', 'Black', 56, '133627', 29.00, 70.71, 43, 22, 'Chest: 60
Waist: 56
Length: 70
Arm: 68', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:15.833648', NULL, 4.09);
INSERT INTO public.clothing VALUES (3399, 'L', 'Calvin Klein', 'Windbreaker', 'Black', 284, '389995', 49.99, 89.29, 117, 23, 'надпись calvin на спине 
ПОГ 63
дл 75
рук 67
плечи 52', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-29 04:14:08.006019', NULL, NULL);
INSERT INTO public.clothing VALUES (3160, 'S', 'Calvin Klein', 'T-Shirt', 'Black', 269, '784046', 12.99, NULL, 114, NULL, 'CKJEANS on side
chest: 50
length: 66', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-20 23:25:28.001385', NULL, NULL);
INSERT INTO public.clothing VALUES (3563, '6.5', 'Michael Kors', 'Shoes', 'Black', 289, '713560', 49.99, NULL, NULL, NULL, 'heels', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-03 03:04:11.576178', NULL, NULL);
INSERT INTO public.clothing VALUES (3475, 'M', 'Armani Exchange', 'Dress Shirt', 'Red', 287, '4364592', 19.99, NULL, 125, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-02 21:16:46.111402', NULL, NULL);
INSERT INTO public.clothing VALUES (3161, 'M', 'Karl Lagerfeld', 'Dress', 'Black', 269, 'LD1R9551', 19.99, NULL, 122, NULL, 'white square on boob

chest: 48
length: 94', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-20 23:26:25.193313', NULL, 0.00);
INSERT INTO public.clothing VALUES (3564, '9', 'Michael Kors', 'Shoes', 'Black', 289, '713614', 49.99, NULL, 122, NULL, 'heels', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-03 03:04:24.993437', NULL, NULL);
INSERT INTO public.clothing VALUES (3243, 'L', 'Calvin Klein', 'Sweat Shirt', 'Tan', NULL, '??????', 29.99, 50.00, NULL, 22, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-21 20:09:05.901669', NULL, 4.00);
INSERT INTO public.clothing VALUES (3476, 'S', 'Armani Exchange', 'Dress Shirt', 'Red', 287, '4364608', 19.99, NULL, 125, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-02 21:19:11.932551', NULL, 0.00);
INSERT INTO public.clothing VALUES (3320, 'S', 'Tommy Hilfiger', 'Dress', 'Black', 279, '779879201999', 19.99, NULL, 127, NULL, 'с золотой надписью CAlvin klein
ПОГ 45
ПОб 49
дл 91', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-25 03:19:02.513022', NULL, 0.00);
INSERT INTO public.clothing VALUES (3405, 'S', 'Adidas', 'Skirt', 'Pink', 284, '728101', 19.99, NULL, 119, NULL, 'плесированная

ПОТ 31-41
дл 80', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-29 04:24:34.652604', NULL, 0.00);
INSERT INTO public.clothing VALUES (852, 'XS', 'Armani Exchange', 'Vest Jacket', 'Carrot', 57, '114844', 29.99, NULL, 41, NULL, 'Chest: 39
Waist: 39
Length: 58', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:08.359125', NULL, NULL);
INSERT INTO public.clothing VALUES (661, 'XS', 'Armani Exchange', 'Sweat Shirt', 'White', 32, '001542', 9.99, 13.64, 31, 9, 'Black pixelated letters', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.437533', NULL, NULL);
INSERT INTO public.clothing VALUES (662, 'L', 'Armani Exchange', 'T-Shirt', 'Navy', 43, '775078', 19.90, 27.17, 31, 9, 'silver rhinestones', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.446308', NULL, NULL);
INSERT INTO public.clothing VALUES (663, 'M', 'Armani Exchange', 'T-Shirt', 'Black', 43, '137905', 19.99, 27.30, 31, 9, 'silver rhinestones', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.454908', NULL, NULL);
INSERT INTO public.clothing VALUES (669, 'M', 'Michael Kors', 'Sweater', 'Red', NULL, '173930', 23.00, 31.05, 31, 9, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.507963', NULL, NULL);
INSERT INTO public.clothing VALUES (670, 'M', 'Tommy Hilfiger', 'Golfik', 'Navy', NULL, '130467', 12.00, 16.20, 31, 9, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.517704', NULL, NULL);
INSERT INTO public.clothing VALUES (671, 'M', 'Michael Kors', 'Sweater', 'Black', NULL, '173787', 20.00, 27.00, 31, 9, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.525793', NULL, NULL);
INSERT INTO public.clothing VALUES (672, 'M', 'Tommy Hilfiger', 'Golfik', 'Black', NULL, '130672', 12.00, 16.20, 31, 9, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.53552', NULL, NULL);
INSERT INTO public.clothing VALUES (673, 'M', 'Michael Kors', 'Jacket', 'Olive', NULL, '270768', 54.00, 72.90, 31, 9, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.543767', NULL, NULL);
INSERT INTO public.clothing VALUES (532, 'S', 'Levis', 'Belt', 'Black', 39, '091656', 10.39, 14.04, 32, 9, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.317092', NULL, NULL);
INSERT INTO public.clothing VALUES (533, '34', 'Levis', 'Belt', 'Black', 39, '462243', 7.99, 10.80, 32, 9, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.325531', NULL, NULL);
INSERT INTO public.clothing VALUES (117, 'XXS', 'Tommy Hilfiger', 'Sweat Shirt', 'Navy', 11, '792803', 15.99, 21.79, 32, 9, '"Tommy Hilfiger" in block letters on chest

Chest: 43
Waist: 41
Length: 58
Arm: 58', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.667759', NULL, NULL);
INSERT INTO public.clothing VALUES (393, 'XXS', 'Tommy Hilfiger', 'Sweat Shirt', 'Navy', 31, '792872', 11.99, 16.34, 32, 9, 'to alla', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.106222', NULL, NULL);
INSERT INTO public.clothing VALUES (394, 'L', 'Tommy Hilfiger', 'Sweat Shirt', 'White', 31, '418325', 11.99, 16.34, 32, 9, 'to alla', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.115105', NULL, NULL);
INSERT INTO public.clothing VALUES (445, 'L', 'Michael Kors', 'Belt', 'White, Grey', NULL, '980427', 14.00, 18.90, 32, 9, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.563612', NULL, NULL);
INSERT INTO public.clothing VALUES (531, 'S', 'Levis', 'Belt', 'Black', 39, '145762', 10.42, 13.86, 32, 9, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.307896', NULL, NULL);
INSERT INTO public.clothing VALUES (527, '38', 'Levis', 'Belt', 'Black', 39, '498585', 7.99, 10.80, 32, 9, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.272369', NULL, NULL);
INSERT INTO public.clothing VALUES (534, '38', 'Levis', 'Belt', 'Brown', 39, '294742', 10.39, 14.04, 32, 9, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.334701', NULL, NULL);
INSERT INTO public.clothing VALUES (804, 'S', 'Michael Kors', 'Puffy Jacket', 'Black', 56, '756790', 134.40, NULL, NULL, NULL, 'jacket from Michael Kors', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:08:00.688142', NULL, NULL);
INSERT INTO public.clothing VALUES (791, 'S', 'Calvin Klein', 'Hoodie Dress', 'White', 54, '427871', 10.81, NULL, NULL, NULL, NULL, true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.573835', NULL, NULL);
INSERT INTO public.clothing VALUES (805, 'S', 'Calvin Klein', 'Sweat Shirt', 'Pink', NULL, '827497', 29.99, NULL, NULL, NULL, NULL, true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.696372', NULL, NULL);
INSERT INTO public.clothing VALUES (801, 'M', 'Tommy Hilfiger', 'Golfik', 'Navy', 55, '395441', 17.49, NULL, NULL, NULL, NULL, true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.662632', NULL, NULL);
INSERT INTO public.clothing VALUES (790, 'XS', 'Calvin Klein', 'Satin Pants', 'Black', 54, '549462', 10.81, NULL, NULL, NULL, 'waist: 36
hips: 50
Length: 96', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.560341', NULL, NULL);
INSERT INTO public.clothing VALUES (1183, '???', 'Calvin Klein', 'unknown', 'Unknown', 103, '626077', 7.90, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.507571', NULL, NULL);
INSERT INTO public.clothing VALUES (2353, 'M', 'Calvin Klein', 'Gloves', 'Black', 188, '543077', 8.49, NULL, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-01-31 15:10:49.648659', NULL, 0.00);
INSERT INTO public.clothing VALUES (535, '34', 'Levis', 'Belt', 'Black', 39, '498561', 7.99, 10.80, 32, 9, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.343052', NULL, NULL);
INSERT INTO public.clothing VALUES (2179, 'XXS', 'Tommy Hilfiger', 'Golfik', 'White', 169, '398640', 19.99, NULL, NULL, NULL, 'silver round logo', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-01-21 17:04:38.092793', NULL, NULL);
INSERT INTO public.clothing VALUES (653, 'S', 'Tommy Hilfiger', 'Puffy Jacket', 'Gold', 40, '899915', 55.99, 75.67, 32, 9, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.365189', NULL, NULL);
INSERT INTO public.clothing VALUES (654, 'L', 'Tommy Hilfiger', 'Puffy Jacket', 'Gold', 40, '899892', 56.01, 75.70, 32, 9, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.373714', NULL, NULL);
INSERT INTO public.clothing VALUES (666, 'L', 'Michael Kors', 'Puffy Jacket', 'Grey', NULL, '573350', 79.99, 107.99, 32, 9, 'burlington tag
long
hooded', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.481855', NULL, NULL);
INSERT INTO public.clothing VALUES (1968, 'M', 'Tommy Hilfiger', 'Free Sweater', 'Red', 150, '416023', 15.99, NULL, NULL, NULL, 'chest: 53
length: 73
arm: 70', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-01-08 10:43:09.062071', NULL, 0.00);
INSERT INTO public.clothing VALUES (1160, '0', 'Calvin Klein', 'Pants', 'Grey', 99, '203361', 13.51, NULL, 38, NULL, NULL, true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:11.2895', NULL, NULL);
INSERT INTO public.clothing VALUES (3162, 'S', 'Calvin Klein', 'Shorts', 'Black', 269, '348053', 14.99, NULL, 114, NULL, 'bicycle shorts
white stripe on side
waist: 35
hips: 39
pasadka: 25
length: 47', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-20 23:27:59.192469', NULL, NULL);
INSERT INTO public.clothing VALUES (926, '36', 'Calvin Klein', 'Jeans', 'Blue', 64, '011996', 13.52, NULL, 119, NULL, 'Waist: 47
Length: 111
Lapatka: 32', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:09.094247', NULL, NULL);
INSERT INTO public.clothing VALUES (2373, 'XS', 'DKNY', 'Puffy Jacket', 'Green', 190, '273823', 47.99, 110.71, NULL, 22, 'chest: 51
length: 70
hips: 51
arm: 57
shoulders: 50', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-01-31 15:35:43.421286', NULL, NULL);
INSERT INTO public.clothing VALUES (1185, 'XS', 'Calvin Klein', 'Sweat Shirt', 'White', 104, '499298', 11.90, NULL, NULL, NULL, 'Chest: 63
Waist: 63
Length: 45
Arm: 51', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.525345', NULL, NULL);
INSERT INTO public.clothing VALUES (1188, '???', 'Calvin Klein', 'unknown', 'Unknown', 105, '618678', 14.67, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.552865', NULL, NULL);
INSERT INTO public.clothing VALUES (667, 'XS', 'Hunter', 'Puffy Jacket', 'Black', NULL, '527194', 79.99, 107.99, 32, 9, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.490421', NULL, NULL);
INSERT INTO public.clothing VALUES (668, 'M', 'Tommy Hilfiger', 'Coat', 'Plaid', 42, '916797', 56.02, 76.50, 32, 9, 'To Alla', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.499708', NULL, NULL);
INSERT INTO public.clothing VALUES (1189, '???', 'Calvin Klein', 'unknown', 'Unknown', 105, '908888', 14.66, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.561282', NULL, NULL);
INSERT INTO public.clothing VALUES (1190, '???', 'Calvin Klein', 'unknown', 'Unknown', 105, '908871', 14.66, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.570792', NULL, NULL);
INSERT INTO public.clothing VALUES (1191, '???', 'Calvin Klein', 'unknown', 'Unknown', 105, '662151', 24.00, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.579554', NULL, NULL);
INSERT INTO public.clothing VALUES (2064, 'M', 'Karl Lagerfeld', 'Hoodie', 'Black', 158, '849176', 29.99, NULL, NULL, NULL, 'chest: 56
length: 70
arm: 62', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-01-13 11:20:45.821094', NULL, NULL);
INSERT INTO public.clothing VALUES (850, 'L', 'Armani Exchange', 'Puffy Jacket', 'Black', 57, '335567', 55.99, NULL, NULL, NULL, 'Shiny

Chest: 63cm
Waist: 63cm
Length: 73cm
Arm: 61cm', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:08.33723', NULL, NULL);
INSERT INTO public.clothing VALUES (1736, 'XS', 'DKNY', 'Puffy Jacket', 'Black', NULL, '202738', 60.00, NULL, NULL, NULL, 'super long

chest: 50
waist: 43
length: 120
arm: 62', true, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 07:53:36.766883', NULL, 0.00);
INSERT INTO public.clothing VALUES (853, '32', 'Armani Exchange', 'Jeans', 'Blue', 57, '140188', 14.99, NULL, NULL, NULL, 'Waist: 45
Length: 101
Lapatka: 25
', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:08.368091', NULL, NULL);
INSERT INTO public.clothing VALUES (1935, 'XS', 'DKNY', 'T-Shirt', 'Black', NULL, '923555', 20.00, NULL, NULL, NULL, 'White DKNY on chest

chest: 45
length: 62', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-03 04:20:34.726805', NULL, 0.00);
INSERT INTO public.clothing VALUES (1229, '30', 'Levis', 'Jeans', 'Unknown', 107, '603032', 34.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.924362', NULL, NULL);
INSERT INTO public.clothing VALUES (854, '33', 'Armani Exchange', 'Jeans', 'Black', 57, '137799', 14.99, NULL, NULL, NULL, 'Black Stripe on side

Waist: 47
Length: 102
Lapatka: 26
', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:08.378263', NULL, NULL);
INSERT INTO public.clothing VALUES (1192, '???', 'Calvin Klein', 'unknown', 'Unknown', 105, '527482', 20.14, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.588883', NULL, NULL);
INSERT INTO public.clothing VALUES (1, 'L', 'Tommy Hilfiger', 'Puffy Jacket', 'Red, Navy', 1, '218973', 49.99, NULL, 10, NULL, 'Blue hood, red body

Chest: 55
Waist: 52
Length: 64
Arm: 64', false, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:53.628994', NULL, NULL);
INSERT INTO public.clothing VALUES (12, 'M', 'Tommy Hilfiger', 'Puffy Jacket', 'Navy, Red, White', 2, '959107', 49.99, 125.87, 21, 4, 'sold for 3600
mom has 3400

Red & white boobs

Chest: 56
Waist: 51
Length: 60
Arm: 63', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:53.735133', NULL, NULL);
INSERT INTO public.clothing VALUES (737, 'S', 'Calvin Klein', 'T-Shirt', 'Pink', NULL, '351473', 12.00, 16.20, 32, 9, 'no sleeves
with hood', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.103026', NULL, NULL);
INSERT INTO public.clothing VALUES (2006, 'XS', 'Calvin Klein', 'Skirt', 'Black', 154, '659355', 9.13, NULL, 106, NULL, 'long
waist: 32
hips: 47
length: 81', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-01-08 12:02:24.991977', NULL, 0.00);
INSERT INTO public.clothing VALUES (2235, 'L', 'Calvin Klein', 'Hoodie', 'Black', 175, '254853', 29.99, NULL, NULL, NULL, 'grey sign on chest

chest: 58
length: 71
arm: 69', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-01-22 10:05:32.553997', NULL, 0.00);
INSERT INTO public.clothing VALUES (2372, 'S', 'Calvin Klein', 'Puffy Jacket', 'White', NULL, '056377', 0.00, NULL, NULL, NULL, 'rainbow spacesuit
Don''t know tag number for small', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-01-31 15:33:45.429094', NULL, NULL);
INSERT INTO public.clothing VALUES (1196, '???', 'Calvin Klein', 'unknown', 'Unknown', 105, '721062', 10.70, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.624398', NULL, NULL);
INSERT INTO public.clothing VALUES (1197, '???', 'Calvin Klein', 'unknown', 'Unknown', 105, '427833', 25.05, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.633549', NULL, NULL);
INSERT INTO public.clothing VALUES (1198, '???', 'Calvin Klein', 'unknown', 'Unknown', 105, '952702', 22.55, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.642392', NULL, NULL);
INSERT INTO public.clothing VALUES (1199, '???', 'Calvin Klein', 'unknown', 'Unknown', 105, '952818', 17.51, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.652237', NULL, NULL);
INSERT INTO public.clothing VALUES (1200, '???', 'Calvin Klein', 'unknown', 'Unknown', 105, '719532', 23.62, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.660638', NULL, NULL);
INSERT INTO public.clothing VALUES (1201, '???', 'Calvin Klein', 'unknown', 'Unknown', 105, '847987', 12.59, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.670481', NULL, NULL);
INSERT INTO public.clothing VALUES (1203, '00', 'Calvin Klein', 'Pants', 'Navy', 105, '668045', 12.59, NULL, NULL, NULL, 'Waist: 39
Hips: 51
Length: 88
Pasadka: 22', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.689154', NULL, NULL);
INSERT INTO public.clothing VALUES (1208, '???', 'Calvin Klein', 'unknown', 'Unknown', 105, '927854', 14.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.733776', NULL, NULL);
INSERT INTO public.clothing VALUES (1209, '???', 'Calvin Klein', 'unknown', 'Unknown', 105, '927922', 14.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.742689', NULL, NULL);
INSERT INTO public.clothing VALUES (1210, '???', 'Calvin Klein', 'unknown', 'Unknown', 105, '927915', 14.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.751879', NULL, NULL);
INSERT INTO public.clothing VALUES (1211, '???', 'Calvin Klein', 'unknown', 'Unknown', 105, '662946', 14.40, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.760428', NULL, NULL);
INSERT INTO public.clothing VALUES (1212, '???', 'Calvin Klein', 'unknown', 'Unknown', 105, '632435', 29.40, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.77009', NULL, NULL);
INSERT INTO public.clothing VALUES (1213, '???', 'Calvin Klein', 'unknown', 'Unknown', 105, '662595', 14.40, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.77852', NULL, NULL);
INSERT INTO public.clothing VALUES (2272, 'XS', 'DKNY', 'Puffy Jacket', 'Green', 180, '273823', 59.99, NULL, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-01-23 20:47:02.785844', NULL, 0.00);
INSERT INTO public.clothing VALUES (1936, 'XS', 'Levis', 'Rain Coat', 'Pink', NULL, '081610', 39.99, NULL, NULL, NULL, 'chest: 46
length: 83', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-03 04:22:10.107035', NULL, 0.00);
INSERT INTO public.clothing VALUES (1214, '???', 'Calvin Klein', 'unknown', 'Unknown', 105, '475001', 38.85, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.789611', NULL, NULL);
INSERT INTO public.clothing VALUES (1215, '???', 'Calvin Klein', 'unknown', 'Unknown', 106, '528151', 13.44, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.79829', NULL, NULL);
INSERT INTO public.clothing VALUES (1217, '???', 'Calvin Klein', 'unknown', 'Unknown', 106, '866336', 11.04, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.816662', NULL, NULL);
INSERT INTO public.clothing VALUES (1218, '???', 'Calvin Klein', 'unknown', 'Unknown', 106, '866367', 11.04, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.825297', NULL, NULL);
INSERT INTO public.clothing VALUES (1221, '???', 'Levis', 'unknown', 'Unknown', 63, '20600S', 20.65, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.852127', NULL, NULL);
INSERT INTO public.clothing VALUES (1222, '???', 'Levis', 'unknown', 'Unknown', 63, '04300L', 7.20, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.860883', NULL, NULL);
INSERT INTO public.clothing VALUES (1223, '???', 'Levis', 'unknown', 'Unknown', 63, '04290M', 7.20, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.870534', NULL, NULL);
INSERT INTO public.clothing VALUES (1224, 'S', 'Levis', 'Trucker Jacket', 'Unknown', 63, '00490S', 19.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.8789', NULL, NULL);
INSERT INTO public.clothing VALUES (1225, 'XS', 'Levis', 'Trucker Jacket', 'Unknown', 63, '0490XS', 19.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.888534', NULL, NULL);
INSERT INTO public.clothing VALUES (857, 'M', 'Armani Exchange', 'Sport Pants', 'Navy', 57, '493277', 23.99, NULL, NULL, NULL, 'Stripe on side

Waist: 40
Length: 104
Lapatka: 31', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:08.411991', NULL, NULL);
INSERT INTO public.clothing VALUES (858, 'M', 'Armani Exchange', 'Sport Jacket', 'Navy', 57, '493147', 31.99, NULL, NULL, NULL, 'Stripe on arms and back

Chest: 49
Hips: 48
Length: 62
Arm: 60', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:08.426145', NULL, NULL);
INSERT INTO public.clothing VALUES (859, 'M', 'Armani Exchange', 'Puffy Jacket', 'Green', 57, '337073', 55.99, 147.36, NULL, NULL, 'Chest: 57
Waist: 55
Length: 64
Arm: 63', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:08.434824', NULL, NULL);
INSERT INTO public.clothing VALUES (861, 'S', 'Armani Exchange', 'Puffy Jacket', 'Navy', 57, '349823', 55.99, NULL, NULL, NULL, 'Oversized

Chest: 58
Waist: 57
Length: 83
Arm: 63', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:08.453631', NULL, NULL);
INSERT INTO public.clothing VALUES (928, 'M', 'Calvin Klein', 'Vest Jacket', 'Green', 64, '163039', 22.00, NULL, NULL, NULL, 'Chest: 51
Waist: 55
Length: 63', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:09.113484', NULL, NULL);
INSERT INTO public.clothing VALUES (969, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 62, '686966', 7.49, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:09.491447', NULL, NULL);
INSERT INTO public.clothing VALUES (970, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 62, '686966', 7.49, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:09.507143', NULL, NULL);
INSERT INTO public.clothing VALUES (971, 'S', 'Tommy Hilfiger', 'Sweater', 'Grey, White', 62, '686898', 7.49, 38.59, NULL, NULL, 'words everywhere in grey
red zipper

Chest: 47
Waist: 47
Length: 56
Arm: 62', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:09.520651', NULL, NULL);
INSERT INTO public.clothing VALUES (972, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 62, '686904', 7.49, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:09.530393', NULL, NULL);
INSERT INTO public.clothing VALUES (68, 'S', 'Calvin Klein', 'Sweater', 'Pink', NULL, '5534', 19.99, NULL, 2, NULL, 'Belly pocket
long neck', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.235476', NULL, NULL);
INSERT INTO public.clothing VALUES (973, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 62, '682005', 26.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:09.53917', NULL, NULL);
INSERT INTO public.clothing VALUES (975, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 62, '061803', 33.74, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:09.557694', NULL, NULL);
INSERT INTO public.clothing VALUES (1033, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 83, '575116', 11.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.103276', NULL, NULL);
INSERT INTO public.clothing VALUES (1036, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 83, '329733', 11.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.143067', NULL, NULL);
INSERT INTO public.clothing VALUES (1207, '4', 'Calvin Klein', 'Shorts', 'Black', 105, '927847', 14.99, NULL, NULL, NULL, 'waist: 39
hips: 49
pasadka: 22
length: 31', NULL, 'women', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:11.725071', NULL, 0.00);
INSERT INTO public.clothing VALUES (3477, 'L', 'Armani Exchange', 'Dress Shirt', 'Mint', 287, '4364639', 19.99, NULL, 125, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-02 21:20:19.093', NULL, NULL);
INSERT INTO public.clothing VALUES (2716, 'XL', 'DKNY', 'Hoodie', 'Grey', 223, '028773', 19.99, 26.92, 91, 9, NULL, NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-02-27 22:50:01.94192', NULL, 0.00);
INSERT INTO public.clothing VALUES (1041, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 83, '787151', 24.01, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.189052', NULL, NULL);
INSERT INTO public.clothing VALUES (1042, '???', 'Calvin Klein', 'unknown', 'Unknown', 70, '599332', 11.90, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.198688', NULL, NULL);
INSERT INTO public.clothing VALUES (1043, '???', 'Calvin Klein', 'unknown', 'Unknown', 70, '599335', 11.89, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.208272', NULL, NULL);
INSERT INTO public.clothing VALUES (1044, '???', 'Calvin Klein', 'unknown', 'Unknown', 70, '826095', 24.32, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.217412', NULL, NULL);
INSERT INTO public.clothing VALUES (1259, 'S', 'Levis', 'Bodysuit', 'Unknown', 112, '870010', 3.49, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:12.207066', NULL, NULL);
INSERT INTO public.clothing VALUES (1260, 'M', 'Levis', 'Bodysuit', 'Unknown', 112, '870010', 3.49, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:12.215616', NULL, NULL);
INSERT INTO public.clothing VALUES (1261, 'M', 'Levis', 'Bodysuit', 'Unknown', 112, '870009', 3.49, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:12.224519', NULL, NULL);
INSERT INTO public.clothing VALUES (1262, 'S', 'Levis', 'unknown', 'Unknown', 112, '170062', 16.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:12.232891', NULL, NULL);
INSERT INTO public.clothing VALUES (738, 'XS', 'Calvin Klein', 'T-Shirt', 'Pink', NULL, '351480', 12.00, 16.20, 32, 9, 'no sleeves
with hood', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.111052', NULL, NULL);
INSERT INTO public.clothing VALUES (739, 'M', 'Calvin Klein', 'T-Shirt', 'Pink', NULL, '351466', 12.00, 16.20, 32, 9, 'no sleeves
with hood', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.120031', NULL, NULL);
INSERT INTO public.clothing VALUES (740, 'M', 'Calvin Klein', 'Long sleeved shirt', 'Black', NULL, '794883', 12.00, 16.20, 32, 9, 'Chest: 54
Waist: 50
Length: 74
Arm: 66', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.128014', NULL, NULL);
INSERT INTO public.clothing VALUES (741, 'L', 'Calvin Klein', 'Long sleeved shirt', 'White', NULL, '794951', 12.00, 16.20, 32, 9, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.137103', NULL, NULL);
INSERT INTO public.clothing VALUES (742, 'XXL', 'Armani Exchange', 'Vest Jacket', 'Navy, White', 33, '932982', 34.99, 47.79, 32, 9, 'puffy jacket body
sweat shirt sleeves', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.145079', NULL, NULL);
INSERT INTO public.clothing VALUES (743, 'M', 'Michael Kors', 'Puffy Jacket', 'Navy', NULL, '102755', 59.00, 79.65, 32, 9, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.154179', NULL, NULL);
INSERT INTO public.clothing VALUES (798, 'S', 'Calvin Klein', 'Jacket', 'Black', 54, '015306', 17.61, 23.80, 32, 9, 'double sided
(black on other side)', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.638243', NULL, 0.00);
INSERT INTO public.clothing VALUES (795, 'M', 'Calvin Klein', 'Jacket', 'Black', 54, '068974', 17.61, 23.80, 32, 9, 'double sided', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.612439', NULL, 0.00);
INSERT INTO public.clothing VALUES (776, '8', 'Calvin Klein', 'Shoes', 'Red', NULL, 'Shoe02', 19.99, 26.99, 32, 9, 'high heels', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.436312', NULL, 0.00);
INSERT INTO public.clothing VALUES (775, '8', 'Calvin Klein', 'Shoes', 'Black', NULL, 'Shoe01', 29.99, 40.49, 32, 9, 'high heels', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.421264', NULL, 0.00);
INSERT INTO public.clothing VALUES (1040, 'N/A', 'Tommy Hilfiger', 'Hat', 'Black', 83, '521548', 10.60, NULL, 105, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:10.180293', NULL, 0.00);
INSERT INTO public.clothing VALUES (1105, 'S', 'Calvin Klein', 'T-Shirt', 'White', 88, '667741', 12.75, NULL, NULL, NULL, 'silver square', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.779327', NULL, NULL);
INSERT INTO public.clothing VALUES (1107, '???', 'Calvin Klein', 'unknown', 'Unknown', 88, '420227', 8.28, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.797701', NULL, NULL);
INSERT INTO public.clothing VALUES (1108, '???', 'Calvin Klein', 'unknown', 'Unknown', 88, '420234', 8.28, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.806347', NULL, NULL);
INSERT INTO public.clothing VALUES (1109, '???', 'Calvin Klein', 'unknown', 'Unknown', 88, '420234', 8.28, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.815826', NULL, NULL);
INSERT INTO public.clothing VALUES (1110, '???', 'Calvin Klein', 'unknown', 'Unknown', 88, '420227', 8.28, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.824563', NULL, NULL);
INSERT INTO public.clothing VALUES (1263, 'M', 'Levis', 'unknown', 'Unknown', 112, '170062', 16.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:12.24204', NULL, NULL);
INSERT INTO public.clothing VALUES (1264, 'S', 'Levis', 'Trucker Jacket', 'Black', 112, '920003', 31.80, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:12.250421', NULL, NULL);
INSERT INTO public.clothing VALUES (2211, 'S', 'DKNY', 'Polo Shirt', 'Navy', 173, '036652', 14.99, NULL, NULL, NULL, 'chest: 46
length: 68
', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-01-21 17:42:14.152204', NULL, NULL);
INSERT INTO public.clothing VALUES (1937, 'L', 'Tommy Hilfiger', 'Blazer', 'Navy', NULL, '756599', 20.00, NULL, NULL, NULL, 'Linen
chest: 55
length: 73
arm: 66', NULL, 'women', NULL, NULL, 'Linen', 'ukraine', '2021-01-03 04:24:48.232197', NULL, 0.00);
INSERT INTO public.clothing VALUES (1265, '29', 'Levis', 'Shorts', 'Blue', 113, '001029', 13.58, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:12.259927', NULL, NULL);
INSERT INTO public.clothing VALUES (1266, '26', 'Levis', 'Shorts', 'Unknown', 113, '113026', 27.72, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:12.268488', NULL, NULL);
INSERT INTO public.clothing VALUES (2358, '???', 'Calvin Klein', 'Sweat Pants', 'Black', 188, '561235', 16.99, NULL, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-01-31 15:16:51.787708', NULL, NULL);
INSERT INTO public.clothing VALUES (1267, 'XS', 'Levis', 'unknown', 'Unknown', 114, '0620XS', 16.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:12.277445', NULL, NULL);
INSERT INTO public.clothing VALUES (1268, 'L', 'Levis', 'Trucker Jacket', 'Unknown', 114, '00000L', 29.99, NULL, NULL, NULL, 'Revesible', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:12.286311', NULL, NULL);
INSERT INTO public.clothing VALUES (1269, 'M', 'Levis', 'Trucker Jacket', 'Unknown', 114, '00000M', 29.99, NULL, NULL, NULL, 'Revesible', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:12.294856', NULL, NULL);
INSERT INTO public.clothing VALUES (1270, 'S', 'Levis', 'Trucker Jacket', 'Unknown', 114, '00000S', 29.99, NULL, NULL, NULL, 'Revesible', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:12.30423', NULL, NULL);
INSERT INTO public.clothing VALUES (1429, 'XL', 'Levis', 'T-Shirt', 'Unknown', 130, '0300XL', 6.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:13.808087', NULL, NULL);
INSERT INTO public.clothing VALUES (1280, '8', 'Calvin Klein', 'Pants', 'Tan', 115, '566099', 24.93, NULL, NULL, NULL, 'Waist: 40
Hips: 53
Length: 90
Pasadka: 28', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:12.392654', NULL, NULL);
INSERT INTO public.clothing VALUES (1281, '6', 'Calvin Klein', 'Blazer', 'White', 115, '333066', 19.96, NULL, NULL, NULL, 'Chest:  44
Waist: 40
Length: 55
Arm: 59', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:12.401244', NULL, NULL);
INSERT INTO public.clothing VALUES (1282, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 115, '452835', 24.96, NULL, NULL, NULL, 'Chest:  
Waist: 
Length: 
Arm: ', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:12.410095', NULL, NULL);
INSERT INTO public.clothing VALUES (1283, '2', 'Tommy Hilfiger', 'Blazer', 'Light Blue', 115, '330379', 24.96, 80.70, NULL, NULL, 'Chest:  43
Waist: 36
Length: 62
Arm:  61', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:12.419095', NULL, NULL);
INSERT INTO public.clothing VALUES (1286, 'N/A', 'Calvin Klein', 'Bag', 'Unknown', 116, '929931', 30.26, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:12.445628', NULL, NULL);
INSERT INTO public.clothing VALUES (1288, 'S', 'Armani Exchange', 'Sport Jacket', 'White', 60, '385108', 30.80, NULL, NULL, NULL, 'grey stripe on arms + back

Chest: 48
Waist: 43
Length: 62
Arm: 58', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:12.463141', NULL, NULL);
INSERT INTO public.clothing VALUES (1289, 'L', 'Michael Kors', 'Jean Jacket', 'White', 56, '612833', 14.00, NULL, NULL, NULL, 'Marshalls tag: 140027\

Chest: 52
Waist: 52
Length: 54
Arm: 64', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:12.472442', NULL, NULL);
INSERT INTO public.clothing VALUES (1938, '8', 'Calvin Klein', 'Dress', 'Peach', NULL, '998104', 20.00, NULL, NULL, NULL, 'color: peach
chest: 47
hips: 48
length: 100', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-03 04:26:31.52175', NULL, 0.00);
INSERT INTO public.clothing VALUES (1291, 'S', 'Armani Exchange', 'Sport Pants', 'White', 60, '392205', 28.00, NULL, NULL, NULL, 'grey Stripe on side

Waist: 36
Hips: 49
Length: 96
Pasadka: 28', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:12.490398', NULL, NULL);
INSERT INTO public.clothing VALUES (1294, 'S', 'Tommy Hilfiger', 'Sweat Pants', 'Teal', 56, '790854', 0.00, NULL, NULL, NULL, 'Waist: 39
Hips: 50
Length: 98
Pasadka: 24', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:12.516463', NULL, NULL);
INSERT INTO public.clothing VALUES (1297, 'S', 'Tommy Hilfiger', 'Sweat Shirt', 'Teal', 56, '792896', 0.00, NULL, NULL, NULL, 'Chest: 49
Waist: 47
Length: 60
Arm: 59', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:12.544667', NULL, NULL);
INSERT INTO public.clothing VALUES (2131, 'L', 'Michael Kors', 'Sweat Shirt', 'Black', 165, '835308', 20.00, 27.19, 64, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-16 18:57:58.715758', NULL, 0.00);
INSERT INTO public.clothing VALUES (1298, 'S', 'Calvin Klein', 'Sweat Shirt', 'Black', 56, '792896', 0.00, NULL, NULL, NULL, 'Rhinestone "Calvin" on front

Chest: 50
Waist: 43
Length: 53
Arm: 53', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:12.554112', NULL, NULL);
INSERT INTO public.clothing VALUES (1303, '4', 'Karl Lagerfeld', 'Pants', 'Black', 56, 'C239', 5.99, NULL, NULL, NULL, 'Gold Buttons

Waist: 39
Hips: 45
Length: 95
Pasadka: 27', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:12.608963', NULL, NULL);
INSERT INTO public.clothing VALUES (1220, 'L', 'Calvin Klein', 'T-Shirt', 'Black', 106, '197945', 8.49, NULL, NULL, NULL, 'city picture on chest', NULL, 'men', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:11.843012', NULL, 0.00);
INSERT INTO public.clothing VALUES (2321, 'L', 'Calvin Klein', 'Puffy Jacket', 'Black', 185, '871988', 27.60, NULL, NULL, NULL, 'Men
shiny

chest: 65
length: 73
arm: 71', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-01-31 14:43:01.390061', NULL, 0.00);
INSERT INTO public.clothing VALUES (1319, '???', 'Calvin Klein', 'Sweat Pants', 'Unknown', 117, '952825', 19.46, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:12.781362', NULL, NULL);
INSERT INTO public.clothing VALUES (2041, '2', 'Armani Exchange', 'Blazer', 'Navy', 156, '319550', 15.99, NULL, NULL, NULL, 'chest: 45
length: 77', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-01-08 13:27:52.088257', NULL, 0.00);
INSERT INTO public.clothing VALUES (1323, 'S', 'Calvin Klein', 'Pants', 'Black', 121, '529765', 30.35, NULL, NULL, NULL, 'White strip on side', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:12.817651', NULL, NULL);
INSERT INTO public.clothing VALUES (1324, 'S', 'Calvin Klein', 'Pants', 'Black', 121, '529765', 30.34, NULL, NULL, NULL, 'White strip on side', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:12.826617', NULL, NULL);
INSERT INTO public.clothing VALUES (1326, '6', 'Tommy Hilfiger', 'Pants', 'Blue', 56, '191264', 0.00, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:12.844271', NULL, NULL);
INSERT INTO public.clothing VALUES (1329, '???', 'Armani Exchange', 'Pants', 'Unknown', 60, '767705', 27.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:12.871381', NULL, NULL);
INSERT INTO public.clothing VALUES (1330, '???', 'Armani Exchange', 'Sweat Shirt', 'Unknown', 60, '424738', 20.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:12.880146', NULL, NULL);
INSERT INTO public.clothing VALUES (3163, 'M', 'Guess', 'T-Shirt', 'White', 269, '256386', 12.99, NULL, 114, NULL, 'gold horizontal sign
chest: 47
length: 61', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-20 23:28:42.436095', NULL, NULL);
INSERT INTO public.clothing VALUES (1608, 'L', 'Levis', 'T-Shirt', 'White', 147, '399623', 7.99, NULL, 119, NULL, 'with man and horses', NULL, 'men', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:15.460905', NULL, 0.00);
INSERT INTO public.clothing VALUES (1256, 'S', 'DKNY', 'Pants', 'Black', 56, '???', 0.00, NULL, 37, NULL, 'white strip on side', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:12.179578', NULL, NULL);
INSERT INTO public.clothing VALUES (326, 'XS', 'Calvin Klein', 'Sweater', 'White', 27, '364626', 10.12, NULL, 62, NULL, 'with stars

chest: 60
length: 45
arm: 53-74', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.506891', NULL, 0.00);
INSERT INTO public.clothing VALUES (1332, '???', 'Armani Exchange', 'Sweat Shirt', 'Unknown', 60, '302644', 27.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:12.898003', NULL, NULL);
INSERT INTO public.clothing VALUES (1333, '???', 'Armani Exchange', 'T-Shirt', 'Unknown', 60, '142961', 20.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:12.907613', NULL, NULL);
INSERT INTO public.clothing VALUES (1334, '???', 'Armani Exchange', 'T-Shirt', 'Unknown', 60, '224604', 9.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:12.916133', NULL, NULL);
INSERT INTO public.clothing VALUES (1337, '???', 'Armani Exchange', 'Sport Jacket', 'Unknown', 60, '579728', 29.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:12.944015', NULL, NULL);
INSERT INTO public.clothing VALUES (1340, '???', 'Armani Exchange', 'Pants', 'Unknown', 60, '954988', 14.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:12.970246', NULL, NULL);
INSERT INTO public.clothing VALUES (1346, 'M', 'Calvin Klein', 'Sweat Shirt', 'White', 56, '375943', 19.99, NULL, NULL, NULL, 'Ross receipt: 461442
pink and silver letters

Chest: 52
Waist: 52
Length: 65
Arm: 53

', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:13.023246', NULL, NULL);
INSERT INTO public.clothing VALUES (1347, 'M', 'Calvin Klein', 'Sweater', 'Black', 123, '354215', 19.99, NULL, NULL, NULL, 'TJ Maxx tag: 381287
Turtle neck
red square at bottom right

Chest: 56
Waist: 53
Length: 68
Arm: 57', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:13.031295', NULL, NULL);
INSERT INTO public.clothing VALUES (1348, 'XS', 'Armani Exchange', 'Sweat Pants', 'Red', 122, '289327', 20.99, 58.95, NULL, NULL, 'Waist: 33
Hips: 43
Length: 95
Pasadka: 26', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:13.040543', NULL, NULL);
INSERT INTO public.clothing VALUES (1349, 'XS', 'Armani Exchange', 'Sweat Pants', 'Navy', 122, '767774', 20.99, NULL, NULL, NULL, 'Red words on waistband

Waist: 35
Hips: 42
Length: 95
Pasadka: 28', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:13.048748', NULL, NULL);
INSERT INTO public.clothing VALUES (871, 'M', 'Calvin Klein', 'Sport Bra', 'Pink', 58, '126943', 6.12, 8.36, 52, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:08.54628', NULL, 0.00);
INSERT INTO public.clothing VALUES (868, 'M', 'Calvin Klein', 'Sport Bra', 'Pink', 58, '126943', 6.12, 8.36, 52, 9, '80cm', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:08.518787', NULL, 0.00);
INSERT INTO public.clothing VALUES (884, 'S', 'Calvin Klein', 'Sport Bra', 'Black', 59, '898554', 5.44, 7.43, 52, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:08.666166', NULL, 0.00);
INSERT INTO public.clothing VALUES (869, 'M', 'Calvin Klein', 'Panties', 'Purple', 58, '92750', 3.40, 4.64, 52, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:08.528224', NULL, 0.00);
INSERT INTO public.clothing VALUES (870, 'S', 'Calvin Klein', 'Panties', 'Pink', 58, '92798', 3.40, 4.64, 52, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:08.536879', NULL, 0.00);
INSERT INTO public.clothing VALUES (1610, 'L', 'Levis', 'T-Shirt', 'Unknown', 147, '01980L', 7.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:15.47883', NULL, NULL);
INSERT INTO public.clothing VALUES (1350, 'XS', 'Armani Exchange', 'Sport Jacket', 'Navy', 122, '767774', 27.99, NULL, NULL, NULL, 'Red words on wrists

Chest: 40
Waist: 37
Length: 51
Arm: 65', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:13.058216', NULL, NULL);
INSERT INTO public.clothing VALUES (1351, 'XS', 'Armani Exchange', 'Sweater', 'Red', 122, '287156', 27.99, 58.95, NULL, NULL, 'Large white-outlined letters on chest.

Chest: 54
Waist: 50
Length: 62
Arm: 56', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:13.066476', NULL, NULL);
INSERT INTO public.clothing VALUES (1353, 'XS', 'Armani Exchange', 'Sweat Pants', 'Black', 122, '425278', 20.99, 54.39, NULL, NULL, 'White letters on waistband

Waist: 34
Hips: 42
Length: 93
Pasadka: 26', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:13.084107', NULL, NULL);
INSERT INTO public.clothing VALUES (1357, 'M', 'Armani Exchange', 'Sport Jacket', 'Red', 122, '303795', 27.99, NULL, NULL, NULL, 'AX on boob

Chest: 59
Waist: 56
Length: 74
Arm: 63', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:13.125852', NULL, NULL);
INSERT INTO public.clothing VALUES (1358, 'XS', 'Armani Exchange', 'Sweater', 'Black', 122, '767521', 27.99, 54.39, NULL, NULL, 'White letters at bottom

Chest: 42
Waist: 40
Length: 57
Arm: 62', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:13.139302', NULL, NULL);
INSERT INTO public.clothing VALUES (1359, 'L', 'Armani Exchange', 'Sweat Pants', 'Red', 122, '767682', 20.99, NULL, NULL, NULL, 'Black letters on waistband

Waist: 43
Hips: 54
Length: 100
Pasadka: 31', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:13.14767', NULL, NULL);
INSERT INTO public.clothing VALUES (1360, 'XL', 'Armani Exchange', 'Sweater', 'Red', 122, '425186', 27.99, NULL, NULL, NULL, 'Black letters on bottom

Chest: 57
Waist: 53
Length: 60
Arm: 64', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:13.157074', NULL, NULL);
INSERT INTO public.clothing VALUES (1361, 'L', 'Armani Exchange', 'Sweater', 'Red', 122, '425162', 27.99, NULL, NULL, NULL, 'Black letters on bottom

Chest: 52
Waist: 50
Length: 58
Arm: 62', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:13.165062', NULL, NULL);
INSERT INTO public.clothing VALUES (1362, 'XL', 'Armani Exchange', 'Sweat Pants', 'Red', 122, '767712', 20.99, NULL, NULL, NULL, 'Black letters on waistband

Waist: 47
Hips: 56
Length: 101
Pasadka: 32', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:13.174364', NULL, NULL);
INSERT INTO public.clothing VALUES (1363, 'L', 'Armani Exchange', 'Sweat Pants', 'Red', 122, '306024', 20.99, NULL, NULL, NULL, 'AX on pocket

Waist: 46
Hips: 59
Length: 105
Pasadka: 31', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:13.183362', NULL, NULL);
INSERT INTO public.clothing VALUES (1364, 'M', 'Armani Exchange', 'Sweat Pants', 'Red', 122, '306031', 20.99, NULL, NULL, NULL, 'AX on pocket

Waist: 44
Hips: 56
Length: 101
Pasadka: 27', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:13.19249', NULL, NULL);
INSERT INTO public.clothing VALUES (1365, 'XS', 'Calvin Klein', 'Hoodie Dress', 'White', 56, '890089', 0.00, NULL, NULL, NULL, 'Stripe on arms

Chest: 48
Waist: 46
Length: 84
Arm: 53', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:13.200967', NULL, NULL);
INSERT INTO public.clothing VALUES (1367, '2', 'Tommy Hilfiger', 'Pants', 'White', 56, '687596', 0.00, NULL, NULL, NULL, 'Waist: 40
Hips: 50
Length: 89
Pasadka: 24', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:13.218995', NULL, NULL);
INSERT INTO public.clothing VALUES (1369, 'S', 'Calvin Klein', 'Hoodie', 'Black', 56, '018246', 26.99, NULL, NULL, NULL, 'Zipper
Stripe on arms/back

Chest 54:
Waist: 49
Length: 59
Arm: 55', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:13.236732', NULL, NULL);
INSERT INTO public.clothing VALUES (1370, 'M', 'Calvin Klein', 'Sweater', 'Light Blue', 56, '757947', 0.00, NULL, NULL, NULL, 'Turtle Neck

Chest: 59
Waist: 56
Length: 60
Arm:', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:13.245693', NULL, NULL);
INSERT INTO public.clothing VALUES (2185, 'XXS', 'Tommy Hilfiger', 'Windbreaker', 'Navy, White', 170, '686386', 32.00, NULL, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-01-21 17:17:23.933606', NULL, NULL);
INSERT INTO public.clothing VALUES (2239, 'L', 'Michael Kors', 'Polo Shirt', 'Black', 175, '773686', 19.99, NULL, NULL, NULL, 'stripe on shoulder

chest: 56
length: 71
', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-01-22 10:12:28.21562', NULL, NULL);
INSERT INTO public.clothing VALUES (1371, 'L', 'Tommy Hilfiger', 'Polo Shirt', 'White', 56, '871973', 0.00, NULL, NULL, NULL, 'Chest: 53
Waist: 53
Length: 72', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:13.254478', NULL, NULL);
INSERT INTO public.clothing VALUES (1373, 'M', 'Tommy Hilfiger', 'T-Shirt', 'Red, Blue, White', 56, '582658', 0.00, NULL, NULL, NULL, 'Red + blue stripe on chest

Chest: 53
Waist: 53
Length: 69
', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:13.272406', NULL, NULL);
INSERT INTO public.clothing VALUES (1939, 'XS', 'DKNY', 'Dress', 'White, Black', NULL, '618558', 25.00, NULL, NULL, NULL, 'city picture on it
            
            chest: 46
            length: 90', NULL, 'women', NULL, NULL, NULL, 'Ukraine', '2021-01-03 04:27:48.992791', NULL, 0.00);
INSERT INTO public.clothing VALUES (1374, 'XS', 'Levis', 'Long sleeved shirt', 'Navy', 56, '620886', 12.99, NULL, NULL, NULL, 'Ross tag: 3338

Chest: 42
Waist: 39
Length: 65
Arm: 60', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:13.280713', NULL, NULL);
INSERT INTO public.clothing VALUES (1378, 'XS', 'Calvin Klein', 'Sweat Shirt', 'Yellow', 125, '680085', 12.74, NULL, NULL, NULL, 'Black & white letters

Chest: 48
Waist: 48
Length: 64
Arm: 51', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:13.317611', NULL, NULL);
INSERT INTO public.clothing VALUES (2198, 'L', 'DKNY', 'Coat', 'Black', 172, '264449', 44.99, 110.71, 71, 22, 'chest: 63
length: 93
arm: 68
shoulders: 53', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-01-21 17:29:13.461483', NULL, 0.00);
INSERT INTO public.clothing VALUES (1607, 'S', 'Levis', 'T-Shirt', 'Unknown', 147, '00460S', 7.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:15.452509', NULL, NULL);
INSERT INTO public.clothing VALUES (1383, 'M', 'Calvin Klein', 'Shorts', 'Black', 125, '978700', 8.49, 11.43, NULL, NULL, 'SOLD TO ALLA
White letters on one leg

Waist: 39
Hips: 54
Length: 43
Pasadka: 29', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:13.361772', NULL, NULL);
INSERT INTO public.clothing VALUES (2410, 'M', 'Michael Kors', 'T-Shirt', 'Navy', 193, '029518', 14.99, 20.47, 82, 9, NULL, NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-02-07 22:06:49.219088', NULL, 0.00);
INSERT INTO public.clothing VALUES (1376, 'XS', 'Calvin Klein', 'Sweat Shirt', 'White', 125, '022408', 12.74, NULL, 121, NULL, 'Rainbow on front

Chest: 48
Waist: 46
Length: 50
Arm: 58', NULL, 'women', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:13.299382', NULL, 0.00);
INSERT INTO public.clothing VALUES (1372, 'M', 'Tommy Hilfiger', 'Polo Shirt', 'White', 56, '013411', 16.99, NULL, 114, NULL, 'Chest: 51
Waist: 51
Length: 70', NULL, 'women', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:13.263367', NULL, 0.00);
INSERT INTO public.clothing VALUES (1379, '25', 'Calvin Klein', 'Skirt', 'White', 125, '022880', 12.74, NULL, 121, NULL, 'Rainbow letters on side

Waist: 34
Hips: 44
Length: 39', NULL, 'women', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:13.326992', NULL, 0.00);
INSERT INTO public.clothing VALUES (1356, 'L', 'Armani Exchange', 'Polo Shirt', 'Blue, Red, White', 122, '000161', 13.99, NULL, NULL, NULL, 'Red white chest

Chest: 53
Waist: 53
Length: 72', NULL, 'men', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:13.111109', NULL, 0.00);
INSERT INTO public.clothing VALUES (1355, 'L', 'Armani Exchange', 'Polo Shirt', 'White, Blue, Red', 122, '000161', 13.99, NULL, NULL, NULL, 'Red white chest

Chest: 53
Waist: 53
Length: 72', NULL, 'men', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:13.102316', NULL, 0.00);
INSERT INTO public.clothing VALUES (3164, 'S', 'Calvin Klein', 'Blouse', 'White', 269, '939259', 14.99, NULL, 122, NULL, 'sleeveless', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-20 23:29:15.20061', NULL, 0.00);
INSERT INTO public.clothing VALUES (1386, 'M', 'Calvin Klein', 'Sweat Shirt', 'Lemon', 125, '842711', 12.74, NULL, NULL, NULL, 'Large black square on front

Chest: 53
Waist: 51
Length: 58
Arm: ', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:13.387684', NULL, NULL);
INSERT INTO public.clothing VALUES (1389, '???', 'Calvin Klein', 'Shorts', 'Yellow', 125, '928769', 12.74, 17.16, NULL, NULL, 'SOLD TO ALLA
Built in belt

', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:13.414143', NULL, NULL);
INSERT INTO public.clothing VALUES (1390, 'M', 'Levis', 'Trucker Jacket', 'Navy', 56, '370028', 29.99, NULL, NULL, NULL, 'Marshalls receipt.

Chest: 54
Waist: 50
Length: 60
Arm: 57

', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:13.42333', NULL, NULL);
INSERT INTO public.clothing VALUES (1391, 'S', 'Levis', 'Trucker Jacket', 'Navy', 56, '370028', 29.99, NULL, NULL, NULL, 'Marshalls receipt.

Chest: 50
Waist: 49
Length: 60
Arm: 56

', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:13.431686', NULL, NULL);
INSERT INTO public.clothing VALUES (1940, 'L', 'Ralph Lauren', 'Sleeveless Shirt', 'Blue', NULL, '318124', 10.00, NULL, NULL, NULL, 'chest: 58
length: 67/77', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-03 04:29:18.401647', NULL, 0.00);
INSERT INTO public.clothing VALUES (1392, 'M', 'Levis', 'T-Shirt', 'Black', 56, '690466', 0.00, NULL, NULL, NULL, 'Red logo on chest

Chest: 45
Waist: 46
Length: 62', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:13.441123', NULL, NULL);
INSERT INTO public.clothing VALUES (1393, '???', 'Calvin Klein', 'unknown', 'Unknown', 125, '485260', 12.74, 17.16, NULL, NULL, 'SOLD TO ALLA', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:13.449444', NULL, NULL);
INSERT INTO public.clothing VALUES (1395, '???', 'Calvin Klein', 'unknown', 'Unknown', 126, '012313', 11.48, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:13.466989', NULL, NULL);
INSERT INTO public.clothing VALUES (1400, '???', 'Calvin Klein', 'unknown', 'Unknown', 126, '599608', 13.51, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:13.514446', NULL, NULL);
INSERT INTO public.clothing VALUES (1402, '???', 'Calvin Klein', 'Pants', 'Unknown', 127, '529765', 30.35, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:13.545408', NULL, NULL);
INSERT INTO public.clothing VALUES (1403, '???', 'Calvin Klein', 'Pants', 'Unknown', 127, '529765', 30.35, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:13.556382', NULL, NULL);
INSERT INTO public.clothing VALUES (1396, 'XL', 'Calvin Klein', 'T-Shirt', 'Navy', 126, '710967', 5.95, NULL, NULL, NULL, 'large blue square, white letters in square', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:13.476324', NULL, NULL);
INSERT INTO public.clothing VALUES (340, 'L', 'Calvin Klein', 'Hoodie', 'Black', 30, '254853', 29.99, 40.49, 55, 9, 'grey sign on chest

chest: 58
length: 71
arm: 69', true, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.640534', NULL, 0.00);
INSERT INTO public.clothing VALUES (467, 'L', 'Calvin Klein', 'Gloves', 'Black', 34, '543084', 9.97, 13.43, 54, 9, NULL, true, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.747752', NULL, 0.00);
INSERT INTO public.clothing VALUES (498, 'N/A', 'Calvin Klein', 'Scarf', 'Black', 36, '562757', 8.92, 12.06, 54, 9, NULL, true, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.009276', NULL, 0.00);
INSERT INTO public.clothing VALUES (119, 'XS', 'Tommy Hilfiger', 'Sweat Shirt', 'Navy', 13, '792813', 15.99, NULL, 22, NULL, '"Tommy Hilfiger" in block letters on chest

Chest: 47
Waist: 44
Length: 60
Arm: 58', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.686267', NULL, NULL);
INSERT INTO public.clothing VALUES (2339, 'S', 'Calvin Klein', 'Polo', 'Coral', 187, '840910', 8.00, NULL, NULL, NULL, 'chest: 50
length: 69', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-01-31 15:01:04.830439', NULL, NULL);
INSERT INTO public.clothing VALUES (1232, 'XS', 'Levis', 'unknown', 'Unknown', 108, '0620XS', 27.72, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.951155', NULL, NULL);
INSERT INTO public.clothing VALUES (1233, 'XS', 'Levis', 'Trucker Jacket', 'Unknown', 108, '0030XS', 23.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.959913', NULL, NULL);
INSERT INTO public.clothing VALUES (1234, 'S', 'Levis', 'Hoodie', 'Unknown', 108, '01540S', 19.04, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.969139', NULL, NULL);
INSERT INTO public.clothing VALUES (1235, 'S', 'Levis', 'Trucker Jacket', 'Unknown', 108, '00030S', 23.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.977792', NULL, NULL);
INSERT INTO public.clothing VALUES (1237, 'M', 'Levis', 'unknown', 'Unknown', 108, '00640M', 16.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.996534', NULL, NULL);
INSERT INTO public.clothing VALUES (1202, 'XS', 'Calvin Klein', 'T-Shirt', 'Black', 105, '711292', 12.59, NULL, NULL, NULL, 'white CK, grey letters on front', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.679603', NULL, NULL);
INSERT INTO public.clothing VALUES (1300, 'M', 'Armani Exchange', 'Sport Jacket', 'White', 56, '641988', 28.00, 54.39, NULL, NULL, 'Strip on arms + back

Chest: 53
Waist: 48
Length: 62
Arm: 60', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:12.572489', NULL, NULL);
INSERT INTO public.clothing VALUES (1611, 'L', 'Levis', 'T-Shirt', 'Unknown', 147, '01970L', 7.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:15.487657', NULL, NULL);
INSERT INTO public.clothing VALUES (1405, 'M', 'Calvin Klein', 'Hoodie', 'White', 56, '926740', 0.00, NULL, NULL, NULL, 'Black bar on chest

Chest: 53
Waist: 51
Length: 68
Arm: 66', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:13.580849', NULL, NULL);
INSERT INTO public.clothing VALUES (1406, 'M', 'Calvin Klein', 'Hoodie', 'Black', 56, '926740', 0.00, NULL, NULL, NULL, 'white bar on chest

Chest: 53
Waist: 51
Length: 68
Arm: 66', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:13.591928', NULL, NULL);
INSERT INTO public.clothing VALUES (1407, 'M', 'Levis', 'T-Shirt', 'White', 56, '690468', 0.00, NULL, NULL, NULL, 'Red Logo on chest

Chest: 45
Waist: 45
Length: 63', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:13.610538', NULL, NULL);
INSERT INTO public.clothing VALUES (1408, '???', 'Calvin Klein', 'Shorts', 'Unknown', 128, '927854', 7.06, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:13.619904', NULL, NULL);
INSERT INTO public.clothing VALUES (2241, '31X32', 'Diesel', 'Jeans', 'Navy', 177, '824593', 49.99, NULL, NULL, NULL, 'waist: 41
hips: 51
pasadka: 27
length: 106', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-01-22 10:21:37.066188', NULL, NULL);
INSERT INTO public.clothing VALUES (2340, 'S', 'Tommy Hilfiger', 'Blazer', 'Navy', 187, '430844', 14.00, NULL, NULL, NULL, 'buttons along

chest: 47
length: 58
arm: 60', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-01-31 15:02:19.979385', NULL, NULL);
INSERT INTO public.clothing VALUES (1941, 'S', 'Calvin Klein', 'Dress Shirt', 'White', NULL, '984595', 19.99, NULL, NULL, NULL, 'chest: 50
length: 71/79
arm: 62', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-03 04:30:13.342726', NULL, 0.00);
INSERT INTO public.clothing VALUES (1410, '???', 'Calvin Klein', 'unknown', 'Unknown', 128, '485260', 8.83, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:13.637781', NULL, NULL);
INSERT INTO public.clothing VALUES (1419, '???', 'Calvin Klein', 'unknown', 'Unknown', 129, '926840', 2.01, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:13.71968', NULL, NULL);
INSERT INTO public.clothing VALUES (1420, '???', 'Calvin Klein', 'unknown', 'Unknown', 129, '494095', 2.01, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:13.728923', NULL, NULL);
INSERT INTO public.clothing VALUES (1426, '???', 'Calvin Klein', 'unknown', 'Unknown', 129, '012054', 2.01, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:13.781376', NULL, NULL);
INSERT INTO public.clothing VALUES (1427, '???', 'Levis', 'Jeans', 'Unknown', 130, '903028', 34.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:13.790339', NULL, NULL);
INSERT INTO public.clothing VALUES (1976, 'S', 'Calvin Klein', 'T-Shirt', 'Black', NULL, '375318', 9.99, NULL, NULL, NULL, 'White + Silver letters

Chest: 42
Waist: 42
Length: 60
', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-01-08 10:57:35.126922', NULL, 0.00);
INSERT INTO public.clothing VALUES (1430, 'M', 'Levis', 'T-Shirt', 'White', 130, '00280M', 6.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:13.81646', NULL, NULL);
INSERT INTO public.clothing VALUES (1431, 'L', 'Levis', 'T-Shirt', 'White', 130, '00280L', 6.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:13.826025', NULL, NULL);
INSERT INTO public.clothing VALUES (1432, 'L', 'Levis', 'T-Shirt', 'White', 130, '00280L', 6.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:13.834477', NULL, NULL);
INSERT INTO public.clothing VALUES (1433, 'M', 'Levis', 'T-Shirt', 'White', 130, '00280M', 6.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:13.843759', NULL, NULL);
INSERT INTO public.clothing VALUES (1177, 'XS', 'Calvin Klein', 'Tank Top', 'White', 101, '491599', 10.76, NULL, NULL, NULL, 'knitted

chest: 41
length: 54', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.454139', NULL, NULL);
INSERT INTO public.clothing VALUES (1434, 'XL', 'Levis', 'T-Shirt', 'White', 130, '0280XL', 6.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:13.85202', NULL, NULL);
INSERT INTO public.clothing VALUES (1435, 'L', 'Levis', 'T-Shirt', 'White', 130, '00940L', 6.99, NULL, NULL, NULL, 'Stripes on chest

sent in package 2 in database 2.', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:13.861591', NULL, NULL);
INSERT INTO public.clothing VALUES (1439, 'N/A', 'Tommy Hilfiger', 'Fanny Pack', 'Unknown', 131, '170093', 28.82, 57.89, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:13.897441', NULL, NULL);
INSERT INTO public.clothing VALUES (1441, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 131, '875735', 7.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:13.914822', NULL, NULL);
INSERT INTO public.clothing VALUES (1442, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 131, '947968', 7.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:13.923248', NULL, NULL);
INSERT INTO public.clothing VALUES (1443, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 131, '873083', 7.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:13.932324', NULL, NULL);
INSERT INTO public.clothing VALUES (1444, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 131, '688090', 7.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:13.941409', NULL, NULL);
INSERT INTO public.clothing VALUES (1447, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 131, '690550', 7.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:13.967939', NULL, NULL);
INSERT INTO public.clothing VALUES (1448, 'S', 'Calvin Klein', 'Puffy Jacket', 'Gold', 56, '797692', 0.00, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:13.977454', NULL, NULL);
INSERT INTO public.clothing VALUES (1454, '???', 'Calvin Klein', 'unknown', 'Unknown', 132, '862708', 3.39, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:14.030625', NULL, NULL);
INSERT INTO public.clothing VALUES (3165, 'M', 'Michael Kors', 'T-Shirt', 'Navy', 269, '983993', 16.99, NULL, 109, NULL, 'with buttons', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-20 23:29:45.615603', NULL, 0.00);
INSERT INTO public.clothing VALUES (1399, 'XS', 'Calvin Klein', 'Hoodie', 'Black', 126, '599615', 13.51, NULL, 117, NULL, 'large white & yellow letters

Chest: 56
Waist: 50
Length: 49
Arm: 46', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:13.504922', NULL, NULL);
INSERT INTO public.clothing VALUES (1428, 'M', 'Levis', 'T-Shirt', 'Black', 130, '044776', 6.99, NULL, 119, NULL, 'with bridge', NULL, 'men', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:13.798739', NULL, 0.00);
INSERT INTO public.clothing VALUES (1415, '4', 'Calvin Klein', 'Shorts', 'Black', 128, '927847', 5.65, NULL, NULL, NULL, 'waist: 39
hips: 49
pasadka: 22
length: 31', NULL, 'women', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:13.683355', NULL, 0.00);
INSERT INTO public.clothing VALUES (3478, 'S', 'Armani Exchange', 'Leather Jacket', 'Black', 287, '4136397', 39.99, NULL, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-02 21:21:00.48207', NULL, 0.00);
INSERT INTO public.clothing VALUES (1437, '16', 'Tommy Hilfiger', 'Skirt', 'Blue, Red, White', 131, '224987', 6.67, NULL, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:13.879383', NULL, 0.00);
INSERT INTO public.clothing VALUES (1409, '0', 'Calvin Klein', 'Shorts', 'Green', 128, '928141', 8.83, NULL, 127, NULL, 'linen', NULL, 'women', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:13.629203', NULL, 0.00);
INSERT INTO public.clothing VALUES (1466, 'M', 'Tommy Hilfiger', 'Shorts', 'White', 135, '787083', 15.99, NULL, 107, NULL, 'Tommy at bottom
waist: 42
hips: 55
length: 31', NULL, 'women', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:14.138053', NULL, 0.00);
INSERT INTO public.clothing VALUES (3166, 'L', 'Michael Kors', 'T-Shirt', 'Navy', NULL, '984006', 16.99, NULL, 109, NULL, 'with buttons', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-20 23:30:26.391034', NULL, 0.00);
INSERT INTO public.clothing VALUES (165, 'S', 'Nike', 'Puffy Jacket', 'Red', NULL, '848826', 59.99, NULL, 11, NULL, 'Super long
Not really red, but reddish
pink zipper

Chest: 61
Hips: 61
Length: 112
Arm: 70', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:55.121197', NULL, NULL);
INSERT INTO public.clothing VALUES (1455, '???', 'Armani Exchange', 'unknown', 'Unknown', 133, '968646', 48.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:14.039105', NULL, NULL);
INSERT INTO public.clothing VALUES (1456, '???', 'Armani Exchange', 'Sweat Shirt', 'Unknown', 134, '424738', 27.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:14.048208', NULL, NULL);
INSERT INTO public.clothing VALUES (1457, '???', 'Armani Exchange', 'Pants', 'Unknown', 134, '767705', 20.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:14.056781', NULL, NULL);
INSERT INTO public.clothing VALUES (1458, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 135, '792902', 33.59, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:14.066022', NULL, NULL);
INSERT INTO public.clothing VALUES (1459, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 135, '790861', 38.41, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:14.07529', NULL, NULL);
INSERT INTO public.clothing VALUES (1460, 'XS', 'Tommy Hilfiger', 'Sweat Shirt', 'White', 135, '792742', 33.59, NULL, NULL, NULL, '"Tommy Hilfiger" in block letters on chest

Chest: 47
Waist: 44
Length: 60
Arm: 58', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:14.083939', NULL, NULL);
INSERT INTO public.clothing VALUES (1461, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 135, '790700', 38.39, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:14.093529', NULL, NULL);
INSERT INTO public.clothing VALUES (1467, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 135, '790700', 38.39, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:14.147579', NULL, NULL);
INSERT INTO public.clothing VALUES (1594, 'M', 'Levis', 'T-Shirt', 'Unknown', 145, '00300M', 6.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:15.328135', NULL, NULL);
INSERT INTO public.clothing VALUES (1417, '32X32', 'Calvin Klein', 'Jeans', 'Blue', 129, '012153', 2.01, NULL, NULL, NULL, 'model ckj026
moden classics slim

color is similar to american classics

waist: 45
hips: 51
pasadka: 27
length: 102', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:13.701468', NULL, NULL);
INSERT INTO public.clothing VALUES (2130, 'S', 'Tommy Hilfiger', 'Dress', 'Navy', 164, '440288', 27.99, 38.22, 64, 9, 'Tommy jeans

chest: 50
length: 87
arm: 70
', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-16 18:56:16.295372', NULL, 0.00);
INSERT INTO public.clothing VALUES (1990, 'S', 'Tommy Hilfiger', 'Blazer', 'Black', 153, '466412', 20.00, 27.19, 56, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 11:38:55.787723', NULL, 0.00);
INSERT INTO public.clothing VALUES (2024, 'S', 'Calvin Klein', 'Flying Blouse', 'White', 155, '483204', 7.99, 10.80, 56, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 12:19:42.670624', NULL, 0.00);
INSERT INTO public.clothing VALUES (2686, '8.5', 'DKNY', 'Shoes', 'Navy', NULL, '398780', 29.00, 39.15, 91, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-27 21:50:29.689448', NULL, 0.00);
INSERT INTO public.clothing VALUES (2002, 'S', 'Calvin Klein', 'Sweat Shirt', 'Black', 154, '888962', 14.05, 18.92, 56, 9, 'rhinestones', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 11:57:00.550972', NULL, 0.00);
INSERT INTO public.clothing VALUES (2067, 'S', 'Tommy Hilfiger', 'Sweater', 'White', 158, '999813', 12.00, 16.16, 61, 9, 'Gold dots in a diamond pattern everywhere.

Chest: 44
Waist: 40
Length: 61
Arm: 60', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-13 11:23:49.657406', NULL, 4.93);
INSERT INTO public.clothing VALUES (1436, 'L', 'Tommy Hilfiger', 'Polo Shirt', 'White', 131, '113004', 7.99, NULL, 106, NULL, 'chest: 57
length: 72
shoulders: 50', NULL, 'men', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:13.870104', NULL, 0.00);
INSERT INTO public.clothing VALUES (1176, 'XS', 'Calvin Klein', 'T-Shirt', 'Pink', 101, '860548', 5.43, NULL, NULL, NULL, 'Black CK, silver letters on front', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.444748', NULL, NULL);
INSERT INTO public.clothing VALUES (1468, 'XS', 'Tommy Hilfiger', 'Sweat Shirt', 'White', 135, '792742', 33.59, NULL, NULL, NULL, '"Tommy Hilfiger" in block letters on chest

Chest: 47
Waist: 44
Length: 60
Arm: 58', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:14.156023', NULL, NULL);
INSERT INTO public.clothing VALUES (1515, 'N/A', 'Tommy Hilfiger', 'Unknown', 'Unknown', 138, '128138', 7.49, NULL, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:14.59742', NULL, 0.00);
INSERT INTO public.clothing VALUES (1495, '???', 'Tommy Hilfiger', 'Unknown', 'Unknown', 137, '574065', 9.59, NULL, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:14.407217', NULL, 0.00);
INSERT INTO public.clothing VALUES (2242, 'M', 'Michael Kors', 'Puffy Jacket', 'Black', 177, '111733', 59.99, NULL, NULL, NULL, 'red inside

chest: 56
length: 73
arm: 60
shoulders 54', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-01-22 10:23:38.775709', NULL, NULL);
INSERT INTO public.clothing VALUES (1942, 'L', 'Reebok', 'Windbreaker', 'Black', NULL, '434375', 20.00, NULL, NULL, NULL, 'white stripe across chest

chest: 60
length: 73
arm: 70', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-01-03 04:34:45.895469', NULL, 0.00);
INSERT INTO public.clothing VALUES (1492, '???', 'Tommy Hilfiger', 'Unknown', 'Unknown', 137, '666418', 11.19, NULL, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:14.380277', NULL, 0.00);
INSERT INTO public.clothing VALUES (1486, '???', 'Tommy Hilfiger', 'Unknown', 'Unknown', 137, '680957', 10.39, NULL, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:14.327422', NULL, 0.00);
INSERT INTO public.clothing VALUES (1493, '???', 'Tommy Hilfiger', 'Unknown', 'Unknown', 137, '681015', 10.39, NULL, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:14.388754', NULL, 0.00);
INSERT INTO public.clothing VALUES (1485, '???', 'Tommy Hilfiger', 'Unknown', 'Unknown', 137, '690598', 11.19, NULL, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:14.318121', NULL, 0.00);
INSERT INTO public.clothing VALUES (1491, '???', 'Tommy Hilfiger', 'Unknown', 'Unknown', 137, '692080', 11.19, NULL, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:14.371135', NULL, 0.00);
INSERT INTO public.clothing VALUES (1508, 'N/A', 'Tommy Hilfiger', 'Unknown', 'Unknown', 138, '717677', 7.49, NULL, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:14.528843', NULL, 0.00);
INSERT INTO public.clothing VALUES (1509, 'N/A', 'Tommy Hilfiger', 'Unknown', 'Unknown', 138, '717684', 7.49, NULL, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:14.541818', NULL, 0.00);
INSERT INTO public.clothing VALUES (1517, 'N/A', 'Tommy Hilfiger', 'Unknown', 'Unknown', 138, '717745', 7.49, NULL, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:14.61523', NULL, 0.00);
INSERT INTO public.clothing VALUES (1469, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 135, '812075', 35.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:14.165189', NULL, NULL);
INSERT INTO public.clothing VALUES (1473, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 136, '838983', 7.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:14.210514', NULL, NULL);
INSERT INTO public.clothing VALUES (1475, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 136, '332811', 7.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:14.228208', NULL, NULL);
INSERT INTO public.clothing VALUES (1478, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 136, '332712', 7.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:14.254413', NULL, NULL);
INSERT INTO public.clothing VALUES (965, 'XS', 'Tommy Hilfiger', 'Windbreaker', 'Blue, Red, White', 61, '684252', 20.99, NULL, NULL, NULL, 'Blue + Red stripes

Chest: 47
Waist: 38
Length: 65
Arm: 59', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:09.453867', NULL, 0.00);
INSERT INTO public.clothing VALUES (1564, '???', 'Calvin Klein', 'Hoodie', 'Unknown', 141, '854615', 13.52, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:15.045672', NULL, NULL);
INSERT INTO public.clothing VALUES (1484, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 137, '690598', 11.19, 38.60, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:14.309768', NULL, NULL);
INSERT INTO public.clothing VALUES (1487, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 137, '947876', 9.59, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:14.335569', NULL, NULL);
INSERT INTO public.clothing VALUES (1488, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 137, '947951', 9.59, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:14.345102', NULL, NULL);
INSERT INTO public.clothing VALUES (1494, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 137, '947937', 9.59, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:14.398136', NULL, NULL);
INSERT INTO public.clothing VALUES (2326, 'M', 'Calvin Klein', 'Belt', 'Black', 185, '192357', 6.12, NULL, NULL, NULL, 'double sided black/brown
length: 105', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-01-31 14:46:46.901537', NULL, NULL);
INSERT INTO public.clothing VALUES (2342, 'M', 'Calvin Klein', 'Sweat Pants', 'Black', 187, '750078', 19.99, NULL, NULL, NULL, 'calvin klein on side

waist: 40
hips: 51
pasadka: 26
length: 95', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-01-31 15:04:30.828206', NULL, NULL);
INSERT INTO public.clothing VALUES (1482, '???', 'Tommy Hilfiger', 'Unknown', 'Unknown', 137, '776643', 14.39, NULL, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:14.291666', NULL, 0.00);
INSERT INTO public.clothing VALUES (1498, 'N/A', 'Tommy Hilfiger', 'Fanny Pack', 'Red', 138, '468951', 11.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:14.433981', NULL, NULL);
INSERT INTO public.clothing VALUES (1501, 'N/A', 'Tommy Hilfiger', 'unknown', 'Unknown', 138, '411179', 7.49, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:14.461098', NULL, NULL);
INSERT INTO public.clothing VALUES (1502, 'N/A', 'Tommy Hilfiger', 'unknown', 'Unknown', 138, '947883', 7.49, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:14.469184', NULL, NULL);
INSERT INTO public.clothing VALUES (1505, 'N/A', 'Tommy Hilfiger', 'unknown', 'Unknown', 138, '717745', 7.49, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:14.496174', NULL, NULL);
INSERT INTO public.clothing VALUES (1510, 'N/A', 'Tommy Hilfiger', 'unknown', 'Unknown', 138, '947951', 7.49, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:14.550713', NULL, NULL);
INSERT INTO public.clothing VALUES (1513, 'N/A', 'Tommy Hilfiger', 'unknown', 'Unknown', 138, '947944', 7.49, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:14.577563', NULL, NULL);
INSERT INTO public.clothing VALUES (1514, 'N/A', 'Tommy Hilfiger', 'unknown', 'Unknown', 138, '717653', 7.49, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:14.588034', NULL, NULL);
INSERT INTO public.clothing VALUES (1471, 'M', 'Tommy Hilfiger', 'Dress Shirt', 'Black', 136, '008927', 7.99, NULL, 114, NULL, 'Chest: 53
length: 76
shoulders: 45
arm: 66', NULL, 'women', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:14.192404', NULL, 0.00);
INSERT INTO public.clothing VALUES (1470, 'M', 'Tommy Hilfiger', 'Dress Shirt', 'White', 136, '396407', 8.01, NULL, 114, NULL, 'chest: 56
length: 77
shoulders: 47
arm: 66', NULL, 'men', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:14.179496', NULL, 0.00);
INSERT INTO public.clothing VALUES (1496, 'S', 'Tommy Hilfiger', 'Polo Shirt', 'Blue', 137, '716939', 7.19, NULL, NULL, NULL, 'V-Neck
chest: 44
length: 64', NULL, 'women', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:14.416317', NULL, 0.00);
INSERT INTO public.clothing VALUES (1480, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 136, '332736', 7.99, NULL, 119, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:14.272087', NULL, NULL);
INSERT INTO public.clothing VALUES (1477, '4', 'Tommy Hilfiger', 'Pants', 'White', 136, '332842', 7.99, NULL, 119, NULL, 'linen pants', NULL, 'women', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:14.245856', NULL, 0.00);
INSERT INTO public.clothing VALUES (3479, 'M', 'Armani Exchange', 'Leather Jacket', 'Black', 287, '4136380', 39.99, NULL, 125, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-02 21:21:46.284842', NULL, NULL);
INSERT INTO public.clothing VALUES (3167, '8', 'Michael Kors', 'Jeans', 'Navy', 269, '442869', 24.99, NULL, 116, NULL, 'selma straight
with two buttons

waist: 39
hips: 49
pasadka: 27
length: 101', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-20 23:31:43.810334', NULL, 0.00);
INSERT INTO public.clothing VALUES (1519, 'N/A', 'Tommy Hilfiger', 'unknown', 'Unknown', 138, '948026', 7.49, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:14.633036', NULL, NULL);
INSERT INTO public.clothing VALUES (1595, 'M', 'Levis', 'T-Shirt', 'Unknown', 145, '00300M', 6.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:15.336584', NULL, NULL);
INSERT INTO public.clothing VALUES (1532, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 139, '776643', 14.39, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:14.75894', NULL, NULL);
INSERT INTO public.clothing VALUES (1533, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 139, '776650', 14.39, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:14.76795', NULL, NULL);
INSERT INTO public.clothing VALUES (1534, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 139, '690598', 11.19, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:14.776799', NULL, NULL);
INSERT INTO public.clothing VALUES (1535, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 139, '690598', 11.19, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:14.785302', NULL, NULL);
INSERT INTO public.clothing VALUES (1536, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 139, '680957', 10.39, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:14.79416', NULL, NULL);
INSERT INTO public.clothing VALUES (1483, '???', 'Tommy Hilfiger', 'Unknown', 'Unknown', 137, '776650', 14.39, NULL, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:14.300487', NULL, 0.00);
INSERT INTO public.clothing VALUES (1490, 'M', 'Tommy Hilfiger', 'Hoodie', 'Navy', 137, '826140', 19.19, NULL, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:14.362616', NULL, 0.00);
INSERT INTO public.clothing VALUES (2136, 'L', 'Michael Kors', 'Parka', 'Black', 166, '022228', 49.99, NULL, 71, NULL, 'chest: 65
length: 89
arm: 65', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-01-16 19:03:56.116596', NULL, 0.00);
INSERT INTO public.clothing VALUES (2377, 'L', 'Levis', 'T-Shirt', 'White', NULL, '611186', 9.00, NULL, 74, NULL, 'red sign + san francisco sign', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-31 18:34:26.339777', NULL, NULL);
INSERT INTO public.clothing VALUES (1518, 'N/A', 'Tommy Hilfiger', 'Unknown', 'Unknown', 138, '947876', 7.49, NULL, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:14.623979', NULL, 0.00);
INSERT INTO public.clothing VALUES (1503, 'N/A', 'Tommy Hilfiger', 'Unknown', 'Unknown', 138, '947890', 7.49, NULL, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:14.478479', NULL, 0.00);
INSERT INTO public.clothing VALUES (1511, 'N/A', 'Tommy Hilfiger', 'Unknown', 'Unknown', 138, '947968', 7.49, NULL, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:14.559927', NULL, 0.00);
INSERT INTO public.clothing VALUES (1512, 'N/A', 'Tommy Hilfiger', 'Unknown', 'Unknown', 138, '947975', 7.49, NULL, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:14.568443', NULL, 0.00);
INSERT INTO public.clothing VALUES (1507, 'N/A', 'Tommy Hilfiger', 'Unknown', 'Unknown', 138, '948026', 7.49, NULL, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:14.51421', NULL, 0.00);
INSERT INTO public.clothing VALUES (1539, 'M', 'Tommy Hilfiger', 'Hoodie', 'Navy', 139, '826140', 19.22, NULL, NULL, NULL, 'Zipper on top half with red/white outline

Chest: 60
Waist: 57
Length: 68
Arm: 62', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:14.820563', NULL, NULL);
INSERT INTO public.clothing VALUES (1541, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 139, '692090', 11.19, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:14.838244', NULL, NULL);
INSERT INTO public.clothing VALUES (1542, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 139, '666418', 11.19, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:14.847384', NULL, NULL);
INSERT INTO public.clothing VALUES (1977, 'S', 'Calvin Klein', 'T-Shirt', 'Pink', 152, '525188', 14.99, NULL, 106, NULL, 'white / silver logo on chest
chest: 44
length: 63', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-01-08 11:00:53.898022', NULL, 0.00);
INSERT INTO public.clothing VALUES (1219, 'S', 'Calvin Klein', 'T-Shirt', 'White', 106, '866343', 11.04, NULL, NULL, NULL, 'blue city picture on chest', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:11.833946', NULL, NULL);
INSERT INTO public.clothing VALUES (1543, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 139, '681015', 10.39, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:14.855841', NULL, NULL);
INSERT INTO public.clothing VALUES (1544, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 139, '947937', 9.59, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:14.865047', NULL, NULL);
INSERT INTO public.clothing VALUES (1545, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 139, '574065', 9.59, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:14.873619', NULL, NULL);
INSERT INTO public.clothing VALUES (1547, 'XS', 'Tommy Hilfiger', 'Sweat Pants', 'Navy', 140, '790779', 31.99, NULL, NULL, NULL, 'Block letters on leg

Waist: 35
Hips: 47
Length: 96
Pasadka: 24', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:14.891254', NULL, NULL);
INSERT INTO public.clothing VALUES (1548, 'XS', 'Tommy Hilfiger', 'Sweat Shirt', 'Navy', 140, '792810', 27.99, NULL, NULL, NULL, 'Chest: 45
Waist: 45
Length: 57
Arm: 56', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:14.900164', NULL, NULL);
INSERT INTO public.clothing VALUES (1549, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 140, '790793', 31.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:14.909021', NULL, NULL);
INSERT INTO public.clothing VALUES (1550, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 140, '792834', 27.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:14.917853', NULL, NULL);
INSERT INTO public.clothing VALUES (1551, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 140, '792896', 27.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:14.927982', NULL, NULL);
INSERT INTO public.clothing VALUES (1943, 'XS', 'Calvin Klein', 'Sweat Shirt', 'Grey', NULL, '883141', 20.00, NULL, NULL, NULL, 'gold CK on chest

chest: 49
length: 59
arm: 74', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-03 04:38:55.835787', NULL, 0.00);
INSERT INTO public.clothing VALUES (2343, 'M', 'Calvin Klein', 'Hoodie', 'Black', 187, '254846', 29.99, NULL, NULL, NULL, 'grey logo on chest

chest: 56
length: 70
arm: 67', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-01-31 15:05:01.96796', NULL, 0.00);
INSERT INTO public.clothing VALUES (1552, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 140, '792896', 27.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:14.936753', NULL, NULL);
INSERT INTO public.clothing VALUES (1979, 'XS', 'Tommy Hilfiger', 'Hoodie', 'White', 152, '295425', 19.99, NULL, NULL, NULL, 'Hilfiger sign on chest
made pictures downtown davis

chest: 49
length: 57
arm: 53/70', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-01-08 11:03:03.448515', NULL, 0.00);
INSERT INTO public.clothing VALUES (1553, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 140, '098403', 48.00, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:14.946016', NULL, NULL);
INSERT INTO public.clothing VALUES (1554, '???', 'Calvin Klein', 'unknown', 'Unknown', 141, '842711', 11.82, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:14.955702', NULL, NULL);
INSERT INTO public.clothing VALUES (1555, '???', 'Calvin Klein', 'Puffy Jacket', 'Gold', 141, '797692', 6.72, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:14.965793', NULL, NULL);
INSERT INTO public.clothing VALUES (1557, '???', 'Calvin Klein', 'unknown', 'Unknown', 141, '599271', 6.72, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:14.983372', NULL, NULL);
INSERT INTO public.clothing VALUES (1558, '???', 'Calvin Klein', 'Sweater', 'Unknown', 141, '499199', 10.12, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:14.991765', NULL, NULL);
INSERT INTO public.clothing VALUES (1559, '???', 'Calvin Klein', 'Sweater', 'Unknown', 141, '499182', 10.12, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:15.000843', NULL, NULL);
INSERT INTO public.clothing VALUES (1560, '???', 'Calvin Klein', 'unknown', 'Unknown', 141, '738526', 8.42, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:15.009337', NULL, NULL);
INSERT INTO public.clothing VALUES (1561, '???', 'Calvin Klein', 'Sweater', 'Unknown', 141, '499298', 10.12, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:15.01836', NULL, NULL);
INSERT INTO public.clothing VALUES (1562, '???', 'Calvin Klein', 'Sweater', 'Unknown', 141, '499182', 10.12, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:15.02748', NULL, NULL);
INSERT INTO public.clothing VALUES (1563, 'XS', 'Calvin Klein', 'Hoodie Dress', 'White', 141, '890089', 15.22, NULL, NULL, NULL, 'Stripe on arms

Chest: 48
Waist: 46
Length: 84
Arm: 53', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:15.036343', NULL, NULL);
INSERT INTO public.clothing VALUES (1565, '???', 'Calvin Klein', 'unknown', 'Unknown', 141, '640829', 28.56, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:15.054233', NULL, NULL);
INSERT INTO public.clothing VALUES (1566, '???', 'Calvin Klein', 'unknown', 'Unknown', 141, '640829', 28.56, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:15.063608', NULL, NULL);
INSERT INTO public.clothing VALUES (1567, '???', 'Calvin Klein', 'unknown', 'Unknown', 141, '528144', 10.07, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:15.072038', NULL, NULL);
INSERT INTO public.clothing VALUES (1568, '???', 'Calvin Klein', 'unknown', 'Unknown', 142, '991182', 7.41, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:15.081462', NULL, NULL);
INSERT INTO public.clothing VALUES (1578, 'M', 'Calvin Klein', 'Long sleeved shirt', 'Navy', 143, '802243', 10.19, NULL, NULL, NULL, 'Chest: 53
Waist: 51
Length: 72
Arm: 67', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:15.171452', NULL, NULL);
INSERT INTO public.clothing VALUES (1944, 'M', 'Calvin Klein', 'Vest Jacket', 'Green', NULL, '136093', 30.00, NULL, NULL, NULL, 'Bright green / flouresent yellow

chest: 53
length: 65', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-03 04:40:37.849474', NULL, 0.00);
INSERT INTO public.clothing VALUES (1980, 'M', 'Tommy Hilfiger', 'Puffy Jacket', 'Black', 152, '997901', 49.99, NULL, NULL, NULL, 'short
white squares
chest: 53
length: 58
arm: 64', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-01-08 11:05:28.106149', NULL, NULL);
INSERT INTO public.clothing VALUES (1579, '???', 'Calvin Klein', 'unknown', 'Unknown', 143, '199135', 10.19, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:15.180732', NULL, NULL);
INSERT INTO public.clothing VALUES (2344, '36', 'Calvin Klein', 'Belt', 'Black', 187, '004062', 9.99, NULL, NULL, NULL, 'double sided

length: 108', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-01-31 15:06:24.799105', NULL, NULL);
INSERT INTO public.clothing VALUES (1574, 'XS', 'Calvin Klein', 'Hoodie', 'Pink', 142, '351480', 9.69, NULL, 121, NULL, 'chest: 54
length: 49', NULL, 'women', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:15.135995', NULL, 0.00);
INSERT INTO public.clothing VALUES (1570, 'S', 'Calvin Klein', 'Bikini', 'Black', 142, '661147', 9.69, NULL, 121, NULL, 'covered in letters', NULL, 'women', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:15.100115', NULL, 0.00);
INSERT INTO public.clothing VALUES (1569, 'M', 'Calvin Klein', 'Swimming Bra', 'Black', 142, '661352', 9.73, NULL, 121, NULL, 'letters everywhere', NULL, 'women', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:15.090815', NULL, 0.00);
INSERT INTO public.clothing VALUES (1571, 'S', 'Calvin Klein', 'Shorts', 'Pink', 142, '350209', 9.69, NULL, 121, NULL, 'waist: 38
hips: 50
length: 50
pasadka: 24', NULL, 'women', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:15.108883', NULL, 0.00);
INSERT INTO public.clothing VALUES (1575, 'XS', 'Calvin Klein', 'Hoodie', 'Pink', 142, '351480', 9.69, NULL, 121, NULL, 'chest: 54
length: 49', NULL, 'women', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:15.144918', NULL, 0.00);
INSERT INTO public.clothing VALUES (2271, 'L', 'DKNY', 'Puffy Jacket', 'Green', 180, '223054', 69.99, 0.00, 68, 9, NULL, NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-01-23 20:45:29.189483', NULL, 0.00);
INSERT INTO public.clothing VALUES (2273, 'XS', 'DKNY', 'Puffy Jacket', 'Grey', 180, '251821', 59.99, 0.00, 68, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-23 20:48:25.728181', NULL, 0.00);
INSERT INTO public.clothing VALUES (1580, '???', 'Levis', 'unknown', 'Unknown', 144, '002532', 23.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:15.189144', NULL, NULL);
INSERT INTO public.clothing VALUES (1581, '???', 'Levis', 'Shorts', 'Unknown', 145, '038029', 14.99, NULL, NULL, NULL, 'waist: 29', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:15.198613', NULL, NULL);
INSERT INTO public.clothing VALUES (1583, '???', 'Levis', 'Shorts', 'Unknown', 145, '003025', 14.99, NULL, NULL, NULL, 'waist: 25', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:15.21621', NULL, NULL);
INSERT INTO public.clothing VALUES (1586, '???', 'Levis', 'Shorts', 'Unknown', 145, '023027', 14.99, NULL, NULL, NULL, 'waist: 27', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:15.256381', NULL, NULL);
INSERT INTO public.clothing VALUES (2046, 'L', 'Armani Exchange', 'Sweater', 'Navy', 156, '349505', 9.99, 13.61, 64, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 13:31:48.002821', NULL, 0.00);
INSERT INTO public.clothing VALUES (1587, '???', 'Levis', 'Shorts', 'Unknown', 145, '038027', 14.99, NULL, NULL, NULL, 'waist: 27', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:15.26588', NULL, NULL);
INSERT INTO public.clothing VALUES (1588, 'S', 'Levis', 'T-Shirt', 'Unknown', 145, '00310S', 6.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:15.274645', NULL, NULL);
INSERT INTO public.clothing VALUES (1589, 'M', 'Levis', 'T-Shirt', 'Unknown', 145, '00310M', 6.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:15.283937', NULL, NULL);
INSERT INTO public.clothing VALUES (1590, 'L', 'Levis', 'T-Shirt', 'Unknown', 145, '00310L', 6.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:15.292541', NULL, NULL);
INSERT INTO public.clothing VALUES (1591, 'L', 'Levis', 'T-Shirt', 'Unknown', 145, '00300L', 6.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:15.30169', NULL, NULL);
INSERT INTO public.clothing VALUES (1592, 'L', 'Levis', 'T-Shirt', 'Unknown', 145, '00300L', 6.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:15.310086', NULL, NULL);
INSERT INTO public.clothing VALUES (1596, 'L', 'Levis', 'T-Shirt', 'Unknown', 145, '00300L', 6.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:15.345451', NULL, NULL);
INSERT INTO public.clothing VALUES (1598, '???', 'Levis', 'Shorts', 'Unknown', 145, '193025', 14.99, NULL, NULL, NULL, 'waist: 25', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:15.368378', NULL, NULL);
INSERT INTO public.clothing VALUES (1599, '???', 'Levis', 'Jeans', 'Unknown', 145, '502732', 12.49, NULL, NULL, NULL, 'waist: 27
length: 32', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:15.381831', NULL, NULL);
INSERT INTO public.clothing VALUES (1600, '???', 'Levis', 'Jeans', 'Unknown', 145, '503030', 12.49, NULL, NULL, NULL, 'waist: 30
length: 30', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:15.390233', NULL, NULL);
INSERT INTO public.clothing VALUES (1601, '???', 'Levis', 'Jeans', 'Unknown', 145, '502732', 12.49, NULL, NULL, NULL, 'waist: 27
length: 32', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:15.399522', NULL, NULL);
INSERT INTO public.clothing VALUES (2035, 'M', 'Armani Exchange', 'Jean Jacket', 'Blue', 156, '426181', 42.99, 58.57, 64, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 13:23:29.379442', NULL, 0.00);
INSERT INTO public.clothing VALUES (2057, '4', 'Michael Kors', 'Jeans', 'Navy', 157, '834801', 20.00, 27.06, 64, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-13 11:11:01.553633', NULL, 0.00);
INSERT INTO public.clothing VALUES (1243, 'XS', 'Levis', 'Trucker Jacket', 'Unknown', 109, '0490XS', 19.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:12.061506', NULL, NULL);
INSERT INTO public.clothing VALUES (1244, 'XS', 'Levis', 'Trucker Jacket', 'Unknown', 109, '0490XS', 19.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:12.071329', NULL, NULL);
INSERT INTO public.clothing VALUES (1245, '26', 'Levis', 'Shorts', 'Unknown', 110, '107026', 27.72, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:12.080243', NULL, NULL);
INSERT INTO public.clothing VALUES (1246, '32', 'Levis', 'Jeans', 'Unknown', 111, '810293', 19.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:12.09039', NULL, NULL);
INSERT INTO public.clothing VALUES (1247, '30', 'Levis', 'Jeans', 'Unknown', 111, '810356', 14.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:12.099551', NULL, NULL);
INSERT INTO public.clothing VALUES (1946, 'M', 'Calvin Klein', 'Windbreaker', 'White, Black', NULL, '479532', 25.00, NULL, NULL, NULL, 'white top black bottom
chest: 58
length: 67/72
arm: 67', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-01-03 05:02:46.367872', NULL, 0.00);
INSERT INTO public.clothing VALUES (441, 'M', 'DKNY', 'Hoodie', 'Black', NULL, '192902', 14.99, 20.24, 12, 9, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.518978', NULL, NULL);
INSERT INTO public.clothing VALUES (2141, 'S', 'Calvin Klein', 'Fluffy Jacket', 'Black', NULL, '313990', 26.00, NULL, NULL, NULL, 'chest: 54
length: 69
arm: 67', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-01-16 19:11:59.00139', NULL, NULL);
INSERT INTO public.clothing VALUES (2288, 'N/A', 'Calvin Klein', 'Wallet', 'Black', 182, '297731', 9.99, NULL, NULL, NULL, 'length: 11
height: 8.5', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-01-23 21:36:27.590441', NULL, NULL);
INSERT INTO public.clothing VALUES (1248, 'S', 'Levis', 'T-Shirt', 'Black', 111, '690466', 8.00, NULL, NULL, NULL, 'Red logo on chest', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:12.10914', NULL, NULL);
INSERT INTO public.clothing VALUES (1249, '28', 'Levis', 'Shorts', 'Unknown', 111, '780029', 31.15, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:12.117714', NULL, NULL);
INSERT INTO public.clothing VALUES (1411, 'L', 'Calvin Klein', 'Long sleeved shirt', 'White', 128, '794951', 8.83, 12.06, NULL, 10, 'SOLD TO ALLA', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:13.64799', NULL, NULL);
INSERT INTO public.clothing VALUES (262, 'S', 'Michael Kors', 'Hoodie', 'Black', NULL, '223923', 29.99, 59.44, 29, 3, 'white Michael Kors on chest
White line at bottom

sold for 1700

Chest: 52
Waist: 49
Length: 70
Arm: 68', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:55.941637', NULL, NULL);
INSERT INTO public.clothing VALUES (1720, 'S', 'Tommy Hilfiger', 'Sweat Shirt', 'White', 56, '??????', 8.00, NULL, NULL, NULL, 'Oversize
Grey letters', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:16.489555', NULL, NULL);
INSERT INTO public.clothing VALUES (1250, '28', 'Levis', 'Shorts', 'Unknown', 111, '270113', 34.65, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:12.126644', NULL, NULL);
INSERT INTO public.clothing VALUES (1251, '27', 'Levis', 'Pants', 'Unknown', 111, '020106', 34.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:12.135738', NULL, NULL);
INSERT INTO public.clothing VALUES (1257, '27', 'Levis', 'Shorts', 'Unknown', 112, '270107', 34.65, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:12.189234', NULL, NULL);
INSERT INTO public.clothing VALUES (1258, 'S', 'Levis', 'Bodysuit', 'Unknown', 112, '870009', 3.49, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:12.197872', NULL, NULL);
INSERT INTO public.clothing VALUES (2233, 'M', 'Michael Kors', 'Sweater', 'White', 175, '067858', 16.00, 0.00, 67, 9, 'turtle neck
', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-21 18:03:39.442887', NULL, 0.00);
INSERT INTO public.clothing VALUES (2036, '40', 'Armani Exchange', 'Blazer', 'Navy', 156, '347690', 34.99, 47.67, 64, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 13:24:04.028552', NULL, 0.00);
INSERT INTO public.clothing VALUES (2193, 'L', 'Armani Exchange', 'Polo Shirt', 'Grey', 171, '139657', 19.99, 0.00, 67, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-21 17:24:35.245565', NULL, 0.00);
INSERT INTO public.clothing VALUES (2224, 'M', 'Michael Kors', 'Belt', 'Brown', NULL, '275999', 16.99, 0.00, 67, 9, 'reversible', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-21 17:57:09.88097', NULL, 0.00);
INSERT INTO public.clothing VALUES (2222, 'M', 'Tommy Hilfiger', 'Hoodie', 'Red, White, Navy', NULL, '311545', 20.00, 0.00, 67, 9, 'zipped', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-21 17:55:48.79058', NULL, 0.00);
INSERT INTO public.clothing VALUES (2259, 'XS', 'Calvin Klein', 'Flying Blouse', 'Black', 178, '483167', 5.61, NULL, 107, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-01-22 12:52:53.359548', NULL, 0.00);
INSERT INTO public.clothing VALUES (2160, 'L', 'Calvin Klein', 'Puffy Jacket', 'Black', NULL, '309733', 56.00, 110.71, 63, 22, 'Shiny
Red line around hood + bottom + wrists

Chest: 63
Waist: 59
Length: 70
Arm: 65', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-18 15:45:07.633624', NULL, 0.00);
INSERT INTO public.clothing VALUES (1870, 'XS', 'Calvin Klein', 'Sweat Pants', 'Black', NULL, '082933', 20.82, 50.00, NULL, 22, 'delivery $2

White outlined black stripe with "cavin klein ck" down leg

Waist: 36
Hips: 47
Length: 90
Pasadka: 23', true, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-28 14:14:54.900055', NULL, 2.00);
INSERT INTO public.clothing VALUES (3407, '6', 'Calvin Klein', 'Flip Flops', 'Black', 284, '670755901499', 14.99, NULL, 117, NULL, 'пена, ленты накрест размер 6 стелька 23 см', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-29 04:26:38.833522', NULL, NULL);
INSERT INTO public.clothing VALUES (2370, 'XS', 'Calvin Klein', 'Puffy Jacket', 'White', NULL, '056377', 46.00, 110.71, NULL, 22, 'rainbow spacesuit

chest: 57
length: 80
arm: 60', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-01-31 15:33:17.791989', NULL, 5.00);
INSERT INTO public.clothing VALUES (1597, '26', 'Levis', 'Shorts', 'Blue', 145, '714424', 14.99, NULL, 119, NULL, 'waist: 26', NULL, 'women', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:15.354094', NULL, 0.00);
INSERT INTO public.clothing VALUES (1584, '28', 'Levis', 'Shorts', 'Blue', 145, '714431', 14.99, NULL, 119, NULL, 'waist: 28', NULL, 'women', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:15.224969', NULL, 0.00);
INSERT INTO public.clothing VALUES (1582, '27', 'Levis', 'Shorts', 'Blue', 145, '556742', 14.99, NULL, 119, NULL, 'waist: 27', NULL, 'women', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:15.20715', NULL, 0.00);
INSERT INTO public.clothing VALUES (1585, '30', 'Levis', 'Shorts', 'Navy', 145, '261547', 14.99, NULL, 119, NULL, 'waist: 30', NULL, 'women', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:15.241398', NULL, 0.00);
INSERT INTO public.clothing VALUES (3480, 'M', 'Armani Exchange', 'Leather Jacket', 'Black', 287, '4136380', 39.99, NULL, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-02 21:22:13.325801', NULL, 0.00);
INSERT INTO public.clothing VALUES (3168, '6', 'DKNY', 'Dress', 'Pink', 269, '646955', 29.99, NULL, 121, NULL, 'chest: 44/53
length: 98', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-20 23:33:02.768935', NULL, NULL);
INSERT INTO public.clothing VALUES (3565, 'XS', 'Karl Lagerfeld', 'Dress Shirt', 'White', 290, 'LORA6577', 22.99, NULL, 122, NULL, 'с карлом и котами', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-03 03:09:04.747048', NULL, 0.00);
INSERT INTO public.clothing VALUES (2500, 'N/A', 'Michael Kors', 'Backpack', 'Red', NULL, '074299', 0.00, 0.00, 79, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-09 19:50:53.137785', NULL, 0.00);
INSERT INTO public.clothing VALUES (2293, 'M', 'Tommy Hilfiger', 'Golfik', 'White', 182, '130252', 8.00, 0.00, 79, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-23 21:42:31.591529', NULL, 0.00);
INSERT INTO public.clothing VALUES (2165, 'XS', 'DKNY', 'Windbreaker', 'Blue', NULL, '527329', 34.99, 47.24, 64, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-18 16:10:10.581808', NULL, 0.00);
INSERT INTO public.clothing VALUES (2078, '26', 'Michael Kors', 'Coat', 'Black', NULL, '873417', 29.99, 40.49, 64, 9, NULL, NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-01-13 11:42:19.531254', NULL, 0.00);
INSERT INTO public.clothing VALUES (2345, 'N/A', 'Tommy Hilfiger', 'Wallet', 'Black', 187, '239293', 14.99, NULL, 105, NULL, 'little dot', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-01-31 15:07:10.219519', NULL, 0.00);
INSERT INTO public.clothing VALUES (1325, 'XS', 'Calvin Klein', 'Puffy Jacket', 'Purple', 56, '873128', 38.82, 48.52, NULL, 10, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:12.835012', NULL, NULL);
INSERT INTO public.clothing VALUES (1305, '10', 'Ralph Lauren', 'Pants', 'White', 56, '939993', 10.00, NULL, NULL, NULL, 'Waist: 44
Hips: 54
Length: 95
Pasadka: 29', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:12.63077', NULL, NULL);
INSERT INTO public.clothing VALUES (1780, '12', 'Calvin Klein', 'Dress', 'Navy', NULL, '374090', 19.99, NULL, NULL, NULL, 'with buttons
tied sash around waist', false, NULL, NULL, NULL, NULL, NULL, '2020-12-25 02:38:20.589321', NULL, NULL);
INSERT INTO public.clothing VALUES (1947, 'N/A', 'Tommy Hilfiger', 'Purse', 'Grey, Black', NULL, '511931', 16.99, NULL, NULL, NULL, 'grey/white/black striped', NULL, 'women', NULL, NULL, NULL, 'Ukraine', '2021-01-03 05:11:55.977965', NULL, 0.00);
INSERT INTO public.clothing VALUES (1316, '???', 'Calvin Klein', 'unknown', 'Unknown', 117, '024472', 18.90, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:12.754527', NULL, NULL);
INSERT INTO public.clothing VALUES (1317, '???', 'Calvin Klein', 'unknown', 'Unknown', 117, '024526', 18.90, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:12.763165', NULL, NULL);
INSERT INTO public.clothing VALUES (1318, '???', 'Calvin Klein', 'Hoodie', 'Unknown', 117, '952719', 25.06, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:12.773154', NULL, NULL);
INSERT INTO public.clothing VALUES (1375, 'N/A', 'Calvin Klein', 'Hat', 'Black', 105, '618676', 14.67, 30.00, NULL, 10, 'delivery: $3.22', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:13.291123', NULL, NULL);
INSERT INTO public.clothing VALUES (1377, 'XS', 'Calvin Klein', 'Sweat Shirt', 'Yellow', 125, '680085', 12.74, 17.16, NULL, 10, 'SOLD TO ALLA
Black & white letters

Chest: 48
Waist: 48
Length: 64
Arm: 51', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:13.309091', NULL, NULL);
INSERT INTO public.clothing VALUES (2467, 'L', 'Michael Kors', 'Sweat Pants', 'Black, White', 201, '196649', 34.99, 47.13, 82, 9, 'White letters everywhere

waist: 41
hips: 53
pasadka: 37
length: 110', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-08 00:26:06.649782', NULL, 0.00);
INSERT INTO public.clothing VALUES (2419, '4', 'Tommy Hilfiger', 'Dress', 'Green', 195, '198771', 26.16, 35.23, 82, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-07 22:24:14.695053', NULL, 0.00);
INSERT INTO public.clothing VALUES (2420, '2', 'Tommy Hilfiger', 'Dress', 'Green', 195, '198788', 26.16, 35.23, 82, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-07 22:24:27.330397', NULL, 0.00);
INSERT INTO public.clothing VALUES (2319, 'XS', 'Michael Kors', 'Puffy Jacket', 'Black', 184, '272908', 70.00, 95.38, 82, 9, 'long

chest: 51
length: 93
arm: 53/74
shoulders: 60
', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-31 14:41:01.407429', NULL, 0.00);
INSERT INTO public.clothing VALUES (2286, 'N/A', 'Calvin Klein', 'Wallet', 'Black', 182, '297731', 9.99, 13.50, 82, 9, 'length: 11
height: 8.5', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-23 21:36:26.365103', NULL, 0.00);
INSERT INTO public.clothing VALUES (2287, 'N/A', 'Calvin Klein', 'Wallet', 'Black', 182, '297731', 9.99, 13.50, 82, 9, 'length: 11
height: 8.5', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-23 21:36:26.988051', NULL, 0.00);
INSERT INTO public.clothing VALUES (2453, 'S', 'Calvin Klein', 'Dress', 'Blue', 201, '404339', 24.99, 33.66, 82, 9, 'chest: 50
length: 85
arm: 63', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-08 00:04:51.024993', NULL, 0.00);
INSERT INTO public.clothing VALUES (2418, 'XL', 'Tommy Hilfiger', 'Dress', 'White, Navy', 195, '418577', 28.81, 38.80, 82, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-07 22:23:45.873056', NULL, 0.00);
INSERT INTO public.clothing VALUES (2322, '4', 'Calvin Klein', 'Satin Dress', 'Black', 185, '646362', 7.96, 10.87, 82, 9, 'chest: 45
hips: 50
length: 110
', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-31 14:44:26.83341', NULL, 0.00);
INSERT INTO public.clothing VALUES (2325, '8', 'Calvin Klein', 'Satin Dress', 'Grey', 185, '652264', 7.96, 10.87, 82, 9, 'chest: 49
hips: 51
length: 113
', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-31 14:46:06.588501', NULL, 0.00);
INSERT INTO public.clothing VALUES (2629, 'N/A', 'Tommy Hilfiger', 'Wallet', 'Black', 215, '425832', 14.99, 20.26, 91, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-22 07:33:14.941917', NULL, 0.00);
INSERT INTO public.clothing VALUES (2188, 'N/A', 'Armani Exchange', 'Purse', 'Navy', 171, '652315', 29.99, 40.96, 82, 9, 'letters all around
length: 90
height: 13
width: 7', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-21 17:20:50.918219', NULL, 0.00);
INSERT INTO public.clothing VALUES (2181, 'S', 'Tommy Hilfiger', 'Windbreaker', 'Navy, Blue', 170, '686331', 32.00, 43.70, 82, 9, 'chest: 50
length: 64
arm: 64
shoulders: 39', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-21 17:08:38.391872', NULL, 0.00);
INSERT INTO public.clothing VALUES (2225, 'N/A', 'Michael Kors', 'Purse', 'Black', NULL, '454915', 39.99, 0.00, 79, 9, 'leather', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-21 17:57:55.859776', NULL, 0.00);
INSERT INTO public.clothing VALUES (2282, 'S', 'Tommy Hilfiger', 'Sweater', 'Navy', NULL, '803531', 7.00, 9.45, 82, 9, 'chest: 52
length: 62
arm: 63', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-01-23 21:33:29.179959', NULL, 0.00);
INSERT INTO public.clothing VALUES (2457, 'XS', 'Tommy Hilfiger', 'Hoodie', 'Navy', 201, '802090', 22.99, 30.96, 82, 9, 'Tommy Jeans on chest
chest: 48
length: 58
arm: 59', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-08 00:10:18.281368', NULL, 0.00);
INSERT INTO public.clothing VALUES (2501, '???', 'Michael Kors', 'Jeans', 'Blue', NULL, '??????', 20.00, 0.00, 80, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-09 19:56:09.171156', NULL, 0.00);
INSERT INTO public.clothing VALUES (2290, 'N/A', 'Michael Kors', 'Wallet', 'White', 182, '096123', 39.99, 0.00, 80, 9, 'MK everywhere

length: 13
height: 9', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-23 21:40:05.908982', NULL, 0.00);
INSERT INTO public.clothing VALUES (2289, 'N/A', 'Michael Kors', 'Wallet', 'Brown', 182, '096130', 39.99, 0.00, 80, 9, 'MK everywhere

length: 13
height: 9', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-23 21:39:55.986928', NULL, 0.00);
INSERT INTO public.clothing VALUES (2245, 'S', 'Michael Kors', 'T-Shirt', 'Black', 177, '642833', 19.99, 0.00, 68, 9, 'gold circle rivets
', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-22 10:27:32.368505', NULL, 0.00);
INSERT INTO public.clothing VALUES (2205, 'XS', 'DKNY', 'T-Shirt', 'White', 173, '761153', 9.99, 0.00, 68, 9, 'Yellow taxis
fo alla', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-21 17:37:30.383764', NULL, 0.00);
INSERT INTO public.clothing VALUES (2215, 'L', 'DKNY', 'Puffy Jacket', 'Grey', 174, '992198', 65.00, 0.00, 68, 9, 'chest: 66
length: 90
arm: 70
shoulders: 54', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-01-21 17:48:59.722671', NULL, 0.00);
INSERT INTO public.clothing VALUES (2270, 'S', 'DKNY', 'Puffy Jacket', 'Green', 180, '273816', 59.99, 0.00, 68, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-23 20:43:21.495239', NULL, 0.00);
INSERT INTO public.clothing VALUES (2163, 'S', 'DKNY', 'Windbreaker', 'Pink', NULL, '526438', 34.99, 0.00, 67, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-18 16:09:03.204477', NULL, 0.00);
INSERT INTO public.clothing VALUES (2166, 'L', 'DKNY', 'Windbreaker', 'Blue', NULL, '526902', 34.99, 0.00, 67, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-18 16:10:39.188071', NULL, 0.00);
INSERT INTO public.clothing VALUES (2212, 'S', 'DKNY', 'Polo Shirt', 'Black', 173, '607006', 14.99, 0.00, 67, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-21 17:45:07.797003', NULL, 0.00);
INSERT INTO public.clothing VALUES (2213, 'L', 'DKNY', 'Polo Shirt', 'Black', 173, '607266', 14.99, 0.00, 67, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-21 17:45:36.639751', NULL, 0.00);
INSERT INTO public.clothing VALUES (682, 'L', 'Tommy Hilfiger', 'Puffy Jacket', 'Navy, Red, White', 47, '621716', 35.00, 0.00, 67, 9, 'Men
navy top
white center
red bottom

Chest: 64
Length: 72
Arm: 71', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.634817', NULL, 0.00);
INSERT INTO public.clothing VALUES (2190, 'N/A', 'Armani Exchange', 'Purse', 'Navy', 171, '652629', 29.99, 0.00, 67, 9, 'Glossy/Shiny
length: 19
height: 15
width: 7', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-21 17:21:52.662513', NULL, 0.00);
INSERT INTO public.clothing VALUES (2221, 'L', 'Michael Kors', 'Sweat Shirt', 'Blue', NULL, '788512', 20.00, 0.00, 67, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-21 17:54:46.523404', NULL, 0.00);
INSERT INTO public.clothing VALUES (2154, 'S', 'DKNY', 'Puffy Jacket', 'Grey', NULL, '391251', 49.99, 101.79, 63, 22, 'from costco

chest: 53
length: 87
arm: 63
shoulders: 42', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-18 15:39:51.595783', NULL, 0.00);
INSERT INTO public.clothing VALUES (3169, 'L', 'Calvin Klein', 'Dress', 'Black', 269, '404582', 19.99, NULL, 114, NULL, 'white lining on collar
chest: 53
hips: 56
length: 93
', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-20 23:34:44.279267', NULL, NULL);
INSERT INTO public.clothing VALUES (3408, '9', 'Calvin Klein', 'Flip Flops', 'Black', 284, '670755901499', 14.99, NULL, 117, NULL, 'пена, ленты накрест размер 9 стелька 25,5 см', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-29 04:27:13.986405', NULL, NULL);
INSERT INTO public.clothing VALUES (3323, 'M', 'Calvin Klein', 'Dress', 'Black', 279, '405862', 19.99, NULL, 119, NULL, 'с большим СК знаком на гр', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-25 03:22:37.425388', NULL, 0.00);
INSERT INTO public.clothing VALUES (3566, 'M', 'Karl Lagerfeld', 'Dress Shirt', 'White', 290, 'LORA6577', 22.99, NULL, 122, NULL, 'с карлом и котами', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-03 03:09:36.421047', NULL, 0.00);
INSERT INTO public.clothing VALUES (2217, 'S', 'Tommy Hilfiger', 'Sweat Shirt', 'White', NULL, '830956', 19.99, 0.00, 79, 9, 'flag on chest

chest: 46
length: 63
arm: 66', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-21 17:50:53.466553', NULL, 0.00);
INSERT INTO public.clothing VALUES (2436, 'M', 'Calvin Klein', 'T-Shirt', 'Black', 197, '803644', 13.08, 17.62, 82, 9, 'payetki sign on chest

chest: 48
length: 64', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-07 23:34:43.565608', NULL, 0.00);
INSERT INTO public.clothing VALUES (2445, 'XS', 'Calvin Klein', 'T-Shirt', 'Black', 199, '803668', 9.15, 12.37, 82, 9, 'payetki sign on chest

chest: 40
length: 62', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-07 23:49:19.877883', NULL, 0.00);
INSERT INTO public.clothing VALUES (2414, 'L', 'Michael Kors', 'Polo', 'Navy', 192, '833878', 19.99, 27.02, 82, 9, 'chest: 56
length: 74
', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-02-07 22:13:13.487471', NULL, 0.00);
INSERT INTO public.clothing VALUES (2238, 'L', 'Michael Kors', 'Polo Shirt', 'Black', 175, '986079', 19.99, 27.17, 82, 9, 'chest: 56
length: 70', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-01-22 10:10:46.351292', NULL, 0.00);
INSERT INTO public.clothing VALUES (2477, 'M', 'Karl Lagerfeld', 'Sweat Shirt', 'Blue', 201, 'LORHS045', 24.99, 33.66, 82, 9, 'gold 3d circle

chest: 53
length: 61
arm: 59', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-08 00:38:56.327295', NULL, 0.00);
INSERT INTO public.clothing VALUES (2476, 'S', 'Karl Lagerfeld', 'Sweat Shirt', 'Blue', 201, 'LORHS045', 24.99, 33.66, 82, 9, 'gold 3d circle

chest: 51
length: 60
arm: 58', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-08 00:38:21.895134', NULL, 0.00);
INSERT INTO public.clothing VALUES (1387, '4', 'Calvin Klein', 'Shorts', 'Yellow', 125, '928561', 12.74, 17.16, NULL, 10, 'SOLD TO ALLA
Built in belt

Waist: 35
Hips: 51
Length: 42
Pasadka: 28', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:13.396845', NULL, NULL);
INSERT INTO public.clothing VALUES (1380, 'S', 'Calvin Klein', 'Sweat Shirt', 'Yellow', 125, '680078', 12.74, NULL, NULL, NULL, 'Black & white letters

Chest: 50
Waist: 50
Length: 62
Arm:  53', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:13.33545', NULL, NULL);
INSERT INTO public.clothing VALUES (1948, 'L', 'Armani Exchange', 'Belt Purse', 'Black, White', NULL, '257957', 39.99, NULL, NULL, NULL, 'Belt + black purse + white purse', NULL, 'women', NULL, NULL, NULL, 'Ukraine', '2021-01-03 05:28:15.682774', NULL, 0.00);
INSERT INTO public.clothing VALUES (1413, '???', 'Calvin Klein', 'unknown', 'Unknown', 128, '425144', 11.06, 15.10, NULL, 10, 'SOLD TO ALLA', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:13.665717', NULL, NULL);
INSERT INTO public.clothing VALUES (2684, 'L', 'Armani Exchange', 'Puffy Jacket', 'Green', 217, '125819', 69.99, 95.36, 90, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-27 21:44:09.058004', NULL, 0.00);
INSERT INTO public.clothing VALUES (2569, 'XS', 'Tommy Hilfiger', 'Jacket', 'Cream', 209, '144624', 28.17, 37.94, 89, 9, 'Padded
chest: 48
length: 76
arm: 61
shoulders: 40', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-15 04:46:44.776517', NULL, 0.00);
INSERT INTO public.clothing VALUES (2335, 'M', 'Armani Exchange', 'Hoodie', 'Blue', 186, '147492', 35.99, 49.15, 89, 9, 'zipped

chest: 53
length: 68
arm: 67
shoulders: 46
', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-31 14:54:11.891164', NULL, 0.00);
INSERT INTO public.clothing VALUES (2504, '2X36', 'Levis', 'Skirt', 'Blue', 203, '236168', 11.99, 16.21, 82, 9, 'waist: 34
hips: 46
length: 41', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-11 23:36:05.018192', NULL, 0.00);
INSERT INTO public.clothing VALUES (2643, 'M', 'DKNY', 'Puffy Jacket', 'Green', NULL, '273809', 59.99, 80.99, 90, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-22 20:20:49.480363', NULL, 0.00);
INSERT INTO public.clothing VALUES (2535, 'S', 'Michael Kors', 'Puffy Jacket', 'Brown', 206, '280378', 70.00, 94.50, 90, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-15 04:02:05.951915', NULL, 0.00);
INSERT INTO public.clothing VALUES (2546, 'M', 'Tommy Hilfiger', 'T-Shirt', 'Black', 207, '307364', 12.99, 17.50, 89, 9, 'block letter "tommy hilfiger" on chest
chest: 52
length: 63', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-15 04:22:34.493171', NULL, 0.00);
INSERT INTO public.clothing VALUES (2662, 'XL', 'Armani Exchange', 'Puffy Jacket', 'Navy', 217, '335598', 87.00, 118.54, 90, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-23 20:58:55.457045', NULL, 0.00);
INSERT INTO public.clothing VALUES (2644, 'M', 'Armani Exchange', 'Puffy Jacket', 'Green', 217, '337073', 87.00, 118.54, 90, 9, 'Chest: 57
Waist: 55
Length: 64
Arm: 63', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-23 20:43:48.247548', NULL, 0.00);
INSERT INTO public.clothing VALUES (2705, 'M', 'Armani Exchange', 'Long Sleeved Shirt', 'Mint', 222, '364646', 29.99, 40.91, 89, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-27 22:27:18.022566', NULL, 0.00);
INSERT INTO public.clothing VALUES (2661, '4', 'Armani Exchange', 'Blazer', 'Pink', 217, '365414', 39.99, 54.49, 89, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-23 20:58:14.578038', NULL, 0.00);
INSERT INTO public.clothing VALUES (2523, 'L', 'DKNY', 'Puffy Jacket', 'Black', NULL, '391305', 25.00, 33.75, 90, 9, 'from costco

chest: 59
length: 89
arm: 65
shoulders: 46', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-13 02:16:10.374071', NULL, 0.00);
INSERT INTO public.clothing VALUES (3490, 'M', 'Armani Exchange', 'Puffy Jacket', 'Black', 287, '4991903', 49.99, NULL, NULL, NULL, NULL, NULL, 'men', NULL, NULL, NULL, 'usa', '2021-04-02 21:33:56.058794', NULL, NULL);
INSERT INTO public.clothing VALUES (2520, 'M', 'DKNY', 'Puffy Jacket', 'Black', NULL, '391312', 25.00, 33.75, 90, 9, 'from costco

chest: 56
length: 88
arm: 66
shoulders: 43', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-13 02:14:37.355209', NULL, 0.00);
INSERT INTO public.clothing VALUES (2519, 'S', 'DKNY', 'Puffy Jacket', 'Black', NULL, '391329', 25.00, 33.75, 90, 9, 'from costco

chest: 53
length: 87
arm: 63
shoulders: 42', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-13 02:14:29.596996', NULL, 0.00);
INSERT INTO public.clothing VALUES (2701, 'L', 'Armani Exchange', 'Blazer', 'Black', 222, '405819', 29.99, 40.91, 89, 9, NULL, NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-02-27 22:24:33.049325', NULL, 0.00);
INSERT INTO public.clothing VALUES (2699, 'XL', 'Armani Exchange', 'Blazer', 'Black', 222, '405840', 29.99, 40.91, 89, 9, NULL, NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-02-27 22:20:56.67122', NULL, 0.00);
INSERT INTO public.clothing VALUES (2590, 'M', 'Calvin Klein', 'Windbreaker', 'Black', 211, '427543', 49.99, 67.57, 89, 9, 'stripe "calvin" on sleeve

chest: 58
length: 70
arm: 67
shoulders: 50', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-02-18 02:56:58.218093', NULL, 0.00);
INSERT INTO public.clothing VALUES (2543, 'M', 'Michael Kors', 'Sweat Pants', 'Black', 207, '450550', 29.99, 40.39, 89, 9, 'white MK stripe on sides
waist: 39
hips: 53
pasadka: 29
length: 100', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-15 04:19:21.266777', NULL, 0.00);
INSERT INTO public.clothing VALUES (2471, 'L', 'Michael Kors', 'Hoodie', 'White', 201, '451724', 29.99, 40.39, 82, 9, 'Black MK, gold rivet holes

chest: 57
length: 66
arm: 73', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-08 00:30:43.406246', NULL, 0.00);
INSERT INTO public.clothing VALUES (2595, 'L', 'Tommy Hilfiger', 'T-Shirt', 'White', 212, '463966', 9.99, 13.50, 89, 9, 'golden sign hilfiger', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-18 03:02:41.335133', NULL, 0.00);
INSERT INTO public.clothing VALUES (2586, 'M', 'Calvin Klein', 'Sweat Pants', 'Black', 211, '503841', 19.99, 27.02, 89, 9, 'lowercase calvin klein on side with white dot

waist: 40
hips: 51
pasadka: 27
length: 94', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-18 02:54:14.583881', NULL, 0.00);
INSERT INTO public.clothing VALUES (2572, 'M', 'Michael Kors', 'Sweat Shirt', 'Navy', 210, '504671', 19.99, 26.92, 89, 9, 'kors michael kors on chest
chest: 55
length: 69
arm: 66', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-15 04:54:05.619746', NULL, 0.00);
INSERT INTO public.clothing VALUES (2573, 'M', 'Michael Kors', 'Sweat Shirt', 'Black', 210, '504954', 19.99, 26.92, 89, 9, 'kors michael kors on chest
chest: 55
length: 69
arm: 66', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-15 04:54:18.870174', NULL, 0.00);
INSERT INTO public.clothing VALUES (2413, 'M', 'Michael Kors', 'Polo Shirt', 'Black', 192, '773679', 19.99, 27.02, 89, 9, 'Chest 53
length: 70', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-02-07 22:12:15.695485', NULL, 0.00);
INSERT INTO public.clothing VALUES (2103, 'N/A', 'Armani Exchange', 'Bag', 'White', 162, '786539', 39.99, 54.05, 82, 9, 'length: 42
width: 15
height: 24', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-16 14:34:42.300828', NULL, 0.00);
INSERT INTO public.clothing VALUES (2717, 'M', 'Calvin Klein', 'T-Shirt', 'Black', 223, '791423', 12.99, 17.50, 89, 9, 'bluish-golden sign on chest
chest: 54
length: 69', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-02-27 22:50:09.292525', NULL, 0.00);
INSERT INTO public.clothing VALUES (2715, 'XL', 'Calvin Klein', 'T-Shirt', 'Black', 223, '791447', 12.99, 17.50, 89, 9, 'bluish-gold sign', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-02-27 22:49:22.058636', NULL, 0.00);
INSERT INTO public.clothing VALUES (2557, 'S', 'Tommy Hilfiger', 'Hoodie', 'White', 207, '802120', 22.99, 30.96, 89, 9, 'tommy jeans on chest
chest: 50
length: 61
arm: 60
', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-15 04:36:52.815003', NULL, 0.00);
INSERT INTO public.clothing VALUES (2368, 'M', 'Karl Lagerfeld', 'Hoodie', 'Black', 189, 'Lorh7081', 24.99, 0.00, 79, 9, 'pictures on front', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-31 15:30:11.771886', NULL, 0.00);
INSERT INTO public.clothing VALUES (2139, 'M', 'Tommy Hilfiger', 'Sweat Shirt', 'White', NULL, '830949', 19.99, 0.00, 80, 9, 'flag on chest

chest: 50
length: 64
arm: 70', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-16 19:09:29.06326', NULL, 0.00);
INSERT INTO public.clothing VALUES (2366, 'S', 'Karl Lagerfeld', 'Hoodie', 'Black', 189, 'Lorh7081', 24.99, 0.00, 80, 9, 'pictures on front', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-31 15:30:02.750147', NULL, 0.00);
INSERT INTO public.clothing VALUES (3170, 'S', 'Calvin Klein', 'Tank Top', 'Black', 269, '039753', 11.99, NULL, NULL, NULL, 'chest: 47
length: 48', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-20 23:35:24.297103', NULL, NULL);
INSERT INTO public.clothing VALUES (2391, 'S', 'Calvin Klein', 'Hoodie', 'Blue', 192, '281969', 20.00, NULL, NULL, NULL, 'chest: 53
length: 69
arm: 65', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-02-07 21:22:48.30106', NULL, 0.00);
INSERT INTO public.clothing VALUES (351, 'M', 'Calvin Klein', 'Sweat Shirt', 'Black', 29, '782155', 20.19, 53.57, 69, 22, 'zipped
striped calvin klein on sleeve

chest: 52
length: 68
arm: 65', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.733749', NULL, 0.00);
INSERT INTO public.clothing VALUES (1382, 'M', 'Calvin Klein', 'Shorts', 'Black', 125, '978700', 8.49, NULL, 127, NULL, 'White letters on one leg

Waist: 39
Hips: 54
Length: 43
Pasadka: 29', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:13.353134', NULL, NULL);
INSERT INTO public.clothing VALUES (2559, 'M', 'Calvin Klein', 'Panties', 'Blue', 208, '094570', 3.00, 0.00, 92, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-15 04:39:22.152926', NULL, 0.00);
INSERT INTO public.clothing VALUES (2561, 'M', 'Calvin Klein', 'Panties', 'Green', 208, '098226', 3.00, 0.00, 92, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-15 04:39:54.456007', NULL, 0.00);
INSERT INTO public.clothing VALUES (2639, 'M', 'Michael Kors', 'Jean Jacket', 'Navy', 216, '807690', 34.99, 47.56, 89, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-22 07:48:45.770024', NULL, 0.00);
INSERT INTO public.clothing VALUES (2548, 'L', 'Tommy Hilfiger', 'T-Shirt', 'Black', 207, '814307', 12.99, 17.50, 89, 9, 'white line + block letter "tommy hilfiger" on chest
chest: 49
length: 63', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-15 04:24:57.943545', NULL, 0.00);
INSERT INTO public.clothing VALUES (2517, 'M', 'Calvin Klein', 'Hoodie', 'Black', NULL, '845433', 14.99, 20.24, 82, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-12 02:53:08.001345', NULL, 0.00);
INSERT INTO public.clothing VALUES (2516, 'M', 'Calvin Klein', 'Hoodie', 'Black', NULL, '845433', 14.99, 20.24, 82, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-12 02:53:06.640271', NULL, 0.00);
INSERT INTO public.clothing VALUES (2599, 'S', 'Tommy Hilfiger', 'Windbreaker', 'White', NULL, '866511', 29.99, 40.49, 89, 9, 'costco jacket', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-18 03:06:33.727109', NULL, 0.00);
INSERT INTO public.clothing VALUES (2600, 'L', 'Tommy Hilfiger', 'Windbreaker', 'Red', NULL, '866542', 29.99, 40.49, 89, 9, 'costco jacket', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-18 03:06:53.734742', NULL, 0.00);
INSERT INTO public.clothing VALUES (2711, 'L', 'Michael Kors', 'Polo Shirt', 'Black', 223, '941818', 24.99, 33.66, 89, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-27 22:46:38.04553', NULL, 0.00);
INSERT INTO public.clothing VALUES (2329, 'M', 'Armani Exchange', 'Sweat Pants', 'Blue', 186, '968690', 26.99, 36.86, 89, 9, 'waist: 42
hips: 54
pasadka: 30
length: 105', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-31 14:50:13.384656', NULL, 0.00);
INSERT INTO public.clothing VALUES (2514, '8', 'Calvin Klein', 'Shoes', 'Cream', NULL, 'Allashoes1', 29.99, 40.49, 82, 9, 'high heels', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-12 02:49:50.360079', NULL, 0.00);
INSERT INTO public.clothing VALUES (2489, 'L', 'Karl Lagerfeld', 'Sweat Shirt', 'Black, White', NULL, 'LORH7092', 22.99, 31.04, 82, 9, 'Black sunglasses', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-08 01:04:27.499639', NULL, 0.00);
INSERT INTO public.clothing VALUES (2144, 'S', 'Tommy Hilfiger', 'Hoodie', 'White', 167, '805626', 21.99, NULL, NULL, NULL, 'cropped
tommy jeans at bottom

chest: 37
length: 48
arm: 61', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-01-16 19:16:09.167946', NULL, NULL);
INSERT INTO public.clothing VALUES (1462, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 135, '792896', 33.59, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:14.101957', NULL, NULL);
INSERT INTO public.clothing VALUES (2411, 'L', 'DKNY', 'Sweat Pants', 'Black', 192, '055151', 16.99, 22.96, 91, 9, 'white DKNY on leg

Waist: 42
hips: 58
pasadka: 34
length: 105', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-02-07 22:08:26.182909', NULL, 0.00);
INSERT INTO public.clothing VALUES (2783, 'XL', 'Michael Kors', 'Dress Shirt', 'Navy', 226, '056606', 19.99, 26.92, 94, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-01 06:14:10.280727', NULL, 0.00);
INSERT INTO public.clothing VALUES (2592, 'L', 'Calvin Klein', 'Hoodie', 'Grey', 211, '061302', 19.99, 27.02, 91, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-18 02:58:43.560031', NULL, 0.00);
INSERT INTO public.clothing VALUES (1463, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 135, '790854', 38.39, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:14.111399', NULL, NULL);
INSERT INTO public.clothing VALUES (2621, 'M', 'Levis', 'T-Shirt', 'White', 215, '102286', 9.99, 13.50, 91, 9, 'Boxed pack of 3', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-02-22 07:23:01.152162', NULL, 0.00);
INSERT INTO public.clothing VALUES (2622, 'L', 'Levis', 'T-Shirt', 'White', 215, '102415', 9.99, 13.50, 91, 9, 'Boxed pack of 3', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-02-22 07:25:03.932952', NULL, 0.00);
INSERT INTO public.clothing VALUES (2623, 'M', 'Levis', 'T-Shirt', 'White, Grey, Navy', 215, '102484', 9.99, 13.50, 91, 9, 'Boxed pack of 3', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-02-22 07:25:38.25672', NULL, 0.00);
INSERT INTO public.clothing VALUES (2620, 'L', 'Levis', 'Man Panties', 'Black, Grey', 215, '128286', 9.99, 13.50, 91, 9, 'Boxed pack of 4', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-02-22 07:22:22.332473', NULL, 0.00);
INSERT INTO public.clothing VALUES (3054, '8', 'DKNY', 'Shoes', 'White', 234, '196895', 29.99, 40.58, 91, 9, 'с розовыми шнурками', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-11 20:11:52.191662', NULL, 0.00);
INSERT INTO public.clothing VALUES (2350, 'N/A', 'Levis', 'Wallet', 'Black', 187, '290089', 12.99, 17.58, 91, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-31 15:08:51.38697', NULL, 0.00);
INSERT INTO public.clothing VALUES (2693, 'XL', 'Michael Kors', 'Puffy Jacket', 'Black', 221, '336204', 65.00, 88.77, 90, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-27 22:13:20.880069', NULL, 0.00);
INSERT INTO public.clothing VALUES (2964, 'S', 'Michael Kors', 'Belt', 'Brown', 229, '388217', 16.99, 22.99, 91, 9, 'коричневый
92 см', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-06 23:58:04.202617', NULL, 0.00);
INSERT INTO public.clothing VALUES (2781, 'M', 'Calvin Klein', 'Leggings', 'Black', 226, '394333', 19.99, 26.92, 94, 9, 'silver sign', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-01 06:13:24.608845', NULL, 0.00);
INSERT INTO public.clothing VALUES (3057, '6.5', 'Calvin Klein', 'Shoes', 'Cream', 234, '458767', 29.99, 40.58, 91, 9, 'на каблуке с открытой пяткой', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-11 22:36:08.71276', NULL, 0.00);
INSERT INTO public.clothing VALUES (2638, 'L', 'Calvin Klein', 'Sweat Pants', 'Grey', 216, '474479', 19.99, 27.17, 91, 9, 'white capitalized calvin klein jeans', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-22 07:47:29.108649', NULL, 0.00);
INSERT INTO public.clothing VALUES (2637, 'M', 'Calvin Klein', 'Sweat Pants', 'Grey', 216, '474486', 19.99, 27.17, 91, 9, 'white capitalized calvin klein jeans
waist: 41
hips: 53
pasadka: 28
length: 95', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-22 07:47:01.47502', NULL, 0.00);
INSERT INTO public.clothing VALUES (2558, 'L', 'Calvin Klein', 'Panties', 'Blue', 208, '110256', 3.00, 0.00, 92, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-15 04:39:05.257713', NULL, 0.00);
INSERT INTO public.clothing VALUES (2710, 'L', 'Michael Kors', 'Sweat Shirt', 'Navy', 223, '504688', 19.99, 26.92, 91, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-27 22:46:09.236929', NULL, 0.00);
INSERT INTO public.clothing VALUES (2719, 'XL', 'Michael Kors', 'Sweat Shirt', 'Black', 223, '504978', 19.99, 26.92, 91, 9, NULL, NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-02-27 22:51:53.8056', NULL, 0.00);
INSERT INTO public.clothing VALUES (2708, 'XL', 'Michael Kors', 'Sweat Shirt', 'White', 223, '505111', 19.99, 26.92, 91, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-27 22:44:49.965231', NULL, 0.00);
INSERT INTO public.clothing VALUES (3049, 'XL', 'Tommy Hilfiger', 'Windbreaker', 'White', 234, '514372', 34.99, 47.35, 91, 9, 'ветровка с мал круглым знаком', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-11 19:55:04.177949', NULL, 0.00);
INSERT INTO public.clothing VALUES (2625, 'L', 'Bebe', 'Sweat Pants', 'Olive', 215, '618835', 14.99, 20.26, 91, 9, 'gold sign', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-22 07:26:59.511437', NULL, 0.00);
INSERT INTO public.clothing VALUES (2624, 'L', 'Bebe', 'Hoodie', 'Olive', 215, '621477', 14.99, 20.26, 91, 9, 'gold sign', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-22 07:26:23.19314', NULL, 0.00);
INSERT INTO public.clothing VALUES (2562, 'S', 'Calvin Klein', 'Panties', 'White', 208, '125274', 3.00, 0.00, 92, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-15 04:40:07.096736', NULL, 0.00);
INSERT INTO public.clothing VALUES (2780, 'M', 'Calvin Klein', 'T-Shirt', 'Black', 226, '425303', 12.99, 17.50, 94, 9, 'strange sign', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-01 06:12:15.537993', NULL, 0.00);
INSERT INTO public.clothing VALUES (2742, 'XS', 'Tommy Hilfiger', 'Hoodie', 'Grey', 225, '432313', 25.19, 0.00, 92, 9, 'chest: 48
length: 53
arm: 61', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-01 01:17:11.56848', NULL, 0.00);
INSERT INTO public.clothing VALUES (3171, 'XS', 'Levis', 'Hoodie', 'White', 269, '087413', 6.99, NULL, NULL, NULL, 'Hello kitty
chest: 56
length: 59
arm: 59', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-20 23:36:18.072131', NULL, NULL);
INSERT INTO public.clothing VALUES (2685, 'XXL', 'Armani Exchange', 'Windbreaker', 'Black', 217, '933653', 39.99, 54.49, 89, 9, 'A|X on chest', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-27 21:47:02.099525', NULL, 0.00);
INSERT INTO public.clothing VALUES (2297, 'S', 'DKNY', 'Puffy Jacket', 'Grey', NULL, '391251', 49.99, 101.79, NULL, 22, 'from costco

chest: 53
length: 87
arm: 63
shoulders: 42', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-25 15:01:06.37778', NULL, 5.00);
INSERT INTO public.clothing VALUES (3324, 'One Size', 'Calvin Klein', 'Backpack', 'Black', 279, '204922', 49.99, NULL, NULL, NULL, 'чисто чёрный', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-25 03:23:26.013402', NULL, 0.00);
INSERT INTO public.clothing VALUES (3409, 'S', 'Calvin Klein', 'Jean Jacket', 'Blue', NULL, '91480800399911', 19.99, NULL, 118, NULL, NULL, NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-30 02:40:00.425222', NULL, NULL);
INSERT INTO public.clothing VALUES (1949, 'N/A', 'Calvin Klein', 'Wallet', 'Black', NULL, '551939', 15.00, 26.79, NULL, 22, 'White CK pattern', NULL, 'women', NULL, NULL, NULL, 'Usa', '2021-01-03 05:31:57.15707', NULL, 0.00);
INSERT INTO public.clothing VALUES (3483, 'L', 'Armani Exchange', 'Puffy Jacket', 'Black', 287, '0321461', 79.99, NULL, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-02 21:23:22.545686', NULL, NULL);
INSERT INTO public.clothing VALUES (3567, 'S', 'Calvin Klein', 'Dress', 'Black', 290, '227426', 19.99, NULL, 122, NULL, 'со стразами 
ПОГ 45
ПОБ 49
дл 90', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-03 03:11:52.33421', NULL, NULL);
INSERT INTO public.clothing VALUES (1465, 'S', 'Tommy Hilfiger', 'Shorts', 'Black', 135, '085892', 15.99, NULL, 127, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:14.12978', NULL, 0.00);
INSERT INTO public.clothing VALUES (2398, 'S', 'Bebe', 'Sweat Pants', 'Black', 193, '656028', 14.99, 0.00, 92, NULL, 'rose-gold Payetki on leg

waist: 37
hips: 49
pasadka: 27
length: 100', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-07 21:40:04.316323', NULL, 0.00);
INSERT INTO public.clothing VALUES (3410, 'One Size', 'DKNY', 'Backpack', 'Black', NULL, '857349', 39.99, NULL, 118, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-30 02:43:26.698715', NULL, NULL);
INSERT INTO public.clothing VALUES (2013, 'M', 'Calvin Klein', 'Sweat Shirt', 'Black', 154, '796458', 14.05, 0.00, 92, 9, '"calvin" on shoulder
chest: 59
length: 60/70
arm: 43/68', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 12:10:04.10865', NULL, 0.00);
INSERT INTO public.clothing VALUES (2393, 'S', 'Bebe', 'Hoodie', 'Black', 193, '655724', 16.99, 0.00, 92, NULL, 'zipped
pinky-goldish zipper

chest: 51
length: 59
arm: 58', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-07 21:29:11.064354', NULL, 0.00);
INSERT INTO public.clothing VALUES (2727, 'N/A', 'Tommy Hilfiger', 'Hat', 'Navy', 225, '521548', 9.54, NULL, 105, NULL, 'baseball cap', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-01 00:59:10.852303', NULL, 0.00);
INSERT INTO public.clothing VALUES (2177, 'S', 'Tommy Hilfiger', 'Dress', 'Black', 169, '440004', 27.99, 0.00, 67, 9, 'cursive sign

chest: 48
length: 87
arm: 60', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-21 17:03:41.404392', NULL, 0.00);
INSERT INTO public.clothing VALUES (3484, 'XL', 'Armani Exchange', 'Puffy Jacket', 'Black', 287, '4991927', 49.99, NULL, NULL, NULL, NULL, NULL, 'men', NULL, NULL, NULL, 'usa', '2021-04-02 21:25:13.903626', NULL, NULL);
INSERT INTO public.clothing VALUES (2392, 'L', 'Tommy Hilfiger', 'T-Shirt', 'White', 192, '717333', 14.99, NULL, 106, NULL, 'Tommiy Hilfiger on chest

chest: 55
length: 73', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-02-07 21:24:59.023322', NULL, 0.00);
INSERT INTO public.clothing VALUES (2428, 'M', 'Tommy Hilfiger', 'Polo Shirt', 'White', 196, '714189', 16.00, NULL, 106, NULL, 'chest: 52
length: 68
', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-02-07 23:19:06.886444', NULL, 0.00);
INSERT INTO public.clothing VALUES (3172, 'L', 'Karl Lagerfeld', 'Dress', 'Black', NULL, 'LD1R9551', 19.99, NULL, 122, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-20 23:36:49.945877', NULL, 0.00);
INSERT INTO public.clothing VALUES (3568, 'S', 'DKNY', 'Dress', 'Black', 290, '779002', 19.99, NULL, 122, NULL, 'со стразами 
ПОГ 45
ПОБ 49
дл 90', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-03 03:12:21.764108', NULL, NULL);
INSERT INTO public.clothing VALUES (2397, 'XS', 'Calvin Klein', 'T-Shirt', 'Black', 193, '455904', 14.99, NULL, 127, NULL, 'white silver sign on chest

chest: 42
length: 63', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-07 21:38:33.477923', NULL, 0.00);
INSERT INTO public.clothing VALUES (3244, 'S', 'Karl Lagerfeld', 'Sweat Shirt', 'Black', NULL, '851353', 69.99, 75.00, NULL, 22, 'white/pink line down arms
"karl lagerfeld" on white/pink line
pink outlining

chest: 51
length: 66
arm: 59', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-21 21:22:48.896068', NULL, 0.00);
INSERT INTO public.clothing VALUES (2424, 'S', 'Tommy Hilfiger', 'Sweater', 'Red', 195, '398947', 15.99, NULL, NULL, NULL, 'circle logo sign on chest

chest: 38
length: 61
arm: 61', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-07 22:29:59.407008', NULL, 0.00);
INSERT INTO public.clothing VALUES (2402, '8', 'Tommy Hilfiger', 'Flip Flops', 'Black', 193, '859438', 14.99, NULL, NULL, NULL, 'length: 25
', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-07 21:46:58.372987', NULL, 0.00);
INSERT INTO public.clothing VALUES (2777, 'S', 'Tommy Hilfiger', 'Sweater', 'White', 226, '805589', 19.99, 26.92, 91, 9, 'flag on chest', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-01 06:10:55.804502', NULL, 0.00);
INSERT INTO public.clothing VALUES (3061, 'M', 'Calvin Klein', 'Belt', 'Brown', NULL, '882432', 12.99, 17.54, 91, 9, 'CK pattern', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-12 00:38:19.901204', NULL, 0.00);
INSERT INTO public.clothing VALUES (3325, '12', 'Massimo Duti', 'Pants', 'Tan', NULL, '710443', 5.99, NULL, 116, NULL, 'кремовые штаны
ПОТ 42
ПОБ 57
дл 104
пос 33', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-25 04:02:20.941548', NULL, NULL);
INSERT INTO public.clothing VALUES (2009, 'XS', 'Calvin Klein', 'Sweat Shirt', 'Black', 154, '888979', 14.05, 18.92, 56, 9, 'rhinestones', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 12:05:38.450594', NULL, 0.00);
INSERT INTO public.clothing VALUES (1166, 'XS', 'Calvin Klein', 'T-Shirt', 'Black', 100, '599288', 11.89, NULL, NULL, NULL, 'White + yellow letters

Chest: 46
Waist: 46
Length: 43', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:11.343753', NULL, NULL);
INSERT INTO public.clothing VALUES (2405, 'S', 'Bebe', 'Hoodie', 'Green', 193, '621453', 14.99, NULL, NULL, NULL, 'gold sign on chest

chest: 48
length: 63
arm from neck: 80', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-07 21:55:59.9932', NULL, 0.00);
INSERT INTO public.clothing VALUES (2407, 'S', 'Bebe', 'Hoodie', 'Black', 193, '619103', 16.99, NULL, NULL, NULL, 'Zipped
rose-gold

chest: 48
length: 62
arm: 78', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-07 22:00:09.822027', NULL, 0.00);
INSERT INTO public.clothing VALUES (2396, 'S', 'Bebe', 'Hoodie', 'Black', 193, '621309', 14.99, NULL, NULL, NULL, 'pink letters

chest: 45
length: 62
arm from neck: 80', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-07 21:35:56.254816', NULL, 0.00);
INSERT INTO public.clothing VALUES (2394, 'S', 'Bebe', 'Sport Pants', 'Black', 193, '618910', 14.99, NULL, NULL, NULL, 'Pink letters

waist: 37
hips: 48
pasadka: 26
length: 97', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-07 21:31:27.737062', NULL, 0.00);
INSERT INTO public.clothing VALUES (2416, 'XS', 'Tommy Hilfiger', 'Hoodie', 'Pink', 194, '869112', 27.99, 58.93, 105, 22, 'chest: 56
length: 65
arm: 55/77', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-07 22:19:48.743254', NULL, 0.00);
INSERT INTO public.clothing VALUES (1630, 'M', 'Calvin Klein', 'Shorts', 'Pink', 125, '350193', 8.49, NULL, 121, NULL, 'waist: 40
hips: 52
pasadka: 28
length: 51', NULL, 'women', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:15.655871', NULL, 0.00);
INSERT INTO public.clothing VALUES (3056, '8', 'Calvin Klein', 'Flip Flops', 'White', 234, '961393', 14.99, 20.28, 91, 9, 'белые с прозрачным верхом белые буквы стелька 25 см', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-11 22:34:06.826553', NULL, 0.00);
INSERT INTO public.clothing VALUES (3004, '9', 'Calvin Klein', 'Shoes', 'Tan', 232, 'CKS001', 29.99, 40.77, 91, 9, 'high heels', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-10 00:09:37.851849', NULL, 0.00);
INSERT INTO public.clothing VALUES (3005, '8', 'Calvin Klein', 'Shoes', 'Black', 232, 'CKS002', 19.99, 27.17, 91, 9, 'flippy floppy high heels
shiny
', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-10 00:10:32.92948', NULL, 0.00);
INSERT INTO public.clothing VALUES (2817, 'M', 'Tommy Hilfiger', 'Blazer', 'Navy', NULL, '235896', 24.99, 0.00, 97, 9, 'с пуговицами', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 01:50:18.091471', NULL, 0.00);
INSERT INTO public.clothing VALUES (2838, 'M', 'Calvin Klein', 'Rain Coat', 'Pearl', NULL, '360895', 40.00, 0.00, 97, 9, 'ПОГ 54
длина 77
Рукав 72', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 03:01:34.904131', NULL, 0.00);
INSERT INTO public.clothing VALUES (3006, '7.5', 'Calvin Klein', 'Shoes', 'Black', 232, 'CKS002', 19.99, 27.17, 91, 9, 'flippy floppy high heels
shiny
', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-10 00:10:52.761688', NULL, 0.00);
INSERT INTO public.clothing VALUES (2367, 'XS', 'Karl Lagerfeld', 'Hoodie', 'Black', 189, 'Lorh7081', 24.99, 0.00, 92, 9, 'pictures on front', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-31 15:30:07.568326', NULL, 0.00);
INSERT INTO public.clothing VALUES (3060, '7.5', 'Calvin Klein', 'Shoes', 'Tan', NULL, 'CKS002', 19.99, 26.99, 91, 9, 'flippy floppy high heels
shiny
', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-12 00:36:58.667977', NULL, 0.00);
INSERT INTO public.clothing VALUES (2778, 'M', 'Calvin Klein', 'Leggings', 'Black', 226, '036905', 19.99, 26.92, 94, 9, 'white letters all around', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-01 06:11:26.218084', NULL, 0.00);
INSERT INTO public.clothing VALUES (2795, 'M', 'Michael Kors', 'T-Shirt', 'Black', NULL, '056484', 16.99, 22.94, 98, 9, 'Ch 54
L 70', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-03-03 21:08:53.77129', NULL, 0.00);
INSERT INTO public.clothing VALUES (2655, 'L', 'Armani Exchange', 'Sweat Pants', 'Blue', 217, '064538', 29.99, 40.86, 94, 9, 'waist: 45
hips: 56
pasadka: 32
length: 108', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-02-23 20:54:05.834349', NULL, 0.00);
INSERT INTO public.clothing VALUES (3326, 'XS', 'DKNY', 'Sweat Shirt', 'Black', 280, '183771', 29.98, NULL, NULL, NULL, 'chest 51
L 64
sl 58', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-27 04:02:34.356736', NULL, NULL);
INSERT INTO public.clothing VALUES (2653, 'L', 'Armani Exchange', 'Hoodie', 'Blue', 217, '147485', 39.99, 54.49, 94, 9, 'zipped

chest: 58
length: 69
arm: 68
shoulders: 51
', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-23 20:52:08.1686', NULL, 0.00);
INSERT INTO public.clothing VALUES (2654, 'L', 'Armani Exchange', 'Hoodie', 'Blue', 217, '147485', 39.99, 54.49, 94, 9, 'zipped

chest: 58
length: 69
arm: 68
shoulders: 51
', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-23 20:52:24.201696', NULL, 0.00);
INSERT INTO public.clothing VALUES (2794, 'M', 'Michael Kors', 'T-Shirt', 'White', NULL, '238262', 14.99, 20.24, 98, 9, NULL, NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-03-03 21:07:29.234927', NULL, 0.00);
INSERT INTO public.clothing VALUES (2773, 'M', 'Calvin Klein', 'Leggings', 'Black', 226, '282547', 16.99, 22.88, 94, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-01 06:08:59.661044', NULL, 0.00);
INSERT INTO public.clothing VALUES (2775, 'S', 'Calvin Klein', 'Leggings', 'Black', 226, '282554', 16.99, 22.88, 94, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-01 06:09:35.825248', NULL, 0.00);
INSERT INTO public.clothing VALUES (1537, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 139, '947876', 9.59, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:14.803056', NULL, NULL);
INSERT INTO public.clothing VALUES (3411, 'One Size', 'DKNY', 'Purse', 'Black', NULL, '278996', 39.99, NULL, 118, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-30 03:04:49.225885', NULL, NULL);
INSERT INTO public.clothing VALUES (3245, 'S', 'Karl Lagerfeld', 'Sweat Pants', 'Black', NULL, '851308', 49.99, 71.43, NULL, 22, 'white/pink line down side
"karl lagerfeld" on white/pink line

waist: 40
hips: 52
pasadka: 27
length: 102', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-21 21:22:56.145289', NULL, 0.00);
INSERT INTO public.clothing VALUES (2648, 'XL', 'Armani Exchange', 'Sweater', 'Black', 217, '336640', 30.00, 40.88, 94, 9, 'red sign A|X
chest: 59
length: 71
arm: 68', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-02-23 20:47:36.037387', NULL, 0.00);
INSERT INTO public.clothing VALUES (2657, 'M', 'Armani Exchange', 'Sweater', 'Navy', 217, '337166', 28.50, 38.83, 94, 9, 'half zipped
chest: 51
length: 65
arm: 66', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-02-23 20:55:08.352836', NULL, 0.00);
INSERT INTO public.clothing VALUES (3173, 'S', 'Karl Lagerfeld', 'T-Shirt', 'Black', 269, 'LORH7052', 16.99, NULL, 112, NULL, 'с серебр паетками
ПОГ 48
дл
62', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-20 23:37:30.797527', NULL, 0.00);
INSERT INTO public.clothing VALUES (1538, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 139, '947951', 9.59, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:14.812348', NULL, NULL);
INSERT INTO public.clothing VALUES (2800, 'L', 'Calvin Klein', 'T-Shirt', 'Navy', NULL, '344354', 9.99, 13.49, 98, 9, 'lounge', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-03-03 21:19:30.423533', NULL, 0.00);
INSERT INTO public.clothing VALUES (3569, '6', 'Michael Kors', 'Shoes', 'Tan', 290, '623854', 69.99, NULL, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-03 03:14:14.211066', NULL, NULL);
INSERT INTO public.clothing VALUES (2619, '4', 'Tommy Hilfiger', 'Dress', 'Salmon', 215, '362270', 29.99, 40.54, 94, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-22 07:20:51.398692', NULL, 0.00);
INSERT INTO public.clothing VALUES (2660, '2', 'Armani Exchange', 'Blazer', 'Black', 217, '365728', 72.00, 98.10, 94, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-23 20:57:42.430127', NULL, 0.00);
INSERT INTO public.clothing VALUES (2807, '10', 'Tommy Hilfiger', 'Dress', 'Pink', NULL, '374143', 24.99, 33.74, 98, 9, 'с золотыми пуговицами', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-03 21:42:49.736573', NULL, 0.00);
INSERT INTO public.clothing VALUES (2755, 'L', 'Calvin Klein', 'T-Shirt', 'Black', 226, '394241', 12.99, 17.50, 94, 9, 'silver calvin on chest', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-01 05:55:10.358107', NULL, 0.00);
INSERT INTO public.clothing VALUES (2753, 'M', 'Calvin Klein', 'T-Shirt', 'Black', 226, '412884', 12.99, 17.50, 94, 9, 'white silver sign', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-01 05:53:56.471954', NULL, 0.00);
INSERT INTO public.clothing VALUES (2754, 'M', 'Calvin Klein', 'T-Shirt', 'White', 226, '412686', 12.99, 17.50, 94, 9, 'white sign', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-01 05:54:22.430545', NULL, 0.00);
INSERT INTO public.clothing VALUES (2756, 'M', 'Calvin Klein', 'Shorts', 'Grey', 226, '422562', 13.99, 18.84, 94, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-01 05:55:41.396889', NULL, 0.00);
INSERT INTO public.clothing VALUES (2779, 'S', 'Calvin Klein', 'T-Shirt', 'Pink', 226, '425358', 12.99, 17.50, 94, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-01 06:11:52.919054', NULL, 0.00);
INSERT INTO public.clothing VALUES (2821, '4', 'Michael Kors', 'Jeans', 'Navy', NULL, '442845', 24.99, 33.74, 98, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 01:55:47.577381', NULL, 0.00);
INSERT INTO public.clothing VALUES (2641, 'XS', 'Michael Kors', 'Sweat Pants', 'Black', 216, '450536', 29.99, 40.77, 94, 9, 'white MK stripe on sides
waist: 35
hips: 47
pasadka: 26
length: 96', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-22 07:50:21.100379', NULL, 0.00);
INSERT INTO public.clothing VALUES (910, 'S', 'Levis', 'Trucker Jacket', 'Black', 56, '5507', 0.00, NULL, 36, NULL, '', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:08.931749', NULL, NULL);
INSERT INTO public.clothing VALUES (867, 'S', 'Calvin Klein', 'Sport Bra', 'Black', 58, '579903', 6.12, 8.36, 52, 9, '80cm', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:08.510168', NULL, 0.00);
INSERT INTO public.clothing VALUES (2943, 'S', 'Tommy Hilfiger', 'Windbreaker', 'White', NULL, '866511', 29.99, 0.00, 97, 9, 'costco jacket', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-06 21:13:46.173194', NULL, 0.00);
INSERT INTO public.clothing VALUES (2490, 'N/A', 'Calvin Klein', 'Backpack', 'White, Brown', 202, '271252', 59.99, NULL, NULL, NULL, 'Brown cover

width: 25
height: 30
', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-08 01:06:39.010361', NULL, NULL);
INSERT INTO public.clothing VALUES (2861, 'S', 'Calvin Klein', 'Windbreaker', 'Silver', NULL, '899418', 16.00, 0.00, 97, 9, 'chest: 53
length: 81/87', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 05:03:47.182528', NULL, 0.00);
INSERT INTO public.clothing VALUES (2474, 'M', 'Michael Kors', 'Sweat Pants', 'White', 201, '450659', 29.99, 40.39, 94, 9, 'black mk down sides

waist: 39
hips: 52
length: 99
pasadka: 30', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-08 00:34:12.759926', NULL, 0.00);
INSERT INTO public.clothing VALUES (2760, 'XS', 'Michael Kors', 'T-Shirt', 'Black', 226, '452295', 19.99, 26.92, 94, 9, 'white misha korsov sign', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-01 05:57:40.272666', NULL, 0.00);
INSERT INTO public.clothing VALUES (2759, 'S', 'Calvin Klein', 'T-Shirt', 'White', 226, '455232', 12.99, 17.50, 94, 9, 'black silver sign', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-01 05:57:08.808782', NULL, 0.00);
INSERT INTO public.clothing VALUES (2658, '30', 'Armani Exchange', 'Jeans', 'Black', 217, '458136', 39.99, 54.49, 94, 9, 'stripe on side', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-23 20:55:58.039581', NULL, 0.00);
INSERT INTO public.clothing VALUES (2627, '4', 'Calvin Klein', 'Dress', 'Navy', 215, '462728', 24.99, 33.78, 94, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-22 07:28:37.695878', NULL, 0.00);
INSERT INTO public.clothing VALUES (2811, 'M', 'Michael Kors', 'T-Shirt', 'Grey', NULL, '525973', 9.99, 13.49, 98, 9, 'серая лонж
ПОГ 53
дл 73', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-03-03 21:49:56.473068', NULL, 0.00);
INSERT INTO public.clothing VALUES (2766, 'XL', 'Michael Kors', 'Cardigan', 'Sand, Tan', 226, '646961', 29.99, 40.39, 94, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-01 06:03:51.39866', NULL, 0.00);
INSERT INTO public.clothing VALUES (2825, 'M', 'Tommy Hilfiger', 'Skirt', 'Navy', NULL, '795163', 19.99, 26.99, 98, 9, 'ПОТ 39
ПОБ 52
Длина 81', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 02:07:08.344532', NULL, 0.00);
INSERT INTO public.clothing VALUES (2829, '6', 'Tommy Hilfiger', 'Jeans', 'Navy', NULL, '821022', 14.99, 20.24, 98, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 02:12:00.469099', NULL, 0.00);
INSERT INTO public.clothing VALUES (2828, '29', 'Calvin Klein', 'Jeans', 'Navy', NULL, '848539', 14.99, 20.24, 98, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 02:11:16.457918', NULL, 0.00);
INSERT INTO public.clothing VALUES (2816, '10', 'Karl Lagerfeld', 'Jeans', 'Navy', NULL, 'KLP004', 24.99, 0.00, 97, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 01:49:00.451944', NULL, 0.00);
INSERT INTO public.clothing VALUES (2823, 'M', 'Calvin Klein', 'Jacket', 'Blush', NULL, 'KOLck123', 17.99, 0.00, 97, 9, 'персиковый бомбер', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 02:02:40.953869', NULL, 0.00);
INSERT INTO public.clothing VALUES (2802, 'M', 'Guess', 'T-Shirt', 'White', NULL, '929878', 12.99, 17.54, 98, 9, 'red sign guess
CH 49
L 62', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-03 21:23:48.097245', NULL, 0.00);
INSERT INTO public.clothing VALUES (2470, 'S', 'Michael Kors', 'Hoodie', 'White', 201, '451700', 29.99, 64.29, 104, 23, 'Black MK, gold rivet holes

chest: 52
length: 63
arm: 71', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-08 00:29:45.377051', NULL, 0.00);
INSERT INTO public.clothing VALUES (2797, 'M', 'Calvin Klein', 'T-Shirt', 'Black', NULL, 'Ck0001', 12.99, 17.54, 98, 9, 'Ch 54
L 73', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-03-03 21:11:12.16274', NULL, 0.00);
INSERT INTO public.clothing VALUES (2363, 'M', 'Karl Lagerfeld', 'Hoodie', 'Black', 189, 'Lore7067', 29.99, 65.71, 78, 22, 'zipped

chest: 50
length: 58
arm: 60', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-31 15:27:31.780369', NULL, 0.00);
INSERT INTO public.clothing VALUES (2944, 'M', 'Tommy Hilfiger', 'Windbreaker', 'White, Navy', NULL, '866603', 29.99, 0.00, 97, 9, 'from costco', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-06 21:14:44.647766', NULL, 0.00);
INSERT INTO public.clothing VALUES (2798, 'XL', 'Calvin Klein', 'T-Shirt', 'Black', NULL, 'Ck0003', 12.99, 17.54, 98, 9, 'CK on the center', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-03-03 21:13:48.518169', NULL, 0.00);
INSERT INTO public.clothing VALUES (2758, 'S', 'Calvin Klein', 'T-Shirt', 'White', 226, 'KOJHV881', 16.99, 22.88, 94, 9, 'rhinestones', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-01 05:56:49.121947', NULL, 0.00);
INSERT INTO public.clothing VALUES (3327, 'XS', 'DKNY', 'Sweat Shirt', 'Black', 280, '183771', 29.98, NULL, 121, NULL, 'chest 51
L 64
sl 58', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-27 04:02:40.817439', NULL, NULL);
INSERT INTO public.clothing VALUES (2762, 'S', 'Karl Lagerfeld', 'Hoodie', 'Black', 226, 'LORE7067', 29.99, 40.39, 94, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-01 06:00:51.459206', NULL, 0.00);
INSERT INTO public.clothing VALUES (2900, '---', 'Tommy Hilfiger', 'Pants', '---', 228, '162674', 11.47, 15.50, 98, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 05:43:49.053837', NULL, 0.00);
INSERT INTO public.clothing VALUES (1602, 'M', 'Levis', 'T-Shirt', 'Unknown', 146, '04660M', 7.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:15.408149', NULL, NULL);
INSERT INTO public.clothing VALUES (1004, 'XS', 'Tommy Hilfiger', 'Jean Jacket', 'Blue, Navy, Red', 77, '577325', 33.59, NULL, NULL, NULL, 'with red hood

chest: 42
length: 51
arm: 61', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:09.835077', NULL, NULL);
INSERT INTO public.clothing VALUES (994, '00', 'Tommy Hilfiger', 'Pants', 'Navy', 75, '688045', 11.89, NULL, NULL, NULL, 'Waist: 39
Hips: 51
Length: 88
Pasadka: 22', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:09.746091', NULL, NULL);
INSERT INTO public.clothing VALUES (1052, 'S', 'Calvin Klein', 'T-Shirt', 'White', 84, '893226', 10.00, NULL, NULL, NULL, 'golden sign on chest', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:10.288097', NULL, NULL);
INSERT INTO public.clothing VALUES (1093, 'XS', 'Calvin Klein', 'Tank Top', 'White', 87, '491599', 12.15, NULL, NULL, NULL, 'knitted

chest: 41
length: 54', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:10.660128', NULL, NULL);
INSERT INTO public.clothing VALUES (2726, 'N/A', 'Tommy Hilfiger', 'Hat', 'Navy', 225, '521548', 9.54, NULL, 122, NULL, 'baseball cap', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-01 00:59:10.145033', NULL, 0.00);
INSERT INTO public.clothing VALUES (3412, 'One Size', 'Calvin Klein', 'Purse', 'White', NULL, '197606', 49.99, NULL, 122, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-30 03:55:20.589983', NULL, NULL);
INSERT INTO public.clothing VALUES (3486, '8', 'Armani Exchange', 'Blazer', 'Pink', 287, '4365438', 39.99, NULL, 124, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-02 21:28:00.568124', NULL, 0.00);
INSERT INTO public.clothing VALUES (3570, '8.5', 'Michael Kors', 'Shoes', 'Tan', 292, '568219003999', 39.99, NULL, 125, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-03 03:16:48.770349', NULL, NULL);
INSERT INTO public.clothing VALUES (3174, 'S', 'Calvin Klein', 'T-Shirt', 'Pink', 269, '119073', 12.99, NULL, 127, NULL, 'white calvin on chest
chest: 44
length: 63', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-20 23:41:06.156121', NULL, NULL);
INSERT INTO public.clothing VALUES (3246, '8', 'Calvin Klein', 'Dress', 'Pink', NULL, '??????', 24.99, 64.29, NULL, 22, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-21 21:53:30.734148', NULL, NULL);
INSERT INTO public.clothing VALUES (1088, '0', 'Calvin Klein', 'Shorts', 'White', 87, '927908', 14.60, NULL, NULL, NULL, 'Waist: 37
hips: 45
pasadka: 20
length: 29', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:10.615935', NULL, NULL);
INSERT INTO public.clothing VALUES (1067, '0', 'Calvin Klein', 'Shorts', 'White', 86, '927908', 11.95, NULL, NULL, NULL, 'Waist: 37
hips: 45
pasadka: 20
length: 29', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:10.426121', NULL, NULL);
INSERT INTO public.clothing VALUES (1988, 'S', 'Tommy Hilfiger', 'Golfik', 'Purple', 153, '129850', 10.00, 13.59, 56, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 11:37:27.372142', NULL, 0.00);
INSERT INTO public.clothing VALUES (1178, '10', 'Calvin Klein', 'Shorts', 'White', 101, '927953', 12.94, NULL, NULL, NULL, 'Waist: 42
Hips: 51
Length: 33
Pasadka: 25', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:11.46229', NULL, NULL);
INSERT INTO public.clothing VALUES (1290, '8', 'Michael Kors', 'Pants', 'Gold, White', 56, '652832', 8.99, NULL, NULL, NULL, 'Ross tag: 718441
Gold holes on waist

Waist: 40
Hips: 48
Length: 99
Pasadka:  25', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:12.481127', NULL, NULL);
INSERT INTO public.clothing VALUES (2896, '---', 'Tommy Hilfiger', 'Pants', '---', 228, '162728', 11.47, 15.50, 98, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 05:43:11.75116', NULL, 0.00);
INSERT INTO public.clothing VALUES (2897, '---', 'Tommy Hilfiger', 'Pants', '---', 228, '162766', 11.47, 15.50, 98, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 05:43:24.027278', NULL, 0.00);
INSERT INTO public.clothing VALUES (2901, '---', 'Tommy Hilfiger', 'Pants', '---', 228, '162797', 11.47, 15.50, 98, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 05:43:58.252449', NULL, 0.00);
INSERT INTO public.clothing VALUES (2850, 'N/A', 'Tommy Hilfiger', 'Wallet', 'Black', NULL, '239293', 14.99, 20.24, 98, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 04:55:49.157244', NULL, 0.00);
INSERT INTO public.clothing VALUES (1385, 'L', 'Calvin Klein', 'Shorts', 'Black', 125, '978694', 8.49, NULL, NULL, NULL, 'White letters on one leg

Waist: 42
Hips: 58
Length: 45
Pasadka: 32', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:13.379222', NULL, NULL);
INSERT INTO public.clothing VALUES (3175, 'L', 'Michael Kors', 'T-Shirt', 'Navy', 269, '262298', 14.99, NULL, 109, NULL, 'geometric pattern', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-20 23:42:00.365592', NULL, NULL);
INSERT INTO public.clothing VALUES (2857, 'L', 'Michael Kors', 'Windbreaker', 'Black', NULL, '273370', 49.99, 67.49, 98, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 05:00:23.925679', NULL, 0.00);
INSERT INTO public.clothing VALUES (2853, 'N/A', 'Tommy Hilfiger', 'Wallet', 'Black', NULL, '305547', 14.99, 20.24, 98, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 04:57:50.207127', NULL, 0.00);
INSERT INTO public.clothing VALUES (2846, 'XL', 'Calvin Klein', 'Windbreaker', 'Blue', NULL, '389933', 49.99, 67.49, 98, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 04:53:37.858406', NULL, 0.00);
INSERT INTO public.clothing VALUES (1603, 'M', 'Levis', 'T-Shirt', 'Unknown', 146, '04680M', 7.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:15.417294', NULL, NULL);
INSERT INTO public.clothing VALUES (1604, 'XS', 'Levis', 'Hoodie', 'Unknown', 146, '0010XS', 9.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:15.425767', NULL, NULL);
INSERT INTO public.clothing VALUES (1605, 'S', 'Levis', 'Hoodie', 'Unknown', 146, '00010S', 10.00, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:15.434975', NULL, NULL);
INSERT INTO public.clothing VALUES (1414, '2', 'Calvin Klein', 'Shorts', 'Black', 128, '928479', 7.06, NULL, NULL, NULL, 'waist: 32
hips: 48
length: 42', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:13.67511', NULL, NULL);
INSERT INTO public.clothing VALUES (2934, 'M', 'Calvin Klein', 'Dress', 'Black', NULL, '404599', 19.99, 26.99, 98, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 06:17:17.358529', NULL, 0.00);
INSERT INTO public.clothing VALUES (2865, 'L', 'Calvin Klein', 'Windbreaker', 'Red', NULL, '415120', 49.99, 67.49, 98, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 05:11:45.015443', NULL, 0.00);
INSERT INTO public.clothing VALUES (2876, 'M', 'Michael Kors', 'T-Shirt', 'White', NULL, '485697', 14.99, 20.24, 98, 9, 'michael kors inside michael kors on side
', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 05:23:20.004082', NULL, 0.00);
INSERT INTO public.clothing VALUES (835, 'XS', 'Tommy Hilfiger', 'Sweater', 'Blue', NULL, '569580', 22.00, NULL, NULL, NULL, NULL, true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.942766', NULL, NULL);
INSERT INTO public.clothing VALUES (1606, 'L', 'Levis', 'T-Shirt', 'Unknown', 147, '00300L', 7.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:15.443455', NULL, NULL);
INSERT INTO public.clothing VALUES (2902, '---', 'Tommy Hilfiger', 'Pants', '---', 228, '500515', 11.47, 15.50, 98, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 05:44:03.219594', NULL, 0.00);
INSERT INTO public.clothing VALUES (794, 'XS', 'Calvin Klein', 'Jacket', 'Black', 54, '068998', 17.61, 71.07, NULL, 19, 'double sided', true, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.604', NULL, 0.00);
INSERT INTO public.clothing VALUES (2995, 'N/A', 'Levis', 'Wallet', 'Black', NULL, '544143', 12.99, 17.54, 98, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-07 23:12:08.871258', NULL, 0.00);
INSERT INTO public.clothing VALUES (2997, 'N/A', 'Tommy Hilfiger', 'Purse', 'Navy', NULL, '644011', 22.99, 31.04, 98, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-07 23:16:07.768012', NULL, 0.00);
INSERT INTO public.clothing VALUES (2916, 'M', 'Tommy Hilfiger', 'Dress', 'Black', NULL, '738108', 19.99, 26.99, 98, 9, 'tommy jeans on chest

chest: 48
hips: 51
length: 86', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 06:00:48.773186', NULL, 0.00);
INSERT INTO public.clothing VALUES (2914, 'S', 'Tommy Hilfiger', 'Dress', 'Black', NULL, '738115', 19.99, 26.99, 98, 9, 'tommy jeans on chest

chest: 45
hips: 47
length: 85', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 05:59:41.273158', NULL, 0.00);
INSERT INTO public.clothing VALUES (2887, 'L', 'Tommy Hilfiger', 'Sweat Pants', 'Grey', NULL, '774601', 19.99, 26.99, 98, 9, 'blue large tommy hilfiger on sides

waist: 43
hips: 56
pasadka: 28
length: 95', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 05:34:39.516796', NULL, 0.00);
INSERT INTO public.clothing VALUES (2889, 'M', 'Tommy Hilfiger', 'Sweat Pants', 'Grey', NULL, '774618', 19.99, 26.99, 98, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 05:35:43.680148', NULL, 0.00);
INSERT INTO public.clothing VALUES (2883, 'M', 'Tommy Hilfiger', 'Sweat Pants', 'Black', NULL, '774656', 19.99, 26.99, 98, 9, 'large tommy hilfiger on sides

waist: 40
hips: 53
pasadka: 25
length: 92
', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 05:30:56.130506', NULL, 0.00);
INSERT INTO public.clothing VALUES (2888, 'M', 'Tommy Hilfiger', 'Hoodie', 'Grey', NULL, '774731', 24.99, 33.74, 98, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 05:35:19.071017', NULL, 0.00);
INSERT INTO public.clothing VALUES (2881, 'M', 'Tommy Hilfiger', 'Hoodie', 'Black', NULL, '774779', 24.99, 33.74, 98, 9, 'large tommy hilfiger on sides
oversized

chest: 55
length: 64
arm: 63', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 05:29:46.918554', NULL, 0.00);
INSERT INTO public.clothing VALUES (2923, 'S', 'Tommy Hilfiger', 'T-Shirt', 'White', NULL, '808436', 12.99, 17.54, 98, 9, 'with a navy/red flag
', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 06:04:56.981983', NULL, 0.00);
INSERT INTO public.clothing VALUES (3488, 'XL', 'Armani Exchange', 'Sherpa', 'Navy', 287, '0369463', 49.99, NULL, 120, NULL, NULL, NULL, 'men', NULL, NULL, NULL, 'usa', '2021-04-02 21:31:22.394617', NULL, 0.00);
INSERT INTO public.clothing VALUES (2992, '8', 'Tommy Hilfiger', 'Flip Flops', 'Black', 231, '810414', 12.99, 17.50, 98, 9, 'c золотым кружочком
через палец
стелька 25 см', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-07 01:16:05.494758', NULL, 0.00);
INSERT INTO public.clothing VALUES (2848, '11', 'Tommy Hilfiger', 'Flip Flops', 'Navy', NULL, '817147', 16.99, 22.94, 98, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 04:54:59.679648', NULL, 0.00);
INSERT INTO public.clothing VALUES (2868, 'M', 'Calvin Klein', 'Dress', 'Green', NULL, '833771', 19.99, 26.99, 98, 9, '3d ck
chest: 47
hips: 51
length: 93', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 05:13:24.973294', NULL, 0.00);
INSERT INTO public.clothing VALUES (2854, '10', 'Michael Kors', 'Jeans', 'Black', NULL, '834962', 20.00, 27.00, 98, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 04:58:23.414251', NULL, 0.00);
INSERT INTO public.clothing VALUES (2849, 'N/A', 'Tommy Hilfiger', 'Wallet', 'Navy', NULL, '887685', 12.99, 17.54, 98, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 04:55:31.452221', NULL, 0.00);
INSERT INTO public.clothing VALUES (2878, 'XL', 'Michael Kors', 'Sweat Shirt', 'Black', NULL, '937854', 24.00, 32.40, 98, 9, 'metal MK', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 05:25:27.299157', NULL, 0.00);
INSERT INTO public.clothing VALUES (2931, 'L', 'Karl Lagerfeld', 'T-Shirt', 'White', NULL, 'LOORH6009', 16.99, 22.94, 98, 9, 'flower letters + eiffel tower', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 06:12:15.82893', NULL, 0.00);
INSERT INTO public.clothing VALUES (2932, 'XL', 'Karl Lagerfeld', 'T-Shirt', 'White', NULL, 'LOORH6009', 16.99, 22.94, 98, 9, 'flower letters + eiffel tower', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 06:12:19.810544', NULL, 0.00);
INSERT INTO public.clothing VALUES (2927, 'XL', 'Karl Lagerfeld', 'T-Shirt', 'Peach, Coral, Pink', NULL, 'LORH0030', 16.99, 22.94, 98, 9, 'rhinestones', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 06:10:48.689926', NULL, 0.00);
INSERT INTO public.clothing VALUES (2926, 'S', 'Karl Lagerfeld', 'T-Shirt', 'Peach, Coral, Pink', NULL, 'LORH0030', 16.99, 22.94, 98, 9, 'rhinestones', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 06:10:28.038573', NULL, 0.00);
INSERT INTO public.clothing VALUES (3571, '8.5', 'Michael Kors', 'Shoes', 'Tan', 292, '623854006999', 69.99, NULL, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-03 03:17:31.753764', NULL, NULL);
INSERT INTO public.clothing VALUES (3644, 'L', 'Tommy Hilfiger', 'Windbreaker', 'Green', 295, '821190', 39.99, NULL, NULL, NULL, 'Hooded
Double zipper
Chest: 55
Length: 80
Arm: 63', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-07 19:44:24.277349', NULL, NULL);
INSERT INTO public.clothing VALUES (3413, 'XS', 'DKNY', 'Sweat Shirt', 'White', NULL, '196290', 19.93, NULL, 121, NULL, 'с девочкой в юбке', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-30 04:38:39.725919', NULL, NULL);
INSERT INTO public.clothing VALUES (3328, '0', 'DKNY', 'Skirt', 'Black', 280, '127591', 29.98, NULL, 121, NULL, 'waist 36
hips 51
L 69-84127591
', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-27 04:05:02.341058', NULL, NULL);
INSERT INTO public.clothing VALUES (3487, '6', 'Armani Exchange', 'Blazer', 'Pink', 287, '4365421', 39.99, NULL, 124, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-02 21:29:00.104051', NULL, NULL);
INSERT INTO public.clothing VALUES (2560, 'S', 'Calvin Klein', 'Panties', 'Orange', 208, '098011', 3.00, 0.00, 92, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-15 04:39:37.821568', NULL, 0.00);
INSERT INTO public.clothing VALUES (3414, 'M', 'DKNY', 'Sweat Shirt', 'White', NULL, '196276', 19.93, NULL, 122, NULL, 'с девочкой в юбке', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-30 04:38:58.843631', NULL, 0.00);
INSERT INTO public.clothing VALUES (2747, 'S', 'Tommy Hilfiger', 'Hoodie', 'Blue', 225, '003966', 25.19, 0.00, 92, 9, 'blue mesh
chest: 50
length: 56
arm: 64', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-01 01:21:29.850047', NULL, 0.00);
INSERT INTO public.clothing VALUES (1615, 'M', 'Levis', 'T-Shirt', 'White', 147, '343119', 7.99, NULL, 119, NULL, 'levis flag', NULL, 'men', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:15.523525', NULL, 0.00);
INSERT INTO public.clothing VALUES (3247, 'XS', 'Tommy Hilfiger', 'Sweat Shirt', 'Red, Navy, Green, Yellow', NULL, '??????', 19.99, 48.21, NULL, 22, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-21 22:02:01.307764', NULL, NULL);
INSERT INTO public.clothing VALUES (1634, '34', 'Calvin Klein', 'Shorts', 'White, Cream', 125, '996102', 8.49, NULL, 114, NULL, 'waist: 44
hips: 53
pasadka: 30
length: 48', NULL, 'men', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:15.694129', NULL, 0.00);
INSERT INTO public.clothing VALUES (2630, 'N/A', 'Tommy Hilfiger', 'Wallet', 'Black', 215, '???', 14.99, 20.26, 91, 9, 'silver square metal logo', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-22 07:33:42.254917', NULL, 0.00);
INSERT INTO public.clothing VALUES (1030, '6', 'Tommy Hilfiger', 'Jeans', 'Navy', 81, '411193', 15.99, NULL, NULL, NULL, 'waist: 41
hips: 48
pasadka: 25
length: 88', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:10.076767', NULL, NULL);
INSERT INTO public.clothing VALUES (983, 'S', 'Tommy Hilfiger', 'Sport Bra', 'Light Blue, Navy, White', 72, '733257', 8.49, NULL, NULL, NULL, 'go with 768785', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:09.632307', NULL, NULL);
INSERT INTO public.clothing VALUES (2533, 'S', 'Calvin Klein', 'No Fleece Cold Pants', 'Black', 205, '473618', 19.99, NULL, 117, NULL, 'white calvin klein jeans on  calf

waist: 37
hips: 47
pasadka: 25
length: 95', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-13 02:46:35.146392', NULL, NULL);
INSERT INTO public.clothing VALUES (955, 'XS', 'Calvin Klein', 'Tank Top', 'Black', 69, '491490', 8.41, NULL, NULL, NULL, 'Chest: 38
Waist: 38
Length: 52', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:09.360194', NULL, NULL);
INSERT INTO public.clothing VALUES (1612, 'L', 'Levis', 'T-Shirt', 'Unknown', 147, '01970L', 7.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:15.496675', NULL, NULL);
INSERT INTO public.clothing VALUES (2223, 'M', 'Juicy Coture', 'Belt', 'Gold', NULL, '??????', 9.99, NULL, NULL, NULL, 'metallic', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-01-21 17:56:37.58235', NULL, NULL);
INSERT INTO public.clothing VALUES (1613, 'M', 'Levis', 'T-Shirt', 'Unknown', 147, '00410M', 7.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:15.505437', NULL, NULL);
INSERT INTO public.clothing VALUES (1614, 'M', 'Levis', 'T-Shirt', 'Unknown', 147, '00410M', 7.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:15.515266', NULL, NULL);
INSERT INTO public.clothing VALUES (3176, '8.5', 'Tommy Hilfiger', 'Shoes', 'White', 269, 'THS001', 24.99, NULL, 118, NULL, 'Sandals
gold circle', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-20 23:43:41.460386', NULL, NULL);
INSERT INTO public.clothing VALUES (1616, 'M', 'Levis', 'T-Shirt', 'Unknown', 147, '00420M', 7.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:15.533009', NULL, NULL);
INSERT INTO public.clothing VALUES (1617, 'M', 'Levis', 'T-Shirt', 'Unknown', 147, '00420M', 7.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:15.541423', NULL, NULL);
INSERT INTO public.clothing VALUES (878, 'M', 'Calvin Klein', 'Boxers', 'Black', 58, '759660', 7.22, 9.19, NULL, 10, '3 pair
Sold to other seller', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:08.61147', NULL, NULL);
INSERT INTO public.clothing VALUES (882, 'L', 'Calvin Klein', 'Boxers', 'Black, White, Grey', 58, '55549', 6.71, 8.54, NULL, 10, 'Sold to other seller', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:08.647967', NULL, NULL);
INSERT INTO public.clothing VALUES (890, '???', 'Calvin Klein', 'Man Panties', 'Black', 58, '9864', 7.22, 9.19, NULL, 10, 'Sold to other seller', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:08.725031', NULL, NULL);
INSERT INTO public.clothing VALUES (945, 'N/A', 'Tommy Hilfiger', 'Wallet', 'Black', 67, '629322', 14.99, 18.73, NULL, 10, 'Ross Tag: 188295', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:09.268995', NULL, NULL);
INSERT INTO public.clothing VALUES (3645, 'S', 'Tommy Hilfiger', 'Windbreaker', 'Green', 295, '821213', 39.99, NULL, 123, NULL, 'Hooded
Double zipper
Chest: 48
Length: 78
Arm: 61', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-07 19:46:21.302675', NULL, NULL);
INSERT INTO public.clothing VALUES (946, 'N/A', 'Tommy Hilfiger', 'Wallet', 'Black', 67, '629322', 14.99, 18.73, NULL, 10, 'Ross tag:  188295', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:09.278709', NULL, NULL);
INSERT INTO public.clothing VALUES (947, 'N/A', 'Tommy Hilfiger', 'Wallet', 'Black', 67, '239323', 14.99, 18.73, NULL, 10, 'Ross tag:  188202', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:09.287185', NULL, NULL);
INSERT INTO public.clothing VALUES (836, 'XS', 'Tommy Hilfiger', 'Sweater', 'Blue', NULL, '728659', 0.00, NULL, NULL, NULL, NULL, true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.949749', NULL, NULL);
INSERT INTO public.clothing VALUES (1618, 'M', 'Levis', 'T-Shirt', 'Unknown', 147, '00460M', 7.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:15.551092', NULL, NULL);
INSERT INTO public.clothing VALUES (1619, 'M', 'Levis', 'T-Shirt', 'Unknown', 147, '00460M', 8.02, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:15.559603', NULL, NULL);
INSERT INTO public.clothing VALUES (253, 'M', 'Calvin Klein', 'Sweat Shirt', 'White', NULL, '488739', 24.99, NULL, 18, NULL, 'CK pattern down arms

Chest: 54
Waist: 51
Length: 70
Arm: 66', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:55.871186', NULL, 0.00);
INSERT INTO public.clothing VALUES (1631, '???', 'Calvin Klein', 'unknown', 'Unknown', 125, '850567', 8.49, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:15.66555', NULL, NULL);
INSERT INTO public.clothing VALUES (948, 'N/A', 'Levis', 'Wallet', 'Black', 67, '255774', 12.99, 16.23, NULL, 10, 'Ross tag:  665324', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:09.296882', NULL, NULL);
INSERT INTO public.clothing VALUES (1834, 'S', 'Levis', 'Bodysuit', 'Red', NULL, '197596', 4.00, NULL, NULL, NULL, 'chest: 37
length: 69', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-26 08:16:23.824073', NULL, NULL);
INSERT INTO public.clothing VALUES (1007, 'XS', 'Tommy Hilfiger', 'Shorts', 'Navy', 77, '787137', 23.99, NULL, NULL, NULL, 'waist: 36
hips: 49
length: 30
pasadka: 25', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:09.862305', NULL, NULL);
INSERT INTO public.clothing VALUES (193, 'L', 'Tommy Hilfiger', 'Puffy Jacket', 'Black', NULL, '184064', 69.99, 139.51, NULL, 15, 'sold for 3990
delivery: $5
Furry hood lining

Chest: 59
Waist: 54
Length: 85
Arm: 65', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:55.35615', NULL, NULL);
INSERT INTO public.clothing VALUES (259, 'L', 'Calvin Klein', 'Sweat Pants', 'Red', NULL, '790111', 19.99, 54.20, NULL, 13, 'Calvin Klein on bottom half of leg

sold for 3100
sold with 789833

Waist: 47
Hips: 53
Length: 96
Pasadka: 27', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:55.917823', NULL, NULL);
INSERT INTO public.clothing VALUES (2650, 'L', 'Armani Exchange', 'Sweat Pants', 'Blue', 217, '776745', 29.99, 40.86, 94, 9, 'waist: 45
hips: 56
pasadka: 32
length: 108', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-23 20:48:51.239087', NULL, 0.00);
INSERT INTO public.clothing VALUES (397, 'L', 'Calvin Klein', 'Sweat Shirt', 'Black', NULL, '596854', 24.99, NULL, NULL, NULL, 'grey logo on chest

chest: 57
length: 71
arm: 69', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.140789', NULL, NULL);
INSERT INTO public.clothing VALUES (576, 'S', 'Calvin Klein', 'Sweat Pants', 'Black', 36, '785414', 14.88, 48.95, NULL, 16, 'sold for 1400
stripe + "calvin" on stripe

waist: 37
hips: 47
length: 92
pasadka: 24', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.699163', NULL, NULL);
INSERT INTO public.clothing VALUES (2541, 'XS', 'Michael Kors', 'Sweat Pants', 'Black', 207, '450536', 29.99, NULL, 104, NULL, 'white MK stripe on sides
waist: 35
hips: 47
pasadka: 26
length: 96', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-15 04:17:12.245477', NULL, 0.00);
INSERT INTO public.clothing VALUES (3329, '6', 'DKNY', 'Skirt', 'Black', 280, '127539', 29.98, NULL, 121, NULL, 'waist 38
hips 57
L 71-86
', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-27 04:06:14.678141', NULL, NULL);
INSERT INTO public.clothing VALUES (588, 'L', 'Calvin Klein', 'Gloves', 'Black', 36, '543084', 8.92, 39.29, NULL, 23, 'leather', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.79948', NULL, NULL);
INSERT INTO public.clothing VALUES (3572, 'M', 'Calvin Klein', 'Dress', 'Black', 292, '402601', 19.99, NULL, NULL, NULL, 'с полоской по плечу
ПОГ 48
ПОБ 51
дл 90', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-03 03:19:26.750095', NULL, NULL);
INSERT INTO public.clothing VALUES (2173, 'XS', 'Calvin Klein', 'T-Shirt', 'White', 168, '801473', 12.74, 0.00, 67, 9, 'Oversized
payetki sign

chest: 47
length: 50', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-21 16:56:46.409931', NULL, 0.00);
INSERT INTO public.clothing VALUES (1635, '34', 'Calvin Klein', 'Shorts', 'Navy', 125, '850543', 8.49, NULL, 114, NULL, 'Jean shorts
waist: 44
hips: 55
pasadka: 31
length: 50', NULL, 'men', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:15.703297', NULL, 0.00);
INSERT INTO public.clothing VALUES (2604, 'S', 'Tommy Hilfiger', 'Sweat Shirt', 'White', 214, '013521', 31.49, 53.57, 105, 22, 'circle logo
chest: 50
length: 59
arm: 60', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-22 06:44:06.425907', NULL, 0.00);
INSERT INTO public.clothing VALUES (3177, 'M', 'Calvin Klein', 'Belt', 'Black', 269, '237865', 14.99, NULL, 114, NULL, 'CK metal buckle
reversible
length: 102
width: 3', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-20 23:44:46.116535', NULL, NULL);
INSERT INTO public.clothing VALUES (2303, 'S', 'Tommy Hilfiger', 'Windbreaker', 'Navy', 183, '405614', 23.99, NULL, 114, NULL, 'Chest: 55
length: 75
arm from neck:  79', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-01-26 15:45:51.123106', NULL, NULL);
INSERT INTO public.clothing VALUES (2542, 'S', 'Michael Kors', 'Sweat Pants', 'Black', 207, '450543', 29.99, 64.29, NULL, 22, 'white MK stripe on sides
waist: 36
hips: 50
pasadka: 28
length: 99', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-15 04:18:13.162681', NULL, 0.00);
INSERT INTO public.clothing VALUES (2347, 'N/A', 'Calvin Klein', 'Wallet', 'Black', 187, '734519', 9.99, NULL, 114, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-01-31 15:07:41.199339', NULL, 0.00);
INSERT INTO public.clothing VALUES (784, 'S', 'Calvin Klein', 'Hoodie', 'White', 53, '962075', 14.88, 39.29, NULL, 22, 'oversized
cropped
big black payetki sign', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.509998', NULL, NULL);
INSERT INTO public.clothing VALUES (788, 'M', 'Calvin Klein', 'Sweat Shirt', 'Red', 53, '789833', 16.62, 54.20, NULL, 13, 'sold with 790111', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.543672', NULL, NULL);
INSERT INTO public.clothing VALUES (1636, '???', 'Calvin Klein', 'unknown', 'Unknown', 125, '794883', 8.49, NULL, 116, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:15.7118', NULL, NULL);
INSERT INTO public.clothing VALUES (2167, 'XS', 'Calvin Klein', 'Dress Shirt', 'White', 168, '494675', 8.49, NULL, 110, NULL, 'Female
Split back

Chest: 47
Waist: 47
Length: 73
Arm: 61', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-01-21 16:52:14.599824', NULL, 0.00);
INSERT INTO public.clothing VALUES (2626, 'L', 'Calvin Klein', 'Sweat Pants', 'Pink', 215, '445387', 19.99, NULL, 111, NULL, 'white letters', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-22 07:27:46.648976', NULL, 0.00);
INSERT INTO public.clothing VALUES (3248, 'M', 'Calvin Klein', 'Pants', 'White', 276, '436595002299', 22.99, NULL, 112, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-23 00:37:04.846578', NULL, 0.00);
INSERT INTO public.clothing VALUES (2168, 'XS', 'Calvin Klein', 'Flying Blouse', 'White', 168, '483211', 8.49, NULL, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-01-21 16:53:03.646117', NULL, 0.00);
INSERT INTO public.clothing VALUES (1639, 'M', 'Calvin Klein', 'Hoodie', 'Pink', 125, '351466', 8.49, NULL, 121, NULL, 'sleeveless
chest: 58
length: 52', NULL, 'women', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:15.738468', NULL, 0.00);
INSERT INTO public.clothing VALUES (1640, '???', 'Calvin Klein', 'unknown', 'Unknown', 125, '794883', 8.49, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:15.747721', NULL, NULL);
INSERT INTO public.clothing VALUES (2603, 'XS', 'Tommy Hilfiger', 'Sweat Shirt', 'Mint', 214, '013163', 31.49, 53.57, 105, 22, 'circle logo
chest: 48
length: 60
arm: 59', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-22 06:43:17.564896', NULL, 0.00);
INSERT INTO public.clothing VALUES (1642, 'L', 'Calvin Klein', 'Long sleeved shirt', 'White', 125, '794951', 8.49, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:15.765567', NULL, NULL);
INSERT INTO public.clothing VALUES (1660, '2', 'Lee', 'Jeans', 'Navy', 56, '810763', 12.99, NULL, NULL, NULL, 'Waist: 36
Hips: 45
Length: 95
Pasadka: 23', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:15.935824', NULL, NULL);
INSERT INTO public.clothing VALUES (1661, 'N/A', 'Alex Marie', 'Boots', 'Black', 56, '???', 0.00, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:15.949668', NULL, NULL);
INSERT INTO public.clothing VALUES (984, 'S', 'Tommy Hilfiger', 'T-Shirt', 'White', 73, '034002', 12.14, NULL, NULL, NULL, 'v-neck
stripe on shoulder', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:09.641631', NULL, NULL);
INSERT INTO public.clothing VALUES (985, 'S', 'Tommy Hilfiger', 'Polo Shirt', 'White', 73, '567937', 13.49, NULL, NULL, NULL, 'half polo v-neck', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:09.650855', NULL, NULL);
INSERT INTO public.clothing VALUES (1010, 'XS', 'Tommy Hilfiger', 'Polo Shirt', 'White', 77, '329719', 11.99, NULL, NULL, NULL, 'letters on chest', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:09.890252', NULL, NULL);
INSERT INTO public.clothing VALUES (1785, 'M', 'Calvin Klein', 'Dress', 'Black', NULL, '809868', 19.99, NULL, NULL, NULL, 'sparkly overlined and underlined "calvin klein" on chest', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-25 02:52:06.711626', NULL, NULL);
INSERT INTO public.clothing VALUES (1786, 'M', 'Calvin Klein', 'Dress', 'Lemon', NULL, '815876', 19.99, NULL, NULL, NULL, NULL, true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-25 02:54:19.027599', NULL, NULL);
INSERT INTO public.clothing VALUES (1079, 'S', 'Calvin Klein', 'T-Shirt', 'White', 86, '860982', 10.04, NULL, NULL, NULL, 'black / grey logo sign', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:10.535832', NULL, NULL);
INSERT INTO public.clothing VALUES (1053, 'XXS', 'Calvin Klein', 'T-Shirt', 'White', 84, '460946', 13.99, NULL, NULL, NULL, 'v-neck 
blue heart', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:10.297598', NULL, NULL);
INSERT INTO public.clothing VALUES (1083, 'XS', 'Calvin Klein', 'T-Shirt', 'White', 86, '668052', 10.04, NULL, NULL, NULL, 'silver black sign', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:10.57116', NULL, NULL);
INSERT INTO public.clothing VALUES (785, 'XS', 'Calvin Klein', 'Sweater', 'Black', 53, '986293', 8.76, 53.57, NULL, 19, 'green/white line on sleeve with words "calvin klein" inside.', true, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.518953', NULL, 0.00);
INSERT INTO public.clothing VALUES (1035, 'M', 'Tommy Hilfiger', 'T-Shirt', 'Lemon', 83, '575260', 11.99, NULL, NULL, NULL, 'Chest: 47
Waist: 46
Length: 61
', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:10.128691', NULL, NULL);
INSERT INTO public.clothing VALUES (1084, 'XS', 'Calvin Klein', 'T-Shirt', 'White', 86, '668052', 10.04, NULL, NULL, NULL, 'silver black sign', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:10.579792', NULL, NULL);
INSERT INTO public.clothing VALUES (1787, 'M', 'Calvin Klein', 'Dress', 'Deep Seawave', NULL, '821938', 19.99, NULL, NULL, NULL, 'gold buttons
3d CK on chest', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-25 02:57:21.544615', NULL, NULL);
INSERT INTO public.clothing VALUES (1788, 'M', 'Calvin Klein', 'Dress', 'Deep Seawave', NULL, '810277', 19.99, NULL, NULL, NULL, 'white stripe across chest', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-25 02:58:44.9391', NULL, NULL);
INSERT INTO public.clothing VALUES (1789, 'M', 'DKNY', 'Dress', 'Black', NULL, 'AH1CJJ', 15.00, NULL, NULL, NULL, 'metal dots spelling dkny', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-25 03:04:19.318783', NULL, NULL);
INSERT INTO public.clothing VALUES (3415, '0', 'Levis', 'Jeans', 'Navy', 285, '274009', 19.99, NULL, NULL, NULL, 'с высокой посадкой присобраный пояс
ПОТ 32-36
ПОБ 45
дл 100
пос 34', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-30 20:56:12.607495', NULL, NULL);
INSERT INTO public.clothing VALUES (1638, 'M', 'Calvin Klein', 'Shorts', 'Pink', 125, '350193', 8.49, NULL, NULL, NULL, 'waist: 40
hips: 52
pasadka: 28
length: 51', NULL, 'women', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:15.729926', NULL, 0.00);
INSERT INTO public.clothing VALUES (1637, '4', 'Calvin Klein', 'Shorts', 'Blue', 125, '928721', 8.49, NULL, 119, NULL, 'light blue linen', NULL, 'women', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:15.720942', NULL, 0.00);
INSERT INTO public.clothing VALUES (3489, 'L', 'Armani Exchange', 'Puffy Jacket', 'Black', 287, '4991897', 49.99, NULL, NULL, NULL, NULL, NULL, 'men', NULL, NULL, NULL, 'usa', '2021-04-02 21:33:06.577317', NULL, NULL);
INSERT INTO public.clothing VALUES (3646, 'XS', 'Tommy Hilfiger', 'Windbreaker', 'Black', 295, '821299', 40.00, NULL, NULL, NULL, 'Hooded
Double zipper
Chest: 47
Length: 74
Arm: 61', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-07 19:49:41.833541', NULL, NULL);
INSERT INTO public.clothing VALUES (3573, 'S', 'Michael Kors', 'T-Shirt', 'Black', 292, '630403', 19.99, NULL, 127, NULL, 'с замком на груди
ПОГ 44
дл 62', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-03 03:21:12.269992', NULL, NULL);
INSERT INTO public.clothing VALUES (2651, '4', 'Armani Exchange', 'Skirt', 'Black, Purple, Seawave', 217, '329917', 19.99, 27.24, 94, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-23 20:50:19.651525', NULL, 0.00);
INSERT INTO public.clothing VALUES (3416, '2', 'Levis', 'Jeans', 'Navy', 285, '274016', 19.99, NULL, 119, NULL, 'с высокой посадкой присобраный пояс
ПОТ 32-37
ПОБ 47
дл 100
пос 34', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-30 20:57:42.517626', NULL, NULL);
INSERT INTO public.clothing VALUES (845, 'L', 'Karl Lagerfeld', 'T-Shirt', 'Black', NULL, 'RH0024', 8.49, 32.14, NULL, 22, 'golden head', true, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:01.016905', NULL, 0.00);
INSERT INTO public.clothing VALUES (3249, 'S', 'Calvin Klein', 'Pants', 'White', 276, '436595002299', 22.99, NULL, 112, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-23 00:37:17.927618', NULL, 0.00);
INSERT INTO public.clothing VALUES (2632, 'N/A', 'Tommy Hilfiger', 'Wallet', 'Black', 215, '425832', 14.99, NULL, 114, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-22 07:34:53.953379', NULL, 0.00);
INSERT INTO public.clothing VALUES (573, '1SZ', 'Calvin Klein', 'Scarf', 'Olive', 36, '562764', 8.92, NULL, NULL, NULL, NULL, true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.671258', NULL, NULL);
INSERT INTO public.clothing VALUES (2077, '26', 'Calvin Klein', 'Jeans', 'Navy', NULL, '017379', 14.99, 20.24, 61, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-13 11:41:19.487273', NULL, 4.93);
INSERT INTO public.clothing VALUES (131, 'S', 'Calvin Klein', 'Sweat Shirt', 'Black', 15, '084135', 30.35, NULL, NULL, NULL, 'White outlined black stripe with "cavin klein ck" across chest

Chest: 57
Waist: 48
Length: 43
Arm: 43', true, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.808261', NULL, 0.00);
INSERT INTO public.clothing VALUES (1034, 'L', 'Tommy Hilfiger', 'Polo Shirt', 'White', 83, '329740', 11.99, NULL, NULL, NULL, 'letters on chest', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:10.113158', NULL, NULL);
INSERT INTO public.clothing VALUES (1094, 'L', 'Calvin Klein', 'Sport Bra', 'Black', 87, '662861', 8.83, NULL, NULL, NULL, NULL, true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:10.671461', NULL, NULL);
INSERT INTO public.clothing VALUES (1790, 'S', 'Calvin Klein', 'T-Shirt', 'Red', NULL, '464317', 7.00, NULL, NULL, NULL, 'Gold square on chest', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-25 04:26:54.572859', NULL, NULL);
INSERT INTO public.clothing VALUES (1791, 'XS', 'Calvin Klein', 'T-Shirt', 'Black', NULL, '599288', 6.72, NULL, NULL, NULL, 'White + yellow letters

Chest: 46
Waist: 46
Length: 43', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-25 04:28:56.181746', NULL, NULL);
INSERT INTO public.clothing VALUES (173, 'XS', 'Tommy Hilfiger', 'Sweater', 'White', 18, '728376', 10.39, NULL, NULL, NULL, 'V neck
Diamond pattern

Chest: 41
Waist: 38
Length: 60
Arm: 60', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:55.186197', NULL, NULL);
INSERT INTO public.clothing VALUES (205, 'S', 'Calvin Klein', 'Sweater', 'Pink', NULL, '954827', 24.99, NULL, NULL, NULL, 'Long neck
Belly pocket
"Calvin" across chest

Chest: 47
Waist: 41
Length: 67
Arm: 66', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:55.463787', NULL, NULL);
INSERT INTO public.clothing VALUES (206, '1SZ', 'Calvin Klein', 'Scarf', 'Grey, Green, Navy', 34, '377984', 9.99, NULL, NULL, NULL, NULL, true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:55.472406', NULL, NULL);
INSERT INTO public.clothing VALUES (254, 'L', 'Calvin Klein', 'Hoodie', 'Black', NULL, '893885', 29.99, NULL, NULL, NULL, 'White parallel lines across chest with "calvin klein" between them

Chest: 58
Waist: 56
Length: 69
Arm: 68', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:55.878781', NULL, NULL);
INSERT INTO public.clothing VALUES (361, '1SZ', 'Calvin Klein', 'Scarf', 'Black', 29, '562757', 12.10, NULL, NULL, NULL, 'yarn scarf', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.820825', NULL, NULL);
INSERT INTO public.clothing VALUES (406, 'M', 'Juicy Coture', 'Puffy Jacket', 'Black', NULL, '361125', 49.99, NULL, NULL, NULL, 'short

Chest: 61
Length: 61
Arm: 49/72', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.20949', NULL, NULL);
INSERT INTO public.clothing VALUES (463, 'XS', 'Calvin Klein', 'Hoodie Dress', 'Black', 34, '427833', 23.27, NULL, NULL, NULL, 'white logo sign on chest

chest: 48
length: 82
arm: 62', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.715588', NULL, NULL);
INSERT INTO public.clothing VALUES (477, 'L', 'Calvin Klein', 'Sweat Pants', 'White', 37, '298178', 10.53, NULL, NULL, NULL, 'waist: 45
hips: 57/58
length: 108
pasadka: 31', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.83308', NULL, NULL);
INSERT INTO public.clothing VALUES (478, 'L', 'Calvin Klein', 'Hoodie', 'White', 37, '252811', 8.78, NULL, NULL, NULL, 'chest: 58
length: 71
arm: 68', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.841737', NULL, NULL);
INSERT INTO public.clothing VALUES (3574, 'XS', 'Michael Kors', 'T-Shirt', 'White', 292, '452745', 19.99, NULL, NULL, NULL, 'с замком на груди
ПОГ 43
дл 60', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-03 03:22:16.54026', NULL, NULL);
INSERT INTO public.clothing VALUES (464, '1SZ', 'Calvin Klein', 'Scarf', 'Grey, Black', NULL, '586370', 11.70, NULL, NULL, NULL, 'logo pattern
rounded/closed', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.723865', NULL, NULL);
INSERT INTO public.clothing VALUES (1187, 'S', 'Calvin Klein', 'T-Shirt', 'Black', 104, '599325', 7.90, NULL, NULL, NULL, 'Gold CK, white letters on front', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:11.543315', NULL, NULL);
INSERT INTO public.clothing VALUES (2089, 'S', 'Calvin Klein', 'Sweat Pants', 'Black', NULL, '941582', 35.70, NULL, NULL, NULL, 'waist: 39
hips: 47
pasadka: 23
length: 93', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-01-13 12:01:13.011453', NULL, NULL);
INSERT INTO public.clothing VALUES (514, '1SZ', 'Calvin Klein', 'Scarf', 'Grey', 38, '351572', 21.56, NULL, NULL, NULL, 'looks more white', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.159316', NULL, NULL);
INSERT INTO public.clothing VALUES (2003, 'XS', 'Calvin Klein', 'Sweat Shirt', 'Black', 154, '888979', 14.05, 18.92, 56, 9, 'rhinestones', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 11:57:21.755216', NULL, 0.00);
INSERT INTO public.clothing VALUES (517, '1SZ', 'Calvin Klein', 'Scarf', 'Grey', 38, '461288', 12.32, NULL, NULL, NULL, NULL, true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.184963', NULL, NULL);
INSERT INTO public.clothing VALUES (575, 'S', 'Calvin Klein', 'Hoodie', 'Black', 36, '962129', 14.88, NULL, NULL, NULL, 'oversized
cropped
big black payetki sign', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.68803', NULL, NULL);
INSERT INTO public.clothing VALUES (587, '1SZ', 'Calvin Klein', 'Hat', 'Grey', 36, '555773', 8.92, NULL, NULL, NULL, 'beanie cap', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.790743', NULL, NULL);
INSERT INTO public.clothing VALUES (703, 'XS', 'Tommy Hilfiger', 'Sweater', 'White', 42, '653763', 17.49, NULL, NULL, NULL, 'knitted
V-neck
vyazeny ko-seey

Chest: 43
length: 59
arm: 62', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.818178', NULL, NULL);
INSERT INTO public.clothing VALUES (719, 'XXS', 'Tommy Hilfiger', 'Sweater', 'White', 46, '653756', 17.49, NULL, NULL, NULL, 'knitted
v-neck

Chest: 41
length: 58
arm: 56', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.946938', NULL, NULL);
INSERT INTO public.clothing VALUES (1793, 'M', 'Levis', 'T-Shirt', 'White', NULL, '219945', 6.99, NULL, 119, NULL, 'men
horses sign on chest

chest: 50
length: 70', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-25 07:08:01.880976', NULL, NULL);
INSERT INTO public.clothing VALUES (3647, 'M', 'Tommy Hilfiger', 'Windbreaker', 'Black', 295, '821275', 39.99, NULL, 123, NULL, 'Hooded
Double zipper
Chest: 50
Length: 79
Arm: 62', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-07 19:52:31.201671', NULL, NULL);
INSERT INTO public.clothing VALUES (725, 'S', 'Tommy Hilfiger', 'Puffy Jacket', 'Navy, Red, White', NULL, '994122', 59.99, NULL, NULL, NULL, 'navy top
white center
red bottom

chest: 48
length: 58
arm: 68', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.994692', NULL, NULL);
INSERT INTO public.clothing VALUES (723, 'XS', 'DKNY', 'Sweater', 'White', NULL, '183047', 19.99, 41.95, NULL, NULL, 'squared DKNY pattern everywhere

chest: 54
length: 54
arm: 48/67', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.97887', NULL, NULL);
INSERT INTO public.clothing VALUES (763, '1SZ', 'Calvin Klein', 'Hat', 'Black', 51, '562788', 2.32, NULL, NULL, NULL, 'beanie cap', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.322808', NULL, NULL);
INSERT INTO public.clothing VALUES (806, 'S', 'Calvin Klein', 'Hoodie', 'Black', NULL, '826773', 29.99, NULL, NULL, NULL, 'white letters', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.704739', NULL, NULL);
INSERT INTO public.clothing VALUES (2633, 'S', 'Calvin Klein', 'Sweat Pants', 'Black', 215, '749607', 19.99, NULL, NULL, NULL, 'non-sewn waist
long calvin klein sign', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-22 07:36:11.928436', NULL, NULL);
INSERT INTO public.clothing VALUES (3178, 'N/A', 'DKNY', 'Backpack', 'Black', 269, '076339', 49.99, NULL, 127, NULL, '27 X 29 X 11', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-20 23:45:28.076579', NULL, NULL);
INSERT INTO public.clothing VALUES (3331, 'M', 'Calvin Klein', 'Sport Bra', 'Black', 281, '454268', 6.99, NULL, 121, NULL, 'velurovie', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-27 04:10:28.441095', NULL, 0.00);
INSERT INTO public.clothing VALUES (3179, '4', 'Polo', 'Dress Shirt', 'White', 269, '164489', 29.99, NULL, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-20 23:46:17.533662', NULL, NULL);
INSERT INTO public.clothing VALUES (828, 'S', 'Karl Lagerfeld', 'Hoodie', 'White, Black', NULL, '237178', 45.00, 69.64, NULL, 22, 'zipped', true, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.890056', NULL, 5.00);
INSERT INTO public.clothing VALUES (823, 'S', 'Calvin Klein', 'Sweater', 'White', NULL, '789979', 29.99, 53.57, NULL, 22, 'Long neck
Big black letters on chest
small "calvin klein performance" tag on bottom corner

Chest: 58
Waist: 54
Length: 63
Arm: 68', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.838952', NULL, NULL);
INSERT INTO public.clothing VALUES (3575, 'S', 'Michael Kors', 'T-Shirt', 'White', 292, '452752', 19.99, NULL, 127, NULL, 'с замком на груди
ПОГ 45
дл 61', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-03 03:22:56.761997', NULL, NULL);
INSERT INTO public.clothing VALUES (821, 'S', 'Calvin Klein', 'Sweat Pants', 'Black', NULL, '827190', 29.99, 50.00, NULL, 22, '"calvin" on back of calf', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.823645', NULL, NULL);
INSERT INTO public.clothing VALUES (829, 'S', 'Karl Lagerfeld', 'Sweat Pants', 'White, Black', NULL, '237339', 45.00, 69.64, NULL, 22, NULL, true, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.89775', NULL, 5.00);
INSERT INTO public.clothing VALUES (3250, 'L', 'Calvin Klein', 'Hoodie', 'White', 276, '436526002299', 22.99, NULL, 112, NULL, 'sleeveless', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-23 00:37:56.81294', NULL, 0.00);
INSERT INTO public.clothing VALUES (809, 'M', 'Calvin Klein', 'Hoodie', 'Plum', NULL, '247299', 25.00, NULL, NULL, NULL, NULL, true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.730906', NULL, NULL);
INSERT INTO public.clothing VALUES (811, 'XS', 'Calvin Klein', 'Sweat Pants', 'Black', NULL, '827206', 29.99, NULL, NULL, NULL, 'letters "Calvin" on back of the calf', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.746513', NULL, NULL);
INSERT INTO public.clothing VALUES (812, 'XS', 'Calvin Klein', 'Sweat Shirt', 'Black', NULL, '826780', 29.99, NULL, NULL, NULL, 'long
letters "calvin" on chest', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.754705', NULL, NULL);
INSERT INTO public.clothing VALUES (813, 'S', 'Calvin Klein', 'Pants', 'Green', NULL, '109562', 29.99, NULL, NULL, NULL, NULL, true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.762006', NULL, NULL);
INSERT INTO public.clothing VALUES (814, 'S', 'Calvin Klein', 'Hoodie', 'Green', NULL, '108749', 29.99, NULL, NULL, NULL, NULL, true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.769996', NULL, NULL);
INSERT INTO public.clothing VALUES (815, 'XS', 'Calvin Klein', 'Pants', 'Black', NULL, '827442', 29.99, NULL, NULL, NULL, 'pink sign "calvin"', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.777196', NULL, NULL);
INSERT INTO public.clothing VALUES (816, 'XS', 'Calvin Klein', 'Hoodie', 'Black', NULL, '827862', 29.99, NULL, NULL, NULL, 'pink sign "calvin"', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.784673', NULL, NULL);
INSERT INTO public.clothing VALUES (817, 'S', 'Calvin Klein', 'Hoodie', 'Black', NULL, '827855', 29.99, NULL, NULL, NULL, 'pink sign "calvin"', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.792537', NULL, NULL);
INSERT INTO public.clothing VALUES (818, 'S', 'Calvin Klein', 'Hoodie', 'Black', NULL, '827855', 29.99, NULL, NULL, NULL, 'pink sign "calvin"', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.79994', NULL, NULL);
INSERT INTO public.clothing VALUES (2697, '6', 'Armani Exchange', 'Skirt', 'Black, Purple, Seawave', 222, '329924', 19.99, 66.43, 105, 22, 'waist: 35
hips: 50
length: 82', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-27 22:18:51.790667', NULL, 0.00);
INSERT INTO public.clothing VALUES (819, 'S', 'Calvin Klein', 'Sweat Pants', 'Black', NULL, '827435', 29.99, NULL, NULL, NULL, 'pink sign "calvin" on calf', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.80812', NULL, NULL);
INSERT INTO public.clothing VALUES (820, 'S', 'Calvin Klein', 'Sweat Pants', 'Black', NULL, '827435', 29.99, NULL, NULL, NULL, 'pink sign "calvin" on calf', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.815625', NULL, NULL);
INSERT INTO public.clothing VALUES (2696, '2', 'Armani Exchange', 'Blazer', 'Pink', 222, '365407', 39.99, 96.43, 105, 22, 'chest: 46
shoulders: 40
length: 74
arm: 58', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-27 22:18:25.023304', NULL, 0.00);
INSERT INTO public.clothing VALUES (824, 'XS', 'Calvin Klein', 'Sweat Shirt', 'Black', NULL, '796472', 20.19, NULL, NULL, NULL, 'stripe + "calvin" on shoulder

chest: 53
length: 58-67
arm: 43-66', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.848778', NULL, NULL);
INSERT INTO public.clothing VALUES (2764, 'M', 'Karl Lagerfeld', 'T-Shirt', 'Peach, Coral, Pink', 226, 'LORH0030', 16.99, 22.88, 94, 9, 'rhinestones

chest: 51
length: 66', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-01 06:02:39.56582', NULL, 0.00);
INSERT INTO public.clothing VALUES (2709, 'L', 'Calvin Klein', 'Sweat Shirt', 'Black', 223, '503513', 19.99, NULL, 104, NULL, 'calvin on chest
white dot on sleeve
chest: 63
length: 49
arm: 48/74', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-27 22:45:28.218145', NULL, 0.00);
INSERT INTO public.clothing VALUES (830, 'M', 'Karl Lagerfeld', 'Sweat Pants', 'Black, White', NULL, '237222', 0.00, NULL, NULL, NULL, NULL, true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.905718', NULL, NULL);
INSERT INTO public.clothing VALUES (831, 'M', 'Karl Lagerfeld', 'Hoodie', 'Black, White', NULL, '237161', 0.00, NULL, NULL, NULL, 'zipped', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.912484', NULL, NULL);
INSERT INTO public.clothing VALUES (832, 'XS', 'Karl Lagerfeld', 'Sweat Pants', 'White', NULL, '121651', 0.00, NULL, NULL, NULL, NULL, true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.92056', NULL, NULL);
INSERT INTO public.clothing VALUES (1206, 'M', 'Calvin Klein', 'T-Shirt', 'Black', 105, '858064', 12.59, NULL, NULL, NULL, '', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:11.715572', NULL, NULL);
INSERT INTO public.clothing VALUES (838, 'S', 'Tommy Hilfiger', 'Sweater', 'Navy', NULL, '777244', 10.39, NULL, NULL, NULL, 'v-neck', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.965135', NULL, NULL);
INSERT INTO public.clothing VALUES (840, 'S', 'Tommy Hilfiger', 'Sweater', 'White', NULL, '089739', 15.00, NULL, NULL, NULL, NULL, true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.979816', NULL, NULL);
INSERT INTO public.clothing VALUES (841, 'XS', 'Tommy Hilfiger', 'Sweater', 'Navy', NULL, '073063', 20.00, NULL, NULL, NULL, 'v-neck
blue/red stripe on sleeve', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.988073', NULL, NULL);
INSERT INTO public.clothing VALUES (842, 'XS', 'Tommy Hilfiger', 'Sweater', 'Navy, Red, Yellow', NULL, '243657', 22.00, NULL, NULL, NULL, 'color block', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.994908', NULL, NULL);
INSERT INTO public.clothing VALUES (2703, 'S', 'Armani Exchange', 'Long Sleeved Shirt', 'Mint', 222, '364653', 29.99, NULL, 105, NULL, 'chest: 62
length: 66
arm: 45/72', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-27 22:26:59.405916', NULL, 0.00);
INSERT INTO public.clothing VALUES (2700, '6', 'Armani Exchange', 'Blazer', 'Black', 222, '373794', 39.99, NULL, 105, NULL, 'chest: 52
length: 76
arm: 60
shoulders: 42', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-27 22:22:41.181556', NULL, 0.00);
INSERT INTO public.clothing VALUES (822, 'S', 'Calvin Klein', 'Sweat Pants', 'Black', NULL, '827190', 29.99, 50.00, NULL, 21, '"calvin" on back of calf', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.830747', NULL, NULL);
INSERT INTO public.clothing VALUES (2714, 'M', 'Michael Kors', 'Sweat Shirt', 'Black', 223, '504954', 19.99, NULL, 105, NULL, 'chest: 55
length: 69
arm: 67
shoulders: 45', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-02-27 22:48:30.536966', NULL, 0.00);
INSERT INTO public.clothing VALUES (2723, 'N/A', 'Tommy Hilfiger', 'Hat', 'White', 225, '521524', 9.54, NULL, 105, NULL, 'baseball cap', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-01 00:58:55.546714', NULL, 0.00);
INSERT INTO public.clothing VALUES (3417, '6', 'Levis', 'Jeans', 'Navy', 285, '274023', 19.99, NULL, 119, NULL, 'с высокой посадкой присобраный пояс
ПОТ 35-39
ПОБ 49
дл 100
пос 35', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-30 20:58:59.388998', NULL, NULL);
INSERT INTO public.clothing VALUES (3491, 'M', 'Armani Exchange', 'Puffy Jacket', 'Black', 287, '0321478', 79.99, NULL, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-02 21:34:40.253878', NULL, NULL);
INSERT INTO public.clothing VALUES (3648, 'M', 'Calvin Klein', 'Sweat Shirt', 'Black', NULL, '100000', 10.00, NULL, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-08 01:24:10.43615', NULL, NULL);
INSERT INTO public.clothing VALUES (3332, 'M', 'Calvin Klein', 'Sport Bra', 'Black', 281, '454268', 6.99, NULL, 122, NULL, 'velurovie', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-27 04:10:30.499155', NULL, NULL);
INSERT INTO public.clothing VALUES (2732, 'XS', 'Tommy Hilfiger', 'T-Shirt', 'Navy', 225, '297469', 14.39, NULL, NULL, NULL, 'block letters on chest
chest: 40
length: 61
', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-01 01:07:16.643997', NULL, NULL);
INSERT INTO public.clothing VALUES (2731, 'S', 'Tommy Hilfiger', 'Sweat Pants', 'Blue', 225, '006264', 28.79, 0.00, 92, 9, 'blue mesh

waist: 37
hips: 55
pasadka: 25
length: 95', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-01 01:05:46.0759', NULL, 0.00);
INSERT INTO public.clothing VALUES (3576, 'M', 'Michael Kors', 'T-Shirt', 'White', 292, '452769', 19.99, NULL, NULL, NULL, 'с замком на груди
ПОГ 48
дл 64', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-03 03:23:44.937999', NULL, NULL);
INSERT INTO public.clothing VALUES (3649, '0', 'DKNY', 'Dress', 'Black, White', 296, '412260', 15.98, NULL, 121, NULL, 'no tag', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-08 02:52:00.204285', NULL, NULL);
INSERT INTO public.clothing VALUES (3180, 'M', 'Calvin Klein', 'Dress', 'Olive', 270, '221349', 19.99, NULL, 110, NULL, 'Golden rhinestones', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-20 23:50:28.301919', NULL, NULL);
INSERT INTO public.clothing VALUES (3251, 'M', 'Calvin Klein', 'Hoodie', 'White', 276, '436526002299', 22.99, NULL, 112, NULL, 'sleeveless', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-23 00:38:11.384332', NULL, 0.00);
INSERT INTO public.clothing VALUES (3492, 'XL', 'Armani Exchange', 'Sweater', 'Navy', 287, '4348751', 19.99, NULL, 125, NULL, NULL, NULL, 'men', NULL, NULL, NULL, 'usa', '2021-04-02 21:36:05.351933', NULL, NULL);
INSERT INTO public.clothing VALUES (843, 'XS', 'Tommy Hilfiger', 'Sweater', 'Navy, Red, Yellow', NULL, '243657', 22.00, NULL, NULL, NULL, 'color block', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:01.002206', NULL, NULL);
INSERT INTO public.clothing VALUES (826, 'XS', 'Karl Lagerfeld', 'Sweat Pants', 'Black', NULL, '347327', 100.00, 151.79, NULL, 22, 'Sweat suite с полоской по плечу

waist: 37
hips: 47
length: 97
pasadka: 26', true, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.874927', NULL, 0.00);
INSERT INTO public.clothing VALUES (825, 'XS', 'Karl Lagerfeld', 'Sweat Shirt', 'Black', NULL, '347389', 37.00, NULL, NULL, NULL, 'stripe on sleeve

chest: 48
length: 60
arm: 60', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.862821', NULL, NULL);
INSERT INTO public.clothing VALUES (846, 'XS', 'Karl Lagerfeld', 'T-Shirt', 'Black', NULL, '224802', 25.00, NULL, NULL, NULL, 'striped

chest: 44
length: 61', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:01.024878', NULL, NULL);
INSERT INTO public.clothing VALUES (3333, 'S', 'Calvin Klein', 'Sport Bra', 'Black', 281, '454251', 6.99, NULL, 117, NULL, 'velurovie', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-27 04:11:09.60698', NULL, NULL);
INSERT INTO public.clothing VALUES (3652, '0', 'DKNY', 'Jumpsuit', 'Black', 296, '424843', 15.98, NULL, 121, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-08 02:55:42.964293', NULL, NULL);
INSERT INTO public.clothing VALUES (1306, 'XS', 'Ralph Lauren', 'T-Shirt', 'White, Black', 56, '916886', 4.99, NULL, NULL, NULL, 'Striped
Silver buttons

Chest: 40
Waist: 38
Length: 58', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:12.642394', NULL, NULL);
INSERT INTO public.clothing VALUES (827, 'S', 'Karl Lagerfeld', 'Sweat Shirt', 'Black', NULL, '122436', 47.99, NULL, NULL, NULL, 'metal buttons on sleeve

chest: 52
length: 60
arm: 61', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.882129', NULL, NULL);
INSERT INTO public.clothing VALUES (844, 'M', 'Karl Lagerfeld', 'T-Shirt', 'Black', NULL, 'RH0024', 8.49, NULL, NULL, NULL, 'golden head
chest: 51
length: 63', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:01.009482', NULL, NULL);
INSERT INTO public.clothing VALUES (833, 'S', 'Karl Lagerfeld', 'T-Shirt', 'Black', NULL, '814891', 23.99, NULL, NULL, NULL, 'silver stones on letters

chest: 46
length: 61', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.927921', NULL, NULL);
INSERT INTO public.clothing VALUES (1320, '34X32', 'Calvin Klein', 'Jeans', 'Blue', 118, '012450', 13.51, NULL, NULL, NULL, 'model number ckg035
american classics

waist: 45
hips: 54
pasadka: 30
length: 111', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:12.791162', NULL, NULL);
INSERT INTO public.clothing VALUES (3133, 'XS', 'Tommy Hilfiger', 'Windbreaker', 'White', NULL, '866511XS', 29.99, NULL, 103, NULL, 'costco jacket', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-15 22:37:47.143985', NULL, 0.00);
INSERT INTO public.clothing VALUES (2090, 'S', 'Tommy Hilfiger', 'Puffy Jacket', 'White', NULL, '172924', 67.80, NULL, NULL, NULL, 'chest: 59
length: 60
arm: 51/74', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-01-13 12:02:28.421951', NULL, NULL);
INSERT INTO public.clothing VALUES (1753, '6', 'Tommy Hilfiger', 'Blazer', 'Blue', NULL, '330355', 24.99, NULL, NULL, NULL, NULL, true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 09:46:35.961566', NULL, NULL);
INSERT INTO public.clothing VALUES (488, 'XS', 'Calvin Klein', 'Puffy Jacket', 'Pearl', 37, '093273', 17.56, NULL, NULL, NULL, 'chest: 48
length: 56
arm: 65', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.925841', NULL, NULL);
INSERT INTO public.clothing VALUES (1730, 'S', 'DKNY', 'Winter Jacket', 'Black', NULL, '188933', 70.00, NULL, NULL, NULL, 'fur on hood', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 07:14:37.529318', NULL, NULL);
INSERT INTO public.clothing VALUES (1738, 'S', 'Levis', 'Sherpa', 'Light Blue', NULL, '124712', 0.00, NULL, NULL, NULL, 'Short

chest: 53
length: 47', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 07:55:42.125566', NULL, NULL);
INSERT INTO public.clothing VALUES (2072, 'M', 'Calvin Klein', 'Sweat Shirt', 'White', 158, '023141', 16.00, 21.55, 61, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-13 11:31:03.459043', NULL, 4.93);
INSERT INTO public.clothing VALUES (2291, '34X32', 'Calvin Klein', 'Jeans', 'Navy', 182, '172744', 20.00, 27.03, 82, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-23 21:41:02.772681', NULL, 0.00);
INSERT INTO public.clothing VALUES (2348, 'N/A', 'Calvin Klein', 'Wallet', 'Black', 187, '297731', 9.99, NULL, NULL, NULL, 'length: 11
height: 8.5', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-01-31 15:08:10.524416', NULL, 0.00);
INSERT INTO public.clothing VALUES (2770, '3', 'Tommy Hilfiger', 'T-Shirt + Shorts', 'Navy, Red, White', 226, '603998', 16.99, NULL, 105, NULL, 'kid clothes
3 years

t-shirt + shorts', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-01 06:07:24.884539', NULL, 0.00);
INSERT INTO public.clothing VALUES (3418, 'S', 'Armani Exchange', 'Polo Shirt', 'Black', 283, '7281067', 19.99, NULL, NULL, NULL, 'чёрная с орлом
ПОГ 51
дл 67
плечи 45', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-30 21:02:18.398645', NULL, NULL);
INSERT INTO public.clothing VALUES (2739, 'S', 'Tommy Hilfiger', 'Hoodie', 'Grey', 225, '432320', 25.19, NULL, NULL, NULL, 'chest: 52
length: 56
arm: 62', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-01 01:14:13.33848', NULL, NULL);
INSERT INTO public.clothing VALUES (2767, 'M', 'Tommy Hilfiger', 'Hoodie', 'White', 226, '802113', 22.99, 50.00, 105, 22, 'Tommy jeans sign
chest: 53
length: 62
arm: 63', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-01 06:04:41.129063', NULL, 0.00);
INSERT INTO public.clothing VALUES (2740, 'S', 'Tommy Hilfiger', 'Sweat Pants', 'Grey', 225, '006615', 28.94, NULL, NULL, NULL, 'waist: 38
hips: 54
pasadka: 25
length: 96', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-01 01:15:30.965682', NULL, NULL);
INSERT INTO public.clothing VALUES (2745, 'M8-10', 'Tommy Hilfiger', 'Sweat Shirt', 'Blue', 225, '926102', 16.91, NULL, 105, NULL, 'kids clothes
8-10 years

chest: 42
length: 54
arm: 48', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-01 01:20:04.201311', NULL, 0.00);
INSERT INTO public.clothing VALUES (2757, 'S', 'Calvin Klein', 'Shorts', 'Grey', 226, '422579', 13.99, NULL, 121, NULL, 'waist: 37
hips: 50
length: 48
', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-01 05:56:13.138245', NULL, NULL);
INSERT INTO public.clothing VALUES (2171, 'XXS', 'Calvin Klein', 'T-Shirt', 'White', 168, '801480', 12.74, NULL, 121, NULL, 'Oversized
payetki sign

chest: 45
length: 48', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-01-21 16:55:43.902866', NULL, NULL);
INSERT INTO public.clothing VALUES (2786, 'N/A', 'Michael Kors', 'Wallet', 'Black', 227, '445057', 19.99, NULL, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-01 06:22:44.996684', NULL, NULL);
INSERT INTO public.clothing VALUES (2787, 'N/A', 'Tommy Hilfiger', 'Wallet', 'Black', 227, '149137', 14.99, NULL, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-01 06:23:04.970088', NULL, NULL);
INSERT INTO public.clothing VALUES (3650, 'XXS', 'DKNY', 'Dress', 'Black, White', 296, '993993', 15.98, NULL, 121, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-08 02:53:18.930211', NULL, NULL);
INSERT INTO public.clothing VALUES (3334, 'S', 'Calvin Klein', 'Sport Bra', 'Black', 281, '454251', 6.99, NULL, 122, NULL, 'velurovie', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-27 04:11:22.29951', NULL, NULL);
INSERT INTO public.clothing VALUES (3493, 'XXL', 'Armani Exchange', 'Sweater', 'Navy', 287, '4348775', 19.99, NULL, 125, NULL, NULL, NULL, 'men', NULL, NULL, NULL, 'usa', '2021-04-02 21:36:28.321217', NULL, NULL);
INSERT INTO public.clothing VALUES (1760, 'M', 'Calvin Klein', 'T-Shirt', 'White', NULL, '290127', 14.99, 28.57, NULL, 22, 'grey logo on chest', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 11:05:54.701827', NULL, NULL);
INSERT INTO public.clothing VALUES (3252, 'XS', 'Tommy Hilfiger', 'Hoodie', 'White', 276, '802137', 22.99, NULL, NULL, NULL, 'tommy jeans on chest', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-23 00:40:42.528313', NULL, 0.00);
INSERT INTO public.clothing VALUES (1384, 'L', 'Calvin Klein', 'Shorts', 'Black', 125, '978694', 8.49, 11.43, NULL, NULL, 'SOLD TO ALLA
White letters on one leg

Waist: 42
Hips: 58
Length: 45
Pasadka: 32', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:13.370359', NULL, NULL);
INSERT INTO public.clothing VALUES (1735, 'M', 'Calvin Klein', 'Jean Jacket', 'White', NULL, '0005', 20.00, NULL, NULL, NULL, NULL, true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 07:50:18.817694', NULL, NULL);
INSERT INTO public.clothing VALUES (1741, 'S', 'Calvin Klein', 'Hoodie', 'Black', NULL, '074531', 19.44, 54.20, NULL, NULL, 'stripe on sleeve', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 08:00:55.830913', NULL, NULL);
INSERT INTO public.clothing VALUES (1744, 'XS', 'DKNY', 'T-Shirt', 'White', NULL, '208936', 20.00, NULL, NULL, NULL, NULL, true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 09:23:54.712126', NULL, NULL);
INSERT INTO public.clothing VALUES (3181, 'M', 'Calvin Klein', 'Polo Shirt', 'White', 270, '747665', 14.99, NULL, 114, NULL, 'chest: 50
length: 62/66', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-20 23:52:06.530703', NULL, 0.00);
INSERT INTO public.clothing VALUES (1745, 'L', 'Massimo Duti', 'Blazer', 'Black', NULL, '0015', 12.00, NULL, NULL, NULL, 'Man', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 09:25:42.281272', NULL, NULL);
INSERT INTO public.clothing VALUES (2791, 'L', 'Michael Kors', 'T-Shirt', 'Black', NULL, '056491', 16.99, NULL, 114, NULL, 'Chest 58
L 71', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-03 21:04:36.473948', NULL, NULL);
INSERT INTO public.clothing VALUES (1748, '4', 'Calvin Klein', 'Blazer', 'Grey', NULL, '471919', 0.00, NULL, NULL, NULL, NULL, true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 09:30:49.737805', NULL, NULL);
INSERT INTO public.clothing VALUES (1749, 'XS', 'Levis', 'Trucker Jacket', 'Blue', NULL, '150665', 25.00, NULL, NULL, NULL, 'indigo color', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 09:31:48.768809', NULL, NULL);
INSERT INTO public.clothing VALUES (1750, 'M', 'Levis', 'Trucker Jacket', 'Blue', NULL, '105179', 34.00, NULL, NULL, NULL, 'double sided', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 09:33:11.744298', NULL, NULL);
INSERT INTO public.clothing VALUES (1751, 'M', 'New Balance', 'Windbreaker', 'Black', NULL, '0016', 13.00, NULL, NULL, NULL, 'stripe on sleeve', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 09:41:08.891515', NULL, NULL);
INSERT INTO public.clothing VALUES (1752, 'L', 'Michael Kors', 'Jean Jacket', 'White', NULL, '613833', 20.00, NULL, NULL, NULL, NULL, true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 09:42:12.894869', NULL, NULL);
INSERT INTO public.clothing VALUES (1759, 'S', 'Calvin Klein', 'T-Shirt', 'White', NULL, '288698', 14.99, NULL, NULL, NULL, 'small logo on chest', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 11:05:08.939616', NULL, NULL);
INSERT INTO public.clothing VALUES (1746, 'S', 'Levis', 'Sherpa', 'Navy', NULL, '192682', 29.99, 58.93, NULL, 22, 'Chest: 50
Waist: 48
Length: 58
Arm: 56', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 09:28:50.122765', NULL, NULL);
INSERT INTO public.clothing VALUES (1761, 'M', 'Calvin Klein', 'T-Shirt', 'White', NULL, '515180', 14.99, NULL, NULL, NULL, 'black stripe "calvin" on chest', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 11:06:34.524485', NULL, NULL);
INSERT INTO public.clothing VALUES (2091, 'S', 'Tommy Hilfiger', 'Puffy Jacket', 'Black', NULL, '107100', 51.80, NULL, NULL, NULL, 'chest: 53
length: 60
arm: 59', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-01-13 12:03:43.548144', NULL, NULL);
INSERT INTO public.clothing VALUES (1743, '8', 'Tommy Hilfiger', 'Blazer', 'Blue', NULL, '330348', 24.99, 69.75, NULL, 22, 'patches on elbows', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 08:03:21.790896', NULL, NULL);
INSERT INTO public.clothing VALUES (1762, 'M', 'Calvin Klein', 'Polo Shirt', 'White', NULL, '566687', 17.00, NULL, NULL, NULL, 'black square on chest', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 11:07:20.12986', NULL, NULL);
INSERT INTO public.clothing VALUES (1763, 'S', 'Calvin Klein', 'Polo Shirt', 'Black', NULL, '674405', 17.00, NULL, NULL, NULL, 'white square on chest', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 11:08:13.896445', NULL, NULL);
INSERT INTO public.clothing VALUES (1776, 'L', 'Calvin Klein', 'Dress', 'Pink, Black, White', NULL, '823208', 19.99, NULL, NULL, NULL, 'black top
white stripe on chest', true, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-25 02:24:53.443671', NULL, 0.00);
INSERT INTO public.clothing VALUES (3419, 'S', 'Armani Exchange', 'Polo Shirt', 'Black', 283, '7281067', 19.99, NULL, NULL, NULL, 'чёрная с орлом
ПОГ 51
дл 67
плечи 45', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-30 21:02:36.465552', NULL, NULL);
INSERT INTO public.clothing VALUES (1765, 'L', 'Calvin Klein', 'T-Shirt', 'Black', NULL, '288650', 14.99, NULL, NULL, NULL, 'small white logo on chest', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 11:11:52.447954', NULL, NULL);
INSERT INTO public.clothing VALUES (3577, 'L', 'Armani Exchange', 'Sweat Shirt', 'Navy', 293, '2433158', 19.99, NULL, NULL, NULL, 'neopren
ПОГ 58
дл 69
рук 65', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-04-04 05:13:42.954799', NULL, NULL);
INSERT INTO public.clothing VALUES (1766, 'M', 'Calvin Klein', 'Sweat Pants', 'White', NULL, '278602', 0.00, NULL, NULL, NULL, 'stripe on side', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 11:17:03.140706', NULL, NULL);
INSERT INTO public.clothing VALUES (1767, 'M', 'Calvin Klein', 'Sweat Pants', 'White', NULL, '278602', 0.00, NULL, NULL, NULL, 'stripe on side', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 11:17:05.587907', NULL, NULL);
INSERT INTO public.clothing VALUES (1755, 'L', 'Calvin Klein', 'T-Shirt', 'White', NULL, '797473', 6.59, NULL, NULL, NULL, 'large black letters
small grey letters', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 11:00:50.330077', NULL, NULL);
INSERT INTO public.clothing VALUES (1757, 'M', 'Calvin Klein', 'T-Shirt', 'White', NULL, '797466', 6.59, NULL, NULL, NULL, 'large black letters
small grey letters', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 11:02:09.098625', NULL, NULL);
INSERT INTO public.clothing VALUES (1756, 'M', 'Calvin Klein', 'T-Shirt', 'White', NULL, '797466', 6.59, NULL, NULL, NULL, 'large black letters
small grey letters', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 11:02:05.895686', NULL, NULL);
INSERT INTO public.clothing VALUES (1758, 'M', 'Calvin Klein', 'T-Shirt', 'White', NULL, '288704', 14.99, NULL, NULL, NULL, 'small logo on chest', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 11:03:29.29155', NULL, NULL);
INSERT INTO public.clothing VALUES (911, 'M', 'Tommy Hilfiger', 'Sweat Shirt', 'Navy', 56, '2834', 0.00, NULL, 36, NULL, 'W', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:08.941309', NULL, NULL);
INSERT INTO public.clothing VALUES (2789, 'XL', 'Armani Exchange', 'Vest Jacket', 'Black', NULL, '114783', 59.99, 80.99, 94, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-01 06:34:34.864813', NULL, 0.00);
INSERT INTO public.clothing VALUES (2776, 'M', 'Calvin Klein', 'Bodic', 'White', 226, '349944', 14.99, 20.19, 94, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-01 06:10:15.156206', NULL, 0.00);
INSERT INTO public.clothing VALUES (3134, 'S', 'Tommy Hilfiger', 'Windbreaker', 'White', NULL, '866597', 29.99, NULL, 103, NULL, 'costco jacket', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-15 22:38:52.245395', NULL, 0.00);
INSERT INTO public.clothing VALUES (2820, 'S', 'Karl Lagerfeld', 'Dress', 'Grey', NULL, 'LD1R9558', 24.99, NULL, 103, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-04 01:55:00.13085', NULL, 0.00);
INSERT INTO public.clothing VALUES (2790, 'N/A', 'Levis', 'Wallet', 'Black', NULL, '544113', 12.99, NULL, NULL, NULL, NULL, NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-03 20:57:45.011265', NULL, NULL);
INSERT INTO public.clothing VALUES (2803, 'M', 'Guess', 'T-Shirt', 'White', NULL, '929878', 12.99, NULL, 104, NULL, 'red sign guess
CH 49
L 62', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-03 21:24:07.214312', NULL, 0.00);
INSERT INTO public.clothing VALUES (2842, 'XS', 'Tommy Hilfiger', 'Blazer', 'Blue', NULL, '235834', 24.99, NULL, NULL, NULL, 'with buttons

chest: 43
length: 57
arm: 63', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-04 04:49:22.120299', NULL, 0.00);
INSERT INTO public.clothing VALUES (1774, 'M', 'Calvin Klein', 'Sweat Pants', 'Black', NULL, '085551', 29.99, 53.57, NULL, 22, 'stripe on waist', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-23 13:29:44.563702', NULL, NULL);
INSERT INTO public.clothing VALUES (1783, 'S', 'Calvin Klein', 'Dress', 'Red', NULL, '812431', 19.99, 50.00, NULL, 22, 'black stripe down side', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-25 02:42:51.478701', NULL, NULL);
INSERT INTO public.clothing VALUES (1769, 'XS', 'Calvin Klein', 'Sweat Pants', 'White', NULL, '785322', 25.70, NULL, NULL, NULL, 'off white / cream
stripe + calvin down side

Waist: 36
hips: 46
length: 91
pasadka: 24', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-23 13:20:35.984472', NULL, NULL);
INSERT INTO public.clothing VALUES (1747, 'M', 'Levis', 'Trucker Jacket', 'Light Blue', NULL, '734232', 24.99, NULL, NULL, NULL, 'ex-boyfriend trucker
ice queen color

chest: 52
length: 60
arm: 57/74', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 09:29:52.301096', NULL, NULL);
INSERT INTO public.clothing VALUES (1734, 'S', 'Karl Lagerfeld', 'Sweat Shirt', 'Black', NULL, '347372', 0.00, NULL, NULL, NULL, 'chest: 51
length: 61
arm: 62', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 07:45:07.50074', NULL, NULL);
INSERT INTO public.clothing VALUES (1740, 'XS', 'Karl Lagerfeld', 'Sweat Shirt', 'White', NULL, '096317', 45.00, 66.07, NULL, 19, 'red letters', true, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 07:59:54.553069', NULL, 4.00);
INSERT INTO public.clothing VALUES (1764, 'M', 'Calvin Klein', 'T-Shirt', 'Navy', NULL, '781588', 15.00, 28.57, NULL, 19, 'grey logo on chest', true, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 11:11:01.892745', NULL, 3.00);
INSERT INTO public.clothing VALUES (834, 'M', 'Karl Lagerfeld', 'T-Shirt', 'Black', NULL, 'RH0024', 8.49, 33.93, NULL, 19, 'golden head
chest: 51
length: 63', true, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.935355', NULL, 3.00);
INSERT INTO public.clothing VALUES (2843, 'S', 'Tommy Hilfiger', 'Hoodie', 'Navy, White', NULL, '836156', 24.99, NULL, 121, NULL, 'with zipper
chest: 47
length: 60
arm: 64', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-04 04:51:03.635262', NULL, NULL);
INSERT INTO public.clothing VALUES (3578, 'L', 'Armani Exchange', 'Sweat Shirt', 'Navy', 293, '2433158', 19.99, NULL, NULL, NULL, 'neopren
ПОГ 58
дл 69
рук 65', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-04-04 05:14:32.029739', NULL, NULL);
INSERT INTO public.clothing VALUES (3182, 'S', 'Calvin Klein', 'Polo Shirt', 'White', 270, '747672', 14.99, NULL, 114, NULL, 'chest: 50
length: 62/66
', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-20 23:53:14.784892', NULL, 0.00);
INSERT INTO public.clothing VALUES (1737, 'M', 'DKNY', 'Puffy Jacket', 'Black', NULL, '202714', 0.00, NULL, NULL, NULL, 'super long

chest: 54
waist: 48
length: 120
arm: 63', true, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 07:54:00.44425', NULL, 0.00);
INSERT INTO public.clothing VALUES (2508, 'M', 'Levis', 'Puffy Jacket', 'Navy', 203, '024099', 35.99, 48.64, 82, 9, NULL, NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-02-11 23:43:34.714799', NULL, 0.00);
INSERT INTO public.clothing VALUES (3651, 'N/A', 'DKNY', 'Purse', 'Black', 296, '404326', 23.98, NULL, 121, NULL, 'silver rivets', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-08 02:54:39.313186', NULL, NULL);
INSERT INTO public.clothing VALUES (1732, 'XS', 'Levis', 'Sherpa', 'Blue', NULL, '762152', 25.00, NULL, NULL, NULL, 'jean jacket

chest: 43
length: 53
sleeve: 60', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 07:32:02.517206', NULL, NULL);
INSERT INTO public.clothing VALUES (1772, 'S', 'Calvin Klein', 'Sweat Pants', 'Black', NULL, '085568', 29.99, 52.00, NULL, NULL, 'stripe on waist', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-23 13:29:01.396141', NULL, NULL);
INSERT INTO public.clothing VALUES (1768, 'S', 'Calvin Klein', 'Hoodie', 'Black', NULL, '074531', 19.44, NULL, NULL, NULL, 'stripe on sleeve', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-23 13:10:46.798543', NULL, NULL);
INSERT INTO public.clothing VALUES (1773, 'S', 'Calvin Klein', 'Sweat Pants', 'Black', NULL, '085568', 29.99, NULL, NULL, NULL, 'stripe on waist', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-23 13:29:16.781785', NULL, NULL);
INSERT INTO public.clothing VALUES (3253, '4', 'Karl Lagerfeld', 'Jeans', 'Blue', 276, '510887002499', 24.99, NULL, 113, NULL, 'с полоской с боку', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-23 00:41:21.64695', NULL, 0.00);
INSERT INTO public.clothing VALUES (756, 'L', 'Tommy Hilfiger', 'Coat', 'Plaid', 50, '916780', 55.99, 0.00, NULL, 23, 'chest: 55
Waist: 51
length: 99
arm: 66', true, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.262575', NULL, 0.00);
INSERT INTO public.clothing VALUES (1775, 'S', 'DKNY', 'Dress', 'Black', NULL, '554679', 19.99, NULL, NULL, NULL, 'white DKNY letters on chest

chest: 46
length: 93', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-25 02:21:36.461508', NULL, NULL);
INSERT INTO public.clothing VALUES (1777, 'M', 'Calvin Klein', 'Dress', 'Lemon', NULL, '817160', 19.99, NULL, NULL, NULL, NULL, true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-25 02:29:18.77797', NULL, NULL);
INSERT INTO public.clothing VALUES (2227, 'M', 'Tommy Hilfiger', 'Golfik', 'Navy', NULL, '130467', 8.00, NULL, 122, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-01-21 17:59:01.987008', NULL, 0.00);
INSERT INTO public.clothing VALUES (1778, 'M', 'Calvin Klein', 'Dress', 'Black', NULL, '811267', 19.99, NULL, NULL, NULL, 'gold payetki square stones on side of chest', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-25 02:30:47.674333', NULL, NULL);
INSERT INTO public.clothing VALUES (1782, 'M', 'Calvin Klein', 'Dress', 'Pink', NULL, '815845', 19.99, NULL, NULL, NULL, 'black stripe on shoulder', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-25 02:41:04.862733', NULL, NULL);
INSERT INTO public.clothing VALUES (1398, 'XS', 'Calvin Klein', 'T-Shirt', 'Black', 126, '420210', 6.71, 28.57, NULL, 22, 'Gold square on front', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:13.495201', NULL, NULL);
INSERT INTO public.clothing VALUES (3420, 'M', 'Armani Exchange', 'Polo Shirt', 'Blue', 283, '4462175', 19.99, NULL, 123, NULL, 'stripe on the side
ПОГ 54
дл 70
плечи 49', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-30 21:05:40.06513', NULL, NULL);
INSERT INTO public.clothing VALUES (3494, 'XL', 'Armani Exchange', 'Sweater', 'Black', 287, '2337067', 19.99, NULL, 125, NULL, NULL, NULL, 'men', NULL, NULL, NULL, 'usa', '2021-04-02 21:37:04.856565', NULL, NULL);
INSERT INTO public.clothing VALUES (1784, 'M', 'Calvin Klein', 'Dress', 'Coral', NULL, '815791', 19.99, NULL, NULL, NULL, 'black stripe down shoulder/side', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-25 02:48:06.81163', NULL, NULL);
INSERT INTO public.clothing VALUES (1779, 'M', 'Calvin Klein', 'Dress', 'Coral', NULL, '815791', 19.99, NULL, NULL, NULL, 'black stripe down shoulder/side

color is "coralovy" coral', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-25 02:34:44.109328', NULL, NULL);
INSERT INTO public.clothing VALUES (1794, 'L', 'Levis', 'T-Shirt', 'Black', NULL, '652750', 6.99, NULL, NULL, NULL, 'red logo sign on chest

chest: 53
length: 70', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-25 07:09:33.776708', NULL, NULL);
INSERT INTO public.clothing VALUES (1795, 'S', 'Levis', 'T-Shirt', 'White', NULL, '399616', 6.99, NULL, NULL, NULL, 'red logo sign on chest

chest: 51
length: 69', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-25 07:10:03.110692', NULL, NULL);
INSERT INTO public.clothing VALUES (1796, 'L', 'Levis', 'T-Shirt', 'Black', NULL, '652750', 6.99, NULL, NULL, NULL, 'red logo sign on chest

chest: 53
length: 70', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-25 07:10:46.985923', NULL, NULL);
INSERT INTO public.clothing VALUES (1797, 'M', 'Levis', 'T-Shirt', 'Navy', NULL, '173179', 6.99, NULL, NULL, NULL, 'red horses sign sign on chest

chest: 52
length: 70', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-25 07:11:31.425283', NULL, NULL);
INSERT INTO public.clothing VALUES (1798, 'M', 'Levis', 'T-Shirt', 'Navy', NULL, '173179', 6.99, NULL, NULL, NULL, 'red horses sign sign on chest

chest: 52
length: 70', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-25 07:11:33.487236', NULL, NULL);
INSERT INTO public.clothing VALUES (1800, 'M', 'Levis', 'T-Shirt', 'Black', NULL, '220279', 6.99, NULL, NULL, NULL, 'white horses sign sign on chest

chest: 52
length: 70', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-25 07:12:25.783003', NULL, NULL);
INSERT INTO public.clothing VALUES (1799, 'M', 'Levis', 'T-Shirt', 'Black', NULL, '220279', 6.99, NULL, NULL, NULL, 'white horses sign sign on chest

chest: 52
length: 70', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-25 07:12:18.240739', NULL, NULL);
INSERT INTO public.clothing VALUES (2855, '8', 'Michael Kors', 'Jeans', 'Black', NULL, '834955', 20.00, 27.00, 98, 9, 'waist: 38
hips: 47
pasadka: 24
length: 99', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 04:59:30.593824', NULL, 0.00);
INSERT INTO public.clothing VALUES (2903, '---', 'Tommy Hilfiger', 'Pants', '---', 228, '044190', 11.47, 15.50, 94, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 05:44:13.466045', NULL, 0.00);
INSERT INTO public.clothing VALUES (2935, '2', 'DKNY', 'Dress', 'Tan, Sand', NULL, '603655', 19.99, NULL, 103, 9, 'chest: 42
waist: 36
hips: 51
length: 99', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-04 06:18:48.862089', NULL, 0.00);
INSERT INTO public.clothing VALUES (3254, '8', 'Karl Lagerfeld', 'Jeans', 'Blue', 276, '510887002499', 24.99, NULL, 112, NULL, 'с полоской с боку
', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-23 00:43:04.281647', NULL, 0.00);
INSERT INTO public.clothing VALUES (1801, 'M', 'Levis', 'T-Shirt', 'White', NULL, '219945', 6.99, NULL, NULL, NULL, 'horses sign sign on chest

chest: 50
length: 70', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-25 07:13:18.080987', NULL, NULL);
INSERT INTO public.clothing VALUES (1802, 'L', 'Levis', 'T-Shirt', 'Black', NULL, '649858', 6.99, NULL, NULL, NULL, 'san francisco picture

chest: 54
length: 70', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-25 07:14:13.317298', NULL, NULL);
INSERT INTO public.clothing VALUES (3421, 'XL', 'Armani Exchange', 'Polo Shirt', 'White', 283, '4423558', 19.99, NULL, NULL, NULL, 'stripe on the side
', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-30 21:06:31.403336', NULL, NULL);
INSERT INTO public.clothing VALUES (1803, 'M', 'Calvin Klein', 'Sweater', 'White', NULL, '792733', 35.00, NULL, NULL, NULL, 'letters "calvin" on sleeves', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-26 07:24:41.792704', NULL, NULL);
INSERT INTO public.clothing VALUES (1804, 'L', 'Calvin Klein', 'Sweater', 'Black', NULL, '874873', 25.00, NULL, NULL, NULL, 'batwing style', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-26 07:25:40.746651', NULL, NULL);
INSERT INTO public.clothing VALUES (1805, 'XS', 'Calvin Klein', 'Sweater', 'Black', NULL, '954421', 20.00, NULL, NULL, NULL, 'with hood

Chest: 49
Waist: 47
Length: 56
Arm: 50', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-26 07:30:24.620229', NULL, NULL);
INSERT INTO public.clothing VALUES (3579, 'L', 'Armani Exchange', 'Sweat Shirt', 'Navy', 293, '2433158', 19.99, NULL, NULL, NULL, 'neopren
ПОГ 58
дл 69
рук 65', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-04-04 05:15:22.280153', NULL, NULL);
INSERT INTO public.clothing VALUES (1806, 'S', 'Calvin Klein', 'Sweater', 'Tan', NULL, '954469', 30.00, NULL, NULL, NULL, 'with hood', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-26 07:31:11.233878', NULL, NULL);
INSERT INTO public.clothing VALUES (3183, '10', 'DKNY', 'Dress', 'White', 270, '670486', 29.99, NULL, 121, NULL, 'chest: 44/56
length: 95
', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-20 23:55:01.77889', NULL, 0.00);
INSERT INTO public.clothing VALUES (3336, 'M', 'Calvin Klein', 'Panties', 'Black', 281, '454411', 6.99, NULL, 122, NULL, 'velurovie', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-27 04:12:14.739846', NULL, NULL);
INSERT INTO public.clothing VALUES (1807, 'L', 'Calvin Klein', 'Sweater', 'Red', NULL, '063931', 25.00, NULL, NULL, NULL, NULL, true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-26 07:32:15.598658', NULL, NULL);
INSERT INTO public.clothing VALUES (1808, '1SZ', 'Calvin Klein', 'Scarf', 'Black, White', NULL, '449612', 14.99, NULL, NULL, NULL, 'Furry
White ends', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-26 07:39:29.137955', NULL, NULL);
INSERT INTO public.clothing VALUES (1809, 'XS', 'DKNY', 'T-Shirt', 'White', NULL, '854042', 14.99, NULL, NULL, NULL, 'gummy black sign', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-26 07:41:08.144805', NULL, NULL);
INSERT INTO public.clothing VALUES (1810, 'S', 'Tommy Hilfiger', 'T-Shirt', 'Navy', NULL, '014568', 19.99, NULL, NULL, NULL, 'block letters on chest', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-26 07:42:20.595712', NULL, NULL);
INSERT INTO public.clothing VALUES (1811, 'L', 'Tommy Hilfiger', 'T-Shirt', 'White', NULL, '816957', 5.00, NULL, NULL, NULL, 'sign on chest', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-26 07:43:04.937439', NULL, NULL);
INSERT INTO public.clothing VALUES (1812, 'XS', 'Tommy Hilfiger', 'T-Shirt', 'White', NULL, '231941', 19.99, NULL, NULL, NULL, 'red stripe on chest', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-26 07:44:39.010123', NULL, NULL);
INSERT INTO public.clothing VALUES (2092, 'S', 'Karl Lagerfeld', 'Sweat Shirt', 'White', 161, '988141', 49.99, NULL, NULL, NULL, 'rhinestones

chest: 51
length: 61
arm: 57', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-01-13 12:05:49.086725', NULL, NULL);
INSERT INTO public.clothing VALUES (1814, 'XXS', 'DKNY', 'T-Shirt', 'Black', NULL, '920757', 14.99, NULL, NULL, NULL, 'white letters on chest', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-26 07:49:48.520645', NULL, NULL);
INSERT INTO public.clothing VALUES (1815, 'S', 'Levis', 'Jean Shirt', 'Blue', NULL, '617107', 20.00, NULL, NULL, NULL, NULL, true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-26 07:50:37.138364', NULL, NULL);
INSERT INTO public.clothing VALUES (1817, 'M', 'Tommy Hilfiger', 'Dress Shirt', 'White', NULL, '210300', 20.00, NULL, NULL, NULL, NULL, true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-26 07:53:28.658267', NULL, NULL);
INSERT INTO public.clothing VALUES (1818, 'M', 'Tommy Hilfiger', 'T-Shirt', 'White', NULL, '964004', 9.00, NULL, NULL, NULL, 'cursive silver sign on chest', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-26 07:54:43.970394', NULL, NULL);
INSERT INTO public.clothing VALUES (1819, 'S', 'Levis', 'Sweat Shirt', 'Black', NULL, '214780', 15.00, NULL, NULL, NULL, 'white sign on chest', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-26 07:55:41.042487', NULL, NULL);
INSERT INTO public.clothing VALUES (1820, 'M', 'Levis', 'Sweat Shirt', 'White', NULL, '366083', 15.00, NULL, NULL, NULL, 'red sign on chest', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-26 07:56:25.352013', NULL, NULL);
INSERT INTO public.clothing VALUES (1821, 'M', 'Calvin Klein', 'Dress', 'Black', NULL, '863594', 20.00, NULL, NULL, NULL, 'white line across chest', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-26 07:57:24.105212', NULL, NULL);
INSERT INTO public.clothing VALUES (1822, 'S', 'Levis', 'Hoodie', 'Black', NULL, '975352', 15.00, NULL, NULL, NULL, 'levi strauss white circle logo', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-26 07:58:49.98546', NULL, NULL);
INSERT INTO public.clothing VALUES (1824, 'XS', 'DKNY', 'Hoodie', 'White', NULL, '002007', 14.99, NULL, NULL, NULL, 'three-quarters (3/4) sleeve', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-26 08:03:37.464823', NULL, NULL);
INSERT INTO public.clothing VALUES (1771, 'XS', 'Calvin Klein', 'Sweat Pants', 'Black', NULL, '085575', 29.99, NULL, NULL, NULL, 'stripe on waist
waist: 35
hips: 46
length: 93
pasadka: 24', true, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-23 13:28:11.26856', NULL, 0.00);
INSERT INTO public.clothing VALUES (1826, 'XS', 'Levis', 'T-Shirt', 'Black', NULL, '762713', 6.99, NULL, NULL, NULL, 'white san francisco sign on chest

chest: 43
length: 65', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-26 08:08:21.899677', NULL, NULL);
INSERT INTO public.clothing VALUES (1827, 'S', 'Levis', 'T-Shirt', 'Black', NULL, '671747', 9.99, NULL, NULL, NULL, 'romashkis / daisys on cront

chest: 43
length: 60', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-26 08:09:43.756491', NULL, NULL);
INSERT INTO public.clothing VALUES (1828, 'M', 'Levis', 'T-Shirt', 'White', NULL, '520635', 6.99, NULL, NULL, NULL, 'red logo sign on chest

chest; 45
length: 62', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-26 08:10:43.614923', NULL, NULL);
INSERT INTO public.clothing VALUES (1829, 'M', 'Levis', 'Bodysuit', 'Red', NULL, '440210', 4.00, NULL, NULL, NULL, 'chest: 40
length: 70', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-26 08:11:48.189932', NULL, NULL);
INSERT INTO public.clothing VALUES (1830, 'M', 'Levis', 'Bodysuit', 'Black', NULL, '331099', 4.00, NULL, NULL, NULL, 'chest: 40
lenth: 70', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-26 08:12:28.907629', NULL, NULL);
INSERT INTO public.clothing VALUES (1831, 'S', 'Levis', 'T-Shirt', 'Black', NULL, '671730', 9.99, NULL, NULL, NULL, 'sun picture on chest

chest: 43
length: 60', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-26 08:13:41.575621', NULL, NULL);
INSERT INTO public.clothing VALUES (2906, 'M', 'Tommy Hilfiger', 'Sweat Pants', 'Blue, Grey', 228, '006271', 28.34, NULL, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-04 05:47:14.295316', NULL, NULL);
INSERT INTO public.clothing VALUES (2984, 'L', 'DKNY', 'Dress', 'Black', 230, '366218', 24.99, NULL, 103, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-07 00:39:31.175937', NULL, 0.00);
INSERT INTO public.clothing VALUES (2930, 'M', 'Karl Lagerfeld', 'T-Shirt', 'White', NULL, 'LOORH6009', 16.99, 0.00, 97, 9, 'flower letters + eiffel tower', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 06:12:11.83476', NULL, 0.00);
INSERT INTO public.clothing VALUES (2945, '10', 'Calvin Klein', 'Blazer', 'White', 229, '006723', 19.99, NULL, 112, NULL, 'белый без пуговицы
ПОГ 52
Длина 66
рукав  56/62
плечи 42', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-06 23:18:43.945884', NULL, NULL);
INSERT INTO public.clothing VALUES (3255, '10', 'Calvin Klein', 'Jumpsuit', 'Blue', 276, '909680', 29.99, NULL, 112, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-23 00:44:48.29597', NULL, NULL);
INSERT INTO public.clothing VALUES (3184, 'S', 'Michael Kors', 'Jean Jacket', 'Black', 270, '807683', 34.99, NULL, 115, NULL, 'golden buttons
ripped at bottom
chest: 49
length: 53
arm: 58', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-20 23:55:17.502911', NULL, 0.00);
INSERT INTO public.clothing VALUES (1781, 'L', 'Calvin Klein', 'Sweat Shirt', 'Black', NULL, '809851', 19.99, NULL, NULL, NULL, 'white overlined & underlined glittery "calvin klein" on chest', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-25 02:39:51.947103', NULL, NULL);
INSERT INTO public.clothing VALUES (1880, 'M', 'DKNY', 'Panties', 'Red, Black', NULL, 'DK4509', 10.00, NULL, NULL, NULL, 'Bra + panties', true, NULL, NULL, NULL, NULL, 'ukraine', '2021-01-01 11:14:50.260537', NULL, NULL);
INSERT INTO public.clothing VALUES (3422, 'L', 'Armani Exchange', 'Polo Shirt', 'White', 283, '4423527', 19.99, NULL, NULL, NULL, 'stripe on the side
ПОГ 56
дл 72
плечи 50', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-30 21:07:49.589661', NULL, NULL);
INSERT INTO public.clothing VALUES (1832, 'M', 'Levis', 'T-Shirt', 'White', NULL, '611179', 6.99, NULL, 119, NULL, 'sign san francisco levis on chest

chest: 46
length: 62', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-26 08:14:28.464166', NULL, NULL);
INSERT INTO public.clothing VALUES (1440, 'S', 'Tommy Hilfiger', 'Panties', 'Navy, Red', 131, '875728', 7.99, NULL, NULL, NULL, 'red outline', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:13.905965', NULL, NULL);
INSERT INTO public.clothing VALUES (1453, 'XL', 'Calvin Klein', 'Man Panties', 'Blue', 132, '862432', 3.39, NULL, NULL, NULL, NULL, true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:14.021574', NULL, NULL);
INSERT INTO public.clothing VALUES (1833, 'M', 'Levis', 'T-Shirt', 'Black', NULL, '520574', 6.99, NULL, 119, NULL, 'red sign

chest: 46
length: 62', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-26 08:15:41.641114', NULL, NULL);
INSERT INTO public.clothing VALUES (3337, 'M', 'Calvin Klein', 'Panties', 'Black', 281, '454411', 6.99, NULL, 121, NULL, 'velurovie', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-27 04:12:18.764572', NULL, NULL);
INSERT INTO public.clothing VALUES (1632, 'S', 'Calvin Klein', 'Swimsuit', 'Pink', 125, '661543', 8.49, NULL, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:15.676294', NULL, 0.00);
INSERT INTO public.clothing VALUES (1835, 'S', 'Levis', 'Vest Shirt', 'Black', NULL, '555712', 15.00, NULL, NULL, NULL, 'with buttons

chest: 46
length: 52', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-26 08:17:36.383657', NULL, NULL);
INSERT INTO public.clothing VALUES (1836, 'XS', 'Calvin Klein', 'T-Shirt', 'White', NULL, '375271', 9.99, NULL, NULL, NULL, 'black/silver sign on chest', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-26 08:20:54.939735', NULL, NULL);
INSERT INTO public.clothing VALUES (3653, 'XS', 'DKNY', 'T-Shirt', 'Navy', 296, '986377', 15.98, NULL, 121, NULL, 'sequined DKNY', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-08 02:56:59.170698', NULL, 0.00);
INSERT INTO public.clothing VALUES (3496, 'XXL', 'Armani Exchange', 'Sweater', 'Navy', 287, '2336787', 19.99, NULL, 118, NULL, NULL, NULL, 'men', NULL, NULL, NULL, 'usa', '2021-04-02 21:39:09.886515', NULL, NULL);
INSERT INTO public.clothing VALUES (3580, 'M', 'Armani Exchange', 'Sweat Shirt', 'Navy', 293, '2433165', 19.99, NULL, 118, NULL, 'neopren
ПОГ 53
дл 69
рук 65', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-04-04 05:16:24.081685', NULL, NULL);
INSERT INTO public.clothing VALUES (1838, 'XS', 'Calvin Klein', 'T-Shirt', 'White', NULL, '272403', 14.99, NULL, NULL, NULL, 'red square on chest', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-26 08:25:52.68129', NULL, NULL);
INSERT INTO public.clothing VALUES (1839, 'S', 'Calvin Klein', 'T-Shirt', 'White', NULL, '196234', 9.99, NULL, NULL, NULL, 'circled logo
short', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-26 08:27:50.161631', NULL, NULL);
INSERT INTO public.clothing VALUES (2973, 'M', 'Karl Lagerfeld', 'T-Shirt', 'Black', 230, 'LORH7052', 19.99, NULL, 103, NULL, 'c паетками
ПОГ  51
ДЛ 63', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-07 00:18:19.085438', NULL, 0.00);
INSERT INTO public.clothing VALUES (2965, 'S', 'Karl Lagerfeld', 'Hoodie', 'White', 230, 'LORH7081', 14.99, NULL, 103, NULL, 'печатные буквы karl lagerfeld paris

ПОГ 53
дл 58
рук  61', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-07 00:03:12.309467', NULL, 0.00);
INSERT INTO public.clothing VALUES (3137, '---', 'DKNY', '---', '---', NULL, '196283', 19.93, NULL, 104, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-15 22:52:07.951016', NULL, NULL);
INSERT INTO public.clothing VALUES (2996, '7.5', 'Calvin Klein', 'Shoes', 'Yellow', NULL, '382982', 29.93, 40.41, 98, 9, 'pumps', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-07 23:14:40.585793', NULL, 0.00);
INSERT INTO public.clothing VALUES (2847, '11', 'Tommy Hilfiger', 'Flip Flops', 'Navy', NULL, '817147', 16.99, 22.94, 98, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 04:54:58.650957', NULL, 0.00);
INSERT INTO public.clothing VALUES (3256, 'L', 'Michael Kors', 'T-Shirt', 'Navy', 276, '056293', 16.99, NULL, 109, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-23 00:45:54.160643', NULL, NULL);
INSERT INTO public.clothing VALUES (3185, '6', 'Michael Kors', 'Jeans', 'Navy', NULL, '442852', 24.99, NULL, 115, NULL, 'selma straight
with two buttons

waist: 38
hips: 46
pasadka: 26
length: 102', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-20 23:56:02.081', NULL, 0.00);
INSERT INTO public.clothing VALUES (839, 'S', 'Tommy Hilfiger', 'Sweater', 'Navy', NULL, '777244', 10.39, NULL, NULL, NULL, 'V neck
Diamond pattern

Chest: 45
Waist: 42
Length: 64
Arm: 62', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.972956', NULL, NULL);
INSERT INTO public.clothing VALUES (837, 'M', 'Tommy Hilfiger', 'Sweater', 'Navy', NULL, '728604', 10.39, NULL, NULL, NULL, 'v-neck

chest: 48
length: 67
arm: 63', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.957954', NULL, NULL);
INSERT INTO public.clothing VALUES (1841, 'L', 'Tommy Hilfiger', 'Polo Shirt', 'Black', NULL, '887187', 17.00, NULL, NULL, NULL, 'small tommy sign on chest', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-26 12:09:59.584088', NULL, NULL);
INSERT INTO public.clothing VALUES (1843, 'M', 'Tommy Hilfiger', 'Polo Shirt', 'Red, Blue, White', NULL, '279452', 5.00, NULL, NULL, NULL, 'striped', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-26 12:13:44.539832', NULL, NULL);
INSERT INTO public.clothing VALUES (1842, 'S', 'Tommy Hilfiger', 'Polo Shirt', 'White', NULL, '752606', 16.99, NULL, NULL, NULL, 'zipper
striped', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-26 12:13:04.524333', NULL, NULL);
INSERT INTO public.clothing VALUES (1852, 'XS', 'Calvin Klein', 'Sweat Shirt', 'Black', NULL, '??????', 29.99, 54.00, NULL, 18, 'pink letters on leg', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-27 10:47:38.423593', NULL, NULL);
INSERT INTO public.clothing VALUES (1851, 'XS', 'Calvin Klein', 'Sweat Pants', 'Black', NULL, '??????', 29.99, 54.00, NULL, 18, 'pink letters on leg', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-27 10:47:33.133245', NULL, NULL);
INSERT INTO public.clothing VALUES (3007, 'S', 'Calvin Klein', 'Sweat Pants', 'White', 232, '232376', 19.99, NULL, 117, NULL, 'white sewn-in sign
black dot

waist: 38
hips: 49
pasadka: 24
length: 91', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-10 00:12:39.333902', NULL, NULL);
INSERT INTO public.clothing VALUES (3581, 'M', 'Armani Exchange', 'Sweat Shirt', 'Navy', 293, '2433165', 19.99, NULL, NULL, NULL, 'neopren
ПОГ 53
дл 69
рук 65', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-04-04 05:16:33.793659', NULL, NULL);
INSERT INTO public.clothing VALUES (3654, 'N/A', 'Guess', 'Hat', 'Pink', NULL, '666746', 11.00, NULL, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-08 03:30:54.977928', NULL, NULL);
INSERT INTO public.clothing VALUES (3423, 'L', 'Armani Exchange', 'Polo Shirt', 'White', 283, '4423527', 19.99, NULL, 123, NULL, 'stripe on the side
ПОГ 56
дл 72
плечи 50', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-30 21:07:54.589306', NULL, NULL);
INSERT INTO public.clothing VALUES (1840, 'M', 'Calvin Klein', 'T-Shirt', 'White', NULL, '196227', 10.00, 26.79, 121, 23, 'circled logo
short', true, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-26 08:28:41.109762', NULL, 0.00);
INSERT INTO public.clothing VALUES (2836, 'S', 'Calvin Klein', 'Rain Coat', 'Pearl', NULL, '360901', 40.00, 75.00, 104, 23, 'ПОГ 52
длина 75
Рукав 70', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-04 02:58:06.712381', NULL, 0.00);
INSERT INTO public.clothing VALUES (3136, 'N/A', 'Michael Kors', 'Wallet', 'White, Vanilla', NULL, '065570', 53.61, 107.14, 104, 23, 'logo print', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-15 22:51:09.861067', NULL, NULL);
INSERT INTO public.clothing VALUES (2093, 'XS', 'Karl Lagerfeld', 'Sweater', 'White', 161, '811609', 49.99, NULL, NULL, NULL, 'chest: 47
length: 60
arm: 47

three-quarters sleeve', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-01-13 12:07:03.552399', NULL, NULL);
INSERT INTO public.clothing VALUES (1853, 'M', 'Calvin Klein', 'Sweat Pants', 'Black', NULL, '??????', 29.99, 52.44, NULL, 18, 'pink letters', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-27 10:48:25.190607', NULL, NULL);
INSERT INTO public.clothing VALUES (1844, 'S', 'Calvin Klein', 'Hoodie', 'Pink, Orange', NULL, '??????', 29.99, 48.95, NULL, 15, 'sold for 1400', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-27 09:55:38.247821', NULL, NULL);
INSERT INTO public.clothing VALUES (1845, 'S', 'Calvin Klein', 'Puffy Jacket', 'Black', NULL, '??????', 54.00, 108.39, NULL, 15, 'sold for 3100
delivery: $5', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-27 09:59:14.057241', NULL, NULL);
INSERT INTO public.clothing VALUES (1846, '1SZ', 'Calvin Klein', 'Hat', 'Grey', NULL, '555773', 12.00, 31.47, NULL, 17, 'sold for 900
devlivery $5', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-27 10:27:25.985142', NULL, NULL);
INSERT INTO public.clothing VALUES (1864, 'N/A', 'Karl Lagerfeld', 'Bag', 'Black', NULL, '202275', 34.99, NULL, NULL, NULL, 'bumpy cirlces spell "karl"
length: 45
height: 35', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-27 12:39:25.543251', NULL, NULL);
INSERT INTO public.clothing VALUES (1847, '1SZ', 'Calvin Klein', 'Hat', 'Grey', NULL, '461288', 12.32, 31.47, NULL, 17, 'sold for 900
delivery $5', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-27 10:29:16.245957', NULL, NULL);
INSERT INTO public.clothing VALUES (3009, 'S', 'Guess', 'T-Shirt', 'White', 232, '079412', 12.99, NULL, 106, NULL, 'triangle question mark

chest: 42
length: 62', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-10 00:14:05.702657', NULL, 0.00);
INSERT INTO public.clothing VALUES (3424, 'M', 'Armani Exchange', 'Polo Shirt', 'White', 283, '7780638', 19.99, NULL, 123, NULL, 'also tag number 7120632

stripe on the sholder
ПОГ 52
дл 73
', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-30 21:09:55.8109', NULL, 0.00);
INSERT INTO public.clothing VALUES (3139, 'S', 'Calvin Klein', 'Sweat Shirt', 'Tan', NULL, '550081', 27.77, 50.00, NULL, 22, 'from macys
half neck
black gloss letters on chest', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-15 23:05:05.361528', NULL, 4.00);
INSERT INTO public.clothing VALUES (3042, 'XS', 'Tommy Hilfiger', 'Golfik', 'Navy, Red', NULL, '??????', 22.24, NULL, NULL, NULL, 'tommy sign on chest', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-11 04:01:38.317474', NULL, 3.00);
INSERT INTO public.clothing VALUES (3041, 'S', 'Tommy Hilfiger', 'Golfik', 'Navy, Red', NULL, '??????', 22.24, 46.43, NULL, 19, 'tommy sign on chest', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-11 04:01:13.872834', NULL, 3.00);
INSERT INTO public.clothing VALUES (3497, 'M', 'Armani Exchange', 'Vest Jacket', 'Red', 287, '0477748', 28.50, 38.92, 125, 9, NULL, NULL, 'men', NULL, NULL, NULL, 'usa', '2021-04-02 21:43:11.963716', NULL, NULL);
INSERT INTO public.clothing VALUES (1837, 'M', 'Calvin Klein', 'T-Shirt', 'White', NULL, '272427', 14.99, 32.14, NULL, 23, 'red square on chest', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-26 08:25:31.840941', NULL, NULL);
INSERT INTO public.clothing VALUES (2948, 'S', 'Calvin Klein', 'Sweat Shirt', 'Light Blue', 229, '204205', 19.99, 50.00, 117, 23, 'белый calvin klein jeans на груди
ПОГ 54
ДЛ 52
рукав 49/73', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-06 23:24:16.276838', NULL, NULL);
INSERT INTO public.clothing VALUES (3498, 'L', 'Armani Exchange', 'Jean Jacket', 'Navy', 287, '0336045', 49.99, NULL, 120, NULL, NULL, NULL, 'men', NULL, NULL, NULL, 'usa', '2021-04-02 21:44:02.916392', NULL, NULL);
INSERT INTO public.clothing VALUES (1855, 'N/A', 'Calvin Klein', 'Purse', 'Brown', NULL, '435530', 20.00, 58.93, NULL, 22, 'length: 24
height: 18', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-27 11:56:16.982223', NULL, NULL);
INSERT INTO public.clothing VALUES (1848, 'S', 'Tommy Hilfiger', 'Golfik', 'Navy, White, Red', NULL, '??????', 24.99, 45.45, NULL, 17, 'sold for 1300', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-27 10:34:18.949181', NULL, NULL);
INSERT INTO public.clothing VALUES (1849, 'S', 'Calvin Klein', 'Sweat Shirt', 'Black', NULL, '687176', 24.99, 52.00, NULL, 18, 'sold with 827190
Long neck, "performance" tag
large white "Calvin" on chest

Chest: 58
Waist: 50
Length: 57
Arm: 43', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-27 10:45:35.84771', NULL, NULL);
INSERT INTO public.clothing VALUES (3257, 'S', 'Karl Lagerfeld', 'Dress', 'Grey', 276, 'LD1R9559', 16.99, NULL, 112, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-23 00:46:39.765331', NULL, NULL);
INSERT INTO public.clothing VALUES (3186, '4', 'Michael Kors', 'Jeans', 'Navy', 270, '442845', 24.99, NULL, 115, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-21 00:00:30.443061', NULL, 0.00);
INSERT INTO public.clothing VALUES (1850, 'S', 'Calvin Klein', 'Sweat Pants', 'Black', NULL, '827190', 29.99, 52.00, NULL, 18, 'sold with 687176
"calvin" on back of calf', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-27 10:45:42.045891', NULL, NULL);
INSERT INTO public.clothing VALUES (3050, '7', 'Calvin Klein', 'Flip Flops', 'Black', 234, '960168', 14.99, NULL, 115, NULL, 'чёрные с  серыми буквами, стелька 24,5 см идут на 37.5', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-11 20:01:15.027504', NULL, NULL);
INSERT INTO public.clothing VALUES (1854, 'S', 'Victorias Secret', 'Romper', 'Black', NULL, '552105', 16.99, NULL, NULL, NULL, 'delivery $5', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-27 11:47:03.598337', NULL, NULL);
INSERT INTO public.clothing VALUES (1856, 'N/A', 'Calvin Klein', 'Purse', 'Brown', NULL, '391461', 20.00, NULL, NULL, NULL, 'length: 24
height: 16', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-27 12:03:41.735388', NULL, NULL);
INSERT INTO public.clothing VALUES (1857, '1SZ', 'Tommy Hilfiger', 'Hat', 'Navy', NULL, '561884', 15.00, NULL, NULL, NULL, 'beanie cap
red/white stripe around forehead', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-27 12:06:01.723403', NULL, NULL);
INSERT INTO public.clothing VALUES (1865, 'N/A', 'DKNY', 'Purse', 'Black', NULL, '437638', 22.99, NULL, NULL, NULL, 'length: 20
height: 11', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-27 12:41:44.516195', NULL, NULL);
INSERT INTO public.clothing VALUES (1858, '1SZ', 'DKNY', 'Purse', 'Black, White, Red', NULL, '397604', 35.00, NULL, NULL, NULL, 'wide white stripe
thin red stripe

length: 25
height: 17', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-27 12:14:29.201761', NULL, NULL);
INSERT INTO public.clothing VALUES (1859, 'M', 'Levis', 'Sweat Shirt', 'Black', NULL, '366366', 15.00, NULL, NULL, NULL, 'white sign on chest', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-27 12:17:57.732048', NULL, NULL);
INSERT INTO public.clothing VALUES (1878, 'S', 'Calvin Klein', 'Jacket', 'Black', NULL, '022472', 39.99, NULL, NULL, NULL, 'delivery $4
cold sleeves

chest: 48
waist: 42
hips: 51
length: 70
arm from neck: 73', true, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-01 11:02:02.490369', NULL, 0.00);
INSERT INTO public.clothing VALUES (1861, 'N/A', 'Karl Lagerfeld', 'Purse', 'White', NULL, '991271', 0.00, NULL, NULL, NULL, 'was free gift
red line + black lines + eiffel tower
length: 21
height: 15', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-27 12:29:54.437225', NULL, NULL);
INSERT INTO public.clothing VALUES (1860, 'N/A', 'Karl Lagerfeld', 'Purse', 'White', NULL, '991271', 0.00, NULL, NULL, NULL, 'was free gift
red line + black lines + eiffel tower
length: 21
height: 15', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-27 12:29:51.730177', NULL, NULL);
INSERT INTO public.clothing VALUES (1862, 'N/A', 'Calvin Klein', 'Purse', 'Brown', NULL, '974870', 35.00, NULL, NULL, NULL, 'pink strap
length: 25
height: 17', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-27 12:34:13.549929', NULL, NULL);
INSERT INTO public.clothing VALUES (3582, 'M', 'Armani Exchange', 'Sweat Shirt', 'Navy', 293, '2433165', 19.99, NULL, NULL, NULL, 'neopren
ПОГ 53
дл 69
рук 65', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-04-04 05:16:36.727774', NULL, NULL);
INSERT INTO public.clothing VALUES (3655, '???', 'Calvin Klein', 'Flip Flops', 'Black', 297, '733768', 30.60, NULL, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-08 03:42:11.100139', NULL, NULL);
INSERT INTO public.clothing VALUES (1868, '27', 'Calvin Klein', 'Shorts', 'White', NULL, '457724', 14.72, NULL, NULL, NULL, 'waist: 37
hips: 48
length: 33
pasadka: 26', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-28 14:11:56.039145', NULL, NULL);
INSERT INTO public.clothing VALUES (3339, 'XL', 'Calvin Klein', 'Panties', 'Black', 281, '454435', 6.99, NULL, 122, NULL, 'velurovie', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-27 04:12:50.263077', NULL, NULL);
INSERT INTO public.clothing VALUES (1863, 'N/A', 'Levis', 'Bag', 'Black', NULL, '682680', 8.99, NULL, NULL, NULL, 'tote bag
purple + stars

length: 42
height: 40', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-27 12:35:47.570823', NULL, NULL);
INSERT INTO public.clothing VALUES (1867, 'XS', 'Calvin Klein', 'Sweat Shirt', 'White', NULL, '966868', 20.82, NULL, NULL, NULL, 'delivery $2
color is cream
stripe on shoulder

chest: 55
length: 59/66
arm: 43/66', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-28 14:10:29.914751', NULL, NULL);
INSERT INTO public.clothing VALUES (1866, 'XS', 'Calvin Klein', 'Sweat Shirt', 'White', NULL, '966868', 20.82, NULL, NULL, NULL, 'delivery $2
color is cream
stripe on shoulder

chest: 55
length: 59/66
arm: 43/66', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-28 14:10:27.254975', NULL, NULL);
INSERT INTO public.clothing VALUES (1869, '28', 'Calvin Klein', 'Shorts', 'White', NULL, '457717', 14.72, NULL, NULL, NULL, 'waist: 39
hips: 49
length: 34
pasadka: 27', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-28 14:12:58.371596', NULL, NULL);
INSERT INTO public.clothing VALUES (1871, 'S', 'Calvin Klein', 'Sweat Shirt', 'Black', NULL, '084135', 20.83, NULL, NULL, NULL, 'White outlined black stripe with "cavin klein ck" across chest

Chest: 57
Waist: 48
Length: 43
Arm: 43', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-28 14:16:39.578173', NULL, NULL);
INSERT INTO public.clothing VALUES (1872, 'XS', 'Calvin Klein', 'Sweat Shirt', 'White', NULL, '084043', 20.83, NULL, NULL, NULL, 'Black line + white outlined "calvin ck" across chest', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-28 14:18:10.666808', NULL, NULL);
INSERT INTO public.clothing VALUES (81, 'S', 'Calvin Klein', 'Hoodie', 'Unknown', 9, '795178', 29.49, 54.20, NULL, 2, 'sent in package 1.2', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:54.344567', NULL, NULL);
INSERT INTO public.clothing VALUES (1873, 'S', 'Calvin Klein', 'Sweat Pants', 'Black', NULL, '082926', 20.82, NULL, NULL, NULL, 'White outlined black stripe with "cavin klein ck" down leg

Waist: 38
Hips: 50
Length: 90
Pasadka: 25', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-28 14:20:07.522456', NULL, NULL);
INSERT INTO public.clothing VALUES (1875, 'M', 'Calvin Klein', 'Sweat Shirt', 'Black', NULL, '074524', 20.82, NULL, NULL, NULL, 'white stripe on sleeve

chest: 55
length: 60
arm: 47/71', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-28 14:21:25.870947', NULL, NULL);
INSERT INTO public.clothing VALUES (3043, 'XS', 'Calvin Klein', 'Puffy Jacket', 'White', NULL, '056377', 46.00, NULL, NULL, NULL, 'rainbow spacesuit

chest: 57
length: 80
arm: 60', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-11 04:36:51.334698', NULL, 5.00);
INSERT INTO public.clothing VALUES (506, 'XS', 'Calvin Klein', 'Sweat Shirt', 'Black', 15, '084142', 21.25, 50.00, NULL, 19, 'White outlined black stripe with "cavin klein ck" across chest

Chest: 55
Waist: 44
Length: 42
Arm: 42', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.089525', NULL, 0.00);
INSERT INTO public.clothing VALUES (2210, 'M', 'DKNY', 'Polo Shirt', 'Navy', 173, '036737', 14.99, 0.00, 68, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-21 17:41:39.407113', NULL, 0.00);
INSERT INTO public.clothing VALUES (3125, 'M', 'Tommy Hilfiger', 'Polo Shirt', 'Black', NULL, '820209', 17.99, NULL, 107, NULL, 'white stripe on shoulders

Chest: 48
Length: 66


', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-13 05:20:32.279645', NULL, 0.00);
INSERT INTO public.clothing VALUES (3063, '7.5', 'Calvin Klein', 'Shoes', 'Black', 235, 'CKS000', 29.99, NULL, 109, NULL, 'white laces
white ck
white-rimmed sole', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-12 23:37:58.48964', NULL, NULL);
INSERT INTO public.clothing VALUES (3062, 'M', 'Calvin Klein', 'Blouse', 'Black', NULL, '217427', 21.99, NULL, 110, NULL, 'gold buttons', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-12 23:34:32.794493', NULL, NULL);
INSERT INTO public.clothing VALUES (3258, '10', 'Karl Lagerfeld', 'Jeans', 'Blue', 276, '510887002499', 24.99, NULL, 112, NULL, 'с полоской с боку
', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-23 00:46:54.620516', NULL, 0.00);
INSERT INTO public.clothing VALUES (3187, '6', 'Calvin Klein', 'Dress', 'Blue', 270, '203925', 29.99, NULL, 115, NULL, 'gold zipper
chest: 47
waist: 36
Hips: 48
length: 97', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-21 00:01:39.774093', NULL, 0.00);
INSERT INTO public.clothing VALUES (3425, 'M', 'Armani Exchange', 'Polo Shirt', 'White', 283, '7120632', 19.99, NULL, NULL, NULL, 'stripe on the sholder
ПОГ 52
дл 73
', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-30 21:10:01.41173', NULL, NULL);
INSERT INTO public.clothing VALUES (3656, '???', 'Calvin Klein', 'Flip Flops', 'Black', 297, '733720', 30.60, NULL, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-08 03:42:23.25292', NULL, NULL);
INSERT INTO public.clothing VALUES (3340, 'XL', 'Calvin Klein', 'Sport Bra', 'Black', 281, '454282', 6.99, NULL, 122, NULL, 'velurovie', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-27 04:13:15.8086', NULL, NULL);
INSERT INTO public.clothing VALUES (3583, 'XXL', 'Armani Exchange', 'Sweat Shirt', 'Navy', 293, '2433202', 19.99, NULL, 118, NULL, 'neopren
ПОГ 53
дл 69
рук 65', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-04-04 05:17:13.665279', NULL, NULL);
INSERT INTO public.clothing VALUES (3499, 'M', 'Armani Exchange', 'Sherpa', 'Navy', 287, '0369449', 49.99, NULL, 120, NULL, NULL, NULL, 'men', NULL, NULL, NULL, 'usa', '2021-04-02 21:44:42.444994', NULL, NULL);
INSERT INTO public.clothing VALUES (3065, '10', 'Calvin Klein', 'Dress', 'Pink', 235, '203970', 29.99, NULL, 127, NULL, 'gold zipper
chest: 43
waist: 37
length: 100', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-12 23:47:53.978994', NULL, NULL);
INSERT INTO public.clothing VALUES (1874, 'M', 'Calvin Klein', 'Sweat Shirt', 'Black', NULL, '074524', 20.82, NULL, NULL, NULL, 'white stripe on sleeve

chest: 55
length: 60
arm: 47/71', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-28 14:21:23.671364', NULL, NULL);
INSERT INTO public.clothing VALUES (1877, 'M', 'Calvin Klein', 'Jacket', 'White, Black', NULL, '571597', 59.99, NULL, NULL, NULL, 'cold back', true, NULL, NULL, NULL, NULL, 'ukraine', '2021-01-01 10:55:11.761787', NULL, NULL);
INSERT INTO public.clothing VALUES (1339, '32X30', 'Armani Exchange', 'Pants', 'Navy', 60, '954902', 14.99, NULL, NULL, NULL, 'dark navy
Waist: 45
Hips: 55
Length: 100
Pasadka: 27', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:12.961308', NULL, NULL);
INSERT INTO public.clothing VALUES (1074, 'S', 'Calvin Klein', 'T-Shirt', 'Black', 86, '711308', 10.04, NULL, NULL, NULL, 'white CK, grey letters on front', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:10.48907', NULL, NULL);
INSERT INTO public.clothing VALUES (1881, 'M', 'Calvin Klein', 'Swimsuit', 'Black', NULL, '858118', 15.00, NULL, NULL, NULL, 'M top
L bottom', true, NULL, NULL, NULL, NULL, 'ukraine', '2021-01-01 11:20:42.393841', NULL, NULL);
INSERT INTO public.clothing VALUES (1882, 'M', 'Levis', 'Boxers', 'Navy', NULL, '076976', 6.00, NULL, NULL, NULL, '3 pack', true, NULL, NULL, NULL, NULL, 'ukraine', '2021-01-01 11:22:42.740019', NULL, NULL);
INSERT INTO public.clothing VALUES (1883, 'M', 'Calvin Klein', 'Man Panties', 'Purple', NULL, '862852', 5.00, NULL, NULL, NULL, NULL, true, NULL, NULL, NULL, NULL, 'ukraine', '2021-01-01 11:24:39.686395', NULL, NULL);
INSERT INTO public.clothing VALUES (1167, 'M', 'Calvin Klein', 'T-Shirt', 'Black', 100, '711315', 11.89, NULL, NULL, NULL, 'White CK, grey letters on front', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:11.353107', NULL, NULL);
INSERT INTO public.clothing VALUES (1996, 'XS', 'Calvin Klein', 'Belt', 'Brown', 154, '269677', 3.51, 28.57, 81, 22, 'Logo belt
length: 87
', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 11:50:06.322888', NULL, 0.00);
INSERT INTO public.clothing VALUES (3341, '7.5', 'Michael Kors', 'Shoes', 'Tan', 282, '623854006999', 69.99, NULL, NULL, NULL, 'кремовые с коричневым лого принтом
стелька 24 см', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-27 04:16:38.380455', NULL, NULL);
INSERT INTO public.clothing VALUES (3426, 'M', 'Armani Exchange', 'Polo Shirt', 'White', 283, '7120632', 19.99, NULL, NULL, NULL, 'stripe on the sholder
ПОГ 52
дл 73
', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-30 21:10:04.539112', NULL, NULL);
INSERT INTO public.clothing VALUES (3500, 'One Size', 'Armani Exchange', 'Scarf', 'Navy', 287, '0522486', 9.99, NULL, NULL, NULL, NULL, NULL, 'men', NULL, NULL, NULL, 'usa', '2021-04-02 21:45:41.700072', NULL, NULL);
INSERT INTO public.clothing VALUES (3657, '8', 'Nike', 'Shoes', 'Black, Purple', NULL, 'Nike001', 59.97, NULL, 121, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-08 03:48:05.860688', NULL, 0.00);
INSERT INTO public.clothing VALUES (3188, '10', 'Calvin Klein', 'Dress', 'Blue', 270, '203901', 29.99, NULL, 122, NULL, 'gold zipper
chest: 50
waist: 40
Hips: 51
length: 101
', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-21 00:02:31.773773', NULL, 0.00);
INSERT INTO public.clothing VALUES (3259, '10', 'DKNY', 'Dress', 'Blue', 276, '325867', 29.99, NULL, 122, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-23 00:47:57.545236', NULL, 0.00);
INSERT INTO public.clothing VALUES (3584, 'L', 'Armani Exchange', 'Sweat Shirt', 'Black', 293, '2433097', 19.99, NULL, 125, NULL, 'neopren
ПОГ 58
дл 69
рук 65', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-04-04 05:18:21.541683', NULL, NULL);
INSERT INTO public.clothing VALUES (5, 'XS', 'Levis', 'Leather Jacket', 'Black', 1, '516760', 34.99, NULL, 81, NULL, 'Fluffy inside
Bomber jacket

Chest: 48
Waist: 46
Length: 56
Arm: 63', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:53.672862', NULL, 0.00);
INSERT INTO public.clothing VALUES (88, 'M', 'Guess', 'Vest Jacket', 'Black', 10, '498868', 29.99, NULL, 84, NULL, 'puffy
hooded

Chest: 56
Waist: 55
Length: 68', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.404651', NULL, 0.00);
INSERT INTO public.clothing VALUES (135, '28', 'Calvin Klein', 'Jeans', 'Blue', 15, '422661', 20.27, NULL, 6, NULL, 'Mid rise slim boyfriend
Holes in knees

Waist: 41
Hips: 51
Length: 97
Pasadka: 24', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.856563', NULL, NULL);
INSERT INTO public.clothing VALUES (180, 'M', 'Calvin Klein', 'Sweat Shirt', 'Black', NULL, '383727', 24.99, NULL, 5, NULL, 'White "calvin klein" between two white lines on chest

Chest: 52
Waist: 52
Length: 69
Arm: 69', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:55.243836', NULL, NULL);
INSERT INTO public.clothing VALUES (327, 'XS', 'Calvin Klein', 'Sweater', 'White', 28, '364626', 7.91, NULL, 8, NULL, 'with stars

chest: 60
length: 45
arm: 53-74', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.514563', NULL, NULL);
INSERT INTO public.clothing VALUES (2352, 'S', 'Calvin Klein', 'Gloves', 'Black', 188, '543060', 8.49, NULL, 78, NULL, 'width: 11
length: 23', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-31 15:10:41.075526', NULL, 0.00);
INSERT INTO public.clothing VALUES (468, 'M', 'Calvin Klein', 'Gloves', 'Black', 34, '543077', 9.97, NULL, 78, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.756021', NULL, 0.00);
INSERT INTO public.clothing VALUES (3189, '2', 'Calvin Klein', '2', 'Blue', 270, '247271', 29.99, NULL, NULL, NULL, 'wings on shoulder
cerulean
chest: 44
waist: 37
hips: 48
length: 90', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-21 00:04:51.391135', NULL, NULL);
INSERT INTO public.clothing VALUES (3342, '8', 'Michael Kors', 'Shoes', 'Tan', 282, '861647004999', 49.99, NULL, NULL, NULL, 'кремовые
каблук 8 см
стелька 25см ', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-27 04:18:34.811938', NULL, NULL);
INSERT INTO public.clothing VALUES (3260, 'M', 'Michael Kors', 'Cardigan', 'Tan', 276, '646947', 29.99, NULL, 120, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-23 00:48:41.493182', NULL, NULL);
INSERT INTO public.clothing VALUES (3501, 'One Size', 'Armani Exchange', 'Scarf', 'Navy', 287, '0522486', 9.99, NULL, NULL, NULL, NULL, NULL, 'men', NULL, NULL, NULL, 'usa', '2021-04-02 21:45:46.104472', NULL, NULL);
INSERT INTO public.clothing VALUES (3585, '6', 'Armani Exchange', 'Blazer', 'Pink', 293, '4365421', 39.99, NULL, NULL, NULL, 'ПОГ 51
дл 77
рук 61
плечи 42', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-04 05:19:29.531849', NULL, 0.00);
INSERT INTO public.clothing VALUES (3658, 'S', 'Armani Exchange', 'Polo Shirt', 'Black', NULL, '780461', 19.99, NULL, 121, NULL, 'zipper', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-08 03:52:23.151997', NULL, NULL);
INSERT INTO public.clothing VALUES (3427, 'L', 'Armani Exchange', 'Polo Shirt', 'White', 283, '7780621', 19.99, NULL, 123, NULL, 'stripe on the sholder
also tag number 7180621
ПОГ 56
дл 74
', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-30 21:11:36.023302', NULL, 0.00);
INSERT INTO public.clothing VALUES (1739, 'S', 'Karl Lagerfeld', 'Sweat Pants', 'Black', NULL, '347310', 0.00, NULL, NULL, NULL, 'Stripe on side

waist: 42
hips: 52
length: 100
pasadka: 27', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 07:56:35.703926', NULL, NULL);
INSERT INTO public.clothing VALUES (1886, 'XS', 'Levis', 'Jean Jacket', 'Blue', NULL, '150865', 0.00, NULL, NULL, NULL, 'chest: 47
length: 57
arm: 55/71', true, NULL, NULL, NULL, NULL, 'ukraine', '2021-01-01 11:47:06.18675', NULL, NULL);
INSERT INTO public.clothing VALUES (1887, '4PX29', 'Ralph Lauren', 'Jeans', 'Blue', NULL, '322021', 15.00, NULL, NULL, NULL, 'waist: 35
hips: 42
length: 92
pasadka: 22', true, NULL, NULL, NULL, NULL, 'ukraine', '2021-01-02 06:51:30.525061', NULL, NULL);
INSERT INTO public.clothing VALUES (1888, '6', 'Michael Kors', 'Jeans', 'Navy', NULL, 'MK001', 16.99, NULL, NULL, NULL, 'buttons on front

waist: 38
hips: 45
pasadka: 26
length: 98', true, NULL, NULL, NULL, NULL, 'ukraine', '2021-01-02 06:54:02.390114', NULL, NULL);
INSERT INTO public.clothing VALUES (1903, '2', 'Tommy Hilfiger', 'Dress Pants', 'Blue', NULL, '638194', 15.00, NULL, NULL, NULL, 'waist: 38
hips: 47
pasadka: 23
length: 89', true, NULL, NULL, NULL, NULL, 'ukraine', '2021-01-02 07:26:04.328294', NULL, NULL);
INSERT INTO public.clothing VALUES (1171, 'S', 'Calvin Klein', 'T-Shirt', 'Black', 100, '844779', 10.11, NULL, NULL, NULL, 'yellow big letters', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:11.395156', NULL, NULL);
INSERT INTO public.clothing VALUES (1186, 'S', 'Calvin Klein', 'T-Shirt', 'Black', 104, '599325', 7.90, NULL, NULL, NULL, 'Gold CK, white letters on front', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:11.534796', NULL, NULL);
INSERT INTO public.clothing VALUES (1299, 'XS', 'Calvin Klein', 'Dress', 'Grey', 56, '641988', 19.99, NULL, NULL, NULL, 'Pink letters

Chest: 43
Waist: 43
Length: 85', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:12.562814', NULL, NULL);
INSERT INTO public.clothing VALUES (1446, 'L', 'Tommy Hilfiger', 'Sweater', 'Blue', 131, '730942', 7.99, NULL, NULL, NULL, 'v-neck', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:13.959582', NULL, NULL);
INSERT INTO public.clothing VALUES (3261, 'S', 'Michael Kors', 'Cardigan', 'Tan', 276, '646930', 29.99, NULL, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-23 00:48:46.654164', NULL, NULL);
INSERT INTO public.clothing VALUES (3343, '4', 'Michael Kors', 'Jeans', 'Navy', 282, '442845', 24.99, NULL, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-27 04:19:27.127936', NULL, 0.00);
INSERT INTO public.clothing VALUES (3428, 'L', 'Armani Exchange', 'Polo Shirt', 'White', 283, '7180621', 19.99, NULL, NULL, NULL, 'stripe on the sholder
ПОГ 56
дл 74
', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-30 21:11:48.289892', NULL, NULL);
INSERT INTO public.clothing VALUES (3190, '8', 'DKNY', 'Shoes', 'Tan', 271, '56958200329911', 32.99, NULL, 120, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-21 00:07:01.808415', NULL, NULL);
INSERT INTO public.clothing VALUES (3502, 'One Size', 'Armani Exchange', 'Scarf', 'Navy', 287, '0522486', 9.99, NULL, NULL, NULL, NULL, NULL, 'men', NULL, NULL, NULL, 'usa', '2021-04-02 21:45:50.18501', NULL, NULL);
INSERT INTO public.clothing VALUES (3659, 'S', 'Calvin Klein', 'Windbreaker', 'White', 298, '415199', 49.99, NULL, NULL, NULL, NULL, NULL, 'men', NULL, NULL, NULL, 'usa', '2021-04-08 05:03:31.113154', NULL, NULL);
INSERT INTO public.clothing VALUES (3586, 'M', 'Armani Exchange', 'Blazer', 'Black', 293, '0405826', 49.99, NULL, 127, NULL, 'без подкладкм с мал знаком на гр
ПОГ 53
дл 71
рук 64', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-04-04 05:22:47.685747', NULL, 0.00);
INSERT INTO public.clothing VALUES (1556, 'XS', 'Calvin Klein', 'T-Shirt', 'Black', 141, '599288', 6.72, NULL, NULL, NULL, 'White + yellow letters

Chest: 46
Waist: 46
Length: 43', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:14.974228', NULL, NULL);
INSERT INTO public.clothing VALUES (1072, 'M', 'Calvin Klein', 'T-Shirt', 'White', 86, '848229', 10.04, NULL, NULL, NULL, 'big square on chest', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:10.470862', NULL, NULL);
INSERT INTO public.clothing VALUES (1184, 'M', 'Calvin Klein', 'T-Shirt', 'White', 103, '197990', 7.90, NULL, NULL, NULL, 'city picture on chest', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:11.516395', NULL, NULL);
INSERT INTO public.clothing VALUES (1397, 'XL', 'Calvin Klein', 'T-Shirt', 'Navy', 126, '557265', 6.71, NULL, NULL, NULL, 'large white square, blue ck', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:13.484859', NULL, NULL);
INSERT INTO public.clothing VALUES (1101, 'S', 'Calvin Klein', 'T-Shirt', 'Black', 88, '197921', 6.37, NULL, NULL, NULL, 'city picture on chest', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:10.733175', NULL, NULL);
INSERT INTO public.clothing VALUES (876, 'XL', 'Calvin Klein', 'T-Shirt', 'White', 59, '557746', 5.95, NULL, NULL, NULL, 'Large red square

Chest: 60
Waist: 57
Length: 71', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:08.59303', NULL, NULL);
INSERT INTO public.clothing VALUES (136, 'XS', 'Calvin Klein', 'Hoodie', 'Black', 16, '291212', 14.25, 46.43, 5, 22, 'large circle logo on front

Chest: 58
Waist: 50
Length: 49
Arm: 46', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.865694', NULL, NULL);
INSERT INTO public.clothing VALUES (3262, '6', 'Calvin Klein', 'Shoes', 'White', 276, '983797002599', 25.99, NULL, 112, NULL, 'black CK
black stripe on back', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-23 00:49:57.922507', NULL, 0.00);
INSERT INTO public.clothing VALUES (3344, 'M', 'Michael Kors', 'T-Shirt', 'Black', 282, '630410', 19.99, NULL, 118, NULL, 'с зол замочком на гр', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-27 04:20:50.88563', NULL, NULL);
INSERT INTO public.clothing VALUES (3191, '8', 'Tommy Hilfiger', 'Flip Flops', 'White', 271, '07056100249912', 24.99, NULL, 118, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-21 00:07:37.763844', NULL, 0.00);
INSERT INTO public.clothing VALUES (3429, 'L', 'Armani Exchange', 'Polo Shirt', 'White', 283, '7180621', 19.99, NULL, NULL, NULL, 'stripe on the sholder
ПОГ 56
дл 74
', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-30 21:11:52.803574', NULL, NULL);
INSERT INTO public.clothing VALUES (3587, 'XL', 'Armani Exchange', 'Blazer', 'Black', 293, '0405840', 49.99, NULL, NULL, NULL, 'без подкладкм с мал знаком на гр
ПОГ 58
дл 72
рук 67
плечи 52', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-04-04 05:24:00.997639', NULL, 0.00);
INSERT INTO public.clothing VALUES (3660, 'S', 'Tommy Hilfiger', 'Dress', 'Blue', 298, '408887', 19.99, NULL, 122, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-08 05:04:34.645219', NULL, NULL);
INSERT INTO public.clothing VALUES (3503, 'One Size', 'Armani Exchange', 'Purse', 'Black', 287, '4634946', 49.99, NULL, 125, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-02 21:46:42.823029', NULL, NULL);
INSERT INTO public.clothing VALUES (176, 'S', 'Tommy Hilfiger', 'Sweater', 'Navy', 18, '728598', 10.39, NULL, 15, NULL, 'V neck
Diamond pattern

Chest: 45
Waist: 42
Length: 64
Arm: 62', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:55.210877', NULL, NULL);
INSERT INTO public.clothing VALUES (146, 'XS', 'Calvin Klein', 'Sweat Shirt', 'Red', 17, '784929', 28.83, 50.88, 24, 4, 'sold for 2900
sold with 5414

Black shoulder stripe

Chest: 61
Waist: 53
Length: 58
Arm: 43', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.961425', NULL, NULL);
INSERT INTO public.clothing VALUES (137, 'XS', 'Calvin Klein', 'Sweater', 'Black', 15, '954421', 23.63, NULL, 26, NULL, 'with hood

Chest: 49
Waist: 47
Length: 56
Arm: 50', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.880765', NULL, NULL);
INSERT INTO public.clothing VALUES (162, 'M', 'Calvin Klein', 'Puffy Jacket', 'Black', NULL, '309740', 69.99, 111.89, 10, 15, 'sold for 3200
Shiny
Red line around hood + bottom + wrists

Chest: 58
Waist: 55
Length: 68
Arm: 63', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:55.096688', NULL, NULL);
INSERT INTO public.clothing VALUES (3263, '8.5', 'Calvin Klein', 'Shoes', 'White', NULL, '983797002599', 25.99, NULL, 112, NULL, 'black CK
black stripe on back', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-23 00:50:21.279987', NULL, 0.00);
INSERT INTO public.clothing VALUES (891, 'L', 'Armani Exchange', 'T-Shirt', 'White', 60, '142954', 20.99, 39.29, NULL, 22, 'large grey/black square on chest

chest: 53
waist: 53
length: 73', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:08.733852', NULL, NULL);
INSERT INTO public.clothing VALUES (3430, 'M', 'Armani Exchange', 'Polo Shirt', 'White', 283, '7027405', 19.99, NULL, NULL, NULL, 'слова Armani Exchange с лева в столб
маломерит
ПОГ 50
дл 69
Плечи 47
', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-30 21:15:22.914881', NULL, NULL);
INSERT INTO public.clothing VALUES (3345, 'M', 'Calvin Klein', 'Hoodie', 'Tan', 282, '436502002299', 22.99, NULL, 122, NULL, 'sleevless hoodie', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-27 04:22:03.534351', NULL, NULL);
INSERT INTO public.clothing VALUES (3661, 'S', 'Tommy Hilfiger', 'Hoodie', 'Pink', 298, '788431', 24.99, NULL, NULL, NULL, 'oversised
ПОГ 60
дл 62
рук 58/80', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-08 05:06:31.458325', NULL, NULL);
INSERT INTO public.clothing VALUES (3504, '8', 'Armani Exchange', 'Blazer', 'Black', 287, '4365759', 39.99, NULL, 124, NULL, 'с полоской с боку', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-02 21:48:35.793427', NULL, NULL);
INSERT INTO public.clothing VALUES (3588, 'XS', 'Armani Exchange', 'Golfik', 'Black', 293, '0324158', 29.99, NULL, 127, NULL, 'с розово золотыми буквами Армани
ПОГ 43
дл 54
рук 62', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-04 05:28:09.685696', NULL, NULL);
INSERT INTO public.clothing VALUES (2285, 'N/A', 'Calvin Klein', 'Wallet', 'Black', 182, '297731', 9.99, NULL, 81, NULL, 'length: 11
height: 8.5', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-23 21:36:25.771833', NULL, 0.00);
INSERT INTO public.clothing VALUES (2110, 'S', 'DKNY', 'Puffy Jacket', 'Black', NULL, '391329', 49.99, 101.79, 63, 19, 'from costco

chest: 53
length: 87
arm: 63
shoulders: 42', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-16 14:40:27.757229', NULL, 11.23);
INSERT INTO public.clothing VALUES (1144, 'M', 'Calvin Klein', 'T-Shirt', 'Blue', 96, '557845', 6.71, NULL, NULL, NULL, 'red square in front', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:11.144171', NULL, NULL);
INSERT INTO public.clothing VALUES (956, '2', 'Calvin Klein', 'Shorts', 'Black', 69, '928479', 10.11, 13.66, NULL, NULL, 'SOLD TO ALLA

waist: 32
hips: 48
length: 42
Waist: 32
Hips: 50
Length: 41
Pasadka: 29', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:09.369356', NULL, NULL);
INSERT INTO public.clothing VALUES (873, 'S', 'Calvin Klein', 'Sweat Shirt', 'Red', 59, '626446', 11.81, NULL, NULL, NULL, 'Chest: 51
Waist: 46
Length: 64
Arm: 62', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:08.564304', NULL, NULL);
INSERT INTO public.clothing VALUES (877, 'XL', 'Calvin Klein', 'Boxers', 'Black', 58, '759684', 7.22, NULL, NULL, NULL, '3 pair', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:08.601567', NULL, NULL);
INSERT INTO public.clothing VALUES (880, 'S', 'Calvin Klein', 'Boxers', 'Blue, Red, Grey', 58, '304310', 6.71, NULL, NULL, NULL, '3 pair', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:08.629684', NULL, NULL);
INSERT INTO public.clothing VALUES (886, 'S', 'Calvin Klein', 'Windbreaker', 'Black', 59, '634590', 30.60, NULL, NULL, NULL, 'Chest: 52
Waist: 48
Length: 91
Arm:  62', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:08.685498', NULL, NULL);
INSERT INTO public.clothing VALUES (887, 'XS', 'Calvin Klein', 'Windbreaker', 'Black', 59, '634606', 30.60, 87.72, NULL, NULL, 'On receipt as 634590

Chest: 51
Waist: 45
Length: 85 
Arm:  60', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:08.69605', NULL, NULL);
INSERT INTO public.clothing VALUES (889, 'S', 'Calvin Klein', 'T-Shirt', 'Black', 59, '557050', 6.71, NULL, NULL, NULL, 'Large White Square

Chest: 47
Waist: 47
Length: 68
', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:08.715', NULL, NULL);
INSERT INTO public.clothing VALUES (892, 'M', 'Armani Exchange', 'T-Shirt', 'Black', 60, '001870', 20.99, NULL, NULL, NULL, 'chest: 40
waist: 38
length: 62', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:08.74345', NULL, NULL);
INSERT INTO public.clothing VALUES (863, 'M', 'Calvin Klein', 'Tank Top', 'Black', 58, '602521', 5.10, NULL, NULL, NULL, 'Chest: 47
Waist: 47
Length: 69', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:08.472245', NULL, NULL);
INSERT INTO public.clothing VALUES (930, '32', 'Calvin Klein', 'Jeans', 'Blue', 64, '011712', 11.82, NULL, NULL, NULL, 'Waist: 44
Length: 112
Lapatka:  30', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:09.131787', NULL, NULL);
INSERT INTO public.clothing VALUES (931, '2', 'Tommy Hilfiger', 'Pants', 'Navy', 65, '159330', 31.99, NULL, NULL, NULL, 'Waist: 39
Hips: 44
Length: 94
Pasadka: 21', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:09.141458', NULL, NULL);
INSERT INTO public.clothing VALUES (3264, '8', 'Tommy Hilfiger', 'Shoes', 'Navy, Brown', 276, '237473001999', 19.99, NULL, NULL, NULL, 'heeled flip flops', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-23 00:51:18.838096', NULL, NULL);
INSERT INTO public.clothing VALUES (2292, 'L', 'Calvin Klein', 'Hoodie', 'Blue', 182, '289183', 29.99, NULL, 72, NULL, 'chest: 59
length: 71
arm: 67
shoulders: 51', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-23 21:42:00.736676', NULL, 0.00);
INSERT INTO public.clothing VALUES (241, 'XS', 'Calvin Klein', 'Jean Jacket', 'Blue', 21, '105815', 20.01, 64.29, 72, 22, 'Buttons

Chest: 53
Waist: 52
Length: 65
Arm: 57', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:55.777386', NULL, 0.00);
INSERT INTO public.clothing VALUES (3592, 'XS', 'Armani Exchange', 'Dress', 'Pink', 293, '7212658', 28.00, NULL, NULL, NULL, '
ПОГ 48
ПОБ 46
дл 91
', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-04 05:34:02.584454', NULL, NULL);
INSERT INTO public.clothing VALUES (3431, 'M', 'Armani Exchange', 'Polo Shirt', 'White', 283, '7027405', 19.99, NULL, NULL, NULL, 'слова Armani Exchange с лева в столб
маломерит
ПОГ 50
дл 69
Плечи 47
', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-30 21:15:29.094155', NULL, NULL);
INSERT INTO public.clothing VALUES (3662, 'L', 'Guess', 'Dress', 'Black', 298, '708756', 19.99, NULL, 122, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-08 05:08:02.638045', NULL, 0.00);
INSERT INTO public.clothing VALUES (3193, '6', 'Calvin Klein', 'Shoes', 'Tan', 271, '57722100299914', 29.99, NULL, 125, NULL, 'heel pumps', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-21 00:08:50.197475', NULL, 0.00);
INSERT INTO public.clothing VALUES (3505, 'S', 'Armani Exchange', 'Dress Shirt', 'Red', 287, '4364608', 19.99, NULL, 127, NULL, 'оверсайз с ремнём
ПОГ 62
дл 77
рук 46/73', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-02 22:11:54.22383', NULL, NULL);
INSERT INTO public.clothing VALUES (529, '38', 'Levis', 'Belt', 'Brown', 39, '294742', 10.39, 14.04, 32, 9, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.290209', NULL, NULL);
INSERT INTO public.clothing VALUES (932, 'M', 'Tommy Hilfiger', 'Sweat Shirt', 'Light Blue', 65, '690604', 7.99, NULL, NULL, NULL, 'Chest: 54
waist: 52
length: 60
arm: 54
', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:09.150263', NULL, NULL);
INSERT INTO public.clothing VALUES (934, 'XS', 'Tommy Hilfiger', 'Sweat Shirt', 'Navy', 65, '690512', 7.99, NULL, NULL, NULL, 'Chest: 46
waist: 45
length: 59
arm: 55
', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:09.168921', NULL, NULL);
INSERT INTO public.clothing VALUES (942, 'XS', 'Tommy Hilfiger', 'Sweat Shirt', 'Light Blue', 66, '680581', 7.49, NULL, NULL, NULL, 'Chest: 48
Waist: 48
Length: 60
Arm:  64', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:09.242381', NULL, NULL);
INSERT INTO public.clothing VALUES (944, 'M', 'Tommy Hilfiger', 'Sweat Pants', 'White, Grey', 66, '687222', 7.49, NULL, NULL, NULL, 'Grey word pattern

Waist: 42
Hips: 57
Length: 94
Pasadka: ', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:09.260472', NULL, NULL);
INSERT INTO public.clothing VALUES (1102, 'L', 'Calvin Klein', 'T-Shirt', 'Black', 88, '197945', 6.37, NULL, NULL, NULL, 'city picture on chest', true, 'men', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:10.741428', NULL, 0.00);
INSERT INTO public.clothing VALUES (949, 'M', 'Calvin Klein', 'Sport Jacket', 'Black', 68, '018239', 26.99, NULL, NULL, NULL, 'Burlington #: 8158

Chest: 55
Waist: 50
Length: 64
Arm: 56', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:09.305503', NULL, NULL);
INSERT INTO public.clothing VALUES (3265, '10', 'Karl Lagerfeld', 'Jeans', 'Blue', 276, '510887002499', 24.99, NULL, 112, NULL, 'с полоской с боку
', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-23 00:51:31.166259', NULL, 0.00);
INSERT INTO public.clothing VALUES (3347, '8', 'Karl Lagerfeld', 'Jeans', 'Navy', 282, '510887002499', 24.99, NULL, 122, NULL, 'светло синие', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-27 04:24:04.67473', NULL, 0.00);
INSERT INTO public.clothing VALUES (3663, 'XL', 'Tommy Hilfiger', 'Dress', 'Blue', 298, '408856', 19.99, NULL, 122, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-08 05:10:56.22314', NULL, NULL);
INSERT INTO public.clothing VALUES (3432, 'XXL', 'Armani Exchange', 'Polo Shirt', 'White', 283, '2332532', 19.99, NULL, 122, NULL, 'вырез мысом

', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-30 21:17:38.76503', NULL, NULL);
INSERT INTO public.clothing VALUES (3194, '8.5', 'Calvin Klein', 'Shoes', 'Tan', 271, '57723800299914', 29.99, NULL, 125, NULL, 'heel pumps', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-21 00:09:18.554774', NULL, 0.00);
INSERT INTO public.clothing VALUES (302, '3XXS', 'Tommy Hilfiger', 'Hoodie', 'Red', 20, '706435', 7.64, NULL, 7, NULL, 'Kids clothes
2-3 years

chest: 33
length: 41
arm: 32', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.304708', NULL, NULL);
INSERT INTO public.clothing VALUES (3506, '6', 'Armani Exchange', 'Blazer', 'Black', 287, '4365742', 39.99, 100.00, NULL, 23, 'с полоской с боку
ПОГ 50
дл 72
плечи 40
рукав 62', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-02 22:29:08.826258', NULL, NULL);
INSERT INTO public.clothing VALUES (3346, '2', 'Karl Lagerfeld', 'Jeans', 'Navy', 282, '510887002499', 24.99, 82.14, NULL, 23, 'светло синие', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-27 04:23:02.259873', NULL, 0.00);
INSERT INTO public.clothing VALUES (3589, 'M', 'Armani Exchange', 'Golfik', 'Black', 293, '0324127', 29.99, 40.95, 125, 9, 'с розово золотыми буквами Армани
ПОГ 47
дл 59
рук 62', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-04 05:29:20.261519', NULL, NULL);
INSERT INTO public.clothing VALUES (303, '6-7S', 'Tommy Hilfiger', 'Sweat Pants', 'Teal', 25, '471848', 14.09, NULL, 7, NULL, 'Kids clothes
6-7 years

Hips: 37
length: 66', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.312876', NULL, NULL);
INSERT INTO public.clothing VALUES (304, '12-14L', 'Tommy Hilfiger', 'Hoodie', 'Grey', 25, '471503', 17.99, NULL, 7, NULL, 'Kids clothes
12-14 years

chest: 44
length: 56
arm: 53', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.321831', NULL, NULL);
INSERT INTO public.clothing VALUES (305, '6-7S', 'Tommy Hilfiger', 'Hoodie', 'Teal', 25, '478144', 14.99, NULL, 7, NULL, 'Kids clothes
6-7 years

chest: 40
length: 49
arm: 44', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.330728', NULL, NULL);
INSERT INTO public.clothing VALUES (310, 'S', 'Hunter', 'Puffy Jacket', 'Teal', NULL, '526975', 59.99, NULL, 7, NULL, 'already sold', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.373337', NULL, NULL);
INSERT INTO public.clothing VALUES (389, 'M', 'Tommy Hilfiger', 'Sweat Pants', 'Blue', 31, '453882', 23.99, NULL, 108, NULL, 'Men

Waist: 40
Hips: 53
Length: 100
Pasadka: 30', true, 'men', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.071611', NULL, 5.20);
INSERT INTO public.clothing VALUES (244, 'L', 'Calvin Klein', 'Hoodie', 'Navy', NULL, '800385', 19.26, 53.57, 71, 22, 'Men
Black + grey stripe down arm

Chest: 57
Waist: 55
Length: 68
Arm: 67', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:55.800936', NULL, 0.00);
INSERT INTO public.clothing VALUES (3266, '8', 'Polo', 'Dress Shirt', 'Navy, Brown', 276, '164502', 29.99, NULL, 112, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-23 00:52:30.041408', NULL, NULL);
INSERT INTO public.clothing VALUES (3591, 'XS', 'Armani Exchange', 'Dress', 'Pink', 293, '7212603', 28.00, NULL, NULL, NULL, '
ПОГ 48
ПОБ 46
дл 91
', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-04 05:32:35.62944', NULL, NULL);
INSERT INTO public.clothing VALUES (3664, 'L', 'Tommy Hilfiger', 'Dress', 'Blue', 298, '408863', 19.99, NULL, 122, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-08 05:11:13.839146', NULL, NULL);
INSERT INTO public.clothing VALUES (349, 'XS', 'Calvin Klein', 'Sweat Pants', 'Black', 29, '718710', 20.19, NULL, 72, NULL, 'Men
black stripe on side
white letters

waist: 36
hips: 47
length: 102
pasadka: 26', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.71674', NULL, 0.00);
INSERT INTO public.clothing VALUES (415, 'L', 'Tommy Hilfiger', 'Puffy Jacket', 'Navy', NULL, '??????', 79.99, 111.89, 11, 15, 'sold for 3200
Women
long', false, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.294814', NULL, NULL);
INSERT INTO public.clothing VALUES (269, 'M', 'Tommy Hilfiger', 'Sweat Shirt', 'Navy', 23, '355459', 30.08, NULL, 8, NULL, 'Men
Tommy Hilfiger on chest

Chest: 55
Waist: 54
Length: 69
Arm: 68', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.000622', NULL, NULL);
INSERT INTO public.clothing VALUES (376, 'M', 'Calvin Klein', 'Sweat Pants', 'Black', 29, '263169', 20.19, NULL, 19, NULL, 'Men
grey logo sign

Waist: 43
Hips: 53
Length: 107
Pasadka: 30', true, 'men', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.949283', NULL, NULL);
INSERT INTO public.clothing VALUES (395, 'M', 'Tommy Hilfiger', 'Sweater', 'Pink', NULL, '953952', 24.99, NULL, 34, NULL, 'stripe on chest

chest: 59
length: 55/64
arm: 49/73', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.124198', NULL, NULL);
INSERT INTO public.clothing VALUES (396, 'S', 'Calvin Klein', 'Sweater', 'White', NULL, '749102', 34.99, NULL, 17, NULL, 'chest: 53
length: 59
arm: 51/72', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.132336', NULL, NULL);
INSERT INTO public.clothing VALUES (411, 'M', 'Levis', 'Puffy Jacket', 'Unknown', NULL, '??????', 59.99, NULL, 10, NULL, 'Men', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.261443', NULL, NULL);
INSERT INTO public.clothing VALUES (416, 'L', 'Juicy Coture', 'Puffy Jacket', 'Silver', NULL, '??????', 49.99, NULL, 11, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.302531', NULL, 0.00);
INSERT INTO public.clothing VALUES (407, '???', 'Levis', 'Puffy Jacket', 'Brown', NULL, '??????', 44.99, NULL, 10, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.21662', NULL, NULL);
INSERT INTO public.clothing VALUES (413, 'S', 'Calvin Klein', 'Puffy Jacket', 'Silver', NULL, '8092', 0.00, NULL, 11, NULL, 'Space suit', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.278218', NULL, NULL);
INSERT INTO public.clothing VALUES (398, 'M', 'Calvin Klein', 'Sweat Pants', 'Black', NULL, '956951', 19.99, NULL, 72, NULL, 'silver letters along leg

waist: 40
hips: 49
length: 94
pasadka: 25', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.147817', NULL, 0.00);
INSERT INTO public.clothing VALUES (384, '1SZ', 'Calvin Klein', 'Hat', 'Black', NULL, '618676', 14.67, NULL, 73, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.027812', NULL, 0.00);
INSERT INTO public.clothing VALUES (409, 'XS', 'Calvin Klein', 'Puffy Jacket', 'Purple', NULL, '??????', 45.00, 108.40, 10, 13, 'sold for 3100', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.233641', NULL, NULL);
INSERT INTO public.clothing VALUES (410, 'S', 'Michael Kors', 'Puffy Jacket', 'Black', NULL, '??????', 89.99, 146.85, 10, 13, 'sold for 4200', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.247851', NULL, NULL);
INSERT INTO public.clothing VALUES (408, 'XS', 'Hunter', 'Puffy Jacket', 'Teal', NULL, '??????', 59.99, 125.87, 10, 13, 'sold for 3600

chest: 54
length: 63
arm: 63', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.225531', NULL, NULL);
INSERT INTO public.clothing VALUES (412, 'S', 'Bebe', 'Puffy Jacket', 'Black', NULL, '??????', 15.00, 80.42, 11, 14, 'sold for 2300', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.269655', NULL, NULL);
INSERT INTO public.clothing VALUES (454, 'S', 'Calvin Klein', 'Satin Pants', 'Black', 34, '549479', 10.57, NULL, 30, NULL, 'waist: 38
hips: 52
Length: 97', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.640049', NULL, NULL);
INSERT INTO public.clothing VALUES (470, 'M', 'Calvin Klein', 'Hoodie', 'Black', 34, '252682', 16.62, NULL, 19, NULL, 'grey logo sign on chest

chest: 53
length: 70
sleeve: 66', true, 'men', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.773275', NULL, 0.00);
INSERT INTO public.clothing VALUES (485, 'XS', 'Calvin Klein', 'Vest Jacket', 'Black, Grey', 37, '752157', 10.49, NULL, 34, NULL, 'women vest
shiny

chest: 47
length: 62', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.899942', NULL, NULL);
INSERT INTO public.clothing VALUES (3267, 'S', 'Calvin Klein', 'Pants', 'Tan', 276, '436588002299', 22.99, NULL, 109, NULL, 'Cropped', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-23 00:55:49.58608', NULL, NULL);
INSERT INTO public.clothing VALUES (3196, '7.5', 'Tommy Hilfiger', 'Shoes', 'White', 271, '65399100199916', 19.99, NULL, 118, NULL, 'loafers', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-21 00:10:30.936964', NULL, 0.00);
INSERT INTO public.clothing VALUES (3508, '4', 'Armani Exchange', 'Blazer', 'Black', 287, '4365735', 39.99, NULL, NULL, NULL, 'с полоской с боку
ПОГ 49
дл 72
плечи 40
рукав 62', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-02 22:30:47.988153', NULL, NULL);
INSERT INTO public.clothing VALUES (3434, 'XL', 'Armani Exchange', 'Polo Shirt', 'Blue', 283, '7431318', 19.99, NULL, 123, NULL, 'надпись слева на груди
Armani Exchange milano NY

ПОГ 59
дл 74
плечи 52', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-30 21:20:58.273661', NULL, NULL);
INSERT INTO public.clothing VALUES (3665, 'L', 'Calvin Klein', 'Windbreaker', 'White', 298, '415175', 49.99, NULL, 125, NULL, 'Чёрно белая курточка
ПОГ 61
дл 70
рук 66
плечи 52', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-04-08 05:13:34.192783', NULL, NULL);
INSERT INTO public.clothing VALUES (950, 'M', 'Tommy Hilfiger', 'T-Shirt', 'White', 68, '582658', 14.99, NULL, NULL, NULL, 'Burlington #: 8134
Large Blue square on chest

Chest: 51
Waist: 52
Length: 71', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:09.315003', NULL, NULL);
INSERT INTO public.clothing VALUES (951, 'L', 'Calvin Klein', 'Sport Jacket', 'Black', 68, '018222', 26.99, NULL, NULL, NULL, 'Burlington #: 8161

Chest: 55
Waist: 53
Length: 65
Arm:  58', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:09.323782', NULL, NULL);
INSERT INTO public.clothing VALUES (952, 'S', 'Calvin Klein', 'Sport Jacket', 'Black', 68, '018246', 26.99, NULL, NULL, NULL, 'Burlington #: 8145 

Chest: 53
Waist: 49
Length: 63
Arm:  57', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:09.333249', NULL, NULL);
INSERT INTO public.clothing VALUES (957, '36', 'Calvin Klein', 'Shorts', 'Grey', 69, '995709', 10.11, NULL, NULL, NULL, 'Waist: 48
Hips: 54
Length: 50
Pasadka: 29
', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:09.378895', NULL, NULL);
INSERT INTO public.clothing VALUES (960, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 61, '687239', 13.49, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:09.408907', NULL, NULL);
INSERT INTO public.clothing VALUES (963, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 61, '684269', 20.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:09.435569', NULL, NULL);
INSERT INTO public.clothing VALUES (966, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 61, '557099', 9.74, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:09.464809', NULL, NULL);
INSERT INTO public.clothing VALUES (967, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 62, '686911', 7.52, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:09.473438', NULL, NULL);
INSERT INTO public.clothing VALUES (939, '0', 'Tommy Hilfiger', 'Blazer', 'Navy', 66, '319657', 7.49, NULL, NULL, NULL, 'Chest: 43
Waist: 37
Length: 63
Arm: 61', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:09.21527', NULL, 0.00);
INSERT INTO public.clothing VALUES (3268, 'M', 'Calvin Klein', 'Pants', 'Tan', 276, '436588002299', 22.99, NULL, 112, NULL, 'Cropped', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-23 00:56:06.26218', NULL, NULL);
INSERT INTO public.clothing VALUES (3197, 'M', 'Michael Kors', 'Coat', 'Tan', 271, '029779', 29.99, NULL, 115, NULL, 'chest: 51
hips: 52
arm: 60
shoulders: 39
length: 75', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-21 00:11:33.579088', NULL, NULL);
INSERT INTO public.clothing VALUES (3350, 'M', 'Armani Exchange', 'T-Shirt', 'Blue', 283, '0302170', 19.99, NULL, 118, NULL, 'бело синяя футболка свитшот в комплекте с шортами
ПОГ 60
дл 68', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-27 04:57:34.957278', NULL, 0.00);
INSERT INTO public.clothing VALUES (3435, 'L', 'Armani Exchange', 'Polo Shirt', 'Blue', 283, '7431288', 19.99, NULL, 113, NULL, 'надпись слева на груди
Armani Exchange milano NY

ПОГ 56
дл 72
плечи 50', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-30 21:22:05.912509', NULL, NULL);
INSERT INTO public.clothing VALUES (3349, 'S', 'Calvin Klein', 'Dress', 'Pink', 282, '402571', 19.99, 27.30, 118, 9, 'black stripe on shoulder
chest: 45
hips: 49
length: 90', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-27 04:24:56.076241', NULL, 0.00);
INSERT INTO public.clothing VALUES (3598, 'XS', 'Armani Exchange', 'Pants', 'White', 293, '0288672', 19.99, 27.30, 125, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-04 05:46:33.886456', NULL, NULL);
INSERT INTO public.clothing VALUES (3593, 'S', 'Armani Exchange', 'Dress', 'Pink', 293, '7212634', 28.00, NULL, NULL, NULL, 'ПОГ 51
ПОБ 49
дл 91
', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-04 05:35:10.857461', NULL, 0.00);
INSERT INTO public.clothing VALUES (3666, 'M', 'Calvin Klein', 'Windbreaker', 'White', 298, '415182', 49.99, NULL, NULL, NULL, 'Чёрно белая курточка
ПОГ 58
дл 71
рук 66
плечи 51', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-04-08 05:15:46.573521', NULL, NULL);
INSERT INTO public.clothing VALUES (558, '???', 'Michael Kors', 'Sweater', 'Red', NULL, '??????', 34.99, NULL, 16, NULL, 'black gummy stripe on arm', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.533545', NULL, NULL);
INSERT INTO public.clothing VALUES (497, 'N/A', 'Calvin Klein', 'Hat', 'Black', 36, '562788', 8.92, 26.22, 19, 3, 'sold for 750 
mom has 550', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.000217', NULL, NULL);
INSERT INTO public.clothing VALUES (3269, 'S', 'Calvin Klein', 'Hoodie', 'Tan', 276, '436502002299', 22.99, NULL, 109, NULL, 'sleeveless', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-23 00:56:32.315255', NULL, NULL);
INSERT INTO public.clothing VALUES (3667, 'M', 'Calvin Klein', 'Windbreaker', 'Black', 298, '427543', 49.99, NULL, 122, NULL, 'stripe "calvin" on sleeve

chest: 58
length: 70
arm: 67
shoulders: 50', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-04-08 05:16:33.213392', NULL, 0.00);
INSERT INTO public.clothing VALUES (3436, 'L', 'Armani Exchange', 'Polo Shirt', 'Blue', 283, '7431288', 19.99, NULL, 123, NULL, 'надпись слева на груди
Armani Exchange milano NY

ПОГ 56
дл 72
плечи 50', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-30 21:22:20.481019', NULL, NULL);
INSERT INTO public.clothing VALUES (3594, 'S', 'Armani Exchange', 'Dress', 'Pink', 293, '7212580', 28.00, NULL, 124, NULL, 'ПОГ 51
ПОБ 49
дл 91
', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-04 05:35:19.797615', NULL, 0.00);
INSERT INTO public.clothing VALUES (3351, 'M', 'Armani Exchange', 'T-Shirt', 'Blue', 283, '0302170', 19.99, NULL, 127, NULL, 'бело синяя футболка свитшот в комплекте с шортами
ПОГ 60
дл 68', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-27 04:57:38.978532', NULL, 0.00);
INSERT INTO public.clothing VALUES (643, 'L', 'Calvin Klein', 'Sweat Shirt', 'Black', NULL, '074517', 29.99, NULL, 30, NULL, 'white calvin stripe on sleeve', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.275539', NULL, NULL);
INSERT INTO public.clothing VALUES (664, 'N/A', 'Armani Exchange', 'Purse', 'Black', 32, '767493', 39.99, NULL, 34, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.463728', NULL, NULL);
INSERT INTO public.clothing VALUES (675, 'XS', 'Tommy Hilfiger', 'Puffy Jacket', 'Navy', 44, '912522', 34.99, NULL, 33, NULL, 'Shiny
with hood
reversible to fluffy and white

Chest: 54
Length: 57
Arm: 56', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.561733', NULL, NULL);
INSERT INTO public.clothing VALUES (677, 'S', 'Tommy Hilfiger', 'Puffy Jacket', 'Navy', 45, '912515', 35.02, NULL, 33, NULL, 'Shiny
with hood
reversible to fluffy and white

Chest: 55
Length: 62
Arm: 58', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.579619', NULL, NULL);
INSERT INTO public.clothing VALUES (678, 'S', 'Tommy Hilfiger', 'Puffy Jacket', 'Navy', 45, '912515', 34.99, NULL, 33, NULL, 'Shiny
with hood
reversible to fluffy and white

Chest: 55
Length: 62
Arm: 58', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.588445', NULL, NULL);
INSERT INTO public.clothing VALUES (2000, 'S', 'Calvin Klein', 'Belt', 'Black', 154, '261633', 3.51, NULL, 58, NULL, 'length: 95
', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 11:52:17.139192', NULL, 0.00);
INSERT INTO public.clothing VALUES (636, 'S', 'Calvin Klein', 'Sweat Shirt', 'Red', NULL, '784912', 28.83, NULL, 28, NULL, 'Black shoulder stripe

Chest: 65
Waist: 54
Length: 59
Arm: 42', false, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.216651', NULL, NULL);
INSERT INTO public.clothing VALUES (625, 'N/A', 'Tommy Hilfiger', 'Wallet', 'Black', NULL, '239286', 14.99, 34.96, 26, 14, 'sold for 1000
logo dot', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.124246', NULL, NULL);
INSERT INTO public.clothing VALUES (680, 'XS', 'Tommy Hilfiger', 'Puffy Jacket', 'Navy', 46, '912522', 34.99, NULL, 33, NULL, 'Shiny
with hood
reversible to fluffy and white

Chest: 54
Length: 57
Arm: 56', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.607183', NULL, NULL);
INSERT INTO public.clothing VALUES (681, 'M', 'Tommy Hilfiger', 'Puffy Jacket', 'Navy', 42, '912508', 34.99, NULL, 33, NULL, 'Shiny
with hood
reversible to fluffy and white

Chest: 57
Length: 62
Arm: 58', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.621373', NULL, NULL);
INSERT INTO public.clothing VALUES (684, 'M', 'Tommy Hilfiger', 'Coat', 'Plaid', 42, '916797', 55.99, NULL, 33, NULL, 'chest: 50
Waist: 47
length: 98
arm: 66', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.651885', NULL, NULL);
INSERT INTO public.clothing VALUES (685, 'S', 'Tommy Hilfiger', 'Coat', 'Plaid', 42, '916803', 55.99, NULL, 33, NULL, 'chest: 48
Waist: 45
length: 96
arm: 65', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.65988', NULL, NULL);
INSERT INTO public.clothing VALUES (686, '1SZ', 'Tommy Hilfiger', 'Hat', 'White', 44, '561914', 13.99, NULL, 34, NULL, 'Navy hilfiger square on forehead

beanie cap', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.67079', NULL, NULL);
INSERT INTO public.clothing VALUES (688, 'XXS', 'Tommy Hilfiger', 'Sweat Pants', 'Navy', 45, '791479', 13.99, NULL, 72, NULL, 'red/white waist-band
red/white Hilfiger on ankle

Waist: 37
hips: 43
length: 95
pasadka: 23', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.688677', NULL, 0.00);
INSERT INTO public.clothing VALUES (704, 'M', 'Tommy Hilfiger', 'Sweater', 'White', 42, '653787', 17.49, NULL, 33, NULL, 'knitted
V-neck

Chest: 47
length: 62
arm: 60', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.825822', NULL, NULL);
INSERT INTO public.clothing VALUES (713, 'S', 'DKNY', 'Sweater', 'White', NULL, '183030', 19.99, NULL, 33, NULL, 'DKNY square pattern everywhere
oversized

chest: 53
length: 57
arm: 47/68', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.897738', NULL, NULL);
INSERT INTO public.clothing VALUES (128, 'M', 'Levis', 'Puffy Jacket', 'Blue, White, Black', 10, '030267', 59.99, NULL, 4, NULL, 'Men
Black hood
White chest
Blue bottom

Chest: 59
Length:  69
Arm: 70
Shoulders: 49', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.764189', NULL, 8.10);
INSERT INTO public.clothing VALUES (720, 'S', 'DKNY', 'Golfik', 'Black', NULL, '990398', 19.99, NULL, 34, NULL, 'white line down arms with "DKNY" in black

chest: 45
length: 67
arm: 70', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.955404', NULL, NULL);
INSERT INTO public.clothing VALUES (722, 'S', 'DKNY', 'Golfik', 'White', NULL, '936853', 19.99, NULL, 34, NULL, 'black line down arms

chest: 46
length: 63
arm: 69', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.971016', NULL, NULL);
INSERT INTO public.clothing VALUES (693, 'XS', 'Tommy Hilfiger', 'Puffy Jacket', 'Navy', 46, '912522', 34.99, NULL, 60, NULL, 'Shiny
with hood
reversible to fluffy and white

Chest: 54
Length: 57
Arm: 56', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.731746', NULL, 0.00);
INSERT INTO public.clothing VALUES (724, 'S', 'Tommy Hilfiger', 'Puffy Jacket', 'Silver', NULL, '129157', 59.99, NULL, 34, NULL, 'red inside hood
white line down arms with "TOMMY"

chest: 51
length: 56
arm: 63', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.986854', NULL, NULL);
INSERT INTO public.clothing VALUES (1904, '10', 'Karl Lagerfeld', 'Pants', 'Black', NULL, 'RK0287', 15.00, 39.29, NULL, 22, 'Metal face

waist: 43
hips: 51
pasadka: 26
length: 95', true, NULL, NULL, NULL, NULL, 'ukraine', '2021-01-02 07:27:42.601303', NULL, NULL);
INSERT INTO public.clothing VALUES (3199, 'M', 'DKNY', 'T-Shirt', 'White', 271, 'GT022', 12.99, NULL, 109, NULL, 'faded DKNY
chest: 52
length: 71', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-21 00:12:49.843012', NULL, NULL);
INSERT INTO public.clothing VALUES (3270, 'L', 'DKNY', 'Windbreaker', 'Grey', 277, '666380', 39.99, NULL, 115, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-23 01:01:54.591903', NULL, NULL);
INSERT INTO public.clothing VALUES (3352, 'M', 'Armani Exchange', 'T-Shirt', 'Blue', 283, '0302170', 19.99, NULL, NULL, NULL, 'бело синяя футболка свитшот в комплекте с шортами
ПОГ 60
дл 68', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-27 04:57:40.007749', NULL, 0.00);
INSERT INTO public.clothing VALUES (3668, 'M', 'Calvin Klein', 'Windbreaker', 'Black', 298, '427543', 49.99, NULL, 122, NULL, 'stripe "calvin" on sleeve

chest: 58
length: 70
arm: 67
shoulders: 50', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-04-08 05:16:36.628674', NULL, 0.00);
INSERT INTO public.clothing VALUES (3437, 'M', 'Armani Exchange', 'Polo Shirt', 'Blue', 283, '7431295', 19.99, NULL, 122, NULL, 'надпись слева на груди
Armani Exchange milano NY

ПОГ 52
дл 72
плечи 48', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-30 21:23:58.475749', NULL, NULL);
INSERT INTO public.clothing VALUES (3595, 'M', 'Armani Exchange', 'Dress', 'Pink', 294, '7212573', 28.00, NULL, 124, NULL, 'ПОГ 55
ПОБ 52
дл 95
', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-04 05:37:54.329286', NULL, 0.00);
INSERT INTO public.clothing VALUES (2094, 'XS', 'Karl Lagerfeld', 'Sweater', 'Black', 161, '811661', 49.99, NULL, NULL, NULL, 'chest: 47
length: 60
arm: 47

three-quarters sleeve', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-01-13 12:08:01.579516', NULL, NULL);
INSERT INTO public.clothing VALUES (1893, '27X32', 'Levis', 'Jeans', 'Blue', NULL, '646253', 35.00, NULL, NULL, NULL, 'black thingies/patches
with rivets

waist: 36
hips: 45
pasadka: 28
length: 106', true, NULL, NULL, NULL, NULL, 'ukraine', '2021-01-02 07:07:33.333297', NULL, NULL);
INSERT INTO public.clothing VALUES (1894, '30X32', 'Levis', 'Jeans', 'Blue', NULL, '646314', 35.00, NULL, NULL, NULL, 'black thingies/patches
with rivets

waist: 39
hips: 50
pasadka: 29
length: 107', true, NULL, NULL, NULL, NULL, 'ukraine', '2021-01-02 07:09:16.623599', NULL, NULL);
INSERT INTO public.clothing VALUES (1895, '25', 'Levis', 'Jeans', 'Blue', NULL, 'L001', 20.00, NULL, NULL, NULL, '721 high rise skinny
payetki on the side

waist: 31
hips: 39
pasadka: 24
length: 89', true, NULL, NULL, NULL, NULL, 'ukraine', '2021-01-02 07:11:47.812875', NULL, NULL);
INSERT INTO public.clothing VALUES (3280, '9.5', 'Tommy Hilfiger', 'Shoes', 'White', 277, '09229100329919', 32.99, NULL, 118, NULL, NULL, NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-23 01:12:04.031218', NULL, NULL);
INSERT INTO public.clothing VALUES (3511, '0', 'Armani Exchange', 'Blazer', 'Black', 287, '4365681', 39.99, 100.00, NULL, 23, 'с полоской с боку
ПОГ 46
дл 69
плечи 38
рукав 60', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-02 22:37:41.238113', NULL, NULL);
INSERT INTO public.clothing VALUES (3198, 'M', 'Michael Kors', 'Coat', 'Tan', 271, '029779', 29.99, 87.50, NULL, 23, 'chest: 51
hips: 52
arm: 60
shoulders: 39
length: 75', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-21 00:11:37.528467', NULL, NULL);
INSERT INTO public.clothing VALUES (1896, '4X30', 'Ralph Lauren', 'Jeans', 'Blue', NULL, '701895', 15.00, NULL, NULL, NULL, 'waist: 38
hips: 44
pasadka: 25
length: 99', true, NULL, NULL, NULL, NULL, 'ukraine', '2021-01-02 07:13:22.464314', NULL, NULL);
INSERT INTO public.clothing VALUES (1897, '14X32', 'Levis', 'Jeans', 'Blue', NULL, '252969', 7.00, NULL, NULL, NULL, 'waist: 41
hips: 50
pasadka: 30
length: 110', true, NULL, NULL, NULL, NULL, 'ukraine', '2021-01-02 07:15:01.10576', NULL, NULL);
INSERT INTO public.clothing VALUES (1898, '6X32', 'Ralph Lauren', 'Jeans', 'White', NULL, '815634', 15.00, NULL, NULL, NULL, 'waist: 37
hips: 45
pasadka: 24
length: 105', true, NULL, NULL, NULL, NULL, 'ukraine', '2021-01-02 07:16:12.486471', NULL, NULL);
INSERT INTO public.clothing VALUES (1899, '28', 'Calvin Klein', 'Jeans', 'White', NULL, '366637', 15.00, NULL, NULL, NULL, 'stripe on side

waist: 37
hips: 44
pasadka: 26
length: 98', true, NULL, NULL, NULL, NULL, 'ukraine', '2021-01-02 07:18:33.036324', NULL, NULL);
INSERT INTO public.clothing VALUES (1901, '2', 'Tommy Hilfiger', 'Dress Pants', 'White', NULL, '687956', 15.00, NULL, NULL, NULL, 'wide

waist: 38
hips: 53
pasadka: 24
length: 88', true, NULL, NULL, NULL, NULL, 'ukraine', '2021-01-02 07:22:43.733328', NULL, NULL);
INSERT INTO public.clothing VALUES (1902, 'S', 'Calvin Klein', 'Zebra Pants', 'White, Black', NULL, '346498', 15.00, NULL, NULL, NULL, 'zebra pattern

waist: 40
hips: 52
pasadka: 25
length: 87/101', true, NULL, NULL, NULL, NULL, 'ukraine', '2021-01-02 07:24:40.663872', NULL, NULL);
INSERT INTO public.clothing VALUES (1905, '4', 'Calvin Klein', 'Jumpsuit', 'Black', NULL, '722524', 27.00, NULL, NULL, NULL, 'Chest: 46
hips: 50
length: 153', true, NULL, NULL, NULL, NULL, 'ukraine', '2021-01-02 07:31:26.865747', NULL, NULL);
INSERT INTO public.clothing VALUES (1906, '6X28', 'Calvin Klein', 'Jeans', 'Navy', NULL, 'CK001', 24.99, NULL, NULL, NULL, 'Skinny

waist: 35
hips: 43
pasadka: 27
length: 100', true, NULL, NULL, NULL, NULL, 'ukraine', '2021-01-02 07:33:00.307254', NULL, NULL);
INSERT INTO public.clothing VALUES (1907, '2OR26', 'Calvin Klein', 'Jeans', 'Navy', NULL, 'CK002', 24.99, NULL, NULL, NULL, 'straight leg

waist: 34
hips: 42
pasadka: 25
length: 96', true, NULL, NULL, NULL, NULL, 'ukraine', '2021-01-02 07:34:16.909356', NULL, NULL);
INSERT INTO public.clothing VALUES (1908, 'M', 'Calvin Klein', 'Jean Jacket', 'White', NULL, 'CK003', 25.00, NULL, NULL, NULL, 'chest: 47
length: 50
arm: 61', true, NULL, NULL, NULL, NULL, 'ukraine', '2021-01-02 07:36:37.672951', NULL, NULL);
INSERT INTO public.clothing VALUES (1909, 'S', 'Calvin Klein', 'Sport Shorts', 'Blue', NULL, '350254', 15.00, NULL, NULL, NULL, 'waist: 37
hips: 48
pasadka: 25
length: 48', true, NULL, NULL, NULL, NULL, 'ukraine', '2021-01-02 07:44:24.072721', NULL, NULL);
INSERT INTO public.clothing VALUES (1910, 'S', 'Calvin Klein', 'Hoodie', 'Blue', NULL, '351527', 11.00, NULL, NULL, NULL, 'sleeveless

chest: 55
length: 52', true, NULL, NULL, NULL, NULL, 'ukraine', '2021-01-02 07:45:35.845113', NULL, NULL);
INSERT INTO public.clothing VALUES (1911, 'M', 'Tommy Hilfiger', 'Skirt', 'White', NULL, '366941', 9.00, NULL, NULL, NULL, 'waist: 39
hips: 53
length: 48', true, NULL, NULL, NULL, NULL, 'ukraine', '2021-01-02 07:50:47.356196', NULL, NULL);
INSERT INTO public.clothing VALUES (1912, '27', 'Calvin Klein', 'Shorts', 'White', NULL, 'CK004', 5.99, NULL, NULL, NULL, 'Waist: 37
hips: 46
pasadka: 26
length: 44', true, NULL, NULL, NULL, NULL, 'ukraine', '2021-01-02 07:55:20.722938', NULL, NULL);
INSERT INTO public.clothing VALUES (2037, 'XXL', 'Armani Exchange', 'Dress Shirt', 'White', 156, '416673', 9.99, 13.61, 64, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 13:24:40.840432', NULL, 0.00);
INSERT INTO public.clothing VALUES (2063, 'S', 'Tommy Hilfiger', 'T-Shirt', 'White', 158, '437702', 8.00, 10.78, 64, 9, 'chest: 44
length: 62', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-13 11:19:02.705549', NULL, 0.00);
INSERT INTO public.clothing VALUES (2255, 'M', 'DKNY', 'Puffy Jacket', 'Green', 180, '273809', 59.99, 81.93, 65, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-22 11:40:23.163573', NULL, 0.00);
INSERT INTO public.clothing VALUES (1900, '2', 'Calvin Klein', 'Dress Pants', 'Navy', NULL, '134372', 27.00, 42.86, NULL, 21, 'Women

waist: 38
hips: 45
pasadka: 22
length: 96', true, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-02 07:21:12.696033', NULL, NULL);
INSERT INTO public.clothing VALUES (885, 'L', 'Calvin Klein', 'Sport Bra', 'Black', 59, '898578', 5.44, 7.43, 52, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:08.676478', NULL, 0.00);
INSERT INTO public.clothing VALUES (2051, 'N/A', 'Michael Kors', 'Fanny Pack', 'White', NULL, '024720', 0.00, 0.00, 80, 9, 'Cream colored', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 13:48:21.214345', NULL, 0.00);
INSERT INTO public.clothing VALUES (2206, 'XS', 'DKNY', 'T-Shirt', 'White', 173, '518535', 12.49, 0.00, 68, 9, 'empire state building
', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-21 17:38:09.283955', NULL, 0.00);
INSERT INTO public.clothing VALUES (2207, 'XS', 'DKNY', 'T-Shirt', 'White', 173, '755879', 9.99, 0.00, 68, 9, 'metallic DKNY
', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-21 17:39:21.329941', NULL, 0.00);
INSERT INTO public.clothing VALUES (2262, 'L', 'Tommy Hilfiger', 'Sweater', 'White', 179, '394475', 15.99, 0.00, 67, 9, NULL, NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-01-23 19:27:45.15965', NULL, 0.00);
INSERT INTO public.clothing VALUES (2261, 'M', 'Tommy Hilfiger', 'Sweater', 'Blue', 179, '394604', 15.99, 0.00, 67, 9, NULL, NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-01-23 19:27:17.136896', NULL, 0.00);
INSERT INTO public.clothing VALUES (2232, 'S', 'Michael Kors', 'Tank Top', 'Navy', NULL, '689265', 12.00, 0.00, 67, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-21 18:01:41.671727', NULL, 0.00);
INSERT INTO public.clothing VALUES (2316, 'N/A', 'DKNY', 'Fanny Pack', 'Pink', NULL, '627670', 30.99, 80.36, 73, 22, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-29 11:27:25.425398', NULL, 0.00);
INSERT INTO public.clothing VALUES (1913, '6X28', 'Calvin Klein', 'Shorts', 'Navy', NULL, 'CK005', 14.99, NULL, NULL, NULL, 'waist: 37
hips: 48
pasadka: 24
length: 32', true, NULL, NULL, NULL, NULL, 'ukraine', '2021-01-02 07:56:28.12175', NULL, NULL);
INSERT INTO public.clothing VALUES (1914, '28', 'Levis', 'Shorts', 'Blue', NULL, '731613', 25.00, NULL, NULL, NULL, 'ripped bottom

waist: 39
hips: 51
pasadka: 27
length: 32', true, NULL, NULL, NULL, NULL, 'ukraine', '2021-01-02 07:58:30.111703', NULL, NULL);
INSERT INTO public.clothing VALUES (1915, 'L', 'Calvin Klein', 'Skirt', 'Black', NULL, '??????', 15.00, NULL, NULL, NULL, 'waist: 41
hips: 57
length: 80', true, NULL, NULL, NULL, NULL, 'ukraine', '2021-01-02 08:02:24.77511', NULL, NULL);
INSERT INTO public.clothing VALUES (1314, 'L', 'Calvin Klein', 'T-Shirt', 'Pink, Gold', 56, '464706', 0.00, NULL, NULL, NULL, 'Gold Rectangle on chest

Chest: 52
Waist: 52
Length: 65', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:12.728496', NULL, NULL);
INSERT INTO public.clothing VALUES (1731, 'S', 'Levis', 'Jean Jacket', 'Blue', NULL, '931150', 25.00, NULL, NULL, NULL, 'Women
trucker

chest: 49
length: 58
arm: 57', true, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 07:31:01.823942', NULL, NULL);
INSERT INTO public.clothing VALUES (1890, '27X30', 'Calvin Klein', 'Jeans', 'Blue', NULL, '661665', 27.00, NULL, NULL, NULL, 'women
model CKG30
blue/black stripe on side

waist: 36
hips: 48
length: 112
pasadka: 29', true, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-02 06:59:37.677879', NULL, NULL);
INSERT INTO public.clothing VALUES (1889, '28X30', 'Calvin Klein', 'Jeans', 'Blue', NULL, '661702', 30.00, NULL, NULL, NULL, 'women
blue/black stripe on side

waist: 36
hips: 49
length: 115
pasadka: 30', true, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-02 06:56:19.770568', NULL, NULL);
INSERT INTO public.clothing VALUES (1891, '27X32', 'Levis', 'Jeans', 'Blue', NULL, '116243', 20.00, NULL, NULL, NULL, 'women
711

waist: 34
hips: 43
length: 103
pasadka: 22', true, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-02 07:02:10.504638', NULL, NULL);
INSERT INTO public.clothing VALUES (3200, 'M', 'DKNY', 'T-Shirt', 'White', 271, 'GT022', 12.99, NULL, 114, NULL, 'faded DKNY
chest: 52
length: 71', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-21 00:12:53.599706', NULL, NULL);
INSERT INTO public.clothing VALUES (1892, '25X32', 'Levis', 'Jeans', 'Navy', NULL, '487481', 20.00, NULL, NULL, NULL, 'women
ribcage straight

waist: 33
hips: 44
length: 109
pasadka: 28', true, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-02 07:03:59.570874', NULL, NULL);
INSERT INTO public.clothing VALUES (3271, 'S', 'Tommy Hilfiger', 'Leggings', 'Black', 277, '821541', 19.99, NULL, 116, NULL, 'Pink stripe on side', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-23 01:03:13.003897', NULL, NULL);
INSERT INTO public.clothing VALUES (1081, 'M', 'Calvin Klein', 'T-Shirt', 'White', 86, '893233', 10.04, NULL, NULL, NULL, 'golden sign', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.553247', NULL, NULL);
INSERT INTO public.clothing VALUES (1146, 'L', 'Calvin Klein', 'T-Shirt', 'Navy', 96, '710950', 5.95, NULL, NULL, NULL, 'large blue square, white letters in square', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:11.162384', NULL, NULL);
INSERT INTO public.clothing VALUES (1148, 'L', 'Calvin Klein', 'T-Shirt', 'Navy', 96, '710950', 5.95, NULL, NULL, NULL, 'large blue square, white letters in square', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:11.18062', NULL, NULL);
INSERT INTO public.clothing VALUES (1149, 'S', 'Calvin Klein', 'T-Shirt', 'Navy', 96, '710936', 5.95, NULL, NULL, NULL, 'no tag
large blue square with white letters', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:11.189994', NULL, NULL);
INSERT INTO public.clothing VALUES (1143, 'M', 'Calvin Klein', 'T-Shirt', 'Blue', 96, '557845', 6.71, NULL, NULL, NULL, 'red square in front', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:11.135476', NULL, NULL);
INSERT INTO public.clothing VALUES (1145, 'S', 'Calvin Klein', 'T-Shirt', 'Blue', 96, '557838', 6.71, NULL, NULL, NULL, 'red square in front', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:11.153615', NULL, NULL);
INSERT INTO public.clothing VALUES (2128, 'S', 'Tommy Hilfiger', 'Dress', 'Navy', 164, '440288', 27.99, NULL, 72, NULL, 'Tommy Jeans

chest: 50
length: 87
arm: 70
', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-16 18:52:56.934682', NULL, 0.00);
INSERT INTO public.clothing VALUES (2354, 'S', 'Calvin Klein', 'T-Shirt', 'Black', 188, '855773', 12.74, NULL, 74, NULL, 'Gold stones "calvin klein"

chest: 46
length: 64', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-31 15:11:57.354814', NULL, 0.00);
INSERT INTO public.clothing VALUES (2062, 'M', 'Tommy Hilfiger', 'Sweater', 'White', 158, '999806', 12.00, 16.16, 61, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-13 11:18:39.833572', NULL, 4.93);
INSERT INTO public.clothing VALUES (2149, 'XS', 'DKNY', 'Puffy Jacket', 'Grey', NULL, '391268', 49.99, 101.79, 63, 19, 'from costco

chest: 50
length: 84
arm: 63
shoulders: 41', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-18 15:38:51.842258', NULL, 11.23);
INSERT INTO public.clothing VALUES (2150, 'XS', 'DKNY', 'Puffy Jacket', 'Grey', NULL, '391268', 49.99, 101.79, 63, 19, 'from costco

chest: 50
length: 84
arm: 63
shoulders: 41', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-18 15:38:52.896347', NULL, 11.23);
INSERT INTO public.clothing VALUES (3353, 'L', 'Armani Exchange', 'T-Shirt', 'Blue', 283, '0302163', 19.99, NULL, 118, NULL, 'бело синяя футболка свитшот в комплекте с шортами
ПОГ 65
дл  74', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-27 04:58:22.890956', NULL, 0.00);
INSERT INTO public.clothing VALUES (3669, 'M', 'Calvin Klein', 'Windbreaker', 'Black', 298, '427543', 49.99, NULL, NULL, NULL, 'stripe "calvin" on sleeve

chest: 58
length: 70
arm: 67
shoulders: 50', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-04-08 05:16:37.357084', NULL, 0.00);
INSERT INTO public.clothing VALUES (3438, 'M', 'Armani Exchange', 'Polo Shirt', 'Blue', 283, '7431295', 19.99, NULL, 123, NULL, 'надпись слева на груди
Armani Exchange milano NY

ПОГ 52
дл 72
плечи 48', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-30 21:24:02.625839', NULL, NULL);
INSERT INTO public.clothing VALUES (3596, 'S', 'Armani Exchange', 'Dress', 'Pink', 293, '7212580', 28.00, 60.00, NULL, 23, 'ПОГ 51
ПОБ 49
дл 91
', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-04 05:41:27.057068', NULL, 0.00);
INSERT INTO public.clothing VALUES (2040, '4', 'Armani Exchange', 'Blazer', 'Navy', 156, '319567', 15.99, 21.79, 64, 9, 'chest: 49
length: 78', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 13:26:49.32428', NULL, 0.00);
INSERT INTO public.clothing VALUES (2306, '10/12Y', 'Tommy Hilfiger', 'Hoodie', 'Pink', NULL, '488595', 10.00, NULL, 70, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-26 16:13:09.5026', NULL, NULL);
INSERT INTO public.clothing VALUES (2039, 'XXL', 'Armani Exchange', 'Dress Shirt', 'Navy', 156, '413733', 9.99, 0.00, 67, 9, NULL, NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-01-08 13:25:40.357913', NULL, 0.00);
INSERT INTO public.clothing VALUES (2236, 'S', 'Michael Kors', 'Polo Shirt', 'Navy', 175, '429197', 10.00, 0.00, 67, 9, 'chest: 50
length: 71', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-01-22 10:06:14.220813', NULL, 0.00);
INSERT INTO public.clothing VALUES (3201, 'M', 'Calvin Klein', 'Dress Shirt', 'White', 271, '993026', 19.99, NULL, 112, NULL, 'short sleeves
', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-21 00:14:04.296696', NULL, 0.00);
INSERT INTO public.clothing VALUES (380, 'M', 'Calvin Klein', 'Sweat Pants', 'Grey', 29, '718796', 20.19, 27.29, 12, 9, 'men
stripe w/ calvin on side

waist: 41
hips: 52
length: 106
pasadka: 29', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.983385', NULL, NULL);
INSERT INTO public.clothing VALUES (4, 'L', 'Tommy Hilfiger', 'Puffy Jacket', 'Navy, Red', 1, '218973', 49.99, NULL, NULL, NULL, 'Blue hood, red body

Chest: 55
Waist: 52
Length: 64
Arm: 64', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:53.664985', NULL, NULL);
INSERT INTO public.clothing VALUES (3354, 'L', 'Armani Exchange', 'T-Shirt', 'Blue', 283, '0302163', 19.99, NULL, NULL, NULL, 'бело синяя футболка свитшот в комплекте с шортами
ПОГ 65
дл  74', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-27 04:58:26.950859', NULL, 0.00);
INSERT INTO public.clothing VALUES (1099, '???', 'Calvin Klein', 'unknown', 'Unknown', 88, '197938', 6.37, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.715486', NULL, NULL);
INSERT INTO public.clothing VALUES (3272, 'S', 'Calvin Klein', 'Leggings', 'Grey', 277, '8215232178', 19.99, NULL, NULL, NULL, 'Black stripe + letters on side', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-23 01:04:01.234579', NULL, 0.00);
INSERT INTO public.clothing VALUES (3670, 'S', 'Michael Kors', 'Dress Shirt', 'Black', 298, '566970', 29.99, NULL, NULL, NULL, 'с замочком на груди
ПОГ 48
ДЛ 73
плечи  39
рук 39', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-08 05:20:32.054987', NULL, NULL);
INSERT INTO public.clothing VALUES (3439, 'L', 'Armani Exchange', 'Polo Shirt', 'Blue', 283, '4610941', 19.99, NULL, 122, NULL, 'с бел полоской на воротнике', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-30 21:25:12.698559', NULL, NULL);
INSERT INTO public.clothing VALUES (3597, 'XS', 'Armani Exchange', 'Hoodie', 'White', 293, '0285602', 19.99, NULL, 125, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-04 05:45:49.269426', NULL, NULL);
INSERT INTO public.clothing VALUES (11, 'M', 'Tommy Hilfiger', 'Jacket', 'Navy, White, Red', 2, '053086', 19.99, NULL, NULL, NULL, 'navy & white boobs

Chest: 51
Waist: 50
Length: 61
Arm: 72', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:53.726697', NULL, NULL);
INSERT INTO public.clothing VALUES (3, 'M', 'Tommy Hilfiger', 'Coat', 'White, Black', 1, '510041', 49.99, NULL, NULL, NULL, 'Men
White chest, HILFIGER on arm

Chest: 59
Waist: 58
Length: 69
Arm: 68', NULL, 'men', NULL, NULL, NULL, NULL, '2020-12-21 01:07:53.652781', NULL, NULL);
INSERT INTO public.clothing VALUES (16, 'XS', 'Reebok', 'Hoodie Dress', 'Yellow, White, Black', 3, '130769', 19.99, NULL, NULL, NULL, 'Chest: 49
Waist: 45
Length: 81
Arm: 74', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:53.771339', NULL, NULL);
INSERT INTO public.clothing VALUES (17, 'M', 'Reebok', 'Hoodie Dress', 'Black, White', 3, '117456', 19.99, NULL, NULL, NULL, 'Chest: 55
Waist: 52
Length: 80
Arm: 72', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:53.780416', NULL, NULL);
INSERT INTO public.clothing VALUES (22, 'XS', 'Tommy Hilfiger', 'Jacket', 'White', 3, '224028', 22.99, NULL, NULL, NULL, 'Red & Navy boobs
Hooded

Chest: 47
Waist: 46
Length: 59
Arm: 66', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:53.822065', NULL, NULL);
INSERT INTO public.clothing VALUES (2129, 'XS', 'Tommy Hilfiger', 'Dress', 'Black', 164, '439992', 27.99, NULL, 75, NULL, 'cursive sign

chest: 46
length: 87
arm: 59', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-16 18:54:54.294104', NULL, 0.00);
INSERT INTO public.clothing VALUES (2208, 'XXS', 'DKNY', 'T-Shirt', 'White', 173, '747973', 9.99, NULL, 70, NULL, 'purple letters

chest: 40
length: 61', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-21 17:39:54.27652', NULL, 0.00);
INSERT INTO public.clothing VALUES (3671, 'M', 'Michael Kors', 'Dress Shirt', 'White', 298, '567052', 29.99, NULL, NULL, NULL, 'с замочком на груди
ПОГ 52
ДЛ 74
плечи  340
рук 39', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-08 05:22:39.566258', NULL, NULL);
INSERT INTO public.clothing VALUES (2134, 'S', 'Calvin Klein', 'T-Shirt', 'Pink', 166, '525188', 14.99, NULL, 59, NULL, 'white / silver logo on chest
chest: 44
length: 63', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-16 19:00:25.082649', NULL, 0.00);
INSERT INTO public.clothing VALUES (3440, 'XL', 'Armani Exchange', 'Polo Shirt', 'Blue', 283, '4610972', 19.99, NULL, 122, NULL, 'с бел полоской на воротнике', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-30 21:25:25.109624', NULL, NULL);
INSERT INTO public.clothing VALUES (2320, 'XS', 'Michael Kors', 'Puffy Jacket', 'Black', 184, '272908', 70.00, 140.00, 74, 22, 'long

chest: 51
length: 93
arm: 53/74
shoulders: 60
', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-31 14:41:10.500778', NULL, 0.00);
INSERT INTO public.clothing VALUES (2209, 'XXS', 'DKNY', 'T-Shirt', 'White', 173, '520682', 12.49, 26.79, 106, 23, 'empire state building
chest: 42
length: 61', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-01-21 17:40:33.400141', NULL, 0.00);
INSERT INTO public.clothing VALUES (1974, 'M', 'Calvin Klein', 'T-Shirt', 'Black', 151, '434640', 0.60, 30.36, 62, 22, 'Pink / silver logo on chest
chest: 48
length: 64', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 10:55:22.288625', NULL, 0.00);
INSERT INTO public.clothing VALUES (2042, '4', 'Armani Exchange', 'Blazer', 'Navy', 156, '319567', 15.99, NULL, 60, NULL, 'chest: 49
length: 78
', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 13:28:11.631821', NULL, 0.00);
INSERT INTO public.clothing VALUES (2336, 'M', 'Armani Exchange', 'Hoodie', 'Blue', 186, '147492', 35.99, 62.50, 74, 22, 'zipped

chest: 53
length: 68
arm: 67
shoulders: 46
', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-31 14:54:15.808943', NULL, 0.00);
INSERT INTO public.clothing VALUES (3202, 'S', 'Calvin Klein', 'Dress Shirt', 'White', 271, '993019', 19.99, NULL, 112, NULL, 'short sleeves
', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-21 00:14:18.855974', NULL, 0.00);
INSERT INTO public.clothing VALUES (3273, 'M', 'Tommy Hilfiger', 'Windbreaker', 'Blue', 277, '514358', 34.99, NULL, 115, NULL, 'bomber-like', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-23 01:06:27.773673', NULL, NULL);
INSERT INTO public.clothing VALUES (2279, '0', 'Calvin Klein', 'Dress', 'Black', 181, '646287', 9.26, 57.14, 72, 22, 'mid length

chest: 45
length: 112
hips: 45', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-23 21:30:53.66713', NULL, 0.00);
INSERT INTO public.clothing VALUES (3355, 'M', 'Armani Exchange', 'Shorts', 'Blue', 283, '0306338', 19.99, NULL, 118, NULL, 'бело синие к комплекте с свитшотот футболкой
ПОТ 42
ПОБ 56
дл 51', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-27 05:03:51.017874', NULL, NULL);
INSERT INTO public.clothing VALUES (1056, 'L', 'Calvin Klein', 'T-Shirt', 'Black', 84, '548868', 6.99, NULL, NULL, NULL, 'large white letters on chest', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.326111', NULL, NULL);
INSERT INTO public.clothing VALUES (25, 'L', 'Tommy Hilfiger', 'Sweater', 'Black', 3, '116713', 24.99, NULL, NULL, NULL, 'Long neck
TH + leaves on chest

Chest: 49
Waist: 47
Length: 67
Arm: 62', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:53.84877', NULL, NULL);
INSERT INTO public.clothing VALUES (28, 'L', 'Tommy Hilfiger', 'Vest Jacket', 'Red, Navy, White', 4, '795979', 29.99, 40.39, NULL, 1, 'SOLD TO ALLA

White and red boobs

Chest: 53
Waist: 50
Length: 64', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:53.873935', NULL, NULL);
INSERT INTO public.clothing VALUES (29, 'N/A', 'Tommy Hilfiger', 'Wallet', 'Black', 4, '606680', 16.99, 22.89, NULL, 1, 'SOLD TO ALLA', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:53.8839', NULL, NULL);
INSERT INTO public.clothing VALUES (30, 'N/A', 'Tommy Hilfiger', 'Wallet', 'Black', 4, '606680', 16.99, 22.89, NULL, 1, 'SOLD TO ALLA', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:53.892091', NULL, NULL);
INSERT INTO public.clothing VALUES (31, 'XL', 'Tommy Hilfiger', 'Puffy Jacket', 'Black', 4, '637038', 59.99, 80.80, NULL, 1, 'SOLD TO ALLA

Chest: 66
Waist: 63
Length: 71
Arm: 70', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:53.902216', NULL, NULL);
INSERT INTO public.clothing VALUES (32, 'XL', 'Tommy Hilfiger', 'Puffy Jacket', 'Red', 4, '542158', 59.99, 80.80, NULL, 1, 'SOLD TO ALLA

Hooded

Chest: 65
Waist: 61
Length: 73
Arm: 69', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:53.910766', NULL, NULL);
INSERT INTO public.clothing VALUES (33, 'L', 'Tommy Hilfiger', 'Puffy Jacket', 'Black', 4, '637045', 59.99, 80.80, NULL, 1, 'SOLD TO ALLA

Chest: 60
Waist: 60
Length: 70
Arm: 70', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:53.919422', NULL, NULL);
INSERT INTO public.clothing VALUES (34, 'M', 'Tommy Hilfiger', 'Vest Jacket', 'Black, Red, White', 4, '756478', 29.99, 40.39, NULL, 1, 'SOLD TO ALLA

Red & white boobs

Chest: 48
Waist: 45
Length: 61', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:53.927859', NULL, NULL);
INSERT INTO public.clothing VALUES (35, 'M', 'Tommy Hilfiger', 'Puffy Jacket', 'Navy, White, Red', 4, '959107', 49.99, 67.33, NULL, 1, 'SOLD TO ALLA

Hooded
Red & white boobs

Chest: 54
Waist: 52
Length: 59
Arm: 64', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:53.93647', NULL, NULL);
INSERT INTO public.clothing VALUES (2376, 'S', 'Karl Lagerfeld', 'Sweat Pants', 'White', NULL, '339582', 49.99, NULL, 74, NULL, 'black stripe on side', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-31 18:30:04.519636', NULL, NULL);
INSERT INTO public.clothing VALUES (2069, 'S', 'Tommy Hilfiger', 'Golfik', 'Green', 158, '130146', 10.00, 13.47, 61, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-13 11:27:28.516387', NULL, 4.93);
INSERT INTO public.clothing VALUES (2308, 'XS', 'Tommy Hilfiger', 'Sweat Pants', 'Navy', NULL, '777237', 20.00, 46.43, 70, 23, 'blue/white stripe on side

waist: 35
hips: 49
pasadka: 25
length: 96', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-26 16:17:39.469844', NULL, NULL);
INSERT INTO public.clothing VALUES (810, 'M', 'Calvin Klein', 'Sweat Pants', 'Navy', NULL, '263282', 20.00, 27.00, 53, 9, 'grey logo', true, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.739513', NULL, 0.00);
INSERT INTO public.clothing VALUES (2066, 'M', 'Calvin Klein', 'Puffy Jacket', 'Gold', 158, '617638', 44.00, 110.71, 65, 19, 'Chest: 53
Waist: 60
Length: 67
Arm: 64', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-13 11:22:56.704362', NULL, 7.58);
INSERT INTO public.clothing VALUES (2214, 'L', 'DKNY', 'Puffy Jacket', 'Black', 174, '992242', 65.00, NULL, 71, NULL, 'chest: 66
length: 90
arm: 70
shoulders: 54', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-01-21 17:48:23.876049', NULL, 0.00);
INSERT INTO public.clothing VALUES (2176, 'XXS', 'Tommy Hilfiger', 'Hoodie Dress', 'Navy', 169, '440264', 27.99, NULL, 66, NULL, 'letters on chest

chest: 44
length: 87
arm from neck: 67', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-21 17:02:30.690108', NULL, 0.00);
INSERT INTO public.clothing VALUES (1449, '???', 'Calvin Klein', 'Unknown', 'Unknown', 132, '066973', 3.81, 5.20, 52, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:13.986352', NULL, 0.00);
INSERT INTO public.clothing VALUES (1343, 'M', 'Armani Exchange', 'Polo Shirt', 'Red, White, Blue', 122, '000178', 13.99, 19.10, 41, 10, 'Red/white chest

Chest: 49
Length: 68', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:12.996149', NULL, NULL);
INSERT INTO public.clothing VALUES (1452, '???', 'Calvin Klein', 'Unknown', 'Unknown', 132, '067079', 2.72, 3.71, 52, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:14.013097', NULL, 0.00);
INSERT INTO public.clothing VALUES (379, 'L', 'Calvin Klein', 'Sweat Pants', 'Black', 29, '718741', 28.21, 50.00, 71, 22, 'men
stripe w/ white letters on side

waist: 44
hips: 56
length: 105
pasadka: 30', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.975627', NULL, 0.00);
INSERT INTO public.clothing VALUES (3203, 'L', 'Calvin Klein', 'Dress Shirt', 'White', 271, '993033', 19.99, NULL, 112, NULL, 'short sleeves
', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-21 00:14:47.957271', NULL, 0.00);
INSERT INTO public.clothing VALUES (36, 'L', 'Calvin Klein', 'Puffy Jacket', 'Black', 5, '598310', 59.99, NULL, NULL, NULL, 'Chest: 59
Waist: 54
Length: 71
Arm: 65', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:53.945121', NULL, NULL);
INSERT INTO public.clothing VALUES (1075, 'S', 'Calvin Klein', 'T-Shirt', 'Black', 86, '711308', 10.04, NULL, 114, NULL, 'white CK, grey letters on front', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.498424', NULL, NULL);
INSERT INTO public.clothing VALUES (43, 'L', 'Calvin Klein', 'Sweat Shirt', 'Grey', 6, '451913', 19.99, NULL, NULL, NULL, 'Gold CK on chest

Chest: 57
Waist: 56
Length: 67
Arm: 54', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:54.005086', NULL, NULL);
INSERT INTO public.clothing VALUES (46, 'XS', 'DKNY', 'Sweat Pants', 'Black', 7, '258134', 29.75, NULL, NULL, NULL, 'Rainbow "DKNY" hip

Waist: 38
Hips: 46
Length: 86
Pasadka: 25', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:54.030633', NULL, NULL);
INSERT INTO public.clothing VALUES (3441, 'M', 'Armani Exchange', 'Polo Shirt', 'Black', 283, '4139428', 19.99, NULL, 113, NULL, 'с бел полоской на воротнике
ПОГ 50
дл 67
плечи 44', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-30 21:27:09.741696', NULL, NULL);
INSERT INTO public.clothing VALUES (3672, 'XS', 'Calvin Klein', 'T-Shirt', 'Black', NULL, '638542', 11.00, NULL, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-08 05:49:06.623424', NULL, NULL);
INSERT INTO public.clothing VALUES (9, 'S', 'Calvin Klein', 'Sweater', 'Black', 2, '870996', 19.99, NULL, NULL, NULL, 'Long neck

Chest: 42
Waist: 39
Length: 61
Arm: 63', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:53.708607', NULL, NULL);
INSERT INTO public.clothing VALUES (1085, 'M', 'Calvin Klein', 'T-Shirt', 'White', 86, '893233', 10.04, NULL, NULL, NULL, 'golden sign', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.588593', NULL, NULL);
INSERT INTO public.clothing VALUES (3356, 'M', 'Armani Exchange', 'Shorts', 'Blue', 283, '0306338', 19.99, NULL, 127, NULL, 'бело синие к комплекте с свитшотот футболкой
ПОТ 42
ПОБ 56
дл 51', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-27 05:04:08.090727', NULL, NULL);
INSERT INTO public.clothing VALUES (1051, 'S', 'Calvin Klein', 'T-Shirt', 'White', 84, '893226', 10.00, NULL, NULL, NULL, 'golden sign on chest', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:10.279278', NULL, NULL);
INSERT INTO public.clothing VALUES (1111, 'M', 'Calvin Klein', 'T-Shirt', 'Black', 88, '858064', 12.75, 17.17, NULL, 10, 'SOLD TO ALLA', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.834249', NULL, NULL);
INSERT INTO public.clothing VALUES (47, 'S', 'DKNY', 'Sweat Pants', 'Black', 7, '258127', 29.75, NULL, NULL, NULL, 'Rainbow "DKNY" on hip

Waist: 41
Hips: 49
Length: 87
Pasadka: 25', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:54.038944', NULL, NULL);
INSERT INTO public.clothing VALUES (1113, '???', 'Calvin Klein', 'unknown', 'Unknown', 88, '421736', 12.75, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.851888', NULL, NULL);
INSERT INTO public.clothing VALUES (2054, 'S', 'Calvin Klein', 'Sweater', 'Pink', NULL, '954827', 24.99, NULL, NULL, NULL, 'Long neck
Belly pocket
"Calvin" across chest

Chest: 47
Waist: 41
Length: 67
Arm: 66', NULL, NULL, NULL, NULL, NULL, NULL, '2021-01-13 11:07:02.3486', NULL, NULL);
INSERT INTO public.clothing VALUES (62, 'S', 'DKNY', 'Hoodie', 'Black', 7, '257595', 34.75, NULL, NULL, NULL, 'Rainbow "DKNY" on chest

Chest: 56
Waist: 52
Length: 51
Arm: 50', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:54.183421', NULL, NULL);
INSERT INTO public.clothing VALUES (61, 'S', 'Calvin Klein', 'Sweat Pants', 'Mint', 7, '827336', 29.75, NULL, NULL, NULL, 'Black "Calvin" on calf
Has pockets

Waist: 40
Hips: 47
Length: 93
Pasadka: 25', false, 'women', NULL, NULL, NULL, 'usa', '2020-12-21 01:07:54.174487', NULL, 0.00);
INSERT INTO public.clothing VALUES (374, 'XS', 'Calvin Klein', 'Hoodie', 'Black', 29, '962136', 12.17, NULL, NULL, NULL, 'women
short
sparkly giant CK on front

chest: 53
length: 49
arm: 46/67', true, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.932145', NULL, NULL);
INSERT INTO public.clothing VALUES (1813, 'S', 'Tommy Hilfiger', 'T-Shirt', 'White', NULL, '014742', 19.99, NULL, NULL, NULL, 'women
tommy hilfger on front', true, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-26 07:46:36.434742', NULL, NULL);
INSERT INTO public.clothing VALUES (1816, '4S', 'Tommy Hilfiger', 'Dress Shirt', 'White', NULL, '985845', 6.00, NULL, NULL, NULL, 'women', true, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-26 07:51:30.282401', NULL, NULL);
INSERT INTO public.clothing VALUES (1823, 'XL', 'Levis', 'T-Shirt', 'White', NULL, '611193', 6.99, NULL, NULL, NULL, 'women
red sign on chest

chest: 53
length: 66', true, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-26 08:01:37.919121', NULL, NULL);
INSERT INTO public.clothing VALUES (1825, 'L', 'Levis', 'T-Shirt', 'White', NULL, '433708', 9.99, NULL, NULL, NULL, 'women
levis red/white/blue flag on chest

chest: 50
length: 65', true, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-26 08:06:40.899882', NULL, NULL);
INSERT INTO public.clothing VALUES (77, 'S', 'Calvin Klein', 'Sweater', 'White', 9, '987054', 26.27, NULL, NULL, NULL, 'Black sequined ''CALVIN'' on chest

Chest: 46
Waist: 44
Length: 57
Arm: 61', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:54.311737', NULL, NULL);
INSERT INTO public.clothing VALUES (908, 'S', 'Levis', 'Trucker Jacket', 'Light Blue', 63, '1000S', 25.80, NULL, 36, NULL, '', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:08.913013', NULL, NULL);
INSERT INTO public.clothing VALUES (1451, '???', 'Calvin Klein', 'Unknown', 'Unknown', 132, '067178', 2.72, 3.71, 52, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:14.004018', NULL, 0.00);
INSERT INTO public.clothing VALUES (2140, 'L', 'Calvin Klein', 'Sweat Shirt', 'Black', NULL, '488685', 20.00, 53.57, 69, 22, 'chest: 57
length: 71
arm: 65', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-01-16 19:10:40.399806', NULL, 0.00);
INSERT INTO public.clothing VALUES (75, 'M', 'Calvin Klein', 'Sweater', 'Black', 9, '986279', 19.66, 50.00, NULL, 22, 'White/green stripe along arms/shoulder

Chest: 48
Waist: 46
Length: 60
Arm: 72', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.294353', NULL, NULL);
INSERT INTO public.clothing VALUES (2095, 'XS', 'Karl Lagerfeld', 'Sweat Pants', 'Navy', 161, '844916', 49.99, NULL, NULL, NULL, 'white line on side

waist: 38
hips: 49
length: 101
pasadka: 28', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-01-13 12:09:36.145267', NULL, NULL);
INSERT INTO public.clothing VALUES (80, 'S', 'Calvin Klein', 'Sweat Pants', 'Unknown', 9, '784462', 29.49, 54.20, NULL, 2, 'sent in package 1.2', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:54.336216', NULL, NULL);
INSERT INTO public.clothing VALUES (2113, 'M', 'DKNY', 'Puffy Jacket', 'Black', NULL, '391312', 49.99, 101.79, 63, 22, 'from costco

chest: 56
length: 88
arm: 66
shoulders: 43', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-16 14:41:03.511337', NULL, 0.00);
INSERT INTO public.clothing VALUES (84, 'S', 'Calvin Klein', 'Sweater', 'Black', 9, '986286', 19.66, NULL, NULL, NULL, 'in package 1.2

White/green stripe along arms/shoulder

Chest: 43
Waist: 41
Length: 55
Arm: 72', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:54.370364', NULL, NULL);
INSERT INTO public.clothing VALUES (1039, 'S', 'Tommy Hilfiger', 'Polo Shirt', 'Navy', 83, '329795', 11.99, NULL, NULL, NULL, 'women
tommy on chest', true, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:10.170681', NULL, NULL);
INSERT INTO public.clothing VALUES (378, 'M', 'Calvin Klein', 'Sweat Shirt', 'Black', 29, '782155', 20.19, 27.29, 12, 9, 'zipped
striped calvin klein on sleeve

chest: 52
length: 68
arm: 65', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.966095', NULL, NULL);
INSERT INTO public.clothing VALUES (439, 'L', 'Tommy Hilfiger', 'Hoodie', 'White', NULL, '237905', 22.99, 31.04, 12, 9, 'Fluffy
zipper
red boob
blue boob', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.50204', NULL, NULL);
INSERT INTO public.clothing VALUES (359, 'L', 'Calvin Klein', 'Sweat Pants', 'Black', 29, '263176', 20.19, 27.29, 12, 9, 'grey logo

Waist: 46
hips: 55
length: 108
pasadka: 31', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.802868', NULL, NULL);
INSERT INTO public.clothing VALUES (360, 'L', 'Calvin Klein', 'Sweat Shirt', 'Black', 29, '307337', 20.19, 27.29, 12, 9, 'Grey logo on chest

Chest: 59
Length: 71
Arm: 67', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.811935', NULL, NULL);
INSERT INTO public.clothing VALUES (370, 'L', 'Calvin Klein', 'Gloves', 'Black', 29, '543084', 12.10, 16.35, 12, 9, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.898038', NULL, NULL);
INSERT INTO public.clothing VALUES (3275, 'XL', 'Guess', 'T-Shirt', 'White', 277, '079405', 12.99, 28.57, NULL, 23, 'triangle question mark

chest: 50
length: 64', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-23 01:07:04.532097', NULL, 0.00);
INSERT INTO public.clothing VALUES (417, 'XXL', 'Armani Exchange', 'Jacket', 'Navy, Grey', 32, '711047', 34.99, 47.79, 12, 9, 'puffy front
cotton arms/back', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.311101', NULL, NULL);
INSERT INTO public.clothing VALUES (418, 'L', 'Armani Exchange', 'Hoodie', 'Black', 32, '941916', 39.99, 54.61, 12, 9, 'with zipper', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.319325', NULL, NULL);
INSERT INTO public.clothing VALUES (419, 'L', 'Armani Exchange', 'Sweat Pants', 'Black', 32, '942272', 29.99, 40.95, 12, 9, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.328221', NULL, NULL);
INSERT INTO public.clothing VALUES (420, 'L', 'Armani Exchange', 'Hoodie', 'Black, Navy', 32, '941978', 39.99, 54.61, 12, 9, 'with zipper', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.336742', NULL, NULL);
INSERT INTO public.clothing VALUES (83, 'N/A', 'Calvin Klein', 'Backpack', 'Black', 9, '269421', 31.72, NULL, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2020-12-21 01:07:54.361303', NULL, 0.00);
INSERT INTO public.clothing VALUES (1658, 'XS', 'Michael Kors', 'Puffy Jacket', 'Black', 56, '148074', 69.99, NULL, 44, NULL, 'Puffy hood
bought from wilsons leather

Chest: 45
Waist: 41
Hips: 47
Length: 66
Arm: 63
', true, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:15.913471', NULL, 0.00);
INSERT INTO public.clothing VALUES (1155, 'S', 'Calvin Klein', 'T-Shirt', 'Black', 99, '849295', 5.95, NULL, NULL, NULL, 'palm tree picture on chest', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:11.244112', NULL, NULL);
INSERT INTO public.clothing VALUES (3357, 'M', 'Armani Exchange', 'Shorts', 'Blue', 283, '0306338', 19.99, NULL, NULL, NULL, 'бело синие к комплекте с свитшотот футболкой
ПОТ 42
ПОБ 56
дл 51', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-27 05:04:12.127292', NULL, NULL);
INSERT INTO public.clothing VALUES (3600, 'S', 'Armani Exchange', 'Leather Jacket', 'Black', 293, '4136397', 39.99, NULL, NULL, NULL, 'ПОГ 44
по низу 41
длина 49
рук 50
плечи 39', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-04 05:55:12.372966', NULL, 0.00);
INSERT INTO public.clothing VALUES (3673, 'XS', 'Calvin Klein', 'Dress Shirt', 'Red', NULL, '224165', 17.00, NULL, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-08 05:49:45.504337', NULL, NULL);
INSERT INTO public.clothing VALUES (3442, 'M', 'Armani Exchange', 'Polo Shirt', 'Black', 283, '7416542', 19.99, NULL, NULL, NULL, 'с бел полоской на воротнике
ПОГ 50
дл 67
плечи 44', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-30 21:27:32.89874', NULL, 0.00);
INSERT INTO public.clothing VALUES (3204, 'M', 'Tommy Hilfiger', 'Windbreaker', 'White, Black', 271, '331758', 24.99, NULL, 125, NULL, 'Faded', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-21 00:15:37.614395', NULL, 0.00);
INSERT INTO public.clothing VALUES (2312, 'L', 'Calvin Klein', 'Sweat Shirt', 'Black', NULL, '958641', 24.99, NULL, 72, NULL, 'silver sign on chest

chest: 61
length: 65/73
arm: 43/69', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-27 16:10:20.329721', NULL, NULL);
INSERT INTO public.clothing VALUES (3205, 'M', 'DKNY', 'Dress', 'Black', 271, '675993', 19.99, NULL, 109, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-21 00:16:04.941562', NULL, NULL);
INSERT INTO public.clothing VALUES (317, 'XS', 'Calvin Klein', 'Hoodie', 'Black', 27, '110086', 11.82, 11.82, NULL, NULL, 'cropped female hoodie
w/ silver sign

chest: 56
length: 49
arm: 46-70', NULL, 'women', NULL, NULL, NULL, NULL, '2020-12-21 01:07:56.431211', NULL, NULL);
INSERT INTO public.clothing VALUES (101, 'S', 'Tommy Hilfiger', 'Sweat Shirt', 'White', 13, '792759', 15.99, 21.84, NULL, 1, '"Tommy Hilfiger" in block letters on chest

Chest: 51
Waist: 47
Length: 62
Arm: 59', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:54.525557', NULL, NULL);
INSERT INTO public.clothing VALUES (104, 'M', 'Tommy Hilfiger', 'Sweat Pants', 'White', 11, '412125', 15.99, 21.84, NULL, 1, 'Block letters "Tommy hilfiger" down leg

Waist: 42
Hips: 52
Length: 95
Pasadka: 24', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:54.552873', NULL, NULL);
INSERT INTO public.clothing VALUES (1691, 'M', 'DKNY', 'Jacket', 'Black', 56, '??????', 29.99, NULL, 46, 11, 'Kid Clothes
Reversible
Pink fluffy', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:16.215639', NULL, NULL);
INSERT INTO public.clothing VALUES (1692, 'M', 'DKNY', 'Jacket', 'Pink', 56, '??????', 29.99, NULL, 46, 11, 'Kid Clothes
Reversible
white fluffy', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:16.224492', NULL, NULL);
INSERT INTO public.clothing VALUES (105, 'L', 'Tommy Hilfiger', 'Sweat Pants', 'White', 11, '412132', 16.01, 21.84, NULL, 1, 'Block letters "Tommy hilfiger" down leg

Waist: 47
Hips: 56
Length: 98
Pasadka: 28', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:54.561135', NULL, NULL);
INSERT INTO public.clothing VALUES (106, 'M', 'Tommy Hilfiger', 'Sweat Shirt', 'Teal', 13, '792902', 15.99, NULL, NULL, NULL, '"Tommy Hilfiger" in block letters on chest

Chest: 53
Waist: 51
Length: 63
Arm:  61', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:54.570141', NULL, NULL);
INSERT INTO public.clothing VALUES (114, 'XS', 'Tommy Hilfiger', 'Sweat Pants', 'Navy', 11, '790779', 15.99, NULL, NULL, NULL, 'Block letters "Tommy hilfiger" down leg

Waist: 35
Hips: 47
Length: 96
Pasadka: 24', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:54.641959', NULL, NULL);
INSERT INTO public.clothing VALUES (121, 'L', 'Tommy Hilfiger', 'Sweat Pants', 'Teal', 13, '790878', 15.99, 21.84, NULL, 1, 'Block letters "Tommy hilfiger" down leg

Waist: 47
Hips: 56
Length: 98
Pasadka: 28', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:54.70371', NULL, NULL);
INSERT INTO public.clothing VALUES (122, 'L', 'Tommy Hilfiger', 'Sweat Shirt', 'Teal', 13, '792919', 15.99, 21.84, NULL, 1, '"Tommy Hilfiger" in block letters on chest

Chest: 55
Waist: 53
Length: 63
Arm: 60', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:54.711894', NULL, NULL);
INSERT INTO public.clothing VALUES (3276, 'XS', 'Tommy Hilfiger', 'Hoodie', 'Blue', 277, '828205', 29.99, NULL, NULL, NULL, 'zipped
chest: 52
length: 55
arm: 53/71', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-23 01:08:38.043373', NULL, NULL);
INSERT INTO public.clothing VALUES (426, 'L', 'Armani Exchange', 'T-Shirt', 'Blue', 32, '003669', 12.99, 17.74, 12, 9, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.389169', NULL, NULL);
INSERT INTO public.clothing VALUES (3358, 'L', 'Armani Exchange', 'Shorts', 'Blue', 283, '0306321', 19.99, NULL, 118, NULL, 'бело синие к комплекте с свитшотот футболкой
ПОТ 45
ПОБ 59
дл 54', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-27 05:05:03.685613', NULL, 0.00);
INSERT INTO public.clothing VALUES (156, '24', 'Levis', 'Skirt', 'Light Blue', NULL, '796087', 8.99, NULL, 119, NULL, 'Waist: 33
Hips: 46
Length: 44', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:55.048771', NULL, NULL);
INSERT INTO public.clothing VALUES (3674, 'N/A', 'Karl Lagerfeld', 'Tote Bag', 'Cream, White', NULL, '776137', 44.00, NULL, 123, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-08 06:15:47.312715', NULL, 0.00);
INSERT INTO public.clothing VALUES (3443, 'XL', 'Armani Exchange', 'Polo Shirt', 'Black', 283, '2332570', 19.99, NULL, 122, NULL, 'вырез мысом
ПОГ 56
дл 74
плечи 48
', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-30 21:29:26.035604', NULL, NULL);
INSERT INTO public.clothing VALUES (126, 'XS', 'Tommy Hilfiger', 'Sweat Pants', 'Navy', 11, '790779', 15.99, NULL, NULL, NULL, 'Block letters "Tommy hilfiger" down leg

Waist: 35
Hips: 47
Length: 96
Pasadka: 24', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:54.746957', NULL, NULL);
INSERT INTO public.clothing VALUES (27, 'XL', 'Tommy Hilfiger', 'Puffy Jacket', 'Grey, Red', 4, '531572', 69.99, 94.26, NULL, 1, 'SOLD TO ALLA

Men
Hooded
Red across chest
Grey top and bottom

Chest: 66
Waist: 65
Length: 75
Arm: 71', NULL, 'men', NULL, NULL, NULL, NULL, '2020-12-21 01:07:53.865664', NULL, NULL);
INSERT INTO public.clothing VALUES (421, 'L', 'Armani Exchange', 'Sweat Pants', 'Navy', 32, '942333', 29.99, 40.95, 12, 9, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.346066', NULL, NULL);
INSERT INTO public.clothing VALUES (422, 'M', 'Armani Exchange', 'Jacket', 'Navy, Grey', 33, '884137', 34.99, 47.79, 12, 9, 'puffy front
cotton arms/back', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.354559', NULL, NULL);
INSERT INTO public.clothing VALUES (110, 'S', 'Tommy Hilfiger', 'Sweat Shirt', 'Navy', 13, '792827', 15.99, 50.00, NULL, 16, '"Tommy Hilfiger" in block letters on chest
sold with 790786

Chest: 51
Waist: 47
Length: 62
Arm: 59', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.605333', NULL, NULL);
INSERT INTO public.clothing VALUES (1038, 'M', 'Tommy Hilfiger', 'Polo Shirt', 'Navy', 83, '329801', 11.99, NULL, NULL, NULL, 'women
tommy on chest', true, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:10.161521', NULL, NULL);
INSERT INTO public.clothing VALUES (1115, '???', 'Calvin Klein', 'unknown', 'Unknown', 89, '847994', 13.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.869802', NULL, NULL);
INSERT INTO public.clothing VALUES (141, 'M', 'Calvin Klein', 'Hoodie', 'Black', NULL, '687169', 24.99, NULL, NULL, NULL, 'Long neck
Big white letters on chest
small "calvin klein performance" tag on bottom corner

Chest: 61
Waist: 51
Length: 61
Arm: 43', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:54.920376', NULL, NULL);
INSERT INTO public.clothing VALUES (144, 'S', 'Calvin Klein', 'Sweater', 'Black', NULL, '810239', 24.99, NULL, NULL, NULL, 'Long neck
Big white letters on chest
small "calvin klein performance" tag on bottom corner

Chest: 58
Waist: 54
Length: 63
Arm: 68', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:54.944798', NULL, NULL);
INSERT INTO public.clothing VALUES (155, 'XL', 'Michael Kors', 'Hoodie', 'Black', NULL, '223954', 24.99, NULL, NULL, NULL, 'Men

Chest: 61
Waist: 59
Length: 73
Arm: 73', NULL, 'men', NULL, NULL, NULL, NULL, '2020-12-21 01:07:55.0412', NULL, NULL);
INSERT INTO public.clothing VALUES (1693, '12', 'DKNY', 'Jacket', 'Pink', 56, '454583', 24.99, NULL, 46, 11, 'Kid Clothes
Reversible
white fluffy', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:16.233937', NULL, NULL);
INSERT INTO public.clothing VALUES (3206, 'L', 'Michael Kors', 'Dress', 'Black', 271, '444533', 14.99, NULL, 109, NULL, 'gold KORS', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-21 00:16:32.844682', NULL, NULL);
INSERT INTO public.clothing VALUES (3277, '7.5', 'Calvin Klein', 'Shoes', 'Black', 277, '57573500299918', 29.99, NULL, NULL, NULL, 'wedge heels
gloss', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-23 01:09:27.914752', NULL, NULL);
INSERT INTO public.clothing VALUES (3359, 'L', 'Armani Exchange', 'Shorts', 'Blue', NULL, '0306321', 19.99, NULL, NULL, NULL, 'бело синие к комплекте с свитшотот футболкой
ПОТ 45
ПОБ 59
дл 54', NULL, 'men', NULL, NULL, NULL, NULL, '2021-03-27 05:05:43.870993', NULL, NULL);
INSERT INTO public.clothing VALUES (79, 'XS', 'Calvin Klein', 'Sweater', 'Red', 9, '986248', 19.66, 53.21, NULL, 23, 'White line + black "calvin kelin jeans" down arms

Chest: 40
Waist: 39
Length: 52
Arm: 72', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.327911', NULL, NULL);
INSERT INTO public.clothing VALUES (3602, '27', 'Armani Exchange', 'Jeans', 'Navy', 293, '4371361', 29.99, NULL, NULL, NULL, 'ПОТ 36
ПОБ 41
дл 98
пос 22', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-04 06:06:45.084729', NULL, NULL);
INSERT INTO public.clothing VALUES (3444, 'XL', 'Armani Exchange', 'Polo Shirt', 'Black', 283, '2332570', 19.99, NULL, 123, NULL, 'вырез мысом
ПОГ 56
дл 74
плечи 48
', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-30 21:29:50.015209', NULL, NULL);
INSERT INTO public.clothing VALUES (3675, 'N/A', 'Karl Lagerfeld', 'Tote Bag', 'Black', NULL, '202299', 44.00, NULL, 123, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-08 06:16:00.926368', NULL, 0.00);
INSERT INTO public.clothing VALUES (39, 'S', 'Calvin Klein', 'Hoodie', 'White', 6, '213153', 22.99, NULL, 4, NULL, '"Calvin Klein Jeans" and big red CK on chest

Chest: 58
Waist: 53
Length: 52
Arm: 47', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:53.970836', NULL, NULL);
INSERT INTO public.clothing VALUES (1997, 'M', 'Calvin Klein', 'Belt', 'Grey', 154, '268687', 3.51, NULL, 57, NULL, 'logo belt
length: 102
', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 11:50:35.757575', NULL, 0.00);
INSERT INTO public.clothing VALUES (52, 'S', 'Calvin Klein', 'Hoodie', 'Pink', 7, '827558', 29.75, NULL, 4, NULL, 'Black "Calvin" across chest
Belly pocket

Chest: 54
Waist: 52
Length: 54
Arm: 70', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.094099', NULL, NULL);
INSERT INTO public.clothing VALUES (1394, '29', 'Calvin Klein', 'Jeans', 'Blue', 126, '012276', 11.51, NULL, 74, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:13.458745', NULL, 0.00);
INSERT INTO public.clothing VALUES (164, 'M', 'DKNY', 'Purse', 'Black', NULL, '540233', 16.99, NULL, NULL, NULL, 'Belt + purse attached', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:55.113328', NULL, NULL);
INSERT INTO public.clothing VALUES (169, 'N/A', 'Levis', 'Wallet', 'Black', NULL, '049222', 12.99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:55.154593', NULL, NULL);
INSERT INTO public.clothing VALUES (170, 'L', 'Levis', 'Jean Jacket', 'Navy', NULL, '560763', 39.99, NULL, NULL, NULL, 'Men

Chest: 59
Waist: 58
Length: 68
Arm: 67
Shoulder: 47', NULL, 'men', NULL, NULL, NULL, NULL, '2020-12-21 01:07:55.16145', NULL, NULL);
INSERT INTO public.clothing VALUES (1116, '???', 'Calvin Klein', 'unknown', 'Unknown', 89, '848175', 13.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.878347', NULL, NULL);
INSERT INTO public.clothing VALUES (178, 'L', 'Michael Kors', 'Puffy Jacket', 'Grey', NULL, '9621', 79.99, NULL, NULL, NULL, 'Dark grey
furry hood lining

Chest: 60
Waist: 59
Length: 100
Arm: 66', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:55.228906', NULL, NULL);
INSERT INTO public.clothing VALUES (152, 'S', 'Adidas', 'Sport Pants', 'White, Purple', NULL, '622829', 19.99, NULL, NULL, NULL, 'White stripes + patches of different shades of purple.
                                                
Waist: 34
Hips: 51
Length: 108
Pasadka: 30', NULL, 'women', NULL, NULL, NULL, 'Usa', '2020-12-21 01:07:55.016296', NULL, 0.00);
INSERT INTO public.clothing VALUES (1117, '???', 'Calvin Klein', 'unknown', 'Unknown', 89, '528489', 9.40, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.887398', NULL, NULL);
INSERT INTO public.clothing VALUES (1118, '???', 'Calvin Klein', 'unknown', 'Unknown', 90, '640333', 14.31, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.896086', NULL, NULL);
INSERT INTO public.clothing VALUES (1136, 'M', 'Calvin Klein', 'Puffy Jacket', 'Pink', 95, '224547', 22.02, 81.35, NULL, 10, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.060161', NULL, NULL);
INSERT INTO public.clothing VALUES (3278, '7', 'Calvin Klein', 'Flip Flops', 'White', 277, '97017800149911', 14.99, NULL, NULL, NULL, 'golden with calvin klein band 
length: 24.5cm', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-23 01:10:37.129729', NULL, NULL);
INSERT INTO public.clothing VALUES (3207, 'S', 'Guess', 'T-Shirt', 'Black', 271, '964145', 12.99, NULL, 114, NULL, 'pink triangle sign
chest: 43
length: 62', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-21 00:17:21.298631', NULL, NULL);
INSERT INTO public.clothing VALUES (3360, 'One Size', 'Armani Exchange', 'Hat', 'Black', 283, '4174527', 9.99, NULL, 118, NULL, 'чёрная с жёлтым', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-27 05:06:51.700275', NULL, NULL);
INSERT INTO public.clothing VALUES (3603, 'XS', 'Armani Exchange', 'T-Shirt', 'Navy', 293, '0283905', 19.99, NULL, NULL, NULL, 'с полоской по рукаву укороченная
ПОГ 53
дл 48
', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-04 06:13:26.457371', NULL, NULL);
INSERT INTO public.clothing VALUES (3676, 'M', 'Tommy Hilfiger', 'Windbreaker', 'White', NULL, '866504', 29.99, NULL, 123, NULL, 'Costco', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-08 06:30:51.07337', NULL, NULL);
INSERT INTO public.clothing VALUES (99, 'XS', 'Tommy Hilfiger', 'Sweat Shirt', 'White', 12, '792742', 16.99, NULL, 19, NULL, '"Tommy Hilfiger" in block letters on chest

Chest: 47
Waist: 44
Length: 60
Arm: 58', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.507901', NULL, NULL);
INSERT INTO public.clothing VALUES (225, '1SZ', 'Calvin Klein', 'Scarf', 'Black, White', NULL, '449612', 14.99, NULL, 5, NULL, 'Furry
White ends', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:55.627291', NULL, NULL);
INSERT INTO public.clothing VALUES (423, 'L', 'Armani Exchange', 'T-Shirt', 'Black', 33, '903143', 19.99, 27.30, 12, 9, 'stones', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.363407', NULL, NULL);
INSERT INTO public.clothing VALUES (175, 'S', 'Tommy Hilfiger', 'Sweater', 'Navy', 18, '728598', 10.39, NULL, NULL, NULL, 'V neck
Diamond pattern

Chest: 45
Waist: 42
Length: 64
Arm: 62', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:55.202752', NULL, NULL);
INSERT INTO public.clothing VALUES (174, 'S', 'Tommy Hilfiger', 'Sweater', 'Navy', 18, '728598', 10.39, NULL, NULL, NULL, 'V neck
Diamond pattern

Chest: 45
Waist: 42
Length: 64
Arm: 62', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:55.194016', NULL, NULL);
INSERT INTO public.clothing VALUES (424, 'M', 'Armani Exchange', 'T-Shirt', 'Black', 33, '906176', 19.99, 27.30, 12, 9, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.371684', NULL, NULL);
INSERT INTO public.clothing VALUES (425, 'L', 'Armani Exchange', 'T-Shirt', 'Black', 33, '143197', 19.99, 27.30, 12, 9, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.380609', NULL, NULL);
INSERT INTO public.clothing VALUES (427, 'M', 'Armani Exchange', 'T-Shirt', 'Black', 33, '902979', 19.99, 27.30, 12, 9, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.398062', NULL, NULL);
INSERT INTO public.clothing VALUES (1120, 'S', 'Calvin Klein', 'Pants', 'Black', 90, '529765', 26.77, NULL, NULL, NULL, 'White strip on side', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.913731', NULL, NULL);
INSERT INTO public.clothing VALUES (66, '???', 'Calvin Klein', 'Sweat Shirt', 'Purple', NULL, '9933', 19.99, NULL, 2, NULL, 'Fluffy
Belly pocket', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.218296', NULL, NULL);
INSERT INTO public.clothing VALUES (97, 'S', 'Calvin Klein', 'Sweater', 'Red', NULL, '790012', 24.99, NULL, 4, NULL, 'Long neck
Black "calvin" on chest

Chest: 57
Waist: 53
Length: 59
Arm: 69', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.490502', NULL, NULL);
INSERT INTO public.clothing VALUES (280, 'N/A', 'DKNY', 'Purse', 'Black', NULL, '314144', 39.99, NULL, 5, NULL, 'Triangle pointing down pattern

length: 23
height: 16', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.101338', NULL, NULL);
INSERT INTO public.clothing VALUES (390, '1SZ', 'Tommy Hilfiger', 'Hat', 'White', 31, '561914', 14.39, 29.80, 34, 14, 'sold for 850
White beanie cap', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.08041', NULL, NULL);
INSERT INTO public.clothing VALUES (3208, 'L', 'Michael Kors', 'T-Shirt', 'Black', 271, '490998', 14.99, NULL, 114, NULL, 'many KORS across chest
chest: 56
length: 71
', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-21 00:18:31.144564', NULL, NULL);
INSERT INTO public.clothing VALUES (3361, 'M', 'Armani Exchange', 'T-Shirt', 'White', 283, '0290118', 15.99, NULL, 118, NULL, 'с фиолетовыми буквами с боку', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-27 05:08:05.303444', NULL, NULL);
INSERT INTO public.clothing VALUES (3279, '10', 'Calvin Klein', 'Shoes', 'Brown', 277, '51487500299910', 29.99, NULL, 118, NULL, 'CK pattern
no laces', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-23 01:11:14.985861', NULL, NULL);
INSERT INTO public.clothing VALUES (3604, 'S', 'Armani Exchange', 'T-Shirt', 'Navy', 293, '0283882', 19.99, NULL, NULL, NULL, 'с полоской по рукаву укороченная
ПОГ 57
дл 48
', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-04 06:13:58.494977', NULL, NULL);
INSERT INTO public.clothing VALUES (3677, 'S', 'Tommy Hilfiger', 'Windbreaker', 'White', NULL, '866511', 29.99, NULL, 123, NULL, 'costco jacket', NULL, 'women', NULL, NULL, NULL, NULL, '2021-04-08 06:32:46.436159', NULL, NULL);
INSERT INTO public.clothing VALUES (428, 'M', 'Armani Exchange', 'T-Shirt', 'White', 33, '903099', 19.99, 27.30, 12, 9, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.40659', NULL, NULL);
INSERT INTO public.clothing VALUES (429, 'L', 'Armani Exchange', 'T-Shirt', 'White', 33, '906007', 19.99, 27.30, 12, 9, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.415368', NULL, NULL);
INSERT INTO public.clothing VALUES (430, 'XL', 'Armani Exchange', 'Jacket', 'Grey, Navy', 33, '711023', 34.99, 47.79, 12, 9, 'puffy front
cotton arms/back', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.424196', NULL, NULL);
INSERT INTO public.clothing VALUES (442, 'M', 'Calvin Klein', 'Sweat Shirt', 'Black', NULL, '958658', 24.99, 33.74, 12, 9, 'long neck
silver letters', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.533027', NULL, NULL);
INSERT INTO public.clothing VALUES (179, 'M', 'Tommy Hilfiger', 'Sweat Shirt', 'Black', NULL, '932711', 19.99, NULL, NULL, NULL, 'Tommy + red/white line + Hilfiger on chest

Chest: 49
Waist: 47
Length: 59
Arm: 62', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:55.236983', NULL, NULL);
INSERT INTO public.clothing VALUES (3209, 'S', 'Tommy Hilfiger', 'T-Shirt', 'Black', 271, '825051', 14.99, NULL, NULL, NULL, 'black tommy hilfiger on white stripe
chest: 45
length: 61', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-21 00:19:29.5323', NULL, NULL);
INSERT INTO public.clothing VALUES (2117, 'M', 'Calvin Klein', 'Dress Shirt', 'White', NULL, 'Motak561', 12.00, 39.29, 58, 22, 'chest: 53
length: 72/80
arm: 61
shoulders: 42', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-16 15:58:50.439744', NULL, 0.00);
INSERT INTO public.clothing VALUES (219, 'N/A', 'Michael Kors', 'Wallet', 'Green, Black', NULL, '3225', 2.99, NULL, NULL, NULL, 'Ross label covering tag', NULL, 'women', NULL, NULL, NULL, 'Ukraine', '2020-12-21 01:07:55.574225', NULL, 0.00);
INSERT INTO public.clothing VALUES (3520, 'M', 'Armani Exchange', 'Puffy Jacket', 'Black', 287, '4991903', 49.99, NULL, NULL, NULL, 'ПОГ 64
рук 66
плечи 52
дл 85
', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-04-02 23:06:12.907627', NULL, 0.00);
INSERT INTO public.clothing VALUES (3446, 'L', 'Armani Exchange', 'Polo Shirt', 'White', 283, '4139350', 19.99, NULL, 123, NULL, 'мал АЕ знак на груди полоска по воротнику
ПОГ 54
дл 70
плечи 48
', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-30 21:31:33.82024', NULL, 0.00);
INSERT INTO public.clothing VALUES (3518, '28', 'Armani Exchange', 'Jeans', 'Blue', 287, '0281406', 29.99, 62.50, NULL, 23, 'boyfrends
ПОT 40
ПОБ 48-49
пос 28
дл 92
', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-02 23:02:32.504612', NULL, NULL);
INSERT INTO public.clothing VALUES (192, 'M', 'Guess', 'Puffy Jacket', 'Black', NULL, '558685', 39.99, NULL, NULL, NULL, 'Vertical squares on front
Horizontal squares on ribs/sides

Chest: 48
Waist: 43
Length: 61
Arm: 65', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:55.348231', NULL, NULL);
INSERT INTO public.clothing VALUES (194, 'XS', 'Michael Kors', 'Puffy Jacket', 'Grey', 19, '147381', 41.99, 58.58, NULL, 1, 'Silver buttons + zipper

Chest: 49
Waist: 44
Length: 89
Arm: 59', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:55.363039', NULL, NULL);
INSERT INTO public.clothing VALUES (196, 'N/A', 'Calvin Klein', 'Man Purse', 'Black', NULL, '811290', 17.69, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:55.38033', NULL, NULL);
INSERT INTO public.clothing VALUES (203, '1SZ', 'Calvin Klein', 'Hat', 'Pink', NULL, '476298', 9.99, NULL, NULL, NULL, 'Winter hat with fluffy ball on top', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:55.448475', NULL, NULL);
INSERT INTO public.clothing VALUES (2515, '7.5', 'Calvin Klein', 'Shoes', 'Cream', NULL, 'Allashoes2', 29.99, 40.49, 82, 9, 'high heels', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-12 02:50:05.067471', NULL, 0.00);
INSERT INTO public.clothing VALUES (3447, 'L', 'Tommy Hilfiger', 'T-Shirt', 'Navy', NULL, '816834', 2.99, NULL, 119, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-30 23:10:46.099264', NULL, NULL);
INSERT INTO public.clothing VALUES (190, 'M', 'Levis', 'Jean Jacket', 'White', NULL, '311068', 20.00, NULL, 119, NULL, 'Buttons

Chest: 52
Waist: 50
Length: 59
Arm: 59', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:55.333864', NULL, NULL);
INSERT INTO public.clothing VALUES (191, 'M', 'Guess', 'Jean Jacket', 'Blue', NULL, '980756', 39.00, NULL, 121, NULL, 'Buttons
White/blue/black "guess" line down arms

Chest: 54
Waist: 52
Length: 65
Arm: 66', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:55.341199', NULL, NULL);
INSERT INTO public.clothing VALUES (3678, 'XS', 'Tommy Hilfiger', 'Windbreaker', 'White', NULL, '866443', 29.99, NULL, 123, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-08 06:34:11.886174', NULL, NULL);
INSERT INTO public.clothing VALUES (3605, '8', 'Armani Exchange', 'Blazer', 'Black', 293, '4365759', 39.99, NULL, 124, NULL, 'с полоской с боку
ПОГ 52
дл 78
рук 63
плечи 43', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-04 06:15:27.075986', NULL, 0.00);
INSERT INTO public.clothing VALUES (204, 'L', 'Calvin Klein', 'Sweat Pants', 'Black', NULL, '957101', 19.99, NULL, NULL, NULL, '"calvin klein" down side

Waist: 43
Hips: 54
Length: 97
Pasadka: 27', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:55.456473', NULL, NULL);
INSERT INTO public.clothing VALUES (183, 'L', 'Levis', 'Jean Jacket', 'Navy', NULL, '061467', 23.99, NULL, NULL, NULL, 'Men
buttons

Chest: 58
Waist: 57
Length: 68
Arm: 66
Shoulder: 47', NULL, 'men', NULL, NULL, NULL, NULL, '2020-12-21 01:07:55.27946', NULL, NULL);
INSERT INTO public.clothing VALUES (184, 'M', 'Levis', 'Jean Jacket', 'Navy', NULL, '061450', 23.99, NULL, NULL, NULL, 'Men
buttons

Chest: 54
Waist: 52
Length: 63
Arm: 62
Shoulder: 43', NULL, 'men', NULL, NULL, NULL, NULL, '2020-12-21 01:07:55.287309', NULL, NULL);
INSERT INTO public.clothing VALUES (211, '1SZ', 'Michael Kors', 'Scarf', 'Black, Silver', NULL, '329234', 22.99, NULL, NULL, NULL, 'Hat & Scarf in gold box', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:55.5124', NULL, NULL);
INSERT INTO public.clothing VALUES (212, '1SZ', 'Levis', 'Scarf', 'Navy', NULL, '204508', 11.99, NULL, NULL, NULL, 'Hat & Scarf on hanger
Grey + red stripe', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:55.5206', NULL, NULL);
INSERT INTO public.clothing VALUES (213, '1SZ', 'Levis', 'Scarf', 'Grey, Red, Navy', NULL, '204522', 10.99, NULL, NULL, NULL, 'Hat & Scarf on hanger', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:55.5274', NULL, NULL);
INSERT INTO public.clothing VALUES (215, '1SZ', 'Calvin Klein', 'Scarf', 'Grey, Black', NULL, '391171', 9.99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:55.543174', NULL, NULL);
INSERT INTO public.clothing VALUES (216, '1SZ', 'Levis', 'Hat', 'Navy', NULL, '204256', 7.99, NULL, NULL, NULL, 'Beanie Hat', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:55.550367', NULL, NULL);
INSERT INTO public.clothing VALUES (217, 'N/A', 'Tommy Hilfiger', 'Wallet', 'Black', NULL, '8486', 12.99, NULL, NULL, NULL, 'Ross label covering tag', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:55.559285', NULL, NULL);
INSERT INTO public.clothing VALUES (218, 'N/A', 'Tommy Hilfiger', 'Wallet', 'Black', NULL, '8486', 12.99, NULL, NULL, NULL, 'Ross label covering tag', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:55.566758', NULL, NULL);
INSERT INTO public.clothing VALUES (186, 'M', 'Calvin Klein', 'Puffy Jacket', 'Black', NULL, '784867', 69.99, NULL, NULL, NULL, 'Men

Chest: 61
Waist: 60
Length: 71
Arm: 68
Shoulder: 46', NULL, 'men', NULL, NULL, NULL, NULL, '2020-12-21 01:07:55.303683', NULL, NULL);
INSERT INTO public.clothing VALUES (223, '1SZ', 'Calvin Klein', 'Scarf', 'Tan', NULL, '470401', 12.99, 17.54, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:55.605932', NULL, NULL);
INSERT INTO public.clothing VALUES (224, '1SZ', 'Calvin Klein', 'Scarf', 'White, Black', NULL, '449612', 14.99, 20.24, NULL, 1, 'Furry
White ends', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:55.61407', NULL, NULL);
INSERT INTO public.clothing VALUES (228, 'S', 'DKNY', 'Sweater', 'Red', NULL, '313899', 19.99, NULL, NULL, NULL, 'Velvety
3d DKNY

Chest: 60
Waist: 56
Length: 57
Arm: 49', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:55.658724', NULL, NULL);
INSERT INTO public.clothing VALUES (229, 'M', 'DKNY', 'Sweater', 'Red', NULL, '313882', 19.99, NULL, NULL, NULL, 'Velvety
3d DKNY

Chest: 63
Waist: 60
Length: 59
Arm: 49', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:55.667036', NULL, NULL);
INSERT INTO public.clothing VALUES (230, 'S', 'Tommy Hilfiger', 'Sweater', 'Blue', 20, '203869', 8.92, NULL, NULL, NULL, 'Knitted

Chest: 58
Waist: 52
Length: 51
Arm: 43', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:55.674348', NULL, NULL);
INSERT INTO public.clothing VALUES (2021, 'M', 'Calvin Klein', 'Skirt', 'Black', 155, '659324', 10.39, NULL, 62, NULL, 'waist: 38
hips: 51
length: 79', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 12:17:35.474544', NULL, 0.00);
INSERT INTO public.clothing VALUES (2226, 'L', 'Michael Kors', 'Polo', 'Navy', NULL, '833878', 19.99, 42.86, 74, 22, 'chest: 56
length: 74
', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-01-21 17:58:36.125285', NULL, 0.00);
INSERT INTO public.clothing VALUES (3210, 'M', 'Tommy Hilfiger', 'Hoodie', 'Black', 271, '825945', 17.99, NULL, NULL, NULL, 'flag on chest
chest: 50
length: 65
arm: 73', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-21 00:20:54.361483', NULL, NULL);
INSERT INTO public.clothing VALUES (1992, 'S', 'Calvin Klein', 'Belt', 'Brown', 154, '268656', 3.51, 28.57, 57, 22, 'Logo belt
length: 95', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 11:48:15.659857', NULL, 0.00);
INSERT INTO public.clothing VALUES (1479, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 136, '332743', 7.99, NULL, 119, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:14.263758', NULL, NULL);
INSERT INTO public.clothing VALUES (3281, '10', 'Calvin Klein', 'Shoes', 'Navy', 277, '51310000129914', 12.99, NULL, 120, NULL, NULL, NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-23 01:12:49.177243', NULL, NULL);
INSERT INTO public.clothing VALUES (3522, 'M', 'Armani Exchange', 'Vest Jacket', 'Red', 287, '0477748', 28.50, NULL, NULL, NULL, 'красная пуховая жилетка
ПОГ 51
дл  60', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-04-02 23:10:34.823608', NULL, NULL);
INSERT INTO public.clothing VALUES (3606, '4', 'Armani Exchange', 'Blazer', 'Black', 293, '4365735', 39.99, NULL, NULL, NULL, 'с полоской с боку
ПОГ 49
дл 72
плечи 40
рукав 62', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-04 06:18:36.48139', NULL, 0.00);
INSERT INTO public.clothing VALUES (3679, 'L', 'Tommy Hilfiger', 'Windbreaker', 'Red', NULL, '866542', 29.99, NULL, 123, NULL, 'costco jacket', NULL, 'women', NULL, NULL, NULL, NULL, '2021-04-08 06:35:01.288989', NULL, NULL);
INSERT INTO public.clothing VALUES (3363, 'S', 'Armani Exchange', 'T-Shirt', 'White', 283, '0290125', 15.99, NULL, 127, NULL, 'с фиолетовыми буквами с боку
ПОГ 41
дл 62', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-27 05:09:10.8063', NULL, NULL);
INSERT INTO public.clothing VALUES (232, 'S', 'Tommy Hilfiger', 'Sweater', 'Grey', 20, '203654', 8.92, NULL, NULL, NULL, 'Knitted

Chest: 58
Waist: 52
Length: 51
Arm: 43', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:55.690789', NULL, NULL);
INSERT INTO public.clothing VALUES (197, 'N/A', 'Calvin Klein', 'Purse', 'Grey', NULL, '817177', 24.10, NULL, NULL, NULL, 'trippy 3d like "ck" pattern', NULL, 'women', NULL, NULL, NULL, 'Ukraine', '2020-12-21 01:07:55.388059', NULL, 0.00);
INSERT INTO public.clothing VALUES (446, '1SZ', 'Michael Kors', 'Hat', 'Grey', NULL, '340338', 16.99, 22.94, 12, 9, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.572043', NULL, NULL);
INSERT INTO public.clothing VALUES (1125, '???', 'Calvin Klein', 'unknown', 'Unknown', 92, '529772', 28.56, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.958301', NULL, NULL);
INSERT INTO public.clothing VALUES (346, 'L', 'Calvin Klein', 'Belt', 'Black', 29, '192364', 7.99, 10.80, 13, 9, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.691206', NULL, NULL);
INSERT INTO public.clothing VALUES (202, 'N/A', 'Michael Kors', 'Wallet', 'Black', NULL, '445057', 19.99, 26.99, 13, 9, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:55.440121', NULL, NULL);
INSERT INTO public.clothing VALUES (208, 'N/A', 'Michael Kors', 'Wallet', 'Black, Grey', NULL, '445057', 19.99, 26.99, 13, 9, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:55.488815', NULL, NULL);
INSERT INTO public.clothing VALUES (382, 'L', 'Calvin Klein', 'Belt', 'Black', 29, '192166', 7.99, 10.80, 13, 9, 'double sided
on receipt as 192364', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.010451', NULL, NULL);
INSERT INTO public.clothing VALUES (1126, '???', 'Calvin Klein', 'unknown', 'Unknown', 92, '705459', 28.56, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.968008', NULL, NULL);
INSERT INTO public.clothing VALUES (235, 'N/A', 'Calvin Klein', 'Purse', 'Grey', 21, '032488', 18.18, NULL, NULL, NULL, '"ck" pattern everywhere', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:55.722522', NULL, NULL);
INSERT INTO public.clothing VALUES (2382, 'M', 'Calvin Klein', 'Sweat Shirt', 'Pink', NULL, '954810', 24.99, 53.57, 75, 19, 'long neck
veleur sign', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-02 23:07:20.400412', NULL, 7.29);
INSERT INTO public.clothing VALUES (72, 'S', 'Calvin Klein', 'Puffy Jacket', 'White', 9, '100568', 47.05, 100.00, 19, 19, 'Hooded

Chest: 50
Waist: 44
Length: 56
Arm: 63', true, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.269091', NULL, 5.20);
INSERT INTO public.clothing VALUES (2442, 'XL', 'Tommy Hilfiger', 'Sweater', 'White', 198, '596442', 15.29, 44.64, 77, 22, 'zipper on neck

chest: 59
length: 75
arm: 73', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-02-07 23:44:43.142292', NULL, 0.00);
INSERT INTO public.clothing VALUES (2475, 'XS', 'Karl Lagerfeld', 'Sweat Shirt', 'Blue', 201, 'LORHS045', 24.99, 60.71, 77, 22, 'gold 3d circle

chest: 47
length: 60
arm: 57', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-08 00:37:30.443449', NULL, 0.00);
INSERT INTO public.clothing VALUES (3211, 'S', 'Michael Kors', 'T-Shirt', 'White', 271, '491209', 14.99, NULL, 114, NULL, 'line of KORS across chest
chest: 50
length: 60', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-21 00:22:41.802183', NULL, NULL);
INSERT INTO public.clothing VALUES (3282, 'S', 'Calvin Klein', 'Dress', 'Pink', 278, '402571', 19.99, NULL, 115, NULL, 'black stripe on shoulder
chest: 45
hips: 49
length: 90', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-23 01:14:33.627575', NULL, NULL);
INSERT INTO public.clothing VALUES (2459, 'XS', 'Tommy Hilfiger', 'Bodysuit', 'Navy', 201, '808160', 16.99, 39.29, 88, 22, 'Tommy Jeans on chest
chest: 40
length: 67
arm: 58', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-08 00:12:40.214428', NULL, 0.00);
INSERT INTO public.clothing VALUES (3364, 'XL', 'Armani Exchange', 'Dress Shirt', 'White', 283, '4138841', 19.99, NULL, 118, NULL, 'Armani Exchange на воротнике', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-27 05:10:39.544202', NULL, NULL);
INSERT INTO public.clothing VALUES (3448, 'M', 'Calvin Klein', 'T-Shirt', 'Black', NULL, '596783', 14.99, NULL, NULL, NULL, 'big CK on chest', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-30 23:12:54.892143', NULL, NULL);
INSERT INTO public.clothing VALUES (3607, '10', 'Armani Exchange', 'Blazer', 'Black', 293, '4365698', 39.99, NULL, NULL, NULL, 'Stripe on side
chest: 54
length: 78
shoulders: 43
arm: 62', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-04 06:40:06.8705', NULL, NULL);
INSERT INTO public.clothing VALUES (3680, 'M', 'Tommy Hilfiger', 'Windbreaker', 'White, Navy', NULL, '866603', 29.99, NULL, 123, NULL, 'from costco', NULL, 'women', NULL, NULL, NULL, NULL, '2021-04-08 06:35:42.327752', NULL, NULL);
INSERT INTO public.clothing VALUES (3523, 'M', 'Armani Exchange', 'Sweater', 'Navy', 287, '4348737', 19.99, NULL, 127, NULL, '83% шерсть не колется
ПОГ 53
дл 66
рук  64', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-04-02 23:14:55.123261', NULL, NULL);
INSERT INTO public.clothing VALUES (2460, 'S', 'Calvin Klein', 'T-Shirt', 'White', 201, '412693', 12.99, NULL, 85, NULL, 'Black + silver logo on chest
chest: 42
length: 64
', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-08 00:14:56.154197', NULL, 0.00);
INSERT INTO public.clothing VALUES (2464, 'XS', 'Calvin Klein', 'Sweat Pants', 'Cream', 201, '474400', 19.99, NULL, 81, NULL, 'white Calvin klein jeans on side

waist: 36
Hips: 46
Length: 94
Pasadka: 24
', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-08 00:21:32.960544', NULL, 0.00);
INSERT INTO public.clothing VALUES (2461, 'XS', 'Calvin Klein', 'T-Shirt', 'Black', 201, '412907', 12.99, NULL, 85, NULL, 'White + silver logo on chest
chest: 44
length: 61
', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-08 00:16:42.688082', NULL, 0.00);
INSERT INTO public.clothing VALUES (2456, 'M', 'Calvin Klein', 'Dress', 'Blue', 201, '404322', 24.99, NULL, 84, NULL, 'chest: 53
length: 85
arm: 64', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-08 00:07:39.551204', NULL, 0.00);
INSERT INTO public.clothing VALUES (2010, 'S', 'Calvin Klein', 'Sweat Shirt', 'Black', 154, '796465', 14.05, NULL, 84, NULL, '"calvin" on shoulder
chest: 58
length: 60/70
arm: 43/66', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 12:06:07.35519', NULL, 0.00);
INSERT INTO public.clothing VALUES (345, 'L', 'Calvin Klein', 'Belt', 'Black', 29, '192364', 7.99, NULL, 76, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.682306', NULL, 0.00);
INSERT INTO public.clothing VALUES (2502, 'S', 'Levis', 'Puffy Jacket', 'Orange', 203, '660661', 41.99, 83.93, 81, 22, 'chest: 57
length: 56
arm: 56/70', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-11 23:34:07.081908', NULL, 0.00);
INSERT INTO public.clothing VALUES (3212, '32', 'DKNY', 'Pants', 'Navy', 271, '963371', 14.99, NULL, 109, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-21 00:23:19.888615', NULL, NULL);
INSERT INTO public.clothing VALUES (3365, 'L', 'Armani Exchange', 'Dress Shirt', 'White', 283, '4138810', 19.99, NULL, 118, NULL, 'Armani Exchange на воротнике', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-27 05:11:08.473498', NULL, NULL);
INSERT INTO public.clothing VALUES (1476, '10', 'Tommy Hilfiger', 'Pants', 'White', 136, '332873', 7.99, NULL, 119, NULL, 'linen pants', NULL, 'women', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:14.236803', NULL, 0.00);
INSERT INTO public.clothing VALUES (3524, 'XL', 'Armani Exchange', 'Sweater', 'Navy', 287, '4348751', 19.99, NULL, NULL, NULL, '83% шерсть не колется
ПОГ 58
дл 69
рук  66', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-04-02 23:19:44.537495', NULL, NULL);
INSERT INTO public.clothing VALUES (3608, '6', 'Armani Exchange', 'Blazer', 'Black', 293, '4365742', 39.99, NULL, NULL, NULL, 'с полоской с боку
ПОГ 50
дл 72
плечи 40
рукав 62', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-04 06:40:44.112803', NULL, 0.00);
INSERT INTO public.clothing VALUES (3681, 'M', 'Tommy Hilfiger', 'Windbreaker', 'Red', NULL, '866559', 29.99, NULL, 123, NULL, 'costco', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-08 06:37:06.014121', NULL, NULL);
INSERT INTO public.clothing VALUES (242, 'XS', 'Calvin Klein', 'Yoga Pants', 'Black', 21, '974009', 12.09, NULL, NULL, NULL, 'Yellow stripes down side

Waist: 29
Hips: 36
Length: 86
Pasadka: 21', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:55.785754', NULL, NULL);
INSERT INTO public.clothing VALUES (2123, 'L', 'Tommy Hilfiger', 'Polo Shirt', 'Blue', 164, '756440', 10.39, NULL, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-01-16 18:47:00.25887', NULL, NULL);
INSERT INTO public.clothing VALUES (249, 'XS', 'Calvin Klein', 'Puffy Jacket', 'Black', 22, '248634', 59.95, NULL, NULL, NULL, 'Giant zipper
zipper not in center

Chest: 48
Waist: 42
Length: 65
Arm: 61', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:55.839294', NULL, NULL);
INSERT INTO public.clothing VALUES (251, 'XL', 'Calvin Klein', 'Sweater', 'Green', NULL, '063801', 29.99, NULL, NULL, NULL, 'Lime green "calvin klein jeans" across chest

Chest: 70
Waist: 60
Length: 66
Arm: 75', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:55.856288', NULL, NULL);
INSERT INTO public.clothing VALUES (18, 'M', 'Calvin Klein', 'Sport Jacket', 'Black, White', 3, '252569', 24.99, NULL, NULL, NULL, 'Men
White stripe across chest

Chest: 53
Waist: 50
Length: 68
Arm: 64', true, 'men', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:53.788356', NULL, NULL);
INSERT INTO public.clothing VALUES (2432, 'S', 'Calvin Klein', 'T-Shirt', 'Black', 197, '803651', 11.08, 28.57, 76, 23, 'payetki sign on chest

chest: 43
length: 64', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-07 23:31:16.857742', NULL, 0.00);
INSERT INTO public.clothing VALUES (787, 'N/A', 'Calvin Klein', 'Wallet', 'Black', 53, '941810', 9.64, 35.00, NULL, 23, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:08:00.535782', NULL, NULL);
INSERT INTO public.clothing VALUES (255, 'M', 'Calvin Klein', 'Sweat Shirt', 'Black', NULL, '641400', 24.99, NULL, NULL, NULL, 'Grey CK on chest

Chest: 55
Waist: 53
Length: 69
Arm: 67', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:55.886578', NULL, NULL);
INSERT INTO public.clothing VALUES (257, 'L', 'Calvin Klein', 'Hoodie', 'Navy', NULL, '455175', 29.99, NULL, NULL, NULL, 'Grey CK
White calvin klein jeans
on chest

Chest: 59
Waist: 58
Length: 72
Arm: 68', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:55.902287', NULL, NULL);
INSERT INTO public.clothing VALUES (258, 'XL', 'Calvin Klein', 'Hoodie', 'Navy', NULL, '986358', 29.99, NULL, NULL, NULL, 'Zipper
CK on boob
Bold line + calvin klein down arm

Chest: 60
Waist: 60
Length: 69
Arm: 65', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:55.909977', NULL, NULL);
INSERT INTO public.clothing VALUES (2513, '6', 'Michael Kors', 'Shoes', 'Pink', NULL, '724129', 29.93, NULL, 81, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-12 02:02:09.609291', NULL, NULL);
INSERT INTO public.clothing VALUES (3366, 'M', 'Armani Exchange', 'Dress Shirt', 'White', 283, '4138827', 19.99, NULL, 127, NULL, 'Armani Exchange на воротнике
ПОГ 52
ПОТ 48
дл 77
рук 66
плечи 49', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-27 05:13:36.543597', NULL, NULL);
INSERT INTO public.clothing VALUES (3213, 'S', 'Calvin Klein', 'Jean Jacket', 'White', 271, '491292', 24.99, NULL, 115, NULL, 'cropped
chest: 45
length: 42
arm: 57
shoulders: 41', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-21 00:24:06.188857', NULL, NULL);
INSERT INTO public.clothing VALUES (3284, 'M', 'Calvin Klein', 'Sweat Pants', 'Black', 278, '503841', 19.99, NULL, 115, NULL, 'lowercase calvin klein on side with white dot

waist: 40
hips: 51
pasadka: 27
length: 94', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-23 01:15:41.664831', NULL, 0.00);
INSERT INTO public.clothing VALUES (2589, 'M', 'Calvin Klein', 'Windbreaker', 'Black', 211, '427543', 49.99, 85.71, 88, 22, 'stripe "calvin" on sleeve

chest: 58
length: 70
arm: 67
shoulders: 50', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-02-18 02:56:54.577106', NULL, 0.00);
INSERT INTO public.clothing VALUES (2606, 'XS', 'Tommy Hilfiger', 'Sweat Pants', 'Grey', 214, '006608', 35.99, 57.14, 88, 22, 'waist: 36
hips: 50
pasadka: 24
length: 96', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-22 06:46:50.353279', NULL, 0.00);
INSERT INTO public.clothing VALUES (2605, 'XS', 'Tommy Hilfiger', 'Hoodie', 'Grey', 214, '432313', 31.49, 53.57, 88, 22, 'chest: 48
length: 53
arm: 61', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-22 06:45:29.165505', NULL, 0.00);
INSERT INTO public.clothing VALUES (2611, 'XS', 'Tommy Hilfiger', 'Sweat Pants', 'Navy', 214, '006110', 35.99, 57.14, 100, 22, 'waist: 36
hips: 50
pasadka: 24
length: 96', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-22 06:58:16.707333', NULL, 7.25);
INSERT INTO public.clothing VALUES (2612, 'XS', 'Tommy Hilfiger', 'Hoodie', 'Navy', 214, '432108', 31.49, 53.57, 93, 22, 'chest: 46
length: 52
arm: 61', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-22 06:59:03.625276', NULL, 4.24);
INSERT INTO public.clothing VALUES (2607, 'S', 'Tommy Hilfiger', 'Sweat Pants', 'Navy', 214, '006127', 36.04, 57.14, 87, 22, 'waist: 38
hips: 53
pasadka: 25
length: 95', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-22 06:51:51.043623', NULL, 0.00);
INSERT INTO public.clothing VALUES (2609, 'XS', 'Tommy Hilfiger', 'Sweat Pants', 'Navy', 214, '006110', 35.99, 57.14, 93, 22, 'waist: 36
hips: 50
pasadka: 24
length: 96', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-22 06:55:27.059687', NULL, 0.00);
INSERT INTO public.clothing VALUES (2608, 'XS', 'Tommy Hilfiger', 'Hoodie', 'Navy', 214, '432108', 31.49, 53.57, 100, 22, 'chest: 46
length: 52
arm: 61', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-22 06:54:40.941698', NULL, 0.00);
INSERT INTO public.clothing VALUES (3449, 'M', 'Tommy Hilfiger', 'T-Shirt', 'Red', NULL, '513399', 2.99, NULL, 119, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-30 23:19:01.636934', NULL, NULL);
INSERT INTO public.clothing VALUES (2571, 'L', 'Calvin Klein', 'Sweat Pants', 'Chalk, White', 210, '445547', 19.99, 50.00, 93, 22, 'black gloss calvin klein on side
waist: 42
hips: 57
pasadka: 29
length: 97', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-15 04:52:35.749438', NULL, 0.00);
INSERT INTO public.clothing VALUES (3525, 'M', 'Armani Exchange', 'Hoodie', 'Navy', 287, '4147492', 39.99, NULL, NULL, NULL, NULL, NULL, 'men', NULL, NULL, NULL, 'usa', '2021-04-02 23:36:28.644411', NULL, NULL);
INSERT INTO public.clothing VALUES (3682, 'XS', 'Tommy Hilfiger', 'Windbreaker', 'Red', NULL, '866450', 29.99, NULL, 123, NULL, 'costco', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-08 06:37:37.948747', NULL, NULL);
INSERT INTO public.clothing VALUES (2579, 'M', 'Calvin Klein', 'Hoodie', 'Black', NULL, '845433', 14.99, NULL, 84, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-18 00:55:09.48937', NULL, 0.00);
INSERT INTO public.clothing VALUES (2580, '6.5', 'Michael Kors', 'Shoes', 'Red, Gold', NULL, '??????', 0.00, NULL, 84, NULL, 'high heels', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-18 01:00:03.38128', NULL, NULL);
INSERT INTO public.clothing VALUES (3609, '0', 'Armani Exchange', 'Blazer', 'Black', 293, '4365681', 39.99, 100.00, NULL, 23, 'с полоской с боку
ПОГ 46
дл 69
плечи 38
рукав 60', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-04 06:41:00.172465', NULL, 0.00);
INSERT INTO public.clothing VALUES (2581, 'N/A', 'Tommy Hilfiger', 'Hat', 'White', NULL, '521548', 10.60, NULL, 84, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-18 01:04:10.172445', NULL, 0.00);
INSERT INTO public.clothing VALUES (2582, '1SZ', 'Calvin Klein', 'Hat', 'Black', NULL, '618676', 14.67, NULL, 84, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-18 01:05:05.051137', NULL, 0.00);
INSERT INTO public.clothing VALUES (2583, 'Unknown', 'Unknown', 'Unknown', 'Unknown', NULL, '687442', 0.00, NULL, 84, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-18 01:06:28.241932', NULL, NULL);
INSERT INTO public.clothing VALUES (2601, 'L', 'Calvin Klein', 'Sweat Shirt', 'Black', NULL, '??????', 24.99, NULL, 85, NULL, 'pink letters on chest', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-22 06:16:00.149769', NULL, NULL);
INSERT INTO public.clothing VALUES (2602, 'L', 'Calvin Klein', 'Sweat Pants', 'Black', NULL, '??????', 34.99, NULL, 85, NULL, 'pink letters on leg', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-22 06:16:20.080701', NULL, NULL);
INSERT INTO public.clothing VALUES (2556, 'XL', 'Calvin Klein', 'Dress', 'Black', 207, '402588', 19.99, NULL, 85, NULL, 'calvin klein stripe on shoulder
chest: 55
length: 97
', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-15 04:35:25.411808', NULL, 0.00);
INSERT INTO public.clothing VALUES (2616, 'XS', 'Tommy Hilfiger', 'T-Shirt', 'White', 214, '476355', 7.87, NULL, 102, NULL, 'New york bridge on chest
chest: 46
length: 60', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-22 07:03:00.295728', NULL, 0.00);
INSERT INTO public.clothing VALUES (2613, 'S', 'Tommy Hilfiger', 'Hoodie', 'Navy', 214, '432115', 31.49, NULL, 102, NULL, 'chest: 49
length: 53
arm: 63', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-22 07:01:11.760767', NULL, 0.00);
INSERT INTO public.clothing VALUES (2664, 'L', 'Armani Exchange', 'Puffy Jacket', 'Green', 217, '337066', 87.00, NULL, 88, NULL, 'chest: 63
length: 67
arm: 63', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-23 20:59:47.383709', NULL, 0.00);
INSERT INTO public.clothing VALUES (2669, 'M', 'Tommy Hilfiger', 'Sweat Pants', 'Navy', 218, '006134', 35.99, 57.14, 87, 22, 'waist: 41
hips: 56
pasadka: 26
length: 96', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-25 23:45:37.251803', NULL, 0.00);
INSERT INTO public.clothing VALUES (3683, 'S', 'Tommy Hilfiger', 'Windbreaker', 'Navy, White', NULL, '866610', 29.99, NULL, 123, NULL, 'from costco', NULL, 'women', NULL, NULL, NULL, NULL, '2021-04-08 06:38:20.363797', NULL, NULL);
INSERT INTO public.clothing VALUES (2677, 'M', 'Tommy Hilfiger', 'Hoodie', 'Navy', 219, '432122', 31.49, 53.57, 87, 22, 'chest: 51
length: 55
arm: 63', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-25 23:50:42.905015', NULL, 0.00);
INSERT INTO public.clothing VALUES (3214, 'L', 'Michael Kors', 'T-Shirt', 'White', 271, '491230', 14.99, NULL, 109, NULL, 'many KORS across chest', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-21 00:24:50.769426', NULL, NULL);
INSERT INTO public.clothing VALUES (2666, 'L', 'Tommy Hilfiger', 'Sweat Pants', 'Navy', 218, '006141', 35.99, 57.14, 87, 22, 'waist: 45
hips: 58
pasadka: 28
length: 97', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-25 23:42:13.255875', NULL, 5.75);
INSERT INTO public.clothing VALUES (2618, 'XS', 'Tommy Hilfiger', 'T-Shirt', 'White', 214, '466929', 6.47, 26.79, 88, 22, 'rhinestone logo
chest: 41
length: 63', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-22 07:03:53.070325', NULL, 0.00);
INSERT INTO public.clothing VALUES (2667, 'M', 'Tommy Hilfiger', 'Hoodie', 'Navy', 218, '432122', 31.49, 53.57, 87, 22, 'chest: 51
length: 55
arm: 63', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-25 23:43:40.064202', NULL, 5.75);
INSERT INTO public.clothing VALUES (2682, 'S', 'Tommy Hilfiger', 'Windbreaker', 'Navy, Red', NULL, '??????', 25.00, 82.14, 88, 22, '3 in one', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-26 00:15:08.265647', NULL, NULL);
INSERT INTO public.clothing VALUES (2645, 'L', 'Armani Exchange', 'Sweat Pants', 'Blue', 217, '776745', 29.99, 60.71, 88, 22, 'waist: 45
hips: 56
pasadka: 32
length: 108', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-23 20:45:53.192558', NULL, 0.00);
INSERT INTO public.clothing VALUES (2683, 'M', 'Michael Kors', 'Puffy Jacket', 'White', NULL, '??????', 70.00, 140.00, 88, 22, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-26 00:23:41.377821', NULL, NULL);
INSERT INTO public.clothing VALUES (3285, 'M', 'Calvin Klein', 'Dress', 'Black', 278, '403912', 19.99, NULL, 112, NULL, 'laced cleavage', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-23 01:16:34.373151', NULL, NULL);
INSERT INTO public.clothing VALUES (2676, 'XS', 'Tommy Hilfiger', 'Sweat Pants', 'Navy', 219, '006110', 36.04, 57.14, 100, 22, 'waist: 36
hips: 50
pasadka: 24
length: 96', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-25 23:50:27.238862', NULL, 0.00);
INSERT INTO public.clothing VALUES (2681, 'XS', 'Tommy Hilfiger', 'Vest Jacket', 'Navy', NULL, '806999', 24.99, 60.00, 88, 22, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-25 23:58:44.685011', NULL, 5.04);
INSERT INTO public.clothing VALUES (2614, 'S', 'Tommy Hilfiger', 'T-Shirt', 'White', 214, '476362', 7.87, 26.79, 88, 22, 'New york bridge on chest
chest: 48
length: 61', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-22 07:02:10.738388', NULL, 0.00);
INSERT INTO public.clothing VALUES (2665, 'S', 'Tommy Hilfiger', 'Hoodie', 'Navy', 218, '432115', 31.49, 53.57, 87, 22, 'chest: 49
length: 53
arm: 63', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-25 23:40:25.835231', NULL, 0.00);
INSERT INTO public.clothing VALUES (1418, '4', 'Calvin Klein', 'Shorts', 'Blue', 129, '928721', 2.01, NULL, NULL, NULL, 'light blue linen', NULL, 'women', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:13.711102', NULL, 0.00);
INSERT INTO public.clothing VALUES (3526, 'M', 'Armani Exchange', 'Hoodie', 'Navy', 287, '4147492', 39.99, NULL, NULL, NULL, NULL, NULL, 'men', NULL, NULL, NULL, 'usa', '2021-04-02 23:36:36.148957', NULL, NULL);
INSERT INTO public.clothing VALUES (3610, '2', 'Armani Exchange', 'Blazer', 'Black', 293, '4365728', 39.99, NULL, NULL, NULL, 'с полоской с боку
ПОГ 47
дл 71
плечи 40
рукав 61', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-04 06:41:21.625', NULL, 0.00);
INSERT INTO public.clothing VALUES (2631, 'N/A', 'Tommy Hilfiger', 'Wallet', 'Black', 215, '239293', 14.99, NULL, 93, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-22 07:34:48.01343', NULL, 0.00);
INSERT INTO public.clothing VALUES (2659, '2', 'Armani Exchange', 'Skirt', 'Black, Purple, Seawave', 217, '329900', 19.99, NULL, 102, NULL, 'waist: 31
hips: 47
length: 80', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-23 20:57:11.232812', NULL, 0.00);
INSERT INTO public.clothing VALUES (2679, 'XS', 'Tommy Hilfiger', 'Sweat Shirt', 'White', 219, '013514', 31.49, NULL, 87, NULL, 'circle white logo
chest: 46
length: 60
arm: 58
', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-25 23:51:59.740061', NULL, 0.00);
INSERT INTO public.clothing VALUES (2680, 'S', 'Tommy Hilfiger', 'Blazer', 'Navy', NULL, '438044', 20.00, NULL, 87, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-25 23:57:39.468656', NULL, NULL);
INSERT INTO public.clothing VALUES (3527, 'XL', 'Armani Exchange', 'Sweat Pants', 'Blue', 287, '7968713', 39.99, NULL, NULL, NULL, NULL, NULL, 'men', NULL, NULL, NULL, 'usa', '2021-04-02 23:38:34.041572', NULL, NULL);
INSERT INTO public.clothing VALUES (2678, 'XS', 'Tommy Hilfiger', 'Hoodie', 'Navy', 219, '432108', 31.49, 53.57, 100, 22, 'chest: 46
length: 52
arm: 61', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-25 23:50:59.00407', NULL, 0.00);
INSERT INTO public.clothing VALUES (2737, 'L', 'Tommy Hilfiger', 'Sweat Pants', 'Navy', 225, '006141', 28.79, 57.14, 93, 22, 'waist: 45
hips: 58
pasadka: 28
length: 97', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-01 01:10:52.557037', NULL, 0.00);
INSERT INTO public.clothing VALUES (3611, '2', 'Armani Exchange', 'Blazer', 'Black', 293, '4365728', 39.99, NULL, NULL, NULL, 'с полоской с боку
ПОГ 47
дл 71
плечи 40
рукав 61', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-04 06:41:41.041525', NULL, 0.00);
INSERT INTO public.clothing VALUES (2738, 'L', 'Tommy Hilfiger', 'Hoodie', 'Navy', 225, '432139', 25.19, 53.57, 93, 22, 'chest: 56
length: 58
arm: 64', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-01 01:12:00.433965', NULL, 0.00);
INSERT INTO public.clothing VALUES (2752, 'XS', 'DKNY', 'Puffy Jacket', 'Black', NULL, '391336', 20.00, 101.79, 99, 22, 'from costco

chest: 50
length: 84
arm: 63
shoulders: 41', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-01 05:52:03.748434', NULL, 0.00);
INSERT INTO public.clothing VALUES (3684, 'XS', 'Tommy Hilfiger', 'Windbreaker', 'White, Navy', NULL, '866467', 29.99, NULL, 123, NULL, 'from costco', NULL, 'women', NULL, NULL, NULL, NULL, '2021-04-08 06:39:15.399645', NULL, NULL);
INSERT INTO public.clothing VALUES (2743, 'M', 'Tommy Hilfiger', 'T-Shirt', 'White', 225, '297551', 14.39, 32.14, 93, 22, 'block letters on chest

chest: 46
length: 66', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-01 01:18:19.794334', NULL, 0.00);
INSERT INTO public.clothing VALUES (3286, 'N/A', 'Tommy Hilfiger', 'Backpack', 'Black, White', NULL, '490052', 27.99, NULL, 109, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-23 02:49:10.97174', NULL, NULL);
INSERT INTO public.clothing VALUES (3215, 'M', 'Michael Kors', 'T-Shirt', 'White', 271, '491216', 14.99, NULL, 114, NULL, 'many KORS across chest
chest: 53
length:  72
', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-21 00:25:23.59589', NULL, NULL);
INSERT INTO public.clothing VALUES (2735, 'M', 'Tommy Hilfiger', 'Sweat Pants', 'Grey', 225, '006622', 28.79, 57.14, 95, 22, 'waist: 41
hips: 56
pasadka: 26
length: 96', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-01 01:09:07.565634', NULL, 0.00);
INSERT INTO public.clothing VALUES (2736, 'M', 'Tommy Hilfiger', 'Hoodie', 'Grey', 225, '432337', 25.19, 53.57, 95, 22, 'chest: 51
length: 55
arm: 63', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-01 01:10:28.07417', NULL, 0.00);
INSERT INTO public.clothing VALUES (2670, 'XS', 'Tommy Hilfiger', 'Hoodie', 'Salmon, Pink, Peach', 218, '004239', 28.34, NULL, 102, NULL, 'chest: 46
length: 52
arm: 61', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-25 23:46:54.816982', NULL, 4.57);
INSERT INTO public.clothing VALUES (2640, 'M', 'Guess', 'T-Shirt', 'Black', 216, '539459', 12.99, 28.57, 88, 23, 'gold sign
chest: 51
length: 69', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-02-22 07:49:57.491285', NULL, 0.00);
INSERT INTO public.clothing VALUES (2672, 'XXS', 'Tommy Hilfiger', 'Sweat Pants', 'Navy', 219, '006103', 32.39, NULL, 102, NULL, 'waist: 35
hips: 48
pasadka: 21
length: 93', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-25 23:49:03.585496', NULL, 4.57);
INSERT INTO public.clothing VALUES (2668, 'XS', 'Tommy Hilfiger', 'Sweat Pants', 'Salmon, Pink, Peach', 218, '006530', 32.39, NULL, 102, NULL, 'waist: 36
hips: 50
pasadka: 24
length: 96', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-25 23:44:43.993093', NULL, 4.57);
INSERT INTO public.clothing VALUES (2671, 'XXS', 'Tommy Hilfiger', 'Hoodie', 'Navy', 219, '432092', 28.34, NULL, 102, NULL, 'chest: 43
length: 50
arm: 61', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-25 23:48:16.217441', NULL, 4.57);
INSERT INTO public.clothing VALUES (2805, 'S', 'Calvin Klein', 'Bodic', 'White', NULL, '349951', 14.99, 35.00, 95, 22, 'ch 37
L 71', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-03 21:28:45.120022', NULL, 0.00);
INSERT INTO public.clothing VALUES (2813, '2', 'Karl Lagerfeld', 'Jeans', 'Navy', NULL, 'KLP001', 24.99, 75.00, 96, 22, 'ПОТ 36
ПОБ 40
длина 93
посадка 21', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 01:44:14.8479', NULL, 0.00);
INSERT INTO public.clothing VALUES (3368, 'XL', 'Armani Exchange', 'Sweat Shirt', 'Black', 283, '9192889', 19.99, NULL, 118, NULL, 'верх серый низ чёрный', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-27 05:16:37.457694', NULL, NULL);
INSERT INTO public.clothing VALUES (3450, 'M', 'Levis', 'T-Shirt', 'Black', NULL, '220279', 6.99, NULL, 119, NULL, 'white horses sign sign on chest

chest: 52
length: 70', NULL, NULL, NULL, NULL, NULL, NULL, '2021-03-30 23:22:21.286207', NULL, NULL);
INSERT INTO public.clothing VALUES (2704, 'S', 'Armani Exchange', 'Long Sleeved Shirt', 'Mint', 222, '364653', 29.99, NULL, 102, NULL, 'chest: 62
length: 66
arm: 45/72', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-27 22:27:00.244531', NULL, 0.00);
INSERT INTO public.clothing VALUES (2692, 'XS', 'Michael Kors', 'Puffy Jacket', 'Black', 221, '272908', 70.00, NULL, 102, NULL, 'long

chest: 51
length: 93
arm: 53/74
shoulders: 60
', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-27 22:12:54.501136', NULL, 0.00);
INSERT INTO public.clothing VALUES (2734, 'M', 'Tommy Hilfiger', 'Sweat Pants', 'Navy', 225, '006134', 28.79, NULL, 93, NULL, 'waist: 41
hips: 56
pasadka: 26
length: 96', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-01 01:08:06.038523', NULL, 0.00);
INSERT INTO public.clothing VALUES (2733, 'M', 'Tommy Hilfiger', 'Hoodie', 'Navy', 225, '432122', 25.19, NULL, 93, NULL, 'chest: 51
length: 55
arm: 63', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-01 01:07:37.879567', NULL, 0.00);
INSERT INTO public.clothing VALUES (2749, 'S', 'Tommy Hilfiger', 'T-Shirt', 'Navy', 225, '297476', 14.39, NULL, 93, NULL, 'chest: 44
length: 66', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-01 01:22:34.620362', NULL, 0.00);
INSERT INTO public.clothing VALUES (2884, 'M', 'Tommy Hilfiger', 'Sweat Pants', 'Black', NULL, '774656', 19.99, 50.00, 96, 22, 'large tommy hilfiger on sides

waist: 40
hips: 53
pasadka: 25
length: 92
', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 05:30:59.813139', NULL, 0.00);
INSERT INTO public.clothing VALUES (1792, 'L', 'Levis', 'T-Shirt', 'White', NULL, '022743', 6.99, NULL, 119, NULL, 'Men
red logo on chest
            
chest: 53
length: 70', true, 'men', NULL, NULL, NULL, 'Ukraine', '2020-12-25 07:07:01.506687', NULL, 0.00);
INSERT INTO public.clothing VALUES (3528, 'XL', 'Armani Exchange', 'Sweat Pants', 'Blue', 287, '7968713', 39.99, NULL, NULL, NULL, NULL, NULL, 'men', NULL, NULL, NULL, 'usa', '2021-04-02 23:38:38.038237', NULL, NULL);
INSERT INTO public.clothing VALUES (3612, 'S', 'Armani Exchange', 'Puffy Jacket', 'Black', 293, '0321485', 79.99, NULL, NULL, NULL, 'куртка с поясом
ПОГ 48
ПОБ 53
дл 87
рук 63
плечи  41
', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-04 06:42:36.832976', NULL, 0.00);
INSERT INTO public.clothing VALUES (3216, '4', 'DKNY', 'Dress', 'Green', 271, '122593', 24.99, NULL, 121, NULL, 'interesting fabric pattern
with pockets
chest: 45
waist: 37
length: 94', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-21 00:27:59.332106', NULL, NULL);
INSERT INTO public.clothing VALUES (3482, 'S', 'Armani Exchange', 'Puffy Jacket', 'Blue', 287, '8512037', 39.99, NULL, 125, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-02 21:22:44.303554', NULL, NULL);
INSERT INTO public.clothing VALUES (3369, 'M', 'Armani Exchange', 'Sweat Shirt', 'Green', 283, '7410108', 19.99, NULL, 127, NULL, 'тёмно зелёный
ПОГ 52
дл 66
рук 65', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-27 05:18:36.885793', NULL, NULL);
INSERT INTO public.clothing VALUES (2792, 'L', 'Michael Kors', 'T-Shirt', 'Black', NULL, '056491', 16.99, NULL, 99, NULL, 'Chest 58
L 71', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-03-03 21:04:44.214362', NULL, 0.00);
INSERT INTO public.clothing VALUES (2687, '6', 'Tommy Hilfiger', 'Dress', 'Olive', 220, '198764', 11.24, 64.29, 99, 23, 'chest: 45
waist: 39
length: 100', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-27 21:56:52.630409', NULL, 0.00);
INSERT INTO public.clothing VALUES (2788, 'S', 'Michael Kors', 'Jean Jacket', 'Black', 227, '807683', 34.99, 75.00, 101, 23, 'golden buttons
ripped at bottom
chest: 49
length: 53
arm: 58', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-01 06:24:05.673248', NULL, 0.00);
INSERT INTO public.clothing VALUES (2596, 'XS', 'Tommy Hilfiger', 'T-Shirt', 'White', 212, '463935', 9.99, 26.79, 88, 23, 'golden sign hilfiger

chest: 42
length: 62', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-18 03:03:12.244892', NULL, 0.00);
INSERT INTO public.clothing VALUES (2796, 'M', 'Michael Kors', 'T-Shirt', 'Black', NULL, '056484', 16.99, NULL, 99, NULL, 'Ch 54
L 70', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-03-03 21:08:58.880466', NULL, 0.00);
INSERT INTO public.clothing VALUES (2806, 'S', 'Michael Kors', 'T-Shirt', 'Clack', NULL, '452301', 19.99, NULL, 101, NULL, 'white sign MK
ch 48
L  61', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-03 21:31:32.215161', NULL, 0.00);
INSERT INTO public.clothing VALUES (2812, 'M', 'Michael Kors', 'T-Shirt', 'Grey', NULL, '525973', 9.99, NULL, 101, NULL, 'серая лонж
ПОГ 53
дл 73', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-03-03 21:50:01.303263', NULL, 0.00);
INSERT INTO public.clothing VALUES (2892, '2', 'Michael Kors', 'Jeans', 'Navy', NULL, '443071', 29.99, NULL, 101, NULL, 'easy skinny

waist: 36
hips: 45
pasadka: 21
length: 95', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 05:38:12.540658', NULL, 0.00);
INSERT INTO public.clothing VALUES (2875, 'L', 'Michael Kors', 'T-Shirt', 'Black', NULL, '485475', 14.99, NULL, 101, NULL, 'michael kors inside michael kors on side
chest: 56
length: 73', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 05:22:59.400549', NULL, 0.00);
INSERT INTO public.clothing VALUES (2886, 'S', 'Tommy Hilfiger', 'Sweat Pants', 'Black', NULL, '774663', 19.99, NULL, 102, NULL, 'large tommy hilfiger on sides

waist: 38
hips: 50
pasadka: 24
length: 91', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 05:32:36.030169', NULL, 0.00);
INSERT INTO public.clothing VALUES (2885, 'S', 'Tommy Hilfiger', 'Hoodie', 'Black', NULL, '774786', 24.99, NULL, 102, NULL, 'large tommy hilfiger on sides
oversized

chest: 55
length: 64
arm: 61
', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 05:31:44.338594', NULL, 0.00);
INSERT INTO public.clothing VALUES (2866, 'S', 'Tommy Hilfiger', 'Leggings', 'Black', NULL, '829608', 19.99, NULL, 102, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 05:12:17.482655', NULL, 0.00);
INSERT INTO public.clothing VALUES (2869, 'S', 'Tommy Hilfiger', 'Hoodie', 'Pink', NULL, '774700', 24.99, NULL, 102, NULL, 'oversized
large tommy hilfiger on sides

chest: 53
length: 65
arm: 64', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 05:14:40.039789', NULL, 0.00);
INSERT INTO public.clothing VALUES (2871, 'S', 'Tommy Hilfiger', 'Leggings', 'Navy', NULL, '825006', 19.99, NULL, 102, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 05:17:57.763499', NULL, 0.00);
INSERT INTO public.clothing VALUES (2845, 'S', 'Tommy Hilfiger', 'Hoodie', 'Navy', NULL, '802083', 15.99, NULL, 102, NULL, 'tommy jeans
chest: 53
length: 59
arm: 61', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 04:53:00.062262', NULL, 0.00);
INSERT INTO public.clothing VALUES (2921, 'XS', 'Tommy Hilfiger', 'T-Shirt', 'Pink', NULL, '808528', 12.99, NULL, 102, NULL, 'with a navy/white flag


chest: 44
length: 60
', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 06:04:13.854165', NULL, 0.00);
INSERT INTO public.clothing VALUES (2933, 'M', 'Calvin Klein', 'Sweat Shirt', 'Black', NULL, '473700', 19.99, NULL, 99, NULL, 'white & silver letters

chest: 54
length: 57
arm: 71', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 06:16:21.130302', NULL, 0.00);
INSERT INTO public.clothing VALUES (3217, '7', 'Michael Kors', 'Flip Flops', 'White, Vanilla', 272, '871808', 24.99, NULL, 109, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-21 00:29:42.387055', NULL, NULL);
INSERT INTO public.clothing VALUES (3288, 'M', 'Tommy Hilfiger', 'Windbreaker', 'White, Navy', NULL, '866603', 29.99, NULL, 110, NULL, 'from costco', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-23 19:24:55.662343', NULL, 0.00);
INSERT INTO public.clothing VALUES (3370, 'S', 'Armani Exchange', 'Windbreaker', 'Black', 283, '3933622', 29.99, NULL, NULL, NULL, 'замок на половину
ПОГ 58
ДЛ 78
рук 65
плечи 49', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-27 05:22:04.296051', NULL, NULL);
INSERT INTO public.clothing VALUES (2837, 'M', 'Calvin Klein', 'Rain Coat', 'Pearl', NULL, '360895', 40.00, 71.43, 96, 22, 'ПОГ 54
длина 77
Рукав 72', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 03:01:30.518523', NULL, 0.00);
INSERT INTO public.clothing VALUES (2478, 'XS', 'Karl Lagerfeld', 'Sweat Shirt', 'Blue', 201, 'LORHS082', 24.99, 53.57, 77, 22, 'golden glasses

chest: 47
length: 59
arm: 58', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-08 00:41:11.444202', NULL, 0.00);
INSERT INTO public.clothing VALUES (2939, 'S', 'Tommy Hilfiger', 'Blazer', 'Navy', NULL, '235902', 24.99, 53.57, 95, 22, 'на пуговицах', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-06 20:52:35.933912', NULL, 0.00);
INSERT INTO public.clothing VALUES (1993, 'S', 'Calvin Klein', 'Belt', 'Brown', 154, '268656', 3.51, 28.57, 96, 22, 'Logo belt
length: 95', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 11:48:38.303382', NULL, 0.00);
INSERT INTO public.clothing VALUES (3451, 'L', 'Levis', 'T-Shirt', 'White', NULL, '611186', 9.00, NULL, 119, NULL, 'red sign + san francisco sign', NULL, 'women', NULL, NULL, NULL, NULL, '2021-03-30 23:25:20.868056', NULL, NULL);
INSERT INTO public.clothing VALUES (3529, 'XL', 'Armani Exchange', 'Sweat Pants', 'Blue', 287, '7064569', 39.99, NULL, NULL, NULL, NULL, NULL, 'men', NULL, NULL, NULL, 'usa', '2021-04-02 23:39:04.882716', NULL, NULL);
INSERT INTO public.clothing VALUES (1032, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 82, '441992', 9.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.094304', NULL, NULL);
INSERT INTO public.clothing VALUES (3287, 'M', 'Calvin Klein', 'Leggings', 'Black', NULL, '454921', 19.99, 26.99, 109, 9, 'calvin klein jeans down side', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-23 02:51:26.505371', NULL, NULL);
INSERT INTO public.clothing VALUES (2864, 'L', 'Calvin Klein', 'Dress', 'Black', NULL, '398065', 19.99, 50.00, 99, 23, 'stripe on side

chest: 53
hips: 53
length:  95', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 05:09:47.989856', NULL, 0.00);
INSERT INTO public.clothing VALUES (2712, 'M', 'Calvin Klein', 'T-Shirt', 'Black', 223, '791423', 12.99, 28.57, 95, 23, 'bluish-golden sign on chest
chest: 54
length: 69', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-02-27 22:47:19.429429', NULL, 0.00);
INSERT INTO public.clothing VALUES (3613, 'XL', 'Armani Exchange', 'Puffy Jacket', 'Black', 293, '0321492', 79.99, NULL, NULL, NULL, 'куртка с поясом
ПОГ 57
ПОБ 63
дл 89
рук 65
плечи  47
', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-04 06:43:11.756559', NULL, 0.00);
INSERT INTO public.clothing VALUES (3685, 'S', 'Calvin Klein', 'T-Shirt', 'Black', NULL, '039753', 7.49, NULL, NULL, NULL, 'майка
с мал значком Келвин с низу', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-08 16:33:56.091253', NULL, NULL);
INSERT INTO public.clothing VALUES (2912, 'S', 'Calvin Klein', 'T-Shirt', 'Black', NULL, '791416', 12.99, NULL, 99, NULL, 'greyish/golden letters

chest: 50
length: 71
', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-03-04 05:56:08.506333', NULL, 0.00);
INSERT INTO public.clothing VALUES (2690, 'XXL', 'Tommy Hilfiger', 'T-Shirt', 'Black', 220, '451123', 8.99, NULL, 95, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-27 21:59:16.014732', NULL, 0.00);
INSERT INTO public.clothing VALUES (2689, 'XXL', 'Tommy Hilfiger', 'T-Shirt', 'White', 220, '388887', 8.99, NULL, 95, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-27 21:58:54.899048', NULL, 0.00);
INSERT INTO public.clothing VALUES (2940, 'L', 'Tommy Hilfiger', 'Sweat Pants', 'Grey', NULL, '006639', 32.39, NULL, 96, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-06 21:00:14.516533', NULL, 0.00);
INSERT INTO public.clothing VALUES (2941, 'L', 'Tommy Hilfiger', 'Hoodie', 'Grey', NULL, '432344', 28.34, NULL, 96, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-06 21:00:29.622026', NULL, 0.00);
INSERT INTO public.clothing VALUES (2938, 'S', 'Calvin Klein', 'Dress Shirt', 'White', NULL, 'MOTAK561', 20.00, NULL, 96, NULL, 'с золотой молнией
ПОГ 49
длина 71
рукав 60', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-06 20:51:50.096424', NULL, 0.00);
INSERT INTO public.clothing VALUES (2942, 'M', 'Calvin Klein', 'Bodic', 'White', NULL, '349944', 14.99, NULL, 96, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-06 21:06:32.726487', NULL, 0.00);
INSERT INTO public.clothing VALUES (2917, 'M', 'Tommy Hilfiger', 'Dress', 'Black', NULL, '738108', 19.99, NULL, 96, NULL, 'tommy jeans on chest

chest: 48
hips: 51
length: 86', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 06:00:52.401516', NULL, 0.00);
INSERT INTO public.clothing VALUES (3218, '8', 'Michael Kors', 'Flip Flops', 'Pink', 272, '154748', 24.99, NULL, 109, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-21 00:30:07.02918', NULL, NULL);
INSERT INTO public.clothing VALUES (82, 'N/A', 'Calvin Klein', 'Backpack', 'Orange', 9, '269414', 31.72, 71.07, 72, 22, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.353414', NULL, 0.00);
INSERT INTO public.clothing VALUES (3530, 'L', 'Armani Exchange', 'Sweat Pants', 'Blue', 287, '7776745', 39.99, NULL, NULL, NULL, NULL, NULL, 'men', NULL, NULL, NULL, 'usa', '2021-04-02 23:39:59.459198', NULL, NULL);
INSERT INTO public.clothing VALUES (3289, 'XS', 'Tommy Hilfiger', 'Windbreaker', 'White, Navy', NULL, '866467', 29.99, NULL, NULL, NULL, 'from costco', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-23 19:25:18.155676', NULL, 0.00);
INSERT INTO public.clothing VALUES (3686, 'S', 'Polo', 'Sweater', 'Purple', 299, '953706', 23.99, NULL, NULL, NULL, 'косы
ПОГ 50
дл 62
рук 62', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-08 17:45:11.312114', NULL, NULL);
INSERT INTO public.clothing VALUES (2976, '6', 'Michael Kors', 'Jeans', 'Blue', 230, '443095', 29.99, NULL, 99, NULL, 'с накладными карманами с боку
ПОТ 38
ПОБ 49
дл 98
пос 23', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-07 00:26:47.301055', NULL, 0.00);
INSERT INTO public.clothing VALUES (3003, 'S', 'Calvin Klein', 'Sweat Pants', 'Cream, White', NULL, '??????', 19.99, NULL, 81, NULL, 'black letters on leg', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-09 21:06:42.775605', NULL, NULL);
INSERT INTO public.clothing VALUES (2539, 'XS', 'Michael Kors', 'Puffy Jacket', 'Black', 206, '280262', 70.00, 140.00, 101, 23, 'chest: 50
length: 71
arm: 60', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-15 04:06:40.244292', NULL, 0.00);
INSERT INTO public.clothing VALUES (2844, 'M', 'Tommy Hilfiger', 'Hoodie', 'Navy, White', NULL, '836149', 24.99, 50.00, 99, 23, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 04:51:34.431862', NULL, 0.00);
INSERT INTO public.clothing VALUES (2537, 'XS', 'Michael Kors', 'Puffy Jacket', 'White', 206, '280316', 70.00, 140.00, 101, 23, 'chest: 50
length: 71
arm: 60', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-15 04:04:22.742717', NULL, 0.00);
INSERT INTO public.clothing VALUES (2873, '6', 'Calvin Klein', 'Dress', 'Navy', NULL, '462711', 24.99, NULL, 101, NULL, 'metal golden CK thingy
chest: 46
waist: 37
hips: 47
length: 100', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 05:21:24.37057', NULL, 0.00);
INSERT INTO public.clothing VALUES (3036, 'M', 'Michael Kors', 'Jean Jacket', 'Navy', NULL, '614182', 20.00, NULL, 101, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-11 03:19:56.28787', NULL, NULL);
INSERT INTO public.clothing VALUES (3037, 'S', 'Michael Kors', 'Jean Jacket', 'Blue', NULL, '613994', 20.00, NULL, 101, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-11 03:20:21.061036', NULL, NULL);
INSERT INTO public.clothing VALUES (3038, 'L', 'Calvin Klein', 'T-Shirt', 'Black', NULL, '793359', 12.99, NULL, 101, NULL, 'grey ck

chest: 57
length: 71', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-03-11 03:21:42.616066', NULL, 0.00);
INSERT INTO public.clothing VALUES (353, 'XS', 'Calvin Klein', 'Sweat Shirt', 'Black', 29, '796472', 20.19, NULL, NULL, NULL, 'stripe + "calvin" on shoulder

chest: 53
length: 58-67
arm: 43-66', true, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.750871', NULL, 0.00);
INSERT INTO public.clothing VALUES (391, 'L', 'Tommy Hilfiger', 'Hoodie', 'Navy', 31, '438940', 30.03, NULL, 108, NULL, 'Men

chest: 62
length: 73
arm: 61/81', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.089161', NULL, 0.00);
INSERT INTO public.clothing VALUES (261, 'M', 'DKNY', 'Puffy Jacket', 'Black', NULL, '244721', 59.99, NULL, NULL, NULL, 'DKNY on shoulder

Chest: 61
Waist: 59
Length: 71
Arm: 70', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:55.934063', NULL, NULL);
INSERT INTO public.clothing VALUES (1130, '???', 'Calvin Klein', 'unknown', 'Unknown', 92, '860531', 6.32, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.004487', NULL, NULL);
INSERT INTO public.clothing VALUES (266, 'S', 'Guess', 'Puffy Jacket', 'White', NULL, '558654', 39.99, NULL, NULL, NULL, 'Chest: 44
Waist: 39
Length: 60
Arm: 63', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:55.976166', NULL, NULL);
INSERT INTO public.clothing VALUES (1132, '???', 'Calvin Klein', 'unknown', 'Unknown', 93, '662151', 20.41, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.022174', NULL, NULL);
INSERT INTO public.clothing VALUES (274, '1SZ', 'Calvin Klein', 'Hat', 'Green', 24, '562795', 6.51, 8.80, NULL, 1, 'Beanie Cap
dark greenish/greyish', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:56.048283', NULL, NULL);
INSERT INTO public.clothing VALUES (275, '1SZ', 'Calvin Klein', 'Hat', 'Black', 24, '555766', 6.51, 8.80, NULL, 1, 'Beanie Cap', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:56.057885', NULL, NULL);
INSERT INTO public.clothing VALUES (198, 'N/A', 'Calvin Klein', 'Wallet', 'Black', NULL, '907939', 9.21, 19.64, NULL, 19, 'Non-folding wallet', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:55.394896', NULL, 0.00);
INSERT INTO public.clothing VALUES (265, '1SZ', 'Levis', 'Hat', 'Navy', NULL, '204256', 7.99, NULL, NULL, NULL, 'Beanie cap', NULL, 'women', NULL, NULL, NULL, 'Ukraine', '2020-12-21 01:07:55.96776', NULL, 0.00);
INSERT INTO public.clothing VALUES (240, 'S', 'Calvin Klein', 'Long Sleeved Shirt', 'Lemon', 21, '804603', 8.02, NULL, NULL, NULL, 'Calvin on chest

Chest: 55
Waist: 52
Length: 49
Arm: 51', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:55.769821', NULL, 0.00);
INSERT INTO public.clothing VALUES (1133, '???', 'Calvin Klein', 'unknown', 'Unknown', 93, '662144', 20.40, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.03089', NULL, NULL);
INSERT INTO public.clothing VALUES (323, 'L', 'Michael Kors', 'Belt', 'White', NULL, '??????', 14.00, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:56.481828', NULL, NULL);
INSERT INTO public.clothing VALUES (329, 'M', 'Calvin Klein', 'Sweat Pants', 'Black', 28, '561242', 15.86, NULL, NULL, NULL, 'small black rubber sign

waist: 39
hips: 49
length: 100
pasadka: 30', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:56.540673', NULL, NULL);
INSERT INTO public.clothing VALUES (1137, '???', 'Calvin Klein', 'unknown', 'Unknown', 95, '873135', 30.51, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.069823', NULL, NULL);
INSERT INTO public.clothing VALUES (1138, '???', 'Calvin Klein', 'unknown', 'Unknown', 96, '051381', 6.75, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.078933', NULL, NULL);
INSERT INTO public.clothing VALUES (328, 'M', 'Calvin Klein', 'Hoodie', 'Black', 28, '676182', 17.85, NULL, NULL, NULL, 'Men
black sign on chest

chest: 53
length: 67
arm: 66', NULL, 'men', NULL, NULL, NULL, NULL, '2020-12-21 01:07:56.524224', NULL, NULL);
INSERT INTO public.clothing VALUES (1139, '???', 'Calvin Klein', 'unknown', 'Unknown', 96, '051224', 6.71, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.088767', NULL, NULL);
INSERT INTO public.clothing VALUES (347, 'L', 'Calvin Klein', 'Belt', 'Black', 29, '192166', 7.99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:56.699436', NULL, NULL);
INSERT INTO public.clothing VALUES (331, 'S', 'Calvin Klein', 'Hoodie', 'White', 27, '964758', 25.47, NULL, NULL, NULL, 'Women
Payetki

chest: 51
length: 58
arm: 56-72', NULL, 'women', NULL, NULL, NULL, NULL, '2020-12-21 01:07:56.563202', NULL, NULL);
INSERT INTO public.clothing VALUES (1140, '???', 'Calvin Klein', 'unknown', 'Unknown', 96, '499199', 10.11, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.097689', NULL, NULL);
INSERT INTO public.clothing VALUES (233, 'L', 'Tommy Hilfiger', 'Sweater', 'White', 20, '080597', 22.34, NULL, NULL, NULL, 'Men
Zipper on top
Tommy Hilfiger across chest

Chest: 58
Waist: 57
Length: 73
Arm: 69', NULL, 'men', NULL, NULL, NULL, NULL, '2020-12-21 01:07:55.699638', NULL, NULL);
INSERT INTO public.clothing VALUES (234, 'M', 'Tommy Hilfiger', 'Sweater', 'Navy', 20, '080528', 22.30, NULL, NULL, NULL, 'Men
Zipper on top
Tommy Hilfiger across chest

Chest: 54
Waist: 53
Length: 70
Arm: 67', NULL, 'men', NULL, NULL, NULL, NULL, '2020-12-21 01:07:55.70903', NULL, NULL);
INSERT INTO public.clothing VALUES (364, 'XL', 'Calvin Klein', 'Puffy Jacket', 'Black', 29, '876686', 40.37, NULL, NULL, NULL, 'short & tiny

chest: 67
length: 72
arm: 71', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:56.847039', NULL, NULL);
INSERT INTO public.clothing VALUES (372, 'L', 'Calvin Klein', 'Belt', 'Black', 29, '192634', 7.99, NULL, NULL, NULL, 'not double sided', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:56.915443', NULL, NULL);
INSERT INTO public.clothing VALUES (2098, 'XXS', 'Karl Lagerfeld', 'Sweat Shirt', 'Navy, White', 161, '850660', 59.99, NULL, NULL, NULL, 'chest: 48
length: 60
arm: 60', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-01-13 12:15:32.173411', NULL, NULL);
INSERT INTO public.clothing VALUES (2124, 'XL', 'Tommy Hilfiger', 'Polo Shirt', 'Navy', 164, '391146', 10.39, NULL, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-01-16 18:47:20.892287', NULL, NULL);
INSERT INTO public.clothing VALUES (368, 'L', 'Calvin Klein', 'Vest Jacket', 'Black', 29, '876389', 32.29, 66.43, NULL, 18, 'sold for 1900
hooded

chest: 61
length: 69', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.881381', NULL, NULL);
INSERT INTO public.clothing VALUES (3002, 'N/A', 'Calvin Klein', 'Backpack', 'White', NULL, '348190', 59.99, 100.00, 99, 23, 'monogram

height: 36
width: 31', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-08 00:40:40.648083', NULL, NULL);
INSERT INTO public.clothing VALUES (334, 'S', 'Calvin Klein', 'Puffy Jacket', 'White', 28, '100568', 33.26, NULL, NULL, NULL, 'Hooded

Chest: 50
Waist: 44
Length: 56
Arm: 63', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.589412', NULL, NULL);
INSERT INTO public.clothing VALUES (1226, '27', 'Levis', 'Shorts', 'Blue', 63, '001027', 34.65, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.897371', NULL, NULL);
INSERT INTO public.clothing VALUES (1150, '???', 'Calvin Klein', 'unknown', 'Unknown', 97, '346561', 16.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.198831', NULL, NULL);
INSERT INTO public.clothing VALUES (1152, '???', 'Calvin Klein', 'unknown', 'Unknown', 98, '528137', 10.96, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.217392', NULL, NULL);
INSERT INTO public.clothing VALUES (245, 'XS', 'Calvin Klein', 'Hoodie', 'Navy', NULL, '800354', 19.26, NULL, NULL, NULL, 'Men
Black + grey stripe down arm

Chest: 50
Waist: 47
Length: 68
Arm: 66', NULL, 'men', NULL, NULL, NULL, NULL, '2020-12-21 01:07:55.808511', NULL, NULL);
INSERT INTO public.clothing VALUES (1153, '???', 'Calvin Klein', 'unknown', 'Unknown', 98, '528137', 10.96, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.226166', NULL, NULL);
INSERT INTO public.clothing VALUES (247, 'L', 'DKNY', 'Puffy Jacket', 'Silver', NULL, '219385', 59.99, NULL, NULL, NULL, 'Men

Chest: 64
Waist: 62
Length: 71
Arm: 70', NULL, 'men', NULL, NULL, NULL, NULL, '2020-12-21 01:07:55.823289', NULL, NULL);
INSERT INTO public.clothing VALUES (377, 'L', 'Calvin Klein', 'Sweat Pants', 'Blue', 29, '263299', 20.19, NULL, NULL, NULL, 'Men
grey sign

Waist: 46
Hips: 56
Length: 106
Pasadka: 31', NULL, 'men', NULL, NULL, NULL, NULL, '2020-12-21 01:07:56.958485', NULL, NULL);
INSERT INTO public.clothing VALUES (400, 'L', 'U.S. Polo Assn.', 'Sweat Shirt', 'Navy, Red', NULL, '563550', 24.99, NULL, NULL, NULL, 'super fluffy

chest: 63
length: 70
arm: 65', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:57.163917', NULL, NULL);
INSERT INTO public.clothing VALUES (403, 'M', 'Tommy Hilfiger', 'Sweat Shirt', 'White', NULL, '096403', 24.99, NULL, NULL, NULL, 'red tommy hilfiger sign on chest

chest: 54
length: 70
arm: 69 to the neck', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:57.185752', NULL, NULL);
INSERT INTO public.clothing VALUES (2125, 'M', 'Tommy Hilfiger', 'Polo Shirt', 'Navy', 164, '391122', 10.39, NULL, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-01-16 18:47:49.705259', NULL, NULL);
INSERT INTO public.clothing VALUES (1154, '???', 'Calvin Klein', 'unknown', 'Unknown', 98, '146306', 20.65, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.235609', NULL, NULL);
INSERT INTO public.clothing VALUES (1158, '???', 'Calvin Klein', 'unknown', 'Unknown', 99, '849257', 5.95, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.271553', NULL, NULL);
INSERT INTO public.clothing VALUES (450, 'XS', 'Calvin Klein', 'Blouse', 'Black', 34, '579471', 9.24, NULL, NULL, NULL, 'chest: 48
length: 62/70
arm: 63', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:57.60677', NULL, NULL);
INSERT INTO public.clothing VALUES (1159, '???', 'Calvin Klein', 'unknown', 'Unknown', 99, '398622', 13.54, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.280205', NULL, NULL);
INSERT INTO public.clothing VALUES (484, 'XS', 'Calvin Klein', 'Vest Jacket', 'Black, Grey', 37, '752157', 10.49, NULL, NULL, NULL, 'women vest
shiny

chest: 47
length: 62', NULL, 'women', NULL, NULL, NULL, NULL, '2020-12-21 01:07:57.891699', NULL, NULL);
INSERT INTO public.clothing VALUES (465, '1SZ', 'Calvin Klein', 'Scarf', 'Grey, Black', NULL, '586370', 11.70, NULL, NULL, NULL, 'logo pattern
rounded/closed', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:57.731236', NULL, NULL);
INSERT INTO public.clothing VALUES (1162, '???', 'Calvin Klein', 'unknown', 'Unknown', 100, '146306', 17.73, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.307313', NULL, NULL);
INSERT INTO public.clothing VALUES (710, 'S', 'Guess', 'Puffy Jacket', 'White', NULL, '558654', 39.99, NULL, NULL, NULL, 'Chest: 44
Waist: 39
Length: 60
Arm: 63', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:07:59.873826', NULL, NULL);
INSERT INTO public.clothing VALUES (1163, '???', 'Calvin Klein', 'unknown', 'Unknown', 100, '146313', 17.70, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:11.316406', NULL, NULL);
INSERT INTO public.clothing VALUES (392, 'L', 'Tommy Hilfiger', 'Sweat Pants', 'Navy', 31, '453752', 23.99, NULL, 108, NULL, 'Men

waist: 46
hips: 59
length: 102
pasadka: 32', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.097447', NULL, 0.00);
INSERT INTO public.clothing VALUES (3219, '8', 'Michael Kors', 'Flip Flops', 'Navy', 272, '027506', 24.99, NULL, 109, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-21 00:30:23.987611', NULL, NULL);
INSERT INTO public.clothing VALUES (2364, 'XS', 'Karl Lagerfeld', 'Hoodie', 'Black', 189, 'Lore7067', 29.99, NULL, 110, NULL, 'zipped

chest: 45
length: 57
arm: 59', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-01-31 15:28:37.752783', NULL, NULL);
INSERT INTO public.clothing VALUES (2707, 'L', 'Armani Exchange', 'Blazer', 'Black', 222, '405819', 29.99, 89.29, 101, 23, 'chest: 56
length: 74
arm: 66
shoulders: 49', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-02-27 22:42:09.12858', NULL, 0.00);
INSERT INTO public.clothing VALUES (3035, 'N/A', 'Michael Kors', 'Backpack', 'White, Vanilla', NULL, '076101', 93.57, 129.29, 101, 23, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-11 03:19:08.45977', NULL, NULL);
INSERT INTO public.clothing VALUES (2100, 'M', 'DKNY', 'Dress', 'Black', 161, '571126', 14.99, NULL, 111, NULL, 'chest: 49
length: 95', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-01-13 12:18:10.532278', NULL, NULL);
INSERT INTO public.clothing VALUES (2099, 'M', 'Tommy Hilfiger', 'Dress', 'Blue, Pink', 161, '314545', 19.99, NULL, 111, NULL, 'pink top,
blue bottom

chest: 50
length: 86', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-01-13 12:17:04.459618', NULL, NULL);
INSERT INTO public.clothing VALUES (3531, 'L', 'Armani Exchange', 'Sweat Pants', 'Blue', 287, '7776745', 39.99, NULL, NULL, NULL, NULL, NULL, 'men', NULL, NULL, NULL, 'usa', '2021-04-02 23:40:04.041282', NULL, NULL);
INSERT INTO public.clothing VALUES (3452, '7.5', 'Karl Lagerfeld', 'Shoes', 'Black', NULL, '??????', 89.00, 119.57, NULL, 22, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-31 17:19:39.987078', NULL, NULL);
INSERT INTO public.clothing VALUES (3687, 'M', 'Polo', 'Sweater', 'Blue', 299, '644395', 19.99, NULL, NULL, NULL, 'косы
ПОГ 58
дл 64
рук 62', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-08 17:46:30.750754', NULL, NULL);
INSERT INTO public.clothing VALUES (976, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 62, '061780', 33.74, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:09.566829', NULL, NULL);
INSERT INTO public.clothing VALUES (978, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 72, '787076', 25.50, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:09.584739', NULL, NULL);
INSERT INTO public.clothing VALUES (979, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 72, '444160', 10.19, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:09.594368', NULL, NULL);
INSERT INTO public.clothing VALUES (1008, 'M', 'Tommy Hilfiger', 'Polo Shirt', 'Navy', 77, '329801', 11.99, NULL, NULL, NULL, 'women
tommy on chest', true, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:09.870511', NULL, NULL);
INSERT INTO public.clothing VALUES (986, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 73, '400219', 11.24, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:09.660163', NULL, NULL);
INSERT INTO public.clothing VALUES (301, '6S', 'Tommy Hilfiger', 'Hoodie', 'Red', 20, '706459', 7.64, NULL, 7, NULL, 'Kids clothes
size S6-7

chest: 38
length: 49
arm: 43', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.295815', NULL, NULL);
INSERT INTO public.clothing VALUES (987, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 74, '695777', 29.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:09.668893', NULL, NULL);
INSERT INTO public.clothing VALUES (989, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 74, '085885', 24.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:09.688441', NULL, NULL);
INSERT INTO public.clothing VALUES (990, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 74, '073721', 39.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:09.705548', NULL, NULL);
INSERT INTO public.clothing VALUES (991, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 74, '947876', 23.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:09.718545', NULL, NULL);
INSERT INTO public.clothing VALUES (992, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 75, '350834', 23.63, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:09.727547', NULL, NULL);
INSERT INTO public.clothing VALUES (995, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 76, '792674', 27.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:09.754459', NULL, NULL);
INSERT INTO public.clothing VALUES (996, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 76, '159323', 11.19, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:09.763967', NULL, NULL);
INSERT INTO public.clothing VALUES (998, 'XS', 'Tommy Hilfiger', 'Sweat Shirt', 'White', 76, '792742', 27.99, NULL, NULL, NULL, '"Tommy Hilfiger" in block letters on chest

Chest: 47
Waist: 44
Length: 60
Arm: 58', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:09.782003', NULL, NULL);
INSERT INTO public.clothing VALUES (1000, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 76, '250499', 31.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:09.80013', NULL, NULL);
INSERT INTO public.clothing VALUES (1001, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 77, '787144', 23.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:09.808524', NULL, NULL);
INSERT INTO public.clothing VALUES (1009, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 77, '329771', 11.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:09.881282', NULL, NULL);
INSERT INTO public.clothing VALUES (1011, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 77, '329726', 11.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:09.900206', NULL, NULL);
INSERT INTO public.clothing VALUES (1014, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 78, '492911', 23.61, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:09.926966', NULL, NULL);
INSERT INTO public.clothing VALUES (1016, 'XS', 'Tommy Hilfiger', 'Sweat Shirt', 'Light Blue', 78, '569795', 14.39, NULL, NULL, NULL, 'textured Light sweat shirt

Chest: 43
Waist: 38
Length: 57
Arm: 58', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:09.946597', NULL, NULL);
INSERT INTO public.clothing VALUES (1017, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 79, '787076', 25.49, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:09.955458', NULL, NULL);
INSERT INTO public.clothing VALUES (1018, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 79, '565674', 11.89, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:09.965513', NULL, NULL);
INSERT INTO public.clothing VALUES (1019, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 80, '695227', 33.61, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:09.974333', NULL, NULL);
INSERT INTO public.clothing VALUES (1020, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 80, '686683', 38.39, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:09.983689', NULL, NULL);
INSERT INTO public.clothing VALUES (1021, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 80, '716083', 26.39, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:09.992172', NULL, NULL);
INSERT INTO public.clothing VALUES (1022, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 80, '686959', 43.19, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.001299', NULL, NULL);
INSERT INTO public.clothing VALUES (1023, 'N/A', 'Tommy Hilfiger', 'Fanny Pack', 'Blue, Red, White', 80, '465080', 15.68, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.009634', NULL, NULL);
INSERT INTO public.clothing VALUES (1024, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 80, '787069', 23.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.019246', NULL, NULL);
INSERT INTO public.clothing VALUES (1025, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 80, '411155', 15.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.028638', NULL, NULL);
INSERT INTO public.clothing VALUES (1026, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 80, '425497', 12.79, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.03772', NULL, NULL);
INSERT INTO public.clothing VALUES (1027, 'XS', 'Tommy Hilfiger', 'Dress', 'Unknown', 80, '295410', 12.79, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.049933', NULL, NULL);
INSERT INTO public.clothing VALUES (1029, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 80, '295427', 12.79, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.068146', NULL, NULL);
INSERT INTO public.clothing VALUES (1031, '???', 'Tommy Hilfiger', 'unknown', 'Unknown', 81, '575130', 11.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.085801', NULL, NULL);
INSERT INTO public.clothing VALUES (1013, 'XS', 'Tommy Hilfiger', 'Sweater', 'Teal', 78, '569863', 14.39, NULL, NULL, NULL, 'knitted style

Chest: 41
Waist: 37
Length: 56
Arm: 56', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:09.918125', NULL, NULL);
INSERT INTO public.clothing VALUES (1015, 'M', 'Tommy Hilfiger', 'Polo Shirt', 'Mint', 78, '575123', 11.99, NULL, NULL, NULL, NULL, true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:09.936044', NULL, NULL);
INSERT INTO public.clothing VALUES (1045, '???', 'Calvin Klein', 'unknown', 'Unknown', 84, '680061', 14.63, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.225741', NULL, NULL);
INSERT INTO public.clothing VALUES (1046, '???', 'Calvin Klein', 'unknown', 'Unknown', 84, '024465', 18.90, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.235104', NULL, NULL);
INSERT INTO public.clothing VALUES (1047, '???', 'Calvin Klein', 'unknown', 'Unknown', 84, '848929', 20.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.243621', NULL, NULL);
INSERT INTO public.clothing VALUES (1048, '???', 'Calvin Klein', 'unknown', 'Unknown', 84, '139759', 17.32, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.252777', NULL, NULL);
INSERT INTO public.clothing VALUES (1049, '???', 'Calvin Klein', 'unknown', 'Unknown', 84, '139773', 17.32, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.261453', NULL, NULL);
INSERT INTO public.clothing VALUES (961, '???', 'Tommy Hilfiger', 'Unknown', 'Unknown', 61, '686874', 7.49, NULL, 102, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:09.417582', NULL, 0.00);
INSERT INTO public.clothing VALUES (1050, '???', 'Calvin Klein', 'unknown', 'Unknown', 84, '893219', 13.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.27037', NULL, NULL);
INSERT INTO public.clothing VALUES (1054, '???', 'Calvin Klein', 'unknown', 'Unknown', 84, '460922', 13.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.306733', NULL, NULL);
INSERT INTO public.clothing VALUES (1055, '???', 'Calvin Klein', 'unknown', 'Unknown', 84, '847994', 13.99, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.317486', NULL, NULL);
INSERT INTO public.clothing VALUES (1057, '???', 'Calvin Klein', 'unknown', 'Unknown', 85, '927885', 14.18, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.335089', NULL, NULL);
INSERT INTO public.clothing VALUES (1058, '???', 'Calvin Klein', 'unknown', 'Unknown', 85, '668021', 11.89, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.343753', NULL, NULL);
INSERT INTO public.clothing VALUES (1060, '???', 'Calvin Klein', 'unknown', 'Unknown', 85, '475025', 23.11, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.361549', NULL, NULL);
INSERT INTO public.clothing VALUES (1061, 'XS', 'Calvin Klein', 'Sweat Shirt', 'Yellow', 86, '680085', 10.51, NULL, NULL, NULL, 'Black & white letters

Chest: 48
Waist: 48
Length: 64
Arm: 51', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.37056', NULL, NULL);
INSERT INTO public.clothing VALUES (1062, '???', 'Calvin Klein', 'unknown', 'Unknown', 86, '680078', 10.47, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.379359', NULL, NULL);
INSERT INTO public.clothing VALUES (1063, 'XS', 'Calvin Klein', 'Sweat Shirt', 'Yellow', 86, '680085', 10.47, NULL, NULL, NULL, 'Black & white letters

Chest: 48
Waist: 48
Length: 64
Arm: 51', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.389784', NULL, NULL);
INSERT INTO public.clothing VALUES (1064, '???', 'Calvin Klein', 'unknown', 'Unknown', 86, '139766', 12.43, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.399828', NULL, NULL);
INSERT INTO public.clothing VALUES (1065, '???', 'Calvin Klein', 'unknown', 'Unknown', 86, '139759', 12.43, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.408352', NULL, NULL);
INSERT INTO public.clothing VALUES (1069, '???', 'Calvin Klein', 'unknown', 'Unknown', 86, '146290', 14.94, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.443823', NULL, NULL);
INSERT INTO public.clothing VALUES (1070, '???', 'Calvin Klein', 'unknown', 'Unknown', 86, '263169', 17.45, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.453025', NULL, NULL);
INSERT INTO public.clothing VALUES (1071, '???', 'Calvin Klein', 'unknown', 'Unknown', 86, '528427', 7.94, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.461675', NULL, NULL);
INSERT INTO public.clothing VALUES (1077, '???', 'Calvin Klein', 'unknown', 'Unknown', 86, '858071', 10.04, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.516487', NULL, NULL);
INSERT INTO public.clothing VALUES (1082, '???', 'Calvin Klein', 'unknown', 'Unknown', 86, '668038', 10.04, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.561824', NULL, NULL);
INSERT INTO public.clothing VALUES (1086, '???', 'Calvin Klein', 'unknown', 'Unknown', 87, '420227', 7.98, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.597971', NULL, NULL);
INSERT INTO public.clothing VALUES (1087, '???', 'Calvin Klein', 'unknown', 'Unknown', 87, '420227', 7.97, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.606205', NULL, NULL);
INSERT INTO public.clothing VALUES (883, 'S', 'Calvin Klein', 'Sport Bra', 'Pink', 59, '725458', 6.71, NULL, NULL, NULL, '', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:08.657333', NULL, NULL);
INSERT INTO public.clothing VALUES (855, '36', 'Armani Exchange', 'Jeans', 'Grey', 57, '459103', 14.99, NULL, NULL, NULL, 'Waist: 48
Length: 108
Lapatka: 27', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:08.387357', NULL, NULL);
INSERT INTO public.clothing VALUES (1059, '???', 'Calvin Klein', 'unknown', 'Unknown', 85, '474967', 23.11, NULL, 115, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.353056', NULL, NULL);
INSERT INTO public.clothing VALUES (993, '00', 'Tommy Hilfiger', 'Pants', 'White, Cream', 75, '687932', 11.89, NULL, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:09.736346', NULL, 0.00);
INSERT INTO public.clothing VALUES (1080, 'M', 'Calvin Klein', 'T-Shirt', 'White', 86, '668038', 10.04, NULL, 117, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:10.544218', NULL, 0.00);
INSERT INTO public.clothing VALUES (1068, '0', 'Calvin Klein', 'Shorts', 'Black', 86, '927823', 11.95, NULL, 127, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:10.435588', NULL, 0.00);
INSERT INTO public.clothing VALUES (980, 'XS', 'Tommy Hilfiger', 'Hoodie', 'Navy', 72, '686188', 15.29, NULL, 127, NULL, 'half zipper
hilfiger on arm', NULL, 'women', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:09.602899', NULL, 0.00);
INSERT INTO public.clothing VALUES (856, '34', 'Armani Exchange', 'Jeans', 'Blue', 57, '052894', 14.99, NULL, NULL, NULL, 'Tag number faded
style j22
Waist: 48
hips: 54
Length: 108
pasadka: 28', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:08.397235', NULL, NULL);
INSERT INTO public.clothing VALUES (1002, 'XS', 'Tommy Hilfiger', 'Polo Shirt', 'Navy', 77, '329788', 11.99, NULL, NULL, NULL, 'sign on chest', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:09.817653', NULL, NULL);
INSERT INTO public.clothing VALUES (982, 'XS', 'Tommy Hilfiger', 'Leggings', 'Light Blue, Navy, White', 72, '768785', 11.89, NULL, NULL, NULL, 'leggings
go with 733257', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:09.622118', NULL, NULL);
INSERT INTO public.clothing VALUES (1073, 'M', 'Calvin Klein', 'T-Shirt', 'Black', 86, '967975', 10.04, NULL, NULL, NULL, 'grey logo on chest', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:10.480082', NULL, NULL);
INSERT INTO public.clothing VALUES (1174, 'XS', 'Calvin Klein', 'T-Shirt', 'Pink', 101, '860548', 5.43, NULL, NULL, NULL, 'Black CK, silver letters on front', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:11.426366', NULL, NULL);
INSERT INTO public.clothing VALUES (1112, 'XS', 'Calvin Klein', 'T-Shirt', 'Black', 88, '858088', 12.75, NULL, NULL, NULL, 'Gold CK, white letters on front', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:10.842676', NULL, NULL);
INSERT INTO public.clothing VALUES (1100, 'S', 'Calvin Klein', 'T-Shirt', 'Navy', 88, '548967', 6.37, NULL, NULL, NULL, 'white letters "calvin" on chest', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:10.723848', NULL, NULL);
INSERT INTO public.clothing VALUES (1076, 'XS', 'Calvin Klein', 'T-Shirt', 'Black', 86, '711292', 10.04, NULL, NULL, NULL, 'white CK, grey letters on front', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:10.506806', NULL, NULL);
INSERT INTO public.clothing VALUES (1078, 'XS', 'Calvin Klein', 'T-Shirt', 'Black', 86, '858088', 10.04, NULL, NULL, NULL, 'Gold CK, white letters on front', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:10.526192', NULL, NULL);
INSERT INTO public.clothing VALUES (1147, 'S', 'Calvin Klein', 'T-Shirt', 'Navy', 96, '557234', 6.71, NULL, NULL, NULL, 'large white square, blue ck', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:11.171973', NULL, NULL);
INSERT INTO public.clothing VALUES (981, 'XXS', 'Tommy Hilfiger', 'Dress', 'Navy', 72, '567272', 13.59, NULL, NULL, NULL, 'jean collar
sign & flag ''tommy hilfiger'' on chest

chest: 46
length: 81
arm: 53', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:09.613634', NULL, NULL);
INSERT INTO public.clothing VALUES (1141, 'M', 'Calvin Klein', 'T-Shirt', 'Navy', 96, '548974', 5.01, NULL, NULL, NULL, 'white letters "calvin" on chest', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:11.10697', NULL, NULL);
INSERT INTO public.clothing VALUES (1302, 'M', 'Michael Kors', 'T-Shirt', 'Black', 56, '630410', 19.99, NULL, NULL, NULL, 'Gold zipper

Chest: 46
Waist: 40
Length: 61', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:12.595863', NULL, NULL);
INSERT INTO public.clothing VALUES (851, 'S', 'Armani Exchange', 'Fluffy Jacket', 'Carrot', 57, '098762', 29.99, NULL, 44, NULL, 'Chest: 43
Waist: 53
Length: 93
Arm: 58', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:08.348872', NULL, NULL);
INSERT INTO public.clothing VALUES (1089, '???', 'Calvin Klein', 'unknown', 'Unknown', 87, '927915', 14.60, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.624438', NULL, NULL);
INSERT INTO public.clothing VALUES (1090, '???', 'Calvin Klein', 'unknown', 'Unknown', 87, '528335', 7.24, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.634082', NULL, NULL);
INSERT INTO public.clothing VALUES (1091, '???', 'Calvin Klein', 'unknown', 'Unknown', 87, '528403', 9.69, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.642477', NULL, NULL);
INSERT INTO public.clothing VALUES (1095, '???', 'Calvin Klein', 'unknown', 'Unknown', 87, '662854', 8.83, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.68017', NULL, NULL);
INSERT INTO public.clothing VALUES (1096, '???', 'Calvin Klein', 'unknown', 'Unknown', 87, '528472', 9.69, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.688749', NULL, NULL);
INSERT INTO public.clothing VALUES (1097, '???', 'Calvin Klein', 'unknown', 'Unknown', 87, '847987', 12.26, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2020-12-21 01:19:10.697462', NULL, NULL);
INSERT INTO public.clothing VALUES (1037, 'L', 'Tommy Hilfiger', 'Polo Shirt', 'Navy', 83, '329818', 11.99, NULL, 99, NULL, 'chest: 52
length: 66', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:10.152027', NULL, 0.00);
INSERT INTO public.clothing VALUES (1516, 'XS', 'Tommy Hilfiger', 'Polo Shirt', 'Navy', 138, '717738', 7.49, NULL, 45, NULL, 'Female

Chest: 37
Waist: 33
Length: 57', true, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:14.605985', NULL, NULL);
INSERT INTO public.clothing VALUES (1172, 'M', 'Calvin Klein', 'T-Shirt', 'Black', 100, '844786', 10.11, NULL, 39, NULL, '', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:11.408697', NULL, NULL);
INSERT INTO public.clothing VALUES (1134, 'S', 'Calvin Klein', 'Swimsuit', 'Pink', 93, '661543', 37.40, NULL, 63, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:11.04018', NULL, 0.00);
INSERT INTO public.clothing VALUES (1216, 'XS', 'Calvin Klein', 'unknown', 'Black', 106, '844661', 17.72, NULL, 42, NULL, '"Calvin Klein" rhinestones on front

Chest: 47
Waist: 41
Length: 54
Arm: 50', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:11.807523', NULL, NULL);
INSERT INTO public.clothing VALUES (1236, 'S', 'Levis', 'Sweater', 'Black', 108, '00640S', 16.99, NULL, 44, NULL, 'White logo on chest

Chest: 52
Waist: 48
Length: 61
Arm: ', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:11.987699', NULL, NULL);
INSERT INTO public.clothing VALUES (1301, '4', 'Michael Kors', 'Jeans', 'Blue', 56, '655451', 16.99, NULL, 41, NULL, 'Ross tag: 654577

Waist: 37
Hips: 45
Length: 97
Pasadka: 25', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:12.581213', NULL, NULL);
INSERT INTO public.clothing VALUES (1529, 'M', 'Levis', 'Leather Jacket', 'Green', 56, '800067', 26.99, NULL, 42, NULL, 'Chest: 50
Waist: 46
Length: 48
Arm: 62', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:14.72175', NULL, NULL);
INSERT INTO public.clothing VALUES (1530, 'S', 'Calvin Klein', 'Sweat Pants', 'Black', 56, '701926', 19.99, NULL, 42, NULL, 'White letters on calf

Waist: 40
Hips: 49
Length: 93
Pasadka: 24', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:14.731415', NULL, NULL);
INSERT INTO public.clothing VALUES (1593, 'S', 'Levis', 'T-Shirt', 'Black', 145, '00300S', 6.99, NULL, 42, NULL, 'San Francisco Bridge

Chest: 53
Waist: 53
Length: 72', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:15.319145', NULL, NULL);
INSERT INTO public.clothing VALUES (1662, 'XL', 'Levis', 'Jacket', 'White, Red, Blue', 56, '921607', 39.99, NULL, 44, NULL, 'Looks like a vest jacket on a sweater

Chest: 52
Waist: 52
Length: 65
Arm: 60', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:15.957997', NULL, NULL);
INSERT INTO public.clothing VALUES (1366, '2', 'Tommy Hilfiger', 'Pants', 'Navy', 56, '688069', 15.00, NULL, 99, NULL, 'Waist: 37
Hips: 50
Length: 89
Pasadka: 24', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:13.210157', NULL, 0.00);
INSERT INTO public.clothing VALUES (1641, 'L', 'Calvin Klein', 'Long Sleeved Shirt', 'White', 125, '794951', 8.49, NULL, 81, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:15.756175', NULL, 0.00);
INSERT INTO public.clothing VALUES (1654, 'L', 'Tommy Hilfiger', 'Long sleeved shirt', 'White', 56, '833551', 0.00, NULL, 44, NULL, 'Men''s dress shirt

Chest: 54 
Waist: 54
Length: 76
Arm: 62', true, 'men', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:15.877847', NULL, NULL);
INSERT INTO public.clothing VALUES (860, 'L', 'Armani Exchange', 'Trench Coat', 'Black', 57, '144889', 34.99, NULL, 44, NULL, 'Chest: 59
Waist: 59
Length: 101
Arm: 65', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:08.444756', NULL, NULL);
INSERT INTO public.clothing VALUES (895, 'L', 'Armani Exchange', 'T-Shirt', 'Black', 60, '143494', 20.99, NULL, 45, NULL, 'Large circle

chest: 49
waist: 49
length: 72', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:08.772433', NULL, 4.63);
INSERT INTO public.clothing VALUES (874, 'M', 'Calvin Klein', 'Sweat Shirt', 'Red', 59, '626453', 11.81, 49.12, 41, NULL, 'Chest: 54
Waist: 49
Length: 68
Arm:  62', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:08.574586', NULL, NULL);
INSERT INTO public.clothing VALUES (875, 'L', 'Calvin Klein', 'Windbreaker', 'Black', 59, '634583', 30.62, NULL, 41, NULL, 'Chest: 59
Waist: 55
Length: 90
Arm: 62', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:08.583089', NULL, NULL);
INSERT INTO public.clothing VALUES (888, 'M', 'Calvin Klein', 'Windbreaker', 'Black', 59, '680030', 30.60, NULL, 41, NULL, 'On receipt as 634590

Chest: 56
Waist: 51
Length: 88
Arm:  61', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:08.704986', NULL, NULL);
INSERT INTO public.clothing VALUES (893, 'M', 'Armani Exchange', 'T-Shirt', 'Black', 60, '70570', 20.99, NULL, 45, NULL, 'vertical logo

chest: 48
waist: 48
length: 67', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:08.752171', NULL, NULL);
INSERT INTO public.clothing VALUES (896, 'S', 'Tommy Hilfiger', 'Windbreaker', 'White', 61, '4269', 21.02, NULL, 36, NULL, 'W

Chest: 51
Waist: 48
Length: 68
Arm: 60', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:08.781932', NULL, NULL);
INSERT INTO public.clothing VALUES (898, 'S', 'Tommy Hilfiger', 'Polo Shirt', 'Navy', 56, '9795', 0.00, NULL, 36, NULL, 'W', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:08.802088', NULL, NULL);
INSERT INTO public.clothing VALUES (900, 'L', 'Calvin Klein', 'Sweat Shirt', 'Black', 56, '6702', 20.00, NULL, 36, NULL, 'M

White stripe', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:08.821061', NULL, NULL);
INSERT INTO public.clothing VALUES (901, 'M', 'Tommy Hilfiger', 'Windbreaker', 'White', 61, '4276', 20.99, NULL, 36, NULL, 'Chest: 53
Waist: 55
Length: 69 
Arm: 63', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:08.838523', NULL, NULL);
INSERT INTO public.clothing VALUES (903, 'L', 'Tommy Hilfiger', 'Dress Shirt', 'White', 61, '7099', 9.74, NULL, 36, NULL, 'M
sleeve stripes

Chest: 55
Waist: 54
Length:  74
Arm: 69', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:08.864411', NULL, NULL);
INSERT INTO public.clothing VALUES (904, 'XS', 'Calvin Klein', 'Sweat Shirt', 'Yellow', 85, '422616', 12.40, NULL, 36, NULL, 'w', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:08.873506', NULL, NULL);
INSERT INTO public.clothing VALUES (905, 'M', 'Tommy Hilfiger', 'Sweat Pants', 'Navy', 56, '793', 0.00, NULL, 36, NULL, 'w', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:08.882671', NULL, NULL);
INSERT INTO public.clothing VALUES (906, 'XS', 'Tommy Hilfiger', 'Sweat Shirt', 'White', 56, '5674', 0.00, NULL, 36, NULL, 'w', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:08.892736', NULL, NULL);
INSERT INTO public.clothing VALUES (907, 'S', 'Levis', 'Trucker Jacket', 'Blue', 56, '559', 0.00, NULL, 36, NULL, 'w', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:08.901384', NULL, NULL);
INSERT INTO public.clothing VALUES (1331, 'N/A', 'Armani Exchange', 'Bag', 'Black', 60, '767493', 29.99, NULL, 74, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:12.889732', NULL, 4.63);
INSERT INTO public.clothing VALUES (897, 'M', 'Tommy Hilfiger', 'Windbreaker', 'Blue', 62, '9325', 29.24, NULL, 108, NULL, 'M

Chest: 58
Waist: 51
Length: 69
Arm: 67', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:08.792571', NULL, 5.00);
INSERT INTO public.clothing VALUES (912, 'S', 'Calvin Klein', 'Sweat Shirt', 'Black', 56, '9182', 0.00, NULL, 36, NULL, '', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:08.950471', NULL, NULL);
INSERT INTO public.clothing VALUES (913, 'XS', 'Calvin Klein', 'Sweat Shirt', 'Black', 56, '9199', 0.00, NULL, 36, NULL, '', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:08.960377', NULL, NULL);
INSERT INTO public.clothing VALUES (914, 'S', 'Levis', 'Hoodie', 'Black', 56, '5352', 0.00, NULL, 36, NULL, '', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:08.969583', NULL, NULL);
INSERT INTO public.clothing VALUES (915, 'M', 'Levis', 'T-Shirt', 'White', 56, '9945', 8.00, NULL, 36, NULL, '', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:08.984013', NULL, NULL);
INSERT INTO public.clothing VALUES (916, 'M', 'Levis', 'T-Shirt', 'Black', 56, '279', 8.00, NULL, 36, NULL, '', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:08.998243', NULL, NULL);
INSERT INTO public.clothing VALUES (917, 'M', 'Levis', 'T-Shirt', 'White', 56, '9945', 8.00, NULL, 36, NULL, '', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:09.007189', NULL, NULL);
INSERT INTO public.clothing VALUES (918, 'S', 'Levis', 'T-Shirt', 'White', 56, '9616', 8.00, NULL, 36, NULL, '', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:09.017607', NULL, NULL);
INSERT INTO public.clothing VALUES (921, 'XS', 'Calvin Klein', 'T-Shirt', 'Black', 56, '9288', 8.00, NULL, 36, NULL, 'White + yellow letters

Chest: 46
Waist: 46
Length: 43', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:09.046643', NULL, NULL);
INSERT INTO public.clothing VALUES (922, 'XS', 'Calvin Klein', 'T-Shirt', 'Black', 56, '9288', 8.00, NULL, 36, NULL, 'White + yellow letters

Chest: 46
Waist: 46
Length: 43', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:09.055258', NULL, NULL);
INSERT INTO public.clothing VALUES (458, 'S', 'Calvin Klein', 'T-Shirt', 'Black', 34, '803651', 9.97, NULL, 19, NULL, 'payetki sign on chest

chest: 43
length: 64', true, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.674171', NULL, 0.00);
INSERT INTO public.clothing VALUES (924, 'M', 'Tommy Hilfiger', 'Rain Coat', 'Yellow', 61, '6621', 13.49, NULL, 36, NULL, 'W

Chest: 56
Waist: 58
Length: 63
Arm: 62', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:09.074747', NULL, NULL);
INSERT INTO public.clothing VALUES (925, '9', 'Calvin Klein', 'Flip Flops', 'Black', 56, '7482', 0.00, NULL, 36, NULL, '', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:09.084028', NULL, NULL);
INSERT INTO public.clothing VALUES (929, 'L', 'Calvin Klein', 'Vest Jacket', 'Green', 64, '136086', 22.02, NULL, 41, NULL, 'Chest: 55
Waist: 60
Length: 64', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:09.122261', NULL, NULL);
INSERT INTO public.clothing VALUES (935, 'S', 'Tommy Hilfiger', 'Sweat Pants', 'White', 66, '790717', 35.99, NULL, 41, NULL, 'Waist: 37
Hips: 49
Length: 96
Pasadka: 24', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:09.178565', NULL, NULL);
INSERT INTO public.clothing VALUES (936, 'S', 'Tommy Hilfiger', 'Sweat Shirt', 'White', 66, '792759', 31.49, NULL, 41, NULL, '"Tommy Hilfiger" in block letters on chest

Chest: 51
Waist: 47
Length: 62
Arm: 59', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:09.187297', NULL, NULL);
INSERT INTO public.clothing VALUES (937, '2', 'Tommy Hilfiger', 'Shorts', 'Red', 66, '573105', 18.76, NULL, 37, NULL, 'Waist: 39
Hips: 46
Length: 35
Pasadka: 23', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:09.197109', NULL, NULL);
INSERT INTO public.clothing VALUES (938, '10', 'Tommy Hilfiger', 'Blazer', 'Navy', 66, '319602', 7.49, NULL, 41, NULL, 'Chest: 48
Waist: 42
Length: 69
Arm: 62', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:09.205853', NULL, NULL);
INSERT INTO public.clothing VALUES (940, 'M', 'Tommy Hilfiger', 'Sweat Pants', 'White', 66, '790724', 35.99, NULL, 37, NULL, 'Waist: 42
Hips: 52
Length: 95
Pasadka: 26', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:09.224325', NULL, NULL);
INSERT INTO public.clothing VALUES (941, 'M', 'Tommy Hilfiger', 'Sweat Shirt', 'White', 66, '792766', 31.49, NULL, 37, NULL, '"Tommy Hilfiger" in block letters on chest

Chest: 53
Waist: 51
Length: 63
Arm:  61', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:09.233235', NULL, NULL);
INSERT INTO public.clothing VALUES (943, 'XS', 'Tommy Hilfiger', 'Sweater', 'Light Blue', 66, '680581', 7.49, NULL, 41, NULL, 'Chest: 48
Waist: 48
Length: 60
Arm:  64', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:09.25108', NULL, NULL);
INSERT INTO public.clothing VALUES (953, 'S', 'Calvin Klein', 'Windbreaker', 'Black, Red', 69, '719488', 21.27, NULL, 37, NULL, 'Chest: 53
Waist: 52
Length: 64
Arm: 65', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:09.342585', NULL, NULL);
INSERT INTO public.clothing VALUES (927, 'XS', 'Calvin Klein', 'Sweat Pants', 'Black', 64, '263145', 29.54, NULL, 39, NULL, 'Men''s

Waist: 39
Length: 100
Lapatka: 28', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:09.10282', NULL, NULL);
INSERT INTO public.clothing VALUES (959, 'S', 'Tommy Hilfiger', 'Windbreaker', 'Lemon, Light Blue', 61, '686614', 13.49, NULL, 41, NULL, 'Chest: 54
Waist: 54
Length: 62
Arm: 61', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:09.398453', NULL, 0.00);
INSERT INTO public.clothing VALUES (958, 'S', 'Tommy Hilfiger', 'Sweat Shirt', 'White', 61, '565681', 7.49, NULL, 41, NULL, 'Large red white blue logo

Chest: 56
Waist: 55
Length: 55
Arm: 54', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:09.387655', NULL, NULL);
INSERT INTO public.clothing VALUES (954, 'L', 'Calvin Klein', 'Windbreaker', 'Black, Red', 70, '719464', 26.25, NULL, 44, NULL, 'Chest: 59
Waist: 59
Length: 69
Arm: 67
', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:09.351084', NULL, 0.00);
INSERT INTO public.clothing VALUES (968, 'S', 'Tommy Hilfiger', 'Sweater', 'White, Grey', 62, '686898', 7.49, NULL, 42, NULL, 'words everywhere in grey
red zipper

Chest: 47
Waist: 47
Length: 56
Arm: 62', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:09.48263', NULL, NULL);
INSERT INTO public.clothing VALUES (977, '0', 'Tommy Hilfiger', 'Jeans', 'Blue', 71, '411162', 16.00, NULL, 41, NULL, 'Pale blue stripe on side

Waist: 37
Hips: 45
Length: 86
Pasadka: 21', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:09.575317', NULL, NULL);
INSERT INTO public.clothing VALUES (1012, 'XS', 'Tommy Hilfiger', 'Sweat Shirt', 'White', 78, '569511', 14.39, NULL, 39, NULL, '', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:09.908874', NULL, NULL);
INSERT INTO public.clothing VALUES (1066, 'XS', 'Calvin Klein', 'Hoodie', 'Black', 86, '146009', 17.45, NULL, 39, NULL, '', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:10.417745', NULL, NULL);
INSERT INTO public.clothing VALUES (1098, 'S', 'Calvin Klein', 'T-Shirt', 'White', 88, '667741', 12.75, NULL, 38, NULL, 'silver square', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:10.706088', NULL, NULL);
INSERT INTO public.clothing VALUES (1106, '00', 'Calvin Klein', 'Pants', 'Navy', 88, '668045', 12.75, NULL, 42, NULL, 'Waist: 39
Hips: 51
Length: 88
Pasadka: 22', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:10.788581', NULL, NULL);
INSERT INTO public.clothing VALUES (1119, 'L', 'Calvin Klein', 'Sport Pants', 'Black', 90, '332085', 14.31, NULL, 41, NULL, '', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:10.905119', NULL, NULL);
INSERT INTO public.clothing VALUES (1124, 'S', 'Calvin Klein', 'Puffy Jacket', 'Gold', 91, '797692', 8.84, NULL, 41, NULL, '', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:10.949899', NULL, NULL);
INSERT INTO public.clothing VALUES (1135, 'S', 'Calvin Klein', 'Pants', 'Black', 93, '529765', 30.34, NULL, 37, NULL, 'White strip on side', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:11.051359', NULL, NULL);
INSERT INTO public.clothing VALUES (1157, 'XS', 'Calvin Klein', 'Sweat Shirt', 'White', 99, '499298', 10.11, NULL, 41, NULL, 'knitted

Chest: 63
Waist: 63
Length: 45
Arm: 51', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:11.262273', NULL, NULL);
INSERT INTO public.clothing VALUES (1161, 'M', 'Calvin Klein', 'T-Shirt', 'White', 99, '849318', 5.95, NULL, 39, NULL, '', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:11.29843', NULL, NULL);
INSERT INTO public.clothing VALUES (1121, '32X32', 'Calvin Klein', 'Jeans', 'Blue', 90, '010906', 14.31, NULL, 42, NULL, 'skinny
dark blue
Waist: 43
Hips: 49
Length: 105
Pasadka: 28', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:10.922422', NULL, NULL);
INSERT INTO public.clothing VALUES (1122, '32X32', 'Calvin Klein', 'Jeans', 'Navy', 90, '068501', 16.11, NULL, 42, NULL, 'big
athletic taper
dark navy
Waist: 45
Hips: 56
Length: 106
Pasadka: 28', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:10.932157', NULL, NULL);
INSERT INTO public.clothing VALUES (1123, 'N/A', 'Calvin Klein', 'Purse', 'Black', 91, '412403', 2.66, NULL, 44, NULL, 'length: 30
height: 21', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:10.940298', NULL, NULL);
INSERT INTO public.clothing VALUES (1239, 'M', 'Levis', 'T-Shirt', 'Navy, Red', 108, '00420M', 7.99, NULL, 45, NULL, 'Red cowboy/horse logo

Chest: 50
Waist: 50
Length: 65', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:12.015202', NULL, NULL);
INSERT INTO public.clothing VALUES (1253, 'S', 'DKNY', 'Hoodie', 'Black', 56, '???', 8.00, NULL, 37, NULL, 'Zipped
Large white letters on chest', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:12.153863', NULL, NULL);
INSERT INTO public.clothing VALUES (1254, '6', 'Michael Kors', 'Jeans', 'Navy', 56, '???', 18.34, NULL, 37, NULL, 'Selma Skinny', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:12.161895', NULL, NULL);
INSERT INTO public.clothing VALUES (1255, 'XXS', 'DKNY', 'T-Shirt', 'Black', 56, '0757', 0.00, NULL, 37, NULL, 'White letters on chest', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:12.171158', NULL, NULL);
INSERT INTO public.clothing VALUES (1271, '4', 'Calvin Klein', 'Blazer', 'Unknown', 56, '1919', 12.70, NULL, 38, NULL, '', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:12.312687', NULL, NULL);
INSERT INTO public.clothing VALUES (1272, '2', 'Tommy Hilfiger', 'Blazer', 'Unknown', 56, '9640', 0.00, NULL, 38, NULL, '', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:12.322145', NULL, NULL);
INSERT INTO public.clothing VALUES (1273, 'XS', 'Tommy Hilfiger', 'T-Shirt', 'White', 56, '1878', 12.00, NULL, 38, NULL, '', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:12.330463', NULL, NULL);
INSERT INTO public.clothing VALUES (1274, 'M', 'Calvin Klein', 'Windbreaker', 'White, Black', 56, '8845', 27.00, NULL, 38, NULL, '', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:12.339606', NULL, NULL);
INSERT INTO public.clothing VALUES (1275, 'M', 'Tommy Hilfiger', 'Sweat Shirt', 'Navy', 56, '3098', 12.96, NULL, 38, NULL, '', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:12.348277', NULL, NULL);
INSERT INTO public.clothing VALUES (1277, 'S', 'Guess', 'T-Shirt', 'Red, White', 56, '5518', 14.04, NULL, 38, NULL, 'red flowes', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:12.366175', NULL, NULL);
INSERT INTO public.clothing VALUES (1278, 'S', 'Calvin Klein', 'Vest Jacket', 'Lemon', 56, '0329', 13.62, NULL, 39, NULL, '', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:12.375272', NULL, NULL);
INSERT INTO public.clothing VALUES (1279, 'M', 'Calvin Klein', 'Vest Jacket', 'Lemon', 56, '0312', 13.62, NULL, 39, NULL, '', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:12.383563', NULL, NULL);
INSERT INTO public.clothing VALUES (1284, 'M', 'Calvin Klein', 'Puffy Jacket', 'Gold', 116, '797708', 33.66, NULL, 41, NULL, 'Chest: 60
Waist: 62
Length: 62
Arm: 60', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:12.428283', NULL, NULL);
INSERT INTO public.clothing VALUES (1285, 'M', 'Calvin Klein', 'Puffy Jacket', 'Gold', 116, '797708', 33.66, NULL, 41, NULL, 'Chest: 60
Waist: 62
Length: 62
Arm: 60', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:12.437508', NULL, NULL);
INSERT INTO public.clothing VALUES (1292, 'XS', 'Tommy Hilfiger', 'Sweat Shirt', 'Navy', 56, '792810', 35.00, 50.89, 41, NULL, 'Chest: 45
Waist: 45
Length: 57
Arm: 56', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:12.49896', NULL, NULL);
INSERT INTO public.clothing VALUES (1293, 'XS', 'Tommy Hilfiger', 'Sport Pants', 'Navy', 56, '790779', 0.00, 50.89, 41, NULL, 'Block letters on leg

Waist: 35
Hips: 47
Length: 96
Pasadka: 24', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:12.508123', NULL, NULL);
INSERT INTO public.clothing VALUES (1296, 'XS', 'Banana Republic', 'Long sleeved shirt', 'Red', 56, '400007', 8.00, NULL, 41, NULL, 'Marshalls tag: 080027

Silky, Bows on wrists
Striped red and slightly darker red.

Chest: 47
Waist: 48
Length: 56
Arm: 60', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:12.534506', NULL, NULL);
INSERT INTO public.clothing VALUES (1304, '30', 'Calvin Klein', 'Jeans', 'Blue', 56, '012313', 15.00, NULL, 41, NULL, 'Waist: 43
Hips: 50
Length: 101
Pasadka: 28', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:12.62056', NULL, NULL);
INSERT INTO public.clothing VALUES (1308, 'M', 'Armani Exchange', 'Sport Pants', 'White', 60, '392199', 28.00, 34.39, 41, NULL, 'Grey stripe on side

Waist: 40
Hips: 48
Length: 97
Pasadka: 29', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:12.662628', NULL, NULL);
INSERT INTO public.clothing VALUES (1311, '32', 'Calvin Klein', 'Jeans', 'Blue', 119, '012498', 13.52, NULL, 41, NULL, 'Waist: 43
Hips: 50
Length: 112
Pasadka: 28', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:12.695181', NULL, NULL);
INSERT INTO public.clothing VALUES (1315, 'L', 'Karl Lagerfeld', 'Blouse', 'White', 56, 'P833', 10.79, NULL, 41, NULL, 'Chest: 48
Waist: 51
Length: 61', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:12.7445', NULL, NULL);
INSERT INTO public.clothing VALUES (1321, 'L', 'Calvin Klein', 'Boxers', 'Grey, Blue', 119, '432128', 5.86, NULL, 44, NULL, '2 Pack', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:12.799559', NULL, NULL);
INSERT INTO public.clothing VALUES (1322, 'S', 'Calvin Klein', 'Sweat Shirt', 'Black', 120, '844654', 11.81, NULL, 41, NULL, 'rhine stone calvin klein', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:12.808936', NULL, NULL);
INSERT INTO public.clothing VALUES (1327, 'M', 'Calvin Klein', 'Vest Jacket', 'Lemon', 56, '6093', 22.02, NULL, 41, NULL, '', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:12.853094', NULL, NULL);
INSERT INTO public.clothing VALUES (1328, 'M', 'Armani Exchange', 'Sweat Shirt', 'White', 60, '5092', 30.80, NULL, 41, NULL, '', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:12.862217', NULL, NULL);
INSERT INTO public.clothing VALUES (1338, '32', 'Armani Exchange', 'Pants', 'Navy', 60, '954902', 14.99, NULL, 42, NULL, 'Waist: 45
Hips: 55
Length: 100
Pasadka: 27', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:12.95231', NULL, NULL);
INSERT INTO public.clothing VALUES (1342, 'S', 'Levis', 'Leather Jacket', 'Brown', 56, '802925', 59.99, NULL, 41, NULL, '', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:12.987054', NULL, NULL);
INSERT INTO public.clothing VALUES (1344, 'XS', 'Karl Lagerfeld', 'Sport Pants', 'Black', 56, '121965', 0.00, NULL, 41, NULL, 'Stripe on side', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:13.004961', NULL, NULL);
INSERT INTO public.clothing VALUES (1345, 'XS', 'Karl Lagerfeld', 'Sport Jacket', 'Black', 56, '122207', 0.00, NULL, 41, NULL, 'Stripe on side', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:13.013558', NULL, NULL);
INSERT INTO public.clothing VALUES (1307, 'N/A', 'Tommy Hilfiger', 'Purse', 'Black', 56, '495484', 17.99, NULL, 42, NULL, 'indented TH square design

length: 19
height: 11', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:12.652535', NULL, NULL);
INSERT INTO public.clothing VALUES (1313, 'XS', 'DKNY', 'T-Shirt', 'Silver, White', 56, '177317', 14.98, NULL, 41, NULL, 'Silver chest

Chest: 45
Waist: 45
Length: 58
', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:12.716389', NULL, NULL);
INSERT INTO public.clothing VALUES (1381, 'L', 'Calvin Klein', 'Sweat Pants', 'Black', 125, '529741', 30.37, NULL, 43, NULL, 'White stripe on side

Waist: 42
Hips: 52
Length: 93
Pasadka: 26', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:13.344472', NULL, NULL);
INSERT INTO public.clothing VALUES (1421, 'S', 'Calvin Klein', 'Jean Jacket', 'Blue', 129, '643180', 4.11, NULL, 50, NULL, 'Chest: 51 
Waist: 49
Length: 63
Arm: 63', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:13.737228', NULL, NULL);
INSERT INTO public.clothing VALUES (1423, 'M', 'Calvin Klein', 'Long sleeved shirt', 'White', 129, '794944', 2.01, NULL, 42, NULL, 'Chest: 54
Waist: 50
Length: 74
Arm: 66', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:13.755199', NULL, NULL);
INSERT INTO public.clothing VALUES (1445, 'XS', 'Tommy Hilfiger', 'Sweat Shirt', 'Green', 131, '097550', 7.99, NULL, 42, NULL, 'Diamond pattern

Chest: 42
Waist: 39
Length: 62
Arm: 60', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:13.950133', NULL, NULL);
INSERT INTO public.clothing VALUES (1422, 'L', 'Calvin Klein', 'Long sleeved shirt', 'Navy', 129, '802250', 2.01, NULL, 42, NULL, 'Chest: 58
Length: 72
Arm: 68', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:13.746515', NULL, NULL);
INSERT INTO public.clothing VALUES (1416, 'XS', 'Calvin Klein', 'Long sleeved shirt', 'Light Blue', 128, '485291', 8.83, NULL, 42, NULL, 'Chest: 49
Waist: 46
Length: 65
Arm: 61', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:13.692989', NULL, NULL);
INSERT INTO public.clothing VALUES (1489, 'M', 'Tommy Hilfiger', 'Hoodie', 'Navy', 137, '826140', 19.22, NULL, 44, NULL, 'Zipper on top half with red/white outline

Chest: 60
Waist: 57
Length: 68
Arm: 62', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:14.353273', NULL, NULL);
INSERT INTO public.clothing VALUES (1500, 'S', 'Tommy Hilfiger', 'Long sleeved shirt', 'Navy, White', 138, '047781', 7.49, NULL, 42, NULL, 'White sides
Rolled sleeve

Chest: 48
Waist: 52
Length: 68
Arm: 43', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:14.451525', NULL, NULL);
INSERT INTO public.clothing VALUES (1520, 'N/A', 'Calvin Klein', 'Backpack', 'Gold, White', 56, '701628', 49.99, NULL, 42, NULL, 'TJ maxx # 226399
', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:14.64147', NULL, NULL);
INSERT INTO public.clothing VALUES (1522, 'S', 'Levis', 'Trucker Jacket', 'White, Blue', 56, '920000', 29.99, NULL, 42, NULL, 'Puffy arms and hood
Chest: 49
Waist: 47
Length: 58
Arm: 53', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:14.660252', NULL, NULL);
INSERT INTO public.clothing VALUES (1523, 'N/A', 'Michael Kors', 'Purse', 'Black', 56, '428749', 32.00, NULL, 42, NULL, '', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:14.668601', NULL, NULL);
INSERT INTO public.clothing VALUES (1524, '6', 'Michael Kors', 'Jeans', 'Navy, Gold', 56, '4560', 16.99, NULL, 42, NULL, 'Selma Skinny Higher Rise
Ross Receipt

Waist: 40
Hips: 47
Length: 98
Pasadka: 25', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:14.677822', NULL, NULL);
INSERT INTO public.clothing VALUES (1525, 'L', 'Calvin Klein', 'Sweat Shirt', 'Red', 56, '3931', 24.99, NULL, 42, NULL, 'White stripe on arms

Chest: 47
Waist: 45
Length: 61
Arm: ', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:14.686339', NULL, NULL);
INSERT INTO public.clothing VALUES (1683, '6', 'Levis', 'Puffy Jacket', 'Blue, Red', 56, '737979', 34.99, NULL, 46, 11, 'Kid Clothes', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:16.144162', NULL, NULL);
INSERT INTO public.clothing VALUES (1527, 'M', 'Levis', 'Trucker Jacket', 'Light Blue', 56, '440100', 24.99, NULL, 42, NULL, 'Chest:52
Waist: 50
Length: 60
Arm: 58', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:14.703893', NULL, NULL);
INSERT INTO public.clothing VALUES (1528, 'S', 'Calvin Klein', 'Sweater', 'Black', 56, '715534', 24.99, NULL, 42, NULL, 'Large white letters on chest
"Performance"

Chest: 53
Waist: 53
Length: 54
Arm: 52', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:14.713232', NULL, NULL);
INSERT INTO public.clothing VALUES (1472, 'M', 'Tommy Hilfiger', 'Sweat Shirt', 'White, Green', 136, '053013', 7.99, NULL, 42, NULL, 'Chest: 51
Waist: 49
Length: 65
Arm: 62', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:14.20089', NULL, NULL);
INSERT INTO public.clothing VALUES (1577, 'S', 'Calvin Klein', 'Long sleeved shirt', 'Navy', 143, '802236', 10.21, NULL, 42, NULL, 'Chest: 51
Waist: 49
Length: 68
Arm: 65', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:15.163089', NULL, NULL);
INSERT INTO public.clothing VALUES (1609, 'L', 'Levis', 'T-Shirt', 'Black', 147, '01980L', 7.99, NULL, 45, NULL, 'Red logo on chest

Chest: 52
Waist: 50
Length: 68', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:15.469855', NULL, NULL);
INSERT INTO public.clothing VALUES (1620, '26', 'Calvin Klein', 'Jeans', 'Blue', 56, '??????', 20.00, NULL, 42, NULL, 'Waist: 35
Hips: 42
Length: 96
Pasadka: 24', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:15.5688', NULL, NULL);
INSERT INTO public.clothing VALUES (1621, '28', 'Calvin Klein', 'Jeans', 'Blue', 56, '??????', 20.00, NULL, 42, NULL, 'Repreve

Waist: 36
Hips: 42
Length: 98
Pasadka: 26', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:15.577563', NULL, NULL);
INSERT INTO public.clothing VALUES (1624, 'S', 'Levis', 'Trucker Jacket', 'Blue', 56, '440000', 9.00, NULL, 42, NULL, 'Chest: 49
Waist: 47
Length: 58
Arm: 57', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:15.603557', NULL, NULL);
INSERT INTO public.clothing VALUES (1625, 'M', 'Levis', 'Hoodie', 'Red, Black', 56, '181527', 29.98, NULL, 42, NULL, 'Red logo on chest

Chest: 55
Waist: 52
Length: 67
Arm: ', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:15.612249', NULL, NULL);
INSERT INTO public.clothing VALUES (1644, 'S', 'Calvin Klein', 'Sweat Pants', 'Pink', 56, '701827', 19.99, NULL, 43, NULL, 'Waist: 39
Hips: 48
Length: 95
Pasadka: 26
', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:15.783606', NULL, NULL);
INSERT INTO public.clothing VALUES (1648, 'S', 'Calvin Klein', 'Sweater', 'Pink', 56, '958283', 19.99, NULL, 43, NULL, 'Belly pocket
long neck

Chest: 52
Waist: 50
Length: 64
Arm: 63', false, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:15.82176', NULL, NULL);
INSERT INTO public.clothing VALUES (1651, 'S', 'DKNY', 'Jacket', 'Pink', 56, '457973', 16.99, NULL, 42, NULL, 'For kids/baby

Chest: 33
Waist: 32
Length: 37
Arm:  33', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:15.851393', NULL, NULL);
INSERT INTO public.clothing VALUES (1652, 'N/A', 'Calvin Klein', 'Backpack', 'Brown', 56, '887592', 59.99, NULL, 42, NULL, 'ck pattern all around bag', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:15.860324', NULL, NULL);
INSERT INTO public.clothing VALUES (1653, 'M', 'Calvin Klein', 'Puffy Jacket', 'Gold', 56, '617638', 59.99, NULL, 44, NULL, 'Chest: 53
Waist: 60
Length: 67
Arm: 64', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:15.869134', NULL, NULL);
INSERT INTO public.clothing VALUES (1656, 'XS', 'Levis', 'Hoodie', 'Black', 56, '874211', 69.50, NULL, 49, NULL, 'Silver "LEVI''S" on chest

Chest: 56
Waist: 50
Length: 58
Arm: 48
', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:15.895697', NULL, NULL);
INSERT INTO public.clothing VALUES (1645, 'M', 'Tommy Hilfiger', 'Long sleeved shirt', 'White, Blue', 56, '804155', 12.00, NULL, 43, NULL, 'pinstriped

Chest: 47 
Waist: 46
Length: 67
Arm: 61', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:15.791832', NULL, NULL);
INSERT INTO public.clothing VALUES (1626, 'N/A', 'Guess', 'Purse', 'White', 56, '047062', 11.00, NULL, 42, NULL, 'length: 21
height: 15', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:15.620842', NULL, NULL);
INSERT INTO public.clothing VALUES (1666, '8', 'Karl Lagerfeld', 'Shoes', 'White', 56, '111133', 92.00, 123.21, 44, 22, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:15.993217', NULL, 0.00);
INSERT INTO public.clothing VALUES (1628, 'N/A', 'Guess', 'Wallet', 'Pink', 56, '332060', 15.00, 33.93, 42, 21, 'length: 18
height: 10', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:15.638319', NULL, NULL);
INSERT INTO public.clothing VALUES (1667, 'S', 'Calvin Klein', 'Sport Jacket', 'Red', 56, '714698', 19.99, NULL, 44, NULL, 'Fluffy

Chest: 46
Waist: 45
Length: 61
Arm: 68', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:16.002239', NULL, NULL);
INSERT INTO public.clothing VALUES (1669, 'L', 'Nike', 'Puffy Jacket', 'Black', 56, '197180', 39.99, NULL, 45, NULL, 'Chest: 56
Waist: 57
Length: 61
Arm: 59', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:16.020079', NULL, NULL);
INSERT INTO public.clothing VALUES (1670, 'M', 'North Face', 'Vest Jacket', 'White, Black, Teal', 56, '146929', 49.99, NULL, 45, NULL, 'Chest: 54
Waist: 55
Length: 56
', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:16.028652', NULL, NULL);
INSERT INTO public.clothing VALUES (1671, 'XS', 'Calvin Klein', 'Sweat Shirt', 'Black', 56, '354192', 19.99, NULL, 45, NULL, 'Turtle neck
Red logo square on bottom right

Chest: 51
Waist: 48
Length: 63
Arm: 56', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:16.037372', NULL, NULL);
INSERT INTO public.clothing VALUES (1696, 'M', 'Calvin Klein', 'Sweat Shirt', 'Purple', 56, '689926', 19.99, NULL, 47, NULL, 'Long neck
Belly pocket
small "calvin klein performance" tag on bottom corner

Chest: 52
Waist: 50
Length: 65
Arm: 67', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:16.260019', NULL, NULL);
INSERT INTO public.clothing VALUES (1697, 'L', 'Calvin Klein', 'Sport Jacket', 'Red', 56, '714674', 19.99, NULL, 47, NULL, 'Calvin Klein performance on small tag and arms

Chest: 50
Waist: 48
Length: 66
Arm: ', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:16.269295', NULL, NULL);
INSERT INTO public.clothing VALUES (1698, 'S', 'Tommy Hilfiger', 'Sweat Pants', 'Navy', 148, '790786', 32.03, NULL, 47, NULL, 'Block letters on leg

Waist: 40
Hips: 48
Length: 96
Pasadka: 24', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:16.277672', NULL, NULL);
INSERT INTO public.clothing VALUES (1699, 'XS', 'Tommy Hilfiger', 'Sweat Pants', 'Navy', 148, '790779', 31.99, NULL, 47, NULL, 'Block letters on leg

Waist: 35
Hips: 47
Length: 96
Pasadka: 24', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:16.286971', NULL, NULL);
INSERT INTO public.clothing VALUES (1700, 'M', 'Tommy Hilfiger', 'Sweat Pants', 'Navy', 148, '790793', 31.99, NULL, 47, NULL, 'Block letters on leg

Waist: 41
Hips: 51
Length: 97
Pasadka: 25', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:16.295783', NULL, NULL);
INSERT INTO public.clothing VALUES (1701, 'S', 'Tommy Hilfiger', 'Sweat Pants', 'Blue', 148, '436274', 31.99, NULL, 47, NULL, 'Cursive letters on waist

Waist: 39
Hips: 49
Length: 93
Pasadka: 26', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:16.305056', NULL, NULL);
INSERT INTO public.clothing VALUES (1702, 'S', 'Tommy Hilfiger', 'Sweat Shirt', 'Blue', 148, '431484', 27.99, NULL, 47, NULL, 'Cursive letters on chest

Chest: 49
Waist: 48
Length: 61
Arm: 60', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:16.313814', NULL, NULL);
INSERT INTO public.clothing VALUES (1703, 'S', 'Tommy Hilfiger', 'Sweat Pants', 'Navy', 148, '790786', 31.99, NULL, 47, NULL, 'Block letters on leg

Waist: 40
Hips: 48
Length: 96
Pasadka: 24', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:16.32238', NULL, NULL);
INSERT INTO public.clothing VALUES (1704, 'S', 'DKNY', 'Hoodie', 'Black', 56, '192827', 24.99, NULL, 48, NULL, 'Rainbow letters on chest + "sport"

Chest: 56
Waist: 53
Length: 66
Arm: 59', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:16.331641', NULL, NULL);
INSERT INTO public.clothing VALUES (1706, 'L', 'Calvin Klein', 'Sweat Pants', 'Black', 56, '640333', 0.00, NULL, 48, NULL, 'calvin klein taped stripe on side

Waist: 46
Hips: 54
Length: 104
Pasadka: 31', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:16.349459', NULL, NULL);
INSERT INTO public.clothing VALUES (1707, 'S', 'Calvin Klein', 'Sweat Pants', 'White', 56, '790661', 19.99, NULL, 48, NULL, 'words down leg
"calvin klein performance" square

Waist: 40
Hips: 49
Length: 97
Pasadka: 25', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:16.357543', NULL, NULL);
INSERT INTO public.clothing VALUES (1672, 'S', 'Armani Exchange', 'T-Shirt', 'White', 56, '987100', 0.00, NULL, 45, NULL, 'Deep V neck
Negative-spaced logo on chest

Chest:39 
Waist: 36
Length: 59', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:16.04631', NULL, NULL);
INSERT INTO public.clothing VALUES (1694, 'M', 'Calvin Klein', 'Sweat Pants', 'Black', 56, '687084', 19.99, NULL, 47, NULL, 'Calvin Klein on calf

Waist: 42
Hips: 50
Length: 93
Pasadka: 27', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:16.242078', NULL, NULL);
INSERT INTO public.clothing VALUES (1705, 'L', 'Calvin Klein', 'Sweat Pants', 'Purple', 56, '790111', 19.99, NULL, 48, NULL, 'Words on calf

Waist: 45
Hips: 51
Length: 94
Pasadka: 26', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:16.340336', NULL, NULL);
INSERT INTO public.clothing VALUES (1709, 'L', 'Calvin Klein', 'Sweat Pants', 'White', 56, '790647', 19.99, NULL, 48, NULL, 'words down leg
"calvin klein performance" square

Waist: 46
Hips: 53
Length: 101
Pasadka: 28', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:16.375605', NULL, NULL);
INSERT INTO public.clothing VALUES (1711, 'M', 'Calvin Klein', 'Sweat Pants', 'Black', 56, '687121', 19.99, NULL, 48, NULL, 'words on calf

Waist: 40
Hips: 50
Length: 93
Pasadka: 25', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:16.399687', NULL, NULL);
INSERT INTO public.clothing VALUES (1712, 'N/A', 'Tommy Hilfiger', 'Wallet', 'Black', 56, '239286', 15.00, NULL, 49, NULL, '', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:16.413786', NULL, NULL);
INSERT INTO public.clothing VALUES (1713, 'N/A', 'Tommy Hilfiger', 'Wallet', 'Black', 56, '629339', 15.00, NULL, 49, NULL, '', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:16.422765', NULL, NULL);
INSERT INTO public.clothing VALUES (1715, 'S', 'Tommy Hilfiger', 'Sweat Pants', 'Navy', 56, '790786', 32.00, NULL, 49, NULL, 'Block letters on leg

Waist: 40
Hips: 48
Length: 96
Pasadka: 24', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:16.444724', NULL, NULL);
INSERT INTO public.clothing VALUES (1716, 'XXS', 'Karl Lagerfeld', 'Sport Jacket', 'White, Black', 149, '295997', 76.65, NULL, 49, NULL, 'white stripes
Karl Lagerfeld Paris on arms

Chest: 47
Waist: 46
Length: 61
Arm: 59', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:16.454041', NULL, NULL);
INSERT INTO public.clothing VALUES (1497, 'N/A', 'Tommy Hilfiger', 'Fanny Pack', 'Pink', 138, '868946', 11.90, NULL, 57, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:14.424893', NULL, 0.00);
INSERT INTO public.clothing VALUES (1368, 'S', 'Calvin Klein', 'T-Shirt', 'Black', 56, '375318', 9.99, NULL, 62, NULL, 'Ross tag: 402423
White + Silver letters

Chest: 42
Waist: 42
Length: 60
', false, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:13.227938', NULL, 0.00);
INSERT INTO public.clothing VALUES (1028, 'XXS', 'Tommy Hilfiger', 'Sweat Shirt', 'Red, White, Navy, Blue, Green', 80, '426579', 15.99, NULL, 65, NULL, 'green arm
blue arm,
navy bottom
red boob
white boob', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:10.05888', NULL, 0.00);
INSERT INTO public.clothing VALUES (894, 'M', 'Armani Exchange', 'T-Shirt', 'White', 60, '138025', 20.99, NULL, 37, NULL, 'angel wings

chest: 43
waist: 40
length: 64', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:08.762241', NULL, NULL);
INSERT INTO public.clothing VALUES (881, 'M', 'Calvin Klein', 'Man Panties', 'Black', 58, '051336', 6.71, NULL, 44, NULL, '4 pair', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:08.63838', NULL, NULL);
INSERT INTO public.clothing VALUES (1295, 'S', 'Calvin Klein', 'Dress', 'Black', 56, '811212', 19.99, NULL, 41, NULL, 'Other tag: 487470

Silver Rhinestone square on chest

Chest: 45
Hips: 41
Length: 88', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:12.525606', NULL, NULL);
INSERT INTO public.clothing VALUES (1287, 'N/A', 'Guess', 'Fanny Pack', 'Pink', 56, '328346', 19.93, NULL, 41, NULL, 'length: 28
height: 14', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:12.454978', NULL, NULL);
INSERT INTO public.clothing VALUES (1341, '32', 'Armani Exchange', 'Jeans', 'Grey', 60, '955008', 14.99, NULL, 41, NULL, 'style 32r

waist: 43
hips: 53
pasadka: 27
length: 105', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:12.978498', NULL, NULL);
INSERT INTO public.clothing VALUES (1310, '32X30', 'Calvin Klein', 'Jeans', 'Blue', 119, '012337', 13.51, NULL, 41, NULL, 'model number ckg035
american classics
Waist: 43
Hips: 50
Length: 101
Pasadka: 28', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:12.684714', NULL, NULL);
INSERT INTO public.clothing VALUES (1404, 'S', 'Calvin Klein', 'Man Panties', 'Grey, White, Black', 56, '051244', 0.00, NULL, 44, NULL, '4 pack', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:13.568877', NULL, NULL);
INSERT INTO public.clothing VALUES (1499, 'N/A', 'Tommy Hilfiger', 'Fanny Pack', 'Red', 138, '788745', 16.87, NULL, 42, NULL, 'length: 30
height: 14', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:14.443099', NULL, NULL);
INSERT INTO public.clothing VALUES (1481, 'N/A', 'Tommy Hilfiger', 'Purse', 'Black', 137, '137352', 11.99, NULL, 42, NULL, 'red/white/blue/black half stripes on front

length: 24
height: 16', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:14.281048', NULL, NULL);
INSERT INTO public.clothing VALUES (1627, 'N/A', 'Guess', 'Wallet', 'Pink', 56, '332084', 15.00, NULL, 42, NULL, 'small square
length: 12
height: 10', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:15.629495', NULL, NULL);
INSERT INTO public.clothing VALUES (1252, 'M', 'Michael Kors', 'T-Shirt', 'Black', 56, '033195', 21.60, NULL, 37, NULL, 'Large gold letters - 
Men
            
chest: 52
length: 72', true, 'men', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:12.144193', NULL, 0.00);
INSERT INTO public.clothing VALUES (864, 'S', 'Calvin Klein', 'Sleepy Pants', 'Black', 58, '899407', 9.89, 32.14, 43, 22, 'Stripe on side

Waist: 39
Length: 100
Lapatka: 30', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:08.481621', NULL, NULL);
INSERT INTO public.clothing VALUES (1006, 'XS', 'Tommy Hilfiger', 'Hoodie', 'Black', 77, '448809', 21.59, 44.64, 41, 22, 'Chest: 50
Waist: 50
Length: 68
Arm: 54', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:09.852759', NULL, NULL);
INSERT INTO public.clothing VALUES (1354, 'M', 'Armani Exchange', 'Dress Shirt', 'White', 124, '495972', 13.99, 44.64, 43, 21, 'Chest: 49
Waist: 50
Length: 68
Arm:', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:13.093385', NULL, NULL);
INSERT INTO public.clothing VALUES (1425, 'M', 'Calvin Klein', 'Long sleeved shirt', 'Navy', 129, '802243', 2.01, NULL, 42, NULL, 'Chest: 53
Waist: 51
Length: 72
Arm: 67', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:13.772749', NULL, NULL);
INSERT INTO public.clothing VALUES (1474, 'XS', 'Tommy Hilfiger', 'Sweat Shirt', 'Grey, White', 136, '838907', 7.99, NULL, 42, NULL, 'diamond pattern

Chest: 43
Waist: 37
Length: 61
Arm: 60', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:14.218842', NULL, NULL);
INSERT INTO public.clothing VALUES (1647, 'S', 'Calvin Klein', 'Sweater', 'Tan, Black', 56, '958283', 0.00, NULL, 43, NULL, 'Black stripe on one arm
Belly pocket

Chest: 56
Waist: 53
Length: 56
Arm:  46', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:15.812071', NULL, NULL);
INSERT INTO public.clothing VALUES (700, 'M', 'Tommy Hilfiger', 'Windbreaker', 'White', 46, '912157', 56.02, NULL, 33, NULL, '2 jackets in 1

Chest: 52
Waist: 49
Length: 75
Arm: 73', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.791563', NULL, NULL);
INSERT INTO public.clothing VALUES (1695, 'M', 'Calvin Klein', 'Sweat Shirt', 'Black', 56, '687169', 24.99, NULL, 47, NULL, 'Long neck
Big white letters on chest
small "calvin klein performance" tag on bottom corner

Chest: 61
Waist: 51
Length: 61
Arm: 43', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:16.251293', NULL, NULL);
INSERT INTO public.clothing VALUES (1708, 'M', 'Calvin Klein', 'Sweat Pants', 'White', 56, '790654', 19.99, NULL, 48, NULL, 'words down leg
"calvin klein performance" square

Waist: 44
Hips: 50
Length: 98
Pasadka: 25', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:16.367401', NULL, NULL);
INSERT INTO public.clothing VALUES (1664, 'XS', 'Levis', 'Sherpa', 'Navy', 56, '626255', 29.99, NULL, 44, NULL, 'Fluffy inside

Chest: 45
Waist: 42
Length: 59
Arm: 55', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:15.975807', NULL, NULL);
INSERT INTO public.clothing VALUES (1710, 'M', 'Calvin Klein', 'Sweat Pants', 'Black', 56, '687121', 19.99, NULL, 48, NULL, 'words on calf

Waist: 40
Hips: 50
Length: 93
Pasadka: 25', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:16.385149', NULL, NULL);
INSERT INTO public.clothing VALUES (1714, 'M', 'Calvin Klein', 'Sport Jacket', 'Red', 56, '714681', 19.99, NULL, 49, NULL, 'Calvin Klein Performance tag

Chest: 48
Waist: 46
Length: 61
Arm:', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:16.431325', NULL, NULL);
INSERT INTO public.clothing VALUES (1657, 'M', 'Michael Kors', 'Puffy Jacket', 'Black', 56, '147343', 69.99, NULL, 44, NULL, 'Puffy hood

Chest: 53
Waist: 47
Hips: 58
Length: 91
Arm: 64
', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:15.904497', NULL, NULL);
INSERT INTO public.clothing VALUES (1663, 'M', 'Calvin Klein', 'Rain Coat', 'Black', 56, '602827', 79.99, NULL, 44, NULL, 'Hooded, long with belt

Zipper on top half with red/white outline

Chest: 52 
Waist: 38
Length: 83
Arm: ', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:15.967206', NULL, NULL);
INSERT INTO public.clothing VALUES (1521, 'M', 'Tommy Hilfiger', 'Rain Coat', 'Red, White, Blue', 56, '482843', 59.99, NULL, 42, NULL, 'Chest: 54
Waist: 52
Length: 69
Arm: 67', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:14.650979', NULL, NULL);
INSERT INTO public.clothing VALUES (1276, 'M', 'Calvin Klein', 'Polo Shirt', 'White, Black', 56, '880332', 21.60, NULL, 38, NULL, 'white chest', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:12.357629', NULL, NULL);
INSERT INTO public.clothing VALUES (1309, '31X30', 'Calvin Klein', 'Jeans', 'Blue', 118, '012320', 13.51, NULL, 41, NULL, 'model number ckg035
american classics
Waist: 43
Hips: 49
Length: 100
Pasadka: 28', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:12.674324', NULL, NULL);
INSERT INTO public.clothing VALUES (988, '32X32', 'Tommy Hilfiger', 'Jeans', 'Blue', 74, '397541', 12.99, NULL, 36, NULL, 'stretch skinny
waist: 41
hips: 50
pasadka: 27
length: 102', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:09.679595', NULL, NULL);
INSERT INTO public.clothing VALUES (1092, 'M', 'Calvin Klein', 'T-Shirt', 'Pink', 87, '860524', 6.13, NULL, 63, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:10.651744', NULL, 0.00);
INSERT INTO public.clothing VALUES (1335, 'XS', 'Armani Exchange', 'Jean Jacket', 'Black', 60, '579759', 29.99, NULL, 81, NULL, 'glittery

chest: 46
length: 64
arm: 57
shoulders: 45', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:12.925899', NULL, 0.00);
INSERT INTO public.clothing VALUES (2899, '---', 'Tommy Hilfiger', 'Pants', '---', 228, '025658', 11.47, 15.50, 94, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 05:43:41.196499', NULL, 0.00);
INSERT INTO public.clothing VALUES (866, 'M', 'Calvin Klein', 'Panties', 'Pink', 58, '92903', 3.40, 4.64, 52, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:08.499893', NULL, 0.00);
INSERT INTO public.clothing VALUES (919, 'M', 'Levis', 'T-Shirt', 'Red, Navy', 56, '3174', 8.00, NULL, 36, NULL, '', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:09.028034', NULL, NULL);
INSERT INTO public.clothing VALUES (920, 'L', 'Levis', 'T-Shirt', 'Black, Red', 56, '2750', 8.00, NULL, 36, NULL, '', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:09.036897', NULL, NULL);
INSERT INTO public.clothing VALUES (2898, '---', 'Tommy Hilfiger', 'Pants', '---', 228, '025689', 11.47, 15.50, 94, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 05:43:31.644792', NULL, 0.00);
INSERT INTO public.clothing VALUES (1650, 'S', 'DKNY', 'Jacket', 'Black', 56, '457973', 19.99, NULL, 42, NULL, 'Chest: 41
Waist: 41
Length: 47
Arm:  47', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:15.842006', NULL, NULL);
INSERT INTO public.clothing VALUES (872, 'M', 'Calvin Klein', 'Sport Bra', 'Purple', 58, '126899', 6.12, 8.36, 52, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:08.55477', NULL, 0.00);
INSERT INTO public.clothing VALUES (1668, 'M', 'Armani Exchange', 'Jean Jacket', 'Navy', 56, '453170', 30.00, NULL, 44, NULL, 'Chest: 46
Waist: 46
Length: 64
Arm: 64', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:16.010798', NULL, NULL);
INSERT INTO public.clothing VALUES (2133, 'S', 'Tommy Hilfiger', 'Golfik', 'Purple', 165, '129850', 8.00, 10.88, 64, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-16 18:59:37.53034', NULL, 0.00);
INSERT INTO public.clothing VALUES (1987, 'L', 'Tommy Hilfiger', 'Golfik', 'White', 153, '130245', 10.00, 13.59, 56, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 11:37:06.66699', NULL, 0.00);
INSERT INTO public.clothing VALUES (2143, 'N/A', 'Calvin Klein', 'Purse', 'Black', 167, '407460', 29.99, NULL, 71, NULL, 'length: 19
height: 12', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-16 19:15:07.366936', NULL, 0.00);
INSERT INTO public.clothing VALUES (2544, 'L', 'Tommy Hilfiger', 'T-Shirt', 'Black', 207, '307357', 12.99, 17.50, 89, 9, 'block letter "tommy hilfiger" on chest
chest: 54
length: 66', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-15 04:21:06.661087', NULL, 0.00);
INSERT INTO public.clothing VALUES (404, 'S', 'Calvin Klein', 'Sweat Pants', 'Black', NULL, '957125', 19.99, NULL, 60, NULL, 'long calvin klein sign

waist: 37
hips: 48
length: 98
pasadka: 24', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.193364', NULL, 0.00);
INSERT INTO public.clothing VALUES (1312, '30X32', 'Calvin Klein', 'Jeans', 'Blue', 118, '012412', 13.52, 59.79, 41, 23, 'model number ckg035
american classics

Waist: 40
Hips: 48
Length: 105
Pasadka: 27', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:12.706513', NULL, NULL);
INSERT INTO public.clothing VALUES (2038, 'L', 'Armani Exchange', 'Dress Shirt', 'White', 156, '415300', 9.99, 13.61, 64, 9, NULL, NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-01-08 13:25:07.401324', NULL, 0.00);
INSERT INTO public.clothing VALUES (2315, '14-16', 'DKNY', 'Jacket', 'Pink', NULL, '457935', 19.99, NULL, 105, NULL, 'kids clothes
bomber
with hood
black wrists with white dkny
black DKNY on chest

chest: 46
length: 55
arm: 55', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-27 16:30:27.78113', NULL, 3.42);
INSERT INTO public.clothing VALUES (2412, 'L', 'Tommy Hilfiger', 'T-Shirt', 'White', 192, '437689', 8.00, NULL, NULL, NULL, 'for mom', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-07 22:10:42.005572', NULL, 0.00);
INSERT INTO public.clothing VALUES (2423, 'M', 'Tommy Hilfiger', 'Sweater', 'Burgundy', 195, '394673', 15.99, NULL, NULL, NULL, 'chest: 57
length: 67
arm: 67
', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-02-07 22:29:08.938558', NULL, 0.00);
INSERT INTO public.clothing VALUES (2427, 'XXS', 'Tommy Hilfiger', 'Dress', 'Pink', 195, '448802', 14.39, NULL, NULL, NULL, 'chest: 44
length: 63/67
arm: 59
', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-07 22:38:17.08307', NULL, 0.00);
INSERT INTO public.clothing VALUES (2426, 'L', 'Tommy Hilfiger', 'Free Sweater', 'Navy', 195, '415965', 15.99, NULL, 76, NULL, 'chest: 55
length: 76
arm: 74', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-02-07 22:33:07.225044', NULL, 0.00);
INSERT INTO public.clothing VALUES (2729, 'XL', 'Tommy Hilfiger', 'Sweat Pants', 'Pink, Peach, Salmon', 225, '006578', 0.00, NULL, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-01 01:03:05.938712', NULL, NULL);
INSERT INTO public.clothing VALUES (2268, 'L', 'Tommy Hilfiger', 'Vest Jacket', 'Blue', 179, '403603', 16.01, 0.00, 67, 9, NULL, NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-01-23 19:32:03.861139', NULL, 0.00);
INSERT INTO public.clothing VALUES (1438, 'L', 'Tommy Hilfiger', 'Long Sleeved Shirt', 'Blue', 131, '718407', 7.99, 39.86, 44, 22, 'Red + white square logo on boob

Chest: 58
Waist: 55
Length: 75
Arm: 66', true, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:13.888084', NULL, 0.00);
INSERT INTO public.clothing VALUES (2782, 'S', 'Calvin Klein', 'Shorts', 'Black', 226, '719227', 14.99, NULL, 117, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-01 06:13:45.480204', NULL, NULL);
INSERT INTO public.clothing VALUES (2284, 'N/A', 'Calvin Klein', 'Wallet', 'Black', 182, '297731', 9.99, 35.00, 74, 22, 'length: 11
height: 8.5', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-23 21:36:25.122795', NULL, 0.00);
INSERT INTO public.clothing VALUES (1659, 'S', 'Levis', 'Sherpa', 'Navy', 56, '192682', 29.99, 58.93, 44, 22, 'Chest: 50
Waist: 48
Length: 58
Arm: 56', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:15.922029', NULL, NULL);
INSERT INTO public.clothing VALUES (2385, 'M', 'Calvin Klein', 'Dress', 'White', 191, '404377', 24.99, NULL, 121, NULL, 'red sign on chest
chest: 52
length: 91
arm: 63
', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-07 21:06:12.890889', NULL, 0.00);
INSERT INTO public.clothing VALUES (1718, 'S', 'Calvin Klein', 'Sweat Shirt', 'Black', 56, '687176', 24.99, 50.00, 50, 21, 'Long neck, "performance" tag
large white "Calvin" on chest

Chest: 58
Waist: 50
Length: 57
Arm: 43', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:16.472007', NULL, NULL);
INSERT INTO public.clothing VALUES (2400, '6', 'Tommy Hilfiger', 'Flip Flops', 'Black', 193, '859438', 14.99, NULL, 84, NULL, 'length: 23.5
', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-07 21:45:32.112502', NULL, 0.00);
INSERT INTO public.clothing VALUES (2584, 'L', 'Calvin Klein', 'Sweat Pants', 'Black', 211, '503834', 19.99, 27.02, 89, 9, 'lowercase calvin klein on side with white dot

waist: 42
hips: 52
pasadka: 26
length: 96', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-18 02:52:03.14472', NULL, 0.00);
INSERT INTO public.clothing VALUES (2434, 'S', 'Calvin Klein', 'T-Shirt', 'Black', 197, '803651', 13.08, NULL, NULL, NULL, 'payetki sign on chest

chest: 43
length: 64', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-07 23:31:55.553678', NULL, 0.00);
INSERT INTO public.clothing VALUES (2448, 'M', 'Levis', 'Sherpa', 'Blue', 200, '772861', 38.99, NULL, NULL, NULL, 'Trucker Jacket

Chest: 50
length: 55
arm: 61', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-07 23:53:07.144996', NULL, 0.00);
INSERT INTO public.clothing VALUES (2449, '26', 'Levis', 'Jeans', 'Navy', 200, '855874', 29.99, NULL, NULL, NULL, 'With Corset

waist: 38
Hips: 49
length to waist: 89
length to end of pants: 99', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-07 23:56:05.792159', NULL, 0.00);
INSERT INTO public.clothing VALUES (2465, 'M', 'Calvin Klein', 'Sweat Pants', 'Cream', 201, '474387', 19.99, NULL, NULL, NULL, 'white Calvin klein jeans on side

waist: 42
Hips: 53
Length: 95
Pasadka: 28
', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-08 00:22:26.321271', NULL, 0.00);
INSERT INTO public.clothing VALUES (2452, 'XS', 'Levis', 'Hoodie', 'Black', 200, '007898', 16.18, NULL, NULL, NULL, 'Green Purple Circle

chest: 51
length: 64
arm from neck: 69', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-08 00:00:38.159804', NULL, 0.00);
INSERT INTO public.clothing VALUES (2468, 'M', 'Michael Kors', 'Sweat Pants', 'Black, White', 201, '196632', 34.99, NULL, 77, NULL, 'White letters everywhere

waist: 39
hips: 50
pasadka: 36
length: 108', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-08 00:27:09.211833', NULL, 0.00);
INSERT INTO public.clothing VALUES (2483, 'S', 'Tommy Hilfiger', 'Jacket', 'Black, Red', NULL, '346102', 25.00, NULL, NULL, NULL, 'Costco
3 in 1
chest: 51
length: 71
arm: 63', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-08 00:52:33.256043', NULL, 0.00);
INSERT INTO public.clothing VALUES (2484, 'M', 'Calvin Klein', 'Hoodie', 'Black', 192, '346102', 14.99, NULL, NULL, NULL, 'Fleece
small ck on chest

chest: 57
length: 69
arm: 66', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-08 00:55:50.292118', NULL, 0.00);
INSERT INTO public.clothing VALUES (2485, 'M', 'Calvin Klein', 'Hoodie', 'Black', 192, '346102', 14.99, NULL, NULL, NULL, 'Fleece
small ck on chest

chest: 57
length: 69
arm: 66', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-08 00:58:09.368949', NULL, NULL);
INSERT INTO public.clothing VALUES (2479, 'XS', 'Tommy Hilfiger', 'Vest Jacket', 'Navy', 201, '086999', 24.99, NULL, NULL, NULL, 'chest: 46
length: 56', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-08 00:44:06.384975', NULL, 0.00);
INSERT INTO public.clothing VALUES (2487, 'S', 'Calvin Klein', 'Sweat Pants', 'Grey', 194, '503773', 19.99, NULL, NULL, NULL, 'waist: 39
hips: 48
pasadka: 26
length: 93', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-08 01:02:56.240708', NULL, NULL);
INSERT INTO public.clothing VALUES (2496, 'M', 'Reebok', 'Trucker Jacket', 'Black', NULL, '123456789', 19.99, NULL, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-08 06:20:34.336102', NULL, NULL);
INSERT INTO public.clothing VALUES (2784, '4', 'Calvin Klein', 'Dress', 'White', 227, '441068', 29.99, NULL, NULL, NULL, 'chest: 48
length: 118
', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-01 06:21:03.435358', NULL, NULL);
INSERT INTO public.clothing VALUES (2473, 'S', 'Michael Kors', 'Sweat Pants', 'White', 201, '450642', 29.99, NULL, 84, NULL, 'black mk down sides

waist: 36
hips: 49
length: 98
pasadka: 27', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-08 00:33:27.475651', NULL, 0.00);
INSERT INTO public.clothing VALUES (71, 'L', 'Calvin Klein', 'Sweat Pants', 'Red', 9, '764963', 17.21, 23.18, 53, 9, 'Men
Grey "CK" + white "Calvin Klein Jeans" on pocket

Waist: 50
Hips: 58
Length: 107
Pasadka: 31', true, 'men', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.260181', NULL, 0.00);
INSERT INTO public.clothing VALUES (2257, 'XS', 'Calvin Klein', 'Jacket', 'Black', 178, '015313', 14.53, NULL, NULL, NULL, 'double sided
(black on other side)

chest: 51
length: 60
arm: 62', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-01-22 12:50:53.199335', NULL, 0.00);
INSERT INTO public.clothing VALUES (2503, '2X36', 'Levis', 'Skirt', 'Blue', 203, '418189', 8.98, NULL, NULL, NULL, 'waist: 34
hips: 46
length: 43', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-11 23:35:32.048064', NULL, NULL);
INSERT INTO public.clothing VALUES (95, 'M', 'Calvin Klein', 'Sweater', 'White', NULL, '792320', 24.99, NULL, NULL, NULL, 'Long neck
Black "Calvin" on chest

Chest: 64
Waist: 53
Length: 61
Arm: 40', true, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.46385', NULL, 0.00);
INSERT INTO public.clothing VALUES (2526, 'XS', 'Michael Kors', 'Puffy Jacket', 'Black', 204, '101406', 44.99, NULL, NULL, NULL, 'Glossy

chest: 49
length: 69
arm: 62
shoulders: 40', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-13 02:26:48.962824', NULL, NULL);
INSERT INTO public.clothing VALUES (2499, 'M', 'Calvin Klein', 'Bodysuit', 'White', NULL, '079421', 0.00, NULL, 78, NULL, 'chest: 40
length 77', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-09 19:40:20.877822', NULL, NULL);
INSERT INTO public.clothing VALUES (2534, 'M', 'Calvin Klein', 'Sweat Pants', 'Blue', 205, '474530', 19.99, NULL, NULL, NULL, 'blue like jeans

waist: 41
hips: 53
pasadka: 27
length: 95
', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-13 02:48:16.506146', NULL, NULL);
INSERT INTO public.clothing VALUES (2549, 'M', 'Calvin Klein', 'T-Shirt', 'Black', 207, '534982', 12.99, NULL, 84, NULL, 'white calvin on chest
chest: 48
length: 62', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-15 04:26:07.389822', NULL, 0.00);
INSERT INTO public.clothing VALUES (2568, '4', 'Tommy Hilfiger', 'Dress', 'Green', 209, '198771', 23.62, NULL, NULL, NULL, 'chest: 46
length: 100', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-15 04:45:47.033661', NULL, NULL);
INSERT INTO public.clothing VALUES (2575, 'XS', 'Calvin Klein', 'Sweat Shirt', 'Grey', NULL, '826735', 25.00, NULL, NULL, NULL, 'white calvin on chest', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-15 04:56:47.93448', NULL, NULL);
INSERT INTO public.clothing VALUES (2540, 'N/A', 'Michael Kors', 'Purse', 'White', 206, '056844', 39.60, NULL, NULL, NULL, 'grey MK everywhere

width: 24
height: 17', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-15 04:07:22.383981', NULL, 0.00);
INSERT INTO public.clothing VALUES (2530, 'M', 'Bebe', 'Sweat Pants', 'Black', 204, '618729', 14.99, NULL, 84, NULL, 'rose-gold letters

waist: 39
hips: 51
pasadka: 27
length: 100', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-13 02:32:09.309843', NULL, 0.00);
INSERT INTO public.clothing VALUES (2444, '2', 'Calvin Klein', 'Satin Dress', 'Black', 199, '646355', 7.93, NULL, 107, NULL, 'chest: 46
hips: 48
length: 110', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-07 23:48:30.190471', NULL, 0.00);
INSERT INTO public.clothing VALUES (2574, 'S', 'DKNY', 'Hoodie', 'Black', 210, '028247', 19.99, NULL, 107, NULL, 'DKNY on belly
chest: 51
length: 68
arm: 63', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-02-15 04:55:25.921835', NULL, NULL);
INSERT INTO public.clothing VALUES (2554, 'M', 'Calvin Klein', 'Leggings', 'Black', 207, '423439', 19.99, 26.92, 109, 9, 'grey letters

waist: 35
hips: 43
pasadka: 26
length: 80', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-15 04:32:49.114858', NULL, NULL);
INSERT INTO public.clothing VALUES (2446, 'XS', 'Calvin Klein', 'T-Shirt', 'Black', 199, '803668', 9.15, 30.36, NULL, 23, 'payetki sign on chest

chest: 40
length: 62', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-07 23:49:31.614069', NULL, 0.00);
INSERT INTO public.clothing VALUES (2435, 'M', 'Calvin Klein', 'T-Shirt', 'Black', 197, '803644', 11.08, 30.36, 76, 22, 'payetki sign on chest

chest: 48
length: 64', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-07 23:34:33.951729', NULL, 0.00);
INSERT INTO public.clothing VALUES (2488, 'M', 'Calvin Klein', 'Blouse', 'Black', 191, '474035', 19.99, NULL, 110, NULL, 'chest: 54
length: 64/70
arm: 60', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-08 01:03:55.950421', NULL, NULL);
INSERT INTO public.clothing VALUES (2491, 'M', 'Calvin Klein', 'Shorts', 'Grey', 202, '975664', 12.99, NULL, 114, NULL, 'waist: 38
hips: 54', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-02-08 01:07:32.560363', NULL, NULL);
INSERT INTO public.clothing VALUES (2492, 'L', 'Calvin Klein', 'Shorts', 'Grey', 202, '975671', 12.99, NULL, 114, NULL, 'waist: 40
hips: 58
length: 49', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-02-08 01:08:11.576423', NULL, NULL);
INSERT INTO public.clothing VALUES (2438, 'XS', 'Calvin Klein', 'Hoodie', 'White', 197, '962082', 14.78, NULL, 127, NULL, 'cropped
oversized
white payetki sign on chest

chest: 52
length: 49', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-07 23:36:56.136839', NULL, 0.00);
INSERT INTO public.clothing VALUES (2841, 'S', 'Tommy Hilfiger', 'Blazer', 'Navy', NULL, '235902', 24.99, 57.14, NULL, 22, 'на пуговицах', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-04 03:06:46.637808', NULL, NULL);
INSERT INTO public.clothing VALUES (2528, 'S', 'DKNY', 'Sweat Shirt', 'White', 204, '525464', 17.99, NULL, 121, NULL, 'black DKNY on chest

chest: 57
length: 54
arm: 50/73', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-13 02:29:35.213583', NULL, NULL);
INSERT INTO public.clothing VALUES (2430, 'XS', 'Calvin Klein', 'Jacket', 'White, Black', 197, '014309', 29.61, NULL, 121, NULL, 'cold sleeves

chest: 45
length: 61/65
arm: 70', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-07 23:27:52.741235', NULL, 0.00);
INSERT INTO public.clothing VALUES (2597, 'XXS', 'Tommy Hilfiger', 'Hoodie', 'Pink', 212, '432160', 28.00, 53.57, 105, 22, 'chest: 43
length: 52
arm: 61', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-18 03:04:16.830946', NULL, 0.00);
INSERT INTO public.clothing VALUES (2466, 'S', 'Michael Kors', 'Sweat Pants', 'Black, White', 201, '196625', 34.99, NULL, 122, NULL, 'White letters everywhere

waist: 37
hips: 47
pasadka: 32
length: 107', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-08 00:25:06.042209', NULL, 0.00);
INSERT INTO public.clothing VALUES (2598, 'XS', 'Tommy Hilfiger', 'Free Sweater', 'Black', 212, '415729', 15.99, NULL, 105, NULL, 'chest: 48
length: 64
arm: 65', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-18 03:05:12.305907', NULL, 0.00);
INSERT INTO public.clothing VALUES (2585, 'S', 'Calvin Klein', 'Sweat Pants', 'Black', 211, '503858', 19.99, NULL, NULL, NULL, 'lowercase calvin klein on side with white dot

waist: 39
hips: 49
pasadka: 24
length: 93', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-18 02:53:03.572113', NULL, NULL);
INSERT INTO public.clothing VALUES (2587, 'M', 'Calvin Klein', 'Sweat Pants', 'Black', 211, '503841', 19.99, NULL, NULL, NULL, 'lowercase calvin klein on side with white dot

waist: 40
hips: 51
pasadka: 27
length: 94', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-18 02:54:15.440839', NULL, NULL);
INSERT INTO public.clothing VALUES (2588, 'M', 'Calvin Klein', 'Hoodie', 'Black', 211, '827848', 24.99, NULL, NULL, NULL, 'pink sign "calvin"

chest: 57
length: 53
arm: 69', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-18 02:54:57.958723', NULL, 0.00);
INSERT INTO public.clothing VALUES (557, '???', 'Michael Kors', 'Sweater', 'Blue', NULL, '??????', 21.99, NULL, 16, NULL, 'black gummy stripe on arm', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.525536', NULL, NULL);
INSERT INTO public.clothing VALUES (2570, 'M', 'Michael Kors', 'Polo Shirt', 'Black', 210, '773679', 19.99, 39.29, 105, 23, 'Chest 53
length: 70', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-02-15 04:51:06.417689', NULL, 0.00);
INSERT INTO public.clothing VALUES (2356, 'XS', 'Calvin Klein', 'T-Shirt', 'Black', 188, '855780', 12.74, 28.57, 78, 23, 'Gold stones "calvin klein"

chest: 42
length: 61', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-31 15:13:02.155402', NULL, 0.00);
INSERT INTO public.clothing VALUES (2615, 'XS', 'Tommy Hilfiger', 'T-Shirt', 'White', 214, '476355', 7.87, NULL, NULL, NULL, 'New york bridge on chest
chest: 46
length: 60', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-22 07:02:56.508314', NULL, NULL);
INSERT INTO public.clothing VALUES (2617, 'XS', 'Tommy Hilfiger', 'T-Shirt', 'White', 214, '466929', 6.47, NULL, NULL, NULL, 'rhinestone logo
chest: 41
length: 63', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-22 07:03:49.192938', NULL, NULL);
INSERT INTO public.clothing VALUES (2527, 'S', 'DKNY', 'Sweat Shirt', 'Blue', 204, '156045', 19.99, NULL, 83, NULL, 'black line across chest
white letters on line

chest: 48
length: 65
arm to neck: 71', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-13 02:28:43.83951', NULL, 0.00);
INSERT INTO public.clothing VALUES (2578, 'L', 'DKNY', 'Puffy Jacket', 'Grey', NULL, '??????', 0.00, NULL, 84, NULL, NULL, NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-02-18 00:50:14.529437', NULL, NULL);
INSERT INTO public.clothing VALUES (2635, 'S', 'Bebe', 'Sweat Pants', 'Olive', 215, '618811', 14.99, NULL, NULL, NULL, 'gold sign
waist: 36
hips: 50
pasadka: 27
length: 100', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-22 07:42:45.941479', NULL, NULL);
INSERT INTO public.clothing VALUES (2636, 'M', 'Calvin Klein', 'Sweat Pants', 'White', 215, '437146', 24.99, NULL, NULL, NULL, 'black letters on chest
chest: 57
length: 55
arm: 49/69', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-22 07:44:08.731536', NULL, NULL);
INSERT INTO public.clothing VALUES (2652, 'M', 'Armani Exchange', 'Sweater', 'Navy', 217, '337166', 28.50, NULL, 105, NULL, 'half zipped
chest: 51
length: 65
arm: 66', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-02-23 20:51:46.888158', NULL, 0.00);
INSERT INTO public.clothing VALUES (2646, 'XS', 'Armani Exchange', 'Puffy Jacket', 'Black', 217, '321508', 87.00, NULL, NULL, NULL, 'Long', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-23 20:46:35.829835', NULL, NULL);
INSERT INTO public.clothing VALUES (2663, 'L', 'Armani Exchange', 'Puffy Jacket', 'Green', 217, '337066', 87.00, NULL, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-23 20:59:20.010463', NULL, NULL);
INSERT INTO public.clothing VALUES (2673, 'N/A', 'Tommy Hilfiger', 'Hat', 'White', 219, '52154', 11.92, NULL, NULL, NULL, 'baseball cap', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-25 23:49:45.640469', NULL, NULL);
INSERT INTO public.clothing VALUES (2674, 'N/A', 'Tommy Hilfiger', 'Hat', 'White', 219, '52154', 11.92, NULL, NULL, NULL, 'baseball cap', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-25 23:49:49.563004', NULL, NULL);
INSERT INTO public.clothing VALUES (2675, 'N/A', 'Tommy Hilfiger', 'Hat', 'Black', 219, '928915', 13.49, NULL, NULL, NULL, 'baseball cap
half circle', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-25 23:50:14.061968', NULL, NULL);
INSERT INTO public.clothing VALUES (2713, 'L', 'Michael Kors', 'Sweat Shirt', 'Black', 223, '504961', 19.99, NULL, 105, NULL, 'chest: 57
length: 71
arm: 70', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-02-27 22:47:47.091756', NULL, 0.00);
INSERT INTO public.clothing VALUES (2724, 'N/A', 'Tommy Hilfiger', 'Hat', 'White', 225, '521524', 9.54, NULL, 105, NULL, 'baseball cap', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-01 00:58:57.271877', NULL, 0.00);
INSERT INTO public.clothing VALUES (2691, 'N/A', 'Tommy Hilfiger', 'Hat', 'Mint', 220, '066334', 15.74, NULL, NULL, NULL, 'baseball cap', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-27 21:59:43.816048', NULL, NULL);
INSERT INTO public.clothing VALUES (2688, 'S', 'Tommy Hilfiger', 'Dress', 'Navy, White, Red', 220, '424370', 22.49, NULL, 102, NULL, 'large cursive hilfiger block on chest
chest: 46
length: 89', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-27 21:58:16.386328', NULL, 0.00);
INSERT INTO public.clothing VALUES (2694, '2', 'Armani Exchange', 'Blazer', 'Pink', 222, '365407', 39.99, NULL, NULL, NULL, 'chest: 46
shoulders: 40
length: 74
arm: 58', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-27 22:16:42.155398', NULL, NULL);
INSERT INTO public.clothing VALUES (2698, '2', 'Armani Exchange', 'Blazer', 'White', 222, '365322', 39.99, NULL, NULL, NULL, 'chest: 46
shoulders: 40
length: 74
arm: 58', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-27 22:20:31.206321', NULL, NULL);
INSERT INTO public.clothing VALUES (2725, 'N/A', 'Tommy Hilfiger', 'Hat', 'Navy', 225, '521548', 9.54, NULL, NULL, NULL, 'baseball cap', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-01 00:59:09.414686', NULL, 0.00);
INSERT INTO public.clothing VALUES (2744, 'M8-10', 'Tommy Hilfiger', 'Sweat Pants', 'Blue', 225, '930314', 16.91, NULL, 105, NULL, 'kids clothes
8-10 years

waist: 30
hips: 38
length: 75', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-01 01:19:21.417599', NULL, 0.00);
INSERT INTO public.clothing VALUES (2748, 'S', 'Tommy Hilfiger', 'T-Shirt', 'White', 225, '297544', 14.39, NULL, 106, NULL, 'chest: 44
length: 66', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-01 01:22:14.736872', NULL, 0.00);
INSERT INTO public.clothing VALUES (2751, 'L', 'DKNY', 'Puffy Jacket', 'Grey', NULL, '391237', 20.00, NULL, NULL, NULL, 'from costco

chest: 59
length: 89
arm: 65
shoulders: 46', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-01 05:51:21.263437', NULL, 0.00);
INSERT INTO public.clothing VALUES (2769, 'L', 'Guess', 'T-Shirt', 'Black', 226, '971188', 12.99, NULL, NULL, NULL, 'guess with golden city inside
chest: 55
length: 71', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-01 06:06:20.214041', NULL, NULL);
INSERT INTO public.clothing VALUES (2750, 'M', 'Tommy Hilfiger', 'T-Shirt', 'Navy', 225, '297483', 14.39, NULL, 93, NULL, 'chest: 48
length: 65', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-01 01:23:13.13392', NULL, 0.00);
INSERT INTO public.clothing VALUES (2814, '4', 'Karl Lagerfeld', 'Jeans', 'Navy', NULL, 'KLP002', 24.99, NULL, 111, NULL, 'ПОТ 38
ПОБ 41
длина 97
посадка 22', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-04 01:47:50.888692', NULL, NULL);
INSERT INTO public.clothing VALUES (2577, 'S', 'Calvin Klein', 'Vest Jacket', 'Silver', NULL, '876358', 0.00, 64.29, 83, 22, 'hooded

chest: 54
length: 66', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-15 20:13:19.981979', NULL, 0.00);
INSERT INTO public.clothing VALUES (2656, 'L', 'Armani Exchange', 'Hoodie', 'Blue', 217, '147485', 39.99, 60.71, 105, 22, 'zipped

chest: 58
length: 69
arm: 68
shoulders: 51
', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-23 20:54:18.727551', NULL, 0.00);
INSERT INTO public.clothing VALUES (2793, '8', 'Calvin Klein', 'Jumpsuit', 'Blue', NULL, '198151', 24.99, NULL, 112, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-03 21:06:14.601794', NULL, NULL);
INSERT INTO public.clothing VALUES (2824, 'M', 'Calvin Klein', 'T-Shirt', 'White', NULL, '412686', 7.99, NULL, 114, NULL, 'вырез мысом чёрно серебр лого
ПОГ 48
длина 65', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-04 02:04:54.675996', NULL, NULL);
INSERT INTO public.clothing VALUES (2728, 'M', 'Tommy Hilfiger', 'Hoodie', 'Pink, Peach, Salmon', 225, '004253', 25.19, NULL, NULL, NULL, 'chest: 52
length: 55
arm: 64', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-01 01:01:53.490249', NULL, 0.00);
INSERT INTO public.clothing VALUES (2702, '0', 'Armani Exchange', 'Blazer', 'Black', 222, '343732', 39.99, 89.29, 107, 23, 'chest: 46
length: 73
arm: 58
shoulders: 40', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-27 22:25:37.367544', NULL, 4.37);
INSERT INTO public.clothing VALUES (2771, 'XS', 'Karl Lagerfeld', 'T-Shirt', 'Peach, Coral, Pink', 226, 'LORH0030', 16.99, NULL, 128, NULL, 'rhinestones

chest: 43
length: 63', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-01 06:07:36.50586', NULL, 4.18);
INSERT INTO public.clothing VALUES (2593, 'S', 'Calvin Klein', 'Hoodie', 'Pink', 211, '437313', 24.99, NULL, 117, NULL, 'White calvin on chest

chest: 56
length: 54
arm: 53/71', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-18 02:59:57.713578', NULL, NULL);
INSERT INTO public.clothing VALUES (2801, 'M', 'Calvin Klein', 'Bodic', 'White', NULL, '349941', 14.99, 33.93, NULL, 22, '
body with black gray sigh
CH 40
L 76', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-03 21:21:35.798674', NULL, NULL);
INSERT INTO public.clothing VALUES (2774, 'S', 'Calvin Klein', 'Leggings', 'Black', 226, '282554', 16.99, NULL, 117, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-01 06:09:17.880686', NULL, 0.00);
INSERT INTO public.clothing VALUES (2826, 'M', 'Tommy Hilfiger', 'Skirt', 'Navy', NULL, '795163', 19.99, NULL, 119, NULL, 'ПОТ 39
ПОБ 52
Длина 81', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-04 02:07:13.878716', NULL, 0.00);
INSERT INTO public.clothing VALUES (2720, 'M', 'Calvin Klein', 'Sweat Pants', 'Black', 224, '430420', 19.99, NULL, 121, NULL, 'no fleece
CK column on calf', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-27 22:55:08.337648', NULL, NULL);
INSERT INTO public.clothing VALUES (2804, 'M', 'Karl Lagerfeld', 'T-Shirt', 'Blush', NULL, 'LORH0063', 16.99, 22.94, NULL, 9, 'picture of girl in paris', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-03 21:27:14.920392', NULL, NULL);
INSERT INTO public.clothing VALUES (2818, 'L', 'Michael Kors', 'Jean Jacket', 'Navy', NULL, '807706', 34.99, 47.24, NULL, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-04 01:51:20.366555', NULL, NULL);
INSERT INTO public.clothing VALUES (2810, 'L', 'Michael Kors', 'T-Shirt', 'Grey', NULL, '525980', 9.99, NULL, 98, NULL, 'серая лонж', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-03 21:48:21.685581', NULL, 0.00);
INSERT INTO public.clothing VALUES (2722, 'S', 'DKNY', 'Leggings', 'Black', 224, '160240', 19.99, NULL, 127, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-27 22:56:43.183317', NULL, NULL);
INSERT INTO public.clothing VALUES (2831, '4', 'Calvin Klein', 'Jumpsuit', 'Black', NULL, '853007', 29.99, NULL, NULL, NULL, 'с белым воротником', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-04 02:15:22.587271', NULL, NULL);
INSERT INTO public.clothing VALUES (2808, 'S', 'Calvin Klein', 'Pants', 'Black', NULL, 'KOLVK247', 24.99, NULL, NULL, NULL, 'на манжетах с карманами', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-03 21:44:39.488433', NULL, 0.00);
INSERT INTO public.clothing VALUES (3135, '6', 'Karl Lagerfeld', 'Jeans', 'Blue', NULL, 'KLP006', 24.99, NULL, 103, NULL, 'с полоской с боку
ПОТ 38
ПОБ 42
пос 23
дл 97', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-15 22:40:09.786219', NULL, 0.00);
INSERT INTO public.clothing VALUES (2851, 'N/A', 'Tommy Hilfiger', 'Wallet', 'Black', NULL, '239293', 14.99, NULL, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-04 04:55:55.020799', NULL, NULL);
INSERT INTO public.clothing VALUES (2852, 'N/A', 'Tommy Hilfiger', 'Wallet', 'Black', NULL, '425832', 14.99, NULL, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, NULL, '2021-03-04 04:57:30.276515', NULL, NULL);
INSERT INTO public.clothing VALUES (2858, 'S', 'Calvin Klein', 'Sweat Pants', 'Pink', NULL, '406586', 19.99, NULL, NULL, NULL, 'white dot
white lace

waist: 37
hips: 49
pasadka: 25
length: 98', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-04 05:01:32.638169', NULL, NULL);
INSERT INTO public.clothing VALUES (2859, 'M', 'Calvin Klein', 'Jumpsuit', 'White', NULL, '117246', 24.99, NULL, NULL, NULL, 'chest: 48
hips: 54
length: 82', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-04 05:02:25.157358', NULL, NULL);
INSERT INTO public.clothing VALUES (2860, 'M', 'Calvin Klein', 'Sweat Pants', 'Pink', NULL, '406579', 19.99, NULL, NULL, NULL, 'white dot
white lace

waist: 40
hips: 50
pasadka: 27
length: 100', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-04 05:02:40.973576', NULL, 0.00);
INSERT INTO public.clothing VALUES (2862, 'M', 'Calvin Klein', 'Hoodie', 'Black', NULL, '479010', 24.99, NULL, NULL, NULL, 'cropped
cut calvin

chest: 56
length: 52
arm: 69', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-04 05:05:21.855656', NULL, NULL);
INSERT INTO public.clothing VALUES (2872, 'M', 'Calvin Klein', 'Sweat Pants', 'Blue', NULL, '373161', 19.99, NULL, NULL, NULL, 'small ck on k on calf
no fleece
waist: 40
hips: 53
pasadka: 30
length: 98', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-04 05:20:03.129796', NULL, NULL);
INSERT INTO public.clothing VALUES (2877, 'S', 'Calvin Klein', 'Sweat Shirt', 'Black', NULL, '503537', 19.99, NULL, NULL, NULL, 'big letters "calvin"
white dot on sleeve

chest: 58
length: 56
arm: 48/71', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-04 05:24:37.376847', NULL, NULL);
INSERT INTO public.clothing VALUES (2879, '4', 'Tommy Hilfiger', 'Dress', 'Tan', NULL, '171194', 29.99, NULL, NULL, NULL, 'chest: 46
waist: 36
hips: 51
length: 100', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-04 05:26:57.165905', NULL, NULL);
INSERT INTO public.clothing VALUES (2880, 'S', 'Calvin Klein', 'Sweat Pants', 'Dark Tan', NULL, '167296', 19.99, NULL, NULL, NULL, 'waist: 39
hips: 49
pasadka: 25
length: 93
', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-04 05:27:52.129574', NULL, NULL);
INSERT INTO public.clothing VALUES (2922, 'XS', 'Tommy Hilfiger', 'T-Shirt', 'White', NULL, '808443', 12.99, NULL, 106, NULL, 'with a navy/red flag


chest: 44
length: 60
', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-04 06:04:33.105999', NULL, 0.00);
INSERT INTO public.clothing VALUES (2910, 'M', 'Calvin Klein', 'Sweat Pants', 'Black', NULL, '169337', 19.99, NULL, NULL, NULL, 'no fleece
painted letters

waist: 39
hips: 49
pasadka: 26
length: 96', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-04 05:53:06.882501', NULL, NULL);
INSERT INTO public.clothing VALUES (2913, 'S', 'Calvin Klein', 'Sweat Pants', 'Blue', NULL, '169146', 19.99, NULL, NULL, NULL, 'mesh
painted letters

waist: 38
hips: 50
pasadka: 24
length: 94 ', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-04 05:58:16.381479', NULL, NULL);
INSERT INTO public.clothing VALUES (2918, 'S', 'Tommy Hilfiger', 'Dress', 'Navy', NULL, '830567', 19.99, NULL, NULL, NULL, 'with a flag
oversized

chest: 52
length: 85
', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-04 06:02:10.178597', NULL, NULL);
INSERT INTO public.clothing VALUES (2919, 'M', 'Tommy Hilfiger', 'Dress', 'Navy', NULL, '830550', 19.99, NULL, NULL, NULL, 'with a flag
oversized

chest: 54
length: 86
', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-04 06:02:51.278673', NULL, NULL);
INSERT INTO public.clothing VALUES (2920, 'M', 'Tommy Hilfiger', 'Dress', 'Navy', NULL, '830550', 19.99, NULL, NULL, NULL, 'with a flag
oversized

chest: 54
length: 86
', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-04 06:02:55.231998', NULL, NULL);
INSERT INTO public.clothing VALUES (2990, 'M', 'Calvin Klein', 'Sweat Shirt', 'Light Pink', 230, '503407', 19.99, NULL, 104, NULL, 'с белыми буквами на гр
ПОГ 60
дл 60
рук 50/74', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-07 01:12:54.374328', NULL, 0.00);
INSERT INTO public.clothing VALUES (2963, 'S', 'Michael Kors', 'Belt', 'Brown', 229, '388217', 16.99, NULL, NULL, NULL, 'коричневый
92 см', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-06 23:52:39.78407', NULL, NULL);
INSERT INTO public.clothing VALUES (2974, '2/26', 'Levis', 'Shorts', 'Blue', 230, 'Levis01', 12.00, NULL, NULL, NULL, 'высокая талия широкий пояс
ПОТ 33
ПОБ 51
 пос 34
 дл 37', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-07 00:22:16.967005', NULL, NULL);
INSERT INTO public.clothing VALUES (2960, 'M', 'Calvin Klein', 'Belt', 'Grey, Black', 229, '286643', 12.99, NULL, 107, NULL, 'двухстор чёрно серый
101 см', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-06 23:48:19.40866', NULL, 0.00);
INSERT INTO public.clothing VALUES (2915, 'S', 'Tommy Hilfiger', 'Dress', 'Black', NULL, '738115', 19.99, NULL, 111, NULL, 'tommy jeans on chest

chest: 45
hips: 47
length: 85', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-04 05:59:45.223834', NULL, 0.00);
INSERT INTO public.clothing VALUES (2909, 'M', 'Calvin Klein', 'Sweat Shirt', 'Pink', NULL, '503407', 19.99, NULL, 111, NULL, 'white calvin
black dot

chest: 63
length: 58
arm: 49/75', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-04 05:50:55.422488', NULL, NULL);
INSERT INTO public.clothing VALUES (2833, 'M', 'Calvin Klein', 'Tank Top', 'Black', NULL, '192670', 11.99, NULL, 114, NULL, 'короткий топик
ПОГ 39
длина 43', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-04 02:54:50.317602', NULL, NULL);
INSERT INTO public.clothing VALUES (2870, 'S', 'Tommy Hilfiger', 'Leggings', 'Black', NULL, '827109', 19.99, NULL, 114, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-04 05:17:27.858631', NULL, NULL);
INSERT INTO public.clothing VALUES (2928, 'XS', 'Karl Lagerfeld', 'T-Shirt', 'White', NULL, 'LOORH6009', 16.99, NULL, 116, NULL, 'flower letters + eiffel tower

chest: 44
length: 60', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-04 06:12:02.115801', NULL, 0.00);
INSERT INTO public.clothing VALUES (2937, 'M', 'Calvin Klein', 'Pants', 'Cream', NULL, '371327', 19.99, NULL, 117, NULL, 'calvin klein написан краской
ПОТ 40
ПОБ 49
посадка 27
длина 95', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-04 21:11:32.563909', NULL, 0.00);
INSERT INTO public.clothing VALUES (2882, 'M', 'Tommy Hilfiger', 'Hoodie', 'Black', NULL, '774779', 24.99, 50.00, 96, 22, 'large tommy hilfiger on sides
oversized

chest: 55
length: 64
arm: 63', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 05:29:51.479196', NULL, 0.00);
INSERT INTO public.clothing VALUES (2911, 'M', 'Calvin Klein', 'Sweat Shirt', 'Tan', NULL, '169016', 19.99, NULL, 117, NULL, 'no fleece
painted letters

chest: 59
length: 59
arm: 48/72
 ', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-04 05:55:08.828822', NULL, NULL);
INSERT INTO public.clothing VALUES (2958, 'S', 'Calvin Klein', 'Sweat Shirt', 'White', 229, '204243', 19.99, NULL, 117, NULL, 'calvin klein jean черный на груди печатные буквы
ПОГ 54
дл 55
рук 49/73', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-06 23:46:28.494764', NULL, NULL);
INSERT INTO public.clothing VALUES (2856, '8', 'Michael Kors', 'Jeans', 'Black', NULL, '834955', 20.00, NULL, 119, NULL, 'waist: 38
hips: 47
pasadka: 24
length: 99', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-04 04:59:37.888123', NULL, NULL);
INSERT INTO public.clothing VALUES (2874, 'XL', 'Michael Kors', 'T-Shirt', 'Black', NULL, '485482', 14.99, NULL, 98, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-04 05:22:15.330881', NULL, 0.00);
INSERT INTO public.clothing VALUES (2981, 'M', 'Calvin Klein', 'T-Shirt', 'Black', 230, '793342', 12.99, NULL, NULL, NULL, 'ПОГ 51
дл 66
', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-07 00:35:10.03892', NULL, NULL);
INSERT INTO public.clothing VALUES (2982, 'L', 'Calvin Klein', 'T-Shirt', 'Black', 230, '793342', 12.99, NULL, NULL, NULL, 'ПОГ 54
дл 71
', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-07 00:36:23.646757', NULL, NULL);
INSERT INTO public.clothing VALUES (2834, 'S', 'Calvin Klein', 'Tank Top', 'Black', NULL, '192687', 11.99, NULL, NULL, NULL, 'короткий топик
ПОГ 36
длина 42', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-04 02:55:42.961809', NULL, 0.00);
INSERT INTO public.clothing VALUES (2961, 'S', 'Calvin Klein', 'Belt', 'Brown', 229, '268779', 12.99, 35.00, 107, 23, 'коричневый
94 см', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-06 23:50:04.521261', NULL, NULL);
INSERT INTO public.clothing VALUES (2908, 'M', 'Calvin Klein', 'Sweat Pants', 'Light Blue', NULL, '337743', 19.99, 46.43, 117, 23, 'no fleece
white dot

waist: 41
hips: 51
pasadka: 27
length: 95', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-04 05:49:37.081005', NULL, NULL);
INSERT INTO public.clothing VALUES (2988, 'M', 'DKNY', 'Puffy Jacket', 'Black', NULL, '391312', 20.00, NULL, NULL, NULL, 'from costco

chest: 56
length: 88
arm: 66
shoulders: 43', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-07 01:09:09.853086', NULL, 0.00);
INSERT INTO public.clothing VALUES (3008, 'S', 'Calvin Klein', 'Sweat Pants', 'Pink', 232, '232499', 19.99, NULL, NULL, NULL, 'pink sewn-in sign
white dot

waist: 38
hips: 49
pasadka: 24
length: 91', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-10 00:13:14.908727', NULL, 0.00);
INSERT INTO public.clothing VALUES (3010, 'S', 'Calvin Klein', 'Sweat Pants', 'Black', 232, '941582', 19.99, NULL, NULL, NULL, 'waist: 39
hips: 47
pasadka: 23
length: 93', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-10 00:14:26.610521', NULL, 0.00);
INSERT INTO public.clothing VALUES (3031, 'M', 'Tommy Hilfiger', 'Dress', 'White', 233, '830529', 12.00, NULL, NULL, NULL, 'flag on chest
chest: 57
length: 87', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-10 00:33:01.298742', NULL, 0.00);
INSERT INTO public.clothing VALUES (3033, '10', 'Tommy Hilfiger', 'Flip Flops', 'Navy', 233, '527494', 16.99, NULL, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-10 00:34:23.539849', NULL, NULL);
INSERT INTO public.clothing VALUES (1770, 'XS', 'Calvin Klein', 'Sweat Pants', 'Black', NULL, '085575', 29.99, 53.57, NULL, 19, 'stripe on waist
waist: 35
hips: 46
length: 93
pasadka: 24', true, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-23 13:28:07.121827', NULL, 3.00);
INSERT INTO public.clothing VALUES (3044, 'L', 'Calvin Klein', 'T-Shirt', 'Black', NULL, '197945', 8.49, 28.57, NULL, 19, 'city picture on chest', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-11 04:52:55.930882', NULL, 3.00);
INSERT INTO public.clothing VALUES (3045, 'M', 'Calvin Klein', 'Puffy Jacket', 'Silver', NULL, '??????', 46.00, 110.71, NULL, 19, 'space suit', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-11 05:18:22.81601', NULL, 5.00);
INSERT INTO public.clothing VALUES (3046, 'XS', 'Tommy Hilfiger', 'Puffy Jacket', 'White', NULL, '??????', 48.00, NULL, NULL, 19, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-11 06:01:39.101078', NULL, 5.00);
INSERT INTO public.clothing VALUES (3047, 'XS', 'Tommy Hilfiger', 'Puffy Jacket', 'Black', NULL, '??????', 61.00, NULL, NULL, 19, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-11 06:11:44.455905', NULL, 5.00);
INSERT INTO public.clothing VALUES (3055, '7', 'Calvin Klein', 'Flip Flops', 'White', 234, '960871', 14.99, NULL, NULL, NULL, 'прозрачные с белыми буквами', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-11 20:14:21.831924', NULL, NULL);
INSERT INTO public.clothing VALUES (2799, 'M', 'U.S. Polo Assn.', 'Polo Shirt', 'Black', NULL, '691941', 12.99, NULL, 101, NULL, 'small white horse on a side
CH 51
L 71', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-03-03 21:17:26.919361', NULL, 0.00);
INSERT INTO public.clothing VALUES (3040, 'S', 'Tommy Hilfiger', 'Blazer', 'Navy', NULL, '830239', 24.99, NULL, 101, NULL, 'buttons along the line', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-11 03:26:00.012145', NULL, NULL);
INSERT INTO public.clothing VALUES (2835, 'S', 'Calvin Klein', 'Rain Coat', 'Pearl', NULL, '360901', 40.00, NULL, NULL, NULL, 'ПОГ 52
длина 75
Рукав 70', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-04 02:58:01.93699', NULL, 0.00);
INSERT INTO public.clothing VALUES (2867, 'M', 'Calvin Klein', 'Dress', 'Green', NULL, '833771', 19.99, 51.79, 111, 23, '3d ck
chest: 47
hips: 51
length: 93', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-04 05:13:21.286832', NULL, NULL);
INSERT INTO public.clothing VALUES (3029, 'L', 'Calvin Klein', 'T-Shirt', 'Black', 233, '426061', 12.99, NULL, 111, NULL, 'grey/silver logo

chest: 59
length: 73', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-10 00:32:15.544556', NULL, NULL);
INSERT INTO public.clothing VALUES (3011, 'L', 'DKNY', 'Windbreaker', 'Blue', 232, '119323', 39.99, NULL, 125, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-10 00:15:24.238133', NULL, 0.00);
INSERT INTO public.clothing VALUES (2991, 'S', 'Calvin Klein', 'Sweat Shirt', 'Light Pink', 230, '503414', 19.99, NULL, 117, NULL, 'с белыми буквами на гр
ПОГ 57
дл 57
рук 49/72', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-07 01:14:16.211938', NULL, NULL);
INSERT INTO public.clothing VALUES (3013, 'M', 'Calvin Klein', 'Windbreaker', 'Blue', 232, '389957', 49.99, NULL, 114, NULL, 'sign calvin on back

chest: 59
length: 71
arm: 66
shoulders: 50', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-10 00:16:59.051493', NULL, 0.00);
INSERT INTO public.clothing VALUES (3014, 'M10/12', 'Calvin Klein', 'T-Shirt', 'White', 232, '681576', 7.99, NULL, 114, NULL, 'kid clothes
black square sign

chest: 42
length: 58', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-10 00:18:03.300685', NULL, NULL);
INSERT INTO public.clothing VALUES (3015, '6', 'Tommy Hilfiger', 'T-Shirt', 'Navy', 232, '753556', 7.99, NULL, 114, NULL, 'kid clothes
red/white square
tommy hilfiger in square
6 years

chest: 37
length: 49', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-10 00:19:12.206636', NULL, NULL);
INSERT INTO public.clothing VALUES (3016, '7', 'Tommy Hilfiger', 'T-Shirt', 'Navy', 232, '753563', 7.99, NULL, 114, NULL, 'kid clothes
red/white square
tommy hilfiger in square
7 years

chest: 38
length: 51', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-10 00:19:45.459638', NULL, NULL);
INSERT INTO public.clothing VALUES (3018, '8', 'Calvin Klein', 'T-Shirt', 'Mint', 232, '682061', 7.99, NULL, 114, NULL, 'kid clothes
chest: 39
length: 53', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-10 00:21:24.546712', NULL, NULL);
INSERT INTO public.clothing VALUES (3017, '10/12', 'Calvin Klein', 'T-Shirt', 'Mint', 232, '682054', 7.99, NULL, 114, NULL, 'kid clothes
chest: 43
length: 60', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-10 00:20:28.306471', NULL, 0.00);
INSERT INTO public.clothing VALUES (3019, '14/16', 'Calvin Klein', 'T-Shirt', 'Black', 232, '687981', 7.99, NULL, 114, NULL, 'kid clothes
grey gummy sign
chest: 45
length: 63', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-10 00:22:18.290979', NULL, NULL);
INSERT INTO public.clothing VALUES (3020, '10/12', 'Calvin Klein', 'T-Shirt', 'Black', 232, '681538', 7.99, NULL, 114, NULL, 'kid clothes
grey square, white/red logo inside
chest: 42
length: 59', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-10 00:23:10.177948', NULL, NULL);
INSERT INTO public.clothing VALUES (3021, '14/16', 'Calvin Klein', 'T-Shirt', 'White', 232, '688100', 7.99, NULL, 114, NULL, 'kid clothes
grey square
chest: 47
length: 62', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-10 00:24:01.898686', NULL, NULL);
INSERT INTO public.clothing VALUES (3022, '10/12', 'DKNY', 'T-Shirt', 'White', 232, '567955', 6.99, NULL, 114, NULL, 'kid clothes
black square
chest: 44
length: 60', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-10 00:24:41.826995', NULL, NULL);
INSERT INTO public.clothing VALUES (3025, '14/16', 'Calvin Klein', 'T-Shirt', 'White', 232, '681569', 7.99, NULL, 114, NULL, 'kid clothes
black square on chest
chest: 47
length: 64
', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-10 00:28:33.313003', NULL, 0.00);
INSERT INTO public.clothing VALUES (3027, '8', 'Calvin Klein', 'T-Shirt', 'White', 232, '681583', 7.99, NULL, 114, NULL, 'kid clothes
black square on chest
chest: 38
length: 54', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-10 00:29:44.586461', NULL, 0.00);
INSERT INTO public.clothing VALUES (3051, '6', 'Levis', 'T-Shirt', 'Red', 234, '019513', 12.99, NULL, 114, NULL, 'детская футболка поло с шортами на 5-6 лет
рост 110-116 см
Замеры поло ПОГ 34 дл 48, замеры шорт ПОТ 28, ПОБ 35, дл 35
', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-11 20:05:35.725397', NULL, NULL);
INSERT INTO public.clothing VALUES (3052, '4', 'Guess', 'Dress', 'White, Navy', 234, '983449', 12.99, NULL, 114, NULL, 'платье и ромпер
', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-11 20:07:45.095922', NULL, 0.00);
INSERT INTO public.clothing VALUES (3053, '6', 'Guess', 'Dress', 'Peach', 234, '983708', 12.99, NULL, 114, NULL, 'набор платьев, розовое и в полоску
', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-11 20:08:48.370693', NULL, 0.00);
INSERT INTO public.clothing VALUES (3023, 'M', 'Calvin Klein', 'Sweat Pants', 'White', 232, '232369', 19.99, NULL, 115, NULL, 'white sewn-in logo
waist: 41
hips: 51
pasadka: 25
length: 93', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-10 00:26:23.211524', NULL, NULL);
INSERT INTO public.clothing VALUES (3024, 'M', 'DKNY', 'Windbreaker', 'Grey', 232, '666397', 39.99, NULL, 115, NULL, 'black hood/chest
chest: 58
length: 71
arm: 67
shoulders:  48', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-10 00:27:42.822497', NULL, NULL);
INSERT INTO public.clothing VALUES (3012, 'XL', 'Levis', 'Bomber Jacket', 'Black', 232, '624069', 39.99, NULL, 115, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-10 00:15:55.993669', NULL, NULL);
INSERT INTO public.clothing VALUES (3059, '7', 'Calvin Klein', 'Flip Flops', 'Black', 234, '962231', 14.99, NULL, 120, NULL, 'чёрные резиновые лого буквы', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-11 22:39:28.080831', NULL, NULL);
INSERT INTO public.clothing VALUES (3048, '5', 'DKNY', 'Flip Flops', 'Silver', 234, '167797', 8.99, NULL, 122, NULL, 'белый лакированный верх', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-11 19:51:48.187328', NULL, NULL);
INSERT INTO public.clothing VALUES (2986, 'XS', 'Karl Lagerfeld', 'T-Shirt', 'Black', 230, 'LORH7052', 16.99, NULL, 116, NULL, 'с серебр паетками
ПОГ 44
дл
61', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-07 01:05:33.225031', NULL, 0.00);
INSERT INTO public.clothing VALUES (3032, '10', 'Tommy Hilfiger', 'Flip Flops', 'Navy', 233, '527494', 16.99, NULL, 118, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-10 00:34:22.722022', NULL, NULL);
INSERT INTO public.clothing VALUES (3034, '9', 'Tommy Hilfiger', 'Flip Flops', 'Navy', 233, '527470', 16.99, NULL, 118, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-10 00:34:37.553616', NULL, NULL);
INSERT INTO public.clothing VALUES (2985, '4', 'Tommy Hilfiger', 'Jeans', 'Navy', 230, '815502', 14.99, NULL, 119, NULL, '
с метал знаком сзади
ПОТ 37
ПОБ 45
пос 25
дл 96', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-07 00:42:14.658077', NULL, NULL);
INSERT INTO public.clothing VALUES (2994, 'L', 'Tommy Hilfiger', 'Hoodie', 'Grey', NULL, '774724', 24.99, NULL, 98, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-07 23:00:58.732062', NULL, 0.00);
INSERT INTO public.clothing VALUES (2979, 'S', 'DKNY', 'Hoodie', 'Black', 230, '918159', 24.99, NULL, 121, NULL, 'ПОГ 50
дл 54
рук 71', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-07 00:32:16.519345', NULL, NULL);
INSERT INTO public.clothing VALUES (3110, '0', 'Tommy Hilfiger', 'Shorts', 'Black', 268, '865224', 26.79, NULL, NULL, NULL, 'bow fabric belt

Waist: 37
Hips: 48
Pasadka: 26
Length: 34
', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-13 04:50:29.087338', NULL, NULL);
INSERT INTO public.clothing VALUES (3117, 'XL', 'Tommy Hilfiger', 'Polo Shirt', 'White', NULL, '431699', 17.99, NULL, NULL, NULL, 'red + navy side
large TOMMY HILFIGER down side

Chest: 55
Length: 66


', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-13 05:05:10.962367', NULL, NULL);
INSERT INTO public.clothing VALUES (1684, '7', 'DKNY', 'Jacket', 'Pink', 56, '457911', 19.99, 0.00, 46, 11, 'Kid Clothes', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:16.15364', NULL, NULL);
INSERT INTO public.clothing VALUES (2980, 'XS', 'Calvin Klein', 'T-Shirt', 'Purple', 230, '455294', 12.99, 30.36, NULL, 23, 'ПОГ 44
дл 62
', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-07 00:33:52.481905', NULL, 0.00);
INSERT INTO public.clothing VALUES (3119, 'S', 'Calvin Klein', 'Blouse', 'Black', NULL, '217434', 21.99, NULL, NULL, NULL, 'gold buttons

Chest: 49
Length: 67
Arm: 36


', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-13 05:08:09.068432', NULL, NULL);
INSERT INTO public.clothing VALUES (3120, 'S', 'DKNY', 'T-Shirt', 'Black', NULL, '761191', 15.99, NULL, NULL, NULL, 'Taxis

Chest: 44
Length: 64



', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-13 05:11:02.370889', NULL, NULL);
INSERT INTO public.clothing VALUES (10, 'M', 'Calvin Klein', 'Puffy Jacket', 'Black', NULL, '8894', 59.95, NULL, 4, NULL, 'Short
Down
From wilson''s leather', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:53.718113', NULL, NULL);
INSERT INTO public.clothing VALUES (560, '8-10', 'Tommy Hilfiger', 'Puffy Jacket', 'Blue', NULL, '459281', 39.99, NULL, 18, NULL, 'Kids clothes
8-10 years

blue with white stripe

chest: 42
length: 54
arm: 50', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.550838', NULL, NULL);
INSERT INTO public.clothing VALUES (630, 'S', 'Tommy Hilfiger', 'Sweat Shirt', 'White', NULL, '0010', 23.99, 52.44, 27, NULL, 'sold for 1500
mom has 1300
                        
Men
block letters on chest', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.165944', NULL, 6.16);
INSERT INTO public.clothing VALUES (728, '4', 'Tommy Hilfiger', 'Jeans', 'Blue', NULL, '440561', 0.00, NULL, 34, NULL, 'TJ flex stretch skinny
Tommy jeans on back pocket', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.019375', NULL, NULL);
INSERT INTO public.clothing VALUES (2061, '36', 'Calvin Klein', 'Belt', 'Black', 157, '267313', 14.99, NULL, 78, NULL, 'length: 105', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-13 11:16:40.439335', NULL, 0.00);
INSERT INTO public.clothing VALUES (15, 'S', 'Calvin Klein', 'Vest Jacket', 'White, Black', 3, '542986', 29.99, NULL, 6, NULL, 'Chest: 49
Waist: 46
Length: 64', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:53.761508', NULL, NULL);
INSERT INTO public.clothing VALUES (20, 'S', 'Tommy Hilfiger', 'Hoodie', 'Black', 3, '102914', 24.99, NULL, 6, NULL, 'White stripe across chest

Chest: 49
Waist: 48
Length: 57
Arm: 67', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:53.805168', NULL, NULL);
INSERT INTO public.clothing VALUES (129, 'XL', 'Tommy Hilfiger', 'Puffy Jacket', 'White, Navy, Red', 10, '012236', 64.99, 118.88, 4, 13, '            Navy body
                                    Red left arm
                                    White right arm
                                    
                                    sold for 3400
                                    
                                    Chest: 60
                                    Length: 60
                                    Sleeve: 62', true, 'Women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.77836', NULL, 8.10);
INSERT INTO public.clothing VALUES (8, 'M', 'Tommy Hilfiger', 'Coat', 'Navy, Black, White', 2, '525069', 59.99, NULL, 6, NULL, 'Men
Hooded

Chest: 58
Waist: 55
Length: 70
Arn: 68', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:53.700136', NULL, NULL);
INSERT INTO public.clothing VALUES (3073, 'XL', 'Karl Lagerfeld', 'Dress', 'Black', 235, 'LD1R9552', 19.99, NULL, 107, NULL, 'gold/white payetki KARL

chest: 58
length: 96', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-13 00:05:35.871647', NULL, NULL);
INSERT INTO public.clothing VALUES (3114, 'S', 'Calvin Klein', 'Hoodie', 'Pink', NULL, '432103', 21.99, NULL, 109, NULL, 'white + silver letters
burlington

Chest: 53
Length: 62
Arm: 55/73

', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-13 05:00:28.786647', NULL, NULL);
INSERT INTO public.clothing VALUES (2034, '6', 'Armani Exchange', 'Blazer', 'Navy', 156, '319574', 15.99, 85.71, 88, 22, 'a lot of buttons

chest: 50
length: 80
arm: 42', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 13:22:36.537651', NULL, 0.00);
INSERT INTO public.clothing VALUES (3140, 'S', 'Calvin Klein', 'Sweat Shirt', 'Tan', NULL, '550081', 29.99, 50.00, 105, 22, 'from macys
half neck
black gloss letters on chest', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-15 23:06:00.719496', NULL, 0.00);
INSERT INTO public.clothing VALUES (3123, 'L', 'DKNY', 'T-Shirt', 'White', NULL, '761122', 15.99, NULL, 109, NULL, 'Taxis

Chest: 51
Length: 66



', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-13 05:14:44.334233', NULL, 0.00);
INSERT INTO public.clothing VALUES (3122, 'S', 'Tommy Hilfiger', 'Polo Shirt', 'White', NULL, '820094', 17.99, NULL, 114, NULL, 'red + navy side
large TOMMY HILFIGER down side

Chest: 45
Length: 65


', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-13 05:13:17.148919', NULL, 0.00);
INSERT INTO public.clothing VALUES (3109, 'S', 'Tommy Hilfiger', 'Dress', 'Black', 268, '440004', 25.49, NULL, 110, NULL, 'cursive sign

chest: 48
length: 87
arm: 60', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-13 04:47:44.973003', NULL, 0.00);
INSERT INTO public.clothing VALUES (3128, '6', 'Calvin Klein', 'Pants', 'Black', NULL, '115471', 22.99, NULL, 110, NULL, 'satin-like fabric

Waist: 39
Hips: 45
Pasadka: 27
Length: 101
', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-13 05:30:36.372787', NULL, NULL);
INSERT INTO public.clothing VALUES (3102, 'M', 'Karl Lagerfeld', 'Dress', 'Red', 235, 'LD1R9551', 19.99, NULL, 110, NULL, 'white square on boob

chest: 48
length: 94', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-13 03:37:57.85711', NULL, NULL);
INSERT INTO public.clothing VALUES (3103, 'S', 'Karl Lagerfeld', 'Dress', 'Red', 235, 'LD1R9551', 19.99, NULL, 110, NULL, 'white square on boob

chest: 46
length: 92', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-13 03:40:06.388538', NULL, NULL);
INSERT INTO public.clothing VALUES (3129, 'L', 'Calvin Klein', 'T-Shirt', 'Black', NULL, '375332', 12.99, NULL, 111, NULL, 'large white calvin on chest

Chest: 48
Length: 63

', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-13 05:32:03.105542', NULL, 0.00);
INSERT INTO public.clothing VALUES (3111, 'XS', 'Tommy Hilfiger', 'Sweat Shirt', 'Navy', 268, '430388', 25.49, NULL, 111, NULL, 'cursive letters + circle logo

Chest: 46
Length: 61
Arm: 59

', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-13 04:52:49.088129', NULL, NULL);
INSERT INTO public.clothing VALUES (3064, '7.5', 'Calvin Klein', 'Shoes', 'Black', 235, 'CKS000', 25.99, NULL, 118, NULL, 'gold rivets
grey ck everywhere', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-12 23:39:08.955854', NULL, 0.00);
INSERT INTO public.clothing VALUES (3071, '7.5', 'Tommy Hilfiger', 'Shoes', 'Navy', 235, 'THS000', 24.99, NULL, 118, NULL, 'wedge heels

red/white/navy toe strap', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-13 00:01:17.078719', NULL, 0.00);
INSERT INTO public.clothing VALUES (3116, 'S', 'Calvin Klein', 'Hoodie', 'Pink', NULL, '432103', 21.99, NULL, 121, NULL, 'white + silver letters
burlington

Chest: 53
Length: 62
Arm: 55/73

', NULL, 'women', NULL, NULL, NULL, NULL, '2021-03-13 05:02:50.628323', NULL, NULL);
INSERT INTO public.clothing VALUES (3126, 'S', 'Tommy Hilfiger', 'Polo Shirt', 'Black', NULL, '820216', 14.99, NULL, 114, NULL, 'white stripe on shoulders

Chest: 45
Length: 61


', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-13 05:22:02.847486', NULL, 0.00);
INSERT INTO public.clothing VALUES (3124, 'L', 'Michael Kors', 'T-Shirt', 'White', NULL, '485703', 14.99, NULL, 114, NULL, 'large MICHAEL KORS down side

Chest: 54
Length: 73


', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-13 05:18:43.690306', NULL, NULL);
INSERT INTO public.clothing VALUES (3069, '8.5', 'Calvin Klein', 'Shoes', 'Black', NULL, 'CKS000', 25.99, NULL, 118, NULL, 'gold rivets
grey ck everywhere', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-12 23:58:34.385176', NULL, 0.00);
INSERT INTO public.clothing VALUES (2333, 'L', 'Armani Exchange', 'Hoodie', 'Blue', 186, '147485', 35.99, 60.71, 88, 22, 'zipped

chest: 58
length: 69
arm: 68
shoulders: 51
', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-31 14:53:21.372745', NULL, 0.00);
INSERT INTO public.clothing VALUES (7, 'M', 'Tommy Hilfiger', 'Vest Jacket', 'White, Red, Navy', 2, '795986', 29.99, 58.93, 65, 22, 'Chest: 50
Waist: 48
Length: 65', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:53.691179', NULL, 0.00);
INSERT INTO public.clothing VALUES (3130, 'M', 'Calvin Klein', 'T-Shirt', 'Black', NULL, '375349', 12.99, NULL, 121, NULL, 'large white calvin on chest

Chest: 44
Length: 62

', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-13 05:33:54.312823', NULL, NULL);
INSERT INTO public.clothing VALUES (3127, 'N/A', 'Guess', 'Purse', 'Pink', NULL, '404125', 24.99, NULL, 121, NULL, 'Large circle on front', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-13 05:27:23.765769', NULL, NULL);
INSERT INTO public.clothing VALUES (3121, 'S', 'Calvin Klein', 'Leggings', 'Black', NULL, '429974', 19.99, NULL, 127, NULL, 'large calvin klein down side


', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-13 05:12:10.151467', NULL, NULL);
INSERT INTO public.clothing VALUES (3072, 'M', 'Karl Lagerfeld', 'Dress', 'Black', 235, 'LD1R9552', 19.99, NULL, 127, NULL, 'gold/white payetki KARL

chest: 48
length: 94', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-13 00:03:53.651234', NULL, NULL);
INSERT INTO public.clothing VALUES (37, 'M', 'Calvin Klein', 'Sweater', 'Red', 5, '790005', 24.99, NULL, 2, NULL, 'Black "Calvin" on chest

Chest: 57
Waist: 54
Length: 62
Arm: 71', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:53.95361', NULL, NULL);
INSERT INTO public.clothing VALUES (38, 'XL', 'Calvin Klein', 'Vest Jacket', 'Black', 1, '687351', 24.99, 69.58, 21, 4, 'sold for 1990
mom has 1790

Hooded
Puffy
Shiny

Chest: 65
Waist: 66
Length: 70', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:53.962263', NULL, NULL);
INSERT INTO public.clothing VALUES (13, 'L', 'Tommy Hilfiger', 'Coat', 'Black, White, Blue', 2, '525052', 64.99, NULL, 6, NULL, 'Men
Black hood
White chest
Blue body

Chest: 65
Waist: 59
Length: 72
Arm: 69', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:53.743531', NULL, NULL);
INSERT INTO public.clothing VALUES (40, 'XS', 'Karl Lagerfeld', 'T-Shirt', 'Black', 6, '886348', 16.99, NULL, 1, NULL, 'Gold sequins "Karl" on chest

Chest: 44
Waist: 42
Length: 59', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:53.979628', NULL, NULL);
INSERT INTO public.clothing VALUES (19, 'M', 'Michael Kors', 'Hoodie', 'White', 3, '224418', 29.99, 59.44, 25, 13, 'Black michael kors on chest

sold for 1700

Chest: 54
Waist: 52
Length: 70
Arm: 70', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:53.797141', NULL, NULL);
INSERT INTO public.clothing VALUES (6, 'M', 'Michael Kors', 'Puffy Jacket', 'Black', 2, '887032', 39.99, 108.39, 10, 14, 'sold for 3100
Hooded
Shiny inside

Chest: 62
Waist: 59
Length: 88
Arm: 69', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:53.682167', NULL, NULL);
INSERT INTO public.clothing VALUES (3106, '6.5', 'Calvin Klein', 'Shoes', 'White', 235, 'CKS000', 25.99, 70.00, 107, 23, 'black CK
black stripe on back', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-13 03:44:28.494689', NULL, NULL);
INSERT INTO public.clothing VALUES (50, 'M', 'Calvin Klein', 'Sweater', 'Black', 7, '826766', 29.75, NULL, 2, NULL, 'Long neck
White "Calvin" across chest

Chest: 65
Waist: 54
Length: 59
Arm: 43', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.076865', NULL, NULL);
INSERT INTO public.clothing VALUES (51, 'M', 'Calvin Klein', 'Sweat Pants', 'Black', 7, '827183', 29.75, NULL, 2, NULL, 'White "Calvin" on calf
Has pockets

Waist: 43
Hips: 51
Length: 94
Pasadka: 26', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.085822', NULL, NULL);
INSERT INTO public.clothing VALUES (54, 'XS', 'Calvin Klein', 'Sweater', 'Purple', 7, '826681', 29.75, NULL, 1, NULL, 'white "Calvin" across chest
long neck

Chest: 60
Waist: 50
Length: 58
Arm: 43', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.111159', NULL, NULL);
INSERT INTO public.clothing VALUES (56, 'XS', 'Calvin Klein', 'Sweat Pants', 'Purple', 7, '827084', 29.75, NULL, 1, NULL, 'White "Calvin" on calf
Has pockets

Waist: 35
Hips: 44
Length: 92
Pasadka: 23', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.128859', NULL, NULL);
INSERT INTO public.clothing VALUES (472, '1SZ', 'Calvin Klein', 'Hat', 'Black', 34, '555766', 9.97, NULL, 15, NULL, 'white sign on forehead', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.790361', NULL, NULL);
INSERT INTO public.clothing VALUES (69, 'L', 'Levis', 'T-Shirt', 'White', NULL, '00940L', 6.99, NULL, 1, NULL, 'On receipt 74 in database 1.

Stripes on chest', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.243437', NULL, NULL);
INSERT INTO public.clothing VALUES (76, 'S', 'Calvin Klein', 'Sweater', 'Black', 9, '954414', 22.96, NULL, 23, NULL, 'With hood

Chest: 51
Waist: 48
Length: 51
Arm: 51', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.303431', NULL, NULL);
INSERT INTO public.clothing VALUES (87, 'M', 'Calvin Klein', 'Vest Jacket', 'Silver', 10, '220662', 29.99, NULL, 6, NULL, 'puffy
hooded

Chest: 49
Waist: 54
Length: 62', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.396074', NULL, NULL);
INSERT INTO public.clothing VALUES (89, 'M', 'Hunter', 'Puffy Jacket', 'Teal', 10, '526982', 59.99, 146.85, 4, 4, 'sold for 4200
mom has 4050

Hooded
Pink pocket zippers

Chest: 57
Waist: 64
Length: 67
Arm: 68', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.412859', NULL, NULL);
INSERT INTO public.clothing VALUES (90, 'M', 'Hunter', 'Coat', 'Black', 10, '527163', 79.99, NULL, 4, NULL, 'Furry Hood

Chest: 58
Waist: 64
Length: 93
Arm: 61', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.421746', NULL, NULL);
INSERT INTO public.clothing VALUES (91, 'S', 'Hunter', 'Coat', 'Black', 10, '527156', 79.99, NULL, 4, NULL, 'Furry Hood

Chest: 54
Waist: 61
Length: 92
Arm: 61', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.429909', NULL, NULL);
INSERT INTO public.clothing VALUES (2028, 'S', 'Calvin Klein', 'Sweat Pants', 'Black', NULL, '827190', 29.99, NULL, 57, NULL, '"calvin" on back of calf

waist: 37
hips: 47
pasadka: 26
length: 95', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 12:27:09.194015', NULL, 0.00);
INSERT INTO public.clothing VALUES (2318, 'S', 'Michael Kors', 'Puffy Jacket', 'Black', NULL, '280279', 70.80, NULL, 85, NULL, 'chest: 53
length: 71
arm: 64
shoulders: 41', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-31 14:38:38.880851', NULL, 0.00);
INSERT INTO public.clothing VALUES (107, 'M', 'Tommy Hilfiger', 'Sweat Shirt', 'Teal', 13, '792902', 15.99, 21.84, 32, 9, '"Tommy Hilfiger" in block letters on chest

Chest: 53
Waist: 51
Length: 63
Arm:  61', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.578045', NULL, NULL);
INSERT INTO public.clothing VALUES (65, 'XS', 'Tommy Hilfiger', 'Hoodie', 'Navy', 8, '792810', 19.99, 48.95, 2, 3, 'sold for 1400
mom has 1200

Chest: 45
Waist: 45
Length: 57
Arm: 56', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.208686', NULL, NULL);
INSERT INTO public.clothing VALUES (48, 'S', 'Calvin Klein', 'Hoodie', 'Mint', 7, '827619', 29.75, NULL, 1, NULL, 'Black "Calvin" across chest
Belly Pocket

Chest: 55
Waist: 53
Length: 52
Arm: 70', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.047979', NULL, NULL);
INSERT INTO public.clothing VALUES (92, 'M', 'Tommy Hilfiger', 'Hoodie Dress', 'Navy', 10, '920220', 29.99, 62.93, 4, 15, 'sold for 1800
velvety fabric
silver "Tommy Hilfiger" on stripe down arm

Chest: 53
Waist: 52
Length: 89
Arm: 62', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.438605', NULL, NULL);
INSERT INTO public.clothing VALUES (74, 'S', 'Calvin Klein', 'Sweater', 'Black', 9, '986286', 19.66, NULL, 26, NULL, 'White/green stripe along arms/shoulder

Chest: 43
Waist: 41
Length: 55
Arm: 72', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.28601', NULL, NULL);
INSERT INTO public.clothing VALUES (130, 'L', 'Tommy Hilfiger', 'Puffy Jacket', 'White, Navy, Red', 10, '012243', 64.99, 126.31, 4, 4, 'sold for 3600
mom has 3400

Women
Navy body
Red left arm
White right arm

Chest: 56
Length: 56
Sleeve: 61', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.792304', NULL, NULL);
INSERT INTO public.clothing VALUES (108, 'S', 'Tommy Hilfiger', 'Sweat Shirt', 'Teal', 13, '792896', 15.99, 21.84, 32, 9, '"Tommy Hilfiger" in block letters on chest

Chest: 51
Waist: 47
Length: 62
Arm: 59', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.587206', NULL, NULL);
INSERT INTO public.clothing VALUES (100, 'M', 'Tommy Hilfiger', 'Sweat Shirt', 'White', 12, '792766', 16.99, 54.19, 22, 2, '"Tommy Hilfiger" in block letters on chest

Chest: 53
Waist: 51
Length: 63
Arm:  61', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.517111', NULL, NULL);
INSERT INTO public.clothing VALUES (102, 'XXS', 'Tommy Hilfiger', 'Sweat Shirt', 'White', 11, '792735', 15.99, NULL, 6, NULL, '"Tommy Hilfiger" in block letters on chest

Chest: 43
Waist: 41
Length: 58
Arm: 58', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.535733', NULL, NULL);
INSERT INTO public.clothing VALUES (103, 'M', 'Tommy Hilfiger', 'Sweat Pants', 'White', 11, '412125', 15.99, NULL, 6, NULL, 'Block letters "Tommy hilfiger" down leg

Waist: 42
Hips: 52
Length: 95
Pasadka: 24', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.543846', NULL, NULL);
INSERT INTO public.clothing VALUES (23, 'L', 'Tommy Hilfiger', 'Hoodie', 'Black', 3, '103010', 24.99, NULL, 6, NULL, 'Men
white "hilfiger" all over body
red neck string
White stripe down arms

Chest: 57
Waist: 54
Length: 57
Arm: 52', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:53.830984', NULL, NULL);
INSERT INTO public.clothing VALUES (112, 'M', 'Tommy Hilfiger', 'Sweat Pants', 'White', 13, '790724', 15.99, 54.19, 22, 2, 'Block letters "Tommy hilfiger" down leg

Waist: 42
Hips: 52
Length: 95
Pasadka: 24', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.624304', NULL, NULL);
INSERT INTO public.clothing VALUES (113, 'XS', 'Tommy Hilfiger', 'Sweat Pants', 'Navy', 11, '790779', 15.99, 50.70, 22, 3, 'sold with 792813

Block letters "Tommy hilfiger" down leg

Waist: 35
Hips: 47
Length: 96
Pasadka: 24', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.633699', NULL, NULL);
INSERT INTO public.clothing VALUES (118, 'XS', 'Tommy Hilfiger', 'Sweat Shirt', 'Navy', 11, '792810', 15.99, NULL, 6, NULL, '"Tommy Hilfiger" in block letters on chest

Chest: 47
Waist: 44
Length: 60
Arm: 58', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.676359', NULL, NULL);
INSERT INTO public.clothing VALUES (3141, 'S', 'Calvin Klein', 'Sweat Shirt', 'Tan', NULL, '550081', 27.77, NULL, NULL, NULL, 'from macys
half neck
black gloss letters on chest', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-15 23:06:51.738655', NULL, 4.00);
INSERT INTO public.clothing VALUES (2296, 'M', 'DKNY', 'Puffy Jacket', 'Grey', NULL, '391244', 49.99, 101.79, 74, 19, 'from costco

chest: 56
length: 88
arm: 66
shoulders: 43', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-25 15:00:50.625685', NULL, 5.67);
INSERT INTO public.clothing VALUES (2155, 'S', 'DKNY', 'Puffy Jacket', 'Grey', NULL, '391251', 49.99, 101.79, 63, 19, 'from costco

chest: 53
length: 87
arm: 63
shoulders: 42', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-18 15:39:52.099451', NULL, 11.23);
INSERT INTO public.clothing VALUES (2106, 'M', 'DKNY', 'Puffy Jacket', 'Grey', NULL, '391244', 49.99, 101.79, 65, 19, 'from costco

chest: 56
length: 88
arm: 66
shoulders: 43', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-16 14:38:10.924148', NULL, 7.58);
INSERT INTO public.clothing VALUES (1973, 'S', 'Calvin Klein', 'T-Shirt', 'Black', 151, '434657', 0.61, 30.36, 59, 22, 'Pink / silver logo on chest
chest: 45
length: 62', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 10:54:32.032062', NULL, 0.00);
INSERT INTO public.clothing VALUES (2337, 'L', 'Michael Kors', 'Polo', 'Black', 187, '802089', 19.99, 42.86, 88, 21, 'chest: 55
length: 72
shoulders: 47', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-01-31 14:58:28.596477', NULL, 0.00);
INSERT INTO public.clothing VALUES (1994, 'L', 'Calvin Klein', 'Belt', 'Brown', 154, '268632', 3.51, NULL, 59, NULL, 'Logo belt
length: 110
width: 2.5', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 11:49:21.881214', NULL, 3.41);
INSERT INTO public.clothing VALUES (26, 'L', 'Tommy Hilfiger', 'Sweat Pants', 'Black', 3, '103096', 19.99, NULL, 6, NULL, 'Men
white "hilfiger" patterned stripe down legs

Waist: 47
Hips: 54
Length: 93
Pasadka: 26', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:53.856549', NULL, NULL);
INSERT INTO public.clothing VALUES (123, 'XS', 'Calvin Klein', 'Sweat Pants', 'Black', 14, '784479', 35.70, 54.20, 21, 4, 'sold with 5185

word lines on calf

Waist: 36
Hips: 46
Length: 92
Pasadka: 23', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.720866', NULL, NULL);
INSERT INTO public.clothing VALUES (124, 'XS', 'Calvin Klein', 'Hoodie', 'Black', 14, '795185', 35.70, 54.20, 21, 4, 'sold with 4479
sold for 3100
mom has 2900

word lines on chest

Chest: 49
Length: 50
Arm: 51 x 68', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.729414', NULL, NULL);
INSERT INTO public.clothing VALUES (2070, 'S', 'Michael Kors', 'Polo Shirt', 'Navy', 158, '429197', 15.00, 20.20, 64, 9, NULL, NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-01-13 11:28:20.227074', NULL, 0.00);
INSERT INTO public.clothing VALUES (42, 'M', 'Calvin Klein', 'Dress Shirt', 'White', 6, '337361', 19.99, NULL, 1, NULL, 'Men

Chest: 53
Waist: 53
Length: 70
Arm: 62', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:53.996631', NULL, NULL);
INSERT INTO public.clothing VALUES (133, 'N/A', 'Calvin Klein', 'Bag', 'White', 15, '269438', 32.64, NULL, 6, NULL, 'Tote bage', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.833584', NULL, NULL);
INSERT INTO public.clothing VALUES (619, 'XS', 'Calvin Klein', 'Sweat Shirt', 'Mint', NULL, '0007', 29.99, 47.20, 24, 4, 'sold with 0006', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.062969', NULL, NULL);
INSERT INTO public.clothing VALUES (2280, '0', 'Calvin Klein', 'Dress', 'Black', 181, '029594', 9.26, NULL, 72, NULL, 'mid length
zipper on back

chest: 41
length: 115
waist: 32
', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-23 21:32:02.711789', NULL, 0.00);
INSERT INTO public.clothing VALUES (2375, 'S', 'Karl Lagerfeld', 'Hoodie', 'White', NULL, '343688', 34.99, NULL, 74, NULL, 'zipped
black stripe on sleeve', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-31 18:29:34.532278', NULL, NULL);
INSERT INTO public.clothing VALUES (2338, 'XL', 'Armani Exchange', 'Polo', 'Black', 187, '802096', 19.99, 27.05, 82, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-31 14:59:16.587221', NULL, 0.00);
INSERT INTO public.clothing VALUES (3142, 'S', 'Calvin Klein', 'Sweat Pants', 'Black', NULL, '??????', 0.00, NULL, 105, NULL, 'white calvin on back', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-15 23:12:30.849949', NULL, NULL);
INSERT INTO public.clothing VALUES (111, 'S', 'Tommy Hilfiger', 'Sweat Shirt', 'Navy', 13, '792834', 15.99, NULL, 19, NULL, '"Tommy Hilfiger" in block letters on chest

Chest: 53
Waist: 51
Length: 63
Arm:  61', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.616252', NULL, NULL);
INSERT INTO public.clothing VALUES (98, '2PX29', 'Ralph Lauren', 'Jeans', 'Blue', NULL, '322007', 7.49, NULL, 4, NULL, '2PX29
Modern straight petite curvy

Waist: 37
Hips: 42
Length: 97
Pasadka: 21', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.49995', NULL, NULL);
INSERT INTO public.clothing VALUES (138, 'M', 'Calvin Klein', 'Sweater', 'White', NULL, '383772', 24.99, NULL, 5, NULL, 'Black outlined white stripe across chest.

Chest: 54
Waist: 53
Length: 69
Arm: 69', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.894601', NULL, NULL);
INSERT INTO public.clothing VALUES (140, 'S', 'Calvin Klein', 'Hoodie', 'Black', NULL, '291205', 17.72, NULL, 6, NULL, 'Large circle logo on front

Chest: 60
Waist: 52
Length: 51
Arm: 46', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.910972', NULL, NULL);
INSERT INTO public.clothing VALUES (284, 'L', 'Levis', 'Puffy Jacket', 'Blue, White, Black', NULL, '030250', 59.99, NULL, 6, NULL, 'Men
Black top/hood
White chest
blue bottom
            
Chest: 63
Waist: 63
Length: 72
Arm: 72
Shoulders: 48', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.142323', NULL, 0.00);
INSERT INTO public.clothing VALUES (148, 'S', 'Calvin Klein', 'Sweat Pants', 'Red', 17, '784714', 28.83, NULL, 25, NULL, 'Black stripe down side

Waist: 40
Hips: 48
Length: 92
Pasadka: 23', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.979282', NULL, NULL);
INSERT INTO public.clothing VALUES (150, 'M', 'Karl Lagerfeld', 'T-Shirt', 'Black', NULL, '987977', 19.99, NULL, 6, NULL, 'Flower "Karl"

Chest: 52
Waist: 49
Length: 63', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:55.000346', NULL, NULL);
INSERT INTO public.clothing VALUES (151, 'M', 'Karl Lagerfeld', 'T-Shirt', 'Black', NULL, '987977', 19.99, NULL, 6, NULL, 'Flower "Karl"

Chest: 52
Waist: 49
Length: 63', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:55.008215', NULL, NULL);
INSERT INTO public.clothing VALUES (153, 'M', 'Calvin Klein', 'Hoodie', 'Black', NULL, '872108', 29.99, 54.19, 29, 3, '3100 hrn
sold with sweatpants tag: ??????
With zipper

Chest: 54
Waist: 52
Length: 70
Arm: 68', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:55.023826', NULL, NULL);
INSERT INTO public.clothing VALUES (2360, '6', 'Calvin Klein', 'Polo Shirt', 'Black', NULL, '275164', 8.99, NULL, 83, NULL, 'kid clothes
6 years

chest: 33
length: 47
', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-31 15:19:54.976521', NULL, 0.00);
INSERT INTO public.clothing VALUES (2281, '0', 'Calvin Klein', 'Dress', 'Black', 181, '029594', 9.26, NULL, 101, NULL, 'mid length
zipper on back

chest: 41
length: 115
waist: 32
', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-23 21:32:04.061227', NULL, 0.00);
INSERT INTO public.clothing VALUES (116, 'XXS', 'Tommy Hilfiger', 'Sweat Shirt', 'Navy', 13, '792803', 15.99, 39.29, 19, 19, '"Tommy Hilfiger" in block letters on chest

Chest: 43
Waist: 41
Length: 58
Arm: 58', true, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.658537', NULL, 0.00);
INSERT INTO public.clothing VALUES (2252, 'S', 'DKNY', 'Puffy Jacket', 'Grey', NULL, '391251', 49.99, 101.79, 69, 19, 'from costco

chest: 53
length: 87
arm: 63
shoulders: 42', false, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-22 10:29:52.841582', NULL, 8.68);
INSERT INTO public.clothing VALUES (2254, 'S', 'DKNY', 'Puffy Jacket', 'Grey', NULL, '391251', 49.99, 101.79, 69, 19, 'from costco

chest: 53
length: 87
arm: 63
shoulders: 42', false, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-22 10:29:54.267233', NULL, 8.68);
INSERT INTO public.clothing VALUES (125, 'XS', 'Levis', 'Hoodie', 'Black', NULL, '181510', 20.00, 42.86, 6, 19, 'Red logo on chest

Chest: 51
Length: 63
Arm: 69', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.73859', NULL, 2.98);
INSERT INTO public.clothing VALUES (2043, '2', 'Armani Exchange', 'Pants', 'Black', 156, '288078', 15.99, NULL, 102, NULL, 'wide
waist: 31
hips: 49
length: 92
pasadka: 34', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 13:29:54.893921', NULL, 0.00);
INSERT INTO public.clothing VALUES (158, 'S', 'Calvin Klein', 'Sweater', 'Black', NULL, 'HS6041', 19.99, NULL, 5, NULL, 'Tag number is last 6 letters/numbers of style number.

Gold buttons on shoulder
White outline on wrists + neck

Chest: 42
Waist: 39
Length: 63
Arm: 62', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:55.06435', NULL, NULL);
INSERT INTO public.clothing VALUES (159, 'S', 'Calvin Klein', 'Sweater', 'White', NULL, 'HSN076', 19.99, NULL, 5, NULL, 'Tag number is last 6 letters/numbers of style number.

Gold buttons on shoulder

Chest: 42
Waist: 39
Length: 63
Arm: 62', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:55.072707', NULL, NULL);
INSERT INTO public.clothing VALUES (2012, 'XS', 'Calvin Klein', 'Sweat Shirt', 'Black', 154, '796472', 14.05, NULL, 57, NULL, 'stripe + "calvin" on shoulder

chest: 53
length: 58-67
arm: 43-66', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 12:08:13.007569', NULL, 0.00);
INSERT INTO public.clothing VALUES (167, 'S', 'Calvin Klein', 'Sweater', 'White', NULL, '954940', 24.99, 50.70, 29, 3, 'sold with 0661
sold for 2900
mom has 2700

Long neck
large black "calvin" on chest

Chest: 48
Waist: 46
Length: 69
Arms: 67', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:55.137756', NULL, NULL);
INSERT INTO public.clothing VALUES (161, 'L', 'Tommy Hilfiger', 'Puffy Jacket', 'Black', NULL, '429039', 69.99, NULL, 28, NULL, 'Men
Shiny

Chest: 63
Waist: 60
Length: 72
Arm: 70
Shoulder: 47', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:55.088947', NULL, NULL);
INSERT INTO public.clothing VALUES (172, 'M', 'Calvin Klein', 'Puffy Jacket', 'Navy', NULL, '531997', 79.99, NULL, 17, NULL, 'Black bungee on hood

Chest: 58
Waist: 56
Length: 64
Arm: 69', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:55.177437', NULL, NULL);
INSERT INTO public.clothing VALUES (160, 'M', 'Calvin Klein', 'Sweater', 'Black', NULL, 'HSN076', 19.99, NULL, 5, NULL, 'Tag number is last 6 letters/numbers of style number.

Gold buttons on shoulder

Chest: 51
Waist: 47
Length: 66
Arm: 63', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:55.080581', NULL, NULL);
INSERT INTO public.clothing VALUES (2359, 'L', 'Michael Kors', 'Sweat Shirt', 'Black', NULL, '225576', 24.99, 33.74, 82, 9, 'chest: 56
length: 72
arm: 70', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-01-31 15:18:02.32987', NULL, 0.00);
INSERT INTO public.clothing VALUES (2044, '6', 'Armani Exchange', 'Pants', 'Black', 156, '288092', 15.99, 21.79, 64, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 13:30:34.219114', NULL, 0.00);
INSERT INTO public.clothing VALUES (163, 'L', 'Calvin Klein', 'Puffy Jacket', 'Black', NULL, '309733', 69.99, 111.89, 10, 15, 'sold for 3200
Shiny
Red line around hood + bottom + wrists

Chest: 63
Waist: 59
Length: 70
Arm: 65', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:55.105403', NULL, NULL);
INSERT INTO public.clothing VALUES (1629, 'N/A', 'Guess', 'Wallet', 'Tan', 56, '364009', 15.00, NULL, 42, NULL, '', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:15.647384', NULL, NULL);
INSERT INTO public.clothing VALUES (134, 'N/A', 'Calvin Klein', 'Bag', 'Black', 15, '269452', 32.64, 71.07, 6, 22, 'Tote bage', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.845284', NULL, NULL);
INSERT INTO public.clothing VALUES (1975, 'XS', 'Calvin Klein', 'Sweat Shirt', 'Black', 151, '473724', 0.80, 44.64, 81, 22, 'white / silver logo on chest
chest: 48
length: 57
arm to neck: 71', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 10:56:44.991156', NULL, 0.00);
INSERT INTO public.clothing VALUES (2109, 'XS', 'DKNY', 'Puffy Jacket', 'Black', NULL, '391336', 49.99, 101.79, 57, 19, 'from costco

chest: 50
length: 84
arm: 63
shoulders: 41', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-16 14:39:26.384451', NULL, 7.69);
INSERT INTO public.clothing VALUES (2197, '28', 'Armani Exchange', 'Jeans', 'Grey', 171, '458112', 39.99, 75.00, 66, 19, 'with stripe down side

waist: 34
hips: 42
pasadka: 22
length: 98', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-21 17:26:19.112608', NULL, 4.63);
INSERT INTO public.clothing VALUES (157, 'L', 'Calvin Klein', 'Windbreaker', 'Black', NULL, '098711', 49.99, 0.00, 7, NULL, 'Men

Chest: 60
Waist: 58
Length: 73
Arm: 69
Shoulders: 47', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:55.056103', NULL, 4.05);
INSERT INTO public.clothing VALUES (2187, 'N/A', 'Armani Exchange', 'Bag', 'White', 171, '786539', 39.99, 82.14, 69, 19, 'length: 42
width: 15
height: 24', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-21 17:19:30.136347', NULL, 8.68);
INSERT INTO public.clothing VALUES (2045, 'M', 'Armani Exchange', 'Sweater', 'Navy', 156, '349512', 9.99, NULL, 60, NULL, 'chest: 50
length: 65
arm: 66', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 13:31:25.877586', NULL, 6.35);
INSERT INTO public.clothing VALUES (181, 'L', 'Calvin Klein', 'Sweat Shirt', 'Black', NULL, '383734', 24.99, NULL, 10, NULL, 'White "calvin klein" between two white lines on chest

Sweat Suit (comes with pants)
price is 24.99 + 19.99

Chest: 57
Waist: 57
Length: 70
Arm: 67', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:55.257863', NULL, NULL);
INSERT INTO public.clothing VALUES (187, '16', 'Michael Kors', 'Puffy Jacket', 'Red', NULL, '296973', 49.99, NULL, 7, NULL, 'Reddish/purplish/wine color

gold/pink elastic band on waist
Gold sparkles in fur hood lining

Chest: 46
Waist: 40
Length: 82
Arm: 58', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:55.310551', NULL, NULL);
INSERT INTO public.clothing VALUES (188, 'S', 'Calvin Klein', 'Sweater', 'Black', NULL, '687176', 24.99, NULL, 60, NULL, 'Long neck, "performance" tag
large white "Calvin" on chest

Chest: 58
Waist: 50
Length: 57
Arm: 43', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:55.319317', NULL, 0.00);
INSERT INTO public.clothing VALUES (200, 'XS', 'Calvin Klein', 'Sweat Shirt', 'Red', 16, '784929', 24.40, NULL, 25, NULL, 'Black patch on shoulder
Long neck

Chest: 61
Waist: 53
Length: 58
Arm: 44', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:55.42306', NULL, 4.55);
INSERT INTO public.clothing VALUES (207, '1SZ', 'U.S. Polo Assn.', 'Hat', 'Grey, Pink', NULL, '749770', 9.99, NULL, 33, NULL, 'Beanie hats
2 pack
1 pink
1 grey
both sparkly', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:55.480344', NULL, NULL);
INSERT INTO public.clothing VALUES (210, 'M', 'Calvin Klein', 'Hoodie', 'Black', NULL, '913190', 24.99, NULL, 6, NULL, 'Gold "KLEIN" on chest

Chest: 56
Waist: 53
Length: 60
Arm: 56', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:55.504626', NULL, NULL);
INSERT INTO public.clothing VALUES (221, '1SZ', 'Calvin Klein', 'Scarf', 'Green', NULL, '377984', 9.99, 33.22, 25, 4, 'sold for 950
mom has 850', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:55.589163', NULL, NULL);
INSERT INTO public.clothing VALUES (182, 'N/A', 'Michael Kors', 'Wallet', 'Black', NULL, '693427', 19.99, NULL, 25, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:55.271534', NULL, 4.55);
INSERT INTO public.clothing VALUES (227, 'XS', 'DKNY', 'Sweater', 'Red', NULL, '304200', 19.99, NULL, 34, NULL, 'Velvety
3d DKNY

Chest: 57
Waist: 53
Length: 57
Arm: 49', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:55.649079', NULL, NULL);
INSERT INTO public.clothing VALUES (2159, 'S', 'Calvin Klein', 'Puffy Jacket', 'Black', NULL, '875443', 62.00, NULL, 63, NULL, 'long', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-01-18 15:44:04.796822', NULL, NULL);
INSERT INTO public.clothing VALUES (231, 'S', 'Tommy Hilfiger', 'Sweater', 'Red', 20, '204002', 8.92, NULL, 34, NULL, 'Knitted

Chest: 58
Waist: 52
Length: 51
Arm: 43', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:55.682243', NULL, NULL);
INSERT INTO public.clothing VALUES (220, 'S', 'Tommy Hilfiger', 'Hoodie', 'White', NULL, '237448', 22.99, 45.45, 6, 14, 'sold for 1300
Zipper
Fluffy

Chest: 49
Waist: 47
Length: 61
Arm: 69', false, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:55.581086', NULL, NULL);
INSERT INTO public.clothing VALUES (201, 'XS', 'Calvin Klein', 'Sweat Pants', 'Red', 16, '784721', 24.40, 54.20, 15, 13, 'Black line down side

sold for 3100
sold with 784929

Waist: 36
Hips: 46
Length: 91
Pasadka: 24', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:55.431098', NULL, NULL);
INSERT INTO public.clothing VALUES (214, '1SZ', 'Levis', 'Hat', 'Navy', NULL, '204256', 7.99, 22.72, 25, 15, 'sold for 650
Beanie hat', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:55.535323', NULL, NULL);
INSERT INTO public.clothing VALUES (237, 'M', 'Calvin Klein', 'Dress', 'Black', 21, '915118', 12.09, NULL, 7, NULL, 'city design in "CK" on chest

Chest: 48
Waist: 44
Length: 85', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:55.744486', NULL, NULL);
INSERT INTO public.clothing VALUES (238, 'XS', 'Calvin Klein', 'T-Shirt', 'White', 21, '028306', 8.02, NULL, 7, NULL, 'sunset + street + trees + CK on front

Chest: 42
Waist: 37
Length: 61', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:55.753228', NULL, NULL);
INSERT INTO public.clothing VALUES (239, 'XS', 'Calvin Klein', 'Dress', 'Salmon', 21, '035915', 16.15, NULL, 7, NULL, 'With hood
silver "calvin klein jeans" on chest

Chest: 49
Waist: 49
Length: 78
Arm: 59', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:55.761142', NULL, NULL);
INSERT INTO public.clothing VALUES (2111, 'S', 'DKNY', 'Puffy Jacket', 'Black', NULL, '391329', 49.99, 101.79, 57, 19, 'from costco

chest: 53
length: 87
arm: 63
shoulders: 42', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-16 14:40:29.49977', NULL, 7.69);
INSERT INTO public.clothing VALUES (2030, 'XS', 'Calvin Klein', 'Hoodie', 'Black', NULL, '061401', 29.75, 57.14, 73, 19, 'stripe on side

8.25% tax
chest: 52
length: 55
arm: 47/68
', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 13:16:22.85867', NULL, 4.69);
INSERT INTO public.clothing VALUES (2189, 'N/A', 'Armani Exchange', 'Purse', 'Navy', 171, '652315', 29.99, NULL, 65, NULL, 'letters all around
length: 90
height: 13
width: 7', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-21 17:20:57.4094', NULL, 0.00);
INSERT INTO public.clothing VALUES (2025, 'XS', 'Calvin Klein', 'Flying Blouse', 'White', 155, '483211', 7.99, NULL, 66, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 12:19:55.512823', NULL, 0.00);
INSERT INTO public.clothing VALUES (260, '1SZ', 'Levis', 'Scarf', 'Navy, Red', NULL, '204621', 10.99, 14.84, 13, 9, 'Scarf + hat
Red line at bottom', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:55.925336', NULL, NULL);
INSERT INTO public.clothing VALUES (2055, '6', 'Michael Kors', 'Jeans', 'Navy', 157, '834818', 10.00, 13.53, 64, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-13 11:10:31.172786', NULL, 0.00);
INSERT INTO public.clothing VALUES (248, 'L', 'Calvin Klein', 'Sweat Shirt', 'White', NULL, '383789', 24.99, NULL, 6, NULL, 'Blacked outlined white stripe across chest

Chest: 57
Waist: 55
Length: 70
Arm: 68', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:55.830268', NULL, NULL);
INSERT INTO public.clothing VALUES (2349, 'N/A', 'Levis', 'Wallet', 'Black', 187, '290089', 12.99, NULL, 76, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-31 15:08:50.679221', NULL, 0.00);
INSERT INTO public.clothing VALUES (256, 'M', 'Calvin Klein', 'Sweat Shirt', 'Black', NULL, '488678', 24.99, NULL, 18, NULL, 'White "CK" down arms

Chest: 54
Waist: 52
Length: 69
Arm: 64', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:55.893611', NULL, NULL);
INSERT INTO public.clothing VALUES (267, 'S', 'Tommy Hilfiger', 'Socks', 'White', 23, '555297', 9.00, NULL, 8, NULL, 'Baby socks', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:55.983515', NULL, NULL);
INSERT INTO public.clothing VALUES (268, 'S', 'Tommy Hilfiger', 'Socks', 'White', 23, '555297', 9.00, NULL, 8, NULL, 'Baby socks', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:55.992349', NULL, NULL);
INSERT INTO public.clothing VALUES (480, 'L', 'Calvin Klein', 'Hoodie', 'Black', 34, '676199', 17.85, NULL, 20, NULL, 'black gummy sign

chest: 56
length: 70
arm: 70', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.858273', NULL, NULL);
INSERT INTO public.clothing VALUES (2283, 'S', 'Tommy Hilfiger', 'Sweater', 'Navy', NULL, '803531', 7.00, 35.00, 69, 22, 'chest: 52
length: 62
arm: 63', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-01-23 21:33:30.001544', NULL, 0.00);
INSERT INTO public.clothing VALUES (2240, 'S', 'Calvin Klein', 'Windbreaker', 'Silver', 176, '899418', 19.99, 51.79, 84, 22, 'chest: 53
length: 81/87', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-22 10:18:39.875125', NULL, 0.00);
INSERT INTO public.clothing VALUES (2298, '7', 'Tommy Hilfiger', 'Puffy Jacket', 'Navy', NULL, '433663', 17.00, 42.86, 69, 22, 'kids clothes
7-8 years', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-25 15:30:38.323022', NULL, NULL);
INSERT INTO public.clothing VALUES (350, 'M', 'Calvin Klein', 'Sweat Pants', 'Black', 29, '718734', 20.19, 50.00, 69, 22, 'Men
black stripe on side
white letters

waist: 42
hips: 52
length: 104
pasadka: 28', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.725708', NULL, 0.00);
INSERT INTO public.clothing VALUES (209, 'M', 'U.S. Polo Assn.', 'Vest Jacket', 'Black', NULL, '344766', 19.99, 50.00, 60, 22, 'Puffy

Chest: 54
Waist: 50
Length: 60', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:55.496992', NULL, 0.00);
INSERT INTO public.clothing VALUES (2309, 'S', 'Tommy Hilfiger', 'Sweat Shirt', 'Navy', NULL, '433037', 20.00, 46.43, 72, 22, 'white stripe on arm

chest: 52
length: 60
arm: 55/70', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-27 16:02:36.064721', NULL, NULL);
INSERT INTO public.clothing VALUES (2243, 'L', 'Tommy Hilfiger', 'Sweat Shirt', 'White', 177, '830932', 19.99, 48.21, 66, 21, 'flag on chest

chest: 54
length: 63
arm from neck: 70', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-22 10:25:51.037021', NULL, 0.00);
INSERT INTO public.clothing VALUES (195, 'L', 'DKNY', 'Puffy Jacket', 'Navy', 19, '012629', 47.99, 114.29, 6, 21, 'Men
            
Chest: 64
Waist: 64
Length: 86
Arm: 72
Shoulder: 48', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:55.371771', NULL, 0.00);
INSERT INTO public.clothing VALUES (270, '8M', 'Tommy Hilfiger', 'Sweat Shirt', 'Navy', 23, '706220', 19.99, NULL, 8, NULL, 'Kid clothes
age 8-10
Tommy Hilfiger on chest

chest: 42
length: 55
arm: 52', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.010785', NULL, NULL);
INSERT INTO public.clothing VALUES (271, '8M', 'Tommy Hilfiger', 'Sweat Pants', 'Navy', 23, '471794', 18.79, NULL, 8, NULL, 'kids clothes
8-10years

waist: 31
hips: 38
length: 75
pasadka: 23', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.022165', NULL, NULL);
INSERT INTO public.clothing VALUES (272, 'M', 'Calvin Klein', 'Sweater', 'Red', 24, '784905', 14.70, NULL, 29, NULL, 'Long neck
Black patch on shoulder

Chest: 64
Waist: 58
Length: 64
Arm: 67', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.030139', NULL, NULL);
INSERT INTO public.clothing VALUES (273, 'L', 'Calvin Klein', 'Sweat Pants', 'Black', 24, '785391', 14.71, NULL, 29, NULL, 'Calvin on ankle

Waist: 47
Hips: 52
Length: 94
Pasadka: 27', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.040019', NULL, NULL);
INSERT INTO public.clothing VALUES (279, 'S', 'Michael Kors', 'Puffy Jacket', 'Tan', NULL, '069645', 79.99, NULL, 5, NULL, 'Fur lined hood

Chest: 55
Waist: 50
Length: 99
Arm: 64', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.092995', NULL, NULL);
INSERT INTO public.clothing VALUES (352, 'M', 'Calvin Klein', 'Puffy Jacket', 'Black', 29, '934478', 48.44, NULL, 19, NULL, 'Long

chest: 58
Length: 89
arm: 67', true, 'men', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.742641', NULL, 0.00);
INSERT INTO public.clothing VALUES (2169, 'XS', 'Calvin Klein', 'Flying Blouse', 'Black', 168, '483167', 8.49, NULL, 66, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-21 16:53:26.322572', NULL, 0.00);
INSERT INTO public.clothing VALUES (2073, 'M', 'Karl Lagerfeld', 'Hoodie', 'Navy', 158, '758300', 29.99, NULL, 60, NULL, 'with a face in the circle

chest: 58
length: 71
arm: 67', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-01-13 11:32:08.206217', NULL, 6.35);
INSERT INTO public.clothing VALUES (281, 'S', 'Tommy Hilfiger', 'Puffy Jacket', 'White, Navy, Red', NULL, '012267', 64.99, NULL, 5, NULL, 'One arm red
one arm white
navy body

Chest: 53
Waist: 53
Length: 56
Arm: 63', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.109738', NULL, NULL);
INSERT INTO public.clothing VALUES (2327, 'N/A', 'Armani Exchange', 'Purse', 'Navy', 186, '652315', 26.99, NULL, 81, NULL, 'letters all around
length: 90
height: 13
width: 7', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-31 14:48:18.838121', NULL, 0.00);
INSERT INTO public.clothing VALUES (2119, 'XS', 'DKNY', 'Puffy Jacket', 'Black', NULL, '391336', 49.99, 101.79, 63, 19, 'from costco

chest: 50
length: 84
arm: 63
shoulders: 41', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-16 18:40:06.82112', NULL, 11.23);
INSERT INTO public.clothing VALUES (278, 'S', 'Calvin Klein', 'Sweat Shirt', 'Black', NULL, '823550', 24.99, NULL, 5, NULL, 'knitted
oversized
long neck

Chest: 68
Waist: 62
Length: 64
Arm: 53', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.084248', NULL, NULL);
INSERT INTO public.clothing VALUES (1965, 'M', 'Tommy Hilfiger', 'Free Sweater', 'Burgundy', 150, '395588', 10.39, NULL, 62, NULL, 'chest: 53
length: 73
arm: 70', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-01-08 10:30:28.762537', NULL, 3.53);
INSERT INTO public.clothing VALUES (3143, 'S', 'Calvin Klein', 'Sweat Shirt', 'Black', NULL, '550180', 27.77, NULL, NULL, NULL, 'half neck
white calvin on chest', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-15 23:15:47.43542', NULL, 4.00);
INSERT INTO public.clothing VALUES (314, 'S', 'Calvin Klein', 'T-Shirt', 'Black', 26, '974825', 8.53, NULL, 7, NULL, 'goldish blackish letters

Chest: 44
length: 62', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.40682', NULL, NULL);
INSERT INTO public.clothing VALUES (21, 'L', 'Calvin Klein', 'Hoodie', 'Black', 3, '557693', 29.99, NULL, 4, NULL, 'Men
Hooded
White line down arms

Chest: 56
Waist: 53
Length: 70
Arm: 69', true, 'men', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:53.814198', NULL, NULL);
INSERT INTO public.clothing VALUES (2260, '29', 'Calvin Klein', 'Jeans', 'Navy, Grey', 178, '844838', 7.79, NULL, 102, NULL, 'waist: 38
hips: 41
pasadka: 24
length: 93', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-22 12:55:23.874553', NULL, 0.00);
INSERT INTO public.clothing VALUES (149, 'M', 'Calvin Klein', 'Puffy Jacket', 'Black', 17, '934478', 56.51, NULL, 17, NULL, 'Long

Chest: 58
Waist: 53
Length: 89
Arm: 67', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.991258', NULL, 0.00);
INSERT INTO public.clothing VALUES (286, 'S', 'Tommy Hilfiger', 'Puffy Jacket', 'Navy, Red', NULL, '960820', 49.99, NULL, 6, NULL, 'Navy hood/chest
Red body/arms

Chest: 50
Waist: 48
Length: 59
Arm: 60', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.163785', NULL, NULL);
INSERT INTO public.clothing VALUES (287, 'M', 'Calvin Klein', 'Hoodie', 'Pink', NULL, '633067', 19.99, NULL, 6, NULL, 'With zipper
fuzzy
Calvin Klein Performance down arm

Chest: 50
Waist: 47
Length: 64
Arm: 65', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.172982', NULL, NULL);
INSERT INTO public.clothing VALUES (288, 'M', 'Levis', 'Man Panties', 'Light Blue', NULL, '??????', 7.99, 23.21, 6, 19, '3 pairs of men''s boxer briefs', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.180853', NULL, 2.98);
INSERT INTO public.clothing VALUES (64, 'S', 'Tommy Hilfiger', 'Sweat Pants', 'Navy', 8, '790786', 19.99, 50.00, 2, 16, 'sold with 792827
Block letters on leg

Waist: 40
Hips: 48
Length: 96
Pasadka: 24', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.200599', NULL, NULL);
INSERT INTO public.clothing VALUES (289, 'M', 'Levis', 'T-Shirt', 'White', NULL, '??????', 7.99, NULL, 6, NULL, '3 men''s white t-shirts', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.189656', NULL, NULL);
INSERT INTO public.clothing VALUES (290, 'N/A', 'Calvin Klein', 'Backpack', 'Black', NULL, '377687', 79.99, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.197326', NULL, NULL);
INSERT INTO public.clothing VALUES (291, '8M', 'Tommy Hilfiger', 'Vest Jacket', 'Blue, Navy, Red', 25, '286145', 23.99, NULL, 7, NULL, 'Kid clothes
8-10M

Navy top
blue mid
red bottom

Chest: 45
Waist: 45
Length: 55', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.206021', NULL, NULL);
INSERT INTO public.clothing VALUES (292, '7', 'Calvin Klein', 'Vest Jacket', 'Grey, Navy, Lemon', NULL, '209947', 20.99, NULL, 7, NULL, 'Kid clothes

3 piece set
lemon vest jacket
grey long sleeved shirt
navy jeans

vest
Chest: 42
Length: 50

Long sleeved shirt
Chest: 37
Length: 52
Arm: 49

Jeans
Waist: 31
Hips: 33
Length: 74
Pasadka: 21', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.217615', NULL, NULL);
INSERT INTO public.clothing VALUES (337, 'M', 'Tommy Hilfiger', 'Sweater', 'Tan', 30, '130177', 15.00, NULL, 15, NULL, 'golfik

chest: 46
length: 64
arm: 61', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.614351', NULL, NULL);
INSERT INTO public.clothing VALUES (293, '7', 'Calvin Klein', 'Vest Jacket', 'Black, Black, Grey', NULL, '209886', 20.99, NULL, 7, NULL, 'Kid clothes

3 piece set
Black vest jacket
grey/white striped long sleeved shirt
black jeans

vest
Chest: 41
Length: 50

Long sleeved shirt
Chest: 37
Length: 52
Arm: 48

Jeans
Waist: 31
Hips: 33
Length: 74
Pasadka: 21', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.227734', NULL, NULL);
INSERT INTO public.clothing VALUES (2079, 'S', 'Calvin Klein', 'Hoodie', 'White, Cream', 160, '432202', 21.99, 50.00, 60, 19, 'Chest: 54
Length: 63
Arm: 56', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-13 11:45:06.335306', NULL, 6.35);
INSERT INTO public.clothing VALUES (127, 'M', 'Juicy Coture', 'Puffy Jacket', 'Black', 10, '361903', 49.99, 120.00, 4, 2, NULL, true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.755563', NULL, NULL);
INSERT INTO public.clothing VALUES (553, 'L', 'Calvin Klein', 'Puffy Jacket', 'Black', 36, '876693', 29.74, NULL, 9, NULL, 'short & tiny

chest: 64
length: 71
arm: 70', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.492199', NULL, NULL);
INSERT INTO public.clothing VALUES (294, '6S', 'Tommy Hilfiger', 'Sport Jacket', 'Navy, White', 25, '081573', 7.79, NULL, 7, NULL, 'Kid clothes
red/black/blue "tommy hilfiger" everywhere

Chest: 37
Length: 74
Arm: 45', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.237283', NULL, NULL);
INSERT INTO public.clothing VALUES (147, 'S', 'Calvin Klein', 'Sweat Shirt', 'Red', 17, '784912', 28.83, NULL, 27, NULL, 'Black shoulder stripe

Chest: 65
Waist: 54
Length: 59
Arm: 42', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.971077', NULL, NULL);
INSERT INTO public.clothing VALUES (295, '4', 'Levis', 'Hoodie', 'Grey, Navy, Red', NULL, '050015', 19.99, NULL, 7, NULL, 'Kid clothes
3 piece set
Hoodie w/ zipper
Sweat pants
t-shirt

Hoodie
Chest: 34
Length: 41
Arm: 37

t-shirt
Chest: 31
Length: 40

sweat pants
Waist: 24
Length: 55', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.246122', NULL, NULL);
INSERT INTO public.clothing VALUES (296, '6', 'Calvin Klein', 'Puffy Jacket', 'Pink', NULL, '??????', 39.99, NULL, 7, NULL, 'Kids clothes

sparkly black "CK" patch on chest

Chest: 37
Length: 51
Arm: 51', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.254826', NULL, NULL);
INSERT INTO public.clothing VALUES (297, '6', 'U.S. Polo Assn.', 'Puffy Jacket', 'Blue, Red, Navy', NULL, '892878', 19.99, NULL, 7, NULL, 'Kids clothes

blue body
navy hood
red/white chest

Chest: 41
Length: 48
Arm: 41', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.262767', NULL, NULL);
INSERT INTO public.clothing VALUES (298, '8', 'Tommy Hilfiger', 'Puffy Jacket', 'Navy, Red, Blue', 25, '504942', 30.10, NULL, 7, NULL, 'Kids clothes
8-10 years
blue red navy stripe

Chest: 46
Length: 56
Arm: 54', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.271224', NULL, NULL);
INSERT INTO public.clothing VALUES (2369, 'M', 'Calvin Klein', 'Vest Jacket', 'Black', NULL, '389704', 35.00, 64.29, 83, 22, 'chest: 55
length: 66', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-01-31 15:31:40.455072', NULL, 4.02);
INSERT INTO public.clothing VALUES (2380, 'N/A', 'DKNY', 'Purse', 'Pink', NULL, '594200', 35.00, 82.14, 74, 22, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-31 18:37:16.50834', NULL, NULL);
INSERT INTO public.clothing VALUES (2218, 'M', 'Tommy Hilfiger', 'Sweat Shirt', 'White', NULL, '830949', 19.99, 52.14, 74, 22, 'flag on chest

chest: 50
length: 64
arm: 70', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-21 17:51:14.74986', NULL, 0.00);
INSERT INTO public.clothing VALUES (2311, 'S', 'Calvin Klein', 'Hoodie', 'Black', NULL, '247034', 9.96, 35.00, 72, 22, 'cropped
pink stripes

chest: 50
length: 49
arm from neck: 69', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-27 16:08:01.31328', NULL, NULL);
INSERT INTO public.clothing VALUES (2116, 'M', 'Tommy Hilfiger', 'Vest Jacket', 'Blue', NULL, '766638', 39.99, 62.50, 57, 22, 'double sided

chest: 58
length: 68', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-16 15:42:46.092851', NULL, NULL);
INSERT INTO public.clothing VALUES (299, '7', 'Tommy Hilfiger', 'Jeans', 'Light Blue', 20, '344852', 15.93, NULL, 7, NULL, 'Kids clothes
girls

pink stripe on side

Waist: 30
Length: 70', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.279241', NULL, NULL);
INSERT INTO public.clothing VALUES (2351, 'N/A', 'Levis', 'Wallet', 'Black', 187, '290089', 12.99, NULL, 96, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-31 15:08:52.091738', NULL, 0.00);
INSERT INTO public.clothing VALUES (300, '6', 'Tommy Hilfiger', 'Dress', 'Blue, Pink', NULL, '238688', 12.99, NULL, 7, NULL, 'Kids clothes
2 pieces
Pink dress + blue flowery leggings

dress
chest: 32
length: 48
arm: 44

leggings
waist: 25
length: 66', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.288031', NULL, NULL);
INSERT INTO public.clothing VALUES (2050, 'N/A', 'Michael Kors', 'Bag', 'Blush', NULL, '074299', 199.00, 268.65, 56, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 13:45:01.866748', NULL, 0.00);
INSERT INTO public.clothing VALUES (1985, 'S', 'Tommy Hilfiger', 'Golfik', 'Black', 153, '130689', 10.00, 13.59, 56, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 11:36:01.245202', NULL, 0.00);
INSERT INTO public.clothing VALUES (264, 'N/A', 'Tommy Hilfiger', 'Wallet', 'Black', NULL, '239286', 14.99, 20.24, 53, 9, 'logo dot', true, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:55.959277', NULL, 0.00);
INSERT INTO public.clothing VALUES (3144, 'S', 'Calvin Klein', 'Sweat Shirt', 'Black', NULL, '550180', 29.99, NULL, 105, NULL, 'half neck
white calvin on chest', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-15 23:15:59.885641', NULL, NULL);
INSERT INTO public.clothing VALUES (306, '6-7S', 'Tommy Hilfiger', 'Sweat Pants', 'Navy', 25, '081696', 6.59, NULL, 7, NULL, 'Kids clothes
6-7 years

Letters down leg

hips: 36
length: 66', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.339893', NULL, NULL);
INSERT INTO public.clothing VALUES (307, '2T', 'Tommy Hilfiger', 'Dress Shirt', 'White, Black, Plaid', NULL, '094235', 22.99, NULL, 7, NULL, 'Kids clothes
2 years
3 piece set

Plaid vest
white dress shirt
black pants

vest
Chest: 30
length: 36

dress shirt
chest: 32
length: 34
arm: 32

pants
length: 48', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.347664', NULL, NULL);
INSERT INTO public.clothing VALUES (308, '14-16L', 'Calvin Klein', 'Hoodie', 'Black', NULL, '274235', 16.99, NULL, 7, NULL, 'Kids clothes
14-16 years

zipper

chest: 51
length: 66
arm: 60', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.356972', NULL, NULL);
INSERT INTO public.clothing VALUES (309, '8-10M', 'Calvin Klein', 'Sweat Pants', 'Grey', NULL, '504359', 12.99, NULL, 7, NULL, 'Kids clothes
8-10 years
light grey

Waist: 30
Hips: 39
Length: 80', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.364633', NULL, NULL);
INSERT INTO public.clothing VALUES (311, 'S', 'Calvin Klein', 'Sweat Shirt', 'Pink', 26, '767960', 12.85, NULL, 7, NULL, 'super fluffy

Chest: 50
length: 51
arm to neck: 72', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.380936', NULL, NULL);
INSERT INTO public.clothing VALUES (312, 'M', 'Calvin Klein', 'T-Shirt', 'White', 26, '028283', 8.53, NULL, 7, NULL, 'purple sunset picture

Chest: 47
length: 67', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.389877', NULL, NULL);
INSERT INTO public.clothing VALUES (313, 'M', 'Calvin Klein', 'T-Shirt', 'Black', 26, '974818', 8.53, NULL, 7, NULL, 'goldish blackish letters

Chest: 47
length: 64', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.397675', NULL, NULL);
INSERT INTO public.clothing VALUES (315, 'XXS', 'Calvin Klein', 'T-Shirt', 'Black', 26, '974849', 8.53, NULL, 7, NULL, 'goldish blackish letters

Chest: 39
length: 61', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.41439', NULL, NULL);
INSERT INTO public.clothing VALUES (316, 'S', 'Calvin Klein', 'T-Shirt', 'Black', 26, '974825', 8.53, NULL, 7, NULL, 'goldish blackish letters

Chest: 44
length: 62', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.423468', NULL, NULL);
INSERT INTO public.clothing VALUES (318, 'XS', 'Calvin Klein', 'Sweat Pants', 'Black', 28, '784479', 19.94, NULL, 7, NULL, 'many letters on calf

Waist: 35
hips: 45
length: 91
pasadka: 23', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.440111', NULL, NULL);
INSERT INTO public.clothing VALUES (319, 'M', 'Calvin Klein', 'Dress', 'Salmon', 26, '035892', 17.17, NULL, 7, NULL, 'Chest: 52
Length: 83
Arm: 63', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.447772', NULL, NULL);
INSERT INTO public.clothing VALUES (320, 'XS', 'Calvin Klein', 'Dress', 'Salmon', 28, '035915', 10.57, NULL, 7, NULL, 'With hood
silver "calvin klein jeans" on chest

Chest: 49
Waist: 49
Length: 78
Arm: 59', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.457019', NULL, NULL);
INSERT INTO public.clothing VALUES (321, 'S', 'Tommy Hilfiger', 'Sweat Shirt', 'Red', 25, '431522', 20.99, NULL, 7, NULL, 'with cursive sign on chest

Chest: 50
Length: 61
Arm: 60', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.464656', NULL, NULL);
INSERT INTO public.clothing VALUES (322, 'S', 'Tommy Hilfiger', 'Sweat Pants', 'Red', 25, '436342', 23.99, NULL, 7, NULL, 'with cursive sign

Waist: 38
Hips: 50/51
Length: 94
Pasadka: 26', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.473831', NULL, NULL);
INSERT INTO public.clothing VALUES (324, 'S', 'Calvin Klein', 'Sweater', 'White', 27, '364619', 10.12, NULL, 8, NULL, 'with stars

chest: 64
length: 48
arm: 55-77', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.489831', NULL, NULL);
INSERT INTO public.clothing VALUES (325, 'S', 'Calvin Klein', 'Sweater', 'White', 27, '364619', 10.12, NULL, 8, NULL, 'with stars

chest: 64
length: 48
arm: 55-77', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.497807', NULL, NULL);
INSERT INTO public.clothing VALUES (282, 'S', 'Hunter', 'Puffy Jacket', 'Yellow', NULL, '527095', 59.99, NULL, 5, NULL, 'Chest: 57
Waist: 57
Length: 68
Arm: 63', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.11993', NULL, 0.00);
INSERT INTO public.clothing VALUES (285, 'XS', 'Levis', 'Jean Jacket', 'Blue', NULL, '974256', 24.99, NULL, 72, NULL, '"fluffy" arms

Chest: 51
Waist: 49
Length: 48
Arm: 53', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.156102', NULL, 0.00);
INSERT INTO public.clothing VALUES (332, 'S', 'Calvin Klein', 'Puffy Jacket', 'Black', 28, '100612', 33.24, NULL, 10, NULL, 'short

chest: 50
length: 59
arm: 65', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.572659', NULL, NULL);
INSERT INTO public.clothing VALUES (335, 'S', 'Tommy Hilfiger', 'Sweater', 'White', 30, '130269', 12.00, NULL, 15, NULL, 'turtle neck
"golfik"

chest: 46
length: 62
arm: 60', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.59726', NULL, NULL);
INSERT INTO public.clothing VALUES (338, 'M', 'Tommy Hilfiger', 'Sweater', 'Black', 30, '130382', 12.00, NULL, 16, NULL, 'golfik
ribbed lines on chest

chest: 45
length: 65
arm: 61', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.623362', NULL, NULL);
INSERT INTO public.clothing VALUES (348, 'L', 'Calvin Klein', 'Belt', 'Black', 29, '192166', 7.99, NULL, 20, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.708613', NULL, NULL);
INSERT INTO public.clothing VALUES (199, 'S', 'Calvin Klein', 'Fleece Jacket', 'Black', NULL, '946471', 20.18, NULL, 7, NULL, 'Men

Chest: 56
Waist: 54
Length: 66
Arm: 65', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:55.409147', NULL, NULL);
INSERT INTO public.clothing VALUES (363, '1SZ', 'Calvin Klein', 'Hat', 'Black', 29, '555766', 16.14, NULL, 15, NULL, 'white sign', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.838441', NULL, NULL);
INSERT INTO public.clothing VALUES (367, 'M', 'Calvin Klein', 'Vest Jacket', 'Black', 29, '934560', 32.29, NULL, 30, NULL, 'hooded

chest: 57
length: 67', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.873109', NULL, NULL);
INSERT INTO public.clothing VALUES (373, 'XS', 'Calvin Klein', 'Sweat Shirt', 'Black', 29, '013463', 24.22, NULL, 34, NULL, 'fluffy

chest: 53
length: 61
arm: 50/72', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.924093', NULL, NULL);
INSERT INTO public.clothing VALUES (355, 'XS', 'Calvin Klein', 'Sweat Shirt', 'Red', 29, '784929', 20.19, 54.20, 14, 13, 'Calvin on shoulder on stripe

sold for 3100
sold with 784721

chest: 56
length: 58-66
arm: 43-67', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.767863', NULL, NULL);
INSERT INTO public.clothing VALUES (356, 'XS', 'Calvin Klein', 'Sweat Pants', 'Red', 29, '784721', 20.19, NULL, 25, NULL, 'Calvin on stripe

Waist: 36
hips: 46
length: 91
pasadka: 24', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.776983', NULL, NULL);
INSERT INTO public.clothing VALUES (2146, 'XS', 'Calvin Klein', 'Sweat Shirt', 'Red', NULL, '784929', 24.40, NULL, 62, NULL, 'Black patch on shoulder
Long neck

Chest: 61
Waist: 53
Length: 58
Arm: 44', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-17 19:09:41.437298', NULL, 0.00);
INSERT INTO public.clothing VALUES (530, 'M', 'Levis', 'Belt', 'Brown', 39, '760168', 10.39, 14.04, 32, 9, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.299502', NULL, NULL);
INSERT INTO public.clothing VALUES (475, 'N/A', 'Calvin Klein', 'Backpack', 'Black', 34, '269421', 17.02, NULL, 34, NULL, 'Width: 28
Height: 33', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.8161', NULL, NULL);
INSERT INTO public.clothing VALUES (491, 'L', 'Calvin Klein', 'Puffy Jacket', 'Black', 37, '875436', 21.08, NULL, 19, NULL, 'Men
long

chest: 64
length: 91
arm: 69', true, 'men', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.950276', NULL, NULL);
INSERT INTO public.clothing VALUES (243, 'M', 'Calvin Klein', 'Hoodie', 'Navy', NULL, '800378', 19.26, 50.00, 69, 22, 'Men
Black + grey stripe down arm

Chest: 55
Waist: 52
Length: 68
Arm: 63', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:55.793656', NULL, 0.00);
INSERT INTO public.clothing VALUES (343, 'S', 'Calvin Klein', 'Jean Jacket', 'Blue', 29, '105808', 15.90, 64.29, 57, 22, 'oversized

chest: 53
length: 64
arm: 56-74', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.665438', NULL, 0.00);
INSERT INTO public.clothing VALUES (330, 'S', 'Calvin Klein', 'Jean Jacket', 'Blue', 29, '105808', 15.90, 64.29, 57, 22, 'oversized

chest: 53
length: 64
arm: 56-74', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.554836', NULL, 0.00);
INSERT INTO public.clothing VALUES (481, 'L', 'Calvin Klein', 'Sweat Pants', 'Black', 34, '561259', 15.86, NULL, 20, NULL, 'waist: 43
hips: 52
length: 104
pasadka: 31', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.866622', NULL, NULL);
INSERT INTO public.clothing VALUES (482, 'N/A', 'Calvin Klein', 'Scarf', 'Grey', 34, '872343', 13.29, NULL, 20, NULL, 'scarf + gloves + hat', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.87531', NULL, NULL);
INSERT INTO public.clothing VALUES (483, 'N/A', 'Calvin Klein', 'Scarf', 'Black', 34, '872336', 13.29, NULL, 20, NULL, 'scarf + gloves + hat', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.883314', NULL, NULL);
INSERT INTO public.clothing VALUES (502, 'M', 'Calvin Klein', 'Hoodie', 'Black', 34, '676182', 17.85, NULL, 14, NULL, 'Men
black sign on chest

chest: 53
length: 67
arm: 66', true, 'men', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.053459', NULL, NULL);
INSERT INTO public.clothing VALUES (525, 'XL', 'DKNY', 'Puffy Jacket', 'Navy', NULL, '219279', 44.00, 59.40, 13, 9, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.253373', NULL, NULL);
INSERT INTO public.clothing VALUES (489, 'M', 'Calvin Klein', 'Puffy Jacket', 'Pearl', 37, '093259', 17.56, NULL, 20, NULL, 'chest: 53
length: 59
arm: 67', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.933812', NULL, NULL);
INSERT INTO public.clothing VALUES (494, 'L', 'Calvin Klein', 'Sweat Pants', 'Black', 34, '561259', 15.86, NULL, 17, NULL, 'waist: 43
hips: 52
length: 104
pasadka: 31', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.975211', NULL, NULL);
INSERT INTO public.clothing VALUES (495, 'L', 'Calvin Klein', 'Hoodie', 'Black', 34, '676199', 17.85, NULL, 17, NULL, 'black gummy sign

chest: 56
length: 70
arm: 70', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.983611', NULL, NULL);
INSERT INTO public.clothing VALUES (462, 'S', 'Calvin Klein', 'T-Shirt', 'White', 37, '974122', 2.77, NULL, 59, NULL, 'black logo letter with city inside

chest: 44
length: 65', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.70774', NULL, 0.00);
INSERT INTO public.clothing VALUES (2147, 'XS', 'Calvin Klein', 'Sweat Pants', 'Red', NULL, '784721', 20.19, NULL, 62, NULL, 'Calvin on stripe

Waist: 36
hips: 46
length: 91
pasadka: 24', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-17 19:10:20.525427', NULL, 0.00);
INSERT INTO public.clothing VALUES (2231, 'S', 'Tommy Hilfiger', 'T-Shirt', 'White', NULL, '437702', 11.00, NULL, 65, NULL, 'chest: 44
length: 62', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-21 18:00:43.265107', NULL, 0.00);
INSERT INTO public.clothing VALUES (471, 'S', 'Calvin Klein', 'Hoodie', 'White', 34, '037322', 9.24, NULL, 69, NULL, 'short
oversized
gold sign on chest

chest: 55
length: 50
arm: 46/71', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.781962', NULL, 0.00);
INSERT INTO public.clothing VALUES (453, 'XS', 'Calvin Klein', 'Satin Pants', 'Black', 34, '549462', 10.57, NULL, 30, NULL, 'waist: 36
hips: 50
Length: 96', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.631651', NULL, NULL);
INSERT INTO public.clothing VALUES (466, '36', 'Calvin Klein', 'Belt', 'Black', 34, '170256', 13.29, NULL, 19, NULL, NULL, true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.738581', NULL, NULL);
INSERT INTO public.clothing VALUES (526, 'M', 'DKNY', 'Puffy Jacket', 'Navy', NULL, '??????', 44.00, 59.40, 13, 9, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.26392', NULL, NULL);
INSERT INTO public.clothing VALUES (500, 'M', 'Calvin Klein', 'Sweater', 'Red', 34, '784905', 16.62, NULL, 14, NULL, 'Long neck
Black patch on shoulder

Chest: 64
Waist: 58
Length: 64
Arm: 67', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.036832', NULL, NULL);
INSERT INTO public.clothing VALUES (504, 'L', 'Calvin Klein', 'Sweat Pants', 'Black', 34, '785391', 19.94, 54.19, 14, 3, 'sold with 4905

Calvin on ankle

Waist: 47
Hips: 52
Length: 94
Pasadka: 27', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.071985', NULL, NULL);
INSERT INTO public.clothing VALUES (507, 'S', 'Calvin Klein', 'Sweat Shirt', 'Grey', 38, '796410', 17.50, NULL, 16, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.098894', NULL, NULL);
INSERT INTO public.clothing VALUES (508, 'S', 'Calvin Klein', 'Sweat Pants', 'Black', 38, '784462', 17.50, NULL, 16, NULL, 'letters around the calf', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.107149', NULL, NULL);
INSERT INTO public.clothing VALUES (509, 'S', 'Calvin Klein', 'Hoodie', 'Black', 38, '795178', 17.50, NULL, 16, NULL, 'black letters all around hoodie', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.11631', NULL, NULL);
INSERT INTO public.clothing VALUES (618, 'XS', 'Calvin Klein', 'Sweat Pants', 'Mint', NULL, '0006', 29.99, 47.20, 24, 4, 'sold with 0007
sold for 2700
mom has 2500', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.054221', NULL, NULL);
INSERT INTO public.clothing VALUES (510, 'XS', 'Calvin Klein', 'Sweat Pants', 'Black', 38, '784479', 17.50, NULL, 17, NULL, 'word lines on calf

Waist: 36
Hips: 46
Length: 92
Pasadka: 23', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.124533', NULL, NULL);
INSERT INTO public.clothing VALUES (511, 'XS', 'Calvin Klein', 'Hoodie', 'Black', 38, '795185', 17.50, NULL, 17, NULL, 'word lines on chest

Chest: 49
Length: 50
Arm: 51 x 68', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.133302', NULL, NULL);
INSERT INTO public.clothing VALUES (512, 'S', 'Calvin Klein', 'Sweat Pants', 'Grey', 38, '785360', 17.50, NULL, 16, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.141843', NULL, NULL);
INSERT INTO public.clothing VALUES (513, 'M', 'Calvin Klein', 'Sweat Pants', 'Grey', 38, '785353', 17.50, NULL, 16, NULL, 'word "calvin" a a black line on the calf', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.1506', NULL, NULL);
INSERT INTO public.clothing VALUES (516, 'M', 'Calvin Klein', 'Sweat Shirt', 'Grey', 38, '796403', 17.50, NULL, 16, NULL, 'sign "calvin" on shoulder', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.176446', NULL, NULL);
INSERT INTO public.clothing VALUES (1998, 'M', 'Calvin Klein', 'Belt', 'Grey', 154, '268687', 3.51, NULL, 59, NULL, 'logo belt
length: 102
', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 11:50:36.397299', NULL, 0.00);
INSERT INTO public.clothing VALUES (518, 'XS', 'Calvin Klein', 'Hoodie', 'White', 38, '964765', 17.50, NULL, 15, NULL, 'reversible payetki', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.193517', NULL, NULL);
INSERT INTO public.clothing VALUES (519, 'XS', 'Calvin Klein', 'Sweat Shirt', 'Black', 38, '888979', 17.50, NULL, 16, NULL, 'rhine stones on front', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.201956', NULL, NULL);
INSERT INTO public.clothing VALUES (490, 'M', 'Calvin Klein', 'Puffy Jacket', 'Black', 37, '934478', 21.08, 110.71, 57, 19, 'Long

chest: 58
Length: 89
arm: 67', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.942428', NULL, 7.69);
INSERT INTO public.clothing VALUES (473, 'L', 'Calvin Klein', 'Puffy Jacket', 'Black', 34, '871988', 66.49, NULL, 17, NULL, 'Men
shiny

chest: 65
length: 73
arm: 71', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.799025', NULL, 7.82);
INSERT INTO public.clothing VALUES (538, '36', 'Levis', 'Belt', 'Black', 39, '498578', 7.99, NULL, 34, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.36839', NULL, NULL);
INSERT INTO public.clothing VALUES (544, 'N/A', 'Armani Exchange', 'Purse', 'Black', NULL, '767493', 29.99, NULL, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.418445', NULL, NULL);
INSERT INTO public.clothing VALUES (546, 'XS', 'Calvin Klein', 'Sweater', 'Black', NULL, '986293', 0.00, NULL, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.43441', NULL, NULL);
INSERT INTO public.clothing VALUES (547, 'M', 'Tommy Hilfiger', 'Sweater', 'Black', NULL, '??????', 24.99, NULL, 14, NULL, 'Golfik

red + white lines
logo on chest', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.442156', NULL, NULL);
INSERT INTO public.clothing VALUES (548, 'S', 'Tommy Hilfiger', 'Sweater', 'Navy', NULL, '??????', 13.00, NULL, 15, NULL, 'golfik', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.450723', NULL, NULL);
INSERT INTO public.clothing VALUES (2031, 'XS', 'Calvin Klein', 'Sweat Pants', 'Black', NULL, '085575', 29.75, NULL, 73, NULL, 'stripe on waist
waist: 35
hips: 46
length: 93
pasadka: 24', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 13:16:36.111668', NULL, 0.00);
INSERT INTO public.clothing VALUES (528, '38', 'Levis', 'Belt', 'Brown', 39, '294742', 10.39, 14.04, 13, 9, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.281785', NULL, NULL);
INSERT INTO public.clothing VALUES (559, '5', 'Champion', 'Sweat Shirt', 'White, Purple', NULL, '??????', 14.99, NULL, 18, NULL, 'Kids clothes

5 years
girls
white top
purple pants

shirt:
chest: 36
length: 41

pants
hips: 34
length: 61', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.542332', NULL, NULL);
INSERT INTO public.clothing VALUES (515, 'N/A', 'Calvin Klein', 'Bag', 'White', 38, '269438', 17.92, NULL, 19, NULL, 'tote bag', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.167484', NULL, NULL);
INSERT INTO public.clothing VALUES (501, 'M', 'Calvin Klein', 'Sweat Pants', 'Black', 34, '561242', 15.86, NULL, 14, NULL, 'small black rubber sign

waist: 39
hips: 49
length: 100
pasadka: 30', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.045733', NULL, NULL);
INSERT INTO public.clothing VALUES (561, '12-14', 'Calvin Klein', 'Puffy Jacket', 'Black', NULL, '162679', 34.99, NULL, 18, NULL, 'kids clothes
12-14 years

chest: 46
length: 62
arm: 56', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.558632', NULL, NULL);
INSERT INTO public.clothing VALUES (562, '6', 'Tommy Hilfiger', 'Jeans', 'Blue', NULL, '438367', 17.00, NULL, 18, NULL, 'waist: 39
hips: 45
length: 95
pasadka: 24', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.575029', NULL, NULL);
INSERT INTO public.clothing VALUES (564, 'L', 'Armani Exchange', 'Sweat Shirt', 'Grey, Navy', 33, '710996', 34.99, NULL, 18, NULL, 'down padding in front

chest: 51
length: 62
arm: 66', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.597624', NULL, NULL);
INSERT INTO public.clothing VALUES (565, 'M', 'Armani Exchange', 'Sweat Pants', 'Navy', 32, '942340', 29.99, NULL, 18, NULL, 'waist: 41
hips: 52
length: 94
pasadka: 26', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.605455', NULL, NULL);
INSERT INTO public.clothing VALUES (566, 'M', 'Armani Exchange', 'Sweat Shirt', 'Navy', 32, '941985', 39.99, NULL, 18, NULL, 'chest: 52
length: 69
arm: 66', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.614739', NULL, NULL);
INSERT INTO public.clothing VALUES (567, 'M', 'Tommy Hilfiger', 'Puffy Jacket', 'Navy', NULL, '??????', 0.00, NULL, 17, NULL, 'red hood
white "V" stripe', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.622577', NULL, NULL);
INSERT INTO public.clothing VALUES (568, '18', 'Tommy Hilfiger', 'Bodysuit', 'Red, Navy, Grey', NULL, '477148', 12.99, NULL, 18, NULL, 'baby clothes
18 months
3 pair', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.631338', NULL, NULL);
INSERT INTO public.clothing VALUES (569, '0/3', 'Calvin Klein', 'Bodysuit', 'White, Grey, Pink', NULL, '184817', 12.99, NULL, 18, NULL, 'baby clothes
0-3 months
4 pair', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.63897', NULL, NULL);
INSERT INTO public.clothing VALUES (2126, '32X34', 'Tommy Hilfiger', 'Jeans', 'Navy', 164, '836419', 19.19, 58.93, 72, 22, 'Slim

waist: 43
hips: 52
pasadka: 27
length: 114', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-16 18:50:00.226212', NULL, 0.00);
INSERT INTO public.clothing VALUES (578, 'L', 'Calvin Klein', 'Sweat Pants', 'Black', 36, '561259', 14.19, NULL, 34, NULL, 'waist: 43
hips: 52
length: 104
pasadka: 31', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.716047', NULL, NULL);
INSERT INTO public.clothing VALUES (579, 'L', 'Calvin Klein', 'Hoodie', 'Black', 36, '676199', 15.97, NULL, 34, NULL, 'black gummy sign

chest: 56
length: 70
arm: 70', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.724028', NULL, NULL);
INSERT INTO public.clothing VALUES (580, 'XL', 'Calvin Klein', 'Sweat Pants', 'Black', 36, '561266', 14.19, NULL, 20, NULL, 'black gummy sign', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.732964', NULL, NULL);
INSERT INTO public.clothing VALUES (581, 'XL', 'Calvin Klein', 'Hoodie', 'Black', 36, '676205', 15.97, NULL, 20, NULL, 'black gummy sign', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.740734', NULL, NULL);
INSERT INTO public.clothing VALUES (1963, 'M', 'Tommy Hilfiger', 'Free Sweater', 'Black', 150, '415743', 15.99, NULL, 59, NULL, 'chest: 53
length: 73
arm: 70', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-01-08 10:28:06.403093', NULL, 0.00);
INSERT INTO public.clothing VALUES (597, '1SZ', 'Calvin Klein', 'Scarf', 'Pink', NULL, '506149', 19.99, NULL, 20, NULL, 'scarf + beanie cap + gloves in a box', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.872642', NULL, NULL);
INSERT INTO public.clothing VALUES (598, '1SZ', 'Calvin Klein', 'Scarf', 'Tan', NULL, '506156', 19.99, NULL, 20, NULL, 'scarf + beanie cap + gloves', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.881712', NULL, NULL);
INSERT INTO public.clothing VALUES (599, '1SZ', 'Calvin Klein', 'Scarf', 'Grey', NULL, '506163', 19.99, NULL, 20, NULL, 'scarf + beanie cap + gloves', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.890534', NULL, NULL);
INSERT INTO public.clothing VALUES (600, '1SZ', 'Michael Kors', 'Scarf', 'Black, White', NULL, '340390', 14.99, NULL, 20, NULL, 'black "MK" circle pattern', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.899656', NULL, NULL);
INSERT INTO public.clothing VALUES (601, 'L', 'Tommy Hilfiger', 'Sweater', 'Black', NULL, '130665', 12.00, NULL, 20, NULL, 'golfik', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.907202', NULL, NULL);
INSERT INTO public.clothing VALUES (602, 'S', 'Michael Kors', 'Sweater', 'White', NULL, '156285', 29.99, NULL, 20, NULL, 'Big misha korsov sign with rivets', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.916533', NULL, NULL);
INSERT INTO public.clothing VALUES (603, 'XS', 'Calvin Klein', 'Vest Jacket', 'White', NULL, 'XT7498', 25.00, NULL, 20, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.924315', NULL, NULL);
INSERT INTO public.clothing VALUES (604, 'M', 'Tommy Hilfiger', 'Sweat Shirt', 'Red', NULL, '0001', 19.99, 45.45, 21, 4, 'sold for 1300
mom has 1100

fluffy', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.933493', NULL, NULL);
INSERT INTO public.clothing VALUES (605, 'XS', 'Tommy Hilfiger', 'Hoodie', 'White', NULL, '0002', 22.99, 45.45, 21, 4, 'sold for 1300', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.941329', NULL, NULL);
INSERT INTO public.clothing VALUES (606, 'XS', 'Tommy Hilfiger', 'Sweat Pants', 'Teal', NULL, '0003', 15.99, NULL, 22, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.950527', NULL, NULL);
INSERT INTO public.clothing VALUES (607, 'XS', 'Tommy Hilfiger', 'Sweat Shirt', 'Navy', NULL, '792813', 15.99, 50.70, 22, 3, 'sold with 790779
sold for: 2900
have in cash: 2700

"Tommy Hilfiger" in block letters on chest

Chest: 47
Waist: 44
Length: 60
Arm: 58', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.958278', NULL, NULL);
INSERT INTO public.clothing VALUES (608, 'L', 'Tommy Hilfiger', 'Sweater', 'Black', NULL, '0004', 24.99, 45.45, 22, NULL, 'golfik', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.968405', NULL, NULL);
INSERT INTO public.clothing VALUES (609, 'L', 'Calvin Klein', 'Sweat Pants', 'Red', 17, '784691', 28.83, NULL, 23, NULL, 'sign "calvin" on calf', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.976504', NULL, NULL);
INSERT INTO public.clothing VALUES (610, 'M', 'Calvin Klein', 'Sweat Shirt', 'Red', 17, '784905', 28.83, 54.19, 23, 3, 'sold with 5391

sign calvin on shoulder', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.985701', NULL, NULL);
INSERT INTO public.clothing VALUES (612, 'S', 'Calvin Klein', 'Sweat Pants', 'White', 16, '785315', 24.40, 54.19, 23, 4, 'sold with 6373
sold for 3100
mom has 2900

off white 
stripe + calvin down side

Waist: 37
hips: 49
length: 95
pasadka: 26', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.003043', NULL, NULL);
INSERT INTO public.clothing VALUES (613, 'XS', 'Calvin Klein', 'Sweat Shirt', 'White', 16, '796373', 24.40, 54.19, 23, 4, 'sold with 5315

cream
calvin on shoulder', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.011997', NULL, NULL);
INSERT INTO public.clothing VALUES (614, '???', 'Calvin Klein', 'Sweat Shirt', 'White', NULL, '5464', 24.99, NULL, 23, NULL, 'black sign on chest', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.020642', NULL, NULL);
INSERT INTO public.clothing VALUES (617, 'S', 'Calvin Klein', 'Sweat Pants', 'Black', 17, '785414', 28.83, 50.88, 24, 4, 'sold with 4929

stripe + "calvin" on stripe

waist: 37
hips: 47
length: 92
pasadka: 24', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.045164', NULL, NULL);
INSERT INTO public.clothing VALUES (1682, '4', 'Levis', 'Vest Jacket', 'White', 56, '060625', 9.99, NULL, 46, 11, 'Kid Clothes', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:16.135847', NULL, NULL);
INSERT INTO public.clothing VALUES (1999, 'S', 'Calvin Klein', 'Belt', 'Grey', 154, '268694', 3.51, NULL, 59, NULL, 'logo belt
length: 95
', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 11:51:36.404015', NULL, 0.00);
INSERT INTO public.clothing VALUES (616, 'N/A', 'Michael Kors', 'Wallet', 'Black', NULL, '1402', 19.99, 48.95, 23, 16, 'sold for 1400
delivery $5', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.037383', NULL, NULL);
INSERT INTO public.clothing VALUES (622, 'M', 'Calvin Klein', 'Sweater', 'Red', 21, '784905', 24.17, NULL, 25, NULL, 'Long neck
Black patch on shoulder

Chest: 64
Waist: 58
Length: 64
Arm: 67', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.094368', NULL, NULL);
INSERT INTO public.clothing VALUES (633, 'S', 'Calvin Klein', 'Puffy Jacket', 'Blue', 21, '100087', 48.76, 108.39, 27, NULL, 'sold for 3100

women
packable', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.191167', NULL, NULL);
INSERT INTO public.clothing VALUES (628, 'S', 'Calvin Klein', 'Sweat Pants', 'White', NULL, '790661', 19.99, 50.70, 29, 3, 'sold with 4940

words down leg
"calvin klein performance" square

Waist: 40
Hips: 49
Length: 97
Pasadka: 25', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.149369', NULL, NULL);
INSERT INTO public.clothing VALUES (631, '1SZ', 'Tommy Hilfiger', 'Hat', 'White', 20, '561914', 12.74, NULL, 27, NULL, 'beanie cap', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.173343', NULL, NULL);
INSERT INTO public.clothing VALUES (632, 'L', 'Calvin Klein', 'Puffy Jacket', 'Black', 21, '873333', 74.50, 146.85, 27, NULL, 'sold for 4200', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.182591', NULL, NULL);
INSERT INTO public.clothing VALUES (635, 'S', 'Tommy Hilfiger', 'Sweat Shirt', 'White', NULL, '3178', 22.99, NULL, 28, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.207685', NULL, NULL);
INSERT INTO public.clothing VALUES (637, 'S', 'Calvin Klein', 'Sweat Pants', 'Red', NULL, '784714', 28.83, NULL, 28, NULL, 'Black stripe down side

Waist: 40
Hips: 48
Length: 92
Pasadka: 23', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.224305', NULL, NULL);
INSERT INTO public.clothing VALUES (638, 'XS', 'Tommy Hilfiger', 'Hoodie', 'Navy', NULL, '2108', 0.00, NULL, 29, NULL, 'Block letters on chest', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.233519', NULL, NULL);
INSERT INTO public.clothing VALUES (1964, 'M', 'Tommy Hilfiger', 'Free Sweater', 'Navy', 150, '394819', 15.99, NULL, 62, NULL, 'chest: 53
length: 73
arm: 70', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-01-08 10:29:14.995679', NULL, 0.00);
INSERT INTO public.clothing VALUES (642, 'S', 'Michael Kors', 'Puffy Jacket', 'Black', NULL, '0012', 59.99, NULL, 30, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.267745', NULL, NULL);
INSERT INTO public.clothing VALUES (726, 'M', 'Tommy Hilfiger', 'Puffy Jacket', 'Red, Navy, White', NULL, '218102', 59.99, NULL, 34, NULL, 'long
red hood
navy body
white "v" line across chest

chest: 54
length: 86
arm: 63', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.002861', NULL, NULL);
INSERT INTO public.clothing VALUES (683, 'XS', 'Tommy Hilfiger', 'Windbreaker', 'White', 44, '912171', 55.79, NULL, 60, NULL, '2 jackets in 1.
hooded

chest: 50
Waist: 44
length: 73
arm: 73', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.642579', NULL, 0.00);
INSERT INTO public.clothing VALUES (690, 'XXS', 'Tommy Hilfiger', 'Sweat Shirt', 'Navy', 45, '733301', 13.99, NULL, 72, NULL, 'red/white waist-band
adjustable waist

Chest: 45
length: 54
arm: 56', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.70589', NULL, 0.00);
INSERT INTO public.clothing VALUES (691, 'XS', 'Tommy Hilfiger', 'Sweat Shirt', 'Navy', 45, '733318', 13.99, NULL, 75, NULL, 'red/white waist-band
adjustable waist

Chest: 50
length: 54
arm: 55', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.715116', NULL, 0.00);
INSERT INTO public.clothing VALUES (730, 'M', 'Ralph Lauren', 'Puffy Jacket', 'Black', NULL, '334538', 14.99, NULL, 33, NULL, 'short
gold zippers

chest: 49
length: 59
arm: 60', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.039174', NULL, NULL);
INSERT INTO public.clothing VALUES (731, 'N/A', 'Tommy Hilfiger', 'Bag', 'Grey', NULL, 'none', 0.00, NULL, 33, NULL, 'gift tote bag
2 in this package', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.052763', NULL, NULL);
INSERT INTO public.clothing VALUES (745, 'L', 'Tommy Hilfiger', 'Sweater', 'White', 49, '653794', 17.49, NULL, 34, NULL, 'double helix pattern

Chest: 51
length: 61
arm: 60', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.171039', NULL, NULL);
INSERT INTO public.clothing VALUES (753, 'XS', 'Tommy Hilfiger', 'Hoodie', 'Green', 49, '432030', 29.39, NULL, 34, NULL, 'Chest: 46
length: 53
arm: 59', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.237923', NULL, NULL);
INSERT INTO public.clothing VALUES (777, 'L', 'U.S. Polo Assn.', 'Hoodie', 'Black', NULL, '566350', 24.99, NULL, 34, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.450192', NULL, NULL);
INSERT INTO public.clothing VALUES (778, 'L', 'Levis', 'Puffy Jacket', 'Black', 35, '640305', 32.49, NULL, 34, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.45849', NULL, NULL);
INSERT INTO public.clothing VALUES (779, 'M', 'Karl Lagerfeld', 'T-Shirt', 'Black', NULL, '987977', 19.99, NULL, 34, NULL, 'Flower "Karl"

Chest: 52
Waist: 49
Length: 63', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.467365', NULL, NULL);
INSERT INTO public.clothing VALUES (782, 'S', 'Calvin Klein', 'Sweat Pants', 'Pink', 53, '784561', 13.14, NULL, 60, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.493174', NULL, 0.00);
INSERT INTO public.clothing VALUES (749, 'S', 'Tommy Hilfiger', 'Sweat Pants', 'Navy', 50, '621540', 24.49, NULL, 75, NULL, 'Red at pockets

waist: 40
hips: 51
length: 93
pasadka: 27', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.204948', NULL, 0.00);
INSERT INTO public.clothing VALUES (751, 'S', 'Tommy Hilfiger', 'Hoodie', 'White, Red, Navy', 50, '652155', 22.39, NULL, 75, NULL, 'Navy front
red/white back

Chest: 51
length: 61
arm: 57', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.221516', NULL, 0.00);
INSERT INTO public.clothing VALUES (800, 'XS', 'Calvin Klein', 'Puffy Jacket', 'Silver', 54, '888108', 28.00, NULL, 57, NULL, 'space suit

chest: 56
length: 75
arm: 62', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.654626', NULL, 0.00);
INSERT INTO public.clothing VALUES (1967, 'L', 'Tommy Hilfiger', 'Free Sweater', 'Black', 150, '415750', 15.99, NULL, 62, NULL, 'chest: 55
length: 76
arm: 74', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-01-08 10:33:31.501853', NULL, 0.00);
INSERT INTO public.clothing VALUES (799, 'S', 'Calvin Klein', 'Puffy Jacket', 'Silver', 54, '888092', 28.00, NULL, 65, NULL, 'space suit

chest: 60
length: 78
arm: 64', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.645866', NULL, 0.00);
INSERT INTO public.clothing VALUES (733, '38W', 'Calvin Klein', 'Shorts', 'Blue', NULL, '850567', 12.00, 16.20, 32, 9, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.06893', NULL, NULL);
INSERT INTO public.clothing VALUES (734, 'M', 'Calvin Klein', 'Shorts', 'Pink', NULL, '350193', 12.00, 16.20, 32, 9, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.076995', NULL, NULL);
INSERT INTO public.clothing VALUES (2305, 'XS', 'Tommy Hilfiger', 'Hoodie', 'Navy, Red, White', NULL, '652148', 19.00, NULL, 72, NULL, 'Tommy Jeans
Navy front
red/white back

chest: 48
length: 60
arm: 56
shoulders: 45', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-26 15:51:27.577846', NULL, 0.00);
INSERT INTO public.clothing VALUES (735, 'XS', 'Calvin Klein', 'Shorts', 'Pink', NULL, '350216', 12.00, 16.20, 32, 9, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.085853', NULL, NULL);
INSERT INTO public.clothing VALUES (736, 'XS', 'Calvin Klein', 'Shorts', 'Pink', NULL, '350216', 12.00, 16.20, 32, 9, NULL, NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.093875', NULL, NULL);
INSERT INTO public.clothing VALUES (2275, 'S', 'DKNY', 'Puffy Jacket', 'Black', NULL, '391329', 49.99, 101.79, 69, 19, 'from costco

chest: 53
length: 87
arm: 63
shoulders: 42', false, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-23 21:20:06.55249', NULL, 8.68);
INSERT INTO public.clothing VALUES (2121, 'L', 'Calvin Klein', 'Sweat Pants', 'Black', 163, '471614', 19.99, NULL, 73, NULL, 'Calvin in front
Klein on back
non-sewn waist

waist: 42
hips:  53
pasadka: 27
length: 96', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-16 18:44:11.492041', NULL, 0.00);
INSERT INTO public.clothing VALUES (2355, 'XXS', 'Calvin Klein', 'T-Shirt', 'Black', 188, '855797', 12.74, NULL, 74, NULL, 'Gold stones "calvin klein"

chest: 41
length: 60', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-31 15:12:32.941238', NULL, 0.00);
INSERT INTO public.clothing VALUES (1970, 'S', 'Tommy Hilfiger', 'Sweat Shirt', 'White', 150, '621991', 10.39, NULL, 62, NULL, 'zipper on neck

chest: 50
length: 60
arm: 61', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 10:45:37.656206', NULL, 0.00);
INSERT INTO public.clothing VALUES (997, '2', 'Tommy Hilfiger', 'Pants', 'Navy', 76, '159330', 11.19, 12.20, 39, 10, 'Waist: 39
Hips: 44
Length: 94
Pasadka: 21', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:09.772312', NULL, NULL);
INSERT INTO public.clothing VALUES (2178, 'S', 'Tommy Hilfiger', 'Dress', 'Black', 169, '440004', 27.99, NULL, 70, NULL, 'cursive sign

chest: 48
length: 87
arm: 60', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-21 17:03:42.482046', NULL, 0.00);
INSERT INTO public.clothing VALUES (2371, 'XS', 'Calvin Klein', 'Puffy Jacket', 'White', NULL, '056377', 0.00, 110.71, 74, 19, 'rainbow spacesuit

chest: 57
length: 80
arm: 60', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-31 15:33:21.395471', NULL, 5.67);
INSERT INTO public.clothing VALUES (923, 'M', 'Tommy Hilfiger', 'Dress Shirt', 'White', 61, '7082', 9.74, 35.00, 36, 19, 'M

Chest: 56
Waist: 52
Length: 68
Arm: 68', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:09.065155', NULL, 3.00);
INSERT INTO public.clothing VALUES (2294, 'XS', 'DKNY', 'Puffy Jacket', 'Black', NULL, '391336', 49.99, 101.79, 69, 19, 'from costco

chest: 50
length: 84
arm: 63
shoulders: 41', false, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-25 15:00:03.585818', NULL, 8.68);
INSERT INTO public.clothing VALUES (2152, 'S', 'DKNY', 'Puffy Jacket', 'Grey', NULL, '391251', 49.99, 101.79, 71, 19, 'from costco

chest: 53
length: 87
arm: 63
shoulders: 42', true, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-18 15:39:50.427287', NULL, 11.92);
INSERT INTO public.clothing VALUES (2295, 'M', 'DKNY', 'Puffy Jacket', 'Grey', NULL, '391244', 49.99, 101.79, 72, 19, 'from costco

chest: 56
length: 88
arm: 66
shoulders: 43', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-25 15:00:33.041037', NULL, 3.42);
INSERT INTO public.clothing VALUES (2170, 'XS', 'Calvin Klein', 'T-Shirt', 'White', 168, '801473', 12.74, NULL, 65, NULL, 'Oversized
payetki sign

chest: 47
length: 50', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-21 16:54:57.08732', NULL, 0.00);
INSERT INTO public.clothing VALUES (689, 'M', 'Tommy Hilfiger', 'Sweat Pants', 'Navy', 45, '786840', 13.99, NULL, 128, NULL, 'red/white waist-band
red/white Hilfiger on ankle

Waist: 44
hips: 52
length: 100
pasadka: 28', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.697284', NULL, 6.75);
INSERT INTO public.clothing VALUES (2065, 'L', 'Karl Lagerfeld', 'Hoodie', 'Black', 158, '849169', 29.99, NULL, 69, NULL, 'chest: 58
length: 70
arm: 62/81', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-01-13 11:21:55.569265', NULL, 0.00);
INSERT INTO public.clothing VALUES (2278, '0', 'Calvin Klein', 'Dress', 'Grey', 181, '652172', 9.26, NULL, 72, NULL, 'mid length

chest: 45
length: 112
hips: 45', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-23 21:30:30.734939', NULL, 0.00);
INSERT INTO public.clothing VALUES (2374, 'M', 'Calvin Klein', 'Sweat Pants', 'White, Cream', NULL, '956876', 19.99, NULL, 74, NULL, 'black glossy sign
calvin along leg', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-31 18:28:46.783853', NULL, NULL);
INSERT INTO public.clothing VALUES (2008, 'XS', 'Calvin Klein', 'Sweat Pants', 'Black', 154, '785421', 14.05, NULL, 59, NULL, 'with Calvin on calf
waist: 36
hips: 46
length: 93
pasadka: 23', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 12:05:03.266614', NULL, 0.00);
INSERT INTO public.clothing VALUES (2183, 'S', 'Tommy Hilfiger', 'Windbreaker', 'Navy, White', 170, '686409', 32.00, NULL, 65, NULL, 'chest: 48
length: 65
arm: 63
shoulders: 39', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-21 17:11:45.218737', NULL, 0.00);
INSERT INTO public.clothing VALUES (2256, '0', 'Tommy Hilfiger', 'Jeans', 'Navy', NULL, '440547', 0.00, NULL, 65, NULL, 'stretch skinny

waist: 35
hips: 41
pasadka: 23
length: 95', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-22 11:56:06.961372', NULL, NULL);
INSERT INTO public.clothing VALUES (2107, 'M', 'DKNY', 'Puffy Jacket', 'Grey', NULL, '391244', 49.99, 101.79, 57, 19, 'from costco

chest: 56
length: 88
arm: 66
shoulders: 43', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-16 14:38:22.211607', NULL, 7.69);
INSERT INTO public.clothing VALUES (2246, 'XS', 'DKNY', 'Puffy Jacket', 'Grey', NULL, '391268', 49.99, 101.79, 69, 22, 'from costco

chest: 50
length: 84
arm: 63
shoulders: 41', false, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-22 10:29:07.450716', NULL, 0.00);
INSERT INTO public.clothing VALUES (2334, 'L', 'Armani Exchange', 'Hoodie', 'Blue', 186, '147485', 35.99, 64.29, 74, 22, 'zipped

chest: 58
length: 69
arm: 68
shoulders: 51
', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-31 14:53:22.611733', NULL, 0.00);
INSERT INTO public.clothing VALUES (2153, 'S', 'DKNY', 'Puffy Jacket', 'Grey', NULL, '391251', 49.99, 101.79, 65, 22, 'from costco

chest: 53
length: 87
arm: 63
shoulders: 42', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-18 15:39:51.045961', NULL, 0.00);
INSERT INTO public.clothing VALUES (2182, 'L', 'Tommy Hilfiger', 'Windbreaker', 'Navy, White', 170, '686423', 32.00, 66.43, 65, 22, 'chest: 54
length: 67
arm: 64
shoulders: 43', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-21 17:09:43.119615', NULL, 0.00);
INSERT INTO public.clothing VALUES (2105, 'S', 'DKNY', 'Puffy Jacket', 'Grey', NULL, '391251', 49.99, 101.79, 57, 22, 'from costco

chest: 53
length: 87
arm: 63
shoulders: 42', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-16 14:37:20.850145', NULL, 0.00);
INSERT INTO public.clothing VALUES (2104, 'N/A', 'Armani Exchange', 'Bag', 'White', 162, '786539', 39.99, 82.14, 65, 22, 'length: 42
width: 15
height: 24', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-16 14:35:02.743502', NULL, 0.00);
INSERT INTO public.clothing VALUES (2277, 'XL', 'Calvin Klein', 'Puffy Jacket', 'Grey', 181, '873241', 39.22, 121.43, 69, 22, 'chest: 68
length: 71
arm: 67
shoulders: 53', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-23 21:29:11.795666', NULL, 0.00);
INSERT INTO public.clothing VALUES (2148, 'XS', 'DKNY', 'Puffy Jacket', 'Grey', NULL, '391268', 49.99, 101.79, 65, 22, 'from costco

chest: 50
length: 84
arm: 63
shoulders: 41', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-18 15:38:50.315073', NULL, 0.00);
INSERT INTO public.clothing VALUES (2317, 'M', 'Michael Kors', 'Puffy Jacket', 'Black', NULL, '280286', 70.80, 130.00, 74, 22, 'chest: 54
length: 72
arm: 62
shoulders: 41', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-31 14:35:26.978427', NULL, 0.00);
INSERT INTO public.clothing VALUES (2332, 'L', 'Armani Exchange', 'Sweat Pants', 'Blue', 186, '776745', 26.99, 60.71, 105, 22, 'waist: 45
hips: 56
pasadka: 32
length: 108', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-01-31 14:51:49.642049', NULL, 0.00);
INSERT INTO public.clothing VALUES (2101, '6', 'Armani Exchange', 'Blazer', 'Black', 162, '365742', 96.00, 139.50, 58, 21, 'white stripe on side', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-16 14:26:14.078811', NULL, 0.00);
INSERT INTO public.clothing VALUES (2033, '28', 'Armani Exchange', 'Jeans', 'Navy', 162, '371378', 39.99, 69.75, 58, 21, 'super skinny
button fly', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 13:20:43.491672', NULL, 0.00);
INSERT INTO public.clothing VALUES (2102, '28', 'Armani Exchange', 'Jeans', 'Grey', 162, '458112', 39.99, 69.75, 58, 21, 'with stripe down side

waist: 34
hips: 42
pasadka: 22
length: 98', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-16 14:27:47.241771', NULL, 0.00);
INSERT INTO public.clothing VALUES (2142, 'XL', 'Michael Kors', 'Puffy Jacket', 'Black', NULL, '126636', 56.00, NULL, 71, NULL, 'chest: 70
length: 76
arm: 67', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-01-16 19:13:28.707657', NULL, 0.00);
INSERT INTO public.clothing VALUES (2156, 'XL', 'DKNY', 'Puffy Jacket', 'Grey', NULL, '391220', 49.99, NULL, 72, NULL, 'from costco

chest: 62
length: 90
arm: 67
arm: 47', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-18 15:40:42.581518', NULL, 0.00);
INSERT INTO public.clothing VALUES (2068, 'L', 'Tommy Hilfiger', 'T-Shirt', 'White', 158, '437689', 11.00, 14.82, 64, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-13 11:25:35.384706', NULL, 0.00);
INSERT INTO public.clothing VALUES (1971, 'XS', 'Tommy Hilfiger', 'Puffy Jacket', 'Navy', NULL, '954690', 40.01, 54.01, 64, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 10:47:11.762907', NULL, 0.00);
INSERT INTO public.clothing VALUES (2011, 'XS', 'Calvin Klein', 'Sweat Pants', 'Black', 154, '785421', 14.05, NULL, 59, NULL, 'with Calvin on calf
waist: 36
hips: 46
length: 93
pasadka: 23', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 12:07:31.993828', NULL, 0.00);
INSERT INTO public.clothing VALUES (474, 'L', 'Calvin Klein', 'Puffy Jacket', 'Black', 37, '871988', 35.13, NULL, 74, NULL, 'Men
shiny

chest: 65
length: 73
arm: 71', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.80758', NULL, 0.00);
INSERT INTO public.clothing VALUES (1450, '???', 'Calvin Klein', 'Unknown', 'Unknown', 132, '068120', 4.90, 6.69, 52, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:13.99559', NULL, 0.00);
INSERT INTO public.clothing VALUES (2074, 'M', 'Calvin Klein', 'Golfik', 'White', 159, 'M9VS8092', 10.00, 13.56, 61, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-13 11:39:01.740327', NULL, 4.93);
INSERT INTO public.clothing VALUES (2137, 'S', 'DKNY', 'Golfik', 'Black', 166, '185690', 17.99, NULL, 73, NULL, 'grey stripe

chest: 48
length: 64
arm: 61', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-16 19:05:21.540175', NULL, 0.00);
INSERT INTO public.clothing VALUES (2157, 'XL', 'DKNY', 'Puffy Jacket', 'Black', NULL, '391299', 49.99, 101.79, 63, 19, 'from costco

chest: 62
length: 90
arm: 67
arm: 47', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-18 15:41:16.654817', NULL, 11.23);
INSERT INTO public.clothing VALUES (2378, 'S', 'Levis', 'T-Shirt', 'White, Grey, Blue', NULL, 'L002', 12.00, NULL, 74, NULL, 'boxed pack of t-shirts', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-31 18:36:06.484708', NULL, NULL);
INSERT INTO public.clothing VALUES (2341, 'L', 'Calvin Klein', 'Sweat Pants', 'Black', 187, '750061', 19.99, NULL, 74, NULL, 'calvin klein on side

waist: 42
hips: 53
pasadka: 28
length: 102', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-31 15:03:48.209595', NULL, 0.00);
INSERT INTO public.clothing VALUES (2138, 'S', 'Tommy Hilfiger', 'Sweat Shirt', 'White', NULL, '830956', 19.99, NULL, 70, NULL, 'flag on chest

chest: 46
length: 63
arm: 66', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-16 19:08:27.888961', NULL, 0.00);
INSERT INTO public.clothing VALUES (2379, 'XL', 'Levis', 'T-Shirt', 'White', NULL, 'L003', 12.00, NULL, 74, NULL, 'boxed pack of t-shirts', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-31 18:36:35.723075', NULL, NULL);
INSERT INTO public.clothing VALUES (2047, 'M', 'Armani Exchange', 'Sweater', 'Navy', 156, '349512', 9.99, 13.61, 64, 9, 'chest: 50
length: 65
arm: 66', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 13:31:57.549536', NULL, 0.00);
INSERT INTO public.clothing VALUES (171, 'XL', 'Levis', 'Jean Jacket', 'Navy', NULL, '560756', 39.99, NULL, 6, NULL, 'Men

Chest: 63
Waist: 62
Length: 70
Arm: 68
Shoulder: 49', false, 'men', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:55.169611', NULL, NULL);
INSERT INTO public.clothing VALUES (2071, 'L', 'Tommy Hilfiger', 'Sweater', 'Navy', 158, '714394', 15.00, 44.64, 75, 19, NULL, NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-01-13 11:29:03.056109', NULL, 7.29);
INSERT INTO public.clothing VALUES (1673, '0', 'Nike', 'Onesie', 'Black', 56, '135835', 29.99, NULL, 46, 11, 'Kid Clothes', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:16.055001', NULL, NULL);
INSERT INTO public.clothing VALUES (1674, '0', 'Nike', 'Jacket', 'Black', 56, '650048', 19.99, NULL, 46, 11, 'Kid Clothes
Comes with white t-shirt and 
black shorts', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:16.063765', NULL, NULL);
INSERT INTO public.clothing VALUES (1675, '4T', 'Calvin Klein', 'Jacket', 'Grey', 56, '273603', 12.99, NULL, 46, 11, 'Kid Clothes', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:16.07243', NULL, NULL);
INSERT INTO public.clothing VALUES (1676, '12M', 'Tommy Hilfiger', 'Jacket', 'Grey, Blue, Red', 56, '268777', 14.99, NULL, 46, 11, 'Kid Clothes

Comes with pants', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:16.081756', NULL, NULL);
INSERT INTO public.clothing VALUES (1677, '12M', 'Calvin Klein', 'Sweat Shirt', 'Blue, Grey', 56, '184718', 14.99, NULL, 46, 11, 'Kid Clothes

Comes with pants', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:16.090317', NULL, NULL);
INSERT INTO public.clothing VALUES (1678, '12M', 'Tommy Hilfiger', 'Onesie', 'Grey, Red, Blue', 56, '203501', 12.99, NULL, 46, 11, 'Kid Clothes', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:16.099699', NULL, NULL);
INSERT INTO public.clothing VALUES (1679, '4', 'Calvin Klein', 'Jacket', 'White, Black', 56, '062811', 16.99, NULL, 46, 11, 'Kid Clothes

Comes with pants', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:16.10859', NULL, NULL);
INSERT INTO public.clothing VALUES (1680, '6', 'Calvin Klein', 'Sweat Shirt', 'Navy, Grey', 56, '184329', 16.99, NULL, 46, 11, 'Kid Clothes

Comes with pants', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:16.118233', NULL, NULL);
INSERT INTO public.clothing VALUES (1681, 'M', 'Levis', 'Vest Jacket', 'Blue, Red, White', 56, '921584', 39.99, NULL, 46, 11, 'Kid Clothes', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:16.126599', NULL, NULL);
INSERT INTO public.clothing VALUES (2307, 'XS', 'Tommy Hilfiger', 'Hoodie', 'Navy', NULL, '438223', 20.00, 48.21, 70, 23, 'with zipper

chest: 47
length: 60
arm: 57
shoulders: 41', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-26 16:15:33.785964', NULL, NULL);
INSERT INTO public.clothing VALUES (1685, '8', 'Levis', 'Vest Jacket', 'Blue, Red, White', 56, '921577', 39.99, NULL, 46, 11, 'Kid Clothes', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:16.162021', NULL, NULL);
INSERT INTO public.clothing VALUES (1686, '2', 'Nike', 'Puffy Jacket', 'Black, White', 56, '847021', 24.99, NULL, 46, 11, 'Kid Clothes', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:16.171042', NULL, NULL);
INSERT INTO public.clothing VALUES (1687, '2', 'DKNY', 'Jacket', 'Pink', 56, '458352', 14.99, NULL, 46, 11, 'Kid Clothes', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:16.17937', NULL, NULL);
INSERT INTO public.clothing VALUES (1688, '4T', 'DKNY', 'Puffy Jacket', 'Pink', 56, '333642', 19.99, NULL, 46, 11, 'Kid Clothes', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:16.188819', NULL, NULL);
INSERT INTO public.clothing VALUES (1689, 'L', 'DKNY', 'Fluffy Jacket', 'Black, Pink', 56, '517479', 16.99, NULL, 46, 11, 'Kid Clothes', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:16.197768', NULL, NULL);
INSERT INTO public.clothing VALUES (1690, 'M', 'DKNY', 'Jacket', 'Black', 56, '449961', 29.99, NULL, 46, 11, 'Kid Clothes', NULL, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:16.206558', NULL, NULL);
INSERT INTO public.clothing VALUES (2264, 'XXL', 'Tommy Hilfiger', 'Sweater', 'Burgundy', 179, '394703', 15.99, 0.00, 67, 9, NULL, NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-01-23 19:28:49.1593', NULL, 0.00);
INSERT INTO public.clothing VALUES (2014, 'XS', 'Calvin Klein', 'Sweat Shirt', 'Black', 155, '796472', 15.99, NULL, 108, NULL, 'stripe + "calvin" on shoulder

chest: 53
length: 58-67
arm: 43-66', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 12:12:00.732156', NULL, 5.67);
INSERT INTO public.clothing VALUES (2108, 'XS', 'DKNY', 'Puffy Jacket', 'Black', NULL, '391336', 49.99, 101.79, 57, 22, 'from costco

chest: 50
length: 84
arm: 63
shoulders: 41', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-16 14:39:07.571745', NULL, 0.00);
INSERT INTO public.clothing VALUES (2299, 'M', 'Calvin Klein', 'Sweat Pants', 'White, Cream', NULL, '879076', 10.00, 33.93, 69, 22, 'old collection
waist: 42
hips: 52
pasadka: 26
length: 93', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-25 15:42:24.251858', NULL, NULL);
INSERT INTO public.clothing VALUES (2328, 'N/A', 'Armani Exchange', 'Purse', 'Black', 186, '652285', 26.99, 75.00, 74, 22, 'letters all around
length: 90
height: 13
width: 7', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-31 14:48:39.261333', NULL, 0.00);
INSERT INTO public.clothing VALUES (2276, 'M', 'DKNY', 'Puffy Jacket', 'Grey', NULL, '391244', 49.99, 101.79, 69, 22, 'from costco

chest: 56
length: 88
arm: 66
shoulders: 43', false, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-23 21:20:13.501132', NULL, 0.00);
INSERT INTO public.clothing VALUES (2216, 'L', 'DKNY', 'Puffy Jacket', 'Grey', 174, '992198', 65.00, 117.86, 74, 22, 'chest: 66
length: 90
arm: 70
shoulders: 54', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-01-21 17:49:00.331686', NULL, 0.00);
INSERT INTO public.clothing VALUES (2362, 'XS', 'Calvin Klein', 'Sweat Pants', 'Black', NULL, '082933', 24.99, 50.00, 74, 22, 'White outlined black stripe with "cavin klein ck" down leg

Waist: 36
Hips: 47
Length: 90
Pasadka: 23', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-31 15:23:52.36623', NULL, 0.00);
INSERT INTO public.clothing VALUES (2191, 'N/A', 'Armani Exchange', 'Purse', 'Navy', 171, '652629', 29.99, 67.86, 66, 22, 'Glossy/Shiny
length: 19
height: 15
width: 7', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-21 17:22:22.947783', NULL, 0.00);
INSERT INTO public.clothing VALUES (2310, 'S', 'Tommy Hilfiger', 'Sweat Pants', 'Navy', NULL, '436830', 20.00, 48.21, 72, 22, 'white stripe on leg

waist: 38
hips: 52
pasadka: 25
length: 93', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-27 16:04:26.459366', NULL, NULL);
INSERT INTO public.clothing VALUES (1726, 'S', 'Calvin Klein', 'Sweater', 'Black', 56, 'HS6041', 19.99, 26.99, 52, 9, 'Tag number is last 6 letters/numbers of style number.
', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:16.542683', NULL, 0.00);
INSERT INTO public.clothing VALUES (1727, 'S', 'Calvin Klein', 'Sweater', 'White', 56, 'HSN076', 19.99, 26.99, 52, 9, 'Tag number is last 6 letters/numbers of style number.

Gold buttons on shoulder

Chest: 42
Waist: 39
Length: 63
Arm: 62', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:16.552063', NULL, 0.00);
INSERT INTO public.clothing VALUES (1728, 'M', 'DKNY', 'Sport Bra', 'Black', 56, '??????', 8.00, 0.39, 52, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:16.560349', NULL, 0.00);
INSERT INTO public.clothing VALUES (1721, 'M', 'Michael Kors', 'Sweater', 'White', 56, '066509', 31.48, 42.50, 52, 9, 'black stripes

chest: 50
length: 63
arm: 65', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:16.498477', NULL, 0.00);
INSERT INTO public.clothing VALUES (2015, 'N/A', 'Calvin Klein', 'Bag', 'Black', 155, '269452', 15.99, NULL, 72, NULL, 'Width: 47
Height: 30', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 12:12:37.152495', NULL, 0.00);
INSERT INTO public.clothing VALUES (2076, 'L', 'Tommy Hilfiger', 'Golfik', 'Purple', 159, '129836', 10.00, 13.56, 64, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-13 11:40:28.970631', NULL, 0.00);
INSERT INTO public.clothing VALUES (1724, 'M', 'Tommy Hilfiger', 'Sweater', 'Tan', 56, '130177', 15.00, 20.25, 52, 9, 'golfik

chest: 46
length: 64
arm: 61', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:16.524997', NULL, 0.00);
INSERT INTO public.clothing VALUES (1725, 'S', 'Tommy Hilfiger', 'Sweater', 'White', 56, '130269', 12.00, 16.20, 52, 9, 'turtle neck
"golfik"

chest: 46
length: 62
arm: 60', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:16.534466', NULL, 0.00);
INSERT INTO public.clothing VALUES (1722, 'S', 'Tommy Hilfiger', 'Sweater', 'Navy', 56, '130474', 13.00, 17.55, 52, 9, 'golfik
ribbed lines on chest

chest: 45
length: 61
arm: 59', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:16.50724', NULL, 0.00);
INSERT INTO public.clothing VALUES (1723, 'L', 'Calvin Klein', 'Panties', 'Unknown', 56, '351622', 6.00, 8.10, 52, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:16.516407', NULL, 0.00);
INSERT INTO public.clothing VALUES (1983, 'L', 'Tommy Hilfiger', 'Sweater', 'Blue', NULL, '711546', 10.00, 13.50, 64, 9, 'v-neck', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 11:33:50.630872', NULL, 0.00);
INSERT INTO public.clothing VALUES (70, 'M', 'Calvin Klein', 'Sweat Pants', 'Red', 9, '764956', 17.21, 23.18, 55, 9, 'Grey "CK" + white "Calvin Klein Jeans" on pocket

Waist: 45
Hips: 54
Length: 104
Pasadka: 29', true, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.25213', NULL, 0.00);
INSERT INTO public.clothing VALUES (2016, 'S', 'Calvin Klein', 'T-Shirt', 'Black', 155, '803651', 11.99, NULL, 59, NULL, 'payetki sign on chest

chest: 43
length: 64', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 12:12:59.442691', NULL, 0.00);
INSERT INTO public.clothing VALUES (2017, 'XS', 'Calvin Klein', 'T-Shirt', 'Black', 155, '803668', 11.99, NULL, 59, NULL, 'payetki sign on chest

chest: 40
length: 62', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 12:13:36.597386', NULL, 0.00);
INSERT INTO public.clothing VALUES (41, 'XS', 'Karl Lagerfeld', 'T-Shirt', 'Black', 6, '886348', 16.99, NULL, 21, NULL, 'Gold sequins "Karl" on chest

Chest: 44
Waist: 42
Length: 59', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:53.987828', NULL, NULL);
INSERT INTO public.clothing VALUES (67, 'S', 'Calvin Klein', 'Sweat Shirt', 'Purple', NULL, '9933', 19.99, 41.96, 26, 16, 'sold for 1200
Fluffy
Belly pocket', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.226584', NULL, NULL);
INSERT INTO public.clothing VALUES (53, 'XS', 'Calvin Klein', 'Hoodie', 'Mint', 7, '827626', 29.75, NULL, 1, NULL, 'Black "Calvin" across chest
Belly pocket

Chest: 53
Waist: 51
Length: 51
Arm: 67', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.103142', NULL, NULL);
INSERT INTO public.clothing VALUES (55, 'S', 'Calvin Klein', 'Sweat Pants', 'Pink', 7, '827282', 29.75, NULL, 4, NULL, 'Black "Calvin" on calf
Has pockets

Waist: 39
Hips: 47
Length: 93
Pasadka: 25', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.120318', NULL, NULL);
INSERT INTO public.clothing VALUES (57, 'XS', 'Calvin Klein', 'Hoodie', 'Pink', 7, '827565', 29.75, NULL, 1, NULL, 'Black "Calvin" across chest
Belly Pocket

Chest: 53
Waist: 50
Length: 51
Arm: 66', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.138584', NULL, NULL);
INSERT INTO public.clothing VALUES (59, 'XS', 'Calvin Klein', 'Sweat Pants', 'Mint', 7, '827343', 29.75, NULL, 1, NULL, 'Black "Calvin" on calf
Has pockets

Waist: 38
Hips: 45
Length: 93
Pasadka: 24', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.157196', NULL, NULL);
INSERT INTO public.clothing VALUES (60, 'XS', 'Calvin Klein', 'Sweat Pants', 'Pink', 7, '827299', 29.75, NULL, 1, NULL, 'Black "Calvin" on calf
Has pockets

Waist: 38
Hips: 45
Length: 93
Pasadka: 24', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.166394', NULL, NULL);
INSERT INTO public.clothing VALUES (2018, 'L', 'Calvin Klein', 'Bomber Jacket', 'Black', 155, '015283', 20.74, 71.07, 60, 19, 'chest: 56
length: 63
arm: 64', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 12:15:00.158028', NULL, 6.35);
INSERT INTO public.clothing VALUES (1995, 'L', 'Calvin Klein', 'Belt', 'Brown', 154, '268632', 3.51, 28.57, 57, 19, 'Logo belt
length: 110
width: 2.5', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 11:49:22.891598', NULL, 7.69);
INSERT INTO public.clothing VALUES (2145, 'N/A', 'Calvin Klein', 'Backpack', 'Gold, White', NULL, '701628', 49.99, NULL, 59, NULL, 'TJ maxx # 226399
', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-17 18:56:32.111318', NULL, 0.00);
INSERT INTO public.clothing VALUES (555, 'XS', 'Calvin Klein', 'Sweat Pants', 'Tan', NULL, '??????', 0.00, NULL, 9, NULL, NULL, true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.509139', NULL, NULL);
INSERT INTO public.clothing VALUES (1978, 'XS', 'Calvin Klein', 'T-Shirt', 'Pink', 152, '525195', 14.99, NULL, 62, NULL, 'white / silver logo on chest
chest: 41
length: 61', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 11:01:29.737138', NULL, 0.00);
INSERT INTO public.clothing VALUES (1969, 'M', 'Tommy Hilfiger', 'Sweat Shirt', 'White', 150, '622004', 10.39, NULL, 62, NULL, 'zipper on neck

chest: 52
length: 62
arm: 61', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 10:44:32.764473', NULL, 0.00);
INSERT INTO public.clothing VALUES (520, 'M', 'Calvin Klein', 'Puffy Jacket', 'Black', 38, '934478', 42.01, NULL, 19, NULL, 'Long
man

chest: 58
Length: 89
arm: 67', true, 'men', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.21098', NULL, 0.00);
INSERT INTO public.clothing VALUES (712, 'S', 'Calvin Klein', 'Hoodie', 'Pink', NULL, '784660', 24.99, NULL, 60, NULL, 'vertical and horizontal white words all over front

Chest: 51
length: 52
arm: 50/66', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.889972', NULL, 0.00);
INSERT INTO public.clothing VALUES (2258, 'M', 'Calvin Klein', 'Flying Blouse', 'White', 178, '483198', 5.61, NULL, 66, NULL, 'chest: 50
length: 66/83', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-22 12:52:17.22274', NULL, 0.00);
INSERT INTO public.clothing VALUES (2313, 'XS', 'Calvin Klein', 'Hoodie', 'Navy', NULL, '080354', 20.00, NULL, 72, NULL, 'stripe down arm

chest: 50
length: 69
arm: 66
shoulders: 46', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-27 16:19:16.405672', NULL, 0.00);
INSERT INTO public.clothing VALUES (503, 'M', 'Calvin Klein', 'Puffy Jacket', 'Black', 34, '934478', 39.89, 108.39, 9, NULL, 'Long

chest: 58
Length: 89
arm: 67', true, 'men', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.063281', NULL, 0.00);
INSERT INTO public.clothing VALUES (44, 'N/A', 'Calvin Klein', 'Wallet', 'Black', 6, '734519', 12.99, 32.21, 26, 14, 'sold for 950', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.01361', NULL, NULL);
INSERT INTO public.clothing VALUES (2302, 'XS', 'Tommy Hilfiger', 'Hoodie', 'Navy, Red, White', 183, '652148', 10.39, 48.21, 72, 23, 'Tommy Jeans
Navy front
red/white back

chest: 48
length: 60
arm: 56
shoulders: 45', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-26 15:42:55.338175', NULL, 0.00);
INSERT INTO public.clothing VALUES (14, 'M', 'Tommy Hilfiger', 'Puffy Jacket', 'Black', 2, '437638', 69.99, 115.38, 4, 17, 'sold for 3300
Hooded
half chest black

Chest: 61
Waist: 59
Length: 70
Arm: 69', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:53.752322', NULL, NULL);
INSERT INTO public.clothing VALUES (73, 'XS', 'Calvin Klein', 'Sweater', 'Tan', 9, '954476', 22.96, 48.95, 28, 14, 'sold for 1400
with hood
Chest: 49
Waist: 47
Length: 51
Arm: 50', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.277372', NULL, NULL);
INSERT INTO public.clothing VALUES (2005, 'XS', 'Calvin Klein', 'Sweat Pants', 'Black', 154, '785421', 14.05, NULL, 108, NULL, 'with Calvin on calf
waist: 36
hips: 46
length: 93
pasadka: 23', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 12:01:22.376929', NULL, 7.69);
INSERT INTO public.clothing VALUES (2020, 'S', 'Calvin Klein', 'Skirt', 'Black', 155, '659331', 10.39, 39.29, 62, 22, 'waist: 36
hips: 50
length: 79', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 12:16:54.542414', NULL, 0.00);
INSERT INTO public.clothing VALUES (2022, 'XS', 'Calvin Klein', 'Flying Blouse', 'Black', 155, '483167', 7.99, 35.00, 65, 22, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 12:18:52.592696', NULL, 0.00);
INSERT INTO public.clothing VALUES (2248, 'M', 'DKNY', 'Puffy Jacket', 'Grey', NULL, '391244', 49.99, 101.79, 65, 22, 'from costco

chest: 56
length: 88
arm: 66
shoulders: 43', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-22 10:29:26.791967', NULL, 0.00);
INSERT INTO public.clothing VALUES (2115, 'XS', 'DKNY', 'Puffy Jacket', 'Grey', NULL, '391268', 49.99, 94.64, 63, 22, 'from costco

chest: 50
length: 84
arm: 63
shoulders: 41', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-16 14:55:12.258446', NULL, 0.00);
INSERT INTO public.clothing VALUES (2249, 'M', 'DKNY', 'Puffy Jacket', 'Grey', NULL, '391244', 49.99, 101.79, 65, 22, 'from costco

chest: 56
length: 88
arm: 66
shoulders: 43', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-22 10:29:27.533134', NULL, 0.00);
INSERT INTO public.clothing VALUES (24, 'M', 'Tommy Hilfiger', 'Sweater', 'Black', 3, '116027', 19.99, 26.92, 53, 9, 'Long neck
buttons on sleeve

Chest: 46
Waist: 44
Length: 62
Arm: 62', true, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:53.839385', NULL, 0.00);
INSERT INTO public.clothing VALUES (1986, 'M', 'Tommy Hilfiger', 'Golfik', 'White', 153, '130252', 10.00, 13.59, 56, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 11:36:36.209852', NULL, 0.00);
INSERT INTO public.clothing VALUES (499, 'L', 'Calvin Klein', 'Sweat Shirt', 'Navy', 34, '307511', 16.62, 22.39, 53, 9, 'grey letters

chest: 58
length: 71
arm: 68', true, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.023976', NULL, 0.00);
INSERT INTO public.clothing VALUES (1989, 'S', 'Calvin Klein', 'Tank Top', 'White', 153, '431800', 12.00, 16.31, 56, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 11:38:05.777005', NULL, 0.00);
INSERT INTO public.clothing VALUES (414, 'XS', 'Hunter', 'Puffy Jacket', 'Yellow', NULL, '7132', 59.99, 125.87, 11, 16, 'sold for 3600', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.286237', NULL, NULL);
INSERT INTO public.clothing VALUES (399, '1SZ', 'Tommy Hilfiger', 'Hat', 'White', 20, '561914', 12.74, 29.72, 27, 14, 'sold for 850
beanie cap', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.155508', NULL, NULL);
INSERT INTO public.clothing VALUES (459, 'L', 'Calvin Klein', 'T-Shirt', 'Black', 34, '803637', 9.97, NULL, 19, NULL, 'payetki sign on chest

chest: 49
length: 66', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.682812', NULL, NULL);
INSERT INTO public.clothing VALUES (476, 'N/A', 'Calvin Klein', 'Bag', 'Black', 34, '269452', 17.02, NULL, 19, NULL, 'Width: 47
Height: 30', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.825007', NULL, NULL);
INSERT INTO public.clothing VALUES (486, 'S', 'Calvin Klein', 'Puffy Jacket', 'Silver', 37, '888092', 35.19, NULL, 19, NULL, 'space suit

chest: 60
length: 78
arm: 64', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.908658', NULL, NULL);
INSERT INTO public.clothing VALUES (487, 'XS', 'Calvin Klein', 'Puffy Jacket', 'Silver', 34, '888108', 66.64, NULL, 19, NULL, 'space suit

chest: 56
length: 75
arm: 62', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.916965', NULL, NULL);
INSERT INTO public.clothing VALUES (492, 'XS', 'Calvin Klein', 'Hoodie', 'Black', 34, '291212', 9.24, NULL, 19, NULL, 'large circle logo on front

Chest: 58
Waist: 50
Length: 49
Arm: 46', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.958819', NULL, NULL);
INSERT INTO public.clothing VALUES (748, 'S', 'Tommy Hilfiger', 'Windbreaker', 'White', 49, '912164', 56.00, 110.71, 57, 19, '2 in 1 jacket

Chest: 52
length: 74
arm: 72', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.196307', NULL, 7.69);
INSERT INTO public.clothing VALUES (94, 'M', 'Calvin Klein', 'Sweater', 'Black', NULL, '883233', 19.99, 39.29, 4, 19, 'Gold CK + white "calvin klein jeans" on chest

Chest: 52
Waist: 50
Length: 55
Arm: 69', true, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.455308', NULL, 8.10);
INSERT INTO public.clothing VALUES (401, 'M', 'Calvin Klein', 'Sweat Pants', 'Black', NULL, '956951', 19.99, 46.43, 57, 19, 'silver letters along leg

waist: 40
hips: 49
length: 94
pasadka: 25', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.171229', NULL, 7.69);
INSERT INTO public.clothing VALUES (596, 'S', 'Calvin Klein', 'Puffy Jacket', 'Black', NULL, '100612', 33.24, 101.40, 20, 13, 'short
sold for 2900

chest: 50
length: 59
arm: 65', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.865053', NULL, NULL);
INSERT INTO public.clothing VALUES (615, 'N/A', 'Calvin Klein', 'Wallet', 'Black', NULL, '0567', 14.99, 38.46, 23, 18, 'sold for 1100', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.029034', NULL, NULL);
INSERT INTO public.clothing VALUES (589, 'N/A', 'Armani Exchange', 'Purse', 'Pink', NULL, '119288', 29.99, NULL, 19, NULL, NULL, true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.807078', NULL, NULL);
INSERT INTO public.clothing VALUES (570, 'S', 'Michael Kors', 'Sweater', 'White', NULL, '067841', 24.99, NULL, 19, NULL, 'knitted
long neck', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.647887', NULL, NULL);
INSERT INTO public.clothing VALUES (592, 'M', 'Calvin Klein', 'Sweater', 'Black', NULL, '874880', 21.99, NULL, 19, NULL, 'oversized
bat style
white words on chest

chest: 59
length: 62', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.831718', NULL, NULL);
INSERT INTO public.clothing VALUES (593, 'S', 'Tommy Hilfiger', 'Sweater', 'White', NULL, '398664', 15.00, NULL, 19, NULL, 'silver circled sign on chest

chest: 38
length: 60
arm: 61', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.83921', NULL, NULL);
INSERT INTO public.clothing VALUES (594, 'S', 'Tommy Hilfiger', 'Sweater', 'Pink', NULL, '411790', 0.00, NULL, 19, NULL, 'knitted

chest: 47
length: 61
arm: 61', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.848446', NULL, NULL);
INSERT INTO public.clothing VALUES (595, 'M', 'Tommy Hilfiger', 'Sweater', 'White', NULL, '398671', 15.00, NULL, 19, NULL, 'silver circled logo

chest: 42
length: 62
arm: 61', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.855992', NULL, NULL);
INSERT INTO public.clothing VALUES (623, 'S', 'Tommy Hilfiger', 'Sweater', 'Black', NULL, '3313', 24.99, 48.95, 25, 13, 'golfik
sold for 1400', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.10753', NULL, NULL);
INSERT INTO public.clothing VALUES (620, 'XS', 'Calvin Klein', 'Hoodie', 'Black', NULL, '0008', 29.99, 54.20, 24, 17, 'sold with 0011
pink "calvin" on chest', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.071177', NULL, NULL);
INSERT INTO public.clothing VALUES (624, 'S', 'Tommy Hilfiger', 'Sweater', 'Black', NULL, '9163', 24.99, 48.95, 26, 15, 'sold for 1400
golfik', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.116729', NULL, NULL);
INSERT INTO public.clothing VALUES (639, 'XS', 'Calvin Klein', 'Sweater', 'Black', NULL, '910007', 34.99, NULL, 30, NULL, 'big white letters "calvin klein jeans" from the sleeve across the chest', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.241321', NULL, NULL);
INSERT INTO public.clothing VALUES (634, 'XS', 'Calvin Klein', 'Sweat Pants', 'Black', NULL, '0011', 29.99, 54.20, 27, 17, 'sold with 0008
sold for 3100
pink letters on calf', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.200171', NULL, NULL);
INSERT INTO public.clothing VALUES (2086, 'M', 'Tommy Hilfiger', 'Jacket', 'Navy', 158, '135639', 29.00, 39.06, 61, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-13 11:55:00.233432', NULL, 4.93);
INSERT INTO public.clothing VALUES (899, '6', 'Massimo Duti', 'Pants', 'Salmon', 56, '6384', 5.99, NULL, 36, NULL, 'W

waist: 39
hips: 51
pasadka: 28
length: 100', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:08.812033', NULL, NULL);
INSERT INTO public.clothing VALUES (386, 'L', 'Calvin Klein', 'Sweat Pants', 'Black', 26, '263176', 30.02, 40.90, 55, 9, 'grey logo

Waist: 46
hips: 55
length: 108
pasadka: 31', true, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.044165', NULL, 0.00);
INSERT INTO public.clothing VALUES (2032, 'S', 'Calvin Klein', 'Sweat Pants', 'Black', NULL, '085568', 29.75, NULL, 75, NULL, 'stripe on waist

chest: 37
hips: 48
pasadka: 26
length: 97', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 13:17:33.893941', NULL, 0.00);
INSERT INTO public.clothing VALUES (1352, 'S', 'Armani Exchange', 'Dress Shirt', 'Black', 124, '496030', 13.99, 41.96, 43, 13, 'sold for 1200
Chest: 47
Waist: 47
Length: 62
Arm:', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:13.07573', NULL, NULL);
INSERT INTO public.clothing VALUES (1336, 'S', 'Armani Exchange', 'Jean Jacket', 'Navy', 60, '124454', 9.99, NULL, 44, NULL, 'Chest: 47
Waist: 45
Length: 65
Arm: 67', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:12.934522', NULL, NULL);
INSERT INTO public.clothing VALUES (1622, '30', 'Levis', 'Jeans', 'Navy', 56, '776375', 12.50, NULL, 42, NULL, 'Waist: 40
Hips: 44
Length: 99
Pasadka: 25', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:15.586357', NULL, NULL);
INSERT INTO public.clothing VALUES (879, 'M', 'Calvin Klein', 'Boxers', 'Blue', 58, '055655', 6.71, NULL, 44, NULL, '3 pair', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:08.620102', NULL, NULL);
INSERT INTO public.clothing VALUES (371, 'M', 'Calvin Klein', 'Gloves', 'Black', 29, '543077', 12.10, 16.35, 54, 9, NULL, true, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.907378', NULL, 0.00);
INSERT INTO public.clothing VALUES (469, 'M', 'Calvin Klein', 'Sweat Pants', 'Black', 34, '263169', 19.94, NULL, 9, NULL, 'men
grey logo sign

Waist: 41
hips: 53
length: 106
pasadka: 30', true, 'men', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.764575', NULL, 0.00);
INSERT INTO public.clothing VALUES (86, 'XS', 'Calvin Klein', 'Sweater', 'White', 9, '084043', 29.49, NULL, 23, NULL, 'Black line + white outlined "calvin ck" across chest

Chest: 55
Waist: 47
Length: 47
Arm: 47', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.3875', NULL, NULL);
INSERT INTO public.clothing VALUES (93, 'M', 'Calvin Klein', 'Sweat Pants', 'White', NULL, '790654', 19.99, NULL, 5, NULL, 'words down leg
"calvin klein performance" square

Waist: 44
Hips: 50
Length: 98
Pasadka: 25', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.447195', NULL, NULL);
INSERT INTO public.clothing VALUES (109, 'S', 'Tommy Hilfiger', 'Sweat Shirt', 'Navy', 13, '792827', 15.99, NULL, 22, NULL, '"Tommy Hilfiger" in block letters on chest

Chest: 51
Waist: 47
Length: 62
Arm: 59', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.595615', NULL, NULL);
INSERT INTO public.clothing VALUES (120, 'XS', 'Tommy Hilfiger', 'Sweat Shirt', 'Teal', 11, '792889', 15.99, NULL, 22, NULL, '"Tommy Hilfiger" in block letters on chest

Chest: 47
Waist: 44
Length: 60
Arm: 58', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.694558', NULL, NULL);
INSERT INTO public.clothing VALUES (143, 'S', 'Calvin Klein', 'Sweater', 'White', NULL, '789979', 24.99, NULL, 23, NULL, 'Long neck
Big black letters on chest
small "calvin klein performance" tag on bottom corner

Chest: 58
Waist: 54
Length: 63
Arm: 68', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.936731', NULL, NULL);
INSERT INTO public.clothing VALUES (2053, 'L', 'Calvin Klein', 'Sweat Pants', 'Pink', NULL, '101978', 30.70, 42.86, 58, 19, '"Calvin klein" on side of leg

Waist: 43
Hips: 54
Pasadka: 29
Length: 98', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-13 11:06:04.682876', NULL, 5.46);
INSERT INTO public.clothing VALUES (2330, 'M', 'Armani Exchange', 'Sweat Pants', 'Blue', 186, '968690', 26.99, 62.50, 74, 22, 'waist: 42
hips: 54
pasadka: 30
length: 105', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-31 14:50:14.146845', NULL, 0.00);
INSERT INTO public.clothing VALUES (2087, 'M', 'Calvin Klein', 'Leggings', 'Black', NULL, '931361', 29.70, 46.43, 73, 19, 'waist: 35
hips: 41
length: 101
pasadka: 26', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-13 11:57:04.406988', NULL, 4.69);
INSERT INTO public.clothing VALUES (168, 'S', 'Tommy Hilfiger', 'Jacket', 'White, Red, Navy', NULL, '053093', 22.99, NULL, 28, NULL, 'Fluffy sweater jacket
right boob white
left boob navy

Chest: 50
Waist: 48
Length: 58
Arms: 72', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:55.146013', NULL, NULL);
INSERT INTO public.clothing VALUES (142, 'L', 'Calvin Klein', 'Sweat Pants', 'Black', NULL, '789047', 19.99, NULL, 30, NULL, 'White outlined black stripe with "cavin klein ck" down leg

Waist: 44
Hips: 53
Length: 95
Pasadka: 27', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.927567', NULL, NULL);
INSERT INTO public.clothing VALUES (226, 'M', 'Calvin Klein', 'Sweater', 'White', NULL, '954933', 24.99, NULL, 5, NULL, 'Off white with double neck
fluffy letters

Chest: 51
Waist: 46
Length: 67
Arm: 68', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:55.641267', NULL, NULL);
INSERT INTO public.clothing VALUES (222, '1SZ', 'Calvin Klein', 'Scarf', 'Red', NULL, '470371', 12.99, NULL, 34, NULL, NULL, true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:55.597223', NULL, NULL);
INSERT INTO public.clothing VALUES (365, 'L', 'Calvin Klein', 'Puffy Jacket', 'Black', 29, '876693', 40.37, 100.00, 9, NULL, 'short & tiny

chest: 64
length: 71
arm: 70', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.855433', NULL, NULL);
INSERT INTO public.clothing VALUES (362, '1SZ', 'Calvin Klein', 'Hat', 'Black', 29, '555766', 16.14, NULL, 14, NULL, 'white sign', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.829737', NULL, NULL);
INSERT INTO public.clothing VALUES (381, 'M', 'Calvin Klein', 'Puffy Jacket', 'Black', 29, '934645', 40.37, NULL, 9, NULL, 'short tiny

chest: 60
length: 71
arm: 70', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.998038', NULL, NULL);
INSERT INTO public.clothing VALUES (385, 'XS', 'Calvin Klein', 'Sweater', 'Tan', 15, '954476', 23.63, NULL, 9, NULL, 'with hood

Chest: 49
Waist: 47
Length: 51
Arm: 50', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.035242', NULL, NULL);
INSERT INTO public.clothing VALUES (456, 'XS', 'Calvin Klein', 'Sweat Shirt', 'Black', 37, '962518', 8.78, NULL, 14, NULL, 'Big silver payetki letters

chest: 51
length: 52
arm: 58/70', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.656725', NULL, NULL);
INSERT INTO public.clothing VALUES (449, 'S', 'Calvin Klein', 'Blouse', 'Black', 34, '579464', 9.24, NULL, 30, NULL, 'chest: 49
length: 65/72
arm: 64', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.598258', NULL, NULL);
INSERT INTO public.clothing VALUES (366, 'L', 'Calvin Klein', 'Puffy Jacket', 'Black', 29, '875436', 48.45, 108.39, 9, NULL, 'Men
long

chest: 64
length: 91
arm: 69', true, 'men', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.864053', NULL, NULL);
INSERT INTO public.clothing VALUES (2088, 'XS', 'Calvin Klein', 'Hoodie', 'Black', NULL, '069346', 29.70, NULL, 73, NULL, 'with "calvin klein" on wrist

chest: 49
length: 55
arm: 49.7', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-13 12:00:01.564747', NULL, 0.00);
INSERT INTO public.clothing VALUES (554, 'L', 'Calvin Klein', 'Puffy Jacket', 'Black', 36, '876693', 29.74, NULL, 9, NULL, 'short & tiny

chest: 64
length: 71
arm: 70', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.500868', NULL, NULL);
INSERT INTO public.clothing VALUES (550, 'S', 'Calvin Klein', 'Sweat Pants', 'Grey', 36, '785360', 14.88, NULL, 9, NULL, NULL, true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.467409', NULL, NULL);
INSERT INTO public.clothing VALUES (549, 'S', 'Calvin Klein', 'Sweat Shirt', 'Grey', 36, '796410', 14.88, NULL, 9, NULL, NULL, true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.45855', NULL, NULL);
INSERT INTO public.clothing VALUES (551, 'M', 'Calvin Klein', 'Puffy Jacket', 'Black', 36, '934645', 29.74, NULL, 9, NULL, 'short tiny

chest: 60
length: 71
arm: 70', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.475546', NULL, NULL);
INSERT INTO public.clothing VALUES (556, 'XL', 'Tommy Hilfiger', 'Sweater', 'Navy', NULL, '??????', 0.00, 52.45, 9, NULL, 'with turtle neck and zipper', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.517292', NULL, NULL);
INSERT INTO public.clothing VALUES (611, 'XS', 'Calvin Klein', 'Sweat Pants', 'White', 17, '082834', 28.83, NULL, 23, NULL, 'stripe on side', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.994419', NULL, NULL);
INSERT INTO public.clothing VALUES (641, 'S', 'Armani Exchange', 'T-Shirt', 'Black', NULL, '903167', 19.99, NULL, 30, NULL, 'stones', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.258365', NULL, NULL);
INSERT INTO public.clothing VALUES (640, 'L', 'Armani Exchange', 'T-Shirt', 'Black', NULL, '903143', 19.99, NULL, 30, NULL, 'stones', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.250768', NULL, NULL);
INSERT INTO public.clothing VALUES (702, 'XS', 'Tommy Hilfiger', 'Sweater', 'Deep Seawave', 42, '654043', 17.49, NULL, 33, NULL, 'knitted
V-neck

Chest: 43
length: 59
arm: 62', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.808534', NULL, NULL);
INSERT INTO public.clothing VALUES (718, 'S', 'Tommy Hilfiger', 'Coat', 'Plaid', 48, '916803', 56.00, NULL, 33, NULL, 'chest: 48
Waist: 45
length: 96
arm: 65', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.938546', NULL, NULL);
INSERT INTO public.clothing VALUES (711, 'S', 'Tommy Hilfiger', 'Hoodie Dress', 'Navy', NULL, '920114', 29.99, NULL, 34, NULL, 'velvety fabric
silver "Tommy Hilfiger" on stripe down arm

Chest: 48
Length: 89
Arm: 61', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.881648', NULL, NULL);
INSERT INTO public.clothing VALUES (727, '1SZ', 'Tommy Hilfiger', 'Scarf', 'Plaid', 45, '561730', 15.74, NULL, 33, NULL, NULL, true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.010501', NULL, NULL);
INSERT INTO public.clothing VALUES (757, '1SZ', 'Tommy Hilfiger', 'Scarf', 'Plaid', 50, '561730', 15.74, NULL, 34, NULL, NULL, true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.271762', NULL, NULL);
INSERT INTO public.clothing VALUES (747, '1SZ', 'Tommy Hilfiger', 'Hat', 'Black', 49, '561907', 13.99, NULL, 34, NULL, 'beanie cap
gold letters on forehead', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.188163', NULL, NULL);
INSERT INTO public.clothing VALUES (383, '1SZ', 'Calvin Klein', 'Hat', 'Black', NULL, '562788', 8.92, 12.04, 54, 9, 'yarn beanie cap', true, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.019047', NULL, 0.00);
INSERT INTO public.clothing VALUES (139, 'L', 'Calvin Klein', 'Hoodie', 'Black', NULL, '872115', 29.99, 40.49, 53, 9, 'Men
With zipper

Chest: 58
Waist: 56
Length: 70
Arm: 68', true, 'men', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.90376', NULL, 0.00);
INSERT INTO public.clothing VALUES (357, 'L', 'Calvin Klein', 'Sweat Pants', 'Black', 29, '263176', 20.19, 27.29, 53, 9, 'grey logo

Waist: 46
hips: 55
length: 108
pasadka: 31', true, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.785356', NULL, 0.00);
INSERT INTO public.clothing VALUES (767, 'L', 'Calvin Klein', 'Puffy Jacket', 'Black', 52, '875436', 27.99, NULL, 60, NULL, 'matte black

chest: 62
length: 88
arm: 64', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.356455', NULL, 0.00);
INSERT INTO public.clothing VALUES (2251, 'L', 'DKNY', 'Puffy Jacket', 'Grey', NULL, '391237', 49.99, NULL, 72, NULL, 'from costco

chest: 59
length: 89
arm: 65
shoulders: 46', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-22 10:29:40.541555', NULL, 0.00);
INSERT INTO public.clothing VALUES (2085, 'L', 'Tommy Hilfiger', 'Jacket', 'Navy', 158, '135622', 29.00, 39.06, 61, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-13 11:54:50.777217', NULL, 4.93);
INSERT INTO public.clothing VALUES (808, 'L', 'Calvin Klein', 'Hoodie', 'Plum', NULL, '247305', 25.00, 33.75, 53, 9, 'Men', true, 'men', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.721362', NULL, 0.00);
INSERT INTO public.clothing VALUES (189, 'L', 'Calvin Klein', 'Sweat Pants', 'Black', NULL, '687114', 19.99, 26.99, 53, 9, 'White "calvin" on calf

Waist: 43
Hips: 50
Length: 94
Pasadka: 27', true, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:55.32641', NULL, 0.00);
INSERT INTO public.clothing VALUES (1754, 'L', 'Calvin Klein', 'Hoodie', 'Black', NULL, '687152', 24.99, 33.74, 53, 9, 'long
long neck
white calvin on chest', true, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 10:30:35.327542', NULL, 0.00);
INSERT INTO public.clothing VALUES (674, 'M', 'Tommy Hilfiger', 'Puffy Jacket', 'Navy', 44, '912508', 34.99, NULL, 33, NULL, 'Shiny
with hood
reversible to fluffy and white

Chest: 57
Length: 62
Arm: 58', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.553263', NULL, NULL);
INSERT INTO public.clothing VALUES (709, 'M', 'Tommy Hilfiger', 'Puffy Jacket', 'Silver', NULL, '129140', 59.99, NULL, 34, NULL, 'red inside hood
white stripe down arm with "Tommy Hilfiger"

Chest: 55
length: 58
arm: 63', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.865841', NULL, NULL);
INSERT INTO public.clothing VALUES (2, 'M', 'Tommy Hilfiger', 'Puffy Jacket', 'Black, Navy', 1, '218928', 49.99, NULL, 4, NULL, 'Navy hood, black body, red stripe on chest

Chest: 50
Waist: 46
Length: 65
Arm: 65', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:53.638397', NULL, NULL);
INSERT INTO public.clothing VALUES (496, 'L', 'Calvin Klein', 'Sweat Shirt', 'Red', 34, '789840', 16.62, 22.39, 53, 9, 'men

chest: 55
length: 73
arm: 70', true, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.992212', NULL, 0.00);
INSERT INTO public.clothing VALUES (1540, 'M', 'Tommy Hilfiger', 'Hoodie', 'Navy', 139, '826140', 19.19, 25.94, 53, 9, 'Zipper on top half with red/white outline

Chest: 60
Waist: 57
Length: 68
Arm: 62', true, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:14.829886', NULL, 0.00);
INSERT INTO public.clothing VALUES (354, 'S', 'Calvin Klein', 'Sweat Pants', 'Black', 29, '785414', 20.19, NULL, 108, NULL, 'stripe + "calvin" on stripe

waist: 37
hips: 47
length: 92
pasadka: 24', true, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.759536', NULL, 7.04);
INSERT INTO public.clothing VALUES (2331, 'L', 'Armani Exchange', 'Sweat Pants', 'Blue', 186, '776745', 26.99, 64.29, 74, 22, 'waist: 45
hips: 56
pasadka: 32
length: 108', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-31 14:51:44.57858', NULL, 0.00);
INSERT INTO public.clothing VALUES (716, 'M', 'Tommy Hilfiger', 'Puffy Jacket', 'White', NULL, '964668', 49.99, 110.71, 34, 22, 'short

chest: 55
length: 63
arm: 63', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.922704', NULL, NULL);
INSERT INTO public.clothing VALUES (358, 'XL', 'Calvin Klein', 'Puffy Jacket', 'Black', 29, '875429', 48.44, 110.71, 9, 21, 'Long
men

chest: 68
length: 90
arm: 67', true, 'men', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.794401', NULL, 0.00);
INSERT INTO public.clothing VALUES (96, 'M', 'Calvin Klein', 'Sweater', 'White', NULL, '832867', 20.00, NULL, 4, NULL, 'gold "CK" + black "calvin klein jeans" on chest

Chest: 53
Waist: 51
Length: 61
Arm: 60', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.477403', NULL, NULL);
INSERT INTO public.clothing VALUES (387, 'S', 'Calvin Klein', 'Sweat Pants', 'White', 26, '785315', 25.70, NULL, 9, NULL, 'off white / cream
stripe + calvin down side

Waist: 37
hips: 49
length: 95
pasadka: 26', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.052344', NULL, NULL);
INSERT INTO public.clothing VALUES (2118, 'M', 'Tommy Hilfiger', 'Dress', 'White', NULL, '830529', 19.99, NULL, 58, NULL, 'flag on chest
chest: 57
length: 87', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-16 16:00:35.351659', NULL, NULL);
INSERT INTO public.clothing VALUES (341, 'M', 'Calvin Klein', 'Hoodie', 'Black', 30, '254846', 29.99, NULL, 9, NULL, 'grey logo on chest

chest: 56
length: 70
arm: 67', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.648649', NULL, NULL);
INSERT INTO public.clothing VALUES (552, 'M', 'Calvin Klein', 'Puffy Jacket', 'Black', 36, '934645', 29.74, 100.00, 9, NULL, 'short tiny

chest: 60
length: 71
arm: 70', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.484353', NULL, NULL);
INSERT INTO public.clothing VALUES (405, 'M', 'Juicy Coture', 'Puffy Jacket', 'Black', NULL, '361903', 49.99, 146.85, 9, 4, 'sold for 4200

Chest: 51
Length: 101
arm: 64', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.200207', NULL, NULL);
INSERT INTO public.clothing VALUES (2075, 'L', 'Tommy Hilfiger', 'Sweater', 'White', 159, '999790', 12.00, 16.28, 61, 9, 'gold diamonds', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-13 11:39:53.484374', NULL, 4.93);
INSERT INTO public.clothing VALUES (375, 'L', 'Calvin Klein', 'Puffy Jacket', 'Black', 29, '875436', 48.45, NULL, 9, NULL, 'Men
long

chest: 64
length: 91
arm: 69', true, 'men', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.941112', NULL, NULL);
INSERT INTO public.clothing VALUES (2395, 'M', 'Calvin Klein', 'Leggings', 'Black', 193, '444144', 19.99, NULL, 76, NULL, 'calvin klein all around

waist: 35
hips: 41
length: 85', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-07 21:34:12.905365', NULL, 0.00);
INSERT INTO public.clothing VALUES (2425, 'M', 'Tommy Hilfiger', 'Free Sweater', 'Navy', 195, '415958', 15.99, NULL, 88, NULL, 'chest: 55
length: 72
arm: 72
', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-02-07 22:31:56.286586', NULL, 0.00);
INSERT INTO public.clothing VALUES (2219, 'M', 'Michael Kors', 'Polo Shirt', 'Navy', NULL, '833861', 19.99, NULL, 66, NULL, 'Michael Kors on shoulder

chest: 52
length: 70', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-01-21 17:52:08.946754', NULL, 0.00);
INSERT INTO public.clothing VALUES (2399, 'M', 'Calvin Klein', 'Sweat Shirt', 'Pink', 193, '431847', 19.99, NULL, 76, NULL, 'chest: 53
length: 60
arm: 70', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-07 21:43:16.647575', NULL, 0.00);
INSERT INTO public.clothing VALUES (2417, '8.5', 'Tommy Hilfiger', 'Shoes', 'Navy', 195, '230064', 21.48, NULL, 62, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-07 22:22:40.936974', NULL, 0.00);
INSERT INTO public.clothing VALUES (457, 'M', 'Calvin Klein', 'T-Shirt', 'Black', 34, '803644', 9.97, NULL, 19, NULL, 'payetki sign on chest

chest: 48
length: 64', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.665528', NULL, NULL);
INSERT INTO public.clothing VALUES (2433, 'S', 'Calvin Klein', 'T-Shirt', 'Black', 197, '803651', 11.08, NULL, 77, NULL, 'payetki sign on chest

chest: 43
length: 64', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-07 23:31:41.217488', NULL, 0.00);
INSERT INTO public.clothing VALUES (2437, 'M', 'Calvin Klein', 'T-Shirt', 'Black', 197, '803644', 11.08, NULL, 77, NULL, 'payetki sign on chest

chest: 48
length: 64', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-07 23:34:44.84493', NULL, 0.00);
INSERT INTO public.clothing VALUES (2462, 'L', 'Calvin Klein', 'T-Shirt', 'White', 201, '517107', 12.99, NULL, 81, NULL, 'a lot of letters on chest

chest: 48
length: 67', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-08 00:18:07.761037', NULL, 0.00);
INSERT INTO public.clothing VALUES (2439, 'M', 'Tommy Hilfiger', 'Sweater', 'Blue', 198, '395861', 15.29, NULL, 102, NULL, 'zipper on neck

chest: 55
length: 65
arm: 68', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-02-07 23:40:19.328581', NULL, 0.00);
INSERT INTO public.clothing VALUES (2458, 'S', 'Tommy Hilfiger', 'Bodysuit', 'Navy', 201, '808153', 16.99, NULL, 81, NULL, 'Tommy Jeans on chest
chest: 43
length: 69
arm: 61', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-08 00:11:45.626562', NULL, 0.00);
INSERT INTO public.clothing VALUES (2455, 'S', 'Calvin Klein', 'Dress', 'Blue', 201, '404339', 24.99, NULL, 84, NULL, 'chest: 50
length: 85
arm: 63', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-08 00:06:32.955495', NULL, 0.00);
INSERT INTO public.clothing VALUES (2463, 'S', 'Calvin Klein', 'T-Shirt', 'Black', 201, '507306', 12.99, NULL, 85, NULL, 'Circle logo

chest: 43
length: 64', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-08 00:19:33.456316', NULL, 0.00);
INSERT INTO public.clothing VALUES (1876, 'M', 'Calvin Klein', 'Sweat Shirt', 'Red', NULL, '789833', 20.00, 27.00, 55, 9, NULL, true, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-29 01:16:41.42978', NULL, 0.00);
INSERT INTO public.clothing VALUES (2415, 'M', 'Michael Kors', 'Polo Shirt', 'Navy', 194, '833861', 19.99, 26.92, 82, 9, 'Michael Kors on shoulder

chest: 52
length: 70', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-02-07 22:17:03.42677', NULL, 0.00);
INSERT INTO public.clothing VALUES (2408, 'M', 'Bebe', 'Hoodie', 'Black', 193, '621316', 14.99, NULL, 76, NULL, 'pink letters

chest: 49
length: 61
arm from neck: 80', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-07 22:02:57.43641', NULL, 4.80);
INSERT INTO public.clothing VALUES (2409, 'M', 'Bebe', 'Sport Pants', 'Black', 193, '618927', 14.99, NULL, 76, NULL, 'Pink letters

waist: 40
hips: 53
pasadka: 30
length: 100', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-07 22:04:05.380427', NULL, 4.80);
INSERT INTO public.clothing VALUES (2422, 'L', 'Tommy Hilfiger', 'Free Sweater', 'Black', 195, '415750', 15.99, NULL, 76, NULL, 'chest: 55
length: 76
arm: 74', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-02-07 22:26:48.223497', NULL, 0.00);
INSERT INTO public.clothing VALUES (2084, 'S', 'Calvin Klein', 'Sweat Pants', 'Mint', NULL, '827336', 24.99, NULL, 76, NULL, 'Black "Calvin" on calf
Has pockets

Waist: 40
Hips: 47
Length: 93
Pasadka: 25', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-13 11:54:03.434486', NULL, 0.00);
INSERT INTO public.clothing VALUES (2497, '10.5', 'Nike', 'Shoes', 'Navy', NULL, '??????', 0.00, NULL, 76, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-08 23:06:30.984162', NULL, 0.00);
INSERT INTO public.clothing VALUES (2323, '4', 'Calvin Klein', 'Satin Dress', 'Black', 185, '646362', 7.96, NULL, 76, NULL, 'chest: 45
hips: 50
length: 110
', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-31 14:44:40.154555', NULL, 0.00);
INSERT INTO public.clothing VALUES (2023, 'S', 'Calvin Klein', 'Flying Blouse', 'Black', 155, '483150', 7.99, NULL, 76, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 12:19:05.949577', NULL, 0.00);
INSERT INTO public.clothing VALUES (2498, 'L', 'Calvin Klein', 'Hoodie', 'Blue', NULL, '289169', 23.00, NULL, 77, NULL, 'chest: 53
length: 68
arm: 66
', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-08 23:30:46.483263', NULL, 0.00);
INSERT INTO public.clothing VALUES (2172, 'XS', 'Calvin Klein', 'T-Shirt', 'Black', 168, '803668', 12.74, NULL, 77, NULL, 'payetki sign on chest

chest: 40
length: 62', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-21 16:56:04.030944', NULL, 0.00);
INSERT INTO public.clothing VALUES (2447, 'XXS', 'Calvin Klein', 'T-Shirt', 'Black', 199, '803675', 9.15, NULL, 77, NULL, 'payetki sign on chest

chest: 39
length: 61', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-07 23:49:58.65936', NULL, 0.00);
INSERT INTO public.clothing VALUES (2027, 'S', 'Calvin Klein', 'Sweat Pants', 'Black', NULL, '785414', 20.19, NULL, 78, NULL, 'stripe + "calvin" on stripe

waist: 37
hips: 47
length: 92
pasadka: 24', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 12:25:53.599038', NULL, 0.00);
INSERT INTO public.clothing VALUES (2201, 'L', 'DKNY', 'Coat', 'Grey', 172, '264388', 44.99, 114.29, 74, 22, NULL, NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-01-21 17:31:51.93719', NULL, 5.87);
INSERT INTO public.clothing VALUES (2324, '4', 'Calvin Klein', 'Satin Dress', 'Grey', 185, '652240', 7.96, 53.57, 76, 22, 'chest: 45
hips: 50
length: 110
', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-31 14:45:13.399435', NULL, 0.00);
INSERT INTO public.clothing VALUES (2421, '4', 'Tommy Hilfiger', 'Jeans', 'Navy', 195, '410387', 16.79, 50.00, 88, 23, 'waist: 36
hips: 44
pasadka: 24
length: 95', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-07 22:25:40.423059', NULL, 0.00);
INSERT INTO public.clothing VALUES (2081, 'M', 'Calvin Klein', 'Sweat Shirt', 'Pink', 160, '431847', 19.99, 44.64, 70, 22, 'chest: 53
length: 60
arm: 70', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-13 11:47:54.209568', NULL, 0.00);
INSERT INTO public.clothing VALUES (2390, 'S', 'Calvin Klein', 'Dress', 'Pink', 192, '117703', 24.99, 50.00, 100, 22, 'Chest: 49
length: 83
', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-07 21:21:08.664793', NULL, 0.00);
INSERT INTO public.clothing VALUES (2429, 'L', 'Michael Kors', 'Polo', 'Navy', 196, '833878', 19.99, 42.86, 83, 22, 'chest: 56
length: 74
', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-02-07 23:21:07.16673', NULL, 0.00);
INSERT INTO public.clothing VALUES (2451, 'M', 'Levis', 'Hoodie', 'Black', 200, '007904', 16.18, 39.29, 76, 22, 'Green Purple Circle

chest: 57
length: 62
arm from neck: 72', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-07 23:59:29.912734', NULL, 0.00);
INSERT INTO public.clothing VALUES (2441, 'M', 'Tommy Hilfiger', 'Sweater', 'Blue', 198, '680721', 15.29, 50.00, 76, 22, 'zipper on neck

chest: 50
length: 69
arm: 65', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-02-07 23:43:29.819903', NULL, 0.00);
INSERT INTO public.clothing VALUES (2440, 'M', 'Tommy Hilfiger', 'Sweater', 'Black', 198, '630344', 15.29, 50.00, 76, 22, 'zipper on neck

chest: 50
length: 69
arm: 65', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-02-07 23:42:16.167203', NULL, 0.00);
INSERT INTO public.clothing VALUES (1966, 'S', 'Tommy Hilfiger', 'Free Sweater', 'Black', 150, '415736', 15.99, 44.64, 76, 22, 'chest: 51
length: 69
arm: 69', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-01-08 10:32:28.900292', NULL, 0.00);
INSERT INTO public.clothing VALUES (2840, 'M', 'Calvin Klein', 'Dress', 'Pink', NULL, '117697', 20.00, NULL, 99, NULL, 'ПОГ 52
длина 87', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 03:02:47.620575', NULL, 0.00);
INSERT INTO public.clothing VALUES (2346, 'N/A', 'Calvin Klein', 'Wallet', 'Black', 187, '734519', 9.99, 35.00, 78, 19, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-31 15:07:26.642336', NULL, 4.18);
INSERT INTO public.clothing VALUES (1981, 'M', 'DKNY', 'Jacket', 'Black', 152, '051030', 24.99, 53.57, 78, 19, 'With gummy signs
chest: 56
length: 69
arm: 67', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-01-08 11:16:44.429432', NULL, 4.18);
INSERT INTO public.clothing VALUES (796, 'XS', 'Calvin Klein', 'Jacket', 'Black', 54, '015313', 17.61, NULL, 58, 1, 'double sided
(black on other side)

chest: 51
length: 60
arm: 62', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.621427', NULL, 0.00);
INSERT INTO public.clothing VALUES (2004, 'XS', 'Calvin Klein', 'Jacket', 'Black', 154, '015313', 18.21, NULL, 58, NULL, 'double sided
(black on other side)

chest: 51
length: 60
arm: 62', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 11:58:39.650258', NULL, 0.00);
INSERT INTO public.clothing VALUES (2525, 'XS', 'DKNY', 'Puffy Jacket', 'Grey', NULL, '391268', 25.00, NULL, 100, NULL, 'from costco

chest: 50
length: 84
arm: 63
shoulders: 41', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-13 02:17:35.738118', NULL, 0.00);
INSERT INTO public.clothing VALUES (2529, 'M', 'Bebe', 'Hoodie', 'Black', 204, '621910', 16.99, NULL, 84, NULL, 'rose-gold zipper and letters

chest: 50
length: 62
arm: 78', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-13 02:31:07.613712', NULL, 0.00);
INSERT INTO public.clothing VALUES (2522, 'S', 'DKNY', 'Puffy Jacket', 'Black', NULL, '391329', 25.00, NULL, 102, NULL, 'from costco

chest: 53
length: 87
arm: 63
shoulders: 42', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-13 02:15:16.648173', NULL, 0.00);
INSERT INTO public.clothing VALUES (2521, 'M', 'DKNY', 'Puffy Jacket', 'Black', NULL, '391312', 25.00, NULL, 102, NULL, 'from costco

chest: 56
length: 88
arm: 66
shoulders: 43', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-13 02:14:48.309937', NULL, 0.00);
INSERT INTO public.clothing VALUES (2550, 'M', 'Calvin Klein', 'T-Shirt', 'Blush, Pink', 207, '425341', 12.99, NULL, 85, NULL, 'white calvin on chest
chest: 48
length: 62', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-15 04:26:37.010539', NULL, 0.00);
INSERT INTO public.clothing VALUES (2545, 'M', 'Tommy Hilfiger', 'T-Shirt', 'Black', 207, '307364', 12.99, NULL, 83, NULL, 'block letter "tommy hilfiger" on chest
chest: 52
length: 63', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-15 04:22:30.480575', NULL, 0.00);
INSERT INTO public.clothing VALUES (2531, 'S', 'Karl Lagerfeld', 'Sweat Shirt', 'Blue', 205, 'LORHS045', 24.99, NULL, 84, NULL, 'gold 3d circle

chest: 51
length: 60
arm: 58', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-13 02:43:19.617448', NULL, 0.00);
INSERT INTO public.clothing VALUES (2029, 'S', 'Calvin Klein', 'Sweat Pants', 'Black', NULL, '827190', 29.99, NULL, 83, NULL, '"calvin" on back of calf

waist: 37
hips: 47
pasadka: 26
length: 95', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 12:28:01.995377', NULL, 0.00);
INSERT INTO public.clothing VALUES (2532, 'XS', 'Karl Lagerfeld', 'Sweat Shirt', 'Blue', 205, 'LORHS045', 24.99, NULL, 84, NULL, 'gold 3d circle

chest: 47
length: 60
arm: 57', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-13 02:44:11.457604', NULL, 0.00);
INSERT INTO public.clothing VALUES (2552, 'XL', 'Guess', 'T-Shirt', 'Black', 207, '157522', 12.99, NULL, 85, NULL, '3d gold sign
chest: 49
length: 63', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-15 04:29:00.052297', NULL, 0.00);
INSERT INTO public.clothing VALUES (2553, 'S', 'Guess', 'T-Shirt', 'Black', 207, '157515', 12.99, NULL, 85, NULL, '3d gold sign
chest: 40
length: 60', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-15 04:30:06.34288', NULL, 0.00);
INSERT INTO public.clothing VALUES (2269, 'S', 'Tommy Hilfiger', 'Sweat Shirt', 'White', 179, '621991', 10.39, 14.04, 82, 9, 'zipper on neck

chest: 50
length: 60
arm: 61', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-23 19:32:29.475175', NULL, 0.00);
INSERT INTO public.clothing VALUES (2721, 'M', 'DKNY', 'Leggings', 'Black', 224, '160233', 19.99, 27.17, 89, 9, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-27 22:56:08.050744', NULL, 0.00);
INSERT INTO public.clothing VALUES (2983, 'L', 'Calvin Klein', 'T-Shirt', 'Black', 230, '793342', 12.99, NULL, 101, NULL, 'ПОГ 54
дл 71
', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-03-07 00:36:27.905556', NULL, 0.00);
INSERT INTO public.clothing VALUES (2956, '8', 'Tommy Hilfiger', 'Flip Flops', 'Navy White', 229, '566649', 14.99, NULL, 102, NULL, 'меховой верх
стелька 24.5', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-06 23:41:28.512153', NULL, 0.00);
INSERT INTO public.clothing VALUES (2565, 'M', 'Calvin Klein', 'Sweat Pants', 'Black', 208, '718734', 26.69, 57.14, 84, 22, 'Men
black stripe on side
white letters

waist: 42
hips: 52
length: 104
pasadka: 28', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-02-15 04:41:17.642079', NULL, 0.00);
INSERT INTO public.clothing VALUES (2510, 'M', 'Calvin Klein', 'Sweat Shirt', 'White', NULL, '792320', 24.99, 50.00, 81, 22, 'one level neck

Long neck, "performance" tag
large black "Calvin" on chest

Chest: 64
Waist: 54
Length: 61
Arm: 43', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-12 01:39:03.389079', NULL, 0.00);
INSERT INTO public.clothing VALUES (2551, 'M', 'Guess', 'T-Shirt', 'Black', 207, '157508', 12.99, 26.79, 83, 22, '3d gold sign
chest: 44
length: 60', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-15 04:27:55.945942', NULL, 0.00);
INSERT INTO public.clothing VALUES (2506, 'S', 'Levis', 'Puffy Jacket', 'Orange', 203, '094409', 41.99, 83.93, 81, 22, 'chest: 59
length: 61
arm: 58/74', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-11 23:36:53.013478', NULL, 0.00);
INSERT INTO public.clothing VALUES (2404, 'S', 'Bebe', 'Sweat Pants', 'Black', 193, '618712', 14.99, 39.29, 83, 22, 'rose-gold letters on leg

waist: 38
hips: 49
pasadka: 27
length: 100', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-07 21:53:49.908779', NULL, 0.00);
INSERT INTO public.clothing VALUES (2576, 'S', 'Bebe', 'Hoodie', 'Black', 204, '621903', 16.99, 39.29, 83, 22, 'rose-gold zipper and letters

chest: 48
length: 60
arm: 77', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-15 20:05:33.996753', NULL, 0.00);
INSERT INTO public.clothing VALUES (2978, 'S', 'Tommy Hilfiger', 'Bodic', 'Navy', 230, '808153', 11.99, 39.29, 99, 22, 'ПОГ 43
дл 65
рук 59', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-07 00:30:40.69716', NULL, 0.00);
INSERT INTO public.clothing VALUES (2184, 'M', 'Tommy Hilfiger', 'Windbreaker', 'Blue, Navy', 170, '686348', 32.00, 66.43, 81, 22, 'chest: 51
length: 65
arm: 64
shoulders: 40', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-21 17:16:31.179144', NULL, 0.00);
INSERT INTO public.clothing VALUES (2518, 'S', 'DKNY', 'Puffy Jacket', 'Black', NULL, '391329', 25.00, 101.79, 84, 22, 'from costco

chest: 53
length: 87
arm: 63
shoulders: 42', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-13 02:14:16.17618', NULL, 6.51);
INSERT INTO public.clothing VALUES (2512, 'XS', 'DKNY', 'Puffy Jacket', 'Grey', NULL, '391268', 25.00, 101.79, 81, 22, 'from costco

chest: 50
length: 84
arm: 63
shoulders: 41', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-12 01:46:37.494805', NULL, 0.00);
INSERT INTO public.clothing VALUES (2718, 'M', 'Karl Lagerfeld', 'T-Shirt', 'Grey', 223, '732867', 16.99, 39.29, 95, 22, 'karl lagerfeld face
chest: 51
length: 75
', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-02-27 22:51:21.903747', NULL, 0.00);
INSERT INTO public.clothing VALUES (2080, 'XS', 'Calvin Klein', 'Hoodie', 'White, Cream', 160, '432219', 21.99, 50.00, 81, 22, 'chest: 51
length: 61
arm: 65', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-13 11:46:46.731701', NULL, 0.00);
INSERT INTO public.clothing VALUES (2486, 'L', 'Tommy Hilfiger', 'Sweater', 'Tan', 194, '130160', 10.00, 39.29, 88, 22, 'golfik

chest: 51
length: 67
arm: 61', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-08 00:59:17.900876', NULL, 0.00);
INSERT INTO public.clothing VALUES (2505, 'XS', 'Levis', 'Puffy Jacket', 'Orange', 203, '094393', 41.99, 83.93, 81, 22, 'chest: 55
length: 56
arm: 55/70', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-11 23:36:14.740173', NULL, 0.00);
INSERT INTO public.clothing VALUES (2567, 'XXXL', 'Tommy Hilfiger', 'T-Shirt', 'White', 209, '079211', 7.58, 25.00, 95, 22, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-15 04:44:42.632666', NULL, 0.00);
INSERT INTO public.clothing VALUES (770, '14/16L', 'Calvin Klein', 'Hoodie', 'Pink', NULL, '488588', 13.00, 32.14, 81, 21, 'kids clothes
14-16 years
costco
super furry/fluffy

chest: 44
length: 61
arm: 68', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:00.381209', NULL, 0.00);
INSERT INTO public.clothing VALUES (2566, 'S', 'Tommy Hilfiger', 'Sweater', 'Navy', 209, '394802', 14.44, 42.86, 85, 21, 'chest: 52
length: 67
arm: 68', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-15 04:43:58.384003', NULL, 0.00);
INSERT INTO public.clothing VALUES (2511, 'XS', 'DKNY', 'Puffy Jacket', 'Black', NULL, '391336', 25.00, 101.79, 81, 23, 'from costco

chest: 50
length: 84
arm: 63
shoulders: 41', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-12 01:46:07.158449', NULL, 0.00);
INSERT INTO public.clothing VALUES (2989, 'M', 'Michael Kors', 'Sweat Shirt', 'Black', 231, '937830', 24.00, NULL, 99, NULL, 'с серебр буквами
ПОГ 53
дл 70
рук 51/69', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-07 01:10:25.185959', NULL, 0.00);
INSERT INTO public.clothing VALUES (2975, '6', 'Karl Lagerfeld', 'Jeans', 'Blue', 230, 'KLP006', 24.99, NULL, 99, NULL, 'с полоской с боку
ПОТ 38
ПОБ 42
пос 23
дл 97', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-07 00:24:49.437031', NULL, 0.00);
INSERT INTO public.clothing VALUES (2962, 'M', 'Calvin Klein', 'Belt', 'Brown', 229, '268762', 12.99, NULL, 99, NULL, 'коричневый
101 см', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-06 23:50:49.177019', NULL, 0.00);
INSERT INTO public.clothing VALUES (2949, 'M', 'Tommy Hilfiger', 'Sweat Shirt', 'White', 229, '830284', 16.00, NULL, 102, NULL, 'с флагом и вышитыми буквами
ПОГ 52
дл 61
рук 62', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-06 23:26:41.149838', NULL, 0.00);
INSERT INTO public.clothing VALUES (2987, 'S', 'DKNY', 'Puffy Jacket', 'Black', NULL, '391329', 20.00, NULL, 102, NULL, 'from costco

chest: 53
length: 87
arm: 63
shoulders: 42', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-07 01:08:49.623795', NULL, 0.00);
INSERT INTO public.clothing VALUES (2998, 'L', 'Calvin Klein', 'T-Shirt', 'Black', NULL, '793359', 12.99, NULL, 99, NULL, 'grey ck

chest: 57
length: 71', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-03-08 00:20:41.120017', NULL, NULL);
INSERT INTO public.clothing VALUES (3039, 'M', 'Calvin Klein', 'T-Shirt', 'Black', NULL, 'CK000', 12.99, NULL, 101, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-11 03:25:09.42568', NULL, NULL);
INSERT INTO public.clothing VALUES (2082, 'S', 'Calvin Klein', 'Sweat Shirt', 'Pink', 160, '431854', 19.99, 44.64, 60, 19, 'chest: 51
length: 57
arm: 69', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-13 11:48:38.813485', NULL, 6.35);
INSERT INTO public.clothing VALUES (2049, 'N/A', 'Armani Exchange', 'Bag', 'White', 156, '786539', 39.99, 82.14, 57, 19, 'length: 42
width: 15
height: 24', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 13:35:17.41607', NULL, 7.69);
INSERT INTO public.clothing VALUES (115, 'XXS', 'Tommy Hilfiger', 'Sweat Pants', 'Navy', 13, '790762', 15.99, 44.64, 6, 19, 'Block letters "Tommy hilfiger" down leg

Waist: 31
Hips: 42
Length: 95
Pasadka: 22', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.650783', NULL, 2.98);
INSERT INTO public.clothing VALUES (2180, 'XXS', 'Tommy Hilfiger', 'Sweater', 'Navy', 169, '653893', 13.59, 42.86, 70, 19, 'chest: 40
length: 61
arm: 61', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-21 17:05:29.959072', NULL, 4.79);
INSERT INTO public.clothing VALUES (402, 'S', 'Calvin Klein', 'Sweat Shirt', 'Black', NULL, '958665', 24.99, 50.00, 57, 19, 'silver sign on chest

chest: 57
length: 60/70
arm: 44/68', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.178707', NULL, 7.69);
INSERT INTO public.clothing VALUES (2120, 'M', 'Calvin Klein', 'Sweat Pants', 'Black', 163, '471621', 19.99, 46.43, 73, 19, 'Calvin in front
Klein on back
non-sewn waist

waist: 40
hips:  51
pasadka: 25
length: 95', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-16 18:43:12.346528', NULL, 4.69);
INSERT INTO public.clothing VALUES (591, 'S', 'Tommy Hilfiger', 'Sweater', 'Red', NULL, '398947', 15.00, 39.29, 19, 19, 'circle logo sign on chest', true, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.822766', NULL, 5.20);
INSERT INTO public.clothing VALUES (563, 'M', 'Armani Exchange', 'Sweat Shirt', 'Navy, Grey', 33, '884120', 24.99, 78.57, 18, 19, 'down padding in front

chest: 49
length: 61
arm: 65', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.588475', NULL, 7.88);
INSERT INTO public.clothing VALUES (2112, 'S', 'DKNY', 'Puffy Jacket', 'Black', NULL, '391329', 49.99, 101.79, 57, 19, 'from costco

chest: 53
length: 87
arm: 63
shoulders: 42', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-16 14:40:30.531596', NULL, 7.69);
INSERT INTO public.clothing VALUES (2247, 'M', 'DKNY', 'Puffy Jacket', 'Grey', NULL, '391244', 49.99, 101.79, 65, 19, 'from costco

chest: 56
length: 88
arm: 66
shoulders: 43', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-22 10:29:25.824761', NULL, 7.58);
INSERT INTO public.clothing VALUES (2114, 'M', 'DKNY', 'Puffy Jacket', 'Black', NULL, '391312', 49.99, 101.79, 69, 19, 'from costco

chest: 56
length: 88
arm: 66
shoulders: 43', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-16 14:41:04.615209', NULL, 8.68);
INSERT INTO public.clothing VALUES (2253, 'S', 'DKNY', 'Puffy Jacket', 'Grey', NULL, '391251', 49.99, 101.79, 65, 19, 'from costco

chest: 53
length: 87
arm: 63
shoulders: 42', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-22 10:29:53.541317', NULL, 7.58);
INSERT INTO public.clothing VALUES (2019, 'XS', 'Calvin Klein', 'Jacket', 'Black', 155, '015313', 20.72, 66.07, 66, 19, 'double sided
(black on other side)

chest: 51
length: 60
arm: 62', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 12:15:38.325992', NULL, 4.63);
INSERT INTO public.clothing VALUES (521, 'L', 'Calvin Klein', 'Puffy Jacket', 'Black', 38, '875436', 41.99, 110.71, 17, 19, 'Men
long

chest: 64
length: 91
arm: 69', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:58.219353', NULL, 7.82);
INSERT INTO public.clothing VALUES (369, 'S', 'Calvin Klein', 'Puffy Jacket', 'White', 29, '876587', 40.37, 101.79, 60, 19, 'tiny short

chest: 56
length: 68
arm: 67', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.890237', NULL, 6.35);
INSERT INTO public.clothing VALUES (2192, 'N/A', 'Armani Exchange', 'Purse', 'Pink', 171, '256246', 29.99, 67.86, 70, 19, 'Glossy/Shiny
length: 19
height: 15
width: 7', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-21 17:23:11.803705', NULL, 4.79);
INSERT INTO public.clothing VALUES (2048, 'S', 'Armani Exchange', 'Sweater', 'Navy', 156, '349529', 9.99, 60.71, 69, 19, 'chest: 48
length: 62
arm: 63', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-08 13:34:04.793958', NULL, 8.68);
INSERT INTO public.clothing VALUES (2083, 'S', 'Calvin Klein', 'Sweat Shirt', 'Pink', 160, '431854', 19.99, 44.64, 77, 19, 'chest: 51
length: 57
arm: 69', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-13 11:48:56.799963', NULL, 4.35);
INSERT INTO public.clothing VALUES (3108, 'XXS', 'Tommy Hilfiger', 'Dress', 'Black', 268, '439985', 25.49, NULL, 102, NULL, 'chest: 43
arm: 57
length: 86', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-13 04:28:49.690372', NULL, 0.00);
INSERT INTO public.clothing VALUES (2695, '4', 'Armani Exchange', 'Blazer', 'Pink', 222, '365414', 39.99, 89.29, 95, 23, 'chest: 49
length: 75
arm: 59
shoulders: 41', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-27 22:17:27.190231', NULL, 0.00);
INSERT INTO public.clothing VALUES (3112, 'XS', 'Tommy Hilfiger', 'Sweat Shirt', 'Navy', 268, '430388', 25.49, NULL, 102, NULL, 'cursive letters + circle logo

Chest: 46
Length: 61
Arm: 59

', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-13 04:53:24.694693', NULL, 0.00);
INSERT INTO public.clothing VALUES (3131, 'M', 'Tommy Hilfiger', 'Hoodie', 'Navy, White', NULL, '554675', 19.99, NULL, 102, NULL, 'white line across chest

Chest: 50
Length: 51
Arm to neck: 71
', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-13 05:36:07.677839', NULL, 0.00);
INSERT INTO public.clothing VALUES (3066, '2', 'Calvin Klein', 'Dress', 'Blue', 235, '203949', 29.99, NULL, 102, NULL, 'gold zipper
chest: 39
waist: 34
length: 96', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-12 23:50:17.162677', NULL, 0.00);
INSERT INTO public.clothing VALUES (3132, 'L', 'Calvin Klein', 'Jean Jacket', 'White', NULL, '491278', 14.99, NULL, 102, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-15 03:34:40.473984', NULL, NULL);
INSERT INTO public.clothing VALUES (2863, '6', 'Tommy Hilfiger', 'Jeans', 'Blue', NULL, '103092', 14.99, NULL, 102, NULL, 'no tag
circle NY tommy hilfiger

waist: 41
hips: 47
pasadka: 22
length: 93', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 05:07:53.219636', NULL, 0.00);
INSERT INTO public.clothing VALUES (3113, 'S', 'Tommy Hilfiger', 'Sweat Shirt', 'Navy', 268, '430395', 25.49, NULL, 102, NULL, 'cursive letters + circle logo

Chest: 48
Length: 62
Arm: 59

', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-13 04:54:54.061777', NULL, 0.00);
INSERT INTO public.clothing VALUES (3711, 'N/A', 'Michael Kors', 'Purse', 'White', NULL, '274491', 81.82, NULL, 123, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-04-10 23:49:35.188422', NULL, 0.00);
INSERT INTO public.clothing VALUES (2970, 'M', 'Calvin Klein', 'T-Shirt', 'Purple', 230, '412129', 12.99, 30.36, 99, 23, 'ПОГ 48
дл 64', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-07 00:13:38.035059', NULL, 0.00);
INSERT INTO public.clothing VALUES (3000, 'S', 'Calvin Klein', 'Polo Shirt', 'Black', NULL, '294507', 19.99, 35.00, 99, 23, 'ck on shoulder

chest: 50
length: 70', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-03-08 00:24:54.835549', NULL, NULL);
INSERT INTO public.clothing VALUES (3713, 'S', 'Guess', 'T-Shirt', 'White', NULL, '??????', 12.99, 28.57, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-04-11 11:19:34.439331', NULL, 4.00);
INSERT INTO public.clothing VALUES (3712, 'S', 'Calvin Klein', 'Bomber Jacket', 'Black', NULL, '??????', 50.00, 82.14, NULL, 23, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-04-11 11:15:39.302955', NULL, 4.00);
INSERT INTO public.clothing VALUES (2907, 'M', 'Calvin Klein', 'Sweat Pants', 'Light Blue', NULL, '337743', 19.99, 46.43, 99, 23, 'no fleece
white dot

waist: 41
hips: 51
pasadka: 27
length: 95', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 05:49:30.84842', NULL, 0.00);
INSERT INTO public.clothing VALUES (2730, 'XS', 'Tommy Hilfiger', 'Sweat Pants', 'Blue', 225, '006257', 32.39, NULL, 102, NULL, 'blue mesh

waist: 36
hips: 50
pasadka: 24
length: 96', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-01 01:04:34.027201', NULL, 4.57);
INSERT INTO public.clothing VALUES (2969, 'XS', 'Tommy Hilfiger', 'Blazer', 'Navy', 230, '235919', 24.99, NULL, 99, NULL, 'с пуговицами вдоль
ПОГ 43
дл 54
рук 60
плечи 38', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-07 00:12:02.587849', NULL, 3.50);
INSERT INTO public.clothing VALUES (3001, 'S', 'Karl Lagerfeld', 'Hoodie', 'Black', NULL, 'LORE7067', 20.99, NULL, 128, NULL, 'chest: 46
length: 59
arm: 60', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-08 00:25:28.349211', NULL, 3.39);
INSERT INTO public.clothing VALUES (2999, 'M', 'Calvin Klein', 'Polo Shirt', 'Black', NULL, '294514', 19.99, 39.29, 99, 23, 'ck on shoulder

chest: 52
length: 71', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-03-08 00:23:43.858786', NULL, 0.00);
INSERT INTO public.clothing VALUES (2387, 'XS', 'Karl Lagerfeld', 'Sweat Shirt', 'Blue', 191, 'LORHS082', 24.99, 53.57, 111, 23, 'golden glasses

chest: 47
length: 59
arm: 58', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-07 21:09:03.931673', NULL, 0.00);
INSERT INTO public.clothing VALUES (3118, 'M', 'Tommy Hilfiger', 'Dress', 'White', NULL, '830529', 12.00, 50.00, 107, 23, 'flag on chest
chest: 57
length: 87', NULL, 'women', NULL, NULL, NULL, NULL, '2021-03-13 05:05:55.820476', NULL, NULL);
INSERT INTO public.clothing VALUES (2891, 'S', 'Tommy Hilfiger', 'Sweat Pants', 'Grey', NULL, '774625', 19.99, 50.00, 107, 23, 'large blue tommy hilfiger on sides

waist: 38
hips: 52
pasadka: 24
length: 94', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-04 05:37:10.840337', NULL, NULL);
INSERT INTO public.clothing VALUES (2890, 'S', 'Tommy Hilfiger', 'Hoodie', 'Grey', NULL, '774748', 24.99, 50.00, 107, 23, 'large blue tommy hilfiger on sides

chest: 55
length: 66
arm: 62', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-04 05:36:24.576051', NULL, NULL);
INSERT INTO public.clothing VALUES (2454, 'XS', 'Calvin Klein', 'Dress', 'Blue', 201, '404346', 24.99, 55.36, 81, 23, 'chest: 48
length: 83
arm: 63', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-08 00:06:02.658511', NULL, 0.00);
INSERT INTO public.clothing VALUES (2924, 'S', 'Calvin Klein', 'T-Shirt', 'White', NULL, '455591', 12.99, 25.00, 104, 23, 'red ck on k
chest: 41
length: 54
', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-04 06:05:35.303118', NULL, 0.00);
INSERT INTO public.clothing VALUES (2959, 'S', 'Calvin Klein', 'Belt', 'Grey, Black', 229, '286650', 12.99, 35.00, 99, 23, 'двухстор чёрно серый
94 см', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-06 23:47:41.564135', NULL, 0.00);
INSERT INTO public.clothing VALUES (2768, 'L', 'Guess', 'T-Shirt', 'Black', 226, '253941', 12.99, 26.79, 111, 23, 'guess with city inside
chest: 54
length: 72', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-01 06:05:34.951425', NULL, NULL);
INSERT INTO public.clothing VALUES (2706, 'M', 'Armani Exchange', 'Blazer', 'Navy', 222, '405888', 29.99, 89.29, 105, 23, 'small armani exchange circle on chest

chest: 54
length: 72
arm: 64
shoulders: 48', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-02-27 22:41:51.521251', NULL, 0.00);
INSERT INTO public.clothing VALUES (250, 'S', 'Tommy Hilfiger', 'Leather Jacket', 'Brown, Grey', 22, '129521', 81.00, 150.00, 105, 23, 'Grey/brownish color

Chest: 46
Waist: 41
Length: 57
Arm: 62', NULL, 'women', NULL, NULL, NULL, 'usa', '2020-12-21 01:07:55.847021', NULL, 0.00);
INSERT INTO public.clothing VALUES (2132, 'S', 'Tommy Hilfiger', 'Dress', 'White', 165, '830536', 19.99, 50.00, 107, 23, 'with flag

chest: 51
length: 86
', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-01-16 18:58:56.109905', NULL, NULL);
INSERT INTO public.clothing VALUES (2097, 'S', 'Karl Lagerfeld', 'Sweat Shirt', 'Black', 161, '851353', 69.99, 80.36, 105, 23, 'white/pink line down arms
"karl lagerfeld" on white/pink line
pink outlining

chest: 51
length: 66
arm: 59', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-01-13 12:14:10.465144', NULL, 0.00);
INSERT INTO public.clothing VALUES (2096, 'S', 'Karl Lagerfeld', 'Sweat Pants', 'Black', 161, '851308', 49.99, 71.43, 105, 23, 'white/pink line down side
"karl lagerfeld" on white/pink line

waist: 40
hips: 52
pasadka: 27
length: 102', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-01-13 12:12:41.094615', NULL, 0.00);
INSERT INTO public.clothing VALUES (460, 'XS', 'Calvin Klein', 'T-Shirt', 'Black', 34, '803668', 9.97, 28.57, 34, 23, 'payetki sign on chest

chest: 40
length: 62', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:57.691535', NULL, 0.00);
INSERT INTO public.clothing VALUES (2628, 'M', 'Tommy Hilfiger', 'Dress', 'Black', 215, '200146', 19.99, 50.00, 99, 23, '3d letters
chest: 48
length: 90', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-22 07:29:40.966352', NULL, 0.00);
INSERT INTO public.clothing VALUES (3319, 'M', 'Calvin Klein', 'Dress', 'Black', 279, '779879201999', 19.99, NULL, 121, NULL, 'с золотой надписью CAlvin klein
ПОГ 46
ПОб 52
дл 92', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-25 03:19:01.079651', NULL, 0.00);
INSERT INTO public.clothing VALUES (3322, 'M', 'Calvin Klein', 'Dress', 'Black', 279, '779879201999', 19.99, NULL, NULL, NULL, 'с золотой надписью CAlvin klein
ПОГ 46
ПОб 52
дл 92', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-25 03:20:34.337517', NULL, 0.00);
INSERT INTO public.clothing VALUES (2819, '2', 'Michael Kors', 'Jeans', 'Navy', NULL, '442838', 24.99, 64.29, 101, 23, 'с двумя пуговицами
ПОТ 34
ПОБ 43
длина 102
посадка 25', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 01:54:01.329367', NULL, 0.00);
INSERT INTO public.clothing VALUES (2966, 'M', 'Tommy Hilfiger', 'Bodic', 'Navy', 230, '808146', 11.99, 39.29, 99, 23, 'ПОГ 45
дл 66', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-07 00:05:01.981817', NULL, 3.39);
INSERT INTO public.clothing VALUES (2304, 'L', 'Tommy Hilfiger', 'Windbreaker', 'Navy', 183, '405638', 24.00, 65.00, 105, 23, 'Chest: 60
length: 79
arm from neck:  82', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-26 15:47:55.855955', NULL, 3.53);
INSERT INTO public.clothing VALUES (2059, '38', 'Calvin Klein', 'Belt', 'Black', 157, '267320', 14.99, 32.14, 74, 23, 'reversible
length: 110
width: 3', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-01-13 11:14:29.545634', NULL, 0.00);
INSERT INTO public.clothing VALUES (2220, 'M', 'Tommy Hilfiger', 'Hoodie', 'White', NULL, '181994', 16.00, 39.29, 72, 23, 'chest: 51
length: 68
arm from the neck: 72', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-21 17:53:56.485558', NULL, 0.00);
INSERT INTO public.clothing VALUES (1879, 'S', 'Calvin Klein', 'Jacket', 'White', NULL, '022373', 39.99, 71.43, NULL, 23, 'delivery $4
cold sleeves

chest: 48
waist: 42
hips: 51
length: 70
arm from neck: 73', true, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-01 11:02:41.978395', NULL, 0.00);
INSERT INTO public.clothing VALUES (2122, 'XS', 'Tommy Hilfiger', 'Sweater', 'White', 164, '653763', 13.59, 44.64, 65, 23, 'knitted
V-neck
vyazeny ko-seey

Chest: 43
length: 59
arm: 62', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-16 18:46:05.013853', NULL, 0.00);
INSERT INTO public.clothing VALUES (2480, 'S', 'Karl Lagerfeld', 'Sweat Shirt', 'Black, White', 201, 'LORH7092', 22.99, 57.14, 107, 23, 'Black sunglasses

chest: 51
length: 63
arm: 61', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-08 00:47:07.151223', NULL, 0.00);
INSERT INTO public.clothing VALUES (2591, 'S', 'Calvin Klein', 'Windbreaker', 'Black', 211, '415236', 49.99, 89.29, 105, 23, 'stripe "calvin" on sleeve

chest: 55
length: 68
arm: 66
shoulders: 49', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-02-18 02:58:08.654509', NULL, 0.00);
INSERT INTO public.clothing VALUES (1526, 'N/A', 'Guess', 'Purse', 'Red', 56, '414506', 19.99, 35.00, 42, 23, 'zipper on right of "guess"
black card pouch on back

length: 11
height: 19', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:14.695697', NULL, NULL);
INSERT INTO public.clothing VALUES (2186, 'L', 'Tommy Hilfiger', 'Windbreaker', 'Navy, White', 170, '686423', 32.00, 66.43, 99, 23, 'chest: 54
length: 67
arm: 64
shoulders: 43', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-21 17:17:42.074489', NULL, 0.00);
INSERT INTO public.clothing VALUES (246, 'L', 'Tommy Hilfiger', 'Puffy Jacket', 'Black', NULL, '424164', 59.99, 114.29, 84, 23, 'Men

Chest: 60
Waist: 58
Length: 72
Arm: 70', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:55.815597', NULL, 0.00);
INSERT INTO public.clothing VALUES (2237, 'L', 'Michael Kors', 'Polo Shirt', 'Black', 175, '986079', 19.99, 50.00, 66, 23, 'chest: 56
length: 70', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-01-22 10:08:09.342885', NULL, 0.00);
INSERT INTO public.clothing VALUES (2301, 'XS', 'Tommy Hilfiger', 'Sweat Pants', 'Navy', 183, '621533', 10.39, 46.43, 72, 23, 'Tommy Jeans

waist: 35
hips: 49
pasadka: 25
length: 90', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-26 15:40:56.734774', NULL, 0.00);
INSERT INTO public.clothing VALUES (2357, 'M', 'Calvin Klein', 'Hoodie', 'Black', 188, '657810', 16.99, 48.21, 81, 23, 'oversized
"calvin" on one sleeve

chest: 56
length: 63
arm: 55/77', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-31 15:15:57.656759', NULL, 0.00);
INSERT INTO public.clothing VALUES (263, 'M', 'Calvin Klein', 'Sweat Pants', 'Black', NULL, '957118', 19.99, 46.43, 81, 23, 'Calvin Klein down leg

Waist: 43
Hips: 51
Length: 99
Pasadka: 25', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:55.950084', NULL, 0.00);
INSERT INTO public.clothing VALUES (2953, 'M', 'Michael Kors', 'T-Shirt', 'White', 229, '436578', 19.99, 42.86, 104, 23, 'с золотыми буквами\
ПОГ 50
дл 64', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-06 23:35:55.483825', NULL, 0.00);
INSERT INTO public.clothing VALUES (2649, 'L', 'Armani Exchange', 'Sweater', 'Navy', 217, '336732', 30.00, 64.29, 105, 23, 'green sign A|X
zipped
chest: 57
length: 68
arm: 67', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-02-23 20:48:25.889054', NULL, 0.00);
INSERT INTO public.clothing VALUES (3495, 'L', 'Armani Exchange', 'Sweater', 'Grey', 287, '4150224', 19.99, 27.30, 118, 9, NULL, NULL, 'men', NULL, NULL, NULL, 'usa', '2021-04-02 21:37:50.60019', NULL, NULL);
INSERT INTO public.clothing VALUES (2610, 'M', 'Tommy Hilfiger', 'Sweat Shirt', 'Navy', 214, '013323', 31.49, 53.57, 105, 23, 'chest: 51
length: 62
arm: 60', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-22 06:56:59.213335', NULL, 0.00);
INSERT INTO public.clothing VALUES (2929, 'S', 'Karl Lagerfeld', 'T-Shirt', 'White', NULL, 'LOORH6009', 16.99, 39.29, 99, 23, 'flower letters + eiffel tower

chest: 46
length: 62', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 06:12:06.33316', NULL, 0.00);
INSERT INTO public.clothing VALUES (1742, '4', 'Tommy Hilfiger', 'Blazer', 'Yellow', NULL, '358250', 24.99, 64.29, NULL, 23, NULL, true, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 08:02:38.97156', NULL, 4.00);
INSERT INTO public.clothing VALUES (3714, 'M', 'Calvin Klein', 'Coat', 'Black', NULL, '??????', 40.00, 75.00, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-04-11 11:45:43.964857', NULL, 4.00);
INSERT INTO public.clothing VALUES (3715, '4', 'Tommy Hilfiger', 'Blazer', 'Navy', NULL, '??????', 25.00, 75.00, NULL, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-04-11 12:02:56.64691', NULL, 4.00);
INSERT INTO public.clothing VALUES (2972, 'M', 'Karl Lagerfeld', 'T-Shirt', 'Black', 230, 'LORH7052', 19.99, 39.29, 99, 23, 'c паетками
ПОГ  51
ДЛ 63', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-07 00:17:49.576881', NULL, 0.00);
INSERT INTO public.clothing VALUES (2957, 'S', 'Michael Kors', 'Hoodie', 'Black', 229, '440919', 29.99, 64.29, 106, 23, 'с белым МК на груди
ПОГ 56
дл 65
рук 49/71', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-06 23:43:46.500392', NULL, 0.00);
INSERT INTO public.clothing VALUES (2536, 'S', 'Michael Kors', 'Puffy Jacket', 'Brown', 206, '280378', 70.00, 140.00, 101, 23, 'chest: 52
length: 74
arm: 64', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-15 04:02:16.127362', NULL, 0.00);
INSERT INTO public.clothing VALUES (2954, 'M', 'Calvin Klein', 'Sweat Shirt', 'Light Blue', 229, '204199', 19.99, 46.43, 99, 23, 'светло голубой с calvin klein jeans на груди
ПОГ 57
дл 53
рук 48/73', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-06 23:38:01.701749', NULL, 0.00);
INSERT INTO public.clothing VALUES (344, 'XS', 'Calvin Klein', 'Jean Jacket', 'Blue', 27, '105815', 16.75, 64.29, 72, 23, 'Buttons

Chest: 53
Waist: 52
Length: 65
Arm: 57', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:56.674414', NULL, 0.00);
INSERT INTO public.clothing VALUES (3509, '2', 'Armani Exchange', 'Blazer', 'Black', 287, '4365728', 39.99, 100.00, NULL, 23, 'с полоской с боку
ПОГ 47
дл 71
плечи 40
рукав 61', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-02 22:35:54.316718', NULL, NULL);
INSERT INTO public.clothing VALUES (3615, '6', 'Armani Exchange', 'Blazer', 'Black', NULL, '4365742', 0.00, NULL, NULL, NULL, 'с полоской с боку
ПОГ 50
дл 72
плечи 40
рукав 62', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-04 18:44:57.491628', NULL, 0.00);
INSERT INTO public.clothing VALUES (3590, 'M', 'Armani Exchange', 'Golfik', 'Black', 293, '0324127', 29.99, 60.71, NULL, 23, 'с розово золотыми буквами Армани
ПОГ 47
дл 59
рук 62', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-04 05:29:23.425643', NULL, NULL);
INSERT INTO public.clothing VALUES (3513, '0', 'Armani Exchange', 'Pants', 'Black', 287, '0288030', 19.99, 64.29, NULL, 23, 'Кюлоты
ПОТ 30
ПОБ 54
дл 94
пос 34
', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-02 22:46:50.433825', NULL, NULL);
INSERT INTO public.clothing VALUES (3601, '25', 'Armani Exchange', 'Jeans', 'Grey', 293, '0458082', 29.99, 75.00, NULL, 23, 'ПОТ 32
ПОБ 38.5
дл 92
пос 21', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-04 05:59:29.808561', NULL, 0.00);
INSERT INTO public.clothing VALUES (3515, 'XS', 'Armani Exchange', 'Puffy Jacket', 'Black', 287, '0321508', 79.99, 140.00, NULL, 23, 'куртка с поясом
ПОГ 45
ПОБ 50
дл 87
рук 60
плечи  40
', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-02 22:54:34.646117', NULL, 0.00);
INSERT INTO public.clothing VALUES (2594, 'XS', 'Tommy Hilfiger', 'Sweat Shirt', 'Purple', 212, '430593', 19.19, 44.64, 88, 23, 'circle sign

chest: 47
length: 61
arm: 59', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-18 03:01:50.952635', NULL, 0.00);
INSERT INTO public.clothing VALUES (2772, 'S', 'Calvin Klein', 'Dress', 'Black', 226, '398089', 19.99, 50.00, NULL, 23, 'calvin klein stripe on side', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-01 06:08:45.897693', NULL, NULL);
INSERT INTO public.clothing VALUES (3507, '6', 'Armani Exchange', 'Blazer', 'Black', 287, '4365742', 39.99, 100.00, NULL, 23, 'с полоской с боку
ПОГ 50
дл 72
плечи 40
рукав 62', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-02 22:29:14.22407', NULL, NULL);
INSERT INTO public.clothing VALUES (3521, 'L', 'Armani Exchange', 'Jean Jacket', 'Navy', 287, '0336045', 49.99, 92.86, NULL, 23, 'джинсовая как пуховик
ПОГ 58
рук 66
плечи 50
дл 66
', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-04-02 23:08:59.855381', NULL, NULL);
INSERT INTO public.clothing VALUES (3641, 'S', 'Armani Exchange', 'Dress', 'Pink', 294, '7212634', 28.00, 60.00, NULL, 23, 'ПОГ 51
ПОБ 49
дл 91
', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-06 21:13:49.670715', NULL, 0.00);
INSERT INTO public.clothing VALUES (3640, 'XS', 'Armani Exchange', 'Dress', 'Pink', 294, '7212603', 28.00, 60.00, NULL, 23, 'ПОГ 48
ПОБ 46
дл 91
', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-06 21:13:22.697981', NULL, 0.00);
INSERT INTO public.clothing VALUES (3519, 'XL', 'Armani Exchange', 'Vest Jacket', 'Black', 287, '4114936', 39.99, 94.64, NULL, 23, 'ПОГ 53
дл 66
', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-02 23:03:48.007679', NULL, NULL);
INSERT INTO public.clothing VALUES (3516, 'M', 'Armani Exchange', 'Puffy Jacket', 'Black', 287, '0321478', 79.99, 140.00, NULL, 23, 'куртка с поясом маломерит 
ПОГ 51
ПОБ 56
дл 88
рук 63
плечи  43
', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-02 22:58:21.699468', NULL, NULL);
INSERT INTO public.clothing VALUES (3639, 'M', 'Armani Exchange', 'Vest Jacket', 'Red', 294, '0477748', 28.50, 64.29, NULL, 23, 'красная пуховая жилетка
ПОГ 51
дл  60', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-04-06 21:10:18.923843', NULL, 0.00);
INSERT INTO public.clothing VALUES (3514, 'S', 'Armani Exchange', 'Puffy Jacket', 'Black', 287, '0321485', 79.99, 140.00, NULL, 23, 'куртка с поясом
ПОГ 48
ПОБ 53
дл 87
рук 63
плечи  41
', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-02 22:52:33.345801', NULL, 0.00);
INSERT INTO public.clothing VALUES (3512, '4', 'Armani Exchange', 'Pants', 'Black', 287, '0288085', 19.99, 64.29, NULL, 23, 'Кюлоты
ПОТ 32
ПОБ 54
дл 94
пос 34
', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-02 22:46:18.656157', NULL, NULL);
INSERT INTO public.clothing VALUES (692, 'S', 'Tommy Hilfiger', 'Sweat Shirt', 'Navy', 45, '733325', 13.99, NULL, 128, NULL, 'red/white waist-band
adjustable waist

Chest: 54
length: 55
arm: 55', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.723178', NULL, 6.35);
INSERT INTO public.clothing VALUES (3716, 'L', 'DKNY', 'Coat', 'Black', NULL, '264449', 44.99, 114.29, NULL, 23, 'chest: 63
length: 93
arm: 68
shoulders: 53', NULL, 'men', NULL, NULL, NULL, NULL, '2021-04-12 20:24:02.303552', NULL, NULL);
INSERT INTO public.clothing VALUES (3433, 'XL', 'Armani Exchange', 'Polo Shirt', 'Blue', 283, '7431318', 19.99, 50.00, NULL, 23, 'надпись слева на груди
Armani Exchange milano NY

ПОГ 59
дл 74
плечи 52', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-30 21:20:23.077949', NULL, 0.00);
INSERT INTO public.clothing VALUES (132, 'S', 'Calvin Klein', 'Sweat Pants', 'Black', 15, '082926', 30.35, NULL, 28, NULL, 'White outlined black stripe with "cavin klein ck" down leg

Waist: 38
Hips: 50
Length: 90
Pasadka: 25', true, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.821106', NULL, 6.43);
INSERT INTO public.clothing VALUES (1424, 'M', 'Calvin Klein', 'Long Sleeved Shirt', 'Black', 129, '794883', 2.01, NULL, 106, NULL, 'Chest: 54
Waist: 50
Length: 74
Arm: 66', true, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:13.764109', NULL, 0.00);
INSERT INTO public.clothing VALUES (2905, 'S', 'Tommy Hilfiger', 'Hoodie', 'Grey', 228, '432320', 28.34, NULL, 102, NULL, 'chest: 52
length: 56
arm: 62', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 05:45:47.458432', NULL, 4.57);
INSERT INTO public.clothing VALUES (2904, 'S', 'Tommy Hilfiger', 'Sweat Pants', 'Grey', 228, '006615', 32.39, NULL, 102, NULL, 'waist: 38
hips: 54
pasadka: 25
length: 96', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 05:45:20.245552', NULL, 4.57);
INSERT INTO public.clothing VALUES (2741, 'XS', 'Tommy Hilfiger', 'Hoodie', 'Blue', 225, '003959', 28.34, NULL, 102, NULL, 'blue mesh

chest: 47
length: 56
arm: 61', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-01 01:16:55.171755', NULL, 4.57);
INSERT INTO public.clothing VALUES (3107, 'S', 'Tommy Hilfiger', 'Sweat Pants', 'Navy', 225, '006127', 32.39, NULL, 102, NULL, 'waist: 38
hips: 53
pasadka: 25
length: 95', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-13 04:23:13.799717', NULL, 4.57);
INSERT INTO public.clothing VALUES (687, 'XS', 'Tommy Hilfiger', 'T-Shirt', 'Pink', 45, '433303', 26.32, NULL, 102, NULL, 'with belly pocket

white line across chest
with navy "Tommy"

chest: 49
length: 54', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:59.680262', NULL, 4.57);
INSERT INTO public.clothing VALUES (1934, 'M', 'Karl Lagerfeld', 'Sweat Pants', 'Red', NULL, '339698', 49.99, NULL, 128, NULL, 'red stripe on side', NULL, 'women', NULL, NULL, NULL, 'Ukraine', '2021-01-03 04:18:11.506053', NULL, 0.00);
INSERT INTO public.clothing VALUES (2761, 'M', 'Karl Lagerfeld', 'T-Shirt', 'Peach, Coral, Pink', 226, 'LORH0030', 16.99, NULL, 128, NULL, 'rhinestones

chest: 51
length: 66', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-01 05:58:25.180003', NULL, 3.91);
INSERT INTO public.clothing VALUES (2469, 'M', 'Michael Kors', 'Hoodie', 'White', 201, '451717', 29.99, NULL, 128, NULL, 'Black MK, gold rivet holes

chest: 55
length: 66
arm: 71', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-08 00:29:09.121508', NULL, 4.35);
INSERT INTO public.clothing VALUES (2763, 'M', 'Karl Lagerfeld', 'Sweat Shirt', 'White, Black', 226, 'LORH7092', 22.99, NULL, 128, NULL, 'with glasses', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-01 06:02:31.554487', NULL, 4.01);
INSERT INTO public.clothing VALUES (847, 'L', 'Karl Lagerfeld', 'T-Shirt', 'White', NULL, '152167', 19.99, NULL, 128, NULL, 'perfume bottle

chest: 54
length: 63', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:01.032026', NULL, NULL);
INSERT INTO public.clothing VALUES (848, 'S', 'Karl Lagerfeld', 'T-Shirt', 'White', NULL, '159784', 19.99, NULL, 128, NULL, 'with a picture

chest: 47
length: 62', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:08:01.039673', NULL, NULL);
INSERT INTO public.clothing VALUES (2314, '8-10', 'DKNY', 'Hoodie', 'Pink', NULL, '554627', 11.99, NULL, 129, NULL, 'kids clothes
8-10 years
gold DKNY sign on chest
chest: 41
length: 46
arm: 45', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-01-27 16:27:12.656726', NULL, 3.65);
INSERT INTO public.clothing VALUES (3717, '14-16L', 'DKNY', 'Puffy Jacket', 'Pink', NULL, '458383', 19.99, NULL, 129, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-04-18 11:09:31.397259', NULL, 3.42);
INSERT INTO public.clothing VALUES (3718, '14-16L', 'Calvin Klein', 'Hoodie', 'Pink', NULL, '??????', 12.99, NULL, 129, NULL, NULL, NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-04-18 11:13:38.963139', NULL, 3.00);
INSERT INTO public.clothing VALUES (2809, 'M', 'Calvin Klein', 'Pants', 'Black', NULL, 'KOLVK247', 24.99, 0.00, 97, 9, 'на манжетах с карманами', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-03 21:45:27.904552', NULL, 0.00);
INSERT INTO public.clothing VALUES (3633, '0', 'Armani Exchange', 'Blazer', 'Black', 294, '4365681', 39.99, 0.00, NULL, 23, 'с полоской с боку
ПОГ 46
дл 69
плечи 38
рукав 60', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-06 21:02:59.76219', NULL, 0.00);
INSERT INTO public.clothing VALUES (3138, '14-16', 'DKNY', 'Jacket', 'Pink', NULL, '457935', 19.99, NULL, 129, NULL, 'kids clothes
bomber
with hood
black wrists with white dkny
black DKNY on chest

chest: 46
length: 55
arm: 55', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-15 22:56:43.34428', NULL, 4.12);
INSERT INTO public.clothing VALUES (3367, 'M', 'Armani Exchange', 'Dress Shirt', 'White', 283, '4139008', 19.99, NULL, NULL, NULL, 'с планкой спереди маормерит
ПОГ 50
ПОТ 48
дл 76
рук 67
плечи 46', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-27 05:15:32.14103', NULL, 0.00);
INSERT INTO public.clothing VALUES (2472, 'XS', 'Michael Kors', 'Sweat Pants', 'White', 201, '450635', 29.99, 64.29, 104, 23, 'black mk down sides

waist: 34
hips: 46
length: 96
pasadka: 26', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-08 00:32:42.619686', NULL, 0.00);
INSERT INTO public.clothing VALUES (2538, 'M', 'Michael Kors', 'Windbreaker', 'Black', 206, '938271', 40.00, 80.00, 104, 23, 'hooded
short
white letters
chest: 56
length: 53
arm: 60', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-15 04:05:35.780631', NULL, 0.00);
INSERT INTO public.clothing VALUES (2175, 'XS', 'Tommy Hilfiger', 'Windbreaker', 'Blue, Navy', 169, '686324', 32.00, 66.43, 106, 23, 'chest: 45
length: 63
arm: 59
shoulders: 38', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-01-21 17:00:27.28724', NULL, 0.00);
INSERT INTO public.clothing VALUES (236, 'XS', 'Calvin Klein', 'Dress', 'Black', 21, '915132', 12.09, 42.86, 72, 23, 'city design in "CK" on chest

Chest: 42
Waist: 38
Length: 84', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:55.736695', NULL, 0.00);
INSERT INTO public.clothing VALUES (1665, 'XS', 'Levis', 'Leather Jacket', 'Green', 56, '800081', 39.99, 75.00, 44, NULL, 'Chest: 43
Waist: 41
Length: 52
Arm: 63', true, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:15.984947', NULL, 0.00);
INSERT INTO public.clothing VALUES (2450, 'S', 'Levis', 'Hoodie', 'Black', 200, '640205', 16.18, 39.29, 76, 23, 'Green Purple Circle

chest: 55
length: 63
arm from neck: 69', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-07 23:58:56.858866', NULL, 0.00);
INSERT INTO public.clothing VALUES (3147, '2', 'Calvin Klein', 'Blazer', 'Peach', NULL, '505593', 25.00, 48.21, 107, 23, 'Chest: 44
Length: 69
Arm: 61
Shoulders: 40', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-18 23:21:29.069128', NULL, NULL);
INSERT INTO public.clothing VALUES (177, 'XS', 'Tommy Hilfiger', 'Sweater', 'White', 18, '728390', 10.39, 39.29, 26, 23, 'V neck
Diamond pattern

Chest: 48
Waist: 45
Length: 65
Arm: 64', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:55.220774', NULL, NULL);
INSERT INTO public.clothing VALUES (2830, 'M', 'Calvin Klein', 'Dress', 'Black', NULL, '398072', 19.99, 50.00, 99, 23, 'с полоской с боку
ПОГ49
ПОБ 52
длина 90', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 02:14:11.436368', NULL, 0.00);
INSERT INTO public.clothing VALUES (2765, 'M', 'Calvin Klein', 'Leggings', 'Black', 226, '282547', 16.99, 39.29, 111, 23, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-01 06:03:15.201306', NULL, NULL);
INSERT INTO public.clothing VALUES (2955, 'S', 'Calvin Klein', 'Hoodie', 'Pink', 229, '454303', 19.99, 50.00, 107, 23, 'розовый чёрный СК на груди
ПОГ 58
дл 49
рук 48/72', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-06 23:39:45.49539', NULL, 0.00);
INSERT INTO public.clothing VALUES (2547, 'S', 'Tommy Hilfiger', 'T-Shirt', 'Black', 207, '814321', 12.99, 28.57, 83, 23, 'white line + block letter "tommy hilfiger" on chest
chest: 46
length: 60', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-02-15 04:24:10.680106', NULL, 0.00);
INSERT INTO public.clothing VALUES (2993, '7', 'Tommy Hilfiger', 'Flip Flops', 'Black', 231, '810391', 12.99, NULL, NULL, NULL, 'c золотым кружочком
через палец
стелька 24.5 см', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-07 01:16:49.818272', NULL, 2.09);
INSERT INTO public.clothing VALUES (3719, 'M', 'Tommy Hilfiger', 'Dress', 'White', NULL, '315269', 18.00, NULL, NULL, NULL, 'ПОГ 51
Длина 93', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-04-21 18:39:39.945879', NULL, 3.00);
INSERT INTO public.clothing VALUES (3720, 'S', 'DKNY', 'Sweat Pants', 'Blue', NULL, '149719', 28.00, NULL, NULL, NULL, 'ПОТ 39
ПОБ 49
Длина 96

Вместе с кофтой DKNY ', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-04-21 18:55:12.160145', NULL, 3.00);
INSERT INTO public.clothing VALUES (3634, '0', 'Armani Exchange', 'Blazer', 'Black', 294, '4365681', 39.99, 100.00, NULL, NULL, 'с полоской с боку
ПОГ 46
дл 69
плечи 38
рукав 60', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-06 21:03:03.067167', NULL, 0.00);
INSERT INTO public.clothing VALUES (3445, 'L', 'Armani Exchange', 'Polo Shirt', 'White', 283, '4139350', 19.99, 50.00, NULL, 23, 'мал АЕ знак на груди полоска по воротнику
ПОГ 54
дл 70
плечи 48
', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-30 21:31:28.66321', NULL, 0.00);
INSERT INTO public.clothing VALUES (3375, '26', 'Armani Exchange', 'Jeans', 'Grey', 283, '0458099', 29.99, 75.00, NULL, 23, 'с полоской с боку
ПОТ 32-35
ПОБ  39-44
пос 21
дл 95

', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-27 05:30:16.636655', NULL, 0.00);
INSERT INTO public.clothing VALUES (2443, '0', 'Calvin Klein', 'Dress', 'Grey', 199, '652172', 7.93, 46.43, 107, 23, 'mid length

chest: 45
length: 112
hips: 45', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-07 23:46:24.420256', NULL, 0.00);
INSERT INTO public.clothing VALUES (909, 'XS', 'Levis', 'Windbreaker', 'Tan, Blue, Black', 56, '941616', 25.00, 60.00, 36, 23, 'chest: 55
length: 72
arm: 58/72', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:08.922199', NULL, 3.00);
INSERT INTO public.clothing VALUES (3510, '2', 'Armani Exchange', 'Blazer', 'Black', 287, '4365728', 39.99, 100.00, NULL, 23, 'с полоской с боку
ПОГ 47
дл 71
плечи 40
рукав 61', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-02 22:35:57.910709', NULL, NULL);
INSERT INTO public.clothing VALUES (3721, '7.5', 'Converce', 'Shoes', 'White', NULL, '??????', 14.00, 33.93, NULL, 23, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-22 06:35:53.682232', NULL, 0.00);
INSERT INTO public.clothing VALUES (145, 'XS', 'Calvin Klein', 'Dress Shirt', 'White', 17, '494675', 16.83, 47.14, 14, 23, 'Female
Split back

Chest: 47
Waist: 47
Length: 73
Arm: 61', true, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:54.953193', NULL, NULL);
INSERT INTO public.clothing VALUES (3283, 'M', 'Calvin Klein', 'Dress', 'Pink', 278, '402564', 19.99, 50.00, 116, 23, 'black stripe on shoulder
chest: 49
hips: 52
length: 92
', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-23 01:15:20.232013', NULL, NULL);
INSERT INTO public.clothing VALUES (185, 'M', 'Levis', 'Leather Jacket', 'Black', NULL, '516746', 34.99, 82.14, 72, 23, 'bomber

Chest: 53
Waist: 50
Length: 57
Arm: 64', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:07:55.294361', NULL, 0.00);
INSERT INTO public.clothing VALUES (1623, '27', 'Levis', 'Jeans', 'Navy', 56, '508525', 12.50, 58.93, 42, 23, 'Waist: 36
Hips: 41
Length: 101
Pasadka: 23', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:15.594796', NULL, NULL);
INSERT INTO public.clothing VALUES (999, 'XS', 'Tommy Hilfiger', 'Shorts', 'Navy', 76, '787137', 23.99, 35.00, NULL, 23, 'waist: 36
hips: 49
length: 30
pasadka: 25', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:09.79068', NULL, NULL);
INSERT INTO public.clothing VALUES (1401, 'L', 'Calvin Klein', 'T-Shirt', 'White', 127, '460908', 6.71, 28.21, NULL, 23, 'blue heart
v-neck', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:13.530859', NULL, NULL);
INSERT INTO public.clothing VALUES (1646, 'M', 'New Balance', 'Windbreaker', 'Black', 56, '163854', 13.00, 35.00, 43, 23, 'Stripe on arms

Chest: 51
Waist: 48
Length: 67
Arm:', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:15.800947', NULL, 4.09);
INSERT INTO public.clothing VALUES (3371, 'L', 'Armani Exchange', 'T-Shirt', 'White', 283, '0367636', 19.99, 27.30, 118, 9, 'розовая картинка
ПОГ  53
ДЛ 71

', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-27 05:25:22.864082', NULL, NULL);
INSERT INTO public.clothing VALUES (3372, 'L', 'Armani Exchange', 'T-Shirt', 'White', 283, '0367636', 19.99, 35.00, NULL, 23, 'розовая картинка
ПОГ  53
ДЛ 71

', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-27 05:25:28.950066', NULL, NULL);
INSERT INTO public.clothing VALUES (1204, 'M', 'Calvin Klein', 'T-Shirt', 'White', 105, '893233', 12.59, 30.36, NULL, 23, 'golden sign', true, NULL, NULL, NULL, NULL, 'ukraine', '2020-12-21 01:19:11.697916', NULL, NULL);
INSERT INTO public.clothing VALUES (2832, 'S', 'Calvin Klein', 'Dress Shirt', 'White', NULL, 'MOTAK561', 24.99, 42.86, 95, 23, 'с золотой молнией
ПОГ 49
длина 71
рукав 60', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 02:30:42.730098', NULL, 0.00);
INSERT INTO public.clothing VALUES (3330, 'M', 'Calvin Klein', 'Sport Bra', 'Black', 281, '454268', 6.99, 28.57, 117, 23, 'velurovie', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-27 04:10:25.39716', NULL, NULL);
INSERT INTO public.clothing VALUES (862, 'M', 'Calvin Klein', 'Panties', 'Black', 58, '351769', 3.40, 0.00, NULL, 23, NULL, NULL, 'women', NULL, NULL, NULL, 'usa', '2020-12-21 01:19:08.46318', NULL, 0.00);
INSERT INTO public.clothing VALUES (3335, 'M', 'Calvin Klein', 'Panties', 'Black', 281, '454411', 6.99, 21.43, 117, 23, 'velurovie', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-27 04:12:10.529198', NULL, NULL);
INSERT INTO public.clothing VALUES (2403, '7', 'Guess', 'Flip Flops', 'Black', 193, '930096', 14.99, 23.21, 116, 23, 'length: 24.5
burlington tag number', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-02-07 21:48:44.891322', NULL, 0.00);
INSERT INTO public.clothing VALUES (3404, 'L', 'Guess', 'Windbreaker', 'Black', 284, '459241', 39.99, 75.00, NULL, 23, 'с белой молнией
ПОГ 60
дл 70
рук 66
плечи 50', NULL, 'men', NULL, NULL, NULL, 'usa', '2021-03-29 04:21:56.37703', NULL, 0.00);
INSERT INTO public.clothing VALUES (2839, 'M', 'Calvin Klein', 'Dress', 'Pink', NULL, '117697', 20.00, 51.79, 97, 23, 'ПОГ 52
длина 87', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-03-04 03:02:43.408971', NULL, 0.00);
INSERT INTO public.clothing VALUES (3105, '7.5', 'Calvin Klein', 'Shoes', 'White', 235, 'CKS000', 25.99, 70.71, 107, 23, 'black CK
black stripe on back', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-03-13 03:44:16.258827', NULL, NULL);
INSERT INTO public.clothing VALUES (2199, 'L', 'DKNY', 'Coat', 'Black', 172, '264449', 44.99, 60.81, 68, 9, 'chest: 63
length: 93
arm: 68
shoulders: 53', NULL, 'men', NULL, NULL, NULL, 'ukraine', '2021-01-21 17:29:15.396024', NULL, 0.00);
INSERT INTO public.clothing VALUES (3614, 'M', 'Armani Exchange', 'Puffy Jacket', 'Black', 293, '0321478', 79.99, NULL, NULL, NULL, 'куртка с поясом маломерит
ПОГ 51
ПОБ 56
дл 88
рук 63
плечи  43
', NULL, 'women', NULL, NULL, NULL, 'ukraine', '2021-04-04 06:44:37.05262', NULL, 0.00);
INSERT INTO public.clothing VALUES (3627, '6', 'Armani Exchange', 'Blazer', 'Black', 294, '4365742', 39.99, 54.61, 124, 9, 'с полоской с боку', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-06 20:50:54.663886', NULL, 0.00);
INSERT INTO public.clothing VALUES (3628, '6', 'Armani Exchange', 'Blazer', 'Black', 294, '4365742', 39.99, 54.61, 124, 9, 'с полоской с боку', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-06 20:52:45.964622', NULL, 0.00);
INSERT INTO public.clothing VALUES (3485, '6', 'Armani Exchange', 'Blazer', 'Black', 287, '4365742', 39.99, 54.61, 124, 9, 'с полоской с боку', NULL, 'women', NULL, NULL, NULL, 'usa', '2021-04-02 21:26:22.045741', NULL, NULL);


--
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: arn
--

INSERT INTO public.customers VALUES (1, 'Alla', NULL, NULL, NULL, '', '2020-12-21 01:07:52.7772');
INSERT INTO public.customers VALUES (2, 'Other', NULL, NULL, NULL, '', '2020-12-21 01:07:52.787877');
INSERT INTO public.customers VALUES (3, 'December', NULL, NULL, NULL, '', '2020-12-21 01:07:52.801332');
INSERT INTO public.customers VALUES (4, 'catchall', 'none@email.com', NULL, NULL, NULL, '2020-12-21 01:08:37.11622');
INSERT INTO public.customers VALUES (5, 'Zhenya & Misha', 'holder@email.com', NULL, NULL, NULL, '2020-12-21 01:08:37.125225');
INSERT INTO public.customers VALUES (6, 'Alla', NULL, NULL, NULL, '', '2020-12-21 01:08:37.132725');
INSERT INTO public.customers VALUES (7, 'February', NULL, NULL, NULL, NULL, '2021-03-11 03:31:44.785543');
INSERT INTO public.customers VALUES (8, 'January 2021', NULL, NULL, NULL, NULL, '2021-03-17 19:20:57.438424');
INSERT INTO public.customers VALUES (9, 'February 2021', NULL, NULL, NULL, NULL, '2021-03-17 19:21:03.228447');
INSERT INTO public.customers VALUES (10, 'March 2021', NULL, NULL, NULL, NULL, '2021-03-17 19:21:08.463083');
INSERT INTO public.customers VALUES (11, 'April 2021', NULL, NULL, NULL, NULL, '2021-03-17 19:21:14.031364');
INSERT INTO public.customers VALUES (12, 'May 2021', NULL, NULL, NULL, NULL, '2021-03-17 19:21:21.761431');
INSERT INTO public.customers VALUES (13, 'June 2021', NULL, NULL, NULL, NULL, '2021-03-17 19:21:26.941548');
INSERT INTO public.customers VALUES (14, 'July 2021', NULL, NULL, NULL, NULL, '2021-03-17 19:21:41.874464');
INSERT INTO public.customers VALUES (15, 'August 2021', NULL, NULL, NULL, NULL, '2021-03-17 19:21:47.770821');
INSERT INTO public.customers VALUES (16, 'September 2021', NULL, NULL, NULL, NULL, '2021-03-17 19:21:54.25645');
INSERT INTO public.customers VALUES (17, 'October 2021', NULL, NULL, NULL, NULL, '2021-03-17 19:22:01.184717');
INSERT INTO public.customers VALUES (18, 'November 2021', NULL, NULL, NULL, NULL, '2021-03-17 19:22:09.562642');
INSERT INTO public.customers VALUES (19, 'December 2021', NULL, NULL, NULL, NULL, '2021-03-17 19:22:15.623332');


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: arn
--

INSERT INTO public.orders VALUES (1, NULL, 1, 'active', '2020-12-21 01:07:53.511985');
INSERT INTO public.orders VALUES (2, '2020-11-05', 2, 'active', '2020-12-21 01:07:53.521037');
INSERT INTO public.orders VALUES (9, '2020-12-20', 1, 'active', '2020-12-21 01:07:53.589239');
INSERT INTO public.orders VALUES (10, '2020-09-01', 4, 'active', '2020-12-21 01:13:29.391665');
INSERT INTO public.orders VALUES (11, NULL, 5, 'active', '2020-12-21 01:13:29.402399');
INSERT INTO public.orders VALUES (5, NULL, 1, 'active', '2020-12-21 01:07:53.556289');
INSERT INTO public.orders VALUES (6, NULL, 1, 'active', '2020-12-21 01:07:53.564675');
INSERT INTO public.orders VALUES (7, NULL, 1, 'active', '2020-12-21 01:07:53.573282');
INSERT INTO public.orders VALUES (8, NULL, 1, 'active', '2020-12-21 01:07:53.581365');
INSERT INTO public.orders VALUES (12, '2020-12-20', 6, 'active', '2020-12-21 01:13:29.411506');
INSERT INTO public.orders VALUES (13, '2020-12-04', 3, 'complete', '2020-12-27 08:25:05.133715');
INSERT INTO public.orders VALUES (4, '2020-12-03', 3, 'complete', '2020-12-21 01:07:53.547986');
INSERT INTO public.orders VALUES (3, '2020-12-02', 3, 'complete', '2020-12-21 01:07:53.535518');
INSERT INTO public.orders VALUES (14, '2020-12-05', 3, 'complete', '2020-12-27 09:24:19.830687');
INSERT INTO public.orders VALUES (15, '2020-12-07', 3, 'complete', '2020-12-27 09:43:48.340296');
INSERT INTO public.orders VALUES (16, '2020-12-08', 3, 'complete', '2020-12-27 10:07:26.483922');
INSERT INTO public.orders VALUES (17, '2020-12-09', 3, 'complete', '2020-12-27 10:21:32.653984');
INSERT INTO public.orders VALUES (18, '2020-12-10', 3, 'complete', '2020-12-27 10:35:09.652231');
INSERT INTO public.orders VALUES (19, '2021-02-01', 7, 'active', '2021-03-11 03:32:11.147262');
INSERT INTO public.orders VALUES (20, '2021-01-01', 8, 'active', '2021-03-17 19:23:01.115948');
INSERT INTO public.orders VALUES (21, '2021-02-01', 9, 'active', '2021-03-17 19:23:10.495731');
INSERT INTO public.orders VALUES (22, '2021-03-01', 10, 'active', '2021-03-17 19:23:26.259379');
INSERT INTO public.orders VALUES (23, '2021-04-01', 11, 'active', '2021-03-17 19:23:36.187103');
INSERT INTO public.orders VALUES (24, '2021-05-01', 12, 'active', '2021-03-17 19:23:45.100435');
INSERT INTO public.orders VALUES (25, '2021-06-01', 13, 'active', '2021-03-17 19:23:53.309023');
INSERT INTO public.orders VALUES (26, '2021-07-01', 14, 'active', '2021-03-17 19:24:01.787482');
INSERT INTO public.orders VALUES (27, '2021-08-01', 15, 'active', '2021-03-17 19:24:09.912249');
INSERT INTO public.orders VALUES (28, '2021-09-01', 16, 'active', '2021-03-17 19:24:17.357475');
INSERT INTO public.orders VALUES (29, '2021-10-01', 17, 'active', '2021-03-17 19:24:24.706527');
INSERT INTO public.orders VALUES (30, '2021-11-01', 18, 'active', '2021-03-17 19:24:33.777503');
INSERT INTO public.orders VALUES (31, '2021-12-01', 19, 'active', '2021-03-17 19:24:48.111444');


--
-- Data for Name: packages; Type: TABLE DATA; Schema: public; Owner: arn
--

INSERT INTO public.packages VALUES (1, 'usps 3.1', 0.00, '2020-10-30', NULL, '2020-12-21 01:07:53.239841', NULL);
INSERT INTO public.packages VALUES (2, 'usps 4.1', 0.00, '2020-10-30', NULL, '2020-12-21 01:07:53.247313', NULL);
INSERT INTO public.packages VALUES (4, 'Dnipro 1', 153.82, '2020-11-06', NULL, '2020-12-21 01:07:53.272994', NULL);
INSERT INTO public.packages VALUES (12, 'Alla 15', 0.00, '2020-11-28', NULL, '2020-12-21 01:07:53.333278', NULL);
INSERT INTO public.packages VALUES (13, 'Alla 16', 0.00, '2020-11-29', NULL, '2020-12-21 01:07:53.341196', NULL);
INSERT INTO public.packages VALUES (14, 'USPS 19', 0.00, '2020-11-30', NULL, '2020-12-21 01:07:53.347728', NULL);
INSERT INTO public.packages VALUES (15, 'USPS 20', 0.00, '2020-11-30', NULL, '2020-12-21 01:07:53.355176', NULL);
INSERT INTO public.packages VALUES (16, 'USPS 21', 0.00, '2020-11-29', NULL, '2020-12-21 01:07:53.362671', NULL);
INSERT INTO public.packages VALUES (21, 'USPS 5.1', 45.67, '2020-12-01', NULL, '2020-12-21 01:07:53.399416', NULL);
INSERT INTO public.packages VALUES (22, 'USPS 6.1', 41.89, '2020-12-01', NULL, '2020-12-21 01:07:53.407123', NULL);
INSERT INTO public.packages VALUES (23, 'USPS 7.1', 45.36, '2020-12-01', NULL, '2020-12-21 01:07:53.413723', NULL);
INSERT INTO public.packages VALUES (24, 'USPS 8.1', 42.21, '2020-12-01', NULL, '2020-12-21 01:07:53.421056', NULL);
INSERT INTO public.packages VALUES (25, 'USPS 10', 40.95, '2020-12-01', NULL, '2020-12-21 01:07:53.42867', NULL);
INSERT INTO public.packages VALUES (26, 'USPS 14', 41.89, '2020-12-01', NULL, '2020-12-21 01:07:53.435941', NULL);
INSERT INTO public.packages VALUES (28, 'USPS 11', 45.04, '2020-12-01', NULL, '2020-12-21 01:07:53.449582', NULL);
INSERT INTO public.packages VALUES (29, 'USPS 12', 0.00, '2020-12-01', NULL, '2020-12-21 01:07:53.45787', NULL);
INSERT INTO public.packages VALUES (30, 'USPS 22', 0.00, '2020-12-03', NULL, '2020-12-21 01:07:53.465089', NULL);
INSERT INTO public.packages VALUES (31, 'Alla 17', 0.00, NULL, NULL, '2020-12-21 01:07:53.472959', NULL);
INSERT INTO public.packages VALUES (32, 'Alla 18', 0.00, NULL, NULL, '2020-12-21 01:07:53.480161', NULL);
INSERT INTO public.packages VALUES (34, 'on flight orders', 0.00, NULL, NULL, '2020-12-21 01:07:53.49505', NULL);
INSERT INTO public.packages VALUES (36, '31 DNIPRO', 0.00, '2020-08-14', NULL, '2020-12-21 01:09:14.23391', NULL);
INSERT INTO public.packages VALUES (37, '36', 0.00, '2020-08-20', NULL, '2020-12-21 01:09:14.243772', NULL);
INSERT INTO public.packages VALUES (38, '34', 0.00, '2020-08-15', NULL, '2020-12-21 01:09:14.251758', NULL);
INSERT INTO public.packages VALUES (39, '35', 0.00, '2020-08-15', NULL, '2020-12-21 01:09:14.260118', NULL);
INSERT INTO public.packages VALUES (40, 'To Be Shipped', 0.00, NULL, NULL, '2020-12-21 01:09:14.267752', NULL);
INSERT INTO public.packages VALUES (41, 'Dnipro 40', 0.00, '2020-08-24', NULL, '2020-12-21 01:09:14.275177', NULL);
INSERT INTO public.packages VALUES (42, 'TBD Dnipro Air', 0.00, NULL, NULL, '2020-12-21 01:09:14.282765', NULL);
INSERT INTO public.packages VALUES (43, 'USPS package 1', 49.14, NULL, NULL, '2020-12-21 01:09:14.290121', NULL);
INSERT INTO public.packages VALUES (44, 'dnipro tba2', 0.00, NULL, NULL, '2020-12-21 01:09:14.297541', NULL);
INSERT INTO public.packages VALUES (45, 'USPS package 2', 46.30, NULL, NULL, '2020-12-21 01:09:14.304887', NULL);
INSERT INTO public.packages VALUES (46, 'ZhenyaMisha', 96.82, NULL, NULL, '2020-12-21 01:09:14.312695', NULL);
INSERT INTO public.packages VALUES (47, 'USPS package 3', 0.00, NULL, NULL, '2020-12-21 01:09:14.320115', NULL);
INSERT INTO public.packages VALUES (48, 'usps with dkny', 0.00, '2020-10-07', NULL, '2020-12-21 01:09:14.328058', NULL);
INSERT INTO public.packages VALUES (49, 'usps sweats + wallets', 0.00, '2020-10-14', NULL, '2020-12-21 01:09:14.335411', NULL);
INSERT INTO public.packages VALUES (50, 'USPS CK jean jacket', 0.00, '2020-10-16', NULL, '2020-12-21 01:09:14.343179', NULL);
INSERT INTO public.packages VALUES (51, 'usps 3.1', 0.00, '2020-10-30', NULL, '2020-12-21 01:09:14.350585', NULL);
INSERT INTO public.packages VALUES (52, 'Alla 3', 0.00, '2020-12-20', NULL, '2020-12-21 01:09:14.358366', NULL);
INSERT INTO public.packages VALUES (53, 'Alla 4', 0.00, '2020-12-23', NULL, '2020-12-23 07:09:48.551686', NULL);
INSERT INTO public.packages VALUES (54, 'alla 5', 0.00, '2020-12-25', NULL, '2020-12-25 07:18:50.339734', NULL);
INSERT INTO public.packages VALUES (10, 'Dnipro 2', 75.00, NULL, NULL, '2020-12-21 01:07:53.318452', NULL);
INSERT INTO public.packages VALUES (55, 'Alla 6', 0.00, '2020-12-29', NULL, '2020-12-29 01:10:36.393213', NULL);
INSERT INTO public.packages VALUES (56, 'Alla 2021 1', 0.00, '2021-01-08', NULL, '2021-01-08 13:40:51.002971', NULL);
INSERT INTO public.packages VALUES (7, 'Zhenya Misha 7', 150.00, '2020-11-21', NULL, '2020-12-21 01:07:53.29577', NULL);
INSERT INTO public.packages VALUES (8, 'USPS 17', 41.89, '2020-11-23', NULL, '2020-12-21 01:07:53.303089', NULL);
INSERT INTO public.packages VALUES (59, 'usps 1 2021', 40.95, '2021-01-10', NULL, '2021-01-17 18:55:34.01657', NULL);
INSERT INTO public.packages VALUES (61, 'USPS Alla 2 2021', 44.41, '2021-01-17', NULL, '2021-01-17 19:04:23.894934', NULL);
INSERT INTO public.packages VALUES (62, 'usps 2 2021', 49.45, '2021-01-17', NULL, '2021-01-17 19:07:36.600329', NULL);
INSERT INTO public.packages VALUES (64, 'Alla 19', 0.00, '2021-01-19', NULL, '2021-01-19 12:47:17.369361', NULL);
INSERT INTO public.packages VALUES (60, 'Dnipro 1 2021', 108.00, '2021-01-17', NULL, '2021-01-17 19:00:26.432837', NULL);
INSERT INTO public.packages VALUES (67, 'Alla 20', 0.00, '2021-01-24', NULL, '2021-01-23 19:25:02.159415', NULL);
INSERT INTO public.packages VALUES (68, 'Alla 21', 0.00, '2021-01-25', NULL, '2021-01-23 20:19:04.961467', NULL);
INSERT INTO public.packages VALUES (6, 'Dnipro 6 By Sea', 86.30, '2020-11-19', NULL, '2020-12-21 01:07:53.288019', NULL);
INSERT INTO public.packages VALUES (75, 'USPS 4 2021', 51.03, '2021-01-26', NULL, '2021-02-02 23:05:17.513861', NULL);
INSERT INTO public.packages VALUES (27, 'USPS 9 2020', 43.15, '2020-12-01', NULL, '2020-12-21 01:07:53.443176', NULL);
INSERT INTO public.packages VALUES (33, 'Dnipro 13', 160.10, '2020-12-07', NULL, '2020-12-21 01:07:53.487796', NULL);
INSERT INTO public.packages VALUES (18, 'Dnipro 10 Kids + Misha', 94.53, '2020-12-01', NULL, '2020-12-21 01:07:53.377281', NULL);
INSERT INTO public.packages VALUES (79, 'USPS Alla 3 2021', 0.00, '2021-02-06', NULL, '2021-02-09 19:45:14.922657', NULL);
INSERT INTO public.packages VALUES (80, 'USPS Alla 4 2021', 0.00, '2021-02-03', NULL, '2021-02-09 19:51:23.506028', NULL);
INSERT INTO public.packages VALUES (82, 'Alla 22', 0.00, '2021-02-12', NULL, '2021-02-12 02:40:40.015775', NULL);
INSERT INTO public.packages VALUES (89, 'Alla 23 Dnipro', 0.00, '2021-03-01', NULL, '2021-02-27 21:31:09.731547', NULL);
INSERT INTO public.packages VALUES (86, 'Delete', 0.00, '2021-02-22', NULL, '2021-02-22 20:09:22.800884', NULL);
INSERT INTO public.packages VALUES (90, 'Alla Winter', 0.00, '2021-03-01', NULL, '2021-02-27 21:37:40.517428', NULL);
INSERT INTO public.packages VALUES (91, 'Alla 24 Dnipro', 0.00, '2021-03-01', NULL, '2021-02-27 21:47:38.122478', NULL);
INSERT INTO public.packages VALUES (92, 'Alla 5 USPS', 0.00, '2021-03-01', NULL, '2021-03-01 01:23:53.807978', NULL);
INSERT INTO public.packages VALUES (85, 'USPS 11 2021', 46.62, '2021-02-19', NULL, '2021-02-22 06:12:13.798916', 'CV946182023US');
INSERT INTO public.packages VALUES (94, 'Alla 25 Dnipro', 0.00, '2021-03-01', NULL, '2021-03-01 06:30:24.427395', NULL);
INSERT INTO public.packages VALUES (97, 'Alla 6 USPS', 0.00, '2021-03-06', NULL, '2021-03-06 21:12:12.464671', NULL);
INSERT INTO public.packages VALUES (98, 'Alla 26 Dnipro by air', 0.00, '2021-03-08', NULL, '2021-03-07 22:10:04.758253', NULL);
INSERT INTO public.packages VALUES (57, 'Dnipro 2 2021', 169.10, '2021-01-16', NULL, '2021-01-16 14:48:46.420635', NULL);
INSERT INTO public.packages VALUES (63, 'Dnipro 3 2021', 157.27, '2021-01-18', NULL, '2021-01-18 15:30:45.257425', NULL);
INSERT INTO public.packages VALUES (65, 'Dnipro 4 2021', 159.09, '2021-01-22', NULL, '2021-01-22 11:36:23.375985', NULL);
INSERT INTO public.packages VALUES (69, 'Dnipro 5 2021', 173.64, '2021-01-18', NULL, '2021-01-23 21:15:29.923941', NULL);
INSERT INTO public.packages VALUES (71, 'Dnipro 6 2021', 95.35, '2021-01-27', NULL, '2021-01-27 15:17:00.567442', NULL);
INSERT INTO public.packages VALUES (72, 'Dnipro 7 By Sea 2021', 109.39, '2021-01-27', NULL, '2021-01-27 15:58:18.979294', NULL);
INSERT INTO public.packages VALUES (74, 'Dnipro 8 2021', 170.11, '2021-02-02', NULL, '2021-01-31 18:24:27.487895', NULL);
INSERT INTO public.packages VALUES (76, 'Dnipro 9', 96.06, '2021-02-08', NULL, '2021-02-08 22:54:52.250851', NULL);
INSERT INTO public.packages VALUES (81, 'Dnipro 10 2021', 159.33, '2021-02-12', NULL, '2021-02-12 01:34:29.910726', NULL);
INSERT INTO public.packages VALUES (84, 'Dnipro 11 2021', 149.72, '2021-02-17', NULL, '2021-02-18 00:47:59.860444', NULL);
INSERT INTO public.packages VALUES (88, 'Dnipro 12 2021', 100.89, '2021-02-25', NULL, '2021-02-26 00:01:57.026169', NULL);
INSERT INTO public.packages VALUES (58, 'usps 3 2021', 49.14, '2021-01-16', NULL, '2021-01-16 15:52:32.272346', NULL);
INSERT INTO public.packages VALUES (66, 'USPS 5 2021', 46.30, '2021-01-22', NULL, '2021-01-22 12:37:54.257278', NULL);
INSERT INTO public.packages VALUES (70, 'USPS 6 2021', 43.15, '2021-01-26', NULL, '2021-01-26 16:12:12.472901', NULL);
INSERT INTO public.packages VALUES (73, 'USPS 7 2021', 42.21, '2021-01-29', NULL, '2021-01-29 11:25:52.306414', NULL);
INSERT INTO public.packages VALUES (78, 'USPS 8 2021', 45.99, '2021-02-02', NULL, '2021-02-09 19:30:39.480455', NULL);
INSERT INTO public.packages VALUES (77, 'USPS  9 2021', 47.88, '2021-02-08', NULL, '2021-02-08 23:25:48.153008', NULL);
INSERT INTO public.packages VALUES (83, 'USPS 10 2021', 48.19, '2021-02-15', NULL, '2021-02-15 19:54:21.784251', NULL);
INSERT INTO public.packages VALUES (108, 'Mom to Alla', 0.00, '2021-03-18', NULL, '2021-03-19 00:33:22.240386', NULL);
INSERT INTO public.packages VALUES (87, 'USPS 13 2021', 45.96, '2021-02-25', NULL, '2021-02-25 23:52:55.316399', NULL);
INSERT INTO public.packages VALUES (93, 'USPS 14 2021', 46.62, '2021-03-01', NULL, '2021-03-01 01:36:59.265695', NULL);
INSERT INTO public.packages VALUES (100, 'USPS 12 2021', 43.47, '2021-03-03', NULL, '2021-03-09 20:53:37.648942', NULL);
INSERT INTO public.packages VALUES (99, 'Dnipro 14 2021', 108.52, '2021-03-08', NULL, '2021-03-07 23:25:21.965124', NULL);
INSERT INTO public.packages VALUES (19, 'Dnipro 11', 150.67, '2020-12-02', NULL, '2020-12-21 01:07:53.384676', NULL);
INSERT INTO public.packages VALUES (11, 'Dnipro 3', 81.35, NULL, NULL, '2020-12-21 01:07:53.326106', NULL);
INSERT INTO public.packages VALUES (5, 'Dnipro 5', 95.00, '2020-11-17', NULL, '2020-12-21 01:07:53.280431', NULL);
INSERT INTO public.packages VALUES (9, 'Dnipro 8', 157.00, '2020-11-24', '2020-12-22', '2020-12-21 01:07:53.310793', NULL);
INSERT INTO public.packages VALUES (17, 'Dnipro 9', 78.22, '2020-12-01', NULL, '2020-12-21 01:07:53.370721', NULL);
INSERT INTO public.packages VALUES (20, 'Dnipro 12', 82.03, '2020-12-02', NULL, '2020-12-21 01:07:53.392091', NULL);
INSERT INTO public.packages VALUES (102, 'Dnipro 16 2021', 178.38, '2021-03-15', NULL, '2021-03-15 03:19:52.216397', NULL);
INSERT INTO public.packages VALUES (115, 'Dnipro 18 2021', 0.00, '2021-03-23', NULL, '2021-03-24 00:01:15.731527', NULL);
INSERT INTO public.packages VALUES (110, 'Alla 8 USPS', 0.00, '2021-03-22', NULL, '2021-03-23 19:23:19.677427', NULL);
INSERT INTO public.packages VALUES (107, 'Dnipro 17 2021', 96.15, '2021-03-18', NULL, '2021-03-18 23:00:21.351802', 'Tags inside bag with tissue paper');
INSERT INTO public.packages VALUES (112, 'Alla shared D9', NULL, '2021-03-23', NULL, '2021-03-23 21:08:05.911211', NULL);
INSERT INTO public.packages VALUES (103, 'Alla 7 USPS', 48.19, '2021-03-15', NULL, '2021-03-15 22:35:49.613951', 'CV946238870US dostavka: $48.19  total: $48.19 + $221.17 = 269.36');
INSERT INTO public.packages VALUES (109, 'Alla 27 Dinpro By Sea', 0.00, '2021-03-23', NULL, '2021-03-23 00:24:11.009993', NULL);
INSERT INTO public.packages VALUES (116, 'USPS 20 2021', 0.00, '2021-03-25', NULL, '2021-03-25 04:06:39.082586', NULL);
INSERT INTO public.packages VALUES (111, 'USPS 19', 49.07, '2021-03-22', NULL, '2021-03-23 19:35:58.832907', NULL);
INSERT INTO public.packages VALUES (105, 'Dnipro 13 2021', 156.53, '2021-03-15', NULL, '2021-03-15 22:54:41.698045', NULL);
INSERT INTO public.packages VALUES (104, 'USPS 17 2021', 45.67, '2021-03-15', NULL, '2021-03-15 22:44:34.016079', 'Tags from Dnipro 13 & 15');
INSERT INTO public.packages VALUES (101, 'Dnipro 15 2021', 108.25, '2021-03-10', NULL, '2021-03-11 03:16:01.256639', 'CV016115479US');
INSERT INTO public.packages VALUES (96, 'USPS 16 2021', 47.25, '2021-03-06', NULL, '2021-03-06 21:00:52.916764', NULL);
INSERT INTO public.packages VALUES (95, 'USPS 15 2021', 45.99, '2021-03-06', NULL, '2021-03-06 20:48:46.380381', NULL);
INSERT INTO public.packages VALUES (117, 'Dnipro 19 2021', 0.00, '2021-03-29', NULL, '2021-03-29 03:12:25.266198', NULL);
INSERT INTO public.packages VALUES (118, 'Alla 28 by sea', NULL, '2021-03-29', NULL, '2021-03-30 02:36:01.995378', NULL);
INSERT INTO public.packages VALUES (119, 'Nastya Jenia 2', NULL, '2021-03-29', NULL, '2021-03-30 03:27:35.261164', NULL);
INSERT INTO public.packages VALUES (121, 'Dnipro 20 2021', 0.00, '2021-04-01', NULL, '2021-04-01 02:29:13.695295', NULL);
INSERT INTO public.packages VALUES (122, 'Alla Shared D10', 0.00, '2021-04-07', NULL, '2021-04-08 04:14:24.584313', NULL);
INSERT INTO public.packages VALUES (113, 'delete this', 0.00, '2021-03-23', NULL, '2021-03-23 22:48:06.990653', NULL);
INSERT INTO public.packages VALUES (123, 'Alla Shared Syitcase', NULL, '2021-04-11', NULL, '2021-04-08 06:00:40.664536', NULL);
INSERT INTO public.packages VALUES (124, 'Alla suitcase', NULL, '2021-04-11', NULL, '2021-04-08 06:43:36.234286', NULL);
INSERT INTO public.packages VALUES (125, 'Alla 30 by Air', NULL, '2021-04-08', NULL, '2021-04-08 07:14:42.666371', NULL);
INSERT INTO public.packages VALUES (120, 'Alla 29 Dnipro By Sea', 0.00, '2021-03-31', NULL, '2021-04-01 00:24:43.883761', NULL);
INSERT INTO public.packages VALUES (126, 'USPS Nastia Jenia 1', 0.00, '2021-04-09', NULL, '2021-04-09 02:44:08.517481', NULL);
INSERT INTO public.packages VALUES (127, 'Dnipro 21 2021', 0.00, '2021-04-09', NULL, '2021-04-09 03:09:09.935341', NULL);
INSERT INTO public.packages VALUES (106, 'USPS 18 2021', 32.69, '2021-03-16', NULL, '2021-03-16 22:44:36.0521', NULL);
INSERT INTO public.packages VALUES (128, 'Sent to Alla April', NULL, '2021-04-02', NULL, '2021-04-17 15:09:27.165634', NULL);
INSERT INTO public.packages VALUES (129, 'Nastia Jenia Nova Poshta April', NULL, '2021-04-19', NULL, '2021-04-18 11:03:56.669082', NULL);
INSERT INTO public.packages VALUES (114, 'Nastia Zhenya Dnipro 1', 117.03, '2021-03-23', NULL, '2021-03-23 23:16:03.09115', NULL);


--
-- Data for Name: receipts; Type: TABLE DATA; Schema: public; Owner: arn
--

INSERT INTO public.receipts VALUES (1, 'Ross', 7.75, '2020-10-24', '2020-12-21 01:07:52.814602');
INSERT INTO public.receipts VALUES (2, 'Burlington', 7.75, '2020-10-24', '2020-12-21 01:07:52.822188');
INSERT INTO public.receipts VALUES (3, 'Burlington', 7.75, '2020-10-24', '2020-12-21 01:07:52.834862');
INSERT INTO public.receipts VALUES (4, 'Burlington', 7.75, '2020-10-25', '2020-12-21 01:07:52.848425');
INSERT INTO public.receipts VALUES (5, 'TJ Maxx', 8.25, '2020-10-25', '2020-12-21 01:07:52.855848');
INSERT INTO public.receipts VALUES (6, 'Ross', 9.25, '2020-10-23', '2020-12-21 01:07:52.863012');
INSERT INTO public.receipts VALUES (7, 'Macys', 7.75, '2020-10-25', '2020-12-21 01:07:52.87088');
INSERT INTO public.receipts VALUES (8, 'Tommy Hilfiger', 8.13, '2020-10-26', '2020-12-21 01:07:52.878789');
INSERT INTO public.receipts VALUES (9, 'Calvin Klein', 7.75, '2020-10-24', '2020-12-21 01:07:52.886255');
INSERT INTO public.receipts VALUES (10, 'Burlington', 9.00, '2020-11-02', '2020-12-21 01:07:52.893388');
INSERT INTO public.receipts VALUES (11, 'Tommy Hilfiger', 9.00, '2020-11-02', '2020-12-21 01:07:52.900985');
INSERT INTO public.receipts VALUES (12, 'Tommy Hilfiger', 7.75, '2020-11-01', '2020-12-21 01:07:52.907959');
INSERT INTO public.receipts VALUES (13, 'Tommy Hilfiger', 9.25, '2020-11-02', '2020-12-21 01:07:52.91563');
INSERT INTO public.receipts VALUES (14, 'Calvin Klein', 8.13, '2020-11-02', '2020-12-21 01:07:52.922396');
INSERT INTO public.receipts VALUES (15, 'Calvin Klein', 8.13, '2020-10-26', '2020-12-21 01:07:52.929845');
INSERT INTO public.receipts VALUES (16, 'Calvin Klein', 9.25, '2020-11-02', '2020-12-21 01:07:52.937051');
INSERT INTO public.receipts VALUES (17, 'Calvin Klein', 8.13, '2020-11-05', '2020-12-21 01:07:52.945397');
INSERT INTO public.receipts VALUES (18, 'Tommy Hilfiger', 8.13, '2020-11-05', '2020-12-21 01:07:52.952482');
INSERT INTO public.receipts VALUES (19, 'Wilsons Leather', 9.00, '2020-11-02', '2020-12-21 01:07:52.959539');
INSERT INTO public.receipts VALUES (20, 'Tommy Hilfiger', 8.13, '2020-11-08', '2020-12-21 01:07:52.96707');
INSERT INTO public.receipts VALUES (21, 'Calvin Klein', 8.13, '2020-11-09', '2020-12-21 01:07:52.973995');
INSERT INTO public.receipts VALUES (22, 'Wilsons Leather', 9.25, '2020-11-02', '2020-12-21 01:07:52.981551');
INSERT INTO public.receipts VALUES (23, 'Tommy Hilfiger', 8.13, '2020-11-13', '2020-12-21 01:07:52.988509');
INSERT INTO public.receipts VALUES (24, 'Calvin Klein', 8.13, '2020-11-13', '2020-12-21 01:07:52.995287');
INSERT INTO public.receipts VALUES (25, 'Tommy Hilfiger', 8.13, '2020-11-15', '2020-12-21 01:07:53.002737');
INSERT INTO public.receipts VALUES (26, 'Calvin Klein', 9.00, '2020-11-14', '2020-12-21 01:07:53.009797');
INSERT INTO public.receipts VALUES (27, 'Calvin Klein', 8.13, '2020-11-20', '2020-12-21 01:07:53.017423');
INSERT INTO public.receipts VALUES (28, 'Calvin Klein', 8.13, '2020-11-20', '2020-12-21 01:07:53.024487');
INSERT INTO public.receipts VALUES (29, 'Calvin Klein', 8.13, '2020-11-21', '2020-12-21 01:07:53.032192');
INSERT INTO public.receipts VALUES (30, 'Marshalls', 8.00, '2020-11-22', '2020-12-21 01:07:53.039328');
INSERT INTO public.receipts VALUES (31, 'Tommy Hilfiger', 9.00, '2020-11-14', '2020-12-21 01:07:53.046642');
INSERT INTO public.receipts VALUES (32, 'Armani Exchange', 9.25, '2020-11-27', '2020-12-21 01:07:53.053844');
INSERT INTO public.receipts VALUES (33, 'Armani Exchange', 9.25, '2020-11-27', '2020-12-21 01:07:53.061042');
INSERT INTO public.receipts VALUES (34, 'Calvin Klein', 7.75, '2020-11-27', '2020-12-21 01:07:53.068349');
INSERT INTO public.receipts VALUES (35, 'Levis', 8.13, '2020-11-20', '2020-12-21 01:07:53.075342');
INSERT INTO public.receipts VALUES (36, 'Calvin Klein', 8.13, '2020-11-24', '2020-12-21 01:07:53.082642');
INSERT INTO public.receipts VALUES (37, 'Calvin Klein', 9.25, '2020-11-27', '2020-12-21 01:07:53.089832');
INSERT INTO public.receipts VALUES (38, 'Calvin Klein', 8.13, '2020-11-29', '2020-12-21 01:07:53.096834');
INSERT INTO public.receipts VALUES (39, 'Levis', 8.13, '2020-11-29', '2020-12-21 01:07:53.104039');
INSERT INTO public.receipts VALUES (40, 'Tommy Hilfiger - Alla', 8.13, '2020-12-04', '2020-12-21 01:07:53.111469');
INSERT INTO public.receipts VALUES (41, 'Tommy Hilfiger - Alla', 8.13, '2020-12-04', '2020-12-21 01:07:53.119052');
INSERT INTO public.receipts VALUES (42, 'Tommy Hilfiger', 9.25, '2020-12-04', '2020-12-21 01:07:53.126114');
INSERT INTO public.receipts VALUES (43, 'Armani Exchange', 9.25, '2020-12-05', '2020-12-21 01:07:53.133759');
INSERT INTO public.receipts VALUES (44, 'Tommy Hilfiger', 8.13, '2020-12-04', '2020-12-21 01:07:53.141677');
INSERT INTO public.receipts VALUES (45, 'Tommy Hilfiger', 8.25, '2020-12-05', '2020-12-21 01:07:53.149179');
INSERT INTO public.receipts VALUES (46, 'Tommy Hilfiger', 8.13, '2020-12-05', '2020-12-21 01:07:53.156661');
INSERT INTO public.receipts VALUES (47, 'Tommy Hilfiger', 8.13, '2020-12-03', '2020-12-21 01:07:53.163739');
INSERT INTO public.receipts VALUES (48, 'Tommy Hilfiger', 8.25, '2020-12-05', '2020-12-21 01:07:53.171206');
INSERT INTO public.receipts VALUES (49, 'Tommy Hilfiger', 8.13, '2020-12-08', '2020-12-21 01:07:53.178322');
INSERT INTO public.receipts VALUES (50, 'Tommy Hilfiger', 7.75, '2020-12-08', '2020-12-21 01:07:53.186721');
INSERT INTO public.receipts VALUES (51, 'Calvin Klein', 8.13, '2020-12-08', '2020-12-21 01:07:53.19384');
INSERT INTO public.receipts VALUES (52, 'Calvin Klein', 7.75, '2020-12-08', '2020-12-21 01:07:53.201806');
INSERT INTO public.receipts VALUES (53, 'Calvin Klein', 7.75, '2020-12-10', '2020-12-21 01:07:53.208912');
INSERT INTO public.receipts VALUES (54, 'Calvin Klein', 8.13, '2020-12-12', '2020-12-21 01:07:53.21657');
INSERT INTO public.receipts VALUES (55, 'Tommy Hilfiger', 8.13, '2020-12-12', '2020-12-21 01:07:53.224195');
INSERT INTO public.receipts VALUES (56, 'Michael Kors', 8.00, '2020-12-08', '2020-12-21 01:07:53.231776');
INSERT INTO public.receipts VALUES (57, 'Armani Exchange', 9.25, '2020-08-13', '2020-12-21 01:11:09.712443');
INSERT INTO public.receipts VALUES (58, 'Calvin Klein', 9.25, '2020-08-13', '2020-12-21 01:11:09.722596');
INSERT INTO public.receipts VALUES (59, 'Calvin Klein', 9.25, '2020-08-13', '2020-12-21 01:11:09.730194');
INSERT INTO public.receipts VALUES (60, 'Armani Exchange', 9.25, '2020-08-07', '2020-12-21 01:11:09.73705');
INSERT INTO public.receipts VALUES (61, 'Tommy Hilfiger', 8.25, '2020-08-06', '2020-12-21 01:11:09.745024');
INSERT INTO public.receipts VALUES (62, 'Tommy Hilfiger', 7.75, '2020-08-06', '2020-12-21 01:11:09.753403');
INSERT INTO public.receipts VALUES (63, 'Levis', 9.00, '2020-06-18', '2020-12-21 01:11:09.760638');
INSERT INTO public.receipts VALUES (64, 'Calvin Klein', 7.75, '2020-08-16', '2020-12-21 01:11:09.768509');
INSERT INTO public.receipts VALUES (65, 'Tommy Hilfiger', 7.75, '2020-08-16', '2020-12-21 01:11:09.776026');
INSERT INTO public.receipts VALUES (66, 'Tommy Hilfiger', 8.13, '2020-08-17', '2020-12-21 01:11:09.783799');
INSERT INTO public.receipts VALUES (67, 'Ross', 8.13, '2020-08-17', '2020-12-21 01:11:09.791037');
INSERT INTO public.receipts VALUES (68, 'Burlington', 8.13, '2020-08-17', '2020-12-21 01:11:09.798352');
INSERT INTO public.receipts VALUES (69, 'Calvin Klein', 8.13, '2020-08-17', '2020-12-21 01:11:09.805607');
INSERT INTO public.receipts VALUES (70, 'Calvin Klein', 8.13, '2020-06-09', '2020-12-21 01:11:09.812917');
INSERT INTO public.receipts VALUES (71, 'Tommy Hilfiger', 8.13, '2020-06-13', '2020-12-21 01:11:09.820372');
INSERT INTO public.receipts VALUES (72, 'Tommy Hilfiger', 7.75, '2020-07-06', '2020-12-21 01:11:09.827521');
INSERT INTO public.receipts VALUES (73, 'Tommy Hilfiger', 8.13, '2020-07-13', '2020-12-21 01:11:09.834852');
INSERT INTO public.receipts VALUES (74, 'Tommy Hilfiger', 7.75, '2020-07-21', '2020-12-21 01:11:09.841864');
INSERT INTO public.receipts VALUES (75, 'Tommy Hilfiger', 8.13, '2020-07-25', '2020-12-21 01:11:09.849435');
INSERT INTO public.receipts VALUES (76, 'Tommy Hilfiger', 9.00, '2020-06-18', '2020-12-21 01:11:09.856567');
INSERT INTO public.receipts VALUES (77, 'Tommy Hilfiger', 7.75, '2020-06-06', '2020-12-21 01:11:09.863791');
INSERT INTO public.receipts VALUES (78, 'Tommy Hilfiger', 7.75, '2020-06-14', '2020-12-21 01:11:09.871954');
INSERT INTO public.receipts VALUES (79, 'Tommy Hilfiger', 8.13, '2020-07-08', '2020-12-21 01:11:09.879185');
INSERT INTO public.receipts VALUES (80, 'Tommy Hilfiger', 8.13, '2020-06-07', '2020-12-21 01:11:09.886383');
INSERT INTO public.receipts VALUES (81, 'Tommy Hilfiger', 7.75, '2020-06-14', '2020-12-21 01:11:09.893358');
INSERT INTO public.receipts VALUES (82, 'Tommy Hilfiger', 9.00, '2020-06-19', '2020-12-21 01:11:09.900652');
INSERT INTO public.receipts VALUES (83, 'Tommy Hilfiger', 7.75, '2020-06-12', '2020-12-21 01:11:09.908034');
INSERT INTO public.receipts VALUES (84, 'Calvin Klein', 8.13, '2020-06-08', '2020-12-21 01:11:09.915827');
INSERT INTO public.receipts VALUES (85, 'Calvin Klein', 7.75, '2020-06-14', '2020-12-21 01:11:09.923053');
INSERT INTO public.receipts VALUES (86, 'Calvin Klein', 8.13, '2020-06-07', '2020-12-21 01:11:09.930034');
INSERT INTO public.receipts VALUES (87, 'Calvin Klein', 7.75, '2020-06-12', '2020-12-21 01:11:09.937416');
INSERT INTO public.receipts VALUES (88, 'Calvin Klein', 7.75, '2020-06-06', '2020-12-21 01:11:09.944413');
INSERT INTO public.receipts VALUES (89, 'Calvin Klein', 8.13, '2020-06-08', '2020-12-21 01:11:09.952075');
INSERT INTO public.receipts VALUES (90, 'Calvin Klein', 8.13, '2020-07-23', '2020-12-21 01:11:09.959159');
INSERT INTO public.receipts VALUES (91, 'Calvin Klein', 8.13, '2020-07-03', '2020-12-21 01:11:09.966637');
INSERT INTO public.receipts VALUES (92, 'Calvin Klein', 8.13, '2020-07-13', '2020-12-21 01:11:09.973781');
INSERT INTO public.receipts VALUES (93, 'Calvin Klein', 8.13, '2020-06-28', '2020-12-21 01:11:09.980811');
INSERT INTO public.receipts VALUES (95, 'Calvin Klein', 7.75, '2020-07-21', '2020-12-21 01:11:09.995246');
INSERT INTO public.receipts VALUES (96, 'Calvin Klein', 8.13, '2020-07-22', '2020-12-21 01:11:10.002469');
INSERT INTO public.receipts VALUES (97, 'Calvin Klein', 7.75, '2020-07-06', '2020-12-21 01:11:10.009546');
INSERT INTO public.receipts VALUES (98, 'Calvin Klein', 8.13, '2020-06-16', '2020-12-21 01:11:10.017473');
INSERT INTO public.receipts VALUES (99, 'Calvin Klein', 9.25, '2020-08-05', '2020-12-21 01:11:10.024351');
INSERT INTO public.receipts VALUES (100, 'Calvin Klein', 8.13, '2020-06-07', '2020-12-21 01:11:10.031318');
INSERT INTO public.receipts VALUES (101, 'Calvin Klein', 8.13, '2020-06-13', '2020-12-21 01:11:10.038468');
INSERT INTO public.receipts VALUES (102, 'Calvin Klein', 7.75, '2020-07-26', '2020-12-21 01:11:10.045743');
INSERT INTO public.receipts VALUES (103, 'Calvin Klein', 8.13, '2020-07-03', '2020-12-21 01:11:10.053923');
INSERT INTO public.receipts VALUES (104, 'Calvin Klein', 8.13, '2020-07-22', '2020-12-21 01:11:10.061591');
INSERT INTO public.receipts VALUES (105, 'Calvin Klein', 8.13, '2020-06-28', '2020-12-21 01:11:10.069012');
INSERT INTO public.receipts VALUES (106, 'Calvin Klein', 9.00, '2020-06-18', '2020-12-21 01:11:10.075954');
INSERT INTO public.receipts VALUES (107, 'Levis', 7.75, '2020-07-21', '2020-12-21 01:11:10.083546');
INSERT INTO public.receipts VALUES (108, 'Levis', 8.13, '2020-06-16', '2020-12-21 01:11:10.090619');
INSERT INTO public.receipts VALUES (109, 'Levis', 8.13, '2020-07-08', '2020-12-21 01:11:10.097665');
INSERT INTO public.receipts VALUES (110, 'Levis', 8.13, '2020-07-08', '2020-12-21 01:11:10.104703');
INSERT INTO public.receipts VALUES (111, 'Levis', 7.75, '2020-07-06', '2020-12-21 01:11:10.111953');
INSERT INTO public.receipts VALUES (112, 'Levis', 8.13, '2020-07-04', '2020-12-21 01:11:10.120187');
INSERT INTO public.receipts VALUES (113, 'Levis', 8.13, '2020-07-03', '2020-12-21 01:11:10.127334');
INSERT INTO public.receipts VALUES (114, 'Levis', 8.13, '2020-07-13', '2020-12-21 01:11:10.134466');
INSERT INTO public.receipts VALUES (115, 'Macys', 8.75, '2020-08-16', '2020-12-21 01:11:10.141905');
INSERT INTO public.receipts VALUES (116, 'Calvin Klein', 8.13, '2020-08-19', '2020-12-21 01:11:10.148959');
INSERT INTO public.receipts VALUES (117, 'Calvin Klein', 8.13, '2020-06-09', '2020-12-21 01:11:10.155918');
INSERT INTO public.receipts VALUES (118, 'Calvin Klein', 8.13, '2020-08-09', '2020-12-21 01:11:10.162869');
INSERT INTO public.receipts VALUES (119, 'Calvin Klein', 8.13, '2020-08-08', '2020-12-21 01:11:10.170867');
INSERT INTO public.receipts VALUES (120, 'Calvin Klein', 8.13, '2020-08-08', '2020-12-21 01:11:10.177867');
INSERT INTO public.receipts VALUES (121, 'Calvin Klein', 8.13, '2020-08-10', '2020-12-21 01:11:10.185605');
INSERT INTO public.receipts VALUES (122, 'Armani Exchange', 9.25, '2020-08-24', '2020-12-21 01:11:10.193102');
INSERT INTO public.receipts VALUES (123, 'TJ Maxx', 7.75, '2020-08-22', '2020-12-21 01:11:10.201347');
INSERT INTO public.receipts VALUES (124, 'Armani Exchange', 9.25, '2020-08-23', '2020-12-21 01:11:10.209316');
INSERT INTO public.receipts VALUES (125, 'Calvin Klein', 7.75, '2020-08-31', '2020-12-21 01:11:10.222099');
INSERT INTO public.receipts VALUES (126, 'Calvin Klein', 8.13, '2020-07-31', '2020-12-21 01:11:10.235596');
INSERT INTO public.receipts VALUES (127, 'Calvin Klein', 8.13, '2020-08-19', '2020-12-21 01:11:10.242749');
INSERT INTO public.receipts VALUES (128, 'Calvin Klein', 9.25, '2020-09-04', '2020-12-21 01:11:10.250037');
INSERT INTO public.receipts VALUES (129, 'Calvin Klein', 8.13, '2020-09-08', '2020-12-21 01:11:10.258014');
INSERT INTO public.receipts VALUES (130, 'Levis', 8.13, '2020-09-08', '2020-12-21 01:11:10.265312');
INSERT INTO public.receipts VALUES (131, 'Tommy Hilfiger', 8.13, '2020-09-08', '2020-12-21 01:11:10.272781');
INSERT INTO public.receipts VALUES (132, 'Calvin Klein', 9.25, '2020-09-15', '2020-12-21 01:11:10.28053');
INSERT INTO public.receipts VALUES (133, 'Armani Exchange', 9.25, '2020-09-15', '2020-12-21 01:11:10.287974');
INSERT INTO public.receipts VALUES (134, 'Armani Exchange', 9.25, '2020-09-04', '2020-12-21 01:11:10.294991');
INSERT INTO public.receipts VALUES (135, 'Tommy Hilfiger', 9.25, '2020-09-15', '2020-12-21 01:11:10.302935');
INSERT INTO public.receipts VALUES (136, 'Tommy Hilfiger', 8.13, '2020-09-12', '2020-12-21 01:11:10.31003');
INSERT INTO public.receipts VALUES (137, 'Tommy Hilfiger', 8.13, '2020-08-30', '2020-12-21 01:11:10.317921');
INSERT INTO public.receipts VALUES (138, 'Tommy Hilfiger', 7.75, '2020-08-31', '2020-12-21 01:11:10.325496');
INSERT INTO public.receipts VALUES (139, 'Tommy Hilfiger', 8.13, '2020-08-30', '2020-12-21 01:11:10.332918');
INSERT INTO public.receipts VALUES (140, 'Tommy Hilfiger', 9.25, '2020-08-05', '2020-12-21 01:11:10.340458');
INSERT INTO public.receipts VALUES (141, 'Calvin Klein', 7.75, '2020-08-06', '2020-12-21 01:11:10.348208');
INSERT INTO public.receipts VALUES (142, 'Calvin Klein', 9.25, '2020-09-15', '2020-12-21 01:11:10.355764');
INSERT INTO public.receipts VALUES (143, 'Calvin Klein', 8.13, '2020-08-30', '2020-12-21 01:11:10.363129');
INSERT INTO public.receipts VALUES (144, 'Levis', 8.13, '2020-07-31', '2020-12-21 01:11:10.370676');
INSERT INTO public.receipts VALUES (145, 'Levis', 9.25, '2020-09-15', '2020-12-21 01:11:10.378239');
INSERT INTO public.receipts VALUES (146, 'Levis', 9.25, '2020-08-08', '2020-12-21 01:11:10.385621');
INSERT INTO public.receipts VALUES (147, 'Levis', 9.25, '2020-08-07', '2020-12-21 01:11:10.393319');
INSERT INTO public.receipts VALUES (148, 'Tommy Hilfiger', 8.13, '2020-10-02', '2020-12-21 01:11:10.400918');
INSERT INTO public.receipts VALUES (149, 'Karl Lagerfeld', 9.25, '2020-09-15', '2020-12-21 01:11:10.408471');
INSERT INTO public.receipts VALUES (150, 'Tommy Hilfiger', 8.13, '2021-01-07', '2021-01-08 10:26:31.152571');
INSERT INTO public.receipts VALUES (151, 'Burlington', 9.00, '2021-01-07', '2021-01-08 10:50:56.779079');
INSERT INTO public.receipts VALUES (152, 'Burlington', 9.00, '2021-01-07', '2021-01-08 10:59:54.007864');
INSERT INTO public.receipts VALUES (153, 'TJ Maxx', 8.75, '2021-01-07', '2021-01-08 11:31:38.022122');
INSERT INTO public.receipts VALUES (154, 'Calvin Klein', 7.75, '2021-01-07', '2021-01-08 11:46:43.747575');
INSERT INTO public.receipts VALUES (155, 'Calvin Klein', 8.13, '2021-01-07', '2021-01-08 12:10:55.475927');
INSERT INTO public.receipts VALUES (156, 'Armani Exchange', 9.00, '2021-01-07', '2021-01-08 13:19:10.336866');
INSERT INTO public.receipts VALUES (157, 'TJ Maxx', 8.25, '2021-01-12', '2021-01-13 11:09:46.509965');
INSERT INTO public.receipts VALUES (158, 'Marshalls', 7.75, '2021-01-12', '2021-01-13 11:17:40.316063');
INSERT INTO public.receipts VALUES (159, 'TJ Maxx', 8.50, '2021-01-08', '2021-01-13 11:38:07.838571');
INSERT INTO public.receipts VALUES (160, 'Burlington', 7.75, '2021-01-08', '2021-01-13 11:44:13.422288');
INSERT INTO public.receipts VALUES (161, 'Saks Off', 8.00, '2021-01-12', '2021-01-13 12:04:30.995865');
INSERT INTO public.receipts VALUES (162, 'Armani Exchange', 8.13, '2021-01-12', '2021-01-16 14:24:06.864255');
INSERT INTO public.receipts VALUES (163, 'Burlington', 8.00, '2021-01-15', '2021-01-16 18:41:33.785193');
INSERT INTO public.receipts VALUES (164, 'Tommy Hilfiger', 9.25, '2021-01-12', '2021-01-16 18:45:37.325785');
INSERT INTO public.receipts VALUES (165, 'TJ Maxx', 8.75, '2021-01-15', '2021-01-16 18:57:10.620649');
INSERT INTO public.receipts VALUES (166, 'Burlington', 9.25, '2021-01-12', '2021-01-16 19:00:05.743698');
INSERT INTO public.receipts VALUES (167, 'Burlington', 9.25, '2021-01-12', '2021-01-16 19:14:10.958279');
INSERT INTO public.receipts VALUES (168, 'Calvin Klein', 8.13, '2021-01-20', '2021-01-21 16:51:45.716694');
INSERT INTO public.receipts VALUES (169, 'Tommy Hilfiger', 9.25, '2021-01-20', '2021-01-21 16:58:50.545537');
INSERT INTO public.receipts VALUES (170, 'Tommy Hilfiger', 9.25, '2021-01-20', '2021-01-21 17:07:21.206118');
INSERT INTO public.receipts VALUES (171, 'Armani Exchange', 9.25, '2021-01-20', '2021-01-21 17:18:54.338507');
INSERT INTO public.receipts VALUES (172, 'DKNY', 8.13, '2021-01-20', '2021-01-21 17:27:30.516264');
INSERT INTO public.receipts VALUES (173, 'DKNY', 8.13, '2021-01-20', '2021-01-21 17:33:15.259474');
INSERT INTO public.receipts VALUES (174, 'DKNY', 8.13, '2021-01-20', '2021-01-21 17:46:54.60403');
INSERT INTO public.receipts VALUES (175, 'Marshalls', 8.75, '2021-01-21', '2021-01-21 18:02:18.563531');
INSERT INTO public.receipts VALUES (176, 'Marshalls', 8.00, '2021-01-21', '2021-01-22 10:15:42.708855');
INSERT INTO public.receipts VALUES (177, 'Marshalls', 8.75, '2021-01-21', '2021-01-22 10:19:55.778346');
INSERT INTO public.receipts VALUES (178, 'Calvin Klein', 9.25, '2021-01-12', '2021-01-22 12:50:02.810444');
INSERT INTO public.receipts VALUES (179, 'Tommy Hilfiger', 8.13, '2021-01-07', '2021-01-23 19:26:23.939425');
INSERT INTO public.receipts VALUES (180, 'DKNY', 9.25, '2021-01-13', '2021-01-23 20:42:07.930941');
INSERT INTO public.receipts VALUES (181, 'Calvin Klein', 8.13, '2021-01-23', '2021-01-23 21:25:21.00748');
INSERT INTO public.receipts VALUES (182, 'Marshalls', 8.13, '2021-01-23', '2021-01-23 21:35:16.859211');
INSERT INTO public.receipts VALUES (183, 'Tommy Hilfiger', 7.75, '2021-01-19', '2021-01-26 15:35:57.064723');
INSERT INTO public.receipts VALUES (184, 'Michael Kors', 9.00, '2021-01-30', '2021-01-31 14:39:32.70381');
INSERT INTO public.receipts VALUES (185, 'Calvin Klein', 9.25, '2021-01-30', '2021-01-31 14:42:14.787637');
INSERT INTO public.receipts VALUES (186, 'Armani Exchange', 9.25, '2021-01-30', '2021-01-31 14:47:43.426561');
INSERT INTO public.receipts VALUES (187, 'TJ Maxx', 8.25, '2021-01-29', '2021-01-31 14:57:26.474457');
INSERT INTO public.receipts VALUES (188, 'Calvin Klein', 7.75, '2021-01-19', '2021-01-31 15:09:39.751312');
INSERT INTO public.receipts VALUES (189, 'Ross', 8.75, '2021-01-27', '2021-01-31 15:25:31.574987');
INSERT INTO public.receipts VALUES (190, 'DKNY', 9.00, '2021-01-27', '2021-01-31 15:34:25.641917');
INSERT INTO public.receipts VALUES (234, 'Burlington', 8.25, '2021-03-09', '2021-03-11 19:47:32.999845');
INSERT INTO public.receipts VALUES (191, 'Ross', 7.75, '2021-02-01', '2021-02-06 18:38:03.779072');
INSERT INTO public.receipts VALUES (192, 'Marshalls', 8.13, '2021-02-02', '2021-02-07 21:20:20.961684');
INSERT INTO public.receipts VALUES (193, 'Burlington', 9.25, '2021-02-06', '2021-02-07 21:27:55.986201');
INSERT INTO public.receipts VALUES (194, 'Marshalls', 7.75, '2021-02-01', '2021-02-07 22:16:22.040589');
INSERT INTO public.receipts VALUES (195, 'Tommy Hilfiger', 7.75, '2021-02-06', '2021-02-07 22:21:30.510977');
INSERT INTO public.receipts VALUES (196, 'Marshalls', 8.00, '2021-02-05', '2021-02-07 23:17:42.874241');
INSERT INTO public.receipts VALUES (197, 'Calvin Klein', 7.75, '2021-02-06', '2021-02-07 23:25:49.922338');
INSERT INTO public.receipts VALUES (198, 'Tommy Hilfiger', 8.13, '2021-02-02', '2021-02-07 23:38:34.326349');
INSERT INTO public.receipts VALUES (199, 'Calvin Klein', 8.13, '2021-02-02', '2021-02-07 23:46:01.845023');
INSERT INTO public.receipts VALUES (200, 'Levis', 7.75, '2021-02-06', '2021-02-07 23:51:19.464467');
INSERT INTO public.receipts VALUES (201, 'Ross', 7.75, '2021-02-06', '2021-02-08 00:03:16.522723');
INSERT INTO public.receipts VALUES (202, 'Ross', 8.00, '2021-02-04', '2021-02-08 01:05:14.918519');
INSERT INTO public.receipts VALUES (203, 'Levis', 8.13, '2021-02-09', '2021-02-11 23:31:59.114165');
INSERT INTO public.receipts VALUES (204, 'Burlington', 8.00, '2021-02-07', '2021-02-13 02:23:09.422016');
INSERT INTO public.receipts VALUES (205, 'Ross', 8.75, '2021-02-08', '2021-02-13 02:33:37.092477');
INSERT INTO public.receipts VALUES (206, 'Michael Kors', 8.00, '2021-02-13', '2021-02-15 04:01:15.085878');
INSERT INTO public.receipts VALUES (207, 'Ross', 7.75, '2021-02-14', '2021-02-15 04:14:08.93386');
INSERT INTO public.receipts VALUES (208, 'Calvin Klein', 7.75, '2021-02-13', '2021-02-15 04:38:30.346139');
INSERT INTO public.receipts VALUES (209, 'Tommy Hilfiger', 7.75, '2021-02-13', '2021-02-15 04:42:36.855011');
INSERT INTO public.receipts VALUES (210, 'Marshalls', 7.75, '2021-02-13', '2021-02-15 04:50:13.249532');
INSERT INTO public.receipts VALUES (211, 'Burlington', 8.13, '2021-02-16', '2021-02-18 02:48:43.100095');
INSERT INTO public.receipts VALUES (212, 'Tommy Hilfiger', 8.13, '2021-02-16', '2021-02-18 03:00:29.564656');
INSERT INTO public.receipts VALUES (213, 'Armani Exchange', 9.25, '2021-02-20', '2021-02-22 00:22:19.672231');
INSERT INTO public.receipts VALUES (214, 'Tommy Hilfiger', 8.13, '2021-02-21', '2021-02-22 06:39:57.339579');
INSERT INTO public.receipts VALUES (215, 'Burlington', 8.13, '2021-02-19', '2021-02-22 07:16:57.407045');
INSERT INTO public.receipts VALUES (216, 'Ross', 8.75, '2021-02-19', '2021-02-22 07:45:01.257778');
INSERT INTO public.receipts VALUES (217, 'Armani Exchange', 9.00, '2021-02-21', '2021-02-23 20:42:17.795156');
INSERT INTO public.receipts VALUES (218, 'Tommy Hilfiger', 7.75, '2021-02-23', '2021-02-25 23:37:44.924163');
INSERT INTO public.receipts VALUES (219, 'Tommy Hilfiger', 8.13, '2021-02-24', '2021-02-25 23:47:19.001938');
INSERT INTO public.receipts VALUES (220, 'Tommy Hilfiger', 7.75, '2021-02-23', '2021-02-27 21:55:18.517937');
INSERT INTO public.receipts VALUES (221, 'Michael Kors', 9.25, '2021-02-24', '2021-02-27 22:02:00.817469');
INSERT INTO public.receipts VALUES (222, 'Armani Exchange', 9.13, '2021-02-26', '2021-02-27 22:15:38.694145');
INSERT INTO public.receipts VALUES (223, 'Marshalls', 7.75, '2021-02-22', '2021-02-27 22:44:05.909595');
INSERT INTO public.receipts VALUES (224, 'Burlington', 8.75, '2021-02-22', '2021-02-27 22:53:53.793987');
INSERT INTO public.receipts VALUES (225, 'Tommy Hilfiger', 8.12, '2021-02-26', '2021-03-01 00:57:36.808833');
INSERT INTO public.receipts VALUES (226, 'Ross', 7.75, '2021-02-23', '2021-03-01 05:52:39.052112');
INSERT INTO public.receipts VALUES (227, 'Ross', 9.25, '2021-02-24', '2021-03-01 06:20:12.01698');
INSERT INTO public.receipts VALUES (228, 'Tommy Hilfiger', 8.13, '2021-03-02', '2021-03-04 05:41:16.718093');
INSERT INTO public.receipts VALUES (229, 'TJ Maxx', 8.25, '2021-03-03', '2021-03-06 23:15:31.481164');
INSERT INTO public.receipts VALUES (230, 'Ross', 7.75, '2021-03-04', '2021-03-06 23:59:46.408366');
INSERT INTO public.receipts VALUES (231, 'Marshalls', 7.75, '2021-03-04', '2021-03-07 01:07:58.078532');
INSERT INTO public.receipts VALUES (232, 'Burlington', 8.75, '2021-03-07', '2021-03-10 00:08:47.772837');
INSERT INTO public.receipts VALUES (233, 'TJ Maxx', 8.25, '2021-03-08', '2021-03-10 00:30:42.818207');
INSERT INTO public.receipts VALUES (235, 'Ross', 8.13, '2021-03-11', '2021-03-12 23:36:23.245591');
INSERT INTO public.receipts VALUES (268, 'Tommy Hilfiger', 8.13, '2021-03-11', '2021-03-13 03:48:58.203152');
INSERT INTO public.receipts VALUES (269, 'Ross', 7.75, '2021-03-17', '2021-03-20 23:13:58.661853');
INSERT INTO public.receipts VALUES (270, 'Ross', 7.75, '2021-03-19', '2021-03-20 23:49:29.400916');
INSERT INTO public.receipts VALUES (271, 'Burlington', 8.13, '2021-03-19', '2021-03-21 00:05:57.980988');
INSERT INTO public.receipts VALUES (272, 'Marshalls', 8.13, '2021-03-17', '2021-03-21 00:28:54.739963');
INSERT INTO public.receipts VALUES (273, 'Marshalls', 8.00, '2021-03-13', '2021-03-21 00:45:30.77168');
INSERT INTO public.receipts VALUES (274, 'Ross', 8.75, '2021-03-14', '2021-03-21 00:52:38.058357');
INSERT INTO public.receipts VALUES (275, 'Levis', 8.12, '2021-03-17', '2021-03-21 01:01:37.08886');
INSERT INTO public.receipts VALUES (276, 'Ross', 8.13, '2021-03-21', '2021-03-23 00:33:40.173183');
INSERT INTO public.receipts VALUES (277, 'Burlington', 8.13, '2021-03-21', '2021-03-23 01:01:01.112886');
INSERT INTO public.receipts VALUES (278, 'TJ Maxx', 8.25, '2021-03-22', '2021-03-23 01:13:28.802681');
INSERT INTO public.receipts VALUES (279, 'Marshalls', 8.00, '2021-03-23', '2021-03-25 02:53:30.497695');
INSERT INTO public.receipts VALUES (280, 'DKNY', 9.25, '2021-03-25', '2021-03-27 03:58:33.71778');
INSERT INTO public.receipts VALUES (281, 'calvin klein', 9.25, '2021-03-25', '2021-03-27 04:07:22.804835');
INSERT INTO public.receipts VALUES (282, 'Ross', 9.25, '2021-03-25', '2021-03-27 04:14:33.122063');
INSERT INTO public.receipts VALUES (283, 'Armani Exchange', 9.25, '2021-03-25', '2021-03-27 04:50:32.438588');
INSERT INTO public.receipts VALUES (284, 'marshalls', 8.25, '2021-03-28', '2021-03-29 03:59:37.301763');
INSERT INTO public.receipts VALUES (285, 'Levi''s', 9.25, '2021-03-25', '2021-03-30 20:53:26.824547');
INSERT INTO public.receipts VALUES (286, 'Levis', 9.00, '2020-11-02', '2021-04-01 03:16:44.767469');
INSERT INTO public.receipts VALUES (287, 'Armani Exchange', 9.25, '2021-04-02', '2021-04-02 21:15:41.973764');
INSERT INTO public.receipts VALUES (288, 'Ross', 8.25, '2021-03-28', '2021-04-03 02:17:19.956521');
INSERT INTO public.receipts VALUES (289, 'marshalls', 8.00, '2021-03-30', '2021-04-03 02:47:30.74279');
INSERT INTO public.receipts VALUES (290, 'ROSS', 9.25, '2021-04-01', '2021-04-03 03:07:01.388507');
INSERT INTO public.receipts VALUES (291, 'ROSS', 8.25, '2021-03-27', '2021-04-03 03:15:56.167146');
INSERT INTO public.receipts VALUES (292, 'ROSS', 8.25, '2021-03-27', '2021-04-03 03:15:56.27054');
INSERT INTO public.receipts VALUES (293, 'Armani Exchange', 9.25, '2021-04-03', '2021-04-04 05:08:42.781161');
INSERT INTO public.receipts VALUES (294, 'Armani Exchange', 9.25, '2021-04-05', '2021-04-06 20:08:36.172908');
INSERT INTO public.receipts VALUES (295, 'Tommy Hilfiger', 7.75, '2021-03-28', '2021-04-07 19:40:30.161921');
INSERT INTO public.receipts VALUES (296, 'DKNY', 9.25, '2021-02-20', '2021-04-08 02:49:20.824881');
INSERT INTO public.receipts VALUES (297, 'Calvin Klein', 7.75, '2021-03-28', '2021-04-08 03:41:22.260863');
INSERT INTO public.receipts VALUES (298, 'Burlingtom', 9.25, '2021-04-03', '2021-04-08 04:59:55.736574');
INSERT INTO public.receipts VALUES (299, 'Ross', 8.00, '2021-04-07', '2021-04-08 17:42:43.002084');
INSERT INTO public.receipts VALUES (300, 'Armani Exchange', 8.00, '2021-04-08', '2021-04-08 23:21:01.558049');


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: arn
--

INSERT INTO public.users VALUES (1, 'nastyaluchshaya', '$2b$10$KYbiyzrgF7dvJq4DpOi3feNZwRrftKKkvSyjgzWI2l/dKreDNCPCC');


--
-- Name: clothing_id_seq; Type: SEQUENCE SET; Schema: public; Owner: arn
--

SELECT pg_catalog.setval('public.clothing_id_seq', 3721, true);


--
-- Name: customers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: arn
--

SELECT pg_catalog.setval('public.customers_id_seq', 19, true);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: arn
--

SELECT pg_catalog.setval('public.orders_id_seq', 31, true);


--
-- Name: packages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: arn
--

SELECT pg_catalog.setval('public.packages_id_seq', 129, true);


--
-- Name: receipts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: arn
--

SELECT pg_catalog.setval('public.receipts_id_seq', 300, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: arn
--

SELECT pg_catalog.setval('public.users_id_seq', 1, true);


--
-- Name: clothing clothing_pkey; Type: CONSTRAINT; Schema: public; Owner: arn
--

ALTER TABLE ONLY public.clothing
    ADD CONSTRAINT clothing_pkey PRIMARY KEY (id);


--
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: arn
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: arn
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: packages packages_pkey; Type: CONSTRAINT; Schema: public; Owner: arn
--

ALTER TABLE ONLY public.packages
    ADD CONSTRAINT packages_pkey PRIMARY KEY (id);


--
-- Name: receipts receipts_pkey; Type: CONSTRAINT; Schema: public; Owner: arn
--

ALTER TABLE ONLY public.receipts
    ADD CONSTRAINT receipts_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: arn
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: clothing clothing_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arn
--

ALTER TABLE ONLY public.clothing
    ADD CONSTRAINT clothing_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(id);


--
-- Name: clothing clothing_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arn
--

ALTER TABLE ONLY public.clothing
    ADD CONSTRAINT clothing_package_id_fkey FOREIGN KEY (package_id) REFERENCES public.packages(id);


--
-- Name: clothing clothing_receipt_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arn
--

ALTER TABLE ONLY public.clothing
    ADD CONSTRAINT clothing_receipt_id_fkey FOREIGN KEY (receipt_id) REFERENCES public.receipts(id);


--
-- Name: orders orders_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arn
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- PostgreSQL database dump complete
--

