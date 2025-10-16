--
-- PostgreSQL database dump
--

-- Dumped from database version 16.8 (Ubuntu 16.8-0ubuntu0.24.04.1)
-- Dumped by pg_dump version 16.8 (Ubuntu 16.8-0ubuntu0.24.04.1)

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
-- Name: audit_action; Type: TYPE; Schema: public; Owner: neir
--

CREATE TYPE public.audit_action AS ENUM (
    'INSERT',
    'UPDATE',
    'DELETE'
);


ALTER TYPE public.audit_action OWNER TO neir;

--
-- Name: ad_materials_audit(); Type: FUNCTION; Schema: public; Owner: neir
--

CREATE FUNCTION public.ad_materials_audit() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO materials_audit (materials_id, action, before_data, after_data)
    VALUES (
        OLD.id,
        'DELETE',
        to_jsonb(OLD),
        NULL
    );
    RETURN OLD;
END;
$$;


ALTER FUNCTION public.ad_materials_audit() OWNER TO neir;

--
-- Name: ad_payments_audit(); Type: FUNCTION; Schema: public; Owner: neir
--

CREATE FUNCTION public.ad_payments_audit() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO payments_audit (payment_id, action, before_data, after_data)
    VALUES (
        OLD.id,
        'DELETE',
        to_jsonb(OLD),
        NULL
    );
    RETURN OLD;
END;
$$;


ALTER FUNCTION public.ad_payments_audit() OWNER TO neir;

--
-- Name: ad_treatments_audit(); Type: FUNCTION; Schema: public; Owner: neir
--

CREATE FUNCTION public.ad_treatments_audit() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO treatments_audit (treatment_id, action, before_data, after_data)
    VALUES (
        OLD.id,
        'DELETE',
        to_jsonb(OLD),
        NULL
    );
    RETURN OLD;
END;
$$;


ALTER FUNCTION public.ad_treatments_audit() OWNER TO neir;

--
-- Name: ai_materials_audit(); Type: FUNCTION; Schema: public; Owner: neir
--

CREATE FUNCTION public.ai_materials_audit() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO materials_audit (materials_id, action, before_data, after_data)
    VALUES (
        NEW.id,
        'INSERT',
        NULL,
        to_jsonb(NEW)
    );
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.ai_materials_audit() OWNER TO neir;

--
-- Name: ai_payments_audit(); Type: FUNCTION; Schema: public; Owner: neir
--

CREATE FUNCTION public.ai_payments_audit() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO payments_audit (payment_id, action, before_data, after_data)
    VALUES (
        NEW.id,
        'INSERT',
        NULL,
        to_jsonb(NEW)
    );
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.ai_payments_audit() OWNER TO neir;

--
-- Name: ai_treatments_audit(); Type: FUNCTION; Schema: public; Owner: neir
--

CREATE FUNCTION public.ai_treatments_audit() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO treatments_audit (treatment_id, action, before_data, after_data)
    VALUES (
        NEW.id,
        'INSERT',
        NULL,
        to_jsonb(NEW)
    );
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.ai_treatments_audit() OWNER TO neir;

--
-- Name: au_materials_audit(); Type: FUNCTION; Schema: public; Owner: neir
--

CREATE FUNCTION public.au_materials_audit() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO materials_audit (materials_id, action, before_data, after_data)
    VALUES (
        NEW.id,
        'UPDATE',
        to_jsonb(OLD),
        to_jsonb(NEW)
    );
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.au_materials_audit() OWNER TO neir;

--
-- Name: au_payments_audit(); Type: FUNCTION; Schema: public; Owner: neir
--

CREATE FUNCTION public.au_payments_audit() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO payments_audit (payment_id, action, before_data, after_data)
    VALUES (
        NEW.id,
        'UPDATE',
        to_jsonb(OLD),
        to_jsonb(NEW)
    );
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.au_payments_audit() OWNER TO neir;

--
-- Name: au_treatments_audit(); Type: FUNCTION; Schema: public; Owner: neir
--

CREATE FUNCTION public.au_treatments_audit() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO treatments_audit (treatment_id, action, before_data, after_data)
    VALUES (
        NEW.id,
        'UPDATE',
        to_jsonb(OLD),
        to_jsonb(NEW)
    );
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.au_treatments_audit() OWNER TO neir;

--
-- Name: block_audit_immutable(); Type: FUNCTION; Schema: public; Owner: neir
--

CREATE FUNCTION public.block_audit_immutable() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    RAISE EXCEPTION '% es inmutable: % prohibido.', TG_TABLE_NAME, TG_OP;
END;
$$;


ALTER FUNCTION public.block_audit_immutable() OWNER TO neir;

--
-- Name: dentistas_con_b(); Type: PROCEDURE; Schema: public; Owner: neir
--

CREATE PROCEDURE public.dentistas_con_b()
    LANGUAGE plpgsql
    AS $$DECLARE
    dentista RECORD; 
BEGIN
    RAISE NOTICE 'Dentistas que comienzan con B:';
    FOR dentista IN SELECT first_name, id FROM dentists
		WHERE first_name LIKE 'Dr. B%' or  first_name LIKE 'Dra. B%' LOOP
        	RAISE NOTICE 'ID: %, Nombre: %', dentista.id, dentista.first_name;
    END LOOP;
END;
$$;


ALTER PROCEDURE public.dentistas_con_b() OWNER TO neir;

--
-- Name: pacientes_con_c(); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.pacientes_con_c()
    LANGUAGE plpgsql
    AS $$
DECLARE
    paciente RECORD;  -- Declarar la variable paciente como RECORD
BEGIN
    RAISE NOTICE 'Lista de Pacientes que comienzan con C:';
    FOR paciente IN SELECT first_name, id, phone FROM patients WHERE first_name LIKE 'C%' LOOP
        RAISE NOTICE 'ID: %, Nombre: %, Teléfono: %', paciente.id, paciente.first_name, paciente.phone;
    END LOOP;
END;
$$;


ALTER PROCEDURE public.pacientes_con_c() OWNER TO postgres;

--
-- Name: trg_payments_audit(); Type: FUNCTION; Schema: public; Owner: neir
--

CREATE FUNCTION public.trg_payments_audit() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF TG_OP = 'DELETE' THEN
        INSERT INTO payments_audit (payment_id, action, before_data, after_data)
        VALUES (
            OLD.id,
            'DELETE',
            to_jsonb(OLD),
            NULL
        );
        RETURN OLD;
    ELSIF TG_OP = 'INSERT' THEN
        INSERT INTO payments_audit (payment_id, action, before_data, after_data)
        VALUES (
            NEW.id,
            'INSERT',
            NULL,
            to_jsonb(NEW)
        );
        RETURN NEW;
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO payments_audit (payment_id, action, before_data, after_data)
        VALUES (
            NEW.id,
            'UPDATE',
            to_jsonb(OLD),
            to_jsonb(NEW)
        );
        RETURN NEW;
    END IF;
END;
$$;


ALTER FUNCTION public.trg_payments_audit() OWNER TO neir;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: appointments; Type: TABLE; Schema: public; Owner: neir
--

CREATE TABLE public.appointments (
    id integer NOT NULL,
    patient_id integer NOT NULL,
    dentist_id integer NOT NULL,
    date_time timestamp without time zone NOT NULL,
    reason text
);


ALTER TABLE public.appointments OWNER TO neir;

--
-- Name: appointments_id_seq; Type: SEQUENCE; Schema: public; Owner: neir
--

CREATE SEQUENCE public.appointments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.appointments_id_seq OWNER TO neir;

--
-- Name: appointments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neir
--

ALTER SEQUENCE public.appointments_id_seq OWNED BY public.appointments.id;


--
-- Name: dental_histories; Type: TABLE; Schema: public; Owner: neir
--

CREATE TABLE public.dental_histories (
    id integer NOT NULL,
    patient_id integer NOT NULL,
    anamnesis text
);


ALTER TABLE public.dental_histories OWNER TO neir;

--
-- Name: dental_histories_id_seq; Type: SEQUENCE; Schema: public; Owner: neir
--

CREATE SEQUENCE public.dental_histories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dental_histories_id_seq OWNER TO neir;

--
-- Name: dental_histories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neir
--

ALTER SEQUENCE public.dental_histories_id_seq OWNED BY public.dental_histories.id;


--
-- Name: dental_labs; Type: TABLE; Schema: public; Owner: neir
--

CREATE TABLE public.dental_labs (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    phone character varying(20),
    address text
);


ALTER TABLE public.dental_labs OWNER TO neir;

--
-- Name: dental_labs_id_seq; Type: SEQUENCE; Schema: public; Owner: neir
--

CREATE SEQUENCE public.dental_labs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dental_labs_id_seq OWNER TO neir;

--
-- Name: dental_labs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neir
--

ALTER SEQUENCE public.dental_labs_id_seq OWNED BY public.dental_labs.id;


--
-- Name: dentists; Type: TABLE; Schema: public; Owner: neir
--

CREATE TABLE public.dentists (
    id integer NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    specialty character varying(100)
);


ALTER TABLE public.dentists OWNER TO neir;

--
-- Name: dentists_id_seq; Type: SEQUENCE; Schema: public; Owner: neir
--

CREATE SEQUENCE public.dentists_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dentists_id_seq OWNER TO neir;

--
-- Name: dentists_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neir
--

ALTER SEQUENCE public.dentists_id_seq OWNED BY public.dentists.id;


--
-- Name: materials; Type: TABLE; Schema: public; Owner: neir
--

CREATE TABLE public.materials (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    stock integer
);


ALTER TABLE public.materials OWNER TO neir;

--
-- Name: materials_audit; Type: TABLE; Schema: public; Owner: neir
--

CREATE TABLE public.materials_audit (
    id bigint NOT NULL,
    materials_id bigint NOT NULL,
    action public.audit_action DEFAULT 'INSERT'::public.audit_action NOT NULL,
    changed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    changed_by character varying(255) DEFAULT 'Admin'::character varying NOT NULL,
    before_data jsonb,
    after_data jsonb
);


ALTER TABLE public.materials_audit OWNER TO neir;

--
-- Name: materials_audit_id_seq; Type: SEQUENCE; Schema: public; Owner: neir
--

CREATE SEQUENCE public.materials_audit_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.materials_audit_id_seq OWNER TO neir;

--
-- Name: materials_audit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neir
--

ALTER SEQUENCE public.materials_audit_id_seq OWNED BY public.materials_audit.id;


--
-- Name: materials_id_seq; Type: SEQUENCE; Schema: public; Owner: neir
--

CREATE SEQUENCE public.materials_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.materials_id_seq OWNER TO neir;

--
-- Name: materials_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neir
--

ALTER SEQUENCE public.materials_id_seq OWNED BY public.materials.id;


--
-- Name: patients; Type: TABLE; Schema: public; Owner: neir
--

CREATE TABLE public.patients (
    id integer NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    birth_date date,
    phone character varying(20),
    address text
);


ALTER TABLE public.patients OWNER TO neir;

--
-- Name: patients_id_seq; Type: SEQUENCE; Schema: public; Owner: neir
--

CREATE SEQUENCE public.patients_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.patients_id_seq OWNER TO neir;

--
-- Name: patients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neir
--

ALTER SEQUENCE public.patients_id_seq OWNED BY public.patients.id;


--
-- Name: payments; Type: TABLE; Schema: public; Owner: neir
--

CREATE TABLE public.payments (
    id integer NOT NULL,
    plan_id integer NOT NULL,
    payment_date timestamp without time zone DEFAULT now() NOT NULL,
    amount numeric(10,2) NOT NULL,
    payment_method character varying(50)
);


ALTER TABLE public.payments OWNER TO neir;

--
-- Name: payments_audit; Type: TABLE; Schema: public; Owner: neir
--

CREATE TABLE public.payments_audit (
    id bigint NOT NULL,
    payment_id bigint NOT NULL,
    action public.audit_action DEFAULT 'INSERT'::public.audit_action NOT NULL,
    changed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    changed_by character varying(255) DEFAULT 'Admin'::character varying NOT NULL,
    before_data jsonb,
    after_data jsonb
);


ALTER TABLE public.payments_audit OWNER TO neir;

--
-- Name: payments_audit_id_seq; Type: SEQUENCE; Schema: public; Owner: neir
--

CREATE SEQUENCE public.payments_audit_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payments_audit_id_seq OWNER TO neir;

--
-- Name: payments_audit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neir
--

ALTER SEQUENCE public.payments_audit_id_seq OWNED BY public.payments_audit.id;


--
-- Name: payments_id_seq; Type: SEQUENCE; Schema: public; Owner: neir
--

CREATE SEQUENCE public.payments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payments_id_seq OWNER TO neir;

--
-- Name: payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neir
--

ALTER SEQUENCE public.payments_id_seq OWNED BY public.payments.id;


--
-- Name: procedures; Type: TABLE; Schema: public; Owner: neir
--

CREATE TABLE public.procedures (
    id integer NOT NULL,
    plan_id integer NOT NULL,
    treatment_id integer NOT NULL,
    tooth_id integer,
    procedure_date date NOT NULL,
    observations text
);


ALTER TABLE public.procedures OWNER TO neir;

--
-- Name: procedures_id_seq; Type: SEQUENCE; Schema: public; Owner: neir
--

CREATE SEQUENCE public.procedures_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.procedures_id_seq OWNER TO neir;

--
-- Name: procedures_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neir
--

ALTER SEQUENCE public.procedures_id_seq OWNED BY public.procedures.id;


--
-- Name: teeth; Type: TABLE; Schema: public; Owner: neir
--

CREATE TABLE public.teeth (
    id integer NOT NULL,
    tooth_number character varying(10) NOT NULL,
    description text
);


ALTER TABLE public.teeth OWNER TO neir;

--
-- Name: teeth_id_seq; Type: SEQUENCE; Schema: public; Owner: neir
--

CREATE SEQUENCE public.teeth_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.teeth_id_seq OWNER TO neir;

--
-- Name: teeth_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neir
--

ALTER SEQUENCE public.teeth_id_seq OWNED BY public.teeth.id;


--
-- Name: treatment_materials; Type: TABLE; Schema: public; Owner: neir
--

CREATE TABLE public.treatment_materials (
    treatment_id integer NOT NULL,
    material_id integer NOT NULL,
    quantity numeric(10,2) NOT NULL
);


ALTER TABLE public.treatment_materials OWNER TO neir;

--
-- Name: treatment_plans; Type: TABLE; Schema: public; Owner: neir
--

CREATE TABLE public.treatment_plans (
    id integer NOT NULL,
    patient_id integer NOT NULL,
    dentist_id integer NOT NULL,
    start_date date NOT NULL,
    end_date date,
    status character varying(50)
);


ALTER TABLE public.treatment_plans OWNER TO neir;

--
-- Name: treatment_plans_id_seq; Type: SEQUENCE; Schema: public; Owner: neir
--

CREATE SEQUENCE public.treatment_plans_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.treatment_plans_id_seq OWNER TO neir;

--
-- Name: treatment_plans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neir
--

ALTER SEQUENCE public.treatment_plans_id_seq OWNED BY public.treatment_plans.id;


--
-- Name: treatments; Type: TABLE; Schema: public; Owner: neir
--

CREATE TABLE public.treatments (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    cost numeric(10,2)
);


ALTER TABLE public.treatments OWNER TO neir;

--
-- Name: treatments_audit; Type: TABLE; Schema: public; Owner: neir
--

CREATE TABLE public.treatments_audit (
    id bigint NOT NULL,
    treatment_id bigint NOT NULL,
    action public.audit_action DEFAULT 'INSERT'::public.audit_action NOT NULL,
    changed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    changed_by character varying(255) DEFAULT 'Admin'::character varying NOT NULL,
    before_data jsonb,
    after_data jsonb
);


ALTER TABLE public.treatments_audit OWNER TO neir;

--
-- Name: treatments_audit_id_seq; Type: SEQUENCE; Schema: public; Owner: neir
--

CREATE SEQUENCE public.treatments_audit_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.treatments_audit_id_seq OWNER TO neir;

--
-- Name: treatments_audit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neir
--

ALTER SEQUENCE public.treatments_audit_id_seq OWNED BY public.treatments_audit.id;


--
-- Name: treatments_id_seq; Type: SEQUENCE; Schema: public; Owner: neir
--

CREATE SEQUENCE public.treatments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.treatments_id_seq OWNER TO neir;

--
-- Name: treatments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neir
--

ALTER SEQUENCE public.treatments_id_seq OWNED BY public.treatments.id;


--
-- Name: appointments id; Type: DEFAULT; Schema: public; Owner: neir
--

ALTER TABLE ONLY public.appointments ALTER COLUMN id SET DEFAULT nextval('public.appointments_id_seq'::regclass);


--
-- Name: dental_histories id; Type: DEFAULT; Schema: public; Owner: neir
--

ALTER TABLE ONLY public.dental_histories ALTER COLUMN id SET DEFAULT nextval('public.dental_histories_id_seq'::regclass);


--
-- Name: dental_labs id; Type: DEFAULT; Schema: public; Owner: neir
--

ALTER TABLE ONLY public.dental_labs ALTER COLUMN id SET DEFAULT nextval('public.dental_labs_id_seq'::regclass);


--
-- Name: dentists id; Type: DEFAULT; Schema: public; Owner: neir
--

ALTER TABLE ONLY public.dentists ALTER COLUMN id SET DEFAULT nextval('public.dentists_id_seq'::regclass);


--
-- Name: materials id; Type: DEFAULT; Schema: public; Owner: neir
--

ALTER TABLE ONLY public.materials ALTER COLUMN id SET DEFAULT nextval('public.materials_id_seq'::regclass);


--
-- Name: materials_audit id; Type: DEFAULT; Schema: public; Owner: neir
--

ALTER TABLE ONLY public.materials_audit ALTER COLUMN id SET DEFAULT nextval('public.materials_audit_id_seq'::regclass);


--
-- Name: patients id; Type: DEFAULT; Schema: public; Owner: neir
--

ALTER TABLE ONLY public.patients ALTER COLUMN id SET DEFAULT nextval('public.patients_id_seq'::regclass);


--
-- Name: payments id; Type: DEFAULT; Schema: public; Owner: neir
--

ALTER TABLE ONLY public.payments ALTER COLUMN id SET DEFAULT nextval('public.payments_id_seq'::regclass);


--
-- Name: payments_audit id; Type: DEFAULT; Schema: public; Owner: neir
--

ALTER TABLE ONLY public.payments_audit ALTER COLUMN id SET DEFAULT nextval('public.payments_audit_id_seq'::regclass);


--
-- Name: procedures id; Type: DEFAULT; Schema: public; Owner: neir
--

ALTER TABLE ONLY public.procedures ALTER COLUMN id SET DEFAULT nextval('public.procedures_id_seq'::regclass);


--
-- Name: teeth id; Type: DEFAULT; Schema: public; Owner: neir
--

ALTER TABLE ONLY public.teeth ALTER COLUMN id SET DEFAULT nextval('public.teeth_id_seq'::regclass);


--
-- Name: treatment_plans id; Type: DEFAULT; Schema: public; Owner: neir
--

ALTER TABLE ONLY public.treatment_plans ALTER COLUMN id SET DEFAULT nextval('public.treatment_plans_id_seq'::regclass);


--
-- Name: treatments id; Type: DEFAULT; Schema: public; Owner: neir
--

ALTER TABLE ONLY public.treatments ALTER COLUMN id SET DEFAULT nextval('public.treatments_id_seq'::regclass);


--
-- Name: treatments_audit id; Type: DEFAULT; Schema: public; Owner: neir
--

ALTER TABLE ONLY public.treatments_audit ALTER COLUMN id SET DEFAULT nextval('public.treatments_audit_id_seq'::regclass);


--
-- Data for Name: appointments; Type: TABLE DATA; Schema: public; Owner: neir
--

