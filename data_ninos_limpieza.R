# Instalar y cargar los paquetes necesarios
library(tidyverse)
library(rio)
library(dplyr)
library(writexl)

resultados<-read_excel("datos_ninos.xlsx", sheet="resultados")
censo<-read_excel("datos_ninos.xlsx", sheet="censo-oficial")

str(resultados)
str(censo)

resultados_limpio <- resultados %>%
  filter(
    !is.na(hemoglobina) & hemoglobina >= 9 & hemoglobina <= 17,
    !is.na(talla) & talla >= 1.10 & talla <= 1.50,
    !is.na(peso) & peso >= 28 & peso <= 55,
    !is.na(parasitos)
  )
resultados_limpio

resultados <- resultados %>%
  mutate(peso = ifelse(peso > 100, peso / 10, peso))

resultados <- resultados %>%
  mutate(
    peso = ifelse(is.na(peso), mean(peso, na.rm = TRUE), peso),
    talla = ifelse(is.na(talla), mean(talla, na.rm = TRUE), talla),
    parasitos = ifelse(is.na(parasitos), 0, parasitos)
  )
head(resultados)
write_xlsx(resultados, "resultados_limpios.xlsx")

tabla_principal <- merge(resultados, censo, by = "dni", suffixes = c("_resultados", "_censo"))
write_xlsx(tabla_principal, "tabla_principal.xlsx")

