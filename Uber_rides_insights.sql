show databases;


create database uber_rides;

use uber_rides;

select * from uber_1 ;

select * from uber_2 ;

select * from uber_3 ;

#1.  What are & how many unique pickup locations are there in the dataset?

select distinct pickup_location from uber_2 ; 
#select pickup_location, sum(pickup_location) from uber_2 u ;

#2.   What is the total number of rides in the dataset?

 select count(total_rides) from uber_3; 

#3.     Calculate the average ride duration.

   select avg(ride_duration) from uber_2 u; 
  

#4.       List the top 5 drivers based on their total earnings.
select driver_id, driver_name, earnings 
from uber_3 u 
order by earnings desc
limit 5 ; #------------------------------- Better answer
#or
SELECT driver_id, SUM(earnings) AS total_earnings 
FROM uber_3 u 
GROUP BY driver_id 
ORDER BY total_earnings DESC LIMIT 5;


#5.           Calculate the total number of rides for each payment method.
   select payment_method, count(ride_id) as ID 
   from uber_2 u 
   where payment_method in ('cash', 'credit Card')  
  group by payment_method; 
 

#6.           Retrieve rides with a fare amount greater than 20.
 select ride_id, fare_amount
 from uber_2 u 
 where fare_amount > 20 ;
 

#7.      Identify the most common pickup location.
SELECT pickup_location, COUNT(*) AS ride_count #--------(*) inclides null values & count(*) counts rows 
FROM uber_2 u 
GROUP BY pickup_location 
ORDER BY ride_count DESC LIMIT 1;
              #or
SELECT pickup_location, COUNT(pickup_location) AS ride_count 
FROM uber_2 u 
GROUP BY pickup_location 
ORDER BY ride_count DESC 
LIMIT 1;


#8.           Calculate the average fare amount.
   select avg(fare_amount) from uber_2 u;  


#9.           List the top 10 drivers with the highest average ratings.
select driver_id , driver_name , avg(rating) as average_ratings
from uber_3 u 
group by driver_id ,driver_name 
order by average_ratings desc 
limit 10;
  
  
#10.      Calculate the total earnings for all drivers.
select sum(earnings) from uber_3 u ;


#11.      How many rides were paid using the "Cash" payment method?
select count(*) as payment
from uber_2 u 
where payment_method = 'cash' ;

#12.      Calculate the number of rides & average ride distance for rides originating from the 'Dhanbad' pickup location.
select count(pickup_location), avg(ride_distance) as ad 
from uber_2 
where pickup_location = 'Dhanbad'
order by ad ;
 


#13.  Retrieve rides with a ride duration less than 10 minutes.
select count(*) as t #-----------better answer
from uber_2 u 
where ride_duration < 10 ;
                 #OR
select count(ride_id) as t
from uber_2 u 
where ride_duration < 10 ;


#14.      List the passengers who have taken the most number of rides.
select passenger_id ,passenger_name , max(total_rides) rides
from uber_1 u 
group by passenger_id, passenger_name 
order by rides desc ;
                #OR



#15.      Calculate the total number of rides for each driver in descending order.
select driver_id , driver_name , total_rides
from uber_3 u 
#group by driver_id ,driver_name 
order by total_rides desc ;

#16.      Identify the payment methods used by passengers who took rides from the 'Gandhinagar' pickup location.
select * ,count(*) as m
from uber_2 u 
where pickup_location = 'Gandhinagar';


#17.      Calculate the average fare amount for rides with a ride distance greater than 10.
 select count(*) , avg(fare_amount) as fare
 from uber_2 u 
 where ride_distance > 10 ;

#OR 
SELECT AVG(fare_amount) 
FROM uber_2 u 
WHERE ride_distance > 10;

#18.      List the drivers in descending order accordinh to their total number of rides.
select driver_id ,driver_name , total_rides 
from uber_3 u 
order by total_rides desc ;

#19.      Calculate the percentage distribution of rides for each pickup location.
  select pickup_location ,
  count(*) as tr, (count(*) * 100 / (select count(*) from uber_2 u)) AS percentage_distribution
  from uber_2 u 
  group by pickup_location ;
 
 select * from uber_2 u ;


#20.      Retrieve rides where both pickup and dropoff locations are the same.
select * #pickup_location , dropoff_location---this is for if u want to only these table
from uber_2 u 
where pickup_location = dropoff_location ;


Intermediate Level:     

                 

#1.    List the passengers who have taken rides from at least 300 different pickup locations.
SELECT u1.passenger_id, passenger_name, COUNT(DISTINCT u2.pickup_location) AS unique_pickup_locations
FROM uber_1 u1
INNER JOIN uber_2 u2
ON u1.passenger_id = u2.passenger_id
GROUP BY u1.passenger_id, passenger_name 
HAVING COUNT(DISTINCT u2.pickup_location) >= 300;


