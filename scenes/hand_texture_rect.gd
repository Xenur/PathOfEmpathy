extends TextureRect

# Duración de la animación pulsátil
var pulse_duration = 1.0  # Segundos

func _ready():
	pass
	#start_pulse()

func start_pulse():
	# Crear un tween para animar el brillo
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color(1, 1, 1, 0.5), pulse_duration / 2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "modulate", Color(1, 1, 1, 1), pulse_duration / 2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.set_loops()  # Repetir el efecto infinitamente
