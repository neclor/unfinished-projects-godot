extends Node2D


@onready var border_polygon = $BorderPolygon
@onready var body_polygon = $BodyPolygon
@onready var hp_polygon = $HpPolygon


func set_figure_parameters(input_border_polygon : PackedVector2Array, input_body_polygon : PackedVector2Array, input_border_color : Color, input_body_color : Color, input_hp_color : Color):
	border_polygon.polygon = input_border_polygon
	body_polygon.polygon = input_body_polygon
	hp_polygon.polygon = input_body_polygon

	border_polygon.color = input_border_color
	body_polygon.color = input_body_color
	hp_polygon.color = input_hp_color


func redraw_hp(input_hp_polygon : PackedVector2Array):
	hp_polygon.polygon = input_hp_polygon
	queue_redraw()
