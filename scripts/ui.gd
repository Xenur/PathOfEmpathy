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



@onready var audio_stream_player = $AudioStreamPlayer
@onready var beep_audio_stream_player = $BeepAudioStreamPlayer
@onready var player_texture_rect = $"../UI/ScoreTokenPlayer/PlayerTextureRect"

@onready var dificultad_label = $Dificultad/Panel/DificultadLabel

# Definimos la señal personalizada
signal reverse_anverse_toggled(showing_reverses: bool)

var showing_reverses = false  # Indica si las cartas están mostrando el reverso



# Called when the node enters the scene tree for the first time.
func _ready():
	
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
