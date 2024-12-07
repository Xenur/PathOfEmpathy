# **Caminos de Empatía**
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
