--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4
-- Dumped by pg_dump version 16.4

-- Started on 2026-01-25 18:08:48

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
-- TOC entry 221 (class 1259 OID 59665)
-- Name: age_restrictions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.age_restrictions (
    age_id integer NOT NULL,
    age_category character varying(30) NOT NULL
);


--
-- TOC entry 220 (class 1259 OID 59664)
-- Name: age_restrictions_age_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.age_restrictions_age_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4962 (class 0 OID 0)
-- Dependencies: 220
-- Name: age_restrictions_age_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.age_restrictions_age_id_seq OWNED BY public.age_restrictions.age_id;


--
-- TOC entry 233 (class 1259 OID 59764)
-- Name: cards; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cards (
    token_id integer NOT NULL,
    payment_token text NOT NULL,
    last_four_digits character varying(4) NOT NULL,
    user_id integer NOT NULL
);


--
-- TOC entry 232 (class 1259 OID 59763)
-- Name: cards_token_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cards_token_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4963 (class 0 OID 0)
-- Dependencies: 232
-- Name: cards_token_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cards_token_id_seq OWNED BY public.cards.token_id;


--
-- TOC entry 223 (class 1259 OID 59674)
-- Name: categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.categories (
    category_id integer NOT NULL,
    category_name character varying(100) NOT NULL,
    category_name_en character varying(100),
    category_name_kk character varying(100)
);


--
-- TOC entry 222 (class 1259 OID 59673)
-- Name: categories_category_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.categories_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4964 (class 0 OID 0)
-- Dependencies: 222
-- Name: categories_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.categories_category_id_seq OWNED BY public.categories.category_id;


--
-- TOC entry 225 (class 1259 OID 59683)
-- Name: cities; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cities (
    city_id integer NOT NULL,
    city_name character varying(100) NOT NULL,
    city_name_en character varying(100),
    city_name_kk character varying(100)
);


--
-- TOC entry 224 (class 1259 OID 59682)
-- Name: cities_city_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cities_city_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4965 (class 0 OID 0)
-- Dependencies: 224
-- Name: cities_city_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cities_city_id_seq OWNED BY public.cities.city_id;


--
-- TOC entry 229 (class 1259 OID 59701)
-- Name: events; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.events (
    event_id integer NOT NULL,
    event_name character varying(200) NOT NULL,
    event_date date,
    event_place character varying(200),
    event_time time without time zone,
    description text,
    poster text,
    people_amount integer,
    age_id integer,
    category_id integer,
    city_id integer,
    organisator_id integer,
    event_name_en character varying(200),
    event_name_kk character varying(200),
    event_place_en character varying(200),
    event_place_kk character varying(200),
    description_en text,
    description_kk text
);


--
-- TOC entry 228 (class 1259 OID 59700)
-- Name: events_event_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.events_event_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4966 (class 0 OID 0)
-- Dependencies: 228
-- Name: events_event_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.events_event_id_seq OWNED BY public.events.event_id;


--
-- TOC entry 215 (class 1259 OID 59628)
-- Name: flyway_schema_history; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.flyway_schema_history (
    installed_rank integer NOT NULL,
    version character varying(50),
    description character varying(200) NOT NULL,
    type character varying(20) NOT NULL,
    script character varying(1000) NOT NULL,
    checksum integer,
    installed_by character varying(100) NOT NULL,
    installed_on timestamp without time zone DEFAULT now() NOT NULL,
    execution_time integer NOT NULL,
    success boolean NOT NULL
);


--
-- TOC entry 219 (class 1259 OID 59651)
-- Name: organisators; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.organisators (
    organisator_id integer NOT NULL,
    user_id integer NOT NULL
);


--
-- TOC entry 218 (class 1259 OID 59650)
-- Name: organisators_organisator_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.organisators_organisator_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4967 (class 0 OID 0)
-- Dependencies: 218
-- Name: organisators_organisator_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.organisators_organisator_id_seq OWNED BY public.organisators.organisator_id;


--
-- TOC entry 227 (class 1259 OID 59692)
-- Name: promocodes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.promocodes (
    promocode_id integer NOT NULL,
    promocode character varying(200) NOT NULL,
    price_charge double precision
);


--
-- TOC entry 226 (class 1259 OID 59691)
-- Name: promocodes_promocode_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.promocodes_promocode_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4968 (class 0 OID 0)
-- Dependencies: 226
-- Name: promocodes_promocode_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.promocodes_promocode_id_seq OWNED BY public.promocodes.promocode_id;


--
-- TOC entry 231 (class 1259 OID 59734)
-- Name: tickets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tickets (
    ticket_id integer NOT NULL,
    price double precision NOT NULL,
    user_id integer,
    event_id integer NOT NULL,
    quantity integer DEFAULT 1 NOT NULL,
    seat_details text
);


--
-- TOC entry 230 (class 1259 OID 59733)
-- Name: tickets_ticket_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tickets_ticket_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4969 (class 0 OID 0)
-- Dependencies: 230
-- Name: tickets_ticket_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tickets_ticket_id_seq OWNED BY public.tickets.ticket_id;


--
-- TOC entry 217 (class 1259 OID 59638)
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    user_name character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    phone_number character varying(255) NOT NULL,
    email character varying(255),
    user_photo text,
    role character varying(50),
    otp character varying(10),
    refresh_token character varying(250),
    otp_expiry_date timestamp without time zone,
    password_reset_token character varying(250),
    password_reset_token_expiry_date timestamp without time zone
);


--
-- TOC entry 216 (class 1259 OID 59637)
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4970 (class 0 OID 0)
-- Dependencies: 216
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- TOC entry 4735 (class 2604 OID 59668)
-- Name: age_restrictions age_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.age_restrictions ALTER COLUMN age_id SET DEFAULT nextval('public.age_restrictions_age_id_seq'::regclass);


--
-- TOC entry 4742 (class 2604 OID 59767)
-- Name: cards token_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cards ALTER COLUMN token_id SET DEFAULT nextval('public.cards_token_id_seq'::regclass);


--
-- TOC entry 4736 (class 2604 OID 59677)
-- Name: categories category_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories ALTER COLUMN category_id SET DEFAULT nextval('public.categories_category_id_seq'::regclass);


--
-- TOC entry 4737 (class 2604 OID 59686)
-- Name: cities city_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cities ALTER COLUMN city_id SET DEFAULT nextval('public.cities_city_id_seq'::regclass);


--
-- TOC entry 4739 (class 2604 OID 59704)
-- Name: events event_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.events ALTER COLUMN event_id SET DEFAULT nextval('public.events_event_id_seq'::regclass);


--
-- TOC entry 4734 (class 2604 OID 59654)
-- Name: organisators organisator_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organisators ALTER COLUMN organisator_id SET DEFAULT nextval('public.organisators_organisator_id_seq'::regclass);


--
-- TOC entry 4738 (class 2604 OID 59695)
-- Name: promocodes promocode_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.promocodes ALTER COLUMN promocode_id SET DEFAULT nextval('public.promocodes_promocode_id_seq'::regclass);


--
-- TOC entry 4740 (class 2604 OID 59737)
-- Name: tickets ticket_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tickets ALTER COLUMN ticket_id SET DEFAULT nextval('public.tickets_ticket_id_seq'::regclass);


--
-- TOC entry 4733 (class 2604 OID 59641)
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- TOC entry 4944 (class 0 OID 59665)
-- Dependencies: 221
-- Data for Name: age_restrictions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.age_restrictions (age_id, age_category) FROM stdin;
1	0+
2	6+
3	12+
4	14+
5	16+
6	18+
7	21+
\.


--
-- TOC entry 4956 (class 0 OID 59764)
-- Dependencies: 233
-- Data for Name: cards; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.cards (token_id, payment_token, last_four_digits, user_id) FROM stdin;
\.


--
-- TOC entry 4946 (class 0 OID 59674)
-- Dependencies: 223
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.categories (category_id, category_name, category_name_en, category_name_kk) FROM stdin;
1	Кино	Cinema	\N
2	Театры	Theatres	\N
3	Концерты	Concerts	\N
4	STAND UP	Stand Up	\N
5	Спорт	Sport	\N
6	Бизнес-форумы	Business Forums	\N
7	Выставки	Exhibitions	\N
8	Мастер-классы	Master Classes	\N
9	Детям	For Kids	\N
10	Развлечения	Entertainment	\N
\.


--
-- TOC entry 4948 (class 0 OID 59683)
-- Dependencies: 225
-- Data for Name: cities; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.cities (city_id, city_name, city_name_en, city_name_kk) FROM stdin;
1	Астана	Astana	\N
2	Алматы	Almaty	\N
3	Актобе	Aktobe	\N
4	Актау	Aktau	\N
5	Караганда	Karaganda	\N
6	Кокшетау	Kokshetau	\N
7	Костанай	Kostanay	\N
8	Павлодар	Pavlodar	\N
9	Семей	Semey	\N
10	Ташкент	Tashkent	\N
11	Тараз	Taraz	\N
12	Талдыкорган	Taldykorgan	\N
13	Шымкент	Shymkent	\N
14	Усть-Каменогорск	Ust-Kamenogorsk	\N
\.


