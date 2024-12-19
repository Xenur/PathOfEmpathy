# ===============================
# Nombre del Script: tutorial_new_game.gd
# Desarrollador: Carlos Alcaraz Benítez
# Fecha de Creación: 06 de Noviembre de 2024
# Descripción: 
# ===============================
extends Control

@onready var reverse_anverse_toggle_button = $UI/ReverseAnverseToggleButton
@onready var audio_stream_player = $UI/AudioStreamPlayer
@onready var beep_audio_stream_player = $UI/BeepAudioStreamPlayer
@onready var beep_countdown_audio_stream_player = $UI/BeepCountdownAudioStreamPlayer
@onready var audio_stream_token = $UI/AudioStreamToken
@onready var songs_label = $UI/SongsLabel
@onready var dialogue_texture_rect = $UI/DialogueTextureRect
@onready var line_1_dialogue_label = $UI/DialogueTextureRect/Line1DialogueLabel
@onready var line_2_dialogue_label = $UI/DialogueTextureRect/Line2DialogueLabel
@onready var line_3_dialogue_label = $UI/DialogueTextureRect/Line3DialogueLabel
@onready var line_4_dialogue_label = $UI/DialogueTextureRect/Line4DialogueLabel
@onready var line_5_dialogue_label = $UI/DialogueTextureRect/Line5DialogueLabel
@onready var accept_button = $UI/DialogueTextureRect/AcceptButton
@onready var dialogue_label = $UI/DialogueLabel
@onready var hand_texture_rect = $UI/HandTextureRect
@onready var animation_player = $UI/AnimationPlayer

# Nodo AudioStreamPlayer para reproducir el sonido
@onready var sound_player = AudioStreamPlayer.new()
var keypress_sound = preload("res://assets/audio/sfx/consonante_key.ogg")
# Controlador de canciones
var current_song_index = -1
var song_list = [
	"res://assets/audio/music/Arcane Dominion Rising.mp3",
	"res://assets/audio/music/Blade of Eternal War.mp3",
	"res://assets/audio/music/Chaos Dominion Strikes.mp3",
	"res://assets/audio/music/Crimson Battlefront Tactics.mp3",
	"res://assets/audio/music/Cyber Warlord’s Legacy.mp3",
	"res://assets/audio/music/Dread Nexus Awakens.mp3",
	"res://assets/audio/music/Echo of Lost Blades.mp3",
	"res://assets/audio/music/Echoes of Dread.mp3",
	"res://assets/audio/music/Endless Front March.mp3",
	"res://assets/audio/music/Eternal Shadow March.mp3",
	"res://assets/audio/music/Harbinger’s Eternal Call.mp3",
	"res://assets/audio/music/Infernal Accord Broken.mp3",
	"res://assets/audio/music/Lament of Steel Chains.mp3",
	"res://assets/audio/music/Machina’s Wrath Unbound.mp3",
	"res://assets/audio/music/Neon Specter’s Gambit.mp3",
	"res://assets/audio/music/Obsidian Circuit Breaker.mp3",
	"res://assets/audio/music/Phantom War Cry.mp3",
	"res://assets/audio/music/Pulse of War.mp3",
	"res://assets/audio/music/Ruins of Shattered Fate.mp3",
	"res://assets/audio/music/Shadows of Eternal War.mp3",
	"res://assets/audio/music/Specter’s Shadow Edge.mp3",
	"res://assets/audio/music/Strategic Chaos Reign.mp3",
	"res://assets/audio/music/Tactical Rift Surge.mp3",
	"res://assets/audio/music/Titan’s Crimson Gambit.mp3",
	"res://assets/audio/music/Veil of Tactical Chaos.mp3",
	"res://assets/audio/music/Void of Ascension.mp3",
	"res://assets/audio/music/Whispers of Dominion.mp3",
	"res://assets/audio/music/Wraith’s Midnight Siege.mp3",
]

#Variables para manejar el tiempo y la interpolación
@onready var fade_timer = Timer.new()  # Crea un temporizador
var fade_duration = 1.0  # Duración del desvanecimiento en segundos
# Called when the node enters the scene tree for the first time.


