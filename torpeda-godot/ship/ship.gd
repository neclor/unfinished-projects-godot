extends CharacterBody2D


const TRACER = preload("res://tracer/tracer.tscn")


@export var speed := 10
@export var speed_after_5_sec := 10

@onready var timer = $Timer
@onready var tracer_timer = $TracerTimer

var player = false

func start():
	velocity = Vector2.UP.rotated(rotation) * speed
	timer.start()
	tracer_timer.start()


func _physics_process(delta):
	move_and_slide()
	turn(delta)





func turn(delta):
	if !player:
		return

	var input = Input.get_axis("left", "right")
	rotation = rotation + input * delta
	velocity = velocity.rotated(input * delta)





func _on_timer_timeout():
	speed = speed_after_5_sec
	velocity = Vector2.UP.rotated(rotation) * speed


func _on_tracer_timer_timeout():
	var new_tracer = TRACER.instantiate()
	new_tracer.color = modulate
	new_tracer.position = position
	get_parent().add_child(new_tracer)
