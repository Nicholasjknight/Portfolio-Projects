Select * From [Portfolio Project]..['Covid Deaths$']
order by 3,4

Select * From [Portfolio Project]..['Covid Vaccinations$']
order by 3,4

Select Location, date, total_cases, new_cases, total_deaths, population
From [Portfolio Project]..['Covid Deaths$']
Order by 3,4

select location, date, total_cases, total_deaths, (CONVERT(DECIMAL(18,2), total_deaths) / CONVERT(DECIMAL(18,2), total_cases) )*100 as DeathPercent
From [Portfolio Project]..['Covid Deaths$']
order by 1,2

select location, date, total_cases, total_deaths, (CONVERT(DECIMAL(18,2), total_deaths) / CONVERT(DECIMAL(18,2), total_cases) )*100 as DeathPercent
From [Portfolio Project]..['Covid Deaths$']
Where location like '%states%'
order by 1,2

select location, date, total_cases, population, (CONVERT(DECIMAL(18,2), total_cases) / CONVERT(DECIMAL(18,2), population) )*100 as CaughtCovid
From [Portfolio Project]..['Covid Deaths$']
Where location like '%states%'
order by 1,2

select location, Max(total_cases) as HighestInfection, population, MAX(CONVERT(DECIMAL(20,3), total_cases) / CONVERT(DECIMAL(20,3), population) )*100 as CaughtCovid
From [Portfolio Project]..['Covid Deaths$']
Group by location, population
order by CaughtCovid desc

--Deaths by all locations w/ discrepencies
select location, Max(cast(total_deaths as bigint)) as TotalDeathCount
From [Portfolio Project]..['Covid Deaths$']
Group by location, population
order by TotalDeathCount desc

--Deaths by Country
select location, Max(cast(total_deaths as bigint)) as TotalDeathCount
From [Portfolio Project]..['Covid Deaths$']
where continent is not null
Group by location
order by TotalDeathCount desc

-- Deaths by Continent w/ discrepencies
select continent, Max(cast(total_deaths as bigint)) as TotalDeathCount
From [Portfolio Project]..['Covid Deaths$']
where continent is not null
Group by continent
order by TotalDeathCount desc

--Deaths by Continent
select continent, Max(cast(total_deaths as bigint)) as TotalDeathCount
From [Portfolio Project]..['Covid Deaths$']
where continent is not null
Group by continent
order by TotalDeathCount desc

--Global Numbers
Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From [Portfolio Project]..['Covid Deaths$']
where continent is not null 
order by 1,2

--Adding new table
Select *
From [Portfolio Project]..['Covid Deaths$'] dea
Join [Portfolio Project]..['Covid Vaccinations$'] vac
	On dea.location= vac.location
	and dea.date = vac.date

-- Total Population vs Vaccinations
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
From [Portfolio Project]..['Covid Deaths$'] dea
Join [Portfolio Project]..['Covid Vaccinations$'] vac
	On dea.location= vac.location
	and dea.date = vac.date
where dea.continent is not null
order by 1,2,3

--% of population vaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From [Portfolio Project]..['Covid Deaths$'] dea
Join [Portfolio Project]..['Covid Vaccinations$'] vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
order by 2,3

--Using CTE
With PopVsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated) 
as (
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From [Portfolio Project]..['Covid Deaths$'] dea
Join [Portfolio Project]..['Covid Vaccinations$'] vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
)
Select *, (RollingPeopleVaccinated/Population)*100
From PopVsVac

-- Using Temp Table to perform Calculation on Partition By in previous query

DROP Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated

From [Portfolio Project]..['Covid Deaths$'] dea
Join [Portfolio Project]..['Covid Vaccinations$'] vac
	On dea.location = vac.location
	and dea.date = vac.date


Select *, (RollingPeopleVaccinated/Population)*100
From #PercentPopulationVaccinated

-- Creating View to store data for later visualizations

Use [Portfolio Project]
GO
Create View PercentsPopulationVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
From [Portfolio Project]..['Covid Deaths$'] dea
Join [Portfolio Project]..['Covid Vaccinations$'] vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 

Select *, (RollingPeopleVaccinated/Population)*100
From #PercentPopulationVaccinated

-- Tableau Public 

--1
Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From [Portfolio Project]..['Covid Deaths$']
where continent is not null 
order by 1,2
--2
Select location, SUM(cast(new_deaths as int)) as TotalDeathCount
From [Portfolio Project]..['Covid Deaths$']
Where continent is null 
and location not in ('World', 'European Union', 'International')
Group by location
order by TotalDeathCount desc
-- 3.
Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From [Portfolio Project]..['Covid Deaths$']
--Where location like '%states%'
Group by Location, Population
order by PercentPopulationInfected desc
-- 4.
Select Location, Population,date, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From [Portfolio Project]..['Covid Deaths$']
--Where location like '%states%'
Group by Location, Population, date
order by PercentPopulationInfected desc