#2.           Calculate the average fare amount for rides taken on weekdays. -------(doubt)
select avg(fare_amount) as avg_rate
from uber_2 u 
WHERE DAYOFWEEK(STR_TO_DATE(ride_timestamp, '%m/%d/%Y %H:%i'))>5;
#where dayofweek(ride_timestamp) between 2 and 6; 


#3.           Identify the drivers who have taken rides with distances greater than 19.
select d2.driver_id , driver_name , d1.ride_distance
from uber_2 d1
inner join uber_3 d2
on d1.driver_id = d2.driver_id 
where d1.ride_distance > 19 ;


#4.           Calculate the total earnings for drivers who have completed more than 100 rides.
select  d1.driver_id , driver_name , d2.total_rides , d2.earnings 
from uber_2 d1
inner join uber_3 d2
on d1.driver_id = d2.driver_id 
where d2.total_rides  > 100 ;




#5.           Retrieve rides where the fare amount is less than the average fare amount.
select ride_id , fare_amount 
from uber_2 u 
where fare_amount < (SELECT AVG(fare_amount) FROM uber_2);


#6.           Calculate the average rating of drivers who have driven rides with both 'Credit Card' and 'Cash' payment methods.
select d2.driver_id , driver_name , AVG(d3.rating) AS avg_rating
from uber_2 d2 
inner join uber_3 d3
on d2.driver_id = d3.driver_id 
where d2.payment_method in('Credit Card' , 'Cash') 
group by d2.driver_id , driver_name
having count(distinct d2.payment_method) = 2 ;

select * from uber_3;

#7.           List the top 3 passengers with the highest total spending.
 select passenger_id , passenger_name, max(total_spent) as q
 from uber_1 u 
 group by passenger_id , passenger_name
 order by q desc 
limit 3;
 


#8.           Calculate the average fare amount for rides taken during different months of the year.---------(DOUBT)
SELECT MONTH(ride_timestamp) AS ride_month, AVG(fare_amount) AS avg_fare
FROM uber_2
GROUP BY MONTH(ride_timestamp);
 



#9.           Identify the most common pair of pickup and dropoff locations.
select pickup_location , dropoff_location ,count(*) as ride_count
from uber_2 u 
group by pickup_location , dropoff_location
order by ride_count desc ;

#10.      Calculate the total earnings for each driver and order them by earnings in descending order.
select driver_id, driver_name , sum(earnings) as ss
from uber_3 u 
group by driver_id , driver_name 
order by ss desc ;

select * from uber_3 u ;
select * from uber_2 u ;


#11.      List the passengers who have taken rides on their signup date. ----------(WHICH ONE IS RIGHT,,DOUBT)
select p1.passenger_id ,p1.signup_date, p2.ride_timestamp
from uber_1 p1
inner join uber_2 p2
on p1.passenger_id = p2.passenger_id 
where DATE( p2.ride_timestamp) = date(p1.signup_date) ;
                      #or
SELECT p.passenger_id, p.passenger_name
FROM uber_1  p
JOIN uber_2  r ON p.passenger_id = r.passenger_id
WHERE DATE(p.signup_date) = DATE(r.ride_timestamp);

#12.      Calculate the average earnings for each driver and order them by earnings in descending order.
select driver_id, avg(earnings) as ee
from uber_3
group by driver_id 
order by ee desc;


#13.      Retrieve rides with distances less than the average ride distance.
select ride_id ,  ride_distance 
from uber_2 
where ride_distance < (select avg(ride_distance) from uber_2) ;


#14.      List the drivers who have completed the least number of rides.
select * from uber_3 u 
#group by driver_id ,driver_name 
order by total_rides asc ;

#15.      Calculate the average fare amount for rides taken by passengers who have taken at least 20 rides.
select  passenger_id , avg(fare_amount) as ff
from uber_2 
GROUP BY passenger_id
HAVING COUNT(ride_id) >= 20; #-TIP__The HAVING clause works after GROUP BY, 
#so it can reference any column that's being aggregated, even if it’s not included in the SELECT list.

#16.      Identify the pickup location with the highest average fare amount.
 select pickup_location , avg(fare_amount) as mm
 from uber_2 u 
 group by pickup_location 
 order by mm desc 
limit 1 ;

 select * from uber_3 u ;
select * from uber_2 u ;

#17.      Calculate the average rating of drivers who completed at least 100 rides.-----(doubt)
select r1.ride_id , r2.driver_id , avg(rating) as ff
from uber_2 r1
inner join uber_3 r2
on r1.driver_id = r2.driver_id 
where r2.driver_id 
having count(r1.ride_id) >= 100; 

#18.      List the passengers who have taken rides from at least 5 different pickup locations.
SELECT passenger_id, COUNT(DISTINCT pickup_location) AS distinct_locations
FROM uber_2 u
GROUP BY passenger_id
HAVING COUNT(DISTINCT pickup_location) >= 5;