COPY public.appointments (id, patient_id, dentist_id, date_time, reason) FROM stdin;
1	1	1	2024-01-15 09:00:00	Consulta inicial endodoncia
2	2	2	2024-01-15 10:30:00	Evaluación ortodóncica
3	3	3	2024-01-15 14:00:00	Extracción molar
4	4	4	2024-01-16 08:30:00	Limpieza periodontal
5	5	5	2024-01-16 11:00:00	Impresión para prótesis
6	6	6	2024-01-16 15:30:00	Control odontopediátrico
7	7	7	2024-01-17 09:15:00	Colocación implante
8	8	8	2024-01-17 13:45:00	Blanqueamiento dental
9	9	9	2024-01-18 10:00:00	Radiografía panorámica
10	10	10	2024-01-18 16:00:00	Biopsia lesión oral
11	11	11	2024-01-19 08:00:00	Rehabilitación completa
12	12	12	2024-01-19 11:30:00	Control general
13	13	13	2024-01-22 14:30:00	Cirugía maxilofacial
14	14	14	2024-01-22 09:45:00	Ajuste brackets
15	15	15	2024-01-23 15:00:00	Tratamiento conducto
16	16	16	2024-01-23 10:15:00	Curetaje periodontal
17	17	17	2024-01-24 12:00:00	Mantenimiento implante
18	18	18	2024-01-24 16:30:00	Carillas estéticas
19	19	19	2024-01-25 08:45:00	TAC dental
20	20	20	2024-01-25 14:15:00	Estudio histopatológico
21	21	21	2024-01-26 11:00:00	Prótesis total
22	22	22	2024-01-26 13:30:00	Fluorización
23	23	23	2024-01-29 09:30:00	Injerto óseo
24	24	24	2024-01-29 15:45:00	Retiro brackets
25	25	25	2024-01-30 10:30:00	Apexificación
26	26	26	2024-01-30 12:45:00	Cirugía periodontal
27	27	27	2024-01-31 14:00:00	Prótesis sobre implantes
28	28	28	2024-01-31 16:15:00	Microabrasión
29	29	29	2024-02-01 08:30:00	Cefalometría
30	30	30	2024-02-01 11:15:00	Citología oral
31	31	31	2024-02-02 13:00:00	Corona cerámica
32	32	32	2024-02-02 15:30:00	Profilaxis
33	33	33	2024-02-05 09:00:00	Frenectomía
34	34	34	2024-02-05 10:45:00	Expansión maxilar
35	35	35	2024-02-06 12:15:00	Pulpotomía
36	36	36	2024-02-06 14:30:00	Raspado radicular
37	37	37	2024-02-07 16:00:00	Carga inmediata
38	38	38	2024-02-07 08:15:00	Resina estética
39	39	39	2024-02-08 10:00:00	Ortopantomografía
40	40	40	2024-02-08 13:45:00	Inmunohistoquímica
41	41	41	2024-02-09 11:30:00	Puente fijo
42	42	42	2024-02-09 15:00:00	Selladores
43	43	43	2024-02-12 09:15:00	Elevación seno maxilar
44	44	44	2024-02-12 14:45:00	Contención ortodóncica
45	45	45	2024-02-13 10:30:00	Recubrimiento pulpar
46	46	46	2024-02-13 12:00:00	Injerto gingival
47	47	47	2024-02-14 16:30:00	Ataches locator
48	48	48	2024-02-14 08:00:00	Facetas laminadas
49	49	49	2024-02-15 11:45:00	Tomografía computarizada
50	50	50	2024-02-15 13:15:00	Marcadores tumorales
51	51	51	2024-02-16 14:30:00	Incrustación cerámica
52	52	52	2024-02-16 16:00:00	Aplicación flúor
53	53	53	2024-02-19 08:45:00	Distracción osteogénica
54	54	54	2024-02-19 10:15:00	Disyunción maxilar
55	55	55	2024-02-20 12:30:00	Apicoectomía
56	56	56	2024-02-20 15:45:00	Colgajo periodontal
57	57	57	2024-02-21 09:30:00	All-on-4
58	58	58	2024-02-21 11:00:00	Composite directo
59	59	59	2024-02-22 13:30:00	Resonancia magnética
60	60	60	2024-02-22 16:15:00	PCR viral
61	61	61	2024-02-23 08:30:00	Prótesis híbrida
62	62	62	2024-02-23 10:45:00	Barniz fluorado
63	63	63	2024-02-26 14:00:00	Osteotomía sagital
64	64	64	2024-02-26 15:30:00	Aparato funcional
65	65	65	2024-02-27 09:00:00	Hemisección
66	66	66	2024-02-27 11:15:00	Regeneración tisular
67	67	67	2024-02-28 12:45:00	Implante zigomático
68	68	68	2024-02-28 16:30:00	Infiltración resina
69	69	69	2024-02-29 08:15:00	Gammagrafía ósea
70	70	70	2024-02-29 10:00:00	Cultivo bacteriano
71	71	71	2024-03-01 13:15:00	Sobredentadura
72	72	72	2024-03-01 15:00:00	Cepillado supervisado
73	73	73	2024-03-04 09:45:00	Mentoplastia
74	74	74	2024-03-04 11:30:00	Lip bumper
75	75	75	2024-03-05 14:15:00	Obturación retrógrada
76	76	76	2024-03-05 16:00:00	Plasma rico plaquetas
77	77	77	2024-03-06 08:00:00	Mini implantes
78	78	78	2024-03-06 10:30:00	Microabrasión química
79	79	79	2024-03-07 12:00:00	Artroscopia ATM
80	80	80	2024-03-07 14:45:00	Antibiograma
81	81	81	2024-03-08 11:15:00	Telescópica
82	82	82	2024-03-08 13:30:00	Educación higiene
83	83	83	2024-03-11 15:45:00	Le Fort I
84	84	84	2024-03-11 08:30:00	Quad helix
85	85	85	2024-03-12 10:15:00	MTA apical
86	86	86	2024-03-12 12:30:00	Membrana reabsorbible
87	87	87	2024-03-13 16:15:00	Implante pterigoides
88	88	88	2024-03-13 09:00:00	Stratificación composite
89	89	89	2024-03-14 11:30:00	PET-CT
90	90	90	2024-03-14 14:00:00	Genotipado bacteriano
91	91	91	2024-03-15 15:30:00	Bar-clip
92	92	92	2024-03-15 17:00:00	Remineralización
93	93	93	2024-03-18 08:45:00	Sagital split
94	94	94	2024-03-18 10:00:00	Pendulum
95	95	95	2024-03-19 12:15:00	Revascularización pulpar
96	96	96	2024-03-19 14:30:00	Factor crecimiento
97	97	97	2024-03-20 16:45:00	Implante basal
98	98	98	2024-03-20 08:15:00	Icon infiltrante
99	99	99	2024-03-21 10:45:00	Artrocentesis
100	100	100	2024-03-21 13:00:00	Secuenciación genética
101	101	1	2024-03-22 15:15:00	Control endodoncia
102	102	2	2024-03-22 16:30:00	Seguimiento ortodoncia
103	103	3	2024-03-25 09:30:00	Post-operatorio
104	104	4	2024-03-25 11:00:00	Mantenimiento periodontal
105	105	5	2024-03-26 13:45:00	Ajuste prótesis
106	106	6	2024-03-26 15:00:00	Fluorización infantil
107	107	7	2024-03-27 08:30:00	Control implante
108	108	8	2024-03-27 10:15:00	Retoque estético
109	109	9	2024-03-28 12:30:00	Control radiográfico
110	110	10	2024-03-28 14:15:00	Resultado biopsia
111	111	11	2024-03-29 16:00:00	Seguimiento rehabilitación
112	112	12	2024-03-29 17:15:00	Consulta general
113	113	13	2024-04-01 09:00:00	Control post-quirúrgico
114	114	14	2024-04-01 10:45:00	Cambio arcos
115	115	15	2024-04-02 12:00:00	Seguimiento endodoncia
116	116	16	2024-04-02 13:30:00	Evaluación periodontal
117	117	17	2024-04-03 15:45:00	Carga protésica
118	118	18	2024-04-03 08:00:00	Pulido carillas
119	119	19	2024-04-04 10:30:00	Interpretación imágenes
120	120	20	2024-04-04 12:15:00	Informe patológico
121	121	21	2024-04-05 14:30:00	Ajuste prótesis total
122	122	22	2024-04-05 16:00:00	Revisión general
123	123	23	2024-04-08 08:45:00	Control injerto
124	124	24	2024-04-08 10:00:00	Retención ortodóncica
125	125	25	2024-04-09 11:45:00	Control apexificación
126	126	26	2024-04-09 13:15:00	Sutura periodontal
127	127	27	2024-04-10 15:30:00	Activación prótesis
128	128	28	2024-04-10 08:30:00	Evaluación estética
129	129	29	2024-04-11 10:15:00	Análisis cefalométrico
130	130	30	2024-04-11 12:45:00	Resultado citología
131	131	31	2024-04-12 14:00:00	Cementado corona
132	132	32	2024-04-12 15:45:00	Profilaxis trimestral
133	133	33	2024-04-15 09:15:00	Control frenectomía
134	134	34	2024-04-15 11:00:00	Activación expansor
135	135	35	2024-04-16 13:30:00	Control pulpotomía
136	136	36	2024-04-16 15:00:00	Evaluación raspado
137	137	37	2024-04-17 16:30:00	Control carga
138	138	38	2024-04-17 08:15:00	Pulido resina
139	139	39	2024-04-18 10:00:00	Radiografía control
140	140	40	2024-04-18 12:30:00	Informe final
141	141	41	2024-04-19 14:45:00	Ajuste puente
142	142	42	2024-04-19 16:15:00	Control selladores
143	143	43	2024-04-22 08:00:00	Post elevación seno
144	144	44	2024-04-22 09:30:00	Cambio contención
145	145	45	2024-04-23 11:15:00	Control recubrimiento
146	146	46	2024-04-23 13:00:00	Cicatrización injerto
147	147	47	2024-04-24 15:15:00	Activación locator
148	148	48	2024-04-24 08:45:00	Control facetas
149	149	49	2024-04-25 10:30:00	Interpretación TC
150	150	50	2024-04-25 12:00:00	Resultado marcadores
151	151	51	2024-04-26 14:15:00	Cementado incrustación
152	152	52	2024-04-26 15:45:00	Aplicación flúor
153	153	53	2024-04-29 09:00:00	Control distracción
154	154	54	2024-04-29 10:45:00	Seguimiento disyunción
155	155	55	2024-04-30 12:30:00	Post apicoectomía
156	156	56	2024-04-30 14:00:00	Control colgajo
157	157	57	2024-05-01 16:00:00	Mantenimiento All-on-4
158	158	58	2024-05-01 08:30:00	Pulido composite
159	159	59	2024-05-02 10:15:00	Interpretación RM
160	160	60	2024-05-02 12:45:00	Resultado PCR
161	161	61	2024-05-03 14:30:00	Ajuste híbrida
162	162	62	2024-05-03 16:15:00	Reaplicación barniz
163	163	63	2024-05-06 08:15:00	Post osteotomía
164	164	64	2024-05-06 09:45:00	Ajuste funcional
165	165	65	2024-05-07 11:30:00	Control hemisección
166	166	66	2024-05-07 13:15:00	Seguimiento regeneración
167	167	67	2024-05-08 15:00:00	Control zigomático
168	168	68	2024-05-08 08:00:00	Control infiltración
169	169	69	2024-05-09 10:30:00	Resultado gammagrafía
170	170	70	2024-05-09 12:15:00	Resultado cultivo
171	171	71	2024-05-10 14:00:00	Ajuste sobredentadura
172	172	72	2024-05-10 15:30:00	Refuerzo higiene
173	173	73	2024-05-13 09:30:00	Post mentoplastia
174	174	74	2024-05-13 11:00:00	Control lip bumper
175	175	75	2024-05-14 13:15:00	Control obturación
176	176	76	2024-05-14 14:45:00	Aplicación PRP
177	177	77	2024-05-15 16:30:00	Control mini implantes
178	178	78	2024-05-15 08:15:00	Post microabrasión
179	179	79	2024-05-16 10:00:00	Control artroscopia
180	180	80	2024-05-16 11:45:00	Resultado antibiograma
181	181	81	2024-05-17 13:30:00	Ajuste telescópica
182	182	82	2024-05-17 15:00:00	Refuerzo educación
183	183	83	2024-05-20 08:45:00	Post Le Fort
184	184	84	2024-05-20 10:15:00	Activación quad helix
185	185	85	2024-05-21 12:00:00	Control MTA
186	186	86	2024-05-21 13:45:00	Seguimiento membrana
187	187	87	2024-05-22 15:30:00	Control pterigoides
188	188	88	2024-05-22 08:30:00	Pulido estratificación
189	189	89	2024-05-23 10:45:00	Resultado PET-CT
190	190	90	2024-05-23 12:30:00	Informe genotipado
191	191	91	2024-05-24 14:15:00	Activación bar-clip
192	192	92	2024-05-24 16:00:00	Control remineralización
193	193	93	2024-05-27 09:00:00	Post sagital split
194	194	94	2024-05-27 10:30:00	Activación pendulum
195	195	95	2024-05-28 12:15:00	Control revascularización
196	196	96	2024-05-28 14:00:00	Aplicación factor
197	197	97	2024-05-29 15:45:00	Control basal
198	198	98	2024-05-29 08:00:00	Post Icon
199	199	99	2024-05-30 10:15:00	Control artrocentesis
200	200	100	2024-05-30 11:30:00	Resultado secuenciación
\.


--
-- Data for Name: dental_histories; Type: TABLE DATA; Schema: public; Owner: neir
--

COPY public.dental_histories (id, patient_id, anamnesis) FROM stdin;
1	1	Paciente con antecedentes de caries múltiples. Sensibilidad dental ocasional.
2	2	Historial de ortodoncia en la adolescencia. Buena higiene oral actual.
3	3	Periodontitis leve tratada anteriormente. Control regular necesario.
4	4	Sin antecedentes relevantes. Primera consulta odontológica en años.
5	5	Bruxismo nocturno. Usa protector bucal desde hace 2 años.
6	6	Alergico a la penicilina. Antecedentes de abscesos dentales.
7	7	Embarazada (segundo trimestre). Gingivitis del embarazo.
8	8	Diabético tipo 2. Cicatrización lenta. Requiere profilaxis antibiótica.
9	9	Fumadora social. Manchas por tabaco en dientes anteriores.
10	10	Hipertensión arterial controlada con medicamentos. Sin contraindicaciones.
11	11	Paciente joven con excelente higiene oral. Consulta de rutina.
12	12	Antecedentes familiares de enfermedad periodontal. Profilaxis preventiva.
13	13	Tratamiento de conducto previo en molar superior derecho.
14	14	Paciente con ansiedad dental. Requiere sedación consciente.
15	15	Ortodoncia interceptiva en la infancia. Seguimiento ortodóncico.
16	16	Síndrome de boca seca por medicación. Fluorización tópica.
17	17	Antecedentes de traumatismo dental en incisivo central.
18	18	Paciente geriátrico con prótesis parcial superior.
19	19	Halitosis crónica por enfermedad periodontal.
20	20	Primera consulta. Sin antecedentes patológicos relevantes.
21	21	Caries recurrente bajo restauraciones antiguas.
22	22	Maloclusión clase II. Candidato para ortodoncia.
23	23	Paciente con cardiopatía. Requiere profilaxis antibiótica.
24	24	Fluorosis dental leve. Tratamiento estético indicado.
25	25	Antecedentes de cirugía maxilofacial por quiste.
26	26	Paciente con trastorno de la ATM. Férula de descarga.
27	27	Hipoplasia del esmalte en molares permanentes.
28	28	Gingivitis crónica por higiene deficiente.
29	29	Paciente con implantes dentales. Control periimplantario.
30	30	Sensibilidad dental generalizada post-blanqueamiento.
31	31	Antecedentes de quimioterapia. Mucositis oral previa.
32	32	Paciente con epilepsia. Hiperplasia gingival por fenitoína.
33	33	Caries de biberón en dentición temporal.
34	34	Paciente deportista con protector bucal personalizado.
35	35	Antecedentes de bulimia. Erosión dental en palatino.
36	36	Xerostomía por radioterapia en cabeza y cuello.
37	37	Paciente con síndrome de Down. Enfermedad periodontal precoz.
38	38	Antecedentes de labio y paladar hendido reparado.
39	39	Paciente con trastorno bipolar. Xerostomía por medicación.
40	40	Caries rampante en paciente con alto consumo de azúcar.
41	41	Antecedentes de accidente cerebrovascular. Parálisis facial leve.
42	42	Paciente con artritis reumatoide. Síndrome de Sjögren.
43	43	Melanoma oral tratado. Seguimiento oncológico.
44	44	Paciente con VIH. Candidiasis oral recurrente.
45	45	Antecedentes de cirugía ortognática bimaxilar.
46	46	Paciente con insuficiencia renal. Osteodistrofia renal.
47	47	Caries cervicales múltiples por reflujo gastroesofágico.
48	48	Paciente con trasplante de órgano. Inmunosupresión.
49	49	Antecedentes de neuralgia del trigémino.
50	50	Paciente con osteoporosis. Riesgo de osteonecrosis por bifosfonatos.
51	51	Síndrome de burning mouth. Tratamiento sintomático.
52	52	Paciente con marcapasos. Precauciones con electrocirugía.
53	53	Antecedentes de leucoplasia oral. Seguimiento estricto.
54	54	Paciente con hemofilia. Protocolo de coagulación.
55	55	Caries interproximales múltiples. Dieta cariogénica.
56	56	Paciente con enfermedad de Crohn. Aftas recurrentes.
57	57	Antecedentes de fractura mandibular. Secuela de maloclusión.
58	58	Paciente con síndrome de apnea del sueño.
59	59	Gingivitis descamativa crónica. Estudio inmunológico pendiente.
60	60	Paciente con diabetes gestacional. Control estricto.
61	61	Antecedentes de radioterapia oral. Trismo residual.
62	62	Paciente con enfermedad celíaca. Defectos del esmalte.
63	63	Síndrome de boca seca por síndrome de Sjögren.
64	64	Paciente con trastorno de ansiedad generalizada.
65	65	Antecedentes de osteosarcoma mandibular tratado.
66	66	Paciente con lupus eritematoso sistémico.
67	67	Caries de superficie radicular en paciente geriátrico.
68	68	Paciente con válvula cardíaca protésica.
69	69	Antecedentes de liquen plano oral erosivo.
70	70	Paciente con cirrosis hepática. Alteraciones hemostáticas.
71	71	Síndrome de disfunción temporomandibular bilateral.
72	72	Paciente con enfermedad de Parkinson. Dificultad motora.
73	73	Antecedentes de carcinoma escamocelular oral.
74	74	Paciente con esclerosis múltiple. Neuralgia atípica.
75	75	Caries recurrente por síndrome de boca seca.
76	76	Paciente con transplante de médula ósea.
77	77	Antecedentes de osteomielitis mandibular crónica.
78	78	Paciente con fibromialgia. Síndrome de boca ardiente.
79	79	Gingivitis ulceronecrotizante aguda tratada.
80	80	Paciente con enfermedad de Alzheimer inicial.
81	81	Antecedentes de granuloma piógeno recurrente.
82	82	Paciente con síndrome de Down. Periodontitis agresiva.
83	83	Caries múltiples por síndrome de Sjögren.
84	84	Paciente con enfermedad de Behçet. Úlceras aftosas.
85	85	Antecedentes de ameloblastoma mandibular resecado.
86	86	Paciente con artritis psoriásica. Xerostomía.
87	87	Síndrome de Eagle. Proceso estiloideo elongado.
88	88	Paciente con miastenia gravis. Fatiga muscular.
89	89	Antecedentes de angina de Ludwig tratada.
90	90	Paciente con polimialgia reumática.
91	91	Caries rampante por xerostomía inducida por fármacos.
92	92	Paciente con síndrome antifosfolípido.
93	93	Antecedentes de mucocele del labio inferior.
94	94	Paciente con enfermedad de Addison.
95	95	Gingivitis hiperplásica por bloqueadores de calcio.
96	96	Paciente con síndrome de Marfan. Alto riesgo cardiovascular.
97	97	Antecedentes de tumor de glándulas salivales.
98	98	Paciente con porfiria. Fotosensibilidad extrema.
99	99	Síndrome de boca seca por antihistamínicos crónicos.
100	100	Paciente con enfermedad de Wilson. Anillo de Kayser-Fleischer.
101	101	Antecedentes de absceso cerebral odontógeno.
102	102	Paciente con síndrome de Ehlers-Danlos.
103	103	Caries cervicales por erosión ácida ocupacional.
104	104	Paciente con acromegalia. Prognatismo mandibular.
105	105	Antecedentes de osteonecrosis de maxilares.
106	106	Paciente con síndrome de Cushing.
107	107	Gingivitis medicamentosa por ciclosporina.
108	108	Paciente con enfermedad de Huntington.
109	109	Antecedentes de fibroma osificante central.
110	110	Paciente con síndrome de Turner. Microretrognatia.
111	111	Caries múltiples por síndrome de alcoholismo.
112	112	Paciente con enfermedad de Graves. Osteoporosis.
113	113	Antecedentes de quiste dentígero enucleado.
114	114	Paciente con síndrome de Klinefelter.
115	115	Síndrome de burning tongue por menopausia.
116	116	Paciente con enfermedad de Paget ósea.
117	117	Antecedentes de displasia fibrosa maxilar.
118	118	Paciente con síndrome de Williams.
119	119	Caries interproximales por diabetes mal controlada.
120	120	Paciente con enfermedad de Gaucher.
121	121	Antecedentes de tumor odontogénico adenomatoide.
122	122	Paciente con síndrome de Prader-Willi.
123	123	Gingivitis crónica por inmunodeficiencia primaria.
124	124	Paciente con enfermedad de Fabry.
125	125	Antecedentes de granuloma central de células gigantes.
126	126	Paciente con síndrome de McCune-Albright.
127	127	Caries rampante por síndrome de Plummer-Vinson.
128	128	Paciente con enfermedad de Niemann-Pick.
129	129	Antecedentes de mixoma odontogénico resecado.
130	130	Paciente con síndrome de Gorlin-Goltz.
131	131	Síndrome de disfunción craneomandibular crónica.
132	132	Paciente con enfermedad de Tay-Sachs.
133	133	Antecedentes de ameloblastoma uniquístico.
134	134	Paciente con síndrome de Treacher Collins.
135	135	Caries múltiples por síndrome de malabsorción.
136	136	Paciente con enfermedad de Pompe.
137	137	Antecedentes de tumor de Warthin parotídeo.
138	138	Paciente con síndrome de Angelman.
139	139	Gingivitis ulcerativa por neutropenia cíclica.
140	140	Paciente con enfermedad de Krabbe.
141	141	Antecedentes de quiste nasopalatino infectado.
142	142	Paciente con síndrome de Rett.
143	143	Caries cervicales por reflujo laringofaríngeo.
144	144	Paciente con enfermedad de Alexander.
145	145	Antecedentes de fibroma cemento-osificante.
146	146	Paciente con síndrome de Rubinstein-Taybi.
147	147	Síndrome de boca seca por radioterapia facial.
148	148	Paciente con enfermedad de Canavan.
149	149	Antecedentes de tumor neuroectodérmico primitivo.
150	150	Paciente con síndrome de Smith-Magenis.
151	151	Caries múltiples por síndrome de Fanconi.
152	152	Paciente con enfermedad de Pelizaeus-Merzbacher.
153	153	Antecedentes de hemangioma cavernoso oral.
154	154	Paciente con síndrome de Wolf-Hirschhorn.
155	155	Gingivitis crónica por déficit de adhesión leucocitaria.
156	156	Paciente con enfermedad de Leigh.
157	157	Antecedentes de linfangioma quístico cervical.
158	158	Paciente con síndrome de Jacobsen.
159	159	Caries interproximales por xerostomía idiopática.
160	160	Paciente con enfermedad de Zellweger.
161	161	Antecedentes de schwannoma del nervio facial.
162	162	Paciente con síndrome de Beckwith-Wiedemann.
163	163	Síndrome de Eagle con calcificación ligamento estilohioideo.
164	164	Paciente con enfermedad de Refsum.
165	165	Antecedentes de neurofibroma plexiforme facial.
166	166	Paciente con síndrome de Sotos.
167	167	Caries rampante por síndrome de Sjögren secundario.
168	168	Paciente con enfermedad de Batten.
169	169	Antecedentes de lipoma del suelo de boca.
170	170	Paciente con síndrome de Charge.
171	171	Gingivitis medicamentosa por antiepilépticos.
172	172	Paciente con enfermedad de Sandhoff.
173	173	Antecedentes de rabdomioma cardíaco con manifestaciones orales.
174	174	Paciente con síndrome de Cornelia de Lange.
175	175	Caries múltiples por hiposalivación neurogénica.
176	176	Paciente con enfermedad de Metachromatic leukodystrophy.
177	177	Antecedentes de hamartoma fibromatoso infantil.
178	178	Paciente con síndrome de Velocardiofacial.
179	179	Síndrome de boca ardiente post-menopáusico.
180	180	Paciente con enfermedad de Hurler.
181	181	Antecedentes de tumor glómico yugulotimpánico.
182	182	Paciente con síndrome de Miller-Dieker.
183	183	Caries cervicales por erosión química ocupacional.
184	184	Paciente con enfermedad de Hunter.
185	185	Antecedentes de paraganglioma carotídeo.
186	186	Paciente con síndrome de Cri-du-chat.
187	187	Gingivitis crónica por síndrome de hiper-IgE.
188	188	Paciente con enfermedad de Sanfilippo.
189	189	Antecedentes de tumor carcinoide del intestino medio.
190	190	Paciente con síndrome de DiGeorge.
191	191	Carias múltiples por síndrome de Bardet-Biedl.
192	192	Paciente con enfermedad de Morquio.
193	193	Antecedentes de feocromocitoma con crisis hipertensivas.
194	194	Paciente con síndrome de Kabuki.
195	195	Síndrome de disfunción temporomandibular post-traumática.
196	196	Paciente con enfermedad de Maroteaux-Lamy.
197	197	Antecedentes de insulinoma pancreático.
198	198	Paciente con síndrome de Noonan.
199	199	Caries interproximales por hipoplasia del esmalte hereditaria.
200	200	Paciente con enfermedad de Sly. Manifestaciones craneofaciales.
\.


--
-- Data for Name: dental_labs; Type: TABLE DATA; Schema: public; Owner: neir
--

