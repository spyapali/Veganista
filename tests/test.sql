--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.0
-- Dumped by pg_dump version 9.5.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: inputs; Type: TABLE; Schema: public; Owner: shalinipyapali
--

CREATE TABLE inputs (
    input_id integer NOT NULL,
    user_id integer,
    eaten_at date,
    input_name character varying(64)
);


ALTER TABLE inputs OWNER TO shalinipyapali;

--
-- Name: inputs_input_id_seq; Type: SEQUENCE; Schema: public; Owner: shalinipyapali
--

CREATE SEQUENCE inputs_input_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE inputs_input_id_seq OWNER TO shalinipyapali;

--
-- Name: inputs_input_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: shalinipyapali
--

ALTER SEQUENCE inputs_input_id_seq OWNED BY inputs.input_id;


--
-- Name: recipes; Type: TABLE; Schema: public; Owner: shalinipyapali
--

CREATE TABLE recipes (
    recipe_id integer NOT NULL,
    input_name character varying(200),
    percentage_of_carbs double precision,
    percentage_of_fat double precision,
    percentage_of_protein double precision
);


ALTER TABLE recipes OWNER TO shalinipyapali;

--
-- Name: recipes_recipe_id_seq; Type: SEQUENCE; Schema: public; Owner: shalinipyapali
--

CREATE SEQUENCE recipes_recipe_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE recipes_recipe_id_seq OWNER TO shalinipyapali;

--
-- Name: recipes_recipe_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: shalinipyapali
--

ALTER SEQUENCE recipes_recipe_id_seq OWNED BY recipes.recipe_id;


--
-- Name: stats; Type: TABLE; Schema: public; Owner: shalinipyapali
--

CREATE TABLE stats (
    stats_id integer NOT NULL,
    height integer,
    weight integer,
    activity_level character varying(64),
    gender character varying(64),
    age integer,
    user_id integer
);


ALTER TABLE stats OWNER TO shalinipyapali;

--
-- Name: stats_stats_id_seq; Type: SEQUENCE; Schema: public; Owner: shalinipyapali
--

CREATE SEQUENCE stats_stats_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE stats_stats_id_seq OWNER TO shalinipyapali;

--
-- Name: stats_stats_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: shalinipyapali
--

ALTER SEQUENCE stats_stats_id_seq OWNED BY stats.stats_id;


--
-- Name: supplements; Type: TABLE; Schema: public; Owner: shalinipyapali
--

CREATE TABLE supplements (
    unique_id integer NOT NULL,
    supplement_id character varying(64) NOT NULL,
    supplement_taken_at timestamp without time zone NOT NULL
);


ALTER TABLE supplements OWNER TO shalinipyapali;

--
-- Name: supplements_unique_id_seq; Type: SEQUENCE; Schema: public; Owner: shalinipyapali
--

CREATE SEQUENCE supplements_unique_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE supplements_unique_id_seq OWNER TO shalinipyapali;

--
-- Name: supplements_unique_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: shalinipyapali
--

ALTER SEQUENCE supplements_unique_id_seq OWNED BY supplements.unique_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: shalinipyapali
--

CREATE TABLE users (
    user_id integer NOT NULL,
    first_name character varying(64) NOT NULL,
    last_name character varying(64) NOT NULL,
    username character varying(64) NOT NULL,
    password character varying(64) NOT NULL
);


ALTER TABLE users OWNER TO shalinipyapali;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: shalinipyapali
--

CREATE SEQUENCE users_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_user_id_seq OWNER TO shalinipyapali;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: shalinipyapali
--

ALTER SEQUENCE users_user_id_seq OWNED BY users.user_id;


--
-- Name: input_id; Type: DEFAULT; Schema: public; Owner: shalinipyapali
--

ALTER TABLE ONLY inputs ALTER COLUMN input_id SET DEFAULT nextval('inputs_input_id_seq'::regclass);


