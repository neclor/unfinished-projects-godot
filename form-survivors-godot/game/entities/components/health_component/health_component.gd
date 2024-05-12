extends Node2D


@onready var parent = get_parent()
@onready var hp_regen_cooldown_timer = $HpRegenCooldownTimer


const DEFAULT_HP_REGEN_COOLDOWN = 5


var max_hp : int
var hp : int
var hp_regen_per_sec : int
var hp_regen_cooldown : int
var hp_regen_ready := true


func set_values(new_max_hp : int, new_hp_regen_per_sec : int, new_hp_regen_cooldown : int = DEFAULT_HP_REGEN_COOLDOWN):
	max_hp = new_max_hp
	hp = max_hp
	hp_regen_per_sec = new_hp_regen_per_sec
	hp_regen_cooldown = new_hp_regen_cooldown


func redraw_hp():
	parent.redraw_hp(1.0 * hp / max_hp)


func take_damage(input_damage : int):
	if input_damage == 0:
		return
	hp -= input_damage
	if hp <= 0:
		die()
		return
	start_hp_cooldown()
	redraw_hp()


func die():
	parent.start_dying()


func _on_hp_regen_timer_timeout():
	regen_hp()


func heal_hp(input_heal: int):
	hp += input_heal
	if hp > max_hp:
		hp = max_hp
	redraw_hp()


func regen_hp():
	if hp < max_hp and hp_regen_ready:
		heal_hp(hp_regen_per_sec)


func start_hp_cooldown():
	hp_regen_ready = false
	hp_regen_cooldown_timer.wait_time = hp_regen_cooldown
	hp_regen_cooldown_timer.start()


func _on_hp_regen_cooldown_timer_timeout():
	hp_regen_ready = true