COPY public.dental_labs (id, name, phone, address) FROM stdin;
1	Laboratorio Dental Sonrisa	555-1001	Calle 50 #25-30
2	Lab Dental Perfección	555-1002	Carrera 15 #40-20
3	Laboratorio Estética Oral	555-1003	Avenida 68 #35-15
4	Lab Dental Innovación	555-1004	Calle 85 #20-40
5	Laboratorio Oral Design	555-1005	Carrera 30 #50-25
6	Lab Dental Premium	555-1006	Avenida 127 #45-30
7	Laboratorio Dental Elite	555-1007	Calle 100 #35-20
8	Lab Oral Excellence	555-1008	Carrera 45 #60-15
9	Laboratorio Dental Master	555-1009	Avenida 170 #25-35
10	Lab Dental Precision	555-1010	Calle 134 #40-25
11	Laboratorio Dental Arte	555-1011	Carrera 68 #45-18
12	Lab Smile Perfect	555-1012	Avenida 19 #30-25
13	Laboratorio Odonto Técnico	555-1013	Calle 26 #50-40
14	Lab Dental Creativo	555-1014	Carrera 11 #25-35
15	Laboratorio Protésico Ideal	555-1015	Avenida 68 #40-20
16	Lab Oral Estético	555-1016	Calle 72 #35-15
17	Laboratorio Dental Moderno	555-1017	Carrera 7 #60-30
18	Lab Técnico Dental	555-1018	Avenida 39 #45-25
19	Laboratorio Smile Design	555-1019	Calle 53 #20-40
20	Lab Dental Avanzado	555-1020	Carrera 24 #35-18
21	Laboratorio Oral Rehabilitación	555-1021	Avenida 68 #25-35
22	Lab Dental Especializado	555-1022	Calle 85 #50-20
23	Laboratorio Protésico Central	555-1023	Carrera 13 #40-45
24	Lab Estética Dental	555-1024	Avenida 127 #30-15
25	Laboratorio Dental Integral	555-1025	Calle 100 #45-25
26	Lab Oral Técnico	555-1026	Carrera 45 #35-40
27	Laboratorio Dental Digital	555-1027	Avenida 170 #20-30
28	Lab Smile Technology	555-1028	Calle 134 #50-15
29	Laboratorio Protésico Avanzado	555-1029	Carrera 68 #25-35
30	Lab Dental Profesional	555-1030	Avenida 19 #40-20
31	Laboratorio Oral Especialistas	555-1031	Calle 26 #35-45
32	Lab Técnico Moderno	555-1032	Carrera 11 #20-30
33	Laboratorio Dental Experto	555-1033	Avenida 68 #50-25
34	Lab Estética Avanzada	555-1034	Calle 72 #30-15
35	Laboratorio Protésico Elite	555-1035	Carrera 7 #45-40
36	Lab Dental Contemporáneo	555-1036	Avenida 39 #25-35
37	Laboratorio Smile Art	555-1037	Calle 53 #40-18
38	Lab Oral Innovación	555-1038	Carrera 24 #35-20
39	Laboratorio Dental Premium Plus	555-1039	Avenida 68 #20-45
40	Lab Técnico Especializado	555-1040	Calle 85 #50-30
41	Laboratorio Protésico Superior	555-1041	Carrera 13 #25-15
42	Lab Estética Oral Plus	555-1042	Avenida 127 #45-35
43	Laboratorio Dental Excellence	555-1043	Calle 100 #30-40
44	Lab Smile Professional	555-1044	Carrera 45 #40-25
45	Laboratorio Oral Master	555-1045	Avenida 170 #35-18
46	Lab Dental High Tech	555-1046	Calle 134 #20-30
47	Laboratorio Protésico Moderno	555-1047	Carrera 68 #50-15
48	Lab Técnico Dental Plus	555-1048	Avenida 19 #25-45
49	Laboratorio Estética Premium	555-1049	Calle 26 #40-35
50	Lab Oral Design Studio	555-1050	Carrera 11 #35-20
51	Laboratorio Dental Artístico	555-1051	Avenida 68 #20-25
52	Lab Smile Creativo	555-1052	Calle 72 #45-40
53	Laboratorio Protésico Integral	555-1053	Carrera 7 #30-35
54	Lab Dental Técnico Avanzado	555-1054	Avenida 39 #50-18
55	Laboratorio Oral Estético Plus	555-1055	Calle 53 #25-30
56	Lab Protésico Digital	555-1056	Carrera 24 #40-15
57	Laboratorio Dental Contemporáneo	555-1057	Avenida 68 #35-45
58	Lab Smile Innovation	555-1058	Calle 85 #20-25
59	Laboratorio Técnico Oral	555-1059	Carrera 13 #50-40
60	Lab Estética Dental Moderna	555-1060	Avenida 127 #25-35
61	Laboratorio Protésico Profesional	555-1061	Calle 100 #45-18
62	Lab Oral Excellence Plus	555-1062	Carrera 45 #30-30
63	Laboratorio Dental Especializado	555-1063	Avenida 170 #40-15
64	Lab Técnico Premium	555-1064	Calle 134 #35-25
65	Laboratorio Smile Design Studio	555-1065	Carrera 68 #20-45
66	Lab Protésico Arte	555-1066	Avenida 19 #50-30
67	Laboratorio Dental Master Plus	555-1067	Calle 26 #25-40
68	Lab Estética Oral Avanzada	555-1068	Carrera 11 #45-35
69	Laboratorio Técnico Moderno Plus	555-1069	Avenida 68 #30-18
70	Lab Dental Digital Plus	555-1070	Calle 72 #40-20
71	Laboratorio Protésico Excellence	555-1071	Carrera 7 #35-25
72	Lab Smile Técnico	555-1072	Avenida 39 #20-45
73	Laboratorio Oral Profesional	555-1073	Calle 53 #50-30
74	Lab Dental Arte Plus	555-1074	Carrera 24 #25-40
75	Laboratorio Estético Integral	555-1075	Avenida 68 #45-35
76	Lab Protésico Superior Plus	555-1076	Calle 85 #30-18
77	Laboratorio Técnico Especializado	555-1077	Carrera 13 #40-20
78	Lab Oral Design Plus	555-1078	Avenida 127 #35-25
79	Laboratorio Dental High Quality	555-1079	Calle 100 #20-45
80	Lab Smile Excellence	555-1080	Carrera 45 #50-30
81	Laboratorio Protésico Artístico	555-1081	Avenida 170 #25-40
82	Lab Técnico Dental Moderno	555-1082	Calle 134 #45-35
83	Laboratorio Estética Plus	555-1083	Carrera 68 #30-18
84	Lab Oral Técnico Plus	555-1084	Avenida 19 #40-20
85	Laboratorio Dental Premium Studio	555-1085	Calle 26 #35-25
86	Lab Protésico Digital Plus	555-1086	Carrera 11 #20-45
87	Laboratorio Smile Master	555-1087	Avenida 68 #50-30
88	Lab Técnico Oral Plus	555-1088	Calle 72 #25-40
89	Laboratorio Dental Excellence Studio	555-1089	Carrera 7 #45-35
90	Lab Estética Premium Plus	555-1090	Avenida 39 #30-18
91	Laboratorio Protésico Master	555-1091	Calle 53 #40-20
92	Lab Oral Innovation Plus	555-1092	Carrera 24 #35-25
93	Laboratorio Dental Arte Studio	555-1093	Avenida 68 #20-45
94	Lab Técnico Superior	555-1094	Calle 85 #50-30
95	Laboratorio Smile Professional Plus	555-1095	Carrera 13 #25-40
96	Lab Protésico Contemporáneo	555-1096	Avenida 127 #45-35
97	Laboratorio Estético Master	555-1097	Calle 100 #30-18
98	Lab Oral Excellence Studio	555-1098	Carrera 45 #40-20
99	Laboratorio Dental Digital Studio	555-1099	Avenida 170 #35-25
100	Lab Técnico Premium Plus	555-1100	Calle 134 #20-45
101	Laboratorio Protésico Innovation	555-1101	Carrera 68 #50-30
102	Lab Smile Design Master	555-1102	Avenida 19 #25-40
103	Laboratorio Dental Artístico Plus	555-1103	Calle 26 #45-35
104	Lab Estética Oral Studio	555-1104	Carrera 11 #30-18
105	Laboratorio Técnico Excellence	555-1105	Avenida 68 #40-20
106	Lab Protésico Arte Plus	555-1106	Calle 72 #35-25
107	Laboratorio Oral Master Plus	555-1107	Carrera 7 #20-45
108	Lab Dental Premium Excellence	555-1108	Avenida 39 #50-30
109	Laboratorio Smile Técnico Plus	555-1109	Calle 53 #25-40
110	Lab Estético Professional	555-1110	Carrera 24 #45-35
111	Laboratorio Protésico Digital Studio	555-1111	Avenida 68 #30-18
112	Lab Técnico Dental Excellence	555-1112	Calle 85 #40-20
113	Laboratorio Oral Design Master	555-1113	Carrera 13 #35-25
114	Lab Dental Innovation Studio	555-1114	Avenida 127 #20-45
115	Laboratorio Smile Arte	555-1115	Calle 100 #50-30
116	Lab Protésico Premium Studio	555-1116	Carrera 45 #25-40
117	Laboratorio Estética Excellence Plus	555-1117	Avenida 170 #45-35
118	Lab Técnico Oral Studio	555-1118	Calle 134 #30-18
119	Laboratorio Dental Master Studio	555-1119	Carrera 68 #40-20
120	Lab Oral Premium Plus	555-1120	Avenida 19 #35-25
121	Laboratorio Protésico Excellence Studio	555-1121	Calle 26 #20-45
122	Lab Smile Innovation Studio	555-1122	Carrera 11 #50-30
123	Laboratorio Técnico Digital	555-1123	Avenida 68 #25-40
124	Lab Estética Master Plus	555-1124	Calle 72 #45-35
125	Laboratorio Dental Arte Excellence	555-1125	Carrera 7 #30-18
126	Lab Protésico Superior Studio	555-1126	Avenida 39 #40-20
127	Laboratorio Oral Técnico Studio	555-1127	Calle 53 #35-25
128	Lab Dental Premium Master	555-1128	Carrera 24 #20-45
129	Laboratorio Smile Excellence Studio	555-1129	Avenida 68 #50-30
130	Lab Técnico Arte Plus	555-1130	Calle 85 #25-40
131	Laboratorio Estético Innovation	555-1131	Carrera 13 #45-35
132	Lab Protésico Master Plus	555-1132	Avenida 127 #30-18
133	Laboratorio Oral Excellence Master	555-1133	Calle 100 #40-20
134	Lab Dental Digital Excellence	555-1134	Carrera 45 #35-25
135	Laboratorio Smile Premium Studio	555-1135	Avenida 170 #20-45
136	Lab Técnico Professional Plus	555-1136	Calle 134 #50-30
137	Laboratorio Protésico Arte Studio	555-1137	Carrera 68 #25-40
138	Lab Estética Digital Plus	555-1138	Avenida 19 #45-35
139	Laboratorio Dental Superior Plus	555-1139	Calle 26 #30-18
140	Lab Oral Master Studio	555-1140	Carrera 11 #40-20
141	Laboratorio Técnico Excellence Plus	555-1141	Avenida 68 #35-25
142	Lab Protésico Innovation Studio	555-1142	Calle 72 #20-45
143	Laboratorio Smile Master Studio	555-1143	Carrera 7 #50-30
144	Lab Dental Arte Master	555-1144	Avenida 39 #25-40
145	Laboratorio Estético Premium Studio	555-1145	Calle 53 #45-35
146	Lab Técnico Digital Studio	555-1146	Carrera 24 #30-18
147	Laboratorio Oral Arte Plus	555-1147	Avenida 68 #40-20
148	Lab Protésico Excellence Master	555-1148	Calle 85 #35-25
149	Laboratorio Dental Innovation Plus	555-1149	Carrera 13 #20-45
150	Lab Smile Digital Studio	555-1150	Avenida 127 #50-30
151	Laboratorio Técnico Master Studio	555-1151	Calle 100 #25-40
152	Lab Estética Excellence Master	555-1152	Carrera 45 #45-35
153	Laboratorio Protésico Premium Plus	555-1153	Avenida 170 #30-18
154	Lab Oral Digital Plus	555-1154	Calle 134 #40-20
155	Laboratorio Dental Excellence Master	555-1155	Carrera 68 #35-25
156	Lab Técnico Arte Studio	555-1156	Avenida 19 #20-45
157	Laboratorio Smile Superior Plus	555-1157	Calle 26 #50-30
158	Lab Protésico Master Studio	555-1158	Carrera 11 #25-40
159	Laboratorio Estético Digital Studio	555-1159	Avenida 68 #45-35
160	Lab Oral Premium Studio	555-1160	Calle 72 #30-18
161	Laboratorio Dental Digital Master	555-1161	Carrera 7 #40-20
162	Lab Técnico Excellence Studio	555-1162	Avenida 39 #35-25
163	Laboratorio Protésico Arte Master	555-1163	Calle 53 #20-45
164	Lab Smile Innovation Master	555-1164	Carrera 24 #50-30
165	Laboratorio Estética Superior Studio	555-1165	Avenida 68 #25-40
166	Lab Oral Excellence Digital	555-1166	Calle 85 #45-35
167	Laboratorio Dental Premium Digital	555-1167	Carrera 13 #30-18
168	Lab Técnico Master Plus	555-1168	Avenida 127 #40-20
169	Laboratorio Protésico Digital Master	555-1169	Calle 100 #35-25
170	Lab Smile Excellence Master	555-1170	Carrera 45 #20-45
171	Laboratorio Estético Arte Plus	555-1171	Avenida 170 #50-30
172	Lab Oral Innovation Master	555-1172	Calle 134 #25-40
173	Laboratorio Dental Arte Digital	555-1173	Carrera 68 #45-35
174	Lab Técnico Premium Studio	555-1174	Avenida 19 #30-18
175	Laboratorio Protésico Excellence Digital	555-1175	Calle 26 #40-20
176	Lab Oral Master Digital	555-1176	Carrera 11 #35-25
177	Laboratorio Smile Premium Master	555-1177	Avenida 68 #20-45
178	Lab Estética Digital Master	555-1178	Calle 72 #50-30
179	Laboratorio Dental Superior Studio	555-1179	Carrera 7 #25-40
180	Lab Técnico Arte Master	555-1180	Avenida 39 #45-35
181	Laboratorio Protésico Innovation Master	555-1181	Calle 53 #30-18
182	Lab Oral Excellence Plus Master	555-1182	Carrera 24 #40-20
183	Laboratorio Dental Premium Excellence	555-1183	Avenida 68 #35-25
184	Lab Smile Digital Master	555-1184	Calle 85 #20-45
185	Laboratorio Estético Excellence Digital	555-1185	Carrera 13 #50-30
186	Lab Técnico Digital Master	555-1186	Avenida 127 #25-40
187	Laboratorio Protésico Superior Master	555-1187	Calle 100 #45-35
188	Lab Oral Arte Master	555-1188	Carrera 45 #30-18
189	Laboratorio Dental Innovation Master	555-1189	Avenida 170 #40-20
190	Lab Smile Arte Digital	555-1190	Calle 134 #35-25
191	Laboratorio Estético Premium Master	555-1191	Carrera 68 #20-45
192	Lab Técnico Excellence Master	555-1192	Avenida 19 #50-30
193	Laboratorio Protésico Digital Excellence	555-1193	Calle 26 #25-40
194	Lab Oral Premium Master	555-1194	Carrera 11 #45-35
195	Laboratorio Dental Excellence Digital	555-1195	Avenida 68 #30-18
196	Lab Smile Superior Master	555-1196	Calle 72 #40-20
197	Laboratorio Técnico Premium Master	555-1197	Carrera 7 #35-25
198	Lab Estética Innovation Master	555-1198	Avenida 39 #20-45
199	Laboratorio Protésico Arte Excellence	555-1199	Calle 53 #50-30
200	Lab Oral Digital Excellence	555-1200	Carrera 24 #25-40
\.


--
-- Data for Name: dentists; Type: TABLE DATA; Schema: public; Owner: neir
--

COPY public.dentists (id, first_name, last_name, specialty) FROM stdin;
1	Dr. Juan Carlos	Mendoza	Endodoncia
2	Dra. María Elena	Rodríguez	Ortodoncia
3	Dr. José Luis	García	Cirugía Oral
4	Dra. Ana Patricia	López	Periodoncia
5	Dr. Carlos Alberto	Martínez	Prostodoncia
6	Dra. Laura Cristina	González	Odontopediatría
7	Dr. Pedro Antonio	Hernández	Implantología
8	Dra. Sandra Milena	Jiménez	Estética Dental
9	Dr. Miguel Ángel	Torres	Radiología Oral
10	Dra. Carmen Rosa	Flores	Patología Oral
11	Dr. Roberto Carlos	Morales	Rehabilitación Oral
12	Dra. Lucía Andrea	Castro	Odontología General
13	Dr. Fernando José	Ruiz	Cirugía Maxilofacial
14	Dra. Patricia Elena	Vargas	Ortodoncia
15	Dr. Antonio Miguel	Mendoza	Endodoncia
16	Dra. Elena Sofía	Peña	Periodoncia
17	Dr. Raúl Eduardo	Ortega	Prostodoncia
18	Dra. Gloria Isabel	Ramos	Odontopediatría
19	Dr. Jorge Luis	Silva	Implantología
20	Dra. Mónica Alejandra	Gutiérrez	Estética Dental
21	Dr. Diego Fernando	Herrera	Radiología Oral
22	Dra. Cristina Marcela	Medina	Patología Oral
23	Dr. Alejandro José	Sandoval	Rehabilitación Oral
24	Dra. Beatriz Elena	Vega	Odontología General
25	Dr. Francisco Javier	Delgado	Cirugía Maxilofacial
26	Dra. Isabel Cristina	Romero	Ortodoncia
27	Dr. Javier Andrés	Aguilar	Endodoncia
28	Dra. Rosa María	Cortés	Periodoncia
29	Dr. Sergio Alejandro	Navarro	Prostodoncia
30	Dra. Adriana Paola	Molina	Odontopediatría
31	Dr. Guillermo César	Espinoza	Implantología
32	Dra. Valeria Fernanda	Campos	Estética Dental
33	Dr. Ricardo Enrique	Lara	Radiología Oral
34	Dra. Natalia Andrea	Guerrero	Patología Oral
35	Dr. Andrés Felipe	Cabrera	Rehabilitación Oral
36	Dra. Silvia Patricia	Paredes	Odontología General
37	Dr. Héctor Manuel	Rojas	Cirugía Maxilofacial
38	Dra. Teresa Isabel	Figueroa	Ortodoncia
39	Dr. Eduardo Ramón	Soto	Endodoncia
40	Dra. Pilar Mercedes	Contreras	Periodoncia
41	Dr. Álvaro Gustavo	Reyes	Prostodoncia
42	Dra. Marina Soledad	León	Odontopediatría
43	Dr. Iván Esteban	Muñoz	Implantología
44	Dra. Claudia Beatriz	Fuentes	Estética Dental
45	Dr. Óscar Hernán	Carrillo	Radiología Oral
46	Dra. Lorena Marcela	Ibáñez	Patología Oral
47	Dr. Ramón Augusto	Palacios	Rehabilitación Oral
48	Dra. Alicia Elena	Moreno	Odontología General
49	Dr. Tomás Alberto	Vera	Cirugía Maxilofacial
50	Dra. Gabriela Inés	Salas	Ortodoncia
51	Dr. Arturo Benito	Prieto	Endodoncia
52	Dra. Marta Liliana	Acosta	Periodoncia
53	Dr. Pablo Nicolás	Benítez	Prostodoncia
54	Dra. Victoria Eugenia	Castillo	Odontopediatría
55	Dr. Víctor Hugo	Peláez	Implantología
56	Dra. Carolina Amparo	Mendez	Estética Dental
57	Dr. Rubén Darío	Velasco	Radiología Oral
58	Dra. Amparo Lucía	Cárdenas	Patología Oral
59	Dr. Emilio Rafael	Blanco	Rehabilitación Oral
60	Dra. Nuria Esperanza	Domínguez	Odontología General
61	Dr. Gonzalo Patricio	Pascual	Cirugía Maxilofacial
62	Dra. Esperanza Gloria	Gil	Ortodoncia
63	Dr. Alfredo Ignacio	Caballero	Endodoncia
64	Dra. Remedios Carmen	Moya	Periodoncia
65	Dr. Esteban Aurelio	Rubio	Prostodoncia
66	Dra. Consuelo Pilar	Gallego	Odontopediatría
67	Dr. Ignacio Sebastián	Marín	Implantología
68	Dra. Dolores Inmaculada	Pastor	Estética Dental
69	Dr. Enrique Julio	Carmona	Radiología Oral
70	Dra. Inmaculada Mercedes	Serrano	Patología Oral
71	Dr. Julio Nicolás	Vázquez	Rehabilitación Oral
72	Dra. Mercedes Rosario	Martín	Odontología General
73	Dr. Nicolás Samuel	Santana	Cirugía Maxilofacial
74	Dra. Rosario Soledad	Hidalgo	Ortodoncia
75	Dr. Samuel Teodoro	Lorenzo	Endodoncia
76	Dra. Soledad Úrsula	Morales	Periodoncia
77	Dr. Teodoro Vicente	Vidal	Prostodoncia
78	Dra. Úrsula Ximena	Roca	Odontopediatría
79	Dr. Vicente Yolanda	Calvo	Implantología
80	Dra. Ximena Zacarías	Santos	Estética Dental
81	Dr. Yolanda Abel	Iglesias	Radiología Oral
82	Dra. Zacarías Adela	Ferrer	Patología Oral
83	Dr. Abel Bruno	Herrero	Rehabilitación Oral
84	Dra. Adela Carla	Suárez	Odontología General
85	Dr. Bruno Daniel	Ortiz	Cirugía Maxilofacial
86	Dra. Carla Eva	Vicente	Ortodoncia
87	Dr. Daniel Fabián	Esteban	Endodoncia
88	Dra. Eva Gema	Román	Periodoncia
89	Dr. Fabián Hugo	Santiago	Prostodoncia
90	Dra. Gema Irene	Garrido	Odontopediatría
91	Dr. Hugo Jaime	Lozano	Implantología
92	Dra. Irene Karina	Cano	Estética Dental
93	Dr. Jaime Lorenzo	Nieto	Radiología Oral
94	Dra. Karina Maite	Guerrero	Patología Oral
95	Dr. Lorenzo Néstor	Pascual	Rehabilitación Oral
96	Dra. Maite Olga	Duran	Odontología General
97	Dr. Néstor Pablo	Cabrera	Cirugía Maxilofacial
98	Dra. Olga Quique	Moreno	Ortodoncia
99	Dr. Pablo Rebeca	Vega	Endodoncia
100	Dra. Quique Sebastián	Torres	Periodoncia
101	Dr. Rebeca Tamara	Flores	Prostodoncia
102	Dra. Sebastián Ulises	Castro	Odontopediatría
103	Dr. Tamara Verónica	Ruiz	Implantología
104	Dra. Ulises Walter	Vargas	Estética Dental
105	Dr. Verónica Xavier	Mendoza	Radiología Oral
106	Dra. Walter Yanet	Peña	Patología Oral
107	Dr. Xavier Zoe	Ortega	Rehabilitación Oral
108	Dra. Yanet Agustín	Ramos	Odontología General
109	Dr. Zoe Belén	Silva	Cirugía Maxilofacial
110	Dra. Agustín César	Gutiérrez	Ortodoncia
111	Dr. Belén Diana	Herrera	Endodoncia
112	Dra. César Emilio	Medina	Periodoncia
113	Dr. Diana Fátima	Sandoval	Prostodoncia
114	Dra. Emilio Germán	Vega	Odontopediatría
115	Dr. Fátima Hilda	Delgado	Implantología
116	Dra. Germán Ismael	Romero	Estética Dental
117	Dr. Hilda Julia	Aguilar	Radiología Oral
118	Dra. Ismael Kevin	Cortés	Patología Oral
119	Dr. Julia Lola	Navarro	Rehabilitación Oral
120	Dra. Kevin Mario	Molina	Odontología General
121	Dr. Lola Nora	Espinoza	Cirugía Maxilofacial
122	Dra. Mario Omar	Campos	Ortodoncia
123	Dr. Nora Paloma	Lara	Endodoncia
124	Dra. Omar Quintín	Guerrero	Periodoncia
125	Dr. Paloma Rita	Cabrera	Prostodoncia
126	Dra. Quintín Simón	Paredes	Odontopediatría
127	Dr. Rita Tania	Rojas	Implantología
128	Dra. Simón Ulrico	Figueroa	Estética Dental
129	Dr. Tania Vanesa	Soto	Estética Dental
130	Dra. Ulrico Wilson	Contreras	Radiología Oral
131	Dr. Vanesa Ximara	Reyes	Patología Oral
132	Dra. Wilson Yago	León	Rehabilitación Oral
133	Dr. Ximara Zulma	Muñoz	Odontología General
134	Dra. Yago Aurelio	Fuentes	Cirugía Maxilofacial
135	Dr. Zulma Bárbara	Carrillo	Ortodoncia
136	Dra. Aurelio Camilo	Ibáñez	Endodoncia
137	Dr. Bárbara Delia	Palacios	Periodoncia
138	Dra. Camilo Evaristo	Moreno	Prostodoncia
139	Dr. Delia Flora	Vera	Odontopediatría
140	Dra. Evaristo Gaspar	Salas	Implantología
141	Dr. Flora Hortensia	Prieto	Estética Dental
142	Dra. Gaspar Inocencio	Acosta	Radiología Oral
143	Dr. Hortensia Jacinta	Benítez	Patología Oral
144	Dra. Inocencio Kleber	Castillo	Rehabilitación Oral
145	Dr. Jacinta Leonor	Peláez	Odontología General
146	Dra. Kleber Maximiliano	Mendez	Cirugía Maxilofacial
147	Dr. Leonor Nicanor	Velasco	Ortodoncia
148	Dra. Maximiliano Obdulia	Cárdenas	Endodoncia
149	Dr. Nicanor Pancracio	Blanco	Periodoncia
150	Dra. Obdulia Quiteria	Domínguez	Prostodoncia
151	Dr. Pancracio Romualdo	Pascual	Odontopediatría
152	Dra. Quiteria Saturnina	Gil	Implantología
153	Dr. Romualdo Telesforo	Caballero	Estética Dental
154	Dra. Saturnina Urbano	Moya	Radiología Oral
155	Dr. Telesforo Visitación	Rubio	Patología Oral
156	Dra. Urbano Wenceslao	Gallego	Rehabilitación Oral
157	Dr. Visitación Xerez	Marín	Odontología General
158	Dra. Wenceslao Yolanda	Pastor	Cirugía Maxilofacial
159	Dr. Xerez Zoilo	Carmona	Ortodoncia
160	Dra. Yolanda Abundio	Serrano	Endodoncia
161	Dr. Zoilo Brígida	Vázquez	Periodoncia
162	Dra. Abundio Casimiro	Martín	Prostodoncia
163	Dr. Brígida Delfina	Santana	Odontopediatría
164	Dra. Casimiro Eustaquio	Hidalgo	Implantología
165	Dr. Delfina Florencia	Lorenzo	Estética Dental
166	Dra. Eustaquio Gaudencio	Morales	Radiología Oral
167	Dr. Florencia Herminia	Vidal	Patología Oral
168	Dra. Gaudencio Isidro	Roca	Rehabilitación Oral
169	Dr. Herminia Jacoba	Calvo	Odontología General
170	Dra. Isidro Leandro	Santos	Cirugía Maxilofacial
171	Dr. Jacoba Modesto	Iglesias	Ortodoncia
172	Dra. Leandro Nemesio	Ferrer	Endodoncia
173	Dr. Modesto Otilia	Herrero	Periodoncia
174	Dra. Nemesio Plácido	Suárez	Prostodoncia
175	Dr. Otilia Querubín	Ortiz	Odontopediatría
176	Dra. Plácido Ruperto	Vicente	Implantología
177	Dr. Querubín Servando	Esteban	Estética Dental
178	Dra. Ruperto Tiburcio	Román	Radiología Oral
179	Dr. Servando Ubaldo	Santiago	Patología Oral
180	Dra. Tiburcio Venancia	Garrido	Rehabilitación Oral
181	Dr. Ubaldo Wilibaldo	Lozano	Odontología General
182	Dra. Venancia Xenia	Cano	Cirugía Maxilofacial
183	Dr. Wilibaldo Yesenia	Nieto	Ortodoncia
184	Dra. Xenia Zenón	Guerrero	Endodoncia
185	Dr. Yesenia Apolinar	Pascual	Periodoncia
186	Dra. Zenón Bonifacio	Duran	Prostodoncia
187	Dr. Apolinar Candelaria	Cabrera	Odontopediatría
188	Dra. Bonifacio Desiderio	Moreno	Implantología
189	Dr. Candelaria Epifanio	Vega	Estética Dental
190	Dra. Desiderio Filomena	Torres	Radiología Oral
191	Dr. Epifanio Genaro	Flores	Patología Oral
192	Dra. Filomena Hipólito	Castro	Rehabilitación Oral
193	Dr. Genaro Imelda	Ruiz	Odontología General
194	Dra. Hipólito Jeremías	Vargas	Cirugía Maxilofacial
195	Dr. Imelda Ladislao	Mendoza	Ortodoncia
196	Dra. Jeremías Macario	Peña	Endodoncia
197	Dr. Ladislao Nicomedes	Ortega	Periodoncia
198	Dra. Macario Olegario	Ramos	Prostodoncia
199	Dr. Nicomedes Prudencio	Silva	Odontopediatría
200	Dra. Olegario Quintana	Gutiérrez	Implantología
\.


