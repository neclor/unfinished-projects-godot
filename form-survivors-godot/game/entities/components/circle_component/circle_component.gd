extends Node2D


var border_radius : float
var body_radius : float
var hp_radius : float
var border_color : Color
var body_color : Color
var hp_color : Color


func set_figure_parameters(input_border_radius : float, input_body_radius : float, input_border_color : Color, input_body_color : Color, input_hp_color : Color):
	border_radius = input_border_radius
	body_radius = input_body_radius
	hp_radius = body_radius
	border_color = input_border_color
	body_color = input_body_color
	hp_color = input_hp_color
	queue_redraw()


func _draw():
	draw_circle(Vector2.ZERO, border_radius, border_color)
	draw_circle(Vector2.ZERO, body_radius, body_color)
	draw_circle(Vector2.ZERO, hp_radius, hp_color)


func redraw_hp(new_hp_radius : float):
	hp_radius = new_hp_radius
	queue_redraw()
