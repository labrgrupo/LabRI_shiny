# [𝗟𝗮𝗯𝗥𝗜 𝗦𝗵𝗶𝗻𝘆 𝗔𝗽𝗽𝗹𝗶𝗰𝗮𝘁𝗶𝗼𝗻](https://img.shields.io/badge/LabRI%20Shiny%20Application-%230070C0?style=for-the-badge&logoColor=white)

![](https://img.shields.io/github/license/labrgrupo/LabRI_Tool.svg)
![](https://img.shields.io/github/last-commit/labrgrupo/LabRI_Tool/main.svg)

<img src="www/Logo.svg" width="350px" height="250px" align="right"/>

The **LabRI Shiny Application** is designed for the estimation and verification of reference intervals in clinical laboratories. It runs on the user's computer after prior installation of R and RStudio, and provides a desktop-style workflow with **automatic persistence of figures, spreadsheets, intermediate files, and HTML reports** in local output folders.

This repository includes three key components:

- **`install_packages.Rmd`** — Ensures that all required R packages are correctly installed and updated, simplifying the configuration of the R environment for running the LabRI System.
- **`app.R`** — Launches the Shiny application, providing an intuitive graphical interface to execute the LabRI method interactively.
- **`LabRI_script.Rmd`** — Primary script that implements the `LabRI method`, responsible for estimating and verifying reference intervals and producing comprehensive HTML reports.

> 💡 A **cloud-ready** version of this application — designed for deployment on Posit Connect, Posit Cloud, and institutional Shiny servers — is also available: [**LabRI_shiny_connect**](https://github.com/labrgrupo/LabRI_shiny_connect). See the [comparison table](#-local-execution-vs-cloud-ready-version) below.

---

## 𝗨𝘀𝗲𝗿 𝗶𝗻𝘁𝗲𝗿𝗳𝗮𝗰𝗲

The initial interface captures the analyst's name in the **Name of the Responsible Specialist** section and accepts `.csv`, `.xls`, or `.xlsx` uploads in the **Define the Dataset** section, where the relevant data column is selected. A status bar tracks processing progress.

<img src="www/Interface_Shiny.png" width="800px" height="400px"/>

The application can be obtained from this GitHub repository or as a **compressed folder** ready to run, with no additional installation steps beyond R and Shiny — ideal for users who prefer to interact with the LabRI method through a graphical interface without relying on automation files or installers.

<div align="center">

### 👇 **Click here to download the LabRI Shiny Application** 👇

<a href="https://www.dropbox.com/scl/fi/joo13sc02dctn74a394ay/LabRI_tool.zip?rlkey=pe4hou2048lep80z1q9nllz06&st=oxe4wmvu&dl=1" target="_blank">
  <img src="https://img.shields.io/badge/LabRI Shiny Application -%23009C3B?style=for-the-badge&logo=google-chrome&logoColor=%23009C3B&labelColor=%23fee21d" alt="Download LabRI Shiny Application" style="height: 50px;">
</a>

</div>

---

## 🌐 𝗟𝗼𝗰𝗮𝗹 𝗲𝘅𝗲𝗰𝘂𝘁𝗶𝗼𝗻 𝘃𝘀. 𝗰𝗹𝗼𝘂𝗱-𝗿𝗲𝗮𝗱𝘆 𝘃𝗲𝗿𝘀𝗶𝗼𝗻

The LabRI Shiny tool is distributed in **two complementary implementations** that share the same analytical method but differ in their output-management strategy:

- **LabRI Shiny Application (this repository)** — runs locally after R and RStudio are installed. Automatically creates `3_Outputs/Figures/`, `3_Outputs/Spreadsheets/`, and `4_Report_HTML/` and writes figures, spreadsheets, intermediate files, and HTML reports to disk. Appropriate for **single-user desktop workflows**.
- **[LabRI_shiny_connect](https://github.com/labrgrupo/LabRI_shiny_connect)** — cloud-ready implementation for **Posit Connect**, **Posit Cloud**, or institutional Shiny servers. Operates in **session-based mode**, with no persistent files written to the server directory. Outputs are rendered inside the Shiny interface or in temporary session files, and the HTML report can be downloaded manually by the user.

A public demonstration of the cloud-ready version is available at **[labrgroup-labri.share.connect.posit.cloud](https://labrgroup-labri.share.connect.posit.cloud/)** (Posit Connect Cloud Free plan — intended as a showcase only, not for production use).

| Feature | LabRI Shiny Application (local execution) | LabRI_shiny_connect |
|---|---:|---:|
| Runs on the user's computer | Yes | Optional |
| Requires prior installation of R and RStudio | Yes | No (for end users in a deployed cloud environment) |
| Designed for Posit Connect / Posit Cloud | No | Yes |
| Automatically creates output folders | Yes | No |
| Automatically saves figures | Yes | No |
| Automatically saves spreadsheets | Yes | No |
| Automatically saves HTML reports to fixed folders | Yes | No |
| Saves `.RData` / `.Rhistory` | Possible | No |
| Uses temporary files only for session rendering | No | Yes |
| Displays report in the Shiny interface | Yes | Yes |
| Browser-based use without local execution | No | Yes |

The **analytical method is identical** in both implementations; only the output architecture differs. The local version is preferred for individual analytical work and for processing larger datasets without cloud memory constraints, while the cloud-ready version is preferred for institutional deployment, demonstrations, training environments, and multi-user access.

---

## 𝗧𝗵𝗲 𝗟𝗮𝗯𝗥𝗜 𝗠𝗲𝘁𝗵𝗼𝗱

The **LabRI Method** is the analytical core of the **LabRI System**, implemented primarily in `LabRI_script.Rmd`. It is organized in two modules:

- **Estimation Module** — adaptive, multi-criteria estimation of reference intervals via data cleaning, transformation, and clustering, using `refineR`, `reflimR`, and the Expectation–Maximization (EM) algorithm (`mclust`, `mixR`).
- **Verification Module** — three-level analysis assessing statistical uncertainty, equivalence, and concordance, ensuring the estimated intervals are reliable for clinical application.

---

## [𝗔. 𝗘𝘀𝘁𝗶𝗺𝗮𝘁𝗶𝗼𝗻 𝗠𝗼𝗱𝘂𝗹𝗲](https://img.shields.io/badge/LabRI%20Shiny%20Application-%230070C0?style=for-the-badge&logoColor=white)

This module provides an **adaptive, multi-criteria approach for the indirect estimation** of reference intervals, combining parametric and non-parametric percentile approaches according to the number of clusters in the truncated distribution.

### Adaptive behavior

- **Multi-cluster distributions** — The reference limits estimated by `refineR` and `reflimR` are combined through the **Centroid of Winsorized Reference Limits**: the *Two-stage Winsorization* sub-algorithm first estimates robust winsorized limits, then the *Hartigan–Wong Centroid Reference Limits* sub-algorithm computes the centroid (x = lower limit, y = upper limit) for a centralized, stable estimate. When clusters are sufficiently separated, the EM algorithm further refines the result.
- **Single-cluster distributions** — The EM algorithm applies parametric and non-parametric methods to derive the best reference interval estimate.

### Multi-criteria design

Multiple criteria and methods are combined to ensure robust and comprehensive estimation and verification.

---

## [𝗕. 𝗩𝗲𝗿𝗶𝗳𝗶𝗰𝗮𝘁𝗶𝗼𝗻 𝗠𝗼𝗱𝘂𝗹𝗲](https://img.shields.io/badge/LabRI%20Shiny%20Application-%230070C0?style=for-the-badge&logoColor=white)

Before routine clinical application — and especially when reference intervals are derived from indirect methods — laboratories must verify their reference intervals. The Verification Module performs a **three-level analysis** to assess whether compared reference limits are equivalent:

1. **First Level — Statistical Uncertainty.** Evaluates the magnitude of statistical uncertainty associated with the reference limits. If uncertainty is within acceptable bounds, the analysis proceeds to the second level.
2. **Second Level — Distance Criterion Based on Equivalence Testing.** Compares the LabRI-estimated reference limit with a comparative limit using equivalence testing to assess whether differences are large enough to be considered relevant from a practical or clinical standpoint.
3. **Third Level — Concordance Evaluation.** Triggered when the second level suggests *Possible Equivalence* or *Probable Equivalence*. Incorporates confidence intervals and applies Fleiss' Kappa, Lin's Concordance Correlation Coefficient, and Flagging Rates to support robust verification.

---

## 𝗧𝘂𝘁𝗼𝗿𝗶𝗮𝗹

A usage tutorial covering the installation of R and RStudio and the operation of the Shiny tool is available on the **Grupo Lab R website**, which centralizes the documentation and supporting materials for the LabRI System and other tools developed by the group.

<div align="center">

### 👇 **Click here to visit the Grupo Lab R website** 👇

<a href="https://grupolabr.com/" target="_blank">
  <img src="https://img.shields.io/badge/Visit%20Grupo%20Lab%20R%20Website-%23009C3B?style=for-the-badge&logo=google-chrome&logoColor=%23009C3B&labelColor=%23FFDF00" alt="Grupo Lab R Website" style="height: 50px;">
</a>

</div>

---

## [𝗖𝗼𝗻𝘁𝗮𝗰𝘁](https://img.shields.io/badge/LabRI%20Shiny%20Application-%230070C0?style=for-the-badge&logoColor=white)

**Submit suggestions and bugs at:**  
https://github.com/labrgrupo/LabRI_Tool/issues

**Email:**  
alancdias@hotmail.com · labrgrupo@gmail.com

**Link to the publication:**  

---

## 𝗟𝗶𝗰𝗲𝗻𝘀𝗲

Distributed under the **GPL-3.0** license.

---
