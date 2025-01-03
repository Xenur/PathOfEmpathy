extends Control


var font_resource: Font = preload("res://assets/fonts/Roboto-Medium.ttf")
const SAVE_FILE_PATH = "user://game.json"

func _draw():
	if FileAccess.open(SAVE_FILE_PATH, FileAccess.READ):
		var average_data = GlobalData.get_average_data()
		# Calcular el total sumando las categorías
		

		# Centro y radio del gráfico
		var center = Vector2(160, 225)
		var center2 = Vector2(450, 225)
		var radius = 90

		# Colores para cada categoría (debes definir estos previamente)
		var colors2 = [
			Color(0.5, 0.2, 0.8),  # Verde: Ganadas
			Color(1.0, 0.5, 0.0),  # Rojo: Perdidas
			Color(0.2, 0.8, 0.8),  # Azul: Empatadas
		]
		# Colores para cada categoría (debes definir estos previamente)
		var colors = [
			Color(0.2, 0.8, 0.2),  # Verde: Lider
			Color(0.8, 0.2, 0.2),  # Rojo: solidario
			Color(0.2, 0.2, 0.8),  # Azul: escucha
			Color(0.9, 0.9, 0.2)   # Amarillo: mediador
		]

		# Categorías para las etiquetas
		var roles = ["Líder", "Mediador","Solidario", "Escucha"]
		var ias = ["Alumno", "Profesor", "Psicólogo"]
		# Calcular ángulos
		var angles = [
			(float(average_data["average_lider"])/100) * 360,
			(float(average_data["average_mediador"])/100) * 360,
			(float(average_data["average_solidario"])/100) * 360,
			(float(average_data["average_escucha"])/100) * 360
		]
		var angles2 = [
			(float(average_data["average_alumno"])/100) * 360,
			(float(average_data["average_profesor"])/100) * 360,
			(float(average_data["average_psicologo"])/100) * 360
		]

		# Dibujar cada trozo
		var start_angle = 0
		for i in range(angles.size()):
			var end_angle = start_angle + angles[i]
			# Dibujar trozo del gráfico
			draw_circle_arc_poly(center, radius, start_angle, end_angle, colors[i])

			# Calcular la posición del texto a la izquierda
			var text_position = Vector2(40, 60 + i * 25)  # Ajusta las posiciones verticales
			draw_string(
				font_resource,
				text_position,
				"%s: %.1f%%" % [roles[i], (angles[i] / 360) * 100],HORIZONTAL_ALIGNMENT_LEFT,-1,14,colors[i]
			)

			# Actualizar el ángulo inicial para el siguiente trozo
			start_angle = end_angle
			
		# Dibujar cada trozo
		start_angle = 0
		for i in range(angles2.size()):
			var end_angle = start_angle + angles2[i]
			# Dibujar trozo del gráfico
			draw_circle_arc_poly(center2, radius, start_angle, end_angle, colors2[i])

			# Calcular la posición del texto a la izquierda
			var text_position = Vector2(395, 65 + i * 25)  # Ajusta las posiciones verticales
			draw_string(
				font_resource,
				text_position,
				"%s: %.1f%%" % [ias[i], (angles2[i] / 360) * 100],HORIZONTAL_ALIGNMENT_LEFT,-1,14,colors2[i]
			)

			# Actualizar el ángulo inicial para el siguiente trozo
			start_angle = end_angle

func draw_circle_arc_poly(center, radius, angle_from, angle_to, color):
	var nb_points = 32
	var points_arc = PackedVector2Array()
	points_arc.push_back(center)
	var colors = PackedColorArray([color])

	# Generar los puntos del arco
	for i in range(nb_points + 1):
		var angle_point = deg_to_rad(angle_from + i * (angle_to - angle_from) / nb_points)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)
	
	# Dibujar el polígono para el trozo
	draw_polygon(points_arc, colors)
