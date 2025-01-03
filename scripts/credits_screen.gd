# ===============================
# Nombre del Script: CredisScreen.gd
# Desarrollador: Carlos Alcaraz Benítez
# Fecha de Creación: 06 de Noviembre de 2024
# Descripción: Este script maneja la lógica de la pantalla de Créditos
# Se muestra texto con movimiento creado con nodo animationplayer
# Pulsar tecla Esc para salir
# ===============================
# Listado de funciones
# 
#	_ready(): Cargar configuración juego al iniciar
#	_on_animation_player_animation_finished(): Señal de finalización de la animación
#	_unhandled_input(event): Señal de tecla escape presionada
# ===============================

extends Control

# Referencias a los nodos de la escena

@onready var audio_stream_player = $AudioStreamPlayer
@onready var animation_player = $AnimationPlayer

func _ready():
	# Utiliza la variable global GameConfig donde se jugardan los datos de configuración del juego 
	# como en este caso los volúmenes.
	var volume_db = lerp(-80, 0, GameConfig.music_volume / 100.0)
	audio_stream_player.volume_db = volume_db
	#print("velocidad: " +str(animation_player.get_playing_speed()))
	#Ejecuta la animación a la mitad de velocidad. Ajusta la velocidad para mostrar la animación
	_rich()
	animation_player.play("credits_scroll", 0, 1)
	

	
# Señal de finalización de la animación
func _on_animation_player_animation_finished():
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")

#Señal de tecla escape presionada
func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")