# Velocidad de la máquina de escribir (segundos entre caracteres)
var typewriter_speed = 0.03
# Tiempo que el mensaje permanece visible antes de desaparecer (segundos)
var message_display_time = 1.0
# Índice del mensaje actual
var current_message_index = 0
# Lista de mensajes que se mostrarán en el tutorial
var tutorial_messages1 = [
	"Bienvenidos a Caminos de Empatía",
	"¡Vamos a practicar una partida juntos!",
	"Tu objetivo es combatir situaciones de bullying...",
	"...utilizando tus cartas de habilidades"
]
var tutorial_messages2 = [
	"Esta es la situación de bullying actual.",
	"Es el desafio que necesitas resolver",
	"Lee cuidadosamente para poder elegir la mejor respuesta"
	
]
var tutorial_messages3 = [
	"Una vez que tengas claro el desafio deberás...",
	"...elegir las cartas de Respuesta Empática...",
	
]
var tutorial_messages4 = [
	"...y las cartas de Habilidad Social.",
	"Combinando ambas cartas podrás combatir el bullying",
	
]
var tutorial_messages5 = [
	"Es hora de elegir las cartas",
		
]

func _ready():
	#hand_texture_rect.visible = false
	#if dialogue_label:
		#print("Nodo dialogue_label encontrado.")
	#else:
		#print("Error: Nodo dialogue_label no encontrado.")
		#
	#add_child(sound_player)
	#print("ESTAS EN TUTORIAL")
	#dialogue_label.visible = true
	#dialogue_label.text = ""  # Limpia cualquier texto previo
	#await show_messages(tutorial_messages1)
	#await get_tree().create_timer(2.0).timeout
	#hand_texture_rect.visible = true
	#dialogue_label.text = ""  # Limpia cualquier texto previo
	#animation_player.play("hand_bullying", 0, 0.5)
	#
	#await show_messages(tutorial_messages2)
	#
	#await get_tree().create_timer(3.0).timeout
	#hand_texture_rect.visible = true
	#dialogue_label.text = ""  # Limpia cualquier texto previo
	#animation_player.play("hand_re", 0, 0.2)
	#
	#await show_messages(tutorial_messages3)
	#await get_tree().create_timer(3.0).timeout
	#await show_messages(tutorial_messages4)
	#await get_tree().create_timer(3.0).timeout
	#hand_texture_rect.visible = false
	#await show_messages(tutorial_messages5)
	#await get_tree().create_timer(3.0).timeout
	# Agregar y configurar el temporizador
	add_child(fade_timer)
	fade_timer.one_shot = true
	fade_timer.connect("timeout", Callable(self, "_on_fade_timer_timeout"))

	# Reinicia combos y scores
	GlobalData.combo_ia = 0
	GlobalData.combo_player = 0
	GlobalData.hs_multiplier = 0
	GlobalData.re_multiplier = 0
	GlobalData.re_total_score = 0
	GlobalData.hs_total_score = 0
	GlobalData.total_ia_score = 0
	GlobalData.total_player_score = 0
	GlobalData.game_over_time_or_bu = false
	GlobalData.game_over_abort = false
	GlobalData.token_earned_ia["verbal"] = 0
	GlobalData.token_earned_ia["exclusión_social"] = 0
	GlobalData.token_earned_ia["psicológico"] = 0
	GlobalData.token_earned_ia["físico"] = 0
	GlobalData.token_earned_ia["sexual"] = 0
	GlobalData.token_earned_ia["ciberbullying"] = 0
	GlobalData.token_earned_player["verbal"] = 0
	GlobalData.token_earned_player["exclusión_social"] = 0
	GlobalData.token_earned_player["psicológico"] = 0
	GlobalData.token_earned_player["físico"] = 0
	GlobalData.token_earned_player["sexual"] = 0
	GlobalData.token_earned_player["ciberbullying"] = 0
	GlobalData.token_combos_ia["verbal"] = 0
	GlobalData.token_combos_ia["exclusión_social"] = 0
	GlobalData.token_combos_ia["psicológico"] = 0
	GlobalData.token_combos_ia["físico"] = 0
	GlobalData.token_combos_ia["sexual"] = 0
	GlobalData.token_combos_ia["ciberbullying"] = 0
	GlobalData.token_combos_player["verbal"] = 0
	GlobalData.token_combos_player["exclusión_social"] = 0
	GlobalData.token_combos_player["psicológico"] = 0
	GlobalData.token_combos_player["físico"] = 0
	GlobalData.token_combos_player["sexual"] = 0
	GlobalData.token_combos_player["ciberbullying"] = 0
	

	print("comb1: GlobalData.token_combos_player", GlobalData.token_combos_player)
	print("comb1: GlobalData.token_earned_player", GlobalData.token_earned_player)
	print("comb1: GlobalData.token_combos_ia", GlobalData.token_combos_ia)
	print("comb1: GlobalData.token_earned_ia", GlobalData.token_earned_ia)



	audio_stream_player.connect("finished", Callable(self, "_on_audio_stream_player_finished"))

	
	var volume_db = lerp(-80, 0, GameConfig.music_volume / 100.0)
	audio_stream_player.volume_db = volume_db
	volume_db = lerp(-80, 0, GameConfig.sfx_volume / 100.0)
	beep_audio_stream_player.volume_db = volume_db
	beep_countdown_audio_stream_player.volume_db = volume_db
	audio_stream_token.volume_db = volume_db
	#start_playlist()