--
-- Data for Name: materials; Type: TABLE DATA; Schema: public; Owner: neir
--

COPY public.materials (id, name, description, stock) FROM stdin;
1	Gutapercha	Material de obturación endodóntica	1000
2	Cemento endodóntico	Sellador de conductos	50
3	Resina compuesta A2	Resina color A2 universal	200
4	Resina compuesta A3	Resina color A3 universal	180
5	Brackets metálicos	Brackets de acero inoxidable	500
6	Arcos ortodóncicos NiTi	Arcos de níquel titanio	100
7	Implantes titanio 4.1x10	Implantes de titanio grado 4	25
8	Coronas zirconio	Coronas prefabricadas zirconio	30
9	Anestésico lidocaína	Lidocaína al 2% con epinefrina	200
10	Dique de goma	Aislamiento absoluto	500
11	Resina compuesta B1	Resina color B1 clara	150
12	Resina compuesta C2	Resina color C2 grisácea	120
13	Amalgama dental	Aleación de plata para obturación	300
14	Ionómero de vidrio	Material restaurador bioactivo	80
15	Composite fotocurable	Resina activada por luz	250
16	Brackets cerámicos	Brackets estéticos transparentes	200
17	Arcos de acero	Arcos ortodóncicos convencionales	150
18	Ligaduras elásticas	Gomas para brackets colores	2000
19	Cadenas elásticas	Cadenas continuas ortodóncicas	100
20	Implantes 3.7x8	Implantes de diámetro reducido	20
21	Implantes 4.7x12	Implantes para zona posterior	18
22	Pilares de cicatrización	Conformadores gingivales	50
23	Pilares protésicos	Aditamentos para coronas	40
24	Tornillos protésicos	Fijación de restauraciones	100
25	Coronas metal-cerámica	Coronas con base metálica	25
26	Coronas de porcelana	Coronas completamente cerámicas	20
27	Prótesis acrílicas	Bases de dentaduras	15
28	Dientes artificiales	Dientes para prótesis	500
29	Cementos temporales	Fijación provisional	60
30	Cementos definitivos	Cementado permanente	45
31	Ácido fosfórico	Grabador de esmalte	100
32	Adhesivo dental	Sistema de unión	80
33	Primer dental	Promotor de adhesión	70
34	Selladores de fisuras	Prevención de caries	90
35	Flúor tópico	Barniz de fluoruro	120
36	Flúor gel	Aplicación en cubetas	80
37	Pasta profiláctica	Limpieza y pulido	200
38	Copas de goma	Instrumentos de pulido	300
39	Cepillos de profilaxis	Limpieza interproximal	250
40	Hilo dental	Higiene interproximal	1000
41	Revelador de placa	Evidenciador bacteriano	50
42	Antiséptico bucal	Enjuague desinfectante	150
43	Gasas estériles	Material hemostático	500
44	Algodón en rollo	Aislamiento relativo	300
45	Eyectores de saliva	Aspiración intraoral	1000
46	Baberos desechables	Protección del paciente	2000
47	Guantes de látex	Protección del operador	2000
48	Mascarillas quirúrgicas	Protección respiratoria	1000
49	Gorros desechables	Protección capilar	500
50	Jeringas desechables	Aplicación de anestesia	200
51	Agujas dentales	Infiltración anestésica	500
52	Carpules anestésicos	Cartuchos de anestésico	300
53	Vasoconstrictor	Epinefrina 1:100000	100
54	Anestésico sin vaso	Mepivacaína 3%	50
55	Anestésico tópico	Gel anestésico benzocaína	30
56	Hilos de sutura	Seda negra 3-0	100
57	Hilos reabsorbibles	Vicryl 4-0	80
58	Tijeras quirúrgicas	Instrumental de corte	10
59	Pinzas hemostáticas	Control de sangrado	15
60	Elevadores dentales	Luxación de dientes	20
61	Fórceps superiores	Extracción dientes superiores	25
62	Fórceps inferiores	Extracción dientes inferiores	25
63	Curetas periodontales	Raspado subgingival	30
64	Sondas periodontales	Medición de bolsas	20
65	Espejos bucales	Visualización intraoral	50
66	Exploradores dentales	Diagnóstico de caries	40
67	Excavadores de caries	Remoción de tejido cariado	35
68	Aplicadores desechables	Colocación de materiales	1000
69	Matrices metálicas	Conformación de restauraciones	200
70	Cuñas de madera	Separación dental	500
71	Porta matrices	Sujeción de matrices	10
72	Lámpara de polimerización	Activación de resinas	3
73	Turbina dental	Alta velocidad	5
74	Micromotor	Baja velocidad	5
75	Fresas de diamante	Preparación cavitaria	200
76	Fresas de carburo	Eliminación de dentina	150
77	Fresas de acabado	Pulido de restauraciones	100
78	Discos de pulido	Acabado interproximal	300
79	Copas de pulido	Pulido oclusal	100
80	Puntas de silicona	Pulido final	200
81	Pasta de pulir	Brillo final	50
82	Separadores orthodóncicos	Espacios interdentales	500
83	Botones orthodóncicos	Tracción dental	100
84	Gomas intermaxilares	Elásticos orthodóncicos	1000
85	Tubos molares	Anclaje orthodóncico	100
86	Bandas orthodóncicas	Cementado en molares	200
87	Cemento para bandas	Fijación orthodóncica	20
88	Ceras orthodóncicas	Protección mucosa	100
89	Arcos preformados	Nivellación inicial	50
90	Arcos de finalización	Detallado orthodóncico	30
91	Retenedores fijos	Alambre lingual	50
92	Retenedores removibles	Hawley modificado	20
93	Expansores palatinos	Disyunción maxilar	10
94	Máscaras faciales	Tracción maxilar	5
95	Aparatos funcionales	Orthodóncia interceptiva	8
96	Lip bumpers	Protección labial	12
97	Péndulums	Distalización molar	6
98	Quad helix	Expansión posterior	8
99	Biomateriales óseos	Injerto particulado	30
100	Membranas reabsorbibles	Regeneración tisular	25
101	Membranas no reabsorbibles	Barrera permanente	15
102	Plasma rico plaquetas	Factor crecimiento	20
103	Factores crecimiento	PDGF recombinante	10
104	Colágeno inyectable	Relleno de defectos	15
105	Ácido hialurónico	Viscosuplemento	12
106	Hidroxiapatita	Sustituto óseo	25
107	Beta fosfato tricálcico	Material osteoconductivo	20
108	Sulfato de calcio	Barrera reabsorbible	18
109	Matriz ósea desmineralizada	DBM particulado	15
110	Hueso autólogo	Injerto del propio paciente	10
111	Hueso alogénico	Banco de huesos	12
112	Hueso xenogénico	Origen bovino	20
113	Titanio grado 2	Implantes premium	15
114	Titanio grado 4	Implantes estándar	25
115	Aleación Ti-6Al-4V	Implantes de alta resistencia	10
116	Superficie SLA	Tratamiento de superficie	20
117	Superficie anodizada	Implantes con color	15
118	Conexión externa	Hexágono externo	30
119	Conexión interna	Cono morse	25
120	Mini implantes	Orthodóncia temporal	40
121	Implantes cigomáticos	Fijación maxilar atrófica	5
122	Implantes pterigoideos	Anclaje posterior	8
123	Localizador apical	Endometría electrónica	2
124	Limas K	Instrumentación manual	200
125	Limas H	Ensanchamiento radicular	150
126	Limas rotatorias	Sistema mecanizado	100
127	Limas ProTaper	Conicidad variable	80
128	Limas WaveOne	Lima única	60
129	Irrigantes endodóncicos	Hipoclorito de sodio	100
130	EDTA 17%	Quelante de calcio	50
131	Clorhexidina 2%	Desinfectante radicular	40
132	Hidróxido de calcio	Medicación intraconducto	30
133	Formocresol	Fijador pulpar	20
134	MTA	Agregado trióxido mineral	15
135	Biodentine	Sustituto de dentina	12
136	Cementos biocerámicos	Sellado radicular	25
137	Puntas de papel	Secado de conductos	1000
138	Conos de gutapercha	Obturación radicular	2000
139	Espaciadores digitales	Condensación lateral	20
140	Pluggers	Condensación vertical	15
141	Obturadores System B	Técnica termoplástica	5
142	Jeringas de obturación	Gutapercha caliente	8
143	Puntas de obturación	Técnica de inyección	200
144	Radiografías periapicales	Películas tamaño 2	1000
145	Radiografías oclusales	Películas tamaño 4	200
146	Radiografías panorámicas	Película 15x30	100
147	Líquido revelador	Procesado manual	20
148	Líquido fijador	Procesado radiográfico	20
149	Placas digitales	Sensores intraorales	5
150	Posicionadores	Paralelización radiográfica	50
151	Protectores plomados	Radioprotección	10
152	Baberos plomados	Protección corporal	8
153	Protectores tiroideos	Protección específica	15
154	Dosímetros personales	Control de radiación	20
155	Marcadores radiográficos	Identificación de zonas	100
156	Revelado automático	Químicos máquina	10
157	Montaje radiográfico	Cartulinas porta películas	200
158	Negatoscopio	Visualización radiográfica	2
159	Lupas de aumento	Magnificación clínica	5
160	Microscopio dental	Alta magnificación	1
161	Cámaras intraorales	Documentación clínica	3
162	Monitores dentales	Visualización digital	3
163	Software de gestión	Historia clínica digital	1
164	Impresora láser	Documentos clínicos	2
165	Escáner intraoral	Impresiones digitales	1
166	Fresadora CAD-CAM	Manufactura digital	1
167	Horno cerámico	Sinterización	1
168	Articulador semi-ajustable	Simulación oclusal	3
169	Arco facial	Registro maxilar	2
170	Vibrador de yeso	Eliminación de burbujas	1
171	Yeso piedra	Modelos de estudio	100
172	Yeso para troquel	Modelos de trabajo	50
173	Alginato	Impresiones preliminares	80
174	Silicona condensación	Impresiones definitivas	60
175	Silicona adición	Alta precisión	40
176	Poliéter	Impresiones rígidas	30
177	Pasta zinquenólica	Impresiones funcionales	20
178	Ceras de impresión	Registros oclusales	50
179	Cubetas metálicas	Impresiones superiores	20
180	Cubetas plásticas	Impresiones inferiores	25
181	Cubetas individuales	Impresiones personalizadas	15
182	Adhesivo para cubetas	Fijación de materiales	30
183	Vaselina	Aislante	20
184	Separador de yeso	Anti-adherente	25
185	Cera rosa	Confección de prótesis	30
186	Cera pegajosa	Retención temporal	15
187	Godiva	Cera termoplástica	10
188	Resina acrílica	Bases protésicas	40
189	Monómero acrílico	Polimerización	20
190	Catalizador	Activador químico	15
191	Fibra de vidrio	Refuerzo protésico	25
192	Retenedores plásticos	Prótesis parciales	100
193	Ganchos metálicos	Retención en dientes	50
194	Conectores mayores	Estructura protésica	20
195	Apoyos oclusales	Descanso protésico	30
196	Dientes de porcelana	Estética superior	200
197	Dientes de resina	Económicos	300
198	Encía artificial	Estética gingival	50
199	Caracterizadores	Pigmentos estéticos	30
200	Pinceles artísticos	Aplicación de color	20
201	Espátulas de cera	Modelado	15
202	Mecheros Bunsen	Calentamiento	2
203	Crisoles cerámicos	Colado metálico	10
204	Revestimientos	Moldes de colado	30
205	Aleaciones nobles	Oro para coronas	5
206	Aleaciones base	Níquel-cromo	20
207	Aleaciones titanio	Biocompatibilidad	15
208	Soldadura dental	Unión metálica	10
209	Flux dental	Fundente para soldadura	8
210	Ácido fluorhídrico	Grabado cerámico	5
211	Silanos	Adhesión a cerámica	10
212	Opacos cerámicos	Enmascaramiento metálico	15
213	Dentina cerámica	Cuerpo de la restauración	25
214	Esmalte cerámico	Capa externa	20
215	Glaze cerámico	Brillo final	15
216	Stains cerámicos	Caracterización	20
\.


--
-- Data for Name: materials_audit; Type: TABLE DATA; Schema: public; Owner: neir
--

COPY public.materials_audit (id, materials_id, action, changed_at, changed_by, before_data, after_data) FROM stdin;
\.


--
-- Data for Name: patients; Type: TABLE DATA; Schema: public; Owner: neir
--

