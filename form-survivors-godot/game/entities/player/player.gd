class_name Player
extends Entity


@onready var collision_shape = $CollisionShape
@onready var circle_component = $CircleComponent


const DEFAULT_SPEED = 150
const DEFAULT_ATTACK_POWER = 1
const DEFAULT_HP = 100
const HP_COLOR = Color.RED
const BODY_COLOR = Color("#800000")


var level := 0
var xp := 0


func _init():
	speed = DEFAULT_SPEED
	attack_power = DEFAULT_ATTACK_POWER


func _ready():
	health_component.set_values(DEFAULT_HP, 10)

	collision = collision_shape
	figure = circle_component

	figure.set_figure_parameters(BORDER_RADIUS, BODY_RADIUS, BORDER_COLOR, BODY_COLOR, HP_COLOR)

	die_particles.color = HP_COLOR


func move():
		var input_move_direction_vector = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down"))
		move_direction_vector = input_move_direction_vector.normalized()
		move_step()


func die():
	print("mertv")
