--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Drop databases (except postgres and template1)
--




--
-- Drop roles
--



--
-- Roles
--

ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:rXYfovFEkwN97FrULUVjZA==$g0wxEwL+A53DQDAuZhYJzvpT7QZmnLiqD3sVlYB1d6Q=:dpQDf/fbOAKHTamMzIASK4oIncRVyBYaLw9ImXMSYGU=';

--
-- User Configurations
--








--
-- Databases
--

--
-- Database "template1" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.12 (Debian 15.12-1.pgdg120+1)
-- Dumped by pg_dump version 15.12 (Debian 15.12-1.pgdg120+1)

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

UPDATE pg_catalog.pg_database SET datistemplate = false WHERE datname = 'template1';
DROP DATABASE template1;
--
-- Name: template1; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE template1 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE template1 OWNER TO postgres;

\connect template1

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
-- Name: DATABASE template1; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE template1 IS 'default template for new databases';


--
-- Name: template1; Type: DATABASE PROPERTIES; Schema: -; Owner: postgres
--

ALTER DATABASE template1 IS_TEMPLATE = true;


\connect template1

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
-- Name: DATABASE template1; Type: ACL; Schema: -; Owner: postgres
--

REVOKE CONNECT,TEMPORARY ON DATABASE template1 FROM PUBLIC;
GRANT CONNECT ON DATABASE template1 TO PUBLIC;


--
-- PostgreSQL database dump complete
--

--
-- Database "eventify" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.12 (Debian 15.12-1.pgdg120+1)
-- Dumped by pg_dump version 15.12 (Debian 15.12-1.pgdg120+1)

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
-- Name: eventify; Type: DATABASE; Schema: -; Owner: postgres
--

DROP DATABASE IF EXISTS eventify;
CREATE DATABASE eventify WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';
ALTER DATABASE eventify OWNER TO postgres;

\connect eventify

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
-- Name: app_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.app_user (
    id integer NOT NULL,
    email text NOT NULL,
    username text NOT NULL,
    password_hash text NOT NULL,
    email_verified boolean NOT NULL,
    registered_2fa boolean NOT NULL
);


ALTER TABLE public.app_user OWNER TO postgres;

--
-- Name: app_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.app_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app_user_id_seq OWNER TO postgres;

--
-- Name: app_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.app_user_id_seq OWNED BY public.app_user.id;


--
-- Name: booking; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.booking (
    id integer NOT NULL,
    user_id integer NOT NULL,
    event_id integer NOT NULL,
    number_of_people integer NOT NULL
);


ALTER TABLE public.booking OWNER TO postgres;

--
-- Name: booking_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.booking_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.booking_id_seq OWNER TO postgres;

--
-- Name: booking_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.booking_id_seq OWNED BY public.booking.id;


--
-- Name: event; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event (
    id integer NOT NULL,
    name text NOT NULL,
    max_attendees integer NOT NULL,
    min_attendees integer,
    event_date date NOT NULL,
    venue_id integer NOT NULL,
    event_to_tag character varying(50)
);


ALTER TABLE public.event OWNER TO postgres;

--
-- Name: event_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.event_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.event_id_seq OWNER TO postgres;

--
-- Name: event_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.event_id_seq OWNED BY public.event.id;


--
-- Name: event_to_tag; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event_to_tag (
    id integer NOT NULL,
    event_id integer NOT NULL,
    tag_id integer NOT NULL
);


ALTER TABLE public.event_to_tag OWNER TO postgres;

--
-- Name: event_to_tag_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.event_to_tag_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.event_to_tag_id_seq OWNER TO postgres;

--
-- Name: event_to_tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.event_to_tag_id_seq OWNED BY public.event_to_tag.id;


--
-- Name: schedule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schedule (
    id integer NOT NULL,
    event_id integer NOT NULL,
    start_time timestamp without time zone NOT NULL,
    end_time timestamp without time zone NOT NULL
);


ALTER TABLE public.schedule OWNER TO postgres;

--
-- Name: schedule_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.schedule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.schedule_id_seq OWNER TO postgres;

--
-- Name: schedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.schedule_id_seq OWNED BY public.schedule.id;


