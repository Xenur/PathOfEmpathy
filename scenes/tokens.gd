extends Control

@onready var animation_player = $AnimationPlayer
@onready var sprite_2d = $Sprite2D


func set_token_image(token_type: String):
	# Diccionario para asociar parámetros con rutas de imágenes
	var token_textures = {
		"ciberbullying": "res://assets/ui/tokens/token_ciberbullying.png",
		"exclusión_social": "res://assets/ui/tokens/token_exclusión_social.png",
		"físico": "res://assets/ui/tokens/token_físico.png",
		"psicológico": "res://assets/ui/tokens/token_psicologico.png",
		"sexual": "res://assets/ui/tokens/token_sexual.png",
		"verbal": "res://assets/ui/tokens/token_verbal.png"
	}

	# Cambiar la textura del Sprite2D según el parámetro
	if token_type in token_textures:
		sprite_2d.texture = load(token_textures[token_type])
		animation_player.play("heartbeat_token", 0, 0.5)
	else:
		print("Token no encontrado: ", token_type)
