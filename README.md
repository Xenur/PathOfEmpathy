# **Caminos de Empatía**
11/12/2024
v.0.3.0.3-alpha
Estadísticas listas con el nuevo feedback (incluido puntos de empatía y gráfico).
Listo pantallas finalización.
Botón volver en seleccion rol
**** PROXIMO ****
Cheets en la obtención de tokens. +1 en el atributo que se defina segun el token
*FALTARÁ EL TUTORIAL*


10/12/2024
-Arreglado las cartas de siguiente situción que al girarlas se mostraba la carta en curso.
-Arreglado las estadísticas. Ahora incluyen datos de las estrellas.
-Modificado pantalla estadísticias, mostrando información relevante de las estrellas, así como
-solucionado el gráfico de mostrar partidas. Ahora tan solo están las jugadas y las abandonadas
-Arreglado gráfico dificultad
-Añadido dificultad al juego, cada nivel de dificultad aporta un multiplicador diferente, desde facil, medio, dificil.
-Así, las puntuaciones que son las que generan los threshold ocultos tendrán un multiplicador diferente
dependiendo del nivel de dificultad con el que se juegue.
-Añadido cuadro de subtitulos para las canciones. Cuando suena una nueva canción aparece un mensaje con el
nombre de la canción que se desvanece a los 5 segundos.
-Arreglado estrellas cuando no se seleccionan cartas.
-Añadido label a la parte superior/izquierda de la GUI que identifica el nivel de dificultad.
*****PRÓXIMO******

-Implantar cheet cuando se consigan los tokens mendiante los combos (idea principal mostrar durante n
segundos los atributos de las cartas o durante la siguiente tirada, para que conseguir tokens signifique
algo, ya que hasta ahora nos servia para la puntuación final, que ahora no tenemos).


09/12/2024
En la pantalla de selección de rol no me gusta que las cartas tengan borde negro (creo que debería quitarlo).
En  la pantalla de selección de rol cuando se elige un rol salta un audio (debería implementar que al clicar una vez salte). 
En la pantalla de selección de rol cuando eliges un rol se oscurecen los demás (creéis que está bien?)
Pantalla in-game
Stats de rol debo actualizarlo según el estado que elija el jugador.
Cuando se hace visible cuadro de dialogo (al clicar en aceptar o cuando se acaba el tiempo para elegir carta) NO se debería poder clicar en otros botones (como por ejemplo en el de opciones).
ARREGLADO -- En el cuadro de diálogo, si no se juega la carta de habilidad social no avisa de ello. -- 
ARREGLADO -- En el cuadro de diálogo, si se consigue una combinación perfecta de cartas no se muestra bien el campo “porqué”, se sale del cuadro de diálogos.
Si juegas todas las cartas, ¿¿¿por que solo hay 49????
TODO ESTADÍSTICAS DEBE CAMBIAR.
 
07/12/2024 2
* Prueba segundo commit con carpeta release y -gitignore listo

07/12/2024
* Cambio de github para tener correcto las releases
* Cambio a carlos.alcarazb@gmail.com
* Github.com/Xenur


21/11/2024
*	Implementado puntuacion con estrategias correctas
*	Se ha modificado el modal de endturnpopup para mostrar solo info del jugador y
*	nuevo layout para mostrar información de porqué es una combinación correcta.
*	Se otorgan 150 puntos por conseguir combinación
*	Se replantea sistema de combos. No serán seguidos
*	Falta implementar los combos (contador de combos) seran necesarios para cartas i+c y tokens
*	Se ha añadido select de IA en opciones. 
*	Se ha cambiado boton cancelar en popup opciones por restablecer que restablece a los valores predeterminados.
*	Se han añadido los marcos a las cartas
*	Se han añadido los dos avatares (IA, Player) para mostrar la puntuación global.



