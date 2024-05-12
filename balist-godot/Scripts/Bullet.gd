extends CharacterBody2D

const SPEED = 3
const damage = 50
var vector

@rpc("any_peer")
func _physics_process(delta):
	translate(vector * SPEED)


func _on_damage_area_body_entered(body):
	if "hp" in body and not body.is_dead():
		body.take_damage(damage)
	queue_free()
