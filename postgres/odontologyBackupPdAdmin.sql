--
-- PostgreSQL database dump
--

-- Dumped from database version 16.8 (Ubuntu 16.8-0ubuntu0.24.04.1)
-- Dumped by pg_dump version 16.8 (Ubuntu 16.8-0ubuntu0.24.04.1)

-- Started on 2025-08-30 14:24:22 -05

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
-- TOC entry 222 (class 1259 OID 17212)
-- Name: appointment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.appointment (
    appointment_id integer NOT NULL,
    patient_id integer NOT NULL,
    dentist_id integer NOT NULL,
    date_time timestamp without time zone NOT NULL,
    reason text
);


ALTER TABLE public.appointment OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 17211)
-- Name: appointment_appointment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.appointment_appointment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.appointment_appointment_id_seq OWNER TO postgres;

--
-- TOC entry 3599 (class 0 OID 0)
-- Dependencies: 221
-- Name: appointment_appointment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.appointment_appointment_id_seq OWNED BY public.appointment.appointment_id;


--
-- TOC entry 218 (class 1259 OID 17189)
-- Name: dentalhistory; Type: TABLE; Schema: public; Owner: neir
--

CREATE TABLE public.dentalhistory (
    history_id integer NOT NULL,
    patient_id integer NOT NULL,
    anamnesis text
);


ALTER TABLE public.dentalhistory OWNER TO neir;

--
-- TOC entry 217 (class 1259 OID 17188)
-- Name: dentalhistory_history_id_seq; Type: SEQUENCE; Schema: public; Owner: neir
--

CREATE SEQUENCE public.dentalhistory_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dentalhistory_history_id_seq OWNER TO neir;

--
-- TOC entry 3600 (class 0 OID 0)
-- Dependencies: 217
-- Name: dentalhistory_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neir
--

ALTER SEQUENCE public.dentalhistory_history_id_seq OWNED BY public.dentalhistory.history_id;


--
-- TOC entry 235 (class 1259 OID 17314)
-- Name: dentallab; Type: TABLE; Schema: public; Owner: neir
--

CREATE TABLE public.dentallab (
    lab_id integer NOT NULL,
    name character(100) NOT NULL,
    phone character(20),
    address text
);


ALTER TABLE public.dentallab OWNER TO neir;

--
-- TOC entry 234 (class 1259 OID 17313)
-- Name: dentallab_lab_id_seq; Type: SEQUENCE; Schema: public; Owner: neir
--

CREATE SEQUENCE public.dentallab_lab_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dentallab_lab_id_seq OWNER TO neir;

--
-- TOC entry 3601 (class 0 OID 0)
-- Dependencies: 234
-- Name: dentallab_lab_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neir
--

ALTER SEQUENCE public.dentallab_lab_id_seq OWNED BY public.dentallab.lab_id;


--
-- TOC entry 220 (class 1259 OID 17205)
-- Name: dentist; Type: TABLE; Schema: public; Owner: neir
--

CREATE TABLE public.dentist (
    dentist_id integer NOT NULL,
    first_name character(100) NOT NULL,
    last_name character(100) NOT NULL,
    specialty character(100)
);


ALTER TABLE public.dentist OWNER TO neir;

--
-- TOC entry 219 (class 1259 OID 17204)
-- Name: dentist_dentist_id_seq; Type: SEQUENCE; Schema: public; Owner: neir
--

CREATE SEQUENCE public.dentist_dentist_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dentist_dentist_id_seq OWNER TO neir;

--
-- TOC entry 3602 (class 0 OID 0)
-- Dependencies: 219
-- Name: dentist_dentist_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neir
--

ALTER SEQUENCE public.dentist_dentist_id_seq OWNED BY public.dentist.dentist_id;


--
-- TOC entry 232 (class 1259 OID 17290)
-- Name: material; Type: TABLE; Schema: public; Owner: neir
--

CREATE TABLE public.material (
    material_id integer NOT NULL,
    name character(100) NOT NULL,
    description text,
    stock integer
);


ALTER TABLE public.material OWNER TO neir;

--
-- TOC entry 231 (class 1259 OID 17289)
-- Name: material_material_id_seq; Type: SEQUENCE; Schema: public; Owner: neir
--

