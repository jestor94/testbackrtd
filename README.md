# Resuelve Tu deuda Backend Test

## Descripción
La siguiente prueba consiste en una propuesta de solución para la siguiente problemática plasmada en el siguiente [enlace.](https://github.com/resuelve/prueba-ing-backend/blob/master/README.md).

La intención de usar Phoenix server, con Elixir y Typescript, primera es, porque conozco que es su stack principal (Elixir). Además este lenguaje es muy poco común y yo tuve la oportunidad de trabajar con el por unos meses... Tuve que retomar casos de estudio para poder concluir la prueba usando esta tecnología.
Utilicé LiveView y hooks para tener el toque del tiempo real...

Para el framework visual, decidí utilizar Tailwind, es para no hacer una aplicación sencilla, muy pesada al cargar todos los componentes nativos, y mejor solo utilizar lo que se necesita, las clases básicas para armar grids, estilizar botones y componentes básicos, aprovechando la ventaja que tiene al integrar plugins de JS..


## Instalación
Para descargar y ejecutar este proyecto, primero es necesario instalar las siguientes dependencias en tu equipo

[Elixir](https://elixir-lang.org/install.html)
[Phoenix](https://hexdocs.pm/phoenix/installation.html)
[Node](https://nodejs.org/es/download/)

Recomiendo utilizar [NVM](https://github.com/nvm-sh/nvm) para un mejor control de versiones a futuro.

Después de clonar el proyecto, se tienen que ejecutar los siguientes comandos en la carpeta raíz del proyecto

  * Instalación de dependencies con `mix deps.get`
  * Instalación de dependencias de Node.js con `npm install` inside the `assets` directory (`cd assets`)
  * En carpeta raíz (`cd ..`) iniciamos Phoenix con `mix phx.server`

Si no hay ningún error ve a [`localhost:4000`](http://localhost:4000) en tu navegador.

Para ejecutar el proyecto en entorno productivo, [consulta la documentación aquí](https://hexdocs.pm/phoenix/deployment.html).

## Soporte y dudas
Si hay algo que haya redactado mal o no es posible ejecutar el proyecto por escribeme a mi [correo](mailto:jestorres10@gmail.com)

## Extras
También realicé el bonus de la prueba... :)