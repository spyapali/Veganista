--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.2
-- Dumped by pg_dump version 9.5.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: d
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
-- Name: inputs; Type: TABLE; Schema: public; Owner: spyapali
--

CREATE TABLE inputs (
    input_id integer NOT NULL,
    input_name character varying(200),
    user_id integer,
    eaten_at date
);


ALTER TABLE inputs OWNER TO spyapali;

--
-- Name: inputs_input_id_seq; Type: SEQUENCE; Schema: public; Owner: spyapali
--

CREATE SEQUENCE inputs_input_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE inputs_input_id_seq OWNER TO spyapali;

--
-- Name: inputs_input_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: spyapali
--

ALTER SEQUENCE inputs_input_id_seq OWNED BY inputs.input_id;


--
-- Name: recipes; Type: TABLE; Schema: public; Owner: spyapali
--

CREATE TABLE recipes (
    recipe_id integer NOT NULL,
    input_name character varying(200),
    percentage_of_carbs double precision,
    percentage_of_fat double precision,
    percentage_of_protein double precision
);


ALTER TABLE recipes OWNER TO spyapali;

--
-- Name: recipes_recipe_id_seq; Type: SEQUENCE; Schema: public; Owner: spyapali
--

CREATE SEQUENCE recipes_recipe_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE recipes_recipe_id_seq OWNER TO spyapali;

--
-- Name: recipes_recipe_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: spyapali
--

ALTER SEQUENCE recipes_recipe_id_seq OWNED BY recipes.recipe_id;


--
-- Name: stats; Type: TABLE; Schema: public; Owner: spyapali
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


ALTER TABLE stats OWNER TO spyapali;

--
-- Name: stats_stats_id_seq; Type: SEQUENCE; Schema: public; Owner: spyapali
--

CREATE SEQUENCE stats_stats_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE stats_stats_id_seq OWNER TO spyapali;

--
-- Name: stats_stats_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: spyapali
--

ALTER SEQUENCE stats_stats_id_seq OWNED BY stats.stats_id;


--
-- Name: supplements; Type: TABLE; Schema: public; Owner: spyapali
--

CREATE TABLE supplements (
    unique_id integer NOT NULL,
    supplement_id character varying(64) NOT NULL,
    supplement_taken_at timestamp without time zone NOT NULL
);


ALTER TABLE supplements OWNER TO spyapali;

--
-- Name: supplements_unique_id_seq; Type: SEQUENCE; Schema: public; Owner: spyapali
--

CREATE SEQUENCE supplements_unique_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE supplements_unique_id_seq OWNER TO spyapali;

--
-- Name: supplements_unique_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: spyapali
--

ALTER SEQUENCE supplements_unique_id_seq OWNED BY supplements.unique_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: spyapali
--

CREATE TABLE users (
    user_id integer NOT NULL,
    first_name character varying(64) NOT NULL,
    last_name character varying(64) NOT NULL,
    username character varying(64) NOT NULL,
    password character varying(64) NOT NULL
);


ALTER TABLE users OWNER TO spyapali;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: spyapali
--

CREATE SEQUENCE users_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_user_id_seq OWNER TO spyapali;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: spyapali
--

ALTER SEQUENCE users_user_id_seq OWNED BY users.user_id;


--
-- Name: input_id; Type: DEFAULT; Schema: public; Owner: spyapali
--

ALTER TABLE ONLY inputs ALTER COLUMN input_id SET DEFAULT nextval('inputs_input_id_seq'::regclass);


--
-- Name: recipe_id; Type: DEFAULT; Schema: public; Owner: spyapali
--

ALTER TABLE ONLY recipes ALTER COLUMN recipe_id SET DEFAULT nextval('recipes_recipe_id_seq'::regclass);


--
-- Name: stats_id; Type: DEFAULT; Schema: public; Owner: spyapali
--

ALTER TABLE ONLY stats ALTER COLUMN stats_id SET DEFAULT nextval('stats_stats_id_seq'::regclass);