COPY public.patients (id, first_name, last_name, birth_date, phone, address) FROM stdin;
1	Ana	García	1985-03-15	555-0001	Calle 1 #10-20
2	Carlos	López	1990-07-22	555-0002	Carrera 5 #25-30
3	María	Rodríguez	1978-11-08	555-0003	Avenida 10 #40-15
4	José	Martínez	1982-05-12	555-0004	Calle 8 #30-25
5	Laura	González	1995-09-18	555-0005	Carrera 12 #50-10
6	Pedro	Hernández	1987-01-25	555-0006	Avenida 15 #20-35
7	Sandra	Jiménez	1992-12-03	555-0007	Calle 20 #15-40
8	Miguel	Torres	1980-06-30	555-0008	Carrera 25 #35-20
9	Carmen	Flores	1988-04-14	555-0009	Avenida 30 #45-15
10	Roberto	Morales	1975-08-20	555-0010	Calle 35 #25-30
11	Lucía	Castro	1993-02-28	555-0011	Carrera 40 #10-25
12	Fernando	Ruiz	1984-10-05	555-0012	Avenida 45 #30-40
13	Patricia	Vargas	1991-03-17	555-0013	Calle 50 #20-15
14	Antonio	Mendoza	1979-07-12	555-0014	Carrera 55 #40-35
15	Elena	Peña	1986-11-24	555-0015	Avenida 60 #15-25
16	Raúl	Ortega	1994-01-08	555-0016	Calle 65 #35-20
17	Gloria	Ramos	1983-09-21	555-0017	Carrera 70 #25-40
18	Jorge	Silva	1989-05-16	555-0018	Avenida 75 #45-30
19	Mónica	Gutiérrez	1977-12-10	555-0019	Calle 80 #30-15
20	Diego	Herrera	1996-06-23	555-0020	Carrera 85 #20-35
21	Cristina	Medina	1981-04-07	555-0021	Avenida 90 #40-25
22	Alejandro	Sandoval	1990-08-19	555-0022	Calle 95 #15-30
23	Beatriz	Vega	1985-02-14	555-0023	Carrera 100 #35-40
24	Francisco	Delgado	1987-10-26	555-0024	Avenida 105 #25-15
25	Isabel	Romero	1992-07-01	555-0025	Calle 110 #45-35
26	Javier	Aguilar	1978-03-29	555-0026	Carrera 115 #30-20
27	Rosa	Cortés	1994-11-15	555-0027	Avenida 120 #20-40
28	Sergio	Navarro	1982-09-02	555-0028	Calle 125 #40-25
29	Adriana	Molina	1988-01-18	555-0029	Carrera 130 #15-30
30	Guillermo	Espinoza	1975-05-24	555-0030	Avenida 135 #35-15
31	Valeria	Campos	1993-12-06	555-0031	Calle 140 #25-35
32	Ricardo	Lara	1986-08-11	555-0032	Carrera 145 #45-20
33	Natalia	Guerrero	1991-04-27	555-0033	Avenida 150 #30-40
34	Andrés	Cabrera	1984-06-13	555-0034	Calle 155 #20-25
35	Silvia	Paredes	1989-02-08	555-0035	Carrera 160 #40-30
36	Héctor	Rojas	1980-10-22	555-0036	Avenida 165 #15-35
37	Teresa	Figueroa	1995-07-17	555-0037	Calle 170 #35-40
38	Eduardo	Soto	1983-03-04	555-0038	Carrera 175 #25-15
39	Pilar	Contreras	1987-11-20	555-0039	Avenida 180 #45-25
40	Álvaro	Reyes	1976-01-15	555-0040	Calle 185 #30-35
41	Marina	León	1992-09-08	555-0041	Carrera 190 #20-30
42	Iván	Muñoz	1988-05-31	555-0042	Avenida 195 #40-20
43	Claudia	Fuentes	1985-12-17	555-0043	Calle 200 #15-40
44	Óscar	Carrillo	1990-06-04	555-0044	Carrera 205 #35-25
45	Lorena	Ibáñez	1979-02-21	555-0045	Avenida 210 #25-30
46	Ramón	Palacios	1994-08-07	555-0046	Calle 215 #45-15
47	Alicia	Moreno	1981-04-23	555-0047	Carrera 220 #30-40
48	Tomás	Vera	1986-12-09	555-0048	Avenida 225 #20-25
49	Gabriela	Salas	1993-10-14	555-0049	Calle 230 #40-35
50	Arturo	Prieto	1977-06-28	555-0050	Carrera 235 #15-20
51	Marta	Acosta	1991-01-12	555-0051	Avenida 240 #35-30
52	Pablo	Benítez	1984-09-25	555-0052	Calle 245 #25-40
53	Victoria	Castillo	1989-05-10	555-0053	Carrera 250 #45-35
54	Víctor	Peláez	1982-03-16	555-0054	Avenida 255 #30-15
55	Carolina	Mendez	1987-11-01	555-0055	Calle 260 #20-30
56	Rubén	Velasco	1996-07-18	555-0056	Carrera 265 #40-25
57	Amparo	Cárdenas	1978-01-03	555-0057	Avenida 270 #15-35
58	Emilio	Blanco	1992-09-19	555-0058	Calle 275 #35-20
59	Nuria	Domínguez	1985-05-05	555-0059	Carrera 280 #25-40
60	Gonzalo	Pascual	1990-12-21	555-0060	Avenida 285 #45-30
61	Esperanza	Gil	1983-08-14	555-0061	Calle 290 #30-15
62	Alfredo	Caballero	1988-04-30	555-0062	Carrera 295 #20-35
63	Remedios	Moya	1976-02-26	555-0063	Avenida 300 #40-20
64	Esteban	Rubio	1994-10-11	555-0064	Calle 305 #15-40
65	Consuelo	Gallego	1981-06-27	555-0065	Carrera 310 #35-25
66	Ignacio	Marín	1986-01-13	555-0066	Avenida 315 #25-30
67	Dolores	Pastor	1993-09-29	555-0067	Calle 320 #45-35
68	Enrique	Carmona	1979-05-15	555-0068	Carrera 325 #30-20
69	Inmaculada	Serrano	1991-03-02	555-0069	Avenida 330 #20-40
70	Julio	Vázquez	1984-11-18	555-0070	Calle 335 #40-15
71	Mercedes	Martín	1987-07-04	555-0071	Carrera 340 #15-30
72	Nicolás	Santana	1995-01-20	555-0072	Avenida 345 #35-25
73	Rosario	Hidalgo	1982-09-06	555-0073	Calle 350 #25-40
74	Samuel	Lorenzo	1989-05-22	555-0074	Carrera 355 #45-20
75	Soledad	Morales	1980-12-08	555-0075	Avenida 360 #30-35
76	Teodoro	Vidal	1992-08-24	555-0076	Calle 365 #20-30
77	Úrsula	Roca	1978-04-10	555-0077	Carrera 370 #40-15
78	Vicente	Calvo	1985-02-25	555-0078	Avenida 375 #15-35
79	Ximena	Santos	1990-10-12	555-0079	Calle 380 #35-40
80	Yolanda	Iglesias	1983-06-28	555-0080	Carrera 385 #25-20
81	Zacarías	Ferrer	1988-01-14	555-0081	Avenida 390 #45-30
82	Abel	Herrero	1976-09-30	555-0082	Calle 395 #30-25
83	Adela	Suárez	1993-05-16	555-0083	Carrera 400 #20-35
84	Bruno	Ortiz	1981-03-03	555-0084	Avenida 405 #40-40
85	Carla	Vicente	1987-11-19	555-0085	Calle 410 #15-15
86	Daniel	Esteban	1994-07-05	555-0086	Carrera 415 #35-30
87	Eva	Román	1986-01-21	555-0087	Avenida 420 #25-25
88	Fabián	Santiago	1991-09-07	555-0088	Calle 425 #45-40
89	Gema	Garrido	1979-05-23	555-0089	Carrera 430 #30-35
90	Hugo	Lozano	1984-12-09	555-0090	Avenida 435 #20-20
91	Irene	Cano	1989-08-26	555-0091	Calle 440 #40-30
92	Jaime	Nieto	1977-04-12	555-0092	Carrera 445 #15-25
93	Karina	Guerrero	1992-02-28	555-0093	Avenida 450 #35-35
94	Lorenzo	Pascual	1985-10-14	555-0094	Calle 455 #25-40
95	Maite	Duran	1990-06-01	555-0095	Carrera 460 #45-15
96	Néstor	Cabrera	1983-03-17	555-0096	Avenida 465 #30-30
97	Olga	Moreno	1988-11-03	555-0097	Calle 470 #20-25
98	Pablo	Vega	1975-07-20	555-0098	Carrera 475 #40-35
99	Quique	Torres	1993-01-06	555-0099	Avenida 480 #15-40
100	Rebeca	Flores	1981-09-22	555-0100	Calle 485 #35-20
101	Sebastián	Castro	1986-05-08	555-0101	Carrera 490 #25-30
102	Tamara	Ruiz	1994-12-24	555-0102	Avenida 495 #45-25
103	Ulises	Vargas	1982-08-10	555-0103	Calle 500 #30-40
104	Verónica	Mendoza	1987-04-26	555-0104	Carrera 505 #20-15
105	Walter	Peña	1991-02-13	555-0105	Avenida 510 #40-30
106	Xavier	Ortega	1978-10-29	555-0106	Calle 515 #15-35
107	Yanet	Ramos	1985-06-15	555-0107	Carrera 520 #35-25
108	Zoe	Silva	1990-01-31	555-0108	Avenida 525 #25-40
109	Agustín	Gutiérrez	1984-09-17	555-0109	Calle 530 #45-30
110	Belén	Herrera	1989-05-03	555-0110	Carrera 535 #30-15
111	César	Medina	1976-03-19	555-0111	Avenida 540 #20-35
112	Diana	Sandoval	1992-11-05	555-0112	Calle 545 #40-20
113	Emilio	Vega	1980-07-22	555-0113	Carrera 550 #15-40
114	Fátima	Delgado	1987-01-08	555-0114	Avenida 555 #35-25
115	Germán	Romero	1995-09-24	555-0115	Calle 560 #25-30
116	Hilda	Aguilar	1983-05-10	555-0116	Carrera 565 #45-35
117	Ismael	Cortés	1988-02-26	555-0117	Avenida 570 #30-40
118	Julia	Navarro	1979-12-13	555-0118	Calle 575 #20-15
119	Kevin	Molina	1991-08-29	555-0119	Carrera 580 #40-30
120	Lola	Espinoza	1986-04-15	555-0120	Avenida 585 #15-25
121	Mario	Campos	1994-02-01	555-0121	Calle 590 #35-35
122	Nora	Lara	1981-10-18	555-0122	Carrera 595 #25-40
123	Omar	Guerrero	1989-06-04	555-0123	Avenida 600 #45-20
124	Paloma	Cabrera	1977-01-20	555-0124	Calle 605 #30-30
125	Quintín	Paredes	1992-09-06	555-0125	Carrera 610 #20-35
126	Rita	Rojas	1985-05-23	555-0126	Avenida 615 #40-15
127	Simón	Figueroa	1990-03-09	555-0127	Calle 620 #15-40
128	Tania	Soto	1984-11-25	555-0128	Carrera 625 #35-25
129	Ulrico	Contreras	1988-07-12	555-0129	Avenida 630 #25-30
130	Vanesa	Reyes	1975-01-28	555-0130	Calle 635 #45-35
131	Wilson	León	1993-09-14	555-0131	Carrera 640 #30-40
132	Ximara	Muñoz	1982-05-30	555-0132	Avenida 645 #20-20
133	Yago	Fuentes	1987-03-17	555-0133	Calle 650 #40-30
134	Zulma	Carrillo	1996-11-03	555-0134	Carrera 655 #15-25
135	Aurelio	Ibáñez	1980-07-20	555-0135	Avenida 660 #35-35
136	Bárbara	Palacios	1991-01-06	555-0136	Calle 665 #25-40
137	Camilo	Moreno	1784-09-22	555-0137	Carrera 670 #45-15
138	Delia	Vera	1989-05-08	555-0138	Avenida 675 #30-30
139	Evaristo	Salas	1983-02-24	555-0139	Calle 680 #20-25
140	Flora	Prieto	1988-10-11	555-0140	Carrera 685 #40-35
141	Gaspar	Acosta	1976-06-27	555-0141	Avenida 690 #15-40
142	Hortensia	Benítez	1994-04-13	555-0142	Calle 695 #35-20
143	Inocencio	Castillo	1982-12-30	555-0143	Carrera 700 #25-30
144	Jacinta	Peláez	1987-08-16	555-0144	Avenida 705 #45-25
145	Kleber	Mendez	1995-04-02	555-0145	Calle 710 #30-40
146	Leonor	Velasco	1981-02-18	555-0146	Carrera 715 #20-35
147	Maximiliano	Cárdenas	1986-10-05	555-0147	Avenida 720 #40-15
148	Nicanor	Blanco	1990-06-21	555-0148	Calle 725 #15-30
149	Obdulia	Domínguez	1979-04-07	555-0149	Carrera 730 #35-25
150	Pancracio	Pascual	1984-12-23	555-0150	Avenida 735 #25-40
151	Quiteria	Gil	1992-08-09	555-0151	Calle 740 #45-35
152	Romualdo	Caballero	1978-05-26	555-0152	Carrera 745 #30-20
153	Saturnina	Moya	1985-03-12	555-0153	Avenida 750 #20-30
154	Telesforo	Rubio	1991-11-28	555-0154	Calle 755 #40-25
155	Urbano	Gallego	1983-07-15	555-0155	Carrera 760 #15-35
156	Visitación	Marín	1988-01-01	555-0156	Avenida 765 #35-40
157	Wenceslao	Pastor	1977-09-17	555-0157	Calle 770 #25-15
158	Xerez	Carmona	1993-05-04	555-0158	Carrera 775 #45-30
159	Yolanda	Serrano	1986-03-20	555-0159	Avenida 780 #30-35
160	Zoilo	Vázquez	1994-11-06	555-0160	Calle 785 #20-40
161	Abundio	Martín	1982-07-23	555-0161	Carrera 790 #40-20
162	Brígida	Santana	1989-01-09	555-0162	Avenida 795 #15-30
163	Casimiro	Hidalgo	1975-09-25	555-0163	Calle 800 #35-25
164	Delfina	Lorenzo	1990-05-12	555-0164	Carrera 805 #25-35
165	Eustaquio	Morales	1984-03-28	555-0165	Avenida 810 #45-40
166	Florencia	Vidal	1987-11-14	555-0166	Calle 815 #30-15
167	Gaudencio	Roca	1996-07-01	555-0167	Carrera 820 #20-30
168	Herminia	Calvo	1981-01-17	555-0168	Avenida 825 #40-25
169	Isidro	Santos	1988-09-03	555-0169	Calle 830 #15-35
170	Jacoba	Iglesias	1979-05-20	555-0170	Carrera 835 #35-40
171	Leandro	Ferrer	1992-02-05	555-0171	Avenida 840 #25-20
172	Modesto	Herrero	1085-10-22	555-0172	Calle 845 #45-30
173	Nemesio	Suárez	1986-06-08	555-0173	Carrera 850 #30-25
174	Otilia	Ortiz	1991-04-24	555-0174	Avenida 855 #20-35
175	Plácido	Vicente	1983-12-11	555-0175	Calle 860 #40-40
176	Querubín	Esteban	1988-08-27	555-0176	Carrera 865 #15-15
177	Ruperto	Román	1976-04-14	555-0177	Avenida 870 #35-30
178	Servando	Santiago	1994-02-22	555-0178	Calle 875 #25-25
179	Tiburcio	Garrido	1982-10-16	555-0179	Carrera 880 #45-40
180	Ubaldo	Lozano	1987-06-02	555-0180	Avenida 885 #30-35
181	Venancia	Cano	1995-01-19	555-0181	Calle 890 #20-20
182	Wilibaldo	Nieto	1981-09-05	555-0182	Carrera 895 #40-30
183	Xenia	Guerrero	1989-05-21	555-0183	Avenida 900 #15-25
184	Yesenia	Pascual	1984-03-07	555-0184	Calle 905 #35-35
185	Zenón	Duran	1990-11-23	555-0185	Carrera 910 #25-40
186	Apolinar	Cabrera	1778-07-10	555-0186	Avenida 915 #45-15
187	Bonifacio	Moreno	1993-01-26	555-0187	Calle 920 #30-30
188	Candelaria	Vega	1985-09-12	555-0188	Carrera 925 #20-25
189	Desiderio	Torres	1988-05-29	555-0189	Avenida 930 #40-35
190	Epifanio	Flores	1980-03-15	555-0190	Calle 935 #15-40
191	Filomena	Castro	1992-11-01	555-0191	Carrera 940 #35-20
192	Genaro	Ruiz	1987-07-18	555-0192	Avenida 945 #25-30
193	Hipólito	Vargas	1975-01-04	555-0193	Calle 950 #45-25
194	Imelda	Mendoza	1991-09-20	555-0194	Carrera 955 #30-40
195	Jeremías	Peña	1984-05-07	555-0195	Avenida 960 #20-15
196	Ladislao	Ortega	1989-02-23	555-0196	Calle 965 #40-30
197	Macario	Ramos	1982-10-09	555-0197	Carrera 970 #15-35
198	Nicomedes	Silva	1986-06-26	555-0198	Avenida 975 #35-25
199	Olegario	Gutiérrez	1994-04-12	555-0199	Calle 980 #25-40
200	Prudencio	Herrera	1981-12-28	555-0200	Carrera 985 #45-30
\.


--
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: neir
--

COPY public.payments (id, plan_id, payment_date, amount, payment_method) FROM stdin;
2	1	2024-02-15 14:30:00	800000.00	Tarjeta de crédito
3	2	2024-01-16 09:15:00	1250000.00	Transferencia
4	3	2024-01-17 11:45:00	250000.00	Efectivo
5	4	2024-01-18 16:20:00	80000.00	Tarjeta de débito
6	5	2024-01-19 08:30:00	600000.00	Efectivo
7	6	2024-01-20 13:15:00	300000.00	Tarjeta de crédito
8	7	2024-01-21 15:45:00	1500000.00	Transferencia
9	8	2024-01-22 10:30:00	650000.00	Efectivo
10	9	2024-01-23 12:00:00	150000.00	Tarjeta de débito
11	10	2024-01-24 14:20:00	120000.00	Efectivo
12	11	2024-01-25 16:45:00	2500000.00	Transferencia
13	12	2024-01-26 08:15:00	450000.00	Tarjeta de crédito
14	13	2024-01-27 11:30:00	180000.00	Efectivo
15	14	2024-01-28 13:50:00	3500000.00	Transferencia
16	15	2024-01-29 15:10:00	550000.00	Tarjeta de débito
17	16	2024-01-30 09:25:00	200000.00	Efectivo
18	17	2024-01-31 12:40:00	1800000.00	Transferencia
19	18	2024-02-01 14:55:00	750000.00	Tarjeta de crédito
20	19	2024-02-02 10:05:00	100000.00	Efectivo
21	20	2024-02-03 16:35:00	2000000.00	Transferencia
22	21	2024-02-04 08:50:00	1200000.00	Tarjeta de débito
23	22	2024-02-05 11:20:00	300000.00	Efectivo
24	23	2024-02-06 13:45:00	2400000.00	Transferencia
25	24	2024-02-07 15:25:00	4500000.00	Tarjeta de crédito
26	25	2024-02-08 09:40:00	400000.00	Efectivo
27	26	2024-02-09 12:15:00	800000.00	Transferencia
28	27	2024-02-10 14:35:00	350000.00	Tarjeta de débito
29	28	2024-02-11 10:55:00	500000.00	Efectivo
30	29	2024-02-12 16:10:00	200000.00	Tarjeta de crédito
31	30	2024-02-13 08:25:00	350000.00	Transferencia
32	31	2024-02-14 11:50:00	1800000.00	Efectivo
33	32	2024-02-15 13:15:00	80000.00	Tarjeta de débito
34	33	2024-02-16 15:40:00	200000.00	Efectivo
35	34	2024-02-17 09:05:00	800000.00	Transferencia
36	35	2024-02-18 12:30:00	200000.00	Tarjeta de crédito
37	36	2024-02-19 14:20:00	300000.00	Efectivo
38	37	2024-02-20 16:45:00	1500000.00	Transferencia
39	38	2024-02-21 08:15:00	400000.00	Tarjeta de débito
40	39	2024-02-22 11:35:00	200000.00	Efectivo
41	40	2024-02-23 13:50:00	350000.00	Tarjeta de crédito
42	41	2024-02-24 15:10:00	2400000.00	Transferencia
43	42	2024-02-25 09:25:00	50000.00	Efectivo
44	43	2024-02-26 12:40:00	2000000.00	Transferencia
45	44	2024-02-27 14:55:00	3500000.00	Tarjeta de crédito
46	45	2024-02-28 10:05:00	500000.00	Efectivo
47	46	2024-02-29 16:35:00	600000.00	Tarjeta de débito
48	47	2024-03-01 08:50:00	4500000.00	Transferencia
49	48	2024-03-02 11:20:00	650000.00	Efectivo
50	49	2024-03-03 13:45:00	150000.00	Tarjeta de crédito
51	50	2024-03-04 15:25:00	8000000.00	Transferencia
52	51	2024-03-05 09:40:00	750000.00	Efectivo
53	52	2024-03-06 12:15:00	30000.00	Tarjeta de débito
54	53	2024-03-07 14:35:00	600000.00	Efectivo
55	54	2024-03-08 10:55:00	450000.00	Transferencia
56	55	2024-03-09 16:10:00	350000.00	Tarjeta de crédito
57	56	2024-03-10 08:25:00	300000.00	Efectivo
58	57	2024-03-11 11:50:00	8000000.00	Transferencia
59	58	2024-03-12 13:15:00	150000.00	Tarjeta de débito
60	59	2024-03-13 15:40:00	400000.00	Efectivo
61	60	2024-03-14 09:05:00	600000.00	Tarjeta de crédito
62	61	2024-03-15 12:30:00	4000000.00	Transferencia
63	62	2024-03-16 14:20:00	80000.00	Efectivo
64	63	2024-03-17 16:45:00	2500000.00	Transferencia
65	64	2024-03-18 08:15:00	600000.00	Tarjeta de débito
66	65	2024-03-19 11:35:00	800000.00	Efectivo
67	66	2024-03-20 13:50:00	1200000.00	Tarjeta de crédito
68	67	2024-03-21 15:10:00	800000.00	Transferencia
69	68	2024-03-22 09:25:00	250000.00	Efectivo
70	69	2024-03-23 12:40:00	2000000.00	Transferencia
71	70	2024-03-24 14:55:00	800000.00	Tarjeta de débito
72	71	2024-03-25 10:05:00	300000.00	Efectivo
73	72	2024-03-26 16:35:00	120000.00	Tarjeta de crédito
74	73	2024-03-27 08:50:00	800000.00	Transferencia
75	74	2024-03-28 11:20:00	400000.00	Efectivo
76	75	2024-03-29 13:45:00	600000.00	Tarjeta de débito
77	76	2024-03-30 15:25:00	600000.00	Transferencia
78	77	2024-03-31 09:40:00	800000.00	Efectivo
79	78	2024-04-01 12:15:00	300000.00	Tarjeta de crédito
80	79	2024-04-02 14:35:00	2000000.00	Transferencia
81	80	2024-04-03 10:55:00	150000.00	Efectivo
82	81	2024-04-04 16:10:00	800000.00	Tarjeta de débito
83	82	2024-04-05 08:25:00	120000.00	Efectivo
84	83	2024-04-06 11:50:00	2500000.00	Transferencia
85	84	2024-04-07 13:15:00	800000.00	Tarjeta de crédito
86	85	2024-04-08 15:40:00	500000.00	Efectivo
87	86	2024-04-09 09:05:00	1200000.00	Transferencia
88	87	2024-04-10 12:30:00	3000000.00	Tarjeta de débito
89	88	2024-04-11 14:20:00	400000.00	Efectivo
90	89	2024-04-12 16:45:00	1500000.00	Tarjeta de crédito
91	90	2024-04-13 08:15:00	300000.00	Transferencia
92	91	2024-04-14 11:35:00	600000.00	Efectivo
93	92	2024-04-15 13:50:00	250000.00	Tarjeta de débito
94	93	2024-04-16 15:10:00	2500000.00	Transferencia
95	94	2024-04-17 09:25:00	800000.00	Efectivo
96	95	2024-04-18 12:40:00	350000.00	Tarjeta de crédito
97	96	2024-04-19 14:55:00	800000.00	Transferencia
98	97	2024-04-20 10:05:00	2500000.00	Efectivo
99	98	2024-04-21 16:35:00	250000.00	Tarjeta de débito
100	99	2024-04-22 08:50:00	2000000.00	Transferencia
101	100	2024-04-23 11:20:00	600000.00	Tarjeta de crédito
102	101	2024-04-24 13:45:00	550000.00	Efectivo
103	102	2024-04-25 15:25:00	450000.00	Transferencia
104	103	2024-04-26 09:40:00	250000.00	Tarjeta de débito
105	104	2024-04-27 12:15:00	300000.00	Efectivo
106	105	2024-04-28 14:35:00	1200000.00	Tarjeta de crédito
107	106	2024-04-29 10:55:00	300000.00	Transferencia
108	107	2024-04-30 16:10:00	1800000.00	Efectivo
109	108	2024-05-01 08:25:00	650000.00	Tarjeta de débito
110	109	2024-05-02 11:50:00	25000.00	Efectivo
111	110	2024-05-03 13:15:00	350000.00	Transferencia
112	111	2024-05-04 15:40:00	800000.00	Tarjeta de crédito
113	112	2024-05-05 09:05:00	80000.00	Efectivo
114	113	2024-05-06 12:30:00	120000.00	Transferencia
115	114	2024-05-07 14:20:00	2500000.00	Tarjeta de débito
116	115	2024-05-08 16:45:00	350000.00	Efectivo
117	116	2024-05-09 08:15:00	300000.00	Tarjeta de crédito
118	117	2024-05-10 11:35:00	1500000.00	Transferencia
119	118	2024-05-11 13:50:00	650000.00	Efectivo
120	119	2024-05-12 15:10:00	80000.00	Tarjeta de débito
121	120	2024-05-13 09:25:00	200000.00	Transferencia
122	121	2024-05-14 12:40:00	2400000.00	Tarjeta de crédito
123	122	2024-05-15 14:55:00	50000.00	Efectivo
124	123	2024-05-16 10:05:00	200000.00	Transferencia
125	124	2024-05-17 16:35:00	4500000.00	Tarjeta de débito
126	125	2024-05-18 08:50:00	200000.00	Efectivo
127	126	2024-05-19 11:20:00	800000.00	Tarjeta de crédito
128	127	2024-05-20 13:45:00	1500000.00	Transferencia
129	128	2024-05-21 15:25:00	300000.00	Efectivo
130	129	2024-05-22 09:40:00	100000.00	Tarjeta de débito
131	130	2024-05-23 12:15:00	350000.00	Transferencia
132	131	2024-05-24 14:35:00	750000.00	Tarjeta de crédito
133	132	2024-05-25 10:55:00	30000.00	Efectivo
134	133	2024-05-26 16:10:00	600000.00	Transferencia
135	134	2024-05-27 08:25:00	1000000.00	Tarjeta de débito
136	135	2024-05-28 11:50:00	800000.00	Efectivo
137	136	2024-05-29 13:15:00	600000.00	Tarjeta de crédito
138	137	2024-05-30 15:40:00	4500000.00	Transferencia
139	138	2024-05-31 09:05:00	400000.00	Efectivo
140	139	2024-06-01 12:30:00	200000.00	Tarjeta de débito
141	140	2024-06-02 14:20:00	2000000.00	Transferencia
142	141	2024-06-03 16:45:00	1200000.00	Tarjeta de crédito
143	142	2024-06-04 08:15:00	50000.00	Efectivo
144	143	2024-06-05 11:35:00	250000.00	Transferencia
145	144	2024-06-06 13:50:00	2500000.00	Tarjeta de débito
146	145	2024-06-07 15:10:00	500000.00	Efectivo
147	146	2024-06-08 09:25:00	800000.00	Tarjeta de crédito
148	147	2024-06-09 12:40:00	6000000.00	Transferencia
149	148	2024-06-10 14:55:00	250000.00	Efectivo
150	149	2024-06-11 10:05:00	200000.00	Tarjeta de débito
151	150	2024-06-12 16:35:00	800000.00	Transferencia
152	151	2024-06-13 08:50:00	750000.00	Tarjeta de crédito
153	152	2024-06-14 11:20:00	30000.00	Efectivo
154	153	2024-06-15 13:45:00	200000.00	Transferencia
155	154	2024-06-16 15:25:00	4000000.00	Tarjeta de débito
156	155	2024-06-17 09:40:00	600000.00	Efectivo
157	156	2024-06-18 12:15:00	500000.00	Tarjeta de crédito
158	157	2024-06-19 14:35:00	8000000.00	Transferencia
159	158	2024-06-20 10:55:00	300000.00	Efectivo
160	159	2024-06-21 16:10:00	80000.00	Tarjeta de débito
161	160	2024-06-22 08:25:00	350000.00	Transferencia
162	161	2024-06-23 11:50:00	1800000.00	Tarjeta de crédito
163	162	2024-06-24 13:15:00	80000.00	Efectivo
164	163	2024-06-25 15:40:00	2000000.00	Transferencia
165	164	2024-06-26 09:05:00	800000.00	Tarjeta de débito
166	165	2024-06-27 12:30:00	350000.00	Efectivo
167	166	2024-06-28 14:20:00	300000.00	Tarjeta de crédito
168	167	2024-06-29 16:45:00	4000000.00	Transferencia
169	168	2024-06-30 08:15:00	150000.00	Efectivo
170	169	2024-07-01 11:35:00	100000.00	Tarjeta de débito
171	170	2024-07-02 13:50:00	600000.00	Transferencia
172	171	2024-07-03 15:10:00	4000000.00	Tarjeta de crédito
173	172	2024-07-04 09:25:00	120000.00	Efectivo
174	173	2024-07-05 12:40:00	2500000.00	Transferencia
175	174	2024-07-06 14:55:00	400000.00	Tarjeta de débito
176	175	2024-07-07 10:05:00	600000.00	Efectivo
177	176	2024-07-08 16:35:00	600000.00	Tarjeta de crédito
178	177	2024-07-09 08:50:00	800000.00	Transferencia
179	178	2024-07-10 11:20:00	250000.00	Efectivo
180	179	2024-07-11 13:45:00	2000000.00	Tarjeta de débito
181	180	2024-07-12 15:25:00	150000.00	Transferencia
182	181	2024-07-13 09:40:00	800000.00	Tarjeta de crédito
183	182	2024-07-14 12:15:00	120000.00	Efectivo
184	183	2024-07-15 14:35:00	2500000.00	Transferencia
185	184	2024-07-16 10:55:00	800000.00	Tarjeta de débito
186	185	2024-07-17 16:10:00	500000.00	Efectivo
187	186	2024-07-18 08:25:00	1200000.00	Tarjeta de crédito
188	187	2024-07-19 11:50:00	3000000.00	Transferencia
189	188	2024-07-20 13:15:00	400000.00	Efectivo
190	189	2024-07-21 15:40:00	1500000.00	Tarjeta de débito
191	190	2024-07-22 09:05:00	300000.00	Transferencia
192	191	2024-07-23 12:30:00	600000.00	Tarjeta de crédito
193	192	2024-07-24 14:20:00	250000.00	Efectivo
194	193	2024-07-25 16:45:00	2500000.00	Transferencia
195	194	2024-07-26 08:15:00	800000.00	Tarjeta de débito
196	195	2024-07-27 11:35:00	350000.00	Efectivo
197	196	2024-07-28 13:50:00	800000.00	Tarjeta de crédito
198	197	2024-07-29 15:10:00	2500000.00	Transferencia
199	198	2024-07-30 09:25:00	250000.00	Efectivo
200	199	2024-07-31 12:40:00	2000000.00	Tarjeta de débito
201	200	2024-08-01 14:55:00	600000.00	Transferencia
\.


