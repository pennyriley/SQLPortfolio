Select * 
From PortfolioProject..CovidDeaths$
where continent is not null
order by 3,4

--Select * 
--From PortfolioProject..CovidVaccinations$
--order by 3,4


-- Select data that we are going to be using 

Select Location, date, total_cases, new_cases, total_deaths, population
From PortfolioProject..CovidDeaths$
order by 1,2


-- Investigate Total Cases vs Total Deaths

Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths$
Where location like '%states%'
order by 1,2

-- Investigate Total Cases vs Population
-- shows what percentage of population got Covid 

Select Location, date, total_cases, population, (total_cases/population)*100 as PercentPopulationInfected
From PortfolioProject..CovidDeaths$
--Where location like '%states%'
order by 1,2

-- Investigate Countries with Highest Infection Rate compared to Population

Select Location, Population, MAX(total_cases) as HighestInfectionCount, Max((total_cases/population))*100 as PercentPopulationInfected
From PortfolioProject..CovidDeaths$
--Where location like '%states%'
Group by population, location
order by PercentPopulationInfected desc



-- Showing Countries with highest death count per population

Select Location, MAX(cast(total_deaths as int)) as TotalDeathCount 
From PortfolioProject..CovidDeaths$
--Where location like '%states%'
where continent is not null
Group by location
order by TotalDeathCount desc

-- Looking by continent

Select continent, MAX(cast(total_deaths as int)) as TotalDeathCount 
From PortfolioProject..CovidDeaths$
--Where location like '%states%'
where continent is not null
Group by continent
order by TotalDeathCount desc



-- Global Numbers

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths$
Where continent is not null
order by 1,2


-- Look at total population vs vaccinations


Select CovidDeaths$.continent, CovidDeaths$.location, CovidDeaths$.date, CovidDeaths$.population, CovidVaccinations$.new_vaccinations
From PortfolioProject..CovidDeaths$
Join PortfolioProject..CovidVaccinations$
	ON CovidDeaths$.location = CovidVaccinations$.location
	and CovidDeaths$.date= CovidVaccinations$.date
where CovidDeaths$.continent is not null
order by 1,2,3