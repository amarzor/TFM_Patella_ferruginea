# Conectividad poblacional del gasterópodo amenazado Patella ferruginea en el Mediterráneo occidental

Este repositorio contiene los scripts, archivos de configuración y registros de ejecución utilizados para el procesamiento bioinformático y el análisis de genómica poblacional del proyecto. El conjunto de datos final consta de 24 individuos (tras la exclusión de una muestra deficiente durante los pasos iniciales de control de calidad) procedentes de cinco regiones geográficas.

El flujo de trabajo se divide en dos fases principales: el ensamblaje *de novo* y filtrado de polimorfismos de nucleótido simple (SNPs) mediante `ipyrad`, y el análisis de estructura poblacional espacial utilizando `R`.

## Descripción de los archivos

A continuación se detalla la función de cada uno de los cuatro archivos principales de este directorio:

* **`params-Pf_24_def.txt`**
  * **Descripción:** Es el archivo de configuración (*parameters file*) principal utilizado por el software `ipyrad`. 
  * **Función:** Contiene todos los parámetros específicos definidos para el ensamblaje *de novo* y el filtrado estricto de las secuencias. Incluye configuraciones clave como el nivel de similitud para el *clustering*, la profundidad mínima de lectura y, de manera crítica, el filtro de presencia mínima entre muestras (`min_samples_locus`) establecido para retener únicamente los loci presentes en al menos el 50% de los 24 individuos finales.

* **`Análisis_ipyrad.sh`**
  * **Descripción:** Script de terminal (Shell/Bash) diseñado para ejecutar el pipeline de `ipyrad`.
  * **Función:** Contiene los comandos de consola necesarios para lanzar los pasos del 1 al 7 del procesamiento (demultiplexación, edición, clustering intra e inter-muestra, y filtrado final).

* **`Pf_24_def.json`**
  * **Descripción:** Archivo de metadatos y registro de estadísticas generado automáticamente por `ipyrad` al finalizar el ensamblaje.
  * **Función:** Almacena en formato JSON (JavaScript Object Notation) toda la información del rendimiento del ensamblaje para el conjunto de las 24 muestras. Incluye datos métricos fundamentales como el total de lecturas brutas (*reads_raw*), la tasa de error estimada, la heterocigosidad, y el tamaño final de la matriz de SNPs (118.496 SNPs) y de secuencias. Es el archivo del que se extraen las tablas de resumen de calidad.

* **`Analisis Poblacional.Rmd`**
  * **Descripción:** Un cuaderno interactivo de R Markdown que contiene todo el código utilizado para los análisis posteriores.
  * **Función:** Este script importa las matrices de SNPs generadas por `ipyrad` y ejecuta los análisis genéticos. Incluye el código documentado para calcular índices de diversidad genética, generar las matrices de diferenciación por pares y construir los gráficos del Análisis de Componentes Principales (PCA)..

---

### Notas de uso
Para reproducir el análisis desde cero, se debe ejecutar primero el script `Análisis_ipyrad.sh` (asegurándose de que los archivos `.fastq` de secuenciación bruta estén en el directorio correcto especificado en el archivo `params`). Una vez generados los archivos de salida (ej. formato `.vcf`), se puede abrir y ejecutar por bloques el documento `Analisis Poblacional.Rmd` utilizando RStudio.
