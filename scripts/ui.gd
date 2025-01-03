# ===============================
# Nombre del Script: ui.gd
# Desarrollador: Carlos Alcaraz Benítez
# Fecha de Creación: 07 de Noviembre de 2024
# Descripción: Este script maneja la lógica de la ui de la partida
# Por ahora boton opciones (superior izquierda). Habilitado para salir.
# ===============================
# Listado de funciones
#	_on_options_texture_button_pressed(): Señal boton presionado en opciones
# ===============================

extends Control

# Referencias a los nodos de la escena
@onready var ready_texture_button = $ReadyTextureButton
@onready var reverse_anverse_toggle_button = $ReverseAnverseToggleButton

@onready var ia_name_label = $ScoreTokenIA/IANameLabel

@onready var player_name_label = $ScoreTokenPlayer/PlayerNameLabel
@onready var blur_overlay = $Overlay/BlurOverlay


@onready var ia_texture_rect = $ScoreTokenIA/IATextureRect

@onready var game_over = $GameOver
@onready var new_game = $".."



@onready var audio_stream_player = $AudioStreamPlayer
@onready var beep_audio_stream_player = $BeepAudioStreamPlayer

@onready var player_texture_rect = $ScoreTokenPlayer/ShowScorePlayer/PlayerTextureRect

@onready var dificultad_label = $Dificultad/Panel/DificultadLabel

@onready var trait_1_texture_rect = $Control/Trait1Panel/Trait1TextureRect
@onready var trait_1_label = $Control/Trait1Panel/Trait1Label
@onready var trait_2_texture_rect = $Control/Trait2Panel/Trait2TextureRect
@onready var trait_2_label = $Control/Trait2Panel/Trait2Label
@onready var trait_3_texture_rect = $Control/Trait3Panel/Trait3TextureRect
@onready var trait_3_label = $Control/Trait3Panel/Trait3Label
@onready var trait_4_texture_rect = $Control/Trait4Panel/Trait4TextureRect
@onready var trait_4_label = $Control/Trait4Panel/Trait4Label

@onready var trait_5_texture_rect = $Control/Trait5Panel/Trait5TextureRect
@onready var trait_5_label = $Control/Trait5Panel/Trait5Label
@onready var fade_timer = Timer.new()  # Crea un temporizador
var fade_duration = 1.0  # Duración del desvanecimiento en segundos
@onready var songs_label = $SongsLabel




# Definimos la señal personalizada
signal reverse_anverse_toggled(showing_reverses: bool)

var showing_reverses = false  # Indica si las cartas están mostrando el reverso

@onready var trait_1_panel = $Control/Trait1Panel
@onready var trait_2_panel = $Control/Trait2Panel
@onready var trait_3_panel = $Control/Trait3Panel
@onready var trait_4_panel = $Control/Trait4Panel
@onready var trait_5_panel = $Control/Trait5Panel

# Called when the node enters the scene tree for the first time.
func _ready():
	print("exclu: ", GlobalData.player_stats)
		# Agregar y configurar el temporizador
	add_child(fade_timer)
	fade_timer.one_shot = true
	fade_timer.connect("timeout", Callable(self, "_on_fade_timer_timeout"))
	match GameConfig.ia_difficulty:
		0:
			dificultad_label.text = "Alumno"
		1:
			dificultad_label.text = "Profesor"
		2:
			dificultad_label.text = "Psicólogo"
		_:
			dificultad_label.text = "Alumno"  # Dificultad por defecto
	
	if GlobalData.selected_role == "Líder":
		player_texture_rect.texture = load("res://assets/images/cards/roles/lider.webp")
	if GlobalData.selected_role == "Mediador":
		player_texture_rect.texture = load("res://assets/images/cards/roles/mediador.webp")
	if GlobalData.selected_role == "Escucha Activa":
		player_texture_rect.texture = load("res://assets/images/cards/roles/escucha.webp")
	if GlobalData.selected_role == "Solidario":
		player_texture_rect.texture = load("res://assets/images/cards/roles/soporte_solidario.webp")

	print("dificultad ia: ", GameConfig.ia_difficulty)
	update_ia_texture()
	ia_name_label.text = get_difficulty_text(GameConfig.ia_difficulty)
	player_name_label.text = GlobalData.selected_role
	update_button_text()

	update_traits_based_on_role()
	
