library(shiny)
library(bslib)
library(DT)

crime_df <- read.csv("../data/crimedata_csv_AllNeighbourhoods_2025.csv")

neighbourhoods <- c("All", sort(unique(crime_df$NEIGHBOURHOOD)))
crime_types <- c("All", sort(unique(crime_df$TYPE)))

ui <- page_sidebar(
  title = "Vancouver Neighbourhood Safety",
  sidebar = sidebar(
    selectizeInput(
      "nb",
      "Neighbourhood",
      choices = neighbourhoods,
      selected = "All"
    ),
    selectizeInput(
      "crime_type",
      "Crime Type",
      choices = crime_types,
      selected = "All"
    )
  ),
  layout_columns(
    col_widths = c(6, 6),
    style = "align-items: start;",
    value_box(
      title = "Total Crimes",
      height = "100px",
      tags$div(
        style = "font-size:26px; font-weight:600;",
        textOutput("total_crimes")
      )
    ),
    value_box(
      title = "Most Common Crime",
      height = "100px",
      tags$div(
        style = "font-size:26px; font-weight:600;",
        textOutput("top_crime")
      )
    )
  ),
  card(
    card_body(
      plotOutput("crime_barplot", height = "600px")
    )
  )
) 

server <- function(input, output) {

  filtered_data <- reactive({

    req(input$nb, input$crime_type)

    df <- crime_df

    if (input$nb != "All") {
      df <- df[df$NEIGHBOURHOOD == input$nb, ]
    }

    if (input$crime_type != "All") {
      df <- df[df$TYPE == input$crime_type, ]
    }

    df
  })

  output$crime_table <- renderTable({
    filtered_data()
  })

  output$crime_barplot <- renderPlot({

    req(input$nb, input$crime_type)

    if (input$crime_type != "All") {
      return(NULL)
    }

    df <- filtered_data()

    if (nrow(df) == 0) {
      plot.new()
      title("No data available for selected filters")
      return()
    }

    counts <- sort(table(df$TYPE), decreasing = TRUE)
    counts <- head(counts, 10)

    par(mar = c(4, 16, 2, 1))

    barplot(
      rev(counts),
      horiz = TRUE,
      col = "#46b45e",
      las = 1,
      main = "Top 10 Crime Types",
      xlab = "Count"
    )

  }, height = 600)

  output$total_crimes <- renderText({
    nrow(filtered_data())
  })

  output$top_crime <- renderText({

    df <- filtered_data()

    if (nrow(df) == 0) return("No data")

    counts <- sort(table(df$TYPE), decreasing = TRUE)

    names(counts)[1]

  })

}

shinyApp(ui = ui, server = server)