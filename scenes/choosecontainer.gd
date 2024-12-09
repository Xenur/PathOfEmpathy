extends HBoxContainer

# Variables para los nodos
@onready var choose_role = $".."

@onready var frame_lider_texture_rect = $FrameLiderTextureRect
@onready var back_ground_lider_texture_rect = $FrameLiderTextureRect/LiderControl/BackGroundLiderTextureRect

@onready var frame_mediador_texture_rect = $FrameMediadorTextureRect
@onready var back_ground_mediador_texture_rect = $FrameMediadorTextureRect/MediadorControl/BackGroundMediadorTextureRect

@onready var frame_escucha_texture_rect = $FrameEscuchaTextureRect
@onready var back_ground_escucha_texture_rect = $FrameEscuchaTextureRect/EscuchaControl/BackGroundEscuchaTextureRect

@onready var frame_solidario_texture_rect = $FrameSolidarioTextureRect
@onready var back_ground_solidario_texture_rect = $FrameSolidarioTextureRect/SolidarioControl/BackGroundSolidarioTextureRect
@onready var panel_lider = $FrameLiderTextureRect/PanelLider
@onready var panel_escucha = $FrameEscuchaTextureRect/PanelEscucha
@onready var panel_solidario = $FrameSolidarioTextureRect/PanelSolidario
@onready var panel_mediador = $FrameMediadorTextureRect/PanelMediador
@onready var panel = $"../Panel"

@onready var audio_stream_player = $FrameLiderTextureRect/AudioStreamPlayer
#Declaracion Diccionario roles para guardar los roles y sus estadisticas

var roles = {
	"Mediador": {
		"resolucion_conflictos": 3,
		"comunicacion": 2,
		"apoyo_emocional": -1,
		"intervencion": -2,
		"empatia": 0
	},
	"Escucha Activa": {
		"resolucion_conflictos": -2,
		"comunicacion": 0,
		"apoyo_emocional": 3,
		"intervencion": -3,
		"empatia": 4
	},
	"Líder": {
		"resolucion_conflictos": 0,
		"comunicacion": 2,
		"apoyo_emocional": -2,
		"intervencion": 4,
		"empatia": -3
	},
	"Solidario": {
		"resolucion_conflictos": -2,
		"comunicacion": -1,
		"apoyo_emocional": 3,
		"intervencion": 0,
		"empatia": 3
	}
}



func _ready():
# Carga el volumen del juego
	var volume_db = lerp(-80, 0,GameConfig.sfx_volume / 100.0)
	audio_stream_player.volume_db = volume_db
	#Posiciones y tamaño de las ventanas modales

func _sfx(sound_sfx: String):
	var role_name: String
	if sound_sfx == "res://assets/audio/sfx/mediador.ogg":
		role_name = "Mediador"
	if sound_sfx == "res://assets/audio/sfx/lider.ogg":
		role_name = "Líder"
	if sound_sfx == "res://assets/audio/sfx/escucha_activa.ogg":
		role_name = "Escucha Activa"
	if sound_sfx == "res://assets/audio/sfx/soporte_solidario.ogg":
		role_name = "Solidario"
	if roles.has(role_name):
		GlobalData.selected_role = role_name
		GlobalData.player_stats = roles[role_name]
		print("Rol seleccionado: %s" % GlobalData.selected_role)
		print("Atributos: %s" % GlobalData.player_stats)
	
	panel.show()
	# Configura el volumen
	var volume_db = lerp(-80, 0, GameConfig.sfx_volume / 100.0)
	audio_stream_player.volume_db = volume_db
	
	# Cargar el archivo de audio
	var audio_stream = load(sound_sfx)
	if audio_stream != null:
		print("Cargando audio: %s" % sound_sfx)
		# Asignar el audio al AudioStreamPlayer
		audio_stream_player.stream = audio_stream
		# Reproducir el audio
		if audio_stream_player.playing:
			audio_stream_player.stop()
		audio_stream_player.play()
	else:
		print("Error: No se pudo cargar el audio desde %s" % sound_sfx)

		