--
-- Name: unique_id; Type: DEFAULT; Schema: public; Owner: spyapali
--

ALTER TABLE ONLY supplements ALTER COLUMN unique_id SET DEFAULT nextval('supplements_unique_id_seq'::regclass);


--
-- Name: user_id; Type: DEFAULT; Schema: public; Owner: spyapali
--

ALTER TABLE ONLY users ALTER COLUMN user_id SET DEFAULT nextval('users_user_id_seq'::regclass);


--
-- Data for Name: inputs; Type: TABLE DATA; Schema: public; Owner: spyapali
--

COPY inputs (input_id, input_name, user_id, eaten_at) FROM stdin;
1	strawberry smoothie	2	2016-05-01
2	guacamole	3	2016-06-27
6	cherry vanilla almond smoothie	2	2016-06-30
8	raspberry peach smoothie	2	2016-06-30
9	mango chili smoothie	2	2016-06-30
10	strawberry grapefruit smoothie	2	2016-06-30
11	pumpkin spice smoothie	2	2016-06-30
12	almond milk and berry smoothie	2	2016-06-30
13	banana berry green smoothie	2	2016-06-30
14	peanut butter banana smoothie	2	2016-06-30
15	chocolate and banana smoothie	2	2016-06-30
16	pumped-up smoothie	2	2016-06-30
17	herbed hummus	2	2016-06-30
18	beet hummus	2	2016-06-30
19	edamame hummus	2	2016-06-30
20	mediterranean olive hummus	2	2016-06-30
21	guacamole	2	2016-07-02
25	raspberry peach smoothie	2	2016-07-04
\.


--
-- Name: inputs_input_id_seq; Type: SEQUENCE SET; Schema: public; Owner: spyapali
--

SELECT pg_catalog.setval('inputs_input_id_seq', 27, true);


--
-- Data for Name: recipes; Type: TABLE DATA; Schema: public; Owner: spyapali
--

COPY recipes (recipe_id, input_name, percentage_of_carbs, percentage_of_fat, percentage_of_protein) FROM stdin;
1	strawberry smoothie	7.82904937499999942	2.47056923076923063	5.57718000000000114
2	guacamole	4.25837777777777671	22.7783589743589694	5.09196666666666697
4	cherry vanilla almond smoothie	10.4980349999999998	1.82958461538461492	3.95094000000000012
6	Cherry Vanilla Almond Smoothie	10	2	4
7	Chocolate and Banana Smoothie	13	4	11
8	Pumpkin Pie Smoothie	11	6	7
9	Raspberry Peach Smoothie	17	8	9
10	Strawberry Grapefruit Smoothie	12	1	2
11	Peanut Butter Banana Smoothie	13	9	5
12	Mango Chili Smoothie	19	18	17
13	Almond Milk and Berry Smoothie	7	4	3
14	Banana Berry Green Smoothie	12	3	6
15	Carrot Mango Smoothie	6	1	3
16	Mango Coconut Smoothie	13	19	4
18	Herbed Hummus	3	8	9
19	Edamame Hummus	3	26	18
20	Beet Hummus	6	8	8
21	Mediterranean Olive Hummus	9	13	22
22	Mango Hummus	6	17	10
23	Mediterranean Wrap	7	22	18
24	Hummus Vegetable Sandwich	14	14	26
25	Peanut Butter & Jelly Sandwich	13	40	36
26	Edamame Sandwich	12	22	27
27	Spiced Avocado Sandwich	14	25	15
28	AB+J Sandwich	21	30	26
29	Falafel Sandwich with Tomato-Cucumber Salad	19	43	27
30	Apple Sandwiches with Peanut Butter and Raisins	5	23	16
31	Neon Pink Smoothie	7	0	2
32	Strawberry Coconut Smoothie	7	2	2
33	Toast with Refried Beans and Avocado	16	26	24
34	Root Vegetable Chips	14	23	12
35	Coconut Chia Pudding	13	30	8
36	Guacamole	4	23	5
37	raspberry peach smoothie	16.9168821200000004	7.52711307692307763	9.23671787999999871
38	mango chili smoothie	19.2976259477166678	17.9932029548461543	17.0452834538000033
39	strawberry grapefruit smoothie	12.4508629500000012	1.20446730769230737	4.40421820000000075
40	pumpkin spice smoothie	11.2399841296333349	2.56856431615384562	4.18351148939999984
41	almond milk and berry smoothie	7.27985206999999868	4.14240693846153807	3.42452577999999974
42	banana berry green smoothie	14.8457973333333335	6.22425230769230797	5.84558399999999967
43	peanut butter banana smoothie	4.33692635402974958	14.0584469546626938	9.47185083323600274
44	chocolate and banana smoothie	12.5592416666666669	3.92725769230769206	10.9287849999999995
45	pumped-up smoothie	8.96353937499999809	13.8231730769230765	7.26825124999999961
46	herbed hummus	2.85888487000000024	8.46520681538461695	9.40360698000000106
47	beet hummus	5.87220126666666786	8.3604870769230768	8.41114559999999933
48	edamame hummus	2.9245399981633331	25.5814307691025675	18.1796799978799974
49	mediterranean olive hummus	9.25155833333333177	13.2792256410256417	21.8449233333333375
\.