# Asigna una imagen dependiendo de la dificultad
func update_ia_texture():
	var image_path: String = ""
	
	match GameConfig.ia_difficulty:
		0:
			image_path = "res://assets/ui/score/ia_boy_1.png"  # Ruta para Estudiante
		1:
			image_path = "res://assets/ui/score/mujer_2.png"   # Ruta para Profesor
		2:
			image_path = "res://assets/ui/score/mujer_3.png"  # Ruta para Psicólogo
		_:
			image_path = "res://assets/ui/score/hombre_1.png"  # Imagen por defecto
	
	# Cargar la imagen y asignarla al TextureRect
	var texture = load(image_path)
	if texture:
		ia_texture_rect.texture = texture
		print("Imagen cargada:", image_path)
	else:
		print("Error: No se pudo cargar la imagen en la ruta:", image_path)
	
# Método para convertir un entero en texto de dificultad
func get_difficulty_text(difficulty: int) -> String:
	match difficulty:
		0:
			return "Estudiante"
		1:
			return "Profesor"
		2:
			return "Psicólogo"
		_:
			return "Desconocido"




func _on_reverse_anverse_toggle_button_pressed():
	GlobalData.toggle_reverses()  # Alterna entre reverso y anverso
	update_button_text()  # Actualiza el texto del botón
	emit_signal("reverse_anverse_toggled", showing_reverses)  # Emite la señal con el estado actual
	

# Actualiza el texto del botón
func update_button_text():
	if GlobalData.showing_reverses:
		reverse_anverse_toggle_button.text = "Girar Carta"  # Cambia el texto a "Anverso"
		showing_reverses = true
	else:
		reverse_anverse_toggle_button.text = "Girar Carta"  # Cambia el texto a "Reverso"texto a "Reverso"
		showing_reverses = false

## Mantén un diccionario para registrar los valores anteriores de player_stats
var previous_player_stats = {}

