library(shiny)
library(leaflet)

navbarPage("Finfish Cage Detections - Mediterranean Sea", id="main",
           tabPanel("Map", leafletOutput("map", width="100%", height=1000)),
           tabPanel("About",includeMarkdown("readme.md")))