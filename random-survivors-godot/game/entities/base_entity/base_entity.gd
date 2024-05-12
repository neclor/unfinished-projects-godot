extends CharacterBody2D
class_name Entity


@onready var sec_timer = $SecTimer
@onready var stun_timer = $StunTimer

@onready var collision_shape = $CollisionShape

@onready var health_module = $HealthModule
@onready var melee_attack_module = $MeleeAttackModule

@onready var animated_sprite = $AnimatedSprite


#region State var
enum State {
	IDLE = 0,
	MOVE = 1,
	STUN = 2,
	KNOCKBACK = 4,
}
var AvailableStates = State.IDLE | State.MOVE | State.STUN | State.KNOCKBACK
var state := State.IDLE

var invulnerability := false
#endregion


#region Move var
var move_direction_vector : Vector2 = normalize_isometric_vector(Vector2.DOWN)

const DEFAULT_SPEED := 40
var speed := DEFAULT_SPEED
#endregion


#region Stun var
const DEFAULT_STUN_TIME := 1
#endregion


#region Knockback var
const DEFAULT_KNOCKBACK_SPEED := 250
var knockback_speed := DEFAULT_KNOCKBACK_SPEED

const DEFAULT_KNOCKBACK_RANGE := 100
var remaining_knockback_range := DEFAULT_KNOCKBACK_RANGE
#endregion


#region Utilitarian functions
func change_speed(new_speed: int):
	speed = new_speed
	animated_sprite.speed_scale = 1.0 * speed / DEFAULT_SPEED

func normalize_isometric_vector(vector: Vector2):
	# Since the game is played in isometry, the changes in the Y coordinate should be 2 times smaller,
	# so i first normalize the vector stretched along the Y, and then reduce its Y component to maintain the direction

	var new_isometric_vector := Vector2(vector.x, vector.y * 2).normalized()
	new_isometric_vector.y /=2
	return new_isometric_vector

func set_state(new_state: State):
	if new_state == State.IDLE or has_flag(AvailableStates, new_state):
		state = new_state
		return true

	return false

func has_flag(flags, flag_to_check):
	return (flags & flag_to_check) != 0
#endregion


#region Process functions
func _physics_process(delta):
	match state:
		State.STUN:
			pass
		State.KNOCKBACK:
			knockback(delta)
		_:
			action()
			move()


func _on_sec_timer_timeout():
	health_module.regen()

func _process(_delta):
	animation()

func animation():
	animated_sprite.play_animation(state, move_direction_vector)
#endregion


#region Action functions
func action():
	pass
#endregion


#region Move functions
func move():
	pass

func one_move():
	velocity = move_direction_vector * speed
	move_and_slide()
#endregion


#region Stun functions
func start_stun(new_stun_time: int = DEFAULT_STUN_TIME):
	if !set_state(State.STUN):
		return false

	stun_timer.wait_time = new_stun_time
	stun_timer.start()

func _on_stan_timer_timeout():
	stop_stun()

func stop_stun():
	set_state(State.IDLE)
#endregion


#region Knockback functions
func start_knockback(new_knockback_range: int = DEFAULT_KNOCKBACK_RANGE, new_knockback_speed: int = DEFAULT_KNOCKBACK_SPEED, new_knockback_direction: Vector2 = move_direction_vector):
	if !set_state(State.KNOCKBACK):
		return false

	remaining_knockback_range = new_knockback_range
	knockback_speed = new_knockback_speed
	move_direction_vector = new_knockback_direction

	velocity = move_direction_vector * knockback_speed

	health_module.hitbox_disable()

func knockback(delta):
	move_and_slide()

	remaining_knockback_range -= knockback_speed * delta
	check_stop_knockback()

func check_stop_knockback():
	if remaining_knockback_range <= 0:
		stop_knockback()

func stop_knockback():
	set_state(State.IDLE)
	health_module.hitbox_enable()
#endregion


#region Damage functions
func take_damage(input_damage: Damage):
	if state == State.KNOCKBACK or invulnerability:
		return false

	health_module.take_damage(input_damage)
#endregion
