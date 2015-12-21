# Cómo funciona el script

Para cambiar la configuración del teclado lo único que debemos hacer es cambiar el archivo del sistema que describe el significado de cada tecla y de cada combinación de estas.

El script de [pull](pull.sh) lo único que hace es acceder al directorio donde se guardan estas configuraciones y copiar una de ellas directorio desde el que se invoca. Un ejemplo de uso de este script sería:

    $ ./pull.sh es

Y nos permite acceder cómodamente al archivo que describe la configuración en Español del teclado (que probablemente sea la que estamos usando).

Una vez tenemos este fichero, al abrirlo, veremos algo como:

```
// Spanish mapping (note R-H exchange)
partial alphanumeric_keys
xkb_symbols "dvorak" {

    name[Group1]="Spanish (Dvorak)";

    key <TLDE> {[  masculine, ordfeminine, backslash, degree		]};
    key <AE01> {[          1, exclam, bar, onesuperior			]};
    key <AE02> {[          2, quotedbl, at, twosuperior			]};
    key <AE03> {[          3, periodcentered, numbersign, threesuperior	]};
    key <AE04> {[          4, dollar, asciitilde, onequarter		]};
    key <AE05> {[          5, percent, brokenbar, fiveeighths		]};
    key <AE06> {[          6, ampersand, notsign, threequarters		]};
    key <AE07> {[          7, slash, onehalf, seveneighths		]};
    key <AE08> {[          8, parenleft, oneeighth, threeeighths	]};
    key <AE09> {[          9, parenright, asciicircum			]};
    key <AE10> {[          0, equal, grave, dead_doubleacute		]};
    key <AE11> {[ apostrophe, question, dead_macron, dead_ogonek	]};
    key <AE12> {[ exclamdown, questiondown, dead_breve, dead_abovedot	]};

    key <AD01> {[     period, colon, less				]};
    key <AD02> {[      comma, semicolon, greater			]};
    key <AD03> {[     ntilde, Ntilde, lstroke, Lstroke			]};
    key <AD04> {[          p, P, paragraph				]};
    key <AD05> {[          y, Y, yen					]};
    key <AD06> {[          f, F, tslash, Tslash				]};
    key <AD07> {[          g, G, dstroke, Dstroke			]};
    key <AD08> {[          c, C, cent, copyright			]};
    key <AD09> {[          h, H, hstroke, Hstroke			]};
    key <AD10> {[          l, L, sterling				]};
    key <AD11> {[ dead_grave, dead_circumflex, bracketleft, dead_caron	]};
    key <AD12> {[       plus, asterisk, bracketright, plusminus		]};

```

Donde cada línea describe el funcionamiento de una tecla de la forma. Así, por ejemplo, podemos ver que, relacionado con la tecla c tenemos las siguientes combinaciones de telcas:

* Tecla c = c
* Tecla c + shift = C
* Tecla c + AltGr = símbolo de centabo
* Tecla c + AltGr + Shift = símbolo de copyright

Para tener un acceso rápido e intuitivo a las letras del alfabeto griego, lo que debemos hacer es sustituir los dos últimos elementos de cada array representado por lo que queremos que haga esa combinación de teclas.

La forma de indicar que el resultado de la combinación de teclas dadas debe ser una letra griega es mediante el empleo de la instrucción Greek_(nombre de la letra) y Greek_(NOMBRE DE LA LETRA) para mayúsculas y minúsculas respectivamente.

Un ejemplo del resultado sería:

```
key <AC01> {	[	  a,	A,    Greek_alpha,   Greek_ALPHA ]	};
key <AC02> {	[	  s,	S,    Greek_sigma,   Greek_SIGMA ]	};
key <AC03> {	[	  d,	D,    Greek_delta,   Greek_DELTA ]	};
```

Una vez hemos modificado nuestro fichero, lo que debemos hacer es devolverlo a su sitio e indicar al ordenador que se actualice de acuerdo a la nueva información.

Para ello empleamos el script de [push](push.sh) que se ejecuta de la forma:

    $ ./push.sh es

Este script volverá a copiar el archivo *es* al directorio del sistema de que se obtuvo pero con un nombre diferente (evitando así el borrado del original) y causa la actualización de la configuración del teclado respecto a esta nueva configuración.

Para ejecutar este script es necesario tener permisos de super usuario.