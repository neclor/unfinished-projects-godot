extends Node2D
var player_scene = preload("res://Scenes/Player.tscn")

var players = []

const PORT = 6789

var enet_peer = ENetMultiplayerPeer.new()



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func create_palyer(id):
	var player = player_scene.instantiate()
	player.name = "player_" + str(id)
	add_child(player)
	players[id] = player


func _on_host_pressed():
	$Menu.hide()
	
	enet_peer.create_server(PORT)
	multiplayer.multiplayer_peer = enet_peer
	multiplayer.peer_connected.connect(add_player)
	
	add_player(multiplayer.get_unique_id())


func _on_join_pressed():
	$Menu.hide()

	enet_peer.create_client($Menu/ip.text, PORT) #$Menu/ip.text
	multiplayer.multiplayer_peer = enet_peer



func add_player(peer_id):
	var player = player_scene.instantiate()
	player.name = str(peer_id)
	players.append(player)
	add_child(player)