#19/11/2024
*	Implementado puntuación. totales en globaldata
*	falta mostrar en pantalla principal, ahora se muestra en el modal de fin de turno
*	falta guardar información para guardar partida y seguir más adelante
*	falta guardar información para las métricas. Puntuaciones, cartas utilizadas, tiempo utilizado para elegir las cartas 
	antes de pulsar en Listo
*	Tiempo de tirada largo (5 minutos para dar tiempo a elegir las cartas pensando y no hacerlo al tuntun)
*	Siguiente: mostrar puntuaciones, fin partida (por tiempo, por mostrar todas las cartas de bullying, por abandono)
*	Implementar modo estrategia, mostrando puntuaciones de los atributos de las cartas
*	Implementar diversas IAs


# 17/11/2024
## **Descripción**
Este es un juego de cartas estratégico en desarrollo. En esta versión inicial, se han implementado funcionalidades esenciales como el inicio de sesión, el registro de usuarios, la gestión de opciones, y una primera aproximación al flujo de juego.

---

## **Características Actuales**

### **1. Sistema de Usuario**
- **Inicio de Sesión:** Los usuarios registrados pueden acceder a sus cuentas.
- **Registro de Nuevos Usuarios:** Los nuevos usuarios pueden crear una cuenta para jugar.

### **2. Menú Principal**
- **Nueva Partida:** Inicia una nueva partida seleccionando entre dos modos de juego.
- **Opciones:**
  - Ajusta el volumen de música y efectos de sonido (SFX).
  - Activa o desactiva el antialiasing.
- **Créditos:** Muestrará información sobre el desarrollo.
- **Estadísticas (Prototipo):** Vista inicial de estadísticas del juego, mostrando detalles del jugador.
- **Salir:** Cierra el juego.

### **3. Selección de Modo de Juego**
Al seleccionar "Nueva Partida", se presentan dos modos de juego mediante imágenes representativas. Al elegir uno, se accede a una versión inicial del juego.

### **4. Funcionalidades del Juego**
- **Gestión de Cartas:**
  - **Mostrar cartas:** Visualiza las cartas disponibles.
  - **Barajar cartas:** Mezcla las cartas en el mazo.
  - **Agrandar cartas:** Visualiza una carta seleccionada en mayor detalle.
  - **Seleccionar cartas:** Elige cartas para el turno actual.
- **Proto IA:** Una inteligencia artificial inicial que elige sus cartas automáticamente.
- **Turno de Tirada:**
  - Muestra las cartas elegidas por el jugador y la IA.
  - Incluye botones para "Listo" y "Salir".
- **Cuenta Atrás del Turno:**
  - Cada turno tiene un límite de tiempo.
  - Cuando quedan 10 segundos, aparece una cuenta atrás en pantalla acompañada de un sonido de advertencia.

---

## **Cómo Jugar**
1. **Inicio:** Regístrate o inicia sesión en el juego.
2. **Menú Principal:** Explora las opciones y selecciona "Nueva Partida" para empezar.
3. **Modo de Juego:** Elige un modo y accede al tablero de juego.
4. **Turnos:**
   - Visualiza las cartas disponibles y elige las que usarás en el turno.
   - Presiona "Listo" para confirmar tu selección.
   - Si no seleccionas cartas antes de que acabe el tiempo, se seleccionarán automáticamente. Por ahora se seleccionará la carta -1.   

---

## **Desarrollador**
- **Carlos Alcaraz Benítez** - Desarrollo principal y diseño del juego.

---

## **Progreso del Desarrollo**
Este proyecto está en una etapa inicial de desarrollo. Las próximas versiones incluirán:
- Mejoras en la IA del oponente.
- Sistema avanzado de estadísticas, métricas para cumplir uno de los objetivos del proyecto.
- Flujo completo del juego con reglas detalladas y condiciones de victoria.

---

## **Instalación**
1. Descarga el juego desde el repositorio oficial.
2. Extrae los archivos y ejecuta el archivo principal.
3. ¡Regístrate o inicia sesión y comienza a jugar!

---

¡Gracias por jugar! 🚀
