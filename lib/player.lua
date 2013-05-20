local playerName
local hp
local strength
local magic
local level
local exp

local MAX_LEVEL = 100


--some type of level system? 
if exp <= 500 then
	level = 1
else if exp <= 1200 then
	level = 2
else if exp  <= 2000 then
	level = 3

else return end

local function leveledStat(stat)
stat = stat + 10
end

local function addStat

--SYSTEMS NEEDED

--Upon level up, choice in either magic, hp, or str stats to be boosted by 1
-- 1 point provides 10 points to either stat

--need to keep in mind that Name, and level will be logged for leaderboard use later
--