func _rich():
	# Referencia al RichTextLabel en la escena

	var label = $RichTextLabel



	# Texto con formato BBCode
	label.bbcode_text = """
	[center][b][color=#ffffff]¡GRACIAS POR JUGAR A CAMINOS DE EMPATÍA![/color][/b][/center]
	
	[center][color=white][b]Desarrollo Concepto[/b][/color][/center]
	[center][color=#bfbfbf]Carlos Alcaraz Benítez[/color][/center]
	
	[center][color=white][b]Programación y Desarrollo[/b][/color][/center]
	[center][color=#bfbfbf]Carlos Alcaraz Benítez[/color][/center]

	[center][color=white][b]Tests QA[/b][/color][/center]
	[center][color=#bfbfbf]José Luis Ocaña[/color][/center]
	[center][color=#bfbfbf]Raúl Camacho[/color][/center]
		
	[center][color=white][b]Escritura y Narrativa[/b][/color][/center]
	[center][color=#bfbfbf]Carlos Alcaraz Benítez[/color][/center]
	   
	[center][color=white][b]Arte y Diseño Gráfico[/b][/color][/center]
	[center][color=#bfbfbf]Ilustraciones generadas con DALL·E de OpenAI[/color][/center]
	[center][color=#bfbfbf]Animaciones generadas con Runway Gen-3 Alpha[/color][/center]
	[center][color=#bfbfbf]"Marcos" por cardconjurer.com - descargado de cardconjurer.com[/color][/center]
	[center][color=white]Iconos[/color][/center]
	[center][color=#bfbfbf]"Icono Comunicación" por Vectors Market - descargado de flaticon.es[/color][/center]	
	[center][color=#bfbfbf]"Icono Discriminación" por Freepik - descargado de flaticon.es[/color][/center]			
	[center][color=#bfbfbf]"Icono Empatía" por Freepik - descargado de flaticon.es[/color][/center]	
	[center][color=#bfbfbf]"Icono Inteligencia Emocional" por gravisio - descargado de flaticon.es[/color][/center]	
	[center][color=#bfbfbf]"Icono Resolución de Conflictos" por syafii5758 - descargado de flaticon.es[/color][/center]		
	
	[center][color=white][b]Música y Sonido[/b][/color][/center]
	[center][color=#bfbfbf]"Música" generada con Suno AI[/color][/center]			
	[center][color=#bfbfbf]"Beep cuenta atrás" por Thompson Man - descargado de freesound.org[/color][/center]	
	[center][color=#bfbfbf]"Braam aggressive tech blast" por Submority - descargado de freesound.org[/color][/center]	
	[center][color=#bfbfbf]"Click" - descargado de freesound.org[/color][/center]			
	[center][color=#bfbfbf]"Clic menú" por Leszek Szary - descargado de freesound.org[/color][/center]			
	[center][color=#bfbfbf]"Hit low" por Submority - descargado de pixabay.com[/color][/center]			
	[center][color=#bfbfbf]"Mega horn" por Submority - descargado de freesound.org[/color][/center]			
	[center][color=#bfbfbf]"Voces" generadas con Vidnoz[/color][/center]
	[center][color=#bfbfbf]"Whoosh hit" por Submority - descargado de pixabay.com[/color][/center]
	
	[center][color=white][b]Tipografías[/b][/color][/center]
	[center][color=#bfbfbf]"Amatic SC" - Disponible en Google Fonts bajo licencia OFL[/color][/center]
	[center][color=#bfbfbf]"Roboto" - Disponible en Google Fonts bajo licencia Apache License, Version 2.0[/color][/center]
	
	[center][color=white][b]Herramientas y recursos[/b][/color][/center]
	[center][color=#bfbfbf]Audacity[/color][/center]
	[center][color=#bfbfbf]DALL·E[/color][/center]
	[center][color=#bfbfbf]GIMP[/color][/center]
	[center][color=#bfbfbf]Godot 4.3[/color][/center]
	[center][color=#bfbfbf]Jira[/color][/center]
	[center][color=#bfbfbf]remove.bg[/color][/center]
	[center][color=#bfbfbf]Runway Gen-3 Alpha[/color][/center]
	[center][color=#bfbfbf]Shotcut[/color][/center]
	
	
	
	
	
	[center][color=white][b]Agradecimientos Especiales[/b][/color][/center]
	[center][color=#bfbfbf]Quiero expresar mi más sincero agradecimiento a[/color][/center] 
	[center][color=#bfbfbf]José Luis Ocaña y Raúl Camacho, quienes han sido fundamentales en el[/color][/center] 
	[center][color=#bfbfbf]desarrollo de este proyecto. Su apoyo constante en el diseño del juego,[/color][/center] 
	[center][color=#bfbfbf]aportando ideas valiosas sobre cómo estructurarlo y mejorarlo, ha sido[/color][/center]
	[center][color=#bfbfbf]indispensable. Además, su disposición para probar el juego y proporcionar[/color][/center]
	[center][color=#bfbfbf]un feedback constructivo ha contribuido significativamente a perfeccionar[/color][/center]
	[center][color=#bfbfbf]tanto la jugabilidad como la experiencia final.[/color][/center]
	[center][color=#bfbfbf]Mi gratitud también para Guillermo, mi tutor, por guiarme a lo largo de todo[/color][/center]
	[center][color=#bfbfbf]el proceso. Su feedback constante, sus ideas para mejorar y su insistencia[/color][/center]
	[center][color=#bfbfbf]en que iterara sobre el proyecto me permitieron alcanzar un mayor nivel de[/color][/center]
	[center][color=#bfbfbf]excelencia. Gracias por hacerme consciente del potencial de mi trabajo,[/color][/center]
	[center][color=#bfbfbf]por ayudarme a identificar lo que funciona y lo que necesita ajustes, y[/color][/center]
	[center][color=#bfbfbf]por motivarme a reflexionar sobre el proyecto.[/color][/center]
	[center][color=#bfbfbf]Por último, a mi familia. A mi hija Nora, por ser la inspiración detrás[/color][/center]
	[center][color=#bfbfbf]de este proyecto; a mi mujer Isa, por su paciencia infinita y su apoyo[/color][/center]
	[center][color=#bfbfbf]incondicional; y a mis padres Tomas y Petry, por estar siempre ahí,[/color][/center]
	[center][color=#bfbfbf]escuchando y alentándome cada día. Gracias por ser mi motor y mi mayor fuente de fuerza.[/color][/center]
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	[center][color=red][i]¡Gracias a todos por todo![/i][/color][/center]
	
	
	[center][color=#bfbfbf]Carlos Alcaraz Benitez[/color][/center]
	[center][color=#bfbfbf]TFG-VIDEOJUEGOS 2025[/color][/center]


	"""