CREATE SEQUENCE public.material_material_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.material_material_id_seq OWNER TO neir;

--
-- TOC entry 3603 (class 0 OID 0)
-- Dependencies: 231
-- Name: material_material_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neir
--

ALTER SEQUENCE public.material_material_id_seq OWNED BY public.material.material_id;


--
-- TOC entry 216 (class 1259 OID 17180)
-- Name: patient; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.patient (
    patient_id integer NOT NULL,
    first_name character(100) NOT NULL,
    last_name character(100) NOT NULL,
    birth_date date,
    phone character(20),
    address text
);


ALTER TABLE public.patient OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 17179)
-- Name: patient_patient_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.patient_patient_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.patient_patient_id_seq OWNER TO postgres;

--
-- TOC entry 3604 (class 0 OID 0)
-- Dependencies: 215
-- Name: patient_patient_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.patient_patient_id_seq OWNED BY public.patient.patient_id;


--
-- TOC entry 237 (class 1259 OID 17323)
-- Name: payment; Type: TABLE; Schema: public; Owner: neir
--

CREATE TABLE public.payment (
    payment_id integer NOT NULL,
    plan_id integer NOT NULL,
    payment_date timestamp without time zone DEFAULT now() NOT NULL,
    amount numeric(10,2) NOT NULL,
    payment_method character(50)
);


ALTER TABLE public.payment OWNER TO neir;

--
-- TOC entry 236 (class 1259 OID 17322)
-- Name: payment_payment_id_seq; Type: SEQUENCE; Schema: public; Owner: neir
--

CREATE SEQUENCE public.payment_payment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payment_payment_id_seq OWNER TO neir;

--
-- TOC entry 3605 (class 0 OID 0)
-- Dependencies: 236
-- Name: payment_payment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neir
--

ALTER SEQUENCE public.payment_payment_id_seq OWNED BY public.payment.payment_id;


--
-- TOC entry 230 (class 1259 OID 17266)
-- Name: procedure; Type: TABLE; Schema: public; Owner: neir
--

CREATE TABLE public.procedure (
    procedure_id integer NOT NULL,
    plan_id integer NOT NULL,
    treatment_id integer NOT NULL,
    tooth_id integer,
    procedure_date date NOT NULL,
    observations text
);


ALTER TABLE public.procedure OWNER TO neir;

--
-- TOC entry 229 (class 1259 OID 17265)
-- Name: procedure_procedure_id_seq; Type: SEQUENCE; Schema: public; Owner: neir
--

CREATE SEQUENCE public.procedure_procedure_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.procedure_procedure_id_seq OWNER TO neir;

--
-- TOC entry 3606 (class 0 OID 0)
-- Dependencies: 229
-- Name: procedure_procedure_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neir
--

ALTER SEQUENCE public.procedure_procedure_id_seq OWNED BY public.procedure.procedure_id;


--
-- TOC entry 224 (class 1259 OID 17231)
-- Name: tooth; Type: TABLE; Schema: public; Owner: neir
--

CREATE TABLE public.tooth (
    tooth_id integer NOT NULL,
    tooth_number character(10) NOT NULL,
    description text
);


ALTER TABLE public.tooth OWNER TO neir;

--
-- TOC entry 223 (class 1259 OID 17230)
-- Name: tooth_tooth_id_seq; Type: SEQUENCE; Schema: public; Owner: neir
--

CREATE SEQUENCE public.tooth_tooth_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tooth_tooth_id_seq OWNER TO neir;

--
-- TOC entry 3607 (class 0 OID 0)
-- Dependencies: 223
-- Name: tooth_tooth_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neir
--

ALTER SEQUENCE public.tooth_tooth_id_seq OWNED BY public.tooth.tooth_id;


--
-- TOC entry 226 (class 1259 OID 17240)
-- Name: treatment; Type: TABLE; Schema: public; Owner: neir
--

CREATE TABLE public.treatment (
    treatment_id integer NOT NULL,
    name character(100) NOT NULL,
    description text,
    cost numeric(10,2)
);


ALTER TABLE public.treatment OWNER TO neir;

--
-- TOC entry 225 (class 1259 OID 17239)
-- Name: treatment_treatment_id_seq; Type: SEQUENCE; Schema: public; Owner: neir
--

CREATE SEQUENCE public.treatment_treatment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.treatment_treatment_id_seq OWNER TO neir;