--
-- TOC entry 4952 (class 0 OID 59701)
-- Dependencies: 229
-- Data for Name: events; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.events (event_id, event_name, event_date, event_place, event_time, description, poster, people_amount, age_id, category_id, city_id, organisator_id, event_name_en, event_name_kk, event_place_en, event_place_kk, description_en, description_kk) FROM stdin;
78	AI Conf 2025 Dushanbe	2025-10-25	Crowne Plaza Hotel, Dushanbe EXPO	09:00:00	Будущее искусственного интеллекта не просто обсуждается, оно создаётся здесь и сейчас! Глобальный диалог об ИИ с участием новаторов, полисимейкеров и лидеров индустрии из более чем 30 стран. (Место проведения: Душанбе).	static/eventPhoto/ai_conf.jpg	800	5	6	1	16	AI Conf 2025 Dushanbe	\N	Crowne Plaza Hotel, Dushanbe EXPO	\N	The future of artificial intelligence is not just being discussed, it is being created here and now! A global dialogue on AI featuring innovators, policymakers, and industry leaders from over 30 countries. (Location: Dushanbe).	\N
73	Арт-вечеринка от студии Michael Art в Шымкенте	2025-11-08	Ресторан "The paragon" ул.Байдибек би 229	17:00:00	Мы приглашаем тебя провести с нами самое яркое и эксклюзивное событие этого года Арт-вечеринку от студии Michael Art.	static/eventPhoto/арт_вечеринка.jpg	20	3	8	13	7	Art Party by Michael Art Studio in Shymkent	\N	The Paragon Restaurant, Baidibek Bi St 229	\N	We invite you to spend the brightest and most exclusive event of this year with us - the Art Party from Michael Art studio.	\N
74	Массовое посещение бассейна в СК «Бурабай»	2025-10-16	Ледовый дворец «Бурабай», Бассейн	08:00:00	Массовое посещение бассейна в Спортивном комплексе «Бурабай». Дети до 7 лет в маленьком бассейне с родителями. Вместимость - 50 человек за 1 час.	static/eventPhoto/basseyn_burabay.jpg	50	1	5	6	3	Public Swimming at "Burabay" Sports Complex	\N	Burabay Ice Palace, Swimming Pool	\N	Mass visit to the swimming pool at the "Burabay" Sports Complex. Children under 7 years old in a small pool with parents. Capacity - 50 people per 1 hour.	\N
75	Спектакль «Қобыланды»	2025-10-16	Драмтеатр им. Т. Ахтанова	18:30:00	Спектакль "Кобыланды" по мотивам произведения. Жанр: Ауыз әдебиеті. Режиссер: Дина Жұмабаева.	static/eventPhoto/kobylandy_batyr.jpg	400	3	2	3	15	Play "Kobylandy"	\N	T. Akhtanov Drama Theatre	\N	Play "Kobylandy" based on the work. Genre: Oral literature / Folklore. Director: Dina Zhumabayeva.	\N
76	Цирк Шапито ELDORADO в Семее	2025-10-18	Цирк Шапито Семей	16:00:00	Цирк Шапито «EldoradO» с программой «Морское Чудо». 100 минут незабываемого ШОУ: акробатические трюки, группа экзотических животных (морской заяц «ЧАРЛИ», крокодил «Варя», змеи), дрессированные Ротвейлеры.	static/eventPhoto/tsirk_eldorado.jpg	1000	1	9	9	18	ELDORADO Big Top Circus in Semey	\N	Semey Big Top Circus	\N	Big Top Circus "EldoradO" with the program "Sea Miracle". 100 minutes of an unforgettable SHOW: acrobatic stunts, a group of exotic animals (sea hare "CHARLIE", crocodile "Varya", snakes), trained Rottweilers.	\N
77	Выставка «Пабло Пикассо. Параграфы»	2025-10-16	Галерея LM Kulanshi Art	10:00:00	Самое громкое имя в искусстве XX века - на выставке от музея Lumiere-Hall. Неистовый гений, создавший десятки тысяч произведений, величайший новатор современности.	static/eventPhoto/pikasso_paragraphs.jpg	500	1	7	1	7	Exhibition "Pablo Picasso. Paragraphs"	\N	LM Kulanshi Art Gallery	\N	The loudest name in 20th-century art - at the exhibition from the Lumiere-Hall Museum. A frantic genius who created tens of thousands of works, the greatest innovator of modern times.	\N
88	Deep Purple в Алматы	2026-04-22	Almaty Arena 2	20:00:00	Легендарное возвращение Deep Purple в Казахстан самое ожидаемое рок-событие года! Стань частью истории встреться с легендами. 22 апреля 2026 года в Алматы, Казахстан, мы рады приветствовать культовую британскую рок-группу Deep Purple с живым концертом на сцене Almaty Arena.\nДополнительно к вашему билету вы можете приобрести VIP-пакет Meet & Greet Upgrade на сайте группы.	/uploads/event_posters/86d47c7e-6917-49e0-96e4-ed5d6679e689.jpg	2000	1	3	2	21	Deep Purple in Almaty	\N	Almaty Arena 2	\N	The legendary return of Deep Purple to Kazakhstan is the most anticipated rock event of the year! Become part of history, meet the legends. On April 22, 2026, in Almaty, Kazakhstan, we are pleased to welcome the cult British rock band Deep Purple with a live concert on the stage of Almaty Arena. Additionally, you can purchase a VIP Meet & Greet Upgrade package on the band's website.	\N
89	MEGADETH	2026-06-28	СТАДИОН СПАРТАК (Центральный парк), адрес: ул Гоголя, д1, стр 10	17:00:00	MEGADETH это рубеж, после которого метал уже никогда не будет прежним.\n\nПочти невозможно представить, куда бы пришла тяжёлая музыка и культура без группы, основанной, возглавляемой и движимой вокалистом, гитаристом, автором песен и продюсером Дэйвом Мастейном.\n\nС 1983 года MEGADETH остаются одной из самых значимых и влиятельных сил в метале. На их счету 50 миллионов проданных пластинок, премия Grammy и 12 номинаций, миллиарды стримов, семь альбомов в десятке лучших Billboard 200 и армии фанатов по всему миру. Их присутствие ощущается везде от татуировок на знаменитостях до появления в культовых фильмах, сериалах и поп-культуре на протяжении десятилетий.\n\nВ 2025 году коллектив выпустил сингл к новому 17-ому студийному альбому MEGADETH и звучит живее, яростнее и технически сильнее, чем когда-либо. Это скоростной, хлёсткий и филигранно исполненный метал с фирменными риффами, безумными соло, резкими ритмами и острыми текстами, сочетающими ярость и философские размышления.\n\nВ состав группы входят Дэйв Мастейн, Теэму Мянтюсаари (гитара), Джеймс Ломенцо (бас) и Дирк Вербёрен (ударные).\n\nMEGADETH продолжает бросать вызов жанру и расширять его границы, создавая безупречно точный, сложный и цепляющий трэш.\n\nНе пропустите впервые в Казахстане мощный концерт MEGADETH на стадионе Спартак 28 июня 2026!	/uploads/event_posters/b45324fa-759b-4e99-b7fa-564f4b9255ff.jpg	2400	1	3	2	21	MEGADETH	\N	Spartak Stadium (Central Park), Gogol St 1, bld 10	\N	MEGADETH is a milestone after which metal will never be the same. Since 1983, MEGADETH has remained one of the most significant and influential forces in metal. They have 50 million records sold, a Grammy Award and 12 nominations. In 2025, the band released a single for the new 17th studio album. The lineup includes Dave Mustaine, Teemu Mantysaari, James LoMenzo, and Dirk Verbeuren. Don't miss the powerful MEGADETH concert for the first time in Kazakhstan on June 28, 2026!	\N
69	PGL Astana 2026 (Киберспорт)	2026-05-15	Барыс Арена	08:00:00	После оглушительного успеха PGL Astana в 2025 году, когда зрители в столице Казахстана стали свидетелями захватывающего турнира уровня Tier-1 по Counter-Strike и отпраздновали победу Team Spirit, PGL возвращаются с еще одним событием, которое обязательно нужно посетить: PGL Astana 2026!	static/eventPhoto/pgl_astana.jpg	10000	5	5	1	20	PGL Astana 2026 (Esports)	\N	Barys Arena	\N	After the resounding success of PGL Astana in 2025, when viewers in the capital of Kazakhstan witnessed a thrilling Tier-1 Counter-Strike tournament and celebrated Team Spirit's victory, PGL returns with another must-visit event: PGL Astana 2026!	\N
40	Сольный концерт группы MOLDANAZAR	2025-11-22	Казахконцерт им. Розы Баглановой, Проспект Мангилик Ел, 10/1	19:30:00	22 ноября на сцене Казахконцерта им. Розы Баглановой состоится уникальный концерт группы Moldanazar в новом формате. Впервые любимые хиты прозвучат в сопровождении симфонического оркестра, придавая им особую глубину и масштабность. Зрителей ждет неповторимое сочетание синти-попа, инди-рока и авторской подачи, за которые коллектив полюбился тысячам поклонников. Прозвучат проникновенные композиции Ozin gana, Alystama, Aqpen Birge и многие другие песни, ставшие визитной карточкой группы.	static/eventPhoto/moldanazar.jpg	3500	5	3	1	2	MOLDANAZAR Solo Concert	\N	Roza Baglanova Kazakh Concert Hall, Mangilik Yel Ave, 10/1	\N	On November 22, a unique concert by the band Moldanazar will take place in a new format at the Roza Baglanova Kazakh Concert Hall. For the first time, beloved hits will be performed with a symphony orchestra, giving them special depth and scale. The audience can expect a unique combination of synth-pop, indie-rock, and original style. Soulful compositions like Ozin gana, Alystama, Aqpen Birge, and many others will be performed.	\N
52	Сольный Stand Up концерт Сауле Юсуповой	2025-11-08	Almaty Theatre	19:00:00	Сольный Stand Up концерт Сауле Юсуповой в Алматы! Сауле - одна из самых популярных стендап-комиков, известная своим уникальным стилем и жизненными наблюдениями, которые она превращает в искрометные шутки. Приготовьтесь к вечеру, полному откровенного и смешного юмора. Возрастное ограничение: 18+.	static/eventPhoto/saule_yusupova.jpg	800	6	4	2	9	Saule Yusupova Solo Stand Up Concert	\N	Almaty Theatre	\N	Saule Yusupova's Solo Stand Up Concert in Almaty! Saule is one of the most popular stand-up comedians, known for her unique style and life observations, which she turns into sparkling jokes. Get ready for an evening full of frank and funny humor. Age restriction: 18+.	\N
41	Zoloto в Астане	2025-11-23	Конгресс центр	20:00:00	ZOLOTO – это сольный проект Владимира Золотухина, автора, фронтмена и мультиинструменталиста, исполняющего «фешенебельную эстраду» с ностальгическим звучанием, вне времени. Его музыка сочетает инди-поп с элементами диско и ностальгическими отсылками к поп-культуре 90-х и 00-х, создавая атмосферу подлинной внутренней свободы и любви. В составе группы — опытные музыканты: Герман Тигай (бас), Даниил Морозов (барабаны) и Игорь Грибов (гитара/клавиши). У ZOLOTO четыре альбома, включая последний, «Перевоплотиться» (2024), который стал полностью гитарным и вошел в мировые ТОП-чарты. Живые выступления группы, включая глубокий акустический блок, дарят слушателям настоящий катарсис.	static/eventPhoto/zoloto_concert.jpg	2102	5	3	1	4	Zoloto in Astana	\N	Congress Center	\N	ZOLOTO is the solo project of Vladimir Zolotukhin, an author, frontman, and multi-instrumentalist performing "fashionable pop" with a timeless, nostalgic sound. His music combines indie-pop with disco elements and nostalgic references to the pop culture of the 90s and 00s. The band includes experienced musicians: German Tigay (bass), Daniil Morozov (drums), and Igor Gribov (guitar/keys). ZOLOTO has four albums, including the latest "Reincarnate" (2024).	\N
49	Сольный стендап-концерт Алексея Квашонкина	2025-10-29	Harat's Pub (Астана)	20:00:00	Алексей Квашонкин - один из самых ярких представителей российской стендап-комедии, известный своим циничным и ироничным стилем. Его выступления отличаются остротой, актуальностью и неподдельной самоиронией. В своей программе Алексей поднимет насущные темы, которые близки каждому. Вас ждет вечер чистого, нефильтрованного юмора.	static/eventPhoto/kvashonkin_standup.jpg	450	6	4	1	9	Alexey Kvashonkin Solo Stand-up	\N	Harat's Pub (Astana)	\N	Alexey Kvashonkin is one of the brightest representatives of Russian stand-up comedy, known for his cynical and ironic style. His performances are characterized by sharpness, relevance, and genuine self-irony. In his program, Alexey will raise vital topics close to everyone. An evening of pure, unfiltered humor awaits you.	\N
42	Диана Арбенина в Караганде	2025-11-07	Центр бокса им. С. Сапиева	19:00:00	Долгожданное возвращение! 7 ноября 2025 года Диана Арбенина и группа «Ночные Снайперы» вновь выйдут на сцену Центра бокса им. С. Сапиева в Караганде. Поклонников ждет вечер настоящего рок-н-ролла, наполненный невероятной энергетикой и пронзительной лирикой. Прозвучат как легендарные хиты, проверенные временем, так и новые композиции. Это событие отличная возможность вновь ощутить мощь живого выступления одной из главных рок-исполнительниц и услышать любимые песни вживую.	static/eventPhoto/diana_arbenina.jpg	1500	3	3	5	12	Diana Arbenina in Karaganda	\N	S. Sapiyev Boxing Center	\N	A long-awaited return! On November 7, 2025, Diana Arbenina and the "Night Snipers" band will take the stage at the S. Sapiyev Boxing Center in Karaganda. Fans can expect an evening of real rock and roll, filled with incredible energy and poignant lyrics. Both legendary hits and new compositions will be performed.	\N
43	«САЦ» Гастроли	2025-11-05	пр.Н.Назарбаева, 19/1, Русский драматический театр им.Станиславского	18:30:00	«САЦ» - спектакль-реконструкция, основанный на реальных событиях. 7 ноября 1945 года в Алма-Ате остаётся всего один час до открытия первого театра для детей и юношества в Казахстане. На сцене идёт репетиция сказки Евгения Шварца «Красная Шапочка», режиссёр Наталия Ильинична Сац готовит актёров к премьере, в зале звучат голоса, за кулисами идут последние приготовления. В этой постановке оживают великие деятели прошлого: Вера Марецкая, Всеволод Мейерхольд, Евгений Вахтангов, Сергей Эйзенштейн, Николай Черкасов, Канабек Байсеитов, Курманбек Жандарбеков, юный Юрий Померанцев. История театра предстает перед зрителями как живой миф, где судьбы, встречи, творческие откровения и драматические повороты сливаются в единое полотно. В спектакле задействован звездный состав театра: в роли Наталии Ильиничны Сац - прима театра заслуженная артистка Казахстана Татьяна Тарская и заслуженный деятель Казахстана Татьяна Костюченко, в роли Веры Марецкой - народная артистка Казахстана Ольга Коржева, также в нем заняты молодые артисты театра. «САЦ» - это спектакль о легендарном времени, о силе искусства и о женщине, имя которой стало символом детского театра во всем мире. Это не просто воспоминание - это культурный код города, признание в любви к сцене и тем, кто её создавал.	static/eventPhoto/SACH.jpeg	500	2	2	5	3	"SATS" Tour	\N	N. Nazarbayev Ave, 19/1, Stanislavsky Russian Drama Theatre	\N	"SATS" is a reconstruction play based on real events. On November 7, 1945, in Alma-Ata, only one hour remains before the opening of the first theatre for children and youth in Kazakhstan. A rehearsal of Evgeny Schwartz's fairy tale "Little Red Riding Hood" is underway on stage; director Natalya Ilyinichna Sats is preparing actors for the premiere. In this production, great figures of the past come to life. "SATS" is a play about a legendary time, the power of art, and a woman whose name became a symbol of children's theatre worldwide.	\N
44	The Universe of Hans Zimmer	2025-10-27	Дворец культуры им. И. Жансугурова	19:00:00	На сцене более 30 музыкантов оркестра и хора исполнят музыку одного из самых известных, популярных и влиятельных кинокомпозиторов современности - Ханса Циммера. Он оказал колоссальное влияние на новейшую историю голливудского кино и поп-культуру в целом. А также, благодаря его музыке большинство фильмов получили ту самую известность, которую имеют сейчас. В программе концерта: «Дюна 1 и 2», «Интерстеллар», «Бэтман»,«Гладиатор», «Начало», «Кунг-Фу Панда», «Пираты Карибского моря», «Король Лев», «Шерлок Холмс» , «Мадагаскар», «Перл-Харбор», «Последний Самурай», «Человек из стали», «Call of Duty». Вас ждёт колоссальный живой звук под видеоряд в исполнении большого симфонического оркестра и хора.	static/eventPhoto/the_universe_of_hans_zimmer.jpg	1250	2	3	12	8	The Universe of Hans Zimmer	\N	I. Zhansugurov Palace of Culture	\N	More than 30 musicians of the orchestra and choir will perform the music of one of the most famous and influential film composers of our time - Hans Zimmer. The program includes music from: Dune 1 & 2, Interstellar, Batman, Gladiator, Inception, Kung Fu Panda, Pirates of the Caribbean, The Lion King, Sherlock Holmes, Madagascar, Pearl Harbor, The Last Samurai, Man of Steel, Call of Duty.	\N
45	ДО-ДЕС-КА-ДЭН	2025-10-26	Ақмола областық мәдениет басқармасы Шахмет Құсайынов атындағы областық қазақ музыкалық-драма театры	17:00:00	«ДОДЕСКАДЭН» түрлі тағдырларды арқау еткен, терең мағынаға толы тың туынды. Бұл шығарма Жапондық атақты кино режиссер Акира Куросаваның кино сценарийі желісі бойынша театр сахнасында тұңғыш рет сахналанды. Қойылым арқылы көрерменге тек әлеуметтік мәселе емес, адам болмысы, арман мен қиялдың құдыреті, жаны жаралы жандардың ішкі драмасы жеткізіледі. Мұндағы әр кейіпкердің жан тебіренісі үміт пен үнсіздік арасындағы үнсіз күрестің шуы. До-дес-ка-дэн жүрек дауысы. Мәртебелі көрермен, аталған спектакль камералық театр үлгісінде қойылған ерекше форматтағы туынды екенін ескеріңіз. Кейіпкерлер әлемін терең түсіну үшін спектакльді төрт тараптан, төрт рет тамашалау ұсынылады.	static/eventPhoto/do_des_ka_den.jpg	480	5	2	6	2	DO-DES-KA-DEN	\N	Shakhmet Kusayinov Regional Kazakh Music and Drama Theatre	\N	"DO-DES-KA-DEN" is a deep work based on various destinies. This piece is staged for the first time in the theatre based on the screenplay by famous Japanese film director Akira Kurosawa. The performance conveys not only social issues but also human nature, the power of dreams and imagination, and the inner drama of wounded souls. Please note that this performance is staged in a chamber theatre format.	\N
46	Севак Ханагян в Астане	2025-10-18	Отель Rixos President Astana	20:00:00	Севак Ханагян — армянский и российский певец, автор песен, победитель шоу «Главная сцена», участник «Голоса», наставник «Голоса Армении» и победитель «Х-Фактор-7». Песни Севака Ханагяна пронизаны глубокими эмоциями и лирикой, которые находят отклик в сердцах слушателей. Зрителей ждет чувственный вечер, наполненный любимыми хитами, такими как «Не молчи», «Когда мы с тобой», «Добро пожаловать» и новыми композициями.	static/eventPhoto/sevak_khanagyan.jpg	1000	3	3	1	4	Sevak Khanagyan in Astana	\N	Rixos President Astana Hotel	\N	Sevak Khanagyan is an Armenian and Russian singer, songwriter, winner of the "Main Stage" show, participant of "The Voice", mentor of "The Voice of Armenia" and winner of "X-Factor-7". Sevak's songs are permeated with deep emotions and lyrics that resonate in the hearts of listeners. A sensual evening awaits the audience, filled with beloved hits like "Don't be silent", "When we are together", and new compositions.	\N
47	ФК «Астана» - ФК «Актобе»	2025-10-19	Астана Арена	17:00:00	Футбольный матч между командами «Астана» и «Актобе» в рамках чемпионата Казахстана. Нас ждет захватывающая встреча двух сильнейших клубов, которые продемонстрируют свое мастерство и волю к победе. Приходите поддержать свою любимую команду и насладиться атмосферой настоящего футбольного праздника.	static/eventPhoto/fc_astana_aktobe.png	30000	2	5	1	17	FC Astana - FC Aktobe	\N	Astana Arena	\N	Football match between "Astana" and "Aktobe" teams within the framework of the Kazakhstan Championship. We are waiting for an exciting meeting of two strongest clubs that will demonstrate their skills and will to win. Come to support your favorite team and enjoy the atmosphere of a real football holiday.	\N
48	«Алма-Ата 89»	2025-10-23	ARTиШОК театр	19:00:00	Спектакль «Алма-Ата 89» в театре ARTиШОК - это попытка реконструировать и осмыслить события 1989 года. Постановка является размышлением о переломном моменте в истории, о судьбах людей и о том, как прошлое влияет на настоящее. Зрителей ждет глубокое погружение в атмосферу того времени через игру актеров и уникальную сценографию.	static/eventPhoto/alma_ata_89.jpg	300	6	2	2	6	"Alma-Ata 89"	\N	ARTiSHOCK Theatre	\N	The play "Alma-Ata 89" at the ARTiSHOCK Theatre is an attempt to reconstruct and comprehend the events of 1989. The production is a reflection on a turning point in history, on the fates of people, and on how the past influences the present. The audience awaits a deep immersion into the atmosphere of that time through the acting and unique set design.	\N
50	Собор Парижской Богоматери	2025-10-29	Astana Opera	19:00:00	Балет в двух действиях по мотивам одноименного романа Виктора Гюго. Это произведение — бессмертная история о любви, красоте и уродстве, сострадании и жестокости. Хореография передает всю драматическую силу романа, а декорации и костюмы погружают в атмосферу средневекового Парижа. На сцене выступят ведущие солисты театра Astana Opera.	static/eventPhoto/sobor_parizhskoy_bogomateri.jpg	1200	3	2	1	11	Notre Dame de Paris	\N	Astana Opera	\N	Ballet in two acts based on the novel by Victor Hugo. This work is an immortal story about love, beauty and ugliness, compassion and cruelty. The choreography conveys all the dramatic power of the novel, and the sets and costumes immerse you in the atmosphere of medieval Paris. Leading soloists of the Astana Opera theatre will perform on stage.	\N
51	AStudio в Алматы	2025-11-07	Дворец Республики	20:00:00	Главное музыкальное событие осени! Легендарная группа A'STUDIO вновь в Алматы! 7 ноября 2025 года на сцене Дворца Республики прозвучат любимые хиты, которые покорили сердца миллионов, такие как «Джулия», «Улетаю» и многие другие. Невероятная атмосфера, живой звук и самые душевные песни ждут вас в этот вечер!	static/eventPhoto/a_studio.jpg	3000	2	3	2	25	A'Studio in Almaty	\N	Palace of the Republic	\N	The main musical event of the autumn! The legendary group A'STUDIO is back in Almaty! On November 7, 2025, beloved hits that conquered the hearts of millions, such as "Julia", "Fly Away" (Uletayu) and many others, will be performed on the stage of the Palace of the Republic. Incredible atmosphere, live sound and the most soulful songs await you this evening!	\N
53	Truwer в Алматы	2025-11-13	Дворец спорта им. Балуана Шолака	20:00:00	Truwer - казахстанский рэп-исполнитель, завоевавший популярность благодаря своим атмосферным трекам и глубоким текстам. Его музыка сочетает хип-хоп с элементами других жанров, создавая уникальное звучание. На концерте прозвучат как старые хиты, так и треки из новых релизов. Возрастное ограничение: 16+.	static/eventPhoto/truwer.png	3500	5	3	2	4	Truwer in Almaty	\N	Baluan Sholak Sports Palace	\N	Truwer is a Kazakhstani rap artist who gained popularity thanks to his atmospheric tracks and deep lyrics. His music combines hip-hop with elements of other genres, creating a unique sound. The concert will feature both old hits and tracks from new releases. Age restriction: 16+.	\N
54	Симфонические телепортации - 2	2025-11-20	Концертный зал Государственной академической филармонии им Е.Рахмадиева	19:00:00	Торжественное открытие XXVII концертного сезона Симфонического оркестра. В программе прозвучат шедевры мировой классики, включая Концерт для скрипки с оркестром № 3 си минор Камиля Сен-Санса. Вечер станет подтверждением статуса Астаны как центра высоких художественных стандартов.	static/eventPhoto/symfonicheskie_telportachii.jpg	800	2	3	1	4	Symphonic Teleportations - 2	\N	E. Rakhmadiev State Academic Philharmonic Concert Hall	\N	Grand opening of the XXVII concert season of the Symphony Orchestra. The program will feature masterpieces of world classics, including Camille Saint-Saens' Violin Concerto No. 3 in B minor. The evening will be a confirmation of Astana's status as a center of high artistic standards.	\N
55	Галым Калиакбаров - Stand Up концерт	2025-11-22	Алматы, Конкордия, Богенбай батыра 151	19:00:00	Большой сольный Stand Up концерт Галыма Калиакбарова в Алматы. Галым известен своим искрометным юмором, основанным на жизненных наблюдениях и национальной специфике. Зрителей ждет 1,5-2 часа смеха и позитива. Сбор гостей с 18:00, начало в 19:00.	static/eventPhoto/galym_kaliakbarov.png	550	6	4	2	9	Galym Kaliakbarov - Stand Up Concert	\N	Concordia, Bogenbai Batyr 151, Almaty	\N	Big solo Stand Up concert of Galym Kaliakbarov in Almaty. Galym is known for his sparkling humor based on life observations and national specifics. The audience can expect 1.5-2 hours of laughter and positivity. Guests gather from 18:00, start at 19:00.	\N
56	Бағжан Октябрь с концертной программой «Терапия души»	2025-11-22	Дворец Спорта Балуан Шолак	20:00:00	Бағжан Октябрь представляет свою новую концертную программу «Терапия души». Его песни — это глубокие, лиричные истории, которые касаются самых потаенных струн души. Артист обещает незабываемый вечер, наполненный искренними эмоциями и качественной музыкой.	static/eventPhoto/terapia_dushi.jpg	3200	3	3	2	4	Bagzhan October: "Soul Therapy"	\N	Baluan Sholak Sports Palace	\N	Bagzhan October presents his new concert program "Soul Therapy". His songs are deep, lyrical stories that touch the most secret strings of the soul. The artist promises an unforgettable evening filled with sincere emotions and quality music.	\N
57	Polina Hanym в Алматы	2025-11-23	Джаз клуб Everjazz, ул. Гоголя, 40б	18:00:00	23 ноября мы перенесём вас в солнечный Рио-де-Жанейро прямо в сердце Алматы. Polina Hanym исполнит лучшие композиции в жанре джаз, погружая слушателей в атмосферу бразильской босса-новы и латиноамериканских ритмов.	static/eventPhoto/polina_hanym.jpg	200	2	3	2	25	Polina Hanym in Almaty	\N	Everjazz Jazz Club, Gogol St, 40b	\N	On November 23, we will transport you to sunny Rio de Janeiro right in the heart of Almaty. Polina Hanym will perform the best compositions in the jazz genre, immersing listeners in the atmosphere of Brazilian bossa nova and Latin American rhythms.	\N
58	Алсу в Алматы	2025-11-02	Дворец Республики	20:00:00	Долгожданный концерт Алсу в Казахстане! Певица приглашает вас на незабываемый вечер музыки, наполненный теплотой, искренностью и атмосферой волшебства. Не упустите шанс услышать любимые хиты «Зимний сон», «Иногда» и новые песни в живом исполнении.	static/eventPhoto/alsu.jpg	3000	2	3	2	25	Alsou in Almaty	\N	Palace of the Republic	\N	Long-awaited concert of Alsou in Kazakhstan! The singer invites you to an unforgettable evening of music filled with warmth, sincerity, and an atmosphere of magic. Do not miss the chance to hear beloved hits "Winter Dream", "Sometimes" and new songs performed live.	\N
63	Аш пен тоқ (2025)	2025-10-18	Chaplin Mega Almaty	10:00:00	Айдар и Эльдар — бывшие одноклассники, чьи жизни сложились по-разному: один — отец семейства без стабильного дохода, другой — успешный бизнесмен, лишённый родительского счастья. Случайная встреча перерастает в откровенный разговор, в котором каждый мечтает оказаться на месте другого. На следующее утро они просыпаются в телах друг друга. Вынужденные жить чужой жизнью, герои сталкиваются с неожиданными трудностями, меняющими их представление о счастье, успехе и настоящем богатстве.	static/eventPhoto/аш_пен_ток.jpg	300	5	1	2	1	The Hungry and The Full (2025)	\N	Chaplin Mega Almaty	\N	Aidar and Eldar are former classmates whose lives turned out differently: one is a family man without a stable income, the other is a successful businessman deprived of parental happiness. A chance meeting turns into a frank conversation where each dreams of being in the other's place. The next morning they wake up in each other's bodies. Forced to live someone else's life, the heroes face unexpected difficulties that change their idea of happiness, success, and true wealth.	\N
59	Истребитель демонов: Kimetsu No Yaiba Бесконечная крепость (2025)	2025-10-15	Chaplin Mega Silk Way	11:00:00	Тандзиро Камадо — юноша, который вступил в организацию, занимающуюся истреблением демонов, под названием «Корпус истребителей демонов», после того как его младшая сестра Нэдзуко превратилась в демона. Становясь сильнее и укрепляя дружбу и связи с другими членами Корпуса, Тандзиро сражался с множеством демонов вместе со своими товарищами — Дзэницу Агацума и Иноскэ Хибасира. В ходе своего пути он сражался плечом к плечу с высшими мечниками Корпуса — столпами (Хашира), включая столп Пламени Кёдзюро Рэнгоку на «Бесконечном поезде», столп Звука Тэнгэн Узуи в квартале красных фонарей, а также столп Тумана Муичиро Токито и столп Любви Мицури Канродзи в Деревне кузнецов. Когда члены Корпуса и Хашира начали совместную программу силовых тренировок  —Тренировку столпов, чтобы подготовиться к предстоящей битве с демонами, Мудзан Кибуцудзи появляется в особняке Убуяшики. Когда глава Корпуса оказывается в опасности, Тандзиро и столпы спешат на помощь в штаб-квартиру, но оказываются сброшены в таинственное пространство самим Мудзаном Кибуцудзи. Местом, куда упали Тандзиро и члены Корпуса, становится цитадель демонов — Бесконечный замок. И вот, поле боя готово, и финальная битва между Корпусом истребителей демонов и демонами начинается.	static/eventPhoto/истребитель_демонов.jpg	200	3	1	1	1	Demon Slayer: Kimetsu no Yaiba - Infinity Castle (2025)	\N	Chaplin Mega Silk Way	\N	Tanjiro Kamado joins the Demon Slayer Corps after his sister Nezuko turns into a demon. The Corps and the Hashira begin a rigorous training program to prepare for the upcoming battle against demons. However, Muzan Kibutsuji appears at the Ubuyashiki mansion. When the leader of the Corps is in danger, Tanjiro and the Hashira rush to help but are dropped into a mysterious space by Muzan himself—the Infinity Castle. The final battle begins.	\N
60	Мир в огне (2025)	2025-10-02	Chaplin Mega Silk Way	11:00:00	Дэйв Батиста, Ольга Куриленко и Сэмюэл Л.Джексон в фантастической экшн-комедии про ограбление в разгар апокалипсиса. После мощной солнечной вспышки, уничтожившей восточное полушарие. Земли, мир погрузился в хаос. Посреди всего безумия охотник за сокровищами отправляется на самое дерзкое ограбление своей жизни. Ему предстоит украсть «Мону Лизу», теперь сокрытую в самом опасном месте на планете, а также между делом спасти мир (если получится).	static/eventPhoto/мир_в_огне.jpg	200	6	1	1	1	World in Fire (2025)	\N	Chaplin Mega Silk Way	\N	Dave Bautista, Olga Kurylenko, and Samuel L. Jackson in a fantastic action-comedy about a heist in the midst of the apocalypse. After a powerful solar flare destroys the Eastern Hemisphere, the world plunges into chaos. Amidst all the madness, a treasure hunter sets off on the most daring heist of his life. He has to steal the "Mona Lisa", now hidden in the most dangerous place on the planet, and also save the world along the way (if possible).	\N
61	Жұмбақ қыз (2025)	2025-10-25	Chaplin Khan Shatyr	12:45:00	Әкесі өмірден өткеннен кейін Айару депрессияға түсіп, өзін жоғалтып алғандай. Құмар ойынға қызығып, соның ізіне түскенін көргенде анасы мен ағасы қатаң шара қолданады. Ауылдағы әкесі негізін қалаған фермаға апарып тастайды. Айару ауылдың тыныш атмосферасына үйреніп, ферманың жұмысын жандандыруға қызу кіріседі. Бұрын тұнжырап, тек өз әлемінде жүретін қыз жадырап сала береді. Бұлай болуына әсер еткен негізгі бір себеп – махаббат. Фермадағы жеке жүргізушісі Шыңғыс екеуінің арасындағы ұрыс-керістен басталған қарым-қатынас уақыт өте келе тәтті сезімге ұласады. Шыңғыс ауылдағы қызы Нұршатпен сөз байласып, той күнін белгілеп қойған болатын. Ауқатты, ықпалды кісінің қызы Нұршат өз махаббатын біреуге оңай бере салатын адам емес. Шыңғыс қорқақтық танытып сезіміне сатқындық жасай ма, әлде елдің әңгімесін ысырып қойып, сүйіктісі Айарумен қосыла ма? Осылайша, Айару тыныштық табамын ба деп барған ауылда да шытырман оқиға тап болады.  Бұл жердегі «ставканың» құны тым жоғары..	static/eventPhoto/жумбак_кыз.jpg	200	5	1	1	1	Mysterious Girl (2025)	\N	Chaplin Khan Shatyr	\N	After her father passes away, Ayaru falls into depression and seems to lose herself. When her mother and brother see her getting into gambling, they take strict measures. They take her to the farm in the village founded by her father. Ayaru gets used to the quiet atmosphere of the village and vigorously begins to revitalize the farm's work. The main reason for this change is love. The relationship between her and her personal driver on the farm, Shyngys, starts with quarrels but turns into sweet feelings over time. However, Shyngys is engaged to a girl named Nurshat. The stakes are high...	\N
62	Трон: Арес (2025)	2025-10-09	Chaplin Khan Shatyr	10:00:00	"Трон: Арес” - это продолжение знаменитой научно-фантастической франшизы, которое перенесет зрителей в захватывающий и опасный мир цифровой сети, известной как Грид. События разворачиваются спустя годы после событий “Трона: Наследие”. Фильм рассказывает историю Ареса (Джаред Лето) - могущественного программного обеспечения, которое, по всей видимости, вышло из-под контроля и решило вторгнуться в человеческий мир. Он представляет собой нового, грозного антагониста, чьи мотивы и цели остаются загадкой. Фильм обещает зрелищные визуальные эффекты, динамичный экшн, а также исследование философских вопросов о природе сознания и границах технологий. “Трон: Арес” вернет зрителей в мир, который они любят, но при этом предложит новый взгляд на франшизу и ее персонажей.	static/eventPhoto/трон_арес.jpg	200	4	1	1	1	Tron: Ares (2025)	\N	Chaplin Khan Shatyr	\N	"Tron: Ares" is a continuation of the famous sci-fi franchise that will transport viewers to the exciting and dangerous world of the digital network known as the Grid. The film tells the story of Ares (Jared Leto), a powerful software that seems to have gone out of control and decided to invade the human world. It promises spectacular visual effects, dynamic action, and an exploration of philosophical questions about the nature of consciousness.	\N
71	Лекция-экскурсия по выставке «Урал Тансыкбаев»	2025-10-18	Галерея изобразительного искусства (NBU)	14:00:00	Ведущий Данияр Холматов, энтузиаст искусства, магистрант факультета арт-менеджмента Российского гуманитарного университета познакомит вам с ключевыми этапами биографии художника, разбор его значимых работ, обсуждение самой экспозиции и её контекста.	static/eventPhoto/урал_тансыкбаев.jpg	8	2	7	10	24	Lecture-tour of "Ural Tansykbayev" exhibition	\N	Gallery of Fine Arts (NBU)	\N	Host Daniyar Kholmatov, an art enthusiast and master's student at the Art Management Faculty of the Russian University for the Humanities, will introduce you to key stages of the artist's biography, analyze his significant works, and discuss the exposition itself and its context.	\N
72	Almaty Open ATP 250	2025-10-16	«Almaty Arena»	11:00:00		static/eventPhoto/almaty_open.png	1500	5	5	2	5	Almaty Open ATP 250	\N	Almaty Arena	\N		\N
64	Qaitadan (2025)	2025-09-18	Chaplin Mega Almaty	15:00:00	Городской подросток, заваливший важный экзамен, сталкивается с гневом родителей, которые решают отправить его в село к бабушке. Вместо того чтобы вернуться с ними в город, он вынужден остаться в деревне и помогать по хозяйству, пасая скот. Отчаянно мечтая сбежать обратно, герой вскоре обнаруживает, что его день начинает повторяться, как в "Дне сурка". Ситуация усложняется тем, что каждый раз в конце дня местную дамбу прорывает, и стихия сметает всё на своём пути, унося жизни всех вокруг. Понимая, что каждый новый цикл – это шанс предотвратить катастрофу и спасти близких, главный герой пытается вырваться из временной петли, найти способ спасти деревню и изменить своё отношение к жизни.	static/eventPhoto/каитадан.jpg	300	4	1	2	1	Over Again (Qaitadan) (2025)	\N	Chaplin Mega Almaty	\N	A city teenager who failed an important exam is sent to a village to his grandmother. Desperately dreaming of escaping back, the hero soon discovers that his day begins to repeat itself, like in "Groundhog Day". The situation is complicated by the fact that every time at the end of the day, the local dam bursts, and the elements sweep away everything in their path. Realizing that every new cycle is a chance to prevent a catastrophe, the main character tries to break out of the time loop.	\N
65	МӘНШҮК	2025-10-17	Музыкальный театр юного зрителя	19:00:00	Ұлы Жеңістің 80 жылдығына орай, Астана қаласы әкімдігінің Музыкалық жас көрермен театрында Кеңес Одағының Батыры, қазақтың қаһарман қызы Мәншүк Мәметованың қысқа әрі қайсарлыққа толы өмірін бейнелейтін «Мәншүк» музыкалық драма сахналанады. Қойылымның мақсаты есімі аңызға айналған, ерлік істері барша ұлтты таң қалдырған қазақтың батыр қызы жарқын өмірін, Ұлы Отан соғысындағы ерлік істерін ұрпаққа үлгі етіп, өнеге ету. Туынды тарихи деректерге негізделген.	static/eventPhoto/маншук.jpg	150	3	2	1	18	MANSHUK	\N	Musical Theatre of Young Spectators	\N	In honor of the 80th anniversary of the Great Victory, the Musical Drama "Manshuk" depicting the short and courageous life of the Hero of the Soviet Union, the heroic Kazakh daughter Manshuk Mametova, is being staged. The purpose of the production is to set the bright life of the Kazakh heroine and her heroic deeds in the Great Patriotic War as an example for the younger generation. The work is based on historical facts.	\N
66	Ғашықсыз ғасыр	2025-10-17	Мангистауский драматический теарт им. Жантурина	19:00:00	Басты кейіпкерлері біздің замандастарымыз. 47 жастағы ғылым докторы, профессор Қайырбай мен 43 жастағы ғылым кандидаты Фарида жастай бірін-бірі сүйіп қосылған, төрт перзенті бар, кенжесі Жұлдыз мектептегі жоғары сынып оқушысы. Тұрмыстық-әлеуметтік жағдайы жақсы отбасы үшін пьеса сюжетіндегі шиеленісті жағдайы - Қайырбайдың ұлды болу мұратымен Нәзікеш есімді қызбен көңіл қосуы.Оқиғаның шиеленісті, шарықтау кездерінде Фарида мен Қайырбайдың қайта қауышу тағдырына әкеп соқтырады.	static/eventPhoto/гашиксыз_гасыр.jpg	1000	4	2	4	2	Century Without Love	\N	Zhanturin Mangystau Drama Theatre	\N	The main characters are our contemporaries. 47-year-old Doctor of Science Kayirbay and 43-year-old Candidate of Science Farida married for love in their youth and have four children. For a family with good socio-economic status, the conflict in the play's plot is Kayirbay's affair with a girl named Nazikesh due to his desire to have a son. The climax of the event leads to the destiny of Farida and Kayirbay reuniting.	\N
67	Евгений Чебатков в Павлодаре	2025-12-11	ДК имени Естая	19:00:00	Новая программа «На других берегах» - это не просто набор шуток. Это цельное путешествие, в которое комик приглашает каждого зрителя. Путешествие по разным странам, культурам и, самое главное, по глубинам человеческих странностей и наблюдений. Евгений с присущей ему искренностью и острым умом поделится всем, что его удивило, рассмешило или заставило задуматься в последнее время. Если вы цените смелую, интеллигентную комедию и хотите на два часа забыть обо всем на свете, погрузившись в атмосферу качественного юмора, то этот концерт для вас. Не упустите шанс увидеть новое шоу одного из лучших стендап-комиков вживую!	static/eventPhoto/чебатков_павлодар.jpg	500	5	4	8	19	Evgeny Chebatkov in Pavlodar	\N	Estay Palace of Culture	\N	The new program "On Other Shores" is not just a set of jokes. It is a complete journey to which the comedian invites every viewer. A journey through different countries, cultures and, most importantly, the depths of human oddities. Evgeny will share everything that surprised, amused or made him think recently with his inherent sincerity. If you appreciate bold, intelligent comedy, this concert is for you.	\N
68	Lucia Lacarra: суперзвезда мирового балета	2025-11-05	Almaty Theatre	19:30:00	1 и 2 ноября Международный фестиваль танца Ballet совместно с Алматы Театром представляет событие, которого с нетерпением ждёт культурная столица Казахстана. Впервые в Алматы выступит испанская суперзвезда Люсия Лакарра обладательница «Оскара балета» Benois de la Danse, премии Нежинского и звания «Танцовщица десятилетия».	static/eventPhoto/lucia_lacarra.jpg	800	4	3	2	7	Lucia Lacarra: World Ballet Superstar	\N	Almaty Theatre	\N	On November 1 and 2, the International Ballet Festival together with Almaty Theatre presents an event eagerly awaited by the cultural capital of Kazakhstan. For the first time in Almaty, Spanish superstar Lucia Lacarra, winner of the "Ballet Oscar" Benois de la Danse, the Nijinsky Award, and the title of "Dancer of the Decade", will perform.	\N
70	Стендап-концерт Филиппа Воронина	2026-05-21	Almaty Central Stand up club	18:30:00	Филипп Воронин - стендап-комик, сценарист и ведущий шоу «Мне смешно». За время обучения в университете Филипп успел стать финалистом проекта «Comedy Баттл» на ТНТ, а также основать собственную команду «ДАЛС» в КВН, которая в дальнейшем прошла в Высшую лигу и запомнилась всем песней про конфетный вкус и другими яркими шутками.	static/eventPhoto/стендап_филипп.jpg	300	1	10	2	21	Philip Voronin Stand-up Concert	\N	Almaty Central Stand up club	\N	Philip Voronin is a stand-up comedian, screenwriter and host of the show "I'm Funny". During his university studies, Philip managed to become a finalist of the "Comedy Battle" project on TNT, as well as found his own team "DALS" in KVN.	\N
90	Лучшее от Tarsi	2025-12-12	Дворец Жастар	19:00:00	Tarsi Orchestra - Дважды Победители в номинации «Лучший симфонический концерт года» по версии Ticketon\n\nГрандиозный симфо-концерт «Лучшее от Tarsi»\n\nХиты, проверенные временем, энергия, от которой мурашки. Ностальгия ретро-хитов и драйвовая мощь рок-композиций в симфонической обработке.\n\nЛучшие композиции культовых исполнителей, таких как: «Europe», «Queen», «Cher», «Status Quo», «Наутилиус Помпилиус», «Би2», «КиШ» и мн.др. Это будет концерт, где музыка не просто звучит - она зажигает, вдохновляет и объединяет!\n\nГости вечера: рекордсмены по количеству гастролей, алматинская трибьют группа " PULSE KINO "!\nНовый солист группы Рустем Нурдильдин исполнит для Вас лучшие хиты Виктора Цоя в сопровождении симфонического оркестра Tarsi!\n\nСолистка нашего вечера - лауреат международных конкурсов Айнур Енбекова и главный дирижёр Мәдениет саласының үздігі Ерлан Бейсембаев!\n\nПогрузитесь в магию музыки вместе с Tarsi Orchestra - это будет вечер, который останется в памяти надолго!	/uploads/event_posters/f5585241-a825-498f-a3af-677d77f5f050.jpg	180	1	3	1	21	The Best of Tarsi	\N	Zhastar Palace	\N	Tarsi Orchestra - Twice Winners in the nomination "Best Symphonic Concert of the Year" by Ticketon. Grand symphonic concert "The Best of Tarsi". Hits tested by time, energy that gives goosebumps. Nostalgia of retro hits and driving power of rock compositions in symphonic processing. Best compositions of cult performers like: Europe, Queen, Cher, Status Quo, Nautilus Pompilius, Bi-2, KiSh and many others. Guests of the evening: Almaty tribute band "PULSE KINO"!	\N
\.


