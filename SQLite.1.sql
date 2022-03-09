CREATE TABLE MonthlyWeather ( date_id INTEGER PRIMARY KEY, max_temp INTEGER, min_temp INTEGER, weather_obs TEXT);
INSERT INTO MonthlyWeather VALUES (1, 89, 64, "mostly sunny");
INSERT INTO MonthlyWeather VALUES (2, 83, 71, "sunny");
INSERT INTO MonthlyWeather VALUES (3, 76, 54, "sun between clouds");
INSERT INTO MonthlyWeather VALUES (4, 81, 67, "cloudy with chances of rain");
INSERT INTO MonthlyWeather VALUES (5, 78, 65, "mostly sunny");
INSERT INTO MonthlyWeather VALUES (6, 82, 56, "mostly sunny");
INSERT INTO MonthlyWeather VALUES (7, 86, 62, "sun between clouds");
INSERT INTO MonthlyWeather VALUES (8, 87, 60, "sunny");
INSERT INTO MonthlyWeather VALUES (9, 79, 59, "sun between clouds");
INSERT INTO MonthlyWeather VALUES (10, 76, 51, "cloudy with chances of rain");
INSERT INTO MonthlyWeather VALUES (11, 75, 49, "thuderstorm");
INSERT INTO MonthlyWeather VALUES (12, 72, 51, "clouds and high winds");
INSERT INTO MonthlyWeather VALUES (13, 68, 46, "cloudy with chances of rain");
INSERT INTO MonthlyWeather VALUES (14, 75, 51, "mostly sunny");
INSERT INTO MonthlyWeather VALUES (15, 76, 47, "sunny");
INSERT INTO MonthlyWeather VALUES (16, 85, 57, "sunny");
INSERT INTO MonthlyWeather VALUES (17, 87, 64, "mostly sunny");
INSERT INTO MonthlyWeather VALUES (18, 91, 72, "sunny");
INSERT INTO MonthlyWeather VALUES (19, 89, 67, "sunny");
INSERT INTO MonthlyWeather VALUES (20, 81, 71, "mostly sunny");
INSERT INTO MonthlyWeather VALUES (21, 79, 63, "cloudy with chances of rain");
INSERT INTO MonthlyWeather VALUES (22, 80, 65, "cloudy");
INSERT INTO MonthlyWeather VALUES (23, 83, 62, "mostly sunny");
INSERT INTO MonthlyWeather VALUES (24, 76, 59, "rain");
INSERT INTO MonthlyWeather VALUES (25, 75, 61, "thunderstorm");
INSERT INTO MonthlyWeather VALUES (26, 79, 62, "cloudy with chances of rain");
INSERT INTO MonthlyWeather VALUES (27, 82, 60, "sun between clouds");
INSERT INTO MonthlyWeather VALUES (28, 87, 62, "sunny");
INSERT INTO MonthlyWeather VALUES (29, 82, 71, "sunny");
INSERT INTO MonthlyWeather VALUES (30, 79, 58, "mostly sunny");

CREATE TABLE WorkSchedule (date_id INTEGER PRIMARY KEY, shift TEXT);
INSERT INTO WorkSchedule VALUES (1, "off");
INSERT INTO WorkSchedule VALUES (2, "night");
INSERT INTO WorkSchedule VALUES (3, "night");
INSERT INTO WorkSchedule VALUES (4, "off");
INSERT INTO WorkSchedule VALUES (5, "off");
INSERT INTO WorkSchedule VALUES (6, "day");
INSERT INTO WorkSchedule VALUES (7, "day");
INSERT INTO WorkSchedule VALUES (8, "night");
INSERT INTO WorkSchedule VALUES (9, "night");
INSERT INTO WorkSchedule VALUES (10, "night");
INSERT INTO WorkSchedule VALUES (11, "off");
INSERT INTO WorkSchedule VALUES (12, "off");
INSERT INTO WorkSchedule VALUES (13, "night");
INSERT INTO WorkSchedule VALUES (14, "day");
INSERT INTO WorkSchedule VALUES (15, "off");
INSERT INTO WorkSchedule VALUES (16, "day");
INSERT INTO WorkSchedule VALUES (17, "day");
INSERT INTO WorkSchedule VALUES (18, "day");
INSERT INTO WorkSchedule VALUES (19, "night");
INSERT INTO WorkSchedule VALUES (20, "off");
INSERT INTO WorkSchedule VALUES (21, "off");
INSERT INTO WorkSchedule VALUES (22, "off");
INSERT INTO WorkSchedule VALUES (23, "night");
INSERT INTO WorkSchedule VALUES (24, "night");
INSERT INTO WorkSchedule VALUES (25, "night");
INSERT INTO WorkSchedule VALUES (26, "day");
INSERT INTO WorkSchedule VALUES (27, "off");
INSERT INTO WorkSchedule VALUES (28, "off");
INSERT INTO WorkSchedule VALUES (29, "off");
INSERT INTO WorkSchedule VALUES (30, "night");

/*selecting all rows for visualizations*/

SELECT * FROM MonthlyWeather;
SELECT * FROM WorkSchedule;

/*using JOIN to put both tables together and WHERE to connect the common data in both of them*/

SELECT MonthlyWeather.date_id, max_temp, min_temp, weather_obs, shift FROM MonthlyWeather 
JOIN WorkSchedule
WHERE MonthlyWeather.date_id = WorkSchedule.date_id;

/*applying GROUP BY,HAVING, AND to find the days which the temperatures are higher than 80 and is a day off*/
 
SELECT MonthlyWeather.date_id, max_temp, min_temp, weather_obs, shift FROM MonthlyWeather 
JOIN WorkSchedule
WHERE MonthlyWeather.date_id = WorkSchedule.date_id
GROUP BY MonthlyWeather.date_id
HAVING max_temp > 80 AND shift = "off";

/*Using UPDATE to change informations in both tables*/

UPDATE WorkSchedule SET shift = "day" WHERE date_id = 20;
UPDATE MonthlyWeather SET weather_obs = "rain" WHERE date_id = 27;

/*Adding a new column with the average temperature for each row and using SELECT to visualize the result*/

ALTER TABLE MonthlyWeather ADD avg_temp INTEGER;
UPDATE MonthlyWeather SET avg_temp = (max_temp+min_temp)/2 ;
SELECT * FROM MonthlyWeather;

/*Using CASE function to categorize the average temperatue*/

SELECT MonthlyWeather.date_id, max_temp, min_temp, weather_obs, shift, avg_temp,
CASE
  WHEN avg_temp >= 75 THEN "hot"
  WHEN avg_temp >= 70 THEN "warm"
  ELSE "cool"
    END AS temp_sensation
  FROM MonthlyWeather 
JOIN WorkSchedule
WHERE MonthlyWeather.date_id = WorkSchedule.date_id;

