R Notebook
================

<!-- README.md is generated from README.Rmd. Please edit that file -->

-----

<!-- [![Coverage status](https://codecov.io/gh/rkrug/LEEF.Data/branch/master/graph/badge.svg)](https://codecov.io/github/rkrug/LEEF.Data?branch=master) -->

<!-- [![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental) -->

-----

bftools from
<https://docs.openmicroscopy.org/bio-formats/5.8.2/users/comlinetools/conversion.html>
(2018/06/22)

-----

# TODO

## **<span style="color:red">WORKING ON IT</span>** — revise configuration and initialisation

**<span style="color:red">Should be working, but have to adjust the
tests to make sure\!\!\!\!\!\!\!</span>**

Remove the `CONFIG.NAME` file and incorporate it in the `config.yml`
file.

Configuration should be done by running a `initialize_db()` function
which 1) reads `config.yml` from working directory 2) creates directory
structure (if not already existing) 3) creates empty database (if not
slready existing) 4) adds `pre-processors`, `extractors`, … This will
make the usage of different databases much easier and the package much
more versatile

## Move `pre-processors` and `extractors` into separate packages

These will contain the functions and the code to add it to the queue for
processing. This adds flexibility as additional data sources can be
added easier.

## Documentation and tests need to be revised and completed

  - revise Tests
  - revise documentation

## Metadata storage **<span style="color:red">TODO</span>**

Which metadata should be stored and in which format? Metadata is
required at different levels:

1.  new data package

<!-- end list -->

  - date, experiment, who collated the data package (responsible for
    it), comments, …
  - linked via the hash used for the TTS

<!-- end list -->

2.  data source

<!-- end list -->

  - machine, type, version, person who processed the data, comments, …

<!-- end list -->

3.  per experiment

<!-- end list -->

  - name, person responsible, info about experiment, comments, …
    
    How to store the description of the experiment - link to paper /
    outline?

<!-- end list -->

4.  I am sure we need more\!\!\!\!\!\!

## Define database structure including hash and id fields

1)  define fields and linkages between tables
2)  add hash and id fields to `.rds` files in the `LastAdded` folder
3)  Write code to write LastAdded to SQLite database

## function to request DOI

This function will publish the data at the is only necessary for public
repos, but the functionality needs to be included here. This needs to be
done in a github repo - gitlab possible?

## Download seed file

After the TTS is obtained, the seed is downloiaded and saved in the
directory as well. This needs to be automated and done later, as the
seed is only avvailable about 24 hours after the initial
submission.

## Investigate the possiblility of using the gitlab installation from Mathematics department for the local storage.

This is unlikely using the current structure and hopefully new options
will materialise after the Bern meeting.

## Add remote storage instead of SQLite database

-----

# DONE

## Hashing and TTS for new\_data **<span style="color:red">TODO</span>**

Request TTS (Trusted Time Stamp) is obtained from `archive_new_data()`
and is stored in the samd directory as the archive

## build hash / checksum of archive

This is used only to checksum the archive and for obtaining the TTS for
the archive hash.

## Pre-processing of data

Conversion to open formats for archiving and fuerther procesing

## Extraction of data

Extraction of dat and storage in data.table / tibble for addition to
database

## Confirm on what `raw data` is for archiving, DOI, …

At the moment, data is converted from proprietory to open formats and
archived afterwards.

-----

# Introduction

This repo contains an R package for

  - importing new data into the data base
  - accessing the data base

which contains data from the experiments.

It only contains the infrastructure, while the source specific
processing is provided by source specific packages which are called from
this package.

The data is stored locally in a directory structure an SQLite database,
but remote storage is planned.

