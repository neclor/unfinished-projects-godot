class_name Enemy
extends Entity


@onready var collision_polygon = $CollisionPolygon
@onready var polygon_component = $PolygonComponent
@onready var hit_box = $HitBox
@onready var hit_box_collision_polygon = $HitBox/HitBoxCollisionPolygon
@onready var player = get_parent().get_node_or_null("Player")


const MIN_VERTICES_NUMBER = 3
var vertices_number : int 


var normalized_polygon : PackedVector2Array


func init(new_vertices_number : int = MIN_VERTICES_NUMBER):
	new_vertices_number = MIN_VERTICES_NUMBER if new_vertices_number < MIN_VERTICES_NUMBER else new_vertices_number
	vertices_number = new_vertices_number

	speed = vertices_number * 20
	attack_power = vertices_number


func _ready():
	health_component.set_values(vertices_number, 0)

	collision = collision_polygon
	figure = polygon_component

	set_polygons()

	self.rotation = randf_range(0.0, 2 * PI)


func set_polygons():
	var hp_color = choose_color()
	var body_color = hp_color / 2
	body_color.a = 1.0

	set_normalized_polygon()

	var border_polygon = create_polygon(BORDER_RADIUS)
	collision.polygon = border_polygon
	hit_box_collision_polygon.polygon = border_polygon

	figure.set_figure_parameters(border_polygon, create_polygon(BODY_RADIUS), BORDER_COLOR, body_color, hp_color)

	die_particles.color = hp_color


func choose_color():
	var color_components = [randf(), randf(), 0.0]
	var lower_limit = 1.0 - (color_components[0] + color_components[1])

	lower_limit = 0.0 if lower_limit < 0 else lower_limit

	color_components[2] = randf_range(lower_limit, 1.0)

	color_components.shuffle()
	return Color(color_components[0], color_components[1], color_components[2])


func create_polygon(factor : float):
	var polygon = normalized_polygon.duplicate()
	for i in polygon.size():
		polygon[i] *= factor
	return polygon


func set_normalized_polygon():
	var angle_between_points := 2 * PI / vertices_number
	var current_angle := 0.0
	normalized_polygon = []
	for i in vertices_number:
		var next_normalized_point = Vector2.from_angle(current_angle).normalized()
		normalized_polygon.append(next_normalized_point)
		current_angle += angle_between_points


func move():
	if player:
		move_direction_vector = global_position.direction_to(player.global_position).normalized()
		move_step()
	else:
		player = get_parent().get_node_or_null("Player")


func _on_hit_box_body_entered(body):
	if body.is_in_group("player"):
		body.health_component.take_damage(attack_power)
	start_dying()


func start_dying():
	collision.set_deferred("disabled", true)
	figure.visible = false
	hit_box.set_deferred("monitoring", false)
	die_particles.restart()


func redraw_hp(hp_ratio : float):
	figure.redraw_hp(create_polygon(BODY_RADIUS * hp_ratio))
