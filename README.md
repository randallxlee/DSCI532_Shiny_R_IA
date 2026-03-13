# Vancouver Neighbourhood Safety Dashboard

## Overview

The Vancouver Neighbourhood Safety Dashboard is an interactive Shiny application that allows users to explore crime patterns across Vancouver neighbourhoods. The dashboard provides a simple interface to filter crime incidents by neighbourhood and crime type, helping users better understand local safety trends.

## Running the app locally

1. Clone the repository

Run the following commands in your terminal to clone the repository to your local machine:

```bash
git clone <https://github.com/randallxlee/DSCI532_Shiny_R_IA.git>
cd <DSCI532_Shiny_R_IA>
```

2. Start an R session, from the root of the project directory, start R:

``` bash
R
```

3. Install required packages (if not already installed)

``` R
install.packages(c("shiny", "bslib", "DT"))
```

4. Run the Shiny app

To render the app run:

``` R
shiny::runApp("./app")
```

The dashboard will open in your default web browser or in the RStudio Viewer pane.