extends Node2D


const TORPEDA = preload("res://torpeda/torpeda.tscn")



@onready var start_torped = $HUD/StartTorped


@onready var ui_conatiner = $HUD/UiConatiner


@onready var my_ship = $MyShip
@onready var enemy_ship = $EnemyShip







func _on_start_torped_pressed():
	var new_torpeda = TORPEDA.instantiate()
	new_torpeda.speed = int($HUD/UiConatiner/TorpedSpeed.text)
	
	new_torpeda.position = my_ship.position
	new_torpeda.rotation = my_ship.rotation
	new_torpeda.turning_radius = int($HUD/UiConatiner/TorpedRadius.text)



	var distance_to_enemy: float = (enemy_ship.position - my_ship.position).length()
	var direction_to_enemy: float = (enemy_ship.position - my_ship.position).angle() - my_ship.rotation + PI / 2
	var enemy_direction: float = enemy_ship.rotation - my_ship.rotation
	var enemy_speed: int = enemy_ship.speed


	var ang = calculate_angle(distance_to_enemy, direction_to_enemy, enemy_direction, enemy_speed)
	new_torpeda.init(distance_to_enemy, direction_to_enemy, enemy_direction, enemy_speed)

	new_torpeda.rotation += direction_to_enemy - ang
	add_child(new_torpeda)







func calculate_angle(distance_to_enemy: float, direction_to_enemy: float, enemy_direction: float, enemy_speed: float):

	var torped_speed = int($HUD/UiConatiner/TorpedSpeed.text)

	var c = PI - direction_to_enemy + enemy_direction
	var x = asin(enemy_speed / torped_speed * sin(c))

	





	print("c " + str(rad_to_deg(PI - direction_to_enemy + enemy_direction)))

	var torped_angle_x_ = asin(enemy_speed / torped_speed * sin(PI - direction_to_enemy + enemy_direction))

	print("x " + str(rad_to_deg(torped_angle_x_)))

	return torped_angle_x_



















func _on_my_ship_rotation_value_changed(value):
	my_ship.rotation_degrees = value


func _on_enemy_ship_rotation_value_changed(value):
	enemy_ship.rotation_degrees = value


func _on_start_simulation_pressed():
	ui_conatiner.visible = false
	start_torped.visible = true

	my_ship.player = true
	my_ship.speed = int($HUD/UiConatiner/MyShipSpeed.text)
	my_ship.speed_after_5_sec = int($HUD/UiConatiner/MyShipSpeed.text)

	enemy_ship.speed = int($HUD/UiConatiner/EnemyShipSpeed.text)
	enemy_ship.speed_after_5_sec = int($HUD/UiConatiner/EnemyShipSpeed5Sec.text)

	my_ship.start()
	enemy_ship.start()


func _on_enemy_ship_dist_text_changed():
	enemy_ship.position.x = int($HUD/UiConatiner/EnemyShipDist.text)




func _on_restart_pressed():
	Signals.restart.emit()