--
-- Name: recipes_recipe_id_seq; Type: SEQUENCE SET; Schema: public; Owner: spyapali
--

SELECT pg_catalog.setval('recipes_recipe_id_seq', 49, true);


--
-- Data for Name: stats; Type: TABLE DATA; Schema: public; Owner: spyapali
--

COPY stats (stats_id, height, weight, activity_level, gender, age, user_id) FROM stdin;
\.


--
-- Name: stats_stats_id_seq; Type: SEQUENCE SET; Schema: public; Owner: spyapali
--

SELECT pg_catalog.setval('stats_stats_id_seq', 1, false);


--
-- Data for Name: supplements; Type: TABLE DATA; Schema: public; Owner: spyapali
--

COPY supplements (unique_id, supplement_id, supplement_taken_at) FROM stdin;
\.


--
-- Name: supplements_unique_id_seq; Type: SEQUENCE SET; Schema: public; Owner: spyapali
--

SELECT pg_catalog.setval('supplements_unique_id_seq', 1, false);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: spyapali
--

COPY users (user_id, first_name, last_name, username, password) FROM stdin;
1	Shalini	Pyapali	shalu.pyapali@gmail.com	shalu1129
2	Shalini	Pyapali	spyapali	shalu1129
3	Rambabu	Pyapali	rpyapali	chitra
\.


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: spyapali
--

SELECT pg_catalog.setval('users_user_id_seq', 3, true);


--
-- Name: inputs_pkey; Type: CONSTRAINT; Schema: public; Owner: spyapali
--

ALTER TABLE ONLY inputs
    ADD CONSTRAINT inputs_pkey PRIMARY KEY (input_id);


--
-- Name: recipes_pkey; Type: CONSTRAINT; Schema: public; Owner: spyapali
--

ALTER TABLE ONLY recipes
    ADD CONSTRAINT recipes_pkey PRIMARY KEY (recipe_id);


--
-- Name: stats_pkey; Type: CONSTRAINT; Schema: public; Owner: spyapali
--

ALTER TABLE ONLY stats
    ADD CONSTRAINT stats_pkey PRIMARY KEY (stats_id);


--
-- Name: supplements_pkey; Type: CONSTRAINT; Schema: public; Owner: spyapali
--

ALTER TABLE ONLY supplements
    ADD CONSTRAINT supplements_pkey PRIMARY KEY (unique_id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: spyapali
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: inputs_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: spyapali
--

ALTER TABLE ONLY inputs
    ADD CONSTRAINT inputs_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- Name: stats_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: spyapali
--

ALTER TABLE ONLY stats
    ADD CONSTRAINT stats_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- Name: public; Type: ACL; Schema: -; Owner: spyapali
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM spyapali;
GRANT ALL ON SCHEMA public TO spyapali;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

