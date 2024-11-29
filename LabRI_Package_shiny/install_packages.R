
# 1. Debug: Exibir informações do ambiente #####################################


cat("Starting R Package installation and update...\n")
cat("Target library: ", .libPaths(), "\n")


# 2. Configure a CRAN mirror ###################################################


options(repos = c(CRAN = "https://cloud.r-project.org"))


# 3. Local library path ########################################################


local_lib <- file.path(Sys.getenv("LOCALAPPDATA"), "R", "win-library", 
                       paste0(R.version$major, ".", R.version$minor))


# 4. Create directory if necessary #############################################


if (!dir.exists(local_lib)) {
  dir.create(local_lib, recursive = TRUE)
  cat("Creating local library at: ", local_lib, "\n")
}


# 5. Update the library path ###################################################


.libPaths(local_lib)


# 6. List of required packages #################################################


if (!requireNamespace("shiny", quietly = TRUE)) install.packages("shiny", lib = local_lib)

required_packages <- c("AID", "DT", "FactoMineR", "KernSmooth", "MASS", "MethComp",
                       "RVAideMemoire", "calibrate", "cartography", "cluster",
                       "datawizard","data.table", "devtools", "digest", "dplyr", "epiR",
                       "factoextra","ffp", "forecast", "ggQC", "ggplot2", "ggpubr",
                       "ggtext", "grid", "gt","imputeTS", "installr", "irr", "janitor",
                       "kableExtra", "knitr","lattice", "lubridate", "mclust", "mixR",
                       "modeest", "moments","multimode", "multiway", "nortest",
                       "openxlsx", "pacman", "plotly","prettydoc", "qqplotr", "readr",
                       "readxl", "refineR", "reflimR","reshape2", "rmarkdown","scales",
                       "shiny","shinyjs","shiny.exe","shinythemes","stats", "stringi", 
                       "systemfonts","tools","utf8","univOutl", "xfun","writexl","zlog")


# 7. Function to install or update packages ####################################


install_or_update <- function(packages) {
  for (pkg in packages) {
    if (!requireNamespace(pkg, quietly = TRUE)) {
      cat("Installing missing package: ", pkg, "\n")
      tryCatch({
        install.packages(pkg, lib = local_lib)
      }, error = function(e) {
        cat("Error installing package ", pkg, ": ", e$message, "\n")
        stop("Unable to install the required package: ", pkg)
      })
    } else {
      cat("Package ", pkg, " is already installed. Updating to the latest version...\n")
      tryCatch({
        install.packages(pkg, lib = local_lib)
      }, error = function(e) {
        cat("Error updating package ", pkg, ": ", e$message, "\n")
      })
    }
  }
}


# 8. Install or update packages ################################################


install_or_update(required_packages)