func _on_frame_lider_texture_rect_mouse_entered():
	print("entro")
	frame_lider_texture_rect.modulate = Color(1.5, 1.5, 1.5, 1)  # Incrementa brillo
func _on_frame_lider_texture_rect_mouse_exited():
	print("salgo")
	frame_lider_texture_rect.modulate = Color(1, 1, 1, 1)  # Restaura color
func _on_control_mouse_entered():
	print("entro")
	frame_lider_texture_rect.modulate = Color(1.5, 1.5, 1.5, 1)  # Incrementa brillo
func _on_control_mouse_exited():
	print("salgo")
	frame_lider_texture_rect.modulate = Color(1, 1, 1, 1)  # Restaura color


func _on_frame_mediador_texture_rect_mouse_entered():
	print("entro")
	frame_mediador_texture_rect.modulate = Color(1.5, 1.5, 1.5, 1)  # Incrementa brillo
func _on_frame_mediador_texture_rect_mouse_exited():
	print("salgo")
	frame_mediador_texture_rect.modulate = Color(1, 1, 1, 1)  # Restaura color
func _on_mediador_control_mouse_entered():
	print("entro")
	frame_mediador_texture_rect.modulate = Color(1.5, 1.5, 1.5, 1)  # Incrementa brillo
func _on_mediador_control_mouse_exited():
	print("salgo")
	frame_mediador_texture_rect.modulate = Color(1, 1, 1, 1)  # Restaura color


func _on_frame_escucha_texture_rect_mouse_entered():
	print("entro")
	frame_escucha_texture_rect.modulate = Color(1.5, 1.5, 1.5, 1)  # Incrementa brillo

func _on_frame_escucha_texture_rect_mouse_exited():
	print("salgo")
	frame_escucha_texture_rect.modulate = Color(1, 1, 1, 1)  # Restaura color

func _on_escucha_control_mouse_entered():
	print("entro")
	frame_escucha_texture_rect.modulate = Color(1.5, 1.5, 1.5, 1)  # Incrementa brillo

func _on_escucha_control_mouse_exited():
	print("salgo")
	frame_escucha_texture_rect.modulate = Color(1, 1, 1, 1)  # Restaura color


func _on_frame_solidario_texture_rect_mouse_entered():
	print("entro")
	frame_solidario_texture_rect.modulate = Color(1.5, 1.5, 1.5, 1)  # Incrementa brillo


func _on_frame_solidario_texture_rect_mouse_exited():
	print("salgo")
	frame_solidario_texture_rect.modulate = Color(1, 1, 1, 1)  # Restaura color


func _on_solidario_control_mouse_entered():
	print("entro")
	frame_solidario_texture_rect.modulate = Color(1.5, 1.5, 1.5, 1)  # Incrementa brillo


func _on_solidario_control_mouse_exited():
	print("salgo")
	frame_solidario_texture_rect.modulate = Color(1, 1, 1, 1)  # Restaura color


func _on_frame_mediador_texture_rect_gui_input(event):
	# Verifica si el evento es un doble clic
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.double_click:
		_sfx("res://assets/audio/sfx/mediador.ogg")
		frame_lider_texture_rect.modulate = Color(0.5, 0.5, 0.5, 1)  # Restaura color
		
		frame_escucha_texture_rect.modulate = Color(0.5, 0.5, 0.5, 1)  # Restaura color
		frame_solidario_texture_rect.modulate = Color(0.5, 0.5, 0.5, 1)  # Restaura color
		panel_lider.show()		
		panel_solidario.show()
		panel_escucha.show()

func _on_mediador_control_gui_input(event):
	# Verifica si el evento es un doble clic
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.double_click:
		_sfx("res://assets/audio/sfx/mediador.ogg")
		frame_lider_texture_rect.modulate = Color(0.5, 0.5, 0.5, 1)  # Restaura color
		
		frame_escucha_texture_rect.modulate = Color(0.5, 0.5, 0.5, 1)  # Restaura color
		frame_solidario_texture_rect.modulate = Color(0.5, 0.5, 0.5, 1)  # Restaura color
		panel_lider.show()
		panel_solidario.show()
		panel_escucha.show()