--
-- TOC entry 4938 (class 0 OID 59628)
-- Dependencies: 215
-- Data for Name: flyway_schema_history; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) FROM stdin;
1	1	init core tables	SQL	V1__init_core_tables.sql	-1302684553	postgres	2025-10-14 22:18:43.581514	85	t
2	2	insert data indirect tables	SQL	V2__insert_data_indirect_tables.sql	-222731760	postgres	2025-10-14 22:18:43.702287	6	t
3	3	create additional tables	SQL	V3__create_additional_tables.sql	1394842056	postgres	2025-10-14 22:18:43.716952	13	t
4	4	insert language promocodes data	SQL	V4__insert_language_promocodes_data.sql	367706333	postgres	2025-10-14 22:18:43.736868	6	t
5	5	insert organisers	SQL	V5__insert_organisers.sql	1237460796	postgres	2025-10-16 10:53:33.524976	8	t
6	6	insert events	SQL	V6__insert_events.sql	623705376	postgres	2025-10-16 10:55:23.077229	25	t
7	7	drop constrain	SQL	V7__drop_constrain.sql	-1789548893	postgres	2025-10-17 15:39:35.277478	11	t
8	8	inset ticket prices	SQL	V8__inset_ticket_prices.sql	-154855522	postgres	2025-10-17 15:40:23.276266	12	t
9	9	fix tables rows	SQL	V9__fix_tables_rows.sql	463724286	postgres	2025-10-27 14:01:26.027023	53	t
10	10	user changes	SQL	V10__user_changes.sql	-766978331	postgres	2025-10-29 21:57:36.565573	16	t
11	11	add security token to user	SQL	V11__add_security_token_to_user.sql	-626974893	postgres	2025-10-31 16:36:01.85595	18	t
12	12	update legacy tickets	SQL	V12__update_legacy_tickets.sql	629727464	postgres	2025-12-08 21:01:23.596675	58	t
13	13	delete tables	SQL	V13__delete_tables.sql	1069058612	postgres	2025-12-11 18:51:10.81578	41	t
14	14	translate tables	SQL	V14__translate_tables.sql	-1130611498	postgres	2025-12-14 21:55:56.196493	18	t
15	15	populate english translations	SQL	V15__populate_english_translations.sql	-1424711859	postgres	2025-12-14 22:31:09.855954	71	t
\.


