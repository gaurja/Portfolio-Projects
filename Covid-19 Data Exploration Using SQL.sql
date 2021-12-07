-- Showing countries with the highest infection count
SELECT location,population,MAX(total_cases) as HighestInfectionCount,
MAX((CAST (total_cases AS DECIMAL))/population)*100 AS percent_infected
FROM covid_deaths
GROUP BY location,population
ORDER BY percent_infected DESC NULLS LAST
--- Only 2.48% of the population in India got infected

---Selecting Total Deaths by Country as on 01-12-2021 
SELECT location, total_deaths FROM covid_deaths
WHERE date='01-12-2021' AND CONTINENT is not null
ORDER BY total_deaths DESC NULLS LAST

--Breaking things down by continent
SELECT CONTINENT, SUM(total_deaths) AS DEATHSBYCONTINENT FROM covid_deaths
WHERE date='01-12-2021' AND CONTINENT is not null
GROUP BY CONTINENT

--Breaking things down by income group
SELECT location,total_deaths as Deaths_by_income_group FROM covid_deaths
WHERE LOCATION ILIKE '%middle%' and date='01-12-2021'
ORDER BY Deaths_by_income_group DESC
--

--Death Rate
SELECT location,population,total_deaths,total_cases,(CAST(total_deaths AS decimal)/total_cases)*100 as death_rate
FROM covid_deaths
WHERE date='01-12-2021'
ORDER BY death_rate DESC NULLS LAST


--Looking at total population vs vaccination
SELECT dea.location,max(vac.people_fully_vaccinated) as people_fully_vaccinated, max(dea.population) as population, max(cast((vac.people_fully_vaccinated) as decimal))/max(dea.population)*100
AS percentage_people_fully_vaccinated FROM covid_deaths as dea
INNER JOIN covidvaccination AS vac
ON dea.location=vac.location
AND dea.date=vac.date
WHERE dea.continent IS NOT null
GROUP BY dea.location,dea.population
ORDER BY people_fully_vaccinated DESC NULLS LAST

---- Median Age and Covid
SELECT  dea.location,dea.total_cases,max(vac.median_age) as median_age from covid_deaths as dea
INNER JOIN covidvaccination AS vac
ON dea.location=vac.location
AND dea.date=vac.date
WHERE dea.date='01-12-2021' AND dea.continent IS NOT null
GROUP BY dea.location,dea.total_cases
ORDER BY total_cases DESC NULLS LAST
--India is the only nation which lies in the top 10 nations with highest covid cases despite having
--the median age lower than 30. 

-- HDI and Total Deaths
SELECT dea.location,dea.total_deaths,MAX(vac.human_development_index
) AS HDI from covid_deaths as dea
INNER JOIN covidvaccination as vac
ON dea.location=vac.location
AND dea.date=vac.date
WHERE dea.date='01-12-2021' AND dea.continent IS NOT null
GROUP BY dea.location,dea.total_deaths
ORDER BY total_deaths DESC NULLS LAST
--Except india, all 9 countries are in high	human development category

--Does Higher GDP PER CAPITA lead to lower deaths?
SELECT dea.location,SUM(dea.new_deaths) as Total_Deaths,max(vac.gdp_per_capita) as GDP_per_Capita from covid_deaths as dea
INNER JOIN covidvaccination as vac
ON dea.location=vac.location
AND dea.date=vac.date
WHERE DEA.CONTINENT IS NOT NULL 
GROUP BY  DEA.LOCATION
ORDER BY gdp_per_capita DESC NULLS LAST
--Countries that are in the top 20 with highest GDP_PER_CAPITA have lower deaths

SELECT dea.location,SUM(dea.new_deaths) as Total_Deaths,max(vac.gdp_per_capita) as GDP_per_Capita from covid_deaths as dea
INNER JOIN covidvaccination as vac
ON dea.location=vac.location
AND dea.date=vac.date
WHERE DEA.CONTINENT IS NOT NULL 
GROUP BY  DEA.LOCATION
ORDER BY Total_deaths DESC NULLS LAST
LIMIT 20
