extends Node2D
class_name Card

var suit
var value

func _init(_suit, _value):
	suit = _suit
	value = _value

func change_texture():
	$Card.texture = load("res://Assets/Cards/{0}/{1}.png".format([suit, value]))