--
-- TOC entry 3608 (class 0 OID 0)
-- Dependencies: 225
-- Name: treatment_treatment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neir
--

ALTER SEQUENCE public.treatment_treatment_id_seq OWNED BY public.treatment.treatment_id;


--
-- TOC entry 233 (class 1259 OID 17298)
-- Name: treatmentmaterial; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.treatmentmaterial (
    treatment_id integer NOT NULL,
    material_id integer NOT NULL,
    quantity numeric(10,2) NOT NULL
);


ALTER TABLE public.treatmentmaterial OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 17249)
-- Name: treatmentplan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.treatmentplan (
    plan_id integer NOT NULL,
    patient_id integer NOT NULL,
    dentist_id integer NOT NULL,
    start_date date NOT NULL,
    end_date date,
    status character(50)
);


ALTER TABLE public.treatmentplan OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 17248)
-- Name: treatmentplan_plan_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.treatmentplan_plan_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.treatmentplan_plan_id_seq OWNER TO postgres;

--
-- TOC entry 3609 (class 0 OID 0)
-- Dependencies: 227
-- Name: treatmentplan_plan_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.treatmentplan_plan_id_seq OWNED BY public.treatmentplan.plan_id;


--
-- TOC entry 3382 (class 2604 OID 17215)
-- Name: appointment appointment_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointment ALTER COLUMN appointment_id SET DEFAULT nextval('public.appointment_appointment_id_seq'::regclass);


--
-- TOC entry 3380 (class 2604 OID 17192)
-- Name: dentalhistory history_id; Type: DEFAULT; Schema: public; Owner: neir
--

ALTER TABLE ONLY public.dentalhistory ALTER COLUMN history_id SET DEFAULT nextval('public.dentalhistory_history_id_seq'::regclass);


--
-- TOC entry 3388 (class 2604 OID 17317)
-- Name: dentallab lab_id; Type: DEFAULT; Schema: public; Owner: neir
--

ALTER TABLE ONLY public.dentallab ALTER COLUMN lab_id SET DEFAULT nextval('public.dentallab_lab_id_seq'::regclass);


--
-- TOC entry 3381 (class 2604 OID 17208)
-- Name: dentist dentist_id; Type: DEFAULT; Schema: public; Owner: neir
--

ALTER TABLE ONLY public.dentist ALTER COLUMN dentist_id SET DEFAULT nextval('public.dentist_dentist_id_seq'::regclass);


--
-- TOC entry 3387 (class 2604 OID 17293)
-- Name: material material_id; Type: DEFAULT; Schema: public; Owner: neir
--

ALTER TABLE ONLY public.material ALTER COLUMN material_id SET DEFAULT nextval('public.material_material_id_seq'::regclass);


--
-- TOC entry 3379 (class 2604 OID 17183)
-- Name: patient patient_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patient ALTER COLUMN patient_id SET DEFAULT nextval('public.patient_patient_id_seq'::regclass);


--
-- TOC entry 3389 (class 2604 OID 17326)
-- Name: payment payment_id; Type: DEFAULT; Schema: public; Owner: neir
--

ALTER TABLE ONLY public.payment ALTER COLUMN payment_id SET DEFAULT nextval('public.payment_payment_id_seq'::regclass);


--
-- TOC entry 3386 (class 2604 OID 17269)
-- Name: procedure procedure_id; Type: DEFAULT; Schema: public; Owner: neir
--

ALTER TABLE ONLY public.procedure ALTER COLUMN procedure_id SET DEFAULT nextval('public.procedure_procedure_id_seq'::regclass);


--
-- TOC entry 3383 (class 2604 OID 17234)
-- Name: tooth tooth_id; Type: DEFAULT; Schema: public; Owner: neir
--

ALTER TABLE ONLY public.tooth ALTER COLUMN tooth_id SET DEFAULT nextval('public.tooth_tooth_id_seq'::regclass);


--
-- TOC entry 3384 (class 2604 OID 17243)
-- Name: treatment treatment_id; Type: DEFAULT; Schema: public; Owner: neir
--

ALTER TABLE ONLY public.treatment ALTER COLUMN treatment_id SET DEFAULT nextval('public.treatment_treatment_id_seq'::regclass);


