dataregacc
================

This is a personal data package that consolidates all the regional
accounts tables (14) published by Eurostat. You can check them here
(<https://ec.europa.eu/eurostat/web/main/data/database>).

# Install

``` r
remotes::install_github("Luisbia/dataregacc")
```

# Structure of the data set

The dataset becomes available typing `regacc`. The class of the dataset
is a `data.frame` and a `data.table`. It has approximately 3.5 million
rows and 12 columns.

-   **table:** a similar but shorter name than the one used by Eurostat
    (2gdp instead of nama\_10\_2gdp)

-   **country:** the country code.

-   **NUTS:** the NUTS level code (0 = country, 1 = NUTS 1, 2 = NUTS 2,
    3 = NUTS 3). NUTS 3 is available only in three tables.

-   **geo:** the region code according to the NUTS 2021 classification.

-   **label:** the label of the region.

-   **na\_item:** the variable name which normally correspond to the ESA
    code (B1GQ for GDP). In case of doubt (RLPR\_PER stands for Real
    Labour Productivity per person) consult the original dataset.

-   **nace\_r2:** refers to the classification of economic activities
    (NACE). In some tables is available by 10 economic activities. When
    it is not relevant (for example for population) it is filled with Z.

-   **acc:** stands for account and it is mainly needed for Household
    Accounts. For most variables I set it to BAL.

-   **unit:** the unit measure (PS = persons, HW = hours, MIO\_EUR =
    Millions of Euros and so on.)

-   **time:** there is only annual data so it corresponds to the year.

-   **values:** no need to describe (I think).

-   **flags:** for some observations they are relevant (D: definition
    differs, B: breaks). In most cases, they are empty and there are a
    few P: provisional and E: estimate. I only consider relevant D’s and
    B’s. P’s and (most of the time) E’s are more a country practice than
    a real difference.

# What can I do?

A simple example is to compare D.1 (Compensation of employees) reported
in table 2coe (where it is paid or the location of the company) and D.1
reported in table 2hh (where the worker lives).

``` r
library(dataregacc)
library(tidyverse)

  top_commuting<- regacc %>% 
  filter (na_item =="D1" & 
          nace_r2 %in% c("TOTAL","Z") &
          time == 2019 &
          NUTS == 2 &
          unit =="MIO_NAC" &
          label !="Extra-regio") %>% 
  select(country,geo,label,table,values) %>% 
  mutate(table=str_remove(table,"2")) %>% 
  pivot_wider(names_from = table,
              values_from = values) %>% 
  mutate(comm = round(coe*100/hh,1)) %>% 
  arrange(desc(comm)) %>% 
  head(10)
  
knitr::kable(top_commuting)
```

| country | geo  | label                                                         |        coe |         hh |  comm |
|:--------|:-----|:--------------------------------------------------------------|-----------:|-----------:|------:|
| BE      | BE10 | Région de Bruxelles Capitale / Brussels Hoofdstedelijk Gewest |   43504.30 |   23456.40 | 185.5 |
| CZ      | CZ01 | Praha                                                         |  667992.00 |  402470.00 | 166.0 |
| HU      | HU11 | Budapest                                                      | 7475627.00 | 4834576.00 | 154.6 |
| LU      | LU00 | Luxembourg                                                    |   31248.07 |   20443.00 | 152.9 |
| DE      | DE60 | Hamburg                                                       |   62913.92 |   44875.24 | 140.2 |
| DE      | DE50 | Bremen                                                        |   18956.98 |   13660.26 | 138.8 |
| EL      | EL42 | Notio Aigaio                                                  |    2383.74 |    1751.46 | 136.1 |
| AT      | AT13 | Wien                                                          |   50738.00 |   39596.00 | 128.1 |
| PL      | PL91 | Warszawski stoleczny                                          |  161887.00 |  138084.00 | 117.2 |
| NL      | NL32 | Noord Holland                                                 |   81767.00 |   70059.00 | 116.7 |

We can see that 85% of the D.1 of Brussels is paid to workers not living
in Brussels (which btw explains its high GDP per capita).
