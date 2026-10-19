<div align="center">

![LabRI](https://img.shields.io/badge/LabRI-SHINY%20APPLICATION-0078B4?style=for-the-badge&labelColor=555BA6)

# LabRI Shiny Application

**Local execution · Reference interval estimation and verification**

![Version](https://img.shields.io/badge/Version-5.5.2-555BA6?style=flat-square)
![R](https://img.shields.io/badge/Built%20with-R%20%2F%20Shiny-0078B4?style=flat-square&logo=r&logoColor=white)
![License](https://img.shields.io/github/license/labrgrupo/LabRI_shiny?style=flat-square&color=555BA6)
![Latest update](https://img.shields.io/github/last-commit/labrgrupo/LabRI_shiny?style=flat-square&color=0078B4)

[Download](#download) · [Installation](#installation-and-launch) · [Interface](#user-interface) · [Outputs](#local-outputs) · [Methods](#analytical-workflow) · [Local vs. Connect](#local-execution-and-connect-version)

</div>

---

<div align="justify">

## Overview

<img src="logo_LabRI.png" width="250" align="right" alt="LabRI logo" />

**LabRI (Laboratory Reference Interval)** is an R/Shiny application for reference interval estimation and verification in clinical laboratories. This implementation runs on the user's computer and presents its interface in a local browser window.

The application combines complementary statistical methods within an adaptive, multi-method consensus workflow. It supports the assessment of reference limits, their statistical uncertainty, and their agreement with comparative reference intervals.

The **local version automatically saves analytical outputs to disk**, including figures, spreadsheets, intermediate files, and HTML reports. It is intended for individual analytical workflows in which the user needs to retain and review the generated material.

<br clear="all" />

## Download

The **version 5.5.2** local application package is available as **`LabRI_tool_v5.5.2.zip`**. Open **Releases**, select the corresponding release, and download this file under **Assets**.

<div align="center">

<a href="https://github.com/labrgrupo/LabRI_shiny/releases">
  <img src="https://img.shields.io/badge/VIEW%20RELEASES-DOWNLOAD%20LOCAL%20APPLICATION-0078B4?style=for-the-badge&amp;labelColor=555BA6" width="520" alt="Open LabRI releases and download the local Shiny application" />
</a>

</div>

Extract the entire package before use, preserving its folder structure. The ZIP contains the application files; **R and the required R packages must be installed separately**, as described below.

## Installation and launch

### Requirements

| Requirement | Purpose |
| :--- | :--- |
| **R** | Runs the application and its statistical procedures. |
| **RStudio — recommended** | Provides a convenient environment for package installation, R Markdown documents, and launching the application. |
| **Required R packages** | Provide Shiny, statistical methods, data import, and report-generation functionality. Use the supplied installation document. |
| **Writable application folder** | Allows the local implementation to create output directories and save results. |

### Setup

1. **Install R and RStudio.** The tutorial listed under [Documentation](#documentation) covers the setup and use of the application.
2. **Extract the application ZIP.** Keep all supplied files and subfolders together in a writable location on your computer.
3. **Install the dependencies.** Open `install_packages.Rmd` in RStudio and run its package-installation instructions. Internet access is needed to download packages that are not already installed.
4. **Locate the application folder.** Use the directory containing `app.R` as the working directory. If the archive has an outer folder, navigate into the application folder before launching.
5. **Launch LabRI.** Open `app.R` and click **Run App** in RStudio, or execute the following command from that directory:

   ```r
   shiny::runApp(".", launch.browser = TRUE)
   ```

Keep the R session running while using the interface. Stop the application when the analysis is finished.

## Application components

The main files within the application package are:

| File | Role |
| :--- | :--- |
| **`install_packages.Rmd`** | Installs and prepares the R package dependencies. |
| **`app.R`** | Defines and launches the Shiny interface. |
| **`LabRI_script.Rmd`** | Implements the analytical workflow and generates the HTML report. |

## User interface

Enter the analyst's name under **Name of the Responsible Specialist**, then upload a `.csv`, `.xls`, or `.xlsx` file under **Define the Dataset** and select the column containing the results to analyze. The interface displays a processing status bar during execution.

<div align="center">

<img src="www/Interface_Shiny.png" width="900" alt="LabRI Shiny application interface: specialist identification, dataset selection, and analysis settings" />

</div>

Review the selected data column and analysis settings before processing. After execution, inspect the estimated reference limits, uncertainty assessment, figures, and generated report.

## Local outputs

The local implementation creates the following output directories within its application workspace:

| Directory | Content |
| :--- | :--- |
| **`3_Outputs/Figures/`** | Generated analytical figures. |
| **`3_Outputs/Spreadsheets/`** | Generated spreadsheets and tabular outputs. |
| **`4_Report_HTML/`** | HTML reports documenting the analysis. |

The workflow also retains intermediate analytical files. Preserve the relevant outputs together with the input dataset and the application version used for each analysis.

## Analytical workflow

LabRI uses a **data-source-agnostic statistical workflow**: its analytical procedures can be applied after a dataset has been assembled from selected reference individuals or routine laboratory results. The suitability of the data and the interpretation of the resulting intervals depend on population selection, curation, sample size, and distributional characteristics.

### Estimation module

The estimation pathway adapts to the characteristics of the distribution and the components retained after preprocessing and cluster-driven truncation.

| Stage | Purpose |
| :--- | :--- |
| **Preprocessing** | Clean the input results and assess whether transformation is indicated. |
| **Distribution assessment** | Evaluate the component structure using complementary statistical criteria and Gaussian mixture modeling. |
| **Cluster-driven truncation** | Identify the portion of the distribution retained for estimation. |
| **Adaptive estimation** | Apply the applicable parametric, nonparametric, or multi-method consensus pathway. |
| **Uncertainty and reporting** | Assess reference-limit uncertainty and document the analytical pathway in an HTML report. |

For distributions retaining multiple components, the workflow combines candidate reference limits from `refineR` and `reflimR`, with an additional EM-based estimate when its eligibility criteria are met. Two-stage winsorization and consensus aggregation reduce the influence of discrepant candidates. A single retained component follows a combined EM-parametric and nonparametric pathway.

### Verification module

When comparative reference limits are supplied, the verification workflow supports three levels of assessment:

| Level | Assessment |
| :--- | :--- |
| **1 · Statistical uncertainty** | Evaluate the uncertainty associated with the reference limits before proceeding to subsequent levels. |
| **2 · Equivalence** | Assess the distance between estimated and comparative reference limits using the workflow's equivalence criteria. |
| **3 · Concordance** | When the preceding assessment indicates possible or probable equivalence, evaluate agreement using Lin's concordance correlation coefficient, Fleiss' kappa, and flagging rates. |

These assessments support interpretation and local verification; they must be considered alongside data curation, population suitability, and clinical plausibility.

## Local execution and Connect version

The local and Connect implementations share the LabRI analytical framework and differ primarily in how execution and outputs are managed.

| Feature | Local version — this repository | Connect version |
| :--- | :--- | :--- |
| **Execution** | R running on the user's computer. | R running in the hosting environment. |
| **User interface** | Local browser window. | Browser access to the deployed application. |
| **R installation for the end user** | Required. | Not required for access to a deployed instance. |
| **Output management** | Automatic saving to local folders. | Session-specific temporary storage and user downloads. |
| **HTML report** | Displayed in the interface and saved locally. | Viewed in the interface and downloaded by the user. |
| **Main use** | Individual analyses with retained local outputs. | Hosted access, demonstrations, and training. |
| **Available resources** | Depend on the user's computer. | Depend on the hosting configuration. |

For hosted deployment, use **[LabRI_shiny_connect](https://github.com/labrgrupo/LabRI_shiny_connect)** and its deployment instructions. A [public browser demonstration](https://labrgroup-labri.share.connect.posit.cloud/) is also available. Deployment to other Shiny hosting environments may require configuration changes.

## Documentation

Installation and usage tutorials are available on the **Grupo Lab R website**.

<div align="center">

<a href="https://grupolabr.com/">
  <img src="https://img.shields.io/badge/DOCUMENTATION-GRUPO%20LAB%20R-0078B4?style=for-the-badge&amp;labelColor=555BA6" width="400" alt="Visit Grupo Lab R for LabRI installation and usage tutorials" />
</a>

</div>

Datasets and reports supporting the LabRI study are available in the separate [supplementary material repository](https://github.com/labrgrupo/Supplementary_Material_CCA_LabRI).

## Contact and support

Report reproducible problems and suggest improvements through the repository's [Issues page](https://github.com/labrgrupo/LabRI_shiny/issues). Include the application version, R version, operating system, and error message when reporting a problem.

| Contact | Email |
| :--- | :--- |
| **Alan Carvalho Dias** | [alancdias@hotmail.com](mailto:alancdias@hotmail.com) |
| **Grupo Lab R** | [labrgrupo@gmail.com](mailto:labrgrupo@gmail.com) |

## License

Distributed under the **GPL-3.0** license. See [LICENSE.txt](LICENSE.txt) for the license terms.

</div>

---

<div align="center">
<sub><strong>LabRI Shiny Application · Local version</strong><br />Developed by Alan Carvalho Dias · Grupo Lab R</sub>
</div>