--
-- TOC entry 3385 (class 2604 OID 17252)
-- Name: treatmentplan plan_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.treatmentplan ALTER COLUMN plan_id SET DEFAULT nextval('public.treatmentplan_plan_id_seq'::regclass);


--
-- TOC entry 3578 (class 0 OID 17212)
-- Dependencies: 222
-- Data for Name: appointment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.appointment (appointment_id, patient_id, dentist_id, date_time, reason) FROM stdin;
\.


--
-- TOC entry 3574 (class 0 OID 17189)
-- Dependencies: 218
-- Data for Name: dentalhistory; Type: TABLE DATA; Schema: public; Owner: neir
--

COPY public.dentalhistory (history_id, patient_id, anamnesis) FROM stdin;
\.


--
-- TOC entry 3591 (class 0 OID 17314)
-- Dependencies: 235
-- Data for Name: dentallab; Type: TABLE DATA; Schema: public; Owner: neir
--

COPY public.dentallab (lab_id, name, phone, address) FROM stdin;
\.


--
-- TOC entry 3576 (class 0 OID 17205)
-- Dependencies: 220
-- Data for Name: dentist; Type: TABLE DATA; Schema: public; Owner: neir
--

COPY public.dentist (dentist_id, first_name, last_name, specialty) FROM stdin;
\.


--
-- TOC entry 3588 (class 0 OID 17290)
-- Dependencies: 232
-- Data for Name: material; Type: TABLE DATA; Schema: public; Owner: neir
--

COPY public.material (material_id, name, description, stock) FROM stdin;
\.


--
-- TOC entry 3572 (class 0 OID 17180)
-- Dependencies: 216
-- Data for Name: patient; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.patient (patient_id, first_name, last_name, birth_date, phone, address) FROM stdin;
\.


--
-- TOC entry 3593 (class 0 OID 17323)
-- Dependencies: 237
-- Data for Name: payment; Type: TABLE DATA; Schema: public; Owner: neir
--

COPY public.payment (payment_id, plan_id, payment_date, amount, payment_method) FROM stdin;
\.


--
-- TOC entry 3586 (class 0 OID 17266)
-- Dependencies: 230
-- Data for Name: procedure; Type: TABLE DATA; Schema: public; Owner: neir
--

COPY public.procedure (procedure_id, plan_id, treatment_id, tooth_id, procedure_date, observations) FROM stdin;
\.


--
-- TOC entry 3580 (class 0 OID 17231)
-- Dependencies: 224
-- Data for Name: tooth; Type: TABLE DATA; Schema: public; Owner: neir
--

COPY public.tooth (tooth_id, tooth_number, description) FROM stdin;
\.


--
-- TOC entry 3582 (class 0 OID 17240)
-- Dependencies: 226
-- Data for Name: treatment; Type: TABLE DATA; Schema: public; Owner: neir
--

COPY public.treatment (treatment_id, name, description, cost) FROM stdin;
\.


--
-- TOC entry 3589 (class 0 OID 17298)
-- Dependencies: 233
-- Data for Name: treatmentmaterial; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.treatmentmaterial (treatment_id, material_id, quantity) FROM stdin;
\.


--
-- TOC entry 3584 (class 0 OID 17249)
-- Dependencies: 228
-- Data for Name: treatmentplan; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.treatmentplan (plan_id, patient_id, dentist_id, start_date, end_date, status) FROM stdin;
\.


--
-- TOC entry 3610 (class 0 OID 0)
-- Dependencies: 221
-- Name: appointment_appointment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.appointment_appointment_id_seq', 1, false);


--
-- TOC entry 3611 (class 0 OID 0)
-- Dependencies: 217
-- Name: dentalhistory_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neir
--

SELECT pg_catalog.setval('public.dentalhistory_history_id_seq', 1, false);


--
-- TOC entry 3612 (class 0 OID 0)
-- Dependencies: 234
-- Name: dentallab_lab_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neir
--

SELECT pg_catalog.setval('public.dentallab_lab_id_seq', 1, false);


--
-- TOC entry 3613 (class 0 OID 0)
-- Dependencies: 219
-- Name: dentist_dentist_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neir
--

SELECT pg_catalog.setval('public.dentist_dentist_id_seq', 1, false);


