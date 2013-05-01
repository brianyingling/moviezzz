create table movies(
  id serial4 primary key,
  title varchar(255),
  poster text,
  year varchar(4),
  rated varchar(10),
  released varchar(25),
  runtime varchar(25),
  genre varchar(100),
  director varchar(100),
  writers varchar(255),
  actors varchar(255),
  plot text
);