Functions which need to be called by the user are: \* `initialize_DB()`:
to read the config file and to setup the needed directory structure \*
`import_new_data()`: to import new data \*
**<span style="color:red">TODO</span>** \`

1.  import of new data
2.  request new foreacasts

# Dependencies

## bioconductor packages

The extaction of the datra from the flowcytometer depends on
bioconductor packages. They can be ionstalled as followed (details see
<https://bioconductor.org/install/#install-bioconductor-packages> )

It is also possible, that the following packages have to be installed by
hand:

# Installation of R package

## Prerequisites

As the package is only on github, you need `devtools` to install it
easily as a prerequisite

``` r
install.packages("devtools")
```

## Installation of the package

``` r
devtools::install_github("rkrug/LEEF.Data")
```

## Update of the data

If the repo contains the data (in `inst/data/` folder in sqlite format),
the package needs to be updated when new data is available via

``` r
devtools::install_github("rkrug/LEEF.Data")
```

If the data is stored externally, the data retreival functions will
automatically retreive the newest data.

# Usage of package

## Functions to access the data

This package provides functions for **read-only** acces to the data as
well as functions to check the integrity if the data. The functions are

  - `read_data()`
  - **<span style="color:red">more functions are needed depending on the
    type of the data and will be added later</span>**
  - …

# Import new data

Data can be imported from the folder

It can be set by using

The default is to a folder named **ToBeImported** in the current working
directory when the library is loaded.

This folder contains subfolder, which are equal to the name of the table
in the database where the results will be imported to. Details will
follow later.

![](README_files/figure-gfm/leef.import.activity-1.png)<!-- -->

# Infrastructure

## Configuration files of the infrastructure

### `config.yml`

In the `config.yml` file are all configuration options of the
infrastructure. The example one looks as follow:

``` r
default:
  maintainer:
    name: Max Mustermann
    email: Max@musterfabrik.example
  description: This is my fantastic repo
               with lots of data.

master:
  doi: FALSE
  tts: TRUE
  data:
    backend:
      mysql:
        Database: "[database name]"
        UID: "[user id]"
        PWD: "[pasword]"
        Port: 3306

LEEF:
  doi: TRUE
  tts: TRUE
  data:
    backend:
      sqlite:
        folder: inst/extdata
```

The top levels are different repo names (here `master` and `LEEF`) and
default values for all the repos (`default`).

It has the following keywords: - `default` contaiuns self-explanatory
values - `doi` if TRUE, will request DOI after successfull commit -
`tts` if TRUE, will request Trusted Time Stamp of repo after successfull
commit - `data` contains info about the data storage - `backend` the
name of the backend and connection info -
<span style="color:green">others to come</span>

This config file should be the same for all repos in a tree, but it is
not necessary.

### `CONFIG.NAME`

This file contains the name of the configuration for this repo. in this
example `master`. So by changiong the content of this file to `LEEF`,
this repo becomes a `LEEF` repo.

## Import of new data

Before new data can be imported, this repo needs to be forked. Once
forked, all user interaction takes place via this fork and pull requests
to this repo. This fork needs to be cloned to a local computer.

An import of new data follows the following steps:

1.  Create a new branch on the local fork and check it out.
2.  Add all new data files to the directory `inst/new_data/`. The data
    has to follow the following rules:
      - the data has to be in a common format, e.g. `.csv`
      - the name has to reflect the name of the table the data needs to
        be imported to
      - **<span style="color:red">metadata do be added in additional
        file?</span>**
      - **<span style="color:red">more?</span>**
3.  commit these changes to the local fork and push to github fork
4.  create pull request from this repo
5.  an automatic check of the package will be triggered using Travis-ci,
    which will test the data and not the units if the `inst/newdata`
    directory is not empty
6.  From now on in the `after_success section`
7.  after a succerssfull testhat test, the data will be imported and the
    database updated
8.  delete all imported files; if a file remains, raise error
9.  update version in DESCRIPTION
10. the main vignette will be updated with date and (hopefully)
    timestamp of the data
11. changes will be commited to repo with
12. quit

As soon as this repo receives a pull request, it initiates the import
via a Travis job. This importing is handled within the package
`LEEF.Processing` and can be seen in detail in the package
documantation.

For relevance here are two actions:

1.  `LEEF.Processing` does commit the imported data to this repository
    or to the external database.

# Package structure

The DAata package contains the code to

  - `check_existing_...()` to check the existing data
  - `check_new_...()` to check the incoming new data
  - `merge_...()` to merge the new data into the existing data
  - …

In addition, it contains the function

  - `existing_data_ok()` which is doing all checks on the existing data
  - `newData_ok()` which is doing all checks on the new data
  - `merge_all()` which is doing all the merging

and finally

  - `do_all()` which is doing everything in the order of
    1)  `check_existing_data()`
    2)  `check_new_data()`
    3)  `merge_all()`  
    4)  `existing_data_ok()`

![](README_files/figure-gfm/leef.processing.content-1.png)<!-- -->

## Activity Diagram of `import_new_data()` function

![](README_files/figure-gfm/leef.processing.activity-1.png)<!-- -->
