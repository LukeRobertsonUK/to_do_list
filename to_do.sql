create table to_do
  (
    id serial4 primary key,
    title varchar(255),
    due_date date,
    status varchar(10),
    details text,
    owner varchar(100)
);