--
-- Name: tag; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tag (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.tag OWNER TO postgres;

--
-- Name: tag_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tag_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tag_id_seq OWNER TO postgres;

--
-- Name: tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tag_id_seq OWNED BY public.tag.id;


--
-- Name: user_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_session (
    id text NOT NULL,
    user_id integer NOT NULL,
    ip_address inet NOT NULL,
    expires_at timestamp with time zone NOT NULL
);


ALTER TABLE public.user_session OWNER TO postgres;

--
-- Name: venue; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.venue (
    id integer NOT NULL,
    name text NOT NULL,
    address text NOT NULL,
    city text NOT NULL,
    state text NOT NULL,
    zip text NOT NULL,
    phone text NOT NULL,
    capacity integer NOT NULL,
    website text NOT NULL
);


ALTER TABLE public.venue OWNER TO postgres;

--
-- Name: venue_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.venue_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.venue_id_seq OWNER TO postgres;

--
-- Name: venue_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.venue_id_seq OWNED BY public.venue.id;


--
-- Name: app_user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.app_user ALTER COLUMN id SET DEFAULT nextval('public.app_user_id_seq'::regclass);


--
-- Name: booking id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.booking ALTER COLUMN id SET DEFAULT nextval('public.booking_id_seq'::regclass);


--
-- Name: event id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event ALTER COLUMN id SET DEFAULT nextval('public.event_id_seq'::regclass);


--
-- Name: event_to_tag id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_to_tag ALTER COLUMN id SET DEFAULT nextval('public.event_to_tag_id_seq'::regclass);


--
-- Name: schedule id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule ALTER COLUMN id SET DEFAULT nextval('public.schedule_id_seq'::regclass);


--
-- Name: tag id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tag ALTER COLUMN id SET DEFAULT nextval('public.tag_id_seq'::regclass);


--
-- Name: venue id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venue ALTER COLUMN id SET DEFAULT nextval('public.venue_id_seq'::regclass);


--
-- Data for Name: app_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.app_user (id, email, username, password_hash, email_verified, registered_2fa) FROM stdin;
1	test@example.com	example	$argon2id$v=19$m=65536,t=2,p=1$GtODAiMDbT1js8GQAGDxbV4euZPKFQtsB325LlDjm/E$Q2QEtpK7z5301y2wZnSBTeS576dZxx94eDKlshKb/X0	t	t
2	user2@example.com	user2	$argon2id$v=19$m=65536,t=2,p=1$dummyhash2	f	t
3	user3@example.com	user3	$argon2id$v=19$m=65536,t=2,p=1$dummyhash3	t	f
4	user4@example.com	user4	$argon2id$v=19$m=65536,t=2,p=1$dummyhash4	f	t
5	user5@example.com	user5	$argon2id$v=19$m=65536,t=2,p=1$dummyhash5	t	f
6	user6@example.com	user6	$argon2id$v=19$m=65536,t=2,p=1$dummyhash6	f	t
7	user7@example.com	user7	$argon2id$v=19$m=65536,t=2,p=1$dummyhash7	t	f
8	user8@example.com	user8	$argon2id$v=19$m=65536,t=2,p=1$dummyhash8	f	t
9	user9@example.com	user9	$argon2id$v=19$m=65536,t=2,p=1$dummyhash9	t	f
10	user10@example.com	user10	$argon2id$v=19$m=65536,t=2,p=1$dummyhash10	f	t
11	user11@example.com	user11	$argon2id$v=19$m=65536,t=2,p=1$dummyhash11	t	f
12	user12@example.com	user12	$argon2id$v=19$m=65536,t=2,p=1$dummyhash12	f	t
13	user13@example.com	user13	$argon2id$v=19$m=65536,t=2,p=1$dummyhash13	t	f
14	user14@example.com	user14	$argon2id$v=19$m=65536,t=2,p=1$dummyhash14	f	t
15	user15@example.com	user15	$argon2id$v=19$m=65536,t=2,p=1$dummyhash15	t	f
16	user16@example.com	user16	$argon2id$v=19$m=65536,t=2,p=1$dummyhash16	f	t
17	user17@example.com	user17	$argon2id$v=19$m=65536,t=2,p=1$dummyhash17	t	f
18	user18@example.com	user18	$argon2id$v=19$m=65536,t=2,p=1$dummyhash18	f	t
19	user19@example.com	user19	$argon2id$v=19$m=65536,t=2,p=1$dummyhash19	t	f
20	user20@example.com	user20	$argon2id$v=19$m=65536,t=2,p=1$dummyhash20	f	t
21	user21@example.com	user21	$argon2id$v=19$m=65536,t=2,p=1$dummyhash21	t	f
22	user22@example.com	user22	$argon2id$v=19$m=65536,t=2,p=1$dummyhash22	f	t
23	user23@example.com	user23	$argon2id$v=19$m=65536,t=2,p=1$dummyhash23	t	f
24	user24@example.com	user24	$argon2id$v=19$m=65536,t=2,p=1$dummyhash24	f	t
25	user25@example.com	user25	$argon2id$v=19$m=65536,t=2,p=1$dummyhash25	t	f
26	user26@example.com	user26	$argon2id$v=19$m=65536,t=2,p=1$dummyhash26	f	t
27	user27@example.com	user27	$argon2id$v=19$m=65536,t=2,p=1$dummyhash27	t	f
28	user28@example.com	user28	$argon2id$v=19$m=65536,t=2,p=1$dummyhash28	f	t
29	user29@example.com	user29	$argon2id$v=19$m=65536,t=2,p=1$dummyhash29	t	f
30	user30@example.com	user30	$argon2id$v=19$m=65536,t=2,p=1$dummyhash30	f	t
31	user31@example.com	user31	$argon2id$v=19$m=65536,t=2,p=1$dummyhash31	t	f
32	user32@example.com	user32	$argon2id$v=19$m=65536,t=2,p=1$dummyhash32	f	t
33	user33@example.com	user33	$argon2id$v=19$m=65536,t=2,p=1$dummyhash33	t	f
34	user34@example.com	user34	$argon2id$v=19$m=65536,t=2,p=1$dummyhash34	f	t
35	user35@example.com	user35	$argon2id$v=19$m=65536,t=2,p=1$dummyhash35	t	f
36	user36@example.com	user36	$argon2id$v=19$m=65536,t=2,p=1$dummyhash36	f	t
37	user37@example.com	user37	$argon2id$v=19$m=65536,t=2,p=1$dummyhash37	t	f
38	user38@example.com	user38	$argon2id$v=19$m=65536,t=2,p=1$dummyhash38	f	t
39	user39@example.com	user39	$argon2id$v=19$m=65536,t=2,p=1$dummyhash39	t	f
40	user40@example.com	user40	$argon2id$v=19$m=65536,t=2,p=1$dummyhash40	f	t
41	user41@example.com	user41	$argon2id$v=19$m=65536,t=2,p=1$dummyhash41	t	f
42	user42@example.com	user42	$argon2id$v=19$m=65536,t=2,p=1$dummyhash42	f	t
43	user43@example.com	user43	$argon2id$v=19$m=65536,t=2,p=1$dummyhash43	t	f
44	user44@example.com	user44	$argon2id$v=19$m=65536,t=2,p=1$dummyhash44	f	t
45	user45@example.com	user45	$argon2id$v=19$m=65536,t=2,p=1$dummyhash45	t	f
46	user46@example.com	user46	$argon2id$v=19$m=65536,t=2,p=1$dummyhash46	f	t
47	user47@example.com	user47	$argon2id$v=19$m=65536,t=2,p=1$dummyhash47	t	f
48	user48@example.com	user48	$argon2id$v=19$m=65536,t=2,p=1$dummyhash48	f	t
49	user49@example.com	user49	$argon2id$v=19$m=65536,t=2,p=1$dummyhash49	t	f
50	user50@example.com	user50	$argon2id$v=19$m=65536,t=2,p=1$dummyhash50	f	t
51	user51@example.com	user51	$argon2id$v=19$m=65536,t=2,p=1$dummyhash51	t	f
52	user52@example.com	user52	$argon2id$v=19$m=65536,t=2,p=1$dummyhash52	f	t
53	user53@example.com	user53	$argon2id$v=19$m=65536,t=2,p=1$dummyhash53	t	f
54	user54@example.com	user54	$argon2id$v=19$m=65536,t=2,p=1$dummyhash54	f	t
55	user55@example.com	user55	$argon2id$v=19$m=65536,t=2,p=1$dummyhash55	t	f
56	user56@example.com	user56	$argon2id$v=19$m=65536,t=2,p=1$dummyhash56	f	t
57	user57@example.com	user57	$argon2id$v=19$m=65536,t=2,p=1$dummyhash57	t	f
58	user58@example.com	user58	$argon2id$v=19$m=65536,t=2,p=1$dummyhash58	f	t
59	user59@example.com	user59	$argon2id$v=19$m=65536,t=2,p=1$dummyhash59	t	f
60	user60@example.com	user60	$argon2id$v=19$m=65536,t=2,p=1$dummyhash60	f	t
61	user61@example.com	user61	$argon2id$v=19$m=65536,t=2,p=1$dummyhash61	t	f
62	user62@example.com	user62	$argon2id$v=19$m=65536,t=2,p=1$dummyhash62	f	t
63	user63@example.com	user63	$argon2id$v=19$m=65536,t=2,p=1$dummyhash63	t	f
64	user64@example.com	user64	$argon2id$v=19$m=65536,t=2,p=1$dummyhash64	f	t
65	user65@example.com	user65	$argon2id$v=19$m=65536,t=2,p=1$dummyhash65	t	f
66	user66@example.com	user66	$argon2id$v=19$m=65536,t=2,p=1$dummyhash66	f	t
67	user67@example.com	user67	$argon2id$v=19$m=65536,t=2,p=1$dummyhash67	t	f
68	user68@example.com	user68	$argon2id$v=19$m=65536,t=2,p=1$dummyhash68	f	t
69	user69@example.com	user69	$argon2id$v=19$m=65536,t=2,p=1$dummyhash69	t	f
70	user70@example.com	user70	$argon2id$v=19$m=65536,t=2,p=1$dummyhash70	f	t
71	user71@example.com	user71	$argon2id$v=19$m=65536,t=2,p=1$dummyhash71	t	f
72	user72@example.com	user72	$argon2id$v=19$m=65536,t=2,p=1$dummyhash72	f	t
73	user73@example.com	user73	$argon2id$v=19$m=65536,t=2,p=1$dummyhash73	t	f
74	user74@example.com	user74	$argon2id$v=19$m=65536,t=2,p=1$dummyhash74	f	t
75	user75@example.com	user75	$argon2id$v=19$m=65536,t=2,p=1$dummyhash75	t	f
76	user76@example.com	user76	$argon2id$v=19$m=65536,t=2,p=1$dummyhash76	f	t
77	user77@example.com	user77	$argon2id$v=19$m=65536,t=2,p=1$dummyhash77	t	f
78	user78@example.com	user78	$argon2id$v=19$m=65536,t=2,p=1$dummyhash78	f	t
79	user79@example.com	user79	$argon2id$v=19$m=65536,t=2,p=1$dummyhash79	t	f
80	user80@example.com	user80	$argon2id$v=19$m=65536,t=2,p=1$dummyhash80	f	t
81	user81@example.com	user81	$argon2id$v=19$m=65536,t=2,p=1$dummyhash81	t	f
82	user82@example.com	user82	$argon2id$v=19$m=65536,t=2,p=1$dummyhash82	f	t
83	user83@example.com	user83	$argon2id$v=19$m=65536,t=2,p=1$dummyhash83	t	f
84	user84@example.com	user84	$argon2id$v=19$m=65536,t=2,p=1$dummyhash84	f	t
85	user85@example.com	user85	$argon2id$v=19$m=65536,t=2,p=1$dummyhash85	t	f
86	user86@example.com	user86	$argon2id$v=19$m=65536,t=2,p=1$dummyhash86	f	t
87	user87@example.com	user87	$argon2id$v=19$m=65536,t=2,p=1$dummyhash87	t	f
88	user88@example.com	user88	$argon2id$v=19$m=65536,t=2,p=1$dummyhash88	f	t
89	user89@example.com	user89	$argon2id$v=19$m=65536,t=2,p=1$dummyhash89	t	f
90	user90@example.com	user90	$argon2id$v=19$m=65536,t=2,p=1$dummyhash90	f	t
91	user91@example.com	user91	$argon2id$v=19$m=65536,t=2,p=1$dummyhash91	t	f
92	user92@example.com	user92	$argon2id$v=19$m=65536,t=2,p=1$dummyhash92	f	t
93	user93@example.com	user93	$argon2id$v=19$m=65536,t=2,p=1$dummyhash93	t	f
94	user94@example.com	user94	$argon2id$v=19$m=65536,t=2,p=1$dummyhash94	f	t
95	user95@example.com	user95	$argon2id$v=19$m=65536,t=2,p=1$dummyhash95	t	f
96	user96@example.com	user96	$argon2id$v=19$m=65536,t=2,p=1$dummyhash96	f	t
97	user97@example.com	user97	$argon2id$v=19$m=65536,t=2,p=1$dummyhash97	t	f
98	user98@example.com	user98	$argon2id$v=19$m=65536,t=2,p=1$dummyhash98	f	t
99	user99@example.com	user99	$argon2id$v=19$m=65536,t=2,p=1$dummyhash99	t	f
100	user100@example.com	user100	$argon2id$v=19$m=65536,t=2,p=1$dummyhash100	f	t
\.


--
-- Data for Name: booking; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.booking (id, user_id, event_id, number_of_people) FROM stdin;
1	4	8	2
2	7	15	3
3	10	22	4
4	13	29	5
5	16	36	6
6	19	43	7
7	22	50	8
8	25	57	9
9	28	64	10
10	31	71	1
11	34	78	2
12	37	85	3
13	40	92	4
14	43	99	5
15	46	6	6
16	49	13	7
17	52	20	8
18	55	27	9
19	58	34	10
20	61	41	1
21	64	48	2
22	67	55	3
23	70	62	4
24	73	69	5
25	76	76	6
26	79	83	7
27	82	90	8
28	85	97	9
29	88	4	10
30	91	11	1
31	94	18	2
32	97	25	3
33	100	32	4
34	3	39	5
35	6	46	6
36	9	53	7
37	12	60	8
38	15	67	9
39	18	74	10
40	21	81	1
41	24	88	2
42	27	95	3
43	30	2	4
44	33	9	5
45	36	16	6
46	39	23	7
47	42	30	8
48	45	37	9
49	48	44	10
50	51	51	1
51	54	58	2
52	57	65	3
53	60	72	4
54	63	79	5
55	66	86	6
56	69	93	7
57	72	100	8
58	75	7	9
59	78	14	10
60	81	21	1
61	84	28	2
62	87	35	3
63	90	42	4
64	93	49	5
65	96	56	6
66	99	63	7
67	2	70	8
68	5	77	9
69	8	84	10
70	11	91	1
71	14	98	2
72	17	5	3
73	20	12	4
74	23	19	5
75	26	26	6
76	29	33	7
77	32	40	8
78	35	47	9
79	38	54	10
80	41	61	1
81	44	68	2
82	47	75	3
83	50	82	4
84	53	89	5
85	56	96	6
86	59	3	7
87	62	10	8
88	65	17	9
89	68	24	10
90	71	31	1
91	74	38	2
92	77	45	3
93	80	52	4
94	83	59	5
95	86	66	6
96	89	73	7
97	92	80	8
98	95	87	9
99	98	94	10
100	1	1	1
\.


--
-- Data for Name: event; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.event (id, name, max_attendees, min_attendees, event_date, venue_id, event_to_tag) FROM stdin;
1	Event 1	201	101	2025-05-01	1	
2	Event 2	202	102	2025-05-02	2	
3	Event 3	203	103	2025-05-03	3	
4	Event 4	204	104	2025-05-04	4	
5	Event 5	205	105	2025-05-05	5	
6	Event 6	206	106	2025-05-06	6	
7	Event 7	207	107	2025-05-07	7	
8	Event 8	208	108	2025-05-08	8	
9	Event 9	209	109	2025-05-09	9	
10	Event 10	210	110	2025-05-10	10	
11	Event 11	211	111	2025-05-11	11	
12	Event 12	212	112	2025-05-12	12	
13	Event 13	213	113	2025-05-13	13	
14	Event 14	214	114	2025-05-14	14	
15	Event 15	215	115	2025-05-15	15	
16	Event 16	216	116	2025-05-16	16	
17	Event 17	217	117	2025-05-17	17	
18	Event 18	218	118	2025-05-18	18	
19	Event 19	219	119	2025-05-19	19	
20	Event 20	220	120	2025-05-20	20	
21	Event 21	221	121	2025-05-21	21	
22	Event 22	222	122	2025-05-22	22	
23	Event 23	223	123	2025-05-23	23	
24	Event 24	224	124	2025-05-24	24	
25	Event 25	225	125	2025-05-25	25	
26	Event 26	226	126	2025-05-26	26	
27	Event 27	227	127	2025-05-27	27	
28	Event 28	228	128	2025-05-28	28	
29	Event 29	229	129	2025-05-01	29	
30	Event 30	230	130	2025-05-02	30	
31	Event 31	231	131	2025-05-03	31	
32	Event 32	232	132	2025-05-04	32	
33	Event 33	233	133	2025-05-05	33	
34	Event 34	234	134	2025-05-06	34	
35	Event 35	235	135	2025-05-07	35	
36	Event 36	236	136	2025-05-08	36	
37	Event 37	237	137	2025-05-09	37	
38	Event 38	238	138	2025-05-10	38	
39	Event 39	239	139	2025-05-11	39	
40	Event 40	240	140	2025-05-12	40	
41	Event 41	241	141	2025-05-13	41	
42	Event 42	242	142	2025-05-14	42	
43	Event 43	243	143	2025-05-15	43	
44	Event 44	244	144	2025-05-16	44	
45	Event 45	245	145	2025-05-17	45	
46	Event 46	246	146	2025-05-18	46	
47	Event 47	247	147	2025-05-19	47	
48	Event 48	248	148	2025-05-20	48	
49	Event 49	249	149	2025-05-21	49	
50	Event 50	250	150	2025-05-22	50	
51	Event 51	251	151	2025-05-23	51	
52	Event 52	252	152	2025-05-24	52	
53	Event 53	253	153	2025-05-25	53	
54	Event 54	254	154	2025-05-26	54	
55	Event 55	255	155	2025-05-27	55	
56	Event 56	256	156	2025-05-28	56	
57	Event 57	257	157	2025-05-01	57	
58	Event 58	258	158	2025-05-02	58	
59	Event 59	259	159	2025-05-03	59	
60	Event 60	260	160	2025-05-04	60	
61	Event 61	261	161	2025-05-05	61	
62	Event 62	262	162	2025-05-06	62	
63	Event 63	263	163	2025-05-07	63	
64	Event 64	264	164	2025-05-08	64	
65	Event 65	265	165	2025-05-09	65	
66	Event 66	266	166	2025-05-10	66	
67	Event 67	267	167	2025-05-11	67	
68	Event 68	268	168	2025-05-12	68	
69	Event 69	269	169	2025-05-13	69	
70	Event 70	270	170	2025-05-14	70	
71	Event 71	271	171	2025-05-15	71	
72	Event 72	272	172	2025-05-16	72	
73	Event 73	273	173	2025-05-17	73	
74	Event 74	274	174	2025-05-18	74	
75	Event 75	275	175	2025-05-19	75	
76	Event 76	276	176	2025-05-20	76	
77	Event 77	277	177	2025-05-21	77	
78	Event 78	278	178	2025-05-22	78	
79	Event 79	279	179	2025-05-23	79	
80	Event 80	280	180	2025-05-24	80	
81	Event 81	281	181	2025-05-25	81	
82	Event 82	282	182	2025-05-26	82	
83	Event 83	283	183	2025-05-27	83	
84	Event 84	284	184	2025-05-28	84	
85	Event 85	285	185	2025-05-01	85	
86	Event 86	286	186	2025-05-02	86	
87	Event 87	287	187	2025-05-03	87	
88	Event 88	288	188	2025-05-04	88	
89	Event 89	289	189	2025-05-05	89	
90	Event 90	290	190	2025-05-06	90	
91	Event 91	291	191	2025-05-07	91	
92	Event 92	292	192	2025-05-08	92	
93	Event 93	293	193	2025-05-09	93	
94	Event 94	294	194	2025-05-10	94	
95	Event 95	295	195	2025-05-11	95	
96	Event 96	296	196	2025-05-12	96	
97	Event 97	297	197	2025-05-13	97	
98	Event 98	298	198	2025-05-14	98	
99	Event 99	299	199	2025-05-15	99	
100	Event 100	300	200	2025-05-16	100	
\.


--
-- Data for Name: event_to_tag; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.event_to_tag (id, event_id, tag_id) FROM stdin;
1	6	4
2	11	7
3	16	10
4	21	13
5	26	16
6	31	19
7	36	22
8	41	25
9	46	28
10	51	31
11	56	34
12	61	37
13	66	40
14	71	43
15	76	46
16	81	49
17	86	52
18	91	55
19	96	58
20	1	61
21	6	64
22	11	67
23	16	70
24	21	73
25	26	76
26	31	79
27	36	82
28	41	85
29	46	88
30	51	91
31	56	94
32	61	97
33	66	100
34	71	3
35	76	6
36	81	9
37	86	12
38	91	15
39	96	18
40	1	21
41	6	24
42	11	27
43	16	30
44	21	33
45	26	36
46	31	39
47	36	42
48	41	45
49	46	48
50	51	51
51	56	54
52	61	57
53	66	60
54	71	63
55	76	66
56	81	69
57	86	72
58	91	75
59	96	78
60	1	81
61	6	84
62	11	87
63	16	90
64	21	93
65	26	96
66	31	99
67	36	2
68	41	5
69	46	8
70	51	11
71	56	14
72	61	17
73	66	20
74	71	23
75	76	26
76	81	29
77	86	32
78	91	35
79	96	38
80	1	41
81	6	44
82	11	47
83	16	50
84	21	53
85	26	56
86	31	59
87	36	62
88	41	65
89	46	68
90	51	71
91	56	74
92	61	77
93	66	80
94	71	83
95	76	86
96	81	89
97	86	92
98	91	95
99	96	98
100	1	1
\.


--
-- Data for Name: schedule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schedule (id, event_id, start_time, end_time) FROM stdin;
1	1	2025-05-01 10:00:00	2025-05-01 12:00:00
2	2	2025-05-02 10:00:00	2025-05-02 12:00:00
3	3	2025-05-03 10:00:00	2025-05-03 12:00:00
4	4	2025-05-04 10:00:00	2025-05-04 12:00:00
5	5	2025-05-05 10:00:00	2025-05-05 12:00:00
6	6	2025-05-06 10:00:00	2025-05-06 12:00:00
7	7	2025-05-07 10:00:00	2025-05-07 12:00:00
8	8	2025-05-08 10:00:00	2025-05-08 12:00:00
9	9	2025-05-09 10:00:00	2025-05-09 12:00:00
10	10	2025-05-10 10:00:00	2025-05-10 12:00:00
11	11	2025-05-11 10:00:00	2025-05-11 12:00:00
12	12	2025-05-12 10:00:00	2025-05-12 12:00:00
13	13	2025-05-13 10:00:00	2025-05-13 12:00:00
14	14	2025-05-14 10:00:00	2025-05-14 12:00:00
15	15	2025-05-15 10:00:00	2025-05-15 12:00:00
16	16	2025-05-16 10:00:00	2025-05-16 12:00:00
17	17	2025-05-17 10:00:00	2025-05-17 12:00:00
18	18	2025-05-18 10:00:00	2025-05-18 12:00:00
19	19	2025-05-19 10:00:00	2025-05-19 12:00:00
20	20	2025-05-20 10:00:00	2025-05-20 12:00:00
21	21	2025-05-21 10:00:00	2025-05-21 12:00:00
22	22	2025-05-22 10:00:00	2025-05-22 12:00:00
23	23	2025-05-23 10:00:00	2025-05-23 12:00:00
24	24	2025-05-24 10:00:00	2025-05-24 12:00:00
25	25	2025-05-25 10:00:00	2025-05-25 12:00:00
26	26	2025-05-26 10:00:00	2025-05-26 12:00:00
27	27	2025-05-27 10:00:00	2025-05-27 12:00:00
28	28	2025-05-28 10:00:00	2025-05-28 12:00:00
29	29	2025-05-01 10:00:00	2025-05-01 12:00:00
30	30	2025-05-02 10:00:00	2025-05-02 12:00:00
31	31	2025-05-03 10:00:00	2025-05-03 12:00:00
32	32	2025-05-04 10:00:00	2025-05-04 12:00:00
33	33	2025-05-05 10:00:00	2025-05-05 12:00:00
34	34	2025-05-06 10:00:00	2025-05-06 12:00:00
35	35	2025-05-07 10:00:00	2025-05-07 12:00:00
36	36	2025-05-08 10:00:00	2025-05-08 12:00:00
37	37	2025-05-09 10:00:00	2025-05-09 12:00:00
38	38	2025-05-10 10:00:00	2025-05-10 12:00:00
39	39	2025-05-11 10:00:00	2025-05-11 12:00:00
40	40	2025-05-12 10:00:00	2025-05-12 12:00:00
41	41	2025-05-13 10:00:00	2025-05-13 12:00:00
42	42	2025-05-14 10:00:00	2025-05-14 12:00:00
43	43	2025-05-15 10:00:00	2025-05-15 12:00:00
44	44	2025-05-16 10:00:00	2025-05-16 12:00:00
45	45	2025-05-17 10:00:00	2025-05-17 12:00:00
46	46	2025-05-18 10:00:00	2025-05-18 12:00:00
47	47	2025-05-19 10:00:00	2025-05-19 12:00:00
48	48	2025-05-20 10:00:00	2025-05-20 12:00:00
49	49	2025-05-21 10:00:00	2025-05-21 12:00:00
50	50	2025-05-22 10:00:00	2025-05-22 12:00:00
51	51	2025-05-23 10:00:00	2025-05-23 12:00:00
52	52	2025-05-24 10:00:00	2025-05-24 12:00:00
53	53	2025-05-25 10:00:00	2025-05-25 12:00:00
54	54	2025-05-26 10:00:00	2025-05-26 12:00:00
55	55	2025-05-27 10:00:00	2025-05-27 12:00:00
56	56	2025-05-28 10:00:00	2025-05-28 12:00:00
57	57	2025-05-01 10:00:00	2025-05-01 12:00:00
58	58	2025-05-02 10:00:00	2025-05-02 12:00:00
59	59	2025-05-03 10:00:00	2025-05-03 12:00:00
60	60	2025-05-04 10:00:00	2025-05-04 12:00:00
61	61	2025-05-05 10:00:00	2025-05-05 12:00:00
62	62	2025-05-06 10:00:00	2025-05-06 12:00:00
63	63	2025-05-07 10:00:00	2025-05-07 12:00:00
64	64	2025-05-08 10:00:00	2025-05-08 12:00:00
65	65	2025-05-09 10:00:00	2025-05-09 12:00:00
66	66	2025-05-10 10:00:00	2025-05-10 12:00:00
67	67	2025-05-11 10:00:00	2025-05-11 12:00:00
68	68	2025-05-12 10:00:00	2025-05-12 12:00:00
69	69	2025-05-13 10:00:00	2025-05-13 12:00:00
70	70	2025-05-14 10:00:00	2025-05-14 12:00:00
71	71	2025-05-15 10:00:00	2025-05-15 12:00:00
72	72	2025-05-16 10:00:00	2025-05-16 12:00:00
73	73	2025-05-17 10:00:00	2025-05-17 12:00:00
74	74	2025-05-18 10:00:00	2025-05-18 12:00:00
75	75	2025-05-19 10:00:00	2025-05-19 12:00:00
76	76	2025-05-20 10:00:00	2025-05-20 12:00:00
77	77	2025-05-21 10:00:00	2025-05-21 12:00:00
78	78	2025-05-22 10:00:00	2025-05-22 12:00:00
79	79	2025-05-23 10:00:00	2025-05-23 12:00:00
80	80	2025-05-24 10:00:00	2025-05-24 12:00:00
81	81	2025-05-25 10:00:00	2025-05-25 12:00:00
82	82	2025-05-26 10:00:00	2025-05-26 12:00:00
83	83	2025-05-27 10:00:00	2025-05-27 12:00:00
84	84	2025-05-28 10:00:00	2025-05-28 12:00:00
85	85	2025-05-01 10:00:00	2025-05-01 12:00:00
86	86	2025-05-02 10:00:00	2025-05-02 12:00:00
87	87	2025-05-03 10:00:00	2025-05-03 12:00:00
88	88	2025-05-04 10:00:00	2025-05-04 12:00:00
89	89	2025-05-05 10:00:00	2025-05-05 12:00:00
90	90	2025-05-06 10:00:00	2025-05-06 12:00:00
91	91	2025-05-07 10:00:00	2025-05-07 12:00:00
92	92	2025-05-08 10:00:00	2025-05-08 12:00:00
93	93	2025-05-09 10:00:00	2025-05-09 12:00:00
94	94	2025-05-10 10:00:00	2025-05-10 12:00:00
95	95	2025-05-11 10:00:00	2025-05-11 12:00:00
96	96	2025-05-12 10:00:00	2025-05-12 12:00:00
97	97	2025-05-13 10:00:00	2025-05-13 12:00:00
98	98	2025-05-14 10:00:00	2025-05-14 12:00:00
99	99	2025-05-15 10:00:00	2025-05-15 12:00:00
100	100	2025-05-16 10:00:00	2025-05-16 12:00:00
\.


--
-- Data for Name: tag; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tag (id, name) FROM stdin;
1	Tag 1
2	Tag 2
3	Tag 3
4	Tag 4
5	Tag 5
6	Tag 6
7	Tag 7
8	Tag 8
9	Tag 9
10	Tag 10
11	Tag 11
12	Tag 12
13	Tag 13
14	Tag 14
15	Tag 15
16	Tag 16
17	Tag 17
18	Tag 18
19	Tag 19
20	Tag 20
21	Tag 21
22	Tag 22
23	Tag 23
24	Tag 24
25	Tag 25
26	Tag 26
27	Tag 27
28	Tag 28
29	Tag 29
30	Tag 30
31	Tag 31
32	Tag 32
33	Tag 33
34	Tag 34
35	Tag 35
36	Tag 36
37	Tag 37
38	Tag 38
39	Tag 39
40	Tag 40
41	Tag 41
42	Tag 42
43	Tag 43
44	Tag 44
45	Tag 45
46	Tag 46
47	Tag 47
48	Tag 48
49	Tag 49
50	Tag 50
51	Tag 51
52	Tag 52
53	Tag 53
54	Tag 54
55	Tag 55
56	Tag 56
57	Tag 57
58	Tag 58
59	Tag 59
60	Tag 60
61	Tag 61
62	Tag 62
63	Tag 63
64	Tag 64
65	Tag 65
66	Tag 66
67	Tag 67
68	Tag 68
69	Tag 69
70	Tag 70
71	Tag 71
72	Tag 72
73	Tag 73
74	Tag 74
75	Tag 75
76	Tag 76
77	Tag 77
78	Tag 78
79	Tag 79
80	Tag 80
81	Tag 81
82	Tag 82
83	Tag 83
84	Tag 84
85	Tag 85
86	Tag 86
87	Tag 87
88	Tag 88
89	Tag 89
90	Tag 90
91	Tag 91
92	Tag 92
93	Tag 93
94	Tag 94
95	Tag 95
96	Tag 96
97	Tag 97
98	Tag 98
99	Tag 99
100	Tag 100
\.


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_session (id, user_id, ip_address, expires_at) FROM stdin;
sess1	1	192.168.1.1	2025-04-01 12:00:00+00
sess2	2	192.168.1.2	2025-04-02 12:00:00+00
sess3	3	192.168.1.3	2025-04-03 12:00:00+00
sess4	4	192.168.1.4	2025-04-04 12:00:00+00
sess5	5	192.168.1.5	2025-04-05 12:00:00+00
sess6	6	192.168.1.6	2025-04-06 12:00:00+00
sess7	7	192.168.1.7	2025-04-07 12:00:00+00
sess8	8	192.168.1.8	2025-04-08 12:00:00+00
sess9	9	192.168.1.9	2025-04-09 12:00:00+00
sess10	10	192.168.1.10	2025-04-10 12:00:00+00
sess11	11	192.168.1.11	2025-04-11 12:00:00+00
sess12	12	192.168.1.12	2025-04-12 12:00:00+00
sess13	13	192.168.1.13	2025-04-13 12:00:00+00
sess14	14	192.168.1.14	2025-04-14 12:00:00+00
sess15	15	192.168.1.15	2025-04-15 12:00:00+00
sess16	16	192.168.1.16	2025-04-16 12:00:00+00
sess17	17	192.168.1.17	2025-04-17 12:00:00+00
sess18	18	192.168.1.18	2025-04-18 12:00:00+00
sess19	19	192.168.1.19	2025-04-19 12:00:00+00
sess20	20	192.168.1.20	2025-04-20 12:00:00+00
sess21	21	192.168.1.21	2025-04-21 12:00:00+00
sess22	22	192.168.1.22	2025-04-22 12:00:00+00
sess23	23	192.168.1.23	2025-04-23 12:00:00+00
sess24	24	192.168.1.24	2025-04-24 12:00:00+00
sess25	25	192.168.1.25	2025-04-25 12:00:00+00
sess26	26	192.168.1.26	2025-04-26 12:00:00+00
sess27	27	192.168.1.27	2025-04-27 12:00:00+00
sess28	28	192.168.1.28	2025-04-28 12:00:00+00
sess29	29	192.168.1.29	2025-04-01 12:00:00+00
sess30	30	192.168.1.30	2025-04-02 12:00:00+00
sess31	31	192.168.1.31	2025-04-03 12:00:00+00
sess32	32	192.168.1.32	2025-04-04 12:00:00+00
sess33	33	192.168.1.33	2025-04-05 12:00:00+00
sess34	34	192.168.1.34	2025-04-06 12:00:00+00
sess35	35	192.168.1.35	2025-04-07 12:00:00+00
sess36	36	192.168.1.36	2025-04-08 12:00:00+00
sess37	37	192.168.1.37	2025-04-09 12:00:00+00
sess38	38	192.168.1.38	2025-04-10 12:00:00+00
sess39	39	192.168.1.39	2025-04-11 12:00:00+00
sess40	40	192.168.1.40	2025-04-12 12:00:00+00
sess41	41	192.168.1.41	2025-04-13 12:00:00+00
sess42	42	192.168.1.42	2025-04-14 12:00:00+00
sess43	43	192.168.1.43	2025-04-15 12:00:00+00
sess44	44	192.168.1.44	2025-04-16 12:00:00+00
sess45	45	192.168.1.45	2025-04-17 12:00:00+00
sess46	46	192.168.1.46	2025-04-18 12:00:00+00
sess47	47	192.168.1.47	2025-04-19 12:00:00+00
sess48	48	192.168.1.48	2025-04-20 12:00:00+00
sess49	49	192.168.1.49	2025-04-21 12:00:00+00
sess50	50	192.168.1.50	2025-04-22 12:00:00+00
sess51	51	192.168.1.51	2025-04-23 12:00:00+00
sess52	52	192.168.1.52	2025-04-24 12:00:00+00
sess53	53	192.168.1.53	2025-04-25 12:00:00+00
sess54	54	192.168.1.54	2025-04-26 12:00:00+00
sess55	55	192.168.1.55	2025-04-27 12:00:00+00
sess56	56	192.168.1.56	2025-04-28 12:00:00+00
sess57	57	192.168.1.57	2025-04-01 12:00:00+00
sess58	58	192.168.1.58	2025-04-02 12:00:00+00
sess59	59	192.168.1.59	2025-04-03 12:00:00+00
sess60	60	192.168.1.60	2025-04-04 12:00:00+00
sess61	61	192.168.1.61	2025-04-05 12:00:00+00
sess62	62	192.168.1.62	2025-04-06 12:00:00+00
sess63	63	192.168.1.63	2025-04-07 12:00:00+00
sess64	64	192.168.1.64	2025-04-08 12:00:00+00
sess65	65	192.168.1.65	2025-04-09 12:00:00+00
sess66	66	192.168.1.66	2025-04-10 12:00:00+00
sess67	67	192.168.1.67	2025-04-11 12:00:00+00
sess68	68	192.168.1.68	2025-04-12 12:00:00+00
sess69	69	192.168.1.69	2025-04-13 12:00:00+00
sess70	70	192.168.1.70	2025-04-14 12:00:00+00
sess71	71	192.168.1.71	2025-04-15 12:00:00+00
sess72	72	192.168.1.72	2025-04-16 12:00:00+00
sess73	73	192.168.1.73	2025-04-17 12:00:00+00
sess74	74	192.168.1.74	2025-04-18 12:00:00+00
sess75	75	192.168.1.75	2025-04-19 12:00:00+00
sess76	76	192.168.1.76	2025-04-20 12:00:00+00
sess77	77	192.168.1.77	2025-04-21 12:00:00+00
sess78	78	192.168.1.78	2025-04-22 12:00:00+00
sess79	79	192.168.1.79	2025-04-23 12:00:00+00
sess80	80	192.168.1.80	2025-04-24 12:00:00+00
sess81	81	192.168.1.81	2025-04-25 12:00:00+00
sess82	82	192.168.1.82	2025-04-26 12:00:00+00
sess83	83	192.168.1.83	2025-04-27 12:00:00+00
sess84	84	192.168.1.84	2025-04-28 12:00:00+00
sess85	85	192.168.1.85	2025-04-01 12:00:00+00
sess86	86	192.168.1.86	2025-04-02 12:00:00+00
sess87	87	192.168.1.87	2025-04-03 12:00:00+00
sess88	88	192.168.1.88	2025-04-04 12:00:00+00
sess89	89	192.168.1.89	2025-04-05 12:00:00+00
sess90	90	192.168.1.90	2025-04-06 12:00:00+00
sess91	91	192.168.1.91	2025-04-07 12:00:00+00
sess92	92	192.168.1.92	2025-04-08 12:00:00+00
sess93	93	192.168.1.93	2025-04-09 12:00:00+00
sess94	94	192.168.1.94	2025-04-10 12:00:00+00
sess95	95	192.168.1.95	2025-04-11 12:00:00+00
sess96	96	192.168.1.96	2025-04-12 12:00:00+00
sess97	97	192.168.1.97	2025-04-13 12:00:00+00
sess98	98	192.168.1.98	2025-04-14 12:00:00+00
sess99	99	192.168.1.99	2025-04-15 12:00:00+00
sess100	100	192.168.1.100	2025-04-16 12:00:00+00
\.


--
-- Data for Name: venue; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.venue (id, name, address, city, state, zip, phone, capacity, website) FROM stdin;
1	Venue 1	Address 1 Main Street	City 1	State 1	ZIP00001	555-010-0001	101	http://venue1.example.com
2	Venue 2	Address 2 Main Street	City 2	State 2	ZIP00002	555-010-0002	102	http://venue2.example.com
3	Venue 3	Address 3 Main Street	City 3	State 3	ZIP00003	555-010-0003	103	http://venue3.example.com
4	Venue 4	Address 4 Main Street	City 4	State 4	ZIP00004	555-010-0004	104	http://venue4.example.com
5	Venue 5	Address 5 Main Street	City 5	State 5	ZIP00005	555-010-0005	105	http://venue5.example.com
6	Venue 6	Address 6 Main Street	City 6	State 1	ZIP00006	555-010-0006	106	http://venue6.example.com
7	Venue 7	Address 7 Main Street	City 7	State 2	ZIP00007	555-010-0007	107	http://venue7.example.com
8	Venue 8	Address 8 Main Street	City 8	State 3	ZIP00008	555-010-0008	108	http://venue8.example.com
9	Venue 9	Address 9 Main Street	City 9	State 4	ZIP00009	555-010-0009	109	http://venue9.example.com
10	Venue 10	Address 10 Main Street	City 10	State 5	ZIP00010	555-010-0010	110	http://venue10.example.com
11	Venue 11	Address 11 Main Street	City 1	State 1	ZIP00011	555-010-0011	111	http://venue11.example.com
12	Venue 12	Address 12 Main Street	City 2	State 2	ZIP00012	555-010-0012	112	http://venue12.example.com
13	Venue 13	Address 13 Main Street	City 3	State 3	ZIP00013	555-010-0013	113	http://venue13.example.com
14	Venue 14	Address 14 Main Street	City 4	State 4	ZIP00014	555-010-0014	114	http://venue14.example.com
15	Venue 15	Address 15 Main Street	City 5	State 5	ZIP00015	555-010-0015	115	http://venue15.example.com
16	Venue 16	Address 16 Main Street	City 6	State 1	ZIP00016	555-010-0016	116	http://venue16.example.com
17	Venue 17	Address 17 Main Street	City 7	State 2	ZIP00017	555-010-0017	117	http://venue17.example.com
18	Venue 18	Address 18 Main Street	City 8	State 3	ZIP00018	555-010-0018	118	http://venue18.example.com
19	Venue 19	Address 19 Main Street	City 9	State 4	ZIP00019	555-010-0019	119	http://venue19.example.com
20	Venue 20	Address 20 Main Street	City 10	State 5	ZIP00020	555-010-0020	120	http://venue20.example.com
21	Venue 21	Address 21 Main Street	City 1	State 1	ZIP00021	555-010-0021	121	http://venue21.example.com
22	Venue 22	Address 22 Main Street	City 2	State 2	ZIP00022	555-010-0022	122	http://venue22.example.com
23	Venue 23	Address 23 Main Street	City 3	State 3	ZIP00023	555-010-0023	123	http://venue23.example.com
24	Venue 24	Address 24 Main Street	City 4	State 4	ZIP00024	555-010-0024	124	http://venue24.example.com
25	Venue 25	Address 25 Main Street	City 5	State 5	ZIP00025	555-010-0025	125	http://venue25.example.com
26	Venue 26	Address 26 Main Street	City 6	State 1	ZIP00026	555-010-0026	126	http://venue26.example.com
27	Venue 27	Address 27 Main Street	City 7	State 2	ZIP00027	555-010-0027	127	http://venue27.example.com
28	Venue 28	Address 28 Main Street	City 8	State 3	ZIP00028	555-010-0028	128	http://venue28.example.com
29	Venue 29	Address 29 Main Street	City 9	State 4	ZIP00029	555-010-0029	129	http://venue29.example.com
30	Venue 30	Address 30 Main Street	City 10	State 5	ZIP00030	555-010-0030	130	http://venue30.example.com
31	Venue 31	Address 31 Main Street	City 1	State 1	ZIP00031	555-010-0031	131	http://venue31.example.com
32	Venue 32	Address 32 Main Street	City 2	State 2	ZIP00032	555-010-0032	132	http://venue32.example.com
33	Venue 33	Address 33 Main Street	City 3	State 3	ZIP00033	555-010-0033	133	http://venue33.example.com
34	Venue 34	Address 34 Main Street	City 4	State 4	ZIP00034	555-010-0034	134	http://venue34.example.com
35	Venue 35	Address 35 Main Street	City 5	State 5	ZIP00035	555-010-0035	135	http://venue35.example.com
36	Venue 36	Address 36 Main Street	City 6	State 1	ZIP00036	555-010-0036	136	http://venue36.example.com
37	Venue 37	Address 37 Main Street	City 7	State 2	ZIP00037	555-010-0037	137	http://venue37.example.com
38	Venue 38	Address 38 Main Street	City 8	State 3	ZIP00038	555-010-0038	138	http://venue38.example.com
39	Venue 39	Address 39 Main Street	City 9	State 4	ZIP00039	555-010-0039	139	http://venue39.example.com
40	Venue 40	Address 40 Main Street	City 10	State 5	ZIP00040	555-010-0040	140	http://venue40.example.com
41	Venue 41	Address 41 Main Street	City 1	State 1	ZIP00041	555-010-0041	141	http://venue41.example.com
42	Venue 42	Address 42 Main Street	City 2	State 2	ZIP00042	555-010-0042	142	http://venue42.example.com
43	Venue 43	Address 43 Main Street	City 3	State 3	ZIP00043	555-010-0043	143	http://venue43.example.com
44	Venue 44	Address 44 Main Street	City 4	State 4	ZIP00044	555-010-0044	144	http://venue44.example.com
45	Venue 45	Address 45 Main Street	City 5	State 5	ZIP00045	555-010-0045	145	http://venue45.example.com
46	Venue 46	Address 46 Main Street	City 6	State 1	ZIP00046	555-010-0046	146	http://venue46.example.com
47	Venue 47	Address 47 Main Street	City 7	State 2	ZIP00047	555-010-0047	147	http://venue47.example.com
48	Venue 48	Address 48 Main Street	City 8	State 3	ZIP00048	555-010-0048	148	http://venue48.example.com
49	Venue 49	Address 49 Main Street	City 9	State 4	ZIP00049	555-010-0049	149	http://venue49.example.com
50	Venue 50	Address 50 Main Street	City 10	State 5	ZIP00050	555-010-0050	150	http://venue50.example.com
51	Venue 51	Address 51 Main Street	City 1	State 1	ZIP00051	555-010-0051	151	http://venue51.example.com
52	Venue 52	Address 52 Main Street	City 2	State 2	ZIP00052	555-010-0052	152	http://venue52.example.com
53	Venue 53	Address 53 Main Street	City 3	State 3	ZIP00053	555-010-0053	153	http://venue53.example.com
54	Venue 54	Address 54 Main Street	City 4	State 4	ZIP00054	555-010-0054	154	http://venue54.example.com
55	Venue 55	Address 55 Main Street	City 5	State 5	ZIP00055	555-010-0055	155	http://venue55.example.com
56	Venue 56	Address 56 Main Street	City 6	State 1	ZIP00056	555-010-0056	156	http://venue56.example.com
57	Venue 57	Address 57 Main Street	City 7	State 2	ZIP00057	555-010-0057	157	http://venue57.example.com
58	Venue 58	Address 58 Main Street	City 8	State 3	ZIP00058	555-010-0058	158	http://venue58.example.com
59	Venue 59	Address 59 Main Street	City 9	State 4	ZIP00059	555-010-0059	159	http://venue59.example.com
60	Venue 60	Address 60 Main Street	City 10	State 5	ZIP00060	555-010-0060	160	http://venue60.example.com
61	Venue 61	Address 61 Main Street	City 1	State 1	ZIP00061	555-010-0061	161	http://venue61.example.com
62	Venue 62	Address 62 Main Street	City 2	State 2	ZIP00062	555-010-0062	162	http://venue62.example.com
63	Venue 63	Address 63 Main Street	City 3	State 3	ZIP00063	555-010-0063	163	http://venue63.example.com
64	Venue 64	Address 64 Main Street	City 4	State 4	ZIP00064	555-010-0064	164	http://venue64.example.com
65	Venue 65	Address 65 Main Street	City 5	State 5	ZIP00065	555-010-0065	165	http://venue65.example.com
66	Venue 66	Address 66 Main Street	City 6	State 1	ZIP00066	555-010-0066	166	http://venue66.example.com
67	Venue 67	Address 67 Main Street	City 7	State 2	ZIP00067	555-010-0067	167	http://venue67.example.com
68	Venue 68	Address 68 Main Street	City 8	State 3	ZIP00068	555-010-0068	168	http://venue68.example.com
69	Venue 69	Address 69 Main Street	City 9	State 4	ZIP00069	555-010-0069	169	http://venue69.example.com
70	Venue 70	Address 70 Main Street	City 10	State 5	ZIP00070	555-010-0070	170	http://venue70.example.com
71	Venue 71	Address 71 Main Street	City 1	State 1	ZIP00071	555-010-0071	171	http://venue71.example.com
72	Venue 72	Address 72 Main Street	City 2	State 2	ZIP00072	555-010-0072	172	http://venue72.example.com
73	Venue 73	Address 73 Main Street	City 3	State 3	ZIP00073	555-010-0073	173	http://venue73.example.com
74	Venue 74	Address 74 Main Street	City 4	State 4	ZIP00074	555-010-0074	174	http://venue74.example.com
75	Venue 75	Address 75 Main Street	City 5	State 5	ZIP00075	555-010-0075	175	http://venue75.example.com
76	Venue 76	Address 76 Main Street	City 6	State 1	ZIP00076	555-010-0076	176	http://venue76.example.com
77	Venue 77	Address 77 Main Street	City 7	State 2	ZIP00077	555-010-0077	177	http://venue77.example.com
78	Venue 78	Address 78 Main Street	City 8	State 3	ZIP00078	555-010-0078	178	http://venue78.example.com
79	Venue 79	Address 79 Main Street	City 9	State 4	ZIP00079	555-010-0079	179	http://venue79.example.com
80	Venue 80	Address 80 Main Street	City 10	State 5	ZIP00080	555-010-0080	180	http://venue80.example.com
81	Venue 81	Address 81 Main Street	City 1	State 1	ZIP00081	555-010-0081	181	http://venue81.example.com
82	Venue 82	Address 82 Main Street	City 2	State 2	ZIP00082	555-010-0082	182	http://venue82.example.com
83	Venue 83	Address 83 Main Street	City 3	State 3	ZIP00083	555-010-0083	183	http://venue83.example.com
84	Venue 84	Address 84 Main Street	City 4	State 4	ZIP00084	555-010-0084	184	http://venue84.example.com
85	Venue 85	Address 85 Main Street	City 5	State 5	ZIP00085	555-010-0085	185	http://venue85.example.com
86	Venue 86	Address 86 Main Street	City 6	State 1	ZIP00086	555-010-0086	186	http://venue86.example.com
87	Venue 87	Address 87 Main Street	City 7	State 2	ZIP00087	555-010-0087	187	http://venue87.example.com
88	Venue 88	Address 88 Main Street	City 8	State 3	ZIP00088	555-010-0088	188	http://venue88.example.com
89	Venue 89	Address 89 Main Street	City 9	State 4	ZIP00089	555-010-0089	189	http://venue89.example.com
90	Venue 90	Address 90 Main Street	City 10	State 5	ZIP00090	555-010-0090	190	http://venue90.example.com
91	Venue 91	Address 91 Main Street	City 1	State 1	ZIP00091	555-010-0091	191	http://venue91.example.com
92	Venue 92	Address 92 Main Street	City 2	State 2	ZIP00092	555-010-0092	192	http://venue92.example.com
93	Venue 93	Address 93 Main Street	City 3	State 3	ZIP00093	555-010-0093	193	http://venue93.example.com
94	Venue 94	Address 94 Main Street	City 4	State 4	ZIP00094	555-010-0094	194	http://venue94.example.com
95	Venue 95	Address 95 Main Street	City 5	State 5	ZIP00095	555-010-0095	195	http://venue95.example.com
96	Venue 96	Address 96 Main Street	City 6	State 1	ZIP00096	555-010-0096	196	http://venue96.example.com
97	Venue 97	Address 97 Main Street	City 7	State 2	ZIP00097	555-010-0097	197	http://venue97.example.com
98	Venue 98	Address 98 Main Street	City 8	State 3	ZIP00098	555-010-0098	198	http://venue98.example.com
99	Venue 99	Address 99 Main Street	City 9	State 4	ZIP00099	555-010-0099	199	http://venue99.example.com
100	Venue 100	Address 100 Main Street	City 10	State 5	ZIP00100	555-010-0100	200	http://venue100.example.com
\.


--
-- Name: app_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.app_user_id_seq', 1, true);


--
-- Name: booking_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.booking_id_seq', 1, false);


--
-- Name: event_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.event_id_seq', 4, true);


--
-- Name: event_to_tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.event_to_tag_id_seq', 1, false);


--
-- Name: schedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.schedule_id_seq', 1, false);


--
-- Name: tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tag_id_seq', 1, false);


--
-- Name: venue_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.venue_id_seq', 4, true);


--
-- Name: app_user app_user_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.app_user
    ADD CONSTRAINT app_user_email_key UNIQUE (email);


--
-- Name: app_user app_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.app_user
    ADD CONSTRAINT app_user_pkey PRIMARY KEY (id);


--
-- Name: app_user app_user_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.app_user
    ADD CONSTRAINT app_user_username_key UNIQUE (username);


--
-- Name: booking booking_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_pkey PRIMARY KEY (id);


--
-- Name: event event_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event
    ADD CONSTRAINT event_pkey PRIMARY KEY (id);


--
-- Name: event_to_tag event_to_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_to_tag
    ADD CONSTRAINT event_to_tag_pkey PRIMARY KEY (id);


--
-- Name: schedule schedule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule
    ADD CONSTRAINT schedule_pkey PRIMARY KEY (id);


--
-- Name: tag tag_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tag
    ADD CONSTRAINT tag_pkey PRIMARY KEY (id);


--
-- Name: user_session user_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT user_session_pkey PRIMARY KEY (id);


--
-- Name: venue venue_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venue
    ADD CONSTRAINT venue_pkey PRIMARY KEY (id);


--
-- Name: idx_app_user_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_app_user_email ON public.app_user USING btree (email);


--
-- Name: idx_app_user_username; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_app_user_username ON public.app_user USING btree (username);


--
-- Name: idx_booking_event_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_booking_event_id ON public.booking USING btree (event_id);


--
-- Name: idx_booking_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_booking_user_id ON public.booking USING btree (user_id);


--
-- Name: idx_event_event_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_event_event_date ON public.event USING btree (event_date);


--
-- Name: idx_event_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_event_name ON public.event USING btree (name);


--
-- Name: idx_event_to_tag_event_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_event_to_tag_event_id ON public.event_to_tag USING btree (event_id);


--
-- Name: idx_event_to_tag_tag_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_event_to_tag_tag_id ON public.event_to_tag USING btree (tag_id);


--
-- Name: idx_schedule_event_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_schedule_event_id ON public.schedule USING btree (event_id);


--
-- Name: idx_schedule_start_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_schedule_start_time ON public.schedule USING btree (start_time);


--
-- Name: idx_tag_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_tag_name ON public.tag USING btree (name);


--
-- Name: idx_user_session_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_session_user_id ON public.user_session USING btree (user_id);


--
-- Name: idx_venue_city; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_venue_city ON public.venue USING btree (city);


--
-- Name: idx_venue_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_venue_name ON public.venue USING btree (name);


--
-- Name: booking booking_event_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_event_id_fkey FOREIGN KEY (event_id) REFERENCES public.event(id);


--
-- Name: booking booking_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.app_user(id);


--
-- Name: event_to_tag event_to_tag_event_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_to_tag
    ADD CONSTRAINT event_to_tag_event_id_fkey FOREIGN KEY (event_id) REFERENCES public.event(id);


--
-- Name: event_to_tag event_to_tag_tag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_to_tag
    ADD CONSTRAINT event_to_tag_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES public.tag(id);


--
-- Name: event event_venue_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event
    ADD CONSTRAINT event_venue_id_fkey FOREIGN KEY (venue_id) REFERENCES public.venue(id);


--
-- Name: schedule schedule_event_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule
    ADD CONSTRAINT schedule_event_id_fkey FOREIGN KEY (event_id) REFERENCES public.event(id);


--
-- Name: user_session user_session_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT user_session_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.app_user(id);


--
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.12 (Debian 15.12-1.pgdg120+1)
-- Dumped by pg_dump version 15.12 (Debian 15.12-1.pgdg120+1)

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

DROP DATABASE postgres;
--
-- Name: postgres; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE postgres OWNER TO postgres;

\connect postgres

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
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