#19.      Calculate the average fare amount for rides taken by passengers with ratings above 4.
SELECT r1.passenger_id, AVG(r1.fare_amount) AS avg_fare
FROM uber_2 r1
INNER JOIN uber_3 r2 ON r1.driver_id = r2.driver_id
WHERE r2.rating > 4
GROUP BY r1.passenger_id;


SELECT AVG(fare_amount) FROM uber_2 rc WHERE passenger_id in--------(doubt)
(SELECT passenger_id FROM uber_2  pc WHERE rating > 4);



#20.      Retrieve rides with the shortest ride duration in each pickup location.
select pickup_location , min(ride_duration) as tt
from uber_2 
group by pickup_location
order by tt ;



Advanced Level:

#1.           List the drivers who have driven rides in all pickup locations. -----(doubt)
select * from uber_2 u ;

select distinct driver_id,pickup_location from uber_2 u where pickup_location in (select distinct pickup_location from uber_2 u);

select distinct pickup_location from uber_2 u ;


SELECT driver_id
FROM uber_2
GROUP BY driver_id
HAVING COUNT(DISTINCT pickup_location) = (SELECT COUNT(DISTINCT pickup_location) FROM uber_2);


#2.           Calculate the average fare amount for rides taken by passengers who have spent more than 300 in total.
select passenger_id , avg(fare_amount)as ff from uber_2 u  
group by passenger_id 
having sum(fare_amount) > 300 ; 

SELECT AVG(fare_amount)
FROM uber_2 u 
WHERE passenger_id IN (SELECT passenger_id FROM uber_1 u2 WHERE total_spent > 300); #------ ???


#3.           List the bottom 5 drivers based on their average earnings.
select driver_id , driver_name, avg(earnings) as ss
from uber_3
group by driver_id , driver_name 
order by ss asc 
limit 5 ;


#4.           Calculate the sum fare amount for rides taken by passengers who have taken rides in different payment methods.
SELECT SUM(fare_amount)
FROM uber_2
WHERE passenger_id IN (SELECT passenger_id FROM uber_2 u GROUP BY passenger_id
HAVING COUNT(DISTINCT payment_method) > 1
);

#5.           Retrieve rides where the fare amount is significantly above the average fare amount.
SELECT *
FROM uber_2 u 
WHERE fare_amount > (SELECT AVG(fare_amount) from uber_2 u);

select * from uber_3 u ;
#6.           List the drivers who have completed rides on the same day they joined.
select p1.driver_id ,p1.join_date, p2.ride_timestamp
from uber_3 p1
inner join uber_2 p2
on p1.driver_id = p2.driver_id 
where DATE( p2.ride_timestamp) = date(p1.driver_id) ;


#7.           Calculate the average fare amount for rides taken by passengers who have taken rides in different payment methods.
SELECT avg(fare_amount)
FROM uber_2
WHERE passenger_id IN (SELECT passenger_id FROM uber_2 u GROUP BY passenger_id
HAVING COUNT(DISTINCT payment_method) > 1
);

#8.           Identify the pickup location with the highest percentage increase in average fare amount compared to the overall average fare.
select pickup_location , AVG(fare_amount) AS avg_fare,
       (AVG(fare_amount) - (SELECT AVG(fare_amount) from uber_2 u2)) * 100.0 / (SELECT AVG(fare_amount) FROM uber_2 u) AS percentage_increase
from uber_2 u 
group by pickup_location 
order by percentage_increase desc 
limit 1 ;

#Example:
#Imagine:
#The overall average fare is $10.
#At a specific pickup location, the average fare is $12.
#To find the percentage increase:
#Difference: $12 - $10 = $2
#Percentage Increase: ($2 / $10) * 100 = 20%
#So, the fare at this pickup location is 20% higher than the overall average.
#This is how we express the increase in average fare as a percentage compared to the overall average.

#9.           Retrieve rides where the dropoff location is the same as the pickup location.
 select * #pickup_location , dropoff_location---this is for if u want to only these table
from uber_2 u 
where  dropoff_location = pickup_location ;

#10.           Calculate the average rating of drivers who have driven rides with varying pickup locations.
select r1.ride_id , r2.driver_id , avg(rating) as ff #-------------- what is wrong in this querry? (doubt)
from uber_2 r1
inner join uber_3 r2
on r1.driver_id = r2.driver_id 
group by  r1.ride_id , r2.driver_id 
having count(distinct r1.pickup_location)  ; 

                         #OR
SELECT AVG(rating) FROM uber_3 u WHERE driver_id IN (SELECT DISTINCT driver_id FROM uber_2 u2 
    GROUP BY driver_id
    HAVING COUNT(DISTINCT pickup_location) > 1
);

#Project complete