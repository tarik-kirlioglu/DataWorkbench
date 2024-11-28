-- Data Source:https://www.kaggle.com/datasets/whisperingkahuna/footballers-with-50-international-goals-men

-- Overwiew the Datasets
SELECT *
FROM Players;

-- Rename Column Names
EXEC sp_rename 'Players.Career span', 'Career_span', 'COLUMN';
EXEC sp_rename 'Players.Goals per match', 'Goals_per_match', 'COLUMN';
EXEC sp_rename 'Players.Date of 50th goal', 'Date_of_50th_goal', 'COLUMN';

-- Add New Column
ALTER TABLE Players ADD Status VARCHAR(20);

-- Update Status Colummn
UPDATE Players
SET Status= (
CASE
	WHEN Career_span LIKE '%-' THEN 'Active'
    ELSE 'Retired'
END
);

-- Top 10 International Goal Scorers in All Time
SELECT TOP 10 Player, Nation, Confederation, Goals, Caps, Goals_per_match, Status
FROM Players
ORDER BY Goals DESC;

-- Top 10 International Goal Scorers in Active Players
SELECT TOP 10 Player, Nation, Confederation, Goals, Caps, Goals_per_match, Status
FROM Players
WHERE Status='Active'
ORDER BY Goals DESC;

-- Top 10 Footballers with Highest Goal-Ratio
SELECT TOP 10 Player, Nation, Confederation, Goals, Caps, Goals_per_match, Status
FROM Players
ORDER BY Goals_per_match DESC;

-- Highest Goal-Ratio Ranking among Active Players
SELECT Player, Nation, Confederation, Goals, Caps, Goals_per_match, Status
FROM Players
WHERE Status='Active'
ORDER BY Goals_per_match DESC;

-- Total Goals, Caps, Goal-Ratio
SELECT  SUM(Goals) AS TotalGoals, SUM(Caps) AS TotalCaps, (SUM(Goals)/ SUM(Caps)) AS Total_Goal_Ratio
FROM Players;

-- Total Goals by Nation and Confederation
SELECT Nation, Confederation, SUM(Goals) AS Goals
FROM Players
GROUP BY Nation, Confederation
ORDER BY Goals DESC;

-- Retired Players vs Active Players 
SELECT Confederation, COUNT(CASE WHEN Status = 'Retired' THEN 1 END) AS RetiredPlayers, SUM(CASE WHEN Status = 'Retired' THEN Goals END) AS RetiredTotalGoals, 
COUNT(CASE WHEN Status = 'Active' THEN 1 END) AS ActivePlayers, SUM(CASE WHEN Status = 'Active' THEN Goals END) AS ActivePlayersGoals, SUM(Goals) AS TotalGoals
FROM Players
GROUP BY Confederation
ORDER BY TotalGoals DESC;

-- Total Goals and Goals per Match by Nation and Confederation
SELECT Nation, COUNT(Nation) as NationFootballers, Confederation, SUM(Goals) AS Goals, SUM(Caps) AS Caps, SUM(Goals)/SUM(Caps) AS Per_Match_Goals
FROM Players
GROUP BY Nation, Confederation
ORDER BY Per_Match_Goals DESC;

-- Goals per Match and Total Goals by Active Players in Nation and Confederation
SELECT Nation, COUNT(Nation) as NationFootballers, Confederation, SUM(Goals) AS Goals, SUM(Caps) AS Caps, SUM(Goals)/SUM(Caps) AS Per_Match_Goals
FROM Players
WHERE Status='Active'
GROUP BY Nation, Confederation
ORDER BY Per_Match_Goals DESC;