--
-- TOC entry 4942 (class 0 OID 59651)
-- Dependencies: 219
-- Data for Name: organisators; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.organisators (organisator_id, user_id) FROM stdin;
1	1
2	2
3	3
4	4
5	5
6	6
7	7
8	8
9	9
10	10
11	11
12	12
13	13
14	14
15	15
16	16
17	17
18	18
19	19
20	20
21	21
22	22
23	23
24	24
25	25
26	26
27	27
28	28
\.


--
-- TOC entry 4950 (class 0 OID 59692)
-- Dependencies: 227
-- Data for Name: promocodes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.promocodes (promocode_id, promocode, price_charge) FROM stdin;
1	Oqyshy5	0.05
2	Alash10	0.1
3	AtaAnalar15	0.15
4	PepsiCola3	0.03
\.


--
-- TOC entry 4954 (class 0 OID 59734)
-- Dependencies: 231
-- Data for Name: tickets; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.tickets (ticket_id, price, user_id, event_id, quantity, seat_details) FROM stdin;
81	10500	\N	41	1	Стандарт
93	15500	\N	53	1	VIP
85	10000	\N	45	2	Стандарт
100	5000	\N	60	1	Эконом
98	9000	\N	58	1	Стандарт
45	9000	\N	44	200	Эконом
178	120000	30	89	2	Ряд 3, Место 10; Ряд 3, Место 11
185	24000	30	90	3	Ряд 5, Место 8; Ряд 5, Место 9; Ряд 5, Место 10
41	10000	\N	40	100	Стандарт
42	15000	\N	41	50	VIP
43	8000	\N	42	100	Стандарт
44	6000	\N	43	100	Стандарт
46	4000	\N	45	200	Эконом
47	9500	\N	46	50	VIP
48	3500	\N	47	200	Эконом
49	2500	\N	48	300	Входной
50	7000	\N	49	100	Стандарт
51	2500	\N	50	300	Входной
52	20000	\N	51	20	Super VIP
53	10000	\N	52	50	VIP
54	12300	\N	53	50	Premium
55	4500	\N	54	150	Эконом
56	7500	\N	55	100	Стандарт
57	3000	\N	56	200	Входной
58	5500	\N	57	100	Стандарт
59	15800.8	\N	58	40	VIP
60	2100	\N	59	50	Промо
61	2500	\N	60	200	Входной
62	1900	\N	61	50	Промо
63	2500	\N	62	200	Входной
80	7000	30	40	1	Ряд 4, Место 6
68	15300	\N	67	40	VIP
170	100000	\N	89	97	VIP
172	60000	\N	89	296	Сцена
179	7800	\N	70	100	Стандарт
180	15400	\N	70	50	VIP
181	4500	\N	70	150	Эконом
182	3000	\N	90	30	Входной
169	37000	\N	88	2000	Стандартный вход
171	40000	\N	89	2000	Танцпол
64	1900	\N	63	50	Промо
65	2500	\N	64	200	Входной
66	4500	\N	65	150	Эконом
67	3800	\N	66	150	Эконом
69	4950	\N	68	100	Стандарт
70	6500	\N	69	100	Стандарт
72	5000	\N	71	100	Стандарт
73	6870.99	\N	72	80	Комфорт
74	9580.99	\N	73	60	Premium
75	2500	\N	74	300	Входной
76	2900	\N	75	300	Входной
77	7590.9	\N	76	80	Комфорт
78	4500	\N	77	150	Эконом
79	3890.99	\N	78	150	Эконом
82	16000	\N	42	50	VIP
83	12000	\N	43	60	Premium
84	20000	\N	44	20	Super VIP
86	12000	\N	46	60	Premium
87	5000	\N	47	100	Стандарт
88	4000	\N	48	150	Эконом
89	12000	\N	49	60	Premium
90	5000	\N	50	100	Стандарт
91	12500	\N	51	60	Premium
92	8000	\N	52	100	Стандарт
94	3000	\N	54	200	Входной
95	4000	\N	55	150	Эконом
96	5500	\N	56	100	Стандарт
97	10000	\N	57	60	Premium
99	3000	\N	59	200	Входной
101	3500	\N	61	150	Эконом
102	6000	\N	62	100	Стандарт
103	4500	\N	63	150	Эконом
104	7000	\N	64	100	Стандарт
105	8000	\N	65	100	Стандарт
106	4200	\N	66	150	Эконом
107	9900	\N	67	60	Premium
108	9550	\N	68	60	Premium
109	12000	\N	69	50	VIP
111	2990	\N	71	250	Входной
112	3450	\N	72	150	Эконом
113	4500	\N	73	150	Эконом
114	8950	\N	74	100	Стандарт
115	4320	\N	75	150	Эконом
116	3950	\N	76	150	Эконом
117	9000	\N	77	60	Premium
118	5430	\N	78	100	Стандарт
119	5000	\N	40	100	Стандарт
120	4000	\N	41	150	Эконом
121	4500	\N	42	150	Эконом
122	3590	\N	43	200	Входной
123	4500	\N	44	150	Эконом
124	8500	\N	45	100	Стандарт
125	3700	\N	46	150	Эконом
126	7500	\N	47	100	Стандарт
127	9000	\N	48	60	Premium
128	3450	\N	49	150	Эконом
129	7500	\N	50	100	Стандарт
130	6990	\N	51	100	Стандарт
131	3590	\N	52	150	Эконом
132	20000	\N	53	20	Super VIP
133	6000	\N	54	100	Стандарт
134	9900	\N	55	60	Premium
135	7490	\N	56	100	Стандарт
136	2990	\N	57	250	Входной
137	4980	\N	58	150	Эконом
138	4800	\N	59	150	Эконом
139	7000	\N	60	100	Стандарт
140	6890	\N	61	100	Стандарт
141	4800	\N	62	150	Эконом
142	6700	\N	63	100	Стандарт
143	5900	\N	64	100	Стандарт
144	10000	\N	65	60	Premium
145	6850	\N	66	100	Стандарт
146	5500	\N	67	100	Стандарт
147	12400	\N	68	50	VIP
148	18900	\N	69	40	VIP
150	7600	\N	71	100	Стандарт
151	9000	\N	72	60	Premium
152	13400	\N	73	50	VIP
153	5990	\N	74	100	Стандарт
154	6500	\N	75	100	Стандарт
155	13200	\N	76	50	VIP
156	15490	\N	77	50	VIP
157	8500	\N	78	100	Стандарт
183	15000	\N	90	50	Сцена
184	8000	\N	90	97	Зал
\.


