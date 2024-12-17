extends Control
@onready var tutorial_label = $TutorialLabel
@onready var dialogue_label = $DialogueLabel
@onready var h_box_container = $HBoxContainer
@onready var fade_rect: ColorRect = $ColorRect  # Asegúrate de que el nodo ColorRect exista
@onready var accept_button = $AcceptButton

# Velocidad de la máquina de escribir (segundos entre caracteres)
var typewriter_speed = 0.03
# Tiempo que el mensaje permanece visible antes de desaparecer (segundos)
var message_display_time = 1.0
# Índice del mensaje actual
var current_message_index = 0
# Lista de mensajes que se mostrarán en el tutorial
var tutorial_messages = [
	"Bienvenido al tutorial. Aprende cómo jugar paso a paso.",
	"¡Vamos a practicar una partida juntos!",
	"Primero deberas eligir el rol con el que deseas jugar. ",
	"Tu elección afecta directemente los atributos de las cartas.",
	"Ahora elige el rol que más se adapte a ti."
]


# Nodo AudioStreamPlayer para reproducir el sonido
@onready var sound_player = AudioStreamPlayer.new()
# Archivo de sonido
var keypress_sound = preload("res://assets/audio/sfx/consonante_key.ogg")
# Called when the node enters the scene tree for the first time.
func _ready():
	accept_button.disabled = true
	fade_in_scene(1.5)  # Duración de 1.5 segundos
	await get_tree().create_timer(2.0).timeout
	if !has_played_before(GlobalData.id) or GameConfig.tutorial == false:
		GameConfig.tutorial = true
		dialogue_label.visible = true
		# Configuración inicial
		h_box_container.visible = false
		h_box_container.modulate.a = 0  # Comienza invisible

		# Agregar el reproductor de sonido como hijo
		add_child(sound_player)

		# Deshabilitar interacción al inicio
		disable_mouse_interaction()
		disable_children_gui_events()

		# Mostrar los mensajes del tutorial
		await show_messages()

		# Al finalizar el tutorial, habilitar interacción y mostrar HBoxContainer gradualmente
		enable_mouse_interaction()
		enable_children_gui_events()
		fade_in_hbox_container()
		GlobalData.tutorial = true
		accept_button.disabled = false
	else:
		accept_button.disabled = false
		h_box_container.visible = false
		h_box_container.modulate.a = 0  # Comienza invisible
		dialogue_label.visible = false
		fade_in_hbox_container()
		GlobalData.tutorial = false

		


#Funcion para comprobar si el jugador ha jugado alguna partida.
#Si no ha jugado ninguna partida se inicia el tutorial.
#En caso contrario juega una partida normal.

func has_played_before(id_jugador: int) -> bool:
	
	# Cargar los datos guardados
	var saved_data = load_saved_games_persistence()
	
	# Verificar si "partidas" existe y contiene datos
	if not saved_data.has("partidas") or saved_data["partidas"].size() == 0:
		return false  # No hay datos de partidas

	# Verificar si el jugador tiene partidas registradas
	for jugador_partidas in saved_data["partidas"]:
		if jugador_partidas["id_jugador"] == id_jugador:
			return true  # El jugador tiene al menos una partida registrada

	return false  # No se encontró el id_jugador en las partidas
	
func load_saved_games_persistence() -> Dictionary:
	const SAVE_FILE_PATH = "user://game.json"
	var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
	if not file:
		print("Archivo de partidas no encontrado, creando un nuevo registro...")
		return {"partidas": []}
	if file:
		var data = file.get_as_text()
		var json = JSON.new()
		var parse_result = json.parse_string(data)
		return parse_result

	print("Error al cargar los datos guardados.")
	return {"partidas": []}


 #Mostrar los mensajes uno por uno en el Label
func show_messages() -> void:
	for i in range(tutorial_messages.size()):
		# Mostrar el mensaje con el efecto de máquina de escribir
		await type_text(tutorial_messages[i])
		# Esperar antes de pasar al siguiente mensaje, excepto en el último
		if i < tutorial_messages.size() - 1:
			await get_tree().create_timer(2.0).timeout
			#habilitar la interacción con los roles
			h_box_container.mouse_filter = MOUSE_FILTER_PASS

	print("El tutorial ha terminado.")
	# La última frase quedará en el Label
	
# Efecto de máquina de escribir para el texto
func type_text(text_to_type: String) -> void:
	dialogue_label.text = ""  # Limpia el texto actual
	for i in range(text_to_type.length()):
		# Espera entre cada carácter
		await get_tree().create_timer(typewriter_speed).timeout
		# Agrega un carácter al texto visible
		dialogue_label.text += text_to_type[i]
		# Reproduce el sonido
		play_keypress_sound()


# Reproducir el sonido de tecla
func play_keypress_sound():
	sound_player.volume_db = -10  # Reduce el volumen
	sound_player.stream = keypress_sound  # Asigna el sonido
	sound_player.play()  # Reproduce el sonido

# Función para deshabilitar la interacción con el ratón
func disable_mouse_interaction():
	h_box_container.mouse_filter = Control.MOUSE_FILTER_IGNORE
	print("Interacción con el ratón deshabilitada.")

# Función para habilitar la interacción con el ratón
func enable_mouse_interaction():
	h_box_container.mouse_filter = Control.MOUSE_FILTER_PASS
	print("Interacción con el ratón habilitada.")
	
# Referencia al HBoxContainer
@onready var hbox_container = $HBoxContainer
#Variables para manejar el tiempo y la interpolación
@onready var fade_timer = Timer.new()  # Crea un temporizador
var fade_duration = 1.5 # Duración del desvanecimiento en segundos
# Deshabilitar todos los TextureRect hijos
func disable_children_gui_events():
	h_box_container.visible = false

	for child in h_box_container.get_children():
		if child is TextureRect:
			child.mouse_filter = Control.MOUSE_FILTER_IGNORE  # Ignorar interacción del ratón
			print("Interacción deshabilitada para:", child.name)

# Habilitar todos los TextureRect hijos
func enable_children_gui_events():
	h_box_container.visible = true

	for child in h_box_container.get_children():
		if child is TextureRect:
			child.mouse_filter = Control.MOUSE_FILTER_PASS  # Restaurar interacción del ratón
			print("Interacción habilitada para:", child.name)

# Función para mostrar gradualmente el HBoxContainer
func fade_in_hbox_container():
	h_box_container.visible = true
	var tween = create_tween()
	tween.tween_property(h_box_container, "modulate:a", 1, fade_duration)
	print("HBoxContainer apareciendo poco a poco.")


func fade_in_scene(duration: float = 1.5) -> void:
		fade_rect.visible = true  # Asegúrate de que sea visible
		fade_rect.modulate.a = 1.0  # Opacidad completa (negro sólido)
		var tween = create_tween()  # Crea un Tween
		tween.tween_property(fade_rect, "modulate:a", 0.0, duration)  # Anima a opacidad 0
		await tween.finished
		fade_rect.visible = false  # Oculta el ColorRect al final
