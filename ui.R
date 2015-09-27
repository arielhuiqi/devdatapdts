shinyUI(fluidPage(
  titlePanel("Student Admissions at UC Berkeley"),
  
  sidebarLayout
  (
    sidebarPanel(
                  h3("Select the department and gender for the respective admission rates"),
                  selectInput("select_dept", 
                                      label = "Department",
                                      choices = list("A","B","C","D","E","F"),
                              ),
                  selectInput("select_gender", 
                              label = "Gender",
                              choices = list("Female","Male")
                  )
                ),
    mainPanel(h3(textOutput("output_dept")),h3(textOutput("output_gender")),plotOutput("output_plot"),tableOutput("comparison"))
  )
))
