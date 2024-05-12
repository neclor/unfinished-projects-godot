extends Entity
class_name Character


@onready var ability_cooldown_timer = $AbilityCooldownTimer


var view_direction_vector := Vector2(0, 0.5)


#region Ability var
var ability_ready := true
var ability_cooldown := 2
#endregion


#region Init functions
func _ready():
	health_module.max_shield = 100
	health_module.shield = 100
	melee_attack_module.target_group = "enemies"
	change_speed(80)
#endregion


#region Action functions
func action():
	start_ability()
#endregion


#region Move functions
func move():
	if state == State.IDLE or state == State.MOVE:
		var input_move_direction_vector = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down"))
		input_move_direction_vector.y /= 2

		match input_move_direction_vector:
			Vector2(0, 0):
				set_state(State.IDLE)
			_:
				move_direction_vector = normalize_isometric_vector(input_move_direction_vector)
				set_state(State.MOVE)
				one_move()
#endregion


#region Ability functions
func start_ability():
	if ability_ready and Input.is_action_just_pressed("use_ability"):
		start_ability_cooldown()
		ability()

func ability():
	pass

func start_ability_cooldown():
	ability_ready = false
	ability_cooldown_timer.wait_time = ability_cooldown
	ability_cooldown_timer.start()

func _on_ability_cooldown_timer_timeout():
	ability_ready = true
#endregion
