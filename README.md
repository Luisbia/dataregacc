# dataregacc

This is a personal data package that consolidates all the regional accounts tables (14) published by Eurostat. You can check them here (<https://ec.europa.eu/eurostat/web/main/data/database>).

# Install

```{r}
remotes::install_github("Luisbia/dataregacc")
```

# Structure of the data set

The dataset becomes available typing `regacc`. The class of the dataset is a `data.frame` and a `data.table`. It has approximately 3.5 million rows and 12 columns. 

- **table:** a similar but shorter name than the one used by Eurostat (2gdp instead of nama_10_2gdp)

- **country:** the country code.

- **NUTS:** the NUTS level code (0 = country, 1 = NUTS 1, 2 = NUTS 2, 3 = NUTS 3). NUTS 3 is available only in three tables.

- **geo:** the region code according to the NUTS 2021 classification.

- **label:** the label of the region.

- **na_item:** the variable name which normally correspond to the ESA code (B1GQ for GDP). In case of doubt  (RLPR_PER stands for Real Labour Productivity per person) consult the original dataset.

- **nace_r2:** refers to the classification of economic activities (NACE). In some tables is available by 10 economic activities. When it is not relevant (for example for population) it is filled with Z.

- **acc:** stands for account and it is mainly needed for Household Accounts. For most variables I set it to BAL.

- **unit:** the unit measure (PS = persons, HW = hours, MIO_EUR = Millions of Euros and so on.)

- **time:** there is only annual data so it corresponds to the year.

- **values:** no need to describe (I think).

- **flags:** for some observations they are relevant (D: definition differs, B: breaks). In most cases, they are empty and there are a few P: provisional and E: estimate. I only consider relevant D's and B's. P's and (most of the time) E's are more a country practice than a real difference. 

# What can I do?

A simple example is to compare D.1 (Compensation of employees) reported in table 2coe (where it is paid or the location of the company) and D.1 reported in table 2hh (where the worker lives).


```r
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

top_commuting

