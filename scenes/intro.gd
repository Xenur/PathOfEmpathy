extends Node2D
@onready var video_stream_player = $VideoStreamPlayer


func _ready():
	await get_tree().create_timer(1.5).timeout
	var volume_db = lerp(-80, 0, GameConfig.music_volume / 100.0)
	video_stream_player.volume_db = volume_db
	video_stream_player.play()
	
#Señal de tecla escape presionada
func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			video_stream_player.stop()
			get_tree().change_scene_to_file("res://scenes/ChooseRole.tscn")


func _on_video_stream_player_finished():
	get_tree().change_scene_to_file("res://scenes/ChooseRole.tscn")
