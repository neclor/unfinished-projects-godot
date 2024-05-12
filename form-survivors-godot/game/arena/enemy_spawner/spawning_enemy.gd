class_name SpawningEnemy
extends Node2D


const ENEMY = preload("res://game/entities/enemy/enemy.tscn")
const DEFAULT_SPAWN_CIRCLE_RADIUS = 32
const SPAWN_TIME = 1
const SPAWN_CIRCLE_COLOR = Color("#ff000080")

var enemy_level : int
var spawn_circle_radius : float
var elapsed_time := 0.0


func _init(init_enemy_level : int):
	enemy_level = init_enemy_level


func _physics_process(delta):
	elapsed_time += delta

	if elapsed_time >= SPAWN_TIME:
		spawn_enemy()
		queue_free()

	spawn_circle_radius = Tween.interpolate_value(DEFAULT_SPAWN_CIRCLE_RADIUS, -DEFAULT_SPAWN_CIRCLE_RADIUS, elapsed_time, SPAWN_TIME, Tween.TRANS_LINEAR, Tween.EASE_IN)
	queue_redraw()


func _draw():
	draw_circle(Vector2.ZERO, spawn_circle_radius, SPAWN_CIRCLE_COLOR)


func spawn_enemy():
	var new_enemy = ENEMY.instantiate()
	new_enemy.init(enemy_level)
	new_enemy.position = self.position
	get_parent().add_child(new_enemy)
