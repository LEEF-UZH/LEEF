LEEF CA planning
================

<!-- README.md is generated from README.Rmd. Please edit that file -->

# Description

This document contains information on

1.  How the pipeline as it s implemented by the LEEF-UZH project ( by
    using the `LEEF` package) can be used and managed, and
2.  How the pipeline can be setup and internals of the LEEF package.

# Reading this documentation

The easiest to read the documentation is to go to the [package
website](https://leef-uzh.github.io/LEEF/) to see all documentation of
the functions under the menu item
[Reference](https://leef-uzh.github.io/LEEF/reference/index.html) and to
access further documentation in the “Articles” menu. The articles are
also available as vignettes in the R package `LEEF`.

## Measurements in the Pipeline

The actual measurement protocols are located on the Teams server of pour
group. If you have access to it, the links below will point you tho the
documents.

-   **sampling** see
    <a href="https://teams.microsoft.com/l/file/7E868619-064E-4C6B-BC89-935C190130D4?tenantId=c7e438db-e462-4c22-a90a-c358b16980b3&fileType=docx&objectUrl=https%3A%2F%2Fuzh.sharepoint.com%2Fsites%2FLEEF%2FShared%20Documents%2FGeneral%2F05_protocols%2FSampling_manual.docx&baseUrl=https%3A%2F%2Fuzh.sharepoint.com%2Fsites%2FLEEF&serviceName=teams&threadId=19:d14a98eb700e4721b35583265c27e8a3@thread.tacv2&groupId=13ba9e9a-1d5d-42b1-9a95-08fd956973cc" target="_blank">link</a>
    for manual
-   **bemovi** see
    <a href="https://teams.microsoft.com/_#/school/files/General?threadId=19%3Ad14a98eb700e4721b35583265c27e8a3%40thread.tacv2&ctx=channel&context=1_Videoing_documents&rootfolder=%252Fsites%252FLEEF%252FShared%2520Documents%252FGeneral%252F05_protocols%252F1_Videoing_documents" target="_blank">link</a>
    for manual
-   **flowcam** see
    <a href="https://teams.microsoft.com/l/file/2381A032-18A4-4649-B072-871BFF45B788?tenantId=c7e438db-e462-4c22-a90a-c358b16980b3&fileType=docx&objectUrl=https%3A%2F%2Fuzh.sharepoint.com%2Fsites%2FLEEF%2FShared%20Documents%2FGeneral%2F05_protocols%2FFlowcam_manual.docx&baseUrl=https%3A%2F%2Fuzh.sharepoint.com%2Fsites%2FLEEF&serviceName=teams&threadId=19:d14a98eb700e4721b35583265c27e8a3@thread.tacv2&groupId=13ba9e9a-1d5d-42b1-9a95-08fd956973cc" target="_blank">link</a>
    for manual
-   **flowcytometer** see
    <a href="https://teams.microsoft.com/l/file/D0C66850-57BD-49D1-8ED9-528C57B7FC36?tenantId=c7e438db-e462-4c22-a90a-c358b16980b3&fileType=docx&objectUrl=https%3A%2F%2Fuzh.sharepoint.com%2Fsites%2FLEEF%2FShared%20Documents%2FGeneral%2F05_protocols%2FFlowcytometer_manual.docx&baseUrl=https%3A%2F%2Fuzh.sharepoint.com%2Fsites%2FLEEF&serviceName=teams&threadId=19:d14a98eb700e4721b35583265c27e8a3@thread.tacv2&groupId=13ba9e9a-1d5d-42b1-9a95-08fd956973cc" target="_blank">link</a>
    for manual
-   **manual** count see
    <a href="https://teams.microsoft.com/l/file/336D64DD-53FC-4ED1-9E2D-DDE653C357BF?tenantId=c7e438db-e462-4c22-a90a-c358b16980b3&fileType=docx&objectUrl=https%3A%2F%2Fuzh.sharepoint.com%2Fsites%2FLEEF%2FShared%20Documents%2FGeneral%2F05_protocols%2FManual_count_manual.docx&baseUrl=https%3A%2F%2Fuzh.sharepoint.com%2Fsites%2FLEEF&serviceName=teams&threadId=19:d14a98eb700e4721b35583265c27e8a3@thread.tacv2&groupId=13ba9e9a-1d5d-42b1-9a95-08fd956973cc" target="_blank">link</a>
    for manual
-   **O<sub>2</sub> meter** see
    <a href="https://teams.microsoft.com/l/file/A486E46E-A2F1-44F6-89A2-6A05E5B44F27?tenantId=c7e438db-e462-4c22-a90a-c358b16980b3&fileType=docx&objectUrl=https%3A%2F%2Fuzh.sharepoint.com%2Fsites%2FLEEF%2FShared%20Documents%2FGeneral%2F05_protocols%2FO2_manual.docx&baseUrl=https%3A%2F%2Fuzh.sharepoint.com%2Fsites%2FLEEF&serviceName=teams&threadId=19:d14a98eb700e4721b35583265c27e8a3@thread.tacv2&groupId=13ba9e9a-1d5d-42b1-9a95-08fd956973cc" target="_blank">link</a>
    for manual

# Installation of the `LEEF` R package

This R package contains the functionality used for processing the data
in the LEEF project.

The R package is in a
[drat](https://dirk.eddelbuettel.com/code/drat.html) repository, i.e. an
R repository with the same functionality as CRAN, only managed by the
maintainer of the LEEF-UZH organisation on github.

To install it, you need to install the `drat` package if it is not
installed yet

``` r
install.packages("drat")
```

To install the `LEEF` package, you simply have to run

``` r
drat::addRepo("LEEF-UZH")
install.packages("LEEF")
```

This installs the `LEEF` package and all additional `LEEF.xxx` packages
needed for processing, archiving and adding the research ready data to
an SQLite database.

# Funding

The project is funded by the SNF Project 310030\_188431.
