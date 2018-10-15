R Notebook
================

``` r
#load the participant data
library(ggplot2)
library(dplyr)
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
library(knitr)
library(reshape2)
library(googlesheets)
source('../Scripts/paper-prepare.R')
settings <- load_google_sheets()
```

    ## Sheet successfully identified: "TW-GoalOrder"

    ## Accessing worksheet titled 'Walking'.

    ## Parsed with column specification:
    ## cols(
    ##   `Version-1` = col_integer(),
    ##   `Version-2` = col_integer(),
    ##   `Version-3` = col_integer(),
    ##   `Version-4` = col_integer(),
    ##   `Version-5` = col_integer(),
    ##   `Version-6` = col_integer(),
    ##   `Version-3a` = col_integer(),
    ##   `Version-1a` = col_integer()
    ## )

    ## Accessing worksheet titled 'Viewpoint'.

    ## Parsed with column specification:
    ## cols(
    ##   `Version-1` = col_integer(),
    ##   `Version-2` = col_integer(),
    ##   `Version-3` = col_integer(),
    ##   `Version-4` = col_integer(),
    ##   `Version-5` = col_integer(),
    ##   `Version-6` = col_integer()
    ## )

    ## Accessing worksheet titled 'Pointing'.

    ## Parsed with column specification:
    ## cols(
    ##   `Version-1` = col_integer(),
    ##   `Version-2` = col_integer(),
    ##   `Version-3` = col_integer(),
    ##   `Version-4` = col_integer(),
    ##   `Version-5` = col_integer(),
    ##   `Version-6` = col_integer()
    ## )

    ## Sheet successfully identified: "TW-Participants"

    ## Accessing worksheet titled 'Settings'.

    ## Parsed with column specification:
    ## cols(
    ##   Code = col_character(),
    ##   First.phase = col_character(),
    ##   Second.phase = col_character(),
    ##   Walking1 = col_character(),
    ##   Viewpoint1 = col_character(),
    ##   Pointing1 = col_character(),
    ##   Walking2 = col_character(),
    ##   Viewpoint2 = col_character(),
    ##   Pointing2 = col_character(),
    ##   Training = col_character(),
    ##   WalkTimestamp1 = col_character(),
    ##   SOPTimestamp1 = col_character(),
    ##   WalkTimestamp2 = col_character(),
    ##   SOPTimestamp2 = col_character(),
    ##   finished = col_character(),
    ##   is_ok = col_character(),
    ##   is_OK_pre = col_character(),
    ##   notes = col_character(),
    ##   who = col_character()
    ## )

    ## Sheet successfully identified: "TW-BuildingPositions"

    ## Accessing worksheet titled 'GoalPositions'.

    ## Parsed with column specification:
    ## cols(
    ##   Name = col_character(),
    ##   Estimote.x = col_double(),
    ##   Estimote.y = col_double(),
    ##   Unity.x = col_double(),
    ##   Unity.y = col_double()
    ## )

    ## Accessing worksheet titled 'AllDoors'.

    ## Parsed with column specification:
    ## cols(
    ##   Door = col_character(),
    ##   Estimote.x = col_double(),
    ##   Estimote.y = col_double(),
    ##   Unity.x = col_double(),
    ##   Unity.y = col_double(),
    ##   Scaled.x = col_double(),
    ##   Scaled.y = col_double()
    ## )

    ## Sheet successfully identified: "TW questionnaire (Responses)"

    ## Accessing worksheet titled 'Form Responses 1'.

    ## Parsed with column specification:
    ## cols(
    ##   .default = col_character(),
    ##   `What is your age (years)?` = col_integer(),
    ##   `What is your weight (lbs.)?` = col_double(),
    ##   `How many hours did you sleep last night?` = col_double(),
    ##   `Approximately how long ago did you eat (hours)?` = col_double(),
    ##   `How would you rate your level of exposure to/experience with video games?` = col_integer(),
    ##   `How would you rate your level of stress currently` = col_integer()
    ## )

    ## See spec(...) for full column specifications.

    ## Sheet successfully identified: "TW-Participants"

    ## Accessing worksheet titled 'Overview'.

    ## Parsed with column specification:
    ## cols(
    ##   Code = col_character(),
    ##   First.phase = col_character(),
    ##   Second.phase = col_character(),
    ##   First.settings = col_integer(),
    ##   Second.settings = col_integer(),
    ##   date = col_character(),
    ##   Arrived = col_character(),
    ##   Training.started = col_time(format = ""),
    ##   Training.finished = col_character(),
    ##   Phase1.started = col_character(),
    ##   Phase1.finished = col_character(),
    ##   Phase2.started = col_time(format = ""),
    ##   Phase2.finished = col_time(format = ""),
    ##   finished = col_character(),
    ##   notes = col_character()
    ## )

