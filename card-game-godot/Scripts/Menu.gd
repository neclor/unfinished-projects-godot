extends Node2D

var main_scene = preload("res://Scenes/Main.tscn").instantiate()

func _on_join_button_pressed():
	get_tree().root.add_child(main_scene)
	get_tree().root.remove_child(self)
	main_scene.join_game("localhost", $Name.text) #Ip.text

func _on_host_button_pressed():
	get_tree().root.add_child(main_scene)
	get_tree().root.remove_child(self)
	main_scene.host_game($Name.text)