--
-- TOC entry 3614 (class 0 OID 0)
-- Dependencies: 231
-- Name: material_material_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neir
--

SELECT pg_catalog.setval('public.material_material_id_seq', 1, false);


--
-- TOC entry 3615 (class 0 OID 0)
-- Dependencies: 215
-- Name: patient_patient_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.patient_patient_id_seq', 1, false);


--
-- TOC entry 3616 (class 0 OID 0)
-- Dependencies: 236
-- Name: payment_payment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neir
--

SELECT pg_catalog.setval('public.payment_payment_id_seq', 1, false);


--
-- TOC entry 3617 (class 0 OID 0)
-- Dependencies: 229
-- Name: procedure_procedure_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neir
--

SELECT pg_catalog.setval('public.procedure_procedure_id_seq', 1, false);


--
-- TOC entry 3618 (class 0 OID 0)
-- Dependencies: 223
-- Name: tooth_tooth_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neir
--

SELECT pg_catalog.setval('public.tooth_tooth_id_seq', 1, false);


--
-- TOC entry 3619 (class 0 OID 0)
-- Dependencies: 225
-- Name: treatment_treatment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neir
--

SELECT pg_catalog.setval('public.treatment_treatment_id_seq', 1, false);


--
-- TOC entry 3620 (class 0 OID 0)
-- Dependencies: 227
-- Name: treatmentplan_plan_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.treatmentplan_plan_id_seq', 1, false);


--
-- TOC entry 3400 (class 2606 OID 17219)
-- Name: appointment appointment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointment
    ADD CONSTRAINT appointment_pkey PRIMARY KEY (appointment_id);


--
-- TOC entry 3394 (class 2606 OID 17198)
-- Name: dentalhistory dentalhistory_patient_id_key; Type: CONSTRAINT; Schema: public; Owner: neir
--

ALTER TABLE ONLY public.dentalhistory
    ADD CONSTRAINT dentalhistory_patient_id_key UNIQUE (patient_id);


--
-- TOC entry 3396 (class 2606 OID 17196)
-- Name: dentalhistory dentalhistory_pkey; Type: CONSTRAINT; Schema: public; Owner: neir
--

ALTER TABLE ONLY public.dentalhistory
    ADD CONSTRAINT dentalhistory_pkey PRIMARY KEY (history_id);


--
-- TOC entry 3414 (class 2606 OID 17321)
-- Name: dentallab dentallab_pkey; Type: CONSTRAINT; Schema: public; Owner: neir
--

ALTER TABLE ONLY public.dentallab
    ADD CONSTRAINT dentallab_pkey PRIMARY KEY (lab_id);


--
-- TOC entry 3398 (class 2606 OID 17210)
-- Name: dentist dentist_pkey; Type: CONSTRAINT; Schema: public; Owner: neir
--

ALTER TABLE ONLY public.dentist
    ADD CONSTRAINT dentist_pkey PRIMARY KEY (dentist_id);


--
-- TOC entry 3410 (class 2606 OID 17297)
-- Name: material material_pkey; Type: CONSTRAINT; Schema: public; Owner: neir
--

ALTER TABLE ONLY public.material
    ADD CONSTRAINT material_pkey PRIMARY KEY (material_id);


--
-- TOC entry 3392 (class 2606 OID 17187)
-- Name: patient patient_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patient
    ADD CONSTRAINT patient_pkey PRIMARY KEY (patient_id);


--
-- TOC entry 3416 (class 2606 OID 17329)
-- Name: payment payment_pkey; Type: CONSTRAINT; Schema: public; Owner: neir
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT payment_pkey PRIMARY KEY (payment_id);


--
-- TOC entry 3408 (class 2606 OID 17273)
-- Name: procedure procedure_pkey; Type: CONSTRAINT; Schema: public; Owner: neir
--

ALTER TABLE ONLY public.procedure
    ADD CONSTRAINT procedure_pkey PRIMARY KEY (procedure_id);


--
-- TOC entry 3402 (class 2606 OID 17238)
-- Name: tooth tooth_pkey; Type: CONSTRAINT; Schema: public; Owner: neir
--

ALTER TABLE ONLY public.tooth
    ADD CONSTRAINT tooth_pkey PRIMARY KEY (tooth_id);


