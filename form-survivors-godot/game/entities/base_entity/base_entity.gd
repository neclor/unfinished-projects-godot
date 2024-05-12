class_name Entity
extends CharacterBody2D


@onready var die_particles = $DieParticles
@onready var health_component = $HealthComponent
@onready var collision : Node
@onready var figure : Node


const BORDER_RADIUS = 16.0
const BODY_RADIUS = 14.0
const BORDER_COLOR = Color.BLACK


var speed : int
var move_direction_vector : Vector2 = Vector2.ZERO


var attack_power : int


func _physics_process(_delta):
	move()


func move():
	pass


func move_step():
	velocity = move_direction_vector * speed
	move_and_slide()


func start_dying():
	collision.disabled = true
	figure.visible = false
	die_particles.restart()


func _on_die_particles_finished():
	die()


func die():
	queue_free()


func redraw_hp(hp_ratio : float):
	figure.redraw_hp(BODY_RADIUS * hp_ratio)
