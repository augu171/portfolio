¿Qué hacer luego de haber clonado el repo?

Cada carpeta es un proyecto creado en una o varias secciones del curso de flutter del profesor Fernando Herrera, y cada proyecto puede o no tener parte front y back. Nos concentraremos en la parte front.

¿Qué necesito tener instalado para poder correr mi app?

Como explica en las primeras secciones del curso se necesita tener instalado:
- Android Studio y luego crear al menos un dispositivo virtual.
- Visual Studio Code con extensiones de dart,flutter, terminal,etc que nos permitirán poder abrir y debuggear sin necesidad de abrir el Android Studio.
- Instalar flutter como se especifica en su web, podemos guiarnos tambien del curso en esta parte.
- Se debe controlar en el archivo build.gradle que nuestro dispositivo esté en el rango de versiones que admite el proyecto, la versión del dispositivo debe ser igual o mayor a las indicadas.

¿Qué necesito hacer para correr algún proyecto de este repositorio?

Para correr un proyecto en visual studio code debemos abrir la carpeta de modo que solo quede mostrando solo un proyecto y no todos los disponibles del repositorio, luego de estar en la carpeta del proyecto pulsamos ctrl+shift+p y escribimos flutter:select device , seleccionamos esta opción y luego algún dispositivo creado previamente en Android Studio, cuando este dispositivo se encienda del todo y se encuentre en el home, volvemos al visual studio code y buscamos en los archivos del proyecto la carpeta lib y en esta misma abrir el archivo main.dart, estando en main le damos al f5 y va a empezar a correr el proyecto en el dispositivo que seleccionamos con anterioridad.