--
-- Name: recipe_id; Type: DEFAULT; Schema: public; Owner: shalinipyapali
--

ALTER TABLE ONLY recipes ALTER COLUMN recipe_id SET DEFAULT nextval('recipes_recipe_id_seq'::regclass);


--
-- Name: stats_id; Type: DEFAULT; Schema: public; Owner: shalinipyapali
--

ALTER TABLE ONLY stats ALTER COLUMN stats_id SET DEFAULT nextval('stats_stats_id_seq'::regclass);


--
-- Name: unique_id; Type: DEFAULT; Schema: public; Owner: shalinipyapali
--

ALTER TABLE ONLY supplements ALTER COLUMN unique_id SET DEFAULT nextval('supplements_unique_id_seq'::regclass);


--
-- Name: user_id; Type: DEFAULT; Schema: public; Owner: shalinipyapali
--

ALTER TABLE ONLY users ALTER COLUMN user_id SET DEFAULT nextval('users_user_id_seq'::regclass);


--
-- Data for Name: inputs; Type: TABLE DATA; Schema: public; Owner: shalinipyapali
--

COPY inputs (input_id, user_id, eaten_at, input_name) FROM stdin;
12	1	2016-02-29	banana & almond butter toast
13	1	2016-02-29	rava dosa with potato chickpea masala
14	1	2016-02-29	lemon italian ice
15	1	2016-02-29	braised eggplant with garlic and basil
16	1	2016-03-01	raspberry peach smoothie
18	1	2016-03-01	pasta salad with broccoli and peanuts
19	1	2016-03-01	boiled peanuts
20	1	2016-03-01	eggplant & lentil fritters
22	1	2016-03-01	guacamole
24	1	2016-03-01	pickled pepper
26	1	2016-03-01	orange-ginger and lime pickle dipping sauce
36	1	2016-03-02	cherry vanilla almond smoothie
40	1	2016-03-02	guacamole
41	1	2016-03-02	raspberry peach smoothie
42	1	2016-03-03	sea salt and vinegar peanuts
44	1	2016-03-03	guacamole
45	1	2016-03-03	almond butter oatmeal
46	1	2016-03-03	eggplant & lentil fritters
47	1	2016-03-03	pico de gallo
49	1	2016-03-03	eggplant & lentil fritters
50	1	2016-03-03	guacamole
51	1	2016-03-03	guacamole
52	1	2016-03-03	guacamole
53	1	2016-03-03	banana & almond butter toast
54	1	2016-03-03	guacamole
56	1	2016-03-03	raspberry peach smoothie
57	1	2016-03-04	rava dosa with potato chickpea masala
58	1	2016-03-04	rava dosa with potato chickpea masala
59	1	2016-03-04	chile peanuts
\.


--
-- Name: inputs_input_id_seq; Type: SEQUENCE SET; Schema: public; Owner: shalinipyapali
--

SELECT pg_catalog.setval('inputs_input_id_seq', 59, true);


--
-- Data for Name: recipes; Type: TABLE DATA; Schema: public; Owner: shalinipyapali
--

