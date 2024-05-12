extends Node2D

const player_scene = preload("res://Scenes/Player.tscn")
const card_scene = preload("res://Scenes/Card.tscn")
const stack_scene = preload("res://Scenes/Stack.tscn")

const PORT = 6789
var enet_peer = ENetMultiplayerPeer.new()
var players = []

var card_deck = []
var trash = []
var stacks = []

func init():
	card_deck = Deck.shuffle(Deck.create())
	trash = []
	stacks = []

@rpc("any_peer", "call_local")
func start():
	var peer_id = multiplayer.get_unique_id()
	var sender_id = multiplayer.get_remote_sender_id()
	init()
	$StartButton.visible = false
	for i in 4:
		var stack = stack_scene.instantiate()
		#stack.disable_stack()

		#var stack = Stack.new(13)
		stacks.append(stack)
		add_child(stack)

		stack.position = Vector2((stacks.size() - 1) * 200, 400)

	









func join_game(ip_addr):
	enet_peer.create_client(ip_addr, PORT) #$Menu/ip.text
	multiplayer.multiplayer_peer = enet_peer

func host_game():
	$StartButton.visible = true

	enet_peer.create_server(PORT)
	multiplayer.multiplayer_peer = enet_peer
	multiplayer.peer_connected.connect(add_player)
	
	add_player(multiplayer.get_unique_id())

func add_player(peer_id):
	var player = player_scene.instantiate()
	player.init(peer_id, "_name")

	player.name = str(peer_id)

	players.append(player)
	add_child(player)
	
	player.position = Vector2((players.size() - 1) * 200, 0)

	print("player created")


func _on_start_button_pressed():
	start.rpc()

func _on_host_pressed():
	host_game()


func _on_join_pressed():
	join_game("localhost")









