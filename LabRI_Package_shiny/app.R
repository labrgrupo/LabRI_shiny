################################################################################
################################################################################
################################################################################
###################### Laratory Reference Interval tool ########################
######################           (LabRI tool)           ########################
################################################################################
################################################################################
############################ (CLICK on "Run App") ##############################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################

Sys.setenv(RSTUDIO_PANDOC = "C:/Program Files/RStudio/resources/app/bin/quarto/bin/tools")
options(save.workspace = FALSE)  


################################################################################
################################################################################
###################### (A) List of Required Packages ###########################
################################################################################
################################################################################


# A.1. Check if the "pacman" package is installed, if not, install it


if (!requireNamespace("pacman", quietly = TRUE)) install.packages("pacman")


# A.2. List of required packages


required_packages <- c("AID", "DT", "FactoMineR", "KernSmooth", "MASS", "MethComp",
                       "RVAideMemoire", "calibrate", "cartography", "cluster",
                       "datawizard","data.table", "devtools", "digest", "dplyr", "epiR",
                       "factoextra","ffp", "forecast", "ggplot2", "ggpubr",
                       "ggtext", "grid", "gt","imputeTS", "installr", "irr", "janitor",
                       "kableExtra", "knitr","lattice", "lubridate", "mclust", "mixR",
                       "modeest", "moments","multimode", "multiway", "nortest",
                       "openxlsx", "pacman", "plotly","prettydoc", "qqplotr", "readr",
                       "readxl", "refineR", "reflimR","reshape2", "rmarkdown","scales",
                       "shiny","shinyjs","shiny.exe","shinythemes","stats", "stringi", 
                       "systemfonts","tools","utf8","univOutl", "xfun","writexl","zlog")


# A.3. Function to install and load packages


install_and_load_packages <- function(packages) {
  
  
  ## A.3.1. Packages that are not installed
  
  
  missing_packages <- packages[!(packages %in% installed.packages()[, "Package"])]
  
  
  ## A.3.2. Install missing packages
  
  
  if (length(missing_packages) > 0) {
    install.packages(missing_packages)
  }
  
  
  ## A.3.3. Use pacman to load the packages
  
  
  pacman::p_load(char = packages, character.only = TRUE)
}

# A.4. Call the function to install and load the packages

install_and_load_packages(required_packages)


################################################################################
################################################################################
############# (B) Functions for Parameter Initialization and Management ########
################################################################################
################################################################################



# B.1. Function to Load or Create Default Parameters


load_or_initialize_data <- function() {
  if (!dir.exists("3_exports")) {
    dir.create("3_exports")
  }
  
  params_file <- file.path("3_exports", "saved_params.Rds")
  
  if (file.exists(params_file)) {
    readRDS(params_file)
  } else {
    list(
      file_name = "",
      column_name = "",
      ri_type = "Double-sided",
      decimal_places = "2",
      responsible_person = "",
      measurement_procedure = "",
      measurand_name = "",
      name_of_measurand = "",
      unit = "",
      specimen = "",
      age_range = "",
      sex = "",
      exclusion_criteria = "",
      data_source = "",
      upper_ref_limit = "",
      lower_ref_limit = "",
      comp_ref_source = "",
      max_sample_size = "10000"
    )
  }
}

saved_params <- load_or_initialize_data()


# B.2. Function to Save Current Parameters


save_params <- function(input) {
  params_file <- file.path("3_exports", "saved_params.Rds")
  saveRDS(list(
    File_Name = input$file_name$datapath,
    column_name = input$column_name,
    ri_type = input$ri_type,
    decimal_places = input$decimal_places,
    responsible_person = input$responsible_person,
    measurement_procedure = input$measurement_procedure,
    measurand_name = input$measurand_name,
    name_of_measurand = input$name_of_measurand,
    unit = input$unit,
    specimen = input$specimen,
    age_range = input$age_range,
    sex = input$sex,
    exclusion_criteria = input$exclusion_criteria,
    data_source = input$data_source,
    upper_ref_limit = input$upper_ref_limit,
    lower_ref_limit = input$lower_ref_limit,
    comp_ref_source = input$comp_ref_source,
    max_sample_size = input$max_sample_size
  ), params_file)
}


# B.3. Function to Clear Saved Parameters


clear_saved_params <- function() {
  params_file <- file.path("3_exports", "saved_params.Rds")
  if (file.exists(params_file)) {
    file.remove(params_file)
  }
}