--
-- Data for Name: payments_audit; Type: TABLE DATA; Schema: public; Owner: neir
--

COPY public.payments_audit (id, payment_id, action, changed_at, changed_by, before_data, after_data) FROM stdin;
1	1	UPDATE	2025-10-13 11:26:49.094174	Admin	{"id": 1, "amount": 350000.00, "plan_id": 1, "payment_date": "2024-01-15T10:00:00", "payment_method": "Efectivo"}	{"id": 1, "amount": 350000.00, "plan_id": 1, "payment_date": "2024-02-15T10:00:00", "payment_method": "Efectivo"}
2	1	DELETE	2025-10-13 11:27:09.107513	Admin	{"id": 1, "amount": 350000.00, "plan_id": 1, "payment_date": "2024-02-15T10:00:00", "payment_method": "Efectivo"}	\N
3	2	UPDATE	2025-11-13 11:27:09.107	Admin	{"id": 1, "amount": 350000.00, "plan_id": 1, "payment_date": "2024-02-15T10:00:00", "payment_method": "Efectivo"}	{"id": 1, "amount": 350000.00, "plan_id": 1, "payment_date": "2024-02-15T10:00:00", "payment_method": "Efectivo"}
\.


--
-- Data for Name: procedures; Type: TABLE DATA; Schema: public; Owner: neir
--

COPY public.procedures (id, plan_id, treatment_id, tooth_id, procedure_date, observations) FROM stdin;
1	1	1	1	2024-01-15	Endodoncia en incisivo central superior derecho
2	1	4	1	2024-02-15	Corona sobre endodoncia
3	2	11	2	2024-01-16	Inicio ortodoncia con brackets metálicos
4	3	9	18	2024-01-17	Extracción tercer molar superior derecho
5	4	8	\N	2024-01-18	Limpieza periodontal profunda
6	5	13	\N	2024-01-19	Impresiones para prótesis parcial
7	6	7	\N	2024-01-20	Blanqueamiento ambulatorio
8	7	6	16	2024-01-21	Colocación implante molar superior
9	8	18	11	2024-01-22	Carilla en incisivo central
10	9	19	36	2024-01-23	Resina en molar inferior
11	10	8	\N	2024-01-24	Profilaxis y detartraje completo
12	11	2	26	2024-01-25	Endodoncia en primer molar superior izquierdo
13	12	7	\N	2024-01-26	Blanqueamiento dental ambulatorio
14	13	10	48	2024-01-27	Extracción quirúrgica muela del juicio
15	14	11	\N	2024-01-28	Colocación brackets superiores
16	15	3	46	2024-01-29	Endodoncia multirradicular molar inferior
17	16	8	\N	2024-01-30	Limpieza periodontal sector anterior
18	17	6	36	2024-01-31	Implante en zona molar inferior izquierda
19	18	18	21	2024-02-01	Carilla cerámica incisivo lateral
20	19	19	24	2024-02-02	Resina compuesta premolar superior
21	20	5	14	2024-02-03	Corona zirconio premolar derecho
22	21	16	\N	2024-02-04	Prótesis parcial removible superior
23	22	8	\N	2024-02-05	Control periodontal trimestral
24	23	25	37	2024-02-06	Elevación seno maxilar derecho
25	24	12	\N	2024-02-07	Brackets estéticos superiores e inferiores
26	25	26	15	2024-02-08	Apicoectomía segundo premolar superior
27	26	24	\N	2024-02-09	Cirugía periodontal regenerativa
28	27	59	28	2024-02-10	All-on-4 maxilar superior
29	28	7	\N	2024-02-11	Blanqueamiento en consultorio
30	29	31	\N	2024-02-12	Radiografía panorámica diagnóstica
31	30	40	\N	2024-02-13	Biopsia de lesión en paladar
32	31	4	22	2024-02-14	Corona metal-cerámica incisivo lateral
33	32	29	55	2024-02-15	Selladores de fosetas molares temporales
34	33	27	\N	2024-02-16	Frenectomía labial superior
35	34	45	\N	2024-02-17	Expansión maxilar con disyuntor
36	35	30	85	2024-02-18	Pulpotomía molar temporal
37	36	24	\N	2024-02-19	Injerto gingival libre
38	37	6	17	2024-02-20	Implante inmediato postextracción
39	38	41	12	2024-02-21	Composite estratificado incisivo lateral
40	39	31	\N	2024-02-22	TAC dental para planificación
41	40	35	\N	2024-02-23	Sedación consciente con óxido nitroso
42	41	17	\N	2024-02-24	Puente fijo de 4 unidades
43	42	30	74	2024-02-25	Aplicación flúor barniz
44	43	25	\N	2024-02-26	Injerto óseo con biomaterial
45	44	46	\N	2024-02-27	Aparato funcional Frankel
46	45	1	33	2024-02-28	Endodoncia canino inferior izquierdo
47	46	24	\N	2024-02-29	Regeneración tisular guiada
48	47	58	42	2024-03-01	Carga inmediata sobre implante
49	48	42	13	2024-03-02	Microabrasión canino superior
50	49	33	\N	2024-03-03	Cefalometría lateral de cráneo
51	50	39	\N	2024-03-04	Cultivo bacteriano periodontal
52	51	21	45	2024-03-05	Incrustación cerámica premolar
53	52	30	\N	2024-03-06	Programa preventivo infantil
54	53	87	\N	2024-03-07	Distracción osteogénica mandibular
55	54	48	\N	2024-03-08	Lip bumper para protrusión
56	55	26	35	2024-03-09	Apicoectomía segundo premolar inferior
57	56	67	\N	2024-03-10	Colgajo de acceso periodontal
58	57	59	\N	2024-03-11	All-on-6 rehabilitación completa
59	58	19	44	2024-03-12	Resina compuesta clase II
60	59	126	\N	2024-03-13	Resonancia magnética ATM
61	60	130	\N	2024-03-14	Genotipado bacteriano avanzado
62	61	72	\N	2024-03-15	Sobredentadura inferior
63	62	8	\N	2024-03-16	Mantenimiento periodontal
64	63	91	\N	2024-03-17	Osteotomía Le Fort I
65	64	49	\N	2024-03-18	Quad helix expansión
66	65	78	25	2024-03-19	Revascularización pulpar
67	66	64	\N	2024-03-20	Plasma rico en plaquetas
68	67	65	27	2024-03-21	Mini implantes ortodóncicos
69	68	44	23	2024-03-22	Infiltración de resina Icon
70	69	122	\N	2024-03-23	Artroscopia de ATM
71	70	124	\N	2024-03-24	Antibiograma específico
72	71	74	\N	2024-03-25	Barra-clip sobre implantes
73	72	166	\N	2024-03-26	Remineralización con CPP-ACP
74	73	92	\N	2024-03-27	Sagital split mandibular
75	74	50	\N	2024-03-28	Pendulum distalización
76	75	77	31	2024-03-29	MTA apical directo
77	76	63	\N	2024-03-30	Membrana de colágeno
78	77	66	\N	2024-03-31	Implante pterigoideo
79	78	45	41	2024-04-01	Estratificación composite anterior
80	79	125	\N	2024-04-02	PET-CT maxilofacial
81	80	129	\N	2024-04-03	Secuenciación genética
82	81	73	\N	2024-04-04	Telescópicas dobles
83	82	167	\N	2024-04-05	Educación en higiene oral
84	83	89	\N	2024-04-06	Mentoplastia de aumento
85	84	47	\N	2024-04-07	Aparato funcional Twin Block
86	85	79	16	2024-04-08	Obturación retrógrada con MTA
87	86	62	\N	2024-04-09	Factor de crecimiento PDGF
88	87	68	\N	2024-04-10	Implante basal bicortical
89	88	46	32	2024-04-11	Icon infiltrante lesión inicial
90	89	123	\N	2024-04-12	Artrocentesis bilateral
91	90	131	\N	2024-04-13	Marcadores tumorales orales
92	91	75	\N	2024-04-14	Ataches locator implantes
93	92	168	\N	2024-04-15	Técnica de Bass modificada
94	93	90	\N	2024-04-16	Osteotomía sagital bilateral
95	94	51	\N	2024-04-17	Disyunción maxilar rápida
96	95	80	34	2024-04-18	Apexificación con hidróxido
97	96	61	\N	2024-04-19	Injerto óseo autólogo
98	97	69	38	2024-04-20	Implante zigomático
99	98	47	43	2024-04-21	Composite nanohíbrido
100	99	127	\N	2024-04-22	Gammagrafía ósea trifásica
101	100	133	\N	2024-04-23	Inmunohistoquímica p53
102	101	1	47	2024-04-24	Endodoncia segundo molar inferior
103	102	11	\N	2024-04-25	Activación ortodóncica mensual
104	103	9	28	2024-04-26	Extracción cordal superior izquierda
105	104	8	\N	2024-04-27	Raspado y alisado radicular
106	105	16	\N	2024-04-28	Rebase de prótesis total
107	106	7	\N	2024-04-29	Blanqueamiento domiciliario
108	107	6	26	2024-04-30	Control de implante integrado
109	108	18	22	2024-05-01	Carilla de porcelana feldespática
110	109	31	\N	2024-05-02	Radiografía de control
111	110	40	\N	2024-05-03	Resultado de biopsia
112	111	4	15	2024-05-04	Corona provisional acrílica
113	112	8	\N	2024-05-05	Control periodontal semestral
114	113	10	18	2024-05-06	Sutura post-extracción
115	114	12	\N	2024-05-07	Cambio de ligaduras
116	115	2	41	2024-05-08	Obturación de conductos
117	116	24	\N	2024-05-09	Evaluación de injerto
118	117	58	\N	2024-05-10	Carga protésica diferida
119	118	43	11	2024-05-11	Pulido de composite
120	119	33	\N	2024-05-12	Análisis cefalométrico
121	120	35	\N	2024-05-13	Premedicación anestésica
122	121	17	\N	2024-05-14	Cementado de puente
123	122	29	64	2024-05-15	Refuerzo con selladores
124	123	27	\N	2024-05-16	Cicatrización de frenectomía
125	124	45	\N	2024-05-17	Retención ortodóncica
126	125	30	75	2024-05-18	Corona de acero pediátrica
127	126	67	\N	2024-05-19	Segundo tiempo quirúrgico
128	127	57	\N	2024-05-20	Mantenimiento All-on-4
129	128	7	\N	2024-05-21	Control post-blanqueamiento
130	129	32	\N	2024-05-22	TAC de control
131	130	38	\N	2024-05-23	Monitoreo de signos vitales
132	131	21	24	2024-05-24	Pulido de incrustación
133	132	8	\N	2024-05-25	Irrigación subgingival
134	133	25	\N	2024-05-26	Control de injerto óseo
135	134	46	\N	2024-05-27	Ajuste de aparato
136	135	1	44	2024-05-28	Lima de glide path
137	136	63	\N	2024-05-29	Evaluación de membrana
138	137	59	\N	2024-05-30	Fotografías de control
139	138	19	14	2024-05-31	Resina clase V cervical
140	139	31	\N	2024-06-01	Radiografía bitewing
141	140	36	\N	2024-06-02	Control de hemostasia
142	141	4	25	2024-06-03	Impresión para corona
143	142	30	\N	2024-06-04	Aplicación de barniz
144	143	10	\N	2024-06-05	Retiro de puntos
145	144	11	\N	2024-06-06	Colocación de cadena elástica
146	145	3	37	2024-06-07	Instrumentación con ProTaper
147	146	24	\N	2024-06-08	Injerto de tejido conectivo
148	147	6	\N	2024-06-09	Destape de implante
149	148	41	21	2024-06-10	Restauración directa anterior
150	149	33	\N	2024-06-11	Trazado cefalométrico
151	150	35	\N	2024-06-12	Sedación con midazolam
152	151	17	\N	2024-06-13	Ajuste oclusal de puente
153	152	8	\N	2024-06-14	Profilaxis con ultrasonido
154	153	27	\N	2024-06-15	Control de cicatrización
155	154	12	\N	2024-06-16	Brackets linguales
156	155	2	45	2024-06-17	Localización de conductos
157	156	67	\N	2024-06-18	Sutura con seda 4-0
158	157	57	\N	2024-06-19	Higiene de prótesis
159	158	42	13	2024-06-20	Eliminación de manchas
160	159	31	\N	2024-06-21	Imagen panorámica digital
161	160	40	\N	2024-06-22	Marcaje histológico
162	161	4	35	2024-06-23	Preparación para corona
163	162	8	\N	2024-06-24	Irrigación con clorhexidina
164	163	25	\N	2024-06-25	Colocación de membrana
165	164	45	\N	2024-06-26	Expansión palatina lenta
166	165	1	43	2024-06-27	Obturación con gutapercha
167	166	24	\N	2024-06-28	Evaluación de queratinizada
168	167	59	\N	2024-06-29	Control radiográfico
169	168	19	23	2024-06-30	Resina fluida clase III
170	169	31	\N	2024-07-01	Control post-operatorio
171	170	39	\N	2024-07-02	Cultivo de Aggregatibacter
172	171	21	15	2024-07-03	Cementado de inlay
173	172	30	\N	2024-07-04	Técnica de cepillado
174	173	87	\N	2024-07-05	Activación del distractor
175	174	48	\N	2024-07-06	Ajuste del lip bumper
176	175	26	42	2024-07-07	Cirugía periapical
177	176	62	\N	2024-07-08	Aplicación de PDGF
178	177	65	\N	2024-07-09	Colocación de microtornillos
179	178	44	12	2024-07-10	Sellado de fisuras
180	179	122	\N	2024-07-11	Lavado articular
181	180	124	\N	2024-07-12	Test de sensibilidad
182	181	74	\N	2024-07-13	Activación de barra
183	182	166	\N	2024-07-14	Aplicación de MI Paste
184	183	92	\N	2024-07-15	Fijación intermaxilar
185	184	50	\N	2024-07-16	Activación del pendulum
186	185	77	32	2024-07-17	Sellado apical con MTA
187	186	63	\N	2024-07-18	Estabilización primaria
188	187	66	16	2024-07-19	Implante en tuberosidad
189	188	45	22	2024-07-20	Composite nanocerámico
190	189	125	\N	2024-07-21	Fusión de imágenes
191	190	129	\N	2024-07-22	Análisis de microarray
192	191	73	\N	2024-07-23	Retención friccionaal
193	192	167	\N	2024-07-24	Control de técnica
194	193	89	\N	2024-07-25	Osteoplastia mentoniana
195	194	47	\N	2024-07-26	Activación nocturna
196	195	79	34	2024-07-27	Retro-obturación con Biodentine
197	196	61	\N	2024-07-28	Harvesting de calota
198	197	68	48	2024-07-29	Implante cortical basal
199	198	46	31	2024-07-30	Remineralización dirigida
200	199	123	\N	2024-07-31	Artrocentesis terapéutica
201	200	131	\N	2024-08-01	Biopsia líquida
\.


--
-- Data for Name: teeth; Type: TABLE DATA; Schema: public; Owner: neir
--

COPY public.teeth (id, tooth_number, description) FROM stdin;
1	11	Incisivo central superior derecho
2	12	Incisivo lateral superior derecho
3	13	Canino superior derecho
4	14	Primer premolar superior derecho
5	15	Segundo premolar superior derecho
6	16	Primer molar superior derecho
7	17	Segundo molar superior derecho
8	18	Tercer molar superior derecho
9	21	Incisivo central superior izquierdo
10	22	Incisivo lateral superior izquierdo
11	23	Canino superior izquierdo
12	24	Primer premolar superior izquierdo
13	25	Segundo premolar superior izquierdo
14	26	Primer molar superior izquierdo
15	27	Segundo molar superior izquierdo
16	28	Tercer molar superior izquierdo
17	31	Incisivo central inferior izquierdo
18	32	Incisivo lateral inferior izquierdo
19	33	Canino inferior izquierdo
20	34	Primer premolar inferior izquierdo
21	35	Segundo premolar inferior izquierdo
22	36	Primer molar inferior izquierdo
23	37	Segundo molar inferior izquierdo
24	38	Tercer molar inferior izquierdo
25	41	Incisivo central inferior derecho
26	42	Incisivo lateral inferior derecho
27	43	Canino inferior derecho
28	44	Primer premolar inferior derecho
29	45	Segundo premolar inferior derecho
30	46	Primer molar inferior derecho
31	47	Segundo molar inferior derecho
32	48	Tercer molar inferior derecho
33	51	Incisivo central superior derecho temporal
34	52	Incisivo lateral superior derecho temporal
35	53	Canino superior derecho temporal
36	54	Primer molar superior derecho temporal
37	55	Segundo molar superior derecho temporal
38	61	Incisivo central superior izquierdo temporal
39	62	Incisivo lateral superior izquierdo temporal
40	63	Canino superior izquierdo temporal
41	64	Primer molar superior izquierdo temporal
42	65	Segundo molar superior izquierdo temporal
43	71	Incisivo central inferior izquierdo temporal
44	72	Incisivo lateral inferior izquierdo temporal
45	73	Canino inferior izquierdo temporal
46	74	Primer molar inferior izquierdo temporal
47	75	Segundo molar inferior izquierdo temporal
48	81	Incisivo central inferior derecho temporal
49	82	Incisivo lateral inferior derecho temporal
50	83	Canino inferior derecho temporal
51	84	Primer molar inferior derecho temporal
52	85	Segundo molar inferior derecho temporal
53	S1	Supernumerario mesiodens
54	S2	Supernumerario lateral superior
55	S3	Supernumerario paramolar
56	S4	Supernumerario distomolar
57	S5	Supernumerario palatino
58	S6	Supernumerario incisivo inferior
59	S7	Supernumerario canino superior
60	S8	Supernumerario canino inferior
61	S9	Supernumerario premolar superior
62	S10	Supernumerario premolar inferior
63	S11	Supernumerario molar superior
64	S12	Supernumerario molar inferior
65	S13	Supernumerario bilateral
66	S14	Supernumerario múltiple superior
67	S15	Supernumerario múltiple inferior
68	S16	Supernumerario en línea media inferior
69	S17	Supernumerario parapremolar
70	S18	Supernumerario distoincisivo
71	S19	Supernumerario peridens
72	S20	Supernumerario suplementario
73	D1	Diente impactado 18
74	D2	Diente impactado 28
75	D3	Diente impactado 38
76	D4	Diente impactado 48
77	D5	Diente ectópico canino
78	D6	Diente en transposición
79	D7	Diente anquilosado
80	D8	Diente con dilaceración
81	D9	Diente con taurodontismo
82	D10	Diente con geminación
83	D11	Diente fusionado
84	D12	Diente con hipoplasia
85	D13	Diente con hipocalcificación
86	D14	Diente retenido
87	D15	Diente con macrodoncia
88	D16	Diente con microdoncia
89	D17	Diente con dens evaginatus
90	D18	Diente con dens invaginatus
91	D19	Diente ectópico premolar
92	D20	Diente ectópico molar
93	D21	Diente desplazado hacia palatino
94	D22	Diente desplazado hacia lingual
95	D23	Diente desplazado hacia vestibular
96	D24	Diente desplazado hacia mesial
97	D25	Diente desplazado hacia distal
98	D26	Diente con raíz curva
99	D27	Diente con rizomicrodoncia
100	D28	Diente con rizomegadoncia
101	D29	Diente retenido múltiple
102	D30	Diente con alteración estructural
103	V1	Variante anatómica raíz extra 16
104	V2	Variante anatómica raíz extra 26
105	V3	Variante anatómica raíz extra 36
106	V4	Variante anatómica raíz extra 46
107	V5	Variante anatómica conducto C
108	V6	Variante anatómica dens in dente
109	V7	Variante anatómica perla del esmalte
110	V8	Variante anatómica surco palatogingival
111	V9	Variante anatómica tubérculo de Carabelli
112	V10	Variante anatómica cúspide adicional
113	V11	Variante anatómica cúspide paramolar
114	V12	Variante anatómica cúspide en garra
115	V13	Variante anatómica cúspide en talón
116	V14	Variante anatómica cúspide lingual
117	V15	Variante anatómica cúspide vestibular
118	V16	Variante anatómica raíz fusionada
119	V17	Variante anatómica raíz bífida
120	V18	Variante anatómica raíz trifurcada
121	V19	Variante anatómica raíz hipercurvada
122	V20	Variante anatómica conducto accesorio
123	V21	Variante anatómica conducto lateral
124	V22	Variante anatómica conducto múltiple
125	V23	Variante anatómica cámara pulpar amplia
126	V24	Variante anatómica cámara pulpar reducida
127	V25	Variante anatómica esmalte hipoplásico
128	V26	Variante anatómica esmalte rugoso
129	V27	Variante anatómica esmalte periquematías marcadas
130	V28	Variante anatómica esmalte translúcido
131	V29	Variante anatómica esmalte opaco
132	V30	Variante anatómica cúspide palatina extra
133	A1	Ausencia congénita incisivo lateral superior derecho
134	A2	Ausencia congénita incisivo lateral superior izquierdo
135	A3	Ausencia congénita segundo premolar superior derecho
136	A4	Ausencia congénita segundo premolar superior izquierdo
137	A5	Ausencia congénita segundo premolar inferior derecho
138	A6	Ausencia congénita segundo premolar inferior izquierdo
139	A7	Ausencia congénita tercer molar superior derecho
140	A8	Ausencia congénita tercer molar superior izquierdo
141	A9	Ausencia congénita tercer molar inferior derecho
142	A10	Ausencia congénita tercer molar inferior izquierdo
143	R1	Diente restaurado con amalgama
144	R2	Diente restaurado con resina
145	R3	Diente restaurado con incrustación metálica
146	R4	Diente restaurado con incrustación cerámica
147	R5	Diente restaurado con corona total metálica
148	R6	Diente restaurado con corona total cerámica
149	R7	Diente restaurado con perno colado
150	R8	Diente restaurado con perno prefabricado
151	R9	Diente restaurado con reconstrucción estética
152	R10	Diente restaurado con sellante de fosas y fisuras
153	P1	Prótesis fija en incisivo central superior derecho
154	P2	Prótesis fija en incisivo lateral superior derecho
155	P3	Prótesis fija en canino superior derecho
156	P4	Prótesis fija en primer premolar superior derecho
157	P5	Prótesis fija en segundo premolar superior derecho
158	P6	Prótesis fija en primer molar superior derecho
159	P7	Prótesis fija en segundo molar superior derecho
160	P8	Prótesis fija en tercer molar superior derecho
161	P9	Prótesis fija en incisivo central superior izquierdo
162	P10	Prótesis fija en incisivo lateral superior izquierdo
163	P11	Prótesis removible en arcada superior
164	P12	Prótesis removible en arcada inferior
165	P13	Prótesis total superior
166	P14	Prótesis total inferior
167	P15	Implante unitario en premolar superior derecho
168	E1	Diente tratado endodónticamente 11
169	E2	Diente tratado endodónticamente 12
170	E3	Diente tratado endodónticamente 21
171	E4	Diente tratado endodónticamente 22
172	E5	Diente tratado endodónticamente 36
173	E6	Diente tratado endodónticamente 46
174	E7	Diente tratado endodónticamente 16
175	E8	Diente tratado endodónticamente 26
176	E9	Diente tratado endodónticamente 31
177	E10	Diente tratado endodónticamente 41
178	C1	Diente con caries incipiente en 16
179	C2	Diente con caries incipiente en 26
180	C3	Diente con caries moderada en 36
181	C4	Diente con caries moderada en 46
182	C5	Diente con caries profunda en 11
183	C6	Diente con caries profunda en 21
184	C7	Diente con caries radicular en 31
185	C8	Diente con caries radicular en 41
186	C9	Diente con caries generalizada en arcada superior
187	C10	Diente con caries generalizada en arcada inferior
188	M1	Diente con movilidad grado I
189	M2	Diente con movilidad grado II
190	M3	Diente con movilidad grado III
191	M4	Diente con movilidad por pérdida ósea
192	M5	Diente con movilidad post-trauma
193	F1	Diente fracturado esmalte
194	F2	Diente fracturado esmalte-dentina
195	F3	Diente fracturado esmalte-dentina-pulpa
196	F4	Diente con fractura radicular
197	F5	Diente con fractura coronaria
198	F6	Diente con fractura horizontal
199	F7	Diente con fractura vertical
200	F8	Diente con fractura múltiple
201	F9	Diente con fractura coronoradicular
202	F10	Diente fracturado restaurado
\.


