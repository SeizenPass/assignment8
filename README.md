index.jsp - login page  
dashboard.jsp - main page  
profile.jsp  
addBook.jsp  
book.jsp  
addStudent.jsp  

CREATE TABLE public.users
(
    id integer NOT NULL DEFAULT nextval('users_id_seq'::regclass),
    username character varying(50) COLLATE pg_catalog."default" NOT NULL,
    password character varying(20) COLLATE pg_catalog."default" NOT NULL,
    access integer NOT NULL,
    CONSTRAINT users_pkey PRIMARY KEY (id)
);
CREATE TABLE public.borrows
(
    id integer NOT NULL,
    user_id integer NOT NULL,
    isbn character varying(13) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT borrows_pkey PRIMARY KEY (id),
    CONSTRAINT isbn_fk FOREIGN KEY (isbn)
        REFERENCES public.books (isbn) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT user_id_fk FOREIGN KEY (user_id)
        REFERENCES public.users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
);
CREATE TABLE public.books
(
    isbn character varying(13) COLLATE pg_catalog."default" NOT NULL,
    title character varying(100) COLLATE pg_catalog."default" NOT NULL,
    description character varying(500) COLLATE pg_catalog."default",
    count integer NOT NULL,
    CONSTRAINT books_pkey PRIMARY KEY (isbn)
);