COPY recipes (recipe_id, input_name, percentage_of_carbs, percentage_of_fat, percentage_of_protein) FROM stdin;
1	guacamole	4.25837777777778026	22.7783589743590014	5.09196666666666964
2	watermelon crawl	2.74640625000000016	0.114490384615384994	0.287752500000000022
3	pickled pepper	6.43968740000000039	1.20896399999999993	3.61771559999999992
4	orange-ginger and lime pickle dipping sauce	4.62002045100000025	0.458882807692307992	2.11489693000000001
5	pico de gallo	2.05093870000000011	0.301843076923076992	2.08555240000000008
6	peach, tomato and sweet onion salsa	2.01427017566666988	0.254299580307692008	1.4416705809999999
7	raspberry peach smoothie	16.9168821200000004	7.52711307692308029	9.23671788000000049
8	cherry vanilla almond smoothie	10.4980349999999998	1.82958461538461004	3.95094000000000012
10	eggplant & lentil fritters	4.24529842291666704	45.3555336355769185	6.00261862375000099
11	rava dosa with potato chickpea masala	39.5422751742500012	42.9317267808461622	41.6032004896000061
12	lemon italian ice	12.2364794180000018	0.180309669230769215	0.859476090000000248
13	braised eggplant with garlic and basil	7.14744892942500165	33.1019622732692298	10.6249295553999996
14	almond butter oatmeal	20.3792779196666665	16.1086500590769219	12.9340928709999972
15	sea salt and vinegar peanuts	6.26754371666666987	127.453354153846163	58.5697979999999987
16	pasta salad with broccoli and peanuts	64.7864902000000029	25.3039576000000004	21.7430193000000003
17	sugar-candied peanuts	20.4740458333333386	34.898850000000003	18.2857500000000002
18	boiled peanuts	6.0970324666666702	85.9033464615384617	58.5133679999999998
19	chile peanuts	2.37941757131111009	34.0418476129743581	20.9554013812000015
9	banana & almond butter toast	10	11	10
\.


--
-- Name: recipes_recipe_id_seq; Type: SEQUENCE SET; Schema: public; Owner: shalinipyapali
--

SELECT pg_catalog.setval('recipes_recipe_id_seq', 20, true);


--
-- Data for Name: stats; Type: TABLE DATA; Schema: public; Owner: shalinipyapali
--

COPY stats (stats_id, height, weight, activity_level, gender, age, user_id) FROM stdin;
\.


--
-- Name: stats_stats_id_seq; Type: SEQUENCE SET; Schema: public; Owner: shalinipyapali
--

SELECT pg_catalog.setval('stats_stats_id_seq', 1, false);


--
-- Data for Name: supplements; Type: TABLE DATA; Schema: public; Owner: shalinipyapali
--

COPY supplements (unique_id, supplement_id, supplement_taken_at) FROM stdin;
\.


--
-- Name: supplements_unique_id_seq; Type: SEQUENCE SET; Schema: public; Owner: shalinipyapali
--

SELECT pg_catalog.setval('supplements_unique_id_seq', 1, false);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: shalinipyapali
--

COPY users (user_id, first_name, last_name, username, password) FROM stdin;
1	Shalini	Pyapali	spyapali	shalu1129
\.


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: shalinipyapali
--

SELECT pg_catalog.setval('users_user_id_seq', 1, true);


--
-- Name: inputs_pkey; Type: CONSTRAINT; Schema: public; Owner: shalinipyapali
--

ALTER TABLE ONLY inputs
    ADD CONSTRAINT inputs_pkey PRIMARY KEY (input_id);


--
-- Name: recipes_pkey; Type: CONSTRAINT; Schema: public; Owner: shalinipyapali
--

ALTER TABLE ONLY recipes
    ADD CONSTRAINT recipes_pkey PRIMARY KEY (recipe_id);


--
-- Name: stats_pkey; Type: CONSTRAINT; Schema: public; Owner: shalinipyapali
--

ALTER TABLE ONLY stats
    ADD CONSTRAINT stats_pkey PRIMARY KEY (stats_id);


--
-- Name: supplements_pkey; Type: CONSTRAINT; Schema: public; Owner: shalinipyapali
--

ALTER TABLE ONLY supplements
    ADD CONSTRAINT supplements_pkey PRIMARY KEY (unique_id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: shalinipyapali
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: inputs_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: shalinipyapali
--

ALTER TABLE ONLY inputs
    ADD CONSTRAINT inputs_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- Name: stats_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: shalinipyapali
--

ALTER TABLE ONLY stats
    ADD CONSTRAINT stats_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- Name: public; Type: ACL; Schema: -; Owner: shalinipyapali
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM shalinipyapali;
GRANT ALL ON SCHEMA public TO shalinipyapali;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