--
-- TOC entry 4940 (class 0 OID 59638)
-- Dependencies: 217
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.users (user_id, user_name, password, phone_number, email, user_photo, role, otp, refresh_token, otp_expiry_date, password_reset_token, password_reset_token_expiry_date) FROM stdin;
1	Chaplin Cinemas	$2a$10$n9cojXy.PvSkkJT1C/joFOrQ/dVRWm3.TmYWUvLBPNkyFPSi.sd5e	+77771234567	\N	\N	ORGANISATOR	\N	\N	\N	\N	\N
2	Kazakh Concert Prod.	$2a$10$EDJorePW9wFtGRUiZunugOSY5aohl9l3cxY9Th45AJCZFEYiP59zS	+77019876543	\N	\N	ORGANISATOR	\N	\N	\N	\N	\N
3	Good Event Management	$2a$10$wkj6rvuPCetay4h8.FC9Su71M4hZj/.EYjkt8FJioUzubFtBZA/6m	+77080123456	\N	\N	ORGANISATOR	\N	\N	\N	\N	\N
4	Astana Concert Agency	$2a$10$qXoEHBgsNxeGsLSellHKiOB3hiGYNLENwwjGNGxnKKFZ8f.NIaRpa	+77023456789	\N	\N	ORGANISATOR	\N	\N	\N	\N	\N
5	Федерация Тенниса Казахстана	$2a$10$VHCKIqp6pav6c/oAVnuvbe5UwThN7dC4TNVxZnLSiOlbb3yLnDjgi	+77076789012	\N	\N	ORGANISATOR	\N	\N	\N	\N	\N
6	Almaty Theatre	$2a$10$dgdpdjIHl.PyWOZOX7IjIOj5wWH9J8x8KoLPjhOcIdSmp2iQ0j4QC	+77472345678	\N	\N	ORGANISATOR	\N	\N	\N	\N	\N
7	Zhana Event	$2a$10$47FDXl7Ni.Of1KloARTWxulom2ZlifJ8hU3PHDyROjQTFL9ovQrKS	+77759876543	\N	\N	ORGANISATOR	\N	\N	\N	\N	\N
8	Сoncert Company	$2a$10$y7g3QuExPkGmjoWgrXrIxuiAhrCsSmP4dXG3S.F84CH5PZ64qHPzq	+77073332211	\N	\N	ORGANISATOR	\N	\N	\N	\N	\N
9	Stand Up KZ	$2a$10$U/xJPSbi32HCjDtvpGedJOV3R5zYy6Nw82TxXATjb5Bf7xrxswn4K	+77776543210	\N	\N	ORGANISATOR	\N	\N	\N	\N	\N
10	Eastern Star Events	$2a$10$xDxe.tRJFcBiMDKuiPYRu.TAGd5Ng6ugKK.Xiw/r6iHrZd1EGQL4u	+77017890123	\N	\N	ORGANISATOR	\N	\N	\N	\N	\N
11	Astana Opera	$2a$10$EGzN3OJKGPfEKgFNtwHYxuyTM/cs2s4TVqlzlXMXyX5YPX8kYjqKO	+77009998877	\N	\N	ORGANISATOR	\N	\N	\N	\N	\N
12	Qazaq Event	$2a$10$fEuPFPQKEp61p9HU8UljNOpVkkKLdqbR5jxpWNda4b1EF8cwBs6hi	+77015556677	\N	\N	ORGANISATOR	\N	\N	\N	\N	\N
13	Театр «ŞAM»	$2a$10$jmuuhIOvravgbNxQ0GDH5OsvHKj/kxPFZegusZVswsVc5Uu8..CjG	+77004567890	\N	\N	ORGANISATOR	\N	\N	\N	\N	\N
14	Центральный Цирк	$2a$10$m8PxSXuEPFAxdYfo/qLg3uMqwj7wH4FNi3o.loPnrV1ZLwQKzbt8W	+77079990011	\N	\N	ORGANISATOR	\N	\N	\N	\N	\N
15	Театр «Жастар»	$2a$10$vLX/MPcVaPCst8A8/Lf5Rum0BRwD/n6HF22VnnVqCXCSpkodKhd7m	+77012345000	\N	\N	ORGANISATOR	\N	\N	\N	\N	\N
16	FinTech KZ	$2a$10$K.esmz6Gyddjtlfzj28wDO9tak6vxO99BXBwPYdKtmYwRoPQdQ4Xm	+77075550000	\N	\N	ORGANISATOR	\N	\N	\N	\N	\N
17	ПФЛК	$2a$10$V4cQItnuPunZobTACHL6EeuwVFlUAx8WraDVlBsfJfecgIfzfYxuS	+77011110000	\N	\N	ORGANISATOR	\N	\N	\N	\N	\N
18	KidShow Company	$2a$10$J7yoIzDC2K4VvWzfu6Sot.9lMcugiE1go9yWGuCb1fV1VOmcho3QO	+77778889900	\N	\N	ORGANISATOR	\N	\N	\N	\N	\N
19	Stand Up Agency	$2a$10$fTptZifvYU527cMcfP83qu9czzPSMYO6E/bnh7ETWy9YrcZSoRb9G	+77056667788	\N	\N	ORGANISATOR	\N	\N	\N	\N	\N
20	КХЛ / ХК «Барыс»	$2a$10$slhYnEwVf4PZraonJqUv0.WK98KBvrcKUrgusc3.kspW3Tulp//j.	+77013456789	\N	\N	ORGANISATOR	\N	\N	\N	\N	\N
22	TEDxAlmaty Team	$2a$10$4cnkFOv390kDQfs.rZAo9OeokU7BEUKaI.YyPeQbGI0jmQjPO2TJq	+77717778899	\N	\N	ORGANISATOR	\N	\N	\N	\N	\N
23	Rock Fest KZ	$2a$10$6pZTkfapvLpr2y1gEfQ.lOor6UffZJJdi7EXiEKlvpOdFTRdnwOwm	+77071234560	\N	\N	ORGANISATOR	\N	\N	\N	\N	\N
24	Ministry of Culture	$2a$10$M72wnJ4885t8TEenwf/jG.v5BnolHF9sCz2Q6XFA52nif8f4HisLq	+77001112233	\N	\N	ORGANISATOR	\N	\N	\N	\N	\N
25	Broadway Shows KZ	$2a$10$d0fwh5iwXmXev9x88whiVuqa4yNHGWfoW4LOPkV8tKyAQgLU8eg6W	+77078887766	\N	\N	ORGANISATOR	\N	\N	\N	\N	\N
26	Jazz Club Almaty	$2a$10$6qAEVHB3EyOJ.5mceGqq7uAZTAhQv/qi1HNI52r8mmNlrNv4IWnkO	+77055554433	\N	\N	ORGANISATOR	\N	\N	\N	\N	\N
27	Psychology Pro	$2a$10$siDVvDsq1pv/nFmGcaUebu6rp1KEDKQDDtQrCtnDOYgKhMCINfXNG	+77014443322	\N	\N	ORGANISATOR	\N	\N	\N	\N	\N
31	trofim	$2a$10$Lv212r0QRc0Zpg4PHjEYDufcLv6EKlx2cUatVkP7YCs7oU4nhW2b6	+77021394002	\N	\N	USER	\N	\N	\N	\N	\N
30	itszhdi	$2a$10$T.wGmzbELMVSdLwhkBsb0eGjk3uCZHTxWHMNZaH0TUh9WfWOQ110i	+77021036038	muptea@gmail.com	/uploads/user_photos/b7c233b2-0b19-4dcd-ab89-a97cd59d145f.jpg	USER	\N	eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIzMCIsImlhdCI6MTc2NjU1MDk5OSwiZXhwIjoxNzY3MTU1Nzk5fQ.m1a_kM37KrgFgsjKUgAsl5Yks41e0s37mWBfpDyN9pA	\N	\N	\N
21	Qazaqconcert	$2a$10$mdthuz6Nls8EGzMkHxFsbuTo9NqR71tnoJctU1RAd5SrQ/0ClUK3m	+77563221234	kazakhConcert@proton.me	/uploads/user_photos/963751d4-3b49-4bf5-a6fa-145954b24885.jpg	ORGANISATOR	\N	eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIyMSIsImlhdCI6MTc2NTQ3MTA5MywiZXhwIjoxNzY2MDc1ODkzfQ.sQTufE-GaYsAf-aGmj086Abet6nyp-69FiiVireN368	\N	\N	\N
28	The Bus	$2a$10$XTPqiymusq4bvx4dV4haFufh.Jxkc1jOM.tkVkLTz7nd60qoEyCoq	+77773331122	theBusmail@mail.ru	/userPhotos/28_1761649446698.jpg	ORGANISATOR	\N	\N	\N	\N	\N
\.


