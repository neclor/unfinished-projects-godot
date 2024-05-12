extends Node2D


@onready var attack_cooldown_timer = $AttackCooldownTimer

@onready var melee_attack_box = $MeleeAttackBox


#region Attack var
var target_group := "entities"

var attack_cooldown := 1
var attack_ready := false

var attack_damage := 100
#endregion


#region Attack box functions
func attack_box_enable():
	melee_attack_box.monitoring = true
	melee_attack_box.monitorable = true

func attack_box_disable():
	melee_attack_box.monitoring = false
	melee_attack_box.monitorable = false
#endregion


#region Attack functions
func try_attack(attack_direction_vector: Vector2):
	if !attack_ready:
		return false

	melee_attack(attack_direction_vector)

func melee_attack(attack_direction_vector: Vector2):
	melee_attack_box.rotation = atan2(attack_direction_vector.y, attack_direction_vector.x)
	attack_box_enable()
	attack_box_disable()
	start_attack_cooldown()

func start_attack_cooldown():
	attack_ready = false
	attack_cooldown_timer.wait_time = attack_cooldown
	attack_cooldown_timer.start()

func _on_attack_cooldown_timer_timeout():
	attack_ready = true

func _on_melee_attack_box_body_entered(body):
	if body.is_in_group(target_group):
		body.take_damage(Damage.new(attack_damage))
#endregion