################################################################################
################################################################################
############################ (C) User Interface - UI ###########################
################################################################################
################################################################################



ui <- fluidPage(
  theme = shinytheme("flatly"),
  useShinyjs(),
  
  
# C.1. CSS for Blinking Effect
  
  
  tags$head(
    tags$style(HTML("
    /* Defines the style for the blinking element */
    .blinking {
      animation: blinker 2s linear infinite; /* Sets the blinking duration */
    }
    
    /* Defines the blinking animation */
    @keyframes blinker {
      50% {
        opacity: 0; /* Alternates between visible and invisible */
      }
    }
  "))
  ),
  
  
# C.2. Main Container for the Application Header
  
  
  tags$div(
    
     
    ## C.2.1. Main Container Style, Including Gradient Background
    ##        and Flexbox Layout to Arrange Elements
    
    
    style = "background: linear-gradient(to bottom, #062d79, #4a7ad8);
    padding: 15px; display: flex; align-items: center;
    justify-content: space-between; height: 140px;
           border: 2px solid #000000; border-radius: 5px;",
    
    
    ## C.2.2. LabR Tools Logo
    
    
    tags$div(
      
      style = "padding-right: 20px; display: flex; align-items: center;",
      img(src = "logo.png", alt = "Logo",
          style = "height: 135px; margin-bottom: 6px; margin-top: 10px;")
    ),
    
    
    ## C.2.3. Sub-div for Title and Subtitle
    
    
    tags$div(
      
      style = "text-align: left; flex-grow: 1;",
      
      
      ### C.2.3.1. Main Title of the Application
      
      
      h1("Laboratory Reference Interval (LabRI) Tool",
         style = "color: white; margin: 0;"),
      
      
      ### C.2.3.2. Subtitle Below the Main Title
      
      
      tags$p("Tool for Estimating and Verifying Reference Intervals",
             style = "color: #d1d1d1; margin: 5px 0 0 0; font-size: 18px;")
    )
  ),
  
  
# C.3. Custom Style for Tabs
  
  
  tags$style(
    HTML(".nav-tabs > li > a {
      color: #000000;             /* Font color for selected tab */
      background-color: #fffcc4; /* Pastel yellow color for unselected tabs */
    }
    .nav-tabs > li.active > a, .nav-tabs > li.active > a:hover,
    .nav-tabs > li.active > a:focus {
      color: white;               /* Font color for the selected tab */
      background-color: #0d47a1; /* Dark blue color for the selected tab */
    }
  ")),
  
  
# C.4. TabsetPanel for Adding Tabs
  
  
  tabsetPanel(id = "tabs",
              
                 
    ## C.4.1 Configuration Tab Panel
              
              
              tabPanel("Configuration",
                       sidebarLayout(
                         
                         
      ### C.4.1.1. Sidebar Panel for Configuration Inputs
                          
                         
                         sidebarPanel(
                           width = 9, # Adjust the Width to 9 Columns
                           style = "background-color: #f8f9fa;
                           border: 1px solid #ddd; padding: 15px;",
                           
                           
         #### C.4.1.1.1. Input: Name of Responsible Specialist
                           
                           
                           tags$h2("Name of the responsible specialist",
                                   style = "color: #4878d5;
                                           margin-top: 25px;
                                           margin-bottom: 25px;"),
                           textInput("responsible_person",
                                     "Specialist responsible for data analysis:",
                                     saved_params$responsible_person,
                                     width = '100%'),
                           tags$p(tags$strong("NOTE 1:"),
                                  " Provide the name of the person responsible
                                  for the process or analysis performed.",
                                  style = "font-size: 12px; color: #666;
                                          margin-top: -10px;
                                          margin-bottom: 20px;"),
                           tags$hr(style = "border-top: 3px solid #4878d5;
                                           margin: 15px 0;"),
                           
                           
         #### C.4.1.1.2. Input: Define the Dataset
                           
                           
                           tags$h2("Define the Dataset",
                                   style = "color: #4878d5;
                                           margin-top: 25px;
                                           margin-bottom: 25px;"),
                           
                           
                           
                           fileInput("file_name",
                                     label = tags$span("File Name:",
                                                       style = "font-weight: bold;
                                                               font-size: 16px;"),
                                     accept = c(".csv", ".xls", ".xlsx"),
                                     width = '100%',
                                     buttonLabel = tags$span("Click here to
                                                             Choose File",
                                                             style = "font-size: 14px;
                                                                     color: white;"),
                                     placeholder = "No file selected"),
                           tags$p(tags$strong("NOTE 2:"),
                                  " Select the data file to be analyzed.
                                  The file must be in .csv, .xls, or .xlsx format.",
                                  style = "font-size: 12px;
                                          color: #666;
                                          text-align: justify;
                                          margin-top: -15px;
                                          margin-bottom: 25px;"),
                           
                           
                           selectInput("column_name",
                                       "Column Name:",
                                       choices = NULL,
                                       width = '100%'),
                           tags$p(tags$strong("NOTE 3:"),
                                  " Select the column name from the dropdown
                                  list containing the data to be analyzed.",
                                  style = "font-size: 12px; color: #666);
                                          text-align: justify;
                                          margin-top: -10px;
                                          margin-bottom: 25px;"),
                           
                           
                           radioButtons("measurand_name",
                                        "Is the measurand name the
                                        same as the column name?",
                                        choices = c("Yes" = "Yes", "No" = "No"),
                                        selected = saved_params$measurand_name),
                           conditionalPanel(
                             condition = "input.measurand_name == 'No'",
                             textInput("name_of_measurand",
                                       "Measurand Name
                                       (if different from the column name):",
                                       saved_params$name_of_measurand,
                                       width = '100%')),
                           tags$p(tags$strong("NOTE 4:"),
                                  " Select 'Yes' if the measurand name is the
                                  same as the column name in the dataset, or
                                  'No' otherwise. If 'No' is selected, an
                                  additional field will appear to specify a
                                  custom measurand name, which will be used in
                                  the HTML report generated by the tool.",
                                  style = "font-size: 12px;
                                          color: #666;
                                          text-align: justify;
                                          margin-top: -10px;
                                          margin-bottom: 25px;"),
                           
                           
                           textAreaInput("data_source",
                                     "Data Source:",
                                     saved_params$data_source,
                                     width = '100%'),
                           tags$p(tags$strong("NOTA 5:")," Provide the data
                                  source, specifying where the dataset was
                                  obtained from.",
                                  style = "font-size: 12px;
                                          color: #666;
                                          text-align: justify;
                                          margin-top: -10px;
                                          margin-bottom: 25px;"),
                           tags$hr(style = "border-top: 3px solid #4878d5;
                                           margin: 15px 0;"),
                           
                           
        #### C.4.1.1.3. Input: Set the Type of Reference
        ####            Interval and Decimal Places
                           
                           
                           tags$h2("Set the Type of Reference Interval
                                   and Decimal Places",
                                   style = "color: #4878d5;
                                           margin-top: 25px;
                                           margin-bottom: 25px;"),
                           
                           radioButtons("ri_type",
                                        "Type of Reference Interval:",
                                        choices = c("Double-sided",
                                                    "Right-sided"),
                                        selected = saved_params$ri_type),
                           tags$p(tags$strong("NOTE 6:"),
                                  " Select the desired type of reference interval.
                                  The default setting is 'Double-sided,' which
                                  calculates both the lower and upper reference
                                  limits. 'Right-sided' considers only the upper
                                  reference limit.",
                                  style = "font-size: 12px;
                                           color: #666;
                                           text-align: justify;
                                           margin-top: -10px;
                                           margin-bottom: 25px;"),
                           
                         selectInput("ci_level",
                                     "Choose the confidence level applied to 
                                     the estimation of reference interval limits:",
                                     choices = c("90%" = 0.90,
                                                 "95%" = 0.95,
                                                 "99%" = 0.99),
                                     selected = 0.90,
                                     width = "100%"),
                         tags$p(tags$strong("NOTE 7:"),
                         " Select the desired confidence level for estimating 
                         the reference limits. The available options are 90%, 
                         95%, and 99%. If no selection is made, the tool will 
                         apply a default confidence level of 90%",
                         style = "font-size: 12px; color: #666; text-align: justify;
               margin-top: -10px; margin-bottom: 25px;"),
        
        
                             numericInput("decimal_places", "Decimal Places:",
                                        saved_params$decimal_places, min = 0),
                           tags$p(tags$strong("NOTE 8:"),
                                  " Provide the desired number of decimal places
                                  for the results. If left blank, the default
                                  value will be 2 decimal places.",
                                  style = "font-size: 12px;
                                          color: #666;
                                          margin-top: -10px;
                                          margin-bottom: 25px;"),
                           tags$hr(style = "border-top: 3px solid #4878d5;
                                           margin: 15px 0;"),
                           
                           
             #### C.4.1.1.4. Input: Information for Study
             ####            Traceability
                           
                           
                           tags$h2("Information for Study Traceability",
                                   style = "color: #4878d5;
                                           margin-top: 25px;
                                           margin-bottom: 25px;"),
                           
                           
                           textAreaInput("measurement_procedure",
                                         "Measurement Procedure
                                          and Analytical Method:",
                                         saved_params$measurement_procedure,
                                         width = '100%',
                                         height = '100px'),
                           tags$p(tags$strong("NOTE 9:"),
                                  " Describe the measurement procedure and the
                                  analytical method used. This method is the
                                  practical process that applies the analytical
                                  principle to obtain the result.",
                                  style = "font-size: 12px;
                                          color: #666; text-align: justify;
                                          margin-top: -10px;
                                          margin-bottom: 25px;"),
                           
                           
                           textInput("unit", "Unit of Measurement:",
                                     saved_params$unit, width = '100%'),
                           tags$p(tags$strong("NOTE 10:"),
                                  " Describe the unit of measurement for the
                                  measurand (e.g., mg/dL, g/dL, mmol/L etc.).",
                                  style = "font-size: 12px; color: #666;
                                          text-align: justify;
                                          margin-top: -10px;
                                          margin-bottom: 25px;"),
                           
                           
                           textInput("specimen", "Sample Type:",
                                     saved_params$specimen, width = '100%'),
                           tags$p(tags$strong("NOTE 11:"),
                                  " Describe the sample type (e.g., whole blood,
                                  serum, plasma, 24-hour urine, random urine etc.).",
                                  style = "font-size: 12px; color: #666;
                                          text-align: justify;
                                          margin-top: -10px;
                                          margin-bottom: 25px;"),
                           
                           
                           textInput("age_range", "Age Range:",
                                     saved_params$age_range, width = '100%'),
                           tags$p(tags$strong("NOTE 12:"),
                                  " Describe the age range concisely to ensure
                                  readability in the HTML report. Suggested
                                  formats for reporting the age range include
                                  simple, direct expressions like '7 to 16 years',
                                  'under 2 years', '7 - 16 years', '< 2 years' etc.",
                                  style = "font-size: 12px; color: #666;
                                          text-align: justify; margin-top: -10px;
                                          margin-bottom: 25px;"),
                           
                           
                           textInput("sex", "Sex:",
                                     saved_params$sex, width = '100%'),
                           tags$p(tags$strong("NOTE 13:"),
                                  " Describe the sex concisely to ensure
                                  readability in the HTML report. Suggested
                                  formats include simple, direct expressions
                                  like 'Male', 'Female', 'M,' 'F', 'Male and Female',
                                  'M and F' etc.",
                                  style = "font-size: 12px;
                                          color: #666; text-align: justify;
                                          margin-top: -10px;
                                          margin-bottom: 25px;"),
                           
                           
                           textAreaInput("exclusion_criteria",
                                         "Exclusion Criteria:",
                                         saved_params$exclusion_criteria,
                                         width = '100%', height = '100px'),
                           tags$div(
                             tags$p(tags$strong("NOTE 14:"),
                                    " Defining exclusion criteria is essential
                                    to ensure that reference intervals accurately
                                    represent the healthy population. In direct
                                    methods, these criteria enable the careful
                                    selection of reference individuals by
                                    eliminating factors that could introduce
                                    unwanted variability, such as recent illnesses
                                    or medication use.",
                                    style = "font-size: 12px;
                                            color: #666; text-align: justify;
                                            margin-top: -10px;
                                            margin-bottom: 15px;"
                             ),
                             tags$p("In the indirect sampling method, filtering
                                    the dataset is essential. Exclusion criteria
                                    should be applied, such as:",
                                    style = "font-size: 12px;
                                            color: #666; text-align:
                                            justify; margin-top: -5px;
                                            margin-bottom: 10px;"
                             ),
                             tags$ul(
                               tags$li(tags$strong("Exclude potentially
                                                   pathological results:"),
                                       " Eliminate values that may skew the
                                       reference distribution, ensuring it
                                       represents healthy individuals. To
                                       increase dataset selectivity, abnormal
                                       results from co-requested laboratory tests
                                       can be used to help identify subclinical
                                       conditions. Additionally, methods like
                                       Latent Abnormal Values Exclusion (LAVE) or
                                       similar approaches allow for iterative
                                       exclusion of latent abnormal values,
                                       refining the dataset more precisely.",
                                       style = "margin-bottom: 10px;"
                               ),
                               tags$li(tags$strong("Remove data from specific
                                                   departments (e.g., oncology,
                                                   Intensive Care Unit,
                                                   Home Care etc):"),
                                       " These departments typically handle
                                       patients in critical conditions that can
                                       significantly alter results.",
                                       style = "margin-bottom: 10px;"
                               ),
                               tags$li(tags$strong("Limit the frequency of
                                                   results per patient within
                                                   the study period:"),
                                       " Including, for example, only the first
                                       result for each patient prevents data
                                       overload from the same individual, which
                                       could bias the sample.",
                                       style = "margin-bottom: 10px;"
                               )
                             ),
                             style = "font-size: 12px; color: #666;
                                     text-align: justify; margin-top: -10px;
                                     margin-bottom: 25px;"
                           ),
                           tags$hr(style = "border-top: 3px solid #4878d5;
                                           margin: 15px 0;"),
                           
                           
             #### C.4.1.1.5. Input: Provide the Comparative Reference Interval
             ####            (if applicable)
                           
                           
                           tags$h2("Provide the Comparative Reference Interval
                                   (if applicable)",
                                   style = "color: #4878d5;
                                           margin-top: 25px;
                                           margin-bottom: 25px;"),
                           
                           
                           
                           numericInput("upper_ref_limit",
                                        "Upper Reference Limit of the
                                        Comparative Reference:",
                                        saved_params$upper_ref_limit,
                                        width = '100%'),
                           
                           
                           numericInput("lower_ref_limit",
                                        "Lower Reference Limit of the
                                        Comparative Reference:",
                                        saved_params$lower_ref_limit,
                                        width = '100%'),
                           
                           
                           textAreaInput("comp_ref_source",
                                         "Source of the Comparative Reference:",
                                         saved_params$comp_ref_source,
                                         width = '100%',
                                         height = '100px'),
                           tags$div(
                             tags$p(tags$strong("NOTE 15:"),
                                    "To perform reference interval verification,
                                    a comparative reference interval must be
                                    provided. This comparative reference interval
                                    can be selected from various sources, such as:",
                                    style = "font-size: 12px; color: #666;
                                            text-align: justify;
                                            margin-top: -10px;
                                            margin-bottom: 15px;"
                             ),
                             tags$ul(
                               tags$li(tags$strong("Reagent Kit Package Inserts: "),
                                       " Specified reference ranges for laboratory
                                       tests based on manufacturer's validation
                                       studies.",
                                       style = "margin-bottom: 10px;"
                               ),
                               tags$li(tags$strong("Scientific publications and
                                                   guidelines from specialized
                                                   organizations: "),
                                       "Intervals derived from multicenter studies
                                       and reviews that reflect widely accepted
                                       practices in the field.",
                                       style = "margin-bottom: 10px;"
                               ),
                               tags$li(tags$strong("Academic Books (Textbooks): "),
                                       "Consolidated and widely accepted reference
                                       intervals based on extensive scientific
                                       literature and available in academic books.",
                                       style = "margin-bottom: 10px;"
                               ),
                               tags$li(tags$strong("Local or multicentric studies: "),
                                       "Results obtained for a specific population
                                       or harmonized across multiple regions.",
                                       style = "margin-bottom: 10px;"
                               ),
                               tags$li(tags$strong("Indirect methods: "),
                                       "  involve previous studies that estimated
                                       reference intervals using patient data stored
                                       in laboratory information systems (LIS),
                                       applying algorithms to identify and exclude
                                       potentially pathological values.",
                                       style = "margin-bottom: 10px;"
                               )),
                             style = "font-size: 12px; color: #666;
                                     text-align: justify; margin-top: -10px;
                                     margin-bottom: 25px;"
                           ),
                           tags$p(
                             tags$strong("NOTE 16:"),
                             " If a Comparative Reference Interval is not
                             specified, the reference interval estimated by the
                             LabRI method itself will be used as the comparative
                             reference. This is because the verification module
                             algorithms of the LabRI method require a comparative
                             reference to perform the verification.",
                             style = "font-size: 12px; color: #666;
                                     text-align: justify; margin-top: -10px;
                                     margin-bottom: 25px;"
                           ),
                           tags$hr(style = "border-top: 3px solid #4878d5;
                                           margin: 15px 0;"),
                           
                           
              #### C.4.1.1.6. Define the sampling method used for the
              ####            study (if applicable)
                           
                           
                           tags$h2("Define the sampling method used for the
                                   study (if applicable)",
                                   style = "color: #4878d5; margin-top: 25px;
                                           margin-bottom: 25px;"),
                           
                           
                           numericInput("max_sample_size",
                                        "Maximum Sample Size:",
                                        saved_params$max_sample_size),
                           tags$p(tags$strong("NOTE 15:"),
                                  " If the maximum sample size is not specified,
                                  a default value of 10,000 will be used. This
                                  value was validated in the LabRI method study
                                  to estimate reference intervals that are
                                  representative of the population served by the
                                  laboratory, ensuring processing efficiency and
                                  timely results.",
                                  style = "font-size: 12px; color: #666;
                                          margin-top: -10px; margin-bottom: 25px;
                                          text-align: justify;"),
                           
                           
              #### C.4.1.1.7. Main Commands
                           
                           
                           tags$hr(style = "border-top: 3px solid #4878d5;
                                           margin: 15px 0;"),
                           tags$h2("Main Commands", style = "color: #4878d5;
                                   margin-top: 25px;margin-bottom: 25px;"),
                           
                           
                 ##### C.4.1.1.7.1. Save Configuration
                           
                           
                           actionButton("save_config", "Save Configuration",
                                        style = "background-color: #0d47a1;
                                                color: white;
                                                border: 2px solid #0a397f;
                                                font-weight: bold;
                                                box-shadow: 2px 2px 5px
                                                rgba(0, 0, 0, 0.3);
                                                border-top-color: #1a5bb5;
                                                border-left-color: #1a5bb5;"),
                           
                           
                 ##### C.4.1.1.7.2. Clear Configuration
                           
                           
                           actionButton("clear_config", "Clear Configuration",
                                        style = "background-color: #fffcc4;
                                                color: black;
                                                border: 2px solid #e1b12c;
                                                font-weight: bold;
                                                box-shadow: 2px 2px 5px
                                                rgba(0, 0, 0, 0.3);
                                                border-top-color: #ffffe0;
                                                border-left-color: #ffffe0;"),
                           
                           
                ##### C.4.1.1.7.3. Generate Report
                           
                           
                           actionButton("generate_report", "Generate Report",
                                        style = "background-color: #31a939;
                                                 color: white;
                                                 border: 2px solid #228b22;
                                                 font-weight: bold;
                                                 box-shadow: 2px 2px 5px
                                                 rgba(0, 0, 0, 0.3);
                                                 border-top-color: #4caf50;
                                                 border-left-color: #4caf50;"),
                           tags$hr(style = "border-top: 3px solid #4878d5;
                                  margin: 15px 0;"),
                           
                           
            ##### C.4.1.1.8. Report an Issue
                           
                           
                           tags$h2("Report an Issue",
                                   style = "color: #4878d5;
                                  margin-top: 25px; margin-bottom: 25px;"),
                           
                           
                           
                           tags$p("Did you encounter any issues with the
                                 LabRI Tool? We appreciate your feedback!
                                 To report a problem, click the link below
                                 to access our issues system on GitHub:",
                                  tags$a(
                                    tags$span("Report an Issue in GitHub",
                                              style = "text-align: justify;
                                                margin-right: 5px;"),
                                    tags$img(src = "https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png",
                                             alt = "GitHub",
                                             style = "width: 20px; height: 20px;
                                               vertical-align: middle;"),
                                    href = "https://github.com/labrgrupo/LabRI_Tool/issues/new/choose",
                                    target = "_blank",
                                    style = "color: #0d47a1; font-weight: bold;
                                      text-decoration: none; display: inline-flex;
                                      align-items: center;"
                                  ),
                                  tags$p(
                                    tags$strong("NOTE 17:"),
                                    " To submit an issue report, you need to have a
                              GitHub account and be logged in.",
                                    style = "font-size: 12px; color: #666;
                                      text-align: justify; margin-top: 10px;"
                                  )),),
                         
                         
                         #### C.4.1.2. Main Panel for Report Viewing
                         
                         
                         mainPanel(
                           uiOutput("report_view"),
                           style = "background-color: #ffffff;
                                   padding: 20px; border-radius: 5px;"
                         ))),
              
              
    ## C.4.2 Report Tab Panel
              
              
              tabPanel("Report",
                       value = "relatorio",
                       uiOutput("report_content"))
  ),
  
  
# C.5. Footer Note
  
  
  tags$footer(
    tags$p("Developed by Alan Carvalho Dias |
         Powered by LabR Group  | License: GPL-3.0  | Code available at: ",
           
           
    ## C.5.1. GitHub Icon with Text Below the Icon
           
           
           tags$a(
             href = "https://github.com/labrgrupo/LabRI_exe",
             target = "_blank",
             style = "color: white; text-decoration: none;
              display: inline-flex; flex-direction: column;
              align-items: center; margin-left: 10px;",
             
             icon("github", style = "font-size: 24px;"),  # GitHub Icon
             tags$span("GitHub",
                       style = "font-size: 12px;")  # Text Below the Icon
           ),
           
           
    ## C.5.2. Website Icon with Hyperlink
           
           
           tags$a(
             href = "https://grupolabr.com/LabRI_Packed",
             target = "_blank",
             style = "color: white; text-decoration: none; display: inline-flex;
               flex-direction: column; align-items: center; margin-left: 10px;",
             
             icon("globe", style = "font-size: 24px;"),  # Globe Icon for Website
             tags$span("Lab R Group Website",
                       style = "font-size: 12px;")  # Text Below the Icon
           ),
           
    ),
    style = "background: linear-gradient(to bottom, #4a7ad8, #062d79);
          color: white; padding: 15px; text-align: center;
          border-top: 1px solid #ddd; margin-top: 20px;"
  ),)



################################################################################
################################################################################
###################### (D) Server for the Shiny App ############################
################################################################################
################################################################################


server <- function(input, output, session) {
  
  
# D.1. Function to save .RData and .Rhistory when the application is stopped
  
  
  onStop(function() {
    # Paths to save the files
    rdata_file <- file.path("3_exports", ".RData")
    rhistory_file <- file.path("3_exports", ".Rhistory")
    
    # Save the workspace and history
    save.image(rdata_file)
    savehistory(rhistory_file)
    cat("Workspace and history automatically saved in 3_exports.\n")
  })
  
  
# D.2. Define the Directory Where the Report Will Be Saved
  
  
  output_dir <- "4_Report"
  
  
# D.3. Create an Accessible Path in Shiny for the Directory Where the Report is Saved
  
  
  addResourcePath("report", output_dir)
  
  
# D.4. Reactive Function to Load the File and Read Columns
  
  
  dataset <- reactive({
    req(input$file_name)
    ext <- tools::file_ext(input$file_name$name)
    if (!ext %in% c("csv", "xls", "xlsx")) {
      showModal(modalDialog(
        title = "Invalid File Format",
        "Please upload a file in CSV, XLS, or XLSX format.",
        easyClose = TRUE,
        footer = NULL
      ))
      return(NULL)
    }
    file_path <- input$file_name$datapath
    if (ext == "csv") {
      read.csv(file_path)
    } else {
      readxl::read_excel(file_path)
    }
  })
  
  
# D.5. Observer to Update the Column List with Names in selectInput
  
  
  observe({
    data <- dataset()
    if (!is.null(data)) {
      col_names <- names(data)
      updateSelectInput(session, "column_name", choices = col_names)
    }
  })
  
  
# D.6. Observer to Save Configuration
  
  
  observeEvent(input$save_config, {
    save_params(input)
    showModal(modalDialog(
      title = "Configuration Saved",
      "The configurations have been saved successfully!",
      easyClose = TRUE,
      footer = NULL
    ))
  })
  
  
# D.7. Observer to Clear Configuration
  
  
  observeEvent(input$clear_config, {
    clear_saved_params()
    updateTextInput(session, "file_name", value = "")
    updateSelectInput(session, "column_name", selected = "")
    updateRadioButtons(session, "ri_type", selected = "Double-sided")
    updateSelectInput(session, "ci_level", selected = 0.90)
    updateNumericInput(session, "decimal_places", value = 2)
    updateTextInput(session, "responsible_person", value = "")
    updateTextAreaInput(session, "measurement_procedure", value = "")
    updateRadioButtons(session, "measurand_name", selected = "yes")
    updateTextInput(session, "name_of_measurand", value = "")
    updateTextInput(session, "unit", value = "")
    updateTextInput(session, "specimen", value = "")
    updateTextInput(session, "age_range", value = "")
    updateTextInput(session, "sex", value = "")
    updateTextAreaInput(session, "exclusion_criteria", value = "")
    updateTextInput(session, "data_source", value = "")
    updateTextInput(session, "upper_ref_limit", value = "")
    updateTextInput(session, "lower_ref_limit", value = "")
    updateTextAreaInput(session, "comp_ref_source", value = "")
    updateNumericInput(session, "max_sample_size", value = 10000)
    
    
    showModal(modalDialog(
      title = "Configuration Cleared",
      "Settings cleared successfully!",
      easyClose = TRUE,
      footer = NULL
    ))
  })
  
  
# D.8. Observer to Generate Report
  
  
  observeEvent(input$generate_report, {
    if (is.null(input$file_name) || input$column_name == "") {
      showModal(modalDialog(
        title = "Error",
        "Please fill in the required fields: File Name and Column Name.",
        easyClose = TRUE,
        footer = NULL
      ))
      return()
    }
    
    
    withProgress(message = 'Please wait... Rendering...', value = 0.5, {
      tryCatch({
        save_params(input)
        
        
    ## D.8.1. Set the Path to Save the Report Inside 4_Report
        
        
        output_file <- file.path(output_dir, "Report_LabRI_method.html")
        
        output_file <- file.path(output_dir, "Report_LabRI_method.html")
        
        params <- list(
          File_Name = input$file_name$datapath,  # Atualizado para usar datapath
          Column_Name = input$column_name,
          Double_sided = ifelse(input$ri_type == "Double-sided", "x", ""),
          Right_sided = ifelse(input$ri_type == "Right-sided", "x", ""),
          Number_of_decimal_places = as.character(input$decimal_places),
          Responsible_person = input$responsible_person,
          Measurement_procedure_and_analytical_method = input$measurement_procedure,
          measurand_name = input$measurand_name,
          Name_of_measurand = input$name_of_measurand,
          Unit_of_measurement = input$unit,
          Type_of_specimen = input$specimen,
          Age_range = input$age_range,
          Sex = input$sex,
          Exclusion_criteria = input$exclusion_criteria,
          Data_source = input$data_source,
          Upper__Reference__Limit__of__Comparative_Reference = input$upper_ref_limit,
          Lower__Reference__Limit__of__Comparative_Reference = input$lower_ref_limit,
          Source_of_comparative_reference_used = input$comp_ref_source,
          Maximum_sample_size = as.character(input$max_sample_size)
        )
        
        
    ## D.8.2. Rendering the RMarkdown Report
        
        
        render("LabRI_script.Rmd",
               output_file = output_file, params = params, envir = globalenv())
        
        incProgress(1, detail = "Rendering completed successfully!")
        
        
    ## D.8.3. Update the "Report" Tab Content with the Generated HTML
        
        
        output$report_content <- renderUI({
          tags$iframe(src = "report/Report_LabRI_method.html",
                      width = "100%",
                      height = "800px",
                      frameborder = "0")
        })
        
        
    ## D.8.4. Automatically Switch to the Report Tab
        
        
        updateTabsetPanel(session, "tabs", selected = "report")
        
        
    ## D.8.5. Trigger blinking effect until user interacts
        
        
        shinyjs::runjs('
        document.body.classList.add("blinking");
        
        // Monitora interações do usuário para parar o piscar
        document.body.addEventListener("click", stopBlinking);
        document.body.addEventListener("keydown", stopBlinking);
        document.body.addEventListener("mousemove", stopBlinking);
        
        function stopBlinking() {
          document.body.classList.remove("blinking");
          document.body.removeEventListener("click", stopBlinking);
          document.body.removeEventListener("keydown", stopBlinking);
          document.body.removeEventListener("mousemove", stopBlinking);
        }
      ')

        
    ## D.8.6. Display a Message to the User Indicating Success
        
        
        showModal(modalDialog(
          title = "Report Completed",
          "The report was generated successfully and is available for viewing in the 'Report' tab.",
          easyClose = FALSE,
          footer = tagList(
            modalButton("Close"),
            downloadButton("download_report", "Save Report")
          )
        ))
        
        
    ## D.8.7. Download function to save the file
        
        
        output$download_report <- downloadHandler(
          filename = function() {
            paste0("Report_LabRI_method_date_", 
                   format(Sys.time(), "%Y.%m.%d"), 
                   "_time_", 
                   format(Sys.time(), "%H.%M.%S"), 
                   ".html")
          },
          content = function(file) {
            file.copy(output_file, file)
          }
        )
        
      }, error = function(e) {
        showModal(modalDialog(
          title = "Error Generating Report",
          paste("An error occurred while generating the report:", e$message),
          easyClose = TRUE,
          footer = NULL
        ))
      })
    })
  })
  
}

shinyApp(ui = ui, server = server)