func _on_frame_escucha_texture_rect_gui_input(event):
	# Verifica si el evento es un doble clic
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.double_click:
		_sfx("res://assets/audio/sfx/escucha_activa.ogg")
		frame_lider_texture_rect.modulate = Color(0.5, 0.5, 0.5, 1)  # Restaura color
		frame_mediador_texture_rect.modulate = Color(0.5, 0.5, 0.5, 1)  # Restaura color
		
		frame_solidario_texture_rect.modulate = Color(0.5, 0.5, 0.5, 1)  # Restaura color
		panel_lider.show()
		panel_solidario.show()
		panel_mediador.show()


func _on_escucha_control_gui_input(event):
	# Verifica si el evento es un doble clic
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.double_click:
		_sfx("res://assets/audio/sfx/escucha_activa.ogg")
		frame_lider_texture_rect.modulate = Color(0.5, 0.5, 0.5, 1)  # Restaura color
		frame_mediador_texture_rect.modulate = Color(0.5, 0.5, 0.5, 1)  # Restaura color
		frame_solidario_texture_rect.modulate = Color(0.5, 0.5, 0.5, 1)  # Restaura color
		panel_lider.show()
		panel_solidario.show()
		panel_mediador.show()


func _on_frame_solidario_texture_rect_gui_input(event):
	# Verifica si el evento es un doble clic
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.double_click:
		_sfx("res://assets/audio/sfx/soporte_solidario.ogg")
		frame_lider_texture_rect.modulate = Color(0.5, 0.5, 0.5, 1)  # Restaura color
		frame_mediador_texture_rect.modulate = Color(0.5, 0.5, 0.5, 1)  # Restaura color
		frame_escucha_texture_rect.modulate = Color(0.5, 0.5, 0.5, 1)  # Restaura color
		panel_lider.show()

		panel_mediador.show()
		panel_escucha.show()

func _on_solidario_control_gui_input(event):
	# Verifica si el evento es un doble clic
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.double_click:
		_sfx("res://assets/audio/sfx/soporte_solidario.ogg")
		frame_lider_texture_rect.modulate = Color(0.5, 0.5, 0.5, 1)  # Restaura color
		frame_mediador_texture_rect.modulate = Color(0.5, 0.5, 0.5, 1)  # Restaura color
		frame_escucha_texture_rect.modulate = Color(0.5, 0.5, 0.5, 1)  # Restaura color
		panel_lider.show()

		panel_mediador.show()
		panel_escucha.show()

func _on_frame_lider_texture_rect_gui_input(event):
	# Verifica si el evento es un doble clic
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.double_click:
		_sfx("res://assets/audio/sfx/lider.ogg")
		
		frame_mediador_texture_rect.modulate = Color(0.5, 0.5, 0.5, 1)  # Restaura color
		frame_escucha_texture_rect.modulate = Color(0.5, 0.5, 0.5, 1)  # Restaura color
		frame_solidario_texture_rect.modulate = Color(0.5, 0.5, 0.5, 1)  # Restaura color

		panel_solidario.show()
		panel_mediador.show()
		panel_escucha.show()
func _on_lider_control_gui_input(event):
	# Verifica si el evento es un doble clic
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.double_click:
		_sfx("res://assets/audio/sfx/lider.ogg")
		frame_mediador_texture_rect.modulate = Color(0.5, 0.5, 0.5, 1)  # Restaura color
		frame_escucha_texture_rect.modulate = Color(0.5, 0.5, 0.5, 1)  # Restaura color
		frame_solidario_texture_rect.modulate = Color(0.5, 0.5, 0.5, 1)  # Restaura color

		panel_solidario.show()
		panel_mediador.show()
		panel_escucha.show()


func _on_audio_stream_player_finished():
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file("res://scenes/LoadingGame.tscn")
