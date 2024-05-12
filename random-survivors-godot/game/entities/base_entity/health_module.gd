extends Node2D


@onready var hp_regen_cooldown_timer = $HpRegenCooldownTimer
@onready var shield_regen_cooldown_timer = $ShieldRegenCooldownTimer

@onready var hitbox = $Hitbox


#region Health var
var max_hp := 100
var hp := 100
var hp_regen_available := true
var hp_regen_per_sec := 10
var hp_regen_cooldown := 5
#endregion


#region Shield var
var max_shield := 0
var shield := 0
var shield_regen_available := true
var shield_regen_per_sec := 10
var shield_regen_cooldown := 5
#endregion


#region Hitbox functions
func hitbox_enable():
	hitbox.monitorable = true
	hitbox.monitoring = true

func hitbox_disable():
	hitbox.monitorable = false
	hitbox.monitoring = false
#endregion


#region Damage functions
func take_damage(input_damage: Damage):
	if input_damage.damage_power == 0:
		return

	start_shield_cooldown()

	if shield >= input_damage.damage_power:
		shield -= input_damage.damage_power
	else:
		hp -= input_damage.damage_power - shield
		shield = 0
		start_hp_cooldown()

	if hp <= 0:
		die()

func die():
	get_parent().queue_free()
#endregion


#region Regen functions
func regen():
	hp_regen()
	shield_regen()
#endregion


#region Health functions
func heal_hp(heal: int):
	hp += heal
	if hp > max_hp:
		hp = max_hp

func hp_regen():
	if hp < max_hp and hp_regen_available:
		heal_hp(hp_regen_per_sec)

func start_hp_cooldown():
	hp_regen_available = false
	hp_regen_cooldown_timer.wait_time = hp_regen_cooldown
	hp_regen_cooldown_timer.start()

func _on_hp_regen_cooldown_timer_timeout():
	hp_regen_available = true
#endregion


#region Shield functions
func heal_shield(heal: int):
	shield += heal
	if shield > max_shield:
		shield = max_shield

func shield_regen():
	if shield < max_shield and shield_regen_available:
		heal_shield(shield_regen_per_sec)

func start_shield_cooldown():
	shield_regen_available = false
	shield_regen_cooldown_timer.wait_time = shield_regen_cooldown
	shield_regen_cooldown_timer.start()

func _on_shield_regen_cooldown_timer_timeout():
	shield_regen_available = true
#endregion
