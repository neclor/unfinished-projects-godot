extends Node


const SEA = preload("res://sea/sea.tscn")


@onready var sea = $Sea


func _ready():
	Signals.restart.connect(restart)


func restart():
	sea.queue_free()
	sea = SEA.instantiate()
	add_child(sea)
