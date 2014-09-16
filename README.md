# Apuntes Ingeniería Informática - Matemáticas

### Compilación

Los apuntes necesitan los archivos en la carpeta `Cosas Guays LaTeX` para compilar (hay clases de documentos y algunos paquetes). Se pueden o bien instalar directamente en el sistem usando el script `install` del directorio o bien copiarlos al directorio del archivo `.tex` para que el compilador los reconozca.

Además, hay un script en la raíz `compilar.sh` que recorre todos los directorios compilando los PDFs, con capacidad de exportarlos a otras carpetas.

### Sugerencias de comandos (TeXstudio)

Para facilitar las cosas, hay un script `cwlmaker.py` que genera un archivo `.cwl` a partir de los comandos declarados en un fichero de LaTeX. Este archivo permite a [TeXstudio](http://texstudio.sourceforge.net/) dar sugerencias de los comandos que hemos creado.

### Inclusión de PDFs

Para que git meta en el control de código archivos PDF, hay que renombrarlos con una barra baja al principio, para denotar que son archivos auxiliares y no generados por LaTeX.

## Descarga

Puedes descargar los apuntes en PDF, actualizados diariamente, [aquí](https://www.dropbox.com/sh/kbymf37cykz77ha/AADuRd3CoU6UUCZMtK0GdEtPa?dl=0).

## Autores

* [Víctor de Juan Sanz](http://github.com/VicDeJuan)
* [Guillermo Julián Moreno](http://github.com/gjulianm)
* [Guillermo Ruiz Álvarez](http://github.com/rual93)
* [Pedro Valero Mejía](http://github.com/pevalme)

### Puñetas de LaTeX

* Hay que instalar prácticamente todos los paquetes de LaTeX. En Ubuntu, suele ser _texlive-latex-full_, y con cuidado de que instale los paquetes _imakeidx_ y alguno más, que a veces desaparece sin dejar rastro.
* Tal y como está hecho el comando `\makefirstuc`, que se usa en el entorno de definiciones, peta por todo lo alto cuando el primer carácter es una tilde. Por ejemplo, `\begin{defn}[Índice]` no funciona, con un error raro de UTF8. La solución es meter la primera letra entre llaves, así: `\begin{defn}[{Í}ndice]`. Ya, es raro, pero no hay otra.
* Cada vez que se cambian los paquetes hay que volver a instalarlos. Así que si por lo que sea dejan de compilar los apuntes con errores de comandos sin definir, vuelve a ejecutar el script de instalación (`Cosas guays LaTeX/install`) por si acaso.