--
-- Data for Name: treatment_materials; Type: TABLE DATA; Schema: public; Owner: neir
--

COPY public.treatment_materials (treatment_id, material_id, quantity) FROM stdin;
1	1	1.00
1	2	0.50
1	140	5.00
1	141	2.00
1	162	1.00
2	1	1.00
2	2	0.50
2	140	3.00
2	141	1.00
3	1	2.00
3	2	1.00
3	140	8.00
3	141	3.00
3	144	1.00
4	8	1.00
4	197	1.00
4	198	1.00
5	8	1.00
5	197	1.00
6	7	1.00
6	17	4.00
6	18	2.00
6	19	1.00
7	7	1.00
7	17	6.00
7	18	2.00
8	7	1.00
8	17	8.00
8	18	4.00
9	8	1.00
9	197	1.00
10	8	1.00
10	197	1.00
11	5	28.00
11	6	4.00
11	12	20.00
11	13	10.00
11	82	4.00
12	5	28.00
12	6	4.00
12	12	20.00
12	13	10.00
13	5	28.00
13	6	6.00
13	85	4.00
13	86	2.00
14	21	1.00
14	22	1.00
14	195	1.00
15	21	1.00
15	22	1.00
16	23	10.00
16	24	5.00
17	21	1.00
17	22	1.00
18	3	1.00
18	25	1.00
18	26	1.00
19	3	1.00
19	25	1.00
19	26	1.00
20	4	1.00
20	25	1.00
20	26	1.00
21	185	1.00
21	186	1.00
21	187	1.00
22	27	2.00
22	28	1.00
23	22	1.00
23	78	1.00
24	54	15.00
24	55	8.00
25	95	1.00
25	96	0.50
26	52	2.00
26	53	1.00
27	27	4.00
27	78	1.00
28	27	2.00
28	29	1.00
29	156	1.00
29	157	5.00
30	155	1.00
30	156	1.00
31	159	1.00
31	160	1.00
32	27	1.00
32	28	2.00
33	52	1.00
33	53	2.00
34	89	1.00
34	90	2.00
35	27	1.00
35	143	3.00
36	97	1.00
36	98	0.50
37	17	1.00
37	18	1.00
38	3	1.00
38	25	1.00
39	159	1.00
39	160	1.00
40	43	2.00
40	44	1.00
41	21	3.00
41	22	3.00
42	27	2.00
42	28	1.00
43	101	2.00
43	102	1.00
44	91	1.00
44	92	2.00
45	1	1.00
45	2	0.50
46	97	2.00
46	98	1.00
47	17	1.00
47	72	2.00
48	3	1.00
48	33	2.00
49	159	1.00
49	160	1.00
50	155	1.00
50	156	1.00
51	185	1.00
51	186	1.00
52	27	1.00
52	28	1.00
53	54	20.00
53	55	10.00
54	93	1.00
54	94	2.00
55	1	1.00
55	2	0.50
56	97	3.00
56	98	1.50
57	17	4.00
57	18	4.00
58	3	1.00
58	25	1.00
59	159	1.00
59	160	1.00
60	155	1.00
60	156	1.00
61	21	4.00
61	22	4.00
62	27	2.00
62	28	1.00
63	54	25.00
63	55	12.00
64	89	1.00
64	90	3.00
65	1	1.00
65	2	0.50
66	99	1.00
66	100	0.50
67	115	2.00
67	116	1.00
68	3	1.00
68	25	1.00
69	159	1.00
69	160	1.00
70	155	1.00
70	156	1.00
71	72	2.00
71	73	1.00
72	30	2.00
72	31	1.00
73	54	30.00
73	55	15.00
74	93	1.00
74	94	3.00
75	144	2.00
75	145	1.00
76	99	2.00
76	100	1.00
77	115	1.00
77	116	1.00
78	3	2.00
78	25	2.00
79	159	1.00
79	160	1.00
80	155	1.00
80	156	1.00
81	197	3.00
81	198	2.00
82	30	3.00
82	31	2.00
83	54	20.00
83	55	10.00
84	91	1.00
84	92	2.00
85	144	1.00
85	145	1.00
86	97	4.00
86	98	2.00
87	117	1.00
87	118	1.00
88	3	1.00
88	25	1.00
89	159	1.00
89	160	1.00
90	155	1.00
90	156	1.00
91	72	3.00
91	73	2.00
92	168	1.00
92	169	1.00
93	54	35.00
93	55	18.00
94	94	1.00
94	95	2.00
95	146	1.00
95	147	1.00
96	99	3.00
96	100	2.00
97	119	1.00
97	120	1.00
98	170	1.00
98	171	1.00
99	159	1.00
99	160	1.00
100	155	1.00
100	156	1.00
\.


--
-- Data for Name: treatment_plans; Type: TABLE DATA; Schema: public; Owner: neir
--

COPY public.treatment_plans (id, patient_id, dentist_id, start_date, end_date, status) FROM stdin;
1	1	1	2024-01-15	2024-03-15	En progreso
2	2	2	2024-01-16	2024-12-16	Iniciado
3	3	3	2024-01-17	2024-02-17	Completado
4	4	4	2024-01-18	2024-06-18	En progreso
5	5	5	2024-01-19	2024-04-19	Iniciado
6	6	6	2024-01-20	2024-07-20	En progreso
7	7	7	2024-01-21	2024-05-21	Completado
8	8	8	2024-01-22	2024-03-22	En progreso
9	9	9	2024-01-23	2024-02-23	Iniciado
10	10	10	2024-01-24	2024-08-24	En progreso
11	11	11	2024-01-25	2024-09-25	En progreso
12	12	12	2024-01-26	2024-04-26	Completado
13	13	13	2024-01-27	2024-03-27	En progreso
14	14	14	2024-01-28	2024-10-28	Iniciado
15	15	15	2024-01-29	2024-05-29	En progreso
16	16	16	2024-01-30	2024-06-30	Completado
17	17	17	2024-01-31	2024-07-31	En progreso
18	18	18	2024-02-01	2024-04-01	Iniciado
19	19	19	2024-02-02	2024-03-02	Completado
20	20	20	2024-02-03	2024-11-03	En progreso
21	21	21	2024-02-04	2024-08-04	Iniciado
22	22	22	2024-02-05	2024-05-05	En progreso
23	23	23	2024-02-06	2024-06-06	Completado
24	24	24	2024-02-07	2024-12-07	En progreso
25	25	25	2024-02-08	2024-07-08	Iniciado
26	26	26	2024-02-09	2024-09-09	En progreso
27	27	27	2024-02-10	2024-10-10	Completado
28	28	28	2024-02-11	2024-05-11	En progreso
29	29	29	2024-02-12	2024-04-12	Iniciado
30	30	30	2024-02-13	2024-08-13	En progreso
31	31	31	2024-02-14	2024-11-14	Completado
32	32	32	2024-02-15	2024-06-15	En progreso
33	33	33	2024-02-16	2024-03-16	Iniciado
34	34	34	2024-02-17	2024-09-17	En progreso
35	35	35	2024-02-18	2024-07-18	Completado
36	36	36	2024-02-19	2024-10-19	En progreso
37	37	37	2024-02-20	2024-08-20	Iniciado
38	38	38	2024-02-21	2024-05-21	En progreso
39	39	39	2024-02-22	2024-04-22	Completado
40	40	40	2024-02-23	2024-12-23	En progreso
41	41	41	2024-02-24	2024-09-24	Iniciado
42	42	42	2024-02-25	2024-06-25	En progreso
43	43	43	2024-02-26	2024-07-26	Completado
44	44	44	2024-02-27	2024-11-27	En progreso
45	45	45	2024-02-28	2024-08-28	Iniciado
46	46	46	2024-02-29	2024-10-29	En progreso
47	47	47	2024-03-01	2024-05-01	Completado
48	48	48	2024-03-02	2024-09-02	En progreso
49	49	49	2024-03-03	2024-04-03	Iniciado
50	50	50	2024-03-04	2024-12-04	En progreso
51	51	51	2024-03-05	2024-11-05	Completado
52	52	52	2024-03-06	2024-07-06	En progreso
53	53	53	2024-03-07	2024-06-07	Iniciado
54	54	54	2024-03-08	2024-08-08	En progreso
55	55	55	2024-03-09	2024-10-09	Completado
56	56	56	2024-03-10	2024-09-10	En progreso
57	57	57	2024-03-11	2024-05-11	Iniciado
58	58	58	2024-03-12	2024-07-12	En progreso
59	59	59	2024-03-13	2024-04-13	Completado
60	60	60	2024-03-14	2024-12-14	En progreso
61	61	61	2024-03-15	2024-11-15	Iniciado
62	62	62	2024-03-16	2024-08-16	En progreso
63	63	63	2024-03-17	2024-06-17	Completado
64	64	64	2024-03-18	2024-09-18	En progreso
65	65	65	2024-03-19	2024-10-19	Iniciado
66	66	66	2024-03-20	2024-07-20	En progreso
67	67	67	2024-03-21	2024-05-21	Completado
68	68	68	2024-03-22	2024-08-22	En progreso
69	69	69	2024-03-23	2024-04-23	Iniciado
70	70	70	2024-03-24	2024-12-24	En progreso
71	71	71	2024-03-25	2024-11-25	Completado
72	72	72	2024-03-26	2024-09-26	En progreso
73	73	73	2024-03-27	2024-06-27	Iniciado
74	74	74	2024-03-28	2024-10-28	En progreso
75	75	75	2024-03-29	2024-07-29	Completado
76	76	76	2024-03-30	2024-08-30	En progreso
77	77	77	2024-03-31	2024-05-31	Iniciado
78	78	78	2024-04-01	2024-09-01	En progreso
79	79	79	2024-04-02	2024-04-30	Completado
80	80	80	2024-04-03	2024-12-03	En progreso
81	81	81	2024-04-04	2024-11-04	Iniciado
82	82	82	2024-04-05	2024-10-05	En progreso
83	83	83	2024-04-06	2024-06-06	Completado
84	84	84	2024-04-07	2024-08-07	En progreso
85	85	85	2024-04-08	2024-07-08	Iniciado
86	86	86	2024-04-09	2024-09-09	En progreso
87	87	87	2024-04-10	2024-05-10	Completado
88	88	88	2024-04-11	2024-10-11	En progreso
89	89	89	2024-04-12	2024-04-30	Iniciado
90	90	90	2024-04-13	2024-12-13	En progreso
91	91	91	2024-04-14	2024-11-14	Completado
92	92	92	2024-04-15	2024-08-15	En progreso
93	93	93	2024-04-16	2024-06-16	Iniciado
94	94	94	2024-04-17	2024-09-17	En progreso
95	95	95	2024-04-18	2024-07-18	Completado
96	96	96	2024-04-19	2024-10-19	En progreso
97	97	97	2024-04-20	2024-05-20	Iniciado
98	98	98	2024-04-21	2024-08-21	En progreso
99	99	99	2024-04-22	2024-04-30	Completado
100	100	100	2024-04-23	2024-12-23	En progreso
101	101	1	2024-04-24	2024-11-24	Iniciado
102	102	2	2024-04-25	2024-09-25	En progreso
103	103	3	2024-04-26	2024-06-26	Completado
104	104	4	2024-04-27	2024-10-27	En progreso
105	105	5	2024-04-28	2024-07-28	Iniciado
106	106	6	2024-04-29	2024-08-29	En progreso
107	107	7	2024-04-30	2024-05-30	Completado
108	108	8	2024-05-01	2024-09-01	En progreso
109	109	9	2024-05-02	2024-05-31	Iniciado
110	110	10	2024-05-03	2024-12-03	En progreso
111	111	11	2024-05-04	2024-11-04	Completado
112	112	12	2024-05-05	2024-10-05	En progreso
113	113	13	2024-05-06	2024-06-06	Iniciado
114	114	14	2024-05-07	2024-08-07	En progreso
115	115	15	2024-05-08	2024-07-08	Completado
116	116	16	2024-05-09	2024-09-09	En progreso
117	117	17	2024-05-10	2024-05-31	Iniciado
118	118	18	2024-05-11	2024-10-11	En progreso
119	119	19	2024-05-12	2024-05-31	Completado
120	120	20	2024-05-13	2024-12-13	En progreso
121	121	21	2024-05-14	2024-11-14	Iniciado
122	122	22	2024-05-15	2024-08-15	En progreso
123	123	23	2024-05-16	2024-06-16	Completado
124	124	24	2024-05-17	2024-09-17	En progreso
125	125	25	2024-05-18	2024-07-18	Iniciado
126	126	26	2024-05-19	2024-10-19	En progreso
127	127	27	2024-05-20	2024-05-31	Completado
128	128	28	2024-05-21	2024-08-21	En progreso
129	129	29	2024-05-22	2024-05-31	Iniciado
130	130	30	2024-05-23	2024-12-23	En progreso
131	131	31	2024-05-24	2024-11-24	Completado
132	132	32	2024-05-25	2024-09-25	En progreso
133	133	33	2024-05-26	2024-06-26	Iniciado
134	134	34	2024-05-27	2024-10-27	En progreso
135	135	35	2024-05-28	2024-07-28	Completado
136	136	36	2024-05-29	2024-08-29	En progreso
137	137	37	2024-05-30	2024-05-31	Iniciado
138	138	38	2024-05-31	2024-09-30	En progreso
139	139	39	2024-06-01	2024-06-30	Completado
140	140	40	2024-06-02	2024-12-02	En progreso
141	141	41	2024-06-03	2024-11-03	Iniciado
142	142	42	2024-06-04	2024-10-04	En progreso
143	143	43	2024-06-05	2024-06-30	Completado
144	144	44	2024-06-06	2024-08-06	En progreso
145	145	45	2024-06-07	2024-07-07	Iniciado
146	146	46	2024-06-08	2024-09-08	En progreso
147	147	47	2024-06-09	2024-06-30	Completado
148	148	48	2024-06-10	2024-10-10	En progreso
149	149	49	2024-06-11	2024-06-30	Iniciado
150	150	50	2024-06-12	2024-12-12	En progreso
151	151	51	2024-06-13	2024-11-13	Completado
152	152	52	2024-06-14	2024-08-14	En progreso
153	153	53	2024-06-15	2024-06-30	Iniciado
154	154	54	2024-06-16	2024-09-16	En progreso
155	155	55	2024-06-17	2024-07-17	Completado
156	156	56	2024-06-18	2024-10-18	En progreso
157	157	57	2024-06-19	2024-06-30	Iniciado
158	158	58	2024-06-20	2024-08-20	En progreso
159	159	59	2024-06-21	2024-06-30	Completado
160	160	60	2024-06-22	2024-12-22	En progreso
161	161	61	2024-06-23	2024-11-23	Iniciado
162	162	62	2024-06-24	2024-09-24	En progreso
163	163	63	2024-06-25	2024-06-30	Completado
164	164	64	2024-06-26	2024-10-26	En progreso
165	165	65	2024-06-27	2024-07-27	Iniciado
166	166	66	2024-06-28	2024-08-28	En progreso
167	167	67	2024-06-29	2024-06-30	Completado
168	168	68	2024-06-30	2024-09-30	En progreso
169	169	69	2024-07-01	2024-07-31	Iniciado
170	170	70	2024-07-02	2024-12-02	En progreso
171	171	71	2024-07-03	2024-11-03	Completado
172	172	72	2024-07-04	2024-10-04	En progreso
173	173	73	2024-07-05	2024-07-31	Iniciado
174	174	74	2024-07-06	2024-08-06	En progreso
175	175	75	2024-07-07	2024-07-31	Completado
176	176	76	2024-07-08	2024-09-08	En progreso
177	177	77	2024-07-09	2024-07-31	Iniciado
178	178	78	2024-07-10	2024-10-10	En progreso
179	179	79	2024-07-11	2024-07-31	Completado
180	180	80	2024-07-12	2024-12-12	En progreso
181	181	81	2024-07-13	2024-11-13	Iniciado
182	182	82	2024-07-14	2024-08-14	En progreso
183	183	83	2024-07-15	2024-07-31	Completado
184	184	84	2024-07-16	2024-09-16	En progreso
185	185	85	2024-07-17	2024-07-31	Iniciado
186	186	86	2024-07-18	2024-10-18	En progreso
187	187	87	2024-07-19	2024-07-31	Completado
188	188	88	2024-07-20	2024-08-20	En progreso
189	189	89	2024-07-21	2024-07-31	Iniciado
190	190	90	2024-07-22	2024-12-22	En progreso
191	191	91	2024-07-23	2024-11-23	Completado
192	192	92	2024-07-24	2024-09-24	En progreso
193	193	93	2024-07-25	2024-07-31	Iniciado
194	194	94	2024-07-26	2024-10-26	En progreso
195	195	95	2024-07-27	2024-07-31	Completado
196	196	96	2024-07-28	2024-08-28	En progreso
197	197	97	2024-07-29	2024-07-31	Iniciado
198	198	98	2024-07-30	2024-09-30	En progreso
199	199	99	2024-07-31	2024-07-31	Completado
200	200	100	2024-08-01	2024-12-01	En progreso
\.


--
-- Data for Name: treatments; Type: TABLE DATA; Schema: public; Owner: neir
--

