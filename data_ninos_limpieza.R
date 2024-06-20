# Instalar y cargar los paquetes necesarios
library(tidyverse)
library(rio)

resultados<-read_excel("datos_ninos.xlsx", sheet="resultados")
censo<-read_excel("datos_ninos.xlsx", sheet="censo-oficial")

str(resultados)
str(censo)

resultados <- resultados %>%
  mutate(peso = ifelse(peso > 100, peso / 10, peso))

resultados <- resultados %>%
  mutate(
    peso = ifelse(is.na(peso), mean(peso, na.rm = TRUE), peso),
    talla = ifelse(is.na(talla), mean(talla, na.rm = TRUE), talla),
    parasitos = ifelse(is.na(parasitos), 0, parasitos)
  )
head(resultados,30)

tabla_principal <- merge(resultados, censo, by = "dni", suffixes = c("_resultados", "_censo"))


