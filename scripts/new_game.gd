# ===============================
# Nombre del Script: new_game.gd
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
func _ready():
	print("ESTAS EN NEW_GAME")
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
	start_playlist()
func start_playlist():
	# Baraja la lista de canciones para reproducirlas aleatoriamente
	song_list.shuffle()
	play_next_song()
#
#func play_next_song():
	#print("repro Cambiando a la siguiente canción...")
	#current_song_index += 1
	#if current_song_index >= song_list.size():
		#current_song_index = 0  # Reinicia la lista si llegamos al final
		#song_list.shuffle()
	#var song_path = song_list[current_song_index]
	#print("repro Cargando canción:", song_path)
	#var song = load(song_path) as AudioStream
	#if song:
		#audio_stream_player.stream = song
		#audio_stream_player.play()
		#print("repro Reproduciendo:", song_path)
		#songs_label.visible = true
		#songs_label.text = 
#func _on_audio_stream_player_finished():
	## Cuando termine la canción, pasa a la siguiente
	#print("repro cancion ha llegado a su fin")
	#play_next_song()

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
