Create database ola; 
use ola;

Select * from ola_rides;

-- 1) Retrieve Successful Bookings.
Select Count(*) As Successful_Employees From Ola_Rides
Where Booking_Status = 'Success';

-- 2) Find The Average Ride Distance Of each Vehicle Type.
Select Vehicle_Type , Avg(Ride_Distance) As Avg_Ride_Distance From Ola_Rides
Group by Vehicle_Type;

-- 3) Get Total Number OF Cancelled Rides By Customer
Select Count(*) As Customer_canceled_rides From Ola_Rides
Where Booking_Status = 'canceled by customer';

-- 4) List 5 customer who book highest number of rides.
Select Customer_ID, Count( Booking_ID) As Total_Count From Ola_Rides
Group by customer_ID
order by total_Count Desc
Limit 5;

-- 5) get the number of rides canceled by driver due to personal and car related issues
Select Count(*) As Total_Count From Ola_Rides 
Where Canceled_Rides_By_Driver = 'Personal & Car related issue';

-- 6) Retrive Booking Value by payment method
Select Payment_Method , Sum(Booking_Value) As Total_Revenue From Ola_Rides
Group by Payment_Method;

-- 7) Find average Customer Rating and driver rting by vehicle type
Select vehicle_Type , Round(Avg(Customer_Rating),2) As Avg_Customer_Rating,
					  Round(Avg(Driver_Ratings),2) As Driver_Rating
 From Ola_Rides
Group by Vehicle_Type;

-- 8) Find Total Successful Rides Booking values
Select Sum(Booking_Value) As Total_Booking_Value From Ola_Rides;

-- 9) Cancellation Of each vehicle type 
Select Vehicle_Type, 
Round( 100 * Sum(
				case
						When Booking_Status <> 'Success' Then 1
                        Else 0
				 End) / Count(*),2) 
                 As Cancellation_Rate
                 From Ola_Rides
                 Group by Vehicle_Type;
                 
-- 10) Find the vehicle type with the highest success rate
With CTE As( Select Vehicle_Type,SUM(
			Case
				When Booking_Status = 'Success' Then 1 Else 0 
				End )
                As Successful_Bookings ,
			Count(*) As Total_Count 
		From Ola_Rides
		Group by vehicle_Type) 
Select vehicle_type,
		Round((Successful_Bookings/ Total_Count)* 100,2) 
		As Success_Rate 
	From CTE
    Order by Success_Rate desc
    Limit 1;
    

-- 11) Retrive Average Vehicle Turn-Around Time in minutes.
Select Round(Avg(V_Tat) /60 ,2) As Vehicle_TurnAround_Time From ola_Rides;

-- 12) Top 10 Pickup Locations By Revenue
Select Pickup_Location, Sum(Booking_Value) As Total_Booking_Value ,
						Count(*) As Total_Bookings From Ola_Rides
					Group by Pickup_Location 
				Order by Total_Booking_value Desc,
		 Total_Bookings desc
Limit 10;








