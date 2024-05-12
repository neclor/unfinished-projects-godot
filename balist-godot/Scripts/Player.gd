extends CharacterBody2D
class_name Player

const Bullet = preload("res://Scenes/Bullet.tscn")

const SPEED = 100
var hp = 100

const HULL_ROTATION_SPEED = 1
const CANNON_ROTATION_SPEED = 3



var hull_degrees = 0
var cannon_degrees = 0

var attack_cooldown = 1
var time_to_next_attack = 0


func _ready():
	$Name.text = name

	if not is_multiplayer_authority(): return
	
	$PlayerCamera.make_current()

func _enter_tree():
	set_multiplayer_authority(str(name).to_int())





func _physics_process(delta):
	if not is_multiplayer_authority(): return

	move()
	cannon_rotation()

	if Input.is_action_just_pressed("Shot"):
		fire(cannon_degrees)
		
	if time_to_next_attack >= 0:
		time_to_next_attack -= delta

func move():
	var direction = Vector2(Input.get_axis("Left", "Right"), Input.get_axis("Up", "Down"))
	if direction:
		velocity = direction.normalized() * SPEED

		var required_degrees
		match direction:
			Vector2(0, -1):
				required_degrees = 0

			Vector2(1, -1):
				required_degrees = 45

			Vector2(1, 0):
				required_degrees = 90

			Vector2(1, 1):
				required_degrees = 135

			Vector2(0, 1):
				required_degrees = 180

			Vector2(-1, 1):
				required_degrees = 225

			Vector2(-1, 0):
				required_degrees = 270

			Vector2(-1, -1):
				required_degrees = 315

		hull_degrees = part_rotation(hull_degrees, required_degrees, HULL_ROTATION_SPEED)
		$HullSprite.rotation_degrees = hull_degrees
		$Collision.rotation_degrees = hull_degrees
		$HullSprite.play("move")

	else:
		velocity = Vector2(0, 0)
		$HullSprite.stop()

	move_and_slide()

func cannon_rotation():
	var mouse_position = get_local_mouse_position()

	var required_degrees = round(atan2(mouse_position.y, mouse_position.x) * 180 / PI) + 180

	cannon_degrees = part_rotation(cannon_degrees, required_degrees, CANNON_ROTATION_SPEED)
	$CannonSprite.rotation_degrees = cannon_degrees - 90

func part_rotation(part_degrees, required_degrees, rotation_speed):
	if part_degrees >= 360:
		part_degrees -= 360
	elif part_degrees < 0:
		part_degrees += 360

	var degrees_difference = required_degrees - part_degrees

	if abs(degrees_difference) < rotation_speed:
		part_degrees = required_degrees

	elif degrees_difference > 0:
		if degrees_difference <= 180:
			part_degrees += rotation_speed
		else:
			part_degrees -= rotation_speed

	elif degrees_difference < 0:
		if degrees_difference <= -180:
			part_degrees += rotation_speed
		else:
			part_degrees -= rotation_speed

	return part_degrees

@rpc("any_peer")
func fire(degrees):
	if time_to_next_attack < 0:
		var radians = degrees * PI / 180 - PI
		var bullet = Bullet.instantiate()
		bullet.position = $CannonSprite/CannonPosition.global_position
		bullet.rotation = radians + PI/2
		bullet.vector = Vector2(cos(radians), sin(radians))
		get_parent().add_child(bullet)

		reset_attack_calldown()


func take_damage(damage):
	hp -= damage
	if is_dead():
		die()

func is_dead():
	return hp <= 0


func die():
	queue_free()
	
func reset_attack_calldown():
	time_to_next_attack = attack_cooldown
