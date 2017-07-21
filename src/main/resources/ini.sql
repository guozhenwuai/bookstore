create table user(
	id int auto_increment primary key,
    username varchar(32),
    password varchar(32),
    email varchar(64),
    receiver_name varchar(128),
    address varchar(128),
    phone varchar(32),
    isAdmin int);

create table book(
    id int auto_increment primary key,
    name varchar(128),
    category varchar(128),
    author varchar(128),
    cover varchar(256),
    price int);

create table `order`(
    id int auto_increment primary key,
    user_id int,
    receiver_name varchar(128),
    address varchar(128),
    phone varchar(32),
    price int,
    date datetime,
    foreign key (user_id) references user(id) on delete cascade);

create table order_item(
    order_id int,
    book_id int,
    num int,
    price int,
    primary key (order_id,book_id),
    foreign key (order_id) references `order`(id) on delete cascade,
    foreign key (book_id) references book(id) on delete cascade);
    
delimiter //

create trigger order_item_insert after insert on order_item
for each row
begin
	update `order`
	set `order`.price = `order`.price + new.price
	where `order`.id = new.order_id;
end

create trigger order_item_update after update on order_item
for each row
begin
	update `order`
	set `order`.price = `order`.price + new.price - old.price
	where `order`.id = new.order_id;
end 

create trigger order_item_delete after delete on order_item
for each row
begin
	update `order`
	set `order`.price = `order`.price - old.price
	where `order`.id = old.order_id;
end

//