extends AnimatedSprite


#region Animation var
var is_dashing := false
#endregion


#region Animation functions
func play_animation_with_dash(state: Entity.State, dash_state: bool, move_direction_vector: Vector2):
	is_dashing = dash_state

	play_animation(state, move_direction_vector)

func check_state(state: Entity.State):
	match state:
		Entity.State.IDLE:
			animation_name += "idle"

		Entity.State.MOVE:
			animation_name += "move"

		Entity.State.STUN:
			animation_name += "idle"

		Entity.State.KNOCKBACK:
			if is_dashing:
				animation_name += "dash"
			else:
				animation_name += "idle"
				animation_direction_vector *= -1

		_:
			animation_name += "idle"

	return animation_name
#endregion
