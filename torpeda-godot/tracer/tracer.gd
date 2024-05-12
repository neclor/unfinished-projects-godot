extends Node2D

var color := Color.GREEN

func _ready():
	modulate = color
	visible = false
	await get_tree().create_timer(1).timeout
	visible = true

func _on_timer_timeout():
	visible = false
	await get_tree().create_timer(1).timeout
	visible = true
