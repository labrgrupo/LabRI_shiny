# LabRI — Development history and changelog

This changelog records documented milestones in the development of LabRI. It is not a reconstruction of every intermediate revision. The preserved 2022 and 2023 implementations do not contain explicit application version numbers and are therefore identified by year.

The current-version entry describes documented capabilities; it does not imply that every capability was first introduced in v5.5.3. Historical study-level evaluations are distinguished from calculations implemented in the application.

## v5.5.3 — Current documented local Shiny application (2026)

### Analytical framework

- Adaptive, data-source-agnostic workflow supporting datasets assembled from selected reference individuals or routine laboratory results, subject to appropriate population selection and curation.
- Preprocessing, assessment of distributional components, cluster-driven truncation, adaptive estimation, and reference-limit uncertainty assessment.
- For distributions retaining multiple components, consensus aggregation of candidate reference limits from `refineR` and `reflimR`, with an additional EM-based estimate when eligible. Two-stage winsorization limits the influence of discrepant candidates.
- A combined EM-parametric and nonparametric pathway for a single retained component.
- Verification organized into three levels: statistical uncertainty, equivalence, and concordance. The documented concordance assessments include Lin's concordance correlation coefficient, Fleiss' kappa, and flagging rates.

### Local application and reporting

- Shiny interface for dataset upload, column selection, study information, comparative reference limits, and analytical settings.
- Selection of 90%, 95%, or 99% confidence levels through the interface.
- Analytical code and HTML report generation delegated to `LabRI_script.Rmd`.
- Saved configurations, background report generation, progress by analytical stage, detailed execution messages, and cancellation.
- Local analytical outputs, including figures, spreadsheets, intermediate files, and HTML reports; report viewing and download through the interface.

### Evolution relative to the early R Markdown implementations

The documented framework extends the early EM-based workflow with a consensus pathway combining complementary estimators, two-stage winsorization, and an explicitly organized three-level verification process. The local Shiny interface also replaces direct editing of analysis settings in the R Markdown document.

The available historical records do not establish the exact intermediate release in which each change was introduced. Changes exclusive to v5.5.3 relative to v5.5.2 are not inferred here.

## 2023 — R Markdown revision (no explicit version number)

### Changed relative to the preserved 2022 implementation

| Area | Documented change | Practical effect |
| :--- | :--- | :--- |
| **Component retention** | Added exclusion of fitted mixture components with weights at or below 10%, in addition to the location-based retention rule. | Can change the retained components, truncation boundaries, and final reference limits. |
| **Subsampling** | Added `Maximum_sample_size` and random sampling without replacement. | Allows the number of analyzed observations to be limited, reducing computational demand. |
| **Randomness control** | Added explicit calls to `set.seed(200707042)` at the start and at multiple analytical stages. | Controls random operations for repeatability with the same inputs and computational environment. |
| **Input order** | The sampling operation also permutes observations when the full dataset is selected. | Can change the assignment of the position-dependent perturbations used to break ties. |
| **Skewness alert** | Aligned the text used by the skewness alert with the generated classification text. | Corrects the corresponding reporting flag without changing the skewness formula. |
| **Documentation** | Translated the report and input parameters into English, added explicit UTF-8 handling for table labels, and corrected the 10th-percentile label. | Improves report presentation and interpretation. |

### Retained analytical procedures

- Five initial Tukey filtering cycles using `k = 2` and the `resistant` method.
- Position-dependent perturbation of results to break ties.
- Adaptive comparison of Box–Cox `loglik` and `Guerrero` transformations, with rules based on skewness and kurtosis.
- Gaussian mixture modeling with EM, evaluation of one to seven components, and component-count selection using BIC-based criteria and modal information.
- Multicriteria selection of a central component, component-based truncation, and use of modes and antimodes.
- Combined parametric/empirical limits for one retained component, or empirical quantiles following truncation and final filtering for multiple retained components.
- Reference-limit confidence intervals presented at 90%, Bias Ratio, flagging rates, and confidence-interval/reference-interval width ratios.

No new statistical evaluation module was identified in the comparison of the two preserved scripts. Both implementations run as R Markdown documents and generate HTML reports; neither is a Shiny application.

## 2022 — Original LabRI implementation (no explicit version number)

### Estimation and implementation

- Original implementation in R Markdown, with study settings entered in the document and HTML report generation.
- Adaptive statistical pipeline combining Tukey filtering, Box–Cox transformation, Gaussian mixture modeling with EM, multicriteria component selection, and truncation.
- Estimation using parametric/empirical limits or nonparametric quantiles according to the retained-component structure.
- Reference-limit confidence intervals presented at 90%, Bias Ratio, flagging rates, and confidence-interval/reference-interval width ratios in the preserved script.
- Sex and age partitions prepared before analysis rather than generated automatically by the tool.

### Original development study

The method was documented in Alan Carvalho Dias's 2022 MBA in Data Science & Analytics final project at USP/ESALQ, titled *Population reference intervals: an indirect approach based on mixture deconvolution and truncation points* (title translated from Portuguese).

- Algorithm development and readjustment using datasets in Groups A and B, guided by Bias Ratios for the lower limit, midpoint, and upper limit, with a reference threshold of 0.375.
- Subsequent testing using Groups C and D, including scenarios with no relevant contamination and different degrees of contamination by abnormal results.
- External comparison with `kosmic` and `refineR`. These were comparator methods, not estimators incorporated into a LabRI consensus result.
- Study-level evaluation using confusion matrices, accuracy, Cohen's kappa, sensitivity, specificity, positive and negative predictive values, F1, and macro-averages.

These study-level comparisons do not imply that every evaluation metric was implemented in the preserved main R Markdown script. The original method combined algorithms within an adaptive pipeline; it did not implement the later consensus among independent estimators.

The study's percentage of abnormal results must not be confused with the mixture-component weight threshold added in the preserved 2023 script.

## Version associated with a publication

The software version supporting published results should be identified by the corresponding archived code or release. A later application update does not replace that research record. The current interface version alone does not establish which code generated an earlier study's results.

## Future entries

For each new release, record the version, release date, specific changes, and whether they affect numerical results, interpretation, or application operation. Separate changes to the statistical method from interface and documentation changes, and retain the source code corresponding to each release.
