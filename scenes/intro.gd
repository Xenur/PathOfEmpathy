extends Node2D
@onready var video_stream_player = $VideoStreamPlayer


func _ready():
	pass
#Señal de tecla escape presionada
func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			video_stream_player.stop()
			get_tree().change_scene_to_file("res://scenes/ChooseRole.tscn")


func _on_video_stream_player_finished():
	get_tree().change_scene_to_file("res://scenes/ChooseRole.tscn")