--
-- TOC entry 4971 (class 0 OID 0)
-- Dependencies: 220
-- Name: age_restrictions_age_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.age_restrictions_age_id_seq', 7, true);


--
-- TOC entry 4972 (class 0 OID 0)
-- Dependencies: 232
-- Name: cards_token_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.cards_token_id_seq', 1, false);


--
-- TOC entry 4973 (class 0 OID 0)
-- Dependencies: 222
-- Name: categories_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.categories_category_id_seq', 10, true);


--
-- TOC entry 4974 (class 0 OID 0)
-- Dependencies: 224
-- Name: cities_city_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.cities_city_id_seq', 14, true);


--
-- TOC entry 4975 (class 0 OID 0)
-- Dependencies: 228
-- Name: events_event_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.events_event_id_seq', 90, true);


--
-- TOC entry 4976 (class 0 OID 0)
-- Dependencies: 218
-- Name: organisators_organisator_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.organisators_organisator_id_seq', 28, true);


--
-- TOC entry 4977 (class 0 OID 0)
-- Dependencies: 226
-- Name: promocodes_promocode_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.promocodes_promocode_id_seq', 4, true);


--
-- TOC entry 4978 (class 0 OID 0)
-- Dependencies: 230
-- Name: tickets_ticket_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.tickets_ticket_id_seq', 185, true);


