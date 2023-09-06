Select Publisher, Genre, AVG(User_score) as AvgScore
From [Video Game Sales]..Video_Games_Sales_as_at_22_Dec_$
Where Publisher + Genre is not null
Group By Publisher, Genre
Order By AvgScore Desc

Select Genre, AVG(User_score) as AvgScore
From [Video Game Sales]..Video_Games_Sales_as_at_22_Dec_$
Group By Genre
Order By AvgScore Desc

Select Genre, Count(*) as NumberOfGames
From [Video Game Sales]..Video_Games_Sales_as_at_22_Dec_$
Group By Genre
Order By NumberOfGames Desc

Select Genre, Publisher, Count(*) as NumberOfGames
From [Video Game Sales]..Video_Games_Sales_as_at_22_Dec_$
Group By Genre, Publisher
Order By NumberOfGames Desc

Select top 10 Publisher, Count(*) as NumberOfGames, avg(User_Score) as AvgUserScore
From [Video Game Sales]..Video_Games_Sales_as_at_22_Dec_$
Group By Publisher
Order By NumberOfGames Desc

SELECT   Publisher, AVG(User_Score) as AVGScore, AVG(User_Count) as AVGCount 
FROM     [Video Game Sales]..Video_Games_Sales_as_at_22_Dec_$
GROUP BY Publisher
ORDER BY AVGScore desc

--self container / correlated subqueries