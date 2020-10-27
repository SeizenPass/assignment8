index.jsp - login page  
dashboard.jsp - main page  
profile.jsp  
addBook.jsp  
book.jsp  
addStudent.jsp  

CREATE SEQUENCE public.users_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE 1;

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

# Working With assignment8.UserServlet
### *All Methods require destination url to be passed as a string ATTRIBUTE*

## GET/api/v1.0/users:
### gets all users in the database as a ArrayList<assignment8.User> to the request attribute

## GET/api/v1.0/users/{id}:
### gets a single user from the database by his (id) as assignment8.User object to the request attribute

## POST/api/v1.0/users
### adds a row to the database Users, requires (id, username, password, access) parameters to be passed

## PUT/api/v1.0/users/
### modifies a row in the database Users, requires (id, username, password, access) parameters to be passed

## DELETE/api/v1.0/users/{id}
### deletes a row in the database Users depending on his (id)

login.jsp: redirects to assignment8.Auth.java
assignment8.Auth.java: doPost Method creates cookies if username and password contains in the table Users,
also if the data written in the login form does not equals the data in the Users table, then error message appears
 