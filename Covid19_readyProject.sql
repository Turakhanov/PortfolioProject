SELECT *
FROM PortfolioProject1..CovidDeaths
where continent is not null
order by 3,4

--SELECT *
--FROM PortfolioProject1..CovidVaccinations
--order by 3,4


Select location, date, total_cases, new_cases, total_deaths, population
From PortfolioProject1..CovidDeaths
where continent is not null
order by 1,2




Select location, date, total_cases, total_deaths, (total_cases/total_deaths)*100 as DeathPercentage
From PortfolioProject1..CovidDeaths 
where continent is not null
--Where location like 'Uzbekistan'
order by 1,2











Select location, date, total_cases, population, (total_deaths/population)*100 as PopulationPercentageInfected
From PortfolioProject1..CovidDeaths 
where continent is not null
Where location like 'Uzbekistan'
order by PopulationPercentageInfected DESC









Select location, population, MAX(total_cases) AS HighestInfectionCount, MAX((total_deaths/population))*100 as 
 PopulationPercentageInfected
From PortfolioProject1..CovidDeaths 
where continent is not null
Group by Location, population
order by PopulationPercentageInfected desc






Select location,MAX(cast(total_deaths as int)) as HighestDeathRate
From PortfolioProject1..CovidDeaths 
where continent is not null
Group by Location
order by  HighestDeathRate DESC










Select location,MAX(cast(total_deaths as int)) as HighestDeathRate
From PortfolioProject1..CovidDeaths 
where continent is null
Group by Location
order by  HighestDeathRate DESC










--Select SUM(new_cases) as total cases, SUM(new_deaths) as total_deaths, SUM(cast
--  (new_deaths as int))/Sum(new_cases)*100 as DeathPercentage
--From PortfolioProject1..CovidDeaths
--where continent is not null
--order by 1,2
















With PopvsVac (Continent, Location, Population, New_Vaccinations, vaccinatedpop)
as 
(
Select dea.continent, dea.location,dea.population, vac.new_vaccinations,
sum(cast(vac.new_vaccinations as int)) over (partition by dea.location ORDER BY dea.location, dea.date) AS 
vaccinatedpop
from PortfolioProject1..CovidDeaths dea
Join PortfolioProject1..CovidVaccinations vac
    on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
)

Select *, (vaccinatedpop/Population)*100 as VaccinatedPopulationPercent
from PopvsVac









------------------------


CREATE VIEW PercentPopulationVaccinated as
Select dea.continent, dea.location, dea.date,dea.population, vac.new_vaccinations,
sum(cast(vac.new_vaccinations as int)) over (partition by dea.location ORDER BY dea.location, dea.date) AS 
vaccinatedpop
from PortfolioProject1..CovidDeaths dea
Join PortfolioProject1..CovidVaccinations vac
    on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null



SELECT *
FROM PercentPopulationVaccinated