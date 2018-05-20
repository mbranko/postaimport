delete from Sveske;
delete from Godine;
delete from Primerci;
delete from Records;
update Counters set counter_value=0 where counter_name='godinaid';
update Counters set counter_value=0 where counter_name='primerakid';
update Counters set counter_value=0 where counter_name='recordid';
update Counters set counter_value=0 where counter_name='sveskaid';
update Counters set counter_value=0 where counter_name='RN';
