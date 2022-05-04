#Extract economics data from Brazilian's Central Bank


library(tidyverse)
library(rbcb)
library(radiant)

##extracting economic time series from SGS
download_series <- function(){
  
  ipca <- rbcb::get_series(433, start_date = '2008-01-01')
  pib <- rbcb::get_series(4380, start_date = '2008-01-01')
  desocupacao <- rbcb::get_series(24369, start_date = '2008-01-01')
  selic <- rbcb::get_series(4390, start_date = '2008-01-01')
  icei_geral <- rbcb::get_series(7341, start_date = '2008-01-01')
  icei_atual <- rbcb::get_series(7342, start_date = '2008-01-01')
  icei_expectativas <- rbcb::get_series(7343, start_date = '2008-01-01')
  incc <- rbcb::get_series(192, start_date = '2008-01-01')
  ivg_r <- rbcb::get_series(21340, start_date = '2008-01-01')
  igp_m <- rbcb::get_series(189, start_date = '2008-01-01')
  
   dplyr::full_join(ipca, pib) %>% 
     dplyr::full_join(desocupacao) %>%
     dplyr::full_join(selic) %>% 
     dplyr::full_join(icei_geral) %>% 
     dplyr::full_join(icei_atual) %>% 
     dplyr::full_join(icei_expectativas) %>% 
     dplyr::full_join(incc) %>% 
     dplyr::full_join(ivg_r) %>% 
     dplyr::full_join(igp_m) 
  
}

## reunindo os dados extraidos em uma tabela
economic_indices <- download_series() %>% 
  dplyr::filter(date <  '2022-04-01') %>% 
  dplyr::select(date, 'ipca (%)' = '433', 'pib' = '4380', 'desocupacao (%)' = '24369',
                'selic (%)' = '4390', 'icei_geral (%)' = '7341', 
                'icei_atual (%)' = '7342', 'icei_expectativas (%)' = '7343',
                'incc (%)' = '192', 'ivg_r (%)' = '21340', 'igp_m (%)' = '189')


##transforma a tabela em um dataframe
economic_indices <- data.frame(economic_indices)