--
-- TOC entry 3404 (class 2606 OID 17247)
-- Name: treatment treatment_pkey; Type: CONSTRAINT; Schema: public; Owner: neir
--

ALTER TABLE ONLY public.treatment
    ADD CONSTRAINT treatment_pkey PRIMARY KEY (treatment_id);


--
-- TOC entry 3412 (class 2606 OID 17302)
-- Name: treatmentmaterial treatmentmaterial_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.treatmentmaterial
    ADD CONSTRAINT treatmentmaterial_pkey PRIMARY KEY (treatment_id, material_id);


--
-- TOC entry 3406 (class 2606 OID 17254)
-- Name: treatmentplan treatmentplan_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.treatmentplan
    ADD CONSTRAINT treatmentplan_pkey PRIMARY KEY (plan_id);


--
-- TOC entry 3418 (class 2606 OID 17225)
-- Name: appointment fk_appointment_dentist; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointment
    ADD CONSTRAINT fk_appointment_dentist FOREIGN KEY (dentist_id) REFERENCES public.dentist(dentist_id);


--
-- TOC entry 3419 (class 2606 OID 17220)
-- Name: appointment fk_appointment_patient; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointment
    ADD CONSTRAINT fk_appointment_patient FOREIGN KEY (patient_id) REFERENCES public.patient(patient_id);


--
-- TOC entry 3417 (class 2606 OID 17199)
-- Name: dentalhistory fk_history_patient; Type: FK CONSTRAINT; Schema: public; Owner: neir
--

ALTER TABLE ONLY public.dentalhistory
    ADD CONSTRAINT fk_history_patient FOREIGN KEY (patient_id) REFERENCES public.patient(patient_id);


--
-- TOC entry 3427 (class 2606 OID 17330)
-- Name: payment fk_payment_plan; Type: FK CONSTRAINT; Schema: public; Owner: neir
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT fk_payment_plan FOREIGN KEY (plan_id) REFERENCES public.treatmentplan(plan_id);


--
-- TOC entry 3420 (class 2606 OID 17260)
-- Name: treatmentplan fk_plan_dentist; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.treatmentplan
    ADD CONSTRAINT fk_plan_dentist FOREIGN KEY (dentist_id) REFERENCES public.dentist(dentist_id);


--
-- TOC entry 3421 (class 2606 OID 17255)
-- Name: treatmentplan fk_plan_patient; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.treatmentplan
    ADD CONSTRAINT fk_plan_patient FOREIGN KEY (patient_id) REFERENCES public.patient(patient_id);


--
-- TOC entry 3422 (class 2606 OID 17274)
-- Name: procedure fk_procedure_plan; Type: FK CONSTRAINT; Schema: public; Owner: neir
--

ALTER TABLE ONLY public.procedure
    ADD CONSTRAINT fk_procedure_plan FOREIGN KEY (plan_id) REFERENCES public.treatmentplan(plan_id);


--
-- TOC entry 3423 (class 2606 OID 17284)
-- Name: procedure fk_procedure_tooth; Type: FK CONSTRAINT; Schema: public; Owner: neir
--

ALTER TABLE ONLY public.procedure
    ADD CONSTRAINT fk_procedure_tooth FOREIGN KEY (tooth_id) REFERENCES public.tooth(tooth_id);


--
-- TOC entry 3424 (class 2606 OID 17279)
-- Name: procedure fk_procedure_treatment; Type: FK CONSTRAINT; Schema: public; Owner: neir
--

ALTER TABLE ONLY public.procedure
    ADD CONSTRAINT fk_procedure_treatment FOREIGN KEY (treatment_id) REFERENCES public.treatment(treatment_id);


--
-- TOC entry 3425 (class 2606 OID 17308)
-- Name: treatmentmaterial fk_tm_material; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.treatmentmaterial
    ADD CONSTRAINT fk_tm_material FOREIGN KEY (material_id) REFERENCES public.material(material_id);


--
-- TOC entry 3426 (class 2606 OID 17303)
-- Name: treatmentmaterial fk_tm_treatment; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.treatmentmaterial
    ADD CONSTRAINT fk_tm_treatment FOREIGN KEY (treatment_id) REFERENCES public.treatment(treatment_id);


-- Completed on 2025-08-30 14:24:22 -05

--
-- PostgreSQL database dump complete
--