``` r
df_participants <- settings$participants
df_participants <- df_participants %>% mutate(condition=paste0(First.phase,"-",Second.phase))
df_participants <- df_participants %>% filter(condition %in% c("vr-real", "real-real", "ve-real"))
overview <- settings$versions
overview <- overview %>% mutate(condition=paste0(First.phase,"-",Second.phase))
overview <- overview %>% filter(condition %in% c("vr-real", "real-real", "ve-real"))
```

Dropout ratings
---------------

``` r
finished <- overview %>% group_by(condition) %>% count(finished)
finished <- dcast(finished, condition~finished)
```

    ## Using n as value column: use value.var to override.

``` r
finished$percent <- round(finished$yes/(finished$yes+finished$no), 2)
kable(finished)
```

| condition |   no|  yes|  percent|
|:----------|----:|----:|--------:|
| real-real |    1|   23|     0.96|
| ve-real   |    2|   20|     0.91|
| vr-real   |   15|   21|     0.58|

``` r
is_ok <- overview %>% filter(finished=="yes") %>% group_by(condition) %>% count(is_ok)
is_ok <- dcast(is_ok, condition~is_ok)
```

    ## Using n as value column: use value.var to override.

``` r
is_ok$percent <- round(is_ok$yes/(is_ok$yes+is_ok$no), 2)
kable(is_ok)
```

| condition    |     no|     yes|                                                                                         percent|
|:-------------|------:|-------:|-----------------------------------------------------------------------------------------------:|
| real-real    |      1|      22|                                                                                            0.96|
| ve-real      |      1|      19|                                                                                            0.95|
| vr-real      |      1|      20|                                                                                            0.95|
| A total of 1 |  8 par|  ticipa|  nts didn't finish due to motion sickness, with about 50% not finishing the VR to VR condition.|

Female/male
-----------

Report
======

A total of 82 (M = 20.2, SD = 2) undergraduate students at UC Davis particiapted in the study in exchange for a study credit. Each students was randomly assigned a condition and a randomised set of goals. 18 participants didn't finish due to motion sickness and 3 were removed due to a technical failure of the real world tracking systen. Only 58 percent the students being able to finish VR to Real world condition.

Descriptives for the VR/real/desktop - time and path traveled
-------------------------------------------------------------

``` r
kable(walk_all %>% group_by(type, exp_block_id) %>% summarize(mean_dist = mean(distance, na.rm=T), mean_time = mean(time, na.rm=T)))
```

| type |  exp\_block\_id|  mean\_dist|  mean\_time|
|:-----|---------------:|-----------:|-----------:|
| real |               1|    51.72668|    70.03837|
| real |               2|    39.07152|    55.43358|
| real |               3|    28.96494|    34.56142|
| real |               4|    32.27909|    44.51001|
| real |               5|    29.20236|    34.35792|
| real |               6|    26.06957|    28.88117|
| ve   |               1|    64.53015|    90.36540|
| ve   |               2|    50.41029|    58.72601|
| ve   |               3|    32.67206|    35.04767|
| vr   |               1|    64.33447|   133.18176|
| vr   |               2|    50.07224|    89.09526|
| vr   |               3|    38.19759|    62.90698|
| vr   |               4|    31.18000|    48.93413|
| vr   |               5|    28.95835|    40.06223|
| vr   |               6|    24.13934|    33.32056|
