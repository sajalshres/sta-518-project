# Analysis of Airbnb listings

<p style='color:red'><b>NOTE</b>: Work In Progress. ETA: 08/08/2022</p>

## Introduction

![App Demo](./docs/images/app-demo.gif)

[app-airbnb.sajalshres.com](https://app-airbnb.sajalshres.com) is a web application that provides an interactive dashboard containing visualizations and summaries to gain insights about Airbnb using the Airbnb dataset for the USA.

Application is live at:

- **Web Application**: [app-airbnb.sajalshres.com](https://app-airbnb.sajalshres.com)

- **API Application**: [api-airbnb.sajalshres.com](https://api-airbnb.sajalshres.com)

**Note**: If you are having issues with [app-airbnb.sajalshres.com](https://app-airbnb.sajalshres.com), please visit [https://sajalshres.shinyapps.io/airbnb-analysis/](https://sajalshres.shinyapps.io/airbnb-analysis/)

## Proposal

Please visit [proposal document](./docs/proposal.md) for more details on proposal.

## Folder Structure

```
sta-518-project
|
|--api        # API application to fetch raw data, analaysis and summaries.
|--app        # Shiny web appliation containing interactive dashboard.
|--data       # Contains raw and processed data
|--docs       # Contains documentation and rmarkdown notebooks.
|--etl        # ETL cli application to scrape and process the data for analysis.
|--modules    # Shared modules used by scripts and applications.
|--scripts    # Contains rscripts.
```

## Setup

- Install required packages

  ```bash
  Rscript scripts/setup.R
  ```

- Run etl cli tool to scrape the raw data and process them.

  ```bash
  Rscript etl/main.R
  ```
  
- Run web application

  ```bash
  Rscipt scripts/start_app.R --app-dir app --host 127.0.0.1 --port 3000
  ```

- Run api application

  ```bash
  Rscript scripts/start_api.R --app-dir app
  ```
- Launch your favorite browser and visit `http://localhost:3000` to view web application.

<p align="center">
  <img src="./docs/images/app-screenshot.png" alt="App Screenshot" width="800"/>
</p>


- Launch your favorite browser and visit `http://localhost:8000/__docs__/` to view api application.

<p align="center">
  <img src="./docs/images/api-screenshot.png" alt="Api Screenshot" width="800"/>
</p>