--
-- TOC entry 4979 (class 0 OID 0)
-- Dependencies: 216
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_user_id_seq', 31, true);


--
-- TOC entry 4757 (class 2606 OID 59672)
-- Name: age_restrictions age_restrictions_age_category_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.age_restrictions
    ADD CONSTRAINT age_restrictions_age_category_key UNIQUE (age_category);


--
-- TOC entry 4759 (class 2606 OID 59670)
-- Name: age_restrictions age_restrictions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.age_restrictions
    ADD CONSTRAINT age_restrictions_pkey PRIMARY KEY (age_id);


--
-- TOC entry 4784 (class 2606 OID 59773)
-- Name: cards cards_payment_token_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cards
    ADD CONSTRAINT cards_payment_token_key UNIQUE (payment_token);


--
-- TOC entry 4786 (class 2606 OID 59771)
-- Name: cards cards_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cards
    ADD CONSTRAINT cards_pkey PRIMARY KEY (token_id);


--
-- TOC entry 4761 (class 2606 OID 59681)
-- Name: categories categories_category_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_category_name_key UNIQUE (category_name);


--
-- TOC entry 4763 (class 2606 OID 59679)
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (category_id);


--
-- TOC entry 4765 (class 2606 OID 59690)
-- Name: cities cities_city_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_city_name_key UNIQUE (city_name);


