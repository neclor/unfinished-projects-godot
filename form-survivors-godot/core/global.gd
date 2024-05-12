extends Node

var rng := RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	seed(rng.seed)