func start_playlist():
	# Baraja la lista de canciones para reproducirlas aleatoriamente
	song_list.shuffle()
	play_next_song()
#
func play_next_song():
	print("Cambiando a la siguiente canción...")
	current_song_index += 1
	if current_song_index >= song_list.size():
		current_song_index = 0  # Reinicia la lista si llegamos al final
		song_list.shuffle()

	var song_path = song_list[current_song_index]
	print("Cargando canción:", song_path)
	var song = load(song_path) as AudioStream
	if song:
		audio_stream_player.stream = song
		audio_stream_player.play()
		print("Reproduciendo:", song_path)

		# Mostrar el nombre de la canción en el label
		songs_label.text = "Reproduciendo: " + song_path.get_file().get_basename()
		songs_label.visible = true
		songs_label.modulate = Color(1, 1, 1, 1)  # Reinicia la visibilidad del label

		# Inicia el temporizador para que el texto se desvanezca
		fade_timer.start(5.0)

func _on_audio_stream_player_finished():
	print("Canción ha llegado a su fin")
	play_next_song()

func _on_fade_timer_timeout():
	# Desvanece el texto usando interpolación
	var tween = create_tween()
	tween.tween_property(songs_label, "modulate", Color(1, 1, 1, 0), fade_duration)
	tween.connect("finished", Callable(self, "_on_fade_complete"))

func _on_fade_complete():
	# Oculta el label al finalizar el desvanecimiento
	songs_label.visible = false



func show_messages(messages: Array) -> void:
	for i in range(messages.size()):
		# Mostrar el mensaje con el efecto de máquina de escribir
		await type_text(messages[i])
		# Esperar antes de pasar al siguiente mensaje, excepto en el último
		if i < messages.size() - 1:
			await get_tree().create_timer(2.0).timeout

	print("Mensajes finalizados.")
	# La última frase quedará en el Labelbel
	
# Efecto de máquina de escribir para el texto
func type_text(text_to_type: String) -> void:
	dialogue_label.text = ""  # Limpia el texto actual
	for i in range(text_to_type.length()):
		# Espera entre cada carácter
		await get_tree().create_timer(typewriter_speed).timeout
		# Agrega un carácter al texto visible
		dialogue_label.text += text_to_type[i]
		print("Texto actual:", dialogue_label.text)
		# Reproduce el sonido
		play_keypress_sound()


# Reproducir el sonido de tecla
func play_keypress_sound():

	sound_player.volume_db = -10  # Reduce el volumen
	sound_player.stream = keypress_sound  # Asigna el sonido
	sound_player.play()  # Reproduce el sonido
