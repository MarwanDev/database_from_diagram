create table medical_history (
    id int primary key GENERATED ALWAYS AS IDENTITY,
    admitted_at timestamp,
    status varchar(250)
);

create table patients (
    id int primary key GENERATED ALWAYS AS IDENTITY,
    date_of_birth date,
    name varchar(250)
);

alter table medical_history 
add column patient_id int;

alter table medical_history 
add foreign key(patient_id)
references patients(id);


create table invoices (
    id int primary key GENERATED ALWAYS AS IDENTITY,
    total_amoun decimal,
    generated_at timestamp,
    paid_at timestamp,
	medical_history_id int
);

alter table invoices
add foreign key(medical_history_id)
references medical_history(id);



create table invoice_items (
    id int primary key GENERATED ALWAYS AS IDENTITY,
    unit_price decimal,
	quantity int,
    total_price decimal,
    invoice_id int,
    treatment_id int
);


create table treatments (
    id int primary key GENERATED ALWAYS AS IDENTITY,
    type varchar(250),
    name varchar(250)
);

alter table invoice_items
add foreign key(invoice_id)
references invoices(id),
	
add foreign key(treatment_id)
references treatments(id);



create table treatment_medical_history (
	id int primary key GENERATED ALWAYS AS IDENTITY,
	medical_history_id int,
	treatment_id int,
	foreign key(medical_history_id) references medical_history(id),
	foreign key(treatment_id) references treatments(id)
);

create index patient_id_idx on  medical_history(patient_id);
create index medical_history_id_idx on  invoices(medical_history_id);
create index invoice_id_idx on  invoice_items(invoice_id, treatment_id);
create index treatment_medical_history_id_idx on  treatment_medical_history(medical_history_id, treatment_id);