func update_traits_based_on_role():
	# Verificar que el rol seleccionado y las estadísticas existen
	var selected_role = GlobalData.selected_role
	var player_stats = GlobalData.player_stats

	if not selected_role or not player_stats:
		print("Error: Rol seleccionado o estadísticas no disponibles.")
		return

	# Si previous_player_stats está vacío, inicializarlo con los valores actuales
	if previous_player_stats.size() == 0:
		previous_player_stats = player_stats.duplicate()
	print ("exclu: previos_playuer_Stats", previous_player_stats)
	# Mapeo de texturas asociadas a cada estadística
	var textures_map = {
		"resolucion_conflictos": "res://assets/ui/icons/resolución_de_conflictos.png",
		"comunicacion": "res://assets/ui/icons/comunicacion.png",
		"apoyo_emocional": "res://assets/ui/icons/apoyo_emocional.png",
		"intervencion": "res://assets/ui/icons/intervención.png",
		"empatia": "res://assets/ui/icons/empathy.png"
	}

	# Crear una lista con estadísticas y sus claves
	var stats_with_keys = []
	for key in player_stats.keys():
		var value = player_stats.get(key, 0)
		stats_with_keys.append({ "key": key, "value": value })

	# Ordenar estadísticas de mayor a menor
	stats_with_keys.sort_custom(func(a, b): return a["value"] > b["value"])

	# Diccionario con descripciones para los tooltips
	var tooltips_map = {
		"resolucion_conflictos": "Resolución de Conflictos. Habilidad para resolver conflictos de manera efectiva.",
		"comunicacion": "Comunicación. Capacidad para transmitir ideas y emociones claramente.",
		"apoyo_emocional": "Apoyo Emocional. Habilidad para brindar soporte emocional a otros.",
		"intervencion": "Intervención. Capacidad para intervenir en situaciones críticas.",
		"empatia": "Empatía. Habilidad para ponerse en el lugar de los demás y entender sus emociones."
	}

	# Nodos de los traits (etiquetas y texturas)
	var traits = [
		{ "texture_rect": trait_1_texture_rect, "label": trait_1_label, "panel": trait_1_panel },
		{ "texture_rect": trait_2_texture_rect, "label": trait_2_label, "panel": trait_2_panel },
		{ "texture_rect": trait_3_texture_rect, "label": trait_3_label, "panel": trait_3_panel },
		{ "texture_rect": trait_4_texture_rect, "label": trait_4_label, "panel": trait_4_panel },
		{ "texture_rect": trait_5_texture_rect, "label": trait_5_label, "panel": trait_5_panel }
	]

	# Actualizar las imágenes y estadísticas de los traits
	for i in range(min(stats_with_keys.size(), traits.size())):
		var stat = stats_with_keys[i]
		var trait_node = traits[i]
		var stat_key = stat["key"]
		var stat_value = stat["value"]

		# Crear el tooltip dinámicamente
		var _tooltip_text = tooltips_map.get(stat_key, "Sin descripción disponible.")
		#GlobalData.show_tooltips = false
		if GlobalData.show_tooltips:
			trait_node["panel"].tooltip_text = _tooltip_text
		else: 
			trait_node["panel"].tooltip_text = ""

		# Seleccionar la textura correcta según la estadística
		if textures_map.has(stat_key):
			trait_node["texture_rect"].texture = load(textures_map[stat_key])

		# Formatear el valor con signo
		var formatted_value = ("+" + str(stat_value)) if stat_value > 0 else str(stat_value)
		
		# Actualizar el texto
		var label_node = trait_node["label"]
		label_node.text = formatted_value
		

		var stats_display_map = {
			"resolucion_conflictos": "Resolución de Conflictos",
			"comunicacion": "Comunicación",
			"apoyo_emocional": "Apoyo Emocional",
			"intervencion": "Intervención",
			"empatia": "Empatía"
		}
		# Comprobar si el valor ha cambiado
		if previous_player_stats.has(stat_key) and previous_player_stats[stat_key] != stat_value:
			# Verificar si el stat_key tiene una representación amigable
			if stats_display_map.has(stat_key):
				var display_text = stats_display_map[stat_key]
				songs_label.text = "Has modificado el atributo %s en +1" %(display_text)
				print("exclu: ", stat_key)
				print("exclu: ", display_text)
			else:
				songs_label.text = "Has modificado un atributo desconocido."
			songs_label.visible = true
			songs_label.modulate = Color(1, 1, 1, 1)  # Reinicia la visibilidad del label

		# Inicia el temporizador para que el texto se desvanezca
		fade_timer.start(5.0)
		

	# Ocultar nodos no utilizados si hay menos estadísticas que traits disponibles
	for j in range(stats_with_keys.size(), traits.size()):
		traits[j]["texture_rect"].visible = false
		traits[j]["label"].visible = false

	# Actualizar previous_player_stats con los valores actuales
	previous_player_stats = player_stats.duplicate()

	print("Traits actualizados para el rol:", selected_role)

func _on_fade_timer_timeout():
	# Desvanece el texto usando interpolación
	var tween = create_tween()
	tween.tween_property(songs_label, "modulate", Color(1, 1, 1, 0), fade_duration)
	tween.connect("finished", Callable(self, "_on_fade_complete"))

func _on_fade_complete():
	# Oculta el label al finalizar el desvanecimiento
	songs_label.visible = false