COPY public.treatments (id, name, description, cost) FROM stdin;
1	Endodoncia unirradicular	Tratamiento de conducto en diente de una raíz	350000.00
2	Endodoncia birradicular	Tratamiento de conducto en diente de dos raíces	450000.00
3	Endodoncia multirradicular	Tratamiento de conducto en molar	550000.00
4	Corona metal-cerámica	Corona con base metálica y recubrimiento cerámico	800000.00
5	Corona zirconio	Corona de zirconio monolítico	1200000.00
6	Implante dental titanio	Implante de titanio grado 4	1500000.00
7	Blanqueamiento dental	Blanqueamiento con peróxido de carbamida	300000.00
8	Limpieza dental	Profilaxis y detartraje	80000.00
9	Extracción simple	Extracción dental sin complicaciones	120000.00
10	Extracción quirúrgica	Extracción con levantamiento de colgajo	250000.00
11	Ortodoncia brackets metálicos	Tratamiento ortodóncico convencional	2500000.00
12	Ortodoncia brackets estéticos	Brackets de cerámica o zafiro	3500000.00
13	Ortodoncia invisible	Alineadores transparentes	4500000.00
14	Prótesis total superior	Dentadura completa superior	1800000.00
15	Prótesis total inferior	Dentadura completa inferior	1800000.00
16	Prótesis parcial removible	Prótesis con retenedores	1200000.00
17	Puente fijo 3 unidades	Puente de tres coronas	2400000.00
18	Carilla de porcelana	Lámina cerámica estética	650000.00
19	Resina compuesta	Obturación estética	150000.00
20	Amalgama dental	Obturación con amalgama	100000.00
21	Incrustación cerámica	Inlay/Onlay de porcelana	750000.00
22	Férula de descarga	Guarda oclusal para bruxismo	400000.00
23	Cirugía periodontal	Curetaje y alisado radicular	300000.00
24	Injerto gingival	Injerto de tejido blando	800000.00
25	Elevación seno maxilar	Aumento de hueso maxilar	2000000.00
26	Apicoectomía	Cirugía apical	600000.00
27	Frenectomía	Eliminación de frenillo	200000.00
28	Biopsia oral	Estudio histopatológico	350000.00
29	Selladores de fosetas	Prevención de caries	50000.00
30	Aplicación de flúor	Fluorización tópica	30000.00
31	Pulpotomía	Tratamiento pulpar vital	200000.00
32	Corona de acero	Corona pediátrica prefabricada	300000.00
33	Mantenedor de espacio	Aparato ortodóncico preventivo	450000.00
34	Protector bucal deportivo	Protección dental personalizada	250000.00
35	Radiografía periapical	Imagen diagnóstica dental	25000.00
36	Radiografía panorámica	Ortopantomografía	80000.00
37	TAC dental	Tomografía computarizada	200000.00
38	Cefalometría	Análisis radiográfico ortodóncico	100000.00
39	Modelo de estudio	Impresión diagnóstica	50000.00
40	Fotografía intraoral	Documentación clínica	20000.00
41	Anestesia local	Lidocaína con epinefrina	15000.00
42	Sedación consciente	Óxido nitroso	150000.00
43	Hemostasia	Control de hemorragia	100000.00
44	Sutura	Cierre de herida quirúrgica	80000.00
45	Drenaje de absceso	Evacuación de colección purulenta	200000.00
46	Curetaje dental	Eliminación de caries	50000.00
47	Pulido dental	Acabado y brillo	40000.00
48	Desensibilización	Tratamiento hipersensibilidad	120000.00
49	Blanqueamiento en consultorio	Peróxido de hidrógeno 35%	500000.00
50	Microabrasión	Eliminación manchas superficiales	300000.00
51	Composite estratificado	Restauración estética multicapa	400000.00
52	Reconstrucción con poste	Perno muñón fibra vidrio	350000.00
53	Corona temporal	Protección provisional	150000.00
54	Prótesis inmediata	Dentadura postextracción	2000000.00
55	Rebase protésico	Ajuste de prótesis	300000.00
56	Reparación de prótesis	Arreglo de dentadura	200000.00
57	Brackets autoligantes	Sistema ortodóncico avanzado	4000000.00
58	Retenedores ortodóncicos	Contención post-tratamiento	600000.00
59	Expansión maxilar	Aparato de expansión palatina	800000.00
60	Disyuntor palatino	Separación sutura media	1000000.00
61	Aparato funcional	Corrección clase II esqueletal	1500000.00
62	Lip bumper	Protector labial ortodóncico	400000.00
63	Quad helix	Expansor de cuatro hélices	600000.00
64	Pendulum	Distalización de molares	800000.00
65	Implante inmediato	Colocación postextracción	1800000.00
66	Carga inmediata	Restauración sobre implante	1200000.00
67	All-on-4	Rehabilitación total sobre 4 implantes	8000000.00
68	All-on-6	Rehabilitación total sobre 6 implantes	10000000.00
69	Injerto óseo	Regeneración ósea guiada	1500000.00
70	Membrana reabsorbible	Barrera regenerativa	400000.00
71	Plasma rico en plaquetas	Terapia regenerativa PRP	600000.00
72	Factores de crecimiento	Bioestimulación tisular	800000.00
73	Mini implantes	Implantes de diámetro reducido	800000.00
74	Implantes zigomáticos	Fijación en hueso zigomático	3000000.00
75	Implantes pterigoideos	Anclaje en apófisis pterigoides	2500000.00
76	Prótesis híbrida	Fija sobre implantes	6000000.00
77	Sobredentadura	Prótesis removible sobre implantes	4000000.00
78	Locators	Aditamentos de retención	300000.00
79	Barra-clip	Sistema de retención protésica	800000.00
80	Telescópicas	Coronas dobles	1500000.00
81	Ataches de precisión	Conectores protésicos	600000.00
82	Cirugía preprotésica	Preparación para prótesis	800000.00
83	Alveoloplastia	Remodelación de reborde alveolar	600000.00
84	Vestibuloplastia	Profundización del vestíbulo	800000.00
85	Gingivectomía	Eliminación de encía	200000.00
86	Gingivoplastia	Remodelación gingival	300000.00
87	Colgajo periodontal	Acceso quirúrgico periodontal	500000.00
88	Regeneración tisular guiada	RTG periodontal	1200000.00
89	Injerto óseo periodontal	Regeneración ósea	1000000.00
90	Corona de longitud	Alargamiento coronario	400000.00
91	Hemisección	División radicular	600000.00
92	Obturación retrógrada	Sellado apical	400000.00
93	MTA	Agregado trióxido mineral	200000.00
94	Revascularización pulpar	Regeneración endodóntica	800000.00
95	Apexificación	Inducción de cierre apical	500000.00
96	Recubrimiento pulpar	Protección pulpar directa	150000.00
97	Lima rotatoria	Instrumentación mecanizada	50000.00
98	Irrigación ultrasónica	Activación de irrigantes	100000.00
99	Obturación termoplástica	Condensación vertical caliente	150000.00
100	Retratamiento endodóntico	Reendodoncia	600000.00
101	Cirugía endodóntica	Microcirugía apical	800000.00
102	Blanqueamiento interno	Aclaramiento no vital	200000.00
103	Post de fibra	Poste estético radicular	250000.00
104	Post metálico	Poste colado	300000.00
105	Muñón colado	Base para corona	400000.00
106	Corona jacket	Corona completa cerámica	1000000.00
107	Puente Maryland	Puente adherido	1500000.00
108	Puente cantilever	Puente en voladizo	1800000.00
109	Provisionales	Restauraciones temporales	200000.00
110	Cementado definitivo	Fijación permanente	50000.00
111	Ajuste oclusal	Equilibrado de mordida	100000.00
112	Férula quirúrgica	Guía para implantes	400000.00
113	Planificación digital	Diseño asistido por computador	300000.00
114	Impresión digital	Escáner intraoral	200000.00
115	Diseño CAD-CAM	Restauración digital	500000.00
116	Fresado CAD-CAM	Manufactura digital	300000.00
117	Sinterizado	Proceso cerámico	200000.00
118	Glaseado	Acabado cerámico	100000.00
119	Caracterización	Pigmentación estética	150000.00
120	Estratificación	Técnica multicapa	200000.00
121	Infiltración de resina	Técnica ICON	250000.00
122	Carillas ultrafinas	Lentes de contacto dentales	800000.00
123	Mock-up	Ensayo estético	200000.00
124	Encerado diagnóstico	Planificación tridimensional	150000.00
125	Guía quirúrgica	Plantilla para cirugía	300000.00
126	Cirugía guiada	Implantología digital	500000.00
127	Carga diferida	Restauración en segunda fase	800000.00
128	Cicatrización sumergida	Primera fase implantológica	200000.00
129	Destape de implante	Segunda fase quirúrgica	150000.00
130	Pilar de cicatrización	Conformador gingival	200000.00
131	Impresión de implante	Transferencia protésica	150000.00
132	Pilar protésico	Aditamento para corona	400000.00
133	Pilar angulado	Corrección de angulación	500000.00
134	Pilar personalizado	Aditamento individualizado	800000.00
135	Tornillo protésico	Fijación de restauración	100000.00
136	Mantenimiento implante	Profilaxis periimplantaria	120000.00
137	Periimplantitis	Tratamiento de infección	600000.00
138	Destornillado	Desmontaje protésico	100000.00
139	Retorque	Ajuste de tornillería	80000.00
140	Radiografía de control	Seguimiento implantológico	50000.00
141	Resonancia magnética	Diagnóstico por imágenes	400000.00
142	Gammagrafía ósea	Medicina nuclear	600000.00
143	PET-CT	Tomografía por emisión de positrones	1500000.00
144	Biopsia incisional	Muestra parcial	300000.00
145	Biopsia excisional	Extirpación completa	500000.00
146	Citología exfoliativa	Estudio citológico	100000.00
147	Inmunohistoquímica	Marcadores moleculares	400000.00
148	PCR	Reacción en cadena de la polimerasa	200000.00
149	Cultivo bacteriano	Identificación microbiológica	150000.00
150	Antibiograma	Sensibilidad antibiótica	120000.00
151	Secuenciación genética	Análisis del ADN	800000.00
152	Marcadores tumorales	Detección oncológica	300000.00
153	Artroscopia ATM	Cirugía articular mínimamente invasiva	2000000.00
154	Artrocentesis	Lavado articular	800000.00
155	Inyección de ácido hialurónico	Viscosuplemento articular	600000.00
156	Toxina botulínica	Tratamiento neuromuscular	800000.00
157	Férula de reposicionamiento	Aparato para ATM	600000.00
158	Placa neuromiorelajante	Dispositivo oclusal	500000.00
159	Fisioterapia orofacial	Rehabilitación muscular	150000.00
160	Electroterapia	Estimulación eléctrica	100000.00
161	Laser terapia	Fotobiomodulación	200000.00
162	Crioterapia	Aplicación de frío	50000.00
163	Termoterapia	Aplicación de calor	50000.00
164	Masaje terapéutico	Técnica manual	80000.00
165	Ejercicios mandibulares	Terapia kinésica	60000.00
166	Relajación muscular	Técnicas de relajación	100000.00
167	Biofeedback	Retroalimentación biológica	200000.00
168	Psicoterapia dental	Manejo de ansiedad	300000.00
169	Hipnosis clínica	Técnica de relajación	400000.00
170	Musicoterapia	Terapia con música	100000.00
171	Aromaterapia	Terapia con aromas	80000.00
172	Ozono terapia	Tratamiento con ozono	150000.00
173	Plasma frío	Desinfección con plasma	200000.00
174	Fotodinámica	Terapia con luz	300000.00
175	Ultrasonido	Terapia ultrasónica	150000.00
176	Electroforesis	Administración transdérmica	120000.00
177	Iontoforesis	Aplicación de corriente	100000.00
178	Magnetoterapia	Campos magnéticos	180000.00
179	Acupuntura	Medicina tradicional china	200000.00
180	Homeopatía	Medicina alternativa	150000.00
181	Fitoterapia	Medicina herbal	100000.00
182	Nutrición dental	Asesoría nutricional	120000.00
183	Educación en salud oral	Programa preventivo	80000.00
184	Control de placa	Técnicas de higiene	60000.00
185	Uso de hilo dental	Técnica interproximal	30000.00
186	Enjuague bucal	Antiséptico oral	25000.00
187	Cepillado supervisado	Técnica de cepillado	40000.00
188	Revelador de placa	Evidenciador bacteriano	20000.00
189	Índices periodontales	Medición clínica	50000.00
190	Sondaje periodontal	Evaluación de bolsas	80000.00
191	Movilidad dental	Valoración de firmeza	30000.00
192	Oclusión dental	Análisis de mordida	100000.00
193	Articulador semiajustable	Simulador de movimientos	200000.00
194	Arco facial	Registro de posición	150000.00
195	Registro de mordida	Relación intermaxilar	100000.00
196	Montaje en articulador	Posicionamiento de modelos	150000.00
197	Encerado funcional	Diseño oclusal	200000.00
198	Llave de silicona	Guía de reducción	50000.00
199	Matriz provisional	Restauración temporal	80000.00
200	Aislamiento absoluto	Dique de goma	40000.00
201	Aislamiento relativo	Rollos de algodón	20000.00
202	Retracción gingival	Separación de encías	60000.00
203	Hemostasia local	Control de sangrado	50000.00
204	Electrocirugía	Corte y coagulación	150000.00
205	Radiocirugía	Cirugía con ondas de radio	300000.00
206	Piezocirugía	Cirugía ultrasónica	400000.00
207	Cirugía láser	Corte con láser	500000.00
\.


--
-- Data for Name: treatments_audit; Type: TABLE DATA; Schema: public; Owner: neir
--

COPY public.treatments_audit (id, treatment_id, action, changed_at, changed_by, before_data, after_data) FROM stdin;
\.


--
-- Name: appointments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neir
--

SELECT pg_catalog.setval('public.appointments_id_seq', 200, true);


--
-- Name: dental_histories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neir
--

SELECT pg_catalog.setval('public.dental_histories_id_seq', 200, true);


--
-- Name: dental_labs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neir
--

SELECT pg_catalog.setval('public.dental_labs_id_seq', 200, true);


--
-- Name: dentists_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neir
--

SELECT pg_catalog.setval('public.dentists_id_seq', 200, true);


--
-- Name: materials_audit_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neir
--

SELECT pg_catalog.setval('public.materials_audit_id_seq', 1, false);


--
-- Name: materials_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neir
--

SELECT pg_catalog.setval('public.materials_id_seq', 216, true);


--
-- Name: patients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neir
--

SELECT pg_catalog.setval('public.patients_id_seq', 200, true);


--
-- Name: payments_audit_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neir
--

SELECT pg_catalog.setval('public.payments_audit_id_seq', 3, true);


--
-- Name: payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neir
--

SELECT pg_catalog.setval('public.payments_id_seq', 201, true);


--
-- Name: procedures_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neir
--

SELECT pg_catalog.setval('public.procedures_id_seq', 201, true);


--
-- Name: teeth_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neir
--

SELECT pg_catalog.setval('public.teeth_id_seq', 202, true);


--
-- Name: treatment_plans_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neir
--

SELECT pg_catalog.setval('public.treatment_plans_id_seq', 200, true);


--
-- Name: treatments_audit_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neir
--

SELECT pg_catalog.setval('public.treatments_audit_id_seq', 1, false);


--
-- Name: treatments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neir
--

SELECT pg_catalog.setval('public.treatments_id_seq', 207, true);


--
-- Name: appointments appointments_pkey; Type: CONSTRAINT; Schema: public; Owner: neir
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_pkey PRIMARY KEY (id);


--
-- Name: dental_histories dental_histories_patient_id_key; Type: CONSTRAINT; Schema: public; Owner: neir
--

ALTER TABLE ONLY public.dental_histories
    ADD CONSTRAINT dental_histories_patient_id_key UNIQUE (patient_id);


--
-- Name: dental_histories dental_histories_pkey; Type: CONSTRAINT; Schema: public; Owner: neir
--

ALTER TABLE ONLY public.dental_histories
    ADD CONSTRAINT dental_histories_pkey PRIMARY KEY (id);


--
-- Name: dental_labs dental_labs_pkey; Type: CONSTRAINT; Schema: public; Owner: neir
--

ALTER TABLE ONLY public.dental_labs
    ADD CONSTRAINT dental_labs_pkey PRIMARY KEY (id);


--
-- Name: dentists dentists_pkey; Type: CONSTRAINT; Schema: public; Owner: neir
--

ALTER TABLE ONLY public.dentists
    ADD CONSTRAINT dentists_pkey PRIMARY KEY (id);


--
-- Name: materials_audit materials_audit_pkey; Type: CONSTRAINT; Schema: public; Owner: neir
--

ALTER TABLE ONLY public.materials_audit
    ADD CONSTRAINT materials_audit_pkey PRIMARY KEY (id);


--
-- Name: materials materials_pkey; Type: CONSTRAINT; Schema: public; Owner: neir
--

ALTER TABLE ONLY public.materials
    ADD CONSTRAINT materials_pkey PRIMARY KEY (id);


--
-- Name: patients patients_pkey; Type: CONSTRAINT; Schema: public; Owner: neir
--

ALTER TABLE ONLY public.patients
    ADD CONSTRAINT patients_pkey PRIMARY KEY (id);


--
-- Name: payments_audit payments_audit_pkey; Type: CONSTRAINT; Schema: public; Owner: neir
--

ALTER TABLE ONLY public.payments_audit
    ADD CONSTRAINT payments_audit_pkey PRIMARY KEY (id);


--
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: neir
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (id);


--
-- Name: procedures procedures_pkey; Type: CONSTRAINT; Schema: public; Owner: neir
--

ALTER TABLE ONLY public.procedures
    ADD CONSTRAINT procedures_pkey PRIMARY KEY (id);


--
-- Name: teeth teeth_pkey; Type: CONSTRAINT; Schema: public; Owner: neir
--

ALTER TABLE ONLY public.teeth
    ADD CONSTRAINT teeth_pkey PRIMARY KEY (id);


--
-- Name: treatment_materials treatment_materials_pkey; Type: CONSTRAINT; Schema: public; Owner: neir
--

ALTER TABLE ONLY public.treatment_materials
    ADD CONSTRAINT treatment_materials_pkey PRIMARY KEY (treatment_id, material_id);


--
-- Name: treatment_plans treatment_plans_pkey; Type: CONSTRAINT; Schema: public; Owner: neir
--

ALTER TABLE ONLY public.treatment_plans
    ADD CONSTRAINT treatment_plans_pkey PRIMARY KEY (id);


--
-- Name: treatments_audit treatments_audit_pkey; Type: CONSTRAINT; Schema: public; Owner: neir
--

ALTER TABLE ONLY public.treatments_audit
    ADD CONSTRAINT treatments_audit_pkey PRIMARY KEY (id);


--
-- Name: treatments treatments_pkey; Type: CONSTRAINT; Schema: public; Owner: neir
--

ALTER TABLE ONLY public.treatments
    ADD CONSTRAINT treatments_pkey PRIMARY KEY (id);


--
-- Name: materials ad_materials_audit_trg; Type: TRIGGER; Schema: public; Owner: neir
--

CREATE TRIGGER ad_materials_audit_trg AFTER DELETE ON public.materials FOR EACH ROW EXECUTE FUNCTION public.ad_materials_audit();


--
-- Name: payments ad_payments_audit_trg; Type: TRIGGER; Schema: public; Owner: neir
--

CREATE TRIGGER ad_payments_audit_trg AFTER DELETE ON public.payments FOR EACH ROW EXECUTE FUNCTION public.ad_payments_audit();


--
-- Name: treatments ad_treatments_audit_trg; Type: TRIGGER; Schema: public; Owner: neir
--

CREATE TRIGGER ad_treatments_audit_trg AFTER DELETE ON public.treatments FOR EACH ROW EXECUTE FUNCTION public.ad_treatments_audit();


--
-- Name: materials ai_materials_audit_trg; Type: TRIGGER; Schema: public; Owner: neir
--

CREATE TRIGGER ai_materials_audit_trg AFTER INSERT ON public.materials FOR EACH ROW EXECUTE FUNCTION public.ai_materials_audit();


--
-- Name: payments ai_payments_audit_trg; Type: TRIGGER; Schema: public; Owner: neir
--

CREATE TRIGGER ai_payments_audit_trg AFTER INSERT ON public.payments FOR EACH ROW EXECUTE FUNCTION public.ai_payments_audit();


--
-- Name: treatments ai_treatments_audit_trg; Type: TRIGGER; Schema: public; Owner: neir
--

CREATE TRIGGER ai_treatments_audit_trg AFTER INSERT ON public.treatments FOR EACH ROW EXECUTE FUNCTION public.ai_treatments_audit();


--
-- Name: materials au_materials_audit_trg; Type: TRIGGER; Schema: public; Owner: neir
--

CREATE TRIGGER au_materials_audit_trg AFTER UPDATE ON public.materials FOR EACH ROW EXECUTE FUNCTION public.au_materials_audit();


--
-- Name: payments au_payments_audit_trg; Type: TRIGGER; Schema: public; Owner: neir
--

CREATE TRIGGER au_payments_audit_trg AFTER UPDATE ON public.payments FOR EACH ROW EXECUTE FUNCTION public.au_payments_audit();


--
-- Name: treatments au_treatments_audit_trg; Type: TRIGGER; Schema: public; Owner: neir
--

CREATE TRIGGER au_treatments_audit_trg AFTER UPDATE ON public.treatments FOR EACH ROW EXECUTE FUNCTION public.au_treatments_audit();


--
-- Name: materials_audit materials_audit_block_delete; Type: TRIGGER; Schema: public; Owner: neir
--

CREATE TRIGGER materials_audit_block_delete BEFORE DELETE ON public.materials_audit FOR EACH ROW EXECUTE FUNCTION public.block_audit_immutable();


--
-- Name: materials_audit materials_audit_block_update; Type: TRIGGER; Schema: public; Owner: neir
--

CREATE TRIGGER materials_audit_block_update BEFORE UPDATE ON public.materials_audit FOR EACH ROW EXECUTE FUNCTION public.block_audit_immutable();


--
-- Name: payments_audit payments_audit_block_delete; Type: TRIGGER; Schema: public; Owner: neir
--

CREATE TRIGGER payments_audit_block_delete BEFORE DELETE ON public.payments_audit FOR EACH ROW EXECUTE FUNCTION public.block_audit_immutable();


--
-- Name: payments_audit payments_audit_block_update; Type: TRIGGER; Schema: public; Owner: neir
--

CREATE TRIGGER payments_audit_block_update BEFORE UPDATE ON public.payments_audit FOR EACH ROW EXECUTE FUNCTION public.block_audit_immutable();


--
-- Name: treatments_audit treatments_audit_block_delete; Type: TRIGGER; Schema: public; Owner: neir
--

CREATE TRIGGER treatments_audit_block_delete BEFORE DELETE ON public.treatments_audit FOR EACH ROW EXECUTE FUNCTION public.block_audit_immutable();


--
-- Name: treatments_audit treatments_audit_block_update; Type: TRIGGER; Schema: public; Owner: neir
--

CREATE TRIGGER treatments_audit_block_update BEFORE UPDATE ON public.treatments_audit FOR EACH ROW EXECUTE FUNCTION public.block_audit_immutable();


--
-- Name: appointments fk_appointment_dentist; Type: FK CONSTRAINT; Schema: public; Owner: neir
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT fk_appointment_dentist FOREIGN KEY (dentist_id) REFERENCES public.dentists(id);


--
-- Name: appointments fk_appointment_patient; Type: FK CONSTRAINT; Schema: public; Owner: neir
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT fk_appointment_patient FOREIGN KEY (patient_id) REFERENCES public.patients(id);


--
-- Name: dental_histories fk_history_patient; Type: FK CONSTRAINT; Schema: public; Owner: neir
--

ALTER TABLE ONLY public.dental_histories
    ADD CONSTRAINT fk_history_patient FOREIGN KEY (patient_id) REFERENCES public.patients(id);


--
-- Name: payments fk_payment_plan; Type: FK CONSTRAINT; Schema: public; Owner: neir
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT fk_payment_plan FOREIGN KEY (plan_id) REFERENCES public.treatment_plans(id);


--
-- Name: treatment_plans fk_plan_dentist; Type: FK CONSTRAINT; Schema: public; Owner: neir
--

ALTER TABLE ONLY public.treatment_plans
    ADD CONSTRAINT fk_plan_dentist FOREIGN KEY (dentist_id) REFERENCES public.dentists(id);


--
-- Name: treatment_plans fk_plan_patient; Type: FK CONSTRAINT; Schema: public; Owner: neir
--

ALTER TABLE ONLY public.treatment_plans
    ADD CONSTRAINT fk_plan_patient FOREIGN KEY (patient_id) REFERENCES public.patients(id);


--
-- Name: procedures fk_procedure_plan; Type: FK CONSTRAINT; Schema: public; Owner: neir
--

ALTER TABLE ONLY public.procedures
    ADD CONSTRAINT fk_procedure_plan FOREIGN KEY (plan_id) REFERENCES public.treatment_plans(id);


--
-- Name: procedures fk_procedure_tooth; Type: FK CONSTRAINT; Schema: public; Owner: neir
--

ALTER TABLE ONLY public.procedures
    ADD CONSTRAINT fk_procedure_tooth FOREIGN KEY (tooth_id) REFERENCES public.teeth(id);


--
-- Name: procedures fk_procedure_treatment; Type: FK CONSTRAINT; Schema: public; Owner: neir
--

ALTER TABLE ONLY public.procedures
    ADD CONSTRAINT fk_procedure_treatment FOREIGN KEY (treatment_id) REFERENCES public.treatments(id);


--
-- Name: treatment_materials fk_tm_material; Type: FK CONSTRAINT; Schema: public; Owner: neir
--

ALTER TABLE ONLY public.treatment_materials
    ADD CONSTRAINT fk_tm_material FOREIGN KEY (material_id) REFERENCES public.materials(id);


--
-- Name: treatment_materials fk_tm_treatment; Type: FK CONSTRAINT; Schema: public; Owner: neir
--

ALTER TABLE ONLY public.treatment_materials
    ADD CONSTRAINT fk_tm_treatment FOREIGN KEY (treatment_id) REFERENCES public.treatments(id);


--
-- PostgreSQL database dump complete
--

