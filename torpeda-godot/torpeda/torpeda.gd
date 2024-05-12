extends CharacterBody2D


const TRACER = preload("res://tracer/tracer.tscn")


var turning_radius := 50
var speed := 20

@onready var turning_speed: float = speed / turning_radius



var required_angle: float = 0 




func init(distance_to_enemy: float, direction_to_enemy: float, enemy_direction: float, enemy_speed: int):
	pass



func _physics_process(delta):
	velocity = Vector2.UP.rotated(rotation) * speed
	velocity = velocity.rotated(clamp(required_angle, -turning_speed, turning_speed))
	move_and_slide()



























func _on_area_2d_body_entered(body):
	queue_free()
	body.queue_free()



func _on_tracer_timer_timeout():
	var new_tracer = TRACER.instantiate()
	new_tracer.position = position
	get_parent().add_child(new_tracer)


func _on_live_timer_timeout():
	queue_free()