--
-- TOC entry 4767 (class 2606 OID 59688)
-- Name: cities cities_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_pkey PRIMARY KEY (city_id);


--
-- TOC entry 4773 (class 2606 OID 59708)
-- Name: events events_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_pkey PRIMARY KEY (event_id);


--
-- TOC entry 4744 (class 2606 OID 59635)
-- Name: flyway_schema_history flyway_schema_history_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);


--
-- TOC entry 4753 (class 2606 OID 59656)
-- Name: organisators organisators_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organisators
    ADD CONSTRAINT organisators_pkey PRIMARY KEY (organisator_id);


--
-- TOC entry 4755 (class 2606 OID 59658)
-- Name: organisators organisators_user_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organisators
    ADD CONSTRAINT organisators_user_id_key UNIQUE (user_id);


--
-- TOC entry 4769 (class 2606 OID 59697)
-- Name: promocodes promocodes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.promocodes
    ADD CONSTRAINT promocodes_pkey PRIMARY KEY (promocode_id);


--
-- TOC entry 4771 (class 2606 OID 59699)
-- Name: promocodes promocodes_promocode_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.promocodes
    ADD CONSTRAINT promocodes_promocode_key UNIQUE (promocode);


--
-- TOC entry 4782 (class 2606 OID 59739)
-- Name: tickets tickets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_pkey PRIMARY KEY (ticket_id);


--
-- TOC entry 4747 (class 2606 OID 59649)
-- Name: users users_phone_number_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_phone_number_key UNIQUE (phone_number);


--
-- TOC entry 4749 (class 2606 OID 59645)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- TOC entry 4751 (class 2606 OID 59647)
-- Name: users users_user_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_user_name_key UNIQUE (user_name);


--
-- TOC entry 4745 (class 1259 OID 59636)
-- Name: flyway_schema_history_s_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX flyway_schema_history_s_idx ON public.flyway_schema_history USING btree (success);


--
-- TOC entry 4774 (class 1259 OID 59729)
-- Name: idx_events_age_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_events_age_id ON public.events USING btree (age_id);


--
-- TOC entry 4775 (class 1259 OID 59730)
-- Name: idx_events_category_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_events_category_id ON public.events USING btree (category_id);


--
-- TOC entry 4776 (class 1259 OID 59731)
-- Name: idx_events_city_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_events_city_id ON public.events USING btree (city_id);


--
-- TOC entry 4777 (class 1259 OID 59732)
-- Name: idx_events_organisator_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_events_organisator_id ON public.events USING btree (organisator_id);


--
-- TOC entry 4778 (class 1259 OID 59751)
-- Name: idx_tickets_event_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_tickets_event_id ON public.tickets USING btree (event_id);


--
-- TOC entry 4779 (class 1259 OID 59833)
-- Name: idx_tickets_user_event; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_tickets_user_event ON public.tickets USING btree (user_id, event_id);


--
-- TOC entry 4780 (class 1259 OID 59750)
-- Name: idx_tickets_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_tickets_user_id ON public.tickets USING btree (user_id);


--
-- TOC entry 4794 (class 2606 OID 59774)
-- Name: cards cards_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cards
    ADD CONSTRAINT cards_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- TOC entry 4788 (class 2606 OID 59709)
-- Name: events events_age_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_age_id_fkey FOREIGN KEY (age_id) REFERENCES public.age_restrictions(age_id) ON DELETE SET NULL;


--
-- TOC entry 4789 (class 2606 OID 59714)
-- Name: events events_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(category_id) ON DELETE SET NULL;


--
-- TOC entry 4790 (class 2606 OID 59719)
-- Name: events events_city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_city_id_fkey FOREIGN KEY (city_id) REFERENCES public.cities(city_id) ON DELETE SET NULL;


--
-- TOC entry 4791 (class 2606 OID 59724)
-- Name: events events_organisator_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_organisator_id_fkey FOREIGN KEY (organisator_id) REFERENCES public.organisators(organisator_id) ON DELETE CASCADE;


--
-- TOC entry 4787 (class 2606 OID 59659)
-- Name: organisators organisators_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organisators
    ADD CONSTRAINT organisators_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- TOC entry 4792 (class 2606 OID 59745)
-- Name: tickets tickets_event_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_event_id_fkey FOREIGN KEY (event_id) REFERENCES public.events(event_id) ON DELETE CASCADE;


--
-- TOC entry 4793 (class 2606 OID 59740)
-- Name: tickets tickets_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


-- Completed on 2026-01-25 18:08:49

--
-- PostgreSQL database dump complete
--

