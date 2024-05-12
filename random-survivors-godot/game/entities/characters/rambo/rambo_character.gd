extends Character


#region Ability var
var is_dashing := false

const DEFAULT_DASH_SPEED = 250
var dash_speed := DEFAULT_DASH_SPEED

const DEFAULT_DASH_RANGE := 100
var dash_range := DEFAULT_DASH_RANGE
#endregion


#region Process functions
func animation():
	animated_sprite.play_animation_with_dash(state, is_dashing, move_direction_vector)
#endregion


#region Ability functions
func ability():
	start_knockback(dash_range, dash_speed)

	is_dashing = true

func stop_knockback():
	set_state(State.IDLE)
	health_module.hitbox_enable()

	is_dashing = false
#endregion
