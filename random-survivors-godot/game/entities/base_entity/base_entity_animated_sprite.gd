extends AnimatedSprite2D
class_name AnimatedSprite

#region Animation var
var animation_direction_vector := Vector2.DOWN
var animation_name := ""
#endregion


#region Animation functions
func play_animation(state: Entity.State, move_direction_vector: Vector2):
	animation_direction_vector = move_direction_vector
	animation_name = ""

	animation_name = check_state(state)
	animation_name = check_direction(animation_direction_vector)

	self.play(animation_name)

func check_state(state: Entity.State):
	match state:
		Entity.State.IDLE:
			animation_name += "idle"

		Entity.State.MOVE:
			animation_name += "move"

		Entity.State.STUN:
			animation_name += "idle"

		Entity.State.KNOCKBACK:
			animation_name += "idle"
			animation_direction_vector *= -1

		_:
			animation_name += "idle"

	return animation_name

func check_direction(move_direction_vector: Vector2):
	var move_direction_angle := move_direction_vector.angle()

	if abs(move_direction_angle) > PI / 2:
		self.set_flip_h(true)
		move_direction_angle = sign(move_direction_angle) * PI - move_direction_angle
	else:
		self.set_flip_h(false)

	if abs(move_direction_angle) <= atan(0.5) / 2:
		animation_name += "_side"
	else:
		if sign(move_direction_angle) > 0:
			animation_name += "_down"
		else:
			animation_name += "_up"

		if abs(move_direction_angle) < (atan(0.5) + PI / 2) / 2:
			animation_name += "_diagonally"

	return animation_name
#endregion
