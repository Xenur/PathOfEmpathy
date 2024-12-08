@onready var _material = material  # Cambia $Sprite por el nodo de tu imagen

func _on_mouse_entered():
	material.modulate = Color(1.5, 1.5, 1.5, 1)  # Incrementa el brillo (valores mayores a 1 aumentan la luminosidad)

func _on_mouse_exited():
	material.modulate = Color(1, 1, 1, 1)  # Restaura el brillo original
